
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

