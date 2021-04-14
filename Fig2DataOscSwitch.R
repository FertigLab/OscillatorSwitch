#Fig2DataOscSwitch.m
#Rsansale 4/20/20
#how do the macro-system dynamics change when cross coupling parameters change?

#write data to excel
install.packages("xlsx")
library("xlsx")
install.packages("dplyr")
library(dplyr)


#set constants to be used in the loop
kRange = c(0.0001,0.001, 0.01)
nSim   = 100
tMax   = 100

#this is creating 3, 100x10 matrices
#if you want to view the first matrix type: SystemState[1,,] 
#the structure is: systemstate[matrix,row,col]
#SystemState = array(0, dim = c(length(kRange), nSim, 1))
SystemState = matrix(0, nrow = nSim, ncol = 1)

#start loop
numSwitches = 100
numOscillators = 100

#set a format for the decimals being printed
options(scipen = 6)

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

k=0.0001
sigw = 10
for(iSim in 1:nSim){
print(c(k, sigw, iSim))
print(Sys.time())
source(sprintf("%s/simulateCoupled.R", wd))
outputs <- simulateCoupled(t0 = 0, tMax,0.01,100,100, 0.01,0.015,k,0.4,1,1,1,1,1,sigw*rnorm(100, mean = 0, sd = 1))
source(sprintf("%s/oscillatingSwitch.R", wd))
oscillatoroutputs <- oscillatingSwitch(x = outputs$x, theta = outputs$theta)
    if(length(oscillatoroutputs)==1){
        SystemState[iSim, 1] <- oscillatoroutputs
    }else{ 
        SystemState[iSim, 1] <- oscillatoroutputs$switchType
    }
             print(oscillatoroutputs)
}


states = cbind(SystemState_k0001_sigw1, SystemState_k0001_sigw2, SystemState_k0001_sigw3, SystemState_k0001_sigw4, SystemState_k0001_sigw5, SystemState_k0001_sigw6, SystemState_k0001_sigw7, SystemState_k0001_sigw8,SystemState_k0001_sigw9,SystemState_k0001_sigw10)
colnames(states) <- c('sigw1', 'sigw2', 'sigw3', 'sigw4', 'sigw5', 'sigw6', 'sigw7', 'sigw8', 'sigw9', 'sigw10') 

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/figure2_data/k0.0001.csv")
write.csv(states, wd, row.names = TRUE)




















#################
#k = 0.001
nSim   = 100
tMax   = 100

#this is creating 3, 100x10 matrices
#if you want to view the first matrix type: SystemState[1,,] 
#the structure is: systemstate[matrix,row,col]
#SystemState = array(0, dim = c(length(kRange), nSim, 1))
SystemState = matrix(0, nrow = nSim, ncol = 1)

#start loop
numSwitches = 100
numOscillators = 100

#set a format for the decimals being printed
options(scipen = 6)

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

k = 0.001
sigw = 10
for(iSim in 1:nSim){
  print(c(k, sigw, iSim))
  print(Sys.time())
  source(sprintf("%s/simulateCoupled.R", wd))
  outputs <- simulateCoupled(t0 = 0, tMax,0.01,100,100, 0.01,0.015,k,0.4,1,1,1,1,1,sigw*rnorm(100, mean = 0, sd = 1))
  source(sprintf("%s/oscillatingSwitch.R", wd))
  oscillatoroutputs <- oscillatingSwitch(x = outputs$x, theta = outputs$theta)
  if(length(oscillatoroutputs)==1){
    SystemState[iSim, 1] <- oscillatoroutputs
  }else{ 
    SystemState[iSim, 1] <- oscillatoroutputs$switchType
  } 
  print(oscillatoroutputs)
}

