/*
    Data Scope: July 2024 Onwards (Full-Time Professional Role Benchmark)
    Sample Size: 1,615,930 Job Listings Analyzed
    Objective: Evaluate technical skills by balancing market availability (demand) against earning potential 
    (median full-time salary).
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)),1) AS log_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/ 1000000,2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_posted_date >= '2024-07-01 00:00:00'
GROUP BY
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    optimal_score DESC
LIMIT 25;

/*
Result:
┌────────────┬───────────────┬──────────────┬──────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ log_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │      double      │    double     │
├────────────┼───────────────┼──────────────┼──────────────────┼───────────────┤
│ python     │      132000.0 │         9614 │              9.2 │          1.21 │
│ aws        │      142419.0 │         3957 │              8.3 │          1.18 │
│ spark      │      146500.0 │         2805 │              7.9 │          1.16 │
│ sql        │      124350.0 │         9810 │              9.2 │          1.14 │
│ kafka      │      157500.0 │         1434 │              7.3 │          1.14 │
│ scala      │      152500.0 │         1540 │              7.3 │          1.12 │
│ snowflake  │      142560.0 │         2379 │              7.8 │          1.11 │
│ azure      │      135000.0 │         3360 │              8.1 │           1.1 │
│ hadoop     │      150000.0 │         1512 │              7.3 │           1.1 │
│ airflow    │      155000.0 │         1116 │              7.0 │          1.09 │
│ java       │      140000.0 │         2276 │              7.7 │          1.08 │
│ kubernetes │      157500.0 │          964 │              6.9 │          1.08 │
│ mongo      │      207000.0 │          177 │              5.2 │          1.07 │
│ redshift   │      147004.0 │         1265 │              7.1 │          1.05 │
│ pytorch    │      157590.0 │          725 │              6.6 │          1.04 │
│ tensorflow │      150000.0 │          971 │              6.9 │          1.03 │
│ r          │      125000.0 │         3450 │              8.1 │          1.02 │
│ gcp        │      139000.0 │         1405 │              7.2 │          1.01 │
│ databricks │      135000.0 │         1781 │              7.5 │          1.01 │
│ nosql      │      137300.0 │         1324 │              7.2 │          0.99 │
│ go         │      141810.0 │          956 │              6.9 │          0.97 │
│ tableau    │      116100.0 │         3717 │              8.2 │          0.95 │
│ terraform  │      150000.0 │          516 │              6.2 │          0.94 │
│ cassandra  │      154500.0 │          416 │              6.0 │          0.93 │
│ github     │      139500.0 │          796 │              6.7 │          0.93 │
└────────────┴───────────────┴──────────────┴──────────────────┴───────────────┘
  25 rows                                                            5 columns

Key takeaways:
    - Python & AWS: Python (1.21) claims the top overall position: massive job availability (9,614 postings) paired with 
        a solid $132,000 median salary makes it the single highest-yielding skill investment. AWS (1.18) leads all cloud platforms, 
        outperforming Azure (1.10) and GCP (1.01) in both volume (3,957) and compensation ($142,419).
    - Distributed Computing & Real-Time Data Command: Data engineering frameworks—Spark (1.16), Kafka (1.14), Scala (1.12), and 
        Airflow (1.09)—consistently command $145,000–$157,500 median salaries. Kafka ($157,500) and Scala ($152,500) achieve top-tier 
        scores despite lower overall volume, proving that streaming and pipeline orchestration skills yield significant compensation leverage.
    - SQL & Visualization: SQL boasts the highest absolute market demand (9,810), but its lower median salary ($124,350) keeps its optimal score 
        at 1.14. It remains an essential gateway skill that requires pairing with cloud/engineering tools for top pay. Tableau (0.95) shows high demand
        (3,717) but records the lowest median salary ($116,100) in the dataset, demonstrating that pure BI/dashboarding skills hit compensation ceilings 
        earlier than core engineering tools.
*/