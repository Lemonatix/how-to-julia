using Plots

plotly()

xs = range(-3, 3, length=200)
ys = range(-3, 3, length=200)

f1(x,y) = x^2 - y^3
Z1 = [f1(x,y) for x in xs, y in ys]

p1 = surface(xs, ys, Z1,
    title = "Surface: f(x,y) = x² - y³",
    xlabel = "x", ylabel = "y", zlabel = "z",
    legend = false)

p2 = contour(xs, ys, Z1,
    title = "Contour: f(x,y) = x² - y³",
    xlabel = "x", ylabel = "y",
    levels = -4:1:4)

f2(x,y) = sin(x)*cos(y)
Z2 = [f2(x,y) for x in xs, y in ys]

p3 = surface(xs, ys, Z2,
    title = "Surface: f(x,y) = sin(x)·cos(y)",
    xlabel = "x", ylabel = "y", zlabel = "z",
    legend = false)

p4 = contour(xs, ys, Z2,
    title = "Contour: f(x,y) = sin(x)·cos(y)",
    xlabel = "x", ylabel = "y",
    levels = -1:0.2:1)

plot(p1, p2, p3, p4, layout = (2,2), size=(900,600))