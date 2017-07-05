SET @GUID:= 75461;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75461, 21637, 530, 1, 0, 0, 3252.08, 7044.69, 167.263, 0.139135, 300, 0, 0, 6326, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75461, 1, 3265.25, 7042.91, 167.129, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 2, 3275.63, 7048.38, 166.985, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 3, 3279.5, 7068.83, 169.085, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 4, 3274.82, 7083.26, 170.751, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 5, 3265.76, 7089.63, 171.828, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 6, 3257.59, 7091.71, 172.627, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 7, 3235.32, 7080.8, 172.287, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 8, 3231.25, 7075.87, 171.988, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 9, 3230.59, 7068.99, 172.021, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 10, 3235.76, 7048.08, 169.079, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 11, 3239.42, 7044.32, 168.695, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75461, 12, 3252.12, 7044.68, 166.902, 0, 0, 0, 0, 0);

SET @GUID:= 75462;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75462, 21637, 530, 1, 0, 0, 3266.03, 7086.22, 171.556, 4.72778, 300, 0, 0, 6326, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75462, 1, 3265.39, 7079.82, 171.094, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75462, 2, 3264.46, 7116.04, 170.977, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75462, 3, 3265.85, 7080.11, 171.078, 0, 0, 0, 0, 0);

SET @GUID:= 75463;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75463, 21637, 530, 1, 0, 0, 3241.11, 7108.95, 172.951, 0.213991, 300, 0, 0, 6326, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75463, 1, 3265.9, 7115.5, 170.901, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75463, 2, 3229.74, 7106.63, 173.692, 0, 0, 0, 0, 0);

SET @GUID:= 75464;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75464, 21637, 530, 1, 0, 0, 3264.48, 7146.38, 170.952, 1.53364, 300, 0, 0, 6326, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75464, 1, 3264.33, 7167.53, 168.836, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75464, 2, 3262.61, 7137.52, 170.871, 0, 0, 0, 0, 0);

SET @GUID:= 75465;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75465, 21637, 530, 1, 0, 0, 3243.84, 7128.38, 172.626, 3.44728, 300, 0, 0, 6326, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75465, 1, 3226.47, 7124.67, 173.354, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75465, 2, 3257.75, 7133.41, 170.708, 2000, 0, 0, 0, 0);

SET @GUID:= 75466;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75466, 21637, 530, 1, 0, 0, 3253.42, 7179.67, 166.954, 5.4971, 300, 0, 0, 6326, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75466, 1, 3265.43, 7171.59, 168.043, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75466, 2, 3241.92, 7187.97, 167.312, 0, 0, 0, 0, 0);

SET @GUID:= 75467;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75467, 21637, 530, 1, 0, 0, 3189.06, 7168.66, 163.699, 3.95068, 300, 0, 0, 6326, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75467, 1, 3186.85, 7163.8, 162.602, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75467, 2, 3196.61, 7186.72, 164.748, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75467, 3, 3220.13, 7196.03, 166.274, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75467, 4, 3194.01, 7178.35, 165.176, 0, 0, 0, 0, 0);

SET @GUID:= 75731;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75731, 21701, 530, 1, 0, 0, -3718.11, 1072.07, 56.8812, 6.26093, 300, 0, 0, 22680, 3155, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75731, 1, -3688.81, 1070.93, 56.7577, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75731, 2, -3750.32, 1072.48, 56.7722, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75731, 3, -3718.54, 1072.17, 56.8956, 0, 0, 0, 0, 0);

SET @GUID:= 75752;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75752, 21717, 530, 1, 0, 0, -4241.06, 494.309, 35.7766, 3.68838, 300, 0, 0, 6542, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75752, 1, -4232.93, 497.838, 32.2589, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 2, -4208.65, 503.912, 30.6221, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 3, -4196.17, 507.796, 28.9938, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 4, -4187.26, 521.639, 26.37, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 5, -4185.35, 530.539, 24.6807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 6, -4189.39, 535.697, 25.8128, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 7, -4196.17, 540.461, 27.0496, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 8, -4199.93, 541.858, 26.6138, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 9, -4202.98, 542.702, 27.9609, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 10, -4214.73, 545.492, 27.6582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 11, -4221.32, 555.178, 33.2942, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 12, -4219.15, 568.996, 34.5504, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 13, -4215.95, 577.92, 31.8378, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 14, -4223.09, 559.879, 35.1058, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 15, -4221.26, 552.028, 32.5337, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 16, -4215.49, 543.472, 27.7968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 17, -4203.13, 541.788, 27.8393, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 18, -4200.41, 541.324, 26.561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 19, -4191.43, 538.032, 26.0275, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 20, -4185.6, 528.89, 25.0139, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 21, -4190.33, 517.424, 26.8861, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 22, -4198.89, 505.739, 29.8313, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 23, -4227.24, 500.004, 31.7853, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 24, -4234.57, 498.074, 32.5379, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75752, 25, -4239.35, 494.285, 34.3929, 0, 0, 0, 0, 0);

SET @GUID:= 75767;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75767, 21717, 530, 1, 0, 0, -4168.55, 564.651, 14.3388, 2.70591, 300, 0, 0, 6542, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75767, 1, -4188.01, 575.999, 17.7299, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 2, -4198.01, 588.189, 19.0479, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 3, -4199.84, 593.628, 19.4664, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 4, -4195.01, 584.689, 18.1811, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 5, -4188.62, 577.609, 17.7295, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 6, -4175.71, 565.298, 16.4122, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 7, -4168.11, 561.899, 13.9787, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 8, -4155.91, 556.917, 12.1429, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 9, -4132.81, 546.087, 17.3503, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 10, -4109.65, 542.436, 18.3513, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 11, -4102.09, 537.567, 23.0019, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 12, -4099.59, 531.916, 27.4541, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 13, -4108.22, 542.361, 18.6051, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 14, -4135.8, 545.615, 16.8602, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 15, -4144.27, 549.55, 13.5834, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 16, -4158.3, 555.948, 12.4906, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75767, 17, -4166.08, 562.763, 13.6016, 0, 0, 0, 0, 0);

SET @GUID:= 76115;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76115, 21802, 530, 1, 0, 0, -3388, 1194.42, 60.5356, 2.13333, 300, 0, 0, 5409, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76115, 1, -3379.11, 1178.51, 58.7178, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 2, -3376.35, 1169.23, 55.2074, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 3, -3359.68, 1145.92, 53.2619, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 4, -3359.33, 1140.35, 52.3391, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 5, -3361.87, 1110.31, 51.1053, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 6, -3372.91, 1095.99, 46.6471, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 7, -3380.51, 1086.67, 47.8098, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 8, -3385.61, 1063.78, 45.3679, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 9, -3385.87, 1045.29, 44.0683, 30000, 0, 0, 100, 0); -- 2180802
INSERT INTO `waypoint_data` VALUES (76115, 10, -3383.7, 1078.22, 47.0486, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 11, -3372.8, 1092.31, 46.2517, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 12, -3365.84, 1103.95, 49.4862, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 13, -3362.1, 1136.98, 51.7193, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 14, -3367.61, 1148.27, 54.2922, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 15, -3370.16, 1160.22, 54.0023, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 16, -3374.54, 1179.33, 60.4819, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 17, -3381.82, 1185.49, 58.6327, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76115, 18, -3388.16, 1193.09, 59.7231, 30000, 0, 0, 100, 0); -- 2180802
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` = 76123;
DELETE FROM `creature_formations` WHERE `leaderguid` = 76115;
INSERT INTO `creature_formations` VALUES (76115,76115,0,0,2),(76115,76123,3,0,2);

SET @GUID:= 76119;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76119, 21802, 530, 1, 0, 0, -3228.41, 1052.62, 64.849, 2.475, 300, 0, 0, 5409, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76119, 1, -3259.26, 1072.83, 54.8839, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 2, -3272.78, 1094.41, 54.8716, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 3, -3280.44, 1109.07, 55.2712, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 4, -3282.25, 1143.33, 54.9262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 5, -3292.36, 1166.64, 58.4598, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 6, -3293.47, 1185.88, 61.1212, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 7, -3290.61, 1204.3, 64.5273, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 8, -3302.44, 1214.85, 69.6221, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 9, -3308.49, 1216.17, 72.1118, 30000, 0, 0, 100, 0); -- 2180802
INSERT INTO `waypoint_data` VALUES (76119, 10, -3292.32, 1205.35, 64.8642, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 11, -3286.25, 1165.4, 59.9408, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 12, -3283.86, 1150.46, 55.4015, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 13, -3281.51, 1111.11, 55.3331, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 14, -3257.25, 1072.29, 55.522, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 15, -3247.24, 1065.61, 59.0082, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 16, -3229.4, 1049.96, 64.0386, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 17, -3223.6, 1041.76, 62.8929, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 18, -3210.43, 1024.6, 68.3633, 30000, 0, 0, 100, 0); -- 2180802
INSERT INTO `waypoint_data` VALUES (76119, 19, -3222.49, 1042.6, 63.3029, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76119, 20, -3227.91, 1053.83, 65.1242, 0, 0, 0, 0, 0);
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` = 76127;
DELETE FROM `creature_formations` WHERE `leaderguid` = 76119;
INSERT INTO `creature_formations` VALUES (76119,76119,0,0,2),(76119,76127,3,0,2);

