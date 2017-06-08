-- ================
-- 2.1
-- ================

-- ========
-- Temp Out
-- ========

-- ========
-- Creatures
-- ========

-- ========
-- Creature Phase OUT
-- ========

UPDATE `creature` SET `spawnmask` = 0 WHERE `id` IN (22201,22221,22217,22218,22287,22289,22451,22174,22283,22385,21723);

-- ========
-- Creature Phase IN
-- ========

UPDATE `creature` SET `spawnmask` = 1 WHERE `id` IN (18528,22861,22862,22863,22864,12270,12271,24937,22987,22982,23016,23415,23257,22967,22966,23473,23115,22919,22980,23363,22941,23383,23219);
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` IN (84715,79011,79033,8313,2126,2115,12235,12234,12177,12236,96669,79015,79031,79030,79013,79014,44255,44257,44254,48166,86834,44256,91786,91785,91781,91789,91792,91780,91784,91782,91783,91788,91787,91790,91791,91793,75891,75892);
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` BETWEEN 150621 AND 150640;
UPDATE `creature` SET `id` = '23029' WHERE `id` = 21844;

-- Wrath Fiend 22392
UPDATE `creature` SET `id` = 22291 WHERE `guid` IN (78717,78718,78719);
-- Wrath Fiend 22286
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (78325,78326,78327,78328,78329,78330,78331,78332,78333);
-- Bladespine Basilisk 22187
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (77814,77815,77816,77817,77818,77819,77820);
-- Nightmare Imp 22202
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (77855,77856,77857,77858,77859,77860,77861,77862,77863,77864,77865,77866);
-- Terror-Fire Guardian 22327
UPDATE `creature` SET `id` = 22204 WHERE `guid` IN (78559,78560,78561,78562,78563,78564);
-- Terrordar the Tormentor 22385
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` = 78694;
-- Spire Needler 22194
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (77821,77822,77823,77824,77825,77826,77827,77828,77829,77830,77831,77832,77833,77834,77835,77836,77837,77838,77839,77840,77841,77842,77843,77844,77845);
-- Deathlash Stinger 22257 -> Aether Ray
DELETE FROM `creature` WHERE `guid` IN (78216,78217,78218,78219,78220,78221,78223,78224,78225,78226,78227,78228,78229,78230,78231,78232,78233,78234,78235,78236,78237,78238,78239,78240,78241,78242,78243,78244,78245,78246,78247,78248,78249,78250,78251,78252,78253,78254,78255,78256,78257,78258,78259,78260,78261);
INSERT INTO `creature` VALUES (78216, 22181, 530, 1, 0, 0, 2706.82, 7151.3, 364.832, 4.39658, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78217, 22181, 530, 1, 0, 0, 2778.18, 7217.4, 365.399, 2.17515, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78218, 22181, 530, 1, 0, 0, 2650.19, 7215.58, 363.941, 4.31096, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78219, 22181, 530, 1, 0, 0, 2616.01, 7245.59, 364.671, 1.10546, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78220, 22181, 530, 1, 0, 0, 2512.59, 7275.21, 367.263, 2.72734, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78221, 22181, 530, 1, 0, 0, 2527.36, 7253.35, 364.53, 5.55499, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78223, 22181, 530, 1, 0, 0, 2504.71, 7245.27, 365.684, 0.66838, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78224, 22181, 530, 1, 0, 0, 2458.35, 7281.86, 365.359, 4.08158, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78225, 22181, 530, 1, 0, 0, 2446.84, 7359.08, 365.205, 2.49121, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78226, 22181, 530, 1, 0, 0, 2061.52, 7271.81, 363.911, 2.25509, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78227, 22181, 530, 1, 0, 0, 2099.33, 7330.34, 364.607, 2.57119, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78228, 22181, 530, 1, 0, 0, 2067.45, 7331.05, 364.735, 4.17056, 300, 0, 0, 7685, 0, 0, 0);
INSERT INTO `creature` VALUES (78229, 22181, 530, 1, 0, 0, 2159.1853, 7331.5122, 364.6892, 5.89536, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78230, 22181, 530, 1, 0, 0, 2032.96, 7259.08, 363.918, 5.56344, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78231, 22181, 530, 1, 0, 0, 2036.44, 7293.47, 363.316, 5.38637, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78232, 22181, 530, 1, 0, 0, 1843.66, 7295.39, 364.686, 3.08165, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78233, 22181, 530, 1, 0, 0, 1858.35, 7351.39, 363.794, 2.91742, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78234, 22181, 530, 1, 0, 0, 1789.23, 7122.59, 362.149, 3.0024, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78235, 22181, 530, 1, 0, 0, 1926.84, 7195.48, 364.116, 3.93496, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78236, 22181, 530, 1, 0, 0, 2121.94, 7160.59, 363.906, 6.17584, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78237, 22181, 530, 1, 0, 0, 2114.53, 7187.61, 366.179, 4.56345, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78238, 22181, 530, 1, 0, 0, 2206.19, 7122.32, 364.065, 4.78504, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78239, 22181, 530, 1, 0, 0, 2239.24, 7142.74, 366.781, 2.45333, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78240, 22181, 530, 1, 0, 0, 2224.77, 7099.38, 365.982, 1.09666, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78241, 22181, 530, 1, 0, 0, 2353.17, 7104.93, 367.007, 2.18587, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78242, 22181, 530, 1, 0, 0, 2403.47, 7083.51, 366.579, 4.23665, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78243, 22181, 530, 1, 0, 0, 2490, 7043.62, 366.056, 4.14772, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78244, 22181, 530, 1, 0, 0, 2458.42, 7049.03, 367.785, 5.5253, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78245, 22181, 530, 1, 0, 0, 2464.83, 7072.46, 364.959, 6.15883, 300, 0, 0, 7685, 0, 0, 0);
INSERT INTO `creature` VALUES (78246, 22181, 530, 1, 0, 0, 2678.12, 7120.47, 364.677, 4.06626, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78247, 22181, 530, 1, 0, 0, 3790.07, 5840.06, 261.204, 5.2408, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78248, 22181, 530, 1, 0, 0, 3815.14, 5857.78, 266.07, 2.85368, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78249, 22181, 530, 1, 0, 0, 3877.0700, 5943.6000, 270.9169, 1.46953, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78250, 22181, 530, 1, 0, 0, 3899.06, 5968.08, 268.173, 3.42963, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78251, 22181, 530, 1, 0, 0, 3827.45, 5814.51, 267.705, 4.15338, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78252, 22181, 530, 1, 0, 0, 4085.43, 5827.83, 264.129, 2.14618, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78253, 22181, 530, 1, 0, 0, 4077.67, 5856.85, 256.653, 6.22165, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78254, 22181, 530, 1, 0, 0, 4047.39, 5913.28, 263.395, 4.89851, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78255, 22181, 530, 1, 0, 0, 4041.46, 5970.79, 265.805, 6.14957, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78256, 22181, 530, 1, 0, 0, 3999.1237, 6005.3378, 268.6499, 3.2317, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78257, 22181, 530, 1, 0, 0, 3917.28, 6008.18, 267.865, 5.58632, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78258, 22181, 530, 1, 0, 0, 4006.68, 6042.7, 261.141, 5.28363, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78259, 22181, 530, 1, 0, 0, 3952.79, 6078.67, 266.482, 0.737055, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78260, 22181, 530, 1, 0, 0, 3905.1, 6107.35, 266.69, 5.08921, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78261, 22181, 530, 1, 0, 0, 3997.91, 6093.29, 260.065, 3.98226, 300, 5, 0, 7685, 0, 0, 1);

-- ========
-- Creature Change
-- ========

-- Morogrimm Positioning
UPDATE `creature` SET `position_x`='361.872009', `position_y`='-724.400024', `position_z`='-14.0032', `orientation`='3.2655',`spawndist`='0',`movementtype`='0' WHERE `guid` = 82974;

-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `mechanic_immune_mask`='1073561599' WHERE `entry` = 21863;

-- Coilfang Priestess 21220
UPDATE `creature_template` SET `mechanic_immune_mask`='0' WHERE `entry` = 21220;

-- Tidewalker Lurker - Call for Help on Aggro
DELETE FROM `creature_ai_scripts` WHERE `id` = 2192002;
-- INSERT INTO `creature_ai_scripts` VALUES ('2192002','21920','4','0','100','2','0','0','0','0','39','15','0','0','0','0','0','0','0','0','0','0','Tidewalker Lurker - Call for Help on Aggro');

-- ========
-- Quests & Access
-- ========

-- MH, BT
UPDATE `access_requirement` SET `level_min` = 70 WHERE `id` IN (29, 47);

-- MH
DELETE FROM `creature_questrelation` WHERE `quest` IN (10460,10461,10462,10463);
INSERT INTO `creature_questrelation` VALUES (19935, 10460);
INSERT INTO `creature_questrelation` VALUES (19935, 10461);
INSERT INTO `creature_questrelation` VALUES (19935, 10462);
INSERT INTO `creature_questrelation` VALUES (19935, 10463);

-- BT
DELETE FROM `creature_questrelation` WHERE `quest` IN (10947);
INSERT INTO `creature_questrelation` VALUES (21700, 10947);

-- Ogri'la
DELETE FROM `creature_questrelation` WHERE `quest` IN (10339,10969);
INSERT INTO `creature_questrelation` VALUES (20448, 10339);
INSERT INTO `creature_questrelation` VALUES (22899, 10969);

-- Netherwing
DELETE FROM `creature_questrelation` WHERE `quest` IN (11012,11013);
INSERT INTO `creature_questrelation` VALUES (22113, 11012);
INSERT INTO `creature_questrelation` VALUES (22113, 11013);

-- Druid Flight Quest
DELETE FROM `creature_questrelation` WHERE `id` = 12042 AND `quest` = 10955;
INSERT INTO `creature_questrelation` VALUES (12042, 10955);

-- ========
-- Loot
-- ========

-- Magtheridons Head
DELETE FROM `creature_loot_template` WHERE `item` IN (32385,32386);
INSERT INTO `creature_loot_template` VALUES (17257, 32386, 100, 0, 1, 1, 6, 67, 0); 
INSERT INTO `creature_loot_template` VALUES (17257, 32385, 100, 0, 1, 1, 6, 469, 0);

-- Darkmoon Cards
DELETE FROM `creature_loot_template` WHERE `item` IN (31882,31883,31884,31885,31886,31887,31888,31889,31892,31893,31894,31895,31896,31898,31899,31900,31901,31902,31903,31904,31905,31906,31908,31909,31910,31911,31912,31913,31915,31916,31917,31918);
INSERT INTO `creature_loot_template` VALUES (18708, 31882, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16808, 31882, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16808, 31892, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16808, 31901, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20597, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20597, 31882, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20597, 31892, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20597, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20633, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20633, 31882, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20633, 31892, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17798, 31901, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17798, 31892, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17798, 31882, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20633, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17798, 31910, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18708, 31910, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19894, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19894, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19894, 31892, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19894, 31882, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19220, 31882, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21582, 31882, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17977, 31892, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17977, 31901, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17977, 31882, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20737, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20737, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20737, 31892, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20737, 31882, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21582, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21582, 31892, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21582, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20706, 31882, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18473, 31892, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18473, 31882, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18473, 31901, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18708, 31901, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21537, 31882, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19220, 31910, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19220, 31901, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19220, 31892, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21537, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21537, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21537, 31892, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17977, 31910, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18473, 31910, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18708, 31892, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16808, 31910, 2, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20531, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20531, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20706, 31892, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20706, 31901, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20706, 31910, 2, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18433, 31901, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17881, 31882, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17881, 31892, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20306, 31910, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20306, 31882, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17881, 31901, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17881, 31910, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18433, 31892, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18433, 31882, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18433, 31910, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20266, 31910, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20266, 31882, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20266, 31892, 1, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23028, 31912, 0.94, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22960, 31898, 0.9, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 31915, 0.75, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23196, 31898, 0.7, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23169, 31918, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23188, 31889, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23188, 31909, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 31885, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 31888, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 31895, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 31900, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 31909, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 31913, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 31917, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31885, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31888, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31895, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31900, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31904, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31908, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31909, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31913, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 31918, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23305, 31913, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23324, 31895, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23324, 31899, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23324, 31900, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23324, 31913, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23324, 31918, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23330, 31898, 0.47, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24374, 31905, 0.387, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22076, 31900, 0.3584, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22880, 31903, 0.32, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 31911, 0.3, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21178, 31905, 0.2809, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24180, 31887, 0.272, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23008, 31895, 0.2, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20036, 31916, 0.2, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20905, 31911, 0.16, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20052, 31912, 0.15, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24059, 31916, 0.112, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22955, 31887, 0.11, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20095, 31885, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20731, 31909, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22099, 31899, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23147, 31916, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23147, 31906, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23154, 31918, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 31906, 0.091, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20049, 31905, 0.09, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19208, 31886, 0.0835422, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20905, 31916, 0.08, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20033, 31896, 0.08, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20897, 31898, 0.07, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20909, 31915, 0.07, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20031, 31902, 0.07, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20909, 31906, 0.07, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20036, 31886, 0.07, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20032, 31905, 0.07, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24180, 31906, 0.068, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23581, 31898, 0.063, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23581, 31883, 0.063, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23580, 31893, 0.061, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23580, 31883, 0.061, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18323, 31912, 0.06, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20883, 31887, 0.06, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21702, 31911, 0.06, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21702, 31893, 0.06, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20902, 31902, 0.06, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22204, 31889, 0.0591, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23542, 31887, 0.058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23542, 31896, 0.058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23542, 31912, 0.058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23542, 31903, 0.058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23542, 31884, 0.058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24059, 31894, 0.056, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24059, 31883, 0.056, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20854, 31889, 0.0547, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22343, 31904, 0.0519, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22343, 31918, 0.0519, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22955, 31884, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22955, 31916, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22939, 31896, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22939, 31906, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20043, 31884, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20048, 31884, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20048, 31906, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20048, 31898, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20052, 31911, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20052, 31884, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20044, 31903, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20044, 31916, 0.05, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23596, 31898, 0.049, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23596, 31886, 0.049, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23596, 31911, 0.049, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24065, 31887, 0.049, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24065, 31896, 0.049, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24179, 31916, 0.047, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 31916, 0.045, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 31887, 0.045, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 31896, 0.045, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 31915, 0.045, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 31912, 0.045, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 31902, 0.045, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21711, 31918, 0.0437, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16952, 31885, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19231, 31896, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19943, 31895, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19943, 31900, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19943, 31908, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19945, 31909, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19957, 31889, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19957, 31913, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19978, 31888, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19978, 31899, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19978, 31904, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19985, 31917, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19986, 31917, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19989, 31908, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19992, 31899, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19992, 31918, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19996, 31908, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20211, 31900, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20334, 31888, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20730, 31909, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21046, 31900, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21046, 31909, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21189, 31904, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21300, 31885, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21300, 31889, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21382, 31888, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21383, 31913, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21492, 31888, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22195, 31904, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22195, 31918, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22204, 31900, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22204, 31908, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22204, 31913, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22204, 31917, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22241, 31913, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22241, 31917, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22242, 31885, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 31913, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22254, 31885, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22254, 31889, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22254, 31909, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22254, 31913, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22291, 31888, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22291, 31889, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22291, 31913, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22291, 31917, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22291, 31918, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20031, 31903, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20031, 31883, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20031, 31912, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20901, 31911, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20902, 31887, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19507, 31896, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19508, 31912, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16481, 31911, 0.0367, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20211, 31904, 0.0355, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16482, 31915, 0.0351, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16460, 31884, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16460, 31887, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19712, 31915, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20897, 31902, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20875, 31893, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20875, 31905, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20873, 31896, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19633, 31894, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18420, 31887, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20730, 31889, 0.0274, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21057, 31904, 0.0273, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23597, 31896, 0.026, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23597, 31915, 0.026, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23597, 31886, 0.026, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23597, 31884, 0.026, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23597, 31893, 0.026, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23597, 31883, 0.026, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23311, 31918, 0.023, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18559, 31887, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19712, 31884, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20879, 31886, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20897, 31884, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20883, 31896, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19507, 31911, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19712, 31903, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19712, 31896, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19713, 31905, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18558, 31911, 0.02, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21650, 31918, 0.0197, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19657, 31913, 0.0195, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16545, 31916, 0.0194, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22342, 31899, 0.0192, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22342, 31913, 0.0192, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22242, 31908, 0.0189, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22242, 31917, 0.0189, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16540, 31883, 0.0178, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16540, 31893, 0.0178, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19389, 31905, 0.0178, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19389, 31906, 0.0178, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16482, 31906, 0.0175, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 31889, 0.0158, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 31918, 0.0158, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21650, 31917, 0.0132, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18641, 31899, 0.0123353, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20334, 31917, 0.0123, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21911, 31888, 0.0122, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22241, 31889, 0.0109, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22241, 31895, 0.0109, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22195, 31913, 0.0104, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21492, 31885, 0.0102, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19712, 31883, 0.01, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19712, 31887, 0.01, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19713, 31884, 0.01, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22242, 31889, 0.0094, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21189, 31889, 0.0083, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21189, 31899, 0.0083, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21505, 31904, 0.0082, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21911, 31909, 0.0081, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 31885, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 31899, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 31900, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 31904, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21644, 31889, 0.00702134, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19994, 31917, 0.0069, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21650, 31885, 0.0066, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21650, 31888, 0.0066, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21650, 31899, 0.0066, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21650, 31908, 0.0066, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21477, 31885, 0.0065, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21649, 31885, 0.0064, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21649, 31904, 0.0064, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21649, 31917, 0.0064, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20458, 31900, 0.0062, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22018, 31899, 0.0062, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19986, 31888, 0.0061, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19991, 31909, 0.006, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19806, 31899, 0.0057, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18352, 31889, 0.0056, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19988, 31885, 0.0056, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20934, 31899, 0.0054, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21453, 31895, 0.0041, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21911, 31885, 0.0041, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21911, 31895, 0.0041, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21911, 31913, 0.0041, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18857, 31889, 0.0034, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18857, 31900, 0.0034, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22252, 31885, 0.0017, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (12380, 31885, 0.0015, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18207, 31917, 0.0007, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20657, 31910, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20657, 31882, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20657, 31892, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20657, 31901, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18607, 31892, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18607, 31882, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18607, 31901, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18607, 31910, 0, 4, 1, 1, 0, 0, 0);

DELETE FROM `reference_loot_template` WHERE `entry` = 50028;
INSERT INTO `reference_loot_template` VALUES (50028, 31883, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31884, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31886, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31887, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31893, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31894, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31896, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31898, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31902, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31903, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31905, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31906, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31911, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31912, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31915, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 31916, 0, 1, 1, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `mincountOrRef` = -50028;
INSERT INTO `creature_loot_template` VALUES (11980, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (15551, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16389, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16406, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16407, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16408, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16410, 50028, 0.024, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16411, 50028, 0.087, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16412, 50028, 0.079, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16414, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16415, 50028, 0.013, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16424, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16425, 50028, 0.015, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16459, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16460, 50028, 0.021, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16461, 50028, 0.044, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16468, 50028, 0.014, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16470, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16471, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16472, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16473, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16481, 50028, 0.019, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16482, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16507, 50028, 0.013, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16523, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16539, 50028, 0.035, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16540, 50028, 0.02, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16544, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16545, 50028, 0.022, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16593, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16594, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16699, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16700, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (16704, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17083, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17259, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17264, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17269, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17270, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17271, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17281, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17309, 50028, 0.006, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17370, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17371, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17395, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17397, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17398, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17400, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17414, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17420, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17427, 50028, 0.014, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17429, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17455, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17461, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17464, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17465, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17478, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17491, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17517, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17624, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17626, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17670, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17671, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17694, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17695, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17728, 50028, 0.005, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17729, 50028, 0.005, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17730, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17771, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17799, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17814, 50028, 0.021, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17815, 50028, 0.038, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17819, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17820, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17833, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17839, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17860, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17895, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17898, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17899, 50028, 0.014, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17905, 50028, 0.023, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17962, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17963, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17964, 50028, 0.005, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17993, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (17994, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18092, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18093, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18094, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18170, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18171, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18172, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18182, 50028, 0.013, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18309, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18311, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18312, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18313, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18314, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18315, 50028, 0.006, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18317, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18318, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18319, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18320, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18321, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18322, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18323, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18325, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18326, 50028, 0.013, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18327, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18328, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18331, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18404, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18411, 50028, 0.041, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18419, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18420, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18421, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18422, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18423, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18440, 50028, 0.019, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18493, 50028, 0.003, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18495, 50028, 0.002, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18497, 50028, 0.005, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18498, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18499, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18500, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18501, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18503, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18521, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18524, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18535, 50028, 0.029, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18536, 50028, 0.032, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18556, 50028, 0.025, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18558, 50028, 0.014, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18559, 50028, 0.013, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18567, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18585, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18588, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18631, 50028, 0.005, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18632, 50028, 0.006, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18633, 50028, 0.005, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18634, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18635, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18636, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18637, 50028, 0.006, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18638, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18639, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18640, 50028, 0.008, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18702, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18794, 50028, 0.005, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18796, 50028, 0.015, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18830, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18848, 50028, 0.019, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18894, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (18934, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19167, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19168, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19201, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19208, 50028, 0.025, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19209, 50028, 0.034, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19231, 50028, 0.093, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19299, 50028, 0.543, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19307, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19389, 50028, 0.015, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19486, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19505, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19507, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19508, 50028, 0.014, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19509, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19510, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19511, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19512, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19633, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19712, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19713, 50028, 0.015, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19747, 50028, 0.062, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19843, 50028, 0.032, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19847, 50028, 0.048, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20031, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20032, 50028, 0.027, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20033, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20034, 50028, 0.026, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20035, 50028, 0.03, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20036, 50028, 0.03, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20037, 50028, 0.062, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20042, 50028, 0.03, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20043, 50028, 0.023, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20044, 50028, 0.022, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20046, 50028, 0.157, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20048, 50028, 0.024, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20049, 50028, 0.031, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20050, 50028, 0.043, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20052, 50028, 0.058, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20059, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20132, 50028, 0.064, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20138, 50028, 0.082, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20454, 50028, 0.076, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20483, 50028, 0.023, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20600, 50028, 0.063, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20628, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20723, 50028, 0.032, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20757, 50028, 0.072, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20857, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20859, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20873, 50028, 0.047, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20875, 50028, 0.037, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20880, 50028, 0.036, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20881, 50028, 0.035, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20882, 50028, 0.034, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20883, 50028, 0.06, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20896, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20897, 50028, 0.019, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20901, 50028, 0.038, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20902, 50028, 0.043, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20905, 50028, 0.185, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20908, 50028, 0.048, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20909, 50028, 0.048, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20910, 50028, 0.037, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20911, 50028, 0.059, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20988, 50028, 0.006, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20990, 50028, 0.004, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21104, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21164, 50028, 0.049, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21168, 50028, 0.112, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21171, 50028, 0.091, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21178, 50028, 0.102, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21205, 50028, 0.434, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21229, 50028, 0.021, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21230, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21231, 50028, 0.036, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21232, 50028, 0.027, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21263, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21315, 50028, 0.024, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21350, 50028, 0.037, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21500, 50028, 0.04, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21506, 50028, 0.443, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21546, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21547, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21548, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21549, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21563, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21564, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21565, 50028, 0.032, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21570, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21571, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21572, 50028, 0.009, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21573, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21574, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21575, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21576, 50028, 0.014, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21577, 50028, 0.007, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21702, 50028, 0.021, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21838, 50028, 0.026, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22072, 50028, 0.026, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22199, 50028, 0.047, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22393, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22853, 50028, 0.025, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22855, 50028, 0.063, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22869, 50028, 0.029, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22879, 50028, 0.02, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22880, 50028, 0.021, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22882, 50028, 0.033, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22939, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22945, 50028, 0.023, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22953, 50028, 0.069, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22954, 50028, 0.036, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22955, 50028, 0.017, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22956, 50028, 0.029, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22957, 50028, 0.051, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22959, 50028, 0.061, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22960, 50028, 0.038, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22963, 50028, 0.041, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22964, 50028, 0.03, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22965, 50028, 0.061, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23018, 50028, 0.027, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23022, 50028, 0.04, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23028, 50028, 0.049, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23030, 50028, 0.04, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23047, 50028, 0.032, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23049, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23147, 50028, 0.028, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23161, 50028, 0.016, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23172, 50028, 0.03, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23196, 50028, 0.028, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23222, 50028, 0.057, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23223, 50028, 0.021, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23235, 50028, 0.029, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23236, 50028, 0.025, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23237, 50028, 0.022, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23239, 50028, 0.061, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23330, 50028, 0.022, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23337, 50028, 0.018, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23339, 50028, 0.029, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23397, 50028, 0.045, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23400, 50028, 0.108, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23402, 50028, 0.034, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23403, 50028, 0.053, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23542, 50028, 0.022, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23580, 50028, 0.026, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23581, 50028, 0.03, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23582, 50028, 0.032, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23586, 50028, 0.032, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23596, 50028, 0.024, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23597, 50028, 0.022, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23774, 50028, 0.031, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24059, 50028, 0.024, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24065, 50028, 0.024, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24179, 50028, 0.026, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24180, 50028, 0.036, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24374, 50028, 0.03, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24549, 50028, 0.041, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24684, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24686, 50028, 0.012, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24689, 50028, 0.011, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24696, 50028, 0.01, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24698, 50028, 0.019, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (24762, 50028, 0.035, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (25593, 50028, 0.1, 1, -50028, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `mincountOrRef` = -43000;
INSERT INTO `creature_loot_template` VALUES (20184, 43000, 0.5, 0, -43000, 1, 0, 0, 0);

DELETE FROM `reference_loot_template` WHERE `entry` = 43000;
INSERT INTO `reference_loot_template` VALUES (43000, 31882, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (43000, 31892, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (43000, 31901, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (43000, 31910, 0, 1, 1, 1, 0, 0, 0);

-- Time-Lost Scroll
DELETE FROM `creature_loot_template` WHERE `item` = 32620;
INSERT INTO `creature_loot_template` VALUES (21651, 32620, 45, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21763, 32620, 45, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21787, 32620, 45, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21804, 32620, 5, 0, 1, 1, 0, 0, 0);

-- Shadow Dust
DELETE FROM `creature_loot_template` WHERE `item` = 32388;
INSERT INTO `creature_loot_template` VALUES (21644, 32388, 33, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21649, 32388, 33, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21650, 32388, 33, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21804, 32388, 5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (21911, 32388, 33, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23066, 32388, 33, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23067, 32388, 33, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23068, 32388, 33, 0, 1, 1, 0, 0, 0);

-- Verdant Sphere
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` = 32405;

