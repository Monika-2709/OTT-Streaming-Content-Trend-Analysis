-- OTT Streaming Content Trend Analysis
-- Run after importing data/ott_catalog_cleaned.csv into a table named ott_catalog.
-- SQL is written in broadly portable SQL; date parsing may vary by database.

-- 1. Catalog size and type mix
SELECT type, COUNT(*) AS title_count,
       ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM ott_catalog), 2) AS share_pct
FROM ott_catalog
GROUP BY type
ORDER BY title_count DESC;

-- 2. Genre popularity
SELECT genre, COUNT(*) AS title_count
FROM ott_catalog
GROUP BY genre
ORDER BY title_count DESC;

-- 3. Release-year trend
SELECT release_year, COUNT(*) AS title_count
FROM ott_catalog
GROUP BY release_year
ORDER BY release_year;

-- 4. Top countries represented (excluding Unknown)
SELECT country, COUNT(*) AS title_count
FROM ott_catalog
WHERE country <> 'Unknown'
GROUP BY country
ORDER BY title_count DESC
FETCH FIRST 10 ROWS ONLY;

-- 5. Content rating distribution
SELECT rating, COUNT(*) AS title_count
FROM ott_catalog
GROUP BY rating
ORDER BY title_count DESC;

-- 6. Movie runtime summary (assuming duration_value is numeric and duration_unit is Minutes)
SELECT MIN(duration_value) AS min_minutes,
       ROUND(AVG(duration_value), 1) AS avg_minutes,
       MEDIAN(duration_value) AS median_minutes,
       MAX(duration_value) AS max_minutes
FROM ott_catalog
WHERE type = 'Movie' AND duration_unit = 'Minutes';

-- 7. Genre by type
SELECT genre, type, COUNT(*) AS title_count
FROM ott_catalog
GROUP BY genre, type
ORDER BY genre, type;

-- 8. Recent additions by year (database-specific date extraction)
-- PostgreSQL syntax:
SELECT EXTRACT(YEAR FROM date_added) AS added_year, COUNT(*) AS titles_added
FROM ott_catalog
WHERE date_added IS NOT NULL
GROUP BY EXTRACT(YEAR FROM date_added)
ORDER BY added_year;
