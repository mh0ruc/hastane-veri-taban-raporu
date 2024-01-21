CREATE DATABASE ODEV1;

USE ODEV1;

CREATE TABLE BOLUMLER (
    BOLUM_ID INT PRIMARY KEY,
	BOLUM_ADI VARCHAR(255),
    CALISAN_KISI_SAYISI INT -- Assuming it's a numerical value

);


CREATE TABLE DOKTORLAR (
    DOKTOR_ID INT PRIMARY KEY,
    AD VARCHAR(255), -- Specify the length of the VARCHAR
    SOYAD VARCHAR(255),
    UZMANLIK_ALANI VARCHAR(255),
    BOLUM_ID INT,
    RANDEVU_ID INT,
	FOREIGN KEY (BOLUM_ID) REFERENCES BOLUMLER(BOLUM_ID)

);
 
   

CREATE TABLE HASTALAR (
    HASTA_ID INT PRIMARY KEY,
    AD VARCHAR(255),
    SOYAD VARCHAR(255),
    CINSIYET VARCHAR(10), -- Assuming it's a short string like 'Male' or 'Female'
    RANDEVU_ID INT,

    
);

CREATE TABLE ILACLAR (
    ILAC_ID INT PRIMARY KEY,
    AD VARCHAR(255),
    DOZAJ VARCHAR(255)
);

CREATE TABLE PERSONEL (
    PERSONEL_ID INT PRIMARY KEY,
    AD VARCHAR(255),
    SOYAD VARCHAR(255),
    POZISYON VARCHAR(255),
    BOLUM_ID INT,
 
);


CREATE TABLE RANDEVULAR (
    RANDEVU_ID INT PRIMARY KEY,
    HASTA_ID INT,
    DOKTOR_ID INT,
    TEST_ID INT,
    RECETE_ID INT,
    ODA_NO INT,
    RANDEVU_ZAMANI DATE,
    FOREIGN KEY (HASTA_ID) REFERENCES HASTALAR(HASTA_ID),
    FOREIGN KEY (DOKTOR_ID) REFERENCES DOKTORLAR(DOKTOR_ID),
    FOREIGN KEY (TEST_ID) REFERENCES TEST(TEST_ID),
    FOREIGN KEY (RECETE_ID) REFERENCES RECETE(RECETE_ID)
);

CREATE TABLE RECETE (
    RECETE_ID INT PRIMARY KEY,
    AD VARCHAR(255),
    MALIYET INT,
    RANDEVU_ID INT,
    ILAC_ID INT,
    FOREIGN KEY (ILAC_ID) REFERENCES ILACLAR(ILAC_ID)
);

CREATE TABLE TEST (
    TEST_ID INT PRIMARY KEY,
    AD VARCHAR(255),
    MALIYET INT
);

-- HASTALAR tablosunu doldurun
INSERT INTO HASTALAR (HASTA_ID, AD, SOYAD, CINSIYET, RANDEVU_ID)
VALUES (1, 'Ali', 'Can', 'Erkek', NULL),
       (2, 'Fatma', 'Kara', 'Kadýn', NULL),
       (3, 'Hasan', 'Þahin', 'Erkek', NULL),
       (4, 'Merve', 'Ak', 'Kadýn', NULL),
       (5, 'Cemal', 'Yýlmaz', 'Erkek', NULL);

-- DOKTORLAR tablosunu doldurun
INSERT INTO DOKTORLAR (DOKTOR_ID, AD, SOYAD, UZMANLIK_ALANI, BOLUM_ID, RANDEVU_ID)
VALUES (1, 'Ahmet', 'Yýlmaz', 'Kalp Cerrahisi', 1, NULL),
       (2, 'Ayþe', 'Demir', 'Kardiyoloji', 2, NULL),
       (3, 'Mehmet', 'Kara', 'Ýç Hastalýklarý', 3, NULL),
       (4, 'Zeynep', 'Can', 'Nöroloji', 1, NULL),
       (5, 'Cem', 'Aydýn', 'Göz Hastalýklarý', 2, NULL);

