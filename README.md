# Peloton Customer Churn Analysis

## Project Overview
This project analyzes customer churn for a subscription-based fitness platform to understand customer retention, identify potential churn patterns, and explore how subscription plans, acquisition channels, cancellation reasons, and customer engagement relate to churn.

The goal is to turn customer and usage data into actionable business insights that can support retention strategies and improve customer experience.

## Business Objectives
- Calculate the overall customer churn rate.
- Compare churn across subscription plans.
- Analyze churn by customer acquisition channel.
- Identify the most frequently reported cancellation reasons.
- Compare engagement patterns between churned and active customers.
- Present key findings through an Excel dashboard.

## Tools & Technologies
- **MySQL:** Data querying, aggregation, and analysis.
- **Microsoft Excel:** KPI cards, charts, and dashboard creation.
- **SQL:** Data quality checks, churn calculations, grouping, and customer-level usage analysis.

## Dataset
The project uses two datasets:

- **Subscriptions:** Customer IDs, signup dates, subscription plans, monthly prices, acquisition channels, devices, churn status, cancellation dates, and cancellation reasons.
- **Usage:** Monthly workouts completed, active minutes, classes booked, and support tickets.

## Key Performance Indicators
- Total customers
- Churned customers
- Active customers
- Overall churn rate

## Analysis Performed
1. Subscription data quality assessment.
2. Usage data quality assessment.
3. Overall churn rate calculation.
4. Churn analysis by subscription plan.
5. Churn analysis by acquisition channel.
6. Cancellation reason analysis.
7. Usage behavior comparison by churn status.

## Initial Findings
The dataset contains **4,200 customers**, of whom **1,768 are classified as churned** and **2,432 as active**. The overall churn rate is approximately **42.1%**.

Further analysis examines differences across subscription plans, acquisition channels, cancellation reasons, and customer engagement. These comparisons can help identify areas for further investigation and retention improvements.

## Dashboard
The Excel dashboard summarizes customer totals and churn metrics, with charts covering cancellation reasons and churn rate by subscription plan.

## Business Recommendations
- Investigate subscription plans with higher churn rates.
- Review common cancellation reasons to identify opportunities for service improvements.
- Examine engagement patterns before cancellation.
- Evaluate acquisition channels based on customer retention, not just customer volume.
- Develop targeted retention initiatives for customer segments showing elevated churn.

## Project Structure
- `Peloton_Customer_Churn_Analysis.sql` — SQL queries used for analysis.
- `Peloton_Customer_Churn_Analysis.xlsx` — Excel dashboard and supporting analysis.
- `subscriptions.csv` — Subscription dataset.
- `usage.csv` — Customer usage dataset.
- `01_subscription_data_quality.csv` to `07_usage_by_churn_status.csv` — Saved SQL query results.

## Conclusion
This project demonstrates how SQL and Excel can be used to analyze customer churn, explore retention drivers, and communicate findings through business-focused KPIs and visualizations.

**Skills Demonstrated:** SQL, data quality analysis, customer analytics, churn analysis, KPI reporting, Excel dashboards, and business insight generation.
