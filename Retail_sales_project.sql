select * from retail_sales
where 
	transaction_id is null
	or
	sale_time is null
	or
	sale_date is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or
	quantity is null
	or
	cogs is null
	or
	total_sale is null;
	
	--
	
	delete from retail_sales
	where 
	transaction_id is null
	or
	sale_time is null
	or
	sale_date is null
	or
	customer_id is null
	or
	gender is null
	or
	category is null
	or
	quantity is null
	or
	cogs is null
	or
	total_sale is null;
	
	select count(*) from retail_sales;
	
	-- DATA EXPLORATION
	
	--How many sales we have
	select count(*) as total_sales from retail_sales;
	
	-- How many customers we have
	select count (distinct customer_id) as total_customers from retail_sales;
	
	-- How many category we have
	select count(distinct category) as unique_category from retail_sales;
	
	--Data Analysis & Business key problems
	
	--1. write sql query to retrieve all columns for sales made on '2022-11-05'
	
	select * from retail_sales
	where sale_date = '2022-11-05';
	
	
	--2.write sql query to retrieve all transactions where the category is'clothing'and quantity sold is more than 4 in the month of Nov-2022
	
	
select * from retail_sales
where category ='Clothing' and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
and quantity >= 4

-- 3. write sql query to calculate the total sales for each category

select category,sum(total_sale) as net_sales,
count(*) as total_orders from retail_sales
group by category;

-- 4.Write sql query to find the average age of customers who purchased items from th 'Beauty' category

select round(avg(age),2) as average_age_of_customers
from retail_sales
where category='Beauty';

--5. write sql query to find all transactions where total_sales is greater than 1000


select * from retail_sales
where total_sale >1000;

-- 6. write sql query to find the total number of transactions (transaction_id) made by each gender in each category


select gender, category, count(transaction_id) as no_transactions
from retail_sales
group by gender, category
order by 1

-- 7.write sql query to calculate the average sale for each month . Find the best selling month in each year

select * from retail_sales;
select * from(
	select
	extract (year from  sale_date ) as year,
	extract (month from  sale_date ) as month,
	avg(total_sale) as average_sale,
	rank() over(partition by extract (year from  sale_date )order by avg(total_sale) desc ) as rank
	from retail_sales
	group by 1,2)
as t1 
where rank=1
order by 1, 3 desc;

--8. Write sql query to find the top 5 customers based on the highest total sales

 select
 	customer_id, sum(total_sale) as total_sales from retail_sales
	group by 1
	order by  2 desc
	limit 5;
	
--9. write sql query to find the number of unique customer who purchased items from each category

select count(distinct customer_id) as no_of_unique_customers, category
from retail_sales
group by 2

-- 10.  write sql query to create each shift and number of order (Example morning < 12 , Afternoon between 12 & 17 , Evening > 17)

select * from retail_sales;
--CTE is used
with hourly_sales
as
(
select * ,
case 
	when extract(hour from sale_time)< 12 then 'morning'
	when extract(hour from sale_time) between 12 and 17 then 'afternoon'
	else 'evening'
end as shift
from retail_sales
	
)
select count(*) as total_orders,
shift
from hourly_sales
group by shift

-- END OF PROJECT

	