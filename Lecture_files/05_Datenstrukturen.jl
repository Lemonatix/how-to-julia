### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 155a383a-96db-11f0-21ce-63786b5f34b9
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 0d5d8dce-475a-4c5b-9dc9-fe223fc81f7b
md"""
# Datenstrukturen

Mit dem Wissen, was Objekte und Typen sind, stellt sich die Frage, welche
interessante Typen es gibt, um Daten zu speichern: also die Frage nach
interessanten Datentypen.

Als "Basistypen" haben wir schon die Darstellungen von Skalaren (z.B. `Int`)
gesehen. Aber man will ja irgendwann mal mehr als nur Zahlen speichern.

## Collections

Mehrere Objekten (["Ansammlungen"/Collections](https://docs.julialang.org/en/v1/base/collections/) davon) können auf verschiedene Weisen gespeichert werden.
Hier sind (wirklich nur) die häufig verwendete Collections:

### Arrays und Tuples

Folgende Listen und Tuples haben wir schon gesehen. Hier spielt die
Reihenfolge/Anordnung eine wichtige Rolle.
"""

# ╔═╡ 35f24b03-e8a2-4216-806d-65ee9709fbf3
[1, 3, 5]   # ein veränderbares Array/Liste von Objekten (hier `Int` Zahlen)

# ╔═╡ 3d9cfb10-2c07-4452-ae60-45ebf4c4fc19
(1, 3, 5)   # ein unveränderbares Tuple von Objekten

# ╔═╡ 2a9e24dc-ec80-4ac8-b97d-7cea0ca43e78
md"""

### Sets (Mengen)

Weiterhin gibt es auch noch
[Mengen/Sets](https://docs.julialang.org/en/v1/base/collections/#Base.Set) 
(bekannt auch aus der Mathematik):
Hier splielt die Anordnung keine Rolle; es ist "nur" wichtig, ob ein
Element/Objekt in der Menge ist oder nicht.

Mengen sind veränderbar und Elemente können hinzugefügt und entfernt werden.
"""

# ╔═╡ 7907be33-50ab-4bf7-99d6-73ab37e6f90a
let
	menge = Set([1, 5, 7])
	@show 8 ∈ menge
	@show 8 in menge
	@show 5 ∈ menge
	pop!(menge, 5)
	@show menge
	push!(menge, -5)
	@show menge
end;

# ╔═╡ e1ac8f48-8663-4677-b85d-5b02990a582c
md"""
Natürlich gibt es auch die bekannten Operationen auf Mengen, wie etwa
[vereinigen/union](https://docs.julialang.org/en/v1/base/collections/#Base.union)
oder 
[schneiden/intersect](https://docs.julialang.org/en/v1/base/collections/#Base.intersect).
"""

# ╔═╡ 8289a918-b409-434e-bfbf-8251c5ad4773
md"""
### Dictionaries

Für Zuordnungen (Schlüssel => Wert), also Key-Value-Pairs, gibt es Dicts
(sie heißen, in anderen Programmiersprachen, auch Hashmaps, Hashtables, 
Mappings, u.v.m.).
Auch hier spielt die Reihenfolge der Zuordnungen keine Rolle.

Dicts sind veränderbar. Man kann Zuordnungen ändern, hinzufügen und
entfernen.
"""

# ╔═╡ f323244b-02ac-4492-829f-84ab205acbdd
let
	zuordnung = Dict(1=>"eins", 2=>"zwei", 5=>"viele")
	@show Pair(2, "zwei") ∈ zuordnung
	@show Pair(2, "Zwei") ∈ zuordnung
	@show zuordnung[5]
	zuordnung[5] = "mehr"
	@show zuordnung[5]
	@show haskey(zuordnung, 2)
	@show haskey(zuordnung, -3)
	zuordnung[-3] = "minus 3"
	@show haskey(zuordnung, -3)	
	pop!(zuordnung, 5)
	@show zuordnung
end;

# ╔═╡ 8ee31af5-1e04-4278-8d88-3dead04b7a92
md"""
## Composite Types (Zusammengesetzte Typen)

Man kann aus vorhandenen Typen in Julia sehr einfach weitere
Typen ["zusammensetzen"](https://docs.julialang.org/en/v1/manual/types/#Composite-Types).
"""

