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

-- Whirling Blade 23369 mob_whirling_blade
UPDATE `creature_template` SET `modelid_A`='16946' WHERE `entry` = 23369;

-- Watcher Moonshade ori GUID + Path
DELETE FROM `creature` WHERE `guid` IN (78695,511368);
INSERT INTO `creature` VALUES (78695, 22386, 530, 1, 0, 0, 3108.07, 6131.54, 136.358, 1.36031, 300, 0, 0, 4800, 0, 0, 2);
SET @GUID := 78695;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(78695,1,3109.83,6138.61,136.152,15000,0,0,100,0),
(78695,2,3106.78,6123.73,136.396,0,0,0,100,0),
(78695,3,3103.92,6119.18,134.98,0,0,0,100,0),
(78695,4,3107.08,6115.74,134.479,0,0,0,100,0),
(78695,5,3106.34,6115.29,134.444,20000,0,0,100,0),
(78695,6,3100.41,6119.81,134.724,5000,0,0,100,0),
(78695,7,3108.07,6131.54,136.358,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 77174;
INSERT INTO `creature` VALUES (77174, 22025, 530, 1, 0, 0, -3023.25, 2044.44, 96.9412, 3.63741, 300, 0, 0, 5300, 2991, 0, 2);
SET @GUID := 77174;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(77174,1,-3049.04,2036.84,96.7392,0,0,0,100,0),
(77174,2,-3058.74,2037.59,97.0927,0,0,0,100,0),
(77174,3,-3071.71,2031.49,97.8157,0,0,0,100,0),
(77174,4,-3081.47,2022.89,98.1052,0,0,0,100,0),
(77174,5,-3080.4,2018.21,98.423,0,0,0,100,0),
(77174,6,-3068.68,2011.33,99.1066,0,0,0,100,0),
(77174,7,-3063.36,2002.53,99.861,0,0,0,100,0),
(77174,8,-3052.37,1999.89,99.0744,0,0,0,100,0),
(77174,9,-3035,2000.17,98.8673,0,0,0,100,0),
(77174,10,-3018.3,2007.63,96.9703,0,0,0,100,0),
(77174,11,-3016.29,2040.86,97.3995,0,0,0,100,0);

UPDATE `creature` SET `position_x`='-3132.6718', `position_y`='2245.0419', `position_z`='61.3553' WHERE `guid` = 70950;
UPDATE `creature` SET `position_x`='-3069.6955', `position_y`='2177.9125', `position_z`='73.1659' WHERE `guid` = 70951;
