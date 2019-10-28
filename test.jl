# load libraries
using PyPlot

# setup parameters
pop_density = 0.80
dim = 100
threshold = 0.7

# initialize world
world = rand(dim, dim)
for n in 1:dim, m in 1:dim
    if world[n, m] < 0.8
        if rand() < 0.5
            world[n, m] = 1.0
        else
            world[n, m] = 2.0
        end
    else
        world[n, m] = 0.0
    end
end

# show initial state
PyPlot.imshow(world)
display(gcf())

# is agent happy?
function agent_happy(world, i, j, threshold)
    similar = 0
    different = 0
    positions = [ 
        (i-1, j-1), (i-1, j  ), (i-1, j+1),
        (i,   j-1),             (i,   j+1),
        (i+1, j-1), (i+1, j  ), (i+1, j+1) 
    ]
    for pos in positions
        # case 1: row out of bounds (0)
        if pos[1] == 0
            # case 1a: column out of bounds (0)
            if pos[2] == 0
                world[size(world)[1], size(world)[1]] == world[i, j] ? similar += 1 : different += 1
            # case 1b: column out of bounds (dim)
            elseif pos[2] == (size(world)[1] + 1)
                world[size(world)[1], 1] == world[i, j] ? similar += 1 : different += 1
            # case 1c: column not out of bounds
            else
                world[size(world)[1], pos[2]] == world[i, j] ? similar += 1 : different += 1
            end
        # case 2: row out of bounds (dim)
        elseif pos[1] == (size(world)[1] + 1)
            # case 2a: column out of bounds (0)
            if pos[2] == 0
                world[1, size(world)[1]] == world[i, j] ? similar += 1 : different += 1
            # case 2b: column oht of bounds (dim)
            elseif pos[2] == (size(world)[1] + 1)
                world[1, 1] == world[i, j] ? similar += 1 : different += 1
            # case 2c: column not out of bounds
            else
                world[1, pos[2]] == world[i, j] ? similar += 1 : different += 1
            end
        # case 3: row not out of bounds
        else
            # case 3a: column out of bounds (0)
            if pos[2] == 0
                world[pos[1], size(world)[1]] == world[i, j] ? similar += 1 : different += 1
            # case 3b: column out of bounds (dim)
            elseif pos[2] == (size(world)[1] + 1)
                world[pos[1], 1] == world[i, j] ? similar += 1 : different += 1
            # case 3c: column not out of bounds
            else
                world[pos[1], pos[2]] == world[i, j] ? similar += 1 : different += 1
            end        
        end
    end
    # return true if relative count of similar agents in neighborhood is > threshold, else false
    return similar/different >= threshold ? true : false
end

# if agent is unhappy: relocate
function relocate(world, i, j)
    new_row = convert(Int8, ceil(rand() * 100))
    new_col = convert(Int8, ceil(rand() * 100))
    if world[new_row, new_col] == 0.0
        world[new_row, new_col] = world[i, j]
        world[i, j] = 0.0
    else
        relocate(world, i, j)
    end
    return world
end

# simulation step
function tick(world)
    for n in 1:dim, m in 1:dim
        if !agent_happy(world, n, m, threshold)
            relocate(world, n, m)
        end
    end
    return world
end

# run the simulation for 100 steps
function simulate(world)
    for step in 1:1000
        world = tick(world)
    end
    return world
end

# execute simulation
new_world = simulate(world)

# show state after simulation
PyPlot.clf()
PyPlot.imshow(new_world)
display(gcf())

