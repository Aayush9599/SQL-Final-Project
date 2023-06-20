--Q1 How many users have joined Yelp each year since 2010?
select count(u.user_id) as number_of_users, uey.year from users as u
join user_elite_years as uey
on uey.user_id = u.user_id
where date_or_time_user_joined_yelp >= '2010-01-01'
group by year;

--Q2 How many users were elite in each of the 10 years from 2012 through 2021? Does it look like the number of elite users is increasing, decreasing, or staying about the same?
select count(user_id) as number_of_elite_users,year from user_elite_years
where year between 2012 and 2021 GROUP by year;

--Q3 Which of our users has the most 5-star reviews of all time? Give us the person’s name, 
--when they joined Yelp, how many fans they have, how many funny, useful, and 
--cool ratings they’ve gotten. Please also gives us 3-5 examples of recent 5-star reviews 
--they have written.

select u.name,count(r.user_id),r.user_rating,
u.date_or_time_user_joined_yelp,
sum(u.number_of_fans) as number_of_fans,
sum(r.number_of_users_marking_review_funny) as number_of_funny_ratings_recieved_by_user,
sum(r.number_of_users_marking_review_useful) as number_of_useful_ratings_recieved_by_user, 
sum(r.number_of_users_marking_review_cool) as number_of_cool_ratings_recieved_by_user
from reviews r
join users u
on r.user_id = u.user_id
where r.user_rating = '5.0'
group by r.user_rating,r.user_id,u.name,u.date_or_time_user_joined_yelp
order by count(r.user_id) DESC
limit 1;



SELECT u.name,r.the_review_text,r.review_date_or_time from reviews r
join users u
on r.user_id = u.user_id
WHERE u.name in ('Michelle') and r.user_rating='5.0'
group by u.name,r.the_review_text,r.review_date_or_time
order by r.review_date_or_time DESC
limit 5;





--Q4 We’d like to talk with users who have lots of friends on Yelp to better understand 
--how they use the social features of our site. Can you give us user id and name of the 10 users
--with the most friends?
SELECT uf.user_id,  u.name ,count(uf.friend_id) as number_of_friends from userfriends uf
join users u 
on u.user_id = uf.user_id
GROUP by uf.user_id, u.name
order by count(uf.friend_id) DESC
limit 10;

--Q5 Which US states have the most businesses in our database? Give us the top 10 states.
select b.state,count(b.business_id) as number_of_businesses FROM businesses b
group by b.state
order by count(b.business_id) DESC
limit 10;

--Q6 What are our top ten business categories? In other words, which 10 categories have the most businesses assigned to them?
SELECT bc.category_name,count(bc.business_id) from business_categories bc
group by bc.category_name
order by count(bc.business_id) desc
limit 10;

--Q7 What is the average rating of the businesses in each of those top ten categories?
SELECT bc.category_name,avg(r.user_rating) as average_rating from business_categories bc
join reviews r
on bc.business_id = r.business_id
group by bc.category_name
order by count(bc.business_id) desc
limit 10;

--Q8 We’re wondering what makes users tag a Restaurant review as “funny”. Can you give us 5 examples
--of the funniest Restaurant reviews and 5 examples of the 10 least funny? We’d also like you to 
--look at a larger set of funny and unfunny reviews and tell us if you see any patterns that separate
--the two. (We know the last part is qualitative, but tell us anything you see that may be useful.)

--Funniest reviews
SELECT r.the_review_text from business_categories bc
join reviews r
on r.business_id = bc.business_id
where bc.category_name = 'Restaurants'
group by r.the_review_text
order by count(r.number_of_users_marking_review_funny) DESC
limit 5

--least funniest reviews
SELECT r.the_review_text from business_categories bc
join reviews r
on r.business_id = bc.business_id
where bc.category_name = 'Restaurants'
group by r.the_review_text
order by count(r.number_of_users_marking_review_funny) ASC
limit 5






