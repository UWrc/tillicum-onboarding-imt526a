<!-- omit in toc -->
# Setup Required for IMT 526 A

**Overview**

- [1. Create Your Working Directory](#1-create-your-working-directory)
- [2. Prepare Working Directory Visible in Jupyter via Open OnDemand](#2-prepare-working-directory-visible-in-jupyter-via-open-ondemand)
- [3. Customize Conda Environment and Package Locations](#3-customize-conda-environment-and-package-locations)
- [4. Launch JupyterLab from Open OnDemand](#4-launch-jupyterlab-from-open-ondemand)
- [5. Cleanup](#5-cleanup)

## 1. Create Your Working Directory

Let's start with creating your own directory in `/gpfs/projects/imt526a`:

```bash
mkdir -p /gpfs/projects/imt526a/$USER
cd /gpfs/projects/imt526a/$USER
pwd
```

> 📝 **NOTE:** The `$USER` variable automatically expands to your username.

## 2. Prepare Working Directory Visible in Jupyter via Open OnDemand

By default, Jupyter sessions on Open OnDemand (OOD) start in your Home directory. To access files outside your Home directory, we need to create a symbolic link in your Home directory which links to the actual working directory in `/gpfs/projects/imt526a`.

```bash
ln -s /gpfs/projects/imt526a ~/imt526a
```

## 3. Customize Conda Environment and Package Locations

To avoid Home disk quota exceeded, open the file `$HOME/.condarc`:

```bash
nano ~/.condarc
```

and edit it to include following lines:

```yaml
envs_dirs:
  - /gpfs/projects/imt526a/conda/envs
pkgs_dirs:
  - /gpfs/projects/imt526a/conda/pkgs
```

Save (^O) and exit (^X) before continue in the shell.

This will enable the system Conda to find your class Conda environments.

## 4. Launch JupyterLab from Open OnDemand

Launch JupyterLab:

- Go to [**<ins>Tillicum Open OnDemand Portal</ins>**](https://tillicum-ood.hyak.uw.edu/).
- Choose **Interactive Apps** > **Jupyter**.
- Configure:
    - **Account**: imt526a
    - **QOS**: debug
    - **Number of GPUs**: 1
    - **Number of hours**: 1
    - **User Interface**: Jupyter Lab
- Click **Launch**, wait for resources to be allocated.
- Click **Connect to Jupyter** when resources are ready.

## 5. Cleanup

When finished:

1. Close the Jupyter browser tab.
2. Return to OOD and click **Delete** on your running session card.

This release compute resources back to the cluster.

> ⚠️ **WARNING:** Leaving sessions running consumes GPU hours and counts toward your project usage.