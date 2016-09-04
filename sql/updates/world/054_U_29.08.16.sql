-- Wrath Fiend 22392 
UPDATE `creature` SET `id` = 22291 WHERE `guid` IN (78717,78718,78719); -- 22392
-- Wrath Fiend 22286 pre 2.1
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (78325,78326,78327,78328,78329,78330,78331,78332,78333); -- 1
-- Bladespine Basilisk 22187 pre 2.1
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (77814,77815,77816,77817,77818,77819,77820);
-- Nightmare Imp 22202 pre 2.1
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (77855,77856,77857,77858,77859,77860,77861,77862,77863,77864,77865,77866);
-- Terror-Fire Guardian 22327
UPDATE `creature` SET `id` = 22204 WHERE `guid` IN (78559,78560,78561,78562,78563,78564); -- 22327
-- Terrordar the Tormentor 22385 real bt release
-- UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` = 78694;
-- Spire Needler 22194 pre 2.1
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (77821,77822,77823,77824,77825,77826,77827,77828,77829,77830,77831,77832,77833,77834,77835,77836,77837,77838,77839,77840,77841,77842,77843,77844,77845);
-- Deathlash Stinger 22257 pre 2.1 -> Aether Ray
DELETE FROM `creature` WHERE `guid` IN (78216,78217,78218,78219,78220,78221,78223,78224,78225,78226,78227,78228,78229,78230,78231,78232,78233,78234,78235,78236,78237,78238,78239,78240,78241,78242,78243,78244,78245,78246,78247,78248,78249,78250,78251,78252,78253,78254,78255,78256,78257,78258,78259,78260,78261);
-- INSERT INTO `creature` VALUES (78216, 22257, 530, 1, 0, 0, 2706.82, 7151.3, 364.832, 4.39658, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78217, 22257, 530, 1, 0, 0, 2778.18, 7217.4, 365.399, 2.17515, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78218, 22257, 530, 1, 0, 0, 2650.19, 7215.58, 363.941, 4.31096, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78219, 22257, 530, 1, 0, 0, 2616.01, 7245.59, 364.671, 1.10546, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78220, 22257, 530, 1, 0, 0, 2512.59, 7275.21, 367.263, 2.72734, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78221, 22257, 530, 1, 0, 0, 2527.36, 7253.35, 364.53, 5.55499, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78223, 22257, 530, 1, 0, 0, 2504.71, 7245.27, 365.684, 0.66838, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78224, 22257, 530, 1, 0, 0, 2458.35, 7281.86, 365.359, 4.08158, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78225, 22257, 530, 1, 0, 0, 2446.84, 7359.08, 365.205, 2.49121, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78226, 22257, 530, 1, 0, 0, 2061.52, 7271.81, 363.911, 2.25509, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78227, 22257, 530, 1, 0, 0, 2099.33, 7330.34, 364.607, 2.57119, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78228, 22257, 530, 1, 0, 0, 2067.45, 7331.05, 364.735, 4.17056, 300, 0, 0, 7181, 0, 0, 0);
-- INSERT INTO `creature` VALUES (78229, 22257, 530, 1, 0, 0, 2103.11, 7353.6, 366.479, 5.89536, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78230, 22257, 530, 1, 0, 0, 2032.96, 7259.08, 363.918, 5.56344, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78231, 22257, 530, 1, 0, 0, 2036.44, 7293.47, 363.316, 5.38637, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78232, 22257, 530, 1, 0, 0, 1843.66, 7295.39, 364.686, 3.08165, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78233, 22257, 530, 1, 0, 0, 1858.35, 7351.39, 363.794, 2.91742, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78234, 22257, 530, 1, 0, 0, 1789.23, 7122.59, 362.149, 3.0024, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78235, 22257, 530, 1, 0, 0, 1926.84, 7195.48, 364.116, 3.93496, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78236, 22257, 530, 1, 0, 0, 2121.94, 7160.59, 363.906, 6.17584, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78237, 22257, 530, 1, 0, 0, 2114.53, 7187.61, 366.179, 4.56345, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78238, 22257, 530, 1, 0, 0, 2206.19, 7122.32, 364.065, 4.78504, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78239, 22257, 530, 1, 0, 0, 2239.24, 7142.74, 366.781, 2.45333, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78240, 22257, 530, 1, 0, 0, 2224.77, 7099.38, 365.982, 1.09666, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78241, 22257, 530, 1, 0, 0, 2353.17, 7104.93, 367.007, 2.18587, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78242, 22257, 530, 1, 0, 0, 2403.47, 7083.51, 366.579, 4.23665, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78243, 22257, 530, 1, 0, 0, 2490, 7043.62, 366.056, 4.14772, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78244, 22257, 530, 1, 0, 0, 2458.42, 7049.03, 367.785, 5.5253, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78245, 22257, 530, 1, 0, 0, 2464.83, 7072.46, 364.959, 6.15883, 300, 0, 0, 7181, 0, 0, 0);
-- INSERT INTO `creature` VALUES (78246, 22257, 530, 1, 0, 0, 2678.12, 7120.47, 364.677, 4.06626, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78247, 22257, 530, 1, 0, 0, 3790.07, 5840.06, 261.204, 5.2408, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78248, 22257, 530, 1, 0, 0, 3815.14, 5857.78, 266.07, 2.85368, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78249, 22257, 530, 1, 0, 0, 3877.07, 5943.6, 269.352, 1.46953, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78250, 22257, 530, 1, 0, 0, 3899.06, 5968.08, 268.173, 3.42963, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78251, 22257, 530, 1, 0, 0, 3827.45, 5814.51, 267.705, 4.15338, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78252, 22257, 530, 1, 0, 0, 4085.43, 5827.83, 264.129, 2.14618, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78253, 22257, 530, 1, 0, 0, 4077.67, 5856.85, 256.653, 6.22165, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78254, 22257, 530, 1, 0, 0, 4047.39, 5913.28, 263.395, 4.89851, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78255, 22257, 530, 1, 0, 0, 4041.46, 5970.79, 265.805, 6.14957, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78256, 22257, 530, 1, 0, 0, 4002.9, 5996.79, 264.954, 3.2317, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78257, 22257, 530, 1, 0, 0, 3917.28, 6008.18, 267.865, 5.58632, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78258, 22257, 530, 1, 0, 0, 4006.68, 6042.7, 261.141, 5.28363, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78259, 22257, 530, 1, 0, 0, 3952.79, 6078.67, 266.482, 0.737055, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78260, 22257, 530, 1, 0, 0, 3905.1, 6107.35, 266.69, 5.08921, 300, 5, 0, 7181, 0, 0, 1);
-- INSERT INTO `creature` VALUES (78261, 22257, 530, 1, 0, 0, 3997.91, 6093.29, 260.065, 3.98226, 300, 5, 0, 7181, 0, 0, 1);
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
INSERT INTO `creature` VALUES (78256, 22181, 530, 1, 0, 0, 4002.9, 5996.79, 264.954, 3.2317, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78257, 22181, 530, 1, 0, 0, 3917.28, 6008.18, 267.865, 5.58632, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78258, 22181, 530, 1, 0, 0, 4006.68, 6042.7, 261.141, 5.28363, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78259, 22181, 530, 1, 0, 0, 3952.79, 6078.67, 266.482, 0.737055, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78260, 22181, 530, 1, 0, 0, 3905.1, 6107.35, 266.69, 5.08921, 300, 5, 0, 7685, 0, 0, 1);
INSERT INTO `creature` VALUES (78261, 22181, 530, 1, 0, 0, 3997.91, 6093.29, 260.065, 3.98226, 300, 5, 0, 7685, 0, 0, 1);

UPDATE `creature_template` SET `faction_A`=35,`faction_H`=35 WHERE `entry` = 16965;
UPDATE `creature_template` SET `faction_A`=35,`faction_H`=35 WHERE `entry` = 23363;
--
-- Gordunni Soulreaper 23022
UPDATE `creature_template` SET `mindmg`='700',`maxdmg`='900',`speed`='1.48' WHERE `entry` = '23022'; -- 362 789
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23022';
INSERT INTO `creature_ai_scripts` VALUES
('2302201','23022','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Prevent Combat Movement on Spawn'),
('2302202','23022','4','0','100','0','0','0','0','0','11','15232','1','0','23','1','0','0','0','0','0','0','Gordunni Soulreaper - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('2302203','23022','9','5','100','1','0','40','4000','8000','11','15232','1','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Cast Shadow Bolt (Phase 1)'),
('2302204','23022','3','5','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Gordunni Soulreaper - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('2302205','23022','9','5','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Start Combat Movement at 35 Yards (Phase 1)'),
('2302206','23022','9','5','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Prevent Combat Movement at 15 Yards (Phase 1)'),
('2302207','23022','9','5','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Start Combat Movement Below 5 Yards'),
('2302208','23022','3','3','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Set Phase 1 when Mana is above 30% (Phase 2)'),
('2302209','23022','0','0','100','1','3000','5000','9000','18000','11','20464','0','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Summon 3 Skeletons'),
('2302210','23022','2','0','100','1','50','0','10000','11000','11','20743','1','0','0','0','0','0','0','0','0','0','Gordunni Soulreaper - Cast Drain Life at 50% HP'),
('2302211','23022','7','0','100','0','0','0','0','0','22','0','0','0','21','1','0','0','0','0','0','0','Gordunni Soulreaper - Set Phase to 0 and Start Movement on Evade');

-- Skeleton 6412 is used elsewhere too but only spellsummoned and ais should resummon
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '6412';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '6412';
INSERT INTO `creature_ai_scripts` VALUES
('641201','6412','7','0','100','0','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Skeleton - Despawn on Evade');

UPDATE `creature` SET `spawntimesecs`='180' WHERE `id` IN (22144,22143,22148);
DELETE FROM `creature` WHERE `guid` = 140806;
INSERT INTO `creature` VALUES (140806, 23022, 530, 1, 0, 0, -1531.62, 5978.53, 192.407, 2.05811, 300, 0, 0, 28720, 6462, 0, 2);
SET @GUID := 140806;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (@GUID, 1, -1520.91, 5954.39, 193.9, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 2, -1506.94, 5933.15, 194.487, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 3, -1490.97, 5921.78, 194.475, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 4, -1461.24, 5918.18, 195.003, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 5, -1433.64, 5906.33, 192.478, 5000,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 6, -1460.69, 5917.39, 194.915, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 7, -1490.75, 5924.11, 194.476, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 8, -1509.72, 5936.4, 194.489, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 9, -1521.49, 5954.73, 193.833, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (@GUID, 10, -1531.47, 5978.25, 192.398, 5000,0,0,100,0);

-- cooking quests
--
DELETE FROM `game_event_creature_quest` WHERE `quest` IN (11380,11377,11381,11379);
INSERT INTO `game_event_creature_quest` VALUES
(24393,11377,125), -- 11377
(24393,11379,127), -- 11379
(24393,11380,124), -- 11380
(24393,11381,126); -- 11381

UPDATE `creature` SET `spawnmask`=0 WHERE `id` = 18594;

-- Teronis' Corpse
UPDATE `creature` SET `curhealth`='0' WHERE `guid` IN ('84372');
UPDATE `creature_template` SET `dynamicflags`='36' WHERE `entry` =3891; -- 0

-- Phase Wyrm 24917
UPDATE `creature` SET `spawnmask`=0 WHERE `id`=24917;

UPDATE `item_template` SET `buyprice`='50000' WHERE `entry` = 30719; -- 0
UPDATE `item_template` SET `buyprice`='100000' WHERE `entry` = 30721; -- 0

-- temp 10g
UPDATE `item_template` SET `buyprice`='100000' WHERE `entry` = 31108; -- 0
UPDATE `item_template` SET `buyprice`='100000' WHERE `entry` = 31310; -- 0
UPDATE `creature_template` SET `npcflag`=`npcflag`|'128' WHERE `entry` IN (21769,21773);
DELETE FROM `npc_vendor` WHERE `entry` IN (21769,21773);
INSERT INTO `npc_vendor` VALUES
(21769,31108,0,0,0),
(21773,31310,0,0,0);

UPDATE `creature_ai_texts` SET `content_default` = 'has spotted you!', `content_loc3` = 'hat euch gesichtet!' WHERE `entry` = '-48';
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1944001','1944003');
INSERT INTO `creature_ai_scripts` VALUES
(1944001,19440,0,0,100,1,6000,6000,0,0,41,0,0,0,39,30,0,0,0,0,0,0,'Eye of Grillok - Despawn after 6 seconds and pull Mobs in 30yards Range'),
(1944003,19440,9,0,100,1,0,5,0,0,39,30,0,0,0,0,0,0,0,0,0,0,'Eye of Grillok - Add Mobs in 30yards Range when in Melee Range');
UPDATE `creature` SET `MovementType`='2',`curhealth`='305' WHERE `guid` IN (69630,69631,69632,69633);
UPDATE `creature` SET `position_x`='-1163.9326',`position_y`='1989.3409',`position_z`='73.4113',`orientation`='1' WHERE `guid` IN ('69630');
UPDATE `creature` SET `position_x`='-1129.3885',`position_y`='2111.0297',`position_z`='67.3838',`orientation`='2' WHERE `guid` IN ('69631');
UPDATE `creature` SET `position_x`='-1015.0742',`position_y`='2071.7985',`position_z`='68.1599',`orientation`='3' WHERE `guid` IN ('69632'); 
UPDATE `creature` SET `position_x`='-948.0367',`position_y`='1959.3719',`position_z`='66.9395',`orientation`='4' WHERE `guid` IN ('69633');
UPDATE `creature_template` SET `minhealth`='305',`maxhealth`='305',`MovementType`='0' WHERE `entry`='19440';
SET @NPC := 69633;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,01,-928.3358,1986.7524,66.7063,0,1,0,0,0),
(@PATH,02,-914.0970,1975.1490,66.9381,0,1,0,0,0),
(@PATH,03,-942.1527,2017.2342,66.4272,0,1,0,0,0), 
(@PATH,04,-910.6004,2030.3096,54.9803,0,1,0,0,0),
(@PATH,05,-881.2473,2062.9765,32.9544,0,1,0,0,0),
(@PATH,06,-910.6004,2030.3096,54.9803,0,1,0,0,0),
(@PATH,07,-942.1527,2017.2342,66.4272,0,1,0,0,0),
(@PATH,08,-965.8059,2015.7540,66.9382,0,1,0,0,0),
(@PATH,09,-967.2543,2043.5303,66.9383,0,1,0,0,0),
(@PATH,10,-965.8059,2015.7540,66.9382,0,1,0,0,0),
(@PATH,11,-994.0278,2018.3187,66.9398,0,1,0,0,0),
(@PATH,12,-1008.3182,1998.1336,66.9398,0,1,0,0,0),
(@PATH,13,-961.6397,1928.9605,69.7001,0,1,0,0,0);
SET @NPC := 69632;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,01,-995.2246,2050.7878,67.0786,0,1,0,0,0),
(@PATH,02,-965.1807,2015.1136,66.9396,0,1,0,0,0),
(@PATH,03,-1019.5062,2019.8485,68.5836,0,1,0,0,0),
(@PATH,04,-1049.9830,1978.5461,69.7531,0,1,0,0,0),
(@PATH,05,-1083.0324,1999.5413,67.5355,0,1,0,0,0),
(@PATH,06,-1051.1049,2035.9420,67.8373,0,1,0,0,0),
(@PATH,07,-1015.0700,2071.8000,68.1598,0,1,0,0,0);
SET @NPC := 69631;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,01,-1080.3474,2078.0305,65.0987,0,1,0,0,0), 
(@PATH,02,-1058.6500,2095.5725,60.5359,0,1,0,0,0), 
(@PATH,03,-1057.7172,2135.4677,45.9153,0,1,0,0,0),
(@PATH,04,-1051.2012,2158.9655,32.0612,0,1,0,0,0),
(@PATH,05,-1057.7172,2135.4677,45.9153,0,1,0,0,0),
(@PATH,06,-1058.6500,2095.5725,60.5359,0,1,0,0,0),
(@PATH,07,-1080.3474,2078.0305,65.0987,0,1,0,0,0),
(@PATH,08,-1119.9788,2001.8972,68.2734,0,1,0,0,0),
(@PATH,09,-1176.4782,2077.5385,70.3548,0,1,0,0,0),
(@PATH,10,-1169.5651,2108.4208,69.0777,0,1,0,0,0),
(@PATH,11,-1134.4404,2108.9665,67.2592,0,1,0,0,0);
SET @NPC := 69630;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,01,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@PATH,02,-1113.0444,2012.2253,67.1017,0,1,0,0,0),
(@PATH,03,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@PATH,04,-1145.7219,1953.0606,81.1721,0,1,0,0,0),
(@PATH,05,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@PATH,06,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@PATH,07,-1114.2845,1946.6412,74.0025,0,1,0,0,0),
(@PATH,08,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@PATH,09,-1113.0444,2012.2253,67.1017,0,1,0,0,0),
(@PATH,10,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@PATH,11,-1145.7219,1953.0606,81.1721,0,1,0,0,0),
(@PATH,12,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@PATH,13,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@PATH,14,-1179.1141,1990.8114,74.5931,0,1,0,0,0);

DELETE FROM `creature` WHERE `guid` = 16777294;
DELETE FROM `creature` WHERE `guid` IN (85687,85692,100039,100040,100041);
INSERT INTO `creature` VALUES (85687, 23076, 530, 1, 0, 0, 2946.3, 6875.71, 370.04, 3.2148, 300, 0, 0, 22140, 0, 0, 0);
INSERT INTO `creature` VALUES (85692, 23076, 530, 1, 0, 0, 3028.22, 6807.09, 374.075, 5.94641, 300, 0, 0, 22140, 0, 0, 0);
INSERT INTO `creature` VALUES (100039, 23076, 530, 1, 0, 0, 2982.59, 6886.5, 370.082, 0.831123, 300, 0, 0, 22140, 0, 0, 0);
INSERT INTO `creature` VALUES (100040, 23076, 530, 1, 0, 0, 2834.14, 7018.43, 368.459, 5.42992, 300, 0, 0, 21543, 0, 0, 0);
INSERT INTO `creature` VALUES (100041, 23076, 530, 1, 0, 0, 2994.48, 7039.91, 369.42, 5.26077, 300, 0, 0, 22140, 0, 0, 0);

-- channel trigger
UPDATE `creature` SET `movementtype`=0 WHERE `id` = 22436;

-- Legion Flak Cannon 23076
UPDATE `creature_template` SET `unit_flags`='6',`dynamicflags`='8' WHERE `entry` = '23076'; -- 4 0
UPDATE `creature_ai_scripts` SET `action2_type`='20' WHERE `id` = 2307601;
-- Bombing Run Target Bunny 23118
-- UPDATE `creature_template` SET WHERE `entry` = '23118';
UPDATE `creature_ai_scripts` SET `event_type`='1',`action1_param3`='39' WHERE `id` = 2311801;

UPDATE `creature` SET `position_x`='2836.6455', `position_y`='7024.2641', `position_z`='368.4468', `orientation`='5.7334' WHERE `guid` = 85659;
UPDATE `gameobject` SET `position_x`='2836.6455', `position_y`='7024.2641', `position_z`='368.4468', `orientation`='5.7334' WHERE `guid` IN (100213,100214); -- one useable

UPDATE `creature` SET `spawnmask`=0 WHERE `id`=22201;
UPDATE `creature` SET `position_x`='1396.8896', `position_y`='7405.3520', `position_z`='367.7672' WHERE `guid` = '71201';

-- Wrath Speaker 22195
-- UPDATE `creature_template` SET  WHERE `entry` = '22195';
UPDATE `creature` SET `id`='22196',`position_x`='2868.5900', `position_y`='6876.7529', `position_z`='364.3682', `orientation`='1.4025',`spawndist`='0',`movementtype`='0' WHERE `guid` = '77849';

UPDATE `creature` SET `position_x`='3860.7800', `position_y`='5883.7290', `position_z`='266.5476' WHERE `guid` = '78207';
UPDATE `creature` SET `position_x`='4064.6269', `position_y`='5722.4658', `position_z`='267.1163', `spawndist`='5',`movementtype`='1' WHERE `guid` = '78208';
UPDATE `creature` SET `position_x`='4006.2939', `position_y`='5537.3085', `position_z`='267.4615' WHERE `guid` = '78209';
UPDATE `creature` SET `position_x`='3986.0671', `position_y`='5234.5844', `position_z`='265.0721' WHERE `guid` = '78210';
UPDATE `creature` SET `position_x`='4014.5913', `position_y`='4993.4619', `position_z`='268.3882' WHERE `guid` = '78211';
UPDATE `creature` SET `position_x`='3940.2756', `position_y`='4873.3632', `position_z`='267.1611' WHERE `guid` = '78212';
UPDATE `creature` SET `position_x`='4094.4379', `position_y`='5227.4394', `position_z`='265.7415' WHERE `guid` = '78213';
UPDATE `creature` SET `position_x`='3882.9060', `position_y`='5410.5659', `position_z`='267.7539' WHERE `guid` = '78215';



-- Wrath Reaver 22196 inacive
UPDATE `creature_template` SET `speed`='2',`mindmg`='1000',`maxdmg`='2000',`unit_flags`='32834',`mechanic_immune_mask`='1073741823',`flags_extra`='2' WHERE `entry` IN ('22196');

UPDATE `creature` SET `position_x`='2742.7646', `position_y`='7263.2812', `position_z`='368.5848', `orientation`='1.5409',`spawndist`='5',`movementtype`='1' WHERE `guid` = '12859';
UPDATE `creature` SET `position_x`='2747.8618', `position_y`='7298.2163', `position_z`='368.5848', `orientation`='3.1510',`spawndist`='5',`movementtype`='1' WHERE `guid` = '51611';
UPDATE `creature` SET `position_x`='2709.1252', `position_y`='7303.5361', `position_z`='368.5854', `orientation`='4.6864',`spawndist`='5',`movementtype`='1' WHERE `guid` = '48038';
UPDATE `creature` SET `position_x`='2704.1682', `position_y`='7271.0244', `position_z`='368.5840', `orientation`='6.1223',`spawndist`='5',`movementtype`='1' WHERE `guid` = '28456';
UPDATE `creature` SET `position_x`='2122.2214', `position_y`='7106.7392', `position_z`='364.7709', `orientation`='3.0630',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84226';
UPDATE `creature` SET `position_x`='2084.7136', `position_y`='7102.7553', `position_z`='364.7718', `orientation`='1.5550',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84228';
UPDATE `creature` SET `position_x`='2080.6015', `position_y`='7137.5776', `position_z`='364.7713', `orientation`='0.0510',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84236';
UPDATE `creature` SET `position_x`='2117.1728', `position_y`='7141.8442', `position_z`='364.7713', `orientation`='4.6691',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84237';
UPDATE `creature` SET `position_x`='1950.2333', `position_y`='7344.6245', `position_z`='364.4700', `orientation`='3.1627',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84238'; 
UPDATE `creature` SET `position_x`='1911.2104', `position_y`='7339.8510', `position_z`='364.4711', `orientation`='1.5291',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84703';
UPDATE `creature` SET `position_x`='1907.1466', `position_y`='7375.6025', `position_z`='364.4706', `orientation`='6.1394',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84704';
UPDATE `creature` SET `position_x`='1946.1286', `position_y`='7378.9438', `position_z`='364.4708', `orientation`='4.8160',`spawndist`='5',`movementtype`='1' WHERE `guid` = '84706';
UPDATE `creature` SET `spawndist`='5',`movementtype`='1' WHERE `guid` IN (51613,51612,51614,51615,55133,82671,53047,53046,53047,84232,84233,84705,84702);

-- Adyen the Lightwarden 18537 / Ishanah 18538
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'2' WHERE `entry` IN (18537,18538);

-- make them clickable without using quest item -4
UPDATE `gameobject_template` SET `flags`='32' WHERE `entry` IN ('184289','184290','184414','184415');

-- Sunfury Conjurer
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('2013901','2013906');
UPDATE `creature_ai_scripts` SET `action1_param3`='0' WHERE `id` IN ('2013909');
UPDATE `creature_ai_scripts` SET `event_param3`='20000',`action1_param3`='32' WHERE `id` IN ('2013910');
UPDATE `creature_ai_scripts` SET `event_param4`='4500' WHERE `id` IN ('2013903');

-- Zarcsin 23355
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='1284',`maxdmg`='1524',`AIName`='EventAI',`mechanic_immune_mask`='619396095',`equipment_id`='1548' WHERE `entry` = '23355';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23355';
INSERT INTO `creature_ai_scripts` VALUES
(2335501,23355,4,0,100,7,0,0,0,0,11,29651,0,7,1,-9901,0,0,0,0,0,0,'Zarcsin  - Cast Dual Wield on Aggro'),
(2335502,23355,2,0,100,0,50,0,0,0,11,41447,0,7,1,-106,0,0,0,0,0,0,'Zarcsin - Casts Enrage at 50% HP'),
(2335503,23355,0,0,100,1,5000,6000,12000,13000,11,41444,0,0,0,0,0,0,0,0,0,0,'Zarcsin - Casts Fel Flames');
-- 
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9910','-9909','-9908','-9907','-9906','-9905','-9904','-9903','-9902','-9901','-9900');
INSERT INTO `creature_ai_texts` VALUES
('-9910','Me angered. Raaah!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','Schergrat Ogres on Aggro'),
('-9909','Me smash! You die!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','Schergrat Ogres on Aggro'),
('-9908','Now, proceed to the translocator. Forge Camp Wrath awaits your arrival!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','19747 OCC Summon Event'),
('-9907','You will suffer slowly until the end of time for this affront!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 Yell on Aggro'),
('-9906','Prepare yourself for eternal torture, mortal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 Yell on Aggro'),
('-9905','I shall enjoy the smell of the grease from your marrow crackling over the fire!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 Yell on Aggro'),
('-9904','Release the hounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 IC Summon Event'),
('-9903','Your name is as insignificant to me as the names of the thousands who have died under the might of Goc. I will crush you and $N!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','20555 on Aggro'),
('-9902','Me mad. You get smash in face!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','19948 on Aggro'),
('-9901','','As I shall consume your flesh, so too shall the Burning Legion consume your people!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','23355 Yell on Aggro'),
('-9900',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','SCHERGRATCOMMENT');

UPDATE `creature` SET `position_x`='2548.5935', `position_y`='7331.4287', `position_z`='373.4237', `orientation`='4.2454',`spawndist`='0',`movementtype`='0' WHERE `guid` = '44255';
DELETE FROM `creature_addon` WHERE `guid` = 44255;
INSERT INTO `creature_addon` VALUES (44255,0,21152,0,0,4097,0,0,'');

DELETE FROM `creature_loot_template` WHERE `entry` IN (22281,23353,23354,23355,22275);
-- Galvanoth 22281
INSERT INTO `creature_loot_template` VALUES (22281, 21877, 26.506, 0, 4, 5, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 27854, 3.6145, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22281, 27860, 9.6386, 0, 1, 1, 0, 0, 0);
-- Apexis Crystal
INSERT INTO `creature_loot_template` VALUES (22281, 32572, 0, 2, 1, 1, 0, 0, 0); -- 62.6506 0
-- Depleted Items
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
-- Fel Whip
INSERT INTO `creature_loot_template` VALUES (22281, 32733, -100, 0, 1, 1, 0, 0, 0);
--
-- Braxxus 23353
INSERT INTO `creature_loot_template` VALUES (23353, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 25418, 33.9, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 25421, 8, 0, 2, 4, 0, 0, 0);
-- Apexis Crystal
INSERT INTO `creature_loot_template` VALUES (23353, 32572, 0, 2, 1, 1, 0, 0, 0); -- 77.3 0
-- Depleted Items
INSERT INTO `creature_loot_template` VALUES (23353, 32670, 6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32672, 0.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32674, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32676, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32677, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32678, 0.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23353, 32679, 2, 3, 1, 1, 0, 0, 0);
-- Fel Whip
INSERT INTO `creature_loot_template` VALUES (23353, 32733, -100, 0, 1, 1, 0, 0, 0);
--
-- Mo'arg Incinerator 23354
INSERT INTO `creature_loot_template` VALUES (23354, 21877, 21.1, 0, 4, 6, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 27854, 1.7, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23354, 27860, 1, 0, 1, 1, 0, 0, 0);
-- Apexis Crystal
INSERT INTO `creature_loot_template` VALUES (23354, 32572, 0, 2, 1, 1, 0, 0, 0); -- 80.5 0
-- Depleted Items
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
-- Fel Whip
INSERT INTO `creature_loot_template` VALUES (23354, 32733, -100, 0, 1, 1, 0, 0, 0);
--
-- Zarcsin 23355
INSERT INTO `creature_loot_template` VALUES (23355, 21877, 16.9, 0, 4, 6, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 22903, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 27854, 2.6, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23355, 27860, 0.5, 0, 1, 1, 0, 0, 0);
-- Apexis Crystal
INSERT INTO `creature_loot_template` VALUES (23355, 32572, 0, 2, 1, 1, 0, 0, 0); -- 86.8 0
-- Depleted Items
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
-- Fel Whip
INSERT INTO `creature_loot_template` VALUES (23355, 32733, -100, 0, 1, 1, 0, 0, 0);
--
-- Apexis Guardian 22275
INSERT INTO `creature_loot_template` VALUES (22275, 4552, 48.5095, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 4554, 13.5501, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22275, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
-- Apexis Crystal
INSERT INTO `creature_loot_template` VALUES (22275, 32572, 0, 2, 1, 1, 0, 0, 0); -- 60.7046 0
-- Depleted Items
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
-- Apexis Guardian's Head
INSERT INTO `creature_loot_template` VALUES (22275, 32697, -100, 0, 1, 1, 0, 0, 0); -- -43

-- Galvanoth 22281
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='3210',`maxdmg`='3811',`AIName`='EventAI',`mechanic_immune_mask`='619396095',`spell1`='15708',`spell2`='38750',`spell3`='39139' WHERE `entry` = '22281'; -- 577 1178 -- 1200 - 1400 -- 3,210 - 3,811
-- Braxxus 23353
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='2140',`maxdmg`='2541',`AIName`='EventAI',`mechanic_immune_mask`='619396095' WHERE `entry` = '23353'; -- 1284 1524 -- 3,210 - 3,811
-- Mo'arg Incinerator 23354
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='2140',`maxdmg`='2541',`AIName`='EventAI',`mechanic_immune_mask`='619396095' WHERE `entry` = '23354';
-- Zarcsin 23355
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='2140',`maxdmg`='2541',`AIName`='EventAI',`mechanic_immune_mask`='619396095',`equipment_id`='1548' WHERE `entry` = '23355';

DELETE FROM `creature` WHERE `guid` IN (42593,48425,48521,45572);
INSERT INTO `creature` (`guid`,`id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(48425,25370, 580 , 1, 1657.0256, 1056.0332, 16.00, 4.2728, 7200, 0, 0),
-- (48521,25369, 580 , 1, 1751.8967, 993.6798, 16.1618, 1.0841, 7200, 0, 0),
(45572,25507,580,1,1761.8767,1082.1558,17.4186,3.8831,7200,0,0);