SystemState_k001_sigw1 = SystemState
SystemState_k001_sigw2 = SystemState
SystemState_k001_sigw3 = SystemState
SystemState_k001_sigw4 = SystemState
SystemState_k001_sigw5 = SystemState
SystemState_k001_sigw6 = SystemState
SystemState_k001_sigw7 = SystemState
SystemState_k001_sigw8 = SystemState
SystemState_k001_sigw9 = SystemState
SystemState_k001_sigw10 = SystemState

states = cbind(SystemState_k001_sigw1, SystemState_k001_sigw2, SystemState_k001_sigw3, SystemState_k001_sigw4, SystemState_k001_sigw5, SystemState_k001_sigw6, SystemState_k001_sigw7, SystemState_k001_sigw8,SystemState_k001_sigw9,SystemState_k001_sigw10)
colnames(states) <- c('sigw1', 'sigw2', 'sigw3', 'sigw4', 'sigw5', 'sigw6', 'sigw7', 'sigw8', 'sigw9', 'sigw10') 

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/figure2_data/k0.001.csv")
write.csv(states, wd, row.names = TRUE)
























#################
#k = 0.01
nSim   = 100
tMax   = 100

#this is creating 3, 100x10 matrices
#if you want to view the first matrix type: SystemState[1,,] 
#the structure is: systemstate[matrix,row,col]
#SystemState = array(0, dim = c(length(kRange), nSim, 1))
SystemState = matrix(0, nrow = nSim, ncol = 1)

#start loop
numSwitches = 100
numOscillators = 100

#set a format for the decimals being printed
options(scipen = 6)

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")

k = 0.01
sigw = 10
for(iSim in 1:nSim){
  print(c(k, sigw, iSim))
  print(Sys.time())
  source(sprintf("%s/simulateCoupled.R", wd))
  outputs <- simulateCoupled(t0 = 0, tMax,0.01,100,100, 0.01,0.015,k,0.4,1,1,1,1,1,sigw*rnorm(100, mean = 0, sd = 1))
  source(sprintf("%s/oscillatingSwitch.R", wd))
  oscillatoroutputs <- oscillatingSwitch(x = outputs$x, theta = outputs$theta)
  if(length(oscillatoroutputs)==1){
    SystemState[iSim, 1] <- oscillatoroutputs
  }else{ 
    SystemState[iSim, 1] <- oscillatoroutputs$switchType
  } 
  print(oscillatoroutputs)
}


SystemState_k001_sigw10 = SystemState

states = cbind(SystemState_k001_sigw1, SystemState_k001_sigw2, SystemState_k001_sigw3, SystemState_k001_sigw4, SystemState_k001_sigw5, SystemState_k001_sigw6, SystemState_k001_sigw7, SystemState_k001_sigw8,SystemState_k001_sigw9,SystemState_k001_sigw10)
colnames(states) <- c('sigw1', 'sigw2', 'sigw3', 'sigw4', 'sigw5', 'sigw6', 'sigw7', 'sigw8', 'sigw9', 'sigw10') 

wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/figure2_data/k0.01.csv")
write.csv(states, wd, row.names = TRUE)










k0001 <- data.frame(read.csv("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/figure2_data/k0.0001.csv"))
k001 <- data.frame(read.csv("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/figure2_data/k0.001.csv"))
k01 <- data.frame(read.csv("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/figure2_data/k0.01.csv"))

agg_state1_k0001 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
k0001_sig <- k0001[,i]
agg_state1_k0001[i,1] <- data.frame(table(k0001_sig))[1,2]
}

agg_state2_k0001 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
k0001_sig <- k0001[,i]
agg_state2_k0001[i,1] <- data.frame(table(k0001_sig))[2,2]
}

agg_state3_k0001 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
  k0001_sig <- k0001[,i]
  agg_state3_k0001[i,1] <- data.frame(table(k0001_sig))[3,2]
}

agg_k0001<- data.frame(cbind(agg_state1_k0001$frequency, agg_state2_k0001$frequency, agg_state3_k0001$frequency))
colnames(agg_k0001) <- c('freq_1_0001', 'freq_2_0001', 'freq_3_0001')




