using NumerovShooting
using Documenter

DocMeta.setdocmeta!(NumerovShooting, :DocTestSetup, :(using NumerovShooting); recursive=true)

makedocs(;
    modules=[NumerovShooting],
    authors="singularitti <singularitti@outlook.com> and contributors",
    sitename="NumerovShooting.jl",
    format=Documenter.HTML(;
        canonical="https://singularitti.github.io/NumerovShooting.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/singularitti/NumerovShooting.jl",
    devbranch="main",
)
