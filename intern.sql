USE RETAIL_INTERNSHIP;


SELECT COUNT(*) FROM CUSTOMER;
SELECT COUNT(*) FROM ORDERPAYMENTS;
SELECT COUNT(*) FROM [dbo].[orderreview_rating];
SELECT COUNT(*) FROM [dbo].[orders];
SELECT COUNT(*) FROM [dbo].[productsinfo];
SELECT COUNT(*) FROM [dbo].[storesinfo];

*/************************CUSTOMER_TABLE*******************************/
SELECT * FROM CUSTOMER;

---NUMBER OF RECORDS 99441 IN CUSTOMER TABLE---

SELECT CUSTID FROM CUSTOMER
WHERE CUSTID IS NULL

----NO NULL VALUES IN CUST_ID-------------


--******************************************--

SELECT  CUSTID,COUNT(*) AS COUNT_ FROM CUSTOMER
WHERE CUSTID IS NOT NULL
GROUP BY CUSTID
HAVING COUNT(*)=1
---99441-------

--******************************************--

SELECT CUSTOMER_CITY FROM CUSTOMER
WHERE CUSTOMER_CITY IS NULL

----NO NULL VALUES IN CUSTOMER_CITY-------------

--******************************************--

SELECT  CUSTOMER_CITY,COUNT(*) AS COUNT_ FROM CUSTOMER
WHERE CUSTOMER_CITY IS NOT NULL
GROUP BY CUSTOMER_CITY
HAVING COUNT(*)=1
---NO OF RECORDS 1144 WHICH ARE NOT REPEATED---------

--******************************************--

SELECT  CUSTOMER_CITY,COUNT(*) AS COUNT_ FROM CUSTOMER
WHERE CUSTOMER_CITY IS NOT NULL
GROUP BY CUSTOMER_CITY
HAVING COUNT(*)>1
---NO OF RECORDS 2,975 WHICH ARE REPEATED----------

--******************************************--

SELECT CUSTOMER_STATE FROM CUSTOMER
WHERE CUSTOMER_STATE IS NULL

----NO NULL VALUES IN CUSTOMER_STATE-------------

--******************************************--

SELECT DISTINCT CUSTOMER_STATE FROM CUSTOMER
---20-----------

--******************************************--

SELECT  CUSTOMER_STATE,COUNT(*) AS COUNT_ FROM CUSTOMER
WHERE CUSTOMER_STATE IS NOT NULL
GROUP BY CUSTOMER_STATE
HAVING COUNT(*)=1
---EVERY STATE REPEATED MORE THAN ONCE------------

--******************************************--

SELECT  CUSTOMER_STATE,COUNT(*) AS COUNT_ FROM CUSTOMER
WHERE CUSTOMER_STATE IS NOT NULL
GROUP BY CUSTOMER_STATE
HAVING COUNT(*)>1
---NO OF RECORDS 20 WHICH ARE REPEATED-------------

--******************************************--

SELECT GENDER FROM CUSTOMER
WHERE GENDER IS NULL

----NO NULL VALUES IN GENDER-------------

--******************************************--


SELECT DISTINCT GENDER FROM CUSTOMER
---2------------

--******************************************--

SELECT  GENDER,COUNT(*) AS COUNT_ FROM CUSTOMER
WHERE GENDER IS NOT NULL
GROUP BY GENDER
HAVING COUNT(*)=1
----NO GENDER IS UNIQUE---------

--******************************************--

SELECT  GENDER,COUNT(*) AS COUNT_ FROM CUSTOMER
WHERE GENDER IS NOT NULL
GROUP BY GENDER
HAVING COUNT(*)>1
---NO RECORDS ARE 2 WHICH ARE REPEATED------

--******************************************--


SELECT  CUSTID,CUSTOMER_CITY,CUSTOMER_STATE,GENDER,COUNT(*) AS COUNT_ FROM CUSTOMER
GROUP BY CUSTID,CUSTOMER_CITY,CUSTOMER_STATE,GENDER
HAVING COUNT(*)=1
---NO RECORD IS DUPLICATED----



/***********************************ORDERREVIEW_RATING TABLE****************************************/

SELECT  COUNT(*) FROM ORDERREVIEW_RATING

--NUMBER OF RECORDS 100000 IN CUSTOMER TABLE---

--******************************************--

SELECT  COUNT(DISTINCT ORDER_ID) FROM ORDERREVIEW_RATING
/*NO OF DISTINCT RECORDS ARE 99,441 IN ORDER_ID COLUMN  */

--******************************************--

SELECT ORDER_ID FROM ORDERREVIEW_RATING
WHERE ORDER_ID IS NULL

----NO NULL VALUES IN ORDER_ID-------------

--******************************************--


SELECT  ORDER_ID,COUNT(*) AS COUNT_ FROM ORDERREVIEW_RATING
GROUP BY ORDER_ID
HAVING COUNT(ORDER_ID)=1
/*NO OF RECORDS ARE 98,886 IN ORDER_ID COLUMN WHICH ARE NOT REPEATED  */

--******************************************--


SELECT  ORDER_ID,COUNT(*) AS COUNT_ FROM ORDERREVIEW_RATING
GROUP BY ORDER_ID
HAVING COUNT(ORDER_ID)>1
/*NO OF RECORDS 555 WHICH ARE REPEATED*/

--******************************************--

SELECT CUSTOMER_SATISFACTION_SCORE FROM ORDERREVIEW_RATING
WHERE CUSTOMER_SATISFACTION_SCORE IS NULL

----NO NULL VALUES IN CUSTOMER_SATISFACTION_SCORE-------------

--******************************************--

SELECT  CUSTOMER_SATISFACTION_SCORE,COUNT(*) AS COUNT_ FROM ORDERREVIEW_RATING
GROUP BY CUSTOMER_SATISFACTION_SCORE
HAVING COUNT(ORDER_ID)=1

---EVERY RATING IS REPEATED-----------------

--******************************************--

SELECT  CUSTOMER_SATISFACTION_SCORE,COUNT(*) AS COUNT_ FROM ORDERREVIEW_RATING
GROUP BY CUSTOMER_SATISFACTION_SCORE
HAVING COUNT(ORDER_ID)>1

---5 RATING SCORES ARE REPEATED-----------------

--******************************************--


SELECT  ORDER_ID,CUSTOMER_SATISFACTION_SCORE,COUNT(*) AS COUNT_ FROM ORDERREVIEW_RATING
GROUP BY ORDER_ID,CUSTOMER_SATISFACTION_SCORE
HAVING COUNT(*)=1
/*NO OF RECORDS ARE 99,302 IN ORDER_ID COLUMN WHICH ARE NOT REPEATED  */

--******************************************--

SELECT  ORDER_ID,CUSTOMER_SATISFACTION_SCORE,COUNT(*) AS COUNT_ FROM ORDERREVIEW_RATING
GROUP BY ORDER_ID,CUSTOMER_SATISFACTION_SCORE
HAVING COUNT(*)>1

/*NO OF RECORDS 348 WHICH ARE REPEATED*/

--******************************************--

SELECT  ORDER_ID,AVG(CUSTOMER_SATISFACTION_SCORE) AS AVG_RATING FROM ORDERREVIEW_RATING
GROUP BY ORDER_ID
---AFTER AVGERAGING THE RATING OF CUSTOMER WE WILL GET 99441 RECORDS.

--******************************************--


---UPDATE ORDERREVIEW_RATING TABLE WITH AVG_CUSTOMER_SATISFACTION SCORE----


SELECT  ORDER_ID,AVG([Customer_Satisfaction_Score]) AS CUSTOMER_RATING
 INTO #TEMP_RATING
FROM [dbo].[orderreview_rating]
GROUP BY ORDER_ID;

DELETE FROM orderreview_rating;

INSERT INTO orderreview_rating(ORDER_ID,CUSTOMER_SATISFACTION_SCORE)
SELECT ORDER_ID,
CUSTOMER_RATING
FROM #TEMP_RATING


DROP TABLE #TEMP_RATING

SELECT * FROM orderreview_rating

SELECT ORDER_ID FROM orderreview_rating
GROUP BY ORDER_ID
HAVING COUNT(ORDER_ID)>1

---NO DUPLICATE RECORDS FOUND IN ORDERREVIEW_RATING TABLE----



/***********************************PRODUCTINFO TABLE****************************************/

SELECT COUNT(*) FROM PRODUCTSINFO 

---NO OF RECORDS 32,951------------------

SELECT  PRODUCTID  FROM PRODUCTSINFO
WHERE PRODUCTID IS NULL
----NO NULL VALUES IN PRODUCT ID-------------

--******************************************--


SELECT  PRODUCTID,COUNT(*) AS COUNT_ FROM PRODUCTSINFO
GROUP BY PRODUCTID
HAVING COUNT(*)=1
-----NO OF RECORDS ARE 32,951 NO DUPLICATED RECORDS ARE FOUND--------

--******************************************--


SELECT  CATEGORY FROM PRODUCTSINFO
WHERE CATEGORY IS NULL
---NO NULL VALUES IN CATEGORY COLUMN-----------

--******************************************--

SELECT  CATEGORY,COUNT(*) AS COUNT_ FROM PRODUCTSINFO
GROUP BY CATEGORY
HAVING COUNT(*)=1

----EVERY CATEGORY IS REPEATED SO NO RECORDS FOUND WHILE EXECUTING THE ABOVE QUERY-------

--******************************************--

SELECT  CATEGORY,COUNT(*) AS COUNT_ FROM PRODUCTSINFO
GROUP BY CATEGORY
HAVING COUNT(*)>1

---14 CATEGORIES ARE DUPLICATED-----

--******************************************--


UPDATE PRODUCTSINFO
SET CATEGORY='OTHERS'
WHERE CATEGORY ='#N/A'

--******************************************--

----UPDATED RECORDS IN CATEGORY COLUMN WHERE THE CATEGORY IS #N/A TO OTHERS----

SELECT PRODUCT_NAME_LENGTH FROM PRODUCTSINFO
WHERE PRODUCT_NAME_LENGTH IS NULL

----PRODUCT_NAME_LENGTH HAS 610 NULL RECORDS-----------

---UPDATING THE NULL VALUES WITH MEAN ------

