### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ c543f9b0-1219-49f9-9127-958c75cb6b1d
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 8f7bb2c2-7753-11ef-08d5-85313be6de3c
md"""
# Bälle und Boxen (Teil 1)

Es sind $n$ nummerierte Bälle (mit Nummern $1,2,\ldots,n$) und
$k$ nummerierte Boxen (mit Nummern $1,2,\ldots,k$) gegeben.

!!! correct "Aufgabe"
    Schreibe ein Programm welches alle Möglichkeiten ausgibt
    die $n$ Bälle auf die $k$ Boxen zu verteilen (leere Boxen
    sind erlaubt).

    Die Rückgabe soll eine Liste sein, wobei jeder Eintrag
    in der Liste ein Tuple der Form 

    `(<Box-Nummer für Ball 1>, <Box-Nummer für Ball 2>, usw.)`

    ist.
"""

# ╔═╡ 7951a5b8-8d07-4f79-b11d-274d8f7904e0
md"""
## Rekursionsidee

Wir kümmern uns nur um den letzten Ball (falls es den überhaupt gibt;
bei $n=0$ ist alles einfach). Für den letzten Ball haben wir $k$ Möglichkeiten
(nämlich Box $1$, $2$ bis $k$).
Jetzt brauchen wir eine Fallunterscheidung:

1. falls der letzte Ball  auch der einzige Ball ist:
   Dann müssen wir nur diesen verteilen und
   können genau die $k$ Möglichkeiten zurückliefern.
2. falls es noch weitere Bälle als den lezten Ball gibt:
   Dann erhalten wir durch den rekursiven Aufruf für
   die restlichen Bälle alle möglichen Zuteilungen.
   Danach können wir für jede Zuteilung der restlichen
   Bälle, unseren letzten Ball hinzufügen.
"""

# ╔═╡ d72c8a8c-e16f-43de-95c3-8b17f7794aaf
function aufteilung_num_num(n, k)
	result = Vector{NTuple{n, Int}}()
	if n == 0  return result  end
	for letzter_ball_in_box in 1:k   # Schleife: alle Möglichkeiten für letzten Ball
    	if n == 1    # letzter Ball ist einziger Ball
      		push!(result, (letzter_ball_in_box,))
    	else         # es gibt noch andere Bälle als den letzten
      		for sub_zuteilung in aufteilung_num_num(n-1, k)
				# für jede sub_zuteilung der n-1 Bälle: letzter Ball hinzufügen
        		push!(result, (sub_zuteilung..., letzter_ball_in_box))
      		end
    	end
  	end
  return result
end


# ╔═╡ 02b9e2c4-f001-4264-9e3d-43bbe70e2c73
aufteilung_num_num(1,4)

# ╔═╡ 35622f2e-7fc6-4853-9cb0-8a1011ce04f6
aufteilung_num_num(4,1)

# ╔═╡ 96e9bb39-6d41-4a51-9b0e-0adb929af528
aufteilung_num_num(4,4)

# ╔═╡ ea8927de-91c6-4a84-937a-a466e69c2f01
md"""
Natürlich war die Wahl des "letzten" Balles rein willkürlich.

Hier die gleiche Idee mit dem ersten Ball:
"""

# ╔═╡ 99eb27a3-5274-4a85-84ec-a22afbf82d0f
function aufteilung2_num_num(n, k)
	result = Vector{NTuple{n, Int}}()
	if n == 0  return result  end
	for erster_ball_in_box in 1:k   # Schleife: alle Möglichkeiten für erste Ball
    	if n == 1    # erster Ball ist einziger Ball
      		push!(result, (erster_ball_in_box,))
    	else         # es gibt noch andere Bälle, nicht nur den ersten
      		for sub_zuteilung in aufteilung2_num_num(n-1, k)
				# für jede sub_zuteilung der n-1 Bälle: ersten Ball hinzufügen
        		push!(result, (erster_ball_in_box, sub_zuteilung...))
      		end
    	end
  	end
  return result
end


# ╔═╡ 758a3a13-964b-4b47-b1b1-d996ee10032b
aufteilung2_num_num(4,4)