INSERT INTO `creature` VALUES (42593, 25369, 580, 1, 0, 1, 1757.44, 995.046, 16.0957, 0.715585, 7200, 0, 0, 220059, 0, 0, 0);
INSERT INTO `creature` VALUES (48521, 2010, 1, 1, 6801, 1, 9884.34, 1580.37, 1285.29, 0.087266, 300, 0, 0, 137, 0, 0, 0);

DELETE FROM `creature_formations` WHERE `MemberGUID` IN (43440,42593,48521,42655,54833,43738,54819,48360);
INSERT INTO `creature_formations` VALUES
(43440,43440,100,360,2),
(43440,42593,100,360,2),
(43440,42655,100,360,2),
(43440,54833,100,360,2),
(43440,43738,100,360,2),
(43440,54819,100,360,2),
(43440,48360,100,360,2);

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (48425,42593,48521,45572,54810,55065);
INSERT INTO `creature_linked_respawn` VALUES
(48425,53645),
(42593,53645),
(45572,53645),
(54810,53645),
(55065,53645);

-- del bs
DELETE FROM `creature` WHERE `guid` IN (36095,42593,45532,45604,45611,45615,45624,45632,45637,45741,46137,53940,84269,92517,98086,107061,124516,163912,174558,221620,312393,351441,529506,604678,605542,605601,605637,605654,605691,605704,605721,605739,605754,605830,605861,605879,605905,605920,605989,605996,606011,606182,606214,606255,606293,606312,606349,606391,606507,606521,606538,606548,606567,606581,606610,606637,606649,606666,606681,606703,606870,606883,606891,606925,606973,607027,607050,607149,607167,607189,607243,607255,607332,607356,607371,607444,607499,607593,607610,607622,607635,607651,607822,607839,607866,607883,607922,607968,608031,608098,608175,608243,608257,608275,608321,608348,608378,608391,608460,608538,608552,608562,608584,608611,608627,608922,608947,608969,609048,610375,610405,610428,610547,610578,610608,610634,610682,610712,610938,611084,611159,611216,611259,611292,611308,611452,611478,611618,611650,611670,611693,611719,611733,615216,615418,615432,615453,615501,615520,615534,615666,615687,615700,615714,615734,615786,615901,615916,615927,615939,615949,615958,615978,615992,616004,616014,616048,616065,616102,616119,616134,616145,616158,616230,616249,616268,616279,616306,616321,618916,618936,618952,618978,618999,619068,619084,619100,619127,619271,619297,619386,619471,619521,619774,619791,619809,619824,619838,619858,619873,619886,619903,620044,620066,620085,620101,620116,620132,620157,620190,620232,620249,620260,620282,620309,620334,620363,620377,620399,620413,620423,620438,620453,620840,621331,621387,621475,621486,621496,621513,621528,621540,621553,621567,621592,621607,621620,621636,621661,621672,621688,621701,621727,621754,621768,621783,621803,621814,621831,621859,622704,622721,622729,622743,622843,622856,622867,622874,622950,622958,622981,622996,623041,623065,623083,623098,623132,623155,623167,623182,623189,623208,623220,623231,623415,623456,623473,623503,623521,623531,623546,623556,623566,623582,623592,623810,623817,624584,624594,624609,624626,624639,624653,624668,624672,624742,624758,624778,624805,624817,624829,624894,624910,625050,625062,625073,625090,625119,625131,625142,625218,625294,625305,625321,625335,625361,625378,625414,625554,625569,668268,679332,1332722,1334878);

