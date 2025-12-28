### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 08c72f4f-9259-4264-88a9-114dfa29794f
begin
	using Random
	using Statistics
end

# ╔═╡ f7bce40e-8ebe-4022-a4b0-1fdd89d4f023
md"""
# Blackjack Strategien

Wir wollen verschiedene Strategien für
[Blackjack](https://de.wikipedia.org/wiki/Black_Jack)
programmieren und vergleichen.

Wir nehmen die Spielkarten aus dem Kapitel 06.
"""

# ╔═╡ b487b3ec-6fb1-49d6-900d-7ff92f704752
# Macht die (verbatim) Ausgabe etwas größer (für dieses Notebook)
# entweder anpassen oder ganze Zelle einfach löschen, falls es nicht passt.
html"""<style> pluto-output pre { font-size: 1.5em; } </style>"""

# ╔═╡ 2e61ec2a-75ff-11ef-0990-bda8f21f077c
"""Ein "Symbol", welches auf einer Spielkarte stehen kann."""
@enum Kartensymbol S_A=1 S_2 S_3 S_4 S_5 S_6 S_7 S_8 S_9 S_10 S_B S_D=13 S_K

# ╔═╡ 77b08d7f-725a-4e40-87d8-9e105d9f3e05
"""Eine Farbe, die eine Spielkarte haben kann."""
@enum Kartenfarbe F_Pik=0 F_Herz F_Karo F_Kreuz

# ╔═╡ ce67cf2a-f990-4f67-a906-fdeb21670b4f
alle_farben = (F_Pik, F_Herz, F_Karo, F_Kreuz);

# ╔═╡ 535de91f-7e02-4c49-a50e-cc510781d1b2
alle_symbole = (S_A, S_2, S_3, S_4, S_5, S_6, S_7, S_8, S_9, S_10, S_B, S_D, S_K);

# ╔═╡ 3157bb57-4947-4f29-a171-e86bc3aa70ec
"""Eine Spielkarte ist unveränderbar (eine Voraussetzung für ein faires Spiel) und hat ein Symbol und eine Farbe."""
struct Spielkarte
	symbol :: Kartensymbol
	farbe  :: Kartenfarbe
end

# ╔═╡ aa394281-9ea5-4d55-8a4c-b640654896c9
Spielkarte(S_D, F_Herz) # so kann man jetzt eine konkrete Spielkarte erzeugen

# ╔═╡ f142406e-210b-4e97-9ab4-ea835a0c9a01
begin
	import Base.*
	(*)(symbol::Kartensymbol, farbe::Kartenfarbe) = Spielkarte(symbol, farbe)
	(*)(farbe::Kartenfarbe, symbol::Kartensymbol) = Spielkarte(symbol, farbe)

	"""liefere Unicode-Zeichen für angegebene Spielkarte."""
	karte2char(karte::Spielkarte) = Char(
		0x1f0a0 + UInt(karte.farbe) * 0x10 + UInt(karte.symbol))
	
	import Base.show
	show(io::IO, karte::Spielkarte) = print(io, karte2char(karte))
end;

# ╔═╡ 93e2f3ef-2392-4f47-8599-84a08bb350f6
kartendeck = Tuple(symbol*farbe for farbe in alle_farben for symbol in alle_symbole)

# ╔═╡ fca9fc4a-9e63-48de-8286-e6880499422a
md"""
!!! correct "Aufgabe (Teil 1)"
    Schreibe `black_jack_wertigkeiten`.
"""

