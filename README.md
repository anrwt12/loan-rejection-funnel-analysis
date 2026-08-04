# 🏦 Loan Rejection Funnel Analysis

> **End-to-End Banking Analytics Project** | PostgreSQL • Python • Power BI

An end-to-end banking analytics project that analyzes loan application data to uncover approval trends, identify high-risk applicants, evaluate lending decisions, and build executive-level dashboards for business decision-making.

---

## 📖 Table of Contents

- Project Overview
- Business Problem
- Objectives
- Dataset
- Tech Stack
- Project Architecture
- Database Schema
- SQL Analysis
- Business Questions Solved
- Executive KPIs
- Power BI Dashboard
- Advanced SQL Concepts
- Project Structure
- Key Business Insights
- Future Enhancements
- Author

---

# 📌 Project Overview

Financial institutions receive thousands of loan applications every month. Approving the right applicants while minimizing financial risk is one of the most critical challenges for banks.

This project simulates a real-world banking analytics workflow by analyzing loan applications to identify:

- Loan approval and rejection patterns
- Customer credit risk
- Lending performance
- Approval bottlenecks
- Executive business KPIs

The analysis was performed using **PostgreSQL** for data processing, **Python** for analysis, and **Power BI** for interactive dashboards.

---

# 🎯 Business Problem

The bank wants to improve its loan approval process by answering questions such as:

- Which customers are most likely to receive loan approval?
- Which factors contribute to loan rejection?
- Are high-quality customers being rejected?
- Which applicants represent the highest financial risk?
- How can approval decisions be optimized?
- Which customer segments should undergo manual review?

---

# 🎯 Project Objectives

- Analyze loan approval and rejection trends.
- Evaluate customer risk using CIBIL score and financial data.
- Build executive KPIs for lending performance.
- Identify approval bottlenecks.
- Segment customers by income, education, and employment.
- Support better lending decisions through data analytics.

---

# 📂 Dataset

**Dataset Name:** Loan Approval Prediction Dataset

The dataset contains loan application information including:

| Category | Features |
|----------|-----------|
| Applicant Information | Loan ID, Dependents, Education, Employment |
| Financial Information | Annual Income, Loan Amount, Loan Term |
| Credit Information | CIBIL Score |
| Assets | Residential, Commercial, Luxury, Bank Assets |
| Target Variable | Loan Status (Approved / Rejected) |

---

# 🛠 Tech Stack

- PostgreSQL
- SQL
- Python
- Pandas
- NumPy
- Power BI
- Git
- GitHub

---

# 🏗 Project Architecture

```
CSV Dataset
      │
      ▼
PostgreSQL Database
      │
      ▼
Data Cleaning
      │
      ▼
Data Quality Checks
      │
      ▼
Business Analysis
      │
      ▼
Executive KPIs
      │
      ▼
Power BI Dashboard
```

---

# 🗄 Database Schema

The project uses a single fact table:

**loan_applications**

Main attributes:

- Loan ID
- Income
- Loan Amount
- Loan Term
- CIBIL Score
- Education
- Employment Status
- Assets
- Loan Status

---

# 📊 SQL Analysis

The SQL analysis consists of **10 structured modules**.

| SQL File | Description |
|----------|-------------|
| 01_schema.sql | Database schema |
| 02_data_import.sql | Import CSV data |
| 03_data_cleaning.sql | Data cleaning |
| 04_data_quality_checks.sql | Data validation |
| 05_loan_funnel_analysis.sql | Loan funnel analysis |
| 06_customer_risk_analysis.sql | Customer risk segmentation |
| 07_loan_approval_analysis.sql | Approval trend analysis |
| 08_business_kpis.sql | Executive KPIs |
| 09_advanced_analysis.sql | CTEs & Window Functions |
| 10_views_and_indexes.sql | Views & Performance Optimization |

---

# 📈 Business Questions Solved

This project answers several real-world banking questions.

### Loan Performance

- What is the overall approval rate?
- What is the rejection rate?
- How many applications are approved?

### Customer Risk

- Which customers are high risk?
- Which rejected customers deserve manual review?
- Which customers have poor CIBIL scores?

### Approval Analysis

- Does education affect approval?
- Does employment status affect approval?
- Which income groups receive the highest approvals?
- Which loan terms are most frequently approved?

### Financial Analysis

- Loan-to-Income Ratio
- Asset Coverage Ratio
- Average Loan Amount
- Average Annual Income

---

# 📊 Executive KPIs

The dashboard tracks:

- Total Loan Applications
- Approved Loans
- Rejected Loans
- Approval Rate
- Rejection Rate
- Average Annual Income
- Average Loan Amount
- Average CIBIL Score
- High-Risk Applicants
- Loan-to-Income Ratio
- Asset Coverage Ratio
- Manual Review Candidates

---

# 📉 Power BI Dashboard

The Power BI dashboard includes:

### Executive Dashboard

- KPI Cards
- Approval Rate
- Rejection Rate
- Total Applications

### Loan Funnel

- Application Funnel
- Approval Funnel
- Rejection Funnel

### Customer Risk

- Risk Categories
- CIBIL Distribution
- Loan-to-Income Ratio

### Approval Analysis

- Education
- Employment
- Income Band
- Loan Term
- Dependents

> Dashboard screenshots will be added after project completion.

---

# 🚀 Advanced SQL Concepts Used

This project demonstrates:

- Common Table Expressions (CTEs)
- Window Functions
- CASE Statements
- Aggregate Functions
- Ranking Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- NTILE()
- Views
- Indexes
- Performance Optimization

---

# 📂 Project Structure

```
loan-rejection-funnel-analysis
│
├── data/
│
├── docs/
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_data_import.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_data_quality_checks.sql
│   ├── 05_loan_funnel_analysis.sql
│   ├── 06_customer_risk_analysis.sql
│   ├── 07_loan_approval_analysis.sql
│   ├── 08_business_kpis.sql
│   ├── 09_advanced_analysis.sql
│   └── 10_views_and_indexes.sql
│
├── powerbi/
├── python/
├── images/
│
└── README.md
```

---

# 💼 Business Impact

This project demonstrates how data analytics can support banking decisions by:

- Improving loan approval strategies
- Identifying high-risk borrowers
- Detecting potential manual review cases
- Monitoring executive lending KPIs
- Supporting data-driven lending decisions

---

# 🔮 Future Enhancements

- Predictive Machine Learning Model
- Loan Default Prediction
- Automated Risk Scoring
- Interactive Power BI Dashboard
- Time-Series Loan Analysis
- Customer Lifetime Value Analysis

---

# 👩‍💻 Author

**Anjali Rawat**

Aspiring Data Analyst

### Skills

- SQL
- PostgreSQL
- Python
- Power BI
- Excel
- Data Analytics

---

## ⭐ If you found this project useful, consider giving it a star.
