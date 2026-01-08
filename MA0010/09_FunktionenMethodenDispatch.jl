### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 43207c3e-81ea-4bba-99df-ad0df1a6cb81
begin
	using PlutoUI	
	
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ af6df2b6-74ec-11ef-164c-9937ecf2d509
md"""
# Funktionen und Methoden

Es gibt im wesentlichen 3 Möglichkeiten in Julia Funktionen
zu definieren.

## Funktionen mit `function`

Die 1. Variante (haben wir schon gesehen):
"""

# ╔═╡ 22afdb84-9f1f-4478-aff6-4e04adb192e3
md"""
Falls eine solche Funktion kein `return` hat, dann wird als Rückgabe
das Objekt genommen, welches als letztes berechnet/ausgewertet/behandelt
wurde.

Beim Aufruf werden die Argumente der Reihe nach den lokalen Variablen
zugewiesen.
"""

# ╔═╡ 80eeb653-519e-4093-9a88-569bf75a0163
md"""
Da die Eingaben als Variablenzuweisung (Binding) übergeben werden, kann
eine Funktion veränderbare Objekte auch dauerhaft verändern.

Funktionen, die ein oder mehrere Argumente verändern, tragen
per Konvention im Namen ein "!" am Ende. Die Argumente die
verändert werden, werden per Konvention als erstes übergeben:
"""

# ╔═╡ 8adde1ca-7f6d-4a81-ae6a-8cd7dd6b4699
"""zählt den ersten Eintrag in a um delta hoch."""
function erhöhe_ersten_Eintrag!(a, delta=1)
	a[1] += delta
	return a
end;

# ╔═╡ 775af22c-18e3-4d6f-bda9-36a58864ab8a
md"""
Hier oben neu ist auch, dass man Eingabeargumente (hier `delta`) einen
Default-Wert geben kann, der verwendet wird, falls dieses Argument
nicht übergeben wird.
"""

# ╔═╡ d37ef29b-02d8-435b-bbd8-c68cf2e2e777
erhöhe_ersten_Eintrag!([1,2,3]), erhöhe_ersten_Eintrag!([1,2,3], -5)

# ╔═╡ fb20f61d-7baf-43b6-a5ed-96bf6093c953
md"""
## Funktionen mit kompakter Zuweisung

Falls die Funktion nur ein kurzer Ausdruck ist, dann bietet sich
die 2. Variante an:
"""

# ╔═╡ 0a0c9fe5-a9b4-4060-aa88-fe7841280c27
md"""
Das ist wirklich nur eine verkürzende Schreibweise und keine
neue "Art" von Funktionen.

## namenlose Funktionen

Und dann gibt es noch Funktionen ohne Namen! (Manche andere Programmiersprachen
nennen sie auch lambda-Funktionen.)

Entweder lässt man bei `function ...` einfach den Namen weg oder man nimmt die `->`
Notation:
"""

# ╔═╡ 92afeb81-c6a4-441a-a3ba-664b0374a865
x -> x^2

# ╔═╡ fb2ef3e7-d1d2-44c8-a544-ebdf437f06fd
function (x)  return x^2 end

# ╔═╡ c55ef1c7-b27f-4241-a76f-d99402e8c4cc
md"""
Wozu eine Funktion, die man nicht mit Namen verwenden kann?

   1. natürlich kann man diese namenlose Funktion einer Variablen zuweisen.
   2. Man kann diese namenlose Funktion an eine andere Funktion übergeben.
"""

# ╔═╡ 383d52d0-1ceb-48a3-9618-5629da8837f1
dump(x -> x^2)

# ╔═╡ cc238d97-a2d8-44cf-b74a-557f10370b1f
# ein etwas realistischeres Beispiel
map(x -> x^2, [1,2,10,11])   # kann man natürlich auch [1,2,10,11].^2 schreiben

# ╔═╡ a28859ed-e72c-49b7-a58d-480aa75a313b
md"""
Der Fall, dass man eine Funktion (als 1. Argument) übergeben muss, kommt
in Julia relativ häufig vor. Daher gibt es dafür eine Syntax, die das
erheblich vereinfacht: die `do`-Syntax:
"""

# ╔═╡ fbd52f57-7ec9-4622-a082-eac028ae1de1
map([1,2,10,11]) do x
   x^2
