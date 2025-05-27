using Plots
plotly()  # oder pyplot(), plotly(), …

# 1) Taylor-Polynome aus H4.1b definieren
T1(x,y) = 1 + (x-1)
T2(x,y) = 1 + (x-1) + (x-1)*(y-1)

# 2) Gitter im (x,y)-Bereich um (1,1)
xs = range(0.5, 1.5, length=200)
ys = range(0.5, 1.5, length=200)

# 3) Z-Werte für T1/T2 berechnen
Z1 = [T1(x, y) for x in xs, y in ys]
Z2 = [T2(x, y) for x in xs, y in ys]

# 4) Zwei Surface-Plots nebeneinander
plot(
  surface(xs, ys, Z1, xlabel="x", ylabel="y", zlabel="T₁", title="T₁ für g(x,y)=x^y"),
  surface(xs, ys, Z2, xlabel="x", ylabel="y", zlabel="T₂", title="T₂ für g(x,y)=x^y"),
  layout = (1,2),
  size = (900,400)
)
