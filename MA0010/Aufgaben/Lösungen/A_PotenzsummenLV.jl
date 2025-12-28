### A Pluto.jl notebook ###
# v0.20.19

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

# ╔═╡ cfc94c9c-37b6-4085-838a-38cee580caaa
function powersum_n(m, n)
	result = Vector{Vector{Int64}}()
	# Liste mit Einträgen: (verwendete aⱼ-Liste, akt. Wert, nächstes aⱼ)
	todo_liste = [(Vector{Int64}(), 0, 1)] 
	
	while !isempty(todo_liste)
		aj_liste, wert, nächstes = pop!(todo_liste)		
		neuer_wert = wert + nächstes^n
		# Falls wert + nächstes^n zu groß? diese aj_liste ist nicht zielführend
		if neuer_wert > m  continue end  # Dead-End-Pfad
		# 1. Fall:  nächstes **nicht** verwenden
		push!(todo_liste, (aj_liste, wert, nächstes+1))
		# 2. Fall:  nächstes verwenden!
		aj_liste = copy(aj_liste)  # nächstes aⱼ in neuer(!) Liste
		push!(aj_liste, nächstes)
		if neuer_wert == m # Darstellung gefunden
			push!(result, aj_liste)
		else # neuer_wert < m
			push!(todo_liste, (aj_liste, neuer_wert, nächstes+1))
		end
	end
	return result
end

# ╔═╡ a8137b03-f012-4e57-8148-31e95d349dfc
powersum_n(100, 2)

# ╔═╡ ae04bea7-e1f1-4e97-8020-f1dadf6f8394
function powersum_n_recursive(m, n, start_with=1)
  result = Vector{Vector{Int64}}()
  for x in start_with:m
    first = x^n
    if first > m; break; end
    if m - first == 0
      push!(result, [x])
    else
      for subresult in powersum_n_recursive(m-first, n, x+1)
        push!(result, [x, subresult...])
      end
    end
  end
  return result
end


# ╔═╡ d895c506-5d68-4b86-a582-889c18cc5add
powersum_n_recursive(100, 2)

# ╔═╡ 457e20c1-3209-4899-b6b7-e147fdd194d4
powersum_n_recursive(10, 2)

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
# ╠═cfc94c9c-37b6-4085-838a-38cee580caaa
# ╠═a8137b03-f012-4e57-8148-31e95d349dfc
# ╠═ae04bea7-e1f1-4e97-8020-f1dadf6f8394
# ╠═d895c506-5d68-4b86-a582-889c18cc5add
# ╠═457e20c1-3209-4899-b6b7-e147fdd194d4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
