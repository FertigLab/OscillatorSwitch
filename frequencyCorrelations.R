#plotSimulations
#R Sansale 7/1/20

#inputs: omega, omegahat, D, Nt
#outputs: rot, ro

# Produces the time-dependent correlation function r_\omega(t)
# and the time-averaged correlation function <r_\omega>_t.
# Inputs are the frequency \omega, the natural frequency \hat{\omega},
# the coupling matrix D, and number of time steps Nt.
fCorr<-function(omega, omegahat, D, Nt){
  Nx = nrow(D)
  No = nrow(D)
  # Calculation of the time-dependent correlation function
  # This will be a vector
  oh  = rep(omegahat,length(Nt)) 
  oh  = matrix(data = oh, nrow = Nx, ncol = length(Nt))
  rat = omega/oh
  rot = (colSums(D*rat))/Nx
  
  # Calculation of the time-averaged correlation function
  # This will be a scalar
  ro = sum(rot)/Nt
  
  list <- list("rot" = rot, "ro" = ro)
  return(list)
}