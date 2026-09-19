-- ============================================================
-- BANK MANAGEMENT & CUSTOMER ANALYTICS
-- 06 - Advanced SQL
-- ============================================================

USE BankManagementSystem;

-- HAVING
SELECT
    AccountType,
    SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(Balance) > 300000;

-- CASE: customer value based on balance
SELECT
    c.FirstName,
    c.LastName,
    a.Balance,
    CASE
        WHEN a.Balance >= 100000 THEN 'High Value'
        WHEN a.Balance >= 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS CustomerCategory
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- CTE: customer balance summary
WITH CustomerBalance AS (
    SELECT
        CustomerID,
        SUM(Balance) AS TotalBalance
    FROM Accounts
    GROUP BY CustomerID
)
SELECT *
FROM CustomerBalance
ORDER BY TotalBalance DESC;

-- CTE: customers with balance above 100K
WITH CustomerBalance AS (
    SELECT
        CustomerID,
        SUM(Balance) AS TotalBalance
    FROM Accounts
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    TotalBalance
FROM CustomerBalance
WHERE TotalBalance > 100000
ORDER BY TotalBalance DESC;

-- RANK
SELECT
    c.FirstName,
    c.LastName,
    a.Balance,
    RANK() OVER (ORDER BY a.Balance DESC) AS BalanceRank
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- RANK by account type
SELECT
    c.FirstName,
    c.LastName,
    a.AccountType,
    a.Balance,
    RANK() OVER (
        PARTITION BY a.AccountType
        ORDER BY a.Balance DESC
    ) AS AccountTypeRank
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- ROW_NUMBER
SELECT
    c.FirstName,
    c.LastName,
    a.Balance,
    ROW_NUMBER() OVER (ORDER BY a.Balance DESC) AS RowNumber
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- Top customer in each branch
WITH RankedCustomers AS (
    SELECT
        c.CustomerID,
        c.FirstName,
        c.LastName,
        b.BranchName,
        b.City,
        a.Balance,
        RANK() OVER (
            PARTITION BY a.BranchID
            ORDER BY a.Balance DESC
        ) AS BranchRank
    FROM Customers c
    INNER JOIN Accounts a
        ON c.CustomerID = a.CustomerID
    INNER JOIN Branches b
        ON a.BranchID = b.BranchID
)
SELECT
    CustomerID,
    FirstName,
    LastName,
    BranchName,
    City,
    Balance
FROM RankedCustomers
WHERE BranchRank = 1
ORDER BY Balance DESC;

-- Net transaction amount by customer
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
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
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY NetTransactionAmount DESC;

-- Deposit / withdrawal ratio
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE 0 END) AS TotalDeposits,
    SUM(CASE WHEN t.TransactionType = 'Withdrawal' THEN t.Amount ELSE 0 END) AS TotalWithdrawals,
    ROUND(
        SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE 0 END)
        / NULLIF(
            SUM(CASE WHEN t.TransactionType = 'Withdrawal' THEN t.Amount ELSE 0 END),
            0
        ),
        2
    ) AS DepositWithdrawalRatio
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY DepositWithdrawalRatio DESC;

-- Customer activity classification
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(t.TransactionID) AS TotalTransactions,
    CASE
        WHEN COUNT(t.TransactionID) >= 5 THEN 'Highly Active'
        WHEN COUNT(t.TransactionID) >= 3 THEN 'Active'
        ELSE 'Low Activity'
    END AS ActivityLevel
FROM Customers c
LEFT JOIN Accounts a
    ON c.CustomerID = a.CustomerID
LEFT JOIN Transactions t
    ON a.AccountID = t.AccountID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalTransactions DESC;

-- Branch transaction performance
SELECT
    b.BranchID,
    b.BranchName,
    b.City,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(t.Amount) AS TotalTransactionAmount,
    ROUND(AVG(t.Amount), 2) AS AverageTransactionAmount
FROM Branches b
INNER JOIN Accounts a
    ON b.BranchID = a.BranchID
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
GROUP BY b.BranchID, b.BranchName, b.City
ORDER BY TotalTransactionAmount DESC;

