#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"

DISPLAY_SERVICES() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi

    SERVICES=$($PSQL "SELECT * FROM services")
    
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
        echo "$SERVICE_ID) $SERVICE_NAME"
    done

    SELECT_SERVICE
}

SELECT_SERVICE() {
    # get service id from user input
    read SERVICE_ID_SELECTED

    # check if `SERVICE_ID_SELECTED` is valid
    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
        DISPLAY_SERVICES "I could not find that service. What would you like today?"
    else
        SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
        if [[ -z $SERVICE_NAME ]]; then
            DISPLAY_SERVICES "I could not find that service. What would you like today?"
        else
            # create the appointment including the `SERVICE_ID_SELECTED` & SERVICE_NAME arguments
            CREATE_APPOINTMENT $SERVICE_ID_SELECTED $SERVICE_NAME
        fi
    fi
}

CREATE_APPOINTMENT() {
    SERVICE_ID_SELECTED=$1
    SERVICE_NAME=$2

    # get customer info
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    
    # if customer doesn't exist
    if [[ -z $CUSTOMER_NAME ]]
    then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME

        # insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    fi

    # get appointment time
    echo -e "\nWhat time would you like your $SERVICE_NAME, $(echo $CUSTOMER_NAME | sed -r 's/^ *//g')?"
    read SERVICE_TIME

    # get customer id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    # book appointment
    BOOK_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    if [[ $BOOK_APPOINTMENT_RESULT == 'INSERT 0 1' ]]; then
        echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *//g').\n"
    fi
}

DISPLAY_SERVICES