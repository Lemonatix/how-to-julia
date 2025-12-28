### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 81b6f240-8c5e-11f0-26c8-d3b65687cf9a
md"""
# Polynomdivision

Wir betrachten Polynome $p(x)=c_0 + c_1x^1 + c_2x^2 + \cdots + c_nx^n$ mit
rationalen Koeffizienten $c_k\in\mathbb{Q}$ in der monomialien Basis.

Wir speichern solche Polynome als Liste der Koeffizienten: $[c_0,c_1,\ldots,c_n]$.

!!! correct "Aufgabe"
    Schreibe eine Funktion `polydivision(p, q)`, die für 
    Polynome $p$ und $q$ die 
    [Polynomdivision](https://de.wikipedia.org/wiki/Polynomdivision)
    (mit Rest) durchführt und
    als Rückgabe das Ergebnispolynom und das Restpolynom hat.

Beispiel (aus Wikipedia):

Für $p(x)=-1 + x^2 - 2x^3 - x^4$ und $q(x) = 1 + x^2$ gilt

$$p(x) : q(x) = 2 -2x - x^2, \qquad \text{Rest:} -3 + 2x.$$

In Julia:

```julia
polydivision([-1, 0, 1, -2, -1], [1, 0, 1])
   ([2, -2, -1], [-3, 2])
```

!!! correct "Zusatz"
    Schreibe eine Funktion `show_polydivision(p, q)`, die
    die Polynome schön, darstellt, etwa:
    ```
    show_polydivision([-1, 0, 1, -2, -1], [1, 0, 1])

       (-x⁴ -2x³ +x² -1) : (x² +1) = -x² -2x +2   Rest: 2x -3
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
# ╟─81b6f240-8c5e-11f0-26c8-d3b65687cf9a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
