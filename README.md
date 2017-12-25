# ncaa_nba_stats (in progress)
- shift from shooting to performance in general
Can one's shooting in college basketball be used as a predictor for their NBA shooting? 

#currently needs a lot of tweeking!
(look at last year college / first year rookie season only)
data collected using nba_py python library, developed by seemethere and found at https://github.com/seemethere/nba_py
current data takes into regards all seasons of a player and all season of in college - maybe tweek this. 

College Statistics
![alt text](/images/college_stats.png)

NBA Statistics (Regular Season)
![alt text](/images/nba_stats.png)

NBA TS vs College FT
![alt text](/images/nba_ts_college_ft.png)
![alt text](/images/residuals.png)

p-value = 0.02856, reject the null hypothesis
statistical evidence of a relationship between NBA TS and College FT

Looking towards this year's draft - regardless of defensive ability, who is predicted to be a good shooter?
Finally can work on this since exams are over!!

to do list:
1) get stats of active nba players - Done
2) get stats of their college statistics - Done <- somehow I missed player names by accident
3) introduction - is college ts/fg/3pt/ft% a good predictor for nba ts? fg? 3-pt?
    regression analysis - simple linear regression - 3x3 plot
    regression analysis - simple linear regression of true shooting 
    confidence intervals
    t-testing - reject/don't reject slope 0 (existence of a relationship) - Done
4) looking draft to draft, what differentiated the good players from the rest? Was there any way to determine a bust? 
    interactive plots from ... to today - distributions of various statistics (PER/ppg/apg/rpg/shooting splits) - see if anyone stood out. Try multiple regression? Response variable being first year NBA PER, relating to college PER, defensive stats, etc. <- t-tests/f-tests to find variables and obtain model.  
5) looking towards this year's draft
