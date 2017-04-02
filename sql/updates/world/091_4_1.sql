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

