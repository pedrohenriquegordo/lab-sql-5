##############################
###########Labs 01############
##############################
#1
use sakila;
#2
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
#3
SELECT title FROM film;
#4
SELECT DISTINCT(name) AS language FROM language;
#5.1
SELECT count(store_id) FROM store;
#5.2
SELECT count(staff_id) FROM STAFF;
#5.3
SELECT distinct(first_name) FROM STAFF;
##############################
###########Labs 02############
##############################
#1
SELECT first_name FROM actor WHERE first_name = 'Scarlett';
#2
SELECT last_name FROM actor WHERE last_name = 'Johansson';
#3
SELECT count(film_id) FROM film;
#4
SELECT count(rental_id) FROM rental;
#5
SELECT min(rental_duration) FROM film;
SELECT max(rental_duration) FROM film;
#6
SET @min_length = (SELECT min(length) FROM film);
SET @max_length = (SELECT max(length) FROM film);
#7
SET @avg_length = (SELECT avg(LENGTH) FROM film);
#8
SELECT @avg_length DIV 60 AS hrs, @avg_length % 60 AS min;
#9
SELECT COUNT(LENGTH) FROM film WHERE length > 180;
#10
SELECT CONCAT(first_name,' ',last_name,' ','-',' ',email) FROM customer;
#11
SELECT max(length(title)) FROM film;
##############################
###########Labs 03############
##############################
#1
SELECT count(DISTINCT(last_name)) FROM actor;
#2
SELECT count(DISTINCT(Llanguage_id)) FROM film;
#3
SELECT count(rating) FROM film WHERE rating = 'PG-13';
#4
SELECT title FROM film WHERE release_year = '2006' LIMIT 10;
#5
SET @last_date = (select payment_date FROM payment ORDER BY payment_date DESC LIMIT 1);
SET @first_date = (select payment_date FROM payment ORDER BY payment_date ASC LIMIT 1);
SELECT datediff(@last_date,@first_date);
#6
SELECT MONTH(rental_date), WEEKDAY(rental_date) FROM rental LIMIT 20;
#7
SELECT rental_date,
CASE
WHEN WEEKDAY(rental_date) = 5 OR 6 THEN 'weekend'
ELSE 'weekday'
END AS 'day_type'
FROM rental;
#8
SELECT count(rental_date) FROM rental WHERE YEAR(rental_date)=2006 AND MONTH(rental_date)=2;
##############################
###########Labs 04############
##############################
#1
SELECT rating FROM film;
#2
SELECT release_yearFROM film;
#3
SELECT * FROM film WHERE title REGEXP 'ARMAGEDDON';
#4
SELECT * FROM film WHERE title REGEXP 'APOLLO';
#5
SELECT * FROM film WHERE title REGEXP 'APOLLO$';
#6
SELECT * FROM film WHERE title REGEXP 'DATE';
#7
SELECT title FROM film ORDER BY length(title) DESC LIMIT 10;
#8
SELECT title FROM film ORDER BY LENGTH DESC LIMIT 10;
#9
SELECT title FROM film WHERE special_features REGEXP 'Behind the Scenes';
#10
SELECT title,release_year FROM film ORDER BY release_year ASC , title ASC;
##############################
###########Labs 05############
##############################
#1
ALTER TABLE STAFF
DROP COLUMN PICTURE;

#2
INSERT INTO staff
(staff_id , active , username , password , last_update , first_name , last_name , address_id , email , store_id) 
values( 3 , 1 , 'TAMMY','verygood_password123', '2006-02-15 03:57:16',
(SELECT first_name FROM customer WHERE first_name = 'TAMMY' AND last_name = 'SANDERS'),
(SELECT last_name FROM customer WHERE first_name = 'TAMMY' AND last_name = 'SANDERS'),
(SELECT address_id FROM customer WHERE first_name = 'TAMMY' AND last_name = 'SANDERS'),
(SELECT email FROM customer WHERE first_name = 'TAMMY' AND last_name = 'SANDERS'),
(SELECT store_id FROM customer WHERE first_name = 'TAMMY' AND last_name = 'SANDERS'));

SELECT * FROM STAFF;

#3
INSERT INTO rental(rental_date,inventory_id,customer_id,return_date,staff_id,last_update)
values(
now(),
(SELECT count(inventory_id) FROM inventory WHERE film_id = (SELECT film_id FROM sakila.film WHERE title = 'Academy Dinosaur')),
(SELECT customer_id FROM sakila.customer WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'),
(SELECT date_add(now(), INTERVAL 2 DAY)),
(SELECT staff_id FROM sakila.STAFF WHERE first_name = 'Mike' AND last_name = 'Hillyer'),
'2006-02-15 21:30:53'
);

SELECT * from rental order by rental_date desc;

#4
DROP TABLE IF EXISTS deleted_users;
CREATE TABLE deleted_users (
  `customer_id` int UNIQUE NOT NULL,
  `store_id` INT DEFAULT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name`  varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `adress_id` int DEFAULT NULL,
  `active` int DEFAULT NULL,
  `create_date` TIMESTAMP DEFAULT NULL,
  `last_update` TIMESTAMP DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (CUSTOMER_ID)
);
INSERT INTO deleted_users SELECT * FROM CUSTOMER;
SELECT * FROM deleted_users;
DELETE FROM deleted_users where active = 0;
SELECT count(active) FROM deleted_users WHERE active = 0;