-- TEST tablosunu doldurun
INSERT INTO TEST (TEST_ID, AD, MALIYET)
VALUES (1, 'Test1', 80),
       (2, 'Test2', 60),
       (3, 'Test3', 70),
       (4, 'Test4', 90),
       (5, 'Test5', 75);

	   INSERT INTO PERSONEL (PERSONEL_ID, AD, SOYAD, POZISYON, BOLUM_ID)
VALUES (1, 'Zeynep', 'Çelik', 'Hemþire', 1),
       (2, 'Cem', 'Aydýn', 'Sekreter', 2),
       (3, 'Ahmet', 'Yýldýrým', 'Temizlik Görevlisi', 3),
       (4, 'Ayþe', 'Demir', 'Hemþire', 4),
       (5, 'Mehmet', 'Kara', 'Sekreter', 5);

	   -- BOLUMLER tablosunu doldurun
INSERT INTO BOLUMLER (BOLUM_ID, CALISAN_KISI_SAYISI, BOLUM_ADI)
VALUES (1, 10, 'Genel Cerrahi'),
       (2, 8, 'Kardiyoloji'),
       (3, 12, 'Dahiliye'),
       (4, 15, 'Nöroloji'),
       (5, 9, 'Göz Hastalýklarý');

	   INSERT INTO ILACLAR (ILAC_ID, AD, DOZAJ)
VALUES (1, 'Parol', '10 mg'),
       (2, 'Aspirin', '20 mg'),
       (3, 'Lipitor', '40 mg'),
       (4, 'Panadol', '15 mg'),
       (5, 'Plavix', '25 mg');

-- RECETE tablosunu doldurun (ILAC_ID deðerlerini var olan ILACLAR tablosundan alarak)
INSERT INTO RECETE (RECETE_ID, AD, MALIYET, ILAC_ID)
VALUES (1, 'Reçete1', 50, 1),
       (2, 'Reçete2', 30, 2),
       (3, 'Reçete3', 40, 3),
       (4, 'Reçete4', 60, 4),
       (5, 'Reçete5', 35, 5);

-- RANDEVULAR tablosunu doldurun (RECETE_ID deðerlerini var olan RECETE tablosundan alarak)
INSERT INTO RANDEVULAR (RANDEVU_ID, HASTA_ID, DOKTOR_ID, TEST_ID, RECETE_ID, ODA_NO, RANDEVU_ZAMANI)
VALUES (1, 1, 1, 1, 1, 101, '2024-01-20'),
       (2, 2, 2, 2, 2, 102, '2024-01-21'),
       (3, 3, 3, 3, 3, 103, '2024-01-22'),
       (4, 4, 4, 4, 4, 104, '2024-01-23'),
       (5, 5, 5, 5, 5, 105, '2024-01-24');

	   
--------------------------------------------------------------------

SELECT R.RANDEVU_ID, H.AD AS HASTA_AD, H.SOYAD AS HASTA_SOYAD, D.AD AS DOKTOR_AD, D.SOYAD AS DOKTOR_SOYAD
FROM RANDEVULAR R
INNER JOIN HASTALAR H ON R.HASTA_ID = H.HASTA_ID
INNER JOIN DOKTORLAR D ON R.DOKTOR_ID = D.DOKTOR_ID;

--------------------------------------------------------------------
HASTALARA AÝT RANDEVULAR
SELECT HASTA_ID, AD, SOYAD
FROM HASTALAR
WHERE HASTA_ID IN (SELECT HASTA_ID FROM RANDEVULAR);


--------------------------------------------------------------------
---PERSONELLERÝN BÖLÜMLERÝ 
SELECT * FROM PERSONEL INNER JOIN BOLUMLER ON  BOLUMLER.BOLUM_ID=PERSONEL.BOLUM_ID

