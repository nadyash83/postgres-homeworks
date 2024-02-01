"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv

# connect to db

conn = psycopg2.connect(
    host='localhost',
    database='north',
    user='postgres',
    password='nadya12O4'
)

#create cursor
cur = conn.cursor()
with open("north_data/customers_data.csv" , 'r') as file:
    csvfile = csv.reader(file)
    next(csvfile)

    for lines in csvfile:
        cur.execute("INSERT INTO costumers VALUES (%s, %s, %s)", (lines))
#execute query
# cur.execute("SELECT * FROM customers")

cur = conn.cursor()
with open("north_data/employees_data.csv" , 'r') as file:
    csvfile = csv.reader(file)
    next(csvfile)

    for lines in csvfile:
        cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)", (lines))
#execute query

with open("north_data/orders_data.csv" , 'r') as file:
    csvfile = csv.reader(file)
    next(csvfile)

    for lines in csvfile:
        cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)", (lines))
#execute query
conn.commit()
cur.close()
conn.close()

# rows = cur.fetchall()
# for row in rows:
#     print(row)
