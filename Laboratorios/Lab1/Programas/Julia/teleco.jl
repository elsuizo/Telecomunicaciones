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

    d = Dict()
    d_floats = Dict()
    l = length(iter)

    for e in iter
        #d[e] = get(d, e, 0) + 1
        d["$e"] = get(d, "$e", 0) + 1
    end
    p = collect((values(d))) / l
    for (index,value) in enumerate(d)
       d_floats[value] = p[index]
    end

    return d_floats,p
end

function freqs_pr(iter)
    # Funcion para calcular
    pr = Collections.PriorityQueue()

    for e in iter
        pr["$e"] = get(pr, "$e", 0) + 1
    end

    return pr
end



function show_code(d)
    # Funcion para mostrar los elementos de una fuente 
    # y su codigo de Huffman
    for (v,k) in zip(values(d),keys(d))
        println("elemento: $k --> codigo: $v")
    end
end

function show_source(d)
    # Funcion para mostrar los elementos de una fuente 
    # y su frecuencia de aparicion
    for (v,k) in zip(values(d),keys(d))
        println("elemento: $k --> frecuencia: $v")
    end
end

#=------------------------------------------------------------------------------
                        Huffman 
------------------------------------------------------------------------------=#
# Devuelve el valor minimo de un Dict
function min_value(pd)
    runonce = false
    (kmin,cmin) = (nothing,nothing)

    for (k,v) in pd
        if( !runonce )
            runonce = true
            (kmin,cmin) = (k,v)
        elseif( v <= cmin)
            (kmin, cmin) = (k,v)
        end
    end

    return (kmin,cmin)
end

# Creamos el arbol de Huffman
function huffman_tree(pd; rounding = 5)
   huffman = copy(pd)

   while(length(huffman) > 1)
     cum_prob = 0.0
     pair = Dict()
     
     m = (k,v) = min_value(huffman) 
     push!(pair,k,v) 
     cum_prob += pop!(huffman, k)
     
     m = (k,v) = min_value(huffman)
     push!(pair,k,v) 
     cum_prob += pop!(huffman, k)
     
     push!(huffman, pair, round(cum_prob,rounding))
   end

   return huffman
end

# A partir del arbol creamos el codigo
function huffman_code(huff_tree; rounding = 5)
   huff_code = copy(huff_tree)
   top = collect(keys(huff_code))[1]
   huff_code[top] = ""

   while(sum(map((x)->(isa(x,Dict)), collect(keys(huff_code)))) > 0)
     for (k,c) in huff_code
         if(isa(k,Dict))
             kz = collect(keys(k))
             push!(huff_code, kz[1], c*"0")
             push!(huff_code, kz[2], c*"1")
             pop!(huff_code,k) 
         end
     end
   end

   return huff_code
end


function entropy(pd::Dict{Any,Any})
   h = 0.0
   for (s_i, p_i) in pd
     h += (p_i * log2(1.0/p_i))
   end

   return h
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

function L̄(c::Dict{Any,Any}, d::Dict{Any,Any}) 
   new = Dict()
   l = 0.0
   for (k, v) in zip(values(c), values(d))
      new[k] = v 
   end

   for (s_i,p_i) in new
   l += (p_i * length(s_i))
   end
      
   return l
end


export probs, probs_pr,entropy, show_source, huffman_tree, huffman_code, L̄


end
