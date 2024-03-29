# Installation Guide

```@contents
Pages = ["installation.md"]
Depth = 2
```

Here are the installation instructions for package
[NumerovShooting](https://github.com/singularitti/NumerovShooting.jl).
If you have trouble installing it, please refer to our [Troubleshooting](@ref) page
for more information.

## Install Julia

First, you should install [Julia](https://julialang.org/). We recommend downloading it from
[its official website](https://julialang.org/downloads/).
The recommended way is to use a version manager
[Juliaup](https://github.com/JuliaLang/juliaup).

Install the latest Julia version by running this in your terminal:

```bash
curl -fsSL https://install.julialang.org | sh
```

on Unix-type systems. For Windows users, run

```bash
winget install julia -s msstore
```

Once installed, `julia` will be available via the command line interface. This will install
the Juliaup installation manager, which will automatically install Julia and help keep it up
to date. The command `juliaup` is also installed. To install different Julia versions see
`juliaup --help`.
There is a [short video introduction to Juliaup](https://youtu.be/14zfdbzq5BM)
made by its authors.

Please follow the detailed instructions on its website if you have to
[build Julia from source](https://docs.julialang.org/en/v1/devdocs/build/build/).
Some computing centers may have Julia preinstalled. Please contact your administrator for
more information in that case.
Additional information can be found here:
[how to set up Julia on HPC systems](https://juliahpc.github.io/JuliaOnHPCClusters/).

If you have [Homebrew](https://brew.sh) installed,
[open `Terminal.app`](https://support.apple.com/guide/terminal/open-or-quit-terminal-apd5265185d-f365-44cb-8b09-71a064a42125/mac)
and type

```bash
brew install julia
```

to install it as a [formula](https://docs.brew.sh/Formula-Cookbook).

If you are also using [macOS](https://en.wikipedia.org/wiki/MacOS) and want to install it as
a prebuilt binary app, type

```bash
brew install --cask julia
```

instead.

### Which version should I pick?

You can install the current stable release or the long-term support (LTS) release.

- The current stable release is the latest release of Julia. It has access to
  newer features, and is likely faster.
- The long-term support release is an older version of Julia that has
  continued to receive bug and security fixes. However, it may not have the
  latest features or performance improvements.

Most users should install the 'Current stable release' and update their Julia version
whenever a new version is released. Note that any code you write on one version of the
current stable release will continue to work on all subsequent releases.

Users in restricted software environments, where enterprise IT controls software
installations, may benefit from installing the long-term support release to reduce the
frequency of updates.

Versions above `v1.3`, especially the latest stable ones, are strongly recommended.
This package is highly unlikely to work on `v1.0` and earlier versions.
Since the Julia team has set `v1.6` as the LTS release,
we will gradually drop support for versions below `v1.6`.

Julia and Julia packages support multiple operating systems and CPU architectures; check
[this table](https://julialang.org/downloads/#supported_platforms) to see if it can be
installed on your machine. For Mac computers with M-series processors, this package and its
dependencies may not work. Please install the Intel-compatible version of Julia (for macOS
x86-64) if any platform-related error occurs.

## Install the package

The following installation steps are demonstrated using macOS as the standard platform:

1. Open the Terminal app, and type `julia` to start an interactive session (known as the
   [REPL](https://docs.julialang.org/en/v1/stdlib/REPL/)).

2. Run the following commands and wait for them to finish:

   ```julia-repl
   julia> using Pkg

   julia> Pkg.update()

   julia> Pkg.add("NumerovShooting")
   ```

3. Run

   ```julia-repl
   julia> using NumerovShooting
   ```

   and have fun!

4. Please keep the Julia session active while using it. Restarting the session may take some time.

If you want to install the latest in-development (probably buggy)
version of NumerovShooting, type

```@repl
using Pkg
Pkg.update()
pkg"add https://github.com/singularitti/NumerovShooting.jl"
```

in the second step above.

## Update the package

Please [watch](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications#configuring-your-watch-settings-for-an-individual-repository)
our [GitHub repository](https://github.com/singularitti/NumerovShooting.jl)
for new releases.
Once we release a new version, you can update NumerovShooting by typing

```@repl
using Pkg
Pkg.update("NumerovShooting")
Pkg.gc()
```

in the Julia REPL.

## Uninstall and then reinstall the package

Errors may occur if the package is improperly installed.
In this case, you may want to uninstall and reinstall the package. Here is how to do that:

1. To uninstall, in a Julia session, run

   ```julia-repl
   julia> using Pkg

   julia> Pkg.rm("NumerovShooting")

   julia> Pkg.gc()
   ```

2. Press `Ctrl+D` to quit the current session. Start a new Julia session and
   reinstall NumerovShooting.
