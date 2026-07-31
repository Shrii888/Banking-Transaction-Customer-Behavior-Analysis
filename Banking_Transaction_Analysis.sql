CREATE DATABASE BANK_ANALYSIS;

USE BANK_ANALYSIS;

SELECT * FROM bank;
SELECT COUNT(*) AS total_rows FROM bank;
DESCRIBE bank;

-- ============================================================
-- DATA VALIDATION
-- ============================================================

SELECT 
    TransactionType,
    COUNT(*) AS transactions
FROM bank
GROUP BY TransactionType;

SELECT 
    Channel,
    COUNT(*) AS transactions
FROM bank
GROUP BY Channel;

SELECT 
    CustomerOccupation,
    COUNT(*) AS transactions
FROM bank
GROUP BY CustomerOccupation
ORDER BY transactions DESC;

-- ============================================================
-- CREATING A BACKUP TABLE FOR RAW DATA
-- ============================================================

CREATE TABLE bank_backup AS
SELECT *
FROM bank;

SELECT COUNT(*) AS backup_rows
FROM bank_backup;

-- ============================================================
-- DATA CLEANING
-- ============================================================

SELECT * FROM bank;

SELECT 
    TransactionDate,
    STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i') AS format_slash,
    STR_TO_DATE(TransactionDate, '%d-%m-%Y %H:%i') AS format_dash
FROM bank
LIMIT 20;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(
        STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')
    ) AS valid_dates
FROM bank;

ALTER TABLE bank
ADD COLUMN temp_date DATETIME;

UPDATE bank
SET temp_date = STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i');

SELECT COUNT(*) AS valid_dates
FROM bank
WHERE temp_date IS NOT NULL;

ALTER TABLE bank
DROP COLUMN TransactionDate;

SELECT * FROM bank LIMIT 10;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(TransactionDate) AS valid_dates,
    MIN(TransactionDate) AS earliest_date,
    MAX(TransactionDate) AS latest_date
FROM bank;

ALTER TABLE bank
CHANGE COLUMN temp_date TransactionDate DATETIME;

-- Data validation before changing the data types of
-- TransactionAmount and AccountBalance

SELECT
    MIN(TransactionAmount) AS min_transaction,
    MAX(TransactionAmount) AS max_transaction,
    AVG(TransactionAmount) AS avg_transaction,
    MIN(AccountBalance) AS min_balance,
    MAX(AccountBalance) AS max_balance,
    AVG(AccountBalance) AS avg_balance
FROM bank;

ALTER TABLE bank
MODIFY TransactionAmount DECIMAL(12,2),
MODIFY AccountBalance DECIMAL(12,2);

ALTER TABLE bank
RENAME COLUMN `ï»¿TransactionID` TO TransactionID;

ALTER TABLE bank
RENAME COLUMN `IP Address` TO IP_Address;

DESCRIBE bank;

-- ============================================================
-- ACCOUNT-LEVEL CONSISTENCY CHECKS
-- ============================================================

SELECT
    AccountID,
    COUNT(DISTINCT CustomerOccupation) AS occupation_count
FROM bank
GROUP BY AccountID
HAVING COUNT(DISTINCT CustomerOccupation) > 1
ORDER BY occupation_count DESC;

SELECT
    COUNT(*) AS total_accounts,
    SUM(
        CASE 
            WHEN occupation_count > 1 THEN 1
            ELSE 0
        END
    ) AS accounts_with_multiple_occupations
FROM (
    SELECT
        AccountID,
        COUNT(DISTINCT CustomerOccupation) AS occupation_count
    FROM bank
    GROUP BY AccountID
) AS account_check;

-- We checked total accounts and accounts with multiple ages

SELECT
    COUNT(*) AS total_accounts,
    SUM(
        CASE
            WHEN age_count > 1 THEN 1
            ELSE 0
        END
    ) AS accounts_with_multiple_ages
FROM (
    SELECT
        AccountID,
        COUNT(DISTINCT CustomerAge) AS age_count
    FROM bank
    GROUP BY AccountID
) AS age_check;

-- ============================================================
-- BUSINESS QUESTIONS
-- ============================================================

-- Q1. How many total transactions were recorded,
-- and how many unique accounts were involved?

SELECT 
    COUNT(*) AS total_transactions, 
    COUNT(DISTINCT AccountID) AS unique_accounts
FROM bank;


-- Q2. What is the total transaction value, average transaction
-- amount, minimum transaction amount, and maximum transaction amount?

SELECT 
    SUM(TransactionAmount) AS total_transaction_value,
    AVG(TransactionAmount) AS average_transaction_amount,
    MIN(TransactionAmount) AS minimum_transaction_amount,
    MAX(TransactionAmount) AS maximum_transaction_amount
FROM bank;


-- Q3. How do Debit and Credit transactions differ in
-- transaction volume and total transaction value?

SELECT  
    TransactionType,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value
FROM bank 
GROUP BY TransactionType;


-- Q4. Which occupation categories are associated with
-- the highest transaction volume and transaction value?

SELECT 
    CustomerOccupation,
    COUNT(*) AS transaction_volume, 
    SUM(TransactionAmount) AS transaction_value
FROM bank
GROUP BY CustomerOccupation
ORDER BY transaction_volume DESC;


-- Q5. How have transaction volume and transaction value
-- changed year-over-year from 2020 to 2025?

SELECT 
    YEAR(TransactionDate) AS transaction_year,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value
