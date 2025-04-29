import Pkg
using Plots

# Use the GR backend for animation support
gr()

f(x, y) = x^2 / a^2 - y^2 / b^2

x = -7:0.1:7
y = -7:0.1:7
a = 1
b = 1

anim = @animate for azimuth in 0:8:360
    plot(
        x, y, f,
        st=:surface,
        title="Hyperbolic Paraboloid",
        xlabel="x", ylabel="y", zlabel="f(x,y)",
        legend=false,
        camera=(azimuth, 30),
        color=cgrad([:orange, :yellow]),
    )
end

gif(anim, "hyperbolic_paraboloid_rotation.gif", fps=30)