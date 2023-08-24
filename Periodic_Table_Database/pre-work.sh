#!/bin/bash

# This bash script follows the first half of the project tasks

# Connect to database
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# You should delete the non existent element, whose `atomic_number` is `1000`, from the two tables
DELETE_ELEMENT_1=$($PSQL "DELETE FROM elements WHERE atomic_number = 1000")
echo $DELETE_ELEMENT_1
DELETE_ELEMENT_2=$($PSQL "DELETE FROM properties WHERE atomic_number = 1000")
echo $DELETE_ELEMENT_2

# Rename the `weight` column to `atomic_mass` from the `properties` table
RENAME_WEIGHT=$($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass")
echo $RENAME_WEIGHT

# Rename rename the `melting_point` column to `melting_point_celsius`
# and the `boiling_point` column to `boiling_point_celsius` from the properties table
RENAME_MELTING_POINT=$($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius")
RENAME_BOILING_POINT=$($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius")
echo $RENAME_MELTING_POINT
echo $RENAME_BOILING_POINT

# Your `melting_point_celsius` and `boiling_point_celsius` columns should not accept null values
NOT_NULL_MELTING_POINT=$($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL")
NOT_NULL_RENAME_BOILING_POINT=$($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL")
echo $NOT_NULL_MELTING_POINT
echo $NOT_NULL_RENAME_BOILING_POINT

# You should add the `UNIQUE` constraint to the `symbol` and `name` columns from the `elements` table
UNIQUE_CONST_SYMBOL=$($PSQL "ALTER TABLE elements ADD UNIQUE(symbol)")
UNIQUE_CONST_NAME=$($PSQL "ALTER TABLE elements ADD UNIQUE(name)")
echo $UNIQUE_CONST_SYMBOL
echo $UNIQUE_CONST_NAME

# Your `symbol` and `name` columns should have the `NOT NULL` constraint
NOT_NULL_SYMBOL=$($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL")
NOT_NULL_NAME=$($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL")
echo $NOT_NULL_SYMBOL
echo $NOT_NULL_NAME

# You should set the `atomic_number` column from the `properties` table as a foreign key 
# that references the column of the same name in the `elements` table
ATOMIC_NUMBER_FOREIGN_KEY=$($PSQL "ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number)")
echo $ATOMIC_NUMBER_FOREIGN_KEY

# You should create a `types` table that will store the three types of elements
# Your `types` table should have a `type_id` column that is an integer and the primary key
# Your `types` table should have a `type` column that's a `VARCHAR` and cannot be `null`. It will store the different types from the `type` column in the `properties` table
CREATE_TABLE_TYPES=$($PSQL "CREATE TABLE types(type_id INT NOT NULL PRIMARY KEY, type VARCHAR NOT NULL)")
echo $CREATE_TABLE_TYPES

# You should add three rows to your `types` table whose values are the three different types from the `properties` table
INSERT_TYPES=$($PSQL "INSERT INTO types(type_id, type) VALUES(1, 'metal'), (2, 'metalloid'), (3, 'nonmetal')")
echo $INSERT_TYPES

# Your `properties` table should have a `type_id` foreign key column that references the `type_id` column from the `types` table. It should be an `INT` with the `NOT NULL` constraint
TYPE_ID_FOREIGN_KEY=$($PSQL "ALTER TABLE properties ADD COLUMN type_id INT REFERENCES types(type_id)")
echo $TYPE_ID_FOREIGN_KEY

# Each row in your `properties` table should have a `type_id` value that links to the correct type from the `types` table
UPDATE_PROPERTIES_TYPE_ID_1=$($PSQL "UPDATE properties SET type_id = 1 WHERE type = 'metal'")
echo $UPDATE_PROPERTIES_TYPE_ID_1
UPDATE_PROPERTIES_TYPE_ID_2=$($PSQL "UPDATE properties SET type_id = 2 WHERE type = 'metalloid'")
echo $UPDATE_PROPERTIES_TYPE_ID_2
UPDATE_PROPERTIES_TYPE_ID_3=$($PSQL "UPDATE properties SET type_id = 3 WHERE type = 'nonmetal'")
echo $UPDATE_PROPERTIES_TYPE_ID_3

# Set `type_id` column from `properties` table a constraint of `NOT NULL`
TYPE_ID_PROPERTIES_NOT_NULL=$($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL")
echo $TYPE_ID_PROPERTIES_NOT_NULL

# You should capitalize the first letter of all the symbol values in the elements table. Be careful to only capitalize the letter and not change any others
CAPITALIZE_FIRST_LETTER_SYMBOL=$($PSQL "UPDATE elements SET symbol = INITCAP(symbol)")
echo $CAPITALIZE_FIRST_LETTER_SYMBOL

# You should remove all the trailing zeros after the decimals from each row of the `atomic_mass` column. You may need to adjust a data type to `DECIMAL` for this. 
# The final values they should be are in the `atomic_mass.txt` file
UPDATE_DATA_TYPE_ATOMIC_MASS=$($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL")
echo TYPE $UPDATE_DATA_TYPE_ATOMIC_MASS
REMOVE_ZEROS_ATOMIC_MASS=$($PSQL "UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM atomic_mass::TEXT)::NUMERIC")
echo TRAIL $REMOVE_ZEROS_ATOMIC_MASS

# You should add the element with atomic number `9` to your database. Its name is `Fluorine`, symbol is `F`, mass is `18.998`, melting point is `-220`, boiling point is `-188.1`, and it's a `nonmetal`
INSERT_ELEMENT_F=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine')")
echo $INSERT_ELEMENT_F
INSERT_PROPERTIE_F=$($PSQL "INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 18.998, -220, -188.1, 3)")
echo $INSERT_PROPERTIE_F

# You should add the element with atomic number `10` to your database. Its name is `Neon`, symbol is `Ne`, mass is `20.18`, melting point is `-248.6`, boiling point is `-246.1`, and it's a `nonmetal`
INSERT_ELEMENT_NE=$($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(10, 'Ne', 'Neon')")
echo $INSERT_ELEMENT_NE
INSERT_PROPERTIE_NE=$($PSQL "INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(10, 20.18, -248.6, -246.1, 3)")
echo $INSERT_PROPERTIE_NE

# Your properties table should not have a `type` column
DELETE_TYPE_COLUMN=$($PSQL "ALTER TABLE properties DROP COLUMN type;")
echo $DELETE_TYPE_COLUMN