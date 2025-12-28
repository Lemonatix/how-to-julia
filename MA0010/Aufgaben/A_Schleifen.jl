### A Pluto.jl notebook ###
# v0.20.18

using Markdown
using InteractiveUtils

# ╔═╡ 7651c1a8-8e3e-11f0-33dc-cd8c14de6586
md"""
# Aufgabe: Schleifen

!!! correct "Schleifen"
    Überlege, was folgenden Funktionen ausgeben werden und wo/ob es zu
    einem Fehler kommt. Teste Deine Vermutungen danach
    durch Ausführen der Funktionen.
"""

# ╔═╡ 438e69c3-b5ca-472c-a85b-8045f1cafe67
function schleife1()
	for k in range(1,3)
		println(k)
	end
end;

# ╔═╡ 109ccad0-f875-4f40-8e4b-90ca0467fcea
function schleife2()
	for k in 1:2:4
		println(k)
	end
end;

# ╔═╡ d3b95086-1577-49b4-be18-92c8d949a19a
function schleife3()
	for k in 1:-5
		println(k)
	end
end;

# ╔═╡ e694b59e-27d6-44b7-a7ba-1c4f210a7816
function schleife4()
	for k in 1:-5:-10
		println(k)
	end
end;

# ╔═╡ 4ad7714e-a05e-4d11-abea-6b66a2809784
function schleife5()
	for k in 1:3
		for j in k:5
			print(k*j, "  ")
		end
		println()
	end
end;

# ╔═╡ e8ea04c6-15b3-4903-9eea-677fbdbe9084
function schleife6()
	for j in k:5
		for k in 1:3
			print(k*j, "  ")
		end
		println()
	end
end;

# ╔═╡ 8f4f3133-1907-49e0-b5a5-2c7b8429f51f
function schleife7()
	for k in 1:2:10
		for j in 10:-2:1
			print(k % j, "  ")
		end
		println()
	end
end;

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
# ╟─7651c1a8-8e3e-11f0-33dc-cd8c14de6586
# ╠═438e69c3-b5ca-472c-a85b-8045f1cafe67
# ╠═109ccad0-f875-4f40-8e4b-90ca0467fcea
# ╠═d3b95086-1577-49b4-be18-92c8d949a19a
# ╠═e694b59e-27d6-44b7-a7ba-1c4f210a7816
# ╠═4ad7714e-a05e-4d11-abea-6b66a2809784
# ╠═e8ea04c6-15b3-4903-9eea-677fbdbe9084
# ╠═8f4f3133-1907-49e0-b5a5-2c7b8429f51f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
