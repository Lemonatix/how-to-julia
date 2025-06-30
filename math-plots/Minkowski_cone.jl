using Plots
plotly()

θ = range(0, 2π, length=100)
t = range(-5, 5, length=100)
x = [t_i*cos(θ_j) for t_i in t, θ_j in θ]
y = [t_i*sin(θ_j) for t_i in t, θ_j in θ]
z = [t_i          for t_i in t, θ_j in θ]
surface(x, y, z; title="f(x,y,z) = x²+y²-z²", xlabel="x", ylabel="y")
