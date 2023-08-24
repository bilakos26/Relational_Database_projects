#!/bin/bash

# Accepts an argument in the form of an `atomic number`, `symbol`, or `name` of an element and outputs some information about the given element.

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


MAIN() {
    # $#: This is a special variable in bash that represents the number of arguments passed to the script or function.
    if [[ $# -eq 0 ]]; then
        echo "Please provide an element as an argument."
    else
        ELEMENTS "$1"
    fi
}

ELEMENTS() {
    ELEMENT="$1"
    
    # If the `ELEMENT` is a number then it will proceed with the first case
    if [[ $ELEMENT =~ ^[0-9]+$ ]]; then
        # Get result with the `atomic_number`
        GET_RESULT=$($PSQL "SELECT atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $ELEMENT")
    else
        # Get result with the `symbol` or `name`
        GET_RESULT=$($PSQL "SELECT atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM properties INNER JOIN elements USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$ELEMENT' OR name = '$ELEMENT'")
    fi
    
    if [[ $GET_RESULT ]]; then
        echo "$GET_RESULT" | while IFS="|" read AT_NUM NAME SYMBOL AT_MASS MEL_P_CEL BOIL_P_CEL TYPE; do
            echo "The element with atomic number $AT_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AT_MASS amu. $NAME has a melting point of $MEL_P_CEL celsius and a boiling point of $BOIL_P_CEL celsius."
        done
    else
        echo "I could not find that element in the database."
    fi
}

MAIN "$@"