using Plots

include("jl/plot.jl")
include("jl/simulate.jl")

show_blocks(2, 3)
savefig("fig/blocks.pdf")

r, p = simulate_analytic([2.0, 3.0], [0.0, -1.0], [1.0, 100.0], 5000, 0.1)

plot(r[:,1], label="r1", color="blue")
plot!(r[:,2], label="r2", color="brown")
savefig("fig/spacetime.pdf")