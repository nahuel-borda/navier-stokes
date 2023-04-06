#!/bin/bash 

export demo_name=demo
export headless_name=headless

Nruns=1 # Cantidad de ejecuciones para hacer los promedios de los ns_per_cell

#TODO faltaría que el programa guarde algunos datos para después comparar (datos de salida para tests, y datos de metricas para comparar)

for i in "gcc" ; do 
	for j in ""; do
		
		#Exporto los nombres de los compiladores y las opciones
		export CC=$i
		export CFLAGS="-std=c17 -Wall -Wextra -O0 ""$j"	#TODO Esto esta medio choto, como está escrito no hay que cambiar los espacios entre el ""

		echo ''
		echo ''
		echo '------------'
		echo $CC $CFLAGS

		# Compilo
		make clean
		make

		# Ejecuto headless
		for n in $(eval echo "{1.."$Nruns"..1}"); do
			# rm ....... # Borro archivos de datos anteriores
			./${headless_name}
			echo ''
		done
		
		
	done
	
done







