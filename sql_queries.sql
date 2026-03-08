use workflow;
-- 1. overall workflow performance metrics
select count(task_id) as total_tasks, sum(delay_flag) as delayed_tasks, round(sum(delay_flag) * 100.0 / count(task_id),2) as delay_rate,
round(avg(actual_time_minutes),2) as avg_completion_time, round(avg(cost_per_task),2) as avg_cost_per_task from workflow_operations;

-- 2.processes with highest delays
select process_name, count(task_id) as total_tasks, sum(delay_flag) as delayed_tasks, round(sum(delay_flag) * 100.0 / count(task_id),2) as delay_rate
from workflow_operations group by process_name order by delay_rate desc;

-- 3.departments causing operational inefficiencies
select department, count(task_id) as total_tasks, sum(delay_flag) as delayed_tasks, round(sum(delay_flag) * 100.0 / count(task_id),2) as delay_rate
from workflow_operations group by department order by delay_rate desc;

-- 4.employee workload vs delay rate
select employee_workload, count(task_id) as tasks, round(avg(delay_flag) * 100,2) as delay_rate
from workflow_operations group by employee_workload order by employee_workload;

-- 5.tasks with largest time overrun
select task_id, process_name, task_type, actual_time_minutes - estimated_time_minutes as time_overrun
from workflow_operations order by time_overrun desc limit 10;

-- 6.task type performance analysis
select task_type, count(task_id) as total_tasks, round(avg(actual_time_minutes),2) as avg_completion_time, round(avg(delay_flag) * 100,2) as delay_rate
from workflow_operations group by task_type order by avg_completion_time desc;

-- 7.approval level bottlenecks
select approval_level, count(task_id) as total_tasks, round(avg(actual_time_minutes),2) as avg_completion_time,
round(avg(delay_flag) * 100,2) as delay_rate from workflow_operations
group by approval_level order by delay_rate desc;

-- 8.cost impact of delays
select delay_flag, round(avg(cost_per_task),2) as avg_cost
from workflow_operations group by delay_flag;

-- 9.department with highest operational cost
select department, round(sum(cost_per_task),2) as total_cost from workflow_operations group by department order by total_cost desc;

-- 10.daily task volume 
select date(task_start_time) as task_date, count(task_id) as tasks_started
from workflow_operations group by task_date order by task_date;

-- 11.top 3 employees with highest delay rate
with employee_delay as (select assigned_employee_id, count(task_id) as total_tasks,
           sum(delay_flag) as delayed_tasks, round(sum(delay_flag) * 100.0 / count(task_id),2) as delay_rate
           from workflow_operations group by assigned_employee_id)
select * from (select *, rank() over (order by delay_rate desc) as rank_delay
    from employee_delay) t
where rank_delay <= 3;

-- 12.department contribution to total operational cost
select department, round(sum(cost_per_task),2) as department_cost, round(sum(cost_per_task) * 100.0 / sum(sum(cost_per_task)) over (),2) as cost_percentage
from workflow_operations group by department order by department_cost desc;

-- 13.detect tasks with significant time overrun
with task_overrun as (select task_id, process_name, task_type, estimated_time_minutes, actual_time_minutes,
           (actual_time_minutes - estimated_time_minutes) as overrun_minutes from workflow_operations
)select * from task_overrun
where overrun_minutes > (select avg(overrun_minutes)
    from task_overrun) order by overrun_minutes desc;