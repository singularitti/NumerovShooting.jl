"""
# module Conditions



# Examples

```jldoctest
julia>
```
"""
module Conditions

using StaticArrays: FieldVector

export InitialCondition, BoundaryCondition

struct InitialCondition{T} <: FieldVector{2,T}
    y0::T
    yd0::T
end
function InitialCondition(y0::Real, yd0::Real)
    T = Base.promote_typeof(y0, yd0)
    InitialCondition{T}(y0, yd0)
end

struct BoundaryCondition{T} <: FieldVector{2,T}
    y0::T
    y1::T
end
function BoundaryCondition(y0::Real, y1::Real)
    T = Base.promote_typeof(y0, y1)
    BoundaryCondition{T}(y0, y1)
end

end
