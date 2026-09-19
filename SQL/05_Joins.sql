-- ============================================================
-- BANK MANAGEMENT & CUSTOMER ANALYTICS
-- 05 - Joins
-- ============================================================

USE BankManagementSystem;

-- INNER JOIN: customer + account
SELECT
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    a.AccountType,
    a.Balance
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- INNER JOIN: customer + account + branch
SELECT
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    a.Balance,
    b.BranchName,
    b.City
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN Branches b
    ON a.BranchID = b.BranchID;

-- LEFT JOIN: all customers, including customers without accounts
SELECT
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    a.Balance
FROM Customers c
LEFT JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- RIGHT JOIN: all accounts, including accounts without matching customers
SELECT
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    a.Balance
FROM Customers c
RIGHT JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- Customers with accounts and loans
SELECT DISTINCT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    a.Balance,
    l.LoanType,
    l.LoanAmount,
    l.Status
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN Loans l
    ON c.CustomerID = l.CustomerID;

-- Top 3 customers by account balance
SELECT
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    a.Balance
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
ORDER BY a.Balance DESC
LIMIT 3;

-- Branch-wise customer and balance analysis
SELECT
    b.BranchName,
    b.City,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COALESCE(SUM(a.Balance), 0) AS TotalBalance
FROM Branches b
LEFT JOIN Customers c
    ON b.BranchID = c.BranchID
LEFT JOIN Accounts a
    ON c.CustomerID = a.CustomerID
GROUP BY b.BranchName, b.City
ORDER BY TotalBalance DESC;

-- Customer transaction activity
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(t.TransactionID) AS TotalTransactions,
    COALESCE(SUM(t.Amount), 0) AS TotalTransactionAmount
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalTransactionAmount DESC;

-- Branch-wise loan portfolio
SELECT
    b.BranchID,
    b.BranchName,
    b.City,
    COUNT(l.LoanID) AS TotalLoans,
    SUM(l.LoanAmount) AS TotalLoanAmount,
    ROUND(AVG(l.LoanAmount), 2) AS AverageLoanAmount
FROM Branches b
INNER JOIN Customers c
    ON b.BranchID = c.BranchID
INNER JOIN Loans l
    ON c.CustomerID = l.CustomerID
GROUP BY b.BranchID, b.BranchName, b.City
ORDER BY TotalLoanAmount DESC;
