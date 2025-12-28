### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 9862bc0e-776d-11ef-1d2f-d34d7896e1e9
md"""
# Die Sache mit den Bienen und den Kindern

Wir betrachen (handlsübliche) Bienen: es gibt männliche Bienen (hier gerne mit `♂`
bezeichnet) und es gibt weibliche Bienen (hier Bezeichnung `♀`). Und die stammen
ab von ... anderen Bienen!

So eine männliche Biene hat genau eine Mutter und genau 0 Väter! [Klingt vielleicht komisch, ist aber so.] Und eine weibliche Biene hat genau eine Muter und genau einen Vater.

Damit kann man sich jetzt für Bienen-Stammbäume interessieren:
"""

# ╔═╡ 0d4ba677-fc82-4268-9c9b-9babdbbe2da5
HTML("""<pre style="font-family: monospace;">
       ♀ ♂ ♀ ♂ ♀ ♀ ♂ ♀ 
       │ ├─┘ ├─┘ │ ├─┘ 
       ♂ ♀   ♀   ♂ ♀   
       ├─┘   │   ├─┘   
       ♀     ♂   ♀     
       │     ├───┘     
       ♂     ♀         
       ├─────┘         
       ♀               
</pre>""")

# ╔═╡ 047b5c38-f68e-4b6e-b7af-2b69660d369b
md"""
Wir definieren mal ein paar Konstanten, die gleich helfen:
"""

# ╔═╡ ab856eab-0b6b-4292-b135-d4519ff387e2
begin
	const biene_männlich = "♂"
	const biene_weiblich = "♀"
	const linie_links = "│"
	const linie_abwzeig_links = "├"
	const linie_abzweig_links = "├"
	const linie_abzweig = "─"
	const linie_abzweig_rechts = "┘"
end;

# ╔═╡ cf0a385b-7ca2-4565-b858-8d11a7808866
md"""
!!! correct "Aufgabe (Teil 1)"
    Schreibe eine (rekursive) Funktion, die solche Stammbäume
    ausgibt. Dabei sind die Eingaben: mit welcher Biene (weiblich
    oder männlich) wird gestartet und wie viele Generationen
    sollen angezeigt werden.

    ```
      erzeuge_bienen_baum(biene_weiblich, 5)
      9-element Vector{String}:
       "♀ ♂ ♀ ♂ ♀ ♀ ♂ ♀ "
       "│ ├─┘ ├─┘ │ ├─┘ "
       "♂ ♀   ♀   ♂ ♀   "
       "├─┘   │   ├─┘   "
       "♀     ♂   ♀     "
       "│     ├───┘     "
       "♂     ♀         "
       "├─────┘         "
       "♀               "
    ```
"""

# ╔═╡ 781ce8b5-65aa-44c1-9cfa-69d184bb78aa
md"""
## Die Rekursionsidee
"""

# ╔═╡ c84d986f-7bc1-4cc5-a2f5-d01219dc7067
html"""
<pre>
<span style="color: red">♀ ♂ ♀</span> <span style="color: blue">♂ ♀ ♀ ♂ ♀ </span>
<span style="color: red">│ ├─┘</span> <span style="color: blue">├─┘ │ ├─┘ </span>
<span style="color: red">♂ ♀  </span> <span style="color: blue">♀   ♂ ♀   </span>
<span style="color: red">├─┘  </span> <span style="color: blue">│   ├─┘   </span>
<span style="color: red">♀    </span> <span style="color: blue">♂   ♀     </span>
<span style="color: red">│    </span> <span style="color: blue">├───┘     </span>
<span style="color: red">♂    </span> <span style="color: blue">♀         </span>
<span style="color: yellow">├─────┘         </span>
<span style="color: yellow">♀               </span>  
</pre>
"""

# ╔═╡ 0a38f920-bd05-44eb-b4cb-e1d67970873c
md"""
Wir kümmern uns nur um den gelben Teil unten (das sind also die letzten
beiden Zeilen). Den linken/roten Teil und den rechten/blauen Teil
erhalten wir durch den rekursiven Aufruf (geschenkt).
Wir müssen uns nur noch um das Zusammenbauen von rot und blau kümmern
und die beiden gelben Zeilen hinzufügen.

Falls die Biene in der letzten Zeile männlich ist, gibt es nur
einen linken/roten Baum und keinen rechten/blauen.

Wir beachten, dass alle Strings, die wir in die Liste schreiben, die
gleiche Breite haben. Diese Breite ist festgelegt durch die rote und
durch die blaue Breite.
"""

