/*
Question : What are the top paying data science jobs?
- Identify the top paying data science jobs based on average salary.
- Focus on job postings with specified salaries.
- Why? Highlight top paying roles to guide job seekers in 
their career choices and help employers understand competitive 
compensation trends in the data science field.
*/


-- Identify the top 10 paying data science jobs based on average yearly salary.
WITH top_paying_jobs AS (
    SELECT 
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        company_dim.name AS company_name,
        salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_postings_fact.job_title LIKE '%Data Scientist%'
        AND job_postings_fact.job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10)


-- Skill needed for the top paying data science jobs
SELECT 
    top_paying_jobs.job_title,
    top_paying_jobs.company_name,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills
FROM 
    top_paying_jobs
-- INNER JOIN to get the skills associated with the top paying jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;