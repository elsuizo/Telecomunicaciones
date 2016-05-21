#= -------------------------------------------------------------------------
# @file problema7.jl
#
# @date 05/17/16 12:39:58
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
# includes
using PyPlot # para los graficos
#-------------------------------------------------------------------------
# primer conjunto
#-------------------------------------------------------------------------
s1a(t, T, A) = A * (0 .< t .< T/2)
s1b(t, T, A) = A * (T/4 .< t .< 3T/4)
Δ₁(t, T, A) = s1a(t, T, A) - s1b(t, T, A)
h₁(t, T, A) = Δ₁(T-t, T, A) # adaptado a a la diferencia
# segundo conjunto
#-------------------------------------------------------------------------
s2a(t, T, A) = A * (0 .< t .< T/2)
s2b(t, T, A) = A * (T/2 .< t .< T)
Δ₂(t, T, A) = s2a(t, T, A) - s2b(t, T, A) # adaptado a a la diferencia
h₂(t, T, A) = Δ₂(T-t, T, A)
# tercer conjunto
#-------------------------------------------------------------------------
s3a(t, T, A) = A * (0 .< t .< T/2)
s3b(t, T, A) = -A * (0 .< t .< T/2)
Δ₃(t, T, A) = s3a(t, T, A) - s3b(t, T, A) # adaptado a a la diferencia
h₃(t, T, A) = Δ₃(T-t, T, A)
#-------------------------------------------------------------------------
T_b = 2
A = 1
t = collect(linspace(0,3))
#-------------------------------------------------------------------------
# envio s1a
s₁ = s1a(t, T_b, A)
L₁ = length(s₁)
n₀₁ = randn(L₁)
# le agregamos ruido
r₁ = s₁ + n₀₁
ŝ₁ = xcorr(r₁, h₁(t, T_b, A)) ./ L₁ # estimacion
#-------------------------------------------------------------------------
# envio s2a
s₂ = s2a(t, T_b, A)
L₂ = length(s₂)
n₀₂ = randn(L₂)
# le agregamos ruido
r₂ = s₂ + n₀₂
ŝ₂ = xcorr(r₂, h₂(t, T_b, A)) ./ L₂ # estimacion
#-------------------------------------------------------------------------
# envio s3a
s₃ = s3a(t, T_b, A)
L₃ = length(s₃)
n₀₃ = randn(L₃)
# le agregamos ruido
r₃ = s₃ + n₀₃
ŝ₃ = xcorr(r₃, h₃(t, T_b, A)) ./ L₃ #estimacion

# plot primer conjunto
#-------------------------------------------------------------------------
fig = figure(figsize=(10,10))
ax = gca()
p = plot(s1a(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="senial enviada")
p = plot(s1b(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="segunda senial")
p = plot(h₁(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="respuesta del filtro")
p = plot(ŝ₁,linestyle="-",linewidth=2,marker="None",label="salida")
#xlabel(L"$t$")
axis("tight")
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
ylim((-1,3))
savefig("filtro_adaptado1.eps")

# plot segundo conjunto
#-------------------------------------------------------------------------
fig = figure(figsize=(10,10))
ax = gca()
p = plot(s2a(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="senial enviada")
p = plot(s2b(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="segunda senial")
p = plot(h₂(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="respuesta del filtro")
p = plot(ŝ₂,linestyle="-",linewidth=2,marker="None",label="salida")
#xlabel(L"$t$")
axis("tight")
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
ylim((-1,3))
savefig("filtro_adaptado2.eps")

# plot tercer conjunto
#-------------------------------------------------------------------------
fig = figure(figsize=(10,10))
ax = gca()
p = plot(s3a(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="senial enviada")
p = plot(s3b(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="segunda senial")
p = plot(h₃(t, 2, 1),linestyle="-",linewidth=2,marker="None",label="respuesta del filtro")
p = plot(ŝ₃,linestyle="-",linewidth=2,marker="None",label="salida")
#xlabel(L"$t$")
axis("tight")
title("Comparacion de seniales")
grid("on")
legend(loc="upper right",fancybox="true") 
ylim((-1,3))
savefig("filtro_adaptado3.eps")
