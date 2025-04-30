import Pkg
using Plots

plotly()

f(x,y) = x^2/a^2 - y^2/b^2

x = -7:0.1:7
y = -7:0.1:7
a = 1
b = 1
plot(x,y, f, st=:surface, title="Hyperbolic Paraboloid", xlabel="x", ylabel="y", zlabel="f(x,y)", legend=false)