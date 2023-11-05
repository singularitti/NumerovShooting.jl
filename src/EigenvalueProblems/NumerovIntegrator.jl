"""
# module NumerovIntegrator



# Examples

```jldoctest
julia>
```
"""
module NumerovIntegrator

using NumericalMethodsInQuantumMechanics.EigenvalueProblems: InitialCondition

export integrate

abstract type Integrator end

struct NumerovStep{Y,G,S,H} <: Integrator
    y::NTuple{2,Y}
    g::NTuple{3,G}
    s::NTuple{3,S}
    h::H
end
NumerovStep(y, g, s, h) = NumerovStep(Tuple(y), Tuple(g), Tuple(s), h)
function NumerovStep(y::Function, g::Function, s::Function, x)
    h = unique(diff(collect(x)))
    @assert length(h) == 1 "the step length of `x` must be the same!"
    return NumerovStep(y.(x), g.(x), s.(x), only(h))
end

function integrate(step::NumerovStep)
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

struct NumerovIterator{N,Y,G,S,H} <: Integrator
    y::NTuple{2,Y}
    g::NTuple{N,G}
    s::NTuple{N,S}
    h::H
end

# See https://github.com/singularitti/Fibonacci.jl/blob/4f1292a/src/Fibonacci.jl#L44-L57
Base.iterate(iter::NumerovIterator) = (last(iter.y), (iter.y, 2))
function Base.iterate(iter::NumerovIterator, ((yᵢ₋₂, yᵢ₋₁), i))
    if i > length(iter.g)
        return nothing
    else
        yᵢ = integrate(
            NumerovStep(
                (yᵢ₋₂, yᵢ₋₁),
                (iter.g[i - 2], iter.g[i - 1], iter.g[i]),
                (iter.s[i - 2], iter.s[i - 1], iter.s[i]),
                iter.h,
            ),
        )
        return yᵢ, ((yᵢ₋₁, yᵢ), i + 1)
    end
end

Base.eltype(::Type{NumerovIterator{N,Y}}) where {N,Y} = Y

Base.length(iter::NumerovIterator) = length(iter.g)

"""
    numerov_iter(y_prev, y, dx, gvec, svec)

Return the ``y[n + 1]`` step for the Numerov's method, given the current and previous step.

# Arguments
- `y_prev::Real`: the `y[n - 1]` element.
- `y::Real`: the `y[n]` element.
- `dx::Real`: the step length ``h``, need to be small.
- `gvec::AbstractArray{<:Real}`: stores `g[n - 1]`, `g[n]` and `g[n + 1]`.
- `svec::AbstractArray{<:Real}`: stores `s[n - 1]`, `s[n]` and `s[n + 1]`.
"""
"""
    numerov_iter(y_prev, y, dx, gvec)

Same as `numerov_iter(y_prev, y, dx, gvec, svec)`, if ``s(x) ≡ 0`` on the domain.

# Arguments
- `y_prev::Real`: the `y[n - 1]` element.
- `y::Real`: the `y[n]` element.
- `dx::Real`: the step length, need to be small.
- `gvec::AbstractArray{<:Real}`: stores `g[n - 1]`, `g[n]` and `g[n + 1]`.
"""

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
function integrate(gvec, svec, ic::InitialCondition)
    if length(gvec) != length(svec)
        throw(DimensionMismatch("Integ"))
    end
    N = length(gvec)
    dx = inv(N)
    ϕ₀, ϕ′₀ = ic
    ϕ = [ϕ₀, ϕ′₀ * dx]  # ϕ₀, ϕ₁
    for i in 1:(N - 2)
        ϕᵢ₊₂ = iter(ϕ[i], ϕ[i + 1], dx, gvec[i:(i + 2)], svec[i:(i + 2)])
        push!(ϕ, ϕᵢ₊₂)
    end
    return ϕ
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
function integrate(g::Function, s::Function, ic::InitialCondition, dx)
    vec = 0:dx:1
    gvec, svec = map(g, vec), map(s, vec)
    return integrate(gvec, svec, ic)
end

end
