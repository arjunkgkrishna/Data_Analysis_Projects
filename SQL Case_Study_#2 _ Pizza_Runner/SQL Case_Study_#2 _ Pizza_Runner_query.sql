--removing null values from customer_orders table
DROP TABLE IF EXISTS #customer_orders;

SELECT order_id, customer_id, pizza_id, 
  CASE 
    WHEN exclusions  LIKE 'null' THEN  null
	when exclusions like '' then null
    ELSE exclusions
    END AS exclusions,
  CASE 
    WHEN extras  LIKE 'null' THEN null
	when extras like '' then null

    ELSE extras 
    END AS extras, 
  order_time
INTO #customer_orders -- create TEMP TABLE
FROM customer_orders;

--removing null values from runner_orders table

DROP TABLE IF EXISTS #runner_orders

select order_id,runner_id ,
   case when pickup_time  like 'null' then null 
	else pickup_time
	end as pickup_time,
  case when distance like 'null' then null 
    when distance like '%km' then trim('km' from distance)
	else distance 
	end as distance,
  case when duration like 'null' then null 
   when duration like '%min%' then LEFT(duration, CHARINDEX('m',duration)-1)
   else duration
   end as duration,
  case when cancellation like 'null' then null 
		when cancellation like '' then null
   else cancellation
   end as cancellation
into #runner_orders
from runner_orders


--Altering data into the correct data type
ALTER TABLE #runner_orders
ALTER COLUMN pickup_time DATETIME
ALTER COLUMN distance FLOAT
ALTER COLUMN duration INT



				--A. Pizza metrics

--1.How many pizzas were ordered?

select COUNT(*) as pizza_ordered
	from #customer_orders 

--2.How many unique customer orders were made?

select COUNT(distinct order_id) as unique_order
	from #customer_orders 


--3.How many successful orders were delivered by each runner?


select runner_id,COUNT(order_id) as successful_orders_delivered
	from #runner_orders
	where distance is not null
	group by runner_id




--4. How many of each type of pizza was delivered?

SELECT p.pizza_name, COUNT(c.pizza_id) AS delivered_pizza_count
FROM #customer_orders  c
JOIN #runner_orders  r
 ON c.order_id = r.order_id
JOIN pizza_names  p
 ON c.pizza_id = p.pizza_id
WHERE r.distance != 0
GROUP BY p.pizza_name;




--5.How many Vegetarian and Meatlovers were ordered by each customer?

select c.customer_id,p.pizza_name,COUNT(c.order_id) as count
	from #customer_orders c
	join pizza_names p
	on c.pizza_id=p.pizza_id
group by c.customer_id,p.pizza_name
order by 1




--6. What was the maximum number of pizzas delivered in a single order?

with cte as
	(select c.order_id,COUNT(c.pizza_id) as count
	    from #customer_orders c
		join #runner_orders r
		on c.order_id=r.order_id
		where r.distance is not null
	group by c.order_id
	)
select max(count) as maximum_pizza_delivered
	from cte


--7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

select c.customer_id,
	sum(case when (c.extras is not null or c.exclusions is not null) then 1 else 0 end) as change,
	sum(case when (c.extras IS null and c.exclusions IS null) then 1 else 0 end) as no_change
	
	from #customer_orders c
	join #runner_orders r
	on c.order_id = r.order_id
	where distance is not null
group by customer_id




--8. How many pizzas were delivered that had both exclusions and extras?


select 
	sum(case when (c.extras is not null and c.exclusions is not null) then 1 else 0 end) as had_both_change
	
	from #customer_orders c
	join #runner_orders r
	on c.order_id = r.order_id
	where distance is not null


--9. What was the total volume of pizzas ordered for each hour of the day?


SELECT DATEPART(HOUR,order_time) as hour_of_day ,COUNT(order_id) as pizza_count
from #customer_orders
group by  DATEPART(HOUR,order_time)
order by 1


--10. What was the volume of orders for each day of the week?


select FORMAT(order_time,'dddd') as day_of_week,COUNT(order_id) as order_count
from #customer_orders
group by FORMAT(order_time,'dddd')




						--B. Runner and Customer Experience

--1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)


select DATEPART(week,registration_date) as registration_week,
		COUNT(runner_id) as registered_runner_count
from runners
group by DATEPART(week,registration_date)


--2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

select r.runner_id ,AVG(datediff(minute,c.order_time,r.pickup_time)) as avg_time_taken
from #customer_orders c
join #runner_orders r
on c.order_id=r.order_id
group by r.runner_id


--3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

with cte as 
(select c.order_id,count(c.pizza_id) as pizza_count,datediff(minute,c.order_time,r.pickup_time) as avg_time_taken
from #customer_orders c
join #runner_orders r
on c.order_id=r.order_id
where r.distance is not null
group by c.order_id,c.order_time,r.pickup_time
)

select pizza_count,AVG(avg_time_taken)
from cte
group by pizza_count

--Yes , time taken increases as pizza count increases


--4. What was the average distance travelled for each customer?


select c.customer_id,AVG(r.distance) as avg_distance_in_kms
from #runner_orders r
join #customer_orders c
on r.order_id=c.order_id
where r.distance is not null
group by c.customer_id


--5. What was the difference between the longest and shortest delivery times for all orders?

select MAX(duration) -MIN(duration) as delivery_time_diff
from #runner_orders 


--6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

select order_id,distance,AVG((distance/duration)*60) as avg_speed_in_kmph
from #runner_orders
where distance is not null
group by order_id,distance
order by 2


--7. What is the successful delivery percentage for each runner?

SELECT runner_id, 
 ROUND(100 * SUM
  (CASE WHEN cancellation IS null then 1
  ELSE 0
  END) / COUNT(*), 0) AS success_perc
FROM #runner_orders
GROUP BY runner_id
