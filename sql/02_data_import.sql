-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 02_data_import.sql
-- Description: Import loan approval dataset
-- =====================================================

-- Import data using pgAdmin Import/Export Wizard
-- OR use COPY if required

/*
COPY loan_applications
FROM 'C:\Users\YourName\Downloads\loan_approval_dataset.csv'
DELIMITER ','
CSV HEADER;
*/

-- Verify import
SELECT COUNT(*) AS total_records
FROM loan_applications;

-- Preview data
SELECT *
FROM loan_applications
LIMIT 10;
