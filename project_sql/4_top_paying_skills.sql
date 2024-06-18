/*
 Question 4: What are the top paying skills in the market base on salary?
 Description: 
 - This script will look at the average salary associated with each skill for Data Analyst.
 - This query is to gain insight on the most financially rewarding skills in Canada for Data Analyst roles.
 */
SELECT skills,
    AVG(salary_year_avg)::numeric(10) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Canada'
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 10;
/*
 The analysis of the top paying skills for data analyst roles in Canada identified TypeScript, Spark, and Hadoop as the most financially rewarding skills. The data was cleaned to remove duplicates and aggregated to calculate the average salary associated with each skill. TypeScript emerged as the most lucrative skill, with an average salary of $108,416. This insight highlights the potential financial benefits of acquiring these skills for data analyst roles in Canada.
 */
/*
 [
 {
 "skills": "typescript",
 "avg_salary": "108416"
 },
 {
 "skills": "spark",
 "avg_salary": "107479"
 },
 {
 "skills": "hadoop",
 "avg_salary": "107167"
 },
 {
 "skills": "azure",
 "avg_salary": "101014"
 },
 {
 "skills": "databricks",
 "avg_salary": "101014"
 },
 {
 "skills": "sap",
 "avg_salary": "99150"
 },
 {
 "skills": "express",
 "avg_salary": "99150"
 },
 {
 "skills": "python",
 "avg_salary": "94302"
 },
 {
 "skills": "tableau",
 "avg_salary": "88550"
 },
 {
 "skills": "sql",
 "avg_salary": "88452"
 }
 ]
 */`