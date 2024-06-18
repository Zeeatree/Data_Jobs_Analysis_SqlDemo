/*
 Question 2: What are the top skills for the top-paying jobs?
 Description:
 - This query will return the top skills for the top-paying jobs for the role of the user.
 - 
 */
WITH top_paying_jobs As (
    SELECT job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Canada'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
)
SELECT top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 20;
/*
 The analysis of high-paying data analyst roles in Canada identified SQL, Python, Spark, and Hadoop as the most frequently required skills. The data was cleaned to remove duplicates and aggregated to combine skills listed for each role. A bar chart visualized the frequency of these skills, revealing SQL and Python as particularly in-demand. This insight highlights the importance of these technologies for those aiming to secure top-paying data analyst positions in Canada.
 */
/*
 [
 {
 "job_id": 205303,
 "job_title": "Data Analyst, Risk User Experience",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "sql"
 },
 {
 "job_id": 205303,
 "job_title": "Data Analyst, Risk User Experience",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "python"
 },
 {
 "job_id": 205303,
 "job_title": "Data Analyst, Risk User Experience",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "spark"
 },
 {
 "job_id": 205303,
 "job_title": "Data Analyst, Risk User Experience",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "hadoop"
 },
 {
 "job_id": 1180796,
 "job_title": "Data Analyst, Growth",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "sql"
 },
 {
 "job_id": 1180796,
 "job_title": "Data Analyst, Growth",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "python"
 },
 {
 "job_id": 1180796,
 "job_title": "Data Analyst, Growth",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "spark"
 },
 {
 "job_id": 1180796,
 "job_title": "Data Analyst, Growth",
 "salary_year_avg": "111175.0",
 "company_name": "Stripe",
 "skills": "hadoop"
 },
 {
 "job_id": 409209,
 "job_title": "Data Analyst (VBA, Tableau)",
 "salary_year_avg": "109000.0",
 "company_name": "Sun Life",
 "skills": "sql"
 },
 {
 "job_id": 409209,
 "job_title": "Data Analyst (VBA, Tableau)",
 "salary_year_avg": "109000.0",
 "company_name": "Sun Life",
 "skills": "python"
 },
 {
 "job_id": 409209,
 "job_title": "Data Analyst (VBA, Tableau)",
 "salary_year_avg": "109000.0",
 "company_name": "Sun Life",
 "skills": "vba"
 },
 {
 "job_id": 409209,
 "job_title": "Data Analyst (VBA, Tableau)",
 "salary_year_avg": "109000.0",
 "company_name": "Sun Life",
 "skills": "excel"
 },
 {
 "job_id": 409209,
 "job_title": "Data Analyst (VBA, Tableau)",
 "salary_year_avg": "109000.0",
 "company_name": "Sun Life",
 "skills": "tableau"
 },
 {
 "job_id": 629221,
 "job_title": "Analytics Engineering Lead",
 "salary_year_avg": "108415.5",
 "company_name": "Swiss Re",
 "skills": "python"
 },
 {
 "job_id": 629221,
 "job_title": "Analytics Engineering Lead",
 "salary_year_avg": "108415.5",
 "company_name": "Swiss Re",
 "skills": "typescript"
 },
 {
 "job_id": 629221,
 "job_title": "Analytics Engineering Lead",
 "salary_year_avg": "108415.5",
 "company_name": "Swiss Re",
 "skills": "spark"
 },
 {
 "job_id": 1232872,
 "job_title": "Analytics Lab Architect",
 "salary_year_avg": "101014.0",
 "company_name": "Swiss Re",
 "skills": "azure"
 },
 {
 "job_id": 1232872,
 "job_title": "Analytics Lab Architect",
 "salary_year_avg": "101014.0",
 "company_name": "Swiss Re",
 "skills": "databricks"
 },
 {
 "job_id": 973984,
 "job_title": "Data Analyst - HoYolab and Content Creator",
 "salary_year_avg": "100500.0",
 "company_name": "HoYoverse",
 "skills": "sql"
 },
 {
 "job_id": 973984,
 "job_title": "Data Analyst - HoYolab and Content Creator",
 "salary_year_avg": "100500.0",
 "company_name": "HoYoverse",
 "skills": "excel"
 }
 ]
 */