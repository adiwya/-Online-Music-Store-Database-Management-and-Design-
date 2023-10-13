/*
  Name: Aparajeeta Diwya
  Student No: 130958218
  DBS311 A2 DDL/DML Script for Q2 AND Q3
  Date: 04/11/2023
*/
SET SERVEROUTPUT ON;

--QUESTION 2 - DDL/DML Script to create tables and insert records.
--Customer table
CREATE TABLE customer (
    CustomerId INT PRIMARY KEY,
    FName VARCHAR(20)  NOT NULL,
    LName VARCHAR(20)  NOT NULL,
    PhoneNo VARCHAR(15) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    City    VARCHAR(20)  NOT NULL,
    Province VARCHAR(20) NOT NULL,
    Email VARCHAR(20) UNIQUE
);

--Customer table records
INSERT ALL
INTO customer (CustomerId, FName, LName, PhoneNo, Address, City, Province, Email) VALUES (1001, 'Aparajeeta', 'Diwya', '(647) 573-9720','40 Cal Cres', 'Scarborough','ON','apd.diwya@gmail.com')
INTO customer (CustomerId, FName, LName, PhoneNo, Address, City, Province, Email) VALUES (1002, 'Ranju', 'Shah', '(123) 588-5673','42 Cal Cres', 'Scarborough','ON','ranju.shah@gmail.com')
INTO customer (CustomerId, FName, LName, PhoneNo, Address, City, Province, Email) VALUES (1003, 'Aryan', 'Shah', '(333) 786-0946','81 Jarvis Dr', 'Barrie','ON','aryan.shah@gmail.com')
INTO customer (CustomerId, FName, LName, PhoneNo, Address, City, Province, Email) VALUES (1004, 'Rina', 'Shrestha', '(876) 444-6757','10 Med Dr', 'Montreal','QC','rina.shrestha@gmail.com')
INTO customer (CustomerId, FName, LName, PhoneNo, Address, City, Province, Email) VALUES (1005, 'Riva', 'Shah', '(678) 345-1842','52 Cal Post', 'Scarborough','ON','riva.shah@gmail.com')
SELECT *
    FROM dual;
desc customer;
SELECT *
  FROM customer;
  
--Order table
CREATE TABLE orders (
    orderID INT PRIMARY KEY,
    orderDate DATE,
    orderTotal DECIMAL(10, 2),
    customerID INT,
    FOREIGN KEY (customerID) REFERENCES customer(customerID),
    CONSTRAINT check_orderTotal CHECK (orderTotal >= 0)
);

--Order table records
INSERT ALL
INTO orders (customerID, orderID, orderDate, orderTotal) VALUES (1001, 1, '2023-01-01', 120)
INTO orders (customerID, orderID, orderDate, orderTotal) VALUES (1002, 2, '2023-02-08', 130.80)
INTO orders (customerID, orderID, orderDate, orderTotal) VALUES (1003, 3, '2023-03-23', 125.68)
INTO orders (customerID, orderID, orderDate, orderTotal) VALUES (1004, 4, '2023-04-01', 200.65)
INTO orders (customerID, orderID, orderDate, orderTotal) VALUES (1005, 5, '2023-01-17', 345.55)
SELECT *
    FROM dual;
desc orders;
SELECT *
  FROM orders;

--Payment table
CREATE TABLE PAYMENT (
    paymentID INT PRIMARY KEY,
    orderID INT,
    cardType VARCHAR(4) CHECK (cardType IN ('VISA', 'MAST', 'AMEX')),
    paymentDate DATE,
    FOREIGN KEY (orderID) REFERENCES orders(orderID)
);


--Payment table sample records
INSERT ALL
INTO Payment (paymentID, orderID, cardType, paymentDate) VALUES (10, 1, 'VISA','2023-01-05')
INTO Payment (paymentID, orderID, cardType, paymentDate) VALUES (11, 2, 'MAST','2023-02-12')
INTO Payment (paymentID, orderID, cardType, paymentDate) VALUES (12, 3, 'AMEX','2023-03-24')
INTO Payment (paymentID, orderID, cardType, paymentDate) VALUES (13, 4, 'VISA','2023-04-04')
INTO Payment (paymentID, orderID, cardType, paymentDate) VALUES (14, 5, 'MAST','2023-01-20')
SELECT *
    FROM dual;
desc payment;
SELECT *
  FROM payment;


