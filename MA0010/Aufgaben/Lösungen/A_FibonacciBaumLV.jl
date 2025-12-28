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

# ╔═╡ fee2b776-e137-4b7e-b95d-7fd2d41d9b4c
md"""
## Die Rekursionsidee

Wir überlegen uns die Idee für $n=5$, aber programmieren sie für ein
beliebiges $n$.
"""

# ╔═╡ 359ea703-d8b0-44e0-be3d-c52c207f1b21
html"""
<pre>
<span style="color:red">─5┬</span><span style="color:green">─3┬─1</span>
<span style="color:red">  │</span><span style="color:green">  └─2┬─0</span>
<span style="color:red">  │</span><span style="color:green">     └─1</span>
<span style="color:red">  └─</span><span style="color:blue" >4┬─2┬─0</span>
     <span style="color:blue" >│  └─1</span>
     <span style="color:blue" >└─3┬─1</span>
     <span style="color:blue" >   └─2┬─0</span>
     <span style="color:blue" >      └─1</span>
</pre>
"""

# ╔═╡ 9a18d30d-d2c2-4bca-8d26-8ee481e0aefd
md"""
Wir kümmern uns um den roten Teil und rufen für den grünen und blauen Teil
die Funktion rekursiv auf.

Wir erhalten also grün 

```
3-element Vector{String}:
 "─3┬─1"
 "  └─2┬─0"
 "     └─1"
```

und blau 

```
5-element Vector{String}:
 "─4┬─2┬─0"
 "  │  └─1"
 "  └─3┬─1"
 "     └─2┬─0"
 "        └─1"
```

durch zwei Aufrufe und müssen uns nur noch
um das ordentliche Zusammenbauen (die rote Dinge) kümmern.

Die Fälle $n=1$ und $n=2$ bilden den "Anfang" der Rekursion, denn sie
haben keine weiteren Kinder. Sie werden extra behandelt und liefern einfach 
die Strings `"─1"` bzw. `"─2"`.
"""

# ╔═╡ f5e793e2-a5a5-47f3-abc5-c5a1daaa3c9f
function draw_fib_tree1(n) :: Vector{String}
    if n == 0 || n == 1; return ["─" * string(n)] ; end	
    nlen = ndigits(n)
	result = Vector{String}()
	# grünen Teil (oben) und rot davor
	for (index, zeile) in enumerate(draw_fib_tree1(n-2))
		if index == 1
			push!(result, "─" * string(n) * "┬" * zeile)
		else
			push!(result, " "^(nlen+1)    * "│" * zeile)
		end
	end
	# blauen Teil (unten) und rot davor
	for (index, zeile) in enumerate(draw_fib_tree1(n-1))
		if index == 1
			push!(result, " "^(nlen+1)    * "└" * zeile)
		else
			push!(result, " "^(nlen+2)          * zeile)
		end
	end
	return result
end

# ╔═╡ df449308-a5aa-404f-b13c-f3c9c3237476
md"""
Ok. Aber das können wir kompatker schreiben mit dem ` ? : ` Operator:
"""

# ╔═╡ be115fb5-97f3-412b-a2c1-5b5da1b9fea9
function draw_fib_tree2(n) :: Vector{String}
    if n == 0 || n == 1; return ["─" * string(n)] ; end	
    nlen = ndigits(n)
	result = Vector{String}()
	# grünen Teil (oben) und rot davor
	for (index, zeile) in enumerate(draw_fib_tree2(n-2))
		push!(result, (index == 1) ? 
			  "─" * string(n) * "┬" * zeile :
			  " "^(nlen+1)    * "│" * zeile)
	end
	# blauen Teil (unten) und rot davor
	for (index, zeile) in enumerate(draw_fib_tree2(n-1))
		push!(result, (index == 1) ? 
			  " "^(nlen+1)    * "└" * zeile :
			  " "^(nlen+2)          * zeile)
	end
	return result
end

# ╔═╡ e7ef2107-e90d-41c6-8685-09d32671e77e
md"""
Jetzt werden aber immer noch die Zeilen einzeln per `push!` an
`result` angehängt. Mit "List-Comprehension" kann man
den ganzen String-Vektor so bauen:
"""

# ╔═╡ d534a668-6d26-49b5-979f-1a154cd2ba4d
function draw_fib_tree(n) :: Vector{String}
    if n == 0 || n == 1; return ["─" * string(n)] ; end
    nlen = ndigits(n) + 1
    return [
      [(index == 1) ? "─" * string(n) * "┬" * zeile : 
                      " "^nlen        * "│" * zeile
            for (index, zeile) in enumerate(draw_fib_tree(n-2))];
      [(index == 1) ? " "^nlen        * "└" * zeile :
                      " "^(nlen+1)          * zeile
            for (index, zeile) in enumerate(draw_fib_tree(n-1))]]
end

# ╔═╡ 5541fc42-c26b-420f-b7cd-c45128d0acf0
foreach(println, draw_fib_tree(2))

# ╔═╡ 42a4fd08-1a22-4e9e-89d5-a2bec70d7dbf
foreach(println, draw_fib_tree(3))

# ╔═╡ 38a72962-cb69-496c-a4a8-56985fa9d636
draw_fib_tree(5)

# ╔═╡ 4471aeb6-c457-431d-a9a0-944f48f540d8
foreach(println, draw_fib_tree(5))

# ╔═╡ fe9d810c-2775-47dc-9440-f326629af109
foreach(println, draw_fib_tree(7))

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
# ╟─fee2b776-e137-4b7e-b95d-7fd2d41d9b4c
# ╟─359ea703-d8b0-44e0-be3d-c52c207f1b21
# ╟─9a18d30d-d2c2-4bca-8d26-8ee481e0aefd
# ╠═f5e793e2-a5a5-47f3-abc5-c5a1daaa3c9f
# ╟─df449308-a5aa-404f-b13c-f3c9c3237476
# ╠═be115fb5-97f3-412b-a2c1-5b5da1b9fea9
# ╟─e7ef2107-e90d-41c6-8685-09d32671e77e
# ╠═d534a668-6d26-49b5-979f-1a154cd2ba4d
# ╠═5541fc42-c26b-420f-b7cd-c45128d0acf0
# ╠═42a4fd08-1a22-4e9e-89d5-a2bec70d7dbf
# ╠═38a72962-cb69-496c-a4a8-56985fa9d636
# ╠═4471aeb6-c457-431d-a9a0-944f48f540d8
# ╠═fe9d810c-2775-47dc-9440-f326629af109
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
