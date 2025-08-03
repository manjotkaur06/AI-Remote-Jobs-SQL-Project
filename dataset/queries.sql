
/* 
====================================================================
📁 AI-Jobs-SQL-Project - queries.sql
🧠 Purpose: Full SQL analysis of remote AI jobs using clean queries
📊 Structure: Basic → Intermediate → Advanced → Complex
💼 Dataset: ai_jobs table from Kaggle
====================================================================
*/


-- =======================
-- 📌 BASIC SQL QUERIES
-- =======================

-- 🔍 1. View all job listings
-- Helps preview the data structure and understand available fields.
SELECT * FROM ai_jobs;

-- 🔍 2. Count total number of jobs
-- A quick metric showing dataset size.
SELECT COUNT(*) AS total_jobs FROM ai_jobs;

-- 🔍 3. List distinct experience levels
-- Useful for filtering later or creating filters in a dashboard.
SELECT DISTINCT experience_level FROM ai_jobs;

-- 🌎 4. Show jobs from United States
-- Analyzing regional hiring trends or targeting location-specific roles.
SELECT * FROM ai_jobs
WHERE company_location = 'United States';

-- 🧪 5. Filter jobs requiring Python skill
-- Shows technical requirements; useful for skill-based job filtering.
SELECT * FROM ai_jobs
WHERE required_skill ILIKE '%Python%';


-- ============================
-- 📌 INTERMEDIATE QUERIES
-- ============================

-- 📊 6. Count of jobs by experience level
-- Understands demand distribution across seniority levels.
SELECT experience_level, COUNT(*) AS total
FROM ai_jobs
GROUP BY experience_level
ORDER BY total DESC;

-- 📊 7. Employment type distribution
-- Reveals job type trends (full-time, contract, part-time).
SELECT employment_type, COUNT(*) AS total
FROM ai_jobs
GROUP BY employment_type;

-- 🌍 8. Top 5 hiring countries
-- Identifies where most remote jobs are being offered from.
SELECT company_location, COUNT(*) AS jobs
FROM ai_jobs
GROUP BY company_location
ORDER BY jobs DESC
LIMIT 5;

-- 🗓️ 9. Jobs posted in the last 30 days
-- Tracks current hiring activity.
SELECT * FROM ai_jobs
WHERE posting_date >= CURRENT_DATE - INTERVAL '30 days';

-- 💼 10. Company-wise average remote ratio
-- Measures how remote-friendly each company is.
SELECT company_name, ROUND(AVG(remote_ratio), 2) AS avg_remote_ratio
FROM ai_jobs
GROUP BY company_name
ORDER BY avg_remote_ratio DESC
LIMIT 10;


-- ===========================
-- 📌 ADVANCED SQL QUERIES
-- ===========================

-- 💸 11. Average salary by experience level
-- Compares compensation across different seniority levels.
SELECT experience_level,
       ROUND(AVG(CAST(salary_usd AS FLOAT)), 2) AS avg_salary
FROM ai_jobs
WHERE salary_usd ~ '^[0-9]+$'
GROUP BY experience_level
ORDER BY avg_salary DESC;

-- 📊 12. Company size percentage distribution
-- Provides insight into whether big or small companies hire more AI roles.
SELECT company_size,
       COUNT(*) AS total,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM ai_jobs
GROUP BY company_size;

-- 📅 13. Monthly job posting trend
-- Tracks hiring spikes or seasonal patterns.
SELECT DATE_TRUNC('month', posting_date) AS month,
       COUNT(*) AS job_count
FROM ai_jobs
GROUP BY month
ORDER BY month;

-- 🏢 14. Top 5 most remote companies
-- Companies with highest average remote ratio.
SELECT company_name, AVG(remote_ratio) AS avg_remote
FROM ai_jobs
GROUP BY company_name
ORDER BY avg_remote DESC
LIMIT 5;

-- 🧠 15. Total jobs mentioning "Python"
-- Useful to assess tech stack trends in AI hiring.
SELECT COUNT(*) AS python_jobs
FROM ai_jobs
WHERE required_skill ILIKE '%python%';


-- ==========================
-- 🔥 COMPLEX SQL QUERIES
-- ==========================

-- 🧬 16. Companies with most diverse job roles
-- Indicates innovation or multi-domain hiring by measuring job title variety.
SELECT company_name, COUNT(DISTINCT job_title) AS unique_titles
FROM ai_jobs
GROUP BY company_name
ORDER BY unique_titles DESC
LIMIT 5;

-- 💰 17. Highest paying companies for senior-level roles
-- Filters by 'Senior' experience and ranks by average salary.
SELECT company_name,
       ROUND(AVG(CAST(salary_usd AS FLOAT)), 2) AS avg_salary
FROM ai_jobs
WHERE experience_level ILIKE '%Senior%'
      AND salary_usd ~ '^[0-9]+$'
GROUP BY company_name
ORDER BY avg_salary DESC
LIMIT 5;

-- 🧪 18. Average remote ratio by industry
-- Evaluates how flexible different AI industries are for remote work.
SELECT industry,
       ROUND(AVG(remote_ratio), 2) AS avg_remote
FROM ai_jobs
GROUP BY industry
ORDER BY avg_remote DESC
LIMIT 10;

-- 🧠 19. Rank top hiring companies per country
-- Uses window function RANK() to rank employers within each country.
SELECT company_location,
       company_name,
       COUNT(*) AS job_count,
       RANK() OVER (PARTITION BY company_location ORDER BY COUNT(*) DESC) AS rank
FROM ai_jobs
GROUP BY company_location, company_name
ORDER BY company_location, rank;

-- 📈 20. Salary trend by quarter for 'Machine Learning' roles
-- Uses CTE to extract quarterly trends for a specific role type.
WITH ml_jobs AS (
  SELECT *, DATE_TRUNC('quarter', posting_date) AS quarter
  FROM ai_jobs
  WHERE job_title ILIKE '%Machine Learning%'
        AND salary_usd ~ '^[0-9]+$'
)
SELECT quarter,
       ROUND(AVG(CAST(salary_usd AS FLOAT)), 2) AS avg_ml_salary
FROM ml_jobs
GROUP BY quarter
ORDER BY quarter;

-- ⚠️ 21. Count of jobs missing key information
-- Tracks data quality by identifying incomplete records.
SELECT COUNT(*) AS incomplete_jobs
FROM ai_jobs
WHERE salary_usd IS NULL 
   OR required_skill IS NULL 
   OR company_location IS NULL;
