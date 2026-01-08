### A Pluto.jl notebook ###
# v0.20.21

using Markdown
using InteractiveUtils

# ╔═╡ 4c6e716a-843e-4d0d-b1c7-a60dbdc4fa39
begin
	using PlutoUI	
	
	PlutoUI.TableOfContents(title="Inhalt", depth=4)
end

# ╔═╡ 80cbcad8-7509-11ef-3815-c5e2f8b75cd4
md"""
# Rekursion

> Um Rekursion zu verstehen, muss man Rekursion verstanden haben.

Rekursion ist das Konzept, Wiederholung durch Selbstaufruf durchzuführen.
Natürlich wird beim Selbstaufruf nicht extakt das gleiche Problem übergeben
(das wäre dann eine Endlosschleife). Indes wird das Problem typischerweise
aufgeteilt, ein kleiner Teil erledigt und für den Rest der Selbstaufruf
durchgeführt.

## Einführungsbeispiel: Fibonacci

Starten wir mit einem klassichen/akademischen Beispiel: Die Folge
der Fibonacci-Zahlen ist wie folgt definiert:

$f_0 = f_1 = 1,\qquad f_n = f_{n-2} + f_{n-1}\quad (n\ge 2).$

!!! danger "Dies können wir sofort in Code schreiben ..."
    ... was niemand, aber wirklich niemand so implentieren würde!!
"""

# ╔═╡ 3d282e6d-1805-408a-8b57-8b2f309114d6
"""Fibonacci rekursiv."""
function fibonacci(n) 
	return n < 2 ? one(n) : fibonacci(n-2) + fibonacci(n-1)
end;

# ╔═╡ 664f2704-d5ca-44f7-9ad7-8bda8b384102
typeof(one(Int8(8)))

# ╔═╡ ac6126e5-963d-4bf7-88d4-0cd0e6d9b2e3
fibonacci.([1,3, 8])

# ╔═╡ 5aa3fad4-057b-4450-95c8-dc7db51b076a
fibonacci.(0:10)

# ╔═╡ d253bee0-2676-4242-8019-60c8c575d18a
md"""
Anhand des folgenden Aufruf-Diagramms sieht man, wie oft sich diese Funktion
(natürlich für unterschiedliche $n$) selbst aufruft.
"""

# ╔═╡ b9752caa-025d-4166-89d4-5744e220e335
md"""
```julia
─7┬─5┬─3┬─1
  │  │  └─2┬─0
  │  │     └─1
  │  └─4┬─2┬─0
  │     │  └─1
  │     └─3┬─1
  │        └─2┬─0
  │           └─1
  └─6┬─4┬─2┬─0
     │  │  └─1
     │  └─3┬─1
     │     └─2┬─0
     │        └─1
     └─5┬─3┬─1
        │  └─2┬─0
        │     └─1
        └─4┬─2┬─0
           │  └─1
           └─3┬─1
              └─2┬─0
                 └─1
```
"""

# ╔═╡ 207b7b55-73ae-4e1c-845f-5ec169c8afad
md"""
[Keine Panik. Solch einen Aufrufbaum muss man nicht manuell erstellen. Es gibt
eine Aufgabe, zur Erstellung solcher Bäume für beliebiges $n$. Man wird bei der
Erstellung (offensichtlich) rekursiv vorgehen.]
"""

# ╔═╡ 8f96aca9-4aad-4280-b2dd-d76b8fd8cbb7
md"""
Wir bauen mal etwas Dokumentation ein, um zu sehen, wie die Selbstaufrufe
aussehen, also wie man obiges Diagramm zu lesen hat.
"""

# ╔═╡ 12e1a8dc-2784-4275-bcbc-bec467f83106
"""Rekursive Berechnung der n.-ten Fibonacci-Zahl mit Ausgabe."""
function doc_fibonacci(n, tiefe=0)
	doc_prefix = "    "^tiefe
	println(doc_prefix, "Soll " * string(n) * ". Fibonacci Zahl berechnen")
	if n < 2
		println(doc_prefix, "Das ist einfach: liefere einfach 1")
		return one(n)
	else
		(n_2, n_1) = (n-2, n-1)
		println(doc_prefix, 
			"Hm. Brauche dazu die beiden Fibonacci Zahlen " * string(n_2) *
			" und " * string(n_1))
		fn_2 = doc_fibonacci(n_2, tiefe+1)
		fn_1 = doc_fibonacci(n_1, tiefe+1)
		result = fn_2 + fn_1
		println(doc_prefix, "Addiere " * string(fn_2) * " und " *
		                    string(fn_1) * " und liefere ab: " * string(result))
		return result
	end
