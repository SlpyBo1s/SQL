/*
Questions : What are the most optimal skills to learn? (high demand and high salary
- Identify high skills demand and high salary skills for data scientists.
- Concentrate on remote positions with specified salaries
- Why? To guide data scientists in prioritizing skill development for career growth and to help employers understand which skills command the highest compensation in the remote data science job market.
*/


WITH skills_demand AS ( 
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS skill_demand
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Scientist'
        AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id
    ORDER BY 
        skill_demand DESC
    ), 
    average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Scientist'
        AND job_postings_fact.job_work_from_home = TRUE
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
    ORDER BY
        avg_salary DESC
    )

SELECT 
    skills_demand.skills,
    skills_demand.skill_demand,
    average_salary.avg_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
   average_salary.avg_salary DESC,
   skills_demand.skill_demand DESC;