#Rsansale 3/23/20
#getBinaryValue
#inputs: values, cutoff, outputVal
#outputs: binVal

getBinaryValue <- function(values, cutoff, outputVal){
  
  if(length(cutoff) >1) {stop('cutoff value larger than 1 value')}
  
    binVal = (values > cutoff)*1
  
  binVal <- ifelse(binVal == 1, outputVal[2], outputVal[1])
}
