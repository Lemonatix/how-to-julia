using Plots
plotly()

# 1) Originalfunktion und Taylor-Polynome definieren
g(x,y)     = x^y
T1b(x,y)   = 1 + (x-1)
T2b(x,y)   = 1 + (x-1) + (x-1)*(y-1)

# 2) Gitter um (1,1)
xs = range(0.5, 1.5, length=200)
ys = range(0.5, 1.5, length=200)

# 3) Z-Werte berechnen
Zg   = [g(x,y)      for x in xs, y in ys]
Z1b  = [T1b(x,y)    for x in xs, y in ys]
Z2b  = [T2b(x,y)    for x in xs, y in ys]

# 4) Plot: Original | T1 | T2
plot(
  surface(xs, ys, Zg,  xlabel="x", ylabel="y", zlabel="g",  title="g(x,y)=x^y"),
  surface(xs, ys, Z1b, xlabel="x", ylabel="y", zlabel="T₁", title="T₁ um (1,1)"),
  surface(xs, ys, Z2b, xlabel="x", ylabel="y", zlabel="T₂", title="T₂ um (1,1)"),
  layout = (1,3), size = (1200,400)
)
