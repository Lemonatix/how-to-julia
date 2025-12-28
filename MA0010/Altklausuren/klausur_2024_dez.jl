### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ bff30c2b-88d5-45fd-97c7-2a653eef72cb
using Printf

# ╔═╡ 6977992e-b9af-11ef-27ef-09632d4a8915
md"""
# Klausur am 20.12.2024
"""

# ╔═╡ ee5c62d4-c939-4ee5-9d4e-c465feb15c15
md"""
## Aufgabe 1

Ein geordneter Wurzelbaum $B$ ist ein Tupel von endlich vielen
Kindern $B_1,\ldots,B_n$ (mit $n\in\mathbb{N}_0$), die wieder geordnete Wurzelbäume sind:

$$B=(B_1,\ldots,B_n).$$

Ferner seien $N(B)$ (die Anzahl von Knoten in~$B$) und $T(B)$ (die Tiefe
des Baumes~$B$) durch

$$N(B) = 1 + \sum_{k=1}^n N(B_k)
  \quad\hbox{und}\quad
  T(B) = 1 + \max_{k\in\{1,\ldots,n\}} T(B_k)$$

definiert.
Schreibe eine Funktion (in julia) `berechne_NT(B)`,
die für einen Wurzelbaum $B$ die beiden Werte $N(B)$ und $T(B)$
ausrechnet und zurückliefert.

Beispiele:
```
berechne_NT( () )
(1,1)

berechne_NT( (((),()), ()) )
(5,3)
```
"""

# ╔═╡ b36cce74-307c-4f71-a2cd-4acfc0798032
"""
Zusatzfunktion (unabhängig von den Klausuraufgaben), um
Bäume darzustellen.
"""
function graph_zu_baum(baum, indent="", erster=true, letzter=true)
	ergebnis = Vector{String}() # da kommen die Zeilen rein
	if erster
		push!(ergebnis, "█")  # dann geht es mit der Wurzel los
	else
		push!(ergebnis, indent * (letzter ? "└" : "├") * "─▅") # Sub-Baum starten
		indent *= letzter ? "  " : "│ " # Indent, für letzten ist Space sonst Linie
	end
	for (index, kind) in enumerate(baum)  # jetzt zu den Kindern
		append!(ergebnis, graph_zu_baum(kind, indent, false, index == length(baum)))
	end
	return ergebnis
end;

# ╔═╡ 24220136-71ad-411a-b233-195adaeaac92
"""
Zusatzfunktion (unabhängig von den Klausuraufgaben), um
Bäume darzustellen.
"""
function zeige_baum(baum, indent="")
	for zeile in graph_zu_baum(baum, indent)
		println(zeile)
	end
end;

# ╔═╡ 37d72072-79be-4c14-89fe-ba9a87e553fd
function berechne_NT(B)
	N, Tmax = 1, 0            # Wurzel: 1 Knoten; Kinder-Tiefe: 0
	for kind in B             # gucken für jedes Kind
		N_kind, T_kind = berechne_NT(kind) # rekursiv für Kind
		N += N_kind           # Knoten (des Kindes) kommen zur Gesamtknotenzahl hinzu
		Tmax = max(Tmax, T_kind) # Tiefe übernehmen, falls größer
	end
	return N, 1 + Tmax        # Rückgabe: N und 1 + max. Tiefe der Kinder
end

# ╔═╡ 5d3fa27d-c7c7-48a2-9821-000c4c389a60
let
	baum = ()
	zeige_baum(baum)
	berechne_NT(baum)
end

# ╔═╡ cd428a33-e292-445d-9f30-49964c39d2ae
let
	baum =  (((),()), ())
	zeige_baum(baum)
	berechne_NT(baum)
end

# ╔═╡ 353523b7-57c7-473f-8c8d-8dd1d82cc791
md"""
## Aufgabe 2

   * (a) Sei `a = Int8(77)`. Gib alle `Int8`-Zahlen `b`
     an, die in julia `a + b < a` erfüllen.
   * (b) Sei `c = UInt8(77)`. Gib alle `UInt8`-Zahlen `d`
     an, die in julia `c + d < c` erfüllen.
"""

