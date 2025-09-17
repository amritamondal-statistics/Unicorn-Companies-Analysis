#This SQL script splits comma-separated investors, normalizes common investor names, 
#and summarizes distinct unicorn company counts by investor and industry.

CREATE TABLE investor_industry_company_summary AS
WITH investor_clean AS (
  SELECT
    company,
    industry,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(investor, ',', n.n), ',', -1)) AS investor
  FROM unicorn_companies,
  (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10) n
  WHERE investor IS NOT NULL
    AND n.n <= 1 + LENGTH(investor) - LENGTH(REPLACE(investor, ',', ''))
),
cleaned_investor_lower AS (
  SELECT
    industry,
    company,
    CASE
      WHEN LOWER(TRIM(investor)) LIKE 'sequoia capital%' THEN 'sequoia capital'
      WHEN LOWER(TRIM(investor)) LIKE 'softbank%' THEN 'softbank'
      WHEN LOWER(TRIM(investor)) LIKE 'accel%' THEN 'accel'
      WHEN LOWER(TRIM(investor)) LIKE 'matrix%' THEN 'matrix partners'
      WHEN LOWER(TRIM(investor)) LIKE 'khosla%' THEN 'khosla ventures'
      WHEN LOWER(TRIM(investor)) LIKE 'capitalg%' OR LOWER(TRIM(investor)) LIKE 'google%' THEN 'capitalg'
      WHEN LOWER(TRIM(investor)) LIKE 'sig%' THEN 'sig'
      WHEN LOWER(TRIM(investor)) LIKE 'blackbird%' THEN 'blackbird ventures'
      WHEN LOWER(TRIM(investor)) LIKE 'general atlantic%' THEN 'general atlantic'
      ELSE LOWER(TRIM(investor))
    END AS investor
  FROM investor_clean
  WHERE investor <> ''
)
SELECT
  industry,
  investor,
  COUNT(DISTINCT company) AS Unicorn_Count
FROM cleaned_investor_lower
GROUP BY investor, industry
ORDER BY investor ASC, Unicorn_count DESC;


#We have to formate all dates in same format

-- Step 1: Add a new DATE column for cleaned values
ALTER TABLE unicorn_companies
ADD COLUMN date_joined_clean DATE;

-- Step 2: Convert 'MM/DD/YYYY' or 'M/D/YYYY' style dates
UPDATE unicorn_companies
SET date_joined_clean = STR_TO_DATE(`Date Joined`, '%m/%d/%Y')
WHERE `Date Joined` REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';

-- Step 3: Convert 'DD-MM-YYYY' style dates
UPDATE unicorn_companies
SET date_joined_clean = STR_TO_DATE(`Date Joined`, '%d-%m-%Y')
WHERE `Date Joined` REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';

-- Step 4 (optional): Check for entries that could not be converted
SELECT `Date Joined`
FROM unicorn_companies
WHERE date_joined_clean IS NULL;

ALTER TABLE unicorn_companies DROP COLUMN `Date Joined`;

ALTER TABLE unicorn_companies CHANGE date_joined_clean `Date Joined` DATE;


#Correction of mis-spelled finttech to fintech
UPDATE unicorn_companies
SET Industry = 'Fintech'
WHERE Industry = 'Finttech';


#Create funding efficiency for valuation
CREATE TABLE valuation_summary AS
SELECT *,
  `Joined Year` - `Founded Year` AS years_to_unicorn,
  ROUND(valuation_in_billions / NULLIF(total_raised_in_billions, 0), 2) 
  AS funding_efficiency
FROM unicorn_companies;


#This SQL script converts valuation and funding amounts from text ($B / $M)
#into clean numeric values in billions for analysis

#change $B to Billions
ALTER TABLE unicorn_companies
ADD valuation_in_billions DECIMAL(15, 6);

UPDATE unicorn_companies
SET valuation_in_billions = REPLACE(`Valuation ($B)`, '$', '')
WHERE `Valuation ($B)` LIKE '$%';

#ALTER TABLE unicorn_companies DROP COLUMN investment_in_billions;

#change $B & $M into Billions
ALTER TABLE unicorn_companies
ADD total_raised_in_billions DECIMAL(15, 6);

UPDATE unicorn_companies
SET total_raised_in_billions = 
  CASE
    WHEN `Total Raised` REGEXP '^[\\$]?[0-9]+(\\.[0-9]+)?[Bb]$' 
      THEN CAST(REPLACE(REPLACE(REPLACE(`Total Raised`, '$', ''), 'B', ''), 'b', '') AS DECIMAL(15,6))

    WHEN `Total Raised` REGEXP '^[\\$]?[0-9]+(\\.[0-9]+)?[Mm]$' 
      THEN CAST(REPLACE(REPLACE(REPLACE(`Total Raised`, '$', ''), 'M', ''), 'm', '') AS DECIMAL(15,6)) / 1000

    ELSE NULL
  END
WHERE `Total Raised` IS NOT NULL AND `Total Raised` NOT IN ('None', 'none', '-', 'N/A', '');