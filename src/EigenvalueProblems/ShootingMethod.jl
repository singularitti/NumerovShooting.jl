"""
# module ShootingMethod



# Examples

```jldoctest
julia>
```
"""
module ShootingMethod

using Roots: find_zero, AbstractUnivariateZeroMethod

using NumericalMethodsInQuantumMechanics.EigenvalueProblems:
    InitialCondition, BoundaryCondition
using NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod: integrate

export shoot

# last means ``y(t1)``, `ic` contains a guess, `bc[2]` is ``y1``.
# `last(integrate(ic_guess, r, g, s)) - bc[2]` means ``y(t1; yd0) - y1``.
function shoot(bc::BoundaryCondition, g, s, init, args...)
    f = guess -> last(integrate(InitialCondition(bc.y0, guess), g, s, args...)) - bc.y1
    # `x` of the root finding is `y′0`.
    return find_zero(f, init)
end

end
