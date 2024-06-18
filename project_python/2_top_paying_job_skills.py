import os
from dotenv import load_dotenv
import pandas as pd
import matplotlib.pyplot as plt
from sqlalchemy import create_engine

# Load environment variables
load_dotenv(dotenv_path='e:/VS Code Projects/SQL_Project_Data_Jobs_Analysis/project_python/.env')

# Get the environment variables
db_user = os.getenv('DB_USER')
db_pass = os.getenv('DB_PASS')
db_host = os.getenv('DB_HOST')
db_port = os.getenv('DB_PORT')
db_name = os.getenv('DB_NAME')

# Establish a connection to the database
engine = create_engine(f"postgresql://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}")

# Define your SQL query
sql_query = """
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
"""

# Execute the query and fetch the result into a pandas DataFrame
df = pd.read_sql_query(sql_query, engine)

# Plot the data

plt.figure(figsize=(10, 6))
plt.barh(df['skills'], df['salary_year_avg'])
plt.xlabel('Average Salary')
plt.ylabel('Skills')
plt.title('Top Skills for Top-Paying Jobs')
plt.show()
