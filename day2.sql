------------------------Day 2------------------------

--Veritabanında bir tablo oluşturduğunuzda, bu tablodaki bilgilerin doğru ve istediğin şekilde olmasını sağlamak için bazı kurallar koyarsınız. İşte bu kurallara "constraint" diyoruz.

/*Senaryo: "actors" adında bir tablo oluşturun ve şu sütunları ekleyin:

id INTEGER
name VARCHAR(30) 
email VARCHAR(50) 

Scenario: Create a table called "actors" and add the following columns:

id INTEGER
name VARCHAR(30) 
email VARCHAR(50) 
*/

/*1- CREATE TABLE IF NOT EXISTS, tablonun var olup olmadığını kontrol eder. Eğer tablo zaten mevcutsa, CREATE TABLE komutu hiçbir şey yapmaz. Yani, PostgreSQL herhangi bir hata vermeden ve tabloyu yeniden oluşturmadan komutu yoksayar.
Eğer tablo yoksa, yeni bir tablo oluşturur.*/

CREATE TABLE IF NOT EXISTS actors( --1

	id INTEGER,
	name VARCHAR(30),
	email VARCHAR(50)
	
);

SELECT * FROM actors;

INSERT INTO actors VALUES(1001, 'Kemal Sunal', 'aktor@gmail.com');
INSERT INTO actors VALUES(1002, 'Sener Sen', 'aktor@gmail.com'); --2-Mail unique degil, unique olmaliydi

--INSERT INTO actors VALUES (1001, 'Kemal Sunal', 'aktor@gmail.com'), (1002, 'Sener Sen','aktor@gmail.com'); seklinde de girebilirdik

INSERT INTO actors(name) VALUES('Turkan Soray'); --3-Tek bir field'e deger girdik. Digerleri null olacak
SELECT * FROM actors;
----------------------------
--9-Tabloya UNIQUE constraint'i ekleme
--Bir sütuna tekrarlı verilerin eklenememesi için tablo ve sütunları tanımlanırken UNIQUE kısıtlaması eklenir.

/*Senaryo: "programmers" adında bir tablo oluşturun ve şu sütunları ekleyin:

id SERIAL
name VARCHAR(30) 
email VARCHAR(50)
salary REAL
prog_lang VARCHAR(20)  
ve email'i unique yapin*/

/*Scenario: Create a table named "programmers" and add the following columns:

id SERIAL
name VARCHAR(30) 
email VARCHAR(50)
salary REAL
prog_lang VARCHAR(20)  
and make the email unique*/

CREATE TABLE programmers(
	id SERIAL,
	name VARCHAR(30),
	email VARCHAR(50),
	salary REAL,
	prog_lang VARCHAR(20)
);

SELECT * FROM programmers;

INSERT INTO programmers(name, email, salary, prog_lang) VALUES('Tom', 'mail@gmail.com', 5000, 'Java');

INSERT INTO programmers(name, email, salary, prog_lang) VALUES('Jerry', 'mail@gmail.com', 4000, 'SQL'); --HATA, email unique olmaliydi
INSERT INTO programmers(name, email, salary, prog_lang) VALUES('Jerry', 'jerry@gmail.com', 4000, 'SQL'); 

------------------------------------------------------
--10-Tabloya NOT NULL constraint'i ekleme
--Bir sütuna NULL değerlerin  eklenememesi için tablo ve sütunları tanımlanırken NOT NULL kısıtlaması eklenir.

INSERT INTO programmers(email, salary, prog_lang) VALUES('python1@gmail.com', 4000, 'Python');

CREATE TABLE programmers1(
	id SERIAL,
	name VARCHAR(30) NOT NULL,
	email VARCHAR(50) UNIQUE,
	salary REAL,
	prog_lang VARCHAR(20)
);
SELECT * FROM programmers1;

INSERT INTO programmers1(name, email, salary, prog_lang) VALUES('Tom', 'mail@gmail.com', 5000, 'Java');
INSERT INTO programmers1(name, email, salary, prog_lang) VALUES('Jerry', 'jerry@gmail.com', 4000, 'SQL');
INSERT INTO programmers1(email, salary, prog_lang) VALUES('python1@gmail.com', 4000, 'Python'); --HATA, name sutunu null olamaz
SELECT * FROM programmers1;

----------------------------------------
--11-Tabloya PK constraint'i ekleme
--1.yol: PK secilecek sutunun yanina ekleme

/*Senaryo: "actors1" adında bir tablo oluşturun ve şu sütunları ekleyin:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Not: Id'yi primary key olarak belirleyin*/

/*Scenario: Create a table called "actors1" and add the following columns:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Note: Set Id as primary key*/

CREATE TABLE actors1(
id integer PRIMARY KEY,--not null,unique
name varchar(30),
surname varchar(30),
film varchar(50)
);

SELECT * FROM actors1;

--2.yol: Ayri bir sutun gibi ekleme

/*Senaryo: "actors2" adında bir tablo oluşturun ve şu sütunları ekleyin:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Not: Id'yi primary key olarak belirleyin*/

/*Scenario: Create a table called "actors2" and add the following columns:
id INTEGER
name VARCHAR(30) 
surname VARCHAR(30)
film VARCHAR(50)
Note: Set Id as primary key*/

CREATE TABLE actors2(
id integer,
name varchar(30),
surname varchar(30),
film varchar(50),
CONSTRAINT act_pk PRIMARY KEY(id)--CONSTRAINT zorunlu degil, custom isim vermek icin kullanilir
);

SELECT * FROM actors2;

----------------------------------------------------
--composite key

CREATE TABLE company(
	job_id INTEGER,
	name VARCHAR(30),
	company VARCHAR(30),
	CONSTRAINT com_pk PRIMARY KEY(job_id,name)
);

SELECT * FROM	company;
















































