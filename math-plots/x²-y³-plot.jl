import Pkg
using Plots

plotly()

f(x,y) = x^2 - y^3

x = -7:0.1:7
y = -7:0.1:7
plot(x,y, f, st=:surface, title="x²-y³", xlabel="x", ylabel="y", zlabel="f(x,y)", legend=false)