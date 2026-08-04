-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 03_data_cleaning.sql
-- Description: Data Cleaning & Validation
-- =====================================================

-- Preview dataset
select* 
from loan_applications
limit 10;


---------------------------------------------------------
-- Check Total Records
---------------------------------------------------------
 select count(*)  as total_records
 from loan_applications;

---------------------------------------------------------
-- Check for Duplicate Loan IDs
---------------------------------------------------------
select loan_id ,
count(*)
from loan_applications
group by loan_id
having count(*)>1
;

---------------------------------------------------------
-- Check Missing Values
---------------------------------------------------------
select
   COUNT(*) FILTER (WHERE education IS NULL) AS education_nulls,
    COUNT(*) FILTER (WHERE self_employed IS NULL) AS self_employed_nulls,
    COUNT(*) FILTER (WHERE income_annum IS NULL) AS income_nulls,
    COUNT(*) FILTER (WHERE loan_amount IS NULL) AS loan_amount_nulls,
    COUNT(*) FILTER (WHERE cibil_score IS NULL) AS cibil_nulls,
    COUNT(*) FILTER (WHERE loan_status IS NULL) AS loan_status_nulls
FROM loan_applications;

---------------------------------------------------------
-- Remove Leading & Trailing Spaces
---------------------------------------------------------
update loan_applications
set
education = TRIM(education),
self_employed = TRIM(self_employed),
loan_status = TRIM(loan_status);

---------------------------------------------------------
-- Check Invalid Income
---------------------------------------------------------
select*
from loan_applications
where income_annum <=0;

---------------------------------------------------------
-- Check Invalid Loan Amount
---------------------------------------------------------
SELECT *
FROM loan_applications
WHERE loan_amount <= 0;

---------------------------------------------------------
-- Check Invalid CIBIL Score
---------------------------------------------------------
select *
from loan_applications
where cibil_score not between 300 AND 900;

---------------------------------------------------------
-- Verify Distinct Values
---------------------------------------------------------

select distinct education
from loan_applications;

SELECT DISTINCT self_employed
FROM loan_applications;

SELECT DISTINCT loan_status
FROM loan_applications;
