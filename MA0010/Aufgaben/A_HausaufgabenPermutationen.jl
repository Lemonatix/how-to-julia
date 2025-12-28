### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 24c706f1-edc8-4947-b53e-26b2b78b9627
using Random

# ╔═╡ f8c7f498-79ab-11ef-0849-21d364d6b8db
md"""
# Hausaufgabenrückgabe, Hausaufgaben verteilen

[Diese Aufgabe orientiert sich stark an einer (alten) Aufgabe bei Prof. Rolles "Einführung in die W-Theorie".]

Es geben $n$ Personen ihre Hausaufgaben ab. Die korrigierten Hausaufgaben werden *zufällig* auf die $n$ Personen verteilt.

   1. Simuliere mit Julia dieses Zufallsexperiment mehrmals/oft und ermittle, 
      wie viele Personen (im Durchschnitt) die eigenen Hausaufgaben
      zurückbekommen.
      Wiederhole das Experiment für verschiedene $n$.
      Stelle eine Vermutung für den Erwartungswert für die Anzahl der
      Personen, die ihre eigenen Hausaufgaben bekommen, auf.

   2. Die Wahrscheinlichkeit, dass keine Person die eigene Hausaufgabe 
      bekommt, ist

      $P_n = \left({1 - \dfrac 1 {1!} + \dfrac 1 {2!} - \dfrac 1 {3!} + \dotsb + \left({-1}\right)^n \dfrac 1 {n!} }\right) = \sum_{k=0}^n \frac{(-1)^k}{k!}.$

      Schreibe eine Funktion, welche für ein gegebenes $m$ die 
      Wahrscheinlichkeiten $P_1,\ldots,P_m$ berechnet.
"""

# ╔═╡ 6ee5273b-4bb1-4525-b35e-b7d26dfa6e59
md"""
Hinweis zu Permutationen: (`using Random`) und `randperm()`:
"""

# ╔═╡ 17b433e5-91ee-40ad-b9f3-b395d823fa83
@doc randperm

# ╔═╡ f7d196f7-2824-4010-a269-6fda0486ab6e
md"""
## Simulation

Wir müssen folgendes tun:

   1. Hausaufgaben zufällig permutieren
   2. Prüfen, wie viele Personen die eigene Hausaufgabe bekommen haben
   3. Die Punkte 1. und 2. hinreichend oft wiederholen und über 
      die Werte mitteln (Durchschnitt)
"""

# ╔═╡ e09b01cc-5c9e-4ec8-8c0d-82b7ad1ea6a2
"""
Simulation für `n` Personen. Es wird `versuche` oft simuliert.

Rückgabe ist der Durchschnitt.
"""
function simuliere_Rückgabe(n,versuche)
	# hier fehlt die Implementierung
	return 0 # liefere einfach 0; bitte verbessern
end

# ╔═╡ 50edfbd0-20b2-431e-97dc-680eae0ede7c
simuliere_Rückgabe(200, 10_000)

# ╔═╡ 2cac0f47-31c7-46f8-a03e-c9dec93169e6
simuliere_Rückgabe(20, 10_000)

# ╔═╡ 0318e914-621b-4554-863c-437361e3fe71
simuliere_Rückgabe(2000, 10_000)

# ╔═╡ bf7b81a1-29cc-4039-beac-724a29eb3487
simuliere_Rückgabe(2000, 100_000)

# ╔═╡ 9a2c17c9-466b-49d3-a506-5d34d4e35db5
md"""
## Wahrscheinlichkeiten
"""

# ╔═╡ 380a1d38-a702-42ea-9be4-87e229c7d467
"""berechnet obige Wahrscheinlichkeiten P₁ bis Pₘ."""
function berechne_Wahrscheinlichkeiten(m)
	# hier fehlt der Code; liefere falches Ergebnis
	return 0
end

# ╔═╡ b77ab0b9-1276-45ef-b958-2836afd861d0
berechne_Wahrscheinlichkeiten(10)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "fa3e19418881bf344f5796e1504923a7c80ab1ed"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"
"""

# ╔═╡ Cell order:
# ╟─f8c7f498-79ab-11ef-0849-21d364d6b8db
# ╟─6ee5273b-4bb1-4525-b35e-b7d26dfa6e59
# ╟─17b433e5-91ee-40ad-b9f3-b395d823fa83
# ╟─f7d196f7-2824-4010-a269-6fda0486ab6e
# ╠═e09b01cc-5c9e-4ec8-8c0d-82b7ad1ea6a2
# ╠═50edfbd0-20b2-431e-97dc-680eae0ede7c
# ╠═2cac0f47-31c7-46f8-a03e-c9dec93169e6
# ╠═0318e914-621b-4554-863c-437361e3fe71
# ╠═bf7b81a1-29cc-4039-beac-724a29eb3487
# ╟─9a2c17c9-466b-49d3-a506-5d34d4e35db5
# ╠═380a1d38-a702-42ea-9be4-87e229c7d467
# ╠═b77ab0b9-1276-45ef-b958-2836afd861d0
# ╠═24c706f1-edc8-4947-b53e-26b2b78b9627
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
