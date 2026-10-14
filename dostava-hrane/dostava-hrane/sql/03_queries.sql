\xEF\xBB\xBF-- Step 3: example queries (basic, JOINs, aggregation, cursors)
USE dostava_hrane;
GO

-- 1. All available dishes
SELECT naziv, cena FROM Jelo WHERE dostupno = 1;

-- 2. Orders of a single user
SELECT n.narudzbina_id, n.status
FROM Narudzbina n
JOIN Korisnik k ON n.korisnik_id = k.korisnik_id
WHERE k.email = 'marko@email.com';

-- 3. Total revenue per restaurant
SELECT r.naziv, SUM(s.cena_ukupno) AS zarada
FROM Restoran r
JOIN Jelo j ON r.restoran_id = j.restoran_id
JOIN StavkaNarudzbine s ON j.jelo_id = s.jelo_id
GROUP BY r.naziv;

-- 4. Average rating per dish
SELECT j.naziv, AVG(r.ocena) AS prosecna_ocena
FROM Recenzija r
JOIN Jelo j ON r.jelo_id = j.jelo_id
GROUP BY j.naziv;

-- 5. Delivered orders
SELECT narudzbina_id FROM Narudzbina WHERE status = N'dostavljeno';

-- 6. Best-selling dishes
SELECT j.naziv, SUM(s.kolicina) AS ukupno
FROM Jelo j
JOIN StavkaNarudzbine s ON j.jelo_id = s.jelo_id
GROUP BY j.naziv
ORDER BY ukupno DESC;

-- 7. Successful online payments
SELECT * FROM Placanje
WHERE nacin_placanja = 'online' AND status = N'uspešno';

-- 8. Dishes by category
SELECT j.naziv, k.naziv AS kategorija
FROM Jelo j
JOIN Kategorija k ON j.kategorija_id = k.kategorija_id;
GO

-- 9. Cursor: dishes more expensive than 1000 RSD
DECLARE @naziv NVARCHAR(100), @cena DECIMAL(10,2);
DECLARE jela_cursor CURSOR FOR
    SELECT naziv, cena FROM Jelo WHERE cena > 1000;
OPEN jela_cursor;
FETCH NEXT FROM jela_cursor INTO @naziv, @cena;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Skuplje jelo: ' + @naziv + N' - Cena: ' + CAST(@cena AS NVARCHAR);
    FETCH NEXT FROM jela_cursor INTO @naziv, @cena;
END;
CLOSE jela_cursor;
DEALLOCATE jela_cursor;
GO

-- 10. Cursor: orders that are not delivered yet
DECLARE @narudzbina_id INT, @status NVARCHAR(50);
DECLARE narudzbine_cursor CURSOR FOR
    SELECT narudzbina_id, status FROM Narudzbina WHERE status <> N'dostavljeno';
OPEN narudzbine_cursor;
FETCH NEXT FROM narudzbine_cursor INTO @narudzbina_id, @status;
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Narudžbina ID: ' + CAST(@narudzbina_id AS NVARCHAR) + N' - Status: ' + @status;
    FETCH NEXT FROM narudzbine_cursor INTO @narudzbina_id, @status;
END;
CLOSE narudzbine_cursor;
DEALLOCATE narudzbine_cursor;
GO
