using Plots
plotly()

# 1) Originalfunktion und Taylor-Polynome definieren
f(x,y)  = (x - y)/(x + y)
T1(h,k) =  0.5h - 0.5k
T2(h,k) =  0.5h - 0.5k - 0.25h^2 + 0.25k^2

# 2) Gitter – hier vermeiden wir x+y=0
xs = range(0.1, 2.0, length=200)
ys = range(0.1, 2.0, length=200)

# 3) Z-Werte berechnen
Zf  = [f(x,y)          for x in xs, y in ys]
Zt1 = [T1(x-1, y-1)    for x in xs, y in ys]
Zt2 = [T2(x-1, y-1)    for x in xs, y in ys]

# 4) Plot: Original | T1 | T2
plot(
  surface(xs, ys, Zf,  xlabel="x", ylabel="y", zlabel="f",  title="f(x,y)"),
  surface(xs, ys, Zt1, xlabel="x", ylabel="y", zlabel="T₁", title="T₁ um (1,1)"),
  surface(xs, ys, Zt2, xlabel="x", ylabel="y", zlabel="T₂", title="T₂ um (1,1)"),
  layout = (1,3), size = (1200,400)
)