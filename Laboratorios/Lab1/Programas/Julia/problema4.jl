# Script para resolver el problema 4
#-------------------------------------------------------------------------
# Includes 
#-------------------------------------------------------------------------
include("teleco2.jl")
using PyPlot # para los graficos
#-------------------------------------------------------------------------
# Generacion de la senial
x,t = Teleco2.set_sin(1024,200,1)
# cuantizacion uniforme 4 bits= 2^4=16 niveles
x_qu₄ = Teleco2.unifor_quatization(x,16)
# cuantizacion uniforme 3 bits= 2^3=9 niveles
x_qu₃ = Teleco2.unifor_quatization(x,9)
# cuantizacion uniforme 2 bits= 2^2=4 niveles
x_qu₂ = Teleco2.unifor_quatization(x,4)
# seniales de error
x_qu₄ₑ = x-x_qu₄;
x_qu₃ₑ = x-x_qu₃;
x_qu₂ₑ = x-x_qu₂;
#-------------------------------------------------------------------------
# graficos
#-------------------------------------------------------------------------

fig = figure(figsize=(10,10)) 
ax = gca()
p = plot(t,x,linestyle="-",linewidth=3,marker="None",label=L"$sin(2\pi f t)$") 
p2 = plot(t,x_qu₄,linestyle="-",linewidth=2,marker="None",label="cuantizada 4 bits")
p3 = plot(t,x_qu₄ₑ,linestyle="-",linewidth=2,marker="None",label="senial de error")
xlabel(L"$t$")
axis("tight") 
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
savefig("seniales_4_bits.eps")

fig = figure(figsize=(10,10)) 
ax = gca()
p = plot(t,x,linestyle="-",linewidth=3,marker="None",label=L"$sin(2\pi f t)$") 
p2 = plot(t,x_qu₃,linestyle="-",linewidth=2,marker="None",label="cuantizada 3 bits")
p3 = plot(t,x_qu₃ₑ,linestyle="-",linewidth=2,marker="None",label="senial de error")
xlabel(L"$t$")
axis("tight") 
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
savefig("seniales_3_bits.eps")

fig = figure(figsize=(10,10)) 
ax = gca()
p = plot(t,x,linestyle="-",linewidth=3,marker="None",label=L"$sin(2\pi f t)$") 
p2 = plot(t,x_qu₂,linestyle="-",linewidth=2,marker="None",label="cuantizada 2 bits")
p3 = plot(t,x_qu₂ₑ,linestyle="-",linewidth=2,marker="None",label="senial de error")
xlabel(L"$t$")
axis("tight") 
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
savefig("seniales_2_bits.eps")