end

# ╔═╡ 6cd62a05-e962-4665-9d61-efee60ee7031
md"""
Die hat den Vorteil, dass der `do`-Block ein ganzer Block ist und man
dort mehrere Anweisungen, Verwzeigungen, Schleifen, etc. verwenden kann:
"""

# ╔═╡ 4508867a-8b01-4153-a0f8-be024260afc4
map([1,2,10,11]) do x
	if iseven(x)
		return x^2
	else
		return -x
	end
end

# ╔═╡ e2dc2a4d-ab7a-4f58-a1f2-0cc10fa312b0
# das gleiche kürzer
map(x -> iseven(x) ? x^2 : -x, [1,2,10,11])

# ╔═╡ cbf46f72-5c3d-445f-9204-daaec9d7319e
md"""
Eine andere Funktion als `map`, wo der `do`-Syntax häufig Anwendung findet
ist `filter`.
"""

# ╔═╡ 687d7395-2fe2-4df7-8467-0763cb0d5774
filter(iseven, [1,2,10,11])

# ╔═╡ 9f88444b-3694-485b-b7af-6949c48de72d
md"""
## Methoden (Multiple Dispatch)

Jetzt kommt ein sehr Julia-spezifischer Abschnitt. Andere Programmiersprachen
haben dafür andere (oder keine) Konzepte. Und wenn wir schon Programmierung
mit Julia machen, dann sollte man auch auf eines der Julia-Highlights
zu sprechen kommen.

Julia hat für eine Funkion, z.B. für `kurz_und_bündig` oben, mehrere
"Spezialisierungen"! Für jeden Satz von verschiedenen Typen(!) von
Eingabeargumenten wird eine Spezialisierung (speziell für diese Typen)
kompiliert:
"""

# ╔═╡ e29f2ed3-10af-47ec-9709-5f67458e0ebe
md"""
Da bisher `kurz_und_bündig` mit zwei `Int64` und mit zwei `String` verwendet
wurde, gibt es bisher 2 Spezializations. Wenn wir weitere Aufrufe mit
anderen Typen machen, wird Julia für diese eine Funktion auch andere
Spezialisierungen kompilieren.

!!! danger "Achtung"
    In Pluto werden alte Zellen automatisiert aktualisiert, sollte sich
    (später) etwas verändern (was in der Zelle benötigt wird). Daher sieht
    man in Pluto oben schon auch `Float64` Spezifikationen, obwohl diese
    erst weiter unten vorgenommen werden.
"""

# ╔═╡ e7661390-3415-421e-b508-c1db052e800d
md"""
Julia bietet nun direkt an, dass man für verschiedene Typen auch ganz
andere Implementierungen (also ganz anderen Code) angibt.
Das sind dann die verschiedenen "Methoden" ein und derselben Funktion.
"""

# ╔═╡ 321e7929-5a1a-4236-9293-355e81e54b98
md"""
Die Auswahl der richtigen Methode anhand der übergebenen Typen, nennt man
"multiple dispatch".

Ganz Julia versucht sich so mit geeigneten Methoden-Definitionen zu
organisieren.
"""

# ╔═╡ 1c735ee0-74ba-4e17-b6fe-d9b41efcdaaa
@which 5 + 2

# ╔═╡ f7979b78-d489-4f72-9634-7ff1020672f1
@which 5.0 + 2

# ╔═╡ be1eeae5-9be2-413e-bbbb-139a48e3e19f
@which 5.0 + 2.0

# ╔═╡ 1897b847-2bb9-4b1a-9369-85976b96eb65
md"""
## Broadcasting

Und dann sind wir bei einem weiteren Julia-Highlight: `broadcast` und die
Sache mit dem Punkt ".".
"""

# ╔═╡ 804b4e18-8ee6-4365-b5a0-0b6e4bf858f7
[1 2 ; 3 4] .+  [4 5 ; 6 7]

# ╔═╡ 7641e363-88ad-4830-a30f-3c14cf3fade1
[1 2 ; 3 4] .+ [1; 2]  # Broadcast entlang der 1. Dimension

# ╔═╡ 2cbbec15-a89c-47fa-90cd-31cd016f15e4
[1 2 ; 3 4] .+ [1;; 2]   # Broadcast entlang der 2. Dimension

