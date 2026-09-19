-- ============================================================
-- BANK MANAGEMENT & CUSTOMER ANALYTICS
-- 03 - Insert Data
-- ============================================================

USE BankManagementSystem;

-- Branches
INSERT INTO Branches
(BranchID, BranchName, City, IFSCCode)
VALUES
(1, 'BTM Branch', 'Bangalore', 'BANK000101'),
(2, 'MG Road Branch', 'Bangalore', 'BANK000102'),
(3, 'Andheri Branch', 'Mumbai', 'BANK000103'),
(4, 'Connaught Place Branch', 'Delhi', 'BANK000104'),
(5, 'Civil Lines Branch', 'Satna', 'BANK000105');

-- Customers
INSERT INTO Customers
(CustomerID, FirstName, LastName, DateOfBirth, Gender, Phone, Email, Address, City, BranchID)
VALUES
(101, 'Rahul', 'Sharma', '2001-05-15', 'Male', '9876543210', 'rahul@gmail.com', 'BTM Layout', 'Bangalore', 1),
(102, 'Priya', 'Verma', '2002-08-20', 'Female', '9876543211', 'priya@gmail.com', 'Andheri East', 'Mumbai', 3),
(103, 'Amit', 'Patel', '2000-03-10', 'Male', '9876543212', 'amit@gmail.com', 'MG Road', 'Bangalore', 2),
(104, 'Neha', 'Singh', '2003-11-25', 'Female', '9876543213', 'neha@gmail.com', 'Connaught Place', 'Delhi', 4),
(105, 'Rohan', 'Gupta', '2001-07-12', 'Male', '9876543214', 'rohan@gmail.com', 'Civil Lines', 'Satna', 5),
(106, 'Anjali', 'Shukla', '2002-01-18', 'Female', '9876543215', 'anjali@gmail.com', 'BTM Layout', 'Bangalore', 1),
(107, 'Vikas', 'Yadav', '1999-09-05', 'Male', '9876543216', 'vikas@gmail.com', 'MG Road', 'Bangalore', 2),
(108, 'Sneha', 'Joshi', '2003-06-22', 'Female', '9876543217', 'sneha@gmail.com', 'Andheri West', 'Mumbai', 3);

-- Accounts
INSERT INTO Accounts
(AccountID, CustomerID, AccountNumber, AccountType, Balance, OpeningDate, BranchID)
VALUES
(1001, 101, 'ACC100001', 'Savings', 50000.00, '2024-01-15', 1),
(1002, 102, 'ACC100002', 'Savings', 75000.00, '2024-02-20', 3),
(1003, 103, 'ACC100003', 'Current', 120000.00, '2023-11-10', 2),
(1004, 104, 'ACC100004', 'Savings', 35000.00, '2024-03-05', 4),
(1005, 105, 'ACC100005', 'Savings', 90000.00, '2023-12-18', 5),
(1006, 106, 'ACC100006', 'Current', 150000.00, '2024-04-22', 1),
(1007, 107, 'ACC100007', 'Savings', 45000.00, '2024-05-12', 2),
(1008, 108, 'ACC100008', 'Savings', 65000.00, '2024-06-30', 3);

-- Transactions
INSERT INTO Transactions
(TransactionID, AccountID, TransactionType, Amount, TransactionDate, Description)
VALUES
(5001, 1001, 'Deposit', 10000.00, '2026-01-10', 'Salary credit'),
(5002, 1001, 'Withdrawal', 3000.00, '2026-01-15', 'ATM withdrawal'),
(5003, 1002, 'Deposit', 15000.00, '2026-01-18', 'Cash deposit'),
(5004, 1003, 'Withdrawal', 20000.00, '2026-01-20', 'Business expense'),
(5005, 1004, 'Deposit', 8000.00, '2026-01-25', 'Cash deposit'),
(5006, 1005, 'Withdrawal', 5000.00, '2026-02-02', 'ATM withdrawal'),
(5007, 1006, 'Deposit', 25000.00, '2026-02-05', 'Business income'),
(5008, 1007, 'Withdrawal', 7000.00, '2026-02-10', 'Online payment'),
(5009, 1008, 'Deposit', 12000.00, '2026-02-15', 'Salary credit'),
(5010, 1002, 'Withdrawal', 4000.00, '2026-02-20', 'ATM withdrawal'),
(5011, 1003, 'Deposit', 30000.00, '2026-03-01', 'Business income'),
(5012, 1006, 'Withdrawal', 10000.00, '2026-03-05', 'Online transfer');

-- Loans
INSERT INTO Loans
(LoanID, CustomerID, LoanType, LoanAmount, InterestRate, LoanDate, Status)
VALUES
(9001, 101, 'Home Loan', 500000.00, 8.50, '2025-01-10', 'Active'),
(9002, 103, 'Personal Loan', 200000.00, 11.00, '2025-02-15', 'Active'),
(9003, 104, 'Car Loan', 350000.00, 9.25, '2025-03-20', 'Closed'),
(9004, 105, 'Education Loan', 250000.00, 7.50, '2025-04-05', 'Active'),
(9005, 107, 'Personal Loan', 150000.00, 12.00, '2025-05-18', 'Pending'),
(9006, 108, 'Home Loan', 750000.00, 8.25, '2025-06-25', 'Active');

-- Employees
INSERT INTO Employees
(EmployeeID, FirstName, LastName, Position, Salary, BranchID)
VALUES
(201, 'Suresh', 'Kumar', 'Branch Manager', 65000.00, 1),
(202, 'Pooja', 'Mehta', 'Cashier', 35000.00, 1),
(203, 'Arjun', 'Rao', 'Loan Officer', 45000.00, 2),
(204, 'Kavita', 'Sharma', 'Branch Manager', 70000.00, 3),
(205, 'Manish', 'Verma', 'Cashier', 32000.00, 4),
(206, 'Ritu', 'Patel', 'Loan Officer', 48000.00, 5),
(207, 'Aakash', 'Singh', 'Cashier', 34000.00, 2),
(208, 'Divya', 'Joshi', 'Loan Officer', 46000.00, 3);

-- Quick verification
SELECT * FROM Branches;
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Loans;
SELECT * FROM Employees;
