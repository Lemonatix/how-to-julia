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

# show that 2 strings are the same
println("e_str1 == e_str2: $(e_str1 == e_str2)") # e_str1 == e_str2 is enough

# available number format characters are f, e, a, g, c, s, p, d:
@printf "fix trailing precision: %0.3f\n" float(pi)
@printf "scientific form: %0.6e\n" 1000pi
@printf "float in hexadecimal format: %a\n" 0xff
@printf "fix trailing precision: %g\n" pi*1e8
@printf "a character: %c\n" 'α'
@printf "a string: %s\n" "look I'm a string!"
@printf "right justify a string: %50s\n" "width 50, text right justified!"
@printf "a pointer: %p\n" 100000000
@printf "print an integer: %d\n" 1e10