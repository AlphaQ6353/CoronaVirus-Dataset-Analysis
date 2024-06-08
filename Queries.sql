use intern;

-- Q1. Check NULL values
SELECT 
    COUNT(*) AS null_count
FROM 
    covid
WHERE 
    Province IS NULL 
    OR `Country/Region` IS NULL 
    OR Latitude IS NULL 
    OR Longitude IS NULL 
    OR Date IS NULL 
    OR Confirmed IS NULL 
    OR Deaths IS NULL 
    OR Recovered IS NULL;

-- Q2. If NULL values are present, update them with zeros for all columns.
SET SQL_SAFE_UPDATES = 0;
UPDATE 
    covid
SET 
    Province = IFNULL(Province, 0),
    `Country/Region` = IFNULL(`Country/Region`, 0),
    Latitude = IFNULL(Latitude, 0),
    Longitude = IFNULL(Longitude, 0),
    Date = IFNULL(Date, 0),
    Confirmed = IFNULL(Confirmed, 0),
    Deaths = IFNULL(Deaths, 0),
    Recovered = IFNULL(Recovered, 0);

SET SQL_SAFE_UPDATES = 1;

-- Q3. Check total number of rows
SELECT 
    COUNT(*) AS total_rows
FROM 
    covid;

-- Q4. Check start_date and end_date
SELECT 
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM 
    covid;

-- Q5. Number of months present in dataset
SELECT 
    COUNT(DISTINCT LEFT(Date, 7)) AS num_months
FROM 
    covid;

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
    LEFT(Date, 7) AS month,
    AVG(Confirmed) AS avg_confirmed,
    AVG(Deaths) AS avg_deaths,
    AVG(Recovered) AS avg_recovered
FROM 
    covid
GROUP BY 
    LEFT(Date, 7);

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
WITH FrequentData AS (
  SELECT
    CASE WHEN EXTRACT(MONTH FROM date) = 1 THEN 'January'
         WHEN EXTRACT(MONTH FROM date) = 2 THEN 'February'
         WHEN EXTRACT(MONTH FROM date_data) = 3 THEN 'March'
		 WHEN EXTRACT(MONTH FROM date_data) = 4 THEN 'April'
		 WHEN EXTRACT(MONTH FROM date_data) = 5 THEN 'May'
		 WHEN EXTRACT(MONTH FROM date_data) = 6 THEN 'June'
		 WHEN EXTRACT(MONTH FROM date_data) = 7 THEN 'July'
		 WHEN EXTRACT(MONTH FROM date_data) = 8 THEN 'August'
		 WHEN EXTRACT(MONTH FROM date_data) = 9 THEN 'September'
		 WHEN EXTRACT(MONTH FROM date_data) = 10 THEN 'October'
		 WHEN EXTRACT(MONTH FROM date_data) = 11 THEN 'November'
		 WHEN EXTRACT(MONTH FROM date_data) = 12 THEN 'December'
    END AS month,
    EXTRACT(YEAR FROM date) AS year,
    confirmed,
    deaths,
    recovered
  FROM covid
)
SELECT
  month,
  year,
  MAX(CASE WHEN confirmed = f.val THEN 1 ELSE 0 END) AS most_frequent_confirmed,
  MAX(CASE WHEN deaths = f.val THEN 1 ELSE 0 END) AS most_frequent_deaths,
  MAX(CASE WHEN recovered = f.val THEN 1 ELSE 0 END) AS most_frequent_recovered
FROM FrequentData f
GROUP BY month, year
ORDER BY year, month;

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    LEFT(Date, 4) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM 
    covid
GROUP BY 
    LEFT(Date, 4);

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    LEFT(Date, 4) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM 
    covid
GROUP BY 
    LEFT(Date, 4);

-- Q10. The total number of cases of confirmed, deaths, recovered each month
SELECT 
    LEFT(Date, 7) AS month,
    SUM(Confirmed) AS total_confirmed,
    SUM(Deaths) AS total_deaths,
    SUM(Recovered) AS total_recovered
FROM 
    covid
GROUP BY 
    LEFT(Date, 7);

-- Q11. Check how coronavirus spread out with respect to confirmed case
SELECT 
    COUNT(*) AS total_cases,
    AVG(Confirmed) AS average_confirmed,
    VARIANCE(Confirmed) AS variance_confirmed,
    STDDEV(Confirmed) AS stdev_confirmed
FROM 
    covid;

-- Q12. Check how coronavirus spread out with respect to death case per month
SELECT 
    LEFT(Date, 7) AS month,
    COUNT(*) AS total_deaths,
    AVG(Deaths) AS average_deaths,
    VARIANCE(Deaths) AS variance_deaths,
    STDDEV(Deaths) AS stdev_deaths
FROM 
    covid
GROUP BY 
    LEFT(Date, 7);

-- Q13. Check how coronavirus spread out with respect to recovered case
SELECT 
    COUNT(*) AS total_recovered,
    AVG(Recovered) AS average_recovered,
    VARIANCE(Recovered) AS variance_recovered,
    STDDEV(Recovered) AS stdev_recovered
FROM 
    covid;

-- Q14. Find Country having the highest number of Confirmed cases
SELECT 
    `Country/Region`,
    MAX(Confirmed) AS max_confirmed
FROM 
    covid
GROUP BY 
    `Country/Region`
ORDER BY 
    max_confirmed DESC
LIMIT 1;

-- Q15. Find Country having the lowest number of Death cases
SELECT 
    `Country/Region`,
    MIN(Deaths) AS min_deaths
FROM 
    covid
GROUP BY 
    `Country/Region`
ORDER BY 
    min_deaths ASC
LIMIT 1;

-- Q16. Find top 5 countries having the highest number of Recovered cases
SELECT 
    `Country/Region`,
    MAX(Recovered) AS max_recovered
FROM 
    covid
GROUP BY 
    `Country/Region`
ORDER BY 
    max_recovered DESC
LIMIT 5;
