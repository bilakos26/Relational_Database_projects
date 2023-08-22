#!/bin/bash

# This is for creating the database with the tables

PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align -c"

# Create database
CREATE=$($PSQL "CREATE DATABASE salon;")
echo $CREATE

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

# Create tables
TABLE1=$($PSQL "CREATE TABLE customers(customer_id SERIAL PRIMARY KEY, phone VARCHAR NOT NULL UNIQUE, name VARCHAR NOT NULL)")
TABLE2=$($PSQL "CREATE TABLE services(service_id SERIAL PRIMARY KEY, name VARCHAR NOT NULL UNIQUE)")
TABLE3=$($PSQL "CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY, customer_id INT NOT NULL REFERENCES customers(customer_id), service_id INT NOT NULL REFERENCES services(service_id), time VARCHAR NOT NULL)")
echo $TABLE1
echo $TABLE2
echo $TABLE3

# Insert services to the services table
INSERT=$($PSQL "INSERT INTO services (name) VALUES ('cut'), ('color'), ('perm'), ('style'), ('trim')")
echo $INSERT