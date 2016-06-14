-- Scripts update
UPDATE `creature_template` SET `ScriptName` = 'npc_pit_commander' WHERE `creature_template`.`entry` = 18945;
UPDATE `creature_template` SET `ScriptName` = 'npc_dark_portal_invader' WHERE `creature_template`.`entry` = 19005;
UPDATE `creature_template` SET `ScriptName` = 'npc_dark_portal_invader' WHERE `creature_template`.`entry` = 18944;
UPDATE `creature_template` SET `ScriptName` = 'npc_stormwind_soldier' WHERE `creature_template`.`entry` = 18948;
UPDATE `creature_template` SET `ScriptName` = 'npc_orgrimmar_grunt' WHERE `creature_template`.`entry` = 18950;
UPDATE `creature_template` SET `ScriptName` = 'npc_ironforge_paladin' WHERE `creature_template`.`entry` = 18986;
UPDATE `creature_template` SET `ScriptName` = 'npc_darnassian_archer' WHERE `creature_template`.`entry` = 18965;
UPDATE `creature_template` SET `ScriptName` = 'npc_darkspear_axe_thrower' WHERE `creature_template`.`entry` = 18970;
UPDATE `creature_template` SET `ScriptName` = 'npc_orgrimmar_shaman' WHERE `creature_template`.`entry` = 18972;
UPDATE `creature_template` SET `ScriptName` = 'npc_stormwind_mage' WHERE `creature_template`.`entry` = 18949;
UPDATE `creature_template` SET `ScriptName` = 'npc_undercity_mage' WHERE `creature_template`.`entry` = 18971;
UPDATE `creature_template` SET `ScriptName` = 'npc_melgromm_highmountain' WHERE `creature_template`.`entry` = 18969;
UPDATE `creature_template` SET `ScriptName` = 'npc_justinus_the_harbinger' WHERE `creature_template`.`entry` = 18966;
UPDATE `creature_template` SET `ScriptName` = 'npc_infernal_siegebreaker' WHERE `creature_template`.`entry` = 18946;

-- Fel Soldier's deletion
DELETE FROM `creature` WHERE `creature`.`id` = 18944;
-- Wrath Master's deletion
DELETE FROM `creature` WHERE `creature`.`id` = 19005;
-- Wrath Master speed correction
UPDATE `creature_template` SET `speed` = '1.05' WHERE `creature_template`.`entry` = 19005; 

-- Melgromm Highmountain
DELETE FROM `creature` WHERE `creature`.`id` = 18969;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18969, 530, 1, 0, 1343, -230.412, 1071.51, 54.308, 1.53589, 300, 0, 0, 110000, 50250, 0, 0);

-- Justinus the Harbinger
DELETE FROM `creature` WHERE `creature`.`id` = 18966;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18966, 530, 1, 0, 1516, -269.361, 1071.2, 54.3077, 1.65806, 300, 0, 0, 99000, 47325, 0, 0);

-- Darnassian Archers
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68111;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68112;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68114;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68116;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68117;

DELETE FROM `creature` WHERE `creature`.`id` = 18965;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18965, 530, 1, 0, 29, -269.663, 1086.26, 46.2537, 1.5708, 300, 0, 0, 13000, 100, 0, 0),
(NULL, 18965, 530, 1, 0, 29, -269.932, 1083.3, 48.2155, 1.5708, 300, 0, 0, 13000, 100, 0, 0),
(NULL, 18965, 530, 1, 0, 29, -260.176, 1086.36, 46.2835, 1.5708, 300, 0, 0, 13000, 100, 0, 0),
(NULL, 18965, 530, 1, 0, 29, -260.593, 1083.48, 48.1924, 1.5708, 300, 0, 0, 13000, 100, 0, 0),
(NULL, 18965, 530, 1, 0, 29, -265.322, 1083.37, 48.2152, 1.48597, 300, 0, 0, 13000, 100, 0, 0),
(NULL, 18965, 530, 1, 0, 29, -265.187, 1086.36, 46.23, 1.5708, 300, 0, 0, 13000, 100, 0, 0),
(NULL, 18965, 530, 1, 0, 29, -307.406, 1021.64, 54.2668, 0.146198, 300, 0, 0, 13000, 100, 0, 0);

