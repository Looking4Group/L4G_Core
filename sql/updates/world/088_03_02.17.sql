SET @GUID := 97;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (97, 1, -4894.08, -1115.88, 501.793, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 2, -4906.62, -1118.98, 501.698, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 3, -4917.98, -1125.18, 501.698, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 4, -4921.55, -1132.52, 501.607, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 5, -4923.34, -1144.43, 501.442, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 6, -4928.31, -1159, 501.499, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 7, -4932.61, -1173.35, 501.61, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 8, -4938.12, -1183.53, 501.706, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 9, -4948.81, -1191.51, 501.659, 30000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 10, -4938.76, -1183.05, 501.712, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 11, -4932.52, -1170.77, 501.594, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 12, -4928.32, -1153.06, 501.463, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 13, -4925.35, -1140.76, 501.372, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 14, -4922.71, -1131.44, 501.63, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 15, -4913.5, -1121.1, 501.698, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 16, -4900.86, -1117.31, 501.698, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97, 17, -4883.25, -1115.64, 502.197, 30000, 0, 0, 100, 0);

SET @GUID := 6218;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (6218, 1, -7189.78, -1703.28, 242.022, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 2, -7189.11, -1688.74, 240.686, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 3, -7185.06, -1662.91, 241.097, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 4, -7176.01, -1649.45, 241.665, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 5, -7152.52, -1646.87, 240.573, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 6, -7120.01, -1661.24, 240.515, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 7, -7116.35, -1664.98, 241.667, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 8, -7094.93, -1691.71, 241.661, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 9, -7094.97, -1696.36, 240.304, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 10, -7110.31, -1702.4, 240.626, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 11, -7124.61, -1706.56, 240.08, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 12, -7138.68, -1724.57, 240.802, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 13, -7154.09, -1739.43, 242.742, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 14, -7177.27, -1751.42, 243.498, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 15, -7191.14, -1739.76, 244.375, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 16, -7199.08, -1721.11, 244.429, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 17, -7200.48, -1716.67, 242.274, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (6218, 18, -7197.34, -1702.22, 241.667, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `guid` IN (6218,98866,98867,98868,98869);
INSERT INTO `creature` VALUES (6218, 8277, 0, 1, 4458, 0, -7189.3, -1704.58, 242.323, 1.25664, 75600, 0, 0, 2578, 0, 0, 2);
INSERT INTO `creature` VALUES (98866, 8277, 0, 1, 4458, 0, -6536.05, -1656.03, 288.403, 3.02536, 86400, 20, 0, 2578, 0, 0, 1);
INSERT INTO `creature` VALUES (98867, 8277, 0, 1, 4458, 0, -7154.71, -1505.94, 240.626, 0.566275, 97200, 20, 0, 2578, 0, 0, 1);
INSERT INTO `creature` VALUES (98868, 8277, 0, 1, 4458, 0, -7185.76, -999.545, 244.448, 6.09784, 108000, 20, 0, 2578, 0, 0, 1);
INSERT INTO `creature` VALUES (98869, 8277, 0, 1, 4458, 0, -6515.87, -1104.83, 313.092, 5.45302, 115200, 20, 0, 2578, 0, 0, 1);

DELETE FROM `pool_creature` WHERE `pool_entry`  = 1099;
INSERT INTO `pool_creature` VALUES
(6218,1099,0,'Rekk\'tilac (8277)'),
(98866,1099,0,'Rekk\'tilac (8277)'),
(98867,1099,0,'Rekk\'tilac (8277)'),
(98868,1099,0,'Rekk\'tilac (8277)'),
(98869,1099,0,'Rekk\'tilac (8277)');

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 8277;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 8277;
INSERT INTO `creature_ai_scripts` VALUES (827701,8277,1,0,100,1,0,0,0,0,11,10022,0,33,0,0,0,0,0,0,0,0,'Rekk\'tilac - Cast Deadly Poison');

