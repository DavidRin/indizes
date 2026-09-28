--personen.db

.headers on
.mode column
.timer on

--todo Streuung analysieren
-- WITH namenshaeufigkeiten AS (
--     SELECT vorname, COUNT(*) AS anzahl
--     From personen
--     GROUP BY vorname--with statment als hilfstabelle jeder name wird gezählt
-- )SELECT anzahl , COUNT(*)
-- FROM namenshaeufigkeiten
-- GROUP BY anzahl
-- ORDER BY anzahl ASC;

--Varianz
WITH namenshaeufigkeiten AS (
    SELECT vorname, COUNT(*) AS anzahl
    FROM personen
    GROUP BY vorname
)SELECT 
    ROUND(AVG(anzahl), 2) AS durchschnitt,
    --Varianz = (Durchschnitt der Quadratzahlen) minus (Quadrat des Durchschnitts)
    ROUND(AVG(anzahl * anzahl) - (AVG(anzahl) * AVG(anzahl)), 2) AS varianz
FROM namenshaeufigkeiten;
-- Durchschnittlich kommt jeder vorname rund 249,75 mal vor
--Varianz:267,28 
-- Standardabweichung = (varianz)^0,5=16,35

--Abfrage
SELECT COUNT(*) FROM personen WHERE vorname = 'Peter';
--Run Time: real 0.178 user 0.147932 sys 0.019375

-- Index ertellen
CREATE INDEX idx_vorname ON personen(vorname);

--Abfrage mit Index

SELECT COUNT(*) FROM personen WHERE vorname = 'Peter';

--Run Time: real 0.001 user 0.000795 sys 0.000000

--Speicherbadarf der DB überprüfen:

PRAGMA page_count;
PRAGMA page_size;-- Produkt dieser 2 Werte  ergibt Speicher in Byte

--vor index:2870*4096=11 755 520 Byte
--nach index:4780*4096=19 578 880 Byte


-- bias.db

.headers on
.mode column
.timer on




--index erstellen
CREATE INDEX idx_bias_vorname ON personen(vorname);

SELECT COUNT(*) FROM personen WHERE vorname = 'Peter';
--Run Time: real 0.000 user 0.000379 sys 0.000000


SELECT COUNT(*) FROM personen WHERE vorname = 'Simon';
--Run Time: real 0.039 user 0.038860 sys 0.000000