--------------------------------------------------------------------
---MALÝYETÝ 35  TEN BÜYÜK  REÇETELERÝ VE O REÇETELERE AÝT ÝLAÇLARI GETÝREN SORGU
SELECT R.RECETE_ID, R.AD AS RECETE_AD, R.MALIYET,
       I.ILAC_ID, I.AD AS ILAC_AD, I.DOZAJ
FROM RECETE R
JOIN ILACLAR I ON R.ILAC_ID = I.ILAC_ID
WHERE R.MALIYET > 35;

--------------------------------------------------------------------
CREATE PROCEDURE RandevuEkle
    @HastaAd VARCHAR(50),
    @HastaSoyad VARCHAR(50),
    @Cinsiyet VARCHAR(10),
    @DoktorAd VARCHAR(50),
    @DoktorSoyad VARCHAR(50),
    @UzmanlikAlani VARCHAR(50),
    @RandevuZamani DATETIME
AS
BEGIN
    DECLARE @HastaID INT, @DoktorID INT;

    -- Hasta ekleniyor
    INSERT INTO HASTALAR (AD, SOYAD, CINSIYET) VALUES (@HastaAd, @HastaSoyad, @Cinsiyet);
    SET @HastaID = SCOPE_IDENTITY();

    -- Doktor ekleniyor
    INSERT INTO DOKTORLAR (AD, SOYAD, UZMANLIK_ALANI) VALUES (@DoktorAd, @DoktorSoyad, @UzmanlikAlani);
    SET @DoktorID = SCOPE_IDENTITY();

    -- Randevu ekleniyor
    INSERT INTO RANDEVULAR (HASTA_ID, DOKTOR_ID, RANDEVU_ZAMANI) VALUES (@HastaID, @DoktorID, @RandevuZamani);
END;


--------------------------------------------------------------------
CREATE FUNCTION ToplamRandevuSayisi()
RETURNS INT
AS
BEGIN
    DECLARE @ToplamRandevu INT;

    SELECT @ToplamRandevu = COUNT(*) FROM RANDEVULAR;

    RETURN @ToplamRandevu;
END;

--------------------------------------------------------------------

CREATE TRIGGER RandevuEklendiginde
ON RANDEVULAR
AFTER INSERT
AS
BEGIN
    DECLARE @DoktorAdSoyad VARCHAR(100);

    SELECT @DoktorAdSoyad = DOKTORLAR.AD + ' ' + DOKTORLAR.SOYAD
    FROM DOKTORLAR
    INNER JOIN inserted ON DOKTORLAR.DOKTOR_ID = inserted.DOKTOR_ID;

    PRINT 'Yeni randevu eklenmiþtir. Doktor: ' + @DoktorAdSoyad;
END;
--------------------------------------------------------------------
SELECT dbo.ToplamRandevuSayisi() AS ToplamRandevuSayisi;
--------------------------------------------------------------------
-- Yeni bir hasta ekle
INSERT INTO HASTALAR (HASTA_ID, AD, SOYAD, CINSIYET, RANDEVU_ID)
VALUES (6, 'MUSTAFA', 'ORUÇ', 'Erkek', NULL)

INSERT INTO RANDEVULAR (RANDEVU_ID, HASTA_ID, DOKTOR_ID, TEST_ID, RECETE_ID, ODA_NO, RANDEVU_ZAMANI)
VALUES (6, 6, 4, 3, 2, 104, '2024-01-21')
--------------------------------------------------------------------
----EKLENEN HASTAYI SÝL
DECLARE @SilinecekHastaID INT;
SET @SilinecekHastaID = 6;


DECLARE @SilinecekRandevuIDler TABLE (RANDEVU_ID INT);

INSERT INTO @SilinecekRandevuIDler (RANDEVU_ID)
SELECT RANDEVU_ID
FROM RANDEVULAR
WHERE HASTA_ID = @SilinecekHastaID;


DELETE FROM RANDEVULAR
WHERE HASTA_ID = @SilinecekHastaID;


DELETE FROM HASTALAR
WHERE HASTA_ID = @SilinecekHastaID;