# Scheduling Jobs on Tillicum

As you work on your group projects, you will begin running longer and more compute-intensive workloads. Instead of running everything interactively in Jupyter, you may decide to use **Slurm** to schedule and run jobs on Tillicum’s compute nodes.

Slurm (Simple Linux Utility for Resource Management) is the system that:
- Allocates GPUs, CPUs, and memory
- Schedules when your jobs run
- Ensures fair sharing across all users

Using Slurm allows you to:
- Run longer jobs without staying connected  
- Use GPUs efficiently  
- Run multiple experiments for your project  

> 💡 **Important:** For this course, you must submit jobs using your **group account** (e.g., `group1`, `group2`, ...). This ensures project usage is tracked correctly.

## Understanding Job Types

There are two main ways to run work on Tillicum:

| Job Type            | Command  | Best For                     | Runs On                                         |
| ------------------- | -------- | ---------------------------- | ----------------------------------------------- |
| **Interactive Job** | `salloc` | Exploratory or hands-on work | A compute node you connect to directly          |
| **Batch Job**       | `sbatch` | Long or unattended jobs      | Scheduled automatically when resources are available |

Most students will:
- Use **interactive jobs (`salloc`)** for testing and debugging  
- Use **batch jobs (`sbatch`)** for running project workloads  

## Quality of Service (QOS)

Each Tillicum job is submitted under a "Quality-of-Service" or **QOS**, which defines limits such as wall time, GPU count, and concurrent jobs. 

All Tillicum compute nodes have 8 NVIDIA H200 GPUs (141 GB each) and are provisioned with ~200 GB system RAM per GPU and 8 CPUs per GPU.

| QOS             | Max Time   | Max GPUs per Job | Concurrent GPU Limit | Notes                                 |
| --------------- | ---------- | ---------------- | -------------------- | ------------------------------------- |
| **normal**      | 24 hours   | 16               | 48 GPUs              | Default QOS. Standard production work |
| **debug**       | 1 hour     | 1                | 1 job                | Quick testing and setup               |
| **interactive** | 8 hours    | 2                | 2 jobs               | Real-time work or debugging           |

> 💡 **NOTE:** All jobs must request at least 1 GPU.

For this course, you will most commonly use:

- **debug** → quick tests (recommended when setting things up)
- **interactive** → short exploratory sessions
- **normal** → running your actual project workloads

## Job Cost Estimates

For this course, tracking usage per group helps us understand the cost of different project approaches.

When you submit a job, Slurm displays an estimated cost:

```bash
salloc:     GPUs: 1
salloc:     CPUs: 1
salloc:     MEM: 200 GB
salloc:     TIME: 1.00 hrs
salloc: *** COST: $0.90 (Est.)
```

The estimated cost is based on the full requested runtime. This will help you understand the maximum charge for each job.

## Common Slurm Arguments

The following arguments are commonly used and recommended for any job submission:

| Arguments | Command Flags | Notes |
| :- | :- | :- |
| Account | `-A`, `--account` | Specifies which project or lab account to charge. Default: your available account. 💡 **Important for this course:** Always include `--account=<groupX>` in your jobs using the group you were assigned to.|
| QOS | `-q`, `--qos` | Quality of service (QOS). Default: normal.|
| Nodes | `-N`, `--nodes` | Number of compute nodes to request. Most jobs use 1. Multi-node jobs are possible if supported by your code. |
| GPUs | `-G`, `--gpus` | Number of GPUs to request (**min: -G 1**). Note that not all codes can make use of multiple GPUs; scaling is not always linear with more GPUs. |
| Memory | `--mem` | Memory per node (**max: --mem=200G per GPU**). This is in the format `size[units]`. Units may be `M`, `G`, or `T` for megabyte, gigabyte, and terabyte. Default: Megabyte. |
| Time | `-t`, `--time` | Maximum runtime. Formats include `HH:MM:SS`, `D-HH`, and `minutes`. |

For more options, see the [salloc](https://slurm.schedmd.com/salloc.html) and [sbatch](https://slurm.schedmd.com/sbatch.html) manual.

Next, we'll discuss a typical wrokflow and practice some commands. 