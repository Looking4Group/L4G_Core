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

