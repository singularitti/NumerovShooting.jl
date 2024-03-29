# Troubleshooting

```@contents
Pages = ["troubleshooting.md"]
Depth = 2
```

This page lists possible errors you may encounter and provides tips on how to fix them.
If you have any questions about how to use this code, feel free to
[discuss with us](https://github.com/singularitti/NumerovShooting.jl/discussions).

If you have additional tips, please either
[report an issue](https://github.com/singularitti/NumerovShooting.jl/issues/new) or
[submit a pull request](https://github.com/singularitti/NumerovShooting.jl/compare) with suggestions.

## Cannot find the Julia executable

Ensure that Julia is installed in your environment. Please download the latest
[stable version](https://julialang.org/downloads/#current_stable_release) for your platform,
and it's recommended to do it indirectly with
[Juliaup](https://github.com/JuliaLang/juliaup) as explained on that page.

If you prefer not to install Juliaup, download the corresponding binaries instead.
Next, create a symbolic link to the Julia executable.
If the path is not included in your
[`$PATH` environment variable](https://en.wikipedia.org/wiki/PATH_(variable)), add it by
exporting the path to `$PATH`.

Some clusters, like
[Comet](https://www.sdsc.edu/support/user_guides/comet.html),
or [Expanse](https://www.sdsc.edu/services/hpc/expanse/index.html),
already have Julia installed as a module, you can
just `module load julia` to use it. If not, you should either install it yourself or contact
your system administrator.

See [Installation Guide](@ref) for more information.

## Julia starts slow

First, we recommend downloading the latest version of Julia using Juliaup. Usually, the
latest version has the best performance.

For simple, one-time tasks in Julia, you can start the Julia REPL with

```bash
julia --compile=min
```

to minimize compilation or

```bash
julia --optimize=0
```

to minimize optimizations. Or you could make a system image and run with

```bash
julia --sysimage custom-image.so
```

See [Fredrik Ekre's talk](https://youtu.be/IuwxE3m0_QQ?t=313) for details.