-- Darkspear Axe Thrower 
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68125;
DELETE FROM `creature` WHERE `creature`.`id` = 18970;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18970, 530, 1, 0, 36, -239.295, 1084.09, 48.0014, 1.36136, 300, 0, 0, 12652, 0, 0, 0),
(NULL, 18970, 530, 1, 0, 36, -238.914, 1087.51, 45.7332, 1.36136, 300, 0, 0, 12652, 0, 0, 0),
(NULL, 18970, 530, 1, 0, 36, -232.08, 1087.71, 45.671, 1.48353, 300, 0, 0, 12652, 0, 0, 0),
(NULL, 18970, 530, 1, 0, 36, -235.6, 1084.24, 47.9451, 1.43117, 300, 0, 0, 12652, 0, 0, 0),
(NULL, 18970, 530, 1, 0, 36, -235.585, 1087.55, 45.7428, 1.43117, 300, 0, 0, 12652, 0, 0, 0),
(NULL, 18970, 530, 1, 0, 36, -232.192, 1084.25, 47.968, 1.48353, 300, 0, 0, 12683, 0, 0, 0);

-- Stormwind Solider
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68011;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68012;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68013;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68014;

UPDATE `creature_template_addon` SET `emote` = '333' WHERE `creature_template_addon`.`entry` = 18948; 

DELETE FROM `creature` WHERE `creature`.`id` = 18948;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18948, 530, 1, 0, 653, -266.078, 1093.61, 41.6783, 1.50098, 300, 0, 0, 9900, 100, 0, 0),
(NULL, 18948, 530, 1, 0, 653, -271.419, 1093.38, 42.0004, 1.37881, 300, 0, 0, 9900, 100, 0, 0),
(NULL, 18948, 530, 1, 0, 653, -257.699, 1093.79, 41.6667, 1.67552, 300, 0, 0, 9900, 100, 0, 0),
(NULL, 18948, 530, 1, 0, 653, -261.533, 1093.65, 41.6667, 1.58825, 300, 0, 0, 9900, 100, 0, 0),
(NULL, 18948, 530, 1, 0, 653, -321.577, 1009.27, 54.2265, 1.18111, 300, 0, 0, 9900, 100, 0, 0),
(NULL, 18948, 530, 1, 0, 653, -253.58, 1093.68, 41.6667, 1.46818, 300, 0, 0, 9900, 100, 0, 0);

-- Ironforge Paladin
UPDATE `creature_template_addon` SET `emote` = '333' WHERE `creature_template_addon`.`entry` = 18986;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68263;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68264;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68265;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68266;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68267; 
DELETE FROM `creature` WHERE `creature`.`id` = 18986;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18986, 530, 1, 0, 1342, -271.966, 1097.95, 41.924, 1.60779, 300, 0, 0, 13000, 29330, 0, 0),
(NULL, 18986, 530, 1, 0, 1342, -263.989, 1098.2, 41.6714, 1.53589, 300, 0, 0, 13000, 29330, 0, 0),
(NULL, 18986, 530, 1, 0, 1342, -258.965, 1098.33, 41.6668, 1.64061, 300, 0, 0, 13000, 29330, 0, 0),
(NULL, 18986, 530, 1, 0, 1342, -267.882, 1098.1, 41.733, 1.60779, 300, 0, 0, 13000, 29330, 0, 0),
(NULL, 18986, 530, 1, 0, 1342, -314.189, 1020.64, 54.2497, 0.146198, 300, 0, 0, 13000, 29330, 0, 0),
(NULL, 18986, 530, 1, 0, 1342, -319.582, 1014.12, 54.2262, 1.18111, 300, 5, 0, 13000, 29330, 0, 1),
(NULL, 18986, 530, 1, 0, 1342, -254.634, 1098.42, 41.6668, 1.64061, 300, 0, 0, 13000, 29330, 0, 0);

