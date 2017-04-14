-- Add the faction column (INT) to the server first table
SELECT
	COUNT(*)
	INTO @exist
FROM
	information_schema.columns 
WHERE
	table_schema = database()
	AND COLUMN_NAME = 'faction'
	AND TABLE_NAME = 'server_first'
LIMIT 1;

SET @query = IF(@exist <= 0, 'ALTER TABLE `server_first` ADD COLUMN `faction` INT NULL AFTER `entry`', 'SELECT \'Column Exists\' status');

PREPARE stmt FROM @query;

EXECUTE stmt;

-- Remove primary key (from entry field) as we want to have multiple entries per creature due to 2 factions	
ALTER TABLE `server_first`
	DROP PRIMARY KEY;