-- Prince Thunderaan <The Wind Seeker> 14435
UPDATE `creature_template` SET `armor`='7400',`resistance3`='-1',`AIName`='EventAI' WHERE `entry` = '14435';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '14435';
INSERT INTO `creature_ai_scripts` VALUES
('1443501','14435','0','0','100','1','5000','5000','15000','15000','11','23009','0','7','0','0','0','0','0','0','0','0','Prince Thunderaan - Cast Tendrils of Air'),
('1443502','14435','0','0','100','1','15000','15000','15000','15000','11','23011','0','7','0','0','0','0','0','0','0','0','Prince Thunderaan - Cast Tears of the Wind Seeker');

DELETE FROM `creature` WHERE `guid` IN ('66606');
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-1954.978,`position_y`=4752.3,`position_z`=-2.763442,`spawntimesecs`=180 WHERE `guid`=66605;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnMask`,`modelid`,`equipment_id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`spawndist`,`currentwaypoint`,`curhealth`,`curmana`,`DeathState`,`MovementType`) VALUES
(66606,18483,530,1,0,0,-1956.585,4751.758,-2.86066,2.005122,180,0,0,4500,0,0,0);

-- The Grand Collector 23333
UPDATE `creature_template` SET `speed`='2',`mindmg`='2568',`maxdmg`='3048',`unit_flags`='0',`type_flags`='0',`skinloot`='0',`flags_extra`='0' WHERE `entry` = '23333'; -- 1154 2356 -- 6,419 - 7,621 -- 80004
-- Bash'ir's Harbinger 23390
UPDATE `creature_template` SET `speed`='2',`mindmg`='3209',`maxdmg`='3811' WHERE `entry` = '23390'; -- 577 1179 -- 3,209 - 3,811
-- Bash'ir 23391
UPDATE `creature_template` SET `faction_A`='91',`faction_H`='91',`speed`='2',`mindmg`='3210',`maxdmg`='3811',`lootid`='23391' WHERE `entry` = '23391'; -- 577 1178 --  3,210 - 3,811