UPDATE PRODUCTSINFO
SET PRODUCT_NAME_LENGTH=(SELECT AVG(PRODUCT_NAME_LENGTH) FROM PRODUCTSINFO)
WHERE PRODUCT_NAME_LENGTH IS NULL

--******************************************--

--SELECT PRODUCT_NAME_LENGTH FROM PRODUCTSINFO
--WHERE PRODUCT_NAME_LENGTH IS NULL

SELECT PRODUCT_DESCRIPTION_LENGTH FROM PRODUCTSINFO
WHERE PRODUCT_DESCRIPTION_LENGTH IS NULL

----PRODUCT_DESCRIPTION_LENGTH HAS 610 NULL RECORDS-----------


---UPDATING THE NULL VALUES WITH MEAN ------
UPDATE PRODUCTSINFO
SET PRODUCT_DESCRIPTION_LENGTH=(SELECT AVG(PRODUCT_DESCRIPTION_LENGTH) FROM PRODUCTSINFO)
WHERE PRODUCT_DESCRIPTION_LENGTH IS NULL

--******************************************--


SELECT PRODUCT_PHOTOS_QTY FROM PRODUCTSINFO
WHERE PRODUCT_PHOTOS_QTY IS NULL

----PRODUCT_PHOTOS_QTY HAS 610 NULL RECORDS-----------


---UPDATING THE NULL VALUES WITH MEAN ------
UPDATE PRODUCTSINFO
SET PRODUCT_PHOTOS_QTY=(SELECT AVG(PRODUCT_PHOTOS_QTY) FROM PRODUCTSINFO)
WHERE PRODUCT_PHOTOS_QTY IS NULL

--******************************************--

SELECT PRODUCT_WEIGHT_G FROM PRODUCTSINFO
WHERE PRODUCT_WEIGHT_G  IS NULL

----PRODUCT_WEIGHT_G HAS 2 NULL VALUES-----------


---UPDATING THE NULL VALUES WITH MEAN ------
UPDATE PRODUCTSINFO
SET PRODUCT_WEIGHT_G=(SELECT AVG(PRODUCT_WEIGHT_G) FROM PRODUCTSINFO)
WHERE PRODUCT_WEIGHT_G IS NULL


--******************************************--



SELECT PRODUCT_LENGTH_CM FROM PRODUCTSINFO
WHERE PRODUCT_LENGTH_CM IS NULL

----PRODUCT_LENGTH_CM HAS 2 NULL VALUES-----------


---UPDATING THE NULL VALUES WITH MEAN ------
UPDATE PRODUCTSINFO
SET PRODUCT_LENGTH_CM=(SELECT AVG(PRODUCT_LENGTH_CM) FROM PRODUCTSINFO)
WHERE PRODUCT_LENGTH_CM IS NULL

--******************************************--



SELECT PRODUCT_HEIGHT_CM FROM PRODUCTSINFO
WHERE PRODUCT_HEIGHT_CM IS NULL

----PRODUCT_HEIGHT_CM HAS 2 NULL VALUES-----------



---UPDATING THE NULL VALUES WITH MEAN ------
UPDATE PRODUCTSINFO
SET PRODUCT_HEIGHT_CM=(SELECT AVG(PRODUCT_HEIGHT_CM) FROM PRODUCTSINFO)
WHERE PRODUCT_HEIGHT_CM IS NULL

--******************************************--


SELECT PRODUCT_WIDTH_CM FROM PRODUCTSINFO
WHERE PRODUCT_WIDTH_CM IS NULL

----PRODUCT_WIDTH_CM HAS 2 NULL VALUES-----------


--UPDATING THE NULL VALUES WITH MEAN ------
UPDATE PRODUCTSINFO
SET PRODUCT_WIDTH_CM=(SELECT AVG(PRODUCT_WIDTH_CM) FROM PRODUCTSINFO)
WHERE PRODUCT_WIDTH_CM IS NULL

--******************************************--


SELECT  PRODUCTID,
CATEGORY,
PRODUCT_NAME_LENGTH,
PRODUCT_DESCRIPTION_LENGTH,
PRODUCT_PHOTOS_QTY,
PRODUCT_WEIGHT_G,
PRODUCT_LENGTH_CM,
PRODUCT_HEIGHT_CM,
PRODUCT_WIDTH_CM,
COUNT(*) AS COUNT_ FROM PRODUCTSINFO
GROUP BY PRODUCTID,
CATEGORY,
PRODUCT_NAME_LENGTH,
PRODUCT_DESCRIPTION_LENGTH,
PRODUCT_PHOTOS_QTY,
PRODUCT_WEIGHT_G,
PRODUCT_LENGTH_CM,
PRODUCT_HEIGHT_CM,
PRODUCT_WIDTH_CM
HAVING COUNT(*)>1

----NO RECORDS ARE DUPLICATED---------


/***********************************STORESINFO TABLE****************************************/

SELECT * FROM STORESINFO

--TOTAL 535 RECORDS IN STORESINFO----

--******************************************--

SELECT STOREID FROM STORESINFO
WHERE STOREID IS NULL

---NO NULL VALUES IN STOREID------

--******************************************--

SELECT STOREID,COUNT(*) FROM STORESINFO
GROUP BY STOREID
HAVING COUNT(*)>1

---------NO OF RECORDS WHICH ARE DUPLICATED ARE 1---------------

--******************************************--

SELECT SELLER_CITY FROM STORESINFO
WHERE SELLER_CITY IS NULL

---NO NULL VALUES IN SELLER_CITY -----------

--******************************************--

SELECT SELLER_CITY,COUNT(*) FROM STORESINFO
GROUP BY SELLER_CITY
HAVING COUNT(*)>1

---------NO OF RECORDS WHICH ARE DUPLICATED IS 1---------------

--******************************************--

SELECT SELLER_STATE FROM STORESINFO
WHERE SELLER_STATE IS NULL

---NO NULL VALUES IN SELLER_STATE -----------

--******************************************--

SELECT STOREID,
SELLER_CITY,
SELLER_STATE,
REGION,COUNT(*) FROM STORESINFO
GROUP BY STOREID,
SELLER_CITY,
SELLER_STATE,
REGION
HAVING COUNT(*)>1

---FROM WHOLE STORE_INFO ONE RECORD IS DUPLICATED-----------

--******************************************--




----UPDATING STORESINFO TABLE BY REMOVING DUPLICATE RECORD----------------



SELECT STOREID,
SELLER_CITY,
SELLER_STATE,
REGION INTO #TEMP1 FROM STORESINFO
GROUP BY STOREID,
SELLER_CITY,
SELLER_STATE,
REGION

DELETE FROM [dbo].[storesinfo]

INSERT INTO [dbo].[storesinfo](STOREID,SELLER_CITY,SELLER_STATE,REGION )
SELECT STOREID,
SELLER_CITY,
SELLER_STATE,
REGION FROM #TEMP1;

SELECT * FROM STORESINFO

DROP TABLE #TEMP1

---DUPLICATE RECORDS ARE DELETED FROM STORESINFO TABLE-----------------




/***********************************ORDERPAYMENTS TABLE****************************************/

SELECT COUNT(*) FROM ORDERPAYMENTS

----TOTAL RECORDS 1,03,886 ---

--******************************************--

SELECT * FROM ORDERPAYMENTS



SELECT ORDER_ID FROM ORDERPAYMENTS
WHERE ORDER_ID IS NULL

----NO NULL VALUES ARE PRESENT IN ORDER_ID COLUMN------

--******************************************--

SELECT ORDER_ID,COUNT(*) AS COUNT FROM ORDERPAYMENTS
GROUP BY ORDER_ID
HAVING COUNT(*)>1

-----2,961 ORDERS HAVE MORE THAN ONE TRANSACTION-----------------------

--******************************************--

SELECT PAYMENT_TYPE FROM ORDERPAYMENTS
WHERE PAYMENT_TYPE IS NULL

----NO NULL VALUES ARE PRESENT IN PAYMENT_TYPE COLUMN------

--******************************************--


SELECT PAYMENT_VALUE FROM ORDERPAYMENTS
WHERE PAYMENT_VALUE IS NULL

----NO NULL VALUES ARE PRESENT IN PAYMENT_VALUE COLUMN------

--******************************************--


SELECT PAYMENT_VALUE FROM ORDERPAYMENTS
WHERE PAYMENT_VALUE<0

----NO VALUE IS LESS THAN ZERO-----------------------

--******************************************--


SELECT ORDER_ID,PAYMENT_TYPE,PAYMENT_VALUE,COUNT(*)
FROM ORDERPAYMENTS
GROUP BY ORDER_ID,PAYMENT_TYPE,PAYMENT_VALUE
HAVING COUNT(*)>1


SELECT * FROM ORDERPAYMENTS
WHERE ORDER_ID='00bd50cdd31bd22e9081e6e2d5b3577b'

--******************************************--

-----TOTAL 308 DUPLICATE RECORDS ARE PRESENT IN ORDERPAYMENTS TABLE-----------------------

SELECT ORDER_ID,PAYMENT_TYPE,PAYMENT_VALUE INTO #TEMP2
FROM ORDERPAYMENTS
GROUP BY ORDER_ID,PAYMENT_TYPE,PAYMENT_VALUE

DELETE FROM [dbo].[orderpayments]

INSERT INTO [dbo].[orderpayments](ORDER_ID,PAYMENT_TYPE,PAYMENT_VALUE )
SELECT ORDER_ID,
PAYMENT_TYPE,
PAYMENT_VALUE FROM #TEMP2;

SELECT * FROM [dbo].[orderpayments]

DROP TABLE #TEMP2


/***********************ORDERS TABLE****************************/

SELECT COUNT(*) FROM ORDERS

----NO OF RECORDS 112650 ------------

--******************************************--

SELECT CUSTOMER_ID FROM ORDERS
WHERE CUSTOMER_ID IS NULL

---NO NULL VALUES IN CUSTOMER_ID-------

--******************************************--

SELECT CUSTOMER_ID,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY CUSTOMER_ID
HAVING COUNT(*)=1

----88,747 RECORDS ARE NOT DUPLICATED------

--******************************************--

