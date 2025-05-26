using Plots

plotly()

xs = range(-3, 3, length=100)
ys = range(-3, 3, length=100)

epsilon = 0.01
f(x,y) = x^2 - x * y + epsilon * y + y^4 
Z = [f(x,y) for x in xs, y in ys]

p1 = surface(xs, ys, Z,
    title = "Surface: f(x,y) = x² - x*y + epsilon*y - y⁴",
    xlabel = "x", ylabel = "y", zlabel = "z",
    legend = false)

p2 = contour(xs, ys, Z,
    title = "Contour: f(x,y) = x² - xy + epsilon*y - y⁴",
    xlabel = "x", ylabel = "y",
    levels = -20:1:20)

plot(p1, p2, layout = (1,2), size=(900,600))