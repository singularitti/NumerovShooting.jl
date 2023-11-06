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
struct DirichletBoundaryCondition{S,T} <: BoundaryCondition
    y₀::S
    y₁::T
end

include("NumerovIntegrator.jl")
include("ShootingMethod.jl")

end
