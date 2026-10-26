# Olist Delivery Performance Analysis

SQL (SQLite) + Power BI analysis of the Brazilian E-Commerce Public Dataset by Olist ([Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data)). Focus: delivery performance and its link to customer satisfaction.

--Dashboard (POWER BI);
<img width="1270" height="724" alt="Dashboard" src="https://github.com/user-attachments/assets/2e5bd7d7-a8bc-4e3b-bc5f-96ffac0d482e" />



## Key findings

1. **Strong growth in 2017, plateau in 2018.** Monthly orders rose from 787 (Jan 2017) to 7,421 (Nov 2017) and stayed between ~6,100 and ~7,200 in 2018. Growth is almost entirely volume-driven: average revenue per order stays between 125 and 153.
2. **About 8.1% of delivered orders arrive after the estimated date,** with spikes in Nov 2017 (14.3%), Feb 2018 (16.0%) and Mar 2018 (21.4%). Order volume alone does not explain the spikes.
3. **Late delivery is associated with much lower review scores:** 2.57 for late orders vs 4.30 for on-time orders. This is an association, not proof of causation.

## Recommendation

Late deliveries spike in peak months (up to 21.4% in 2018-03 vs 8.1% on average) and are associated with much lower review scores (2.57 vs 4.30). I would first break late orders down by customer state and seller to find where delays concentrate, then add capacity or earlier customer notifications for those regions before high-volume periods such as November.

## Business questions

1. How do monthly orders and revenue develop?
2. Which product categories generate the most revenue?
3. What is the average delivery time and the late-delivery rate?
4. How do late deliveries relate to review scores?

## Method and assumptions

- Scope: orders purchased 2017-01 to 2018-08. 2016 is sparse (no orders in 2016-11) and data is cut off after 2018-08.
- Revenue = item price, excluding freight; canceled and unavailable orders excluded.
- Delivery metrics use delivered orders only. Late = delivered after the estimated delivery date; late rate = late orders / delivered orders. 8 delivered orders without a delivery date are excluded.
- Review analysis uses orders with exactly one review. Orders with several reviews (~0.6%) are excluded; the effect of this exclusion was not tested.
- SQLite date functions (`strftime`, `julianday`) differ from SQL Server and PostgreSQL.

## Repository

-`SQL & CSV Files/` queries with comments (SQL), exported query results (CSV) 
- `dashboard/` Power BI file and screenshot
- Raw data is not included; download it from Kaggle.


Data source: Brazilian E-Commerce Public Dataset by Olist, via Kaggle. License: CC BY-NC-SA 4.0. https://creativecommons.org/licenses/by-nc-sa/4.0/
