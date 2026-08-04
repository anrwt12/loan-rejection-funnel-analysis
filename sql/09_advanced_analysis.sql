-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 09_advanced_analysis.sql
-- Description: Advanced SQL Analysis using CTEs,
-- Window Functions, Ranking & Business Insights
-- =====================================================

---------------------------------------------------------
-- 1. Rank Applicants by CIBIL Score
---------------------------------------------------------

SELECT
    loan_id,
    cibil_score,
    RANK() OVER(ORDER BY cibil_score DESC) AS cibil_rank
FROM loan_applications;

---------------------------------------------------------
-- 2. Top 10 Highest Income Applicants
---------------------------------------------------------

SELECT
    loan_id,
    income_annum,
    DENSE_RANK() OVER(ORDER BY income_annum DESC) AS income_rank
FROM loan_applications
LIMIT 10;

---------------------------------------------------------
-- 3. Loan Amount Ranking within Loan Status
---------------------------------------------------------

SELECT
    loan_id,
    loan_status,
    loan_amount,
    ROW_NUMBER() OVER(
        PARTITION BY loan_status
        ORDER BY loan_amount DESC
    ) AS loan_rank
FROM loan_applications;

---------------------------------------------------------
-- 4. Average Loan Amount by CIBIL Score Band
---------------------------------------------------------

WITH cibil_groups AS
(
SELECT *,
CASE
WHEN cibil_score>=750 THEN 'Excellent'
WHEN cibil_score BETWEEN 650 AND 749 THEN 'Good'
ELSE 'Poor'
END AS cibil_band
FROM loan_applications
)

SELECT
cibil_band,
ROUND(AVG(loan_amount),2) AS avg_loan
FROM cibil_groups
GROUP BY cibil_band;

---------------------------------------------------------
-- 5. Running Total of Loan Amount
---------------------------------------------------------

SELECT

loan_id,

loan_amount,

SUM(loan_amount)
OVER(
ORDER BY loan_amount
) AS running_total

FROM loan_applications;

---------------------------------------------------------
-- 6. Percent Contribution of Each Loan
---------------------------------------------------------

SELECT

loan_id,

loan_amount,

ROUND(

loan_amount*100.0/
SUM(loan_amount) OVER(),

2

) AS contribution_percentage

FROM loan_applications;

---------------------------------------------------------
-- 7. Quartile Analysis using NTILE
---------------------------------------------------------

SELECT

loan_id,

income_annum,

NTILE(4)
OVER(
ORDER BY income_annum
) AS income_quartile

FROM loan_applications;

---------------------------------------------------------
-- 8. Highest Loan in Each Education Group
---------------------------------------------------------

WITH ranked_loans AS
(
SELECT
loan_id,
education,
loan_amount,

ROW_NUMBER()
OVER(
PARTITION BY education
ORDER BY loan_amount DESC
) AS rn

FROM loan_applications
)

SELECT *

FROM ranked_loans

WHERE rn=1;

---------------------------------------------------------
-- 9. Compare Applicant with Overall Average
---------------------------------------------------------

SELECT

loan_id,

income_annum,

loan_amount,

ROUND(
AVG(income_annum)
OVER(),
2
) AS overall_avg_income,

CASE

WHEN income_annum >
AVG(income_annum)
OVER()

THEN 'Above Average'

ELSE 'Below Average'

END AS income_category

FROM loan_applications;

---------------------------------------------------------
-- 10. Top 5 Customers by Asset Value
---------------------------------------------------------

WITH assets AS
(
SELECT

loan_id,

residential_assets_value+
commercial_assets_value+
luxury_assets_value+
bank_asset_value AS total_assets

FROM loan_applications
)

SELECT *

FROM assets

ORDER BY total_assets DESC

LIMIT 5;
