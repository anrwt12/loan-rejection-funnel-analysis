-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 05_loan_funnel_analysis.sql
-- Description: Loan Application Funnel Analysis
-- =====================================================

---------------------------------------------------------
-- 1. Total Loan Applications
---------------------------------------------------------
select count(*) as loan_applications 
FROM loan_applications;

---------------------------------------------------------
-- 2. Approved vs Rejected Applications
---------------------------------------------------------
select loan_status ,
count(*) as total_applications
 from loan_applications
 group by loan_status
 order by total_applications desc
 ;


---------------------------------------------------------
-- 3. Loan Approval Rate
---------------------------------------------------------
select
  ROUND(
count(*) filter (where loan_status = 'Approved')::NUMERIC
*100/count(*),2) 
as approval_rate
FROM loan_applications;

---------------------------------------------------------
-- 4. Loan Rejection Rate
---------------------------------------------------------
SELECT
    ROUND(
        COUNT(*) FILTER (WHERE loan_status = 'Rejected')::NUMERIC
        * 100 / COUNT(*),
        2
    ) AS rejection_rate
FROM loan_applications;

---------------------------------------------------------
-- 5. Approval by Education
---------------------------------------------------------
select
education,
loan_status,
count(*) as applications
from loan_applications
group by education, loan_status
order by education
;

---------------------------------------------------------
-- 6. Approval by Employment Status
---------------------------------------------------------
select self_employed,
loan_status,
count(*) as applications
from loan_applications
group by self_employed, loan_status
order by self_employed;



---------------------------------------------------------
-- 7. Approval by Number of Dependents
---------------------------------------------------------
select
    no_of_dependents,
    loan_status,
    COUNT(*) as applications
from loan_applications
group by no_of_dependents, loan_status
order by  no_of_dependents;


---------------------------------------------------------
-- 8. Approval by Loan Term
---------------------------------------------------------
select
    loan_term,
    loan_status,
    COUNT(*) as applications
from loan_applications
group by  loan_term, loan_status
order by loan_term;

---------------------------------------------------------
-- 9. Average Loan Amount by Status
---------------------------------------------------------
select
loan_status,
round(avg(loan_amount),2) as average_loan_amount
from loan_applications
group by loan_status;


---------------------------------------------------------
-- 10. Average Income by Status
---------------------------------------------------------
select 
loan_status,
round(avg(income_annum),2) as average_income
from loan_applications
group by loan_status;


---------------------------------------------------------
-- 11. Average CIBIL Score by Status
---------------------------------------------------------
select
    loan_status,
    ROUND(AVG(cibil_score),2) as average_cibil_score
from loan_applications
group by  loan_status;


---------------------------------------------------------
-- 12. Loan Funnel Summary
---------------------------------------------------------

select 
count(*) as total_applications,
count(*) filter(where loan_status ='Approved') as approved_loan,
count(*) filter(where loan_status = 'Rejected') as rejected_loan,
round(
count(*) filter(where loan_status ='Approved')*100/count(*),2) as 
approval_rate,
round(
count(*) filter(where loan_status ='Rejected')*100/count(*),2) as 
Rejection_rate
 from loan_applications;



