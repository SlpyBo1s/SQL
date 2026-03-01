/* 
1. What are top paying jobs for my role? What skills are associated with the top paying jobs?
2. What are the most in-demand skills for my role?
3. What are the top skills based on salary for my role?
4. What are the most optimal skills for my role?    
*Optimal = High demand and high salary
*/

SELECT 
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
    skills_dim.skills
ORDER BY 
    skill_demand DESC
LIMIT 5;


