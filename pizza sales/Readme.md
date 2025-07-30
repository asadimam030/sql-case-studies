
# 🍕 Pizza Sales Analysis  
**SQL Case Study**  

**Author:** Md. As ad imam
**Email:** asadimam030@gmail.com
**GitHub:** https://github.com/asadimam030


---

## 📖 Introduction  

The **Pizza Sales Analysis** project focuses on exploring and analyzing a pizza store’s sales database using **SQL**. The objective is to gain valuable business insights about pizza sales trends, customer preferences, and revenue drivers.  

This project simulates a real-world business scenario where data-driven decisions can help the business optimize its menu, pricing, and marketing strategies.

---

## 🗂️ Dataset  

The analysis is based on a fictional pizza sales dataset that contains the following key tables:  

- **`orders`**: Contains information about each pizza order placed by customers.  
- **`order_details`**: Line-item details for each order, including pizza quantity.  
- **`pizzas`**: Includes pizza names, sizes, and prices.  
- **`pizza_types`**: Contains pizza categories (classic, supreme, veggie, etc.) and ingredients.  

---

## 🧹 Data Cleaning  

Before analysis, some data preparation was required:  

- ✅ Ensured consistent date and time formats in the `orders` table.  
- ✅ Checked for null or missing values in key columns.  
- ✅ Standardized pizza size and category values.  
- ✅ Created temporary views to handle intermediate transformations.

---

## 📊 Case Study & Analysis  

This project answers several business questions, such as:  

- 📅 **What are the busiest days and months for pizza sales?**  
- 🍕 **Which pizzas generate the highest revenue?**  
- 📐 **Which pizza sizes are the most popular?**  
- 🏆 **What are the top 3 pizzas by revenue in each category?** *(using SQL window functions)*  
- 💸 **How much cumulative revenue is generated over time?**  

---

## 📈 Insights  

- The **Large** and **Extra-Large pizzas** generated the most revenue.  
- **Classic Deluxe** emerged as the **top-selling pizza by revenue**.  
- Peak sales occur on **weekends**, particularly **Friday & Saturday evenings**.  
- Monthly revenue trends show **December** as the strongest month, indicating seasonal demand.

---

## 🚀 How to Use  

1️⃣ Clone this repository:  
```bash
git clone [https://github.com/asadimam030/pizza-sales-analysis.git]

