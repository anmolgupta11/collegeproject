#!/bin/sh
#SBATCH -N 4 / Number of nodes
#SBATCH --ntasks-per-node=40 / Number of cores for node
#SBATCH --job-name=lammps / Name of application
#SBATCH --error=job.%J.err_16_node_40 / Name of the output file
#SBATCH --output=job.%J.out_16_node_40 / Name of the error file
#SBATCH --partition=cpu / Partition or queue name

module unload gnu8/8.3.0
module load intel/2019.5.281
module load openmpi/4.0.1

export I_MPI_FALLBACK=disable
export I_MPI_FABRICS=shm:dapl
export I_MPI_DEBUG=9
export OMP_NUM_THREADS=1

cd lammps-calculations/VLE/
time mpiexec.hydra -genv I_MPI_DEBUG 9 -n $SLURM_NTASKS -genv  OMP_NUM_THREADS 1 lmp_intel_cpu_intelmpi -in in.lammps.vle