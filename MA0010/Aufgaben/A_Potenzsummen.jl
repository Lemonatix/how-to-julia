### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ 76a3cd18-8cba-11f0-20d8-399d3fa4eb95
md"""
# Potenzsummen

Es gilt für $m=100$:

$$m = 100 = 1^2 + 3^2 + 4^2 + 5^2 + 7^2 = 6^2 + 8^2 = 10^2.$$

Soweit so klar. 

!!! correct "Aufgabe"
    Schreibe eine Funktion `powersum_n(m, n)`,
    die für $m\in\mathbb{N}$ alle Potenzsummen 
    (mit Exponent $n$) der Form
    
    $$m = \sum a_j^n$$
    
    mit $a_1<a_2<a_3\cdots$ findet.

Die Rückgabe sollte ein Vektor wobei jeder Eintrag
ein Vektor mit den Koeffizienten $a_j$ ist.

Beispiel:

```julia
powersum_n(100, 2)
3-element Vector{Vector{Int64}}:
 [1, 3, 4, 5, 7]
 [6, 8]
 [10]
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
# ╟─76a3cd18-8cba-11f0-20d8-399d3fa4eb95
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
