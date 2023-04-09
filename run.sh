#!/bin/bash
export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

NPARAM=$3

make clean >/dev/null 2>&1
rm ./headless.dat 
touch ./headless.dat
make all >/dev/null 2>&1

perf stat -r 10 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses ./headless $NPARAM >/dev/null 2>&1
python3 mean_outputs.py output.txt
cat output.txt
