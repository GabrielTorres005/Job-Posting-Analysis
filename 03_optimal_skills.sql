/*
    --What are the top 10 most optimal skills for remote Data Engineeers in both demand and salary?--
    -   Create a ranking column that combines demand count and median salary to identify the most valuable skills.
    -   Focus only on remote Data Engineer positions with specified annual salaries
    -   Why?
        -   This approach highlights skills that balance market demand and financial rewward. It weights core skills appropriately

*/


SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)),1) AS log_demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/ 1000000,2) AS ranking_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE
    job_work_from_home = TRUE
    AND job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    ranking_score DESC
LIMIT 25;


/*
Result:
┌────────────┬──────────────┬──────────────────┬───────────────┬───────────────┐
│   skills   │ demand_count │ log_demand_count │ median_salary │ ranking_score │
│  varchar   │    int64     │      double      │    double     │    double     │
├────────────┼──────────────┼──────────────────┼───────────────┼───────────────┤
│ terraform  │          193 │              5.3 │      184000.0 │          0.97 │
│ python     │         1133 │              7.0 │      135000.0 │          0.95 │
│ aws        │          783 │              6.7 │      137320.0 │          0.91 │
│ sql        │         1128 │              7.0 │      130000.0 │          0.91 │
│ airflow    │          386 │              6.0 │      150000.0 │          0.89 │
│ spark      │          503 │              6.2 │      140000.0 │          0.87 │
│ kafka      │          292 │              5.7 │      145000.0 │          0.82 │
│ snowflake  │          438 │              6.1 │      135500.0 │          0.82 │
│ azure      │          475 │              6.2 │      128000.0 │          0.79 │
│ java       │          303 │              5.7 │      135000.0 │          0.77 │
│ scala      │          247 │              5.5 │      137290.0 │          0.76 │
│ kubernetes │          147 │              5.0 │      150500.0 │          0.75 │
│ git        │          208 │              5.3 │      140000.0 │          0.75 │
│ databricks │          266 │              5.6 │      132750.0 │          0.74 │
│ redshift   │          274 │              5.6 │      130000.0 │          0.73 │
│ gcp        │          196 │              5.3 │      136000.0 │          0.72 │
│ hadoop     │          198 │              5.3 │      135000.0 │          0.71 │
│ nosql      │          193 │              5.3 │      134415.0 │          0.71 │
│ pyspark    │          152 │              5.0 │      140000.0 │           0.7 │
│ mongodb    │          136 │              4.9 │      135750.0 │          0.67 │
│ docker     │          144 │              5.0 │      135000.0 │          0.67 │
│ go         │          113 │              4.7 │      140000.0 │          0.66 │
│ r          │          133 │              4.9 │      134775.0 │          0.66 │
│ github     │          127 │              4.8 │      135000.0 │          0.65 │
│ bigquery   │          123 │              4.8 │      135000.0 │          0.65 │
└────────────┴──────────────┴──────────────────┴───────────────┴───────────────┘
  25 rows                                                            5 columns

Key takeaways:
-   Terraform Claims #1 Overall: Despite modest demand (193 listings), Terraform's outlier salary of $184,000 
gives it the highest ranking score (0.97)
-   Python & SQL Define Market Baseline: Python (1,133 listings) and SQL (1,128 listings) dominate overall demand 
volume by a wide margin.
-   Data Orchestration Commands a Premium: Infrastructure and streaming technologies—such as Airflow ($150,000), 
Kubernetes ($150,500), and Kafka ($145,000) command a $10,000–$20,000 salary premium over core programming languages.
-   AWS Leads Cloud Platforms: AWS (783 listings, 0.91 score) outperforms Azure (475 listings, 0.79 score) and GCP (196 listings, 0.72 score) 
combined in volume, while also offering the highest cloud median salary ($137,320).
-   Specialized Languages Outpay High-Volume Ones: Go ($140,000) and Scala ($137,290) pay higher median salaries than Python ($135,000) and Java ($135,000), 
reflecting a supply shortage premium for niche systems and data engineering languages.
*/