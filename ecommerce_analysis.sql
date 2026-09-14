-- E-Commerce Sales & Customer Analytics
-- Advanced SQL Analysis
-- Database: SQLite
-- Main table: ecommerce

-- 01. Regional Performance
SELECT
    region,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) * 100.0 / SUM(net_sales), 2) AS profit_margin
FROM ecommerce
GROUP BY region
ORDER BY total_sales DESC;

-- 02. High-Value Delayed Orders
SELECT
    order_id, order_date, region, shipping_method,
    net_sales, profit, delivery_status
FROM ecommerce
WHERE delivery_status = 'Delayed'
  AND net_sales > 1000
ORDER BY net_sales DESC
LIMIT 20;

-- 03. Order Value Segmentation
SELECT
    CASE
        WHEN net_sales < 500 THEN 'Low Value'
        WHEN net_sales <= 1500 THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_segment,
    COUNT(DISTINCT order_id) AS orders,
    COUNT(DISTINCT customer_id) AS customers,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) * 100.0 / SUM(net_sales), 2) AS profit_margin
FROM ecommerce
GROUP BY
    CASE
        WHEN net_sales < 500 THEN 'Low Value'
        WHEN net_sales <= 1500 THEN 'Medium Value'
        ELSE 'High Value'
    END
ORDER BY total_sales DESC;

-- 04. High-Sales Regions
SELECT
    region,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(net_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM ecommerce
GROUP BY region
HAVING SUM(net_sales) > 30000000
ORDER BY total_sales DESC;

-- 05. Customers Above Average Sales
SELECT
    customer_id,
    ROUND(SUM(net_sales), 2) AS total_sales
FROM ecommerce
GROUP BY customer_id
HAVING SUM(net_sales) > (
    SELECT AVG(customer_sales)
    FROM (
        SELECT customer_id, SUM(net_sales) AS customer_sales
        FROM ecommerce
        GROUP BY customer_id
    )
)
ORDER BY total_sales DESC
LIMIT 20;

-- 06. Customer Summary JOIN
SELECT DISTINCT
    cs.customer_id,
    e.customer_name,
    e.customer_segment,
    cs.total_orders,
    ROUND(cs.total_sales, 2) AS total_sales,
    ROUND(cs.total_profit, 2) AS total_profit
FROM customer_summary AS cs
INNER JOIN ecommerce AS e
    ON cs.customer_id = e.customer_id
ORDER BY cs.total_sales DESC
LIMIT 20;

-- 07. Multiple JOIN
SELECT
    cs.customer_id,
    ci.customer_name,
    ci.customer_segment,
    cm.marketing_channel,
    cm.orders,
    ROUND(cm.sales, 2) AS sales,
    ROUND(cm.profit, 2) AS profit
FROM customer_summary AS cs
INNER JOIN customer_info AS ci
    ON cs.customer_id = ci.customer_id
INNER JOIN customer_marketing AS cm
    ON cs.customer_id = cm.customer_id
ORDER BY cs.total_sales DESC
LIMIT 30;

-- 08. CTE: Regions Above Overall Profit Margin
WITH regional_performance AS (
    SELECT
        region,
        SUM(net_sales) AS total_sales,
        SUM(profit) AS total_profit,
        SUM(profit) * 100.0 / SUM(net_sales) AS profit_margin
    FROM ecommerce
    GROUP BY region
),
overall_performance AS (
    SELECT SUM(profit) * 100.0 / SUM(net_sales) AS overall_margin
    FROM ecommerce
)
SELECT
    rp.region,
    ROUND(rp.total_sales, 2) AS total_sales,
    ROUND(rp.total_profit, 2) AS total_profit,
    ROUND(rp.profit_margin, 2) AS profit_margin,
    ROUND(op.overall_margin, 2) AS overall_margin
FROM regional_performance AS rp
CROSS JOIN overall_performance AS op
WHERE rp.profit_margin > op.overall_margin
ORDER BY rp.profit_margin DESC;

-- 09. Window Function: Customer Sales Ranking
WITH customer_sales AS (
    SELECT
        customer_id,
        customer_segment,
        SUM(net_sales) AS total_sales
    FROM ecommerce
    GROUP BY customer_id, customer_segment
)
SELECT
    customer_id,
    customer_segment,
    ROUND(total_sales, 2) AS total_sales,
    RANK() OVER (
        PARTITION BY customer_segment
        ORDER BY total_sales DESC
    ) AS segment_rank
FROM customer_sales
ORDER BY customer_segment, segment_rank
LIMIT 30;

-- 10. Top 3 Customers in Each Segment
WITH customer_sales AS (
    SELECT
        customer_id,
        customer_segment,
        SUM(net_sales) AS total_sales
    FROM ecommerce
    GROUP BY customer_id, customer_segment
),
ranked_customers AS (
    SELECT
        customer_id,
        customer_segment,
        total_sales,
        RANK() OVER (
            PARTITION BY customer_segment
            ORDER BY total_sales DESC
        ) AS sales_rank
    FROM customer_sales
)
SELECT
    customer_id,
    customer_segment,
    ROUND(total_sales, 2) AS total_sales,
    sales_rank
FROM ranked_customers
WHERE sales_rank <= 3
ORDER BY customer_segment, sales_rank;

-- 11. Monthly Sales Growth Using LAG()
WITH monthly_sales AS (
    SELECT
        strftime('%Y-%m', order_date) AS month,
        SUM(net_sales) AS total_sales
    FROM ecommerce
    GROUP BY strftime('%Y-%m', order_date)
),
monthly_comparison AS (
    SELECT
        month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(previous_month_sales, 2) AS previous_month_sales,
    ROUND(
        (total_sales - previous_month_sales) * 100.0
        / previous_month_sales,
        2
    ) AS sales_growth_percentage
FROM monthly_comparison
ORDER BY month;