--Order_Line table
CREATE TABLE order_line (
    orderLineNo INT PRIMARY KEY,
    Qty INT CHECK (Qty >= 0),
    ActPrice DECIMAL(10, 2) CHECK (ActPrice > 0),
    orderID INT,
    FOREIGN KEY (orderID) REFERENCES orders(orderID)
);


--Order_Line table sample records
INSERT INTO order_line (orderID, orderLineNo, Qty, ActPrice) VALUES (1, 100, 3, 29.99);
INSERT INTO order_line (orderID, orderLineNo, Qty, ActPrice) VALUES (2, 101, 4, 13.25);
INSERT INTO order_line (orderID, orderLineNo, Qty, ActPrice) VALUES (3, 102, 1, 34.90);
INSERT INTO order_line (orderID, orderLineNo, Qty, ActPrice) VALUES (4, 103, 3, 25.55);
INSERT INTO order_line (orderID, orderLineNo, Qty, ActPrice) VALUES (5, 104, 5, 23.85);
SELECT *
    FROM dual;
desc order_line;
SELECT * 
    FROM order_line;

ALTER TABLE order_line
ADD FOREIGN KEY (recordingID)
REFERENCES recording(recordingID);


--Record_Hist table
CREATE TABLE record_hist (
    priceID INT NOT NULL PRIMARY KEY,
    price DECIMAL(5, 2) CHECK (price > 0 AND price <= 999.99),
    startDate DATE
);


--Record_Hist table sample records
INSERT ALL 
INTO record_hist (priceID, price, startDate) VALUES (1, 199.99, '2023-01-04')
INTO record_hist (priceID, price, startDate) VALUES (2, 180.85, '2023-02-10')      
INTO record_hist (priceID, price, startDate) VALUES (3, 355.50, '2023-04-02')       
INTO record_hist (priceID, price, startDate) VALUES (4, 990.00, '2023-03-14')      
INTO record_hist (priceID, price, startDate) VALUES (5, 789.99, '2023-02-24')
SELECT *
    FROM dual;
SELECT *
    FROM record_hist;
    
desc record_hist;

ALTER TABLE record_hist
ADD FOREIGN KEY (recordingID)
REFERENCES recording(recordingID);


--Recording table
CREATE TABLE recording (
    recordingID INT PRIMARY KEY,
    title VARCHAR(20),
    performerName VARCHAR(50),
    sell_price DECIMAL(10, 2) NOT NULL,
    qty_stock INT NOT NULL
);


--Recording table sample records
INSERT ALL
INTO recording (recordingID, title, performerName, sell_price, qty_stock) VALUES (1, 'Paper Rings', 'Taylor Swift', 299.99, 20)
INTO recording (recordingID, title, performerName, sell_price, qty_stock) VALUES (2, 'Die For You', 'The Weeknd', 220.99, 23)
INTO recording (recordingID, title, performerName, sell_price, qty_stock) VALUES (3, 'Dusk Till Dawn', 'Zayn Mallik', 350.00, 34)
INTO recording (recordingID, title, performerName, sell_price, qty_stock) VALUES (4, 'Good 4 U', 'Olivia Rodrigo', 190.00, 50)
INTO recording (recordingID, title, performerName, sell_price, qty_stock) VALUES (5, 'Calm Down', 'Selena Gomez', 499.99, 39)
SELECT *
    FROM dual;
desc recording;
SELECT *
    FROM recording;

ALTER TABLE recording
ADD FOREIGN KEY (categoryID)
REFERENCES category(categoryID);

ALTER TABLE recording
ADD FOREIGN KEY (labelID)
REFERENCES label(labelID);


--Category table
CREATE TABLE category (
    categoryId INT PRIMARY KEY,
    categoryDesc VARCHAR(50) NOT NULL CHECK (CategoryDesc IN ('R&B', 'Jazz', 'Metal Rock', 'Alt Rock', 'Easy Rock', 'Classic Rock', 'Hip-Hop'))
);


--Category table sample records
INSERT ALL
INTO category (categoryId, categoryDesc) VALUES (1, 'Metal Rock')
INTO category (categoryId, categoryDesc) VALUES (2, 'Easy Rock')
INTO category (categoryId, categoryDesc) VALUES (3, 'Hip-Hop')
INTO category (categoryId, categoryDesc) VALUES (4, 'Jazz')
INTO category (categoryId, categoryDesc) VALUES (5, 'Alt Rock')
INTO category (categoryId, categoryDesc) VALUES (6, 'Classic Rock')
INTO category (categoryId, categoryDesc) VALUES (7, 'R&B')
SELECT *
    FROM dual;
