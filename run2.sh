#!/bin/bash
export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

#rm ./headless.dat 


perf stat -r 10 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses ./headless $3 0.1 0 0 5 100 >/dev/null 2>&1
python3 mean_outputs.py output.txt
cat output.txt
