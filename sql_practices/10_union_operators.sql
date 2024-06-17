-- Union Operator 
-- The UNION operator is used to combine the result-set of two or more SELECT statements.
-- Each SELECT statement within UNION must have the same number of columns
-- UNION ALL
-- The UNION ALL operator is used to combine the result-set of two or more SELECT statements.
-- The difference between UNION and UNION ALL is that UNION ALL will not remove duplicate rows.
-- UNION and UNION ALL examples
SELECT quater1_job_postings.job_title_short,
    quater1_job_postings.job_location,
    quater1_job_postings.job_via,
    quater1_job_postings.job_posted_date::DATE,
    quater1_job_postings.salary_year_avg
FROM (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM feburary_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    ) AS quater1_job_postings
WHERE quater1_job_postings.salary_year_avg > 70000
    AND quater1_job_postings.job_title_short = 'Data Analyst'
ORDER BY quater1_job_postings.salary_year_avg DESC;