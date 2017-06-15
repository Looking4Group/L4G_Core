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

