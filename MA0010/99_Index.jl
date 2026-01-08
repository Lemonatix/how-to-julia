### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 0732fe12-97bf-11f0-10bd-cd38a49c23fc
md"""
# Index

Ein Index für (fast) alle Typen, Funktionen, Keywords, etc. die im Kurs auftauchen.

## A

* [`a:b`](https://docs.julialang.org/en/v1/base/math/#Base.range)
* [`...`](https://docs.julialang.org/en/v1/manual/faq/#What-does-the-...-operator-do?)
* [`a?b:c`](https://docs.julialang.org/en/v1/base/base/#?:)
* [`all`](https://docs.julialang.org/en/v1/base/collections/#Base.all-Tuple%7BAny%7D)
* [`any`](https://docs.julialang.org/en/v1/base/collections/#Base.any-Tuple%7BAny%7D)
* [`append!`](https://docs.julialang.org/en/v1/base/collections/#Base.append!)

## B

* [`begin`](https://docs.julialang.org/en/v1/base/base/#begin)
* [`Bool`](https://docs.julialang.org/en/v1/base/numbers/#Core.Bool)
* [`broadcast`](https://docs.julialang.org/en/v1/base/arrays/#Base.Broadcast.broadcast)

## C

* [`cat`](https://docs.julialang.org/en/v1/base/arrays/#Base.cat)
* [`Char`](https://docs.julialang.org/en/v1/base/strings/#Core.Char)
* [`checked_add`](https://docs.julialang.org/en/v1/base/math/#Base.Checked.checked_add)
* [`checked_div`](https://docs.julialang.org/en/v1/base/math/#Base.Checked.checked_div)
* [`checked_mul`](https://docs.julialang.org/en/v1/base/math/#Base.Checked.checked_mul)
* [`checked_sub`](https://docs.julialang.org/en/v1/base/math/#Base.Checked.checked_sub)
* [`collect`](https://docs.julialang.org/en/v1/base/collections/#Base.collect-Tuple%7BAny%7D)
* [Comprehensions](https://docs.julialang.org/en/v1/manual/arrays/#man-comprehensions) z.B. `[  for ...]`
* [`cumsum`](https://docs.julialang.org/en/v1/base/arrays/#Base.cumsum)

## D

* [`Dict`](https://docs.julialang.org/en/v1/base/collections/#Base.Dict)
* [`diff`](https://docs.julialang.org/en/v1/base/arrays/#Base.diff)
* [`digits`](https://docs.julialang.org/en/v1/base/numbers/#Base.digits)
* [`do`](https://docs.julialang.org/en/v1/base/base/#do)
* [`dump`](https://docs.julialang.org/en/v1/base/io-network/#Base.dump)

## E

* [`@enum`](https://docs.julialang.org/en/v1/base/base/#Base.Enums.@enum)
* [`else`](https://docs.julialang.org/en/v1/base/base/#if)
* [`elseif`](https://docs.julialang.org/en/v1/base/base/#if)
* [`end`](https://docs.julialang.org/en/v1/base/base/#end)
* [`enumerate`](https://docs.julialang.org/en/v1/base/iterators/#Base.Iterators.enumerate)
* [`exp`](https://docs.julialang.org/en/v1/base/math/#Base.exp-Tuple%7BFloat64%7D)

## F

* [`false`](https://docs.julialang.org/en/v1/base/numbers/#Core.Bool)
* [`filter`](https://docs.julialang.org/en/v1/base/collections/#Base.filter)
* [`findfirst`](https://docs.julialang.org/en/v1/base/arrays/#Base.findfirst-Tuple{Any})
* [`findlast`](https://docs.julialang.org/en/v1/base/arrays/#Base.findlast-Tuple%7BAny%7D)
* [`for`](https://docs.julialang.org/en/v1/base/base/#for)
* [`function`](https://docs.julialang.org/en/v1/base/base/#function)

## I

* [`@isdefined`](https://docs.julialang.org/en/v1/base/base/#Base.@isdefined)
* [`if`](https://docs.julialang.org/en/v1/base/base/#if)
* [`in`](https://docs.julialang.org/en/v1/base/collections/#Base.in)
* [`Int8`](https://docs.julialang.org/en/v1/base/numbers/#Core.Int8)
* [`Int16`](https://docs.julialang.org/en/v1/base/numbers/#Core.Int16)
* [`Int32`](https://docs.julialang.org/en/v1/base/numbers/#Core.Int32)
* [`Int64`](https://docs.julialang.org/en/v1/base/numbers/#Core.Int64)
* [`Int128`](https://docs.julialang.org/en/v1/base/numbers/#Core.Int128)
* [`Int`](https://docs.julialang.org/en/v1/base/collections/#Base.Dict)
* [`intersect`](https://docs.julialang.org/en/v1/base/collections/#Base.intersect)
* [`iseven`](https://docs.julialang.org/en/v1/base/numbers/#Base.iseven)
* [`ismutable`](https://docs.julialang.org/en/v1/base/base/#Base.ismutable)
* [`isodd`](https://docs.julialang.org/en/v1/base/numbers/#Base.isodd)

## K

* [`kron`](https://docs.julialang.org/en/v1/stdlib/LinearAlgebra/#Base.kron)

## L

* [`length`](https://docs.julialang.org/en/v1/base/collections/#Base.length)
* [`let`](https://docs.julialang.org/en/v1/base/base/#let)

## M

* [`map`](https://docs.julialang.org/en/v1/base/collections/#Base.map)
* [`methods`](https://docs.julialang.org/en/v1/base/base/#Base.methods)
* [`mutable struct`](https://docs.julialang.org/en/v1/base/base/#mutable%20struct)

## N

* [`ndigits`](https://docs.julialang.org/en/v1/base/math/#Base.ndigits)
* [`nothing`](https://docs.julialang.org/en/v1/base/constants/#Core.nothing)

## O

* [`one`](https://docs.julialang.org/en/v1/base/numbers/#Base.one)
* [`ones`](https://docs.julialang.org/en/v1/base/arrays/#Base.ones)

## P

* [`Pair`](https://docs.julialang.org/en/v1/base/collections/#Core.Pair)
* [`pop!`](https://docs.julialang.org/en/v1/base/collections/#Base.pop!)
* [`print`](https://docs.julialang.org/en/v1/base/io-network/#Base.print)
* [`println`](https://docs.julialang.org/en/v1/base/io-network/#Base.println)
* [`push!`](https://docs.julialang.org/en/v1/base/collections/#Base.push!)

## R

* [`rand`](https://docs.julialang.org/en/v1/stdlib/Random/#Base.rand)
* [`randperm`](https://docs.julialang.org/en/v1/stdlib/Random/#Random.randperm)
* [`range`](https://docs.julialang.org/en/v1/base/math/#Base.range)
* [`Rational`](https://docs.julialang.org/en/v1/base/numbers/#Base.Rational)
* [`reinterpret`](https://docs.julialang.org/en/v1/base/arrays/#Base.reinterpret)
* [`return`](https://docs.julialang.org/en/v1/base/base/#return)
* [`reverse`](https://docs.julialang.org/en/v1/base/arrays/#Base.reverse-Tuple%7BAbstractVector%7D)
* [`reverse!`](https://docs.julialang.org/en/v1/base/arrays/#Base.reverse!)

## S

* [`@show`](https://docs.julialang.org/en/v1/base/base/#Base.@show)
* [`Set`](https://docs.julialang.org/en/v1/base/collections/#Base.Set)
* [`similar`](https://docs.julialang.org/en/v1/base/arrays/#Base.similar)
* [`size`](https://docs.julialang.org/en/v1/base/arrays/#Base.size)
* [`sizeof`](https://docs.julialang.org/en/v1/base/base/#Base.sizeof-Tuple%7BType%7D)
* [`string`](https://docs.julialang.org/en/v1/base/strings/#Base.string)
* [`String`](https://docs.julialang.org/en/v1/base/strings/#Core.String-Tuple%7BAbstractString%7D)
* [`struct`](https://docs.julialang.org/en/v1/base/base/#struct)
* [`sum`](https://docs.julialang.org/en/v1/base/collections/#Base.sum)

## T

* [`true`](https://docs.julialang.org/en/v1/base/numbers/#Core.Bool) 
* [`Tuple`](https://docs.julialang.org/en/v1/base/base/#Core.Tuple)
* [`tuple`](https://docs.julialang.org/en/v1/base/base/#Core.tuple)
* [`typemax`](https://docs.julialang.org/en/v1/base/base/#Base.typemax)
* [`typemin`](https://docs.julialang.org/en/v1/base/base/#Base.typemin)
* [`typeof`](https://docs.julialang.org/en/v1/base/base/#Core.typeof)

## U

* [`UInt8`](https://docs.julialang.org/en/v1/base/numbers/#Core.UInt8) 
* [`UInt16`](https://docs.julialang.org/en/v1/base/numbers/#Core.UInt16)
* [`UInt32`](https://docs.julialang.org/en/v1/base/numbers/#Core.UInt32)
* [`UInt64`](https://docs.julialang.org/en/v1/base/numbers/#Core.UInt64)
* [`UInt128`](https://docs.julialang.org/en/v1/base/numbers/#Core.UInt128)
* [`UInt`](https://docs.julialang.org/en/v1/base/numbers/#Core.UInt)
* [`union`](https://docs.julialang.org/en/v1/base/collections/#Base.union)

## V

* [`Vector`](https://docs.julialang.org/en/v1/base/arrays/#Base.Vector)
* [`view`](https://docs.julialang.org/en/v1/base/arrays/#Base.view)

## W

* [`@which`](https://docs.julialang.org/en/v1/base/base/#Base.which-Tuple%7BAny,%20Any%7D)
* [`while`](https://docs.julialang.org/en/v1/base/base/#while)

## Z

* [`zeros`](https://docs.julialang.org/en/v1/base/arrays/#Base.zeros)


## Rest
* [`!==`](https://docs.julialang.org/en/v1/base/math/#Base.:!==)
* [`!=`](https://docs.julialang.org/en/v1/base/math/#Base.:!=)
* [`!`](https://docs.julialang.org/en/v1/base/math/#Base.:!) 
* [`%`](https://docs.julialang.org/en/v1/base/math/#Base.rem)
* [`&&`](https://docs.julialang.org/en/v1/base/math/#&&)
* [`&`](https://docs.julialang.org/en/v1/base/math/#Base.:&)
* [`*`](https://docs.julialang.org/en/v1/base/math/#Base.:*-Tuple{Any,%20Vararg{Any}})
* [`+`](https://docs.julialang.org/en/v1/base/math/#Base.:+)
* [`-`](https://docs.julialang.org/en/v1/base/math/#Base.:--Tuple{Any,%20Any})
* [`//`](https://docs.julialang.org/en/v1/base/math/#Base.://) 
* [`/`](https://docs.julialang.org/en/v1/base/math/#Base.:/)
* [`<`](https://docs.julialang.org/en/v1/base/math/#Base.:%3C)
* [`===`](https://docs.julialang.org/en/v1/base/base/#Core.:===)
* [`==`](https://docs.julialang.org/en/v1/base/math/#Base.:==)
* [`=>`](https://docs.julialang.org/en/v1/base/collections/#Core.Pair)
* [`=`](https://docs.julialang.org/en/v1/base/base/#=) (auch `+=`, `*=`, etc.) 
* [`>`](https://docs.julialang.org/en/v1/base/math/#Base.:%3E)
* [`^`](https://docs.julialang.org/en/v1/base/math/#Base.:^-Tuple{Number,%20Number})
* [`|`](https://docs.julialang.org/en/v1/base/math/#Base.:|)
* [`||`](https://docs.julialang.org/en/v1/base/math/#||)
* [`÷`](https://docs.julialang.org/en/v1/base/math/#Base.div-Tuple%7BAny,%20Any,%20RoundingMode%7D)
* [`∊`](https://docs.julialang.org/en/v1/base/collections/#Base.in)
* [`≤`](https://docs.julialang.org/en/v1/base/math/#Base.:%3C=)
* [`≥`](https://docs.julialang.org/en/v1/base/math/#Base.:%3E=)
* [`⊻`](https://docs.julialang.org/en/v1/base/math/#Base.xor)
* [`⊽`](https://docs.julialang.org/en/v1/base/math/#Base.nor)
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.6"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─0732fe12-97bf-11f0-10bd-cd38a49c23fc
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
