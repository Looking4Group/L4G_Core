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

-- 30 day duration 200g cost
DELETE FROM `item_template` WHERE `entry`=1000021;
INSERT INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES 
(1000021, 15, 0, -1, 'Hellfire Talent Reset Token', 37780, 6, 1, 1, 2000000, 0, 0, -1, -1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'This token allows you to reset your talents for free at your class trainer. Unlimited uses. Expires after 30 days.', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, -2592000);

DELETE FROM `npc_option` WHERE `id`=52;
INSERT INTO `npc_option` (`id`, `npcflag`, `icon`, `action`, `option_text`, `box_text`) VALUES 
('52', '16', '2', '19', 'Use the talent reset token to unlearn my talents for free!', 'Are you sure you wish to unlearn all your talents?');

DELETE FROM `npc_option` WHERE `id`=53;
INSERT INTO `npc_option` (`id`, `npcflag`, `icon`, `action`, `box_money`, `option_text`, `box_text`) VALUES 
('53', '16', '2', '20', '2000000', 'Buy a talent reset token', 'This token lasts for 30 days and costs 200 gold. During that time you can reset your talents an unlimited amount of times for free by talking to your class trainer. Do you wish to buy this item?');

-- Son of Cenarius 4057
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 4057;
INSERT INTO `creature_ai_scripts` VALUES (405701, 4057, 1, 0, 100, 0, 0, 0, 0, 0, 11, 7993, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Son of Cenarius - Summon Treant Ally OOC');

-- Treant Ally 5806
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 5806;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 5806;
INSERT INTO `creature_ai_scripts` VALUES (580601, 5806, 7, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Treant Ally - Despawn on Evade');

UPDATE `petcreateinfo_spell` SET `spell2` = 27349 WHERE `entry` = 21042; -- 27051
