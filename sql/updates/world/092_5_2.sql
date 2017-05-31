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

-- Quest 9719 should be available to both factions.
UPDATE `quest_template` SET `RequiredRaces` = 0 WHERE  `entry` = 9719; -- 1101

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (18124, 19402, 20324);
INSERT INTO `creature_ai_scripts` VALUES
-- Parched Hydra
('2032401','20324','9','0','75','1','0','5','9000','14000','11','35236','1','0','0','0','0','0','0','0','0','0','Parched Hydra - Cast Heat Wave'),
-- (2032401, 20324, 0, 0, 75, 1, 1000, 1000, 6000, 6000, 11, 35236, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Parched Hydra - Cast Heat Wave');

-- Withered Bog Lord
('1940201','19402','9','0','75','1','0','5','12000','16000','11','35238','1','0','0','0','0','0','0','0','0','0','Withered Bog Lord - Cast War Stomp'),
('1940202','19402','0','0','100','1','6000','11000','8000','14000','11','35235','0','0','0','0','0','0','0','0','0','0','Withered Bog Lord - Cast Osmosis'),
-- (1940201, 19402, 0, 0, 100, 1, 6000, 6000, 10000, 10000, 11, 35235, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Withered Bog Lord - Cast Osmosis');
-- (1940202, 19402, 0, 0, 75, 1, 3000, 3000, 10000, 10000, 11, 35238, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Withered Bog Lord - Cast War Stomp');

-- Withered Giant
('1812401','18124','0','0','100','1','6000','11000','8000','14000','11','35235','0','0','0','0','0','0','0','0','0','0','Withered Giant - Cast Osmosis');
-- (1812401, 18124, 0, 0, 100, 1, 6000, 6000, 10000, 10000, 11, 35235, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Withered Giant - Cast Osmosis');

UPDATE `creature` SET `spawntimesecs` = 180 WHERE `id` = 22355;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22355;
INSERT INTO `creature_ai_scripts` VALUES
('2235501','22355','4','0','100','0','0','0','0','0','31','1','6','0','0','0','0','0','0','0','0','0','Netherweb Victim - Choose Random Phase on Aggro'),
('2235502','22355','6','62','90','0','0','0','0','0','12','21242','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Auchenai Death-Speaker on Death (Phase 1)'),
('2235503','22355','6','61','90','0','0','0','0','0','12','18470','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Bonelasher on Death (Phase 2)'),
('2235504','22355','6','59','90','0','0','0','0','0','12','21661','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Cabal Skirmisher on Death (Phase 3)'),
('2235505','22355','6','55','90','0','0','0','0','0','12','16805','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Broken Skeleton on Death (Phase 4)'),
('2235506','22355','6','47','90','0','0','0','0','0','12','18452','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Skithian Dreadhawk on Death (Phase 5)'),
('2235507','22355','6','31','90','0','0','0','0','0','12','22459','0','60000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Freed Sha\'tar Warrior on Death (Phase 6)'),
('2235508','22355','6','0','10','0','0','0','0','0','12','22459','0','60000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Freed Sha\'tar Warrior on Death');

-- Eredar Sorcerer 25033 
UPDATE `creature_template` SET `flags_extra` = 64 WHERE `entry` = 25033;

-- Coilskar Assassin 21044
UPDATE `creature_template` SET `equipment_id` = 1571 WHERE `entry` = 21044;


-- Set 20145  Level 60 doesnt matter as spellsummoned
UPDATE `creature_template` SET `minlevel`='60',`maxlevel`='60' WHERE `entry` = '20145';

-- Set 20143 Invis for Players
UPDATE `creature_template` SET `modelid_A` = 18684, `modelid_H` = 18684, `minlevel`='60',`maxlevel`='60', `unit_flags` = 33554688, `flags_extra` = 2, `maxdmg` = 60 WHERE `entry` = '20143';

DELETE FROM `creature_questrelation` WHERE `quest` = 10877;
INSERT INTO `creature_questrelation` VALUES (22456, 10877);

-- Massive Treasure Chest Quest 10877
UPDATE `gameobject` SET `spawntimesecs`='301' WHERE `guid` = 26109;
UPDATE `gameobject_template` SET `data2`='300',`data3`='1' WHERE `entry` = 185220;

-- Dread Relic Thrall
UPDATE `creature_template` SET `minlevel`='66',`maxlevel`='69',`armor`='4200',`speed`='1.20',`mindmg`='100',`maxdmg`='200',`AIName`='EventAI' WHERE `entry` = 22369;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22369;
INSERT INTO `creature_ai_scripts` VALUES
('2236901','22369','1','0','100','1','29000','31000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Dread Relic Thrall - Despawn OOC');

-- Farahlon Giant 18885
-- missing summoning spell with included shrink component from dbc
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 18885; -- 277 623
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18885;
INSERT INTO `creature_ai_scripts` VALUES
('1888501','18885','2','0','100','0','75','0','0','0','12','21077','1','0','0','0','0','0','0','0','0','0','Farahlon Giant - Summon Farahlon Shardling and Cast Shrink at 75% HP'),
('1888502','18885','2','0','100','0','50','0','0','0','12','21077','1','0','0','0','0','0','0','0','0','0','Farahlon Giant - Summon Farahlon Shardling and Cast Shrink at 50% HP'),
('1888503','18885','2','0','100','0','25','0','0','0','12','21077','1','0','0','0','0','0','0','0','0','0','Farahlon Giant - Summon Farahlon Shardling and Cast Shrink at 25% HP');

-- Farahlon Breaker 18886
-- missing summoning spell with included shrink component from dbc
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 18886; -- 303 684
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18886;
INSERT INTO `creature_ai_scripts` VALUES
('1888601','18886','2','0','100','0','75','0','0','0','12','21078','1','0','0','0','0','0','0','0','0','0','Farahlon Breaker - Summon Farahlon Shardling and Cast Shrink at 75% HP'),
('1888602','18886','2','0','100','0','50','0','0','0','12','21078','1','0','0','0','0','0','0','0','0','0','Farahlon Breaker - Summon Farahlon Shardling and Cast Shrink at 50% HP'),
('1888603','18886','2','0','100','0','25','0','0','0','12','21078','1','0','0','0','0','0','0','0','0','0','Farahlon Breaker - Summon Farahlon Shardling and Cast Shrink at 25% HP');

-- Farahlon Crumbler 21077
UPDATE `creature_template` SET `minhealth` = 4057, `maxhealth` = 4192 WHERE `entry` = 21077;

-- Farahlon Shardling 21078
UPDATE `creature_template` SET `minhealth` = 7591, `maxhealth` = 7591,`faction_A` = 778, `faction_H` = 778 WHERE `entry` = 21078;

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67674;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3307.196,`position_y`=4042.883,`position_z`=154.8781 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3277.618,4026.461,147.0905,0,0,0,100,0),
(@PATH,2,3260.858,4007.037,144.7625,0,0,0,100,0),
(@PATH,3,3250.179,3988.815,150.5136,0,0,0,100,0),
(@PATH,4,3241.547,3965.698,161.7374,1000,0,0,100,0),
(@PATH,5,3250.179,3988.815,150.5136,0,0,0,100,0),
(@PATH,6,3260.858,4007.037,144.7625,0,0,0,100,0),
(@PATH,7,3277.618,4026.461,147.0905,0,0,0,100,0),
(@PATH,8,3307.196,4042.883,154.8781,0,0,0,100,0),
(@PATH,9,3320.514,4065.975,147.2531,0,0,0,100,0),
(@PATH,10,3339.809,4086.788,141.3519,0,0,0,100,0),
(@PATH,11,3320.514,4065.975,147.2531,0,0,0,100,0),
(@PATH,12,3307.196,4042.883,154.8781,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67675;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3500.969,`position_y`=4111.483,`position_z`=119.7430 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3485.152,4132.505,120.2611,0,0,0,100,0),
(@PATH,2,3500.969,4111.483,119.74300,0,0,0,100,0),
(@PATH,3,3504.477,4105.242,116.2309,0,0,0,100,0),
(@PATH,4,3528.868,4068.198,117.009,0,0,0,100,0),
(@PATH,5,3539.426,4043.977,115.94192,0,0,0,100,0),
(@PATH,6,3543.322,4036.772,109.2695,0,0,0,100,0),
(@PATH,7,3544.440,4030.735,106.11139,0,0,0,100,0),
(@PATH,8,3547.317,4017.866,112.61887,0,0,0,100,0),
(@PATH,9,3550.593,3999.587,112.1916,0,0,0,100,0),
(@PATH,10,3554.401,3988.877,118.17648,0,0,0,100,0),
(@PATH,11,3557.836,3972.274,118.9416,0,0,0,100,0),
(@PATH,12,3556.315,3956.803,123.46574,0,0,0,100,0),
(@PATH,13,3558.203,3940.378,123.7852,0,0,0,100,0),
(@PATH,14,3549.843,3903.547,118.9388,0,0,0,100,0),
(@PATH,15,3522.814,3871.391,125.8325,0,0,0,100,0),
(@PATH,16,3519.263,3862.244,122.35843,0,0,0,100,0),
(@PATH,17,3513.410,3840.514,130.29782,0,0,0,100,0),
(@PATH,18,3510.590,3830.997,126.47477,0,0,0,100,0),
(@PATH,19,3509.047,3823.276,128.7576,0,0,0,100,0),
(@PATH,20,3501.395,3806.494,139.15434,0,0,0,100,0),
(@PATH,21,3488.025,3783.108,145.2974,0,0,0,100,0),
(@PATH,22,3501.395,3806.494,139.15434,0,0,0,100,0),
(@PATH,23,3509.047,3823.276,128.7576,0,0,0,100,0),
(@PATH,24,3510.590,3830.997,126.47477,0,0,0,100,0),
(@PATH,25,3513.410,3840.514,130.29782,0,0,0,100,0),
(@PATH,26,3519.263,3862.244,122.35843,0,0,0,100,0),
(@PATH,27,3522.636,3871.163,125.8325,0,0,0,100,0),
(@PATH,28,3549.666,3903.319,118.9388,0,0,0,100,0),
(@PATH,29,3558.201,3940.354,123.7852,0,0,0,100,0),
(@PATH,30,3556.315,3956.803,123.46574,0,0,0,100,0),
(@PATH,31,3557.836,3972.274,118.9416,0,0,0,100,0),
(@PATH,32,3554.401,3988.877,118.17648,0,0,0,100,0),
(@PATH,33,3550.593,3999.587,112.1916,0,0,0,100,0),
(@PATH,34,3547.317,4017.866,112.61887,0,0,0,100,0),
(@PATH,35,3544.440,4030.735,106.11139,0,0,0,100,0),
(@PATH,36,3543.322,4036.772,109.2695,0,0,0,100,0),
(@PATH,37,3539.426,4043.977,115.94192,0,0,0,100,0),
(@PATH,38,3528.868,4068.198,117.009,0,0,0,100,0),
(@PATH,39,3504.477,4105.242,116.2309,0,0,0,100,0),
(@PATH,40,3500.969,4111.483,119.74300,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67676;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3187.844,`position_y`=3354.885,`position_z`=103.6849 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3186.171,3369.128,103.175,0,0,0,100,0),
(@PATH,2,3187.844,3354.885,103.6849,0,0,0,100,0),
(@PATH,3,3193.295,3334.863,105.5599,0,0,0,100,0),
(@PATH,4,3176.572,3326.64,106.6562,0,0,0,100,0),
(@PATH,5,3147.848,3330.089,110.65391,0,0,0,100,0),
(@PATH,6,3112.877,3326.449,108.7179,0,0,0,100,0),
(@PATH,7,3109.425,3297.064,110.9742,0,0,0,100,0),
(@PATH,8,3112.877,3326.449,108.7179,0,0,0,100,0),
(@PATH,9,3147.848,3330.089,110.65391,0,0,0,100,0),
(@PATH,10,3176.572,3326.64,106.6562,0,0,0,100,0),
(@PATH,11,3193.295,3334.863,105.5599,0,0,0,100,0),
(@PATH,12,3187.844,3354.885,103.6849,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67677;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3205.647,`position_y`=3602.592,`position_z`=129.2651 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3223.249,3624.715,127.0151,0,0,0,100,0),
(@PATH,2,3235.066,3659.355,127.7201,0,0,0,100,0),
(@PATH,3,3216.7,3678.948,130.4733,0,0,0,100,0),
(@PATH,4,3189.74,3684.127,131.0753,0,0,0,100,0),
(@PATH,5,3170.825,3663.576,132.6749,0,0,0,100,0),
(@PATH,6,3178.646,3639.574,130.4249,0,0,0,100,0),
(@PATH,7,3185.125,3653.292,130.72742,0,0,0,100,0),
(@PATH,8,3201.354,3649.029,128.16573,0,0,0,100,0),
(@PATH,9,3204.285,3617.030,129.46323,0,0,0,100,0),
(@PATH,10,3190.81,3613.903,130.5821,0,0,0,100,0),
(@PATH,11,3187.683,3592.944,134.12030,0,0,0,100,0),
(@PATH,12,3202.407,3584.459,129.73170,0,0,0,100,0),
(@PATH,13,3200.818,3578.828,129.82494,0,0,0,100,0),
(@PATH,14,3197.821,3575.041,130.04979,0,0,0,100,0),
(@PATH,15,3192.861,3576.952,131.0747,0,0,0,100,0),
(@PATH,16,3184.961,3555.860,131.56726,0,0,0,100,0),
(@PATH,17,3174.97,3545.822,139.6494,0,0,0,100,0),
(@PATH,18,3168.137,3528.296,144.1821,0,0,0,100,0),
(@PATH,19,3174.97,3545.822,139.6494,0,0,0,100,0),
(@PATH,20,3184.961,3555.860,131.56726,0,0,0,100,0),
(@PATH,21,3192.861,3576.952,131.0747,0,0,0,100,0),
(@PATH,22,3197.821,3575.041,130.04979,0,0,0,100,0),
(@PATH,23,3200.818,3578.828,129.82494,0,0,0,100,0),
(@PATH,24,3202.407,3584.459,129.73170,0,0,0,100,0),
(@PATH,25,3187.683,3592.944,134.12030,0,0,0,100,0),
(@PATH,26,3190.81,3613.903,130.5821,0,0,0,100,0),
(@PATH,27,3204.285,3617.030,129.46323,0,0,0,100,0),
(@PATH,28,3201.354,3649.029,128.16573,0,0,0,100,0),
(@PATH,29,3185.125,3653.292,130.72742,0,0,0,100,0),
(@PATH,30,3178.388,3639.369,130.4249,0,0,0,100,0),
(@PATH,31,3170.825,3663.576,132.6749,0,0,0,100,0),
(@PATH,32,3189.74,3684.127,131.0753,0,0,0,100,0),
(@PATH,33,3216.7,3678.948,130.4733,0,0,0,100,0),
(@PATH,34,3235.066,3659.355,127.7201,0,0,0,100,0),
(@PATH,35,3223.249,3624.715,127.0151,0,0,0,100,0),
(@PATH,36,3205.647,3602.592,129.2651,0,0,0,100,0),
(@PATH,37,3192.143,3599.760,130.23784,0,0,0,100,0),
(@PATH,38,3187.477,3599.081,133.15712,0,0,0,100,0),
(@PATH,39,3181.387,3595.847,134.07948,0,0,0,100,0),
(@PATH,40,3170.807,3588.936,135.81763,0,0,0,100,0),
(@PATH,41,3173.438,3581.25,135.0747,0,0,0,100,0),
(@PATH,42,3168.840,3584.897,136.61433,0,0,0,100,0),
(@PATH,43,3160.090,3578.968,139.22585,0,0,0,100,0),
(@PATH,44,3153.512,3574.571,138.24211,0,0,0,100,0),
(@PATH,45,3148.415,3570.115,141.38100,0,0,0,100,0),
(@PATH,46,3144.422,3566.506,140.08098,0,0,0,100,0),
(@PATH,47,3138.708,3561.236,141.6376,0,0,0,100,0),
(@PATH,48,3115.41,3551.044,140.6872,1000,0,0,100,0),
(@PATH,49,3138.708,3561.236,141.6376,0,0,0,100,0),
(@PATH,50,3144.422,3566.506,140.08098,0,0,0,100,0),
(@PATH,51,3148.415,3570.115,141.38100,0,0,0,100,0),
(@PATH,52,3153.512,3574.571,138.24211,0,0,0,100,0),
(@PATH,53,3160.090,3578.968,139.22585,0,0,0,100,0),
(@PATH,54,3168.840,3584.897,136.61433,0,0,0,100,0),
(@PATH,55,3172.968,3580.598,135.0747,0,0,0,100,0),
(@PATH,56,3170.807,3588.936,135.81763,0,0,0,100,0),
(@PATH,57,3181.387,3595.847,134.07948,0,0,0,100,0),
(@PATH,58,3187.477,3599.081,133.15712,0,0,0,100,0),
(@PATH,59,3192.143,3599.760,130.23784,0,0,0,100,0),
(@PATH,60,3205.647,3602.592,129.2651,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67678;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3083.824,`position_y`=3822.363,`position_z`=142.9242 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3107.359,3805.027,143.4097,0,0,0,100,0),
(@PATH,2,3113.569,3784.48,142.849,0,0,0,100,0),
(@PATH,3,3125.968,3758.109,141.6801,0,0,0,100,0),
(@PATH,4,3143.205,3746.017,140.3879,0,0,0,100,0),
(@PATH,5,3166.316,3767.922,139.2505,0,0,0,100,0),
(@PATH,6,3157.023,3792.195,141.1255,0,0,0,100,0),
(@PATH,7,3165.993,3808.895,140.2915,0,0,0,100,0),
(@PATH,8,3169.192,3824.669,133.174408,0,0,0,100,0),
(@PATH,9,3172.914,3832.764,133.808151,0,0,0,100,0),
(@PATH,10,3175.760,3840.606,130.687729,0,0,0,100,0),
(@PATH,11,3167.760,3847.435,134.709045,0,0,0,100,0),
(@PATH,12,3160.811,3854.203,135.4904,0,0,0,100,0),
(@PATH,13,3156.707,3863.009,137.4904,0,0,0,100,0),
(@PATH,14,3145.38,3864.699,144.4904,0,0,0,100,0),
(@PATH,15,3115.666,3862.969,143.9057,0,0,0,100,0),
(@PATH,16,3095.106,3848.855,144.1251,0,0,0,100,0),
(@PATH,17,3083.824,3822.363,142.9242,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67679;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2953.074,`position_y`=4418.923,`position_z`=113.6698 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2968.870,4415.504,104.08283,0,0,0,100,0),
(@PATH,2,2980.312,4414.008,110.27019,0,0,0,100,0),
(@PATH,3,2989.23,4413.055,111.8806,0,0,0,100,0),
(@PATH,4,3019.479,4393.933,114.7273,0,0,0,100,0),
(@PATH,5,3031.533,4384.412,115.13152,0,0,0,100,0),
(@PATH,6,3037.941,4378.716,110.84249,0,0,0,100,0),
(@PATH,7,3042.72,4375.858,114.4709,0,0,0,100,0),
(@PATH,8,3047.354,4372.069,118.25387,0,0,0,100,0),
(@PATH,9,3069.198,4352.577,120.5235,0,0,0,100,0),
(@PATH,10,3070.953,4332.657,125.02256,0,0,0,100,0),
(@PATH,11,3072.404,4323.974,122.46004,0,0,0,100,0),
(@PATH,12,3075.358,4315.096,129.9413,0,0,0,100,0),
(@PATH,13,3079.458,4302.790,133.94775,0,0,0,100,0),
(@PATH,14,3080.927,4296.537,131.91492,0,0,0,100,0),
(@PATH,15,3085.319,4283.639,136.32475,0,0,0,100,0),
(@PATH,16,3086.899,4278.267,136.2266,0,0,0,100,0),
(@PATH,17,3083.732,4260.896,130.52606,0,0,0,100,0),
(@PATH,18,3082.22,4243.589,132.2974,0,0,0,100,0),
(@PATH,19,3072.038,4215.869,141.6003,0,0,0,100,0),
(@PATH,20,3068.870,4212.112,142.49199,0,0,0,100,0),
(@PATH,21,3065.441,4208.322,140.52289,0,0,0,100,0),
(@PATH,22,3059.951,4202.285,145.96335,0,0,0,100,0),
(@PATH,23,3046.959,4187.614,148.8807,0,0,0,100,0),
(@PATH,24,3046.440,4183.375,148.15771,0,0,0,100,0),
(@PATH,25,3045.245,4174.715,144.05222,0,0,0,100,0),
(@PATH,26,3044.982,4164.704,148.3401,0,0,0,100,0),
(@PATH,27,3062.038,4148.822,144.2151,0,0,0,100,0),
(@PATH,28,3085.888,4134.461,134.2539,0,0,0,100,0),
(@PATH,29,3090.815,4126.320,129.15350,0,0,0,100,0),
(@PATH,30,3098.432,4116.025,134.30519,0,0,0,100,0),
(@PATH,31,3102.213,4111.794,134.9322,0,0,0,100,0),
(@PATH,32,3125.156,4102.375,131.92854,0,0,0,100,0),
(@PATH,33,3133.285,4098.211,125.818,0,0,0,100,0),
(@PATH,34,3136.667,4096.907,125.45198,0,0,0,100,0),
(@PATH,35,3142.879,4094.014,130.06189,0,0,0,100,0),
(@PATH,36,3147.032,4092.458,130.79753,0,0,0,100,0),
(@PATH,37,3163.426,4085.868,128.8258,0,0,0,100,0),
(@PATH,38,3147.032,4092.458,130.79753,0,0,0,100,0),
(@PATH,39,3142.879,4094.014,130.06189,0,0,0,100,0),
(@PATH,40,3136.667,4096.907,125.45198,0,0,0,100,0),
(@PATH,41,3133.285,4098.211,125.818,0,0,0,100,0),
(@PATH,42,3125.156,4102.375,131.92854,0,0,0,100,0),
(@PATH,43,3102.213,4111.794,134.9322,0,0,0,100,0),
(@PATH,44,3098.432,4116.025,134.30519,0,0,0,100,0),
(@PATH,45,3090.815,4126.320,129.15350,0,0,0,100,0),
(@PATH,46,3085.888,4134.461,134.2539,0,0,0,100,0),
(@PATH,47,3062.038,4148.822,144.2151,0,0,0,100,0),
(@PATH,48,3045.147,4164.433,148.5901,0,0,0,100,0),
(@PATH,49,3045.245,4174.715,144.05222,0,0,0,100,0),
(@PATH,50,3046.440,4183.375,148.15771,0,0,0,100,0),
(@PATH,51,3046.959,4187.614,148.8807,0,0,0,100,0),
(@PATH,52,3059.951,4202.285,145.96335,0,0,0,100,0),
(@PATH,53,3065.441,4208.322,140.52289,0,0,0,100,0),
(@PATH,54,3068.870,4212.112,142.49199,0,0,0,100,0),
(@PATH,55,3072.038,4215.869,141.6003,0,0,0,100,0),
(@PATH,56,3082.22,4243.589,132.2974,0,0,0,100,0),
(@PATH,57,3083.732,4260.896,130.52606,0,0,0,100,0),
(@PATH,58,3086.899,4278.267,136.2266,0,0,0,100,0),
(@PATH,59,3085.319,4283.639,136.32475,0,0,0,100,0),
(@PATH,60,3080.927,4296.537,131.91492,0,0,0,100,0),
(@PATH,61,3079.458,4302.790,133.94775,0,0,0,100,0),
(@PATH,62,3075.358,4315.096,129.9413,0,0,0,100,0),
(@PATH,63,3072.404,4323.974,122.46004,0,0,0,100,0),
(@PATH,64,3070.953,4332.657,125.02256,0,0,0,100,0),
(@PATH,65,3069.198,4352.577,120.5235,0,0,0,100,0),
(@PATH,66,3047.354,4372.069,118.25387,0,0,0,100,0),
(@PATH,67,3042.72,4375.858,114.4709,0,0,0,100,0),
(@PATH,68,3037.941,4378.716,110.84249,0,0,0,100,0),
(@PATH,69,3031.533,4384.412,115.13152,0,0,0,100,0),
(@PATH,70,3019.479,4393.933,114.7273,0,0,0,100,0),
(@PATH,71,2989.23,4413.055,111.8806,0,0,0,100,0),
(@PATH,72,2980.312,4414.008,110.27019,0,0,0,100,0),
(@PATH,73,2968.870,4415.504,104.08283,0,0,0,100,0),
(@PATH,74,2953.074,4418.923,113.6698,0,0,0,100,0),
(@PATH,75,2945.318,4422.867,113.08457,0,0,0,100,0),
(@PATH,76,2937.188,4426.727,106.90451,0,0,0,100,0),
(@PATH,77,2927.775,4431.704,112.43441,0,0,0,100,0),
(@PATH,78,2916.436,4437.853,113.2494,0,0,0,100,0),
(@PATH,79,2887.948,4449.667,115.9472,0,0,0,100,0),
(@PATH,80,2916.436,4437.853,113.2494,0,0,0,100,0),
(@PATH,81,2927.775,4431.704,112.43441,0,0,0,100,0),
(@PATH,82,2937.188,4426.727,106.90451,0,0,0,100,0),
(@PATH,83,2945.318,4422.867,113.08457,0,0,0,100,0),
(@PATH,84,2953.074,4418.923,113.6698,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67680;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3354.154,`position_y`=3934.199,`position_z`=194.9946 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3326.337,3936.656,185.7551,0,0,0,100,0),
(@PATH,2,3289.139,3941.342,176.3743,0,0,0,100,0),
(@PATH,3,3277.685,3946.140,173.13022,0,0,0,100,0),
(@PATH,4,3270.545,3949.150,168.28789,0,0,0,100,0),
(@PATH,5,3264.730,3950.612,168.52800,0,0,0,100,0),
(@PATH,6,3260.312,3951.976,166.74434,0,0,0,100,0),
(@PATH,7,3256.503,3953.552,167.9874,0,0,0,100,0),
(@PATH,8,3233.981,3970.728,159.8886,0,0,0,100,0),
(@PATH,9,3201.644,3982.191,155.4106,0,0,0,100,0),
(@PATH,10,3192.360,3985.352,154.61075,0,0,0,100,0),
(@PATH,11,3185.386,3987.769,151.02473,0,0,0,100,0),
(@PATH,12,3177.326,3990.076,153.16119,0,0,0,100,0),
(@PATH,13,3157.516,3996.942,152.4727,0,0,0,100,0),
(@PATH,14,3138.194,4034.612,143.7936,0,0,0,100,0),
(@PATH,15,3157.516,3996.942,152.4727,0,0,0,100,0),
(@PATH,16,3177.326,3990.076,153.16119,0,0,0,100,0),
(@PATH,17,3185.386,3987.769,151.02473,0,0,0,100,0),
(@PATH,18,3192.360,3985.352,154.61075,0,0,0,100,0),
(@PATH,19,3201.644,3982.191,155.4106,0,0,0,100,0),
(@PATH,20,3233.981,3970.728,159.8886,0,0,0,100,0),
(@PATH,21,3256.503,3953.552,167.9874,0,0,0,100,0),
(@PATH,22,3260.312,3951.976,166.74434,0,0,0,100,0),
(@PATH,23,3264.730,3950.612,168.52800,0,0,0,100,0),
(@PATH,24,3270.545,3949.150,168.28789,0,0,0,100,0),
(@PATH,25,3277.685,3946.140,173.13022,0,0,0,100,0),
(@PATH,26,3289.139,3941.342,176.3743,0,0,0,100,0),
(@PATH,27,3326.337,3936.656,185.7551,0,0,0,100,0),
(@PATH,28,3354.154,3934.199,194.9946,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67681;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3355.43,`position_y`=4002.26,`position_z`=172.045 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3330.275,3988.508,172.517,0,0,0,100,0),
(@PATH,2,3335.216,3953.428,182.4946,0,0,0,100,0),
(@PATH,3,3343.837,3924.523,195.0368,1000,0,0,100,0),
(@PATH,4,3335.253,3953.264,182.4946,0,0,0,100,0),
(@PATH,5,3330.275,3988.508,172.517,0,0,0,100,0),
(@PATH,6,3355.438,4002.257,172.045,0,0,0,100,0),
(@PATH,7,3357.194,4007.439,174.10998,0,0,0,100,0),
(@PATH,8,3361.875,4020.746,173.30781,0,0,0,100,0),
(@PATH,9,3365.056,4031.747,166.795,0,0,0,100,0),
(@PATH,10,3378.95,4062.084,164.3968,1000,0,0,100,0),
(@PATH,11,3365.056,4031.747,166.795,0,0,0,100,0),
(@PATH,12,3361.876,4020.746,173.30781,0,0,0,100,0),
(@PATH,13,3357.194,4007.439,174.10998,0,0,0,100,0),
(@PATH,14,3355.43,4002.26,172.045,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67682;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2753.675,`position_y`=3675.186,`position_z`=135.0956 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2752.725,3638.173,138.30611,0,0,0,100,0),
(@PATH,2,2737.014,3614.894,140.55336,0,0,0,100,0),
(@PATH,3,2723.215,3596.417,139.1804,0,0,0,100,0),
(@PATH,4,2699.974,3555.05,136.0686,0,0,0,100,0),
(@PATH,5,2700.122,3523.024,138.8626,0,0,0,100,0),
(@PATH,6,2732.669,3502.801,137.7376,0,0,0,100,0),
(@PATH,7,2760.138,3473.001,137.8149,0,0,0,100,0),
(@PATH,8,2732.669,3502.801,137.7376,0,0,0,100,0),
(@PATH,9,2700.122,3523.024,138.8626,0,0,0,100,0),
(@PATH,10,2699.974,3555.05,136.0686,0,0,0,100,0),
(@PATH,11,2723.215,3596.417,139.1804,0,0,0,100,0),
(@PATH,12,2737.014,3614.894,140.55336,0,0,0,100,0),
(@PATH,13,2752.725,3638.173,138.30611,0,0,0,100,0),
(@PATH,14,2753.675,3675.186,135.0956,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67683;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3494.521,`position_y`=3825.948,`position_z`=138.826 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3478.928,3860.734,137.685,0,0,0,100,0),
(@PATH,2,3468.246,3864.527,144.41382,0,0,0,100,0),
(@PATH,3,3436.838,3871.05,145.8949,0,0,0,100,0),
(@PATH,4,3400.958,3849.562,144.1248,0,0,0,100,0),
(@PATH,5,3436.838,3871.05,145.8949,0,0,0,100,0),
(@PATH,6,3468.246,3864.527,144.41382,0,0,0,100,0),
(@PATH,7,3478.62,3860.805,137.685,0,0,0,100,0),
(@PATH,8,3494.521,3825.948,138.826,0,0,0,100,0),
(@PATH,9,3501.794,3816.455,134.85043,0,0,0,100,0),
(@PATH,10,3506.306,3810.192,137.24022,0,0,0,100,0),
(@PATH,11,3522.751,3787.881,134.6801,0,0,0,100,0),
(@PATH,12,3540.783,3744.365,126.4502,0,0,0,100,0),
(@PATH,13,3549.274,3716.644,128.705,0,0,0,100,0),
(@PATH,14,3561.855,3703.672,126.12941,0,0,0,100,0),
(@PATH,15,3568.691,3697.024,121.05640,0,0,0,100,0),
(@PATH,16,3575.249,3691.114,124.98943,0,0,0,100,0),
(@PATH,17,3581.976,3684.394,125.7408,0,0,0,100,0),
(@PATH,18,3604.484,3652.555,122.0869,0,0,0,100,0),
(@PATH,19,3614.723,3618.143,122.672,0,0,0,100,0),
(@PATH,20,3643.934,3580.083,108.1123,0,0,0,100,0),
(@PATH,21,3654.955,3560.409,102.2775,0,0,0,100,0),
(@PATH,22,3643.917,3548.586,104.79498,0,0,0,100,0),
(@PATH,23,3639.404,3543.252,102.43231,0,0,0,100,0),
(@PATH,24,3634.628,3537.618,107.24618,0,0,0,100,0),
(@PATH,25,3630.19,3531.329,109.6528,0,0,0,100,0),
(@PATH,26,3634.628,3537.618,107.24618,0,0,0,100,0),
(@PATH,27,3639.404,3543.252,102.43231,0,0,0,100,0),
(@PATH,28,3643.917,3548.586,104.79498,0,0,0,100,0),
(@PATH,29,3654.955,3560.409,102.2775,0,0,0,100,0),
(@PATH,30,3643.934,3580.083,108.1123,0,0,0,100,0),
(@PATH,31,3614.723,3618.143,122.672,0,0,0,100,0),
(@PATH,32,3604.569,3652.428,122.0869,0,0,0,100,0),
(@PATH,33,3581.976,3684.394,125.7408,0,0,0,100,0),
(@PATH,34,3575.249,3691.114,124.98943,0,0,0,100,0),
(@PATH,35,3568.691,3697.024,121.05640,0,0,0,100,0),
(@PATH,36,3561.855,3703.672,126.12941,0,0,0,100,0),
(@PATH,37,3549.274,3716.644,128.705,0,0,0,100,0),
(@PATH,38,3540.783,3744.365,126.4502,0,0,0,100,0),
(@PATH,39,3522.751,3787.881,134.6801,0,0,0,100,0),
(@PATH,40,3506.306,3810.192,137.24022,0,0,0,100,0),
(@PATH,41,3501.794,3816.455,134.85043,0,0,0,100,0),
(@PATH,42,3494.521,3825.948,138.826,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67684;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2701.955,`position_y`=3523.686,`position_z`=138.8626 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2715.25,3553.21,136.9013,0,0,0,100,0),
(@PATH,2,2736.884,3574.413,139.223,0,0,0,100,0),
(@PATH,3,2771.713,3570.953,143.5453,0,0,0,100,0),
(@PATH,4,2792.225,3585.327,149.4203,0,0,0,100,0),
(@PATH,5,2771.713,3570.953,143.5453,0,0,0,100,0),
(@PATH,6,2736.884,3574.413,139.223,0,0,0,100,0),
(@PATH,7,2715.25,3553.21,136.9013,0,0,0,100,0),
(@PATH,8,2701.955,3523.686,138.8626,0,0,0,100,0),
(@PATH,9,2674.59,3498.665,138.4444,0,0,0,100,0),
(@PATH,10,2658.199,3478.996,136.3828,0,0,0,100,0),
(@PATH,11,2657.239,3466.174,137.92674,0,0,0,100,0),
(@PATH,12,2656.176,3454.785,135.19179,0,0,0,100,0),
(@PATH,13,2656.075,3446.561,139.651,0,0,0,100,0),
(@PATH,14,2644.711,3405.757,145.9891,0,0,0,100,0),
(@PATH,15,2628.007,3385.215,146.6058,0,0,0,100,0),
(@PATH,16,2644.711,3405.757,145.9891,0,0,0,100,0),
(@PATH,17,2656.075,3446.561,139.651,0,0,0,100,0),
(@PATH,18,2656.176,3454.785,135.19179,0,0,0,100,0),
(@PATH,19,2657.239,3466.174,137.92674,0,0,0,100,0),
(@PATH,20,2658.199,3478.996,136.3828,0,0,0,100,0),
(@PATH,21,2674.59,3498.665,138.4444,0,0,0,100,0),
(@PATH,22,2701.955,3523.686,138.8626,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67686;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2748.586,`position_y`=3009.797,`position_z`=120.4969 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2767.257,3018.985,122.9459,0,0,0,100,0),
(@PATH,2,2801.052,3000.443,124.6497,0,0,0,100,0),
(@PATH,3,2812.721,2982.991,116.0997,0,0,0,100,0),
(@PATH,4,2832.336,2996.546,120.5997,0,0,0,100,0),
(@PATH,5,2830.507,3010.039,123.0247,0,0,0,100,0),
(@PATH,6,2814.308,3024.928,124.6497,0,0,0,100,0),
(@PATH,7,2801.464,3020.028,127.3997,0,0,0,100,0),
(@PATH,8,2793.697,3003.944,124.4459,0,0,0,100,0),
(@PATH,9,2772.344,2989.09,119.8073,0,0,0,100,0),
(@PATH,10,2748.876,2991.988,115.8422,0,0,0,100,0),
(@PATH,11,2748.586,3009.797,120.4969,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67688;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2834.561,`position_y`=3001.471,`position_z`=120.8159 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2840.711,3031.622,124.3159,0,0,0,100,0),
(@PATH,2,2857.4,3067.843,129.3599,0,0,0,100,0),
(@PATH,3,2899.201,3080.454,126.1296,0,0,0,100,0),
(@PATH,4,2857.4,3067.843,129.3599,0,0,0,100,0),
(@PATH,5,2840.711,3031.622,124.3159,0,0,0,100,0),
(@PATH,6,2834.561,3001.471,120.8159,0,0,0,100,0),
(@PATH,7,2822.727,2965.426,115.3626,0,0,0,100,0),
(@PATH,8,2818.008,2927.768,116.7844,0,0,0,100,0),
(@PATH,9,2822.727,2965.426,115.3626,0,0,0,100,0),
(@PATH,10,2834.561,3001.471,120.8159,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67689;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2848.075,`position_y`=3093.444,`position_z`=132.7349 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2858.285,3097.977,136.87012,0,0,0,100,0),
(@PATH,2,2871.172,3100.596,135.9064,0,0,0,100,0),
(@PATH,3,2892.202,3086.498,130.2546,0,0,0,100,0),
(@PATH,4,2903.099,3082.905,125.89697,0,0,0,100,0),
(@PATH,5,2916.77,3078.38,118.1466,0,0,0,100,0),
(@PATH,6,2931.368,3085.41,124.3966,0,0,0,100,0),
(@PATH,7,2913.329,3108.087,136.5948,0,0,0,100,0),
(@PATH,8,2901.257,3107.051,132.31752,0,0,0,100,0),
(@PATH,9,2888.116,3103.573,134.9064,0,0,0,100,0),
(@PATH,10,2874.584,3076.865,130.3796,0,0,0,100,0),
(@PATH,11,2864.657,3041.682,126.3279,0,0,0,100,0),
(@PATH,12,2843.429,3035.965,122.9529,0,0,0,100,0),
(@PATH,13,2826.314,3047.521,129.3029,0,0,0,100,0),
(@PATH,14,2827.662,3066.208,130.5529,0,0,0,100,0),
(@PATH,15,2848.075,3093.444,132.7349,0,0,0,100,0);

-- Pathing for Nether Ray Entry: 18880
SET @NPC := 67690;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3211.062,`position_y`=2915.2,`position_z`=126.1535 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3234.818,2931.539,132.6105,0,0,0,100,0),
(@PATH,2,3211.062,2915.2,126.1535,0,0,0,100,0),
(@PATH,3,3180.997,2899.493,122.4443,0,0,0,100,0),
(@PATH,4,3155.461,2898.618,109.8302,0,0,0,100,0),
(@PATH,5,3130.092,2921.61,111.8091,0,0,0,100,0),
(@PATH,6,3101.947,2887.793,107.7605,0,0,0,100,0),
(@PATH,7,3092.268,2889.189,100.72347,0,0,0,100,0),
(@PATH,8,3080.941,2889.102,101.0506,0,0,0,100,0),
(@PATH,9,3074.878,2890.193,101.54104,0,0,0,100,0),
(@PATH,10,3061.921,2893.191,100.51373,0,0,0,100,0),
(@PATH,11,3056.108,2895.22,95.62936,0,0,0,100,0),
(@PATH,12,3046.537,2896.025,88.50332,0,0,0,100,0),
(@PATH,13,3036.618,2898.464,90.65160,0,0,0,100,0),
(@PATH,14,3026.08,2901.524,87.18484,0,0,0,100,0),
(@PATH,15,2994.799,2882.332,78.04801,0,0,0,100,0),
(@PATH,16,2999.258,2856.904,68.22955,0,0,0,100,0),
(@PATH,17,2981.474,2831.317,66.73794,0,0,0,100,0),
(@PATH,18,2981.693,2807.114,58.98794,0,0,0,100,0),
(@PATH,19,2981.474,2831.317,66.73794,0,0,0,100,0),
(@PATH,20,2999.154,2856.777,68.22955,0,0,0,100,0),
(@PATH,21,2994.799,2882.332,78.04801,0,0,0,100,0),
(@PATH,22,3026.08,2901.524,87.18484,0,0,0,100,0),
(@PATH,23,3036.618,2898.464,90.65160,0,0,0,100,0),
(@PATH,24,3046.537,2896.025,88.50332,0,0,0,100,0),
(@PATH,25,3056.108,2895.22,95.62936,0,0,0,100,0),
(@PATH,26,3061.921,2893.191,100.51373,0,0,0,100,0),
(@PATH,27,3074.878,2890.193,101.54104,0,0,0,100,0),
(@PATH,28,3080.941,2889.102,101.0506,0,0,0,100,0),
(@PATH,29,3092.268,2889.189,100.72347,0,0,0,100,0),
(@PATH,30,3101.77,2887.565,107.7605,0,0,0,100,0),
(@PATH,31,3130.092,2921.61,111.8091,0,0,0,100,0),
(@PATH,32,3155.461,2898.618,109.8302,0,0,0,100,0),
(@PATH,33,3180.997,2899.493,122.4443,0,0,0,100,0),
(@PATH,34,3211.062,2915.2,126.1535,0,0,0,100,0);

-- Pathing for Shaleskin Flayer Entry: 20210
SET @NPC := 71872;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3367.845,`position_y`=4044.642,`position_z`=166.1468 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3366.639,4009.914,176.67,0,1,0,100,0),
(@PATH,2,3368.435,4004.178,177.404144,0,1,0,100,0),
(@PATH,3,3370.942,3996.480,175.153839,0,1,0,100,0),
(@PATH,4,3373.951,3984.955,186.3951,0,1,0,100,0),
(@PATH,5,3365.027,3955.574,192.7446,0,1,0,100,0),
(@PATH,6,3341.767,3935.888,190.3696,0,1,0,100,0),
(@PATH,7,3318.116,3920.932,189.6091,0,1,0,100,0),
(@PATH,8,3291.822,3931.773,180.6205,0,1,0,100,0),
(@PATH,9,3279.326,3936.204,176.748886,0,1,0,100,0),
(@PATH,10,3274.518,3937.024,172.854630,0,1,0,100,0),
(@PATH,11,3266.748,3939.606,175.114761,0,1,0,100,0),
(@PATH,12,3257,3943.094,171.2374,0,1,0,100,0),
(@PATH,13,3221.064,3955.733,165.0594,0,1,0,100,0),
(@PATH,14,3215.425,3985.175,154.1606,0,1,0,100,0),
(@PATH,15,3227.777,3993.394,151.396332,0,1,0,100,0),
(@PATH,16,3233.644,3998.084,146.493988,0,1,0,100,0),
(@PATH,17,3241.634,4004.46,149.7625,0,1,0,100,0),
(@PATH,18,3249.900,4002.525,149.618729,0,1,0,100,0),
(@PATH,19,3258.537,4000.494,145.491760,0,1,0,100,0),
(@PATH,20,3263.390,3999.769,147.094147,0,1,0,100,0),
(@PATH,21,3278.169,3998.145,157.3382,0,1,0,100,0),
(@PATH,22,3294.997,3986.058,163.8382,0,1,0,100,0),
(@PATH,23,3311.89,3996.222,166.142,0,1,0,100,0),
(@PATH,24,3316.447,4016.001,156.5248,0,1,0,100,0),
(@PATH,25,3294.146,4053.942,150.6925,0,1,0,100,0),
(@PATH,26,3301.807,4061.169,149.166290,0,1,0,100,0),
(@PATH,27,3311.557,4068.420,142.918396,0,1,0,100,0),
(@PATH,28,3317.598,4073.995,144.5602,0,1,0,100,0),
(@PATH,29,3341.35,4079.132,143.1019,0,1,0,100,0),
(@PATH,30,3352.074,4063.453,155.245,0,1,0,100,0),
(@PATH,31,3367.845,4044.642,166.1468,0,1,0,100,0);

-- Pathing for Shaleskin Flayer Entry: 20210
SET @NPC := 71879;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2648.76,`position_y`=3549.557,`position_z`=137.8162 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2666.568,3548.781,135.4412,0,1,0,100,0),
(@PATH,2,2648.76,3549.557,137.8162,0,1,0,100,0),
(@PATH,3,2633.136,3554.922,140.6537,0,1,0,100,0),
(@PATH,4,2642.836,3586.615,151.5832,0,1,0,100,0),
(@PATH,5,2647.962,3603.651,160.0796,0,1,0,100,0),
(@PATH,6,2633.64,3560.175,142.5662,0,1,0,100,0),
(@PATH,7,2629.507,3533.575,138.5287,0,1,0,100,0),
(@PATH,8,2648.173,3501.048,142.4444,0,1,0,100,0),
(@PATH,9,2656.382,3500.899,140.968567,0,1,0,100,0),
(@PATH,10,2665.253,3500.416,135.201950,0,1,0,100,0),
(@PATH,11,2673.378,3499.821,137.783707,0,1,0,100,0),
(@PATH,12,2687.637,3500.182,138.9444,0,1,0,100,0),
(@PATH,13,2721.845,3517.543,138.1126,0,1,0,100,0),
(@PATH,14,2733.924,3521.773,137.1899,0,1,0,100,0),
(@PATH,15,2733.155,3482.243,138.363,0,1,0,100,0),
(@PATH,16,2715.966,3450.111,142.1551,0,1,0,100,0),
(@PATH,17,2706.084,3457.206,142.5301,0,1,0,100,0),
(@PATH,18,2683.547,3442.403,143.1151,0,1,0,100,0),
(@PATH,19,2682.677,3466.437,142.3651,0,1,0,100,0),
(@PATH,20,2654.926,3434.49,143.651,0,1,0,100,0),
(@PATH,21,2624.556,3430.113,144.4111,0,1,0,100,0),
(@PATH,22,2609.411,3420.988,146.5361,0,1,0,100,0),
(@PATH,23,2600.413,3394.266,144.4808,0,1,0,100,0),
(@PATH,24,2609.411,3420.988,146.5361,0,1,0,100,0),
(@PATH,25,2624.556,3430.113,144.4111,0,1,0,100,0),
(@PATH,26,2654.926,3434.49,143.651,0,1,0,100,0),
(@PATH,27,2682.677,3466.437,142.3651,0,1,0,100,0),
(@PATH,28,2683.547,3442.403,143.1151,0,1,0,100,0),
(@PATH,29,2706.084,3457.206,142.5301,0,1,0,100,0),
(@PATH,30,2715.966,3450.111,142.1551,0,1,0,100,0),
(@PATH,31,2733.155,3482.243,138.363,0,1,0,100,0),
(@PATH,32,2733.924,3521.773,137.1899,0,1,0,100,0),
(@PATH,33,2721.845,3517.543,138.1126,0,1,0,100,0),
(@PATH,34,2687.637,3500.182,138.9444,0,1,0,100,0),
(@PATH,35,2673.378,3499.821,137.783707,0,1,0,100,0),
(@PATH,36,2665.253,3500.416,135.201950,0,1,0,100,0),
(@PATH,37,2656.382,3500.899,140.968567,0,1,0,100,0),
(@PATH,38,2648.173,3501.048,142.4444,0,1,0,100,0),
(@PATH,39,2629.507,3533.575,138.5287,0,1,0,100,0),
(@PATH,40,2633.64,3560.175,142.5662,0,1,0,100,0),
(@PATH,41,2647.962,3603.651,160.0796,0,1,0,100,0),
(@PATH,42,2642.836,3586.615,151.5832,0,1,0,100,0),
(@PATH,43,2633.168,3555.064,140.6537,0,1,0,100,0),
(@PATH,44,2648.76,3549.557,137.8162,0,1,0,100,0);

