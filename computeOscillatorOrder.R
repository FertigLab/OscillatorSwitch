#computeOscillatorOrder
#R Sansale 7/1/20

#inputs: theta
#outputs: r, psi

computeOscillatorOrder <- function(theta){
  
numOscillators = nrow(theta)
numSim         = ncol(theta)

r   = rep(0, times = numSim)
psi = rep(0, times = numSim)

for(i in 1:numSim){
order      = (1/numOscillators)*sum(exp((1i*theta[,i])))
psi[i] = Arg(order)
#psi[i] = atan2(Im(order), Re(order))
r[i]   = abs(order)
}

list <- list("psi" = psi, "r" = r)
return(list)
}

