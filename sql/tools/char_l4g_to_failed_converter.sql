CREATE TABLE characters_backup LIKE characters;
INSERT INTO characters_backup SELECT * FROM characters;

ALTER TABLE characters
ADD gender TINYINT UNSIGNED NOT NULL default '0' AFTER class,
ADD xp INT UNSIGNED NOT NULL default '0' AFTER gender,
ADD money INT UNSIGNED NOT NULL default '0' AFTER xp,
ADD playerBytes INT UNSIGNED NOT NULL default '0' AFTER money,
ADD playerBytes2 INT UNSIGNED NOT NULL default '0' AFTER playerBytes,
ADD playerFlags INT UNSIGNED NOT NULL default '0' AFTER playerBytes2,
ADD `level` tinyint(3) unsigned DEFAULT '1' AFTER playerFlags,
DROP COLUMN `grantableLevels`;

UPDATE characters SET
gender = (CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(data, ' ', 37), ' ', -1) AS UNSIGNED) & 0xFF0000) >> 16,
xp = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(data, ' ', 927), ' ', -1) AS UNSIGNED),
money = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(data, ' ', 1462), ' ', -1) AS UNSIGNED),
playerBytes = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(data, ' ', 240), ' ', -1) AS UNSIGNED),
playerBytes2 = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(data, ' ', 241), ' ', -1) AS UNSIGNED),
playerFlags = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(data, ' ', 237), ' ', -1) AS UNSIGNED),
`level` = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(data, ' ', 35), ' ', -1) AS UNSIGNED)

WHERE LENGTH(SUBSTRING_INDEX(data, ' ', 1592)) < LENGTH(data) && LENGTH(data) <= LENGTH(SUBSTRING_INDEX(data, ' ', 1593));

ALTER TABLE `characters`
  ADD COLUMN `title` BIGINT(30) UNSIGNED NULL  COMMENT 'Character\'s title' AFTER `level`;

UPDATE `characters` SET `title`= (CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`data`, ' ', 925), ' ', -1) AS UNSIGNED) | (CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`data`, ' ', 926), ' ', -1) AS UNSIGNED) << 32));

ALTER TABLE characters
ADD `instance_id` int(11) unsigned NOT NULL DEFAULT '0' AFTER map;

ALTER TABLE characters DROP KEY `idx_account`;
ALTER TABLE characters DROP KEY `idx_online`;
ALTER TABLE characters DROP KEY `idx_name`;
ALTER TABLE characters ADD KEY `account` (`account`);
ALTER TABLE characters ADD KEY `online` (`online`);
ALTER TABLE characters ADD KEY `name` (`name`);

ALTER TABLE arena_team_member ADD KEY `arenateamid` (`arenateamid`);

DROP TABLE IF EXISTS `auctionhouse`;
CREATE TABLE `auctionhouse` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `houseid` int(11) unsigned NOT NULL DEFAULT '0',
  `itemguid` int(11) unsigned NOT NULL DEFAULT '0',
  `item_template` int(11) unsigned NOT NULL DEFAULT '0',
  `item_count` int(11) unsigned NOT NULL DEFAULT '0',
  `item_randompropertyid` int(11) NOT NULL DEFAULT '0',
  `itemowner` int(11) unsigned NOT NULL DEFAULT '0',
  `buyoutprice` int(11) NOT NULL DEFAULT '0',
  `time` bigint(40) NOT NULL DEFAULT '0',
  `buyguid` int(11) unsigned NOT NULL DEFAULT '0',
  `lastbid` int(11) NOT NULL DEFAULT '0',
  `startbid` int(11) NOT NULL DEFAULT '0',
  `deposit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE character_action ADD KEY `guid` (`guid`);
ALTER TABLE character_aura ADD KEY `guid` (`guid`);
ALTER TABLE character_instance ADD KEY `guid` (`guid`);

ALTER TABLE character_inventory DROP KEY `idx_guid`;
ALTER TABLE character_inventory ADD KEY `guid` (`guid`);

ALTER TABLE character_pet_declinedname DROP KEY `owner_key`;
ALTER TABLE character_pet_declinedname ADD KEY `owner` (`owner`);

ALTER TABLE character_queststatus_daily DROP KEY `idx_guid`;
ALTER TABLE character_queststatus_daily ADD KEY `guid` (`guid`);

DROP TABLE IF EXISTS `character_stats_ro`;
CREATE TABLE `character_stats_ro` (
  `guid` bigint(8) unsigned NOT NULL,
  `honor` bigint(8) unsigned NOT NULL,
  `honorablekills` bit(8) NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE character_tutorial DROP KEY `acc_key`;
ALTER TABLE character_tutorial ADD KEY `account` (`account`);

ALTER TABLE corpse DROP KEY `idx_type`;
ALTER TABLE corpse DROP KEY `instance`;
ALTER TABLE corpse ADD KEY `corpse_type` (`corpse_type`);
ALTER TABLE corpse ADD KEY `instance` (`instance`);

DROP TABLE IF EXISTS `creature_respawn`;
CREATE TABLE `creature_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `deleted_chars`;
CREATE TABLE `deleted_chars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_guid` int(10) unsigned NOT NULL,
  `oldname` varchar(15) NOT NULL,
  `acc` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `gameobject_respawn`;
