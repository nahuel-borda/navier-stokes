#!/usr/bin/python3

import matplotlib.pyplot as plt		# cosas de graficos
#from numpy import genfromtxt		# para importar datos
#from numpy import loadtxt			# para importar datos
from pandas import read_csv			# para importar datos
from numpy import mean				# para promedios
import matplotlib.colors as mcolors	# para definir colores

means=[]
legend=[]


lista1=['gcc']
lista2=["-O0", "-O1", "-O2", "-O3", "-Ofast", "-Os"]
#lista2=["-O0", "-O1"]

# Hago promedios a partir de los métricas obtenidas
for i in lista1:
	for j in lista2:
		namefile="lab1_pruebas_compiladores/datos_"+str(i)+"_"+str(j)+"/headless.dat"
		print(namefile)
#		data = genfromtxt(namefile, unpack=True)
#		data = loadtxt(namefile, delimiter=',', skiprows=0, dtype=str)
		data = read_csv(namefile,header=None)
		ns_per_cell=data[0]
		means.append(1./mean(ns_per_cell)) # Hago el promedio de todos los ns_per_cell


print(means)


# me hago una lista de colores
colores_tab=mcolors.TABLEAU_COLORS
colores=[]
for clr in colores_tab.values():
	colores.append(clr)
	

# graficos
cant=len(lista1)*len(lista2)
plt.bar(range(0,cant),means,color=colores[0:cant],edgecolor='black')
plt.ylabel('ns/cell)')

## defino las leyendas
plt.title('gcc')
legend=["-O0", "-O1", "-O2", "-O3", "-Ofast", "-Os"]
#legend=["-O0", "-O1"]
labels = legend
handles = [plt.Rectangle((0,0),1,1, color=clr) for clr in colores]
plt.legend(handles, labels)

# muestra en pantalla
#plt.show()

# guarda
plt.savefig('prueba_comps_codigo_original.png', bbox_inches='tight')
