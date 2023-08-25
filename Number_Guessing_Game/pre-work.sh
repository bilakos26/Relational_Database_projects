#!/bin/bash

# This bash script is for creating the Database with the Tables and the Columns.

# Connect to `postgres` database
PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"

# Create Database
CREATE=$($PSQL "CREATE DATABASE number_guess")
echo $CREATE

# Connect to `number_guess` database
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Create Table users
USERS=$($PSQL "CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR(22) NOT NULL UNIQUE)")
echo $USERS

# Create Table games_played
GAMES=$($PSQL "CREATE TABLE games_played(game_id SERIAL PRIMARY KEY, secret_number INT NOT NULL,guesses INT NOT NULL DEFAULT 0, user_id INT NOT NULL REFERENCES users(user_id))")
echo $GAMES