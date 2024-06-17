SELECT 
    job_title_short as titile,
    job_location as location,
    job_posted_date at time zone 'UTC' at time zone 'EST',
    EXTRACT(MONTH FROM job_posted_date) as date_month,
    EXTRACT(YEAR FROM job_posted_date) as date_year
FROM 
    job_postings_fact
LIMIT 5;