-- Netherwing Eggs Creature Loot
DELETE FROM `creature_loot_template` WHERE `item` = 32506;
INSERT INTO `creature_loot_template` VALUES (23169, 32506, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23264, 32506, 1.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23285, 32506, 0.9, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23286, 32506, 1.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23290, 32506, 1.2, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23305, 32506, 1.3, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23324, 32506, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23326, 32506, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23501, 32506, 0.9, 0, 1, 1, 0, 0, 0);

-- (Re)Activate Mark of the Illidari
UPDATE `creature_loot_template` SET `mincountOrRef` = 1, `maxcount` = 1 WHERE `item` = 32897;

-- (Re)Activate Trash Patterns
-- <~1% fist entry 0,984
UPDATE `creature_loot_template` SET `mincountOrRef` = 1,`maxcount` = 1 WHERE `item` IN (30321,30322,30323,30324,30280,30281,30282,30283,30301,30302,30303,30304,30305,30306,30307,30308); -- 1 1

-- (Re)Activate Boss Pattern
UPDATE `reference_loot_template` SET `mincountOrRef` = 1, `maxcount` = 1 WHERE `entry` = 34052; -- 1 1

-- (Re)Activate 32902,32905 Bottled Nethergon Energy / Bottled Nethergon Vapor
UPDATE `creature_loot_template` SET `mincountOrRef` = 1, `maxcount` = 3 WHERE `item` IN (32902,32905); -- 1 3

