-- ============================================================
-- BANK MANAGEMENT & CUSTOMER ANALYTICS
-- 04 - Basic Analysis
-- ============================================================

USE BankManagementSystem;

-- Database overview
SHOW TABLES;

-- Customer count
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

-- Customers by city
SELECT City, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC;

-- Account balance KPIs
SELECT SUM(Balance) AS TotalBalance
FROM Accounts;

SELECT ROUND(AVG(Balance), 2) AS AverageBalance
FROM Accounts;

SELECT MAX(Balance) AS HighestBalance
FROM Accounts;

SELECT MIN(Balance) AS LowestBalance
FROM Accounts;

-- Account type analysis
SELECT
    AccountType,
    COUNT(*) AS TotalAccounts,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
ORDER BY TotalBalance DESC;

-- Highest balance account
SELECT *
FROM Accounts
WHERE Balance = (SELECT MAX(Balance) FROM Accounts);

-- Transaction analysis
SELECT
    TransactionType,
    COUNT(*) AS TransactionCount,
    SUM(Amount) AS TotalAmount
FROM Transactions
GROUP BY TransactionType;

-- Monthly transaction trend
SELECT
    MONTH(TransactionDate) AS MonthNumber,
    MONTHNAME(TransactionDate) AS MonthName,
    SUM(Amount) AS TotalTransactionAmount
FROM Transactions
GROUP BY MONTH(TransactionDate), MONTHNAME(TransactionDate)
ORDER BY MonthNumber;

-- Loan status analysis
SELECT
    Status,
    COUNT(*) AS TotalLoans,
    SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY Status;

-- Loan type analysis
SELECT
    LoanType,
    COUNT(*) AS TotalLoans,
    SUM(LoanAmount) AS TotalLoanAmount,
    ROUND(AVG(InterestRate), 2) AS AverageInterestRate
FROM Loans
GROUP BY LoanType
ORDER BY TotalLoanAmount DESC;
