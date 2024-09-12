#!/bin/bash
# Rebuild all
echo "Enter your username:"
read USERNAME
# PSQL variable
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
# Check Username
CHECK_USERNAME_EXISTS=$($PSQL "SELECT player_id FROM players WHERE username = '$USERNAME' ")
# If Username Dont exists lets create them
if [[ -z $CHECK_USERNAME_EXISTS ]]
then
  # if creation is successfull continue, if not reject
  CREATE_USERNAME=$($PSQL "INSERT INTO players(username) VALUES ('$USERNAME') ")
  if [[ ! $CREATE_USERNAME = "INSERT 0 1" ]]
  then
    exit 0
  fi
fi
# get player id
PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE username = '$USERNAME' ")
# Verificamos si el usuario es nuevo
if [[ -z $CHECK_USERNAME_EXISTS ]]
then
# Si es nuevo mandamos un solo mensaje
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."
else
# Si no es nuevo mandamos mensaje uniendo todas las tablas
  GAMES_PLAYED=$($PSQL "SELECT count(session_id) FROM  sessions WHERE player_id = $PLAYER_ID")
  BEST_GAME=$($PSQL "SELECT min(attempts) FROM players INNER JOIN  sessions USING (player_id) where player_id=$PLAYER_ID ")
  echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
# Generate Random Number
echo "Guess the secret number between 1 and 1000:"
SECRET_NUMBER=$(( $RANDOM % 1000 + 1))
# Start Session
SESSION_ID=$($PSQL "INSERT INTO sessions(player_id) VALUES ($PLAYER_ID); SELECT MAX(session_id) FROM sessions WHERE player_id=$PLAYER_ID ")
# Start Game
read GUESS
ATTEMPT_COUNTER=1
while [[ ! $SECRET_NUMBER = $GUESS ]]
do
  # is not an int
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo That is not an integer, guess again:
  elif [[ $GUESS -gt $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
  elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
  fi
  ATTEMPT_COUNTER=$(( $ATTEMPT_COUNTER + 1 ))
  read GUESS
done
SESSION_ID=$($PSQL "UPDATE sessions SET attempts=$ATTEMPT_COUNTER WHERE session_id=$SESSION_ID")
echo You guessed it in $ATTEMPT_COUNTER tries. The secret number was $SECRET_NUMBER. Nice job!
