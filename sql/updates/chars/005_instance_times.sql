CREATE TABLE IF NOT EXISTS `instance_times` (
  `instance_id` int(11) unsigned NOT NULL DEFAULT '0',
  `map` int(11) unsigned DEFAULT '0',
  `difficulty` tinyint(1) unsigned DEFAULT NULL,
  `data` longtext,
  `start_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `end_time` timestamp NULL DEFAULT NULL,
  `player_ids` longtext,
  `deaths` int(11) DEFAULT '0',
  PRIMARY KEY (`instance_id`),
  KEY `map` (`map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;