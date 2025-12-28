### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ beeea862-f515-436d-bbaf-c3b99b7645c0
# Zeige (in Pluto) ein Inhaltsverzeichnis
begin
	using PlutoUI
	using Printf
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 1891df2a-a1bf-4544-b0d8-781b688a26ca
md"""
# Variablen, Objekte und Scopes

Häufig führt das fehlende Verständnis für die Unterschiede von Variablen und Objekten zu großer Verwirrung. Daher wird in diesem Abschnitt versucht, diese Unterschiede deutlich herauszuarbeiten.

Julia verfolgt den "Everything is an object"/"Alles ist ein Objekt"-Ansatz. Dies hat enorme Konsequenzen. Daher wollen wir zunächst näher verstehen, was ein "Objekt" ist.

Das "Alles ist ein Objekt" bezieht sich (wie es so schon heißt) auf "alles, außer Syntax".
"""

# ╔═╡ d69055f8-6c4e-11ef-23d7-81aec1872324
md"""
## Was sind Objekte?

Ein Objekt ist ein Teil des (Arbeits-)Speichers mit
   1. einem Zustand (gespeicherte Bits; die Menge der gespeicherten Bits darf auf leer sein)
   2. einem Typ (der angibt, wie Bits zu interpretieren sind und was man mit dem Objekt tun kann)

Hier erste Beispiele:
"""

# ╔═╡ 4f126d52-7144-4b28-95cd-bb2133ae3b93
typeof(5), sizeof(5)

# ╔═╡ 50d4a4d7-59ae-49a3-b0bd-6d7d94a443d2
typeof(5000000000000000000000000), sizeof(5000000000000000000000000)

# ╔═╡ 4ca9ff63-a199-4a76-9cda-3d9fb16db24d
md"""
### (Un-)veränderbare Objekte

Der Typ eines Objekts entscheidet auch, ob der Zustand eines Objekts (prinzipiell) veränderbar ist oder nicht. Damit kann man Objekte in zwei große Klassen einteilen:
   1. veränderbare Objekte (mutables objects): Ein solches Objekt hat
      (typischerweise) genau einen Bereich im Speicher, wo der Zustand dieses
      Objekts gepflegt wird.
   2. unveränderbare Objekte (unmutable objects): Da der Zustand (per Definition)
      unveränderbar ist, gibt es oft keinen dedizierten Bereich im Speicher, wo
      der Zustand gepflegt wird, sondern solche Objekte (mit deren Zuständen)
      werden oft direkt weitergereicht und/oder kopiert.

Hier sind einige Beispiele: So sind etwa Objekte von folgenden Typen unveränderbar:
   * [Integer- und Floatingpoint-Numbers (ohne "Big" im Namen)](https://docs.julialang.org/en/v1/manual/integers-and-floating-point-numbers/) 
   * [komplexe und rationale Zahlen (ohne "Big" im Namen)](https://docs.julialang.org/en/v1/manual/complex-and-rational-numbers/)
   * [Funktionen](https://docs.julialang.org/en/v1/manual/functions/)
   * [Tuples](https://docs.julialang.org/en/v1/manual/functions/#Tuples)
   * [spezielle Arrays, z.B. Ranges](https://docs.julialang.org/en/v1/base/math/#Base.range)

Objekte von folgenden Typen sind veränderbar:
   * [Big Integers und Big Floats](https://docs.julialang.org/en/v1/base/numbers/#BigFloats-and-BigInts): Das sind Typen aus der [GNU Multiple Precision Arithmetic Library](https://gmplib.org/)
   * [spezielle Arrays, z.B. Matrizen](https://docs.julialang.org/en/v1/base/arrays/)

Mit `ismutable()` kann man für jedes Objekt testen, ob es veränderbar ist.
"""

# ╔═╡ 0f228e01-ff56-48c2-87b7-a68bf8141640
ismutable(5), ismutable(sin), ismutable([1,2,3])

# ╔═╡ 8fa189a9-7324-4517-b451-864a666a8da8
md"""
## Objekte/Typen zur Darstellung von Zahlen

### Integer-Typen

Hier geht es um Integer mit fester "Bitgröße" (also ohne "Big" im Namen).

Mit Integer-Datentypen lassen sich Zahlen aus Teilmengen 
von $\mathbb{Z}$ darstellen. Es gibt *signed* und *unsigned* Integer.

#### Bitdarstellung für unsigned Integers

Ein *unsigned* Integer mit einer Bit-Breite $n$ wird so gespeichert 
$\left(\beta_{n-1},\beta_{n-2},\ldots,\beta_1,\beta_0\right)$ 
(mit $\beta_k\in\{0,1\}$) und  stellt die Zahl

$$z = \sum_{k=0}^{n-1} \beta_k2^k = \beta_{n-1}\cdot 2^{n-1} + \cdots + \beta_2\cdot 2^2 + \beta_1\cdot 2^1 + \beta_0\cdot 2^0$$

dar. Siehe dazu auch [Wikipedia: Stellenwertsystem](https://de.wikipedia.org/wiki/Stellenwertsystem).

Oft stellt man obige Formel auch durch folgendes "Diagramm" dar.

```
    ┌────┬────┬────┬────┬────┬────┬────┐
    │βₙ₋₁│βₙ₋₂│ ⋯  │ ⋯  │ β₂ │ β₁ │ β₀ │
    └────┴────┴────┴────┴────┴────┴────┘
     2ⁿ⁻¹ 2ⁿ⁻²  ⋯    ⋯    2²   2¹   2⁰
```

#### Bitdarstellung für signed Integers

Bei einem *signed* Integer wird das höchste Bit verwendet, um negative Zahlen
bekommen zu können:

Ein *signed* Integer mit einer Bit-Breite $n$ wird so gespeichert 
$(\beta_{n-1},\beta_{n-2},\ldots,\beta_1,\beta_0)$ 
(mit $\beta_k\in\{0,1\}$) und stellt die Zahl

$$z = (-1)\cdot\beta_{n-1}2^{n-1}+\sum_{k=0}^{n-2} \beta_k2^k = -\beta_{n-1}\cdot 2^{n-1}+\beta_{n-2}\cdot 2^{n-2} + \cdots + \beta_1\cdot 2^1 + \beta_0\cdot 2^0$$

dar. Siehe dazu auch [Wikipedia: Zweierkomplement](https://de.wikipedia.org/wiki/Zweierkomplement).

Wieder als Diagramm (Achtung auf das Vorzeichen "$-$" beim $-2^{n-1}$ Term).

```
    ┌────┬────┬────┬────┬────┬────┬────┐
    │βₙ₋₁│βₙ₋₂│ ⋯  │ ⋯  │ β₂ │ β₁ │ β₀ │
    └────┴────┴────┴────┴────┴────┴────┘
    -2ⁿ⁻¹ 2ⁿ⁻²  ⋯    ⋯    2²   2¹   2⁰    
```

Ein paar Darstellungen:

| Typ     | Zahl           | Bits                         |
| -----:  | ------------:  | ---------------------------: |
|  Int8   |  $(Int8(15))   | $(bitstring(Int8(15)))       |
|  Int8   |  $(Int8(-15))  | $(bitstring(Int8(-15)))      |
|  Int8   |  $(Int8(-1))   | $(bitstring(Int8(-1)))       |
|  Int16  |  $(Int16(15))  | $(bitstring(Int16(15)))      |
|  Int16  |  $(Int16(-15)) | $(bitstring(Int16(-15)))     |
|  Int16  |  $(Int16(-1))  | $(bitstring(Int16(-1)))      |

Hier eine Übersicht welche größtmögliche Zahl bei den
verschiedenen Integer-Typen möglich ist.

| Typ         | Bytes              |  größte Zahl        |
| :---------- | ---------------:   | ------------------: |
| Int8        | $(sizeof(Int8))    | $(typemax(Int8))    |
| Int16       | $(sizeof(Int16))   | $(typemax(Int16))   |
| Int32       | $(sizeof(Int32))   | $(typemax(Int32))   |
| Int64       | $(sizeof(Int64))   | $(typemax(Int64))   |
| Int128      | $(sizeof(Int128))  | $(typemax(Int128))  |
| UInt8       | $(sizeof(UInt8))   | $(typemax(UInt8))   |
| UInt16      | $(sizeof(UInt16))  | $(typemax(UInt16))  |
| UInt32      | $(sizeof(UInt32))  | $(typemax(UInt32))  |
| UInt64      | $(sizeof(UInt64))  | $(typemax(UInt64))  |
| UInt128     | $(sizeof(UInt128)) | $(typemax(UInt128)) |
"""

# ╔═╡ d0dae510-bca4-4fb3-be12-c6835e457799
md"""
Da für (obige) Integer-Typen nur endlich viele Bits zur Verfügung stehen,
lassen sich nur endlich viele Zahlen darstellen.
Damit stellt sich automatisch die Frage, was passiert, wenn man zum maximal
darstellbaren Wert 1 addiert (Integer-Overflow) bzw. vom minimal darstellbaren
Wert 1 subtrahiert (Integer-Underflow).

Julia *garantiert* ein *wraparound* Verhalten:
"""

# ╔═╡ f4b17101-3b9b-438a-9b60-818030f9e404
i8min, i8max, i8one = typemin(Int8), typemax(Int8), one(Int8)

# ╔═╡ 7983e3f0-53eb-4a77-a909-e56df4a8a7b5
i8max + i8one

# ╔═╡ a6fa9ac9-f84b-4812-8159-102b7b1d28e9
i8min - i8one

# ╔═╡ cd1f3797-fe89-485a-b97a-1708be02f42e
md"""
!!! danger "Warnendes Beispiel"
    Die Gleichung

    $$z=-z=|z|$$

    hat in $\mathbb{C}$ genau eine Lösung, nämlich $z=0$.

    Obiges *wraparound* Verhalten sorgt dafür, dass diese Gleichung
    bei Integer-Arithmetik für jeden signed Integer-Typ 
    *eine weitere Lösung besitzt, die negativ ist*, nämlich `typemin()`.
    Hier ein Beispiel für `Int8`:
    ```
      i8min == -i8min == abs(i8min) < 0
      Int8(-128) == -Int8(-128) == abs(Int8(-128)) < 0
    ```
"""

# ╔═╡ b1b3f5a6-8ccf-4aa5-a108-8235cdabd0b3
 i8min == -i8min == abs(i8min) < 0

# ╔═╡ 043d0c7a-c821-49f2-8846-aa054a989a9d
md"""
### Floatingpoint-Typen (Gleitkommazahlen)

Die (`Float32`, `Float64`) kommen ganz ganz ausführlich in der Numerik, inklusive der vielen Bells, Whistles und Fallstricke. Wir verwenden sie hier um Kurs nur phänomenologisch.
"""

# ╔═╡ 0f2e1695-5961-4ea1-8df3-81d9c2f0f03d
1/2, 2.0, √6

# ╔═╡ 632fef90-9bd6-4a56-905a-87c8e688da6a
md"""
### Weitere häufige (Daten-)typen

|  Typ      |  Beispiele         |  Kommentar                               |
| :-------- | :----------------: | :--------------------------------------- |
| `Bool`    | `false`, `true`    | für Logik: falsch/wahr                   |
| `Char`    | `'a'`, `'ß'`       | Buchstabe/Zeichen (Unicode-Codepoint)    |
| `String`  | `"Ein Test."`      | Verkettung von `Char`s.                  |
| `Tuple`   | `(5.5, "Test")`    | unveränderbare Anordnung von Objekten    |
| `Vector`  | `[1,2,3,4]`        | eine veränderbare Liste/Array            |

Bei `Vector` wird (bei Julia) der gemeinsame Typ der Element auch notiert:
`Vector{Int64}` ist eine Liste mit `Int64` Einträgen.

Zu [Unicode](https://home.unicode.org/) gäbe es viel zu sagen. Leider reicht
die Zeit nicht. Das absolute Minimum steht 
z.B. hier [tonsky-Blog: Unicode](https://tonsky.me/blog/unicode/).
"""

# ╔═╡ 81f3305f-07fb-4d5f-bfc6-45de6191b7a6
'a'

# ╔═╡ bd0aad40-25f1-4721-9970-f51be6907551
'ß'

# ╔═╡ b405c82c-680a-4da3-85e4-f81ed84ee35d
'𝄞'

# ╔═╡ babb9f42-b15c-4235-9824-efa72871df1e
md"""
Mit `*` kann man Strings/Chars konkatenieren:
"""

# ╔═╡ 0b974411-472c-4a9f-9a42-8d56e12bc8ff
"Dies " * 'i' * "st" * " ein Test."

# ╔═╡ 6c897424-7098-446e-a3fb-ae431b9f1fc8
"ha "^3   # und mit "*" ist dann auch "^" klar

# ╔═╡ f71bafa4-02f2-467b-9adf-422a548da688
md"""
## Was sind Variablen?

Eine Variable ist eine Zuordnung (auch "Binding" genannt), welche einem (Variablen-)Namen ein Objekt zuordnet. In einer Variable wird also niemals ein Zustand (oder ein Typ) gespeichert, sondern stets nur die Verknüpfung auf ein Objekt. Die Variable *ist* die Verknüpfung von Name und Objekt.

Wann immer Julia ein Objekt benötigt und eine Variable vorfindet, wird die Variable durch genau das Objekt ersetzt, das der Variable (aktuell) zu geordnet ist.
"""

# ╔═╡ c4e0c5d4-bc4a-4009-8458-22c44b8a239d
md"""
### Beispiel (mit unveränderbaren Objekten)
"""

# ╔═╡ a8c7c7b7-361d-42f4-b7d2-d95c021c23c3
let
	a = 3
	b = a
	b = b + 1
	@show a, b
end;

# ╔═╡ b52e876e-9d89-4e17-85e7-7b86c54907fd
md"""
Ausbuchstabiert passiert hier folgendes: 
   1. Zeile: 
      Es wird ein Objekt vom Typ `Int64` mit Wert `3` im Speicher
      angelegt; es wird eine Variable vom Namen `a` angelegt,
      die auf das vorherige Objekt verweist.         
   2. Zeile: Es wird eine Variable `b` angelegt, und da bei der Zuordnung
      kein Objekt, sondern eine Variable (nämlich `a`) übergeben wird, 
      ist `b` jetzt ebenfalls mit der `3` verknüpft.
   3. Zeile: Auf der rechten Seite steht ein "versteckter" Funktionsaufruf,
      nämlich `+(b, 1)`, also die Funktion mit Namen `+` wird auf 
      zwei Objekte angewendet: das, worauf `b` verweist, und `1`.
      Diese Funktion liefert ein neues Objekt zurück, in diesem Fall 
      wieder vom Typ `Int64` mit Wert `4`.
      Die Variable `b` wird neu verknüpft mit diesem Objekt.
      Die alte Verknüpfung von `b` mit `3` ist "verloren", bzw. in 
      diesem konkreten Fall noch über `a` erreichbar.
"""

# ╔═╡ 674e6838-0798-48fd-a490-ee1c72230650
md"""
### Beispiel (mit veränderbaren Objekten)
"""

# ╔═╡ 0d4d8ff1-66cc-449c-bd5a-bba6d6a0ae34
x  = [1, 2, 3]  # Dem Namen "x" wird ein Objekt (hier Liste/Vector) zugewiesen

# ╔═╡ 19e4384b-b0f7-4252-9c95-56f6fe151ee9
md"""
Auf der rechten Seite wird (implizit) eine Funktion aufgerufen, welche die 
drei (unveränderbaren) Objekte `1`, `2` und `3` in einem neuen veränderbaren
Vektor/Array zusammengefasst (wir kommen später ausführlich zur Erzeugung von
Array).
Der Rückgabewert ist dieses veränderbare Array-Objekt.
Die Variable `x` wird mit diesem Objekt verknüpft.
"""

# ╔═╡ 0ad182a7-a2dd-4e95-98db-9817ffbe24fd
y = x

# ╔═╡ 3dbc69a8-c109-4c09-92e4-6d1da3009c5d
md"""
Es wird eine Variable mit Namen `y` angelegt und sie zeigt
genau darauf, worauf `x` zeigt:
"""

# ╔═╡ da2f9be2-59e3-44a1-9c53-08bccd3e4942
md"""
Wird nun das Objekt, auf welches `y` verweist verändert, so wird genau das gleiche Objekt verändert, worauf `x` verweist:
"""

# ╔═╡ 36af19c8-2316-420e-a816-339744f8f68c
y[2] = 0;

# ╔═╡ a51e5e6d-1da6-4168-a5bc-128afb0b52f8
md"""
Hier wird eine Funktion aufgerufen (`setindex!`), welche den Wert `10` an
die zweite Stelle des Arrays schreibt, auf das `y` verweist.
"""

# ╔═╡ fe1d0b60-0a98-4bed-bc5c-cb5da5827961
x, y

# ╔═╡ d2aa5bbc-1cf2-4a10-b889-637281c9c033
md"""
Auch Funktionen können (veränderbare) Objekte verändern. In Julia gibt es die
Konvention, dass Funktionen, die ihr (typischerweise) erstes Argument verändern,
im Namen am Ende ein Ausrufezeichen "!" haben. So hängt z.B. `push!` weitere
Objekte an eine List an.
"""

# ╔═╡ 4c4f1af4-eaaa-45e4-911e-f5515c1784b1
let
	liste = [1,2,3]
	push!(liste, 12)
	@show liste
end;

# ╔═╡ 7c011d80-700d-407e-9939-82322ce3901b
md"""
## Scopes

Ein Scope/Gültigkeitsbereich einer Variable ist der Bereich im Code in
dem die Variable zugänglich/verfügbar ist.

Es gibt einige [Konstrukte](https://docs.julialang.org/en/v1/manual/variables-and-scoping/#scope-of-variables), die wir im Laufe des Kurses kennenlernen
werden, die dafür sorgen, dass Variablen "abgekapselt" sind und nur innerhalb
dieser Strukturen leben. Dies ist ein Vorteil.
"""

# ╔═╡ dbf4396e-cecc-405c-ac1c-bd21097f91bf
md"""
### `let`-Block
"""

# ╔═╡ aad00c4e-5fbb-4614-8427-6078572ea09a
let  # erzeugt einen neuen Scope für Variablen
	g = "Test! "
	f = g*g
end

# ╔═╡ e7c355bf-5264-430b-a374-ec30f5332254
md"""
`f` und `g` sind außerhalb ihres `let`-Blockes/Scope nicht verfügbar.
"""

# ╔═╡ 394ae206-1729-419c-96b5-0e674bd07464
@isdefined(g), @isdefined(f)

# ╔═╡ 1f057a20-9d6a-457e-a40d-38b5c2a5fa05
md"""
!!! danger "`begin`-Block"
    Ganz anders ist ein `begin`-Block. Er erzeugt **keinen** neuen Scope. 
    Er gruppiert nur mehrere Statements zusammen und liefert als
    Ergebnis das Ergebnis des letzten Statements:
"""

# ╔═╡ 4c13ea39-d918-4032-abee-b0a0edbb9a64
begin
	gibt_es_auch_außerhalb = "Nur ein Test."
	length(gibt_es_auch_außerhalb)
end

# ╔═╡ da8a9c18-c98a-430a-8d28-000d6d0abdc6
@isdefined(gibt_es_auch_außerhalb)

# ╔═╡ a77866af-7cc0-4de3-908a-d9b957eb9765
md"""
### Funktionen

Eine sehr hilfreiche Möglichkeit einen neuen Scope zu haben, ist
eine Funktion (mit Eingaben und Ausgaben) zu definieren (wir werden
später ausführlicher über Funktionen sprechen):
"""

# ╔═╡ 50a32f90-e81d-4ff1-8413-fc4448d3158c
"""
Eine neue Funktion mit Namen `test_funktion` und zwei Eingaben `a` und `b`.
Das was hinter `return` steht wird die Ausgabe.
"""
function test_funktion(a, b)
	sq = a^2  # lokaler Scope; sq nur innerhalb der Funktion verfügbar
	return b * sq
end

# ╔═╡ 82964a7e-455e-4132-870c-8aecfa592e47
test_funktion(2,3)

# ╔═╡ 5cf92602-c128-41ef-a026-82f37e1c6c30
test_funktion(" ein Test", "Dies ist")

# ╔═╡ d13c3b0e-5130-493c-a947-f4a0b0170153
md"""
Wenn Funktion nur aus einem Ausdruck bestehen, gibt es auch eine
kürzere Möglichkeit, solche Funktionen zu definieren:
"""

# ╔═╡ c0ca3aa4-bf87-4251-a630-a80808c87d3c
test_function2(a,b) = b * a^2

# ╔═╡ 620d8505-5f96-4944-bb5d-dde0bbf69b5d
test_function2(" ein Test", "Dies ist")

# ╔═╡ fdac4041-8fed-4910-8a57-812efd52db0b
"""liefere Infos (Typ, Anzahl der Bytes, ggf. Adresse) für ein Objekt."""
function liefere_objekt_infos(obj)
	obj_type = typeof(obj)	
	if ismutable(obj)
		return @sprintf("Im Speicher %p (%i Bytes) Typ %s: %s",
			pointer_from_objref(obj), sizeof(obj), obj_type, obj)
	else
		return @sprintf("(%i Bytes) Typ %s: %s", sizeof(obj), obj_type, obj)
	end
end;

# ╔═╡ 65642127-f9f1-472e-bb6b-3ca3b2395c94
md"""
Mit einer kleinen Hilfsfunktion `liefere_object_infos` (wir sprechen später darüber, wie man Funktionen erstellt) sieht es so aus:

|  Code                           | Ausgabe                                 |
| :------------------------------ | :------------------------------------   |
| `liefere_objekt_infos(5)`       | $(liefere_objekt_infos(5))              |
| `liefere_objekt_infos("bla")`   | $(liefere_objekt_infos("bla"))          |
| `liefere_objekt_infos(true)`    | $(liefere_objekt_infos(true))           |
| `liefere_objekt_infos([1,2,3])` | $(liefere_objekt_infos([1,2,3]))        |
| `liefere_objekt_infos((1,2,3))` | $(liefere_objekt_infos((1,2,3)))        |
| `liefere_objekt_infos(sin)`     | $(liefere_objekt_infos(sin))            |
| `liefere_objekt_infos(+)`       | $(liefere_objekt_infos(+))              |
"""

# ╔═╡ d24e5e5d-2c7d-4d82-8fee-3285a0bed4d0
liefere_objekt_infos(x)

# ╔═╡ 3e2bfe26-84bc-4e7a-902f-fcbd1a61730d
liefere_objekt_infos(y)

