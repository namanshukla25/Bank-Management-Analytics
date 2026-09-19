# Bank Management & Customer Analytics

## 📌 Project Overview
An end-to-end banking analytics project using **MySQL, SQL, Power BI and DAX**. Customer, account, branch, transaction, loan and employee data are stored in a relational database, analyzed with SQL, and presented through an interactive Power BI dashboard.

## 🎯 Objectives
- Design a relational banking database using MySQL.
- Analyze customers, accounts, balances, transactions and loans.
- Apply advanced SQL techniques to solve business questions.
- Build an interactive Power BI dashboard.
- Generate practical banking and customer insights.

## 🛠️ Technologies
- **MySQL / MySQL Workbench** — database and SQL analysis
- **Power BI** — interactive dashboards
- **DAX** — calculations and customer segmentation
- **GitHub** — project documentation and version control

## 🗄️ Database Structure
The project contains 6 interconnected tables:

| Table | Purpose |
|---|---|
| `Customers` | Customer and branch information |
| `Branches` | Bank branch details |
| `Accounts` | Account type, balance and opening information |
| `Transactions` | Deposit and withdrawal activity |
| `Loans` | Loan amount, type, interest rate and status |
| `Employees` | Employee and branch information |

### Relationships
```text
Branches
   │
   ├── Customers
   │      ├── Accounts ── Transactions
   │      └── Loans
   │
   └── Employees
```

## 📊 Power BI Dashboard

### 1. Executive Overview
Key metrics:
- Total Customers: **8**
- Total Accounts: **8**
- Total Balance: **₹6.30 Lakh**
- Total Transactions: **12**
- Total Loan Amount: **₹22 Lakh**

### 2. Customer Analysis
Includes customer balances, average balance, customer value segmentation, account type distribution and city-wise customer distribution.

### 3. Transaction Analysis
Includes transaction amount, deposits vs withdrawals, monthly trends, transaction count and customer-wise transaction analysis.

- Deposits: **₹1.00 Lakh**
- Withdrawals: **₹0.49 Lakh**
- Net Transaction Amount: **₹0.51 Lakh**

### 4. Loan Analysis
Includes total loans, active loan amount, loan status, loan type, customer-wise loan amount and average interest rate.

- Total Loans: **6**
- Total Loan Amount: **₹22 Lakh**
- Active Loan Amount: **₹17 Lakh**

## 🔍 SQL Concepts Demonstrated

### Basic SQL
`SELECT` · `WHERE` · `GROUP BY` · `ORDER BY` · `LIMIT` · Aggregate Functions · `HAVING` · `CASE`

### Joins
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- Multi-table joins
- Customer 360 analysis

### Advanced SQL
- Subqueries
- CTEs
- `RANK()`
- `DENSE_RANK()`
- `ROW_NUMBER()`
- `PARTITION BY`
- `LAG()`
- Customer segmentation
- Transaction anomaly detection
- Month-over-month analysis
- Data quality checks

## 💡 Key Business Insights
- 8 customers hold 8 accounts with a combined balance of **₹6.30 Lakh**.
- Savings accounts contribute **₹3.60 Lakh** and current accounts **₹2.70 Lakh**.
- Bangalore has the highest customer count in the dataset.
- Deposits of **₹1.00 Lakh** exceed withdrawals of **₹0.49 Lakh**.
- The loan portfolio totals **₹22 Lakh**, including **₹17 Lakh** in active loans.
- Home loans represent the largest loan category in the dataset.

## 📁 Project Structure
```text
Bank-Management-Analytics/
│
├── README.md
│
├── SQL/
│   ├── 01_Create_Database.sql
│   ├── 02_Create_Tables.sql
│   ├── 03_Insert_Data.sql
│   ├── 04_Basic_Analysis.sql
│   ├── 05_Joins.sql
│   ├── 06_Advanced_SQL.sql
│   └── 07_Final_Analysis.sql
│
├── PowerBI/
│   └── Bank_Management_Analytics_Dashboard.pbix
│
└── Screenshots/
    ├── 01_Executive_Overview.png
    ├── 02_Customer_Analysis.png
    ├── 03_Transaction_Analysis.png
    └── 04_Loan_Analysis.png
```

## ▶️ How to Run

### MySQL
Open MySQL Workbench and run the SQL files in this order:
```text
01_Create_Database.sql
02_Create_Tables.sql
03_Insert_Data.sql
04_Basic_Analysis.sql
05_Joins.sql
06_Advanced_SQL.sql
07_Final_Analysis.sql
```

### Power BI
1. Open `Bank_Management_Analytics_Dashboard.pbix`.
2. Ensure MySQL Server is running.
3. Update connection credentials if required.
4. Refresh the dataset.
5. Explore the dashboard pages and slicers.

## 📈 Skills Demonstrated
**SQL | MySQL | Power BI | DAX | Data Analysis | Data Visualization | Business Intelligence | Customer Analytics | Financial Data Analysis**

## 👨‍💻 Author
**Naman Shukla**  
B.Tech Computer Science Engineering | Aspiring Data Analyst

## ⭐ Project Workflow
**Database Design → SQL Analysis → Business Insights → Power BI Dashboard**
