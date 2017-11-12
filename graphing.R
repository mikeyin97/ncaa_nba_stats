# imports

library(ggplot2)
library(grid)
library(gridExtra)
MINIMUM = 10
nba_stats <- read.csv("regular_season_stats.csv")
college_stats <- read.csv("college_stats.csv")
merged_stats <- merge(nba_stats, college_stats, by = "PLAYER_ID") #.x is nba, .y is college
merged_stats$ts.x<-(merged_stats$PTS.x)*(merged_stats$GP.x)/
  2/(merged_stats$FGA.x*merged_stats$GP.x+(0.44)*(merged_stats$FTA.x*merged_stats$GP.x))
merged_stats$ts.y<-(merged_stats$PTS.y)*(merged_stats$GP.y)/
  2/(merged_stats$FGA.y*merged_stats$GP.y+(0.44)*(merged_stats$FTA.y*merged_stats$GP.y))


merged_stats_college <- subset(merged_stats, (FGA.y*GP.y>MINIMUM)&(FTA.y*GP.y>MINIMUM)&(FG3A.y*GP.y>MINIMUM))

merged_stats_min = subset(merged_stats, (FGA.y*GP.y>MINIMUM)&(FTA.y*GP.y>MINIMUM)&(FGA.x*GP.x>MINIMUM)&(FTA.x*GP.x>MINIMUM))
merged_stats_3s = subset(merged_stats, (FG3A.x*GP.x>MINIMUM))
c_shooting_splits <- merged_stats[,c("FT_PCT.y","FG_PCT.y","FG3_PCT.y")]


#get college shooting splits, indiv columns, etc. 
par(mfrow=c(2,2))
hist(merged_stats_3s$ts.y, breaks="FD",main = "TS% - College", col = "darkblue")
hist(merged_stats_3s$FG_PCT.y, breaks="FD", main = "FG% - College", col = "darkblue")
hist(merged_stats_3s$FG3_PCT.y, breaks="FD", main = "3FG% - College", col = "darkblue")
hist(merged_stats_3s$FT_PCT.y, breaks="FD", main = "FT% - COllege", col = "darkblue")

par(mfrow=c(2,2))
hist(merged_stats_3s$ts.x, breaks="FD", main = "TS% - NBA", col = "darkblue")
hist(merged_stats_3s$FG_PCT.x, breaks="FD", main = "FG% - NBA", col = "darkblue")
hist(merged_stats_3s$FG3_PCT.x, breaks="FD", main = "3FG% - NBA", col = "darkblue")
hist(merged_stats_3s$FT_PCT.x, breaks="FD", main = "FT% - NBA", col = "darkblue")
#ggpairs(c_shooting_splits, colour="gray20")

# comment on normality and shape of distributions
# make a dataframe with college shooting splits against nba shooting splits. 
# filter by like 3 fga on all shooting

# FT PCT vs True Shooting NBA

x<-merged_stats_3s[,c("FT_PCT.y")];
y<-merged_stats_3s[,c("ts.x")]
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
ciLower <- ystar-ci; ciHigher <- ystar+ci
par(mfrow=c(1,1))
plot(x,y,xlim=c(min(x),max(x)),
     ylim=c(min(y),max(y)),
     pch=16,cex=0.8, main = "NBA TS% vs College FT%", xlab = "College FT%", ylab = "NBA TS%")
pi <- qt(.975,n-2)*S*sqrt(1+1/n+(xstar-mx)^2/Sxx)
piLower <- ystar-pi; piHigher <- ystar+pi
lines(xstar,ystar,type="l",col="black", lwd=3)
lines(xstar,ciLower,type="l",col="red", lwd = 2)
lines(xstar,ciHigher,type="l",col="red", lwd = 2)
lines(xstar,piLower,type="l",col="green", lwd = 2)
lines(xstar,piHigher,type="l",col="green", lwd = 2)

seB0 <- S*sqrt(1/n+mx^2/Sxx) 
seB1 <- S/sqrt(Sxx) 
t0 <- b0/seB0 
t1 <- b1/seB1 
pval0 <- 2*pt(-abs(t0),n-2) 
pval1 <- 2*pt(-abs(t1),n-2) 
print(c(b0,b1,pval0,pval1))
myFit <- lm(y~x) 
summary(myFit)

par(mfrow=c(2,2))
plot(lm(y~x))