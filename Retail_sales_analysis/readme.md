# 🛍️ Retail Sales Analysis – SQL Project

Welcome to the **Retail Sales Analysis Project**!  
This project demonstrates how SQL can be used to **analyze retail transaction data**, extract valuable insights, and solve **real business problems**.

---

## 📂 **Project Overview**
Retail businesses generate large amounts of sales data every day. In this project, we:
- Created a **structured retail sales database**
- Cleaned and validated the dataset
- Performed **data exploration** and **analysis**
- Solved real-world **business questions** using SQL

---

## 🗄️ **Database Schema**
The project is built around a single main table:

**`retail_sales`**
| Column Name     | Data Type      | Description                           |
|-----------------|---------------|---------------------------------------|
| transactions_id | INT (PK)      | Unique ID for each transaction        |
| sale_date       | DATE          | Date of sale                          |
| sale_time       | TIME          | Time of sale                          |
| customer_id     | INT           | Customer ID                           |
| gender          | VARCHAR(15)   | Gender of the customer                |
| age             | INT           | Age of the customer                   |
| category        | VARCHAR(15)   | Product category (Clothing, Beauty, etc.) |
| quantiy         | INT           | Quantity purchased                    |
| price_per_unit  | FLOAT         | Price per item                        |
| cogs            | FLOAT         | Cost of goods sold                    |
| total_sale      | FLOAT         | Total sale amount                     |

---

## 🔍 **Key SQL Tasks Performed**
✅ **Data Cleaning**
- Identified and removed rows with NULL values  
- Ensured transaction IDs were unique and valid  

✅ **Data Exploration**
- Total sales count  
- Number of unique customers  
- Distinct product categories  

✅ **Business Questions Solved**
1️⃣ Retrieve all sales made on a specific date (`2022-11-05`)  
2️⃣ Find transactions in **Clothing** category with quantity > 4 in Nov-2022  
3️⃣ Calculate **total sales by category**  
4️⃣ Find **average age** of customers purchasing **Beauty** products  
5️⃣ Identify all transactions with **total sales > 1000**  
6️⃣ Count **transactions by gender** in each category  
7️⃣ Calculate **monthly sales** and identify best-selling month each year  
8️⃣ Find **Top 5 customers** by total sales  
9️⃣ Count **unique customers** per category  

---

## 📊 **Sample Insights**
- 🥇 **Top Category:** Clothing accounted for the highest revenue  
- 🧾 **Best-Selling Month:** November showed the highest sales spike  
- 👥 **Customer Profile:** Beauty category attracted younger customers (avg age lower)  

---

## 🛠️ **Tech Stack**
- **Database:** MySQL  
- **Tool:** MySQL Workbench  
- **Language:** SQL

---

## 🚀 **How to Use**
1️⃣ **Clone the Repository**
```bash
https://github.com/asadimam030/sql-case-studies/tree/main/Retail_sales_analysis