-- Orgrimmar Grunt
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68017;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68018;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68019;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68020;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68023;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68024;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 68026;
DELETE FROM `creature` WHERE `creature`.`id` = 18950;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18950, 530, 1, 0, 133, -236.118, 1094.29, 41.6667, 1.51844, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -245.26, 1094.14, 41.6667, 1.37881, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -233.701, 1098.25, 41.6666, 1.41372, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -246.106, 1097.79, 41.6667, 1.41372, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -237.952, 1098.13, 41.6667, 1.5708, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -229.492, 1098.26, 41.6667, 1.41372, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -240.848, 1094.25, 41.6667, 1.44862, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -231.356, 1094.29, 41.6667, 1.58825, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -242.308, 1098.02, 41.6667, 1.48353, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -180.343, 1018.59, 54.2253, 2.42443, 300, 0, 0, 12000, 5280, 0, 0),
(NULL, 18950, 530, 1, 0, 133, -249.316, 1094.13, 41.6667, 1.64061, 300, 0, 0, 12000, 5280, 0, 0);

-- Orgrimmar Shaman
DELETE FROM `creature` WHERE `creature`.`id` = 18972;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 18972, 530, 1, 0, 0, -242.171, 1111.31, 41.6667, 1.57437, 300, 0, 0, 7900, 29330, 0, 0),
(NULL, 18972, 530, 1, 0, 0, -244.131, 1111.3, 41.6667, 1.57437, 300, 0, 0, 7900, 29330, 0, 0),
(NULL, 18972, 530, 1, 0, 0, -244.125, 1109.73, 41.6667, 1.57437, 300, 0, 0, 7900, 29330, 0, 0),
(NULL, 18972, 530, 1, 0, 0, -242.179, 1109.73, 41.6667, 1.57437, 300, 0, 0, 7900, 29330, 0, 0),
(NULL, 18972, 530, 1, 0, 0, -242.174, 1108.35, 41.6667, 1.57437, 300, 0, 0, 7900, 29330, 0, 0),
(NULL, 18972, 530, 1, 0, 0, -244.169, 1108.34, 41.6667, 1.57437, 300, 0, 0, 7900, 29330, 0, 0),
(NULL, 18972, 530, 1, 0, 0, -243.29, 1113.25, 41.6667, 1.57437, 300, 0, 0, 7900, 29330, 0, 0);
-- Correct Unit Flag
UPDATE `creature_template` SET `unit_flags` = '557312' WHERE `creature_template`.`entry` = 18972; 

