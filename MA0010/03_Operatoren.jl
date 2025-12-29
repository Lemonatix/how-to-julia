### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 6138a2dd-2355-4902-b050-8ad9220e5537
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 8890f16a-744b-11ef-1ba8-770cda23d8ed
md"""
# Operatoren

Operatoren sind "Aktionen" mit/auf Objekten. So liefert `a + b` ein neues
Objekt mit dem Ergebnis der Addition von `a` und `b`.

## häufige Operatoren

Hier eine Übersicht der häufigsten Operationen:

| Symbol | Aktion               |  Beispiel                                    |
| -----: | -------------------- | -------------------------------------------- |
| `+`    | Addtion              | `2+3=`$(2+3)                                 |
| `-`    | Subtraktion          | `2-3=`$(2-3)                                 |
| `*`    | Multiplikation       | `2*3=`$(2*3) oder `"ab"*"cd" = "abcd"`       |
| `/`    | Division             | `2/3=`$(2/3)                                 |
| `//`   | rat. Division        | `2//3=`$(2//3)                               |
| `÷`    | ganzzahlige Div.     | `2÷3=`$(2÷3)                                 |
| `%`    | Rest bei ganzz. Div. | `2%3=`$(2%3)                                 |
| `=`    | Binding: Var-Objekt  | `a=5`                                        |
| `^`    | Potenzbildung        | `2^3=`$(2^3)                                 |

## Operatoren als Funktionen

Die allermeisten Operatoren sind nur "getarnte" Funktionsaufrufe: So wird
ein `2+3` in julia übersetzt zum Aufruf der Funktion `+`, also `+(2,3)`.
Ja, es gibt eine Funktion mit dem netten Namen "`+`". Genau so verhält
es sich mit den allermeisten Operatoren.

Die allermeisten? Welche denn nicht? Das "`=`" ist z.B. kein Funktionsaufruf,
sondern echte Syntax (siehe Variablen und deren Binding). Und im Logik-Kapitel
werden wir weitere Operatoren kennenlernen, die "echte" Syntax sind und keine
"getarnten" Funktionsaufrufe.
"""

# ╔═╡ c030c1f6-a923-4c14-8300-258e9cf1fd0b
+(2,3)

# ╔═╡ 994a0c7f-79e0-454e-b767-aee040d8fa94
//(5,2)

# ╔═╡ e9c2be8a-86ba-472b-b976-40b734115e60
md"""
## Broadcasting

Viele Operatoren unterstützen "Broadcasting" (dazu später mehr). Als erste
Approximation kann man "Broadcasting" als "führe komponentenweise aus" lesen.
Für Broadcasting wird vor dem Operator ein Punkt `.` gesetzt; bei Funktionen
wird der Punkt nach dem Funktionsnamen gesetzt:
"""

# ╔═╡ ea9e38df-767b-44b3-891d-264a92f62688
[1,2,3,4,5] .< 4

# ╔═╡ 2fdd7516-498e-4a59-8fad-a497b78fcb93
[1,2,3,4,5] .≤ 4

# ╔═╡ 6f9a47c5-c6f7-4ca2-b8fe-0cb76ff01863
(1,2,3,4,5) .≤ 4

# ╔═╡ b46fb18f-fa29-4ec0-bc38-4635c81a0788
begin
	@show (1,2,3) .+ (1,2,3)   
    # @show (1,2,3) + (1,2,3)   #  "+" bei Tuples gibt es nicht! Ausprobieren!
end;

# ╔═╡ 4273d8f8-0e31-44f5-80ba-705cdb3618ce
let
	a = [1,2,3]
	a[2:3] .= 8
	@show a
end;

# ╔═╡ b19c41bd-6efe-4702-b7e8-a2a4591d1c81
sin.([1,2,π/2])

# ╔═╡ 745577fc-5568-4050-9e38-2e944c4905a3
[1,2,3].^2

# ╔═╡ 0e67a19b-e976-4509-a718-ced5422d78e3
M = [1 2; 3 4];

# ╔═╡ da1fe808-da62-45dd-a22e-8435e88dc143
M^2

# ╔═╡ 38923cdb-359c-4589-b54c-ba7bd476e4ce
M.^2

# ╔═╡ 764ab489-7ae9-44b1-85b6-b44a8dc01cd2
exp(M)

# ╔═╡ a56fe896-46d3-48f3-887d-ecbfd74251f8
exp.(M)  # skalare exp-Funkktion komponentenweise anwenden

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.3"
manifest_format = "2.0"
project_hash = "9c9a0986cd2aeb771b961ed0c3e9b6da6b71a391"

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
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.3.0+1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.7.0"

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

[[deps.JuliaSyntaxHighlighting]]
deps = ["StyledStrings"]
uuid = "ac6e5ff7-fb65-4e79-a425-ec3bc9c03011"
version = "1.12.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.15.0+0"

[[deps.LibGit2]]
deps = ["LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "OpenSSL_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.9.0+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "OpenSSL_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.3+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.12.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64", "JuliaSyntaxHighlighting", "StyledStrings"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2025.5.20"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.3.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.29+0"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.5.4+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.12.1"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

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

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

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
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

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
version = "1.3.1+2"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.15.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.64.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.7.0+0"
"""

# ╔═╡ Cell order:
# ╟─8890f16a-744b-11ef-1ba8-770cda23d8ed
# ╠═c030c1f6-a923-4c14-8300-258e9cf1fd0b
# ╠═994a0c7f-79e0-454e-b767-aee040d8fa94
# ╟─e9c2be8a-86ba-472b-b976-40b734115e60
# ╠═ea9e38df-767b-44b3-891d-264a92f62688
# ╠═2fdd7516-498e-4a59-8fad-a497b78fcb93
# ╠═6f9a47c5-c6f7-4ca2-b8fe-0cb76ff01863
# ╠═b46fb18f-fa29-4ec0-bc38-4635c81a0788
# ╠═4273d8f8-0e31-44f5-80ba-705cdb3618ce
# ╠═b19c41bd-6efe-4702-b7e8-a2a4591d1c81
# ╠═745577fc-5568-4050-9e38-2e944c4905a3
# ╠═0e67a19b-e976-4509-a718-ced5422d78e3
# ╠═da1fe808-da62-45dd-a22e-8435e88dc143
# ╠═38923cdb-359c-4589-b54c-ba7bd476e4ce
# ╠═764ab489-7ae9-44b1-85b6-b44a8dc01cd2
# ╠═a56fe896-46d3-48f3-887d-ecbfd74251f8
# ╟─6138a2dd-2355-4902-b050-8ad9220e5537
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
