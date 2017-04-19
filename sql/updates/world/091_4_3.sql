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

