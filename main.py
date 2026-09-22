import sqlite3
from faker import Faker

fake = Faker('de_DE')

db_name = 'personen.db'
conn = sqlite3.connect(db_name)
cursor = conn.cursor()


cursor.execute('''
    CREATE TABLE IF NOT EXISTS personen (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        vorname TEXT NOT NULL,
        nachname TEXT NOT NULL
    )
''')
conn.commit()


TOTAL_RECORDS = 500000


for i in range(TOTAL_RECORDS):
    cursor.execute(
        "INSERT INTO personen (vorname, nachname) VALUES (?, ?)", 
        (fake.first_name(), fake.last_name())
    )

conn.commit()
conn.close()    