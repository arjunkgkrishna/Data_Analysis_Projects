# DAX Measures & KPI Modeling

Created multiple DAX measures in Power Pivot for financial KPI analysis and year-over-year sales comparison.

## Key Measures Created

### Net Sales
```DAX
Net Sales =
SUM(fact_sales_monthly_with_cost[net_sales_amount])
```

### Gross Margin
```DAX
Gross Margin =
[Net Sales] - [COGS]
```

### Gross Margin Percentage
```DAX
GM % =
([Gross Margin] / [Net Sales])
```

### Cost of Goods Sold (COGS)
```DAX
COGS =
SUM(fact_sales_monthly_with_cost[COGS])
```

### Year-wise Net Sales Measures

```DAX
Net Sales 2019 =
CALCULATE(
    [Net Sales],
    dim_date[FY] = "2019"
)
```

```DAX
Net Sales 2020 =
CALCULATE(
    [Net Sales],
    dim_date[FY] = "2020"
)
```

```DAX
Net Sales 2021 =
CALCULATE(
    [Net Sales],
    dim_date[FY] = "2021"
)
```

### Year-over-Year Growth
```DAX
2020 vs 2021 =
DIVIDE(
    [Net Sales 2021] - [Net Sales 2020],
    [Net Sales 2020],
    0
)
```

---

## KPI Analysis Performed

- Year-over-Year Sales Growth
- Gross Margin Analysis
- Profitability Tracking
- Revenue Performance Monitoring
- Cost Analysis
- Financial KPI Reporting

---

## Advanced BI Concepts Demonstrated

- DAX Measure Creation
- Context Transition using `CALCULATE()`
- Dynamic KPI Modeling
- Financial Metric Engineering
- Relationship-based Calculations
- Time Intelligence Logic
