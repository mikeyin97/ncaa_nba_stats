from nba_py import player
from nba_py.player import get_player
import pandas as pd

current_players = player.PlayerList(season = "2017-17").info()

college_stats = pd.DataFrame()
nba_stats = pd.DataFrame()
print(player.PlayerShotTracking(203518).general_shooting())
"""
for index, row in (current_players).iterrows():
    college_stats = college_stats.append(player.PlayerCareer(row["PERSON_ID"]).college_season_career_totals())
    nba_stats = nba_stats.append(player.PlayerCareer(row["PERSON_ID"]).regular_season_career_totals())"""
    

#college_stats.to_csv("college_stats.csv")
#nba_stats.to_csv("regular_season_stats.csv")

