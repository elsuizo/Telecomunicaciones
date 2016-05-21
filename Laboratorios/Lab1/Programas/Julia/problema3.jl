# Script para la resolucion del problema 3

# incluimos el modulo
include("teleco.jl")

# leemos los bytes de la fuente castellano
s1 = open(readbytes,"../Archivos/castellano.txt");
# leemos los bytes de la fuente ingles
s2 = open(readbytes,"../Archivos/ingles.txt");
# leemos los bytes de la fuente castellano zipeada
s1_zip = open(readbytes,"../Archivos/castellano.txt.zip");
# leemos los bytes de la fuente ingles zipeada
s2_zip = open(readbytes,"../Archivos/ingles.txt.zip");

# calculamos las longitudes de los archivos(bytes)
l1 = length(s1);
l2 = length(s2);
l1_zip = length(s1_zip);
l2_zip = length(s2_zip);

# calculamos los ratios
r1 = (l1_zip / l1) * 100;
r2 = (l2_zip / l2) * 100;

# mostramos los resultados
print("La eficiencia de compresión para el caso de la fuente en castellano es: $r1\n")

print("La eficiencia de compresión para el caso de la fuente en ingles es: $r2\n")

# Leemos los archivos como texto plano
Tc = open(readall,"../Archivos/castellano.txt");
Ti = open(readall,"../Archivos/ingles.txt");

# Filtramos el texto para quitar los "\n" y los espacios " "
Tc = filter!(x->(x!='\n')&&(x!=' '),collect(Tc));
Ti = filter!(x->(x!='\n')&&(x!=' '),collect(Ti));

# calculamos las frecuencias y probabilidades 
dc,pc = Teleco.probs(Tc);
d_i,p_i= Teleco.probs(Ti);
# Mostramos los resultados
println("Las frecuencias para el texto en castellano son:\n\n")
Teleco.show_source(dc)
println("Las frecuencias para el texto en ingles son:\n\n")
Teleco.show_source(d_i)
# convertimos los vectores a Floats
pc = convert(Array{Float64,1}, pc)
p_i = convert(Array{Float64,1}, p_i)
# calculamos las entropias
hc = Teleco.entropy(pc);
hi = Teleco.entropy(p_i);

println("La fuente discreta castellano.txt tiene una entropia: $hc [bits/simbolo]")
print("La fuente discreta ingles.txt tiene una entropia: $hi [bits/simbolo]")
