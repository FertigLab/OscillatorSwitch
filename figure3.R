#figure 3

install.packages("dplyr")
library('dplyr')
#k = 0.0001
nSim   = 30
tMax   = 100

#this is creating 3, 100x10 matrices
#if you want to view the first matrix type: SystemState[1,,]
#the structure is: systemstate[matrix,row,col]
#SystemState = array(0, dim = c(length(kRange), nSim, 1))
SystemState = matrix(0, nrow = nSim, ncol = 1)

#start loop
numSwitches = 10
numOscillators = 10

#set a format for the decimals being printed
options(scipen = 6)

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

#simulateCoupled <- function(t0, tf, delT, numOscillators, numSwitches, kxx, kxtheta, kthetax, kthetatheta,
#                            pa, pb, pc, pd, tau, naturalFrequency, fileNameBase)


kxx = 0.1
kxtheta = 0.1
kthetax = 0.0001
kthetatheta = 0.4
sigw = 1


for(iSim in 1:nSim){
  print(c(k, sigw, iSim))
  print(Sys.time())
  source(sprintf("%s/simulateCoupled.R", wd))
  outputs <- simulateCoupled(t0 = 0, tMax,0.01,numOscillators,numSwitches, kxx ,kxtheta, kthetax ,kthetatheta ,1,1,1,1,1,sigw*rnorm(numOscillators, mean = 0, sd = 1))
  source(sprintf("%s/oscillatingSwitch.R", wd))
  oscillatoroutputs <- oscillatingSwitch(x = outputs$x, theta = outputs$theta)
  if(length(oscillatoroutputs)==1){
    SystemState[iSim, 1] <- oscillatoroutputs
  }else{
    SystemState[iSim, 1] <- oscillatoroutputs$switchType
  }
  print(oscillatoroutputs)
}

#naming convention: systemstate_numOscillatorsnumSwitches, systemstate_1010= system states from 10 oscillators and 10 switches
SystemState_1010 = SystemState
SystemState_1111 = SystemState