desc category;
SELECT *
    FROM category;



--Label table
CREATE TABLE label (
    labelID INT PRIMARY KEY,
    labelName VARCHAR(20) NOT NULL,
    urlSite VARCHAR(100) NOT NULL
);

--Label table sample records
INSERT ALL
INTO label (labelID, labelName, urlSite) VALUES (1001, 'Sony', 'sonylabels.ca')
INTO label (labelID, labelName, urlSite) VALUES (1002, 'Virginia', 'virginialables.ca')
INTO label (labelID, labelName, urlSite) VALUES (1003, 'Columbia', 'columbialabels.ca')
INTO label (labelID, labelName, urlSite) VALUES (1004, 'Top Charts', 'topchartslabels.ca')
INTO label (labelID, labelName, urlSite) VALUES (1005, 'Music Masters', 'musicmasterslabels.ca')
INTO label (labelID, labelName, urlSite) VALUES (1006, 'Hit Records', 'hitrecordslabels.ca')
INTO label (labelID, labelName, urlSite) VALUES (1007, 'Songs On The House', 'songsonthehouselabels.ca')
SELECT *
    FROM dual;
desc label;
SELECT *
    FROM label;
    
--Sales_Rep table   
CREATE TABLE sales_rep (
    REPNo INT PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(20) UNIQUE
);

--Sales_Rep table sample records
INSERT ALL
INTO sales_rep (REPNo, FirstName, LastName, PhoneNumber, Email) VALUES (2000, 'Ananya', 'Sharma', '(647) 574-7720','ananya.s@gmail.com')
INTO sales_rep (REPNo, FirstName, LastName, PhoneNumber, Email) VALUES (2001, 'Jack', 'Wright', '(553) 578-8673','jack.w@gmail.com')
INTO sales_rep (REPNo, FirstName, LastName, PhoneNumber, Email) VALUES (2002, 'Alia', 'Menon', '(633) 986-1346','alia.m@yahoo.com')
INTO sales_rep (REPNo, FirstName, LastName, PhoneNumber, Email) VALUES (2003, 'Aanand', 'Shrestha','(806) 484-9797','aanand.s@gmail.com')
INTO sales_rep (REPNo, FirstName, LastName, PhoneNumber, Email) VALUES (2004, 'Rina', 'Bright', '(678) 345-1842','rina.b@gmail.com')
SELECT *
    FROM dual;
desc sales_rep;
SELECT *
  FROM sales_rep;

ALTER TABLE sales_rep
ADD FOREIGN KEY (labelID)
REFERENCES label(labelID);

ALTER TABLE sales_rep
ADD FOREIGN KEY (regionId)
REFERENCES region(regionId);

--Region table
CREATE TABLE region (
    regionId INT PRIMARY KEY,
    regionName VARCHAR(20) NOT NULL
);

--Region table sample records
INSERT ALL
INTO region (regionId, regionName) VALUES (301, 'USA')
INTO region (regionId, regionName) VALUES (302, 'US-North')
INTO region (regionId, regionName) VALUES (303, 'US-EAST')
INTO region (regionId, regionName) VALUES (304, 'CANADA')
INTO region (regionId, regionName) VALUES (305, 'ASIA')
SELECT *
    FROM dual;
desc region;
SELECT *
  FROM region;



--QUESTION 3 - Stored Procedure
CREATE OR REPLACE PROCEDURE Recording_Selling_Price_Report IS
avgPrice RECORDING.sell_price%TYPE;
highVar NUMBER :=0; --highVar for HIGH Recording
lowVar NUMBER :=0; --lowVar for LOW Recording
BEGIN
select COUNT(*) INTO lowVar
from RECORDING  
    WHERE sell_price < ( SELECT AVG(sell_price) 
        FROM RECORDING);

select COUNT(*) INTO highVar
from RECORDING  
    WHERE sell_price >= ( SELECT AVG(sell_price) 
        FROM RECORDING);
DBMS_output.put_line( 'LOW Recording ' || lowVar);
DBMS_output.put_line( 'HIGH Recording '|| highVar);
END;
--This statement is run on a different SQL worksheet for the output of the procedure
/
exec Recording_Selling_Price_Report;
/





