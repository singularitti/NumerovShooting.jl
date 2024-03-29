# NumerovShooting

| **Documentation** | [![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://singularitti.github.io/NumerovShooting.jl/stable/) [![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://singularitti.github.io/NumerovShooting.jl/dev/)                                                                                                                                                                                                                                                                                                 |
| :---------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Build Status**  | [![Build Status](https://github.com/singularitti/NumerovShooting.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/singularitti/NumerovShooting.jl/actions/workflows/CI.yml?query=branch%3Amain) [![Build Status](https://ci.appveyor.com/api/projects/status/github/singularitti/NumerovShooting.jl?svg=true)](https://ci.appveyor.com/project/singularitti/NumerovShooting-jl)[![Build Status](https://api.cirrus-ci.com/github/singularitti/NumerovShooting.jl.svg)](https://cirrus-ci.com/github/singularitti/NumerovShooting.jl) |
|   **Coverage**    | [![Coverage](https://github.com/singularitti/NumerovShooting.jl/badges/main/coverage.svg)](https://github.com/singularitti/NumerovShooting.jl/commits/main) [![Coverage](https://codecov.io/gh/singularitti/NumerovShooting.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/singularitti/NumerovShooting.jl)                                                                                                                                                                                                                |
|    **Others**     | [![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle) [![License](https://img.shields.io/github/license/singularitti/NumerovShooting.jl)](https://github.com/singularitti/NumerovShooting.jl/blob/main/LICENSE)                                                                                                                                                                                                                                                   |

The code, which is [hosted on GitHub](https://github.com/singularitti/NumerovShooting.jl), is tested
using various continuous integration services for its validity.

This repository is created and maintained by
[@singularitti](https://github.com/singularitti), and contributions are highly welcome.

## Package features

This repo stores a [Julia](https://julialang.org/) implementation of Paolo Giannozzi's course [Numerical Methods in Quantum Mechanics](http://www.fisica.uniud.it/~giannozz/Corsi/MQ/mq.html)
of year 2018-2019.
But only for the Numerov's method in the first chapter.

## Course Description

The lecture notes is [here](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/LectureNotes/mq.pdf).

### Goals

this course provides an introduction to numerical methods and techniques useful for the numerical solution of quantum
mechanical problems, especially in atomic and condensed-matter physics. The course is organized as a series of
theoretical lessons in which the physical problems and the numerical concepts needed for their resolution are
presented, followed by practical sessions in which examples of implementatation for specific simple problems are
presented. The student will learn to use the concepts and to practise scientific programming by modifying and
extending the examples presented during the course.

### Syllabus

Schroedinger equations in one dimension: techniques for numerical solutions. Solution of the Schroedinger equations
for a potential with spherical symmetry. Scattering from a potential. Variational method: expansion on a basis of
functions, secular problem, eigenvalues and eigenvectors. Examples: gaussian basis, plane-wave basis. Many-electron
systems: Hartree and Hartree-Fock equations: self-consistent field, exchange interaction. Numerical solution of
Hartree-Fock equations in atoms with radial integration and on a gaussian basis set. Introduction to numerical
solution of electronic states in molecules. Electronic states in solids: solution of the Schroedinger equation
for periodic potentials. Introduction to exact diagonalization of spin systems. Introduction to Density-Functional
Theory.

| No.  | My code | Subject                                                      |
| :--: | :-----: | ------------------------------------------------------------ |
|  1.  |         | *One-dimensional Schroedinger equation:*  general features of the discrete spectrum, relationship between energy, parity, number of intersections of a solution. Harmonic oscillator: analytical solution. Discretization, Numerov algorithm, numerical stability, eigenvalue search using stable outwards and inwards integrations. (Notes: Ch.1) |
|  2.  |         | *Numerical solution of the one-dimensional Schroedinger equation:*  examples for the harmonic oscillator (code *harmonic0*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/harmonic0.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/harmonic0.c); code *harmonic1*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/harmonic1.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/harmonic1.c)). |
|  3.  |         | *Three-dimensional Schroedinger equation:*  Central potentials, variable separation, logarithmic grids, perturbative estimate to accelerate eigenvalue convergence. (Notes: Ch.2). A glimpse on true three-dimensional problems on a grid. (Notes: appendix B) |
|  4.  |         | *Numerical solution for spherically symmetric potentials:*  example for Hydrogen atom (code *hydrogen_radial*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/hydrogen_radial.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/hydrogen_radial.c); needed Fortran routines [`solve_sheq`](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/solve_sheq.f90), [`init_pot`](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/init_pot.f90), [`do_mesh`](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/do_mesh.f90)) |
|  5.  |         | *Scattering from a potential:* cross section, phase shifts, resonances. (Notes: Ch.3; Thijssen: Ch.2) |
|  6.  |         | *Calculation of cross sections:* numerical solution for Lennard-Jones potential (code *crossection*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/crossection.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/crossection.c)). |
|  7.  |         | *Variational method:* Schroedinger equation as minimum problem, expansion on a basis of functions, secular problem, introduction to diagonalization algorithms. (Notes: Ch.4; Thijssen: Ch.3) |
|  8.  |         | *Variational method using an orthonormal basis set:* example of a potential well in plane waves (code *pwell*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/pwell.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/pwell.c)). |
|  9.  |         | *Non-orthonormal basis sets:* gaussian functions. (Notes: Ch.5) |
| 10.  |         | *Variational method with gaussian basis set:* solution for Hydrogen atom (code *hydrogen_gauss*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/hydrogen_gauss.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/hydrogen_gauss.c); needed Fortran routine [`diag`](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/diag.f90)). |
| 11.  |         | *Self-consistent field:* solution of the many-body problem: Hartree method, self-consistent field. (Notes: Ch.6) |
| 12.  |         | *He atom with Hartree approximation:* solution with radial integration and self-consistency (code *helium_hf_radial*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/helium_hf_radial.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/helium_hf_radial.c)). |
| 13.  |         | *Hartree-Fock method:* Slater determinants, Hartree-Fock equations (Notes: Ch.7; Thijssen: Ch.4.1-4.5) |
| 14.  |         | *Helium atom with Hartree-Fock approximation:* solution with gaussian basis and diagonalization (code *helium_hf_gauss*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/helium_hf_gauss.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/helium_hf_gauss.c)). |
| 15.  |         | *Molecules:* Born-Oppenheimer approximation, potential energy surface, diatomic molecules. introduction to numerical solution for molecules. (Notes: Ch.8; Thijssen: Ch.4.6-4.8) |
| 16.  |         | *Molecules with gaussian basis:* solution of Hartree-Fock equations on a gaussian basis for a H2 molecule (code *h2_hf_gauss*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/h2_hf_gauss.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/h2_hf_gauss.c)). |
| 17.  |         | *Electronic states in crystals:* Bloch theorem, band structure. (Notes: Ch.9; Thijssen: Ch.4.6-4.8) |
| 18.  |         | *Periodic potentials:* numerical solution with plane waves of the Kronig-Penney model (code *periodicwell*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/periodicwell.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/periodicwell.c); needed Fortran routine [`cft`](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/cft.f90)). |
| 19.  |         | *Electronic states in crystals II:* three-dimensional case, methods of solution, plane wave basis set, introduction to the concept of pseudopotential. (Notes: Ch.10; Thijssen: Ch.6.1-6.4, 6.7) |
| 20.  |         | *Pseudopotentials:*  solution of the [Cohen-Bergstresser](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/LectureNotes/cohenbergstresser.pdf) model for Silicon (code *cohenbergstresser*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/cohenbergstresser.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/cohenbergstresser.c)). |
| 21.  |         | *Spin systems* Introduction to spin systems: Heisenberg model, exact diagonalization, iterative methods for diagonalization, sparseness. (Notes: Ch.11) |
| 22.  |         | *Exact Diagonalization* Solution of the Heisenberg model with Lanczos chains (code *heisenberg_exact*: [Fortran](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/heisenberg_exact.f90), [C](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/C/heisenberg_exact.c)). |
| 23.  |         | *Density-Functional Theory* Introduction to the theory and to the plane-wave pseudopotential method (Notes: Ch.12) |
| 24.  |         | *Density-Functional Theory II* Fast Fourier-Trasform and iterative techniques ([dumb](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/ah_slow.f90) and [less dumb](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/Software/F90/ah.f90) code, only Fortran, solving Si with [Appelbaum-Hamann](http://www.fisica.uniud.it/~giannozz/Didattica/MQ/LectureNotes/Appelbaum-Hamann.pdf) pseudopotentials).  Assignment of exam problems. |

## Installation

The package can be installed with the Julia package manager.
From [the Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/), type `]` to enter
the [Pkg mode](https://docs.julialang.org/en/v1/stdlib/REPL/#Pkg-mode) and run:

```julia-repl
pkg> add NumerovShooting
```

Or, equivalently, via [`Pkg.jl`](https://pkgdocs.julialang.org/v1/):

```julia
julia> import Pkg; Pkg.add("NumerovShooting")
```

## Documentation

- [**STABLE**](https://singularitti.github.io/NumerovShooting.jl/stable/) — **documentation of the most recently tagged version.**
- [**DEV**](https://singularitti.github.io/NumerovShooting.jl/dev/) — _documentation of the in-development version._

## Project status

The package is developed for and tested against Julia `v1.6` and above on Linux, macOS, and
Windows.

## Questions and contributions

You can post usage questions on
[our discussion page](https://github.com/singularitti/NumerovShooting.jl/discussions).

We welcome contributions, feature requests, and suggestions. If you encounter any problems,
please open an [issue](https://github.com/singularitti/NumerovShooting.jl/issues).
The [Contributing](@ref) page has
a few guidelines that should be followed when opening pull requests and contributing code.
