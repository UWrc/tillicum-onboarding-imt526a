# Navigating the Filesystem & Understanding Storage Spaces

On Tillicum, storage is **physically separate** from computation nodes. It’s mounted so every node in the cluster can access it under `/gpfs/`. 

You’ll often hear Tillicum storage referred to as GPFS, which stands for **General Parallel File System** — IBM’s high-performance, cluster-wide filesystem. It allows all compute nodes to read and write to the same shared data simultaneously with very high throughput.

So whenever you see a path like:

```bash
/gpfs/home/UWnetID
```
that means you’re accessing your home directory on the GPFS storage system, not a local disk on the login node.

![Diagrammatic representation of the Tillicum filesystem directory tree. The directory tree shows the root directory at the top which holds all subdirectories. The picture is a truncated view of the filesystem showing the root directory and a few directories within it, including GPFS and a few directories within GPFS/: home/ where the Home directories are, software/ where we keep software, datasets/ where common datasets are stored, scrubbed/ where users can utilize temporary storage, and projects/ where the lab groups their dedicated storage.](./img/directory_graphic.jpg 'filesystem')
*Diagram - truncated view of the Tillicum filesystem.*

As shown above, the Tillicum filesystem is organized under the root directory `/`. Within it, `/gpfs/` contains several key subdirectories:

* `home/` — individual user home directories for configuration and small files.
* `software/` — centrally managed shared applications and tools.
* `datasets/` — curated public or shared research datasets. We have a process by which groups can nominate datasets for storage under our [**<ins>Data Commons</ins>**](https://hyak.uw.edu/docs/data-commons/requirements). 
* `scrubbed/` — temporary scratch space for active work, periodically cleaned.
* `projects/` — long-term storage for groups and project-specific data.

Every user on Tillicum has access to three key storage spaces mounted under `/gpfs/` where they can **write** *and* **read** files:

1. Home directory (`/gpfs/home/UWNetID`)— personal, backed-up storage
1. Project/lab dedicated storage (`/gpfs/projects/group-name`) — shared, backed-up storage for research groups
1. Scrubbed storage (`/gpfs/scrubbed/some-directory`) — large, temporary scratch space for active computation

Here’s a quick overview of Tillicum storage policies:
| Storage             | Size / Quota          | Backup          | Notes                                                                        |
| ------------------- | --------------------- | --------------- | ---------------------------------------------------------------------------- |
| Home Directory      | 10 GB per user        | Daily snapshots | Keep only configuration files here; use other spaces for data/code           |
| Project/Lab Storage | 1 TB per project/lab  | Daily snapshots | Request allocation via [**<ins>Tillicum intake form</ins>**](https://uwconnect.uw.edu/it?id=kb_article_view&sysparm_article=KB0036077)                             |
| Scrubbed Storage    | Up to 100 TB per user | None            | Scratch space, purged after 60 days of inactivity; not for long-term storage |

***Tillicum is a new service. We will constantly evaluate these storage policies based on user feedback.***

> 💡 **TIP:** For this class, students will have access to project storage `/gpfs/projects/imt526a`.

# Data Transfer: Moving Files To and From Tillicum

Efficient and reliable data transfer is a key part of working on Tillicum. There are two main ways to move files between your local computer and the cluster:

| Method                           | Best For                               | Notes                                                                            |
| -------------------------------- | -------------------------------------- | -------------------------------------------------------------------------------- |
| **`scp` (Secure Copy Protocol)** | Small to medium file transfers         | Simple and available by default on all systems                                   |
| **Globus**                       | Large datasets, unsupervised transfers | Automatically handles restarts and failures, ideal for long or complex transfers |

## Transfer Data with `scp`

`scp` (secure copy) works similarly to `ssh`—you’ll use your UW NetID credentials to securely copy data between your local machine and Tillicum. More instructions are available [**<ins>here</ins>**](https://hyak.uw.edu/docs/storage/transfer).

## Transfer Data with Globus (Recommended)

While `scp` is great for quick transfers, **Globus** is the best way to move large datasets reliably and automatically.

Globus provides:
* **Automatic checkpointing** – if your connection drops, transfers resume from where they left off
* **Integrity checks** – ensures every file arrives intact
* **Unsupervised transfers** – no need to stay connected while data moves

Tillicum is available as a Globus collection for data transfer. Globus is available on Hyak Klone, Kopah, and UW OneDrive, allowing for seamless and high-speed data transfers to and from Tillicum.

### Learn More

* Hyak Klone Globus Documentation: [**<ins>Learn more here.</ins>**](https://hyak.uw.edu/docs/storage/globus)
* Globus User Documentation: [**<ins>Learn more here.</ins>**](https://docs.globus.org/?_gl=1*s0ry7u*_ga*MTE2MzI4NzMxNi4xNzQyMzQxMTg3*_ga_7ZB89HGG0P*MTc0NDA3MjY1Ny4xNy4xLjE3NDQwNzI2NTcuMC4wLjA.)
* [**<ins>Video Tutorial: Introduction to Globus for Researchers and New Users</ins>**](https://www.youtube.com/watch?v=-j7Mp3FN1zo&list=PLLCSx-IFoBeu2F-HF-DMoc5_AUsvYft8c&index=2)
* [**<ins>Video Tutorial: Globus Connect Personal Setup</ins>**](https://www.youtube.com/watch?v=bpnVcAN99WY). *Note: the Endpoints Menu Tool appears to be deprecated and now "Endpoint" and "Collection" are synonymous. Your personal endpoint can be found by searching Collections.*

# Practice

Let's review key storage directories on Tillicum and practice commands.

### 1. Your Home Directory

Your Home directory is your default location when logging into Tillicum. It’s located at:

```bash
cd ~
/gpfs/home/UWnetID
```
where **UWnetID** is *your* UW NetID.

We recommend storing only configuration files here and using other storage spaces for data, code, and software.

To check your current location, use:

```bash
pwd
```
To list the contents of your directory:

```bash
ls
```
To show detailed information or hidden files:

```bash
# List items with details
ls -l
# List item including hidden files
ls -a
```

### 2. Monitoring Your Storage Usage

To see how much space each subdirectory uses:

```bash
du -h -d 1
```

This command reports how much space each folder occupies and updates dynamically as you clean up files.

### 3. Moving Around — cd

The `cd` command changes your current directory. Some useful shortcuts:

```bash
cd ~                # Go to your home directory
cd /gpfs            # Go to the GPFS directory
ls                  # List contents under current directory: /gpfs
cd projects/imt526a # Go to shared directory by this class
pwd                 # Check your current location
cd ..               # Return to your previous directory
```

### 4. Scrubbed Storage

Scrubbed storage is temporary scratch space for active computation. It’s not backed up and files are deleted automatically after **60 days** of inactivity.

Location:

```bash
cd /gpfs/scrubbed/
ls
```