-- Pathing for Nether Dragon Entry: 20332
SET @NPC := 72241;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4015.625,`position_y`=1375.597,`position_z`=-126.2281 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3993.205,1362.504,-126.3612,0,0,0,100,0),
(@PATH,2,4015.625,1375.597,-126.2281,0,0,0,100,0),
(@PATH,3,4023.942,1396.098,-130.608719,0,0,0,100,0),
(@PATH,4,4026.553,1401.912,-126.9327,0,0,0,100,0),
(@PATH,5,4031.12,1440.92,-123.1165,0,0,0,100,0),
(@PATH,6,4042.615,1481.239,-120.7033,0,0,0,100,0),
(@PATH,7,4074.899,1492.06,-119.7024,0,0,0,100,0),
(@PATH,8,4120.914,1499.665,-110.4685,0,0,0,100,0),
(@PATH,9,4146.447,1478.963,-118.314,0,0,0,100,0),
(@PATH,10,4178.771,1485.569,-122.8746,0,0,0,100,0),
(@PATH,11,4187.719,1485.892,-127.801094,0,0,0,100,0),
(@PATH,12,4199.382,1485.576,-127.4996,0,0,0,100,0),
(@PATH,13,4187.719,1485.892,-127.801094,0,0,0,100,0),
(@PATH,14,4178.91,1485.611,-122.8746,0,0,0,100,0),
(@PATH,15,4146.447,1478.963,-118.314,0,0,0,100,0),
(@PATH,16,4120.914,1499.665,-110.4685,0,0,0,100,0),
(@PATH,17,4074.899,1492.06,-119.7024,0,0,0,100,0),
(@PATH,18,4042.615,1481.239,-120.7033,0,0,0,100,0),
(@PATH,19,4031.12,1440.92,-123.1165,0,0,0,100,0),
(@PATH,20,4026.553,1401.912,-126.9327,0,0,0,100,0),
(@PATH,21,4023.942,1396.098,-130.608719,0,0,0,100,0),
(@PATH,22,4015.625,1375.597,-126.2281,0,0,0,100,0);

