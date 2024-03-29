using Roots: AbstractNonBracketingMethod, find_zero

export shoot

function shoot(problem::Problem, g₀_init, method::AbstractNonBracketingMethod)
    function f(g₀)
        problem = Problem(
            Returns(g₀), problem.s, problem.bc, problem.ic, problem.n, problem.h
        )
        return last(solve(problem, Numerov())) - problem.bc.y₁
    end
    return find_zero(f, g₀_init, method)
end