# ╔═╡ c7052a70-87ef-4b4d-b034-fe8c2a9e9911
function erzeuge_bienen_baum(sexus, levels) :: Vector{String}
  if levels == 1   return [sexus * " "]  end  # nur eine Zeile; also letzte Zeile
  if sexus == biene_männlich                  # Fallunterscheidung nach gelber Biene
    baum_li = erzeuge_bienen_baum(biene_weiblich, levels-1)  # nur Baum links
    rest_platz = " " ^ (length(baum_li[1]) - 1)              # soviel Spaces
    return [baum_li...,                  # neue Liste, baum_li/rot auspacken
            linie_links * rest_platz,    # Linie und Restplatz, damit gleich breit
            sexus       * rest_platz]    # letzte Zeile
  else
    baum_li = erzeuge_bienen_baum(biene_männlich, levels - 1) # baum_li/rot
    baum_re = erzeuge_bienen_baum(biene_weiblich, levels - 1) # baum_re/blau
    breite_li, breite_re = length(baum_li[1]), length(baum_re[1]) # jeweilige Breiten
    return [(baum_li .* baum_re)...,     # rot/blau komponentenweise verheften
            linie_abzweig_links  * linie_abzweig ^ (breite_li - 1) * # vorl. Zeile
            linie_abzweig_rechts *           " " ^ (breite_re - 1),
            sexus * " " ^ (breite_li + breite_re - 1)]               # letzte Zeile
  end
end

# ╔═╡ b521eb41-6fb5-4062-8e32-6f8c7a8a08b4
erzeuge_bienen_baum(biene_männlich, 5)

# ╔═╡ 6cd8f4be-a727-4579-987d-dad4928c6870
md"""
!!! correct "Aufgabe (Teil 2)"
    Schreibe eine Funktion, die die Ausgabe von `erzeuge_bienen_baum`
    nimmt und in jeder Generation die männlichen bzw. weiblichen Bienen zählt.
    Sie soll als Ausgabe zwei Listen zurücklieferen:
    `[Anz der weiblichen Bienen in Generation 1, 2, 3, etc.]` und
    `[Anz der männlichen Bienen in Generation 1, 2, 3, etc.]`.
    Was fällt an den Listen auf?
"""

# ╔═╡ 1e0638da-760f-4e92-a1e6-44a0b71623d8
md"""
Ein Blick auf so einen Stammbaum zeigt: die geraden Zeilen enthalten
nur die Verbindungsstücke. In den ungeraden Zeilen stehen die Infos
(also die Geschlechtssymbole), die uns interessieren.
"""

# ╔═╡ a334744d-69c5-4358-bc35-6ef95e1ca6a6
function zähle_sexus(baum::Vector{String})
	baum = baum[1:2:end-1]  # nehmen nur die ungeraden Zeilen; gerade sind Linien
	anz_weiblich = [length(findall(biene_weiblich, zeile)) for zeile in baum]
	anz_männlich = [length(findall(biene_männlich, zeile)) for zeile in baum]
	return reverse!(anz_weiblich), reverse!(anz_männlich)
end

# ╔═╡ d0263952-c4e1-4fd9-8776-7fae215c1d7b
zähle_sexus(erzeuge_bienen_baum(biene_männlich, 12))

# ╔═╡ 70717607-d732-4df9-bd41-fda433e85bc0
zähle_sexus(erzeuge_bienen_baum(biene_weiblich, 12))

# ╔═╡ cbc9b229-dbaf-483e-ba5d-9bd741f6204e
md"""
Ahhh: Ein alter bekannter: Fibonacci-Zahlen. Sie tauchen gerne dort auf,
wo es so ein (1, 2)-Konzept (wie männlich: 1 Elternteil, weiblich: 2 Elternteile)
auftritt.
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "da39a3ee5e6b4b0d3255bfef95601890afd80709"

[deps]
"""

# ╔═╡ Cell order:
# ╟─9862bc0e-776d-11ef-1d2f-d34d7896e1e9
# ╟─0d4ba677-fc82-4268-9c9b-9babdbbe2da5
# ╟─047b5c38-f68e-4b6e-b7af-2b69660d369b
# ╠═ab856eab-0b6b-4292-b135-d4519ff387e2
# ╟─cf0a385b-7ca2-4565-b858-8d11a7808866
# ╟─781ce8b5-65aa-44c1-9cfa-69d184bb78aa
# ╟─c84d986f-7bc1-4cc5-a2f5-d01219dc7067
# ╟─0a38f920-bd05-44eb-b4cb-e1d67970873c
# ╠═c7052a70-87ef-4b4d-b034-fe8c2a9e9911
# ╠═b521eb41-6fb5-4062-8e32-6f8c7a8a08b4
# ╟─6cd8f4be-a727-4579-987d-dad4928c6870
# ╟─1e0638da-760f-4e92-a1e6-44a0b71623d8
# ╠═a334744d-69c5-4358-bc35-6ef95e1ca6a6
# ╠═d0263952-c4e1-4fd9-8776-7fae215c1d7b
# ╠═70717607-d732-4df9-bd41-fda433e85bc0
# ╟─cbc9b229-dbaf-483e-ba5d-9bd741f6204e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
