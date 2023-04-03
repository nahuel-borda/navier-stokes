#!/bin/bash 

export demo_name=demo
export headless_name=headless

Nruns=4 # Cantidad de ejecuciones para hacer los promedios de los ns_per_cell

#TODO agregar icc, clang a la lista de compiladores (no los tengo instalados)

#TODO Entiendo que podría haber hecho dos comandos en el makefile que sean por ejemplo
#     make pruebas_comp que compilen con todos los compiladores y opciones, y prueba_ind 
#     que compile uno solo para ir haciendo pruebas en el código.
#     Pero como queremos también automatizar la ejecución dejé un loop acá. Cual es la buena forma de hacer esto??
#     Porque si ahora quiero cambiar algo en el código y hacer una única prueba tengo que hacer otro compile.sh??

pardir="lab1_pruebas_compiladores"
mkdir $pardir


for i in "gcc" ; do 
	for j in "-O0" "-O1" "-O2" "-O3" "-Ofast" "-Os" "-Oz"; do
		
		#Exporto los nombres de los compiladores y las opciones
		export CC=$i
		export CFLAGS="-std=c17 -Wall -Wextra ""$j"	#TODO Esto esta medio choto, como está escrito no hay que cambiar los espacios entre el ""

		echo ''
		echo ''
		echo '------------'
		echo $CC $CFLAGS

		# Compilo
		make clean
		make

		# Hago un subdirectorio de pardir
		dir=datos_${i}_${j}
		mkdir $pardir/$dir
		
		# Borro archivos de datos anteriores
		rm $pardir/$dir/headless.dat 
		
		# muevo el ejecutable al nuevo directorio
		cp ./${headless_name} $pardir/$dir/${headless_name}

		# Ejecuto headless Nruns veces dentro de dir, se genera un solo archivo de datos con los Nruns resultados.
		cd $pardir/$dir
		for n in $(eval echo "{1.."$Nruns"..1}"); do
			./${headless_name}
			echo ''
		done		
		cd ../.. 
		
		
	done
	
done







