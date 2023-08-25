CREATE DATABASE MoonBankDB2;
CREATE TABLE UserAccount(
	UserID		    int		    NOT NULL    UNIQUE  AUTO_INCREMENT, -- Used for keeping count
	LastName	    CHAR(255)	NOT NULL,
	FirstName 	    CHAR(255)	NOT NULL,
	DoB		        date		NOT NULL,
	Email		    CHAR(255)	NOT NULL    UNIQUE,
	PhoneNumber	    CHAR(255)	NOT NULL    UNIQUE,
	NINumber	    CHAR(255)	NOT NULL,       -- (((Primary Key)))
	FirstLine 	    CHAR(255)   NOT NULL,
	Postcode 	    CHAR(255)   NOT NULL,
	Password	    CHAR(255)   NOT NULL,
    
    PRIMARY KEY (NINumber)
	
	
);

CREATE TABLE BankAccount(
	NINumber		CHAR(255)   NOT NULL, 	    -- (((Foreign Key)))
	AccountID		int     NOT NULL	UNIQUE		AUTO_INCREMENT,       -- (((Primary Key)))
	CreditScore		int,
    PRIMARY KEY (AccountID),
    FOREIGN KEY (NINumber) REFERENCES UserAccount(NINumber)
	
);

CREATE TABLE StandardCurrentAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    Overdraft		BOOLEAN		NOT NULL,
    OverdraftLimit 	float,
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE BasicCurrentAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID)
    
    
);

CREATE TABLE PackagedCurrentAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    Overdraft		BOOLEAN		NOT NULL,
    OverdraftLimit 	float,
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE JointCurrentAccount(
	AccountID1		int,
    AccountID2		int,
	AccountNumber	int		NOT NULL	UNIQUE,
	SortCode		int 	NOT NULL,
	Balance			float		NOT NULL, 
	InterestRate 	float		NOT NULL,
	Overdraft		BOOLEAN		NOT NULL,
	OverdraftLimit 	float,
     
	PRIMARY KEY (AccountNumber),
	FOREIGN KEY (AccountID1) REFERENCES BankAccount(AccountID),
    FOREIGN KEY (AccountID2) REFERENCES BankAccount(AccountID),
	CHECK (OverdraftLimit>=0)
     
     
);
    
CREATE TABLE StudentBankAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    Overdraft		BOOLEAN		NOT NULL,
    OverdraftLimit 	float,
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE GraduateBankAccount (
    AccountID int,
    AccountNumber int NOT NULL,
    SortCode int NOT NULL,
    Balance FLOAT NOT NULL,
    InterestRate FLOAT NOT NULL,
    Overdraft BOOLEAN NOT NULL,
    OverdraftLimit FLOAT,
    DateStarted DATE,
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID)
        REFERENCES BankAccount (AccountID),
    CHECK (OverdraftLimit >= 0)
);

CREATE TABLE CreditAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    Overdraft		BOOLEAN		NOT NULL,
    OverdraftLimit 	float,
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE RegularSavingsAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    InterestLimit	float		NOT NULL,
    CurrentAccount	BOOLEAN,
    
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
	CHECK (InterestLimit>=0)
    
);

CREATE TABLE CashISAAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    InterestLimit	float		NOT NULL,
    CurrentAccount  BOOLEAN,
    
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
	CHECK (InterestLimit>=0)
    
);

CREATE TABLE Childrens16PlusAccount(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID)
	
    
);

CREATE TABLE ChildrensMinus16Account(
	AccountID		int,
    AccountNumber	int		NOT NULL,
    SortCode		int		NOT NULL,
    Balance			float		NOT NULL, 
    InterestRate 	float		NOT NULL,
    
    
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID)
	
    
);


    

-- maybe create some indexes for faster retrieval
-- maybe some views, but not necessary

