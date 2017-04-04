UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` IN (44239, 54299, 54300, 54301, 56142, 78386, 78725, 78727, 78728, 84981, 86119, 211996, 223757);

SET @GUID := 1768;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16843008,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(1768,1,-4640.85,-1014.54,501.648,0,0,0,100,0),
(1768,2,-4681.18,-969.568,501.658,0,0,0,100,0),
(1768,3,-4689.31,-949.094,501.658,0,0,0,100,0),
(1768,4,-4711.22,-922.766,501.66,0,0,0,100,0),
(1768,5,-4709.47,-906.969,501.66,0,0,0,100,0),
(1768,6,-4668.06,-918.75,501.654,0,0,0,100,0),
(1768,7,-4625.97,-969.373,501.661,0,0,0,100,0),
(1768,8,-4617.51,-1000.31,501.66,0,0,0,100,0),
(1768,9,-4626.04,-1011.51,501.654,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 4915;
INSERT INTO `creature` VALUES (4915, 1410, 530, 1, 0, 0, -2411.25, 3154.89, 12.5169, 2.57465, 300, 0, 0, 4422, 2620, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = 4915;
INSERT INTO `creature_addon` VALUES (4915,4915,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = 4915;
INSERT INTO `waypoint_data` VALUES (4915, 1, -2425.55, 3163.99, 17.8902, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 2, -2429.36, 3184.92, 18.0829, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 3, -2421.88, 3196.28, 18.0901, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 4, -2409.75, 3196.48, 18.0835, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 5, -2401.37, 3186.51, 18.0837, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 6, -2403.1, 3176.19, 18.0851, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 7, -2411.92, 3170.7, 18.0846, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 8, -2421.16, 3170.4, 18.0838, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 9, -2424.85, 3168.23, 18.0831, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 10, -2417.57, 3160.76, 15.4873, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 11, -2409.66, 3157.18, 11.9287, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 12, -2399.89, 3160.79, 8.80061, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 13, -2390.16, 3169.78, 3.50048, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 14, -2388.43, 3169.41, 3.0388, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 15, -2400.48, 3157.43, 9.2453, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (4915, 16, -2411.25, 3154.89, 12.5169, 0, 0, 0, 100, 0);

SET @GUID := 6747;
UPDATE `creature` SET `MovementType`='2', `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(6747,1,-1747.49,5126.32,-35.8634,15000,0,0,0,0),
(6747,2,-1752.1,5142.16,-36.2611,269000,0,0,0,0),
(6747,3,-1747.49,5126.32,-35.8634,60000,0,0,0,0);

SET @GUID := 8742;
UPDATE `creature` SET `MovementType`='2', `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(8742,1,-5367.19,-2936.94,327.368,0,0,0,0,0),
(8742,2,-5378.17,-2925.83,331.671,0,0,0,0,0),
(8742,3,-5396.18,-2905.99,338.893,0,0,0,0,0),
(8742,4,-5405.21,-2891.45,342.355,0,0,0,0,0),
(8742,5,-5397.65,-2903.89,339.434,0,0,0,0,0),
(8742,6,-5389.32,-2913.93,336.257,0,0,0,0,0),
(8742,7,-5370.99,-2933.09,328.984,0,0,0,0,0),
(8742,8,-5357.74,-2947.28,324.143,0,0,0,0,0),
(8742,9,-5352.05,-2945.49,323.469,0,0,0,0,0),
(8742,10,-5347.44,-2937.83,323.164,0,0,0,0,0),
(8742,11,-5350.51,-2946.23,323.517,0,0,0,0,0),
(8742,12,-5359.93,-2951.5,324.043,0,0,0,0,0),
(8742,13,-5369.64,-2951.62,323.784,0,0,0,0,0),
(8742,14,-5355.88,-2952.06,323.909,0,0,0,0,0),
(8742,15,-5351.84,-2965.23,324.015,0,0,0,0,0),
(8742,16,-5348.78,-2976.38,324.3,0,0,0,0,0),
(8742,17,-5358.76,-2984.13,324.552,0,0,0,0,0),
(8742,18,-5371.16,-2994.94,328.932,0,0,0,0,0),
(8742,19,-5361.08,-2986.07,325.003,0,0,0,0,0),
(8742,20,-5346.79,-2982.49,323.927,0,0,0,0,0),
(8742,21,-5338.73,-2987.41,323.931,0,0,0,0,0),
(8742,22,-5340.02,-2994,323.655,0,0,0,0,0),
(8742,23,-5340.75,-3010.79,324.108,0,0,0,0,0),
(8742,24,-5343.91,-3011.72,324.257,0,0,0,0,0),
(8742,25,-5348.24,-3012.78,326.232,0,0,0,0,0),
(8742,26,-5343.15,-3012.38,324.056,0,0,0,0,0),
(8742,27,-5340.65,-3007.47,324.071,0,0,0,0,0),
(8742,28,-5339.2,-2988.51,323.821,0,0,0,0,0),
(8742,29,-5349.9,-2965.89,324.026,0,0,0,0,0),
(8742,30,-5344.21,-2962.33,323.909,0,0,0,0,0),
(8742,31,-5335.43,-2960.58,325.959,0,0,0,0,0),
(8742,32,-5323.14,-2959.65,331.089,0,0,0,0,0),
(8742,33,-5313.22,-2956.49,333.68,0,0,0,0,0),
(8742,34,-5306.52,-2953.33,334.127,0,0,0,0,0),
(8742,35,-5317.66,-2952.92,332.948,0,0,0,0,0),
(8742,36,-5331.26,-2955.29,327.422,0,0,0,0,0),
(8742,37,-5341.59,-2956.78,324.044,0,0,0,0,0),
(8742,38,-5350.97,-2952.2,323.754,0,0,0,0,0),
(8742,39,-5359.27,-2942.62,324.853,0,0,0,0,0);

SET @GUID := 10593;
UPDATE `creature` SET `MovementType`='2', `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(10593,1,-2605.98,-2294.53,90.1834,0,0,0,0,0),
(10593,2,-2599.3,-2294.19,90.1834,0,0,0,0,0),
(10593,3,-2593.9,-2290.89,88.216,0,0,0,0,0),
(10593,4,-2593.32,-2285.17,86.0468,0,0,0,0,0),
(10593,5,-2595.42,-2277.21,86.0165,0,0,0,0,0),
(10593,6,-2607.02,-2274.33,86.0165,0,0,0,0,0),
(10593,7,-2613.51,-2284.33,86.0163,0,0,0,0,0),
(10593,8,-2612.99,-2289.62,88.1459,0,0,0,0,0),
(10593,9,-2608.98,-2293.16,90.1093,0,0,0,0,0);