SELECT CUSTOMER_ID,COUNT(*) AS COUNT_ FROM ORDERS
GROUP BY CUSTOMER_ID
HAVING COUNT(*)>1

---9,828 RECORDS ARE DUPLICATED------------

--******************************************--

SELECT ORDER_ID FROM ORDERS
WHERE ORDER_ID IS NULL

---NO NULL VALUES IN ORDER_ID-------

--******************************************--

SELECT ORDER_ID,COUNT(*)  AS COUNT_ FROM ORDERS
GROUP BY ORDER_ID
HAVING COUNT(*)=1

----88,863 RECORDS ARE NOT DUPLICATED----------

--******************************************--

SELECT ORDER_ID,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY ORDER_ID
HAVING COUNT(*)>1

----9,803 RECORDS ARE DUPLICATED----------

--******************************************--

SELECT PRODUCT_ID FROM ORDERS
WHERE PRODUCT_ID IS NULL

---NO NULL VALUES IN PRODUCT_ID-------

--******************************************--

SELECT PRODUCT_ID,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY PRODUCT_ID

HAVING COUNT(*)=1

----18,117 RECORDS ARE NOT DUPLICATED----------

--******************************************--

SELECT PRODUCT_ID,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY PRODUCT_ID
HAVING COUNT(*)>1

----14834 RECORDS ARE DUPLICATED----------

--******************************************--

SELECT CHANNEL FROM ORDERS
WHERE CHANNEL IS NULL

---NO NULL VALUES IN CHANNEL-------

--******************************************--

SELECT CHANNEL,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY CHANNEL
HAVING COUNT(*)=1

---EVERY RECORD IN CHANNEL COLUMN IS DUPLICATED-------

--******************************************--

SELECT CHANNEL,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY CHANNEL
HAVING COUNT(*)>1

---3 CHANNELS ARE DUPLICATED-------------------------

--******************************************--


SELECT DELIVERED_STOREID FROM ORDERS
WHERE DELIVERED_STOREID IS NULL

---NO NULL VALUES IN Delivered_StoreID-------

--******************************************--

SELECT DELIVERED_STOREID,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY DELIVERED_STOREID
HAVING COUNT(*)=1

---EVERY RECORD IN Delivered_StoreID COLUMN IS DUPLICATED-------

--******************************************--

SELECT DELIVERED_STOREID,COUNT(*) AS COUNT_  FROM ORDERS
GROUP BY DELIVERED_STOREID
HAVING COUNT(*)>1

---37 DELIVERED_STOREID RECORDS ARE DUPLICATED-------

--******************************************--



SELECT BILL_DATE_TIMESTAMP FROM ORDERS
WHERE BILL_DATE_TIMESTAMP IS NULL

---NO NULL VALUES IN BILL_DATE_TIMESTAMP-------

--******************************************--

SELECT QUANTITY FROM ORDERS
WHERE QUANTITY IS NULL

---NO NULL VALUES IN QUANTITY-------

--******************************************--

SELECT COST_PER_UNIT FROM ORDERS
WHERE COST_PER_UNIT IS NULL

---NO NULL VALUES IN COST_PER_UNIT-------

--******************************************--

SELECT MRP FROM ORDERS
WHERE MRP IS NULL

---NO NULL VALUES IN MRP-------

--******************************************--

SELECT DISCOUNT FROM ORDERS
WHERE DISCOUNT IS NULL

---NO NULL VALUES IN DISCOUNT-------

--******************************************--

SELECT TOTAL_AMOUNT FROM ORDERS
WHERE TOTAL_AMOUNT IS NULL

---NO NULL VALUES IN TOTAL_AMOUNT-------

/************CLEANING ORDERS TABLE****************/






with cust_ord as(
select customer_id,order_id,round(sum(total_amount),0) as total_amount from orders
group by customer_id,order_id
),
ord_pay as(
select order_id,round(sum(payment_value),0) as payment_value from orderpayments
group by order_id
),
matched_records as
(select a.*,b.payment_value
from cust_ord a
left join ord_pay b
on a.order_id=b.order_id
and a.total_amount=b.payment_value
)
select * from matched_records
where payment_value is not null

--drop table matched_records

select * into matched_records from matched_records

select * from matched_records

--********************************************************
select * from orders
where order_id='c8114f17241723311fd349c747e151b0'

--when i sum total amount from orders table and join it to orderpayments table these type of records are left

select * from orderpayments
where order_id='c8114f17241723311fd349c747e151b0'
--**********************************************************

select * from orders
where order_id in ('cffc3fce7450b2db5f6294229289299b','39c1a4a89678bf3fbbcaa3719ba937dc','19af5e1e647ae04a3a572d7d5bbd9e1b','cde001ad61a8e40ea8feff0ea31f9ea3')

--when i sum total amount from orders table and join it to orderpayments table these type of records are MAPPED

select * from orderpayments
where order_id in('cffc3fce7450b2db5f6294229289299b','39c1a4a89678bf3fbbcaa3719ba937dc','19af5e1e647ae04a3a572d7d5bbd9e1b','cde001ad61a8e40ea8feff0ea31f9ea3')



--********************************************************

with cust_ord as(
select customer_id,order_id,round(sum(total_amount),0) as total_amount from orders
group by customer_id,order_id
),
ord_pay as(
select order_id,round(sum(payment_value),0) as payment_value from orderpayments
group by order_id
),
null_values as(
select b.* from
cust_ord a
right join
ord_pay b
on a.order_id=b.order_id
and a.total_amount=b.payment_value
where a.customer_id is null
),
remaining_ids as
(
select a.customer_id,a.order_id,b.payment_value from
orders a
join null_values b
on a.order_id=b.order_id
and round(a.total_amount,0)=b.payment_value
)
select * from remaining_ids

--select * into remaining_records from remaining_ids

select *  from null_values
where order_id in (select order_id from orders
group  by order_id
having count(distinct product_id)>1)

	drop table remaining_records
--*******************************************
select * from orders
where order_id='04d545b51bf8586200b03f1e22db97e2'

select * from orderpayments
where order_id='04d545b51bf8586200b03f1e22db97e2'

select * from remaining_records
where order_id='04d545b51bf8586200b03f1e22db97e2'



--*********************************************
select * from orders
where order_id='c639d319e7a759b47c407201b57d5522'

select * from orderpayments
where order_id='c639d319e7a759b47c407201b57d5522'
	
--*******************************************
select * from orders
where order_id='e10d948a9f7322cbeaa0d54d56af5ca9'

----here order_ids match but while joining we are suming the orders if the same cust id and ord id repeated twice and matching with payment_value of payments table 

select * from orderpayments
where order_id='e10d948a9f7322cbeaa0d54d56af5ca9'

--***********************************************
select * from orders
where order_id='08c30c203ecbdda69311c1dba85abfa6'

select * from orderpayments
where order_id='08c30c203ecbdda69311c1dba85abfa6'

--*************************************************

select * from matched_records

select * from remaining_records
where order_id='c639d319e7a759b47c407201b57d5522'

with a1 as
(select a.* from matched_records b 
join orders a 
on a.customer_id=b.customer_id
and a.order_id=b.order_id
),
a2 as
(select a.* from orders a
join remaining_records b
on a.customer_id=b.customer_id
and a.order_id=b.order_id
and round(a.total_amount,0)=b.payment_value
),
a3 as
(select * from a1
union all
select * from  a2)
select * into new_order from a3

drop table new_order


select * from new_order


select * into integrated_table from(
select A.*,B.category,C.customer_satisfaction_score,D.seller_city,D.seller_state,D.region,E.customer_city,E.customer_state,E.gender
from new_order A
join productsinfo B
on A.product_id=B.productid
join orderreview_rating C
on A.order_id=C.order_id
join storesinfo D
on A.delivered_storeid=D.storeid
join customer E
on A.customer_id=E.custid
)a

select order_id,count(*) from integrated_table
group by order_id
having count(*)>1

select * from matched_records

select * from remaining_records

select * from integrated_table



------------------------------------------------Detailed exploratory analysis ----------------------------------------------------------------

---The number of orders

SELECT COUNT(DISTINCT ORDER_ID) AS NUMBER_OF_ORDERS FROM integrated_table

--******************************************--

---Total Discount
SELECT SUM(QUANTITY*DISCOUNT) AS TOTAL_DISCOUNT FROM integrated_table;

--******************************************--

---Average discount per customer
SELECT AVG(CAST(TOTAL_DISCOUNT_PER_CUSTOMER AS FLOAT)) AS AVG_DISCOUNT_PER_CUSTOMER FROM
(
SELECT CUSTOMER_ID,SUM(QUANTITY*DISCOUNT) AS TOTAL_DISCOUNT_PER_CUSTOMER FROM integrated_table
GROUP BY CUSTOMER_ID)A

--******************************************--

---Average discount per order
SELECT AVG(CAST(DISCOUNT_PER_ORDER AS FLOAT)) AS AVG_DISCOUNT_PER_ORDER FROM
(
SELECT SUM(QUANTITY*DISCOUNT) AS DISCOUNT_PER_ORDER FROM integrated_table
GROUP BY ORDER_ID)B

--******************************************--

---Average order value or Average Bill Value

SELECT AVG(TOTAL_AMOUNT) AS ORDER_VALUE FROM (
SELECT ORDER_ID,SUM(TOTAL_AMOUNT) AS TOTAL_AMOUNT FROM integrated_table
GROUP BY  ORDER_ID)A

--******************************************--


---Average Sales per Customer
SELECT AVG(AVG_SALES) AS AVG_SALES FROM(
SELECT CUSTOMER_ID,SUM(TOTAL_AMOUNT) AS AVG_SALES FROM integrated_table
GROUP BY  CUSTOMER_ID)A

--******************************************--


---Average profit per customer

SELECT AVG(TOTAL_PROFIT) AS AVERAGE_PROFIT_PER_CUSTOMER FROM
(
SELECT A.CUSTOMER_ID,SUM(A.TOTAL_AMOUNT-A.COST_PRICE) AS TOTAL_PROFIT
FROM(
SELECT *,(COST_PER_UNIT*QUANTITY) AS COST_PRICE,(MRP*QUANTITY) AS ACTUAL_COST_PRICE 
FROM integrated_table)A
GROUP BY A.CUSTOMER_ID
)B

