#! /bin/bash
#PJM -N graphite_1d10
#PJM -g xg17i???
#PJM -L rscgrp=regular-flat
#PJM -L elapse=2:00:00
#PJM -L node=2
#PJM --mpi proc=2
#PJM --omp thread=256
#PJM -o job.log
#PJM -e job.err
#PJM -m b,e
#PJM –j

export FORT_BUFFERED=1

export KMP_AFFINITY=balanced,granularity=fine
export I_MPI_PIN_PROCESSOR_EXCLUDE_LIST=0,1,68,69,136,137,204,205
export I_MPI_HBW_POLICY=hbw_bind,hbw_bind

ARTED_DIR=/work/xg17i???/x?????/ARTED
ARTED=${ARTED_DIR}/bin/ARTED_sc.mic

mpiexec.hydra -n ${PJM_MPI_PROC}  ${ARTED} < ./graphite_1d10.inp > ./graphite_1d10.out
