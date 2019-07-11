"""
# module InfinitePotentialWells



# Examples

```jldoctest
julia>
```
"""
module InfinitePotentialWells

export AbstractInfinitePotentialWell,
    InfiniteSquareWell,
    InfiniteSphericalWell

abstract type AbstractInfinitePotentialWell end

struct InfiniteSquareWell <: AbstractInfinitePotentialWell
    xmin::Real
    xmax::Real
end

struct InfiniteSphericalWell <: AbstractInfinitePotentialWell
    r::Real
end

end
