#! /bin/bash
#SBATCH -J graphite_1d10
#SBATCH -p mixed
#SBATCH -N 2
#SBATCH --ntasks-per-node=2
#SBATCH -t 02:00:00
#SBATCH -o output.log

cd $SLURM_SUBMIT_DIR

module purge
module load intel intelmpi mkl

export OMP_STACKSIZE="2M"
export OMP_SCHEDULE="static"
export MIC_OMP_NUM_THREADS=180
export MIC_KMP_AFFINITY="scatter,granularity=fine"

# load-balancer
export ARTED_ENABLE_LOAD_BALANCER=1
export ARTED_CPU_PPN=${SLURM_NTASKS_PER_NODE}
export ARTED_MIC_PPN=2
export ARTED_CPU_TASK_RATIO=0.78

ARTED_DIR=/work/TDDFT/$USER/ARTED
MPIRUN_SYMM=$ARTED_DIR/script/mpirun.symm
ARTED=$ARTED_DIR/bin/ARTED_sc

$MPIRUN_SYMM -s $ARTED < graphite_1d10.inp > graphite_1d10.out

