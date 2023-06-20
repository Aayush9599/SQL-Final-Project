create table businesses(
business_id varchar(22) PRIMARY KEY,
business_name VARCHAR(100),
street_address VARCHAR(1000),
city varchar(100),
state VARCHAR(3),
postal_code varchar(9),
latitude float,
longitude FLOAT,
avg_reviews float,
number_of_reviews int,
business_open_or_close boolean);




create table business_attributes(
business_id varchar(22) REFERENCES businesses(business_id),
attribute_name varchar(50),
attribute_value VARCHAR(50));
	


CREATE table business_categories(
business_id varchar(22) REFERENCES businesses(business_id),
category_name VARCHAR(50));



create table business_hours(
business_id varchar(22) REFERENCES businesses(business_id),
day_of_week VARCHAR(22),
opening_time TIME,
closing_time TIME);

	

CREATE table user_elite_years(
user_id varchar(22) REFERENCES users(user_id) ,
year SMALLINT);



create TABLE reviews(
review_id varchar(22) PRIMARY KEY,
user_id varchar(22),
business_id varchar(22) REFERENCES businesses(business_id) ,
user_rating DECIMAL,
number_of_users_marking_review_useful smallint,
number_of_users_marking_review_funny smallint,
number_of_users_marking_review_cool smallint,
the_reveiw_text text,
review_date_or_time TIMESTAMP);


CREATE table tips(
user_id varchar(22) REFERENCES users(user_id),
business_id varchar(22)REFERENCES businesses(business_id) ,
text TEXT,
date_or_time_the_tip_was_left timestamp,
number_of_compliments_tip_recieved SMALLINT);


CREATE table users(
user_id varchar(22) PRIMARY key,
Name text,
number_of_reviews_user_left SMALLINT,
date_or_time_user_joined_yelp TIMESTAMP,
number_of_useful_votes_sent_by_user INT,
number_of_funny_votes_sent_by_user INT,
number_of_cool_votes_sent_by_user INT,
number_of_fans int,
average_rating_of_all_users_review DECIMAL,
number_of_hot_compliments_recieved_by_user INT,
number_of_more_compliments_recieved_by_user INT,	
number_of_profile_compliments_recieved_by_user INT,
number_of_cute_compliments_recieved_by_user INT,
number_of_list_compliments_recieved_by_user INT,
number_of_note_compliments_recieved_by_user INT,
number_of_plain_compliments_recieved_by_user INT,
number_of_cool_compliments_recieved_by_user INT,
number_of_funny_compliments_recieved_by_user INT,
number_of_writer_compliments_recieved_by_user INT,
number_of_photo_compliments_recieved_by_user INT
);


create table userfriends(
user_id varchar(22) REFERENCES users(user_id),
friend_id VARCHAR(22));






