import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors

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

# Create a dictionary to map the skills to their respective categories
skill_category = {
    'TypeScript': 'Programming Languages',
    'Python': 'Programming Languages',
    'SQL': 'Programming Languages',
    'VBA': 'Programming Languages',
    'Spark': 'Big Data Technologies',
    'Hadoop': 'Big Data Technologies',
    'Azure': 'Cloud Computing',
    'Databricks': 'Data Processing and Analytics Platforms',
    'SAP': 'Data Processing and Analytics Platforms',
    'Tableau': 'Data Processing and Analytics Platforms',
    'SAS': 'Data Processing and Analytics Platforms',
    'SPSS': 'Data Processing and Analytics Platforms',
    'Power BI': 'Data Processing and Analytics Platforms',
    'Express': 'Web Development',
    'Excel': 'Office Productivity Tools',
    'Word': 'Office Productivity Tools',
    'Outlook': 'Office Productivity Tools',
    'PowerPoint': 'Office Productivity Tools'
}

# Ensure all skills in the DataFrame are in the skill_category mapping
missing_skills = set(df['skills']) - set(skill_category.keys())
if missing_skills:
    print(f"The following skills are not in the skill_category mapping and will be marked as 'Unknown': {missing_skills}")

# Map the skills to their respective categories
df['category'] = df['skills'].map(lambda x: skill_category.get(x, 'Unknown'))

# Create a color map for the categories, including a color for 'Unknown'
category_colors = {
    'Programming Languages': 'blue',
    'Big Data Technologies': 'green',
    'Cloud Computing': 'red',
    'Data Processing and Analytics Platforms': 'purple',
    'Web Development': 'orange',
    'Office Productivity Tools': 'yellow',
    'Data Visualization Tools': 'pink',
    'Unknown': 'grey'  # Adding a color for unknown categories
}

# Ensure all skills in the DataFrame are in the skill_category mapping
missing_skills = set(df['skills']) - set(skill_category.keys())
if missing_skills:
    print(f"The following skills are not in the skill_category mapping and will be marked as 'Unknown': {missing_skills}")

# Map the skills to their respective categories
df['category'] = df['skills'].map(lambda x: skill_category.get(x, 'Unknown'))

# Generate a list of colors for each skill
colors = list(mcolors.TABLEAU_COLORS.values()) + list(mcolors.CSS4_COLORS.values())
color_map = {skill: colors[i % len(colors)] for i, skill in enumerate(df['skills'])}

# Create a pie chart to visualize the distribution of the top paying skills
plt.figure(figsize=(10, 10))
plt.pie(df['avg_salary'], labels=df['skills'], colors=[color_map[skill] for skill in df['skills']], autopct='%1.1f%%')
plt.title('Distribution of Top Paying Skills')
plt.show()