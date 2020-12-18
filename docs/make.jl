using NumericalMethodsInQuantumMechanics
using Documenter

makedocs(;
    modules=[NumericalMethodsInQuantumMechanics],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/singularitti/NumericalMethodsInQuantumMechanics.jl/blob/{commit}{path}#L{line}",
    sitename="NumericalMethodsInQuantumMechanics.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://singularitti.github.io/NumericalMethodsInQuantumMechanics.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => Any[
            "EigenvalueProblems/NumerovMethod.md",
        ],
    ],
)

deploydocs(;
    repo="github.com/singularitti/NumericalMethodsInQuantumMechanics.jl",
)
