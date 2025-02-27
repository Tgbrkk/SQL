------------------ DAY 3------------------
--12-Tabloya FK constraint'i ekleme

/*Senaryo: "companies" ve "employees" adlarinda iki tablo oluşturun.

companies tablosu sütunları: 
sirket_id INTEGER, sirket VARCHAR(50), personel_sayisi INTEGER
employees tablosu sütunları:
id INTEGER, isim VARCHAR(50), sehir VARCHAR(50), maas REAL, sirket VARCHAR(50)*/

/*Scenario: Create two tables named "companies" and "employees".

Companies table columns: 
company_id INTEGER, company VARCHAR(50), number_of_employees INTEGER
employees table columns:
id INTEGER, name VARCHAR(50), city VARCHAR(50), salary REAL, company VARCHAR(50)*/

CREATE TABLE companies(
sirket_id INTEGER,
sirket VARCHAR(50) PRIMARY KEY,
personel_sayisi INTEGER
);

SELECT * FROM companies;

CREATE TABLE employees(
id INTEGER,
isim VARCHAR(50),
sehir VARCHAR(50),
maas REAL,
sirket VARCHAR(50),
CONSTRAINT per_fk FOREIGN KEY(sirket) REFERENCES companies(sirket)
--FOREIGN KEY(sirket) REFERENCES companies(sirket)); de yazabilirdik
--sirket VARCHAR(50) CONSTRAINT per_fk REFERENCES companies(sirket)); seklinde de yazilabilirdi
);

SELECT * FROM employees;
-----------------------------------

--13-Tabloya CHECK constraint'i ekleme

--CHECK ile bir alana girilebilecek değerleri sınırlayabiliriz.

/*Senaryo: "person" adinda bir tablo oluşturun.
person tablosu sütunları: 

id INTEGER, name VARCHAR(50), salary REAL, age INTEGER olsun. Salary 5000’den kucuk ve yas negatif girilemesin*/

/*Scenario: Create a table named "person".
person table columns: 

id INTEGER, name VARCHAR(50), salary REAL, age INTEGER. Salary cannot be less than 5000 and age cannot be negative*/


CREATE TABLE person(
id integer,
name varchar(50),
salary real CHECK(salary>5000),--5000 den az kabul etmez.
age integer CHECK(age>0)--negatif kabul etmez 
);

SELECT * FROM person;

INSERT INTO person VALUES(11,'Ali Can',6000,35);

INSERT INTO person VALUES(11,'Ali Can',6000,-3);
-- HATA , yukarıdaki -3 olan person_age_check

INSERT INTO person VALUES(11,'Ali Can',4000,35)
-- HATA maaş 5000 den az olmaz person_salary_check

------------------  tekrar --------------------

/*Senaryo: "worker" ve "address" adlarinda iki tablo oluşturun.

worker tablosu sütunları: 
id CHAR(5), isim VARCHAR(50), maas INT, ise_baslama DATE

address tablosu sütunları:
adres_id CHAR(5), sokak VARCHAR(30), cadde VARCHAR(30), sehir VARCHAR(30)

Tablolari birbirine baglayarak, UNIQUE, NOT NULL uygulamasi yapiniz*/

/*Scenario: Create two tables named "worker" and "address".

worker table columns: 
id CHAR(5), name VARCHAR(50), salary INT, job_start DATE

address table columns:
address_id CHAR(5), street VARCHAR(30), street VARCHAR(30), city VARCHAR(30)

Apply UNIQUE, NOT NULL by linking tables together*/

--NOT: UNIQUE null kabul eder. Birden fazla da kabul eder cunku null bir deger degildir. Karsilastirma yapmaz.