# ╔═╡ 3b1b6d0a-2df4-4d4d-92a0-5b00831bc1c8
[1 2 ; 3 4] .+ [1 2]   # nochmal entlang der 2. Dim mit anderer Schreibweise

# ╔═╡ 8e2d06e8-cdfd-40e2-bb66-d413a198979a
md"""
Das alles ist nur syntaktischer "Sugar" und löst auf Aufrufe
von `broadcast` auf:
"""

# ╔═╡ 8da224d5-8933-4a08-a6ba-da476f733839
broadcast(+, [1 2 ; 3 4], [1 2])

# ╔═╡ 841eaa5d-44c7-435e-b65b-ab44e8a35926
md"""
Multiple Dispatch (also geschickt definierten Methoden für
verschiedenste Typen der Argumente für `broadcast`) ermöglicht dieses
Feature.
"""

# ╔═╡ 0564f0eb-9d5a-4287-9017-70d4a07b2afc
broadcast(string, [1,2,3], ". ", ["Los", "weiter", "noch weiter"])

# ╔═╡ 6f4fa20e-e325-4c8b-b66d-e08c26916779
string.([1,2,3], ". ", ["Los", "weiter", "noch weiter"])

# ╔═╡ 44191fc7-888a-4579-a832-f92e3a6ad915
md"""
Auch Zuweisungen unterstützen Broadcasting. Daher gibt es auch
`.=` und `.+=` und `.*=` etc.
"""

# ╔═╡ 413a8706-92f3-4097-b27a-882344893564
md"""
Julia gibt sich im Fall, wo mehrere broadcasts in einem Ausdruck vorkommen,
viel Mühe, diese möglichst zu einer Schleife zu verheiraten (fused broadcast),
damit kein (möglichst wenig) Zusatzspeicher benötigt wird.
"""

# ╔═╡ 605258a3-9e17-4afb-93e9-718e43efabf5
sin.(cos.([1,2,3])) # wird zu

# ╔═╡ ad6035d6-d98a-4bfd-97e6-e7df4cdd8e65
broadcast(x -> sin(cos(x)), [1,2,3])

# ╔═╡ 06292583-1269-437c-a00e-a9e621e48ce0
md"""
## Beispiel: Spielkarten 🂡

Wir wollen das mal in Aktion sehen und nehmen dazu Spielkarten
als Beispiel.

Mit `@enum` Kann man (Integer-)Aufzählungen einen eigenen Typ
geben und den einzelnen Integers in der Aufzählung einen Namen:
"""

# ╔═╡ f2e027fa-79ce-4a12-b433-1636ea4c9e9c
"""Ein "Symbol", welches auf einer Spielkarte stehen kann."""
@enum Kartensymbol S_A=1 S_2 S_3 S_4 S_5 S_6 S_7 S_8 S_9 S_10 S_B S_D=13 S_K

# ╔═╡ becfa8bd-4b67-4e7a-8871-7f0e764482c2
md"""
Wir werden hier diese Aufzählungen verwenden, um eine menschlich viel
bessere lesbare Form zu haben.

Die Integer selbst sind hier nicht so wichtig. Sie sind (im konkreten Fall)
so gewählt, dass sie hilfreich sind, Unicode-Zeichen zu finden, die die
entsprechende Spielkarte darstellt.
"""

# ╔═╡ 0b9586f6-ecdd-4421-9a89-55218718a8a6
"""Eine Farbe, die eine Spielkarte haben kann."""
@enum Kartenfarbe F_Pik=0 F_Herz F_Karo F_Kreuz

# ╔═╡ e7054d62-2e56-468e-ad69-6236fbf5ed1f
alle_farben = (F_Pik, F_Herz, F_Karo, F_Kreuz);

# ╔═╡ 730013e0-80d7-4205-9698-f0e6b7eacac9
alle_symbole = (S_A, S_2, S_3, S_4, S_5, S_6, S_7, S_8, S_9, S_10, S_B, S_D, S_K);

# ╔═╡ f80e8e33-4394-411a-a593-8e18cccaaa39
md"""
Und jetzt kommt ein composite Datentyp. Ein Typ, der sich aus anderen
Typen zusammensetzt. Eine `struct` ist in Julia unmutable.
"""

