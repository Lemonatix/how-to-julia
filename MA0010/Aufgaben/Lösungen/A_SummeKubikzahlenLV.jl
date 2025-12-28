### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 53d6a852-743e-11ef-34c3-8d8d750da1de
md"""
# Aufgabe: Summe von Kubikzahlen

Es gilt

$1^3 + 2^3 + 3^3 + 4^3 + \cdots + n^3 = (1+2+3+4+\cdots+n)^2 \qquad \forall n\in\mathbb{N}.$

!!! correct "Aufgabe"
    Schreibe ein Programm, welches für ein vorgebenes $m$ die linke und die rechte       Seite für alle $n\in\{1,2,\ldots,m\}$ berechnet und die Ergebnisse in 
    einer $\mathbb{N}^{m\times 2}$ Matrix speichert (die linke Seiten in der ersten
    Spalte und die rechten Seiten in der 2. Spalte).

    Überlege wie viele Rechenoperationen (Additionen, Multiplikationen)
    Dein Programm in Abhängigkeit von $m$ benötigt.

    Schreibe eine Variante die linear in $m$ skaliert!
"""

# ╔═╡ b00835aa-3692-4926-abed-7cdd405a3aed
function Vorschlag1(m)
    M = zeros(Int,m,2)   
    for n=1:m
        v = 1:n
        M[n,1] = sum(v.^3)  # 3*n Multiplikationen und (n-1) Additionen
        M[n,2] = sum(v)^2   # (n-1) Additionen und 1 Multiplikation
    end
    return M                # Gesamtaufwand: 2.5m² + 1.5m
end;

# ╔═╡ 3018887e-2c1d-4beb-a103-e3d577674277
Vorschlag1(4)

# ╔═╡ 997cd8f6-7ec5-434a-be00-59d360951ec9
function Vorschlag2(m)
    M = ones(Int,m,2)   
    for n=2:m
        M[n,1] = M[n-1,1] + n^3 # 3 Multiplikationen und 1 Addition
        M[n,2] = M[n-1,2] + n   # 1 Addition
    end
    M[:,2] .^= 2                # m Multiplikationen
    return M                    # Gesamtaufwand: 5m - 4
end;

# ╔═╡ d76d3563-abc1-41b6-8ce5-cf6520fe815b
Vorschlag2(4)

# ╔═╡ a611399b-cec6-4605-812a-5e5dd0422c92
md"""
Hier eine Kurzschreibeweise für Vorschlag 1 (mit Comprehensions, siehe 07_Arrays)
"""

# ╔═╡ 97b93e6e-5725-47ef-9dfc-9d067ae527de
Vorschlag3(m) = reduce(vcat, [sum((1:n).^3)  sum(1:n)^2] for n in 1:m)

# ╔═╡ 755b05cd-9681-4e10-8514-ca3a04c016db
Vorschlag3(5)

# ╔═╡ 86f8af03-6d45-4c24-a7af-ca96af43a48b
md"""
Und hier eine Schreibweise, die ganz ganz nah am Text der Aufgabenstellung
ist. Auch der Gleiche Aufwand wie Vorschlag 1:
"""

# ╔═╡ 2eed46ba-9ba8-4e2d-970a-538f12bce3bc
Vorschlag4(m) = [ 
	spalte == 1 ? sum((1:n).^3) : sum(1:n)^2 
	for n in 1:m, spalte in 1:2]

# ╔═╡ 07f9b584-313a-4d34-a5a0-2cc65fff3f58
Vorschlag4(5)

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
# ╟─53d6a852-743e-11ef-34c3-8d8d750da1de
# ╠═b00835aa-3692-4926-abed-7cdd405a3aed
# ╠═3018887e-2c1d-4beb-a103-e3d577674277
# ╠═997cd8f6-7ec5-434a-be00-59d360951ec9
# ╠═d76d3563-abc1-41b6-8ce5-cf6520fe815b
# ╟─a611399b-cec6-4605-812a-5e5dd0422c92
# ╠═97b93e6e-5725-47ef-9dfc-9d067ae527de
# ╠═755b05cd-9681-4e10-8514-ca3a04c016db
# ╟─86f8af03-6d45-4c24-a7af-ca96af43a48b
# ╠═2eed46ba-9ba8-4e2d-970a-538f12bce3bc
# ╠═07f9b584-313a-4d34-a5a0-2cc65fff3f58
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
