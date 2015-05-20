# Modulo para el laboratorio1:Teoria de las telecomunicaciones
module Teleco
    

function probs(iter)
    # Funcion para calcular las probabilidades de ocurrencia de cada simbolo
    # en una fuente de informacion discreta sin memoria.
    # Input:
    # -----
    # iter: Cualquier fuente iterable(texto,vectores...etc) 
    # Output:
    # ------
    # d: Diccionario con los elementos de la fuente y sus frecuencias
    # p: Vector de probabilidades

    d = Dict{eltype(iter), Int}()
    l = length(iter)
    
    for e in iter
        d[e] = get(d, e, 0) + 1 
    end
    p = collect((values(d))) / l 
    return d,p
end

function freqs_pr(iter)
    # Funcion para calcular 
    pr = Collections.PriorityQueue()
    
    for e in iter
        pr["$e"] = get(pr, "$e", 0) + 1 
    end
    
    return pr
end


function entropy(p)
   # Funcion para calcular la entropia de una 
   # fuente discreta sin memoria
   # Input:
   # -----
   # p: Vector de probabilidades de la fuente
   # Output:
   # ------
   # h: Entropia de la fuente
    i = log2(1./p)
    aux = p.*i
    h = sum(aux)
    
    return h

end

function show_source(d)
    # Funcion para mostrar los elementos de una fuente 
    # y su frecuencia de aparicion
    for (v,k) in zip(values(d),keys(d))
        println("elemento: $k --> frecuencia: $v")
    end
end    

export probs, probs_pr,entropy, show_source


end
