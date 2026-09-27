import sqlite3
from faker import Faker
# Faker initialisieren + sprachauswahl
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
BATCH_SIZE = 10000 # 10.000 Datensätze pro Schreibvorgang,wie viele Datensätze in einem einzigen Durchlauf  generiert und an SQLite übergeben werden

for i in range(0,TOTAL_RECORDS,BATCH_SIZE):
    batch_data=[]#Liste von tuple
    for j in range(BATCH_SIZE):
        batch_data.append((fake.first_name(), fake.last_name()))

    cursor.executemany(
        "INSERT INTO personen (vorname, nachname) VALUES (?, ?)", 
        batch_data
    )
    conn.commit()

conn.close()    