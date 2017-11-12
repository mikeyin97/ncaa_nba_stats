# imports
MINIMUM = 10
nba_stats <- read.csv("regular_season_stats.csv")
college_stats <- read.csv("college_stats.csv")
merged_stats <- merge(nba_stats, college_stats, by = "PLAYER_ID") #.x is nba, .y is college
merged_stats$ts.x<-(merged_stats$PTS.x)*(merged_stats$GP.x)/
  2/(merged_stats$FGA.x*merged_stats$GP.x+(0.44)*(merged_stats$FTA.x*merged_stats$GP.x))
merged_stats$ts.y<-(merged_stats$PTS.y)*(merged_stats$GP.y)/
  2/(merged_stats$FGA.y*merged_stats$GP.y+(0.44)*(merged_stats$FTA.y*merged_stats$GP.y))


merged_stats_college <- subset(merged_stats, (FGA.y*GP.y>MINIMUM)&(FTA.y*GP.y>MINIMUM)&(FGA3.y*GP.y>MINIMUM))

merged_stats_min = subset(merged_stats, (FGA.y*GP.y>MINIMUM)&(FTA.y*GP.y>MINIMUM)&(FGA.x*GP.x>MINIMUM)&(FTA.x*GP.x>MINIMUM))
merged_stats_3s = subset(merged_stats, (FG3A.x*GP.x>MINIMUM))
c_shooting_splits <- merged_stats[,c("FT_PCT.y","FG_PCT.y","FG3_PCT.y")]


#get college shooting splits, indiv columns, etc. 
hist(merged_stats_3s$ts.y, breaks="FD")
hist(merged_stats_3s$FG_PCT.y, breaks="FD")
hist(merged_stats_3s$FG3_PCT.y, breaks="FD")
hist(merged_stats_3s$FT_PCT.y, breaks="FD")

hist(merged_stats_3s$ts.x, breaks="FD")
hist(merged_stats_3s$FG_PCT.x, breaks="FD")
hist(merged_stats_3s$FG3_PCT.x, breaks="FD")
hist(merged_stats_3s$FT_PCT.x, breaks="FD")
#ggpairs(c_shooting_splits, colour="gray20")

# comment on normality and shape of distributions
# make a dataframe with college shooting splits against nba shooting splits. 
# filter by like 3 fga on all shooting

# FT PCT vs True Shooting NBA

x<-merged_stats_3s[,c("ft.y")];
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
plot(x,y,xlim=c(min(x),max(x)),
     ylim=c(min(y),max(y)))
pi <- qt(.975,n-2)*S*sqrt(1+1/n+(xstar-mx)^2/Sxx)
piLower <- ystar-pi; piHigher <- ystar+pi
lines(xstar,ystar,type="l",col="black")
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

par(mfrow=c(2,2))
plot(lm(y~x))