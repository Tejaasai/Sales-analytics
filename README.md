# Retail Sales-analytics

The client owns one of the leading retail store chains in India and would like to receive a detailed analysis report and data-driven insights from the point of sales data to define marketing strategies going forward. The client also wants help in measuring, managing, and analyzing the performance of the business.

## Objective: 
Conduct a comprehensive exploratory analysis to examine sales trends and understand customer behavior in detail.

## Summary: 
Conducted detailed exploratory data analysis on transaction data to understand the sales patterns among various products and additionally, analyzed category penetration across different years along with maximum rated categories and prioritized customer segments based on the findings.

## Techniques used: 
Data Modeling (Creation of ER Diagrams), Data Manipulation, Data Summarization, Exploratory Data Analysis, Creation of Reports, and Insights Generation

## Challenges:
•	While joining orders table with order payments table had some issues because orders table has order level data without payment type but order payment table has payment type column for each product and amount column was not totally matching with amount column in orders table.

## Detailed Steps:

•	Understand the business objective and available data with the help of a data dictionary.

•	Created an ER Diagram that represents the structure of the database.

•	Subsequently, a database was established in an MS SQL server with the necessary schema, and the data was successfully loaded into it.

•	Performed the below analysis to understand the selling patterns, trends, seasonality of sales, performance of stores at different locations, and prioritizing customers.
o	Performance of sales over gender.
o	Sales in different store locations and states over time
o	Behavior of customers purchasing pattern over month and year

•	Finally generated insights in terms of most selling products, most performing stores, maximum rated categories, penetration, trends, seasonality, etc.

## Findings:

•	Female customers have contributed more sales of around 10.6 million, which is 70% of total sales.

•	ST103 has outperformed other stores and generated 3.2 million in revenue, which is located in Andhra Pradesh.

•	ST354 is the least performing among the other stores and is located in Haryana.

•	Most of the payments are done through credit card, and fewer payments are done through debit card, as we can see there are fewer orders placed through debit card.

•	Weekdays have more sales than other days of the week, with Wednesday seeing the highest sales of the week.

•	The maximum rated category is Pet Shop, with an average rating of 4.28, but a smaller number of customers have rated it. So we can assume that customers rating is satisfactory, but this category is not that popular among customers

## Recommendations:

•	More contribution of sales is from south region apart from other regions, so other regions should be focused more to increase sales.

•	More sales are on weekdays other than weekends so weekends should be more focused this might result in increase in sales.

•	More one-time buyers are present other than repeated buyers so one-time buyers should focused more to increase the retention rate.

•	More sales are done through credit card may be due to good discounts on using credit card, so customers whose other mode of payments should be given good discounts or offers to increase sales.





