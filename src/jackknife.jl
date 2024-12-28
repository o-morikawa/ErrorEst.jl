function jack1mk(data) # to make samples
    Ndata = length(data)
    sum = 0.0
    for i=1:Ndata
        sum+=data[i]
    end
    samples = zeros(Ndata)
    for i=1:Ndata
       samples[i]=(sum-data[i])/(Ndata-1)
    end
    return samples
end
function jack1er(samples) # to evaluate mean value and error
    Nsamples = length(samples)
    av = 0.0
    er = 0.0
    for i=1:Nsamples
        av+=samples[i]
        er+=samples[i]^2
    end
    av/=Nsamples
    er/=Nsamples
    er = sqrt( (er-av^2)*(Nsamples-1) )
    return av,er
end


data = [1,2,3,4,5,6]
samples = jack1mk(data)

Nsamples = length(samples)
for i=1:Nsamples
    # Oi = f(samples[i])
    # samples[i] = Oi
end

av, er = jack1er(samples) # <O>+/-er
println("$av +/- $er")
