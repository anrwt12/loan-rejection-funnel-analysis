-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 06_customer_risk_analysis.sql
-- Description: Customer Risk Segmentation & Analysis
-- =====================================================
        
---------------------------------------------------------
-- 1. Customer Risk Segmentation using CIBIL Score
---------------------------------------------------------

select 
 case 
     when cibil_score>=750 then 'Low Risk'
	 when cibil_score between 650 and 749 then 'Medium Risk'
	 else 'High Risk'
End as risk_category,
count(*) as applicants
from loan_applications
group by risk_category
order by applicants desc;


---------------------------------------------------------
-- 2. Approval Rate by Risk Category
---------------------------------------------------------
select
case
	 when cibil_score >= 750 then 'Low Risk'
    when cibil_score between 650 AND 749 then 'Medium Risk'
    else'High Risk'
end AS risk_category,
ROUND(
count(*) filter(where loan_status = 'Approved')* 100/
count(*),2 )as  approved_rate
from  loan_applications
group by risk_category;

---------------------------------------------------------
-- 3. High Income Customers Rejected
---------------------------------------------------------
select 
loan_id,
income_annum,
loan_amount,cibil_score from loan_applications
where loan_status = 'Rejected'
And income_annum >
(
select avg(income_annum)
from loan_applications
)
order by income_annum desc;


---------------------------------------------------------
-- 4. Low CIBIL Customers Approved
---------------------------------------------------------
select 
loan_id,
income_annum,
loan_amount,
cibil_score
from loan_applications
where loan_status = 'Apporoved' 
and cibil_score <650
order by cibil_score;

---------------------------------------------------------
-- 5. Loan-to-Income Ratio
---------------------------------------------------------
select
loan_id,
income_annum,
loan_amount,
round(
loan_amount::numeric/
income_annum,2) 
as loan_income_ratio
from loan_applications
order by loan_income_ratio desc;


---------------------------------------------------------
-- 6. Total Asset Value
---------------------------------------------------------
select
    loan_id,
    (
        residential_assets_value +
        commercial_assets_value +
        luxury_assets_value +
        bank_asset_value
    ) as total_assets
from loan_applications
order by  total_assets DESC;

---------------------------------------------------------
-- 7. Asset Coverage Ratio
---------------------------------------------------------
with asset_summary AS (
   select
        loan_id,
        loan_amount,
        residential_assets_value +
        commercial_assets_value +
        luxury_assets_value +
        bank_asset_value AS total_assets
   from loan_applications
)

select
    loan_id,
    loan_amount,
    total_assets,
    ROUND(
        loan_amount::NUMERIC / nullif(total_assets,0),
        2
    ) as asset_coverage_ratio
from asset_summary;
---------------------------------------------------------
-- 8. Top 10 Highest Risk Applicants
---------------------------------------------------------
select 
loan_id,
income_annum,
loan_amount,
cibil_score
from loan_applications
order by cibil_score asc,
loan_amount desc
limit 10;

---------------------------------------------------------
-- 9. Best Customers Rejected
---------------------------------------------------------
select
loan_id,
income_annum,
loan_amount,
cibil_score
from loan_applications
where
loan_status='Rejected'
AND cibil_score>=750
order by income_annum DESC;