-- Waypoints
DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98250;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98250, 1, -224.99, 1505.72, 21.0752, 0, 0, 0, 100, 0),
(98250, 2, -233.099, 1469.78, 16.5077, 0, 0, 0, 100, 0),
(98250, 3, -241.714, 1434.06, 14.1237, 0, 0, 0, 100, 0),
(98250, 4, -246.07, 1409.46, 12.4779, 0, 0, 0, 100, 0),
(98250, 5, -243.211, 1346.01, 12.3213, 0, 0, 0, 100, 0),
(98250, 6, -239.57, 1304.84, 18.9974, 0, 0, 0, 100, 0),
(98250, 7, -232.601, 1256.69, 27.4233, 0, 0, 0, 100, 0),
(98250, 8, -237.506, 1221.13, 33.5956, 0, 0, 0, 100, 0),
(98250, 9, -236.284, 1190.55, 42.0998, 0, 0, 0, 100, 0),
(98250, 10, -229.541, 1147.88, 41.6500, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98251;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98251, 1, -217.011, 1511.61, 21.6546, 0, 0, 0, 100, 0),
(98251, 2, -225.415, 1477.44, 17.7857, 0, 0, 0, 100, 0),
(98251, 3, -234.207, 1438.76, 14.165,  0, 0, 0, 100, 0),
(98251, 4, -240.038, 1417.18, 13.145, 0, 0, 0, 100, 0),
(98251, 5, -237.052, 1352.44, 11.549, 0, 0, 0, 100, 0),
(98251, 6, -235.177, 1311.52, 18.3116, 0, 0, 0, 100, 0),
(98251, 7, -225.64, 1264.91, 26.6153, 0, 0, 0, 100, 0),
(98251, 8, -229.735, 1228.86, 32.1081, 0, 0, 0, 100, 0),
(98251, 9, -230.273, 1194.63, 42.0642, 0, 0, 0, 100, 0),
(98251, 10, -206.253, 1147.08, 41.5728, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98252;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98252, 1, -237.069, 1509.86, 21.9464, 0, 0, 0, 100, 0),
(98252, 2, -245.181, 1472.65, 16.6989, 0, 0, 0, 100, 0),
(98252, 3, -253.786, 1437.32, 14.5129, 0, 0, 0, 100, 0),
(98252, 4, -257.539, 1412.4, 12.2531, 0, 0, 0, 100, 0),
(98252, 5, -255.893, 1348.47, 12.12, 0, 0, 0, 100, 0),
(98252, 6, -250.351, 1303.41, 19.0344, 0, 0, 0, 100, 0),
(98252, 7, -245.552, 1256.08, 27.1643, 0, 0, 0, 100, 0),
(98252, 8, -250.639, 1223.68, 33.4376, 0, 0, 0, 100, 0),
(98252, 9, -257.768, 1186.54, 41.991, 0, 0, 0, 100, 0),
(98252, 10, -263.407, 1170.32, 41.6372, 0, 0, 0, 100, 0),
(98252, 11, -257.890, 1148.31, 41.6561, 0, 0, 0, 100, 0);


DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98253;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98253, 1, -241.549, 1519.34, 23.1541, 0, 0, 0, 100, 0),
(98253, 2, -247.066, 1488.58, 19.7701, 0, 0, 0, 100, 0),
(98253, 3, -256.323, 1448.82, 15.5856, 0, 0, 0, 100, 0),
(98253, 4, -262.649, 1422.58, 12.8675, 0, 0, 0, 100, 0),
(98253, 5, -262.608, 1355.51, 11.4148, 0, 0, 0, 100, 0),
(98253, 6, -255.724, 1312.74, 17.7639, 0, 0, 0, 100, 0),
(98253, 7, -251.932, 1266, 25.459, 0, 0, 0, 100, 0),
(98253, 8, -254.577, 1233.84, 31.5337, 0, 0, 0, 100, 0),
(98253, 9, -261.251, 1187.7, 41.9877, 0, 0, 0, 100, 0),
(98253, 10, -273.688, 1167.97, 41.674, 0, 0, 0, 100, 0),
(98253, 11, -282.439, 1148.48, 41.5774, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98254; -- WRATH MASTER
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98254, 1, -232.234, 1499.89, 20.506, 0, 0, 0, 100, 0),
(98254, 2, -240.331, 1463.14, 15.5619, 0, 0, 0, 100, 0),
(98254, 3, -249.256, 1427.5, 13.6716, 0, 0, 0, 100, 0),
(98254, 4, -251.864, 1401.77, 11.8626, 0, 0, 0, 100, 0),
(98254, 5, -248.64, 1338.86, 13.3091, 0, 0, 0, 100, 0),
(98254, 6, -243.248, 1296.31, 20.1426, 0, 0, 0, 100, 0),
(98254, 7, -238.194, 1247.3, 28.7492, 0, 0, 0, 100, 0),
(98254, 8, -243.649, 1213.78, 35.8842, 0, 0, 0, 100, 0),
(98254, 9, -246.953, 1194.95, 42.8209, 0, 0, 0, 100, 0),
(98254, 10, -249.174, 1155.63, 41.6368, 0, 0, 0, 100, 0),
(98254, 11, -247.743, 1142.64, 41.6119, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98255;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98255, 1, -225.479, 1467.13, 16.6995, 0, 0, 0, 100, 0),
(98255, 2, -237.805, 1424.85, 13.8334, 0, 0, 0, 100, 0),
(98255, 3, -240.678, 1387.87, 11.2254, 0, 0, 0, 100, 0),
(98255, 4, -237.999, 1342.45, 12.8601, 0, 0, 0, 100, 0),
(98255, 5, -232.924, 1297.05, 20.5927, 0, 0, 0, 100, 0),
(98255, 6, -228.677, 1263.84, 26.5186, 0, 0, 0, 100, 0),
(98255, 7, -229.369, 1221.84, 33.6855, 0, 0, 0, 100, 0),
(98255, 8, -229.954, 1196.97, 41.8498, 0, 0, 0, 100, 0),
(98255, 9, -225.079, 1174.82, 41.6683, 0, 0, 0, 100, 0),
(98255, 10, -216.886, 1158.78, 41.588, 0, 0, 0, 100, 0),
(98255, 11, -188.317, 1139.68, 41.5866, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98256;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98256, 1, -233.868, 1469.59, 16.4544, 0, 0, 0, 100, 0),
(98256, 2, -246.152, 1425.96, 13.6408, 0, 0, 0, 100, 0),
(98256, 3,  -248.504, 1388.13, 11.2545, 0, 0, 0, 100, 0),
(98256, 4,  -246.512, 1341.98, 12.8924, 0, 0, 0, 100, 0),
(98256, 5, -241.854, 1296.03, 20.2207, 0, 0, 0, 100, 0),
(98256, 6, -236.384, 1263.87, 26.0613, 0, 0, 0, 100, 0),
(98256, 7, -239.646, 1222.08, 33.4128, 0, 0, 0, 100, 0),
(98256, 8, -236.113, 1196.43, 41.581, 0, 0, 0, 100, 0),
(98256, 9, -231.653, 1172.39, 41.5739, 0, 0, 0, 100, 0),
(98256, 10, -216.886, 1158.78, 41.588, 0, 0, 0, 100, 0),
(98256, 11, -213.682, 1139.87, 41.594, 0, 0, 0, 100, 0);


DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98257;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98257, 1, -241.713, 1471.89, 16.5222, 0, 0, 0, 100, 0),
(98257, 2, -253.438, 1426.93, 13.6534, 0, 0, 0, 100, 0),
(98257, 3, -256.557, 1388.39, 11.0582, 0, 0, 0, 100, 0),
(98257, 4, -253.739, 1341.58, 12.9367, 0, 0, 0, 100, 0),
(98257, 5, -248.69, 1295.25, 20.3101, 0, 0, 0, 100, 0),
(98257, 6, -244.441, 1263.9, 25.8385, 0, 0, 0, 100, 0),
(98257, 7, -248.627, 1222.29, 33.6666, 0, 0, 0, 100, 0),
(98257, 8, -256.585, 1196.54, 41.364, 0, 0, 0, 100, 0),
(98257, 9, -260.729, 1172.18, 41.6556, 0, 0, 0, 100, 0),
(98257, 10, -244.518, 1159.97, 41.5897, 0, 0, 0, 100, 0),
(98257, 11, -238.322, 1140.29, 41.6657, 0, 0, 0, 100, 0);


DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98258;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98258, 1, -249.444, 1474.16, 17.4824, 0, 0, 0, 100, 0),
(98258, 2, -260.842, 1427.92, 13.6294, 0, 0, 0, 100, 0),
(98258, 3, -264.61, 1388.65, 10.8883, 0, 0, 0, 100, 0),
(98258, 4, -261.553, 1341.15, 13.0269, 0, 0, 0, 100, 0),
(98258, 5, -255.074, 1294.52, 20.8318, 0, 0, 0, 100, 0),
(98258, 6, -253.079, 1263.93, 25.8012, 0, 0, 0, 100, 0),
(98258, 7, -257.382, 1222.5, 34.059, 0, 0, 0, 100, 0),
(98258, 8, -260.889, 1196.64, 41.339, 0, 0, 0, 100, 0),
(98258, 9, -268.282, 1169.91, 41.6606, 0, 0, 0, 100, 0),
(98258, 10, -265.105, 1140.24, 41.6677, 0, 0, 0, 100, 0);


DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98259;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98259, 1, -249.444, 1474.16, 17.4824, 0, 0, 0, 100, 0),
(98259, 2, -260.842, 1427.92, 13.6294, 0, 0, 0, 100, 0),
(98259, 3, -264.61, 1388.65, 10.8883, 0, 0, 0, 100, 0),
(98259, 4, -261.553, 1341.15, 13.0269, 0, 0, 0, 100, 0),
(98259, 5, -255.074, 1294.52, 20.8318, 0, 0, 0, 100, 0),
(98259, 6, -253.079, 1263.93, 25.8012, 0, 0, 0, 100, 0),
(98259, 7, -257.382, 1222.5, 34.059, 0, 0, 0, 100, 0),
(98259, 8, -260.889, 1196.64, 41.339, 0, 0, 0, 100, 0),
(98259, 9, -268.282, 1169.91, 41.6606, 0, 0, 0, 100, 0),
(98259, 10, -282.494, 1148.49, 41.5774, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98260;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98260, 1, -241.713, 1471.89, 16.5222, 0, 0, 0, 100, 0),
(98260, 2, -253.438, 1426.93, 13.6534, 0, 0, 0, 100, 0),
(98260, 3, -256.557, 1388.39, 11.0582, 0, 0, 0, 100, 0),
(98260, 4, -253.739, 1341.58, 12.9367, 0, 0, 0, 100, 0),
(98260, 5, -248.69, 1295.25, 20.3101, 0, 0, 0, 100, 0),
(98260, 6, -244.441, 1263.9, 25.8385, 0, 0, 0, 100, 0),
(98260, 7, -248.627, 1222.29, 33.6666, 0, 0, 0, 100, 0),
(98260, 8, -256.585, 1196.54, 41.364, 0, 0, 0, 100, 0),
(98260, 9, -260.729, 1172.18, 41.6556, 0, 0, 0, 100, 0),
(98260, 10, -244.518, 1159.97, 41.5897, 0, 0, 0, 100, 0),
(98260, 11, -257.891, 1148.32, 41.6561, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98261;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98261, 1, -233.868, 1469.59, 16.4544, 0, 0, 0, 100, 0),
(98261, 2, -246.152, 1425.96, 13.6408, 0, 0, 0, 100, 0),
(98261, 3, -248.504, 1388.13, 11.2545, 0, 0, 0, 100, 0),
(98261, 4, -246.512, 1341.98, 12.8924, 0, 0, 0, 100, 0),
(98261, 5, -241.854, 1296.03, 20.2207, 0, 0, 0, 100, 0),
(98261, 6, -236.384, 1263.87, 26.0613, 0, 0, 0, 100, 0),
(98261, 7, -239.646, 1222.08, 33.4128, 0, 0, 0, 100, 0),
(98261, 8, -236.113, 1196.43, 41.581, 0, 0, 0, 100, 0),
(98261, 9, -231.653, 1172.39, 41.5739, 0, 0, 0, 100, 0),
(98261, 10, -229.541, 1147.88, 41.65, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 98262;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(98262, 1, -225.479, 1467.13, 16.6995, 0, 0, 0, 100, 0),
(98262, 2, -237.805, 1424.85, 13.8334, 0, 0, 0, 100, 0),
(98262, 3, -240.678, 1387.87, 11.2254, 0, 0, 0, 100, 0),
(98262, 4, -237.999, 1342.45, 12.8601, 0, 0, 0, 100, 0),
(98262, 5, -232.924, 1297.05, 20.5927, 0, 0, 0, 100, 0),
(98262, 6, -228.677, 1263.84, 26.5186, 0, 0, 0, 100, 0),
(98262, 7, -229.369, 1221.84, 33.6855, 0, 0, 0, 100, 0),
(98262, 8, -229.954, 1196.97, 41.8498, 0, 0, 0, 100, 0),
(98262, 9, -225.079, 1174.82, 41.6683, 0, 0, 0, 100, 0),
(98262, 10, -216.886, 1158.78, 41.588, 0, 0, 0, 100, 0),
(98262, 11, -206.253, 1147.09, 41.5728, 0, 0, 0, 100, 0);

-- TEMP
-- Target & Casters for Infernal Rain
DELETE FROM `creature_template` WHERE `creature_template`.`entry` = 30001; -- Caster 1 Infernal
DELETE FROM `creature_template` WHERE `creature_template`.`entry` = 30002; -- Caster 2 Infernal
DELETE FROM `creature_template` WHERE `creature_template`.`entry` = 30003; -- Target 1 Infernal
DELETE FROM `creature_template` WHERE `creature_template`.`entry` = 30004; -- Target 2 Infernal
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `KillCredit`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `IconName`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `xp_modifier`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(30001, 0, NULL, 16480, 0, 21072, 0, 'L4G - Infernal Caster Right', '', '', 1, 1, 1, 1, 0, 0, 0, 1, 35, 35, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 4, 0, 1, 0, 0, 128, ''),
(30002, 0, NULL, 16480, 0, 21072, 0, 'L4G - Infernal Caster Left', '', '', 1, 1, 1, 1, 0, 0, 0, 1, 35, 35, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 4, 0, 1, 0, 0, 128, ''),
(30003, 0, NULL, 16480, 0, 21072, 0, 'L4G - Infernal Target Right', '', '', 1, 1, 1, 1, 0, 0, 0, 1, 35, 35, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 128, ''),
(30004, 0, NULL, 16480, 0, 21072, 0, 'L4G - Infernal Target Left', '', '', 1, 1, 1, 1, 0, 0, 0, 1, 35, 35, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 128, '');

DELETE FROM `creature` WHERE `creature`.`id` = 30001;
DELETE FROM `creature` WHERE `creature`.`id` = 30002;
DELETE FROM `creature` WHERE `creature`.`id` = 30003;
DELETE FROM `creature` WHERE `creature`.`id` = 30004;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 30001, 530, 1, 0, 0, -292.791, 1143.22, 91.9368, 2.3911, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30002, 530, 1, 0, 0, -266.624, 1154.46, 79.4764, 2.44346, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30003, 530, 1, 0, 0, -266.312, 1099.08, 41.7916, 1.73303, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30004, 530, 1, 0, 0, -234.448, 1097.6, 41.7916, 2.89898, 300, 0, 0, 1, 0, 0, 0);

-- Formations
DELETE FROM `creature_template` WHERE `creature_template`.`entry` = 30005; -- Final Position Trigger
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `KillCredit`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `IconName`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `xp_modifier`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(30005, 0, NULL, 16480, 0, 21072, 0, 'L4G - Final Position Trigger', '', '', 1, 1, 1, 1, 0, 0, 0, 1, 35, 35, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 128, '');

DELETE FROM `creature` WHERE `creature`.`id` = 30005;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(NULL, 30005, 530, 1, 0, 0, -282.494, 1148.49, 41.5774, 4.70902, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -265.105, 1140.24, 41.6677, 4.76002, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -257.891, 1148.32, 41.6561, 4.71952, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -238.322, 1140.29, 41.6657, 4.67755, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -229.541, 1147.88, 41.65, 4.67755, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -213.682, 1139.87, 41.594, 4.67755, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -206.253, 1147.09, 41.5728, 4.67755, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -188.317, 1139.68, 41.5866, 4.72781, 300, 0, 0, 1, 0, 0, 0),
(NULL, 30005, 530, 1, 0, 0, -247.794, 1143.10, 41.6128, 4.72781, 300, 0, 0, 1, 0, 0, 0);
