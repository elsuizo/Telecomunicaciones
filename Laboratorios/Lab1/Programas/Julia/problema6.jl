# Script para resolver el problema 6

#-------------------------------------------------------------------------
# includes
#-------------------------------------------------------------------------
using PyPlot
using WAV # modulo para trabajar con wavs
using DSP
include("teleco2.jl")

# leemos el archivo de voz
x,fs = wavread("audio_voz.wav")
# cuantizamos con la ley-mu 4 bits y mu=255=0xff
x_q₄ = Teleco2.μ_quantization(x,16,255)
x_q₃ = Teleco2.μ_quantization(x,9,255)
x_q₂ = Teleco2.μ_quantization(x,4,255)

wavwrite(x_q₄,"audio_voz_q_4_mu.wav")
wavwrite(x_q₃,"audio_voz_q_3_mu.wav")
wavwrite(x_q₂,"audio_voz_q_2_mu.wav")
# calculamos la seniales de error
xₑ₂ = x-x_q₂
xₑ₄ = x-x_q₄
xₑ₃ = x-x_q₃

#calculamos la relacion senial-ruido
s_n₂ = 10*log10((mean(x_q₂ .* x_q₂)) / (mean(xₑ₂ .* xₑ₂)))
s_n₃ = 10*log10((mean(x_q₃ .* x_q₃)) / (mean(xₑ₃ .* xₑ₃)))
s_n₄ = 10*log10((mean(x_q₄ .* x_q₄)) / (mean(xₑ₃ .* xₑ₄)))

println("La relación senial-ruido para 2 bits es: $s_n₂ [Db]")
println("La relación senial-ruido para 3 bits es: $s_n₃ [Db]")
println("La relación senial-ruido para 4 bits es: $s_n₄ [Db]")
# calculamos las densidades espectrales de la seniales 
f_x = periodogram(x[:]) #flat
f_x₂ = periodogram(x_q₂[:])
f_x₃ = periodogram(x_q₃[:])
f_x₄ = periodogram(x_q₄[:])
#-------------------------------------------------------------------------
# Graficos
#-------------------------------------------------------------------------
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
savefig("senialesv_voz_4_bits_mu.eps")
#-------------------------------------------------------------------------
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
savefig("senialesv_voz_3_bits_mu.eps")
#-------------------------------------------------------------------------
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
savefig("senialesv_voz_2_bits_mu.eps")
#-------------------------------------------------------------------------
# densidad espectral de x
fig = figure(figsize=(10,10))
ax = gca()
p3 = plot(f_x.power,linestyle="-",linewidth=1,marker="None",label=L"$\vert X(f)\vert ^{2}$")
xlabel(L"$f$")
axis("tight")
title("Densidad espectral de energia de la senial de audio")
grid("on")
legend(loc="upper right",fancybox="true")
savefig("densidad_espectral_x.eps")
#-------------------------------------------------------------------------
fig = figure(figsize=(10,10))
ax = gca()
p3 = plot(f_x₂.power,linestyle="-",linewidth=1,marker="None",label=L"$\vert X(f)\vert ^{2}$")
xlabel(L"$f$")
axis("tight")
title(L"Densidad espectral de energia(2 bits ley-$\mu$)")
grid("on")
legend(loc="upper right",fancybox="true")
savefig("densidad_espectral_x_2.eps")
#-------------------------------------------------------------------------
fig = figure(figsize=(10,10))
ax = gca()
p3 = plot(f_x₃.power,linestyle="-",linewidth=1,marker="None",label=L"$\vert X(f)\vert ^{2}$")
xlabel(L"$f$")
axis("tight") 
title(L"Densidad espectral de energia(3 bits ley-$\mu$)")
grid("on")
legend(loc="upper right",fancybox="true")
savefig("densidad_espectral_x_3.eps")
#-------------------------------------------------------------------------
fig = figure(figsize=(10,10))
ax = gca()
p3 = plot(f_x₄.power,linestyle="-",linewidth=1,marker="None",label=L"$\vert X(f)\vert ^{2}$")
xlabel(L"$f$")
axis("tight")
title(L"Densidad espectral de energia(4 bits ley-$\mu$)")
grid("on")
legend(loc="upper right",fancybox="true")
savefig("densidad_espectral_x_4.eps")
