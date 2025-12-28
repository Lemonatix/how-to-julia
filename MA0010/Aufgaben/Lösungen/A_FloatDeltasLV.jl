### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 6e79c5aa-7771-11ef-3888-05866905121a
md"""
# Spielen mit Gleitkommazahlen

!!! correct "Aufgabe (Teil 1)"
    Schreibe eine Funktion, welche (mittels einer Schleife) 
    das kleinstmögliche $n\in\mathbb{N}$ ermittelt, so dass bei 
    `Float64`-Rechnung
    $1.0 + 2.0^{-n} == 1.0$
    gilt.
"""

# ╔═╡ 8266be27-6be3-49ec-baac-95a75a16e829
function OnePlusTest()
  delta, n = 0.5, 1 # starten mit 2^(-1) = 0.5
  while 1.0 + delta != 1.0
    delta /= 2
    n += 1
  end
  return n
end

# ╔═╡ 9f554b9d-ab1d-48b6-9525-a1e8dfcbfe9f
OnePlusTest()

# ╔═╡ 83d86cd0-314f-4756-8d31-a3f698474447
md"""
!!! correct "Aufgabe (Teil 2)"
    Schreibe eine Funktion, welche (mittels einer Schleife) 
    das kleinstmögliche $n\in\mathbb{N}$ ermittelt, so dass bei 
    `Float64`-Rechnung
    $0.0 + 2.0^{-n} == 0.0$
    gilt.
"""

# ╔═╡ f840a22b-0fef-4797-8c4a-9018a4c1dcf6
function HalfMinTest()
  delta, n = 0.5, 1  # starte mit 2^(-1) = 0.5
  while 0.0 + delta != 0.0
    delta /= 2
    n += 1
  end
  return n
end

# ╔═╡ fbadb227-660b-46ac-8aac-31dc1f8d4ff4
HalfMinTest()

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
# ╟─6e79c5aa-7771-11ef-3888-05866905121a
# ╠═8266be27-6be3-49ec-baac-95a75a16e829
# ╠═9f554b9d-ab1d-48b6-9525-a1e8dfcbfe9f
# ╟─83d86cd0-314f-4756-8d31-a3f698474447
# ╠═f840a22b-0fef-4797-8c4a-9018a4c1dcf6
# ╠═fbadb227-660b-46ac-8aac-31dc1f8d4ff4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