-- Pathing for Nether Dragon Entry: 20332
SET @NPC := 72242;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3963.911,`position_y`=1575.182,`position_z`=-29.98592 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3951.161133,1572.015015,-36.459148,0,0,0,100,0),
(@PATH,2,3933.130615,1566.745728,-46.080715,0,0,0,100,0),
(@PATH,3,3918.786865,1560.240112,-56.230549,0,0,0,100,0),
(@PATH,4,3908.367,1548.98,-65.75422,0,0,0,100,0),
(@PATH,5,3922.72,1533.55,-78.62922,0,0,0,100,0),
(@PATH,6,3959.93,1523.56,-100.9522,0,0,0,100,0),
(@PATH,7,3980.386475,1517.487,-112.395996,0,0,0,100,0),
(@PATH,8,4000.854,1504.009,-116.9818,0,0,0,100,0),
(@PATH,9,4024.555,1466.375,-120.6165,0,0,0,100,0),
(@PATH,10,4023.507,1434.695,-124.2415,0,0,0,100,0),
(@PATH,11,4024.031,1400.242,-128.8077,0,0,0,100,0),
(@PATH,12,4023.507,1434.695,-124.2415,0,0,0,100,0),
(@PATH,13,4024.555,1466.375,-120.6165,0,0,0,100,0),
(@PATH,14,4000.854,1504.009,-116.9818,0,0,0,100,0),
(@PATH,15,3980.386475,1517.487,-112.39599,0,0,0,100,0),
(@PATH,16,3959.93,1523.56,-100.9522,0,0,0,100,0),
(@PATH,17,3922.72,1533.55,-78.62922,0,0,0,100,0),
(@PATH,18,3908.367,1548.98,-65.75422,0,0,0,100,0),
(@PATH,19,3918.786865,1560.240,-56.23054,0,0,0,100,0),
(@PATH,20,3933.130615,1566.745,-46.08071,0,0,0,100,0),
(@PATH,21,3951.161133,1572.015,-36.45914,0,0,0,100,0),
(@PATH,22,3963.911,1575.182,-29.98592,0,0,0,100,0),
(@PATH,23,3994.548,1579.995,-14.14009,0,0,0,100,0),
(@PATH,24,4029.739,1577.882,4.271389,0,0,0,100,0),
(@PATH,25,4060.888,1579.013,16.68998,0,0,0,100,0),
(@PATH,26,4029.739,1577.882,4.271389,0,0,0,100,0),
(@PATH,27,3994.585,1579.99,-14.14009,0,0,0,100,0),
(@PATH,28,3963.911,1575.182,-29.98592,0,0,0,100,0);

-- Pathing for Eye of Culuthas Entry: 20394
SET @NPC := 72356;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4574.177,`position_y`=2582.585,`position_z`=196.8039 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4581.819,2612.694,196.9925,0,0,0,100,0),
(@PATH,2,4574.177,2582.585,196.8039,0,0,0,100,0),
(@PATH,3,4572.471,2543.21,194.4042,0,0,0,100,0),
(@PATH,4,4566.249,2521.063,184.7399,0,0,0,100,0),
(@PATH,5,4557.073,2491.929,170.5824,0,0,0,100,0),
(@PATH,6,4544.432,2456.955,155.9754,0,0,0,100,0),
(@PATH,7,4537.792,2425.746,146.6794,0,0,0,100,0),
(@PATH,8,4531.627,2393.09,141.5395,0,0,0,100,0),
(@PATH,9,4537.75,2425.51,146.6794,0,0,0,100,0),
(@PATH,10,4544.432,2456.955,155.9754,0,0,0,100,0),
(@PATH,11,4557.073,2491.929,170.5824,0,0,0,100,0),
(@PATH,12,4566.249,2521.063,184.7399,0,0,0,100,0),
(@PATH,13,4572.471,2543.21,194.4042,0,0,0,100,0),
(@PATH,14,4574.177,2582.585,196.8039,0,0,0,100,0);

-- Pathing for Eye of Culuthas Entry: 20394
SET @NPC := 72361;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4724.262,`position_y`=2379.566,`position_z`=198.4699 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4664.497,2366.81,188.7332,0,0,0,100,0),
(@PATH,2,4629.371,2338.715,176.7445,0,0,0,100,0),
(@PATH,3,4614.613,2367.734,187.5365,0,0,0,100,0),
(@PATH,4,4597.512,2392.366,192.0093,0,0,0,100,0),
(@PATH,5,4603.895,2423.138,195.0877,0,0,0,100,0),
(@PATH,6,4597.512,2392.366,192.0093,0,0,0,100,0),
(@PATH,7,4614.613,2367.734,187.5365,0,0,0,100,0),
(@PATH,8,4629.371,2338.715,176.7445,0,0,0,100,0),
(@PATH,9,4664.46,2366.802,188.7332,0,0,0,100,0),
(@PATH,10,4691.033,2378.478,194.8672,0,0,0,100,0),
(@PATH,11,4724.262,2379.566,198.4699,0,0,0,100,0);

