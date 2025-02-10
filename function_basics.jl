function sphere_vol(r)
    return 4/3 * pi * r^3 # pi can also be written as π
end

r = 2
println(sphere_vol(r))

vol = sphere_vol(3)
println(vol)