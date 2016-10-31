-- more missing patterns thanks for pointing out @Tykan
-- http://looking4group.eu/hellfire/showthread.php?tid=2979
DELETE FROM `reference_loot_template` WHERE `entry` = 24092 AND `item` IN (31875,31876,31877,31878,31879);
INSERT INTO `reference_loot_template` VALUES (24092, 31875, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31876, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31877, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31878, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31879, 0, 1, 1, 1, 0, 0, 0);

DELETE FROM `reference_loot_template` WHERE `entry` = 10006 AND `item` IN (31875,31876,31877);
INSERT INTO `reference_loot_template` VALUES (10006, 31875, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (10006, 31876, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (10006, 31877, 0, 1, 1, 1, 0, 0, 0);
-- INSERT INTO `reference_loot_template` VALUES (10006, 33186, 0, 1, 1, 1, 0, 0, 0); Plans: Adamantite Weapon Chain Readd 2.3

-- Ethereum Nullifier 22822
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 22822;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22822;
INSERT INTO `creature_ai_scripts` VALUES
(2282201,22822,2,0,100,1,50,0,10000,15000,11,36513,0,1,0,0,0,0,0,0,0,0,'Ethereum Nullifier - Casts Intangible Presence');
 
-- Ethereum Jailor 23008
UPDATE `creature` SET `spawntimesecs` = 1200 WHERE `id` = 23008;
UPDATE `creature_template` SET `baseattacktime`='1400',`AIName`='EventAI' WHERE `entry` = 23008; -- 2000
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23008;
INSERT INTO `creature_ai_scripts` VALUES
(2300801,23008,2,0,100,1,50,0,10000,15000,11,36513,0,1,0,0,0,0,0,0,0,0,'Ethereum Jailor - Casts Intangible Presence'),
(2300802,23008,9,0,50,1,0,3,10000,15000,11,35924,0,1,0,0,0,0,0,0,0,0,'Ethereum Jailor - Casts Energy Flux');

-- add Formula: Enchant Bracer - Greater Dodge to Ethereum Jailor Loottable
DELETE FROM `creature_loot_template` WHERE `entry` = 23008 AND `item` = 22530;
INSERT INTO `creature_loot_template` VALUES 
(23008, 22530, 1.0, 0, 1, 1, 7, 333, 1);

-- Serpentshrine Sporebat 21246
-- 107150, 214300 Leben haben Spore Burst Charge 10-15 secs melee for 3000 on cloth. hacky charge fix
-- By 1313moridin (1,661 – 13·34) on 2007/04/30 (Patch 2.0.12) they only have alittle over 200k hp
-- http://wowwiki.wikia.com/wiki/Serpentshrine_Sporebat?direction=next&oldid=768437 , http://www.wowhead.com/npc=21246/serpentshrine-sporebat#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3000',`maxdmg`='5000',`baseattacktime`='1000',`mechanic_immune_mask`='0' WHERE `entry` = 21246; -- 1874 3809 2000 -- 2500 3500 7,649 - 9,084
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21246;
INSERT INTO `creature_ai_scripts` VALUES
('2124601','21246','9','0','50','2','6','30','0','0','11','38461','1','0','11','40602','1','0','0','0','0','0','Serpentshrine Sporebat - Cast Charge on Aggro'), -- 5 22120 -- 38461
('2124602','21246','9','0','100','3','0','5','15800','24000','11','38924','0','1','0','0','0','0','0','0','0','0','Serpentshrine Sporebat - Cast Spore Burst'),
('2124603','21246','0','0','100','3','10000','15000','10000','15000','11','38461','4','1','11','40602','4','1','0','0','0','0','Serpentshrine Sporebat - Cast Random Charge');
