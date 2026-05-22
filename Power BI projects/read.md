
# Business Insight 360 | Power BI Analytics Project

## Overview

Business Insight 360 is an end-to-end business intelligence and analytics project developed using Power BI to analyze sales, finance, marketing, and supply chain performance.

The project simulates a real-world enterprise reporting environment by integrating financial KPIs, profitability analysis, forecasting metrics, customer insights, and market performance into interactive dashboards.

The solution was designed for executive-level decision-making and business performance monitoring using advanced Power BI reporting techniques.

---

# Business Problem

Organizations generate large volumes of operational and financial data, but decision-makers often struggle to transform raw data into actionable business insights.

The objective of this project was to build a centralized analytics solution capable of:

- Monitoring sales and profitability
- Tracking gross margin and net profit performance
- Analyzing customer and product contribution
- Measuring forecast accuracy
- Evaluating supply chain risks
- Comparing regional and market performance
- Building executive-level KPI dashboards

---

# Dashboard Views

## 1. Executive View

The Executive Dashboard provides a high-level overview of business performance across sales, profitability, forecast accuracy, and market contribution.

### KPIs Monitored
- Net Sales
- Gross Margin %
- Net Profit %
- Forecast Accuracy %
- Market Share %
- Revenue Contribution %

### Insights Generated
- Division-wise sales contribution
- Channel performance analysis
- Regional profitability trends
- Top customers and products
- Sub-zone performance analysis

### Dashboard Features
- KPI Cards
- Trend Analysis
- Contribution Analysis
- Pie Charts
- Heatmap-style tables
- Comparative Metrics

---

## 2. Sales View

The Sales Dashboard analyzes customer performance and product contribution using profitability and revenue metrics.

### Key Analysis
- Customer performance tracking
- Product profitability analysis
- Gross margin comparison
- Revenue contribution analysis
- Regional sales benchmarking

### Visualizations Used
- Scatter Plot Performance Matrix
- Customer Performance Tables
- Product Contribution Tables
- Unit Economics Visualization

### Insights Generated
- High-revenue customers
- Gross margin optimization
- Market contribution comparison
- Product-level profitability

---

## 3. Marketing View

The Marketing Dashboard evaluates market and segment profitability to support strategic business decisions.

### Key Analysis
- Segment-wise profitability
- Net profit analysis
- Gross margin tracking
- Division contribution comparison

### Visualizations Used
- Bubble Charts
- Waterfall Charts
- Pie Charts
- KPI Tables

### Insights Generated
- Segment-level profitability
- Marketing performance evaluation
- Revenue vs profit comparison
- Product segment optimization

---

## 4. Supply Chain View

The Supply Chain Dashboard focuses on forecasting efficiency and operational risk analysis.

### KPIs Monitored
- Forecast Accuracy %
- Net Error
- Absolute Error
- Risk Classification

### Key Analysis
- Forecast accuracy trends
- Product-level forecast performance
- Customer-level supply chain risk
- Net error tracking

### Visualizations Used
- Forecast Trend Analysis
- Risk Monitoring Tables
- Operational KPI Cards
- Forecast Accuracy Reports

### Insights Generated
- Supply chain forecasting efficiency
- Operational risk identification
- Product forecasting accuracy
- Error trend analysis

---

# Power BI Features Used

## Data Modeling

Implemented a warehouse-style star schema using:
- Fact tables
- Dimension tables
- Relationship modeling
- Optimized analytical structure

### Fact Tables
- `fact_sales_monthly`
- `fact_forecast_monthly`
- `fact_actuals_estimate`
- `manufacturing_cost`
- `freight_cost`

### Dimension Tables
- `dim_customer`
- `dim_product`
- `dim_market`
- `dim_date`

---

# Power Query

Used Power Query for:
- Data cleaning
- Data transformation
- ETL workflows
- Merging datasets
- Data standardization

### Transformations Performed
- Removing duplicates
- Data type conversions
- Conditional columns
- Query merging
- Data filtering
- Aggregation workflows

---

# DAX Modeling

Created advanced DAX measures for KPI engineering and analytical reporting.

---

## Key DAX Measures

### Net Sales
```DAX
Net Sales =
SUM(fact_sales_monthly[net_sales])
```

---

### Gross Margin
```DAX
Gross Margin =
[Net Sales] - [COGS]
```

---

### Gross Margin %
```DAX
GM % =
DIVIDE([Gross Margin], [Net Sales], 0)
```

---

### Net Profit %
```DAX
Net Profit % =
DIVIDE([Net Profit], [Net Sales], 0)
```

---

### Forecast Accuracy %
```DAX
Forecast Accuracy % =
DIVIDE(
    [Actual Sales],
    [Forecast Sales],
    0
)
```

---

# KPI Analysis Performed

- Revenue Performance Analysis
- Gross Margin Analysis
- Net Profit Monitoring
- Forecast Accuracy Tracking
- Product Contribution Analysis
- Customer Performance Analysis
- Market Share Evaluation
- Supply Chain Risk Monitoring

---

# Visualizations Used

- KPI Cards
- Scatter Plots
- Pie Charts
- Waterfall Charts
- Line Charts
- Matrix Tables
- Trend Analysis Charts
- Performance Heatmaps

---

# Advanced BI Concepts Demonstrated

## Business Intelligence
- Executive KPI Reporting
- Performance Monitoring
- Business Analytics
- Financial Reporting

## Data Modeling
- Star Schema Modeling
- Relationship Management
- Fact & Dimension Modeling

## DAX & Analytics
- KPI Engineering
- Time Intelligence
- Profitability Analysis
- Forecast Analytics

## Dashboard Design
- Interactive Navigation
- Multi-page Reporting
- Dynamic Filtering
- Cross-filtering
- Drill-through Reporting

---

# Business Insights Generated

- Top-performing customers by revenue
- Product profitability trends
- Market share distribution
- Forecasting efficiency analysis
- Operational risk monitoring
- Segment-wise net profit analysis
- Regional sales contribution

---

# Tools & Technologies

- Power BI
- Power Query
- DAX
- Data Modeling
- Power BI Service
- Business Intelligence Reporting

---

# Skills Demonstrated

- Power BI Dashboard Development
- Data Visualization
- DAX Modeling
- KPI Engineering
- Financial Analytics
- Forecast Analytics
- Data Modeling
- Business Intelligence Reporting
- Analytical Thinking

---

# Project Architecture

```text
Data Sources
     ↓
Power Query Transformation
     ↓
Data Modeling
     ↓
DAX KPI Calculations
     ↓
Interactive Power BI Dashboards
     ↓
Business Insights & Reporting
```

---

# Dashboard Pages Included

- Executive View
- Sales View
- Marketing View
- Supply Chain View
- Finance View
- P & L Analysis
- Sales Trend Analysis

---

# Future Improvements

- Real-time data integration
- Predictive analytics
- AI-driven forecasting
- Automated refresh pipelines
- Advanced executive KPI monitoring

---

# Author

Your Name
