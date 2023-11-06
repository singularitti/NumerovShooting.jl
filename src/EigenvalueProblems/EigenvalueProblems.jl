"""
# module EigenvalueProblems



# Examples

```jldoctest
julia>
```
"""
module EigenvalueProblems

export InitialCondition, BoundaryCondition

struct InitialCondition{Y,Y′}
    y₀::Y
    y′₀::Y′
end

abstract type BoundaryCondition end
struct DirichletBoundaryCondition{T} <: BoundaryCondition
    y₀::T
    y₁::T
end

struct Problem{G,S,T,H}
    g::G
    s::S
    bc::DirichletBoundaryCondition{T}
    n::Int64
    h::H
end

include("NumerovIntegrator.jl")
include("ShootingMethod.jl")

end