CREATE TABLE worker(
id char(5) PRIMARY KEY, 
isim varchar(50) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE address(
adres_id char(5),
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
FOREIGN KEY(adres_id) REFERENCES worker(id) 
);

SELECT * FROM worker;
SELECT * FROM address;

INSERT INTO worker VALUES('10002', 'Donatello' ,12000, '2018-04-14');--başarılı

INSERT INTO worker VALUES('10003', null, 5000, '2018-04-14');--başarılı

INSERT INTO worker VALUES('10004', 'Donatello', 5000, '2018-04-14');--HATA name unique çünkü

INSERT INTO worker VALUES('10005', 'Michelangelo', 5000, '2018-04-14');--başarılı

INSERT INTO worker VALUES('10006', 'Leonardo', null, '2019-04-12');--HATA maas not null çünkü,

INSERT INTO worker VALUES('10007', 'Raphael', '', '2018-04-14');--HATA maas int bekliyor biz boşluk string gönderdik

INSERT INTO worker VALUES('', 'April', 2000, '2018-04-14');--başarılı char empty(boş) kabul eder

INSERT INTO worker VALUES('', 'Ms.April', 2000, '2018-04-14');--HATA id unique çünkü

INSERT INTO worker VALUES('10002', 'Splinter', 12000, '2018-04-14');--HATA id unique 10002 daha önce gönderilmişti

INSERT INTO worker VALUES(null, 'Fred', 12000, '2018-04-14');--HATA Primary key null kabul etmez

INSERT INTO worker VALUES('10008', 'Barnie', 10000, '2018-04-14');--başarılı

INSERT INTO worker VALUES('10009', 'Wilma', 11000, '2018-04-14');--başarılı

INSERT INTO worker VALUES('10010', 'Betty' ,12000, '2018-04-14');--başarılı

INSERT INTO address VALUES('10003','Ninja Sok', '40.Cad.', 'IST');--başarılı

INSERT INTO address VALUES('10003','Kaya Sok', '50.Cad.', 'Ankara');--başarılı FK dublicate olabilir

INSERT INTO address VALUES('10002','Taş Sok', '30.Cad.', 'Konya');--başarılı

INSERT INTO address VALUES('10012','Taş Sok', '30.Cad.', 'Konya');--HATA PK de 10012 yok

INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya');--başarılı

INSERT INTO address VALUES(NULL,'Taş Sok', '23.Cad.', 'Konya');--başarılı ikinci null da kabul eder

---------------------------------------------------
/*14- WHERE ifadesi, belirli koşulları karşılayan kayıtları seçmek için kullanılır. Bir SELECT, UPDATE ya da DELETE sorgusunda, hangi satırların işleme dahil edileceğini belirtmek için WHERE koşulu eklenir.*/

--worker tablosundan ismi 'Donatello' olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose name is 'Donatello' from the worker table

SELECT * FROM worker;
SELECT * FROM address;

SELECT * FROM worker WHERE isim = 'Donatello';--5 tane daha olsaydı hepsini getirirdi çünkü unique değil
--------------------------------

--worker tablosundan maaşı 5000’den fazla olanların tüm bilgilerini listeleyelim
--Let's list all the information of those whose salary is more than 5000 from the worker table

SELECT * FROM worker WHERE maas>5000;
----------------------------------------------

--worker tablosundan maaşı 5000’den fazla olanların isim ve maaşlarını listeleyelim
--Let's list the names and salaries of those whose salary is more than 5000 from the worker table

SELECT isim , maas FROM worker WHERE maas>5000;
-----------------------------------------------

--address tablosundan sehri 'Konya' ve 
--adres_id'si 10002 olan kaydın tüm verilerini getirelim
--select the city 'Konya' from the address table and 
--Let's get all the data of the record with address_id 10002

SELECT * FROM address WHERE sehir='Konya' AND adres_id='10002';
---------------------------------------------------

--sehri 'Konya' veya 'Bursa' olan adreslerin cadde ve sehir bilgilerini getirelim.
--Let's get the street and city information for addresses whose city is 'Konya' or 'Bursa'.

SELECT cadde,sehir FROM address WHERE sehir='Konya' OR sehir='Bursa';
----------------------------------------------

--15-Tablodan kayıt silme-DELETE FROM ... komutu:DML

/*Senaryo: "students1" adinda bir tablo oluşturun.

students1 tablosu sütunları: 
id INTEGER, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu INTEGER

Tablo uzerinde cesitli silme islemleri yapiniz*/

/*Scenario: Create a table named "students1".

students1 table columns: 
id INTEGER, name VARCHAR(50), parent_name VARCHAR(50), written_note INTEGER

Perform various deletion operations on the table*/

CREATE TABLE students1(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);

INSERT INTO students1 VALUES(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

SELECT * FROM students1;
------------------------
--id=123 olan kaydı silelim.
-- Let's delete the record with id=123.

DELETE FROM students1 WHERE id=123;

-------------------------------------
--ismi Kemal Tan olan kaydı silelim.
-- delete the entry with the name Kemal Tan.

DELETE FROM students1 WHERE isim='Kemal Tan';

------------------------------------------
--ismi Ahmet Ran veya Veli Han olan kayıtları silelim
-- delete records with the name Ahmet Ran or Veli Han

DELETE FROM students1 WHERE isim='Ahmet Ran' OR isim='Veli Han';

----------------------------------------
--15-a-tablodaki tüm kayıtları silme:DELETE FROM: DML,rollback ile geri alınabilir

SELECT * FROM students;

--students tablosundan tüm kayıtları silelim.
-- delete all records from the students table.

DELETE FROM students;

--NOT: DELETE FROM komutu koşulsuz kullanıldığında
--tüm satırları siler ancak tablo kalır.
--tabloyu drop siler.

--satirlari tek tek sildigi icin yavastir. Daha hizlisi var. (TRUNCATE)

------------------------------------------
--16-Tablodaki tüm kayıtları silme:TRUNCATE TABLE:DDL

CREATE TABLE doctors(
id SERIAL,
name VARCHAR(30) NOT NULL,
salary REAL,
email VARCHAR(50) UNIQUE	
);
SELECT * FROM doctors;

INSERT INTO doctors(name,salary,email) VALUES('Dr. Gregory House',6000,'dr@mail.com');--başarılı

INSERT INTO doctors(salary,email) VALUES(6000,'doctor@mail.com');--HATA name not null çünkü

INSERT INTO doctors(name,salary,email) VALUES('',6000,'doc@mail.com');--başarılı

--doctors tablosundan tüm kayıtları silelim.
--Delete all records from the doctors table.

TRUNCATE TABLE doctors;

---------------------------------------------
--17-parent-child ilişkisi olan tablolardan kayıt silme
--Delete records from tables with parent-child relationship

SELECT * FROM worker;
SELECT * FROM address;

--worker tablosundan tüm kayıtları silelim.
-- delete all records from the worker table.

DELETE FROM worker;--HATA
--worker tablosunda address tarafından referans alınan kayıtlar olduğu için silmeye izin yok.

DELETE FROM worker WHERE id='10002';--HATA
--id=10002 olan kayıt adresler tarafından referans alındığı için silmeye izin yok.Once child'dan iliskiyi koparalim.

DELETE FROM address WHERE adres_id='10002';
--referans alınan kayıt silindi,ilişki koparıldı
DELETE FROM worker WHERE id='10002';
--şimdi başarılı
--------------------
DELETE FROM address;--tüm ilişki koparıldı
DELETE FROM worker;--şimdi başarılı
--artık hiçbir kayıt ref alınmadığı için başarılı

---------------------
--18-ON DELETE CASCADE

/*Senaryo: “students2” ve “grades2” adlarinda iki tablo oluşturun.

students2 tablosu sütunları: 
id int, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int

grades2 tablosu sütunları:
talebe_id int, ders_adi varchar(30), yazili_notu int

Tablolari birbirine baglayarak, ON DELETE CASCADE uygulamasi yapiniz*/

/*Scenario: Create two tables named "students2" and "grades2".

students2 table columns: 
id int, name VARCHAR(50), parent_name VARCHAR(50), written_note int

grades2 table columns:
student_id int, course_name varchar(30), written_note int

Apply ON DELETE CASCADE by linking the tables together*/

CREATE TABLE students2(
	id int primary key,  
	isim VARCHAR(50),
	veli_isim VARCHAR(50),
	yazili_notu int
);

CREATE TABLE grades2(

	talebe_id int,
	ders_adi varchar(30),
	yazili_notu int,
	CONSTRAINT notlar_fk FOREIGN KEY(talebe_id) REFERENCES students2(id) ON DELETE CASCADE
	
);

INSERT INTO students2 VALUES
(122, 'Kerem Can', 'Fatma',75),
(123, 'Ali Can', 'Hasan',75),
(124, 'Veli Han', 'Ayse',85),
(125, 'Kemal Tan', 'Hasan',85),
(126, 'Ahmet Ran', 'Ayse',95),
(127, 'Mustafa Bak', 'Can',99),
(128, 'Mustafa Bak', 'Ali', 99),
(129, 'Mehmet Bak', 'Alihan', 89);

INSERT INTO grades2 VALUES 
 ('123','kimya',75),
 ('124', 'fizik',65),
 ('125', 'tarih',90),
 ('126', 'Matematik',90),
 ('127', 'Matematik',90),
 (null, 'tarih',90);

SELECT * FROM students2; --parent
SELECT * FROM grades2; --child

DELETE FROM grades2 WHERE talebe_id=123; --basarili, child'dan direkt silebiliriz
DELETE FROM students2 WHERE id=126; --basarili,ON DELETE CASCADE otomatik olarak önce child olan grades2 tablosundan referans verilen kaydi siler, sonra parent olan students2 den bu kaydi siler

DELETE FROM students2;
DELETE FROM grades2; --null'da silinir

-------------------------------
--19-tabloyu silme

DROP TABLE students2; --HATA, silemezsiniz cunku child'i var

DROP TABLE students2 CASCADE;

SELECT * FROM students2; --parent
SELECT * FROM grades2; --child

---------------
DROP TABLE IF EXISTS student18; --tablo varsa siler yoksa hata vermez notice(uyari) verir, app calismaya devam eder

---------------------
--20-IN Condition
--IN: Bir değerin belirli bir değerler listesi içinde olup olmadığını kontrol eder.

/*Senaryo: “customers” adinda bir tablo oluşturun.

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

--1.yol:






























































































