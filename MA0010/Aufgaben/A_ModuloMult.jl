### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ eb5506c8-f2a7-4248-8ead-e589fc5b3d10
mul6(a,b) = (a*b) % 6;

# ╔═╡ d617ec3c-8e40-11f0-218f-9f7d4785eaab
md"""
# Modulo-Multiplikation

Wir betrachten $\cdot_n$ mit $a\cdot_nb := (a\cdot b)\mod n$. Das ist
"die Multiplikation modulo $n$". Hier ist die Multiplikationstabelle für $n=6$:

|  ⋅₆   | 1            | 2            | 3            | 4            | 5            |
|-------|--------------|--------------|--------------|--------------|--------------|
| **1** | $(mul6(1,1)) | $(mul6(1,2)) | $(mul6(1,3)) | $(mul6(1,4)) | $(mul6(1,5)) |
| **2** | $(mul6(2,1)) | $(mul6(2,2)) | $(mul6(2,3)) | $(mul6(2,4)) | $(mul6(2,5)) |
| **3** | $(mul6(3,1)) | $(mul6(3,2)) | $(mul6(3,3)) | $(mul6(3,4)) | $(mul6(3,5)) |
| **4** | $(mul6(4,1)) | $(mul6(4,2)) | $(mul6(4,3)) | $(mul6(4,4)) | $(mul6(4,5)) |
| **5** | $(mul6(5,1)) | $(mul6(5,2)) | $(mul6(5,3)) | $(mul6(5,4)) | $(mul6(5,5)) |

Oft ist (nur) wichtig, ob/wo in einer Zeile $0$ steht und ob/wo in einer Zeile
eine $1$ steht.

!!! correct "Aufgabe, Teil 1"
    Schreibe eine Funktion `mul_matrix(n)` welche für die Eingabe $n$
    eine $(n-1)\times (n-1)$-Charakter (`Char`) Matrix ausgibt,
    mit den Einträge `'0'`, `'1'` oder `' '` (Space), wobei Space
    für irgendetwas ungleich $0$/$1$ steht.

Beispiel
```
mul_matrix(12)
11×11 Matrix{Char}:
 '1'  ' '  ' '  ' '  ' '  ' '  ' '  ' '  ' '  ' '  ' '
 ' '  ' '  ' '  ' '  ' '  '0'  ' '  ' '  ' '  ' '  ' '
 ' '  ' '  ' '  '0'  ' '  ' '  ' '  '0'  ' '  ' '  ' '
 ' '  ' '  '0'  ' '  ' '  '0'  ' '  ' '  '0'  ' '  ' '
 ' '  ' '  ' '  ' '  '1'  ' '  ' '  ' '  ' '  ' '  ' '
 ' '  '0'  ' '  '0'  ' '  '0'  ' '  '0'  ' '  '0'  ' '
 ' '  ' '  ' '  ' '  ' '  ' '  '1'  ' '  ' '  ' '  ' '
 ' '  ' '  '0'  ' '  ' '  '0'  ' '  ' '  '0'  ' '  ' '
 ' '  ' '  ' '  '0'  ' '  ' '  ' '  '0'  ' '  ' '  ' '
 ' '  ' '  ' '  ' '  ' '  '0'  ' '  ' '  ' '  ' '  ' '
 ' '  ' '  ' '  ' '  ' '  ' '  ' '  ' '  ' '  ' '  '1'
```

!!! correct "Aufgabe, Teil 2"
    Schreibe eine Funktion `mul_tabelle(n)` welche die $0$- und
    die $1$-Einträge in der $\cdot_n$-Multiplikationstabelle
    schön (mit `print`) ausgibt:

Beispiel:
```
mul_tabelle(12)
  │         11
  │12345678901
──┼───────────
 1│1          
 2│     0     
 3│   0   0   
 4│  0  0  0  
 5│    1      
 6│ 0 0 0 0 0 
 7│      1    
 8│  0  0  0  
 9│   0   0   
10│     0     
11│          1
```
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
# ╟─d617ec3c-8e40-11f0-218f-9f7d4785eaab
# ╟─eb5506c8-f2a7-4248-8ead-e589fc5b3d10
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