SET @GUID:= 76120;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76120, 21802, 530, 1, 0, 0, -3286.63, 964.17, 41.43, 6.035, 300, 0, 0, 5409, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76120, 1, -3264.56, 956.407, 44.0834, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 2, -3254.37, 955.421, 44.447, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 3, -3249, 956.924, 46.2156, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 4, -3243.16, 966.087, 49.847, 30000, 0, 0, 100, 0); -- 2180802
INSERT INTO `waypoint_data` VALUES (76120, 5, -3253.68, 955.537, 44.5803, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 6, -3266.88, 956.354, 43.7912, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 7, -3294.13, 963.64, 39.9235, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 8, -3302.23, 965.645, 35.4366, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 9, -3322.04, 975.571, 33.1319, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 10, -3338.73, 983.639, 31.113, 30000, 0, 0, 100, 0); -- 2180802
INSERT INTO `waypoint_data` VALUES (76120, 11, -3310.66, 973.82, 36.262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 12, -3301.89, 970.678, 35.8647, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 13, -3296.16, 968.426, 37.2491, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76120, 14, -3287.63, 963.147, 41.2303, 0, 0, 0, 0, 0);
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` = 76128;
DELETE FROM `creature_formations` WHERE `leaderguid` = 76120;
INSERT INTO `creature_formations` VALUES (76120,76120,0,0,2),(76120,76128,3,0,2);

SET @GUID:= 76167;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76167, 21808, 530, 1, 0, 0, -3355.4, 1174.93, 60.3469, 0.027337, 300, 0, 0, 6761, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76167, 1, -3308.4, 1178.67, 60.972, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 2, -3302.08, 1176.9, 58.4699, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 3, -3277.92, 1163.18, 60.7207, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 4, -3269.26, 1154.6, 58.9431, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 5, -3250.66, 1142.6, 60.0516, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 6, -3239.26, 1131.2, 63.2564, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 7, -3231.82, 1121.32, 64.8874, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 8, -3214.57, 1117.07, 69.0652, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 9, -3207.66, 1114.73, 71.7199, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 10, -3234.79, 1124.66, 63.9035, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 11, -3255.86, 1155.72, 58.6257, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 12, -3276.2, 1175.08, 61.2425, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 13, -3299.03, 1180.25, 59.428, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 14, -3334.88, 1175.26, 61.2751, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 15, -3359.92, 1173.9, 60.1825, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 16, -3391.86, 1171.35, 51.4148, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76167, 17, -3358.93, 1173.4, 60.1428, 0, 0, 0, 0, 0);

SET @GUID:= 76168;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76168, 21808, 530, 1, 0, 0, -3180.94, 1132.83, 78.5556, 0.257672, 300, 0, 0, 6761, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76168, 1, -3178.42, 1131.57, 77.7655, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 2, -3174.17, 1119.94, 73.6459, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 3, -3179.24, 1131.89, 78.1005, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 4, -3184.18, 1133.17, 78.4947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 5, -3193.66, 1128.78, 73.2561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 6, -3211.84, 1124.36, 70.9976, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 7, -3229.74, 1122.73, 65.6454, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 8, -3245.7, 1135.28, 61.8133, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 9, -3248.13, 1150.43, 57.8912, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 10, -3246.33, 1171.27, 58.0128, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 11, -3245.7, 1183.07, 58.2289, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 12, -3240.14, 1211.39, 66.0515, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 13, -3245.38, 1206.68, 64.6064, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 14, -3243.14, 1181.67, 57.2295, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 15, -3243.31, 1149.56, 57.3698, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 16, -3243.02, 1138.71, 61.4023, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 17, -3227.35, 1117.96, 66.4116, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 18, -3203.32, 1126.09, 72.5751, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 19, -3194.19, 1127.55, 72.5067, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 20, -3182.7, 1132.93, 78.6731, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76168, 21, -3179.76, 1131.43, 78.1285, 0, 0, 0, 0, 0);

SET @GUID:= 76169;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76169, 21808, 530, 1, 0, 0, -3250.86, 1104.4, 60.4245, 3.04173, 300, 0, 0, 6761, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76169, 1, -3277.61, 1105.5, 55.1733, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 2, -3285.27, 1111.13, 56.2405, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 3, -3305.33, 1125.33, 59.4396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 4, -3318.33, 1127.53, 60.1466, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 5, -3339.87, 1125.46, 57.064, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 6, -3354.29, 1114.77, 53.2102, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 7, -3370.59, 1083.4, 45.9588, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 8, -3378.09, 1077.26, 47.3137, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 9, -3386.03, 1076.46, 46.5369, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 10, -3370.59, 1081.59, 45.9528, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 11, -3353.4, 1117.64, 53.6212, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 12, -3334.57, 1129.47, 57.6868, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 13, -3311.61, 1129.57, 59.4793, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 14, -3305.19, 1126.8, 59.1115, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 15, -3291.06, 1116.42, 58.5582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 16, -3283.33, 1109.84, 55.5914, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 17, -3276.35, 1102.98, 55.0464, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 18, -3242.7, 1105.89, 61.5623, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 19, -3229.65, 1101.25, 66.3961, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76169, 20, -3246.55, 1103.62, 60.8973, 0, 0, 0, 0, 0);

SET @GUID:= 76170;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76170, 21808, 530, 1, 0, 0, -3270.78, 949.295, 43.0955, 3.26595, 300, 0, 0, 6761, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76170, 1, -3280.6, 947.888, 42.6272, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 2, -3288.21, 944.545, 38.954, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 3, -3302.84, 939.51, 36.424, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 4, -3309.41, 934.472, 36.0443, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 5, -3318.15, 928.217, 32.3918, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 6, -3331.99, 922.586, 31.7365, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 7, -3322.16, 925.744, 31.296, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 8, -3310.37, 936.74, 35.3425, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 9, -3302.37, 940.933, 36.1796, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 10, -3287.18, 946.728, 39.5706, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 11, -3283.28, 952.706, 41.143, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 12, -3276.21, 953.964, 42.1101, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 13, -3261.06, 948.93, 42.9136, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 14, -3246.8, 947.155, 44.7651, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 15, -3234.86, 942.679, 48.2091, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 16, -3247.76, 948.391, 44.7988, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 17, -3260.35, 948.763, 43.0041, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76170, 18, -3269.56, 949.604, 42.7369, 0, 0, 0, 0, 0);

SET @GUID:= 76171;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76171, 21808, 530, 1, 0, 0, -3287.04, 948.351, 39.7317, 0.009765, 300, 0, 0, 6761, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76171, 1, -3280.3, 957.403, 41.4696, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 2, -3257.59, 951.954, 43.4983, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 3, -3247.14, 945.764, 44.7965, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 4, -3238.19, 935.526, 46.3302, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 5, -3226.82, 916.186, 46.3998, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 6, -3225.4, 907.094, 44.9183, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 7, -3229.75, 895.431, 39.8892, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 8, -3245.4, 884.838, 32.106, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 9, -3281.53, 879.127, 13.899, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 10, -3321.82, 874.553, -7.36087, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 11, -3299.96, 876.675, 4.01488, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 12, -3262.06, 881.242, 22.869, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 13, -3246.28, 881.161, 31.5096, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 14, -3222.63, 896.762, 43.3892, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 15, -3219.84, 906.7, 46.661, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 16, -3220.26, 912.807, 46.5106, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 17, -3228.99, 931.71, 48.0305, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 18, -3244.93, 946.163, 45.1056, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 19, -3255.75, 953.24, 43.7815, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 20, -3278.82, 955.948, 41.7722, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 21, -3303.78, 945.419, 35.6887, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 22, -3325.15, 941.581, 32.7707, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76171, 23, -3290.05, 946.581, 38.6477, 0, 0, 0, 0, 0);

SET @GUID:= 76172;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76172, 21808, 530, 1, 0, 0, -3404.59, 861.869, -22.8115, 6.15592, 300, 0, 0, 6761, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76172, 1, -3363.99, 863.054, -17.928, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 2, -3336.72, 868.281, -14.4972, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 3, -3325.31, 867.909, -10.5469, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 4, -3305.19, 869.397, 2.16438, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 5, -3291.59, 870.047, 7.80878, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 6, -3273.02, 872.993, 17.7677, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 7, -3288.99, 868.781, 9.03969, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 8, -3308.33, 865.931, 0.661755, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 9, -3323.9, 866.267, -10.1088, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 10, -3336.14, 865.321, -15.1536, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 11, -3354.42, 863.811, -16.7995, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 12, -3363.89, 861.46, -18.165, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 13, -3375.57, 858.85, -18.0049, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 14, -3399.78, 862.753, -21.3708, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76172, 15, -3418.18, 871.94, -26.3409, 3000, 0, 0, 0, 0);

SET @GUID:= 76262;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76262, 21810, 530, 1, 0, 0, 3234.68, 6393.25, 131.117, 1.309, 300, 0, 0, 6116, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76262, 1, 3234.68, 6393.25, 131.117, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76262, 2, 3248.11, 6414.8, 139.107, 10000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76262, 3, 3234.68, 6393.25, 131.117, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76262, 4, 3222.07, 6365.31, 120.538, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76262, 5, 3219.33, 6345.78, 120.38, 10000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76262, 6, 3222.07, 6365.31, 120.538, 0, 0, 0, 0, 0);

SET @GUID:= 76801;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (76801, 21986, 530, 1, 0, 0, -3058.79, 794.144, -10.0661, 0.965849, 300, 0, 0, 15000, 3155, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (76801, 1, -3048.58, 811.772, -10.4179, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 2, -3048.34, 818.511, -10.4845, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 3, -3045.79, 823.876, -10.5028, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 4, -3037.01, 827.66, -10.4129, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 5, -3012.69, 855.806, -10.4971, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 6, -3007.02, 859.512, -9.04558, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 7, -2993.32, 863.408, -8.71289, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 8, -2987.23, 863.706, -8.63931, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 9, -2996.22, 863.37, -8.7418, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 10, -3006.27, 859.969, -8.90674, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 11, -3013.39, 856.758, -10.493, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 12, -3038.15, 827.185, -10.4295, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 13, -3044.78, 824.265, -10.5029, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 14, -3048.3, 818.94, -10.4888, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 15, -3048.79, 811.524, -10.4148, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 16, -3061.71, 790.621, -10.1069, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 17, -3067.3, 787.768, -10.1496, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 18, -3074.11, 788.496, -8.57641, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 19, -3067.02, 787.852, -10.1493, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 20, -3063, 789.95, -10.116, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (76801, 21, -3058.71, 794.269, -10.1038, 0, 0, 0, 0, 0);

SET @GUID:= 77084;
DELETE FROM `creature` WHERE `id` = 22006;
INSERT INTO `creature` VALUES (77084, 22006, 530, 1, 0, 0, -3225.12, 246.817, 195.679, 4.87723, 300, 0, 0, 83204, 18930, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77084, 1, -3225.12, 246.817, 195.679, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 2, -3240.03, 255.9, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 3, -3257.98, 269.678, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 4, -3274.72, 279.532, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 5, -3285.86, 310.516, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 6, -3275.1, 325.252, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 7, -3254.87, 341.812, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 8, -3227.61, 331.076, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 9, -3218.13, 316.963, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 10, -3217.59, 298.951, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 11, -3217.09, 283.996, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 12, -3207.64, 260.908, 203.19, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 13, -3212.76, 247.542, 203.19, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 14, -3220.4, 239.538, 203.19, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 15, -3252.73, 239.407, 172.163, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 16, -3266.67, 280.529, 161.968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 17, -3237.02, 300.281, 161.968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 18, -3205.82, 285.144, 183.413, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 19, -3205.76, 262.642, 184.707, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 20, -3213.83, 246.444, 194.429, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 21, -3225.12, 246.817, 195.679, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 22, -3240.03, 255.9, 201.579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77084, 23, -3257.98, 269.678, 201.579, 0, 0, 0, 0, 0);

SET @GUID:= 77197;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77197, 22040, 530, 1, 0, 0, 3113.81, 6200.3, 142.263, 1.19287, 300, 0, 0, 6920, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77197, 1, 3124.23, 6233.62, 136.97, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77197, 2, 3147.09, 6267.4, 135.472, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77197, 3, 3156.74, 6256.76, 139.877, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77197, 4, 3141.01, 6234.98, 131.415, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77197, 5, 3127.32, 6194.33, 139.273, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77197, 6, 3117.39, 6173.92, 149.005, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77197, 7, 3112.4, 6203.86, 140.679, 0, 0, 0, 0, 0);

SET @GUID:= 77198;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77198, 22040, 530, 1, 0, 0, 3135.4, 6236.62, 137.463, 2.63824, 300, 0, 0, 6920, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77198, 1, 3115.27, 6211.26, 159.97, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77198, 2, 3113.32, 6232.72, 157.375, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77198, 3, 3113.32, 6232.72, 157.375, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77198, 4, 3128.49, 6246.51, 159.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77198, 5, 3157.74, 6265.23, 153.897, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77198, 6, 3127.11, 6212.17, 145.774, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77198, 7, 3108.92, 6203.04, 156.09, 0, 0, 0, 0, 0);

SET @GUID:= 77199;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77199, 22040, 530, 1, 0, 0, 3205.48, 6290.76, 143.321, 4.46608, 300, 0, 0, 6920, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77199, 1, 3198.88, 6277.04, 149.718, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77199, 2, 3180.94, 6268.35, 157.716, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77199, 3, 3165.28, 6262.16, 156.564, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77199, 4, 3142.23, 6246.89, 150.136, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77199, 5, 3159.69, 6272.63, 134.671, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77199, 6, 3194.37, 6275.42, 134.083, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77199, 7, 3226.19, 6295.34, 131.692, 0, 0, 0, 0, 0);

SET @GUID:= 77200;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77200, 22040, 530, 1, 0, 0, 3206.03, 6297.4, 134.013, 1.46622, 300, 0, 0, 6920, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77200, 1, 3203.5, 6319.69, 137.047, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 2, 3201.96, 6338.33, 137.974, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 3, 3209.66, 6354.16, 133.517, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 4, 3220.84, 6355.37, 127.547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 5, 3221.17, 6331.7, 128.506, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 6, 3219.61, 6299.02, 127.619, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 7, 3205.93, 6277.75, 128.726, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 8, 3180.64, 6265.26, 127.438, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 9, 3164.07, 6259.64, 127.524, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 10, 3150.32, 6264.08, 132.687, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 11, 3162.77, 6271.1, 130.938, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 12, 3193.65, 6280.42, 128.58, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77200, 13, 3210.11, 6301.49, 129.114, 0, 0, 0, 0, 0);

SET @GUID:= 77201;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77201, 22040, 530, 1, 0, 0, 3208.64, 6363.27, 153.608, 5.34254, 300, 0, 0, 6920, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77201, 1, 3211.89, 6378.37, 160.947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 2, 3223.31, 6397.84, 163.276, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 3, 3240.92, 6421.12, 167.839, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 4, 3285.83, 6471.06, 168.139, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 5, 3272.85, 6444.45, 159.229, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 6, 3248.37, 6404.73, 141.554, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 7, 3224.73, 6361.07, 131.423, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 8, 3222.71, 6339.17, 125.556, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77201, 9, 3209.97, 6331.73, 142.969, 0, 0, 0, 0, 0);

SET @GUID:= 77202;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77202, 22040, 530, 1, 0, 0, 3215.39, 6350.47, 137.6, 3.59581, 300, 0, 0, 6920, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77202, 1, 3201.85, 6329.47, 135.39, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 2, 3215.68, 6310.24, 134.807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 3, 3206.73, 6283.2, 131.488, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 4, 3195.56, 6276.81, 136.21, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 5, 3167.04, 6269.82, 140.305, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 6, 3148.29, 6255.34, 140.236, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 7, 3134.61, 6240.46, 132.794, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 8, 3131.1, 6225.55, 132.227, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 9, 3128.93, 6212.33, 133.492, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 10, 3115.99, 6212.47, 148.839, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 11, 3112.29, 6227.4, 149.795, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 12, 3121.26, 6241.04, 141.894, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 13, 3141.21, 6254.18, 135.909, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 14, 3163.35, 6266.26, 131.723, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 15, 3183.51, 6278, 129.545, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 16, 3199.83, 6290.69, 126.462, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 17, 3207.84, 6303.4, 129.794, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77202, 18, 3206.88, 6319.42, 131.763, 0, 0, 0, 0, 0);

SET @GUID:= 77483;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77483, 22084, 530, 1, 0, 0, -3350.52, 258.855, 120.525, 2.81653, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77483, 1, -3335.96, 252.971, 120.503, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 2, -3328.07, 251.428, 120.524, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 3, -3311.63, 255.485, 120.518, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 4, -3303.8, 273.052, 120.589, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 5, -3302.62, 298.24, 120.514, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 6, -3304.24, 323.465, 120.536, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 7, -3312.88, 339.077, 120.555, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 8, -3316.73, 342.398, 120.55, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 9, -3348.09, 331.383, 120.546, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 10, -3351.53, 331.255, 120.531, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 11, -3353.14, 333.8, 120.497, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 12, -3350.19, 348.79, 120.449, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 13, -3353.36, 354.283, 120.449, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 14, -3352.93, 375.159, 120.448, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 15, -3353.28, 354.983, 120.448, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 16, -3351.32, 343.409, 120.454, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 17, -3354.26, 336.788, 120.472, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 18, -3353.37, 334.146, 120.492, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 19, -3350.73, 332.514, 120.526, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 20, -3326.92, 339.233, 120.56, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 21, -3318.34, 339.093, 120.561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 22, -3311.01, 327.968, 120.568, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 23, -3302.74, 299.107, 120.516, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 24, -3307.59, 261.589, 120.517, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 25, -3318.06, 253.183, 120.517, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 26, -3327.05, 251.433, 120.521, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 27, -3340.25, 251.811, 120.495, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77483, 28, -3352.26, 260.266, 120.52, 3000, 0, 0, 0, 0);

SET @GUID:= 77487;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77487, 22084, 530, 1, 0, 0, -3408.25, 314.888, 104.408, 1.65035, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77487, 1, -3403.36, 328.728, 104.111, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 2, -3403.34, 345.801, 103.946, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 3, -3411.08, 359.65, 103.966, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 4, -3403.22, 348.167, 104.009, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 5, -3403.2, 330.073, 104.047, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 6, -3407.83, 315.041, 104.654, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 7, -3406.25, 306.512, 103.943, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 8, -3406.99, 302.545, 103.946, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 9, -3407.98, 298.818, 105.111, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 10, -3413.04, 282.767, 103.936, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 11, -3411.76, 274.507, 103.942, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 12, -3408.24, 267.966, 103.968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 13, -3408.09, 263.461, 103.969, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 14, -3409.98, 260.113, 103.964, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 15, -3408.91, 254.544, 103.966, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 16, -3404.35, 252.276, 103.978, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 17, -3376.87, 253.681, 104.061, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 18, -3381.12, 253.231, 104.047, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 19, -3402.8, 247.365, 103.956, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 20, -3406.42, 247.804, 103.947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 21, -3410.52, 254.466, 103.956, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 22, -3410.92, 257.94, 103.962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 23, -3408.46, 262.608, 103.968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 24, -3407.48, 268.496, 103.971, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 25, -3411.08, 275.701, 103.945, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 26, -3410.74, 299.295, 105.128, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 27, -3409.55, 302.646, 103.827, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 28, -3408.06, 306.691, 104.119, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77487, 29, -3408.78, 314.251, 104.629, 0, 0, 0, 0, 0);

SET @GUID:= 77492;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77492, 22084, 530, 1, 0, 0, -3415.49, 395.264, 103.933, 4.4788, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77492, 1, -3412.22, 417.967, 103.933, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 2, -3410.95, 423.623, 103.934, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 3, -3413.51, 442.227, 103.985, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 4, -3416.25, 462.052, 103.934, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 5, -3416.09, 464.669, 103.934, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 6, -3413.45, 467.302, 103.932, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 7, -3400.26, 464.812, 103.95, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 8, -3387.51, 470.969, 103.939, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 9, -3391.15, 470.302, 103.939, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 10, -3399.68, 465.833, 103.947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 11, -3403.21, 465.623, 103.946, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 12, -3410.5, 468.868, 103.929, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 13, -3415.67, 467.461, 103.929, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 14, -3417.33, 461.138, 103.932, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 15, -3413.48, 443.661, 103.945, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 16, -3410.68, 424.075, 103.937, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77492, 17, -3414.94, 397.161, 103.951, 3000, 0, 0, 0, 0);

SET @GUID:= 77495;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77495, 22084, 530, 1, 0, 0, -3244.87, 421.909, 104.074, 3.02842, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77495, 1, -3256.18, 422.742, 103.978, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 2, -3286.15, 419.751, 103.974, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 3, -3306.04, 421.926, 104.003, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 4, -3311.07, 424.383, 104.048, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 5, -3315.66, 425.487, 104.055, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 6, -3322.92, 423.942, 104.092, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 7, -3332.62, 421.341, 104.096, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 8, -3356.46, 420.663, 104.161, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 9, -3370.29, 418.798, 103.982, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 10, -3324.61, 422.059, 104.046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 11, -3318.73, 424.825, 104.117, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 12, -3313.96, 425.627, 103.984, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 13, -3305.73, 423.301, 103.986, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 14, -3286.33, 419.791, 103.972, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 15, -3256.3, 423.441, 103.978, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 16, -3242.21, 422.384, 104.231, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 17, -3214.77, 418.887, 104.062, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77495, 18, -3244.94, 422.606, 103.98, 0, 0, 0, 0, 0);

SET @GUID:= 77497;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77497, 22084, 530, 1, 0, 0, -3297.32, 385.104, 120.458, 4.10727, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77497, 1, -3309.75, 383.58, 120.455, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 2, -3324.14, 389.139, 120.448, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 3, -3308.31, 384.654, 120.453, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 4, -3296.79, 385.616, 120.456, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 5, -3275.75, 390.621, 120.372, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 6, -3243.44, 394.94, 120.362, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 7, -3212.55, 394.678, 120.397, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 8, -3205.38, 396.341, 120.346, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 9, -3200.26, 394.407, 120.295, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 10, -3198.01, 388.696, 120.182, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 11, -3197.4, 380.314, 120.025, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 12, -3203.67, 374.006, 119.961, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 13, -3200.19, 377.802, 119.995, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 14, -3197.83, 389.538, 120.197, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 15, -3199.44, 392.892, 120.263, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 16, -3202.69, 395.882, 120.328, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 17, -3212.96, 394.533, 120.397, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 18, -3248.72, 394.193, 120.381, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 19, -3274.55, 390.446, 120.378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77497, 20, -3298.78, 384.522, 120.456, 0, 0, 0, 0, 0);

SET @GUID:= 77498;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77498, 22084, 530, 1, 0, 0, -3265.98, 460.908, 103.946, 1.3719, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77498, 1, -3273.43, 466.25, 103.948, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 2, -3277.28, 468.818, 105.082, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 3, -3274.15, 466.214, 103.949, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 4, -3269.09, 460.547, 103.946, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 5, -3264.62, 458.287, 103.947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 6, -3253.52, 458.053, 103.947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 7, -3241.2, 462.775, 103.945, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 8, -3239.41, 463.03, 104.836, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 9, -3219.88, 467.26, 104.331, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 10, -3212.73, 466.414, 104.33, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 11, -3205.91, 460.539, 104.4, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 12, -3197.35, 445.923, 104.261, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 13, -3198.24, 439.746, 104.223, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 14, -3196.72, 443.402, 104.248, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 15, -3199.45, 450.803, 104.291, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 16, -3212.03, 465.281, 104.389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 17, -3216.81, 467.331, 104.329, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 18, -3225.77, 468.258, 104.335, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 19, -3237.89, 470.102, 104.449, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 20, -3239.49, 470.269, 103.937, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 21, -3245.35, 468.929, 103.937, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 22, -3257.26, 457.551, 103.947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (77498, 23, -3265.83, 459.973, 103.947, 0, 0, 0, 0, 0);

SET @GUID:= 78222;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (78222, 18696, 530, 1, 0, 0, -4428.79, 1879.54, 159.279, 3.89207, 86400, 0, 0, 13130, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78222, 1, -4394.72, 1864.71, 157.072, 10000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 2, -4461.79, 1886.59, 160.185, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 3, -4483.14, 1923.24, 147.075, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 4, -4482.07, 1945.44, 137.237, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 5, -4466.53, 1966.46, 122.571, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 6, -4450.53, 1991.66, 104.083, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 7, -4469.15, 1990.33, 111.189, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 8, -4468.9, 1970.66, 121.295, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 9, -4486.36, 1927.62, 146.364, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78222, 10, -4450.83, 1884.11, 160.943, 0, 0, 0, 0, 0);

UPDATE `creature_loot_template` SET `groupid` = 9 WHERE `item` = 23608; -- 0

SET @GUID:= 78435;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (78435, 22307, 530, 1, 0, 0, -2849.23, 4452.75, -7.3317, 0.966037, 300, 0, 0, 6000, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78435, 1, -2831, 4488.55, -5.40144, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 2, -2833.69, 4511.24, -6.97536, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 3, -2842.93, 4539.57, -8.92945, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 4, -2832.84, 4562.57, -10.6274, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 5, -2812.07, 4585.45, -8.46509, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 6, -2787.71, 4619.89, -9.44887, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 7, -2803.7, 4593.78, -8.32121, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 8, -2832.8, 4562.59, -10.6239, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 9, -2841.43, 4548.17, -9.81332, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 10, -2842.89, 4536.18, -8.57972, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 11, -2832.78, 4509.27, -6.88285, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 12, -2831.88, 4486.51, -5.39805, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 13, -2845.88, 4456.93, -7.39068, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 14, -2859.88, 4439.34, -7.46962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 15, -2890.42, 4435.54, -9.61593, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 16, -2914.65, 4419.62, -10.2268, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 17, -2888.55, 4435.11, -9.39205, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 18, -2859.97, 4439.61, -7.46688, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78435, 19, -2848.79, 4453.25, -7.47306, 0, 0, 0, 0, 0);

SET @GUID:= 78436;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (78436, 22307, 530, 1, 0, 0, -2735.1, 4897.37, -6.92439, 3.30256, 300, 0, 0, 6000, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78436, 1, -2751.24, 4888.25, -9.28854, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78436, 2, -2731.95, 4896.86, -6.58817, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78436, 3, -2718.83, 4895.61, -4.4686, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78436, 4, -2709.21, 4893.35, -2.85624, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78436, 5, -2703.63, 4899.27, -2.11423, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78436, 6, -2708.72, 4891.87, -2.74489, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78436, 7, -2715.36, 4890.9, -3.81047, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78436, 8, -2733.71, 4896.45, -6.85721, 0, 0, 0, 0, 0);

SET @GUID:= 78438;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (78438, 22307, 530, 1, 0, 0, -3546.35, 4215.03, -4.56673, 2.60472, 300, 0, 0, 6000, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78438, 1, -3526.37, 4199.18, -4.18007, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 2, -3502.95, 4204.91, -3.86274, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 3, -3485.76, 4213.2, -5.05477, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 4, -3478.05, 4210.96, -4.81493, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 5, -3466.32, 4196, -3.19562, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 6, -3458.17, 4190.77, -2.7045, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 7, -3442.91, 4194.63, -4.69759, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 8, -3419.98, 4207.14, -7.63673, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 9, -3392.66, 4211.94, -9.26122, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 10, -3371.72, 4209.28, -9.76929, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 11, -3345.31, 4200.04, -8.81895, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 12, -3318.96, 4181.89, -7.0849, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 13, -3302.02, 4175.35, -7.40304, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 14, -3292.47, 4177.36, -8.09926, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 15, -3291.31, 4189.23, -9.51124, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 16, -3293.06, 4177.42, -8.07473, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 17, -3300.57, 4172.31, -7.15121, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 18, -3310.15, 4173.36, -6.84514, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 19, -3334.44, 4193.86, -7.95459, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 20, -3355.39, 4203.79, -9.36296, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 21, -3380.73, 4211.96, -9.7678, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 22, -3393.45, 4211.85, -9.21899, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 23, -3421.38, 4206.5, -7.50797, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 24, -3444.25, 4194.58, -4.59379, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 25, -3458.62, 4190.86, -2.68858, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 26, -3469.01, 4198.23, -3.41623, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 27, -3479, 4211.13, -4.81482, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 28, -3488.95, 4213.56, -5.12335, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 29, -3504.71, 4205.71, -4.04269, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 30, -3522.31, 4198.98, -3.97894, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 31, -3532.67, 4201.09, -4.47656, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78438, 32, -3553.74, 4222.86, -4.66667, 4000, 0, 0, 0, 0);

SET @GUID:= 78439;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (78439, 22307, 530, 1, 0, 0, -3106.56, 4259.65, -9.25109, 0.134295, 300, 0, 0, 6000, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78439, 1, -3082.88, 4264, -8.33045, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78439, 2, -3041.47, 4307.55, -11.0783, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78439, 3, -3063.64, 4284.76, -9.75672, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78439, 4, -3083.91, 4262.66, -8.21446, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78439, 5, -3096.39, 4258.22, -8.41367, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78439, 6, -3119.69, 4258.84, -10.3825, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78439, 7, -3136.22, 4243.77, -9.69491, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78439, 8, -3120.7, 4259.65, -10.5223, 0, 0, 0, 0, 0);

SET @GUID:= 78731;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (78731, 22396, 530, 1, 0, 0, 3233.38, 6394.42, 131.359, 1.09134, 300, 0, 0, 8856, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78731, 1, 3233.38, 6394.42, 131.359, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78731, 2, 3247.23, 6415.38, 139.057, 10000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78731, 3, 3233.38, 6394.42, 131.359, 25000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78731, 4, 3222.07, 6365.31, 120.538, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78731, 5, 3217.93, 6345.77, 120.283, 10000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78731, 6, 3222.07, 6365.31, 120.538, 0, 0, 0, 0, 0);

SET @GUID:= 83257;
DELETE FROM `creature` WHERE `guid` IN (@GUID, 16777338);
INSERT INTO `creature` VALUES (83257, 19428, 556, 3, 0, 0, -242.483, 299.172, 26.7562, 4.3511, 7200, 0, 0, 31398, 14955, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` IN (@GUID, 16777338);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` IN (@GUID, 16777338);
INSERT INTO `waypoint_data` VALUES (83257, 1, -242.483, 299.172, 26.7562, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83257, 2, -214.631, 332.432, 26.7577, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83257, 3, -188.86, 315.704, 26.7306, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83257, 4, -183.914, 295.964, 26.6141, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83257, 5, -188.86, 315.704, 26.7306, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83257, 6, -214.631, 332.432, 26.7577, 0, 0, 0, 100, 0);
DELETE FROM `creature_linked_respawn` WHERE `guid` = 83257;
INSERT INTO `creature_linked_respawn` VALUES (83257, 83300);

SET @GUID:= 84490;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (84490, 21879, 530, 1, 0, 0, -3362.46, 1708.18, 132.83, 5.005, 120, 0, 0, 6542, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (84490, 1, -3342.16, 1671.63, 129.944, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 2, -3324.74, 1654.29, 120.786, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 3, -3262.07, 1625.13, 104.116, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 4, -3201.14, 1588.5, 87.5292, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 5, -3156.44, 1563.46, 68.9621, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 6, -3109.66, 1530.26, 51.1911, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 7, -3094.71, 1515.09, 53.628, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 8, -3079.1, 1510.42, 55.6868, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 9, -3072.98, 1480.65, 50.7285, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 10, -3077.09, 1431.52, 40.7097, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 11, -3092.36, 1397.29, 30.0941, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 12, -3152.2, 1410.38, 59.0371, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 13, -3174.71, 1452.19, 64.8905, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 14, -3184.41, 1493.91, 71.7535, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 15, -3172.29, 1532.88, 78.8215, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 16, -3171.24, 1549.15, 80.4466, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 17, -3183.67, 1572.14, 80.131, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 18, -3210.32, 1594.07, 85.4464, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 19, -3261.54, 1629.86, 96.9339, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 20, -3274.6, 1674.89, 94.9156, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 21, -3290.82, 1710.06, 101.77, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 22, -3315.46, 1740.15, 107.11, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 23, -3334.17, 1743.58, 132.191, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 24, -3355.31, 1730.86, 136.543, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84490, 25, -3362.46, 1708.18, 132.831, 0, 0, 0, 0, 0);

SET @GUID:= 84497;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (84497, 19673, 530, 1, 0, 0, -3127.5, 4922.79, -98.2781, 2.44596, 120, 0, 0, 27635, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (84497, 1, -3129.8, 4926.13, -98.4561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84497, 2, -3124.58, 4931.7, -98.6768, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84497, 3, -3110.8, 4938.22, -99.5145, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84497, 4, -3095.94, 4940.46, -99.6997, 15000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84497, 5, -3095.94, 4940.46, -99.6997, 50000, 0, 0, 100, 0); -- 1967301

SET @GUID:= 84611;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (84611, 21879, 530, 1, 0, 0, -3606.28, 2599.38, 89.0027, 4.75698, 120, 0, 0, 6542, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (84611, 1, -3611.37, 2570.27, 92.8707, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 2, -3630.27, 2532.11, 96.4359, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 3, -3634.83, 2513.9, 98.419, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 4, -3616.7, 2497.18, 97.6505, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 5, -3595.42, 2510.97, 96.382, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 6, -3561.81, 2564.88, 94.1001, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 7, -3537.12, 2599.25, 91.2254, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 8, -3502.47, 2623.8, 90.4972, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 9, -3496.2, 2632.96, 89.131, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 10, -3490.85, 2650.53, 87.8434, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 11, -3512.66, 2658.27, 89.6923, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 12, -3577.53, 2654.37, 100.46, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 13, -3604.02, 2651.04, 100.266, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 14, -3609.28, 2644.1, 99.8964, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 15, -3611.19, 2629.42, 98.4657, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84611, 16, -3605.42, 2598.31, 96.3323, 0, 0, 0, 0, 0);

SET @GUID:= 84630;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (84630, 21879, 530, 1, 0, 0, -3095.24, 1220.88, 33.0581, 5.27721, 120, 0, 0, 6542, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (84630, 1, -3074.93, 1188.86, 38.7277, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 2, -3035.11, 1165.31, 35.0121, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 3, -3019.73, 1151.13, 35.1351, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 4, -3016.61, 1123.1, 34.1982, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 5, -3027.22, 1079.76, 30.0755, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 6, -3045.88, 1054.69, 24.7407, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 7, -3067.38, 1055.21, 26.6896, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 8, -3079.45, 1063.56, 30.5619, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 9, -3086.67, 1077.83, 33.8127, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 10, -3088.04, 1090.91, 40.1218, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 11, -3082.3, 1104.32, 40.6544, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 12, -3064.73, 1124.94, 40.3428, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 13, -3057.82, 1140.25, 41.1656, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 14, -3055.51, 1153.65, 40.4705, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 15, -3083.91, 1211.61, 33.5587, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 16, -3104.27, 1231.58, 37.455, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 17, -3137.43, 1230.34, 48.7557, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 18, -3158.72, 1239.77, 53.3977, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 19, -3171.76, 1255.58, 54.3913, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 20, -3175.61, 1271.74, 51.2876, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 21, -3173.25, 1283.96, 49.6603, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 22, -3168.4, 1292.35, 48.0716, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 23, -3157.36, 1297.83, 44.8439, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 24, -3142.57, 1296.69, 40.3447, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 25, -3124.68, 1284.35, 37.5749, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 26, -3110.24, 1268.31, 34.9335, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (84630, 27, -3097.65, 1231.28, 39.9472, 0, 0, 0, 0, 0);

SET @GUID:= 84636;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (84636, 21699, 530, 1, 0, 0, -3697.67, 1026.18, 57.1449, 4.67545, 120, 0, 0, 4800, 13236, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (84636, 1, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 2, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 3, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 4, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 5, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 6, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 7, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 8, -3697.09, 1028.91, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 9, -3708.71, 1028.62, 56.3771, 15000, 0, 0, 100, 0); -- 8463601
INSERT INTO `waypoint_data` VALUES (84636, 10, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 11, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 12, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 13, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 14, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 15, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 16, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 17, -3697.09, 1028.91, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 18, -3708.71, 1028.62, 56.3771, 15000, 0, 0, 100, 0); -- 8463602
INSERT INTO `waypoint_data` VALUES (84636, 19, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 20, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 21, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 22, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 23, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 24, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 25, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 26, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 27, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 28, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 29, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 30, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 31, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 32, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 33, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 34, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 35, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 36, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 37, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 38, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 39, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 40, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 41, -3697.57, 1035.3, 57.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (84636, 42, -3697.14, 1023.41, 57.14, 0, 0, 0, 100, 0);

SET @GUID:= 79765;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (79765, 24007, 1, 1, 89, 0, -3737.91, -4332.46, 9.96946, 4.6036, 360, 0, 0, 950, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (79765, 1, -3737.38, -4339.24, 10.5292, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 2, -3737.81, -4335.35, 9.84398, 2500, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 3, -3735.17, -4345.08, 11.0501, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 4, -3738.3, -4361.5, 11.2421, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 5, -3742.32, -4377.53, 10.6394, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 6, -3756.93, -4384.59, 10.6027, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 7, -3769.1, -4388.77, 10.7333, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 8, -3783.84, -4392.15, 10.5963, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 9, -3800.35, -4397.41, 11.2693, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 10, -3808.19, -4406.56, 12.4574, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 11, -3815.65, -4421.6, 12.594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 12, -3814.47, -4438.06, 12.8084, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 13, -3814.74, -4470.19, 12.6997, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 14, -3802.13, -4500.09, 11.5537, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 15, -3802.86, -4509.85, 11.4222, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 16, -3815.81, -4523.22, 9.21862, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 17, -3834.9, -4541.82, 9.20508, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 18, -3849.47, -4541.81, 9.02653, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 19, -3855.75, -4556.12, 8.32684, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 20, -3869.67, -4572.9, 8.29316, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 21, -3880.14, -4579.89, 9.15202, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 22, -3906.28, -4565.93, 9.17806, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 23, -3924.72, -4542.71, 9.16604, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 24, -3953.79, -4515.71, 9.30722, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 25, -3978.23, -4535.58, 9.94442, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 26, -3993.97, -4549.47, 9.87766, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 27, -4021.61, -4573.67, 9.59439, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 28, -4043.51, -4550.47, 10.3517, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 29, -4056.3, -4540.98, 9.92103, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 30, -4064.65, -4540.02, 9.76037, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 31, -4066.84, -4538.29, 10.4222, 2500, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 32, -4065.13, -4540.5, 9.757, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 33, -4056.75, -4550.28, 9.87959, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 34, -4029.68, -4576.24, 9.76127, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 35, -4001.19, -4571.22, 9.55702, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 36, -3986.45, -4556.28, 9.83284, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 37, -3957.55, -4529.18, 9.38431, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 38, -3932.16, -4537.99, 9.27164, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 39, -3911.75, -4566.73, 9.20224, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 40, -3881.36, -4588, 9.18528, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 41, -3873.01, -4583.53, 8.92324, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 42, -3861.95, -4574.5, 7.99635, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 43, -3846.36, -4564.64, 8.30792, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 44, -3830.7, -4559.4, 8.83052, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 45, -3832.32, -4547.23, 9.16615, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 46, -3821.52, -4536.15, 9.2179, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 47, -3798.46, -4514.58, 11.4829, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 48, -3798.34, -4495.33, 11.5418, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 49, -3810.93, -4466.96, 12.72, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 50, -3809.62, -4423.87, 12.7021, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 51, -3800.44, -4404.46, 11.6021, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 52, -3791.14, -4398.28, 10.5966, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 53, -3767.57, -4392.14, 10.7013, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 54, -3737.47, -4376.04, 10.7435, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 55, -3738.52, -4374.07, 10.6227, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 56, -3740.05, -4364.22, 11.0139, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 57, -3734.39, -4349, 11.1383, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (79765, 58, -3735.35, -4341.23, 10.9751, 0, 0, 0, 0, 0);

DELETE FROM `pool_creature` WHERE `guid` = 85405;
INSERT INTO `pool_creature` VALUES (85405, 1189, 0, 'Okrek (18685)');

SET @GUID:= 85382;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (85382, 18685, 530, 1, 0, 0, -1633.09, 4416.39, 52.1155, 5.98654, 79200, 0, 0, 9144, 13525, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85382, 1, -1633.09, 4416.39, 52.0432, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85382, 2, -1618.41, 4410.16, 52.5576, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85382, 3, -1606.43, 4420.26, 52.6329, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85382, 4, -1611.34, 4435.12, 52.6265, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85382, 5, -1624.94, 4436.8, 52.6168, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85382, 6, -1633.09, 4416.39, 52.0432, 0, 0, 0, 0, 0);
DELETE FROM `pool_creature` WHERE `guid` = 85382;
INSERT INTO `pool_creature` VALUES (85382, 1189, 0, 'Okrek (18685)');

SET @GUID:= 85564;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (85564, 18685, 530, 1, 0, 0, -1843.55, 3958.17, 46.5491, 4.04581, 100800, 0, 0, 9144, 13525, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85564, 1, -1843.55, 3958.17, 46.5491, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 2, -1849.11, 3959.83, 46.5567, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 3, -1856.92, 3952.97, 46.4926, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 4, -1856.12, 3938.67, 46.05, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 5, -1853.1, 3924.98, 45.3693, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 6, -1862.49, 3908.7, 39.1752, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 7, -1879.08, 3879.85, 45.4519, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 8, -1903.73, 3870.84, 45.3793, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 9, -1910.33, 3850.94, 45.4441, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 10, -1887.31, 3837.38, 45.4393, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 11, -1871.41, 3847.16, 45.4412, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 12, -1871.2, 3867.79, 45.4431, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 13, -1880.9, 3877.3, 45.4447, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 14, -1868.93, 3897.99, 39.0142, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 15, -1853.37, 3923.24, 45.3162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 16, -1826.5, 3934.92, 46.5561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 17, -1829.69, 3958.36, 46.5588, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 18, -1836.99, 3960.91, 46.5588, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85564, 19, -1843.55, 3958.17, 46.5491, 0, 0, 0, 0, 0);
DELETE FROM `pool_creature` WHERE `guid` = 85564;
INSERT INTO `pool_creature` VALUES (85564, 1189, 0, 'Okrek (18685)');

SET @GUID:= 85565;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (85565, 18685, 530, 1, 0, 0, -3551.84, 3999.6, 93.7046, 5.20977, 115200, 0, 0, 9144, 13525, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85565, 1, -3551.84, 3999.6, 93.7046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 2, -3563.29, 4001.41, 91.8348, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 3, -3590.03, 4006.42, 75.3029, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 4, -3555.16, 4040.98, 69.5859, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 5, -3512.02, 4051.49, 60.9738, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 6, -3499.84, 4050.19, 59.424, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 7, -3482.48, 4033.23, 59.8893, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 8, -3461.45, 4028.88, 59.1618, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 9, -3428.89, 4011.93, 62.2547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 10, -3386.09, 4008.06, 58.385, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 11, -3363.25, 4002.11, 58.7623, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 12, -3386.09, 4008.06, 58.385, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 13, -3428.89, 4011.93, 62.2547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 14, -3461.45, 4028.88, 59.1618, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 15, -3482.48, 4033.23, 59.8893, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 16, -3499.84, 4050.19, 59.424, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 17, -3512.02, 4051.49, 60.9738, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 18, -3555.16, 4040.98, 69.5859, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 19, -3590.03, 4006.42, 75.3029, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 20, -3563.29, 4001.41, 91.8348, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85565, 21, -3551.84, 3999.6, 93.7046, 0, 0, 0, 0, 0);
DELETE FROM `pool_creature` WHERE `guid` = 85565;
INSERT INTO `pool_creature` VALUES (85565, 1189, 0, 'Okrek (18685)');

SET @GUID:= 85682;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (85682, 17414, 542, 3, 0, 0, 352.426, 85.7746, 9.6222, 6.27838, 7200, 0, 0, 10472, 5875, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85682, 1, 347.956, 85.7409, 9.62043, 0, 0, 1000, 100, 0);
INSERT INTO `waypoint_data` VALUES (85682, 2, 347.916, 110.351, 9.61782, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85682, 3, 352.837, 111.374, 9.61782, 20000, 0, 1069, 100, 0);
INSERT INTO `waypoint_data` VALUES (85682, 4, 347.284, 107.207, 9.62031, 0, 0, 1000, 100, 0);
INSERT INTO `waypoint_data` VALUES (85682, 5, 349.97, 85.8217, 9.62088, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85682, 6, 353.022, 85.8086, 9.6216, 20000, 0, 1069, 100, 0);
DELETE FROM `creature_linked_respawn` WHERE `guid` = 85682;
INSERT INTO `creature_linked_respawn` VALUES (85682, 56436);

SET @GUID:= 85694;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (85694, 17626, 542, 3, 0, 0, 298.504, 0.906181, 9.60513, 3.30906, 7200, 0, 0, 14958, 5158, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85694, 1, 284.936, -1.96804, 9.04424, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85694, 2, 266.223, -13.4516, 6.96003, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85694, 3, 254.934, -26.0985, 6.95547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85694, 4, 244.856, -40.045, 8.6632, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85694, 5, 253.197, -27.9716, 6.95299, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85694, 6, 268.678, -12.4847, 6.95837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85694, 7, 287.2, -2.90165, 9.42918, 0, 0, 0, 0, 0);
DELETE FROM `creature_linked_respawn` WHERE `guid` = 85694;
INSERT INTO `creature_linked_respawn` VALUES (85694, 56436);

SET @GUID:= 86037;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (86037, 19445, 530, 1, 0, 0, -365.884, 992.767, 54.2785, 5.61996, 120, 0, 0, 5725, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (86037, 1, -351.676, 1003.09, 54.2105, 0, 0, 0, 100, 0); -- 1944501
INSERT INTO `waypoint_data` VALUES (86037, 2, -347.655, 1004.96, 54.2145, 16000, 0, 0, 100, 0); -- 1944502
INSERT INTO `waypoint_data` VALUES (86037, 3, -340.337, 1012.39, 54.2244, 20000, 0, 0, 100, 0); -- 1944503

SET @GUID:= 86744;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (86744, 18682, 530, 1, 0, 0, -294.88, 6951.41, 19.3571, 5.86619, 10506, 15, 0, 8844, 2620, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (86744, 1, -294.88, 6951.41, 19.3571, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 2, -264.713, 6967.21, 18.5643, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 3, -238.936, 6962.83, 18.4649, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 4, -223.667, 6933.64, 18.847, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 5, -206.707, 6923.1, 19.2127, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 6, -174.357, 6912.01, 23.7861, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 7, -133.379, 6904.8, 19.1708, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 8, -89.2117, 6888.52, 18.7763, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 9, -10.2975, 6909.53, 18.2978, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 10, -18.0022, 6939.27, 21.741, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 11, -25.1892, 6997.55, 20.889, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 12, -24.8436, 7035.61, 17.8247, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 13, 6.85314, 7099.44, 17.3786, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 14, 25.5966, 7264.21, 17.4588, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 15, 12.2616, 7293.45, 17.3838, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 16, -41.0481, 7273.87, 17.9097, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 17, -85.6322, 7318.57, 17.6278, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 18, -89.8231, 7394.33, 17.6309, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 19, -163.533, 7388.21, 17.2929, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 20, -188.143, 7374.22, 17.5246, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 21, -209.081, 7387.84, 19.2417, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 22, -223.03, 7406.85, 17.6799, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86744, 23, -316.638, 7413.45, 17.396, 0, 0, 0, 0, 0);
DELETE FROM `pool_creature` WHERE `guid` = 86744;
INSERT INTO `pool_creature` VALUES (86744, 1194, 0, 'Bog Lurker (18682)');

DELETE FROM `pool_creature` WHERE `guid` = 86745;
INSERT INTO `pool_creature` VALUES (86745, 1194, 0, 'Bog Lurker (18682)');

SET @GUID:= 86746;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (86746, 18682, 530, 1, 0, 0, 1172.09, 8023.15, 17.7483, 0.670779, 10506, 15, 0, 8844, 2620, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (86746, 1, 1172.09, 8023.15, 17.7483, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 2, 1205.67, 8081.13, 18.0472, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 3, 1246.97, 8119.73, 18.0185, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 4, 1244.49, 8164.48, 19.4185, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 5, 1223.65, 8202.27, 17.7094, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 6, 1221.96, 8226.97, 17.6808, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 7, 1197.53, 8287.43, 18.2173, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 8, 1216.92, 8311.79, 18.6032, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 9, 1196.57, 8343.54, 17.3991, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 10, 1088.8, 8342.08, 17.3746, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 11, 1045.06, 8342.71, 21.9398, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 12, 1011.94, 8349.03, 19.6497, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 13, 930.204, 8321.25, 17.427, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 14, 906.417, 8281.23, 18.9275, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 15, 908.587, 8226.88, 18.308, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 16, 942.57, 8148.69, 17.3847, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 17, 1006.13, 8155.76, 17.3811, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 18, 1059.14, 8110.92, 17.4296, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 19, 1108.14, 8112.69, 17.3877, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 20, 1140.55, 8059.55, 17.6974, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86746, 21, 1151.68, 8029.68, 17.6969, 0, 0, 0, 0, 0);
DELETE FROM `pool_creature` WHERE `guid` = 86746;
INSERT INTO `pool_creature` VALUES (86746, 1194, 0, 'Bog Lurker (18682)');

SET @GUID:= 91723;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (91723, 22148, 530, 1, 0, 1375, -1502.15, 5912.79, 194.478, 2.06345, 300, 0, 0, 7181, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (91723, 1, -1516.81, 5917.45, 195.449, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 2, -1525.88, 5933.57, 195.338, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 3, -1526.19, 5955.61, 193.51, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 4, -1532.71, 5973.49, 192.256, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 5, -1539.29, 5982.87, 193.319, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 6, -1553.98, 5985.15, 194.251, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 7, -1540.94, 5984.6, 193.291, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 8, -1532.33, 5973.62, 192.258, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 9, -1525.75, 5955.2, 193.569, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 10, -1524.27, 5935.62, 195.015, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 11, -1520.3, 5922.19, 195.538, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 12, -1513.03, 5913.5, 194.928, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 13, -1502.11, 5909.78, 194.504, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 14, -1492.31, 5913.65, 194.478, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 15, -1489.66, 5924.48, 194.477, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 16, -1491.87, 5941.16, 194.984, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 17, -1461.09, 5937.19, 208.795, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 18, -1460.87, 5950.35, 215.162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 19, -1463.92, 5963.32, 221.615, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 20, -1461.15, 5950.46, 215.23, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 21, -1461.57, 5937.18, 208.582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 22, -1471.27, 5937.14, 204.23, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 23, -1491.39, 5941.14, 195.014, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 24, -1490.3, 5924.05, 194.477, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 25, -1492.73, 5913.35, 194.477, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91723, 26, -1502.59, 5911.17, 194.487, 0, 0, 0, 0, 0);

SET @GUID:= 91732;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (91732, 22148, 530, 1, 0, 1375, -1258.5, 5874.49, 183.428, 5.46489, 300, 0, 0, 7181, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (91732, 1, -1279.51, 5882.71, 187.378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 2, -1310.55, 5896.12, 190.15, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 3, -1341.92, 5905.7, 190.723, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 4, -1364.53, 5907.49, 191.539, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 5, -1376.18, 5903.3, 191.004, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 6, -1395.03, 5887.96, 187.162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 7, -1399.69, 5866.81, 183.818, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 8, -1392.64, 5850.37, 184.667, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 9, -1378.41, 5840.53, 185.955, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 10, -1350.94, 5830.78, 186.287, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 11, -1335.77, 5818.54, 184.853, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 12, -1321.25, 5813.11, 185.734, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 13, -1298.8, 5823.94, 185.414, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 14, -1274.05, 5847.85, 185.968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 15, -1256.68, 5867.76, 183.556, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91732, 16, -1262.47, 5878.12, 184.899, 0, 0, 0, 0, 0);

SET @GUID:= 91738;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (91738, 23022, 530, 1, 0, 0, -1315.22, 5809.05, 186.312, 5.15544, 300, 0, 0, 27945, 6310, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (91738, 1, -1330, 5772.58, 182.907, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 2, -1330.99, 5742.57, 181.18, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 3, -1334.7, 5735.71, 180.898, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 4, -1332.69, 5723.99, 180.092, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 5, -1334.92, 5714.3, 180.339, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 6, -1332.69, 5723.99, 180.092, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 7, -1334.7, 5735.71, 180.898, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 8, -1332.17, 5745.07, 181.152, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 9, -1329.98, 5772.85, 182.91, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 10, -1322.73, 5792.35, 183.804, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 11, -1319.87, 5808.9, 185.731, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 12, -1337.74, 5821.18, 184.754, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 13, -1379.33, 5839.73, 186.025, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 14, -1336.58, 5820.7, 184.813, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91738, 15, -1319.5, 5808.55, 185.771, 0, 0, 0, 0, 0);

SET @GUID:= 91739;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (91739, 22148, 530, 1, 0, 1375, -1359.5, 5639, 181.393, 1.20936, 300, 0, 0, 7181, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (91739, 1, -1354.87, 5651.11, 181.969, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 2, -1343.61, 5658.92, 185.445, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 3, -1328.94, 5658.8, 191.292, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 4, -1322.06, 5663.88, 192.348, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 5, -1312.35, 5664.69, 193.89, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 6, -1303.89, 5670.08, 193.189, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 7, -1292.06, 5687.82, 190.006, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 8, -1279.21, 5699.54, 192.317, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 9, -1268.02, 5689.71, 205.593, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 10, -1261.08, 5682.03, 208.766, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 11, -1254.01, 5673.35, 213.628, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 12, -1242.06, 5678.88, 219.256, 10000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 13, -1252.32, 5675.64, 214.624, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 14, -1260.94, 5682.09, 208.806, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 15, -1267.29, 5688.28, 206.674, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 16, -1276.43, 5698.97, 194.941, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 17, -1282.77, 5699.04, 191.403, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 18, -1291.96, 5687.64, 190.034, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 19, -1299.03, 5677.06, 192.878, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 20, -1305.87, 5667.05, 193.435, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 21, -1319.81, 5661.57, 192.259, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 22, -1331.31, 5659.29, 190.595, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 23, -1344.88, 5658.89, 185.011, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 24, -1354.81, 5650.98, 181.997, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 25, -1354.93, 5634.64, 182.154, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 26, -1354.17, 5620.48, 181.845, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 27, -1373.38, 5598.87, 195.183, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 28, -1353.86, 5620.57, 181.861, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (91739, 29, -1355.3, 5638.02, 182.237, 0, 0, 0, 0, 0);

SET @GUID:= 93830;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (93830, 21220, 548, 1, 0, 0, 37.2912, -299.594, 1.58652, 3.76626, 7200, 0, 0, 143600, 48465, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (93830, 1, 20.291, -301.371, 0.760882, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93830, 2, 14.7836, -293.903, 0.745901, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93830, 3, 31.4443, -298.098, 1.27367, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (93830, 4, 33.4981, -299.408, 1.5865, 0, 0, 0, 0, 0);

SET @GUID:= 96989;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (96989, 20237, 530, 1, 18666, 0, 267.502, 1449.24, -14.3756, 4.23579, 360, 0, 0, 3000, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,18736,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (96989, 1, 267.502, 1449.24, -14.3756, 10000, 1, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96989, 2, 267.502, 1449.24, -14.3756, 60000, 1, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96989, 3, 267.502, 1449.24, -14.3756, 3000, 1, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96989, 4, 288.012, 1484.46, -13.3656, 2000, 1, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96989, 5, 288.012, 1484.46, -13.3656, 60000, 1, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (96989, 6, 288.012, 1484.46, -13.3656, 3000, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` = 21217;
INSERT INTO `creature_loot_template` VALUES (21217, 29434, 0, 0, 2, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21217, 34052, 2, 2, -34052, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21217, 34058, 100, 1, -34058, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21217, 90052, 10, 1, -34052, 1, 0, 0, 0);

