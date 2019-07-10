using Documenter, GitHubJuliaMITTemplate

makedocs(;
    modules=[GitHubJuliaMITTemplate],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/singularitti/GitHubJuliaMITTemplate.jl/blob/{commit}{path}#L{line}",
    sitename="GitHubJuliaMITTemplate.jl",
    authors="Qi Zhang <singularitti@outlook.com>",
    assets=String[],
)

deploydocs(;
    repo="github.com/singularitti/GitHubJuliaMITTemplate.jl",
)