-- Hellfire Warder – Höllenfeuerwärter 18829
UPDATE `creature_template` SET `modelid_A2`='11438',`modelid_H2`='11440',`minlevel`='73',`maxlevel`='73',`rank`='3',`mindmg`='9417',`maxdmg`='11178',`baseattacktime`='2000',`speed`='1.48',`mechanic_immune_mask`='646004723' WHERE `entry` = 18829;

DELETE FROM `creature` WHERE `guid` IN ('85987');
UPDATE `creature_template` SET `speed`='1.48',`equipment_id`='1481',`AIName`='EventAI',`mechanic_immune_mask`='1' WHERE `entry` IN ('19443');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19443');
INSERT INTO `creature_ai_scripts` VALUES
(1944301,19443,9,0,100,1,0,5,15000,15000,11,34108,1,1,0,0,0,0,0,0,0,0,'Tagar Spinebreaker - Casts Spine Break'),
(1944302,19443,0,0,100,1,5500,5500,5000,10000,11,34109,1,1,0,0,0,0,0,0,0,0,'Tagar Spinebreaker - Casts Whirlwind Knockback');
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` IN ('14365');
--
-- Tagar Spinebreaker
SET @GUID := '85990';
SET @POINT := '0';
UPDATE `creature` SET `position_x`='-440.0492', `position_y`='2970.065', `position_z`='7.508814', `orientation`='4.585325', `spawntimesecs`='1800', `spawndist`='0', `MovementType`='2' WHERE `id`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` VALUES (@GUID,@GUID,0,0,0,0,0,0,'18950 0 18950 1');  
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-444.4490', '2935.541', '17.37160', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-431.3665', '2916.574', '19.33275', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-410.3391', '2897.444', '16.29737', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-431.3771', '2863.750', '23.18233', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-458.1045', '2835.910', '34.73303', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-474.8221', '2803.170', '44.83184', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-482.1413', '2780.444', '50.48174', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-464.1363', '2757.426', '49.97451', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-437.0097', '2742.231', '45.18545', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-417.4688', '2742.025', '40.00116', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-394.2155', '2733.282', '34.96598', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-370.1947', '2739.405', '27.66764', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-344.3984', '2742.731', '22.04218', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-328.4409', '2738.122', '21.60171', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-322.7293', '2726.575', '23.19661', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-324.5292', '2712.571', '25.90339', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-333.8743', '2701.390', '29.52560', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-343.8678', '2682.296', '35.19290', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-360.7138', '2656.587', '43.49288', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-353.4090', '2634.224', '39.98934', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-340.1870', '2619.544', '42.69732', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-315.1161', '2608.520', '41.10941', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-315.1175', '2592.784', '41.11610', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-326.0264', '2576.755', '44.59876', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-319.7011', '2564.647', '44.56841', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-306.6035', '2559.670', '43.15996', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-303.0155', '2544.127', '42.16570', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-308.2558', '2522.323', '42.33207', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-324.7303', '2514.007', '39.77470', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-341.2596', '2517.181', '42.19988', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-356.1326', '2524.870', '43.68792', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-372.5794', '2518.969', '44.36980', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-384.2734', '2500.578', '43.13384', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-382.4619', '2489.239', '35.94414', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-366.6036', '2481.708', '27.00704', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-336.8055', '2478.964', '29.27730', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-316.8047', '2478.671', '38.34806', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-300.1674', '2481.248', '40.28580', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-291.5379', '2471.795', '40.73017', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-299.4210', '2460.934', '41.18763', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-293.6134', '2451.263', '42.09815', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-290.9243', '2436.451', '43.87549', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-297.5943', '2428.966', '44.06300', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-296.6749', '2419.157', '44.97658', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-282.9760', '2416.102', '46.81825', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-276.8629', '2401.864', '49.40187', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-277.8916', '2385.711', '48.82200', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-275.5488', '2365.848', '50.60513', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-285.8336', '2348.487', '51.24258', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-270.1180', '2336.440', '54.06826', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-258.9032', '2325.336', '56.74421', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-245.2461', '2312.125', '51.73371', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-224.2681', '2309.814', '49.53231', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-193.9720', '2316.471', '55.18532', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-177.4344', '2325.307', '62.10829', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-168.6765', '2338.462', '60.56923', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-167.8729', '2349.308', '58.74965', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-168.5200', '2364.601', '56.28956', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-169.8706', '2379.328', '53.68618', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-174.0273', '2386.164', '51.76809', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-181.4586', '2393.358', '50.29006', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-181.6118', '2401.965', '49.19543', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-170.8668', '2413.743', '48.18652', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-155.9585', '2418.159', '44.62416', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-143.6135', '2429.302', '48.67031', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-137.6620', '2446.288', '45.33263', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-129.5334', '2458.865', '47.11806', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-118.4858', '2470.283', '46.80577', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-125.0594', '2492.918', '46.72667', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-142.4668', '2500.675', '45.44909', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-163.2269', '2495.378', '43.84887', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-175.1656', '2507.058', '42.24383', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-177.5515', '2518.257', '40.71404', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-171.8750', '2527.604', '41.07635', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-162.3206', '2537.286', '42.56754', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-146.7115', '2543.318', '41.38029', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-140.9195', '2565.580', '41.34489', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-161.9319', '2585.890', '39.86102', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-168.3633', '2594.324', '39.29259', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-162.8318', '2603.218', '39.82217', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-164.8098', '2612.353', '39.95963', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-166.3010', '2628.302', '41.23965', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-169.2782', '2651.493', '41.80959', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-173.8719', '2678.044', '42.39021', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-167.0316', '2686.460', '43.08601', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-136.6367', '2692.575', '45.80075', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-109.7790', '2700.458', '50.21601', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-105.7824', '2731.501', '52.56415', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-118.9187', '2750.039', '49.62867', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-130.3567', '2775.545', '41.48006', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-152.8521', '2788.343', '37.01861', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-186.1224', '2795.503', '26.38808', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-188.4375', '2810.328', '24.27693', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-175.6934', '2802.433', '28.90193', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-161.5930', '2806.948', '32.17490', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-149.4453', '2809.883', '35.48875', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-148.4477', '2826.183', '33.97642', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-165.3999', '2836.788', '26.73048', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-180.7325', '2840.167', '23.00070', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-165.3999', '2836.788', '26.73048', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-148.4477', '2826.183', '33.97642', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-149.4453', '2809.883', '35.48875', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-161.5930', '2806.948', '32.17490', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-175.5444', '2802.353', '28.92329', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-188.2305', '2810.365', '24.27693', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-186.1224', '2795.503', '26.38808', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-152.8521', '2788.343', '37.01861', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-130.3567', '2775.545', '41.48006', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-118.9187', '2750.039', '49.62867', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-105.7824', '2731.501', '52.56415', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-109.7790', '2700.458', '50.21601', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-136.5448', '2692.581', '46.02975', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-167.0316', '2686.460', '43.08601', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-173.8719', '2678.044', '42.39021', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-169.2782', '2651.493', '41.80959', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-166.3010', '2628.302', '41.23965', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-164.8098', '2612.353', '39.95963', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-162.8318', '2603.218', '39.82217', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-168.3633', '2594.324', '39.29259', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-161.9319', '2585.890', '39.86102', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-141.0879', '2565.726', '41.35856', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-146.7115', '2543.318', '41.38029', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-162.3206', '2537.286', '42.56754', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-171.8750', '2527.604', '41.07635', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-177.5515', '2518.257', '40.71404', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-175.1656', '2507.058', '42.24383', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-163.2269', '2495.378', '43.84887', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-142.4668', '2500.675', '45.44909', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-125.0594', '2492.918', '46.72667', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-118.4858', '2470.283', '46.80577', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-129.5334', '2458.865', '47.11806', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-137.6620', '2446.288', '45.33263', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-143.6135', '2429.302', '48.67031', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-155.9585', '2418.159', '44.62416', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-170.8668', '2413.743', '48.18652', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-181.6118', '2401.965', '49.19543', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-181.4586', '2393.358', '50.29006', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-174.0259', '2386.168', '51.76711', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-169.8706', '2379.328', '53.68618', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-168.5200', '2364.601', '56.28956', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-167.8729', '2349.308', '58.74965', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-168.6765', '2338.462', '60.56923', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-177.4344', '2325.307', '62.10829', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-193.9720', '2316.471', '55.18532', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-224.2681', '2309.814', '49.53231', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-244.9998', '2311.902', '51.73676', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-258.9032', '2325.336', '56.74421', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-270.1180', '2336.440', '54.06826', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-285.8336', '2348.487', '51.24258', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-275.5303', '2365.616', '50.66873', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-277.8916', '2385.711', '48.82200', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-276.8629', '2401.864', '49.40187', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-282.9760', '2416.102', '46.81825', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-296.6749', '2419.157', '44.97658', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-297.5943', '2428.966', '44.06300', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-290.9243', '2436.451', '43.87549', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-293.5898', '2451.217', '42.06214', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-299.4210', '2460.934', '41.18763', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-291.5379', '2471.795', '40.73017', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-300.1674', '2481.248', '40.28580', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-316.4770', '2478.663', '38.43131', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-336.4766', '2478.955', '29.18672', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-366.6036', '2481.708', '27.00704', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-382.4619', '2489.239', '35.94414', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-384.2734', '2500.578', '43.13384', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-372.5794', '2518.969', '44.36980', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-356.1326', '2524.870', '43.68792', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-341.2596', '2517.181', '42.19988', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-324.7303', '2514.007', '39.77470', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-308.2558', '2522.323', '42.33207', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-303.0155', '2544.127', '42.16570', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-306.4639', '2559.613', '43.08623', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-319.7011', '2564.647', '44.56841', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-326.0264', '2576.755', '44.59876', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-315.1175', '2592.784', '41.11610', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-315.1161', '2608.520', '41.10941', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-340.1870', '2619.544', '42.69732', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-353.4090', '2634.224', '39.98934', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-360.7138', '2656.587', '43.49288', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-343.8678', '2682.296', '35.19290', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-333.8743', '2701.390', '29.52560', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-324.5292', '2712.571', '25.90339', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-322.7293', '2726.575', '23.19661', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-328.4409', '2738.122', '21.60171', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-344.1392', '2742.767', '22.06757', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-370.1947', '2739.405', '27.66764', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-394.2155', '2733.282', '34.96598', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-417.4688', '2742.025', '40.00116', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-437.0097', '2742.231', '45.18545', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-464.1363', '2757.426', '49.97451', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-482.1413', '2780.444', '50.48174', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-474.8221', '2803.170', '44.83184', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-458.1045', '2835.910', '34.73303', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-431.3771', '2863.750', '23.18233', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-410.3391', '2897.444', '16.29737', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-431.3665', '2916.574', '19.33275', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-444.4490', '2935.541', '17.37160', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-438.6376', '2967.621', '7.942842', '0', '0', '0', '100', '0');

