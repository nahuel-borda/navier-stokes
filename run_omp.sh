#!/bin/bash
export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

make clean >/dev/null 2>&1

rm -f ./headless.dat 
rm -f output.txt
rm -f out.txt
rm -f headless.optrpt

make all 2>&1

export OMP_NUM_THREADS=$5

perf stat -r 1 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses ./headless $3 0.1 0 0 5 100 $4
python3 mean_outputs.py output.txt


cat output.txt > out.txt
cat out.txt
