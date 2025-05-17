-- Q3: Find active accounts with no inflow in the last 365 days

-- Subquery 1: Get latest inflow for savings
SELECT 
    s.plan_id,
    s.owner_id,
    'Savings' AS type,
    MAX(s.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days
FROM savings_savingsaccount s
WHERE s.amount > 0
GROUP BY s.plan_id, s.owner_id
HAVING inactivity_days > 365

UNION

-- Subquery 2: Get latest inflow for investment plans
SELECT 
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    MAX(p.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(p.created_on)) AS inactivity_days
FROM plans_plan p
WHERE p.amount > 0 AND p.created_on IS NOT NULL
GROUP BY p.id, p.owner_id
HAVING inactivity_days > 365;
