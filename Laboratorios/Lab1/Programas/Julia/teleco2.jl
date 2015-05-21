# modulo para el problema 4 
module Teleco2

function set_sin(N::Number,fs::Number,f::Number)
    # funcion para generar una senial sinoidal
    # Inputs:
    # ------
    # N: numero de muestras
    # fs: frecuencia de muestreo 
    # f: frecuencia de la senial 
    # Outputs:
    # -------
    # t: vector de tiepos
    # x: senial generada

    ts = 1/fs
    t = ts .* [0:N-1]
    x = sin(2*π*f*t); # senial

    return x,t
end
function unifor_quatization(x::AbstractArray,N::Int)
    # funcion para cuantizar uniformente una senial
    # Inputs:
    # ------
    # x: senial de entrada
    # N: Niveles de cuantizacion
    # Output:
    # ------
    # x_q: senial quantizada

    mag_max = maximum(abs(x))
    x_max = mag_max; x_min = -mag_max;
    q = (x_max - x_min)/N;

    x_q = floor((x-x_min)/q) * q + q/2 +x_min;

    return x_q
end



export unifor_quatization,set_sin
    
end