-- DEMO ACCOUNT
INSERT INTO UserAccount (LastName, FirstName, DoB, Email, PhoneNumber, NINumber, 
FirstLine, Postcode, Password)
VALUES ("Account", "Demo", "2000-01-01", "DemoAccount@demomail.com", "01100011011", 
"AA000000A", "10 Downing Street", "AA0 0AA", "Oranges"),
		("Smith", "Roger", "2000-01-01", "RogerSmith@demomail.com", "01100011012", 
"CC000000A", "3 Red Street", "BB0 0AA", "Apple1"),
		("Deer", "Gary", "1992-10-01", "GaryDeer@demomail.com", "02200011011", 
"DD000000A", "5 Blue Street", "CC0 0AA", "Grapes1"),
		("Khan", "Tom", "1972-03-25", "TomKhan@demomail.com", "01300011011", 
"EE000000A", "1 Gray Street", "DD0 0AA", "KiwiKiwi2"),
		("Brick", "David", "1982-04-11", "DavidBrick@demomail.com", "01400011011", 
"FF000000A", "7 Black Street", "EE0 0AA", "Strawberry3"),
		("Smith", "Evan", "1990-05-17", "EvanSmith@demomail.com", "01600011011", 
"GG000000A", "2 Green Street", "FF0 0AA", "PlumPlum1"),
		("Fields", "Lucas", "1999-10-18", "LucasFields@demomail.com", "01800011011", 
"HH000000A", "19 Purple Street", "GG0 0AA", "Satsuma1"),
		("Hill", "Alex", "1983-12-27", "AlexHill@demomail.com", "01900011011", 
"JJ000000A", "24 Yellow Street", "HH0 0AA", "Tangerine1"),
		("Bolt", "Yahan", "1989-11-03", "YahanBolt@demomail.com", "01120011011", 
"II000000A", "2 Sunny Street", "JJ0 0AA", "Blueberry1"),
		("Grass", "Nigel", "1999-10-13", "NigelGrass@demomail.com", "0113011011", 
"KK000000A", "11 Rainy Street", "KL0 0AA", "Blackberry1"),
		("Plant", "Steven", "2010-08-20", "StevenPlant@demomail.com", "01940011011", 
"JK000000A", "4 Nettle Street", "LK0 0AA", "BerryBerry1"),
		("gddhdh", "Alex", "1983-12-27", "AlexHill@demomail.com", "01900011011", 
"JJ000000A", "24 Yellow Street", "HH0 0AA", "Tangerine1"),
		("User", "Test", "2001-01-01", "TestUser@demomail.com", "011000110787", 
"BB000000A", "10 Downing Street", "AA0 0AA", "Banana2");

INSERT INTO BankAccount (NINumber, CreditScore)
VALUES ("AA000000A", 750),
		("BB000000A", 740),
        ("CC000000A", 800),
        ("DD000000A", 440),
        ("EE000000A", 537),
        ("FF000000A", 673),
        ("GG000000A", 721),
        ("HH000000A", 702),
        ("JJ000000A", 540);
        
        
INSERT INTO StandardCurrentAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(101102059, 501010, 1050, 1.0, 1, 500);

INSERT INTO BasicCurrentAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(201102059, 501010, 1050, 1.0, 1, 500);

INSERT INTO PackagedCurrentAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(301102059, 501010, 1050, 1.0, 1, 500);



INSERT INTO JointCurrentAccount(AccountID1, AccountID2, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(1, 2, 401102059, 501010, 1050, 1.0, 1, 500);

INSERT INTO StudentBankAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(501102059, 501010, 1050, 1.0, 1, 500);

INSERT INTO GraduateBankAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, DateStarted)
VALUES(601102059, 501010, 1050, 1.0, 1, 500, 2022-10-01);

INSERT INTO CreditAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(701102059, 501010, 1050, 1.0, 1, 500);

--  ADD ACC ID TO ALL INSERT INTOS



-- INSERT INTO BankAccount (AccountNumber, SortCode, Balance, Overdraft, OverdraftLimit, InterestRate, 
-- InterestLimit, JointOwner)
-- VALUES (10110111, 101010, 100000, 1, 2000, 
-- 0.5, 1000, 0);

-- Remove User Account
-- DELETE FROM UserAccount WHERE NINumber="etc";

