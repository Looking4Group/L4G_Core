
UPDATE `creature_template_addon` SET `auras` = '33650 0' WHERE `entry` = 17261;

DELETE FROM `waypoint_data` WHERE `id` = 99269;
INSERT INTO `waypoint_data` VALUES (99269, 1, -3909.09, 1599.06, 82.2905, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 2, -3856.33, 1659.5, 85.4238, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 3, -3839.19, 1713.32, 97.2489, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 4, -3765.35, 1781.95, 93.3816, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 5, -3717.94, 1846.46, 88.1826, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 6, -3693.34, 1884.69, 83.0234, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 7, -3684.59, 1885.59, 89.2877, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 8, -3594.32, 2009.48, 78.1582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 9, -3531.75, 2038.94, 80.5568, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 10, -3556.73, 2111.01, 85.5594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99269, 11, -3650.54, 2224.42, 94.4209, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES
('99269', '12', '-3556.73', '2111.01', '85.5594', 0, 0, 0, 0, 0),
('99269', '13', '-3531.75', '2038.94', '80.5568', 0, 0, 0, 0, 0),
('99269', '14', '-3594.32', '2009.48', '78.1582', 0, 0, 0, 0, 0),
('99269', '15', '-3684.59', '1885.59', '89.2877', 0, 0, 0, 0, 0),
('99269', '16', '-3693.34', '1884.69', '83.0234', 0, 0, 0, 0, 0),
('99269', '17', '-3717.94', '1846.46', '88.1826', 0, 0, 0, 0, 0),
('99269', '18', '-3765.35', '1781.95', '93.3816', 0, 0, 0, 0, 0),
('99269', '19', '-3839.19', '1713.32', '97.2489', 0, 0, 0, 0, 0),
('99269', '20', '-3856.33', '1659.5', '85.4238', 0, 0, 0, 0, 0);

-- http://www.wowhead.com/item=30850/freshly-drawn-blood
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 50 WHERE `entry` = 18859 AND `item` = 30850;

DELETE FROM `creature_template_addon` WHERE `entry` IN (18472,20690);
INSERT INTO `creature_template_addon` VALUES
(18472, 0, 0, 0, 0, 0, 0, 0, '18950 0 18950 1'),
(20690, 0, 0, 0, 0, 0, 0, 0, '18950 0 18950 1');

-- Elementalist Yal'hah
-- Like Mathar G'ochar this guy had random waittimes for no reason and he also had some incorrect points.
-- Pathing for  Entry: 18234 'UDB FORMAT' 
SET @GUID := 65504;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` IN (@GUID,1426);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action_chance`) VALUES
(65504,1,-1359.951,7230.642,33.16471, 0, 0, 100),
(65504,2,-1377.451,7232.392,30.66471, 0, 0, 100),
(65504,3,-1389.036,7236.409,27.42647, 0, 0, 100),
(65504,4,-1391.793,7241.86,26.52675, 0, 0, 100),
(65504,5,-1396.95,7257.921,25.92204, 0, 0, 100),
(65504,6,-1397.287,7265.475,25.63307, 0, 0, 100),
(65504,7,-1401.94,7268.414,25.83983, 0, 0, 100),
(65504,8,-1398.011,7264.283,25.80521, 0, 0, 100),
(65504,9,-1398.269,7258.208,25.68449, 0, 0, 100),
(65504,10,-1391.307,7237.914,26.65525, 0, 0, 100),
(65504,11,-1370.948,7231.767,32.34181, 0, 0, 100),
(65504,12,-1366.966,7230.84,33.15897, 0, 0, 100),
(65504,13,-1359.524,7229.641,33.27132, 0, 0, 100),
(65504,14,-1344.06,7208.987,33.42862, 0, 0, 100),
(65504,15,-1322.06,7214.737,33.67862, 0, 0, 100),
(65504,16,-1318.594,7215.798,33.90633, 0, 0, 100),
(65504,17,-1319.344,7229.548,33.40633, 0, 0, 100),
(65504,18,-1320.066,7243.84,32.93043, 0, 0, 100),
(65504,19,-1333.604,7245.339,33.40546, 0, 0, 100),
(65504,20,-1343.926,7246.193,33.07669, 0, 0, 100);

-- This is for the static creatures in the Scourge Camp in Hyjal Summit

