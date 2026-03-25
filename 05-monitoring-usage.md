# Scheduling Jobs on Tillicum

When you first log in to Tillicum, you land on a shared login node (`tillicum-login01`). Login nodes are for light activity like transferring data, setting up environments, and preparing job scripts.

🛑 **Do not run compute-heavy work here**. All compute work must be run through the job scheduler.

Tillicum uses Slurm, a workload manager that allocates compute resources on the cluster. Slurm coordinates who gets GPUs and CPUs, when jobs run, and where they run.

## Understanding Job Types

There are two main ways to run work on Tillicum:

| Job Type            | Command  | Best For                     | Runs On                                         |
| ------------------- | -------- | ---------------------------- | ----------------------------------------------- |
| **Interactive Job** | `salloc` | Exploratory or hands-on work | A compute node you connect to directly          |
| **Batch Job**       | `sbatch` | Long or unattended jobs      | Runs automatically when resources are available |


Tillicum jobs are submitted under a "Quality-of-Service" or **QOS**, which defines limits like wall time, GPU count, and concurrent jobs. All Tillicum compute nodes have 8 GPUs (141 GB each) and these are provisioned with 200 GB system RAM per GPU and 8 CPUs per GPU.

| QOS             | Max Time   | Max GPUs per Job | Concurrent GPU Limit | Notes                           |
| --------------- | ---------- | ---------------- | -------------------- | ------------------------------- |
| **normal**      | 24 hours   | 16               | 48 GPUs              | Standard production work        |
| **debug**       | 30 minutes | 1                | 1 job                | Low-cost testing and setup      |
| **interactive** | 8 hours    | 2                | 2 jobs               | For real-time work or debugging |
| **long**        | by request | details TBA       | details TBA           | For special long jobs           |
| **wide**        | by request | details TBA       | details TBA           | For distributed jobs            |

**Tip**: You must request at least 1 GPU. CPU-only jobs are not allowed.

## Job Cost Estimates

Tillicum provides usage-based billing:

**Rate:** $0.90 per GPU-hour

**Formula:** GPU Hours = GPUs × Time Used

When you submit a job, Slurm estimates the cost:

```bash
salloc:     GPUs: 1
salloc:     CPUs: 1
salloc:     MEM: 200000 MB
salloc:     TIME: 1.00 hrs
salloc: *** COST: $0.90 (Est.)
```

Billing is handled monthly through UW-IT’s ITBill system.

### Monitor Your Job

Check your job’s status:

```bash
squeue -u $USER
```

This command lists all your active or queued jobs.
You’ll see columns such as:
| Column               | Meaning                                                                                                            |
| -------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **JOBID**            | A unique number assigned to your job. Use this to reference it in other commands.                                  |
| **PARTITION**        | The resource pool or QOS (e.g., `normal`, `interactive`).                                                          |
| **NAME**             | The job name you set in your script (`--job-name`).                                                                |
| **ST**               | The job’s status — common values include: <br> `PD` (Pending), `R` (Running), `CG` (Completing), `CD` (Completed). |
| **TIME**             | How long the job has been running.                                                                                 |
| **NODELIST(REASON)** | The node(s) your job is on, or if pending, the reason it’s waiting (like “Resources” or “Priority”).               |