UPDATE `creature` SET `spawndist`='0',`movementtype`='0' WHERE `guid` = '57907';

UPDATE `creature_template` SET `speed`='2.00',`mindmg`='6500',`maxdmg`='8500',`mechanic_immune_mask`='1072644095',`flags_extra`='4522017',`minhealth`='4810000',`maxhealth`='4810000' WHERE `entry` = 21216; -- 6500 7500 3700000 --
-- Pure Spawn of Hydross 22035
-- Pure Spawns of Hydross has around 55,000 HP
UPDATE `creature_template` SET `minhealth`='72692',`maxhealth`='72692',`mindmg`='4000',`maxdmg`='5000',`baseattacktime`='2000',`speed`='1.48',`resistance4`='-1',`AIName`='EventAI' WHERE `entry` =22035; -- 55917 3500 4500 2000 -- 
-- Tainted Spawn of Hydross 22036
-- Tainted Spawn of Hydross has around 62,500 HP
UPDATE `creature_template` SET `minhealth`='81792',`maxhealth`='81792',`mindmg`='4000',`maxdmg`='5000',`baseattacktime`='2000',`speed`='1.48',`resistance3`='-1',`AIName`='EventAI' WHERE `entry` = 22036; -- 62917 3500 4500 2000 --

-- 2h respawn as decided by staff
-- ssc hydross & lurker trash 45min respawn timer
-- The creatures that lead up to Hydross the Unstable and creatures at the six pumping stations are now on a 2 hour respawn instead of 45 minutes. 
-- always 5min in despawn so -5min always
UPDATE `creature` SET `spawntimesecs`='7200' WHERE `guid` IN (80272,93853,93828,93851,82953,82961,82917,93848,93850,93852,82956,93832,93849,93847,82958,82957,93845);
--
-- Lurker Trash
UPDATE `creature` SET `spawntimesecs`='7200' WHERE `guid` IN (183607,82966,93837,93840,93841,82861,172713,173195,93789,183141,93829,82965,93834,93830,93787,175587,175857,93831,182677,93820,93815,93824,93825,82036,176722,176935,82032,181841,93823,93821,93822,93819,82002,177699,81997,82003,180803,93816,82964,93827,93818,81917,81916,80273,81944,179801,93842,82955,93844,93826,81029,80445,80274,80473);

