# simulate by using analytical solutions instead of using time steps and Euler, RK4 or similar algorithms
# in case of collisions we can just swap the sign and calculate the time of the collsion
# dt is used for the returned vectors
function simulate_analytic(r_start::Vector{Float64}, p_start::Vector{Float64}, m::Vector{Float64}, n::Int64, dt::Float64)
    r = zeros(Float64, n+1, size(r_start, 1))
    p = zeros(Float64, n+1, size(p_start, 1))
    r[1, :] = r_start
    p[1, :] = p_start
    r_current = r_start
    p_current = p_start
    t_current = 0.0 # this is the time we have in the simulation
    i = 1 # this is up to where we have simulated the positions
    while t_current < n * dt && i < n+1
        # we want to update t to the next collision (r_1(t) = r_2(t) or r_1(t) = 1)
        t_wall = -1.0
        if p_current[1] != 0
            t_wall = - (r_current[1] - 1) * m[1] / p_current[1] # time colliding with wall (might be negative if moving away from wall)
        end
        t_blocks = -1.0
        if p_current[2] / m[2] - p_current[1] / m[1] != 0
            t_blocks = - (r_current[2] - r_current[1]) / (p_current[2] / m[2] - p_current[1] / m[1]) # time colliding with other block
        end
        if t_wall > 0
            if t_blocks > 0 && t_blocks < t_wall
                t_step = t_blocks
                # update r, t before collision
                while i * dt - t_current <= t_step && i <= n
                    r[i+1, :] = p_current ./ m .* (i .* dt - t_current)
                    p[i+1, :] = p_current
                    i += 1
                end
                t_current += t_step
                r_current += p_current ./ m .* t_step
                u = sum(p_current) / sum(m)
                p_current = 2 .* m .* u .- p_current
            else
                t_step = t_wall
                # update r, t before collision
                while i * dt - t_current <= t_step && i <= n
                    r[i+1, :] = r_current + p_current ./ m .* (i .* dt - t_current)
                    p[i+1, :] = p_current
                    i += 1
                end
                t_current += t_step
                r_current += p_current ./ m .* t_step
                p_current[1] *= -1
            end
        else
            if t_blocks > 0
                t_step = t_blocks
                # update r, t before collision
                while i * dt - t_current <= t_step && i <= n
                    r[i+1, :] = r_current + p_current ./ m .* (i .* dt - t_current)
                    p[i+1, :] = p_current
                    i += 1
                end
                t_current += t_step
                r_current += p_current ./ m .* t_step
                u = sum(p_current) / sum(m)
                p_current = 2 .* m .* u .- p_current
            else
                while i <= n
                    r[i+1, :] = r_current + p_current ./ m .* (i .* dt - t_current)
                    p[i+1, :] = p_current
                    i += 1
                end
            end
        end
    end
    return r, p
end