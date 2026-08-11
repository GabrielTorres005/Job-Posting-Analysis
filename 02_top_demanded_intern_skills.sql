/*
    Data Scope: July 2024 - May 2025 (Summer 2025 Internship Cycle)
    Sample Size: 1,615,930 Job Listings Analyzed
    Objective: Evaluate the most requested technical skills and tool categories for intern candidates 
*/

SELECT 
  sd.skills,
  sd.type,
  COUNT(jpf.*) AS skill_demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON 
  jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON
  sjd.skill_id = sd.skill_id
WHERE 
  (job_title LIKE '%intern%' OR job_title LIKE '%Intern%')
  AND (job_posted_date >= '2024-07-01 00:00:00' AND job_posted_date <= '2025-05-31 23:59:00')
  AND (job_title_short NOT LIKE '%Senior%')
GROUP BY
  sd.skills,
  sd.type
ORDER BY
  skill_demand_count DESC
LIMIT 10;

/*
Result:
┌────────────┬───────────────┬────────────────────┐
│   skills   │     type      │ skill_demand_count │
│  varchar   │    varchar    │       int64        │
├────────────┼───────────────┼────────────────────┤
│ python     │ programming   │               4365 │
│ sql        │ programming   │               3358 │
│ excel      │ analyst_tools │               2272 │
│ tableau    │ analyst_tools │               1483 │
│ power bi   │ analyst_tools │               1302 │
│ r          │ programming   │               1231 │
│ azure      │ cloud         │                943 │
│ aws        │ cloud         │                918 │
│ java       │ programming   │                631 │
│ tensorflow │ libraries     │                565 │
└────────────┴───────────────┴────────────────────┘
  10 rows                               3 columns

Key Takeaways:
  - Python & SQL fundamentals: Python is the single most requested skill (4,365 mentions), underscoring its 
      versatility across data analysis, machine learning, and data engineering. SQL follows closely as the core data 
      querying standard. Together, Python + SQL form the universal baseline for ~45.3% of all top skill requirements.
  - Business Analysis & Visualization: Excel remains resilient as the #3 most requested skill (2,272 mentions), proving 
      that spreadsheet capabilities remain essential even for advanced data teams. Tableau slightly edges out 
      Power BI (1,483 vs. 1,302 mentions, a ~13.9% margin), though proficiency in either major BI tool covers the vast majority of 
      enterprise dashboarding needs.
  - Cloud Ecosystems: Azure (943) and AWS (918) sit in a near tie, capturing a combined ~10.9% share. This highlights a shift 
      toward cloud-native workflows for interns; familiarity with at least one primary cloud provider provides a distinct competitive edge.
*/