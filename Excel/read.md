# Excel Sales & Finance Analytics Dashboard

## Overview
This project focuses on building interactive business intelligence dashboards and analytical reports using Microsoft Excel, Power Query, Power Pivot, Data Modeling, and DAX.

The project analyzes sales, product performance, customer trends, and regional business insights through KPI-driven dashboards and advanced Excel analytics techniques. The dashboards were designed to simulate real-world management reporting workflows used in business intelligence and financial analytics environments.

---

# Business Problem

Businesses generate large volumes of sales and financial data, but raw spreadsheets alone do not provide actionable insights for decision-making.

The objective of this project was to build scalable and interactive Excel dashboards capable of:
- Tracking sales performance
- Analyzing product contribution
- Monitoring profitability metrics
- Identifying top and bottom-performing products
- Comparing regional sales performance
- Automating reporting workflows
- Creating KPI-based management reports

---

# Project Reports

## 1. Division Level Report
Analyzed business performance across different product divisions to evaluate revenue contribution and sales growth.

### Key Insights
- Division-wise sales comparison
- Revenue contribution analysis
- Performance trend evaluation
- Division profitability tracking

---

## 2. Top 10 Products Report
Identified top-performing products based on sales quantity and revenue contribution.

### Key Insights
- Product ranking analysis
- Revenue-driving products
- Product sales contribution
- High-performing product categories

---

## 3. Top 5 Countries Report
Analyzed country-wise sales trends and identified top-performing markets.

### Key Insights
- Country-level sales performance
- Regional revenue analysis
- Market contribution tracking
- Geographic sales comparison

---

## 4. Top & Bottom Products Analysis
Compared high-performing and low-performing products to identify business opportunities and underperforming categories.

### Key Insights
- Product profitability analysis
- Bottom-performing product identification
- Sales trend comparison
- Product growth opportunities

---

# Data Modeling

Implemented a warehouse-style data model using:
- Fact tables
- Dimension tables
- Relationship modeling
- Optimized analytical structures

The data model improved:
- scalability
- reporting performance
- analytical flexibility
- KPI calculation efficiency

---

# Power Query

Used Power Query for:
- Data cleaning
- Data transformation
- Removing inconsistencies
- Merging datasets
- Data preparation automation
- ETL workflow simulation

### Power Query Operations Performed
- Column transformations
- Data type conversion
- Removing duplicates
- Appending tables
- Merging queries
- Conditional transformations

---

# Power Pivot

Built scalable analytical models using Power Pivot.

### Power Pivot Features Used
- Table relationships
- Data modeling
- Star-schema design
- Measure creation
- KPI modeling
- Relationship management

---

# DAX Modeling

Created multiple DAX measures for financial KPI analysis and business reporting.

---

## DAX Measures Created

### Net Sales
```DAX
Net Sales =
SUM(fact_sales_monthly_with_cost[net_sales_amount])
```

---

### Cost of Goods Sold (COGS)
```DAX
COGS =
SUM(fact_sales_monthly_with_cost[COGS])
```

---

### Gross Margin
```DAX
Gross Margin =
[Net Sales] - [COGS]
```

---

### Gross Margin Percentage
```DAX
GM % =
([Gross Margin] / [Net Sales])
```

---

### Net Sales 2019
```DAX
Net Sales 2019 =
CALCULATE(
    [Net Sales],
    dim_date[FY] = "2019"
)
```

---

### Net Sales 2020
```DAX
Net Sales 2020 =
CALCULATE(
    [Net Sales],
    dim_date[FY] = "2020"
)
```

---

### Net Sales 2021
```DAX
Net Sales 2021 =
CALCULATE(
    [Net Sales],
    dim_date[FY] = "2021"
)
```

---

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

# KPI Analysis Performed

- Year-over-Year Sales Growth
- Gross Margin Analysis
- Revenue Performance Tracking
- Profitability Monitoring
- Product Contribution Analysis
- Regional Sales Analysis
- Financial KPI Reporting

---

# Dashboard Features

## Interactive Reporting
- Dynamic filtering
- Interactive PivotTables
- Drill-down analysis
- KPI visualization

---

## Visualizations
- Pivot Charts
- KPI Cards
- Trend Analysis Charts
- Comparative Reports
- Product Ranking Charts

---

## Excel Features Used
- Pivot Tables
- Pivot Charts
- Conditional Formatting
- Slicers
- Dynamic Dashboards
- Lookup Functions
- Data Validation

---

# Advanced Excel Functions Used

```excel
VLOOKUP()
```

```excel
XLOOKUP()
```

```excel
SUMIFS()
```

```excel
COUNTIFS()
```

```excel
IF()
```

```excel
INDEX()
```

```excel
MATCH()
```

---

# Business Insights Generated

- Top-performing products by sales
- Country-wise revenue contribution
- Division-level performance analysis
- Gross margin evaluation
- Product ranking insights
- Top & bottom product analysis
- Revenue growth tracking

---

# Files Included

- `Division level Report.pdf`
- `Top 10 Products.pdf`
- `Top 5 Country - 2021.pdf`
- `Top and bottom products - QTY.pdf`

---

# Tools & Technologies

- Microsoft Excel
- Power Query
- Power Pivot
- DAX
- Data Modeling
- Pivot Tables
- Pivot Charts
- Dashboard Development

---

# Skills Demonstrated

- Data Analysis
- Data Visualization
- Dashboard Development
- DAX Modeling
- Power Query
- Power Pivot
- KPI Engineering
- Financial KPI Analysis
- Data Modeling
- Business Intelligence Reporting
- Analytical Thinking

---

# Future Improvements

- Power BI integration
- Automated dashboard refresh
- Forecasting dashboards
- Executive KPI reporting
- Advanced trend analysis
- Real-time data connectivity

---

# Author

Your Name
