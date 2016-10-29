-- Same Quepop for WSG Arathi and EOTS
UPDATE `battleground_template` SET `MinPlayersPerTeam` = 6 WHERE `id` IN (2,3,7);

-- shoulder pads 2.00k r 1500p -> 1435
-- the 2.05k to 2.2k grind is worth 2 weeks of points minimum
-- DELETE FROM `npc_vendor` WHERE `entry` = 1200061 AND `item` IN (30490,31964,31971,31976,31979,31990,31996,32001,32008,32013,32018,32024,32033,32037,32043,32047,32059);
-- INSERT INTO `npc_vendor` VALUES
-- (1200061,30490,0,0,1435), --  2359
-- (1200061,31964,0,0,1435),(1200061,31971,0,0,1435),(1200061,31976,0,0,1435),(1200061,31979,0,0,1435),(1200061,31990,0,0,1435),(1200061,31996,0,0,1435),(1200061,32001,0,0,1435),(1200061,32008,0,0,1435),
-- (1200061,32013,0,0,1435),(1200061,32018,0,0,1435),(1200061,32024,0,0,1435),(1200061,32033,0,0,1435),(1200061,32037,0,0,1435),(1200061,32043,0,0,1435),(1200061,32047,0,0,1435),(1200061,32059,0,0,1435);

DELETE FROM `creature` WHERE `guid` IN (16800046,16800048,16800056,16800106,16800123,16800126,16800127,16800135,16800136,16800923,16800924,16800716,16800707,16800705,16800706);
DELETE FROM `creature` WHERE `guid` IN (26973,44253,40444,73662,86179,88482,93958,93959,93960,132569,245629);

INSERT INTO `creature` VALUES (26973, 5643, 1, 1, 3790, 0, -419.61, 1850.15, 128.492, 1.20428, 300, 0, 0, 1208, 1097, 0, 0);

INSERT INTO `creature` VALUES (44253, 27666, 530, 1, 0, 1293, -1829.72, 5500.5, -12.4278, 3.8107, 25, 0, 0, 6600, 0, 0, 0);

INSERT INTO `creature` VALUES (40444, 27667, 530, 1, 0, 429, -1848.02, 5506.64, -12.4278, 4.97954, 300, 0, 0, 4500, 0, 0, 0);

INSERT INTO `creature` VALUES (73662, 20921, 530, 1, 0, 0, 3373.58, 2892.23, 144.049, 4.32842, 300, 0, 0, 5000, 3080, 0, 0);

INSERT INTO `creature` VALUES (86179, 26124, 0, 1, 0, 0, 1806.27, 220.163, 60.3925, 1.43117, 300, 0, 0, 1, 0, 0, 0);

INSERT INTO `creature` VALUES (88482, 15930, 533, 1, 0, 0, 3508.85, -2994.08, 312.18, 2.33, 6380, 0, 0, 499650, 0, 0, 0);
DELETE FROM `creature_linked_respawn` WHERE `guid` = 88482;
INSERT INTO `creature_linked_respawn` VALUES
(88482,88480);

INSERT INTO `creature` VALUES (93958, 26092, 530, 0, 0, 0, 12687, -6942.73, 36.2523, 4.49695, 600, 0, 0, 2500, 7196, 0, 0);
INSERT INTO `creature` VALUES (93959, 26091, 530, 0, 0, 0, 12678.7, -6972.44, 36.2525, 1.9392, 600, 0, 0, 8400, 7196, 0, 0);
INSERT INTO `creature` VALUES (93960, 26089, 530, 0, 0, 0, 12686.7, -6972.61, 36.2519, 1.84288, 600, 0, 0, 6000, 0, 0, 0);

INSERT INTO `creature` VALUES (132569, 18956, 556, 1, 0, 0, -157.6380, 158.8178, 0.010763, 1.0821, 180, 0, 0, 8700, 0, 0, 0);

INSERT INTO `creature` VALUES (245629, 26178, 1, 1, 0, 0, -413.607, 2425.78, 65.7533, 4.50994, 600, 0, 0, 1700, 0, 0, 0);

DELETE FROM `game_event_creature` WHERE `guid` IN (44253,40444,86179,93958,93959,93960);
INSERT INTO `game_event_creature` VALUES
(86179, 1),

(44253, 46),
(40444, 46),

(93959,49),

(93958,53),
(93960,53);

-- Stairs of Destiny NPCs should not be attackable
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|2 WHERE `entry` IN (20487, 20513);

-- Searing Elemental (Fire Elemental)
UPDATE `creature_template` SET `resistance2` = -1 WHERE `entry` = 20514;

