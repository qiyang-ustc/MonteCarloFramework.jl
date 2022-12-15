using MonteCarloFramework,Test,Statistics

f(x,y) = x*x+y*y < 1.0
update!(x) = f(rand(),rand())
measure(x) = 4*x
parameter = MarkovChainParameter(10,1000,1000)

@test mean(task_run(1.0,update!,measure,Float64,parameter))≈3.14 atol = 1E-2
