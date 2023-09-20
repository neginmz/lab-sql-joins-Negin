use sakila;
-- List the number of films per category.
select count(f.film_id) as film_number, fc.category_id from film as f
inner join film_category as fc
on f.film_id=fc.film_id
group by fc.category_id
order by count(f.film_id) Desc;
-- Retrieve the store ID, city, and country for each store.
select s.store_id, a.city_id, c.city, co.country from store as s
join address as a
on s.address_id=a.address_id
join city as c
on c.city_id=a.city_id
join country as co
on c.country_id=co.country_id;
-- Calculate the total revenue generated by each store in dollars.
select format(sum(p.amount),'C') as total_revenue, s.store_id from payment as p
join staff as st
on p.staff_id=st.staff_id
join store as s
on s.store_id=st.store_id
group by s.store_id;
-- Determine the average running time of films for each category.
select round(avg(length)) as film_duration_avg, c.name from film as f
join film_category as fc
on fc.film_id=f.film_id
join category as c
on c.category_id=fc.category_id
group by fc.category_id, c.name;
-- Identify the film categories with the longest average running time
select round(avg(length)) as film_duration_avg, c.name from film as f
join film_category as fc
on fc.film_id=f.film_id
join category as c
on c.category_id=fc.category_id
group by fc.category_id, c.name
order by film_duration_avg;
-- Display the top 10 most frequently rented movies in descending order.
select f.title, count(f.title) as number_rented_movie from film as f
join inventory as inv
on f.film_id=inv.film_id
join rental as r
on inv.inventory_id=r.inventory_id
group by f.film_id, f.title
order by number_rented_movie Desc
limit 10 ;
-- Determine if "Academy Dinosaur" can be rented from Store 1.
select f.film_id, f.title, inv.store_id from film as f
join inventory as inv
on f.film_id=inv.film_id
join rental as re
on re.inventory_id=inv.inventory_id
where title="Academy Dinosaur" and store_id=1
group by film_id;
-- Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
select distinct(title),inv.inventory_id,
case
WHEN inventory_id is null then 'no available'
when inventory_id is not null then 'available'
end as 'availibility'
from film as f
left join inventory as inv
on inv.film_id=f.film_id;







