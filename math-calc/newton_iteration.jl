using LinearAlgebra, ForwardDiff

s(x,y) = (1 - x^2) / (x + y)
h(x,y) = sqrt(s(x,y)^2 - (y - x)^2)

Vhat(z) = begin
    x, y = z
    (π/3) * (x^2 + x*y + y^2) * h(x,y)
end

F(z) = ForwardDiff.gradient(Vhat, z)
J(z) = ForwardDiff.jacobian(F, z)

function newton_bgucket(z0; maxiter=10)
    z = copy(z0)
    for k in 1:maxiter
        z -= J(z) \ F(z)
    end
    return z
end

z0 = [1/sqrt(3), 1/sqrt(3)]
z  = newton_bucket(z0, maxiter=10)

x_opt, y_opt = z
println((x_opt, y_opt, s(x_opt,y_opt), h(x_opt,y_opt), Vhat(z)))
