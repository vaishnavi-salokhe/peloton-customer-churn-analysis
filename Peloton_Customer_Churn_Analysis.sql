CREATE DATABASE IF NOT EXISTS peloton_churn;
USE peloton_churn;


CREATE DATABASE IF NOT EXISTS peloton_churn;
USE peloton_churn;

-- QUERY 1: Subscription data quality
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(customer_id IS NULL) AS missing_customer_ids,
    SUM(churned IS NULL OR TRIM(churned) = '') AS missing_churn_status
FROM subscriptions;

-- QUERY 2: Usage data quality
SELECT
    COUNT(*) AS total_usage_records,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(customer_id IS NULL) AS missing_customer_ids,
    SUM(workouts_completed IS NULL) AS missing_workout_values
FROM `usage`;

-- QUERY 3: Overall churn rate
SELECT
    COUNT(*) AS total_customers,
    SUM(LOWER(TRIM(churned)) = 'yes') AS churned_customers,
    SUM(LOWER(TRIM(churned)) = 'no') AS active_customers,
    ROUND(
        100.0 * SUM(LOWER(TRIM(churned)) = 'yes')
        / NULLIF(SUM(LOWER(TRIM(churned)) IN ('yes','no')), 0),
        2
    ) AS churn_rate_pct
FROM subscriptions;

-- QUERY 4: Churn by subscription plan
SELECT
    plan_type,
    COUNT(*) AS total_customers,
    SUM(LOWER(TRIM(churned)) = 'yes') AS churned_customers,
    ROUND(
        100.0 * SUM(LOWER(TRIM(churned)) = 'yes')
        / NULLIF(SUM(LOWER(TRIM(churned)) IN ('yes','no')), 0),
        2
    ) AS churn_rate_pct,
    ROUND(AVG(monthly_price), 2) AS avg_monthly_price
FROM subscriptions
GROUP BY plan_type
ORDER BY churn_rate_pct DESC;

-- QUERY 5: Churn by acquisition channel
SELECT
    acquisition_channel,
    COUNT(*) AS total_customers,
    SUM(LOWER(TRIM(churned)) = 'yes') AS churned_customers,
    ROUND(
        100.0 * SUM(LOWER(TRIM(churned)) = 'yes')
        / NULLIF(SUM(LOWER(TRIM(churned)) IN ('yes','no')), 0),
        2
    ) AS churn_rate_pct
FROM subscriptions
GROUP BY acquisition_channel
ORDER BY churn_rate_pct DESC;

-- QUERY 6: Churn by cancellation reason
SELECT
    cancel_reason,
    COUNT(*) AS customers,
    ROUND(
        100.0 * COUNT(*) /
        (SELECT COUNT(*)
         FROM subscriptions
         WHERE LOWER(TRIM(churned)) = 'yes'),
        2
    ) AS pct_of_churned_customers
FROM subscriptions
WHERE LOWER(TRIM(churned)) = 'yes'
GROUP BY cancel_reason
ORDER BY customers DESC;

-- QUERY 7: Usage behavior by churn status
WITH customer_usage AS (
    SELECT
        customer_id,
        COUNT(*) AS months_observed,
        AVG(workouts_completed) AS avg_monthly_workouts,
        AVG(minutes_active) AS avg_monthly_active_minutes,
        AVG(classes_booked) AS avg_monthly_classes,
        AVG(support_tickets) AS avg_monthly_support_tickets
    FROM `usage`
    GROUP BY customer_id
)
SELECT
    s.churned,
    COUNT(*) AS customers,
    ROUND(AVG(u.months_observed), 2) AS avg_months_observed,
    ROUND(AVG(u.avg_monthly_workouts), 2) AS avg_monthly_workouts,
    ROUND(AVG(u.avg_monthly_active_minutes), 2)
        AS avg_monthly_active_minutes,
    ROUND(AVG(u.avg_monthly_classes), 2) AS avg_monthly_classes,
    ROUND(AVG(u.avg_monthly_support_tickets), 2)
        AS avg_monthly_support_tickets
FROM subscriptions s
LEFT JOIN customer_usage u
    ON s.customer_id = u.customer_id
GROUP BY s.churned
ORDER BY s.churned;
