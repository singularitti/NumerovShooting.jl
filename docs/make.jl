using Documenter, NumericalMethodsInQuantumMechanics

makedocs(;
    modules=[NumericalMethodsInQuantumMechanics],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/singularitti/NumericalMethodsInQuantumMechanics.jl/blob/{commit}{path}#L{line}",
    sitename="NumericalMethodsInQuantumMechanics.jl",
    authors="Qi Zhang <singularitti@outlook.com>",
    assets=String[],
)

deploydocs(;
    repo="github.com/singularitti/NumericalMethodsInQuantumMechanics.jl",
    devbranch = "develop",
    devurl = "dev",
)