-- Pathing for Eye of Culuthas Entry: 20394
SET @NPC := 72359;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4545.216,`position_y`=2366.726,`position_z`=142.7543 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4566.693,2321.677,146.0354,0,0,0,100,0),
(@PATH,2,4599.825,2297.896,153.2209,0,0,0,100,0),
(@PATH,3,4620.302,2296.565,158.4346,0,0,0,100,0),
(@PATH,4,4633.196,2308.325,163.6382,0,0,0,100,0),
(@PATH,5,4629.893,2337.082,175.9945,0,0,0,100,0),
(@PATH,6,4661.949,2365.652,188.1765,0,0,0,100,0),
(@PATH,7,4678.245,2369.857,192.1172,0,0,0,100,0),
(@PATH,8,4669.796,2396.104,191.7422,0,0,0,100,0),
(@PATH,9,4678.245,2369.857,192.1172,0,0,0,100,0),
(@PATH,10,4661.949,2365.652,188.1765,0,0,0,100,0),
(@PATH,11,4629.893,2337.082,175.9945,0,0,0,100,0),
(@PATH,12,4633.196,2308.325,163.6382,0,0,0,100,0),
(@PATH,13,4620.302,2296.565,158.4346,0,0,0,100,0),
(@PATH,14,4599.825,2297.896,153.2209,0,0,0,100,0),
(@PATH,15,4566.693,2321.677,146.0354,0,0,0,100,0),
(@PATH,16,4545.216,2366.726,142.7543,0,0,0,100,0),
(@PATH,17,4538.641,2392.494,142.3793,0,0,0,100,0),
(@PATH,18,4499.992,2411.276,133.2375,0,0,0,100,0),
(@PATH,19,4538.641,2392.494,142.3793,0,0,0,100,0),
(@PATH,20,4545.216,2366.726,142.7543,0,0,0,100,0);

-- Pathing for Eye of Culuthas Entry: 20394
SET @NPC := 72355;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4615.711,`position_y`=2602.974,`position_z`=204.4271 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4594.127,2637.872,195.5317,0,0,0,100,0),
(@PATH,2,4602.311,2657.53,192.6531,0,0,0,100,0),
(@PATH,3,4614.258,2686.23,186.5977,0,0,0,100,0),
(@PATH,4,4616.129,2705.724,180.9353,0,0,0,100,0),
(@PATH,5,4617.279,2739.662,170.0329,0,0,0,100,0),
(@PATH,6,4616.129,2705.724,180.9353,0,0,0,100,0),
(@PATH,7,4614.258,2686.23,186.5977,0,0,0,100,0),
(@PATH,8,4602.311,2657.53,192.6531,0,0,0,100,0),
(@PATH,9,4594.127,2637.872,195.5317,0,0,0,100,0),
(@PATH,10,4615.708,2602.998,204.4271,0,0,0,100,0),
(@PATH,11,4649.18,2602.585,208.8828,0,0,0,100,0),
(@PATH,12,4692.474,2599.164,209.7667,0,0,0,100,0),
(@PATH,13,4704.08,2612.966,210.41,0,0,0,100,0),
(@PATH,14,4692.474,2599.164,209.7667,0,0,0,100,0),
(@PATH,15,4649.18,2602.585,208.8828,0,0,0,100,0),
(@PATH,16,4615.711,2602.974,204.4271,0,0,0,100,0);

-- Pathing for Eye of Culuthas Entry: 20394
SET @NPC := 72354;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4522.624,`position_y`=2679.764,`position_z`=176.6805 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4531.139,2677.394,176.5555,0,0,0,100,0),
(@PATH,2,4547.688,2673.579,176.7999,0,0,0,100,0),
(@PATH,3,4563.968,2673.638,178.2999,0,0,0,100,0),
(@PATH,4,4581.804,2681.135,181.2904,0,0,0,100,0),
(@PATH,5,4603.715,2690.732,185.2227,0,0,0,100,0),
(@PATH,6,4581.804,2681.135,181.2904,0,0,0,100,0),
(@PATH,7,4563.968,2673.638,178.2999,0,0,0,100,0),
(@PATH,8,4547.688,2673.579,176.7999,0,0,0,100,0),
(@PATH,9,4531.139,2677.394,176.5555,0,0,0,100,0),
(@PATH,10,4522.624,2679.764,176.6805,0,0,0,100,0);

-- Pathing for Ar'kelos Entry: 19494
SET @NPC := 69855;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2240.612,`position_y`=2231.969,`position_z`=101.7543 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2235.431,2232.697,101.3736,0,0,0,100,0),
(@PATH,2,2234.174,2236.417,101.1358,0,0,0,100,0),
(@PATH,3,2237.611,2241.542,101.1581,0,0,0,100,0),
(@PATH,4,2241.375,2242.135,101.3886,0,0,0,100,0),
(@PATH,5,2243.609,2240.113,101.623,0,0,0,100,0),
(@PATH,6,2243.737,2236.394,101.7843,0,0,0,100,0),
(@PATH,7,2240.612,2231.969,101.7543,0,0,0,100,0);

-- Pathing for Cohlien Frostweaver Entry: 19545
SET @NPC := 69958;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2218.052,`position_y`=2155.52,`position_z`=75.16641 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2227.514,2146.222,74.54141,0,0,0,100,0),
(@PATH,2,2238.457,2156.491,77.7053,0,0,0,100,0),
(@PATH,3,2246.653,2163.828,80.7053,0,0,0,100,0),
(@PATH,4,2255.551,2174.134,84.49949,0,0,0,100,0),
(@PATH,5,2264.292,2184.693,87.87449,0,0,0,100,0),
(@PATH,6,2270.136,2192.784,90.81113,0,0,0,100,0),
(@PATH,7,2264.292,2184.693,87.87449,0,0,0,100,0),
(@PATH,8,2255.551,2174.134,84.49949,0,0,0,100,0),
(@PATH,9,2246.8,2163.955,80.7053,0,0,0,100,0),
(@PATH,10,2238.698,2156.714,77.7053,0,0,0,100,0),
(@PATH,11,2227.514,2146.222,74.54141,0,0,0,100,0),
(@PATH,12,2218.052,2155.52,75.16641,0,0,0,100,0),
(@PATH,13,2206.56,2146.317,72.41641,0,0,0,100,0),
(@PATH,14,2198.984,2154.768,71.77188,0,0,0,100,0),
(@PATH,15,2195.368,2159.292,71.64688,0,0,0,100,0),
(@PATH,16,2199.257,2163.273,73.27188,0,0,0,100,0),
(@PATH,17,2195.368,2159.292,71.64688,0,0,0,100,0),
(@PATH,18,2198.984,2154.768,71.77188,0,0,0,100,0),
(@PATH,19,2206.56,2146.317,72.41641,0,0,0,100,0),
(@PATH,20,2218.052,2155.52,75.16641,0,0,0,100,0);

-- Pathing for Abjurist Belmara Entry: 19546
SET @NPC := 69959;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2162.673,`position_y`=2239.201,`position_z`=74.96153 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2161.253,2246.413,75.08653,0,0,0,100,0),
(@PATH,2,2167.947,2252.325,75.3343,0,0,0,100,0),
(@PATH,3,2176.671,2259.385,76.0843,0,0,0,100,0),
(@PATH,4,2167.947,2252.325,75.3343,0,0,0,100,0),
(@PATH,5,2161.253,2246.413,75.08653,0,0,0,100,0),
(@PATH,6,2162.673,2239.201,74.96153,0,0,0,100,0),
(@PATH,7,2170.977,2229.723,75.35621,0,0,0,100,0),
(@PATH,8,2173.582,2222.547,75.48121,0,0,0,100,0),
(@PATH,9,2172.486,2216.009,74.85621,0,0,0,100,0),
(@PATH,10,2171.116,2206.345,73.35621,0,0,0,100,0),
(@PATH,11,2171.409,2196.346,72.16417,0,0,0,100,0),
(@PATH,12,2173.672,2191.277,71.66417,0,0,0,100,0),
(@PATH,13,2177.406,2192.71,72.91417,0,0,0,100,0),
(@PATH,14,2173.672,2191.277,71.66417,0,0,0,100,0),
(@PATH,15,2171.411,2196.131,72.16417,0,0,0,100,0),
(@PATH,16,2171.116,2206.345,73.35621,0,0,0,100,0),
(@PATH,17,2172.486,2216.009,74.85621,0,0,0,100,0),
(@PATH,18,2173.582,2222.547,75.48121,0,0,0,100,0),
(@PATH,19,2170.977,2229.723,75.35621,0,0,0,100,0),
(@PATH,20,2162.673,2239.201,74.96153,0,0,0,100,0);

-- Pathing for Conjurer Luminrath Entry: 19544
SET @NPC := 69957;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=2308.526,`position_y`=2152.486,`position_z`=89.90528 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,2304.674,2153.754,90.03028,0,0,0,100,0),
(@PATH,2,2308.526,2152.486,89.90528,0,0,0,100,0),
(@PATH,3,2315.141,2149.993,87.90528,0,0,0,100,0),
(@PATH,4,2317.099,2141.939,86.40528,0,0,0,100,0),
(@PATH,5,2312.283,2133.227,86.0655,0,0,0,100,0),
(@PATH,6,2304.422,2127.045,83.9405,0,0,0,100,0),
(@PATH,7,2300.402,2122.592,82.5655,0,0,0,100,0),
(@PATH,8,2293.575,2129.682,83.01796,0,0,0,100,0),
(@PATH,9,2280.72,2142.293,84.05183,0,0,0,100,0),
(@PATH,10,2277.714,2145.194,83.19107,0,0,0,100,0),
(@PATH,11,2271.714,2150.194,79.69107,0,0,0,100,0),
(@PATH,12,2266.208,2154.595,81.3303,0,0,0,100,0),
(@PATH,13,2256.744,2164.514,82.0803,0,0,0,100,0),
(@PATH,14,2266.208,2154.595,81.3303,0,0,0,100,0),
(@PATH,15,2271.714,2150.194,79.69107,0,0,0,100,0),
(@PATH,16,2277.714,2145.194,83.19107,0,0,0,100,0),
(@PATH,17,2280.72,2142.293,84.05183,0,0,0,100,0),
(@PATH,18,2293.575,2129.682,83.01796,0,0,0,100,0),
(@PATH,19,2300.182,2122.348,82.5655,0,0,0,100,0),
(@PATH,20,2304.185,2126.818,83.9405,0,0,0,100,0),
(@PATH,21,2312.283,2133.227,86.0655,0,0,0,100,0),
(@PATH,22,2317.099,2141.939,86.40528,0,0,0,100,0),
(@PATH,23,2315.141,2149.993,87.90528,0,0,0,100,0),
(@PATH,24,2308.526,2152.486,89.90528,0,0,0,100,0);

-- Pathing for Sundered Rumbler Entry: 18881
SET @NPC := 72537;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3285.168,`position_y`=3666.935,`position_z`=122.3814 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3285.266,3699.622,122.6314,0,0,0,100,0),
(@PATH,2,3285.168,3666.935,122.3814,0,0,0,100,0),
(@PATH,3,3271.159,3654.384,124.4546,0,0,0,100,0),
(@PATH,4,3285.168,3666.935,122.3814,0,0,0,100,0),
(@PATH,5,3285.266,3699.622,122.6314,0,0,0,100,0),
(@PATH,6,3283.2567,3707.5315,124.52155,0,0,0,100,0),
(@PATH,7,3282.0067,3712.5315,122.27155,0,0,0,100,0),
(@PATH,8,3281.2567,3715.0315,121.52155,0,0,0,100,0),
(@PATH,9,3280.7567,3718.0315,121.27155,0,0,0,100,0),
(@PATH,10,3280.2567,3720.0315,120.52155,0,0,0,100,0),
(@PATH,11,3276.763,3732.637,120.2214,0,0,0,100,0),
(@PATH,12,3238.595,3748.578,121.8806,0,0,0,100,0),
(@PATH,13,3237.837,3780.781,124.1419,0,0,0,100,0),
(@PATH,14,3238.595,3748.578,121.8806,0,0,0,100,0),
(@PATH,15,3276.763,3732.637,120.2214,0,0,0,100,0),
(@PATH,16,3280.2567,3720.0315,120.52155,0,0,0,100,0),
(@PATH,17,3280.7567,3718.0315,121.27155,0,0,0,100,0),
(@PATH,18,3281.2567,3715.0315,121.52155,0,0,0,100,0),
(@PATH,19,3282.0067,3712.5315,122.27155,0,0,0,100,0),
(@PATH,20,3283.2567,3707.5315,124.52155,0,0,0,100,0);

-- Pathing for Sundered Rumbler Entry: 18881
SET @NPC := 67694;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3300.63,`position_y`=3524.814,`position_z`=119.3577 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3301.806,3478.514,108.0464,0,0,0,100,0),
(@PATH,2,3300.63,3524.814,119.3577,0,0,0,100,0),
(@PATH,3,3314.206,3535.807,122.2244,0,0,0,100,0),
(@PATH,4,3314.667,3565.323,121.8494,0,0,0,100,0),
(@PATH,5,3295.182,3584.966,121.833,0,0,0,100,0),
(@PATH,6,3296.069,3616.939,124.855,0,0,0,100,0),
(@PATH,7,3317.645,3642.473,123.6244,0,0,0,100,0),
(@PATH,8,3281.766,3673.759,122.3814,0,0,0,100,0),
(@PATH,9,3317.645,3642.473,123.6244,0,0,0,100,0),
(@PATH,10,3296.069,3616.939,124.855,0,0,0,100,0),
(@PATH,11,3295.182,3584.966,121.833,0,0,0,100,0),
(@PATH,12,3314.667,3565.323,121.8494,0,0,0,100,0),
(@PATH,13,3314.206,3535.807,122.2244,0,0,0,100,0),
(@PATH,14,3300.63,3524.814,119.3577,0,0,0,100,0);

-- Pathing for Sundered Rumbler Entry: 18881
SET @NPC := 67695;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3283.052,`position_y`=3531.829,`position_z`=117.1162 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3257.882,3501.52,109.848,0,0,0,100,0),
(@PATH,2,3251.0377,3500.4235,107.93321,0,0,0,100,0),
(@PATH,3,3247.0377,3499.9235,106.93321,0,0,0,100,0),
(@PATH,4,3209.488,3493.788,105.6449,0,0,0,100,0),
(@PATH,5,3191.958,3480.165,99.16507,0,0,0,100,0),
(@PATH,6,3192.7714,3457.4731,97.96445,0,0,0,100,0),
(@PATH,7,3193.0214,3455.4731,97.21445,0,0,0,100,0),
(@PATH,8,3193.0214,3452.4731,96.46445,0,0,0,100,0),
(@PATH,9,3193.0214,3450.4731,95.71445,0,0,0,100,0),
(@PATH,10,3193.2714,3448.4731,94.71445,0,0,0,100,0),
(@PATH,11,3193.2714,3446.4731,94.21445,0,0,0,100,0),
(@PATH,12,3193.585,3438.282,93.76384,0,0,0,100,0),
(@PATH,13,3175.364,3421.07,94.23314,0,0,0,100,0),
(@PATH,14,3175.134,3400.337,95.73314,0,0,0,100,0),
(@PATH,15,3165.382,3385.651,100.0248,0,0,0,100,0),
(@PATH,16,3175.134,3400.337,95.73314,0,0,0,100,0),
(@PATH,17,3175.364,3421.07,94.23314,0,0,0,100,0),
(@PATH,18,3193.585,3438.282,93.76384,0,0,0,100,0),
(@PATH,19,3193.2714,3446.4731,94.21445,0,0,0,100,0),
(@PATH,20,3193.2714,3448.4731,94.71445,0,0,0,100,0),
(@PATH,21,3193.0214,3450.4731,95.71445,0,0,0,100,0),
(@PATH,22,3193.0214,3452.4731,96.46445,0,0,0,100,0),
(@PATH,23,3193.0214,3455.4731,97.21445,0,0,0,100,0),
(@PATH,24,3192.7714,3457.4731,97.96445,0,0,0,100,0),
(@PATH,25,3191.958,3480.165,99.16507,0,0,0,100,0),
(@PATH,26,3209.488,3493.788,105.6449,0,0,0,100,0),
(@PATH,27,3247.0377,3499.9235,106.93321,0,0,0,100,0),
(@PATH,28,3251.0377,3500.4235,107.93321,0,0,0,100,0),
(@PATH,29,3257.882,3501.52,109.848,0,0,0,100,0),
(@PATH,30,3283.052,3531.829,117.1162,0,0,0,100,0),
(@PATH,31,3281.379,3566.475,118.7789,0,0,0,100,0),
(@PATH,32,3291.429,3581.389,121.958,0,0,0,100,0),
(@PATH,33,3281.379,3566.475,118.7789,0,0,0,100,0),
(@PATH,34,3283.052,3531.829,117.1162,0,0,0,100,0);

-- Pathing for Sundered Rumbler Entry: 18881
SET @NPC := 67696;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3260.27,`position_y`=3469.911,`position_z`=99.7075 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3260.709,3483.817,100.7075,0,0,0,100,0),
(@PATH,2,3260.27,3469.911,99.7075,0,0,0,100,0),
(@PATH,3,3254.799,3462.614,99.6072,0,0,0,100,0),
(@PATH,4,3253.8108,3459.8367,98.7941,0,0,0,100,0),
(@PATH,5,3253.0608,3457.8367,97.7941,0,0,0,100,0),
(@PATH,6,3252.5608,3456.0867,96.5441,0,0,0,100,0),
(@PATH,7,3250.5608,3450.3367,94.0441,0,0,0,100,0),
(@PATH,8,3242.662,3428.51,93.43222,0,0,0,100,0),
(@PATH,9,3226.99,3399.985,94.66531,0,0,0,100,0),
(@PATH,10,3226.587,3388.906,94.66531,0,0,0,100,0),
(@PATH,11,3233.238,3377.579,93.66531,0,0,0,100,0),
(@PATH,12,3228.08,3366.189,93.63511,0,0,0,100,0),
(@PATH,13,3236.872,3342.85,93.31496,0,0,0,100,0),
(@PATH,14,3228.08,3366.189,93.63511,0,0,0,100,0),
(@PATH,15,3233.238,3377.579,93.66531,0,0,0,100,0),
(@PATH,16,3226.587,3388.906,94.66531,0,0,0,100,0),
(@PATH,17,3226.99,3399.985,94.66531,0,0,0,100,0),
(@PATH,18,3242.662,3428.51,93.43222,0,0,0,100,0),
(@PATH,19,3250.5608,3450.3367,94.0441,0,0,0,100,0),
(@PATH,20,3252.5608,3456.0867,96.5441,0,0,0,100,0),
(@PATH,21,3253.0608,3457.8367,97.7941,0,0,0,100,0),
(@PATH,22,3253.8108,3459.8367,98.7941,0,0,0,100,0),
(@PATH,23,3254.799,3462.614,99.6072,0,0,0,100,0),
(@PATH,24,3260.27,3469.911,99.7075,0,0,0,100,0);

