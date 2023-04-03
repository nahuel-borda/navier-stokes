#!/bin/bash
export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

make clean
make all

perf stat -x ';' -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time ./headless
