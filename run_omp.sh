#!/bin/bash
export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

make clean >/dev/null 2>&1

rm -f ./headless{$3}{$4}{$5}.dat 
rm -f output.txt
rm -f out.txt
rm -f headless.optrpt

make all >/dev/null 2>&1

export OMP_NUM_THREADS=$5

export filename_headless="headless$3$4$5.dat"

perf stat -r 1 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses ./headless $3 0.1 0 0 5 100 $4 >/dev/null 2>&1

python3 mean_outputs.py output.txt "headless$3$4$5.dat"

cat output.txt #> out.txt
#cat out.txt
