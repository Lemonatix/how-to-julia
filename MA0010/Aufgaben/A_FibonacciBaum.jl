### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ f6c6f32e-8b61-11f0-2031-150dd1ae1084
md"""
# Aufrufbaum beim rekursiven Fibonacci Beispiel

Betrachte folgendes Beispiel aus der Vorlesung:

```julia
function fibonacci(n) 
    return n < 2 ? one(n) : fibonacci(n-2) + fibonacci(n-1)
end
```

!!! correct "Aufgabe"
    Schreibe eine Funktion `draw_fib_tree(n)`, welche die 
    "Aufrufbäume" (als Liste von Strings) zurückgibt:

    ```julia
    8-element Vector{String}:
     "─5┬─3┬─1"
     "  │  └─2┬─0"
     "  │     └─1"
     "  └─4┬─2┬─0"
     "     │  └─1"
     "     └─3┬─1"
     "        └─2┬─0"
     "           └─1"
    ```

Damit kann man dann wie folgt die Bäume schön zeichnen:

```julia
foreach(println, draw_fib_tree(5))
─5┬─3┬─1
  │  └─2┬─0
  │     └─1
  └─4┬─2┬─0
     │  └─1
     └─3┬─1
        └─2┬─0
           └─1
```


Oder für $n=7$:

```julia
foreach(println, draw_fib_tree(7))
─7┬─5┬─3┬─1
  │  │  └─2┬─0
  │  │     └─1
  │  └─4┬─2┬─0
  │     │  └─1
  │     └─3┬─1
  │        └─2┬─0
  │           └─1
  └─6┬─4┬─2┬─0
     │  │  └─1
     │  └─3┬─1
     │     └─2┬─0
     │        └─1
     └─5┬─3┬─1
        │  └─2┬─0
        │     └─1
        └─4┬─2┬─0
           │  └─1
           └─3┬─1
              └─2┬─0
                 └─1
```
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─f6c6f32e-8b61-11f0-2031-150dd1ae1084
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
