using Plots
plotlyjs()

as = vcat(range(-2, -0.1, length=120),
          range( 0.1,  2.0, length=120))
bs = range(-2.0, 2.0, length=120)

As = [a for b in bs, a in as]
Bs = [b for b in bs, a in as]

Ds = (1 .- Bs.^2) ./ As

plt = surface(
    As, Bs, Ds;
    xlabel = "a", ylabel = "b", zlabel = "d",
    title  = "SL(2,ℝ): ad + b² = 1, SO(2) = a²+b²=1",
    legend = false,
    opacity = 0.8
)

θ = range(0, 2π, length=300)
aC = cos.(θ)
bC = sin.(θ)
dC = aC

plot!(
    plt,
    aC, bC, dC;
    linecolor = :red,
    linewidth = 3,
    label     = "SO(2)",
)

display(plt)
