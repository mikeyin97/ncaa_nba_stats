# imports
nba_stats <- read.table("nba_stats.csv", header=TRUE, 
                     sep=",", row.names="id")
college_stats <- read.table("college_stats.csv", header=TRUE, 
                                   sep=",", row.names="id")
#str(data)
#df[,c("A","B","E")]
#get college shooting splits, indiv columns, etc. 

plotmatrix(college_stats, colour="gray20")
# comment on normality and shape of distributions
# make a dataframe with college shooting splits against nba shooting splits. 



x<-
n <- length(x);
mx <- mean(x); my <- mean(y)
Sxx <- sum((x-mx)^2); Sxy <- sum((x-mx)*(y-my))
b1 <- Sxy/Sxx; b0 <- mean(y) - b1*mean(x)
yhat <- b0 + b1*x
RSS <- sum((y-yhat)^2)
S <- sqrt(RSS/(n-2))
xstar <- seq(min(x)-1,max(x)+1,.1)
ystar <- b0+b1*xstar 
ci <- qt(.975,n-2)*S*sqrt(1/n+(xstar-mx)^2/Sxx) 
ciLower <- ystarMean-ci; ciHigher <- ystarMean+ci
plot(x,y,xlim=c(min(xstar),max(xstar)),
     ylim=c(min(ciLower),max(ciHigher)))
pi <- qt(.975,n-2)*S*sqrt(1+1/n+(xstar-mx)^2/Sxx)
piLower <- ystarMean-pi; piHigher <- ystarMean+pi
plot(x,y,xlim=c(min(xstar),max(xstar)),
     ylim=c(min(piLower),max(piHigher)))
lines(xstar,ystarMean,type="l",col="black")
lines(xstar,ciLower,type="l",col="red")
lines(xstar,ciHigher,type="l",col="red")
lines(xstar,piLower,type="l",col="green")
lines(xstar,piHigher,type="l",col="green")

seB0 <- S*sqrt(1/n+mx^2/Sxx) 
seB1 <- S/sqrt(Sxx) 
t0 <- b0/seB0 
t1 <- b1/seB1 
pval0 <- 2*pt(-abs(t0),n-2) 
pval1 <- 2*pt(-abs(t1),n-2) 
print(c(b0,b1,pval0,pval1))
myFit <- lm(y~x) 
summary(myFit)

set.seed(1000)
x = 1:100; y=1+0.75*x+rnorm(100,0,1) # generate x and y
plot(x,y);
par(mfrow=c(2,2))
plot(lm(y~x))