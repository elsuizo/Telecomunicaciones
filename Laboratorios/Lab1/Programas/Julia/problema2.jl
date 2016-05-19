#= -------------------------------------------------------------------------
# @file problema2.jl
#
# @date 05/17/16 01:07:50
# @author Martin Noblia
# @email martin.noblia@openmailbox.org
#
# @brief
#
# @detail
#
  Licence:
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License

---------------------------------------------------------------------------=#
# incluimos el modulo
include("teleco.jl")
# leemos el archivo
T = open(readall,"/home/elsuizo/Telecomunicaciones/Laboratorios/Lab1/Programas/Archivos/texto2.txt");
# Filtramos el texto para quitar los "\n" 
T = filter!(x->(x!='\n'), collect(T));
# calculamos las frecuencias y probabilidades 
d,p = Teleco.probs(T);
# generamos el arbol de Huffman
tree = Teleco.huffman_tree(d)
# generamos el codigo de Huffman
c = Teleco.huffman_code(tree)
# mostramos las salidas
println("Fuente y sus probabilidades")
Teleco.show_source(d)
println("Fuente y sus codigos de Huffmann")
Teleco.show_code(c)
h = Teleco.entropy(d);
print("La fuente discreta texto2.txt tiene una entropia: $h [bits/simbolo]\n")
L_hat = Teleco.L̄(c, d)
print("El codigo de Huffmann de la fuente discreta texto2.txt tiene una longitud promedio: $L_hat [bits/simbolo]\n")
# Calculo de la eficiencia
η = (h/L_hat) * 100
print("La eficiencia del codigo Huffman para la fuente discreta texto2.txt es: $η")
