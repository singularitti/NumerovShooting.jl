"""
# module Conditions



# Examples

```jldoctest
julia>
```
"""
module Conditions

using StaticArrays: FieldVector

export InitialCondition,
    BoundaryCondition

struct InitialCondition{T} <: FieldVector{2, T}
    y0::T
    yd0::T
end
InitialCondition(y0::Real, yd0::Real) = InitialCondition(promote(y0, yd0)...)

struct BoundaryCondition{T} <: FieldVector{2, T}
    y0::T
    y1::T
end
BoundaryCondition(y0::Real, y1::Real) = BoundaryCondition(promote(y0, y1)...)

end
