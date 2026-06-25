
-- Phase 2: Logistics KPI Extraction & Aggregation

-- KPI 1: Overall On-Time Delivery Rate
SELECT 
    COUNT(CASE WHEN Delivery_Status IN ('On Time', 'Advance Delivery') THEN 1 END) * 100.0 / COUNT(*) AS On_Time_Delivery_Rate
FROM 
    supply_chain_data;

-- KPI 2: Identify Delivery Bottlenecks by Region and Shipping Mode
-- This query helps identify exactly where logistics are failing
SELECT 
    Order_Region,
    Shipping_Mode,
    COUNT(*) AS Total_Orders,
    SUM(CASE WHEN Delivery_Status = 'Late Delivery' THEN 1 ELSE 0 END) AS Late_Orders,
    (SUM(CASE WHEN Delivery_Status = 'Late Delivery' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Late_Delivery_Percentage
FROM 
    supply_chain_data
GROUP BY 
    Order_Region, 
    Shipping_Mode
HAVING 
    Total_Orders > 100 -- Filtering out statistically insignificant sample sizes
ORDER BY 
    Late_Delivery_Percentage DESC;

-- KPI 3: Average Order Cycle Time (Days from Order to Shipping)
SELECT 
    Category_Name,
    ROUND(AVG(Days_for_shipping_real), 2) AS Avg_Actual_Shipping_Days,
    ROUND(AVG(Days_for_shipment_scheduled), 2) AS Avg_Scheduled_Shipping_Days,
    ROUND(AVG(Days_for_shipping_real - Days_for_shipment_scheduled), 2) AS Avg_Delay_Days
FROM 
    supply_chain_data
GROUP BY 
    Category_Name
ORDER BY 
    Avg_Delay_Days DESC;

-- KPI 4: Financial Impact of Late Deliveries
SELECT 
    Delivery_Status,
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Order_Profit_Per_Order), 2) AS Total_Profit,
    ROUND(AVG(Shipping_Cost), 2) AS Avg_Shipping_Cost_Per_Order
FROM 
    supply_chain_data
GROUP BY 
    Delivery_Status;
