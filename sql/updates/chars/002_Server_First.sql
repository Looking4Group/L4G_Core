-- server first table structure
CREATE TABLE IF NOT EXISTS `server_first` (
	`entry` INT(11) NOT NULL COMMENT 'Team ID for server first 70. Creature ID for server first boss kill.',
	`faction` INT(11) NULL DEFAULT NULL,
	`date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`character_id` INT(11) NULL DEFAULT NULL,
	`guild_id` INT(11) NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
