-- Death's Door Fel Cannon Target Bunny
UPDATE `creature` SET `position_x` = 2195.8024, `position_y` = 5475.7568, `position_z` = 163.7464, `orientation` = 0.2682,`spawndist`='0',`movementtype`='0',`spawntimesecs`='1' WHERE `guid` = 78947;
-- UPDATE `creature_template` SET `flags_extra` = 130, `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 22495; -- 35 130

-- Blade's Edge - Legion - Invis Bunny
UPDATE `creature_template` SET `AIName` = 'EventAI', `InhabitType` = 5, `flags_extra`=130 WHERE `entry` = 20736;

-- Death's Door North Warp-Gate
UPDATE `creature` SET `position_x` = '2196.6601', `position_y` = '5474.8798', `position_z` = '153.5782', `spawntimesecs` = 60 WHERE `guid` = 78881;
UPDATE `creature_template` SET `mindmg` = 1, `maxdmg` = 1, `AIName` = 'EventAI', `flags_extra`= 2 WHERE `entry` = 22471; -- 202 350

-- Death's Door South Warp-Gate
UPDATE `creature` SET `position_x` = '1968.8369', `position_y` = '5316.9965', `position_z` = '154.0295', `spawntimesecs` = 60 WHERE `guid` = 78882;
UPDATE `creature_template` SET `mindmg` = 1, `maxdmg` = 1, `AIName` = 'EventAI', `flags_extra`= 2 WHERE `entry` = 22472; -- 202 350

-- Void Hound
UPDATE `creature_template` SET `modelid_A` = 17188, `modelid_H` = 17188 WHERE `entry` = 22500;

-- Canons
UPDATE `creature` SET `orientation` = '5.8660', `spawntimesecs` = 60 WHERE `guid` = 78794;
UPDATE `creature` SET `orientation` = '3.3174', `spawntimesecs` = 60 WHERE `guid` = 78793;

-- AIs
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (20736,22471,22472);
INSERT INTO `creature_ai_scripts` VALUES (2073601, 20736, 4, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Invis Bunny - Disable Melee on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2247101, 22471, 4, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Door North Warp-Gate - Invis Bunny - Disable Melee on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2247201, 22472, 4, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Door South Warp-Gate - Invis Bunny - Disable Melee on Aggro');

-- Godan 3345
UPDATE `creature_template` SET `equipment_id` = 0 WHERE `entry` = 3345; -- 488 Fishing Pole now not used in any template

UPDATE `creature` SET `position_x` = '-185.0473', `position_y` = '206.4911', `position_z` = '78.8817' WHERE `guid` = 15507;
UPDATE `creature` SET `position_x` = '-181.6646', `position_y` = '68.2096', `position_z` = '67.8410' WHERE `guid` = 16655;

-- 3239,3240,3685 Benedict's Chest, Taillasher Eggs, Silithid Mound Lootable
UPDATE `gameobject_template` SET `faction` = 0 WHERE `entry` IN (3239,3240,3685);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16473;
INSERT INTO `creature_ai_scripts` VALUES
('1647301','16473','0','0','70','3','5000','10000','11000','15000','11','29680','0','0','0','0','0','0','0','0','0','0','Spectral Performer - Cast Curtain Call'),
('1647302','16473','0','0','100','3','11000','17000','15000','21000','11','29679','1','32','0','0','0','0','0','0','0','0','Spectral Performer - Cast Bad Poetry'),
('1647303','16473','2','0','100','3','50','0','25000','35000','11','29683','0','1','0','0','0','0','0','0','0','0','Spectral Performer - Cast Spotlight at 50% HP'),
('1647304','16473','6','0','20','2','0','0','0','0','1','-138','0','0','0','0','0','0','0','0','0','0','Spectral Performer - Say on Death');

UPDATE `creature_template` SET `mechanic_immune_mask`='1039089663' WHERE `entry` = 16473;

DELETE FROM `gameobject` WHERE `guid` IN (13691202,13674995);
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16231.7783', `position_y` = '16282.6748', `position_z` = '20.8547', `orientation` = '5.3060', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13675185;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16229.9443', `position_y` = '16254.8974', `position_z` = '13.4824', `orientation` = '2.3175', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 14107551;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16231.1718', `position_y` = '16263.1748', `position_z` = '13.4947', `orientation` = '3.2640', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13675189;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16219.2783', `position_y` = '16260.9707', `position_z` = '13.3842', `orientation` = '0.1538', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13675190;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16230.2246', `position_y` = '16267.2109', `position_z` = '13.2607', `orientation` = '3.5270', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13676379;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16219.8271', `position_y` = '16265.9970', `position_z` = '13.2733', `orientation` = '5.6005', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 14072713;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16221.7968', `position_y` = '16257.0742', `position_z` = '13.1844', `orientation` = '1.1354', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 12929294;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16231.6474', `position_y` = '16258.8544', `position_z` = '13.7686', `orientation` = '3.2364', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 12917797;
UPDATE `gameobject` SET `id` = 187345, `position_x` = '16224.1142', `position_y` = '16262.0175', `position_z` = '13.2639', `orientation` = '4.8466', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 14023982;

DELETE FROM `creature_ai_scripts` WHERE `id` = 1832501;
INSERT INTO `creature_ai_scripts` VALUES ('1832501','18325','0','0','100','7','8700','12700','10000','15000','11','27641','4','0','0','0','0','0','0','0','0','0','Sethekk Prophet - Cast Fear');

-- Tazan's Satchel
UPDATE `item_template` SET `flags` = 0 WHERE `entry` = 7209; -- 4

UPDATE `creature` SET `spawnmask` = 3, `spawntimesecs` = 86400 WHERE `id` = 17695 AND `spawntimesecs` = 7200;
DELETE FROM `pool_template` WHERE `entry` = 30028;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30028','5','Shattared Halls - Shattered Hand Assassin - Pool'); 
DELETE FROM `pool_creature` WHERE `pool_entry` = 30028;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99941,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99949,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99942,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99943,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99944,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99946,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99948,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99940,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99939,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99947,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99945,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99954,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');

DELETE FROM `creature` WHERE `guid` IN (15373,15484,15487,15466,15480,15482);
INSERT INTO `creature` VALUES (15373, 2375, 0, 1, 3617, 0, -1108.67, -39.2486, -2.84983, 0.361285, 300, 10, 0, 950, 0, 0, 1);
INSERT INTO `creature` VALUES (15466, 2349, 0, 1, 6808, 0, -285.62, -1156.22, 53.6537, 6.20492, 300, 10, 0, 664, 0, 0, 1);
INSERT INTO `creature` VALUES (15484, 2348, 0, 1, 8014, 0, -781.564, -891.376, 27.1351, 4.64985, 300, 5, 0, 788, 0, 0, 1);
INSERT INTO `creature` VALUES (15487, 2349, 0, 1, 6808, 0, -554.877, -972.102, 43.8503, 0.59589, 300, 10, 0, 664, 0, 0, 1);
INSERT INTO `creature` VALUES (15480, 2350, 0, 1, 1989, 0, -705.869, 388.254, 70.2089, 2.22054, 300, 10, 0, 494, 0, 0, 1);
INSERT INTO `creature` VALUES (15482, 2356, 0, 1, 3201, 0, -583.157, -950.196, 40.9115, 2.38018, 300, 10, 0, 944, 0, 0, 1);

-- Illidari Highlord 19797
UPDATE `creature_template` SET `speed`='1.20',`mechanic_immune_mask`='75569267',`flags_extra`='1073741824'  WHERE `entry` = 19797; -- 67110917

-- Illidari Mind Breaker 22074
UPDATE `creature_template` SET `speed`='1.20' WHERE `entry` = 22074;

-- Illidari Soldier 22075
UPDATE `creature_template` SET `speed`='1.20' WHERE `entry` = 22075;

-- Torloth the Magnificent 22076
UPDATE `creature_template` SET `speed`='1.48',`flags_extra`='1073741826' WHERE `entry` = 22076;

UPDATE `creature_template` SET `maxhealth`='22958',`speed`='0.6',`mindmg`='557',`maxdmg`='662',`mechanic_immune_mask`='650853375',`flags_extra`='1086390272' WHERE `entry` = 23375; -- 20958 0.5 100 205 -- 557 - 662

-- Aran Elemental Outsource

DELETE FROM `creature` WHERE `guid` IN (135128,135129,135130,135131,135132,135133,135138,135154);
DELETE FROM `creature_formations` WHERE `leaderguid` IN (57440,49978,50716,49805,50521,135172);
DELETE FROM `creature_formations` WHERE `memberguid` IN (57440,49978,50716,49805,50521,135172);
INSERT INTO `creature_formations` VALUES
(135172, 135172, 100, 360, 2),
(135172, 57440, 100, 360, 2),
(135172, 49978, 100, 360, 2),
(135172, 50716, 100, 360, 2),
(135172, 49805, 100, 360, 2),
(135172, 50521, 100, 360, 2);

DELETE FROM `creature_linked_respawn` WHERE `guid` = 45682;
INSERT INTO `creature_linked_respawn` VALUES (45682, 57440);

-- Shade of Aran Teleport Center 17176- Used for Elemental Check
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `AIName` = '' WHERE `entry` = 17176; -- `unit_flags` = 33554432 35 128
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17176;

UPDATE `creature` SET `spawntimesecs` = 780 WHERE `id` IN (17171,17168,17170,17169,17161,17176);
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel` = 70, `minmana` = 0, `maxmana` = 0, `faction_A` = 16, `faction_H` = 16, `AIName` = 'EventAI' WHERE `entry` IN (17171,17168,17170,17169);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (17171,17168,17170,17169,17176);
INSERT INTO `creature_ai_scripts` VALUES 
(1716801, 17168, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport N - Stop Movement and Stop Melee on Aggro'),
(1716802, 17168, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 29962, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport N - Cast Summon Water Elemental on 40% Shade of Aran HP'), -- 40% HP 
(1716803, 17168, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport N - Call for Help and Despawn'),

(1716901, 17169, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport S - Stop Movement and Stop Melee on Aggro'),
(1716902, 17169, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 37053, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport S - Cast Summon Water Elemental on 40% Shade of Aran HP'),
(1716903, 17169, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport S - Call for Help and Despawn'),

(1717001, 17170, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport E - Stop Movement and Stop Melee on Aggro'),
(1717002, 17170, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 37051, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport E - Cast Summon Water Elemental on 40% Shade of Aran HP'),
(1717003, 17170, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport E - Call for Help and Despawn'),

(1717101, 17171, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport W - Stop Movement and Stop Melee on Aggro'),
(1717102, 17171, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 37052, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport W - Cast Summon Water Elemental on 40% Shade of Aran HP'),
(1717103, 17171, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport W - Call for Help and Despawn');

-- Conjured Elemental 17167- mob_aran_elemental
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `mindmg` = 300, `maxdmg` = 600, `speed` = 1.00, `AIName` = 'EventAI', `ScriptName` = '' WHERE `entry` = 17167;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17167;
INSERT INTO `creature_ai_scripts` VALUES ('1716701','17167','9','0','100','3','0','40','1500','4000','11','31012','1','0','0','0','0','0','0','0','0','0','Conjured Elemental - Cast Water Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('1716702','17167','1','0','100','2','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Conjured Elemental - Despawn OOC');

-- Shade of Aran 16524
UPDATE `creature` SET `position_x`='-11164.9257',`position_y`='-1912.1971',`position_z`='232.0090',`orientation`='2.2226', `MovementType` = 0 WHERE `guid` = 57440;
UPDATE `creature_template` SET `mindmg`='2295',`maxdmg`='2760',`baseattacktime`='2000',`speed`='1.71',`flags_extra` = `flags_extra`|2|1048576 WHERE `entry` = 16524; -- 3060 3679 -- 4,590 - 5,519

-- Blizzard (Shade of Aran) 17161
UPDATE `creature_template` SET `speed` = 1.20, `unit_flags`='33554432',`flags_extra`='130' WHERE `entry` = 17161; -- 1,125 33554432 128

-- https://github.com/Looking4Group/L4G_Core/pull/3385
UPDATE creature_template SET ScriptName = 'npc_bloodmaul_dire_wolf' WHERE entry = 20058;
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=21176, `ReqSpellCast1`=0 WHERE entry=10506;

-- Droggam should only drop one of the quest items, not both.
-- https://github.com/Looking4Group/L4G_Core/issues/3374
DELETE FROM `creature_loot_template` WHERE  `entry`=20731 AND `item`=30415;

DELETE FROM `looking4group_string` WHERE `entry`=2026;
INSERT INTO `looking4group_string` (`entry`, `content_default`) VALUES 
('2026', '|cff00ff00Character|r %s |cff00ff00was reported for spam. Ticket entry:|r|cffff00ff %d.|r');

UPDATE `creature_template` SET `mechanic_immune_mask`='787431407' WHERE `entry` = 17546;

UPDATE `creature_template` SET `mindmg`='3956',`maxdmg`='4698' WHERE `entry` = 16181;

-- Recipe: Transmute Primal Might Restocktime
UPDATE `npc_vendor` SET `maxcount` = 1, `incrtime` = 9000 WHERE `item` = 23574; -- 43200

UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` IN (16595, 16596);

DELETE FROM `gameobject` WHERE `guid` IN (82599,82598,82597);

UPDATE `creature_template` SET `npcflag` = `npcflag`|64  WHERE `entry` IN (3690, 4773);

UPDATE creature_template SET ScriptName = 'npc_bloodmaul_dire_wolf' WHERE entry = 20058;
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=21176, `ReqSpellCast1`=0 WHERE entry=10506;

-- change trainer_type_mount cause since patch 1.12.1 the mount trainer system was reworked
UPDATE `creature_template` SET `trainer_type` = 2 where `trainer_type` = 1;

UPDATE `gameobject` SET `spawntimesecs` = 7200, `animprogress` = 100 WHERE `id` IN (176224, 181085);
UPDATE `gameobject_template` SET `flags` = 0, `data1` = 13646 WHERE `entry` = 176224; -- 4 0
DELETE FROM `gameobject_loot_template` WHERE `entry` IN (13646,17899);
INSERT INTO `gameobject_loot_template` VALUES (13646, 13180, 100, 0, 1, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (17899, 13180, 100, 0, 1, 4, 0, 0, 0);
DELETE FROM `gameobject` WHERE `guid` = 194585;
INSERT INTO `gameobject` VALUES (194585, 181085, 329, 1, 3504.23, -3371.19, 135.959, 4.18344, 0, 0, 0.86736, -0.497682, 7200, 100, 1);

-- Pattern: Heavy Knothide Leather Decrease Restocktime
UPDATE `npc_vendor` SET `incrtime` = 21600 WHERE `item` = 25720; -- 43200

UPDATE `creature_addon` SET `path_id` = 317 WHERE `guid` = 317;
DELETE FROM `waypoint_data` WHERE `id` = 317;
INSERT INTO `waypoint_data` VALUES (317, 1, 13.542, -115.249, -22.0705, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (317, 2, -32.8072, -95.2656, -21.5533, 0, 0, 0, 100, 0);

UPDATE `creature_addon` SET `path_id` = 16151 WHERE `guid` = 16151;
DELETE FROM `waypoint_data` WHERE `id` = 16151;
INSERT INTO `waypoint_data` VALUES (16151, 1, -569.682, -1401.96, 65.1979, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 2, -575.74, -1396.38, 64.9948, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 3, -584.413, -1389.3, 64.8748, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 4, -595.388, -1379.73, 64.8748, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 5, -588.171, -1386.76, 64.8748, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 6, -575.576, -1396.1, 64.9934, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 7, -568.931, -1402.08, 65.2048, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 8, -561.627, -1405.26, 65.1853, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 9, -558.839, -1407.12, 66.2219, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 10, -555.617, -1409.11, 66.222, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 11, -550.801, -1412.21, 67.9631, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 12, -543.596, -1416.84, 69.3283, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 13, -535.226, -1422.41, 68.9278, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 14, -530.073, -1425.87, 66.8384, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 15, -527.609, -1427.53, 66.222, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 16, -523.67, -1430.66, 66.2222, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 17, -528.096, -1427.69, 66.2221, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 18, -533.48, -1423.78, 68.4047, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 19, -539.745, -1419.4, 69.3461, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 20, -548.937, -1413, 68.8202, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 21, -555.197, -1408.62, 66.2221, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 22, -559.511, -1405.72, 66.222, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (16151, 23, -560.986, -1404.74, 65.1854, 0, 0, 0, 100, 0);

-- Mutanus the Devourer spawned via script
DELETE FROM `creature` WHERE `id` = 3654;

-- Ishamuhale spawned via http://db.hellfire-tbc.com/?item=10338
DELETE FROM `creature` WHERE `id` = 3257;

UPDATE `creature` SET `MovementType` = 0 WHERE `guid` = 48707;
DELETE FROM `creature_addon` WHERE `guid` = 48707;
DELETE FROM `waypoint_data` WHERE `id` = 1193;
-- INSERT INTO `waypoint_data` VALUES (48707, 1, -263.519, 150.466, -18.9955, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 2, -275.879, 148.999, -22.2309, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 3, -283.074, 148.146, -25.4312, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 4, -275.879, 148.999, -22.2309, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 5, -263.519, 150.466, -18.9955, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 6, -247.886, 140.202, -18.5693, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 7, -225.044, 153.121, -19.0445, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 8, -212.734, 154.857, -21.4755, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 9, -199.5, 155.408, -25.2446, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 10, -212.734, 154.857, -21.4755, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 11, -225.044, 153.121, -19.0445, 0, 0, 0, 100, 0);
-- -- INSERT INTO `waypoint_data` VALUES (48707, 12, -238.8606, 157.8310, -18.7639, 0, 0, 0, 100, 0);
-- INSERT INTO `waypoint_data` VALUES (48707, 13, -240.889, 165.027, -18.5517, 0, 0, 0, 100, 0);

UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16 WHERE `entry` = 8996;

UPDATE `creature_ai_scripts` SET `event_param1` = 5000, `event_param2` = 5000 WHERE `id` = 561701;
UPDATE `creature_ai_scripts` SET `event_param1` = 0 WHERE `id` = 561703;
UPDATE `creature_ai_scripts` SET `action1_param1` = 1 WHERE `id` = 561702;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 5615;
INSERT INTO `creature_ai_scripts` VALUES
('561501','5615','1','0','100','0','1000','1000','0','0','11','22766','0','32','0','0','0','0','0','0','0','0','Wastewander Rogue - Cast Sneak OOC'),
('561502','5615','9','0','100','1','0','5','6000','10000','11','8721','1','0','0','0','0','0','0','0','0','0','Wastewander Rogue - Cast Backstab'),
('561503','5615','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Wastewander Rogue - Flee at 15% HP');
UPDATE `creature_addon` SET `auras` = NULL WHERE `guid` IN (23464,23465,23466,23467,23470,23471,23475,23479,23480,23482,23483,23484,23485,23486,23487,23488,23489,23490,23491,23492,23493,92063,92413);

UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';

-- https://github.com/Looking4Group/L4G_Core/issues/964
DELETE FROM `script_texts` WHERE `entry`=-1000711;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000711, 'You\'ve found a cure! We will crush our enemies!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'Maghar Grunt SAY_THANKS1');
DELETE FROM `script_texts` WHERE `entry`=-1000710;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000710, 'You\'ve restored my health! I\'m in your debt, $N.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'Maghar Grunt SAY_THANKS2');
DELETE FROM `script_texts` WHERE `entry`=-1000709;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000709, 'My strength.... is... returning!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'Maghar Grunt SAY_THANKS3');
UPDATE creature_template SET ScriptName='npc_maghar_grunt' WHERE entry=16847;

DELETE FROM `npc_trainer` WHERE `entry` = 1000044 AND `spell` IN (29801,23881,20252,7386,23922,20243,12294);
INSERT INTO `npc_trainer` VALUES
(1000044, 29801, 0, 0, 0, 1),
(1000044, 23881, 0, 0, 0, 1),
(1000044, 20252, 0, 0, 0, 1),
(1000044, 7386, 0, 0, 0, 1),
(1000044, 23922, 0, 0, 0, 1),
(1000044, 20243, 0, 0, 0, 1),
(1000044, 12294, 0, 0, 0, 1);

UPDATE `creature_template` SET `ScriptName`='npc_fel_guard_hound' WHERE `entry`=21847; 
UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`=16863; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID`=16863;
INSERT INTO `creature_ai_scripts` (`id`,`entryOrGUID`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
-- Deranged Helboar 
('1686301','16863','1','0','100','0','1000','1000','0','0','11','33908','0','0','0','0','0','0','0','0','0','0','Deranged Helboar - Cast Burning Spikes on Spawn'),
('1686302','16863','2','0','100','0','30','0','0','0','11','8599','0','0','1','-106','0','0','0','0','0','0','Deranged Helboar - Cast Enrage at 30% HP'),
('1686303','16863','6','0','100','0','0','0','0','0','11','37689','0','7','0','0','0','0','0','0','0','0','Deranged Helboar - Cast Tell Dog I Just Died! on Death');
-- Missing gameobject template
DELETE FROM `gameobject_template` WHERE `entry`=184981;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `castBarCaption`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`) VALUES
(184981, 6, 1287, 'TEMP Felhound Poo Trap', '', 0, 0, 1, 0, 0, 0, 37695, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

-- Fix quest template for Corki quests. (values from tbc-db)
UPDATE quest_template SET ReqCreatureOrGOId1=18369, ReqCreatureOrGOCount1=1, ReqSpellCast1=0 WHERE entry=9923;
UPDATE quest_template SET ReqCreatureOrGOId1=20812, ReqCreatureOrGOCount1=1, ReqSpellCast1=0 WHERE entry=9924;
UPDATE quest_template SET ReqCreatureOrGOId1=18444, ReqCreatureOrGOCount1=1, ReqSpellCast1=0 WHERE entry=9955;
-- Our id's were totally mixed up. Update positions from tbc-db
UPDATE creature SET position_x=-2563.89, position_y=6288.29, position_z=15.295, orientation=5.23599 WHERE guid=65786;
UPDATE creature SET position_x=-918.143, position_y=8663.94, position_z=172.542, orientation=0.523599 WHERE guid=65849;
-- Quest relations also wrong
UPDATE creature_questrelation SET quest=9923 WHERE id=18369;
UPDATE creature_questrelation SET quest=9955 WHERE id=18445;
UPDATE creature_involvedrelation SET id=18445 WHERE quest=9954;

UPDATE `spell_affect` SET `spellfamilymask` = 0x20C01AF7 WHERE entry=12536;

UPDATE creature_template SET faction_A=35,faction_H=35 WHERE entry=4962;

-- Carrion Swarmer 13160
UPDATE `creature_template` SET `flags_extra` = 64 WHERE `entry` = 13160;

UPDATE `gameobject` SET `spawnMask` = 0 WHERE `id` = 2850;

-- The Underspore
UPDATE `gameobject` SET `spawntimesecs` = 60 WHERE `id` = 182054; -- 360

DELETE FROM `command` WHERE `name` IN ('account set multiacc','adgreduce','npc extraflag','npc fieldflag');
INSERT INTO `command` (name, permission_mask, help) VALUES
('account set multiacc', 8192, ''),
('adgreduce', 8192, ''),
('npc extraflag', 8192, ''),
('npc fieldflag', 8192, '');

UPDATE `npc_vendor` SET `incrtime` = 21600 WHERE `item` = 25848; -- 43200

UPDATE `creature_model_info` SET `bounding_radius` = 11, `combat_reach` = 11 WHERE `modelid` = 18698;

UPDATE `creature_model_info` SET `bounding_radius`= 2,`combat_reach`= 8 WHERE `modelid` = 19097;

UPDATE `creature` SET `position_x` = '-8394.000000', `position_y` = '448.941986', `position_z` = '123.760002', `orientation` = '0.6663' WHERE `guid` = 10523;
UPDATE `creature` SET `position_x` = '-8389.000000', `position_y` = '452.936005', `position_z` = '123.760002', `orientation` = '3.7961' WHERE `guid` = 10524;

UPDATE `creature_addon` SET `path_id` = 10528 WHERE `guid` = 10528;
DELETE FROM `waypoint_data` WHERE `id` = 10528;
INSERT INTO `waypoint_data` VALUES (10528, 1, -8532.2, 386.405, 108.386, 1, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 2, -8520.8, 395.473, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 3, -8510.08, 404.166, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 4, -8502.4, 404.974, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 5, -8497.35, 398.44, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 6, -8488.92, 399.493, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 7, -8483.58, 403.824, 108.386, 10000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 8, -8488.92, 399.493, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 9, -8497.35, 398.44, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 10, -8502.4, 404.974, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 11, -8510.08, 404.166, 108.386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (10528, 12, -8520.8, 395.473, 108.386, 0, 0, 0, 100, 0);

UPDATE `creature_template` SET `flags_extra` = `flags_extra`|4194304 WHERE `entry` IN (18831, 18832, 18834, 18835);

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (50521,49805,50716,49978,135172,45682,85212,85213,85214);
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('85212', '10999101');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('85213', '10999101');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('85214', '10999101');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('45682', '57440');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('135172', '57440');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('49978', '57440');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('50716', '57440');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('49805', '57440');
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES ('50521', '57440');

DELETE FROM `creature_addon` WHERE `guid` = 52386;
INSERT INTO `creature_addon` VALUES (52386,0,0,0,0,4097,173,0,'');

UPDATE `battleground_template` SET `MinPlayersPerTeam` = 8 WHERE `id` IN (2, 3, 7);

-- Baelmon the Hound-Master
UPDATE `creature_template` SET `mindmg`='1037',`maxdmg`='1229' WHERE `entry` = 19747;

-- Sharth Voldoun
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 18554; -- 1470

UPDATE `creature` SET `spawntimesecs` = 30 WHERE `guid` IN (86466,112008,111481);
UPDATE `creature` SET `spawntimesecs`= 7200 WHERE `guid` IN (13590, 13414, 13244, 110619);

DELETE FROM `game_event_creature` WHERE `guid` = 94378;
INSERT INTO `game_event_creature` VALUES (94378, 46);

UPDATE `creature_template` SET `npcflag` = `npcflag`|128 WHERE entry = 24975;

DELETE FROM `npc_vendor` WHERE `entry` = 24975;
INSERT INTO `npc_vendor` VALUES (24975, 3371, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (24975, 3372, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (24975, 8925, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (24975, 13467, 3, 9000, 0);
INSERT INTO `npc_vendor` VALUES (24975, 18256, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (24975, 22785, 3, 9000, 0);
INSERT INTO `npc_vendor` VALUES (24975, 22786, 3, 9000, 0);
INSERT INTO `npc_vendor` VALUES (24975, 22791, 3, 9000, 0);
INSERT INTO `npc_vendor` VALUES (24975, 22793, 1, 9000, 0);

DELETE FROM `spell_proc_event` WHERE entry = 30482;
-- INSERT INTO `spell_proc_event` VALUES (30482, 0, 0, 0, 131624, 0, 0, 0, 0);

UPDATE `creature` SET `position_x` = '-10947.0937', `position_y` = '-1957.2091', `position_z` = '275.2672' WHERE `guid` = 135911;

-- Druid [Subtlety]
-- Add Nature's Grasp & Regrowth
UPDATE `spell_affect` SET `SpellFamilyMask`='12965527033218834' WHERE (`entry`='17118') AND effectId = 1;
UPDATE `spell_affect` SET `SpellFamilyMask`='12965527033218834' WHERE (`entry`='17119') AND effectId = 1;
UPDATE `spell_affect` SET `SpellFamilyMask`='12965527033218834' WHERE (`entry`='17120') AND effectId = 1;
UPDATE `spell_affect` SET `SpellFamilyMask`='12965527033218834' WHERE (`entry`='17121') AND effectId = 1;
UPDATE `spell_affect` SET `SpellFamilyMask`='12965527033218834' WHERE (`entry`='17122') AND effectId = 1;

DELETE FROM `gameobject` WHERE `guid` IN (82587, 82576, 82586, 82589);

-- Remove duplicate SSC bridge objects
DELETE FROM `gameobject` WHERE `guid` IN (78715, 78716, 78717);

DELETE FROM `creature_loot_template` WHERE `item` = 18335;
INSERT INTO `creature_loot_template` VALUES (13526, 18335, 3.34, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11388, 18335, 2.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12156, 18335, 2.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11831, 18335, 1.98, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13236, 18335, 1.96, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13441, 18335, 1.94, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14521, 18335, 1.94, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13438, 18335, 1.88, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (7667, 18335, 1.8403, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (8717, 18335, 1.8287, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (7665, 18335, 1.8065, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14518, 18335, 1.72, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14519, 18335, 1.67, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13449, 18335, 1.58, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (1852, 18335, 1.5789, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11391, 18335, 1.5747, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11878, 18335, 1.56, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12158, 18335, 1.56, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12459, 18335, 1.5468, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (1843, 18335, 1.51, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13531, 18335, 1.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11445, 18335, 1.4938, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10317, 18335, 1.4842, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11387, 18335, 1.4785, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11469, 18335, 1.46, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13298, 18335, 1.46, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13530, 18335, 1.46, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11032, 18335, 1.44, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11339, 18335, 1.4358, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12339, 18335, 1.43, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14750, 18335, 1.4283, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13440, 18335, 1.42, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12128, 18335, 1.4, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9819, 18335, 1.3806, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10390, 18335, 1.38, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10681, 18335, 1.3686, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13448, 18335, 1.36, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11471, 18335, 1.34, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11657, 18335, 1.34, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10742, 18335, 1.3325, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11356, 18335, 1.3214, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10762, 18335, 1.321, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9260, 18335, 1.32, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11350, 18335, 1.3162, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9263, 18335, 1.3132, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10423, 18335, 1.3114, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13180, 18335, 1.31, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13139, 18335, 1.3063, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10316, 18335, 1.3034, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11284, 18335, 1.3023, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11352, 18335, 1.3014, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11340, 18335, 1.299, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9268, 18335, 1.2906, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13181, 18335, 1.29, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10318, 18335, 1.2875, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10464, 18335, 1.28, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14520, 18335, 1.28, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11475, 18335, 1.278, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16193, 18335, 1.2674, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14882, 18335, 1.2662, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11351, 18335, 1.2619, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14825, 18335, 1.2584, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11257, 18335, 1.2488, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9266, 18335, 1.2484, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9818, 18335, 1.2484, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10487, 18335, 1.2413, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12396, 18335, 1.24, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10399, 18335, 1.2338, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10486, 18335, 1.2315, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10996, 18335, 1.2288, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9717, 18335, 1.2222, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11582, 18335, 1.2203, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12157, 18335, 1.22, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14883, 18335, 1.2188, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12457, 18335, 1.2181, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (15591, 18335, 1.218, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9261, 18335, 1.215, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (15111, 18335, 1.2144, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10422, 18335, 1.213, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11448, 18335, 1.2054, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11043, 18335, 1.2052, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9693, 18335, 1.2042, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9583, 18335, 1.204, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10201, 18335, 1.2, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13284, 18335, 1.2, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13957, 18335, 1.2, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9216, 18335, 1.1997, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10418, 18335, 1.1968, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11470, 18335, 1.1946, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9817, 18335, 1.1932, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10421, 18335, 1.19, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (15980, 18335, 1.1886, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9264, 18335, 1.1885, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11453, 18335, 1.1876, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13443, 18335, 1.1855, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10476, 18335, 1.1838, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11830, 18335, 1.1803, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (1836, 18335, 1.18, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13576, 18335, 1.18, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9259, 18335, 1.1774, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13153, 18335, 1.1769, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13996, 18335, 1.1756, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10398, 18335, 1.1727, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10384, 18335, 1.1681, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11473, 18335, 1.1651, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10319, 18335, 1.165, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11444, 18335, 1.1621, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (7734, 18335, 1.16, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13437, 18335, 1.16, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (14351, 18335, 1.16, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10680, 18335, 1.1592, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (1832, 18335, 1.1589, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11456, 18335, 1.1585, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10426, 18335, 1.1578, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11441, 18335, 1.1557, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13137, 18335, 1.155, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13296, 18335, 1.1543, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10491, 18335, 1.1534, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11472, 18335, 1.1531, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10495, 18335, 1.1529, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10405, 18335, 1.1525, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (1846, 18335, 1.1504, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10400, 18335, 1.15, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9269, 18335, 1.1463, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10488, 18335, 1.1462, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9265, 18335, 1.1457, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (7463, 18335, 1.1436, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10424, 18335, 1.1431, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10425, 18335, 1.1422, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9448, 18335, 1.1407, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11679, 18335, 1.14, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11452, 18335, 1.1399, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10470, 18335, 1.139, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13152, 18335, 1.1382, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16154, 18335, 1.1376, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13147, 18335, 1.1374, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13140, 18335, 1.1369, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10382, 18335, 1.1362, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10419, 18335, 1.1359, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10417, 18335, 1.1316, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16163, 18335, 1.1316, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13447, 18335, 1.13, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16368, 18335, 1.1284, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10498, 18335, 1.1276, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10420, 18335, 1.1263, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10394, 18335, 1.1255, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9692, 18335, 1.1247, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11457, 18335, 1.1232, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10406, 18335, 1.1223, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10489, 18335, 1.1222, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10469, 18335, 1.1214, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (15981, 18335, 1.1211, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10471, 18335, 1.1208, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (8716, 18335, 1.12, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (1788, 18335, 1.1176, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13179, 18335, 1.114, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (7461, 18335, 1.1103, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9241, 18335, 1.1102, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9716, 18335, 1.1095, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10477, 18335, 1.1051, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13319, 18335, 1.1004, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10385, 18335, 1.0935, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10414, 18335, 1.0932, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10381, 18335, 1.093, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11450, 18335, 1.0833, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13176, 18335, 1.08, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16145, 18335, 1.0796, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11338, 18335, 1.0784, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11898, 18335, 1.0773, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10478, 18335, 1.0765, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16022, 18335, 1.0718, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9262, 18335, 1.0715, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10500, 18335, 1.071, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13318, 18335, 1.0699, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10416, 18335, 1.0691, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (9197, 18335, 1.0631, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10463, 18335, 1.0631, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10407, 18335, 1.062, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13300, 18335, 1.0619, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13797, 18335, 1.0585, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (1805, 18335, 1.0583, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10499, 18335, 1.0574, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13297, 18335, 1.0506, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13144, 18335, 1.0505, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13577, 18335, 1.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16020, 18335, 1.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13320, 18335, 1.0487, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11949, 18335, 1.048, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13154, 18335, 1.047, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13143, 18335, 1.0464, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13145, 18335, 1.0464, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13138, 18335, 1.0457, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13299, 18335, 1.0433, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12051, 18335, 1.0427, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11947, 18335, 1.0415, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (13146, 18335, 1.0383, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (10391, 18335, 1.037, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (11353, 18335, 1.0322, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (7072, 18335, 1.03, 0, 1, 1, 0, 0, 0);

DELETE FROM `item_template` WHERE `entry` IN (16302,16316,16317,16318,16319,16320,16321,16322,16323,16324,16325,16326,16327,16328,16329,16330,16331,16346,16347,16348,
16349,16350,16351,16352,16353,16354,16355,16356,16357,16358,16359,16360,16361,16362,16363,16364,16365,16366,16368,16371,16372,16373,16374,16375,16376,16377,16378,16379,16380,16381,16383,16384,
16385,16386,16387,16388,16389,16390,22179,22180,22181,22182,22184,22185,22186,22187,22188,22189,22190,23711,23730,23731,23734,23745,23755,25469,25900,28068,28071,28072,28073);
INSERT INTO `item_template` VALUES (16302, 9, 0, -1, 'Grimoire of Firebolt (Rank 2)', 1246, 1, 64, 1, 33, 25, 0, 31488, -1, 8, 8, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20270, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16316, 9, 0, -1, 'Grimoire of Firebolt (Rank 3)', 1246, 1, 64, 1, 500, 375, 0, 31488, -1, 18, 18, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20312, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16317, 9, 0, -1, 'Grimoire of Firebolt (Rank 4)', 1246, 1, 64, 1, 1667, 1250, 0, 31488, -1, 28, 28, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20313, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16318, 9, 0, -1, 'Grimoire of Firebolt (Rank 5)', 1246, 1, 64, 1, 3333, 2500, 0, 31488, -1, 38, 38, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20314, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16319, 9, 0, -1, 'Grimoire of Firebolt (Rank 6)', 1246, 1, 64, 1, 4667, 3500, 0, 31488, -1, 48, 48, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20315, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16320, 9, 0, -1, 'Grimoire of Firebolt (Rank 7)', 1246, 1, 64, 1, 8000, 6000, 0, 31488, -1, 58, 58, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20316, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16321, 9, 0, -1, 'Grimoire of Blood Pact (Rank 1)', 1246, 1, 64, 1, 33, 25, 0, 31488, -1, 4, 4, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20397, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16322, 9, 0, -1, 'Grimoire of Blood Pact (Rank 2)', 1246, 1, 64, 1, 300, 225, 0, 31488, -1, 14, 14, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20318, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16323, 9, 0, -1, 'Grimoire of Blood Pact (Rank 3)', 1246, 1, 64, 1, 1333, 1000, 0, 31488, -1, 26, 26, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20319, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16324, 9, 0, -1, 'Grimoire of Blood Pact (Rank 4)', 1246, 1, 64, 1, 3333, 2500, 0, 31488, -1, 38, 38, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20320, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16325, 9, 0, -1, 'Grimoire of Blood Pact (Rank 5)', 1246, 1, 64, 1, 5000, 3750, 0, 31488, -1, 50, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20321, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16326, 9, 0, -1, 'Grimoire of Fire Shield (Rank 1)', 1246, 1, 64, 1, 300, 225, 0, 31488, -1, 14, 14, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20322, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16327, 9, 0, -1, 'Grimoire of Fire Shield (Rank 2)', 1246, 1, 64, 1, 1000, 750, 0, 31488, -1, 24, 24, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20323, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16328, 9, 0, -1, 'Grimoire of Fire Shield (Rank 3)', 1246, 1, 64, 1, 2667, 2000, 0, 31488, -1, 34, 34, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20324, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16329, 9, 0, -1, 'Grimoire of Fire Shield (Rank 4)', 1246, 1, 64, 1, 4000, 3000, 0, 31488, -1, 44, 44, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20326, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16330, 9, 0, -1, 'Grimoire of Fire Shield (Rank 5)', 1246, 1, 64, 1, 6667, 5000, 0, 31488, -1, 54, 54, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20327, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16331, 9, 0, -1, 'Grimoire of Phase Shift', 1246, 1, 64, 1, 200, 150, 0, 31488, -1, 12, 12, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20329, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16346, 9, 0, -1, 'Grimoire of Torment (Rank 2)', 1246, 1, 64, 1, 667, 500, 0, 31488, -1, 20, 20, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20317, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16347, 9, 0, -1, 'Grimoire of Torment (Rank 3)', 1246, 1, 64, 1, 2000, 1500, 0, 31488, -1, 30, 30, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20377, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16348, 9, 0, -1, 'Grimoire of Torment (Rank 4)', 1246, 1, 64, 1, 3667, 2750, 0, 31488, -1, 40, 40, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20378, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16349, 9, 0, -1, 'Grimoire of Torment (Rank 5)', 1246, 1, 64, 1, 5000, 3750, 0, 31488, -1, 50, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20379, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16350, 9, 0, -1, 'Grimoire of Torment (Rank 6)', 1246, 1, 64, 1, 26000, 6500, 0, 31488, -1, 60, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20380, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16351, 9, 0, -1, 'Grimoire of Sacrifice (Rank 1)', 1246, 1, 64, 1, 400, 300, 0, 31488, -1, 16, 16, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20381, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16352, 9, 0, -1, 'Grimoire of Sacrifice (Rank 2)', 1246, 1, 64, 1, 1000, 750, 0, 31488, -1, 24, 24, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20382, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16353, 9, 0, -1, 'Grimoire of Sacrifice (Rank 3)', 1246, 1, 64, 1, 2333, 1750, 0, 31488, -1, 32, 32, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20383, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16354, 9, 0, -1, 'Grimoire of Sacrifice (Rank 4)', 1246, 1, 64, 1, 3667, 2750, 0, 31488, -1, 40, 40, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20384, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16355, 9, 0, -1, 'Grimoire of Sacrifice (Rank 5)', 1246, 1, 64, 1, 4667, 3500, 0, 31488, -1, 48, 48, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20385, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16356, 9, 0, -1, 'Grimoire of Sacrifice (Rank 6)', 1246, 1, 64, 1, 7333, 5500, 0, 31488, -1, 56, 56, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20386, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16357, 9, 0, -1, 'Grimoire of Consume Shadows (Rank 1)', 1246, 1, 64, 1, 500, 375, 0, 31488, -1, 18, 18, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20387, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16358, 9, 0, -1, 'Grimoire of Consume Shadows (Rank 2)', 1246, 1, 64, 1, 1333, 1000, 0, 31488, -1, 26, 26, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20388, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16359, 9, 0, -1, 'Grimoire of Consume Shadows (Rank 3)', 1246, 1, 64, 1, 2667, 2000, 0, 31488, -1, 34, 34, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20389, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16360, 9, 0, -1, 'Grimoire of Consume Shadows (Rank 4)', 1246, 1, 64, 1, 3667, 2750, 0, 31488, -1, 42, 42, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20390, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16361, 9, 0, -1, 'Grimoire of Consume Shadows (Rank 5)', 1246, 1, 64, 1, 5000, 3750, 0, 31488, -1, 50, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20391, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16362, 9, 0, -1, 'Grimoire of Consume Shadows (Rank 6)', 1246, 1, 64, 1, 8000, 6000, 0, 31488, -1, 58, 58, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20392, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16363, 9, 0, -1, 'Grimoire of Suffering (Rank 1)', 1246, 1, 64, 1, 1000, 750, 0, 31488, -1, 24, 24, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20393, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16364, 9, 0, -1, 'Grimoire of Suffering (Rank 2)', 1246, 1, 64, 1, 3000, 2250, 0, 31488, -1, 36, 36, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20394, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16365, 9, 0, -1, 'Grimoire of Suffering (Rank 3)', 1246, 1, 64, 1, 4667, 3500, 0, 31488, -1, 48, 48, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20395, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16366, 9, 0, -1, 'Grimoire of Suffering (Rank 4)', 1246, 1, 64, 1, 26000, 6500, 0, 31488, -1, 60, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20396, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16368, 9, 0, -1, 'Grimoire of Lash of Pain (Rank 2)', 1246, 1, 64, 1, 1667, 1250, 0, 31488, -1, 28, 28, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20398, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16371, 9, 0, -1, 'Grimoire of Lash of Pain (Rank 3)', 1246, 1, 64, 1, 3000, 2250, 0, 31488, -1, 36, 36, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20399, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16372, 9, 0, -1, 'Grimoire of Lash of Pain (Rank 4)', 1246, 1, 64, 1, 4000, 3000, 0, 31488, -1, 44, 44, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20400, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16373, 9, 0, -1, 'Grimoire of Lash of Pain (Rank 5)', 1246, 1, 64, 1, 6000, 4500, 0, 31488, -1, 52, 52, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20401, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16374, 9, 0, -1, 'Grimoire of Lash of Pain (Rank 6)', 1246, 1, 64, 1, 26000, 6500, 0, 31488, -1, 60, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20402, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16375, 9, 0, -1, 'Grimoire of Soothing Kiss (Rank 1)', 1246, 1, 64, 1, 833, 625, 0, 31488, -1, 22, 22, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20403, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16376, 9, 0, -1, 'Grimoire of Soothing Kiss (Rank 2)', 1246, 1, 64, 1, 2667, 2000, 0, 31488, -1, 34, 34, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20404, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16377, 9, 0, -1, 'Grimoire of Soothing Kiss (Rank 3)', 1246, 1, 64, 1, 4333, 3250, 0, 31488, -1, 46, 46, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20405, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16378, 9, 0, -1, 'Grimoire of Soothing Kiss (Rank 4)', 1246, 1, 64, 1, 8000, 6000, 0, 31488, -1, 58, 58, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20406, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16379, 9, 0, -1, 'Grimoire of Seduction', 1246, 1, 64, 1, 1333, 1000, 0, 31488, -1, 26, 26, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20407, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16380, 9, 0, -1, 'Grimoire of Lesser Invisibility', 1246, 1, 64, 1, 2333, 1750, 0, 31488, -1, 32, 32, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20408, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16381, 9, 0, -1, 'Grimoire of Devour Magic (Rank 2)', 1246, 1, 64, 1, 3333, 2500, 0, 31488, -1, 38, 38, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20426, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16383, 9, 0, -1, 'Grimoire of Devour Magic (Rank 4)', 1246, 1, 64, 1, 6667, 5000, 0, 31488, -1, 54, 54, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20428, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16384, 9, 0, -1, 'Grimoire of Tainted Blood (Rank 1)', 1246, 1, 64, 1, 2333, 1750, 0, 31488, -1, 32, 32, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20429, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16385, 9, 0, -1, 'Grimoire of Tainted Blood (Rank 2)', 1246, 1, 64, 1, 3667, 2750, 0, 31488, -1, 40, 40, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20430, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16386, 9, 0, -1, 'Grimoire of Tainted Blood (Rank 3)', 1246, 1, 64, 1, 4667, 3500, 0, 31488, -1, 48, 48, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20431, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16387, 9, 0, -1, 'Grimoire of Tainted Blood (Rank 4)', 1246, 1, 64, 1, 7333, 5500, 0, 31488, -1, 56, 56, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20432, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16388, 9, 0, -1, 'Grimoire of Spell Lock (Rank 1)', 1246, 1, 64, 1, 3000, 2250, 0, 31488, -1, 36, 36, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20433, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16389, 9, 0, -1, 'Grimoire of Spell Lock (Rank 2)', 1246, 1, 64, 1, 6000, 4500, 0, 31488, -1, 52, 52, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20434, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (16390, 9, 0, -1, 'Grimoire of Paranoia', 1246, 1, 64, 1, 3667, 2750, 0, 31488, -1, 42, 42, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20435, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22179, 9, 0, -1, 'Grimoire of Firebolt (Rank 8)', 1246, 1, 64, 1, 54000, 13500, 0, 31488, -1, 68, 68, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27487, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22180, 9, 0, -1, 'Grimoire of Blood Pact (Rank 6)', 1246, 1, 64, 1, 26000, 6500, 0, 31488, -1, 62, 62, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27488, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22181, 9, 0, -1, 'Grimoire of Fire Shield (Rank 6)', 1246, 1, 64, 1, 36000, 9000, 0, 31488, -1, 64, 64, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27489, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22182, 9, 0, -1, 'Grimoire of Torment (Rank 7)', 1246, 1, 64, 1, 67000, 16750, 0, 31488, -1, 70, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27490, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22184, 9, 0, -1, 'Grimoire of Consume Shadows (Rank 7)', 1246, 1, 64, 1, 44000, 11000, 0, 31488, -1, 66, 66, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27491, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22185, 9, 0, -1, 'Grimoire of Sacrifice (Rank 7)', 1246, 1, 64, 1, 36000, 9000, 0, 31488, -1, 64, 64, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27492, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22186, 9, 0, -1, 'Grimoire of Lash of Pain (Rank 7)', 1246, 1, 64, 1, 54000, 13500, 0, 31488, -1, 68, 68, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27493, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22187, 9, 0, -1, 'Grimoire of Soothing Kiss (Rank 5)', 1246, 1, 64, 1, 67000, 16750, 0, 31488, -1, 70, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27494, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22188, 9, 0, -1, 'Grimoire of Devour Magic (Rank 5)', 1246, 1, 64, 1, 29000, 7250, 0, 31488, -1, 62, 62, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27495, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22189, 9, 0, -1, 'Grimoire of Devour Magic (Rank 6)', 1246, 1, 64, 1, 67000, 16750, 0, 31488, -1, 70, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27496, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (22190, 9, 0, -1, 'Grimoire of Tainted Blood (Rank 5)', 1246, 1, 64, 1, 36000, 9000, 0, 31488, -1, 64, 64, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27497, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (23711, 9, 0, -1, 'Grimoire of Intercept (Rank 1)', 1246, 1, 64, 1, 6000, 4500, 0, 31488, -1, 52, 52, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30154, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (23730, 9, 0, -1, 'Grimoire of Intercept (Rank 2)', 1246, 1, 64, 1, 26000, 6500, 0, 31488, -1, 61, 61, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30199, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (23731, 9, 0, -1, 'Grimoire of Intercept (Rank 3)', 1246, 1, 64, 1, 60000, 15000, 0, 31488, -1, 69, 69, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30200, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (23734, 9, 0, -1, 'Grimoire of Cleave (Rank 1)', 1246, 1, 64, 1, 5000, 3750, 0, 31488, -1, 50, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30214, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (23745, 9, 0, -1, 'Grimoire of Cleave (Rank 2)', 1246, 1, 64, 1, 5000, 3750, 0, 31488, -1, 60, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30222, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (23755, 9, 0, -1, 'Grimoire of Cleave (Rank 3)', 1246, 1, 64, 1, 60000, 15000, 0, 31488, -1, 68, 68, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30224, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (25469, 9, 0, -1, 'Grimoire of Avoidance', 1246, 1, 64, 1, 26000, 6500, 0, 31488, -1, 60, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32234, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (25900, 9, 0, -1, 'Grimoire of Demonic Frenzy', 1246, 1, 64, 1, 7333, 5500, 0, 31488, -1, 56, 56, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32852, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (28068, 9, 0, -1, 'Grimoire of Suffering (Rank 6)', 1246, 1, 64, 1, 60000, 15000, 0, 31488, -1, 69, 69, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33703, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (28071, 9, 0, -1, 'Grimoire of Anguish (Rank 1)', 1246, 1, 64, 1, 5000, 3750, 0, 31488, -1, 50, 50, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33704, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (28072, 9, 0, -1, 'Grimoire of Anguish (Rank 2)', 1246, 1, 64, 1, 26000, 6500, 0, 31488, -1, 60, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33705, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
INSERT INTO `item_template` VALUES (28073, 9, 0, -1, 'Grimoire of Anguish (Rank 3)', 1246, 1, 64, 1, 67000, 16750, 0, 31488, -1, 70, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33706, 0, -1, -1, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);

-- Draenei Vindicator 16996
UPDATE `creature_template` SET `AIName` = 'EventAI', `equipment_id` = 3001 WHERE `entry` = 16996;
DELETE FROM `creature_equip_template` WHERE `entry` = 3001;
INSERT INTO `creature_equip_template` VALUES (3001, 3780, 0, 0, 50267138, 0, 0, 3, 0, 0);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16996;
INSERT INTO `creature_ai_scripts` VALUES
('1699601','16996','9','0','100','1','0','8','16000','25000','11','13005','4','32','0','0','0','0','0','0','0','0','Draenei Vindicator - Cast Hammer of Justice'),
('1699602','16996','0','0','100','1','7000','9000','30000','35000','11','33127','0','0','0','0','0','0','0','0','0','0','Draenei Vindicator - Cast Seal of Command'),
('1699603','16996','2','0','100','0','20','0','21000','28000','11','13874','0','0','0','0','0','0','0','0','0','0','Draenei Vindicator - Cast Divine Shield at 20% HP'),
('1699604','16996','1','0','100','0','30000','30000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Draenei Vindicator - Despawn OOC');

-- Draenei Anchorite 16994
UPDATE `creature_template` SET `AIName` = 'EventAI', `equipment_id` = 3003 WHERE `entry` = 16994;
DELETE FROM `creature_equip_template` WHERE `entry` IN (3002,3003);
INSERT INTO `creature_equip_template` VALUES
(3002,21968,0,0,50268674,0,0,2,0,0), -- non sparkle
(3003,31608,0,0,50268674,0,0,2,0,0); -- sparkle
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16994;
INSERT INTO `creature_ai_scripts` VALUES
('1699401','16994','4','0','100','0','0','0','0','0','11','25431','0','0','0','0','0','0','0','0','0','0','Draenei Anchorite - Cast Inner Fire on Aggro'),
('1699402','16994','14','0','100','1','1000','40','12000','15000','11','17137','6','0','0','0','0','0','0','0','0','0','Draenei Anchorite - Cast Flash Heal'),
('1699403','16994','0','0','100','1','5000','7000','17000','22000','11','17140','4','32','0','0','0','0','0','0','0','0','Draenei Anchorite - Cast Holy Fire'),
('1699404','16994','1','0','100','0','30000','30000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Draenei Anchorite - Despawn OOC');

UPDATE `spell_affect` SET `SpellFamilyMask` = 34376646656 WHERE `entry` = 37166;

DELETE FROM `creature` WHERE `guid` = 38421;
INSERT INTO `creature` VALUES (38421, 4571, 0, 1, 2640, 0, 1690.33, 138.073, -55.2145, 0.773067, 300, 0, 0, 1500, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = 38421;
INSERT INTO `creature_addon` VALUES (38421, 38421, 0, 16777472, 0, 4097, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id` = 38421;
INSERT INTO `waypoint_data` VALUES (38421, 1, 1692.2, 139.642, -55.2144, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 2, 1694.76, 138.543, -55.0225, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 3, 1698.87, 134.571, -52.5054, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 4, 1702.59, 131.03, -49.612, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 5, 1705.98, 127.957, -48.9152, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 6, 1709.31, 124.368, -49.6985, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 7, 1712.87, 120.622, -52.6176, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 8, 1717.21, 116.37, -55.215, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 9, 1715.93, 112.044, -55.215, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 10, 1710.19, 105.649, -60.2262, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 11, 1704.67, 98.548, -60.1567, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 12, 1702.47, 96.9137, -62.1837, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 13, 1696.2, 89.7006, -62.2455, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 14, 1693.45, 80.9227, -62.2896, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 15, 1694.97, 74.6062, -62.2896, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 16, 1703.91, 68.9162, -62.2896, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 17, 1716.82, 67.5873, -62.282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 18, 1726.94, 73.5294, -62.2807, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 19, 1746.53, 97.6153, -62.2778, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 20, 1761.98, 112.225, -62.2821, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 21, 1764.7, 122.499, -62.2893, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 22, 1762.12, 130.43, -62.2938, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 23, 1756.82, 135.878, -62.2966, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 24, 1748.17, 137.67, -62.2805, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 25, 1742.72, 136.389, -62.2153, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 26, 1737.08, 131.299, -62.1162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 27, 1735.05, 129.374, -60.1033, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 28, 1727.59, 123.737, -60.3729, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 29, 1721.74, 118.051, -55.2156, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 30, 1717.09, 117.097, -55.0316, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 31, 1713.29, 120.886, -52.6638, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 32, 1709.64, 123.817, -50.023, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 33, 1705.95, 127.812, -48.9135, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 34, 1702.81, 131.053, -49.581, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 35, 1699.2, 134.709, -52.4444, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 36, 1695.12, 138.729, -54.9684, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 37, 1694.59, 141.696, -55.2144, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 38, 1695.87, 143.529, -55.2143, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 39, 1701.86, 150.073, -60.4695, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 40, 1701.06, 158.275, -60.4383, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 41, 1704.81, 171.62, -60.7377, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 42, 1700.96, 175.207, -62.0006, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 43, 1694.13, 176.282, -62.1716, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 44, 1678.93, 164.417, -62.1567, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 45, 1661.36, 147.729, -62.1658, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 46, 1656.41, 141.674, -62.1556, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 47, 1658.16, 130.09, -62.1958, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 48, 1660.05, 128.195, -61.4954, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 49, 1670.62, 126.869, -61.4803, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 50, 1672.97, 126.965, -60.3898, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 51, 1683.95, 131.564, -60.4653, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38421, 52, 1690.07, 137.64, -55.2144, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `guid` = 32072;
INSERT INTO `creature` VALUES (32072, 14404, 0, 1, 14454, 0, 1617.09, 218.687, -59.2467, 0, 900, 0, 0, 5100, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = 32072;
INSERT INTO `creature_addon` VALUES (32072, 32072, 0, 16843008, 0, 4097, 0, 0, '18950 0');
DELETE FROM `waypoint_data` WHERE `id` = 32072;
INSERT INTO `waypoint_data` VALUES (32072, 1, 1617.09, 218.687, -59.2467, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 2, 1631.55, 204.236, -60.7761, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 3, 1640.15, 200.02, -60.7678, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 4, 1655.09, 207.06, -62.1803, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 5, 1668.47, 234.78, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 6, 1680.32, 239.207, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 7, 1723.51, 240.413, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 8, 1730.39, 230.812, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 9, 1728.82, 211.138, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 10, 1724.62, 196.027, -62.1626, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 11, 1718.69, 184.905, -60.7586, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 12, 1709.36, 179.081, -60.7305, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 13, 1701.33, 182.732, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 14, 1702.61, 194.201, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 15, 1698.51, 195.957, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 16, 1692.65, 187.999, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 17, 1679, 162.393, -62.1604, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 18, 1649.45, 142.482, -62.1477, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 19, 1637.99, 136.562, -62.1488, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 20, 1639.09, 132.697, -62.1597, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 21, 1650.7, 134.778, -62.1682, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 22, 1667.65, 127.941, -61.4869, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 23, 1682.42, 130.873, -60.4286, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 24, 1690.93, 138.499, -55.2145, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 25, 1693.52, 138.657, -55.2145, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 26, 1704.9, 128.41, -49.009, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 27, 1716.95, 114.974, -55.2154, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 28, 1717.12, 112.667, -55.2158, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 29, 1709.33, 104.537, -60.1854, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 30, 1696.45, 91.297, -62.2527, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 31, 1695.93, 86.824, -62.2604, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 32, 1702.34, 70.9391, -62.2922, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 33, 1709.62, 68.1468, -62.2882, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 34, 1738.57, 59.2006, -59.5723, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 35, 1749.86, 49.0943, -52.817, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 36, 1753.91, 47.7115, -52.817, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 37, 1766.79, 58.5176, -46.321, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 38, 1778.53, 70.2465, -46.317, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 39, 1786.4, 78.9438, -52.817, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 40, 1786.2, 83.474, -52.817, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 41, 1772.83, 97.0845, -60.6015, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 42, 1770.96, 104.361, -62.2738, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 43, 1756.44, 136.994, -62.2401, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 44, 1750.69, 140.286, -62.1918, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 45, 1742.04, 136.301, -62.1524, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 46, 1729.46, 125.036, -60.21, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 47, 1720.63, 116.774, -55.2157, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 48, 1718.35, 117.292, -55.2152, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 49, 1705.41, 129.555, -49.0482, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 50, 1694.9, 140.426, -55.2145, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 51, 1695.19, 142.793, -55.2145, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 52, 1702.09, 150.261, -60.4686, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 53, 1702.37, 152.251, -60.4589, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 54, 1700.79, 156.051, -60.448, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 55, 1712.58, 176.174, -60.7519, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 56, 1724.33, 198.704, -62.1648, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 57, 1730.76, 214.786, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 58, 1732.08, 228.061, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 59, 1720.84, 236.727, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 60, 1675.71, 241.504, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 61, 1666.81, 247.804, -62.178, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 62, 1665.4, 249.851, -62.1778, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 63, 1658.12, 270.697, -62.1794, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 64, 1655.74, 273.132, -62.1799, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 65, 1640.92, 281.127, -60.7668, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 66, 1637.55, 279.363, -60.7701, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 67, 1620.19, 263.86, -58.9402, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 68, 1610.99, 255.713, -61.9098, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 69, 1607.46, 253.633, -62.0916, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 70, 1596.37, 252.838, -62.0975, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 71, 1584.99, 252.553, -62.1102, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 72, 1583.53, 251.004, -62.1036, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 73, 1584.34, 225.876, -62.0858, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 74, 1585.53, 222.97, -62.1403, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 75, 1593.44, 221.058, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 76, 1594.7, 230.496, -52.1552, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 77, 1589.6, 231.807, -52.1454, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 78, 1586.99, 233.745, -52.1458, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 79, 1586.88, 246.49, -52.1549, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 80, 1587.66, 247.933, -52.1531, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 81, 1590.81, 248.534, -52.1547, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 82, 1602.72, 248.408, -52.1477, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 83, 1605.24, 245.458, -52.1536, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 84, 1606.5, 241.89, -52.1555, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 85, 1607.7, 240.195, -52.1589, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 86, 1630.69, 241.34, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 87, 1632.83, 242.523, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 88, 1632.96, 245.954, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 89, 1631.51, 254.891, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 90, 1613.1, 273.434, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 91, 1605.62, 276.518, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 92, 1586.84, 276.654, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 93, 1578.67, 274.247, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 94, 1562.31, 257.007, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 95, 1558.67, 246.731, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 96, 1559.34, 229.621, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 97, 1562.74, 222.946, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 98, 1578.15, 207.449, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 99, 1586.2, 204.75, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 100, 1604.9, 204.706, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 101, 1611.63, 206.971, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 102, 1628.34, 223.248, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 103, 1631.79, 229.782, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 104, 1632.78, 236.384, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 105, 1630.62, 237.216, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 106, 1607.8, 239.176, -52.1592, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 107, 1606.17, 237.944, -52.1547, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 108, 1604.56, 233.824, -52.1459, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 109, 1602.06, 231.893, -52.1512, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 110, 1596.99, 231.884, -52.1509, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 111, 1596.21, 221.58, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 112, 1606.62, 223.471, -62.1119, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32072, 113, 1609.26, 223.324, -61.9032, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `guid` = 31872;
INSERT INTO `creature` VALUES (31872, 5732, 0, 1, 4109, 0, 1505.12, 243.027, -62.1777, 0.022364, 300, 0, 0, 1900, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = 31872;
INSERT INTO `creature_addon` VALUES (31872, 31872, 0, 16843008, 0, 4097, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id` = 31872;
INSERT INTO `waypoint_data` VALUES (31872, 1, 1522.48, 244.058, -62.1777, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 2, 1528.44, 267.6, -62.1777, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 3, 1540.64, 286.87, -62.1807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 4, 1559.33, 302.771, -62.1794, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 5, 1592.42, 309.175, -62.1793, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 6, 1595.77, 321.185, -62.1792, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 7, 1594.66, 361.866, -62.1792, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 8, 1585.56, 373.068, -62.1792, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 9, 1562.96, 371.724, -61.6201, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 10, 1547.47, 367.693, -62.184, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 11, 1537.93, 359.399, -61.5061, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 12, 1519.49, 349.405, -60.7889, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 13, 1511.65, 344.481, -60.0904, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 14, 1491.67, 323.27, -60.0917, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 15, 1478.44, 300.126, -61.5167, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 16, 1468.36, 282.284, -62.1743, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 17, 1465.31, 277.089, -61.62, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 18, 1463.87, 248.681, -62.1776, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31872, 19, 1479.31, 241.924, -62.1776, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 32074;
INSERT INTO `creature` VALUES (32074, 14403, 0, 1, 14453, 0, 1609.25, 223.458, -61.9034, 0, 900, 0, 0, 8900, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = 32074;
INSERT INTO `creature_addon` VALUES (32074, 32074, 0, 16777472, 0, 4097, 0, 0, '18950 0');
DELETE FROM `waypoint_data` WHERE `id` = 32074;
INSERT INTO `waypoint_data` VALUES (32074, 1, 1609.25, 223.458, -61.9034, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 2, 1625.3, 210.093, -60.7, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 3, 1639.94, 197.828, -60.7662, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 4, 1647.45, 200.848, -62.1817, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 5, 1667.02, 234.69, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 6, 1675.6, 239, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 7, 1723.02, 239.116, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 8, 1727.49, 241.209, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 9, 1729.36, 267.54, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 10, 1723.58, 290.441, -62.1844, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 11, 1720.12, 305.296, -61.4777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 12, 1718.49, 309.041, -61.4776, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 13, 1706.62, 324.028, -55.3924, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 14, 1707.66, 325.929, -55.3924, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 15, 1720.19, 335.44, -49.1403, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 16, 1734.86, 346.229, -55.3935, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 17, 1737.21, 345.446, -55.3939, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 18, 1744.15, 336.707, -60.4845, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 19, 1745.91, 336.582, -60.4845, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 20, 1773.95, 346.565, -62.2919, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 21, 1786.24, 357.143, -61.9606, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 22, 1792.52, 369.883, -60.159, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 23, 1792.49, 374.119, -60.159, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 24, 1787.54, 394.849, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 25, 1789.02, 398.807, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 26, 1788.91, 404.603, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 27, 1783.72, 410.248, -57.1944, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 28, 1776.08, 418.387, -58.031, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 29, 1761.86, 432.215, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 30, 1758.75, 431.906, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 31, 1754.99, 427.797, -57.208, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 32, 1752.37, 415.723, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 33, 1755.39, 404.236, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 34, 1761.86, 397.933, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 35, 1775.76, 395.263, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 36, 1783.61, 394.952, -57.2146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 37, 1785.32, 393.828, -57.2137, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 38, 1794.38, 372.68, -60.159, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 39, 1779.7, 349.051, -62.3233, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 40, 1757.67, 332.684, -62.2457, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 41, 1755.16, 332.687, -62.3082, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 42, 1744.68, 335.301, -60.4844, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 43, 1736.58, 344.367, -55.3936, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 44, 1734.49, 344.861, -55.3932, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 45, 1720.66, 334.889, -49.1375, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 46, 1708.5, 323.994, -55.3924, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 47, 1714.45, 313.474, -60.4849, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 48, 1714.44, 311.784, -60.4847, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 49, 1704.68, 296.586, -62.1763, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 50, 1703.6, 293.716, -62.1681, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 51, 1703.47, 283.342, -62.1567, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 52, 1702.13, 279.941, -62.1551, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 53, 1698.64, 280.802, -62.1489, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 54, 1697.22, 284.909, -62.1473, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 55, 1701.11, 293.63, -62.1622, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 56, 1700.36, 296.727, -62.1666, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 57, 1690.12, 309.386, -62.1682, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 58, 1668.72, 328.757, -62.164, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 59, 1640.5, 340.779, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 60, 1636.33, 344.566, -62.177, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 61, 1637.51, 347.035, -62.1783, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 62, 1642.68, 346.874, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 63, 1649.72, 344.399, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 64, 1653.71, 346.036, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 65, 1658.57, 355.837, -60.7433, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 66, 1656.86, 359.73, -60.7457, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 67, 1638.04, 370.099, -62.1692, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 68, 1611.81, 375.152, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 69, 1572.17, 374.006, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 70, 1551.99, 369.247, -62.1816, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 71, 1544.06, 358.657, -62.19, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 72, 1538.39, 348.907, -62.1768, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 73, 1539.91, 346.422, -62.1725, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 74, 1552.08, 348.612, -62.1591, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 75, 1557.47, 348.297, -62.1556, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 76, 1557.97, 345.033, -62.1489, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 77, 1551.41, 341.444, -62.1405, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 78, 1533.87, 335.02, -62.167, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 79, 1510.63, 312.581, -62.1477, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 80, 1498.7, 297.357, -62.1757, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 81, 1493.62, 284.433, -62.1717, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 82, 1490.81, 281.06, -62.1727, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 83, 1488.55, 281.725, -62.1636, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 84, 1490.05, 297.732, -62.1824, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 85, 1486.55, 310.192, -61.4948, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 86, 1488.01, 319.712, -60.7861, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 87, 1500.95, 335.121, -60.0923, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 88, 1513.51, 345.537, -60.0912, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 89, 1534.2, 356.902, -61.4984, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 90, 1554.56, 368.312, -62.182, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 91, 1571.42, 375.187, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 92, 1585.84, 377.765, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 93, 1592.03, 370.874, -62.1947, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 94, 1597.09, 347.085, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 95, 1596.72, 319.143, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 96, 1599.78, 311.695, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 97, 1630.8, 295.77, -62.1767, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 98, 1636.08, 284.011, -60.7685, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 99, 1633.37, 278.824, -60.7766, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 100, 1611.44, 256.594, -61.9106, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 101, 1608.65, 256.319, -62.096, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 102, 1598.78, 259.965, -57.1617, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 103, 1596.85, 259.143, -57.1617, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 104, 1595.79, 257.024, -56.9791, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 105, 1595.79, 257.024, -56.9791, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 106, 1595.77, 249.513, -52.1528, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 107, 1597.26, 248.567, -52.1501, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 108, 1603.44, 249.175, -52.1474, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 109, 1605.08, 247.345, -52.1539, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 110, 1606.02, 242.434, -52.1542, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 111, 1607.03, 240.719, -52.157, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 112, 1630.53, 240.444, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 113, 1632.89, 243.005, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 114, 1632.59, 249.767, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 115, 1631.35, 254.087, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 116, 1612.68, 274.291, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 117, 1606.97, 276.323, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 118, 1586.31, 276.41, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 119, 1580.77, 274.948, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 120, 1563.42, 257.585, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 121, 1560.01, 251.964, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 122, 1558.89, 241.319, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 123, 1559.38, 231.329, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 124, 1561.18, 225.609, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 125, 1578.66, 206.978, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 126, 1585.73, 204.561, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 127, 1605.47, 204.048, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 128, 1611.46, 206.035, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 129, 1629.38, 223.781, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 130, 1633.15, 233.434, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 131, 1630.57, 236.934, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 132, 1607.13, 238.872, -52.1573, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 133, 1605.7, 237.491, -52.1456, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 134, 1603.53, 232.569, -52.1455, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 135, 1596.86, 231.52, -52.1519, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 136, 1596.12, 220.683, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 137, 1598.21, 220.211, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32074, 138, 1606.56, 223.616, -62.1116, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `guid` IN (38429, 38430);
INSERT INTO `creature` VALUES (38429, 5668, 0, 1, 4004, 0, 1598.63, 340.759, -62.1777, 1.54469, 300, 0, 0, 490, 0, 0, 0);
INSERT INTO `creature` VALUES (38430, 5670, 0, 1, 4005, 0, 1596.62, 340.43, -62.1777, 1.53766, 300, 0, 0, 940, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` IN (38429, 38430);
INSERT INTO `creature_addon` VALUES (38429, 0, 0, 16843008, 0, 4096, 0, 0, NULL);
INSERT INTO `creature_addon` VALUES (38430, 32035, 0, 16777472, 0, 4096, 0, 0, NULL);
DELETE FROM `creature_formations` WHERE `leaderguid` = 38430;
INSERT INTO `creature_formations` VALUES
(38430, 38430, 100, 360, 2),
(38430, 38429, 2, 1.57, 2);
DELETE FROM `waypoint_data` WHERE `id` = 38430;
INSERT INTO `waypoint_data` VALUES (38430, 1, 1596.41, 363.119, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 2, 1600.59, 371.134, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 3, 1604.57, 375.022, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 4, 1612.86, 375.448, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 5, 1629.42, 373.423, -61.6199, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 6, 1636.5, 371.63, -62.0316, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 7, 1648.59, 366.277, -62.1478, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 8, 1650.51, 364.818, -60.7627, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 9, 1658.69, 356.651, -60.7464, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 10, 1660.31, 351.521, -60.7251, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 11, 1659.8, 344.908, -62.1714, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 12, 1660.42, 337.393, -62.1724, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 13, 1686.19, 312.154, -62.1589, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 14, 1693.32, 305.168, -62.1613, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 15, 1700.09, 302.831, -62.1701, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 16, 1714.19, 304.062, -61.4879, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 17, 1720.74, 299.715, -61.4923, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 18, 1722.4, 297.283, -62.1776, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 19, 1728.38, 279.716, -62.1779, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 20, 1729.16, 274.654, -61.6199, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 21, 1729.83, 270.673, -62.0556, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 22, 1733.4, 254.988, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 23, 1731.59, 247.396, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 24, 1722.09, 241.103, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 25, 1708.78, 237.128, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 26, 1667.44, 238.904, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 27, 1661.93, 245.751, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 28, 1659.92, 263.654, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 29, 1652.95, 278.419, -62.1774, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 30, 1645.44, 287.234, -62.1818, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 31, 1632.76, 298.534, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 32, 1621.63, 304.092, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 33, 1602.04, 308.263, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 34, 1597.12, 314.251, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 35, 1595.59, 321.995, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (38430, 36, 1596.3, 340.951, -62.1788, 0, 0, 0, 100, 0);

UPDATE `creature_template` SET `minhealth` = 2218, `maxhealth` = 2218 WHERE `entry` = 23713;
DELETE FROM `creature` WHERE `guid` = 32035;
INSERT INTO `creature` VALUES (32035, 23713, 0, 1, 8848, 1, 1556.82, 206.279, -60.7725, 1.4197, 300, 0, 0, 2218, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = 32035;
INSERT INTO `creature_addon` VALUES (32035, 32035, 0, 16777472, 0, 4097, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id` = 32035;
INSERT INTO `waypoint_data` VALUES (32035, 1, 1560.83, 209.632, -60.7421, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 2, 1567.42, 215.764, -59.5841, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 3, 1573.73, 221.612, -59.6846, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 4, 1578.99, 223.877, -61.8354, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 5, 1583.84, 224.62, -62.0892, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 6, 1595.7, 219.823, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 7, 1595.65, 225.848, -55.2846, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 8, 1596.25, 231.32, -52.153, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 9, 1605.35, 230.99, -52.1497, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 10, 1607.17, 235.047, -52.1509, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 11, 1607.14, 240.583, -52.1573, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 12, 1616.12, 240.593, -47.4926, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 13, 1624.23, 239.499, -43.8868, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 14, 1631.11, 241.189, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 15, 1624.3, 239.49, -43.8772, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 16, 1616.12, 240.593, -47.4926, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 17, 1607.14, 240.583, -52.1573, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 18, 1607.17, 235.047, -52.1509, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 19, 1605.35, 230.99, -52.1497, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 20, 1596.25, 231.32, -52.153, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 21, 1595.65, 225.848, -55.2846, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 22, 1595.7, 219.823, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 23, 1583.84, 224.62, -62.0892, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 24, 1579.19, 223.908, -61.9083, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 25, 1573.73, 221.612, -59.6846, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 26, 1567.42, 215.764, -59.5841, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 27, 1560.83, 209.632, -60.7421, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 28, 1557.04, 206.466, -60.7763, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 29, 1550.39, 203.157, -60.7695, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 30, 1545.23, 202.719, -62.1832, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 31, 1539.65, 204.423, -62.1826, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 32, 1534.03, 208.736, -62.1818, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 33, 1530.08, 215.568, -62.1809, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 34, 1531.97, 227.786, -62.1783, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 35, 1532.85, 234.12, -62.1783, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 36, 1533.76, 241.554, -62.1782, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 37, 1535.32, 247.9, -62.1781, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 38, 1536.04, 255.27, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 39, 1537.23, 263.136, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 40, 1542.86, 271.875, -62.1768, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 41, 1546.77, 277.976, -62.1833, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 42, 1555.23, 283.841, -60.7743, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 43, 1559, 279.925, -60.772, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 44, 1562.27, 274.753, -60.7577, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 45, 1565.53, 269.078, -60.6939, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 46, 1568.66, 265.453, -59.4534, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 47, 1573.28, 260.474, -59.3003, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 48, 1576.91, 256.333, -61.3601, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 49, 1579.96, 255.398, -61.9104, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 50, 1583.6, 256.013, -62.0965, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 51, 1586.94, 257.516, -61.4295, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 52, 1589.17, 258.373, -59.639, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 53, 1593.72, 259.792, -57.1617, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 54, 1596.38, 257.637, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 55, 1595.66, 252.608, -53.6675, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 56, 1596.05, 249.318, -52.1528, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 57, 1589.19, 248.801, -52.1533, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 58, 1585.73, 245.916, -52.1526, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 59, 1584.44, 242.4, -52.1516, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 60, 1579.16, 241.369, -49.833, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 61, 1569.92, 242.132, -44.9335, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 62, 1563.14, 243.895, -43.3325, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 63, 1559.2, 247.966, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 64, 1561.46, 256.767, -43.1026, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 65, 1568.45, 263.594, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 66, 1575.97, 271.122, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 67, 1587.46, 276.32, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 68, 1601.59, 275.179, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 69, 1611.95, 274.535, -43.1028, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 70, 1620.38, 266.854, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 71, 1628.55, 255.421, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 72, 1630.92, 248.495, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 73, 1631.49, 231.21, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 74, 1629.06, 224.007, -43.1025, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 75, 1621.78, 216.405, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 76, 1612.36, 208.564, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 77, 1599.45, 204.769, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 78, 1589.99, 204.937, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 79, 1579.58, 207.341, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 80, 1572.47, 213.801, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 81, 1563.91, 223.09, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 82, 1559.54, 231.344, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 83, 1558.18, 239.552, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 84, 1559.54, 231.359, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 85, 1563.91, 223.09, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 86, 1572.36, 213.924, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 87, 1579.58, 207.341, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 88, 1589.99, 204.937, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 89, 1599.45, 204.769, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 90, 1612.36, 208.564, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 91, 1621.78, 216.405, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 92, 1629.06, 224.007, -43.1025, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 93, 1631.49, 231.21, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 94, 1630.92, 248.495, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 95, 1628.55, 255.421, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 96, 1620.38, 266.854, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 97, 1611.95, 274.535, -43.1028, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 98, 1601.59, 275.179, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 99, 1587.46, 276.32, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 100, 1575.97, 271.122, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 101, 1568.45, 263.594, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 102, 1561.46, 256.767, -43.1026, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 103, 1559.2, 247.966, -43.1027, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 104, 1563.14, 243.895, -43.3325, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 105, 1569.92, 242.132, -44.9335, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 106, 1579.16, 241.369, -49.833, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 107, 1584.44, 242.4, -52.1516, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 108, 1585.73, 245.916, -52.1526, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 109, 1589.19, 248.801, -52.1533, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 110, 1596.05, 249.318, -52.1528, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 111, 1595.65, 252.503, -53.5886, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 112, 1596.38, 257.637, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 113, 1593.8, 259.818, -57.1618, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 114, 1589.17, 258.373, -59.639, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 115, 1587.2, 257.613, -61.2253, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 116, 1583.6, 256.013, -62.0965, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 117, 1579.96, 255.398, -61.9104, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 118, 1576.91, 256.333, -61.3601, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 119, 1573.33, 260.418, -59.3121, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 120, 1568.66, 265.453, -59.4534, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 121, 1565.53, 269.078, -60.6939, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 122, 1562.27, 274.753, -60.7577, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 123, 1559, 279.925, -60.772, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 124, 1555.23, 283.841, -60.7743, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 125, 1546.77, 277.976, -62.1833, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 126, 1542.86, 271.875, -62.1768, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 127, 1537.23, 263.136, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 128, 1536.04, 255.27, -62.1777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 129, 1535.32, 247.9, -62.1781, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 130, 1533.76, 241.554, -62.1782, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 131, 1532.85, 234.12, -62.1783, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 132, 1531.97, 227.786, -62.1783, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 133, 1530.08, 215.568, -62.1809, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 134, 1534.03, 208.736, -62.1818, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 135, 1539.65, 204.423, -62.1826, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 136, 1545.23, 202.719, -62.1832, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 137, 1550.39, 203.157, -60.7695, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (32035, 138, 1556.82, 206.279, -60.7725, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `guid` IN (41830, 41831, 41832);
INSERT INTO `creature` VALUES (41830, 5706, 0, 1, 4063, 0, 1595.9, 130.349, -62.1777, 1.59303, 300, 0, 0, 480, 0, 0, 2);
INSERT INTO `creature` VALUES (41831, 5701, 0, 1, 4058, 0, 1594.51, 129.267, -62.1777, 1.59302, 300, 0, 0, 919, 0, 0, 0);
INSERT INTO `creature` VALUES (41832, 5707, 0, 1, 4064, 0, 1597.35, 128.684, -62.1777, 1.59389, 300, 0, 0, 970, 0, 0, 0);
DELETE FROM `creature_addon` WHERE `guid` IN (41830, 41831, 41832);
INSERT INTO `creature_addon` VALUES (41830, 41830, 0, 16777472, 0, 4097, 0, 0, NULL);
INSERT INTO `creature_addon` VALUES (41831, 0, 0, 16843008, 0, 4097, 0, 0, NULL);
INSERT INTO `creature_addon` VALUES (41832, 0, 0, 16777472, 0, 4097, 0, 0, NULL);
DELETE FROM `creature_formations` WHERE `leaderguid` = 41830;
INSERT INTO `creature_formations` VALUES
(41830, 41830, 100, 360, 2),
(41830, 41831, 2, 5.50, 2),
(41830, 41832, 2, 0.78, 2);
DELETE FROM `waypoint_data` WHERE `id` = 41830;
INSERT INTO `waypoint_data` VALUES (41830, 1, 1596.21, 161.705, -62.1775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 2, 1599.04, 168.373, -62.1775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 3, 1624.81, 177.137, -62.1775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 4, 1635.19, 183.345, -62.1775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 5, 1644.25, 190.512, -62.182, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 6, 1653.08, 198.578, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 7, 1658.44, 208.939, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 8, 1664.89, 231.188, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 9, 1669.19, 236.104, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 10, 1683.7, 238.711, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 11, 1702.69, 239.171, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 12, 1721.73, 238.3, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 13, 1728.95, 232.596, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 14, 1729.27, 211.525, -62.1788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 15, 1727.06, 203.417, -61.6199, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 16, 1720.51, 188.164, -62.1457, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 17, 1719.23, 185.944, -60.7604, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 18, 1701.35, 159.811, -60.7826, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 19, 1671.79, 130.367, -60.3906, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 20, 1669.36, 128.858, -61.4819, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 21, 1646.95, 113.664, -62.1838, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 22, 1630.37, 108.162, -61.62, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 23, 1616.77, 106.219, -62.1776, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 24, 1605.79, 106.219, -62.1776, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 25, 1599.24, 109.457, -62.1776, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 26, 1595.92, 120.261, -62.1776, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41830, 27, 1595.89, 130.826, -62.1776, 0, 0, 0, 100, 0);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 2 WHERE `entry` = 2265 AND `item` IN (2489,2491,2492,2490,2493,2495,2488,2494);

DELETE FROM `creature` WHERE `guid` = 24728;
INSERT INTO `creature` VALUES (24728, 11833, 1, 1, 11754, 0, -1055.55, -217.179, 159.546, 1.50903, 250, 0, 0, 910, 0, 0, 0);

