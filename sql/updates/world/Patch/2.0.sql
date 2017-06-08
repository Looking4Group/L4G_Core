-- ================
-- 2.0
-- ================

-- ========
-- Temp Out
-- ========

-- Spellcost Reduce /3 to 60
-- UPDATE `npc_trainer` SET `spellcost` = `spellcost`/3 WHERE `reqskill` = 0 AND `reqskillvalue` = 0 AND `reqlevel` < 60;

-- Arena Team Creation Npcs
-- UPDATE `creature` SET `spawnmask` = 0 WHERE `id` IN (18897,19856,19861,25991,26012); -- 1

-- Temp Reduce Creature Respawn
-- UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (705, 707, 724); -- 370
-- UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (1765, 1769, 2176, 2189, 2231, 2234, 3110, 3242, 3243, 3244, 3246, 3254, 3255, 3266, 3267, 3268, 3269, 3271, 3272, 3273, 3285, 3379, 3380, 3381, 3382, 3383, 3397, 3415, 3835, 4316, 5766, 10158, 10159, 10160, 12296, 12298, 1767, 1766, 1768, 1770, 1772, 1773, 1778, 1779, 1780, 1781, 1782, 1797, 1865, 1866, 1867, 1868, 1869, 1870, 1888, 1889, 1908, 1909, 1912, 1913, 1914, 1915, 1923, 1924, 1939, 1940, 1942, 1943, 1947, 1951, 1953, 1954, 1955, 1956, 1957, 1958, 1971, 1972, 1973, 1974, 1978, 1983, 2053, 2054, 2069, 2070, 2071, 2120, 2163, 2164, 2165, 2167, 2168, 2169, 2170, 2171, 2177, 2178, 2179, 2180, 2181, 2182, 2183, 2185, 2187, 2190, 2201, 2202, 2203, 2204, 2205, 2206, 2207, 2208, 2212, 2232, 2233, 2235, 2236, 2237, 2321, 2322, 2323, 2324, 2336, 2338, 2339, 3234, 3236, 3239, 3240, 3241, 3245, 3247, 3248, 3250, 3251, 3256, 3258, 3260, 3261, 3263, 3265, 3274, 3275, 3276, 3277, 3278, 3279, 3280, 3281, 3282, 3283, 3284, 3286, 3384, 3385, 3386, 3416, 3424, 3425, 3426, 3456, 3461, 3463, 3466, 3631, 3632, 3633, 3634, 3638, 3641, 4127, 4129, 6020, 6033); -- 275
-- UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (2949, 2950, 2951, 2952, 2953, 2954, 2956, 2957, 2958, 2959, 2960, 2962, 2963, 2964, 2965, 2969, 2970, 2971, 2972, 2973, 2974, 2975, 2976, 2977, 2978, 2979, 2989, 2990, 3035, 3232, 3566); -- 250
-- UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (3101, 3102, 3106, 3124, 3125, 3128); -- 200
-- UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (6, 30, 38, 40, 43, 46, 69, 80, 94, 97, 103, 113, 116, 118, 257, 285, 299, 327, 330, 390, 473, 474, 475, 476, 478, 524, 525, 704, 706, 708, 732, 735, 808, 822, 880, 881, 946, 1115, 1116, 1117, 1118, 1120, 1121, 1122, 1123, 1124, 1125, 1126, 1127, 1128, 1131, 1133, 1134, 1135, 1138, 1196, 1199, 1201, 1211, 1388, 1397, 1689, 1718, 1922, 1961, 3100, 3127, 3225, 3227, 5893, 6093, 6123, 6124, 6846, 6886, 6927, 13159); -- 180
-- UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (2955, 2961, 2966); -- 155
-- UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (1501, 1502, 1508, 1512, 3098, 7319); -- 120

-- UPDATE `creature` SET `spawntimesecs` = 90 WHERE `spawntimesecs` = 300 AND `map` IN (0, 1, 530) AND `curhealth` < 1200;

-- Temp Reduce Go Respawn
-- UPDATE `gameobject` SET `spawntimesecs` = 900 WHERE `spawntimesecs` = 122; -- 900 Reset after some time 122
-- UPDATE `gameobject` SET `spawntimesecs` = 1200 WHERE `spawntimesecs` = 123; -- 1200 123
-- UPDATE `gameobject` SET `spawntimesecs` = 300 WHERE `spawntimesecs` = 124; -- 300 124
-- UPDATE `gameobject` SET `spawntimesecs` = 600 WHERE `spawntimesecs` = 125; -- 600 125

-- Remove Start Items
-- TRUNCATE TABLE `playercreateinfo_item`;

-- Remove Target Dummies
-- DELETE FROM `creature` WHERE `guid` BETWEEN 10000100 AND 10000153;
-- DELETE FROM `creature_addon` WHERE `guid` BETWEEN 10000100 AND 10000153;

-- Instant Npcs
-- DELETE FROM `creature` WHERE `id` IN (1000001,1000003);

-- chests in azeroth
-- UPDATE `gameobject` SET `spawnmask` = 0 WHERE `id` IN (2850, 2855, 2857, 4149, 153454);

-- ========
-- Creatures
-- ========

-- ========
-- Creature Phase IN
-- ========

