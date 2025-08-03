/* 
===============================================================
📁 AI-Remote-Jobs-SQL-Project - Queries.sql
🧠 Purpose: SQL Queries from Basic to Advanced for analysis of 
            remote AI jobs (from Kaggle dataset)
📊 Skills Showcased: Joins, Aggregations, CTEs, Window Functions
===============================================================
*/


-- =======================
-- 📌 BASIC SQL QUERIES
-- =======================

-- 🔍 1. View all remote jobs
-- This is a basic check to go through data.
SELECT * FROM remote_jobs;

-- 🔍 2. Filter jobs in AI category
--helps to identify the trendy and in demand domains
SELECT category, COUNT(*) AS total_jobs
FROM remote_jobs
GROUP BY category
ORDER BY total_jobs DESC;

-- 🔍 3. Jobs posted most recently
-- useful for job seekers or market analyst
SELECT * FROM remote_jobs
ORDER BY date_posted DESC
LIMIT 10;

-- 🔍 4. Remote jobs located in India
-- gives a flexibility idea jobs posted in specific country 
SELECT * FROM remote_jobs
WHERE location ILIKE '%India%';


-- ============================
-- 📌 INTERMEDIATE QUERIES
-- ============================

-- 📊 5. Count of jobs by category

SELECT category, COUNT(*) AS total_jobs
FROM remote_jobs
GROUP BY category
ORDER BY total_jobs DESC;

-- 📊 6. Most active hiring companies
SELECT company, COUNT(*) AS postings
FROM remote_jobs
GROUP BY company
ORDER BY postings DESC
LIMIT 5;

-- 📊 7. Number of jobs per job type
SELECT job_type, COUNT(*) AS total
FROM remote_jobs
GROUP BY job_type
ORDER BY total DESC;

-- 📅 8. Jobs posted in Q1 2025
SELECT * FROM remote_jobs
WHERE date_posted BETWEEN '2025-01-01' AND '2025-03-31';


-- ===========================
-- 📌 ADVANCED SQL QUERIES
-- ===========================

-- 🧮 9. Top 10 most frequent job titles
SELECT title, COUNT(*) AS frequency
FROM remote_jobs
GROUP BY title
ORDER BY frequency DESC
LIMIT 10;

-- 🧠 10. Percentage distribution of job types
SELECT job_type,
       COUNT(*) AS total,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM remote_jobs
GROUP BY job_type;

-- 🧠 11. Top hiring company each month (Window Function)
WITH monthly_hires AS (
  SELECT company,
         DATE_TRUNC('month', date_posted) AS month,
         COUNT(*) AS total,
         RANK() OVER (PARTITION BY DATE_TRUNC('month', date_posted)
                      ORDER BY COUNT(*) DESC) AS rank
  FROM remote_jobs
  GROUP BY company, DATE_TRUNC('month', date_posted)
)
SELECT * FROM monthly_hires
WHERE rank = 1;


-- ==========================
-- 🔥 COMPLEX SQL QUERIES
-- ==========================

-- 🧬 12. Companies with most diverse job roles (by unique titles)
SELECT company, COUNT(DISTINCT title) AS unique_roles
FROM remote_jobs
GROUP BY company
ORDER BY unique_roles DESC
LIMIT 5;

-- 🔎 13. Extract jobs with keywords (AI, ML, NLP, Deep Learning)
SELECT * FROM remote_jobs
WHERE title ~* '(AI|ML|NLP|Deep Learning)';

-- 📈 14. Monthly trend for Data Scientist roles
SELECT DATE_TRUNC('month', date_posted) AS month,
       COUNT(*) AS total_jobs
FROM remote_jobs
WHERE title ILIKE '%Data Scientist%'
GROUP BY month
ORDER BY month;

-- 🧠 15. Top 3 hiring companies with jobs having 'Engineer' in title
SELECT company, COUNT(*) AS engineer_jobs
FROM remote_jobs
WHERE title ILIKE '%Engineer%'
GROUP BY company
ORDER BY engineer_jobs DESC
LIMIT 3;

-- ⚠️ 16. Number of jobs missing salary data
SELECT COUNT(*) AS missing_salary_rows
FROM remote_jobs
WHERE salary IS NULL OR salary = '';


