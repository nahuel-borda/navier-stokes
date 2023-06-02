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
rm -f headless.optrpt

make all >vectorization_report.txt 2>&1

if [ $CC == 'clang' ]; then
  cat vectorization_report.txt | sort --unique | grep -c 'vectorization width' | xargs -I {} echo "{};;total_vectorizations;" >> vect_output.txt
  cat vectorization_report.txt | sort --unique | grep -c 'pass-missed' | xargs -I {} echo "{};;missed_vectorizations;" >> vect_output.txt
elif [ $CC == 'aocc' ]; then
  cat vectorization_report.txt | sort --unique | grep -c 'vectorization width' | xargs -I {} echo "{};;total_vectorizations;" >> vect_output.txt
  cat vectorization_report.txt | sort --unique | grep -c 'pass-missed' | xargs -I {} echo "{};;missed_vectorizations;" >> vect_output.txt
elif [ $CC == 'icc' ]; then
  cat headless.optrpt | sort --unique | grep -c 'WAS VECTORIZED' | xargs -I {} echo "{};;total_vectorizations;" >> vect_output.txt
  cat headless.optrpt | sort --unique | grep -c 'not vectorized' | xargs -I {} echo "{};;missed_vectorizations;" >> vect_output.txt
elif [ $CC == 'icx' ]; then
  cat headless.optrpt | sort --unique | grep -c 'WAS VECTORIZED' | xargs -I {} echo "{};;total_vectorizations;" >> vect_output.txt
  cat headless.optrpt | sort --unique | grep -c 'not vectorized' | xargs -I {} echo "{};;missed_vectorizations;" >> vect_output.txt
else
  grep -c "optimized" vectorization_report.txt | xargs -I {} echo "{};;total_vectorizations;" >> vect_output.txt
  grep -c "missed" vectorization_report.txt | xargs -I {} echo "{};;missed_vectorizations;" >> vect_output.txt
fi


if [ $# == 2 ]; then
	perf stat -r 1 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses ./headless >/dev/null 2>&1
	python3 mean_outputs.py output.txt
elif [ $# == 3 ]; then
	perf stat -r 1 -x ';' -o output.txt -e cpu-clock,task-clock,context-switches,page-faults,cycles,instructions,branches,faults,migrations,duration_time,cache-misses OMP_NUM_THREADS=$5 ./headless $3 0.1 0 0 5 100 $4 >/dev/null 2>&1
	python3 mean_outputs.py output.txt
fi

cat output.txt vect_output.txt > out.txt
cat out.txt
