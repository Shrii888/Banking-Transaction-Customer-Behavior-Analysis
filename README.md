# Banking Transaction & Customer Behavior Analysis

## 📊 Project Overview

This project analyzes approximately **50,000 banking transactions** across **2020–2025** to understand transaction trends, customer behavior, high-value transaction patterns, and account-level performance.

The project combines **MySQL and Power BI** to transform raw banking transaction data into business-focused insights.

The analysis was structured around **15 business questions**, progressing from basic descriptive analysis to advanced SQL using **CTEs, subqueries, CASE statements, RANK(), and PARTITION BY**.

---

## 🎯 Business Objective

The objective of this project is to understand:

- Overall transaction volume and transaction value
- Debit vs. Credit transaction behavior
- Yearly and monthly transaction trends
- High-value transaction concentration
- Customer behavior across age groups and occupations
- Transaction behavior across account-balance and duration segments
- Location-level high-value transaction patterns
- Account-level transaction performance
- Debit and Credit account rankings

---

## 🗂️ Dataset

The dataset contains approximately:

- **50,000 transactions**
- **~500 unique accounts**
- Transaction period: **2020–2025**

### Key fields

| Column | Description |
|---|---|
| TransactionID | Unique transaction identifier |
| AccountID | Customer/account identifier |
| TransactionAmount | Transaction amount |
| TransactionType | Debit or Credit |
| TransactionDate | Date and time of transaction |
| Location | Transaction location |
| Channel | ATM, Branch or Online |
| CustomerAge | Customer age |
| CustomerOccupation | Customer occupation |
| AccountBalance | Account balance |
| TransactionDuration | Transaction duration |
| LoginAttempts | Number of login attempts |

---

# 🛠️ Tools & Technologies

- **MySQL** — Data validation, cleaning and SQL analysis
- **Power BI** — Dashboard development and visualization
- **Excel/CSV** — Source data preparation
- **GitHub** — Project documentation and portfolio presentation

---

# 🧹 Data Cleaning & Validation

Before performing the analysis, the dataset was validated and cleaned using SQL.

### Steps included:

1. Validated total row count and table structure
2. Checked transaction type distribution
3. Checked channel distribution
4. Checked occupation distribution
5. Created a backup table before transformations
6. Validated transaction date formats
7. Converted transaction dates into `DATETIME`
8. Validated earliest and latest transaction dates
9. Validated transaction amount and account balance ranges
10. Converted monetary fields to `DECIMAL(12,2)`
11. Cleaned malformed column names
12. Checked account-level consistency for occupation and age

---

# 🔎 SQL Analysis

The project contains **15 business-driven SQL questions**.

## Basic & Intermediate Analysis

### Q1 — Transaction and Account Overview
How many total transactions were recorded and how many unique accounts were involved?

### Q2 — Transaction Amount Statistics
What is the total transaction value, average transaction amount, minimum amount and maximum amount?

### Q3 — Debit vs Credit
How do Debit and Credit transactions differ in transaction volume and total transaction value?

### Q4 — Occupation Analysis
Which occupation categories are associated with the highest transaction volume and transaction value?

### Q5 — Year-over-Year Performance
How have transaction volume and transaction value changed from 2020 to 2025?

### Q6 — Monthly Transaction Activity
Which months generate the highest and lowest transaction activity across the six-year period?

### Q7 — High-Value Transactions
How many transactions exceed **$1,000**, and what percentage of all transactions do they represent?

### Q8 — Most Active Accounts
Which accounts are the most active based on transaction frequency?

### Q9 — Account Balance Segmentation
How does transaction behavior differ across Low, Medium and High balance segments?

### Q10 — Customer Age Segmentation
How does transaction activity differ across customer age groups?

### Q11 — Transaction Duration
Do longer transactions tend to have higher transaction values?

### Q12 — Login Attempt Analysis
Which accounts have transactions associated with unusually high login attempts?

---

## 🚀 Advanced SQL Analysis

### Q13 — Above-Average Accounts

Identified accounts generating more transaction value than the average account using:

- CTE
- Subquery
- Aggregation

### Q14 — Account Ranking

Ranked accounts according to total transaction value using:

