# E-Commerce Returns & Reverse Logistics Analytics

## Project Overview

E-commerce returns can significantly impact revenue, profitability, and operational efficiency.

This project analyzes an e-commerce company's order and return data to identify:

- Where return rates are highest
- Which product categories generate the most returns
- What return reasons drive the highest costs
- How payment methods are associated with return behaviour
- Which cities have higher return rates
- Which products generate the highest return costs
- How long customers take to return products
- Which customers have unusually high return frequency

The analysis combines SQL, Excel, Power Query, Power BI, and DAX to transform raw transactional data into business-focused insights.

---

## Business Problem

The company wants to understand:

> **Where is the business losing money because of product returns, and what operational areas should be investigated to reduce return-related costs?**

Returns create multiple financial impacts, including:

- Refunds
- Reverse shipping costs
- Restocking losses
- Product-specific losses
- Operational workload

The objective of this project is to quantify these impacts and identify the major return drivers.

---

## Project Objectives

The analysis focuses on five key objectives:

1. Measure the overall return rate and financial impact of returns.
2. Identify product categories and products with high return activity.
3. Understand the main reasons customers return products.
4. Analyze customer and operational patterns associated with returns.
5. Build an interactive dashboard that helps business users explore return performance.

---

## Tools & Technologies

| Tool | Purpose |
|---|---|
| MySQL | Data storage and SQL analysis |
| SQL | Business analysis and KPI calculations |
| Excel | Return-cost analysis and customer return-frequency analysis |
| Power Query | Data cleaning and transformation |
| Power BI | Interactive dashboard and visualization |
| DAX | Measures and analytical calculations |
| GitHub | Project documentation and portfolio presentation |

---

## Dataset

The project uses four related datasets.

### Customers

Contains customer-level information such as:

- Customer ID
- Customer name
- City
- Signup date
- Serial-returner indicator

### Products

Contains product-level information such as:

- Product ID
- Product name
- Category
- Selling price
- Product cost

### Orders

Contains transaction-level information such as:

- Order ID
- Customer ID
- Product ID
- Order date
- Delivery date
- City
- Category
- Payment method
- Quantity
- Order amount

### Returns

Contains return-level information such as:

- Return ID
- Order ID
- Return date
- Return reason
- Return status
- Refund amount
- Reverse shipping cost
- Restocking loss

---

## Dataset Size

| Dataset | Records |
|---|---:|
| Customers | 600 |
| Products | 48 |
| Orders | 9,000 |
| Returns | 1,676 |

---

# Data Preparation

## Power Query

Power Query was used to clean and standardize the datasets before analysis.

Key transformations included:

- Setting appropriate data types
- Converting dates to Date format
- Converting identifiers to Whole Number
- Converting financial fields to Decimal Number
- Standardizing text fields
- Removing unnecessary columns
- Creating a calculated `Total Return Cost` column

### Total Return Cost

The return cost was calculated as:

```text
Total Return Cost =
Refund Amount
+ Reverse Shipping Cost
+ Restocking Loss
```

---

# SQL Analysis

The cleaned data was loaded into a MySQL database named:

```text
ecommerce_returns
```

The SQL analysis focused on nine business questions.

### 1. Overall Return Rate & Total Return Cost

Measured:

- Total orders
- Returned orders
- Overall return rate
- Total return cost

Results:

- Total Orders: **9,000**
- Returned Orders: **1,676**
- Return Rate: **18.62%**
- Total Return Cost: **₹69,59,047.17**

### 2. Return Rate by Payment Method

Compared return behaviour between Cash on Delivery (COD) and prepaid orders.

| Payment Method | Total Orders | Returned Orders | Return Rate |
|---|---:|---:|---:|
| COD | 3,728 | 895 | **24.01%** |
| Prepaid | 5,272 | 781 | **14.81%** |

### 3. Return Rate by City

| City | Return Rate |
|---|---:|
| Hyderabad | **20.20%** |
| Delhi NCR | **19.17%** |
| Pune | **18.98%** |
| Kochi | **18.86%** |
| Chennai | **18.75%** |
| Bangalore | **18.34%** |
| Mumbai | **16.90%** |

### 4. Return Rate by Product Category

| Category | Return Rate |
|---|---:|
| Fashion & Apparel | **29.02%** |
| Footwear | **25.73%** |
| Accessories | **16.19%** |
| Home & Kitchen | **16.16%** |
| Electronics | **12.64%** |
| Beauty & Personal Care | **12.37%** |

### 5. Return Reasons by Product Category

The analysis examined which return reasons were associated with different product categories.

Examples include:

- Fashion & Apparel → **Size/Fit Issue**
- Electronics → **Defective/Damaged**
- Accessories → **Changed Mind**
- Accessories → **Not as Described**
- Beauty & Personal Care → **Not as Described**