# ╔═╡ 75822488-9704-4411-b007-e9111dcabd5f
begin
	struct Punkt                 # ein Punkt in ℤ² mit
		x    :: Int              # x Koordinate,
		y    :: Int              # y Koordinate und
		name :: String           # Name
	end

	P0 = Punkt(0, 0, "Ursprung")
	P1 = Punkt(1, -1, "P1")
	@show P1.y
end;

# ╔═╡ 2c9a6105-dbf6-479d-b55b-200f40aedfbd
md"""
Solche `struct` gibt es unmutable (das ist der default, wenn nichts dabei steht)
oder als `mutable struct ...`.
"""

# ╔═╡ 7e80f45f-fb24-4a39-a335-1c75f56b458e
md"""
# Design Patterns & The Art of Programming

Mit diesen Grundlagen zur Erschaffung neuer Datentypen ist bei der
Softwareprogrammierung eine große Herausforderung, die **passenden** und
**geeigneten** Datentypen für ein Problem zu finden, damit dann
der Code und die Algorithmen die gewünschte Eigenschaften haben.
Dies erfordert Übung und viel Erfahrung.

## Gang of Four

Es gibt "Guidelines" bzw. [Design Patterns](https://en.wikipedia.org/wiki/Software_design_pattern). Ein sehr altes (aber immer noch sehr empfehlenswertes)
Buch dazu ist das Buch der "Gang of Four". Hier kostenlos als Download:

   * Gang of Four: Design Patterns [https://www.cs.unc.edu/~stotts/GOF/hires/contfso.htm](https://www.cs.unc.edu/~stotts/GOF/hires/contfso.htm)

## The Art of Computer Programming

Und für tiefe Analysen (Welche Datenstruktur liefert wann welche
Ergebnisse? Welcher Algorithmus schneidet wann besser ab, als folgende
anderen Algorithmen?) gibt es **DAS** Standardwerk (begonnen 1962)

   * Donald E. Knuth: [The Art of Computer Programming](https://en.wikipedia.org/wiki/The_Art_of_Computer_Programming).
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.71"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "0c76a76c3ac8f04e01e91e0dc955aee1f9d81e4a"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "67e11ee83a43eb71ddc950302c53bf33f0690dfe"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.12.1"

    [deps.ColorTypes.extensions]
    StyledStringsExt = "StyledStrings"

    [deps.ColorTypes.weakdeps]
    StyledStrings = "f489334b-da3d-4c2e-b8f0-e476e12c162b"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "7d2f8f21da5db6a806faf7b9b292296da42b2810"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.3"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Downloads", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "8329a3a4f75e178c11c1ce2342778bcbbbfa7e3c"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.71"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "0f27480397253da18fe2c12a4ba4eb9eb208bf3d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.5.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "372b90fe551c019541fafc6ff034199dc19c8436"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.12"

[[deps.URIs]]
git-tree-sha1 = "bef26fb046d031353ef97a82e3fdb6afe7f21b1a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.6.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─0d5d8dce-475a-4c5b-9dc9-fe223fc81f7b
# ╠═35f24b03-e8a2-4216-806d-65ee9709fbf3
# ╠═3d9cfb10-2c07-4452-ae60-45ebf4c4fc19
# ╟─2a9e24dc-ec80-4ac8-b97d-7cea0ca43e78
# ╠═7907be33-50ab-4bf7-99d6-73ab37e6f90a
# ╟─e1ac8f48-8663-4677-b85d-5b02990a582c
# ╟─8289a918-b409-434e-bfbf-8251c5ad4773
# ╠═f323244b-02ac-4492-829f-84ab205acbdd
# ╟─8ee31af5-1e04-4278-8d88-3dead04b7a92
# ╠═75822488-9704-4411-b007-e9111dcabd5f
# ╟─2c9a6105-dbf6-479d-b55b-200f40aedfbd
# ╟─7e80f45f-fb24-4a39-a335-1c75f56b458e
# ╟─155a383a-96db-11f0-21ce-63786b5f34b9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