end;

# ╔═╡ e51918b3-027e-4932-b869-c03490e808d4
doc_fibonacci(1)

# ╔═╡ b8e8bc4d-806d-4cd8-b316-cc13ed116b9f
doc_fibonacci(2)

# ╔═╡ d29e4769-e703-409b-a7ab-0f5cfacafdbb
doc_fibonacci(4)

# ╔═╡ 5ebe10d9-e50e-41ab-9073-959e44c610e4
md"""
Wir sehen, wie oft `doc_fibonacci` sich selbst aufruf.

Zum Spaß zählen wir mal mit. Also nicht per Hand. Wir schreiben Code
der für uns mitzählt.
"""

# ╔═╡ 23c60b92-f633-4341-937d-69305ea713e8
"""
Rekursive Berechnung der n. Fibonacci-Zahl, inkl. Zählung, wie oft
diese Funktion aufgerufen wurde.
"""
function count_fibonacci(n)
	if n < 2		
		return one(n), 1 # liefere 1 und es war nur ein Aufruf (dieser hier)
	else
		fn_2, count_n_2 = count_fibonacci(n-2) # Fib-Zahl und Aufwand
		fn_1, count_n_1 = count_fibonacci(n-1) # Fib-Zahl und Aufwand
		# liefere Summe und Aufwand (dieser Aufruf muss auch gezählt werden)
		return fn_2 + fn_1, 1 + count_n_2 + count_n_1
	end
end;

# ╔═╡ b0968894-07de-46a2-a38f-4371602446b3
count_fibonacci.(0:7)

# ╔═╡ 7a075396-a6a9-4010-a4f6-86afa87211b6
fibonacci.(0:10)

# ╔═╡ 048311ee-d97e-4e33-9ace-b936891c5c07
diff([count_fibonacci(n)[2] for n in 0:10])

# ╔═╡ 55899a07-9032-41ae-adcb-4ea6ef6f72c0
let
	prüfe(n) = (count_fibonacci(n)[2] - count_fibonacci(n-1)[2]) - 2fibonacci(n-2)
	prüfe.(2:30)
end

# ╔═╡ b162c5e2-3458-45eb-9431-6da3d063299d
md"""
!!! info "Fällt etwas auf?"
    Die Anzahl $a_k$ der Funktionsaufrufe erfüllt offenbar

    $a_1 = a_2 = 1,\qquad a_n = 1 + a_{n-2} + a_{n-1}\quad (n\ge 3).$

    Und scheinbar gilt:

    $\frac{a_n - a_{n-1}}{2}= f_{n-2}\quad (n\ge 2).$

    Beweis?
"""

# ╔═╡ daf50473-46fb-480a-9d6e-e1d6ce82e85d
md"""
Natürlich wird niemand so viele Selbstaufrufe machen (es war ja auch
ein "akademisches" Beispiel). Selbst eine einfache
iterative Variante ist deutlich schneller (und schöner?).
"""

# ╔═╡ c0c7c815-1465-48b4-96cc-093d77e2ed9b
"""
Berechnet iterativ die n. Fibonacci Zahl.

Vorsicht: kein Test auf Integer-Overflow!
"""
function iter_fibonacci(n)
	alt, aktuell = one(n), one(n)  # 0. und 1. Fib-Zahl
	for _ in 2:n  # jetzt iterativ hoch
		alt, aktuell = aktuell, alt + aktuell
	end
	return aktuell
end;

# ╔═╡ 76dfe310-a5aa-4ddd-b8de-e987108679c0
md"""
---
Ein kleiner Nebenschauplatz: Integer-Overflow!
"""

# ╔═╡ ef9fe3b4-60c5-434b-bbbe-8b863f58d63c
iter_fibonacci(100), iter_fibonacci(Int128(100))

