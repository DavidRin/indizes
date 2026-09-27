--personen.db

.headers on
.mode column
.timer on

--todo Streuung analysieren
WITH namenshaeufigkeiten AS (
    SELECT vorname, COUNT(*) AS anzahl
    From personen
    GROUP BY vorname
)


--Abfrage
SELECT COUNT(*) FROM personen WHERE vorname = 'Peter';
--Run Time: real 0.178 user 0.147932 sys 0.019375

-- Index ertellen
CREATE INDEX idx_vorname ON personen(vorname);

--Abfrage mit Index

SELECT COUNT(*) FROM personen WHERE vorname = 'Peter';

--Run Time: real 0.001 user 0.000795 sys 0.000000






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
