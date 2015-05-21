# script problema 5

#-------------------------------------------------------------------------
# Includes 
#-------------------------------------------------------------------------
using PyPlot
using WAV # modulo para trabajar con wavs
include("teleco2.jl")

# leemos el archivo de voz
x,fs = wavread("audio_voz.wav")
# cuantizamos uniformente con 4 bits
x_q₄ = Teleco2.unifor_quatization(x,16) 
x_q₃ = Teleco2.unifor_quatization(x,9) 
x_q₂ = Teleco2.unifor_quatization(x,4) 

wavwrite(x_q₄,"audio_voz_q_4.wav",Fs=8000)
wavwrite(x_q₃,"audio_voz_q_3.wav",Fs=8000)
wavwrite(x_q₂,"audio_voz_q_2.wav",Fs=8000)

xₑ₂ = x-x_q₂
xₑ₄ = x-x_q₄
xₑ₃ = x-x_q₃


fig = figure(figsize=(10,10)) 
ax = gca()
p = plot(x,linestyle="-",linewidth=2,marker="None",label="senial original")
p2 = plot(x_q₄,linestyle="-",linewidth=1,marker="None",label="cuantizada 4 bits")
p3 = plot(xₑ₄,linestyle="-",linewidth=1,marker="None",label="senial de error")
xlabel(L"$t$")
axis("tight") 
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
savefig("senialesv_voz_4_bits.eps")

fig = figure(figsize=(10,10)) 
ax = gca()
p = plot(x,linestyle="-",linewidth=2,marker="None",label="senial original")
p2 = plot(x_q₃,linestyle="-",linewidth=1,marker="None",label="cuantizada 3 bits")
p3 = plot(xₑ₃,linestyle="-",linewidth=1,marker="None",label="senial de error")
xlabel(L"$t$")
axis("tight") 
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
savefig("senialesv_voz_3_bits.eps")

fig = figure(figsize=(10,10)) 
ax = gca()
p = plot(x,linestyle="-",linewidth=2,marker="None",label="senial original")
p2 = plot(x_q₂,linestyle="-",linewidth=1,marker="None",label="cuantizada 2 bits")
p3 = plot(xₑ₂,linestyle="-",linewidth=1,marker="None",label="senial de error")
xlabel(L"$t$")
axis("tight") 
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
savefig("senialesv_voz_2_bits.eps")

