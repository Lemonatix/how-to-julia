### A Pluto.jl notebook ###
# v0.20.19

using Markdown
using InteractiveUtils

# ╔═╡ 8f7bb2c2-7753-11ef-08d5-85313be6de3c
md"""
# Bälle und Boxen (Teil 1)

Es sind $n$ nummerierte Bälle (mit Nummern $1,2,\ldots,n$) und
$k$ nummerierte Boxen (mit Nummern $1,2,\ldots,k$) gegeben.

!!! correct "Aufgabe"
    Schreibe ein Programm welches alle Möglichkeiten ausgibt
    die $n$ Bälle auf die $k$ Boxen zu verteilen (leere Boxen
    sind erlaubt).

    Die Rückgabe soll eine Liste sein, wobei jeder Eintrag
    in der Liste ein Tuple der Form 

    `(<Box-Nummer für Ball 1>, <Box-Nummer für Ball 2>, usw.)`

    ist.
"""

# ╔═╡ Cell order:
# ╠═8f7bb2c2-7753-11ef-08d5-85313be6de3c
