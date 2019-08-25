"""
# module NumerovMethod



# Examples

```jldoctest
julia>
```
"""
module NumerovMethod

using NumericalMethodsInQuantumMechanics.EigenvalueProblems.Conditions

export numerov_iter, integrate

"""
    numerov_iter(y_prev, y, dx, gvec, svec)

Return the next step for the Numerov's method, given the current and previous step. See the [Numerov's method](@ref)
documentation for more information.

# Arguments
- `y_prev::Real`: the `y[n - 1]` element.
- `y::Real`: the `y[n]` element.
- `dx::Real`: the step length ``h``, need to be small.
- `gvec::AbstractArray{<:Real}`: stores `g[n - 1]`, `g[n]` and `g[n + 1]`.
- `svec::AbstractArray{<:Real}`: stores `s[n - 1]`, `s[n]` and `s[n + 1]`.
"""
function numerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<:Real}, svec::AbstractArray{<:Real})
    length(gvec) == length(svec) == 3 || error("Dimension must be 3!")
    g_prev, g, g_next = gvec
    s_prev, s, s_next = svec
    y_prev_coeff = -(1 + dx^2 / 12 * g_prev)
    y_coeff = 2(1 - 5dx^2 / 12 * g)
    y_next_coeff = 1 + dx^2 / 12 * g_next
    s_coeff = dx^2 / 12 * (s_prev + 10s + s_next)
    return (y_coeff * y + y_prev_coeff * y_prev) / y_next_coeff
end  # function numerov_method_iter
"""
    numerov_iter(y_prev, y, dx, gvec)

Same as `numerov_iter(y_prev, y, dx, gvec, svec)`, if ``s(x) ≡ 0`` on the domain.

# Arguments
- `y_prev::Real`: the `y[n - 1]` element.
- `y::Real`: the `y[n]` element.
- `dx::Real`: the step length, need to be small.
- `gvec::AbstractArray{<:Real}`: stores `g[n - 1]`, `g[n]` and `g[n + 1]`.
"""
function numerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<:Real})
    return 2(12 - 5dx^2 * gvec[2]) / (12 + dx^2 * gvec[3]) * y - y_prev
end  # function numerov_iter

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
function integrate(
    ic::InitialCondition,
    r::AbstractRange{<:Real},
    gvec::AbstractArray{<:Real},
    svec::AbstractArray{<:Real}
)
    y0, yd0 = ic
    dx = step(r)
    y = [y0, yd0 * dx]
    for i = 1:(length(r)-2)
        y_next = numerov_iter(y[i], y[i+1], dx, gvec[i:(i+2)], svec[i:(i+2)])
        push!(y, y_next)
    end
    return y
end  # function integrate
"""
    integrate(ic, r, g, s)

Same as `integrate(ic, r, gvec, svec)`, but `g` and `s` are two functions.

# Arguments
- `ic::InitialCondition`: the initial condition ``y(x_0) = y_0`` and ``y'(x_0) = y_0'``, could be a guess.
- `r::AbstractRange{<:Real}`: a range, the domain ``x``.
- `g::Function`: the function ``g``.
- `s::Function`: the function ``s``.
"""
function integrate(ic::InitialCondition, r::AbstractRange{<:Real}, g::Function, s::Function)
    gvec, svec = map(g, r), map(s, r)
    return integrate(ic, r, gvec, svec)
end  # function integrate

end