--******************************************--


---average number of categories per order


SELECT AVG(cast(COUNT_ORD AS FLOAT)) AS AVG_CAT FROM
(
SELECT ORDER_ID,CAST(COUNT(DISTINCT CATEGORY)AS FLOAT) AS COUNT_ORD FROM integrated_table
GROUP BY  ORDER_ID)A

SELECT COUNT(DISTINCT CATEGORY) FROM integrated_table
SELECT COUNT(DISTINCT ORDER_ID) FROM integrated_table



--******************************************--


---average number of items per order

SELECT AVG(cast(QUANTITY as float))AS AVG_QUANTITY FROM integrated_table

--******************************************--

---Number of customers
SELECT COUNT(DISTINCT(CUSTOMER_ID)) AS NUMBER_OF_CUSTOMERS FROM integrated_table;


--******************************************--

---Transactions per Customer

SELECT AVG(cast(TRANSACTIONS as float)) AS AVG_TRANSACTIONS FROM(
SELECT CUSTOMER_ID,COUNT(DISTINCT(ORDER_ID)) AS TRANSACTIONS FROM integrated_table
GROUP BY CUSTOMER_ID
--ORDER BY TRANSACTIONS  DESC
)A

--******************************************--

---Total Revenue
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE
FROM integrated_table


--******************************************--

---Total Profit
SELECT SUM(TOTAL_AMOUNT-(COST_PER_UNIT*QUANTITY)) AS TOTAL_PROFIT
FROM integrated_table

--******************************************--
---Total Cost
SELECT SUM(COST_PER_UNIT*QUANTITY) AS TOTAL_COST FROM integrated_table

--******************************************--

---Total quantity
SELECT SUM(QUANTITY) AS TOTAL_QUANTITY FROM integrated_table

--******************************************--

---Total products
SELECT COUNT(DISTINCT(PRODUCT_ID)) AS TOTAL_PRODUCTS FROM integrated_table

--******************************************--

---Total categories
SELECT COUNT(DISTINCT(CATEGORY)) AS TOTAL_CATEGORIES FROM integrated_table

--******************************************--

SELECT DISTINCT(CATEGORY) AS TOTAL_CATEGORIES FROM integrated_table

--******************************************--

---Total stores
SELECT COUNT(DISTINCT(DELIVERED_STOREID)) AS TOTAL_STORES FROM integrated_table

--******************************************--

---Total locations
SELECT COUNT(DISTINCT(SELLER_STATE)) AS TOTAL_STATE_LOCATION FROM integrated_table


SELECT COUNT(DISTINCT(CUSTOMER_STATE)) AS TOTAL_STATE_LOCATION FROM integrated_table

SELECT COUNT(DISTINCT(CUSTOMER_CITY)) AS TOTAL_CITIES FROM integrated_table
--******************************************--

---Total Regions
SELECT COUNT(DISTINCT(REGION)) AS TOTAL_REGIONS FROM integrated_table

--******************************************--

---Total channels
SELECT COUNT(DISTINCT(CHANNEL)) AS TOTAL_CHANNELS FROM integrated_table

--******************************************--

---Total payment methods

SELECT COUNT(DISTINCT(PAYMENT_TYPE)) AS TOTAL_PAYMENT_METHODS FROM ORDERPAYMENTS
WHERE ORDER_ID IN (SELECT DISTINCT ORDER_ID FROM integrated_table)


--******************************************--

---Average number of days between two transactions (if the customer has more than one transaction)

WITH NEXT_DATE AS (
    SELECT 
        CUSTOMER_ID,ORDER_ID,
        BILL_DATE_TIMESTAMP AS TRANSACTION_DATE,
        LEAD(BILL_DATE_TIMESTAMP) OVER (PARTITION BY CUSTOMER_ID ORDER BY BILL_DATE_TIMESTAMP) AS NEXT_TRANSACTION_DATE
    FROM 
        integrated_table
),
TransactionDifferences AS(
SELECT 
    CUSTOMER_ID,
    DATEDIFF(DAY, TRANSACTION_DATE,NEXT_TRANSACTION_DATE) AS DAYS_BETWEEN
FROM 
    NEXT_DATE
WHERE 
    NEXT_TRANSACTION_DATE IS NOT NULL
) ,
AVG_CAL AS
(
SELECT CUSTOMER_ID,AVG(DAYS_BETWEEN) AVG_DAYS_BETWEEN FROM TransactionDifferences
GROUP BY CUSTOMER_ID
)

SELECT AVG(AVG_DAYS_BETWEEN) AVG_NUMBER_OF_DAYS FROM AVG_CAL


--******************************************--

---percentage of profit
SELECT ((SUM(TOTAL_AMOUNT)-SUM(COST_PRICE))/SUM(COST_PRICE))*100 AS PERCENTAGE_OF_PROFIT FROM 
(
SELECT *,(COST_PER_UNIT*QUANTITY) AS COST_PRICE,(MRP*QUANTITY) AS ACTUAL_COST_PRICE 
FROM integrated_table)A

--******************************************--

---percentage of discount
SELECT((SUM(ACTUAL_COST_PRICE)-SUM(TOTAL_AMOUNT))/SUM(ACTUAL_COST_PRICE))*100 AS PERCENTAGE_OF_DISCOUNT 
FROM (
SELECT *,(COST_PER_UNIT*QUANTITY) AS COST_PRICE,(MRP*QUANTITY) AS ACTUAL_COST_PRICE 
FROM integrated_table)A

--******************************************--

---Repeat purchase rate
WITH REPEAT_PURCH AS(
SELECT ORDER_ID,
      COUNT( ORDER_ID) AS COUNT_PUR
FROM integrated_table
GROUP BY ORDER_ID
HAVING COUNT(ORDER_ID)>1
)
SELECT (COUNT(RP.ORDER_ID)*1.0/COUNT(DISTINCT(O.ORDER_ID)))*100 AS REPEAT_PURCHASE_RATE
FROM integrated_table O
LEFT JOIN REPEAT_PURCH AS RP
ON O.ORDER_ID=RP.ORDER_ID

--******************************************--


---Repeat customer percentage
WITH REPEAT_PURCH AS(
SELECT CUSTOMER_ID,
      COUNT(ORDER_ID) AS COUNT_PUR
FROM integrated_table
GROUP BY CUSTOMER_ID
HAVING COUNT(DISTINCT ORDER_ID)>1
)
SELECT (COUNT(DISTINCT CASE WHEN RP.CUSTOMER_ID IS NOT NULL THEN RP.CUSTOMER_ID ELSE NULL END)*100.00/COUNT(DISTINCT(O.CUSTOMER_ID))) AS REPEAT_CUSTOMER_PERCENT
FROM integrated_table O
LEFT JOIN REPEAT_PURCH AS RP
ON O.CUSTOMER_ID=RP.CUSTOMER_ID

--******************************************--

---One time buyers percentage

--WITH ONE_TIME AS (
--SELECT CUSTOMER_ID
--FROM ORDERS
--GROUP BY CUSTOMER_ID
--HAVING COUNT(distinct order_ID)=1
--)
--SELECT 
--count(distinct case when ot.Customer_id is not null then ot.Customer_id else null end) * 100.00/ COUNT(DISTINCT O.CUSTOMER_ID)
----(COUNT(OT.CUSTOMER_ID)*1.0/COUNT(DISTINCT(O.CUSTOMER_ID)))*100 AS ONE_TIME_BUYER
--FROM ORDERS O
--LEFT JOIN ONE_TIME AS OT
--ON O.CUSTOMER_ID=OT.CUSTOMER_ID


---One time buyers percentage
with one_time_cust as (
select customer_id from integrated_table
group by Customer_id
having count(distinct order_id) = 1
)
select (select count(*) from one_time_cust) * 100.00 / (select count(distinct customer_id) AS ONE_TIME_BUYERS_PERCENT from integrated_table)

--******************************************--

--Understanding how many new customers acquired every month (who made transaction first time in the data)
WITH FIRST_PURCHASE AS
(
SELECT CUSTOMER_ID,
	   MIN(BILL_DATE_TIMESTAMP) AS FIRST_PURCH
FROM integrated_table
GROUP BY CUSTOMER_ID
)
SELECT 
DATEPART(year,FIRST_PURCH) AS year_,
DATEPART(MONTH,FIRST_PURCH) AS MONTH_,
COUNT(DISTINCT(CUSTOMER_ID)) AS NEW_CUSTOMERS
FROM FIRST_PURCHASE
GROUP BY DATEPART(year,FIRST_PURCH),DATEPART(MONTH,FIRST_PURCH)
ORDER BY year_,MONTH_;

--******************************************--
--recheck
--Understand the retention of customers on month on month basis 
WITH CUSTOMER_MONTHLY AS
(
    SELECT 
        DATEPART(YEAR, BILL_DATE_TIMESTAMP) AS PURCHASE_YEAR,
        DATEPART(MONTH, BILL_DATE_TIMESTAMP) AS PURCHASE_MONTH,
        CUSTOMER_ID
    FROM integrated_table
    GROUP BY CUSTOMER_ID,
             DATEPART(MONTH, BILL_DATE_TIMESTAMP),
             DATEPART(YEAR, BILL_DATE_TIMESTAMP)
),
RETENTION_CUST AS(
    SELECT A.PURCHASE_YEAR AS YEAR_,
           A.PURCHASE_MONTH AS MONTH_,
		   CONCAT(A.PURCHASE_YEAR,'-',A.PURCHASE_MONTH) AS MONTH_YEAR,
           COUNT(DISTINCT(B.CUSTOMER_ID)) AS RETENTION_CUST
    FROM CUSTOMER_MONTHLY A
    JOIN CUSTOMER_MONTHLY B
        ON A.CUSTOMER_ID = B.CUSTOMER_ID
        -- Adjust for consecutive month, accounting for year changes
        AND (
            (A.PURCHASE_MONTH = B.PURCHASE_MONTH - 1 AND A.PURCHASE_YEAR = B.PURCHASE_YEAR)
            OR (A.PURCHASE_MONTH = 12 AND B.PURCHASE_MONTH = 1 AND A.PURCHASE_YEAR = B.PURCHASE_YEAR - 1)
        )
    GROUP BY A.PURCHASE_YEAR, A.PURCHASE_MONTH
)
SELECT  Month_, Year_,MONTH_YEAR, COALESCE(RETENTION_CUST, 0) AS Retained_Customers
FROM Retention_CUST
ORDER BY Year_, Month_;