UPDATE `creature` SET `spawnmask` = 1 WHERE `id` IN (22201,22221,22217,22218,22287,22289,22451,22174,22283,22385,21723);
-- UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` IN ();
UPDATE `creature` SET `id` = 21844 WHERE `id` = 23029;
-- Wrath Fiend 22392
UPDATE `creature` SET `id` = 22392 WHERE `guid` IN (78717,78718,78719);
-- Wrath Fiend 22286
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` IN (78325,78326,78327,78328,78329,78330,78331,78332,78333);
-- Bladespine Basilisk 22187
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` IN (77814,77815,77816,77817,77818,77819,77820);
-- Nightmare Imp 22202
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` IN (77855,77856,77857,77858,77859,77860,77861,77862,77863,77864,77865,77866);
-- Terror-Fire Guardian 22327
UPDATE `creature` SET `id` = 22327 WHERE `guid` IN (78559,78560,78561,78562,78563,78564);
-- Terrordar the Tormentor 22385
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` = 78694;
-- Spire Needler 22194
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` IN (77821,77822,77823,77824,77825,77826,77827,77828,77829,77830,77831,77832,77833,77834,77835,77836,77837,77838,77839,77840,77841,77842,77843,77844,77845);
-- Deathlash Stinger 22257 -> Aether Ray
UPDATE `creature` SET `id` = 22257 WHERE `guid` BETWEEN 77787 AND 77791;
DELETE FROM `creature` WHERE `guid` IN (78216,78217,78218,78219,78220,78221,78223,78224,78225,78226,78227,78228,78229,78230,78231,78232,78233,78234,78235,78236,78237,78238,78239,78240,78241,78242,78243,78244,78245,78246,78247,78248,78249,78250,78251,78252,78253,78254,78255,78256,78257,78258,78259,78260,78261);
INSERT INTO `creature` VALUES (78216, 22257, 530, 1, 0, 0, 2706.82, 7151.3, 364.832, 4.39658, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78217, 22257, 530, 1, 0, 0, 2778.18, 7217.4, 365.399, 2.17515, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78218, 22257, 530, 1, 0, 0, 2650.19, 7215.58, 363.941, 4.31096, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78219, 22257, 530, 1, 0, 0, 2616.01, 7245.59, 364.671, 1.10546, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78220, 22257, 530, 1, 0, 0, 2512.59, 7275.21, 367.263, 2.72734, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78221, 22257, 530, 1, 0, 0, 2527.36, 7253.35, 364.53, 5.55499, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78223, 22257, 530, 1, 0, 0, 2504.71, 7245.27, 365.684, 0.66838, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78224, 22257, 530, 1, 0, 0, 2458.35, 7281.86, 365.359, 4.08158, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78225, 22257, 530, 1, 0, 0, 2446.84, 7359.08, 365.205, 2.49121, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78226, 22257, 530, 1, 0, 0, 2061.52, 7271.81, 363.911, 2.25509, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78227, 22257, 530, 1, 0, 0, 2099.33, 7330.34, 364.607, 2.57119, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78228, 22257, 530, 1, 0, 0, 2067.45, 7331.05, 364.735, 4.17056, 300, 0, 0, 7181, 0, 0, 0);
INSERT INTO `creature` VALUES (78229, 22257, 530, 1, 0, 0, 2159.1853, 7331.5122, 364.6892, 5.89536, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78230, 22257, 530, 1, 0, 0, 2032.96, 7259.08, 363.918, 5.56344, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78231, 22257, 530, 1, 0, 0, 2036.44, 7293.47, 363.316, 5.38637, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78232, 22257, 530, 1, 0, 0, 1843.66, 7295.39, 364.686, 3.08165, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78233, 22257, 530, 1, 0, 0, 1858.35, 7351.39, 363.794, 2.91742, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78234, 22257, 530, 1, 0, 0, 1789.23, 7122.59, 362.149, 3.0024, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78235, 22257, 530, 1, 0, 0, 1926.84, 7195.48, 364.116, 3.93496, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78236, 22257, 530, 1, 0, 0, 2121.94, 7160.59, 363.906, 6.17584, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78237, 22257, 530, 1, 0, 0, 2114.53, 7187.61, 366.179, 4.56345, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78238, 22257, 530, 1, 0, 0, 2206.19, 7122.32, 364.065, 4.78504, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78239, 22257, 530, 1, 0, 0, 2239.24, 7142.74, 366.781, 2.45333, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78240, 22257, 530, 1, 0, 0, 2224.77, 7099.38, 365.982, 1.09666, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78241, 22257, 530, 1, 0, 0, 2353.17, 7104.93, 367.007, 2.18587, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78242, 22257, 530, 1, 0, 0, 2403.47, 7083.51, 366.579, 4.23665, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78243, 22257, 530, 1, 0, 0, 2490, 7043.62, 366.056, 4.14772, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78244, 22257, 530, 1, 0, 0, 2458.42, 7049.03, 367.785, 5.5253, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78245, 22257, 530, 1, 0, 0, 2464.83, 7072.46, 364.959, 6.15883, 300, 0, 0, 7181, 0, 0, 0);
INSERT INTO `creature` VALUES (78246, 22257, 530, 1, 0, 0, 2678.12, 7120.47, 364.677, 4.06626, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78247, 22257, 530, 1, 0, 0, 3790.07, 5840.06, 261.204, 5.2408, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78248, 22257, 530, 1, 0, 0, 3815.14, 5857.78, 266.07, 2.85368, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78249, 22257, 530, 1, 0, 0, 3877.0700, 5943.6000, 270.9169, 1.46953, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78250, 22257, 530, 1, 0, 0, 3899.06, 5968.08, 268.173, 3.42963, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78251, 22257, 530, 1, 0, 0, 3827.45, 5814.51, 267.705, 4.15338, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78252, 22257, 530, 1, 0, 0, 4085.43, 5827.83, 264.129, 2.14618, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78253, 22257, 530, 1, 0, 0, 4077.67, 5856.85, 256.653, 6.22165, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78254, 22257, 530, 1, 0, 0, 4047.39, 5913.28, 263.395, 4.89851, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78255, 22257, 530, 1, 0, 0, 4041.46, 5970.79, 265.805, 6.14957, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78256, 22257, 530, 1, 0, 0, 3999.1237, 6005.3378, 268.6499, 3.2317, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78257, 22257, 530, 1, 0, 0, 3917.28, 6008.18, 267.865, 5.58632, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78258, 22257, 530, 1, 0, 0, 4006.68, 6042.7, 261.141, 5.28363, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78259, 22257, 530, 1, 0, 0, 3952.79, 6078.67, 266.482, 0.737055, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78260, 22257, 530, 1, 0, 0, 3905.1, 6107.35, 266.69, 5.08921, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (78261, 22257, 530, 1, 0, 0, 3997.91, 6093.29, 260.065, 3.98226, 300, 5, 0, 7181, 0, 0, 1);

-- ========
-- Creature Phase OUT
-- ========

UPDATE `creature` SET `spawnmask` = 0 WHERE `id` IN (18528,22861,22862,22863,22864,12270,12271,24937,22987,22982,23016,23415,23257,22967,22966,23473,23115,22919,24918,24933,24919,22980,23363,22941,24393,23383,23219);
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (84715,79011,79033,44253,40444,8313,2126,2115,12235,12234,12177,12236,96669,79015,79031,79030,79013,79014,44255,44257,44254,48166,86834,44256,91786,91785,91781,91789,91792,91780,91784,91782,91783,91788,91787,91790,91791,91793);

-- ========
-- Creature Change
-- ========

-- Morogrimm Positioning
UPDATE `creature` SET `position_x`='354.7654', `position_y`='-723.9628', `position_z`='-13.8946', `orientation`='3.2655' WHERE `guid` = 82974;

-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `mechanic_immune_mask`='1073692671' WHERE `entry` = 21863;

-- Coilfang Priestess 21220
UPDATE `creature_template` SET `mechanic_immune_mask`='69649' WHERE `entry` = 21220;

-- Tidewalker Lurker - Call for Help on Aggro
DELETE FROM `creature_ai_scripts` WHERE `id` = 2192002;
INSERT INTO `creature_ai_scripts` VALUES ('2192002','21920','4','0','100','2','0','0','0','0','39','15','0','0','0','0','0','0','0','0','0','0','Tidewalker Lurker - Call for Help on Aggro');

-- ========
-- Quests & Access
-- ========

-- MH, BT, ZA, SWP, MGT
UPDATE `access_requirement` SET `level_min` = 71 WHERE `id` IN (29, 47, 49, 50, 51);

-- MH
DELETE FROM `creature_questrelation` WHERE `quest` IN (10460,10461,10462,10463);
-- INSERT INTO `creature_questrelation` VALUES (19935, 10460);
-- INSERT INTO `creature_questrelation` VALUES (19935, 10461);
-- INSERT INTO `creature_questrelation` VALUES (19935, 10462);
-- INSERT INTO `creature_questrelation` VALUES (19935, 10463);

-- BT
DELETE FROM `creature_questrelation` WHERE `quest` IN (10947);
-- INSERT INTO `creature_questrelation` VALUES (21700, 10947);

-- Ogri'la
DELETE FROM `creature_questrelation` WHERE `quest` IN (10339,10969);
INSERT INTO `creature_questrelation` VALUES (20448, 10339);
-- INSERT INTO `creature_questrelation` VALUES (22899, 10969);

-- Netherwing
DELETE FROM `creature_questrelation` WHERE `quest` IN (11012,11013);
-- INSERT INTO `creature_questrelation` VALUES (22113, 11012);
-- INSERT INTO `creature_questrelation` VALUES (22113, 11013);

-- Druid Flight Quest
DELETE FROM `creature_questrelation` WHERE `id` = 12042 AND `quest` = 10955;
-- INSERT INTO `creature_questrelation` VALUES (12042, 10955);

-- ========
-- Loot
-- ========

-- Magtheridons Head
DELETE FROM `creature_loot_template` WHERE `item` IN (32385,32386);
-- INSERT INTO `creature_loot_template` VALUES (17257, 32386, 100, 0, 1, 1, 6, 67, 0); 
-- INSERT INTO `creature_loot_template` VALUES (17257, 32385, 100, 0, 1, 1, 6, 469, 0);

-- Darkmoon Cards
DELETE FROM `creature_loot_template` WHERE `item` IN (31882,31883,31884,31885,31886,31887,31888,31889,31892,31893,31894,31895,31896,31898,31899,31900,31901,31902,31903,31904,31905,31906,31908,31909,31910,31911,31912,31913,31915,31916,31917,31918);
DELETE FROM `reference_loot_template` WHERE `entry` IN (43000,50028);
DELETE FROM `creature_loot_template` WHERE `mincountOrRef` IN (-43000,-50028);

-- Time-Lost Scroll
DELETE FROM `creature_loot_template` WHERE `item` = 32620;
-- INSERT INTO `creature_loot_template` VALUES (21651, 32620, 45, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (21763, 32620, 45, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (21787, 32620, 45, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (21804, 32620, 5, 0, 1, 1, 0, 0, 0);

-- Shadow Dust
DELETE FROM `creature_loot_template` WHERE `item` = 32388;
-- INSERT INTO `creature_loot_template` VALUES (21644, 32388, 33, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (21649, 32388, 33, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (21650, 32388, 33, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (21804, 32388, 5, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (21911, 32388, 33, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (23066, 32388, 33, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (23067, 32388, 33, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (23068, 32388, 33, 0, 1, 1, 0, 0, 0);

-- Verdant Sphere
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `item` = 32405;

-- Netherwing Eggs Creature Loot
DELETE FROM `creature_loot_template` WHERE `item` = 32506;

-- (Re)Activate Mark of the Illidari
UPDATE `creature_loot_template` SET `mincountOrRef` = 0, `maxcount` = 0 WHERE `item` = 32897;

-- (Re)Activate Trash Patterns
-- <~1% fist entry 0,984
UPDATE `creature_loot_template` SET `mincountOrRef` = 0,`maxcount` = 0 WHERE `item` IN (30321,30322,30323,30324,30280,30281,30282,30283,30301,30302,30303,30304,30305,30306,30307,30308);

-- (Re)Activate Boss Pattern
UPDATE `reference_loot_template` SET `mincountOrRef` = 0, `maxcount` = 0 WHERE `entry` = 34052;

-- (Re)Activate 32902,32905 Bottled Nethergon Energy / Bottled Nethergon Vapor
UPDATE `creature_loot_template` SET `mincountOrRef` = 0, `maxcount` = 0 WHERE `item` IN (32902,32905);

-- (Re)Activate Coilfang Armaments in SSC
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21863 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21339 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21301 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21299 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21298 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21263 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21251 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21232 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21231 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21230 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21229 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21228 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21227 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21226 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21225 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21224 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21221 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21220 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21218 AND `item` = 24368; -- 12

-- High King Maulgar 18831
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 18831 AND `item` = 34050;

-- Gruul the Dragonkiller 19044
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 19044 AND `item` = 190039;

-- Magtheridon 17257
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 17257 AND `item` = 34039;

-- Void Reaver 19516
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 19516 AND `item` = 34054;

-- Leotheras the Blind 21215
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 21215 AND `item` = 34059;

-- Fathom-Lord Karathress 21214
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 21214 AND `item` = 34060;

-- Lady Vashj 21212
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 21212 AND `item` = 50031;

-- Kael'thas Sunstrider 19622
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 19622 AND `item` = 50032;

-- Apexis Shard
DELETE FROM `creature_loot_template` WHERE `item` = 32569;

-- Depleted Items
DELETE FROM `creature_loot_template` WHERE `item` IN (32672,32677,32676,32576,32673,32671,32675,32678,32679,32674,32670);

-- Drop Motes of Shadow/Fire
UPDATE `creature_loot_template` SET `item` = 22577 WHERE `item` = 22574 AND `entry` = 22323;

-- Gem Patterns (Design: Rigid Star of Elune, Design: Shifting Nightseye, Design: Glinting Nightseye, Design: Veiled Nightseye, Design: Deadly Noble Topaz
DELETE FROM `reference_loot_template` WHERE `entry` = 24092 AND `item` IN (31875,31876,31877,31878,31879);
DELETE FROM `reference_loot_template` WHERE `entry` = 10006 AND `item` IN (31875,31876,31877);

-- Design: Thundering Skyfire Diamond
DELETE FROM `reference_loot_template` WHERE `item` = 32411;

-- ========
-- Items
-- ========

-- Rod of the Sun King
UPDATE `spell_proc_event` SET `cooldown` = 0, `ppmRate` = 6 WHERE `entry` = 36070;

-- HC Keys at revered
UPDATE `item_template` SET `RequiredReputationRank` = 6 WHERE `entry` IN (30634, 30623, 30622, 30637, 30635, 30633);

-- ========
-- Gameobjects
-- ========

-- Netherwing Gos
UPDATE `gameobject` SET `spawnmask` = 0 WHERE `id` IN (185877, 185915, 185881);

-- Ethereum Prison
UPDATE `gameobject` SET `spawnmask` = 0 WHERE `id` IN (184418,184419,184420,184421,184422,184423,184424,184425,184426,184427,184428,184429,184430,184431,184998,185460,185464,185466,185512,185461); 

-- ========
-- Trainer & Vendor
-- ========

-- G'eras
DELETE FROM `npc_vendor` WHERE `entry` = 18525;
-- 2.0
INSERT INTO `npc_vendor` VALUES (18525, 29266, 0, 0, 1037);
INSERT INTO `npc_vendor` VALUES (18525, 29267, 0, 0, 1037);
INSERT INTO `npc_vendor` VALUES (18525, 29268, 0, 0, 1037);
INSERT INTO `npc_vendor` VALUES (18525, 29269, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29270, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29271, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29272, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29273, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29274, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29275, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 29367, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29368, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29369, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29370, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29373, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29374, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29375, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29376, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29379, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29381, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29382, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29383, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29384, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29385, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29386, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29387, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29388, 0, 0, 1642);
INSERT INTO `npc_vendor` VALUES (18525, 29389, 0, 0, 1642);
INSERT INTO `npc_vendor` VALUES (18525, 29390, 0, 0, 1642);
INSERT INTO `npc_vendor` VALUES (18525, 30761, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30762, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30763, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30764, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30766, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30767, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30768, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30769, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30770, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30772, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30773, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30774, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30776, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30778, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30779, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30780, 0, 0, 1452);

-- Recipe: Earthen Elixir
DELETE FROM `npc_vendor` WHERE `entry` = 17904 AND `item` = 32070;
-- INSERT INTO `npc_vendor` VALUES (17904, 32070, 0, 0, 0);

-- Recipe: Elixir of Ironskin
DELETE FROM `npc_vendor` WHERE `item` = 32071;
-- INSERT INTO `npc_vendor` VALUES (18821, 32071, 0, 0, 1765);
-- INSERT INTO `npc_vendor` VALUES (18822, 32071, 0, 0, 1765);

-- Elixir of Major Fortitude
DELETE FROM `npc_trainer` WHERE `spell` = 39636;
-- INSERT INTO `npc_trainer` VALUES (16588, 39636, 25000, 171, 310, 0);
-- INSERT INTO `npc_trainer` VALUES (18802, 39636, 25000, 171, 310, 0);
-- INSERT INTO `npc_trainer` VALUES (19052, 39636, 25000, 171, 310, 0);

-- Elixir of Draenic Wisdom
DELETE FROM `npc_trainer` WHERE `spell` = 39638;
-- INSERT INTO `npc_trainer` VALUES (16588, 39638, 30000, 171, 320, 0);
-- INSERT INTO `npc_trainer` VALUES (18802, 39638, 30000, 171, 320, 0);
-- INSERT INTO `npc_trainer` VALUES (19052, 39638, 30000, 171, 320, 0);

-- Cauldron of *
DELETE FROM `skill_discovery_template` WHERE `spellId` BETWEEN 41458 AND 41503;
-- INSERT INTO `skill_discovery_template` VALUES (41458, 28575, 30);
-- INSERT INTO `skill_discovery_template` VALUES (41500, 28571, 30);
-- INSERT INTO `skill_discovery_template` VALUES (41501, 28572, 30);
-- INSERT INTO `skill_discovery_template` VALUES (41502, 28573, 30);
-- INSERT INTO `skill_discovery_template` VALUES (41503, 28576, 30);

-- Formula: Enchant Weapon - Major Striking
DELETE FROM `npc_vendor` WHERE `item` = 22552;
-- INSERT INTO `npc_vendor` VALUES (20242, 22552, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (23007, 22552, 0, 0, 0);

-- Schematic: Fused Wiring
DELETE FROM `npc_vendor` WHERE `item` = 32381;
-- INSERT INTO `npc_vendor` VALUES (11185, 32381, 1, 10800, 0);
-- INSERT INTO `npc_vendor` VALUES (19661, 32381, 1, 600, 0);

-- Several new recipes
DELETE FROM `npc_trainer` WHERE `spell` IN (41414,41415,41418,41420,41429,40514);
-- INSERT INTO `npc_trainer` VALUES (18751, 40514, 30000, 755, 340, 0);
-- INSERT INTO `npc_trainer` VALUES (18751, 41418, 30000, 755, 365, 0);
-- INSERT INTO `npc_trainer` VALUES (18751, 41414, 10000, 755, 325, 0);
-- INSERT INTO `npc_trainer` VALUES (18751, 41415, 10000, 755, 330, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 40514, 30000, 755, 340, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 41418, 30000, 755, 365, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 41414, 10000, 755, 325, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 41415, 10000, 755, 330, 0);
-- INSERT INTO `npc_trainer` VALUES (19063, 40514, 30000, 755, 340, 0);
-- INSERT INTO `npc_trainer` VALUES (19063, 41418, 30000, 755, 365, 0);
-- INSERT INTO `npc_trainer` VALUES (19063, 41414, 10000, 755, 325, 0);
-- INSERT INTO `npc_trainer` VALUES (19063, 41415, 10000, 755, 330, 0);
-- INSERT INTO `npc_trainer` VALUES (19539, 40514, 30000, 755, 340, 0);
-- INSERT INTO `npc_trainer` VALUES (19539, 41418, 30000, 755, 365, 0);
-- INSERT INTO `npc_trainer` VALUES (19539, 41415, 10000, 755, 330, 0);
-- INSERT INTO `npc_trainer` VALUES (19539, 41414, 10000, 755, 325, 0);
-- INSERT INTO `npc_trainer` VALUES (18751, 41429, 10000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 41429, 10000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (19063, 41429, 10000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (19539, 41429, 10000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (19539, 41420, 8500, 755, 325, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 41420, 8500, 755, 325, 0);

-- Frost Grenade
DELETE FROM `npc_trainer` WHERE `spell` = 39973;
-- INSERT INTO `npc_trainer` VALUES (17634, 39973, 55000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (17637, 39973, 55000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (18752, 39973, 55000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (18775, 39973, 55000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (19576, 39973, 55000, 202, 335, 0);

-- Icy Blasting Primers
DELETE FROM `npc_trainer` WHERE `spell` = 39971;
-- INSERT INTO `npc_trainer` VALUES (17634, 39971, 20000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (17637, 39971, 20000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (18752, 39971, 20000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (18775, 39971, 20000, 202, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (19576, 39971, 20000, 202, 335, 0);

-- Design: Relentless Earthstorm Diamond
DELETE FROM `npc_vendor` WHERE `item` IN (33622,32412);
-- INSERT INTO `npc_vendor` VALUES (20242, 32412, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (23007, 32412, 0, 0, 0);

-- Engineering Goggles
DELETE FROM `npc_trainer` WHERE `spell` IN (40274,41311,41312,41314,41315,41316,41317,41318,41319,41320,41321);

-- Gyro-balanced Khorium Destroyer 
DELETE FROM `npc_trainer` WHERE `spell` = 41307;

-- Purified Shadow Pearl
DELETE FROM `npc_trainer` WHERE `spell` = 41429;

-- ========
-- Reputation
-- ========

-- Skyguard Rep
DELETE FROM `creature_onkill_reputation` WHERE `RewonKillRepFaction1` = 1031;
-- INSERT INTO `creature_onkill_reputation` VALUES (21644, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21649, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21650, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21651, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21652, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21763, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21787, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21804, 1031, 0, 6, 0, 5, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21838, 1031, 0, 7, 0, 500, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21911, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21912, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (21985, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23029, 1031, 0, 7, 0, 30, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23051, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23066, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23067, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23068, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23161, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23162, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23163, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23165, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
-- INSERT INTO `creature_onkill_reputation` VALUES (23207, 1031, 0, 7, 0, 10, 0, 0, 0, 0);

-- Patch 2.1.2

-- Design: Mystic Dawnstone
DELETE FROM `npc_vendor` WHERE `item` = 24208;
-- INSERT INTO `npc_vendor` VALUES (21474, 24208, 1, 86400, 0);
-- INSERT INTO `npc_vendor` VALUES (21485, 24208, 1, 86400, 0);

-- Fisherman's Feast
-- Hot Buttered Trout
-- Stewed Trout
UPDATE `creature_template` SET `npcflag`=`npcflag`&~16 WHERE `entry`=19186;

-- =============================================================================================
-- Patch 2.2.0
-- =============================================================================================

-- Eye Vendor
-- Recipe: Flask of Chromatic Wonder
-- Formula: Enchant Weapon - Greater Agility
-- Pattern: Cloak of Darkness
-- Pattern: Shadowprowler's Chestguard
DELETE FROM `npc_vendor` WHERE `item` IN (33209,33165,33124,33205);
-- INSERT INTO `npc_vendor` VALUES (18255, 33124, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (18255, 33165, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (18255, 33205, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (18255, 33209, 0, 0, 0);

-- Ragesteel Shoulders
DELETE FROM `creature_loot_template` WHERE `item` = 33174;
-- Fix Plans: Ragesteel Shoulders To Drop More Blizzlike - (Current Rates are wowhead and these only drop for Blacksmith Players)
-- UPDATE `creature_loot_template` SET `Chance` = 1 WHERE `item` = 33174 AND `entry` IN (21050,21061);
-- UPDATE `creature_loot_template` SET `Chance` = 0.5 WHERE `item` = 33174 AND `entry` IN (21059,21060);
-- INSERT INTO `creature_loot_template` VALUES (21050, 33174, 2.5, 0, 1, 1, 7, 164, 1);
-- INSERT INTO `creature_loot_template` VALUES (21059, 33174, 2.5, 0, 1, 1, 7, 164, 1);
-- INSERT INTO `creature_loot_template` VALUES (21060, 33174, 2.5, 0, 1, 1, 7, 164, 1);
-- INSERT INTO `creature_loot_template` VALUES (21061, 33174, 2.5, 0, 1, 1, 7, 164, 1);

-- Design: Great Golden Draenite and similar
DELETE FROM `creature_loot_template` WHERE `mincountOrRef` = -25030;
-- INSERT INTO `creature_loot_template` VALUES (18607, 25030, 25, 2, -25030, 1, 0, 0, 0);

-- Several new recipes for Jewelcrafter Gems
DELETE FROM `npc_vendor` WHERE `item` IN (33159,33156,33305,33160,33157,33155);
-- INSERT INTO `npc_vendor` VALUES (20242, 33156, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (20242, 33305, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21432, 33155, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21432, 33159, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21643, 33160, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21655, 33157, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (23007, 33156, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (23007, 33305, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21643, 33158, 0, 0, 0);

-- Formula: Enchant Cloak - Dodge
-- Formula: Enchant Cloak - Stealth
-- Formula: Enchant Cloak - Subtlety
-- Formula: Enchant Gloves - Superior Agility
-- Formula: Enchant Gloves - Threat
DELETE FROM `npc_vendor` WHERE `item` IN (33148,33149,33150,33151,33152,33153);
INSERT INTO `npc_vendor` VALUES (17657, 33150, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 33151, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (17904, 33149, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21432, 33153, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21643, 33152, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21655, 33148, 0, 0, 0);

-- Steady Talasite
DELETE FROM `npc_vendor` WHERE `item` IN (33783);
-- INSERT INTO `npc_vendor` VALUES (18821, 33783, 0, 0, 2236);
-- INSERT INTO `npc_vendor` VALUES (18822, 33783, 0, 0, 2236);

-- Nexus Transformation
-- Small Prismatic Shards
DELETE FROM `npc_trainer` WHERE `spell` IN (42613,42615);
-- INSERT INTO `npc_trainer` VALUES (19540, 42613, 1000, 333, 300, 0);
-- INSERT INTO `npc_trainer` VALUES (18753, 42613, 1000, 333, 300, 0);
-- INSERT INTO `npc_trainer` VALUES (19252, 42613, 1000, 333, 300, 0);
-- INSERT INTO `npc_trainer` VALUES (18773, 42613, 1000, 333, 300, 0);
-- INSERT INTO `npc_trainer` VALUES (19540, 42615, 40000, 333, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (18753, 42615, 40000, 333, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (19252, 42615, 40000, 333, 335, 0);
-- INSERT INTO `npc_trainer` VALUES (18773, 42615, 40000, 333, 335, 0);

-- =============================================================================================
-- Patch 2.3.0
-- http://wowwiki.wikia.com/wiki/Patch_2.3.0
-- =============================================================================================

-- ZA
-- UPDATE `access_requirement` SET `level_min` = 70 WHERE `id` = 49;

-- Mad Alchemist's Potion
DELETE FROM `npc_trainer` WHERE `spell` = 45061;
-- INSERT INTO `npc_trainer` VALUES (18802, 45061, 30000, 171, 325, 0);
-- INSERT INTO `npc_trainer` VALUES (16588, 45061, 30000, 171, 325, 0);
-- INSERT INTO `npc_trainer` VALUES (19052, 45061, 30000, 171, 325, 0);

-- Plans: Heavy Copper Longsword
UPDATE `quest_template` SET `RewItemId1` = 3609 WHERE `entry` = 1578; -- 33792

-- Plans: Adamantite Weapon Chain
DELETE FROM `creature_loot_template` WHERE `item` = 35296;
-- INSERT INTO `creature_loot_template` VALUES (24857, 35296, 0, 0, 0, 2, 1, 1, NULL);

-- Schematic: Field Repair Bot 110G
DELETE FROM `creature_loot_template` WHERE `item` = 34114;
-- INSERT INTO `creature_loot_template` VALUES (23386, 34114, 0, 1.43, 0, 0, 1, 1, NULL);

-- Design: Chaotic Skyfire Diamond 
DELETE FROM `creature_loot_template` WHERE `item` = 34689;
-- INSERT INTO `creature_loot_template` VALUES (19768, 34689, 0, 2, 0, 0, 1, 1, NULL);

-- Pattern: Green Winter Clothes
DELETE FROM `npc_vendor` WHERE `item` = 34261;
-- INSERT INTO `npc_vendor` VALUES (13420, 34261, 0, 0, 0);

-- Pattern: Winter Boots
DELETE FROM `npc_vendor` WHERE `item` = 34262;
-- INSERT INTO `npc_vendor` VALUES (13420, 34262, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (13433, 34262, 0, 0, 0);

-- Pattern: Red Winter Clothes
DELETE FROM `npc_vendor` WHERE `item` = 34319;
-- INSERT INTO `npc_vendor` VALUES (13433, 34319, 0, 0, 0);

-- Leatherworker's Satchel
DELETE FROM `npc_trainer` WHERE `spell` = 45100;
-- INSERT INTO `npc_trainer` VALUES (18754, 45100, 15000, 165, 300, 0);
-- INSERT INTO `npc_trainer` VALUES (18771, 45100, 15000, 165, 300, 0);
-- INSERT INTO `npc_trainer` VALUES (19187, 45100, 15000, 165, 300, 0);
-- INSERT INTO `npc_trainer` VALUES (21087, 45100, 15000, 165, 300, 0);

-- Glove Reinforcements
DELETE FROM `npc_trainer` WHERE `spell` = 44770;
-- INSERT INTO `npc_trainer` VALUES (18754, 44770, 50000, 165, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (18771, 44770, 50000, 165, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (19187, 44770, 50000, 165, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (21087, 44770, 50000, 165, 350, 0);

-- Knothide Ammo Pouch
DELETE FROM `npc_trainer` WHERE `spell` = 44343;
-- INSERT INTO `npc_trainer` VALUES (18754, 44343, 18000, 165, 315, 0);
-- INSERT INTO `npc_trainer` VALUES (18771, 44343, 18000, 165, 315, 0);
-- INSERT INTO `npc_trainer` VALUES (19187, 44343, 18000, 165, 315, 0);
-- INSERT INTO `npc_trainer` VALUES (21087, 44343, 18000, 165, 315, 0);

-- Knothide Quiver
DELETE FROM `npc_trainer` WHERE `spell` = 44344;
-- INSERT INTO `npc_trainer` VALUES (18754, 44344, 18000, 165, 315, 0);
-- INSERT INTO `npc_trainer` VALUES (18771, 44344, 18000, 165, 315, 0);
-- INSERT INTO `npc_trainer` VALUES (19187, 44344, 18000, 165, 315, 0);
-- INSERT INTO `npc_trainer` VALUES (21087, 44344, 18000, 165, 315, 0);

-- Heavy Knothide Armor Kit
DELETE FROM `npc_trainer` WHERE `spell` = 44970;
-- INSERT INTO `npc_trainer` VALUES (18754, 44970, 50000, 165, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (18771, 44970, 50000, 165, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (21087, 44970, 50000, 165, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (19187, 44970, 50000, 165, 350, 0);

-- Netherscale Ammo Pouch, Quiver of a Thousand Feathers
DELETE FROM `npc_vendor` WHERE `item` IN (34200,34201,34218);
-- INSERT INTO `npc_vendor` VALUES (17585, 34201, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (17657, 34218, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (21655, 34200, 0, 0, 0);

-- Pattern: Bag of Many Hides
DELETE FROM `creature_loot_template` WHERE `item` = 34491;
-- INSERT INTO `creature_loot_template` VALUES (22143, 34491, 1.15, 0, 1, 1, 7, 165, 1);
-- INSERT INTO `creature_loot_template` VALUES (22144, 34491, 1.15, 0, 1, 1, 7, 165, 1);
-- INSERT INTO `creature_loot_template` VALUES (22148, 34491, 1.15, 0, 1, 1, 7, 165, 1);
-- INSERT INTO `creature_loot_template` VALUES (23022, 34491, 1.34, 0, 1, 1, 7, 165, 1);

-- Flying Machine 
DELETE FROM `npc_trainer` WHERE `spell` = 44155;
-- INSERT INTO `npc_trainer` VALUES (24868, 44155, 120000, 202, 350, 70);
-- INSERT INTO `npc_trainer` VALUES (25099, 44155, 120000, 202, 350, 70);

-- Turbo-Charged Flying Machine
DELETE FROM `npc_trainer` WHERE `spell` = 44157;
-- INSERT INTO `npc_trainer` VALUES (24868, 44157, 200000, 202, 375, 70);
-- INSERT INTO `npc_trainer` VALUES (25099, 44157, 200000, 202, 375, 70);

-- Weather-Beaten Journal
DELETE FROM `item_loot_template` WHERE `item` = 34109;
-- INSERT INTO `item_loot_template` VALUES (20708, 34109, 5, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `item_loot_template` VALUES (21113, 34109, 5, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `item_loot_template` VALUES (21150, 34109, 5, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `item_loot_template` VALUES (21228, 34109, 5, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `item_loot_template` VALUES (27481, 34109, 11, 0, 1, 1, 0, 0, 0);
-- INSERT INTO `item_loot_template` VALUES (27513, 34109, 43, 0, 1, 1, 0, 0, 0);

-- Plans: Hammer of Righteous Might
DELETE FROM `reference_loot_template` WHERE `entry` = 10006 AND `item` = 33954;
-- INSERT INTO `reference_loot_template` VALUES (10006, 33954, 0, 1, 1, 1, 0, 0, 0);

-- Daily Fishing
-- UPDATE `creature` SET `spawnmask` = 0 WHERE `id` = 25580; -- forgotten
-- Daily dungeon quests
-- Daily cooking quests
-- Daily PvP
UPDATE `creature` SET `spawnmask` = 1 WHERE `id` IN (15350, 15351);
UPDATE `quest_template` set `RewHonorableKills` = 20, `RewMoneyMaxLevel` = 0 where `entry` between 11335 and 11342; -- nonblizzlike 24 155999 blizzlike 20 75900

-- PvP Turn in Quest
UPDATE `quest_template` SET `ReqItemId1` = 0, `RewHonorableKills` = 15 WHERE `entry` IN (8388,8385); -- nonblizzlike 0 20 blizzlike 20560 15

-- 2.3 Rep PvP Gear
DELETE FROM `npc_vendor` where entry = 17585 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 17657 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 21655 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 17904 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 21432 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 21643 AND item > 35000;

-- Cenarion War Hippogryph
DELETE FROM `npc_vendor` WHERE `item` = 33999;
-- INSERT INTO `npc_vendor` VALUES (17904, 33999, 0, 0, 0);

-- =============================================================================================
-- Patch 2.4.0
-- Shattered Sun Offensive - We dont delte gameevents
-- SELECT * FROM `game_event` WHERE `entry` BETWEEN 35 AND 53;
-- =============================================================================================

-- SWP, MGT
-- UPDATE `access_requirement` SET `level_min` = 70 WHERE `id` IN (50, 51);

-- HC Keys at revered 
-- UPDATE `item_template` SET `RequiredReputationRank` = 5 WHERE `entry` IN (30634, 30623, 30622, 30637, 30635, 30633); -- 6

-- Brilliant Glass
DELETE FROM `npc_trainer` WHERE `spell` = 47280;
-- INSERT INTO `npc_trainer` VALUES (19539, 47280, 27000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (19063, 47280, 27000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 47280, 27000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (18751, 47280, 27000, 755, 350, 0);

-- Schematic: Rocket Boots Xtreme Lite
DELETE FROM `reference_loot_template` WHERE `item` = 35582 AND `entry` = 50019;
-- INSERT INTO `reference_loot_template` VALUES (50019, 35582, 10, 0, 1, 1, 0, 0, 0);

-- Shattrath Flask of Pure Death
-- Shattrath Flask of Blinding Light
DELETE FROM `npc_vendor` WHERE `item` IN (35716,35717);
-- INSERT INTO `npc_vendor` VALUES (23483, 35716, 0, 0, 1959);
-- INSERT INTO `npc_vendor` VALUES (23483, 35717, 0, 0, 1959);
-- INSERT INTO `npc_vendor` VALUES (23484, 35716, 0, 0, 1959);
-- INSERT INTO `npc_vendor` VALUES (23484, 35717, 0, 0, 1959);

-- Daily fishing quests
-- Forgotten to despawn 25580 

-- Charred Bear Kabobs
-- Juicy Bear Burger
DELETE FROM `npc_vendor` WHERE `item` IN (35564,35566);
-- INSERT INTO `npc_vendor` VALUES (2803, 35564, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (2803, 35566, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (2806, 35564, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (2806, 35566, 0, 0, 0);

-- 2.4 Magtheridons Black Sack of Gems and Pit Lord's Satchel
-- UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 17257 AND `item` IN (34846,34845);

-- Riding
-- Alliance First Mount
-- UPDATE `item_template` SET `RequiredLevel` = 40, `BuyPrice` = 1 WHERE `entry` IN (2411,2414,5655,5656,5864,5872,5873,8563,8595,8629,8631,8632,13321,13322,28481,29743,29744); -- 30 100000
-- UPDATE `npc_trainer` SET `spellcost` = 1, `reqlevel` = 40 WHERE `entry` IN (4732,4753,4772,7954,20914) AND `spell` = 33388; -- 350000 900000prenerf

-- Horde and other ReqSkill 762 Mounts
-- UPDATE `item_template` SET `RequiredLevel` = 40 WHERE `entry` IN (1132,5665,5668,8588,8591,8592,13331,13332,13333,15277,15290,28927,29220,29221,29222,33224,33976,37012); -- 30
-- UPDATE `npc_trainer` SET `spellcost` = 500000, `reqlevel` = 40 WHERE `entry` IN (3690,4752,4773,7953,16280) AND `spell` = 33388; -- 350000 900000 prenerf

-- Set Paladin and Warlock First Mount to 40
-- UPDATE `npc_trainer` SET `reqlevel` = 40 WHERE `spell` IN (5784,13819,34769); -- 30
-- Alliance Warlock and Paladin First Mount at Alliance Incentive Discount
-- UPDATE `npc_trainer` SET `spellcost` = 0 WHERE `spell` IN (5784,13819,34769) AND `entry` IN (5495,5496,906,459,461,5171,5173,5172,460,5612,5491,5492,925,927,928,5147,5148,5149,926,1232,8140,17483,17509,16501,16761,17121); -- 10000

-- ===========================================================================================

UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';
