-- =====================================================
-- Loan Rejection Funnel Analysis
-- File: 01_schema.sql
-- Description: Database schema for loan applications
-- =====================================================

DROP TABLE IF EXISTS loan_applications;

CREATE TABLE loan_applications (
    loan_id INT PRIMARY KEY,
    no_of_dependents INT,
    education VARCHAR(20),
    self_employed VARCHAR(10),
    income_annum BIGINT,
    loan_amount BIGINT,
    loan_term INT,
    cibil_score INT,
    residential_assets_value BIGINT,
    commercial_assets_value BIGINT,
    luxury_assets_value BIGINT,
    bank_asset_value BIGINT,
    loan_status VARCHAR(20)
);

-- Verify table
SELECT * FROM loan_applications;
