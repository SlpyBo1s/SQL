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

/*
Question : What skills are associated with the top paying data science jobs?
*/

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



/*

Based on the Top 10 Most In-Demand Skills, we can identify the core competencies required for top-tier Data Scientist roles:
- SQL (7 occurrences): Ranks as the absolute number one most requested skill. This proves that the fundamental ability to extract and manipulate data from relational databases remains crucial.
- Python (6 occurrences): The de facto programming language for Data Science takes the solid second spot.
- Java & Spark (5 occurrences each): Indicates that top-level roles frequently require Big Data capabilities (Spark) and robust, object-oriented programming (Java) to deploy machine learning models into production.
- Tableau (4 occurrences): The most highly demanded data visualization tool, emphasizing the need to communicate insights effectively to business stakeholders.

*/