- CTE
- `RANK() OVER()`

### Q15 — Debit/Credit Account Ranking

Ranked accounts separately for Debit and Credit transactions using:

- CTE
- `RANK()`
- `PARTITION BY`

---

# 📈 Power BI Dashboard

The Power BI report contains **two analytical pages**.

## Page 1 — Banking Transaction & Customer Behavior Analysis

### KPIs

- Total Transactions
- Unique Accounts
- Total Transaction Value
- High-Value Transaction %

### Visualizations

- Annual Transaction Performance
- Debit vs Credit Performance
- Transaction Channel Performance
- Transaction Value by Age Group

### Interactive Slicers

- Date
- Transaction Type
- Channel
- Age Group

---

## Page 2 — Customer Segmentation & Transaction Behavior

This page focuses on deeper customer and transaction patterns.

### Visualizations

- Transaction Value by Customer Occupation
- Transaction Value by Transaction Duration
- High-Value Transaction Rate by Location
- High-Value Transaction Rate by Occupation

---

# 💡 Key Business Insights

### Overall Transaction Activity

Approximately **50,000 transactions** were analyzed across approximately **500 accounts**.

### Transaction Value

The dataset generated approximately **$14.9M** in total transaction value.

### High-Value Transactions

Transactions above **$1,000** represented approximately **3.58%** of all transactions.

This indicates that the majority of transaction activity falls below the project's high-value threshold.

### Customer Age

The **41–60 age group** generated the highest transaction value among the analyzed age segments.

### Transaction Duration

Long-duration transactions generated approximately **$6.85M** in transaction value, compared with approximately:

- **$4.68M** from Medium-duration transactions
- **$3.37M** from Short-duration transactions

This indicates an association between longer transaction duration and higher aggregate transaction value within this dataset.

### Account Performance

Account-level analysis revealed substantial variation in transaction contribution.

The highest-ranked account generated **more than $111K** in total transaction value.

### Location & Occupation

High-value transaction rates varied across locations and occupations, allowing potential concentration areas to be identified for further investigation.

---

# 📌 Business Recommendations

Based on the analysis:

1. **Prioritize high-contribution customer segments** for targeted relationship and engagement strategies.

2. **Monitor high-value transaction concentration** across locations and occupations.

3. **Investigate long-duration transactions** to understand whether higher values are associated with transaction complexity or specific transaction types.

4. **Use account-level rankings** to identify high-contribution accounts for relationship-management strategies.

5. **Monitor accounts with high login attempts** as a separate transaction-security and risk-monitoring use case.

---

# ⚠️ Limitations

- The dataset is observational and does not establish causation.
- The **$1,000 high-value threshold** was selected as an analytical threshold for this project.
- The dataset should not be treated as representative of the entire banking industry.
- High-value rates should be considered alongside transaction volume before making business decisions.
- Further analysis using customer-level and fraud-specific data could provide stronger risk insights.

---

# 🧠 Skills Demonstrated

### SQL

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- Aggregate Functions
- CASE WHEN
- Date Functions
- Subqueries
- CTEs
- Window Functions
- `RANK()`
- `PARTITION BY`
- Data Validation
- Data Cleaning
- Data Type Conversion

### Power BI

- KPI Cards
- Calculated Measures
- Bar & Column Charts
- Donut/Pie Chart
- Interactive Slicers
- Customer Segmentation
- Trend Analysis
- Dashboard Design

### Analytical Skills

- Business Question Development
- Data Validation
- Customer Segmentation
- Trend Analysis
- Benchmarking
- Account Performance Analysis
- Business Insight Generation

---

# 📁 Repository Structure

```text
Banking-Transaction-Customer-Behavior-Analysis/
│
├── README.md
│
├── SQL/
│   └── Banking_Transaction_Analysis.sql
│
├── PowerBI/
│   └── Banking_Transaction_Analysis.pbix
│
├── Data/
│   └── banking_transaction_data.csv
│
├── Dashboard/
│   ├── Page_1_Overview.png
│   └── Page_2_Customer_Behavior.png
│
└── Documentation/
    └── Banking_Transaction_Analysis_Case_Study.md