DELETE FROM `reference_loot_template` WHERE `entry` = 34052;
INSERT INTO `reference_loot_template` VALUES (34052, 30280, 0, 1, 1, 1, 7, 197, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30281, 0, 1, 1, 1, 7, 197, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30282, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34052, 30283, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34052, 30301, 0, 1, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30302, 0, 1, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30303, 0, 1, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30304, 0, 1, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30305, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34052, 30306, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34052, 30307, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34052, 30308, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34052, 30321, 0, 1, 1, 1, 7, 164, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30322, 0, 1, 1, 1, 7, 164, 1);
INSERT INTO `reference_loot_template` VALUES (34052, 30323, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34052, 30324, 0, 2, 1, 1, 0, 0, 0);

DELETE FROM `reference_loot_template` WHERE `entry` = 34058;
INSERT INTO `reference_loot_template` VALUES (34058, 30057, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30058, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30059, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30060, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30061, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30062, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30063, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30064, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30066, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30067, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 33054, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34058, 30665, 0, 1, 1, 1, 0, 0, 0);

UPDATE `creature_loot_template` SET `maxcount` = 3 WHERE `entry` = 21216 AND `mincountOrRef` = -34057;

UPDATE `creature_loot_template` SET `maxcount` = 3 WHERE `entry` = 21217 AND `mincountOrRef` = -34058;

UPDATE `creature_loot_template` SET `maxcount` = 3 WHERE `entry` = 21213 AND `mincountOrRef` = -34061;

UPDATE `creature_loot_template` SET `maxcount` = 3 WHERE `entry` = 19514 AND `mincountOrRef` = -34053;

UPDATE `creature_loot_template` SET `maxcount` = 3 WHERE `entry` = 18805 AND `mincountOrRef` = -34055;

-- https://github.com/Looking4Group/L4G_Core/issues/633
-- =========
-- Zul'Aman
-- =========
-- http://vignette4.wikia.nocookie.net/wowwiki/images/4/46/Armor.JPG
-- https://web.archive.org/web/20100907205300/http://www.hordeguides.de/Schlachtzug/TBC/3805/ZulAman/index.htm

-- ======================================================
-- Texts & Scripts
-- ======================================================

