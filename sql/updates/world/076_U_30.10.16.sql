-- more missing patterns thanks for pointing out @Tykan
-- http://looking4group.eu/hellfire/showthread.php?tid=2979
DELETE FROM `reference_loot_template` WHERE `entry` = 24092 AND `item` IN (31875,31876,31877,31878,31879);
INSERT INTO `reference_loot_template` VALUES (24092, 31875, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31876, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31877, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31878, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (24092, 31879, 0, 1, 1, 1, 0, 0, 0);

DELETE FROM `reference_loot_template` WHERE `entry` = 10006 AND `item` IN (31875,31876,31877);
INSERT INTO `reference_loot_template` VALUES (10006, 31875, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (10006, 31876, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (10006, 31877, 0, 1, 1, 1, 0, 0, 0);
-- INSERT INTO `reference_loot_template` VALUES (10006, 33186, 0, 1, 1, 1, 0, 0, 0); Plans: Adamantite Weapon Chain Readd 2.3

-- Ethereum Nullifier 22822
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 22822;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22822;
INSERT INTO `creature_ai_scripts` VALUES
(2282201,22822,2,0,100,1,50,0,10000,15000,11,36513,0,1,0,0,0,0,0,0,0,0,'Ethereum Nullifier - Casts Intangible Presence');
 
-- Ethereum Jailor 23008
UPDATE `creature` SET `spawntimesecs` = 1200 WHERE `id` = 23008;
UPDATE `creature_template` SET `baseattacktime`='1400',`AIName`='EventAI' WHERE `entry` = 23008; -- 2000
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23008;
INSERT INTO `creature_ai_scripts` VALUES
(2300801,23008,2,0,100,1,50,0,10000,15000,11,36513,0,1,0,0,0,0,0,0,0,0,'Ethereum Jailor - Casts Intangible Presence'),
(2300802,23008,9,0,50,1,0,3,10000,15000,11,35924,0,1,0,0,0,0,0,0,0,0,'Ethereum Jailor - Casts Energy Flux');

-- add Formula: Enchant Bracer - Greater Dodge to Ethereum Jailor Loottable
DELETE FROM `creature_loot_template` WHERE `entry` = 23008 AND `item` = 22530;
INSERT INTO `creature_loot_template` VALUES 
(23008, 22530, 1.0, 0, 1, 1, 7, 333, 1);

-- Serpentshrine Sporebat 21246
-- 107150, 214300 Leben haben Spore Burst Charge 10-15 secs melee for 3000 on cloth. hacky charge fix
-- By 1313moridin (1,661 – 13·34) on 2007/04/30 (Patch 2.0.12) they only have alittle over 200k hp
-- http://wowwiki.wikia.com/wiki/Serpentshrine_Sporebat?direction=next&oldid=768437 , http://www.wowhead.com/npc=21246/serpentshrine-sporebat#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3000',`maxdmg`='5000',`baseattacktime`='1000',`mechanic_immune_mask`='0' WHERE `entry` = 21246; -- 1874 3809 2000 -- 2500 3500 7,649 - 9,084
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21246;
INSERT INTO `creature_ai_scripts` VALUES
('2124601','21246','9','0','50','2','6','30','0','0','11','38461','1','0','11','40602','1','0','0','0','0','0','Serpentshrine Sporebat - Cast Charge on Aggro'), -- 5 22120 -- 38461
('2124602','21246','9','0','100','3','0','5','15800','24000','11','38924','0','1','0','0','0','0','0','0','0','0','Serpentshrine Sporebat - Cast Spore Burst'),
('2124603','21246','0','0','100','3','10000','15000','10000','15000','11','38461','4','1','11','40602','4','1','0','0','0','0','Serpentshrine Sporebat - Cast Random Charge');

-- Whirling Blade 23369 mob_whirling_blade
UPDATE `creature_template` SET `modelid_A`='16946' WHERE `entry` = 23369;

-- Watcher Moonshade ori GUID + Path
DELETE FROM `creature` WHERE `guid` IN (78695,511368);
INSERT INTO `creature` VALUES (78695, 22386, 530, 1, 0, 0, 3108.07, 6131.54, 136.358, 1.36031, 300, 0, 0, 4800, 0, 0, 2);
SET @GUID := 78695;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(78695,1,3109.83,6138.61,136.152,15000,0,0,100,0),
(78695,2,3106.78,6123.73,136.396,0,0,0,100,0),
(78695,3,3103.92,6119.18,134.98,0,0,0,100,0),
(78695,4,3107.08,6115.74,134.479,0,0,0,100,0),
(78695,5,3106.34,6115.29,134.444,20000,0,0,100,0),
(78695,6,3100.41,6119.81,134.724,5000,0,0,100,0),
(78695,7,3108.07,6131.54,136.358,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 77174;
INSERT INTO `creature` VALUES (77174, 22025, 530, 1, 0, 0, -3023.25, 2044.44, 96.9412, 3.63741, 300, 0, 0, 5300, 2991, 0, 2);
SET @GUID := 77174;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(77174,1,-3049.04,2036.84,96.7392,0,0,0,100,0),
(77174,2,-3058.74,2037.59,97.0927,0,0,0,100,0),
(77174,3,-3071.71,2031.49,97.8157,0,0,0,100,0),
(77174,4,-3081.47,2022.89,98.1052,0,0,0,100,0),
(77174,5,-3080.4,2018.21,98.423,0,0,0,100,0),
(77174,6,-3068.68,2011.33,99.1066,0,0,0,100,0),
(77174,7,-3063.36,2002.53,99.861,0,0,0,100,0),
(77174,8,-3052.37,1999.89,99.0744,0,0,0,100,0),
(77174,9,-3035,2000.17,98.8673,0,0,0,100,0),
(77174,10,-3018.3,2007.63,96.9703,0,0,0,100,0),
(77174,11,-3016.29,2040.86,97.3995,0,0,0,100,0);

UPDATE `creature` SET `position_x`='-3132.6718', `position_y`='2245.0419', `position_z`='61.3553' WHERE `guid` = 70950;
UPDATE `creature` SET `position_x`='-3069.6955', `position_y`='2177.9125', `position_z`='73.1659' WHERE `guid` = 70951;

DELETE FROM `creature` WHERE `guid` = 86493;
INSERT INTO `creature` VALUES (86493, 22024, 530, 1, 0, 0, -3493.57, 2277.09, 65.3081, 0.030873, 1524, 0, 0, 4531, 2991, 0, 2);
SET @GUID := 86493;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(86493,1,-3478.58,2278.88,64.3024,0,0,0,100,0),
(86493,2,-3465.33,2287.22,63.4117,0,0,0,100,0),
(86493,3,-3396.56,2289.24,62.6846,0,0,0,100,0),
(86493,4,-3375.29,2283.54,62.2904,0,0,0,100,0),
(86493,5,-3361.75,2279.95,61.9273,0,0,0,100,0),
(86493,6,-3346.63,2278.56,61.3279,0,0,0,100,0),
(86493,7,-3292.68,2278.75,60.6095,0,0,0,100,0),
(86493,8,-3365.18,2279.23,62.0737,0,0,0,100,0),
(86493,9,-3387.64,2287.59,62.3845,0,0,0,100,0),
(86493,10,-3399.74,2289.47,62.7643,0,0,0,100,0),
(86493,11,-3457.02,2289.38,63.4614,0,0,0,100,0),
(86493,12,-3465.55,2286.99,63.416,0,0,0,100,0),
(86493,13,-3476.52,2280.52,64.1385,0,0,0,100,0),
(86493,14,-3494.46,2277.87,65.362,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 76716;
INSERT INTO `creature` VALUES (76716, 21928, 530, 1, 0, 0, -3780.32, 2669.17, 101.36, 3.25117, 300, 0, 0, 5589, 3155, 0, 2);
SET @GUID := 76716;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(76716,1,-3786.7,2670.05,101.234,0,0,0,100,0),
(76716,2,-3780.58,2686.94,101.002,0,0,0,100,0),
(76716,3,-3787.51,2672.69,101.089,0,0,0,100,0),
(76716,4,-3799,2670.99,101.33,0,0,0,100,0),
(76716,5,-3805.09,2676,100.937,0,0,0,100,0),
(76716,6,-3821.13,2697.37,101.103,0,0,0,100,0),
(76716,7,-3802.29,2672.35,101.077,0,0,0,100,0),
(76716,8,-3793.76,2669.05,101.634,0,0,0,100,0),
(76716,9,-3788.45,2672.2,101.092,0,0,0,100,0),
(76716,10,-3778.92,2687.8,101.164,0,0,0,100,0),
(76716,11,-3785.84,2674.82,100.917,0,0,0,100,0),
(76716,12,-3783.46,2669.85,101.156,0,0,0,100,0),
(76716,13,-3770.29,2669.09,100.84,0,0,0,100,0),
(76716,14,-3718.1,2675.63,105.861,0,0,0,100,0),
(76716,15,-3779.27,2669.86,101.105,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 84491;
INSERT INTO `creature` VALUES (84491, 21501, 530, 1, 0, 0, -3242.16, 2977.81, 132.319, 1.83354, 120, 0, 0, 26168, 0, 0, 2);
SET @GUID := 84491;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(84491,1,-3247.6,2994.17,135.993,0,0,0,100,0),
(84491,2,-3279.03,3007.97,141.889,0,0,0,100,0),
(84491,3,-3298.27,3015.95,150.866,0,0,0,100,0),
(84491,4,-3305.81,3025.77,154.973,0,0,0,100,0),
(84491,5,-3306.91,3039,150.53,0,0,0,100,0),
(84491,6,-3290.88,3050.58,142.305,0,0,0,100,0),
(84491,7,-3247.36,3076.23,135.868,0,0,0,100,0),
(84491,8,-3226.75,3084.37,131.21,0,0,0,100,0),
(84491,9,-3212.6,3083.74,127.018,0,0,0,100,0),
(84491,10,-3189.07,3053.51,116.723,0,0,0,100,0),
(84491,11,-3163.71,3039.35,109.256,0,0,0,100,0),
(84491,12,-3123.28,2992.12,97.3441,0,0,0,100,0),
(84491,13,-3119.82,2954.27,93.2622,0,0,0,100,0),
(84491,14,-3126.95,2940.52,93.3914,0,0,0,100,0),
(84491,15,-3147.16,2936.34,94.7507,0,0,0,100,0),
(84491,16,-3157.92,2926.54,96.0054,0,0,0,100,0),
(84491,17,-3172.45,2894.14,96.479,0,0,0,100,0),
(84491,18,-3177.28,2877.4,96.6412,0,0,0,100,0),
(84491,19,-3169.7,2843.48,89.1798,0,0,0,100,0),
(84491,20,-3170.42,2824.29,87.7978,0,0,0,100,0),
(84491,21,-3187.37,2806.07,91.5113,0,0,0,100,0),
(84491,22,-3206.98,2791.17,99.2637,0,0,0,100,0),
(84491,23,-3219.35,2790.44,102.432,0,0,0,100,0),
(84491,24,-3238.97,2798.19,116.781,0,0,0,100,0),
(84491,25,-3272.61,2796.84,122.803,0,0,0,100,0),
(84491,26,-3306.26,2800.2,123.104,0,0,0,100,0),
(84491,27,-3323.38,2811.41,123.411,0,0,0,100,0),
(84491,28,-3326.33,2831.94,130.764,0,0,0,100,0),
(84491,29,-3305.22,2857.19,130.839,0,0,0,100,0),
(84491,30,-3293.86,2880.3,131.407,0,0,0,100,0),
(84491,31,-3287.93,2911.6,132.588,0,0,0,100,0),
(84491,32,-3278.15,2933.55,131.801,0,0,0,100,0),
(84491,33,-3256.96,2941.67,128.587,0,0,0,100,0),
(84491,34,-3243.07,2976.45,132.121,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 75406;
INSERT INTO `creature` VALUES (75406, 21499, 530, 1, 0, 0, -3236.58, 2950.32, 126.891, 2.3555, 300, 0, 0, 6761, 0, 0, 2);
SET @GUID := 75406;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(75406,1,-3272.84,2971.38,133.97,0,0,0,100,0),
(75406,2,-3278.5,2984.29,136.129,0,0,0,100,0),
(75406,3,-3276.45,2992.78,138.053,0,0,0,100,0),
(75406,4,-3262.68,3003.52,138.648,3000,0,0,100,0),
(75406,5,-3280.27,2984.84,136.464,0,0,0,100,0),
(75406,6,-3277.7,2973.1,134.572,0,0,0,100,0),
(75406,7,-3255.09,2960.49,131.977,0,0,0,100,0),
(75406,8,-3237.69,2951.95,127.202,0,0,0,100,0),
(75406,9,-3228.07,2925.12,127.1,0,0,0,100,0),
(75406,10,-3238.74,2908.37,126.218,0,0,0,100,0),
(75406,11,-3252.44,2900.96,125.35,0,0,0,100,0),
(75406,12,-3260.73,2903.15,126.776,3000,0,0,100,0),
(75406,13,-3251.93,2902.01,125.441,0,0,0,100,0),
(75406,14,-3238.65,2908.15,126.18,0,0,0,100,0),
(75406,15,-3229.86,2917.15,127.228,0,0,0,100,0),
(75406,16,-3229.09,2929.26,126.888,0,0,0,100,0),
(75406,17,-3236.67,2950.03,126.819,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 75405;
INSERT INTO `creature` VALUES (75405, 21497, 530, 1, 0, 0, 3178.03, 7162.76, 198.649, 2.094, 300, 0, 0, 34930, 0, 0, 2);
SET @GUID := 75405;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(75405,1,3406.09,7124.06,189.294,0,0,0,100,0),
(75405,2,3406.94,7123.54,189.294,0,0,0,100,0),
(75405,3,3227.07,7124.38,198.293,0,0,0,100,0),
(75405,4,3197.35,7140.33,198.293,0,0,0,100,0),
(75405,5,3174.6,7175.17,198.293,0,0,0,100,0),
(75405,6,3206.27,7208.28,193.488,0,0,0,100,0),
(75405,7,3226.79,7220.99,193.488,0,0,0,100,0),
(75405,8,3255.19,7222.58,193.488,0,0,0,100,0),
(75405,9,3300.44,7212.05,189.294,0,0,0,100,0),
(75405,10,3313.93,7200.43,189.294,0,0,0,100,0),
(75405,11,3343.27,7180.31,189.294,0,0,0,100,0),
(75405,12,3375.99,7142.72,189.294,0,0,0,100,0),
(75405,13,3417.93,7115.4,189.294,0,0,0,100,0),
(75405,14,3443.3,7078.94,189.294,0,0,0,100,0),
(75405,15,3423.43,7041.69,183.628,0,0,0,100,0),
(75405,16,3389.92,7007.88,183.628,0,0,0,100,0),
(75405,17,3346.99,6983.5,183.628,0,0,0,100,0),
(75405,18,3303.02,6983.78,183.628,0,0,0,100,0),
(75405,19,3281.57,7027.43,186.35,0,0,0,100,0),
(75405,20,3283.78,7064.68,186.433,0,0,0,100,0),
(75405,21,3281.75,7085.84,187.989,0,0,0,100,0),
(75405,22,3266.41,7105.88,192.072,0,0,0,100,0),
(75405,23,3242.7,7118.66,196.016,0,0,0,100,0),
(75405,24,3227.07,7124.38,198.293,0,0,0,100,0),
(75405,25,3197.35,7140.33,198.293,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 74614;
INSERT INTO `creature` VALUES (74614, 21309, 530, 1, 0, 0, -3693.65, 2668.37, 107.487, 4.3966, 300, 0, 0, 5589, 3155, 0, 2);
SET @GUID := 74614;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(74614,1,-3697.1,2669.77,107.186,0,0,0,100,0),
(74614,2,-3697.68,2673.34,108.569,0,0,0,100,0),
(74614,3,-3692.22,2678.74,108.66,0,0,0,100,0),
(74614,4,-3690.04,2682.79,108.752,0,0,0,100,0),
(74614,5,-3692.89,2684.18,108.485,6000,0,2130901,100,0), 
(74614,6,-3690.92,2682.03,108.744,0,0,0,100,0),
(74614,7,-3694.07,2677.51,108.537,0,0,0,100,0),
(74614,8,-3697.53,2673.77,108.581,0,0,0,100,0),
(74614,9,-3693.46,2668.44,107.174,20000,0,0,100,0);

DELETE FROM `waypoint_scripts` WHERE `id` = 2130901;
INSERT INTO `waypoint_scripts` VALUES (2130901, 1, 15, 36578, 0, 0, 0, 0, 0, 0, 2130901, 'cast 36578 on buddy');
INSERT INTO `waypoint_scripts` VALUES (2130901, 5, 15, 6273, 0, 0, 0, 0, 0, 0, 2130902, 'cast 6273 on X');

DELETE FROM `creature` WHERE `guid` = 72380;
INSERT INTO `creature` VALUES (72380, 20410, 530, 1, 0, 0, 2295.74, 2100.04, 78.143, 1.8877, 300, 0, 0, 7500, 0, 0, 2);
SET @GUID := 72380;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES
(72380,1,2292.12,2100.73,76.9142,0,0,0,100,0),
(72380,2,2284.79,2102.1,69.642,0,0,0,100,0),
(72380,3,2282.07,2087.95,65.2024,0,0,0,100,0),
(72380,4,2277.8,2060.16,65.7808,0,0,0,100,0),
(72380,5,2284.91,2047.64,67.2429,0,0,0,100,0),
(72380,6,2289.74,2052.37,70.4908,0,0,0,100,0),
(72380,7,2299.16,2070.77,74.9437,0,0,0,100,0),
(72380,8,2301.77,2075.56,74.3596,0,0,0,100,0),
(72380,9,2304.54,2080.78,75.7481,0,0,0,100,0),
(72380,10,2304.76,2088.31,76.84,0,0,0,100,0),
(72380,11,2292.5,2100.48,77.0599,0,0,0,100,0);

-- Raging Fire-Soul no ai/script
UPDATE `creature_template` SET `AIName`= NULL WHERE `entry` = 22311;

-- Harbinger Skyriss 20912,21599
-- 50028 was empty, reused and now back to original values
DELETE FROM `creature_loot_template` WHERE `item` IN (50028,50033) AND `entry` = 21599;
INSERT INTO `creature_loot_template` VALUES 
(21599,50033,40,0,-50033,1,0,0,0);

DELETE FROM `reference_loot_template` WHERE `entry` = 50033;
INSERT INTO `reference_loot_template` VALUES (50033, 30581, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50033, 30575, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50033, 30582, 0, 1, 1, 1, 0, 0, 0);

DELETE FROM `reference_loot_template` WHERE `entry` = 50028;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31883', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31884', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31886', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31887', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31893', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31894', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31896', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31898', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31902', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31903', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31905', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31906', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31911', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31912', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31915', '0', '1', '1', '1', '0', '0', '0');
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES ('50028', '31916', '0', '1', '1', '1', '0', '0', '0');

-- Tainted Earthgrab Totem 18176,19897 
UPDATE creature_template SET spell1 = 20654 WHERE entry = 18176; 
UPDATE creature_template SET spell1 = 20654 WHERE entry = 19897; 

-- Tainted Stoneskin Totem 18177,19900 
UPDATE creature_template SET spell1 = 31986 WHERE entry = 18177; 
UPDATE creature_template SET minhealth='5', maxhealth='5', spell1 = 31986 WHERE entry = 19900; 

-- Corrupted Nova Totem 18179,19899 
UPDATE creature_template SET spell1 = 33132 WHERE entry = 18179; 
UPDATE creature_template SET spell1 = 33132 WHERE entry = 19899; 

-- Mennu's Healing Ward 20208,22322 
UPDATE creature_template SET heroic_entry = 22322, spell1 = 34977 WHERE entry = 20208; 
UPDATE creature_template SET spell1 = 38800 WHERE entry = 22322;

-- slight ppm-correction for OoC
UPDATE `spell_proc_event` SET `ppmRate` = 2.5 WHERE `entry` = 16864; -- 2
