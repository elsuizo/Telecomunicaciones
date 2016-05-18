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
# Filtramos el texto para quitar los "\n" y los espacios " "
T = filter!(x->(x!='\n')&&(x!=' '),collect(T));
# calculamos las frecuencias y probabilidades 
d,p = Teleco.probs(T);
#pr = Teleco.freqs_pr(T)
tree = Teleco.huffmanTree(d)

