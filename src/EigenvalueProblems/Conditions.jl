"""
# module Conditions



# Examples

```jldoctest
julia>
```
"""
module Conditions

export InitialCondition,
    BoundaryCondition

struct InitialCondition
    y0::Real
    yd0::Real
end

struct BoundaryCondition
    y0::Real
    y1::Real
end

end
