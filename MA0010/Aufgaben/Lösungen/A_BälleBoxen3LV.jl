### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 50e6e342-e9bf-49f1-8eee-c6d5de2ed6c8
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 4de4d684-7755-11ef-10f6-89f91a77d583
md"""
# Bälle und Boxen (Teil 3)

Wir haben $n$ nummerierte Bälle (mit Nummern $1,2,\ldots,n$) und 
$k$ ununterscheidbare Boxen.

!!! correct "Aufgabe"
    Schreibe ein Programm welches alle Möglichkeiten ausgibt
    die $n$ Bälle auf die $k$ Boxen zu verteilen (leere Boxen sind erlaubt).

    Die Rückgabe soll eine Liste sein, wobei jedes Element der
    Liste eine Menge (Set) der Form

    ```
    Set( 
      Set(<Nummern der Bälle, die in einer Box zusammenliegen>),
      Set(<Nummern der Bälle, die in einer (anderen) Box zusammenliegen>), usw.
    )
    ```

    ist.
"""

# ╔═╡ f380f2da-a09b-48ed-bc27-95cb446d40fd
md"""
## Die Rekursionsidee

Den Sonderfall, dass es nur einen Ball oder nur eine Box gibt, behandeln
wir vorab. Dann müssen alle Bälle in einer Box liegen (entweder der eine Ball
in irgendeiner Box oder im andern Fall: alle Bälle in der einzigen Box).

Wir führen die Rekursion anhand des letzten Balles durch:

Wir lassen für die restlichen $n-1$ Bälle alle Zuteilungen/Partitionen bestimmen
und gehen dann durch: Entweder kann man den letzten Ball in eine der
Mengen legen, die bei den Zuteilungen schon da sind oder der letzte Ball
liegt komplett für sich alleine in einer eigenen Menge. Dieser letzte Fall klappt
aber nur, wenn die Partition der $n-1$ Bälle aus weniger als $k$ Mengen besteht.
"""

# ╔═╡ 80007eb1-2c77-4509-8c4d-57729b192b0d
function aufteilung_num_un(n, k)
	k == 1  ||  n == 1  && return [Set((Set(1:n),))] # geht nur: alle zusammen
	ergebnis = Vector{Set{Set{Int}}}() # da sammeln wir alle Partitionen auf
	# Es gibt einen letzten Ball n und restliche Bälle: n - 1 > 0
	for partition in aufteilung_num_un(n-1, k) # Bälle 1 bis n-1 aufteilen
		part_mengen = collect(partition) # beteiligte Mengen in Vektor
		for (index, menge) in enumerate(part_mengen) # jeder dieser Mengen
			neue_menge = push!(copy(menge), n)       # nur "neue" mit n drin
			push!(ergebnis, Set((part_mengen[1:index-1]..., neue_menge, 
			                     part_mengen[index+1:length(part_mengen)]...)))
		end
		length(partition) < k &&  # haben noch Platz, damit n alleine liegen kann
			push!(ergebnis, Set((part_mengen..., Set(n))))
	end
	return ergebnis
end

# ╔═╡ c94fb13e-76f8-4370-9594-47185f8011b0
aufteilung_num_un(3, 2)

# ╔═╡ c294a921-e804-4f6e-8182-bbf429a1dfda
aufteilung_num_un(3, 3)

# ╔═╡ 882826ae-6fa4-4e7b-8eb6-20572f03ba70
aufteilung_num_un(3, 4)

# ╔═╡ 94357e31-3fe9-4c3a-8c00-f13f1466c3a8
md"""
## Iterative Idee

Auch hier wollen wir einen iterativen Zugang sehen.

Wir nehmen wieder die Idee einer "Todo-Liste" mit (typischerweise)
vielen Einträgen. Jeder einzelne Eintrag in dieser Liste hat folgende
Form:

   * `([Liste mit schon gefundenen Mengen/Teilpartition], nächste Kugelnummer)`
"""

# ╔═╡ fc029cab-ca57-4994-b0f0-20e331bed4f9
function aufteilung2_num_un(n, k)
	todo_liste = [(Vector{Set{Int64}}(), 1)]
	ergebnis = Vector{Set{Set{Int}}}() # da sammeln wir alle Partitionen auf
	while !isempty(todo_liste)
		teilpartition, nächste = pop!(todo_liste)
		if nächste > n
			push!(ergebnis, Set(teilpartition))
			continue
		end
		for partnummer in 1:length(teilpartition)
			neue_part = copy(teilpartition)
			neue_part[partnummer] = Set([neue_part[partnummer]..., nächste])
			push!(todo_liste, (neue_part, nächste+1))
		end
		length(teilpartition) < k && # haben noch Platz für neue Menge
			push!(todo_liste, ([teilpartition..., Set([nächste])], nächste+1))
	end
	return ergebnis
end

# ╔═╡ fa9c201e-dd0d-44fa-bf09-f4f077899a4c
aufteilung_num_un(3,2)

# ╔═╡ 4951a340-76a4-4de3-b0c2-0ef21c6d09fe
aufteilung2_num_un(3,2)

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
# ╟─4de4d684-7755-11ef-10f6-89f91a77d583
# ╟─f380f2da-a09b-48ed-bc27-95cb446d40fd
# ╠═80007eb1-2c77-4509-8c4d-57729b192b0d
# ╠═c94fb13e-76f8-4370-9594-47185f8011b0
# ╠═c294a921-e804-4f6e-8182-bbf429a1dfda
# ╠═882826ae-6fa4-4e7b-8eb6-20572f03ba70
# ╟─94357e31-3fe9-4c3a-8c00-f13f1466c3a8
# ╠═fc029cab-ca57-4994-b0f0-20e331bed4f9
# ╠═fa9c201e-dd0d-44fa-bf09-f4f077899a4c
# ╠═4951a340-76a4-4de3-b0c2-0ef21c6d09fe
# ╟─50e6e342-e9bf-49f1-8eee-c6d5de2ed6c8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