-- Pathing for Sundered Rumbler Entry: 18881
SET @NPC := 67697;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=3193.751,`position_y`=3437.182,`position_z`=93.63884 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,3234.859,3432.428,93.43222,0,0,0,100,0),
(@PATH,2,3281.241,3419.181,93.43222,0,0,0,100,0),
(@PATH,3,3305.17,3406.754,93.4439,0,0,0,100,0),
(@PATH,4,3324.777,3383.345,95.8713,0,0,0,100,0),
(@PATH,5,3305.17,3406.754,93.4439,0,0,0,100,0),
(@PATH,6,3281.241,3419.181,93.43222,0,0,0,100,0),
(@PATH,7,3234.859,3432.428,93.43222,0,0,0,100,0),
(@PATH,8,3193.751,3437.182,93.63884,0,0,0,100,0),
(@PATH,9,3175.196,3422.16,94.23314,0,0,0,100,0),
(@PATH,10,3147.319,3422.596,100.6664,0,0,0,100,0),
(@PATH,11,3175.196,3422.16,94.23314,0,0,0,100,0),
(@PATH,12,3193.751,3437.182,93.63884,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74222;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4553.955,`position_y`=2687.114,`position_z`=176.5499 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4549.639,2687.8,176.2999,0,0,0,100,0),
(@PATH,2,4553.955,2687.114,176.5499,0,0,0,100,0),
(@PATH,3,4555.577,2683.206,176.9249,0,0,0,100,0),
(@PATH,4,4553.955,2687.114,176.5499,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74223;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4562.047,`position_y`=2669.278,`position_z`=178.5499 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4562.68,2675.701,178.1749,0,0,0,100,0),
(@PATH,2,4562.047,2669.278,178.5499,0,0,0,100,0),
(@PATH,3,4556.256,2668.143,177.7999,0,0,0,100,0),
(@PATH,4,4562.047,2669.278,178.5499,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74224;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4696.381,`position_y`=2601.714,`position_z`=209.8917 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4702.104,2603.248,210.16,0,0,0,100,0),
(@PATH,2,4696.381,2601.714,209.8917,0,0,0,100,0),
(@PATH,3,4690.812,2596.801,209.8917,0,0,0,100,0),
(@PATH,4,4689.338,2591.425,209.8917,0,0,0,100,0),
(@PATH,5,4690.812,2596.801,209.8917,0,0,0,100,0),
(@PATH,6,4696.381,2601.714,209.8917,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74225;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4694.737,`position_y`=2611.983,`position_z`=209.8917 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4694.698,2628.866,210.7667,0,0,0,100,0),
(@PATH,2,4694.737,2611.983,209.8917,0,0,0,100,0),
(@PATH,3,4688.729,2604.648,209.7667,0,0,0,100,0),
(@PATH,4,4679.191,2599.677,209.5167,0,0,0,100,0),
(@PATH,5,4669.759,2599.583,209.2667,0,0,0,100,0),
(@PATH,6,4682.154,2601.221,209.6417,0,0,0,100,0),
(@PATH,7,4694.737,2611.983,209.8917,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74226;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4608.13,`position_y`=2429.07,`position_z`=195.0877 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4607.922,2424.169,194.9627,0,0,0,100,0),
(@PATH,2,4603.165,2421.986,194.9627,0,0,0,100,0),
(@PATH,3,4597.103,2424.986,195.2854,0,0,0,100,0),
(@PATH,4,4603.165,2421.986,194.9627,0,0,0,100,0),
(@PATH,5,4607.922,2424.169,194.9627,0,0,0,100,0),
(@PATH,6,4608.13,2429.07,195.0877,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74227;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4666.593,`position_y`=2405.013,`position_z`=191.8335 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4663.231,2412.144,191.8335,0,0,0,100,0),
(@PATH,2,4666.593,2405.013,191.8335,0,0,0,100,0),
(@PATH,3,4665.042,2392.39,191.7332,0,0,0,100,0),
(@PATH,4,4657.117,2382.845,191.7332,0,0,0,100,0),
(@PATH,5,4647.556,2381.307,191.7332,0,0,0,100,0),
(@PATH,6,4657.117,2382.845,191.7332,0,0,0,100,0),
(@PATH,7,4665.042,2392.39,191.7332,0,0,0,100,0),
(@PATH,8,4666.593,2405.013,191.8335,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74228;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4726.265,`position_y`=2381.999,`position_z`=198.4699 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4723.63,2385.29,198.4699,0,0,0,100,0),
(@PATH,2,4718.666,2383.238,198.3449,0,0,0,100,0),
(@PATH,3,4721.186,2363.666,198.9685,0,0,0,100,0),
(@PATH,4,4726.265,2381.999,198.4699,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74229;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4705.219,`position_y`=2459.428,`position_z`=240.1093 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4707.024,2478.386,239.8881,0,0,0,100,0),
(@PATH,2,4703.323,2473.484,239.8881,0,0,0,100,0),
(@PATH,3,4702.328,2466.821,240.0131,0,0,0,100,0),
(@PATH,4,4705.219,2459.428,240.1093,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 74230;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4697.593,`position_y`=2505.859,`position_z`=236.6816 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4701.562,2501.556,237.7412,0,0,0,100,0),
(@PATH,2,4697.593,2505.859,236.6816,0,0,0,100,0),
(@PATH,3,4693.739,2504.999,237.5566,0,0,0,100,0),
(@PATH,4,4697.593,2505.859,236.6816,0,0,0,100,0);

-- Pathing for Culuthas Scan Target Dummy Entry: 21157
SET @NPC := 69986;
SET @PATH := @NPC;
UPDATE `creature` SET `id`=21157,`curhealth`=1,`spawndist`=0,`MovementType`=2,`position_x`=4702.083,`position_y`=2488.536,`position_z`=239.2631 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4701.83,2482.624,239.6381,0,0,0,100,0),
(@PATH,2,4704.716,2479.467,239.8881,0,0,0,100,0),
(@PATH,3,4701.83,2482.624,239.6381,0,0,0,100,0),
(@PATH,4,4702.083,2488.536,239.2631,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71708;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4602.324,`position_y`=2706.992,`position_z`=180.9353 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4599.582,2718.879,179.018,0,0,0,100,0),
(@PATH,2,4602.102,2707.148,180.9353,0,0,0,100,0),
(@PATH,3,4625.324,2706.341,181.6853,0,0,0,100,0),
(@PATH,4,4629.149,2677.264,192.0977,0,0,0,100,0),
(@PATH,5,4625.324,2706.341,181.6853,0,0,0,100,0),
(@PATH,6,4602.324,2706.992,180.9353,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71709;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4555.143,`position_y`=2700.897,`position_z`=176.1601 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4565.459,2684.939,178.6749,0,0,0,100,0),
(@PATH,2,4555.143,2700.897,176.1601,0,0,0,100,0),
(@PATH,3,4550.593,2684.636,176.5499,0,0,0,100,0),
(@PATH,4,4555.143,2700.897,176.1601,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71710;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4643.591,`position_y`=2623.063,`position_z`=210.0078 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4615.729,2620.247,204.5521,0,0,0,100,0),
(@PATH,2,4643.591,2623.063,210.0078,0,0,0,100,0),
(@PATH,3,4653.376,2642.757,209.5201,0,0,0,100,0),
(@PATH,4,4643.591,2623.063,210.0078,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71711;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4572.147,`position_y`=2598.857,`position_z`=197.5539 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4562.755,2625.661,198.3123,0,0,0,100,0),
(@PATH,2,4572.147,2598.857,197.5539,0,0,0,100,0),
(@PATH,3,4567.414,2551.977,197.5292,0,0,0,100,0),
(@PATH,4,4572.7192,2548.6343,195.68613,0,0,0,100,0),
(@PATH,5,4586.7192,2539.6343,198.68613,0,0,0,100,0),
(@PATH,6,4599.199,2531.054,201.4356,0,0,0,100,0),
(@PATH,7,4586.7192,2539.6343,198.68613,0,0,0,100,0),
(@PATH,8,4572.7192,2548.6343,195.68613,0,0,0,100,0),
(@PATH,9,4567.414,2551.977,197.5292,0,0,0,100,0),
(@PATH,10,4572.147,2598.857,197.5539,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71712;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4574.8994,`position_y`=2607.1254,`position_z`=198.1482 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4570.387,2610.892,197.8675,0,0,0,100,0),
(@PATH,2,4571.046,2632.996,196.4925,0,0,0,100,0),
(@PATH,3,4596.327,2671.216,191.5404,0,0,0,100,0),
(@PATH,4,4571.046,2632.996,196.4925,0,0,0,100,0),
(@PATH,5,4570.387,2610.892,197.8675,0,0,0,100,0),
(@PATH,6,4574.8994,2607.1254,198.1482,0,0,0,100,0),
(@PATH,7,4577.8994,2604.3754,197.3982,0,0,0,100,0),
(@PATH,8,4582.8994,2600.1254,196.8982,0,0,0,100,0),
(@PATH,9,4585.8994,2597.3754,197.3982,0,0,0,100,0),
(@PATH,10,4588.8994,2594.8754,199.1482,0,0,0,100,0),
(@PATH,11,4591.912,2591.859,201.9289,0,0,0,100,0),
(@PATH,12,4588.8994,2594.8754,199.1482,0,0,0,100,0),
(@PATH,13,4585.8994,2597.3754,197.3982,0,0,0,100,0),
(@PATH,14,4582.8994,2600.1254,196.8982,0,0,0,100,0),
(@PATH,15,4577.8994,2604.3754,197.3982,0,0,0,100,0),
(@PATH,16,4574.8994,2607.1254,198.1482,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71713;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4645.316,`position_y`=2546.069,`position_z`=220.3803 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4627.432,2570.993,212.9502,0,0,0,100,0),
(@PATH,2,4601.223,2573.04,214.8252,0,0,0,100,0),
(@PATH,3,4627.432,2570.993,212.9502,0,0,0,100,0),
(@PATH,4,4645.316,2546.069,220.3803,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71714;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4692.563,`position_y`=2634.855,`position_z`=210.5535 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4696.623,2608.201,210.0167,0,0,0,100,0),
(@PATH,2,4692.563,2634.855,210.5535,0,0,0,100,0),
(@PATH,3,4724.994,2625.934,211.035,0,0,0,100,0),
(@PATH,4,4738.364,2616.47,212.2359,0,0,0,100,0),
(@PATH,5,4724.994,2625.934,211.035,0,0,0,100,0),
(@PATH,6,4692.563,2634.855,210.5535,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71715;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4701.552,`position_y`=2547.523,`position_z`=231.4014 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4680.343,2554.787,226.42,0,0,0,100,0),
(@PATH,2,4658.521,2569.822,220.5987,0,0,0,100,0),
(@PATH,3,4680.343,2554.787,226.42,0,0,0,100,0),
(@PATH,4,4701.552,2547.523,231.4014,0,0,0,100,0),
(@PATH,5,4720.161,2512.047,239.4912,0,0,0,100,0),
(@PATH,6,4701.552,2547.523,231.4014,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71716;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4644.884,`position_y`=2591.018,`position_z`=211.7237 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4669.56,2589.762,210.1417,0,0,0,100,0),
(@PATH,2,4679.705,2580.529,210.0167,0,0,0,100,0),
(@PATH,3,4693.441,2575.518,210.1417,0,0,0,100,0),
(@PATH,4,4679.705,2580.529,210.0167,0,0,0,100,0),
(@PATH,5,4669.56,2589.762,210.1417,0,0,0,100,0),
(@PATH,6,4644.884,2591.018,211.7237,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71717;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4722.953,`position_y`=2444.164,`position_z`=241.6093 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4700.694,2438.369,238.8593,0,0,0,100,0),
(@PATH,2,4722.953,2444.164,241.6093,0,0,0,100,0),
(@PATH,3,4705.252,2473.897,240.0131,0,0,0,100,0),
(@PATH,4,4722.275,2475.85,240.2631,0,0,0,100,0),
(@PATH,5,4705.252,2473.897,240.0131,0,0,0,100,0),
(@PATH,6,4722.953,2444.164,241.6093,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71718;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4672.375,`position_y`=2488.454,`position_z`=240.1172 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4660.249,2464.098,240.0322,0,0,0,100,0),
(@PATH,2,4672.375,2488.454,240.1172,0,0,0,100,0),
(@PATH,3,4677.573,2516.831,239.9316,0,0,0,100,0),
(@PATH,4,4672.375,2488.454,240.1172,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71719;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4674.963,`position_y`=2399.898,`position_z`=191.7422 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4636.733,2427.21,194.5835,0,0,0,100,0),
(@PATH,2,4674.963,2399.898,191.7422,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71720;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4591.706,`position_y`=2413.99,`position_z`=193.9104 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4582.292,2440.066,195.7642,0,0,0,100,0),
(@PATH,2,4591.706,2413.99,193.9104,0,0,0,100,0),
(@PATH,3,4591.92,2373.975,190.7593,0,0,0,100,0),
(@PATH,4,4591.706,2413.99,193.9104,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71721;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4553.732,`position_y`=2496.342,`position_z`=172.3324 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4570.055,2495.549,174.081329,0,0,0,100,0),
(@PATH,2,4582.606,2495.403,169.5553,0,0,0,100,0),
(@PATH,3,4570.055,2495.549,174.081329,0,0,0,100,0),
(@PATH,4,4553.732,2496.342,172.3324,0,0,0,100,0),
(@PATH,5,4533.37,2466.238,158.4754,0,0,0,100,0),
(@PATH,6,4553.732,2496.342,172.3324,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71722;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4629.57,`position_y`=2370.969,`position_z`=190.2865 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4653.941,2354.145,183.9265,0,0,0,100,0),
(@PATH,2,4656.874,2333.608,185.9265,0,0,0,100,0),
(@PATH,3,4653.941,2354.145,183.9265,0,0,0,100,0),
(@PATH,4,4629.57,2370.969,190.2865,0,0,0,100,0),
(@PATH,5,4614.512,2397.25,193.2865,0,0,0,100,0),
(@PATH,6,4617.032,2422.815,194.7127,0,0,0,100,0),
(@PATH,7,4614.512,2397.25,193.2865,0,0,0,100,0),
(@PATH,8,4629.57,2370.969,190.2865,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71723;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4597.019,`position_y`=2310.656,`position_z`=153.1604 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4575.151,2320.547,147.5354,0,0,0,100,0),
(@PATH,2,4565.379,2347.765,145.9557,0,0,0,100,0),
(@PATH,3,4556.11,2361.77,144.0807,0,0,0,100,0),
(@PATH,4,4527.204,2360.386,142.3529,0,0,0,100,0),
(@PATH,5,4556.11,2361.77,144.0807,0,0,0,100,0),
(@PATH,6,4565.379,2347.765,145.9557,0,0,0,100,0),
(@PATH,7,4575.151,2320.547,147.5354,0,0,0,100,0),
(@PATH,8,4597.019,2310.656,153.1604,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71724;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4616.262,`position_y`=2334.016,`position_z`=176.6195 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4642.863,2325.923,172.8524,0,0,0,100,0),
(@PATH,2,4636.983,2291.834,162.9081,0,0,0,100,0),
(@PATH,3,4628.926,2289.38,160.8096,0,0,0,100,0),
(@PATH,4,4636.983,2291.834,162.9081,0,0,0,100,0),
(@PATH,5,4642.863,2325.923,172.8524,0,0,0,100,0),
(@PATH,6,4616.262,2334.016,176.6195,0,0,0,100,0),
(@PATH,7,4591.569,2351.197,176.313,0,0,0,100,0),
(@PATH,8,4616.262,2334.016,176.6195,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71725;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4663.332,`position_y`=2350.589,`position_z`=188.1765 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4657.653,2329.646,186.3524,0,0,0,100,0),
(@PATH,2,4663.332,2350.589,188.1765,0,0,0,100,0),
(@PATH,3,4678.804,2363.938,193.0415,0,0,0,100,0),
(@PATH,4,4699.673,2358.466,198.6665,0,0,0,100,0),
(@PATH,5,4678.804,2363.938,193.0415,0,0,0,100,0),
(@PATH,6,4663.332,2350.589,188.1765,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71726;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4706.639,`position_y`=2387.899,`position_z`=198.2199 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4717.08,2384.72,198.3449,0,0,0,100,0),
(@PATH,2,4745.857,2375.955,198.4512,0,0,0,100,0),
(@PATH,3,4717.08,2384.72,198.3449,0,0,0,100,0),
(@PATH,4,4706.639,2387.899,198.2199,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71727;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4574.894,`position_y`=2289.601,`position_z`=146.0959 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4551.33,2291.415,141.1749,0,0,0,100,0),
(@PATH,2,4536.958,2310.266,139.5906,0,0,0,100,0),
(@PATH,3,4525.249,2342.697,136.3529,0,0,0,100,0),
(@PATH,4,4536.958,2310.266,139.5906,0,0,0,100,0),
(@PATH,5,4551.33,2291.415,141.1749,0,0,0,100,0),
(@PATH,6,4574.894,2289.601,146.0959,0,0,0,100,0);

