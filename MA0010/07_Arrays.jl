### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 7cfa90e9-311d-4592-941e-2c154e18fa37
begin
	using PlutoUI
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ ecb63dbc-6f70-11ef-32c8-a73a30c0a168
md"""
# Arrays

Arrays sind Ansammlungen von (endlich vielen) Objekten in einem
$d$-dimensionalen (uniformen) Gitter (z.B. Rechteck, Quader).

Auf die Elemente eines Arrays wird mit der Klammernotation `[...]`
zugegriffen. Die Indizes sind (meist) Elemente des $\mathbb{N}^d$.
[Weiter unten sprechen wir über die verschiedenen Arten der Indizierung.]

Die Notation des Typs ist `Array{<Typ der Elemente>, d}` bzw.
Subtypen/Spezialisierungen davon.

!!! danger "Achtung"
    Es gibt veränderbare und unveränderbare Arrays! Dies entscheidet
    der entsprechende (Sub-)Typ.
"""

# ╔═╡ c535824f-00f7-40af-8fce-c65be9a2130d
md"""
## 0-dim Arrays

Sie sind langweilig. Entlang der nicht-vorhandenen Dimension wird die Ansammlung
von genau einem(!) Objekt gespeichert (anlog zur Geometrie: Ebene ist 2D,
Gerade ist 1D und ein Punkt ist 0D-Objekt):
"""

# ╔═╡ 72f9872d-7b58-4585-af90-69661e77539f
let
	A0 = zeros()
	A0[] = 5.5
	@show typeof(A0)
	print(A0[])
end;

# ╔═╡ 2c0ddec5-08aa-4a63-bdae-d94016d3622f
md"""
## 1-dim Arrays (Vektoren)

Bei Vektoren sind die Indizes Integer Zahlen. Der erste Eintrag hat den Index $1$.

Vektoren lassen sich durch Aufzählung der Element mit wenig Tipparbeit
erzeugen:
"""

# ╔═╡ 9d29d539-d0de-4952-9cc6-d9a98703ecfc
vektor = [5, 3, -3]

# ╔═╡ 5683dcc2-1c44-4a5d-8a5e-1c9c668971c9
md"""
Das Komma "," trennt bei Vektoren(!) die Einträge. 
Alternativ kann man auch ";" verwenden.

Hier ist der Typ des soeben erzeugten Vektors:
"""

# ╔═╡ 4fe70375-82b3-440d-b1b4-37d1698304fc
typeof(vektor)

# ╔═╡ f6dac188-1285-4ae8-805a-309b3fa4081d
md"""
Weitere Möglichkeiten zur Erzeugung von Vektoren und zum Auslesen von Elementen:
"""

# ╔═╡ 59345233-9203-4397-a28f-88b56deee959
let
	@show [1; "bla"; 20.5; π ] # Konstruktion mit expliziter Aufzählung der Elemente
	@show zeros(Int64, 5)      # Vektor mit fünf Nullen vom Typ Int64
	@show ones(Int8, 5)        # Vektor mit fünf Einsen vom Typ Int8
	@show a = b = rand(3)       # 3 "zufällige" Gleitkommazahlen	
	@show a[2], a[end], b[2]
	@show similar(b)           # gleiche Dimension/Größe wie b; nicht initialisiert
end;

# ╔═╡ 3c688237-4d50-41bf-8701-e943c5d67689
md"""
Bei veränderbaren Arrays können Elemente auch (nach der Konstruktion) verändert werden:
"""

# ╔═╡ 300dd55e-2c76-4ee3-9f4d-ed0dff9e2842
let
	vektor = [1, 0, 3, 4, 5]
	vektor[2] = 2
	vektor
end

# ╔═╡ 01abd3b7-c7a8-4e21-8157-a35b78ce7bbf
md"""
## 2-dim Arrays (Matrizen)

Ähnlich zu Vektoren, gibt es auch eine eigene Schreibweise/Notation,
um Matrizen durch Aufzählung der Elemente zu erzeugen:

Die Zeilen werden dabei durch Strichpunkt ";" voneinander getrennt
und die Spalten durch Leerzeichen/Spaces " ".
"""

