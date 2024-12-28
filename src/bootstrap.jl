using Statistics
using Random
using Dates

function boot1mk(
    data,
    n_boot::Int
)
    #Random.seed!(123)
    t0 = Dates.DateTime(2024,1,1,16,10,7)
    t  = Dates.now()
    Random.seed!(Dates.value(t-t0))

    Ndata = length(data)
    samples = zeros(Ndata, n_boot)
    for j = 1:n_boot
        for i = 1:Ndata
            r = rand(1:Ndata)
            samples[i,j] = data[r]
        end
    end
    return samples
end

function boot1er(
    data,
    samples
)
    Ndata, Nboot = size(samples)
    ave = mean(data)

    av_boot = zeros(Nboot)
    av_bias = 0.0
    er = 0.0
    for j = 1:Nboot
        for i = 1:Ndata
            av_boot[j] += samples[i,j]/Ndata
        end
        av_bias += av_boot[j]/Nboot
        er += av_boot[j]^2
    end
    er = sqrt( (er-av_bias^2)/(Nboot-1) )
    return av_bias, er / sqrt(Ndata), av_bias-ave
end

a = [11,9,9,12,5,8,7,12,13,14,18,15]
samples = boot1mk(a, 200)
b = boot1er(a, samples)  # boot_ave, boot_er, boot_bias
