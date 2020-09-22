CREATE TABLE IF NOT EXISTS "users"(
    "id" serial PRIMARY KEY,
    "firstName" varchar(64) NOT NULL,
    "lastName" varchar(64) NOT NULL,
    "email" varchar(64) NOT NULL UNIQUE,
    "isMale" boolean,
    "birthday" date NOT NULL CHECK ("birthday" < current_date),
    "createAt" timestamp DEFAULT current_timestamp
);

/*
1. select all women
2. select all adult men;
3. select all users. filter: age between 40 and 100
4. select all users. filter: birthday in July
5. select all women. filter: birthday in 14 February
*/
--1
SELECT * FROM users 
WHERE  "isMale" = false;

--2
SELECT * FROM users 
WHERE "isMale" = true AND age("birthday") >= make_interval(18);

--3
SELECT * FROM users 
WHERE 
    age("birthday") 
        BETWEEN make_interval(40) AND make_interval(100);

--4
SELECT * FROM users 
WHERE extract('month' FROM "birthday") = 7;


--5
SELECT * FROM users 
WHERE 
"isMale" = false 
AND 
EXTRACT('day' FROM "birthday") = 25 
AND 
EXTRACT('month' FROM "birthday") = 10 ;

/*
PAGINATION
*/
SELECT * FROM users 
WHERE "isMale" = false
LIMIT 20 
OFFSET 40; -- page 1


/*
ALIASES
*/
SELECT 
    concat("firstName",' ',"lastName") AS "Full name",    
    "birthday",
    EXTRACT('year' FROM age("birthday")) AS "TEST",
    "email" "e-mail address"
FROM "users" AS u
WHERE char_length( concat("firstName",' ',"lastName")) > 18
;