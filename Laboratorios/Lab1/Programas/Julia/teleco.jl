#! /usr/bin/env julia

# Funcion para calcular las probabilidades de ocurrencia de cada simbolo existente en 
# una fuente de informacion

function probabilidad_txt(T::UTF8String)
    # Compute the probabilities of letters
    d = Dict{Char, FloatingPoint}()
    prob = [length(find(T.data .== letter)) for letter in Set(T.data)] / (length(T.data))
    d = {letter => i for i in prob, letter in Set(T)}
     
    return d,prob

end


