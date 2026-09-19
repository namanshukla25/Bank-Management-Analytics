-- ============================================================
-- BANK MANAGEMENT & CUSTOMER ANALYTICS
-- 02 - Create Tables
-- ============================================================

USE BankManagementSystem;

-- Branches
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100),
    City VARCHAR(50),
    IFSCCode VARCHAR(20) UNIQUE
);

-- Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(150),
    City VARCHAR(50),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- Accounts
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountNumber VARCHAR(20) UNIQUE,
    AccountType VARCHAR(20),
    Balance DECIMAL(15,2),
    OpeningDate DATE,
    BranchID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

-- Transactions
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(20),
    Amount DECIMAL(15,2),
    TransactionDate DATE,
    Description VARCHAR(150),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Loans
CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanType VARCHAR(30),
    LoanAmount DECIMAL(15,2),
    InterestRate DECIMAL(5,2),
    LoanDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Position VARCHAR(50),
    Salary DECIMAL(12,2),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);
