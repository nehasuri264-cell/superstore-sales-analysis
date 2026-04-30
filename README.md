# 🛒 Super Store Sales Analysis — Excel + SQL + Power BI

An end-to-end sales analysis project on e-commerce data using **Advanced Excel** (Pivot Tables, Dashboard), **MySQL** (Aggregations, CTEs, Window Functions), and **Power BI** (Interactive Dashboard, DAX Measures).

---

## 📌 Project Objective

To analyze Super Store e-commerce sales data and extract actionable business insights around revenue trends, top-performing states, customer segments, and sales channels — simulating the kind of analysis a Business/Data Analyst would perform in a real company.

---

## 🔍 Key Business Insights

| Insight | Finding |
|--------|---------|
| 💰 Top 3 States | Maharashtra, Karnataka, UP → contribute **35% of total revenue** |
| 👩 Customer Segment | Women account for **65% of purchases** — primary target audience |
| 📦 Top Channels | Amazon, Myntra, Flipkart → drive **80% of all orders** |
| 👥 Age Group | Adults (26–45) are the **highest buying segment** |
| 📈 Growth Insight | Month-over-month growth tracked using SQL LAG() function |

---

## 🛠 Tools & Skills Used

### Excel
- Pivot Tables & Pivot Charts
- Interactive Dashboard with slicers
- Data aggregation and visualization
- Trend and segment analysis

### SQL (MySQL)
- `SELECT`, `WHERE`, `GROUP BY`, `ORDER BY`, `HAVING`
- Aggregate functions — `SUM`, `COUNT`, `AVG`
- Date functions — `STR_TO_DATE`, `YEAR`, `MONTH`
- **Window Functions** — `RANK()`, `SUM() OVER()`, `LAG()`
- **Nested Aggregates** — `SUM(SUM()) OVER()` for contribution %
- **CTE (WITH clause)** — for readable, modular subqueries
- Data quality checks — NULL detection, duplicate identification

### Power BI
- Connected live data from Excel source
- Built interactive dashboard with 6 visuals
- **DAX Measures** — `Avg Order Value = DIVIDE(SUM(Amount), COUNT(Order ID))`
- KPI Cards, Bar Chart, Donut Chart, Pie Chart, Line Chart
- Dynamic slicers for State and Channel filtering
- Published to Power BI Service for browser-based sharing

---

## 📊 Dashboard Preview

![Sales Performance Dashboard](Sales_Performance_Dashboard.png)

🔗 **[View Live Interactive Dashboard](#)** ← replace with your Power BI Service link

---

## 📂 Files in this Repository

| File | Description |
|------|-------------|
| `SQL file.sql` | 14 SQL queries with comments — from basic to advanced |
| `Excel analysis project.xlsx` | Pivot-based dashboard with business insights |
| `Sales_Performance_Dashboard.pdf` | Power BI dashboard export |
| `Sales_Performance_Dashboard.png` | Dashboard screenshot for preview |

---

## 📊 SQL Queries Overview

| # | Query | Concept Used |
|---|-------|-------------|
| 1 | View full dataset | SELECT * |
| 2 | Overall business summary | Aggregations |
| 3 | Monthly sales trend | GROUP BY + Date functions |
| 4 | Sales by city | GROUP BY + ORDER BY |
| 5 | Top 5 customers | LIMIT |
| 6 | Sales by category | Aggregation |
| 7 | NULL value check | Data Quality |
| 8 | Duplicate order detection | HAVING COUNT > 1 |
| 9 | Sales by channel | GROUP BY |
| 10 | Running total | SUM() OVER() — Window Function |
| 11 | City ranking | RANK() — Window Function |
| 12 | Customer revenue % | SUM(SUM()) OVER() — Nested Aggregate |
| 13 | Category revenue % | SUM(SUM()) OVER() — Nested Aggregate |
| 14 | Month-over-month growth | CTE + LAG() — Window Function |

---

## 💡 Business Recommendation

Target **women aged 26–45 in Maharashtra, Karnataka, and Uttar Pradesh** through **Amazon, Myntra, and Flipkart** with focused promotions and ads. This single segment represents the highest revenue opportunity based on the data.

---

## 👩‍💻 Author

**Neha Suri**
Aspiring Business Analyst | Excel • SQL • Power BI • Power Query