# ╔═╡ 3c80344b-1a22-4002-a09b-c3e81ed1b0a3
"""Eine Spielkarte ist unveränderbar (eine Voraussetzung für ein faires Spiel) und hat genau ein Symbol und genau eine Farbe."""
struct Spielkarte
	symbol :: Kartensymbol
	farbe  :: Kartenfarbe
end

# ╔═╡ 4b4f4523-de3d-43e8-a536-3197c57dee72
bsp_karte = Spielkarte(S_9, F_Herz) # so kann man eine konkrete Spielkarte erzeugen

# ╔═╡ 022a807b-5b19-4737-8ca7-3eea2a40c127
bsp_karte.farbe  # liefert Farbe

# ╔═╡ 8687b358-c344-4fd3-abd1-2e168a400e91
bsp_karte.symbol # liefert Symbol

# ╔═╡ b2dbefb9-cc55-414a-ac9c-e8ccfd302a43
Int(bsp_karte.symbol) # so kann man aus einem enum einen Integer machen

# ╔═╡ 8a817771-f8d5-4e33-b305-c82dfc05f62a
bsp_karte.farbe in (F_Herz, F_Pik)  # typischer Tests mit enums

# ╔═╡ 2148d8b5-4a39-4046-a276-ee8a3c40c3ff
md"""
Als nächstes Kommen ein paar "Luxus" Funktionen:

Ständig `Spielkarte(...)` tippen, wenn man eine neue Spielkarte erzeugen will.
Das will man einfacher haben.
Als Beispiel für Julia-Overloading wird jetzt der `*` erweitert:

Man kann mit `<Symbol> * <Farbe>` und `<Farbe> * <Symbol>` direkt eine `Spielkarte` erzeugen.

Außerdem zeigen wir Spielkarte gleich mit dem passenden Unicode-Zeichen an. Dazu wird die `Base.show` Methode überladen.
"""

# ╔═╡ 6b936b17-c0c1-426e-afa3-94ecafa6ee14
begin
	import Base.*
	(*)(symbol::Kartensymbol, farbe::Kartenfarbe) = Spielkarte(symbol, farbe)
	(*)(farbe::Kartenfarbe, symbol::Kartensymbol) = Spielkarte(symbol, farbe)
end;

# ╔═╡ aa68ea56-58c9-4083-9e5a-84e61e029c1d
"""Dies ist die Dokumentation von neue_funktion."""
function neue_funktion(a,b) # neuer Scope: lokale Var. a und b sind Input
	sq = a^2                # lokale Variablen (nur in diesem Scope)
	return b*sq             # Rückgabe
end;

# ╔═╡ 881109bd-8883-47f3-8fc3-8801bd317408
neue_funktion(5,2), neue_funktion("aber ", "äh ")

# ╔═╡ df0235af-4ac6-4622-84c3-69fba60c6b49
kurz_und_bündig(x, y) = y*x^2

# ╔═╡ b3e3cfd0-980b-47b0-bbfc-397ee3005241
kurz_und_bündig(5, 2), kurz_und_bündig("aber ", "äh ")

# ╔═╡ 0cffa196-3e32-4569-8a21-7c3e7be5a96b
kurz_und_bündig(1.2, 1.2)

# ╔═╡ 42f86020-4c7e-45e0-ab22-7e6c8132791a
begin
	verrückt(a::Integer, b::Integer) = a * b # bei Integer wird multipliziert
	verrückt(a::AbstractFloat, b::AbstractFloat) = a + b # bei Float wird addiert
	verrückt(a,b) = a # ansonsten liefert verrückt das erste Argument
end

# ╔═╡ 21e40fde-6a75-479b-a470-1a0ca7bbce76
verrückt(1,2), verrückt(1.0, 2.0), verrückt(1.0, 2), verrückt("ja", "nein")

# ╔═╡ b1203940-dcd4-4053-b65b-606c31600d7e
let
	a = [1,2,3]
	a .=  a .* a .+ 5
	@show a
	@show a .< 10
end

# ╔═╡ 3823433f-71bd-44fb-8ce8-570115762418
begin
	"""liefere Unicode-Zeichen für angegebene Spielkarte."""
	karte2char(karte::Spielkarte) = Char(
		0x1f0a0 + UInt(karte.farbe) * 0x10 + UInt(karte.symbol))
	
	import Base.show
	show(io::IO, karte::Spielkarte) = print(io, karte2char(karte))	
