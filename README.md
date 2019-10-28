# Schelling Model of Segregation

This is a Julia implementation of Schelling's model of segregation (1971).

To experiment with the simulation, fork this repository and open the file test.jl. In this script, you can play around with some parameters of the simulation.

These are the functions from schelling_model.jl that are used in the test script:

initialize_world(dim, pop_density):
    
    * initializes the world where the simulation takes place
    * dim: the world is created as a dim x dim matrix
    * pop_density: the density of the world's population

simulate(world, max_ticks, threshold):

    * runs the simulation
    * world: the world created with inizialize_world()
    * max_ticks: the maximum number of ticks the simulation should be run
    * threshold: threshold at which agents relocate in the world

The prior and the resulted state of the world are visualized with the PyPlot module. You can install it like this:

```
using Pkg
Pkg.add("PyPlot")
```

## Reference

Schelling, T. C. (1971). Dynamic models of segregation. Journal of mathematical sociology, 1(2), 143-186.