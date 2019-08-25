# This simulation is referenced from
# [《量子力学本征值问题的数值方法——打靶法与Numerov方法》](https://zhuanlan.zhihu.com/p/59099100).
using LinearAlgebra: dot

using Roots
using SpecialMatrices: Strang

using NumericalMethodsInQuantumMechanics.EigenvalueProblems.Conditions
using NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod
using NumericalMethodsInQuantumMechanics.EigenvalueProblems.ShootingMethod

x = range(0; stop = 1, step = 0.002)
n = length(x)
g = zeros(n)
s = zeros(n)
problem = setup_problem(BoundaryCondition(0.0, 1.0), x, g, s)
yd0 = shoot(problem, Bisection(), [0, 1000])
ψ = integrate(InitialCondition(0.0, yd0), x, g, s)
e = dot(ψ, Strang(n) * ψ)
