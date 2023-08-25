CREATE DATABASE MoonBankDB2;
CREATE TABLE UserAccount(
	UserID		    int		    NOT NULL	UNIQUE	AUTO_INCREMENT, -- (((Primary Key)))
	LastName	    CHAR(255)	NOT NULL,
	FirstName 	    CHAR(255)	NOT NULL,
	DoB		        date		NOT NULL,
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
	CreditScore		int,
    AccountNumber	int			NOT NULL UNIQUE,
    SortCode		int			NOT NULL,
    Balance			float, 
    InterestRate 	float,
    InterestLimit	float,
    Overdraft		BOOLEAN,
    OverdraftLimit 	float,
    DateStarted 	DATE,   
    ParentID		int,
    UserID2		int,
    AccountType		int,
    -- Account Types: 	0: StandardCurrentAccount
	-- .				1: BasicCurrentAccount
    -- .				2: PackagedCurrentAccount
    -- .				3: JointCurrentAccount
    -- .				4: StudentBankAccount
    -- .				5: GraduateBankAccount
    -- .				6: CreditAccount
    -- .				7: RegularSavingsAccount
    -- .				8: CashISAAccount
    -- .				9: Childrens16PlusAccount
    -- .				10: ChildrensMinus16Account
    
    -- . 				Needed Columns
    -- . 				0: AccountNumber, SortCode, Balance, InterestRate, Overdraft, OverdraftLimit
    -- . 				1: AccountNumber, SortCode, Balance, InterestRate
    -- . 				2: AccountNumber, SortCode, Balance, InterestRate, Overdraft, OverdraftLimit
    -- . 				3: AccountNumber, SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, UserID2
    -- . 				4: AccountNumber, SortCode, Balance, InterestRate, Overdraft, OverdraftLimit
    -- . 				5: AccountNumber, SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, DateStarted
    -- . 				6: AccountNumber, SortCode, Balance, InterestRate, Overdraft, OverdraftLimit
    -- . 				7: AccountNumber, SortCode, Balance, InterestRate, InterestLimit
    -- . 				8: AccountNumber, SortCode, Balance, InterestRate, InterestLimit
    -- . 				9: AccountNumber, SortCode, Balance, InterestRate
    -- . 				10: AccountNumber, SortCode, Balance, InterestRate, ParentID
    
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (UserID) REFERENCES UserAccount(UserID),
    FOREIGN KEY (ParentID) REFERENCES UserAccount(UserID)
	
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
        
INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, UserID, CreditScore)
VALUES(411102059, 501010, 1050, 1.0, 1, 500, 1, 750),
		(421102059, 501010, 1050, 1.0, 1, 500, 9, 540),
        (431102059, 501010, 1050, 1.0, 1, 500, 10, 632),
        (441102059, 501010, 1050, 1.0, 1, 500, 12, 412);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, UserID, CreditScore)
VALUES(201102059, 501010, 1050, 1.0, 3, 800);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, UserId, CreditScore)
VALUES(301102059, 501010, 1050, 1.0, 1, 500, 4, 440);



INSERT INTO BankAccount(UserID2, AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, UserID, CreditScore)
VALUES(2, 401102059, 501010, 1050, 1.0, 1, 500, 1, 750);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, UserID, CreditScore)
VALUES(501102059, 501010, 30054, 1.0, 1, 500, 5, 537);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, DateStarted, UserID, CreditScore)
VALUES(601102059, 501010, 6052, 1.0, 1, 500, "2022-10-01", 6, 673);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, Overdraft, OverdraftLimit, UserID, CreditScore)
VALUES(701102059, 501010, 550, 1.0, 1, 500, 7, 721);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, InterestLimit, UserID, CreditScore)
VALUES(801102059, 501010, 1050, 1.0, 1000, 1, 750);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, InterestLimit, UserID, CreditScore)
VALUES(901102059, 501010, 1050, 1.0, 1000, 8, 702);

INSERT INTO BankAccount(AccountNumber, 
SortCode, Balance, InterestRate, UserID, CreditScore)
VALUES(911102059, 501010, 1050, 1.0, 13, 500);

INSERT INTO BankAccount(ParentID, AccountNumber, 
SortCode, Balance, InterestRate, UserID, CreditScore)
VALUES(4, 921102059, 501010, 1050, 1.0, 11, 733);