-- Pathing for Hound of Culuthas Entry: 20141
SET @NPC := 71728;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4549.188,`position_y`=2419.691,`position_z`=148.8044 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4515.678,2427.541,143.7992,0,0,0,100,0),
(@PATH,2,4508.379,2413.015,135.952255,0,0,0,100,0),
(@PATH,3,4496.701,2392.73,133.75,0,0,0,100,0),
(@PATH,4,4508.379,2413.015,135.952255,0,0,0,100,0),
(@PATH,5,4515.678,2427.541,143.7992,0,0,0,100,0),
(@PATH,6,4549.188,2419.691,148.8044,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67837;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4680.648,`position_y`=2933.528,`position_z`=128.5915 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4699.682,2925.731,124.7106,0,0,0,100,0),
(@PATH,2,4733.456,2919.721,124.4173,0,0,0,100,0),
(@PATH,3,4748.244,2898.929,124.5695,0,0,0,100,0),
(@PATH,4,4767.581,2892.407,127.7676,0,0,0,100,0),
(@PATH,5,4798.508,2902.931,135.7957,0,0,0,100,0),
(@PATH,6,4767.581,2892.407,127.7676,0,0,0,100,0),
(@PATH,7,4748.244,2898.929,124.5695,0,0,0,100,0),
(@PATH,8,4733.456,2919.721,124.4173,0,0,0,100,0),
(@PATH,9,4699.682,2925.731,124.7106,0,0,0,100,0),
(@PATH,10,4680.648,2933.528,128.5915,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67838;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4694.271,`position_y`=3000.521,`position_z`=131.8281 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4659.013,2990.837,139.3366,1000,0,0,100,0),
(@PATH,2,4720.058,2989.236,126.6483,4000,0,0,100,0),
(@PATH,3,4694.271,3000.521,131.8281,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67839;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4793.853,`position_y`=2559.355,`position_z`=107.7497 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4793.462,2551.932,107.38942,0,0,0,100,0),
(@PATH,2,4801.294,2542.204,103.63306,0,0,0,100,0),
(@PATH,3,4804.184,2533.202,108.15168,0,0,0,100,0),
(@PATH,4,4809.523,2531.038,110.9908,0,0,0,100,0),
(@PATH,5,4804.184,2533.202,108.15168,0,0,0,100,0),
(@PATH,6,4801.294,2542.204,103.63306,0,0,0,100,0),
(@PATH,7,4793.462,2551.932,107.38942,0,0,0,100,0),
(@PATH,8,4793.853,2559.355,107.7497,0,0,0,100,0),
(@PATH,9,4811.914,2578.137,102.8657,0,0,0,100,0),
(@PATH,10,4816.318,2599.686,95.24067,0,0,0,100,0),
(@PATH,11,4806.355,2610.437,94.20722,0,0,0,100,0),
(@PATH,12,4805.519,2632.837,97.45722,0,0,0,100,0),
(@PATH,13,4796.551,2649.526,96.84445,0,0,0,100,0),
(@PATH,14,4788.854,2664.759,101.7405,0,0,0,100,0),
(@PATH,15,4771.989,2675.860,106.12727,0,0,0,100,0),
(@PATH,16,4758.874,2684.205,100.5239,0,0,0,100,0),
(@PATH,17,4771.989,2675.860,106.12727,0,0,0,100,0),
(@PATH,18,4788.732,2665.01,101.7405,0,0,0,100,0),
(@PATH,19,4796.551,2649.526,96.84445,0,0,0,100,0),
(@PATH,20,4805.396,2633.088,97.45722,0,0,0,100,0),
(@PATH,21,4806.355,2610.437,94.20722,0,0,0,100,0),
(@PATH,22,4816.354,2599.911,95.24067,0,0,0,100,0),
(@PATH,23,4811.949,2578.362,102.8657,0,0,0,100,0),
(@PATH,24,4793.853,2559.355,107.7497,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67840;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4824.477,`position_y`=2413.032,`position_z`=117.5647 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4826.337,2423.967,113.5648,0,0,0,100,0),
(@PATH,2,4824.542,2388.935,117.0019,0,0,0,100,0),
(@PATH,3,4813.468,2410.938,119.4397,1000,0,0,100,0),
(@PATH,4,4825.049,2394.731,117.0018,0,0,0,100,0),
(@PATH,5,4826.267,2388.755,116.1268,1000,0,0,100,0),
(@PATH,6,4824.679,2414.616,116.9397,4000,0,0,100,0),
(@PATH,7,4823.229,2376.179,116.8768,0,0,0,100,0),
(@PATH,8,4824.477,2413.032,117.5647,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67841;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4805.055,`position_y`=2965.261,`position_z`=136.8346 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4830.165,2940.167,142.0846,0,0,0,100,0),
(@PATH,2,4843.901,2916.912,145.5221,0,0,0,100,0),
(@PATH,3,4869.021,2894.213,150.9389,0,0,0,100,0),
(@PATH,4,4844.042,2916.676,145.5221,0,0,0,100,0),
(@PATH,5,4830.165,2940.167,142.0846,0,0,0,100,0),
(@PATH,6,4805.055,2965.261,136.8346,0,0,0,100,0),
(@PATH,7,4776.206,2983.031,131.7047,0,0,0,100,0),
(@PATH,8,4752.369,2980.172,128.7036,0,0,0,100,0),
(@PATH,9,4734.413,2954.917,125.8786,0,0,0,100,0),
(@PATH,10,4722.08,2929.788,122.8356,0,0,0,100,0),
(@PATH,11,4714.174,2899.318,118.1997,0,0,0,100,0),
(@PATH,12,4721.984,2929.598,122.8356,0,0,0,100,0),
(@PATH,13,4734.413,2954.917,125.8786,0,0,0,100,0),
(@PATH,14,4752.307,2980.16,128.7036,0,0,0,100,0),
(@PATH,15,4776.143,2983.02,131.7047,0,0,0,100,0),
(@PATH,16,4805.055,2965.261,136.8346,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67842;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4834.341,`position_y`=2888.756,`position_z`=143.8247 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4844.857,2856.093,143.7463,0,0,0,100,0),
(@PATH,2,4834.341,2888.756,143.8247,0,0,0,100,0),
(@PATH,3,4807.149,2909.79,137.9392,0,0,0,100,0),
(@PATH,4,4803.561,2932.8,138.1892,0,0,0,100,0),
(@PATH,5,4784.36,2964.11,133.7875,0,0,0,100,0),
(@PATH,6,4803.561,2932.8,138.1892,0,0,0,100,0),
(@PATH,7,4807.149,2909.79,137.9392,0,0,0,100,0),
(@PATH,8,4834.341,2888.756,143.8247,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67843;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4861.565,`position_y`=2899.577,`position_z`=149.4497 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4831.78,2932.901,142.9392,0,0,0,100,0),
(@PATH,2,4824.348,2966.6,139.2096,0,0,0,100,0),
(@PATH,3,4833.872,2984.859,138.9322,0,0,0,100,0),
(@PATH,4,4865.883,2993.591,143.0572,0,0,0,100,0),
(@PATH,5,4833.872,2984.859,138.9322,0,0,0,100,0),
(@PATH,6,4824.348,2966.6,139.2096,0,0,0,100,0),
(@PATH,7,4831.78,2932.901,142.9392,0,0,0,100,0),
(@PATH,8,4861.565,2899.577,149.4497,24000,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67844;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4889.342,`position_y`=2820.243,`position_z`=95.60491 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4866.937,2782.555,97.07332,0,0,0,100,0),
(@PATH,2,4834.273,2749.54,91.19633,0,0,0,100,0),
(@PATH,3,4813.485,2733.715,85.98716,0,0,0,100,0),
(@PATH,4,4809.271,2699.641,88.18708,0,0,0,100,0),
(@PATH,5,4810.158,2667.983,98.81208,0,0,0,100,0),
(@PATH,6,4809.271,2699.641,88.18708,0,0,0,100,0),
(@PATH,7,4813.485,2733.715,85.98716,0,0,0,100,0),
(@PATH,8,4834.273,2749.54,91.19633,0,0,0,100,0),
(@PATH,9,4866.937,2782.555,97.07332,0,0,0,100,0),
(@PATH,10,4889.342,2820.243,95.60491,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67847;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4671.166,`position_y`=2833.747,`position_z`=119.9709 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4701.324,2825.501,112.6165,0,0,0,100,0),
(@PATH,2,4733.146,2840.096,112.46,0,0,0,100,0),
(@PATH,3,4733.27,2865.343,117.21,0,0,0,100,0),
(@PATH,4,4717.506,2898.328,118.4497,0,0,0,100,0),
(@PATH,5,4733.584,2912.84,123.2923,0,0,0,100,0),
(@PATH,6,4766.141,2890.556,127.3195,0,0,0,100,0),
(@PATH,7,4733.584,2912.84,123.2923,0,0,0,100,0),
(@PATH,8,4717.506,2898.328,118.4497,0,0,0,100,0),
(@PATH,9,4733.27,2865.343,117.21,0,0,0,100,0),
(@PATH,10,4733.184,2840.137,112.46,0,0,0,100,0),
(@PATH,11,4701.324,2825.501,112.6165,0,0,0,100,0),
(@PATH,12,4671.166,2833.747,119.9709,0,0,0,100,0),
(@PATH,13,4657.984,2865.764,115.7247,0,0,0,100,0),
(@PATH,14,4678.522,2878.853,116.3573,0,0,0,100,0),
(@PATH,15,4657.984,2865.764,115.7247,0,0,0,100,0),
(@PATH,16,4671.166,2833.747,119.9709,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67848;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4735.839,`position_y`=3006.335,`position_z`=126.3608 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4766.877,3012.027,129.7613,0,0,0,100,0),
(@PATH,2,4735.839,3006.335,126.3608,0,0,0,100,0),
(@PATH,3,4699.474,2992.311,130.3387,0,0,0,100,0),
(@PATH,4,4667.536,2968.931,136.8387,0,0,0,100,0),
(@PATH,5,4655.592,2935.294,137.8124,0,0,0,100,0),
(@PATH,6,4667.536,2968.931,136.8387,0,0,0,100,0),
(@PATH,7,4699.474,2992.311,130.3387,0,0,0,100,0),
(@PATH,8,4735.839,3006.335,126.3608,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 69997;
SET @PATH := @NPC;
UPDATE `creature` SET `id`=18886,`curhealth`=1,`spawndist`=0,`MovementType`=2,`position_x`=4836.941,`position_y`=2327.35,`position_z`=106.2828 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4855.318,2346.112,96.91952,4000,0,0,100,0),
(@PATH,2,4822.361,2352.147,109.4193,0,0,0,100,0),
(@PATH,3,4822.504,2344.83,108.5443,11000,0,0,100,0),
(@PATH,4,4828.094,2345.115,106.7943,0,0,0,100,0),
(@PATH,5,4836.068,2345.272,102.9197,0,0,0,100,0),
(@PATH,6,4844.936,2340.653,98.41952,0,0,0,100,0),
(@PATH,7,4852.699,2346.962,99.54452,0,0,0,100,0),
(@PATH,8,4846.147,2345.409,102.0445,1000,0,0,100,0),
(@PATH,9,4823.075,2346.144,108.0443,0,0,0,100,0),
(@PATH,10,4838.939,2344.494,101.9195,0,0,0,100,0),
(@PATH,11,4836.941,2327.35,106.2828,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67845;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4807.688,`position_y`=2724.204,`position_z`=84.94135 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4777.618,2730.457,81.22252,0,0,0,100,0),
(@PATH,2,4764.885,2742.8694,81.61359,0,0,0,100,0),
(@PATH,3,4756.885,2750.1194,85.11359,0,0,0,100,0),
(@PATH,4,4748.135,2758.1194,88.11359,0,0,0,100,0),
(@PATH,5,4746.541,2759.596,88.90433,0,0,0,100,0),
(@PATH,6,4739.336,2798.704,98.97594,0,0,0,100,0),
(@PATH,7,4746.541,2759.596,88.90433,0,0,0,100,0),
(@PATH,8,4748.135,2758.1194,88.11359,0,0,0,100,0),
(@PATH,9,4756.885,2750.1194,85.11359,0,0,0,100,0),
(@PATH,10,4764.885,2742.8694,81.61359,0,0,0,100,0),
(@PATH,11,4777.618,2730.457,81.22252,0,0,0,100,0),
(@PATH,12,4807.688,2724.204,84.94135,0,0,0,100,0),
(@PATH,13,4833.35,2746.087,91.07133,0,0,0,100,0),
(@PATH,14,4854.537,2763.94,96.69633,0,0,0,100,0),
(@PATH,15,4867.339,2749.076,90.63702,0,0,0,100,0),
(@PATH,16,4891.293,2750.6,84.13702,0,0,0,100,0),
(@PATH,17,4867.339,2749.076,90.63702,0,0,0,100,0),
(@PATH,18,4854.537,2763.94,96.69633,0,0,0,100,0),
(@PATH,19,4833.35,2746.087,91.07133,0,0,0,100,0),
(@PATH,20,4807.688,2724.204,84.94135,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67846;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4705.967,`position_y`=2725.816,`position_z`=112.5994 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4726.067,2715.057,100.2244,0,0,0,100,0),
(@PATH,2,4730.1675,2707.9592,96.68663,0,0,0,100,0),
(@PATH,3,4733.9175,2700.2092,102.68663,0,0,0,100,0),
(@PATH,4,4737.268,2693.862,108.1489,0,0,0,100,0),
(@PATH,5,4733.9175,2700.2092,102.68663,0,0,0,100,0),
(@PATH,6,4730.1675,2707.9592,96.68663,0,0,0,100,0),
(@PATH,7,4726.067,2715.057,100.2244,0,0,0,100,0),
(@PATH,8,4705.967,2725.816,112.5994,0,0,0,100,0),
(@PATH,9,4708.094,2745.621,111.2062,0,0,0,100,0),
(@PATH,10,4693.125,2751.136,115.1726,0,0,0,100,0),
(@PATH,11,4671.101,2754.369,125.6726,0,0,0,100,0),
(@PATH,12,4666.887,2768.541,130.7094,0,0,0,100,0),
(@PATH,13,4686.194,2770.743,124.8344,0,0,0,100,0),
(@PATH,14,4700.069,2777.035,116.6096,0,0,0,100,0),
(@PATH,15,4692.681,2791.015,114.4594,0,0,0,100,0),
(@PATH,16,4700.069,2777.035,116.6096,0,0,0,100,0),
(@PATH,17,4686.194,2770.743,124.8344,0,0,0,100,0),
(@PATH,18,4666.887,2768.541,130.7094,0,0,0,100,0),
(@PATH,19,4671.101,2754.369,125.6726,0,0,0,100,0),
(@PATH,20,4693.125,2751.136,115.1726,0,0,0,100,0),
(@PATH,21,4708.094,2745.621,111.2062,0,0,0,100,0),
(@PATH,22,4705.967,2725.816,112.5994,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 67849;
SET @PATH := @NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=4894.055,`position_y`=2678.779,`position_z`=79.14181 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4898.583984,2685.638184,81.916397,0,0,0,100,0),
(@PATH,2,4898.583984,2685.638184,81.916397,0,0,0,100,0),
(@PATH,3,4903.135254,2692.378174,80.039780,0,0,0,100,0),
(@PATH,4,4906.950684,2697.958252,75.823601,0,0,0,100,0),
(@PATH,5,4910.214,2703.051,76.77097,0,0,0,100,0),
(@PATH,6,4906.950684,2697.958252,75.823601,0,0,0,100,0),
(@PATH,7,4903.135254,2692.378174,80.039780,0,0,0,100,0),
(@PATH,8,4898.583984,2685.638184,81.916397,0,0,0,100,0),
(@PATH,9,4898.583984,2685.638184,81.916397,0,0,0,100,0),
(@PATH,10,4894.055,2678.779,79.14181,0,0,0,100,0),
(@PATH,11,4890.638672,2668.343994,84.098625,0,0,0,100,0),
(@PATH,12,4880.379883,2649.595215,85.190849,0,0,0,100,0),
(@PATH,13,4877.725098,2643.881348,83.099609,0,0,0,100,0),
(@PATH,14,4875.45,2639.722,85.40894,0,0,0,100,0),
(@PATH,15,4872.527,2620.948,87.5256,0,0,0,100,0),
(@PATH,16,4854.194,2601.887,92.93586,0,0,0,100,0),
(@PATH,17,4847.225,2560.535,88.06782,1000,0,0,100,0),
(@PATH,18,4854.194,2601.887,92.93586,0,0,0,100,0),
(@PATH,19,4872.527,2620.948,87.5256,0,0,0,100,0),
(@PATH,20,4875.45,2639.722,85.40894,0,0,0,100,0),
(@PATH,21,4877.725098,2643.881348,83.099609,0,0,0,100,0),
(@PATH,22,4880.379883,2649.595215,85.190849,0,0,0,100,0),
(@PATH,23,4890.638672,2668.343994,84.098625,0,0,0,100,0),
(@PATH,24,4894.055,2678.779,79.14181,0,0,0,100,0);

-- Pathing for Farahlon Breaker Entry: 18886
SET @NPC := 69977;
SET @PATH := @NPC;
UPDATE `creature` SET `id`=18886,`curhealth`=1,`spawndist`=0,`MovementType`=2,`position_x`=4819.647,`position_y`=2537.184,`position_z`=110.34905 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4824.148,2532.490,109.05141,0,0,0,100,0),
(@PATH,2,4816.462,2531.366,111.35047,0,0,0,100,0),
(@PATH,3,4812.264,2535.927,110.47469,3000,0,0,100,0),
(@PATH,4,4808.402,2540.578,104.31991,0,0,0,100,0),
(@PATH,5,4803.943,2544.884,102.38943,1000,0,0,100,0),
(@PATH,6,4794.366,2551.873,107.13906,0,0,0,100,0),
(@PATH,7,4797.480,2543.475,105.70802,0,0,0,100,0),
(@PATH,8,4796.184,2536.756,108.24725,5000,0,0,100,0),
(@PATH,9,4803.583,2530.559,109.12021,0,0,0,100,0),
(@PATH,10,4811.625,2532.295,111.37372,0,0,0,100,0),
(@PATH,11,4816.192,2535.158,110.93280,2000,0,0,100,0),
(@PATH,12,4823.782,2532.975,109.24986,0,0,0,100,0),
(@PATH,13,4823.609,2538.890,108.99189,1000,0,0,100,0),
(@PATH,14,4815.678,2538.618,109.75655,0,0,0,100,0),
(@PATH,15,4813.142,2545.137,104.41969,0,0,0,100,0),
(@PATH,16,4803.757,2544.752,102.43920,4000,0,0,100,0),
(@PATH,17,4792.094,2543.446,109.15849,0,0,0,100,0),
(@PATH,18,4791.390,2551.806,108.40910,0,0,0,100,0),
(@PATH,19,4803.108,2543.305,102.70206,2000,0,0,100,0),
(@PATH,20,4811.917,2533.514,111.25555,0,0,0,100,0),
(@PATH,21,4819.647,2537.184,110.34905,0,0,0,100,0);

DELETE FROM `npc_vendor` WHERE `item` = 22911;
INSERT INTO `npc_vendor` VALUES (19042, 22911, 1, 3600, 0);
INSERT INTO `npc_vendor` VALUES (19837, 22911, 1, 3600, 0);

