#!/bin/bash

# Slurm job options (name, compute nodes, job time)
#SBATCH --job-name=loops2
#SBATCH --time=0:10:0
#SBATCH --exclusive
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=36

# Replace [budget code] below with your budget code (e.g. dc116-s1234567)
#SBATCH --account=dc134-s2195209
# We use the "standard" partition as we are running on CPU nodes
#SBATCH --partition=standard
# We use the "short" QoS as our runtime is less than20 mins
#SBATCH --qos=short

module load intel-compilers-19

# Change to the submission directory
cd $SLURM_SUBMIT_DIR

# Set the number of threads
export OMP_NUM_THREADS=1

echo  OMP_NUM_THREADS=1
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=2

echo  OMP_NUM_THREADS=2
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=4

echo  OMP_NUM_THREADS=4
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=6

echo  OMP_NUM_THREADS=6
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=8

echo  OMP_NUM_THREADS=8
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=12

echo  OMP_NUM_THREADS=12
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=16

echo  OMP_NUM_THREADS=16
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=24

echo  OMP_NUM_THREADS=24
srun --cpu-bind=cores ./loops2
echo ----------

export OMP_NUM_THREADS=32

echo  OMP_NUM_THREADS=32
srun --cpu-bind=cores ./loops2
echo ----------
