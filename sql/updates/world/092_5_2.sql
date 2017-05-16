-- Pattern: Spellstrike Pants
UPDATE `creature_loot_template` SET `groupid` = 3 WHERE `entry` IN (18708,20657) AND `item` = 24309;

-- Aqueous Lord 22878
UPDATE `creature_template` SET `mindmg`='6938',`maxdmg`='7257' WHERE `entry` = 22878;

-- Daily PvP
UPDATE `creature` SET `spawnmask` = 1 WHERE `id` IN (15350, 15351);
UPDATE `quest_template` set `RewHonorableKills` = 20, `RewMoneyMaxLevel` = 0 where `entry` between 11335 and 11342; -- nonblizzlike 24 155999 blizzlike 20 75900

-- PvP Turn in Quest
UPDATE `quest_template` SET `ReqItemId1` = 20560, `RewHonorableKills` = 15 WHERE `entry` IN (8388,8385); -- nonblizzlike 0 20 blizzlike 20560 15

-- http://www.wowhead.com/spell=1122/summon-infernal
UPDATE `creature_template` SET `AIName` = 'EventAI'  WHERE `entry` = 89;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 89;
INSERT INTO `creature_ai_scripts` VALUES ('8901','89','1','0','100','0','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Infernal - Despawn OOC');

