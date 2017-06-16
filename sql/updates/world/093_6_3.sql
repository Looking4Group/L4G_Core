-- Incandescent Fel Spark 22323
UPDATE `creature_template` SET `resistance2` = '-1', `flags_extra` = `flags_extra`|262144 WHERE `entry` = 22323;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22323;
INSERT INTO `creature_ai_scripts` VALUES
('2232301','22323','0','0','100','1','0','1000','10000','11000','11','36247','1','0','0','0','0','0','0','0','0','0','Incandescent Fel Spark - Cast Fel Fireball'),
('2232302','22323','6','0','100','0','0','0','0','0','11','44877','0','3','0','0','0','0','0','0','0','0','Incandescent Fel Spark - Cast Living Flare Master on Death');

-- Elemental Melee Attacks can not be blocked
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|262144 WHERE `dmgschool` != 0 AND `flags_extra` != `flags_extra`|262144;

-- 17471- (mob_lesser_shadow_fissure)
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `unit_flags` = 33947654, `ScriptName` = '' WHERE `entry` = 17471; -- needs nontargetable, nonattackable, nomove and maybe more
DELETE FROM `creature_template_addon` WHERE `entry` = 17471;
INSERT INTO `creature_template_addon` VALUES (17471, 0, 0, 0, 0, 0, 0, 0, '30497 0');

