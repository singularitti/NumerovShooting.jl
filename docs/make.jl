using NumericalMethodsInQuantumMechanics
using Documenter

DocMeta.setdocmeta!(NumericalMethodsInQuantumMechanics, :DocTestSetup, :(using NumericalMethodsInQuantumMechanics); recursive=true)

makedocs(;
    modules=[NumericalMethodsInQuantumMechanics],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/singularitti/NumericalMethodsInQuantumMechanics.jl/blob/{commit}{path}#{line}",
    sitename="NumericalMethodsInQuantumMechanics.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://singularitti.github.io/NumericalMethodsInQuantumMechanics.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/singularitti/NumericalMethodsInQuantumMechanics.jl",
    devbranch="main",
)
