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
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND job_location = 'Canada'
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
"""

# Execute the query and fetch the result into a pandas DataFrame
df = pd.read_sql_query(sql_query, engine)

# Plot the data
plt.figure(figsize=(10, 6))
colors = ['blue', 'green', 'red', 'orange', 'purple', 'yellow', 'pink', 'brown', 'gray', 'cyan']
plt.barh(df['company_name'], df['salary_year_avg'], color=colors, edgecolor='black')
plt.xlabel('Average Salary')
plt.ylabel('Company')
plt.title('Top Paying Companies for Data Analysts in Canada')
plt.gca().invert_yaxis()
plt.show()