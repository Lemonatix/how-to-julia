using Plots
plotly()

n, R, γ = 1.0, 8.314, 1.4

V0, P0 = 0.5, 5e3

V_range  = range(0.01, 10.0, length=500)       
T_range  = range(100.0, 1000.0, length=500)  

T0       = 300.0
P_isoT   = n * R * T0 ./ V_range

P_ich    = n * R .* T_range ./ V0

V_isob   = n * R .* T_range ./ P0

C        = P_isoT[1] * V_range[1]^γ
P_ad     = C ./ V_range.^γ
T_ad     = P_ad .* V_range ./ (n * R)

plt = plot(
    V_range, fill(T0, length(V_range)), P_isoT;
    label="Isotherme (T=$(T0) K)", lw=2,
    legend=:topright
)

plot!(plt,
    fill(V0, length(T_range)), T_range, P_ich;
    label="Isochore (V=$(V0) m³)", lw=2
)
plot!(plt,
    V_isob, T_range, fill(P0, length(T_range));
    label="Isobare (P=$(P0) Pa)", lw=2
)
plot!(plt,
    V_range, T_ad, P_ad;
    label="Adiabate (γ=$(γ))", lw=2
)

xlabel!("V [m³]")
ylabel!("T [K]")
zlabel!("P [Pa]")
title!("Thermodynamische Prozesse im erweiterten P–V–T-Raum")
display(plt)
