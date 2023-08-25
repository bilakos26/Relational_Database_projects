#!/bin/bash

# Write a script that generates a random number between 1 and 1000 for `users` to guess. Create a `number_guess` database to hold the information suggested in the user stories.

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAIN() {
    # Get username
    echo "Enter your username:"
    read USERNAME
    
    # If user doesn't exists on the database then continue with the first condition
    if ! USER_EXISTS "$USERNAME"; then
        if INSERT_USER "$USERNAME"; then
            echo "Welcome, $USERNAME! It looks like this is your first time here."
        else
            echo "Failed to insert user to the database"
        fi
    else
        echo "Welcome back, $USERNAME! You have played $(GAMES_PLAYED "$USERNAME") games, and your best game took $(BEST_GAME "$USERNAME") guesses."
    fi
    PLAY_GAME "$USERNAME" # Play the game
}

USER_EXISTS() {
    local username="$1" # Get the username as an argument

    # Check if the user exists on the database
    EXISTS=$($PSQL "SELECT * FROM users WHERE username = '$username'")
    if [[ $EXISTS ]]; then
        return 0 # User exists
    else
        return 1 # User doesn't exists
    fi
}

INSERT_USER() {
    local username="$1"

    # Insert user to the database
    INSERT=$($PSQL "INSERT INTO users(username) VALUES('$username')")
    if [[ $INSERT == "INSERT 0 1" ]]; then
        return 0
    else
        return 1
    fi
}

GET_USER_ID() {
    local username="$1"

    # Returns the `USER_ID`
    echo $($PSQL "SELECT user_id FROM users WHERE username = '$username'")
}

GAMES_PLAYED() {
    local username="$1"
    local user_id=$(GET_USER_ID "$username")

    # Returns all the games played
    echo $($PSQL "SELECT COUNT(*) FROM games_played WHERE user_id = '$user_id'")
}

BEST_GAME () {
    local username="$1"
    local user_id=$(GET_USER_ID "$username")

    # Returns the best game played with the less guesses
    BEST=$($PSQL "SELECT MIN(guesses) FROM games_played FULL JOIN users USING(user_id) WHERE user_id = $user_id")
    if [[ -z $BEST ]]; then
        echo "0"
    else
        echo $BEST
    fi
}

INSERT_NUMBER() {
    local user_id=$2
    local number=$1

    INSERT_GAMES_PLAYED=$($PSQL "INSERT INTO games_played(secret_number, user_id) VALUES($number, $user_id)")
    if [[ $INSERT_GAMES_PLAYED == "INSERT 0 1" ]]; then
        return 0
    else
        return 1
    fi
}

PLAY_GAME() {
    local username="$1"
    local user_id=$(GET_USER_ID "$username")

    # Create a random number between 1 and 1000
    RANDOM_NUM=$(( RANDOM % 1000 + 1 ))

    # For debugging uncomment the below line
    # echo "RANDOM NUMBER: $RANDOM_NUM"

    if INSERT_NUMBER $RANDOM_NUM $user_id; then
        echo "Guess the secret number between 1 and 1000:"
        while true; do
            read USER_INPUT
            
            if [[ ! $USER_INPUT =~ ^[0-9]+$ ]]; then
                echo "That is not an integer, guess again:"
            else
                GUESS_RESULT=$(CHECK_GUESS $RANDOM_NUM $USER_INPUT $user_id)
                if [[ ! $GUESS_RESULT ]]; then
                    break
                else
                    echo "$GUESS_RESULT"
                fi
            fi
        done
        echo "You guessed it in $(GET_GUESSES $user_id) tries. The secret number was $RANDOM_NUM. Nice job!"
    fi
}

CHECK_GUESS() {
    local number=$1
    local user_input=$2
    local user_id=$3
    if [[ $number -gt $user_input ]]; then
        INCREMENT_GUESSES $user_id
        echo "It's higher than that, guess again:"
    elif [[ $number -lt $user_input ]]; then
        INCREMENT_GUESSES $user_id
        echo "It's lower than that, guess again:"
    else
        INCREMENT_GUESSES $user_id
        return 1
    fi
}

INCREMENT_GUESSES() {
    # Increases the guesses number for that game played
    local user_id=$1

    GAME_ID=$($PSQL "SELECT MAX(game_id) FROM games_played WHERE user_id = $user_id")
    UPDATE=$($PSQL "UPDATE games_played SET guesses = (guesses + 1) WHERE game_id = $GAME_ID")
}

GET_GUESSES() {
    local user_id=$1

    GAME_ID=$($PSQL "SELECT MAX(game_id) FROM games_played WHERE user_id = $user_id")
    echo $($PSQL "SELECT guesses FROM games_played WHERE user_id = $user_id AND game_id = $GAME_ID")
}

MAIN