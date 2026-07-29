-- ============================================================
-- Sample data
-- All people and phone numbers in this file are fictional.
-- ============================================================

SET DEFINE OFF;

-- Suppliers
INSERT INTO Furnizori VALUES (1, 'Licitatie Germania');
INSERT INTO Furnizori VALUES (2, 'Licitatie Olanda');
INSERT INTO Furnizori VALUES (3, 'Licitatie Spania');
INSERT INTO Furnizori VALUES (4, 'Licitatie Polonia');
INSERT INTO Furnizori VALUES (5, 'Germania - furnizor privat');
INSERT INTO Furnizori VALUES (6, 'Olanda - furnizor privat');
INSERT INTO Furnizori VALUES (7, 'Spania - furnizor privat');
INSERT INTO Furnizori VALUES (8, 'Polonia - furnizor privat');
INSERT INTO Furnizori VALUES (9, 'Romania - furnizor privat');
INSERT INTO Furnizori VALUES (10, 'Alte surse');

-- Clients
INSERT INTO Clienti VALUES (1, 'Client Exemplu 01', '0700000001');
INSERT INTO Clienti VALUES (2, 'Client Exemplu 02', '0700000002');
INSERT INTO Clienti VALUES (3, 'Client Exemplu 03', '0700000003');
INSERT INTO Clienti VALUES (4, 'Client Exemplu 04', '0700000004');
INSERT INTO Clienti VALUES (5, 'Client Exemplu 05', '0700000005');
INSERT INTO Clienti VALUES (6, 'Client Exemplu 06', '0700000006');
INSERT INTO Clienti VALUES (7, 'Client Exemplu 07', '0700000007');
INSERT INTO Clienti VALUES (8, 'Client Exemplu 08', '0700000008');
INSERT INTO Clienti VALUES (9, 'Client Exemplu 09', '0700000009');
INSERT INTO Clienti VALUES (10, 'Client Exemplu 10', '0700000010');

-- Employees
INSERT INTO Angajati VALUES (1, 'Angajat Exemplu 01', 'Director', 15000);
INSERT INTO Angajati VALUES (2, 'Angajat Exemplu 02', 'Manager', 12000);
INSERT INTO Angajati VALUES (3, 'Angajat Exemplu 03', 'Social Media/Promovare', 7000);
INSERT INTO Angajati VALUES (4, 'Angajat Exemplu 04', 'Social Media/Promovare', 7000);
INSERT INTO Angajati VALUES (5, 'Angajat Exemplu 05', 'Documente Auto', 8000);
INSERT INTO Angajati VALUES (6, 'Angajat Exemplu 06', 'Vânzător Mașini', 10000);
INSERT INTO Angajati VALUES (7, 'Angajat Exemplu 07', 'Vânzător Mașini', 10000);
INSERT INTO Angajati VALUES (8, 'Angajat Exemplu 08', 'Vânzător Mașini', 10000);
INSERT INTO Angajati VALUES (9, 'Angajat Exemplu 09', 'Inspector Auto', 9000);
INSERT INTO Angajati VALUES (10, 'Angajat Exemplu 10', 'Inspector Auto', 9000);

-- Vehicles
INSERT INTO Vehicule VALUES (1, 'BMW', 'Seria 3', 25000, 'Indisponibila', 1);
INSERT INTO Vehicule VALUES (2, 'Audi', 'A4', 23000, 'Indisponibila', 1);
INSERT INTO Vehicule VALUES (3, 'Mercedes', 'C-Class', 28000, 'Indisponibila', 1);
INSERT INTO Vehicule VALUES (4, 'Volkswagen', 'Passat', 18000, 'Indisponibila', 2);
INSERT INTO Vehicule VALUES (5, 'Ford', 'Focus', 15000, 'Indisponibila', 2);
INSERT INTO Vehicule VALUES (6, 'Toyota', 'Corolla', 17000, 'Indisponibila', 2);
INSERT INTO Vehicule VALUES (7, 'Honda', 'Civic', 6000, 'Indisponibila', 3);
INSERT INTO Vehicule VALUES (8, 'Hyundai', 'Elantra', 14000, 'Indisponibila', 3);
INSERT INTO Vehicule VALUES (9, 'Renault', 'Megane', 13000, 'Indisponibila', 3);
INSERT INTO Vehicule VALUES (10, 'Peugeot', '308', 12000, 'Indisponibila', 4);
INSERT INTO Vehicule VALUES (11, 'BMW', 'Seria 5', 35000, 'Disponibila', 4);
INSERT INTO Vehicule VALUES (12, 'BMW', 'X5', 45000, 'Disponibila', 4);
INSERT INTO Vehicule VALUES (13, 'Audi', 'A6', 34000, 'Disponibila', 5);
INSERT INTO Vehicule VALUES (14, 'Audi', 'Q7', 50000, 'Disponibila', 5);
INSERT INTO Vehicule VALUES (15, 'Mercedes', 'E-Class', 37000, 'Disponibila', 5);
INSERT INTO Vehicule VALUES (16, 'Mercedes', 'GLE', 60000, 'Disponibila', 6);
INSERT INTO Vehicule VALUES (17, 'Honda', 'CR-V', 28000, 'Disponibila', 7);
INSERT INTO Vehicule VALUES (18, 'Honda', 'Accord', 27000, 'Disponibila', 8);
INSERT INTO Vehicule VALUES (19, 'BMW', 'i3', 40000, 'Disponibila', 9);
INSERT INTO Vehicule VALUES (20, 'Mercedes', 'C-Class Coupe', 42000, 'Disponibila', 10);

-- Sales
INSERT INTO Vanzari VALUES (1, 1, 1, 6, DATE '2024-01-05');
INSERT INTO Vanzari VALUES (2, 2, 2, 7, DATE '2024-01-18');
INSERT INTO Vanzari VALUES (3, 3, 3, 8, DATE '2024-02-02');
INSERT INTO Vanzari VALUES (4, 4, 4, 6, DATE '2024-02-15');
INSERT INTO Vanzari VALUES (5, 5, 5, 7, DATE '2024-03-01');
INSERT INTO Vanzari VALUES (6, 6, 6, 8, DATE '2024-03-20');
INSERT INTO Vanzari VALUES (7, 7, 7, 7, DATE '2024-04-05');
INSERT INTO Vanzari VALUES (8, 8, 8, 7, DATE '2024-04-22');
INSERT INTO Vanzari VALUES (9, 9, 9, 8, DATE '2024-05-10');
INSERT INTO Vanzari VALUES (10, 10, 10, 6, DATE '2024-05-25');

-- Available stock
INSERT INTO Stocuri VALUES (1, 11, 1);
INSERT INTO Stocuri VALUES (2, 12, 1);
INSERT INTO Stocuri VALUES (3, 13, 1);
INSERT INTO Stocuri VALUES (4, 14, 1);
INSERT INTO Stocuri VALUES (5, 15, 1);
INSERT INTO Stocuri VALUES (6, 16, 1);
INSERT INTO Stocuri VALUES (7, 17, 1);
INSERT INTO Stocuri VALUES (8, 18, 1);
INSERT INTO Stocuri VALUES (9, 19, 1);
INSERT INTO Stocuri VALUES (10, 20, 1);

COMMIT;
