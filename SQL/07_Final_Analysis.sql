-- ============================================================
-- BANK MANAGEMENT & CUSTOMER ANALYTICS
-- 07 - Final / Executive Analysis
-- ============================================================

USE BankManagementSystem;

-- Customer 360 summary
WITH AccountSummary AS (
    SELECT
        CustomerID,
        COUNT(AccountID) AS TotalAccounts,
        SUM(Balance) AS TotalBalance
    FROM Accounts
    GROUP BY CustomerID
),
TransactionSummary AS (
    SELECT
        a.CustomerID,
        COUNT(t.TransactionID) AS TotalTransactions,
        SUM(t.Amount) AS TotalTransactionAmount
    FROM Accounts a
    INNER JOIN Transactions t
        ON a.AccountID = t.AccountID
    GROUP BY a.CustomerID
),
LoanSummary AS (
    SELECT
        CustomerID,
        COUNT(LoanID) AS TotalLoans,
        SUM(LoanAmount) AS TotalLoanAmount
    FROM Loans
    GROUP BY CustomerID
)
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.City,
    COALESCE(a.TotalAccounts, 0) AS TotalAccounts,
    COALESCE(a.TotalBalance, 0) AS TotalBalance,
    COALESCE(t.TotalTransactions, 0) AS TotalTransactions,
    COALESCE(t.TotalTransactionAmount, 0) AS TotalTransactionAmount,
    COALESCE(l.TotalLoans, 0) AS TotalLoans,
    COALESCE(l.TotalLoanAmount, 0) AS TotalLoanAmount
FROM Customers c
LEFT JOIN AccountSummary a
    ON c.CustomerID = a.CustomerID
LEFT JOIN TransactionSummary t
    ON c.CustomerID = t.CustomerID
LEFT JOIN LoanSummary l
    ON c.CustomerID = l.CustomerID
ORDER BY TotalBalance DESC;

-- Customer value segmentation
WITH CustomerSummary AS (
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        c.City,
        COALESCE(SUM(DISTINCT a.Balance), 0) AS TotalBalance,
        COALESCE(SUM(DISTINCT l.LoanAmount), 0) AS TotalLoanAmount
    FROM Customers c
    LEFT JOIN Accounts a
        ON c.CustomerID = a.CustomerID
    LEFT JOIN Loans l
        ON c.CustomerID = l.CustomerID
    GROUP BY
        c.CustomerID,
        c.FirstName,
        c.LastName,
        c.City
)
SELECT
    CustomerID,
    CustomerName,
    City,
    TotalBalance,
    TotalLoanAmount,
    CASE
        WHEN TotalBalance >= 100000
             AND TotalLoanAmount >= 500000
            THEN 'High Value'
        WHEN TotalBalance >= 50000
             OR TotalLoanAmount >= 200000
            THEN 'Medium Value'
        ELSE 'Low Value'
    END AS CustomerSegment
FROM CustomerSummary
ORDER BY TotalBalance DESC;

-- Customer transaction-to-balance analysis
WITH CustomerAnalysis AS (
    SELECT
        c.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        SUM(a.Balance) AS TotalBalance,
        SUM(
            CASE
                WHEN t.TransactionType = 'Deposit' THEN t.Amount
                WHEN t.TransactionType = 'Withdrawal' THEN -t.Amount
                ELSE 0
            END
        ) AS NetTransactionAmount
    FROM Customers c
    INNER JOIN Accounts a
        ON c.CustomerID = a.CustomerID
    LEFT JOIN Transactions t
        ON a.AccountID = t.AccountID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
)
SELECT
    CustomerID,
    CustomerName,
    TotalBalance,
    NetTransactionAmount,
    ROUND(
        NetTransactionAmount * 100.0
        / NULLIF(TotalBalance, 0),
        2
    ) AS TransactionToBalancePercentage
FROM CustomerAnalysis
ORDER BY TransactionToBalancePercentage DESC;

-- Branch-level deposit, withdrawal and net transaction analysis
SELECT
    b.BranchID,
    b.BranchName,
    b.City,
    SUM(
        CASE
            WHEN t.TransactionType = 'Deposit' THEN t.Amount
            WHEN t.TransactionType = 'Withdrawal' THEN -t.Amount
            ELSE 0
        END
    ) AS NetTransactionAmount,
    SUM(
        CASE
            WHEN t.TransactionType = 'Deposit' THEN t.Amount
            ELSE 0
        END
    ) AS TotalDeposits,
    SUM(
        CASE
            WHEN t.TransactionType = 'Withdrawal' THEN t.Amount
            ELSE 0
        END
    ) AS TotalWithdrawals
FROM Branches b
INNER JOIN Accounts a
    ON b.BranchID = a.BranchID
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
GROUP BY b.BranchID, b.BranchName, b.City
ORDER BY NetTransactionAmount DESC;

-- Executive KPI summary
SELECT
    (SELECT COUNT(*) FROM Customers) AS TotalCustomers,
    (SELECT COUNT(*) FROM Accounts) AS TotalAccounts,
    (SELECT SUM(Balance) FROM Accounts) AS TotalBalance,
    (SELECT COUNT(*) FROM Transactions) AS TotalTransactions,
    (SELECT SUM(Amount) FROM Transactions) AS TotalTransactionAmount,
    (SELECT COUNT(*) FROM Loans) AS TotalLoans,
    (SELECT SUM(LoanAmount) FROM Loans) AS TotalLoanAmount;

-- Expected executive KPI snapshot for this project:
-- Customers: 8
-- Accounts: 8
-- Total Balance: 630000
-- Transactions: 12
-- Transaction Amount: 149000
-- Loans: 6
-- Loan Amount: 2200000
