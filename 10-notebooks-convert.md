## Typical Workflow

For your group project, a common workflow may look like:

1. Develop and test code in Jupyter or an interactive job  
2. Save your code as a Python script 
3. Write a Slurm job script  
4. Submit with `sbatch`  
5. Check results in output files  

You will repeat this process as you iterate on your project. Converting from your interactive workflow to using Slurm will allow you to scale be more efficient with your time and your job runtimes on Tillicum. 

## Running Jupyter Notebooks with Slurm

Many of you will develop your work in Jupyter notebooks. As a first step toward scaling your project with Slurm, you will convert your notebook into a Python script.

---

### Step 1: Make Sure Your Notebook Runs Cleanly

Before converting your notebook:

- Restart the kernel
- Always test your code interactively before submitting a batch job
    - Test run all cells from top to bottom (execute the cell long enough to know it will likely be a successful run)

> ⚠️ **Important:** Slurm will execute your script exactly once, with no manual intervention. A successfully run notebook/script runs start to finish without errors.   

Common issues to check:
- Missing imports
- Cells that depend on variables from earlier interactive runs
- Hardcoded or incorrect file paths

### Step 2: Convert the Notebook to a Python Script

From the terminal on Tillicum, navigate to your notebook directory and run:

```bash
jupyter nbconvert --to script example.ipynb
```

This will create a Python script in the same directory:

```bash
example.py
```

### Step 3: Review the Script

Open the generated `.py` file and confirm:

* All necessary code is included
* There are no notebook-specific commands (e.g., interactive plotting)
* Input and output paths are correct

In the next section, we'll use this script to practice submitting Python jobs to Slurm. 

