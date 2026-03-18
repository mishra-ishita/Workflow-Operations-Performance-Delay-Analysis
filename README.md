# Workflow Operations Performance & Delay Analysis

> **A data-driven investigation into why 95% of operational tasks miss their deadlines** — and why the answer isn't what you'd expect.

## 🧩 The Problem

The workflow system was processing 2,500 tasks. Nearly all of them were late.

A **94.92% delay rate** across five departments, five process types, and ten employees sounds like an organizational crisis. But the real question — the one this project sets out to answer — is more nuanced:

**Is this a people problem, a volume problem, or a process design problem?**

The data gives a clear answer. Task inflow is stable day-to-day (no demand spikes). Costs are virtually identical whether a task is delayed or not (₹277.9 vs ₹278.8). All five departments delay at nearly the same rate (93–96%). This rules out overload, budget waste, and department-specific failure.

The culprit is the **workflow process itself** — specifically, approval bottlenecks, validation inefficiencies, and workload imbalance among employees. Fixing the system, not the people, is where the leverage lies.

## 🎯 Objectives

- Measure overall task performance: delay rate, completion time, cost per task
- Identify which processes and task types drive the most delays
- Analyse department-level workload distribution and operational costs
- Examine the relationship between employee workload and delay rate
- Detect tasks with significant time overruns (>120 minutes past estimate)
- Deliver prioritised, data-backed recommendations to reduce delays

## 🗂️ Dataset

Operational task records from an enterprise workflow system (2024):

| Field | Description |
|-------|-------------|
| `Task_ID` | Unique task identifier |
| `Process_Name` | Invoice Approval / Purchase Order / HR Onboarding / IT Support Ticket / Customer Complaint |
| `Task_Type` | Approval / Review / Escalation / Validation / Data Entry |
| `Department` | IT / Finance / HR / Operations / Customer Service |
| `Assigned_Employee_ID` | Employee handling the task |
| `Estimated_Time_Minutes` | Expected completion time |
| `Actual_Time_Minutes` | Actual time taken |
| `Delay_Flag` | 1 = delayed, 0 = on time |
| `Cost` | Cost associated with the task |
| `Task_Date` | Date the task was initiated |
| `Approval_Level` | Level 1 / Level 2 / Level 3 |
| `Priority_Level` | Critical / High / Medium / Low |

## 🛠️ Tools & Stack

| Tool | Role |
|------|------|
| **SQL** | Data cleaning, aggregation, delay calculations, employee & process analysis |
| **Excel / Power BI** | Interactive dashboard, KPI cards, visual storytelling |

## 🔍 SQL Analysis — 13 Queries, Full Coverage

The analysis was built entirely in SQL across 13 structured queries:

| # | Query | Key Output |
|---|-------|------------|
| 1 | Overall workflow metrics | 94.92% delay rate · 181 min avg completion · ₹278 avg cost |
| 2 | Process-wise delay rate | Invoice Approval highest (96.25%) |
| 3 | Department delay rate | IT highest (95.37%) — but all within 1.5% of each other |
| 4 | Employee workload vs delay | 250+ task employees hit ~96% delay rate |
| 5 | Top time overrun tasks | Multiple tasks exceed estimate by exactly 120 min |
| 6 | Task type performance | Validation slowest (96.15% delay, 185 min avg) |
| 7 | Approval level bottlenecks | Level 1 worst (96%) — single-reviewer bottleneck confirmed |
| 8 | Cost impact of delays | Delayed vs non-delayed cost difference: < ₹1 — time problem, not budget |
| 9 | Department operational cost | Operations highest (₹1,41,783) — but distribution is nearly equal |
| 10 | Daily task volume | Stable inflow — delays are NOT caused by demand spikes |
| 11 | Employees with 100% delay rate | 10+ employees flagged including EMP_35, EMP_16, EMP_55 |
| 12 | Department cost contribution | Balanced 19–20% each — no single department over-consuming |
| 13 | Significant time overrun detection | Approval, Escalation, Validation tasks overrun most consistently |

