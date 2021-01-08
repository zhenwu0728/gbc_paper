#!/bin/sh
#SBATCH -J Darwin_Exu           # job name
#SBATCH -p sched_mit_darwin     # which queue ("partition")
#SBATCH -N 6                    # number of nodes to use (each has 16 cores)
#SBATCH -n 96                   # total number of cores to run on
#SBATCH --constraint=centos6
#SBATCH --mem-per-cpu 4000      # memory per core needed (16-core nodes have 64GB)
#SBATCH --time 12:00:00         # run no longer than 16 hours

module use /home/jahn/software/modulefiles
module add engaging/intel/2013.1.046
module add netcdf/4.3.3.1_intel-2013.1.046

echo "MITgcm 3D job starting"
date
echo "-----------------------------"

mpirun -n 96 ./mitgcmuv

echo "-----------------------------"
date
echo "MITgcm 3D job finished"