### 6. Monthly Return Trend

Monthly return activity was analyzed to identify changes in return behaviour over time.

Examples of observed monthly return rates include:

- August 2024 → **20.43%**
- January 2025 → **20.10%**
- July 2024 → **19.84%**
- June 2024 → **16.07%**

### 7. Month-over-Month Return Rate Change

The SQL `LAG()` window function was used to compare monthly return rates and calculate month-over-month percentage-point changes.

This helps identify periods where return performance increased or decreased relative to the previous month.

### 8. Top Products by Return Cost

Products were ranked based on total return-related cost.

Examples of high-cost products included:

- Electronics Item 2 → **₹4,79,693.20**
- Electronics Item 4 → **₹4,85,140.26**
- Footwear Item 8 → **₹3,11,424.04**
- Footwear Item 7 → **₹3,06,853.00**

### 9. Average Days to Return

Average return time was calculated using:

```text
Delivery Date → Return Date
```

| Category | Average Days to Return |
|---|---:|
| Footwear | **7.17** |
| Fashion & Apparel | **6.95** |
| Home & Kitchen | **6.84** |
| Beauty & Personal Care | **6.81** |
| Electronics | **6.80** |
| Accessories | **6.67** |

---

# Excel Analysis

Excel was used for detailed return-cost analysis and customer-level return-frequency analysis.

## Return Cost Calculator

A return-cost calculator was created using:

```text
Refund Amount
+ Reverse Shipping Cost
+ Restocking Loss
```

The workbook calculates:

- Total return cost
- Average return cost
- Total number of returns
- Return cost by reason
- Return cost by product category

### Overall Return Cost

**₹69,59,047.17**

### Average Return Cost

**₹4,152.18**

### Return Cost by Reason

| Return Reason | Total Return Cost |
|---|---:|
| Better Price Found | **₹3,94,162.82** |
| Changed Mind | **₹12,87,960.34** |
| Defective/Damaged | **₹22,38,263.23** |
| Not as Described | **₹14,15,301.73** |
| Size/Fit Issue | **₹14,72,508.09** |
| Wrong Item Delivered | **₹1,50,850.96** |

### Return Cost by Product Category

| Category | Total Return Cost |
|---|---:|
| Fashion & Apparel | **₹9,29,453.75** |
| Footwear | **₹16,74,655.16** |
| Accessories | **₹3,82,571.24** |
| Home & Kitchen | **₹7,65,489.50** |
| Electronics | **₹30,15,026.49** |
| Beauty & Personal Care | **₹1,91,851.03** |

## High Return-Frequency Customers

Customer return frequency was analyzed using Excel formulas.

Customers with **3 or more returned orders** were flagged as:

```text
High Return Frequency
```

This is a behavioural segmentation flag for further analysis and **does not imply fraud or inappropriate behaviour**.

---

# Power BI Dashboard

The final Power BI dashboard contains three analytical pages.

## Page 1 — Executive Overview

### Purpose

Provides a high-level view of overall return performance and financial impact.

### KPIs

- Total Orders → **9,000**
- Total Returned Orders → **1,676**
- Return Rate → **18.62%**
- Total Return Cost → **₹69,59,047**

### Filters

- Category
- City
- Payment Method
- Year

### Visualizations

- Return Rate by Product Category
- Return Cost by Product Category
- Return Rate by Payment Method
- Monthly Return Rate Trend

---

## Page 2 — Return Drivers & Cost Intelligence

### Purpose

Identifies the major reasons behind returns and their financial impact.

### KPIs

- Total Refund Value → **₹58,72,080**
- Total Reverse Shipping Cost → **₹2,01,337**
- Total Restocking Loss → **₹8,85,630**

These components together represent the total return cost:

**₹69,59,047**

### Filters

- Return Reason
- Product Category

### Visualizations

- Return Reasons
- Return Cost by Reason
- Return Cost by Product Category

---

## Page 3 — Customer & Operations Insights

### Purpose

Analyzes customer behaviour, geographical patterns, return timing, and operational return characteristics.

### Filters

- City
- Product Category

### Visualizations

- High Return-Frequency Customers
- Return Rate by City
- Average Days to Return by Category
- Return Status Breakdown
- Return Reasons by City

### Return Status Breakdown

Returned orders are divided into:

- Approved → **155 (9.25%)**
- Rejected → **1,521 (90.75%)**

---

# Key Business Findings

## Overall Return Performance

The dataset contains **9,000 orders**, of which **1,676 were returned**.

This results in an overall return rate of:

**18.62%**

The total return-related cost is:

**₹69,59,047.17**

## Payment Method

COD orders have a higher observed return rate than prepaid orders in this dataset:

