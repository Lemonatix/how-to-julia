### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ ad7690aa-a4eb-11f0-1cbb-27f8b6b5493d
md"""
# Aufgabe: Summe

Vorab *Achtung*: Das ist eine akademische Aufgabe. Es gibt in julia `sum`.

!!! correct "Aufgabe"
    Schreibe eine julia Funktion `summe(vektor)` die für einen
    Integer-Vektor `vektor` die Summe der Elemente berechnet.

Schreibe mehrere Implementierungen. Vergleiche auch mit `sum`.
"""

# ╔═╡ 2a05d2cd-9071-4088-846c-a19ab53a0bd9
summe(vektor) = isempty(vektor) ? 0 : vektor[1] + summe(vektor[2:end])

# ╔═╡ 0d70c5b9-1b3d-42ae-b15f-c549d76c7f50
md"""
!!! danger "Achtung"
    Obige `summe([a,b])` liefert nicht immer `a+b` als Ergebnis!!!
    Überlege jetzt (ohne weiterzulesen), *Warum?*

Hier ein Beispiel:
"""

# ╔═╡ d9389cb5-8a1f-4162-9e46-739a39f2a8bd
md"""
```














```
"""

# ╔═╡ a06190f3-6df4-4918-8881-9891322a25aa
summe([Int8(100), Int8(100)])

# ╔═╡ a7181c6c-5d0c-4e9b-be87-6c627bd2489f
Int8(100) + Int8(100)

# ╔═╡ 72e83205-8432-4b57-b681-36c6a6d7b681
summe2(vektor) = isempty(vektor) ? zero(eltype(vektor)) : vektor[1] + summe2(vektor[2:end])

# ╔═╡ 6c833814-8513-4ad7-9ebe-d9b124f927e2
summe2([Int8(100), Int8(100)])

# ╔═╡ 2d1eea58-8f04-4d36-8df3-b05914123680
function summe3(vektor)
	ergebnis = zero(eltype(vektor))
	for wert in vektor
		ergebnis += wert
	end
	return ergebnis	
end

# ╔═╡ f1c0dd51-4b93-4861-a6f4-4f42b85f1011
summe4(vektor) = reduce(+, vektor)

# ╔═╡ 2b213a58-98ed-4402-9303-2a6e203e5d7b
summe4([Int8(100), Int8(100)])

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
# ╟─ad7690aa-a4eb-11f0-1cbb-27f8b6b5493d
# ╠═2a05d2cd-9071-4088-846c-a19ab53a0bd9
# ╟─0d70c5b9-1b3d-42ae-b15f-c549d76c7f50
# ╟─d9389cb5-8a1f-4162-9e46-739a39f2a8bd
# ╠═a06190f3-6df4-4918-8881-9891322a25aa
# ╠═a7181c6c-5d0c-4e9b-be87-6c627bd2489f
# ╠═72e83205-8432-4b57-b681-36c6a6d7b681
# ╠═6c833814-8513-4ad7-9ebe-d9b124f927e2
# ╠═2d1eea58-8f04-4d36-8df3-b05914123680
# ╠═f1c0dd51-4b93-4861-a6f4-4f42b85f1011
# ╠═2b213a58-98ed-4402-9303-2a6e203e5d7b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
