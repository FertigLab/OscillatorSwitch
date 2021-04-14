#Rsansale
#computeModelDerivative
#inputs: x, theta, omega,natural_omega, tau, cutofftheta, kxx, kthetatheta, kthetax, kxtheta, A, B, C, D
#outputs: dx, dtheta, domega 

computeModelDerivative <- function(x, theta, omega, natural_omega, tau, cutofftheta, kxx, kthetatheta, kthetax, 
                                   kxtheta, A, B, C, D){
  
  numSwitch = nrow(x)
  numOscillator = nrow(theta)
  
  # make other variables the correct dimension
  if (length(tau) == 1){
    tau2 = data.frame(rep(0, times = numSwitch))
    colnames(tau2) <- c("values")
    tau2$values = rep((tau*1), times = numSwitch)
    tau = tau2$values
    tau2 = NULL
  }
  
  wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")
  sprintf("%s/getBinaryValue.R", wd)
  source(sprintf("%s/getBinaryValue.R", wd))
  # get binary values for x and theta
  binX     = getBinaryValue(x, 0, c(0,1))
  binTheta = getBinaryValue(theta, cutofftheta, c(0,1))
  
  #write differential eq for x
  dx      = -x - tau + kxx*(A%*%binX) + kxtheta*(B%*%binTheta)
  # Creates the square matrix sin(\theta_j - \theta_i)
  thetasq = matrix(rep(theta, times = numOscillator), nrow = numOscillator, ncol = numSwitch)
  #delta   = matrix(sin(thetasq - t(thetasq)), nrow = nrow(theta), ncol = nrow(theta))
  delta = sin(thetasq-t(thetasq))
  # The differential equation for \theta
  dtheta  = omega + kthetatheta*diag(C%*%delta)

  # The rectangular matrix \tilde{x}_j \hat{\omega}_\mu - \omega_\mu
  onevec  = matrix(rep(1, times = length(x)), nrow = numOscillator, ncol = 1)
  #
  delom   = (binX %*% t(natural_omega)) - onevec %*% t(omega)
  # The differential equation for \omega
  domega  = kthetax*diag(D%*%delom)
  
  newList <- list("dx" = dx, "dtheta" = dtheta, "domega" = domega)
return(newList)
}