# ╔═╡ 66472bfa-118e-4f7d-b72f-714df4148a76
matrix = [1 -2 3 ; 0 1 0]

# ╔═╡ 0e37c7b3-959a-4acc-9ddd-d784233abf3e
typeof(matrix)

# ╔═╡ 6ad1f64e-ecbf-45b9-8aa4-c53036d8f6ec
md"""
Weitere Möglichkeiten zur Erzeugung von Matrizen und zum Auslesen von Elementen:
"""

# ╔═╡ 99091eaf-9f54-44ac-b795-d258ba4f1591
let
	@show [1 "bla"; 20.5 π ]   # Konstruktion mit expliziter Aufzählung der Elemente
	@show zeros(Int64, (3,2))  # 3×2 Matrix mit Nullen vom Typ Int64
	@show ones(Int8, (2,1))    # 2×1 Matrix mit Einsen vom Typ Int8
	@show B = rand(2, 2)       # 2×2 Matrix mit "zufälligen" Gleitkommazahlen	
	@show [1,2,3]'             # Transposition eines Vektors: hier 1×3 Matrix
	@show B[1,1], B[end]
	@show similar(B)
end;

# ╔═╡ 16a3c27b-45f7-4b1b-b34b-b46a330cedc4
md"""
Mit der Matrix-Schreibweise `[ ... ; ....]` lassen sich auch Matrizen aus
Submatrizen erstellen:
"""

# ╔═╡ 883723e1-ae7b-4812-a0fe-b7e39c8f4015
let
	vektor = [1,3]
	matrix = [ vektor' ; -1 -2; -2vektor' ]
end

# ╔═╡ d6866ef7-98f8-4810-9ce1-b05f6ee9d9b6
let
	vektor = [1,3]
	matrix = [ vektor' ; -1 -2; -2vektor' ]
	[matrix  2matrix; 3matrix  -matrix]
end

# ╔═╡ 7697f81f-765f-4f42-858a-5df201893862
md"""
Das alles sind Spezialfälle der Funktion `cat`, die verwendet werden
kann, um Objekte entlang beliebiger Dimensionen anzuordnen:
"""

# ╔═╡ d65515ca-f689-4f95-add5-4af6425748c8
M1 = let
	row = [1 2 3]
	matrix = cat(
			cat(row, row, row, dims=1), 
			row', row', dims=2)
	cat(matrix, ones(Int64, (3,5)), dims=3)
end

# ╔═╡ 7fa28ec3-caed-4490-b108-8e5bdee451e2
md"""
Und damit sind wir schon beim nächsten Abschnitt:
"""

# ╔═╡ 6e2ba21b-4dc5-4cae-ac76-b23814900745
md"""
## d-dim Arrays

Solche höherdimensionalen Arrays baut man häufig aus kleineren
Bauteilen mit Hilfe von `cat` zusammen.

Es gibt aber auch hier eine Notation: Strichpunkt ";" und ";;" und ";;;". Die
Bedeutungen (in absteigender Priorität):

|  Symbol               |   Bedeutung                                 |
| --------------------: | ------------------------------------------- |
| Leerzeichen           | entlang der 2. Dimension zusammenbauen      |
|  `;`                  | entlang der 1. Dimension zusammenbauen      |
|  `;;`                 | entlang der 2. Dimension zusammenbauen      |
|  `;;;`                | entlang der 3. Dimension zusammenbauen      |
|  usw.                 | usw.                                        |

Damit kann man obiges Beispiel in verschiedensten Weisen auch
mit dieser Notation schreiben:
"""

# ╔═╡ c750d536-69e7-4182-9e2c-5bf9928fa768
M2 = [[ 1 2 3 1 1; 1 2 3 2 2; 1 2 3 3 3 ];;; ones(Int64, (3,5))]

# ╔═╡ 8bcc5a54-7173-40e6-bdbd-d2e053012ec5
M3 = [[ 1;; 2;; 3;; 1;; 1]; [1;; 2;; 3;; 2;; 2]; [1;; 2;; 3;; 3;; 3] ;;; 
	ones(Int64, (3,5))]

