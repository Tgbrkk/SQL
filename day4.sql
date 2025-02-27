------------------ DAY 4—————————
--20-IN Condition
--IN: Bir değerin belirli bir değerler listesi içinde olup olmadığını kontrol eder.

/*Senaryo: "customers" adinda bir tablo oluşturun.

customers tablosu sütunları: 
urun_id INTEGER, musteri_isim VARCHAR(50), urun_isim VARCHAR(50)

Tablo uzerinde IN kullanimi yapiniz*/

/*Scenario: Create a table named "customers".

customers table columns: 
product_id INTEGER, customer_name VARCHAR(50), product_name VARCHAR(50)

Use IN on the table */

CREATE TABLE customers  (
urun_id int,  
musteri_isim varchar(50),
urun_isim varchar(50)
);

INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (10, 'Mark', 'Orange');
INSERT INTO customers VALUES (20, 'John', 'Apple');
INSERT INTO customers VALUES (30, 'Amy', 'Palm');
INSERT INTO customers VALUES (20, 'Mark', 'Apple');
INSERT INTO customers VALUES (10, 'Adem', 'Orange');
INSERT INTO customers VALUES (40, 'John', 'Apricot');
INSERT INTO customers VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers;

--customers tablosundan ürün ismi 'Orange', 'Apple' veya 'Apricot' olan verileri listeleyiniz.
-- List the data from the customers table with product name 'Orange', 'Apple' or 'Apricot'.

--1.yol
SELECT * FROM customers WHERE urun_isim='Orange' OR urun_isim='Apple'OR urun_isim='Apricot';
--uzun yolu 

--2.yol
SELECT *
FROM customers
WHERE urun_isim IN ('Orange','Apple','Apricot');
--IN , OR gibi çalışır. 

--customers tablosundan ürün ismi 'Orange', 'Apple' ve 'Apricot' olmayan verileri listeleyiniz.
--List the data from the customers table that do not have the product names 'Orange', 'Apple' and 'Apricot'.

SELECT *
FROM customers
WHERE urun_isim NOT IN ('Orange','Apple','Apricot');
-------------------------------------------------------
--21-BETWEEN .. AND …

--BETWEEN operatörü, belirtilen iki değer arasında kalan değerleri seçmek için kullanılır ve her zaman AND ile birlikte kullanılır.

--customers tablosunda urun_id 20(dahil) ile 30(dahil) arasinda olan urunlerin tum bilgilerini listeleyiniz
--List all the information of the products with product_id between 20(inclusive) and 30(inclusive) in the customers table

----20++++++++30-----

--1.yol
SELECT *
FROM customers
WHERE urun_id>=20 AND urun_id<=30;

--2.yol
SELECT *
FROM customers
WHERE urun_id BETWEEN 20 AND 30;

--customers tablosunda urun_id degeri 20’den küçük veya 30’dan büyük olan urunlerin tum bilgilerini listeleyiniz.(yani 20 ve 30 dahil değil)
--List all the information of the products whose product_id value is less than 20 or greater than 30 in the customers table (ie 20 and 30 are not included).

+++++20------30++++++

SELECT *
FROM customers
WHERE urun_id NOT BETWEEN 20 AND 30;

--ODEV: Eğer kullanıcı yanlışlıkla değerleri ters girerse, bunu kontrol edip düzeltebilirsiniz. Nasil?

----------------------------
--22-AGGREGATE Fonk.

/*COUNT(): Belirtilen sütunda kaç adet değer olduğunu sayar.
SUM(): Sayısal bir sütundaki tüm değerlerin toplamını hesaplar.
AVG(): Sayısal bir sütundaki tüm değerlerin ortalamasını hesaplar.
MIN(): Bir sütundaki en küçük değeri bulur.
MAX(): Bir sütundaki en büyük değeri bulur.*/

/*Senaryo: "brands" ve "employees3" adinda iki tablo oluşturun.*/
/*Scenario: Create two tables named "brands" and "employees3".*/

