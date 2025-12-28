### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 812be222-a4e4-11f0-1baa-6d601171aef3
md"""
# Aufgabe: Sterne

Vorab *Achtung*: Das ist eine akademische Aufgabe. Die *Sinnfrage*
("Warum sollte man das wollen?") lohnt sich nicht zu stellen.

!!! correct "Aufgabe"
    Schreibe eine julia Funktion `sterne(n)`, die für eine natürliche
    Zahl $n>0$ einen String-Vektor mit $n$ Zeilen zurückliefert, wo
    im $k$. Eintrag $k$ Sterne sind.

Beispiel: `sterne(5)` sollte folgendes liefern:

```
5-element Vector{String}:
 "*"
 "**"
 "***"
 "****"
 "*****"
```

Versuche verschiedene Implementierungen ...
"""

# ╔═╡ fccb0c99-28cb-46af-9271-00c77518c1fd
sterne(n) = "*" .^ (1:n)

# ╔═╡ 41df8bc3-738f-416e-a224-261b185b708d
sterne(5)

# ╔═╡ f27949e9-cc15-4809-b173-0909c0241df8
foreach(println, sterne(5))

# ╔═╡ 6902c50c-fc3d-4b6b-b894-a3eefa5452cd
sterne2(n) = ["*"^k for k in 1:n]

# ╔═╡ b225a3ad-0e37-4999-8f58-4e6911458ac4
sterne3(n) = map(k -> "*"^k, 1:n)

# ╔═╡ 985822a6-a2b1-4b1b-8820-ff4d8b7d5a94
function sterne4(n)
	ergebnis = Vector{String}()
	for k in 1:n
		push!(ergebnis, "*"^k)
	end
	return ergebnis
end

# ╔═╡ 12f53451-4c65-4967-bee5-c3246fa3d628
sterne5(n) = accumulate(*, fill("*", n))

# ╔═╡ b7472ceb-7de5-4686-9893-ff77f1e58dab
sterne6(n) = n == 1 ? ["*"] : [sterne6(n-1)..., "*"^n]

# ╔═╡ 5140fc4c-af6f-407f-bf49-da76f4aa88f5
sterne7(n) = n == 1 ? ["*"] : map(x -> x*"*", ["", sterne7(n-1)...])

# ╔═╡ 067248f7-d57a-4105-87e6-30b039bdb775
function sterne8(n)
	ergebnis = fill("*", n)
	for line in 2:n
		ergebnis[line:n] .*= "*"
	end
	return ergebnis
end

# ╔═╡ 893f33f5-8103-4302-bb44-fe5afc2c48a5
struct sterne9_data
	n :: Integer
end

# ╔═╡ 6fe8059b-0cfe-42f0-8c3d-2860fcb72fd7
Base.iterate(s9data::sterne9_data, state=1) = state > s9data.n ? nothing : ("*"^state, state+1)

# ╔═╡ cb298193-bf2b-4fb2-ba46-2f0c70fcdaa4
Base.length(s9data::sterne9_data) = s9data.n

# ╔═╡ 62439a08-c43b-4184-8ee0-2eee5e1a824c
sterne9(n) = [sterne9_data(n)...]

# ╔═╡ d4826e63-726f-4c12-ad48-d0f1bec06ef6
function sterne10(n)
	aktuell = "*"^n
	ergebnis = Vector{String}()
	while !isempty(aktuell)
		pushfirst!(ergebnis, aktuell)
		aktuell = aktuell[1:end-1]
	end
	return ergebnis
end

# ╔═╡ b4a5f8ca-b622-4df3-a713-0fdf976cde63
sterne11(n) = [wert[1:k]  for k in 1:n for wert in ["*"^n]]

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
# ╟─812be222-a4e4-11f0-1baa-6d601171aef3
# ╠═fccb0c99-28cb-46af-9271-00c77518c1fd
# ╠═41df8bc3-738f-416e-a224-261b185b708d
# ╠═f27949e9-cc15-4809-b173-0909c0241df8
# ╠═6902c50c-fc3d-4b6b-b894-a3eefa5452cd
# ╠═b225a3ad-0e37-4999-8f58-4e6911458ac4
# ╠═985822a6-a2b1-4b1b-8820-ff4d8b7d5a94
# ╠═12f53451-4c65-4967-bee5-c3246fa3d628
# ╠═b7472ceb-7de5-4686-9893-ff77f1e58dab
# ╠═5140fc4c-af6f-407f-bf49-da76f4aa88f5
# ╠═067248f7-d57a-4105-87e6-30b039bdb775
# ╠═893f33f5-8103-4302-bb44-fe5afc2c48a5
# ╠═6fe8059b-0cfe-42f0-8c3d-2860fcb72fd7
# ╠═cb298193-bf2b-4fb2-ba46-2f0c70fcdaa4
# ╠═62439a08-c43b-4184-8ee0-2eee5e1a824c
# ╠═d4826e63-726f-4c12-ad48-d0f1bec06ef6
# ╠═b4a5f8ca-b622-4df3-a713-0fdf976cde63
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
