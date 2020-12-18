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
using NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod

export setup_problem, shoot

# last means ``y(t1)``, `ic` contains a guess, `bc[2]` is ``y1``.
# `last(integrate(ic_guess, r, g, s)) - bc[2]` means ``y(t1; yd0) - y1``.
setup_problem(bc::BoundaryCondition, r, g, s) =
    guess -> last(integrate(InitialCondition(bc.y0, guess), r, g, s)) - bc.y1

# `x` of the root finding is `y′0`.
shoot(f, method::AbstractUnivariateZeroMethod, r) =
    find_zero(f, (minimum(r), maximum(r)), method)

end
