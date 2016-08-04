-- murmur 2 rar items
UPDATE `creature_loot_template` SET `groupid`='1',`maxcount`='2' WHERE `entry` = '20657' AND `item` = '35002';

-- Journeyman & Disciple Set
-- 7351,7350,6515,6514,6513
-- 2959,2960,3641,4662,4663
UPDATE `loot_creatures` SET `mincount`='0' WHERE `itemid` IN (7351,7350,6515,6514,6513,2959,2960,3641,4662,4663); -- 1

-- Journeyman & Disciple Set
-- 7351,7350,6515,6514,6513
-- 2959,2960,3641,4662,4663
-- 10%
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='6.7126' WHERE `entry`='2018' AND `item`='7350';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='3.2982' WHERE `entry`='2027' AND `item`='4662';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='3.3332' WHERE `entry`='2030' AND `item`='2959';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='6.6781' WHERE `entry`='2177' AND `item`='7351';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='1.9483' WHERE `entry`='2231' AND `item`='3641';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='7.3072' WHERE `entry`='2234' AND `item`='6515';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='3.5534' WHERE `entry`='2957' AND `item`='6514';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='3.0949' WHERE `entry`='2960' AND `item`='4662';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='4.348' WHERE `entry`='2979' AND `item`='2960';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='1.5308' WHERE `entry`='3100' AND `item`='4663';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='3.593' WHERE `entry`='3100' AND `item`='6514';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='8.7386' WHERE `entry`='3113' AND `item`='7350';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='7.8536' WHERE `entry`='3123' AND `item`='6514';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='5.5911' WHERE `entry`='3127' AND `item`='2960';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='9.4686' WHERE `entry`='3196' AND `item`='6514';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='6.0483' WHERE `entry`='3207' AND `item`='2960';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='6.3154' WHERE `entry`='3244' AND `item`='6514';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='9.7217' WHERE `entry`='3268' AND `item`='6514';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='7.6467' WHERE `entry`='3268' AND `item`='7350';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='6.5973' WHERE `entry`='3379' AND `item`='7351';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='4.5622' WHERE `entry`='7318' AND `item`='2960';
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='5.0' WHERE `entry`='15407' AND `item`='6515';

-- nerf gauntlet
-- respawn gauntlet
UPDATE `creature` SET `spawntimesecs`='300' WHERE `guid` IN (117515,117489,117436,117466);
UPDATE `creature` SET `spawntimesecs`='300' WHERE `guid` IN (62926,62927,62932,107964);

-- Shattered Hand Zealot 17462 20595
UPDATE `creature_template` SET `equipment_id`='990',`mindmg`='315',`maxdmg`='414' WHERE `entry` IN (17462); -- 1 rotes schwert 96 195
UPDATE `creature_template` SET `equipment_id`='990',`mindmg`='1000',`maxdmg`='1500' WHERE `entry` IN (20595); -- 1 rotes schwert 1430 2000 -- 1500 2500
--
-- Shattered Hand Scout 17693 20592
UPDATE `creature_template` SET `equipment_id`='52',`MovementType`='2',`AIName`='EventAI',`mindmg`='393',`maxdmg`='517' WHERE `entry` IN (17693); -- Fakel 120 244
UPDATE `creature_template` SET `equipment_id`='52',`MovementType`='2',`mindmg`='1000',`maxdmg`='1500' WHERE `entry` IN (20592); -- Fakel 1221 1827
-- prevent gauntlet boss from respawning
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (16777014,62871,62872);
INSERT INTO `creature_linked_respawn` VALUES
(62871,16777014),
(62872,16777014),
(16777014,16777014);
