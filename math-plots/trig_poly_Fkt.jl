using Plots
plotly()

f(x,y) = (x^2 + 2*y^2) * cos(x+y)

x = range(-1, 1, length=100)
y = range(-1, 1, length=100)
plot(x,y, f, st=:surface, xlabel="x", ylabel="y", zlabel="f(x,y)", legend=false)