### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 5c68793a-7689-11ef-2e10-4d87b3ce14c0
md"""
# Nochmal Geldwechseln (iterativ)

Aus dem Rekursionskapitel haben wir die wirklich unschöne
`liefere_euro_stückelungen_iter` gesehen.

Sie verwendete vorab (hard-kodiert) die möglichen Münzen. Die rekursive
Variante (für beliebig vorgegebene Münzen) war schöner und kürzer.

Es ist jetzt an der Zeit das Geldwechsel-Problem auch iterativ
(für beliebig vorgegebene Münzen) zu lösen.

Hier nochaml die unschöne hard-coded Variante:
"""

# ╔═╡ 2d186c0c-e2ff-4c03-b739-e9f72f203aac
function liefere_euro_stückelungen_iter(n)
	ergebnis = Vector{Vector{Int}}() # hier kommen die Stückelungen rein	
	max_200 = n ÷ 200 # wie oft geht die 200 cent Münze maximal rein
	for anz_200 in max_200:-1:0 # wir probieren alle aus
		rest_ohne_200 = n - anz_200*200
		max_100 = rest_ohne_200 ÷ 100 # wie oft geht die 100 cent Münze max. rein
		for anz_100 in max_100:-1:0 # wir probieren alle aus
			rest_ohne_100 = rest_ohne_200 - anz_100*100
			max_50 = rest_ohne_100 ÷ 50 # wie oft geht die 50 cent Münze max. rein
			for anz_50 in max_50:-1:0 # auch die probieren wir alle
				rest_ohne_50 = rest_ohne_100 - anz_50*50
				max_20 = rest_ohne_50 ÷ 20
				for anz_20 in max_20:-1:0
					rest_ohne_20 = rest_ohne_50 - anz_20*20
					max_10 = rest_ohne_20 ÷ 10
					for anz_10 in max_10:-1:0
						rest_ohne_10 = rest_ohne_20 - anz_10*10
						max_5 = rest_ohne_10 ÷ 5
						for anz_5 in max_5:-1:0
							rest_ohne_5 = rest_ohne_10 - anz_5*5
							max_2 = rest_ohne_5 ÷ 2
							for anz_2 in max_2:-1:0
								rest_ohne_2 = rest_ohne_5 - anz_2*2
								# der wird mit 1cent aufgefüllt
								push!(ergebnis, [rest_ohne_2, anz_2, anz_5, anz_10,
								                 anz_20, anz_50, anz_100, anz_200])
							end
						end
					end
				end
			end
		end
	end
	return ergebnis
end

# ╔═╡ beed85d8-c74e-4ae3-b5e2-f4370e8fcd2f
# Der Default, falls nichts anderes angegeben:
const münzen = [1, 2, 5, 10, 20, 50, 100, 200]  # Einheit: Cents

# ╔═╡ 8f284d93-f799-4821-87b3-07cc0359cb27
md"""
!!! correct "Aufgabe"
    Programmiere eine schöne iterative Methode, welche auch die erlaubten
    Münzen als Eingabe nimmt.
"""

# ╔═╡ a4ac21fb-03b0-4251-ab1b-45e87a2e966d
"""
ermittle iterative alle Möglichkeiten den Geldbetrag n zu wechslen, wenn
`verwende_münzen` die erlaubten Münzen enthält.

Die Einträge in `verwende_münzen` müssen streng monoton steigen und
mit `1` beginnen!
"""
function liefere_stückelungen_iter(n, verwende_münzen=münzen)
	stückelungen = Vector{Vector{Int}}() # hier kommen die Stückelungen rein
	error("Der Rest fehlt")
	return stückelungen
end

# ╔═╡ 57a31544-a198-4bcd-9caf-10aab6f0d584
liefere_stückelungen_iter(101)

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
# ╟─5c68793a-7689-11ef-2e10-4d87b3ce14c0
# ╠═2d186c0c-e2ff-4c03-b739-e9f72f203aac
# ╠═beed85d8-c74e-4ae3-b5e2-f4370e8fcd2f
# ╟─8f284d93-f799-4821-87b3-07cc0359cb27
# ╠═a4ac21fb-03b0-4251-ab1b-45e87a2e966d
# ╠═57a31544-a198-4bcd-9caf-10aab6f0d584
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
