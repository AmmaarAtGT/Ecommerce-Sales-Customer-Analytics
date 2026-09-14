# E-Commerce Sales & Customer Analytics

## Project Overview

This project analyzes e-commerce sales, customer behavior, marketing performance, delivery operations, returns, and profitability using Python, Pandas, NumPy, Matplotlib, and SQL.

The goal is to transform raw transactional data into actionable business insights that can support decisions around customer retention, marketing, profitability, and operational performance.

---

## Business Problem

An e-commerce business generates a large volume of customer and order data, but raw data alone does not provide clear answers to important business questions.

This project investigates questions such as:

* Which regions generate the most sales and profit?
* Which customer segments contribute the most revenue?
* How do high-value customers behave?
* Which marketing channels generate the most sales?
* How effective are coupons?
* How frequently are orders delayed?
* What are the most common return reasons?
* Which customers generate the most revenue?
* How does monthly sales performance change over time?

---

## Objectives

* Clean and prepare raw e-commerce data for analysis.
* Perform exploratory data analysis using Python.
* Analyze customer purchasing behavior.
* Evaluate regional sales and profitability.
* Analyze marketing channels and campaigns.
* Investigate delivery and return performance.
* Analyze customer lifetime value (CLV).
* Use SQL to perform advanced business analysis.
* Translate analytical findings into business recommendations.

---

## Dataset

The dataset contains approximately **138,000 order records** and **46 original columns** covering:

* Order information
* Customer information
* Sales and profit
* Payment methods
* Marketing channels
* Delivery performance
* Returns
* Customer ratings
* Review sentiment
* Customer lifetime value

Additional analytical features were created during data preparation, including:

* Year
* Month
* Quarter
* Day of week
* Discount percentage
* Cost percentage
* Calculated profit margin
* Coupon usage indicator

---

## Tools & Technologies

### Python

* Pandas
* NumPy
* Matplotlib

### SQL

* SQLite
* SELECT
* WHERE
* GROUP BY
* HAVING
* CASE WHEN
* Subqueries
* INNER JOIN
* LEFT JOIN
* Multiple JOINs
* CTEs
* Window functions
* RANK()
* LAG()

### Analysis Skills

* Data cleaning
* Missing-value handling
* Data transformation
* Exploratory data analysis
* Descriptive statistics
* Customer segmentation
* Business KPI analysis
* Trend analysis

---

## Data Cleaning

The dataset was inspected for:

* Missing values
* Duplicate records
* Data types
* Financial consistency
* Categorical inconsistencies

No fully duplicate rows were identified.

Several categorical missing values were handled explicitly. For example:

* Missing return status → `Not Returned`
* Missing return reason → `No Return`
* Missing coupon code → `No Coupon`
* Missing campaign name → `No Campaign`

The order date was converted to a proper datetime format for time-based analysis.

---

## Key KPIs

| KPI                     |    Result |
| ----------------------- | --------: |
| Total Sales             |  ~177.13M |
| Total Profit            |   ~76.15M |
| Total Orders            |   138,116 |
| Total Customers         |    24,911 |
| Average Order Value     | ~1,282.50 |
| Overall Profit Margin   |   ~42.99% |
| Return Rate             |    ~6.85% |
| Average Customer Rating | ~3.68 / 5 |

---

## Key Findings

### Regional Performance

South generated the highest sales and profit:

* Sales: ~55.59M
* Profit: ~23.34M
* Profit margin: ~41.99%

However, North achieved the highest profit margin at approximately **46.10%**, followed by West at approximately **45.02%**.

**Insight:** South is the largest revenue contributor, while North and West demonstrate stronger profitability efficiency.

---

### Customer Behavior

Customers placed an average of approximately **5.54 orders**, with a median of 5 orders.

Customer lifetime value analysis showed:

| CLV Segment | Customers | Average Orders |
| ----------- | --------: | -------------: |
| Low CLV     |     6,228 |           3.44 |
| Medium CLV  |    12,455 |           5.53 |
| High CLV    |     6,228 |           7.68 |

High-CLV customers generated approximately **77.67M in sales**.

**Insight:** Higher-CLV customers tend to place more orders, making them an important group for retention and loyalty strategies.

---

### Marketing Performance

Organic Search generated the highest sales among marketing channels at approximately **35.66M**, followed by:

* Google Ads: ~26.54M
* Direct: ~26.12M
* Facebook Ads: ~21.37M

Profit margins across marketing channels were relatively similar.

**Important limitation:** The dataset does not contain marketing spend, so true ROAS, CAC, or marketing ROI could not be calculated.

---

### Coupon Analysis

Approximately 20% of orders used coupons.

Coupon orders had a profit margin of approximately **43.08%**, compared with **42.96%** for orders without coupons.

Among the top-performing coupons by sales, `SAVE17` generated the highest sales.

