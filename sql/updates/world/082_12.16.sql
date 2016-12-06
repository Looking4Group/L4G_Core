-- Steam Surger
UPDATE `creature` SET `MovementType` = 0 WHERE `id` = 21696;

SET @GUID := 12604;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12604, 1, -9583.38, 56.4448, 61.5721, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12604, 2, -9562.35, 72.3336, 59.0201, 5000, 0, 0, 0, 0);

SET @GUID := 12679;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12679, 1, 22.672, -223.202, -22.536, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12679, 2, 39.0578, -210.222, -22.6133, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12679, 3, 22.1297, -224.366, -22.5328, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12679, 4, 8.45932, -247.386, -23.3366, 0, 0, 0, 0, 0);

SET @GUID := 12695;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12695, 1, 27.0136, -145.039, -22.3968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 2, 18.9726, -161.946, -22.438, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12695, 3, 26.7279, -177.709, -22.3997, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 4, 18.9726, -161.946, -22.438, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12695, 5, 30.8925, -138.629, -22.5491, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 6, 57.7822, -114.87, -22.6239, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 7, 38.5541, -130.114, -22.6439, 0, 0, 0, 0, 0);

SET @GUID := 12700;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12700, 1, 13.0123, -180.845, -22.3747, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 2, 17.6451, -189.086, -22.4312, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 3, 29.465, -208.979, -22.5932, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 4, 17.0985, -188.306, -22.4238, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 5, 9.53988, -180.075, -22.4403, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 6, -7.20501, -173.28, -23.2732, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 7, 2.36385, -176.577, -22.3011, 0, 0, 0, 0, 0);

SET @GUID := 99970;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (99970, 1, -1046.56, 7486.97, 229.16, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99970, 2, -1069.78, 7421.03, 228.622, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99970, 3, -1119.78, 7498.12, 218.884, 3000, 0, 0, 0, 0);

SET @GUID := 12794;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12794, 11, 675.512, 270.854, 125.131, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 12, 655.124, 294.591, 125.117, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 13, 655.017, 300.198, 125.126, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 14, 658.337, 327.576, 125.159, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 15, 665.057, 333.561, 125.156, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 16, 688.727, 360.796, 125.139, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 17, 692.899, 360.548, 125.139, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 1, 704.168, 360.445, 125.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 2, 723.814, 359.922, 125.143, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 3, 725.9, 356.229, 125.149, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 4, 753.716, 322.517, 125.174, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 5, 753.62, 319.39, 125.172, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 6, 750.64, 287.66, 125.142, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 7, 748.388, 284.961, 125.142, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 8, 723.082, 263.289, 125.158, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 9, 719.945, 263.568, 125.177, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 10, 681.224, 266.071, 125.149, 0, 0, 0, 100, 0);

-- Reinforced Fel Iron Chest 185168,185169
UPDATE `gameobject_template` SET `size` = 1.5 WHERE `entry` IN (185168,185169);

-- Hellfire Ramparts Epic Gems
DELETE FROM `reference_loot_template` WHERE `entry` = 50002 AND `item` = 30592;
INSERT INTO `reference_loot_template` VALUES (50002, 30592, 0, 1, 1, 1, 0, 0, 0);

UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 21764 AND `item` = 12020;
DELETE FROM `gameobject_loot_template` WHERE `entry` = 21764 AND `item` = 50002;
INSERT INTO `gameobject_loot_template` VALUES (21764, 50002, 40, 1, -50002, 1, 0, 0, 0);
