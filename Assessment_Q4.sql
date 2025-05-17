-- Q4: CLV Estimation (based on confirmed_amount in kobo, converted to naira)

SELECT 
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.created_on, CURDATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND((
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.created_on, CURDATE()), 0)) * 12 *
        0.001 * AVG(s.confirmed_amount) / 100
    ), 2) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount s 
    ON u.id = s.owner_id
JOIN plans_plan p 
    ON s.plan_id = p.id
WHERE p.is_regular_savings = 1 
  AND s.confirmed_amount > 0 
  AND s.transaction_date IS NOT NULL
GROUP BY u.id, u.name, u.created_on
ORDER BY estimated_clv DESC;
