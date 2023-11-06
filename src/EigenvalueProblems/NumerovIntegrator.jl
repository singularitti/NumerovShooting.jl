"""
# module NumerovIntegrator



# Examples

```jldoctest
julia>
```
"""
module NumerovIntegrator

using NumericalMethodsInQuantumMechanics.EigenvalueProblems: InitialCondition
using OffsetArrays: Origin, OffsetVector

export Numerov, integrate, eachstep

abstract type Integrator end
struct Numerov <: Integrator end

struct NumerovStep{Y,G,S,H}
    y::NTuple{2,Y}
    g::NTuple{3,G}
    s::NTuple{3,S}
    h::H
end
NumerovStep(y, g, s, h) =
    NumerovStep{eltype(y),eltype(g),eltype(s),typeof(h)}(Tuple(y), Tuple(g), Tuple(s), h)
function NumerovStep(y::Function, g::Function, s::Function, x)
    h = unique(diff(collect(x)))
    @assert length(h) == 1 "the step length of `x` must be the same!"
    return NumerovStep(y.(x), g.(x), s.(x), only(h))
end

function evaluate(step::NumerovStep)
    yᵢ₋₁, yᵢ = step.y
    gᵢ₋₁, gᵢ, gᵢ₊₁ = step.g
    sᵢ₋₁, sᵢ, sᵢ₊₁ = step.s
    coeffᵢ₋₁ = -(1 + step.h^2 / 12 * gᵢ₋₁)
    coeffᵢ = 2(1 - 5step.h^2 / 12 * gᵢ)
    coeffᵢ₊₁ = 1 + step.h^2 / 12 * gᵢ₊₁
    s = step.h^2 / 12 * (sᵢ₋₁ + 10sᵢ + sᵢ₊₁)
    yᵢ₊₁ = (coeffᵢ * yᵢ + coeffᵢ₋₁ * yᵢ₋₁ + s) / coeffᵢ₊₁
    return yᵢ₊₁
end

struct NumerovIterator{Y,G,S,H} <: Integrator
    y::OffsetVector{Y,Vector{Y}}
    g::OffsetVector{G,Vector{G}}
    s::OffsetVector{S,Vector{S}}
    h::H
end
function NumerovIterator(y, g, s, h)
    if length(y) != 2
        throw(ArgumentError("the length of `y` must be 2!"))
    end
    if size(g) != size(s)
        throw(DimensionMismatch("the size of `g` and `s` must be the same!"))
    end
    if length(g) < 3
        throw(ArgumentError("the length of `g` and `s` must be greater than 3!"))
    end
    return NumerovIterator{eltype(y),eltype(g),eltype(s),typeof(h)}(
        Origin(0)(y), Origin(0)(g), Origin(0)(s), h
    )
end

# See https://github.com/singularitti/Fibonacci.jl/blob/4f1292a/src/Fibonacci.jl#L44-L57
Base.iterate(iter::NumerovIterator) = iter.y[0], (iter.y, 1)  # y₀, ((y₀, y₁), 1)
function Base.iterate(iter::NumerovIterator, ((yᵢ₋₁, yᵢ), i))
    if i > length(iter.g) - 2  # Minus 2 since we start the index from 0 & skip the first element of `y` (index=0)
        return nothing
    else
        yᵢ₊₁ = evaluate(
            NumerovStep(
                (yᵢ₋₁, yᵢ),
                (iter.g[i - 1], iter.g[i], iter.g[i + 1]),  # gᵢ₋₁, gᵢ, gᵢ₊₁
                (iter.s[i - 1], iter.s[i], iter.s[i + 1]),  # sᵢ₋₁, sᵢ, sᵢ₊₁
                iter.h,
            ),
        )
        return yᵢ, ((yᵢ, yᵢ₊₁), i + 1)
    end
end

Base.eltype(::Type{<:NumerovIterator{N,Y}}) where {N,Y} = Y

Base.length(iter::NumerovIterator) = length(iter.g)

eachstep(y, g, s, h) = NumerovIterator(y, g, s, h)

"""
    integrate(ic, r, gvec, svec)

Do the Numerov's method integration, return the solution ``y(x)``, given that ``g(x)`` and ``s(x)`` already
as vectors (already applied on ``x``).

# Arguments
- `ic::InitialCondition`: the initial condition ``y(x_0) = y_0`` and ``y'(x_0) = y_0'``, could be a guess.
- `r::AbstractRange{<:Real}`: a range, the domain ``x``.
- `gvec::AbstractArray{<:Real}`: the result of function ``g`` applied on ``x`` (range `r`).
- `svec::AbstractArray{<:Real}`: the result of function ``s`` applied on ``x`` (range `r`).
"""
function integrate(𝐠, 𝐬, ic::InitialCondition, h, ::Numerov)
    ϕ₀, ϕ′₀ = ic.y₀, ic.y′₀
    ϕ = [ϕ₀, ϕ′₀ * h]  # ϕ₀, ϕ₁
    return collect(NumerovIterator(ϕ, 𝐠, 𝐬, h))
end
"""
    integrate(ic, r, g, s)

Same as `integrate(ic, r, gvec, svec)`, but `g` and `s` are two functions.

# Arguments
- `ic::InitialCondition`: the initial condition ``y(x_0) = y_0`` and ``y'(x_0) = y_0'``, could be a guess.
- `r::AbstractRange{<:Real}`: a range, the domain ``x``.
- `g::Function`: the function ``g``.
- `s::Function`: the function ``s``.
"""
function integrate(g::Function, s::Function, ic::InitialCondition, h, ::Numerov)
    𝐱 = 0:h:1
    𝐠, 𝐬 = map(g, 𝐱), map(s, 𝐱)
    return integrate(𝐠, 𝐬, ic, h, Numerov())
end

end
