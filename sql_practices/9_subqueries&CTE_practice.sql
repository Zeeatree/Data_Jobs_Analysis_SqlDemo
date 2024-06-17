/*
 Find the count of the number of job postings per skill
 - display the top 5 skills by their demand in remote jobs
 - include skill ID, name, and count of postings requiring the skill
 */
-- CTE to find the count of the number of job postings per skill
WITH remote_job_skills AS (
    SELECT skill_id,
        COUNT(*) as skill_count
    FROM skills_job_dim AS skills_to_job
        INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE job_postings.job_work_from_home = TRUE AND job_postings.job_title_short = 'Data Scientist'
    GROUP BY skill_id
)
SELECT skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
    INNER JOIN skills_dim AS skills ON remote_job_skills.skill_id = skills.skill_id
ORDER BY skill_count DESC
LIMIT 10;