-- Grand Warlock Nethekurse ReGUID
DELETE FROM `creature` WHERE `guid` IN (13681415,57853);
INSERT INTO `creature` VALUES (57853, 16807, 540, 3, 0, 0, 178.928, 289.487, -8.18744, 4.70166, 43200, 0, 0, 107700, 60581, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (13681415);

DELETE FROM `creature_linked_respawn` WHERE `linkedguid` IN (13681415,57853);
INSERT INTO `creature_linked_respawn` VALUES (11262, 57853);
INSERT INTO `creature_linked_respawn` VALUES (13540, 57853);
INSERT INTO `creature_linked_respawn` VALUES (15331, 57853);
INSERT INTO `creature_linked_respawn` VALUES (15610, 57853);
INSERT INTO `creature_linked_respawn` VALUES (18485, 57853);
INSERT INTO `creature_linked_respawn` VALUES (18536, 57853);
INSERT INTO `creature_linked_respawn` VALUES (18601, 57853);
INSERT INTO `creature_linked_respawn` VALUES (18788, 57853);
INSERT INTO `creature_linked_respawn` VALUES (18838, 57853);
INSERT INTO `creature_linked_respawn` VALUES (19314, 57853);
INSERT INTO `creature_linked_respawn` VALUES (20420, 57853);
INSERT INTO `creature_linked_respawn` VALUES (20624, 57853);
INSERT INTO `creature_linked_respawn` VALUES (21428, 57853);
INSERT INTO `creature_linked_respawn` VALUES (22961, 57853);
INSERT INTO `creature_linked_respawn` VALUES (24089, 57853);
INSERT INTO `creature_linked_respawn` VALUES (24360, 57853);
INSERT INTO `creature_linked_respawn` VALUES (30418, 57853);
INSERT INTO `creature_linked_respawn` VALUES (31564, 57853);
INSERT INTO `creature_linked_respawn` VALUES (32163, 57853);
INSERT INTO `creature_linked_respawn` VALUES (32301, 57853);
INSERT INTO `creature_linked_respawn` VALUES (34034, 57853);
INSERT INTO `creature_linked_respawn` VALUES (34199, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57220, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57221, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57222, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57223, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57581, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57584, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57688, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57690, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57693, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57694, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57695, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57696, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57698, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57700, 57853);
INSERT INTO `creature_linked_respawn` VALUES (59478, 57853);
INSERT INTO `creature_linked_respawn` VALUES (59479, 57853);
INSERT INTO `creature_linked_respawn` VALUES (59480, 57853);
INSERT INTO `creature_linked_respawn` VALUES (59481, 57853);
INSERT INTO `creature_linked_respawn` VALUES (63390, 57853);
INSERT INTO `creature_linked_respawn` VALUES (63391, 57853);
INSERT INTO `creature_linked_respawn` VALUES (63392, 57853);
INSERT INTO `creature_linked_respawn` VALUES (90805, 57853);
INSERT INTO `creature_linked_respawn` VALUES (90996, 57853);
INSERT INTO `creature_linked_respawn` VALUES (91716, 57853);
INSERT INTO `creature_linked_respawn` VALUES (91731, 57853);
INSERT INTO `creature_linked_respawn` VALUES (91744, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92552, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92632, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92711, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92729, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92744, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92765, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92781, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92787, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92796, 57853);
INSERT INTO `creature_linked_respawn` VALUES (92808, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93078, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93256, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93273, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93283, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93441, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93459, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93546, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93554, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93578, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93590, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93607, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93976, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93985, 57853);
INSERT INTO `creature_linked_respawn` VALUES (93998, 57853);
INSERT INTO `creature_linked_respawn` VALUES (99955, 57853);
INSERT INTO `creature_linked_respawn` VALUES (99956, 57853);
INSERT INTO `creature_linked_respawn` VALUES (99957, 57853);
INSERT INTO `creature_linked_respawn` VALUES (99958, 57853);
INSERT INTO `creature_linked_respawn` VALUES (99996, 57853);
INSERT INTO `creature_linked_respawn` VALUES (99997, 57853);
INSERT INTO `creature_linked_respawn` VALUES (99998, 57853);
INSERT INTO `creature_linked_respawn` VALUES (163620, 57853);
INSERT INTO `creature_linked_respawn` VALUES (163676, 57853);
INSERT INTO `creature_linked_respawn` VALUES (163832, 57853);
INSERT INTO `creature_linked_respawn` VALUES (163872, 57853);
INSERT INTO `creature_linked_respawn` VALUES (163892, 57853);
INSERT INTO `creature_linked_respawn` VALUES (187294, 57853);
INSERT INTO `creature_linked_respawn` VALUES (57853, 57853);

-- Reguid 12719 to 76575
SET @GUID := 76575;
DELETE FROM `creature` WHERE `guid` IN (@GUID,12719);
INSERT INTO `creature` VALUES (@GUID, 24994, 530, 1, 0, 0, 12848.6, -7040.74, 18.6604, 2.20449, 300, 0, 0, 69860, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` IN (@GUID,12719);
INSERT INTO `creature_addon` VALUES (@GUID, @GUID, 0, 0, 0, 0, 0, 0, NULL);
DELETE FROM `game_event_creature` WHERE `guid` IN (@GUID,12719);
INSERT INTO `game_event_creature` VALUES (@GUID, 42);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (@GUID, 1, 12855.8, -7032.47, 18.9525, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 2, 12858.4, -7006.76, 25.2855, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 3, 12850.2, -6994.06, 32.3065, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 4, 12840.5, -6986.8, 38.0928, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 5, 12826.7, -6983.79, 43.9748, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 6, 12815.7, -6985.14, 47.3124, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 7, 12806.8, -6991.77, 47.6362, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 8, 12816, -7002.94, 47.4295, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 9, 12832.2, -7003.82, 47.4274, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 10, 12837, -7022.8, 47.4028, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 11, 12844, -7033.88, 47.8643, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 12, 12835.7, -7023.58, 47.4043, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 13, 12834.8, -7008.85, 47.4273, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 14, 12817, -7001.99, 47.4273, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 15, 12807, -6992.42, 47.6398, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 16, 12815.9, -6984.86, 47.1909, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 17, 12832.4, -6983.44, 41.6628, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 18, 12847.7, -6989.91, 34.3545, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 19, 12858.2, -7005.1, 25.8451, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 20, 12858.1, -7022.35, 20.3098, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (@GUID, 21, 12848.7, -7041.35, 18.6506, 0, 0, 0, 100, 0);

-- Reguid 7400 to 12719
DELETE FROM `creature` WHERE `guid` IN (7400,12718,12719,12720,12721,12722,12723,12724,12725,12726);
INSERT INTO `creature` VALUES (12718, 23047, 564, 1, 0, 0, 448.664, 191.274, 164.065, 0.139626, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12719, 23047, 564, 1, 0, 0, 449.336, 187.124, 164.065, 0.15708, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12720, 23047, 564, 1, 0, 0, 449.499, 182.922, 164.065, 0.139626, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12721, 23047, 564, 1, 0, 0, 448.259, 195.735, 164.065, 0.05236, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12722, 23047, 564, 1, 0, 0, 442.897, 191.007, 164.065, 0.122173, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12723, 23047, 564, 1, 0, 0, 443.344, 186.511, 164.065, 0.087266, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12724, 23047, 564, 1, 0, 0, 443.843, 182.041, 164.065, 0.122173, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12725, 23047, 564, 1, 0, 0, 442.478, 195.178, 164.065, 0.10472, 7200, 0, 0, 36200, 0, 0, 0);
INSERT INTO `creature` VALUES (12726, 23049, 564, 1, 0, 0, 454.345, 190.091, 164.065, 3.07178, 7200, 0, 0, 369000, 0, 0, 2);

DELETE FROM `creature_formations` WHERE `leaderguid` = 12726;
INSERT INTO `creature_formations` VALUES (12726, 12718, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12719, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12720, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12721, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12722, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12723, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12724, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12725, 0, 0, 2);
INSERT INTO `creature_formations` VALUES (12726, 12726, 0, 0, 2);

DELETE FROM `creature_formations` WHERE `leaderguid` = 52745;
INSERT INTO `creature_formations` VALUES
(52745, 52754, 0, 0, 2),
(52745, 12883, 0, 0, 2),
(52745, 52744, 0, 0, 2),
(52745, 52745, 0, 0, 2),
(52745, 52755, 0, 0, 2);

-- Spell Summoned 91405,91406,91407,91421,91422,91427
DELETE FROM `creature` WHERE `id` = 11258;
UPDATE `creature_template` SET `mindmg` = '102', `maxdmg` = '135' WHERE `entry` = 11258;

DELETE FROM `creature_ai_texts` WHERE `entry` IN (-762,-763);
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-762','Note the weak binding structure of this one. Be sure to finish your incantations or this is what you will end up with.','0','0','0','11582','1'),
('-763','Wow, this one is just plain useless. Let me try again.','0','0','0','11582','1');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 11582;
INSERT INTO `creature_ai_scripts` VALUES
('1158201','11582','1','0','100','3','1000','2500','30000','31000','11','16531','0','1','0','0','0','0','0','0','0','0','Scholomance Dark Summoner - Cast Frail Skeleton OOC'),
('1158202','11582','1','0','100','3','16000','17500','30000','31000','1','-410','-311','-435','1','-762','-763','0','0','0','0','0','Scholomance Dark Summoner - Random Say OOC'),
('1158203','11582','0','0','95','3','500','2800','1900','3700','11','17618','0','1','0','0','0','0','0','0','0','0','Scholomance Dark Summoner - Summon Risen Lackey'),
('1158204','11582','0','0','100','3','0','500','38700','49300','11','12279','1','32','0','0','0','0','0','0','0','0','Scholomance Dark Summoner - Cast Curse of Blood');

-- Nethermancer Sepethrea  19221,21536
UPDATE `creature_template` SET `mindmg`='800',`maxdmg`='1200' WHERE `entry` = 19221;
UPDATE `creature_template` SET `mindmg`='1982',`maxdmg`='2345' WHERE `entry` = 21536;

SET @GUID := 31751;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (31751, 21771, 530, 1, 0, 0, -3079.75, 2555.73, 62.854, 4.732, 300, 0, 0, 6300, 2991, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (31751, 1, -3079.74, 2547.04, 62.8024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 2, -3079.75, 2555.73, 62.854, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 3, -3079.74, 2547.04, 62.8024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 4, -3079.75, 2555.73, 62.854, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 5, -3079.74, 2547.04, 62.8024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 6, -3079.75, 2555.73, 62.854, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 7, -3079.74, 2547.04, 62.8024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 8, -3080.14, 2550.91, 62.8903, 25000, 0, 0, 0, 0); -- 2177101
INSERT INTO `waypoint_data` VALUES (31751, 9, -3079.75, 2555.73, 62.854, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 10, -3079.74, 2547.04, 62.8024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 11, -3079.75, 2555.73, 62.854, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 12, -3079.74, 2547.04, 62.8024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 13, -3079.75, 2555.73, 62.854, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 14, -3079.74, 2547.04, 62.8024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (31751, 15, -3079.75, 2555.73, 62.854, 2000, 0, 0, 0, 0);

SET @GUID := 46384;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (46384, 1, 10093.5, 2453.88, 1318.27, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 2, 10104.3, 2461.38, 1317.78, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 3, 10111.6, 2475.67, 1317.32, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 4, 10111.9, 2490.86, 1318.19, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 5, 10093.4, 2527.76, 1317.64, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 6, 10105.1, 2505.08, 1318.6, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 7, 10111.3, 2489.62, 1317.98, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 8, 10110.9, 2475.37, 1317.29, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 9, 10102.8, 2458.83, 1318.06, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (46384, 10, 10085.3, 2449.67, 1317.97, 0, 0, 0, 0, 0);

SET @GUID := 35869;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (35869, 1, -3681.7, 562.659, 32.9927, 0, 0, 0, 0, 0); -- 2174301
INSERT INTO `waypoint_data` VALUES (35869, 2, -3644.52, 562.962, 20.2017, 0, 0, 0, 0, 0); -- 2174301
INSERT INTO `waypoint_data` VALUES (35869, 3, -3634.11, 563.081, 16.8451, 6000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (35869, 4, -3660.47, 562.699, 25.7358, 0, 0, 0, 0, 0); -- 2174301
INSERT INTO `waypoint_data` VALUES (35869, 5, -3701.42, 562.505, 39.7008, 0, 0, 0, 0, 0); -- 2174301
INSERT INTO `waypoint_data` VALUES (35869, 6, -3715.82, 562.837, 44.734, 6000, 0, 0, 0, 0);

SET @GUID := 52399;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52399, 1, -2670.27, 8556.48, -24.3327, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 2, -2727.6, 8505.54, -33.2203, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 3, -2798.87, 8408.73, -32.8769, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 4, -2753.05, 8142.68, -41.5723, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 5, -2668.57, 8092.38, -40.8327, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 6, -2541.15, 8080.54, -42.7048, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 7, -2443.69, 8129.17, -36.6802, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 8, -2383.76, 8191.97, -33.1643, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 9, -2354.92, 8321.24, -32.3505, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 10, -2379.65, 8410.24, -30.9855, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 11, -2456.4, 8494.97, -29.0302, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 12, -2566.02, 8530.06, -25.9058, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52399, 13, -2670.74, 8520.71, -30.7958, 0, 0, 0, 0, 0);

SET @GUID := 52400;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52400, 1, -2286.56, 8621.62, -5.12038, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52400, 2, -2208.61, 8513.88, -5.39454, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52400, 3, -2209.42, 8573.6, 2.2257, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52400, 4, -2280.99, 8652.49, 0.706009, 0, 0, 0, 0, 0);

SET @GUID := 52402;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52402, 1, -2740.06, 6962.79, -2.00595, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 2, -2708.33, 6930.69, 5.90239, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 3, -2713.82, 6842.92, 4.49263, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 4, -2821.07, 6757.41, 12.1712, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 5, -2827.28, 6723.3, 21.978, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 6, -2806.46, 6586.45, 41.6987, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 7, -2740.08, 6641.43, 22.961, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 8, -2706.18, 6733.12, 24.1225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52402, 9, -2728.09, 6881.95, 2.40176, 0, 0, 0, 0, 0);

SET @GUID := 52403;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52403, 1, -2369.1, 6513.95, 45.4725, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 2, -2383.58, 6477.35, 27.9339, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 3, -2395.76, 6431.19, 22.4845, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 4, -2381.16, 6457.17, 20.261, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 5, -2284.68, 6488.93, 16.614, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 6, -2197.57, 6495.5, 25.7769, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 7, -2145.82, 6435.28, 42.102, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 8, -2031.99, 6339.93, 59.739, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 9, -1950.56, 6362.55, 59.9186, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 10, -1885.45, 6416.22, 55.2037, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 11, -1784.83, 6480.16, 51.1629, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 12, -2005.43, 6490.27, 110.293, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52403, 13, -2159.16, 6562.93, 28.7363, 0, 0, 0, 0, 0);

SET @GUID := 52404;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52404, 1, -1518.15, 7065.83, 18.9225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52404, 2, -1585.41, 7114.7, 15.0063, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52404, 3, -1608.95, 6993.19, 5.14389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52404, 4, -1540.55, 7013.53, 12.4748, 0, 0, 0, 0, 0);

SET @GUID := 54870;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (54870, 22148, 530, 1, 0, 0, -1330.64, 5792.9, 183.28, 1.74635, 300, 0, 0, 7181, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (54870, 1, -1338.4, 5817.68, 184.866, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 2, -1336.71, 5831.79, 185.845, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 3, -1313.84, 5849.55, 199.389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 4, -1316.62, 5853.86, 201.805, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 5, -1334.76, 5866.23, 212.388, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 6, -1313.79, 5851.52, 199.923, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 7, -1315.65, 5846.51, 197.901, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 8, -1336.87, 5831.49, 185.797, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 9, -1337.9, 5816.23, 184.889, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 10, -1329.2, 5786.87, 182.854, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 11, -1328.9, 5767.59, 182.657, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 12, -1328.76, 5747.74, 182.025, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 13, -1334.7, 5735.71, 180.898, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 14, -1332.69, 5723.99, 180.092, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 15, -1334.7, 5735.71, 180.898, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 16, -1328.95, 5748.09, 181.99, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 17, -1328.93, 5768.83, 182.739, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (54870, 18, -1330.62, 5792.06, 183.215, 0, 0, 0, 0, 0);

SET @GUID := 55802;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (55802, 16221, 530, 1, 0, 0, 9151.62, -6702.86, 24.3109, 5.83393, 360, 0, 0, 1215, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (55802, 1, 9151.62, -6702.86, 24.3109, 1000, 0, 0, 0, 0); -- 1622101
INSERT INTO `waypoint_data` VALUES (55802, 2, 9175.54, -6714.2, 26.0494, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 3, 9200.73, -6718.44, 25.8468, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 4, 9209.32, -6722.74, 25.632, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 5, 9221.76, -6734.95, 25.2283, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 6, 9237.28, -6759.91, 24.9455, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 7, 9244.59, -6788.33, 23.7142, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 8, 9246.93, -6818.23, 19.3459, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 9, 9243.49, -6833.1, 17.0062, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 10, 9224.17, -6858.76, 12.2348, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 11, 9245.08, -6830.3, 17.4443, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 12, 9245.33, -6792.53, 23.2525, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 13, 9240.97, -6767.78, 24.67, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 14, 9224.66, -6739.66, 25.1088, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 15, 9214, -6727.22, 25.3519, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 16, 9203.12, -6718.08, 25.8748, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 17, 9177.27, -6714.54, 26.1012, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 18, 9152.85, -6704.02, 24.4276, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 19, 9130.06, -6693.25, 23.2046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 20, 9100.87, -6685.34, 20.8723, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 21, 9083.46, -6682.89, 19.3495, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 22, 9065.56, -6682.98, 16.7473, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 23, 9093.29, -6683.31, 20.3039, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 24, 9101.51, -6680.65, 20.9162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 25, 9103.88, -6674.12, 21.7294, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 26, 9099.35, -6657.52, 22.0418, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 27, 9102.42, -6647.26, 23.2374, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 28, 9121.32, -6626.45, 26.7952, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 29, 9136.62, -6618.55, 29.0918, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 30, 9157.46, -6615.65, 30.7248, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 31, 9168.71, -6610.88, 31.2371, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 32, 9179.42, -6600.27, 31.8366, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 33, 9193.47, -6583.44, 32.6952, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 34, 9224.49, -6560.81, 31.9586, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 35, 9245.92, -6548.87, 31.942, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 36, 9258.16, -6547.53, 33.2162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 37, 9291.08, -6553.81, 34.5914, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 38, 9296.64, -6552.64, 34.6026, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 39, 9301.53, -6550.26, 34.6231, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 40, 9305.17, -6546.33, 34.6403, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 41, 9296.7, -6552.85, 34.602, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 42, 9289.65, -6554.36, 34.5911, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 43, 9258.17, -6547.61, 33.2113, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 44, 9245.94, -6549.07, 31.9428, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 45, 9224.78, -6560.53, 31.9582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 46, 9193.19, -6583.57, 32.6867, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 47, 9185.34, -6590.89, 32.376, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 48, 9174.6, -6606.27, 31.49, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 49, 9168.63, -6611.54, 31.2102, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 50, 9155.36, -6616.81, 30.5532, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 51, 9137.52, -6618.39, 29.2279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 52, 9127.76, -6621.33, 27.8341, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 53, 9107.5, -6640.04, 24.401, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 54, 9099.88, -6651.96, 22.5778, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 55, 9098.93, -6659.86, 21.8473, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 56, 9104.61, -6676.34, 21.5272, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 57, 9103.24, -6680.22, 21.0557, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 58, 9098.15, -6683.2, 20.6473, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 59, 9064.97, -6683.33, 16.6582, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 60, 9101.57, -6684.97, 20.8846, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (55802, 61, 9130.73, -6693.28, 23.2326, 1000, 0, 0, 0, 0); -- 1622102
INSERT INTO `waypoint_data` VALUES (55802, 62, 9151.19, -6702.86, 24.2903, 0, 0, 0, 0, 0);

SET @GUID := 57532;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57532, 1, 193.875, 2691.79, 90.4446, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 2, 191.2, 2691.52, 88.8684, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 3, 157.955, 2682.04, 84.7984, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 4, 141.394, 2682.27, 85.0582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 5, 132.142, 2680.31, 84.5387, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 6, 127.41, 2674.16, 83.792, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 7, 130.227, 2665.74, 84.1191, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 8, 149.295, 2655.32, 85.7645, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 9, 173.005, 2636.76, 86.6589, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 10, 187.296, 2615.96, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 11, 185.294, 2610.45, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 12, 185.983, 2605.4, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 13, 189.477, 2601.48, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 14, 193.971, 2600.82, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 15, 199.045, 2603.43, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 16, 200.401, 2608.22, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 17, 198.212, 2611.95, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 18, 186.073, 2618.92, 87.2837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 19, 180.859, 2625.11, 87.8267, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 20, 164.915, 2644.56, 86.2701, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 21, 145.338, 2655.01, 85.4967, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 22, 135.465, 2662.14, 84.5251, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 23, 130.392, 2669.21, 84.0476, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 24, 130.433, 2676.11, 84.0992, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 25, 134.531, 2681.19, 84.7492, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 26, 149.893, 2685.69, 85.0317, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 27, 191.088, 2690.85, 88.8187, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 28, 193.292, 2691.13, 90.313, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 29, 216.744, 2693.81, 91.565, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 30, 225.475, 2680.62, 90.6967, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 31, 239.822, 2680.8, 90.7032, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 32, 247.639, 2683.32, 90.7032, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 33, 255.599, 2691.21, 90.7032, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 34, 254.618, 2704.87, 90.7033, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 35, 244.664, 2714.81, 90.7033, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 36, 225.82, 2712.12, 90.7023, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 37, 220.749, 2707.72, 90.7025, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 38, 218.562, 2694.82, 90.8683, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57532, 39, 199.561, 2692.09, 90.7037, 0, 0, 0, 0, 0);

SET @GUID := 57537;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57537, 1, -1334.61, 2361.44, 88.952, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 2, -1326.63, 2356.51, 88.9537, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 3, -1319.9, 2360.74, 88.9537, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 4, -1316.27, 2374.49, 88.5711, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 5, -1311.84, 2380.79, 86.4663, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 6, -1305.65, 2385.17, 83.8705, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 7, -1300.34, 2386.99, 81.7855, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 8, -1314.47, 2380.93, 87.1559, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 9, -1317.66, 2376, 88.5791, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 10, -1321.38, 2374.12, 88.873, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 11, -1323.15, 2376.17, 88.8695, 30000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 12, -1322.26, 2373.85, 88.9045, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 13, -1318.56, 2374.65, 88.7012, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 14, -1313.77, 2380.42, 87.0546, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 15, -1307.63, 2384.66, 84.5135, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 16, -1299.73, 2387.06, 81.5404, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 17, -1313.26, 2383.31, 86.4903, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 18, -1322.3, 2388.47, 88.4279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 19, -1327.29, 2387.27, 88.8594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 20, -1331.12, 2383.82, 88.9524, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 21, -1333.59, 2377.26, 88.9512, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57537, 22, -1340.06, 2370.25, 88.9512, 5000, 0, 0, 0, 0);

SET @GUID := 57576;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57576, 1, 23.7, 2677.07, 76.7947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 2, 29.5186, 2662.79, 75.5889, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 3, 36.7549, 2663.57, 76.6482, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 4, 57.1088, 2670.26, 79.1019, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 5, 65.1478, 2663.53, 79.9572, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 6, 68.2604, 2653.86, 80.6543, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 7, 66.6964, 2647.89, 79.1051, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 8, 69.3452, 2654.17, 80.9377, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 9, 65.8566, 2661.81, 80.4231, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 10, 54.4738, 2667.41, 78.6493, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 11, 41.6966, 2665.8, 77.3675, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 12, 31.8775, 2658.08, 75.2857, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 13, 32.2505, 2643.01, 74.3166, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 14, 35.6496, 2635.57, 75.9404, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 15, 41.5567, 2626.67, 74.4366, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 16, 45.3727, 2626.16, 73.861, 60000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 17, 42.0584, 2627.08, 74.4471, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 18, 33.2927, 2635.99, 75.411, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 19, 32.4661, 2641.63, 74.3467, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 20, 27.458, 2663.08, 75.3224, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 21, 24.2932, 2669.6, 76.2387, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 22, 23.1339, 2680.03, 76.8103, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57576, 23, 26.3861, 2681.9, 77.2808, 60000, 0, 0, 0, 0);

SET @GUID := 57608;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57608, 1, 9572.41, -7060.69, 18.6436, 30000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57608, 2, 9581.56, -7062.5, 18.6436, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57608, 3, 9590.1, -7060.46, 18.6436, 30000, 0, 0, 100, 0); -- 1661101
INSERT INTO `waypoint_data` VALUES (57608, 4, 9587.3, -7060.51, 18.6436, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57608, 5, 9586.82, -7062.25, 18.6436, 20000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57608, 6, 9581.68, -7062.86, 18.6436, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57608, 7, 9571.29, -7061.17, 18.6436, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57608, 8, 9572.41, -7060.69, 18.6436, 180000, 0, 0, 100, 0);

SET @GUID := 57621;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57621, 1, 9453.12, -7138.64, 16.1464, 45000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57621, 2, 9455.66, -7135.42, 16.1352, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57621, 3, 9453.97, -7134.69, 16.1431, 30000, 0, 0, 100, 0); -- 1662601
INSERT INTO `waypoint_data` VALUES (57621, 4, 9451.15, -7138.66, 16.1464, 30000, 0, 0, 100, 0); -- 1662601
INSERT INTO `waypoint_data` VALUES (57621, 5, 9453.12, -7138.64, 16.1464, 240000, 0, 0, 100, 0);

SET @GUID := 57637;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57637, 1, 10013.3, -7214.86, 32.0748, 30000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57637, 2, 10013.5, -7217.56, 32.0748, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57637, 3, 10016.2, -7218.02, 32.0748, 20000, 0, 0, 100, 0); -- 1664301
INSERT INTO `waypoint_data` VALUES (57637, 4, 10014.7, -7217.3, 32.0764, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57637, 5, 10017.5, -7213.64, 32.0764, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57637, 6, 10017.7, -7210.42, 32.0756, 6000, 0, 0, 100, 0); -- 1664302
INSERT INTO `waypoint_data` VALUES (57637, 7, 10017.5, -7213.48, 32.0764, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57637, 8, 10013.3, -7214.86, 32.0748, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57637, 9, 10013.3, -7214.86, 32.0748, 240000, 0, 0, 100, 0);

SET @GUID := 57648;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57648, 1, 9703.85, -7267.49, 16.1144, 60000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 2, 9703.63, -7263.83, 15.9914, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 3, 9706.74, -7261.86, 16.5287, 30000, 0, 0, 100, 0); -- 1665501
INSERT INTO `waypoint_data` VALUES (57648, 4, 9703.75, -7263.42, 16.0209, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 5, 9701.5, -7261.56, 15.9065, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 6, 9698.97, -7258.35, 15.599, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 7, 9698.97, -7258.35, 15.599, 30000, 0, 0, 100, 0); -- 1665502
INSERT INTO `waypoint_data` VALUES (57648, 8, 9700.7, -7261.93, 15.7977, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 9, 9703.63, -7266.76, 16.0817, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 10, 9701.12, -7272.78, 15.8364, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 11, 9700.66, -7278.72, 15.5704, 30000, 0, 0, 100, 0); -- 1665502
INSERT INTO `waypoint_data` VALUES (57648, 12, 9701.32, -7272.86, 15.8672, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 13, 9703.85, -7267.49, 16.1144, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57648, 14, 9703.85, -7267.49, 16.1144, 180000, 0, 0, 100, 0);

SET @GUID := 57656;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57656, 1, 9651.49, -7040.08, 15.2471, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57656, 2, 9652.64, -7034.86, 15.26, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57656, 3, 9647.81, -7031.98, 15.2677, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57656, 4, 9648.98, -7029.66, 15.2674, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57656, 5, 9650.64, -7037.8, 15.2478, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57656, 6, 9644.82, -7038.16, 15.2464, 0, 0, 0, 100, 0);

SET @GUID := 57657;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57657, 1, 9822.16, -7333.16, 26.3, 30000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57657, 2, 9822.35, -7331.03, 26.2814, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57657, 3, 9820.39, -7329.52, 26.2814, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57657, 4, 9819.43, -7330.37, 26.2814, 30000, 0, 0, 100, 0); -- 1666701
INSERT INTO `waypoint_data` VALUES (57657, 5, 9820.59, -7329.88, 26.2814, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57657, 6, 9821.49, -7331.48, 26.2814, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57657, 7, 9821.25, -7331.97, 26.2814, 30000, 0, 0, 100, 0); -- 1666702
INSERT INTO `waypoint_data` VALUES (57657, 8, 9822.16, -7333.16, 26.3, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57657, 9, 9822.16, -7333.16, 26.3, 200000, 0, 0, 100, 0);

UPDATE `creature` SET `position_x` = '9841.98', `position_y` = '-7362.39', `position_z` = '18.5945', `orientation` = '4.79965', `spawndist` = '0', `MovementType` = '0' WHERE `guid` = 57659;

SET @GUID := 57661;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57661, 1, 9859.67, -7361.79, 18.5932, 30000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57661, 2, 9858.73, -7363.12, 18.5903, 60000, 0, 0, 100, 0); -- 1667101
INSERT INTO `waypoint_data` VALUES (57661, 3, 9859.67, -7361.79, 18.5932, 1000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57661, 4, 9859.67, -7361.79, 18.5932, 240000, 0, 0, 100, 0);

SET @GUID := 57682;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57682, 1, 9451.74, -7122.86, 16.1462, 30000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57682, 2, 9452.37, -7125.35, 16.1465, 30000, 0, 0, 100, 0); -- 1669301
INSERT INTO `waypoint_data` VALUES (57682, 3, 9451.99, -7128.64, 16.1465, 30000, 0, 0, 100, 0); -- 1669301
INSERT INTO `waypoint_data` VALUES (57682, 4, 9451.74, -7122.86, 16.1462, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57682, 5, 9451.74, -7122.86, 16.1462, 30000, 0, 0, 100, 0);

SET @GUID := 58236;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58236, 1, -1024.86, 2199.93, 16.0507, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 2, -1043.71, 2205.85, 18.2739, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 3, -1068.3, 2213.88, 22.7967, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 4, -1092.91, 2219.38, 27.9263, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 5, -1117.16, 2221.18, 33.0392, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 6, -1134.75, 2216.39, 37.4685, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 7, -1149.06, 2203.35, 42.9657, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 8, -1155.48, 2189.72, 48.2462, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 9, -1158.35, 2175.26, 53.319, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 10, -1152.85, 2194.93, 46.0027, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 11, -1145.53, 2212.2, 40.6077, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 12, -1128.85, 2223.86, 35.3135, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 13, -1109.89, 2228.37, 30.7806, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 14, -1083.28, 2225.96, 25.7495, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 15, -1061.53, 2221.22, 21.2006, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 16, -1035.28, 2215.97, 16.6068, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 17, -1000.94, 2193.2, 13.8464, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 18, -976.253, 2185.78, 15.2738, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 19, -955.033, 2175.5, 14.9072, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 20, -934.932, 2161.59, 15.0371, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 21, -910.531, 2137.36, 16.3468, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 22, -932.735, 2160.22, 14.8823, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 23, -955.265, 2176.38, 14.7504, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 24, -980.067, 2185.16, 15.1836, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58236, 25, -1001.41, 2192.61, 13.9525, 0, 0, 0, 0, 0);

SET @GUID := 58237;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58237, 1, -974.291, 2186.16, 15.1253, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 2, -951.808, 2177.4, 14.1062, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 3, -929.571, 2164.15, 13.4644, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 4, -902.517, 2138.79, 16.077, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 5, -930.448, 2172.64, 12.3099, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 6, -944.377, 2186.65, 11.8939, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 7, -983.655, 2187.45, 14.8497, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 8, -1007.33, 2189.93, 14.9752, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 9, -1030.59, 2194.99, 17.4679, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 10, -1057.93, 2201.25, 21.0192, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 11, -1083.97, 2208.65, 26.6141, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 12, -1107.72, 2215.39, 31.3355, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 13, -1131.01, 2214.46, 36.8603, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 14, -1142.89, 2204.85, 41.0721, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 15, -1152.11, 2188.75, 47.5631, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 16, -1155.22, 2172.22, 53.6154, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 17, -1153.81, 2160.07, 58.6675, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 18, -1154.31, 2183.87, 49.6374, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 19, -1150.31, 2200.56, 43.8697, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 20, -1139.98, 2212.49, 39.1752, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 21, -1126.38, 2220.28, 35.1574, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 22, -1101.18, 2221.35, 29.5914, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 23, -1072.66, 2217.09, 23.5984, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 24, -1045.89, 2211.76, 18.5257, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 25, -1023.87, 2206.67, 15.177, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 26, -1003.5, 2198.92, 13.5018, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58237, 27, -983.176, 2187.15, 14.9128, 0, 0, 0, 0, 0);

SET @GUID := 58254;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58254, 1, -790.032, 1962.93, 45.3447, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 2, -809.198, 1923.56, 51.8344, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 3, -827.004, 1896.67, 59.7061, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 4, -849.344, 1879.82, 67.1254, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 5, -825.689, 1900.39, 58.7116, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 6, -808.322, 1925.15, 51.4201, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 7, -791.544, 1962.34, 45.315, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 8, -781.957, 1990.77, 40.2408, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 9, -773.231, 2018.09, 35.4392, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 10, -768.839, 2042.85, 30.9032, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 11, -772.551, 2061.69, 27.7752, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 12, -787.499, 2083.5, 23.6727, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 13, -823.745, 2089.21, 20.9182, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 14, -856.988, 2093.57, 22.2103, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 15, -886.28, 2099.46, 22.9353, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 16, -904.995, 2111.08, 21.1433, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 17, -922.803, 2128, 19.3213, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 18, -942.02, 2150.8, 16.5509, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 19, -959.78, 2164.99, 15.8987, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 20, -940.572, 2143.93, 17.6556, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 21, -918.177, 2118.69, 20.5409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 22, -899.606, 2102.69, 22.8781, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 23, -874.997, 2094.67, 23.1139, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 24, -850.269, 2093.94, 21.4416, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 25, -816.176, 2094.17, 20.135, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 26, -793.212, 2087.5, 22.6706, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 27, -781.01, 2077.79, 24.9176, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 28, -769.776, 2061.46, 28.0881, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 29, -765.403, 2038.76, 31.8703, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 30, -769.031, 2017.48, 36.0035, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58254, 31, -780.603, 1989.93, 40.5153, 0, 0, 0, 0, 0);

SET @GUID := 58628;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58628, 1, -1066.28, 2076.29, 65.2581, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 2, -1084.71, 2090.96, 64.0698, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 3, -1107.22, 2093.74, 67.0261, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 4, -1126.19, 2091.05, 67.6642, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 5, -1140.15, 2088.18, 67.046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 6, -1144.39, 2084.57, 66.9404, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 7, -1132.81, 2089.31, 67.6161, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 8, -1115.34, 2093.11, 67.5254, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 9, -1091.94, 2092.04, 65.1282, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 10, -1073.86, 2086.69, 63.2546, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 11, -1064.04, 2075.59, 65.6203, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58628, 12, -1064.26, 2062.38, 67.3094, 45000, 0, 0, 0, 0);

SET @GUID := 58636;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58636, 1, -989.995, 1941.95, 71.4595, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 2, -1008.41, 1959.06, 68.9236, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 3, -1019.71, 1969.1, 68.6018, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 4, -1026.27, 1974.99, 70.055, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 5, -1026.92, 1982.57, 69.3283, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 6, -1025.51, 1975.34, 69.8823, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 7, -1020.08, 1966.5, 68.308, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 8, -995.228, 1955.72, 69.9662, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 9, -978.143, 1924.37, 75.1594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 10, -971.913, 1906.66, 81.0091, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 11, -969.988, 1896.65, 85.587, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 12, -968.026, 1884.12, 93.5716, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 13, -968.339, 1894.25, 86.2747, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 14, -971.346, 1907.8, 80.164, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58636, 15, -978.063, 1919.93, 76.9127, 0, 0, 0, 0, 0);

SET @GUID := 58638;
UPDATE `creature` SET `MovementType`= 2 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58638, 1, -969.117, 1895.51, 85.8342, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 2, -979.002, 1893.24, 92.7384, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 3, -980.753, 1889.95, 94.2667, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 4, -969.104, 1893.87, 86.9405, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 5, -943.258, 1896.12, 76.5289, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 6, -927.465, 1904.29, 70.9232, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 7, -918.028, 1919.59, 67.2824, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 8, -912.198, 1930.65, 66.9439, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 9, -906.253, 1936.39, 66.9409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 10, -902.916, 1935.38, 66.9409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 11, -899.893, 1931.82, 66.9409, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 12, -904.32, 1933.33, 66.9409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 13, -909.279, 1931.34, 66.9409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 14, -923.102, 1907.03, 69.6799, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 15, -935.694, 1898.91, 74.0559, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58638, 16, -957.265, 1896.2, 79.8492, 0, 0, 0, 0, 0);

UPDATE `creature` SET `position_x` = '9512.21', `position_y` = '-6840.16', `position_z` = '16.4934', `orientation` = '1.0903', `spawndist` = '0', `MovementType` = '0' WHERE `guid` = 58702;