-- Greyheart Nether-Mage 21230
-- only Sheepable immune to cast speed reduce ( all casters )
-- Decides whether Fire 38635 38636 38641 Frost 38644 38645 38646 Arcane 38633 38634, additional Blink 38642 38643 and Buff 38647 38648 38649 depending on specc chosen maybe 38632 for visual something
-- http://www.wowhead.com/npc=21230/greyheart-nether-mage#comments , http://wowwiki.wikia.com/wiki/Greyheart_Nether-Mage?direction=prev&oldid=993664 , http://wowwiki.wikia.com/wiki/Greyheart_Nether-Mage?direction=next&oldid=1185956
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`baseattacktime`='1400',`mechanic_immune_mask`='1073627115' WHERE `entry` = 21230; -- 1513 3087 2000 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21230;
INSERT INTO `creature_ai_scripts` VALUES
('2123001','21230','11','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Spawn'),
('2123002','21230','4','125','100','2','0','0','0','0','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt on Aggro (Phase 1)'),
('2123003','21230','9','125','100','3','0','40','1200','4800','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt (Phase 1)'),
('2123004','21230','9','125','100','3','0','5','8000','12000','11','38644','0','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Cone of Cold (Phase 1)'),
('2123005','21230','0','125','100','3','6000','12000','8400','12000','11','38646','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blizzard (Phase 1)'),
('2123006','21230','1','125','100','3','1000','1000','1800000','1800000','11','38649','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction OOC (Phase 1)'),
('2123007','21230','27','125','100','3','38649','1','5000','5000','11','38649','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction on Missing Buff (Phase 1)'),
('2123008','21230','1','119','100','3','1000','1000','1800000','1800000','11','38648','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction OOC (Phase 3)'),
('2123009','21230','4','119','100','2','0','0','0','0','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball on Aggro (Phase 3)'),
('2123010','21230','9','119','100','3','0','40','1200','4800','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball (Phase 3)'),
('2123011','21230','0','119','100','3','6000','12000','8400','12000','11','38635','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Rain of Fire (Phase 3)'),
('2123012','21230','9','119','100','2','0','30','9000','12000','11','38636','1','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Scorch (Phase 3)'),
('2123013','21230','27','119','100','3','38648','1','5000','5000','11','38648','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction on Missing Buff (Phase 3)'),
('2123014','21230','1','95','100','3','1000','1000','1800000','1800000','11','38647','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction OOC (Phase 2)'),
('2123015','21230','4','95','100','2','0','0','0','0','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley on Aggro (Phase 5)'),
('2123016','21230','9','95','100','3','0','40','4800','9600','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley (Phase 5)'),
('2123017','21230','0','95','100','3','2000','6000','9600','12600','11','38634','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Lightning (Phase 5)'),
('2123018','21230','27','95','100','3','38647','1','5000','5000','11','38647','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction on Missing Buff (Phase 5)'),
('2123019','21230','0','0','75','3','6000','18000','17000','24000','11','38642','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blink'),
('2123020','21230','7','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Evade');

-- League of Arathor Emissary
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|4 WHERE `entry` = 14991;