# ╔═╡ accbdf40-3830-49f1-87c1-f711ae812795
M4 = [1;1;1 ;; 2;2;2 ;; 3;3;3 ;; 1;2;3 ;; 1;2;3 ;;; ones(Int64, (3,5))]

# ╔═╡ 46e9a98c-950f-404a-a875-657792a0a39b
M1 == M2 == M3 == M4

# ╔═╡ 895425b7-be35-4eae-9542-eba4527f3897
md"""
## kartesische und lineare Indizierung

Es gibt mehrere Möglichkeiten auf einzelne Elemente von Arrays zuzugreifen (um sie
auszulesen oder zu verändern).

Hier ein Beispiel:
"""

# ╔═╡ ce2a4dee-0c82-4f9b-8d50-9e9808ed8cf1
A = [ 1 11 111; 4 5 6]  # unsere Beispielmatrix

# ╔═╡ 229e496c-284a-42fb-9804-f292611d4f48
A[1,2] # Element mit Index (1,2): 1. Zeile, 2. Spalte
# das ist aber nur eine Kurzform für:

# ╔═╡ 59548e17-bec6-41b1-90ac-fa71f4626c91
A[CartesianIndex(1,2)] # Element mit kartesischem Index (1,2)

# ╔═╡ 85f742df-c485-41d2-a1b5-87d34b55789f
md"""
Irgendwie werden aber oft die Elemente eines Arrays im (linearen) Speicher auch
angeordnet. Daher gibt es auch eine Möglichkeit diese linearisierte
Nummeriung zu verwenden:
"""

# ╔═╡ 061030a4-c0dd-4800-b0eb-6857eb7d1b2d
A[1], A[2], A[3]   # ersten 3 Elemente (in der linearisierten Nummerierung)

# ╔═╡ 06573d64-6f24-4c20-a427-4b2fd9c26b5c
md"""
Julias `findall` liefert (in einigen Fällen) auch `CartestianIndex` Objekte als Ergebnis:
"""

# ╔═╡ 54ab44da-8221-4ed3-97e6-55832af06c27
findall(iseven, A)   # alle Positionen der Einträge in A finden, die gerade sind

# ╔═╡ 9cee6017-e02d-4583-aeb5-2445a5916e8d
md"""
Wie rechnet man zwischen den beiden Indizierungsmethoden um?

`LinearIndices()` liefert für ein Array ein neues Array der
gleichen Größe (und Dimensionen), wo an jeder Position der
linearisierte Index steht.

Man sieht es am besten am Beispiel:
"""

# ╔═╡ 8a6b53e2-03b8-4dd3-bbb0-f92e502b1410
LIA = LinearIndices(A)

# ╔═╡ 2c3d9d26-8d8e-4a2a-b135-abcaef4f2739
md"""
Analog gibt es `CartesianIndices()`:
Es liefert ein (linear) indizierbares Objekt, welches
den jeweiligen `CartesianIndex` zurückgibt.
"""

# ╔═╡ 34e4bac7-2213-4f11-b4fb-a218d1bfdee4
CIA = CartesianIndices(A)

# ╔═╡ af08e77f-1079-45bf-8f21-44dd2118e1ef
CIA[5]  # linear Index 5 gehört zu Index (1,3)

# ╔═╡ c7ef9140-a06e-4a59-a414-001919767cc2
md"""
## mehrere Elemente gleichzeitig indizieren

Man kann auch mehrere Elemente eines Arrays gleichzeitig
ansprechen.

Bei all den folgenden Methoden werden stets neue Objekte
(entsprechend der Auswahl/Indizierung) erzeugt. Mit `view()`
gibt es eine Möglichkeit dies zu verhindern und eine (An-)Sicht
auf das Original zu bekommen. Bei solchen `view`s werden Änderungen
direkt im Original vorgenommen.

### Aufzählungen von Indizes
"""

