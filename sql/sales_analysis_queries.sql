-- SALES PERFORMANCE ANALYSIS QUERIES
-- Business Problem: Analyze sales performance to identify trends and opportunities

-- 1. Total Sales and Profit by Region
SELECT 
    region,
    SUM(units_sold * unit_price) as total_revenue,
    SUM(units_sold * (unit_price - cost_price)) as total_profit,
    ROUND(SUM(units_sold * (unit_price - cost_price)) / SUM(units_sold * unit_price) * 100, 2) as profit_margin
FROM sales_data
GROUP BY region
ORDER BY total_revenue DESC;

-- 2. Top Performing Products
SELECT 
    product,
    category,
    SUM(units_sold) as total_units,
    SUM(units_sold * unit_price) as total_revenue
FROM sales_data
GROUP BY product, category
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Monthly Sales Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') as month,
    SUM(units_sold * unit_price) as monthly_revenue,
    COUNT(DISTINCT order_id) as order_count
FROM sales_data
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 4. Salesperson Performance Ranking
SELECT 
    salesperson,
    region,
    SUM(units_sold * unit_price) as total_sales,
    SUM(units_sold * (unit_price - cost_price)) as total_profit,
    ROUND(AVG(units_sold * (unit_price - cost_price) / (units_sold * unit_price)) * 100, 2) as avg_margin
FROM sales_data
GROUP BY salesperson, region
ORDER BY total_sales DESC;

-- 5. Category Performance Analysis
SELECT 
    category,
    SUM(units_sold * unit_price) as category_revenue,
    ROUND(SUM(units_sold * unit_price) / (SELECT SUM(units_sold * unit_price) FROM sales_data) * 100, 2) as revenue_percentage
FROM sales_data
GROUP BY category
ORDER BY category_revenue DESC;
