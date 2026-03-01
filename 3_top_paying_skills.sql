/*
Questions : What are the top skills based on salary?
- Look at average salary for each skill associated with data science jobs.
- Focuses on skills with specified salary
- Why? It reveals which skills are most financially rewarding,
 guiding job seekers on which skills to prioritize for higher earning potential and helping employers 
 understand which skills command higher salaries in the data science field.
*/

SELECT 
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
    skills_dim.skills 
ORDER BY
    avg_salary DESC
LIMIT 25;

/*
1. Data Governance & Compliance is King
Insight: GDPR ranks #1 with an average salary of $217,738.
Why it matters: This is a massive standout. It shows that companies are willing to pay a massive premium for professionals who understand data privacy laws. Integrating compliance and data governance into data systems is highly lucrative because the cost of failing to comply with GDPR is devastating for enterprises.

2.High-Performance & Niche Languages Command a Premium
Insight: System-level and high-concurrency languages dominate the top spots: Golang/Go (#2 and #13), C (#12), Elixir (#18), Rust (#19), and Julia (#25).
Why it matters: While Python and SQL are the most in-demand (as seen in previous data), specialized backend and high-performance computation languages pay the most. Companies need these for scaling infrastructure, managing distributed systems, and doing heavy scientific/quantitative computing (like Julia).

3.  Specialized Databases Over Traditional Relational DBs
Insight: Among databases, specialized NoSQL and Graph databases lead the pack: Neo4j (Graph - #6), DynamoDB (NoSQL - #8), Redis (In-memory - #16), and Cassandra (Wide-column - #20).
Why it matters: High salaries here point to a trend of companies dealing with massive-scale distributed data, real-time analytics, and complex relationship mapping (fraud detection, recommendation engines) where traditional SQL databases struggle.

4. Enterprise BI & Orchestration Tools Pay Well
Insight: Enterprise Business Intelligence tools like MicroStrategy (#7), Qlik (#15), and Looker (#21) sit alongside data orchestration tools like Airflow (#24).
Why it matters: Skills that help companies automate data pipelines (Airflow) and securely visualize that data for C-level executives (Microstrategy, Looker) are highly valued.

5. Niche AI/ML Tooling & Web3
Insight: OpenCV (#5 - Computer Vision), DataRobot (#14 - AutoML), Watson (#17 - Enterprise AI), and Solidity (#11 - Blockchain/Web3) are highly ranked.
Why it matters: Building standard Machine Learning models is becoming commoditized. However, highly specific applications—like deploying computer vision systems, managing automated enterprise AI environments, or writing smart contracts—remain scarce and therefore highly paid.
*/