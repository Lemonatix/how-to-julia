### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 81b6f240-8c5e-11f0-26c8-d3b65687cf9a
md"""
# Polynomdivision

Wir betrachten Polynome $p(x)=c_0 + c_1x^1 + c_2x^2 + \cdots + c_nx^n$ mit
rationalen Koeffizienten $c_k\in\mathbb{Q}$ in der monomialen Basis.

Wir speichern solche Polynome als Liste der Koeffizienten: $[c_0,c_1,\ldots,c_n]$.

!!! correct "Aufgabe"
    Schreibe eine Funktion `polydivision(p, q)`, die für 
    Polynome $p$ und $q$ die 
    [Polynomdivision](https://de.wikipedia.org/wiki/Polynomdivision)
    (mit Rest) durchführt und
    als Rückgabe das Ergebnispolynom und das Restpolynom hat.

Beispiel (aus Wikipedia):

Für $p(x)=-1 + x^2 - 2x^3 - x^4$ und $q(x) = 1 + x^2$ gilt

$$p(x) : q(x) = 2 -2x - x^2, \qquad \text{Rest:} -3 + 2x.$$

In Julia:

```julia
polydivision([-1, 0, 1, -2, -1], [1, 0, 1])
   ([2, -2, -1], [-3, 2])
```

!!! correct "Zusatz"
    Schreibe eine Funktion `show_polydivision(p, q)`, die
    die Polynome schön, darstellt, etwa:
    ```
    show_polydivision([-1, 0, 1, -2, -1], [1, 0, 1])

       (-x⁴ -2x³ +x² -1) : (x² +1) = -x² -2x +2   Rest: 2x -3
    ```
"""

# ╔═╡ b706d2f8-d976-485d-90d6-752116e83592
md"""
## Polynomdivison ausführlich

Wir sehen uns (am obigen Beispiel) die Schritte der Polynomdivision an, um zu
sehen, welche Operationen wir für Polynome programmieren.

1. Schritt:
   Zur Bestimmung des ersten Terms muss der Quotienten bestehend aus
   den führenden Termen (hier $-x^4$ und $x^2$) gebildet werden,
   also $-x^4/x^2=-x^2$.
   
   $(-1 + x^2 - 2x^3 - x^4) : (1 + x^2) = -x^2 + \ldots$

   Dieser Schritt besteht also aus der rationalen Division der führenden
   Koeffizienten und die Bestimmung des Exponenten.
2. Schritt:
   Nun muss das Produkt eines Monoms (hier $-x^2$) mit $q$ erfolgen.

   $(-x^2)\cdot(1+x^2) = -x^2 - x^4$
3. Schritt:
   Dieses Polynom muss von der linken Seite abgezogen werden:

   $(-1 + x^2 - 2x^3 - x^4) - (-x^2 - x^4) = -1 +2x^2-2x^3$

Danach beginnen die Schritte wieder von vorne, sofern der Polynomgrad noch
größer oder gleich dem Polynomgrad von $q$ ist.
"""

# ╔═╡ 73dfc930-c20a-432c-b704-3c875b80508d
md"""
Oft stören abschließende Nullen in der Koeffizientenlisten: 
So wird durch `[1,0,-1]` und `[1,0,-1,0,0]` das gleiche Polynom (nämlich $1-x^2$)
beschrieben. Will man nun den Grad des Polynoms (und andere Operationen),
so ist es oft hilfreich, wenn "überflüssige" Nullen (rechts) entfernt werden:
"""

# ╔═╡ 1b9c9060-a21f-4232-924d-f1d2c156f048
"""entferne restlichen Nullen (rechts) im Koeffizientenvektor."""
function compactpoly(p)
  index = findlast(p .!= 0)
  return p[1:(index === nothing ? 0 : index)] # leere Liste für Nullpolynom
end

# ╔═╡ f0374ead-0ad7-4e87-bda5-6b10d7874adc
"""Polynomdivison p : q mit Rest."""
function polydivision(p, q)
  p, q = compactpoly(copy(p)), compactpoly(copy(q)) # auf Kopie arbeiten
  isempty(q) && error("Division by 0")
  pivot = q[end]                      # führender Koeffizient von q speichern
  result = zeros(Rational, length(p)) # Ergebnisspeicher (max. Grad von p)
  while (index = findlast(p .!= 0)) !== nothing
    exp_diff = index - length(q)      # Exponent im 1. Schritt (siehe oben)
    exp_diff < 0 && break             # Grad q ist zu groß: p ist jetzt Rest
    result[exp_diff+1] = factor = p[index]//pivot # 1. Schritt: Division d. Koeff
	s2 = pushfirst!(factor*q, zeros(Rational, exp_diff)...) # 2. Schritt
	# 3. Schritt: s2 ggf. mit Nullen auffüllen (bis so lang wie p)
	length(s2) < length(p) && append!(s2, zeros(Rational, (length(p) - length(s2))))
    p -= s2                           # 3. Schritt: Subtraktion
  end
  return compactpoly(result), compactpoly(p)
