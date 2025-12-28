### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 91b09f2a-7754-11ef-26e1-b5c38b4013e0
md"""
# Bälle und Boxen (Teil 2)

Wir haben $n$ ununterscheidbare Bälle und $k$ nummerierte Boxen (mit
Nummern von $1,2,\ldots,k$).

!!! correct "Aufgabe"
    Schreibe ein Programm welches alle Möglichkeiten ausgibt
    die $n$ Bälle auf die $k$ Boxen zu verteilen.

    Die Rückgabe soll eine Liste sein, wobei jedes Element der
    Liste ein Tuple der Form

    `(<Anzahl der Bälle in Box 1>, <Anzahl der Bälle in Box 2>, usw.)`

    ist.
"""

# ╔═╡ e89ac102-bd34-4e81-9682-be5c127d28a4
md"""
## Rekursionsidee

Wir führen die Rekursion anhand der Anzahl der Bälle in der letzten Box durch.

1. Falls es nur eine Box gibt, müssen alle Bälle dort rein.
2. Falls es mehr als eine Box gibt, dann können in der letzten Box
   $0$ oder $1$ oder $2$ oder $\ldots$ $n$ Bälle drin sein.
   Für jede Variante, wie viele Bälle in der letzten Box sind,
   ermitteln wir durch den rekursiven Aufruf alle Verteilungen
   der restlichen Bälle auf die anderen Boxen und hängen
   an diese Verteilungen die Anzahl der Bälle in der letzten Box an.

Mit Hilfe von
[List-Comprehensions](https://docs.julialang.org/en/v1/manual/arrays/#man-comprehensions) versuchen wir das in einer einzigen Expression 
(was umgangssprachlich "Einzeiler" heißt).
"""

# ╔═╡ a54b1b3c-977b-4582-8b31-11c477926f21
aufteilung_un_num(n, k) =    k == 1 ? [(n,)] : 
		[(zuteilung..., anz_in_letzter_box) # anz_in_letzter_box anhängen
			for anz_in_letzter_box in 0:n   # Möglichkeiten für anz_in_letzter_box
			for zuteilung in aufteilung_un_num(n-anz_in_letzter_box, k-1) # Rekursion
		]

# ╔═╡ cf354731-0ab8-464a-8e6e-f79b9b5425ca
aufteilung_un_num(4, 1)

# ╔═╡ 31d222d6-366a-48ac-8c88-6774f59c22a9
aufteilung_un_num(1, 4)

# ╔═╡ bcc0cbf5-1b2c-4d04-8671-e5979b586182
aufteilung_un_num(4, 4)

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
# ╟─91b09f2a-7754-11ef-26e1-b5c38b4013e0
# ╟─e89ac102-bd34-4e81-9682-be5c127d28a4
# ╠═a54b1b3c-977b-4582-8b31-11c477926f21
# ╠═cf354731-0ab8-464a-8e6e-f79b9b5425ca
# ╠═31d222d6-366a-48ac-8c88-6774f59c22a9
# ╠═bcc0cbf5-1b2c-4d04-8671-e5979b586182
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
