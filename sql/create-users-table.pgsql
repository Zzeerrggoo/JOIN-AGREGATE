CREATE TABLE IF NOT EXISTS "users"(
    "id" serial PRIMARY KEY,
    "firstName" varchar(64) NOT NULL,
    "lastName" varchar(64) NOT NULL,
    "email" varchar(64) NOT NULL UNIQUE,
    "isMale" boolean,
    "birthday" date NOT NULL CHECK ("birthday" < current_date),
    "createAt" timestamp DEFAULT current_timestamp
);