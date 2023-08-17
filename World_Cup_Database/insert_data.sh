#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Drop tables if they exist
echo $($PSQL "TRUNCATE teams, games")

# Insert Teams
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
    if [[ $YEAR != 'year' && $YEAR != ' ' ]]
    then
        team_1=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
        team_2=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
        
        if [[ -z $team_1 ]]
        then
            team_1=$($PSQL "INSERT INTO teams (name) VALUES ('$WINNER')")
        fi
        if [[ -z $team_2 ]]
        then
            team_2=$($PSQL "INSERT INTO teams (name) VALUES ('$OPPONENT')")
        fi

        if [[ $team_1 == 'INSERT 0 1' ]]
        then
            echo "Winner Team $WINNER inserted"
        fi

        if [[ $team_2 == 'INSERT 0 1' ]]
        then
            echo "Opponent Team $OPPONENT inserted"
        fi
    fi
done

# Insert Games
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
    if [[ $YEAR != 'year' && $YEAR != ' ' ]]
    then
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
        OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
        
        if [[ $WINNER_ID && $OPPONENT_ID ]]
        then
            GAME=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
            if [[ $GAME = 'INSERT 0 1' ]]
            then
                echo "Game $WINNER - $OPPONENT inserted"
            fi
        fi
    fi
done