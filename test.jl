#=

parameters:
* population density
* two types of agents
* tolerance threshold

methods:
* tick
* simulate
* setup
* check_neighborhood

undecided:
* agent happiness

if rand() < 0.8 if rand() < 0.5 (first population density then agent type)

=#

# load libraries
using PyPlot

# setup parameters
pop_density = 0.80
dim = 100

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

# is agent happy?
function check_agent_happiness(world, i, j, threshold)
    similar = 0
    different = 0
    positions = [ 
        (i-1, j-1), (i-1, j  ), (i-1, j+1),
        (i,   j-1),             (i,   j+1),
        (i+1, j-1), (i+1, j  ), (i+1, j+1) 
    ]
    for pos in positions
        if pos[1] == 0
            if pos[2] == 0
                world[size(world)[1], size(world)[1]] == world[i, j] ? similar += 1 : different += 1
            elseif pos[2] == (size(world)[1] + 1)
                world[size(world)[1], 1] == world[i, j] ? similar += 1 : different += 1
            else
                world[size(world)[1], pos[2]] == world[i, j] ? similar += 1 : different += 1
            end
        elseif pos[1] == (size(world)[1] + 1)
            if pos[2] == 0
                world[1, size(world)[1]] == world[i, j] ? similar += 1 : different += 1
            elseif pos[2] == (size(world)[1] + 1)
                world[1, 1] == world[i, j] ? similar += 1 : different += 1
            else
                world[1, pos[2]] == world[i, j] ? similar += 1 : different += 1
            end
        else
            if pos[2] == 0
                world[pos[1], size(world)[1]] == world[i, j] ? similar += 1 : different += 1
            elseif pos[2] == (size(world)[1] + 1)
                world[pos[1], 1] == world[i, j] ? similar += 1 : different += 1
            else
                world[pos[1], pos[2]] == world[i, j] ? similar += 1 : different += 1
            end        
        end
    end
    return similar/different >= threshold ? true : false
    # return similar, different
end

function relocate(world, i, j)
end

PyPlot.imshow(world)
display(gcf())