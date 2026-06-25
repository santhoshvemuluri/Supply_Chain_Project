
--  Data Preprocessing and Cleaning

-- Identify and remove duplicate order entries
WITH CTE AS (
    SELECT 
        Order_Id, 
        ROW_NUMBER() OVER (PARTITION BY Order_Id ORDER BY Order_Date DESC) as row_num
    FROM 
        supply_chain_data
)
DELETE FROM supply_chain_data 
WHERE Order_Id IN (SELECT Order_Id FROM CTE WHERE row_num > 1);

-- 2. Standardize Date Formats (Assuming varchar dates in raw data)
-- Converting string dates to actual DATE formats for accurate time calculation
UPDATE supply_chain_data
SET 
    Order_Date = STR_TO_DATE(Order_Date, '%m/%d/%Y'),
    Shipping_Date = STR_TO_DATE(Shipping_Date, '%m/%d/%Y');

-- 3. Handle NULL values in critical logistics columns
-- Replace missing shipping costs with the average shipping cost of that specific region
UPDATE supply_chain_data AS sc1
JOIN (
    SELECT Order_Region, AVG(Shipping_Cost) as Avg_Cost 
    FROM supply_chain_data 
    WHERE Shipping_Cost IS NOT NULL 
    GROUP BY Order_Region
) AS sc2 ON sc1.Order_Region = sc2.Order_Region
SET sc1.Shipping_Cost = sc2.Avg_Cost
WHERE sc1.Shipping_Cost IS NULL;

-- 4. Create a standardized Delivery Status column
ALTER TABLE supply_chain_data ADD COLUMN Delivery_Status VARCHAR(50);

UPDATE supply_chain_data
SET Delivery_Status = CASE 
    WHEN Days_for_shipping_real > Days_for_shipment_scheduled THEN 'Late Delivery'
    WHEN Days_for_shipping_real < Days_for_shipment_scheduled THEN 'Advance Delivery'
    ELSE 'On Time'
END;
