import Pkg
using Plots

f(x,y) = x^2-y^2

x = -10:0.1:10
y = -10:0.1:10

plot(x,y, f, st=:surface, title="3D Surface Plot", xlabel="x", ylabel="y", zlabel="f(x,y)", legend=false)