# ╔═╡ f51ebec8-4630-450d-8737-47c790cb8572
A[[2,5,6]]  # das (linearisierte) 2., 5. und 6. Element von A

# ╔═╡ 9eb52f6f-e1fe-430b-b68f-a92fc0353201
A[[1,2], [1,3]] # (kartesisch:) die Zeilen 1 und 2 und dort die Spalten 1 und 3

# ╔═╡ 51446b73-2962-4108-b24d-f6fc82a6b63f
A[1:2, 3]   # (kartesisch:) Range der Zeilen 1 bis 2 und dort die 3. Spalte

# ╔═╡ 532c74ef-7e15-49e8-b5e0-e4f06761426f
A[begin:end, 3], A[:,3]     # gleiche nochmal in weiteren Varianten

# ╔═╡ 11f03785-5b4e-41d6-8305-36dcc8b49bac
md"""
### logische Auswahl von Indizes

Dies ist eine häufige Form, weil sie viele Dinge erleichtert:
"""

# ╔═╡ 30e93812-897d-4b35-ab44-5f6921478be4
A .> 5        # liefert Bit, wo elementweise/punktweise Bedingung erfüllt ist

# ╔═╡ 262b824e-88a7-495a-bfe1-e9fe06bc0f8b
A[A.>5]       # man kann BitArrays als Indizierung verwenden

# ╔═╡ fc787fc0-e465-49f4-8dbe-1e41f7bda38e
md"""
### Beispiel mit `view()`

Mit `view` geht alles genauso, nur dass nicht kopiert wird:
"""

# ╔═╡ 84b14d04-84ec-4ef5-b49e-b7d1921d200a
B = [ 1 11 111; 4 5 6]  # B matrix

# ╔═╡ a60648a8-fcf7-4da7-bda8-5898a51fa27b
vB = view(B, B.>5) # liefert Sicht/View auf Elemente, die JETZT größer als 5 sind

# ╔═╡ 75785851-da87-4994-b2ea-d7f8858d31a9
vB[2]   # 2. Element, das größer als 5 ist

# ╔═╡ 69a3822e-8273-48c4-8304-16a5a2b6ea18
vB[:]   # alle Elemente

# ╔═╡ 3b859757-2735-4e59-84a7-2dcded633ab5
vB[2] = -vB[2]  # Ändern 2. Element

# ╔═╡ d60c43c0-8161-4508-88b2-f684de262c3e
B

# ╔═╡ 8dee36dd-93c7-4e59-98aa-ea5e4af0cf25
md"""
## Comprehensions

Eine weitere Variante, die sich sehr sehr nahe an
der Notation in der Mathematik orientiert, sind Array-Comprehensions:
"""

# ╔═╡ 9facd00b-73d1-4816-be37-83914ad670e2
[x^2 for x in [1,10,100,201,202]]

# ╔═╡ a0762a56-9fbc-417f-be97-4dff75e8bc71
[x^2 for x in [1,10,100,201,202] if iseven(x^2)]

# ╔═╡ 2ab70645-41a9-400c-a87f-e7bb4074fad2
[x*y for x in [1,2,3]  for y in [10,11]]

