-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 07_loan_approval_analysis.sql
-- Description: Loan Approval Pattern Analysis
-- =====================================================

---------------------------------------------------------
-- 1. Approval Rate by Education
---------------------------------------------------------

SELECT
    education,
    COUNT(*) AS total_applications,
    COUNT(*) FILTER (WHERE loan_status = 'Approved') AS approved_loans,
    ROUND(
        COUNT(*) FILTER (WHERE loan_status = 'Approved') * 100.0 /
        COUNT(*),
        2
    ) AS approval_rate
FROM loan_applications
GROUP BY education
ORDER BY approval_rate DESC;

---------------------------------------------------------
-- 2. Approval Rate by Employment Type
---------------------------------------------------------

SELECT
    self_employed,
    COUNT(*) AS total_applications,
    COUNT(*) FILTER (WHERE loan_status='Approved') AS approved_loans,
    ROUND(
        COUNT(*) FILTER (WHERE loan_status='Approved') *100.0/
        COUNT(*),
        2
    ) AS approval_rate
FROM loan_applications
GROUP BY self_employed;

---------------------------------------------------------
-- 3. Approval Rate by Number of Dependents
---------------------------------------------------------

SELECT
    no_of_dependents,
    COUNT(*) AS total_applications,
    COUNT(*) FILTER (WHERE loan_status='Approved') AS approved_loans,
    ROUND(
        COUNT(*) FILTER (WHERE loan_status='Approved')*100.0/
        COUNT(*),
        2
    ) AS approval_rate
FROM loan_applications
GROUP BY no_of_dependents
ORDER BY no_of_dependents;

---------------------------------------------------------
-- 4. Approval Rate by Loan Term
---------------------------------------------------------

SELECT
    loan_term,
    COUNT(*) AS total_applications,
    COUNT(*) FILTER (WHERE loan_status='Approved') AS approved_loans,
    ROUND(
        COUNT(*) FILTER (WHERE loan_status='Approved')*100.0/
        COUNT(*),
        2
    ) AS approval_rate
FROM loan_applications
GROUP BY loan_term
ORDER BY loan_term;

---------------------------------------------------------
-- 5. Approval Rate by CIBIL Score Band
---------------------------------------------------------

SELECT
CASE
    WHEN cibil_score BETWEEN 300 AND 499 THEN '300-499'
    WHEN cibil_score BETWEEN 500 AND 599 THEN '500-599'
    WHEN cibil_score BETWEEN 600 AND 699 THEN '600-699'
    WHEN cibil_score BETWEEN 700 AND 799 THEN '700-799'
    ELSE '800-900'
END AS cibil_band,

COUNT(*) AS total_applications,

COUNT(*) FILTER
(
WHERE loan_status='Approved'
) AS approved_loans,

ROUND(
COUNT(*) FILTER
(
WHERE loan_status='Approved'
)*100.0/
COUNT(*),
2
) AS approval_rate

FROM loan_applications

GROUP BY cibil_band

ORDER BY cibil_band;

---------------------------------------------------------
-- 6. Approval Rate by Income Band
---------------------------------------------------------

SELECT

CASE

WHEN income_annum <5000000 THEN 'Below 50L'

WHEN income_annum BETWEEN 5000000 AND 10000000 THEN '50L-1Cr'

WHEN income_annum BETWEEN 10000001 AND 20000000 THEN '1Cr-2Cr'

ELSE 'Above 2Cr'

END AS income_band,

COUNT(*) AS total_applications,

COUNT(*) FILTER
(
WHERE loan_status='Approved'
) AS approved_loans,

ROUND(

COUNT(*) FILTER
(
WHERE loan_status='Approved'
)*100.0/
COUNT(*),
2

) AS approval_rate

FROM loan_applications

GROUP BY income_band

ORDER BY approval_rate DESC;

---------------------------------------------------------
-- 7. Customers Eligible for Manual Review
---------------------------------------------------------

SELECT

loan_id,

income_annum,

loan_amount,

cibil_score,

loan_status

FROM loan_applications

WHERE

loan_status='Rejected'

AND income_annum >
(
SELECT AVG(income_annum)
FROM loan_applications
)

AND cibil_score >=700

ORDER BY income_annum DESC;

---------------------------------------------------------
-- 8. Top 10 Highest Approved Loans
---------------------------------------------------------

SELECT

loan_id,

loan_amount,

income_annum,

cibil_score

FROM loan_applications

WHERE loan_status='Approved'

ORDER BY loan_amount DESC

LIMIT 10;

---------------------------------------------------------
-- 9. Average Loan Amount by Approval Status
---------------------------------------------------------

SELECT

loan_status,

ROUND(AVG(loan_amount),2) AS avg_loan_amount,

ROUND(AVG(income_annum),2) AS avg_income,

ROUND(AVG(cibil_score),2) AS avg_cibil

FROM loan_applications

GROUP BY loan_status;

---------------------------------------------------------
-- 10. Executive Approval Summary
---------------------------------------------------------

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

) AS approval_rate;
