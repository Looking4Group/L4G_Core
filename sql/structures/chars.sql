SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for arena_logging
-- ----------------------------
DROP TABLE IF EXISTS `arena_logging`;
CREATE TABLE `arena_logging` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `playername` varchar(50) DEFAULT NULL,
  `guid` bigint(20) DEFAULT NULL,
  `team` bigint(20) DEFAULT NULL,
  `ipaddress` varchar(20) DEFAULT NULL,
  `damage` bigint(20) DEFAULT NULL,
  `healing` bigint(20) DEFAULT NULL,
  `killingblows` bigint(20) DEFAULT NULL,
  `checked` int(1) DEFAULT NULL,
  `comment` text,
  `lineup` int(1) DEFAULT NULL,
  `fromgm` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2916 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for arena_team
-- ----------------------------
DROP TABLE IF EXISTS `arena_team`;
CREATE TABLE `arena_team` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT '0',
  `name` char(255) NOT NULL,
  `captainguid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `BackgroundColor` int(10) unsigned NOT NULL DEFAULT '0',
  `EmblemStyle` int(10) unsigned NOT NULL DEFAULT '0',
  `EmblemColor` int(10) unsigned NOT NULL DEFAULT '0',
  `BorderStyle` int(10) unsigned NOT NULL DEFAULT '0',
  `BorderColor` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenateamid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for arena_team_member
-- ----------------------------
DROP TABLE IF EXISTS `arena_team_member`;
CREATE TABLE `arena_team_member` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT '0',
  `guid` int(10) unsigned NOT NULL DEFAULT '0',
  `played_week` int(10) unsigned NOT NULL DEFAULT '0',
  `wons_week` int(10) unsigned NOT NULL DEFAULT '0',
  `played_season` int(10) unsigned NOT NULL DEFAULT '0',
  `wons_season` int(10) unsigned NOT NULL DEFAULT '0',
  `personal_rating` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenateamid`,`guid`),
  KEY `arenateamid` (`arenateamid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for arena_team_push
-- ----------------------------
DROP TABLE IF EXISTS `arena_team_push`;
CREATE TABLE `arena_team_push` (
  `ArenaID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TeamID` int(11) NOT NULL,
  `GegnerTeamID` int(11) NOT NULL,
  `Datum` longtext,
  `win` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ArenaID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for arena_team_stats
-- ----------------------------
DROP TABLE IF EXISTS `arena_team_stats`;
CREATE TABLE `arena_team_stats` (
  `arenateamid` int(10) unsigned NOT NULL DEFAULT '0',
  `rating` int(10) unsigned NOT NULL DEFAULT '0',
  `games` int(10) unsigned NOT NULL DEFAULT '0',
  `wins` int(10) unsigned NOT NULL DEFAULT '0',
  `played` int(10) unsigned NOT NULL DEFAULT '0',
  `wins2` int(10) unsigned NOT NULL DEFAULT '0',
  `rank` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`arenateamid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auctionhouse
-- ----------------------------
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

-- ----------------------------
-- Table structure for auctionhousebot
-- ----------------------------
DROP TABLE IF EXISTS `auctionhousebot`;
CREATE TABLE `auctionhousebot` (
  `auctionhouse` int(11) NOT NULL DEFAULT '0' COMMENT 'mapID of the auctionhouse.',
  `name` char(25) DEFAULT NULL COMMENT 'Text name of the auctionhouse.',
  `minitems` int(11) DEFAULT '0' COMMENT 'This is the minimum number of items you want to keep in the auction house. a 0 here will make it the same as the maximum.',
  `maxitems` int(11) DEFAULT '0' COMMENT 'This is the number of items you want to keep in the auction house.',
  `percentgreytradegoods` int(11) DEFAULT '0' COMMENT 'Sets the percentage of the Grey Trade Goods auction items',
  `percentwhitetradegoods` int(11) DEFAULT '27' COMMENT 'Sets the percentage of the White Trade Goods auction items',
  `percentgreentradegoods` int(11) DEFAULT '12' COMMENT 'Sets the percentage of the Green Trade Goods auction items',
  `percentbluetradegoods` int(11) DEFAULT '10' COMMENT 'Sets the percentage of the Blue Trade Goods auction items',
  `percentpurpletradegoods` int(11) DEFAULT '1' COMMENT 'Sets the percentage of the Purple Trade Goods auction items',
  `percentorangetradegoods` int(11) DEFAULT '0' COMMENT 'Sets the percentage of the Orange Trade Goods auction items',
  `percentyellowtradegoods` int(11) DEFAULT '0' COMMENT 'Sets the percentage of the Yellow Trade Goods auction items',
  `percentgreyitems` int(11) DEFAULT '0' COMMENT 'Sets the percentage of the non trade Grey auction items',
  `percentwhiteitems` int(11) DEFAULT '10' COMMENT 'Sets the percentage of the non trade White auction items',
  `percentgreenitems` int(11) DEFAULT '30' COMMENT 'Sets the percentage of the non trade Green auction items',
  `percentblueitems` int(11) DEFAULT '8' COMMENT 'Sets the percentage of the non trade Blue auction items',
  `percentpurpleitems` int(11) DEFAULT '2' COMMENT 'Sets the percentage of the non trade Purple auction items',
  `percentorangeitems` int(11) DEFAULT '0' COMMENT 'Sets the percentage of the non trade Orange auction items',
  `percentyellowitems` int(11) DEFAULT '0' COMMENT 'Sets the percentage of the non trade Yellow auction items',
  `minpricegrey` int(11) DEFAULT '100' COMMENT 'Minimum price of Grey items (percentage).',
  `maxpricegrey` int(11) DEFAULT '150' COMMENT 'Maximum price of Grey items (percentage).',
  `minpricewhite` int(11) DEFAULT '150' COMMENT 'Minimum price of White items (percentage).',
  `maxpricewhite` int(11) DEFAULT '250' COMMENT 'Maximum price of White items (percentage).',
  `minpricegreen` int(11) DEFAULT '800' COMMENT 'Minimum price of Green items (percentage).',
  `maxpricegreen` int(11) DEFAULT '1400' COMMENT 'Maximum price of Green items (percentage).',
  `minpriceblue` int(11) DEFAULT '1250' COMMENT 'Minimum price of Blue items (percentage).',
  `maxpriceblue` int(11) DEFAULT '1750' COMMENT 'Maximum price of Blue items (percentage).',
  `minpricepurple` int(11) DEFAULT '2250' COMMENT 'Minimum price of Purple items (percentage).',
  `maxpricepurple` int(11) DEFAULT '4550' COMMENT 'Maximum price of Purple items (percentage).',
  `minpriceorange` int(11) DEFAULT '3250' COMMENT 'Minimum price of Orange items (percentage).',
  `maxpriceorange` int(11) DEFAULT '5550' COMMENT 'Maximum price of Orange items (percentage).',
  `minpriceyellow` int(11) DEFAULT '5250' COMMENT 'Minimum price of Yellow items (percentage).',
  `maxpriceyellow` int(11) DEFAULT '6550' COMMENT 'Maximum price of Yellow items (percentage).',
  `minbidpricegrey` int(11) DEFAULT '70' COMMENT 'Starting bid price of Grey items as a percentage of the randomly chosen buyout price. Default: 70',
  `maxbidpricegrey` int(11) DEFAULT '100' COMMENT 'Starting bid price of Grey items as a percentage of the randomly chosen buyout price. Default: 100',
  `minbidpricewhite` int(11) DEFAULT '70' COMMENT 'Starting bid price of White items as a percentage of the randomly chosen buyout price. Default: 70',
  `maxbidpricewhite` int(11) DEFAULT '100' COMMENT 'Starting bid price of White items as a percentage of the randomly chosen buyout price. Default: 100',
  `minbidpricegreen` int(11) DEFAULT '80' COMMENT 'Starting bid price of Green items as a percentage of the randomly chosen buyout price. Default: 80',
  `maxbidpricegreen` int(11) DEFAULT '100' COMMENT 'Starting bid price of Green items as a percentage of the randomly chosen buyout price. Default: 100',
  `minbidpriceblue` int(11) DEFAULT '75' COMMENT 'Starting bid price of Blue items as a percentage of the randomly chosen buyout price. Default: 75',
  `maxbidpriceblue` int(11) DEFAULT '100' COMMENT 'Starting bid price of Blue items as a percentage of the randomly chosen buyout price. Default: 100',
  `minbidpricepurple` int(11) DEFAULT '80' COMMENT 'Starting bid price of Purple items as a percentage of the randomly chosen buyout price. Default: 80',
  `maxbidpricepurple` int(11) DEFAULT '100' COMMENT 'Starting bid price of Purple items as a percentage of the randomly chosen buyout price. Default: 100',
  `minbidpriceorange` int(11) DEFAULT '80' COMMENT 'Starting bid price of Orange items as a percentage of the randomly chosen buyout price. Default: 80',
  `maxbidpriceorange` int(11) DEFAULT '100' COMMENT 'Starting bid price of Orange items as a percentage of the randomly chosen buyout price. Default: 100',
  `minbidpriceyellow` int(11) DEFAULT '80' COMMENT 'Starting bid price of Yellow items as a percentage of the randomly chosen buyout price. Default: 80',
  `maxbidpriceyellow` int(11) DEFAULT '100' COMMENT 'Starting bid price of Yellow items as a percentage of the randomly chosen buyout price. Default: 100',
  `maxstackgrey` int(11) DEFAULT '0' COMMENT 'Stack size limits for item qualities - a value of 0 will disable a maximum stack size for that quality, which will allow the bot to create items in stack as large as the item allows.',
  `maxstackwhite` int(11) DEFAULT '0' COMMENT 'Stack size limits for item qualities - a value of 0 will disable a maximum stack size for that quality, which will allow the bot to create items in stack as large as the item allows.',
  `maxstackgreen` int(11) DEFAULT '0' COMMENT 'Stack size limits for item qualities - a value of 0 will disable a maximum stack size for that quality, which will allow the bot to create items in stack as large as the item allows.',
  `maxstackblue` int(11) DEFAULT '0' COMMENT 'Stack size limits for item qualities - a value of 0 will disable a maximum stack size for that quality, which will allow the bot to create items in stack as large as the item allows.',
  `maxstackpurple` int(11) DEFAULT '0' COMMENT 'Stack size limits for item qualities - a value of 0 will disable a maximum stack size for that quality, which will allow the bot to create items in stack as large as the item allows.',
  `maxstackorange` int(11) DEFAULT '0' COMMENT 'Stack size limits for item qualities - a value of 0 will disable a maximum stack size for that quality, which will allow the bot to create items in stack as large as the item allows.',
  `maxstackyellow` int(11) DEFAULT '0' COMMENT 'Stack size limits for item qualities - a value of 0 will disable a maximum stack size for that quality, which will allow the bot to create items in stack as large as the item allows.',
  `buyerpricegrey` int(11) DEFAULT '1' COMMENT 'Multiplier to vendorprice when buying grey items from auctionhouse',
  `buyerpricewhite` int(11) DEFAULT '3' COMMENT 'Multiplier to vendorprice when buying white items from auctionhouse',
  `buyerpricegreen` int(11) DEFAULT '5' COMMENT 'Multiplier to vendorprice when buying green items from auctionhouse',
  `buyerpriceblue` int(11) DEFAULT '12' COMMENT 'Multiplier to vendorprice when buying blue items from auctionhouse',
  `buyerpricepurple` int(11) DEFAULT '15' COMMENT 'Multiplier to vendorprice when buying purple items from auctionhouse',
  `buyerpriceorange` int(11) DEFAULT '20' COMMENT 'Multiplier to vendorprice when buying orange items from auctionhouse',
  `buyerpriceyellow` int(11) DEFAULT '22' COMMENT 'Multiplier to vendorprice when buying yellow items from auctionhouse',
  `buyerbiddinginterval` int(11) DEFAULT '1' COMMENT 'Interval how frequently AHB bids on each AH. Time in minutes',
  `buyerbidsperinterval` int(11) DEFAULT '1' COMMENT 'number of bids to put in per bidding interval',
  PRIMARY KEY (`auctionhouse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bossfight_detail
-- ----------------------------
DROP TABLE IF EXISTS `bossfight_detail`;
CREATE TABLE `bossfight_detail` (
  `id` int(10) unsigned NOT NULL,
  `player_id` int(10) unsigned NOT NULL,
  `player_name` varchar(40) CHARACTER SET latin1 COLLATE latin1_german1_ci NOT NULL,
  `healing` bigint(12) DEFAULT NULL,
  `damage` bigint(12) DEFAULT NULL,
  PRIMARY KEY (`id`,`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bossfight_loot
-- ----------------------------
DROP TABLE IF EXISTS `bossfight_loot`;
CREATE TABLE `bossfight_loot` (
  `instance_id` int(11) NOT NULL,
  `boss_entry` int(11) NOT NULL,
  `loot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bossfight_overview
-- ----------------------------
DROP TABLE IF EXISTS `bossfight_overview`;
CREATE TABLE `bossfight_overview` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `instance_id` int(10) unsigned DEFAULT NULL,
  `boss_name` varchar(40) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `boss_entry` int(7) unsigned NOT NULL,
  `location` varchar(40) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `guild` varchar(40) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  `length` bigint(15) unsigned NOT NULL,
  `date` bigint(15) unsigned NOT NULL,
  `loot` varchar(250) CHARACTER SET latin1 COLLATE latin1_german1_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bugreport
-- ----------------------------
DROP TABLE IF EXISTS `bugreport`;
CREATE TABLE `bugreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL DEFAULT '',
  `content` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_action
-- ----------------------------
DROP TABLE IF EXISTS `character_action`;
CREATE TABLE `character_action` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `button` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `action` smallint(5) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `misc` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`button`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_aura
-- ----------------------------
DROP TABLE IF EXISTS `character_aura`;
CREATE TABLE `character_aura` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `caster_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `effect_index` int(11) unsigned NOT NULL DEFAULT '0',
  `stackcount` int(11) NOT NULL DEFAULT '1',
  `amount` int(11) NOT NULL DEFAULT '0',
  `maxduration` int(11) NOT NULL DEFAULT '0',
  `remaintime` int(11) NOT NULL DEFAULT '0',
  `remaincharges` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`,`effect_index`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_bgcoord
-- ----------------------------
DROP TABLE IF EXISTS `character_bgcoord`;
CREATE TABLE `character_bgcoord` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `bgid` int(10) unsigned NOT NULL DEFAULT '0',
  `bgteam` int(10) unsigned NOT NULL DEFAULT '0',
  `bgmap` int(10) unsigned NOT NULL DEFAULT '0',
  `bgx` float NOT NULL DEFAULT '0',
  `bgy` float NOT NULL DEFAULT '0',
  `bgz` float NOT NULL DEFAULT '0',
  `bgo` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_declinedname
-- ----------------------------
DROP TABLE IF EXISTS `character_declinedname`;
CREATE TABLE `character_declinedname` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `genitive` varchar(15) NOT NULL DEFAULT '',
  `dative` varchar(15) NOT NULL DEFAULT '',
  `accusative` varchar(15) NOT NULL DEFAULT '',
  `instrumental` varchar(15) NOT NULL DEFAULT '',
  `prepositional` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_gifts
-- ----------------------------
DROP TABLE IF EXISTS `character_gifts`;
CREATE TABLE `character_gifts` (
  `guid` int(20) unsigned NOT NULL DEFAULT '0',
  `item_guid` int(11) unsigned NOT NULL DEFAULT '0',
  `entry` int(20) unsigned NOT NULL DEFAULT '0',
  `flags` int(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_guid`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_homebind
-- ----------------------------
DROP TABLE IF EXISTS `character_homebind`;
CREATE TABLE `character_homebind` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `zone` int(11) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_homebind_b2tbc
-- ----------------------------
DROP TABLE IF EXISTS `character_homebind_b2tbc`;
CREATE TABLE `character_homebind_b2tbc` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `map` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `zone` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Zone Identifier',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';

-- ----------------------------
-- Table structure for character_instance
-- ----------------------------
DROP TABLE IF EXISTS `character_instance`;
CREATE TABLE `character_instance` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL DEFAULT '0',
  `permanent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_inventory
-- ----------------------------
DROP TABLE IF EXISTS `character_inventory`;
CREATE TABLE `character_inventory` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `bag` int(11) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item` int(11) unsigned NOT NULL DEFAULT '0',
  `item_template` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`item`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_pet
-- ----------------------------
DROP TABLE IF EXISTS `character_pet`;
CREATE TABLE `character_pet` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `entry` int(11) unsigned NOT NULL DEFAULT '0',
  `owner` int(11) unsigned NOT NULL DEFAULT '0',
  `modelid` int(11) unsigned DEFAULT '0',
  `CreatedBySpell` int(11) unsigned NOT NULL DEFAULT '0',
  `PetType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `level` int(11) unsigned NOT NULL DEFAULT '1',
  `exp` int(11) unsigned NOT NULL DEFAULT '0',
  `Reactstate` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `loyaltypoints` int(11) NOT NULL DEFAULT '0',
  `loyalty` int(11) unsigned NOT NULL DEFAULT '0',
  `trainpoint` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT 'Pet',
  `renamed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `slot` int(11) unsigned NOT NULL DEFAULT '0',
  `curhealth` int(11) unsigned NOT NULL DEFAULT '1',
  `curmana` int(11) unsigned NOT NULL DEFAULT '0',
  `curhappiness` int(11) unsigned NOT NULL DEFAULT '0',
  `savetime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resettalents_cost` int(11) unsigned NOT NULL DEFAULT '0',
  `resettalents_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `abdata` longtext,
  `teachspelldata` longtext,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_pet_declinedname
-- ----------------------------
DROP TABLE IF EXISTS `character_pet_declinedname`;
CREATE TABLE `character_pet_declinedname` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `owner` int(11) unsigned NOT NULL DEFAULT '0',
  `genitive` varchar(12) NOT NULL DEFAULT '',
  `dative` varchar(12) NOT NULL DEFAULT '',
  `accusative` varchar(12) NOT NULL DEFAULT '',
  `instrumental` varchar(12) NOT NULL DEFAULT '',
  `prepositional` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_push
-- ----------------------------
DROP TABLE IF EXISTS `character_push`;
CREATE TABLE `character_push` (
  `account` int(11) NOT NULL,
  `ip` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='character_push';

-- ----------------------------
-- Table structure for character_quest
-- ----------------------------
DROP TABLE IF EXISTS `character_quest`;
CREATE TABLE `character_quest` (
  `guid` int(11) unsigned NOT NULL,
  `show_low_level_quest` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_quest_specialization
-- ----------------------------
DROP TABLE IF EXISTS `character_quest_specialization`;
CREATE TABLE `character_quest_specialization` (
  `guid` int(11) unsigned NOT NULL,
  `spezi_quest` set('2','5','4','3','1') NOT NULL,
  `done` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`guid`,`spezi_quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_queststatus
-- ----------------------------
DROP TABLE IF EXISTS `character_queststatus`;
CREATE TABLE `character_queststatus` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `quest` int(11) unsigned NOT NULL DEFAULT '0',
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `rewarded` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `explored` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timer` bigint(20) unsigned NOT NULL DEFAULT '0',
  `mobcount1` int(11) unsigned NOT NULL DEFAULT '0',
  `mobcount2` int(11) unsigned NOT NULL DEFAULT '0',
  `mobcount3` int(11) unsigned NOT NULL DEFAULT '0',
  `mobcount4` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount1` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount2` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount3` int(11) unsigned NOT NULL DEFAULT '0',
  `itemcount4` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_queststatus_daily
-- ----------------------------
DROP TABLE IF EXISTS `character_queststatus_daily`;
CREATE TABLE `character_queststatus_daily` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `quest` int(11) unsigned NOT NULL DEFAULT '0',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`),
  KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_queststatus_monthly
-- ----------------------------
DROP TABLE IF EXISTS `character_queststatus_monthly`;
CREATE TABLE `character_queststatus_monthly` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `quest` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Quest Identifier',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`quest`),
  KEY `idx_guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Player System';

-- ----------------------------
-- Table structure for character_reputation
-- ----------------------------
DROP TABLE IF EXISTS `character_reputation`;
CREATE TABLE `character_reputation` (
  `guid` bigint(10) NOT NULL DEFAULT '0',
  `faction` bigint(10) NOT NULL DEFAULT '0',
  `standing` bigint(10) DEFAULT NULL,
  `flags` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`guid`,`faction`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_social
-- ----------------------------
DROP TABLE IF EXISTS `character_social`;
CREATE TABLE `character_social` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `friend` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `note` varchar(48) NOT NULL DEFAULT '',
  PRIMARY KEY (`guid`,`friend`,`flags`),
  KEY `guid` (`guid`),
  KEY `friend` (`friend`),
  KEY `guid_flags` (`guid`,`flags`),
  KEY `friend_flags` (`friend`,`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_spell
-- ----------------------------
DROP TABLE IF EXISTS `character_spell`;
CREATE TABLE `character_spell` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `slot` int(11) unsigned NOT NULL DEFAULT '0',
  `active` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `disabled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_spell_cooldown
-- ----------------------------
DROP TABLE IF EXISTS `character_spell_cooldown`;
CREATE TABLE `character_spell_cooldown` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `item` int(11) unsigned NOT NULL DEFAULT '0',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_stats_ro
-- ----------------------------
DROP TABLE IF EXISTS `character_stats_ro`;
CREATE TABLE `character_stats_ro` (
  `guid` bigint(8) unsigned NOT NULL,
  `honor` bigint(8) unsigned NOT NULL,
  `honorablekills` bit(8) NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for character_stop_level
-- ----------------------------
DROP TABLE IF EXISTS `character_stop_level`;
CREATE TABLE `character_stop_level` (
  `id` int(11) NOT NULL DEFAULT '0',
  `active` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Chars No Leveling';

-- ----------------------------
-- Table structure for character_tutorial
-- ----------------------------
DROP TABLE IF EXISTS `character_tutorial`;
CREATE TABLE `character_tutorial` (
  `account` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `realmid` int(11) unsigned NOT NULL DEFAULT '0',
  `tut0` int(11) unsigned NOT NULL DEFAULT '0',
  `tut1` int(11) unsigned NOT NULL DEFAULT '0',
  `tut2` int(11) unsigned NOT NULL DEFAULT '0',
  `tut3` int(11) unsigned NOT NULL DEFAULT '0',
  `tut4` int(11) unsigned NOT NULL DEFAULT '0',
  `tut5` int(11) unsigned NOT NULL DEFAULT '0',
  `tut6` int(11) unsigned NOT NULL DEFAULT '0',
  `tut7` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`account`,`realmid`),
  KEY `account` (`account`)
) ENGINE=InnoDB AUTO_INCREMENT=58285 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `account` int(11) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  `name` varchar(12) NOT NULL DEFAULT '',
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `gender` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `xp` int(10) unsigned NOT NULL DEFAULT '0',
  `money` int(10) unsigned NOT NULL DEFAULT '0',
  `playerBytes` int(10) unsigned NOT NULL DEFAULT '0',
  `playerBytes2` int(10) unsigned NOT NULL DEFAULT '0',
  `playerFlags` int(10) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(3) unsigned DEFAULT '1',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `instance_id` int(11) unsigned NOT NULL DEFAULT '0',
  `dungeon_difficulty` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `taximask` longtext,
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cinematic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `totaltime` int(11) unsigned NOT NULL DEFAULT '0',
  `leveltime` int(11) unsigned NOT NULL DEFAULT '0',
  `logout_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `is_logout_resting` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rest_bonus` float NOT NULL DEFAULT '0',
  `resettalents_cost` int(11) unsigned NOT NULL DEFAULT '0',
  `resettalents_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `trans_x` float NOT NULL DEFAULT '0',
  `trans_y` float NOT NULL DEFAULT '0',
  `trans_z` float NOT NULL DEFAULT '0',
  `trans_o` float NOT NULL DEFAULT '0',
  `transguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `extra_flags` int(11) unsigned NOT NULL DEFAULT '0',
  `stable_slots` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `at_login` int(11) unsigned NOT NULL DEFAULT '0',
  `zone` int(11) unsigned NOT NULL DEFAULT '0',
  `death_expire_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxi_path` text,
  `changeRaceTo` tinyint(4) DEFAULT '0',
  `arena_pending_points` int(10) unsigned NOT NULL DEFAULT '0',
  `latency` int(11) unsigned NOT NULL DEFAULT '0',
  `title` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`guid`),
  KEY `account` (`account`),
  KEY `online` (`online`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for characters_backup
-- ----------------------------
DROP TABLE IF EXISTS `characters_backup`;
CREATE TABLE `characters_backup` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `account` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Account Identifier',
  `data` longtext,
  `name` varchar(12) NOT NULL DEFAULT '',
  `race` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `map` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `dungeon_difficulty` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `taximask` longtext,
  `online` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cinematic` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `totaltime` int(11) unsigned NOT NULL DEFAULT '0',
  `leveltime` int(11) unsigned NOT NULL DEFAULT '0',
  `logout_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `is_logout_resting` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rest_bonus` float NOT NULL DEFAULT '0',
  `resettalents_cost` int(11) unsigned NOT NULL DEFAULT '0',
  `resettalents_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `trans_x` float NOT NULL DEFAULT '0',
  `trans_y` float NOT NULL DEFAULT '0',
  `trans_z` float NOT NULL DEFAULT '0',
  `trans_o` float NOT NULL DEFAULT '0',
  `transguid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `extra_flags` int(11) unsigned NOT NULL DEFAULT '0',
  `stable_slots` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `at_login` int(11) unsigned NOT NULL DEFAULT '0',
  `zone` int(11) unsigned NOT NULL DEFAULT '0',
  `death_expire_time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxi_path` text,
  `arena_pending_points` int(10) unsigned NOT NULL DEFAULT '0',
  `latency` int(11) unsigned NOT NULL DEFAULT '0',
  `grantableLevels` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `idx_account` (`account`),
  KEY `idx_online` (`online`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player System';

-- ----------------------------
-- Table structure for cheat_logging
-- ----------------------------
DROP TABLE IF EXISTS `cheat_logging`;
CREATE TABLE `cheat_logging` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `playername` varchar(50) DEFAULT NULL,
  `account_id` bigint(20) NOT NULL,
  `latency` int(11) DEFAULT NULL,
  `ipaddress` varchar(50) DEFAULT NULL,
  `hackingtype` varchar(50) DEFAULT NULL,
  `finish` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for corpse
-- ----------------------------
DROP TABLE IF EXISTS `corpse`;
CREATE TABLE `corpse` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `player` int(11) unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  `zone` int(11) unsigned NOT NULL DEFAULT '38',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  `corpse_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `corpse_type` (`corpse_type`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for creature_respawn
-- ----------------------------
DROP TABLE IF EXISTS `creature_respawn`;
CREATE TABLE `creature_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for deleted_chars
-- ----------------------------
DROP TABLE IF EXISTS `deleted_chars`;
CREATE TABLE `deleted_chars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_guid` int(10) unsigned NOT NULL,
  `oldname` varchar(15) NOT NULL,
  `acc` int(11) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72391 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for game_event_condition_save
-- ----------------------------
DROP TABLE IF EXISTS `game_event_condition_save`;
CREATE TABLE `game_event_condition_save` (
  `event_id` mediumint(8) unsigned NOT NULL,
  `condition_id` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `done` float DEFAULT '0',
  PRIMARY KEY (`event_id`,`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for game_event_save
-- ----------------------------
DROP TABLE IF EXISTS `game_event_save`;
CREATE TABLE `game_event_save` (
  `event_id` mediumint(8) unsigned NOT NULL,
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `next_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for gameobject_respawn
-- ----------------------------
DROP TABLE IF EXISTS `gameobject_respawn`;
CREATE TABLE `gameobject_respawn` (
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawntime` bigint(20) NOT NULL DEFAULT '0',
  `instance` mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for gm_tickets
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=5462 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for group_instance
-- ----------------------------
DROP TABLE IF EXISTS `group_instance`;
CREATE TABLE `group_instance` (
  `leaderGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `instance` int(11) unsigned NOT NULL DEFAULT '0',
  `permanent` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`leaderGuid`,`instance`),
  KEY `instance` (`instance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for group_member
-- ----------------------------
DROP TABLE IF EXISTS `group_member`;
CREATE TABLE `group_member` (
  `leaderGuid` int(11) unsigned NOT NULL,
  `memberGuid` int(11) unsigned NOT NULL,
  `assistant` tinyint(1) unsigned NOT NULL,
  `subgroup` smallint(6) unsigned NOT NULL,
  PRIMARY KEY (`leaderGuid`,`memberGuid`),
  KEY `memberGuid` (`memberGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for group_saved_loot
-- ----------------------------
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

-- ----------------------------
-- Table structure for groups
-- ----------------------------
DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `leaderGuid` int(11) unsigned NOT NULL,
  `mainTank` int(11) unsigned NOT NULL,
  `mainAssistant` int(11) unsigned NOT NULL,
  `lootMethod` tinyint(4) unsigned NOT NULL,
  `looterGuid` int(11) unsigned NOT NULL,
  `lootThreshold` tinyint(4) unsigned NOT NULL,
  `icon1` int(11) unsigned NOT NULL,
  `icon2` int(11) unsigned NOT NULL,
  `icon3` int(11) unsigned NOT NULL,
  `icon4` int(11) unsigned NOT NULL,
  `icon5` int(11) unsigned NOT NULL,
  `icon6` int(11) unsigned NOT NULL,
  `icon7` int(11) unsigned NOT NULL,
  `icon8` int(11) unsigned NOT NULL,
  `isRaid` tinyint(1) unsigned NOT NULL,
  `difficulty` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`leaderGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild
-- ----------------------------
DROP TABLE IF EXISTS `guild`;
CREATE TABLE `guild` (
  `guildid` int(6) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `leaderguid` int(6) unsigned NOT NULL DEFAULT '0',
  `EmblemStyle` int(5) NOT NULL DEFAULT '0',
  `EmblemColor` int(5) NOT NULL DEFAULT '0',
  `BorderStyle` int(5) NOT NULL DEFAULT '0',
  `BorderColor` int(5) NOT NULL DEFAULT '0',
  `BackgroundColor` int(5) NOT NULL DEFAULT '0',
  `info` text NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `createdate` datetime DEFAULT NULL,
  `BankMoney` bigint(20) NOT NULL DEFAULT '0',
  `xp` int(10) NOT NULL DEFAULT '0',
  `level` tinyint(3) NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_announce_cooldown
-- ----------------------------
DROP TABLE IF EXISTS `guild_announce_cooldown`;
CREATE TABLE `guild_announce_cooldown` (
  `guild_id` int(10) unsigned NOT NULL,
  `cooldown_end` bigint(20) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_bank_eventlog
-- ----------------------------
DROP TABLE IF EXISTS `guild_bank_eventlog`;
CREATE TABLE `guild_bank_eventlog` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `LogGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `LogEntry` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `PlayerGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `ItemOrMoney` int(11) unsigned NOT NULL DEFAULT '0',
  `ItemStackCount` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `DestTabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TimeStamp` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `PlayerGuid` (`PlayerGuid`),
  KEY `LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_bank_item
-- ----------------------------
DROP TABLE IF EXISTS `guild_bank_item`;
CREATE TABLE `guild_bank_item` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `SlotId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `item_guid` int(11) unsigned NOT NULL DEFAULT '0',
  `item_entry` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`TabId`,`SlotId`),
  KEY `guildid` (`guildid`),
  KEY `item_guid` (`item_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_bank_right
-- ----------------------------
DROP TABLE IF EXISTS `guild_bank_right`;
CREATE TABLE `guild_bank_right` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `rid` int(11) unsigned NOT NULL DEFAULT '0',
  `gbright` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SlotPerDay` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`TabId`,`rid`),
  KEY `guildid` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_bank_tab
-- ----------------------------
DROP TABLE IF EXISTS `guild_bank_tab`;
CREATE TABLE `guild_bank_tab` (
  `guildid` int(11) unsigned NOT NULL DEFAULT '0',
  `TabId` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `TabName` varchar(100) NOT NULL DEFAULT '',
  `TabIcon` varchar(100) NOT NULL DEFAULT '',
  `TabText` text,
  PRIMARY KEY (`guildid`,`TabId`),
  KEY `guildid` (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_bonus_config
-- ----------------------------
DROP TABLE IF EXISTS `guild_bonus_config`;
CREATE TABLE `guild_bonus_config` (
  `BonusId` smallint(5) NOT NULL DEFAULT '0',
  `RequiredGuildLevel` tinyint(3) NOT NULL DEFAULT '0',
  `comment` longtext CHARACTER SET utf8
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for guild_eventlog
-- ----------------------------
DROP TABLE IF EXISTS `guild_eventlog`;
CREATE TABLE `guild_eventlog` (
  `guildid` int(11) NOT NULL,
  `LogGuid` int(11) NOT NULL,
  `EventType` tinyint(1) NOT NULL,
  `PlayerGuid1` int(11) NOT NULL,
  `PlayerGuid2` int(11) NOT NULL,
  `NewRank` tinyint(2) NOT NULL,
  `TimeStamp` bigint(20) NOT NULL,
  PRIMARY KEY (`guildid`,`LogGuid`),
  KEY `PlayerGuid1` (`PlayerGuid1`),
  KEY `PlayerGuid2` (`PlayerGuid2`),
  KEY `LogGuid` (`LogGuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_member
-- ----------------------------
DROP TABLE IF EXISTS `guild_member`;
CREATE TABLE `guild_member` (
  `guildid` int(6) unsigned NOT NULL DEFAULT '0',
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `rank` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `pnote` varchar(255) NOT NULL DEFAULT '',
  `offnote` varchar(255) NOT NULL DEFAULT '',
  `BankResetTimeMoney` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemMoney` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab0` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab0` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab1` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab1` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab2` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab2` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab3` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab3` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab4` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab4` int(11) unsigned NOT NULL DEFAULT '0',
  `BankResetTimeTab5` int(11) unsigned NOT NULL DEFAULT '0',
  `BankRemSlotsTab5` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`),
  KEY `guildid` (`guildid`),
  KEY `guildid_rank` (`guildid`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_rank
-- ----------------------------
DROP TABLE IF EXISTS `guild_rank`;
CREATE TABLE `guild_rank` (
  `guildid` int(6) unsigned NOT NULL DEFAULT '0',
  `rid` int(11) unsigned NOT NULL,
  `rname` varchar(255) NOT NULL DEFAULT '',
  `rights` int(3) unsigned NOT NULL DEFAULT '0',
  `BankMoneyPerDay` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for guild_xp_for_next_level
-- ----------------------------
DROP TABLE IF EXISTS `guild_xp_for_next_level`;
CREATE TABLE `guild_xp_for_next_level` (
  `level` tinyint(3) NOT NULL DEFAULT '0',
  `xp_for_next_level` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for hidden_rating
-- ----------------------------
DROP TABLE IF EXISTS `hidden_rating`;
CREATE TABLE `hidden_rating` (
  `guid` int(11) unsigned NOT NULL,
  `rating2` int(10) unsigned NOT NULL DEFAULT '1500',
  `rating3` int(10) unsigned NOT NULL DEFAULT '1500',
  `rating5` int(10) unsigned NOT NULL DEFAULT '1500',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for instance
-- ----------------------------
DROP TABLE IF EXISTS `instance`;
CREATE TABLE `instance` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `map` int(11) unsigned NOT NULL DEFAULT '0',
  `resettime` bigint(40) NOT NULL DEFAULT '0',
  `difficulty` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  PRIMARY KEY (`id`),
  KEY `map` (`map`),
  KEY `resettime` (`resettime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for instance_reset
-- ----------------------------
DROP TABLE IF EXISTS `instance_reset`;
CREATE TABLE `instance_reset` (
  `mapid` int(11) unsigned NOT NULL DEFAULT '0',
  `resettime` bigint(40) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for item_instance
-- ----------------------------
DROP TABLE IF EXISTS `item_instance`;
CREATE TABLE `item_instance` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `owner_guid` int(11) unsigned NOT NULL DEFAULT '0',
  `data` longtext,
  PRIMARY KEY (`guid`),
  KEY `owner_guid` (`owner_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for item_template
-- ----------------------------
DROP TABLE IF EXISTS `item_template`;
CREATE TABLE `item_template` (
  `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `class` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `subclass` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `unk0` int(11) NOT NULL DEFAULT '-1',
  `name` varchar(255) NOT NULL DEFAULT '',
  `displayid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Quality` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `Flags` int(10) unsigned NOT NULL DEFAULT '0',
  `BuyCount` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `BuyPrice` int(10) unsigned NOT NULL DEFAULT '0',
  `SellPrice` int(10) unsigned NOT NULL DEFAULT '0',
  `InventoryType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `AllowableClass` mediumint(9) NOT NULL DEFAULT '-1',
  `AllowableRace` mediumint(9) NOT NULL DEFAULT '-1',
  `ItemLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RequiredSkill` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredSkillRank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `requiredspell` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `requiredhonorrank` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RequiredCityRank` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationFaction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `RequiredReputationRank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `maxcount` smallint(5) unsigned NOT NULL DEFAULT '0',
  `stackable` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ContainerSlots` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_type1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value1` smallint(6) NOT NULL DEFAULT '0',
  `stat_type2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value2` smallint(6) NOT NULL DEFAULT '0',
  `stat_type3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value3` smallint(6) NOT NULL DEFAULT '0',
  `stat_type4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value4` smallint(6) NOT NULL DEFAULT '0',
  `stat_type5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value5` smallint(6) NOT NULL DEFAULT '0',
  `stat_type6` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value6` smallint(6) NOT NULL DEFAULT '0',
  `stat_type7` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value7` smallint(6) NOT NULL DEFAULT '0',
  `stat_type8` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value8` smallint(6) NOT NULL DEFAULT '0',
  `stat_type9` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value9` smallint(6) NOT NULL DEFAULT '0',
  `stat_type10` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stat_value10` smallint(6) NOT NULL DEFAULT '0',
  `dmg_min1` float NOT NULL DEFAULT '0',
  `dmg_max1` float NOT NULL DEFAULT '0',
  `dmg_type1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min2` float NOT NULL DEFAULT '0',
  `dmg_max2` float NOT NULL DEFAULT '0',
  `dmg_type2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min3` float NOT NULL DEFAULT '0',
  `dmg_max3` float NOT NULL DEFAULT '0',
  `dmg_type3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min4` float NOT NULL DEFAULT '0',
  `dmg_max4` float NOT NULL DEFAULT '0',
  `dmg_type4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `dmg_min5` float NOT NULL DEFAULT '0',
  `dmg_max5` float NOT NULL DEFAULT '0',
  `dmg_type5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `armor` smallint(5) unsigned NOT NULL DEFAULT '0',
  `holy_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fire_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `nature_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `frost_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `shadow_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `arcane_res` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `delay` smallint(5) unsigned NOT NULL DEFAULT '1000',
  `ammo_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RangedModRange` float NOT NULL DEFAULT '0',
  `spellid_1` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_1` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_1` float NOT NULL DEFAULT '0',
  `spellcooldown_1` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_1` int(11) NOT NULL DEFAULT '-1',
  `spellid_2` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_2` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_2` float NOT NULL DEFAULT '0',
  `spellcooldown_2` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_2` int(11) NOT NULL DEFAULT '-1',
  `spellid_3` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_3` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_3` float NOT NULL DEFAULT '0',
  `spellcooldown_3` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_3` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_3` int(11) NOT NULL DEFAULT '-1',
  `spellid_4` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_4` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_4` float NOT NULL DEFAULT '0',
  `spellcooldown_4` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_4` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_4` int(11) NOT NULL DEFAULT '-1',
  `spellid_5` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `spelltrigger_5` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellcharges_5` tinyint(4) NOT NULL DEFAULT '0',
  `spellppmRate_5` float NOT NULL DEFAULT '0',
  `spellcooldown_5` int(11) NOT NULL DEFAULT '-1',
  `spellcategory_5` smallint(5) unsigned NOT NULL DEFAULT '0',
  `spellcategorycooldown_5` int(11) NOT NULL DEFAULT '-1',
  `bonding` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL DEFAULT '',
  `PageText` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `LanguageID` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `PageMaterial` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `startquest` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `lockid` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Material` tinyint(4) NOT NULL DEFAULT '0',
  `sheath` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `RandomProperty` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `RandomSuffix` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `block` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `itemset` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `MaxDurability` smallint(5) unsigned NOT NULL DEFAULT '0',
  `area` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `Map` smallint(6) NOT NULL DEFAULT '0',
  `BagFamily` mediumint(9) NOT NULL DEFAULT '0',
  `TotemCategory` tinyint(4) NOT NULL DEFAULT '0',
  `socketColor_1` tinyint(4) NOT NULL DEFAULT '0',
  `socketContent_1` mediumint(9) NOT NULL DEFAULT '0',
  `socketColor_2` tinyint(4) NOT NULL DEFAULT '0',
  `socketContent_2` mediumint(9) NOT NULL DEFAULT '0',
  `socketColor_3` tinyint(4) NOT NULL DEFAULT '0',
  `socketContent_3` mediumint(9) NOT NULL DEFAULT '0',
  `socketBonus` mediumint(9) NOT NULL DEFAULT '0',
  `GemProperties` mediumint(9) NOT NULL DEFAULT '0',
  `RequiredDisenchantSkill` smallint(6) NOT NULL DEFAULT '-1',
  `ArmorDamageModifier` float NOT NULL DEFAULT '0',
  `ScriptName` varchar(64) NOT NULL DEFAULT '',
  `DisenchantID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `FoodType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `minMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0',
  `maxMoneyLoot` int(10) unsigned NOT NULL DEFAULT '0',
  `Duration` int(11) NOT NULL DEFAULT '0' COMMENT 'Duration in seconds. Negative value means realtime, postive value ingame time',
  PRIMARY KEY (`entry`),
  KEY `idx_name` (`name`),
  KEY `items_index` (`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Item System';

-- ----------------------------
-- Table structure for item_text
-- ----------------------------
DROP TABLE IF EXISTS `item_text`;
CREATE TABLE `item_text` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `text` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mail
-- ----------------------------
DROP TABLE IF EXISTS `mail`;
CREATE TABLE `mail` (
  `id` int(11) unsigned NOT NULL DEFAULT '0',
  `messageType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `stationery` tinyint(3) NOT NULL DEFAULT '41',
  `mailTemplateId` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `sender` int(11) unsigned NOT NULL DEFAULT '0',
  `receiver` int(11) unsigned NOT NULL DEFAULT '0',
  `subject` longtext,
  `itemTextId` int(11) unsigned NOT NULL DEFAULT '0',
  `has_items` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `expire_time` bigint(40) NOT NULL DEFAULT '0',
  `deliver_time` bigint(40) NOT NULL DEFAULT '0',
  `money` int(11) unsigned NOT NULL DEFAULT '0',
  `cod` int(11) unsigned NOT NULL DEFAULT '0',
  `checked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mail_external
-- ----------------------------
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

-- ----------------------------
-- Table structure for mail_items
-- ----------------------------
DROP TABLE IF EXISTS `mail_items`;
CREATE TABLE `mail_items` (
  `mail_id` int(11) NOT NULL DEFAULT '0',
  `item_guid` int(11) NOT NULL DEFAULT '0',
  `item_template` int(11) NOT NULL DEFAULT '0',
  `receiver` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`mail_id`,`item_guid`),
  KEY `receiver` (`receiver`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for map_template
-- ----------------------------
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

-- ----------------------------
-- Table structure for online_history
-- ----------------------------
DROP TABLE IF EXISTS `online_history`;
CREATE TABLE `online_history` (
  `id` bigint(100) unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `online_count` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for opcodes_cooldown
-- ----------------------------
DROP TABLE IF EXISTS `opcodes_cooldown`;
CREATE TABLE `opcodes_cooldown` (
  `opcode` varchar(20) NOT NULL COMMENT 'Opcode name',
  `cooldown` int(4) unsigned DEFAULT '1000' COMMENT 'Opcode cooldown',
  PRIMARY KEY (`opcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pet_aura
-- ----------------------------
DROP TABLE IF EXISTS `pet_aura`;
CREATE TABLE `pet_aura` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `caster_guid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `effect_index` int(11) unsigned NOT NULL DEFAULT '0',
  `stackcount` int(11) NOT NULL DEFAULT '1',
  `amount` int(11) NOT NULL DEFAULT '0',
  `maxduration` int(11) NOT NULL DEFAULT '0',
  `remaintime` int(11) NOT NULL DEFAULT '0',
  `remaincharges` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`,`effect_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pet_spell
-- ----------------------------
DROP TABLE IF EXISTS `pet_spell`;
CREATE TABLE `pet_spell` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `slot` int(11) unsigned NOT NULL DEFAULT '0',
  `active` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pet_spell_cooldown
-- ----------------------------
DROP TABLE IF EXISTS `pet_spell_cooldown`;
CREATE TABLE `pet_spell_cooldown` (
  `guid` int(11) unsigned NOT NULL DEFAULT '0',
  `spell` int(11) unsigned NOT NULL DEFAULT '0',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for petition
-- ----------------------------
DROP TABLE IF EXISTS `petition`;
CREATE TABLE `petition` (
  `ownerguid` int(10) unsigned NOT NULL,
  `petitionguid` int(10) unsigned DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ownerguid`,`type`),
  UNIQUE KEY `ownerguid_petitionguid` (`ownerguid`,`petitionguid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for petition_sign
-- ----------------------------
DROP TABLE IF EXISTS `petition_sign`;
CREATE TABLE `petition_sign` (
  `ownerguid` int(10) unsigned NOT NULL,
  `petitionguid` int(11) unsigned NOT NULL DEFAULT '0',
  `playerguid` int(11) unsigned NOT NULL DEFAULT '0',
  `player_account` int(11) unsigned NOT NULL DEFAULT '0',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`petitionguid`,`playerguid`)
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
) ENGINE=InnoDB AUTO_INCREMENT=14943333 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=4240 DEFAULT CHARSET=latin1;

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
-- Table structure for race_change_skins
-- ----------------------------
DROP TABLE IF EXISTS `race_change_skins`;
CREATE TABLE `race_change_skins` (
  `race` tinyint(4) NOT NULL,
  `gender` tinyint(4) NOT NULL,
  `skin1` int(11) NOT NULL,
  `skin2` int(11) NOT NULL,
  `skin3` int(11) NOT NULL,
  PRIMARY KEY (`race`,`gender`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for race_change_spells
-- ----------------------------
DROP TABLE IF EXISTS `race_change_spells`;
CREATE TABLE `race_change_spells` (
  `race` tinyint(3) unsigned NOT NULL,
  `class` tinyint(3) unsigned NOT NULL,
  `spell` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`race`,`class`,`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for reserved_name
-- ----------------------------
DROP TABLE IF EXISTS `reserved_name`;
CREATE TABLE `reserved_name` (
  `name` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Player Reserved Names';

-- ----------------------------
-- Table structure for saved_variables
-- ----------------------------
DROP TABLE IF EXISTS `saved_variables`;
CREATE TABLE `saved_variables` (
  `NextArenaPointDistributionTime` bigint(40) unsigned NOT NULL DEFAULT '0',
  `HeroicQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `NormalQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `CookingQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `FishingQuest` int(5) unsigned NOT NULL DEFAULT '0',
  `PVPAlliance` int(5) unsigned NOT NULL DEFAULT '0',
  `PVPHorde` int(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for spell_disabled
-- ----------------------------
DROP TABLE IF EXISTS `spell_disabled`;
CREATE TABLE `spell_disabled` (
  `entry` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Spell entry',
  `disable_mask` int(8) unsigned NOT NULL DEFAULT '0',
  `comment` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='Disabled Spell System';

-- ----------------------------
-- Table structure for temp_skills
-- ----------------------------
DROP TABLE IF EXISTS `temp_skills`;
CREATE TABLE `temp_skills` (
  `i` int(11) unsigned NOT NULL,
  PRIMARY KEY (`i`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for uptime
-- ----------------------------
DROP TABLE IF EXISTS `uptime`;
CREATE TABLE `uptime` (
  `starttime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `startstring` varchar(64) NOT NULL DEFAULT '',
  `uptime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`starttime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Uptime system';

-- Records
INSERT INTO `game_event_save` VALUES ('36', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('38', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('40', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('42', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('44', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('45', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('46', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('48', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('49', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('50', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('51', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('52', '2', '0000-00-00 00:00:00');
INSERT INTO `game_event_save` VALUES ('53', '3', '2024-11-24 16:06:05');

INSERT INTO `instance_reset` VALUES ('169', '1422590400');
INSERT INTO `instance_reset` VALUES ('249', '1422676800');
INSERT INTO `instance_reset` VALUES ('269', '1422590400');
INSERT INTO `instance_reset` VALUES ('309', '1422676800');
INSERT INTO `instance_reset` VALUES ('409', '1422590400');
INSERT INTO `instance_reset` VALUES ('469', '1422590400');
INSERT INTO `instance_reset` VALUES ('509', '1422676800');
INSERT INTO `instance_reset` VALUES ('531', '1422590400');
INSERT INTO `instance_reset` VALUES ('532', '1423022400');
INSERT INTO `instance_reset` VALUES ('533', '1422590400');
INSERT INTO `instance_reset` VALUES ('534', '1423022400');
INSERT INTO `instance_reset` VALUES ('540', '1422590400');
INSERT INTO `instance_reset` VALUES ('542', '1422590400');
INSERT INTO `instance_reset` VALUES ('543', '1422590400');
INSERT INTO `instance_reset` VALUES ('544', '1423022400');
INSERT INTO `instance_reset` VALUES ('545', '1422590400');
INSERT INTO `instance_reset` VALUES ('546', '1422590400');
INSERT INTO `instance_reset` VALUES ('547', '1422590400');
INSERT INTO `instance_reset` VALUES ('548', '1423022400');
INSERT INTO `instance_reset` VALUES ('550', '1423022400');
INSERT INTO `instance_reset` VALUES ('552', '1422590400');
INSERT INTO `instance_reset` VALUES ('553', '1422590400');
INSERT INTO `instance_reset` VALUES ('554', '1422590400');
INSERT INTO `instance_reset` VALUES ('555', '1422590400');
INSERT INTO `instance_reset` VALUES ('556', '1422590400');
INSERT INTO `instance_reset` VALUES ('557', '1422590400');
INSERT INTO `instance_reset` VALUES ('558', '1422590400');
INSERT INTO `instance_reset` VALUES ('560', '1422590400');
INSERT INTO `instance_reset` VALUES ('564', '1423022400');
INSERT INTO `instance_reset` VALUES ('565', '1423022400');
INSERT INTO `instance_reset` VALUES ('568', '1423022400');
INSERT INTO `instance_reset` VALUES ('580', '1423022400');
INSERT INTO `instance_reset` VALUES ('585', '1422590400');

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

INSERT INTO `opcodes_cooldown` VALUES ('CMSG_INSPECT', '1000');
INSERT INTO `opcodes_cooldown` VALUES ('CMSG_WHOIS', '1000');

INSERT INTO `race_change_skins` VALUES ('1', '0', '460548', '17106691', '84019200');
INSERT INTO `race_change_skins` VALUES ('1', '1', '919811', '84410882', '151193093');
INSERT INTO `race_change_skins` VALUES ('2', '0', '328449', '33882627', '84083971');
INSERT INTO `race_change_skins` VALUES ('2', '1', '197633', '17170434', '117506307');
INSERT INTO `race_change_skins` VALUES ('3', '0', '33816832', '117770496', '329473');
INSERT INTO `race_change_skins` VALUES ('3', '1', '772', '262662', '33882633');
INSERT INTO `race_change_skins` VALUES ('4', '0', '16843520', '67109123', '117507847');
INSERT INTO `race_change_skins` VALUES ('4', '1', '1544', '67110661', '117441288');
INSERT INTO `race_change_skins` VALUES ('5', '0', '524544', '17369090', '67371012');
INSERT INTO `race_change_skins` VALUES ('5', '1', '198661', '83887620', '151257088');
INSERT INTO `race_change_skins` VALUES ('6', '0', '66048', '458752', '16777743');
INSERT INTO `race_change_skins` VALUES ('6', '1', '262662', '17039625', '33882633');
INSERT INTO `race_change_skins` VALUES ('7', '0', '17104898', '67174401', '117769729');
INSERT INTO `race_change_skins` VALUES ('7', '1', '17040388', '84148480', '134348802');
INSERT INTO `race_change_skins` VALUES ('8', '0', '516', '33620482', '134415364');
INSERT INTO `race_change_skins` VALUES ('8', '1', '33817860', '117572867', '151127299');
INSERT INTO `race_change_skins` VALUES ('10', '0', '262663', '16973833', '33751305');
INSERT INTO `race_change_skins` VALUES ('10', '1', '17105156', '67438340', '101319939');
INSERT INTO `race_change_skins` VALUES ('11', '0', '327691', '33947651', '50726153');
INSERT INTO `race_change_skins` VALUES ('11', '1', '17170950', '67764484', '101058057');


INSERT INTO `race_change_spells` VALUES ('1', '1', '668');
INSERT INTO `race_change_spells` VALUES ('1', '1', '20597');
INSERT INTO `race_change_spells` VALUES ('1', '1', '20598');
INSERT INTO `race_change_spells` VALUES ('1', '1', '20599');
INSERT INTO `race_change_spells` VALUES ('1', '1', '20600');
INSERT INTO `race_change_spells` VALUES ('1', '1', '20864');
INSERT INTO `race_change_spells` VALUES ('1', '2', '668');
INSERT INTO `race_change_spells` VALUES ('1', '2', '20597');
INSERT INTO `race_change_spells` VALUES ('1', '2', '20598');
INSERT INTO `race_change_spells` VALUES ('1', '2', '20599');
INSERT INTO `race_change_spells` VALUES ('1', '2', '20600');
INSERT INTO `race_change_spells` VALUES ('1', '2', '20864');
INSERT INTO `race_change_spells` VALUES ('1', '4', '668');
INSERT INTO `race_change_spells` VALUES ('1', '4', '20597');
INSERT INTO `race_change_spells` VALUES ('1', '4', '20598');
INSERT INTO `race_change_spells` VALUES ('1', '4', '20599');
INSERT INTO `race_change_spells` VALUES ('1', '4', '20600');
INSERT INTO `race_change_spells` VALUES ('1', '4', '20864');
INSERT INTO `race_change_spells` VALUES ('1', '5', '668');
INSERT INTO `race_change_spells` VALUES ('1', '5', '20597');
INSERT INTO `race_change_spells` VALUES ('1', '5', '20598');
INSERT INTO `race_change_spells` VALUES ('1', '5', '20599');
INSERT INTO `race_change_spells` VALUES ('1', '5', '20600');
INSERT INTO `race_change_spells` VALUES ('1', '5', '20864');
INSERT INTO `race_change_spells` VALUES ('1', '8', '668');
INSERT INTO `race_change_spells` VALUES ('1', '8', '20597');
INSERT INTO `race_change_spells` VALUES ('1', '8', '20598');
INSERT INTO `race_change_spells` VALUES ('1', '8', '20599');
INSERT INTO `race_change_spells` VALUES ('1', '8', '20600');
INSERT INTO `race_change_spells` VALUES ('1', '8', '20864');
INSERT INTO `race_change_spells` VALUES ('1', '9', '668');
INSERT INTO `race_change_spells` VALUES ('1', '9', '20597');
INSERT INTO `race_change_spells` VALUES ('1', '9', '20598');
INSERT INTO `race_change_spells` VALUES ('1', '9', '20599');
INSERT INTO `race_change_spells` VALUES ('1', '9', '20600');
INSERT INTO `race_change_spells` VALUES ('1', '9', '20864');
INSERT INTO `race_change_spells` VALUES ('2', '1', '669');
INSERT INTO `race_change_spells` VALUES ('2', '1', '20572');
INSERT INTO `race_change_spells` VALUES ('2', '1', '20573');
INSERT INTO `race_change_spells` VALUES ('2', '1', '20574');
INSERT INTO `race_change_spells` VALUES ('2', '1', '21563');
INSERT INTO `race_change_spells` VALUES ('2', '3', '669');
INSERT INTO `race_change_spells` VALUES ('2', '3', '20572');
INSERT INTO `race_change_spells` VALUES ('2', '3', '20573');
INSERT INTO `race_change_spells` VALUES ('2', '3', '20574');
INSERT INTO `race_change_spells` VALUES ('2', '3', '21563');
INSERT INTO `race_change_spells` VALUES ('2', '4', '669');
INSERT INTO `race_change_spells` VALUES ('2', '4', '20572');
INSERT INTO `race_change_spells` VALUES ('2', '4', '20573');
INSERT INTO `race_change_spells` VALUES ('2', '4', '20574');
INSERT INTO `race_change_spells` VALUES ('2', '4', '21563');
INSERT INTO `race_change_spells` VALUES ('2', '7', '669');
INSERT INTO `race_change_spells` VALUES ('2', '7', '20573');
INSERT INTO `race_change_spells` VALUES ('2', '7', '20574');
INSERT INTO `race_change_spells` VALUES ('2', '7', '21563');
INSERT INTO `race_change_spells` VALUES ('2', '7', '33697');
INSERT INTO `race_change_spells` VALUES ('2', '9', '669');
INSERT INTO `race_change_spells` VALUES ('2', '9', '20573');
INSERT INTO `race_change_spells` VALUES ('2', '9', '20574');
INSERT INTO `race_change_spells` VALUES ('2', '9', '21563');
INSERT INTO `race_change_spells` VALUES ('2', '9', '33702');
INSERT INTO `race_change_spells` VALUES ('3', '1', '668');
INSERT INTO `race_change_spells` VALUES ('3', '1', '672');
INSERT INTO `race_change_spells` VALUES ('3', '1', '2481');
INSERT INTO `race_change_spells` VALUES ('3', '1', '20594');
INSERT INTO `race_change_spells` VALUES ('3', '1', '20595');
INSERT INTO `race_change_spells` VALUES ('3', '1', '20596');
INSERT INTO `race_change_spells` VALUES ('3', '2', '668');
INSERT INTO `race_change_spells` VALUES ('3', '2', '672');
INSERT INTO `race_change_spells` VALUES ('3', '2', '2481');
INSERT INTO `race_change_spells` VALUES ('3', '2', '20594');
INSERT INTO `race_change_spells` VALUES ('3', '2', '20595');
INSERT INTO `race_change_spells` VALUES ('3', '2', '20596');
INSERT INTO `race_change_spells` VALUES ('3', '3', '668');
INSERT INTO `race_change_spells` VALUES ('3', '3', '672');
INSERT INTO `race_change_spells` VALUES ('3', '3', '2481');
INSERT INTO `race_change_spells` VALUES ('3', '3', '20594');
INSERT INTO `race_change_spells` VALUES ('3', '3', '20595');
INSERT INTO `race_change_spells` VALUES ('3', '3', '20596');
INSERT INTO `race_change_spells` VALUES ('3', '4', '668');
INSERT INTO `race_change_spells` VALUES ('3', '4', '672');
INSERT INTO `race_change_spells` VALUES ('3', '4', '2481');
INSERT INTO `race_change_spells` VALUES ('3', '4', '20594');
INSERT INTO `race_change_spells` VALUES ('3', '4', '20595');
INSERT INTO `race_change_spells` VALUES ('3', '4', '20596');
INSERT INTO `race_change_spells` VALUES ('3', '5', '668');
INSERT INTO `race_change_spells` VALUES ('3', '5', '672');
INSERT INTO `race_change_spells` VALUES ('3', '5', '2481');
INSERT INTO `race_change_spells` VALUES ('3', '5', '20594');
INSERT INTO `race_change_spells` VALUES ('3', '5', '20595');
INSERT INTO `race_change_spells` VALUES ('3', '5', '20596');
INSERT INTO `race_change_spells` VALUES ('4', '1', '668');
INSERT INTO `race_change_spells` VALUES ('4', '1', '671');
INSERT INTO `race_change_spells` VALUES ('4', '1', '20580');
INSERT INTO `race_change_spells` VALUES ('4', '1', '20582');
INSERT INTO `race_change_spells` VALUES ('4', '1', '20583');
INSERT INTO `race_change_spells` VALUES ('4', '1', '20585');
INSERT INTO `race_change_spells` VALUES ('4', '1', '21009');
INSERT INTO `race_change_spells` VALUES ('4', '3', '668');
INSERT INTO `race_change_spells` VALUES ('4', '3', '671');
INSERT INTO `race_change_spells` VALUES ('4', '3', '20580');
INSERT INTO `race_change_spells` VALUES ('4', '3', '20582');
INSERT INTO `race_change_spells` VALUES ('4', '3', '20583');
INSERT INTO `race_change_spells` VALUES ('4', '3', '20585');
INSERT INTO `race_change_spells` VALUES ('4', '3', '21009');
INSERT INTO `race_change_spells` VALUES ('4', '4', '668');
INSERT INTO `race_change_spells` VALUES ('4', '4', '671');
INSERT INTO `race_change_spells` VALUES ('4', '4', '20580');
INSERT INTO `race_change_spells` VALUES ('4', '4', '20582');
INSERT INTO `race_change_spells` VALUES ('4', '4', '20583');
INSERT INTO `race_change_spells` VALUES ('4', '4', '20585');
INSERT INTO `race_change_spells` VALUES ('4', '4', '21009');
INSERT INTO `race_change_spells` VALUES ('4', '5', '668');
INSERT INTO `race_change_spells` VALUES ('4', '5', '671');
INSERT INTO `race_change_spells` VALUES ('4', '5', '20580');
INSERT INTO `race_change_spells` VALUES ('4', '5', '20582');
INSERT INTO `race_change_spells` VALUES ('4', '5', '20583');
INSERT INTO `race_change_spells` VALUES ('4', '5', '20585');
INSERT INTO `race_change_spells` VALUES ('4', '5', '21009');
INSERT INTO `race_change_spells` VALUES ('4', '11', '668');
INSERT INTO `race_change_spells` VALUES ('4', '11', '671');
INSERT INTO `race_change_spells` VALUES ('4', '11', '20580');
INSERT INTO `race_change_spells` VALUES ('4', '11', '20582');
INSERT INTO `race_change_spells` VALUES ('4', '11', '20583');
INSERT INTO `race_change_spells` VALUES ('4', '11', '20585');
INSERT INTO `race_change_spells` VALUES ('4', '11', '21009');
INSERT INTO `race_change_spells` VALUES ('5', '1', '669');
INSERT INTO `race_change_spells` VALUES ('5', '1', '5227');
INSERT INTO `race_change_spells` VALUES ('5', '1', '7744');
INSERT INTO `race_change_spells` VALUES ('5', '1', '17737');
INSERT INTO `race_change_spells` VALUES ('5', '1', '20577');
INSERT INTO `race_change_spells` VALUES ('5', '1', '20579');
INSERT INTO `race_change_spells` VALUES ('5', '4', '669');
INSERT INTO `race_change_spells` VALUES ('5', '4', '5227');
INSERT INTO `race_change_spells` VALUES ('5', '4', '7744');
INSERT INTO `race_change_spells` VALUES ('5', '4', '17737');
INSERT INTO `race_change_spells` VALUES ('5', '4', '20577');
INSERT INTO `race_change_spells` VALUES ('5', '4', '20579');
INSERT INTO `race_change_spells` VALUES ('5', '5', '669');
INSERT INTO `race_change_spells` VALUES ('5', '5', '5227');
INSERT INTO `race_change_spells` VALUES ('5', '5', '7744');
INSERT INTO `race_change_spells` VALUES ('5', '5', '17737');
INSERT INTO `race_change_spells` VALUES ('5', '5', '20577');
INSERT INTO `race_change_spells` VALUES ('5', '5', '20579');
INSERT INTO `race_change_spells` VALUES ('5', '8', '669');
INSERT INTO `race_change_spells` VALUES ('5', '8', '5227');
INSERT INTO `race_change_spells` VALUES ('5', '8', '7744');
INSERT INTO `race_change_spells` VALUES ('5', '8', '17737');
INSERT INTO `race_change_spells` VALUES ('5', '8', '20577');
INSERT INTO `race_change_spells` VALUES ('5', '8', '20579');
INSERT INTO `race_change_spells` VALUES ('5', '9', '669');
INSERT INTO `race_change_spells` VALUES ('5', '9', '5227');
INSERT INTO `race_change_spells` VALUES ('5', '9', '7744');
INSERT INTO `race_change_spells` VALUES ('5', '9', '17737');
INSERT INTO `race_change_spells` VALUES ('5', '9', '20577');
INSERT INTO `race_change_spells` VALUES ('5', '9', '20579');
INSERT INTO `race_change_spells` VALUES ('6', '1', '669');
INSERT INTO `race_change_spells` VALUES ('6', '1', '670');
INSERT INTO `race_change_spells` VALUES ('6', '1', '20549');
INSERT INTO `race_change_spells` VALUES ('6', '1', '20550');
INSERT INTO `race_change_spells` VALUES ('6', '1', '20551');
INSERT INTO `race_change_spells` VALUES ('6', '1', '20552');
INSERT INTO `race_change_spells` VALUES ('6', '3', '669');
INSERT INTO `race_change_spells` VALUES ('6', '3', '670');
INSERT INTO `race_change_spells` VALUES ('6', '3', '20549');
INSERT INTO `race_change_spells` VALUES ('6', '3', '20550');
INSERT INTO `race_change_spells` VALUES ('6', '3', '20551');
INSERT INTO `race_change_spells` VALUES ('6', '3', '20552');
INSERT INTO `race_change_spells` VALUES ('6', '7', '669');
INSERT INTO `race_change_spells` VALUES ('6', '7', '670');
INSERT INTO `race_change_spells` VALUES ('6', '7', '20549');
INSERT INTO `race_change_spells` VALUES ('6', '7', '20550');
INSERT INTO `race_change_spells` VALUES ('6', '7', '20551');
INSERT INTO `race_change_spells` VALUES ('6', '7', '20552');
INSERT INTO `race_change_spells` VALUES ('6', '11', '669');
INSERT INTO `race_change_spells` VALUES ('6', '11', '670');
INSERT INTO `race_change_spells` VALUES ('6', '11', '20549');
INSERT INTO `race_change_spells` VALUES ('6', '11', '20550');
INSERT INTO `race_change_spells` VALUES ('6', '11', '20551');
INSERT INTO `race_change_spells` VALUES ('6', '11', '20552');
INSERT INTO `race_change_spells` VALUES ('7', '1', '668');
INSERT INTO `race_change_spells` VALUES ('7', '1', '7340');
INSERT INTO `race_change_spells` VALUES ('7', '1', '20589');
INSERT INTO `race_change_spells` VALUES ('7', '1', '20591');
INSERT INTO `race_change_spells` VALUES ('7', '1', '20592');
INSERT INTO `race_change_spells` VALUES ('7', '1', '20593');
INSERT INTO `race_change_spells` VALUES ('7', '4', '668');
INSERT INTO `race_change_spells` VALUES ('7', '4', '7340');
INSERT INTO `race_change_spells` VALUES ('7', '4', '20589');
INSERT INTO `race_change_spells` VALUES ('7', '4', '20591');
INSERT INTO `race_change_spells` VALUES ('7', '4', '20592');
INSERT INTO `race_change_spells` VALUES ('7', '4', '20593');
INSERT INTO `race_change_spells` VALUES ('7', '8', '668');
INSERT INTO `race_change_spells` VALUES ('7', '8', '7340');
INSERT INTO `race_change_spells` VALUES ('7', '8', '20589');
INSERT INTO `race_change_spells` VALUES ('7', '8', '20591');
INSERT INTO `race_change_spells` VALUES ('7', '8', '20592');
INSERT INTO `race_change_spells` VALUES ('7', '8', '20593');
INSERT INTO `race_change_spells` VALUES ('7', '9', '668');
INSERT INTO `race_change_spells` VALUES ('7', '9', '7340');
INSERT INTO `race_change_spells` VALUES ('7', '9', '20589');
INSERT INTO `race_change_spells` VALUES ('7', '9', '20591');
INSERT INTO `race_change_spells` VALUES ('7', '9', '20592');
INSERT INTO `race_change_spells` VALUES ('7', '9', '20593');
INSERT INTO `race_change_spells` VALUES ('8', '1', '669');
INSERT INTO `race_change_spells` VALUES ('8', '1', '7341');
INSERT INTO `race_change_spells` VALUES ('8', '1', '20555');
INSERT INTO `race_change_spells` VALUES ('8', '1', '20557');
INSERT INTO `race_change_spells` VALUES ('8', '1', '20558');
INSERT INTO `race_change_spells` VALUES ('8', '1', '26290');
INSERT INTO `race_change_spells` VALUES ('8', '1', '26296');
INSERT INTO `race_change_spells` VALUES ('8', '3', '669');
INSERT INTO `race_change_spells` VALUES ('8', '3', '7341');
INSERT INTO `race_change_spells` VALUES ('8', '3', '20554');
INSERT INTO `race_change_spells` VALUES ('8', '3', '20555');
INSERT INTO `race_change_spells` VALUES ('8', '3', '20557');
INSERT INTO `race_change_spells` VALUES ('8', '3', '20558');
INSERT INTO `race_change_spells` VALUES ('8', '3', '26290');
INSERT INTO `race_change_spells` VALUES ('8', '4', '669');
INSERT INTO `race_change_spells` VALUES ('8', '4', '7341');
INSERT INTO `race_change_spells` VALUES ('8', '4', '20555');
INSERT INTO `race_change_spells` VALUES ('8', '4', '20557');
INSERT INTO `race_change_spells` VALUES ('8', '4', '20558');
INSERT INTO `race_change_spells` VALUES ('8', '4', '26290');
INSERT INTO `race_change_spells` VALUES ('8', '4', '26297');
INSERT INTO `race_change_spells` VALUES ('8', '5', '669');
INSERT INTO `race_change_spells` VALUES ('8', '5', '7341');
INSERT INTO `race_change_spells` VALUES ('8', '5', '20554');
INSERT INTO `race_change_spells` VALUES ('8', '5', '20555');
INSERT INTO `race_change_spells` VALUES ('8', '5', '20557');
INSERT INTO `race_change_spells` VALUES ('8', '5', '20558');
INSERT INTO `race_change_spells` VALUES ('8', '5', '26290');
INSERT INTO `race_change_spells` VALUES ('8', '7', '669');
INSERT INTO `race_change_spells` VALUES ('8', '7', '7341');
INSERT INTO `race_change_spells` VALUES ('8', '7', '20554');
INSERT INTO `race_change_spells` VALUES ('8', '7', '20555');
INSERT INTO `race_change_spells` VALUES ('8', '7', '20557');
INSERT INTO `race_change_spells` VALUES ('8', '7', '20558');
INSERT INTO `race_change_spells` VALUES ('8', '7', '26290');
INSERT INTO `race_change_spells` VALUES ('8', '8', '669');
INSERT INTO `race_change_spells` VALUES ('8', '8', '7341');
INSERT INTO `race_change_spells` VALUES ('8', '8', '20554');
INSERT INTO `race_change_spells` VALUES ('8', '8', '20555');
INSERT INTO `race_change_spells` VALUES ('8', '8', '20557');
INSERT INTO `race_change_spells` VALUES ('8', '8', '20558');
INSERT INTO `race_change_spells` VALUES ('8', '8', '26290');
INSERT INTO `race_change_spells` VALUES ('10', '2', '669');
INSERT INTO `race_change_spells` VALUES ('10', '2', '813');
INSERT INTO `race_change_spells` VALUES ('10', '2', '822');
INSERT INTO `race_change_spells` VALUES ('10', '2', '28730');
INSERT INTO `race_change_spells` VALUES ('10', '2', '28734');
INSERT INTO `race_change_spells` VALUES ('10', '2', '28877');
INSERT INTO `race_change_spells` VALUES ('10', '3', '669');
INSERT INTO `race_change_spells` VALUES ('10', '3', '813');
INSERT INTO `race_change_spells` VALUES ('10', '3', '822');
INSERT INTO `race_change_spells` VALUES ('10', '3', '28730');
INSERT INTO `race_change_spells` VALUES ('10', '3', '28734');
INSERT INTO `race_change_spells` VALUES ('10', '3', '28877');
INSERT INTO `race_change_spells` VALUES ('10', '4', '669');
INSERT INTO `race_change_spells` VALUES ('10', '4', '813');
INSERT INTO `race_change_spells` VALUES ('10', '4', '822');
INSERT INTO `race_change_spells` VALUES ('10', '4', '25046');
INSERT INTO `race_change_spells` VALUES ('10', '4', '28734');
INSERT INTO `race_change_spells` VALUES ('10', '4', '28877');
INSERT INTO `race_change_spells` VALUES ('10', '5', '669');
INSERT INTO `race_change_spells` VALUES ('10', '5', '813');
INSERT INTO `race_change_spells` VALUES ('10', '5', '822');
INSERT INTO `race_change_spells` VALUES ('10', '5', '28730');
INSERT INTO `race_change_spells` VALUES ('10', '5', '28734');
INSERT INTO `race_change_spells` VALUES ('10', '5', '28877');
INSERT INTO `race_change_spells` VALUES ('10', '8', '669');
INSERT INTO `race_change_spells` VALUES ('10', '8', '813');
INSERT INTO `race_change_spells` VALUES ('10', '8', '822');
INSERT INTO `race_change_spells` VALUES ('10', '8', '28730');
INSERT INTO `race_change_spells` VALUES ('10', '8', '28734');
INSERT INTO `race_change_spells` VALUES ('10', '8', '28877');
INSERT INTO `race_change_spells` VALUES ('10', '9', '669');
INSERT INTO `race_change_spells` VALUES ('10', '9', '813');
INSERT INTO `race_change_spells` VALUES ('10', '9', '822');
INSERT INTO `race_change_spells` VALUES ('10', '9', '28730');
INSERT INTO `race_change_spells` VALUES ('10', '9', '28734');
INSERT INTO `race_change_spells` VALUES ('10', '9', '28877');
INSERT INTO `race_change_spells` VALUES ('11', '1', '668');
INSERT INTO `race_change_spells` VALUES ('11', '1', '6562');
INSERT INTO `race_change_spells` VALUES ('11', '1', '20579');
INSERT INTO `race_change_spells` VALUES ('11', '1', '28875');
INSERT INTO `race_change_spells` VALUES ('11', '1', '28880');
INSERT INTO `race_change_spells` VALUES ('11', '1', '29932');
INSERT INTO `race_change_spells` VALUES ('11', '2', '668');
INSERT INTO `race_change_spells` VALUES ('11', '2', '6562');
INSERT INTO `race_change_spells` VALUES ('11', '2', '20579');
INSERT INTO `race_change_spells` VALUES ('11', '2', '28875');
INSERT INTO `race_change_spells` VALUES ('11', '2', '28880');
INSERT INTO `race_change_spells` VALUES ('11', '2', '29932');
INSERT INTO `race_change_spells` VALUES ('11', '3', '668');
INSERT INTO `race_change_spells` VALUES ('11', '3', '6562');
INSERT INTO `race_change_spells` VALUES ('11', '3', '20579');
INSERT INTO `race_change_spells` VALUES ('11', '3', '28875');
INSERT INTO `race_change_spells` VALUES ('11', '3', '28880');
INSERT INTO `race_change_spells` VALUES ('11', '3', '29932');
INSERT INTO `race_change_spells` VALUES ('11', '5', '668');
INSERT INTO `race_change_spells` VALUES ('11', '5', '20579');
INSERT INTO `race_change_spells` VALUES ('11', '5', '28875');
INSERT INTO `race_change_spells` VALUES ('11', '5', '28878');
INSERT INTO `race_change_spells` VALUES ('11', '5', '28880');
INSERT INTO `race_change_spells` VALUES ('11', '5', '29932');
INSERT INTO `race_change_spells` VALUES ('11', '7', '668');
INSERT INTO `race_change_spells` VALUES ('11', '7', '20579');
INSERT INTO `race_change_spells` VALUES ('11', '7', '28875');
INSERT INTO `race_change_spells` VALUES ('11', '7', '28878');
INSERT INTO `race_change_spells` VALUES ('11', '7', '28880');
INSERT INTO `race_change_spells` VALUES ('11', '7', '29932');
INSERT INTO `race_change_spells` VALUES ('11', '8', '668');
INSERT INTO `race_change_spells` VALUES ('11', '8', '20579');
INSERT INTO `race_change_spells` VALUES ('11', '8', '28875');
INSERT INTO `race_change_spells` VALUES ('11', '8', '28878');
INSERT INTO `race_change_spells` VALUES ('11', '8', '28880');
INSERT INTO `race_change_spells` VALUES ('11', '8', '29932');

INSERT INTO `spell_disabled` VALUES ('1852', '7', 'Silenced (GM Tool) Spell bugged');
INSERT INTO `spell_disabled` VALUES ('46642', '7', '5k gold');









-- ----------------------------
-- Procedure structure for PreventCharDelete
-- ----------------------------
DROP PROCEDURE IF EXISTS `PreventCharDelete`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PreventCharDelete`(IN charguid INT UNSIGNED)
BEGIN
    INSERT INTO deleted_chars (char_guid, oldname, acc, date)  VALUES (charguid, (SELECT name FROM characters WHERE guid = charguid), (SELECT account FROM characters WHERE guid = charguid), CAST(NOW() AS DATETIME));
    UPDATE characters SET account = 1 WHERE guid = charguid;
    UPDATE characters SET name = CONCAT('DEL', name, 'DEL') WHERE guid = charguid;
    DELETE FROM character_social WHERE guid = charguid OR friend = charguid;
    DELETE FROM mail WHERE receiver = charguid;
    DELETE FROM mail_items WHERE receiver = charguid;
END
;;
DELIMITER ;
