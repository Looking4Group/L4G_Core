-- server first table structure
CREATE TABLE IF NOT EXISTS `server_first` (
  `entry` int(11) NOT NULL COMMENT 'Team ID for server first 70. Creature ID for server first boss kill.',
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `character_id` int(11) DEFAULT NULL,
  `guild_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
