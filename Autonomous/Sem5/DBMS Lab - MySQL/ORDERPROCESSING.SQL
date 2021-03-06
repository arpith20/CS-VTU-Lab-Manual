CREATE SCHEMA ORDER_PROCESSING;

USE ORDER_PROCESSING;

CREATE TABLE CUSTOMER
(
CNO INT PRIMARY KEY,
CNAME VARCHAR(10) NOT NULL,
CITY VARCHAR(15) NOT NULL
);

CREATE TABLE ORDER1
(
ONO INT PRIMARY KEY,
ODATE DATE NOT NULL,
CNO INT NOT NULL,
OAMT INT NOT NULL,
FOREIGN KEY(CNO) REFERENCES CUSTOMER(CNO) ON DELETE CASCADE
);

CREATE TABLE ITEM
(
INO INT PRIMARY KEY,
UPRICE INT NOT NULL
);

CREATE TABLE OITEM
(
ONO INT,
INO INT,
QTY INT CHECK(QTY>0),
PRIMARY KEY(ONO,INO),
FOREIGN KEY(ONO) REFERENCES ORDER1(ONO) ON DELETE CASCADE,
FOREIGN KEY(INO) REFERENCES ITEM(INO) ON DELETE SET NULL
);

CREATE TABLE WAREHOUSE
(
WNO INT PRIMARY KEY,
CITY VARCHAR(15) NOT NULL
);

CREATE TABLE SHIPMENT
(
ONO INT,
WNO INT,
SDATE DATE NOT NULL,
FOREIGN KEY(ONO) REFERENCES ORDER1(ONO) ON DELETE CASCADE,
FOREIGN KEY(WNO) REFERENCES WAREHOUSE(WNO) ON DELETE CASCADE
);

-- CUSTOMER
INSERT INTO CUSTOMER VALUES(1,'ABC','BANGALORE');
INSERT INTO CUSTOMER VALUES(2,'CDE','MYSORE');
INSERT INTO CUSTOMER VALUES(3,'DEF','CHENNAI');
INSERT INTO CUSTOMER VALUES(4,'EFG','MUMBAI');
INSERT INTO CUSTOMER VALUES(5,'ADF','KOLKATA');

-- ORDER1
INSERT INTO ORDER1 VALUES(1,'2006-01-01',1,20000); 
INSERT INTO ORDER1 VALUES(2,'2006-03-26',2,10000); 
INSERT INTO ORDER1 VALUES(3,'2006-06-12',1,5000); 
INSERT INTO ORDER1 VALUES(4,'2006-09-15',3,9000); 
INSERT INTO ORDER1 VALUES(5,'2007-01-05',4,2500); 
INSERT INTO ORDER1 VALUES(6,'2007-01-10',4,2400); 
INSERT INTO ORDER1 VALUES(7,'2007-03-03',5,3500);

-- ITEM
INSERT INTO ITEM VALUES(1,500);
INSERT INTO ITEM VALUES(2,300);
INSERT INTO ITEM VALUES(3,2500);
INSERT INTO ITEM VALUES(4,800);
INSERT INTO ITEM VALUES(5,700);

-- OITEM
INSERT INTO OITEM VALUES(1,1,40);
INSERT INTO OITEM VALUES(2,1,20);
INSERT INTO OITEM VALUES(3,3,2);
INSERT INTO OITEM VALUES(5,3,1);
INSERT INTO OITEM VALUES(4,2,30);
INSERT INTO OITEM VALUES(6,4,3);
INSERT INTO OITEM VALUES(7,5,5);

-- WAREHOUSE
INSERT INTO WAREHOUSE VALUES(100,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(101,'CHENNAI');
INSERT INTO WAREHOUSE VALUES(102,'MUMBAI');
INSERT INTO WAREHOUSE VALUES(103,'KOLKATA');
INSERT INTO WAREHOUSE VALUES(104,'MYSORE');
INSERT INTO WAREHOUSE VALUES(105,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(106,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(107,'BANGALORE');
INSERT INTO WAREHOUSE VALUES(108,'BANGALORE');

-- SHIPMENT
INSERT INTO SHIPMENT VALUES(1,100,'2006-01-03');
INSERT INTO SHIPMENT VALUES(2,100,'2006-03-28');
INSERT INTO SHIPMENT VALUES(2,105,'2006-03-27');
INSERT INTO SHIPMENT VALUES(2,106,'2004-06-20');
INSERT INTO SHIPMENT VALUES(2,107,'2007-01-21');
INSERT INTO SHIPMENT VALUES(2,108,'2006-02-13');
INSERT INTO SHIPMENT VALUES(3,101,'2006-06-15');
INSERT INTO SHIPMENT VALUES(4,102,'2006-09-18');
INSERT INTO SHIPMENT VALUES(5,103,'2007-01-11');
INSERT INTO SHIPMENT VALUES(6,107,'2007-01-13');
INSERT INTO SHIPMENT VALUES(7,103,'2007-03-03');

SELECT C.CNAME AS CUSTNAME, COUNT(O.ONO) AS NUM_OF_ORDERS, AVG(O.OAMT) AS AVG_ORDER_AMT
	FROM CUSTOMER C,ORDER1 O
	WHERE C.CNO=O.CNO
	GROUP BY C.CNO;

SELECT DISTINCT S.ONO FROM SHIPMENT S WHERE S.WNO IN (SELECT W.WNO FROM WAREHOUSE W WHERE W.CITY='BANGALORE');

SELECT * FROM ITEM;
SELECT * FROM OITEM;
DELETE FROM ITEM WHERE INO=5;
SELECT * FROM OITEM;
SELECT * FROM ITEM;
