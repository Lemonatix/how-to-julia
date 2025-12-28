### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ a545d484-7104-11ef-315d-01f9f2978ea4
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 80bd24de-3dcb-4d81-94f7-b4051bef0954
md"""
# Logik, Bedingungen, Schleifen

Normalerweise wird Code einfach linear "der Reihe nach" 
Zeile für Zeile durchgeführt. Das ist der Standardfluss, den man aber
oft genug umlenken oder kontrollieren möchte
(daher [control flow](https://docs.julialang.org/en/v1/manual/control-flow/)).
Eine der häufigsten Modifikationen des Codeflusses sind **bedingte Ausführung** und die **Wiederholung** von einem Code-Abschnitt. Vorbereitend dazu müssen wir uns dafür zunächst mit "Logik" befassen.

## Logik

Wir kennen schon den Datentyp `Bool` (mit den Objekten `false` und `true`).
Er ist die Grundlage für logische Ausdrücke und damit für bedingte
Ausführung von Code.

`Bool`-Werte werden unter anderem von *Operationen* zurückgegeben:

| Operator           | Aktion                                                      |
| -----------------: | :---------------------------------------------------------- |
| `==`               | prüft auf Gleichheit                                        |
| `!=`               | prüft auf Ungleichheit                                      |
| `===`              | prüft auf Identität                                         |
| `!==`              | prüft auf Nicht-Identität                                   |
| `<`, `>`, `≤`, `≥` | prüft auf kleiner/größer/kleiner-gleich/größer gleich       |
| `!`                | negiert (rechte Seite)                                      |
| `&&`               | logisches "und"                                             |
| `\|\|`             | logisches "oder"                                            |
| `⊻`                | logisches "exclusives oder"                                 |

Daneben gibt es noch viele Funktionen, die bei logischen Aussagen helfen:

| Funktion           | Aktion                                                      |
| -----------------: | :---------------------------------------------------------- |
| `all()`            | prüft, ob alle Argumente `true` sind                        |
| `any()`            | prüft, ob mindestens ein Argument `true` ist                |
| `is...()`          | viele weitere Tests, z.B. `iseven`, `isodd`, etc.           |

Hier die "üblichen" Logik-Tabellen.
"""

# ╔═╡ e0cfb41f-f0c5-4f49-bdc6-3756db6e2ab5
md"""
!!! danger "Ein kleiner Hinweis"
    Anders als `+`, `-` oder `⊻` sind `&&` und `||` **keine**
    Objekte, sondern **Syntax**.
    Dies hat folgenden Grund: `&&` und `||` sind "short-circuit", d.h. bei
    ```
      a || b
    ```
    soll `b` wirklich nur ausgeführt werden, wenn `a` nicht `true` ist. Gäbe
    es eine Funktion `||(a,b)`, dann würden **beide** Argument ausgewertet werden,
    bevor `||` aufgrufen würde.
"""

# ╔═╡ fdddf715-a020-415c-92c9-99dd4f2a7c4a
md"""
## Bedingungen (if)

Sie haben die Form:

    if <Test1>

      <true1-block>

    elseif <Test2>

      <true2-block>  

    elseif <Test3>

      <true3-block>  
    ...
    else 

      <else block>

    end

Dabei sind die `elseif` optional sowie der `else` Teil optional.
Es wird nur der erste `<true-block>` ausgeführt dessen Logik-Bedingung `true`
ist. Falls keine Bedingung `true` ist und ein `else`-Block da ist, wird
dieser Ausgeführt. Die Rückgabe ist das Ergebnis des zuletzt ausgeführten
Blocks oder `nothing`, falls es keinen solchen Block gibt.
"""

# ╔═╡ c3b800af-890b-4a39-bbb8-2c924dde99dd
if true end    # liefert nothing

# ╔═╡ 6848444f-38cb-4f53-adf4-72b3f075c5e7
if false end   # liefert nothing

# ╔═╡ 8b4d3cc4-c1f6-41b6-be4c-768b266f800d
""" Einfaches Beispiel zu `if` um Relation zweier Objekte zu bestimmen."""
function liefere_relation(a, b)
	if a < b
		ergebnis = "ist kleiner als"
	elseif a == b
		ergebnis = "ist gleich"
	elseif a > b
		ergebnis = "ist größer als"
	else
		ergebnis = "steht in keiner Relation zu"
	end
	return string(a)* " " * ergebnis * " " * string(b)
end

