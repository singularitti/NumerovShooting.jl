using NumerovShooting
using Documenter

DocMeta.setdocmeta!(NumerovShooting, :DocTestSetup, :(using NumerovShooting); recursive=true)

makedocs(;
    modules=[NumerovShooting],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/singularitti/NumerovShooting.jl/blob/{commit}{path}#{line}",
    sitename="NumerovShooting.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
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
