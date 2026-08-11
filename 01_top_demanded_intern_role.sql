/*
    Data Scope: July 2024 - May 2025 (Summer 2025 Internship Cycle)
    Sample Size: 1,615,930 Job Listings Analyzed
    Objective: Evaluate demand volume across entry-level/intern data and tech roles.  
*/

SELECT
  job_title_short AS internship_role,
  COUNT(*) AS demand_count
FROM job_postings_fact
WHERE 
  (job_title LIKE '%intern%' OR job_title LIKE '%Intern%')
  AND (job_posted_date >= '2024-07-01 00:00:00' AND job_posted_date <= '2025-05-31 23:59:00')
  AND (job_title_short NOT LIKE '%Senior%')
GROUP BY
  internship_role
ORDER BY
  demand_count DESC;
  
/*
    Result:
┌───────────────────────────┬──────────────┐
│      internship_role      │ demand_count │
│          varchar          │    int64     │
├───────────────────────────┼──────────────┤
│ Data Analyst              │         4239 │
│ Data Scientist            │         2171 │
│ Data Engineer             │         1257 │
│ Business Analyst          │          525 │
│ Software Engineer         │          285 │
│ Machine Learning Engineer │          221 │
│ Cloud Engineer            │           39 │
└───────────────────────────┴──────────────┘
  7 rows         2 columns

Key Takeaways:
  -  Data Dominance: Nearly half of all postings (48.52%), Data Analyst is overwhelmingly the 
      most accessible and heavily requested internship role. Combined demand for DA, DS, and DE reaches 7,667 positions (87.75%).
      There high corporate interest in predictive modeling and advanced analytics in the talent pipeline.

  - Specialized vs Generealist engineering gap: Specialized infrastructure/advanced AI roles maintain lower internship volume,
      suggesting companies prefer hiring senior/full-time talent for complex cloud architecture and ML ops rather than interns.
*/