CREATE TABLE brands(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO brands VALUES(100, 'Vakko', 12000);
INSERT INTO brands VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO brands VALUES(102, 'Adidas', 10000);
INSERT INTO brands VALUES(103, 'LCWaikiki', 21000);

CREATE TABLE employees3(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO employees3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO employees3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO employees3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO employees3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO employees3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO employees3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO employees3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

SELECT * FROM brands;
SELECT * FROM employees3;

--employees3 tablosunda max maaş değerini bulunuz.
--Find the max salary value in the employees3 table.

SELECT MAX(maas)FROM employees3;--7000

--employees3 tablosunda min maaş değerini bulunuz.
--Find the min salary value in the employees3 table.

SELECT MIN(maas)FROM employees3;--1000

--employees3 tablosunda toplam maaş değerini bulunuz.
--Find the total salary value in the employees3 table.

SELECT SUM(maas)FROM employees3;

--employees3 tablosunda ortalama maaş değerini bulunuz.
--Find the average salary value in the employees3 table.

SELECT AVG(maas) FROM employees3; --2714.2857142857142857

SELECT ROUND(AVG(maas) ,2) FROM employees3; --2714.29

--employees3 tablosundaki kayıt sayısını bulunuz.
--Find the number of records in the employees3 table.

SELECT COUNT(id) FROM employees3;--null değerleri saymaz
SELECT COUNT(*) FROM employees3;--null değerleri sayar

--employees3 tablosunda maaşı 2500 olanların kayıt sayısını bulunuz.
--Find the number of records of those whose salary is 2500 in the employees3 table.

SELECT count(*) FROM employees3 WHERE maas=2500;--2

--SELECT isim, count(*) FROM employees3; HATA

--------------------------------------------
--23-ALIASES:Rumuz/Etiket/takma isim

/*Senaryo: "workers" adinda bir tablo oluşturalim.

1-calisan_id sutun ismini id olarak degistirelim
2-calisan_isim sutun ismini isim olarak degistirelim
3-workers olan tablo ismini w olarak degistirelim*/

/*Scenario: Let's create a table called "workers".

1- Let's change the name of column employee_id to id.
2-employee_name column name should be changed to name.
3- Let's change the table name workers to w*/

CREATE TABLE workers(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);

INSERT INTO workers VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO workers VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO workers VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM workers;
-- alies sadece tanımlandığı sorguda isim değiştirmeye yarar

SELECT calisan_id AS id FROM workers;
SELECT calisan_isim AS isim FROM workers;
SELECT calisan_isim isim FROM workers; --AS kullanmadan da calisir

SELECT calisan_isim AS isim FROM workers AS w;
SELECT calisan_isim isim FROM workers w;--AS kullanmadan da calisir

------------------------------------------
--24-SUBQUERY--NESTED QUERY
--24-a-SUBQUERY: WHERE ile kullanımı

--brands ve employees3 tablolarin da subquery calismasi yapalim

/*Senaryo 1: marka_id si 100 olan firmada çalışanların bilgilerini listeleyiniz.*/
/*Scenario 1: List the information of the employees of the company with brand_id 100.*/

--1.yol: dinamik değil

SELECT marka_isim FROM brands WHERE marka_id=100;--Vakko
SELECT * FROM employees3 WHERE isyeri='Vakko';

--2.yol : Dinamik

SELECT * FROM employees3
WHERE isyeri=(SELECT marka_isim FROM brands WHERE marka_id=100);

-----------------------------------------
/*Senaryo 2: (INTERVIEW QUESTION) employees3 tablosunda max maaşı alan çalışanın tüm fieldlarını listeleyiniz.*/
/*Scenario 2: (INTERVIEW QUESTION) List all fields of the employee receiving the max salary in the employees3 table.*/

--1.yol dinamik değil
SELECT * 
FROM employees3
WHERE maas=7000;--çalışır ama dinamik değil

--2.yol dinamik 
SELECT * 
FROM employees3
WHERE maas=(SELECT MAX(maas)FROM employees3);--where kadar yazılan main query,whereden sonra yazılan sub query oluyor.

--Interview Question: employees3 tablosunda ikinci en yüksek maaşı gösteriniz. (ORDER BY kullanmadan cozulecek)
--Interview Question: Show the second highest salary in table employees3. (to be solved without using ORDER BY)

SELECT max(maas)
FROM employees3
WHERE maas<(SELECT max(maas)FROM employees3);--max maası getir ama en yükse olandan bir küçük olanı demektir.

--------------------------
/*Senaryo 3: employees3 tablosunda max veya min maaşı alan çalışanların tüm fieldlarını gösteriniz.*/
/*Scenario 3: Show all fields of employees who receive max or min salary in table employees3.*/

SELECT *
FROM employees3
WHERE maas=(SELECT max(maas)FROM employees3) OR
	  maas=(SELECT min(maas)FROM employees3); 

-----------------------------------
/*Senaryo 4: Ankara'da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.*/
/*Scenario 4: List the brand ids and number of employees of brands with employees in Ankara.*/

SELECT marka_id,calisan_sayisi 
FROM brands WHERE marka_isim IN ('Vakko','Adidas','Pierre Cardin');

SELECT marka_id,calisan_sayisi 
FROM brands 
WHERE marka_isim IN(SELECT isyeri FROM employees3 WHERE sehir='Ankara');

----------------
/*Senaryo 5: marka_id’si 101’den büyük olan marka çalişanlarinin tüm bilgilerini listeleyiniz.*/
/*Scenario 5: list all information of brand employees with brand_id greater than 101.*/

SELECT *
FROM employees3
WHERE isyeri IN (SELECT marka_isim FROM brands WHERE marka_id > 101);

------------------
/*Senaryo 6: Çalisan sayisi 15.000’den cok olan markalarin isimlerini, calisanlarin isimlerini ve maaşlarini listeleyiniz.*/
/*Scenario 6: List the names of brands with more than 15,000 employees, the names of the employees and their salaries.*/

SELECT isim, maas, isyeri
FROM employees3
WHERE isyeri IN(SELECT marka_isim FROM brands WHERE calisan_sayisi > 15000);

--tek sonuc dondugunden eminseniz IN yerine = de kullanabilirsiniz
--unique ve aggregate'ler tek deger dondurur

-------------------------
--24-b-SUBQUERY: SELECT komutundan sonra kullanımı

/*Senaryo 7: Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.*/
/*Scenario 7: Write a QUERY that lists the id, name and total number of cities each brand is located in.*/

SELECT marka_id, marka_isim, (SELECT COUNT(sehir) FROM employees3 WHERE isyeri=marka_isim) FROM brands;

--DISTINCT: Tekrar eden değerleri kaldırarak sorgu sonucunda yalnızca benzersiz değerleri döndürür.

SELECT marka_id, marka_isim, (SELECT COUNT(DISTINCT(sehir)) FROM employees3 WHERE isyeri=marka_isim) AS sehir_sayisi FROM brands;

-------------
/*Senaryo 8: Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minimum maaşini listeleyen bir sorgu yaziniz.*/
/*Scenario 8: Write a query that lists the name of each brand, the number of employees, and the maximum and minimum salary of the employees of that brand.*/

--aggrigate sub query olur .

SELECT marka_isim, calisan_sayisi, (SELECT MAX(maas) FROM employees3 WHERE isyeri=marka_isim), (SELECT MIN(maas) FROM employees3 WHERE isyeri=marka_isim) FROM brands;





























