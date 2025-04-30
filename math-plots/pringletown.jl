using Plots; gr()

a, b = 1.0, 1.0

x = -7:0.1:7
y = -7:0.1:7

f(x,y) = x^2/a^2 - y^2/b^2

bpm      = 122        
fps      = 30
period_s = 2*(60/bpm)  # two beats per full 360°
nframes  = round(Int, period_s*fps)
angles   = range(0, stop=360, length=nframes)

anim = @animate for az in angles
    surface(
        x, y, f,
        st            = :surface,
        title         = "Hyperbolic Paraboloid aka. Pringle",
        xlabel        = "x", ylabel = "y", zlabel = "z",
        legend        = false,
        camera        = (az, 30),
        color         = cgrad([:orange, :yellow]),
        shading       = :smooth,
        aspect_ratio  = :equal,
        xlims         = (-7,7), ylims = (-7,7),
    )
end

gif(anim, "hyperbolic_paraboloid_aka_pringle.gif", fps = fps)
