/*
    --What are the top 10 in demand skills for remote Data Engineers?--
    
    
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE
    job_work_from_home = TRUE
    AND job_title_short = 'Data Engineer'
GROUP BY
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 10;

/*
    Result:

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns


Key Takeaways:
-   SQL and Python remain the fundemental skill for Data Engineers
-   In modern Data Engineering Cloud platforms (AWS, Azure) have become critical
-   Big data tool like spark continure to be relevant 
-   Data pipeline tools (Airflow, Snowflake, and Databricks) show a high demand
-   Java and GCP end our top demanded skills for Data Engineers
*/