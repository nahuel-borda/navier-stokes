#!/bin/bash 

if [ $HOSTNAME = "atom" ]; then
	source /opt/intel/oneapi/setvars.sh
	source /opt/AMD/aocc-compiler-4.0.0/setenv_AOCC.sh
fi

cd ~/navier-stokes/

./lab1_prueba_compiladores_1.sh
./lab1_prueba_compiladores_2.sh

python3 ./plots_lab1_pruebas_compiladores_1.sh
python3 ./plots_lab1_pruebas_compiladores_2.sh
