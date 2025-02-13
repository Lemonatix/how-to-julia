string0 = "This is part of the introduction to Julia programming language."
println(string0)

print("this")
print(" and")
print(" that.\n") # \n is a newline character

c1 = 'a'
# the ascii value of a char can be found with Int():
println(c1, " ascii value = ", Int(c1))

s1 = "Hello there!"
s1_caps = uppercase(s1)
s1_lower = lowercase(s1) # if print isnt used, the latest line is printed
println(s1_caps, "\n", s1_lower)