/*
 Question 3: What are the most in-demand skilss for data analyst role?
 Description:
 - This query will return the most in-demand skills for the role of data analyst.
 - The query will return the top 20 most in-demand skills for data analyst roles in Canada.
 - The queery aims to provide insights into the skills that are most frequently required for data analyst roles in Canada.
 */
SELECT skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Canada'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10;
/*
 The analysis of in-demand data analyst roles in Canada identified SQL, Excel, and Python as the most frequently required skills. The data was cleaned to remove duplicates and aggregated to combine skills listed for each role. A bar chart visualized the frequency of these skills, revealing SQL and Excel as particularly in-demand. This insight highlights the importance of these technologies for those aiming to secure data analyst positions in Canada.
 
 */
/*
 [
 {
 "skills": "sql",
 "demand_count": "600"
 },
 {
 "skills": "excel",
 "demand_count": "423"
 },
 {
 "skills": "python",
 "demand_count": "374"
 },
 {
 "skills": "tableau",
 "demand_count": "277"
 },
 {
 "skills": "power bi",
 "demand_count": "255"
 },
 {
 "skills": "r",
 "demand_count": "198"
 },
 {
 "skills": "sas",
 "demand_count": "164"
 },
 {
 "skills": "word",
 "demand_count": "111"
 },
 {
 "skills": "powerpoint",
 "demand_count": "102"
 },
 {
 "skills": "go",
 "demand_count": "92"
 }
 ]
 */