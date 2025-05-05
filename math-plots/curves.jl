using Plots
gr()  

t1 = range(-2, 2, length=300)
x1 = t1 .^ 2
y1 = t1 .^ 3
p1 = plot(
    x1, y1,
    xlabel = "x",
    ylabel = "y",
    title  = "γ₁(t) = (t², t³)",
    legend = false,
    aspect_ratio = :equal,
)

t2 = range(0, 10, length=500)
x2 = t2
y2 = t2 .* cos.(t2)
z2 = t2 .* sin.(t2)
p2 = plot(
    x2, y2, z2,
    xlabel = "x = t",
    ylabel = "y = t·cos(t)",
    zlabel = "z = t·sin(t)",
    title  = "γ₂(t) = (t, t·cos(t), t·sin(t))",
    legend = false,
    camera = (30, 30),
)

t3 = range(0, 2π, length=1000)
x3 = sin.(3 .* t3) .* cos.(t3)
y3 = sin.(3 .* t3) .* sin.(t3)
p3 = plot(
    x3, y3,
    xlabel = "x",
    ylabel = "y",
    title  = "γ₃(t) = (sin(3t)·cos(t), sin(3t)·sin(t))",
    legend = false,
    aspect_ratio = :equal,
)

plot(p1, p2, p3, layout = (3,1), size=(600,1200))