-- Loan interest categorization
SELECT
    LoanID,
    CustomerID,
    LoanType,
    LoanAmount,
    InterestRate,
    CASE
        WHEN InterestRate >= 10 THEN 'High Interest'
        WHEN InterestRate >= 8 THEN 'Medium Interest'
        ELSE 'Low Interest'
    END AS InterestCategory,
    Status
FROM Loans
ORDER BY InterestRate DESC;

-- Loan portfolio summary
SELECT
    COUNT(LoanID) AS TotalLoans,
    SUM(LoanAmount) AS TotalLoanAmount,
    ROUND(AVG(LoanAmount), 2) AS AverageLoanAmount,
    ROUND(AVG(InterestRate), 2) AS AverageInterestRate,
    SUM(CASE WHEN Status = 'Active' THEN LoanAmount ELSE 0 END) AS ActiveLoanAmount
FROM Loans;

-- Loan status percentages
SELECT
    Status,
    COUNT(LoanID) AS TotalLoans,
    SUM(LoanAmount) AS TotalLoanAmount,
    ROUND(
        SUM(LoanAmount) * 100.0 /
        (SELECT SUM(LoanAmount) FROM Loans),
        2
    ) AS LoanAmountPercentage
FROM Loans
GROUP BY Status
ORDER BY LoanAmountPercentage DESC;

-- Transaction anomaly / outlier detection
SELECT
    TransactionID,
    AccountID,
    TransactionType,
    Amount,
    TransactionDate,
    ROUND(
        AVG(Amount) OVER (PARTITION BY TransactionType),
        2
    ) AS AverageAmountByType,
    CASE
        WHEN Amount > AVG(Amount) OVER (PARTITION BY TransactionType) * 2
            THEN 'Potential Outlier'
        ELSE 'Normal'
    END AS TransactionStatus
FROM Transactions
ORDER BY TransactionType, Amount DESC;

-- Month-over-month transaction growth
WITH MonthlyTransactions AS (
    SELECT
        YEAR(TransactionDate) AS TransactionYear,
        MONTH(TransactionDate) AS TransactionMonth,
        MONTHNAME(TransactionDate) AS MonthName,
        SUM(Amount) AS TotalTransactionAmount
    FROM Transactions
    GROUP BY
        YEAR(TransactionDate),
        MONTH(TransactionDate),
        MONTHNAME(TransactionDate)
),
MonthlyGrowth AS (
    SELECT
        TransactionYear,
        TransactionMonth,
        MonthName,
        TotalTransactionAmount,
        LAG(TotalTransactionAmount) OVER (
            ORDER BY TransactionYear, TransactionMonth
        ) AS PreviousMonthAmount
    FROM MonthlyTransactions
)
SELECT
    MonthName,
    TotalTransactionAmount,
    PreviousMonthAmount,
    ROUND(
        (TotalTransactionAmount - PreviousMonthAmount) * 100.0
        / NULLIF(PreviousMonthAmount, 0),
        2
    ) AS GrowthPercentage
FROM MonthlyGrowth
ORDER BY TransactionYear, TransactionMonth;

-- Data quality: duplicate customer IDs
SELECT
    CustomerID,
    COUNT(*) AS DuplicateCount
FROM Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- Data quality: missing customer fields
SELECT
    SUM(CASE WHEN FirstName IS NULL THEN 1 ELSE 0 END) AS MissingFirstName,
    SUM(CASE WHEN LastName IS NULL THEN 1 ELSE 0 END) AS MissingLastName,
    SUM(CASE WHEN DateOfBirth IS NULL THEN 1 ELSE 0 END) AS MissingDateOfBirth,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS MissingGender,
    SUM(CASE WHEN Phone IS NULL THEN 1 ELSE 0 END) AS MissingPhone,
    SUM(CASE WHEN Email IS NULL THEN 1 ELSE 0 END) AS MissingEmail,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS MissingCity,
    SUM(CASE WHEN BranchID IS NULL THEN 1 ELSE 0 END) AS MissingBranchID
FROM Customers;

-- Data quality: invalid branch references
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.BranchID
FROM Customers c
LEFT JOIN Branches b
    ON c.BranchID = b.BranchID
WHERE b.BranchID IS NULL;

-- Data quality: negative balances
SELECT
    AccountID,
    CustomerID,
    AccountNumber,
    AccountType,
    Balance
FROM Accounts
WHERE Balance < 0
ORDER BY Balance;