--******************************************--

--How the revenues from existing/new customers on monthly basis
WITH FIRST_PURCHASE AS
(
    SELECT CUSTOMER_ID,
           MIN(BILL_DATE_TIMESTAMP) AS FIRST_PUR_DATE
    FROM integrated_table
    GROUP BY CUSTOMER_ID
)
, MARKED_TRANSACTIONS AS
(
    SELECT 
        O.CUSTOMER_ID,
        O.BILL_DATE_TIMESTAMP,
        DATEPART(YEAR, O.BILL_DATE_TIMESTAMP) AS PURCHASE_YEAR,
        DATEPART(MONTH, O.BILL_DATE_TIMESTAMP) AS PURCHASE_MONTH,
        CASE 
            -- Mark the first transaction as new customer revenue
            WHEN O.BILL_DATE_TIMESTAMP = FP.FIRST_PUR_DATE THEN 'NEW'
            -- All subsequent transactions are considered existing customer revenue
            ELSE 'EXISTING'
        END AS CUSTOMER_TYPE,
        O.TOTAL_AMOUNT
    FROM integrated_table O
    JOIN FIRST_PURCHASE FP
    ON O.CUSTOMER_ID = FP.CUSTOMER_ID
)
SELECT 
    PURCHASE_YEAR,
    PURCHASE_MONTH,
    SUM(CASE WHEN CUSTOMER_TYPE = 'NEW' THEN TOTAL_AMOUNT ELSE 0 END) AS NEW_CUST_REVENUE,
    SUM(CASE WHEN CUSTOMER_TYPE = 'EXISTING' THEN TOTAL_AMOUNT ELSE 0 END) AS EXISTING_CUST_REVENUE
FROM MARKED_TRANSACTIONS
GROUP BY PURCHASE_YEAR, PURCHASE_MONTH
ORDER BY PURCHASE_YEAR, PURCHASE_MONTH;


--******************************************--


--Understand the trends/seasonality of sales, quantity by category, region, store, channel, payment method etc…

------------------------------------------------------------------------------------------------------------------------
--***********creating temp table***************--
--SELECT * INTO #TEMPA FROM
--(SELECT *,
--DATENAME(MONTH,BILL_DATE_TIMESTAMP) AS MONTH_,
--DATENAME(YEAR,BILL_DATE_TIMESTAMP) AS YEAR_
--FROM ORD1)B


--******************************************--

----seasonality of sale


-------MONTHLY TREND--------------
SELECT DATENAME(MONTH,BILL_DATE_TIMESTAMP) AS MONTH_,SUM(TOTAL_AMOUNT) AS SALES
FROM integrated_table
GROUP BY DATENAME(MONTH,BILL_DATE_TIMESTAMP)
ORDER BY SALES DESC

--******************************************--

------YEARLY TREND----------------
SELECT DATENAME(YEAR,BILL_DATE_TIMESTAMP) AS YEAR_,SUM(TOTAL_AMOUNT) AS SALES
FROM integrated_table
GROUP BY DATENAME(YEAR,BILL_DATE_TIMESTAMP)
ORDER BY SALES

--ACTUALLY IT WAS MENTIONED AS SEP2021-OCT2023 DATA IS PRESENT BUT 2020 DATA IS ALSO PRESENT---

--******************************************--

-----STORE WISE SALES---------
SELECT Delivered_StoreID AS STOREID,SUM(TOTAL_AMOUNT) AS SALES
FROM integrated_table
GROUP BY Delivered_StoreID
ORDER BY SALES DESC

--******************************************--

-----CHANNEL WISE SALES--------
SELECT CHANNEL,SUM(TOTAL_AMOUNT) AS SALES
FROM integrated_table
GROUP BY CHANNEL
ORDER BY SALES DESC

--******************************************--

---REGION WISE SALES-------
SELECT REGION,SUM(TOTAL_AMOUNT) AS SALES FROM integrated_table
GROUP BY REGION
ORDER  BY SALES

--******************************************--
SELECT SELLER_state,SUM(TOTAL_AMOUNT) AS SALES FROM integrated_table
GROUP BY SELLER_state
ORDER  BY SALES DESC



--SELECT CUSTOMER_STATE,SELLER_state,SUM(TOTAL_AMOUNT) AS SALES FROM integrated_table
--GROUP BY CUSTOMER_STATE,SELLER_state
--ORDER  BY SALES DESC




--SELECT REGION,SUM(TOTAL_AMOUNT) AS SALES
--FROM(
--SELECT *
--FROM ORDERS O
--JOIN STORESINFO S
--ON O.DELIVERED_STOREID=S.STOREID)A
--GROUP BY REGION
--ORDER BY SALES DESC

--******************************************--

-----PAYMENT_TYPE-----------


SELECT PAYMENT_TYPE,SUM(PAYMENT_VALUE) AS PAYMENT_VALUE
FROM ORDERPAYMENTS
WHERE ORDER_ID IN
(SELECT DISTINCT(ORDER_ID) FROM integrated_table)
GROUP BY PAYMENT_TYPE
ORDER BY PAYMENT_VALUE DESC

--******************************************--

--Popular categories/Popular Products by store, state, region.
--*****************creating temp table****************--
--SELECT * INTO #ORD_STORE
--FROM
--(SELECT P.CATEGORY,O.PRODUCT_ID,S.STOREID,S.SELLER_STATE,S.REGION
--FROM ORD1 O
--JOIN PRODUCTSINFO P
--ON O.product_id=P.productid
--JOIN storesinfo S
--ON O.Delivered_StoreID=S.StoreID)A

--******************************************--

-----Popular Products by store, state, region.
SELECT TOP 10 * FROM
(
SELECT PRODUCT_ID,COUNT(PRODUCT_ID) AS COUNT_PROD,DELIVERED_STOREID,SELLER_STATE,REGION,
ROW_NUMBER() OVER (ORDER BY COUNT(PRODUCT_ID) DESC) AS R_N
FROM integrated_table
GROUP BY PRODUCT_ID,DELIVERED_STOREID,SELLER_STATE,REGION
)B

--******************************************--

--List the top 10 most expensive products sorted by price and their contribution to sales

WITH PRODRAN_ AS
(SELECT TOP 10 CATEGORY,PRODUCT_ID,(TOTAL_AMOUNT/QUANTITY) AS TOTAL_AMOUNT ,
DENSE_RANK() OVER (ORDER BY TOTAL_AMOUNT/QUANTITY  DESC) AS RANK_
FROM integrated_table
ORDER BY DENSE_RANK() OVER (ORDER BY TOTAL_AMOUNT/QUANTITY  DESC)
),
A AS
(SELECT PRODUCT_ID,SUM(TOTAL_AMOUNT) AS TOTAL_PROD_AMOUNT FROM integrated_table
GROUP BY PRODUCT_ID
)
SELECT P.CATEGORY,P.PRODUCT_ID,P.TOTAL_AMOUNT,A.TOTAL_PROD_AMOUNT*100/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table) AS SALES_CONTRIBUTION 
FROM PRODRAN_ P
JOIN A
ON P.PRODUCT_ID=A.PRODUCT_ID
ORDER BY P.RANK_



--******************************************--

--Which products appeared in the transactions?

SELECT DISTINCT(PRODUCT_ID) FROM integrated_table
WHERE TOTAL_AMOUNT>0;

--******************************************--

--Top 10-performing & worst 10 performance stores in terms of sales
WITH A AS(
SELECT DELIVERED_STOREID,SELLER_STATE,SELLER_CITY,SUM(TOTAL_AMOUNT) AS SALES,
DENSE_RANK() OVER (ORDER BY SUM(TOTAL_AMOUNT)  DESC) AS RANK_
FROM integrated_table
GROUP BY Delivered_StoreID,SELLER_STATE,SELLER_CITY
),B as(

(SELECT TOP 10 * FROM A
ORDER BY RANK_)
UNION ALL
(SELECT TOP 10 * FROM A
ORDER BY RANK_ desc)
)
SELECT * FROM B

---------------------------------------------------2. Customer Behaviour-----------------------------------------------------------------------------
--Segment the customers (divide the customers into groups) based on the revenue

WITH CUST_SAL AS(
SELECT CUSTOMER_ID,SUM(TOTAL_AMOUNT) AS SALES
FROM integrated_table
GROUP BY CUSTOMER_ID),
SEGMENTS AS
(
SELECT CUSTOMER_ID,
(CASE
			WHEN SALES>3000  THEN '>3000'
			WHEN SALES>2000 AND SALES<=3000  THEN '2001-3000'
			WHEN SALES>1000 AND SALES<=2000   THEN '1001-2000'
			WHEN SALES>500 AND SALES<=1000   THEN '501-1000'
			WHEN SALES>0 AND SALES<=500    THEN '0-500'
			ELSE 'NO PURCHASE'
			END) AS GROUPS
FROM CUST_SAL
)
SELECT GROUPS,COUNT(DISTINCT CUSTOMER_ID) AS COUNT_OF_CUSTOMERS
FROM SEGMENTS
GROUP BY GROUPS
ORDER BY COUNT_OF_CUSTOMERS DESC


---segment by gender

SELECT GENDER,COUNT(GENDER) AS COUNT_,SUM(TOTAL_AMOUNT) AS AMOUNT_SPENT,SUM(TOTAL_AMOUNT)*100/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table) AS PERCENT_
FROM integrated_table
GROUP BY GENDER


SELECT GENDER,COUNT(DISTINCT CUSTOMER_ID) AS COUNT_,SUM(TOTAL_AMOUNT) AS AMOUNT_SPENT,SUM(TOTAL_AMOUNT)*100/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table) AS PERCENT_
FROM integrated_table
GROUP BY GENDER


--******************************************--

--Divide the customers into groups based on Recency, Frequency, and Monetary (RFM Segmentation) - 
--Divide the customers into Premium, Gold, Silver, Standard customers and understand the behaviour of each segment of customers



