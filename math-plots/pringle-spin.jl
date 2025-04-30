import Pkg
using Plots

# Use the GR backend for animation support
gr()

f(x, y) = x^2 / a^2 - y^2 / b^2

x = -4:0.05:4
y = -2:0.05:2
a, b = 3.0, 1.5

anim = @animate for azimuth in 0:5.0:360
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