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
"""

# Execute the query and fetch the result into a pandas DataFrame
df = pd.read_sql_query(sql_query, engine)

# Plot the data

plt.figure(figsize=(10, 6))
plt.pie(df['demand_count'], labels=df['skills'], autopct='%1.1f%%')
plt.title('Most In-Demand Skills for Data Analyst Jobs in Canada')
plt.show()
