/*
 CTE (Common Table Expression) is a temporary result set that 
 you can reference within a SELECT, INSERT, UPDATE, or DELETE 
 statement.
 CTEs are defined using the WITH keyword.
 CTEs are useful for:
 - Breaking down complex queries into simpler parts
 - Improving readability
 - Reusing the same query multiple times
 - Recursive queries
 */
WITH company_job_count as (
    SELECT company_id,
        COUNT(*) as total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name as company_name,
    company_job_count.total_jobs
FROM company_dim
    LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY total_jobs DESC