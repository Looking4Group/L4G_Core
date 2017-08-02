DELETE FROM creature_formations WHERE leaderguid IN (12880,12881,12872,12873);
DELETE FROM creature_formations WHERE memberguid IN (12880,12881,12872,12873);
INSERT INTO creature_formations VALUES
(12880,12880,100,360,2),
(12880,12881,100,360,2),
(12880,12872,100,360,2),
(12880,12873,100,360,2);

UPDATE `creature_template` SET `InhabitType` = 5 WHERE `entry` = 17260;

DELETE FROM `creature` WHERE `guid` IN (38, 32343);
INSERT INTO `creature` VALUES (38, 15763, 0, 1, 0, 0, -4811.98, -1264.85, 501.951, 3.05433, 300, 0, 0, 3000, 0, 0, 0);
INSERT INTO `creature` VALUES (32343, 14887, 1, 1, 15364, 0, 3301.05, -3732.57, 173.544, 2.9147, 868400, 0, 0, 820000, 9852, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (169,171,99691,99692);
INSERT INTO `creature` VALUES (169, 1125, 0, 1, 0, 0, -5488.25, -566.629, 400.102, 1.97222, 180, 10, 0, 102, 0, 0, 1);
INSERT INTO `creature` VALUES (171, 12363, 0, 1, 0, 0, -5458.53, -613.969, 393.841, 5.51524, 180, 0, 0, 64, 53, 0, 0);
INSERT INTO `creature` VALUES (99691, 24064, 568, 1, 0, 0, 172.391, 1152.36, -0.150623, 2.0844, 7200, 0, 0, 29000, 0, 0, 0);
INSERT INTO `creature` VALUES (99692, 24064, 568, 1, 0, 0, 149.256, 1152.16, 0.21241, 3.10939, 7200, 0, 0, 29000, 0, 0, 0);

DELETE FROM `creature_formations` WHERE `memberguid` IN (169, 171, 99691, 99692);
INSERT INTO `creature_formations` VALUES (86927, 99692, 5.6992, 1.61841, 2), (86927, 99691, 2.30932, 4.86453, 2);

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (169, 171, 99691, 99692);
INSERT INTO `creature_linked_respawn` VALUES (99691, 86195), (99692,	86195);

UPDATE `creature_template` SET `minhealth` = 172320, `maxhealth` = 172320 WHERE `entry` = 23028;
UPDATE `creature` SET `curhealth` = 172320, `spawndist` = 0, `MovementType` = 0 WHERE `id` = 23028;
UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 53816;

SET @GUID := 53815; -- 26677
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (53815, 23028, 564, 1, 0, 0, 614.969, 905.172, 59.0277, 3.24826, 7200, 0, 0, 172320, 32310, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (53815, 1, 614.969, 905.172, 59.0277, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53815, 2, 602.599, 900.33, 59.4069, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53815, 3, 601.325, 900.235, 59.6449, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53815, 4, 596.367, 905.317, 59.7319, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53815, 5, 594.775, 909.96, 59.2119, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53815, 6, 598.766, 913.359, 58.6906, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53815, 7, 609.461, 912.467, 58.6248, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53815, 8, 615.044, 905.198, 58.9843, 0, 0, 0, 100, 0);
DELETE FROM `creature_formations` WHERE `leaderguid` = 53815;
INSERT INTO `creature_formations` VALUES (53815, 53815, 0, 0, 2), (53815, 26677, 4, 4.71, 2);

SET @GUID := 53817; -- 53818
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (53817, 23028, 564, 1, 0, 0, 779.796, 907.4, 55.3142, 0.467618, 7200, 0, 0, 172320, 32310, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (53817, 1, 779.796, 907.4, 55.3142, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 2, 787.965, 919.118, 56.0122, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 3, 793.161, 922.244, 56.7831, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 4, 795.399, 923.138, 56.9845, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 5, 801.302, 923.385, 57.1734, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 6, 808.412, 919.609, 57.2328, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 7, 812.012, 913.312, 57.1818, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 8, 812.204, 913.675, 57.2261, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 9, 808.292, 919.791, 57.1894, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 10, 801.103, 923.239, 57.1144, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 11, 790.035, 920.629, 56.377, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 12, 786.245, 917.222, 55.7047, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53817, 13, 783.331, 914.037, 55.2782, 0, 0, 0, 100, 0);
DELETE FROM `creature_formations` WHERE `leaderguid` IN (53817, 53818);
INSERT INTO `creature_formations` VALUES (53817, 53817, 0, 0, 2), (53817, 53818, 4, 4.71, 2);

SET @GUID := 53819; -- 35394
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (53819, 23028, 564, 1, 0, 0, 824.239, 922.099, 56.915, 2.32234, 7200, 0, 0, 172320, 32310, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (53819, 1, 824.239, 922.099, 56.915, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 2, 821.017, 923.827, 56.8629, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 3, 818.073, 927.409, 57.3001, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 4, 814.823, 931.159, 56.8001, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 5, 812.996, 933.005, 56.4235, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 6, 812.416, 948.017, 56.8114, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 7, 813.565, 956.657, 55.9874, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 8, 814.467, 959.68, 55.6162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 9, 815.813, 960.579, 55.6155, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 10, 813.732, 955.556, 56.1911, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 11, 812.79, 950.88, 56.5835, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 12, 812.501, 941.174, 56.2278, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 13, 816.401, 926.781, 57.3932, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53819, 14, 818.651, 925.781, 57.3932, 0, 0, 0, 100, 0);
DELETE FROM `creature_formations` WHERE `leaderguid` = 53819;
INSERT INTO `creature_formations` VALUES (53819, 53819, 0, 0, 2), (53819, 35394, 4, 4.71, 2);

SET @GUID := 53820; -- 53821
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (53820, 23028, 564, 1, 0, 0, 633.226, 963.415, 55.9534, 5.46778, 7200, 0, 0, 172320, 32310, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (53820, 1, 633.226, 963.415, 55.9534, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 2, 626.054, 963.98, 56.3757, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 3, 620.521, 966.034, 56.2526, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 4, 620.735, 966.174, 56.313, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 5, 626.103, 963.96, 56.2586, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 6, 639.017, 964.698, 55.6559, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 7, 640.423, 965.39, 55.4163, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 8, 640.174, 965.036, 55.3669, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53820, 9, 634.595, 963.631, 56.073, 0, 0, 0, 100, 0);
DELETE FROM `creature_formations` WHERE `leaderguid` = 53820;
INSERT INTO `creature_formations` VALUES (53820, 53820, 0, 0, 2), (53820, 53821, 4, 4.71, 2);

SET @GUID := 53814; -- 53816
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (53814, 23028, 564, 1, 0, 0, 782.2965, 769.8445, 65.6355, 1.59721, 7200, 0, 0, 172320, 32310, 0, 0);
DELETE FROM `creature_formations` WHERE `leaderguid` = 53816;
INSERT INTO `creature_formations` VALUES (53816, 53816, 0, 0, 2), (53816, 53814, 4, 4.71, 2);

SET @GUID := 53813; -- 53053
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (53813, 22963, 564, 1, 0, 0, 761.4728, 776.0482, 64.7099, 3.1607, 7200, 0, 0, 25000, 31550, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderguid` = 53053;
INSERT INTO `creature_formations` VALUES (53053, 53053, 0, 0, 2),(53053, 53050, 0, 0, 2),(53053, 53051, 0, 0, 2),(53053, 53052, 0, 0, 2),(53053, 53049, 0, 0, 2),(53053, 53813, 0, 0, 2); 

DELETE FROM `creature_formations` WHERE `leaderguid` = 52911;
INSERT INTO `creature_formations` VALUES (52911, 52911, 0, 0, 2),(52911, 52910, 0, 0, 2),(52911, 52909, 0, 0, 2),(52911, 52908, 0, 0, 2),(52911, 52907, 0, 0, 2),(52911, 37612, 0, 0, 2);

DELETE FROM `creature_formations` WHERE `leaderguid` = 52938;
INSERT INTO `creature_formations` VALUES (52938, 52938, 0, 0, 2),(52938, 52936, 0, 0, 2),(52938, 52935, 0, 0, 2),(52938, 52930, 0, 0, 2),(52938, 52919, 0, 0, 2),(52938, 52918, 0, 0, 2);

DELETE FROM `creature_formations` WHERE `leaderguid` = 53048;
INSERT INTO `creature_formations` VALUES (53048, 53048, 0, 0, 2),(53048, 53035, 0, 0, 2),(53048, 52991, 0, 0, 2),(53048, 52941, 0, 0, 2),(53048, 52940, 0, 0, 2),(53048, 52939, 0, 0, 2);

DELETE FROM `creature_formations` WHERE `leaderguid` = 52917;
INSERT INTO `creature_formations` VALUES (52917, 52917, 0, 0, 2),(52917, 52916, 0, 0, 2),(52917, 52915, 0, 0, 2),(52917, 52914, 0, 0, 2),(52917, 52913, 0, 0, 2),(52917, 52912, 0, 0, 2);

-- Deathwhisperer 19299
UPDATE creature_template SET `spell1` = 0, `spell2` = 0, `spell3` = 0 WHERE entry = 19299;

