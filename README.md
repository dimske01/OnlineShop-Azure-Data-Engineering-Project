# Online Shop – Azure Data Engineering Project

## 1. Project Overview

This project demonstrates an end-to-end data engineering and analytics workflow for an online shop.

The main objective was to build a data pipeline that transfers data from CSV files into an Azure SQL Database, perform data quality checks and SQL transformations, automate database operations using Azure Data Factory, and finally create an interactive Power BI dashboard to analyze business performance.

The project covers the main stages of a data workflow, from data ingestion and preparation to analysis and visualization.

## 2. Technologies & Tools

- **Microsoft Azure SQL Database:** Relational database used to store and manage the online shop data.
- **Azure Data Factory:** Used to create and execute data pipelines for transferring data from Azure Blob Storage to Azure SQL Database.
- **Microsoft SQL:** Used for data quality checks, data cleaning, transformations, joins, aggregations, views, CTEs and stored procedures.
- **Microsoft Power BI:** Used to create an interactive dashboard and visualize business metrics.
- **Microsoft Excel:** Used for initial data inspection and preparation.
- **Azure Blob Storage:** Used to store the original CSV files.

## 3. Dataset & Database Structure

The project uses six CSV files representing the main entities of an online shop.

The Azure SQL Database contains six relational tables:

| Table | Rows |
|---|---:|
| customers | 200 |
| categories | 10 |
| products | 100 |
| orders | 480 |
| order_items | 791 |
| payments | 480 |

The tables are connected through primary and foreign key relationships, allowing data to be analyzed across customers, orders, products, categories and payments.

## 4. Data Ingestion – Azure Data Factory

Azure Data Factory was used to build a pipeline named `PL_Load_OnlineShop`.

The pipeline transfers data from CSV files stored in Azure Blob Storage into the corresponding tables in Azure SQL Database.

Copy activities were configured to move the source data to the database. A Stored Procedure activity was also added to execute a database procedure as part of the pipeline workflow.

This demonstrated how data ingestion and database operations can be organized and automated using Azure Data Factory.

## 5. Data Quality Checks & Data Preparation

SQL queries were used to investigate the quality and consistency of the data before performing the analysis.

The checks included:

- Identifying missing values (NULLs).
- Checking duplicate customer email addresses.
- Identifying duplicate product names.
- Detecting duplicate order and product combinations in `order_items`.
- Checking payment validity.
- Verifying primary and foreign key relationships.
- Investigating consistency between related tables.

The checks identified duplicate customer emails, repeated product names and repeated order/product combinations.

No NULL values were found in the checked customer, product and category columns, and the payment validation query returned zero invalid payments.

These checks helped identify potential data quality issues and understand the relationships between the database tables.

## 6. SQL Data Analysis

After examining the data quality, SQL was used to perform business analysis.

The analysis included:

- Total spending and order activity per customer.
- Identifying the customers with the highest total spending.
- Finding customers with the highest number of orders.
- Comparing order amounts with payment amounts.
- Analyzing customer payment method preferences.
- Combining information from multiple tables using JOINs.
- Using GROUP BY, HAVING, aggregate functions and Common Table Expressions (CTEs).

Views were also created to organize reusable query results.

### Key Findings

Some of the main findings from the analysis were:

- The customers with the highest number of orders had 6 orders each.
- Kai Ali had the highest total spending, with 15,939.05.
- Lucas Smith and Felix Moreau followed with 12,947.06 and 12,553.50 respectively.
- Credit card was the most frequently used payment method, with 260 payments, followed by PayPal with 138 and bank transfer with 82.
- The orders table contained 273 completed, 164 pending and 43 cancelled orders.

These findings demonstrate how SQL can be used to extract useful business information from relational data.

## 7. Stored Procedure & Automation

A SQL Stored Procedure was created to automate the customer summary update process.

Instead of manually executing the same SQL operations each time, the stored procedure groups the relevant operations into a reusable database procedure.

The procedure was also integrated into Azure Data Factory through a Stored Procedure activity.

This demonstrates how database logic can be reused and incorporated into an automated data pipeline.

## 8. Power BI Dashboard

Microsoft Power BI was used to connect to Azure SQL Database and build an interactive dashboard.

The dashboard presents key business metrics and visualizations, including:

- Total Sales.
- Customer-related metrics.
- Payment method distribution.
- Order and sales analysis.
- Interactive filters and visual comparisons.

The dashboard provides a visual overview of the online shop's business performance and makes the analysis easier to understand.

## 9. Project Workflow

The project followed these main stages:

1. Collecting and inspecting the original CSV files.
2. Uploading the source files to Azure Blob Storage.
3. Creating and populating the Azure SQL Database.
4. Establishing relationships between the database tables.
5. Building the Azure Data Factory ingestion pipeline.
6. Performing SQL data quality checks and data preparation.
7. Conducting SQL business analysis.
8. Creating views and a stored procedure.
9. Integrating the stored procedure into Azure Data Factory.
10. Building the final Power BI dashboard.

## 10. Key Skills Demonstrated

- Relational database design and relationships.
- SQL querying and data analysis.
- Data quality checks and data preparation.
- JOINs, CTEs, aggregate functions and views.
- Stored procedures and reusable SQL logic.
- Azure SQL Database.
- Azure Data Factory pipelines and Copy activities.
- Azure Blob Storage.
- Power BI dashboard development.
- End-to-end data workflow understanding.

## 11. Conclusion

This project provided practical experience in building a data workflow using Microsoft Azure, SQL and Power BI.

It demonstrates the process of moving raw data into a relational database, examining data quality, transforming and analyzing information, automating database operations, and presenting business insights through an interactive dashboard.