-- -9711 - -9725
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -1442 AND -1439;
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9731 AND -9730;
INSERT INTO `creature_ai_texts` VALUES
-- INSERT INTO `creature_ai_texts` VALUES
-- (-1439,'I gonna make you into mojo!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Zul\'aman Trash'), -228
-- (-1440,'Killing you be easy.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Zul\'aman Trash'), -229
(-9730,'My weapon be thirsty!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Zul\'aman Trash'),
(-9731,'More intruders! Sound da alarm!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Zul\'aman Trash');
-- (-1442,'You be dead soon!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Zul\'aman Trash'); -230

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1568086 AND -1568067;
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1800509 AND -1800499;
INSERT INTO `script_texts` VALUES (-1568086, 'absorbs the essence of the dragonhawk spirit!', NULL, NULL, 'absorbiert die Essenz des Drachenfalken!', NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, 'zuljin EMOTE_DRAGONHAWK_SPIRIT');
INSERT INTO `script_texts` VALUES (-1568085, 'absorbs the essence of the lynx spirit!', NULL, NULL, 'absorbiert die Essenz des Luchses!', NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, 'zuljin EMOTE_LYNX_SPIRIT');
INSERT INTO `script_texts` VALUES (-1568084, 'absorbs the essence of the eagle spirit!', NULL, NULL, 'absorbiert die Essenz des Adlers!', NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, 'zuljin EMOTE_EAGLE_SPIRIT');
INSERT INTO `script_texts` VALUES (-1568083, 'absorbs the essence of the bear spirit!', NULL, NULL, 'absorbiert die Essenz des Bären!', NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, 'zuljin EMOTE_BEAR_SPIRIT');
INSERT INTO `script_texts` VALUES (-1568082, 'In fact, It would be the best if you just stay here. You\'d only get in my way.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'harrison SAY_OPEN_GATE');
INSERT INTO `script_texts` VALUES (-1568081, 'I\'ve researched this site extensively and i won\'t allow any dim-witted treasure hunters to swoop in and steal what belongs to in a museum. I\'ll lead this charge.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'harrison SAY_OPENING_ENTRANCE');
INSERT INTO `script_texts` VALUES (-1568080, 'According to my calculations, if enough of us bang the gong at once the seal on these doors will break and we can enter.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'harrison SAY_AT_GONG');
INSERT INTO `script_texts` VALUES (-1568079, 'Suit yourself. At least five of you must assist me if we\'re to get inside. Follow me.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, 'harrison SAY_START');
INSERT INTO `script_texts` VALUES (-1568078, 'Watch now. Every offering gonna strengthen our ties to da spirit world. Soon, we gonna be unstoppable!', NULL, NULL, 'Seht genau hin. Unsere Verbindung zur Geisterwelt wird mit jeder Opferung stärker. Schon bald wird man uns nicht mehr aufhalten können!', NULL, NULL, NULL, NULL, NULL, 12065, 6, 0, 0, 'zulaman SAY_INST_COMPLETE');
INSERT INTO `script_texts` VALUES (-1568077, 'Ya not do too bad. Ya efforts [...] for a small time. Come to me now. Ya prove yourself worthy offerings.', NULL, NULL, 'Nicht schlecht, aber eure Bemühungen zögern das Unvermeidliche nur hinaus. Kommt jetzt zu mir, ihr habt euch als würdige Opfer erwiesen.', NULL, NULL, NULL, NULL, NULL, 12062, 6, 0, 0, 'zulaman SAY_INST_SACRIF2');
INSERT INTO `script_texts` VALUES (-1568076, 'Ya make a good try... but now you gonna join da ones who already fall.', NULL, NULL, 'Netter Versuch. Aber jetzt folgt ihr denen, die schon vor euch versagt haben.', NULL, NULL, NULL, NULL, NULL, 12061, 6, 0, 0, 'zulaman SAY_INST_SACRIF1');
INSERT INTO `script_texts` VALUES (-1568075, 'Make haste, ma priests! Da rituals must not be interrupted!', NULL, NULL, 'Beeilt euch meine Priester! Nichts darf die Rituale unterbrechen.', NULL, NULL, NULL, NULL, NULL, 12060, 6, 0, 0, 'zulaman SAY_INST_WARN_4');
INSERT INTO `script_texts` VALUES (-1568074, 'Time be running low, strangers. Soon you gonna join da souls of dem ya failed to save.', NULL, NULL, 'Euch bleibt nicht mehr viel Zeit, Fremde. Bald werdet ihr euch zu den Seelen gesellen, die ihr nicht zu retten vermochtet.', NULL, NULL, NULL, NULL, NULL, 12059, 6, 0, 0, 'zulaman SAY_INST_WARN_3');
INSERT INTO `script_texts` VALUES (-1568073, 'Soon da cages gonna be empty, da sacrifices be complete, and you gonna take dere places.', NULL, NULL, 'Bald werden die Käfige leer und die Opfer vollbracht sein. Dann werdet ihr an ihre Stelle treten.', NULL, NULL, NULL, NULL, NULL, 12058, 6, 0, 0, 'zulaman SAY_INST_WARN_2');
INSERT INTO `script_texts` VALUES (-1568072, 'Your efforts was in vain, trespassers. The rituals nearly be complete.', NULL, NULL, 'Ihr habt euch umsonst bemüht, Eindringlinge. Die Rituale sind fast abgeschlossen.', NULL, NULL, NULL, NULL, NULL, 12057, 6, 0, 0, 'zulaman SAY_INST_WARN_1');
INSERT INTO `script_texts` VALUES (-1568071, 'Ya gonna fail, strangers. Many try before you, but dey only make us stronger!', NULL, NULL, 'Ihr werdet versagen, Fremde. Viele haben es vor euch versucht, aber dadurch werden wir nur noch stärker.', NULL, NULL, NULL, NULL, NULL, 12056, 6, 0, 0, 'zulaman SAY_INST_PROGRESS_3');
INSERT INTO `script_texts` VALUES (-1568070, 'Don\'t be shy. Thousands have come before you. Ya not be alone in your service.', NULL, NULL, 'Nicht so schüchtern, vor euch waren schon tausende hier. Ihr werdet nicht allein sein.', NULL, NULL, NULL, NULL, NULL, 12055, 6, 0, 0, 'zulaman SAY_INST_PROGRESS_2');
INSERT INTO `script_texts` VALUES (-1568069, 'Take your pick, trespassers! Any of ma priests be happy to accommodate ya.', NULL, NULL, 'Ihr habt die Wahl, Eindringlinge. Ein jeder meiner Priester wird euch mit Freuden entgegen kommen.', NULL, NULL, NULL, NULL, NULL, 12054, 6, 0, 0, 'zulaman SAY_INST_PROGRESS_1');
INSERT INTO `script_texts` VALUES (-1568068, 'Da spirits gonna feast today! Begin da ceremonies, sacrifice da prisoners... make room for our new guests!', NULL, NULL, 'Die Geister werden sich heute gütlich tun, beginnt mit der Zeremonie. Opfert die Gefangenen, macht Platz für unsere neuen Gäste, ahahahaha..haha.', NULL, NULL, NULL, NULL, NULL, 12053, 6, 0, 0, 'zulaman SAY_INST_BEGIN');
INSERT INTO `script_texts` VALUES (-1568067, 'Zul\'jin got a surprise for ya...', NULL, NULL, 'Seid ihr Wahnsinnig, ihr bringt uns alle noch um!', NULL, NULL, NULL, NULL, NULL, 12052, 6, 0, 0, 'zulaman SAY_INST_RELEASE');

INSERT INTO `script_texts` VALUES (-1800509, 'Everybody always wanna take from us. Now we gonna start takin\' back. Anybody who get in our way...gonna drown in dey own blood! Da Amani empire be back now...seekin\' vengeance. And we gonna start wit\' you.', NULL, NULL, 'Alle wollen immer von uns nehmen. Jetzt werden wir anfangen uns etwas zurück zu holen. Wer sich uns in den Weg stellt, erseuft in seinem eigenen Blut. Das Imperium der Amani ist wieder da und sinnt nach Rache. Und mit euch werden wir anfangen!', NULL, NULL, NULL, NULL, NULL, 12090, 6, 0, 0, 'Zuljin YELL_INTRO');
INSERT INTO `script_texts` VALUES (-1800508, 'Mebbe me fall...but da Amani empire...never gonna die...', NULL, NULL, 'Dies... ist mein Ende... aber das Imperium der Amani... wird niemals untergehen...', NULL, NULL, NULL, NULL, NULL, 12100, 6, 0, 0, 'Zuljin YELL_DEATH');
INSERT INTO `script_texts` VALUES (-1800507, 'You too slow! Me too strong!', NULL, NULL, 'Ihr seid zu langsam! Ich zu stark!', NULL, NULL, NULL, NULL, NULL, 12097, 6, 0, 0, 'Zuljin YELL_BERSERK');
INSERT INTO `script_texts` VALUES (-1800506, 'Nobody badduh dan me!', NULL, NULL, 'Keiner kann es mit mir aufnehmen!', NULL, NULL, NULL, NULL, NULL, 12091, 6, 0, 0, 'Zuljin YELL_AGGRO');
INSERT INTO `script_texts` VALUES (-1800505, 'Fire kill you just as quick!', NULL, NULL, 'Das Feuer macht euch den Garaus!', NULL, NULL, NULL, NULL, NULL, 12096, 6, 0, 0, 'Zuljin YELL_FIRE_BREATH');
INSERT INTO `script_texts` VALUES (-1800504, 'Lot more gonna fall like you!', NULL, NULL, 'Noch viele werden euer Schicksal erleiden!', NULL, NULL, NULL, NULL, NULL, 12099, 6, 0, 0, 'Zuljin YELL_KILL_TWO');
INSERT INTO `script_texts` VALUES (-1800503, 'Da Amani de chuka!', NULL, NULL, 'Da Amani de chuka!', NULL, NULL, NULL, NULL, NULL, 12098, 6, 0, 0, 'Zuljin YELL_KILL_ONE');
INSERT INTO `script_texts` VALUES (-1800502, 'Dere be no hidin\' from da eagle!', NULL, NULL, 'Niemand versteckt sich vor dem Adler!', NULL, NULL, NULL, NULL, NULL, 12093, 6, 0, 0, 'Zuljin YELL_TRANSFORM_TO_EAGLE');
INSERT INTO `script_texts` VALUES (-1800501, 'Ya don\' have to look to da sky to see da dragonhawk!', NULL, NULL, 'Was starrt ihr in die Luft? Der Drachenfalke steht schon vor euch!', NULL, NULL, NULL, NULL, NULL, 12095, 6, 0, 0, 'Zuljin YELL_TRANSFORM_TO_DRAGONHAWK');
INSERT INTO `script_texts` VALUES (-1800500, 'Got me some new tricks... like me brudda bear....', NULL, NULL, 'Sagt Hallo zu Bruder Bär!', NULL, NULL, NULL, NULL, NULL, 12092, 6, 0, 0, 'Zuljin YELL_TRANSFORM_TO_BEAR');
INSERT INTO `script_texts` VALUES (-1800499, 'Let me introduce you to me new bruddas: fang and claw!', NULL, NULL, 'Lernt meine Brüder kennen: Reißzahn und Klaue!', NULL, NULL, NULL, NULL, NULL, 12094, 6, 0, 0, 'Zuljin YELL_TRANSFORM_TO_LYNX');

UPDATE `script_texts` SET `content_loc3`='Mehr Eindringlinge! Gebt Alarm!' WHERE (`entry`='-1811003');
UPDATE `script_texts` SET `content_loc3` = 'Der Schatten wird euch verschlingen!' WHERE `entry` = -1800493;
UPDATE `script_texts` SET `content_loc3` = 'Eure Seele wird bluten!' WHERE `entry`  = -1800494;
UPDATE `script_texts` SET `content_loc3` = 'Die Dunkelheit wird euch holen!' WHERE `entry` = -1800495;
UPDATE `script_texts` SET `content_loc3` = 'Aus diesem Alptraum gibt es kein Erwachen!' WHERE `entry` = -1800496;
UPDATE `script_texts` SET `content_loc3` = 'Das ist nicht... mein Ende...' WHERE `entry` = -1800498;
UPDATE `script_texts` SET `content_loc3` = 'Der Schatten wird euch verschlingen!' WHERE `entry` = -1800512;
UPDATE `script_texts` SET `content_loc3` = 'Wenn ihr mich jetzt nicht tötet, habt ihr eure letzte Chance verspielt!' WHERE `entry` = -1800513;
UPDATE `script_texts` SET `content_loc3` = 'Ihr gehört jetzt mir!' WHERE `entry` = -1800514;
UPDATE `script_texts` SET `content_loc3` = 'Das wird nichts ändern.' WHERE `entry` = -1800515;
UPDATE `script_texts` SET `content_loc3` = 'Euer Tot wird noch grausamer.' WHERE `entry` = -1800516;
UPDATE `script_texts` SET `content_loc3` = 'Das lässt mich kalt.' WHERE `entry` = -1800517;

DELETE FROM `waypoint_scripts` WHERE `id` IN (220,221,222,225,8930801,8930301,8931301,8931201,8927801);		
DELETE FROM `waypoint_scripts` WHERE `id` BETWEEN 401 AND 420;		
DELETE FROM `waypoint_scripts` WHERE `id` BETWEEN 501 AND 520;		
INSERT INTO `waypoint_scripts` VALUES 		
(220, 0, 22, 0, 0, 0, 0, 0, 0, 0, 220, 'Creature - Visibilty OFF'),		
(221, 0, 22, 1, 0, 0, 0, 0, 0, 0, 221, 'Creature - Visibilty ON'),		
(222, 0, 22, 2, 0, 0, 0, 0, 0, 0, 222, 'Creature - Visibilty Group Stealth'),		
(225, 0, 22, 5, 0, 0, 0, 0, 0, 0, 225, 'Creature - Visibilty Respawn'),		
		
(401, 0, 4, 46, 1, 0, 0, 0, 0, 0, 401, 'Creature - Add UNIT_FLAG_UNKNOWN7'),		
(402, 0, 4, 46, 2, 0, 0, 0, 0, 0, 402, 'Creature - Add UNIT_FLAG_NON_ATTACKABLE'),		
(403, 0, 4, 46, 4, 0, 0, 0, 0, 0, 403, 'Creature - Add UNIT_FLAG_DISABLE_MOVE'),		
(404, 0, 4, 46, 8, 0, 0, 0, 0, 0, 404, 'Creature - Add UNIT_FLAG_PVP_ATTACKABLE'),		
(405, 0, 4, 46, 16, 0, 0, 0, 0, 0, 405, 'Creature - Add UNIT_FLAG_RENAME'),		
(406, 0, 4, 46, 32, 0, 0, 0, 0, 0, 406, 'Creature - Add UNIT_FLAG_RESTING'),		
(407, 0, 4, 46, 64, 0, 0, 0, 0, 0, 407, 'Creature - Add UNIT_FLAG_UNKNOWN9'),		
(408, 0, 4, 46, 128, 0, 0, 0, 0, 0, 408, 'Creature - Add UNIT_FLAG_NOT_ATTACKABLE_1'),		
(409, 0, 4, 46, 256, 0, 0, 0, 0, 0, 409, 'Creature - Add UNIT_FLAG_NOT_ATTACKABLE_2'),		
(410, 0, 4, 46, 512, 0, 0, 0, 0, 0, 410, 'Creature - Add UNIT_FLAG_PASSIVE'),		
(411, 0, 4, 46, 1024, 0, 0, 0, 0, 0, 411, 'Creature - Add UNIT_FLAG_LOOTING'),		
(412, 0, 4, 46, 2048, 0, 0, 0, 0, 0, 412, 'Creature - Add UNIT_FLAG_PET_IN_COMBAT'),		
(413, 0, 4, 46, 4096, 0, 0, 0, 0, 0, 413, 'Creature - Add UNIT_FLAG_PVP'),		
(414, 0, 4, 46, 8192, 0, 0, 0, 0, 0, 414, 'Creature - Add UNIT_FLAG_SILENCED'),		
(415, 0, 4, 46, 16384, 0, 0, 0, 0, 0, 415, 'Creature - Add UNIT_FLAG_UNKNOWN4'),		
(416, 0, 4, 46, 32768, 0, 0, 0, 0, 0, 416, 'Creature - Add UNIT_FLAG_UNKNOWN13'),		
(417, 0, 4, 46, 65536, 0, 0, 0, 0, 0, 417, 'Creature - Add UNIT_FLAG_NOT_PL_SPELL_TARGET'),		
(418, 0, 4, 46, 131072, 0, 0, 0, 0, 0, 418, 'Creature - Add UNIT_FLAG_PACIFIED'),		
			
(501, 0, 5, 46, 1, 0, 0, 0, 0, 0, 501, 'Creature - Remove UNIT_FLAG_UNKNOWN7'),		
(502, 0, 5, 46, 2, 0, 0, 0, 0, 0, 502, 'Creature - Remove UNIT_FLAG_NON_ATTACKABLE'),		
(503, 0, 5, 46, 4, 0, 0, 0, 0, 0, 503, 'Creature - Remove UNIT_FLAG_DISABLE_MOVE'),		
(504, 0, 5, 46, 8, 0, 0, 0, 0, 0, 504, 'Creature - Remove UNIT_FLAG_PVP_ATTACKABLE'),		
(505, 0, 5, 46, 16, 0, 0, 0, 0, 0, 505, 'Creature - Remove UNIT_FLAG_RENAME'),		
(506, 0, 5, 46, 32, 0, 0, 0, 0, 0, 506, 'Creature - Remove UNIT_FLAG_RESTING'),		
(507, 0, 5, 46, 64, 0, 0, 0, 0, 0, 507, 'Creature - Remove UNIT_FLAG_UNKNOWN9'),		
(508, 0, 5, 46, 128, 0, 0, 0, 0, 0, 508, 'Creature - Remove UNIT_FLAG_NOT_ATTACKABLE_1'),		
(509, 0, 5, 46, 256, 0, 0, 0, 0, 0, 509, 'Creature - Remove UNIT_FLAG_NOT_ATTACKABLE_2'),		
(510, 0, 5, 46, 512, 0, 0, 0, 0, 0, 510, 'Creature - Remove UNIT_FLAG_PASSIVE'),		
(511, 0, 5, 46, 1024, 0, 0, 0, 0, 0, 511, 'Creature - Remove UNIT_FLAG_LOOTING'),		
(512, 0, 5, 46, 2048, 0, 0, 0, 0, 0, 512, 'Creature - Remove UNIT_FLAG_PET_IN_COMBAT'),		
(513, 0, 5, 46, 4096, 0, 0, 0, 0, 0, 513, 'Creature - Remove UNIT_FLAG_PVP'),		
(514, 0, 5, 46, 8192, 0, 0, 0, 0, 0, 514, 'Creature - Remove UNIT_FLAG_SILENCED'),		
(515, 0, 5, 46, 16384, 0, 0, 0, 0, 0, 515, 'Creature - Remove UNIT_FLAG_UNKNOWN4'),		
(516, 0, 5, 46, 32768, 0, 0, 0, 0, 0, 516, 'Creature - Remove UNIT_FLAG_UNKNOWN13'),		
(517, 0, 5, 46, 65536, 0, 0, 0, 0, 0, 517, 'Creature - Remove UNIT_FLAG_NOT_PL_SPELL_TARGET'),		
(518, 0, 5, 46, 131072, 0, 0, 0, 0, 0, 518, 'Creature - Remove UNIT_FLAG_PACIFIED');	
			
-- (8930801, 0, 6, 568, 1, 0, -181.2782, 1273.0632, 1.6089, 3.0394, 8930801, 'Teleport 89308'),
-- (8930301, 0, 6, 568, 1, 0, -171.8750, 1213.3399, 0.1278, 0.7295, 8930301, 'Teleport 89303'),
-- (8931301, 0, 6, 568, 1, 0, -163.5030, 1193.4367, 0.7938, 0.4123, 8931301, 'Teleport 89313');
-- (8931201, 0, 6, 568, 1, 0, -114.6728, 1156.1302, 0.0009, 3.5556, 8931201, 'Teleport 89312');
-- (8927801, 0, 6, 568, 1, 0, -212.178, 1161.06, -1.58448, 1.10716, 8927801, 'Teleport 89278');

-- ======================================================
-- Spawns
-- ======================================================

DELETE FROM `creature` WHERE `guid` IN (99685,99686,89291,16777029,16777030,16777031,16777032,16777033,86225,89119,89295,89296,89297,86194,86914,89272,89275,16777016,16777017,16777018,16777019,16777020,16777021,16777022,16777023,16777024,89280,89281,89282,89283,89273,89281,89282,89267,89266,16777015,99439,16777025,99689,99693,89224,89287,89288,89289,89290,89286,89288,99687,16800636,16777028,99438,16777027,99437,16777026,99436,5735903,86609,89250,89157,17636,20196,31753,31756,31834,33301,1354945,86177,86210,86479,86609,89207,89223,89244,89274,89278,89280,89293,89303,89312,89313,89329,16777193);
INSERT INTO `creature` VALUES
(17636, 24138, 568, 1, 0, 0, 273.399, 1054.89, 0.000612732, 5.66519, 7200, 0, 0, 40000, 0, 0, 0),
(20196, 24138, 568, 1, 0, 0, 275.893, 1058.4, 0.00207663, 5.66519, 7200, 0, 0, 40000, 0, 0, 0),
-- Reuseable
-- INSERT INTO `creature` VALUES (28406, 24043, 568, 1, 0, 0, 425.254, 915.918, 1.42904, 4.27095, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
-- INSERT INTO `creature` VALUES (29104, 24043, 568, 1, 0, 0, 444.624, 919.356, 0.000968, 4.37934, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
-- INSERT INTO `creature` VALUES (29105, 24043, 568, 1, 0, 0, 444.713, 893.398, 0.424363, 3.86255, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
-- INSERT INTO `creature` VALUES (29107, 24043, 568, 1, 0, 0, 452.123, 896.927, 0.470437, 3.24056, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
-- INSERT INTO `creature` VALUES (29108, 24043, 568, 1, 0, 0, 436.483, 980.415, 0.0000249752, 5.43102, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
-- INSERT INTO `creature` VALUES (29109, 24043, 568, 1, 0, 0, 454.153, 1002.42, 1.26073, 4.1948, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
-- INSERT INTO `creature` VALUES (29441, 24043, 568, 1, 0, 0, 441.019, 993.681, 0.000042755, 5.43966, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
-- INSERT INTO `creature` VALUES (29846, 24043, 568, 1, 0, 0, 450.493, 980.478, 0.0602788, 4.5231, 7200, 10, 0, 53000, 0, 0, 1); -- too much cat
(31753, 24043, 568, 1, 0, 0, 396.0724, 868.7962, 0.7103, 5.95802, 7200, 10, 0, 53000, 0, 0, 1),
(31756, 24043, 568, 1, 0, 0, 397.144, 897.193, 0.0827273, 3.57592, 7200, 10, 0, 53000, 0, 0, 1),
(31834, 24043, 568, 1, 0, 0, 379.562, 879.276, -0.041181, 1.02023, 7200, 10, 0, 53000, 0, 0, 1),
(33301, 24043, 568, 1, 0, 0, 398.69, 883.048, 0.000125858, 2.60674, 7200, 10, 0, 53000, 0, 0, 1),
(86177, 24375, 568, 1, 0, 0, 120.687, 1674, 42.0217, 1.59044, 7200, 0, 0, 26000, 0, 0, 0),
(86194, 23597, 568, 1, 0, 0, 138.816, 1587.09, 43.6489, 4.74729, 7200, 0, 0, 86000, 0, 0, 0),
(86210, 24179, 568, 1, 0, 0, 111.692, 1417.37, -2.47524, 3.02313, 7200, 0, 0, 57000, 32310, 0, 0),
(86225, 23746, 568, 1, 19595, 0, 120.857, 1605.62, 43.5857, 4.13643, 7200, 5, 0, 1, 0, 0, 1),
(86479, 24325, 568, 1, 0, 0, 192.938, 1422.35, 15.7245, 5.91667, 300, 0, 0, 1, 0, 0, 0),
(86609, 23576, 568, 1, 0, 0, 16.9616, 1414.6, 11.9265, 6.23082, 6048000, 0, 0, 1700000, 0, 0, 0),
(86914, 23597, 568, 1, 0, 0, 101.955, 1588.22, 43.6776, 4.93928, 7200, 0, 0, 86000, 0, 0, 0),
(89157, 24065, 568, 1, 0, 0, 277.8444, 1054.3112, 0.0000, 5.6494, 7200, 5, 0, 86000, 0, 0, 2),
(89119, 23746, 568, 1, 19595, 0, 424.028, 1092.51, 6.35764, 0.0274122, 7200, 0, 0, 1, 0, 0, 0),
(89207, 24065, 568, 1, 0, 0, 221.267, 1067.83, 0.375, 1.69092, 7200, 5, 0, 86000, 0, 0, 1),
(89223, 23774, 568, 1, 0, 0, -213.016, 1159.9, -1.69267, 0.785406, 7200, 5, 0, 100000, 0, 0, 1), -- movement?
(89224, 22515, 568, 1, 0, 0, -166.024, 1191.63, 0.925669, 2.80998, 7200, 0, 0, 881, 0, 0, 0),
(89244, 23586, 568, 1, 0, 0, -198.805, 1227.37, 1.09097, 1.32645, 7200, 0, 0, 12000, 0, 0, 0),
(89250, 22515, 568, 1, 0, 0, -127.3625, 1168.0448, 0.6862, 5.8765, 7200, 0, 0, 881, 0, 0, 0),
(89272, 14881, 568, 1, 2536, 0, 91.6916, 1725.1, 42.0215, 2.8154, 7200, 5, 0, 8, 0, 0, 1),
(89273, 23746, 568, 1, 19595, 0, 344.2582, 1084.6541, 7.72835, 6.2753, 7200, 0, 0, 1, 0, 0, 0), 
(89274, 23746, 568, 1, 19595, 0, 316.036, 1083.1, 9.97774, 0.222981, 7200, 0, 0, 1, 0, 0, 0),  
(89275, 23746, 568, 1, 0, 0, 423.573, 1142.57, 5.51217, 3.24004, 7200, 0, 0, 1, 0, 0, 0),
(89278, 23586, 568, 1, 0, 0, -212.178, 1161.06, -1.58448, 1.10716, 7200, 0, 0, 12000, 0, 0, 2), -- confirmed moving in video
(89286, 23586, 568, 1, 0, 0, -219.0938, 1380.5607, -0.0554, 1.1772, 7200, 0, 0, 12000, 0, 0, 0),
(89291, 23746, 568, 1, 0, 0, 417.317, 1150.98, 5.26049, 4.8325, 7200, 0, 0, 1, 0, 0, 0),
(89293, 23834, 568, 1, 0, 0, -96.6350, 1116.5039, 5.5939, 0.8997, 1500, 0, 0, 12000, 0, 0, 0),
(89295, 23597, 568, 1, 0, 0, 396.7467, 1046.6815, 9.5216, 6.2792, 1500, 0, 0, 86000, 0, 0, 0), 
(89296, 24065, 568, 1, 0, 0, 401.9991, 1051.1831, 9.5216, 4.6849, 1500, 0, 0, 86000, 0, 0, 0), 
(89297, 23597, 568, 1, 0, 0, 405.0610, 1046.5765, 9.5202, 3.1534, 1500, 0, 0, 86000, 0, 0, 0),
(89303, 23586, 568, 1, 0, 0, -171.875, 1213.34, 0.127825, 3.7951, 7200, 0, 0, 12000, 0, 0, 0), -- confirmed
-- (89305, 23587, 568, 1, 0, 0, -158.279, 1213.58, 0.682461, 1.71346, 7200, 0, 0, 82950, 0, 0, 0); -- jan
-- (89306, 23587, 568, 1, 0, 0, -161.563, 1212.92, 0.193758, 1.81578, 7200, 5, 0, 82950, 0, 0, 1); -- jan
-- (89307, 23587, 568, 1, 0, 0, -161.297, 1190, 1.009, 2.80998, 7200, 0, 0, 82950, 0, 0, 0); -- jan
-- (89309, 23587, 568, 1, 0, 0, -164.396, 1196.36, 1.009, 2.80998, 7200, 0, 0, 82950, 0, 0, 0); -- jan
-- (89310, 23581, 568, 1, 0, 0, 132.874, 1410.11, -4.91132, 0.345519, 7200, 5, 0, 66000, 31550, 0, 1); -- akil
-- (89311, 24179, 568, 1, 0, 0, 115.513, 1404.04, -7.85024, 1.6843, 7200, 0, 0, 57000, 32310, 0, 0); -- akil
(89312, 23586, 568, 1, 0, 0, -107.676, 1154.55, 0.083333, 3.94444, 7200, 0, 0, 12000, 0, 0, 0),
(89313, 23586, 568, 1, 0, 0, -167.522, 1194.68, 0.642452, 5.3058, 7200, 0, 0, 12000, 0, 0, 0),
-- (89326, 24059, 568, 1, 22301, 0, 81.1417, 1147.26, 0.197549, 3.02961, 7200, 5, 0, 86000, 0, 0, 1); -- hala
-- (89327, 23596, 568, 1, 22307, 0, 81.7096, 1144.18, 0.197549, 3.3227, 7200, 0, 0, 69000, 6462, 0, 0); -- hala
-- (89329, 23586, 568, 1, 0, 0, -117.331, 1121.12, 0.0878, 2.26893, 7200, 0, 0, 12000, 0, 0, 0),
-- (XXXXX, 23877, 568, 1, 0, 0, 149.657, 705.75, 45.1948, 3.10669, 604800, 0, 0, 5312, 0, 0, 0); -- static spawn zuljin god 99439
-- (99440, 23878, 568, 1, 0, 0, 134.6, 724.341, 45.1947, 4.06662, 604800, 0, 0, 5312, 0, 0, 0); -- static spawn zuljin god
-- (99441, 23879, 568, 1, 0, 0, 91.133, 705.753, 45.1947, 0.0174533, 604800, 0, 0, 13000, 0, 0, 0); -- static spawn zuljin god
-- (99442, 23880, 568, 1, 0, 0, 105.526, 724.926, 45.1947, 5.35816, 604800, 0, 0, 5312, 0, 0, 0); -- static spawn zuljin god
(99685, 24064, 568, 1, 0, 0, 187.3542, 1182.2142, 3.9117, 1.3901, 7200, 5, 0, 29000, 0, 0, 1),
(99686, 24064, 568, 1, 0, 0, 178.8993, 1177.3803, 0.1803, 1.4372, 7200, 5, 0, 29000, 0, 0, 1),
(99687, 75432, 568, 1, 0, 0, 120.407, 884.102, 33.4115, 1.56701, 300, 0, 0, 1, 0, 0, 0),
-- (99689, 24043, 568, 1, 0, 0, 440.257, 908.198, 0.000133, 4.06911, 7200, 0, 0, 53000, 0, 0, 0),
(99693, 23596, 568, 1, 0, 0, 403.8968, 1093.0825, 6.7059, 3.1537, 1500, 0, 0, 69000, 0, 0, 0);

DELETE FROM `creature` WHERE `id` = 24047;
INSERT INTO `creature` VALUES (86207, 24047, 568, 1, 0, 0, 334.262, 978.604, -2.50742, 5.63074, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (86208, 24047, 568, 1, 0, 0, 317.741, 989.672, -5.39434, 2.02388, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (89204, 24047, 568, 1, 0, 0, 284.695, 1033.79, -3.70402, 0.800363, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (89205, 24047, 568, 1, 0, 0, 298.851, 1023.65, -1.39662, 5.41663, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (89206, 24047, 568, 1, 0, 0, 303.241, 1008.27, -3.27641, 1.64086, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220871, 24047, 568, 1, 0, 0, 364.813, 874.984, -3.22653, 5.57733, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220870, 24047, 568, 1, 0, 0, 338.201, 957.958, -2.70258, 1.96847, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220869, 24047, 568, 1, 0, 0, 355.643, 923.712, -2.52614, 3.14159, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220868, 24047, 568, 1, 0, 0, 361.195, 899.191, -2.56194, 1.85005, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220867, 24047, 568, 1, 0, 0, 280.868, 889.955, -0.348142, 1.97222, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220866, 24047, 568, 1, 0, 0, 281.395, 902.082, 0.469923, 5.84685, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220865, 24047, 568, 1, 0, 0, 272.592, 875.328, -1.3365, 5.2709, 7200, 5, 0, 28561, 0, 0, 1);
INSERT INTO `creature` VALUES (220864, 24047, 568, 1, 0, 0, 289.2145, 870.0304, -1.7992, 2.56563, 7200, 5, 0, 28561, 0, 0, 1);

-- ==========
-- ReGUID
-- ==========

-- Gauntlet
-- INSERT INTO `creature` VALUES (89266, 24217, 568, 1, 0, 0, -92.281, 1418.93, 27.3781, 3.10991, 7200, 0, 0, 42000, 0, 0, 0); -- nalo
INSERT INTO `creature` VALUES (89266, 24175, 568, 1, 0, 0, 208.943, 1466.58, 25.9168, 3.83307, 10800, 0, 0, 14000, 0, 0, 0);
-- INSERT INTO `creature` VALUES (89267, 24217, 568, 1, 0, 0, -88.112, 1419.37, 27.3781, 2.53874, 7200, 0, 0, 42000, 0, 0, 0); -- nalo
INSERT INTO `creature` VALUES (89267, 24549, 568, 1, 0, 0, 302.33, 1385.29, 57.4664, 3.5178, 1500, 0, 0, 140000, 0, 0, 0);
-- (89280, 23586, 568, 1, 0, 0, -197.946, 1325.93, 1.25821, 1.76407, 7200, 5, 0, 12000, 0, 0, 1),
INSERT INTO `creature` VALUES (89280, 24180, 568, 1, 0, 0, 224.54, 1427.66, 28.7058, 1.6481, 1500, 0, 0, 71000, 0, 0, 0);
-- INSERT INTO `creature` VALUES (89281, 1412, 568, 1, 134, 0, -229.353, 1425.05, 0.94149, 0.488692, 7200, 0, 0, 8, 0, 0, 0); -- jan
INSERT INTO `creature` VALUES (89281, 24180, 568, 1, 0, 0, 224.08, 1389.13, 41.9104, 1.65987, 1500, 0, 0, 71000, 0, 0, 0);
-- (89282, 23587, 568, 1, 0, 0, -182.005, 1346.86, 0.629187, 5.46288, 7200, 0, 0, 82950, 0, 0, 0),
INSERT INTO `creature` VALUES (89282, 24180, 568, 1, 0, 0, 246.103, 1368.09, 49.1573, 2.8309, 1500, 0, 0, 71000, 0, 0, 0);
-- (89283, 23586, 568, 1, 0, 0, -219.0938, 1380.5607, -0.0554, 1.1772, 7200, 0, 0, 12000, 0, 0, 0),
INSERT INTO `creature` VALUES (89283, 24180, 568, 1, 0, 0, 285.208, 1374.22, 49.3217, 3.40582, 1500, 0, 0, 71000, 0, 0, 0);
-- INSERT INTO `creature` VALUES (89287, 23586, 568, 1, 0, 2172, -196.992, 1226.94, 0.808015, 1.82899, 10800, 5, 0, 12000, 0, 0, 1); -- jan
INSERT INTO `creature` VALUES (89287, 24179, 568, 1, 0, 2179, 282.614, 1383.56, 49.3217, 3.40079, 1500, 0, 0, 57000, 32310, 0, 0);
-- INSERT INTO `creature` VALUES (89288, 23586, 568, 1, 22983, 0, -170.374, 1239.39, 1.66798, 2.73909, 7200, 5, 0, 12000, 0, 1);
INSERT INTO `creature` VALUES (89288, 24179, 568, 1, 0, 2179, 248.805, 1377.08, 49.3205, 2.85415, 1500, 0, 0, 57000, 32310, 0, 0);
-- INSERT INTO `creature` VALUES (89289, 23586, 568, 1, 0, 0, -212.178, 1161.06, -1.58448, 1.10716, 7200, 5, 0, 12000, 0, 0, 1); -- jan
INSERT INTO `creature` VALUES (89289, 24179, 568, 1, 0, 2179, 232.734, 1388.62, 42.659, 1.55509, 1500, 0, 0, 57000, 32310, 0, 0);
-- INSERT INTO `creature` VALUES (89290, 23587, 568, 1, 0, 0, -114.15, 1164.14, 0.738333, 3.56047, 7200, 0, 0, 82950, 0, 0, 0); -- jan
INSERT INTO `creature` VALUES (89290, 24179, 568, 1, 0, 2179, 232.856, 1427.8, 29.0465, 1.57787, 1500, 0, 0, 57000, 32310, 0, 0);
-- Cage NPCs
INSERT INTO `creature` VALUES (99436, 23999, 568, 1, 0, 0, 406.663, 1504.73, 81.6148, 4.24865, 604800, 0, 0, 11000, 0, 0, 0); -- cage npc
-- (99436, 23999, 568, 1, 0, 0, 296.225, 1468.35, 81.5893, 5.37561, 604800, 0, 0, 11000, 0, 0, 0); Save
-- INSERT INTO `creature` VALUES (16777026, 23999, 568, 1, 0, 0, 406.663, 1504.73, 81.6148, 4.24865, 604800, 0, 0, 4890, 0, 0, 0);
INSERT INTO `creature` VALUES (99437, 24001, 568, 1, 0, 0, 400.589, 1146.05, 6.34083, 4.94645, 604800, 0, 0, 3260, 0, 0, 0); -- cage npc
-- (99437, 24001, 568, 1, 0, 0, 383.776, 1082.97, 6.04766, 1.58825, 604800, 0, 0, 3260, 0, 0, 0); Save
-- INSERT INTO `creature` VALUES (16777027, 24001, 568, 1, 0, 0, 400.589, 1146.05, 6.34083, 4.94645, 237000, 0, 0, 3260, 0, 0, 0);
INSERT INTO `creature` VALUES (99438, 24024, 568, 1, 0, 0, -72.8802, 1176.6, 5.26225, 1.83072, 604800, 0, 0, 5624, 0, 0, 0); -- cage npc
-- (99438, 24024, 568, 1, 0, 0, -73.8207, 1164.74, 5.28789, 4.59022, 604800, 0, 0, 5624, 0, 0, 0); Save
-- INSERT INTO `creature` VALUES (16777028, 24024, 568, 1, 0, 0, -72.8802, 1176.6, 5.26225, 1.83072, 237000, 0, 0, 5624, 0, 0, 0);
INSERT INTO `creature` VALUES (99439, 23790, 568, 1, 0, 0, -145.762, 1335.76, 48.174, 6.17758, 237000, 0, 0, 4890, 0, 0, 0); -- 89157
-- left
-- INSERT INTO `creature` VALUES (16800636, 75432, 568, 1, 0, 0, 120.407, 884.102, 33.4115, 1.56701, 300, 0, 0, 1, 0, 0, 0);

-- ======================================================
-- NPC Research
-- ======================================================

-- World Trigger (Not Immune PC) 21252
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 21252;

-- World Trigger 22515
UPDATE `creature` SET `modelid` = 16925, `spawntimesecs` = 7200, `spawndist` = 0, `MovementType` = 0 WHERE `id` = 22515;
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (89224,89247,86907,89164,89188);

-- Amani'shi Axe Thrower 23542
-- axe volley about 2000-3500 on cloth roughly 1400 physical damage to cloth.
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Axe_Thrower?oldid=1530733
-- http://www.wowhead.com/npc=23542/amanishi-axe-thrower#comments
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 1500 WHERE `id` = 23542;
UPDATE `creature_template` SET `armor` = 6800, `speed` = 1.48, `mindmg` = 1400, `maxdmg` = 1800, `minrangedmg` = 1000, `maxrangedmg` = 2000 WHERE `entry` = 23542; -- 3200 1.15 -- 3,950 - 5,050
DELETE FROM `creature_template_addon` WHERE `entry` = 23542;
INSERT INTO `creature_template_addon` VALUES (23542,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23542;
INSERT INTO `creature_ai_scripts` VALUES (2354201, 23542, 9, 0, 100, 3, 0, 5, 12000, 12000, 11, 31566, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - Cast Raptor Strike');
INSERT INTO `creature_ai_scripts` VALUES (2354202, 23542, 0, 0, 100, 3, 0, 0, 7400, 7400, 11, 35011, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - Cast Knockdown');
INSERT INTO `creature_ai_scripts` VALUES (2354203, 23542, 0, 0, 100, 3, 5000, 15000, 27000, 60000, 11, 42359, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - Cast Axe Volley');
INSERT INTO `creature_ai_scripts` VALUES (2354204, 23542, 0, 0, 100, 3, 1000, 4000, 10000, 18000, 11, 42332, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Axe Thrower - Cast Throw Axe');

-- Amani'shi Warbringer 23580
-- http://www.wowhead.com/npc=23580/amanishi-warbringer#comments
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Warbringer
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 1500 WHERE `id` = 23580;
UPDATE `creature_template` SET `armor` = '6200',`speed` = '1.48',`mindmg` = '5833',`maxdmg` = '6167',`mechanic_immune_mask` = '646002547',`flags_extra` = '1073741824' WHERE `entry` = 23580; -- 4850 1,15 8000 10000 -- 4055 8109 -- 5833 6167-- 35000 37000
DELETE FROM `creature_template_addon` WHERE `entry` = 23580;
INSERT INTO `creature_template_addon` VALUES (23580,0,22467,16777472,0,4097,0,0,''); -- mount 22467
UPDATE `creature_equip_template` SET `equipinfo1` = 218169346, `equipinfo2` = 218169346, `equipslot1` = 3, `equipslot2` = 3 WHERE `entry` = 2169; -- 4278190082 269
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23580;
INSERT INTO `creature_ai_scripts` VALUES (2358001, 23580, 4, 0, 100, 2, 0, 0, 0, 0, 11, 42459, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Cast Dual Wield on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2358002, 23580, 2, 0, 100, 2, 33, 11, 0, 0, 11, 43274, 0, 0, 17, 154, 0, 0, 19, 134217728, 0, 0, 'Amani\'shi Warbringer - Summon Bear + Dismount Warbringer');
INSERT INTO `creature_ai_scripts` VALUES (2358003, 23580, 0, 0, 100, 3, 3000, 6000, 12000, 12000, 11, 43273, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Cast Cleave');
INSERT INTO `creature_ai_scripts` VALUES (2358004, 23580, 0, 0, 100, 3, 5000, 5000, 20000, 20000, 11, 42496, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Cast Furious Roar');
INSERT INTO `creature_ai_scripts` VALUES (2358005, 23580, 2, 0, 100, 2, 30, 0, 0, 0, 11, 40743, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Cast Enrage at 30% HP');
INSERT INTO `creature_ai_scripts` VALUES (2358006, 23580, 2, 0, 100, 2, 5, 0, 0, 0, 18, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Set UNIT_FLAG_MOUNT');
INSERT INTO `creature_ai_scripts` VALUES (2358007, 23580, 1, 0, 100, 2, 10000, 10000, 0, 0, 17, 154, 22467, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Mount OOC');
-- INSERT INTO `creature_ai_scripts` VALUES (2358008, 23580, 11, 0, 100, 2, 0, 0, 0, 0, 18, 134217728, 0, 0, 17, 154, 22467, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Mount on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (2358009, 23580, 7, 0, 100, 2, 0, 0, 0, 0, 43, 22467, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Warbringer - Mount on Reaching Spawnpoint');

-- Amani'shi Medicine Man 23581
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Medicine_Man?direction=next&oldid=1329728
-- http://www.wowhead.com/npc=23581/amanishi-medicine-man#comments
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 1500 WHERE `id` = 23581;
UPDATE `creature_template` SET `minhealth` = 67000, `armor` = 5950, `speed` = 1.48, `mindmg` = 3125, `maxdmg` = 4375, `flags_extra` = 4194304 WHERE `entry` = 23581; -- 66000 3887 1.15 625 3125 0 -- 6,250 - 8,750
DELETE FROM `creature_template_addon` WHERE `entry` = 23581;
INSERT INTO `creature_template_addon` VALUES (23581,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23581;
INSERT INTO `creature_ai_scripts` VALUES (2358101, 23581, 14, 0, 100, 3, 5000, 40, 8000, 16000, 11, 42477, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - Cast Chain Heal');
INSERT INTO `creature_ai_scripts` VALUES (2358102, 23581, 0, 0, 100, 3, 6000, 15000, 10000, 30000, 11, 42478, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - Cast Protective Ward');
INSERT INTO `creature_ai_scripts` VALUES (2358103, 23581, 0, 0, 100, 3, 3000, 15000, 10000, 30000, 11, 42376, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - Cast Powerful Healing Ward');
INSERT INTO `creature_ai_scripts` VALUES (2358104, 23581, 9, 0, 66, 3, 0, 40, 8000, 16000, 11, 45075, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Medicine Man - Cast Lightning Bolt');

-- Amani Protective Ward 23822
-- Creates an immunity shield on nearby friendlies spell1 42480
UPDATE `creature_template` SET `minlevel` = '71',`minhealth` = '2250',`maxhealth` = '2328' WHERE `entry` = 23822;

-- Amani Healing Ward 23757
-- Periodically casts Healing Aura to heal(835/tick) nearby friendlies 42375
UPDATE `creature_template` SET `minlevel` = '71',`minhealth` = '2250',`maxhealth` = '2328', `flags_extra` = 64 WHERE `entry` = 23757;

-- Amani'shi Tribesman 23582
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Tribesman
-- http://www.wowhead.com/npc=23582/amanishi-tribesman#comments
-- dual wield?
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 1500 WHERE `id` = 23582;
UPDATE `creature_template` SET `armor` = '6800',`speed` = '1.48',`mindmg` = '5000',`maxdmg` = '6000',`dynamicflags` = '0'  WHERE `entry` = 23582; -- 4212 1.15 2187.5 4687.5 -- 12,500 - 15,000
DELETE FROM `creature_template_addon` WHERE `entry` = 23582;
INSERT INTO `creature_template_addon` VALUES (23582,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23582;
INSERT INTO `creature_ai_scripts` VALUES (2358201, 23582, 9, 0, 70, 3, 0, 6, 10000, 16000, 11, 42495, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Tribesman - Cast Cyclone Strike');
INSERT INTO `creature_ai_scripts` VALUES (2358202, 23582, 13, 0, 100, 3, 9000, 12000, 0, 0, 11, 36033, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Tribesman - Cast Kick on Target Spell Cast');

-- Amani Bear 23584
-- http://wowwiki.wikia.com/wiki/Amani_Bear
-- http://www.wowhead.com/npc=23584/amani-bear#abilities
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 1500 WHERE `id` = 23584;
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '4017',`maxdmg` = '4765' WHERE `entry` = 23584; -- 1.15 1801 3684 -- 10,029 - 11,912 /2.5
DELETE FROM `creature_template_addon` WHERE `entry` = 23584;
INSERT INTO `creature_template_addon` VALUES (23584,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23584;
INSERT INTO `creature_ai_scripts` VALUES (2358401, 23584, 0, 0, 100, 3, 1000, 1000, 20000, 30000, 11, 42745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear - Cast Frenzy');
INSERT INTO `creature_ai_scripts` VALUES (2358402, 23584, 9, 0, 100, 3, 0, 5, 10000, 20000, 11, 42747, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear - Cast Crunch Armor');

-- Amani'shi Scout 23586- npc_amanishi_scout
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 120, `spawndist` = 0 WHERE `id` = 23586;
-- Static Group Spawns
UPDATE `creature` SET `spawntimesecs` = 1500 WHERE `guid` IN (89191,89244,89284,89285,89286);
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `armor` = '4800',`speed` = '1.20',`mindmg` = '282',`maxdmg` = '563', `mechanic_immune_mask` = '66049', `flags_extra` = '1073741824' WHERE `entry` = 23586; -- 1890 1760 1.15 150 450
DELETE FROM `creature_template_addon` WHERE `entry` = 23586;
INSERT INTO `creature_template_addon` VALUES (23586,0,0,16777472,0,4097,0,0,''); -- moveflags was 16384 falling
-- (XXX,XXX,1,0,100,1,15000,20000,15000,20000,11,42350,0,0,0,0,0,0,0,0,0,0,'Amani\'shi Scout - Cast Throw Skull OOC Visual Event');
-- ('2358601','23586','4','0','100','2','0','0','0','0','1','-141','0','0','4','12104','0','0','11','42177','0','0','Amani\'shi Scout - Yell and Sound and Cast Alert Drums on Aggro'),
-- ('2358602','23586','0','0','100','3','2000','2000','4000','5000','11','16496','1','0','0','0','0','0','0','0','0','0','Amani\'shi Scout - Cast Shoot'),
-- ('2358603','23586','0','0','100','3','6000','6000','20000','24000','11','43205','1','0','0','0','0','0','0','0','0','0','Amani\'shi Scout - Cast Multi-Shot'),

-- Amani'shi Reinforcement 23587
-- should be summoned in the huts from the triggers npcs in there?
-- maybe they used spawnlocations for the spells
-- http://www.wowhead.com/npc=23587/amanishi-reinforcement#comments
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Reinforcement
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `speed` = '1.48',`mindmg` = '4179',`maxdmg` = '4963' WHERE `entry` = 23587; -- 1.15 2252.5 4605 -- 12,537 - 14,889
DELETE FROM `creature_template_addon` WHERE `entry` = 23587;
INSERT INTO `creature_template_addon` VALUES (23587,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23587;
INSERT INTO `creature_ai_scripts` VALUES (2358701, 23587, 9, 0, 50, 3, 0, 5, 8000, 8000, 11, 43298, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Reinforcement - Cast Strike');
INSERT INTO `creature_ai_scripts` VALUES (2358702, 23587, 4, 0, 50, 2, 0, 0, 0, 0, 11, 32323, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Reinforcement - Cast Charge on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2358703, 23587, 11, 0, 100, 2, 0, 0, 0, 0, 38, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Reinforcement - Combat Pulse on Spawn');
INSERT INTO `creature_ai_scripts` VALUES (2358704, 23587, 1, 0, 100, 2, 15000, 15000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Reinforcement - Despawn OOC');

-- Amani'shi Flame Caster 23596
-- interuptable vulnerable to Stun Sap, Sheep, Trap, Fear and can also be MC'ed
UPDATE `creature` SET `modelid`='0',`equipment_id`='0',`spawntimesecs`='1500',`curhealth`='0',`curmana`='0', `curmana` = 6900, `curhealth` = 69000 WHERE `id` = 23596;
UPDATE `creature` SET `id` = 23596, `modelid` = 0 WHERE `guid` = 89331;
UPDATE `creature_template` SET `modelid_A2`='22308',`modelid_H2`='22308',`armor`='5700',`speed`='1.48',`mindmg` = '3750',`maxdmg` = '5250',`flags_extra` = '4194304' WHERE `entry` = 23596; -- 3887 1.15 375 1875 -- 3,750 - 5,250
DELETE FROM `creature_template_addon` WHERE `entry` = 23596;
INSERT INTO `creature_template_addon` VALUES (23596,0,0,512,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23596;
INSERT INTO `creature_ai_scripts` VALUES (2359601, 23596, 0, 0, 100, 3, 1000, 4000, 15000, 30000, 11, 43242, 0, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Flame Caster - Cast Haste');
INSERT INTO `creature_ai_scripts` VALUES (2359602, 23596, 0, 0, 100, 3, 3000, 6000, 7000, 14000, 11, 43240, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Flame Caster - Cast Fireball Volley');
INSERT INTO `creature_ai_scripts` VALUES (2359603, 23596, 0, 0, 100, 3, 1000, 6000, 5000, 9700, 11, 43245, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Flame Caster - Cast Fire Blast');
INSERT INTO `creature_ai_scripts` VALUES (2359604, 23596, 1, 0, 100, 3, 15000, 45000, 60000, 120000, 11, 42220, 4, 32, 5, 11, -1, -1, 0, 0, 0, 0, 'Amani\'shi Flame Caster - Cast Conflagration on Friendly and Laugh OOC'); -- NEEDS TARGET SPELLWORK, TARGETS TROLLS NOT PLAYERS OR THIS IS THE OUT OF COMBAT SPELL THAT CAN BE SEEN IN POVS
INSERT INTO `creature_ai_scripts` VALUES (2359605,23596,4,0,15,2,0,0,0,0,1,-228,-229,-230,0,0,0,0,0,0,0,0,'Amani\'shi Flame Caster - Text on Aggro');

-- Amani'shi Guardian 23597
-- http://www.wowhead.com/npc=23597/amanishi-guardian#comments
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Guardian
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 1500 WHERE `id` = 23597;
UPDATE `creature_template` SET `modelid_A2`='22309',`modelid_H2`='22309',`armor`='7100',`speed`='1.48',`mindmg` = '5000',`maxdmg` = '7000', `baseattacktime`='2000',`mechanic_immune_mask`='787169275',`flags_extra`='1073741824' WHERE `entry` = 23597; -- 6135 1.15 2000 612441851 -- 4501 4876 -- 6,000 - 7,500
DELETE FROM `creature_template_addon` WHERE `entry` = 23597;
INSERT INTO `creature_template_addon` VALUES (23597,0,0,16777472,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23597;
INSERT INTO `creature_ai_scripts` VALUES (2359701, 23597, 0, 0, 100, 2, 2000, 6000, 8000, 16000, 11, 43249, 0, 0, 39, 10, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Cast Startling Roar on Aggro'); -- Call for Help
INSERT INTO `creature_ai_scripts` VALUES (2359702, 23597, 0, 0, 100, 3, 5000, 5000, 12000, 12000, 11, 43246, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Cast Rend');
INSERT INTO `creature_ai_scripts` VALUES (2359703,23597,4,0,15,2,0,0,0,0,1,-228,-229,-9730,0,0,0,0,0,0,0,0,'Amani\'shi Guardian - Text on Aggro');
-- INSERT INTO `creature_ai_scripts` VALUES (2359704, 23597, 15, 0, 100, 3, 0, 30, 0, 0, 11, 23859, 6, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Guardian - Cast Dispel Magic on Friendly CC'); -- 40 17201

-- Zul'Aman Exterior InvisMan 23746
-- DONT MOVE FROM ENTRANCE!
UPDATE `creature` SET `position_x` = '332.5429', `position_y` = '1086.7421' WHERE `guid` = 89186;
UPDATE `creature_template` SET `InhabitType` = 7, `AIName` = 'EventAI' WHERE `entry` = 23746;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23746;
INSERT INTO `creature_ai_scripts` VALUES (2374601, 23746, 8, 0, 100, 2, 43515, -1, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Aman Exterior InvisMan - Die Ashli\'s Fireball Spellhit');
INSERT INTO `creature_ai_scripts` VALUES (2374602, 23746, 8, 0, 100, 2, 43520, -1, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Aman Exterior InvisMan - Die Ashli\'s Fireball Spellhit');
INSERT INTO `creature_ai_scripts` VALUES (2374603, 23746, 8, 0, 100, 2, 43525, -1, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zul\'Aman Exterior InvisMan - Die Ashli\'s Fireball Spellhit');

-- Amani'shi Trainer 23774
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Trainer?oldid=1475310
-- http://www.wowhead.com/npc=23774/amanishi-trainer#comments
UPDATE `creature` SET `id` = 23774, `modelid` = 0,  `spawndist` = 0 WHERE `guid` IN (89122, 89160);
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 1500, `curhealth` = 34000 WHERE `id` = 23774;
UPDATE `creature_template` SET `minhealth` = 34000, `maxhealth` = 35000, `speed` = 1.30, `mindmg` = 4063, `maxdmg` = 5521 WHERE `entry` =  23774; -- 100000 1.15 1407.5 5782.5 -- 12,188 - 16,563
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23774;
INSERT INTO `creature_ai_scripts` VALUES (2377401, 23774, 4, 0, 15, 2, 0, 0, 0, 0, 1, -228, -229, -9730, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Trainer - Text on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2377402, 23774, 9, 0, 100, 3, 0, 30, 4000, 8000, 11, 20989, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Trainer - Cast Sleep');
INSERT INTO `creature_ai_scripts` VALUES (2377403, 23774, 16, 0, 100, 3, 43292, 100, 5000, 15000, 11, 43292, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Trainer - Cast Incite Rage');

-- Dragonhawk God Invisman 23813- Quest
-- flame breath is casted on this npc, change target selection for the spell
UPDATE `creature_template` SET `flags_extra`='128' WHERE `entry` = 23813;

-- Eagle God Invisman 23814- Quest
UPDATE `creature_template` SET `flags_extra`='128' WHERE `entry` = 23814;

-- Lynx God Invisman 23815- Quest
-- if 128 makes the quest still completeable try for 23814 and 23813
UPDATE `creature_template` SET `flags_extra`='128' WHERE `entry` = 23815;

-- Amani Dragonhawk 23834
-- http://wowwiki.wikia.com/wiki/Amani_Dragonhawk
-- www.wowhead.com/npc=23834/amani-dragonhawk
UPDATE `creature` SET `spawntimesecs` = 1500, `modelid` = 0 WHERE `id` = 23834;
UPDATE `creature_template` SET `armor` = '5800',`speed` = '1.37',`mindmg` = '2000',`maxdmg` = '4000' WHERE `entry` = 23834; -- 1854 1.15 1000 3500 -- 
DELETE FROM `creature_template_addon` WHERE `entry` = 23834;
INSERT INTO `creature_template_addon` VALUES (23834, 0, 0, 16777472, 0, 4097, 0, 0, '18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23834;
INSERT INTO `creature_ai_scripts` VALUES
('2383401','23834','0','0','100','3','4000','9000','10000','27500','11','43294','1','0','0','0','0','0','0','0','0','0','Amani Dragonhawk - Cast Flame Breath');

-- Amani'shi Savage 23889
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Savage
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 3600 WHERE `id` = 23889;
UPDATE `creature_template` SET `modelid_A` = '22322',`modelid_H` = '22322',`modelid_A2` = '22324',`modelid_H2` = '22324',`speed`='1.20',`mindmg` = '282',`maxdmg` = '329' WHERE `entry` = 23889; -- 1.15 160 240 -- 760 - 840
DELETE FROM `creature_template_addon` WHERE `entry` = 23889;
INSERT INTO `creature_template_addon` VALUES (23889,0, 0, 16777472, 0, 4097, 0, 0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23889;
INSERT INTO `creature_ai_scripts` VALUES (2388901, 23889, 0, 0, 100, 3, 2000, 7000, 7000, 12000, 11, 9080, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Savage - Cast Hamstring');
INSERT INTO `creature_ai_scripts` VALUES (2388902, 23889, 0, 0, 100, 3, 6000, 11000, 11000, 16000, 11, 12054, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Savage - Cast Rend'); -- 32
INSERT INTO `creature_ai_scripts` VALUES (2388903, 23889, 9, 0, 100, 3, 0, 5, 5000, 9000, 11, 11971, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Savage - Cast Sunder Armor');

-- Amani Lynx 24043
-- stealthed
-- http://wowwiki.wikia.com/wiki/Amani_Lynx
-- http://www.wowhead.com/npc=24043/amani-lynx#comments
UPDATE `creature` SET `spawntimesecs` = 7200, `spawndist` = 5 WHERE `id` =  24043;
UPDATE `creature` SET `position_x` = '429.3981', `position_y` = '994.2989', `position_z` = '1.1951' WHERE `guid` = 235; 
UPDATE `creature_template` SET `minlevel` = '70',`armor` = '5800',`maxdmg` = '4500' WHERE `entry` = 24043; -- 69 4125 2500 3500
DELETE FROM `creature_template_addon` WHERE `entry` = 24043;
INSERT INTO `creature_template_addon` VALUES (24043,0,0,16777472,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24043;
INSERT INTO `creature_ai_scripts` VALUES (2404301, 24043, 4, 0, 100, 2, 0, 0, 0, 0, 28, 0, 42866, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx - Remove Stealth on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2404302, 24043, 9, 0, 100, 3, 0, 5, 11000, 22000, 11, 43357, 4, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx - Cast Feral Swipe');
INSERT INTO `creature_ai_scripts` VALUES (2404303, 24043, 1, 0, 100, 2, 0, 0, 0, 0, 11, 42866, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Lynx - Cast Stealth OOC');

-- Amani Crocolisk 24047
-- http://wowwiki.wikia.com/wiki/Amani_Crocolisk
-- http://www.wowhead.com/npc=24047/amani-crocolisk#comments
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `curhealth` = 28561 WHERE `id` = 24047;
UPDATE `creature_template` SET `minhealth` = '28561',`maxhealth` = '29561',`speed` = '1.20',`mindmg` = '1876',`maxdmg` = '2251', `AIName` = 'EventAI', `mechanic_immune_mask` = '8402000' WHERE `entry` = 24047; --  19561 1.15 1125 2625
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24047;
INSERT INTO `creature_ai_scripts` VALUES (2404701, 24047, 4, 0, 100, 2, 0, 0, 0, 0, 39, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Crocolisk - Call for Help on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2404702, 24047, 0, 0, 100, 3, 5000, 5000, 13000, 13000, 11, 43352, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Crocolisk - Cast Tail Swip'); -- recheck spell
INSERT INTO `creature_ai_scripts` VALUES (2404703, 24047, 0, 0, 100, 3, 1000, 1000, 24000, 24000, 11, 43353, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Crocolisk - Cast Infected Bite');

-- Amani'shi Beast Tamer 24059
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Beast_Tamer
-- http://www.wowhead.com/npc=24059/amanishi-beast-tamer#comments
UPDATE `creature` SET `id` = 24059, `modelid` = 0 WHERE `guid` IN (245,243);
UPDATE `creature` SET `spawntimesecs` = 7200, `equipment_id` = 0 WHERE `id` = 24059;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4063',`maxdmg`='5521',`mechanic_immune_mask`='75498832' WHERE `entry` = 24059; -- 5000 7000
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24059;
INSERT INTO `creature_ai_scripts` VALUES (2405901, 24059, 0, 0, 100, 3, 3000, 9000, 9000, 18000, 11, 43361, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Beast Tamer - Cast Domesticate');
INSERT INTO `creature_ai_scripts` VALUES (2405902, 24059, 0, 0, 100, 3, 5000, 10000, 10000, 15000, 11, 43359, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Beast Tamer - Cast Eye of The Beast');

-- Amani Lynx Cub 24064
-- not all are stealthed
UPDATE `creature` SET `id` = 24064, `modelid` = 0 WHERE `guid` IN (169,171);
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id`  = 24064;
UPDATE `creature_addon` SET `auras` = '42943 0' WHERE `guid` IN (89135,89200,88652,89176,89141,86198,87043,86922,89172,89177,89175,89173,86921,89145);
UPDATE `creature_template` SET `armor` = '4800',`speed` = '1.48' WHERE `entry` = 24064; -- 1850 2 -- 1500 2500 --
DELETE FROM `creature_template_addon` WHERE `entry` = 24064;
INSERT INTO `creature_template_addon` VALUES (24064, 0, 0, 16908544, 0, 4097, 0, 0, '');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24064;
INSERT INTO `creature_ai_scripts` VALUES
-- ('2406401','24064','1','0','100','2','0','0','1000','1000','11','42943','0','0','0','0','0','0','0','0','0','0','Amani Lynx Cub - Cast Stealth on Spawn'),
('2406402','24064','4','0','100','2','0','0','0','0','28','0','42943','0','11','43317','0','0','0','0','0','0','Amani Lynx Cub - Remove Stealth Aura and Cast Dash on Aggro'),
('2406403','24064','0','0','50','3','5000','15000','5000','15000','11','43358','1','0','0','0','0','0','0','0','0','0','Amani Lynx Cub - Cast Gut Rip');

-- Amani'shi Handler 24065
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 7200 WHERE `id` = 24065;
UPDATE `creature_template` SET `armor`='7000',`speed`='1.48',`mindmg`='4063',`maxdmg`='5521',`baseattacktime`='1400',`mechanic_immune_mask`='612439667' WHERE `entry` = 24065; -- 4850 1.15 1250 6250 2000 70259 -- 12,500 - 17,500
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24065;
INSERT INTO `creature_ai_scripts` VALUES
('2406501','24065','9','0','100','3','0','5','10200','23200','11','43364','4','32','0','0','0','0','0','0','0','0','Amani\'shi Handler - Cast Tranquilizing Poison'),
('2406502','24065','9','0','100','3','0','35','9000','9000','11','43362','4','0','0','0','0','0','0','0','0','0','Amani\'shi Handler - Cast Electrified Net');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (-24002,-24003,-43364);
INSERT INTO `spell_linked_spell` VALUES
(-24002, 8064, 0, 'Sleepy on Tranquilizing Poison Expire'),
(-24003, 8064, 0, 'Sleepy on Tranquilizing Poison Expire'),
(-43364, 8064, 0, 'Sleepy on Tranquilizing Poison Expire');

-- Tamed Amani Crocolisk 24138
-- http://wow.gamepedia.com/index.php?title=Tamed_Amani_Crocolisk&oldid=1555913
-- http://www.wowhead.com/npc=24138/tamed-amani-crocolisk#comments
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` = 24138;
UPDATE `creature_template` SET `armor`='6792',`speed`='1.48',`unit_flags`='32832',`lootid`='24138',`skinloot`='24138',`mingold`='0',`maxgold`='0' WHERE `entry` = 24138; -- 0 1 20000 40000
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24138;
INSERT INTO `creature_ai_scripts` VALUES
(2413801,24138,9,0,100,3,0,5,10000,15000,11,43353,1,0,0,0,0,0,0,0,0,0,'Tamed Amani Crocolisk - Cast Infected Bite'),
(2413802,24138,0,0,100,3,5000,5000,6000,15000,11,43352,5,0,0,0,0,0,0,0,0,0,'Tamed Amani Crocolisk - Cast Tail Swipe'); -- spell bugged should be behind only

-- Amani'shi Wind Walker 24179 
-- http://www.wowhead.com/npc=24179/amanishi-wind-walker#comments
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Wind_Walker
UPDATE `creature` SET `equipment_id` = 2179, `spawntimesecs` = 1500 WHERE `guid` = 86210;
UPDATE `creature_template` SET `armor` = '5714',`speed` = '1.48',`mindmg` = '3750',`maxdmg` = '4583' WHERE `entry` = 24179; -- 2480 1.15 1875 4375 -- 11,250 - 13,750
DELETE FROM `creature_template_addon` WHERE `entry` = 24179;
INSERT INTO `creature_template_addon` VALUES (24179, 0, 0, 512, 0, 4097, 0, 0, '18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24179;
INSERT INTO `creature_ai_scripts` VALUES (2417901, 24179, 4, 0, 15, 2, 0, 0, 0, 0, 1, -228, -229, -9730, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Wind Walker - Text on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2417902, 24179, 2, 0, 100, 3, 80, 0, 8000, 16000, 11, 43527, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Wind Walker - Cast Chain Heal');
INSERT INTO `creature_ai_scripts` VALUES (2417903, 24179, 9, 0, 100, 3, 0, 20, 4000, 8000, 11, 43524, 4, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Wind Walker - Cast Frost Shock');
INSERT INTO `creature_ai_scripts` VALUES (2417904, 24179, 0, 0, 100, 3, 5000, 5000, 9000, 17500, 11, 43526, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Wind Walker - Cast Lightning Bolt');

-- Amani'shi Protector 24180
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Protector
-- http://www.wowhead.com/npc=24180/amanishi-protector#abilities
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`mindmg` = '4771',`maxdmg` = '6813',`modelid_A2`='22264',`modelid_H2`='22263',`equipment_id`='8101' WHERE `entry` = 24180; --  3965 1 1282.5 7407.5 0 0 -- 14,313 - 20,438
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24180;
INSERT INTO `creature_ai_scripts` VALUES
(2418001, 24180, 4, 0, 15, 2, 0, 0, 0, 0, 1, -228, -229, -9730, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - Text on Aggro'),
(2418002, 24180, 4, 0, 100, 2, 0, 0, 0, 0, 34, 24, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - Set Instance Data on Aggro'),
(2418003, 24180, 0, 0, 100, 3, 4000, 6000, 12000, 18000, 11, 15496, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - Cast Cleave'),
(2418004, 24180, 9, 0, 100, 3, 0, 5, 10000, 15000, 11, 43529, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - Cast Mortal Strike'),
(2418005, 24180, 0, 0, 100, 3, 10000, 20000, 20000, 40000, 11, 43530, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Protector - Cast Piercing Howl');
DELETE FROM `creature_equip_template` WHERE `entry` = 8101;
INSERT INTO `creature_equip_template` VALUES
(8101,46789,32560,0,218171138,234948100,0,3,1038,0);

-- Amani Bear Mount 24217
-- http://www.wowhead.com/npc=24217/amani-bear-mount#comments
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Bear_Mount misleading
UPDATE `creature_template` SET `armor` = '6200',`speed` = '1.48',`mindmg` = '4167',`maxdmg` = '5833',`mechanic_immune_mask` = '1029',`flags_extra` = '1073741824' WHERE `entry` = 24217; -- 0 1.15 1250 6250 -- 12,500 - 17,500
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24217;
INSERT INTO `creature_ai_scripts` VALUES (2421701, 24217, 0, 0, 100, 3, 1000, 2000, 10000, 15000, 11, 42747, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear Mount - Cast Crunch Armor');
INSERT INTO `creature_ai_scripts` VALUES (2421702, 24217, 0, 0, 100, 3, 10000, 15000, 15000, 25000, 11, 42745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear Mount - Cast Enrage');
INSERT INTO `creature_ai_scripts` VALUES (2421703, 24217, 7, 0, 100, 2, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear Mount - Despawn on Evade');
INSERT INTO `creature_ai_scripts` VALUES (2421704, 24217, 1, 0, 100, 3, 0, 0, 1000, 1000, 103, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Bear Mount - Aggro Pulse OOC');

-- Dragonhawk Egg 24312
-- http://www.wowhead.com/npc=24312/dragonhawk-egg
-- doesnt work atm as dragon hawk hatchling is hardcoded for bossfight
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 1500 WHERE `id` = 24312;
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel` = 70, `faction_A` = '1890',`faction_H` = '1890',`unit_flags` = 33554692,`AIName` = 'EventAI' WHERE `entry` = 24312;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24312;
-- INSERT INTO `creature_ai_scripts` VALUES (2431201, 24312, 4, 0, 100, 2, 0, 0, 0, 0, 11, 42493, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Dragonhawk Egg - Summon Dragonhawk Hatchling on Aggro');

-- harrison jones #2
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|128 WHERE `entry` = 24358; -- not used npc harrison jones without hat

-- Amani'shi Berserker 24374
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Berserker
UPDATE `creature` SET `spawntimesecs`='3300' WHERE `id` = 24374;
UPDATE `creature_template` SET `armor` = '6792',`speed`='1.48',`mindmg` = '8000',`maxdmg` = '12000',`mechanic_immune_mask`='787431423',`flags_extra` = `flags_extra`|1073741824 WHERE `entry` = 24374; -- 6000 1 612441851 6000 8500 -- 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24374;
INSERT INTO `creature_ai_scripts` VALUES (2437401, 24374, 0, 0, 100, 3, 1000, 3000, 2000, 10000, 11, 43673, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - Cast Mighty Blow');
INSERT INTO `creature_ai_scripts` VALUES (2437402, 24374, 2, 0, 100, 2, 30, 0, 0, 0, 11, 28747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani\'shi Berserker - Cast Enrage'); -- should be enrage 28747

-- Amani Elder Lynx 24530
-- http://wowwiki.wikia.com/wiki/Amani_Elder_Lynx
-- http://www.wowhead.com/npc=24530/amani-elder-lynx#comments
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 24530;
UPDATE `creature_template` SET `armor` = '6792',`mechanic_immune_mask` = '75578962',`flags_extra` = '1073741824' WHERE `entry` = 24530; -- 3580 3500 4500
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24530;
INSERT INTO `creature_ai_scripts` VALUES (2453001, 24530, 2, 0, 100, 3, 30, 0, 90000, 90000, 11, 34970, 0, 0, 1, -46, 0, 0, 0, 0, 0, 0, 'Amani Elder Lynx - Cast Enrage at 30% HP');
INSERT INTO `creature_ai_scripts` VALUES (2453002, 24530, 9, 0, 100, 3, 0, 5, 5000, 15000, 11, 43357, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Elder Lynx - Cast Feral Swipe');
INSERT INTO `creature_ai_scripts` VALUES (2453003, 24530, 0, 0, 100, 3, 1500, 3500, 9000, 13000, 11, 43356, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Amani Elder Lynx - Cast Pounce');

-- Zul'Aman Door Trigger
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 25173;

-- ==============
-- Akilzon Gauntlet Event
-- ==============

-- Eagle Troll Spawn Target
-- Used as Gauntlet Combat Trigger
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|4, `AIName`='EventAI' WHERE `entry` = 24325;
DELETE FROM `creature_template_addon` WHERE `entry` = 24325;
INSERT INTO `creature_template_addon` VALUES
(24325,0,0,0,0,0,0,0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24325;
INSERT INTO `creature_ai_scripts` VALUES
('2432501','24325','4','0','100','2','0','0','0','0','20','0','0','0','0','0','0','0','0','0','0','0','Eagle Troll Spawn Target - Stop Melee on Aggro'),
('2432502','24325','0','0','100','2','120000','120000','0','0','37','0','0','0','0','0','0','0','0','0','0','0','Eagle Troll Spawn Target - Despawn IC');
-- ('2432501','24325','4','0','100','2','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Eagle Troll Spawn Target - Delayed Despawn on Aggro');

-- Amani'shi Lookout 24175- npc_amanishi_lookout
-- http://www.wowhead.com/npc=24175/amanishi-lookout#english-comments
UPDATE `creature` SET `spawntimesecs` = 1 WHERE `id` = 24175;
UPDATE `creature_template` SET `speed` = 1.48, `unit_flags` = 163906, `equipment_id` = 8100, `flags_extra` = 0 WHERE `entry` = 24175; -- uf 131074 ef 0
DELETE FROM `creature_template_addon` WHERE `entry` = 24175;
INSERT INTO `creature_template_addon` VALUES (24175,0,0,16777472,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `creature_equip_template` WHERE `entry` = 8100;
INSERT INTO `creature_equip_template` VALUES
(8100,40401,0,0,285279746,0,0,2,0,0);

-- Amani Eagle 24159- npc_amani_eagle
-- http://www.wowhead.com/npc=24159/amani-eagle#comments
-- http://wowwiki.wikia.com/wiki/Amani_Eagle
-- 5 or 6 or (8) are summoned every 10-15 Spell 43517
UPDATE `creature_template` SET `speed` = '1.20' WHERE `entry` = 24159; -- 1

-- Amani'shi Warrior 24225- npc_amanishi_warrior
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Warrior
-- http://www.wowhead.com/npc=24225/amanishi-warrior#abilities 43518 43519
UPDATE `creature_template` SET `minhealth` = '23116',`maxhealth` = '25116',`speed` = '1.48',`mindmg` = '2563',`maxdmg` = '3938' WHERE `entry` = 24225; -- 17116 1 500 6000 -- 10,250 - 15,750

-- Amani'shi Tempest 24549
-- http://wowwiki.wikia.com/wiki/Amani'shi_Tempest
-- spawn 2 npcs on timer ic ~ 30secs or so then all ~ 20secs
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`mindmg`='3295',`maxdmg`='6589',`baseattacktime`='1500',`mechanic_immune_mask`='787169275',`flags_extra`='65536',`unit_flags`='0',`equipment_id`='8102' WHERE `entry` = 24549; -- dualwielder equipment_id fehlt  2600 1 1250 6250 2000 71283 0 0
DELETE FROM `creature_equip_template` WHERE `entry` = 8102;
INSERT INTO `creature_equip_template` VALUES
(8102,46982,46982,0,218173186,218173186,0,3,3,0);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24549;
INSERT INTO `creature_ai_scripts` VALUES
(2454901,24549,4,0,100,2,0,0,0,0,34,24,11,0,11,29651,0,0,0,0,0,0,'Amani\'shi Tempest - Set Instance Data and Cast Dual Wield on Aggro'),
(2454902,24549,6,0,100,2,0,0,0,0,34,24,12,0,0,0,0,0,0,0,0,0,'Amani\'shi Tempest - Set Instance Data on Death'),
(2454903,24549,7,0,100,2,0,0,0,0,34,24,0,0,0,0,0,0,0,0,0,0,'Amani\'shi Tempest - Set Instance Data on Evade'),
(2454904,24549,9,0,100,3,0,5,5000,10000,11,44033,0,0,0,0,0,0,0,0,0,0,'Amani\'shi Tempest - Cast Thunder Clap');

-- ====================
-- Time Event Npcs
-- ====================

-- Harkor 23999

-- Harkor's Corpse 24443

-- http://www.wowhead.com/object=186748/bakkalzus-brew-keg#comments

-- Tanzar 23790

-- Tanzar's Corpse 24442

-- Ashli 24001- npc_ashli
UPDATE `creature_template` SET `speed` = '1.20' WHERE `entry` = 24001; -- 2.75
-- Ashli's Spells
DELETE FROM `spell_script_target` WHERE `entry` IN (43520, 43525, 43515);
INSERT INTO `spell_script_target` VALUES
(43515, 1, 23746),
(43520, 1, 23746),
(43525, 1, 23746);

-- Ashli's Corpse 24441

-- Kraz 24024- npc_kraz
UPDATE `creature_template` SET `speed` = '1.20' WHERE `entry` = 24024; -- 2.5

-- Kraz's Corpse 24444

-- 24851
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel` = 70, `minhealth` = 13337, `maxhealth` = 13337, `rank` = 1, `equipment_id` = 8103 WHERE `entry` = 24851;

-- ====================
-- Bosses
-- ====================

-- Akil'zon 23574- boss_akilzon
-- http://wowwiki.wikia.com/wiki/Akil%27zon_(original)?oldid=1576590
UPDATE `creature_template` SET `speed` = '2',`mindmg` = '6000',`maxdmg` = '7000',`mechanic_immune_mask` = '650854239' WHERE `entry` = 23574; -- 1.15 7000 8500 -- 

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (43622, 44008, 45213);
INSERT INTO `spell_linked_spell` VALUES
-- (43648, 45213, 1, 'Storm Eye Visual'); not needed currently
(43622, 44008, 0, 'Static Disruption Debuff'), 
(43622, 45265, 1, 'Static Disruption Chaining Visual');

-- Soaring Eagle 24858- mob_akilzon_eagle
UPDATE `creature_template` SET `speed` = '1.2' WHERE `entry` = 24858; -- 1

-- Nalorakk 23576- boss_nalorakk
UPDATE `creature_template` SET `speed` = '2',`mindmg` = '6000',`maxdmg` = '9000',`mechanic_immune_mask` = '650854239' WHERE `entry` = 23576; -- 1.15 7500 9000 -- 4688 - 6563

-- Jan'alai 23578- boss_janalai
UPDATE `creature` SET `modelid`='0' WHERE `id` = 23578;
UPDATE `creature_template` SET `speed`='2',`mechanic_immune_mask`='650854239',`mindmg` = '6000',`maxdmg` = '7000' WHERE `entry` = 23578; -- 5000 6500 -- 

-- Amani'shi Hatcher 23818- mob_janalai_hatcher
-- http://www.wowhead.com/npc=23818/amanishi-hatcher#english-comments
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Hatcher
-- they both go to the same side when no eggs are left on one side
UPDATE `creature_template` SET `armor`='6792',`speed`='1.20' WHERE `entry` = 23818;

-- Amani Dragonhawk Hatchling 23598- mob_janalai_hatchling
-- http://wow.gamepedia.com/index.php?title=Amani_Dragonhawk_Hatchling&oldid=1553570
-- http://www.wowhead.com/npc=23598/amani-dragonhawk-hatchling#comments
-- http://wowwiki.wikia.com/wiki/Amani_Dragonhawk_Hatchling
UPDATE `creature_template` SET `maxhealth` = '8000',`speed` = '1.20',`AIName`='',`ScriptName`='mob_janalai_hatchling',`flags_extra` = '268435456' WHERE `entry` = 23598; -- 7800 1.15 1000 3100
DELETE FROM `creature_template_addon` WHERE `entry` = 23598;
INSERT INTO `creature_template_addon` VALUES (23598, 0, 0, 512, 0, 4097, 0, 1024, ''); -- moveflag 1024
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23598;
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('2359801','23598','1','0','100','3','1000','1000','2000','2000','38','0','0','0','0','0','0','0','0','0','0','0','Amani Dragonhawk Hatchling - DoZoneInCombat OOC'),
-- ('2359801','23598','1','0','100','3','1000','1000','2000','2000','103','200','0','0','0','0','0','0','0','0','0','0','Amani Dragonhawk Hatchling - Aggro Pulse OOC'),
-- ('2359802','23598','1','0','100','2','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Amani Dragonhawk Hatchling - Despawn OOC'),
-- ('2359803','23598','0','0','100','3','7000','9000','7000','9000','11','43299','4','0','0','0','0','0','0','0','0','0','Amani Dragonhawk Hatchling - Cast Flame Buffet'),
-- ('2359804','23598','7','0','100','2','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Amani Dragonhawk Hatchling - Despawn on Evade');

-- Fire Bomb (Zul'Aman) 23920- mob_janalai_firebomb
-- some firebombs dont despawn properly might be a problem when wiping

-- Dragonhawk Egg 23817- mob_janalai_egg

-- Halazzi 23577- boss_halazzi
UPDATE `creature_template` SET `mindmg` = '7000',`maxdmg` = '9000', `speed` = '2' WHERE `entry` = 23577; -- 1.15 7500 9000 -- 3376 6751
DELETE FROM `creature_equip_template` WHERE `entry` = 8103;
INSERT INTO `creature_equip_template` VALUES (8103,32722,32581,0,218171138,218171138,0,3,3,0);

-- Spirit of the Lynx 24143- (mob_halazzi_lynx outdated)
UPDATE `creature_template` SET `mindmg` = '4459',`maxdmg` = '6329', `speed` = '1.48', `AIName` = 'EventAI', `ScriptName` = '' WHERE `entry` = 24143; -- 1.3 1500 4500 -- 8.918 - 12.657
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24143;
INSERT INTO `creature_ai_scripts` VALUES
('2414301','24143','11','0','100','2','0','0','0','0','42','1','1','0','0','0','0','0','0','0','0','0','Spirit of the Lynx - Set Invincible at 1% HP on Spawn'),
('2414302','24143','0','0','100','3','10000','20000','20000','30000','11','43290','0','0','0','0','0','0','0','0','0','0','Spirit of the Lynx - Cast Lynx Flurry'),
('2414303','24143','0','0','100','3','3000','4000','3000','4000','11','43243','1','0','0','0','0','0','0','0','0','0','Spirit of the Lynx - Cast Shred Armor');

-- Corrupted Lightning Totem 24224 Spell 43302
UPDATE `creature_template` SET `minhealth` = 9000, `maxhealth` = 9000, `mechanic_immune_mask` = '1073725439',`flags_extra` = '4194304' WHERE `entry` = 24224;
UPDATE `creature_ai_scripts` SET `event_param3` = 1500, `event_param4` = 2000 WHERE `id` = 2422401; -- 2000 2000

-- Hex Lord Malacrass 24239- boss_hexlord_malacrass
-- http://wowwiki.wikia.com/wiki/Hex_Lord_Malacrass_(original)?direction=next&oldid=1533677
UPDATE `creature` SET `modelid` = 0 WHERE `id` = 24239;
UPDATE `creature_template` SET `speed` = 2, `mindmg` = '8000', `maxdmg` = '9000' WHERE `entry` = 24239; -- 1 5000 6500

-- Alyson Antille 24240- boss_alyson_antille
-- http://wowwiki.wikia.com/wiki/Alyson_Antille
-- http://www.wowhead.com/npc=24240/alyson-antille#comments
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '833',`maxdmg` = '1167', `mechanic_immune_mask` = '1' WHERE `entry` = 24240; -- 250 1250 -- 2,500 - 3,500

-- Thurg 24241- boss_thurg 
-- http://wowwiki.wikia.com/wiki/Thurg 
-- http://www.wowhead.com/npc=24241/thurg
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '1667',`maxdmg` = '2333',`mechanic_immune_mask` = '1', `resistance6` = '30' WHERE `entry` = 24241; -- 1 500 2500 -- 5,000 - 7,000

-- Slither 24242- boss_slither
-- http://www.wowhead.com/npc=24242/slither
-- http://wowwiki.wikia.com/wiki/Slither
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '1000',`maxdmg` = '1667',`mechanic_immune_mask` = '1' WHERE `entry` = 24242; -- 1 0 2000 -- 3,000 - 5,000

-- Lord Raadan 24243- boss_lord_raadan
-- http://www.wowhead.com/npc=24243/lord-raadan
-- http://wowwiki.wikia.com/wiki/Lord_Raadan
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '1500',`maxdmg` = '1833',`mechanic_immune_mask` = '1' WHERE `entry` = 24243; -- 1 750 1750 -- 4,500 - 5,500

-- Gazakroth 24244- boss_gazakroth
-- http://www.wowhead.com/npc=24244/gazakroth
-- http://wowwiki.wikia.com/wiki/Gazakroth
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '210',`maxdmg` = '230',`mechanic_immune_mask` = '1' WHERE `entry` = 24244; -- 1 45 65 -- 210 - 230

-- Fenstalker 24245- boss_fenstalker
-- http://www.wowhead.com/npc=24245/fenstalker
-- http://wowwiki.wikia.com/wiki/Fenstalker
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '1500',`maxdmg` = '1833', `mechanic_immune_mask` = '1' WHERE `entry` = 24245; -- 1 750 1750 -- 4,500 - 5,500

-- Darkheart 24246- boss_darkheart
-- http://www.wowhead.com/npc=24246/darkheart
-- http://wowwiki.wikia.com/wiki/Darkheart
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '2492',`maxdmg` = '2942',`mechanic_immune_mask` = '8388625' WHERE `entry` = 24246; -- 1363 2713 -- 7,475 - 8,825

-- Koragg 24247- boss_koragg
-- http://www.wowhead.com/npc=24247/koragg
-- http://wowwiki.wikia.com/wiki/Koragg
UPDATE `creature_template` SET `speed` = '1.48',`mindmg` = '2200',`maxdmg` = '2600',`mechanic_immune_mask` = '8388625' WHERE `entry` = 24247; -- 1 1200 2400 -- 6,600 - 7,800

-- Zul'jin 23863- boss_zuljin
-- dmg calc with spell 15576
-- Recheck Models of Spells 42594,42606,42607,42608 due to correct hitbox size
-- Spell Changed Models dont change bounding_radius or combat_reach
-- UPDATE `creature_model_info` SET `bounding_radius`='1',`combat_reach` = '1' WHERE `modelid`=21899; #Troll
-- UPDATE `creature_model_info` SET `bounding_radius`='1',`combat_reach` = '1' WHERE `modelid`=21736; #Bear
-- UPDATE `creature_model_info` SET `bounding_radius`='1',`combat_reach` = '1' WHERE `modelid`=22257; #Eagle
-- UPDATE `creature_model_info` SET `bounding_radius`='2',`combat_reach` = '2' WHERE `modelid`=21907; #Lynx
-- UPDATE `creature_model_info` SET `bounding_radius`='7',`combat_reach` = '7' WHERE `modelid`=21901; #Dragonhawk
-- http://wowwiki.wikia.com/wiki/Zul%27jin_(raid_tactics)?direction=next&oldid=1299860
UPDATE `creature` SET `curhealth` = 1700000 WHERE `id` = 23863;
UPDATE `creature` SET `position_x` = '119.959000', `position_y` = '675.840942', `position_z` = '52.161823', `orientation` = '1.559990' WHERE `guid` = 89358; -- 120.132004 664.015015 51.702301 1.580600
UPDATE `creature_template` SET `minhealth`='1700000', `maxhealth`='1700000', `speed`='2',`mindmg`='9000',`maxdmg`='10000' WHERE `entry` = 23863; -- 1600000 1 2000 6000 -- 5625 7275! -- 14,000 - 18,000

-- Amani Lynx Spirit, Amani Bear Spirit, Amani Dragonhawk Spirit, Amani Eagle Spirit 23877,23878,23879,23880
UPDATE `creature_template` SET `minlevel` = '73',`maxlevel` = '73',`minhealth` = '5312',`maxhealth` = '5312', `faction_A` = '1665',`faction_H` = '1665', `unit_flags` = 33554434 WHERE `entry` IN (23877,23878,23879,23880);

DELETE FROM `spell_script_target` WHERE `entry` = 42542;
INSERT INTO `spell_script_target` VALUES (42542, 1, 23863);

-- Feather Vortex 24136- mob_zuljin_vortex
UPDATE `creature_template` SET `minhealth` = '100000',`maxhealth` = '100000', `speed`='1.00', `unit_flags` = '33554432', `mechanic_immune_mask` = '1073741823', `flags_extra` = '524352', `AIName` = '', `ScriptName` = 'mob_zuljin_vortex' WHERE `entry` = 24136; -- 1 2 0 0 0
DELETE FROM `creature_template_addon` WHERE `entry` = 24136;
INSERT INTO `creature_template_addon` VALUES (24136, 0, 0, 0, 0, 0, 0, 0, '43120 0 43119 0');
-- DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24136;
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('2413601','24136','4','0','100','2','0','0','0','0','13','100','4','0','20','0','0','0','0','0','0','0','Feather Vortex - Attack Random and Stop Melee on Aggro'),
-- ('2413602','24136','9','0','100','3','0','5','10000','10000','14','-99','1','0','13','100','4','0','0','0','0','0','Feather Vortex - Drop Threath and Start Attack Random in Melee Range');

-- Amani'shi Savage 75433- mob_amanshi_savage
-- http://wowwiki.wikia.com/wiki/Amani%27shi_Savage
UPDATE `creature_template` SET `modelid_A` = '22322',`modelid_H` = '22322',`modelid_A2` = '22324',`modelid_H2` = '22324',`speed`='1.20',`mindmg` = '282',`maxdmg` = '329' WHERE `entry` = 75433; -- 1.15 160 240 -- 760 - 840
DELETE FROM `creature_template_addon` WHERE `entry` = 75433;
INSERT INTO `creature_template_addon` VALUES (75433,0, 0, 16777472, 0, 4097, 0, 0,'18950 0 18950 1');

-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================

-- General
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0 WHERE `guid` IN (89230, 89123, 89293);

-- Halazzi Trash
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `guid` IN (255,99693,251,253,89144,89143,89295,89297,86204,86205,89134,89133);

UPDATE `creature` SET `orientation` = '5.8806' WHERE `guid` = 89254;
UPDATE `creature` SET `orientation` = '3.5439' WHERE `guid` = 86909;
UPDATE `creature` SET `orientation` = '5.3856' WHERE `guid` = 89222;

UPDATE `creature` SET `position_x` = '-33.7911', `position_y` = '1122.1312', `position_z` = '18.7124' WHERE `guid` = 86474;
UPDATE `creature` SET `position_x` = '-33.3260', `position_y` = '1177.7864', `position_z` = '18.7114' WHERE `guid` = 86477;
UPDATE `creature` SET `position_x` = '-9.8241', `position_y` = '1149.7989', `position_z` = '18.7114' WHERE `guid` = 86478;
UPDATE `creature` SET `position_x` = '-55.3117', `position_y` = '1150.0552', `position_z` = '18.7052' WHERE `guid` = 86475;
UPDATE `creature` SET `position_x` = '343.9531', `position_y` = '1047.1018', `position_z` = '9.5199' WHERE `guid` = 86204;

DELETE FROM `creature_addon` WHERE `guid` IN (251,86306,89131,89144,89168,89169,89196,89221,89233,89245,89246,89251);
UPDATE `creature_addon` SET `auras`='18950 0 18950 1' WHERE `guid` = 89169;

SET @GUID := 86308;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 238.0737, 1029.3819, 16.4899,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 232.7241, 1017.9666, 16.3869,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 240.2530, 1006.2888, 16.4477,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 254.5853, 1008.2086, 16.4742,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 259.1850, 1020.8645, 16.4193,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 247.3921, 1032.4918, 16.5432,0,0,0,100,0);

SET @GUID := 86307;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 244.4358, 1026.0593, 3.4683,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 244.6288, 1025.2019, 3.4683,15000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 254.5704, 1021.4236, 3.4684,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 254.3959, 1016.9506, 6.5766,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 250.6309, 1010.5523, 10.7040,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 248.1847, 1006.7416, 11.0891,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 249.5265, 999.6571, 10.9164,150000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 248.1847, 1006.7416, 11.0891,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 250.6309, 1010.5523, 10.7040,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 254.3959, 1016.9506, 6.5766,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 254.5704, 1021.4236, 3.4684,0,0,0,100,0);

SET @GUID := 89248;
SET @POINT := 0;
UPDATE `creature` SET `MovementType` = 2, `spawndist` = 0 WHERE `guid` = @GUID;
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0 WHERE `guid` = 86867;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -198.0335, 1162.7864, -0.3906,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -197.3535, 1128.7833, -0.2768,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -187.2174, 1121.8016, 0.0000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -187.6073, 1110.7960, 0.0000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -212.3179, 1106.6700, -0.1009,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -228.3822, 1122.2513, 0.1154,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -232.2036, 1141.2053, -0.9500,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -230.1483, 1160.9539, -1.8820,0,0,0,100,0);

SET @GUID := 89160;
SET @POINT := 0;
UPDATE `creature` SET `MovementType` = 2, `spawndist` = 0 WHERE `guid` = @GUID;
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0 WHERE `guid` = 89163;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -212.3179, 1106.6700, -0.1009,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -228.3822, 1122.2513, 0.1154,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -232.2036, 1141.2053, -0.9500,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -230.1483, 1160.9539, -1.8820,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -198.0335, 1162.7864, -0.3906,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -197.3535, 1128.7833, -0.2768,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -187.2174, 1121.8016, 0.0000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -187.6073, 1110.7960, 0.0000,0,0,0,100,0);

SET @GUID := 89193;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
UPDATE `creature` SET `MovementType`= 0, `spawndist` = 0 WHERE `guid` = 86903;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -203.5472, 1156.4801, -1.0473,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -201.6007, 1150.4677, -1.4257,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -204.9382, 1145.9350, -1.6790,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -211.7031, 1145.1348, -1.9070,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -214.4541, 1150.0476, -2.0609,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -214.3552, 1155.2484, -1.9893,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -208.9885, 1158.2601, -1.5696,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -205.7931, 1157.1260, -1.3524,0,0,0,100,0);

SET @GUID := 89237;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
UPDATE `creature` SET `MovementType`= 0, `spawndist` = 0 WHERE `guid` = 86904; 
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -226.1191, 1147.7078, -1.8788,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -231.3070, 1152.1437, -1.8956,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -228.1814, 1160.1099, -1.9557,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -221.2898, 1160.3408, -1.9310,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -218.8405, 1156.7766, -1.9696,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -219.6508, 1150.3697, -1.9589,0,0,0,100,0);

SET @GUID := 89223;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
UPDATE `creature` SET `MovementType`= 0, `spawndist` = 0 WHERE `guid` = 86902;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -227.5500, 1170.2030, -0.5678,10000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -197.8925, 1170.5773, -0.5678,10000,0,0,100,0);

SET @GUID := 89189;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
UPDATE `creature` SET `MovementType`= 0, `spawndist` = 0 WHERE `guid` = 89162;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -214.0313, 1131.1123, -1.8925,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -216.7572, 1135.0898, -1.8358,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -224.4418, 1134.3134, -1.1852,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -225.0600, 1141.0803,-0.9861,0,0,0,100,0);

SET @GUID := 89121;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
UPDATE `creature` SET `MovementType`= 0, `spawndist` = 0 WHERE `guid` = 89161;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -203.6892, 1119.2899, -0.0642,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -203.9384, 1113.1306, -0.1852,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -207.8608, 1109.7000, -0.4540,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -212.7773, 1110.6180, -0.9615,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -216.6400, 1114.1215, -1.4225,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -216.2238, 1118.9251, -1.7741,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -211.8607, 1123.3919, -1.8337,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -206.9451, 1122.5347, -1.1313,0,0,0,100,0);

-- 89131 steht falsch 
UPDATE `creature` SET `position_x` = -84.1312, `position_y` = 1194.2934, `position_z` = 5.6570, `orientation` = 0.6667 WHERE `guid` = 89131;

-- RESPAWNTIMERS CHECKEN BOSSDEPENDEND
-- Akil'zon Trash Respawntimer 30min
UPDATE `creature` SET `spawntimesecs`='1' WHERE `guid` IN (89266,89280,89281,89282,89283,89287,89288,89289,89290); -- ->5min
UPDATE `creature` SET `spawntimesecs`='1500' WHERE `guid` = 89267; -- -> 30min
DELETE FROM `creature_addon` WHERE `guid` IN (89287,89288,89289,89290,89280,89281,89282,89283,89286,89283,89267,89191,89284,89285,89287,89288,89286,89244,89331,89278,16777016,16777024,16777017,16777023,16777018,16777022,16777021,16777019,16777020);
INSERT INTO `creature_addon` VALUES
(89244,0,0,16777472,1,4097,0,0,''),
(89286,0,0,16777472,1,4097,0,0,''),

(89280,0,0,0,0,4097,333,0,''),
(89290,0,0,0,0,4097,333,0,''),
(89281,0,0,0,0,4097,333,0,''),
(89289,0,0,0,0,4097,333,0,''),
(89282,0,0,0,0,4097,333,0,''),
(89288,0,0,0,0,4097,333,0,''),
(89287,0,0,0,0,4097,333,0,''),
(89283,0,0,0,0,4097,333,0,''),
(89267,0,0,0,0,4097,333,0,'');

UPDATE `creature` SET `position_x` = '-139.5014', `position_y` = '1164.5451', `position_z` = '3.2550', `orientation` = '1.7976', `MovementType` = '0' WHERE `guid` = 89284;
-- UPDATE `creature` SET `position_x` = '-127.5309', `position_y` = '1168.0200', `position_z` = '0.6812', `orientation` = '5.8503' WHERE `guid` = 89224;

UPDATE `creature` SET `id`='23596',`modelid`='0' WHERE `guid` = 89168;
UPDATE `creature` SET `movementtype` ='0',`spawndist`='0',`spawntimesecs`='7200' WHERE `guid` = 86211;
UPDATE `creature` SET `spawndist`='0',`modelid`='0',`spawntimesecs`='7200' WHERE `guid` = 86212;

-- 2 grp at stairs
UPDATE `creature` SET `position_x`='-76.1703', `position_y`='1378.2469', `position_z`='40.7942', `orientation`='1.5734' WHERE `guid` = 89264;
UPDATE `creature` SET `position_x`='-84.8824', `position_y`='1378.2242', `position_z`='40.7934', `orientation`='1.5734' WHERE `guid` = 89263;

SET @NPC := 86212;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'116.3167','1156.2285','-1.3304',0,0,0,0,0),
(@PATH,2,'134.6540','1174.6312','-7.6658',0,0,0,0,0),
(@PATH,3,'126.5884','1196.3280','-15.4215',0,0,0,0,0),
(@PATH,4,'100.8596','1198.0642','-14.8360',0,0,0,0,0),
(@PATH,5,'115.5575','1230.1401','-24.5541',0,0,0,0,0),
(@PATH,6,'100.8596','1198.0642','-14.8360',0,0,0,0,0),
(@PATH,7,'126.5884','1196.3280','-15.4215',0,0,0,0,0),
(@PATH,8,'134.6540','1174.6312','-7.6658',0,0,0,0,0),
(@PATH,9,'116.3167','1156.2285','-1.3304',0,0,0,0,0),
(@PATH,10,'100.7675','1146.9780','1.4131',0,0,0,0,0);

SET @GUID := 243;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'18950 0 18950 1'); -- old path 16004
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (243, 1, 446.0509, 933.9879, 0.0006, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 2, 442.129, 904.214, 0.000692, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 3, 416.327, 888.693, 0.000035, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 4, 404.5015, 885.7965, 0.0000,0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (243, 5, 416.327, 888.693, 0.000035, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 6, 442.129, 904.214, 0.000692, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 7, 445.459, 962.963, 0.000075, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 8, 425.408, 985.171, 0.000075, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 9, 410.89, 986.49, 0.000075, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 10, 425.408, 985.171, 0.000075, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (243, 11, 445.459, 962.963, 0.000075, 0, 0, 0, 0, 0);

-- Amani'shi Guardian missing Stealth Detection and Stats
UPDATE `creature_addon` SET `bytes0` = 16777472, `bytes2` = 4097, `auras` = '18950 0 18950 1' WHERE `guid` = 245;
UPDATE `creature_addon` SET `bytes0` = 16777472, `bytes2` = 4097, `auras` = '18950 0 18950 1' WHERE `guid` = 255;

SET @GUID := 13755;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16843008,0,4097,0,0,''); -- old path 243...
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13755, 1, -1543.41, -3904.05, 14.0485, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 2, -1558.45, -3906.93, 12.6675, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 3, -1570.63, -3908.8, 12.195, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 4, -1577.34, -3909.02, 12.2799, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 5, -1587.39, -3900.14, 12.5705, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 6, -1594.86, -3889.95, 14.4789, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 7, -1597.94, -3879.58, 15.6313, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 8, -1593.48, -3868.54, 15.7342, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 9, -1584.79, -3857.84, 16.3712, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 10, -1574.84, -3852.01, 17.71, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 11, -1563.51, -3854.24, 18.9286, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 12, -1555.01, -3861.42, 19.0928, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 13, -1548.29, -3872.14, 18.7169, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 14, -1544.44, -3882.65, 17.6808, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13755, 15, -1544.53, -3895.72, 15.5314, 0, 0, 0, 100, 0);

-- 213,217,215 nonexistant
SET @GUID := 213;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'18950 0 18950 1'); -- path 16003
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,372.7164, 934.8178, 0.0000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,367.1250, 946.3226, 0.0000,2000,0,0,100,0),
(@GUID,@POINT := @POINT + 1,372.7164, 934.8178, 0.0000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,380.684, 882.053, 0.011345,2000,0,0,100,0),
(@GUID,@POINT := @POINT + 1,380.2495, 884.9297, 0.0108,0,0,0,100,0);

SET @GUID := 89157;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 290.4004, 1049.9591, 0.0008,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 308.1571, 1033.3675, 0.0008,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 317.4832, 1013.5916, 0.0071,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 342.7563, 996.0705, -0.0000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 360.1288, 960.7166, 0.0001,5000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 342.7563, 996.0705, -0.0000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 317.4832, 1013.5916, 0.0071,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 308.1571, 1033.3675, 0.0008,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 290.4004, 1049.9591, 0.0008,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 277.8444, 1054.3112, 0.0000,5000,0,0,100,0);

SET @GUID := 86209;		
DELETE FROM `creature_addon` WHERE `guid` = @GUID;	
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,512,0,4097,0,0,'');		
DELETE FROM `waypoint_data` WHERE `id` = @GUID;		
INSERT INTO `waypoint_data` VALUES (86209, 1, 94.0516, 1420.18, 0.768301, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 2, 105.468, 1420.02, -1.50645, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 3, 137.522, 1419.38, -0.302712, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 4, 149.003, 1418.53, 3.30319, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 5, 154.109, 1418.43, 3.30319, 2000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 6, 148.596, 1418.59, 3.30319, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 7, 138.759, 1418.32, -0.325193, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 8, 103.892, 1419.73, -1.55035, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 9, 92.3991, 1420.26, 0.768636, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (86209, 10, 82.9161, 1420.1, 0.768636, 2000, 0, 0, 100, 0);

SET @GUID := 89308;		
SET @POINT := 0;		
UPDATE `creature` SET `position_x` = '-181.2782', `position_y` = '1273.0632', `position_z` = '1.6089', `orientation` = '3.0394', `MovementType` = '2' WHERE `guid` = @GUID;		
DELETE FROM `creature_addon` WHERE `guid` = @GUID;		
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');		
DELETE FROM `waypoint_data` WHERE `id` = @GUID;		
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,221,100,0),
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,502,100,0),		
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,510,100,0),		 
(@GUID,@POINT := @POINT + 1, -197.3252, 1276.5983, 1.1920,0,0,0,100,0),		
(@GUID,@POINT := @POINT + 1, -199.2218, 1338.8071, 0.2291,0,0,0,100,0),		
(@GUID,@POINT := @POINT + 1, -190.7081, 1345.4399, -0.1164,0,0,0,100,0),		
(@GUID,@POINT := @POINT + 1, -184.6473, 1347.3172, -0.1083,0,0,0,100,0),		
(@GUID,@POINT := @POINT + 1, -178.3489, 1350.2700, -0.0230,0,0,220,100,0),
(@GUID,@POINT := @POINT + 1, -178.3489, 1350.2700, -0.0230,0,0,402,100,0),	
(@GUID,@POINT := @POINT + 1, -178.3489, 1350.2700, -0.0230,0,0,410,100,0),
(@GUID,@POINT := @POINT + 1, -161.8452, 1354.2738, 17.4233,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -162.1108, 1272.5865, 16.4045,17000,0,0,100,0);

SET @GUID := 89303;		
SET @POINT := 0;		
UPDATE `creature` SET `MovementType` = '2' WHERE `guid` = @GUID;		
DELETE FROM `creature_addon` WHERE `guid` = @GUID;		
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');		
DELETE FROM `waypoint_data` WHERE `id` = @GUID;		
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-171.8750, 1213.3399, 0.1278,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-171.8750, 1213.3399, 0.1278,0,0,221,100,0),
(@GUID,@POINT := @POINT + 1,-171.8750, 1213.3399, 0.1278,0,0,502,100,0),
(@GUID,@POINT := @POINT + 1,-171.8750, 1213.3399, 0.1278,0,0,510,100,0),
(@GUID,@POINT := @POINT + 1,-166.2432, 1218.8035, 0.0792,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-161.6200, 1221.2172, 0.5074,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-142.5437, 1201.9991, 1.3941,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-129.0265, 1152.3684, 0.1531,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-124.1406, 1152.1911, 0.2570,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-114.6728, 1156.1302, 0.0009,0,0,220,100,0),
(@GUID,@POINT := @POINT + 1,-114.6728, 1156.1302, 0.0009,0,0,402,100,0),
(@GUID,@POINT := @POINT + 1,-114.6728, 1156.1302, 0.0009,0,0,410,100,0),
(@GUID,@POINT := @POINT + 1, -94.6466, 1191.4406, 15.6773,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -153.9721, 1246.7384, 15.6775,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -165.9297, 1225.6486, 19.3436,2000,0,0,100,0);

SET @GUID := 89313;		
SET @POINT := 0;		
UPDATE `creature` SET `MovementType` = '2' WHERE `guid` = @GUID;		
DELETE FROM `creature_addon` WHERE `guid` = @GUID;		
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');		
DELETE FROM `waypoint_data` WHERE `id` = @GUID;		
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-163.5030, 1193.4367, 0.7938,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-163.5030, 1193.4367, 0.7938,0,0,221,100,0),
(@GUID,@POINT := @POINT + 1,-163.5030, 1193.4367, 0.7938,0,0,502,100,0),
(@GUID,@POINT := @POINT + 1,-163.5030, 1193.4367, 0.7938,0,0,510,100,0),
(@GUID,@POINT := @POINT + 1,-160.6187, 1194.7271, 0.5157,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-151.4554, 1198.2204, 0.1018,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-150.5681, 1202.1022, 0.2013,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-165.7255, 1226.2877, 0.2412,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-197.4094, 1251.1176, 0.2398,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-197.3118, 1271.4202, 1.1483,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-190.0849, 1274.0864, 1.0419,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-181.2782, 1273.0632, 1.6089,0,0,220,100,0),
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,402,100,0),
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,410,100,0),
(@GUID,@POINT := @POINT + 1, -162.1108, 1272.5865, 16.4045,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -153.9721, 1246.7384, 15.6775,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -166.0811, 1230.6322, 19.5207,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -188.8950, 1172.8701, 13.8768,3000,0,0,100,0);

SET @GUID := 89312;		
SET @POINT := 0;		
UPDATE `creature` SET `MovementType` = '2' WHERE `guid` = @GUID;		
DELETE FROM `creature_addon` WHERE `guid` = @GUID;		
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');		
DELETE FROM `waypoint_data` WHERE `id` = @GUID;		
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-114.6728, 1156.1302, 0.0009,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-114.6728, 1156.1302, 0.0009,0,0,221,100,0),
(@GUID,@POINT := @POINT + 1,-114.6728, 1156.1302, 0.0009,0,0,502,100,0),
(@GUID,@POINT := @POINT + 1,-114.6728, 1156.1302, 0.0009,0,0,510,100,0),
(@GUID,@POINT := @POINT + 1,-123.1707, 1152.6462, 0.1670,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-129.4595, 1152.8106, 0.0985,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-138.0689, 1192.0770, 0.0185,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-165.7255, 1226.2877, 0.2412,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-197.4094, 1251.1176, 0.2398,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-197.3118, 1271.4202, 1.1483,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-190.0849, 1274.0864, 1.0419,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-181.2782, 1273.0632, 1.6089,0,0,220,100,0),
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,402,100,0),
(@GUID,@POINT := @POINT + 1, -181.2782, 1273.0632, 1.6089,0,0,410,100,0),
(@GUID,@POINT := @POINT + 1, -162.1108, 1272.5865, 16.4045,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -153.9721, 1246.7384, 15.6775,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -94.6466, 1191.4406, 15.6773,0,0,0,100,0);

SET @GUID := 89278;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -212.178, 1161.06, -1.58448,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -212.178, 1161.06, -1.58448,0,0,221,100,0),
(@GUID,@POINT := @POINT + 1, -212.178, 1161.06, -1.58448,0,0,502,100,0),
(@GUID,@POINT := @POINT + 1, -212.178, 1161.06, -1.58448,0,0,510,100,0),
(@GUID,@POINT := @POINT + 1, -208.4145, 1171.1068, -0.5677,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -206.5637, 1176.3857, -0.5677,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -206.5916, 1181.1059, -0.5677,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -204.9635, 1185.4606, -2.8645,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -192.0960, 1207.7651, 0.5354,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -197.4094, 1251.1176, 0.2398,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -197.3118, 1271.4202, 1.1483,0,0,0,100,0),	
(@GUID,@POINT := @POINT + 1, -199.2218, 1338.8071, 0.2291,0,0,0,100,0),	
(@GUID,@POINT := @POINT + 1, -206.4741, 1358.9240, -0.1075,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -206.4054, 1366.7082, 0.1034,20000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -195.5092, 1344.8483, -0.1167,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -190.7081, 1345.4399, -0.1164,0,0,0,100,0),		
(@GUID,@POINT := @POINT + 1, -184.6473, 1347.3172, -0.1083,0,0,0,100,0),		
(@GUID,@POINT := @POINT + 1, -178.3489, 1350.2700, -0.0230,0,0,220,100,0),
(@GUID,@POINT := @POINT + 1, -178.3489, 1350.2700, -0.0230,0,0,402,100,0),
(@GUID,@POINT := @POINT + 1, -178.3489, 1350.2700, -0.0230,0,0,410,100,0),
(@GUID,@POINT := @POINT + 1, -161.8452, 1354.2738, 17.4233,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -162.1108, 1272.5865, 16.4045,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -153.9721, 1246.7384, 15.6775,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -166.0811, 1230.6322, 19.5207,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -188.8950, 1172.8701, 13.8768,8000,0,0,100,0);

SET @GUID := 89167;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID, 0, 16777472, 0, 4097, 0, 0, '18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -140.3471, 1143.2023, 0.5762,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -139.6195, 1137.6429, 0.4367,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -135.2308, 1144.7722, 0.4381,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -132.1690, 1140.1400, 0.4630,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -139.6195, 1137.6429, 0.4367,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -132.1690, 1140.1400, 0.4630,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -140.3471, 1143.2023, 0.5762,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -139.6195, 1137.6429, 0.4367,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -135.2308, 1144.7722, 0.4381,0,1,0,100,0);

-- ======================================================
-- Linking
-- ======================================================

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (89322,89140,86200,86201,86202,86203,87042,86199,89201,89202,89203,99685,99686,99693,255,89189,89162,89237,86904,89295,89296,89297,89278,86204,86205,86206,89248,86867,89193,86903,89223,86902,89237,86904,89189,89162,89121,89161,89160,89163,89284,89142,89174,86922,89172,89177,89175,89173,86921,89145,89168,89246,89165,89192,89233,89131,86910,86906,89273,89274,89275,89287,89288,89289,89290,89280,89281,89282,89283,89267,89266,31834,31756,33301,31753,89207,89199,89135,89200,88652,89176,89141,86198,87043,89286,89190,89244,86859,86750,86702,86701,89259,89260,89261,89262,86698,86699,86700,86479,89157,86209,86306,86280,86239,89264,89263,16777015,16777016,16777024,16777017,16777023,16777018,16777022,16777021,16777019,16777020,86914,86194,89170,89245,89191,89331,89285,89255,89241,89251,89167,89286);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (89322,89140,86200,86201,86202,86203,87042,86199,86201,86202,86203,99685,99686,99693,255,89189,89162,89237,86904,89293,89295,89296,89297,89278,86204,86205,86206,89248,86867,89193,86903,89223,86902,89237,86904,89189,89162,89121,89161,89160,89163,89284,89142,89174,86922,89172,89177,89175,89173,86921,89145,89168,89246,89165,89192,89233,89131,86910,86906,89273,89274,89275,89287,89288,89289,89290,89280,89281,89282,89283,89267,89266,31834,31756,33301,31753,89207,89199,89135,89200,88652,89176,89141,86198,87043,89286,89190,89244,86859,86750,86702,86701,89259,89260,89261,89262,86698,86699,86700,86479,89157,86209,86306,86280,86239,89264,89263,16777015,16777016,16777024,16777017,16777023,16777018,16777022,16777021,16777019,16777020,86914,86194,89170,89245,89191,89331,89285,89255,89241,89251,89167,89286);
INSERT INTO `creature_formations` VALUES

(89140,89140,100,360,2),
(89140,86200,100,360,2),
(89140,86201,100,360,2),
(89140,86202,100,360,2),
(89140,86203,100,360,2),
(89140,87042,100,360,2),

(86199,86199,100,360,2),
(86199,89201,100,360,2),
(86199,89202,100,360,2),
(86199,89203,100,360,2),
(86199,99685,100,360,2),
(86199,99686,100,360,2),

(255,255,100,360,2),
(255,99693,3,0.50,2),

(89189,89189,100,360,2),
(89189,89162,4,3.14,2),

(89237,89237,100,360,2),
(89237,86904,4,3.14,2),

(89122, 89293, 4, 3.93, 2),

(86204,86204,100,360,2),
(86204,86205,100,360,2),
(86204,86206,100,360,2),

(89223,89223,100,360,2),
(89223,86902,4,3.14,2),

(89193,89193,100,360,2),
(89193,86903,4,3.14,2),

(89121,89121,100,360,2),
(89121,89161,4,3.14,2),

(89160,89160,100,360,2),
(89160,89163,4,3.14,2),

(89248,89248,100,360,2),
(89248,86867,4,3.14,2),

(89142,89142,100,360,2),
(89142,89174,100,360,2),
(89142,86922,100,360,2),
(89142,89172,100,360,2),
(89142,89177,100,360,2),
(89142,89175,100,360,2),
(89142,89173,100,360,2),
(89142,86921,100,360,2),
(89142,89145,100,360,2),

(89168,89168,100,360,2),
(89168,89246,100,360,2),
(89168,89165,100,360,2),
(89168,89192,100,360,2),

(89233,89233,100,360,2),
(89233,89131,100,360,2),
(89233,86910,100,360,2),
(89233,86906,100,360,2),

(89295,89295,100,360,2),
(89295,89296,100,360,2),
(89295,89297,100,360,2),

(31834,31834,100,360,2),
(31834,31753,100,360,2),
(31834,31756,100,360,2),
(31834,33301,100,360,2),

(89207,89207,100,360,2),
(89207,89199,100,360,2),
(89207,89135,100,360,2),
(89207,89200,100,360,2),
(89207,88652,100,360,2),
(89207,89176,100,360,2),
(89207,89141,100,360,2),
(89207,86198,100,360,2),
(89207,87043,100,360,2),

(89190,89190,100,360,2),
(89190,89244,100,360,2),
(89190,86859,100,360,2),
(89190,86750,100,360,2),
(89190,86702,100,360,2),
(89190,86701,100,360,2),

(89259,89259,100,360,2),
(89259,89260,100,360,2),
(89259,89261,100,360,2),
(89259,89262,100,360,2),

(86698,86698,100,360,2),
(86698,86699,100,360,2),
(86698,86700,100,360,2),

(89157,89157,100,360,2),
(89157,17636,4,0.7,2),
(89157,20196,4,5.5,2),

(86209,86209,0.467914,2.90974,2),
(86209,86210,4.14516,4.52363,2),

(86306,86306,100,360,2),
(86306,86280,100,360,2),
(86306,86239,100,360,2),

(89264,89264,100,360,2),
(89264,89263,100,360,2),

(89267,89267,100,360,1),
(89267,89266,100,360,0),
-- (89267,86479,100,360,0),

(89283,89283,100,360,1),
(89283,89287,100,360,0),
(89283,89288,100,360,0),
(89283,89282,100,360,0),

(89281,89289,100,360,0),
(89281,89281,100,360,1),
(89281,89290,100,360,0),
(89281,89280,100,360,0),

(86914,86914,100,360,2),
(86914,86194,100,360,2),
(86914,85580,100,360,2),
(86914,86918,100,360,2),
(86914,86913,100,360,2),
(86914,86132,100,360,2),
(86914,86916,100,360,2),
(86914,86162,100,360,2),
(86914,86920,100,360,2),
(86914,86915,100,360,2),

(89191,89191,100,360,2),
(89191,89170,100,360,2),
(89191,89245,100,360,2),
(89191,89331,100,360,2),

-- (89285,89284,100,360,2),
(89285,89285,100,360,2),
(89285,89255,100,360,2),
(89285,89241,100,360,2),
(89285,89251,100,360,2),
(89285,89167,100,360,2),

('89322','89322','120','360','2'),
('89322','89228','120','360','0'),
('89322','89320','120','360','0'),
('89322','89301','120','360','0'),
('89322','89317','120','360','0'),
('89322','89302','120','360','0'),
('89322','89316','120','360','0'),
('89322','89321','120','360','0'),
('89322','89328','120','360','0'),
('89322','89348','120','360','0'),
('89322','89353','120','360','0'),
('89322','89343','120','360','0'),
('89322','89351','120','360','0'),
('89322','89354','120','360','0'),
('89322','89352','120','360','0'),
('89322','89350','120','360','0'),
('89322','89346','120','360','0'),
('89322','89347','120','360','0'),
('89322','89344','120','360','0'),
('89322','89349','120','360','0'),
('89322','89345','120','360','0'),
('89322','89355','120','360','0'),
('89322','89356','120','360','0'),
('89322','89337','120','360','0'),
('89322','89342','120','360','0'),
('89322','89335','120','360','0'),
('89322','89338','120','360','0'),
('89322','89340','120','360','0'),
('89322','89333','120','360','0'),
('89322','89341','120','360','0'),
('89322','89339','120','360','0'),
('89322','89336','120','360','0'),
('89322','89334','120','360','0'),
('89322','89315','120','360','0'),
('89322','89300','120','360','0'),
('89322','89226','120','360','0'),
('89322','89319','120','360','0'),
('89322','89332','120','360','0'),
('89322','89227','120','360','0'),
('89322','89323','120','360','0'),
('89322','89314','120','360','0');

UPDATE `creature_formations` SET `dist` = 3 WHERE `memberguid` = 239; -- 1.32088
UPDATE `creature_formations` SET `dist` = 4 WHERE `memberguid` = 89123; -- 10.3757

-- ======================================================
-- Respawn
-- ======================================================

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (89226,89227,89228,89300,89301,89302,89314,89315,89316,89317,89319,89320,89321,89323,89328,89332,89333,89334,89335,89336,89337,89338,89339,89340,89341,89342,89343,89344,89345,89346,89347,89348,89349,89350,89351,89352,89353,89354,89355,89356,99685,99686,89119,89213,89111,89273,89186,86375,89291,99693,89293,86194,86914,89297,89296,89295,31834,31753,33301,31756,17636,20196,89157,89267,89207,89223,89312,89313,89244,89303,89278,86866,86905,86908,86911,89124,89125,89126,89127,89128,89129,89130,89132,89166,89197,89198,89216,89217,89218,89225,89232,89234,89235,89236,89238,89239,89240,89242,89249,89252,89253,89273,89274,89275,89287,89288,89289,89290,89283,89282,89281,89280,89267,89266,86479,85580,86210,16777193,16777015,16777016,16777017,16777018,16777019,16777020,16777021,16777022,16777023,16777024);
DELETE FROM `creature_linked_respawn` WHERE `linkedguid` IN (5735903,86609,89267);

-- maybe linked to 23774s instead
INSERT INTO `creature_linked_respawn` VALUES (86866, 89322);
INSERT INTO `creature_linked_respawn` VALUES (86905, 89322);
INSERT INTO `creature_linked_respawn` VALUES (86908, 89322);
INSERT INTO `creature_linked_respawn` VALUES (86911, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89124, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89125, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89126, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89127, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89128, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89129, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89130, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89132, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89166, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89197, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89198, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89216, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89217, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89218, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89225, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89232, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89234, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89235, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89236, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89238, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89239, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89240, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89242, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89249, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89252, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89253, 89322);

-- Jan'alai
INSERT INTO `creature_linked_respawn` VALUES (89293, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89278, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89303, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89312, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89313, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89244, 89322);
INSERT INTO `creature_linked_respawn` VALUES (89223, 89322);
INSERT INTO `creature_linked_respawn` VALUES 
(89226, 89322),(89227, 89322),(89228, 89322),(89300, 89322),
(89301, 89322),(89302, 89322),(89314, 89322),(89315, 89322),
(89316, 89322),(89317, 89322),(89319, 89322),(89320, 89322),
(89321, 89322),(89323, 89322),(89328, 89322),(89332, 89322),
(89333, 89322),(89334, 89322),(89335, 89322),(89336, 89322),
(89337, 89322),(89338, 89322),(89339, 89322),(89340, 89322),
(89341, 89322),(89342, 89322),(89343, 89322),(89344, 89322),
(89345, 89322),(89346, 89322),(89347, 89322),(89348, 89322),
(89349, 89322),(89350, 89322),(89351, 89322),(89352, 89322),
(89353, 89322),(89354, 89322),(89355, 89322),(89356, 89322);

-- Nalorakk
INSERT INTO `creature_linked_respawn` VALUES (86194, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86914, 86609);
INSERT INTO `creature_linked_respawn` VALUES (85580, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86209, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86210, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86610, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86611, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86612, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86695, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86696, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86697, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86698, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86699, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86700, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86913, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86918, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89259, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89260, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89261, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89262, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89263, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89264, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89268, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89269, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89270, 86609);
INSERT INTO `creature_linked_respawn` VALUES (89271, 86609);
INSERT INTO `creature_linked_respawn` VALUES (86609, 86609);

-- Amani'shi Tempest
INSERT INTO `creature_linked_respawn` VALUES (86479, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89266, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89280, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89281, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89282, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89283, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89287, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89288, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89289, 89267);
INSERT INTO `creature_linked_respawn` VALUES (89290, 89267);

-- Akil'zon - Amani'shi Tempest
INSERT INTO `creature_linked_respawn` VALUES (89267, 86494);

-- Halazzi
INSERT INTO `creature_linked_respawn` VALUES (99685, 86195);
INSERT INTO `creature_linked_respawn` VALUES (99686, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89119, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89213, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89111, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89186, 86195);
INSERT INTO `creature_linked_respawn` VALUES (86375, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89291, 86195);
INSERT INTO `creature_linked_respawn` VALUES (99693, 86195);
INSERT INTO `creature_linked_respawn` VALUES (31834, 86195);
INSERT INTO `creature_linked_respawn` VALUES (33301, 86195);
INSERT INTO `creature_linked_respawn` VALUES (31756, 86195);
INSERT INTO `creature_linked_respawn` VALUES (31753, 86195);
INSERT INTO `creature_linked_respawn` VALUES (17636, 86195);
INSERT INTO `creature_linked_respawn` VALUES (20196, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89157, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89207, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89273, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89274, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89275, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89295, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89296, 86195);
INSERT INTO `creature_linked_respawn` VALUES (89297, 86195);

-- =====================
-- Gameobjects
-- =====================

-- Research
-- (187377,186648,187378,187021,186748,187379,186658,186667,187380,186338,186633,186671,187021,185438,185454,186482,185434);

-- Gold Coins, maybe need c++ go script
UPDATE `gameobject_template` SET `flags` = 64 WHERE `entry` IN (186633, 186634); -- 0

DELETE FROM `gameobject` WHERE `guid` BETWEEN 55361 AND 55448;
INSERT INTO `gameobject` VALUES (55361, 186633, 568, 1, -79.2179, 1125.98, 5.53967, -1.93732, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55362, 186633, 568, 1, -80.7119, 1124.81, 5.59401, -1.95477, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55363, 186633, 568, 1, 332.322, 1084.61, 6.23159, -0.872664, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55364, 186633, 568, 1, 332.423, 1083.13, 6.30574, 2.46091, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55365, 186633, 568, 1, 331.155, 1084.52, 6.2764, 0.750491, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55366, 186633, 568, 1, 333.545, 1085.66, 6.32405, -0.733038, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55367, 186633, 568, 1, 330.726, 1086.47, 6.22998, 0.767944, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55368, 186633, 568, 1, 343.771, 1151.66, 6.34366, -2.87979, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55369, 186633, 568, 1, 341.88, 1151.76, 6.34366, -0.820303, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55370, 186633, 568, 1, 345.407, 1152.75, 6.34366, -1.309, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55371, 186633, 568, 1, 343.2, 1150.49, 6.34366, 0.087266, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55372, 186633, 568, 1, 424.528, 1081.66, 6.75976, 1.11701, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55373, 186633, 568, 1, 425.217, 1085.2, 6.49234, -1.64061, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55374, 186633, 568, 1, 423.058, 1082.9, 6.68479, -0.349065, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55375, 186633, 568, 1, 305.952, 1466.29, 81.6448, -2.19912, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55376, 186633, 568, 1, 304.405, 1465.53, 81.6934, -2.75761, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55377, 186633, 568, 1, 305.355, 1467.36, 81.6934, 0.837757, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55378, 186634, 568, 1, -79.5859, 1124.89, 5.57584, 0.90757, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55379, 186634, 568, 1, -80.4313, 1126.02, 5.59401, -0.575957, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55380, 186634, 568, 1, 304.023, 1467.73, 81.5893, 0.750491, 0, 0, 0, 0, -604800, 255, 1);
-- 
INSERT INTO `gameobject` VALUES (55382, 186658, 568, 1, -84.165802, 1177.880005, 5.635830, 1.283480, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55383, 180771, 568, 1, 141.189, 717.505, 45.1114, -1.55334, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55384, 180771, 568, 1, 99.5758, 717.845, 45.1114, 1.55334, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55385, 180771, 568, 1, 119.808, 657.875, 51.679, 1.65806, 0, 0, 0, 0, -604800, 255, 1);
--
--
-- INSERT INTO `gameobject` VALUES (55387, 186671, 568, 1, 343.357, 1152.03, 6.34366, -2.93214, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55388, 186671, 568, 1, 344.333, 1084.68, 6.96691, 2.96704, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55389, 186671, 568, 1, 316.036011, 1083.099976, 9.977740, 0.222981, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55390, 186671, 568, 1, 424.028015, 1092.510010, 6.357640, 0.027412, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55392, 186430, 568, 1, 251.429, 996.856, 10.912, 2.11185, 0, 0, 0, 0, 604800, 255, 1);
INSERT INTO `gameobject` VALUES (55393, 185434, 568, 1, -146.864, 1332.22, 48.1739, -0.95993, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55394, 185434, 568, 1, -75.1178, 1137.77, 5.21104, 1.16937, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55395, 185434, 568, 1, 293.915, 1458.4, 81.5059, -1.25664, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55396, 185434, 568, 1, 343.361, 1311.33, 81.5876, 0.017452, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55397, 185434, 568, 1, -73.5284, 1139.15, 5.19407, -2.26892, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55398, 185434, 568, 1, -23.8944, 1332.41, 48.1739, 0.645772, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55399, 185434, 568, 1, 392.563, 1155.37, 6.34364, -1.81514, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55400, 185438, 568, 1, -150.023, 1350.04, 48.1739, -0.575957, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55401, 185438, 568, 1, 398.786, 1086.32, 5.35751, 2.84488, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55402, 185454, 568, 1, -28.1068, 1338.44, 48.1739, -1.53589, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55403, 185454, 568, 1, -132.61, 1341.92, 48.1739, 0.890117, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55404, 185454, 568, 1, 305.403, 1460.19, 81.5059, -1.18682, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55405, 185454, 568, 1, 297.778, 1461.44, 81.5059, -1.8675, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55406, 185454, 568, 1, 337.444, 1323.92, 81.5876, -2.89724, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55407, 185454, 568, 1, -150.251, 1337.35, 48.1739, 0.855211, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55408, 185454, 568, 1, 346.202, 1314.28, 81.5876, 1.95477, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55409, 185454, 568, 1, 396.143, 1148.68, 6.34339, 2.56563, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55410, 185454, 568, 1, 345.458, 1324.55, 81.5876, 0.837757, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55411, 185454, 568, 1, 411.937, 1123.93, 6.10051, -0.436332, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55412, 185455, 568, 1, -133.912, 1335.87, 48.1739, 0.226892, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55413, 185455, 568, 1, 341.998, 1320.82, 81.5876, -0.90757, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55414, 185455, 568, 1, 291.797, 1464.71, 81.506, 0.680677, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55415, 185455, 568, 1, -147.718, 1342.07, 48.1739, -0.541051, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55416, 185455, 568, 1, -24.0499, 1343.66, 48.1739, -0.069812, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55417, 185455, 568, 1, 298.285, 1454.72, 81.5059, 0.244346, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55418, 185455, 568, 1, 335.697, 1314.94, 81.5876, 0.314158, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55419, 185455, 568, 1, 300.462, 1470.83, 81.506, 1.88495, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55420, 186482, 568, 1, -74.6319, 1138.7, 5.20206, 0, 0, 0, 0, 0, 180, 255, 0);
INSERT INTO `gameobject` VALUES (55421, 186482, 568, 1, 341.059, 1311.29, 81.5876, 0.017452, 0, 0, 0, 0, 180, 255, 0);
INSERT INTO `gameobject` VALUES (55422, 186482, 568, 1, 383.488, 1152.29, 6.34366, 3.12412, 0, 0, 0, 0, 180, 255, 0);
INSERT INTO `gameobject` VALUES (55423, 186482, 568, 1, 294.252, 1457.96, 81.5059, -1.3439, 0, 0, 0, 0, 180, 255, 0);
-- INSERT INTO `gameobject` VALUES (55424, 186482, 568, 1, -149.09, 1349.99, 48.1739, -2.19912, 0, 0, 0, 0, 180, 255, 0);
INSERT INTO `gameobject` VALUES (55425, 186482, 568, 1, -22.0915, 1350.19, 48.1739, 2.26892, 0, 0, 0, 0, 180, 255, 0);
-- INSERT INTO `gameobject` VALUES (55426, 186745, 568, 1, 120.146, 665.572, 51.7082, -0.453785, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55427, 186748, 568, 1, 99.8802, 694.349, 45.1114, 0.837757, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55428, 186750, 568, 1, 140.644, 694.009, 45.1114, -2.00713, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55430, 187035, 568, 1, 132.464, 1334.19, -9.37467, -2.53072, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55431, 187036, 568, 1, 98.8152, 1245.41, -9.49482, 1.43117, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55432, 187037, 568, 1, 132.373, 1244.41, -9.6476, 0.296705, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55436, 186338, 568, 1, 397.309, 1083.46, 5.41724, -0.017452, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55437, 186338, 568, 1, -23.4402, 1333.18, 48.1739, 0.017452, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55438, 186338, 568, 1, 398.437, 1152.45, 6.34364, 3.14159, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55441, 186860, 568, 1, 99.9827, 1333.95, -9.39569, 0.59341, 0, 0, 0, 0, 180, 255, 1);
-- INSERT INTO `gameobject` VALUES (55442, 187377, 568, 1, -147.731, 1333.47, 48.1739, -0.872664, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55443, 186865, 568, 1, 92.7648, 707.518, 45.1114, 0.017452, 0, 0, 0, 0, -604800, 255, 1);
INSERT INTO `gameobject` VALUES (55444, 187378, 568, 1, 296.334, 1468.37, 81.506, -2.51327, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55445, 187379, 568, 1, -73.7866, 1164.58, 5.2034, 3.14159, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55446, 187380, 568, 1, 383.674, 1083.18, 5.75323, 0.017452, 0, 0, 0, 0, 180, 255, 1);
INSERT INTO `gameobject` VALUES (55448, 186623, 568, 1, 307.208, 1464.14, 81.6032, -0.104719, 0, 0, 0, 0, 180, 255, 1);

DELETE FROM `gameobject` WHERE `guid` = 8794515;
INSERT INTO `gameobject` VALUES (8794515, 186671, 568, 1, 316.036, 1083.1, 9.77774, 0.222981, 0, 0, 0.11126, 0.993791, 237000, 0, 1);

UPDATE `gameobject` SET `spawnmask` = 0 WHERE `guid` = 8794517;
-- INSERT INTO `gameobject` VALUES (8794517, 186671, 568, 1, 332.877, 1150.18, 6.34384, 1.62413, 0, 0, 0.72571, 0.688001, 237000, 0, 1);

-- =====================
-- Miscellaneous
-- =====================

UPDATE `waypoint_data` SET `action` = 219 WHERE `id` = 1756 AND `point` = 7;		
UPDATE `waypoint_data` SET `action` = 223 WHERE `id` = 1780 AND `point` IN (1,2);		
UPDATE `waypoint_data` SET `action` = 223 WHERE `id` = 1782 AND `point` = 1;

