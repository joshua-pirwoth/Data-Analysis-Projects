SHOW TABLES;

# DUPLICATE THE ORIGINAL DATASET
CREATE TABLE cause_of_death
LIKE death_causes;

# COPY DATA OF THE ORIGINAL TABLE INTO THE NEW TABLE
INSERT INTO cause_of_death
SELECT * FROM death_causes;

SELECT * FROM cause_of_death;

ALTER TABLE cause_of_death
RENAME COLUMN `Death ID` TO Death_ID;


-- 1. REMOVE DUPLICATES!!!

# SEARCH FOR ROWS WITHOUT IDs
SELECT *
FROM cause_of_death
WHERE Death_ID = "";

SELECT *
FROM cause_of_death
WHERE Death_ID IS NULL;

# SEARCH FOR DUPLICATE ROWS
WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY Death_ID, City, Incident_Type, Fatalities, Injuries, Category, Cause_of_dead
    ) AS row_num
FROM cause_of_death
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1
;

# NO DUPLICATE ROWS FOUND!


-- 2. STANDARDIZE THE DATA!!!

SELECT DISTINCT City
FROM cause_of_death;


UPDATE cause_of_death
SET City = "Gaza City"
WHERE City = "Gaza city";

UPDATE cause_of_death
SET City = "Middle Area"
WHERE City = "middle Area";

SELECT *
FROM cause_of_death
WHERE City = "";

# REPLACE EMPTY CITY WITH "Unknown"
UPDATE cause_of_death
SET City = "Unknown"
WHERE City = "";

SELECT * FROM cause_of_death;

SELECT DISTINCT Category
FROM cause_of_death;

UPDATE cause_of_death
SET Category = "Lack of Medical Access"
WHERE Category LIKE 'Lack%';

ALTER TABLE cause_of_death
RENAME COLUMN Cause_of_dead
TO Cause_of_Death;

SELECT DISTINCT Death_ID
FROM cause_of_death;


# GROUP RECORDS BY Death_ID
SELECT Death_ID, COUNT(*) AS COUNT
FROM cause_of_death
GROUP BY Death_ID
HAVING COUNT(*) > 1;


-- 3. ANALYZE THE DATA!!!

SELECT * FROM cause_of_death;

-- 3a. General Overview
# Total number of Incidents, Fatalities, and Injuries

SELECT COUNT(*) AS Total_Incidents,
SUM(Fatalities) AS Total_Fatalities,
SUM(Injuries) AS Total_Injuries
FROM cause_of_death;

-- 3b. INCIDENT ANALYSIS
# Most frequent incident types (Top 3)
SELECT DISTINCT Incident_Type
FROM cause_of_death;

SELECT Incident_Type, COUNT(*) AS COUNT
FROM cause_of_death
GROUP BY Incident_Type
ORDER BY COUNT DESC
LIMIT 3;

# comparison of fatality and injury rates by incident type (By sum and average)
SELECT Incident_Type,
SUM(Fatalities) AS Total_Fatalities,
SUM(Injuries) AS Total_Injuries
FROM cause_of_death
GROUP BY Incident_Type
ORDER BY 1;

# Average number of Fatalities, and Injuries per Incident type
SELECT Incident_Type,
ROUND(AVG(Fatalities), 0) AS Avg_Fatalities,
ROUND(AVG(Injuries), 0) AS Avg_Injuries
FROM cause_of_death
GROUP BY Incident_Type
ORDER BY 1;

-- 3c. CITY-LEVEL INSIGHTS
# Cities with the highest number of incidents (Top 5)
SELECT City, COUNT(*) AS COUNT
FROM cause_of_death
GROUP BY City
ORDER BY 2 DESC
LIMIT 5;

# Fatality and Injury distribution across cities
SELECT City,
SUM(Fatalities) AS Total_Fatalities,
SUM(Injuries) AS Total_Injuries
FROM cause_of_death
GROUP BY City
ORDER BY 1;

-- 3d. CAUSE OF DEATH ANALYSIS
# Most common causes of death (Top 3)
SELECT Cause_of_Death, COUNT(*) AS COUNT
FROM cause_of_death
GROUP BY Cause_of_Death
ORDER BY COUNT DESC
LIMIT 3;

# How cause of death varies by incident type
SELECT Incident_Type, Cause_of_Death, COUNT(*) AS occurence_count
FROM cause_of_death
GROUP BY Incident_Type, Cause_of_Death
ORDER BY Incident_Type, occurence_count DESC;

SELECT * FROM cause_of_death;