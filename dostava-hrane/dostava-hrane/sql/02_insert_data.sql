\xEF\xBB\xBF-- Step 2: sample data
USE dostava_hrane;
GO

-- Korisnici (users)
INSERT INTO Korisnik (ime, prezime, email, lozinka, telefon, adresa) VALUES
(N'Marko', N'Marković', 'marko@email.com', 'lozinka123', '0612345678', 'Bulevar Kralja Aleksandra 73'),
(N'Ana', N'Petrović', 'ana@email.com', 'tajna123', '0623456789', 'Nemanjina 10');

-- Restorani (restaurants)
INSERT INTO Restoran (naziv, adresa, telefon, tip_kuhinje) VALUES
(N'Italija u Tanjiru', 'Knez Mihailova 5', '0111234567', 'Italijanska'),
(N'Azijska Magija', 'Balkanska 23', '0112345678', 'Azijska');

-- Kategorije (categories)
INSERT INTO Kategorija (naziv, opis, aktivan) VALUES
(N'Glavno jelo', N'Velika porcija, glavno jelo', 1),
(N'Dezert', N'Slatkiši i kolači', 1),
(N'Piće', N'Alkoholna i bezalkoholna pića', 1);

-- Jela (dishes)
INSERT INTO Jelo (restoran_id, kategorija_id, naziv, opis, cena, dostupno) VALUES
(1, 1, N'Pasta Carbonara', N'Pasta sa jajima, sirom i slaninom', 950.00, 1),
(1, 2, N'Tiramisu', N'Tradicionalni italijanski kolač', 500.00, 1),
(2, 1, N'Pad Thai', N'Pirinač, piletina, sos', 1100.00, 1),
(2, 3, N'Zeleni čaj', N'Osvežavajući napitak', 250.00, 1);

-- Narudžbine (orders)
INSERT INTO Narudzbina (korisnik_id, datum_vreme, status, ukupna_cena) VALUES
(1, GETDATE(), N'na čekanju', 1450.00),
(2, GETDATE(), N'dostavljeno', 1350.00);

-- Stavke narudžbine (order items)
INSERT INTO StavkaNarudzbine (narudzbina_id, jelo_id, kolicina, cena_ukupno) VALUES
(1, 1, 1, 950.00),
(1, 2, 1, 500.00),
(2, 3, 1, 1100.00),
(2, 4, 1, 250.00);

-- Dostavljači (couriers)
INSERT INTO Dostavljac (ime, prezime, vozilo) VALUES
(N'Nikola', N'Jovanović', N'Skuteri'),
(N'Jelena', N'Milovanović', N'Bicikl');

-- Dostava (deliveries)
INSERT INTO Dostava (narudzbina_id, dostavljac_id, vreme_preuzimanja, vreme_isporuke) VALUES
(2, 1, GETDATE(), DATEADD(MINUTE, 30, GETDATE()));

-- Plaćanja (payments)
INSERT INTO Placanje (narudzbina_id, iznos, datum_placanja, nacin_placanja, status) VALUES
(1, 1450.00, GETDATE(), N'gotovina', N'na čekanju'),
(2, 1350.00, GETDATE(), N'online', N'uspešno');

-- Recenzije (reviews)
INSERT INTO Recenzija (korisnik_id, jelo_id, ocena, komentar, datum_postavljanja, verifikovana_kupovina) VALUES
(1, 1, 5, N'Veoma ukusna pasta!', GETDATE(), 1),
(2, 3, 4, N'Odlično jelo, ali pomalo ljuto.', GETDATE(), 1);
GO