DELETE FROM `creature_loot_template` WHERE `entry` IN (23061,23282,23261,23281);
-- Rivendark 23061
INSERT INTO `creature_loot_template` VALUES (23061, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 29549, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 29563, 25.1, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 29564, 5.7, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 31837, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23061, 32569, 92, 0, 2, 3, 0, 0, 0); --  24.9
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
INSERT INTO `creature_loot_template` VALUES (23061, 32681, 0, 2, 1, 1, 0, 0, 0); -- 100 0
INSERT INTO `creature_loot_template` VALUES (23061, 32732, -100, 0, 1, 1, 0, 0, 0);
--
-- Obsidia 23282
INSERT INTO `creature_loot_template` VALUES (23282, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 29563, 23.6, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 29564, 5, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23282, 32569, 93, 0, 2, 3, 0, 0, 0); -- 25
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
INSERT INTO `creature_loot_template` VALUES (23282, 32682, 0, 2	, 1, 1, 0, 0, 0); -- 100 0
INSERT INTO `creature_loot_template` VALUES (23282, 32732, -100, 0, 1, 1, 0, 0, 0);
--
-- Furywing 23261
INSERT INTO `creature_loot_template` VALUES (23261, 22153, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 29549, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 29563, 27.2, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 29564, 5.1, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32569, 92, 0, 2, 3, 0, 0, 0); -- 25
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
INSERT INTO `creature_loot_template` VALUES (23261, 32683, 0, 2, 1, 1, 0, 0, 0); -- 100 0
INSERT INTO `creature_loot_template` VALUES (23261, 32732, -100, 0, 1, 1, 0, 0, 0);
--
-- Insidion 23281
INSERT INTO `creature_loot_template` VALUES (23281, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 29563, 23.6, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 29564, 7, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23281, 32569, 93, 0, 2, 3, 0, 0, 0); -- 25.1 
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
INSERT INTO `creature_loot_template` VALUES (23281, 32684, 0, 2, 1, 1, 0, 0, 0); -- 100 0
INSERT INTO `creature_loot_template` VALUES (23281, 32732, -100, 0, 1, 1, 0, 0, 0);

