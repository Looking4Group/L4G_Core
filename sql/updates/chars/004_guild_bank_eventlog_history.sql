SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for guild_bank_eventlog_history
-- ----------------------------
DROP TABLE IF EXISTS `guild_bank_eventlog_history`;
CREATE TABLE `guild_bank_eventlog_history` (
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


ALTER TABLE `guild_bank_eventlog_history`
MODIFY COLUMN `LogGuid`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT FIRST ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`LogGuid`);

ALTER TABLE `guild_bank_eventlog_history`
MODIFY COLUMN `LogGuid`  int(11) UNSIGNED NOT NULL DEFAULT 0 FIRST ;
