using Statistics
export MarkovChainParameter,task_run

"""
    Parameters of Markov Chain
"""
struct MarkovChainParameter
    NToss::Int64 # The number of steps for thermalization, throw out in the head of a Markov chain
    NBlck::Int64 # The Number of Blocks in Markov Chain. See Block-Sample Method
    NSamp::Int64 # The Number of Samples in each Block. See Block-Sample Method
end

"""
    update a state machine (x) respect to a given method of:
        update!(x): no return value
        measure(x): return a data

    and write the result into data
        datastruct: a !!Mutable!! type, the original data collected in Markov Chain
"""
function task_run(x,update!::Function,measure::Function,datastruct::DataType,parameters::MarkovChainParameter) 
    data = Array{datastruct}(undef,parameters.NBlck)
    samp_data_buff = Array{datastruct}(undef,parameters.NSamp)

    for itoss = 1:parameters.NToss
        x = update!(x)
    end

    for iblck = 1:parameters.NBlck
        for isamp = 1:parameters.NSamp
            x = update!(x)
            samp_data_buff[isamp] = measure(x)
        end
        data[iblck] = mean(samp_data_buff)
    end

    return data
end