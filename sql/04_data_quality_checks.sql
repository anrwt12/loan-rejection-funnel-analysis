
-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 04_data_quality_checks.sql
-- Description: Data Quality Assessment
-- =====================================================


---------------------------------------------------------
-- 1. Total Records
---------------------------------------------------------
select count(*)  as total_records 
from loan_applications;

---------------------------------------------------------
-- 2. Verify Unique Loan IDs
---------------------------------------------------------
select 
count(*) as total_records,
count(distinct loan_id) as unique_loan_ids
from  loan_applications;

---------------------------------------------------------
-- 3. Check for Duplicate Loan IDs
---------------------------------------------------------
SELECT
    loan_id,
    COUNT(*) AS duplicate_count
FROM loan_applications
GROUP BY loan_id
HAVING COUNT(*) > 1;

---------------------------------------------------------
-- 4. Missing Values Summary
---------------------------------------------------------

SELECT
    COUNT(*) FILTER (WHERE loan_id IS NULL) AS loan_id_nulls,
    COUNT(*) FILTER (WHERE no_of_dependents IS NULL) AS dependents_nulls,
    COUNT(*) FILTER (WHERE education IS NULL) AS education_nulls,
    COUNT(*) FILTER (WHERE self_employed IS NULL) AS self_employed_nulls,
    COUNT(*) FILTER (WHERE income_annum IS NULL) AS income_nulls,
    COUNT(*) FILTER (WHERE loan_amount IS NULL) AS loan_amount_nulls,
    COUNT(*) FILTER (WHERE loan_term IS NULL) AS loan_term_nulls,
    COUNT(*) FILTER (WHERE cibil_score IS NULL) AS cibil_nulls,
    COUNT(*) FILTER (WHERE residential_assets_value IS NULL) AS residential_asset_nulls,
    COUNT(*) FILTER (WHERE commercial_assets_value IS NULL) AS commercial_asset_nulls,
    COUNT(*) FILTER (WHERE luxury_assets_value IS NULL) AS luxury_asset_nulls,
    COUNT(*) FILTER (WHERE bank_asset_value IS NULL) AS bank_asset_nulls,
    COUNT(*) FILTER (WHERE loan_status IS NULL) AS loan_status_nulls
FROM loan_applications;


---------------------------------------------------------
-- 5. Validate CIBIL Score Range
---------------------------------------------------------
select
min(cibil_score) as min_cibil_score,
max(cibil_score) as max_cibil_score
from loan_applications;

---------------------------------------------------------
-- 7. Validate Loan Amount Range
---------------------------------------------------------
select
min(loan_amount) as min_loan_amount,
max(loan_amount) as max_loan_amount
from loan_applications;

---------------------------------------------------------
-- 8. Validate Loan Term Range
---------------------------------------------------------
select
min(loan_term) as min_loan_terms,
max(loan_term) as max_loan_terms
from loan_applications;

---------------------------------------------------------
-- 9. Verify Category Values
---------------------------------------------------------
select loan_status, count(*)  as total
from loan_applications
group by loan_status;


select education , 
count(*) as total
from loan_applications
group by education;


select self_employed ,
count(*) as total
from loan_applications
group by self_employed ;


---------------------------------------------------------
-- 10. Data Quality Summary
---------------------------------------------------------

select 
count(*) as total_records,
count(distinct loan_id) as  unique_loan_ids,
round(avg(cibil_score),2) as avg_cibil_score,
round(avg(income_annum),2) as avg_income,
round(avg(loan_amount),2) AS avg_loan_amount
from loan_applications;

