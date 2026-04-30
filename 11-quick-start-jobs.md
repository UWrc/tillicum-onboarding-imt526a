# Quick Start: Running Your First Jobs

This section you'll use your python script (converted from the Notebook) to get practice with two common workflows with Slurm:

1. Running code interactively (for testing)
2. Running code as a batch job (for longer workloads)

## Step 1: Start an Interactive Job

> ⚠️ **WARNING: All compute work must be done on compute nodes.**

Request an interactive session with 1 GPU for 30 minutes:
```bash
salloc -A groupX --qos=interactive --gpus=1 --time=00:30:00
```

Once resources are allocated, confirm you’re on a compute node:

```bash
hostname
```

Then verify your GPU is visible:

```bash
nvidia-smi
```

## Step 2: Load the Course Environment

Load the conda module and activate the class environment:
```bash
module purge
module load conda
conda activate /gpfs/projects/imt526a/conda/envs/imt526a-jupyter-torch
```

Confirm Python:
```bash
which python
python --version
```

## Step 3: Run a Python Script

Run the example script which we previously converted from Notebook format:
```bash
python python_demo.py
```
This verifies your environment is working correctly on a compute node.

When finished:
```bash
exit
```

## Step 4: Run a Batch Job

Now let’s run the same idea as a batch job.

```bash
nano job.slurm
```
> ***IMPORTANT*** - Edit the `--account=` line to match your assigned Slurm group account. 

```bash
#!/bin/bash

#SBATCH --job-name=python_demo
#SBATCH --account=groupX #EDIT THIS LINE TO MATCH YOUR GROUP
#SBATCH --qos=normal
#SBATCH --gpus=1
#SBATCH --time=00:05:00
#SBATCH --output=slurm-%j.out

module purge
module load conda
conda activate /gpfs/projects/imt526a/conda/envs/imt526a-jupyter-torch

python python_demo.py
```
When you are finished editing `job.slurm`, exit `nano` with by holding the Control button and pushing the C button (Ctrl + C). 

Submit the job:
```bash
sbatch job.slurm
```

Check status:
```bash
squeue -u $USER
```

After completion, view output using the Job ID assigned to your job:
```bash
cat slurm-<job_id>.out
```

> #### Monitoring Your Jobs
> As you work on your project, monitor your jobs and usage:
>
> ```bash
> squeue -u $USER
> watch -n 10 squeue -u $USER
> ```
> See more details in: 👉 [**<ins>04-monitoring-usage.md</ins>**](./04-monitoring-usage.md)

## Tips
* Always test your code interactively before submitting a batch job
    * Test your code in Notebook mode
    * Test your code with an interactive Slurm job, at least long enough to know it will get to the first substantial step without errors. 
* Use short runtimes (e.g., 5–10 minutes) when testing
* Save outputs (models, results, logs) to your group project directory
    * Save JobIDs and output logs for debugging

## Advanced Topics (Optional)

If your project requires more advanced workflows, you may explore:

* Automating workflows with Bash scripts
* Running parameter sweeps with Slurm job arrays

> 💡 **Tip:** If you need to test multiple model parameters (e.g., learning rates), this can be done efficiently using Slurm job arrays.

👉 [**<ins>See our Tillicum Slurm Tutorial</ins>**](https://github.com/UWrc/tillicum-slurm.git)

> ⚠️ ***Be mindful of resource usage and cost when running multiple jobs in parallel.***