# ╔═╡ 36adceff-c921-4c40-988b-f58380dadbbc
md"""
## Iterative Idee

Insbesondere wenn wir obige Ausgabe für $n=k=4$ sehen 
und mal kurz die Boxen (anstatt von $1$ bis $k=4$) von $0$ bis $3=k-1$ nummerieren:

```
 (0, 0, 0, 0)
 (0, 0, 0, 1)
 (0, 0, 0, 2)
 (0, 0, 0, 3)
 (0, 0, 1, 0)
 (0, 0, 1, 1)
 (0, 0, 1, 2)
 (0, 0, 1, 3)
 (0, 0, 2, 0)
 ⋮
 (3, 3, 3, 0)
 (3, 3, 3, 1)
 (3, 3, 3, 2)
 (3, 3, 3, 3)
```

Dann fällt auf, das das nur Zählen im von 0 bis 255 zur Basis 4 ist.
"""

# ╔═╡ 9ee46732-f04d-41a3-8c7d-14b09bc7a384
function aufteilung3_num_num(n, k)
	n==0  ||  k == 0 && return []
	k==1 && return ones(Int, n)
	result = Vector{NTuple{n, Int}}()
	for counter in 0:(k^n - 1)
		ziffern = digits(counter, base=k, pad=n) .+ 1
		push!(result, (ziffern...,))
	end
	return result
end

# ╔═╡ d016d458-3fb2-4c7b-84f5-cdad41c05de8
aufteilung3_num_num(4,2)

# ╔═╡ e7ed9037-80fb-4553-b1c0-6a458215eeb3
md"""
Mit Comprehensions können wir das noch etwas kürzer schreiben.
"""

# ╔═╡ ffae72ab-cb86-4419-ad78-1557e27aaedf
function aufteilung4_num_num(n, k)
	n==0  ||  k == 0 && return []
	k==1 && return ones(Int, n)
	return [((digits(counter, base=k, pad=n) .+ 1)...,)
		    for counter in 0:(k^n - 1)]
end

# ╔═╡ 02f7e468-69c8-4584-b5ba-1f5eb6834a98
aufteilung4_num_num(4,2)

# ╔═╡ a8f0bcc9-d4e9-4fce-bdef-0fd8bcd7569d
md"""
## Der Einzeiler

Und das bekommen wir jetzt auch in eine einzige Expression (also einen "Einzeiler").
"""

# ╔═╡ 65433a0b-5b73-4458-b9a0-33e6bfa8eee8
aufteilung5_num_num(n, k) = 
	(n==0 || k==0) ? [] : (k==1) ? ones(Int, n) : 
	[((digits(counter, base=k, pad=n) .+ 1)...,) for counter in 0:(k^n - 1)]

# ╔═╡ d9aba350-d239-4e6a-a53b-84f9c5ade732
aufteilung5_num_num(2,3)

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
# ╟─8f7bb2c2-7753-11ef-08d5-85313be6de3c
# ╟─7951a5b8-8d07-4f79-b11d-274d8f7904e0
# ╠═d72c8a8c-e16f-43de-95c3-8b17f7794aaf
# ╠═02b9e2c4-f001-4264-9e3d-43bbe70e2c73
# ╠═35622f2e-7fc6-4853-9cb0-8a1011ce04f6
# ╠═96e9bb39-6d41-4a51-9b0e-0adb929af528
# ╟─ea8927de-91c6-4a84-937a-a466e69c2f01
# ╠═99eb27a3-5274-4a85-84ec-a22afbf82d0f
# ╠═758a3a13-964b-4b47-b1b1-d996ee10032b
# ╟─36adceff-c921-4c40-988b-f58380dadbbc
# ╠═9ee46732-f04d-41a3-8c7d-14b09bc7a384
# ╠═d016d458-3fb2-4c7b-84f5-cdad41c05de8
# ╟─e7ed9037-80fb-4553-b1c0-6a458215eeb3
# ╠═ffae72ab-cb86-4419-ad78-1557e27aaedf
# ╠═02f7e468-69c8-4584-b5ba-1f5eb6834a98
# ╟─a8f0bcc9-d4e9-4fce-bdef-0fd8bcd7569d
# ╠═65433a0b-5b73-4458-b9a0-33e6bfa8eee8
# ╠═d9aba350-d239-4e6a-a53b-84f9c5ade732
# ╟─c543f9b0-1219-49f9-9127-958c75cb6b1d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
