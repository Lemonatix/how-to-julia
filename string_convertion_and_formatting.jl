# strings convertion using float and int
e_str1 = "2.718"
e = parse(Float64, e_str1)
println(5e)

num_15 = parse(Int, "15")
println(3num_15)

# string convertion and formatting
using Printf # import Printf module
@printf "e = %0.2f\n" e # precision of 2 decimal places, \n is newline
e_str2 = @sprintf("%0.3f", e)