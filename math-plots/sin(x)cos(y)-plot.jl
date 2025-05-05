import Pkg
using Plots

plotly()

f(x,y) = sin(x) * cos(y)

x = range(-5, 5, length=700)
y = range(-5, 5, length=700)
plot(x,y, f, st=:surface, title="x²-y³", xlabel="x", ylabel="y", zlabel="f(x,y)", legend=false)