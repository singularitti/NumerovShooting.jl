"""
# module NumerovIntegrator



# Examples

```jldoctest
julia>
```
"""
module NumerovIntegrator

using NumericalMethodsInQuantumMechanics.EigenvalueProblems:
    InitialCondition, InternalProblem
using OffsetArrays: Origin, OffsetVector
using StaticArrays: SVector

export Numerov, integrate

abstract type Integrator end
struct Numerov <: Integrator end

struct NumerovStep{G,S,Y,H}
    g::SVector{3,G}
    s::SVector{3,S}
    y::SVector{2,Y}
    h::H
end
NumerovStep(g, s, y, h) = NumerovStep(SVector{3}(g), SVector{3}(s), SVector{2}(y), h)

function evaluate(step::NumerovStep)
    gᵢ₋₁, gᵢ, gᵢ₊₁ = step.g
    sᵢ₋₁, sᵢ, sᵢ₊₁ = step.s
    yᵢ₋₁, yᵢ = step.y
    cᵢ₋₁ = -(1 + step.h^2 / 12 * gᵢ₋₁)
    cᵢ = 2(1 - 5step.h^2 / 12 * gᵢ)
    cᵢ₊₁ = 1 + step.h^2 / 12 * gᵢ₊₁
    s = step.h^2 / 12 * (sᵢ₋₁ + 10sᵢ + sᵢ₊₁)
    yᵢ₊₁ = (cᵢ * yᵢ + cᵢ₋₁ * yᵢ₋₁ + s) / cᵢ₊₁
    return yᵢ₊₁
end

struct NumerovIterator{N,G,S,Y,X} <: Integrator
    g::OffsetVector{G,SVector{N,G}}
    s::OffsetVector{S,SVector{N,S}}
    y::OffsetVector{Y,SVector{2,Y}}
    x::OffsetVector{X,SVector{N,X}}
end
function NumerovIterator(𝐠, 𝐬, 𝐲, 𝐱)
    𝐠 = Origin(0)(SVector{length(𝐠)}(𝐠))
    𝐬 = Origin(0)(SVector{length(𝐬)}(𝐬))
    𝐲 = Origin(0)(SVector{2}(𝐲))
    𝐱 = Origin(0)(SVector{length(𝐱)}(𝐱))
    return NumerovIterator(𝐠, 𝐬, 𝐲, 𝐱)
end

# See https://github.com/singularitti/Fibonacci.jl/blob/4f1292a/src/Fibonacci.jl#L44-L57
# See https://en.wikipedia.org/wiki/Numerov%27s_method#The_method
Base.iterate(iter::NumerovIterator) = iter.y[0], (iter.y, 1)  # y₀, ((y₀, y₁), 1)
function Base.iterate(iter::NumerovIterator, ((yᵢ₋₁, yᵢ), i))
    if i > length(iter.g) - 2  # Minus 2 since we start the index from 0 & skip the first element of `y` (index=0)
        return nothing
    else
        yᵢ₊₁ = evaluate(
            NumerovStep(
                (iter.g[i - 1], iter.g[i], iter.g[i + 1]),  # gᵢ₋₁, gᵢ, gᵢ₊₁
                (iter.s[i - 1], iter.s[i], iter.s[i + 1]),  # sᵢ₋₁, sᵢ, sᵢ₊₁
                (yᵢ₋₁, yᵢ),
                iter.x[i + 1] - iter.x[i],
            ),
        )
        return yᵢ, ((yᵢ, yᵢ₊₁), i + 1)
    end
end

Base.eltype(::Type{NumerovIterator{N,G,S,Y,X}}) where {N,G,S,Y,X} = Y

Base.length(::NumerovIterator{N}) where {N} = N

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
integrate(𝐠, 𝐬, 𝐲, 𝐱, y′₀, ::Numerov) =
    NumerovIterator(𝐠, 𝐬, (first(𝐲), y′₀ * first(diff(𝐱))), 𝐱)
integrate(problem::InternalProblem, y′₀, ::Numerov) =
    integrate(problem.g, problem.s, problem.y, problem.x, y′₀, Numerov())

end
