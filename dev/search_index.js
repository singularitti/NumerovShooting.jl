var documenterSearchIndex = {"docs":
[{"location":"#NumericalMethodsInQuantumMechanics.jl-1","page":"Home","title":"NumericalMethodsInQuantumMechanics.jl","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"This repo stores a Julia implementation of Paolo Giannozzi's course Numerical Methods in Quantum Mechanics of year 2018-2019.","category":"page"},{"location":"#Course-Description-1","page":"Home","title":"Course Description","text":"","category":"section"},{"location":"#Goals-1","page":"Home","title":"Goals","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"this course provides an introduction to numerical methods and techniques useful for the numerical solution of quantum mechanical problems, especially in atomic and condensed-matter physics. The course is organized as a series of theoretical lessons in which the physical problems and the numerical concepts needed for their resolution are presented, followed by practical sessions in which examples of implementatation for specific simple problems are presented. The student will learn to use the concepts and to practise scientific programming by modifying and extending the examples presented during the course.","category":"page"},{"location":"#Syllabus-1","page":"Home","title":"Syllabus","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Schroedinger equations in one dimension: techniques for numerical solutions. Solution of the Schroedinger equations for a potential with spherical symmetry. Scattering from a potential. Variational method: expansion on a basis of functions, secular problem, eigenvalues and eigenvectors. Examples: gaussian basis, plane-wave basis. Many-electron systems: Hartree and Hartree-Fock equations: self-consistent field, exchange interaction. Numerical solution of Hartree-Fock equations in atoms with radial integration and on a gaussian basis set. Introduction to numerical solution of electronic states in molecules. Electronic states in solids: solution of the Schroedinger equation for periodic potentials. Introduction to exact diagonalization of spin systems. Introduction to Density-Functional Theory.","category":"page"},{"location":"#","page":"Home","title":"Home","text":"No. My code Subject\n1.  One-dimensional Schroedinger equation:  general features of the discrete spectrum, relationship between energy, parity, number of intersections of a solution. Harmonic oscillator: analytical solution. Discretization, Numerov algorithm, numerical stability, eigenvalue search using stable outwards and inwards integrations. (Notes: Ch.1)\n2.  Numerical solution of the one-dimensional Schroedinger equation:  examples for the harmonic oscillator (code harmonic0: Fortran, C; code harmonic1: Fortran, C).\n3.  Three-dimensional Schroedinger equation:  Central potentials, variable separation, logarithmic grids, perturbative estimate to accelerate eigenvalue convergence. (Notes: Ch.2). A glimpse on true three-dimensional problems on a grid. (Notes: appendix B)\n4.  Numerical solution for spherically symmetric potentials:  example for Hydrogen atom (code hydrogen_radial: Fortran, C; needed Fortran routines solve_sheq, init_pot, do_mesh)\n5.  Scattering from a potential: cross section, phase shifts, resonances. (Notes: Ch.3; Thijssen: Ch.2)\n6.  Calculation of cross sections: numerical solution for Lennard-Jones potential (code crossection: Fortran, C).\n7.  Variational method: Schroedinger equation as minimum problem, expansion on a basis of functions, secular problem, introduction to diagonalization algorithms. (Notes: Ch.4; Thijssen: Ch.3)\n8.  Variational method using an orthonormal basis set: example of a potential well in plane waves (code pwell: Fortran, C).\n9.  Non-orthonormal basis sets: gaussian functions. (Notes: Ch.5)\n10.  Variational method with gaussian basis set: solution for Hydrogen atom (code hydrogen_gauss: Fortran, C; needed Fortran routine diag).\n11.  Self-consistent field: solution of the many-body problem: Hartree method, self-consistent field. (Notes: Ch.6)\n12.  He atom with Hartree approximation: solution with radial integration and self-consistency (code heliumhfradial: Fortran, C).\n13.  Hartree-Fock method: Slater determinants, Hartree-Fock equations (Notes: Ch.7; Thijssen: Ch.4.1-4.5)\n14.  Helium atom with Hartree-Fock approximation: solution with gaussian basis and diagonalization (code heliumhfgauss: Fortran, C).\n15.  Molecules: Born-Oppenheimer approximation, potential energy surface, diatomic molecules. introduction to numerical solution for molecules. (Notes: Ch.8; Thijssen: Ch.4.6-4.8)\n16.  Molecules with gaussian basis: solution of Hartree-Fock equations on a gaussian basis for a H2 molecule (code h2hfgauss: Fortran, C).\n17.  Electronic states in crystals: Bloch theorem, band structure. (Notes: Ch.9; Thijssen: Ch.4.6-4.8)\n18.  Periodic potentials: numerical solution with plane waves of the Kronig-Penney model (code periodicwell: Fortran, C; needed Fortran routine cft).\n19.  Electronic states in crystals II: three-dimensional case, methods of solution, plane wave basis set, introduction to the concept of pseudopotential. (Notes: Ch.10; Thijssen: Ch.6.1-6.4, 6.7)\n20.  Pseudopotentials:  solution of the Cohen-Bergstresser model for Silicon (code cohenbergstresser: Fortran, C).\n21.  Spin systems Introduction to spin systems: Heisenberg model, exact diagonalization, iterative methods for diagonalization, sparseness. (Notes: Ch.11)\n22.  Exact Diagonalization Solution of the Heisenberg model with Lanczos chains (code heisenberg_exact: Fortran, C).\n23.  Density-Functional Theory Introduction to the theory and to the plane-wave pseudopotential method (Notes: Ch.12)\n24.  Density-Functional Theory II Fast Fourier-Trasform and iterative techniques (dumb and less dumb code, only Fortran, solving Si with Appelbaum-Hamann pseudopotentials).  Assignment of exam problems.","category":"page"},{"location":"#Manual-Outline-1","page":"Home","title":"Manual Outline","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"Pages = [\n    \"EigenvalueProblems/NumerovMethod.md\",\n]\nDepth = 3","category":"page"},{"location":"#main-index-1","page":"Home","title":"Index","text":"","category":"section"},{"location":"#","page":"Home","title":"Home","text":"","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#Numerov's-method-1","page":"Numerov's method","title":"Numerov's method","text":"","category":"section"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"CurrentModule = NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"The Numerov method is introduced by Russian astronomer Boris Vasilyevich Numerov, to solve ODE","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"frac d^2 y  dx^2  + g(x) y(x) = s(x)","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"with initial conditions","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"y(x_0) = y_0 quad y(x_0) = y_0","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"Follow the derivation from the notes, we derive the n + 1 step of y_n + 1 = y(x_n + 1) satisfies","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"bigg( 1 + frac h^2  12  g_n + 1 bigg) y_n + 1 =\n2 y_n bigg( 1 - frac 5 h^2  12  g_n bigg) - bigg( 1 + frac h^2  12  g_n - 1 bigg) y_n - 1","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"where g_n = g(x_n) and s_n = s(x_n), etc.","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"Therefore, we could split the x-axis to N pieces, and solve the solution y(x) piece-by-piece, i.e., from y[1] and y[2] to y[3], repeatedly.","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"If s(x) \\\\equiv 0 on the domain of x, the the above equation simplifies to","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"y_n + 1 = 2 frac 12 - 5h^2 g_n  12 + h^2 g_n + 1  y_n - y_n - 1","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#","page":"Numerov's method","title":"Numerov's method","text":"numerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<: Real}, svec::AbstractArray{<: Real})\nnumerov_iter(y_prev::Real, y::Real, dx::Real, gvec::AbstractArray{<: Real})\n\nintegrate(y0::Real, yd0::Real, r::AbstractRange{<: Real}, gvec::AbstractArray{<: Real}, svec::AbstractArray{<: Real})\nintegrate(y0::Real, yd0::Real, r::AbstractRange{<: Real}, g::Function, s::Function)","category":"page"},{"location":"EigenvalueProblems/NumerovMethod/#NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.numerov_iter-Tuple{Real,Real,Real,AbstractArray{#s4,N} where N where #s4<:Real,AbstractArray{#s3,N} where N where #s3<:Real}","page":"Numerov's method","title":"NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.numerov_iter","text":"numerov_iter(y_prev, y, dx, gvec, svec)\n\nReturn the next step for the Numerov's method, given the current and previous step. See the Numerov's method documentation for more information.\n\nArguments\n\ny_prev::Real: the y[n - 1] element.\ny::Real: the y[n] element.\ndx::Real: the step length h, need to be small.\ngvec::AbstractArray{<: Real}: stores g[n - 1], g[n] and g[n + 1].\nsvec::AbstractArray{<: Real}: stores s[n - 1], s[n] and s[n + 1].\n\n\n\n\n\n","category":"method"},{"location":"EigenvalueProblems/NumerovMethod/#NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.numerov_iter-Tuple{Real,Real,Real,AbstractArray{#s4,N} where N where #s4<:Real}","page":"Numerov's method","title":"NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.numerov_iter","text":"numerov_iter(y_prev, y, dx, gvec)\n\nSame as numerov_iter(y_prev, y, dx, gvec, svec), if s(x)  0 on the domain.\n\nArguments\n\ny_prev::Real: the y[n - 1] element.\ny::Real: the y[n] element.\ndx::Real: the step length, need to be small.\ngvec::AbstractArray{<: Real}: stores g[n - 1], g[n] and g[n + 1].\n\n\n\n\n\n","category":"method"},{"location":"EigenvalueProblems/NumerovMethod/#NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.integrate-Tuple{Real,Real,AbstractRange{#s4} where #s4<:Real,AbstractArray{#s3,N} where N where #s3<:Real,AbstractArray{#s5,N} where N where #s5<:Real}","page":"Numerov's method","title":"NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.integrate","text":"integrate(y0, yd0, r, gvec, svec)\n\nDo the Numerov's method integration, return the solution y(x), given that g(x) and s(x) already as vectors (already applied on x).\n\nArguments\n\ny0::Real: the initial value y(x_0) = y_0, could be a guess.\nyd0::Real: the initial value y(x_0) = y_0, could be a guess.\nr::AbstractRange{<: Real}: a range, the domain x.\ngvec::AbstractArray{<: Real}: the result of function g applied on x (range r).\nsvec::AbstractArray{<: Real}: the result of function s applied on x (range r).\n\n\n\n\n\n","category":"method"},{"location":"EigenvalueProblems/NumerovMethod/#NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.integrate-Tuple{Real,Real,AbstractRange{#s5} where #s5<:Real,Function,Function}","page":"Numerov's method","title":"NumericalMethodsInQuantumMechanics.EigenvalueProblems.NumerovMethod.integrate","text":"integrate(y0, yd0, r, g, s)\n\nSame as integrate(y0, yd0, r, gvec, svec), but g and s are two functions.\n\nArguments\n\ny0::Real: the initial value y(x_0) = y_0, could be a guess.\nyd0::Real: the initial value y(x_0) = y_0, could be a guess.\nr::AbstractRange{<: Real}: a range, the domain x.\ng::Function: the function g.\ns::Function: the function s.\n\n\n\n\n\n","category":"method"}]
}