SET @GUID := 15672;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (15672, 1, -670.405, -444.052, 31.6317, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 2, -660.506, -441.375, 31.5639, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 3, -655.451, -429.433, 31.5566, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 4, -658.611, -415.943, 31.6317, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 5, -670.15, -407.462, 31.6319, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 6, -684.337, -409.182, 31.629, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 7, -694.346, -420.741, 31.6318, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 8, -696.943, -430.143, 31.6318, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 9, -687.174, -441.478, 31.615, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (15672, 10, -671.317, -447.569, 31.6317, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 20102;
INSERT INTO `creature` VALUES (20102, 3258, 1, 1, 4745, 0, -1584.75, -1756.68, 94.2299, 4.16507, 275, 5, 0, 386, 0, 0, 2);
SET @GUID := 20102;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (20102, 1, -1585.73, -1763.48, 94.4033, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 2, -1584.23, -1770.72, 94.5353, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 3, -1587.01, -1784.16, 94.6057, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 4, -1597.84, -1798.65, 94.123, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 5, -1612.62, -1805.75, 93.7835, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 6, -1625.09, -1807.49, 92.7887, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 7, -1642.47, -1800.45, 91.672, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 8, -1651.48, -1787.24, 91.6669, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 9, -1653.96, -1772.09, 91.6669, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 10, -1640.56, -1773.2, 91.6669, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 11, -1630.07, -1780.61, 91.6669, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 12, -1613.45, -1780.63, 91.7194, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 13, -1603.47, -1781.84, 93.1374, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 14, -1591.12, -1781.98, 94.5722, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 15, -1590.12, -1781.48, 94.5951, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 16, -1574.82, -1768.56, 94.8246, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 17, -1571.66, -1755.69, 94.1852, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 18, -1578.28, -1739.92, 92.6243, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 19, -1592.01, -1731.08, 92.7012, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 20, -1599.28, -1732.52, 93.2406, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (20102, 21, -1588.46, -1748.98, 93.9693, 0, 0, 0, 0, 0);

SET @GUID := 56348;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (56348, 1, -2287.88, 5221.7, -9.98743, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (56348, 2, -2287.88, 5221.7, -9.98743, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (56348, 3, -2271.06, 5218.77, -9.98373, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (56348, 4, -2257.39, 5205.93, -9.98758, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (56348, 5, -2240, 5194.25, -10.4829, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (56348, 6, -2240, 5194.25, -10.4829, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (56348, 7, -2260.97, 5210.73, -9.98946, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (56348, 8, -2275.19, 5220.14, -9.98464, 0, 0, 0, 0, 0);

UPDATE `creature_template_addon` SET `path_id` = 0 WHERE `entry` = 17496;
DELETE FROM `creature_addon` WHERE `guid` = 63004;
INSERT INTO `creature_addon` VALUES (63004, 63004, 0, 16908544, 0, 4097, 0, 0, NULL);

UPDATE `creature_template_addon` SET `path_id` = 0 WHERE `entry` = 3068;
DELETE FROM `creature_addon` WHERE `guid` = 26908;
INSERT INTO `creature_addon` VALUES (26908, 26908, 0, 0, 0, 4097, 0, 0, '');

UPDATE `creature_template_addon` SET `path_id` = 0 WHERE `entry` = 17664;
DELETE FROM `creature_addon` WHERE `guid` = 63387;
INSERT INTO `creature_addon` VALUES (63387, 63387, 2346, 512, 0, 4097, 0, 0, NULL);

UPDATE `creature_template_addon` SET `path_id` = 0 WHERE `entry` = 22060;
DELETE FROM `creature_addon` WHERE `guid` = 77280;
INSERT INTO `creature_addon` VALUES (77280, 77280, 0, 16843008, 33554432, 4097, 0, 0, '34189 0');

SET @GUID := 83477;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (83477, 1, 2635.52, 682.289, 54.7766, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 2, 2638.17, 696.646, 55.8434, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 3, 2636.67, 708.608, 56.0377, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 4, 2623.08, 723.656, 55.638, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 5, 2612.12, 737.482, 55.7181, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 6, 2610.67, 752.921, 56.4109, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 7, 2615.43, 768.168, 56.5572, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 8, 2627.93, 780.921, 57.3552, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 9, 2641.7, 792.294, 58.0251, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 10, 2648.2, 810.258, 59.4304, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 11, 2647.24, 810.07, 59.4602, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 12, 2642.72, 792.735, 58.1111, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 13, 2630.25, 782.713, 57.4952, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 14, 2613.78, 765.981, 56.4382, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 15, 2610.81, 742.183, 56.1014, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 16, 2617.28, 726.713, 55.4612, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 17, 2634.57, 709.866, 56.0608, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 18, 2638.19, 696.127, 55.8127, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 19, 2635.68, 682.366, 54.7789, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83477, 20, 2629.07, 664.327, 54.274, 0, 0, 0, 100, 0);

DELETE FROM `creature_addon` WHERE `guid` = 96592;
INSERT INTO `creature_addon` VALUES (96592, 96592, 0, 16777472, 0, 4096, 0, 0, NULL);

SET @GUID := 96594;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (96594, 1, -1918.05, 5334.41, -12.428, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 2, -1918.05, 5334.41, -12.428, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 3, -1918.05, 5334.41, -12.428, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 4, -1918.05, 5334.41, -12.428, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 5, -1918.05, 5334.41, -12.428, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 6, -1918.05, 5334.41, -12.428, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 7, -1918.05, 5334.41, -12.428, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 8, -1918.05, 5334.41, -12.428, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 9, -1918.05, 5334.41, -12.428, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96594, 10, -1918.05, 5334.41, -12.428, 60000, 0, 0, 0, 0);

-- Needs Adjustments
SET @GUID := 96619;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (96619, 1, -1835.49, 5313.03, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 2, -1841.81, 5311.87, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 3, -1842.62, 5313.06, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 4, -1842.62, 5313.06, -12.4282, 30000, 0, 0, 100, 0); -- 2513801
INSERT INTO `waypoint_data` VALUES (96619, 5, -1845.9, 5310.6, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 6, -1850.46, 5310.65, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 7, -1852.19, 5314.11, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 8, -1852.19, 5314.11, -12.4282, 30000, 0, 0, 100, 0); -- 2513802
INSERT INTO `waypoint_data` VALUES (96619, 9, -1850.97, 5318.61, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 10, -1843, 5320.51, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 11, -1840.26, 5319.29, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 12, -1840.26, 5319.29, -12.4282, 30000, 0, 0, 100, 0); -- 2513801
INSERT INTO `waypoint_data` VALUES (96619, 13, -1835.4, 5320.18, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 14, -1835.03, 5317.27, -12.4282, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (96619, 15, -1835.03, 5317.27, -12.4282, 30000, 0, 0, 100, 0); -- 2513802

SET @GUID := 97110;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (97110, 1, -8764.87, 847.11, 87.2577, 0, 1, 0, 100, 0); -- 9711001
INSERT INTO `waypoint_data` VALUES (97110, 2, -8764.87, 847.11, 87.2577, 6000, 0, 0, 100, 0); -- 9711002
INSERT INTO `waypoint_data` VALUES (97110, 3, -8764.87, 847.11, 87.2577, 0, 0, 0, 100, 0); -- 9711003
INSERT INTO `waypoint_data` VALUES (97110, 4, -8764.87, 847.11, 87.2577, 233000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97110, 5, -8764.87, 847.11, 87.2577, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97110, 6, -8767.81, 845.135, 88.5791, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97110, 7, -8771.36, 841.955, 90.3736, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97110, 8, -8775.25, 838.443, 92.3464, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97110, 9, -8780.41, 835.036, 94.6678, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97110, 10, -8789.37, 827.108, 97.6443, 0, 0, 0, 100, 0);

SET @GUID := 97111;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (97111, 1, -8764.18, 846.946, 87.0923, 60000, 1, 0, 100, 0); -- 9711001
INSERT INTO `waypoint_data` VALUES (97111, 2, -8764.18, 846.946, 87.0923, 6000, 0, 0, 100, 0); -- 9711002
INSERT INTO `waypoint_data` VALUES (97111, 3, -8764.18, 846.946, 87.0923, 0, 0, 0, 100, 0); -- 9711003
INSERT INTO `waypoint_data` VALUES (97111, 4, -8764.18, 846.946, 87.0923, 174000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97111, 5, -8764.18, 846.946, 87.0923, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97111, 6, -8766.69, 844.125, 88.4861, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97111, 7, -8770.97, 840.874, 90.511, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97111, 8, -8775.98, 836.386, 93.0448, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97111, 9, -8779.09, 833.919, 94.5413, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97111, 10, -8788.55, 825.631, 97.6435, 0, 0, 0, 100, 0);

SET @GUID := 97112;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (97112, 1, -8764.17, 846.22, 87.2574, 120000, 1, 0, 100, 0); -- 9711001
INSERT INTO `waypoint_data` VALUES (97112, 2, -8764.17, 846.22, 87.2574, 6000, 0, 0, 100, 0); -- 9711002
INSERT INTO `waypoint_data` VALUES (97112, 3, -8764.17, 846.22, 87.2574, 0, 0, 0, 100, 0); -- 9711003
INSERT INTO `waypoint_data` VALUES (97112, 4, -8764.17, 846.22, 87.2574, 115000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97112, 5, -8764.17, 846.22, 87.2574, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97112, 6, -8768.75, 841.352, 89.7436, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97112, 7, -8773.94, 837.223, 92.2453, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97112, 8, -8779.93, 831.68, 95.316, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97112, 9, -8788.56, 825.087, 97.6439, 0, 0, 0, 100, 0);

SET @GUID := 97113;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (97113, 1, -8763.14, 845.686, 87.0814, 180000, 1, 0, 100, 0); -- 9711001
INSERT INTO `waypoint_data` VALUES (97113, 2, -8763.14, 845.686, 87.0814, 6000, 0, 0, 100, 0); -- 9711002
INSERT INTO `waypoint_data` VALUES (97113, 3, -8763.14, 845.686, 87.0814, 0, 0, 0, 100, 0); -- 9711003
INSERT INTO `waypoint_data` VALUES (97113, 4, -8763.14, 845.686, 87.0814, 56700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97113, 5, -8763.14, 845.686, 87.0814, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97113, 6, -8770.88, 840.53, 90.5654, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97113, 7, -8776.35, 837.9, 92.7992, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97113, 8, -8781.09, 834.758, 94.9354, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97113, 9, -8783.9, 830.873, 96.6753, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (97113, 10, -8790.4, 827.703, 97.6425, 0, 0, 0, 100, 0);

SET @GUID := 98200;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'36151 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (98200, 1, 74.0433, -68.8504, -2.7532, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98200, 2, 29.3908, -30.3243, -2.7497, 0, 1, 0, 100, 0);

DELETE FROM `creature_template_addon` WHERE `entry` IN (17724,20185);
INSERT INTO `creature_template_addon` VALUES 
(17724,0,0,0,0,4097,0,0,'36151 0'),
(20185,0,0,0,0,4097,0,0,'36151 0');

SET @GUID:= 98209;
UPDATE `creature` SET `MovementType`='2', `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'36151 0');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,'27.2480','-194.4162','-4.2727',0,1,0,100,0),
(@GUID,2,'56.4067','-171.6072','-3.3128',0,1,0,100,0),
(@GUID,3,'11.1139','-207.1972','-4.5332',0,1,0,100,0),
(@GUID,4,'-3.5688','-205.4432','-4.5332',0,1,0,100,0),
(@GUID,5,'-9.2726','-220.6104','-4.5332',0,1,0,100,0),
(@GUID,6,'14.8130','-222.3226','-4.5332',0,1,0,100,0),
(@GUID,7,'11.1139','-207.1972','-4.5332',0,1,0,100,0);

SET @GUID := 98211;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'36151 0');
DELETE FROM `waypoint_data` WHERE `id` IN (1316, @GUID);
INSERT INTO `waypoint_data` VALUES (98211, 1, -78.2187, -278.08, -1.29024, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 2, -101.42, -287.156, 1.83909, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 3, -117.784, -281.744, 6.29074, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 4, -114.828, -265.574, 14.1106, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 5, -100.356, -256.529, 24.1543, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 6, -94.5013, -260.984, 23.5905, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 7, -111.209, -322.297, 31.7191, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 8, -92.9906, -259.027, 23.2777, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 9, -104.135, -255.064, 24.1181, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 10, -117.155, -271.564, 9.91377, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 11, -120.779, -289.544, 4.69137, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 12, -100.661, -289.117, 1.68816, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 13, -82.6219, -280.77, -0.527521, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98211, 14, -62.776, -265.349, -4.53726, 0, 1, 0, 100, 0);

SET @GUID := 98225;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` IN (1330, @GUID);
INSERT INTO `waypoint_data` VALUES (98225, 1, 337.392, -369.792, 37.5788, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98225, 2, 340.685, -352.773, 30.5923, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98225, 3, 325.793, -326.49, 19.6275, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98225, 4, 282.261, -299.356, 19.1603, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98225, 5, 270.244, -282.533, 24.1691, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98225, 6, 290.544, -301.37, 18.3725, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98225, 7, 325.27, -324.578, 19.2048, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98225, 8, 336.507, -346.866, 28.18, 0, 0, 0, 100, 0);

SET @GUID := 98234;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'36151 0');
DELETE FROM `waypoint_data` WHERE `id` IN (1329, @GUID);
INSERT INTO `waypoint_data` VALUES (98234, 1, 266.995, -202.99, 28.7592, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98234, 2, 268.777, -256.844, 26.6499, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98234, 3, 268.675, -203.632, 28.8667, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (98234, 4, 249.744, -147.077, 28.5912, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `guid` IN (140698,140699,140700,4538452);
DELETE FROM `waypoint_data` WHERE `id` = 8989;
UPDATE `creature_template_addon` SET `path_id` = 0 WHERE `entry` = 18733;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1940;
INSERT INTO `creature_ai_scripts` VALUES (194001, 1940, 0, 0, 75, 1, 5000, 5000, 20000, 40000, 11, 3256, 4, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Rot Hide Plague Weaver - Cast Plague Cloud');
INSERT INTO `creature_ai_scripts` VALUES (194002, 1940, 0, 0, 40, 0, 0, 0, 2500, 2500, 11, 3237, 1, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Rot Hide Plague Weaver - Cast Curse of Thule');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1868;
INSERT INTO `creature_ai_scripts` VALUES (186801, 1868, 2, 0, 85, 1, 65, 0, 22000, 22000, 11, 7290, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenclaw Servant - Cast Soul Siphon');
INSERT INTO `creature_ai_scripts` VALUES (186802, 1868, 0, 0, 85, 1, 4000, 4000, 24000, 28000, 11, 980, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenclaw Servant - Cast Curse of Agony');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1947;
INSERT INTO `creature_ai_scripts` VALUES (194701, 1947, 0, 0, 85, 1, 5000, 5000, 20000, 30000, 11, 7655, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - Cast Hex of Ravenclaw');
INSERT INTO `creature_ai_scripts` VALUES (194702, 1947, 0, 0, 85, 1, 1000, 1000, 7000, 12000, 11, 20800, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - Cast Immolate');
INSERT INTO `creature_ai_scripts` VALUES (194703, 1947, 1, 0, 100, 0, 0, 0, 1000, 1000, 11, 11939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - Reset Summon Imp');
INSERT INTO `creature_ai_scripts` VALUES (194704, 1947, 1, 0, 100, 1, 1000, 1000, 1800000, 1800000, 11, 13787, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thule Ravenclaw - Cast Demon Armor on Spawn');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 2255;
INSERT INTO `creature_ai_scripts` VALUES (225501, 2255, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Prevent Combat Movement on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (225502, 2255, 4, 0, 10, 0, 0, 0, 0, 0, 1, -359, -360, -361, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Random Say on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (225503, 2255, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9672, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Cast Frostbolt and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (225504, 2255, 9, 5, 100, 1, 0, 40, 3500, 4800, 11, 9672, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Cast Frostbolt (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (225505, 2255, 3, 5, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (225506, 2255, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Start Combat Movement at 35 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (225507, 2255, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Prevent Combat Movement at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (225508, 2255, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Start Combat Movement Below 5 Yards');
INSERT INTO `creature_ai_scripts` VALUES (225509, 2255, 3, 3, 100, 1, 100, 30, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Set Phase 1 when Mana is above 30% (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES (225510, 2255, 0, 0, 100, 1, 5300, 7400, 11300, 21200, 11, 6742, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Cast Bloodlust');
INSERT INTO `creature_ai_scripts` VALUES (225511, 2255, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Crushridge Mage - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 2283;
INSERT INTO `creature_ai_scripts` VALUES (228301, 2283, 0, 0, 85, 1, 3000, 3000, 9000, 12000, 11, 970, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenclaw Regent - Cast Shadow Word: Pain 3');
INSERT INTO `creature_ai_scripts` VALUES (228302, 2283, 0, 0, 85, 1, 6000, 6000, 12000, 18000, 11, 7645, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Ravenclaw Regent - Cast Dominate Mind');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 2319;
INSERT INTO `creature_ai_scripts` VALUES (231901, 2319, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Prevent Combat Movement on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (231902, 2319, 1, 0, 100, 1, 1000, 1000, 1800000, 1800000, 11, 12544, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Cast Frost Armor on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (231903, 2319, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20815, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Cast Fireball and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (231904, 2319, 9, 5, 100, 1, 0, 40, 3500, 5400, 11, 20815, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Cast Fireball (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (231905, 2319, 3, 5, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (231906, 2319, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Start Combat Movement at 35 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (231907, 2319, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Prevent Combat Movement at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (231908, 2319, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Start Combat Movement Below 5 Yards');
INSERT INTO `creature_ai_scripts` VALUES (231909, 2319, 3, 3, 100, 1, 100, 30, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Set Phase 1 when Mana is above 30% (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES (231910, 2319, 0, 0, 100, 1, 5000, 9000, 25000, 35000, 11, 12824, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Cast Polymorph');
INSERT INTO `creature_ai_scripts` VALUES (231911, 2319, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Syndicate Wizard - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16905;
INSERT INTO `creature_ai_scripts` VALUES (1690501, 16905, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Prevent Combat Movement and Set Phase 1 on OOC');
INSERT INTO `creature_ai_scripts` VALUES (1690502, 16905, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9053, 1, 0, 22, 1, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Cast Fireball and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (1690503, 16905, 9, 13, 100, 1, 0, 40, 3000, 3800, 11, 9053, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Cast Fireball (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1690504, 16905, 3, 13, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1690505, 16905, 9, 13, 100, 1, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Start Combat Movement at 35 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1690506, 16905, 9, 13, 100, 1, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Prevent Combat Movement at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1690507, 16905, 9, 13, 100, 1, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Start Combat Movement Below 5 Yards');
INSERT INTO `creature_ai_scripts` VALUES (1690508, 16905, 0, 13, 100, 1, 5000, 9000, 12000, 15000, 11, 11829, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Cast Flamestrike (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1690509, 16905, 3, 11, 100, 1, 100, 30, 1000, 1000, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Set Phase 1 when Mana is above 30% (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES (1690510, 16905, 2, 0, 100, 0, 15, 0, 0, 0, 11, 11831, 0, 1, 22, 3, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Cast Frost Nova and Set Phase 3 at 15% HP');
INSERT INTO `creature_ai_scripts` VALUES (1690511, 16905, 2, 7, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0, 'Unyielding Sorcerer - Start Combat Movement and Flee at 15% HP (Phase 3)');
INSERT INTO `creature_ai_scripts` VALUES (1690512, 16905, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Unyielding Sorcerer - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19705;
INSERT INTO `creature_ai_scripts` VALUES (1970501, 19705, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Prevent Combat Movement and Prevent Melee on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (1970502, 19705, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6660, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Cast Shoot and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (1970503, 19705, 9, 5, 100, 1, 5, 30, 2300, 3900, 11, 6660, 1, 0, 40, 2, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Cast Shoot and Set Ranged Weapon Model (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970504, 19705, 9, 5, 100, 1, 0, 50, 9000, 12000, 11, 35964, 1, 1, 40, 2, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Cast Frost Arrow and Set Ranged Weapon Model (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970505, 19705, 9, 5, 100, 1, 25, 80, 0, 0, 21, 1, 1, 0, 20, 1, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Start Combat Movement and Start Melee at 25 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970506, 19705, 9, 5, 100, 1, 0, 5, 0, 0, 21, 1, 0, 0, 40, 1, 0, 0, 20, 1, 0, 0, 'Master Daellis Dawnstrike - Start Combat Movement and Set Melee Weapon Model and Start Melee Below 5 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970507, 19705, 9, 5, 100, 1, 5, 15, 0, 0, 21, 1, 1, 0, 20, 0, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Prevent Combat Movement and Prevent Melee at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970508, 19705, 9, 0, 100, 1, 0, 5, 16000, 21000, 11, 35963, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Cast Improved Wing Clip');
INSERT INTO `creature_ai_scripts` VALUES (1970509, 19705, 2, 0, 100, 0, 15, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Set Phase 2 at 15% HP');
INSERT INTO `creature_ai_scripts` VALUES (1970510, 19705, 2, 3, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0, 'Master Daellis Dawnstrike - Start Combat Movement and Flee at 15% HP (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES (1970511, 19705, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 'Master Daellis Dawnstrike - Set Phase to 0 and Set Melee Weapon Model on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19707;
INSERT INTO `creature_ai_scripts` VALUES (1970701, 19707, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Prevent Combat Movement and Prevent Melee on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (1970702, 19707, 4, 0, 100, 0, 0, 0, 0, 0, 11, 6660, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Cast Shoot and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (1970703, 19707, 9, 5, 100, 1, 5, 30, 2300, 3900, 11, 6660, 1, 0, 40, 2, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Cast Shoot and Set Ranged Weapon Model (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970704, 19707, 9, 5, 100, 1, 10, 40, 9000, 12000, 11, 37847, 1, 1, 40, 2, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Cast Immolation Arrow and Set Ranged Weapon Model (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970705, 19707, 9, 5, 100, 1, 25, 80, 0, 0, 21, 1, 1, 0, 20, 1, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Start Combat Movement and Start Melee at 25 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970706, 19707, 9, 5, 100, 1, 0, 5, 0, 0, 21, 1, 0, 0, 40, 1, 0, 0, 20, 1, 0, 0, 'Sunfury Archer - Start Combat Movement and Set Melee Weapon Model and Start Melee Below 5 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970707, 19707, 9, 5, 100, 1, 5, 15, 0, 0, 21, 1, 1, 0, 20, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Prevent Combat Movement and Prevent Melee at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1970708, 19707, 9, 0, 100, 1, 0, 20, 12000, 15000, 11, 12024, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Cast Net');
INSERT INTO `creature_ai_scripts` VALUES (1970709, 19707, 2, 0, 100, 0, 15, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Set Phase 2 at 15% HP');
INSERT INTO `creature_ai_scripts` VALUES (1970710, 19707, 2, 3, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0, 'Sunfury Archer - Start Combat Movement and Flee at 15% HP (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES (1970711, 19707, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 'Sunfury Archer - Set Phase to 0 and Set Melee Weapon Model on Evade');

-- Fix Cannons Moveable by CC Spells
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|4, `dynamicflags` = `dynamicflags`|8 WHERE `entry` IN (19067, 19210, 19399, 21233, 22443, 22451, 22461, 23076);
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (21233, 22451);
UPDATE `creature_template` SET `mechanic_immune_mask` = '12665366' WHERE `entry` IN (19067, 19210, 19399, 21233, 22443, 22451, 22461, 23076);

DELETE FROM `game_event_creature` WHERE `guid` = 152120;
INSERT INTO `game_event_creature` VALUES (152120, 26);

UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (79360, 79361);
DELETE FROM `creature_addon` WHERE `guid` IN (79360, 79361);
DELETE FROM `waypoint_data` WHERE `id` IN (79360, 79361);

UPDATE `creature_template` SET `npcflag` = 3 WHERE `entry` = 239; -- 2

-- https://github.com/Looking4Group/L4G_Core/issues/2069
-- http://www.wowhead.com/npc=20763/captured-protectorate-vanguard
INSERT IGNORE INTO `creature_questrelation` VALUES (20763,10425);
UPDATE `creature_template` SET `MovementType`=0 WHERE `entry`=20763;

-- Bugs below ground on each pull otherwise. This branch seems to be completely broken on the map. Move him to solid ground for now. Force disabling his mmap movement did not help.
UPDATE `creature` SET `position_x`=11005.211914, `position_y`=1903.362793, `position_z`=1333.655151 WHERE  `guid`=2672350; -- 11053/1921.37/1332.75

-- https://github.com/Looking4Group/L4G_Core/issues/3295
UPDATE `creature_template` SET `InhabitType`='3' WHERE  `entry`=3107;

-- https://github.com/Looking4Group/L4G_Core/issues/3291
DELETE FROM `game_event_creature` WHERE `guid` IN(152120,7370,12369);
INSERT INTO `game_event_creature` VALUES
(152120,26),
(7370,-26),
(12369,-26);

UPDATE `creature` SET `spawndist`=3 WHERE `guid`=44499;

-- Increase Spider Speed from too low values
UPDATE `creature_template` SET `speed` = 0.90 WHERE `entry` IN (30,43,1986);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 5617;
INSERT INTO `creature_ai_scripts` VALUES
('561701','5617','1','0','100','0','1000','1000','0','0','11','12746','0','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Summon Voidwalker on Spawn'),
('561702','5617','4','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Set Phase 1 on Aggro'),
('561703','5617','9','13','100','1','8','40','3000','4000','11','20825','1','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Cast Shadow Bolt (Phase 1)'),
('561706','5617','3','13','100','0','7','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Set Phase 2 when Mana is at 7% (Phase 1)'),
('561707','5617','3','11','100','1','100','15','1000','1000','22','1','0','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Set Phase 1 when Mana is above 15% (Phase 2)'),
('561708','5617','0','0','100','1','7600','12800','14600','30200','11','20826','4','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Cast Immolate'),
('561709','5617','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Set Phase 3 at 15% HP'),
('561710','5617','2','7','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Wastewander Shadow Mage - Flee at 15% HP (Phase 3)'),
('561711','5617','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Wastewander Shadow Mage - Set Phase to 0 on Evade');

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 8996;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 8996;
INSERT INTO `creature_ai_scripts` VALUES
('899601','8996','7','0','100','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Voidwalker Minion - Despawn on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 3715;
INSERT INTO `creature_ai_scripts` VALUES (371501, 3715, 9, 0, 100, 1, 0, 30, 3200, 5000, 11, 8598, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathtail Sea Witch - Cast Lightning Blast');
INSERT INTO `creature_ai_scripts` VALUES (371502, 3715, 9, 0, 100, 1, 0, 10, 20900, 33500, 11, 2691, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathtail Sea Witch - Cast Mana Burn');
INSERT INTO `creature_ai_scripts` VALUES (371503, 3715, 2, 0, 100, 0, 15, 0, 0, 0, 25, 0, 0, 0,1, -47, 0, 0, 0, 0, 0, 0, 'Wrathtail Sea Witch - Flee at 15% HP');

DELETE FROM `gameobject` WHERE `id` IN (181248,181249);
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` IN (103711,3764,1732,2054,176643,150082,324,1733,105569,175404,123848,73940,177388,73941,1667,1610,181109,150080,1734,103713,3763,2055,1731,123309,123310,73939,176645,150079,2040,2653,1735,165658,181108,150081,2047) AND `map` IN (0,1,530);

-- Eliza's Guard 1871
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 1871;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1871;
INSERT INTO `creature_ai_scripts` VALUES ('187101','1871','1','0','100','0','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Eliza\'s Guard - Despawn OOC');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 314;
INSERT INTO `creature_ai_scripts` VALUES (31401, 314, 1, 0, 100, 0, 0, 0, 0, 0, 11, 26047, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Cast Birth on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (31402, 314, 1, 0, 100, 0, 500, 500, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Prevent Combat Movement on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (31403, 314, 0, 0, 100, 0, 1000, 1000, 0, 0, 1, -460, -461, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Say on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (31404, 314, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20819, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Eliza - Cast Frostbolt and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (31405, 314, 9, 5, 100, 1, 0, 40, 3400, 5000, 11, 20819, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Cast Frostbolt (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (31406, 314, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Eliza - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (31407, 314, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Start Combat Movement at 35 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (31408, 314, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Prevent Combat Movement at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (31409, 314, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Start Combat Movement Below 5 Yards');
INSERT INTO `creature_ai_scripts` VALUES (31410, 314, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Set Phase 1 when Mana is above 15% (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES (31411, 314, 0, 0, 100, 1, 4100, 6400, 72300, 72300, 11, 3107, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Summon Eliza\'s Guard');
INSERT INTO `creature_ai_scripts` VALUES (31412, 314, 9, 0, 100, 1, 0, 8, 12500, 36300, 11, 11831, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Cast Frost Nova');
INSERT INTO `creature_ai_scripts` VALUES (31413, 314, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eliza - Set Phase to 0 on Evade');
INSERT INTO `creature_ai_scripts` VALUES ('31414','314','1','0','100','0','15000','15000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Eliza - Despawn OOC');

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181555;
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` = 181555 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181569;
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` = 181569 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181570;
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` = 181570 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181556;
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` = 181556 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181557;
UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `id` = 181557 AND `map` IN (0, 1, 530);

-- Outland Dungeon Ores
UPDATE `gameobject` SET `spawntimesecs` = 86400 WHERE `guid` IN (3497242, 3497243, 3497128, 3497127, 3489213, 3486610, 3496020, 3486611, 3494261, 3497219, 3497218, 3489285, 3497216, 3497215, 3497208, 3497207, 3497206, 3497211, 3497212, 3496019, 3497213, 3497214, 3497217, 3497209, 3493144, 3493145, 3497210, 3497966, 3497334, 3497333, 3497331, 3497330, 3497332);

UPDATE `gameobject` SET `spawntimesecs`= 300,`animprogress`= 255 WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181279,181280,181281,181284,181285,185877,185881) AND `map`= 530; -- 2700

UPDATE `creature` SET `position_x` = '1056.6199', `position_y` = '-2828.1201', `position_z` = '42.0509' WHERE `guid` = 11352;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17414;
INSERT INTO `creature_ai_scripts` VALUES
('1741401','17414','9','0','100','3','0','5','7000','14900','11','30846','0','0','1','-155','0','0','0','0','0','0','Shadowmoon Technician (Normal) - Throw Proximity Bomb'),
('1741402','17414','9','0','100','5','0','5','7000','14900','11','32784','0','0','1','-155','0','0','0','0','0','0','Shadowmoon Technician (Heroic) - Throw Proximity Bomb'),
('1741403','17414','9','0','100','3','0','25','3600','6200','11','40062','4','0','0','0','0','0','0','0','0','0','Shadowmoon Technician (Normal) - Cast Throw Dynamite'),
('1741404','17414','9','0','100','5','0','25','3600','6200','11','40064','4','0','0','0','0','0','0','0','0','0','Shadowmoon Technician (Heroic) - Cast Throw Dynamite'),
('1741405','17414','0','0','100','7','6000','6000','12000','18000','11','6726','4','32','0','0','0','0','0','0','0','0','Shadowmoon Technician - Cast Silence'),
('1741406','17414','4','0','100','6','0','0','0','0','11','29651','0','0','0','0','0','0','0','0','0','0','Shadowmoon Technician - Casts Dual Wield on Aggro');

UPDATE `creature_template` SET `mindmg`='815',`maxdmg`='1061' WHERE `entry` = 17381;

UPDATE `creature_template` SET `mindmg`='525',`maxdmg`='600' WHERE `entry` = 17377;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21979;
INSERT INTO `creature_ai_scripts` VALUES (2197901, 21979, 4, 0, 100, 0, 0, 0, 0, 0, 11, 38094, 1, 0, 22, 1, 0, 0, 40, 2, 0, 0, 'Val\'zareq the Conqueror - Cast Shoot and Set Phase 1 and Set Ranged Weapon Model on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2197902, 21979, 9, 13, 100, 1, 0, 40, 2200, 4700, 11, 38094, 1, 0, 40, 2, 0, 0, 0, 0, 0, 0, 'Val\'zareq the Conqueror - Cast Shoot and Set Ranged Weapon Model (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (2197903, 21979, 9, 13, 100, 1, 0, 35, 4400, 9400, 11, 36623, 1, 0, 40, 2, 0, 0, 0, 0, 0, 0, 'Val\'zareq the Conqueror - Cast Arcane Shot and Set Ranged Weapon Model (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (2197904, 21979, 9, 0, 100, 7, 0, 5, 0, 0, 40, 1, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 'Val\'zareq the Conqueror - Set Melee Weapon Model in Melee Range');
INSERT INTO `creature_ai_scripts` VALUES (2197905, 21979, 2, 0, 100, 0, 15, 0, 0, 0, 22, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Val\'zareq the Conqueror - Set Phase 3 at 15% HP');
INSERT INTO `creature_ai_scripts` VALUES (2197906, 21979, 2, 7, 100, 0, 15, 0, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0, 0, 0, 0, 0, 'Val\'zareq the Conqueror - Flee at 15% HP (Phase 3)');
INSERT INTO `creature_ai_scripts` VALUES (2197907, 21979, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Val\'zareq the Conqueror - Set Phase 0 on Evade');

UPDATE `creature_template` SET `baseattacktime` = 2000 WHERE `entry` = 17770;
UPDATE `creature_template` SET `baseattacktime` = 2000 WHERE `entry` = 20169;

DELETE FROM `creature_questrelation` WHERE `quest` IN (10339,10969);
INSERT INTO `creature_questrelation` VALUES (20448, 10339);

-- Arcane Wraith 15273
UPDATE `creature_template` SET `mindmg` = 2, `maxdmg` = 4 WHERE `entry` = 15273; -- 1 3

-- extreme lowlevel npcs
UPDATE `creature_template` SET `mindmg` = 1, `maxdmg` = 2 WHERE `mindmg` <= 1 and `maxdmg` <= 2;
UPDATE `creature_template` SET `mindmg` = 1, `maxdmg` = 2 WHERE `entry` IN (1984,26207,3098,26020,22145,26238,2809,5002,15935,19031,21034);

UPDATE `creature_template` SET `minlevel` = 69, `maxlevel` = 70, `armor`= 6800 WHERE `entry` = 17695;

UPDATE `creature_template` SET `minlevel` = 70, `maxlevel` = 70, `armor` = 6800 WHERE `entry` = 17671;

UPDATE `creature_template` SET `mindmg`='417',`maxdmg`='546', `baseattacktime` = 2000 WHERE `entry` = 18105;
UPDATE `creature_template` SET `mindmg`='3077',`maxdmg`='3654', `baseattacktime` = 2000 WHERE `entry` = 20168;

UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 731;

UPDATE `gameobject` SET `spawntimesecs` = 120 WHERE `guid` = 10830;
DELETE FROM `gameobject` WHERE `guid` IN (14054928,14054931,14054933,14054935,14054937,14054939,14054941,14054946);

UPDATE `creature_template` SET `baseattacktime` = 2000 WHERE `entry` = 17536;
UPDATE `creature_template` SET `baseattacktime` = 2000 WHERE `entry` = 18432;

UPDATE `creature_template` SET `mindmg`='437',`maxdmg`='862',`baseattacktime` = 2000 WHERE `entry` = 17537;

-- temp disable chests in azeroth
UPDATE `gameobject` SET `spawnmask` = 0 WHERE `id` IN (2855, 2857, 4149, 153454);

