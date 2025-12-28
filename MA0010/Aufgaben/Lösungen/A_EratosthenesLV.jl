### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 77e70204-8c17-11f0-1e78-ffe1bf0d7406
md"""
# Das Sieb des Eratosthenes (ein Klassiker)

Das [Sieb des Eratosthenes](https://de.wikipedia.org/wiki/Sieb_des_Eratosthenes) ist eine (alte) Methode, um für ein gegebenes $n\in\mathbb{N}$ alle Primzahlen $\le n$ zu finden.

Es läuft so ab:
   1. Wir beginnen mit der Liste der Zahlen $2$ bis $n$.
   2. Wir speichern die erste Zahl in der (Ergebnis-)Liste und entfernen
      alle Vielfachen dieser Zahl aus der Liste.
   3. Falls die Liste noch nicht leer ist, springen wir zu Schritt 2.
   4. Ansonsten sind die gespeicherten Zahlen (aus Schritt 2) die
      gesuchten Primzahlen.

Hier die ersten Schritte für das Beispiel mit $n=50$.

Schirtt 1:

```
gespeichert: []
Liste: [2, 3, 4, 5, 6, 7, usw.]
```

Schritt 2:

```
gespeichert: [2]
Liste: [3, 5, 7, 9, 11, usw.]
```

Schritt 2:

```
gespeichert: [2, 3]
Liste: [5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43, 47, 49]
```

Schritt 2:

```
gespeichert: [2, 3, 5]
Liste: [7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 49]
```

Schritt 2:

```
gespeichert: [2, 3, 5, 7]
Liste: [11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
```

usw.

"""

# ╔═╡ 52e303e9-a5a8-495f-a65d-15b29bf0a9fa
md"""
!!! correct "Aufgabe"
    Programmiere eine Funktion `sieb(n)`, welches auf diese
    Art und Weise die Primzahlen $\le n$ ermittelt und als
    Liste zurückgibt.
"""

# ╔═╡ 1fb536e3-4fbf-47ff-887f-ffcd9a4e341f
function sieb1(n)
  gespeichert = Vector{Int}()
  liste  = collect(2:n)
  while length(liste) > 0
	  gefunden = liste[1]
	  push!(gespeichert, gefunden)
	  liste = filter(x -> x % gefunden != 0, liste[2:end])
  end
  return gespeichert
end


# ╔═╡ e1a0426a-a798-4176-857a-b27f471ffda9
sieb1(50)

# ╔═╡ 928d70e5-b0d4-4227-b564-96917178a73f
function sieb2_rec(liste)
	gefunden = liste[1]
	return length(liste) == 1 ? [gefunden] :
           [gefunden; sieb2_rec([x for x in liste[2:end] if x % gefunden != 0])]
end

# ╔═╡ 1f6e0b7a-c88d-454a-86fc-8e9154881230
sieb2_rec(2:50)

# ╔═╡ a9aa2c90-5d98-43bf-a74a-7cff3f691438
function sieb3(n)
	liste = fill(true, n) # alle Kandidaten
	liste[1] = false # ist keine Primzahl
	for k in 2:n
		liste[k] || continue   # falls k nicht prim, weiter
		liste[k .* (2:n÷k)] .= false # k ist prim, Vielfache auf nicht-prim setzen
	end
	return findall(liste)
end

# ╔═╡ 4a46e2c7-8d84-46d9-a1c6-981f8cb0dbd3
sieb3(50)

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
# ╟─77e70204-8c17-11f0-1e78-ffe1bf0d7406
# ╟─52e303e9-a5a8-495f-a65d-15b29bf0a9fa
# ╠═1fb536e3-4fbf-47ff-887f-ffcd9a4e341f
# ╠═e1a0426a-a798-4176-857a-b27f471ffda9
# ╠═928d70e5-b0d4-4227-b564-96917178a73f
# ╠═1f6e0b7a-c88d-454a-86fc-8e9154881230
# ╠═a9aa2c90-5d98-43bf-a74a-7cff3f691438
# ╠═4a46e2c7-8d84-46d9-a1c6-981f8cb0dbd3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
