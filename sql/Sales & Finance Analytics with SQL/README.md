# Advanced Sales & Finance Analytics using MySQL

## Overview
This project is an enterprise-style SQL analytics solution built using MySQL to analyze sales, finance, customer, and market performance data. The project simulates real-world business intelligence reporting workflows involving gross sales, invoice deductions, customer contribution analysis, and product performance tracking.

The system follows a warehouse-style schema using fact and dimension tables to support scalable analytical reporting.

---

# Business Problem

Retail businesses generate massive amounts of transactional sales data, but extracting meaningful financial insights from raw data is challenging.

The objective of this project was to build a scalable SQL analytics system capable of:

- Tracking gross and net sales performance
- Analyzing customer and market trends
- Calculating invoice deductions
- Ranking products and customers
- Improving reporting efficiency through query optimization

---

# Database Schema

## Fact Tables
- `fact_sales_monthly`
- `fact_gross_price`
- `fact_pre_invoice_deductions`
- `fact_post_invoice_deductions`
- `fact_forecast_monthly`

## Dimension Tables
- `dim_customer`
- `dim_product`
- `dim_date`

---

# ER Diagram

> Add your exported ER diagram screenshot here.

```md
![ER Diagram](images/erd-diagram.png)
```

---

# Project Features

## 1. Monthly Gross Sales Reporting

Developed monthly gross sales reporting systems to track revenue performance across customers, products, and markets.

### SQL Query

```sql
SELECT 
    s.date,
    SUM(
        ROUND(s.sold_quantity * g.gross_price, 2)
    ) AS monthly_sales

FROM fact_sales_monthly s

JOIN fact_gross_price g
    ON g.fiscal_year = s.fiscal_year
    AND g.product_code = s.product_code

GROUP BY s.date
ORDER BY s.date;
```

---

## 2. Pre-Invoice Discount Analysis

Integrated pre-invoice deductions into detailed customer sales reporting.

### SQL Query

```sql
SELECT 
    s.date,
    s.product_code,
    p.product,
    p.variant,
    s.sold_quantity,

    g.gross_price AS gross_price_per_item,

    ROUND(
        s.sold_quantity * g.gross_price,
        2
    ) AS gross_price_total,

    pre.pre_invoice_discount_pct

FROM fact_sales_monthly s

JOIN dim_product p
    ON s.product_code = p.product_code

JOIN fact_gross_price g
    ON g.fiscal_year = s.fiscal_year
    AND g.product_code = s.product_code

JOIN fact_pre_invoice_deductions pre
    ON pre.customer_code = s.customer_code
    AND pre.fiscal_year = s.fiscal_year

WHERE s.fiscal_year = 2021;
```

---

## 3. Net Invoice Sales Calculation

Calculated net invoice sales after pre-invoice discounts using CTEs.

### SQL Query

```sql
WITH cte1 AS (

    SELECT 
        s.date,
        s.customer_code,
        s.product_code,

        p.product,
        p.variant,

        s.sold_quantity,

        g.gross_price AS gross_price_per_item,

        ROUND(
            s.sold_quantity * g.gross_price,
            2
        ) AS gross_price_total,

        pre.pre_invoice_discount_pct

    FROM fact_sales_monthly s

    JOIN dim_product p
        ON s.product_code = p.product_code

    JOIN fact_gross_price g
        ON g.fiscal_year = s.fiscal_year
        AND g.product_code = s.product_code

    JOIN fact_pre_invoice_deductions pre
        ON pre.customer_code = s.customer_code
        AND pre.fiscal_year = s.fiscal_year

    WHERE s.fiscal_year = 2021
)

SELECT
    *,

    (
        gross_price_total
        -
        pre_invoice_discount_pct * gross_price_total
    ) AS net_invoice_sales

FROM cte1;
```

---

## 4. Net Sales Reporting

Calculated final net sales after post-invoice deductions.

### SQL Query

```sql
SELECT 
    *,

    net_invoice_sales *
    (
        1 - post_invoice_discount_pct
    ) AS net_sales

FROM sales_postinv_discount;
```

---

## 5. Top Markets by Net Sales

Identified top-performing markets based on revenue contribution.

### SQL Query

```sql
SELECT 
    market,

    ROUND(
        SUM(net_sales) / 1000000,
        2
    ) AS net_sales_mln

FROM net_sales

WHERE fiscal_year = 2021

GROUP BY market

ORDER BY net_sales_mln DESC

LIMIT 5;
```

---