end

# ╔═╡ 535f8946-b5ce-4bb1-9ffc-d0eeb6ef918b
md"""
Damit kann man jetzt Spielkarten schneller erzeugen und sie sehen auch
ordentlich in der Ausgabe aus:
"""

# ╔═╡ 0b796343-3154-4eb4-8cb3-fe50c4266cc8
[S_2 * F_Pik, S_K * F_Herz]

# ╔═╡ 850ad618-d58f-43e0-ad2d-61d93c1cd439
md"""
Außerdem kann man jetzt Folgendes machen (äußeres Produkt).
"""

# ╔═╡ ee72cd83-a91f-41c2-ae82-132d73357810
kartendeck = Tuple(symbol*farbe for farbe in alle_farben for symbol in alle_symbole)

# ╔═╡ c5597a10-1387-45b3-adee-acf6a83e86ea
kron([S_4, S_A], [F_Pik, F_Herz, F_Kreuz])

# ╔═╡ 93a70d91-a9ea-4ead-b6ce-3975038851a4
"""zeige Signaturen aller Methoden einer Funktion an."""
function zeige_methoden_sig(func)
	for method in methods(func)
		print(method.sig, "\n")
	end
end;

# ╔═╡ 7239f585-1233-402e-bbd7-658191eb22ba
# jetzt hat verrückt 3 (vom Programmierer) spezifizierte Methoden
# mit unterschiedlichen Typen-Signaturen
zeige_methoden_sig(verrückt)

# ╔═╡ 26dcc2c6-bde4-48d0-93a9-71a2bcc24388
zeige_methoden_sig(+)

# ╔═╡ 56757b86-44ad-4581-a89a-cdbf93760d23
"""zeige Spezialisierungen einer Funktion an."""
function zeige_methoden_spec(func)
	for method in methods(func)
		for method_instance in method.specializations
			if method_instance === nothing continue end
			print(method_instance, "\n")
		end
	end
end;

# ╔═╡ e8811256-ac73-4840-8d56-72324ccb0a66
zeige_methoden_spec(kurz_und_bündig)

# ╔═╡ ac309b39-782a-4926-9b62-f23fd95dec9f
zeige_methoden_spec(kurz_und_bündig)

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

