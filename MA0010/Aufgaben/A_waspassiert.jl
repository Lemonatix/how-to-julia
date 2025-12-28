### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 824205ac-9ae8-11f0-0316-5328e6156fbc
md"""
# Aufgabe: Was passiert?

Überlege, was julia als print-Output liefert, oder ob es zu einer Fehlermeldung kommt. Überprüfe anschließend Deine Überlegungen.
"""

# ╔═╡ 7eff1bc6-78ea-4c3e-aead-5ebb6d52a48a
function test1()
	for i in [1:4]
		print(i)
	end
end;

# ╔═╡ 8e4194ea-08f3-4f32-9352-c38d6a49c8af
function test2()
	println(2 .^ (1:4))
end;

# ╔═╡ df9afffa-a439-454b-8f14-deb6d6bf88f4
function test3()
	t = tuple(1,2,3); t[2] = 4; println(t)
end;

# ╔═╡ 34fb9676-38a8-461f-a9c4-6e7d361ba893
function test4()
	a = [[1,3,5,7], [2,4,6,8]]; b = a; b[2] = [4]; println(a)
end;

# ╔═╡ 76b0ba94-dd7d-4c92-b93a-bce45cfbecfb
function test5()
	function sum_rec(v)
		if v == 0   return 0  end
		return v[end] + sum_rec(v[1:end-1])
	end;
	print(sum_rec([1,2,3]))
end;

# ╔═╡ a54d72a8-4cc8-4c65-aa96-156cb6533be3
function test6()
	function myfunc(a)
		if a % 8 == 0   println(a); return  end
		myfunc(a-1)
		println(a)
	end
	myfunc(10)
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
# ╟─824205ac-9ae8-11f0-0316-5328e6156fbc
# ╠═7eff1bc6-78ea-4c3e-aead-5ebb6d52a48a
# ╠═8e4194ea-08f3-4f32-9352-c38d6a49c8af
# ╠═df9afffa-a439-454b-8f14-deb6d6bf88f4
# ╠═34fb9676-38a8-461f-a9c4-6e7d361ba893
# ╠═76b0ba94-dd7d-4c92-b93a-bce45cfbecfb
# ╠═a54d72a8-4cc8-4c65-aa96-156cb6533be3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