SET @GUID := 86120;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX,YYY,ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3820.2136,3569.1176,294.5442,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3777.4877,3504.3828,303.5247,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3732.4897,3452.7006,307.9561,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3686.8332,3451.7778,310.1673,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3608.2360,3470.6501,316.8722,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3561.0017,3505.7106,313.4443,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3534.2641,3541.0085,310.5031,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3543.2609,3589.5461,312.8757,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3560.8098,3624.6367,309.2609,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3588.5305,3664.1962,306.7961,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3672.4365,3730.8588,306.0436,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3745.7727,3730.3386,311.7840,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3810.6787,3647.8015,302.2104,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1,-3834.4943,3597.2600,296.8573,0,1,0,100,0);

-- Monstrous Kaliri 23051
UPDATE `creature_template` SET `speed`='2.0',`inhabittype`='7' WHERE `entry` = '23051'; -- 1 3

-- Hyakiss the Lurker - Hyakiss der Lauerer 16179
UPDATE `creature_template` SET `mindmg`='5275',`maxdmg`='6264',`type_flags`='108',`mechanic_immune_mask`='787431423',`flags_extra`='0',`speed`='1.78',`baseattacktime`='1500',`inhabittype`='3',`AIName`='EventAI' WHERE `entry` IN ('16179'); -- -- ba 1900 -- 10,549 - 12,527
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16179');
INSERT INTO `creature_ai_scripts` VALUES
('1617901','16179','11','0','66','0','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Chance to Despawn on Spawn'),
('1617902','16179','11','0','100','0','0','0','0','0','11','22766','0','33','1','-9979','0','0','0','0','0','0','Hyakiss the Lurker - Cast Stealth and Emote on Spawn'),
('1617903','16179','4','0','100','0','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Set Phase 1 on Aggro'),
('1617904','16179','9','5','100','1','0','5','5000','10000','11','29901','1','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Cast Acidic Fang (Phase 1)'),
('1617905','16179','24','5','100','1','29901','7','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Set Phase 2 on Target Max Acidic Fang Aura Stack (Phase 1)'),
('1617906','16179','28','3','100','1','29901','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Set Phase 1 on Target Missing Acidic Fang Aura Stack (Phase 2)'),
('1617907','16179','9','0','100','1','0','40','6000','12000','11','29896','4','1','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Cast Hyakiss\' Web'),
('1617908','16179','7','0','100','1','0','0','0','0','22','0','0','0','11','22766','0','1','0','0','0','0','Hyakiss the Lurker - Set Phase to 0 & Cast Stealth on Evade');

-- Shadikith the Glider - Shadikith der Gleiter
UPDATE `creature_template` SET `mindmg`='6716',`maxdmg`='7706',`speed`='1.71',`type_flags`='108',`mechanic_immune_mask`='787431423',`flags_extra`='0',`baseattacktime`='1500',`AIName`='EventAI' WHERE `entry` IN ('16180'); -- 1400 -- 13,432 - 15,411
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16180');
INSERT INTO `creature_ai_scripts` VALUES
('1618001','16180','11','0','66','1','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Shadikith the Glider - Chance to Despawn on Spawn'),
('1618002','16180','9','0','100','0','0','45','0','0','11','29903','1','1','0','0','0','0','0','0','0','0','Shadikith the Glider - Cast Dive on Aggro'),
('1618003','16180','0','0','100','1','7000','11000','8000','12000','11','29905','1','1','13','-99','1','0','0','0','0','0','Shadikith the Glider - Cast Wing Buffet & Tank Aggro Reset'),
('1618004','16180','9','0','100','1','0','5','10000','12000','11','29904','0','1','0','0','0','0','0','0','0','0','Shadikith the Glider - Cast Sonic Burst'),
('1618005','16180','2','0','100','0','75','0','0','0','11','29903','5','1','0','0','0','0','0','0','0','0','Shadikith the Glider - Cast Dive at 75% HP'),
('1618006','16180','2','0','100','0','50','0','0','0','11','29903','5','1','0','0','0','0','0','0','0','0','Shadikith the Glider - Cast Dive at 50% HP'),
('1618007','16180','2','0','100','0','25','0','0','0','11','29903','5','1','0','0','0','0','0','0','0','0','Shadikith the Glider - Cast Dive at 25% HP'); -- ziel welches am weitesten weg ist hmmm

-- thx @ anonxy 
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 29905 AND `entry` = 19622;

-- Elder Razormaw nerf
UPDATE `creature_template` SET `equipment_id`='0' WHERE `entry` = 1019;

INSERT INTO `item_template` VALUES
(31878,9,10,-1,'Design: Veiled Noble Topaz',6270,3,64,1,120000,30000,0,-1,-1,70,0,755,350,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,483,0,-1,0,-1,0,-1,39470,6,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,0,0,0,-1,0,-1,0,'Teaches you how to cut a Veiled Noble Topaz.',0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,'',0,0,0,0,0);

DELETE FROM `creature_loot_template` WHERE `entry` IN (23230);
-- Shartuul 23230
INSERT INTO `creature_loot_template` VALUES (23230, 21877, 59.6, 0, 4, 6, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 27854, 4.3, 0, 1, 1, 0, 0, 0);
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
INSERT INTO `creature_loot_template` VALUES (23230, 32941, 8.6, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23230, 32942, 4.4, 2, 1, 1, 0, 0, 0);

-- Set Internal Cooldown to Thrash and Double Attack Abilities
DELETE FROM `spell_proc_event` WHERE `entry` IN (3417,8876,12787,19817,19818,19194,18943);
INSERT INTO `spell_proc_event` VALUES
(3417,0,0,0,0,0,0,0,2),
(8876,0,0,0,0,0,0,0,2),
(12787,0,0,0,0,0,0,0,2),
(19817,0,0,0,0,0,0,0,2),
(19818,0,0,0,0,0,0,0,2),
(19194,0,0,0,0,0,0,0,2),
(18943,0,0,0,0,0,0,0,2);

-- respawn
UPDATE `creature` SET `spawntimesecs`='120' WHERE `id` IN ('20561'); -- 1551

-- One Barber One 
UPDATE `creature` SET `spawnmask`='1',`position_x`='16227.0566', `position_y`='16287.4736', `position_z`='31.4318', `orientation`='4.6047',`spawndist`='0',`movementtype`='0' WHERE `guid` = 16800799;
UPDATE `creature` SET `spawnmask`='1',`id`='1000033',`position_x`='16251.6015', `position_y`='16295.9707', `position_z`='13.1745', `orientation`='1.4473',`spawndist`='0',`movementtype`='0' WHERE `guid` = '16800595';
DELETE FROM `gameobject` WHERE `guid` = 9970818;
INSERT INTO `gameobject` VALUES (9970818,183402,1,1,16232.5859,16297.9716,13.17430,0,0,0,-0.05,0.90,25,100,1); -- 0.665095,0.746758
UPDATE `gameobject` SET `animprogress`=100 WHERE `guid` IN (7332252,9970817);

-- Frostwolf Bowman 13359
UPDATE `creature_template` SET `modelid_A`='13398',`modelid_A2`='13400',`modelid_H`='13398',`modelid_H2`='13400',`minhealth`='10000',`maxhealth`='10142',`rank`='0',`mindmg`='500',`maxdmg`='1000',`attackpower`='0',`baseattacktime`='1400',`minrangedmg`='1000',`maxrangedmg`='2000',`unit_flags`=36937 WHERE `entry` IN ('13359'); -- 66 137 2000 200 600 uf 4608

