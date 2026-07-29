-- ============================================================
-- SQL query examples
-- Run after the database has been installed.
-- ============================================================

SET DEFINE OFF;

-- Query 01: Display all project tables.
SELECT * FROM Vehicule;
SELECT * FROM Clienti;
SELECT * FROM Angajati;
SELECT * FROM Furnizori;
SELECT * FROM Vanzari;
SELECT * FROM Stocuri;

-- Query 02: Display vehicles priced above 30,000 EUR.
SELECT id_vehicul, marca, model, pret
FROM Vehicule
WHERE pret > 30000
ORDER BY pret DESC;

-- Query 03: Display clients whose names start with the letter C.
SELECT id_client, nume_client, telefon
FROM Clienti
WHERE nume_client LIKE 'Client%'
ORDER BY nume_client;

-- Query 04: Display sales with vehicle and client details.
SELECT z.id_vanzare,
       v.marca,
       v.model,
       c.nume_client,
       z.data
FROM Vanzari z
JOIN Vehicule v ON z.id_masina = v.id_vehicul
JOIN Clienti c ON z.id_client = c.id_client
ORDER BY z.data;

-- Query 05: Display stock and vehicle details.
SELECT s.id_stoc,
       v.marca,
       v.model,
       s.cantitate
FROM Stocuri s
JOIN Vehicule v ON s.id_vehicul = v.id_vehicul
ORDER BY s.id_stoc;

-- Query 06: Count sales by month.
SELECT TO_CHAR(data, 'YYYY-MM') AS luna_vanzare,
       COUNT(*) AS numar_vanzari
FROM Vanzari
GROUP BY TO_CHAR(data, 'YYYY-MM')
ORDER BY luna_vanzare;

-- Query 07: Display clients and employees in one alphabetical list.
SELECT nume_client AS nume, 'Client' AS categorie
FROM Clienti
UNION
SELECT nume_angajat AS nume, 'Angajat' AS categorie
FROM Angajati
ORDER BY nume;

-- Query 08: Calculate the total sales value for each salesperson.
SELECT a.id_angajat,
       a.nume_angajat,
       SUM(v.pret) AS valoare_totala
FROM Vanzari z
JOIN Angajati a ON z.id_angajat = a.id_angajat
JOIN Vehicule v ON z.id_masina = v.id_vehicul
GROUP BY a.id_angajat, a.nume_angajat
ORDER BY valoare_totala DESC;

-- Query 09: Calculate the total value of sold and unsold vehicles.
SELECT stare,
       SUM(pret) AS valoare_totala
FROM Vehicule
GROUP BY stare;

-- Query 10: Label the sale month using DECODE.
SELECT z.id_vanzare,
       v.marca,
       v.model,
       DECODE(
           TO_CHAR(z.data, 'MM'),
           '01', 'Ianuarie',
           '02', 'Februarie',
           '03', 'Martie',
           '04', 'Aprilie',
           'Alta luna'
       ) AS luna_vanzarii
FROM Vanzari z
JOIN Vehicule v ON z.id_masina = v.id_vehicul;

-- Query 11: Categorise vehicles by price using CASE.
SELECT marca,
       model,
       pret,
       CASE
           WHEN pret < 20000 THEN 'Pret mic'
           WHEN pret BETWEEN 20000 AND 40000 THEN 'Pret mediu'
           ELSE 'Pret mare'
       END AS categorie_pret
FROM Vehicule
ORDER BY pret;

-- Query 12: Display clients who bought a BMW.
SELECT c.nume_client,
       c.telefon
FROM Clienti c
WHERE c.id_client IN (
    SELECT z.id_client
    FROM Vanzari z
    JOIN Vehicule v ON z.id_masina = v.id_vehicul
    WHERE v.marca = 'BMW'
);

-- Query 13: Display sold vehicles and the responsible salesperson.
SELECT z.id_vanzare,
       z.data,
       a.nume_angajat,
       a.functie,
       v.marca,
       v.model
FROM Vanzari z
JOIN Angajati a ON z.id_angajat = a.id_angajat
JOIN Vehicule v ON z.id_masina = v.id_vehicul
ORDER BY z.data;

