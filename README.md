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

The project uses four related datasets:

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