# ╔═╡ 0351cf1a-f7fa-48dd-8937-963d4645f1a6
liefere_relation(3, 5)

# ╔═╡ 921d4fd6-d226-4124-929f-d32bdbd5f88e
liefere_relation(Set("abc"), Set("ac"))

# ╔═╡ dc9de226-74dc-4ac0-bf20-9c563bb7d103
liefere_relation(Set("abc"), Set("acd"))

# ╔═╡ 5fd2a75f-8f1c-4716-a338-6da0663bfd1d
md"""
## Der `? : ` Operator

Eng verwandt mit `if` ist der `? : ` Operator. Ihn kann man gut verwenden,
wenn der `true`- und `false`-Block eines `if` nur aus einem Wert besteht:

    <Bedingung> ? <Wert für true> : <Wert für false>

Man beachte, dass der `? : ` Operator rechts-assoziativ ist:

    a ? b : c ? d : e   wird so geklammert  a ? b : ( c ? d : e )
"""

# ╔═╡ 885f21b4-cb89-4246-b4a4-32ae7c73a867
""" liefere_relation aber jetzt mit `? : `Operator"""
function liefere_relation2(a,b)
	ergebnis = a < b   ? "ist kleiner als" :
	           a == b  ? "ist gleich"      :
		       a > b   ? "ist größer als"  :
			             "steht in keiner Relation zu"
	return string(a) * " " * ergebnis * " " * string(b)
end

# ╔═╡ 5b3dd238-76e5-4fd6-ba56-a8e664b363c7
liefere_relation2(3, 5)

# ╔═╡ 4f6fdde1-9834-49c0-82e2-68f74367f353
liefere_relation2(Set("abc"), Set("acd"))

# ╔═╡ 14db5ba3-51e2-4d2d-a83a-0ecebd3efc05
md"""
## `for` Schleifen

In der einfachsten Variante haben sie die Form

    for <Variablenname> in <Aufzählbares>
      # mach was mit <Variablenname>
    end
"""

# ╔═╡ 7fa51c29-dcae-4cd8-b6ba-6ba9d34f4f3e
for name in ("A", "Bee", "Cee", "Dee")  print(name)  end

# ╔═╡ 2cc09b30-7c3d-4cd9-935d-106445335d56
for buchstabe in ("Achso!") dump(buchstabe) end

# ╔═╡ 6f5ccfea-eb88-4df3-a3cb-34f35f95aa9b
for zahl in [1 2; 3 4]  dump(zahl) end

# ╔═╡ 795bd530-8f35-4cea-8baf-2aea4051c1f8
for zahl in 2:3:10 dump(zahl) end

# ╔═╡ e85e75d2-a572-43c7-b2a3-5c322e695a61
md"""
Innerhalb von `for`-Schleifen gibt es noch `continue` und `break`.

   * `break` beendet die `for`-Schleife sofort.
   * `continue` springt in der `for`-Schleife zum nächsten Wert.
"""

# ╔═╡ ad3d462f-cf20-4409-afa1-fdf2d018e379
md"""
## `while` Schleifen

Die Form lautet:

    while <Bedingung>
      <block>
    end

Dabei werden folgende Schritte durchgeführt:

  1. falls die `<Bedingung>` nicht erfüllt ist, also `false` ist, ist die `while`
     Schleife beendet und es geht nach dem `end` weiter
  2. falls die `<Bedingung>` erfüllt ist, aso `true` ist, wird der `block`
     ausgeführt und es geht bei Schritt 1. weiter.

Diese Form der Schleife bietet sich an, wenn man vorab nicht etwas
`iterierbares` hat und sich erst durch die Ausführungen von `<block>`
ergibt, wie oft `<block>` ausgeführt wird.

Auch bei `while` Schleifen gibt es `break` und `continue` mit der jeweils
gleichen Funktion wie bei `for` Schleifen.
"""

# ╔═╡ 1e9d7335-5066-4633-9d24-e2298ee68112
md"""
### Beispiel

Als Beispiel betrachten wir die ["Collatz" Funktion](https://de.wikipedia.org/wiki/Collatz-Problem)

$f\colon\,\mathbb{N} \to \mathbb{N},\qquad f(n)=\begin{cases} n/2 & \hbox{falls}\ n\  \hbox{gerade} \\ 3n+1  & \hbox{sonst}\end{cases}$

Es wird nun die Folge $(n, f(n), f(f(n)), f(f(f(n))), \ldots)$ betrachtet.
"""

