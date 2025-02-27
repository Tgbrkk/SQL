------------------ DAY 5 ------------------
--25-EXISTS Condition

/*Senaryo 1: “march” ve “april” adlarinda iki tablo oluşturunuz ve Mart ayında 'Toyota' satışı yapılmış ise Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.*/
/*Scenario : Create two tables named "march" and "april" and list the information of all products in April if 'Toyota' was sold in March.*/

CREATE TABLE march(     
urun_id int,      
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO march VALUES (10, 'Mark', 'Honda');
INSERT INTO march VALUES (20, 'John', 'Toyota');
INSERT INTO march VALUES (30, 'Amy', 'Ford');
INSERT INTO march VALUES (20, 'Mark', 'Toyota');
INSERT INTO march VALUES (10, 'Adam', 'Honda');
INSERT INTO march VALUES (40, 'John', 'Hyundai');
INSERT INTO march VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE april (     
urun_id int ,
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO april VALUES (10, 'Hasan', 'Honda');
INSERT INTO april VALUES (10, 'Kemal', 'Honda');
INSERT INTO april VALUES (20, 'Ayse', 'Toyota');
INSERT INTO april VALUES (50, 'Yasar', 'Volvo');
INSERT INTO april VALUES (20, 'Mine', 'Toyota');

SELECT * FROM march;
SELECT * FROM april;

SELECT * 
FROM april
WHERE EXISTS (SELECT * FROM march WHERE urun_isim ='Toyota');

--------------------------------------
/*Senaryo 2: Mart ayında 'Volvo' satışı yapılmışsa, Nisan ayındaki tüm ürünlerin bilgilerini listeleyiniz.*/
/*Scenario 2: If 'Volvo' was sold in March, list the information of all products in April.*/

SELECT * 
FROM april
WHERE EXISTS (SELECT * FROM march WHERE urun_isim='Volvo');

---------------------------------------------------
/*Senaryo 3: Mart ayında satılan ürünlerin urun_id ve musteri_isim’lerini, eğer urun(urun_isim) Nisan ayında da satılmışsa, listeleyen bir sorgu yazınız.*/
/*Scenario 3: Write a query that lists the product_id and customer_name of the products sold in March, if the product(urun_isim) was also sold in April.*/

SELECT urun_id,musteri_isim
FROM march AS m --tablo ismi geçici olarak m oldu
WHERE EXISTS (SELECT urun_isim FROM april AS a WHERE a.urun_isim=m.urun_isim);

---------------------------------------------------
/*Senaryo 4: Her iki ayda birden satılan ürünlerin urun_isim’lerini, bu ürünleri NİSAN ayında satın alan musteri_isim’lerine gore listeleyen bir sorgu yazınız*/
/*Scenario 4: Write a query that lists the product names of the products sold in both months according to the customer names that purchased these products in APRIL*/

SELECT urun_isim,musteri_isim
FROM april a 
WHERE EXISTS (SELECT * FROM march m WHERE m.urun_isim=a.urun_isim); 

-- ÖDEV: Martta satılıp Nisanda satilmayan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--MART ayında satın alan musteri isimlerini listeleyen bir sorgu yazınız.
-- HOMEWORK: Identify the product names of the products that were sold in March but not in April and
--Write a query that lists the names of customers who purchased in March.

--------------------
--26-UPDATE tablo_adı SET sütunadı=yeni değer 
--WHERE koşul 
-- koşulu sağlayan kayıtlar güncellenir


/*Senaryo 1: employees4 adli bir tablo olusturunuz. id’si 123456789 olan çalışanın isyeri ismini 'Trendyol' olarak güncelleyiniz.*/
/*Scenario 1: Create a table named employees4. update the workplace name of the employee whose id is 123456789 to ‘Trendyol'.*/

CREATE TABLE employees4 (
id INT UNIQUE, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas INT, 
isyeri VARCHAR(20)
);

INSERT INTO employees4 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees4 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees4 VALUES(345678901, null, 'Ankara', 3000, 'Vakko');
INSERT INTO employees4 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees4 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees4 VALUES(678901234, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees4 VALUES(789012345, 'Fatma Yasa', null, 2500, 'Vakko');
INSERT INTO employees4 VALUES(890123456, null, 'Bursa', 2500, 'Vakko');
INSERT INTO employees4 VALUES(901234567, 'Ali Han', null, 2500, 'Vakko');

SELECT * FROM employees4;

UPDATE employees4 
SET isyeri ='Trendyol'
WHERE id =123456789;

---------------------------
/*Senaryo 2: id’si 567890123 olan çalışanın ismini 'Veli Yıldırım' ve sehrini 'Bursa' olarak güncelleyiniz.*/
/*Scenario 2: Update the name of the employee whose id is 567890123 as 'Veli Yıldırım' and the city as ‘Bursa'.*/

UPDATE employees4
SET isim='Veli Yıldırım',sehir='Bursa'
WHERE id=567890123;

----------------------------
/*Senaryo 3: brands tablosundaki marka_id değeri 102’ye eşit veya büyük olanların marka_id’sini 2 ile çarparak değiştirin.*/
/*Scenario 3: change the marka_id of brands in the brands table with a marka_id greater than or equal to 102 by multiplying by 2.*/

SELECT * FROM brands;

UPDATE brands
SET marka_id=marka_id*2
WHERE marka_id>=102;

------------------------------------
/*Senaryo 4: brands tablosundaki tüm markaların calisan_sayisi değerlerini marka_id ile toplayarak güncelleyiniz.*/
/*Scenario 4: Update the calisan_sayisi values of all brands in the brands table by adding them with marka_id.*/

UPDATE brands
SET calisan_sayisi = marka_id + calisan_sayisi;

---------------------------------
/*Senaryo 5: employees4 tablosundan Ali Seker’in isyerini, 567890123 id’li çalışanın isyeri ismi ile güncelleyiniz.*/
/*Scenario 5: Update the workplace of Ali Seker from table employees4 with the workplace name of the employee with id 567890123.*/

UPDATE employees4
SET isyeri =(SElECT isyeri FROM employees4 WHERE id=567890123)
WHERE isim='Ali Seker';
--SELECT isyeri FROM employees4 WHERE id = 567890123 ile Adidas'i dinamik olarak aldik

-------------------------------------
/*Senaryo 6: employees4 tablosunda maasi 1500 olanların isyerini, markalar tablosunda marka_id=100 olan markanın ismi ile değiştiriniz.*/
/*Scenario 6: Replace the workplace of those with salary 1500 in the employees4 table with the name of the brand with marka_id=100 in the brands table.*/

UPDATE employees4
SET isyeri=(SELECT marka_isim FROM brands WHERE marka_id=100)
WHERE maas=1500;

SELECT * FROM employees4;

--employees4 tablosundaki isyeri 'Vakko' olanların sehir bilgisinin sonuna ' Şubesi' ekleyiniz.
--Add ' Şubesi’ at the end of the city information of those whose workplace is 'Vakko' in the employees4 table.

--|| operatörü, SQL'de dizeleri birleştirmek (concatenate) için kullanılır. Java'daki + operatörü ile benzer işlevi görür.

UPDATE employees4
SET sehir = sehir||' subesi'
WHERE isyeri='Vakko';

--alternatif null a etki etmesi için

UPDATE employees4
SET sehir = CONCAT(sehir,' subesi')
WHERE isyeri='Vakko';

--------------------------------------
--27-IS NULL condition 
 
--Ornek 1: employees4 tablosunda isim sütunu null olanları listeleyiniz.
--Example 1: List those whose name column is null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NULL;

--Ornek 2: employees4 tablosunda isim sütunu null olmayanları listeleyiniz.
--Example 2: List those whose name column is not null in the employees4 table.

SELECT * FROM employees4
WHERE isim IS NOT NULL;

--Ornek 3: employees4 tablosunda isim sütunu null olanların isim değerini 'isimsiz' olarak güncelleyiniz.
--Example 3: Update the name value of those whose name column is null in the employees4 table to 'isimsiz'.

UPDATE employees4
SET isim='isimsiz'
WHERE isim IS NULL;

SELECT * FROM employees4;

---------------------------
--28-ORDER BY: Kayıtları belirli bir field'e göre azalan/artan şekilde sıralamamızı sağlar.
--VARSAYILAN olarak ASC(natural-artan-doğal) olarak sıralar

/*ORDER BY komutu yalnızca SELECT sorgularıyla birlikte kullanılır çünkü amacı, bir sorgunun sonuç setini belirli kriterlere göre sıralamaktır.  INSERT, UPDATE ve DELETE komutlarıyla kullanılamaz. Bu komutlar, veritabanında veri eklemek, güncellemek veya silmek için kullanılır ve sonuç seti döndürmezler.*/

DROP TABLE person;

CREATE TABLE person(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);

INSERT INTO person VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO person VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO person VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO person VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO person VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO person VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');
INSERT INTO person VALUES(256789018, 'Samet','Bulut', 'Izmir'); 
INSERT INTO person VALUES(256789013, 'Veli','Cem', 'Bursa'); 
INSERT INTO person VALUES(256789010, 'Samet','Bulut', 'Ankara'); 

SELECT * FROM person;

----------------------------------------------
/*Senaryo 1: person tablosundaki tüm kayıtları adrese göre (artan sirada) sıralayarak listeleyiniz.*/
/*Scenario 1: List all records in the person table sorted by address (in ascending order).*/

SELECT *
FROM person
ORDER BY adres;

--ASC otomatik yapilir, gorunur de yapabiliriz
SELECT *
FROM person
ORDER BY adres ASC;

-------------------------------
/*Senaryo 2: person tablosundaki tüm kayıtları soyisime göre (azalan) sıralayarak listeleyiniz.*/
/*Scenario 2: List all records in the person table sorted by surname (descending).*/

SELECT * 
FROM person
ORDER BY soyisim DESC;

--person tablosundaki soyismi Bulut olanları isme göre (azalan) sıralayarak listeleyiniz.
--List the people whose surname is Bulut in the person table in descending order by name.

SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY isim DESC;

--alternatif

SELECT *
FROM person
WHERE soyisim='Bulut'
ORDER BY 2 DESC;--2.sütuna göre sırala olmuş oluyor

------------------------------------------
/*Senaryo 3: person tablosundaki tüm kayıtları isme göre azalan, soyisme göre artan sekilde sıralayarak listeleyiniz.*/
/*Scenario 3: List all records in the person table in descending order by first name and ascending order by surname.*/

SELECT * 
FROM person
ORDER BY isim DESC,soyisim ASC;

---------------------------------------
/*Senaryo 4: person tablosunda isim ve soyisim değerlerini, soyisim kelime uzunluklarına göre sıralayarak listeleyiniz.*/
/*Scenario 4: List the name and surname values in the person table, sorted by surname word lengths.*/

SELECT isim,soyisim
FROM person 
ORDER BY LENGTH(soyisim);

--3.sutun ile uzunluklari da yazdiralim. length’e isim de verelim

SELECT isim,soyisim,LENGTH(soyisim) AS karakter_sayisi
FROM person 
ORDER BY LENGTH(soyisim);

--------------------------------------------
/*Senaryo 5: person tablosunda, tüm isim ve soyisim değerlerini aralarında bir boşluk ile aynı sutunda çağırarak, her bir isim ve soyisim değerinin toplam uzunluğuna göre sıralayınız.*/

/*Scenario 5: In the person table, call all first and last name values in the same column with a space between them and sort by the total length of each first and last name value.*/

SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim,
LENGTH(CONCAT(isim,soyisim))karakter_sayisi
FROM person
ORDER BY LENGTH(CONCAT(isim,soyisim));

-----------------------------------------------
/*Senaryo 6: employees4 tablosunda maaşı ortalama maaştan yüksek olan çalışanların isim,şehir ve maaşlarını maaşa göre artan sekilde sıralayarak listeleyiniz.*/

/*Scenario 6: In table employees4, list the names, cities and salaries of employees whose salaries are higher than the average salary in ascending order by salary.*/

SELECT * FROM employees4;
SELECT AVG(maas) FROM employees4;--2666.6666666666666667

SELECT isim,sehir,maas
FROM employees4
WHERE maas>(SELECT AVG(maas)FROM employees4)
ORDER BY maas;

------------------------------
--29-GROUP BY

CREATE TABLE greengrocer(
isim varchar(50),
urun_adi varchar(50),
urun_miktar int
);

INSERT INTO greengrocer VALUES( 'Ali', 'Elma', 5);
INSERT INTO greengrocer VALUES( 'Ayse', 'Armut', 3);
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 2);  
INSERT INTO greengrocer VALUES( 'Hasan', 'Uzum', 4);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Veli', 'Uzum', 5);  
INSERT INTO greengrocer VALUES( 'Ali', 'Armut', 2);  
INSERT INTO greengrocer VALUES( 'Veli', 'Elma', 3);  
INSERT INTO greengrocer VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM greengrocer;

------------------------
/*Senaryo 1: greengrocer tablosundaki tüm isimleri ve her bir isim için, toplam ürün miktarını görüntüleyiniz.*/
/*Scenario 1: Display all names in the greengrocer table and, for each name, the total quantity of products.*/

SELECT isim,SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim;--group by'ın karsisina select'de ki stun ismi yazılır.

---------------------
/*Senaryo 2: greengrocer tablosundaki tüm isimleri ve her bir isim için toplam ürün miktarını görüntüleyiniz.
Toplam ürün miktarına göre azalan olarak sıralayınız.*/

/*Scenario 2: Display all names in the greengrocer table and the total product quantity for each name.
Sort in descending order by total product quantity.*/

SELECT isim,SUM(urun_miktar) toplam_kg
FROM greengrocer
GROUP BY isim
ORDER BY toplam_kg DESC;

-----------------------
/*Senaryo 3: Her bir ismin aldığı, her bir ürünün toplam miktarını, isme göre sıralı görüntüleyiniz.*/
/*Scenario 3: Display the total amount of each product purchased by each name, ordered by name.*/









