# ╔═╡ 8c16ebb9-3a54-48ce-9d16-029b65a93efd
md"""
(a) Die größte `Int8` Zahl lautet: 127. Sollte die reelle Addtion $a+b>127$ sein,
so wird in julia wegen des Integer-Überlaufs mit Wrap-Around-Verhalten
`a + b < 0` gelten. Damit gilt: `a + b ≥ a` ist genau dann der Fall, wenn
$b\in\{0,1,\ldots,127-a\}=\{0,1,\ldots,50\}$. Gefragt ist nach den Zahlen, die
das nicht erfüllen, also die `Int8`-Zahlen, die nicht in $\{0,1,\ldots,50\}$
liegen, das sind 

$$b\in\{-128,-127,\ldots,-1\}\cup\{51,52,\ldots,127\}.$$
"""

# ╔═╡ 89df20a4-b499-461c-8929-f69c4efec23b
let  # nur zum Test; wir lassen julia alle Int8-Zahlen durchprobieren
	a = Int8(77)
	for b in range(typemin(Int8), typemax(Int8))
		if a + b < a
			@printf("%i  ",b)
		end		
	end
	println()
end

# ╔═╡ 3d2e8a26-1fbc-45c2-bce2-14c8aa204cba
md"""
(b) Die größte `UInt8` Zahl lautet: 255. Sollte die reelle Addtion $c+d>255$ sein,
so wird in julia wegen des Integer-Überlaufs mit Wrap-Around-Verhalten
`c + d < c` gelten. Damit gilt: `c + d ≥ c` ist genau dann der Fall, wenn
$d\in\{0,1,\ldots,255-a\}=\{0,1,\ldots,178\}$. Gefragt ist nach den Zahlen, die
das nicht erfüllen, also die `UInt8`-Zahlen, die nicht in $\{0,1,\ldots,178\}$
liegen, das sind 

$$c\in\{179,180,\ldots,255\}.$$
"""

# ╔═╡ 449ff6f1-d18e-4d8a-8feb-cbc0290a7b30
let  # nur zum Test; wir lassen julia alle Int8-Zahlen durchprobieren
	c = UInt8(77)
	for d in range(typemin(UInt8), typemax(UInt8))
		if c + d < c
			@printf("%i  ",d)
		end		
	end
	println()
end

# ╔═╡ 75aaa971-a687-466f-ab3d-c335d0d77669
md"""
## Aufgabe 3

Betrache für ein gegebenes $f\colon\,\mathbb{Z}\to\mathbb{Z}$ und
einen Startwert $w$, die Folge

$$a_0 := w,\qquad a_n := f(a_{n-1}) \qquad (n\in\mathbb{Z}).$$

Die Folge heißt \emph{periodisch}, wenn es ein $N\in\mathbb{N}_0$ 
und ein $d\in\mathbb{N}$ gibt mit $a_{n+d}=a_n$ für alle $n\ge N$.
Die minimale Zahl $d$ mit dieser Eigenschaft wird Periodenlänge genannt.

Schreibe eine Funktion (in julia)

```
function finde_periode(f, w)
```

welche für die Eingaben $f$ und $w$ die Periodenlänge $d$ und $N$ der zugehörigen
(periodischen) Folge $(a_n)$ bestimmt.

Beispiel: Für

$$f(z) = \begin{cases}  
             z/2  & \hbox{falls $z$ gerade} \\
             3z+1 & \hbox{falls $z$ ungerade}
        \end{cases}$$

und $a_0:=w=-19$ ist

$$(a_0,\ a_1,\ a_2, \ldots) = 
  (-19, -56, -28, -14, -7, -20, -10, -5, -14, \ldots).$$

Daher $d=5$ und $N=3$. `finde_periode(f,-19)` liefert als Ergebnis `5,3)`.

"""

# ╔═╡ 48c49624-26ab-406c-999a-8d6b8024ba85
md"""
---

Eine Idee zur Lösung: Wir berechnen $a_0$, $a_1$, etc. und speichern dabei
an welchem Index in der Folge dieser Wert (das erste Mal) auftauchte.

Wenn wir ein weiteres $a_k$ berechnen und diesen Wert schon
gespeichert haben, haben wir die Periodenlänge und Position gefunden.
"""

# ╔═╡ 85780b33-e09f-47c3-91b6-ae1472dd1145
function finde_periode(func, wert)
	already_seen = Dict{Int, Int}()   # Speicher: Wert => erste Position
	index = 0                         # Index für Folgenglieder
	while ! haskey(already_seen, wert) # Wert ist neu
		already_seen[wert] = index    # speichere ersten Index für Wert
		wert = func(wert)             # nächstes Folgenglied berechnen
		index += 1                    # für diesen Index
	end
	first_seen = already_seen[wert]   # wo war dieser Wert schon mal
	return index - first_seen, first_seen
end