FROM bank
GROUP BY transaction_year 
ORDER BY transaction_year DESC;


-- Q6. Which months generate the highest and lowest
-- transaction activity across the six-year period?

SELECT 
    MONTH(TransactionDate) AS Transac_month,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value
FROM bank
GROUP BY Transac_month
ORDER BY Transac_month;


-- Q7. How many high-value transactions exceed $1,000,
-- and what percentage of all transactions do they represent?

SELECT 
    SUM(
        CASE
            WHEN TransactionAmount > 1000 THEN 1
            ELSE 0
        END
    ) AS high_value_transactions,
    COUNT(*) AS total_transactions,
    ROUND(
        SUM(
            CASE
                WHEN TransactionAmount > 1000 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS high_value_percentage
FROM bank;


-- Q8. Which accounts are the most active based on
-- transaction frequency?

SELECT
    AccountID,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value,
    AVG(TransactionAmount) AS avg_transaction_value
FROM bank
GROUP BY AccountID
ORDER BY transaction_volume DESC
LIMIT 20;


-- Q9. How does transaction behavior differ across
-- account-balance segments?

-- First understand the actual distribution of AccountBalance.

SELECT
    ROUND(MIN(AccountBalance)) AS minimum_balance,
    ROUND(MAX(AccountBalance)) AS maximum_balance,
    ROUND(AVG(AccountBalance)) AS average_balance
FROM bank;

-- CASE WHEN based on the observed balance range

SELECT
    CASE
        WHEN AccountBalance <= 5000 THEN 'Low Balance'
        WHEN AccountBalance <= 10000 THEN 'Medium Balance'
        ELSE 'High Balance'
    END AS balance_segment,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value,
    AVG(TransactionAmount) AS avg_transaction_value
FROM bank 
GROUP BY balance_segment
ORDER BY transaction_value DESC;


-- Q10. How does transaction activity differ across
-- customer age groups?

SELECT
    CASE
        WHEN CustomerAge BETWEEN 18 AND 25 THEN '18-25'
        WHEN CustomerAge BETWEEN 26 AND 40 THEN '26-40'
        WHEN CustomerAge BETWEEN 41 AND 60 THEN '41-60'
        ELSE '61+'
    END AS age_group,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value
FROM bank
GROUP BY age_group
ORDER BY transaction_value;


-- Q11. Do longer transactions tend to have higher
-- transaction values?

-- Inspect the actual TransactionDuration range first.

SELECT
    MIN(TransactionDuration) AS minimum_duration,
    MAX(TransactionDuration) AS maximum_duration,
    ROUND(AVG(TransactionDuration), 2) AS average_duration
FROM bank;

SELECT
    CASE
        WHEN TransactionDuration <= 60 THEN 'Short'
        WHEN TransactionDuration <= 120 THEN 'Medium'
        ELSE 'Long'
    END AS duration_group,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value
FROM bank
GROUP BY duration_group
ORDER BY transaction_value;


-- Q12. Which accounts have transactions associated
-- with unusually high login attempts?

-- Check the range of login attempts first.

SELECT
    MIN(LoginAttempts) AS min_attempts,
    MAX(LoginAttempts) AS max_attempts
FROM bank;

SELECT
    AccountID,
    COUNT(*) AS transaction_volume,
    SUM(TransactionAmount) AS transaction_value,
    MAX(LoginAttempts) AS max_login_attempts
FROM bank
WHERE LoginAttempts >= 4
GROUP BY AccountID
ORDER BY transaction_value DESC;


-- Q13. Which accounts generate more transaction value
-- than the average account?

WITH account_summary AS (
    SELECT
        AccountID,
        SUM(TransactionAmount) AS transaction_value
    FROM bank
    GROUP BY AccountID
)
SELECT
    AccountID,
    transaction_value
FROM account_summary
WHERE transaction_value > (
    SELECT AVG(transaction_value)
    FROM account_summary
)
ORDER BY transaction_value DESC;


-- Q14. How do all accounts rank based on their
-- total transaction value?

WITH account_summary AS (
    SELECT
        AccountID,
        SUM(TransactionAmount) AS transaction_value
    FROM bank
    GROUP BY AccountID
)
SELECT
    AccountID,
    transaction_value,
    RANK() OVER (
        ORDER BY transaction_value DESC
    ) AS value_rank
FROM account_summary
ORDER BY value_rank;


-- Q15. Which accounts generate the highest transaction
-- value for Debit and Credit transactions?

WITH account_type_summary AS (
    SELECT
        AccountID,
        TransactionType,
        SUM(TransactionAmount) AS transaction_value
    FROM bank
    GROUP BY AccountID, TransactionType
)
SELECT
    AccountID,
    TransactionType,
    transaction_value,
    RANK() OVER (
        PARTITION BY TransactionType
        ORDER BY transaction_value DESC
    ) AS type_rank
FROM account_type_summary
ORDER BY TransactionType, type_rank;

-- ============================================================
-- FINAL VALIDATION
-- ============================================================

SELECT * FROM bank;
SELECT COUNT(*) AS current_rows FROM bank;

-- Check backup table
SELECT COUNT(*) AS backup_rows
FROM bank_backup;

-- Check current cleaned table
SELECT COUNT(*) AS current_rows
FROM bank;

SELECT COUNT(*) AS total_rows
FROM bank;

SELECT COUNT(DISTINCT TransactionID) AS unique_transactions
FROM bank;
