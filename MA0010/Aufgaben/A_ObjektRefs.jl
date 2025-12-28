### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ 3634ba7c-7449-11ef-1fc8-db6ae4ea403e
md"""
# Aufgaben zu Objekt-Referenzen

!!! correct "Aufgabe"
    Überlege, was bei folgenden Funktionen passiert. Was wird ausgegeben?
    Kontrolliere Deine Vermutungen mit julia!
"""

# ╔═╡ 2dae4b55-b9bf-4a9b-b6ff-88b738fdfe1c
function A1()
	a = [1,2,3]
    b = a
    a[2] = 10
    b += [5,5,5]
	@show a
	@show b
end;

# ╔═╡ 74060976-ddd8-4547-9886-7f0d864d2117
# A1();

# ╔═╡ b14e3836-10a9-4ab6-a173-83a5b436251a
function A2()
	a = [1,2,3]
    b = a
    a[2] = 10
    b .+= [5,5,5]
	@show a
	@show b
end;

# ╔═╡ a0e8f295-418a-4b4c-bdc2-6d43161d16ed
# A2();

# ╔═╡ 77fcce9b-d618-425b-affd-50a342a7e069
function A3()
	a = [1,2,3]
    b = a
    a = ones(3)
    b += [5,5,5]
	@show a
	@show b
end;

# ╔═╡ 381a1e75-78b2-4a6b-8bbc-9f99b52a2f14
# A3();

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
# ╟─3634ba7c-7449-11ef-1fc8-db6ae4ea403e
# ╠═2dae4b55-b9bf-4a9b-b6ff-88b738fdfe1c
# ╠═74060976-ddd8-4547-9886-7f0d864d2117
# ╠═b14e3836-10a9-4ab6-a173-83a5b436251a
# ╠═a0e8f295-418a-4b4c-bdc2-6d43161d16ed
# ╠═77fcce9b-d618-425b-affd-50a342a7e069
# ╠═381a1e75-78b2-4a6b-8bbc-9f99b52a2f14
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