## 📊 Dashboard

A single-page interactive dashboard built in Power BI / Excel covering:

- **KPI Cards**: Total Tasks (2,500) · Total Delays (2,373) · Delay Rate (95%) · Avg Completion Time (180.86 min) · Avg Cost Per Task (₹277.98)
- **Delay Rate by Process**: Horizontal bar chart — Invoice Approval leads at 96.3%
- **Department Cost Distribution**: Column chart showing near-equal spend across all 5 departments
- **Average Completion Time by Task Type**: Validation (185.4 min) vs Approval (178.5 min) gap visualised
- **Employee Workload vs Delay Rate**: Line chart showing workload-delay correlation
- **Task Status Distribution**: Donut chart — even split across Approval, Review, Escalation, Validation, Data Entry

**Filters**: Department · Task Type · Priority Level

## 🔎 Key Findings

### The headline finding
> Delays are systemic and process-driven — not caused by volume spikes, department failures, or budget overruns.

| Finding | What it means |
|---------|---------------|
| **95% delay rate, but cost difference < ₹1** | This is a time/capacity crisis, not a budget crisis |
| **All 5 departments within 1.5% of each other** | No single department is the problem — the process design is |
| **Stable daily task inflow** | Demand is not the cause — workflow design is |
| **Level 1 approvals: 96% delay rate** | First approval stage is the single biggest bottleneck |
| **Validation tasks: 185 min avg vs Approval: 178 min** | Manual verification steps are the slowest task type |
| **10+ employees at 100% delay rate** | Workload imbalance is concentrated — not spread evenly |
| **Time overruns consistently capped at 120 min** | Suggests a systemic SLA breach pattern, not random delays |

## 📌 Recommendations

**Priority 1 — Break the Level 1 approval bottleneck (highest ROI)**
Level 1 approvals have a 96% delay rate — the worst of any approval tier. Introduce parallel routing so tasks don't queue behind a single reviewer. This alone affects 826 tasks in the dataset.

**Priority 2 — Automate or streamline validation steps**
Validation tasks take 185+ minutes on average and delay at 96.15%. Many of these are likely manual checks that could be rule-based or partially automated — especially in Invoice Approval and HR Onboarding workflows.

**Priority 3 — Rebalance employee workload**
Employees handling 250+ tasks show ~96% delay rates. Employees with 100% delay rates (EMP_35, EMP_16, EMP_55 and others) are likely overloaded or mis-assigned. Redistribute tasks to lower-load employees before adding headcount.

**Priority 4 — Revise SLA benchmarks**
The consistent 120-minute overrun pattern across unrelated processes suggests estimated times may be systematically underestimated. Recalibrate SLAs based on actual completion data to get a realistic baseline — without this, the 95% delay rate may be partly a measurement problem.

**Priority 5 — Build real-time delay alerting**
Since delays are predictable (approval + validation tasks in IT and Finance departments, assigned to high-workload employees), a simple rule-based alert system could flag at-risk tasks before they breach SLA rather than after.

## 📁 Project Files

```
📦 WorkflowDelayAnalysis/
├── 📄 workflow_data.csv                           — Raw task-level dataset
├── 📄 SQLQueries_WorkflowAnalysis.pdf             — All 13 SQL queries with outputs & insights
├── 📊 WorkflowDashboard.pbix / .xlsx             — Interactive Power BI / Excel dashboard
└── 📑 PPT_WorkflowOperationsPerformance.pptx     — Presentation with findings & recommendations
```

## 💡 What This Project Demonstrates

- **Structured SQL thinking** — 13 queries covering metrics, segmentation, correlation, ranking, outlier detection, and time-series analysis
- **Analytical scepticism** — questioning what a 95% delay rate actually means before accepting it at face value
- **Root cause reasoning** — ruling out volume, cost, and department-level causes to isolate process design as the core issue
- **Operational analytics** — applying data analysis to internal business processes, not just customer-facing metrics
- **Dashboard design** — KPI-driven single-page Power BI dashboard with cross-filtering by department, task type, and priority
