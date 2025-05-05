using Plots

xs = range(-2, 2, length=20)
ys = range(-2, 2, length=20)
points = [(x,y) for x in xs for y in ys]

x_coords = [p[1] for p in points]
y_coords = [p[2] for p in points]

u = [p[2] for p in points]         
v = zeros(length(points))           

quiver(
    x_coords, y_coords,
    quiver = (u, v),
    aspect_ratio = 1,              
    xlabel = "x", ylabel = "y",
    title  = "Vektorfeld f(x,y) = (y, 0)"
)