- COD → **24.01%**
- Prepaid → **14.81%**

This difference can be investigated further to understand whether payment method is associated with specific customer or operational patterns.

## Product Categories

Fashion & Apparel and Footwear have the highest observed return rates:

- Fashion & Apparel → **29.02%**
- Footwear → **25.73%**

Electronics has a lower return rate of **12.64%**, but it generates the highest total return cost among the product categories.

## Return Reasons

Major return reasons include:

- Size/Fit Issue
- Defective/Damaged
- Not as Described
- Changed Mind
- Better Price Found
- Wrong Item Delivered

Fashion & Apparel shows a notable association with **Size/Fit Issue**, while Electronics shows notable **Defective/Damaged** returns.

## Return Cost

The total return cost consists of:

- Refund Value → **₹58,72,080**
- Reverse Shipping Cost → **₹2,01,337**
- Restocking Loss → **₹8,85,630**

Total:

**₹69,59,047**

Electronics has the highest total return cost among the product categories at approximately:

**₹30.15 lakh**

## City-Level Analysis

Return rates vary across cities.

The highest observed city-level return rate in the dataset is:

**Hyderabad → 20.20%**

The lowest observed city-level return rate is:

**Mumbai → 16.90%**

These differences can help identify locations that may require further operational investigation.

## Return Timing

The average number of days between delivery and return varies by category.

Footwear has the highest average return time:

**7.17 days**

Accessories has the lowest:

**6.67 days**

---

# Business Recommendations

The following recommendations are based on the observed patterns in the analysis.

## 1. Improve Size & Fit Information

Fashion & Apparel has a high observed return rate, with Size/Fit Issue being an important return reason.

Potential actions:

- Improve size charts
- Add detailed product measurements
- Provide fit guidance
- Analyze product-level size-return patterns

## 2. Investigate Product Quality

Electronics has the highest total return cost and notable defective/damaged returns.

Potential actions:

- Review supplier quality
- Strengthen packaging
- Analyze defective-return rates by product
- Monitor supplier-level return patterns

## 3. Analyze COD Return Behaviour

COD has a higher observed return rate than prepaid orders.

Potential actions:

- Investigate COD-specific return patterns
- Analyze repeat-return behaviour
- Review delivery and order-confirmation processes

## 4. Reduce Reverse Logistics Cost

Return-cost analysis can help identify products and categories generating high return-related costs.

Potential actions:

- Review high-cost products
- Analyze reverse shipping expenses
- Improve restocking processes
- Identify products with repeated return activity

## 5. Monitor High Return-Frequency Customers

Customers with multiple returned orders can be monitored as a behavioural segment.

This should be used for further analysis rather than treating the flag as evidence of fraud.

---

# Project Workflow

```text
Raw Data
    ↓
Data Cleaning
    ↓
Power Query
    ↓
MySQL Database
    ↓
SQL Business Analysis
    ↓
Excel Analysis
    ↓
Power BI Data Model
    ↓
DAX Measures
    ↓
Interactive Dashboard
    ↓
Business Insights
    ↓
Recommendations
```

---

# Project Structure

```text
Project_2_ECommerce_Returns_Analytics
│
├── data
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   └── returns.csv
│
├── sql
│   └── returns_analysis_queries.sql
│
├── excel
│   └── Returns_Analysis.xlsx
│
├── powerbi
│   └── ECommerce_Returns_Intelligence.pbix
│
└── README.md
```

---

# Skills Demonstrated

## SQL

- SELECT
- JOIN
- GROUP BY
- Aggregate functions
- Date functions
- `LAG()` window function
- Business KPI calculations
- Return-rate analysis
- Cost analysis

## Excel

- Excel Tables
- Lookup functions
- Conditional logic
- `COUNTIF`
- `UNIQUE`
- KPI calculations
- Return-cost analysis
- Customer return-frequency analysis

## Power Query

- Data cleaning
- Data-type transformation
- Column removal
- Custom columns
- Multi-table preparation

## Power BI

- Data modeling
- Relationships
- DAX measures
- KPI cards
- Slicers
- Bar charts
- Column charts
- Donut charts
- Interactive filtering
- Dashboard design

## Business Analytics

- Return-rate analysis
- Cost analysis
- Customer behaviour analysis
- Operational analysis
- Root-cause analysis
- Business recommendations

---

# Conclusion

This project demonstrates an end-to-end data analytics workflow using SQL, Excel, Power Query, and Power BI.

The analysis transforms raw e-commerce order and return data into a business intelligence solution that highlights:

- Return performance
- Financial impact
- Product and category-level drivers
- Customer behaviour
- Geographical patterns
- Operational return timing

The final dashboard provides an interactive way for business users to explore return activity and identify areas for further investigation and potential cost reduction.
