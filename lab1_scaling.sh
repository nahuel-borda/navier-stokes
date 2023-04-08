#!/bin/bash 

export demo_name=demo
export headless_name=headless


pardir="lab1_scaling"
mkdir $pardir


for N in 30 32 62 64 126 128 157 254 256 401 510 512 1022 1024 1777 2046 2048; do

	# Hago un subdirectorio de pardir
	dir=datos_$N
	mkdir $pardir/$dir

	make clean >/dev/null 2>&1
	make all >/dev/null 2>&1

	# muevo el ejecutable al nuevo directorio
	cp ./run2.sh $pardir/$dir/	
	cp ./${headless_name} $pardir/$dir/${headless_name}

	# Ejecuto dentro de dir
	cd $pardir/$dir
	./run2.sh aocc "-std=c17 -Wall -Wextra -Ofast -march=native" "$N 0.1 0 0 5 100"
	cd ../.. 		
		
done
	




