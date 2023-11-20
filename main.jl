using Plots

include("jl/plot.jl")
include("jl/simulate.jl")

show_blocks(2, 3)
savefig("fig/blocks.pdf")

r, p = simulate_analytic([2.0, 3.0], [0.0, -1.0], [1.0, 100.0], 5000, 0.1)

plot(r[:,1], label="\$r_1\$", color="blue")
plot!(r[:,2], label="\$r_2\$", color="brown")
savefig("fig/spacetime.pdf")

plot(p[:, 2] / 10, p[:, 1], xlabel="\$p_2 / \\sqrt{m_2}\$", ylabel="\$p_1 / \\sqrt{m_1}\$", aspect_ratio=:equal, label="")
plot!([0.1 * cos(x) for x in 0.0:0.01:2*pi], [0.1 * sin(x) for x in 0.0:0.01:2*pi], label="")
savefig("fig/p1p2.pdf")