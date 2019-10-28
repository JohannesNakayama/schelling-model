# initialize world
function initialize_world(dim, pop_density)
    world = rand(dim, dim)
    # distribute agents probabilitically
    for n in 1:dim, m in 1:dim
        if world[n, m] < pop_density
            if rand() < 0.5
                world[n, m] = 1.0
            else
                world[n, m] = 2.0
            end
        else
            world[n, m] = 0.0
        end
    end
    return world
end

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

# find a new place to live
function relocate(world, i, j)
    new_row = convert(Int64, ceil(rand() * size(world)[1]))
    new_col = convert(Int64, ceil(rand() * size(world)[1]))
    if world[new_row, new_col] == 0.0
        world[new_row, new_col] = world[i, j]
        world[i, j] = 0.0
    else
        relocate(world, i, j)
    end
    return world
end

# simulation step
function tick(world, threshold)
    for n in 1:size(world)[1], m in 1:size(world)[1]
        if !agent_happy(world, n, m, threshold)
            relocate(world, n, m)
        end
    end
    return world
end

# run the simulation for max_ticks steps at given threshold 
function simulate(world, max_ticks, threshold)
    for t in 1:max_ticks
        world = tick(world, threshold)
    end
    return world
end