DELETE FROM `creature` WHERE `id` IN (21229,21230,21231);
DELETE FROM `creature` WHERE `guid` IN (93778,93785,93796);
INSERT INTO `creature` VALUES (80997, 21229, 548, 1, 0, 0, 334.2682, -430.3515, 28.8718, 6.2358, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (82756, 21229, 548, 1, 0, 2224, 374.2856, -347.3562, 21.8560, 5.4622, 7200, 0, 0, 143600, 48465, 0, 0);
-- INSERT INTO `creature` VALUES (82768, 21229, 548, 1, 0, 0, 553.778, -545.207, -7.23891, 2.79189, 7200, 0, 0, 143600, 48465, 0, 0);
-- INSERT INTO `creature` VALUES (82853, 21229, 548, 1, 0, 0, 561.644, -507.314, -13.1582, 3.055, 7200, 0, 0, 143600, 48465, 0, 0);
-- INSERT INTO `creature` VALUES (82862, 21229, 548, 1, 0, 0, 441.064, -512.791, -13.1582, 0.129391, 7200, 0, 0, 143600, 48465, 0, 0);
-- INSERT INTO `creature` VALUES (82959, 21229, 548, 1, 0, 0, 437.532, -481.711, -13.1582, 6.23586, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93774, 21229, 548, 1, 0, 0, 330.81, -350.956, 21.3821, 2.61292, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93775, 21229, 548, 1, 0, 0, 314.319, -329.828, 19.6541, 0.443651, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93776, 21229, 548, 1, 0, 0, 308.572, -367.721, 22.3129, 1.02799, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93777, 21230, 548, 1, 0, 0, 333.3426, -427.1696, 28.8718, 0.68634, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93781, 21229, 548, 1, 0, 2224, 423.121, -419.802, 9.39515, 1.14256, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93782, 21229, 548, 1, 0, 2224, 501.418, -454.667, -13.1574, 1.67115, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93783, 21229, 548, 1, 0, 2224, 496.749, -454.619, -13.1574, 1.67115, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93785, 21232, 548, 1, 0, 0, 324.7960, -435.9576, 29.0952, 3.9464, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93786, 21229, 548, 1, 0, 2224, 427.517, -422.144, 9.60363, 1.0813, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93797, 21229, 548, 1, 0, 0, 395.807, -354.966, 23.4089, 2.34588, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93800, 21229, 548, 1, 0, 0, 358.323, -317.66, 18.4688, 1.61074, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (198740, 21229, 548, 1, 0, 2224, 220.117, -430.829, -4.43271, 2.94987, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (202219, 21229, 548, 1, 0, 2224, 214.48, -509.495, -11.5361, 2.89592, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (208245, 21229, 548, 1, 0, 2224, 204.643, -613.358, -11.8273, 0.273917, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (210738, 21229, 548, 1, 0, 2224, 217.717, -264.914, -2.02762, 5.5094, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (257314, 21229, 548, 1, 0, 2224, 376.155, -498.513, 27.1909, 3.37391, 7200, 0, 0, 143600, 48465, 0, 0);

INSERT INTO `creature` VALUES (81912, 21230, 548, 1, 0, 1044, 369.8341, -350.7282, 21.6454, 5.4622, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93769, 21230, 548, 1, 0, 1044, 377.142, -511.228, 28.8012, 3.22154, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93778, 21232, 548, 1, 0, 0, 333.1330, -422.3574, 28.8717, 3.8365, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93779, 21229, 548, 1, 0, 0, 334.326, -427.819, 28.8718, 0.694979, 7200, 0, 0, 143600, 48465, 0, 2);
INSERT INTO `creature` VALUES (93790, 21230, 548, 1, 0, 0, 329.482, -346.314, 21.3023, 2.87367, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93795, 21230, 548, 1, 0, 0, 399.4429, -354.5076, 23.6099, 2.1189, 7200, 0, 0, 143600, 48465, 0, 2);
INSERT INTO `creature` VALUES (93796, 21232, 548, 1, 0, 0, 400.3313, -362.0697, 23.6713, 2.0788, 7200, 0, 0, 179525, 0, 0, 0);
INSERT INTO `creature` VALUES (93799, 21229, 548, 1, 0, 0, 346.7421, -319.6366, 18.5966, 1.6020, 7200, 5, 0, 143600, 48465, 0, 1);
INSERT INTO `creature` VALUES (93801, 21230, 548, 1, 0, 1044, 314.5498, -318.5748, 18.7143, 6.1651, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (93854, 21230, 548, 1, 0, 0, 309.366, -371.816, 22.3256, 0.790794, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (200581, 21230, 548, 1, 0, 1044, 226.337, -433.501, -4.43271, 2.87314, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (201667, 21230, 548, 1, 0, 1044, 231.933, -429.863, -4.43271, 1.88432, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (202652, 21230, 548, 1, 0, 1044, 221.87, -512.06, -11.5361, 2.77811, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (202740, 21230, 548, 1, 0, 1044, 224.503, -518.917, -11.5558, 3.68725, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (208340, 21230, 548, 1, 0, 1044, 198.197, -614.523, -11.8344, 0.273917, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (208389, 21230, 548, 1, 0, 1044, 191.42, -610.888, -11.8542, 0.554305, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (210824, 21230, 548, 1, 0, 1044, 213.501, -260.794, -2.02762, 5.5094, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (210894, 21230, 548, 1, 0, 1044, 205.82, -260.676, -2.02762, 5.49838, 7200, 0, 0, 143600, 48465, 0, 0);

INSERT INTO `creature` VALUES (80497, 21231, 548, 1, 0, 0, 337.1503, -438.3084, 28.8718, 0.0210, 7200, 0, 0, 179525, 0, 0, 0);
-- INSERT INTO `creature` VALUES (81025, 21231, 548, 1, 0, 0, 451.279, -570.087, -7.36974, 6.24372, 7200, 0, 0, 179525, 0, 0, 0);
-- INSERT INTO `creature` VALUES (81028, 21231, 548, 1, 0, 0, 549.974, -569.879, -7.14429, 2.91756, 7200, 0, 0, 179525, 0, 0, 0);
-- INSERT INTO `creature` VALUES (81770, 21231, 548, 1, 0, 0, 556.908, -478.109, -13.1582, 3.15946, 7200, 0, 0, 179525, 0, 0, 0);
INSERT INTO `creature` VALUES (82869, 21231, 548, 1, 0, 2135, 470.277, -413.445, -4.8385, 2.26183, 7200, 0, 0, 200000, 0, 0, 2);
INSERT INTO `creature` VALUES (93767, 21231, 548, 1, 0, 2135, 338.445, -505.401, 28.1543, 2.54137, 7200, 0, 0, 200000, 0, 0, 2);
INSERT INTO `creature` VALUES (93784, 21231, 548, 1, 0, 2135, 426.294, -419.788, 8.69177, 1.11581, 7200, 0, 0, 200000, 0, 0, 2);
INSERT INTO `creature` VALUES (93791, 21231, 548, 1, 0, 0, 315.756, -324.118, 19.0598, 6.01055, 7200, 0, 0, 200000, 0, 0, 0);
INSERT INTO `creature` VALUES (93792, 21231, 548, 1, 0, 0, 304.69, -367.878, 22.4158, 0.591305, 7200, 0, 0, 200000, 0, 0, 0);
INSERT INTO `creature` VALUES (93793, 21231, 548, 1, 0, 0, 394.402, -373.301, 23.3723, 2.44877, 7200, 0, 0, 200000, 0, 0, 0);
INSERT INTO `creature` VALUES (93794, 21231, 548, 1, 0, 0, 372.981, -350.218, 21.8563, 5.19217, 7200, 0, 0, 200000, 0, 0, 0);
INSERT INTO `creature` VALUES (93803, 21231, 548, 1, 0, 0, 313.666, -262.427, 14.0867, 2.89016, 7200, 0, 0, 200000, 0, 0, 2);
INSERT INTO `creature` VALUES (93804, 21231, 548, 1, 0, 0, 315.598, -255.441, 13.6739, 2.89959, 7200, 0, 0, 200000, 0, 0, 2);
INSERT INTO `creature` VALUES (255324, 21231, 548, 1, 0, 2135, 374.988, -508.343, 28.39, 3.42574, 7200, 0, 0, 200000, 0, 0, 0);
INSERT INTO `creature` VALUES (255453, 21231, 548, 1, 0, 2135, 374.519, -501.494, 27.4001, 3.19013, 7200, 0, 0, 200000, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` BETWEEN 172714 AND 172722;
DELETE FROM `creature` WHERE `guid` IN (80510,80731,80498,81913,81914,81915,93768);
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (80510,80731,80498,81912,82756,81913,81914,81915,93768,80497);
INSERT INTO `creature_linked_respawn` VALUES
(80510,93773),
(80731,93773),
(80498,93773),
(81912,93773),
(82756,93773),
(81913,93773),
(81914,93773),
(81915,93773),
(93768,93773),
(80497,93773);

INSERT INTO `creature` VALUES (93768, 21230, 548, 1, 0, 0, 392.107, -497.182, 28.4324, 3.21532, 7200, 0, 0, 143600, 48465, 0, 2);
SET @GUID := 93768;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (93768, 1, 345.004, -495.757, 27.4974, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 2, 332.75, -484.522, 28.8718, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 3, 342.738, -459.077, 28.357, 0, 0, 0, 0, 0);  
INSERT INTO `waypoint_data` VALUES (93768, 4, 356.3506, -403.3568, 27.0522, 0, 0, 0, 0, 0); 
INSERT INTO `waypoint_data` VALUES (93768, 5, 359.284, -371.831, 22.9121, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 6, 371.08, -355.191, 21.8825, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 7, 380.074, -343.367, 21.9524, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 8, 385.721, -357.798, 22.8594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 9, 378.991, -384.532, 22.852, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 10, 367.8644, -403.3157, 27.8450, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 11, 325.218, -461.153, 28.9344, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93768, 12, 328.264, -497.084, 28.3245, 0, 0, 0, 0, 0);
 
SET @GUID := 93795;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (93795, 1, 392.887, -329.59, 20.8056, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93795, 2, 387.976, -320.925, 20.1713, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93795, 3, 373.389, -331.221, 19.8124, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93795, 4, 378.267, -350.125, 22.2263, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93795, 5, 388.241, -344.162, 22.856, 0, 0, 0, 0, 0);

SET @GUID := 93779;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 339.2322, -420.8434, 28.8717,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 330.7823, -417.7982, 28.8717,2000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 339.2322, -420.8434, 28.8717,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 341.9577, -432.8303, 28.7432,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 340.0797, -443.4074, 28.6889,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 333.6788, -443.5497, 28.8710,2000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 340.0797, -443.4074, 28.6889,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 341.9577, -432.8303, 28.7432,0,0,0,100,0);

INSERT INTO `creature` VALUES (80510, 21229, 548, 1, 0, 0, 334.5979, -403.3244, 28.2897, 5.3287, 7200, 0, 0, 143600, 48465, 0, 2);
SET @GUID := 80510;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (80510, 1, 338.786, -409.471, 28.3277, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80510, 2, 379.036, -396.841, 28.2056, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80510, 3, 359.758, -387.969, 23.7165, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80510, 4, 323.079, -385.927, 23.0982, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (80731, 21230, 548, 1, 0, 0, 345.9931, -506.1338, 28.1467, 3.1272, 7200, 0, 0, 143600, 48465, 0, 2);
SET @GUID := 80731;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (80731, 1, 335.054, -500.517, 27.8057, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 2, 329.97, -461.809, 28.8718, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 3, 340.265, -455.305, 28.5874, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 4, 363.066, -404.175, 27.2828, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 5, 377.62, -366.287, 22.4606, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 6, 344.51, -364.056, 21.7262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 7, 343.749, -425.712, 28.7533, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 8, 328.873, -483.333, 28.8704, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 9, 333.436, -494.25, 27.7525, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (80731, 10, 393.779, -503.174, 27.205, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (80498, 21231, 548, 1, 0, 0, 333.5784, -343.7477, 21.0158, 2.7997, 7200, 0, 0, 179525, 0, 0, 0);

INSERT INTO `creature` VALUES (81913, 21230, 548, 1, 0, 1044, 390.1734, -381.4599, 23.1745, 3.0860, 7200, 0, 0, 143600, 48465, 0, 0);
INSERT INTO `creature` VALUES (81914, 21229, 548, 1, 0, 2224, 396.5572, -368.5735, 23.4723, 3.1547, 7200, 0, 0, 143600, 48465, 0, 0);

INSERT INTO `creature` VALUES (81915, 21863, 548, 1, 0, 0, 392.0486, -366.5477, 23.2245, 2.7640, 7200, 5, 0, 104790, 0, 0, 1);

UPDATE `creature` SET `equipment_id` = 2137 WHERE `guid` = 93798;
DELETE FROM `creature_addon` WHERE `guid` = 93798;
INSERT INTO `creature_addon` VALUES
(93798, 0, 0, 512, 0, 4097, 0, 0, NULL);

SET @GUID := 82952;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,''); -- 1680
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (82952, 1, 364.177, -317.168, 18.3748, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (82952, 2, 353.5723, -310.7877, 18.1592, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (82952, 3, 334.063, -320.588, 18.6774, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (82952, 4, 322.622, -348.978, 21.6507, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (82952, 5, 326.463, -368.18, 22.0487, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (82952, 6, 380.639, -362.416, 22.6063, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (82952, 7, 382.796, -325.989, 19.9232, 0, 0, 0, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderguid` IN (80497,93776,93790,93793,93794,93791,93798,93766);
INSERT INTO `creature_formations` VALUES

(80497,80497,100,360,2),
(80497,93779,100,360,2),
(80497,93785,100,360,2),
(80497,80997,100,360,2),
(80497,93777,100,360,2),
(80497,93778,100,360,2),

(93776,93776,100,360,2),
(93776,93854,100,360,2),
(93776,93792,100,360,2),

(93790,93790,100,360,2),
(93790,80498,100,360,2),
(93790,93774,100,360,2),

(93793,93793,100,360,2),
(93793,81913,100,360,2),
(93793,81914,100,360,2),
(93793,81915,100,360,2),
(93793,93796,100,360,2),
(93793,93797,100,360,2),

(93794,93794,100,360,2),
(93794,82756,100,360,2),
(93794,81912,100,360,2),

(93791,93791,100,360,2),
(93791,93775,100,360,2),
(93791,93801,100,360,2),

(93798,93798,100,360,2),
(93798,93799,100,360,2),
(93798,93800,100,360,2),

(93766,93766,100,360,2),
(93766,82975,100,360,2),
(93766,82976,100,360,2),
(93766,93765,100,360,2);
--
-- 183607,82966,93837,93840,93841,
-- 82861,93789,172713,173195
