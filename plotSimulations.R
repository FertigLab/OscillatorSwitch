#plotSimulations
#R Sansale 7/1/20

#inputs: t, x, theta, omega, omegaHat, colFig
#outputs: figH, rx, romega, rtheta, psi
plotSimulations <- function(t,x,theta,omega,omegahat,title, savepath){
wd = c("/Users/rebeccasansale/Desktop/fertig_lab/dynamic_system_paper/R_code")
sprintf("%s/frequencyCorrelations.R", wd)
source(sprintf("%s/frequencyCorrelations.R", wd))
romega = fCorr(omega = omega, omegahat = omegahat, D = matrix(1, nrow = nrow(omega), ncol = ncol(omega)), Nt = seq(1,t, by = 1))


#getbinaryValue
sprintf("%s/getBinaryValue.R", wd)
source(sprintf("%s/getBinaryValue.R", wd))
rx     = t(colMeans(getBinaryValue(x,0,c(0,1))))


#compute oscillator order
sprintf("%s/computeOscillatorOrder.R", wd)
source(sprintf("%s/computeOscillatorOrder.R", wd))
rthetapsi <- computeOscillatorOrder(theta)

pdf(file = savepath)
#plots
par(mfrow=c(2,1))
#plot time vs rx
plot(x = seq(1,length(rx), by = 1), rx, type = 'l', lty = 2, lwd = 3, col = "blue", xlab = c('time'), ylab = c('rx,rt,ro'), ylim = c(0,1), main = c(title))
#plotting rtheta and romega
lines(x = seq(1,length(romega$rot)), (romega$rot), type = 'l', lty = 3, lwd = 2, col = "red")
lines(x = seq(1,length(rthetapsi$r)), (rthetapsi$r), type = 'l', lty = 4, lwd = 2, col = "green")
legend(x = 3000, y = 0.8, legend = c('rx', 'romega_avg_time', 'r_theta'), col = c('blue', 'red', 'green'), lty = c(2,3,4), lwd = c(3,2,2))

#plot time vs psi, this is the oscillator panel
plot(x = seq(1,length(rthetapsi$psi), by = 1), rthetapsi$psi, type = 'l', col = 'red', xlab = c('time'), ylab = c('Psi'), ylim =c(-pi,pi))
dev.off()

}


