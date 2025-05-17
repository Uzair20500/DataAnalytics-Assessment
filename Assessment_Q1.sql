USE adashi_staging;

WITH savings AS (
    SELECT owner_id, COUNT(*) AS savings_count, SUM(amount) AS total_deposits
    FROM savings_savingsaccount
    WHERE amount > 0
    GROUP BY owner_id
),
investments AS (
    SELECT owner_id, COUNT(*) AS investment_count
    FROM plans_plan
    WHERE amount > 0
    GROUP BY owner_id
)
SELECT 
    u.id AS owner_id,
    u.name,
    s.savings_count,
    i.investment_count,
    s.total_deposits
FROM users_customuser u
JOIN savings s ON u.id = s.owner_id
JOIN investments i ON u.id = i.owner_id
ORDER BY s.total_deposits DESC;