####k001
agg_state1_k001 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
  k001_sig <- k001[,i]
  agg_state1_k001[i,1] <- data.frame(table(k001_sig))[1,2]
}

agg_state2_k001 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
  k001_sig <- k001[,i]
  agg_state2_k001[i,1] <- data.frame(table(k001_sig))[2,2]
}

agg_state3_k001 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
  k001_sig <- k001[,i]
  agg_state3_k001[i,1] <- data.frame(table(k001_sig))[3,2]
}

agg_k001<- data.frame(cbind(agg_state1_k001$frequency, agg_state2_k001$frequency, agg_state3_k001$frequency))
colnames(agg_k001) <- c('freq_1_001', 'freq_2_001', 'freq_3_001')



####k01
agg_state1_k01 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
  k01_sig <- k01[,i]
  agg_state1_k01[i,1] <- data.frame(table(k01_sig))[1,2]
}

agg_state2_k01 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
  k01_sig <- k01[,i]
  agg_state2_k01[i,1] <- data.frame(table(k01_sig))[2,2]
}

agg_state3_k01 <- data.frame(frequency = rep(0,times = 10), sigw = seq(1,10, by=1))
for(i in 1:10){
  k01_sig <- k01[,i]
  agg_state3_k01[i,1] <- data.frame(table(k01_sig))[3,2]
}
is.na(agg_state3_k01$frequency) <- 0

agg_k01<- data.frame(cbind(agg_state1_k01$frequency, agg_state2_k01$frequency, agg_state3_k01$frequency))
colnames(agg_k01) <- c('freq_1_01', 'freq_2_01', 'freq_3_01')


all_sims <- data.frame(cbind(agg_k01,agg_k001,agg_k0001))
is.na(all_sims) <- 0

savepath = ("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code/figure2_plots/frequencies.pdf")
pdf(file = savepath)
par(mfrow = c(3,1))
plot(x = seq(1,10, by = 1), y =all_sims$freq_1_01, type = 'l', lty = 1, lwd = 3, col = 'firebrick', xlim = c(1,10), ylim = c(0,100), main = c('Frequency of Occurance of Dynamics in Figure 1'), xlab = c('sigma_omega'), ylab = c('Frequency'))
lines(x = seq(1,10, by = 1), y =all_sims$freq_1_001, type = 'l', lty = 2, lwd = 3, col = 'dodgerblue')
lines(x = seq(1,10, by = 1), y =all_sims$freq_1_0001, type = 'l', lty = 3, lwd = 3, col = '#FFCC33')
legend(x = 1, y = 85, legend = c('k = 1', 'k = 0.1', 'k = 0.01'), col = c('firebrick', 'blue', '#FFCC33'), lty = c(1,2,3))
plot(x = seq(1,10, by = 1), y =all_sims$freq_2_01, type = 'l', lty = 1, lwd = 3, col = 'firebrick', xlim = c(1,10), ylim = c(0,100), xlab = c('sigma_omega'),  ylab = c('Frequency'))
lines(x = seq(1,10, by = 1), y =all_sims$freq_2_001, type = 'l', lty = 2, lwd = 3, col = 'dodgerblue')
lines(x = seq(1,10, by = 1), y =all_sims$freq_2_0001, type = 'l', lty = 3, lwd = 3, col = '#FFCC33')
plot(x = seq(1,10, by = 1), y =all_sims$freq_3_01, type = 'l', lty = 1, lwd = 3, col = 'firebrick', xlim = c(1,10), ylim = c(0,100), xlab = c('sigma_omega'),  ylab = c('Frequency'))
lines(x = seq(1,10, by = 1), y =all_sims$freq_3_001, type = 'l', lty = 2, lwd = 3, col = 'dodgerblue')
lines(x = seq(1,10, by = 1), y =all_sims$freq_3_0001, type = 'l', lty = 3, lwd = 3, col = '#FFCC33')
dev.off()


