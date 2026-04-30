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
