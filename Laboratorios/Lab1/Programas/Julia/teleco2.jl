# modulo para el problema 4 
module Teleco2

function set_sin(N::Int, fs::Number, f::Number)
    # funcion para generar una senial sinoidal
    # Inputs:
    # ------
    # N: numero de muestras(numero entero)
    # fs: frecuencia de muestreo(numero real) 
    # f: frecuencia de la senial(numero real)
    # Outputs:
    # -------
    # t: vector de tiempos(Array)
    # x: senial generada(Array)

    ts = 1/fs
    t = ts .* [0:N-1]
    x = sin(2*π*f*t); # senial

    return x,t
end

function unifor_quatization(x::AbstractArray, N::Int)
    # funcion para cuantizar uniformente una senial
    # Inputs:
    # ------
    # x: senial de entrada(Array)
    # N: niveles de cuantizacion(numero entero)
    # Output:
    # ------
    # x_q: senial quantizada(Array)

    mag_max = maximum(abs(x))
    x_max = mag_max; x_min = -mag_max;
    q = (x_max - x_min)/N;

    x_q = floor((x-x_min)/q) * q + q/2 +x_min;

    return x_q
end

function μ_quantization(x::AbstractArray, N::Int, μ::Int)
    # funcion para cuantizar mediante la ley-mu
    # Inputs:
    # ------
    # x: senial de entrada(Array)
    # N: niveles de cuantizacion(numero entero)
    # μ: parametro(Numero real)
    # Output:
    # ------
    # x_μ: senial cuantizada

    mag_max = maximum(abs(x))
    x_max = mag_max; x_min = -mag_max;
    q = (x_max - x_min)/N;

    y = x_max*log10(1+abs(x)*(μ / x_max))/log10(1+μ);

    y_μ = floor((y-x_min)/q)*q+q/2+x_min;

    x_μ = (x_max/μ)*(10.^((log10(1+μ)/x_max)*y_μ)-1).*sign(x);


   return x_μ
end


#s1a(t, T, A) = A * (0 .< t .< T/2)
#h(t, T, A) = s1a(T-t, T, A)
export unifor_quatization,set_sin, heaviside, interval

end
