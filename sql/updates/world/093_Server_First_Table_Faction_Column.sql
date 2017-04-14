-- Add the faction column (INT) to the server first table
ALTER TABLE `server_first`
	ADD COLUMN `faction` INT NULL AFTER `entry`;

-- Remove primary key (from entry field) as we want to have multiple entries per creature due to 2 factions	
ALTER TABLE `server_first`
	DROP PRIMARY KEY;