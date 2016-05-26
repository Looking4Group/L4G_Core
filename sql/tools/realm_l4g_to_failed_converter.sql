/* copy new account access level into old gmlevel field for conversion */

UPDATE account SET gmlevel = (SELECT gmlevel FROM account_access WHERE id = account.id) WHERE id = account.id AND id IN (SELECT id FROM account_access);

/* backup old account and account access table */

CREATE TABLE account_backup LIKE account;
INSERT INTO account_backup SELECT * FROM account;
CREATE TABLE account_access_backup LIKE account_access;
INSERT INTO account_access_backup SELECT * FROM account_access;

/* change account table structure to faileds one */

ALTER TABLE `account`
DROP COLUMN `recruiter`,
DROP COLUMN `rank`,
DROP COLUMN `staff_id`,
DROP COLUMN `vp`,
DROP COLUMN `dp`,
DROP COLUMN `isactive`,
DROP COLUMN `activation`,
ADD COLUMN `last_local_ip`  varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0.0.0.0' AFTER `last_ip`,
ADD COLUMN `opcodesDisabled`  int(11) NOT NULL DEFAULT 0 AFTER `locale`,
ADD COLUMN `account_flags`  double NULL DEFAULT 0 AFTER `opcodesDisabled`,
ADD COLUMN `operatingSystem`  tinyint(4) NULL DEFAULT NULL AFTER `account_flags`,
ADD COLUMN `vote`  int(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `operatingSystem`,
DROP INDEX `idx_username` ,
ADD UNIQUE INDEX `username` (`username`) USING BTREE ,
DROP INDEX `idx_gmlevel` ,
ADD INDEX `gmlevel` (`gmlevel`) USING BTREE ;

/* drop account_access table cause we do not need it here */

DROP TABLE IF EXISTS account_access;

DROP TABLE IF EXISTS `account_login`;

CREATE TABLE `account_login` (
  `id` int(11) NOT NULL DEFAULT '0',
  `logindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(30) NOT NULL,
  `local_ip` varchar(30) NOT NULL,
  PRIMARY KEY (`id`,`logindate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `account_mute`;

CREATE TABLE `account_mute` (
  `id` int(11) NOT NULL DEFAULT '0',
  `mutedate` bigint(40) NOT NULL DEFAULT '0',
  `unmutedate` bigint(40) NOT NULL DEFAULT '0',
  `mutedby` varchar(50) NOT NULL,
  `mutereason` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`mutedate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `email_banned`;

CREATE TABLE `email_banned` (
  `email` varchar(50) NOT NULL,
  `bandate` int(11) NOT NULL,
  `bannedby` varchar(50) NOT NULL DEFAULT '[Console]',
  `banreason` varchar(50) NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `pattern_banned`;

CREATE TABLE `pattern_banned` (
  `ip_pattern` varchar(20) DEFAULT NULL,
  `localip_pattern` varchar(20) DEFAULT NULL,
  `comment` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `unqueue_account`;

CREATE TABLE `unqueue_account` (
  `accid` double unsigned NOT NULL,
  `add_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text,
  PRIMARY KEY (`accid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/* change tablestructure of realmlist table */

ALTER TABLE `realmlist`
DROP COLUMN `gamebuild`,
CHANGE COLUMN `color` `realmflags`  tinyint(3) UNSIGNED NOT NULL DEFAULT 2 AFTER `icon`,
ADD COLUMN `realmbuilds`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '8606' AFTER `population`,
ADD COLUMN `dbinfo`  varchar(355) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'username;password;3306;127.0.0.1;DBWorld;DBCharacter' COMMENT 'Database info to THIS row' AFTER `realmbuilds`,
ADD COLUMN `ra_address`  varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '127.0.0.1' AFTER `dbinfo`,
ADD COLUMN `ra_port`  int(5) NOT NULL DEFAULT 3443 AFTER `ra_address`,
ADD COLUMN `ra_user`  varchar(355) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'username' AFTER `ra_port`,
ADD COLUMN `ra_pass`  varchar(355) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'password' AFTER `ra_user`,
DROP INDEX `idx_name` ,
ADD UNIQUE INDEX `name` (`name`) USING BTREE ;

/*
now we should have the same structure as of the failed account db base structure and continue updating db to newest revision
keep in mind that we have the vointing points stored in the account_backup table and the vip dates in the account_access_backup table for future reimplementation of that features
*/

DROP TABLE IF EXISTS `account_access`;
CREATE TABLE `account_access` (
  `id` int(11) unsigned NOT NULL,
  `gmlevel` tinyint(3) unsigned NOT NULL,
  `RealmID` int(11) NOT NULL DEFAULT '-1',
  `comment` text,
  PRIMARY KEY (`id`,`RealmID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO account_access SELECT id, gmlevel, -1, NULL FROM account WHERE gmlevel > 0;

ALTER TABLE `account`
DROP COLUMN `gmlevel`,
DROP COLUMN `mutetime`,
MODIFY COLUMN `id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Identifier' FIRST ,
DROP INDEX `gmlevel`,
DROP INDEX `username` ,
ADD UNIQUE INDEX `idx_username` (`username`) USING BTREE ,
ENGINE=MyISAM,
COMMENT='Account System',
ROW_FORMAT=DYNAMIC;

ALTER TABLE `account_banned`
MODIFY COLUMN `id`  int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Account Id' FIRST ,
ENGINE=MyISAM,
COMMENT='Ban List',
ROW_FORMAT=DYNAMIC;

ALTER TABLE `account_login`
MODIFY COLUMN `id`  int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Account Id' FIRST ,
ENGINE=MyISAM,
ROW_FORMAT=DYNAMIC;

ALTER TABLE `account_mute`
MODIFY COLUMN `id`  int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Account Id' FIRST ,
ENGINE=MyISAM,
COMMENT='Mute List',
ROW_FORMAT=DYNAMIC;

ALTER TABLE `email_banned`
ENGINE=MyISAM,
ROW_FORMAT=DYNAMIC;

ALTER TABLE `ip_banned`
MODIFY COLUMN `bandate`  bigint(40) NOT NULL AFTER `ip`,
MODIFY COLUMN `unbandate`  bigint(40) NOT NULL AFTER `bandate`,
ENGINE=MyISAM,
COMMENT='Banned IPs',
ROW_FORMAT=DYNAMIC;

ALTER TABLE `pattern_banned`
ENGINE=MyISAM,
ROW_FORMAT=DYNAMIC;

ALTER TABLE `realmcharacters`
ENGINE=MyISAM,
COMMENT='Realm Character Tracker',
ROW_FORMAT=DYNAMIC;

ALTER TABLE `realmlist`
ENGINE=MyISAM,
COMMENT='Realm System',
ROW_FORMAT=DYNAMIC;

ALTER TABLE `unqueue_account`
MODIFY COLUMN `accid`  int(11) UNSIGNED NOT NULL FIRST ,
ENGINE=MyISAM,
ROW_FORMAT=DYNAMIC;

ALTER TABLE `realmlist`
DROP COLUMN `dbinfo`,
DROP COLUMN `ra_address`,
DROP COLUMN `ra_port`,
DROP COLUMN `ra_user`,
DROP COLUMN `ra_pass`,
CHANGE COLUMN `realmbuilds` `gamebuild`  int(11) UNSIGNED NOT NULL DEFAULT 8606 AFTER `population`,
DROP INDEX `name` ,
ADD UNIQUE INDEX `idx_name` (`name`) USING BTREE ;

ALTER TABLE `account`
DROP COLUMN `vote`,
DROP COLUMN `operatingSystem`,
ADD COLUMN `os`  varchar(3) NOT NULL DEFAULT '' AFTER `locale`;

ALTER TABLE `account_banned`
ADD COLUMN `realm`  int(11) UNSIGNED NOT NULL AFTER `id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`, `realm`, `bandate`);

CREATE  TABLE IF NOT EXISTS `account_state` (
  `account_state_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`account_state_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE  TABLE IF NOT EXISTS `client_os_version` (
  `client_os_version_id` TINYINT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`client_os_version_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE  TABLE IF NOT EXISTS `expansion` (
  `expansion_id` TINYINT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`expansion_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE  TABLE IF NOT EXISTS `locale` (
  `locale_id` TINYINT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`locale_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE  TABLE IF NOT EXISTS `punishment_type` (
  `punishment_type_id` TINYINT UNSIGNED NOT NULL,
  `name` CHAR(30) NOT NULL,
  PRIMARY KEY (`punishment_type_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

ALTER TABLE `account` RENAME `account_old`;

CREATE  TABLE IF NOT EXISTS `account` (
  `account_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) CHARACTER SET 'latin1' COLLATE 'latin1_general_ci' NOT NULL,
  `email` VARCHAR(50) NOT NULL DEFAULT '',
  `pass_hash` CHAR(40) NOT NULL DEFAULT '',
  `join_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `registration_ip` VARCHAR(16) NOT NULL DEFAULT '0.0.0.0',
  `expansion_id` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `account_state_id` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `locale_id` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `failed_logins` INT UNSIGNED NOT NULL DEFAULT 0,
  `last_ip` VARCHAR(16) NOT NULL DEFAULT '0.0.0.0',
  `last_local_ip` VARCHAR(16) NOT NULL DEFAULT '0.0.0.0',
  `last_login` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `online` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `opcodes_disabled` INT UNSIGNED NOT NULL DEFAULT 0,
  `account_flags` INT UNSIGNED NOT NULL DEFAULT 0,
  `client_os_version_id` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`account_id`) ,
  UNIQUE INDEX `username` (`username` ASC),
  CONSTRAINT `FK_account_state_id` FOREIGN KEY `account_state_id` (`account_state_id`)
    REFERENCES `account_state` (`account_state_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `FK_client_os_version_id` FOREIGN KEY `client_os_version_id` (`client_os_version_id`)
    REFERENCES `client_os_version` (`client_os_version_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_expansion_id` FOREIGN KEY `expansion_id` (`expansion_id`)
    REFERENCES `expansion` (`expansion_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8 COLLATE = utf8_unicode_ci;

ALTER TABLE account_login DROP PRIMARY KEY;
ALTER TABLE account_login
  CHANGE `id` `account_id` INT UNSIGNED NOT NULL,
  CHANGE `logindate` `login_date` INT(11) NOT NULL,
  MODIFY `ip` VARCHAR(16) NOT NULL,
  MODIFY `local_ip` VARCHAR(16) NOT NULL,
  ADD PRIMARY KEY (`account_id`, `login_date`),
  ADD CONSTRAINT `FK_account_login_account_id` FOREIGN KEY `account_id` (`account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  ENGINE = InnoDB;

ALTER TABLE ip_banned DROP PRIMARY KEY;
ALTER TABLE ip_banned
  MODIFY `ip` CHAR(16) NOT NULL,
  CHANGE `bandate` `ban_date` INT(11) NOT NULL,
  CHANGE `unbandate` `unban_date` INT(11) NOT NULL,
  CHANGE `bannedby` `banned_by` VARCHAR(16) NOT NULL,
  CHANGE `banreason` `ban_reason` VARCHAR(100) NOT NULL,
  ADD PRIMARY KEY (`ip`, `ban_date`);

ALTER TABLE email_banned DROP PRIMARY KEY;
ALTER TABLE email_banned
  CHANGE `bandate` `ban_date` INT(11) NOT NULL,
  CHANGE `bannedby` `banned_by` VARCHAR(16) NOT NULL,
  CHANGE `banreason` `ban_reason` VARCHAR(100) NOT NULL,
  ADD PRIMARY KEY (`email`);

ALTER TABLE `pattern_banned` RENAME `pattern_banned_old`;

CREATE TABLE IF NOT EXISTS `pattern_banned` (
  `pattern_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ip_pattern` VARCHAR(255) NOT NULL ,
  `local_ip_pattern` VARCHAR(255) NOT NULL ,
  `comment` CHAR(100) NOT NULL ,
  PRIMARY KEY (`pattern_id`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

ALTER TABLE `realmlist` RENAME `realms`;

ALTER TABLE `realms` DROP KEY idx_name;
ALTER TABLE `realms`
  CHANGE `id` `realm_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  MODIFY `name` VARCHAR(32) NOT NULL,
  CHANGE `address` `ip_address` VARCHAR(16) NOT NULL DEFAULT '127.0.0.1',
  MODIFY `port` INT UNSIGNED NOT NULL DEFAULT 8085,
  MODIFY `icon` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  CHANGE `realmflags` `flags` TINYINT UNSIGNED NOT NULL DEFAULT 6 COMMENT 'Supported masks: 0x1 (invalid, not show in realm list), 0x2 (offline, set by core), 0x4 (show version and build), 0x20 (recommended), 0x40 (new players)',
  MODIFY `timezone` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  DROP COLUMN `allowedSecurityLevel`,
  ADD COLUMN `required_permission_mask` BIGINT UNSIGNED NOT NULL DEFAULT 1 AFTER `timezone`,
  MODIFY `population` FLOAT UNSIGNED NOT NULL DEFAULT 0,
  CHANGE `gamebuild` `allowed_builds` VARCHAR(64) NOT NULL DEFAULT '8606',
  ADD UNIQUE INDEX `name` (`name`),
  ENGINE = InnoDB;

ALTER TABLE `realmcharacters` RENAME `realm_characters`;

ALTER TABLE `realm_characters`
  CHANGE `realmid` `realm_id` INT UNSIGNED NOT NULL,
  CHANGE `acctid` `account_id` INT UNSIGNED NOT NULL,
  CHANGE `numchars` `characters_count` TINYINT UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE `realm_characters`
  ADD CONSTRAINT `FK_realm_characters_realm_id` FOREIGN KEY `realm_id` (`realm_id`)
    REFERENCES `realms`(`realm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_realm_characters_account_id` FOREIGN KEY `account_id` (`account_id`)
    REFERENCES `account`(`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE `realm_characters` ENGINE = InnoDB;

CREATE  TABLE IF NOT EXISTS `account_permissions` (
  `account_id` INT UNSIGNED NOT NULL,
  `realm_id` INT UNSIGNED NOT NULL,
  `permission_mask` BIGINT UNSIGNED NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`account_id`, `realm_id`),
  CONSTRAINT `FK_account_permissions_account_id` FOREIGN KEY `account_id` (`account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_account_permissions_realm_id` FOREIGN KEY `realm_id` (`realm_id` )
    REFERENCES `realms` (`realm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE  TABLE IF NOT EXISTS `account_punishment` (
  `account_id` INT UNSIGNED NOT NULL ,
  `punishment_type_id` TINYINT UNSIGNED NOT NULL ,
  `punishment_date` INT(11) NOT NULL ,
  `expiration_date` INT(11) NOT NULL ,
  `punished_by` VARCHAR(45) NOT NULL ,
  `reason` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`account_id`, `punishment_type_id`, `punishment_date`) ,
  CONSTRAINT `FKpunishment_type_id` FOREIGN KEY `punishment_type_id` (`punishment_type_id`)
    REFERENCES `punishment_type` (`punishment_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_account_punishment_account_id` FOREIGN KEY `account_id` (`account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE  TABLE IF NOT EXISTS `account_support` (
  `account_id` INT UNSIGNED NOT NULL ,
  `support_points` INT UNSIGNED NOT NULL DEFAULT 0 ,
  PRIMARY KEY (`account_id`) ,
  CONSTRAINT `FK_account_support_account_id` FOREIGN KEY `account_id` (`account_id`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE  TABLE IF NOT EXISTS `account_session` (
  `account_id` INT UNSIGNED NOT NULL ,
  `session_key` VARCHAR(80) NOT NULL DEFAULT '' ,
  `v` VARCHAR(80) NOT NULL DEFAULT '' ,
  `s` VARCHAR(80) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`account_id`) ,
  CONSTRAINT `FK_account_session_account_id` FOREIGN KEY `account_id` (`account_id`)
    REFERENCES `account` (`account_id` )
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

DROP TRIGGER IF EXISTS `account_creation`;
DROP TRIGGER IF EXISTS `realm_creation`;

DELIMITER //

CREATE TRIGGER `account_creation` AFTER INSERT ON `account` FOR EACH ROW
BEGIN
    INSERT INTO `account_permissions` (`account_id`, `realm_id`)
        SELECT NEW.`account_id`, `realm_id` FROM realms;
    INSERT INTO `account_support` (`account_id`)
        VALUES (NEW.`account_id`);
    INSERT INTO `account_session` (`account_id`)
        VALUES (NEW.`account_id`);
    INSERT INTO `realm_characters` (`account_id`, `realm_id`)
        SELECT NEW.`account_id`, `realm_id` FROM realms;
END

//

DELIMITER //

CREATE TRIGGER `realm_creation` AFTER INSERT ON `realms` FOR EACH ROW
BEGIN
    INSERT INTO `account_permissions` (`account_id`, `realm_id`)
        SELECT `account_id`, NEW.`realm_id` FROM account;
    INSERT INTO `realm_characters` (`account_id`, `realm_id`)
        SELECT `account_id`, NEW.`realm_id` FROM account;
END

//

DELIMITER ;

INSERT INTO `account_state` (`account_state_id`, `name`) VALUES
(1, 'Active'),
(2, 'IP locked'),
(3, 'Frozen');

INSERT INTO `client_os_version` VALUES
(0, 'Unknown'),
(1, 'Microsoft Windows'),
(2, 'Apple Macintosh OSX'),
(3, 'Custom WoW Chat Client');

INSERT INTO `expansion` VALUES
(0, 'World of Warcraft'),
(1, 'World of Warcraft: The Burning Crusade'),
(2, 'World of Warcraft: Wrath of the Lich King'),
(3, 'World of Warcraft: Cataclysm');

INSERT INTO `punishment_type` VALUES
(1, 'Account mute'),
(2, 'Account ban');

INSERT INTO `locale` VALUES
(0, 'enUS'),
(1, 'koKR'),
(2, 'frFR'),
(3, 'deDE'),
(4, 'zhCN'),
(5, 'zhTW'),
(6, 'esES'),
(7, 'esMX'),
(8, 'ruRU');

INSERT INTO pattern_banned (`ip_pattern`, `local_ip_pattern`, `comment`)
    SELECT `ip_pattern`, `localip_pattern`, `comment` FROM pattern_banned_old;

DELETE FROM realm_characters;

INSERT INTO `account` (`account_id`, `username`, `email`, `pass_hash`, `join_date`, `expansion_id`,  `account_state_id`, `locale_id`, `failed_logins`, `last_ip`, `last_local_ip`, `last_login`, `online`, `opcodes_disabled`, `account_flags`)
    SELECT `id`, `username`, `email`, `sha_pass_hash`, `joindate`, `expansion`, `locked` + 1, `locale`, `failed_logins`, `last_ip`, `last_local_ip`, `last_login`, `online`, `opcodesDisabled`, `account_flags` FROM account_old;

UPDATE `account` SET `client_os_version_id` = `client_os_version_id` + 1;
UPDATE `account` SET `client_os_version_id` = 0 WHERE `client_os_version_id` > 2;

INSERT INTO `account_punishment`
    SELECT `id`, 2, `bandate`, `unbandate`, `bannedby`, `banreason` FROM `account_banned`;

INSERT INTO `account_punishment`
    SELECT `id`, 1, `mutedate`, `unmutedate`, `mutedby`, `mutereason` FROM `account_mute`;

UPDATE `account_punishment`
SET `expiration_date` = UNIX_TIMESTAMP()
WHERE `punishment_type_id` = 2 AND
    EXISTS (SELECT `id`
        FROM `account_banned`
        WHERE `id` = `account_punishment`.`account_id` AND
            `bandate` = `account_punishment`.`punishment_date` AND
            `active` = 0 AND `unbandate` > UNIX_TIMESTAMP());

UPDATE `account_punishment`
SET `expiration_date` = UNIX_TIMESTAMP()
WHERE `punishment_type_id` = 1 AND
    EXISTS (SELECT `id`
        FROM `account_mute`
        WHERE `id` = `account_punishment`.`account_id` AND
            `mutedate` = `account_punishment`.`punishment_date` AND
            `active` = 0 AND `unmutedate` > UNIX_TIMESTAMP());

UPDATE account_access set RealmID = 1;

UPDATE `account_permissions`
SET `permission_mask` = `permission_mask` | 0x000001;

UPDATE `account_permissions`
SET `permission_mask` = `permission_mask` | 0x000101
WHERE EXISTS (SELECT 1
          FROM `account_access`
          WHERE `id` = `account_permissions`.`account_id` AND
              `RealmID` = `account_permissions`.`realm_id` AND
              `gmlevel` = 1);

UPDATE `account_permissions`
SET `permission_mask` = `permission_mask` | 0x000301
WHERE EXISTS (SELECT 1
          FROM `account_access`
          WHERE `id` = `account_permissions`.`account_id` AND
              `RealmID` = `account_permissions`.`realm_id` AND
              `gmlevel` = 2);

UPDATE `account_permissions`
SET `permission_mask` = `permission_mask` | 0x000B03
WHERE EXISTS (SELECT 1
          FROM `account_access`
          WHERE `id` = `account_permissions`.`account_id` AND
              `RealmID` = `account_permissions`.`realm_id` AND
              `gmlevel` = 3);

UPDATE `account_permissions`
SET `permission_mask` = `permission_mask` | 0x001B03
WHERE EXISTS (SELECT 1
          FROM `account_access`
          WHERE `id` = `account_permissions`.`account_id` AND
              `RealmID` = `account_permissions`.`realm_id` AND
              `gmlevel` = 4);

UPDATE `account_permissions`
SET `permission_mask` = `permission_mask` | 0x003B03
WHERE EXISTS (SELECT 1
          FROM `account_access`
          WHERE `id` = `account_permissions`.`account_id` AND
              `RealmID` = `account_permissions`.`realm_id` AND
              `gmlevel` > 4);

DROP TABLE IF EXISTS `account_old`;
DROP TABLE IF EXISTS `pattern_banned_old`;
DROP TABLE IF EXISTS `account_banned`;
DROP TABLE IF EXISTS `account_mute`;
DROP TABLE IF EXISTS `account_access`;
DROP TABLE IF EXISTS `account_extend`;
DROP TABLE IF EXISTS `account_groups`;
DROP TABLE IF EXISTS `account_keys`;
DROP TABLE IF EXISTS `blocked_ips`;
DROP TABLE IF EXISTS `ip2nation`;
DROP TABLE IF EXISTS `ip2nationCountries`;
DROP TABLE IF EXISTS `online`;

-- vip expirience
ALTER TABLE account_permissions ADD COLUMN setdate INT(11);
ALTER TABLE account_permissions ADD COLUMN unsetdate INT(11);

UPDATE account_permissions SET 
setdate = (SELECT setdate FROM account_access_backup WHERE account_id = account_access_backup.id), 
unsetdate = (SELECT unsetdate FROM account_access_backup WHERE account_id = account_access_backup.id);

DROP TABLE IF EXISTS `account_web`;
CREATE TABLE `account_web` (
`account_id`  int(10) NULL ,
`rank`  int(32) NULL ,
`staff_id`  int(32) NULL ,
`vp`  varchar(32) NULL ,
`dp`  varchar(32) NULL ,
`isactive`  int(32) NULL ,
`activation`  varchar(255) NULL ,
PRIMARY KEY (`account_id`)
);

INSERT INTO `account_web` (`account_id`, `rank`, `staff_id`, `vp`, `dp`, `isactive`, `activation`) SELECT `id`, `rank`, `staff_id`, `vp`, `dp`, `isactive`, `activation` FROM `account_backup`;

/* now our realm db should be ok */
