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

show(s1[5]); println() # indexing starts at 1 instead of 0 like in Python
show(s1[1:5]); println() # slicing is similar to Python, last character is included

a = "Hello"
b = "me"
println("$a to $b") # string interpolation

println("1 + 2 = $(1 + 2)")

s2 = "this" * " and" * " that" # string concatenation with *
println(s2)

s3 = string("this", " and", " that") # string concatenation with string()
println(s3)