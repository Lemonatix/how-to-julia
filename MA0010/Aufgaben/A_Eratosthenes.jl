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
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
