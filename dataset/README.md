# 📊 AI Remote Jobs SQL Project

A complete end-to-end **SQL project** analyzing real-world remote job listings in the **AI/ML industry**, using a dataset sourced from [Kaggle]. This project covers **basic to advanced SQL queries**, database schema design, and **business insights generation** — perfect for showcasing hands-on SQL skills to recruiters.

---

## 🚀 Project Overview

- 🔍 Cleaned, structured, and analyzed job data using SQL
- 📈 Generated insights on top hiring companies, job roles, salaries, and job types
- 💡 Used advanced SQL concepts like **CTEs, Window Functions, Subqueries**
- 📊 Derived practical **business insights** from AI job trends
- ✅ Created a GitHub + LinkedIn-ready data project for portfolios

---

## 🧱 Dataset

- **Source**: [Kaggle Remote Jobs Dataset](https://www.kaggle.com/datasets/bismasajjad/global-ai-job-market-and-salary-trends-2025)
- **File**: `remote_jobs.csv`  
- **Total Records**: ~2,000+
- **Columns Used**: `job_id' , job_title' , 'salary_usd' , 'salary_currency' , 'experience_level' ,'employement_type' , 'company_location' , 'posting_date',
    'company_size','employee_residence','remote_ratio','required_skill' ,'company_name','industry text'

---

## 🗃️ Table Schema

```sql

CREATE TABLE ai_jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_title TEXT,
    salary_usd VARCHAR(255),
    salary_currency VARCHAR(10),
    experience_level VARCHAR(50),
    employment_type VARCHAR(50),
    company_location VARCHAR(100),
    posting_date DATE,
    company_size VARCHAR(50),
    employee_residence VARCHAR(100),
    remote_ratio INT,
    required_skill TEXT ,
    company_name varchar(34),
    industry text
);

