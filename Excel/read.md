# Excel Sales Analytics Dashboard

## Overview
This project focuses on building interactive sales analytics dashboards and business reports using Microsoft Excel, Power Query, Power Pivot, and DAX. The project analyzes product performance, country-wise sales trends, and division-level business insights through advanced data modeling and visualization techniques.

The dashboards were designed to simulate real-world business intelligence reporting workflows for management decision-making and KPI tracking.

---

# Business Problem

Businesses generate large volumes of sales data, but raw spreadsheets alone do not provide meaningful insights for decision-making.

The objective of this project was to build dynamic Excel dashboards capable of:
- Tracking product performance
- Analyzing country-wise sales trends
- Identifying top and bottom-performing products
- Building scalable data models
- Automating data transformation workflows
- Creating KPI-driven management reports

---

# Project Reports

## 1. Division Level Report
Analyzed sales performance across different business divisions to identify high-performing segments and revenue contribution.

### Key Insights
- Division-wise sales comparison
- Revenue contribution analysis
- Performance trend evaluation

---

## 2. Top 10 Products Report
Identified the top-performing products based on sales quantity and revenue contribution.

### Key Insights
- Product ranking analysis
- Revenue-driving products
- Sales contribution insights

---

## 3. Top 5 Countries Report
Analyzed country-wise sales performance and identified top-performing markets.

### Key Insights
- Regional sales distribution
- Country-level revenue analysis
- Market contribution trends

---

## 4. Top & Bottom Products Analysis
Compared high-performing and low-performing products to identify growth opportunities and underperforming categories.

### Key Insights
- Product performance comparison
- Bottom-performing product analysis
- Sales trend evaluation

---

# Technologies & Features Used

## Power Query
Used Power Query for:
- Data cleaning
- Data transformation
- Merging datasets
- Automating data preparation workflows

---

## Power Pivot
Built scalable data models using:
- Table relationships
- Star-schema modeling
- Data relationships between fact and dimension tables

---

## DAX Modeling
Created DAX measures and calculated columns for:
- Revenue calculations
- KPI metrics
- Sales growth analysis
- Product ranking
- Performance comparisons

### Example DAX Measures

```DAX
Total Sales =
SUM(Sales[Sales Amount])
```

```DAX
Top Product Rank =
RANKX(
    ALL(Products[Product]),
    [Total Sales],
    ,
    DESC
)
```

---

## Excel Dashboard Features
- Pivot Tables
- Pivot Charts
- KPI Cards
- Interactive Reports
- Dynamic Filtering
- Conditional Formatting

---

# Data Modeling

Implemented a warehouse-style data model using:
- Fact tables
- Dimension tables
- Relationship modeling
- Optimized reporting structures

This improved:
- scalability
- reporting efficiency
- analytical flexibility

---

# Business Insights Generated

- Top-performing products by sales
- Country-wise revenue contribution
- Division-level sales analysis
- Product ranking insights
- Top and bottom product comparison
- KPI-based business reporting

---

# Tools & Technologies
- Microsoft Excel
- Power Query
- Power Pivot
- DAX
- Pivot Tables
- Data Modeling
- Dashboard Development

---

# Skills Demonstrated
- Data Analysis
- Data Modeling
- Power Query
- Power Pivot
- DAX Modeling
- Dashboard Development
- Business Intelligence Reporting
- KPI Reporting
- Data Visualization

---

# Files Included

- `Division level Report.pdf`
- `Top 10 Products.pdf`
- `Top 5 Country - 2021.pdf`
- `Top and bottom products - QTY.pdf`

---

# Future Improvements
- Power BI migration
- Automated refresh pipelines
- Forecasting dashboards
- Advanced KPI tracking
- Executive reporting dashboards

---

# Author
Your Name
