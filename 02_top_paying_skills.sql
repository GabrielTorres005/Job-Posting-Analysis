/*
    --What are the highest paying skills for Data Engineers?--
    -   Calculate the median salary for each skill required in data engineering
    position
    -   Focus on remote positions with speicfied salaries
    -   Include skill frequency to identify both salary and demand
    -   Why? Help identify which skills command the highest compensation while 
    showing how common those skills are, providing a more complete picture for skill
    development priorities
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count,
    ROUND(MEDIAN(jpf.salary_year_avg),0) AS median_salary
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
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;


/*
Result:
┌────────────┬──────────────┬───────────────┐
│   skills   │ demand_count │ median_salary │
│  varchar   │    int64     │    double     │
├────────────┼──────────────┼───────────────┤
│ rust       │          232 │      210000.0 │
│ terraform  │         3248 │      184000.0 │
│ golang     │          912 │      184000.0 │
│ spring     │          364 │      175500.0 │
│ neo4j      │          277 │      170000.0 │
│ gdpr       │          582 │      169616.0 │
│ zoom       │          127 │      168438.0 │
│ graphql    │          445 │      167500.0 │
│ mongo      │          265 │      162250.0 │
│ fastapi    │          204 │      157500.0 │
│ bitbucket  │          478 │      155000.0 │
│ django     │          265 │      155000.0 │
│ crystal    │          129 │      154224.0 │
│ c          │          444 │      151500.0 │
│ atlassian  │          249 │      151500.0 │
│ typescript │          388 │      151000.0 │
│ kubernetes │         4202 │      150500.0 │
│ css        │          262 │      150000.0 │
│ ruby       │          736 │      150000.0 │
│ node       │          179 │      150000.0 │
│ airflow    │         9996 │      150000.0 │
│ redis      │          605 │      149000.0 │
│ vmware     │          136 │      148798.0 │
│ ansible    │          475 │      148798.0 │
│ jupyter    │          400 │      147500.0 │
└────────────┴──────────────┴───────────────┘
  25 rows                         3 columns

Key Takeaways:
    -   Rust remains the top paying skill in data engineers ($210,000)
    -   Terraform and Golang both have the same median salary at 2nd and 3rd highest paying skill ($184,000)
    -    Airflow leads total demand by a massive margin (9,996 listings)
    -   Cloud and Devops represent over 17,000 listings sohwing great demand for infastrucure automation
    -   Specialized backend, data, and compliance skills such as Spring ($175,500), Neo4j ($170,000), 
    GDPR ($169,616), and GraphQL ($167,500) yield high salaries despite lower listing volume (<600 listings each)
    -   Median salaries across all 25 skills remain high and tightly clustered, ranging from $147,500 (Jupyter) to 
    $210,000 (Rust), with a dataset average of ~$160,465.
*/