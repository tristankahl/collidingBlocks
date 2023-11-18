function show_blocks(a, b)
    plot(aspect_ratio=:equal, axis=:off, ticks=false)
    # draw small block
    plot!([a-1, a], [1, 1], fillrange=[0, 0], linewidth=0, color=:blue, label="")
    # draw big block
    plot!([b, b+2], [2, 2], fillrange=[0, 0], linewidth=0, color=:brown, label="")
    # draw wall of height 5
    plot!([-1, 0, 0], [5, 5, 0], fillrange=[0, 0, 0], color=:black, fillcolor=:gray, label="") # fillstyle=:/, 
    # draw floor
    plot!([-2, 18], [0, 0], color=:black, label="")
end