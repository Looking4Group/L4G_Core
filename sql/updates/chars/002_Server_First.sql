-- server first table structure
-- IMPORTANT. Check you create it inside the CHARACTERS database. No idea what it is called for Hellfire.
CREATE TABLE IF NOT EXISTS `characters`.`server_first` (
  `entry` int(11) NOT NULL COMMENT 'Team ID for server first 70. Creature ID for server first boss kill.',
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `character_id` int(11) DEFAULT NULL,
  `guild_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;