# ╔═╡ 2f92735c-ae9d-492a-9482-94a21e34f2a4
"""Berechnet iterativ die n. Fibonacci Zahl mit Overflow-check."""
function checked_iter_fibonacci(n)
	alt, aktuell = one(n), one(n)  # 0. und 1. Fib-Zahl
	for _ in 2:n  # jetzt iterativ hoch
		alt, aktuell = aktuell, Base.checked_add(alt, aktuell)
	end
	return aktuell
end;

# ╔═╡ 67592314-7f41-49e6-9b01-1bfa5375f329
checked_iter_fibonacci(100) # mit Fehler bei Overflow

# ╔═╡ 6c038357-0aac-4b8d-a984-104b5e25e91d
checked_iter_fibonacci(Int128(100))

# ╔═╡ d29b1eea-1759-4457-b4b1-b3637f33f8aa
md"""
Ende des Overflow-Schauspiels.

---

Damit haben wir ein klassisches Beispiel gesehen, anhand dem man Rekursion erklären
kann, aber wo niemand Rekursion programmieren würde. Toll. (Super?)

Gibt es denn auch relevante Beispiele, wo jemand auch wirklich Rekursion
verwenden würde? [Es gäbe wohl in diesem Kurs nicht den Abschnitt "Rekursion", falls
die Antwort "nein" wäre.]

Was gibt es Schöneres, als alte Prüfungsaufgaben, die das erklären könnten? Also
ab zu Kettenbrüchen.
"""

# ╔═╡ 0ebbaeb1-eed2-4eba-97f1-2e6c606ad182
md"""
## Beispiel: Kettenbrüche

Für eine (rationale) Zahl $w_0>0$ ist durch

$$a_0 := \lfloor w_0\rfloor,\quad w_n = \underbrace{\lfloor w_n\rfloor}_{=:a_n}  + \frac{1}{w_{n+1}} \qquad \hbox{für alle $n\in\mathbb{N}$ mit $w_{n-1}\ne a_{n-1}$}$$

ein einfacher Kettenbruch definiert.

Hinweis: Es ist
$\lfloor z\rfloor := \max\{k\in\mathbb{Z}:k\le z\}$; in julia lautet
die Funktion `floor(...)`.

Beispiele:

$$\frac{15}{121} = 0 + \frac{1}{8 + \frac{1}{15}};\;\; a=[0,8,15];\quad\frac{1393}{972} = 1 + \frac{1}{2 + \frac{1}{3 + \frac{1}{4 + \frac{1}{5 + \frac{1}{6}}}}};\;\; a=[1,2,3,4,5,6]$$

   1. Schreibe eine Funktion (in julia), die für einen gegebenen Vektor $a$ den
      Kettenbruch auswertet und den Wert als Ergebnis zurückliefert.

            berechne_kettenbruch(a::Vector{Int})::Rational
   2. Schreibe eine Funktion (in julia), die für eine gegebene rationale Zahl den          (endlichen) Kettenbruch berechnet (also den Vektor $a$ zurückliefert).

            erzeuge_kettenbruch(w::Rational)::Vector{Int}
"""

# ╔═╡ 2ae96939-072e-4e48-816b-040a1249b1e8
md"""
Wie lautet hier die Rekursionsidee für die 1. Aufgabe?

Wir teilen $a$ auf in $a=[a_1, \underbrace{a_2, a_3, \ldots, a_n}_{r:=\text{Rest}}]$.
   1. Falls der Rest nicht da ist (also $a$ nur eine Zahl enthielt) ist alles einfach
      und wir liefern $a_1$ ab und sind fertig.
   2. Falls es einen Rest gibt, dann ist es auch einfach:
      Wir rufen die Funktion auf (die wir gerade schreiben), um den Kettenbruch $K$
      für den Rest $[a_2,a_3,\ldots,a_n]$ zu berechnen und liefern
      $a_1 + 1/K$ ab.

Und mit dem `? :`-Operator ist das ein schöner und kurzer "Einzeiler".
"""

