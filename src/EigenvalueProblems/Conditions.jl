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

struct BoundaryCondition{T} <: FieldVector{2, T}
    y0::T
    y1::T
end

end
