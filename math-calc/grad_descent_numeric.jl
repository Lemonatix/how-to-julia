function grad_f(x)
    x1, x2 = x
    return [cos(x1)*cos(x2), -sin(x1)*sin(x2)]
end

function run_gradient_descent()
    tau = 1.0; x = [1.0, 1.0]

    for k in 1:4
        x = x .- tau .* grad_f(x)
        println("k = $k: x = ", round.(x, digits=6))
    end
end

run_gradient_descent()