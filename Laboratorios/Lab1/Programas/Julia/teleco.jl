module Teleco

type DiscretSource
    source :: UTF8String
    entropy :: Float64
    code :: Dict
    probs :: Vector
end

    
    
# Funcion para calcular las probabilidades de ocurrencia de cada simbolo existente en 
# una fuente de informacion

function probs_letters(ds::DiscretSource)
    # Compute the probabilities of letters
    d = Dict{Char, Float64}()
    prob = [length(find(ds.source.data .== letter)) for letter in Set(ds.source.data)] / (length(ds.source.data))
    d = {letter => i for i in prob, letter in Set(ds.source.data)}
     
    return d,prob

end

function information(ds::DiscretSource)

    i = log2(1 ./ ds.probs)
    return i
end

#function entropia(d)
export probs_letters, information, DiscretSource
end    

#export probabilidad_txt, informacion
#end