# ╔═╡ 15ddd4e3-8fe5-4967-b004-426a04c3a6dc
collatz(z) = iseven(z) ? z ÷ 2 : 3z+1

# ╔═╡ 233c4d4b-1646-44cd-b7b9-e89b33d0eabb
finde_periode(collatz, -19)

# ╔═╡ b2e697ee-4b21-447f-8163-e732ad8585e6
md"""
## Aufgabe 4

Bestimme, was julia als print-Output liefert, oder ob es zu einer Fehlermeldung kommt:
"""

# ╔═╡ 6ccb25a0-231f-46c8-bfe9-910046dcd48b
println(1/4); println(1//4); println(1÷4)

# ╔═╡ 57c70876-ece9-4412-b5c9-07385586f06d
println([1; 2;; 3 ; 4] == [1 3 ; 2 4])

# ╔═╡ 69505b29-09ff-46e7-8911-f3bb9f0e126d
println("*".^[1,2,3])

# ╔═╡ 31037ec8-a2e3-4da9-a70e-0d2ddefa0b70
function myfunc(a)
	if length(a) > 0
		println(a[1]);
		myfunc(a[2:end])
		println(a[1]);
	end
end;

# ╔═╡ 16011f8d-ec03-40c3-8222-953f2adc82ef
myfunc([1,2,3])

# ╔═╡ 20d65611-cc7c-46bb-9712-8bcd08143215
function wastutdas(x::Vector{Int}) :: Vector{Vector{Int}}
	result = [Vector{Int}()]
    for elem in x
		for index in 1:length(result)
			push!(result, [result[index]..., elem])
        end
    end
    return result
end;

# ╔═╡ 16a7a436-0d42-43c7-b081-d489ad3bf0b8
wastutdas([1,2,3])

# ╔═╡ 79f9c292-3e96-4b24-8d79-31d27eba90b4
function was_tut_das(v)
    if length(v) == 0   return 0   end
	return was_tut_das(v[2:end])+(v[1]%2 == 0 ? v[1] : 0)
end;

# ╔═╡ e694bde5-94ac-4ea2-be8b-91450a0e28a4
println(was_tut_das([1, 2, 3, 4, 5, 6]))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "f604830d70fa58877def5710c5d1fa32dcb3f998"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"
"""

# ╔═╡ Cell order:
# ╟─6977992e-b9af-11ef-27ef-09632d4a8915
# ╟─bff30c2b-88d5-45fd-97c7-2a653eef72cb
# ╟─ee5c62d4-c939-4ee5-9d4e-c465feb15c15
# ╟─b36cce74-307c-4f71-a2cd-4acfc0798032
# ╟─24220136-71ad-411a-b233-195adaeaac92
# ╠═37d72072-79be-4c14-89fe-ba9a87e553fd
# ╠═5d3fa27d-c7c7-48a2-9821-000c4c389a60
# ╠═cd428a33-e292-445d-9f30-49964c39d2ae
# ╟─353523b7-57c7-473f-8c8d-8dd1d82cc791
# ╟─8c16ebb9-3a54-48ce-9d16-029b65a93efd
# ╠═89df20a4-b499-461c-8929-f69c4efec23b
# ╟─3d2e8a26-1fbc-45c2-bce2-14c8aa204cba
# ╠═449ff6f1-d18e-4d8a-8feb-cbc0290a7b30
# ╟─75aaa971-a687-466f-ab3d-c335d0d77669
# ╟─48c49624-26ab-406c-999a-8d6b8024ba85
# ╠═85780b33-e09f-47c3-91b6-ae1472dd1145
# ╠═15ddd4e3-8fe5-4967-b004-426a04c3a6dc
# ╠═233c4d4b-1646-44cd-b7b9-e89b33d0eabb
# ╟─b2e697ee-4b21-447f-8163-e732ad8585e6
# ╠═6ccb25a0-231f-46c8-bfe9-910046dcd48b
# ╠═57c70876-ece9-4412-b5c9-07385586f06d
# ╠═69505b29-09ff-46e7-8911-f3bb9f0e126d
# ╠═31037ec8-a2e3-4da9-a70e-0d2ddefa0b70
# ╠═16011f8d-ec03-40c3-8222-953f2adc82ef
# ╠═20d65611-cc7c-46bb-9712-8bcd08143215
# ╠═16a7a436-0d42-43c7-b081-d489ad3bf0b8
# ╠═79f9c292-3e96-4b24-8d79-31d27eba90b4
# ╠═e694bde5-94ac-4ea2-be8b-91450a0e28a4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
