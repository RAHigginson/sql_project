SET SQL_SAFE_UPDATES = 0;
-- Cleaning tasks airbnb_last_review table

-- Changing the date from string to date format and standarizing the format to DD-MM-YYYY
UPDATE airbnb_last_review
SET last_review = DATE_FORMAT(STR_TO_DATE(last_review, '%M %d %Y'), '%d-%m-%Y');

SELECT * 
FROM airbnb_last_review;

-- checking if there are null values

SELECT *
FROM airbnb_last_review
WHERE listing_id IS NULL OR host_name IS NULL OR last_review IS NULL;


-- Cleaning tasks airbnb_price table

-- Trying the code
SELECT SUBSTRING_INDEX(price, ' ', 1) AS Price_in_dollars
FROM airbnb_price;

-- creating the new table
ALTER TABLE airbnb_price
ADD COLUMN Price_in_dollars VARCHAR(255);
-- populating the column with the value in dollars
UPDATE airbnb_price
SET Price_in_dollars = SUBSTRING_INDEX(price, ' ', 1);
-- deleting the old column
ALTER TABLE airbnb_price
DROP COLUMN price;
-- putting the column back to its original index
ALTER TABLE airbnb_price
MODIFY COLUMN Price_in_dollars VARCHAR(255) AFTER listing_id;
-- check if the table was modified
SELECT *
FROM airbnb_price;

-- creating two new columns to divide the nbhood_full column
ALTER TABLE airbnb_price
ADD COLUMN nbhood_borough VARCHAR(255),
ADD COLUMN nbhood_portion VARCHAR(255);

-- populating the new columns

UPDATE airbnb_price
SET nbhood_borough = SUBSTRING_INDEX(nbhood_full, ',', 1),
	nbhood_portion = substring_index(nbhood_full, ',', -1);

-- dropping the old column 
ALTER TABLE airbnb_price
DROP COLUMN nbhood_full;

-- checking the new table
SELECT * 
FROM airbnb_price;


-- Cleaning task airbnb_room_type table

-- standirizng the data in the room_type column

UPDATE airbnb_room_type
SET room_type = CONCAT(
    UPPER(SUBSTRING(room_type, 1, 1)),
    LOWER(SUBSTRING(room_type, 2))
);

-- checking the new table

SELECT *
FROM airbnb_room_type;

-- checking the unique values 

SELECT room_type, COUNT(*) AS count
FROM airbnb_room_type
GROUP BY room_type;
