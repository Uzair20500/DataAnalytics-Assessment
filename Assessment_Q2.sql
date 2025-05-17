-- Q2: Transaction Frequency Analysis

WITH monthly_activity AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        PERIOD_DIFF(
            DATE_FORMAT(MAX(s.transaction_date), '%Y%m'),
            DATE_FORMAT(MIN(s.transaction_date), '%Y%m')
        ) + 1 AS active_months
    FROM savings_savingsaccount s
    WHERE s.transaction_date IS NOT NULL
    GROUP BY s.owner_id
),
user_frequency AS (
    SELECT 
        m.owner_id,
        ROUND(m.total_transactions / m.active_months, 1) AS avg_transactions_per_month,
        CASE
            WHEN (m.total_transactions / m.active_months) >= 10 THEN 'High Frequency'
            WHEN (m.total_transactions / m.active_months) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM monthly_activity m
),
category_summary AS (
    SELECT 
        frequency_category,
        COUNT(*) AS customer_count,
        ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
    FROM user_frequency
    GROUP BY frequency_category
)
SELECT *
FROM category_summary
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
