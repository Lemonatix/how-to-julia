### A Pluto.jl notebook ###
# v0.19.46

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

# ╔═╡ c7052a70-87ef-4b4d-b034-fe8c2a9e9911
function erzeuge_bienen_baum(sexus, levels) :: Vector{String}
	if levels == 1   return [sexus * " "]  end
	error("Der Rest fehlt hier.")  
end

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

# ╔═╡ a334744d-69c5-4358-bc35-6ef95e1ca6a6
function zähle_sexus(baum::Vector{String})
	error("Der Rest fehlt hier.")  
end

# ╔═╡ d0263952-c4e1-4fd9-8776-7fae215c1d7b
# zähle_sexus(erzeuge_bienen_baum(biene_männlich, 12))

# ╔═╡ 70717607-d732-4df9-bd41-fda433e85bc0
# zähle_sexus(erzeuge_bienen_baum(biene_weiblich, 12))

# ╔═╡ Cell order:
# ╟─9862bc0e-776d-11ef-1d2f-d34d7896e1e9
# ╟─0d4ba677-fc82-4268-9c9b-9babdbbe2da5
# ╟─047b5c38-f68e-4b6e-b7af-2b69660d369b
# ╠═ab856eab-0b6b-4292-b135-d4519ff387e2
# ╟─cf0a385b-7ca2-4565-b858-8d11a7808866
# ╠═c7052a70-87ef-4b4d-b034-fe8c2a9e9911
# ╟─6cd8f4be-a727-4579-987d-dad4928c6870
# ╠═a334744d-69c5-4358-bc35-6ef95e1ca6a6
# ╠═d0263952-c4e1-4fd9-8776-7fae215c1d7b
# ╠═70717607-d732-4df9-bd41-fda433e85bc0
