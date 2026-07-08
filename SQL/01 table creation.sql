-- user table --

CREATE TABLE users
(
user_id int PRIMARY KEY IDENTITY (1,1) ,
user_name varchar(50),
email varchar(50),
city varchar(50),
create_date varchar(50)
)

-- inserting data in user table--

INSERT INTO users(user_name,email,city,create_date)
SELECT user_name,email,city,create_date FROM users_data_import


-- post table --

CREATE TABLE post 
(
post_id int PRIMARY KEY,
user_id int NOT NULL,
post_text varchar(300),
post_date varchar(50),
FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE
)

-- insert data into post table--

INSERT INTO post(post_id,user_id,post_text,post_date)
SELECT post_id,user_id,post_text,post_date FROM post_data_import


-- sentiment_keywords--

CREATE TABLE sentiment_keyword 
(
keyword_id int PRIMARY KEY,
keyword varchar(50),
sentiment_type varchar(50)
)