WITH RFM AS
(
SELECT CUSTOMER_ID,
DATEDIFF(DAY,MAX(BILL_DATE_TIMESTAMP),GETDATE()) AS RECENCY,
COUNT(ORDER_ID)AS FREQUENCY,
SUM(TOTAL_AMOUNT) AS MONETORY
FROM integrated_table
GROUP BY CUSTOMER_ID
),

RFM_SCORES AS
(
SELECT CUSTOMER_ID,
RECENCY,
FREQUENCY,
MONETORY,
NTILE(4) OVER (ORDER BY RECENCY DESC) AS RECENCY_SCORE,
NTILE(4) OVER (ORDER BY FREQUENCY ASC) AS FREQUENCY_SCORE,
NTILE(4) OVER (ORDER BY MONETORY asc) AS MONETORY_SCORE
--CASE WHEN MONETORY>=0 AND MONETORY<201 THEN 1
--WHEN MONETORY>=201 AND MONETORY<401 THEN 2
--WHEN MONETORY>=401 AND MONETORY<601  THEN 3
--ELSE 4
--END AS MONETORY_SCORE,

FROM RFM
),
RFM_SEGMENTATION AS(
SELECT CUSTOMER_ID,
(RECENCY_SCORE+FREQUENCY_SCORE+MONETORY_SCORE) AS RFM_SCORE
FROM RFM_SCORES
),

SEGMENT AS(
SELECT
CUSTOMER_ID,
CASE WHEN RFM_SCORE>=9 AND RFM_SCORE<11 THEN 'GOLD'
	 WHEN RFM_SCORE>=7 AND RFM_SCORE<9 THEN  'SILVER'
	 WHEN RFM_SCORE>=3 AND RFM_SCORE<7 THEN  'STANDARD'
	 ELSE 'PREMIUM'
	 END AS CUSTOMER_SEGMENT
FROM RFM_SEGMENTATION
)
SELECT CUSTOMER_SEGMENT,COUNT(DISTINCT CUSTOMER_ID) AS NO_OF_CUSTOMERS
FROM SEGMENT
GROUP BY CUSTOMER_SEGMENT
ORDER BY NO_OF_CUSTOMERS DESC

--******************************************--

--Find out the number of customers who purchased in all the channels and find the key metrics.
WITH CUSTOMER_CH AS
(
SELECT CUSTOMER_ID,CHANNEL,R_N
FROM(
SELECT CUSTOMER_ID,CHANNEL,
ROW_NUMBER() OVER(PARTITION BY CUSTOMER_ID ORDER BY CHANNEL) AS R_N
FROM integrated_table
GROUP BY CUSTOMER_ID,CHANNEL)A
WHERE R_N=3
),
KEY_METRICS AS
(
SELECT CC.CUSTOMER_ID,
COUNT(O.ORDER_ID) AS NO_OF_TRANSACTIONS,
SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT,
AVG(O.TOTAL_AMOUNT) AS AVG_ORDER_VALUE,
DATEDIFF(DAY,MIN(O.BILL_DATE_TIMESTAMP),MAX(O.BILL_DATE_TIMESTAMP)) AS RECENCY
FROM integrated_table O
JOIN CUSTOMER_CH CC
ON O.CUSTOMER_ID=CC.CUSTOMER_ID
GROUP BY CC.CUSTOMER_ID
)
SELECT A.CUSTOMER_ID,
B.customer_state,
B.customer_city,
A.NO_OF_TRANSACTIONS,
A.TOTAL_SPENT,
A.AVG_ORDER_VALUE,
A.RECENCY
FROM KEY_METRICS A
JOIN integrated_table B
ON A.CUSTOMER_ID=B.CUSTOMER_ID
GROUP BY A.CUSTOMER_ID,
B.customer_state,
B.customer_city,
A.NO_OF_TRANSACTIONS,
A.TOTAL_SPENT,
A.AVG_ORDER_VALUE,
A.RECENCY

--******************************************--

--Understand the behavior of one time buyers and repeat buyers
WITH ORD AS
(
SELECT CUSTOMER_ID,COUNT(DISTINCT ORDER_ID) AS COUNT_ORD
FROM integrated_table
GROUP BY CUSTOMER_ID
),
BUYERS_CLASSIFY AS
(
SELECT CUSTOMER_ID,
CASE WHEN COUNT_ORD=1 THEN 'ONE_TIME_BUYER'
ELSE 'REPEAT BUYER'
END AS BUYERS_TYPE
FROM ORD
),
KEY_METRICS AS
(
SELECT  BC.BUYERS_TYPE,
COUNT(DISTINCT(BC.CUSTOMER_ID)) AS TOTAL_CUSTOMERS,
COUNT(DISTINCT O.ORDER_ID) AS TOTAL_ORDERS,
SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT,
AVG(O.TOTAL_AMOUNT) AS AVG_SPENT

FROM integrated_table O
JOIN BUYERS_CLASSIFY BC
ON O.CUSTOMER_ID=BC.CUSTOMER_ID
GROUP BY BC.BUYERS_TYPE
)
SELECT BUYERS_TYPE,
TOTAL_CUSTOMERS,
TOTAL_ORDERS,
TOTAL_SPENT,
AVG_SPENT
FROM KEY_METRICS;
--THE NUMBER OF ORDERS MADE BY ONE_TIME_BUYERS ARE MORE THAN REPEAT CUSTOMERS----

--******************************************--


--Understand the behavior of discount seekers & non discount seekers
WITH DISCOUNT_CLASSIFIER AS
 (
 SELECT CUSTOMER_ID,
 CASE WHEN
			SUM(CASE WHEN DISCOUNT=0  THEN TOTAL_AMOUNT ELSE 0 END)>=
			SUM(CASE WHEN DISCOUNT>0 THEN TOTAL_AMOUNT ELSE 0 END)
			THEN 'NON_DISCOUNT_SEEKERS'
 ELSE 'DISCOUNT_SEEKERS'
 END AS DISCOUNT_TYPE
 FROM integrated_table
 GROUP BY CUSTOMER_ID
 ),
 KEY_METRICS AS
 (
 SELECT DC.DISCOUNT_TYPE,
 COUNT(DISTINCT(O.CUSTOMER_ID)) AS TOTAL_CUSTOMERS,
 COUNT(DISTINCT O.ORDER_ID) AS TOTAL_ORDERS,
SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT,
AVG(O.TOTAL_AMOUNT) AS AVG_SPENT
FROM integrated_table O
JOIN DISCOUNT_CLASSIFIER DC
ON O.CUSTOMER_ID=DC.CUSTOMER_ID
GROUP BY DC.DISCOUNT_TYPE
)
SELECT DISCOUNT_TYPE,
TOTAL_CUSTOMERS,
TOTAL_ORDERS,
TOTAL_SPENT,
AVG_SPENT
FROM KEY_METRICS

---NON_DISCOUNT_SEEKERS TOTAL SPENT IS MORE THAN DISCOUNT SEEKERS----

--******************************************--


--Understand preferences of customers (preferred channel, Preferred payment method, preferred store, discount preference, preferred categories etc.)

--preferred channel
SELECT 
CHANNEL AS PREFFERED_CHANNEL,
COUNT(DISTINCT ORDER_ID) AS COUNT_ORDERS
FROM integrated_table
GROUP BY CHANNEL
ORDER BY COUNT_ORDERS DESC

--******************************************--

--preferred store by customer

SELECT
CUSTOMER_ID,
DELIVERED_STOREID AS PREFFERED_STOREID,
COUNT(DISTINCT ORDER_ID) AS COUNT_ORDERS
FROM integrated_table
GROUP BY CUSTOMER_ID,DELIVERED_STOREID
ORDER BY COUNT_ORDERS DESC

--preferred store

SELECT 
DELIVERED_STOREID AS PREFFERED_STOREID,
COUNT(DISTINCT ORDER_ID) AS COUNT_ORDERS
FROM integrated_table
GROUP BY DELIVERED_STOREID
ORDER BY COUNT_ORDERS DESC

--******************************************--

--Preferred payment method by order
SELECT
ORDER_ID,
PAYMENT_TYPE AS PREFFERED_PAYMENT_TYPE,
COUNT(DISTINCT ORDER_ID) AS COUNT_ORDERS
FROM ORDERPAYMENTS
WHERE ORDER_ID IN (SELECT DISTINCT ORDER_ID FROM integrated_table)
GROUP BY ORDER_ID,PAYMENT_TYPE
ORDER BY COUNT_ORDERS DESC

--Preferred payment method


SELECT PAYMENT_TYPE,COUNT(DISTINCT ORDER_ID) AS COUNT_ORDERS
FROM ORDERPAYMENTS
WHERE ORDER_ID IN (SELECT DISTINCT ORDER_ID FROM integrated_table)
GROUP BY PAYMENT_TYPE
ORDER BY COUNT_ORDERS DESC

--******************************************--


--preferred categories by customer-----

SELECT
CUSTOMER_ID,
CATEGORY AS PREFFERED_CATEGORY,
COUNT(DISTINCT ORDER_ID) AS COUNT_ORDERS
FROM integrated_table
GROUP BY CUSTOMER_ID,CATEGORY
ORDER BY COUNT_ORDERS DESC

--preferred categories------------

SELECT
CATEGORY AS PREFFERED_CATEGORY,
COUNT(DISTINCT ORDER_ID) AS COUNT_ORDERS
FROM integrated_table
GROUP BY CATEGORY
ORDER BY COUNT_ORDERS DESC

--******************************************--


---DISCOUNT PREFERENCES

WITH TOTAL_DISCOUNT AS(
SELECT QUANTITY,((QUANTITY*DISCOUNT)*100/TOTAL_AMOUNT )  AS DISCOUNT_PERCENT FROM integrated_table
),
BINS AS(
SELECT QUANTITY,
CASE 
WHEN DISCOUNT_PERCENT<10 THEN '0-10%'
WHEN DISCOUNT_PERCENT>=10 AND DISCOUNT_PERCENT<20 THEN '10-20%'
WHEN DISCOUNT_PERCENT>=20 AND DISCOUNT_PERCENT<30 THEN '20-30%'
WHEN DISCOUNT_PERCENT>=30 AND DISCOUNT_PERCENT<40 THEN '30-40%'
WHEN DISCOUNT_PERCENT>=40 AND DISCOUNT_PERCENT<50 THEN '40-50%'
WHEN DISCOUNT_PERCENT>=50 AND DISCOUNT_PERCENT<60 THEN '50-60%'
ELSE '>60%'
END AS BINS
FROM TOTAL_DISCOUNT
)
SELECT BINS,COUNT(BINS) AS DISCOUNT_PREFERENCE,SUM(QUANTITY) AS TOTAL_QUANTITY_ORDERED
FROM BINS
GROUP BY BINS
ORDER BY SUM(QUANTITY) DESC



