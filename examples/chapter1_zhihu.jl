# This simulation is referenced from
# [《量子力学本征值问题的数值方法——打靶法与Numerov方法》](https://zhuanlan.zhihu.com/p/59099100).
using LinearAlgebra: normalize
using Plots
using Roots

using NumericalMethodsInQuantumMechanics.EigenvalueProblems
using NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovIntegrator
using NumericalMethodsInQuantumMechanics.EigenvalueProblems.ShootingMethod

PLOT_DEFAULTS = Dict(
    :size => (800, 450),
    :framestyle => :box,
    :linewidth => 1,
    :markersize => 2,
    :markerstrokewidth => 0,
    :minorticks => 5,
    :guidefontsize => 10,
    :tickfontsize => 8,
    :legendfontsize => 7,
    :left_margin => (3.5, :mm),
    :grid => nothing,
    :legend_foreground_color => nothing,
    :legend_background_color => nothing,
    :legend_position => :outertop,
    :legend_columns => 5,
    :background_color_inside => nothing,
)

dx = 0.002
x = range(0; stop=1, step=dx)
n = length(x)
s = zeros(n);
problem = Problem(identity, s, Dirichlet(0, 0), InitialCondition(0, 10), n, dx)
exact_energies = Tuple(n^2 * π^2 / 2 for n in 1:5)
energies = map(exact_energies) do g₀_init
    shoot(problem, 2g₀_init, Order5()) / 2
end
errors = abs.(energies .- exact_energies)
wavefuncs = map(energies) do energy
    eval = 2energy
    evec = normalize(
        solve(
            Problem(Returns(eval), s, Dirichlet(0, 0), InitialCondition(0, 10), n, dx),
            Numerov(),
        ),
    )
end
plt = plot(; PLOT_DEFAULTS...)
for (i, wavefunc) in enumerate(wavefuncs)
    plot!(plt, x, wavefunc; ylims=extrema(wavefunc), label="$(i)th wavefunc")
end
xlims!(plt, extrema(x))
display(plt)
