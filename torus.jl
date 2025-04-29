using Plots; plotlyjs()
Θ = ϕ = range(-π,π,300)
X = [(2 + cos(v)) * cos(u) for u in Θ, v in ϕ]
Y = [(2 + cos(v)) * sin(u) for u in Θ, v in ϕ]
Z = [1.5*sin(v) for u in Θ, v in ϕ]
surface(X, Y, Z, lims=(-3,3), size=(600,600), cbar=:none, legend=false, )