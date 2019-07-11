"""
# module NumerovMethod



# Examples

```jldoctest
julia>
```
"""
module NumerovMethod

export numerov_iter,
    integrate

function numerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<: Real}, svec::AbstractArray{<: Real})
    length(gvec) == length(svec) = 3 || error("Dimension must be 3!")
    g_prev, g, g_next = gvec
    s_prev, s, s_next = svec
    y_prev_coeff = -(1 + dx^2 / 12 * g_prev)
    y_coeff = 2(1 - 5dx^2 / 12 * g)
    y_next_coeff = 1 + dx^2 / 12 * g_next
    s_coeff = dx^2 / 12 * (s_prev + 10s + s_next)
    return (y_coeff * y + y_prev_coeff * y_prev) / y_next_coeff
end  # function numerov_method_iter
function numerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<: Real})
    return 2(12 - 5dx^2 * gvec[2]) / (12 + dx^2 * gvec[3]) * y - y_prev
end  # function numerov_iter

function integrate(y0::Real, yd0::Real, r::AbstractRange{<: Real}, gvec::AbstractArray{<: Real}, svec::AbstractArray{<: Real})
    dx = step(r)
    y = [y0, yd0 * dx]
    for i in eachindex(r)
        y_next = numerov_iter(y[i], y[i + 1], dx, gvec[i:(i + 2)], svec[i:(i + 2)])
        push!(y, y_next)
    end
    return y
end  # function integrate
function integrate(y0::Real, yd0::Real, r::AbstractRange{<: Real}, g::Function, s::Function)
    gvec, svec = map(g, r), map(s, r)
    return integrate(y0, yd0, r, gvec, svec)
end  # function integrate

end
