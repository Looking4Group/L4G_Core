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

UPDATE `npc_vendor` SET `incrtime` = 3600 WHERE `item` IN (12163,16243,22901,22911); -- 7200
UPDATE `npc_vendor` SET `incrtime` = 3600 WHERE `item` = 23574; -- 9000
UPDATE `npc_vendor` SET `incrtime` = 3600 WHERE `item` IN (22563,21900,21901,25849,28282,22907); -- 10800
UPDATE `npc_vendor` SET `incrtime` = 3600 WHERE `item` IN (25720,25848); -- 21600
UPDATE `npc_vendor` SET `incrtime` = 3600 WHERE `item` IN (22562,22565,21894,23799,23811,23815,23816,23590,23591,23592,23593,21898,21899,23807,25846,25847); -- 43200

-- Add Deadly Throw to Cold Blood spell_affect
UPDATE  `spell_affect` SET `SpellFamilyMask` = 66044691230  WHERE `entry` = 14177;

-- Moonstalker Runt 2070
UPDATE `creature_template` SET `minlevel` = 10, `maxlevel` = 11 WHERE `entry` = 2070; -- 16 17

-- Shadow of Leotheras 21875
UPDATE `creature_template` SET `flags_extra` = 1078001665 WHERE `entry` = 21875;

