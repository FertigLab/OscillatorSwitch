#Oscillating Switch
#R Sansale 4/1/20


#install.packages("magrittr")

#install.packages("dplyr")
#inputs: x,theta,switchTiming
#outputs: switchType, oscillatorType, idxFirst, validTiming, numSwitch

#switchTiming default value = 1
oscillatingSwitch <- function(x, theta, switchTiming = 1) {

#specify validTiming output variable of interest
validTiming = NULL
numSwitch   = 0

#set oscillator type
oscillatorType  = 'na'

#get binary values
wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")
sprintf("%s/getBinaryValue.R", wd)
source(sprintf("%s/getBinaryValue.R", wd))
# get binary values for x 
xMean = getBinaryValue(x, 0, c(0,1)) %>% as.matrix()

#now sum the xMean value by column
xMean = colSums(xMean) %>% as.matrix() %>% t()

#set idxFirst variable
idxFirst = which(xMean == 0) %>% as.matrix() %>% t()
if (length(idxFirst) ==0){
  switchType = 1
  return(switchType)
} 

idxFirst = idxFirst[1]


#now find when we go back to equilibrium, i.e. when xMean returns to 0
#nextIdx = which(xMean[,idxFirst:ncol(xMean)] == nrow(xMean))
nextIdx = which(xMean[,idxFirst:ncol(xMean)] == 0) %>% as.matrix() %>% t()
numSwitch = 1
if (length(nextIdx)==1){
  switchType = 3
}

#were finding where the switches/oscillators go into equilibrium
#few different ways the system will enter equilibrium
#it can bounce in and out of equilibrium rapidly before settling
#it can enter equilibrium and stay there
#this next few lines looks at when the system next attains or leaves equilibrium
#based on what we want the simulation to do we choose how long the system needs to be in equilibrium
#before exiting the simulation

#finding the number of time steps between the next instances of nonzero xMean values
nextIdxDiff = max(nextIdx[1,2:ncol(nextIdx)] - nextIdx[1,1:ncol(nextIdx)-1])
#count the max number of time steps between nonzero column values
numSwitch = length(nextIdxDiff >= switchTiming)

#now adjust the switchtype variable based on the nextIdxDiff
if (nextIdxDiff > 1) {
  switchType = 2
  return(switchType)
}

#switch timing has a default value of 1
if (nextIdxDiff >= switchTiming){
  validTiming = TRUE
}

#if the final element in the xMean row vector is equal to 0 then switchType = 3
if (xMean[,ncol(xMean)] == 0){
  switchType=3
}else{
  switchType = 1
}

  
newlist <- list("switchType" = switchType, "validTiming" = validTiming, "numSwitch" = numSwitch, "idxFirst" = idxFirst)  
return(newlist)

}