# ╔═╡ fed3ebef-a75c-4322-9d3d-31a72e36889f
begin
	# Verwendete Bilder
	Bilder = Dict()
	Bilder["x_ref"] = PlutoUI.Resource(
	"""data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHN2ZyBQVUJM
SUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3Mv
U1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KPHN2ZyB2ZXJzaW9uPSIxLjIiIHdpZHRoPSIyMjQuMDFt
bSIgaGVpZ2h0PSI5Ni4wMW1tIiB2aWV3Qm94PSIyOTAwIDM1OTkgMjI0MDEgOTYwMSIgcHJlc2Vy
dmVBc3BlY3RSYXRpbz0ieE1pZFlNaWQiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLXdpZHRo
PSIyOC4yMjIiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9y
Zy8yMDAwL3N2ZyIgeG1sbnM6b29vPSJodHRwOi8veG1sLm9wZW5vZmZpY2Uub3JnL3N2Zy9leHBv
cnQiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4bWxuczpwcmVz
ZW50YXRpb249Imh0dHA6Ly9zdW4uY29tL3htbG5zL3N0YXJvZmZpY2UvcHJlc2VudGF0aW9uIiB4
bWxuczpzbWlsPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1NNSUwyMC8iIHhtbG5zOmFuaW09InVy
bjpvYXNpczpuYW1lczp0YzpvcGVuZG9jdW1lbnQ6eG1sbnM6YW5pbWF0aW9uOjEuMCIgeG1sOnNw
YWNlPSJwcmVzZXJ2ZSI+CiA8ZGVmcyBjbGFzcz0iQ2xpcFBhdGhHcm91cCI+CiAgPGNsaXBQYXRo
IGlkPSJwcmVzZW50YXRpb25fY2xpcF9wYXRoIiBjbGlwUGF0aFVuaXRzPSJ1c2VyU3BhY2VPblVz
ZSI+CiAgIDxyZWN0IHg9IjI5MDAiIHk9IjM1OTkiIHdpZHRoPSIyMjQwMSIgaGVpZ2h0PSI5NjAx
Ii8+CiAgPC9jbGlwUGF0aD4KIDwvZGVmcz4KIDxkZWZzPgogIDxmb250IGlkPSJFbWJlZGRlZEZv
bnRfMSIgaG9yaXotYWR2LXg9IjIwNDgiPgogICA8Zm9udC1mYWNlIGZvbnQtZmFtaWx5PSJEZWph
VnUgU2FucyBlbWJlZGRlZCIgdW5pdHMtcGVyLWVtPSIyMDQ4IiBmb250LXdlaWdodD0ibm9ybWFs
IiBmb250LXN0eWxlPSJub3JtYWwiIGFzY2VudD0iMTg3OSIgZGVzY2VudD0iNDc2Ii8+CiAgIDxt
aXNzaW5nLWdseXBoIGhvcml6LWFkdi14PSIyMDQ4IiBkPSJNIDAsMCBMIDIwNDcsMCAyMDQ3LDIw
NDcgMCwyMDQ3IDAsMCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJ4IiBob3Jpei1hZHYteD0iMTEx
MiIgZD0iTSAxMTI0LDExMjAgTCA3MTksNTc1IDExNDUsMCA5MjgsMCA2MDIsNDQwIDI3NiwwIDU5
LDAgNDk0LDU4NiA5NiwxMTIwIDMxMywxMTIwIDYxMCw3MjEgOTA3LDExMjAgMTEyNCwxMTIwIFoi
Lz4KICAgPGdseXBoIHVuaWNvZGU9InQiIGhvcml6LWFkdi14PSI3MTUiIGQ9Ik0gMzc1LDE0Mzgg
TCAzNzUsMTEyMCA3NTQsMTEyMCA3NTQsOTc3IDM3NSw5NzcgMzc1LDM2OSBDIDM3NSwyNzggMzg4
LDIxOSA0MTMsMTkzIDQzOCwxNjcgNDg4LDE1NCA1NjUsMTU0IEwgNzU0LDE1NCA3NTQsMCA1NjUs
MCBDIDQyMywwIDMyNSwyNyAyNzEsODAgMjE3LDEzMyAxOTAsMjI5IDE5MCwzNjkgTCAxOTAsOTc3
IDU1LDk3NyA1NSwxMTIwIDE5MCwxMTIwIDE5MCwxNDM4IDM3NSwxNDM4IFoiLz4KICAgPGdseXBo
IHVuaWNvZGU9InMiIGhvcml6LWFkdi14PSI4NzQiIGQ9Ik0gOTA3LDEwODcgTCA5MDcsOTEzIEMg
ODU1LDk0MCA4MDEsOTYwIDc0NSw5NzMgNjg5LDk4NiA2MzEsOTkzIDU3MSw5OTMgNDgwLDk5MyA0
MTEsOTc5IDM2Niw5NTEgMzIwLDkyMyAyOTcsODgxIDI5Nyw4MjUgMjk3LDc4MiAzMTMsNzQ5IDM0
Niw3MjUgMzc5LDcwMCA0NDQsNjc3IDU0Myw2NTUgTCA2MDYsNjQxIEMgNzM3LDYxMyA4MzAsNTc0
IDg4NSw1MjMgOTQwLDQ3MiA5NjcsNDAwIDk2NywzMDkgOTY3LDIwNSA5MjYsMTIzIDg0NCw2MiA3
NjEsMSA2NDgsLTI5IDUwNCwtMjkgNDQ0LC0yOSAzODIsLTIzIDMxNywtMTIgMjUyLDAgMTgzLDE4
IDExMSw0MSBMIDExMSwyMzEgQyAxNzksMTk2IDI0NiwxNjkgMzEyLDE1MiAzNzgsMTM0IDQ0Mywx
MjUgNTA4LDEyNSA1OTUsMTI1IDY2MSwxNDAgNzA4LDE3MCA3NTUsMTk5IDc3OCwyNDEgNzc4LDI5
NSA3NzgsMzQ1IDc2MSwzODMgNzI4LDQxMCA2OTQsNDM3IDYyMCw0NjIgNTA2LDQ4NyBMIDQ0Miw1
MDIgQyAzMjgsNTI2IDI0Niw1NjMgMTk1LDYxMyAxNDQsNjYyIDExOSw3MzAgMTE5LDgxNyAxMTks
OTIyIDE1NiwxMDA0IDIzMSwxMDYxIDMwNiwxMTE4IDQxMiwxMTQ3IDU0OSwxMTQ3IDYxNywxMTQ3
IDY4MSwxMTQyIDc0MSwxMTMyIDgwMSwxMTIyIDg1NiwxMTA3IDkwNywxMDg3IFoiLz4KICAgPGds
eXBoIHVuaWNvZGU9InIiIGhvcml6LWFkdi14PSI2NjMiIGQ9Ik0gODQyLDk0OCBDIDgyMSw5NjAg
Nzk5LDk2OSA3NzUsOTc1IDc1MCw5ODAgNzIzLDk4MyA2OTQsOTgzIDU5MCw5ODMgNTEwLDk0OSA0
NTUsODgyIDM5OSw4MTQgMzcxLDcxNyAzNzEsNTkwIEwgMzcxLDAgMTg2LDAgMTg2LDExMjAgMzcx
LDExMjAgMzcxLDk0NiBDIDQxMCwxMDE0IDQ2MCwxMDY1IDUyMiwxMDk4IDU4NCwxMTMxIDY1OSwx
MTQ3IDc0OCwxMTQ3IDc2MSwxMTQ3IDc3NSwxMTQ2IDc5MCwxMTQ1IDgwNSwxMTQzIDgyMiwxMTQw
IDg0MSwxMTM3IEwgODQyLDk0OCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJwIiBob3Jpei1hZHYt
eD0iMTAwNyIgZD0iTSAzNzEsMTY4IEwgMzcxLC00MjYgMTg2LC00MjYgMTg2LDExMjAgMzcxLDEx
MjAgMzcxLDk1MCBDIDQxMCwxMDE3IDQ1OSwxMDY2IDUxOCwxMDk5IDU3NywxMTMxIDY0NywxMTQ3
IDcyOSwxMTQ3IDg2NSwxMTQ3IDk3NiwxMDkzIDEwNjEsOTg1IDExNDYsODc3IDExODgsNzM1IDEx
ODgsNTU5IDExODgsMzgzIDExNDYsMjQxIDEwNjEsMTMzIDk3NiwyNSA4NjUsLTI5IDcyOSwtMjkg
NjQ3LC0yOSA1NzcsLTEzIDUxOCwyMCA0NTksNTIgNDEwLDEwMSAzNzEsMTY4IFogTSA5OTcsNTU5
IEMgOTk3LDY5NCA5NjksODAxIDkxNCw4NzggODU4LDk1NSA3ODEsOTkzIDY4NCw5OTMgNTg3LDk5
MyA1MTAsOTU1IDQ1NSw4NzggMzk5LDgwMSAzNzEsNjk0IDM3MSw1NTkgMzcxLDQyNCAzOTksMzE4
IDQ1NSwyNDEgNTEwLDE2NCA1ODcsMTI1IDY4NCwxMjUgNzgxLDEyNSA4NTgsMTY0IDkxNCwyNDEg
OTY5LDMxOCA5OTcsNDI0IDk5Nyw1NTkgWiIvPgogICA8Z2x5cGggdW5pY29kZT0ibiIgaG9yaXot
YWR2LXg9Ijk1NCIgZD0iTSAxMTI0LDY3NiBMIDExMjQsMCA5NDAsMCA5NDAsNjcwIEMgOTQwLDc3
NiA5MTksODU1IDg3OCw5MDggODM3LDk2MSA3NzUsOTg3IDY5Miw5ODcgNTkzLDk4NyA1MTQsOTU1
IDQ1Nyw4OTIgNDAwLDgyOSAzNzEsNzQyIDM3MSw2MzMgTCAzNzEsMCAxODYsMCAxODYsMTEyMCAz
NzEsMTEyMCAzNzEsOTQ2IEMgNDE1LDEwMTMgNDY3LDEwNjQgNTI3LDEwOTcgNTg2LDExMzAgNjU1
LDExNDcgNzMzLDExNDcgODYyLDExNDcgOTU5LDExMDcgMTAyNSwxMDI4IDEwOTEsOTQ4IDExMjQs
ODMxIDExMjQsNjc2IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9Im0iIGhvcml6LWFkdi14PSIxNjQy
IiBkPSJNIDEwNjUsOTA1IEMgMTExMSw5ODggMTE2NiwxMDQ5IDEyMzAsMTA4OCAxMjk0LDExMjcg
MTM2OSwxMTQ3IDE0NTYsMTE0NyAxNTczLDExNDcgMTY2MywxMTA2IDE3MjYsMTAyNSAxNzg5LDk0
MyAxODIxLDgyNyAxODIxLDY3NiBMIDE4MjEsMCAxNjM2LDAgMTYzNiw2NzAgQyAxNjM2LDc3NyAx
NjE3LDg1NyAxNTc5LDkwOSAxNTQxLDk2MSAxNDgzLDk4NyAxNDA1LDk4NyAxMzEwLDk4NyAxMjM0
LDk1NSAxMTc5LDg5MiAxMTI0LDgyOSAxMDk2LDc0MiAxMDk2LDYzMyBMIDEwOTYsMCA5MTEsMCA5
MTEsNjcwIEMgOTExLDc3OCA4OTIsODU4IDg1NCw5MTAgODE2LDk2MSA3NTcsOTg3IDY3OCw5ODcg
NTg0LDk4NyA1MDksOTU1IDQ1NCw4OTIgMzk5LDgyOCAzNzEsNzQyIDM3MSw2MzMgTCAzNzEsMCAx
ODYsMCAxODYsMTEyMCAzNzEsMTEyMCAzNzEsOTQ2IEMgNDEzLDEwMTUgNDYzLDEwNjUgNTIyLDEw
OTggNTgxLDExMzEgNjUwLDExNDcgNzMxLDExNDcgODEyLDExNDcgODgyLDExMjYgOTM5LDEwODUg
OTk2LDEwNDQgMTAzOCw5ODQgMTA2NSw5MDUgWiIvPgogICA8Z2x5cGggdW5pY29kZT0ibCIgaG9y
aXotYWR2LXg9IjIxMyIgZD0iTSAxOTMsMTU1NiBMIDM3NywxNTU2IDM3NywwIDE5MywwIDE5Mywx
NTU2IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9ImkiIGhvcml6LWFkdi14PSIyMTMiIGQ9Ik0gMTkz
LDExMjAgTCAzNzcsMTEyMCAzNzcsMCAxOTMsMCAxOTMsMTEyMCBaIE0gMTkzLDE1NTYgTCAzNzcs
MTU1NiAzNzcsMTMyMyAxOTMsMTMyMyAxOTMsMTU1NiBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJo
IiBob3Jpei1hZHYteD0iOTU0IiBkPSJNIDExMjQsNjc2IEwgMTEyNCwwIDk0MCwwIDk0MCw2NzAg
QyA5NDAsNzc2IDkxOSw4NTUgODc4LDkwOCA4MzcsOTYxIDc3NSw5ODcgNjkyLDk4NyA1OTMsOTg3
IDUxNCw5NTUgNDU3LDg5MiA0MDAsODI5IDM3MSw3NDIgMzcxLDYzMyBMIDM3MSwwIDE4NiwwIDE4
NiwxNTU2IDM3MSwxNTU2IDM3MSw5NDYgQyA0MTUsMTAxMyA0NjcsMTA2NCA1MjcsMTA5NyA1ODYs
MTEzMCA2NTUsMTE0NyA3MzMsMTE0NyA4NjIsMTE0NyA5NTksMTEwNyAxMDI1LDEwMjggMTA5MSw5
NDggMTEyNCw4MzEgMTEyNCw2NzYgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iZSIgaG9yaXotYWR2
LXg9IjEwNTkiIGQ9Ik0gMTE1MSw2MDYgTCAxMTUxLDUxNiAzMDUsNTE2IEMgMzEzLDM4OSAzNTEs
MjkzIDQyMCwyMjcgNDg4LDE2MCA1ODMsMTI3IDcwNSwxMjcgNzc2LDEyNyA4NDQsMTM2IDkxMSwx
NTMgOTc3LDE3MCAxMDQzLDE5NiAxMTA4LDIzMSBMIDExMDgsNTcgQyAxMDQyLDI5IDk3NCw4IDkw
NSwtNyA4MzYsLTIyIDc2NSwtMjkgNjk0LC0yOSA1MTUsLTI5IDM3NCwyMyAyNzAsMTI3IDE2NSwy
MzEgMTEzLDM3MiAxMTMsNTQ5IDExMyw3MzIgMTYzLDg3OCAyNjIsOTg2IDM2MSwxMDkzIDQ5NCwx
MTQ3IDY2MiwxMTQ3IDgxMywxMTQ3IDkzMiwxMDk5IDEwMjAsMTAwMiAxMTA3LDkwNSAxMTUxLDc3
MyAxMTUxLDYwNiBaIE0gOTY3LDY1OSBDIDk2Niw3NjAgOTM4LDg0MSA4ODMsOTAxIDgyOCw5NjEg
NzU1LDk5MSA2NjQsOTkxIDU2MSw5OTEgNDc5LDk2MiA0MTgsOTA0IDM1Niw4NDYgMzIwLDc2NCAz
MTEsNjU5IEwgOTY3LDY1OSBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJjIiBob3Jpei1hZHYteD0i
OTAwIiBkPSJNIDk5OSwxMDc3IEwgOTk5LDkwNSBDIDk0Nyw5MzQgODk1LDk1NSA4NDMsOTcwIDc5
MCw5ODQgNzM3LDk5MSA2ODQsOTkxIDU2NSw5OTEgNDcyLDk1MyA0MDYsODc4IDM0MCw4MDIgMzA3
LDY5NiAzMDcsNTU5IDMwNyw0MjIgMzQwLDMxNiA0MDYsMjQxIDQ3MiwxNjUgNTY1LDEyNyA2ODQs
MTI3IDczNywxMjcgNzkwLDEzNCA4NDMsMTQ5IDg5NSwxNjMgOTQ3LDE4NCA5OTksMjEzIEwgOTk5
LDQzIEMgOTQ4LDE5IDg5NSwxIDg0MCwtMTEgNzg1LC0yMyA3MjYsLTI5IDY2NCwtMjkgNDk1LC0y
OSAzNjEsMjQgMjYyLDEzMCAxNjMsMjM2IDExMywzNzkgMTEzLDU1OSAxMTMsNzQyIDE2Myw4ODUg
MjY0LDk5MCAzNjQsMTA5NSA1MDEsMTE0NyA2NzYsMTE0NyA3MzMsMTE0NyA3ODgsMTE0MSA4NDIs
MTEzMCA4OTYsMTExOCA5NDgsMTEwMCA5OTksMTA3NyBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJi
IiBob3Jpei1hZHYteD0iMTAwNyIgZD0iTSA5OTcsNTU5IEMgOTk3LDY5NCA5NjksODAxIDkxNCw4
NzggODU4LDk1NSA3ODEsOTkzIDY4NCw5OTMgNTg3LDk5MyA1MTAsOTU1IDQ1NSw4NzggMzk5LDgw
MSAzNzEsNjk0IDM3MSw1NTkgMzcxLDQyNCAzOTksMzE4IDQ1NSwyNDEgNTEwLDE2NCA1ODcsMTI1
IDY4NCwxMjUgNzgxLDEyNSA4NTgsMTY0IDkxNCwyNDEgOTY5LDMxOCA5OTcsNDI0IDk5Nyw1NTkg
WiBNIDM3MSw5NTAgQyA0MTAsMTAxNyA0NTksMTA2NiA1MTgsMTA5OSA1NzcsMTEzMSA2NDcsMTE0
NyA3MjksMTE0NyA4NjUsMTE0NyA5NzYsMTA5MyAxMDYxLDk4NSAxMTQ2LDg3NyAxMTg4LDczNSAx
MTg4LDU1OSAxMTg4LDM4MyAxMTQ2LDI0MSAxMDYxLDEzMyA5NzYsMjUgODY1LC0yOSA3MjksLTI5
IDY0NywtMjkgNTc3LC0xMyA1MTgsMjAgNDU5LDUyIDQxMCwxMDEgMzcxLDE2OCBMIDM3MSwwIDE4
NiwwIDE4NiwxNTU2IDM3MSwxNTU2IDM3MSw5NTAgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iYSIg
aG9yaXotYWR2LXg9Ijk4MCIgZD0iTSA3MDIsNTYzIEMgNTUzLDU2MyA0NTAsNTQ2IDM5Myw1MTIg
MzM2LDQ3OCAzMDcsNDIwIDMwNywzMzggMzA3LDI3MyAzMjksMjIxIDM3MiwxODMgNDE1LDE0NCA0
NzMsMTI1IDU0NywxMjUgNjQ5LDEyNSA3MzEsMTYxIDc5MywyMzQgODU0LDMwNiA4ODUsNDAyIDg4
NSw1MjIgTCA4ODUsNTYzIDcwMiw1NjMgWiBNIDEwNjksNjM5IEwgMTA2OSwwIDg4NSwwIDg4NSwx
NzAgQyA4NDMsMTAyIDc5MSw1MiA3MjgsMjAgNjY1LC0xMyA1ODksLTI5IDQ5OCwtMjkgMzgzLC0y
OSAyOTIsMyAyMjUsNjggMTU3LDEzMiAxMjMsMjE4IDEyMywzMjYgMTIzLDQ1MiAxNjUsNTQ3IDI1
MCw2MTEgMzM0LDY3NSA0NjAsNzA3IDYyNyw3MDcgTCA4ODUsNzA3IDg4NSw3MjUgQyA4ODUsODEw
IDg1Nyw4NzUgODAyLDkyMiA3NDYsOTY4IDY2OCw5OTEgNTY3LDk5MSA1MDMsOTkxIDQ0MSw5ODMg
MzgwLDk2OCAzMTksOTUzIDI2MSw5MzAgMjA1LDg5OSBMIDIwNSwxMDY5IEMgMjcyLDEwOTUgMzM4
LDExMTUgNDAxLDExMjggNDY0LDExNDEgNTI2LDExNDcgNTg2LDExNDcgNzQ4LDExNDcgODY5LDEx
MDUgOTQ5LDEwMjEgMTAyOSw5MzcgMTA2OSw4MTAgMTA2OSw2MzkgWiIvPgogICA8Z2x5cGggdW5p
Y29kZT0iViIgaG9yaXotYWR2LXg9IjE0MDMiIGQ9Ik0gNTg2LDAgTCAxNiwxNDkzIDIyNywxNDkz
IDcwMCwyMzYgMTE3NCwxNDkzIDEzODQsMTQ5MyA4MTUsMCA1ODYsMCBaIi8+CiAgIDxnbHlwaCB1
bmljb2RlPSJTIiBob3Jpei1hZHYteD0iMTA2MCIgZD0iTSAxMDk2LDE0NDQgTCAxMDk2LDEyNDcg
QyAxMDE5LDEyODQgOTQ3LDEzMTEgODc5LDEzMjkgODExLDEzNDcgNzQ1LDEzNTYgNjgyLDEzNTYg
NTcyLDEzNTYgNDg3LDEzMzUgNDI4LDEyOTIgMzY4LDEyNDkgMzM4LDExODkgMzM4LDExMTAgMzM4
LDEwNDQgMzU4LDk5NCAzOTgsOTYxIDQzNyw5MjcgNTEyLDkwMCA2MjMsODc5IEwgNzQ1LDg1NCBD
IDg5Niw4MjUgMTAwNyw3NzUgMTA3OSw3MDMgMTE1MCw2MzAgMTE4Niw1MzMgMTE4Niw0MTIgMTE4
NiwyNjcgMTEzOCwxNTggMTA0MSw4MyA5NDQsOCA4MDEsLTI5IDYxNCwtMjkgNTQzLC0yOSA0Njgs
LTIxIDM4OSwtNSAzMDksMTEgMjI2LDM1IDE0MSw2NiBMIDE0MSwyNzQgQyAyMjMsMjI4IDMwMywx
OTMgMzgyLDE3MCA0NjEsMTQ3IDUzOCwxMzUgNjE0LDEzNSA3MjksMTM1IDgxOCwxNTggODgxLDIw
MyA5NDQsMjQ4IDk3NSwzMTMgOTc1LDM5NyA5NzUsNDcwIDk1Myw1MjggOTA4LDU2OSA4NjMsNjEw
IDc4OSw2NDEgNjg2LDY2MiBMIDU2Myw2ODYgQyA0MTIsNzE2IDMwMyw3NjMgMjM2LDgyNyAxNjks
ODkxIDEzNSw5ODAgMTM1LDEwOTQgMTM1LDEyMjYgMTgyLDEzMzAgMjc1LDE0MDYgMzY4LDE0ODIg
NDk2LDE1MjAgNjU5LDE1MjAgNzI5LDE1MjAgODAwLDE1MTQgODczLDE1MDEgOTQ2LDE0ODggMTAy
MCwxNDY5IDEwOTYsMTQ0NCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJMIiBob3Jpei1hZHYteD0i
OTU0IiBkPSJNIDIwMSwxNDkzIEwgNDAzLDE0OTMgNDAzLDE3MCAxMTMwLDE3MCAxMTMwLDAgMjAx
LDAgMjAxLDE0OTMgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iOiIgaG9yaXotYWR2LXg9IjIxMyIg
ZD0iTSAyNDAsMjU0IEwgNDUxLDI1NCA0NTEsMCAyNDAsMCAyNDAsMjU0IFogTSAyNDAsMTA1OSBM
IDQ1MSwxMDU5IDQ1MSw4MDUgMjQwLDgwNSAyNDAsMTA1OSBaIi8+CiAgIDxnbHlwaCB1bmljb2Rl
PSIzIiBob3Jpei1hZHYteD0iMTAwNyIgZD0iTSA4MzEsODA1IEMgOTI4LDc4NCAxMDAzLDc0MSAx
MDU4LDY3NiAxMTEyLDYxMSAxMTM5LDUzMCAxMTM5LDQzNCAxMTM5LDI4NyAxMDg4LDE3MyA5ODcs
OTIgODg2LDExIDc0MiwtMjkgNTU1LC0yOSA0OTIsLTI5IDQyOCwtMjMgMzYyLC0xMSAyOTUsMiAy
MjcsMjAgMTU2LDQ1IEwgMTU2LDI0MCBDIDIxMiwyMDcgMjczLDE4MyAzNDAsMTY2IDQwNywxNDkg
NDc2LDE0MSA1NDksMTQxIDY3NiwxNDEgNzcyLDE2NiA4MzksMjE2IDkwNSwyNjYgOTM4LDMzOSA5
MzgsNDM0IDkzOCw1MjIgOTA3LDU5MSA4NDYsNjQxIDc4NCw2OTAgNjk4LDcxNSA1ODgsNzE1IEwg
NDE0LDcxNSA0MTQsODgxIDU5Niw4ODEgQyA2OTUsODgxIDc3MSw5MDEgODI0LDk0MSA4NzcsOTgw
IDkwMywxMDM3IDkwMywxMTEyIDkwMywxMTg5IDg3NiwxMjQ4IDgyMiwxMjg5IDc2NywxMzMwIDY4
OSwxMzUwIDU4OCwxMzUwIDUzMywxMzUwIDQ3MywxMzQ0IDQxMCwxMzMyIDM0NywxMzIwIDI3Nywx
MzAxIDIwMSwxMjc2IEwgMjAxLDE0NTYgQyAyNzgsMTQ3NyAzNTAsMTQ5MyA0MTcsMTUwNCA0ODQs
MTUxNSA1NDcsMTUyMCA2MDYsMTUyMCA3NTksMTUyMCA4ODEsMTQ4NSA5NzAsMTQxNiAxMDU5LDEz
NDYgMTEwNCwxMjUyIDExMDQsMTEzMyAxMTA0LDEwNTAgMTA4MCw5ODEgMTAzMyw5MjQgOTg2LDg2
NyA5MTgsODI3IDgzMSw4MDUgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iMiIgaG9yaXotYWR2LXg9
Ijk4MCIgZD0iTSAzOTMsMTcwIEwgMTA5OCwxNzAgMTA5OCwwIDE1MCwwIDE1MCwxNzAgQyAyMjcs
MjQ5IDMzMSwzNTYgNDY0LDQ5MCA1OTYsNjIzIDY3OSw3MDkgNzEzLDc0OCA3NzgsODIxIDgyMyw4
ODIgODQ5LDkzMyA4NzQsOTgzIDg4NywxMDMyIDg4NywxMDgxIDg4NywxMTYwIDg1OSwxMjI1IDgw
NCwxMjc1IDc0OCwxMzI1IDY3NSwxMzUwIDU4NiwxMzUwIDUyMywxMzUwIDQ1NiwxMzM5IDM4Niwx
MzE3IDMxNSwxMjk1IDI0MCwxMjYyIDE2MCwxMjE3IEwgMTYwLDE0MjEgQyAyNDEsMTQ1NCAzMTcs
MTQ3OCAzODgsMTQ5NSA0NTksMTUxMiA1MjMsMTUyMCA1ODIsMTUyMCA3MzcsMTUyMCA4NjAsMTQ4
MSA5NTIsMTQwNCAxMDQ0LDEzMjcgMTA5MCwxMjIzIDEwOTAsMTA5NCAxMDkwLDEwMzMgMTA3OSw5
NzUgMTA1Niw5MjAgMTAzMyw4NjUgOTkxLDgwMCA5MzAsNzI1IDkxMyw3MDYgODYwLDY1MCA3NzEs
NTU4IDY4Miw0NjUgNTU2LDMzNiAzOTMsMTcwIFoiLz4KICAgPGdseXBoIHVuaWNvZGU9IjEiIGhv
cml6LWFkdi14PSI5MDAiIGQ9Ik0gMjU0LDE3MCBMIDU4NCwxNzAgNTg0LDEzMDkgMjI1LDEyMzcg
MjI1LDE0MjEgNTgyLDE0OTMgNzg0LDE0OTMgNzg0LDE3MCAxMTE0LDE3MCAxMTE0LDAgMjU0LDAg
MjU0LDE3MCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSIsIiBob3Jpei1hZHYteD0iMzE5IiBkPSJN
IDI0MCwyNTQgTCA0NTEsMjU0IDQ1MSw4MiAyODcsLTIzOCAxNTgsLTIzOCAyNDAsODIgMjQwLDI1
NCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSIpIiBob3Jpei1hZHYteD0iNDc3IiBkPSJNIDE2NCwx
NTU0IEwgMzI0LDE1NTQgQyA0MjQsMTM5NyA0OTksMTI0MyA1NDksMTA5MiA1OTgsOTQxIDYyMyw3
OTIgNjIzLDY0MyA2MjMsNDk0IDU5OCwzNDMgNTQ5LDE5MiA0OTksNDEgNDI0LC0xMTMgMzI0LC0y
NzAgTCAxNjQsLTI3MCBDIDI1MywtMTE3IDMxOSwzNSAzNjMsMTg2IDQwNiwzMzcgNDI4LDQ4OSA0
MjgsNjQzIDQyOCw3OTcgNDA2LDk0OSAzNjMsMTA5OSAzMTksMTI0OSAyNTMsMTQwMSAxNjQsMTU1
NCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSIoIiBob3Jpei1hZHYteD0iNDc3IiBkPSJNIDYzNSwx
NTU0IEMgNTQ2LDE0MDEgNDc5LDEyNDkgNDM2LDEwOTkgMzkzLDk0OSAzNzEsNzk3IDM3MSw2NDMg
MzcxLDQ4OSAzOTMsMzM3IDQzNywxODYgNDgwLDM1IDU0NiwtMTE3IDYzNSwtMjcwIEwgNDc1LC0y
NzAgQyAzNzUsLTExMyAzMDAsNDEgMjUxLDE5MiAyMDEsMzQzIDE3Niw0OTQgMTc2LDY0MyAxNzYs
NzkyIDIwMSw5NDEgMjUwLDEwOTIgMjk5LDEyNDMgMzc0LDEzOTcgNDc1LDE1NTQgTCA2MzUsMTU1
NCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSIgIiBob3Jpei1hZHYteD0iNjM1Ii8+CiAgPC9mb250
PgogPC9kZWZzPgogPGRlZnMgY2xhc3M9IlRleHRTaGFwZUluZGV4Ij4KICA8ZyBvb286c2xpZGU9
ImlkMSIgb29vOmlkLWxpc3Q9ImlkMyBpZDQgaWQ1IGlkNiBpZDciLz4KIDwvZGVmcz4KIDxkZWZz
IGNsYXNzPSJFbWJlZGRlZEJ1bGxldENoYXJzIj4KICA8ZyBpZD0iYnVsbGV0LWNoYXItdGVtcGxh
dGUoNTczNTYpIiB0cmFuc2Zvcm09InNjYWxlKDAuMDAwNDg4MjgxMjUsLTAuMDAwNDg4MjgxMjUp
Ij4KICAgPHBhdGggZD0iTSA1ODAsMTE0MSBMIDExNjMsNTcxIDU4MCwwIC00LDU3MSA1ODAsMTE0
MSBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxsZXQtY2hhci10ZW1wbGF0ZSg1NzM1NCkiIHRyYW5z
Zm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBkPSJN
IDgsMTEyOCBMIDExMzcsMTEyOCAxMTM3LDAgOCwwIDgsMTEyOCBaIi8+CiAgPC9nPgogIDxnIGlk
PSJidWxsZXQtY2hhci10ZW1wbGF0ZSgxMDE0NikiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgy
ODEyNSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBkPSJNIDE3NCwwIEwgNjAyLDczOSAxNzQs
MTQ4MSAxNDU2LDczOSAxNzQsMCBaIE0gMTM1OCw3MzkgTCAzMDksMTM0NiA2NTksNzM5IDEzNTgs
NzM5IFoiLz4KICA8L2c+CiAgPGcgaWQ9ImJ1bGxldC1jaGFyLXRlbXBsYXRlKDEwMTMyKSIgdHJh
bnNmb3JtPSJzY2FsZSgwLjAwMDQ4ODI4MTI1LC0wLjAwMDQ4ODI4MTI1KSI+CiAgIDxwYXRoIGQ9
Ik0gMjAxNSw3MzkgTCAxMjc2LDAgNzE3LDAgMTI2MCw1NDMgMTc0LDU0MyAxNzQsOTM2IDEyNjAs
OTM2IDcxNywxNDgxIDEyNzQsMTQ4MSAyMDE1LDczOSBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxs
ZXQtY2hhci10ZW1wbGF0ZSgxMDAwNykiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwt
MC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBkPSJNIDAsLTIgQyAtNywxNCAtMTYsMjcgLTI1LDM3
IEwgMzU2LDU2NyBDIDI2Miw4MjMgMjE1LDk1MiAyMTUsOTU0IDIxNSw5NzkgMjI4LDk5MiAyNTUs
OTkyIDI2NCw5OTIgMjc2LDk5MCAyODksOTg3IDMxMCw5OTEgMzMxLDk5OSAzNTQsMTAxMiBMIDM4
MSw5OTkgNDkyLDc0OCA3NzIsMTA0OSA4MzYsMTAyNCA4NjAsMTA0OSBDIDg4MSwxMDM5IDkwMSwx
MDI1IDkyMiwxMDA2IDg4Niw5MzcgODM1LDg2MyA3NzAsNzg0IDc2OSw3ODMgNzEwLDcxNiA1OTQs
NTg0IEwgNzc0LDIyMyBDIDc3NCwxOTYgNzUzLDE2OCA3MTEsMTM5IEwgNzI3LDExOSBDIDcxNyw5
MCA2OTksNzYgNjcyLDc2IDY0MSw3NiA1NzAsMTc4IDQ1NywzODEgTCAxNjQsLTc2IEMgMTQyLC0x
MTAgMTExLC0xMjcgNzIsLTEyNyAzMCwtMTI3IDksLTExMCA4LC03NiAxLC02NyAtMiwtNTIgLTIs
LTMyIC0yLC0yMyAtMSwtMTMgMCwtMiBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxsZXQtY2hhci10
ZW1wbGF0ZSgxMDAwNCkiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgy
ODEyNSkiPgogICA8cGF0aCBkPSJNIDI4NSwtMzMgQyAxODIsLTMzIDExMSwzMCA3NCwxNTYgNTIs
MjI4IDQxLDMzMyA0MSw0NzEgNDEsNTQ5IDU1LDYxNiA4Miw2NzIgMTE2LDc0MyAxNjksNzc4IDI0
MCw3NzggMjkzLDc3OCAzMjgsNzQ3IDM0Niw2ODQgTCAzNjksNTA4IEMgMzc3LDQ0NCAzOTcsNDEx
IDQyOCw0MTAgTCAxMTYzLDExMTYgQyAxMTc0LDExMjcgMTE5NiwxMTMzIDEyMjksMTEzMyAxMjcx
LDExMzMgMTI5MiwxMTE4IDEyOTIsMTA4NyBMIDEyOTIsOTY1IEMgMTI5Miw5MjkgMTI4Miw5MDEg
MTI2Miw4ODEgTCA0NDIsNDcgQyAzOTAsLTYgMzM4LC0zMyAyODUsLTMzIFoiLz4KICA8L2c+CiAg
PGcgaWQ9ImJ1bGxldC1jaGFyLXRlbXBsYXRlKDk2NzkpIiB0cmFuc2Zvcm09InNjYWxlKDAuMDAw
NDg4MjgxMjUsLTAuMDAwNDg4MjgxMjUpIj4KICAgPHBhdGggZD0iTSA4MTMsMCBDIDYzMiwwIDQ4
OSw1NCAzODMsMTYxIDI3NiwyNjggMjIzLDQxMSAyMjMsNTkyIDIyMyw3NzMgMjc2LDkxNiAzODMs
MTAyMyA0ODksMTEzMCA2MzIsMTE4NCA4MTMsMTE4NCA5OTIsMTE4NCAxMTM2LDExMzAgMTI0NSwx
MDIzIDEzNTMsOTE2IDE0MDcsNzcyIDE0MDcsNTkyIDE0MDcsNDEyIDEzNTMsMjY4IDEyNDUsMTYx
IDExMzYsNTQgOTkyLDAgODEzLDAgWiIvPgogIDwvZz4KICA8ZyBpZD0iYnVsbGV0LWNoYXItdGVt
cGxhdGUoODIyNikiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgyODEy
NSkiPgogICA8cGF0aCBkPSJNIDM0Niw0NTcgQyAyNzMsNDU3IDIwOSw0ODMgMTU1LDUzNSAxMDEs
NTg2IDc0LDY0OSA3NCw3MjMgNzQsNzk2IDEwMSw4NTkgMTU1LDkxMSAyMDksOTYzIDI3Myw5ODkg
MzQ2LDk4OSA0MTksOTg5IDQ4MCw5NjMgNTMxLDkxMCA1ODIsODU5IDYwOCw3OTYgNjA4LDcyMyA2
MDgsNjQ4IDU4Myw1ODYgNTMyLDUzNSA0ODIsNDgzIDQyMCw0NTcgMzQ2LDQ1NyBaIi8+CiAgPC9n
PgogIDxnIGlkPSJidWxsZXQtY2hhci10ZW1wbGF0ZSg4MjExKSIgdHJhbnNmb3JtPSJzY2FsZSgw
LjAwMDQ4ODI4MTI1LC0wLjAwMDQ4ODI4MTI1KSI+CiAgIDxwYXRoIGQ9Ik0gLTQsNDU5IEwgMTEz
NSw0NTkgMTEzNSw2MDYgLTQsNjA2IC00LDQ1OSBaIi8+CiAgPC9nPgogPC9kZWZzPgogPGRlZnMg
Y2xhc3M9IlRleHRFbWJlZGRlZEJpdG1hcHMiLz4KIDxnIGNsYXNzPSJTbGlkZUdyb3VwIj4KICA8
Zz4KICAgPGcgaWQ9ImlkMSIgY2xhc3M9IlNsaWRlIiBjbGlwLXBhdGg9InVybCgjcHJlc2VudGF0
aW9uX2NsaXBfcGF0aCkiPgogICAgPGcgY2xhc3M9IlBhZ2UiPgogICAgIDxnIGNsYXNzPSJjb20u
c3VuLnN0YXIuZHJhd2luZy5DdXN0b21TaGFwZSI+CiAgICAgIDxnIGlkPSJpZDMiPgogICAgICAg
PHJlY3QgY2xhc3M9IkJvdW5kaW5nQm94IiBzdHJva2U9Im5vbmUiIGZpbGw9Im5vbmUiIHg9IjE5
Mzk5IiB5PSIzNjk5IiB3aWR0aD0iNTkwMyIgaGVpZ2h0PSI5NTAzIi8+CiAgICAgICA8cGF0aCBm
aWxsPSJyZ2IoMTQyLDE4MSwxNDIpIiBzdHJva2U9Im5vbmUiIGQ9Ik0gMjIzNTAsMTMyMDAgTCAx
OTQwMCwxMzIwMCAxOTQwMCwzNzAwIDI1MzAwLDM3MDAgMjUzMDAsMTMyMDAgMjIzNTAsMTMyMDAg
WiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9
Ik0gMjIzNTAsMTMyMDAgTCAxOTQwMCwxMzIwMCAxOTQwMCwzNzAwIDI1MzAwLDM3MDAgMjUzMDAs
MTMyMDAgMjIzNTAsMTMyMDAgWiIvPgogICAgICAgPHRleHQgY2xhc3M9IlRleHRTaGFwZSI+PHRz
cGFuIGNsYXNzPSJUZXh0UGFyYWdyYXBoIiBmb250LWZhbWlseT0iRGVqYVZ1IFNhbnMsIHNhbnMt
c2VyaWYiIGZvbnQtc2l6ZT0iNjM0cHgiIGZvbnQtd2VpZ2h0PSI0MDAiPjx0c3BhbiBjbGFzcz0i
VGV4dFBvc2l0aW9uIiB4PSIyMDk2NCIgeT0iNDQxMyI+PHRzcGFuIGZpbGw9InJnYigwLDAsMCki
IHN0cm9rZT0ibm9uZSI+U3BlaWNoZXI8L3RzcGFuPjwvdHNwYW4+PC90c3Bhbj48L3RleHQ+CiAg
ICAgIDwvZz4KICAgICA8L2c+CiAgICAgPGcgY2xhc3M9ImNvbS5zdW4uc3Rhci5kcmF3aW5nLkN1
c3RvbVNoYXBlIj4KICAgICAgPGcgaWQ9ImlkNCI+CiAgICAgICA8cmVjdCBjbGFzcz0iQm91bmRp
bmdCb3giIHN0cm9rZT0ibm9uZSIgZmlsbD0ibm9uZSIgeD0iMTkzOTkiIHk9IjYzOTkiIHdpZHRo
PSI1OTAzIiBoZWlnaHQ9IjIwMDMiLz4KICAgICAgIDxwYXRoIGZpbGw9InJnYigwLDEyOCwwKSIg
c3Ryb2tlPSJub25lIiBkPSJNIDIyMzUwLDg0MDAgTCAxOTQwMCw4NDAwIDE5NDAwLDY0MDAgMjUz
MDAsNjQwMCAyNTMwMCw4NDAwIDIyMzUwLDg0MDAgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9u
ZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9Ik0gMjIzNTAsODQwMCBMIDE5NDAwLDg0MDAg
MTk0MDAsNjQwMCAyNTMwMCw2NDAwIDI1MzAwLDg0MDAgMjIzNTAsODQwMCBaIi8+CiAgICAgICA8
dGV4dCBjbGFzcz0iVGV4dFNoYXBlIj48dHNwYW4gY2xhc3M9IlRleHRQYXJhZ3JhcGgiIGZvbnQt
ZmFtaWx5PSJEZWphVnUgU2Fucywgc2Fucy1zZXJpZiIgZm9udC1zaXplPSI2MzRweCIgZm9udC13
ZWlnaHQ9IjQwMCI+PHRzcGFuIGNsYXNzPSJUZXh0UG9zaXRpb24iIHg9IjIwMzgwIiB5PSI3NjIw
Ij48dHNwYW4gZmlsbD0icmdiKDAsMCwwKSIgc3Ryb2tlPSJub25lIj5MaXN0ZTogMSwgMiwgMzwv
dHNwYW4+PC90c3Bhbj48L3RzcGFuPjwvdGV4dD4KICAgICAgPC9nPgogICAgIDwvZz4KICAgICA8
ZyBjbGFzcz0iY29tLnN1bi5zdGFyLmRyYXdpbmcuQ3VzdG9tU2hhcGUiPgogICAgICA8ZyBpZD0i
aWQ1Ij4KICAgICAgIDxyZWN0IGNsYXNzPSJCb3VuZGluZ0JveCIgc3Ryb2tlPSJub25lIiBmaWxs
PSJub25lIiB4PSIyODk5IiB5PSIzNTk5IiB3aWR0aD0iOTkwNCIgaGVpZ2h0PSI5NTA0Ii8+CiAg
ICAgICA8cGF0aCBmaWxsPSJyZ2IoMTE0LDE1OSwyMDcpIiBzdHJva2U9Im5vbmUiIGQ9Ik0gNDQ4
MywzNjAwIEMgMzY5MSwzNjAwIDI5MDAsNDM5MSAyOTAwLDUxODMgTCAyOTAwLDExNTE3IEMgMjkw
MCwxMjMwOSAzNjkxLDEzMTAxIDQ0ODMsMTMxMDEgTCAxMTIxNywxMzEwMSBDIDEyMDA5LDEzMTAx
IDEyODAxLDEyMzA5IDEyODAxLDExNTE3IEwgMTI4MDEsNTE4MyBDIDEyODAxLDQzOTEgMTIwMDks
MzYwMCAxMTIxNywzNjAwIEwgNDQ4MywzNjAwIFogTSAyOTAwLDM2MDAgTCAyOTAwLDM2MDAgWiBN
IDEyODAxLDEzMTAxIEwgMTI4MDEsMTMxMDEgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIg
c3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9Ik0gNDQ4MywzNjAwIEMgMzY5MSwzNjAwIDI5MDAs
NDM5MSAyOTAwLDUxODMgTCAyOTAwLDExNTE3IEMgMjkwMCwxMjMwOSAzNjkxLDEzMTAxIDQ0ODMs
MTMxMDEgTCAxMTIxNywxMzEwMSBDIDEyMDA5LDEzMTAxIDEyODAxLDEyMzA5IDEyODAxLDExNTE3
IEwgMTI4MDEsNTE4MyBDIDEyODAxLDQzOTEgMTIwMDksMzYwMCAxMTIxNywzNjAwIEwgNDQ4Mywz
NjAwIFoiLz4KICAgICAgIDxwYXRoIGZpbGw9Im5vbmUiIHN0cm9rZT0icmdiKDUyLDEwMSwxNjQp
IiBkPSJNIDI5MDAsMzYwMCBMIDI5MDAsMzYwMCBaIi8+CiAgICAgICA8cGF0aCBmaWxsPSJub25l
IiBzdHJva2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSAxMjgwMSwxMzEwMSBMIDEyODAxLDEzMTAx
IFoiLz4KICAgICAgIDx0ZXh0IGNsYXNzPSJUZXh0U2hhcGUiPjx0c3BhbiBjbGFzcz0iVGV4dFBh
cmFncmFwaCIgZm9udC1mYW1pbHk9IkRlamFWdSBTYW5zLCBzYW5zLXNlcmlmIiBmb250LXNpemU9
IjYzNHB4IiBmb250LXdlaWdodD0iNDAwIj48dHNwYW4gY2xhc3M9IlRleHRQb3NpdGlvbiIgeD0i
NTAxMiIgeT0iNDc3NiI+PHRzcGFuIGZpbGw9InJnYigwLDAsMCkiIHN0cm9rZT0ibm9uZSI+VmFy
aWFibGVuKG5hbWVuKTwvdHNwYW4+PC90c3Bhbj48L3RzcGFuPjwvdGV4dD4KICAgICAgPC9nPgog
ICAgIDwvZz4KICAgICA8ZyBjbGFzcz0iY29tLnN1bi5zdGFyLmRyYXdpbmcuQ3VzdG9tU2hhcGUi
PgogICAgICA8ZyBpZD0iaWQ2Ij4KICAgICAgIDxyZWN0IGNsYXNzPSJCb3VuZGluZ0JveCIgc3Ry
b2tlPSJub25lIiBmaWxsPSJub25lIiB4PSI2NDk5IiB5PSI1Mzk5IiB3aWR0aD0iMzYwNCIgaGVp
Z2h0PSIyMDA0Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMCw3MSwyNTUpIiBzdHJva2U9Im5v
bmUiIGQ9Ik0gNjgzMyw1NDAwIEMgNjY2Niw1NDAwIDY1MDAsNTU2NiA2NTAwLDU3MzMgTCA2NTAw
LDcwNjcgQyA2NTAwLDcyMzQgNjY2Niw3NDAxIDY4MzMsNzQwMSBMIDk3NjcsNzQwMSBDIDk5MzMs
NzQwMSAxMDEwMCw3MjM0IDEwMTAwLDcwNjcgTCAxMDEwMCw1NzMzIEMgMTAxMDAsNTU2NiA5OTMz
LDU0MDAgOTc2Nyw1NDAwIEwgNjgzMyw1NDAwIFogTSA2NTAwLDU0MDAgTCA2NTAwLDU0MDAgWiBN
IDEwMTAxLDc0MDEgTCAxMDEwMSw3NDAxIFoiLz4KICAgICAgIDxwYXRoIGZpbGw9Im5vbmUiIHN0
cm9rZT0icmdiKDUyLDEwMSwxNjQpIiBkPSJNIDY4MzMsNTQwMCBDIDY2NjYsNTQwMCA2NTAwLDU1
NjYgNjUwMCw1NzMzIEwgNjUwMCw3MDY3IEMgNjUwMCw3MjM0IDY2NjYsNzQwMSA2ODMzLDc0MDEg
TCA5NzY3LDc0MDEgQyA5OTMzLDc0MDEgMTAxMDAsNzIzNCAxMDEwMCw3MDY3IEwgMTAxMDAsNTcz
MyBDIDEwMTAwLDU1NjYgOTkzMyw1NDAwIDk3NjcsNTQwMCBMIDY4MzMsNTQwMCBaIi8+CiAgICAg
ICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSA2NTAwLDU0
MDAgTCA2NTAwLDU0MDAgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2Io
NTIsMTAxLDE2NCkiIGQ9Ik0gMTAxMDEsNzQwMSBMIDEwMTAxLDc0MDEgWiIvPgogICAgICAgPHRl
eHQgY2xhc3M9IlRleHRTaGFwZSI+PHRzcGFuIGNsYXNzPSJUZXh0UGFyYWdyYXBoIiBmb250LWZh
bWlseT0iRGVqYVZ1IFNhbnMsIHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iNjM0cHgiIGZvbnQtd2Vp
Z2h0PSI0MDAiPjx0c3BhbiBjbGFzcz0iVGV4dFBvc2l0aW9uIiB4PSI4MTEyIiB5PSI2NjIwIj48
dHNwYW4gZmlsbD0icmdiKDAsMCwwKSIgc3Ryb2tlPSJub25lIj54PC90c3Bhbj48L3RzcGFuPjwv
dHNwYW4+PC90ZXh0PgogICAgICA8L2c+CiAgICAgPC9nPgogICAgIDxnIGNsYXNzPSJjb20uc3Vu
LnN0YXIuZHJhd2luZy5Db25uZWN0b3JTaGFwZSI+CiAgICAgIDxnIGlkPSJpZDciPgogICAgICAg
PHJlY3QgY2xhc3M9IkJvdW5kaW5nQm94IiBzdHJva2U9Im5vbmUiIGZpbGw9Im5vbmUiIHg9IjEw
MDY0IiB5PSI2MzY0IiB3aWR0aD0iOTMzNyIgaGVpZ2h0PSIxMjM3Ii8+CiAgICAgICA8cGF0aCBm
aWxsPSJub25lIiBzdHJva2U9InJnYigwLDAsMCkiIHN0cm9rZS13aWR0aD0iNzEiIHN0cm9rZS1s
aW5lam9pbj0icm91bmQiIGQ9Ik0gMTAxMDAsNjQwMCBDIDE3MDc2LDY0MDAgMTI3MjAsNzMzNSAx
ODc1MCw3Mzk3Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMCwwLDApIiBzdHJva2U9Im5vbmUi
IGQ9Ik0gMTk0MDAsNzQwMCBMIDE4NzkyLDcxOTQgMTg3OTAsNzYwMCAxOTQwMCw3NDAwIFoiLz4K
ICAgICAgPC9nPgogICAgIDwvZz4KICAgIDwvZz4KICAgPC9nPgogIDwvZz4KIDwvZz4KPC9zdmc+""", MIME("image/svg"), (:height => 240,))
	Bilder["xy_ref"] = PlutoUI.Resource(
	"""data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHN2ZyBQVUJM
SUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3Mv
U1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KPHN2ZyB2ZXJzaW9uPSIxLjIiIHdpZHRoPSIyMjQuMDFt
bSIgaGVpZ2h0PSI5Ni4wMW1tIiB2aWV3Qm94PSIyOTAwIDM1OTkgMjI0MDEgOTYwMSIgcHJlc2Vy
dmVBc3BlY3RSYXRpbz0ieE1pZFlNaWQiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLXdpZHRo
PSIyOC4yMjIiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9y
Zy8yMDAwL3N2ZyIgeG1sbnM6b29vPSJodHRwOi8veG1sLm9wZW5vZmZpY2Uub3JnL3N2Zy9leHBv
cnQiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4bWxuczpwcmVz
ZW50YXRpb249Imh0dHA6Ly9zdW4uY29tL3htbG5zL3N0YXJvZmZpY2UvcHJlc2VudGF0aW9uIiB4
bWxuczpzbWlsPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1NNSUwyMC8iIHhtbG5zOmFuaW09InVy
bjpvYXNpczpuYW1lczp0YzpvcGVuZG9jdW1lbnQ6eG1sbnM6YW5pbWF0aW9uOjEuMCIgeG1sOnNw
YWNlPSJwcmVzZXJ2ZSI+CiA8ZGVmcyBjbGFzcz0iQ2xpcFBhdGhHcm91cCI+CiAgPGNsaXBQYXRo
IGlkPSJwcmVzZW50YXRpb25fY2xpcF9wYXRoIiBjbGlwUGF0aFVuaXRzPSJ1c2VyU3BhY2VPblVz
ZSI+CiAgIDxyZWN0IHg9IjI5MDAiIHk9IjM1OTkiIHdpZHRoPSIyMjQwMSIgaGVpZ2h0PSI5NjAx
Ii8+CiAgPC9jbGlwUGF0aD4KIDwvZGVmcz4KIDxkZWZzPgogIDxmb250IGlkPSJFbWJlZGRlZEZv
bnRfMSIgaG9yaXotYWR2LXg9IjIwNDgiPgogICA8Zm9udC1mYWNlIGZvbnQtZmFtaWx5PSJEZWph
VnUgU2FucyBlbWJlZGRlZCIgdW5pdHMtcGVyLWVtPSIyMDQ4IiBmb250LXdlaWdodD0ibm9ybWFs
IiBmb250LXN0eWxlPSJub3JtYWwiIGFzY2VudD0iMTg3OSIgZGVzY2VudD0iNDc2Ii8+CiAgIDxt
aXNzaW5nLWdseXBoIGhvcml6LWFkdi14PSIyMDQ4IiBkPSJNIDAsMCBMIDIwNDcsMCAyMDQ3LDIw
NDcgMCwyMDQ3IDAsMCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJ5IiBob3Jpei1hZHYteD0iMTEx
MiIgZD0iTSA2NTksLTEwNCBDIDYwNywtMjM3IDU1NiwtMzI0IDUwNywtMzY1IDQ1OCwtNDA2IDM5
MiwtNDI2IDMwOSwtNDI2IEwgMTYyLC00MjYgMTYyLC0yNzIgMjcwLC0yNzIgQyAzMjEsLTI3MiAz
NjAsLTI2MCAzODgsLTIzNiA0MTYsLTIxMiA0NDcsLTE1NSA0ODEsLTY2IEwgNTE0LDE4IDYxLDEx
MjAgMjU2LDExMjAgNjA2LDI0NCA5NTYsMTEyMCAxMTUxLDExMjAgNjU5LC0xMDQgWiIvPgogICA8
Z2x5cGggdW5pY29kZT0ieCIgaG9yaXotYWR2LXg9IjExMTIiIGQ9Ik0gMTEyNCwxMTIwIEwgNzE5
LDU3NSAxMTQ1LDAgOTI4LDAgNjAyLDQ0MCAyNzYsMCA1OSwwIDQ5NCw1ODYgOTYsMTEyMCAzMTMs
MTEyMCA2MTAsNzIxIDkwNywxMTIwIDExMjQsMTEyMCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJ0
IiBob3Jpei1hZHYteD0iNzE1IiBkPSJNIDM3NSwxNDM4IEwgMzc1LDExMjAgNzU0LDExMjAgNzU0
LDk3NyAzNzUsOTc3IDM3NSwzNjkgQyAzNzUsMjc4IDM4OCwyMTkgNDEzLDE5MyA0MzgsMTY3IDQ4
OCwxNTQgNTY1LDE1NCBMIDc1NCwxNTQgNzU0LDAgNTY1LDAgQyA0MjMsMCAzMjUsMjcgMjcxLDgw
IDIxNywxMzMgMTkwLDIyOSAxOTAsMzY5IEwgMTkwLDk3NyA1NSw5NzcgNTUsMTEyMCAxOTAsMTEy
MCAxOTAsMTQzOCAzNzUsMTQzOCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJzIiBob3Jpei1hZHYt
eD0iODc0IiBkPSJNIDkwNywxMDg3IEwgOTA3LDkxMyBDIDg1NSw5NDAgODAxLDk2MCA3NDUsOTcz
IDY4OSw5ODYgNjMxLDk5MyA1NzEsOTkzIDQ4MCw5OTMgNDExLDk3OSAzNjYsOTUxIDMyMCw5MjMg
Mjk3LDg4MSAyOTcsODI1IDI5Nyw3ODIgMzEzLDc0OSAzNDYsNzI1IDM3OSw3MDAgNDQ0LDY3NyA1
NDMsNjU1IEwgNjA2LDY0MSBDIDczNyw2MTMgODMwLDU3NCA4ODUsNTIzIDk0MCw0NzIgOTY3LDQw
MCA5NjcsMzA5IDk2NywyMDUgOTI2LDEyMyA4NDQsNjIgNzYxLDEgNjQ4LC0yOSA1MDQsLTI5IDQ0
NCwtMjkgMzgyLC0yMyAzMTcsLTEyIDI1MiwwIDE4MywxOCAxMTEsNDEgTCAxMTEsMjMxIEMgMTc5
LDE5NiAyNDYsMTY5IDMxMiwxNTIgMzc4LDEzNCA0NDMsMTI1IDUwOCwxMjUgNTk1LDEyNSA2NjEs
MTQwIDcwOCwxNzAgNzU1LDE5OSA3NzgsMjQxIDc3OCwyOTUgNzc4LDM0NSA3NjEsMzgzIDcyOCw0
MTAgNjk0LDQzNyA2MjAsNDYyIDUwNiw0ODcgTCA0NDIsNTAyIEMgMzI4LDUyNiAyNDYsNTYzIDE5
NSw2MTMgMTQ0LDY2MiAxMTksNzMwIDExOSw4MTcgMTE5LDkyMiAxNTYsMTAwNCAyMzEsMTA2MSAz
MDYsMTExOCA0MTIsMTE0NyA1NDksMTE0NyA2MTcsMTE0NyA2ODEsMTE0MiA3NDEsMTEzMiA4MDEs
MTEyMiA4NTYsMTEwNyA5MDcsMTA4NyBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJyIiBob3Jpei1h
ZHYteD0iNjYzIiBkPSJNIDg0Miw5NDggQyA4MjEsOTYwIDc5OSw5NjkgNzc1LDk3NSA3NTAsOTgw
IDcyMyw5ODMgNjk0LDk4MyA1OTAsOTgzIDUxMCw5NDkgNDU1LDg4MiAzOTksODE0IDM3MSw3MTcg
MzcxLDU5MCBMIDM3MSwwIDE4NiwwIDE4NiwxMTIwIDM3MSwxMTIwIDM3MSw5NDYgQyA0MTAsMTAx
NCA0NjAsMTA2NSA1MjIsMTA5OCA1ODQsMTEzMSA2NTksMTE0NyA3NDgsMTE0NyA3NjEsMTE0NyA3
NzUsMTE0NiA3OTAsMTE0NSA4MDUsMTE0MyA4MjIsMTE0MCA4NDEsMTEzNyBMIDg0Miw5NDggWiIv
PgogICA8Z2x5cGggdW5pY29kZT0icCIgaG9yaXotYWR2LXg9IjEwMDciIGQ9Ik0gMzcxLDE2OCBM
IDM3MSwtNDI2IDE4NiwtNDI2IDE4NiwxMTIwIDM3MSwxMTIwIDM3MSw5NTAgQyA0MTAsMTAxNyA0
NTksMTA2NiA1MTgsMTA5OSA1NzcsMTEzMSA2NDcsMTE0NyA3MjksMTE0NyA4NjUsMTE0NyA5NzYs
MTA5MyAxMDYxLDk4NSAxMTQ2LDg3NyAxMTg4LDczNSAxMTg4LDU1OSAxMTg4LDM4MyAxMTQ2LDI0
MSAxMDYxLDEzMyA5NzYsMjUgODY1LC0yOSA3MjksLTI5IDY0NywtMjkgNTc3LC0xMyA1MTgsMjAg
NDU5LDUyIDQxMCwxMDEgMzcxLDE2OCBaIE0gOTk3LDU1OSBDIDk5Nyw2OTQgOTY5LDgwMSA5MTQs
ODc4IDg1OCw5NTUgNzgxLDk5MyA2ODQsOTkzIDU4Nyw5OTMgNTEwLDk1NSA0NTUsODc4IDM5OSw4
MDEgMzcxLDY5NCAzNzEsNTU5IDM3MSw0MjQgMzk5LDMxOCA0NTUsMjQxIDUxMCwxNjQgNTg3LDEy
NSA2ODQsMTI1IDc4MSwxMjUgODU4LDE2NCA5MTQsMjQxIDk2OSwzMTggOTk3LDQyNCA5OTcsNTU5
IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9Im4iIGhvcml6LWFkdi14PSI5NTQiIGQ9Ik0gMTEyNCw2
NzYgTCAxMTI0LDAgOTQwLDAgOTQwLDY3MCBDIDk0MCw3NzYgOTE5LDg1NSA4NzgsOTA4IDgzNyw5
NjEgNzc1LDk4NyA2OTIsOTg3IDU5Myw5ODcgNTE0LDk1NSA0NTcsODkyIDQwMCw4MjkgMzcxLDc0
MiAzNzEsNjMzIEwgMzcxLDAgMTg2LDAgMTg2LDExMjAgMzcxLDExMjAgMzcxLDk0NiBDIDQxNSwx
MDEzIDQ2NywxMDY0IDUyNywxMDk3IDU4NiwxMTMwIDY1NSwxMTQ3IDczMywxMTQ3IDg2MiwxMTQ3
IDk1OSwxMTA3IDEwMjUsMTAyOCAxMDkxLDk0OCAxMTI0LDgzMSAxMTI0LDY3NiBaIi8+CiAgIDxn
bHlwaCB1bmljb2RlPSJtIiBob3Jpei1hZHYteD0iMTY0MiIgZD0iTSAxMDY1LDkwNSBDIDExMTEs
OTg4IDExNjYsMTA0OSAxMjMwLDEwODggMTI5NCwxMTI3IDEzNjksMTE0NyAxNDU2LDExNDcgMTU3
MywxMTQ3IDE2NjMsMTEwNiAxNzI2LDEwMjUgMTc4OSw5NDMgMTgyMSw4MjcgMTgyMSw2NzYgTCAx
ODIxLDAgMTYzNiwwIDE2MzYsNjcwIEMgMTYzNiw3NzcgMTYxNyw4NTcgMTU3OSw5MDkgMTU0MSw5
NjEgMTQ4Myw5ODcgMTQwNSw5ODcgMTMxMCw5ODcgMTIzNCw5NTUgMTE3OSw4OTIgMTEyNCw4Mjkg
MTA5Niw3NDIgMTA5Niw2MzMgTCAxMDk2LDAgOTExLDAgOTExLDY3MCBDIDkxMSw3NzggODkyLDg1
OCA4NTQsOTEwIDgxNiw5NjEgNzU3LDk4NyA2NzgsOTg3IDU4NCw5ODcgNTA5LDk1NSA0NTQsODky
IDM5OSw4MjggMzcxLDc0MiAzNzEsNjMzIEwgMzcxLDAgMTg2LDAgMTg2LDExMjAgMzcxLDExMjAg
MzcxLDk0NiBDIDQxMywxMDE1IDQ2MywxMDY1IDUyMiwxMDk4IDU4MSwxMTMxIDY1MCwxMTQ3IDcz
MSwxMTQ3IDgxMiwxMTQ3IDg4MiwxMTI2IDkzOSwxMDg1IDk5NiwxMDQ0IDEwMzgsOTg0IDEwNjUs
OTA1IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9ImwiIGhvcml6LWFkdi14PSIyMTMiIGQ9Ik0gMTkz
LDE1NTYgTCAzNzcsMTU1NiAzNzcsMCAxOTMsMCAxOTMsMTU1NiBaIi8+CiAgIDxnbHlwaCB1bmlj
b2RlPSJpIiBob3Jpei1hZHYteD0iMjEzIiBkPSJNIDE5MywxMTIwIEwgMzc3LDExMjAgMzc3LDAg
MTkzLDAgMTkzLDExMjAgWiBNIDE5MywxNTU2IEwgMzc3LDE1NTYgMzc3LDEzMjMgMTkzLDEzMjMg
MTkzLDE1NTYgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iaCIgaG9yaXotYWR2LXg9Ijk1NCIgZD0i
TSAxMTI0LDY3NiBMIDExMjQsMCA5NDAsMCA5NDAsNjcwIEMgOTQwLDc3NiA5MTksODU1IDg3OCw5
MDggODM3LDk2MSA3NzUsOTg3IDY5Miw5ODcgNTkzLDk4NyA1MTQsOTU1IDQ1Nyw4OTIgNDAwLDgy
OSAzNzEsNzQyIDM3MSw2MzMgTCAzNzEsMCAxODYsMCAxODYsMTU1NiAzNzEsMTU1NiAzNzEsOTQ2
IEMgNDE1LDEwMTMgNDY3LDEwNjQgNTI3LDEwOTcgNTg2LDExMzAgNjU1LDExNDcgNzMzLDExNDcg
ODYyLDExNDcgOTU5LDExMDcgMTAyNSwxMDI4IDEwOTEsOTQ4IDExMjQsODMxIDExMjQsNjc2IFoi
Lz4KICAgPGdseXBoIHVuaWNvZGU9ImUiIGhvcml6LWFkdi14PSIxMDU5IiBkPSJNIDExNTEsNjA2
IEwgMTE1MSw1MTYgMzA1LDUxNiBDIDMxMywzODkgMzUxLDI5MyA0MjAsMjI3IDQ4OCwxNjAgNTgz
LDEyNyA3MDUsMTI3IDc3NiwxMjcgODQ0LDEzNiA5MTEsMTUzIDk3NywxNzAgMTA0MywxOTYgMTEw
OCwyMzEgTCAxMTA4LDU3IEMgMTA0MiwyOSA5NzQsOCA5MDUsLTcgODM2LC0yMiA3NjUsLTI5IDY5
NCwtMjkgNTE1LC0yOSAzNzQsMjMgMjcwLDEyNyAxNjUsMjMxIDExMywzNzIgMTEzLDU0OSAxMTMs
NzMyIDE2Myw4NzggMjYyLDk4NiAzNjEsMTA5MyA0OTQsMTE0NyA2NjIsMTE0NyA4MTMsMTE0NyA5
MzIsMTA5OSAxMDIwLDEwMDIgMTEwNyw5MDUgMTE1MSw3NzMgMTE1MSw2MDYgWiBNIDk2Nyw2NTkg
QyA5NjYsNzYwIDkzOCw4NDEgODgzLDkwMSA4MjgsOTYxIDc1NSw5OTEgNjY0LDk5MSA1NjEsOTkx
IDQ3OSw5NjIgNDE4LDkwNCAzNTYsODQ2IDMyMCw3NjQgMzExLDY1OSBMIDk2Nyw2NTkgWiIvPgog
ICA8Z2x5cGggdW5pY29kZT0iYyIgaG9yaXotYWR2LXg9IjkwMCIgZD0iTSA5OTksMTA3NyBMIDk5
OSw5MDUgQyA5NDcsOTM0IDg5NSw5NTUgODQzLDk3MCA3OTAsOTg0IDczNyw5OTEgNjg0LDk5MSA1
NjUsOTkxIDQ3Miw5NTMgNDA2LDg3OCAzNDAsODAyIDMwNyw2OTYgMzA3LDU1OSAzMDcsNDIyIDM0
MCwzMTYgNDA2LDI0MSA0NzIsMTY1IDU2NSwxMjcgNjg0LDEyNyA3MzcsMTI3IDc5MCwxMzQgODQz
LDE0OSA4OTUsMTYzIDk0NywxODQgOTk5LDIxMyBMIDk5OSw0MyBDIDk0OCwxOSA4OTUsMSA4NDAs
LTExIDc4NSwtMjMgNzI2LC0yOSA2NjQsLTI5IDQ5NSwtMjkgMzYxLDI0IDI2MiwxMzAgMTYzLDIz
NiAxMTMsMzc5IDExMyw1NTkgMTEzLDc0MiAxNjMsODg1IDI2NCw5OTAgMzY0LDEwOTUgNTAxLDEx
NDcgNjc2LDExNDcgNzMzLDExNDcgNzg4LDExNDEgODQyLDExMzAgODk2LDExMTggOTQ4LDExMDAg
OTk5LDEwNzcgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iYiIgaG9yaXotYWR2LXg9IjEwMDciIGQ9
Ik0gOTk3LDU1OSBDIDk5Nyw2OTQgOTY5LDgwMSA5MTQsODc4IDg1OCw5NTUgNzgxLDk5MyA2ODQs
OTkzIDU4Nyw5OTMgNTEwLDk1NSA0NTUsODc4IDM5OSw4MDEgMzcxLDY5NCAzNzEsNTU5IDM3MSw0
MjQgMzk5LDMxOCA0NTUsMjQxIDUxMCwxNjQgNTg3LDEyNSA2ODQsMTI1IDc4MSwxMjUgODU4LDE2
NCA5MTQsMjQxIDk2OSwzMTggOTk3LDQyNCA5OTcsNTU5IFogTSAzNzEsOTUwIEMgNDEwLDEwMTcg
NDU5LDEwNjYgNTE4LDEwOTkgNTc3LDExMzEgNjQ3LDExNDcgNzI5LDExNDcgODY1LDExNDcgOTc2
LDEwOTMgMTA2MSw5ODUgMTE0Niw4NzcgMTE4OCw3MzUgMTE4OCw1NTkgMTE4OCwzODMgMTE0Niwy
NDEgMTA2MSwxMzMgOTc2LDI1IDg2NSwtMjkgNzI5LC0yOSA2NDcsLTI5IDU3NywtMTMgNTE4LDIw
IDQ1OSw1MiA0MTAsMTAxIDM3MSwxNjggTCAzNzEsMCAxODYsMCAxODYsMTU1NiAzNzEsMTU1NiAz
NzEsOTUwIFoiLz4KICAgPGdseXBoIHVuaWNvZGU9ImEiIGhvcml6LWFkdi14PSI5ODAiIGQ9Ik0g
NzAyLDU2MyBDIDU1Myw1NjMgNDUwLDU0NiAzOTMsNTEyIDMzNiw0NzggMzA3LDQyMCAzMDcsMzM4
IDMwNywyNzMgMzI5LDIyMSAzNzIsMTgzIDQxNSwxNDQgNDczLDEyNSA1NDcsMTI1IDY0OSwxMjUg
NzMxLDE2MSA3OTMsMjM0IDg1NCwzMDYgODg1LDQwMiA4ODUsNTIyIEwgODg1LDU2MyA3MDIsNTYz
IFogTSAxMDY5LDYzOSBMIDEwNjksMCA4ODUsMCA4ODUsMTcwIEMgODQzLDEwMiA3OTEsNTIgNzI4
LDIwIDY2NSwtMTMgNTg5LC0yOSA0OTgsLTI5IDM4MywtMjkgMjkyLDMgMjI1LDY4IDE1NywxMzIg
MTIzLDIxOCAxMjMsMzI2IDEyMyw0NTIgMTY1LDU0NyAyNTAsNjExIDMzNCw2NzUgNDYwLDcwNyA2
MjcsNzA3IEwgODg1LDcwNyA4ODUsNzI1IEMgODg1LDgxMCA4NTcsODc1IDgwMiw5MjIgNzQ2LDk2
OCA2NjgsOTkxIDU2Nyw5OTEgNTAzLDk5MSA0NDEsOTgzIDM4MCw5NjggMzE5LDk1MyAyNjEsOTMw
IDIwNSw4OTkgTCAyMDUsMTA2OSBDIDI3MiwxMDk1IDMzOCwxMTE1IDQwMSwxMTI4IDQ2NCwxMTQx
IDUyNiwxMTQ3IDU4NiwxMTQ3IDc0OCwxMTQ3IDg2OSwxMTA1IDk0OSwxMDIxIDEwMjksOTM3IDEw
NjksODEwIDEwNjksNjM5IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9IlYiIGhvcml6LWFkdi14PSIx
NDAzIiBkPSJNIDU4NiwwIEwgMTYsMTQ5MyAyMjcsMTQ5MyA3MDAsMjM2IDExNzQsMTQ5MyAxMzg0
LDE0OTMgODE1LDAgNTg2LDAgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iUyIgaG9yaXotYWR2LXg9
IjEwNjAiIGQ9Ik0gMTA5NiwxNDQ0IEwgMTA5NiwxMjQ3IEMgMTAxOSwxMjg0IDk0NywxMzExIDg3
OSwxMzI5IDgxMSwxMzQ3IDc0NSwxMzU2IDY4MiwxMzU2IDU3MiwxMzU2IDQ4NywxMzM1IDQyOCwx
MjkyIDM2OCwxMjQ5IDMzOCwxMTg5IDMzOCwxMTEwIDMzOCwxMDQ0IDM1OCw5OTQgMzk4LDk2MSA0
MzcsOTI3IDUxMiw5MDAgNjIzLDg3OSBMIDc0NSw4NTQgQyA4OTYsODI1IDEwMDcsNzc1IDEwNzks
NzAzIDExNTAsNjMwIDExODYsNTMzIDExODYsNDEyIDExODYsMjY3IDExMzgsMTU4IDEwNDEsODMg
OTQ0LDggODAxLC0yOSA2MTQsLTI5IDU0MywtMjkgNDY4LC0yMSAzODksLTUgMzA5LDExIDIyNiwz
NSAxNDEsNjYgTCAxNDEsMjc0IEMgMjIzLDIyOCAzMDMsMTkzIDM4MiwxNzAgNDYxLDE0NyA1Mzgs
MTM1IDYxNCwxMzUgNzI5LDEzNSA4MTgsMTU4IDg4MSwyMDMgOTQ0LDI0OCA5NzUsMzEzIDk3NSwz
OTcgOTc1LDQ3MCA5NTMsNTI4IDkwOCw1NjkgODYzLDYxMCA3ODksNjQxIDY4Niw2NjIgTCA1NjMs
Njg2IEMgNDEyLDcxNiAzMDMsNzYzIDIzNiw4MjcgMTY5LDg5MSAxMzUsOTgwIDEzNSwxMDk0IDEz
NSwxMjI2IDE4MiwxMzMwIDI3NSwxNDA2IDM2OCwxNDgyIDQ5NiwxNTIwIDY1OSwxNTIwIDcyOSwx
NTIwIDgwMCwxNTE0IDg3MywxNTAxIDk0NiwxNDg4IDEwMjAsMTQ2OSAxMDk2LDE0NDQgWiIvPgog
ICA8Z2x5cGggdW5pY29kZT0iTCIgaG9yaXotYWR2LXg9Ijk1NCIgZD0iTSAyMDEsMTQ5MyBMIDQw
MywxNDkzIDQwMywxNzAgMTEzMCwxNzAgMTEzMCwwIDIwMSwwIDIwMSwxNDkzIFoiLz4KICAgPGds
eXBoIHVuaWNvZGU9IjoiIGhvcml6LWFkdi14PSIyMTMiIGQ9Ik0gMjQwLDI1NCBMIDQ1MSwyNTQg
NDUxLDAgMjQwLDAgMjQwLDI1NCBaIE0gMjQwLDEwNTkgTCA0NTEsMTA1OSA0NTEsODA1IDI0MCw4
MDUgMjQwLDEwNTkgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iMyIgaG9yaXotYWR2LXg9IjEwMDci
IGQ9Ik0gODMxLDgwNSBDIDkyOCw3ODQgMTAwMyw3NDEgMTA1OCw2NzYgMTExMiw2MTEgMTEzOSw1
MzAgMTEzOSw0MzQgMTEzOSwyODcgMTA4OCwxNzMgOTg3LDkyIDg4NiwxMSA3NDIsLTI5IDU1NSwt
MjkgNDkyLC0yOSA0MjgsLTIzIDM2MiwtMTEgMjk1LDIgMjI3LDIwIDE1Niw0NSBMIDE1NiwyNDAg
QyAyMTIsMjA3IDI3MywxODMgMzQwLDE2NiA0MDcsMTQ5IDQ3NiwxNDEgNTQ5LDE0MSA2NzYsMTQx
IDc3MiwxNjYgODM5LDIxNiA5MDUsMjY2IDkzOCwzMzkgOTM4LDQzNCA5MzgsNTIyIDkwNyw1OTEg
ODQ2LDY0MSA3ODQsNjkwIDY5OCw3MTUgNTg4LDcxNSBMIDQxNCw3MTUgNDE0LDg4MSA1OTYsODgx
IEMgNjk1LDg4MSA3NzEsOTAxIDgyNCw5NDEgODc3LDk4MCA5MDMsMTAzNyA5MDMsMTExMiA5MDMs
MTE4OSA4NzYsMTI0OCA4MjIsMTI4OSA3NjcsMTMzMCA2ODksMTM1MCA1ODgsMTM1MCA1MzMsMTM1
MCA0NzMsMTM0NCA0MTAsMTMzMiAzNDcsMTMyMCAyNzcsMTMwMSAyMDEsMTI3NiBMIDIwMSwxNDU2
IEMgMjc4LDE0NzcgMzUwLDE0OTMgNDE3LDE1MDQgNDg0LDE1MTUgNTQ3LDE1MjAgNjA2LDE1MjAg
NzU5LDE1MjAgODgxLDE0ODUgOTcwLDE0MTYgMTA1OSwxMzQ2IDExMDQsMTI1MiAxMTA0LDExMzMg
MTEwNCwxMDUwIDEwODAsOTgxIDEwMzMsOTI0IDk4Niw4NjcgOTE4LDgyNyA4MzEsODA1IFoiLz4K
ICAgPGdseXBoIHVuaWNvZGU9IjIiIGhvcml6LWFkdi14PSI5ODAiIGQ9Ik0gMzkzLDE3MCBMIDEw
OTgsMTcwIDEwOTgsMCAxNTAsMCAxNTAsMTcwIEMgMjI3LDI0OSAzMzEsMzU2IDQ2NCw0OTAgNTk2
LDYyMyA2NzksNzA5IDcxMyw3NDggNzc4LDgyMSA4MjMsODgyIDg0OSw5MzMgODc0LDk4MyA4ODcs
MTAzMiA4ODcsMTA4MSA4ODcsMTE2MCA4NTksMTIyNSA4MDQsMTI3NSA3NDgsMTMyNSA2NzUsMTM1
MCA1ODYsMTM1MCA1MjMsMTM1MCA0NTYsMTMzOSAzODYsMTMxNyAzMTUsMTI5NSAyNDAsMTI2MiAx
NjAsMTIxNyBMIDE2MCwxNDIxIEMgMjQxLDE0NTQgMzE3LDE0NzggMzg4LDE0OTUgNDU5LDE1MTIg
NTIzLDE1MjAgNTgyLDE1MjAgNzM3LDE1MjAgODYwLDE0ODEgOTUyLDE0MDQgMTA0NCwxMzI3IDEw
OTAsMTIyMyAxMDkwLDEwOTQgMTA5MCwxMDMzIDEwNzksOTc1IDEwNTYsOTIwIDEwMzMsODY1IDk5
MSw4MDAgOTMwLDcyNSA5MTMsNzA2IDg2MCw2NTAgNzcxLDU1OCA2ODIsNDY1IDU1NiwzMzYgMzkz
LDE3MCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSIxIiBob3Jpei1hZHYteD0iOTAwIiBkPSJNIDI1
NCwxNzAgTCA1ODQsMTcwIDU4NCwxMzA5IDIyNSwxMjM3IDIyNSwxNDIxIDU4MiwxNDkzIDc4NCwx
NDkzIDc4NCwxNzAgMTExNCwxNzAgMTExNCwwIDI1NCwwIDI1NCwxNzAgWiIvPgogICA8Z2x5cGgg
dW5pY29kZT0iLCIgaG9yaXotYWR2LXg9IjMxOSIgZD0iTSAyNDAsMjU0IEwgNDUxLDI1NCA0NTEs
ODIgMjg3LC0yMzggMTU4LC0yMzggMjQwLDgyIDI0MCwyNTQgWiIvPgogICA8Z2x5cGggdW5pY29k
ZT0iKSIgaG9yaXotYWR2LXg9IjQ3NyIgZD0iTSAxNjQsMTU1NCBMIDMyNCwxNTU0IEMgNDI0LDEz
OTcgNDk5LDEyNDMgNTQ5LDEwOTIgNTk4LDk0MSA2MjMsNzkyIDYyMyw2NDMgNjIzLDQ5NCA1OTgs
MzQzIDU0OSwxOTIgNDk5LDQxIDQyNCwtMTEzIDMyNCwtMjcwIEwgMTY0LC0yNzAgQyAyNTMsLTEx
NyAzMTksMzUgMzYzLDE4NiA0MDYsMzM3IDQyOCw0ODkgNDI4LDY0MyA0MjgsNzk3IDQwNiw5NDkg
MzYzLDEwOTkgMzE5LDEyNDkgMjUzLDE0MDEgMTY0LDE1NTQgWiIvPgogICA8Z2x5cGggdW5pY29k
ZT0iKCIgaG9yaXotYWR2LXg9IjQ3NyIgZD0iTSA2MzUsMTU1NCBDIDU0NiwxNDAxIDQ3OSwxMjQ5
IDQzNiwxMDk5IDM5Myw5NDkgMzcxLDc5NyAzNzEsNjQzIDM3MSw0ODkgMzkzLDMzNyA0MzcsMTg2
IDQ4MCwzNSA1NDYsLTExNyA2MzUsLTI3MCBMIDQ3NSwtMjcwIEMgMzc1LC0xMTMgMzAwLDQxIDI1
MSwxOTIgMjAxLDM0MyAxNzYsNDk0IDE3Niw2NDMgMTc2LDc5MiAyMDEsOTQxIDI1MCwxMDkyIDI5
OSwxMjQzIDM3NCwxMzk3IDQ3NSwxNTU0IEwgNjM1LDE1NTQgWiIvPgogICA8Z2x5cGggdW5pY29k
ZT0iICIgaG9yaXotYWR2LXg9IjYzNSIvPgogIDwvZm9udD4KIDwvZGVmcz4KIDxkZWZzIGNsYXNz
PSJUZXh0U2hhcGVJbmRleCI+CiAgPGcgb29vOnNsaWRlPSJpZDEiIG9vbzppZC1saXN0PSJpZDMg
aWQ0IGlkNSBpZDYgaWQ3IGlkOCBpZDkiLz4KIDwvZGVmcz4KIDxkZWZzIGNsYXNzPSJFbWJlZGRl
ZEJ1bGxldENoYXJzIj4KICA8ZyBpZD0iYnVsbGV0LWNoYXItdGVtcGxhdGUoNTczNTYpIiB0cmFu
c2Zvcm09InNjYWxlKDAuMDAwNDg4MjgxMjUsLTAuMDAwNDg4MjgxMjUpIj4KICAgPHBhdGggZD0i
TSA1ODAsMTE0MSBMIDExNjMsNTcxIDU4MCwwIC00LDU3MSA1ODAsMTE0MSBaIi8+CiAgPC9nPgog
IDxnIGlkPSJidWxsZXQtY2hhci10ZW1wbGF0ZSg1NzM1NCkiIHRyYW5zZm9ybT0ic2NhbGUoMC4w
MDA0ODgyODEyNSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBkPSJNIDgsMTEyOCBMIDExMzcs
MTEyOCAxMTM3LDAgOCwwIDgsMTEyOCBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxsZXQtY2hhci10
ZW1wbGF0ZSgxMDE0NikiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgy
ODEyNSkiPgogICA8cGF0aCBkPSJNIDE3NCwwIEwgNjAyLDczOSAxNzQsMTQ4MSAxNDU2LDczOSAx
NzQsMCBaIE0gMTM1OCw3MzkgTCAzMDksMTM0NiA2NTksNzM5IDEzNTgsNzM5IFoiLz4KICA8L2c+
CiAgPGcgaWQ9ImJ1bGxldC1jaGFyLXRlbXBsYXRlKDEwMTMyKSIgdHJhbnNmb3JtPSJzY2FsZSgw
LjAwMDQ4ODI4MTI1LC0wLjAwMDQ4ODI4MTI1KSI+CiAgIDxwYXRoIGQ9Ik0gMjAxNSw3MzkgTCAx
Mjc2LDAgNzE3LDAgMTI2MCw1NDMgMTc0LDU0MyAxNzQsOTM2IDEyNjAsOTM2IDcxNywxNDgxIDEy
NzQsMTQ4MSAyMDE1LDczOSBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxsZXQtY2hhci10ZW1wbGF0
ZSgxMDAwNykiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgyODEyNSki
PgogICA8cGF0aCBkPSJNIDAsLTIgQyAtNywxNCAtMTYsMjcgLTI1LDM3IEwgMzU2LDU2NyBDIDI2
Miw4MjMgMjE1LDk1MiAyMTUsOTU0IDIxNSw5NzkgMjI4LDk5MiAyNTUsOTkyIDI2NCw5OTIgMjc2
LDk5MCAyODksOTg3IDMxMCw5OTEgMzMxLDk5OSAzNTQsMTAxMiBMIDM4MSw5OTkgNDkyLDc0OCA3
NzIsMTA0OSA4MzYsMTAyNCA4NjAsMTA0OSBDIDg4MSwxMDM5IDkwMSwxMDI1IDkyMiwxMDA2IDg4
Niw5MzcgODM1LDg2MyA3NzAsNzg0IDc2OSw3ODMgNzEwLDcxNiA1OTQsNTg0IEwgNzc0LDIyMyBD
IDc3NCwxOTYgNzUzLDE2OCA3MTEsMTM5IEwgNzI3LDExOSBDIDcxNyw5MCA2OTksNzYgNjcyLDc2
IDY0MSw3NiA1NzAsMTc4IDQ1NywzODEgTCAxNjQsLTc2IEMgMTQyLC0xMTAgMTExLC0xMjcgNzIs
LTEyNyAzMCwtMTI3IDksLTExMCA4LC03NiAxLC02NyAtMiwtNTIgLTIsLTMyIC0yLC0yMyAtMSwt
MTMgMCwtMiBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxsZXQtY2hhci10ZW1wbGF0ZSgxMDAwNCki
IHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0
aCBkPSJNIDI4NSwtMzMgQyAxODIsLTMzIDExMSwzMCA3NCwxNTYgNTIsMjI4IDQxLDMzMyA0MSw0
NzEgNDEsNTQ5IDU1LDYxNiA4Miw2NzIgMTE2LDc0MyAxNjksNzc4IDI0MCw3NzggMjkzLDc3OCAz
MjgsNzQ3IDM0Niw2ODQgTCAzNjksNTA4IEMgMzc3LDQ0NCAzOTcsNDExIDQyOCw0MTAgTCAxMTYz
LDExMTYgQyAxMTc0LDExMjcgMTE5NiwxMTMzIDEyMjksMTEzMyAxMjcxLDExMzMgMTI5MiwxMTE4
IDEyOTIsMTA4NyBMIDEyOTIsOTY1IEMgMTI5Miw5MjkgMTI4Miw5MDEgMTI2Miw4ODEgTCA0NDIs
NDcgQyAzOTAsLTYgMzM4LC0zMyAyODUsLTMzIFoiLz4KICA8L2c+CiAgPGcgaWQ9ImJ1bGxldC1j
aGFyLXRlbXBsYXRlKDk2NzkpIiB0cmFuc2Zvcm09InNjYWxlKDAuMDAwNDg4MjgxMjUsLTAuMDAw
NDg4MjgxMjUpIj4KICAgPHBhdGggZD0iTSA4MTMsMCBDIDYzMiwwIDQ4OSw1NCAzODMsMTYxIDI3
NiwyNjggMjIzLDQxMSAyMjMsNTkyIDIyMyw3NzMgMjc2LDkxNiAzODMsMTAyMyA0ODksMTEzMCA2
MzIsMTE4NCA4MTMsMTE4NCA5OTIsMTE4NCAxMTM2LDExMzAgMTI0NSwxMDIzIDEzNTMsOTE2IDE0
MDcsNzcyIDE0MDcsNTkyIDE0MDcsNDEyIDEzNTMsMjY4IDEyNDUsMTYxIDExMzYsNTQgOTkyLDAg
ODEzLDAgWiIvPgogIDwvZz4KICA8ZyBpZD0iYnVsbGV0LWNoYXItdGVtcGxhdGUoODIyNikiIHRy
YW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBk
PSJNIDM0Niw0NTcgQyAyNzMsNDU3IDIwOSw0ODMgMTU1LDUzNSAxMDEsNTg2IDc0LDY0OSA3NCw3
MjMgNzQsNzk2IDEwMSw4NTkgMTU1LDkxMSAyMDksOTYzIDI3Myw5ODkgMzQ2LDk4OSA0MTksOTg5
IDQ4MCw5NjMgNTMxLDkxMCA1ODIsODU5IDYwOCw3OTYgNjA4LDcyMyA2MDgsNjQ4IDU4Myw1ODYg
NTMyLDUzNSA0ODIsNDgzIDQyMCw0NTcgMzQ2LDQ1NyBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxs
ZXQtY2hhci10ZW1wbGF0ZSg4MjExKSIgdHJhbnNmb3JtPSJzY2FsZSgwLjAwMDQ4ODI4MTI1LC0w
LjAwMDQ4ODI4MTI1KSI+CiAgIDxwYXRoIGQ9Ik0gLTQsNDU5IEwgMTEzNSw0NTkgMTEzNSw2MDYg
LTQsNjA2IC00LDQ1OSBaIi8+CiAgPC9nPgogPC9kZWZzPgogPGRlZnMgY2xhc3M9IlRleHRFbWJl
ZGRlZEJpdG1hcHMiLz4KIDxnIGNsYXNzPSJTbGlkZUdyb3VwIj4KICA8Zz4KICAgPGcgaWQ9Imlk
MSIgY2xhc3M9IlNsaWRlIiBjbGlwLXBhdGg9InVybCgjcHJlc2VudGF0aW9uX2NsaXBfcGF0aCki
PgogICAgPGcgY2xhc3M9IlBhZ2UiPgogICAgIDxnIGNsYXNzPSJjb20uc3VuLnN0YXIuZHJhd2lu
Zy5DdXN0b21TaGFwZSI+CiAgICAgIDxnIGlkPSJpZDMiPgogICAgICAgPHJlY3QgY2xhc3M9IkJv
dW5kaW5nQm94IiBzdHJva2U9Im5vbmUiIGZpbGw9Im5vbmUiIHg9IjE5Mzk5IiB5PSIzNjk5IiB3
aWR0aD0iNTkwMyIgaGVpZ2h0PSI5NTAzIi8+CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMTQyLDE4
MSwxNDIpIiBzdHJva2U9Im5vbmUiIGQ9Ik0gMjIzNTAsMTMyMDAgTCAxOTQwMCwxMzIwMCAxOTQw
MCwzNzAwIDI1MzAwLDM3MDAgMjUzMDAsMTMyMDAgMjIzNTAsMTMyMDAgWiIvPgogICAgICAgPHBh
dGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9Ik0gMjIzNTAsMTMyMDAg
TCAxOTQwMCwxMzIwMCAxOTQwMCwzNzAwIDI1MzAwLDM3MDAgMjUzMDAsMTMyMDAgMjIzNTAsMTMy
MDAgWiIvPgogICAgICAgPHRleHQgY2xhc3M9IlRleHRTaGFwZSI+PHRzcGFuIGNsYXNzPSJUZXh0
UGFyYWdyYXBoIiBmb250LWZhbWlseT0iRGVqYVZ1IFNhbnMsIHNhbnMtc2VyaWYiIGZvbnQtc2l6
ZT0iNjM0cHgiIGZvbnQtd2VpZ2h0PSI0MDAiPjx0c3BhbiBjbGFzcz0iVGV4dFBvc2l0aW9uIiB4
PSIyMDk2NCIgeT0iNDQxMyI+PHRzcGFuIGZpbGw9InJnYigwLDAsMCkiIHN0cm9rZT0ibm9uZSI+
U3BlaWNoZXI8L3RzcGFuPjwvdHNwYW4+PC90c3Bhbj48L3RleHQ+CiAgICAgIDwvZz4KICAgICA8
L2c+CiAgICAgPGcgY2xhc3M9ImNvbS5zdW4uc3Rhci5kcmF3aW5nLkN1c3RvbVNoYXBlIj4KICAg
ICAgPGcgaWQ9ImlkNCI+CiAgICAgICA8cmVjdCBjbGFzcz0iQm91bmRpbmdCb3giIHN0cm9rZT0i
bm9uZSIgZmlsbD0ibm9uZSIgeD0iMTkzOTkiIHk9IjYzOTkiIHdpZHRoPSI1OTAzIiBoZWlnaHQ9
IjIwMDMiLz4KICAgICAgIDxwYXRoIGZpbGw9InJnYigwLDEyOCwwKSIgc3Ryb2tlPSJub25lIiBk
PSJNIDIyMzUwLDg0MDAgTCAxOTQwMCw4NDAwIDE5NDAwLDY0MDAgMjUzMDAsNjQwMCAyNTMwMCw4
NDAwIDIyMzUwLDg0MDAgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2Io
NTIsMTAxLDE2NCkiIGQ9Ik0gMjIzNTAsODQwMCBMIDE5NDAwLDg0MDAgMTk0MDAsNjQwMCAyNTMw
MCw2NDAwIDI1MzAwLDg0MDAgMjIzNTAsODQwMCBaIi8+CiAgICAgICA8dGV4dCBjbGFzcz0iVGV4
dFNoYXBlIj48dHNwYW4gY2xhc3M9IlRleHRQYXJhZ3JhcGgiIGZvbnQtZmFtaWx5PSJEZWphVnUg
U2Fucywgc2Fucy1zZXJpZiIgZm9udC1zaXplPSI2MzRweCIgZm9udC13ZWlnaHQ9IjQwMCI+PHRz
cGFuIGNsYXNzPSJUZXh0UG9zaXRpb24iIHg9IjIwMzgwIiB5PSI3NjIwIj48dHNwYW4gZmlsbD0i
cmdiKDAsMCwwKSIgc3Ryb2tlPSJub25lIj5MaXN0ZTogMSwgMiwgMzwvdHNwYW4+PC90c3Bhbj48
L3RzcGFuPjwvdGV4dD4KICAgICAgPC9nPgogICAgIDwvZz4KICAgICA8ZyBjbGFzcz0iY29tLnN1
bi5zdGFyLmRyYXdpbmcuQ3VzdG9tU2hhcGUiPgogICAgICA8ZyBpZD0iaWQ1Ij4KICAgICAgIDxy
ZWN0IGNsYXNzPSJCb3VuZGluZ0JveCIgc3Ryb2tlPSJub25lIiBmaWxsPSJub25lIiB4PSIyODk5
IiB5PSIzNTk5IiB3aWR0aD0iOTkwNCIgaGVpZ2h0PSI5NTA0Ii8+CiAgICAgICA8cGF0aCBmaWxs
PSJyZ2IoMTE0LDE1OSwyMDcpIiBzdHJva2U9Im5vbmUiIGQ9Ik0gNDQ4MywzNjAwIEMgMzY5MSwz
NjAwIDI5MDAsNDM5MSAyOTAwLDUxODMgTCAyOTAwLDExNTE3IEMgMjkwMCwxMjMwOSAzNjkxLDEz
MTAxIDQ0ODMsMTMxMDEgTCAxMTIxNywxMzEwMSBDIDEyMDA5LDEzMTAxIDEyODAxLDEyMzA5IDEy
ODAxLDExNTE3IEwgMTI4MDEsNTE4MyBDIDEyODAxLDQzOTEgMTIwMDksMzYwMCAxMTIxNywzNjAw
IEwgNDQ4MywzNjAwIFogTSAyOTAwLDM2MDAgTCAyOTAwLDM2MDAgWiBNIDEyODAxLDEzMTAxIEwg
MTI4MDEsMTMxMDEgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2IoNTIs
MTAxLDE2NCkiIGQ9Ik0gNDQ4MywzNjAwIEMgMzY5MSwzNjAwIDI5MDAsNDM5MSAyOTAwLDUxODMg
TCAyOTAwLDExNTE3IEMgMjkwMCwxMjMwOSAzNjkxLDEzMTAxIDQ0ODMsMTMxMDEgTCAxMTIxNywx
MzEwMSBDIDEyMDA5LDEzMTAxIDEyODAxLDEyMzA5IDEyODAxLDExNTE3IEwgMTI4MDEsNTE4MyBD
IDEyODAxLDQzOTEgMTIwMDksMzYwMCAxMTIxNywzNjAwIEwgNDQ4MywzNjAwIFoiLz4KICAgICAg
IDxwYXRoIGZpbGw9Im5vbmUiIHN0cm9rZT0icmdiKDUyLDEwMSwxNjQpIiBkPSJNIDI5MDAsMzYw
MCBMIDI5MDAsMzYwMCBaIi8+CiAgICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9InJnYig1
MiwxMDEsMTY0KSIgZD0iTSAxMjgwMSwxMzEwMSBMIDEyODAxLDEzMTAxIFoiLz4KICAgICAgIDx0
ZXh0IGNsYXNzPSJUZXh0U2hhcGUiPjx0c3BhbiBjbGFzcz0iVGV4dFBhcmFncmFwaCIgZm9udC1m
YW1pbHk9IkRlamFWdSBTYW5zLCBzYW5zLXNlcmlmIiBmb250LXNpemU9IjYzNHB4IiBmb250LXdl
aWdodD0iNDAwIj48dHNwYW4gY2xhc3M9IlRleHRQb3NpdGlvbiIgeD0iNTAxMiIgeT0iNDc3NiI+
PHRzcGFuIGZpbGw9InJnYigwLDAsMCkiIHN0cm9rZT0ibm9uZSI+VmFyaWFibGVuKG5hbWVuKTwv
dHNwYW4+PC90c3Bhbj48L3RzcGFuPjwvdGV4dD4KICAgICAgPC9nPgogICAgIDwvZz4KICAgICA8
ZyBjbGFzcz0iY29tLnN1bi5zdGFyLmRyYXdpbmcuQ3VzdG9tU2hhcGUiPgogICAgICA8ZyBpZD0i
aWQ2Ij4KICAgICAgIDxyZWN0IGNsYXNzPSJCb3VuZGluZ0JveCIgc3Ryb2tlPSJub25lIiBmaWxs
PSJub25lIiB4PSI2NDk5IiB5PSI1Mzk5IiB3aWR0aD0iMzYwNCIgaGVpZ2h0PSIyMDA0Ii8+CiAg
ICAgICA8cGF0aCBmaWxsPSJyZ2IoMCw3MSwyNTUpIiBzdHJva2U9Im5vbmUiIGQ9Ik0gNjgzMyw1
NDAwIEMgNjY2Niw1NDAwIDY1MDAsNTU2NiA2NTAwLDU3MzMgTCA2NTAwLDcwNjcgQyA2NTAwLDcy
MzQgNjY2Niw3NDAxIDY4MzMsNzQwMSBMIDk3NjcsNzQwMSBDIDk5MzMsNzQwMSAxMDEwMCw3MjM0
IDEwMTAwLDcwNjcgTCAxMDEwMCw1NzMzIEMgMTAxMDAsNTU2NiA5OTMzLDU0MDAgOTc2Nyw1NDAw
IEwgNjgzMyw1NDAwIFogTSA2NTAwLDU0MDAgTCA2NTAwLDU0MDAgWiBNIDEwMTAxLDc0MDEgTCAx
MDEwMSw3NDAxIFoiLz4KICAgICAgIDxwYXRoIGZpbGw9Im5vbmUiIHN0cm9rZT0icmdiKDUyLDEw
MSwxNjQpIiBkPSJNIDY4MzMsNTQwMCBDIDY2NjYsNTQwMCA2NTAwLDU1NjYgNjUwMCw1NzMzIEwg
NjUwMCw3MDY3IEMgNjUwMCw3MjM0IDY2NjYsNzQwMSA2ODMzLDc0MDEgTCA5NzY3LDc0MDEgQyA5
OTMzLDc0MDEgMTAxMDAsNzIzNCAxMDEwMCw3MDY3IEwgMTAxMDAsNTczMyBDIDEwMTAwLDU1NjYg
OTkzMyw1NDAwIDk3NjcsNTQwMCBMIDY4MzMsNTQwMCBaIi8+CiAgICAgICA8cGF0aCBmaWxsPSJu
b25lIiBzdHJva2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSA2NTAwLDU0MDAgTCA2NTAwLDU0MDAg
WiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9
Ik0gMTAxMDEsNzQwMSBMIDEwMTAxLDc0MDEgWiIvPgogICAgICAgPHRleHQgY2xhc3M9IlRleHRT
aGFwZSI+PHRzcGFuIGNsYXNzPSJUZXh0UGFyYWdyYXBoIiBmb250LWZhbWlseT0iRGVqYVZ1IFNh
bnMsIHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iNjM0cHgiIGZvbnQtd2VpZ2h0PSI0MDAiPjx0c3Bh
biBjbGFzcz0iVGV4dFBvc2l0aW9uIiB4PSI4MTEyIiB5PSI2NjIwIj48dHNwYW4gZmlsbD0icmdi
KDAsMCwwKSIgc3Ryb2tlPSJub25lIj54PC90c3Bhbj48L3RzcGFuPjwvdHNwYW4+PC90ZXh0Pgog
ICAgICA8L2c+CiAgICAgPC9nPgogICAgIDxnIGNsYXNzPSJjb20uc3VuLnN0YXIuZHJhd2luZy5D
b25uZWN0b3JTaGFwZSI+CiAgICAgIDxnIGlkPSJpZDciPgogICAgICAgPHJlY3QgY2xhc3M9IkJv
dW5kaW5nQm94IiBzdHJva2U9Im5vbmUiIGZpbGw9Im5vbmUiIHg9IjEwMDY0IiB5PSI2MzY0IiB3
aWR0aD0iOTMzNyIgaGVpZ2h0PSIxMjM3Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJv
a2U9InJnYigwLDAsMCkiIHN0cm9rZS13aWR0aD0iNzEiIHN0cm9rZS1saW5lam9pbj0icm91bmQi
IGQ9Ik0gMTAxMDAsNjQwMCBDIDE3MDc2LDY0MDAgMTI3MjAsNzMzNSAxODc1MCw3Mzk3Ii8+CiAg
ICAgICA8cGF0aCBmaWxsPSJyZ2IoMCwwLDApIiBzdHJva2U9Im5vbmUiIGQ9Ik0gMTk0MDAsNzQw
MCBMIDE4NzkyLDcxOTQgMTg3OTAsNzYwMCAxOTQwMCw3NDAwIFoiLz4KICAgICAgPC9nPgogICAg
IDwvZz4KICAgICA8ZyBjbGFzcz0iY29tLnN1bi5zdGFyLmRyYXdpbmcuQ3VzdG9tU2hhcGUiPgog
ICAgICA8ZyBpZD0iaWQ4Ij4KICAgICAgIDxyZWN0IGNsYXNzPSJCb3VuZGluZ0JveCIgc3Ryb2tl
PSJub25lIiBmaWxsPSJub25lIiB4PSI2NDk5IiB5PSI5MDk5IiB3aWR0aD0iMzYwNCIgaGVpZ2h0
PSIyMDA0Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMCw3MSwyNTUpIiBzdHJva2U9Im5vbmUi
IGQ9Ik0gNjgzMyw5MTAwIEMgNjY2Niw5MTAwIDY1MDAsOTI2NiA2NTAwLDk0MzMgTCA2NTAwLDEw
NzY3IEMgNjUwMCwxMDkzNCA2NjY2LDExMTAxIDY4MzMsMTExMDEgTCA5NzY3LDExMTAxIEMgOTkz
MywxMTEwMSAxMDEwMCwxMDkzNCAxMDEwMCwxMDc2NyBMIDEwMTAwLDk0MzMgQyAxMDEwMCw5MjY2
IDk5MzMsOTEwMCA5NzY3LDkxMDAgTCA2ODMzLDkxMDAgWiBNIDY1MDAsOTEwMCBMIDY1MDAsOTEw
MCBaIE0gMTAxMDEsMTExMDEgTCAxMDEwMSwxMTEwMSBaIi8+CiAgICAgICA8cGF0aCBmaWxsPSJu
b25lIiBzdHJva2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSA2ODMzLDkxMDAgQyA2NjY2LDkxMDAg
NjUwMCw5MjY2IDY1MDAsOTQzMyBMIDY1MDAsMTA3NjcgQyA2NTAwLDEwOTM0IDY2NjYsMTExMDEg
NjgzMywxMTEwMSBMIDk3NjcsMTExMDEgQyA5OTMzLDExMTAxIDEwMTAwLDEwOTM0IDEwMTAwLDEw
NzY3IEwgMTAxMDAsOTQzMyBDIDEwMTAwLDkyNjYgOTkzMyw5MTAwIDk3NjcsOTEwMCBMIDY4MzMs
OTEwMCBaIi8+CiAgICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9InJnYig1MiwxMDEsMTY0
KSIgZD0iTSA2NTAwLDkxMDAgTCA2NTAwLDkxMDAgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9u
ZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9Ik0gMTAxMDEsMTExMDEgTCAxMDEwMSwxMTEw
MSBaIi8+CiAgICAgICA8dGV4dCBjbGFzcz0iVGV4dFNoYXBlIj48dHNwYW4gY2xhc3M9IlRleHRQ
YXJhZ3JhcGgiIGZvbnQtZmFtaWx5PSJEZWphVnUgU2Fucywgc2Fucy1zZXJpZiIgZm9udC1zaXpl
PSI2MzRweCIgZm9udC13ZWlnaHQ9IjQwMCI+PHRzcGFuIGNsYXNzPSJUZXh0UG9zaXRpb24iIHg9
IjgxMTIiIHk9IjEwMzIwIj48dHNwYW4gZmlsbD0icmdiKDAsMCwwKSIgc3Ryb2tlPSJub25lIj55
PC90c3Bhbj48L3RzcGFuPjwvdHNwYW4+PC90ZXh0PgogICAgICA8L2c+CiAgICAgPC9nPgogICAg
IDxnIGNsYXNzPSJjb20uc3VuLnN0YXIuZHJhd2luZy5Db25uZWN0b3JTaGFwZSI+CiAgICAgIDxn
IGlkPSJpZDkiPgogICAgICAgPHJlY3QgY2xhc3M9IkJvdW5kaW5nQm94IiBzdHJva2U9Im5vbmUi
IGZpbGw9Im5vbmUiIHg9IjEwMDY0IiB5PSI3MjA1IiB3aWR0aD0iOTMzNyIgaGVpZ2h0PSIyOTMy
Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9InJnYigwLDAsMCkiIHN0cm9rZS13
aWR0aD0iNzEiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0gMTAxMDAsMTAxMDAgQyAxNzA3
NiwxMDEwMCAxMjcxNSw3NTcxIDE4NzYxLDc0MDgiLz4KICAgICAgIDxwYXRoIGZpbGw9InJnYigw
LDAsMCkiIHN0cm9rZT0ibm9uZSIgZD0iTSAxOTQwMCw3NDAwIEwgMTg3ODgsNzIwNSAxODc5NCw3
NjExIDE5NDAwLDc0MDAgWiIvPgogICAgICA8L2c+CiAgICAgPC9nPgogICAgPC9nPgogICA8L2c+
CiAgPC9nPgogPC9nPgo8L3N2Zz4=""", MIME("image/svg"), (:height => 240,))
Bilder["xy_changed_ref"] = PlutoUI.Resource(
	"""data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPCFET0NUWVBFIHN2ZyBQVUJM
SUMgIi0vL1czQy8vRFREIFNWRyAxLjEvL0VOIiAiaHR0cDovL3d3dy53My5vcmcvR3JhcGhpY3Mv
U1ZHLzEuMS9EVEQvc3ZnMTEuZHRkIj4KPHN2ZyB2ZXJzaW9uPSIxLjIiIHdpZHRoPSIyMjQuMDFt
bSIgaGVpZ2h0PSI5Ni4wMW1tIiB2aWV3Qm94PSIyOTAwIDM1OTkgMjI0MDEgOTYwMSIgcHJlc2Vy
dmVBc3BlY3RSYXRpbz0ieE1pZFlNaWQiIGZpbGwtcnVsZT0iZXZlbm9kZCIgc3Ryb2tlLXdpZHRo
PSIyOC4yMjIiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9y
Zy8yMDAwL3N2ZyIgeG1sbnM6b29vPSJodHRwOi8veG1sLm9wZW5vZmZpY2Uub3JnL3N2Zy9leHBv
cnQiIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4bWxuczpwcmVz
ZW50YXRpb249Imh0dHA6Ly9zdW4uY29tL3htbG5zL3N0YXJvZmZpY2UvcHJlc2VudGF0aW9uIiB4
bWxuczpzbWlsPSJodHRwOi8vd3d3LnczLm9yZy8yMDAxL1NNSUwyMC8iIHhtbG5zOmFuaW09InVy
bjpvYXNpczpuYW1lczp0YzpvcGVuZG9jdW1lbnQ6eG1sbnM6YW5pbWF0aW9uOjEuMCIgeG1sOnNw
YWNlPSJwcmVzZXJ2ZSI+CiA8ZGVmcyBjbGFzcz0iQ2xpcFBhdGhHcm91cCI+CiAgPGNsaXBQYXRo
IGlkPSJwcmVzZW50YXRpb25fY2xpcF9wYXRoIiBjbGlwUGF0aFVuaXRzPSJ1c2VyU3BhY2VPblVz
ZSI+CiAgIDxyZWN0IHg9IjI5MDAiIHk9IjM1OTkiIHdpZHRoPSIyMjQwMSIgaGVpZ2h0PSI5NjAx
Ii8+CiAgPC9jbGlwUGF0aD4KIDwvZGVmcz4KIDxkZWZzPgogIDxmb250IGlkPSJFbWJlZGRlZEZv
bnRfMSIgaG9yaXotYWR2LXg9IjIwNDgiPgogICA8Zm9udC1mYWNlIGZvbnQtZmFtaWx5PSJEZWph
VnUgU2FucyBlbWJlZGRlZCIgdW5pdHMtcGVyLWVtPSIyMDQ4IiBmb250LXdlaWdodD0ibm9ybWFs
IiBmb250LXN0eWxlPSJub3JtYWwiIGFzY2VudD0iMTg3OSIgZGVzY2VudD0iNDc2Ii8+CiAgIDxt
aXNzaW5nLWdseXBoIGhvcml6LWFkdi14PSIyMDQ4IiBkPSJNIDAsMCBMIDIwNDcsMCAyMDQ3LDIw
NDcgMCwyMDQ3IDAsMCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJ5IiBob3Jpei1hZHYteD0iMTEx
MiIgZD0iTSA2NTksLTEwNCBDIDYwNywtMjM3IDU1NiwtMzI0IDUwNywtMzY1IDQ1OCwtNDA2IDM5
MiwtNDI2IDMwOSwtNDI2IEwgMTYyLC00MjYgMTYyLC0yNzIgMjcwLC0yNzIgQyAzMjEsLTI3MiAz
NjAsLTI2MCAzODgsLTIzNiA0MTYsLTIxMiA0NDcsLTE1NSA0ODEsLTY2IEwgNTE0LDE4IDYxLDEx
MjAgMjU2LDExMjAgNjA2LDI0NCA5NTYsMTEyMCAxMTUxLDExMjAgNjU5LC0xMDQgWiIvPgogICA8
Z2x5cGggdW5pY29kZT0ieCIgaG9yaXotYWR2LXg9IjExMTIiIGQ9Ik0gMTEyNCwxMTIwIEwgNzE5
LDU3NSAxMTQ1LDAgOTI4LDAgNjAyLDQ0MCAyNzYsMCA1OSwwIDQ5NCw1ODYgOTYsMTEyMCAzMTMs
MTEyMCA2MTAsNzIxIDkwNywxMTIwIDExMjQsMTEyMCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJ0
IiBob3Jpei1hZHYteD0iNzE1IiBkPSJNIDM3NSwxNDM4IEwgMzc1LDExMjAgNzU0LDExMjAgNzU0
LDk3NyAzNzUsOTc3IDM3NSwzNjkgQyAzNzUsMjc4IDM4OCwyMTkgNDEzLDE5MyA0MzgsMTY3IDQ4
OCwxNTQgNTY1LDE1NCBMIDc1NCwxNTQgNzU0LDAgNTY1LDAgQyA0MjMsMCAzMjUsMjcgMjcxLDgw
IDIxNywxMzMgMTkwLDIyOSAxOTAsMzY5IEwgMTkwLDk3NyA1NSw5NzcgNTUsMTEyMCAxOTAsMTEy
MCAxOTAsMTQzOCAzNzUsMTQzOCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJzIiBob3Jpei1hZHYt
eD0iODc0IiBkPSJNIDkwNywxMDg3IEwgOTA3LDkxMyBDIDg1NSw5NDAgODAxLDk2MCA3NDUsOTcz
IDY4OSw5ODYgNjMxLDk5MyA1NzEsOTkzIDQ4MCw5OTMgNDExLDk3OSAzNjYsOTUxIDMyMCw5MjMg
Mjk3LDg4MSAyOTcsODI1IDI5Nyw3ODIgMzEzLDc0OSAzNDYsNzI1IDM3OSw3MDAgNDQ0LDY3NyA1
NDMsNjU1IEwgNjA2LDY0MSBDIDczNyw2MTMgODMwLDU3NCA4ODUsNTIzIDk0MCw0NzIgOTY3LDQw
MCA5NjcsMzA5IDk2NywyMDUgOTI2LDEyMyA4NDQsNjIgNzYxLDEgNjQ4LC0yOSA1MDQsLTI5IDQ0
NCwtMjkgMzgyLC0yMyAzMTcsLTEyIDI1MiwwIDE4MywxOCAxMTEsNDEgTCAxMTEsMjMxIEMgMTc5
LDE5NiAyNDYsMTY5IDMxMiwxNTIgMzc4LDEzNCA0NDMsMTI1IDUwOCwxMjUgNTk1LDEyNSA2NjEs
MTQwIDcwOCwxNzAgNzU1LDE5OSA3NzgsMjQxIDc3OCwyOTUgNzc4LDM0NSA3NjEsMzgzIDcyOCw0
MTAgNjk0LDQzNyA2MjAsNDYyIDUwNiw0ODcgTCA0NDIsNTAyIEMgMzI4LDUyNiAyNDYsNTYzIDE5
NSw2MTMgMTQ0LDY2MiAxMTksNzMwIDExOSw4MTcgMTE5LDkyMiAxNTYsMTAwNCAyMzEsMTA2MSAz
MDYsMTExOCA0MTIsMTE0NyA1NDksMTE0NyA2MTcsMTE0NyA2ODEsMTE0MiA3NDEsMTEzMiA4MDEs
MTEyMiA4NTYsMTEwNyA5MDcsMTA4NyBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSJyIiBob3Jpei1h
ZHYteD0iNjYzIiBkPSJNIDg0Miw5NDggQyA4MjEsOTYwIDc5OSw5NjkgNzc1LDk3NSA3NTAsOTgw
IDcyMyw5ODMgNjk0LDk4MyA1OTAsOTgzIDUxMCw5NDkgNDU1LDg4MiAzOTksODE0IDM3MSw3MTcg
MzcxLDU5MCBMIDM3MSwwIDE4NiwwIDE4NiwxMTIwIDM3MSwxMTIwIDM3MSw5NDYgQyA0MTAsMTAx
NCA0NjAsMTA2NSA1MjIsMTA5OCA1ODQsMTEzMSA2NTksMTE0NyA3NDgsMTE0NyA3NjEsMTE0NyA3
NzUsMTE0NiA3OTAsMTE0NSA4MDUsMTE0MyA4MjIsMTE0MCA4NDEsMTEzNyBMIDg0Miw5NDggWiIv
PgogICA8Z2x5cGggdW5pY29kZT0icCIgaG9yaXotYWR2LXg9IjEwMDciIGQ9Ik0gMzcxLDE2OCBM
IDM3MSwtNDI2IDE4NiwtNDI2IDE4NiwxMTIwIDM3MSwxMTIwIDM3MSw5NTAgQyA0MTAsMTAxNyA0
NTksMTA2NiA1MTgsMTA5OSA1NzcsMTEzMSA2NDcsMTE0NyA3MjksMTE0NyA4NjUsMTE0NyA5NzYs
MTA5MyAxMDYxLDk4NSAxMTQ2LDg3NyAxMTg4LDczNSAxMTg4LDU1OSAxMTg4LDM4MyAxMTQ2LDI0
MSAxMDYxLDEzMyA5NzYsMjUgODY1LC0yOSA3MjksLTI5IDY0NywtMjkgNTc3LC0xMyA1MTgsMjAg
NDU5LDUyIDQxMCwxMDEgMzcxLDE2OCBaIE0gOTk3LDU1OSBDIDk5Nyw2OTQgOTY5LDgwMSA5MTQs
ODc4IDg1OCw5NTUgNzgxLDk5MyA2ODQsOTkzIDU4Nyw5OTMgNTEwLDk1NSA0NTUsODc4IDM5OSw4
MDEgMzcxLDY5NCAzNzEsNTU5IDM3MSw0MjQgMzk5LDMxOCA0NTUsMjQxIDUxMCwxNjQgNTg3LDEy
NSA2ODQsMTI1IDc4MSwxMjUgODU4LDE2NCA5MTQsMjQxIDk2OSwzMTggOTk3LDQyNCA5OTcsNTU5
IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9Im4iIGhvcml6LWFkdi14PSI5NTQiIGQ9Ik0gMTEyNCw2
NzYgTCAxMTI0LDAgOTQwLDAgOTQwLDY3MCBDIDk0MCw3NzYgOTE5LDg1NSA4NzgsOTA4IDgzNyw5
NjEgNzc1LDk4NyA2OTIsOTg3IDU5Myw5ODcgNTE0LDk1NSA0NTcsODkyIDQwMCw4MjkgMzcxLDc0
MiAzNzEsNjMzIEwgMzcxLDAgMTg2LDAgMTg2LDExMjAgMzcxLDExMjAgMzcxLDk0NiBDIDQxNSwx
MDEzIDQ2NywxMDY0IDUyNywxMDk3IDU4NiwxMTMwIDY1NSwxMTQ3IDczMywxMTQ3IDg2MiwxMTQ3
IDk1OSwxMTA3IDEwMjUsMTAyOCAxMDkxLDk0OCAxMTI0LDgzMSAxMTI0LDY3NiBaIi8+CiAgIDxn
bHlwaCB1bmljb2RlPSJtIiBob3Jpei1hZHYteD0iMTY0MiIgZD0iTSAxMDY1LDkwNSBDIDExMTEs
OTg4IDExNjYsMTA0OSAxMjMwLDEwODggMTI5NCwxMTI3IDEzNjksMTE0NyAxNDU2LDExNDcgMTU3
MywxMTQ3IDE2NjMsMTEwNiAxNzI2LDEwMjUgMTc4OSw5NDMgMTgyMSw4MjcgMTgyMSw2NzYgTCAx
ODIxLDAgMTYzNiwwIDE2MzYsNjcwIEMgMTYzNiw3NzcgMTYxNyw4NTcgMTU3OSw5MDkgMTU0MSw5
NjEgMTQ4Myw5ODcgMTQwNSw5ODcgMTMxMCw5ODcgMTIzNCw5NTUgMTE3OSw4OTIgMTEyNCw4Mjkg
MTA5Niw3NDIgMTA5Niw2MzMgTCAxMDk2LDAgOTExLDAgOTExLDY3MCBDIDkxMSw3NzggODkyLDg1
OCA4NTQsOTEwIDgxNiw5NjEgNzU3LDk4NyA2NzgsOTg3IDU4NCw5ODcgNTA5LDk1NSA0NTQsODky
IDM5OSw4MjggMzcxLDc0MiAzNzEsNjMzIEwgMzcxLDAgMTg2LDAgMTg2LDExMjAgMzcxLDExMjAg
MzcxLDk0NiBDIDQxMywxMDE1IDQ2MywxMDY1IDUyMiwxMDk4IDU4MSwxMTMxIDY1MCwxMTQ3IDcz
MSwxMTQ3IDgxMiwxMTQ3IDg4MiwxMTI2IDkzOSwxMDg1IDk5NiwxMDQ0IDEwMzgsOTg0IDEwNjUs
OTA1IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9ImwiIGhvcml6LWFkdi14PSIyMTMiIGQ9Ik0gMTkz
LDE1NTYgTCAzNzcsMTU1NiAzNzcsMCAxOTMsMCAxOTMsMTU1NiBaIi8+CiAgIDxnbHlwaCB1bmlj
b2RlPSJpIiBob3Jpei1hZHYteD0iMjEzIiBkPSJNIDE5MywxMTIwIEwgMzc3LDExMjAgMzc3LDAg
MTkzLDAgMTkzLDExMjAgWiBNIDE5MywxNTU2IEwgMzc3LDE1NTYgMzc3LDEzMjMgMTkzLDEzMjMg
MTkzLDE1NTYgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iaCIgaG9yaXotYWR2LXg9Ijk1NCIgZD0i
TSAxMTI0LDY3NiBMIDExMjQsMCA5NDAsMCA5NDAsNjcwIEMgOTQwLDc3NiA5MTksODU1IDg3OCw5
MDggODM3LDk2MSA3NzUsOTg3IDY5Miw5ODcgNTkzLDk4NyA1MTQsOTU1IDQ1Nyw4OTIgNDAwLDgy
OSAzNzEsNzQyIDM3MSw2MzMgTCAzNzEsMCAxODYsMCAxODYsMTU1NiAzNzEsMTU1NiAzNzEsOTQ2
IEMgNDE1LDEwMTMgNDY3LDEwNjQgNTI3LDEwOTcgNTg2LDExMzAgNjU1LDExNDcgNzMzLDExNDcg
ODYyLDExNDcgOTU5LDExMDcgMTAyNSwxMDI4IDEwOTEsOTQ4IDExMjQsODMxIDExMjQsNjc2IFoi
Lz4KICAgPGdseXBoIHVuaWNvZGU9ImUiIGhvcml6LWFkdi14PSIxMDU5IiBkPSJNIDExNTEsNjA2
IEwgMTE1MSw1MTYgMzA1LDUxNiBDIDMxMywzODkgMzUxLDI5MyA0MjAsMjI3IDQ4OCwxNjAgNTgz
LDEyNyA3MDUsMTI3IDc3NiwxMjcgODQ0LDEzNiA5MTEsMTUzIDk3NywxNzAgMTA0MywxOTYgMTEw
OCwyMzEgTCAxMTA4LDU3IEMgMTA0MiwyOSA5NzQsOCA5MDUsLTcgODM2LC0yMiA3NjUsLTI5IDY5
NCwtMjkgNTE1LC0yOSAzNzQsMjMgMjcwLDEyNyAxNjUsMjMxIDExMywzNzIgMTEzLDU0OSAxMTMs
NzMyIDE2Myw4NzggMjYyLDk4NiAzNjEsMTA5MyA0OTQsMTE0NyA2NjIsMTE0NyA4MTMsMTE0NyA5
MzIsMTA5OSAxMDIwLDEwMDIgMTEwNyw5MDUgMTE1MSw3NzMgMTE1MSw2MDYgWiBNIDk2Nyw2NTkg
QyA5NjYsNzYwIDkzOCw4NDEgODgzLDkwMSA4MjgsOTYxIDc1NSw5OTEgNjY0LDk5MSA1NjEsOTkx
IDQ3OSw5NjIgNDE4LDkwNCAzNTYsODQ2IDMyMCw3NjQgMzExLDY1OSBMIDk2Nyw2NTkgWiIvPgog
ICA8Z2x5cGggdW5pY29kZT0iYyIgaG9yaXotYWR2LXg9IjkwMCIgZD0iTSA5OTksMTA3NyBMIDk5
OSw5MDUgQyA5NDcsOTM0IDg5NSw5NTUgODQzLDk3MCA3OTAsOTg0IDczNyw5OTEgNjg0LDk5MSA1
NjUsOTkxIDQ3Miw5NTMgNDA2LDg3OCAzNDAsODAyIDMwNyw2OTYgMzA3LDU1OSAzMDcsNDIyIDM0
MCwzMTYgNDA2LDI0MSA0NzIsMTY1IDU2NSwxMjcgNjg0LDEyNyA3MzcsMTI3IDc5MCwxMzQgODQz
LDE0OSA4OTUsMTYzIDk0NywxODQgOTk5LDIxMyBMIDk5OSw0MyBDIDk0OCwxOSA4OTUsMSA4NDAs
LTExIDc4NSwtMjMgNzI2LC0yOSA2NjQsLTI5IDQ5NSwtMjkgMzYxLDI0IDI2MiwxMzAgMTYzLDIz
NiAxMTMsMzc5IDExMyw1NTkgMTEzLDc0MiAxNjMsODg1IDI2NCw5OTAgMzY0LDEwOTUgNTAxLDEx
NDcgNjc2LDExNDcgNzMzLDExNDcgNzg4LDExNDEgODQyLDExMzAgODk2LDExMTggOTQ4LDExMDAg
OTk5LDEwNzcgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iYiIgaG9yaXotYWR2LXg9IjEwMDciIGQ9
Ik0gOTk3LDU1OSBDIDk5Nyw2OTQgOTY5LDgwMSA5MTQsODc4IDg1OCw5NTUgNzgxLDk5MyA2ODQs
OTkzIDU4Nyw5OTMgNTEwLDk1NSA0NTUsODc4IDM5OSw4MDEgMzcxLDY5NCAzNzEsNTU5IDM3MSw0
MjQgMzk5LDMxOCA0NTUsMjQxIDUxMCwxNjQgNTg3LDEyNSA2ODQsMTI1IDc4MSwxMjUgODU4LDE2
NCA5MTQsMjQxIDk2OSwzMTggOTk3LDQyNCA5OTcsNTU5IFogTSAzNzEsOTUwIEMgNDEwLDEwMTcg
NDU5LDEwNjYgNTE4LDEwOTkgNTc3LDExMzEgNjQ3LDExNDcgNzI5LDExNDcgODY1LDExNDcgOTc2
LDEwOTMgMTA2MSw5ODUgMTE0Niw4NzcgMTE4OCw3MzUgMTE4OCw1NTkgMTE4OCwzODMgMTE0Niwy
NDEgMTA2MSwxMzMgOTc2LDI1IDg2NSwtMjkgNzI5LC0yOSA2NDcsLTI5IDU3NywtMTMgNTE4LDIw
IDQ1OSw1MiA0MTAsMTAxIDM3MSwxNjggTCAzNzEsMCAxODYsMCAxODYsMTU1NiAzNzEsMTU1NiAz
NzEsOTUwIFoiLz4KICAgPGdseXBoIHVuaWNvZGU9ImEiIGhvcml6LWFkdi14PSI5ODAiIGQ9Ik0g
NzAyLDU2MyBDIDU1Myw1NjMgNDUwLDU0NiAzOTMsNTEyIDMzNiw0NzggMzA3LDQyMCAzMDcsMzM4
IDMwNywyNzMgMzI5LDIyMSAzNzIsMTgzIDQxNSwxNDQgNDczLDEyNSA1NDcsMTI1IDY0OSwxMjUg
NzMxLDE2MSA3OTMsMjM0IDg1NCwzMDYgODg1LDQwMiA4ODUsNTIyIEwgODg1LDU2MyA3MDIsNTYz
IFogTSAxMDY5LDYzOSBMIDEwNjksMCA4ODUsMCA4ODUsMTcwIEMgODQzLDEwMiA3OTEsNTIgNzI4
LDIwIDY2NSwtMTMgNTg5LC0yOSA0OTgsLTI5IDM4MywtMjkgMjkyLDMgMjI1LDY4IDE1NywxMzIg
MTIzLDIxOCAxMjMsMzI2IDEyMyw0NTIgMTY1LDU0NyAyNTAsNjExIDMzNCw2NzUgNDYwLDcwNyA2
MjcsNzA3IEwgODg1LDcwNyA4ODUsNzI1IEMgODg1LDgxMCA4NTcsODc1IDgwMiw5MjIgNzQ2LDk2
OCA2NjgsOTkxIDU2Nyw5OTEgNTAzLDk5MSA0NDEsOTgzIDM4MCw5NjggMzE5LDk1MyAyNjEsOTMw
IDIwNSw4OTkgTCAyMDUsMTA2OSBDIDI3MiwxMDk1IDMzOCwxMTE1IDQwMSwxMTI4IDQ2NCwxMTQx
IDUyNiwxMTQ3IDU4NiwxMTQ3IDc0OCwxMTQ3IDg2OSwxMTA1IDk0OSwxMDIxIDEwMjksOTM3IDEw
NjksODEwIDEwNjksNjM5IFoiLz4KICAgPGdseXBoIHVuaWNvZGU9IlYiIGhvcml6LWFkdi14PSIx
NDAzIiBkPSJNIDU4NiwwIEwgMTYsMTQ5MyAyMjcsMTQ5MyA3MDAsMjM2IDExNzQsMTQ5MyAxMzg0
LDE0OTMgODE1LDAgNTg2LDAgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iUyIgaG9yaXotYWR2LXg9
IjEwNjAiIGQ9Ik0gMTA5NiwxNDQ0IEwgMTA5NiwxMjQ3IEMgMTAxOSwxMjg0IDk0NywxMzExIDg3
OSwxMzI5IDgxMSwxMzQ3IDc0NSwxMzU2IDY4MiwxMzU2IDU3MiwxMzU2IDQ4NywxMzM1IDQyOCwx
MjkyIDM2OCwxMjQ5IDMzOCwxMTg5IDMzOCwxMTEwIDMzOCwxMDQ0IDM1OCw5OTQgMzk4LDk2MSA0
MzcsOTI3IDUxMiw5MDAgNjIzLDg3OSBMIDc0NSw4NTQgQyA4OTYsODI1IDEwMDcsNzc1IDEwNzks
NzAzIDExNTAsNjMwIDExODYsNTMzIDExODYsNDEyIDExODYsMjY3IDExMzgsMTU4IDEwNDEsODMg
OTQ0LDggODAxLC0yOSA2MTQsLTI5IDU0MywtMjkgNDY4LC0yMSAzODksLTUgMzA5LDExIDIyNiwz
NSAxNDEsNjYgTCAxNDEsMjc0IEMgMjIzLDIyOCAzMDMsMTkzIDM4MiwxNzAgNDYxLDE0NyA1Mzgs
MTM1IDYxNCwxMzUgNzI5LDEzNSA4MTgsMTU4IDg4MSwyMDMgOTQ0LDI0OCA5NzUsMzEzIDk3NSwz
OTcgOTc1LDQ3MCA5NTMsNTI4IDkwOCw1NjkgODYzLDYxMCA3ODksNjQxIDY4Niw2NjIgTCA1NjMs
Njg2IEMgNDEyLDcxNiAzMDMsNzYzIDIzNiw4MjcgMTY5LDg5MSAxMzUsOTgwIDEzNSwxMDk0IDEz
NSwxMjI2IDE4MiwxMzMwIDI3NSwxNDA2IDM2OCwxNDgyIDQ5NiwxNTIwIDY1OSwxNTIwIDcyOSwx
NTIwIDgwMCwxNTE0IDg3MywxNTAxIDk0NiwxNDg4IDEwMjAsMTQ2OSAxMDk2LDE0NDQgWiIvPgog
ICA8Z2x5cGggdW5pY29kZT0iTCIgaG9yaXotYWR2LXg9Ijk1NCIgZD0iTSAyMDEsMTQ5MyBMIDQw
MywxNDkzIDQwMywxNzAgMTEzMCwxNzAgMTEzMCwwIDIwMSwwIDIwMSwxNDkzIFoiLz4KICAgPGds
eXBoIHVuaWNvZGU9IjoiIGhvcml6LWFkdi14PSIyMTMiIGQ9Ik0gMjQwLDI1NCBMIDQ1MSwyNTQg
NDUxLDAgMjQwLDAgMjQwLDI1NCBaIE0gMjQwLDEwNTkgTCA0NTEsMTA1OSA0NTEsODA1IDI0MCw4
MDUgMjQwLDEwNTkgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iMyIgaG9yaXotYWR2LXg9IjEwMDci
IGQ9Ik0gODMxLDgwNSBDIDkyOCw3ODQgMTAwMyw3NDEgMTA1OCw2NzYgMTExMiw2MTEgMTEzOSw1
MzAgMTEzOSw0MzQgMTEzOSwyODcgMTA4OCwxNzMgOTg3LDkyIDg4NiwxMSA3NDIsLTI5IDU1NSwt
MjkgNDkyLC0yOSA0MjgsLTIzIDM2MiwtMTEgMjk1LDIgMjI3LDIwIDE1Niw0NSBMIDE1NiwyNDAg
QyAyMTIsMjA3IDI3MywxODMgMzQwLDE2NiA0MDcsMTQ5IDQ3NiwxNDEgNTQ5LDE0MSA2NzYsMTQx
IDc3MiwxNjYgODM5LDIxNiA5MDUsMjY2IDkzOCwzMzkgOTM4LDQzNCA5MzgsNTIyIDkwNyw1OTEg
ODQ2LDY0MSA3ODQsNjkwIDY5OCw3MTUgNTg4LDcxNSBMIDQxNCw3MTUgNDE0LDg4MSA1OTYsODgx
IEMgNjk1LDg4MSA3NzEsOTAxIDgyNCw5NDEgODc3LDk4MCA5MDMsMTAzNyA5MDMsMTExMiA5MDMs
MTE4OSA4NzYsMTI0OCA4MjIsMTI4OSA3NjcsMTMzMCA2ODksMTM1MCA1ODgsMTM1MCA1MzMsMTM1
MCA0NzMsMTM0NCA0MTAsMTMzMiAzNDcsMTMyMCAyNzcsMTMwMSAyMDEsMTI3NiBMIDIwMSwxNDU2
IEMgMjc4LDE0NzcgMzUwLDE0OTMgNDE3LDE1MDQgNDg0LDE1MTUgNTQ3LDE1MjAgNjA2LDE1MjAg
NzU5LDE1MjAgODgxLDE0ODUgOTcwLDE0MTYgMTA1OSwxMzQ2IDExMDQsMTI1MiAxMTA0LDExMzMg
MTEwNCwxMDUwIDEwODAsOTgxIDEwMzMsOTI0IDk4Niw4NjcgOTE4LDgyNyA4MzEsODA1IFoiLz4K
ICAgPGdseXBoIHVuaWNvZGU9IjEiIGhvcml6LWFkdi14PSI5MDAiIGQ9Ik0gMjU0LDE3MCBMIDU4
NCwxNzAgNTg0LDEzMDkgMjI1LDEyMzcgMjI1LDE0MjEgNTgyLDE0OTMgNzg0LDE0OTMgNzg0LDE3
MCAxMTE0LDE3MCAxMTE0LDAgMjU0LDAgMjU0LDE3MCBaIi8+CiAgIDxnbHlwaCB1bmljb2RlPSIw
IiBob3Jpei1hZHYteD0iMTAzMyIgZD0iTSA2NTEsMTM2MCBDIDU0NywxMzYwIDQ2OSwxMzA5IDQx
NywxMjA3IDM2NCwxMTA0IDMzOCw5NTAgMzM4LDc0NSAzMzgsNTQwIDM2NCwzODcgNDE3LDI4NSA0
NjksMTgyIDU0NywxMzEgNjUxLDEzMSA3NTYsMTMxIDgzNCwxODIgODg3LDI4NSA5MzksMzg3IDk2
NSw1NDAgOTY1LDc0NSA5NjUsOTUwIDkzOSwxMTA0IDg4NywxMjA3IDgzNCwxMzA5IDc1NiwxMzYw
IDY1MSwxMzYwIFogTSA2NTEsMTUyMCBDIDgxOCwxNTIwIDk0NiwxNDU0IDEwMzUsMTMyMiAxMTIz
LDExODkgMTE2Nyw5OTcgMTE2Nyw3NDUgMTE2Nyw0OTQgMTEyMywzMDIgMTAzNSwxNzAgOTQ2LDM3
IDgxOCwtMjkgNjUxLC0yOSA0ODQsLTI5IDM1NiwzNyAyNjgsMTcwIDE3OSwzMDIgMTM1LDQ5NCAx
MzUsNzQ1IDEzNSw5OTcgMTc5LDExODkgMjY4LDEzMjIgMzU2LDE0NTQgNDg0LDE1MjAgNjUxLDE1
MjAgWiIvPgogICA8Z2x5cGggdW5pY29kZT0iLCIgaG9yaXotYWR2LXg9IjMxOSIgZD0iTSAyNDAs
MjU0IEwgNDUxLDI1NCA0NTEsODIgMjg3LC0yMzggMTU4LC0yMzggMjQwLDgyIDI0MCwyNTQgWiIv
PgogICA8Z2x5cGggdW5pY29kZT0iKSIgaG9yaXotYWR2LXg9IjQ3NyIgZD0iTSAxNjQsMTU1NCBM
IDMyNCwxNTU0IEMgNDI0LDEzOTcgNDk5LDEyNDMgNTQ5LDEwOTIgNTk4LDk0MSA2MjMsNzkyIDYy
Myw2NDMgNjIzLDQ5NCA1OTgsMzQzIDU0OSwxOTIgNDk5LDQxIDQyNCwtMTEzIDMyNCwtMjcwIEwg
MTY0LC0yNzAgQyAyNTMsLTExNyAzMTksMzUgMzYzLDE4NiA0MDYsMzM3IDQyOCw0ODkgNDI4LDY0
MyA0MjgsNzk3IDQwNiw5NDkgMzYzLDEwOTkgMzE5LDEyNDkgMjUzLDE0MDEgMTY0LDE1NTQgWiIv
PgogICA8Z2x5cGggdW5pY29kZT0iKCIgaG9yaXotYWR2LXg9IjQ3NyIgZD0iTSA2MzUsMTU1NCBD
IDU0NiwxNDAxIDQ3OSwxMjQ5IDQzNiwxMDk5IDM5Myw5NDkgMzcxLDc5NyAzNzEsNjQzIDM3MSw0
ODkgMzkzLDMzNyA0MzcsMTg2IDQ4MCwzNSA1NDYsLTExNyA2MzUsLTI3MCBMIDQ3NSwtMjcwIEMg
Mzc1LC0xMTMgMzAwLDQxIDI1MSwxOTIgMjAxLDM0MyAxNzYsNDk0IDE3Niw2NDMgMTc2LDc5MiAy
MDEsOTQxIDI1MCwxMDkyIDI5OSwxMjQzIDM3NCwxMzk3IDQ3NSwxNTU0IEwgNjM1LDE1NTQgWiIv
PgogICA8Z2x5cGggdW5pY29kZT0iICIgaG9yaXotYWR2LXg9IjYzNSIvPgogIDwvZm9udD4KIDwv
ZGVmcz4KIDxkZWZzIGNsYXNzPSJUZXh0U2hhcGVJbmRleCI+CiAgPGcgb29vOnNsaWRlPSJpZDEi
IG9vbzppZC1saXN0PSJpZDMgaWQ0IGlkNSBpZDYgaWQ3IGlkOCBpZDkiLz4KIDwvZGVmcz4KIDxk
ZWZzIGNsYXNzPSJFbWJlZGRlZEJ1bGxldENoYXJzIj4KICA8ZyBpZD0iYnVsbGV0LWNoYXItdGVt
cGxhdGUoNTczNTYpIiB0cmFuc2Zvcm09InNjYWxlKDAuMDAwNDg4MjgxMjUsLTAuMDAwNDg4Mjgx
MjUpIj4KICAgPHBhdGggZD0iTSA1ODAsMTE0MSBMIDExNjMsNTcxIDU4MCwwIC00LDU3MSA1ODAs
MTE0MSBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxsZXQtY2hhci10ZW1wbGF0ZSg1NzM1NCkiIHRy
YW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBk
PSJNIDgsMTEyOCBMIDExMzcsMTEyOCAxMTM3LDAgOCwwIDgsMTEyOCBaIi8+CiAgPC9nPgogIDxn
IGlkPSJidWxsZXQtY2hhci10ZW1wbGF0ZSgxMDE0NikiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0
ODgyODEyNSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBkPSJNIDE3NCwwIEwgNjAyLDczOSAx
NzQsMTQ4MSAxNDU2LDczOSAxNzQsMCBaIE0gMTM1OCw3MzkgTCAzMDksMTM0NiA2NTksNzM5IDEz
NTgsNzM5IFoiLz4KICA8L2c+CiAgPGcgaWQ9ImJ1bGxldC1jaGFyLXRlbXBsYXRlKDEwMTMyKSIg
dHJhbnNmb3JtPSJzY2FsZSgwLjAwMDQ4ODI4MTI1LC0wLjAwMDQ4ODI4MTI1KSI+CiAgIDxwYXRo
IGQ9Ik0gMjAxNSw3MzkgTCAxMjc2LDAgNzE3LDAgMTI2MCw1NDMgMTc0LDU0MyAxNzQsOTM2IDEy
NjAsOTM2IDcxNywxNDgxIDEyNzQsMTQ4MSAyMDE1LDczOSBaIi8+CiAgPC9nPgogIDxnIGlkPSJi
dWxsZXQtY2hhci10ZW1wbGF0ZSgxMDAwNykiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEy
NSwtMC4wMDA0ODgyODEyNSkiPgogICA8cGF0aCBkPSJNIDAsLTIgQyAtNywxNCAtMTYsMjcgLTI1
LDM3IEwgMzU2LDU2NyBDIDI2Miw4MjMgMjE1LDk1MiAyMTUsOTU0IDIxNSw5NzkgMjI4LDk5MiAy
NTUsOTkyIDI2NCw5OTIgMjc2LDk5MCAyODksOTg3IDMxMCw5OTEgMzMxLDk5OSAzNTQsMTAxMiBM
IDM4MSw5OTkgNDkyLDc0OCA3NzIsMTA0OSA4MzYsMTAyNCA4NjAsMTA0OSBDIDg4MSwxMDM5IDkw
MSwxMDI1IDkyMiwxMDA2IDg4Niw5MzcgODM1LDg2MyA3NzAsNzg0IDc2OSw3ODMgNzEwLDcxNiA1
OTQsNTg0IEwgNzc0LDIyMyBDIDc3NCwxOTYgNzUzLDE2OCA3MTEsMTM5IEwgNzI3LDExOSBDIDcx
Nyw5MCA2OTksNzYgNjcyLDc2IDY0MSw3NiA1NzAsMTc4IDQ1NywzODEgTCAxNjQsLTc2IEMgMTQy
LC0xMTAgMTExLC0xMjcgNzIsLTEyNyAzMCwtMTI3IDksLTExMCA4LC03NiAxLC02NyAtMiwtNTIg
LTIsLTMyIC0yLC0yMyAtMSwtMTMgMCwtMiBaIi8+CiAgPC9nPgogIDxnIGlkPSJidWxsZXQtY2hh
ci10ZW1wbGF0ZSgxMDAwNCkiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0
ODgyODEyNSkiPgogICA8cGF0aCBkPSJNIDI4NSwtMzMgQyAxODIsLTMzIDExMSwzMCA3NCwxNTYg
NTIsMjI4IDQxLDMzMyA0MSw0NzEgNDEsNTQ5IDU1LDYxNiA4Miw2NzIgMTE2LDc0MyAxNjksNzc4
IDI0MCw3NzggMjkzLDc3OCAzMjgsNzQ3IDM0Niw2ODQgTCAzNjksNTA4IEMgMzc3LDQ0NCAzOTcs
NDExIDQyOCw0MTAgTCAxMTYzLDExMTYgQyAxMTc0LDExMjcgMTE5NiwxMTMzIDEyMjksMTEzMyAx
MjcxLDExMzMgMTI5MiwxMTE4IDEyOTIsMTA4NyBMIDEyOTIsOTY1IEMgMTI5Miw5MjkgMTI4Miw5
MDEgMTI2Miw4ODEgTCA0NDIsNDcgQyAzOTAsLTYgMzM4LC0zMyAyODUsLTMzIFoiLz4KICA8L2c+
CiAgPGcgaWQ9ImJ1bGxldC1jaGFyLXRlbXBsYXRlKDk2NzkpIiB0cmFuc2Zvcm09InNjYWxlKDAu
MDAwNDg4MjgxMjUsLTAuMDAwNDg4MjgxMjUpIj4KICAgPHBhdGggZD0iTSA4MTMsMCBDIDYzMiww
IDQ4OSw1NCAzODMsMTYxIDI3NiwyNjggMjIzLDQxMSAyMjMsNTkyIDIyMyw3NzMgMjc2LDkxNiAz
ODMsMTAyMyA0ODksMTEzMCA2MzIsMTE4NCA4MTMsMTE4NCA5OTIsMTE4NCAxMTM2LDExMzAgMTI0
NSwxMDIzIDEzNTMsOTE2IDE0MDcsNzcyIDE0MDcsNTkyIDE0MDcsNDEyIDEzNTMsMjY4IDEyNDUs
MTYxIDExMzYsNTQgOTkyLDAgODEzLDAgWiIvPgogIDwvZz4KICA8ZyBpZD0iYnVsbGV0LWNoYXIt
dGVtcGxhdGUoODIyNikiIHRyYW5zZm9ybT0ic2NhbGUoMC4wMDA0ODgyODEyNSwtMC4wMDA0ODgy
ODEyNSkiPgogICA8cGF0aCBkPSJNIDM0Niw0NTcgQyAyNzMsNDU3IDIwOSw0ODMgMTU1LDUzNSAx
MDEsNTg2IDc0LDY0OSA3NCw3MjMgNzQsNzk2IDEwMSw4NTkgMTU1LDkxMSAyMDksOTYzIDI3Myw5
ODkgMzQ2LDk4OSA0MTksOTg5IDQ4MCw5NjMgNTMxLDkxMCA1ODIsODU5IDYwOCw3OTYgNjA4LDcy
MyA2MDgsNjQ4IDU4Myw1ODYgNTMyLDUzNSA0ODIsNDgzIDQyMCw0NTcgMzQ2LDQ1NyBaIi8+CiAg
PC9nPgogIDxnIGlkPSJidWxsZXQtY2hhci10ZW1wbGF0ZSg4MjExKSIgdHJhbnNmb3JtPSJzY2Fs
ZSgwLjAwMDQ4ODI4MTI1LC0wLjAwMDQ4ODI4MTI1KSI+CiAgIDxwYXRoIGQ9Ik0gLTQsNDU5IEwg
MTEzNSw0NTkgMTEzNSw2MDYgLTQsNjA2IC00LDQ1OSBaIi8+CiAgPC9nPgogPC9kZWZzPgogPGRl
ZnMgY2xhc3M9IlRleHRFbWJlZGRlZEJpdG1hcHMiLz4KIDxnIGNsYXNzPSJTbGlkZUdyb3VwIj4K
ICA8Zz4KICAgPGcgaWQ9ImlkMSIgY2xhc3M9IlNsaWRlIiBjbGlwLXBhdGg9InVybCgjcHJlc2Vu
dGF0aW9uX2NsaXBfcGF0aCkiPgogICAgPGcgY2xhc3M9IlBhZ2UiPgogICAgIDxnIGNsYXNzPSJj
b20uc3VuLnN0YXIuZHJhd2luZy5DdXN0b21TaGFwZSI+CiAgICAgIDxnIGlkPSJpZDMiPgogICAg
ICAgPHJlY3QgY2xhc3M9IkJvdW5kaW5nQm94IiBzdHJva2U9Im5vbmUiIGZpbGw9Im5vbmUiIHg9
IjE5Mzk5IiB5PSIzNjk5IiB3aWR0aD0iNTkwMyIgaGVpZ2h0PSI5NTAzIi8+CiAgICAgICA8cGF0
aCBmaWxsPSJyZ2IoMTQyLDE4MSwxNDIpIiBzdHJva2U9Im5vbmUiIGQ9Ik0gMjIzNTAsMTMyMDAg
TCAxOTQwMCwxMzIwMCAxOTQwMCwzNzAwIDI1MzAwLDM3MDAgMjUzMDAsMTMyMDAgMjIzNTAsMTMy
MDAgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCki
IGQ9Ik0gMjIzNTAsMTMyMDAgTCAxOTQwMCwxMzIwMCAxOTQwMCwzNzAwIDI1MzAwLDM3MDAgMjUz
MDAsMTMyMDAgMjIzNTAsMTMyMDAgWiIvPgogICAgICAgPHRleHQgY2xhc3M9IlRleHRTaGFwZSI+
PHRzcGFuIGNsYXNzPSJUZXh0UGFyYWdyYXBoIiBmb250LWZhbWlseT0iRGVqYVZ1IFNhbnMsIHNh
bnMtc2VyaWYiIGZvbnQtc2l6ZT0iNjM0cHgiIGZvbnQtd2VpZ2h0PSI0MDAiPjx0c3BhbiBjbGFz
cz0iVGV4dFBvc2l0aW9uIiB4PSIyMDk2NCIgeT0iNDQxMyI+PHRzcGFuIGZpbGw9InJnYigwLDAs
MCkiIHN0cm9rZT0ibm9uZSI+U3BlaWNoZXI8L3RzcGFuPjwvdHNwYW4+PC90c3Bhbj48L3RleHQ+
CiAgICAgIDwvZz4KICAgICA8L2c+CiAgICAgPGcgY2xhc3M9ImNvbS5zdW4uc3Rhci5kcmF3aW5n
LkN1c3RvbVNoYXBlIj4KICAgICAgPGcgaWQ9ImlkNCI+CiAgICAgICA8cmVjdCBjbGFzcz0iQm91
bmRpbmdCb3giIHN0cm9rZT0ibm9uZSIgZmlsbD0ibm9uZSIgeD0iMTkzOTkiIHk9IjYzOTkiIHdp
ZHRoPSI1OTAzIiBoZWlnaHQ9IjIwMDMiLz4KICAgICAgIDxwYXRoIGZpbGw9InJnYigwLDEyOCww
KSIgc3Ryb2tlPSJub25lIiBkPSJNIDIyMzUwLDg0MDAgTCAxOTQwMCw4NDAwIDE5NDAwLDY0MDAg
MjUzMDAsNjQwMCAyNTMwMCw4NDAwIDIyMzUwLDg0MDAgWiIvPgogICAgICAgPHBhdGggZmlsbD0i
bm9uZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9Ik0gMjIzNTAsODQwMCBMIDE5NDAwLDg0
MDAgMTk0MDAsNjQwMCAyNTMwMCw2NDAwIDI1MzAwLDg0MDAgMjIzNTAsODQwMCBaIi8+CiAgICAg
ICA8dGV4dCBjbGFzcz0iVGV4dFNoYXBlIj48dHNwYW4gY2xhc3M9IlRleHRQYXJhZ3JhcGgiIGZv
bnQtZmFtaWx5PSJEZWphVnUgU2Fucywgc2Fucy1zZXJpZiIgZm9udC1zaXplPSI2MzRweCIgZm9u
dC13ZWlnaHQ9IjQwMCI+PHRzcGFuIGNsYXNzPSJUZXh0UG9zaXRpb24iIHg9IjIwMzgwIiB5PSI3
NjIwIj48dHNwYW4gZmlsbD0icmdiKDAsMCwwKSIgc3Ryb2tlPSJub25lIj5MaXN0ZTogMSwgMCwg
MzwvdHNwYW4+PC90c3Bhbj48L3RzcGFuPjwvdGV4dD4KICAgICAgPC9nPgogICAgIDwvZz4KICAg
ICA8ZyBjbGFzcz0iY29tLnN1bi5zdGFyLmRyYXdpbmcuQ3VzdG9tU2hhcGUiPgogICAgICA8ZyBp
ZD0iaWQ1Ij4KICAgICAgIDxyZWN0IGNsYXNzPSJCb3VuZGluZ0JveCIgc3Ryb2tlPSJub25lIiBm
aWxsPSJub25lIiB4PSIyODk5IiB5PSIzNTk5IiB3aWR0aD0iOTkwNCIgaGVpZ2h0PSI5NTA0Ii8+
CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMTE0LDE1OSwyMDcpIiBzdHJva2U9Im5vbmUiIGQ9Ik0g
NDQ4MywzNjAwIEMgMzY5MSwzNjAwIDI5MDAsNDM5MSAyOTAwLDUxODMgTCAyOTAwLDExNTE3IEMg
MjkwMCwxMjMwOSAzNjkxLDEzMTAxIDQ0ODMsMTMxMDEgTCAxMTIxNywxMzEwMSBDIDEyMDA5LDEz
MTAxIDEyODAxLDEyMzA5IDEyODAxLDExNTE3IEwgMTI4MDEsNTE4MyBDIDEyODAxLDQzOTEgMTIw
MDksMzYwMCAxMTIxNywzNjAwIEwgNDQ4MywzNjAwIFogTSAyOTAwLDM2MDAgTCAyOTAwLDM2MDAg
WiBNIDEyODAxLDEzMTAxIEwgMTI4MDEsMTMxMDEgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9u
ZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9Ik0gNDQ4MywzNjAwIEMgMzY5MSwzNjAwIDI5
MDAsNDM5MSAyOTAwLDUxODMgTCAyOTAwLDExNTE3IEMgMjkwMCwxMjMwOSAzNjkxLDEzMTAxIDQ0
ODMsMTMxMDEgTCAxMTIxNywxMzEwMSBDIDEyMDA5LDEzMTAxIDEyODAxLDEyMzA5IDEyODAxLDEx
NTE3IEwgMTI4MDEsNTE4MyBDIDEyODAxLDQzOTEgMTIwMDksMzYwMCAxMTIxNywzNjAwIEwgNDQ4
MywzNjAwIFoiLz4KICAgICAgIDxwYXRoIGZpbGw9Im5vbmUiIHN0cm9rZT0icmdiKDUyLDEwMSwx
NjQpIiBkPSJNIDI5MDAsMzYwMCBMIDI5MDAsMzYwMCBaIi8+CiAgICAgICA8cGF0aCBmaWxsPSJu
b25lIiBzdHJva2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSAxMjgwMSwxMzEwMSBMIDEyODAxLDEz
MTAxIFoiLz4KICAgICAgIDx0ZXh0IGNsYXNzPSJUZXh0U2hhcGUiPjx0c3BhbiBjbGFzcz0iVGV4
dFBhcmFncmFwaCIgZm9udC1mYW1pbHk9IkRlamFWdSBTYW5zLCBzYW5zLXNlcmlmIiBmb250LXNp
emU9IjYzNHB4IiBmb250LXdlaWdodD0iNDAwIj48dHNwYW4gY2xhc3M9IlRleHRQb3NpdGlvbiIg
eD0iNTAxMiIgeT0iNDc3NiI+PHRzcGFuIGZpbGw9InJnYigwLDAsMCkiIHN0cm9rZT0ibm9uZSI+
VmFyaWFibGVuKG5hbWVuKTwvdHNwYW4+PC90c3Bhbj48L3RzcGFuPjwvdGV4dD4KICAgICAgPC9n
PgogICAgIDwvZz4KICAgICA8ZyBjbGFzcz0iY29tLnN1bi5zdGFyLmRyYXdpbmcuQ3VzdG9tU2hh
cGUiPgogICAgICA8ZyBpZD0iaWQ2Ij4KICAgICAgIDxyZWN0IGNsYXNzPSJCb3VuZGluZ0JveCIg
c3Ryb2tlPSJub25lIiBmaWxsPSJub25lIiB4PSI2NDk5IiB5PSI1Mzk5IiB3aWR0aD0iMzYwNCIg
aGVpZ2h0PSIyMDA0Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMCw3MSwyNTUpIiBzdHJva2U9
Im5vbmUiIGQ9Ik0gNjgzMyw1NDAwIEMgNjY2Niw1NDAwIDY1MDAsNTU2NiA2NTAwLDU3MzMgTCA2
NTAwLDcwNjcgQyA2NTAwLDcyMzQgNjY2Niw3NDAxIDY4MzMsNzQwMSBMIDk3NjcsNzQwMSBDIDk5
MzMsNzQwMSAxMDEwMCw3MjM0IDEwMTAwLDcwNjcgTCAxMDEwMCw1NzMzIEMgMTAxMDAsNTU2NiA5
OTMzLDU0MDAgOTc2Nyw1NDAwIEwgNjgzMyw1NDAwIFogTSA2NTAwLDU0MDAgTCA2NTAwLDU0MDAg
WiBNIDEwMTAxLDc0MDEgTCAxMDEwMSw3NDAxIFoiLz4KICAgICAgIDxwYXRoIGZpbGw9Im5vbmUi
IHN0cm9rZT0icmdiKDUyLDEwMSwxNjQpIiBkPSJNIDY4MzMsNTQwMCBDIDY2NjYsNTQwMCA2NTAw
LDU1NjYgNjUwMCw1NzMzIEwgNjUwMCw3MDY3IEMgNjUwMCw3MjM0IDY2NjYsNzQwMSA2ODMzLDc0
MDEgTCA5NzY3LDc0MDEgQyA5OTMzLDc0MDEgMTAxMDAsNzIzNCAxMDEwMCw3MDY3IEwgMTAxMDAs
NTczMyBDIDEwMTAwLDU1NjYgOTkzMyw1NDAwIDk3NjcsNTQwMCBMIDY4MzMsNTQwMCBaIi8+CiAg
ICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSA2NTAw
LDU0MDAgTCA2NTAwLDU0MDAgWiIvPgogICAgICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJy
Z2IoNTIsMTAxLDE2NCkiIGQ9Ik0gMTAxMDEsNzQwMSBMIDEwMTAxLDc0MDEgWiIvPgogICAgICAg
PHRleHQgY2xhc3M9IlRleHRTaGFwZSI+PHRzcGFuIGNsYXNzPSJUZXh0UGFyYWdyYXBoIiBmb250
LWZhbWlseT0iRGVqYVZ1IFNhbnMsIHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iNjM0cHgiIGZvbnQt
d2VpZ2h0PSI0MDAiPjx0c3BhbiBjbGFzcz0iVGV4dFBvc2l0aW9uIiB4PSI4MTEyIiB5PSI2NjIw
Ij48dHNwYW4gZmlsbD0icmdiKDAsMCwwKSIgc3Ryb2tlPSJub25lIj54PC90c3Bhbj48L3RzcGFu
PjwvdHNwYW4+PC90ZXh0PgogICAgICA8L2c+CiAgICAgPC9nPgogICAgIDxnIGNsYXNzPSJjb20u
c3VuLnN0YXIuZHJhd2luZy5Db25uZWN0b3JTaGFwZSI+CiAgICAgIDxnIGlkPSJpZDciPgogICAg
ICAgPHJlY3QgY2xhc3M9IkJvdW5kaW5nQm94IiBzdHJva2U9Im5vbmUiIGZpbGw9Im5vbmUiIHg9
IjEwMDY0IiB5PSI2MzY0IiB3aWR0aD0iOTMzNyIgaGVpZ2h0PSIxMjM3Ii8+CiAgICAgICA8cGF0
aCBmaWxsPSJub25lIiBzdHJva2U9InJnYigwLDAsMCkiIHN0cm9rZS13aWR0aD0iNzEiIHN0cm9r
ZS1saW5lam9pbj0icm91bmQiIGQ9Ik0gMTAxMDAsNjQwMCBDIDE3MDc2LDY0MDAgMTI3MjAsNzMz
NSAxODc1MCw3Mzk3Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMCwwLDApIiBzdHJva2U9Im5v
bmUiIGQ9Ik0gMTk0MDAsNzQwMCBMIDE4NzkyLDcxOTQgMTg3OTAsNzYwMCAxOTQwMCw3NDAwIFoi
Lz4KICAgICAgPC9nPgogICAgIDwvZz4KICAgICA8ZyBjbGFzcz0iY29tLnN1bi5zdGFyLmRyYXdp
bmcuQ3VzdG9tU2hhcGUiPgogICAgICA8ZyBpZD0iaWQ4Ij4KICAgICAgIDxyZWN0IGNsYXNzPSJC
b3VuZGluZ0JveCIgc3Ryb2tlPSJub25lIiBmaWxsPSJub25lIiB4PSI2NDk5IiB5PSI5MDk5IiB3
aWR0aD0iMzYwNCIgaGVpZ2h0PSIyMDA0Ii8+CiAgICAgICA8cGF0aCBmaWxsPSJyZ2IoMCw3MSwy
NTUpIiBzdHJva2U9Im5vbmUiIGQ9Ik0gNjgzMyw5MTAwIEMgNjY2Niw5MTAwIDY1MDAsOTI2NiA2
NTAwLDk0MzMgTCA2NTAwLDEwNzY3IEMgNjUwMCwxMDkzNCA2NjY2LDExMTAxIDY4MzMsMTExMDEg
TCA5NzY3LDExMTAxIEMgOTkzMywxMTEwMSAxMDEwMCwxMDkzNCAxMDEwMCwxMDc2NyBMIDEwMTAw
LDk0MzMgQyAxMDEwMCw5MjY2IDk5MzMsOTEwMCA5NzY3LDkxMDAgTCA2ODMzLDkxMDAgWiBNIDY1
MDAsOTEwMCBMIDY1MDAsOTEwMCBaIE0gMTAxMDEsMTExMDEgTCAxMDEwMSwxMTEwMSBaIi8+CiAg
ICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSA2ODMz
LDkxMDAgQyA2NjY2LDkxMDAgNjUwMCw5MjY2IDY1MDAsOTQzMyBMIDY1MDAsMTA3NjcgQyA2NTAw
LDEwOTM0IDY2NjYsMTExMDEgNjgzMywxMTEwMSBMIDk3NjcsMTExMDEgQyA5OTMzLDExMTAxIDEw
MTAwLDEwOTM0IDEwMTAwLDEwNzY3IEwgMTAxMDAsOTQzMyBDIDEwMTAwLDkyNjYgOTkzMyw5MTAw
IDk3NjcsOTEwMCBMIDY4MzMsOTEwMCBaIi8+CiAgICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJv
a2U9InJnYig1MiwxMDEsMTY0KSIgZD0iTSA2NTAwLDkxMDAgTCA2NTAwLDkxMDAgWiIvPgogICAg
ICAgPHBhdGggZmlsbD0ibm9uZSIgc3Ryb2tlPSJyZ2IoNTIsMTAxLDE2NCkiIGQ9Ik0gMTAxMDEs
MTExMDEgTCAxMDEwMSwxMTEwMSBaIi8+CiAgICAgICA8dGV4dCBjbGFzcz0iVGV4dFNoYXBlIj48
dHNwYW4gY2xhc3M9IlRleHRQYXJhZ3JhcGgiIGZvbnQtZmFtaWx5PSJEZWphVnUgU2Fucywgc2Fu
cy1zZXJpZiIgZm9udC1zaXplPSI2MzRweCIgZm9udC13ZWlnaHQ9IjQwMCI+PHRzcGFuIGNsYXNz
PSJUZXh0UG9zaXRpb24iIHg9IjgxMTIiIHk9IjEwMzIwIj48dHNwYW4gZmlsbD0icmdiKDAsMCww
KSIgc3Ryb2tlPSJub25lIj55PC90c3Bhbj48L3RzcGFuPjwvdHNwYW4+PC90ZXh0PgogICAgICA8
L2c+CiAgICAgPC9nPgogICAgIDxnIGNsYXNzPSJjb20uc3VuLnN0YXIuZHJhd2luZy5Db25uZWN0
b3JTaGFwZSI+CiAgICAgIDxnIGlkPSJpZDkiPgogICAgICAgPHJlY3QgY2xhc3M9IkJvdW5kaW5n
Qm94IiBzdHJva2U9Im5vbmUiIGZpbGw9Im5vbmUiIHg9IjEwMDY0IiB5PSI3MjA1IiB3aWR0aD0i
OTMzNyIgaGVpZ2h0PSIyOTMyIi8+CiAgICAgICA8cGF0aCBmaWxsPSJub25lIiBzdHJva2U9InJn
YigwLDAsMCkiIHN0cm9rZS13aWR0aD0iNzEiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGQ9Ik0g
MTAxMDAsMTAxMDAgQyAxNzA3NiwxMDEwMCAxMjcxNSw3NTcxIDE4NzYxLDc0MDgiLz4KICAgICAg
IDxwYXRoIGZpbGw9InJnYigwLDAsMCkiIHN0cm9rZT0ibm9uZSIgZD0iTSAxOTQwMCw3NDAwIEwg
MTg3ODgsNzIwNSAxODc5NCw3NjExIDE5NDAwLDc0MDAgWiIvPgogICAgICA8L2c+CiAgICAgPC9n
PgogICAgPC9nPgogICA8L2c+CiAgPC9nPgogPC9nPgo8L3N2Zz4=""", 
	MIME("image/svg"), (:height => 240,))
	
