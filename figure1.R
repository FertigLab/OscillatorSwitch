#Rsansale figure 1 3/22/20

install.packages("dplyr")
library(dplyr)



#timing of simulations
tMax = 100

#Number of simulations
nSim = 0

#Everything "On"
onSimType = 0
kOn = 0.01
kOtherOn = 0.015
kttOn = 0.4
kxxOn = 0.11
sigwOn = 10
onSimType = 0

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

#start the while loop
while (onSimType != 1){
nSim       = nSim+1
omegaHatOn = sigwOn*rnorm(100, mean = 0, sd = 1)

#output from simulatecoupled will be 3 objects
#x, omega, theta, all 3 are matrices
sprintf("%s/simulateCoupled.R", wd)
source(sprintf("%s/simulateCoupled.R", wd))
#simulateCoupled <- function(t0, tf, delT, numOscillators, numSwitches, kxx, kxtheta, kthetax, kthetatheta,
#                            pa, pb, pc, pd, tau, naturalFrequency, fileNameBase)
outputs <- simulateCoupled(0, tMax,0.01, 100, 100, kxxOn,kOtherOn,kOn,kttOn,1,1,1,1,1,omegaHatOn)

#put these values through the oscillating switch
sprintf("%s/oscillatingSwitch.R", wd)
source(sprintf("%s/oscillatingSwitch.R", wd))
onSimType <- oscillatingSwitch(outputs$x, outputs$theta)
}

#now plot
sprintf("%s/plotSimulations.R", wd)
source(sprintf("%s/plotSimulations.R", wd))
fig1OnCol = plotSimulations(t = ncol(outputs$x), x = outputs$x,theta = outputs$theta, omega = outputs$omega, omegahat = omegaHatOn,title = "Oscillators synchronize and switches stay on", savepath = "/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_plots/everythingon.pdf")

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_data/everythingon_data.csv")
write.csv(outputs, wd, row.names = TRUE)


















#Oscillators freeze and switches stay off
nSim       = 0
offSimType = 0
kOff       = 0.01
kOtherOff  = 0.015
kttOff     = 0.4
kxxOff     = 0.01
sigwOff    = 10
tFirst     = 0

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

while(offSimType !=3|tFirst<20){
omegaHatOff = sigwOff*rnorm(100, mean = 0, sd = 1)
sprintf("%s/simulateCoupled.R", wd)
source(sprintf("%s/simulateCoupled.R", wd))
outputs <- simulateCoupled(0, tMax, 0.01, 100,100, kxxOff, kOtherOff, kOff, kttOff, 1,1,1,1,1,omegaHatOff)

#put these values through the oscillating switch
sprintf("%s/oscillatingSwitch.R", wd)
source(sprintf("%s/oscillatingSwitch.R", wd))
offSimType <- oscillatingSwitch(outputs$x, outputs$theta)
if(length(offSimType) > 1){
  tFirst    = offSimType$idxFirst
  offSimType = offSimType$switchType
}
nSim      = nSim+1
print(c(nSim,offSimType))
}

#now plot the outputs
sprintf("%s/plotSimulations.R", wd)
source(sprintf("%s/plotSimulations.R", wd))
fig1OffCol = plotSimulations(t = ncol(outputs$x), x = outputs$x,theta = outputs$theta, omega = outputs$omega, omegahat = omegaHatOff, title = "Oscillators freeze and switches stay off", savepath = "/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_plots/everythingoff4.pdf")

#set where to save
wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_data/everythingoff_data.csv")
write.csv(outputs, wd, row.names = TRUE)
















#Switches in sync with oscillators
nSim         = 0
oscSimType   = 0
kOsc         = 0.002
kOtherOsc    = 1.6
kttOsc       = 0.42
kxxOsc       = 0.01
sigwOsc      = 3
validTiming  = FALSE

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

while (oscSimType != 2){
omegaHatOsc = sigwOsc*rnorm(100, mean = 0, sd = 1)
sprintf("%s/simulateCoupled.R", wd)
source(sprintf("%s/simulateCoupled.R", wd))
#simulateCoupled <- function(t0, tf, delT, numOscillators, numSwitches, kxx, kxtheta, kthetax, kthetatheta,
#pa, pb, pc, pd, tau, naturalFrequency, fileNameBase)
outputs <- simulateCoupled(0, tMax, 0.01, 100, 100, kxxOsc, kOtherOsc, kOsc, kttOsc, 1, 1, 1, 1, 1, omegaHatOsc)

sprintf("%s/oscillatingSwitch.R", wd)
source(sprintf("%s/oscillatingSwitch.R", wd))
oscSimType <- oscillatingSwitch(outputs$x, outputs$theta, 100)
if(length(offSimType) > 1){
  tFirst    = oscSimType$idxFirst
  offSimType = oscSimType$switchType
}
nSim = nSim+1
print(c(nSim, oscSimType))
}

#now plot the outputs
sprintf("%s/plotSimulations.R", wd)
source(sprintf("%s/plotSimulations.R", wd))
fig1OscCol = plotSimulations(t = ncol(outputs$x), x = outputs$x, theta = outputs$theta, omega = outputs$omega, omegahat = omegaHatOsc,title = "oscillators synchronize and
switches oscillate", savepath = "/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_plots/switchsyncosc.pdf")

#set where to save
wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_data/switchsyncosc_data.csv")
write.csv(outputs, wd, row.names = TRUE)














#switches out of sync, temporary oscillations
nSwitchOscNoSync = 0
nSim             = 0
validTiming      = FALSE
oscSimNoSync     = 0

kxx = 0.001
kxtheta = 0.014
kthetax = 0.02
ktt = 0.018
sigw = 10

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

while(oscSimNoSync!= 2){
omegaHatNoSync = sigw*rnorm(100, mean = 0, sd = 1)
sprintf("%s/simulateCoupled.R", wd)
source(sprintf("%s/simulateCoupled.R", wd))

#simulateCoupled <- function(t0, tf, delT, numOscillators, numSwitches, kxx, kxtheta, kthetax, kthetatheta,
#pa, pb, pc, pd, tau, naturalFrequency, fileNameBase)
outputs <- simulateCoupled(0,100,0.01,100,100,kxx,kxtheta,kthetax,ktt,1,1,1,1,1,omegaHatNoSync)

sprintf("%s/oscillatingSwitch.R", wd)
source(sprintf("%s/oscillatingSwitch.R", wd))
oscSimNoSync <-oscillatingSwitch(outputs$x, outputs$theta,50)
if(length(oscSimNoSync) > 1){
  tFirst    = oscSimNoSync$idxFirst
  oscSimNoSync = oscSimNoSync$switchType
}
nSim      = nSim+1
print(c(nSim,oscSimNoSync))
}

#now plot the outputs
sprintf("%s/plotSimulations.R", wd)
source(sprintf("%s/plotSimulations.R", wd))
fig1OscCol = plotSimulations(t = ncol(outputs$x), x = outputs$x, theta = outputs$theta, omega = outputs$omega, title = "transitory oscillations in oscillators and switches", omegahat = omegaHatNoSync, savepath = "/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_plots/oscSimNoSync5.pdf")

#set where to save
wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/Figure1_data/oscSimNoSync_data4.csv")
write.csv(outputs, wd, row.names = TRUE)