UPDATE `creature` SET `spawntimesecs` = 120 WHERE `id` IN (19723,19724);

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` IN (19723,19724);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (19723,19724);
INSERT INTO `creature_ai_scripts` VALUES
('1972301','19723','8','0','100','0','34526','-1','0','0','104','181915','140','0','37','0','0','0','0','0','0','0','Invis BE Ballista - Summon Fire Go and Die on Burn Blood Elf Equipment Spellhit'),
('1972401','19724','8','0','100','0','34526','-1','0','0','104','181915','140','0','37','0','0','0','0','0','0','0','Invis BE Tent - Summon Fire Go and Die on Burn Blood Elf Equipment Spellhit');

DELETE FROM `creature` WHERE `guid` IN (44003, 44064, 44091, 44180, 44457, 44468, 44592, 44677, 44923, 45018, 45068, 45075, 45111, 45321, 45329, 45397, 45399, 45423, 45460, 45532, 45600, 45604, 45611, 45615, 45624, 45632, 45637, 45641, 45685, 
45741, 45831, 45903, 45932, 45933, 45986, 50369, 269932, 274958);
INSERT INTO `creature` VALUES (44003, 11736, 1, 1, 15384, 0, -6948.86, 1787.18, 0.049702, 0.034166, 300, 10, 0, 3644, 0, 0, 1);
INSERT INTO `creature` VALUES (44064, 1553, 0, 1, 4734, 0, 2153.34, 13.387, 41.753, 1.74531, 300, 5, 0, 120, 0, 0, 1);
INSERT INTO `creature` VALUES (44091, 11736, 1, 1, 15384, 0, -7413.93, 1180.05, 3.10124, 5.1804, 300, 25, 0, 3644, 0, 0, 1);
INSERT INTO `creature` VALUES (44180, 24366, 0, 1, 0, 0, -11340.5, -219.14, 75.2143, 2.04203, 300, 0, 0, 3200, 0, 0, 0);
INSERT INTO `creature` VALUES (50369, 5247, 1, 1, 2592, 0, -5357.15, 324.802, 32.4303, 1.59656, 300, 3, 0, 2310, 0, 0, 1);
INSERT INTO `creature` VALUES (44468, 25588, 580, 1, 0, 0, 1684.7, 614.42, 28.058, 0.698392, 7200, 0, 0, 190000, 0, 0, 0);
INSERT INTO `creature` VALUES (44592, 1674, 0, 1, 10852, 0, 2511.96, 389.683, 34.1707, 1.37608, 300, 5, 0, 120, 0, 0, 1);
INSERT INTO `creature` VALUES (44677, 1941, 0, 1, 10853, 0, 2616.3, 513.188, 19.5454, 1.81797, 300, 10, 0, 120, 0, 0, 1);
INSERT INTO `creature` VALUES (44923, 1535, 0, 1, 2471, 0, 2430.09, 1577.92, 37.2447, 3.80482, 300, 0, 0, 120, 0, 0, 0);
INSERT INTO `creature` VALUES (45018, 1523, 0, 1, 535, 0, 2784.93, 791.135, 114.629, 3.75304, 300, 5, 0, 148, 165, 0, 1);
INSERT INTO `creature` VALUES (45068, 1548, 0, 1, 9020, 0, 2042.62, 455.149, 45.4707, 0.271616, 300, 5, 0, 138, 0, 0, 1);
INSERT INTO `creature` VALUES (45111, 1553, 0, 1, 4734, 0, 2204.33, 453.73, 60.6053, 1.98456, 300, 5, 0, 120, 0, 0, 1);
INSERT INTO `creature` VALUES (45321, 4475, 0, 1, 10970, 0, 1899.09, -1539.69, 59.7576, 5.89595, 315, 10, 0, 3082, 0, 0, 1);
INSERT INTO `creature` VALUES (45329, 1796, 0, 1, 10487, 0, 1449.13, -1846.6, 58.6686, 2.11309, 315, 10, 0, 3529, 0, 0, 1);
INSERT INTO `creature` VALUES (45397, 2110, 0, 1, 1141, 0, 1370.75, -1549.55, 57.7947, 3.60198, 315, 10, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (45399, 2110, 0, 1, 1141, 0, 1770.39, -1204.02, 59.5956, 5.43287, 315, 10, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (45423, 11217, 0, 1, 10896, 0, 1253.96, -2604.14, 91.5909, 3.1765, 315, 0, 0, 5500, 0, 0, 0);
INSERT INTO `creature` VALUES (45460, 1789, 0, 1, 9790, 0, 1238.74, -1593.33, 68.9581, 3.65619, 315, 5, 0, 2823, 2117, 0, 1);
INSERT INTO `creature` VALUES (45532, 2914, 0, 1, 2957, 0, -10805.2, 837.114, 32.9496, 2.33747, 300, 10, 0, 8, 0, 0, 1);
INSERT INTO `creature` VALUES (45600, 11738, 1, 1, 8014, 0, -6662.02, 653.445, 5.83046, 3.28653, 300, 25, 0, 3529, 0, 0, 1);
INSERT INTO `creature` VALUES (45604, 11738, 1, 1, 8014, 0, -6948.48, 983.046, 9.39294, 6.2105, 300, 25, 0, 3529, 0, 0, 1);
INSERT INTO `creature` VALUES (45611, 11739, 1, 1, 711, 0, -7689.71, 1411.01, 2.75041, 4.69428, 300, 25, 0, 3758, 0, 0, 1);
INSERT INTO `creature` VALUES (45615, 11739, 1, 1, 711, 0, -7747.9, 1516.7, -0.080106, 0.772662, 300, 25, 0, 3758, 0, 0, 1);
INSERT INTO `creature` VALUES (45624, 11739, 1, 1, 711, 0, -7706.67, 1589.48, 2.83999, 4.05102, 300, 25, 0, 3758, 0, 0, 1);
INSERT INTO `creature` VALUES (45632, 11739, 1, 1, 711, 0, -7917.91, 1564.34, -1.78348, 1.8314, 300, 25, 0, 3758, 0, 0, 1);
INSERT INTO `creature` VALUES (45637, 11739, 1, 1, 711, 0, -7669.72, 1260.77, 0.598203, 3.62534, 300, 25, 0, 3758, 0, 0, 1);
INSERT INTO `creature` VALUES (45641, 11739, 1, 1, 711, 0, -7880.63, 1014.48, 6.2752, 4.10759, 300, 25, 0, 3758, 0, 0, 1);
INSERT INTO `creature` VALUES (45685, 11739, 1, 1, 711, 0, -7816.13, 1119.34, 0.457605, 1.49845, 300, 25, 0, 3758, 0, 0, 1);
INSERT INTO `creature` VALUES (45741, 9716, 229, 1, 0, 0, -168.48, -418.68, 76.33, 1.66, 10800, 0, 0, 8352, 0, 0, 0);
INSERT INTO `creature` VALUES (45831, 10680, 229, 1, 0, 0, 165.25, -254.12, 111.1, 3.2, 10800, 0, 0, 7300, 2369, 0, 0);
INSERT INTO `creature` VALUES (45903, 8891, 230, 1, 8750, 0, 655.143, -233.742, -83.5416, 2.05949, 7200, 0, 0, 6645, 0, 0, 0);
INSERT INTO `creature` VALUES (45932, 8906, 230, 1, 8177, 0, 851.842, 13.2664, -53.6419, 2.28638, 7200, 0, 0, 7800, 3200, 0, 0);
INSERT INTO `creature` VALUES (45933, 8907, 230, 1, 8178, 0, 856.701, 17.871, -53.6308, 2.53073, 7200, 0, 0, 7599, 0, 0, 0);
INSERT INTO `creature` VALUES (45986, 11740, 1, 1, 15386, 0, -6467.49, 384.979, 2.0952, 3.22571, 300, 25, 0, 3137, 0, 0, 1);

-- (Re) Activate General Epic Gems in Heroics
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 33 WHERE `entry` IN (18436,18433,18621,18601,18607,20923,20568,20596,20597,19893,19895,19894,20169,20168,20183,20184,20629,20630,20633,20267,20268,20266,22930,20318,20306,20690,23035,20706,20636,20637,20653,20657,20535,20521,20531,20738,20745,20737,21626,21590,21624,21599,21533,21536,21537,21551,21558,21581,21559,21582) AND `mincountOrRef` IN (-43002,-50000,-50001,-50002,-50005,-50006,-50007,-50008,-50012,-50013,-50018,-50021,-50024,-50025,-50033); -- 33
UPDATE `gameobject_loot_template` SET `ChanceOrQuestCHance` = 33 WHERE `entry` = 21764 AND `mincountOrRef` = -50002; -- 33

-- Gorefiend's Truncheon 
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -80 WHERE `entry` = 21784 AND `item` = 30800;

-- Grand Commander Ruusk 20563- npc_grand_commander_ruusk
UPDATE `creature_template` SET `faction_A` = 1701, `faction_H` = 1701 WHERE `entry` = 20563; -- 35

-- Eclipsion Bloodwarder 19806
UPDATE `creature_template` SET `faction_A` = 1793, `faction_H` = 1793, `minmana` = 2991, `maxmana` = 2991 WHERE `entry` = 19806; -- 1701 Mounted, can detect.
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19806;
INSERT INTO `creature_ai_scripts` VALUES (1980601, 19806, 2, 0, 100, 1, 35, 0, 5000, 15000, 11, 37838, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Bloodwarder - Cast Blood Leech at 35% HP');
INSERT INTO `creature_ai_scripts` VALUES (1980602, 19806, 6, 0, 100, 0, 0, 0, 0, 0, 11, 38311, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Bloodwarder - Summon Eclipsion Hawkstrider on Death');
INSERT INTO `creature_ai_scripts` VALUES (1980603, 19806, 13, 0, 100, 1, 8000, 12000, 0, 0, 11, 38313, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Bloodwarder - Cast Pummel on Player Spellcasting');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19796;
INSERT INTO `creature_ai_scripts` VALUES (1979601, 19796, 9, 0, 100, 1, 0, 5, 12000, 17000, 11, 37986, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Archmage - Cast Ancient Fire');
INSERT INTO `creature_ai_scripts` VALUES (1979602, 19796, 9, 0, 100, 1, 0, 30, 3800, 5200, 11, 13878, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Archmage - Cast Scorch');
INSERT INTO `creature_ai_scripts` VALUES (1979603, 19796, 0, 0, 100, 1, 9000, 15000, 16000, 24000, 11, 11829, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eclipsion Archmage - Cast Flamestrike');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -37986;
INSERT INTO `spell_linked_spell` VALUES (-37986, 37988, 0, 'Ancient Fire Damage Component');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20502;
INSERT INTO `creature_ai_scripts` VALUES ('2050201','20502','9','0','100','1','0','5','11000','16000','11','37985','1','0','0','0','0','0','0','0','0','0','Eclipsion Dragonhawk - Cast Fire Breath');

DELETE FROM `creature` WHERE `id` IN (19806,19796,20502);
DELETE FROM `creature` WHERE `guid` IN (70813,70818,70819);
INSERT INTO `creature` VALUES (70923, 19806, 530, 1, 0, 0, -4137.81, 1518.9, 103.254, 2.19925, 300, 0, 0, 6986, 0, 0, 2);
INSERT INTO `creature` VALUES (70924, 19806, 530, 1, 0, 0, -4311.7, 1584.43, 142.611, 2.2141, 300, 0, 0, 6986, 0, 0, 2);
INSERT INTO `creature` VALUES (70925, 19806, 530, 1, 0, 0, -4382.89, 1686.13, 157.85, 2.72837, 300, 0, 0, 6986, 0, 0, 2);
INSERT INTO `creature` VALUES (70926, 19806, 530, 1, 0, 0, -4443.15, 1583.94, 163.903, 2.60201, 300, 0, 0, 6986, 0, 0, 2);
INSERT INTO `creature` VALUES (70927, 19806, 530, 1, 0, 0, -4555.15, 1638.48, 174.33, 4.23101, 300, 0, 0, 6986, 0, 0, 2);
INSERT INTO `creature` VALUES (70928, 19806, 530, 1, 0, 0, -4416.45, 1791.87, 156.612, 1.35636, 300, 5, 0, 6986, 0, 0, 1); -- probably missing path

INSERT INTO `creature` VALUES (72566, 20502, 530, 1, 0, 0, -4161.39, 1379.87, 119.887, 3.97536, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72567, 20502, 530, 1, 0, 0, -4154.48, 1486.17, 111.583, 1.97586, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72568, 20502, 530, 1, 0, 0, -4187.53, 1414.62, 126.909, 2.26015, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72569, 20502, 530, 1, 0, 0, -4209.3, 1446.01, 131.766, 2.7362, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72570, 20502, 530, 1, 0, 0, -4148.6, 1445.65, 108.858, 5.76715, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72571, 20502, 530, 1, 0, 0, -4238.27, 1474.27, 131.036, 6.06073, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72572, 20502, 530, 1, 0, 0, -4219.04, 1487.25, 123.647, 0.330297, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72573, 20502, 530, 1, 0, 0, -4159.44, 1551.63, 106.227, 5.32552, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72574, 20502, 530, 1, 0, 0, -4291.56, 1524.98, 143.316, 0.961208, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72575, 20502, 530, 1, 0, 0, -4212.76, 1587.6, 114.78, 4.45556, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72576, 20502, 530, 1, 0, 0, -4254.82, 1572.58, 128.343, 0.860721, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72577, 20502, 530, 1, 0, 0, -4308.85, 1722.53, 139.577, 0.302449, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72578, 20502, 530, 1, 0, 0, -4278.48, 1604.91, 132.241, 0.167716, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72579, 20502, 530, 1, 0, 0, -4283.73, 1634.77, 125.962, 3.60027, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72580, 20502, 530, 1, 0, 0, -4347.24, 1665.91, 159.632, 4.37613, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72581, 20502, 530, 1, 0, 0, -4303.43, 1672.19, 128.043, 5.78984, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72582, 20502, 530, 1, 0, 0, -4314.96, 1643.81, 138.826, 0.595045, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72583, 20502, 530, 1, 0, 0, -4349.77, 1576.37, 158.376, 3.92354, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72584, 20502, 530, 1, 0, 0, -4358.74, 1547.07, 161.232, 2.48027, 300, 10, 0, 6384, 0, 0, 1); 
INSERT INTO `creature` VALUES (72585, 20502, 530, 1, 0, 0, -4424.16, 1570.85, 164.735, 4.603, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72586, 20502, 530, 1, 0, 0, -4424.06, 1611.96, 164.194, 2.45647, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72587, 20502, 530, 1, 0, 0, -4434.23, 1684.58, 161.129, 4.63809, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72588, 20502, 530, 1, 0, 0, -4515.05, 1569.1, 219.549, 3.9321, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72589, 20502, 530, 1, 0, 0, -4554.88, 1571.77, 216.679, 1.59934, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72590, 20502, 530, 1, 0, 0, -4519.27, 1638.77, 173.791, 2.50239, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72591, 20502, 530, 1, 0, 0, -4637.16, 1660.55, 190.076, 1.55932, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72592, 20502, 530, 1, 0, 0, -4494.61, 1843.63, 178.341, 1.01688, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72593, 20502, 530, 1, 0, 0, -4517.54, 1798.33, 174.528, 3.86395, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72594, 20502, 530, 1, 0, 0, -4606.24, 1770.71, 167.931, 1.90088, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72595, 20502, 530, 1, 0, 0, -4551.52, 1774.52, 179.629, 0.834426, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72596, 20502, 530, 1, 0, 0, -4402.43, 1737.2, 158.074, 5.65413, 300, 5, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72597, 20502, 530, 1, 0, 0, -4421.96, 1813.77, 158.5, 3.40574, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72598, 20502, 530, 1, 0, 0, -4365.26, 1842.05, 148.297, 1.7473, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72599, 20502, 530, 1, 0, 0, -4322.73, 1753.68, 148.833, 1.85374, 300, 10, 0, 6384, 0, 0, 1);
INSERT INTO `creature` VALUES (72600, 20502, 530, 1, 0, 0, -4358.42, 1783.01, 147.744, 4.43328, 300, 10, 0, 6384, 0, 0, 1);

INSERT INTO `creature` VALUES (70850, 19796, 530, 1, 0, 0, -4092.91, 1493.31, 96.5598, 3.26377, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70851, 19796, 530, 1, 0, 0, -4234.69, 1496.32, 127.328, 2.14675, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70852, 19796, 530, 1, 0, 0, -4162.61, 1544.51, 108.878, 4.01426, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70853, 19796, 530, 1, 0, 0, -4288.84, 1598.95, 136.992, 3.90954, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70854, 19796, 530, 1, 0, 0, -4394.37, 1695.86, 157.779, 0.523606, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70855, 19796, 530, 1, 0, 0, -4381.37, 1643.24, 159.277, 6.10865, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70856, 19796, 530, 1, 0, 0, -4418.83, 1566.92, 164.814, 1.41372, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70857, 19796, 530, 1, 0, 0, -4447.8, 1665.69, 163.551, 3.03687, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70858, 19796, 530, 1, 0, 0, -4485.73, 1647.33, 165.472, 0.314159, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70859, 19796, 530, 1, 0, 0, -4455.88, 1628.55, 163.035, 3.12414, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70860, 19796, 530, 1, 0, 0, -4538.56, 1633.76, 174.954, 2.81591, 300, 5, 0, 5233, 2991, 0, 1);
INSERT INTO `creature` VALUES (70861, 19796, 530, 1, 0, 0, -4498.56, 1742.42, 159.721, 3.23835, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70862, 19796, 530, 1, 0, 0, -4485.7, 1692.84, 164.861, 0.174533, 300, 0, 0, 5233, 2991, 0, 2);
INSERT INTO `creature` VALUES (70863, 19796, 530, 1, 0, 0, -4488.76, 1728.99, 161.141, 0.523599, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70864, 19796, 530, 1, 0, 0, -4489.87, 1714.28, 161.148, 0.296706, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70865, 19796, 530, 1, 0, 0, -4524.77, 1708.84, 175.073, 3.24631, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70866, 19796, 530, 1, 0, 0, -4574.51, 1654.76, 174.894, 6.045, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70867, 19796, 530, 1, 0, 0, -4539.33, 1729.32, 174.81, 4.59022, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70868, 19796, 530, 1, 0, 0, -4574.43, 1692.16, 175.296, 6.12611, 300, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (70869, 19796, 530, 1, 0, 0, -4355.15, 1724.12, 157.56, 3.50811, 300, 0, 0, 5233, 2991, 0, 0);

INSERT INTO `creature` VALUES (70813, 19792, 530, 1, 0, 1, -4172.62, 1491.76, 115.012, 3.06137, 300, 0, 0, 5325, 2991, 0, 2);
INSERT INTO `creature` VALUES (70818, 19792, 530, 1, 0, 1, -4234.92, 1547.49, 126.534, 2.52623, 300, 0, 0, 5325, 2991, 0, 2);
INSERT INTO `creature` VALUES (70819, 19792, 530, 1, 0, 1, -4215.1, 1564.35, 118.479, 5.91321, 300, 0, 0, 5325, 2991, 0, 2);

SET @GUID := 70923;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70923, 1, -4144.03, 1516.01, 104.13, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 2, -4168.75, 1522.81, 110.265, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 3, -4174.44, 1522.28, 111.557, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 4, -4181.34, 1517.79, 113.086, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 5, -4195.61, 1516.24, 116.29, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 6, -4207.42, 1518.59, 118.997, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 7, -4224.71, 1524.65, 122.91, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 8, -4234.86, 1526.13, 125.585, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 9, -4253.02, 1522.34, 129.609, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 10, -4261.56, 1521.92, 131.608, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 11, -4265.57, 1523.97, 132.558, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 12, -4254.05, 1521.91, 129.781, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 13, -4237.44, 1524.61, 126.194, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 14, -4229.78, 1525.15, 124.065, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 15, -4219.36, 1522.89, 121.703, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 16, -4204.41, 1517.54, 118.322, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 17, -4190.44, 1515.25, 115, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 18, -4183.74, 1516.31, 113.599, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 19, -4172.74, 1521.46, 111.102, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 20, -4165.77, 1522.23, 109.544, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 21, -4139.21, 1514.18, 102.831, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 22, -4133.8, 1513.59, 101.652, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 23, -4113.55, 1517.62, 98.1321, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 24, -4121.4, 1515.92, 99.3408, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 25, -4130.05, 1514.34, 100.942, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 26, -4137.85, 1515.48, 102.65, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70923, 27, -4139.25, 1519.45, 103.506, 6000, 0, 0, 0, 0); -- 2201801

SET @GUID := 70924;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70924, 1, -4324.03, 1600.51, 146.298, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 2, -4337.41, 1614.33, 150.214, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 3, -4336.32, 1622.15, 151.53, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70924, 4, -4340.98, 1616, 150.98, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 5, -4325.63, 1601.34, 146.561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 6, -4309.38, 1581.74, 141.93, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 7, -4300.53, 1570.15, 139.926, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 8, -4291.35, 1556.55, 138.285, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 9, -4286.25, 1550.18, 137.281, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 10, -4287.76, 1541.51, 137.022, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70924, 11, -4286.43, 1548.91, 137.17, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70924, 12, -4304.09, 1575.78, 140.759, 0, 0, 0, 0, 0);

SET @GUID := 70925;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70925, 1, -4372.55, 1683.09, 157.025, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 2, -4366.69, 1671.29, 157.44, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 3, -4367, 1649.91, 156.692, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 4, -4367.2, 1639.65, 156.228, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 5, -4366.11, 1665.18, 157.379, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 6, -4367.23, 1673.29, 157.385, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 7, -4370.52, 1681.48, 157.084, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 8, -4385.14, 1702.94, 156.566, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 9, -4394.85, 1711.57, 156.651, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 10, -4399.57, 1714.28, 156.73, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 11, -4409.25, 1716.47, 156.881, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 12, -4419.85, 1719.44, 156.646, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 13, -4425.06, 1708.94, 158.197, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70925, 14, -4432, 1717.95, 156.919, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 15, -4440.07, 1717.75, 157.25, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 16, -4464.77, 1713.9, 159.434, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 17, -4432.1, 1719.04, 156.907, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 18, -4416.2, 1717.96, 156.672, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 19, -4399.96, 1713.63, 156.768, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 20, -4390.19, 1707.64, 156.447, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 21, -4382.59, 1697.12, 156.8, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70925, 22, -4384.58, 1690.3, 157.509, 6000, 0, 0, 0, 0); -- 2201801

SET @GUID := 70926;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70926, 1, -4451.96, 1590.28, 163.602, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 2, -4457.07, 1598.35, 163.219, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 3, -4459.01, 1607.41, 163.099, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 4, -4460.46, 1612.1, 163.135, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 5, -4469.87, 1626.93, 163.221, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 6, -4479.2, 1629.14, 164.972, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70926, 7, -4471.79, 1632.22, 163.176, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 8, -4473.61, 1657.56, 162.967, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 9, -4470.16, 1629.06, 163.218, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 10, -4459.56, 1608.58, 163.113, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 11, -4457.94, 1604.06, 163.154, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 12, -4452.69, 1600.74, 163.691, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70926, 13, -4455.44, 1594.2, 163.468, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 14, -4449.52, 1586.77, 163.769, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 15, -4436.75, 1580.4, 163.88, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 16, -4411.86, 1580.59, 163.674, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 17, -4403.58, 1582.91, 163.576, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 18, -4396.31, 1587.7, 163.617, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 19, -4391.02, 1593.5, 163.101, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 20, -4392.31, 1600.97, 163.198, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70926, 21, -4387, 1602.28, 162.184, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 22, -4383.6, 1608, 161.379, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 23, -4380.16, 1621.23, 159.307, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 24, -4376.61, 1627.86, 157.965, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 25, -4380.52, 1616.6, 160.09, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 26, -4377.64, 1612.64, 161.076, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70926, 27, -4384.84, 1605.69, 161.714, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 28, -4390.99, 1594.24, 163.044, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 29, -4399.82, 1585.74, 163.666, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 30, -4410.02, 1580.67, 163.732, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 31, -4428.3, 1579.59, 163.658, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70926, 32, -4431.9, 1573.93, 164.781, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70926, 33, -4443.13, 1584.03, 163.839, 0, 0, 0, 0, 0);

SET @GUID := 70927;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70927, 1, -4561.29, 1622.66, 174.52, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 2, -4556.69, 1612.49, 175.33, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70927, 3, -4561.48, 1622.28, 174.532, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 4, -4552.43, 1641.26, 174.227, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 5, -4547.81, 1671.86, 174.681, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 6, -4549.14, 1679.34, 174.778, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 7, -4559.94, 1696.43, 174.438, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 8, -4550.01, 1706.51, 174.655, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 9, -4543.46, 1710.85, 174.534, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 10, -4538.14, 1716.93, 174.342, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 11, -4543.14, 1711.25, 174.521, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 12, -4550.39, 1706.83, 174.629, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 13, -4559.8, 1699.55, 174.513, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 14, -4567.53, 1704.06, 174.243, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 15, -4583.33, 1724.12, 174.348, 6000, 0, 0, 0, 0); -- 2201801
INSERT INTO `waypoint_data` VALUES (70927, 16, -4550.86, 1682.13, 174.752, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 17, -4548.21, 1673.59, 174.731, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 18, -4551.93, 1658.56, 174.314, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70927, 19, -4554.31, 1637.39, 174.319, 0, 0, 0, 0, 0);

-- INSERT INTO `dbscripts_on_creature_movement` VALUES (2201801, 0, 31, 19792, 30, 0, 0, 0, -5000, 0, 0, 0, 0, 0, 0, 0, '');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (2201801, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (2201801, 4, 1, 66, 0, 19792, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'force 19792 to: emote');

SET @GUID := 70813;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70813, 1, -4172.62, 1491.76, 115.012, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70813, 2, -4137.53, 1488.11, 107.358, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70813, 3, -4101.36, 1478.42, 98.5473, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70813, 4, -4137.53, 1488.11, 107.358, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70813, 5, -4172.62, 1491.76, 115.012, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70813, 6, -4203.64, 1494.26, 121.395, 0, 0, 0, 100, 0);

SET @GUID := 70818;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70818, 1, -4234.92, 1547.49, 126.534, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70818, 2, -4265.91, 1569.38, 133.28, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70818, 3, -4281.01, 1599.98, 133.654, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70818, 4, -4302.11, 1633.57, 134.678, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70818, 5, -4315.96, 1670.13, 135.905, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70818, 6, -4302.11, 1633.57, 134.678, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70818, 7, -4281.01, 1599.98, 133.654, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70818, 8, -4265.91, 1569.38, 133.28, 0, 0, 0, 100, 0);

SET @GUID := 70819;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70819, 1, -4215.1, 1564.35, 118.479, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70819, 2, -4180.45, 1555.49, 110.181, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70819, 3, -4156.68, 1546.29, 106.544, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70819, 4, -4126.06, 1537.17, 99.6366, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70819, 5, -4089.76, 1532.37, 93.8425, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70819, 6, -4126.06, 1537.17, 99.6366, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70819, 7, -4156.68, 1546.29, 106.544, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70819, 8, -4180.45, 1555.49, 110.181, 0, 0, 0, 100, 0);

SET @GUID := 70850;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70850, 1, -4092.91, 1493.31, 96.5598, 22000, 0, 0, 0, 0); -- 2201701
INSERT INTO `waypoint_data` VALUES (70850, 2, -4092.91, 1493.31, 96.5598, 1000, 0, 0, 0, 0);

SET @GUID := 70851;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70851, 1, -4234.69, 1496.32, 127.328, 22000, 0, 0, 0, 0); -- 2201701
INSERT INTO `waypoint_data` VALUES (70851, 2, -4234.69, 1496.32, 127.328, 1000, 0, 0, 0, 0);

SET @GUID := 70852;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70852, 1, -4162.61, 1544.51, 108.878, 22000, 0, 0, 0, 0); -- 2201701
INSERT INTO `waypoint_data` VALUES (70852, 2, -4162.61, 1544.51, 108.878, 1000, 0, 0, 0, 0);

SET @GUID := 70853;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70853, 1, -4288.84, 1598.95, 136.992, 22000, 0, 0, 0, 0); -- 2201701
INSERT INTO `waypoint_data` VALUES (70853, 2, -4288.84, 1598.95, 136.992, 1000, 0, 0, 0, 0);

SET @GUID := 70854;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70854, 1, -4394.37, 1695.86, 157.779, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70854, 2, -4385.76, 1701.12, 156.656, 22000, 0, 0, 0, 0); -- 2201701

SET @GUID := 70855;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70855, 1, -4375.27, 1652.96, 157.32, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70855, 2, -4380.66, 1663.27, 157.461, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70855, 3, -4389.26, 1670.82, 158.883, 30000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70855, 4, -4380.12, 1662.37, 157.488, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70855, 5, -4374.9, 1652.34, 157.29, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70855, 6, -4381.38, 1642.9, 159.117, 60000, 0, 0, 0, 0);

SET @GUID := 70856;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70856, 1, -4417.68, 1580.7, 163.462, 22000, 0, 0, 0, 0); -- 2201701
INSERT INTO `waypoint_data` VALUES (70856, 2, -4418.79, 1566.57, 164.76, 60000, 0, 0, 0, 0);

SET @GUID := 70858;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70858, 1, -4486.56, 1647.48, 165.475, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70858, 2, -4471.61, 1654.49, 162.833, 22000, 0, 0, 0, 0); -- 2201701
INSERT INTO `waypoint_data` VALUES (70858, 3, -4486.56, 1647.48, 165.475, 45000, 0, 0, 0, 0);

SET @GUID := 70861;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70861, 1, -4484.18, 1744.06, 158.657, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70861, 2, -4476.58, 1750.96, 158.348, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70861, 3, -4469.4, 1760.97, 158.252, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70861, 4, -4465.99, 1769.93, 158.857, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70861, 5, -4471.04, 1758.56, 158.216, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70861, 6, -4481.98, 1745.8, 158.59, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70861, 7, -4487.37, 1743.44, 158.809, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (70861, 8, -4498.17, 1742.18, 159.676, 20000, 0, 0, 0, 0); -- 1979601

SET @GUID := 70862;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70862, 1, -4473.33, 1681.59, 162.246, 22000, 0, 0, 0, 0); -- 2201701
INSERT INTO `waypoint_data` VALUES (70862, 2, -4486.05, 1693.03, 164.847, 60000, 0, 0, 0, 0);

-- INSERT INTO `dbscripts_on_creature_movement` VALUES (2201701, 1, 15, 35190, 0, 20431, 20, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'cast 35190 on buddy');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (2201701, 20, 15, 6273, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- INSERT INTO `dbscripts_on_creature_movement` VALUES (1979601, 0, 31, 19792, 10, 0, 0, 0, -10000, 0, 0, 0, 0, 0, 0, 0, '');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (1979601, 2, 1, 66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (1979601, 4, 1, 66, 0, 19792, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'force 19792 to: emote');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (1979601, 7, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (1979601, 9, 1, 1, 0, 19792, 10, 4, 0, 0, 0, 0, 0, 0, 0, 0, 'force 19792 to: emote');
-- INSERT INTO `dbscripts_on_creature_movement` VALUES (1979601, 11, 1, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

UPDATE `creature_template` SET `skinloot` = 80010 WHERE `entry` = 18343; -- 80004
UPDATE `creature_template` SET `skinloot` = 80011 WHERE `entry` = 20268; -- 80004

DELETE FROM `skinning_loot_template` WHERE `entry` = 80010;
INSERT INTO `skinning_loot_template` VALUES (80010, 23425, 100, 0, 4, 8, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 23427, 75, 0, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 22447, 50, 0, 3, 6, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 21929, 0, 1, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 23077, 0, 2, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 23079, 0, 1, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 23107, 0, 1, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 23112, 0, 2, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80010, 23117, 0, 2, 1, 2, 0, 0, 0);

DELETE FROM `skinning_loot_template` WHERE `entry` = 80011;
INSERT INTO `skinning_loot_template` VALUES (80011, 23425, 100, 0, 4, 8, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23427, 75, 0, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 22447, 50, 0, 3, 6, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 21929, 0, 1, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23077, 0, 2, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23079, 0, 1, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23107, 0, 1, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23112, 0, 2, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23117, 0, 2, 1, 2, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23439, 0, 3, 1, 1, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23436, 0, 3, 1, 1, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23437, 0, 3, 1, 1, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23441, 0, 3, 1, 1, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23440, 0, 3, 1, 1, 0, 0, 0);
INSERT INTO `skinning_loot_template` VALUES (80011, 23438, 0, 3, 1, 1, 0, 0, 0);

UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%First Aid Trainer%'; -- npc to check 2327
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Blacksmithing Trainer%'; -- 2998
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Herbalism Trainer%'; -- 908
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Tailoring Trainer%'; -- 2399
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Alchemy Trainer%'; -- 1386
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Skinning Trainer%'; -- 6289
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Enchanting Trainer%'; -- 11073
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Cooking Trainer%'; -- 16277
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Mining Trainer%'; -- 16663
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Engineering Trainer%'; -- 3494
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Fishing Trainer%'; -- 1700 Alliance
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Jewelcrafting Trainer%'; -- 15501
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Leatherworking Trainer%'; -- 21087
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Armorsmith Trainer%'; -- 7230
UPDATE `creature_template` SET `npcflag` = `npcflag`|64 WHERE `subname` LIKE '%Weaponsmith Trainer%'; -- 20124

UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Mage Trainer%'; -- 198
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Portal Trainer%'; -- 2485
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Priest Trainer%'; -- 375
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Warlock Trainer%'; -- 459
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Demon Trainer%'; -- 5520
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Rogue Trainer%'; -- 915
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Druid Trainer%'; -- 3033
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Hunter Trainer%'; -- 895
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Pet Trainer%'; -- 543
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Shaman Trainer%'; -- 986
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Warrior Trainer%'; -- 911
UPDATE `creature_template` SET `npcflag` = `npcflag`|32 WHERE `subname` LIKE '%Paladin Trainer%'; -- 925

DELETE FROM creature  WHERE id IN (21909, 21924);

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES
(200059, 21909, 530, 1, 0, 0, -3413.58, 828.195, -30.7598, 1.18588, 300, 3, 0, 2800, 0, 1),
('200060','21909','530','1','0','0','-3414.29','813.942','-31.1204','1.47848','300','3','0','2800','0','1'),
('200061','21909','530','1','0','0','-3408.51','795.854','-31.4297','1.45215','300','3','0','2800','0','1');

-- Arcano-Scorp Credit 21924

-- Arcano-Scorp 21909
UPDATE creature_template SET spell1=37918, spell2=37851 WHERE entry=21909;

-- Arcano Control Unit 185008, 185009, 185010
UPDATE gameobject_template SET ScriptName='go_arcanocontroller' WHERE entry IN (185008, 185009, 185010);

UPDATE `creature_template` SET `ScriptName`='' WHERE `ScriptName`='npc_rogue_trainer';

DELETE FROM `npc_option` WHERE `id`=54;
INSERT INTO `npc_option` (`id`, `npcflag`, `action`, `option_text`) VALUES
('54', '16', '21', '<Take the letter>');

UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid`= 75414;
UPDATE `creature_template` SET `ScriptName` = 'mob_sunfury_warlock' WHERE `creature_template`.`entry` = 21503;