# ╔═╡ 6ba86a81-9532-4f78-92d1-26de601d08c6
[x*y for x in [1,2,3], y in [10,11]]

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
# ╟─ecb63dbc-6f70-11ef-32c8-a73a30c0a168
# ╟─c535824f-00f7-40af-8fce-c65be9a2130d
# ╠═72f9872d-7b58-4585-af90-69661e77539f
# ╟─2c0ddec5-08aa-4a63-bdae-d94016d3622f
# ╠═9d29d539-d0de-4952-9cc6-d9a98703ecfc
# ╟─5683dcc2-1c44-4a5d-8a5e-1c9c668971c9
# ╠═4fe70375-82b3-440d-b1b4-37d1698304fc
# ╟─f6dac188-1285-4ae8-805a-309b3fa4081d
# ╠═59345233-9203-4397-a28f-88b56deee959
# ╟─3c688237-4d50-41bf-8701-e943c5d67689
# ╠═300dd55e-2c76-4ee3-9f4d-ed0dff9e2842
# ╟─01abd3b7-c7a8-4e21-8157-a35b78ce7bbf
# ╠═66472bfa-118e-4f7d-b72f-714df4148a76
# ╠═0e37c7b3-959a-4acc-9ddd-d784233abf3e
# ╟─6ad1f64e-ecbf-45b9-8aa4-c53036d8f6ec
# ╠═99091eaf-9f54-44ac-b795-d258ba4f1591
# ╟─16a3c27b-45f7-4b1b-b34b-b46a330cedc4
# ╠═883723e1-ae7b-4812-a0fe-b7e39c8f4015
# ╠═d6866ef7-98f8-4810-9ce1-b05f6ee9d9b6
# ╟─7697f81f-765f-4f42-858a-5df201893862
# ╠═d65515ca-f689-4f95-add5-4af6425748c8
# ╟─7fa28ec3-caed-4490-b108-8e5bdee451e2
# ╟─6e2ba21b-4dc5-4cae-ac76-b23814900745
# ╠═c750d536-69e7-4182-9e2c-5bf9928fa768
# ╠═8bcc5a54-7173-40e6-bdbd-d2e053012ec5
# ╠═accbdf40-3830-49f1-87c1-f711ae812795
# ╠═46e9a98c-950f-404a-a875-657792a0a39b
# ╟─895425b7-be35-4eae-9542-eba4527f3897
# ╠═ce2a4dee-0c82-4f9b-8d50-9e9808ed8cf1
# ╠═229e496c-284a-42fb-9804-f292611d4f48
# ╠═59548e17-bec6-41b1-90ac-fa71f4626c91
# ╟─85f742df-c485-41d2-a1b5-87d34b55789f
# ╠═061030a4-c0dd-4800-b0eb-6857eb7d1b2d
# ╟─06573d64-6f24-4c20-a427-4b2fd9c26b5c
# ╠═54ab44da-8221-4ed3-97e6-55832af06c27
# ╟─9cee6017-e02d-4583-aeb5-2445a5916e8d
# ╠═8a6b53e2-03b8-4dd3-bbb0-f92e502b1410
# ╟─2c3d9d26-8d8e-4a2a-b135-abcaef4f2739
# ╠═34e4bac7-2213-4f11-b4fb-a218d1bfdee4
# ╠═af08e77f-1079-45bf-8f21-44dd2118e1ef
# ╟─c7ef9140-a06e-4a59-a414-001919767cc2
# ╠═f51ebec8-4630-450d-8737-47c790cb8572
# ╠═9eb52f6f-e1fe-430b-b68f-a92fc0353201
# ╠═51446b73-2962-4108-b24d-f6fc82a6b63f
# ╠═532c74ef-7e15-49e8-b5e0-e4f06761426f
# ╟─11f03785-5b4e-41d6-8305-36dcc8b49bac
# ╠═30e93812-897d-4b35-ab44-5f6921478be4
# ╠═262b824e-88a7-495a-bfe1-e9fe06bc0f8b
# ╟─fc787fc0-e465-49f4-8dbe-1e41f7bda38e
# ╠═84b14d04-84ec-4ef5-b49e-b7d1921d200a
# ╠═a60648a8-fcf7-4da7-bda8-5898a51fa27b
# ╠═75785851-da87-4994-b2ea-d7f8858d31a9
# ╠═69a3822e-8273-48c4-8304-16a5a2b6ea18
# ╠═3b859757-2735-4e59-84a7-2dcded633ab5
# ╠═d60c43c0-8161-4508-88b2-f684de262c3e
# ╟─8dee36dd-93c7-4e59-98aa-ea5e4af0cf25
# ╠═9facd00b-73d1-4816-be37-83914ad670e2
# ╠═a0762a56-9fbc-417f-be97-4dff75e8bc71
# ╠═2ab70645-41a9-400c-a87f-e7bb4074fad2
# ╠═6ba86a81-9532-4f78-92d1-26de601d08c6
# ╟─7cfa90e9-311d-4592-941e-2c154e18fa37
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
