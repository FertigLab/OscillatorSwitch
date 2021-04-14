#RSansale 3/22/20
#simulateCoupled function

#need to return a few different objects:
#time
#x (matrix)
#theta (matrix)
#omega (matrix)
#A (matrix)
#B (matrix)
#C (matrix)
#D (matrix)

#inputs
#t0, tf, delT, numOscillators, numSwitches, kxx, kxtheta, kthetax, kthetatheta
#pa, pb, pc, pd, tau, naturalFrequency, fileNameBase

simulateCoupled <- function(t0, tf, delT, numOscillators, numSwitches, kxx, kxtheta, kthetax, kthetatheta,
                            pa, pb, pc, pd, tau, naturalFrequency, fileNameBase){
  
  #initialize the variables
  time  = seq(t0, tf, by = delT)
  x     = matrix(0, nrow = numSwitches, ncol = length(time))
  theta = matrix(0, numOscillators, length(time))
  omega = matrix(0, numOscillators, length(time))
  
  #set the initial conditions
  x[, 1]    = rnorm(n = numSwitches, mean = 0, sd = 1)
  theta[,1] = 2*pi*runif(n = numOscillators, min = 0, max = 1)
  omega[,1] = naturalFrequency
  
  A = matrix(1, nrow = numOscillators, ncol = numSwitches)
  diag(A) <- 0

  B = matrix(1, nrow = numOscillators, ncol = numSwitches)
  C = matrix(1, nrow = numOscillators, ncol = numSwitches)
  diag(C) <- 0 
  
  D = matrix(1, nrow = numOscillators, ncol = numSwitches)

  mod <- function(x,m){
    tl <- floor(x/m)
    return(x-tl*m)
  }
  # run the simulation
  wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")
  sprintf("%s/computeModelDerivative.R", wd)
  source(sprintf("%s/computeModelDerivative.R", wd))
for(iTime in 2:length(time)){
  output = computeModelDerivative(as.matrix(x[,iTime-1]), as.matrix(theta[,iTime-1]), as.matrix(omega[,iTime-1]), naturalFrequency, tau, pi,
                                        kxx, kthetatheta, kthetax, kxtheta, A, B, C, D)
  x[, iTime]     = x[,iTime-1]     + output$dx%*%delT
  tchange = output$dtheta*delT
  ttchange = theta[,iTime-1] + tchange
  theta[,iTime] = mod((ttchange),2*pi)
  omega[,iTime] = omega[,iTime-1] + output$domega*delT
  iTime = iTime + 1
  if(iTime == length(iTime)){
    list <- list("x" = x, "omega" = omega, "theta" = theta)
    return(list)
  }
}


newlist <- list("x" = x, "omega" = omega, "theta" = theta)  
return(newlist)

  
}
