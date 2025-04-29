import Pkg
using Plots

plotly()

f(x,y) = x^2/a^2 - y^2/b^2

x = -5:0.1:5
y = -5:0.1:5
a = 1
b = 1
plot(x,y, f, st=:surface, title="Hyperbolic Paraboloid", xlabel="x", ylabel="y", zlabel="f(x,y)", legend=false)