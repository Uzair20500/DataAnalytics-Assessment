# DataAnalytics-Assessment

This repository contains solutions to a SQL proficiency assessment involving customer behavior, transactions, and financial products. All SQL queries are written for MySQL and based on the provided schema.

---

## Assessment_Q1.sql — High-Value Customers with Multiple Products

**Approach**:  
Joined `users_customuser`, `savings_savingsaccount`, and `plans_plan` to identify customers who have at least one funded savings account and one funded investment plan. Used filters on positive `amount`, grouped by user, and sorted by total deposits.

**Challenges**:  
Initially applied `is_fixed_investment` and `is_regular_savings` filters, but the dataset lacked such classifications. The solution was simplified to use only `amount > 0`.

---

## Assessment_Q2.sql — Transaction Frequency Analysis

**Approach**:  
Calculated the number of months each user was active using `transaction_date`, then derived average monthly transactions. Classified users into High, Medium, and Low Frequency tiers using a `CASE` statement.

**Challenges**:  
`PERIOD_DIFF` helped calculate month span. Ensured to avoid division by zero by handling users with only one month of activity.

---

## Assessment_Q3.sql — Account Inactivity Alert

**Approach**:  
Extracted savings and investment accounts with no inflow for over 365 days. Used `transaction_date` and `created_on` timestamps and compared them to `CURDATE()` using `DATEDIFF`.

**Challenges**:  
Had to separately analyze savings and plan tables, then unify results using `UNION ALL`.

---

## Assessment_Q4.sql — Customer Lifetime Value Estimation

**Approach**:  
Calculated CLV using confirmed inflow transactions (`confirmed_amount` from `savings_savingsaccount`), filtered by `is_regular_savings = 1`. Converted kobo to naira, estimated monthly transaction profit, and applied the CLV formula based on tenure.

**Challenges**:  
Adjusted for kobo-to-naira and ensured accurate tenure via `TIMESTAMPDIFF`. Used `NULLIF` to handle potential division by zero.

---

### Tools Used
- MySQL Workbench
- Git / GitHub
