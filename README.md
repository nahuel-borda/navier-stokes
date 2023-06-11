## Navier Strokes Simulation

- [Original study](https://www.dgp.toronto.edu/public_user/stam/reality/Research/pdf/GDC03.pdf)
- [Wikipedia Page](https://en.wikipedia.org/wiki/Navier%E2%80%93Stokes_equations)

This repository contains an implementation of the Navier-Stokes equations for fluid flow simulation, using Gauss-Seidel relaxation, red-black notation, and parallelization through OpenMP. The solver is designed to accurately model fluid flow behavior and provide high-performance computing using optimzed numerical methods and parallelization techniques.

Features
Navier-Stokes equations solver for fluid flow simulations
Gauss-Seidel relaxation for iterative equation solving
Red-black notation for efficient data representation and processing
OpenMP for parallelization and improved performance on multi-core processors
Support for multi-physics applications and various boundary conditions
Installation
The code is written in C and can be compiled using a suitable C compiler with OpenMP support. I reccomend clang, after benchmarking in gcc, clang, llvm, aocc, icx and icc. To compile the code, simply navigate to the repository root directory and run:

```sh
export CC=clang 
export CFLAGS='-fopenmp=libomp -std=c99 -march=native -Ofast -ftree-vectorize -Wall -Wextra'
make all
```

If you plan on using multithread, specify the number of threads with:

```sh
export OMP_NUM_THREADS='number of threads'
```

Usage
Run the compiled binary by executing:

```sh
./demo SIZE 0.1 0 0 5 100 BLOCK_DIVISION

# SIZE and BLOCK_DIVISION must be a power of 2. I got a sweet spot in performance and resolution using 2048 for SIZE and 64 for BLOCK DIVISION on a M2 chip.
# also OMP_PROC_BIND=true and OMP_NUM_THREADS=8, so each thread gets a whole core.
```

The simulation parameters can be configured in the source code to match the specific use case, such as changing the grid size, time steps, and fluid properties.

```c
# Before executing
fprintf(stderr, "usage : %s N dt diff visc force source\n", argv[0]);
fprintf(stderr, "where:\n");
fprintf(stderr, "\t N      : grid resolution\n");
fprintf(stderr, "\t dt     : time step\n");
fprintf(stderr, "\t diff   : diffusion rate of the density\n");
fprintf(stderr, "\t visc   : viscosity of the fluid\n");
fprintf(stderr, "\t force  : scales the mouse movement that generate a force\n");
fprintf(stderr, "\t source : amount of density that will be deposited\n");
fprintf(stderr, "\t sb : the size for the grid to be divided. Mus be a divisor of N.\n");

# After executing
printf("\n\nHow to use this demo:\n\n");
printf("\t Add densities with the right mouse button\n");
printf("\t Add velocities with the left mouse button and dragging the mouse\n");
printf("\t Toggle density/velocity display with the 'v' key\n");
printf("\t Clear the simulation by pressing the 'c' key\n");
printf("\t Quit by pressing the 'q' key\n");
```

Contributing
Feel free to contribute to this project by submitting pull requests or opening issues for bug reports, feature requests, and discussions.

Acknowledgments
A special thanks to all researchers and developers whose work has provided the foundation for this Navier-Stokes simulation implementation
