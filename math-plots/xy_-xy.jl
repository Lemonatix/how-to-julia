using GLMakie

# 1) Funktion definieren
f(x,y) = abs(y) < abs(x) ? x*y : -x*y

# 2) Gitter (je 100×100 Punkte)
xs = LinRange(-1, 1, 100)
ys = LinRange(-1, 1, 100)

# 3) Z-Werte in einer Matrix
Z = [f(x,y) for x in xs, y in ys]

# 4) Surface-Plot
fig = Figure(resolution = (600, 400))
ax = Axis3(fig[1,1], xlabel="x", ylabel="y", zlabel="f(x,y)")
GLMakie.surface!(ax, xs, ys, Z; colormap = :viridis)
fig
