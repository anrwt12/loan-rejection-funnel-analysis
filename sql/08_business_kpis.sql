-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 08_business_kpis.sql
-- Description: Executive Business KPIs
-- =====================================================

---------------------------------------------------------
-- 1. Loan Portfolio Summary
---------------------------------------------------------

SELECT
    COUNT(*) AS total_applications,
    COUNT(*) FILTER (WHERE loan_status = 'Approved') AS approved_loans,
    COUNT(*) FILTER (WHERE loan_status = 'Rejected') AS rejected_loans,
    ROUND(
        COUNT(*) FILTER (WHERE loan_status = 'Approved') * 100.0 /
        COUNT(*), 2
    ) AS approval_rate,
    ROUND(
        COUNT(*) FILTER (WHERE loan_status = 'Rejected') * 100.0 /
        COUNT(*), 2
    ) AS rejection_rate
FROM loan_applications;

---------------------------------------------------------
-- 2. Financial KPIs
---------------------------------------------------------

SELECT
    ROUND(AVG(income_annum),2) AS avg_income,
    ROUND(AVG(loan_amount),2) AS avg_loan_amount,
    ROUND(AVG(cibil_score),2) AS avg_cibil_score
FROM loan_applications;

---------------------------------------------------------
-- 3. Loan-to-Income Ratio KPI
---------------------------------------------------------

SELECT
    ROUND(
        AVG(
            loan_amount::NUMERIC /
            NULLIF(income_annum,0)
        ),
        2
    ) AS avg_loan_to_income_ratio
FROM loan_applications;

---------------------------------------------------------
-- 4. Asset Coverage Ratio KPI
---------------------------------------------------------

WITH asset_summary AS (
    SELECT
        loan_id,
        loan_amount,
        residential_assets_value +
        commercial_assets_value +
        luxury_assets_value +
        bank_asset_value AS total_assets
    FROM loan_applications
)

SELECT
    ROUND(
        AVG(
            loan_amount::NUMERIC /
            NULLIF(total_assets,0)
        ),
        2
    ) AS avg_asset_coverage_ratio
FROM asset_summary;

---------------------------------------------------------
-- 5. Risk Category Distribution
---------------------------------------------------------

SELECT
CASE
    WHEN cibil_score >=750 THEN 'Low Risk'
    WHEN cibil_score BETWEEN 650 AND 749 THEN 'Medium Risk'
    ELSE 'High Risk'
END AS risk_category,

COUNT(*) AS applicants

FROM loan_applications

GROUP BY risk_category

ORDER BY applicants DESC;

---------------------------------------------------------
-- 6. Top Performing Customer Segment
---------------------------------------------------------

SELECT
    education,
    self_employed,
    COUNT(*) FILTER (WHERE loan_status='Approved') AS approved_loans,
    COUNT(*) AS total_applications,
    ROUND(
        COUNT(*) FILTER (WHERE loan_status='Approved') *100.0/
        COUNT(*),
        2
    ) AS approval_rate
FROM loan_applications
GROUP BY education, self_employed
ORDER BY approval_rate DESC;

---------------------------------------------------------
-- 7. High-Risk Loan Exposure
---------------------------------------------------------

SELECT
    COUNT(*) AS high_risk_loans,
    ROUND(SUM(loan_amount),2) AS total_high_risk_loan_amount
FROM loan_applications
WHERE cibil_score < 650;

---------------------------------------------------------
-- 8. Manual Review Candidates
---------------------------------------------------------

SELECT
    COUNT(*) AS manual_review_cases
FROM loan_applications
WHERE loan_status='Rejected'
AND cibil_score >=700
AND income_annum >
(
SELECT AVG(income_annum)
FROM loan_applications
);

---------------------------------------------------------
-- 9. Total Loan Amount Approved
---------------------------------------------------------

SELECT
    ROUND(SUM(loan_amount),2) AS total_approved_loan_amount
FROM loan_applications
WHERE loan_status='Approved';

---------------------------------------------------------
-- 10. Executive Dashboard KPIs
---------------------------------------------------------

SELECT
    COUNT(*) AS total_applications,
    ROUND(AVG(cibil_score),2) AS avg_cibil_score,
    ROUND(AVG(income_annum),2) AS avg_income,
    ROUND(AVG(loan_amount),2) AS avg_loan_amount,
    COUNT(*) FILTER (WHERE loan_status='Approved') AS approved_loans,
    COUNT(*) FILTER (WHERE loan_status='Rejected') AS rejected_loans
FROM loan_applications;
