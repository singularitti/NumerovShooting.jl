"""
# module EigenvalueProblems



# Examples

```jldoctest
julia>
```
"""
module EigenvalueProblems

using OffsetArrays: Origin, OffsetVector
using StaticArrays: SVector

export InitialCondition, DirichletBoundaryCondition, Problem, expand

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
function InternalProblem(𝐠, 𝐬, 𝐲, 𝐱)
    if size(𝐠) == size(𝐬) == size(𝐱)
        return InternalProblem{length(𝐱),eltype(𝐠),eltype(𝐬),eltype(𝐲),eltype(𝐱)}(
            𝐠, 𝐬, 𝐲, 𝐱
        )
    else
        throw(DimensionMismatch("the length of `𝐠`, `𝐬`, and `𝐱` must be the same!"))
    end
end
function InternalProblem(problem::Problem)
    𝐱 = range(zero(problem.h); length=problem.n + 1, step=problem.h)
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
    𝐲 = SVector(problem.bc.y₀, problem.bc.y₁)
    return InternalProblem(𝐠, 𝐬, 𝐲, 𝐱)
end

expand(problem::Problem) = InternalProblem(problem)

function solve end

include("NumerovIntegrator.jl")
include("ShootingMethod.jl")

end
