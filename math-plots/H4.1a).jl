using Plots
plotly()  # oder pyplot(), plotly(), …

# 1) Taylor-Polynome aus H4.1a definieren
#    T1(h,k)   = ½·h − ½·k
#    T2(h,k)   = ½·h − ½·k − ¼·h^2 + ¼·k^2
T1(h,k) =  0.5h - 0.5k
T2(h,k) =  0.5h - 0.5k - 0.25h^2 + 0.25k^2

# 2) Gitter im (x,y)-Bereich um (1,1)
xs = range(0.0, 2.0, length=200)
ys = range(0.0, 2.0, length=200)

# 3) h = x-1, k = y-1 und Z-Werte für T1/T2
Z1 = [T1(x-1, y-1) for x in xs, y in ys]
Z2 = [T2(x-1, y-1) for x in xs, y in ys]

# 4) Zwei Surface-Plots nebeneinander
plot(
  surface(xs, ys, Z1, xlabel="x", ylabel="y", zlabel="T₁", title="T₁(1,1)"),
  surface(xs, ys, Z2, xlabel="x", ylabel="y", zlabel="T₂", title="T₂(1,1)"),
  layout = (1,2),
  size = (900,400)
)