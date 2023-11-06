"""
# module EigenvalueProblems



# Examples

```jldoctest
julia>
```
"""
module EigenvalueProblems

using StaticArrays: SVector

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

struct InternalProblem{N,G,S,Y,X}
    g::SVector{N,G}
    s::SVector{N,S}
    y::SVector{2,Y}
    x::SVector{N,X}
end
function InternalProblem(problem::Problem)
    𝐱 = range(0; length=problem.n, step=problem.h)
    𝐠 = if problem.g isa AbstractArray || problem.g isa Tuple
        problem.g
    else
        problem.g.(𝐱)
    end
    𝐬 = if problem.s isa AbstractArray || problem.s isa Tuple
        problem.s
    else
        problem.s.(𝐱)
    end
    if size(𝐠) == size(𝐬) == size(𝐱)
        return InternalProblem(𝐠, 𝐬, SVector(problem.bc.y₀, problem.bc.y₁), 𝐱)
    else
        throw(DimensionMismatch("the length of `g` and `s` must be `n`!"))
    end
end

include("NumerovIntegrator.jl")
include("ShootingMethod.jl")

end