end

# ╔═╡ c5349915-a131-45dd-9aae-d507706389ba
polydivision([-1, 0, 1, -2, -1], [1, 0, 1])

# ╔═╡ 3203fee2-247a-4016-a668-22254765088c
md"""
## Nun zur "Schönschrift"-Aktion

Wir besorgen uns die Exponenten `⁰¹²³⁴⁵⁶⁷⁸⁹` und schreiben eine Zuordnungstabelle
für die Ziffern:

    "0" => "⁰"
    "1" => "¹"
    etc.
"""

# ╔═╡ 752b64d4-279f-48bb-a894-a012f3ddc99a
getexp(n) = replace(  # Exponentenzuordnung:
	  string(n), (Pair(entry...) for entry in zip("0123456789",  "⁰¹²³⁴⁵⁶⁷⁸⁹"))...)

# ╔═╡ 2846ae70-381f-4974-a7ed-1337628d2a4f
getexp(12)

# ╔═╡ 0dc67b40-3b6a-4c86-a44c-d3a4d04b912c
md"""
Bei der Darstellung der Terme achten wir auf ein paar Sonderfälle:

* Terme, deren Koeffizienten $0$ sind, schreiben wir nicht, also $1$ statt $1+0x$;
  außer es ist das Nullpolynom, dann schreiben wir dafür $0$.
* Die $1$ lassen wir als Koeffizient weg, also $x^2$ statt $1x^2$; außer
  es ist der konstante Term.
* Die $-1$ schreiben wir nur mit Minus, also $-x^2$ statt $-1x^2$; außer
  es ist der konstante Term.
* Werte, die als Integer darstellbar sind schreiben wir ohne Bruchstrich,
  also `5` anstatt `5//1`.
* Als Variable schreiben wir $x$, außer beim konstanten Term (dort schreiben
  wir kein $x^0$).

Für die meisten Fallunterscheidungen bietet sich hier `a ? b : c` an. Und
da er rechts-assoziativ ist, kann man das sehr schön schreiben.
Zusammen mit List-Comprehensions sieht es z.B. so aus:
"""

# ╔═╡ 1c203fb9-611b-4e6c-83e8-80b2097bdf2f
show_polynom(poly, variable="x") = length(poly) == 0   ? "0" :
  join(reverse!([(value > 0   && index != length(poly) ? "+" : "")*
                 (value ==  1 && index != 1            ? ""  :
	              value == -1 && index != 1            ? "-" : 
                  string(isinteger(value) ? Integer(value) : value))*
                 (index == 1 ? "" : index == 2 ? variable : variable*getexp(index-1))
	             for (index, value) in enumerate(poly) if value != 0]), " ");

# ╔═╡ fa3f844c-3725-4568-8e84-421791778177
"""
Hier noch eine Funktion, die für zwei Polynome p und q die 
Polynomdivision ausführt und die Eingaben sowie die Ausgaben schön darstellt.
"""
function show_polydivision(p, q)
	ergebnis = polydivision(p, q)
	println("(", show_polynom(p), ") : (", show_polynom(q), ") = ",
		    show_polynom(ergebnis[1]),  "   Rest: ", show_polynom(ergebnis[2]))	
	return ergebnis
end

# ╔═╡ a4b1297d-731c-40f2-a25d-19acf452f16a
show_polydivision([-1, 0, 1, -2, -1], [1, 0, 1]);

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
# ╟─81b6f240-8c5e-11f0-26c8-d3b65687cf9a
# ╟─b706d2f8-d976-485d-90d6-752116e83592
# ╟─73dfc930-c20a-432c-b704-3c875b80508d
# ╠═1b9c9060-a21f-4232-924d-f1d2c156f048
# ╠═f0374ead-0ad7-4e87-bda5-6b10d7874adc
# ╠═c5349915-a131-45dd-9aae-d507706389ba
# ╟─3203fee2-247a-4016-a668-22254765088c
# ╠═752b64d4-279f-48bb-a894-a012f3ddc99a
# ╠═2846ae70-381f-4974-a7ed-1337628d2a4f
# ╟─0dc67b40-3b6a-4c86-a44c-d3a4d04b912c
# ╠═1c203fb9-611b-4e6c-83e8-80b2097bdf2f
# ╠═fa3f844c-3725-4568-8e84-421791778177
# ╠═a4b1297d-731c-40f2-a25d-19acf452f16a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
