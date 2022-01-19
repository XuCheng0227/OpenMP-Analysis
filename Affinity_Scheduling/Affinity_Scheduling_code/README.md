## Requirements

* Intel compiler.

To get the intel compiler on Cirrus, run:

```console
$ module load intel-compilers-19
```
---

* openmp

To run the openmp program directly,

```console
$ icc -O3 -qopenmp -std=c99 -c affinity.c
$ icc -O3 -qopenmp -std=c99 -o loops2 loops2.o affinity.o -lm

```
---

## Compilation

Makefile is provided. To compile the code, simply run make. And all the file will be compiled to the executables.

```console
$ make
```

or

```console
$ make all
```

Or run the program directl using Cirrus sbatch commands with compilation, but have to modify --nodes to 1, when running on a single computer nodes.

```console
$ sbatch loops2.slurm
```

---

## Usage

To run the loops2 program, usage is provided below,

```console
$ export OMP_NUM_THREADS=16
$ ./loops2

```

To run theprogram, threads number must be first determined after export OMP_NUM_THREADS=.
(There are 2 -n with different meanings.)


# A Cirrus Slurm job submission script

`loops2.slurm` is the submission script for Cirrus which submits a job to a compute node to run Percolate.

Default Settings:

*  --exclusive
*  --tasks-per-node=36
*  --nodes=1
*  --partition=standard
*  --cpus-per-task=36

To use it, submit the job as follows:

```console
$ sbatch coursework.job
```

A job ID will then be displayed, for example:

```
Submitted batch job 252132
```

You can check the job's progress in the queue

```console
$ squeue -u $USER
```

Once it completes you will output files, slurm-<JOB_ID>:

```console
$ ls
... slurm-252132.out ...
```

To read the file, run
```console
$ nano slurm-252132.out
```
