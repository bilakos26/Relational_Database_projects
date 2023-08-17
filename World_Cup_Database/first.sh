#!/bin/bash

# This is for creating the database and tables

PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"

CREATE=$($PSQL "CREATE DATABASE worldcup;")

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

TABLE1=$($PSQL "CREATE TABLE teams(team_id SERIAL PRIMARY KEY,name VARCHAR UNIQUE NOT NULL);")
TABLE2=$($PSQL "CREATE TABLE games(game_id SERIAL PRIMARY KEY,year INT NOT NULL,round VARCHAR NOT NULL,winner_id INT NOT NULL REFERENCES teams(team_id),opponent_id INT NOT NULL REFERENCES teams(team_id),winner_goals INT NOT NULL,opponent_goals INT NOT NULL);")
echo $CREATE
echo $TABLE1
echo $TABLE2