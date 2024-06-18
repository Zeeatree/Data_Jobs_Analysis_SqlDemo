/*
 Question 5: What are the 5 most optimal skills to learn to get a job in the future?
 Description:
 - Identify the skills that are most in demand and also have the highest average salary.
 */
WITH skills_demand As (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) as demand_count
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Canada'
    GROUP BY skills_dim.skill_id
),
average_salary AS (
    SELECT skills_job_dim.skill_id,
        AVG(salary_year_avg)::numeric(10) AS avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Canada'
    GROUP BY skills_job_dim.skill_id
)
SELECT skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM skills_demand
    INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY demand_count DESC,
    avg_salary DESC
LIMIT 5;

/*
    The analysis of the 5 most optimal skills to learn for future job prospects in Canada identified SQL, Python, Excel, Spark and Hadoop as the most in-demand skills with the highest average salary. These skills are essential for data analyst roles and are highly sought after by employers in the Canadian job market. By acquiring these skills, individuals can enhance their employability and increase their earning potential in the data analytics field.
    */

/*
[
  {
    "skills": "sql",
    "demand_count": "9",
    "avg_salary": "88452"
  },
  {
    "skills": "python",
    "demand_count": "8",
    "avg_salary": "94302"
  },
  {
    "skills": "excel",
    "demand_count": "5",
    "avg_salary": "83413"
  },
  {
    "skills": "spark",
    "demand_count": "4",
    "avg_salary": "107479"
  },
  {
    "skills": "hadoop",
    "demand_count": "3",
    "avg_salary": "107167"
  }
]
*/