DELETE FROM `creature` WHERE `id` IN (17899,17898,17895);
DELETE FROM `creature` WHERE `guid` BETWEEN 190600 AND 190601;
DELETE FROM `creature` WHERE `guid` BETWEEN 190700 AND 190701;
INSERT INTO `creature` VALUES (190700, 17919, 534, 1, 0, 0, 4989.3134, -1751.1210, 1331.4525, 1.7154, 300, 0, 0, 41916, 0, 0, 0);
INSERT INTO `creature` VALUES (190701, 17919, 534, 1, 0, 0, 4976.4956, -1752.9862, 1330.7408, 1.7154, 300, 0, 0, 41916, 0, 0, 0);

-- Missing spawns
-- Shadowy Necromancer
DELETE FROM creature WHERE guid BETWEEN 151177 AND 151182;
INSERT INTO creature (guid, id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(151177,17899,534,1,0,0,5059.646,-1498.705,1339.723,2.443461,7200,0,0,120000,31550,0,0),
(151178,17899,534,1,0,0,5065.653,-1489.542,1339.872,2.687807,7200,0,0,120000,31550,0,0),
(151179,17899,534,1,0,0,5133.389,-1507.289,1343.748,0.5934119,7200,0,0,120000,31550,0,0),
(151180,17899,534,1,0,0,5128.913,-1498.062,1343.55,0.296706,7200,0,0,120000,31550,0,0),
(151181,17899,534,1,0,0,5080.594,-1382.097,1350.73,2.426008,7200,0,0,120000,31550,0,0),
(151182,17899,534,1,0,0,5085.502,-1378.091,1352.692,1.745329,7200,0,0,120000,31550,0,0);

-- Abomination
DELETE FROM creature WHERE guid BETWEEN 151183 AND 151190;
INSERT INTO creature (guid, id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(151183,17898,534,1,0,0,4982.554,-1480.297,1334.175,4.956735,7200,0,0,179525,0,0,0),
(151184,17898,534,1,0,0,4991.231,-1499.123,1328.669,2.199115,7200,0,0,179525,0,0,0),
(151185,17898,534,1,0,0,4949.747,-1495.203,1329.991,5.113815,7200,0,0,179525,0,0,0),
(151186,17898,534,1,0,0,4958.057,-1512.072,1328.542,2.268928,7200,0,0,179525,0,0,0),
(151187,17898,534,1,0,0,5226.073,-1497.29,1357.369,2.635447,7200,0,0,179525,0,0,0),
(151188,17898,534,1,0,0,5213.393,-1514.153,1356.394,2.321288,7200,0,0,179525,0,0,0),
(151189,17898,534,1,0,0,5174.264,-1376.852,1362.488,4.18879,7200,0,0,179525,0,0,0),
(151190,17898,534,1,0,0,5151.006,-1363.474,1362.312,4.433136,7200,0,0,179525,0,0,0);

-- Ghoul
DELETE FROM creature WHERE guid BETWEEN 151191 AND 151206;
INSERT INTO creature (guid, id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
-- Patrol 1
(151191,17895,534,1,0,0,5040.115,-1467.419,1334.116,2.156081,7200,0,0,139720,0,0,2),
(151192,17895,534,1,0,0,5040.881,-1471.807,1334.044,2.01692,7200,0,0,139720,0,0,0),
(151193,17895,534,1,0,0,5047.158,-1468.655,1335.214,2.920739,7200,0,0,139720,0,0,0),
(151194,17895,534,1,0,0,5045.542,-1462.257,1335.28,3.812386,7200,0,0,139720,0,0,0),
(151195,17895,534,1,0,0,5037.341,-1464.374,1334.078,0.7141473,7200,0,0,139720,0,0,0),
-- Patrol 2
(151196,17895,534,1,0,0,5161.598,-1474.63,1349.208,0.144966,7200,0,0,139720,0,0,2),
(151197,17895,534,1,0,0,5166.927,-1476.521,1350.079,0.7519124,7200,0,0,139720,0,0,0),
(151198,17895,534,1,0,0,5162.632,-1480.041,1348.891,1.268422,7200,0,0,139720,0,0,0),
(151199,17895,534,1,0,0,5157.37,-1475.699,1348.33,0.2324913,7200,0,0,139720,0,0,0),
(151200,17895,534,1,0,0,5161.598,-1469.751,1349.646,5.292036,7200,0,0,139720,0,0,0),
-- Random Movement Pack 1
(151201,17895,534,1,0,0,5102.5,-1419.945,1344.191,5.977761,7200,3,0,139720,0,0,1),
(151202,17895,534,1,0,0,5100.732,-1402.343,1347.152,5.423813,7200,3,0,139720,0,0,1),
(151203,17895,534,1,0,0,5097.404,-1412.765,1345.183,2.697808,7200,3,0,139720,0,0,1),
-- Random Movement Pack 2
(151204,17895,534,1,0,0,5041.802,-1403.05,1340.821,3.996804,7200,3,0,139720,0,0,1),
(151205,17895,534,1,0,0,5034.968,-1411.679,1338.862,0.4670456,7200,3,0,139720,0,0,1),
(151206,17895,534,1,0,0,5023.414,-1408.8,1340.691,3.954692,7200,3,0,139720,0,0,1);

-- Ghoul
DELETE FROM creature_template_addon WHERE entry = 17895;
INSERT INTO creature_template_addon VALUES (17895,0,0,0,0,4097,0,0,'8278 0');

-- Linking
-- All groups always assist and always respawn together
DELETE FROM creature_formations WHERE leaderGUID BETWEEN 151177 AND 151204;
INSERT INTO creature_formations (leaderGUID, memberGUID, dist, angle, groupAI) VALUES 
-- Shadowy Necromancer Pair 1
(151177,151177,0,0,2),
(151177,151178,0,0,2),
-- Shadowy Necromancer Pair 2
(151179,151179,0,0,2),
(151179,151180,0,0,2),
-- Shadowy Necromancer Pair 2
(151181,151181,0,0,2),
(151181,151182,0,0,2),
-- Abomination Pair 1
(151183,151183,0,0,2),
(151183,151184,0,0,2),
-- Abomination Pair 2
(151185,151185,0,0,2),
(151185,151186,0,0,2),
-- Abomination Pair 3
(151187,151187,0,0,2),
(151187,151188,0,0,2),
-- Abomination Pair 4
(151189,151189,0,0,2),
(151189,151190,0,0,2),
-- Ghoul Patrol 1
(151191,151191,3,0,2),
(151191,151192,3,5.50,2),
(151191,151193,3,0.78,2),
(151191,151194,3,2.36,2),
(151191,151195,3,3.93,2),
-- Ghoul Patrol 2
(151196,151196,3,0,2),
(151196,151197,3,2.36,2),
(151196,151198,3,0.78,2),
(151196,151199,3,5.50,2),
(151196,151200,3,3.93,2),
-- Ghoul Pack 1
(151201,151201,0,0,2),
(151201,151202,0,0,2),
(151201,151203,0,0,2),
-- Ghoul Pack 2
(151204,151204,0,0,2),
(151204,151205,0,0,2),
(151204,151206,0,0,2);

-- Movement
DELETE FROM `creature_addon` WHERE `guid` IN (151196,151191);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES 
(151196,151196,0,0,0,4097,0,0,NULL),
(151191,151196,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` IN (151196,151191);
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`action`,`wpguid`) VALUES
-- Patrol Movement 1 (151196)
(151196,1,5177.061,-1472.387,1352.352,0,0,0),
(151196,2,5196.295,-1471.192,1355.553,0,0,0),
(151196,3,5199.827,-1500.772,1352.664,0,0,0),
(151196,4,5213.694,-1495.623,1354.766,0,0,0),
(151196,5,5217.239,-1475.281,1356.733,0,0,0),
(151196,6,5197.961,-1441.216,1357.113,0,0,0),
(151196,7,5181.914,-1413.979,1357.858,0,0,0),
(151196,8,5158.718,-1385.877,1360.025,0,0,0),
(151196,9,5147.666,-1380.736,1359.432,0,0,0),
(151196,10,5173.433,-1410.497,1358.454,0,0,0),
(151196,11,5174.288,-1421.772,1356.15,0,0,0),
(151196,12,5136.555,-1427.744,1349.445,0,0,0),
(151196,13,5138.226,-1439.814,1350.016,0,0,0),
(151196,14,5178.257,-1430.198,1355.973,0,0,0),
(151196,15,5196.151,-1441.762,1357.172,0,0,0),
(151196,16,5197.18,-1457.359,1356.371,0,0,0),
(151196,17,5175.5,-1467.672,1352.416,0,0,0),
(151196,18,5158.646,-1476.287,1348.624,0,0,0),

-- Patrol Movement 2 (151191)
(151191,1,5042.798,-1421.651,1338.593,0,0,0),
(151191,2,5060.235,-1406.821,1343.302,0,0,0),
(151191,3,5081.393,-1389.004,1349.981,0,0,0),
(151191,4,5064.051,-1406.118,1344.382,0,0,0),
(151191,5,5045.213,-1424.599,1338.668,0,0,0),
(151191,6,5041.382,-1445.845,1337.136,0,0,0),
(151191,7,5059.28,-1453.436,1338.473,0,0,0),
(151191,8,5088.196,-1445.408,1341.515,0,0,0),
(151191,9,5109.869,-1461.847,1343.585,0,0,0),
(151191,10,5132.516,-1473.779,1346.901,0,0,0),
(151191,11,5145.405,-1489.544,1346.683,0,0,0),
(151191,12,5125.458,-1483.826,1345.05,0,0,0),
(151191,13,5100.58,-1475.076,1342.765,0,0,0),
(151191,14,5077.241,-1472.962,1341.856,0,0,0),
(151191,15,5055.857,-1481.453,1336.507,0,0,0),
(151191,16,5040.884,-1495.718,1334.07,0,0,0),
(151191,17,5012.168,-1481.613,1330.496,0,0,0),
(151191,18,5020.881,-1464.904,1333.158,0,0,0),
(151191,19,5027.937,-1449.432,1335.135,0,0,0);

-- General Cleanup 

DELETE FROM `gameobject` WHERE `id` = 181959;
INSERT INTO `gameobject` VALUES (27220, 181959, 530, 1, 8088.47, -7545.81, 151.991, 1.8326, 0, 0, 0.793353, 0.608761, 122, 100, 1);
INSERT INTO `gameobject` VALUES (27221, 181959, 530, 1, 8086.87, -7538.78, 150.854, -2.00713, 0, 0, 0.843391, -0.5373, 122, 100, 1);
DELETE FROM `creature` WHERE `guid` IN (192366,192602,192623,192635,192655,192667,45032,44828,44758,44702,44571);
INSERT INTO `creature` VALUES (44571, 1548, 0, 1, 9020, 0, 1685.31, 551.94, 33.8957, 4.73607, 300, 10, 0, 138, 0, 0, 1);
INSERT INTO `creature` VALUES (44702, 1513, 0, 1, 9535, 0, 2043.27, 1477.44, 67.522, 0.802797, 300, 5, 0, 71, 0, 0, 1);
INSERT INTO `creature` VALUES (44758, 1540, 0, 1, 2481, 0, 3052.12, -565.528, 126.397, 2.72271, 300, 0, 0, 198, 0, 0, 0);
INSERT INTO `creature` VALUES (44828, 1555, 0, 1, 368, 0, 2353.68, -848.584, 71.915, 0.18287, 300, 10, 0, 176, 0, 0, 1);
INSERT INTO `creature` VALUES (45032, 1530, 0, 1, 1196, 0, 3043.34, 672.834, 81.047, 2.41767, 300, 3, 0, 198, 0, 0, 1);
DELETE FROM `creature` WHERE `guid` IN (26901,194893);
INSERT INTO `creature` VALUES (26901, 15350, 1, 1, 15387, 1, -1385.16, -91.2934, 159.055, 3.12414, 300, 0, 0, 126000, 0, 0, 0);
DELETE FROM `gameobject` WHERE `guid` BETWEEN 2881461 AND 3021673;

-- http://db.hellfire-tbc.com/?spell=14195 add Shiv to Seal Fate
UPDATE `spell_proc_event` SET `Spellfamilymask` = 27388806408 WHERE `entry` IN (14186, 14190, 14193, 14194, 14195); -- 26851935496

-- someone made mistake and made for him 567 max damage...too much for 30 lvl mob. I took data from silvermoon db
-- http://www.wowhead.com/npc=3414
UPDATE `creature_template` SET `mindmg`='42', `maxdmg`='56' WHERE (`entry`='3414');

-- http://www.wowwiki.com/Quest:Unfinished_Gordok_Business
DELETE FROM `gameobject` WHERE `guid` = 195036;
INSERT INTO `gameobject` VALUES (195036, 179545, 429, 1, 116.135, 638.836, -48.467, -0.785397, 0, 0, 0, 0, 300, 255, 1);

DELETE FROM `creature_loot_template` WHERE `entry` IN (18497,20299);
INSERT INTO `creature_loot_template` VALUES (18497, 21877, 24.59, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 27855, 6, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 27860, 3, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 23605, 8.56, 0, 1, 1, 7, 164, 1);
INSERT INTO `creature_loot_template` VALUES (18497, 24000, 3, 1, -24000, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 24001, 3, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 24007, 1, 1, -24007, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 24008, 1, 1, -24008, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 24035, 1, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 50028, 0.005, 1, -50028, 1, 0, 0, 0);

INSERT INTO `creature_loot_template` VALUES (20299, 21877, 24.59, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 27855, 9, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 27860, 4, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 23605, 11.2, 0, 1, 1, 7, 164, 1);
INSERT INTO `creature_loot_template` VALUES (20299, 24001, 3, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 24002, 3, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 24014, 0.2, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 24035, 1, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20299, 50028, 0.005, 1, -50028, 1, 0, 0, 0);

UPDATE `creature_template` SET `pickpocketloot` = 20299 WHERE `entry` = 20299;
DELETE FROM `pickpocketing_loot_template` WHERE `entry` = 20299;
INSERT INTO `pickpocketing_loot_template` VALUES (20299, 29571, 8.64, 0, 1, 1, 0, 0, 0);
INSERT INTO `pickpocketing_loot_template` VALUES (20299, 29569, 10.08, 0, 1, 1, 0, 0, 0);
INSERT INTO `pickpocketing_loot_template` VALUES (20299, 22829, 3.52, 0, 1, 1, 0, 0, 0);
INSERT INTO `pickpocketing_loot_template` VALUES (20299, 27855, 3.2, 0, 1, 1, 0, 0, 0);
INSERT INTO `pickpocketing_loot_template` VALUES (20299, 30458, 2.24, 0, 1, 1, 0, 0, 0);
INSERT INTO `pickpocketing_loot_template` VALUES (20299, 23439, 0.16, 0, 1, 1, 0, 0, 0);
INSERT INTO `pickpocketing_loot_template` VALUES (20299, 27856, 2.56, 0, 1, 1, 0, 0, 0);

-- this is just wrong
DELETE FROM `creature_loot_template` WHERE `item` = 28551;

DELETE FROM `creature_loot_template` WHERE `item` IN (7666);
INSERT INTO `creature_loot_template` VALUES (4856, 7666, 4.7, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (4852, 7666, 3.9, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (4851, 7666, 2.3, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (4846, 7666, 1.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (4845, 7666, 1.4, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (4844, 7666, 1.2, 0, 1, 1, 0, 0, 0);

-- Ragnaros 11502
UPDATE `creature_template` SET `dmgschool` = 2 WHERE `entry` = 11502;

DELETE FROM `creature` WHERE `guid` IN (16777014,34038);
INSERT INTO `creature` VALUES (34038, 20923, 540, 2, 0, 0, 513.24, 315.927, 1.93557, 3.1429, 86400, 0, 0, 103320, 0, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (16777014,34038,62871,62872);
INSERT INTO `creature_formations` VALUES
(34038,34038,150,360,2),
(34038,62921,150,360,2),
(34038,62871,150,360,2),
(34038,62872,150,360,2);

DELETE FROM `creature_linked_respawn` WHERE `linkedguid` IN (16777014,34038,62921);
INSERT INTO `creature_linked_respawn` VALUES (62921, 62921);
INSERT INTO `creature_linked_respawn` VALUES (34038, 34038);

UPDATE `creature` SET `spawntimesecs`= 86400 WHERE `id` = 17427;
UPDATE `creature` SET `position_x` = '513.24', `position_y` = '315.927', `position_z` = '1.93557', `orientation` = '3.1429', `spawntimesecs`= 86400 WHERE `id` = 17461;
UPDATE `creature` SET `spawntimesecs`= 86400 WHERE `id` = 20923;