--******************************************--

--Understand the behavior of customers who purchased one category and purchased multiple categories

WITH 
COUNT_ AS
(
SELECT CUSTOMER_ID,
COUNT(DISTINCT CATEGORY) AS COUNT_CATEG
FROM integrated_table
GROUP BY CUSTOMER_ID
),
CATEG_CLASSIFY AS
(
SELECT CUSTOMER_ID,
CASE WHEN COUNT_CATEG=1 THEN 'ONE_CATEGORY_BUYERS'
ELSE 'MULTIPLE_CATEGORY_BUYERS'
END AS CATEGORY_CLASSIFIER
FROM COUNT_
),
 KEY_METRICS AS
 (
 SELECT CC.CATEGORY_CLASSIFIER,
 COUNT(DISTINCT(CC.CUSTOMER_ID)) AS TOTAL_CUSTOMERS,
 COUNT(DISTINCT O.ORDER_ID) AS TOTAL_ORDERS,
SUM(O.TOTAL_AMOUNT) AS TOTAL_SPENT,
AVG(O.TOTAL_AMOUNT) AS AVG_SPENT
FROM integrated_table O
JOIN CATEG_CLASSIFY CC
ON O.CUSTOMER_ID=CC.CUSTOMER_ID
GROUP BY CC.CATEGORY_CLASSIFIER
)
SELECT  CATEGORY_CLASSIFIER,
TOTAL_CUSTOMERS,
TOTAL_ORDERS,
TOTAL_SPENT,
AVG_SPENT
FROM KEY_METRICS

---------------------------------------------------------3.Which products are selling together------------------------------------------------------------------------------------------------
--We need to find which of the top 10 combinations of products are selling together in each transaction.  (combination of 2 or 3 buying together)

WITH PRODUCTPAIR AS
(
SELECT 
O1.ORDER_ID,
O1.PRODUCT_ID AS PRODUCT_1,
O2.PRODUCT_ID AS PRODUCT_2
FROM orders O1
JOIN orders O2
ON O1.ORDER_ID=O2.ORDER_ID
AND O1.PRODUCT_ID<O2.PRODUCT_ID
),
CAT_ AS(
SELECT P1.PRODUCT_1,
P1.PRODUCT_2,
C1.CATEGORY AS CATEGORY_1,
C2.CATEGORY AS CATEGORY_2
FROM PRODUCTPAIR P1
JOIN productsinfo C1
ON C1.PRODUCTID=P1.PRODUCT_1
JOIN productsinfo C2
ON C2.PRODUCTID=P1.PRODUCT_2
),
PAIRCOUNT AS
(
SELECT PRODUCT_1,
PRODUCT_2,
CATEGORY_1,
CATEGORY_2,
COUNT(*) AS COMBINATION_COUNT
FROM CAT_
GROUP BY PRODUCT_1,PRODUCT_2,CATEGORY_1,CATEGORY_2
)

SELECT TOP 10 * FROM PAIRCOUNT
ORDER BY COMBINATION_COUNT DESC


-----------------------------------------------------------------------4. Understand the Category Behavior----------------------------------------------------------------------------
--Total Sales & Percentage of sales by category (Perform Pareto Analysis)
--Total Sales
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_SALES FROM integrated_table

--Percentage of sales by category
SELECT CATEGORY,SUM(TOTAL_AMOUNT) AS SALES,
SUM(SUM(TOTAL_AMOUNT)) OVER(ORDER BY SUM(TOTAL_AMOUNT) DESC) CUMM_SALES,
(SUM(TOTAL_AMOUNT)/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table))*100 AS PERCENT_OF_SALES,
SUM((SUM(TOTAL_AMOUNT)/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table))*100) 
OVER(ORDER BY SUM(TOTAL_AMOUNT) DESC) AS CUMM_PERCENT_OF_SALES
FROM integrated_table
GROUP BY CATEGORY
ORDER BY SALES DESC

--******************************************--

--Most profitable category and its contribution

WITH O_P AS
(
SELECT Category,
SUM(TOTAL_AMOUNT-(COST_PER_UNIT*QUANTITY)) AS TOTAL_PROFIT,
SUM(TOTAL_AMOUNT) AS TOTAL_AMOUNT
FROM integrated_table
GROUP BY CATEGORY
)

SELECT CATEGORY,
TOTAL_PROFIT,
(TOTAL_AMOUNT/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table) )*100 AS SALE_CONTRIBUTION
FROM O_P
ORDER BY SALE_CONTRIBUTION DESC

--******************************************--

--Category Penetration Analysis by month on month (Category Penetration = number of orders containing the category/number of orders)


WITH MONTHLY_ORDER AS
(
SELECT DATENAME(MONTH,BILL_DATE_TIMESTAMP)AS MONTH_,COUNT(DISTINCT(ORDER_ID)) AS TOTAL_ORDERS
FROM integrated_table
GROUP BY DATENAME(MONTH,BILL_DATE_TIMESTAMP)
),
CATEGORY_ORDER AS
(
SELECT CATEGORY,
DATENAME(MONTH,BILL_DATE_TIMESTAMP)MONTH_,
COUNT(DISTINCT(ORDER_ID)) AS CATEGORY_ORDERS
FROM integrated_table
GROUP BY CATEGORY,DATENAME(MONTH,BILL_DATE_TIMESTAMP)
)
SELECT
C.MONTH_,
C.CATEGORY,
C.CATEGORY_ORDERS,
M.TOTAL_ORDERS,
((C.CATEGORY_ORDERS)*1.0/(M.TOTAL_ORDERS))*100 AS CATEGORY_PENETRATION
FROM CATEGORY_ORDER C
JOIN MONTHLY_ORDER M
ON C.MONTH_=M.MONTH_
ORDER BY C.MONTH_,C.CATEGORY

--******************************************--

--Cross Category Analysis by month on Month (In Every Bill, how many categories shopped. Need to calculate average number of categories shopped in each bill by Region, By State etc)

WITH CATEGORIES_PER_ORDER AS
(
SELECT 
ORDER_ID,
REGION,
DATEPART(YEAR,BILL_DATE_TIMESTAMP)YEAR_,
DATEPART(MONTH,BILL_DATE_TIMESTAMP)MONTH_,
CAST(COUNT(DISTINCT CATEGORY) AS FLOAT) AS CATEGORY_COUNT

FROM INTEGRATED_TABLE
GROUP BY ORDER_ID,REGION,DATEPART(YEAR,BILL_DATE_TIMESTAMP),DATEPART(MONTH,BILL_DATE_TIMESTAMP)
),
AVG_CATE AS
(
SELECT
YEAR_,
MONTH_,
REGION,
AVG(CATEGORY_COUNT) AS AVG_CAT_PER_ORDER
FROM CATEGORIES_PER_ORDER
GROUP BY YEAR_,MONTH_,REGION
)
SELECT
--CONCAT(YEAR_,'- ',MONTH_) AS YEAR_MONTH,
YEAR_,
MONTH_,
AVG(CASE WHEN REGION='NORTH' THEN AVG_CAT_PER_ORDER END)AS NORTH,
AVG(CASE WHEN REGION='SOUTH' THEN AVG_CAT_PER_ORDER END)AS SOUTH,
AVG(CASE WHEN REGION='EAST' THEN AVG_CAT_PER_ORDER END) AS EAST,
AVG(CASE WHEN REGION='NORTH' THEN AVG_CAT_PER_ORDER END) AS WEST
FROM AVG_CATE
GROUP BY YEAR_,MONTH_,CONCAT(YEAR_,'-',MONTH_)
ORDER BY YEAR_,MONTH_;
-----------------------------------

WITH CATEGORIES_PER_ORDER AS
(
SELECT 
ORDER_ID,
CUSTOMER_STATE,
DATEPART(YEAR,BILL_DATE_TIMESTAMP)YEAR_,
DATEPART(MONTH,BILL_DATE_TIMESTAMP)MONTH_,
CAST(COUNT(DISTINCT CATEGORY) AS FLOAT) AS CATEGORY_COUNT

FROM integrated_table
GROUP BY ORDER_ID,CUSTOMER_STATE,DATEPART(YEAR,BILL_DATE_TIMESTAMP),DATEPART(MONTH,BILL_DATE_TIMESTAMP)
),
AVG_CATE AS
(
SELECT
YEAR_,
MONTH_,
CUSTOMER_STATE,
AVG(CAST(CATEGORY_COUNT AS FLOAT)) AS AVG_CAT_PER_ORDER
FROM CATEGORIES_PER_ORDER
GROUP BY YEAR_,MONTH_,CUSTOMER_STATE
)
SELECT
YEAR_,
MONTH_,
CUSTOMER_STATE,
AVG_CAT_PER_ORDER
FROM AVG_CATE
ORDER BY YEAR_,MONTH_;

--******************************************--


--Most popular category during first purchase of customer

WITH FIRST_PURCHASE AS
(
SELECT CUSTOMER_ID,
MIN(BILL_DATE_TIMESTAMP) AS FIRST_PUR
FROM integrated_table
GROUP BY CUSTOMER_ID
),
FIRST_PURCH_DETAILS AS
(
SELECT OP.CUSTOMER_ID,
OP.ORDER_ID,
OP.BILL_DATE_TIMESTAMP,
OP.CATEGORY
FROM integrated_table AS OP
JOIN FIRST_PURCHASE FP
ON OP.CUSTOMER_ID=FP.CUSTOMER_ID
AND OP.BILL_DATE_TIMESTAMP=FP.FIRST_PUR
)
SELECT CATEGORY,
COUNT(DISTINCT ORDER_ID) AS PURCHASE_COUNT
FROM FIRST_PURCH_DETAILS
GROUP BY CATEGORY
ORDER BY PURCHASE_COUNT DESC