-- Query 14: Display salespeople with at least two sales.
SELECT z.id_angajat,
       a.nume_angajat,
       COUNT(*) AS numar_vanzari
FROM Vanzari z
JOIN Angajati a ON z.id_angajat = a.id_angajat
GROUP BY z.id_angajat, a.nume_angajat
HAVING COUNT(*) >= 2
ORDER BY numar_vanzari DESC;

-- Query 15: Count available vehicles by brand.
SELECT v.marca,
       COUNT(s.id_stoc) AS masini_pe_stoc
FROM Stocuri s
JOIN Vehicule v ON s.id_vehicul = v.id_vehicul
WHERE v.stare = 'Disponibila'
GROUP BY v.marca
ORDER BY masini_pe_stoc DESC, v.marca;

-- Query 16: Display vehicles sold during the first seven days of a month in 2024.
SELECT v.marca,
       v.model,
       z.data
FROM Vanzari z
JOIN Vehicule v ON z.id_masina = v.id_vehicul
WHERE EXTRACT(YEAR FROM z.data) = 2024
  AND z.data BETWEEN TRUNC(z.data, 'MM') AND TRUNC(z.data, 'MM') + 6
ORDER BY z.data;

-- Query 17: Calculate the monthly sales value.
SELECT TO_CHAR(z.data, 'YYYY-MM') AS luna,
       SUM(v.pret) AS valoare_totala
FROM Vanzari z
JOIN Vehicule v ON z.id_masina = v.id_vehicul
GROUP BY TO_CHAR(z.data, 'YYYY-MM')
ORDER BY luna;

-- Query 18: Display the five least expensive available vehicles.
SELECT id_vehicul, marca, model, pret
FROM Vehicule
WHERE stare = 'Disponibila'
ORDER BY pret ASC
FETCH FIRST 5 ROWS ONLY;

-- Query 19: Display available vehicles by descending price.
SELECT id_vehicul, marca, model, pret
FROM Vehicule
WHERE stare = 'Disponibila'
ORDER BY pret DESC;

-- Query 20: Calculate the number and average value of sales for each salesperson.
SELECT a.nume_angajat,
       COUNT(z.id_vanzare) AS total_vanzari,
       ROUND(AVG(v.pret), 2) AS pret_mediu
FROM Vanzari z
JOIN Angajati a ON z.id_angajat = a.id_angajat
JOIN Vehicule v ON z.id_masina = v.id_vehicul
GROUP BY a.nume_angajat
ORDER BY total_vanzari DESC;

-- Query 21: Display clients who bought vehicles priced below 15,000 EUR.
SELECT c.nume_client,
       v.marca,
       v.model,
       v.pret
FROM Vanzari z
JOIN Clienti c ON z.id_client = c.id_client
JOIN Vehicule v ON z.id_masina = v.id_vehicul
WHERE v.pret < 15000;

-- Query 22: Display sales made by a selected employee name prefix.
SELECT z.id_vanzare,
       a.nume_angajat,
       v.marca,
       v.model,
       z.data
FROM Vanzari z
JOIN Angajati a ON z.id_angajat = a.id_angajat
JOIN Vehicule v ON z.id_masina = v.id_vehicul
WHERE a.nume_angajat LIKE 'Angajat Exemplu 0%';

-- Query 23: Count sold vehicles by brand.
SELECT v.marca,
       COUNT(z.id_masina) AS total_vanzari
FROM Vehicule v
JOIN Vanzari z ON v.id_vehicul = z.id_masina
GROUP BY v.marca
ORDER BY total_vanzari DESC;

-- Query 24: Display the most expensive sold vehicle and its client.
SELECT c.nume_client,
       v.marca,
       v.model,
       v.pret
FROM Clienti c
JOIN Vanzari z ON c.id_client = z.id_client
JOIN Vehicule v ON z.id_masina = v.id_vehicul
WHERE v.pret = (
    SELECT MAX(v2.pret)
    FROM Vehicule v2
    JOIN Vanzari z2 ON v2.id_vehicul = z2.id_masina
);