# ╔═╡ bfb359a4-0618-4a56-b4ba-6156a641a8e2
"""
Diese Funktion nimmt eine "Hand" (=Liste von Spielkarten) entgegen
und liefert eine Liste(!) der möglichen Wertigkeiten.

Warum Liste? Jedes Ass kann mit 1 oder 11 gewertet werden, daher
können sich (wenn ein oder mehrere Asse vorkommen) Mehrdeutigkeiten
ergeben.

Die Wertigkeiten sollen dabei sortiert sein.
"""
function black_jack_wertigkeiten(hand::Vector{Spielkarte}) :: Vector{Int}
	if length(hand) == 0  return [0]  end  # leere Hand
	wertigkeit = sum( # zählen zunächst die Wertigkeiten der Nicht-Asse
		karte.symbol == S_A             ?  0 :
		karte.symbol in (S_B, S_D, S_K) ? 10 : Int(karte.symbol)
		for karte in hand)
	anz_ass = sum(karte.symbol == S_A for karte in hand) # Anzahl der Ässer
	# 0:anz_ass können wir als 11 Werten (den Rest anz_ass:-1:0 als 1)
	return collect((0:anz_ass) .* 11 .+ (anz_ass:-1:0) .* 1) .+ wertigkeit
end

# ╔═╡ 7d4dcc03-fe66-4cf2-9efc-48a57c35c971
@assert black_jack_wertigkeiten(Vector{Spielkarte}()) == [0,]

# ╔═╡ d2f15d4d-c959-48c8-9efc-048a087bddea
@assert black_jack_wertigkeiten([S_K * F_Pik]) == [10,]

# ╔═╡ bd7df8b5-ccfc-4bc1-9e7f-c828e15f9757
@assert black_jack_wertigkeiten([S_K * F_Pik, S_A * F_Herz, S_A * F_Pik]) == [12,22,32]

# ╔═╡ 62a8b7ee-4170-48c1-8ac1-e02ec46bf1ce
md"""
Jetzt brauchen wir noch Spieler. Ein Spieler wird hier reduziert auf seine
Aktionen.
"""

# ╔═╡ 91794651-c10c-44f2-a2ed-7abc5fbb590b
@enum Spieleraktion A_noch_eine_karte A_fertig

# ╔═╡ 16bc7f56-e0d7-466d-ba0b-dc5c0700db9b
md"""
Und ein Spieler ist damit eine Funktion, die eine (aktuelle) Hand
entgegennimmt und eine Aktion (was zu tun ist) ausspuckt:
"""

# ╔═╡ 432d6cf3-dec2-496e-849a-640576c33f92
"""
Ein Spieler, der unabhängig von der aktuellen hand einfach zufällig
noch eine Karte will oder fertig sagt.
"""
function zufalls_spieler(hand::Vector{Spielkarte}) :: Spieleraktion
	return rand([A_noch_eine_karte, A_fertig])
end

# ╔═╡ f3acd324-5089-4c93-ba4c-f1ec8a80624d
"""
Wir lassen einen Spieler n-mal spielen (pro Spiel werden 6 Kartensets mit 
je 52 Karten gemischt) und geben die jeweilige Punktzahl aus
(entsprechend den Regeln von Blackjack).
"""
function simuliere_spiele(spieler, n)
	ergebnisse = zeros(Int, n)  # da kommen die Punkte für jedes spiel rein
	for index in 1:n  # Schleife über n Spiele
		stapel = shuffle!(repeat([kartendeck...], 6)) # 312 Karten; 6 Kartendekcs
		hand = [pop!(stapel),] # mit 1 (und gleich noch einer) Karte geht es los
		while true
			push!(hand, pop!(stapel))  # nächste Karte
			wertigkeiten = black_jack_wertigkeiten(hand)
			# mehr als 21 oder 21 geneu erreicht; Dealer hört ohne Nachfrage auf;
			# in den anderen Fällen muss der Spieler entscheiden			
			aktion = (wertigkeiten[1] > 21 || 21 ∈ wertigkeiten) ?
						A_fertig : spieler(hand)
			if aktion == A_fertig  # dann Ergebnis notieren und Spiel fertig
				ergebnis = (wertigkeiten[1] > 21) ? 
						wertigkeiten[1] : maximum(wertigkeiten[wertigkeiten .≤ 21])
				ergebnisse[index] = ergebnis
				break # while loop beenden
			end
			# sonst weiter
		end
	end
	return ergebnisse
end

