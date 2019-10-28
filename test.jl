# load libraries and code
using PyPlot
include("schelling_model.jl")

# initialize world
world = initialize_world(100, 0.7)

# show initial state
PyPlot.clf()
PyPlot.subplot(1, 2, 1)
PyPlot.imshow(world)

# execute simulation
new_world = simulate(world, 1000, 0.5)

# show state after simulation
PyPlot.subplot(1, 2, 2)
PyPlot.imshow(new_world)
display(gcf())