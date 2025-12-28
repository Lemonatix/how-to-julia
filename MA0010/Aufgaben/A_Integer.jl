### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ 326664dd-797d-4742-981a-1d09864c77fb
using Printf

# ╔═╡ 993b64f2-9ae7-11f0-3a9e-3b4a4ff52211
md"""
# Aufgabe

!!! correct "Aufgabe zu Integer-Zahlen"
    1. Die beiden `Int8` Zahlen $a$, $b$
       sehen auf Bitebene so aus: $a\colon\,11111100$ und $b\colon\,00100001$.
       Gib $a$ und $b$ in Dezimalschreibweise an und
       notiere die Bitdarstellung von `a+b`.
    2. julia rechnet (siehe unten): Welche Werte stimmen 
       mit $2^k$ (für $k\in\{60,\ldots,64\}$) überein?
       Welche nicht? Erkläre, was passiert.
    3. Sei `a = Int8(77)`. Gib alle `Int8`-Zahlen `b`
       an, die in julia `a + b < a` erfüllen.
    4. Sei `c = UInt8(77)`. Gib alle `UInt8`-Zahlen `d`
       an, die in julia `c + d < c` erfüllen.
"""

# ╔═╡ 2fc57794-3b06-4068-b12f-e0e5db25c950
begin  # Rechnung zu 2.
	@show 2 ^ 60
	@show 2 ^ 61
	@show 2 ^ 62
	@show 2 ^ 63
	@show 2 ^ 64
end;

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.7"
manifest_format = "2.0"
project_hash = "f604830d70fa58877def5710c5d1fa32dcb3f998"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"
"""

# ╔═╡ Cell order:
# ╟─993b64f2-9ae7-11f0-3a9e-3b4a4ff52211
# ╠═2fc57794-3b06-4068-b12f-e0e5db25c950
# ╟─326664dd-797d-4742-981a-1d09864c77fb
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
