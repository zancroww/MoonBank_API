CREATE DATABASE MoonBankDB;
USE MoonBankDB;
CREATE TABLE UserAccount(
    UserID		    CHAR(255)   NOT NULL UNIQUE, -- (((Primary Key)))
	LastName	    CHAR(255)	NOT NULL,
	FirstName 	    CHAR(255)	NOT NULL,
	DoB		        date		NOT NULL,
	Email		    CHAR(255)	NOT NULL    UNIQUE,
	PhoneNumber	    CHAR(255)	NOT NULL,
	NINumber	    CHAR(255),       
	FirstLine 	    CHAR(255)   NOT NULL,
	Postcode 	    CHAR(255)   NOT NULL,
	Password	    CHAR(255)   NOT NULL,
    Salt			CHAR(255)	NOT NULL,
    
    PRIMARY KEY (UserID)
);

CREATE TABLE BankAccount(
	UserID			CHAR(255), 	    -- (((Foreign Key)))
	CreditScore		int,
    AccountNumber	int			NOT NULL UNIQUE,
    SortCode		int			NOT NULL,
    Balance			float, 
    InterestRate 	float,
    InterestLimit	float,
    Overdraft		BOOLEAN,
    OverdraftLimit 	float,
    DateStarted 	DATE,   
    UserID2		    CHAR(255),
    AccountType		CHAR(255),
    -- Account Types: 			0: StandardCurrentAccount
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
    -- .				All: AccountNumber, SortCode, Balance, InterestRate, AccountType, CreditScore
    -- . 				0: Overdraft, OverdraftLimit
    -- . 				1: 
    -- . 				2: Overdraft, OverdraftLimit
    -- . 				3: Overdraft, OverdraftLimit, UserID2
    -- . 				4: Overdraft, OverdraftLimit
    -- . 				5: Overdraft, OverdraftLimit, DateStarted
    -- . 				6: Overdraft, OverdraftLimit
    -- . 				7: InterestLimit
    -- . 				8: InterestLimit
    -- . 				9: 
    -- . 				10: UserID2

    CHECK (AccountType = "StandardCurrentAccount" OR AccountType="BasicCurrentAccount" OR AccountType="PackagedCurrentAccount"
    OR AccountType="JointCurrentAccount" OR AccountType="StudentBankAccount" OR AccountType="GraduateBankAccount" OR AccountType="CreditAccount"
    OR AccountType="RegularSavingsAccount" OR AccountType="CashISAAccount" OR AccountType="Childrens16PlusAccount" OR AccountType="ChildrensMinus16Account"),
    PRIMARY KEY (AccountNumber),
    FOREIGN KEY (UserID) REFERENCES UserAccount(UserID),	
);