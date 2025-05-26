using Plots
using LinearAlgebra

# optional: interaktives 3D-Backend
plotlyjs()

# Basis­punkt und Verschiebung
x0 = [1.0, 2.0, 1.0]
h  = [0.5, -0.3, 0.2]

# Gradient an x0: ∇f = 2*(x+y+z)*[1,1,1]
grad = 2*(sum(x0)) * [1.0, 1.0, 1.0]   # z.B. [8.0,8.0,8.0]

# Linearer Anteil L(h)
Lh = dot(grad, h)

# Richtungseinheitsvektor des Gradienten
dir_grad = grad / norm(grad)
v        = dir_grad * Lh

# größere Achsgrenzen
lims = (-1.0, 4.0)

plt = plot(legend=:bottomright,
           title="3D: Verschiebung h, ∇f(x₀) und L(h)",
           xlabel="x", ylabel="y", zlabel="z",
           xlims=lims, ylims=lims, zlims=lims,
           aspect_ratio=:equal)

# Basispunkt
scatter!(plt, [x0[1]], [x0[2]], [x0[3]],
         label="x₀ = (1,2,1)", ms=3, color=:black)

# Verschiebung h (blau)
quiver!(plt,
        [x0[1]], [x0[2]], [x0[3]],
        quiver=([h[1]], [h[2]], [h[3]]),
        lw=2, lc=:blue,
        arrow = :arrow, arrowsize = 0.4,
        label="h")

# Gradient ∇f(x₀) (rot), moderat skaliert
quiver!(plt,
        [x0[1]], [x0[2]], [x0[3]],
        quiver=([grad[1]/5], [grad[2]/5], [grad[3]/5]),
        lw=3, lc=:red,
        arrow = :arrow, arrowsize = 0.4,
        label="∇f(x₀)/5")

# L(h) (grün)
quiver!(plt,
        [x0[1]], [x0[2]], [x0[3]],
        quiver=([v[1]], [v[2]], [v[3]]),
        lw=2, lc=:green,
        arrow = :arrow, arrowsize = 0.4,
        label="L(h) = Df·h")

display(plt)