UPDATE creature SET position_x = '-3821.350098', position_y = '388.109009', position_z = '120.563004', orientation = '3.462162' WHERE guid = '75409';
UPDATE creature SET position_x = '-3824.939941', position_y = '374.354004', position_z = '120.572998', orientation = '2.276190' WHERE guid = '75408';
UPDATE creature SET position_x = '-3841.300049', position_y = '376.158997', position_z = '120.410004', orientation = '0.783461' WHERE guid = '75414';
UPDATE creature SET position_x = '-3844.830078', position_y = '388.716003', position_z = '120.417999', orientation = '5.906568' WHERE guid = '75411';
UPDATE creature SET position_x = '-3840.110107', position_y = '403.463989', position_z = '120.544998', orientation = '5.052265' WHERE guid = '75410';
UPDATE creature SET position_x = '-3833.280029', position_y = '384.148010', position_z = '120.570999', orientation = '4.680910' WHERE guid = '28167';

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17357;
INSERT INTO `creature_ai_scripts` VALUES
('1735701','17357','0','0','100','7','3000','6000','3800','6500','11','30494','0','0','0','0','0','0','0','0','0','0','Creeping Oozeling - Cast Sticky Ooze');

-- Raging Flames 20481,21538
UPDATE `creature_template` SET `speed`='0.50', `resistance1` = -1, `resistance2` = -1, `resistance3` = -1, `resistance4` = -1, `resistance5` = -1, `resistance6` = -1 WHERE `entry` = 20481;
UPDATE `creature_template` SET `speed`='0.80', `resistance1` = -1, `resistance2` = -1, `resistance3` = -1, `resistance4` = -1, `resistance5` = -1, `resistance6` = -1 WHERE `entry` = 21538;

UPDATE `item_template` SET `RequiredLevel` = 70 WHERE `entry` IN (34060, 34061);