# ╔═╡ 8494d792-868b-47b0-8e2c-b5782c351ce0
"""Liefert Elemente der Collatz-Folge bis 1 auftritt."""
function collatz(n)
	ergebnis = Vector{Int64}()	
	while true
		push!(ergebnis, n)
		if n == 1 break end
		n = iseven(n) ? n ÷ 2 : 3n + 1	# Achtung: Overlow-Check fehlt!
	end
	return ergebnis
end

# ╔═╡ 451951fc-57d6-40bf-9aee-b056cc81d641
collatz(7)

# ╔═╡ 89d417d4-163d-49d5-a297-73872270f5e8
collatz(27)

# ╔═╡ 4aa76fc7-a429-4bbd-aabb-7e779414d679
"""
Hilfsfunktion zur Erzeugung einer HTML-Tabelle zur Darstellung
der üblichen Logik-Tabellen.
"""
function zeige_logik_tabelle(operator, name=repr(operator))
	columns, rows = (false, true), (false, true)
	return HTML(
		"<table><tr><th>" * name * "</th>" * 
		join("<th>" * repr(entry) * "</th>" for entry in columns) * "</tr>" *
		join(
			"<tr><th>" * repr(row) * "</th>" *
			join("<td>" * repr(operator(row, col)) * "</td>" for col in columns) *
			"</tr>" for row in rows) * "</table>")
end;

# ╔═╡ 916a1832-c81e-4a1a-be9e-6334627c65f3
zeige_logik_tabelle((x,y) -> x && y, "&&")

# ╔═╡ 1c56e3a6-d6a0-484e-85c8-e03465a4fb8e
zeige_logik_tabelle((x,y) -> x || y, "||")

# ╔═╡ 7f95dcca-88ed-4602-8d1f-2ee0377bd1ec
zeige_logik_tabelle((x,y) -> x ⊻ y, "⊻")

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

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "8aa109ae420d50afa1101b40d1430cf3ec96e03e"

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
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

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
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

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
# ╟─80bd24de-3dcb-4d81-94f7-b4051bef0954
# ╟─916a1832-c81e-4a1a-be9e-6334627c65f3
# ╟─1c56e3a6-d6a0-484e-85c8-e03465a4fb8e
# ╟─7f95dcca-88ed-4602-8d1f-2ee0377bd1ec
# ╟─e0cfb41f-f0c5-4f49-bdc6-3756db6e2ab5
# ╟─fdddf715-a020-415c-92c9-99dd4f2a7c4a
# ╠═c3b800af-890b-4a39-bbb8-2c924dde99dd
# ╠═6848444f-38cb-4f53-adf4-72b3f075c5e7
# ╠═8b4d3cc4-c1f6-41b6-be4c-768b266f800d
# ╠═0351cf1a-f7fa-48dd-8937-963d4645f1a6
# ╠═921d4fd6-d226-4124-929f-d32bdbd5f88e
# ╠═dc9de226-74dc-4ac0-bf20-9c563bb7d103
# ╟─5fd2a75f-8f1c-4716-a338-6da0663bfd1d
# ╠═885f21b4-cb89-4246-b4a4-32ae7c73a867
# ╠═5b3dd238-76e5-4fd6-ba56-a8e664b363c7
# ╠═4f6fdde1-9834-49c0-82e2-68f74367f353
# ╟─14db5ba3-51e2-4d2d-a83a-0ecebd3efc05
# ╠═7fa51c29-dcae-4cd8-b6ba-6ba9d34f4f3e
# ╠═2cc09b30-7c3d-4cd9-935d-106445335d56
# ╠═6f5ccfea-eb88-4df3-a3cb-34f35f95aa9b
# ╠═795bd530-8f35-4cea-8baf-2aea4051c1f8
# ╟─e85e75d2-a572-43c7-b2a3-5c322e695a61
# ╟─ad3d462f-cf20-4409-afa1-fdf2d018e379
# ╟─1e9d7335-5066-4633-9d24-e2298ee68112
# ╠═8494d792-868b-47b0-8e2c-b5782c351ce0
# ╠═451951fc-57d6-40bf-9aee-b056cc81d641
# ╠═89d417d4-163d-49d5-a297-73872270f5e8
# ╟─a545d484-7104-11ef-315d-01f9f2978ea4
# ╟─4aa76fc7-a429-4bbd-aabb-7e779414d679
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
