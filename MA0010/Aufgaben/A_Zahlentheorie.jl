### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ c4b003a4-8b81-11f0-2f66-c1b26d52fef5
md"""
# Etwas Algebra: Zahlentheorie

Für zwei Funktionen $f,g\colon\,\mathbb{N}\to\mathbb{Q}$ definieren wir
das Produkt (die [Dirchlet-Faltung](https://de.wikipedia.org/wiki/Zahlentheoretische_Funktion#Faltung)) $f\odot g$ durch 

$$(f\odot g)(n) := \sum_{k|n} f(k)\cdot g(n/k)$$

Dabei bedeutet $k|n$, dass $1\le k\le n$ ein Teiler von $n$ ist (gesprochen
"$k$ teilt $n$").

!!! correct "Aufgabe 1: Multiplikation"
    Schreibe eine Funktion
    ```
    function xmul(f, g, n)
    ```
    die $(f\odot g)(n)$ für Funktionen $f$ und $g$ berechnet.

Sei $e_k(k)=1$ und  $e_k(n)=0$ für $n\ne k$. Die Funktion $e_1$ ist das
neutrale Element. Es gilt für alle $f$:

$$f\odot e_1 = e_1\odot f = f.$$

Teste Deine Implementierung für verschiedene Kombinationen von $f$ und $e_k$.
Überlege zunächst wie das Ergebnis von $f\odot e_k$ aussieht.

!!! correct "Aufgabe 2: Inverse"
    Schreibe eine Funktion
    ```
    function xinverse(f, n)
    ```
    die für eine Funktion $f$ ihr Inverses an der Stelle $n$,
    also $f^{-1}(n)$ berechnet oder mit dem Aufruf
    `error("f ist nicht invertierbar")` abbricht, falls $f$ 
    nicht invertierbar ist.

    Die Inverse $f^{-1}$ ist, wie üblich,
    über $f\odot f^{-1}= f^{-1}\odot f = e_1$ definiert.

Teste Deine Funktion mit der konstanten Einsfunktione $E(n) := 1$. 
Diese Funktion $\mu := E^{-1}$ erfüllt

$$\mu \odot E = E \odot \mu = e_1$$

und heißt [Möbiusfunktion](https://de.wikipedia.org/wiki/M%C3%B6biusfunktion).
Im verlinkten Wikipedia-Artikel stehen auch die ersten 20 Funktionswerte.
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
# ╟─c4b003a4-8b81-11f0-2f66-c1b26d52fef5
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
