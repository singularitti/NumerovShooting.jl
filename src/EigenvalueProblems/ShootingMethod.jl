"""
# module ShootingMethod



# Examples

```jldoctest
julia>
```
"""
module ShootingMethod

using Roots: find_zero, Bisection

using NumericalMethodsInQuantumMechanics.EigenvalueProblems.Conditions
using NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod

export generate_initial_condition,
    generate_problem,
    shoot

generate_initial_condition(bc::BoundaryCondition{T}, guess::T) where {T} = InitialCondition(bc[1], guess)

function generate_problem(bc::BoundaryCondition, r, g, s)
    function (guess)
        # last means ``y(t1)``, `ic` contains `yd0`, which is a guess, `bc[2]` is ``y1``.
        # `last(integrate(ic_guess, r, g, s))` means `y(t1; yd0) - y1`
        return last(integrate(generate_initial_condition(bc, guess), r, g, s)) - bc[2]
    end
end  # function generate_f

function shoot(f::Function, r::AbstractRange)::Real
    # `x` of the root finding is `yd0`.
    return find_zero(f, (minimum(r), maximum(r)), Bisection())
end  # function shoot

end
