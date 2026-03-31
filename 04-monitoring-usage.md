# Monitoring Your Usage on Tillicum

When you first log in to Tillicum, you land on a shared login node (`tillicum-login01`). Login nodes are for light activity like transferring data, setting up environments, and preparing job scripts.

🛑 **Do not run compute-heavy work here**. All compute work must be run through the job scheduler.

Tillicum uses Slurm, a workload manager that allocates compute resources on the cluster. Slurm coordinates who gets GPUs and CPUs, when jobs run, and where they run.

## Tillicum QoS

Tillicum jobs are submitted under a "Quality-of-Service" or **QOS**, which defines limits like wall time, GPU count, and concurrent jobs.
- All Tillicum compute nodes have **8 GPUs (141 GB each)** and these are provisioned with 200 GB system RAM per GPU and 8 CPUs per GPU.
- You must request at least 1 GPU. *CPU-only* jobs are not allowed.

| QOS             | Max Time | Max GPUs per Job | Concurrent GPU Limit      | Notes                       |
| --------------- | -------- | ---------------- | ------------------------- | --------------------------- |
| **normal**      | 24 hours | 16               | 96 GPUs                   | Standard production work    |
| **debug**       | 1 hour   | 1                | 1 job                     | Quick testing and setup     |
| **interactive** | 8 hours  | 2                | 2 jobs                    | Real-time work or debugging |
| **long**        | 7 days   | 16               | QoS cannot exceed 96 GPUs | Long jobs                   |
| **wide**        | 24 hours | NA               | QoS cannot exceed 96 GPUs | Distributed jobs            |

> 💡 **TIP:** **By default, all your jobs submitted via Open OnDemand are interactive jobs in debug QOS for the in-class hands-on sessions.**

### Monitor Your Job

Check your job’s status:

```bash
squeue -u $USER
```

This command lists all your active or queued jobs.
You’ll see columns such as:
| Column               | Meaning |
| -------------------- | - |
| **JOBID**            | A unique number assigned to your job. Use this to reference it in other commands. |
| **PARTITION**        | The resource pool or QOS (e.g., `normal`, `interactive`). |
| **NAME**             | The job name you set in your script (`--job-name`). |
| **ST**               | The job’s status — common values include: <br> `PD` (Pending), `R` (Running), `CG` (Completing), `CD` (Completed). |
| **TIME**             | How long the job has been running. |
| **NODELIST(REASON)** | The node(s) your job is on, or if pending, the reason it’s waiting (like “Resources” or “Priority”). |

## Pay-as-you-go by the GPU Hour

Tillicum provides usage-based billing:

**Rate:** $0.90 per GPU-hour

**Formula:** ***GPU Hours*** = Elapsed Time x ***N*** GPUs

## Monitoring Your Usage: `hyakusage`

Tillicum provides a convenient utility called `hyakusage` to help users track their usage and costs. `hyakusage` summarizes resource usage and associated costs across users, accounts, and QOS levels.

> ⚠️ **WARNING:** Users are responsible for monitoring their own usage.

### Budget Enforcement

Tillicum supports budget settings at both the **account** and **user** levels. 

### Default

Running `hyakusage` with no arguments prints a usage report for the **current billing cycle** for the **current user**, grouped by **account** and **QOS**. Additionally, a budget usage summary will also be included if the user- or account-level budget is defined.

```
hyakusage
```

**Key features:**
- Displays usage for all accounts you have access to.
- Shows total GPU-hours and costs per account for current billing cycle at the top of each account.
- Shows active credits (e.g., remaining demo credits) with corresponding expiration dates.
- Integrates user- and account-level budgets (if set) to show progress toward limits.

### Options

The `hyakusage` program has a rich set of command line arguments for more complex queries.

```js
$ hyakusage --help
Print GPU hour usage and costs on Tillicum.

Usage: hyakusage [options]

Example: hyakusage -u all
  Show usage for all users in your accessible accounts in current billing cycle.

Optional arguments:
  -u, -user      Comma-separated list of users or "all" for all users in your accessible accounts (default: current user)
  -s, -start     Start date YYYY-MM-DD (default: start of current billing cycle)
  -e, -end       End date YYYY-MM-DD inclusive (default: today)
  -a, -account   Comma-separated list of accounts  or "all" for all accessible accounts (default: all)
  -q, -qos       Comma-separated list of QOS  or "all" for all QOS in your accessible accounts (default: all)
  -h, -help      Show this help message and exit

Notes:
  * Billing cycle starts on the 26th of each month.
  * Usage is counted by job END date.
  * Costs are rounded to nearest cent.
  * You can only see accounts you have access to.
```

### Examples

```js
# To audit all users' resource usage from your group
hyakusage -u all

# To view resource usage for a given time period
hyakusage -s 2026-03-31 -e 2026-06-04

# To filter by specific account and QOS
hyakusage -a account -q debug
```