# ╔═╡ cd3c4ad8-52a0-4f0f-86f9-0c76fbd77e2e
ergebnisse = simuliere_spiele(zufalls_spieler, 15)

# ╔═╡ 78eb5b03-80ba-464e-82fb-2aeaadc12d1d
"""liefere Statistik für Spiele."""
function statistik(ergebnisse)
	anz = length(ergebnisse)
	verloren, gewonnen = sum(ergebnisse .> 21), sum(ergebnisse .≤ 21)
	ergebnisse_ok = ergebnisse[ergebnisse .≤ 21]
	relativ(k) = round(100 * k / anz)
	return Dict(
		"anzahl_spiele" => anz,
		"verloren_prozent" => relativ(verloren),
		"gewonnen_prozent" => relativ(gewonnen),
		"Durschnitt_gewonnen" => mean(ergebnisse_ok),
		"Median_gewonnen" => median(ergebnisse_ok)
	)
end

# ╔═╡ 4737b7c0-b3d4-4f8a-adcf-cf0b8618d74e
statistik(ergebnisse)

# ╔═╡ 27e95b58-4fa6-4d75-b546-aaaa9df27dff
statistik(simuliere_spiele(zufalls_spieler, 10_000))

# ╔═╡ 6ec7c473-f701-4c0e-8b40-a74fcc182257
md"""
!!! correct "Aufgabe (Teil 2)"
    Schreibe bessere "Spieler"-Funktionen.
"""

# ╔═╡ 6af6ac16-d9d2-4ed2-9040-d6696aa640eb
md"""
Dieser Fun-Teil ist wirklich den Teilnehmern überlassen.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
Statistics = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "f83ad666d8a38d10d2cff41cc9796112285f9ca2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"
"""

# ╔═╡ Cell order:
# ╟─f7bce40e-8ebe-4022-a4b0-1fdd89d4f023
# ╠═b487b3ec-6fb1-49d6-900d-7ff92f704752
# ╠═08c72f4f-9259-4264-88a9-114dfa29794f
# ╠═2e61ec2a-75ff-11ef-0990-bda8f21f077c
# ╠═77b08d7f-725a-4e40-87d8-9e105d9f3e05
# ╠═ce67cf2a-f990-4f67-a906-fdeb21670b4f
# ╠═535de91f-7e02-4c49-a50e-cc510781d1b2
# ╠═3157bb57-4947-4f29-a171-e86bc3aa70ec
# ╠═aa394281-9ea5-4d55-8a4c-b640654896c9
# ╠═f142406e-210b-4e97-9ab4-ea835a0c9a01
# ╠═93e2f3ef-2392-4f47-8599-84a08bb350f6
# ╟─fca9fc4a-9e63-48de-8286-e6880499422a
# ╠═bfb359a4-0618-4a56-b4ba-6156a641a8e2
# ╠═7d4dcc03-fe66-4cf2-9efc-48a57c35c971
# ╠═d2f15d4d-c959-48c8-9efc-048a087bddea
# ╠═bd7df8b5-ccfc-4bc1-9e7f-c828e15f9757
# ╟─62a8b7ee-4170-48c1-8ac1-e02ec46bf1ce
# ╠═91794651-c10c-44f2-a2ed-7abc5fbb590b
# ╟─16bc7f56-e0d7-466d-ba0b-dc5c0700db9b
# ╠═432d6cf3-dec2-496e-849a-640576c33f92
# ╠═f3acd324-5089-4c93-ba4c-f1ec8a80624d
# ╠═cd3c4ad8-52a0-4f0f-86f9-0c76fbd77e2e
# ╠═78eb5b03-80ba-464e-82fb-2aeaadc12d1d
# ╠═4737b7c0-b3d4-4f8a-adcf-cf0b8618d74e
# ╠═27e95b58-4fa6-4d75-b546-aaaa9df27dff
# ╟─6ec7c473-f701-4c0e-8b40-a74fcc182257
# ╟─6af6ac16-d9d2-4ed2-9040-d6696aa640eb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