julia_version = "1.11.6"
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
# ╟─af6df2b6-74ec-11ef-164c-9937ecf2d509
# ╠═aa68ea56-58c9-4083-9e5a-84e61e029c1d
# ╟─22afdb84-9f1f-4478-aff6-4e04adb192e3
# ╠═881109bd-8883-47f3-8fc3-8801bd317408
# ╟─80eeb653-519e-4093-9a88-569bf75a0163
# ╠═8adde1ca-7f6d-4a81-ae6a-8cd7dd6b4699
# ╟─775af22c-18e3-4d6f-bda9-36a58864ab8a
# ╠═d37ef29b-02d8-435b-bbd8-c68cf2e2e777
# ╟─fb20f61d-7baf-43b6-a5ed-96bf6093c953
# ╠═df0235af-4ac6-4622-84c3-69fba60c6b49
# ╠═b3e3cfd0-980b-47b0-bbfc-397ee3005241
# ╟─0a0c9fe5-a9b4-4060-aa88-fe7841280c27
# ╠═92afeb81-c6a4-441a-a3ba-664b0374a865
# ╠═fb2ef3e7-d1d2-44c8-a544-ebdf437f06fd
# ╟─c55ef1c7-b27f-4241-a76f-d99402e8c4cc
# ╠═383d52d0-1ceb-48a3-9618-5629da8837f1
# ╠═cc238d97-a2d8-44cf-b74a-557f10370b1f
# ╟─a28859ed-e72c-49b7-a58d-480aa75a313b
# ╠═fbd52f57-7ec9-4622-a082-eac028ae1de1
# ╟─6cd62a05-e962-4665-9d61-efee60ee7031
# ╠═4508867a-8b01-4153-a0f8-be024260afc4
# ╠═e2dc2a4d-ab7a-4f58-a1f2-0cc10fa312b0
# ╟─cbf46f72-5c3d-445f-9204-daaec9d7319e
# ╠═687d7395-2fe2-4df7-8467-0763cb0d5774
# ╟─9f88444b-3694-485b-b7af-6949c48de72d
# ╠═e8811256-ac73-4840-8d56-72324ccb0a66
# ╟─e29f2ed3-10af-47ec-9709-5f67458e0ebe
# ╠═0cffa196-3e32-4569-8a21-7c3e7be5a96b
# ╠═ac309b39-782a-4926-9b62-f23fd95dec9f
# ╟─e7661390-3415-421e-b508-c1db052e800d
# ╠═42f86020-4c7e-45e0-ab22-7e6c8132791a
# ╠═7239f585-1233-402e-bbd7-658191eb22ba
# ╠═21e40fde-6a75-479b-a470-1a0ca7bbce76
# ╟─321e7929-5a1a-4236-9293-355e81e54b98
# ╠═26dcc2c6-bde4-48d0-93a9-71a2bcc24388
# ╠═1c735ee0-74ba-4e17-b6fe-d9b41efcdaaa
# ╠═f7979b78-d489-4f72-9634-7ff1020672f1
# ╠═be1eeae5-9be2-413e-bbbb-139a48e3e19f
# ╟─1897b847-2bb9-4b1a-9369-85976b96eb65
# ╠═804b4e18-8ee6-4365-b5a0-0b6e4bf858f7
# ╠═7641e363-88ad-4830-a30f-3c14cf3fade1
# ╠═2cbbec15-a89c-47fa-90cd-31cd016f15e4
# ╠═3b1b6d0a-2df4-4d4d-92a0-5b00831bc1c8
# ╟─8e2d06e8-cdfd-40e2-bb66-d413a198979a
# ╠═8da224d5-8933-4a08-a6ba-da476f733839
# ╟─841eaa5d-44c7-435e-b65b-ab44e8a35926
# ╠═0564f0eb-9d5a-4287-9017-70d4a07b2afc
# ╠═6f4fa20e-e325-4c8b-b66d-e08c26916779
# ╟─44191fc7-888a-4579-a832-f92e3a6ad915
# ╠═b1203940-dcd4-4053-b65b-606c31600d7e
# ╟─413a8706-92f3-4097-b27a-882344893564
# ╠═605258a3-9e17-4afb-93e9-718e43efabf5
# ╠═ad6035d6-d98a-4bfd-97e6-e7df4cdd8e65
# ╟─06292583-1269-437c-a00e-a9e621e48ce0
# ╠═f2e027fa-79ce-4a12-b433-1636ea4c9e9c
# ╟─becfa8bd-4b67-4e7a-8871-7f0e764482c2
# ╠═0b9586f6-ecdd-4421-9a89-55218718a8a6
# ╠═e7054d62-2e56-468e-ad69-6236fbf5ed1f
# ╠═730013e0-80d7-4205-9698-f0e6b7eacac9
# ╟─f80e8e33-4394-411a-a593-8e18cccaaa39
# ╠═3c80344b-1a22-4002-a09b-c3e81ed1b0a3
# ╠═4b4f4523-de3d-43e8-a536-3197c57dee72
# ╠═022a807b-5b19-4737-8ca7-3eea2a40c127
# ╠═8687b358-c344-4fd3-abd1-2e168a400e91
# ╠═b2dbefb9-cc55-414a-ac9c-e8ccfd302a43
# ╠═8a817771-f8d5-4e33-b305-c82dfc05f62a
# ╟─2148d8b5-4a39-4046-a276-ee8a3c40c3ff
# ╠═6b936b17-c0c1-426e-afa3-94ecafa6ee14
# ╠═3823433f-71bd-44fb-8ce8-570115762418
# ╟─535f8946-b5ce-4bb1-9ffc-d0eeb6ef918b
# ╠═0b796343-3154-4eb4-8cb3-fe50c4266cc8
# ╟─850ad618-d58f-43e0-ad2d-61d93c1cd439
# ╠═ee72cd83-a91f-41c2-ae82-132d73357810
# ╠═c5597a10-1387-45b3-adee-acf6a83e86ea
# ╟─43207c3e-81ea-4bba-99df-ad0df1a6cb81
# ╟─93a70d91-a9ea-4ead-b6ce-3975038851a4
# ╟─56757b86-44ad-4581-a89a-cdbf93760d23
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
