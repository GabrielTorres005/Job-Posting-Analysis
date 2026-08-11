## Exploratory Data Analysis w/ SQL: Early Career Job Market Analysis

![Project 1 overview](/images/job_analytics_graphic.png)

A SQL project analyzing different market trends for tech internships using real-world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights.**

## Executive Summary

- **Project Scope:** Built **3 analytical queries** that answer key questions about the tech job market.
- **Data Modeling:** Used **multi-table joins** across fact and dimension tables to extract insights.
- **Analytics:** Applies **aggregations, filtering, and sorting** to find top skills by demand, salary, and overall value.
- **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, and salary patterns.

If you have a minute, review these:

[Top Demanded Intern Roles (SQL)](01_top_demanded_intern_role.sql) - Demand analysis with multi-table joins.  
[Top Demanded Intern Skills Query (SQL)](02_top_demanded_intern_skills.sql) - Salary analysis with aggregation.  
[Most Optimal Skills (SQL)](03_optimal_skills.sql) - Combined demand/salary optimization query.

## Problem & Context

Job market analysis needs to answer questions like:

- **Most in-demand:** *Which roles were most in-demand for interns?*
- **Highest paid:** *Which skills command the highest value out of interns?*
- **Best trade-off:** *What is the optimal skill set balancing projected demand and compensation for full-time roles?*

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:

![Database Schema](../Job_Posting_Analysis/images/data_jobs%28Schema%29.png)

- **Fact Table:** `job_posting_fact` - Central table containing job posting details (job titles, locations, salaries, dates, etc.)
- **Dimensional Tables:**
    - `company_dim` - Company information linked to job postings
    - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table:** `skills_job_dim` - Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and optimal skill combinations for tech students.

## Tech Stack

- **Query Engine:** DuckDB for fast OLAP-style analytical queries
- **Language:** SQL (ANSI-style with analytical functions)
- **Data Model:** Star schema with fact + dimension + bridge tables
- **Development:** VS Code for SQL editing + Terminal for DuckDB CLI
- **Version Control:** Git/GitHub for versioned SQL scripts

## Analysis Overview

### Query Structure

1. **[Top Demanded Intern Roles (SQL)](01_top_demanded_intern_role.sql)** - Identifies the most in-demand internship roles during the summer 2025 recruitment cycle.
2. **[Top Demanded Skills Query (SQL)](02_top_demanded_intern_skills.sql)** - Analyzes the top 10 most demanded skills by recruiters for intern new hires.
3. **[Most Optimal Skills (SQL)](03_optimal_skills.sql)** - Calculates an optimal score using the natural log of demand combined with median salary to identify the most valuable skills to learn.

## Key Takeaways: Tech & Data Skills in the AI Era

### 1. Market Shift: Syntax to Infrastructure
Generative AI automates routine query writing, shifting hiring demand toward **distributed systems, real-time data streaming, and cloud architecture**.

| Category | Key Technologies | Market Focus & Compensation Profile |
| :--- | :--- | :--- |
| **Core Baseline** | `Python`, `SQL` | **Universal Foundation:** Python leads overall ROI (Score: **1.21**, **$132,000** median); SQL opens ~73% of entry-level roles. |
| **BI & Analytics** | `Excel`, `Tableau`, `Power BI` | **High Volume, Lower Ceiling:** Accounts for ~30% of intern demand, but pure dashboarding hits early pay ceilings (Tableau: **$116,100**). |
| **Cloud Platforms** | `AWS`, `Azure`, `Snowflake` | **Scale Engine:** AWS leads cloud tools (**1.18** score, **$142,419** median) for hosting enterprise pipelines. |
| **Data Streaming** | `Apache Spark`, `Kafka`, `Scala` | **Top Earning Multipliers:** Real-time stream processing commands peak salaries (**Kafka: $157,500**, **Spark: $146,500**). |
| **AI / ML Ops** | `PyTorch`, `Kubernetes` | **Deployment Floor:** Model serving and containerization set the highest pay floors (**$150,000–$157,590+**). |

### 2. Strategic Insights for New Grads
* **Architectural Literacy over Syntax:** AI handles boilerplate code; employers prioritize systems design, data reliability, and pipeline cost optimization.
* **The Streaming Premium:** Real-time ingestion tools (`Kafka`, `Spark`) command higher compensation leverage than traditional SQL reporting due to AI data pipeline demand.
* **Cloud Dominance:** `AWS` commands higher search volume and salary leverage ($142.4k vs $135k) compared to Azure and GCP.

## SQL Skills Demonstrated

### Query Design & Optimization
- **Complex Joins:** Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregations:** `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering:** Boolean logic `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting:** `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques
- **Grouping:** `GROUP BY` for categorical analysis by skills
- **Mathematical Functions:** `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics:** Derived optimal score combining log-transformed demand with median salary
- **HAVING Clauses:** Filtering aggregated results (skills with $\ge 100$ postings)
- **NULL Handling:** Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)