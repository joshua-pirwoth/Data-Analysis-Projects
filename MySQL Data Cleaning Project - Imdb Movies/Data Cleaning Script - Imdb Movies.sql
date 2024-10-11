DROP TABLE IF EXISTS movies_for_mysql;
DROP TABLE IF EXISTS imdb_movies;

# STARTTTTTTTTT OVERRRRRRR


CREATE TABLE imdb_movies
LIKE movies_for_mysql;

SELECT * FROM imdb_movies;

INSERT imdb_movies
SELECT * FROM movies_for_mysql;


# TRIM MOVIE NAMES
SELECT MOVIES, TRIM(MOVIES)
FROM imdb_movies;

UPDATE imdb_movies
SET MOVIES = TRIM(MOVIES);


SELECT * FROM imdb_movies;

# CONVERTING RATING TO A FLOAT DATATYPE
SELECT *
FROM imdb_movies
WHERE RATING = '';

UPDATE imdb_movies
SET RATING = NULL
WHERE RATING = '';

ALTER TABLE imdb_movies
MODIFY COLUMN RATING FLOAT;


# CONVERTING VOTES TO A FLOAT DATATYPE
SELECT VOTES
FROM imdb_movies
WHERE VOTES = '';

UPDATE imdb_movies
SET VOTES = NULL
WHERE VOTES = '';

UPDATE imdb_movies
SET VOTES = TRIM(VOTES);

UPDATE imdb_movies
SET VOTES = REPLACE(VOTES, ',', '');

UPDATE imdb_movies
SET VOTES = NULL
WHERE VOTES NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

ALTER TABLE imdb_movies
MODIFY COLUMN VOTES INT;

SELECT *
FROM imdb_movies;


# TRANSFORM THE RUNTIME COLUMN
SELECT RunTime, TRIM(RunTime)
FROM imdb_movies;

UPDATE imdb_movies
SET RunTime = TRIM(RunTime);

UPDATE imdb_movies
SET RunTime = NULL
WHERE RunTime NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

SELECT RunTime, ROUND(RunTime, 0)
FROM imdb_movies;

UPDATE imdb_movies
SET RunTime = ROUND(RunTime, 0);

ALTER TABLE imdb_movies
MODIFY COLUMN RunTime INT;

SELECT *
FROM imdb_movies;


#GROSS
SELECT Gross, REPLACE(Gross, ',', '')
FROM imdb_movies;

UPDATE imdb_movies
SET Gross = REPLACE(Gross, ',', '');

UPDATE imdb_movies
SET Gross = TRIM(Gross);

UPDATE imdb_movies
SET Gross = NULL
WHERE Gross = '';

# Retrieves all records with a Gross that was mistakenly recorded as words
SELECT DISTINCT Gross
FROM imdb_movies
WHERE (Gross NOT LIKE '$%') AND (Gross NOT REGEXP '^[0-9]+(\.[0-9]+)?$');

# Replace the above records to null values
UPDATE imdb_movies
SET Gross = NULL
WHERE (Gross NOT LIKE '$%') AND (Gross NOT REGEXP '^[0-9]+(\.[0-9]+)?$');

# Retrieves all records with a Gross that was recorded as numbers without the currency notation
SELECT DISTINCT Gross
FROM imdb_movies
WHERE Gross REGEXP '^[0-9]+(\.[0-9]+)?$';

SELECT Gross
FROM imdb_movies
WHERE Gross IS NOT NULL
ORDER BY 1;


# RECONCILING THE ISSUE OF UNREALISTIC VALUES IN THE GROSS COLUMN
ALTER TABLE imdb_movies
ADD COLUMN movie_gross
TEXT;

SELECT *
FROM imdb_movies;


UPDATE imdb_movies
SET Gross = REPLACE(Gross, ',', '')
WHERE Gross REGEXP '^[0-9]+(\.[0-9]+)?$';

SELECT Gross
FROM imdb_movies
WHERE Gross REGEXP '^[0-9]+(\.[0-9]+)?$';

SELECT Gross, movie_gross
FROM imdb_movies
WHERE Gross REGEXP '^[0-9]+(\.[0-9]+)?$';

UPDATE imdb_movies
SET movie_gross = Gross
WHERE Gross REGEXP '^[0-9]+(\.[0-9]+)?$'; 

SELECT Gross, movie_gross
FROM imdb_movies
WHERE Gross IS NOT NULL;

ALTER TABLE imdb_movies
MODIFY COLUMN movie_gross INT;

SELECT movie_gross
FROM imdb_movies
WHERE movie_gross < 100000;

UPDATE imdb_movies
SET movie_gross = NULL
WHERE movie_gross < 100000;

UPDATE imdb_movies
SET Gross = NULL
WHERE Gross REGEXP '^[0-9]+(\.[0-9]+)?$';


UPDATE imdb_movies AS t2
JOIN movies_for_mysql AS t1
	ON t1.MOVIES = t2.MOVIES
SET t2.Gross = t1.Gross
WHERE t1.Gross LIKE '$%M';


SELECT Gross
FROM movies_for_mysql
WHERE Gross != '';

ALTER TABLE imdb_movies
MODIFY COLUMN Gross FLOAT;

UPDATE movies_for_mysql
SET Gross = TRIM(Gross);

SELECT Gross
FROM imdb_movies
WHERE Gross IS NOT NULL;

SELECT Gross, TRIM(TRAILING 'M' FROM Gross)
FROM imdb_movies
WHERE Gross IS NOT NULL;

UPDATE imdb_movies
SET Gross = TRIM(TRAILING 'M' FROM Gross)
WHERE Gross IS NOT NULL;

SELECT Gross, TRIM(LEADING '$' FROM Gross)
FROM imdb_movies
WHERE Gross IS NOT NULL;

UPDATE imdb_movies
SET Gross = TRIM(LEADING '$' FROM Gross)
WHERE Gross IS NOT NULL;

ALTER TABLE imdb_movies
MODIFY COLUMN Gross FLOAT;

SELECT Gross, (Gross * 1000000)
FROM imdb_movies
WHERE Gross IS NOT NULL;

UPDATE imdb_movies
SET Gross = (Gross * 1000000);

SELECT Gross
FROM imdb_movies
WHERE Gross IS NOT NULL;

ALTER TABLE imdb_movies
MODIFY COLUMN Gross INT;


SELECT *
FROM imdb_movies;

ALTER TABLE imdb_movies
DROP COLUMN `ONE-LINE`;

ALTER TABLE imdb_movies
DROP COLUMN STARS;

SELECT *
FROM imdb_movies
WHERE Gross < 100000;

# NULLIFY UNREALISTICALLY LOW GROSS VALUES
UPDATE imdb_movies
SET Gross = NULL
WHERE Gross < 100000;


SELECT Gross
FROM movies_for_mysql
WHERE Gross REGEXP '^[0-9]+(\.[0-9]+)?$';

ALTER TABLE imdb_movies
MODIFY COLUMN Gross TEXT;
 

UPDATE imdb_movies AS t2
JOIN movies_for_mysql AS t1
	ON t1.MOVIES = t2.MOVIES
SET t2.Gross = t1.Gross
WHERE t1.Gross REGEXP '^[0-9]+(\.[0-9]+)?$';

SELECT Gross
FROM imdb_movies
WHERE Gross IS NOT NULL;






















