#= Script para el problema 1
desde consola:
julia problema1.jl
=#
# incluimos el modulo
include("teleco.jl")
# leemos el archivo
T = open(readall,"/home/elsuizo/Telecomunicaciones/Laboratorios/Lab1/Programas/Archivos/texto.txt");
# Filtramos el texto para quitar los "\n" y los espacios " "
T = filter!(x->(x!='\n')&&(x!=' '),collect(T));
# calculamos las frecuencias y probabilidades 
d,p = Teleco.probs(T);
# Mostramos los resultados
Teleco.show_source(d)
# Calculamos la entropia de la fuente
h = Teleco.entropy(p);
print("La fuente discreta texto.txt tiene una entropia: $h [bits/simbolo]\n")