-------------------------------------------------------------------5. Customer satisfaction towards category & product ---------------------------------

--DROP TABLE #O_P_RR

--******************************************--

--Which categories (top 10) are maximum rated & minimum rated and average rating score? 

WITH CATEGORY_RATING AS
(
SELECT
CATEGORY,
AVG(cast(CUSTOMER_SATISFACTION_SCORE as float)) AVG_RATING,
COUNT(CUSTOMER_SATISFACTION_SCORE) AS COUNT_OF_RATING
FROM integrated_table
WHERE Customer_Satisfaction_Score IS NOT NULL
GROUP BY CATEGORY
),

TOP_10_MAX_RATED AS
(
SELECT TOP 10
CATEGORY,
AVG_RATING,
COUNT_OF_RATING
FROM CATEGORY_RATING
ORDER BY avg_rating DESC
),
TOP_10_MIN_RATED AS
(
SELECT TOP 10
CATEGORY,
AVG_RATING,
COUNT_OF_RATING
FROM CATEGORY_RATING
ORDER BY avg_rating
)
SELECT 
'MAX_RATING' AS RATING_TYPE,
CATEGORY,
AVG_RATING,
COUNT_OF_RATING
FROM TOP_10_MAX_RATED
 UNION ALL
 SELECT
 'MIN_RATING' AS RATING_TYPE,
CATEGORY,
AVG_RATING,
COUNT_OF_RATING
FROM TOP_10_MIN_RATED
ORDER BY RATING_TYPE DESC,AVG_RATING DESC

--******************************************--


--DROP TABLE #TEMP1

--******************************************--

--Average rating by location, store, product, category, month, etc.

SELECT 'BY LOCATION' AS DIMENSION,
SELLER_STATE AS VALUE,
AVG(cast(CUSTOMER_SATISFACTION_SCORE as float)) AVG_RATING,
COUNT(CUSTOMER_SATISFACTION_SCORE) AS TOTAL_RATING
FROM integrated_table
GROUP BY SELLER_STATE

UNION ALL

SELECT 'BY PRODUCT' AS DIMENSION,
PRODUCT_ID AS VALUE,
AVG(cast(CUSTOMER_SATISFACTION_SCORE as float)) AVG_RATING,
COUNT(CUSTOMER_SATISFACTION_SCORE) AS TOTAL_RATING
FROM integrated_table
GROUP BY PRODUCT_ID


UNION ALL

SELECT 'BY CATEGORY' AS DIMENSION,
CATEGORY AS VALUE,
AVG(cast(CUSTOMER_SATISFACTION_SCORE as float)) AVG_RATING,
COUNT(CUSTOMER_SATISFACTION_SCORE) AS TOTAL_RATING
FROM integrated_table
GROUP BY CATEGORY


UNION ALL

SELECT 'BY STORE' AS DIMENSION,
DELIVERED_STOREID AS VALUE,
AVG(cast(CUSTOMER_SATISFACTION_SCORE as float)) AVG_RATING,
COUNT(CUSTOMER_SATISFACTION_SCORE) AS TOTAL_RATING
FROM integrated_table
GROUP BY DELIVERED_STOREID

UNION ALL

SELECT 'BY MONTH' AS DIMENSION,
CONCAT (YEAR(BILL_DATE_TIMESTAMP),'-',MONTH(BILL_DATE_TIMESTAMP)) AS VALUE,
AVG(cast(CUSTOMER_SATISFACTION_SCORE as float)) AVG_RATING,
COUNT(CUSTOMER_SATISFACTION_SCORE) AS TOTAL_RATING
FROM integrated_table
GROUP BY YEAR(BILL_DATE_TIMESTAMP),MONTH(BILL_DATE_TIMESTAMP)

ORDER BY DIMENSION,AVG_RATING DESC;



-------------------------------------------------6. Perform cohort analysis (customer retention for month on month and retention for fixed month)---------------------------------------------------------------------------------------
--"Customers who started in each month and understand their behavior in the respective months 
--(Example: If 100 new customers started in Jan -2023, how is the 100 new customer behavior (in terms of purchases, revenue, etc..) in Feb-2023, Mar-2023, Apr-2023, etc...)
--Which Month cohort has maximum retention?"


WITH CUSTOMER_START_MONTH AS
(
SELECT 
CUSTOMER_ID,
MIN(YEAR(BILL_DATE_TIMESTAMP)*100+MONTH(BILL_DATE_TIMESTAMP)) AS START_MONTH
FROM integrated_table
GROUP BY CUSTOMER_ID
),
COHORT_ANALYSIS AS
(
SELECT 
CSM.START_MONTH AS COHORT_START_MONTH,
(YEAR(O.BILL_DATE_TIMESTAMP)*100+MONTH(O.BILL_DATE_TIMESTAMP)) AS ANALYSIS_MONTH,
COUNT(DISTINCT O.CUSTOMER_ID) AS NUM_CUST,
COUNT(O.ORDER_ID) AS TOTAL_ORDERS,
SUM(O.TOTAL_AMOUNT) AS TOTAL_REVENUE

FROM CUSTOMER_START_MONTH CSM
JOIN integrated_table O
ON CSM.CUSTOMER_ID=O.CUSTOMER_ID
GROUP BY CSM.START_MONTH,
YEAR(O.BILL_DATE_TIMESTAMP),
MONTH(O.BILL_DATE_TIMESTAMP)
)

SELECT COHORT_START_MONTH,
ANALYSIS_MONTH,
NUM_CUST,
TOTAL_ORDERS,
TOTAL_REVENUE,
(NUM_CUST*1.0/MAX(NUM_CUST) OVER(PARTITION BY COHORT_START_MONTH)*100) AS  RETENTION_PERCENT
FROM COHORT_ANALYSIS
ORDER BY COHORT_START_MONTH,
ANALYSIS_MONTH


-------------------------------------------------7. Perform analysis related to Sales Trends, patterns, and seasonality.----------------------------------------
--Which months have had the highest sales, what is the sales amount and contribution in percentage?

WITH SALES AS
(
SELECT MONTH(BILL_DATE_TIMESTAMP) AS MONTH_,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY MONTH(BILL_DATE_TIMESTAMP)
)
SELECT  MONTH_,
TOTAL_SALES,
(TOTAL_SALES/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table))*100 AS CONTRIBUTION_PERCENT
FROM SALES
ORDER BY MONTH_

--******************************************--

--Which months have had the least sales, what is the sales amount and contribution in percentage?
WITH SALES AS
(
SELECT MONTH(BILL_DATE_TIMESTAMP) AS MONTH_,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY MONTH(BILL_DATE_TIMESTAMP)
)
SELECT TOP 1 MONTH_,
TOTAL_SALES,
(TOTAL_SALES/(SELECT SUM(TOTAL_AMOUNT) FROM integrated_table))*100 AS CONTRIBUTION_PERCENT
FROM SALES
ORDER BY TOTAL_SALES 

--******************************************--

--Sales trend by month 
SELECT 
YEAR(BILL_DATE_TIMESTAMP) AS YEAR_,
MONTH(BILL_DATE_TIMESTAMP) AS MONTH_,
CONCAT(YEAR(BILL_DATE_TIMESTAMP),'-',MONTH(BILL_DATE_TIMESTAMP)) AS YEAR_MONTH,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY YEAR(BILL_DATE_TIMESTAMP),
MONTH(BILL_DATE_TIMESTAMP)
ORDER BY YEAR_,MONTH_

--******************************************--

--Is there any seasonality in the sales (weekdays vs. weekends, months, days of week, weeks etc.)?
--seasonality in the sales weekdays vs. weekends
SELECT
CASE
WHEN DATENAME(WEEKDAY,BILL_DATE_TIMESTAMP) IN ('SATURDAY','SUNDAY') THEN 'WEEKEND'
ELSE 'WEEKDAY'
END AS DAY_TYPE,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY 
CASE
WHEN DATENAME(WEEKDAY,BILL_DATE_TIMESTAMP) IN ('SATURDAY','SUNDAY') THEN 'WEEKEND'
ELSE 'WEEKDAY'
END;

--******************************************--

---SALES BY MONTH
SELECT 
DATEPART(MONTH,BILL_DATE_TIMESTAMP) AS MONTH_,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY DATEPART(MONTH,BILL_DATE_TIMESTAMP)
ORDER BY MONTH_

--******************************************--

----SALES BY DAYS OF WEEK
SELECT 
DATENAME(WEEKDAY,BILL_DATE_TIMESTAMP) AS WEEK_DAY,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY DATENAME(WEEKDAY,BILL_DATE_TIMESTAMP)
ORDER BY WEEK_DAY

--******************************************--

----SALES BY WEEKS
SELECT 
DATEPART(YEAR,BILL_DATE_TIMESTAMP) AS YEAR_,
DATEPART(WEEK,BILL_DATE_TIMESTAMP) AS WEEK_,
CONCAT(DATEPART(YEAR,BILL_DATE_TIMESTAMP),'-',DATEPART(WEEK,BILL_DATE_TIMESTAMP)) AS WEEK_NO,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY DATEPART(YEAR,BILL_DATE_TIMESTAMP),
DATEPART(WEEK,BILL_DATE_TIMESTAMP)
ORDER BY YEAR_,WEEK_

--******************************************--

--SALES BY  QUARTER

SELECT 
DATEPART(YEAR,BILL_DATE_TIMESTAMP) AS YEAR_,
DATEPART(QUARTER,BILL_DATE_TIMESTAMP) AS QUARTER_,
CONCAT(DATEPART(YEAR,BILL_DATE_TIMESTAMP),'-Q',DATEPART(QUARTER,BILL_DATE_TIMESTAMP)) AS YEAR_WISE_QUARTERS,
SUM(TOTAL_AMOUNT) AS TOTAL_SALES
FROM integrated_table
GROUP BY DATEPART(YEAR,BILL_DATE_TIMESTAMP),
DATEPART(QUARTER,BILL_DATE_TIMESTAMP)
ORDER BY YEAR_,QUARTER_