## 6. Customer Revenue Contribution Analysis

Calculated customer-wise percentage contribution to total revenue using window functions.

### SQL Query

```sql
WITH cte1 AS (

    SELECT
        customer,

        ROUND(
            SUM(net_sales) / 1000000,
            2
        ) AS net_sales_mln

    FROM net_sales s

    JOIN dim_customer c
        ON s.customer_code = c.customer_code

    WHERE s.fiscal_year = 2021

    GROUP BY customer
)

SELECT
    *,

    net_sales_mln * 100 /

    SUM(net_sales_mln)
    OVER() AS pct_net_sales

FROM cte1

ORDER BY net_sales_mln DESC;
```

---

## 7. Product Ranking Analysis

Ranked top-selling products across divisions using `DENSE_RANK()`.

### SQL Query

```sql
WITH cte1 AS (

    SELECT
        p.division,
        p.product,

        SUM(sold_quantity) AS total_qty

    FROM fact_sales_monthly s

    JOIN dim_product p
        ON p.product_code = s.product_code

    WHERE fiscal_year = 2021

    GROUP BY p.product
),

cte2 AS (

    SELECT
        *,

        DENSE_RANK() OVER (
            PARTITION BY division
            ORDER BY total_qty DESC
        ) AS drnk

    FROM cte1
)

SELECT *

FROM cte2

WHERE drnk <= 3;
```

---

# Advanced SQL Concepts Used

## Joins
- Multi-table joins
- Fact-to-dimension joins
- Composite joins

## Common Table Expressions (CTEs)
Used for layered calculations and reporting logic.

## SQL Views
Created reusable reporting views:
- `sales_preinv_discount`
- `sales_postinv_discount`
- `net_sales`

## Stored Procedures
Built reusable procedures for:
- Monthly gross sales reporting
- Top markets analysis
- Top customer analysis
- Product ranking reports

### Example Stored Procedure

```sql
CREATE PROCEDURE get_top_n_markets_by_net_sales(
    in_fiscal_year INT,
    in_top_n INT
)

BEGIN

    SELECT 
        market,

        ROUND(
            SUM(net_sales)/1000000,
            2
        ) AS net_sales_mln

    FROM net_sales

    WHERE fiscal_year = in_fiscal_year

    GROUP BY market

    ORDER BY net_sales_mln DESC

    LIMIT in_top_n;

END;
```

---

## User Defined Functions (UDF)

### Fiscal Year Function

```sql
CREATE FUNCTION get_fiscal_year(
    calendar_date DATE
)

RETURNS INT

DETERMINISTIC

BEGIN

    DECLARE fiscal_year INT;

    SET fiscal_year =
        YEAR(
            DATE_ADD(
                calendar_date,
                INTERVAL 4 MONTH
            )
        );

    RETURN fiscal_year;

END;
```

---

## Window Functions
Implemented:
- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `OVER(PARTITION BY)`

for ranking, contribution analysis, and category-wise reporting.

---

# Query Optimization

Improved reporting efficiency by:
- Avoiding repeated function calls
- Using dimensional modeling
- Optimizing joins
- Adding fiscal-year filtering

### Optimized Query Example

```sql
SELECT 
    s.date,
    s.customer_code,
    s.product_code,

    p.product,
    p.variant,

    s.sold_quantity,

    g.gross_price AS gross_price_per_item,

    ROUND(
        s.sold_quantity * g.gross_price,
        2
    ) AS gross_price_total

FROM fact_sales_monthly s

JOIN dim_product p
    ON s.product_code = p.product_code

JOIN fact_gross_price g
    ON g.fiscal_year = s.fiscal_year
    AND g.product_code = s.product_code

WHERE s.fiscal_year = 2021;
```

---

# Example Business Insights

- Identified top-performing markets by net sales
- Calculated customer-wise revenue contribution
- Ranked best-selling products by division
- Analyzed regional sales distribution
- Evaluated impact of invoice deductions on profitability

---

# Tools & Technologies

- MySQL
- MySQL Workbench
- Advanced SQL
- Stored Procedures
- Window Functions
- SQL Views
- CTEs
- Warehouse Modeling

---

# Skills Demonstrated

- Advanced SQL
- Financial Analytics
- Business Intelligence
- Query Optimization
- Data Modeling
- Analytical Reporting
- Performance Tuning

---

# Future Improvements

- Power BI / Tableau dashboard integration
- Automated ETL workflows
- KPI monitoring dashboards
- Forecast visualization reports

---

# Author

Your Name
