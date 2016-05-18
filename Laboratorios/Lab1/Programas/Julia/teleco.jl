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
    #d_floats = Dict{eltype(iter), AbstractFloat}()
    l = length(iter)

    for e in iter
        d[e] = get(d, e, 0) + 1
    end
    p = collect((values(d))) / l
    #for (k,v) in d
    #   d_floats[k] = p[v]
    #end

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
    i = log2(1. / p)
    aux = p .* i
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

#=------------------------------------------------------------------------------
                        Huffmann stuff
------------------------------------------------------------------------------=#

#=------------------------------------------------------------------------------
                        como el de Python
------------------------------------------------------------------------------=#
function encode(freqs)


end




#=------------------------------------------------------------------------------
                        como el de Rosetta
------------------------------------------------------------------------------=#
# returns the least value of dictionary enteries
function minvalue(pd)
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

function huffmanTree(pd)
    huffman_tree = copy(pd)
    #@show huffman_tree

    while(length(huffman_tree) > 1)
        cmb_prob = 0
        pair = Dict()

        #get first new item
        m = (k,v) = minimum(huffman_tree) # get the smallest value form the huffman tree
        #@show m
        #push!(pair,k,v)
        setindex!(pair,k,v)
        cmb_prob += pop!(huffman_tree,k)

        m = (k,v) = minimum(huffman_tree) # get the smallest value form the huffman tree
        @show pair
        setindex!(pair,v,k)
        cmb_prob += pop!(huffman_tree,k)

        #push!(huffman_tree,pair,round(cmb_prob,rounding))
        setindex!(huffman_tree,pair, cmb_prob)
    end

    return huffman_tree
end

# given a huffman tree create a huffman code
function huffmanCode( huff_tree; rounding = 5)
    huff_code = copy(huff_tree)
    # set the first node to the empty string which will let the coding propagate down the tree
    top = collect(keys(huff_code))[1]
    huff_code[top] = ""

    while( sum(map((x)->(isa(x,Dict)), collect(keys(huff_code)))) > 0)
        # this is complicated way of asking "Are there any Dictionaries left?", which is
        # equivalent to the question "Are all the letters encoded?"
        for (k,c) in huff_code
            if( isa(k,Dict) )
                kz = collect(keys(k))
                push!(huff_code, kz[1], c*"0")
                push!(huff_code, kz[2], c*"1")
                pop!(huff_code,k) # remove the node, leaving the lower nodes
            end
        end
    end

    return huff_code
 end


export probs, probs_pr,entropy, show_source


end
