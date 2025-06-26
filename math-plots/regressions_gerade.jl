using Plots

xs = [1500, 1800, 1900, 2000]
ys = [0.50, 0.98, 1.65, 6.13]

a0 = -13.6407
a1 = 0.0088643

x_line = range(1400, stop=2100, length=300)
y_line = a0 .+ a1 .* x_line

scatter(
    xs, ys;
    label       = "Datenpunkte",
    xlabel      = "Jahr (x)",
    ylabel      = "Weltbevölkerung (Mrd.)",
    title       = "Lin. Reg. der Weltbevölkerung",
    legend      = :topleft,
    markercolor = :blue,
    markersize  = 6
)

plot!(
    x_line, y_line;
    label        = "Regressionsgerade",
    linecolor    = :red,
    linewidth    = 2
)

# savefig("regressionsgerade.png")