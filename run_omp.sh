#!/bin/bash

#SBATCH --job-name=test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=$5

export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

make clean >/dev/null 2>&1

rm -f ./headless.dat 
touch headless.dat
rm -f output.txt
rm -f out.txt
rm -f headless.optrpt

make all >/dev/null 2>&1

export OMP_NUM_THREADS=$5
export OMP_PROC_BIND=true

perf stat -r 1 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses srun --input headless.dat --ntasks=1 ./headless $3 0.1 0 0 5 100 $4 >/dev/null 2>&1

python3 mean_outputs.py output.txt

cat output.txt 
