# Salon Appointment Scheduler
This is one of the required projects to earn your certification. For this project, you will create an interactive Bash program that uses PostgreSQL to track the customers and appointments for your salon.

## Create Tables

```postgresql
CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY, 
    phone VARCHAR NOT NULL UNIQUE, 
    name VARCHAR NOT NULL
);

CREATE TABLE services(
    service_id SERIAL PRIMARY KEY, 
    name VARCHAR NOT NULL UNIQUE
);

CREATE TABLE appointments(
    appointment_id SERIAL PRIMARY KEY, 
    customer_id INT NOT NULL REFERENCES customers(customer_id), 
    service_id INT NOT NULL REFERENCES services(service_id), 
    time VARCHAR NOT NULL
);
```

### Export database to `.sql` file
```shell
pg_dump -cC --inserts -U freecodecamp salon > salon.sql
```