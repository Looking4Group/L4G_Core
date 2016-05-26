SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `account_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(16) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pass_hash` char(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token_key` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `join_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `registration_ip` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `expansion_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `account_state_id` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `locale_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `failed_logins` int(10) unsigned NOT NULL DEFAULT '0',
  `last_ip` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `last_local_ip` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `opcodes_disabled` int(10) unsigned NOT NULL DEFAULT '0',
  `account_flags` int(10) unsigned NOT NULL DEFAULT '0',
  `client_os_version_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `staff_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `isactive` tinyint(2) DEFAULT '1',
  `activation` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `votes` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_account_state_id` (`account_state_id`),
  KEY `FK_client_os_version_id` (`client_os_version_id`),
  KEY `FK_expansion_id` (`expansion_id`),
  CONSTRAINT `FK_account_state_id` FOREIGN KEY (`account_state_id`) REFERENCES `account_state` (`account_state_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `FK_client_os_version_id` FOREIGN KEY (`client_os_version_id`) REFERENCES `client_os_version` (`client_os_version_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_expansion_id` FOREIGN KEY (`expansion_id`) REFERENCES `expansion` (`expansion_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=58291 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for account_friends
-- ----------------------------
DROP TABLE IF EXISTS `account_friends`;
CREATE TABLE `account_friends` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `friend_id` int(11) unsigned NOT NULL DEFAULT '0',
  `bind_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Bring Date',
  `expire_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Expire Date',
  PRIMARY KEY (`id`,`friend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 PACK_KEYS=0 COMMENT='Stores accounts for Refer-a-Friend System.';

-- ----------------------------
-- Table structure for account_login
-- ----------------------------
DROP TABLE IF EXISTS `account_login`;
CREATE TABLE `account_login` (
  `account_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Id',
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `local_ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`account_id`,`login_date`),
  CONSTRAINT `FK_account_login_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for account_login_old
-- ----------------------------
DROP TABLE IF EXISTS `account_login_old`;
CREATE TABLE `account_login_old` (
  `id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Id',
  `logindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(30) NOT NULL,
  `local_ip` varchar(30) NOT NULL,
  PRIMARY KEY (`id`,`logindate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for account_mentor
-- ----------------------------
DROP TABLE IF EXISTS `account_mentor`;
CREATE TABLE `account_mentor` (
  `acc_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`acc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for account_permissions
-- ----------------------------
DROP TABLE IF EXISTS `account_permissions`;
CREATE TABLE `account_permissions` (
  `account_id` int(10) unsigned NOT NULL,
  `realm_id` int(10) unsigned NOT NULL,
  `permission_mask` bigint(20) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`,`realm_id`),
  KEY `FK_account_permissions_realm_id` (`realm_id`),
  CONSTRAINT `FK_account_permissions_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_account_permissions_realm_id` FOREIGN KEY (`realm_id`) REFERENCES `realms` (`realm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_punishment
-- ----------------------------
DROP TABLE IF EXISTS `account_punishment`;
CREATE TABLE `account_punishment` (
  `account_id` int(10) unsigned NOT NULL,
  `punishment_type_id` tinyint(3) unsigned NOT NULL,
  `punishment_date` int(11) NOT NULL,
  `expiration_date` int(11) NOT NULL,
  `punished_by` varchar(45) NOT NULL,
  `reason` varchar(100) NOT NULL,
  `active` int(255) DEFAULT NULL,
  PRIMARY KEY (`account_id`,`punishment_type_id`,`punishment_date`),
  KEY `FKpunishment_type_id` (`punishment_type_id`),
  CONSTRAINT `FKpunishment_type_id` FOREIGN KEY (`punishment_type_id`) REFERENCES `punishment_type` (`punishment_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_account_punishment_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_session
-- ----------------------------
DROP TABLE IF EXISTS `account_session`;
CREATE TABLE `account_session` (
  `account_id` int(10) unsigned NOT NULL,
  `session_key` varchar(80) NOT NULL DEFAULT '',
  `v` varchar(80) NOT NULL DEFAULT '',
  `s` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`),
  CONSTRAINT `FK_account_session_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_state
-- ----------------------------
DROP TABLE IF EXISTS `account_state`;
CREATE TABLE `account_state` (
  `account_state_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  PRIMARY KEY (`account_state_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for account_support
-- ----------------------------
DROP TABLE IF EXISTS `account_support`;
CREATE TABLE `account_support` (
  `account_id` int(10) unsigned NOT NULL,
  `support_points` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_id`),
  CONSTRAINT `FK_account_support_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for client_os_version
-- ----------------------------
DROP TABLE IF EXISTS `client_os_version`;
CREATE TABLE `client_os_version` (
  `client_os_version_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`client_os_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for email_banned
-- ----------------------------
DROP TABLE IF EXISTS `email_banned`;
CREATE TABLE `email_banned` (
  `email` varchar(50) NOT NULL,
  `ban_date` int(11) NOT NULL,
  `banned_by` varchar(16) NOT NULL,
  `ban_reason` varchar(100) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for expansion
-- ----------------------------
DROP TABLE IF EXISTS `expansion`;
CREATE TABLE `expansion` (
  `expansion_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`expansion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ip_banned
-- ----------------------------
DROP TABLE IF EXISTS `ip_banned`;
CREATE TABLE `ip_banned` (
  `ip` char(16) NOT NULL,
  `ban_date` int(11) NOT NULL,
  `unban_date` int(11) NOT NULL,
  `banned_by` varchar(16) NOT NULL,
  `ban_reason` varchar(100) NOT NULL,
  PRIMARY KEY (`ip`,`ban_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Banned IPs';

-- ----------------------------
-- Table structure for locale
-- ----------------------------
DROP TABLE IF EXISTS `locale`;
CREATE TABLE `locale` (
  `locale_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`locale_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mentoring_program
-- ----------------------------
DROP TABLE IF EXISTS `mentoring_program`;
CREATE TABLE `mentoring_program` (
  `mentee` int(10) unsigned NOT NULL,
  `mentor` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`mentee`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pattern_banned
-- ----------------------------
DROP TABLE IF EXISTS `pattern_banned`;
CREATE TABLE `pattern_banned` (
  `pattern_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip_pattern` varchar(255) NOT NULL,
  `local_ip_pattern` varchar(255) NOT NULL,
  `comment` char(100) NOT NULL,
  PRIMARY KEY (`pattern_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for punishment_type
-- ----------------------------
DROP TABLE IF EXISTS `punishment_type`;
CREATE TABLE `punishment_type` (
  `punishment_type_id` tinyint(3) unsigned NOT NULL,
  `name` char(30) NOT NULL,
  PRIMARY KEY (`punishment_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pve_log
-- ----------------------------
DROP TABLE IF EXISTS `pve_log`;
CREATE TABLE `pve_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `boss_id` int(10) unsigned NOT NULL,
  `instance_id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `start_time` int(11) DEFAULT NULL,
  `damage` int(10) DEFAULT '0',
  `heal` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pve_log_loot
-- ----------------------------
DROP TABLE IF EXISTS `pve_log_loot`;
CREATE TABLE `pve_log_loot` (
  `instance_id` int(11) NOT NULL,
  `boss_entry` int(11) NOT NULL,
  `loot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pve_log_overview
-- ----------------------------
DROP TABLE IF EXISTS `pve_log_overview`;
CREATE TABLE `pve_log_overview` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` int(10) unsigned DEFAULT NULL,
  `boss_name` varchar(40) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `boss_entry` int(7) unsigned NOT NULL,
  `location` varchar(40) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `guild` varchar(40) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `length` bigint(15) unsigned NOT NULL,
  `date` bigint(15) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pvpstats_battlegrounds
-- ----------------------------
DROP TABLE IF EXISTS `pvpstats_battlegrounds`;
CREATE TABLE `pvpstats_battlegrounds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `winner_faction` int(10) unsigned NOT NULL,
  `bracket_id` tinyint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pvpstats_players
-- ----------------------------
DROP TABLE IF EXISTS `pvpstats_players`;
CREATE TABLE `pvpstats_players` (
  `battleground_id` bigint(20) unsigned NOT NULL,
  `character_guid` int(10) unsigned NOT NULL,
  `score_killing_blows` mediumint(8) unsigned NOT NULL,
  `score_deaths` mediumint(8) unsigned NOT NULL,
  `score_honorable_kills` mediumint(8) unsigned NOT NULL,
  `score_bonus_honor` mediumint(8) unsigned NOT NULL,
  `score_damage_done` mediumint(8) unsigned NOT NULL,
  `score_healing_done` mediumint(8) unsigned NOT NULL,
  `attr_1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `attr_5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `team` int(10) NOT NULL,
  PRIMARY KEY (`battleground_id`,`character_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for realm_characters
-- ----------------------------
DROP TABLE IF EXISTS `realm_characters`;
CREATE TABLE `realm_characters` (
  `realm_id` int(10) unsigned NOT NULL,
  `account_id` int(10) unsigned NOT NULL,
  `characters_count` tinyint(3) unsigned NOT NULL DEFAULT '0',
  KEY `FK_realm_characters_realm_id` (`realm_id`),
  KEY `FK_realm_characters_account_id` (`account_id`),
  CONSTRAINT `FK_realm_characters_account_id` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_realm_characters_realm_id` FOREIGN KEY (`realm_id`) REFERENCES `realms` (`realm_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Table structure for realmcharacters_old
-- ----------------------------
DROP TABLE IF EXISTS `realmcharacters_old`;
CREATE TABLE `realmcharacters_old` (
  `realmid` int(11) unsigned NOT NULL DEFAULT '0',
  `acctid` bigint(20) unsigned NOT NULL,
  `numchars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm Character Tracker';

-- ----------------------------
-- Table structure for realms
-- ----------------------------
DROP TABLE IF EXISTS `realms`;
CREATE TABLE `realms` (
  `realm_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `ip_address` varchar(16) NOT NULL DEFAULT '127.0.0.1',
  `port` int(10) unsigned NOT NULL DEFAULT '8085',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `flags` tinyint(3) unsigned NOT NULL DEFAULT '6' COMMENT 'Supported masks: 0x1 (invalid, not show in realm list), 0x2 (offline, set by core), 0x4 (show version and build), 0x20 (recommended), 0x40 (new players)',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `required_permission_mask` bigint(20) unsigned NOT NULL DEFAULT '1',
  `population` float unsigned NOT NULL DEFAULT '0',
  `allowed_builds` varchar(64) NOT NULL DEFAULT '8606',
  PRIMARY KEY (`realm_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm System';

-- Records

INSERT INTO `account_state` VALUES ('1', 'Active');
INSERT INTO `account_state` VALUES ('2', 'IP locked');
INSERT INTO `account_state` VALUES ('3', 'Frozen');

INSERT INTO `client_os_version` VALUES ('0', 'Unknown');
INSERT INTO `client_os_version` VALUES ('1', 'Microsoft Windows');
INSERT INTO `client_os_version` VALUES ('2', 'Apple Macintosh OSX');
INSERT INTO `client_os_version` VALUES ('3', 'Custom WoW Chat Client');

INSERT INTO `expansion` VALUES ('0', 'World of Warcraft');
INSERT INTO `expansion` VALUES ('1', 'World of Warcraft: The Burning Crusade');
INSERT INTO `expansion` VALUES ('2', 'World of Warcraft: Wrath of the Lich King');
INSERT INTO `expansion` VALUES ('3', 'World of Warcraft: Cataclysm');

INSERT INTO `locale` VALUES ('0', 'enUS');
INSERT INTO `locale` VALUES ('1', 'koKR');
INSERT INTO `locale` VALUES ('2', 'frFR');
INSERT INTO `locale` VALUES ('3', 'deDE');
INSERT INTO `locale` VALUES ('4', 'zhCN');
INSERT INTO `locale` VALUES ('5', 'zhTW');
INSERT INTO `locale` VALUES ('6', 'esES');
INSERT INTO `locale` VALUES ('7', 'esMX');
INSERT INTO `locale` VALUES ('8', 'ruRU');

INSERT INTO `punishment_type` VALUES ('1', 'Account mute');
INSERT INTO `punishment_type` VALUES ('2', 'Account ban');

-- ----------------------------
-- Table structure for unqueue_account
-- ----------------------------
DROP TABLE IF EXISTS `unqueue_account`;
CREATE TABLE `unqueue_account` (
  `accid` int(11) unsigned NOT NULL,
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text,
  PRIMARY KEY (`accid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
DROP TRIGGER IF EXISTS `account_creation`;
DELIMITER ;;
CREATE TRIGGER `account_creation` AFTER INSERT ON `account` FOR EACH ROW BEGIN
    INSERT INTO `account_permissions` (`account_id`, `realm_id`)
        SELECT NEW.`account_id`, `realm_id` FROM realms;
    INSERT INTO `account_support` (`account_id`)
        VALUES (NEW.`account_id`);
    INSERT INTO `account_session` (`account_id`)
        VALUES (NEW.`account_id`);
    INSERT INTO `realm_characters` (`account_id`, `realm_id`)
        SELECT NEW.`account_id`, `realm_id` FROM realms;
END
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `realm_creation`;
DELIMITER ;;
CREATE TRIGGER `realm_creation` AFTER INSERT ON `realms` FOR EACH ROW BEGIN
    INSERT INTO `account_permissions` (`account_id`, `realm_id`)
        SELECT `account_id`, NEW.`realm_id` FROM account;
    INSERT INTO `realm_characters` (`account_id`, `realm_id`)
        SELECT `account_id`, NEW.`realm_id` FROM account;
END
;;
DELIMITER ;
