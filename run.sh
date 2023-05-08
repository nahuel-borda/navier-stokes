#!/bin/bash
export demo_name=demo
export headless_name=headless
export CC=$1
export CFLAGS=$2

make clean >/dev/null 2>&1

rm -f ./headless.dat 
rm -f vect_output.txt
rm -f output.txt
rm -f out.txt

make headless >vectorization_report.txt 2>&1

grep -c "optimized" vectorization_report.txt | xargs -I {} echo "{};;total_vectorizations;" >> vect_output.txt
grep -c "missed" vectorization_report.txt | xargs -I {} echo "{};;missed_vectorizations;" >> vect_output.txt

perf stat -r 10 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses ./headless >/dev/null 2>&1
python3 mean_outputs.py output.txt 
cat output.txt vect_output.txt > out.txt
cat out.txt