# ╔═╡ c60370d4-bc51-476d-8bdd-3104fa4f3b1e
function berechne_kettenbruch(a::Vector{Int}) :: Rational
	return a[1] + (length(a) == 1 ? 0 : 1//berechne_kettenbruch(a[2:end]))
end;

# ╔═╡ a5ca8579-71ec-44be-a58b-640c30ece456
md"""
Und die Rekursionsidee für die 2. Aufgabe?

Nun: Da steht die Lösung schon in der Aufgabenstellung. Die Definition des
Kettenbruchs ist schon die Idee.
   1. Wir bestimmen den ganzzahligen Anteil $\alpha$ von $w$. Das liefert
      bereits den ersten Koeffizienten.
   2. Und dann brauchen wir die Koeffizienten von $1/(w-\alpha)$.
      Hier müssen wir aufpassen: Falls $w-\alpha=0$ ist, sind wir fertig.
"""

# ╔═╡ 962e327e-ab50-4c6b-b649-8e8ce6bfacd5
function erzeuge_kettenbruch(w::Rational) :: Vector{Int}
	α = floor(Int, w)
	diff = w - α
	return diff == 0 ? [α] : [α, erzeuge_kettenbruch(1//diff)...]
end;

# ╔═╡ bd4a46c6-d197-4119-a628-5d68a4045673
md"""
## Beispiel: Wurzelbäume

Nun zu einem ganz typischen/klassischen Beispiel, wo Rekursion sehr sehr
oft Verwendung findet.

!!! correct "Definition: geordneter Wurzelbaum"
    Ein geordneter Wurzelbaum $B$ (ab jetzt oft kurz WB) 
    ist eine Aufzählung/Liste
    von endlich vielen Kindern $B_1,\ldots,B_n$ (mit $n\in\mathbb{N}_0$),
    die wieder geordnete Wurzelbäume sind:

    $B=(B_1,\ldots,B_n).$

Schon die Defintion ist rekursiv.
"""

# ╔═╡ 5e0d43ee-c5da-472c-9c33-ab38d105c727
begin # Wurzelbäume mit Hilfe von Tuples
	Bsp1 = tuple()  # WB ohne Kinder
	Bsp2 = (Bsp1,)  # WB mit einem Kind (nämlich Bsp1)
	Bsp3 = (Bsp2, Bsp1, Bsp2)  # noch ein WB
end

# ╔═╡ c00164c0-2a2e-4bb9-96f1-c42017439e60
md"""
Wie könnte man jetzt WB schöner darstellen?
Aufgrund der Definition können geordnete Wurzelbäume 
auch als Graph dargestellt werden:
"""

# ╔═╡ aa9a8572-e368-4bba-add0-13d5a5f5f828
HTML(raw"""<pre style="font-family: monospace;">
      Bsp1: █              Bsp3: █
                                 ├─▅
                                 │ └─▅
      Bsp2: █                    ├─▅
            └─▅                  └─▅
                                   └─▅
	  </pre>""")

# ╔═╡ 53d2dbd6-0df4-41d0-bc3f-45e2e591ac5d
md"""
Dann schreiben wir mal eine (rekursive) Funktion, die solche Bäume zeichnet:
"""

# ╔═╡ d842b707-1bf6-4a5e-915b-c09d900881d9
"""liefere String-Vektor mit dem Graphen zum Wurzelbam `baum`."""
function graph_zu_baum(baum, indent="", erster=true, letzter=true)
	ergebnis = Vector{String}() # da kommen die Zeilen rein
	if erster
		push!(ergebnis, "█")  # dann geht es mit der Wurzel los
	else
		push!(ergebnis, indent * (letzter ? "└" : "├") * "─▅") # Sub-Baum starten
		indent *= letzter ? "  " : "│ " # Indent, für letzten ist Space sonst Linie
	end
	for (index, kind) in enumerate(baum)  # jetzt zu den Kindern
		append!(ergebnis, graph_zu_baum(kind, indent, false, index == length(baum)))
	end
	return ergebnis
end

# ╔═╡ 865cf95d-c541-4c0b-81ab-f2cb898d35ef
graph_zu_baum(Bsp1)

# ╔═╡ 150281c0-2885-432e-b7ab-2723f4bf9e13
graph_zu_baum(Bsp2)

# ╔═╡ a0e91685-b847-44ea-837e-2b2495f205e7
graph_zu_baum(Bsp3)

# ╔═╡ b0db8623-b666-452c-8eff-1ab219052abb
graph_zu_baum((Bsp3, Bsp1))

# ╔═╡ 6f3b3513-fea0-4135-b425-52b9ec877e5e
md"""
Und wir können auch für einen Baum, rekursiv die Anzahl der Knoten zählen.
"""

# ╔═╡ c8bb1583-a0ea-4f0b-98ce-27bb95dafbb9
"""ermittelt rekursiv die Anzahl der Knoten in einem Baum."""
wb_knoten(baum) = 1 + (baum != () ? sum(wb_knoten(kind) for kind in baum) : 0)

# ╔═╡ 5c26b70f-786c-4159-a8ef-42663ffbbd60
wb_knoten(Bsp3)

# ╔═╡ cfc18086-8ddc-499f-9307-f9008f33fc87
md"""
Und weil wir gerade bei Wurzelbäume sind: WB kann man auch durch ihren
"WB-Code" beschreiben:

!!! correct "Definition: WB-Code"
    Sei $B=[B_1,\ldots,B_n]$ ein Wurzelbaum mit $n\in\mathbb{N}_0$ Kindern,
    dann definiert

    $C_B:=[\#\hbox{Knoten von }B , C_{B_1},\ldots,C_{B_n}]$

    den WB-Code für $B$.

Wieder eine rekursive Definition. Hier der WB-Code (mit Herleitung)
für `Bsp3`:
"""

# ╔═╡ dd0f4b99-a0e8-48f8-8ebb-098b69f21309
HTML(raw"""<pre style="font-family: monospace">
█ [6,2,1,1,2,1]
├─▅ [2,1]
│ └─▅ [1]
├─▅ [1]
└─▅ [2,1]
  └─▅ [1]
</pre>
""")

# ╔═╡ 01de52e2-db1e-407c-b91d-c95726b36007
md"""
## Beispiel: Geldwechseln

OK. Ein finanzielles Thema: Geldwechseln! Wie viele Möglichkeiten
gibt es $100$ cent mit Münzen zu stückeln? z.B. $2$ mal $50$ cent; oder $10$ mal $10$ cent; usw.

Wir hätten gerne für einen beliebigen Cent-Betrag $n$ die Aufzählung(!) aller
Möglichkeiten!

---

**Einschub:**

Wie (hoffentlich) aus anderen Veranstaltungen bekannt, kann man die Anzahl(!) der
Möglichkeiten für jeden cent-Betrag $n$ aus der [Taylorentwicklung](https://tinyurl.com/mr3hhtfy) von

$$f(z)=\frac{1}{(1-z^1)(1-z^2)(1-z^5)(1-z^{10})(1-z^{20})(1-z^{50})(1-z^{100})(1-z^{200})}$$

um $z_0=0$ ablesen:

$1 + z + 2 z^2 + 2 z^3 + 3 z^4 + 4 z^5 + 5 z^6 + 6 z^7 + \cdots + +4366 z^{99} + 4563 z^{100} + 4710 z^{101} + \cdots$

Der Koeffizient des $z^n$-Terms gibt die Anzahl der Stückelungsmöglichkeiten an. Also gibt es $4563$ Möglichkeiten $100$ cent zu wechseln und $4710$ Möglichkeiten $101$ cent zu wechseln.

**Ende des Einschubs**

---

Zurück zur Aufzählung. Zunächst mal die möglichen Münzen ($2$€, $1$€, $50$ cent, usw.):
"""

# ╔═╡ f5f72da5-916a-4cf5-95b2-1549ea90554f
const münzen = [1, 2, 5, 10, 20, 50, 100, 200]  # Einheit: Cents

# ╔═╡ 9d7c4bfe-9524-4c3f-ab48-8522513916f4
md"""
Wie schreiben wir eine Stückelung auf? Wir können aufschreiben, wie viele Münzen
wir von jeder Sorte nehmen. Also z.B.
  * Variante: $2$ mal $50$ cent, $0$ mal der Rest: `[0, 0, 0, 0, 0, 2, 0, 0]`
  * Variante: $1$ mal $50$ cent, $5$ mal $10$ cent: `[0, 0, 0, 5, 0, 1, 0, 0]`
"""

# ╔═╡ 9c2ccc59-e5c2-4dbc-bd04-7f6a4fb17de7
let # wie kommt man von so einer Stückelung zum Betrag? z.B:
	stückelung = [0, 0, 0, 5, 0, 1, 0, 0]
	betrag = sum(stückelung .* münzen)
	@show betrag
end;

# ╔═╡ 934bd986-7e64-426a-a8f0-4ff8c9eb385f
md"""
Und jetzt? Wie läuft das rekursiv?

Fangen wir mal bei einem sehr kleinen Problem an: $0$ cent. Da gibt es genau
eine Stückelung: wir nehmen von jeder Münze $0$ Stück. Perfekt. Den Anfang
haben wir.
"""

# ╔═╡ 94746827-c47a-4561-b00f-04483ba2a3ba
function liefere_stückelungen_anfang(n)
	if n == 0
		return [zeros(Int, size(münzen))] # eine Liste mit genau einer Stückelung
	end
	error("Rest fehlt noch")
end

# ╔═╡ 3423f75d-f1cc-46db-b40a-4c46cee797cc
md"""
Nun für $n>0$, z.B. $n=78$. Alle Münzen, deren Wert über $n$ liegen,
brauchen wir nicht angucken. Und bei Münzen mit Wert $n$ oder darunter (z.B. 
$50$ cent Münze), haben wir die Wahl: Nehmen oder nicht. Also Stückelungen, wo $50$ cent vorkommen (mindestens $1$ mal) oder Stückelungen, wo 
$50$ cent niemals vorkommen.

Wir führen diese Rekursion anhand der größten Münze, die noch möglich ist, durch.

Und damit haben wir die Rekursionsidee: Wir suchen die größte Münze die
prinzipiell möglich ist (z.B. im Beispiel oben $50$ cent) und haben 2 Fälle:
   1. Fall: Wir nehmen eine $50$ cent Münzen; dann haben wir
      das gleiche Problem wieder nur mit einem um $50$ cent reduzierten
      Betrag (im Beispiel $28$ cent). Passt.
      Da rufen wir wieder die gleiche Funktion auf, um dessen Stückelungen
      zu bekommen und addieren bei allen Stückelungen einfach eine
      $50$ cent Münze.
   2. Fall: Wir nehmen keine $50$ cent Münze; dann haben wir
      das gleiche Problem wieder mit dem gleichen Betrag, aber mit
      der zusätzlichen Nebenbedingung, dass niemals mehr $50$ cent Münzen
      vorkommen dürfen. Wir müssen also in der Funktion zusätzlich
      als Eingabe mitschleppen/wissen, welche Münzen "erlaubt" sind.
      [irgendwas von der Form `münzen[1:k]`]

Und die möglichen Stückelungen sammeln wir in einer Liste auf.
"""

# ╔═╡ 1b66697e-3502-4369-ae6f-f649c819bd9d
"""
ermittle rekursiv alle Möglichkeiten den Geldbetrag n zu wechslen, wenn
`verwende_münzen` die erlaubten Münzen enthält.

Die Einträge in `verwende_münzen` müssen streng monoton steigen und
mit `1` beginnen!
"""
function liefere_stückelungen(n, verwende_münzen=münzen)
	ergebnis = Vector{Vector{Int}}() # hier kommen die Stückelungen rein
	if n == 0
		push!(ergebnis, zeros(Int, size(münzen))) # einzig mögliche Stückelung hinzu
	else # n > 0; wir suchen die größte Münze, die noch geht		
		index = length(filter(x -> x <= n, verwende_münzen)) # index gefunden
		münzwert = verwende_münzen[index]                    # zugehöriger Wert
		
		# 1. Fall: wir nehmen die Münze einmal (das merken wir uns)
		#          und haben noch einen Restbetrag n - münzwert	
        #          davon holen wir uns die Möglichen Stückelungen
		for stückelung in liefere_stückelungen(n-münzwert, verwende_münzen[1:index])
			stückelung[index] += 1      # addieren unsere 1 Münze
			push!(ergebnis, stückelung) # und speichern
		end
		
		# 2. Fall: wir nehmen die Münzen keinmal (auch später niemals mehr)
		#          Restbetrag ist n, aber erlaubten Münzen sind weniger
		#          und wir übernehmen die Stückelungen des (Rest-)Betrags.
		if index > 1 # klappt natürlich nur wenn wir nicht schon bei index 1 sind
			append!(ergebnis, liefere_stückelungen(n, verwende_münzen[1:index-1]))
		end
	end
	return ergebnis
end;

# ╔═╡ 71289113-0c53-4691-9f25-2509fffe610f
liefere_stückelungen(5)

# ╔═╡ 3bfbc551-0522-460d-b438-e2d1fd99403b
liefere_stückelungen(101) # tatsächlich 4710 Möglichkeiten

# ╔═╡ edcadb66-54e5-4e23-85b3-5cca515e8a99
md"""
Geht das auch iterativ? Klar. Aber schauen wir uns zunächst mal
den Fall an, dass wir die Münzen nicht als Eingabe bekommen, sondern vorab 
schon wissen, dass es (z.B.) die Euro-Münzen sein werden.

Wie sieht das dann iterativ aus?

Ein Beispiel: $78$ cent; da haben wir die Möglichkeiten mit $0$ oder $1$-mal
$50$ cent zu starten. Und in allen beiden Fällen gucken wir uns für den jeweiligen 
Restbetrag an und machen das gleiche Spiel für die $20$ cent Münze:
Wie viele Möglichkeiten für $20$ cent Stücke wir haben, etc.

In Code sieht es etwa so aus:
"""

# ╔═╡ ce0816f5-ea24-4310-9f66-2897a2f06c5f
function liefere_euro_stückelungen_iter(n)
	ergebnis = Vector{Vector{Int}}() # hier kommen die Stückelungen rein	
	max_200 = n ÷ 200 # wie oft geht die 200 cent Münze maximal rein
	for anz_200 in max_200:-1:0 # wir probieren alle aus
		rest_ohne_200 = n - anz_200*200
		max_100 = rest_ohne_200 ÷ 100 # wie oft geht die 100 cent Münze max. rein
		for anz_100 in max_100:-1:0 # wir probieren alle aus
			rest_ohne_100 = rest_ohne_200 - anz_100*100
			max_50 = rest_ohne_100 ÷ 50 # wie oft geht die 50 cent Münze max. rein
			for anz_50 in max_50:-1:0 # auch die probieren wir alle
				rest_ohne_50 = rest_ohne_100 - anz_50*50
				max_20 = rest_ohne_50 ÷ 20
				for anz_20 in max_20:-1:0
					rest_ohne_20 = rest_ohne_50 - anz_20*20
					max_10 = rest_ohne_20 ÷ 10
					for anz_10 in max_10:-1:0
						rest_ohne_10 = rest_ohne_20 - anz_10*10
						max_5 = rest_ohne_10 ÷ 5
						for anz_5 in max_5:-1:0
							rest_ohne_5 = rest_ohne_10 - anz_5*5
							max_2 = rest_ohne_5 ÷ 2
							for anz_2 in max_2:-1:0
								rest_ohne_2 = rest_ohne_5 - anz_2*2
								# der wird mit 1cent aufgefüllt
								push!(ergebnis, [rest_ohne_2, anz_2, anz_5, anz_10,
								                 anz_20, anz_50, anz_100, anz_200])
							end
						end
					end
				end
			end
		end
	end
	return ergebnis
end

# ╔═╡ c0428ffa-a4ed-4cca-83a3-260b1126eae3
md"""
Schön ist das nicht. Mache es schöner! Vielleicht hilft es, sich eine Idee zu überlegen, welche wieder mit beliebigen `verwende_münzen` funktioniert 
(natürlich mit den Bedingungen: die Einträge von `verwende_münzen` sind streng monoton steigend und beginnen mit $1$).
"""

# ╔═╡ 39fd032c-ba13-48af-84d7-894cca35253e
liefere_euro_stückelungen_iter(101)

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
# ╟─80cbcad8-7509-11ef-3815-c5e2f8b75cd4
# ╠═3d282e6d-1805-408a-8b57-8b2f309114d6
# ╠═664f2704-d5ca-44f7-9ad7-8bda8b384102
# ╠═ac6126e5-963d-4bf7-88d4-0cd0e6d9b2e3
# ╠═5aa3fad4-057b-4450-95c8-dc7db51b076a
# ╟─d253bee0-2676-4242-8019-60c8c575d18a
# ╟─b9752caa-025d-4166-89d4-5744e220e335
# ╟─207b7b55-73ae-4e1c-845f-5ec169c8afad
# ╟─8f96aca9-4aad-4280-b2dd-d76b8fd8cbb7
# ╠═12e1a8dc-2784-4275-bcbc-bec467f83106
# ╠═e51918b3-027e-4932-b869-c03490e808d4
# ╠═b8e8bc4d-806d-4cd8-b316-cc13ed116b9f
# ╠═d29e4769-e703-409b-a7ab-0f5cfacafdbb
# ╟─5ebe10d9-e50e-41ab-9073-959e44c610e4
# ╠═23c60b92-f633-4341-937d-69305ea713e8
# ╠═b0968894-07de-46a2-a38f-4371602446b3
# ╠═7a075396-a6a9-4010-a4f6-86afa87211b6
# ╠═048311ee-d97e-4e33-9ace-b936891c5c07
# ╠═55899a07-9032-41ae-adcb-4ea6ef6f72c0
# ╟─b162c5e2-3458-45eb-9431-6da3d063299d
# ╟─daf50473-46fb-480a-9d6e-e1d6ce82e85d
# ╠═c0c7c815-1465-48b4-96cc-093d77e2ed9b
# ╟─76dfe310-a5aa-4ddd-b8de-e987108679c0
# ╠═ef9fe3b4-60c5-434b-bbbe-8b863f58d63c
# ╠═2f92735c-ae9d-492a-9482-94a21e34f2a4
# ╠═67592314-7f41-49e6-9b01-1bfa5375f329
# ╠═6c038357-0aac-4b8d-a984-104b5e25e91d
# ╟─d29b1eea-1759-4457-b4b1-b3637f33f8aa
# ╟─0ebbaeb1-eed2-4eba-97f1-2e6c606ad182
# ╟─2ae96939-072e-4e48-816b-040a1249b1e8
# ╠═c60370d4-bc51-476d-8bdd-3104fa4f3b1e
# ╟─a5ca8579-71ec-44be-a58b-640c30ece456
# ╠═962e327e-ab50-4c6b-b649-8e8ce6bfacd5
# ╟─bd4a46c6-d197-4119-a628-5d68a4045673
# ╠═5e0d43ee-c5da-472c-9c33-ab38d105c727
# ╟─c00164c0-2a2e-4bb9-96f1-c42017439e60
# ╟─aa9a8572-e368-4bba-add0-13d5a5f5f828
# ╟─53d2dbd6-0df4-41d0-bc3f-45e2e591ac5d
# ╠═d842b707-1bf6-4a5e-915b-c09d900881d9
# ╠═865cf95d-c541-4c0b-81ab-f2cb898d35ef
# ╠═150281c0-2885-432e-b7ab-2723f4bf9e13
# ╠═a0e91685-b847-44ea-837e-2b2495f205e7
# ╠═b0db8623-b666-452c-8eff-1ab219052abb
# ╟─6f3b3513-fea0-4135-b425-52b9ec877e5e
# ╠═c8bb1583-a0ea-4f0b-98ce-27bb95dafbb9
# ╠═5c26b70f-786c-4159-a8ef-42663ffbbd60
# ╟─cfc18086-8ddc-499f-9307-f9008f33fc87
# ╟─dd0f4b99-a0e8-48f8-8ebb-098b69f21309
# ╟─01de52e2-db1e-407c-b91d-c95726b36007
# ╠═f5f72da5-916a-4cf5-95b2-1549ea90554f
# ╟─9d7c4bfe-9524-4c3f-ab48-8522513916f4
# ╠═9c2ccc59-e5c2-4dbc-bd04-7f6a4fb17de7
# ╟─934bd986-7e64-426a-a8f0-4ff8c9eb385f
# ╠═94746827-c47a-4561-b00f-04483ba2a3ba
# ╟─3423f75d-f1cc-46db-b40a-4c46cee797cc
# ╠═1b66697e-3502-4369-ae6f-f649c819bd9d
# ╠═71289113-0c53-4691-9f25-2509fffe610f
# ╠═3bfbc551-0522-460d-b438-e2d1fd99403b
# ╟─edcadb66-54e5-4e23-85b3-5cca515e8a99
# ╠═ce0816f5-ea24-4310-9f66-2897a2f06c5f
# ╟─c0428ffa-a4ed-4cca-83a3-260b1126eae3
# ╠═39fd032c-ba13-48af-84d7-894cca35253e
# ╟─4c6e716a-843e-4d0d-b1c7-a60dbdc4fa39
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
