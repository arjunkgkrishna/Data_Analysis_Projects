# [8-Week SQL Challenge](https://8weeksqlchallenge.com/)


##  [Case Study #1 - Danny's Diner](https://8weeksqlchallenge.com/case-study-1/)


### Problem Statement

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.
    
### Case Study Questions

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?. 



### Solutions

1. What is the total amount each customer spent at the restaurant?
```
select sales.customer_id,
	   sum(menu.price) as total_amount_spent
from sales 
join menu
on sales.product_id = menu.product_id
group by sales.customer_id
order by 1

```
2. How many days has each customer visited the restaurant?
```
select  customer_id,
		count(distinct order_date) days_visited
from sales 
group by customer_id
order by 2 desc
```

3. What was the first item from the menu purchased by each customer?
```
with cte as (select  s.customer_id,
			m.product_name as first_item,
          	dense_rank() over (partition  by s.customer_id order by s.order_date) as rank
			from sales s
          	join menu m
          	on s.product_id = m.product_id
group by S.customer_id, M.product_name,S.order_date)
            
 select customer_id, first_item
 from cte
 where rank =1
```

4. What is the most purchased item on the menu and how many times was it purchased by all customers?
```
select Top 1 menu.product_name , count(sales.product_id)
		From Menu 
		join Sales 
		On menu.product_id = sales.product_id
		group by menu.product_name
		order by Count(sales.product_id) desc
```
5. Which item was the most popular for each customer?
```
With rank as
(
Select sales.customer_ID ,
      menu.product_name, 
       Count(sales.product_id) as  most_popular,
       Dense_rank()  Over (Partition by sales.Customer_ID order by Count(sales.product_id) DESC ) as Rank
From menu 
join sales 
On menu.product_id = sales.product_id
group by sales.customer_id,sales.product_id,menu.product_name
)
Select Customer_id,Product_name,most_popular
From rank
where rank = 1
```
6. Which item was purchased first by the customer after they became a member?
```
with cte  as     
(select sales.customer_id, sales.product_id,
		dense_rank() over(partition by sales.customer_id order by sales.order_date) as rank
from sales
join members
on sales.customer_id = members.customer_id
where sales.order_date>=members.join_date)

select cte.customer_id, menu.product_name
from cte
join menu 
on cte.product_id = menu.product_id
where rank =1
```
7. Which item was purchased just before the customer became a member?
```
with cte  as     
(
select sales.customer_id, sales.product_id,
		dense_rank() over(partition by sales.customer_id order by sales.order_date desc ) as rank
from sales
join members
on sales.customer_id = members.customer_id
where sales.order_date < members.join_date)

select cte.customer_id, menu.product_name
from cte
join menu
on cte.product_id = menu.product_id
where rank =1
```
8. What is the total items and amount spent for each member before they became a member?
```
select sales.customer_id, count(sales.product_id) as total_iteams,sum(menu.price) as amount_spent
from sales
join members
on sales.customer_id = members.customer_id
join menu 
on sales.product_id = menu.product_id
where sales.order_date < members.join_date
group by sales.customer_id
order by 1
```
9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
```
select sales.customer_id,
		sum(case when sales.product_id = 1 then 2*10*menu.price
        	 else 10*menu.price end) as point 
from sales
join menu 
on sales.product_id = menu.product_id
group by sales.customer_id
order by 1
```
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
```
select sales.customer_id,
		sum(case when (sales.order_date >= members.join_date) and (sales.order_date <= (DATEADD(day,6,members.join_date)))
				 		then 2*10*menu.price
             	 when sales.product_id = 1 then 2*10*menu.price
        	       else 10*menu.price end) as point 
from sales
join menu 
on sales.product_id = menu.product_id
join members
on sales.customer_id = members.customer_id
where sales.order_date <= '2021-01-31'
group by sales.customer_id
order by 1
```