CREATE TABLE `gameobject_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `gm_tickets`;
CREATE TABLE `gm_tickets` (
  `guid` int(10) NOT NULL AUTO_INCREMENT,
  `playerGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `createtime` int(10) NOT NULL,
  `map` int(11) NOT NULL DEFAULT '0',
  `posX` float NOT NULL DEFAULT '0',
  `posY` float NOT NULL DEFAULT '0',
  `posZ` float NOT NULL DEFAULT '0',
  `timestamp` int(10) NOT NULL DEFAULT '0',
  `assignedto` int(10) NOT NULL DEFAULT '0',
  `closed` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE group_member ADD KEY `memberGuid` (`memberGuid`);

DROP TABLE IF EXISTS `group_saved_loot`;
CREATE TABLE `group_saved_loot` (
  `creatureId` int(11) NOT NULL DEFAULT '0',
  `instanceId` int(11) NOT NULL DEFAULT '0',
  `itemId` int(11) NOT NULL DEFAULT '0',
  `itemCount` int(11) DEFAULT NULL,
  `summoned` tinyint(1) DEFAULT '0',
  `position_x` float DEFAULT NULL,
  `position_y` float DEFAULT NULL,
  `position_z` float DEFAULT NULL,
  `playerGuids` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`creatureId`,`instanceId`,`itemId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE guild ADD flags INT UNSIGNED NOT NULL default '0' AFTER BankMoney;

DROP TABLE IF EXISTS `guild_announce_cooldown`;
CREATE TABLE `guild_announce_cooldown` (
  `guild_id` int(10) unsigned NOT NULL,
  `cooldown_end` bigint(20) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE guild_bank_eventlog DROP KEY `guildid_key`;
ALTER TABLE guild_bank_eventlog ADD KEY `PlayerGuid` (`PlayerGuid`);
ALTER TABLE guild_bank_eventlog ADD KEY `LogGuid` (`LogGuid`);

ALTER TABLE guild_bank_item DROP KEY `guildid_key`;
ALTER TABLE guild_bank_item ADD KEY `guildid` (`guildid`);
ALTER TABLE guild_bank_item ADD KEY `item_guid` (`item_guid`);

ALTER TABLE guild_bank_right DROP KEY `guildid_key`;
ALTER TABLE guild_bank_right ADD KEY `guildid` (`guildid`);

ALTER TABLE guild_bank_tab DROP KEY `guildid_key`;
ALTER TABLE guild_bank_tab ADD KEY `guildid` (`guildid`);

ALTER TABLE guild_eventlog CONVERT TO CHARACTER SET utf8;
ALTER TABLE guild_eventlog ADD PRIMARY KEY (`guildid`,`LogGuid`);
ALTER TABLE guild_eventlog ADD KEY `PlayerGuid1` (`PlayerGuid1`);
ALTER TABLE guild_eventlog ADD KEY `PlayerGuid2` (`PlayerGuid2`);
ALTER TABLE guild_eventlog ADD KEY `LogGuid` (`LogGuid`);

ALTER TABLE guild_member DROP KEY `guid_key`;
ALTER TABLE guild_member DROP KEY `guildid_key`;
ALTER TABLE guild_member DROP KEY `guildid_rank_key`;
ALTER TABLE guild_member ADD PRIMARY KEY (`guid`);
ALTER TABLE guild_member ADD KEY `guildid` (`guildid`);
ALTER TABLE guild_member ADD KEY `guildid_rank` (`guildid`,`rank`);

ALTER TABLE guild_rank ADD KEY `rid` (`rid`);

DROP TABLE IF EXISTS `hidden_rating`;
CREATE TABLE `hidden_rating` (
  `guid` int(11) unsigned NOT NULL,
  `rating2` int(10) unsigned NOT NULL DEFAULT '1500',
  `rating3` int(10) unsigned NOT NULL DEFAULT '1500',
  `rating5` int(10) unsigned NOT NULL DEFAULT '1500',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE item_instance DROP KEY `idx_owner_guid`;
ALTER TABLE item_instance ADD KEY `owner_guid` (`owner_guid`);

DROP TABLE IF EXISTS `item_text`;
CREATE TABLE `item_text` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `text` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE mail DROP KEY `idx_receiver`;
ALTER TABLE mail ADD KEY `receiver` (`receiver`);

DROP TABLE IF EXISTS `mail_external`;
CREATE TABLE `mail_external` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `receiver` bigint(20) unsigned NOT NULL,
  `subject` varchar(200) DEFAULT 'Support Message',
  `message` varchar(500) DEFAULT 'Support Message',
  `money` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_count` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE mail_items DROP PRIMARY KEY;
ALTER TABLE mail_items DROP KEY `idx_receiver`;
ALTER TABLE mail_items ADD PRIMARY KEY (`item_guid`);
ALTER TABLE mail_items ADD KEY `receiver` (`receiver`);
ALTER TABLE mail_items ADD KEY `idx_mail_id` (`mail_id`);

DROP TABLE IF EXISTS `map_template`;
CREATE TABLE `map_template` (
  `entry` int(3) unsigned NOT NULL COMMENT 'MapID',
  `visibility` float unsigned DEFAULT '533' COMMENT 'VisibilityRadius',
  `pathfinding` smallint(1) unsigned DEFAULT '6' COMMENT 'PathFinding Prioririty',
  `lineofsight` smallint(1) unsigned DEFAULT '6' COMMENT 'LineOfSight Prioririty',
  `ainotifyperiod` smallint(4) unsigned DEFAULT '1000' COMMENT 'Interval between AI notifications about relocation',
  `viewupdatedistance` smallint(2) unsigned DEFAULT '10' COMMENT 'ViewUpdate minimal distance',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `map_template` VALUES ('0', '80', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('1', '80', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('13', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('25', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('29', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('30', '170', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('33', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('34', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('36', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('43', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('47', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('48', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('70', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('90', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('109', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('129', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('169', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('189', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('209', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('229', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('230', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('249', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('269', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('289', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('309', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('329', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('349', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('369', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('389', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('409', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('429', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('449', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('450', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('451', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('469', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('489', '170', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('509', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('529', '170', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('530', '80', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('531', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('532', '130', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('533', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('534', '175', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('540', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('542', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('543', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('544', '130', '1', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('545', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('546', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('547', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('548', '130', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('550', '175', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('552', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('553', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('554', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('555', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('556', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('557', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('558', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('559', '200', '6', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('560', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('562', '200', '6', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('564', '175', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('565', '130', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('566', '170', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('568', '130', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('572', '200', '6', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('580', '130', '3', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('585', '130', '2', '6', '1000', '10');
INSERT INTO `map_template` VALUES ('598', '130', '2', '6', '1000', '10');

DROP TABLE IF EXISTS `opcodes_cooldown`;
CREATE TABLE `opcodes_cooldown` (
  `opcode` varchar(20) NOT NULL COMMENT 'Opcode name',
  `cooldown` int(4) unsigned DEFAULT '1000' COMMENT 'Opcode cooldown',
  PRIMARY KEY (`opcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `opcodes_cooldown` VALUES ('CMSG_INSPECT', '1000');
INSERT INTO `opcodes_cooldown` VALUES ('CMSG_WHOIS', '1000');

ALTER TABLE petition DROP KEY `index_ownerguid_petitionguid`;
ALTER TABLE petition ADD UNIQUE KEY `ownerguid_petitionguid` (`ownerguid`,`petitionguid`);

DROP TABLE IF EXISTS `reserved_name`;
CREATE TABLE `reserved_name` (
  `name` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player Reserved Names';

ALTER TABLE saved_variables
ADD `HeroicQuest` int(5) unsigned NOT NULL DEFAULT '0' AFTER NextArenaPointDistributionTime,
ADD `NormalQuest` int(5) unsigned NOT NULL DEFAULT '0' AFTER HeroicQuest,
ADD `CookingQuest` int(5) unsigned NOT NULL DEFAULT '0' AFTER NormalQuest,
ADD `FishingQuest` int(5) unsigned NOT NULL DEFAULT '0' AFTER CookingQuest,
ADD `PVPAlliance` int(5) unsigned NOT NULL DEFAULT '0' AFTER FishingQuest,
ADD `PVPHorde` int(5) unsigned NOT NULL DEFAULT '0' AFTER PVPAlliance;

DROP TABLE IF EXISTS `spell_disabled`;
CREATE TABLE `spell_disabled` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell entry',
  `disable_mask` int(8) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Disabled Spell System';

INSERT INTO `spell_disabled` VALUES ('1852', '7', 'Silenced (GM Tool) Spell bugged');
INSERT INTO `spell_disabled` VALUES ('46642', '7', '5k gold');

DROP TABLE IF EXISTS `uptime`;
CREATE TABLE `uptime` (
  `starttime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `startstring` varchar(64) NOT NULL DEFAULT '',
  `uptime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Uptime system';

DROP PROCEDURE IF EXISTS `PreventCharDelete`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PreventCharDelete`(IN charguid INT UNSIGNED)
BEGIN
    INSERT INTO deleted_chars VALUES ('XXX', charguid, (SELECT name FROM characters WHERE guid = charguid), (SELECT account FROM characters WHERE guid = charguid), CAST(NOW() AS DATETIME));
    UPDATE characters SET account = 1 WHERE guid = charguid;
    UPDATE characters SET name = CONCAT('DEL', name, 'DEL') WHERE guid = charguid;
    DELETE FROM character_social WHERE guid = charguid OR friend = charguid;
    DELETE FROM mail WHERE receiver = charguid;
    DELETE FROM mail_items WHERE receiver = charguid;
END
;;
DELIMITER ;
