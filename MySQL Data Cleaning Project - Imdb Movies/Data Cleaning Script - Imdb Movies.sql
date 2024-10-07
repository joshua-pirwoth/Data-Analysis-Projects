DROP TABLE IF EXISTS imdb_movies;

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


SELECT RunTime, TRIM(RunTime)
FROM imdb_movies;

UPDATE imdb_movies
SET RunTime = TRIM(RunTime);

UPDATE imdb_movies
SET RunTime = NULL
WHERE RunTime NOT REGEXP '^[0-9]+(\.[0-9]+)?$';








