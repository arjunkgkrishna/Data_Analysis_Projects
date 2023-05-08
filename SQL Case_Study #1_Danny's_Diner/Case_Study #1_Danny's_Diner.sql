
CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');





  --solutions

  -- 1. What is the total amount each customer spent at the restaurant?

select sales.customer_id,
	   sum(menu.price) as total_amount_spent
from sales 
join menu
on sales.product_id = menu.product_id
group by sales.customer_id
order by 1


-- 2. How many days has each customer visited the restaurant?

select  customer_id,
		count(distinct order_date) days_visited
from sales 
group by customer_id
order by 2 desc


-- 3. What was the first item from the menu purchased by each customer?

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


-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

select Top 1 menu.product_name , count(sales.product_id)
		From Menu 
		join Sales 
		On menu.product_id = sales.product_id
		group by menu.product_name
		order by Count(sales.product_id) desc

-- 5. Which item was the most popular for each customer?

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

-- 6. Which item was purchased first by the customer after they became a member?

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

-- 7. Which item was purchased just before the customer became a member?

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
-- 8. What is the total items and amount spent for each member before they became a member?

select sales.customer_id, count(sales.product_id) as total_iteams,sum(menu.price) as amount_spent
from sales
join members
on sales.customer_id = members.customer_id
join menu 
on sales.product_id = menu.product_id
where sales.order_date < members.join_date
group by sales.customer_id
order by 1
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

select sales.customer_id,
		sum(case when sales.product_id = 1 then 2*10*menu.price
        	 else 10*menu.price end) as point 
from sales
join menu 
on sales.product_id = menu.product_id
group by sales.customer_id
order by 1
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

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