-- Stormpike Bowman 13358
UPDATE `creature_template` SET `modelid_A`='13390',`modelid_A2`='13392',`modelid_H`='13390',`modelid_H2`='13392',`faction_A`='1217',`faction_H`='1217',`mingold`='262',`maxgold`='347',`minhealth`='10000',`maxhealth`='10142',`rank`='0',`mindmg`='500',`maxdmg`='1000',`attackpower`='0',`baseattacktime`='1400',`minrangedmg`='1000',`maxrangedmg`='2000',`unit_flags`=36937 WHERE `entry` IN ('13358'); -- 65 135 2000 200 600 uf 4608  4500

DELETE FROM `creature_formations` WHERE `leaderguid` IN (85160,85161,85163,85162,85156,85155,85154,85153,85152,85212,85213,85214,85150,85149,85148,85157,85158,85159,353909,368541,353950,395179,395234,398744,392058,391887,401214,401334,400697,400574,399809,392343,392630,81433,81434,396271,393119,392984,384686,384589,384191,384131,367568,363280,363149,367717,362544,368129,362730,367972,368275,361773,362303,368393,381053,380123,380082,379841,379950,381165,85368,85365,85366,101620,85327,99807,99770,99544,85323,85070,96875,96374,586480,586402,586452,586419,579499,579000,85057,85068,306005,305961,306606,306554,306725,85035,85036,84973,84974,85084,85082,85181,85001,85055,85180,84980,84979,84978,85182,56813,56814,369099,369130,56822,56817,56824,369530,56818,369555,56809,56816,56823,56815,369790,369881,369817,56811,56821,368729,56807,56812,56820,368834,368879,56819,56810,56808,56825,56822,56818,84987,56849,56855);
DELETE FROM `creature_formations` WHERE `memberguid` IN (85160,85161,85163,85162,85156,85155,85154,85153,85152,85212,85213,85214,85150,85149,85148,85157,85158,85159,353909,368541,353950,395179,395234,398744,392058,391887,401214,401334,400697,400574,399809,392343,392630,81433,81434,396271,393119,392984,384686,384589,384191,384131,367568,363280,363149,367717,362544,368129,362730,367972,368275,361773,362303,368393,381053,380123,380082,379841,379950,381165,85368,85365,85366,101620,85327,99807,99770,99544,85323,85070,96875,96374,586480,586402,586452,586419,579499,579000,85057,85068,306005,305961,306606,306554,306725,85035,85036,84973,84974,85084,85082,85181,85001,85055,85180,84980,84979,84978,85182,56813,56814,369099,369130,56822,56817,56824,369530,56818,369555,56809,56816,56823,56815,369790,369881,369817,56811,56821,368729,56807,56812,56820,368834,368879,56819,56810,56808,56825,56822,56818,84987,56849,56855);
INSERT INTO `creature_formations` VALUES
--
--
--
(85160,85160,5,360,2),
(85160,85161,5,360,2),
(85160,85163,5,360,2),
(85160,85162,5,360,2),
(85160,85156,5,360,2),
(85160,85155,5,360,2),
(85160,85154,5,360,2),
(85160,85153,5,360,2),
(85160,85152,5,360,2),
(85160,85212,5,360,2),
(85160,85213,5,360,2),
(85160,85214,5,360,2),
(85160,85150,5,360,2),
(85160,85149,5,360,2),
(85160,85148,5,360,2),
(85160,85157,5,360,2),
(85160,85158,5,360,2),
(85160,85159,5,360,2),
--
-- 353909 368541 353950
--
(368541,368541,5,360,2),
(368541,353909,2,1,2),
(368541,353950,2,5,2),
--
(395179,395179,60,360,2),
(395179,395234,60,360,2),
--
(398744,398744,60,360,2),
(398744,392058,60,360,2),
(398744,391887,60,360,2),
--
(401214,401214,60,360,2),
(401214,401334,60,360,2),
-- 
(400697,400697,60,360,2),
(400697,400574,60,360,2),
-- 
(399809,399809,60,360,2),
(399809,392343,60,360,2),
(399809,392630,60,360,2),
-- 
(81433,81433,60,360,2),
(81433,81434,60,360,2),
--
(396271,396271,60,360,2),
(396271,393119,60,360,2),
(396271,392984,60,360,2),
-- 
(384686,384686,60,360,2),
(384686,384589,60,360,2),
(384686,384191,60,360,2),
(384686,384131,60,360,2),
--
(367568,367568,60,360,2),
(367568,363280,60,360,2),
(367568,363149,60,360,2),
(367568,367717,60,360,2),
--
(362544,362544,60,360,2),
(362544,368129,60,360,2),
(362544,362730,60,360,2),
(362544,367972,60,360,2),
--
(368275,368275,60,360,2),
(368275,361773,60,360,2),
(368275,362303,60,360,2),
(368275,368393,60,360,2),
--
(381053,381053,60,360,2),
(381053,380123,60,360,2),
(381053,380082,60,360,2),
--
(379841,379841,60,360,2),
(379841,379950,60,360,2),
(379841,381165,60,360,2),
--
(85368,85368,60,360,2),
(85368,85365,60,360,2),
(85368,85366,60,360,2),
(85368,101620,60,360,2),
--
(85327,85327,60,360,2),
(85327,99807,60,360,2),
(85327,99770,60,360,2),
(85327,99544,60,360,2),
--
(85323,85323,60,360,2),
(85323,85070,60,360,2),
(85323,96875,60,360,2),
(85323,96374,60,360,2),
-- 
(586480,586480,60,360,2),
(586480,586402,60,360,2),
(586480,586452,60,360,2),
(586480,586419,60,360,2),
--
(579499,579499,60,360,2),
(579499,579000,60,360,2),
(579499,85057,60,360,2),
(579499,85068,60,360,2),
--
(306005,306005,60,360,2),
(306005,305961,60,360,2),
(306005,306606,60,360,2),
(306005,306554,60,360,2),
(306005,306725,60,360,2),
--
(84973,84973,60,360,2),
(84973,84974,60,360,2),
(84973,85035,60,360,2),
(84973,85036,60,360,2),
--
(85084,85084,60,360,2),
(85084,85082,60,360,2),
--
(85181,85181,60,360,2),
(85181,85001,60,360,2),
--
(85055,85055,60,360,2),
(85055,85180,60,360,2),
--
(84980,84980,60,360,2),
(84980,84979,60,360,2),
--
(84978,84978,60,360,2),
(84978,85182,60,360,2),
--
(56813,56813,60,360,2),
(56813,56814,60,360,2),
(56813,56822,60,360,2),
(56813,369099,60,360,2),
(56813,369130,60,360,2),
--
(56817,56817,60,360,2),
(56817,56824,60,360,2),
(56817,56818,60,360,2),
(56817,369530,60,360,2),
(56817,369555,60,360,2),
--
(56809,56809,60,360,2),
(56809,56816,60,360,2),
(56809,56823,60,360,2),
(56809,56815,60,360,2),
(56809,369790,60,360,2),
(56809,369881,60,360,2),
(56809,369817,60,360,2),
--
(56811,56811,60,360,2),
(56811,56821,60,360,2),
(56811,368729,60,360,2),
(56811,56807,60,360,2),
--
(56812,56812,60,360,2),
(56812,56820,60,360,2),
(56812,368834,60,360,2),
(56812,368879,60,360,2),
--
(56819,56819,60,360,2),
(56819,56810,60,360,2),
(56819,56808,60,360,2),
--
(84987,84987,60,360,2),
(84987,56849,60,360,2),
(84987,56855,60,360,2);

DELETE FROM `creature_onkill_reputation` WHERE `creature_id` =17096;
-- 17096	967	0	7	0	15	0	0	0	0

-- Restless Skeleton 17261
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='1224',`maxdmg`='1519',`baseattacktime`='1400',`resistance2`='-1',`resistance3`='-1',`resistance4`='-1',`resistance5`='-1',`resistance6`='-1' WHERE `entry` IN ('17261'); -- 587 1471 -- 3,672 - 4,556
--
-- Image of Arcanagos
UPDATE `creature_template` SET `InhabitType`='5' WHERE `entry` = 17652;
DELETE FROM `creature_template_addon` WHERE `entry` = 17652;
INSERT INTO `creature_template_addon` VALUES
(17652,0,0,16908544,0,4097,0,0,NULL);
