#!/bin/bash
export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

make clean >/dev/null 2>&1
make all >/dev/null 2>&1

perf stat -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time ./headless >/dev/null 2>&1
cat output.txt
