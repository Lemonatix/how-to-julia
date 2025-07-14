using Plots

F0 = 1.0
t = range(0, 20, length=1000)
z = (F0/2) .* t .* sin.(t)

plot(t, z, xlabel="t", ylabel="z(t)", title="Resonante Lösung z(t) = (F₀/2) · t · sin(t)", lw=2)