-- Query 25: Display sold vehicles in chronological order.
SELECT a.nume_angajat,
       v.marca,
       v.model,
       z.data
FROM Angajati a
JOIN Vanzari z ON a.id_angajat = z.id_angajat
JOIN Vehicule v ON z.id_masina = v.id_vehicul
ORDER BY z.data ASC;

-- Query 26: Display the employee with the highest number of sales.
SELECT a.nume_angajat,
       COUNT(z.id_vanzare) AS total_vanzari
FROM Angajati a
JOIN Vanzari z ON a.id_angajat = z.id_angajat
GROUP BY a.nume_angajat
ORDER BY total_vanzari DESC
FETCH FIRST 1 ROW ONLY;

-- Query 27: Display clients who bought vehicles above the overall average price.
SELECT c.nume_client,
       z.data,
       v.marca,
       v.model,
       v.pret
FROM Clienti c
JOIN Vanzari z ON c.id_client = z.id_client
JOIN Vehicule v ON z.id_masina = v.id_vehicul
WHERE v.pret > (
    SELECT AVG(pret)
    FROM Vehicule
);

-- Query 28: Display sales from a fixed nine-month interval.
SELECT z.id_vanzare,
       c.nume_client,
       v.marca,
       v.model,
       z.data
FROM Vanzari z
JOIN Clienti c ON z.id_client = c.id_client
JOIN Vehicule v ON z.id_masina = v.id_vehicul
WHERE z.data BETWEEN DATE '2024-03-17' AND DATE '2024-12-17'
ORDER BY z.data;

-- Query 29: Calculate the stock value of every available vehicle.
SELECT s.id_stoc,
       v.marca,
       v.model,
       s.cantitate,
       v.pret,
       s.cantitate * v.pret AS valoare_totala
FROM Stocuri s
JOIN Vehicule v ON s.id_vehicul = v.id_vehicul;

-- Query 30: Display vehicles that do not appear in the sales table.
SELECT v.marca,
       v.model,
       v.pret
FROM Vehicule v
WHERE NOT EXISTS (
    SELECT 1
    FROM Vanzari z
    WHERE z.id_masina = v.id_vehicul
)
ORDER BY v.pret;

-- Query 31: Display the least expensive available vehicle.
SELECT marca, model, pret
FROM Vehicule
WHERE stare = 'Disponibila'
  AND pret = (
      SELECT MIN(pret)
      FROM Vehicule
      WHERE stare = 'Disponibila'
  );

-- Query 32: Display employees whose salaries are above the average salary.
SELECT nume_angajat,
       functie,
       salariu
FROM Angajati
WHERE salariu > (
    SELECT AVG(salariu)
    FROM Angajati
)
ORDER BY salariu DESC;

-- Query 33: Calculate the total salary cost for each role.
SELECT functie,
       SUM(salariu) AS salariu_total
FROM Angajati
GROUP BY functie
ORDER BY salariu_total DESC;

-- Query 34: Display complete sale details.
SELECT z.id_vanzare,
       v.marca,
       v.model,
       c.nume_client,
       a.nume_angajat,
       z.data
FROM Vanzari z
JOIN Vehicule v ON z.id_masina = v.id_vehicul
JOIN Clienti c ON z.id_client = c.id_client
JOIN Angajati a ON z.id_angajat = a.id_angajat
ORDER BY z.id_vanzare;

-- Query 35: Display suppliers assigned to vehicles.
SELECT v.id_vehicul,
       v.marca,
       v.model,
       f.nume_furnizor
FROM Vehicule v
JOIN Furnizori f ON v.id_furnizor = f.id_furnizor
ORDER BY v.id_vehicul;

-- Query 36: Display names that appear in both client and employee tables.
SELECT nume_client AS nume
FROM Clienti
INTERSECT
SELECT nume_angajat AS nume
FROM Angajati;

-- Query 37: Display vehicle brands that have not been sold.
SELECT marca
FROM Vehicule
MINUS
SELECT v.marca
FROM Vehicule v
JOIN Vanzari z ON v.id_vehicul = z.id_masina;
