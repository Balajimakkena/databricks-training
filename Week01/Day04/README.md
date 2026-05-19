# 📘 Day04 – SQL Practice Queries
# SQL Window Functions and CTE Practice

This repository contains SQL queries using:

- Window Functions  
- Common Table Expressions (CTEs)  
- Recursive CTEs  
- Ranking Functions  
- Aggregate Window Functions  

These queries are useful for practicing advanced SQL concepts commonly asked in interviews and used in real-world analytics projects.

---

## 📚 Topics Covered

### Window Functions

#### Ranking Functions
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `NTILE()`

#### Aggregate Window Functions
- `SUM() OVER()`
- `AVG() OVER()`
- `COUNT() OVER()`

#### Analytical Functions
- `LAG()`
- `LEAD()`

---

## 📝 Query List

| Query No | Description |
|----------|-------------|
| 1 | Assign row numbers to employees by salary |
| 2 | Rank employees using `RANK()` |
| 3 | Rank employees using `DENSE_RANK()` |
| 4 | Find top 3 highest-paid employees |
| 5 | Rank employees within departments |
| 6 | Find highest salary in each department |
| 7 | Calculate running total of orders |
| 8 | Calculate cumulative sales per employee |
| 9 | Show previous order amount using `LAG()` |
| 10 | Show next order amount using `LEAD()` |
| 11 | Find difference between current and previous order |
| 12 | Calculate moving average of last 3 orders |
| 13 | Divide employees into salary quartiles |
| 14 | Find first order of each customer |
| 15 | Find latest order of each customer |
| 16 | Display department average salary |
| 17 | Find employees earning above department average |
| 18 | Calculate department payroll |
| 19 | Find salary contribution percentage |
| 20 | Show total employee count with each row |
| 21 | CTE for total sales per employee |
| 22 | Employees whose sales exceed company average |
| 23 | Customer spending and ranking using multiple CTEs |
| 24 | Recursive CTE to generate numbers 1–10 |
| 25 | Recursive employee hierarchy query |
| 26 | Orders above average order amount |
| 27 | Rank customers by total spending |
| 28 | Find second-highest salary in each department |
| 29 | Difference between employee salary and department max salary |
| 30 | Top-performing employee in each department |

---

## 💡 SQL Concepts Used

### Window Functions

Window functions perform calculations across rows related to the current row without grouping the result.

Example:

```sql
SUM(salary) OVER(PARTITION BY department)
```

---

### Common Table Expressions (CTEs)

CTEs help write clean and readable SQL queries.

Example:

```sql
WITH employee_sales AS (
    SELECT employee_id,
           SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)
```

---

### Recursive CTE

Recursive CTEs are useful for:

- Hierarchical data  
- Tree structures  
- Number generation  

Example:

```sql
WITH RECURSIVE numbers AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM numbers
    WHERE num < 10
)
```

---

## 🗂️ Tables Used

### employees

Contains employee details:

- employee_id  
- employee_name  
- department  
- salary  
- manager_id  

### orders

Contains order details:

- order_id  
- customer_id  
- employee_id  
- order_date  
- total_amount  

### customers

Contains customer information:

- customer_id  
- customer_name  

---

## 🎯 Learning Outcomes

After practicing these queries, you will understand:

- Advanced SQL analytics  
- Ranking techniques  
- Running totals and moving averages  
- Window functions with partitions  
- Recursive queries  
- Data analysis using SQL  

---

## 🛠️ Tools

- SQL Server  
- Databricks SQL  

---

## 👨‍💻 Author

**Balaji Makkena**