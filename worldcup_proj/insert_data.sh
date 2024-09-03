#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Delete rows from tables
AUX=$($PSQL "TRUNCATE TABLE games, teams")

#!/bin/bash
GET_TEAM_ID() {
  TEAM=$1
  # search for team in team table
  TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$TEAM'")
  # check if team exists
  if [[ -z $TEAM_ID ]]
  then
    # if not exists, create team
    AUX="$($PSQL "INSERT INTO teams(name) VALUES ('$TEAM')")"
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$TEAM'")
  fi
  # echo team id
  echo $TEAM_ID
}

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do 
  echo $WINNER
  if [[ $WINNER != "winner" || $OPPONENT != "opponent" ]]
  then
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    if [[ -z $WINNER_ID ]]
    then
    # if not exists, create team
      AUX="$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")"
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    fi

    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    if [[ -z $OPPONENT_ID ]]
    then
    # if not exists, create team
      AUX="$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")"
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    fi

    
    AUX="$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES ($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")"
  fi
done

echo $
