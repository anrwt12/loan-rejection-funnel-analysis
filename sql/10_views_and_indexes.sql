-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 10_views_and_indexes.sql
-- Description: Views and Performance Optimization
-- =====================================================

---------------------------------------------------------
-- 1. View: Loan Approval Summary
---------------------------------------------------------

CREATE OR REPLACE VIEW vw_loan_summary AS

SELECT

loan_status,

COUNT(*) AS total_applications,

ROUND(AVG(income_annum),2) AS avg_income,

ROUND(AVG(loan_amount),2) AS avg_loan_amount,

ROUND(AVG(cibil_score),2) AS avg_cibil

FROM loan_applications

GROUP BY loan_status;

---------------------------------------------------------
-- 2. View: Customer Risk Summary
---------------------------------------------------------

CREATE OR REPLACE VIEW vw_customer_risk AS

SELECT

loan_id,

income_annum,

loan_amount,

cibil_score,

CASE

WHEN cibil_score >=750 THEN 'Low Risk'

WHEN cibil_score BETWEEN 650 AND 749 THEN 'Medium Risk'

ELSE 'High Risk'

END AS risk_category,

loan_status

FROM loan_applications;

---------------------------------------------------------
-- 3. View: Asset Summary
---------------------------------------------------------

CREATE OR REPLACE VIEW vw_asset_summary AS

SELECT

loan_id,

loan_amount,

residential_assets_value,

commercial_assets_value,

luxury_assets_value,

bank_asset_value,

(residential_assets_value+

commercial_assets_value+

luxury_assets_value+

bank_asset_value)

AS total_assets

FROM loan_applications;

---------------------------------------------------------
-- 4. View: Executive Dashboard
---------------------------------------------------------

CREATE OR REPLACE VIEW vw_dashboard_kpis AS

SELECT

COUNT(*) AS total_applications,

COUNT(*) FILTER

(

WHERE loan_status='Approved'

) AS approved,

COUNT(*) FILTER

(

WHERE loan_status='Rejected'

) AS rejected,

ROUND(

COUNT(*) FILTER

(

WHERE loan_status='Approved'

)*100.0/

COUNT(*),

2

) AS approval_rate,

ROUND(

AVG(cibil_score),

2

) AS avg_cibil_score,

ROUND(

AVG(loan_amount),

2

) AS avg_loan_amount

FROM loan_applications;

---------------------------------------------------------
-- 5. Index on Loan Status
---------------------------------------------------------

CREATE INDEX idx_loan_status

ON loan_applications(loan_status);

---------------------------------------------------------
-- 6. Index on CIBIL Score
---------------------------------------------------------

CREATE INDEX idx_cibil_score

ON loan_applications(cibil_score);

---------------------------------------------------------
-- 7. Index on Income
---------------------------------------------------------

CREATE INDEX idx_income

ON loan_applications(income_annum);

---------------------------------------------------------
-- 8. Index on Loan Amount
---------------------------------------------------------

CREATE INDEX idx_loan_amount

ON loan_applications(loan_amount);

---------------------------------------------------------
-- 9. Index on Education
---------------------------------------------------------

CREATE INDEX idx_education

ON loan_applications(education);

---------------------------------------------------------
-- 10. Index on Self Employment
---------------------------------------------------------

CREATE INDEX idx_self_employed

ON loan_applications(self_employed);

---------------------------------------------------------
-- Verify Views
---------------------------------------------------------

SELECT * FROM vw_loan_summary;

SELECT * FROM vw_customer_risk;

SELECT * FROM vw_asset_summary;

SELECT * FROM vw_dashboard_kpis;