end;
	

# ╔═╡ c3c27ab9-7edb-4b57-b721-ec650ef44108
Bilder["x_ref"]

# ╔═╡ 965ba691-ec75-4c8c-b783-9336ae090a81
Bilder["xy_ref"]

# ╔═╡ d58e7efd-85db-4362-aa69-dc4cb89c3ee0
Bilder["xy_changed_ref"]

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[compat]
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.12.3"
manifest_format = "2.0"
project_hash = "bd66f660a0198a1338b20ef2fb472648eb0cb4b2"

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
# ╟─1891df2a-a1bf-4544-b0d8-781b688a26ca
# ╟─d69055f8-6c4e-11ef-23d7-81aec1872324
# ╠═4f126d52-7144-4b28-95cd-bb2133ae3b93
# ╠═50d4a4d7-59ae-49a3-b0bd-6d7d94a443d2
# ╟─65642127-f9f1-472e-bb6b-3ca3b2395c94
# ╟─4ca9ff63-a199-4a76-9cda-3d9fb16db24d
# ╠═0f228e01-ff56-48c2-87b7-a68bf8141640
# ╟─8fa189a9-7324-4517-b451-864a666a8da8
# ╟─d0dae510-bca4-4fb3-be12-c6835e457799
# ╠═f4b17101-3b9b-438a-9b60-818030f9e404
# ╠═7983e3f0-53eb-4a77-a909-e56df4a8a7b5
# ╠═a6fa9ac9-f84b-4812-8159-102b7b1d28e9
# ╟─cd1f3797-fe89-485a-b97a-1708be02f42e
# ╠═b1b3f5a6-8ccf-4aa5-a108-8235cdabd0b3
# ╟─043d0c7a-c821-49f2-8846-aa054a989a9d
# ╠═0f2e1695-5961-4ea1-8df3-81d9c2f0f03d
# ╟─632fef90-9bd6-4a56-905a-87c8e688da6a
# ╠═81f3305f-07fb-4d5f-bfc6-45de6191b7a6
# ╠═bd0aad40-25f1-4721-9970-f51be6907551
# ╠═b405c82c-680a-4da3-85e4-f81ed84ee35d
# ╟─babb9f42-b15c-4235-9824-efa72871df1e
# ╠═0b974411-472c-4a9f-9a42-8d56e12bc8ff
# ╠═6c897424-7098-446e-a3fb-ae431b9f1fc8
# ╟─f71bafa4-02f2-467b-9adf-422a548da688
# ╟─c4e0c5d4-bc4a-4009-8458-22c44b8a239d
# ╠═a8c7c7b7-361d-42f4-b7d2-d95c021c23c3
# ╟─b52e876e-9d89-4e17-85e7-7b86c54907fd
# ╟─674e6838-0798-48fd-a490-ee1c72230650
# ╠═0d4d8ff1-66cc-449c-bd5a-bba6d6a0ae34
# ╟─19e4384b-b0f7-4252-9c95-56f6fe151ee9
# ╟─c3c27ab9-7edb-4b57-b721-ec650ef44108
# ╠═0ad182a7-a2dd-4e95-98db-9817ffbe24fd
# ╟─3dbc69a8-c109-4c09-92e4-6d1da3009c5d
# ╟─965ba691-ec75-4c8c-b783-9336ae090a81
# ╟─da2f9be2-59e3-44a1-9c53-08bccd3e4942
# ╠═36af19c8-2316-420e-a816-339744f8f68c
# ╟─a51e5e6d-1da6-4168-a5bc-128afb0b52f8
# ╠═fe1d0b60-0a98-4bed-bc5c-cb5da5827961
# ╠═d24e5e5d-2c7d-4d82-8fee-3285a0bed4d0
# ╠═3e2bfe26-84bc-4e7a-902f-fcbd1a61730d
# ╟─d58e7efd-85db-4362-aa69-dc4cb89c3ee0
# ╟─d2aa5bbc-1cf2-4a10-b889-637281c9c033
# ╠═4c4f1af4-eaaa-45e4-911e-f5515c1784b1
# ╟─7c011d80-700d-407e-9939-82322ce3901b
# ╟─dbf4396e-cecc-405c-ac1c-bd21097f91bf
# ╠═aad00c4e-5fbb-4614-8427-6078572ea09a
# ╟─e7c355bf-5264-430b-a374-ec30f5332254
# ╠═394ae206-1729-419c-96b5-0e674bd07464
# ╟─1f057a20-9d6a-457e-a40d-38b5c2a5fa05
# ╠═4c13ea39-d918-4032-abee-b0a0edbb9a64
# ╠═da8a9c18-c98a-430a-8d28-000d6d0abdc6
# ╟─a77866af-7cc0-4de3-908a-d9b957eb9765
# ╠═50a32f90-e81d-4ff1-8413-fc4448d3158c
# ╠═82964a7e-455e-4132-870c-8aecfa592e47
# ╠═5cf92602-c128-41ef-a026-82f37e1c6c30
# ╟─d13c3b0e-5130-493c-a947-f4a0b0170153
# ╠═c0ca3aa4-bf87-4251-a630-a80808c87d3c
# ╠═620d8505-5f96-4944-bb5d-dde0bbf69b5d
# ╟─beeea862-f515-436d-bbaf-c3b99b7645c0
# ╟─fdac4041-8fed-4910-8a57-812efd52db0b
# ╟─fed3ebef-a75c-4322-9d3d-31a72e36889f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
