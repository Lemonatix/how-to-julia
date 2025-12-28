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

# ╔═╡ 3acfa8f1-edc7-45cc-a13f-eed6aee7ccf8
function xmul(f, g, n)
	return sum( f(k)*g(n//k) for k in range(1,n) if n % k == 0)
end

# ╔═╡ c449b2e4-bd72-468a-8124-998187f3ed76
e₁(n) = n == 1 ? 1 : 0

# ╔═╡ 2e976f70-96c2-4842-b5c6-3f4b85e75eee
e₂(n) = n == 2 ? 1 : 0

# ╔═╡ f96af837-25b1-498a-b299-7964095f5a92
e₄(n) = n == 4 ? 1 : 0

# ╔═╡ 89a87f80-b86b-4ccb-b1b8-a3d78f1ccca1
N(n) = n

# ╔═╡ 64028af4-eff1-4332-a5ea-6d303388518d
[xmul(N, e₁, n) for n in range(1,20)]

# ╔═╡ 39ff80f7-424b-4e81-a19e-1a08476dc8bf
[xmul(N, e₂, n) for n in range(1,20)]

# ╔═╡ 465c4d60-9a20-4497-a61f-f91dbc9eb8f9
[xmul(N, e₄, n) for n in range(1,20)]

# ╔═╡ 3ba528de-8033-48cc-a46a-a500acef0e71
function xinverse(f, n)
	f1 = f(1)
	if f1 == 0; error("f ist nicht invertierbar.") end
	result = zeros(Rational, n)
	result[1] = 1//f1
	for k in range(2,n)
		result[k] = -sum( f(k//j)*result[j] for j in range(1, k-1) 
						                    if k % j ==0 ) // f1
	end
	return result[n]
end

# ╔═╡ 08c98ee6-3afd-49e0-95e1-90539df148c1
E(n) = 1

# ╔═╡ 60c3303c-12b8-4268-8836-b2c86dca3da4
[Int(xinverse(E, n)) for n in range(1,25)] # es sind alles Int, daher ...

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
# ╠═3acfa8f1-edc7-45cc-a13f-eed6aee7ccf8
# ╠═c449b2e4-bd72-468a-8124-998187f3ed76
# ╠═2e976f70-96c2-4842-b5c6-3f4b85e75eee
# ╠═f96af837-25b1-498a-b299-7964095f5a92
# ╠═89a87f80-b86b-4ccb-b1b8-a3d78f1ccca1
# ╠═64028af4-eff1-4332-a5ea-6d303388518d
# ╠═39ff80f7-424b-4e81-a19e-1a08476dc8bf
# ╠═465c4d60-9a20-4497-a61f-f91dbc9eb8f9
# ╠═3ba528de-8033-48cc-a46a-a500acef0e71
# ╠═08c98ee6-3afd-49e0-95e1-90539df148c1
# ╠═60c3303c-12b8-4268-8836-b2c86dca3da4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
