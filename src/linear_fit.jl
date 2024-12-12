using Plots

function linear_fit(chi::Array{Float64, 2})
    ## chi[:, 1] : x
    ## chi[:, 2] : y
    ## chi[:, 3] : dy
    dy2   = sum(chi[:, 3].^(-2))
    xdy2  = sum(chi[:, 1] .* (chi[:, 3].^(-2)))
    x2dy2 = sum((chi[:, 1].^2) .* (chi[:, 3].^(-2)))
    ydy2  = sum(chi[:, 2] .* (chi[:, 3].^(-2)))
    y2dy2 = sum((chi[:, 2].^2) .* (chi[:, 3].^(-2)))
    xydy2 = sum(chi[:, 1] .* chi[:, 2] .* (chi[:, 3].^(-2)))
    ## parameters:
    ##  a  delta_a
    ##  b  delta_b
    ##  rsc(reduced chi-square) d.o.f.
    par = zeros(Float64, 3, 2)
    dn = dy2 * x2dy2 - xdy2^2
    par[1,1] = ( dy2 * xydy2 - xdy2 * ydy2 ) / dn
    par[1,2] = sqrt( dy2 / dn )
    par[2,1] = ( x2dy2 * ydy2 - xdy2 * xydy2 ) / dn
    par[2,2] = sqrt( x2dy2 / dn )
    par[3,1] = ( y2dy2 - par[1,1] * xydy2 - par[2,1] * ydy2 ) / (size(chi, 1) - 2)
    par[3,2] = size(chi, 1)
    return par
end

m = [
0.2673	0.10166784268881983/0.2673	0.003703845345280128/0.2673
0.186	0.07945930204458417/0.186	0.007609934147031334/0.186
0.1326	0.0565588586448514/0.1326	0.017939631697030726/0.1326
]

println("Input:")
println(m)

res = linear_fit(m)
println("Fitting:")
println(res)

f(x) = res[1,1]*x+res[2,1]

plt = plot(m[:,1],m[:,2],yerror=m[:,3],seriestype=:scatter,label="Data")
plot!(plt,[0],[res[2,1]],yerror=[res[2,2]],seriestype=:scatter,label="Fit")
plot!(plt,f,xlims=(-0.01,0.275),label="Fit")
savefig("linear_fit.png")
