import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt

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
    AVG(salary_year_avg)::numeric(10) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Canada'
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 20;
"""

# Execute the query and fetch the result into a pandas DataFrame
df = pd.read_sql_query(sql_query, engine)

# Define your data
data = [
    {"skills": "sql", "demand_count": 9, "avg_salary": 88452},
    {"skills": "python", "demand_count": 8, "avg_salary": 94302},
    {"skills": "excel", "demand_count": 5, "avg_salary": 83413},
    {"skills": "spark", "demand_count": 4, "avg_salary": 107479},
    {"skills": "hadoop", "demand_count": 3, "avg_salary": 107167}
]

# Convert the data to a pandas DataFrame
df = pd.DataFrame(data)

# Create a figure and a set of subplots
fig, ax1 = plt.subplots()

# Create a bar chart for the demand count
ax1.bar(df['skills'], df['demand_count'], color='b', alpha=0.5)
ax1.set_xlabel('Skills')
ax1.set_ylabel('Demand Count', color='b')
ax1.tick_params('y', colors='b')

# Create a second y-axis for the average salary
ax2 = ax1.twinx()
ax2.plot(df['skills'], df['avg_salary'], color='r', marker='o')
ax2.set_ylabel('Average Salary', color='r')
ax2.tick_params('y', colors='r')

# Set the title of the chart
plt.title('Demand Count and Average Salary for Top Skills')

# Show the chart
plt.show()