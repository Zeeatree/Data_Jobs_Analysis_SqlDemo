/* 
 Question 1: What are the top-paying companies for my role?
 Description:    
 - This query will return the top-paying companies for the role of the user.
 - The user will be prompted to enter their role.
 - The query will return the top 10 highest paying companies for the role of the user.
 - The query will only return job postings wil specified salary.
 - The query is to gain insight top paying opportunities for the user's role.
 */
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Canada'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

