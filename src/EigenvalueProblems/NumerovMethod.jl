"""
# module NumerovMethod



# Examples

```jldoctest
julia>
```
"""
module NumerovMethod

function numerov_iter(y_prev::Real, y::Real, h::Real, gvec::AbstractArray{<: Real}, svec::AbstractArray{<: Real})
    g_prev, g, g_next = gvec
    s_prev, s, s_next = svec
    y_prev_coeff = -(1 + h^2 / 12 * g_prev)
    y_coeff = 2(1 - 5h^2 / 12 * g)
    y_next_coeff = 1 + h^2 / 12 * g_next
    s_coeff = h^2 / 12 * (s_prev + 10s + s_next)
    (y_coeff * y + y_prev_coeff * y_prev) / y_next_coeff
end  # function numerov_method_iter
function numerov_iter(y_prev::Real, y::Real, h::Real, gvec::AbstractArray{<: Real})
    2(12 - 5h^2 * gvec[2]) / (12 + h^2 * gvec[3]) * y - y_prev
end  # function numerov_iter

end