**Insight:** Coupon usage did not show a large difference in recorded profit margin, but individual coupons should be evaluated separately before optimizing promotions.

---

### Delivery Performance

| Delivery Status | Percentage of Orders |
| --------------- | -------------------: |
| On Time         |               62.93% |
| Cancelled       |               17.78% |
| Delayed         |               12.23% |
| Early           |                7.06% |

Delayed orders had an average actual delivery time of approximately **6.83 days**, compared with an estimated **4.31 days**.

**Insight:** Delivery performance represents a significant operational opportunity. Delays are relatively consistent across regions, suggesting a broader operational issue rather than a problem isolated to one region.

---

### Returns

The overall return rate was approximately **6.85%**.

The largest individual return reason was:

**Wrong Product — 13.07% of returned orders**

Other major return reasons included:

* Other
* Changed Mind
* Size Issue
* Defective Product
* Late Delivery

**Insight:** Return reasons are relatively evenly distributed, so reducing returns may require several operational and customer-experience improvements rather than focusing on a single cause.

---

### Customer Satisfaction

Among records with available review sentiment:

* Positive: ~68.76%
* Neutral: ~30.54%
* Negative: ~0.70%

The average customer rating was approximately **3.68 / 5**.

A limitation was identified: returned orders did not contain customer ratings or review sentiment data, preventing a reliable analysis of the relationship between customer satisfaction and returns.

---

## SQL Analysis

The project includes an SQL analysis script covering:

1. Regional performance
2. High-value delayed orders
3. Order-value segmentation
4. High-sales regions
5. Customers above average sales
6. Customer JOIN analysis
7. Multiple JOIN analysis
8. CTE-based regional analysis
9. Customer sales ranking
10. Top 3 customers within each segment
11. Monthly sales growth using `LAG()`

The SQL work demonstrates both foundational and advanced analytical SQL techniques.

---

## Business Recommendations

### 1. Improve delivery reliability

With approximately 62.93% of orders delivered on time and 12.23% delayed, the business should investigate:

* Warehouse processing times
* Shipping partner performance
* Delivery estimates
* Regional logistics
* Customer communication during delays

### 2. Prioritize high-CLV customers

High-CLV customers place substantially more orders than low-CLV customers.

Potential strategies include:

* Loyalty programs
* Personalized offers
* Retention campaigns
* Early-access promotions

### 3. Investigate regional profitability

North and West achieve stronger margins than the largest sales region, South.

The business should investigate the operational or customer factors contributing to this difference.

### 4. Add marketing cost data

Future analysis should include:

* Marketing spend
* Customer acquisition cost
* Campaign cost
* Conversion rate

This would allow calculation of:

* ROAS
* CAC
* Campaign ROI
* Profit per acquired customer

### 5. Reduce product-related returns

The high proportion of "Wrong Product" returns suggests an opportunity to investigate:

* Product descriptions
* Product selection accuracy
* Order fulfillment
* Warehouse picking processes

---

## Limitations

Several limitations should be considered when interpreting the results:

* The dataset does not contain product-level information suitable for detailed product/category analysis.
* Marketing spend is unavailable, so ROAS and marketing ROI cannot be calculated.
* Returned orders do not contain customer rating or review sentiment data.
* The `is_repeat_customer` field appears to describe repeat behavior within the available dataset and should not be interpreted as a real-world retention rate without additional historical context.
* Recorded financial treatment of returned and cancelled orders should be validated against real business accounting rules before making financial decisions.

---

## Future Improvements

Future versions of the project could include:

* Product-level analysis
* Customer cohort analysis
* RFM customer segmentation
* Marketing ROI analysis
* Churn prediction
* Sales forecasting
* Customer lifetime value modeling
* Machine-learning-based return prediction
* Interactive Power BI dashboard

---

## Project Structure

```text
Ecommerce-Sales-Customer-Analytics/
│
├── data/
│   └── ecommerce_dataset.csv
│
├── notebooks/
│   └── Ecommerce_Sales_Customer_Analytics.ipynb
│
├── sql/
│   └── ecommerce_analysis.sql
│
├── visualizations/
│   └── charts/
│
├── reports/
│
└── README.md
```

---

## Conclusion

This project demonstrates an end-to-end data analytics workflow, from raw data cleaning and exploratory analysis to advanced SQL analysis and business recommendations.
## Dataset Availability

The original dataset is not included in this repository because its file size exceeds GitHub's standard file upload limit. The analysis notebook contains the complete data-cleaning, transformation, analysis, and visualization workflow used for this project.
The analysis highlights opportunities around customer retention, regional profitability, marketing measurement, delivery reliability, and return reduction.

The project demonstrates practical skills in **Python, Pandas, NumPy, Matplotlib, SQL, data cleaning, exploratory data analysis, customer analytics, and business problem solving**.