--Q9 We think the compliments that tips receive are mostly based on how long the tip is.
--Can you compare the average length of the tip text for the 100 most-complimented tips
--with the average length of the 100 least-complimented tips and tell us if that seems to be true? 
--(Hint: you will need to use computed properties to answer this question).

select avg(length(t.text)) 
from tips t
where length(t.text) in(
	select length(t.text)
	from tips t
    group by t.text
    ORDER by count(t.number_of_compliments_tip_recieved) DESC
    limit 100)
union	
select avg(length(t.text)) 
from tips t
where length(t.text) in(
	select length(t.text)
	from tips t
    group by t.text
    ORDER by count(t.number_of_compliments_tip_recieved) ASC
    limit 100);	

--Q10 We are trying to figure out whether restaurant reviews are driven mostly by
--how many hours the restaurant is open, or the days they are open. 
--Can you please give us a spreadsheet with the data we need to answer that question? 
--(Note from Professor Augustyn: You don’t actually have to hand in a spreadsheet…just give me
--a table with 10 rows of sample data returned by your query.)

select bc.category_name, r.the_review_text,count(r.the_review_text),bh.day_of_week, bh.opening_time, bh.closing_time
from business_hours bh
join business_categories bc
on bh.business_id = bc.business_id
join reviews r
on bh.business_id = r.business_id
where bc.category_name = 'Restaurants'
group by bc.category_name, r.the_review_text,bh.day_of_week, bh.opening_time, bh.closing_time
order by count(r.the_review_text) desc
limit 10;


-- extra credit questions
--Q11. Select business categories with working hours less than equal to 10.
select bc.category_name, bh.closing_time -bh.opening_time as working_hours from business_hours bh
join business_categories bc
on bc.business_id = bh.business_id
where bh.closing_time -bh.opening_time <= '10:00:00';

--Q12. select top 10 business categories where the business accepts creditcard.
select bc.category_name,count(bc.category_name) from business_attributes ba
join business_categories bc
on bc.business_id = ba.business_id
WHERE ba.attribute_name = 'businessacceptscreditcards'
group by bc.category_name
order by count(bc.category_name) desc
limit 10

--Q13.What is the average length of the 100 most useful reviews.
select avg(length(r.the_review_text)) 
from reviews r
where length(r.the_review_text) in(
	select length(r.the_review_text)
	from reviews r
    group by r.the_review_text
    ORDER by count(r.number_of_users_marking_review_useful) DESC
    limit 100)
	
--Q14. Which of our users have 4 star ratings greater than 50. Give their names, date when they joined Yelp,
-- their total no. of fans, their total no. of funny ratings,useful ratings and cool ratings 
-- recieved by them.
select u.name,count(r.user_id),r.user_rating,
u.date_or_time_user_joined_yelp,
sum(u.number_of_fans) as number_of_fans,
sum(r.number_of_users_marking_review_funny) as number_of_funny_ratings_recieved_by_user,
sum(r.number_of_users_marking_review_useful) as number_of_useful_ratings_recieved_by_user, 
sum(r.number_of_users_marking_review_cool) as number_of_cool_ratings_recieved_by_user
from reviews r
join users u
on r.user_id = u.user_id
where r.user_rating = '4.0' 
group by r.user_rating,r.user_id,u.name,u.date_or_time_user_joined_yelp
HAVING count(r.user_id) > 50
order by count(r.user_id) DESC


--Q15.Give us the users along with their reviews who have got the highest number of cool reviews  and having a length of 1000.
select u.name,r.the_review_text,length(r.the_review_text) 
from reviews r
join users u 
on u.user_id = r.user_id
where length(r.the_review_text) in
(
	select length(r.the_review_text)
	from reviews r
    group by r.the_review_text
    ORDER by count(r.number_of_users_marking_review_cool) DESC
    )
group by u.name,r.the_review_text
having length(r.the_review_text) = 1000


-- Q16.Give us the list of restaurants name which are in the state of Arizona.
SELECT b.business_name, b.state from businesses b
join business_categories bc
on bc.business_id = b.business_id
where bc.category_name = 'Restaurants' and b.state= 'AZ'