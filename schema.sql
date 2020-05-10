-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/AxW01z
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

DROP TABLE IF EXISTS Transactions CASCADE;
DROP TABLE IF EXISTS Merchant_Details CASCADE;
DROP TABLE IF EXISTS Credit_Cards CASCADE;
DROP TABLE IF EXISTS Merchant_Category CASCADE;
DROP TABLE IF EXISTS Card_Holders CASCADE;


CREATE TABLE Transactions (
    Trans_id int   NOT NULL,
    Date timestamp   NOT NULL,
    Amount float   NOT NULL,
    Credit_Card varchar(20)   NOT NULL,
    Merch_id int   NOT NULL,
    CONSTRAINT pk_Transactions PRIMARY KEY (
        Trans_id
     )
);

CREATE TABLE Merchant_Details (
    Merch_id int   NOT NULL,
    Merch_name varchar(255)   NOT NULL,
    Merch_category_id int   NOT NULL,
    CONSTRAINT pk_Merchant_Details PRIMARY KEY (
        Merch_id
     )
);

CREATE TABLE Credit_Cards ( 
    Credit_Card varchar(20)  PRIMARY KEY NOT NULL
	,Card_Holder_id int   NOT NULL
	)
	;

CREATE TABLE Merchant_Category (
    Merch_category_id int   NOT NULL,
    Merch_category varchar(255)   NOT NULL,
    CONSTRAINT pk_Merchant_Category PRIMARY KEY (
        Merch_category_id
     )
);

CREATE TABLE Card_Holders (
    Card_Holder_id int   NOT NULL,
    Card_Holder_Name varchar(255)   NOT NULL,
    CONSTRAINT pk_Card_Holder PRIMARY KEY (
        Card_Holder_id
     )
);

ALTER TABLE Transactions ADD CONSTRAINT fk_Transactions_Credit_Card FOREIGN KEY(Credit_Card)
REFERENCES Credit_Cards (Credit_Card);

ALTER TABLE Transactions ADD CONSTRAINT fk_Transactions_Merch_id FOREIGN KEY(Merch_id)
REFERENCES Merchant_Details (Merch_id);

ALTER TABLE Merchant_Details ADD CONSTRAINT fk_Merchant_Details_Merch_category_id FOREIGN KEY(Merch_category_id)
REFERENCES Merchant_Category (Merch_category_id);

ALTER TABLE Credit_Cards ADD CONSTRAINT fk_Credit_Cards_Card_Holder_id FOREIGN KEY(Card_Holder_id)
REFERENCES Card_Holders (Card_Holder_id);


