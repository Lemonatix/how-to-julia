### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ ee260a29-cf0e-4f88-b038-65517547a8e2
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 795d8364-7756-11ef-35f6-a17acc26b2dd
md"""
# Bälle und Boxen (Teil 4)

Wir haben $n$ ununterscheidbare Bälle und $k$ ununterscheidbare Boxen.

!!! correct "Aufgabe"
    Schreibe ein Programm welches alle Möglichkeiten ausgibt
    die $n$ Bälle auf die $k$ Boxen zu verteilen (leere
    Boxen sind erlaubt).

    Die Rückgabe soll eine Liste sein, wobei jedes Element der
    Liste Dict Form

    ```
    Dict(
       1 => <Anzahl der Boxen die einen Ball beinhalten>,
       2 => <Anzahl der Boxen die zwei Bälle beinhalten>,
       usw.
	)
    ```

    ist.
"""

# ╔═╡ f888281e-d5e6-490a-b947-d6b468749c02
md"""
## Rekursionsidee

Rekursion über die maximale Anzahl von Bällen, die zusammenliegen dürfen.
"""

# ╔═╡ b83efe36-2691-4e91-9310-5493df0867c0
function aufteilung_un_un(n, k, max_in_box=n) :: Vector{Dict{Int,Int}}
	ergebnis = Vector{Dict{Int,Int}}()
	if k == 1  ||  n == 1 # alle liegen zusammen in einer Box
		if n ≤ max_in_box  push!(ergebnis, Dict(n => 1)) end
	else
		# Rekursion über die max. Anzahl der Bälle die zusammenliegen dürfen
		# wenn alle zusammenliegen ist es auch einfach		
		for max_zusammen in min(n, max_in_box):-1:1
			if max_zusammen * k < n  break end # geht nicht mehr; zu wenige Boxen
			if max_zusammen == n # dann alle zusammen
				push!(ergebnis, Dict(n => 1))
				continue
			end
			# legen max_zusammen in eine Box merken und Rest aufteilen
			aufteilungen = aufteilung_un_un(n-max_zusammen, k-1, max_zusammen)
			# die eine Box mit unseren max_zusammen in jeder Aufteilung dazu
			for aufteilung in aufteilungen
				aufteilung[max_zusammen] = 1 + get(aufteilung, max_zusammen, 0)
				push!(ergebnis, aufteilung)
			end
		end
	end
	return ergebnis
end

# ╔═╡ dedefe9d-f7aa-4ef7-95d0-73940738f2b6
aufteilung_un_un(1, 1)

# ╔═╡ 6c3c05d8-2d84-47ad-88ed-8d6da22d4221
aufteilung_un_un(2, 1)

# ╔═╡ 361443a9-ae24-4794-b5d5-866f48b8e2c0
aufteilung_un_un(2, 4)

# ╔═╡ bc8d78ac-917b-4888-bbaa-bb112aa6b7a9
aufteilung_un_un(4, 2)

# ╔═╡ c759d8e7-77d9-4243-b122-41a9adcf4279
aufteilung_un_un(4, 4)

# ╔═╡ 463437b6-b088-4d6b-96ae-e1ec9019bbfe
aufteilung_un_un(5,3)

# ╔═╡ 6630e4f5-7690-4951-89fb-22c9c797ffac
md"""
## Iterative Idee

Für diese iterative Idee machen wir eine Beobachtung: Wir sollen $n$ Bälle,
die wir nicht unterscheiden können, "zusammenlegen" in Boxen. Nehmen
wir den Fall $n=5$ Bälle und $k=3$ Boxen. Dann können wir doch die
Situationen so beschreiben:

$5 = 2+2+1 = 3+1+1 = 3+2 = 4+1 = 5$ 

Also für das erste Gleichheitszeichen: Es liegt ein Ball in einer Box alleine und $2$ Boxen haben $2$ Bälle.

Ah! Wir suchen alle Möglichkten $n$ in einer Summe mit bis zu $k$ Summanden
zu schreiben! Da haben wir mit der Aufgabe "Potenzsumme" schon Erfahrung.

Als einzigen Zusatz: Wenn wir eine Liste der Summanden z.B. `[2,1,2]` haben,
dann müssen wir diese noch in die gewünschte "Dict"-Schreibweise überführen.
"""

# ╔═╡ 5374bfcc-fe20-4087-ab0b-a4284e891bb8
function aufteilung2_un_un(n, k)
	result =  Vector{Dict{Int,Int}}()
	todo_liste = [(Vector{Int64}(), 0, n)]  # (bisher. Summanden, Wert, nächster)
	while !isempty(todo_liste)
		aj_liste, wert, nächster = pop!(todo_liste)
		if wert == n
			push!(result, Dict(value => count(==(value), aj_liste)
				   for value in unique(aj_liste))) # umschreiben in Dict-Schreibweise
			continue
		end
		length(aj_liste) == k && continue # max. Anz. an Summanden => nix geht mehr	
		wert + nächster <= n && # 1. Fall: nehmen nächster, falls möglich
			push!(todo_liste, ([aj_liste..., nächster], wert + nächster, nächster))
		# 2. Fall: nehmen nächster nicht, falls möglich
		nächster > 1 && push!(todo_liste, (aj_liste, wert, nächster-1))
	end	
	return result
end

# ╔═╡ cda0b0ab-52c3-490b-96aa-b5fea4e4a880
aufteilung_un_un(4, 3)

# ╔═╡ 7bf67296-ceb7-493b-a4ef-5a6b9305340e
aufteilung2_un_un(4, 3)

# ╔═╡ 36bb3e59-1eab-4e8a-8001-5303197a1a4b
aufteilung2_un_un(5, 3)

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
# ╟─795d8364-7756-11ef-35f6-a17acc26b2dd
# ╟─f888281e-d5e6-490a-b947-d6b468749c02
# ╠═b83efe36-2691-4e91-9310-5493df0867c0
# ╠═dedefe9d-f7aa-4ef7-95d0-73940738f2b6
# ╠═6c3c05d8-2d84-47ad-88ed-8d6da22d4221
# ╠═361443a9-ae24-4794-b5d5-866f48b8e2c0
# ╠═bc8d78ac-917b-4888-bbaa-bb112aa6b7a9
# ╠═c759d8e7-77d9-4243-b122-41a9adcf4279
# ╠═463437b6-b088-4d6b-96ae-e1ec9019bbfe
# ╟─6630e4f5-7690-4951-89fb-22c9c797ffac
# ╠═5374bfcc-fe20-4087-ab0b-a4284e891bb8
# ╠═cda0b0ab-52c3-490b-96aa-b5fea4e4a880
# ╠═7bf67296-ceb7-493b-a4ef-5a6b9305340e
# ╠═36bb3e59-1eab-4e8a-8001-5303197a1a4b
# ╟─ee260a29-cf0e-4f88-b038-65517547a8e2
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
