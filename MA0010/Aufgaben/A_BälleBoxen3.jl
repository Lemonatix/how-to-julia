### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 4de4d684-7755-11ef-10f6-89f91a77d583
md"""
# Bälle und Boxen (Teil 3)

Wir haben $n$ nummerierte Bälle (mit Nummern $1,2,\ldots,n$) und 
$k$ ununterscheidbare Boxen.

!!! correct "Aufgabe"
    Schreibe ein Programm welches alle Möglichkeiten ausgibt
    die $n$ Bälle auf die $k$ Boxen zu verteilen (leere Boxen sind erlaubt).

    Die Rückgabe soll eine Liste sein, wobei jedes Element der
    Liste eine Menge (Set) der Form

    ```
    Set( 
      Set(<Nummern der Bälle, die in einer Box zusammenliegen>),
      Set(<Nummern der Bälle, die in einer (anderen) Box zusammenliegen>), usw.
    )
    ```

    ist.
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
# ╟─4de4d684-7755-11ef-10f6-89f91a77d583
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
