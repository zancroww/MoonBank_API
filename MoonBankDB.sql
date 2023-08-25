CREATE DATABASE MoonBankDB2;
CREATE TABLE UserAccount(
	UserID		    int		NOT NULL	UNIQUE	AUTO_INCREMENT, -- (((Primary Key)))
	LastName	    CHAR(255)	NOT NULL,
	FirstName 	    CHAR(255)	NOT NULL,
	DoB		    date	NOT NULL,
	Email		    CHAR(255)	NOT NULL    UNIQUE,
	PhoneNumber	    CHAR(255)	NOT NULL    UNIQUE,
	NINumber	    CHAR(255)	NOT NULL,       
	FirstLine 	    CHAR(255)   NOT NULL,
	Postcode 	    CHAR(255)   NOT NULL,
	Password	    CHAR(255)   NOT NULL,
    
    	PRIMARY KEY (UserID)
	
	
);

CREATE TABLE BankAccount(
	UserID			int, 	    -- (((Foreign Key)))
	AccountID		int     NOT NULL	UNIQUE		AUTO_INCREMENT,       -- (((Primary Key)))
	CreditScore		int,
    	PRIMARY KEY (AccountID),
    	FOREIGN KEY (UserID) REFERENCES UserAccount(UserID)
	
);

CREATE TABLE StandardCurrentAccount(
	AccountID		int		NOT NULL,
    	AccountNumber		int		NOT NULL UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    	Overdraft		BOOLEAN		NOT NULL,
    	OverdraftLimit 		float,
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    	CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE BasicCurrentAccount(
	AccountID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID)
    
    
);

CREATE TABLE PackagedCurrentAccount(
	AccountID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    	Overdraft		BOOLEAN		NOT NULL,
    	OverdraftLimit 		float,
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    	CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE JointCurrentAccount(
	AccountID1		int,
    	AccountID2		int,
	AccountNumber		int		NOT NULL	UNIQUE,
	SortCode		int 		NOT NULL,
	Balance			float		NOT NULL, 
	InterestRate 		float		NOT NULL,
	Overdraft		BOOLEAN		NOT NULL,
	OverdraftLimit 		float,
     
	PRIMARY KEY (AccountNumber),
	FOREIGN KEY (AccountID1) REFERENCES BankAccount(AccountID),
	FOREIGN KEY (AccountID2) REFERENCES BankAccount(AccountID),
	CHECK (OverdraftLimit>=0)
     
     
);
    
CREATE TABLE StudentBankAccount(
	AccountID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    	Overdraft		BOOLEAN		NOT NULL,
    	OverdraftLimit 		float,
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    	CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE GraduateBankAccount (
    	AccountID 		int,
    	AccountNumber 		int 	NOT NULL	UNIQUE,
    	SortCode 		int 	NOT NULL,
    	Balance 		FLOAT 	NOT NULL,
    	InterestRate 		FLOAT 	NOT NULL,
    	Overdraft 		BOOLEAN NOT NULL,
    	OverdraftLimit 		FLOAT,
    	DateStarted 		DATE,   
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID)
        REFERENCES BankAccount (AccountID),
    	CHECK (OverdraftLimit >= 0)
);

CREATE TABLE CreditAccount(
	AccountID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    	Overdraft		BOOLEAN		NOT NULL,
    	OverdraftLimit 		float,
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    	CHECK (OverdraftLimit>=0)
    
    
);

CREATE TABLE RegularSavingsAccount(
	AccountID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    	InterestLimit		float		NOT NULL,
    
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
	CHECK (InterestLimit>=0)
    
);

CREATE TABLE CashISAAccount(
	AccountID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    	InterestLimit		float		NOT NULL,
    
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
	CHECK (InterestLimit>=0)
    
);

CREATE TABLE Childrens16PlusAccount(
	AccountID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID)
	
    
);

CREATE TABLE ChildrensMinus16Account(
	AccountID		int,
    	ParentID		int,
    	AccountNumber		int		NOT NULL	UNIQUE,
    	SortCode		int		NOT NULL,
    	Balance			float		NOT NULL, 
    	InterestRate 		float		NOT NULL,
    
    
    
    
    	PRIMARY KEY (AccountNumber),
    	FOREIGN KEY (AccountID) REFERENCES BankAccount(AccountID),
    	FOREIGN KEY (ParentID) REFERENCES BankAccount(AccountID)
	
    
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
		("Koolaid", "Barry", "1995-09-23", "BarryKoolaid@demomail.com", "01930011011", 
"PP000000A", "5 Leaf Street", "HP0 0AA", "Dragonfruit1"),
		("User", "Test", "2006-01-01", "TestUser@demomail.com", "011000110787", 
"BB000000A", "10 Downing Street", "AA0 0AA", "Banana2");

INSERT INTO BankAccount (UserID, CreditScore)
VALUES ("1", 750),
	("2", 740),
        ("3", 800),
        ("4", 440),
        ("5", 537),
        ("6", 673),
        ("7", 721),
        ("8", 702),
        ("9", 540),
        ("10", 632),
        ("11", 733),
        ("12", 412),
        ("13", 500);
        
        
INSERT INTO StandardCurrentAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(1, 411102059, 501010, 1050, 1.0, 1, 500),
	(9, 421102059, 501010, 1050, 1.0, 1, 500),
        (10, 431102059, 501010, 1050, 1.0, 1, 500),
        (12, 441102059, 501010, 1050, 1.0, 1, 500);

INSERT INTO BasicCurrentAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate)
VALUES(3, 201102059, 501010, 1050, 1.0);

INSERT INTO PackagedCurrentAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(4, 301102059, 501010, 1050, 1.0, 1, 500);



INSERT INTO JointCurrentAccount(AccountID1, AccountID2, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(1, 2, 401102059, 501010, 1050, 1.0, 1, 500);

INSERT INTO StudentBankAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(5,501102059, 501010, 30054, 1.0, 1, 500);

INSERT INTO GraduateBankAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, DateStarted)
VALUES(6, 601102059, 501010, 6052, 1.0, 1, 500, "2022-10-01");

INSERT INTO CreditAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit)
VALUES(7, 701102059, 501010, 550, 1.0, 1, 500);

INSERT INTO RegularSavingsAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate, InterestLimit )
VALUES(1, 801102059, 501010, 1050, 1.0, 1000);

INSERT INTO CashISAAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate, InterestLimit )
VALUES(8, 901102059, 501010, 1050, 1.0, 1000);

INSERT INTO Childrens16PlusAccount(AccountID, AccountNumber, 
SortCode, Balance, InterestRate)
VALUES(13, 911102059, 501010, 1050, 1.0);

INSERT INTO ChildrensMinus16Account(AccountID, ParentID, AccountNumber, 
SortCode, Balance, InterestRate)
VALUES(11, 4, 921102059, 501010, 1050, 1.0);











--  ADD ACC ID TO ALL INSERT INTOS



-- INSERT INTO BankAccount (AccountNumber, SortCode, Balance, Overdraft, OverdraftLimit, InterestRate, 
-- InterestLimit, JointOwner)
-- VALUES (10110111, 101010, 100000, 1, 2000, 
-- 0.5, 1000, 0);

-- Remove User Account
-- DELETE FROM UserAccount WHERE NINumber="etc";
