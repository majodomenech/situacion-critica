# dataCollapse.jl

# Libraries
using ForwardDiff : gradient

# Useful functions

function norm(v)
    sqrt.(sum(v.^2))
end

function horner(a,x)
    r = 0.0
    for i = length(a):-1:2
       r = x*(a[i]+r)
    end
    return a[1]+r
end

function hornerb(b,x)
    r = 0.0
    for i = length(b):-1:1
       r = x*(b[i]+r)
    end
    return 1+r
end


# To evaluate a Padé approximant, we need to construct a vector with a and b together

join_vectors(a,b) = vcat(a,b)

pade(p,x) = horner(p[1:length(a)],x)/hornerb(p[length(a)+1:end],x)

## Energy functions and gradient
"""
Esta función nos devuelve una nueva función E(p) y su gradiente ∇E, construida a partir de un conjunto de datos xdata,ydata
"""
function build_cost_function(xdata,ydata)
    E(p) = sum(( ((xx->pade(p,xx)).(xdata)) - ydata).^2)
    ∇E(p) = ForwardDiff.gradient(E,p)
    E,∇E
end

## Optimizers
"""
Descenso por gradiente tradicional
"""
function grad_descent(lr,p0,it=1000)
    p = p0
    i = 0
    @showprogress for i in 1:it
        grad = ∇E(p)
        grad /= norm(grad)
        p -= lr*grad
        i += 1
    end
    p
end

"""
Optimizador Adam, tal como está descrito en https://arxiv.org/abs/1412.6980

Los parámetros son α, β1 y β2 y ϵ que por defecto son los sugeridos en el paper:
    α = 1e-4
    β1 = 0.9
    β2 = 0.999
    ϵ = 1e-8
"""
function adam_optimizer(p0,α=1e-4,β1=0.9,β2=0.999,tolerance=1e-3,ϵ=1e-8)
    p = p0
    t = 1
    
    m = zeros(length(p0))
    v = zeros(length(p0))
    
    e0 = E(p)
    Δe = e0

    while Δe > tolerance
        grad = ∇E(p)
        
        m = (β1 * m) + (1-β1)*grad
        v = (β2 * v) + (1-β2)*(grad .^ 2)
        
        m_ = m/(1-β1^t)
        v_ = v/(1-β2^t)
        
        Δp = α * (m_./(sqrt.(v_) .+ ϵ))
        
        p-= Δp
        t += 1
        
        e1 = E(p)
       
        Δe = abs(e1 - e0)
        e0 = e1
    end
    println("The optimization has converged. Total iterations: $t")
    p
end