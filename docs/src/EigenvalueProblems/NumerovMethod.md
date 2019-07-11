# Numerov’s method

```@meta
CurrentModule = NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod
```

The *Numerov method* is introduced by Russian astronomer Boris Vasilyevich Numerov, to solve ODE

```math
\frac{ d^2 y }{ dx^2 } + g(x) y(x) = s(x).
```

with initial conditions

```math
y(x_0) = y_0 \quad y'(x_0) = y_0'.
```

Follow the derivation from the [notes](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/LectureNotes/mq-cap1.pdf), we derive the ``n + 1`` step of ``y_{n + 1} = y(x_{n + 1})`` satisfies

```math
\bigg( 1 + \frac{ h^2 }{ 12 } g_{n + 1} \bigg) y_{n + 1} =
2 y_{n} \bigg( 1 - \frac{ 5 h^2 }{ 12 } g_{n} \bigg) - \bigg( 1 + \frac{ h^2 }{ 12 } g_{n - 1} \bigg) y_{n - 1},
```

where ``g_{n} = g(x_{n})`` and ``s_{n} = s(x_{n})``, etc.

Therefore, we could split the ``x``-axis to ``N`` pieces, and solve the solution ``y(x)`` piece-by-piece, i.e., from `y[1]` and `y[2]` to `y[3]`, repeatedly.

If `s(x) \equiv 0` on the domain of ``x``, the the above equation simplifies to

```math
y_{n + 1} = 2 \frac{ 12 - 5h^2 g_{n} }{ 12 + h^2 g_{n + 1} } y_{n} - y_{n - 1}.
```



```@docs
numerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<: Real}, svec::AbstractArray{<: Real})
numerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<: Real})

integrate(y0::Real, yd0::Real, r::AbstractRange{<: Real}, gvec::AbstractArray{<: Real}, svec::AbstractArray{<: Real})
integrate(y0::Real, yd0::Real, r::AbstractRange{<: Real}, g::Function, s::Function)
```
