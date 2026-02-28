-- mainframe_override=# \d emptystack_accounts;
--          Table "public.emptystack_accounts"
--    Column   | Type | Collation | Nullable | Default 
-- ------------+------+-----------+----------+---------
--  username   | text |           | not null | 
--  password   | text |           | not null | 
--  first_name | text |           | not null | 
--  last_name  | text |           | not null | 
-- Indexes:
--     "emptystack_accounts_pkey" PRIMARY KEY, btree (username)
--     "emptystack_accounts_username_key" UNIQUE, btree (username)

--           Table "public.forum_accounts"
--    Column   | Type | Collation | Nullable | Default 
-- ------------+------+-----------+----------+---------
--  username   | text |           | not null | 
--  first_name | text |           | not null | 
--  last_name  | text |           | not null | 
-- Indexes:
--     "forum_accounts_pkey" PRIMARY KEY, btree (username)
--     "forum_accounts_username_key" UNIQUE, btree (username)

-- Table "public.forum_posts"
--  Column  |              Type              | Collation | Nullable | Default 
-- ---------+--------------------------------+-----------+----------+---------
--  id      | text                           |           | not null | 
--  title   | text                           |           | not null | 
--  content | text                           |           | not null | 
--  date    | timestamp(3) without time zone |           | not null | 
--  author  | text                           |           | not null | 
-- Indexes:
--     "forum_posts_pkey" PRIMARY KEY, btree (id)

-- Get the username of the person who made the post about EmptyStack in forum_posts.
-- Get the last name of the person associated with that username in forum_accounts.
select 
a.username, 
a.last_name 
from forum_posts p 
join forum_accounts a ON p.author = a.username
where lower(p.content) like '%emptystack%'

    username    | last_name 
----------------+-----------
 smart-money-44 | Steele
(1 row)

-- Find all other accounts with the same last name.
select * from forum_accounts where last_name = 'Steele' ;

    username     | first_name | last_name 
-----------------+------------+-----------
 sharp-engine-57 | Andrew     | Steele
 stinky-tofu-98  | Kevin      | Steele
 smart-money-44  | Brad       | Steele
(3 rows)

-- Find all accounts in emptystack_accounts with the same last name.
-- There will only be one EmptyStack employee with a forum account. Use their credentials to access node mainframe, which will output a new sql file for you to run.

select * from emptystack_accounts where last_name = 'Steele' ;

Results: 
    username    |  password   | first_name | last_name 
----------------+-------------+------------+-----------
 triple-cart-38 | password456 | Andrew     | Steele -- this one worked
 lance-main-11  | password789 | Lance      | Steele
(2 rows)

psql -f emptystack.sql
-- Find the message in emptystack_messages that mentions a project involving self-driving taxis. That message is sent from an admin account and also reveals the project code.

mainframe_override=# select * from emptystack_messages where lower(body) like '%taxi%';
  id   |     from     |       to       |   subject    |                            body
-------+--------------+----------------+--------------+------------------------------------------------------------
 LidWj | your-boss-99 | triple-cart-38 | Project TAXI | Deploy Project TAXI by end of week. We need this out ASAP.
(1 row)

Project TAXI

-- Get the credentials for the admin account from emptystack_accounts.

select * from emptystack_accounts where username = 'your-boss-99'

   username   |    password    | first_name | last_name
--------------+----------------+------------+-----------
 your-boss-99 | notagaincarter | Skylar     | Singer
(1 row)


-- Get the ID of the project from emptystack_projects.

mainframe_override=# select * from emptystack_projects where lower(code) = 'taxi';
    id    | code
----------+------
 DczE0v2b | TAXI
(1 row)

-- Use that information to stop the project: node mainframe -stop!
