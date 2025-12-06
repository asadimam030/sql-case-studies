# Zepto Sales SQL PRoject

![zepto_dashboard](https://github.com/user-attachments/assets/1a5a6d7b-804f-4c1c-accc-0a5f11087758)

## Objective
The objective of this project is to analyze Zepto’s product dataset to uncover insights related to pricing efficiency, discount patterns, stock availability, and category performance. This analysis aims to help optimize inventory planning, identify best-value products, detect pricing inconsistencies, understand stock shortages, and evaluate revenue potential across categories. By examining product attributes such as MRP, discounts, weight, availability, and stock status, this project supports data-driven decision-making for improving profitability, demand forecasting, and operational efficiency.

## Key Questions
**Q1. Top 10 Best-Value Products (Highest Discount Percentage).**<br>
Identify the products offering the highest discount percentage and return the top 10 best-value deals.

**Q2. Products With High MRP but Out of Stock**<br>
Find premium or high-priced products that are currently unavailable, indicating high demand or poor stock management.

**Q3. Estimated Revenue per Category**<br>
Calculate potential revenue for each category using:<br>
estimated_revenue = discountedSellingPrice × availableQuantity<br>
This helps identify which product categories generate the highest future revenue.<br>

**Q4. Products With MRP > ₹500 and Discount < 10%**<br>
Find premium-priced products offering low discounts. This reveals items with:<br>
low promotional intensity, OR<br>
opportunities for price adjustments.<br>

**Q5. Top 5 Categories With Highest Average Discount Percentage**<br>
Determine which product categories provide the best deals or most aggressive pricing strategy.<br>

**Q6. Price Per Gram for Products Above 100g**<br>
Calculate:<br>
price_per_gram = discountedSellingPrice / weightInGms<br>
Then sort products from best value (lowest) to least value (highest).

**Q7. Group Products Into Low, Medium, and Bulk Categories**<br>
Create weight-based segmentation:<br>
Low Weight → under 250g<br>
Medium Weight → 250g–1000g<br>
Bulk Weight → above 1000g<br>
This helps in understanding product packaging strategy.

**Q8. Total Inventory Weight per Category**<br>
Calculate total stock weight using:<br>
total_weight = availableQuantity × weightInGms<br>
Group by category to understand inventory distribution across product types.


