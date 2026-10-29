

CREATE TABLE zomato_data (
    restaurant_name VARCHAR(255),
    dining_rating NUMERIC(3,1),
    delivery_rating NUMERIC(3,1),
    dining_votes INTEGER,
    delivery_votes INTEGER,
    cuisine VARCHAR(255),
    place_name VARCHAR(255),
    city VARCHAR(100),
    item_name TEXT,
    best_seller VARCHAR(100),
    votes INTEGER,
    prices NUMERIC(10,2)
);
select * from zomato_data;
SELECT
    restaurant_name,
    item_name,
    city,
    COUNT(*) AS duplicate_count
FROM zomato_data
GROUP BY restaurant_name, item_name, city
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;
SELECT
    COUNT(*) FILTER (WHERE restaurant_name IS NULL) AS missing_restaurant,
    COUNT(*) FILTER (WHERE city IS NULL) AS missing_city,
    COUNT(*) FILTER (WHERE cuisine IS NULL) AS missing_cuisine,
    COUNT(*) FILTER (WHERE prices IS NULL) AS missing_prices,
    COUNT(*) FILTER (WHERE votes IS NULL) AS missing_votes
FROM zomato_data;
SELECT *
FROM zomato_data
WHERE prices <= 0;
##4: City-wise Restaurant Analysis
select city ,
count (Distinct restaurant_name) as total_restaurant
from zomato_data
group by city
order by total_restaurant Desc;
##Task: Write an SQL query to find restaurants with prices above ₹1,000.
SELECT COUNT(*)
FROM zomato_data
WHERE prices > 1000;
## find the avg price of food items

SELECT
    city,
    AVG(prices) AS avg_price
FROM zomato_data
GROUP BY city
ORDER BY avg_price DESC;

select * from zomato_data;
''' count restaurant by causine , find how many records belongs to eash cusine in the zomato dataset''':
select cuisine , count(*) as total_cuisine 
from zomato_data 
group by cuisine 
order by total_cuisine desc;

'''Question 9: Find the Highest-Rated Restaurants

Task: Find the top 10 restaurants with the highest dining ratings.

Requirements:

Display restaurant_name, city, and dining_rating.
Sort by dining_rating from highest to lowest.
Display only 10 records.'''
SELECT restaurant_name, city, dining_rating
FROM zomato_data
ORDER BY dining_rating DESC NULLS LAST
LIMIT 10;
'''Question 10: Find Restaurants with Low Dining Ratings

Task: Find all restaurants with a dining rating below 3.0.'''
select restaurant_name ,city , dining_rating
from zomato_data
where dining_rating < 3.0
order by dining_rating asc nulls last;
'''Question 11: Find the Most Popular Food Items

Task: Find the top 10 food items with the highest number of votes.

Requirements:

Display item_name, restaurant_name, and votes.
Sort by votes from highest to lowest.
Display only 10 records.
Exclude records where votes is NULL.'''
select item_name, restaurant_name, votes 
from zomato_data
where votes is not null
order by votes desc  limit 10;
'''Question 12: Find the Highest Price in Each City

Task: Find the maximum food-item price in each city.

Requirements:

Display city and the maximum price.
Group the results by city.
Sort the results by maximum price in descending order.

💡 Hint: Use MAX(), GROUP BY, and ORDER BY.'''

select city , max(prices) as maximum_price 
from zomato_data 
group by city 
order by maximum_price desc;
'''Question 13: Find the Average Dining Rating for Each City

Task: Calculate the average dining rating for each city.

Requirements:

Display city and the average dining rating.
Exclude records where dining_rating is NULL.
Sort the results by average rating in descending order.

💡 Hint: Use AVG(), WHERE, GROUP BY, and ORDER BY.'''
 
 select * from zomato_data;
select    city , avg(dining_rating) as average_dining_rating
from zomato_data 
where dining_rating is not null 
group by city
order by average_dining_rating desc;

'''Question 14: Find the Total Votes for Each City

Task: Calculate the total number of votes received by food items in each city.

Requirements:

Display city and the total votes.
Exclude records where votes is NULL.
Group the results by city.
Sort by total votes in descending order.'''
select city , sum(votes)as total_votes
from zomato_data
where votes is not null
group by city 
order by total_votes desc;

'''Question 15: Find Restaurants with Above-Average Dining Ratings

Task: Find restaurants whose dining rating is greater than the overall average dining rating.

Requirements:

Display restaurant_name, city, and dining_rating.
Show only restaurants with a rating above the overall average.
Sort by dining_rating in descending order.
Exclude NULL ratings.'''
```sql
SELECT restaurant_name, city, dining_rating
FROM zomato_data
WHERE dining_rating IS NOT NULL
  AND dining_rating > (
      SELECT AVG(dining_rating)
      FROM zomato_data
  )
ORDER BY dining_rating DESC;
```
''' Question 16: Find the Top 5 Most Popular Cuisines

Task: Find the top 5 cuisines with the highest total votes.

Requirements:

Display cuisine and total_votes.
Exclude records where votes is NULL.
Group records by cuisine.
Sort by total votes in descending order.
Display only 5 results.'''

select cuisine ,sum (votes) as total_votes
from zomato_data
where votes is not null
group by cuisine 
order by total_votes desc
limit 5;

'''Question 17: Find Restaurants with Above-Average Prices

Task: Find food items whose price is greater than the overall average price of all food items.

Requirements:

Display item_name, restaurant_name, and prices.
Exclude records where prices is NULL.
Show only food items priced above the overall average.
Sort by prices in descending order.
Display only the top 10 results.'''
select item_name,restaurant_name , prices from zomato_data 
where prices is not null
and prices > (select avg(prices) from zomato_data )
order by prices desc limit 10;
'''Question 18: Find the Restaurant with the Most Food Items

Task: Find the top 10 restaurants that have the highest number of food items listed in the dataset.

Requirements:

Display restaurant_name and total_items.
Count the number of food-item records for each restaurant.
Group the records by restaurant name.
Sort by total_items in descending order.
Display only the top 10 restaurants.'''

SELECT restaurant_name, COUNT(item_name) AS total_items
FROM zomato_data
GROUP BY restaurant_name
ORDER BY total_items DESC
LIMIT 10;
'''Question 19: Find the Most Popular Food Item in Each City

Task: Find the food item with the highest number of votes in each city.

Requirements:

Display city, item_name, restaurant_name, and votes.
Find the most-voted food item in each city.
Sort the results by votes in descending order.
Exclude records where votes is NULL.'''
```sql
WITH ranked_items AS (
    SELECT
        city,
        item_name,
        restaurant_name,
        votes,
        ROW_NUMBER() OVER (
            PARTITION BY city
            ORDER BY votes DESC
        ) AS rn
    FROM zomato_data
    WHERE votes IS NOT NULL
)
SELECT city, item_name, restaurant_name, votes
FROM ranked_items
WHERE rn = 1
ORDER BY votes DESC;
```




