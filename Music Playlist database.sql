Project - Music Store Data Analysis

Q1 - Who is the senior most employee based on job title?

Select * from Employee 
Order by levels desc
LIMIt 1

Q2 - How many customers are form each country?

SELECT COUNT(*) as customer_count, country
FROM customer
GROUP BY country 

Q3 - Which are the top 5 cities having the most number of Invoices?

Select COUNT(*) as invoices_count ,billing_city 
from invoice
group by billing_city
Order by invoices_count desc
LIMIT 5

Q4 - Which country has the most number of customers?

Select COUNT(*) as customer_count , country 
from customer
group by country
Order by customer_count desc
LIMIT 1

Q5 - What are the least 5 values of invoices?

Select distinct total from invoice
Order by total
limit 5

Q6- Which city has the best customers? We would like to launch a music festival in that city where we made the most money

Select SUM(total) as invoice_total, billing_city from invoice
group by billing_city 
order by invoice_total desc
limit 1

Q7- Which customer spent the most money so that we can give more discount to him/her?

Select customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) as total
from customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP by customer.customer_id
Order by total desc
limit 1

Q8 - Write a query to return the mail,first name, last name, & Genre of all Jazz music listner. Return your list alphabetically by email starting with B.

Select distinct email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.invoice_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
SELECT track_id FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Jazz'
)
ORDER by email;

Q9 - Lets invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count on the top 
10 rock bands

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.artist_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10

Q10 - Return all the track names that have a song long length less than the average song length. 
Return the name and milliseconds for each track and order by the song length with the longest songs listed first 

SELECT name, milliseconds 
FROM track
WHERE milliseconds < (
             SELECT AVG(milliseconds) AS avg_track_length
			 FROM track)
ORDER BY milliseconds DESC