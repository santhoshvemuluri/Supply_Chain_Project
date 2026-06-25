# Supply Chain KPI Monitoring & Analysis

## 📌 Project Overview
This project analyzes logistics data to identify structural trends, delivery bottlenecks, and areas for supply chain optimization. By leveraging complex SQL queries for data extraction and Advanced Excel (Pivot Tables & Macros) for visualization, this project provides a continuous reporting mechanism for real-time logistics performance metrics (KPIs).

## 🛠️ Tech Stack
* **Database & Data Manipulation:** SQL (MySQL/PostgreSQL)
* **Data Visualization & Dashboarding:** Advanced Excel (Pivot Tables, Slicers, Power Query)
* **Automation:** Excel VBA (Macros)
* **Dataset:** [Kaggle: DataCo Smart Supply Chain](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)

## 🎯 Objectives
1. **Preprocess and Clean Data:** Handle missing values, standardize shipping dates, and remove duplicate order entries.
2. **KPI Extraction (SQL):** Calculate On-Time Delivery Rates, Average Order Cycle Times, and Late Delivery Risk percentages.
3. **Dashboard Design (Excel):** Build an interactive dashboard for non-technical stakeholders to filter metrics by region, shipping mode, and product category.
4. **Process Automation:** Implement a VBA Macro to instantly refresh all data connections and clear slicer filters with a single click.

## 📊 Key Insights Generated
* **Bottleneck Identification:** Identified that 'Standard Class' shipping to the specific regions accounted for 45% of all late deliveries.
* **Cycle Time Optimization:** Uncovered an average delay of 2.4 days in processing orders categorized as 'High Risk'.
* **Cost vs. Delivery Mode:** Highlighted discrepancies in shipping costs per unit between 'First Class' and 'Same Day' shipping relative to their actual on-time performance.

## 📁 Repository Structure
* `/sql_queries` - Contains SQL scripts for data cleaning and KPI aggregations.
* `/excel_dashboard` - Contains the VBA macro code used for dashboard automation. *(Note: The raw .xlsx file is excluded due to size limits, but the logic is documented here).*