-- (Re)Activate Coilfang Armaments in SSC
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21863 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21339 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21301 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21299 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21298 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 16 WHERE `entry` = 21263 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21251 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21232 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21231 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 16 WHERE `entry` = 21230 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 16 WHERE `entry` = 21229 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21228 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21227 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21226 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21225 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21224 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21221 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21220 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 12 WHERE `entry` = 21218 AND `item` = 24368; -- 12

-- High King Maulgar 18831
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 18831 AND `item` = 34050;

-- Gruul the Dragonkiller 19044
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 19044 AND `item` = 190039;

-- Magtheridon 17257
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 17257 AND `item` = 34039;

-- Void Reaver 19516
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 19516 AND `item` = 34054;

-- Leotheras the Blind 21215
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 21215 AND `item` = 34059;

-- Fathom-Lord Karathress 21214
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 21214 AND `item` = 34060;

-- Lady Vashj 21212
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 21212 AND `item` = 50031;

-- Kael'thas Sunstrider 19622
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 19622 AND `item` = 50032;

-- Apexis Shard
DELETE FROM `creature_loot_template` WHERE `item` = 32569;
INSERT INTO `creature_loot_template` VALUES (18692, 32569, 100, 2, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (19973, 32569, 73, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (20557, 32569, 8.3465, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22175, 32569, 33.1139, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22180, 32569, 25, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22181, 32569, 31.0921, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22182, 32569, 22.768, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22195, 32569, 26, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22204, 32569, 25, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22241, 32569, 27, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22242, 32569, 25, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22243, 32569, 28, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22244, 32569, 14, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22254, 32569, 25, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22291, 32569, 27, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22298, 32569, 13, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22304, 32569, 98.2, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32569, 92, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23153, 32569, 97.2, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23154, 32569, 97.2, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23174, 32569, 98.7, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32569, 92, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32569, 93, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32569, 93, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23386, 32569, 30, 0, 1, 1, 0, 0, 0);

-- Depleted Items
DELETE FROM `creature_loot_template` WHERE `item` IN (32672,32677,32676,32576,32673,32671,32675,32678,32679,32674,32670);
INSERT INTO `creature_loot_template` VALUES (22275, 32670, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32672, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32673, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32674, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32675, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32676, 1.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32677, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32670, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32673, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32674, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32675, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32676, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32677, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32678, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32670, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32672, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32674, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32675, 1.2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32676, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32677, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32678, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32679, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32670, 6.5, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32671, 12.9, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32672, 4.4, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32673, 15, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32674, 4.4, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32675, 10.7, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32676, 3, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32677, 6.5, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32678, 15, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32679, 8.6, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32670, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32671, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32673, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32674, 0.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32675, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32676, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32677, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32678, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32679, 4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32670, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32672, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32673, 1.1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32674, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32675, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32676, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32677, 1.1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32678, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32679, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32670, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32673, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32674, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32675, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32676, 1.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32677, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32679, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32670, 6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32672, 6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32673, 0.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32674, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32675, 0.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32676, 5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32677, 0.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32679, 0.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32670, 6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32672, 0.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32674, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32676, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32677, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32678, 0.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32670, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32672, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32673, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32674, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32675, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32676, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32677, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32670, 1.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32674, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32675, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32676, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32677, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32670, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32671, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32672, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32673, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32674, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32675, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32676, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32677, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32678, 11, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32679, 0.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32670, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32674, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32675, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32676, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32677, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32679, 2, 3, 1, 1, 0, 0, 0);

-- Drop Motes of Shadow/Fire
UPDATE `creature_loot_template` SET `item` = 22574 WHERE `item` = 22577 AND `entry` = 22323;

-- Gem Patterns (Design: Rigid Star of Elune, Design: Shifting Nightseye, Design: Glinting Nightseye, Design: Veiled Nightseye, Design: Deadly Noble Topaz
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

-- Design: Thundering Skyfire Diamond
DELETE FROM `reference_loot_template` WHERE `item` = 32411;
INSERT INTO `reference_loot_template` VALUES (24093, 32411, 0, 1, 1, 1, 0, 0, 0);

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
UPDATE `gameobject` SET `spawnmask` = 1 WHERE `id` IN (185877, 185915, 185881);

-- Ethereum Prison
UPDATE `gameobject` SET `spawnmask` = 1 WHERE `id` IN (184418,184419,184420,184421,184422,184423,184424,184425,184426,184427,184428,184429,184430,184431,184998,185460,185464,185466,185512,185461); 

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
-- 2.1
INSERT INTO `npc_vendor` VALUES (18525, 23572, 0, 0, 1909);
INSERT INTO `npc_vendor` VALUES (18525, 32083, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32084, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32085, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32086, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32087, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32088, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32089, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32090, 0, 0, 1040);

-- Recipe: Earthen Elixir
DELETE FROM `npc_vendor` WHERE `entry` = 17904 AND `item` = 32070;
INSERT INTO `npc_vendor` VALUES (17904, 32070, 0, 0, 0);

-- Recipe: Elixir of Ironskin
DELETE FROM `npc_vendor` WHERE `item` = 32071;
INSERT INTO `npc_vendor` VALUES (18821, 32071, 0, 0, 1765);
INSERT INTO `npc_vendor` VALUES (18822, 32071, 0, 0, 1765);

-- Elixir of Major Fortitude
DELETE FROM `npc_trainer` WHERE `spell` = 39636;
INSERT INTO `npc_trainer` VALUES (16588, 39636, 25000, 171, 310, 0);
INSERT INTO `npc_trainer` VALUES (18802, 39636, 25000, 171, 310, 0);
INSERT INTO `npc_trainer` VALUES (19052, 39636, 25000, 171, 310, 0);

-- Elixir of Draenic Wisdom
DELETE FROM `npc_trainer` WHERE `spell` = 39638;
INSERT INTO `npc_trainer` VALUES (16588, 39638, 30000, 171, 320, 0);
INSERT INTO `npc_trainer` VALUES (18802, 39638, 30000, 171, 320, 0);
INSERT INTO `npc_trainer` VALUES (19052, 39638, 30000, 171, 320, 0);

-- Cauldron of *
DELETE FROM `skill_discovery_template` WHERE `spellId` BETWEEN 41458 AND 41503;
INSERT INTO `skill_discovery_template` VALUES (41458, 28575, 30);
INSERT INTO `skill_discovery_template` VALUES (41500, 28571, 30);
INSERT INTO `skill_discovery_template` VALUES (41501, 28572, 30);
INSERT INTO `skill_discovery_template` VALUES (41502, 28573, 30);
INSERT INTO `skill_discovery_template` VALUES (41503, 28576, 30);

-- Formula: Enchant Weapon - Major Striking
DELETE FROM `npc_vendor` WHERE `item` = 22552;
INSERT INTO `npc_vendor` VALUES (20242, 22552, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (23007, 22552, 0, 0, 0);

-- Schematic: Fused Wiring
DELETE FROM `npc_vendor` WHERE `item` = 32381;
INSERT INTO `npc_vendor` VALUES (11185, 32381, 1, 10800, 0);
INSERT INTO `npc_vendor` VALUES (19661, 32381, 1, 600, 0);

-- Several new recipes
DELETE FROM `npc_trainer` WHERE `spell` IN (41414,41415,41418,41420,41429,40514);
INSERT INTO `npc_trainer` VALUES (18751, 40514, 30000, 755, 340, 0);
INSERT INTO `npc_trainer` VALUES (18751, 41418, 30000, 755, 365, 0);
INSERT INTO `npc_trainer` VALUES (18751, 41414, 10000, 755, 325, 0);
INSERT INTO `npc_trainer` VALUES (18751, 41415, 10000, 755, 330, 0);
INSERT INTO `npc_trainer` VALUES (18774, 40514, 30000, 755, 340, 0);
INSERT INTO `npc_trainer` VALUES (18774, 41418, 30000, 755, 365, 0);
INSERT INTO `npc_trainer` VALUES (18774, 41414, 10000, 755, 325, 0);
INSERT INTO `npc_trainer` VALUES (18774, 41415, 10000, 755, 330, 0);
INSERT INTO `npc_trainer` VALUES (19063, 40514, 30000, 755, 340, 0);
INSERT INTO `npc_trainer` VALUES (19063, 41418, 30000, 755, 365, 0);
INSERT INTO `npc_trainer` VALUES (19063, 41414, 10000, 755, 325, 0);
INSERT INTO `npc_trainer` VALUES (19063, 41415, 10000, 755, 330, 0);
INSERT INTO `npc_trainer` VALUES (19539, 40514, 30000, 755, 340, 0);
INSERT INTO `npc_trainer` VALUES (19539, 41418, 30000, 755, 365, 0);
INSERT INTO `npc_trainer` VALUES (19539, 41415, 10000, 755, 330, 0);
INSERT INTO `npc_trainer` VALUES (19539, 41414, 10000, 755, 325, 0);
INSERT INTO `npc_trainer` VALUES (18751, 41429, 10000, 755, 350, 0);
INSERT INTO `npc_trainer` VALUES (18774, 41429, 10000, 755, 350, 0);
INSERT INTO `npc_trainer` VALUES (19063, 41429, 10000, 755, 350, 0);
INSERT INTO `npc_trainer` VALUES (19539, 41429, 10000, 755, 350, 0);
INSERT INTO `npc_trainer` VALUES (19539, 41420, 8500, 755, 325, 0);
INSERT INTO `npc_trainer` VALUES (18774, 41420, 8500, 755, 325, 0);

-- Frost Grenade
DELETE FROM `npc_trainer` WHERE `spell` = 39973;
INSERT INTO `npc_trainer` VALUES (17634, 39973, 55000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (17637, 39973, 55000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (18752, 39973, 55000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (18775, 39973, 55000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (19576, 39973, 55000, 202, 335, 0);

-- Icy Blasting Primers
DELETE FROM `npc_trainer` WHERE `spell` = 39971;
INSERT INTO `npc_trainer` VALUES (17634, 39971, 20000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (17637, 39971, 20000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (18752, 39971, 20000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (18775, 39971, 20000, 202, 335, 0);
INSERT INTO `npc_trainer` VALUES (19576, 39971, 20000, 202, 335, 0);

-- Design: Relentless Earthstorm Diamond
DELETE FROM `npc_vendor` WHERE `item` IN (33622,32412);
INSERT INTO `npc_vendor` VALUES (20242, 32412, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (23007, 32412, 0, 0, 0);

-- Engineering Goggles
DELETE FROM `npc_trainer` WHERE `spell` IN (40274,41311,41312,41314,41315,41316,41317,41318,41319,41320,41321);
INSERT INTO `npc_trainer` VALUES (18775, 40274, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 40274, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 40274, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 40274, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 40274, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41311, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41311, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41311, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41311, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41311, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41312, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41312, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41312, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41312, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41312, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41314, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41314, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41314, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41314, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41314, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41315, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41315, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41315, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41315, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41315, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41316, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41316, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41316, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41316, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41316, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41317, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41317, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41317, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41317, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41317, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41318, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41318, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41318, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41318, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41318, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41319, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41319, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41319, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41319, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41319, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41320, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41320, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41320, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41320, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41320, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41321, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41321, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (17637, 41321, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41321, 50000, 202, 350, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41321, 50000, 202, 350, 0);

-- Gyro-balanced Khorium Destroyer 
DELETE FROM `npc_trainer` WHERE `spell` = 41307;
INSERT INTO `npc_trainer` VALUES (17637, 41307, 50000, 202, 375, 0);
INSERT INTO `npc_trainer` VALUES (18775, 41307, 50000, 202, 375, 0);
INSERT INTO `npc_trainer` VALUES (17634, 41307, 50000, 202, 375, 0);
INSERT INTO `npc_trainer` VALUES (19576, 41307, 50000, 202, 375, 0);
INSERT INTO `npc_trainer` VALUES (18752, 41307, 50000, 202, 375, 0);

-- Purified Shadow Pearl
DELETE FROM `npc_trainer` WHERE `spell` = 41429;
INSERT INTO `npc_trainer` VALUES
(18751,41429,10000,755,350,0),
(18774,41429,10000,755,350,0),
(19063,41429,10000,755,350,0),
(19539,41429,10000,755,350,0);

-- ========
-- Reputation
-- ========

-- Skyguard Rep
DELETE FROM `creature_onkill_reputation` WHERE `RewonKillRepFaction1` = 1031;
INSERT INTO `creature_onkill_reputation` VALUES (21644, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21649, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21650, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21651, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21652, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21763, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21787, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21804, 1031, 0, 6, 0, 5, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21838, 1031, 0, 7, 0, 500, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21911, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21912, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (21985, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23029, 1031, 0, 7, 0, 30, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23051, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23066, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23067, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23068, 1031, 0, 7, 0, 10, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23161, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23162, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23163, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23165, 1031, 0, 7, 0, 100, 0, 0, 0, 0);
INSERT INTO `creature_onkill_reputation` VALUES (23207, 1031, 0, 7, 0, 10, 0, 0, 0, 0);

-- Patch 2.1.2

-- Design: Mystic Dawnstone
DELETE FROM `npc_vendor` WHERE `item` = 24208;
INSERT INTO `npc_vendor` VALUES (21474, 24208, 1, 86400, 0);
INSERT INTO `npc_vendor` VALUES (21485, 24208, 1, 86400, 0);

-- Fisherman's Feast
-- Hot Buttered Trout
-- Stewed Trout
-- UPDATE `creature_template` SET `npcflag`=`npcflag`&~16 WHERE `entry`=19186;
UPDATE `creature_template` SET `npcflag`=`npcflag`|16 WHERE `entry` = 19186;

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
