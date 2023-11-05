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
function iter(yᵢ₋₁, yᵢ, dx, gvec, svec)
    gᵢ₋₁, gᵢ, gᵢ₊₁ = gvec
    sᵢ₋₁, sᵢ, sᵢ₊₁ = svec
    coeffᵢ₋₁ = -(1 + dx^2 / 12 * gᵢ₋₁)
    coeffᵢ = 2(1 - 5dx^2 / 12 * gᵢ)
    coeffᵢ₊₁ = 1 + dx^2 / 12 * gᵢ₊₁
    coeff_sᵢ = dx^2 / 12 * (sᵢ₋₁ + 10sᵢ + sᵢ₊₁)
    return (coeffᵢ * yᵢ + coeffᵢ₋₁ * yᵢ₋₁) / coeffᵢ₊₁
end
"""
    numerov_iter(y_prev, y, dx, gvec)

Same as `numerov_iter(y_prev, y, dx, gvec, svec)`, if ``s(x) ≡ 0`` on the domain.

# Arguments
- `y_prev::Real`: the `y[n - 1]` element.
- `y::Real`: the `y[n]` element.
- `dx::Real`: the step length, need to be small.
- `gvec::AbstractArray{<:Real}`: stores `g[n - 1]`, `g[n]` and `g[n + 1]`.
"""
iter(yᵢ₋₁, yᵢ, dx, gvec) = 2(12 - 5dx^2 * gvec[2]) / (12 + dx^2 * gvec[3]) * yᵢ - yᵢ₋₁

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
