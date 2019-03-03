/* Answer to question number 1 */
select 
c.customer_id, 
c.first_name, 
c.last_name, 
sum(p.amount) as 'TOTAL SPENT' from payment p
join customer c 
	on p.customer_id = c.customer_id
group by p.customer_id
order by last_name ASC,
sum(p.amount) DESC;

/* Answer to question number 2 */
select
distinct a.district, a.city_id
from address a
join city c 
	on a.city_id = c.city_id 
where postal_code = '';

/* Answer to question number 3 */
select 
f.title 
from film f 
where f.title like '%DOCTOR%' OR f.title like '%FIRE%';

/* Answer to question number 4 */
select 
fa.actor_id, 
a.first_name, 
a.last_name, 
count(fa.actor_id) as 'NUMBER OF MOVIES'
from film_actor fa
join film f 
	on fa.film_id = f.film_id
join actor a 
	on fa.actor_id = a.actor_id
group by fa.actor_id
order by a.last_name ASC, 
count(fa.actor_id) DESC;

/* Answer to question number 5 */
select 
c.name, 
AVG(f.length) 
from film f
join film_category fc 
	on f.film_id = fc.film_id
join category c 
on c.category_id = fc.category_id
group by c.name
order by AVG(f.length);

/* Answer to question number 6 */
select 
s.store_id,
SUM(p.amount) 
from store s 
join staff st 
	on s.store_id = st.store_id
join payment p 
	on st.staff_id = p.staff_id
group by s.store_id
order by SUM(p.amount) desc;

/* Answer to question number 7 */
select 
c.first_name,
c.last_name,
c.email,
SUM(amount) as 'Total Amount' 
from city ci
join country co 
	on ci.country_id = co.country_id
join address a
	on ci.city_id = a.city_id
join customer c 
	on a.address_id = c.address_id
join payment p 
	on c.customer_id = p.customer_id
where co.country = 'Canada'
group by c.customer_id
order by c.last_name;

/* Answer to question number 8 */
start transaction;
insert into 
rental(rental_date, inventory_id, customer_id, staff_id)
	values(
			now(), 
            (select min(i.inventory_id) from Inventory i
				join film f
					on i.film_id = f.film_id
				where f.title = "Hunger Roof" and i.store_id = 2),
			(select c.customer_id from customer c
				where c.first_name = "Mathew" and c.last_name = "Bolin"),
			(select s.staff_id from staff s
				where s.first_name = "Jon" and s.last_name = "Stephens" and s.store_id = 2));
            
insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
	select customer_id, staff_id, rental_id, 2.99, rental_date
    from rental where last_update = now();

Rollback;
commit;

/* Answer to question number 9 */
start transaction;
update rental r
	join customer c
		on r.customer_id = c.customer_id
	join inventory i 
		on r.inventory_id = i.inventory_id
    join film f
		on i.film_id = f.film_id
    set r.return_date = now()
	where c.first_name = "Tracy" and c.last_name = "Cole" and f.title = "Ali Forever";

Rollback;
commit;

/* Answer to question number 10 */
start transaction;

update category 
set name = replace (name, 'Animation', 'Japanese') where category_id = '2';

Rollback;
commit;



