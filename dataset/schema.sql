#The table schema 

     --------

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
