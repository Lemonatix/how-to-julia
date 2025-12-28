### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ e98b65f2-7855-11ef-31d7-db99cccf4047
md"""
# Wurzelbäume (WB-Code)

!!! correct "Definition: geordneter Wurzelbaum"
    Ein geordneter Wurzelbaum $B$ (ab jetzt oft kurz WB) 
    ist eine Aufzählung/Liste
    von endlich vielen Kindern $B_1,\ldots,B_n$ (mit $n\in\mathbb{N}_0$),
    die wieder geordnete Wurzelbäume sind:

    $B=(B_1,\ldots,B_n).$

Zu Wurzelbäumen gab es die Defintion "WB-Code":

!!! correct "Definition: WB-Code"
    Sei $B=[B_1,\ldots,B_n]$ ein Wurzelbaum mit $n\in\mathbb{N}_0$ Kindern,
    dann definiert

    $C_B:=[\#\hbox{Knoten von }B , C_{B_1},\ldots,C_{B_n}]$

    den WB-Code für $B$.

Damit sind wir bei den zwei Aufgaben angekommen:

!!! correct "Aufgabe (Teil 1)"
    Schreibe eine Funktion, die zu einem Wurzelbaum den zugehörigen
    WB-Code berechnet.
    z.B.
    ```
      wb_code( ((), ((),), (((),(),),),) )  liefert [8,1,2,1,4,3,1,1]
    ```

!!! correct "Aufgabe (Teil 2)"
    Schreibe eine Funktion, die zu einem WB-Code den Wurzelbaum
    konstruiert.
"""

# ╔═╡ b641abab-d75f-4629-af51-4df1c694fb94
"""liefere String-Vektor mit dem Graphen zum Wurzelbam `baum`."""
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
end

# ╔═╡ 27609eba-164c-4395-9146-25b710388291
"""berechne WB-Code für Wurzelbaum `baum`."""
function wb_code(baum) :: Vector{Int}
	ergebnis = [1,] # hier kommt der Code rein; wir starten mal mit unserer Wurzel
	for kind in baum
		kind_code = wb_code(kind) # der Code vom Kind
		ergebnis[1] += kind_code[1] # addieren die Anzahl der Knoten des Kindex
		append!(ergebnis, kind_code) # hängen Kind-Code an
	end
	return ergebnis
end;

# ╔═╡ c6a8fc89-cc3c-4659-b2ba-5fd442c72662
begin # Wurzelbäume mit Hilfe von Tuples
	Bsp1 = tuple()  # WB ohne Kinder
	Bsp2 = (Bsp1,)  # WB mit einem Kind (nämlich Bsp1)
	Bsp3 = (Bsp2, Bsp1, Bsp2)  # noch ein WB
end

# ╔═╡ b464c311-6cba-4f37-8619-e4c109cb7768
foreach(println, graph_zu_baum(Bsp3))

# ╔═╡ 8fb5769a-71d2-40ba-a816-ab843b916e19
wb_code(Bsp3)

# ╔═╡ 77620afb-dc15-46f5-af59-1027cd0db7b3
wb_code( ((), (()), (((),()))) )

# ╔═╡ 5c9f4bab-4ab4-45e6-adaa-84c0b43ca7aa
wb_code( ((), ((),), (((),(),),),) )

# ╔═╡ e674e215-234e-4763-b6bb-742b1b8c6931
md"""
Mit Hilfe von `mapreduce` können wir auch einen Einzeiler programmieren:
"""

# ╔═╡ 313c443b-d73f-4781-bc47-16b62b482202
wb_code2(baum) :: Vector{Int} = mapreduce(wb_code2,
	function (data, child_code)
		data[1] += child_code[1]
		return append!(data, child_code)
	end, baum; init=[1,])

# ╔═╡ 448c899a-9507-4178-8b9e-2a33fe54d4e4
wb_code2( ((), (()), (((),()))) )

# ╔═╡ ba208e71-ff51-438a-a40d-a2f8e7d8306e
wb_code2( ((), ((),), (((),(),),),) )

# ╔═╡ e9b670cf-ae0a-4912-a55b-5516f8249c5c
"""
konstruiert Wurzelbaum aus WB-Code.

`index` ist die Position in `code` an der begonnen wird
der Code zu lesen (daher: Default `1`).

Rückgabe ist ein Tupel, wobei der erste Eintrag der
gesuchte Baum ist und der zweite Eintrag die nächste
Position in `code` ist, die nicht mehr ausgewertet wurde.

Beispiel:
```
wb_aus_code([6,1,1,3,1,1]) liefert (((), (), ((), ())), 7)
```
"""
function wb_aus_code(code::Vector{Int}, index=1)
	ergebnis = ()
	rest_knoten = code[index] - 1 # so viele Knoten sind noch zu behandeln
	index += 1
	while rest_knoten > 0  # da fehlt noch was, ab zum nächsten
		kind_knoten = code[index]
		rest_knoten -= kind_knoten
		kind_baum, index = wb_aus_code(code, index)
		ergebnis = (ergebnis..., kind_baum)
	end
	return ergebnis, index
end

# ╔═╡ c29060e9-bbb3-40b3-a992-9d579a5ddb09
string(wb_aus_code([6,1,1,3,1,1]))

# ╔═╡ 21a37af6-f805-4f1e-8085-2c69797cd150
graph_zu_baum(wb_aus_code([6,1,1,3,1,1])[1])

# ╔═╡ 19d4fd3a-4a56-4600-a121-88a8d7b9d26e
wb_aus_code(wb_code(Bsp3))[1] == Bsp3

# ╔═╡ 6a8cd6d8-cde7-4e47-9bcc-8a86f4035c95
foreach(println, 
		graph_zu_baum(wb_aus_code([8, 1, 2, 1, 4, 3, 1, 1])[1]))

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
# ╟─e98b65f2-7855-11ef-31d7-db99cccf4047
# ╟─b641abab-d75f-4629-af51-4df1c694fb94
# ╠═27609eba-164c-4395-9146-25b710388291
# ╠═c6a8fc89-cc3c-4659-b2ba-5fd442c72662
# ╠═b464c311-6cba-4f37-8619-e4c109cb7768
# ╠═8fb5769a-71d2-40ba-a816-ab843b916e19
# ╠═77620afb-dc15-46f5-af59-1027cd0db7b3
# ╠═5c9f4bab-4ab4-45e6-adaa-84c0b43ca7aa
# ╟─e674e215-234e-4763-b6bb-742b1b8c6931
# ╠═313c443b-d73f-4781-bc47-16b62b482202
# ╠═448c899a-9507-4178-8b9e-2a33fe54d4e4
# ╠═ba208e71-ff51-438a-a40d-a2f8e7d8306e
# ╠═e9b670cf-ae0a-4912-a55b-5516f8249c5c
# ╠═c29060e9-bbb3-40b3-a992-9d579a5ddb09
# ╠═21a37af6-f805-4f1e-8085-2c69797cd150
# ╠═19d4fd3a-4a56-4600-a121-88a8d7b9d26e
# ╠═6a8cd6d8-cde7-4e47-9bcc-8a86f4035c95
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
