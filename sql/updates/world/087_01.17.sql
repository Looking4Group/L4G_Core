-- thx @Nuraya for pointing this one out
SET @GUID := 37071;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (37071, 3667, 1, 1, 1937, 0, 5681.28, 203.113, 26.7769, 3.03396, 275, 5, 0, 356, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (37071, 37071, 0, 16843008, 0, 4097, 0, 0, NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 1, 5680.94, 203.747, 26.8227, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 2, 5693.18, 202.087, 26.0062, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 3, 5690.8, 190.771, 26.2839, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 4, 5685.78, 175.918, 27.8643, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 5, 5681.24, 162.083, 29.161, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 6, 5676.4, 147.196, 29.9354, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 7, 5666.69, 139.036, 30.6115, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 8, 5650.47, 133.369, 30.8467, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 9, 5635.73, 131.037, 30.106, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 10, 5629.98, 125.184, 28.9908, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 11, 5619.66, 114.925, 26.7356, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 12, 5604.99, 121.417, 25.7667, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 13, 5598.24, 131.694, 26.6801, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 14, 5593.16, 144.531, 28.0487, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 15, 5591.96, 157.918, 28.2676, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 16, 5591.2, 172.062, 27.8291, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 17, 5599.89, 182.317, 28.2093, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 18, 5609.15, 192.019, 27.6733, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 19, 5621.33, 201.892, 26.0223, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 20, 5629.1, 212.851, 25.2154, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 21, 5634.12, 232.882, 24.327, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 22, 5627.68, 201.562, 25.9998, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 23, 5639.7, 199.106, 26.8455, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 24, 5652.64, 200.325, 26.9248, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (37071, 25, 5669.31, 202.233, 27.2184, 0, 0, 0, 0, 0);

-- Irradiated Invader 6213
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6213;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6213;
INSERT INTO `creature_ai_scripts` VALUES
('621301','6213','1','0','100','2','0','0','0','0','11','21862','0','1','11','9769','0','1','0','0','0','0','Irradiated Invader - Cast Radiation Visual and Radiation OOC'),
('621302','6213','9','0','100','3','0','25','3600','7200','11','9771','1','0','0','0','0','0','0','0','0','0','Irradiated Invader - Cast Radiation Bolt'),
('621303','6213','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Irradiated Invader - Flee at 15% HP (Out of Instance Only)'),
('621304','6213','6','0','100','2','0','0','0','0','1','-30','0','0','11','9798','0','7','0','0','0','0','Irradiated Invader - Emote and Cast Radiation on Death');

-- Irradiated Pillager 6329
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6329;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6329;
INSERT INTO `creature_ai_scripts` VALUES
('632901','6329','1','0','100','2','0','0','0','0','11','21862','0','1','11','9769','0','1','0','0','0','0','Irradiated Pillager - Cast Radiation Visual and Radiation OOC'),
('632902','6329','9','0','100','3','0','25','3600','7200','11','9771','1','0','0','0','0','0','0','0','0','0','Irradiated Pillager - Cast Radiation Bolt'),
('632903','6329','6','0','100','2','0','0','0','0','1','-30','0','0','11','9798','0','7','0','0','0','0','Irradiated Pillager - Emote and Cast Radiation on Death'),
('632904','6329','2','0','100','2','50','0','0','0','11','8269','0','1','1','-106','0','0','0','0','0','0','Irradiated Pillager - Cast Frenzy at 50% HP');

DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -33 AND -30;
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
('-30','blood sprays into the air!','0','2','0','Common Gnomeregan Emote','0'),
('-31','is splashed by the blood and becomes irradiated!','0','2','0','Common Gnomeregan Emote','0'),
('-32','Electric justice!','5811','1','0','6235','0'),
('-33','Warning! Warning! Intruder alert! Intruder alert!','0','1','0','7849','0');

-- Invis Legion Hold Caster
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `id` = 21403;
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 21403;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21403;
INSERT INTO `creature_ai_scripts` VALUES
(2140301, 21403, 1, 0, 100, 1, 1000, 1000, 4000, 4000, 11, 36804, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Invis Legion Hold Caster - Cast Electrical Shock OOC');

DELETE FROM `spell_script_target` WHERE `entry` = 36804;
INSERT INTO `spell_script_target` VALUES
(36804, 1, 21404);

DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9219 AND -9208;
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9399 AND -9301;
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9499 AND -9400;
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9699 AND -9603;
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9720 AND -9707;
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9794 AND -9790; 
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9847 AND -9830; 
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9856 AND -9850;   
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9874 AND -9860;  
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9896 AND -9880;   
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9956 AND -9950;
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-9900,-9930,-9931,-9990,-9991);

-- Reduce Plans: Copper Chain Vest Dropchance on Siltfin Murloc
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 17190 AND `item` = 3609;

-- ---------------------------------
-- [Quest]: How to Serve Goblins. ID: 10238
-- Solves https://github.com/Looking4Group/L4G_Core/issues/2932 when combined with corescript
-- ---------------------------------

-- Moh
UPDATE gameobject_template SET ScriptName = 'go_moh_cage' WHERE entry = 183940; 
UPDATE creature_template SET ScriptName = 'npc_moh' WHERE entry = 19764;
UPDATE creature SET spawntimesecs = 181 WHERE guid = 70700; -- 300

-- Jakk
UPDATE gameobject_template SET ScriptName = 'go_jakk_cage' WHERE entry = 183941;
UPDATE creature_template SET ScriptName = 'npc_jakk' WHERE entry = 19766;
UPDATE creature SET spawntimesecs = 181 WHERE guid = 70709; -- 300

-- Manni
UPDATE gameobject_template SET ScriptName = 'go_manni_cage' WHERE entry = 183936;
UPDATE creature_template SET ScriptName = 'npc_manni' WHERE entry = 19763;
UPDATE creature SET spawntimesecs = 181 WHERE guid = 70699; -- 300

DELETE FROM `script_texts` WHERE `entry` BETWEEN -1999972 AND -1999970;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES 
(-1999972, 'I thought I was a goner for sure.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 71, 'SAY_MOH'),
(-1999971, 'I don''t know which is worse, getting eaten by fel orcs or working for that slave master Razelcraz! Oh well, thanks anyways!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 66, 'SAY_JAKK'),
(-1999970, 'Thank goodness you got here, it was almost dinner time!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 70, 'SAY_MANNI');

-- Increase Spawndist due to stacked spawns w8ing for repopulation
UPDATE `creature` SET `spawndist` = 30 WHERE `id` BETWEEN 17325 AND 17330; -- 5

-- misplacement
UPDATE `creature` SET `position_x`='-3840.9509', `position_y`='3430.9916', `position_z`='325.1050', `orientation`='5.8567' WHERE `guid` = 3258602;

-- 7899,7901,7902
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -100 WHERE `item` = 9275; -- -100
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `item` = 4306 AND `entry` IN (7899,7901,7902); -- 2

UPDATE `creature` SET `orientation` = '5.06145' WHERE `guid` = 98243;
UPDATE `creature` SET `orientation` = '3.92699' WHERE `guid` = 98244;
UPDATE `gameobject` SET `orientation` = 0 WHERE `guid` = 3487154;

-- ReGUID
DELETE FROM `creature` WHERE `guid` IN (16134939,208042,16137217,49937,16139874,85627,16144916,32067,16148271,24670,16151603,57684,16279446,16279941,16280674,16685789,56327);
INSERT INTO `creature` VALUES (208042, 12197, 0, 1, 0, 105, -5045.62, -1266.26, 510.325, 5.29937, 25, 0, 0, 13000, 0, 0, 0);
INSERT INTO `creature` VALUES (49937, 5118, 1, 1, 0, 1182, 9986.19, 2310.25, 1330.79, 1.34439, 25, 0, 0, 5100, 0, 0, 0);
INSERT INTO `creature` VALUES (85627, 20119, 530, 1, 0, 0, -3963.17, -11346, -120.654, 3.43206, 25, 0, 0, 4800, 0, 0, 0);
INSERT INTO `creature` VALUES (32067, 347, 0, 1, 0, 838, 1333.51, 320.778, -63.7147, 2.8488, 25, 0, 0, 11000, 0, 0, 0);
INSERT INTO `creature` VALUES (24670, 7427, 1, 1, 0, 136, -1382.28, -79.0521, 160.518, 3.03226, 25, 0, 0, 4300, 0, 0, 0);
INSERT INTO `creature` VALUES (57684, 16695, 530, 1, 0, 0, 9850.71, -7572.28, 19.2497, 1.45743, 25, 0, 0, 4700, 0, 0, 0);
INSERT INTO `creature` VALUES (56327, 15691, 532, 1, 0, 0, -11117.8, -1867.36, 169.082, 3.75874, 604800, 0, 0, 1379160, 67740, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` IN (56327,16685789);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (56327,56327,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` IN (56327,2665340992);
INSERT INTO `waypoint_data` VALUES (56327, 1, -11169.2, -1908.89, 165.765, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (56327, 2, -11173.8, -1903.03, 165.765, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (56327, 3, -11193, -1878.27, 153.545, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (56327, 4, -11196.7, -1873.38, 153.55, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (56327, 5, -11192.7, -1878.62, 153.546, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (56327, 6, -11173.3, -1901.45, 165.646, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (56327, 7, -11168.4, -1907.62, 165.766, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (56327, 8, -11088.2, -1844.42, 165.767, 2500, 0, 0, 100, 0);
DELETE FROM `creature_linked_respawn` WHERE `linkedGUID` IN (56327,16685789);
INSERT INTO `creature_linked_respawn` VALUES (57176, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57177, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57178, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57179, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57180, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57181, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57183, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57184, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57185, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57187, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57206, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57207, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57208, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57209, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57210, 56327);
INSERT INTO `creature_linked_respawn` VALUES (57211, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85034, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85238, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85239, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85240, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85241, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85242, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85243, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85244, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85245, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85246, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85247, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85248, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85249, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85250, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85251, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85252, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85253, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85254, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85255, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85256, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85257, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85258, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85259, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85260, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85261, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85262, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85263, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85264, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85266, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85267, 56327);
INSERT INTO `creature_linked_respawn` VALUES (85268, 56327);
INSERT INTO `creature_linked_respawn` VALUES (56327, 56327);

-- Deathsworn Captain (Shadowfang Keep)(3872)
UPDATE `pool_creature` SET `chance` = 0 WHERE `guid` IN (657,99291);

DELETE FROM `creature` WHERE `guid` = 42593;
INSERT INTO `creature` VALUES (42593, 25369, 580, 1, 0, 0, 1757.44, 995.046, 16.0957, 0.715585, 604800, 0, 0, 240000, 0, 0, 0);

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (48044,84986,85004,85357,126600,134711,240198,240807,240957,240995,241085,241141,241960,242412,242681,242745,243224,244331,245098,16800046);
DELETE FROM `creature_linked_respawn` WHERE `linkedguid` IN (84387,84572,85780,85784,16777006,16777195);

DELETE FROM `creature` WHERE `guid` = 55353;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (55353, 15397, 530, 1, 0, 0, 8700.38, -6638.36, 72.8276, 5.51524, 300, 0, 0, 210, 0, 0, 0);

-- https://github.com/Looking4Group/L4G_Core/issues/634
-- http://hellfire-tbc.com/hellfire2/forums/showthread.php?tid=2477

-- ============
-- Black Temple
-- ============

-- ======================================================
-- Texts & Scripts
-- ======================================================

UPDATE `script_texts` SET `content_loc3`='Stellt eure Handlungen ein. Ihr werdet eleminiert werden!' WHERE `entry` = '-1000387';
UPDATE `script_texts` SET `content_loc3`='Akama. Euer falsches Spiel überrascht mich nicht. Ich hätte Euch und Eure missgestalteten Brüder schon vor langer Zeit abschlachten sollen.' WHERE `entry` = '-1999998';  
UPDATE `script_texts` SET `content_loc3`='Erzittert vor der Macht des Dämonen!' WHERE `entry` = '-1999996';
UPDATE `script_texts` SET `content_loc3`='Blickt in die Augen des Verräters!' WHERE `entry` = '-1999995';
UPDATE `script_texts` SET `content_loc3`='Spürt die Flammen von Azzinoth!' WHERE `entry` = '-1999994';
UPDATE `script_texts` SET `content_loc3`='Gesindel! Keiner von Euch wird je Hand an mich legen!' WHERE `entry` = '-1999993';
UPDATE `script_texts` SET `content_loc3`='Viel zu einfach!' WHERE `entry` = '-1999992';
UPDATE `script_texts` SET `content_loc3`='Wer möchte nun meine Klingen schmecken?!' WHERE `entry` = '-1999991';
UPDATE `script_texts` SET `content_loc3`='Ich werde mich um diese Bastarde kümmern! Schlagt zu, Freunde! Greift den Verräter an!' WHERE `entry` = '-1999990';
UPDATE `script_texts` SET `content_loc3`='Kommt, meine Diener. Gebt diesem Verräter, was er verdient.' WHERE `entry` = '-1999989';
UPDATE `script_texts` SET `content_loc3`='Seid vorsichtig, Freunde. Der Verräter verweilt im Hof direkt vor uns.' WHERE `entry` = '-1999988'; 
UPDATE `script_texts` SET `content_loc3`='Das Licht wird diese trostlosen Hallen erneut erfüllen... Das schwöre Ich!' WHERE `entry` = '-1529011'; 
UPDATE `script_texts` SET `content_loc3`='Er hat Recht. Ich fühle nichts... Ich bin... nichts... Lebt Wohl, Ihr Helden.' WHERE `entry` = '-1529010';
UPDATE `script_texts` SET `content_loc3`='Ihr habt gewonnen... Maiev. Aber die Jägerin... ist nichts ohne die Beute. Ihr... seid nichts... ohne mich.' WHERE `entry` = '-1529009';
UPDATE `script_texts` SET `content_loc3`='Es ist vollbracht. Ihr seid geschlagen.' WHERE `entry` = '-1529008';  
UPDATE `script_texts` SET `content_loc3`='Spürt den Hass von zehntausend Jahren!' WHERE `entry` = '-1529007';    
UPDATE `script_texts` SET `content_loc3`='Endlich ist meine lange Jagd zu Ende. Heute wird die Gerechtigkeit obsiegen!' WHERE `entry` = '-1529006';
UPDATE `script_texts` SET `content_loc3`='Maiev... Wie kann das sein...?' WHERE `entry` = '-1529005';
UPDATE `script_texts` SET `content_loc3`='Ihr Zorn ist nichts im Vergleich zu dem meinen, Illidan. Wir beide haben noch eine Rechnung offen.' WHERE `entry` = '-1529004';
UPDATE `script_texts` SET `content_loc3`='War\'s das schon, Sterbliche? Ist das alles, was Ihr zu bieten habt?' WHERE `entry` = '-1529003';
UPDATE `script_texts` SET `content_loc3`='Ihr wisst nicht, was Euch erwartet!' WHERE `entry` = '-1529002';
UPDATE `script_texts` SET `content_loc3`='Die Zeit ist gekommen, der Augenblick ist endlich da!' WHERE `entry` = '-1529001';
UPDATE `script_texts` SET `content_loc3`='Gewagte Worte. Und doch bin ich... unbeeindruckt.' WHERE `entry` = '-1529000';
UPDATE `script_texts` SET `content_loc3`='Wir sind hier um Eure Herrschaft zu beenden, Illidan. Mein Volk und die gesamte Scherbenwelt werden frei sein!' WHERE `entry` = '-1529099';
UPDATE `script_texts` SET `content_loc3`='Dieses Mal gibt es kein Gefängnis für Euch!' WHERE `entry` = '-1529022';
UPDATE `script_texts` SET `content_loc3`='Blutet wie Ich geblutet habe!' WHERE `entry` = '-1529021';
UPDATE `script_texts` SET `content_loc3`='Das ist für Naisha!' WHERE `entry` = '-1529020';
UPDATE `script_texts` SET `content_loc3`='Ihr wisst nicht was Macht bedeutet!' WHERE `entry` = '-1529018';
UPDATE `script_texts` SET `content_loc3`='Gebt euren Ängsten nach!' WHERE `entry` = '-1529017';
UPDATE `script_texts` SET `content_loc3`=' Ich danke Euch für Eure Hilfe, Brüder. Unser Volk wird erlöst werden!' WHERE `entry` = '-1309028';
UPDATE `script_texts` SET `content_loc3`='Euer Volk wird immer mit Euch sein!' WHERE `entry` = '-1309027';
UPDATE `script_texts` SET `content_loc3`='Ihr seid nicht allein, Akama.' WHERE `entry` = '-1309026';      
UPDATE `script_texts` SET `content_loc3`='Diese Tür ist alles, was zwischen uns und dem Verräter steht. Tretet beiseite, Freunde.' WHERE `entry` = '-1309025';
UPDATE `script_texts` SET `content_loc3`='Ich schaffe das nicht allein...' WHERE `entry` = '-1309024';

-- ============================
-- Spawns & Pooling
-- ============================

DELETE FROM `creature` WHERE `guid` IN (53823,53926,53929,53948,240957,240995,241085,241141,242681,242745);
DELETE FROM `creature` WHERE `guid` IN (246422,246423);
INSERT INTO `creature` VALUES (246422, 23374, 564, 1, 0, 0, 631.877258, 251.739273, 112.665802, 3.0788, 7200, 0, 0, 215979, 0, 0, 0);
INSERT INTO `creature` VALUES (246423, 23374, 564, 1, 0, 0, 774.256470, 250.553162, 112.735138, 0.1076, 7200, 0, 0, 215979, 0, 0, 0);

-- free 52466 52467 52468 52469 52470 52478 53802 53803 53804 53805 53806 53807 53808 53810 53811 53812 53813 53814 53823 53919 53920 53921 53922 53923 53924 53925 53926 53927 53928 53929 53939 53940 53944 53945 53946 53947 53948 53949 53950 53952 53956 53974 53975 53976 53977 53978 

-- unused
-- INSERT INTO `creature` VALUES (52466, XXX, 564, 1, 0, 0, XXX, YYY, ZZZ, OOO, 7200, 0, 0, 0, 0, 0, 0);
-- INSERT INTO `creature` VALUES (52467, XXX, 564, 1, 0, 0, XXX, YYY, ZZZ, OOO, 7200, 0, 0, 0, 0, 0, 0);

-- already 2 with lower guid, but pos looks better on these.
-- INSERT INTO `creature` VALUES (52502, 23448, 564, 1, 0, 0, 678.06, 285.22, 354.325, 3.29867, 3600, 0, 0, 3079, 0, 0, 0);
-- INSERT INTO `creature` VALUES (52503, 23448, 564, 1, 0, 0, 676.226, 325.231, 354.319, 3.12414, 3600, 0, 0, 3079, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (12754,12841,12758,12776,12814,12819,12886,39926,39928,40233,40243,40244,40407,42920,52461,52484,52754,52768,52769,52846,53054,53211,53212,53796,53797,53798,53799,53800,53801,53821,53827,53828,53829,53831,53907,53909,53915,126600,244331,245098,16777200,16777194,16777195);

INSERT INTO `creature` VALUES (12754, 22881, 564, 1, 0, 0, 451.222992, 808.208008, 12.127271, 3.909540, 7200, 0, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (12841, 22881, 564, 1, 0, 0, 436.329010, 793.070007, 12.044035, 0.837758, 7200, 0, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (12758, 23339, 564, 1, 0, 517, 723.369, 430.184, 112.739, 1.6717, 3600, 0, 0, 215430, 0, 0, 0);
INSERT INTO `creature` VALUES (12776, 23089, 564, 1, 0, 1679, 757.5, 239.638, 353.281, 2.26385, 300, 0, 0, 1001550, 607000, 0, 0);
INSERT INTO `creature` VALUES (12814, 22849, 564, 1, 0, 0, 488.521, 395.2, 112.784, 3.26497, 10800, 0, 0, 102000, 0, 0, 0);
INSERT INTO `creature` VALUES (12819, 22849, 564, 1, 0, 0, 488.885, 407.437, 112.784, 3.22492, 10800, 0, 0, 102000, 0, 0, 0);
INSERT INTO `creature` VALUES (12886, 23394, 564, 1, 0, 0, 622.994, 126.932, 254.169, 3.17459, 3600, 5, 0, 464940, 0, 0, 2);
INSERT INTO `creature` VALUES (39926, 23398, 564, 1, 0, 0, 538.471, 51.5336, 112.967, 4.92016, 30, 5, 0, 3912, 3155, 0, 1);
INSERT INTO `creature` VALUES (39928, 23398, 564, 1, 0, 0, 513.068, 64.5998, 112.745, 6.27078, 30, 5, 0, 3912, 3155, 0, 1);
INSERT INTO `creature` VALUES (40233, 23398, 564, 1, 0, 0, 562.506, 94.6764, 112.695, 2.37427, 30, 5, 0, 3912, 3155, 0, 1);
INSERT INTO `creature` VALUES (40243, 23398, 564, 1, 0, 0, 617.138, 84.3218, 112.394, 6.19269, 30, 5, 0, 3912, 3155, 0, 1);
INSERT INTO `creature` VALUES (40244, 23398, 564, 1, 0, 0, 543.152, 82.0115, 113.121, 1.26602, 30, 5, 0, 3912, 3155, 0, 1);
INSERT INTO `creature` VALUES (40407, 23398, 564, 1, 0, 0, 605.794, 62.7557, 111.802, 4.54002, 30, 5, 0, 3912, 3155, 0, 1);
INSERT INTO `creature` VALUES (42920, 23399, 564, 1, 0, 0, 595.844, 41.3876, 112.717, 2.51799, 30, 5, 0, 49585, 66180, 0, 1);
INSERT INTO `creature` VALUES (52461, 23412, 564, 1, 0, 0, 771.637, 304.536, 315.156, 3.12414, 3600, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (52484, 22917, 564, 1, 0, 442, 701.94,    307.019,    354.27, 0.73, 604800, 0, 0, 6070400, 0, 0, 0);
INSERT INTO `creature` VALUES (52754, 22946, 564, 1, 0, 0, 525.3706, 144.4366, 164.7709, 3.1980, 7200, 5, 0, 50267, 0, 0, 0);
INSERT INTO `creature` VALUES (52768, 22954, 564, 1, 0, 0, 635.48, 715.718, 73.3794, 3.20803, 7200, 30, 0, 387450, 0, 0, 1);
INSERT INTO `creature` VALUES (52769, 22954, 564, 1, 0, 0, 744.237, 691.116, 71.9755, 0.055227, 7200, 30, 0, 387450, 0, 0, 1);
INSERT INTO `creature` VALUES (52846, 22956, 564, 1, 0, 0, 812.467, 489.963, 183.293, 4.69698, 3600, 5, 0, 206605, 33090, 0, 2);
INSERT INTO `creature` VALUES (53054, 22964, 564, 1, 19199, 0, 833.48, 523.838, 165.731, 4.69426, 3600, 5, 0, 295150, 33090, 0, 2);
INSERT INTO `creature` VALUES (53211, 23232, 564, 1, 0, 0, 808.419, 107.089, 112.659, 0.92698, 7200, 5, 0, 100534, 0, 0, 1);
INSERT INTO `creature` VALUES (53212, 23232, 564, 1, 0, 0, 797.713, 119.231, 112.187, 3.52653, 7200, 5, 0, 100534, 0, 0, 1);
INSERT INTO `creature` VALUES (53796, 23018, 564, 1, 0, 0, 434.989, 261.706, 172.368, 4.70618, 7200, 0, 0, 200000, 64620, 0, 0);
INSERT INTO `creature` VALUES (53797, 23018, 564, 1, 0, 0, 439.994, 262.253, 172.612, 4.70577, 7200, 0, 0, 200000, 64620, 0, 0);
INSERT INTO `creature` VALUES (53798, 23018, 564, 1, 0, 0, 458.21, 170.244, 163.981, 6.27262, 7200, 0, 0, 200000, 64620, 0, 0);
INSERT INTO `creature` VALUES (53799, 23018, 564, 1, 0, 0, 436.145, 170.477, 163.981, 4.62763, 7200, 0, 0, 200000, 64620, 0, 0);
INSERT INTO `creature` VALUES (53800, 23018, 564, 1, 0, 0, 563.892, 110.831, 148.604, 3.12589, 7200, 0, 0, 200000, 64620, 0, 0);
INSERT INTO `creature` VALUES (53801, 23018, 564, 1, 0, 0, 586.709, 110.746, 139.313, 3.15837, 7200, 0, 0, 200000, 64620, 0, 0);
INSERT INTO `creature` VALUES (53821, 23028, 564, 1, 0, 0, 623.037, 970.488, 56.0675, 5.46771, 3600, 5, 0, 120624, 32310, 0, 1);
INSERT INTO `creature` VALUES (53827, 23030, 564, 1, 0, 0, 586.461, 877.008, 184.506, 1.56462, 3600, 5, 0, 140728, 32310, 0, 1);
INSERT INTO `creature` VALUES (53828, 23030, 564, 1, 0, 0, 671.666, 851.845, 184.506, -3.12458, 3600, 5, 0, 140728, 32310, 0, 1);
INSERT INTO `creature` VALUES (53829, 23030, 564, 1, 0, 0, 613.381, 861.349, 184.506, 3.2175, 3600, 5, 0, 140728, 32310, 0, 1);
INSERT INTO `creature` VALUES (53831, 23030, 564, 1, 0, 0, 782.901, 826.758, 157.837, 2.88201, 3600, 5, 0, 140728, 32310, 0, 1);
INSERT INTO `creature` VALUES (53907, 23030, 564, 1, 0, 0, 619.52, 736.459, 181.093, 0.897722, 3600, 5, 0, 140728, 32310, 0, 1);
INSERT INTO `creature` VALUES (53909, 23030, 564, 1, 0, 0, 630.91, 721.643, 181.093, 0.960804, 3600, 5, 0, 140728, 32310, 0, 1);
INSERT INTO `creature` VALUES (53915, 23030, 564, 1, 21543, 0, 676.9092, 741.6328, 98.4910, -2.51146, 3600, 5, 0, 201040, 32310, 0, 1);

-- ======================================================
-- NPC Research
-- Trash /1.75
-- ======================================================

-- Toad (1420) - NSR
-- Snake (2914) - NSR
-- Giant Surf Glider (5432) - NSR
-- Spider (14881) - NSR
-- Mechanical Greench (15721) - NSR

-- Ashtongue Battlelord 22844- mob_ashtongue_battlelord
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22844;
UPDATE `creature_template` SET `mindmg`='11485',`maxdmg`='13542',`speed` = '1.48', `lootid` = 22844 WHERE `entry` = 22844; -- 5900 9500 -- 20,099 - 23,699
DELETE FROM `creature_template_addon` WHERE `entry` = 22844;
INSERT INTO `creature_template_addon` VALUES (22844, 0, 0, 16777472, 0, 4097, 0, 0, '');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22844;
INSERT INTO `creature_onkill_reputation` VALUES (22844, 1012, 0, 7, 0, 15, 0, 0, 0, 0);
UPDATE `creature_model_info` SET `modelid_other_gender`= 0 WHERE `modelid` = 21115; -- 21118

-- Ashtongue Mystic 22845- mob_ashtongue_mystic
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22845;
UPDATE `creature_template` SET `speed` = '1.48',`mindmg`='6835',`maxdmg`='7263',`lootid` = '22845',`mechanic_immune_mask`='125709185',`flags_extra`='4259840' WHERE `entry` = 22845; -- 4201 4951 -- 11,961 - 12,711
DELETE FROM `creature_template_addon` WHERE `entry` = 22845;
INSERT INTO `creature_template_addon` VALUES (22845, 0, 0, 512, 0, 4097, 0, 0,'');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22845;
INSERT INTO `creature_onkill_reputation` VALUES (22845, 1012, 0, 7, 0, 15, 0, 0, 0, 0);

-- #define NPC_CYCLONE_TOTEM           22894
-- #define NPC_ASHTONGUE_SEARING_TOTEM 22896
-- #define NPC_SUMMONED_WINDFURY_TOTEM 22897

-- Ashtongue Stormcaller 22846- mob_ashtongue_stormcaller
-- Ashtongue Stormcaller - Summon Storm Fury on Spawn so always has one!
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22846;
UPDATE `creature_template` SET `modelid_A2`='0',`modelid_H2`='0',`speed`='1.48',`mindmg`='5399',`maxdmg`='6085',`lootid`='22846',`mechanic_immune_mask`='125709185' WHERE `entry` = 22846; -- 2551 3751 -- 9,449 - 10,649
DELETE FROM `creature_template_addon` WHERE `entry` = 22846;
INSERT INTO `creature_template_addon` VALUES (22846, 0, 0, 512, 0, 4097, 0, 0, '41151 0');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22846;
INSERT INTO `creature_onkill_reputation` VALUES (22846, 1012, 0, 7, 0, 15, 0, 0, 0, 0);
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid` = 21118; -- 21115

-- Ashtongue Primalist 22847- mob_ashtongue_primalist
-- 39584 not breakable by damage, otherwise instantly broken, doesnt make sense
-- Spell 39535 Summon Feral Spirit no movement 
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22847;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8663',`maxdmg`='10163',`lootid`='22847',`mechanic_immune_mask`='648232951',`flags_extra`='4259840' WHERE `entry` = 22847; -- 3751 6376 -- 15,160 - 17,785
DELETE FROM `creature_template_addon` WHERE `entry` = 22847;
INSERT INTO `creature_template_addon` VALUES (22847, 0, 0, 512, 0, 4097, 0, 0, '');	
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22847;
INSERT INTO `creature_onkill_reputation` VALUES (22847, 1012, 0, 7, 0, 15, 0, 0, 0, 0);
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid` = 21117; -- 20422

-- Storm Fury 22848- mob_storm_fury
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22848;
UPDATE `creature_template` SET `armor`='5800',`speed`='1.48',`mindmg`='4122',`maxdmg`='5172',`baseattacktime`='1400',`mechanic_immune_mask`='1073588143' WHERE `entry` = 22847; -- 3001 4051 2000 -- 4,122 - 5,172
DELETE FROM `creature_template_addon` WHERE `entry` = 22848;
INSERT INTO `creature_template_addon` VALUES (22848, 0, 0, 512, 0, 4097, 0, 0, '');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22848;
INSERT INTO `creature_onkill_reputation` VALUES (22848, 1012, 0, 5, 0, 3, 0, 0, 0, 0);   

-- Ashtongue Feral Spirit 22849- mob_ashtongue_feral_spirit
-- insanly hugh aggro radius
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` = 22849;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4682',`maxdmg`='5539',`mechanic_immune_mask`='662569871' WHERE `entry` = 22849; -- 2251 3751 -- 8,193 - 9,693
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22849;
INSERT INTO `creature_onkill_reputation` VALUES (22849, 1012, 0, 15, 0, 7, 0, 0, 0, 0);

-- Illidari Defiler 22853- mob_illidari_defiler
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22853;
UPDATE `creature_template` SET `mindmg`='6149',`maxdmg`='7221',`mechanic_immune_mask`='787038035' WHERE `entry` = 22853; -- 3001 4876 -- 10,761 - 12,636
DELETE FROM `creature_template_addon` WHERE `entry` = 22853;
INSERT INTO `creature_template_addon` VALUES (22853, 0, 0, 512, 0, 4097, 0, 0, '39839 0');

-- Illidari Nightlord 22855- mob_illidari_nightlord
UPDATE `creature` SET `modelid` = 0, `spawndist` = 0, `spawntimesecs` = 7200 WHERE `id` = 22855;
UPDATE `creature_template` SET `mindmg`='12895',`maxdmg`='15895',`mechanic_immune_mask`='805257207',`flags_extra`='1078001664' WHERE `entry` = 22855; -- 6001 11251 -- 22,566 - 27,816
DELETE FROM `creature_template_addon` WHERE `entry` = 22855;
INSERT INTO `creature_template_addon` VALUES (22855, 0, 0, 16777472, 0, 4097, 0, 0, '');

-- Illidari Boneslicer 22869- mob_illidari_boneslicer
UPDATE `creature` SET `modelid` = 0, `spawndist` = 0, `spawntimesecs` = 7200 WHERE `id` = 22869;
UPDATE `creature_template` SET `speed` = 1.71,`mindmg`='5707',`maxdmg`='7122',`mechanic_immune_mask`='787038035' WHERE `entry` = 22869; -- 2551 5026 -- 9,988 - 12,463
DELETE FROM `creature_template_addon` WHERE `entry` = 22869;
INSERT INTO `creature_template_addon` VALUES (22869, 0, 0, 16777472, 0, 4097, 0, 0, '');	

-- Coilskar General 22873- mob_coilskar_general
UPDATE `creature` SET `modelid` = 0, `spawndist` = 0, `spawntimesecs` = 7200 WHERE `id` = 22873;
UPDATE `creature_template` SET `modelid_A2`= 21160,`modelid_H2` = 21160,`speed` = 1.71,`mindmg`='12742',`maxdmg`='14557',`mechanic_immune_mask`='788512759' WHERE `entry` = 22873; -- 2776 5951 -- 22,299 - 25,474
DELETE FROM `creature_template_addon` WHERE `entry` = 22873;
INSERT INTO `creature_template_addon` VALUES (22873, 0, 0, 16777472, 0, 4097, 0, 0, '');

-- Coilskar Harpooner 22874- mob_coilskar_harpooner
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22874;
DELETE FROM `creature_template_addon` WHERE `entry` = 22874;
INSERT INTO `creature_template_addon` VALUES (22874, 0, 0, 512, 0, 4097, 0, 0, '');	
UPDATE `creature_template` SET `speed` = 1.71, `mindmg`='7370',`maxdmg`='8527' WHERE `entry` = 22874; -- 4276 6300 -- 12,898 - 14,922
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 3 WHERE `creature_id` = 22874;

-- Coilskar Sea-Caller 22875- mob_coilskar_seacaller
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22875;
UPDATE `creature_template` SET `modelid_A2`='21163',`modelid_H2`='21163',`speed` = 1.71,`mindmg`='4806',`maxdmg`='5706',`mechanic_immune_mask`='67125063' WHERE `entry` = 22875; -- 1513 3087 -- 8,411 - 9,985
DELETE FROM `creature_template_addon` WHERE `entry` = 22875;
INSERT INTO `creature_template_addon` VALUES (22875, 0, 0, 66048, 0, 4097, 0, 0, '');	

-- Coilskar Soothsayer 22876- mob_coilskar_soothsayer
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22876;
UPDATE `creature_template` SET `speed` = 1.71,`mindmg`='5973',`maxdmg`='6087',`mechanic_immune_mask`='10241' WHERE `entry` = 22876; -- 3555 3755 -- 10,453 - 10,653
DELETE FROM `creature_template_addon` WHERE `entry` = 22876;
INSERT INTO `creature_template_addon` VALUES (22876, 0, 0, 66048, 0, 4097, 0, 0, '');

-- Coilskar Wrangler 22877- mob_coilskar_wrangler
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22877;
UPDATE `creature_template` SET `modelid_A2`='21166',`modelid_H2`='21166',`speed` = 1.71,`mindmg`='10362',`maxdmg`='10939' WHERE `entry` = 22877; -- 5200 6210 -- 18,134 - 19,144
DELETE FROM `creature_template_addon` WHERE `entry` = 22877;
INSERT INTO `creature_template_addon` VALUES (22877, 0, 0, 512, 0, 4097, 0, 0, '');

-- Aqueous Lord 22878- mob_aqueous_lord
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22878;
UPDATE `creature_template` SET `speed` = 1.71, `mindmg`='7929',`maxdmg`='8294',`flags_extra` = 1074069536 WHERE `entry` = 22878; -- 3938 4576 -- 13,876 - 14,514
DELETE FROM `creature_template_addon` WHERE `entry` = 22878;
INSERT INTO `creature_template_addon` VALUES (22878, 0, 0, 16908544, 0, 4097, 0, 0, '18950 0');

-- Shadowmoon Reaver 22879- mob_shadowmoon_reaver
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0, `MovementType` = 0 WHERE `id` = 22879;
UPDATE `creature_template` SET `speed` = 1.48,`mindmg`='9542',`maxdmg`='12751',`mechanic_immune_mask`='10497' WHERE `entry` = 22879; -- 4394 10009 -- 16,699 - 22,314
DELETE FROM `creature_template_addon` WHERE `entry` = 22879;
INSERT INTO `creature_template_addon` VALUES (22879, 0, 0, 16777472, 0, 4097, 375, 0, '');	

-- Shadowmoon Champion 22880- mob_shadowmoon_champion
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22880;
UPDATE `creature_template` SET `modelid_A2`='21368',`modelid_H2`='21368',`speed` = 1.71, `mindmg`='9319',`maxdmg`='14318', `flags_extra` = 1073807360 WHERE `entry` = 22880; -- 2109 10857 -- 16,308 - 25,056
DELETE FROM `creature_template_addon` WHERE `entry` = 22880;
INSERT INTO `creature_template_addon` VALUES (22880, 0, 0, 16777472, 0, 4097, 375, 0, '');	

-- Aqueous Surger 22881
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` = 22881;
UPDATE `creature_template` SET `speed` = '1.48',`mindmg`='3376',`maxdmg`='4126',`mechanic_immune_mask`='11265' WHERE `entry` = 22881; -- 3376 4126 -- 11,604 - 12,354 elemental
DELETE FROM `creature_template_addon` WHERE `entry` = 22881;
INSERT INTO `creature_template_addon` VALUES (22881, 0, 0, 16908544, 0, 4097, 0, 0, '');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22881;
INSERT INTO `creature_ai_scripts` VALUES
('2288101','22881','9','0','100','3','0','55','13000','18000','11','40095','1','0','0','0','0','0','0','0','0','0','Aqueous Surger - Cast Poison Bolt Volley');

-- Shadowmoon Deathshaper 22882- mob_shadowmoon_deathshaper
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22882;
UPDATE `creature_template` SET `speed` = 1.48, `mindmg`='6646',`maxdmg`='8247',`mechanic_immune_mask`='100673793' WHERE `entry` = 22882; -- 3732 6534 -- 11,631 - 14,433
DELETE FROM `creature_template_addon` WHERE `entry` = 22882;
INSERT INTO `creature_template_addon` VALUES (22882, 0, 0, 512, 0, 4097, 0, 0, '13787 0');

-- Shadowmoon Fallen 23371
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`speed`='1.20',`mindmg`='5070',`maxdmg`='7013',`mechanic_immune_mask`='8398929' WHERE `entry` = 23371; -- 1900 5300 -- 8,873 - 12,273

-- Aqueous Spawn 22883- mob_aqueous_spawn
-- add Zcheck = 5000; to SludgeNova to prevent spell cancel
UPDATE `creature` SET `spawntimesecs` = 1200 WHERE `id` = 22883; 
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='3333',`maxdmg`='3632',`mechanic_immune_mask`='10241' WHERE `entry` = 22883; -- 2.5 1262 1785 -- 5,833 - 6,356 elemental
DELETE FROM `creature_template_addon` WHERE `entry` = 22883;
INSERT INTO `creature_template_addon` VALUES (22883, 0, 0, 16908544, 0, 4097, 0, 0, '');

-- Leviathan 22884- mob_leviathan
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22884;
UPDATE `creature_template` SET `speed` = 1.71, `mindmg`='10673',`maxdmg`='11422',`mechanic_immune_mask`='650854143',`flags_extra`='1078001664' WHERE `entry` = 22884; -- 5900 7210 -- 18,678 - 19,988
DELETE FROM `creature_template_addon` WHERE `entry` = 22884;
INSERT INTO `creature_template_addon` VALUES (22884, 0, 0, 16908544, 0, 4097, 0, 0, '');

-- Dragon Turtle 22885- mob_dragon_turtle
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22885;
UPDATE `creature_template` SET `speed` = 1.48, `mindmg`='10045',`maxdmg`='10259',`mechanic_immune_mask`='11265' WHERE `entry` = 22885; -- 6151 6526 -- 17,579 - 17,954
DELETE FROM `creature_template_addon` WHERE `entry` = 22885;
INSERT INTO `creature_template_addon` VALUES (22885, 0, 0, 16908544, 0, 4097, 0, 0, '');	
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22885;
INSERT INTO `creature_onkill_reputation` VALUES (22885, 1012, 0, 7, 0, 15, 0, 0, 0, 0);

-- Greater Shadowfiend 22929
UPDATE `creature_template` SET `minhealth`='4400',`maxhealth`='4400',`speed` = 1.20,`mindmg`='415',`maxdmg`='645' WHERE `entry` = 22929; -- 2900 1 -- 18 248 -- 415 - 645

-- Temple Concubine 22939- mob_temple_concubine
-- 29k hp?
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22939; -- Emotes 1 10 69
UPDATE `creature_template` SET `modelid_A`='21449',`modelid_H`='21449',`modelid_A2`='21451',`modelid_H2`='21451', `armor` = 6200,`speed` = 1.48, `mindmg`='885',`maxdmg`='999', `mechanic_immune_mask`='67124289' WHERE `entry` = 22939; -- 612 812 -- 1,548 - 1,748
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 3 WHERE `creature_id` = 22939; -- 15

-- Shadowmoon Blood Mage 22945- mob_shadowmoon_blood_mage
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22945;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='6646',`maxdmg`='8476',`mechanic_immune_mask`='100673793' WHERE `entry` = 22945; -- 3732 6934 -- 11,631 - 14,833

-- Shadowmoon War Hound 22946
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0, `MovementType` = 0 WHERE `id` = 22946;
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='3825',`maxdmg`='4543' WHERE `entry` = 22946; -- 687 1405 -- 3,825 - 4,543
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22946;
INSERT INTO `creature_onkill_reputation` VALUES (22946, 1012, 0, 7, 0, 3, 0, 0, 0, 0);

-- Wrathbone Flayer 22953- mob_wrathbone_flayer
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22953;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='12761',`maxdmg`='16659',`flags_extra`='1073807360' WHERE `entry` = 22953; -- 6062 12884 -- 22,331 - 29,153

-- Illidari Fearbringer 22954- mob_illidari_fearbringer
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22954;
UPDATE `creature_template` SET `mindmg`='10943',`maxdmg`='12829',`mechanic_immune_mask`='1073725439',`flags_extra`='1078001664' WHERE `entry` = 22954; -- 4951 8251 -- 19,150 - 22,450

-- Charming Courtesan 22955- mob_charming_courtesan
-- emote 1 10 69
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 22955;
UPDATE `creature_template` SET `modelid_A`='21452',`modelid_H`='21452',`modelid_A2`='21454',`modelid_H2`='21454',`speed`='1.10',`mindmg`='1353',`maxdmg`='1574',`mechanic_immune_mask`='67185729' WHERE `entry` = 22955; -- 672 1059 -- 2,368 - 2,755
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 3 WHERE `creature_id` = 22955; -- 15

-- Sister of Pain 22956- mob_sister_of_pain
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22956;
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (52848,52850,52855);
-- http://www.wowhead.com/npc=22956 http://wowwiki.wikia.com/wiki/Sister_of_Pain
UPDATE `creature_template` SET `speed` = 1.71, `mindmg`='12030',`maxdmg`='14889', `mechanic_immune_mask` = 650854259, `flags_extra` = 1078001664 WHERE `entry` = 22956; -- 7887 12890 -- 21,052 - 26,055

-- Sister of Pleasure 22964- mob_sister_of_pleasure
-- http://www.wowhead.com/npc=22964 http://wowwiki.wikia.com/wiki/Sister_of_Pleasure
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22964;
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (53054,53055,53058);
UPDATE `creature_template` SET `speed` = 1.71, `mindmg`='11458',`maxdmg`='13746', `mechanic_immune_mask` = 617299967, `flags_extra` = 1078001664 WHERE `entry` = 22964; -- 6887 10890 -- 20,052 - 24,055

-- Priestess of Dementia 22957
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22957;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='10366',`maxdmg`='14007',`mechanic_immune_mask`='113982939',`flags_extra`='1073807360' WHERE `entry` = 22957; -- 6731 13104 -- 18,140 - 24,513

-- Spellbound Attendant 22959- mob_spellbound_attendent
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22959;
UPDATE `creature_template` SET `modelid_A`='21530',`modelid_H`='21530',`modelid_A2`='21532',`modelid_H2`='21532',`speed`='1.48',`mindmg`='8254',`maxdmg`='9691',`mechanic_immune_mask`='67124289' WHERE `entry` = 22959; -- 3418 5933 -- 14,444 - 16,959

-- Dragonmaw Wyrmcaller 22960- mob_dragonmaw_wyrmcaller
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 22960;
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (52872,52873,52889,52902); 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='10498',`maxdmg`='11441',`mechanic_immune_mask`='788217811',`flags_extra`='1078001664' WHERE `entry` = 22960; -- 6301 7951 -- 18,372 - 20,022

-- Priestess of Delight 22962- mob_pristess_of_delight
UPDATE `creature` SET `modelid` = 21502, `spawntimesecs` = 7200 WHERE `id` = 22962;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='14725',`maxdmg`='19238',`mechanic_immune_mask`='113982811',`flags_extra`='1073807360' WHERE `entry` = 22962; -- 8731 16629 -- 25,769 - 33,667

-- Bonechewer Worker 22963- mob_bonechewer_worker
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 7200 WHERE `id` = 22963;
UPDATE `creature_template` SET `modelid_A`='21535',`modelid_H`='21535',`modelid_A2`='21537',`modelid_H2`='21537',`speed`='1.48',`mindmg`='1218',`maxdmg`='1227',`mechanic_immune_mask`='75795' WHERE `entry` = 22963; -- 436 451 -- 2,132 - 2,147

-- Enslaved Servant 22965- mob_enslaved_servant
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 0, `spawndist` = 0, `MovementType` = 0 WHERE `id` = 22965;
UPDATE `creature_template` SET `modelid_A`='21196',`modelid_H`='21196',`modelid_A2`='21528',`modelid_H2`='21528',`speed`='1.00',`mindmg`='9714',`maxdmg`='10751',`mechanic_immune_mask`='67124289' WHERE `entry` = 22965; -- 4694 6509 -- 16,999 - 18,814        

-- Shadowmoon Houndmaster 23018- mob_shadowmoon_houndmaster
-- http://wowwiki.wikia.com/wiki/Shadowmoon_Houndmaster?direction=next&oldid=1320513
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='10154',`maxdmg`='13270',`minrangedmg`='4000',`maxrangedmg`='8000',`flags_extra`='536870912' WHERE `entry` = 23018; -- 4836 10288 0 0-- 17,770 - 23,222
-- UPDATE `creature_template_addon` SET `mount`='' WHERE `entry` IN (''); -- 14334

-- Bonechewer Taskmaster 23028- mob_bonechewer_taskmaster
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 7200 WHERE `id` = 23028; 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='7199',`maxdmg`='8913',`mechanic_immune_mask`='646004703' WHERE `entry` = 23028; -- 2251 5251 -- 12,598 - 15,598
DELETE FROM `creature_template_addon` WHERE `entry` = 23028;
INSERT INTO `creature_template_addon` VALUES (23028, 0, 0, 16908544, 0, 4097, 0, 0, '');

-- Dragonmaw Sky Stalker 23030- mob_dragonmaw_skystalker
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23030;
UPDATE `creature` SET `currentwaypoint` = 2 WHERE `guid` = 53912;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='4806',`maxdmg`='5706',`mechanic_immune_mask`='646004699',`flags_extra`='1078001664' WHERE `entry` = 23030; -- 1513 3087 -- 8,411 - 9,985

-- Shadowmoon Soldier 23047- mob_shadowmoon_soldier
UPDATE `creature` SET `modelid`  = 0, `spawntimesecs` = 7200 WHERE `id` = 23047; 
UPDATE `creature_template` SET `modelid_A`='21383',`modelid_H`='21383',`modelid_A2`='21385',`modelid_H2`='21385',`speed`='1.48',`mindmg`='1809',`maxdmg`='2398' WHERE `entry` = 23047; -- 800 1830 -- 3,166 - 4,196
DELETE FROM `creature_template_addon` WHERE `entry` = 23047;
INSERT INTO `creature_template_addon` VALUES (23047, 0, 0, 16777472, 0, 4097, 0, 0, '');

-- Shadowmoon Weapon Master 23049- mob_shadowmoon_weapon_master
-- #define DATA_WEAPONMASTER_LIST_SIZE     32
-- #define DATA_WEAPONMASTER_SOLDIER 33 // -40
-- missing guids
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23049;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='15389',`maxdmg`='21846',`mechanic_immune_mask`='650854399',`flags_extra`='1078001664' WHERE `entry` = 23049; -- 8000 19300 -- 26,931 - 38,231
DELETE FROM `creature_template_addon` WHERE `entry` = 23049;
INSERT INTO `creature_template_addon` VALUES (23049, 0, 0, 16777472, 0, 4097, 0, 0, '');

-- Demon Fire 23069- mob_demon_fire
-- spell 1 = 40029

-- Shadowmoon Riding Hound 23083- mob_shadowmoon_riding_hound
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4857',`maxdmg`='5940',`baseattacktime`='1000',`mechanic_immune_mask`='75507183' WHERE `entry` = 23083; -- 1527 3422 1000 -- 8,500 - 10,395

-- Sewer Rat (23086) - NSR
-- Sewer Crocolisk (23087) - NSR

-- Shadowmoon Grunt (23147) - NSR -- mob_shadowmoon_grunt
-- aura 34664 0
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `MovementType` = 0 WHERE `id` = 23147;
UPDATE `creature_addon` SET `moveflags` = 0 WHERE `guid` IN (52447,52449); -- 2048
UPDATE `creature_addon` SET `auras` = '34664 0' WHERE `guid` IN (52441,52448,52457);
UPDATE `creature_template` SET `modelid_A2`='21377',`modelid_H2`='21377',`speed`='1.48',`mindmg`='1548',`maxdmg`='1967' WHERE `entry` = 23147;  -- 815 1548 -- 2,709 - 3,442
DELETE FROM `creature_template_addon` WHERE `entry` = 23147;
INSERT INTO `creature_template_addon` VALUES (23147, 0, 0, 16777472, 0, 4097, 0, 0, '');

-- Aluyen (23157) - NSR
-- Seer Kanai (23158) - NSR
-- Okuno (23159) - NSR

-- Hand of Gorefiend 23172- mob_hand_of_gorefiend
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `curmana` = 0 WHERE `id` = 23172;
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`minmana`='0',`maxmana`='0',`armor`='7400',`speed`='1.48',`mindmg`='11436',`maxdmg`='18596',`flags_extra` = 1078001664 WHERE `entry` = 23172; -- 10500 17660 -- 11436 - 18596
DELETE FROM `creature_template_addon` WHERE `entry` = 23172;
INSERT INTO `creature_template_addon` VALUES
(23172, 0, 0, 512, 0, 4097, 0, 0, '');

-- Bonechewer Behemoth 23196- mob_bonechewer_behemoth
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0 WHERE `id` = 23196;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='9890',`maxdmg`='15657',`flags_extra`='1073807360' WHERE `entry` = 23196; -- 3109 13200 -- 17,308 - 27,399
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`= '23' WHERE `creature_id` = 23196;

-- Bonechewer Brawler 23222- mob_bonechewer_brawler
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23222;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='12380',`maxdmg`='16525',`flags_extra`='1073741824' WHERE `entry` = 23222; -- 3071 10325 -- 21,665 - 28,919

-- Bonechewer Spectator 23223- mob_bonechewer_spectator emote 22
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23223;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='1295',`maxdmg`='1652',`mechanic_immune_mask`='662781919' WHERE `entry` = 23223; -- 407 1032 -- 2,266 - 2,891

-- Mutant War Hound 23232- mob_mutated_war_hound
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200, `spawndist` = 0, `MovementType` = 0 WHERE `id` = 23232;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4142',`maxdmg`='4723',`mechanic_immune_mask`='662715903' WHERE `entry` = 23232; -- 2368 3385 -- 7,248 - 8,265
DELETE FROM `creature_template_addon` WHERE `entry` = 23232;
INSERT INTO `creature_template_addon` VALUES (23232, 0, 0, 16777472, 0, 4097, 0, 0, '41290 0'); 

-- Bonechewer Blade Fury 23235- mob_bonechewer_blade_fury
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23235;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8483',`maxdmg`='11111',`mechanic_immune_mask`='67119105' WHERE `entry` = 23235; -- 3487 8086 -- 14,846 - 19,445

-- Bonechewer Shield Deciple 23236- mob_bonechewer_shield_disciple
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23236;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='10847',`maxdmg`='12835',`mechanic_immune_mask`='67119105' WHERE `entry` = 23236; -- 6521 10000 -- 18,982 - 22,461

-- Bonechewer Blood Prophet 23237- mob_bonechewer_blood_prophet
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23237;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5863',`maxdmg`='7904' WHERE `entry` = 23237; -- 2501 6072 -- 10,261 - 13,832

-- Bonechewer Combatant 23239- mob_bonechewer_combatant
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23239;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='14380',`maxdmg`='18811',`mechanic_immune_mask`='662781919',`flags_extra`='1073741824' WHERE `entry` = 23239; -- 6571 14325 -- 25,165 - 32,919

-- Dragonmaw Wind Reaver 23330- mob_dragonmaw_windreaver
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23330;
UPDATE `creature_addon` SET `mount`= 21548 WHERE `guid` IN (12737,12738,12739,12740,12741,12742,12743); -- 24725
UPDATE `creature_template` SET `speed` = 1.71,`mindmg`='4205',`maxdmg`='4993',`mechanic_immune_mask`='646004699',`flags_extra`='1078001664' WHERE `entry` = 23330; -- 1323 2701 -- 7,359 - 8,737

-- Illidari Centurion 23337- mob_illidari_centurion
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 7200, `curhealth` = 293000 WHERE `id` = 23337;
UPDATE `creature_template` SET `mindmg`='12038',`maxdmg`='13753',`mechanic_immune_mask`='652951551',`flags_extra`='1078001664' WHERE `entry` = 23337; -- 6301 9301 -- 21,067 - 24,067
DELETE FROM `creature_template_addon` WHERE `entry` = 23337;
INSERT INTO `creature_template_addon` VALUES (23337, 0, 0, 16777472, 0, 4097, 375, 0, '');	

-- Illidari Heartseeker 23339- mob_illidari_heartseeker
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 7200 WHERE `id` = 23339;
UPDATE `creature_template` SET `mindmg`='6925',`maxdmg`='7782',`mechanic_immune_mask`='46153555' WHERE `entry` = 23339; -- 3751 5251 -- 12,118 - 13,618
DELETE FROM `creature_template_addon` WHERE `entry` = 23339;
INSERT INTO `creature_template_addon` VALUES (23339, 0, 0, 16777472, 0, 4097, 0, 0, '');	

-- Whirling Blade 23369 -- mob_whirling_blade
-- UPDATE `creature_template` SET WHERE `entry` = 23369;

-- Ashtongue Stalker 23374- mob_ashtongue_stalker
UPDATE `creature` SET `modelid` = 0, `equipment_id` = 0, `spawntimesecs` = 7200 WHERE `id` = 23374;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5855',`maxdmg`='7295',`mechanic_immune_mask`='570568513' WHERE `entry` = 23374; -- 2551 6151 -- 14,637 - 18,237 /2.5
DELETE FROM `creature_template_addon` WHERE `entry` = 23374;
INSERT INTO `creature_template_addon` VALUES (23374, 0, 0, 16777472, 0, 4097, 0, 0, '');	

-- Black Temple - Houndmaster Flare Dummy 23379
-- trigger doesnt despawn should despawn or change model to 11686 only
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` = 23379;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23379;
INSERT INTO `creature_ai_scripts` VALUES   
('2337901','23379','0','0','100','0','30000','30000','0','0','37','0','0','0','0','0','0','0','0','0','0','0','Houndmaster Flare Dummy - Kill Self after 30sec');         

-- Fallen Ally 23389
-- These appear when a person in the raid dies while fighting the trash packs just after Supremus.
UPDATE `creature_template` SET `mechanic_immune_mask`='8398929' WHERE `entry` = 23389; -- 1500 2500 -- 1,786 - 2,786

-- Promenade Sentinal 23394- mob_promenade_sentinel
UPDATE `creature` SET `modelid` = 0, `spawntimesecs`  = 7200, `spawndist` = 0 WHERE `id` = 23394;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='12835',`maxdmg`='17101',`resistance3`='-1',`mechanic_immune_mask`='787169279',`flags_extra`='1078001664' WHERE `entry` = 23394; -- 7316 14781 -- 22,461 - 29,926
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='30' WHERE `creature_id` = 23394;
DELETE FROM `creature_template_addon` WHERE `entry` = 23394;
INSERT INTO `creature_template_addon` VALUES (23394, 0, 0, 16908544, 0, 4097, 0, 0, '');

-- Illidari Blood Lord 23397- mob_illidari_blood_lord
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23397;
UPDATE `creature_template` SET `modelid_A`='21560',`modelid_H`='21560',`modelid_A2`='21562',`modelid_H2`='21562',`speed`='1.48',`mindmg`='12866',`maxdmg`='16289',`mechanic_immune_mask`='788217855',`flags_extra`='1078001664' WHERE `entry` = 23397; -- 9790 15781 -- 22,515 - 28,506
DELETE FROM `creature_template_addon` WHERE `entry` = 23397;
INSERT INTO `creature_template_addon` VALUES (23397, 0, 0, 512, 0, 4097, 0, 0, '');

-- Angered Soul Fragment 23398 -- mob_angered_soul_fragment
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 20, `spawndist` = 5, `MovementType` = 1 WHERE `id` = 23398;
UPDATE `creature_addon` SET `auras` = '35841 0' WHERE `guid` IN (9794,9821,9851,9869,9953);
UPDATE `creature_template` SET `modelid_A` = 11686, `speed` = 1.20, `mindmg`='1404',`maxdmg`='1981' WHERE `entry` = 23398; -- 236 1246 -- 2,457 - 3,467
DELETE FROM `creature_template_addon` WHERE `entry` = 23398;
INSERT INTO `creature_template_addon` VALUES (23398, 0, 0, 131584, 0, 4097, 0, 0, '35841 0');

-- Suffering Soul Fragment 23399- mob_suffering_soul_fragment
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 20 WHERE `id` = 23399;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4764',`maxdmg`='5762' WHERE `entry` = 23399; -- 2555 4301 -- 8,337 - 10,083 

-- Illidari Archon 23400- mob_illidari_archon
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23400;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='7258',`maxdmg`='9545',`mechanic_immune_mask`='67120471',`flags_extra`='1077936128' WHERE `entry` = 23400; -- 3925 7927 -- 12,701 - 16,703
DELETE FROM `creature_template_addon` WHERE `entry` = 23400;
INSERT INTO `creature_template_addon` VALUES (23400, 0, 0, 512, 0, 4097, 0, 0, '');

-- Hungering Soul Fragment 23401- mob_hungering_soul_fragment
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 20, `spawndist` = 5, `MovementType` = 1 WHERE `id` = 23401;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4253',`maxdmg`='4596' WHERE `entry` = 23401; -- 3000 3600 -- 7,443 - 8,043
DELETE FROM `creature_template_addon` WHERE `entry` = 23401;
INSERT INTO `creature_template_addon` VALUES (23401, 0, 0, 16908544, 0, 4097, 0, 0, '41248 0'); 

-- Illidari Battle-Mage 23402- mob_illidari_battle_mage
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23402;#
UPDATE `creature_addon` SET `emote` = 0 WHERE `guid` = 52433; -- 69
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8401',`maxdmg`='11259',`mechanic_immune_mask`='109063511' WHERE `entry` = 23402; -- 5925 10927 -- 14,701 - 19,703

-- Illidari Assassin 23403- mob_illidari_assassin
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 7200 WHERE `id` = 23403;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='6969',`maxdmg`='8452',`mechanic_immune_mask`='109064151',`flags_extra`='1078001664' WHERE `entry` = 23403; -- 5591 9297 -- 17,423 - 21,129 /2.5

-- Teleport NPCs
-- Spirit of Udalo (23410) - npc_spirit_of_udalo
-- Spirit of Olum (23411) - npc_spirit_of_olum

-- Image of Dementia 23436- mob_image_of_dementia
-- http://www.wowhead.com/npc=23436/image-of-dementia#comments
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='700',`maxdmg`='1400',`mechanic_immune_mask`='650854359',`flags_extra`='1078001664' WHERE `entry` = 23436; -- 500 900
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='0' WHERE `creature_id` = 23436;
DELETE FROM `creature_template_addon` WHERE `entry` = 23436;
INSERT INTO `creature_template_addon` VALUES (23436, 0, 0, 16777472, 0, 4097, 0, 0, '41399 0 41399 1');


-- ============================
-- Bosses
-- http://wowwiki.wikia.com/wiki/Armor?file=Armor.JPG Bosse
-- ============================

-- High Warlord Naj'entus 22887 - boss_najentus 
-- http://wowwiki.wikia.com/wiki/High_Warlord_Naj%27entus?oldid=1593265
UPDATE `creature` SET `modelid` = 0 WHERE `id` = 22887;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='14595',`maxdmg`='16095',`mechanic_immune_mask`='617299807',`flags_extra`='1078001665' WHERE `entry` = 22887; -- 1.2 9000 12000 -- 29,190 - 32,190 /2

-- GOBJECT_SPINE 185584

-- ===============

-- Supremus 22898- boss_supremus 
-- http://wowwiki.wikia.com/wiki/Supremus?oldid=1618153
UPDATE  `creature` SET `modelid` = 0 WHERE `id` = 22898;
UPDATE `creature_template` SET `speed` = 1.71,`mindmg`='16865',`maxdmg`='20495',`mechanic_immune_mask`='650854239',`flags_extra`='1078001697' WHERE `entry` = 22898; -- 6690 13950 -- 33,730 - 40,990 /2
-- core scripted atm
-- UPDATE `creature_model_info` SET `bounding_radius` = 20,`combat_reach` = 20 WHERE `modelid` = 21145; -- 13 0

-- Supremus Punch Invis Stalker 23095

-- Supremus Volcano 23085

-- ===============

-- Akama 23191- npc_akama_shade
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 23191;
-- UPDATE `creature_template` SET WHERE `entry` = 23191;
-- Akama Soul Expel Cosmetic Spell doesnt work
DELETE FROM `spell_script_target` WHERE `entry` = 40855;
INSERT INTO `spell_script_target` VALUES (40855,2,22841);

-- Shade of Akama 22841- boss_shade_of_akama
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 604800 WHERE `id` = 22841;
UPDATE `creature_template` SET `speed`='1.0',`mindmg`='10000',`maxdmg`='20000',`mechanic_immune_mask`='650854271',`flags_extra`='1078001665' WHERE `entry` = 22841; -- 1.2 -- 9476 19367 -- 52,741 - 62,632 fix

-- Ashtongue Channeler 23421- mob_ashtongue_channeler
UPDATE `creature_template` SET `armor`='5714',`speed`='1.48',`mindmg`='3097',`maxdmg`='3674',`mechanic_immune_mask`='788217855',`flags_extra`='1078001664' WHERE `entry` = 23421; -- 3577 1.2 976 1986 -- 5,419 - 6,429
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 23421;
INSERT INTO `creature_onkill_reputation` VALUES (23421, 1012, 0, 5, 0, 15, 0, 0, 0, 0);

-- Ashtongue Sorcerer 23215- mob_ashtongue_sorcerer
UPDATE `creature_template` SET `modelid_A`='21402',`modelid_H`='21402',`modelid_A2`='21593',`modelid_H2`='21593',`armor`='5800',`speed`='1.48',`mindmg`='7190',`maxdmg`='8529',`mechanic_immune_mask`='1056653183',`flags_extra`='1073807360' WHERE `entry` = 23215; -- 3577 1,5 2267 4610 -- 12,582 - 14,925
-- UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`= 23215;
-- UPDATE `creature_template` SET `ScriptName`='mob_ashtongue_sorcerer', `AIName`='' WHERE `entry`= 23215;


-- Ashtongue Defender 23216- mob_ashtongue_defender
UPDATE `creature_template` SET `modelid_A`='21595',`modelid_H`='21595',`speed`='1.48',`mindmg`='4087',`maxdmg`='8000',`mechanic_immune_mask`='1056653179',`flags_extra`='0' WHERE `entry` = 23216; -- 4000 8000 -- 7,152 - 11,152
-- UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`=23216;
-- UPDATE `creature_template` SET `ScriptName`='mob_ashtongue_defender', `AIName`='' WHERE `entry`= 23216;

-- Ashtongue Broken (23319) - NSR

-- Ashtongue Elementalist 23523- mob_ashtongue_elementalist
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` = 23523; -- 1.5
-- UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`= 23523;
-- UPDATE `creature_template` SET `ScriptName`='mob_ashtongue_elementalist', `AIName`='' WHERE `entry`= 23523;

-- Ashtongue Spiritbinder 23524- mob_ashtongue_spiritbinder
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` = 23524; -- 1.5
-- UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`= 23524;
-- UPDATE `creature_template` SET `ScriptName`='mob_ashtongue_spiritbinder', `AIName`='' WHERE `entry`= 23524;

-- Akama (22990) - npc_akama_shade Shadowmoonvalley

-- Ashtongue Rogue 23318- mob_ashtongue_rogue
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` = 23318; -- 1.5
-- UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`= 23318;
-- UPDATE `creature_template` SET `ScriptName`='mob_ashtongue_rogue', `AIName`='' WHERE `entry`= 23318;

-- ===============

-- Teron Gorefiend 22871- boss_teron_gorefiend
UPDATE `creature` SET `modelid` = 0, `spawntimesecs` = 604800 WHERE `id` = 22871;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='14489',`maxdmg`='17198',`mechanic_immune_mask`='650854395',`flags_extra`='1078001665' WHERE `entry` = 22871; -- 7820 15946 -- 14000 18800calc -- 43,467 - 51,593 /3

-- Doom Blossom 23123- mob_doom_blossom
-- faction 35

-- Shadowy Construct 23111- mob_shadowy_construct
-- maybe increase speed slightly
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='1500',`maxdmg`='3000',`mechanic_immune_mask`='12582928',`flags_extra`='1078001664' WHERE `entry` = 23111; -- 600 900 -- 1600 2800

-- Vengeful Spirit (23109) - NSR

-- ===============

-- Gurtogg Bloodboil 22948- boss_gurtogg_bloodboil /2.25
UPDATE `creature` SET `modelid` = 0 WHERE `id` = 22948;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='11721',`maxdmg`='14363',`mechanic_immune_mask`='650854399' WHERE `entry` = 22948; -- 4738 9684 -- 26,371 - 31,317

-- ===============
-- https://web.archive.org/web/20100907205653/http://www.hordeguides.de/Schlachtzug/TBC/Boss/23420/Relikt-der-Seelen/index.htm

-- Reliquary of the Lost 22856 -- Visual
UPDATE `creature_template` SET `unit_flags`='33816896' WHERE `entry` = 22856; -- 33554752

-- Essence of Suffering 23418- boss_essence_of_suffering
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='788',`maxdmg`='1013',`mechanic_immune_mask`='650854399' WHERE `entry` = 23418; -- 1.2 700 1200 -- 843 - 1343

-- Essence of Desire 23419- boss_essence_of_desire
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='9458',`maxdmg`='10462',`mechanic_immune_mask`='617299967' WHERE `entry` = 23419; -- 1.2 10000 13010 -- 28,375 - 31,385

-- Essence of Anger 23420- boss_essence_of_anger
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='10058',`maxdmg`='11025',`mechanic_immune_mask`='650854399' WHERE `entry` = 23420; -- 1.2 11800 14700 -- 30,175 - 33,075

-- Enslaved Soul 23469- npc_enslaved_soul
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='650854239' WHERE `entry` = 23469; -- 540 580
-- visual
DELETE FROM `creature_template_addon` WHERE `entry` = 23469;
INSERT INTO `creature_template_addon` VALUES (23469, 0, 0, 0, 0, 4097, 0, 0, '30206 0');

-- Invisible Stalker (Floating) 23033
UPDATE `creature_template` SET `InhabitType`= 7 WHERE `entry` = 23033; -- 3

-- Reliquary Combat Trigger 23417
UPDATE `creature_template` SET `modelid_A` = 15435, `flags_extra`= 130 WHERE `entry` = 23417;

-- http://db.looking4group.eu/?npc=23472

-- ===============

-- Mother Shahraz 22947- boss_mother_shahraz
-- https://web.archive.org/web/20100907205638/http://www.hordeguides.de/Schlachtzug/TBC/Boss/22947/Mutter-Shahraz/index.htm
UPDATE `creature` SET `modelid` = 0 WHERE `id` = 22947;
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='11758',`maxdmg`='15406',`mechanic_immune_mask`='650854395',`flags_extra`='1078001705' WHERE `entry` = 22947; -- 8797 17938 -- 48,900 - 58,041

-- ===============

-- The Illidari Council 23426- mob_illidari_council
-- https://web.archive.org/web/20100907205648/http://www.hordeguides.de/Schlachtzug/TBC/Boss/22949/Rat-der-Illidari/index.htm

-- Gathios the Shatterer 22949- boss_gathios_the_shatterer
UPDATE `creature` SET `modelid`  = 0 WHERE `id` = 22949;
UPDATE `creature_template` SET `mindmg`='12214',`maxdmg`='14676',`mechanic_immune_mask`='617299963',`mingold`=62500, `maxgold` = 62500 WHERE `entry` = 22949; -- 9331 17949 -- 42,749 - 51,367 /3.5

-- High Nethermancer Zerevor 22950- boss_high_nethermancer_zerevor
UPDATE `creature` SET `modelid`  = 0 WHERE `id` = 22950;
UPDATE `creature_template` SET `mindmg`='2484',`maxdmg`='2948',`mechanic_immune_mask`='617299963',`mingold`=62500, `maxgold` = 62500 WHERE `entry` = 22950; -- 1564 3189 -- 8,693 - 10,318

-- Lady Malande 22951- boss_lady_malande
UPDATE `creature` SET `modelid`  = 0 WHERE `id` = 22951;
UPDATE `creature_template` SET `mindmg`='4452',`maxdmg`='5463',`mingold`=62500, `maxgold` = 62500,`mechanic_immune_mask`='617299963' WHERE `entry` = 22951; -- 4443 7983 -- 15,582 - 19,122

-- Veras Darkshadow 22952- boss_veras_darkshadow
UPDATE `creature` SET `modelid`  = 0 WHERE `id` = 22952;
UPDATE `creature_template` SET `mindmg`='7269',`maxdmg`='9096',`mechanic_immune_mask`='617297915',`mingold`=62500, `maxgold` = 62500 WHERE `entry` = 22952; -- 6212 12608 -- 25,440 - 31,836

-- ===============

-- Illidan Stormrage 22917- boss_illidan_stormrage
-- https://web.archive.org/web/20100907205633/http://www.hordeguides.de/Schlachtzug/TBC/Boss/22917/Illidan-Sturmgrimm/index.htm
-- he is floating since some time
UPDATE `creature_template` SET `speed`='2.4',`mindmg`='16500',`maxdmg`='21500',`mechanic_immune_mask`='617299963' WHERE `entry` = 22917; -- 2 16500 21500 -- ~12858 17144! -- 20,786 - 25,786

-- Akama 23089- boss_illidan_akama
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4075',`maxdmg`='4837'  WHERE `entry` = 23089; -- 2932 5979 -- 16,299 - 19,346 /4

-- Illidari Elite 23226- NSR fights against akama illidan
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='2785',`maxdmg`='3308' WHERE `entry` = 23226; -- 500 1023 -- 2785 - 3308

-- Parasitic Shadowfiend 23498- boss_illidan_parasite_shadowfiend
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='873',`maxdmg`='993',`mechanic_immune_mask`='650854335',`flags_extra`='1086390272' WHERE `entry` = 23498; -- 1.1 188 308 -- 873 - 993

-- Shadow Demon 23375- boss_illidan_shadowdemon
UPDATE `creature_template` SET `maxhealth`='22958',`speed`='0.6',`mindmg`='557',`maxdmg`='662',`mechanic_immune_mask`='650854399',`flags_extra`='1086390272' WHERE `entry` = 23375; -- 20958 0.5 100 205 -- 557 - 662

-- Maiev Shadowsong 23197- boss_illidan_maiev
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`flags_extra`='1078001664' WHERE `entry` = 23197; -- 3000 4000 -- 5,625 - 6,625

-- Flame of Azzinoth 22997- boss_illidan_flameofazzinoth
-- http://de.wowhead.com/npc=22997/flamme-von-azzinoth#english-comments
UPDATE `creature_template` SET `mindmg`='11000',`maxdmg`='12000',`mechanic_immune_mask`='650854399',`flags_extra`='1078198304' WHERE `entry` = 22997; -- 13000 13000 -- 7502!

-- Blade of Azzinoth 22996- boss_illidan_glaive
-- trigger
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|262144 WHERE `entry` = 22996;

-- Flame Crash 23336- mob_flame_crash
-- trigger

-- Glaive Target 23448
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|262144 WHERE `entry` = 23448;

-- CAGE_TRAP_TRIGGER = 23292
-- trigger

-- Illidan Door Trigger
UPDATE `creature` SET `position_x`='772.6823', `position_y`='304.5182', `position_z`='316.3370' WHERE `guid` = 52461;
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 23412;

-- ======================================================
-- Group Linking
-- ======================================================

DELETE FROM `creature_formations` WHERE `leaderguid` IN (12817,12803,12812,12797,12788,12789,12810,52874,52873,12847,12846,12855,12856,12850,16202,12754,12841,12782,12793,12807,12815,12780,12804,12791,18239,12866,12852,12851,12746,12747,12755,12820,12833,12834,12752,12753,12842,12758,12825,12750,12751,12839,12757,12823,12806,12819,12805,12814,52846,53054,53798,53799,53796,53797,53801,53800);
DELETE FROM `creature_formations` WHERE `memberguid` IN (12817,12803,12812,12797,12788,12789,12810,52874,52873,12782,12793,12807,12815,12780,12804,12791,18239,12866,12852,12851,12746,12747,12755,12820,12833,12834,12752,12753,12842,12758,12825,12750,12751,12839,12757,12823,12806,12819,12805,12814,52846,53054,53798,53799,53796,53797,53801,53800);
INSERT INTO `creature_formations` VALUES

--

(12817,12817,100,360,2),
(12817,12803,100,360,2),
(12817,12812,100,360,2),
(12817,12797,100,360,2),
(12817,12788,100,360,2),
(12817,12789,100,360,2),
(12817,12810,100,360,2),

(52874,52874,100,360,2),
(52874,52873,5,1.57,2),

(12847,12847,100,360,2),
(12847,12846,100,360,2),
(12847,12855,100,360,2),
(12847,12856,100,360,2),
(12847,12850,100,360,2),
(12847,16202,100,360,2),
(12847,12754,100,360,2),
(12847,12841,100,360,2),

(12782,12782,100,360,2),
(12782,12793,5,4.71,2),
(12782,12807,5,1.57,2),
(12782,12815,7,1.57,2),

(12780,12780,100,360,2),
(12780,12791,5,1.57,2),
(12780,12804,5,4.71,2),
(12780,18239,7,4.71,2),

(12866, 12852, 5, 1.57, 2), -- 10
(12866, 12851, 5, 4.71, 2), -- 10
(12866, 12866, 0, 0, 2),

(12746,12746,100,360,2),
(12746,12747,100,360,2),
(12746,12755,100,360,2),
(12746,12820,100,360,2),
(12746,12833,100,360,2),
(12746,12834,100,360,2),
--
(12752,12752,100,360,2),
(12752,12753,100,360,2),
(12752,12842,100,360,2),
(12752,12758,100,360,2),
(12752,12825,100,360,2),
-- 
(12750,12750,100,360,2),
(12750,12751,100,360,2),
(12750,12839,100,360,2),
(12750,12757,100,360,2),
(12750,12823,100,360,2),
--
(12806,12806,100,360,2),
(12806,12819,2,4.7,2),

(12805,12805,100,360,2),
(12805,12814,2,1.5,2),

(52846,52846,100,360,2),
(52846,53054,3,1.5,2),

(53798,53798,100,360,2),
(53798,53799,6,0,2),

-- (53800,53800,100,360,2),
-- (53800,53801,6,0,2),

(53796,53796,100,360,2),
(53796,53797,4,4.7,2);

-- (12794,  242745, 7, 0.69, 2),
-- (12796,  240995, 7, 0.69, 2);


-- ======================================================
-- Respawn
-- ======================================================

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (12841,12754,246422,246423,16196,16193,12886,52846,42920,9851,9869,40407,40243,16221,40233,40244,39926,16215,9953,39928,16205,53211,53212,53797,53796,12880,53799,53798,52754,53827,53829,53828,53831,53907,53909,53800,53801,12749,12753,12758,12751,12781,12792,12799,12800,241261,12782,12793,12807,12815,12779,12778,12790,12798,241416,12780,12791,12804,18239,247005,247051,12806,12819,12805,12814,12789,12788,12797,12812,12803,12817,12810,12786,12801,12811,12809,12816,12795,12785,12830,12829,246569,246615,12796,12787,12802,12794,12808,12784,246485,246421,53821,52768,52769,12849,12848,16199,16201,13418,13416,13774,13429,13408,13402,13401,13404,13400,13406,13236,126600,240198,240807,240957,240995,241085,241141,241960,242412,242681,242745,243224,244331,245098);
INSERT INTO `creature_linked_respawn` VALUES

(16196,52479),
(16193,52479),
(12886,52479),

(52846,52760),

(42920,12828),
(9851,12828),
(9869,12828),
(40407,12828),
(40243,12828),
(16221,12828),
(40233,12828),
(40244,12828),
(39926,12828),
(16215,12828),
(9953,12828),
(39928,12828),
(16205,12828),

(53211,52761),
(53212,52761),

(53797,12843),
(53796,12843),
(12880,12843),
(53799,12843),
(53798,12843),
(52754,12843),
(53801,12843),
(53800,12843),

-- should be 12777
(12749,12777),
(12753,12777),
(12758,12777),
(12751,12777),

-- should be 84716
(246422,12777),
(246423,12777),

(12781,12777),
(12792,12777),
(12799,12777),
(12800,12777),
(241261,12777),
(12782,12777),
(12793,12777),
(12807,12777),
(12815,12777),
(12779,12777),
(12778,12777),
(12790,12777),
(12798,12777),
(241416,12777),
(12780,12777),
(12791,12777),
(12804,12777),
(18239,12777),
(247005,12777),
(247051,12777),
(12806,12777),
(12819,12777),
(12805,12777),
(12814,12777),
(12789,12777),
(12788,12777),
(12797,12777),
(12812,12777),
(12803,12777),
(12817,12777),
(12810,12777),
(12786,12777),
(12801,12777),
(12811,12777),
(12809,12777),
(12816,12777),
(12795,12777),
(12785,12777),
(12830,12777),
(12829,12777),
(246569,12777),
(246615,12777),
(12796,12777),
(12787,12777),
(12802,12777),
(12794,12777),
(12808,12777),
(12784,12777),
(246485,12777),
(246421,12777),

(53827,52458),
(53829,52458),
(53828,52458),
(53831,52458),
(53907,52458),
(53909,52458),
(53821,52458),
(52768,52458),
(52769,52458),

(12754,40527),
(12841,40527),
(12849,40527),
(12848,40527),
(16199,40527),
(16201,40527),
(13418,40527),
(13416,40527),
(13774,40527),
(13429,40527),
(13408,40527),
(13402,40527),
(13401,40527),
(13404,40527),
(13400,40527),
(13406,40527),
(13236,40527);

-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================

-- General
UPDATE `creature_addon` SET `bytes1` = 8 WHERE `guid` IN (12779,12781,12790,12799); -- 1
UPDATE `creature_addon` SET `bytes1` = 0 WHERE `guid` IN (12785,12786,12795,12801,12809); -- 8
UPDATE `creature_addon` SET `bytes1` = 8 WHERE `guid` IN (12800); -- 0
UPDATE `creature_addon` SET `emote` = 0 WHERE `guid` = 12789; -- 378
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` IN (12793);
DELETE FROM `creature_addon` WHERE `guid` IN (18239);
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` IN (18239,12793,12815,12807);

-- Specific

UPDATE `creature` SET `position_x`='265.8057', `position_y`='885.8453', `position_z`='-25.7932' WHERE `guid` = 12853;

UPDATE `creature` SET `currentwaypoint` = '5' WHERE `guid` = 12737;

UPDATE `creature` SET `currentwaypoint` = 4 WHERE `guid` = 53912;

UPDATE `creature` SET `currentwaypoint` = '5', `MovementType`='2' WHERE `guid` = 53829;
DELETE FROM `creature_addon` WHERE `guid` = 53829;
INSERT INTO `creature_addon` VALUES
(53829, 53827, 24725, 512, 0, 4097, 0, 1024, '');	

DELETE FROM `creature_addon` WHERE `guid` IN (53827,53828);
INSERT INTO `creature_addon` VALUES
(53827, 0, 24725, 512, 0, 4097, 0, 0, ''),	
(53828, 0, 24725, 512, 0, 4097, 0, 0, '');

UPDATE `creature` SET `position_x`='777.311829', `position_y`='851.671875', `position_z`='59.054199', `orientation`='5.1064',`spawndist`='0',`movementtype`='0' WHERE `guid` = 53827;
UPDATE `creature` SET `position_x`='801.692261', `position_y`='853.007812', `position_z`='60.433735', `orientation`='4.1497',`spawndist`='0',`movementtype`='0' WHERE `guid` = 53828;

SET @GUID := 52874;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 702.7473, 801.6859, 62.1615,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 702.6610, 794.3372, 63.3655,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 702.7971, 690.7724, 72.1014,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 702.7948, 696.1107, 71.6445,0,0,0,100,0);

UPDATE `creature` SET `position_x`='449.290985', `position_y`='790.747986', `position_z`='12.031914', `orientation`='2.076940' WHERE `guid` = 12846;
UPDATE `creature` SET `position_x`='454.178986', `position_y`='802.715027', `position_z`='12.097442', `orientation`='3.385940' WHERE `guid` = 12855;
UPDATE `creature` SET `position_x`='442.347992', `position_y`='790.156982', `position_z`='12.028371', `orientation`='1.466080' WHERE `guid` = 12856;
UPDATE `creature` SET `position_x`='446.810364', `position_y`='810.570618', `position_z`='12.139904', `orientation`='4.564470' WHERE `guid` = 12850;
UPDATE `creature` SET `position_x`='440.881317', `position_y`='810.689209', `position_z`='12.140484', `orientation`='4.733326' WHERE `guid` = 16202;

UPDATE `creature` SET `position_x`='599.337952', `position_y`='904.976135', `position_z`='59.033104', `orientation`='2.514592' WHERE `guid` = 26677;

SET @GUID := 53054;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (53054, 1, 833.48, 523.838, 165.731, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 2, 820.928, 518.631, 165.988, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 3, 815.696, 514.767, 166.104, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 4, 815.656, 506.274, 170.29, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 5, 815.522, 493.552, 180.4, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 6, 815.273, 477.568, 192.706, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 7, 815.569, 467.024, 192.791, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 8, 815.274, 477.438, 192.706, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 9, 815.522, 493.567, 180.4, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 10, 815.656, 506.292, 170.29, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 11, 814.793, 512.636, 166.104, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 12, 820.021, 518.023, 165.988, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 13, 834.557, 524.627, 165.731, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 14, 840.495, 531.905, 165.753, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 15, 840.718, 540.302, 165.679, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 16, 849.122, 540.508, 165.822, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 17, 862.165, 540.535, 156.232, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 18, 874.748, 540.406, 146.189, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 19, 890.828, 540.022, 139.304, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 20, 874.789, 540.405, 146.189, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 21, 862.202, 540.535, 156.232, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 22, 849.189, 540.509, 165.822, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 23, 843.528, 542.474, 165.679, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53054, 24, 839.879, 530.768, 165.753, 0, 0, 0, 100, 0);

SET @GUID := 52846;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52846, 1, 832.29, 526.592, 165.731, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 2, 818.831, 520.776, 165.988, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 3, 812.696, 514.781, 166.104, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 4, 812.656, 506.306, 170.29, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 5, 812.523, 493.598, 180.4, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 6, 812.274, 477.484, 192.706, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 7, 812.571, 466.939, 192.791, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 8, 812.274, 477.484, 192.706, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 9, 812.523, 493.598, 180.4, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 10, 812.656, 506.306, 170.29, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 11, 812.696, 514.781, 166.104, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 12, 818.831, 520.776, 165.988, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 13, 832.29, 526.592, 165.731, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 14, 837.612, 532.732, 165.753, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 15, 840.644, 543.301, 165.679, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 16, 849.115, 543.508, 165.822, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 17, 862.196, 543.535, 156.232, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 18, 874.82, 543.405, 146.189, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 19, 883.0063, 543.1736, 139.6635, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 20, 890.899, 543.021, 139.304, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 21, 896.5783, 542.9110, 139.3039, 0, 0, 0, 100, 0); 
INSERT INTO `waypoint_data` VALUES (52846, 22, 883.0063, 543.1736, 139.6635, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 23, 874.82, 543.405, 146.189, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 24, 862.196, 543.535, 156.232, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 25, 849.115, 543.508, 165.822, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 26, 840.644, 543.301, 165.679, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52846, 27, 837.612, 532.732, 165.753, 0, 0, 0, 100, 0);

SET @GUID := 12886;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12886, 1, 624.821, 173.841, 253.243, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 2, 640.569, 173.921, 245.059, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 3, 642.414, 149.818, 245.051, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 4, 639.994, 127.37, 245.058, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 5, 626.282, 127.041, 251.905, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 6, 611.546, 126.554, 258.893, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 7, 606.469, 138.467, 258.76, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 8, 607.16, 162.469, 258.751, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 9, 613.019, 175.03, 258.94, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12886, 10, 624.821, 173.841, 253.243, 0, 0, 0, 100, 0);

SET @GUID := 12782;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 495.7767, 354.6180, 112.7836,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 477.3133, 365.3570, 112.7836,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 480.2561, 363.5315, 112.7836,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 495.7767, 354.6180, 112.7836,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 503.9439, 358.6741, 112.7836,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 524.2752, 370.0444, 112.7836,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 534.4701, 385.5416, 112.7836,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 532.5229, 379.8294, 112.7836,0,0,0,100,0);

SET @GUID := 53796;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 434.8668, 243.5092, 164.7588,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 434.9193, 239.2255, 164.7675,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 434.8668, 243.5092, 164.7588,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 434.9783, 279.1066, 179.6963,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 435.2803, 310.2175, 192.7752,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 435.2467, 320.0552, 192.7752,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 435.2803, 310.2175, 192.7752,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 434.9783, 279.1066, 179.6963,0,0,0,100,0);

SET @GUID := 42920;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (42920, 1, 629.089, 47.3309, 112.777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (42920, 2, 601.507, 37.5607, 112.735, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (42920, 3, 575.11, 56.3028, 111.031, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (42920, 4, 601.277, 37.4792, 112.741, 0, 0, 0, 100, 0);

DELETE FROM `creature_addon` WHERE `guid` IN (52480,52481);
INSERT INTO `creature_addon` VALUES 
(52480, 0, 0, 512, 8, 4097, 0, 0, ''),
(52481, 0, 0, 512, 8, 4097, 0, 0, '');

SET @GUID := 53816;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (53816, 1, 775.079, 766.952, 66.1695, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 2, 776.475, 758.128, 68.5918, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 3, 776.724, 748.545, 70.0428, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 4, 771.158, 744.486, 69.7692, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 5, 776.724, 748.545, 70.0428, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 6, 776.475, 758.128, 68.5918, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 7, 775.079, 766.952, 66.1695, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 8, 776.642, 775.294, 65.648, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 9, 779.1, 781.978, 65.9348, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 10, 776.998, 791.397, 65.6326, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 11, 779.1, 781.978, 65.9348, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (53816, 12, 776.642, 775.294, 65.648, 0, 0, 0, 100, 0);

SET @GUID := 52418;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID, @GUID, 0, 16908544, 0, 4097, 0, 0, '41248 0'); 
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52418, 1, 617.44, 102.765, 112.751, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52418, 2, 601.631, 74.0624, 111.239, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52418, 3, 578.161, 98.9663, 113.047, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52418, 4, 601.55, 73.9752, 111.243, 0, 0, 0, 100, 0);

SET @GUID := 52420;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID, @GUID, 0, 16908544, 0, 4097, 0, 0, '41248 0'); 
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52420, 1, 620.916, 30.2202, 112.736, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52420, 2, 607.715, 64.6145, 111.726, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52420, 3, 589.44, 39.2402, 112.765, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52420, 4, 607.578, 64.4233, 111.72, 0, 0, 0, 100, 0);

SET @GUID := 52423;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID, @GUID, 0, 16908544, 0, 4097, 0, 0, '41248 0'); 
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52423, 1, 512.155, 30.0493, 113.648, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52423, 2, 487.486, 43.7172, 112.325, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52423, 3, 512.155, 30.0493, 113.648, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52423, 4, 550.625, 48.4656, 112.568, 0, 0, 0, 100, 0);

SET @GUID := 52424;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID, @GUID, 0, 16908544, 0, 4097, 0, 0, '41248 0'); 
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52424, 1, 518.947, 74.61, 112.913, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52424, 2, 473.218, 73.2273, 111.846, 0, 0, 0, 100, 0);

SET @GUID := 52427;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID, @GUID, 0, 16908544, 0, 4097, 0, 0, '41248 0'); 
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52427, 1, 552.323, 97.9542, 112.481, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52427, 2, 536.094, 78.042, 113.071, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52427, 3, 552.323, 97.9542, 112.481, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (52427, 4, 573.458, 103.49, 113.186, 0, 0, 0, 100, 0);

SET @GUID := 12780;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12780, 1, 478.281, 443.979, 112.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12780, 2, 526.059, 429.854, 112.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12780, 3, 535.645, 409.609, 112.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12780, 4, 526.018, 432.29, 112.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12780, 5, 483.452, 438.467, 112.784, 0, 0, 0, 100, 0);

SET @GUID := 13405;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13405, 1, 251.44, 759.29, -27.23, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 2, 217.36, 759.36, -23.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 3, 225.43, 782.14, -24.39, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 4, 227.67, 805.59, -24.22, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 5, 219.13, 812.14, -24.17, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 6, 228.22, 841.06, -23.87, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 7, 219.55, 860.39, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 8, 227.97, 877.38, -24.26, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 9, 221.87, 886.87, -24.52, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 10, 224.47, 958.78, -60.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 11, 225.26, 976.52, -61.56, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 12, 216.84, 996.08, -61.48, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 13, 229.36, 1021.73, -61.49, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 14, 216.84, 1048.74, -59.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 15, 229.36, 1021.73, -61.49, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 16, 216.84, 996.08, -61.48, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 17, 225.26, 976.52, -61.56, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 18, 224.47, 958.78, -60.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 19, 221.87, 886.87, -24.52, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 20, 227.97, 877.38, -24.26, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 21, 219.55, 860.39, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 22, 228.22, 841.06, -23.87, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 23, 219.13, 812.14, -24.17, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 24, 227.67, 805.59, -24.22, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 25, 225.43, 782.14, -24.39, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13405, 26, 217.36, 759.36, -23.86, 0, 0, 0, 100, 0);

SET @GUID := 13429;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13429, 1, 229.7791, 1071.0634, -60.7522, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 2, 229.4675, 1055.7926, -60.7067, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 3, 216.84, 1048.74, -59.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 4, 229.36, 1021.73, -61.49, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 5, 216.84, 996.08, -61.48, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 6, 225.26, 976.52, -61.56, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 7, 224.47, 958.78, -60.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 8, 221.87, 886.87, -24.52, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 9, 227.97, 877.38, -24.26, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 10, 219.55, 860.39, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 11, 228.22, 841.06, -23.87, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 12, 219.13, 812.14, -24.17, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 13, 227.67, 805.59, -24.22, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 14, 225.43, 782.14, -24.39, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 15, 217.36, 759.36, -23.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 16, 225.43, 782.14, -24.39, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 17, 227.67, 805.59, -24.22, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 18, 219.13, 812.14, -24.17, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 19, 228.22, 841.06, -23.87, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 20, 219.55, 860.39, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 21, 227.97, 877.38, -24.26, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 22, 221.87, 886.87, -24.52, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 23, 224.47, 958.78, -60.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 24, 225.26, 976.52, -61.56, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 25, 216.84, 996.08, -61.48, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 26, 229.36, 1021.73, -61.49, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 27, 216.84, 1048.74, -59.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 28, 229.4675, 1055.7926, -60.7067, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 29, 229.7791, 1071.0634, -60.7522, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13429, 30, 224.4049, 1088.6700, -60.7743, 0, 0, 0, 100, 0);

SET @GUID := 13774;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13774, 1, 229.7791, 1071.0634, -60.7522, 20000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 2, 229.4675, 1055.7926, -60.7067, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 3, 216.84, 1048.74, -59.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 4, 229.36, 1021.73, -61.49, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 5, 216.84, 996.08, -61.48, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 6, 225.26, 976.52, -61.56, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 7, 224.47, 958.78, -60.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 8, 221.87, 886.87, -24.52, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 9, 227.97, 877.38, -24.26, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 10, 219.55, 860.39, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 11, 228.22, 841.06, -23.87, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 12, 219.13, 812.14, -24.17, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 13, 227.67, 805.59, -24.22, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 14, 225.43, 782.14, -24.39, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 15, 217.36, 759.36, -23.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 16, 225.43, 782.14, -24.39, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 17, 227.67, 805.59, -24.22, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 18, 219.13, 812.14, -24.17, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 19, 228.22, 841.06, -23.87, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 20, 219.55, 860.39, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 21, 227.97, 877.38, -24.26, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 22, 221.87, 886.87, -24.52, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 23, 224.47, 958.78, -60.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 24, 225.26, 976.52, -61.56, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 25, 216.84, 996.08, -61.48, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 26, 229.36, 1021.73, -61.49, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 27, 216.84, 1048.74, -59.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 28, 229.4675, 1055.7926, -60.7067, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 29, 229.7791, 1071.0634, -60.7522, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13774, 30, 224.4049, 1088.6700, -60.7743, 0, 0, 0, 100, 0);

SET @GUID := 13403;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13403, 1, 286.43, 1048.05, -60, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 2, 274.88, 1019.67, -60.75, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 3, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 4, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 5, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 6, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 7, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 8, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 9, 275.65, 826.39, -24.41, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 10, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 11, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 12, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 13, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 14, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 15, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13403, 16, 274.88, 1019.67, -60.75, 0, 0, 0, 100, 0);

SET @GUID := 13416;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13416, 1, 295.4839, 969.7720, -60.9073, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 2, 293.6034, 980.6284, -60.4646, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 3, 276.6246, 981.1029, -60.2640, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 4, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 5, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 6, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 7, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 8, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 9, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 10, 275.65, 826.39, -24.41, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 11, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 12, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 13, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 14, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 15, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 16, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 17, 276.6246, 981.1029, -60.2640, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 18, 293.6034, 980.6284, -60.4646, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13416, 19, 295.4839, 969.7720, -60.9073, 0, 0, 0, 100, 0);

SET @GUID := 13418;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13418, 1, 295.4839, 969.7720, -60.9073, 15000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 2, 293.6034, 980.6284, -60.4646, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 3, 276.6246, 981.1029, -60.2640, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 4, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 5, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 6, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 7, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 8, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 9, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 10, 275.65, 826.39, -24.41, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 11, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 12, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 13, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 14, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 15, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 16, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 17, 276.6246, 981.1029, -60.2640, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 18, 293.6034, 980.6284, -60.4646, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13418, 19, 295.4839, 969.7720, -60.9073, 0, 0, 0, 100, 0);

SET @GUID := 13407;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13407, 1, 286.43, 1048.05, -60, 20000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 2, 274.88, 1019.67, -60.75, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 3, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 4, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 5, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 6, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 7, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 8, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 9, 275.65, 826.39, -24.41, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 10, 277.3314, 842.3016, -24.2162, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 11, 284.51, 860.11, -23.27, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 12, 276.59, 870.45, -24.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 13, 276.64, 885.94, -24.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 14, 279.9772, 924.4305, -43.3291, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 15, 276.16, 957.98, -60.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13407, 16, 274.88, 1019.67, -60.75, 0, 0, 0, 100, 0);

SET @GUID := 13410;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13410, 1, 275.65, 826.39, -24.41, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 2, 291.14, 826.66, -22.94, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 3, 332.54, 826.46, -4.84, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 4, 341.42, 824.14, -0.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 5, 349.66, 826.58, 1.78, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 6, 388.74, 826.42, 15.69, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 7, 405.79, 826.48, 14.46, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 8, 388.74, 826.42, 15.69, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 9, 349.66, 826.58, 1.78, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 10, 341.42, 824.14, -0.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 11, 332.54, 826.46, -4.84, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13410, 12, 291.14, 826.66, -22.94, 0, 0, 0, 100, 0);

SET @GUID := 13411;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13411, 1, 275.65, 826.39, -24.41, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 2, 291.14, 826.66, -22.94, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 3, 332.54, 826.46, -4.84, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 4, 341.42, 824.14, -0.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 5, 349.66, 826.58, 1.78, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 6, 388.74, 826.42, 15.69, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 7, 405.79, 826.48, 14.46, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 8, 406.1925, 844.5750, 14.6775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 9, 398.2640, 864.1204, 14.9389, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 10, 408.9743, 875.9220, 14.0330, 5000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 11, 398.2640, 864.1204, 14.9389, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 12, 406.1925, 844.5750, 14.6775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 13, 405.79, 826.48, 14.46, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 14, 388.74, 826.42, 15.69, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 15, 349.66, 826.58, 1.78, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 16, 341.42, 824.14, -0.86, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 17, 332.54, 826.46, -4.84, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13411, 18, 291.14, 826.66, -22.94, 0, 0, 0, 100, 0);

UPDATE `waypoint_data` SET `move_type` = 0 WHERE `id` = 13412;

SET @GUID := 13413;
UPDATE `creature` SET `position_x`='286.8793', `position_y`='799.1722', `position_z`='-24.2530', `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13413, 1, 279.07, 799, -24.25, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 2, 289.22, 799.62, -24.23, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 3, 346.48, 799.92, -0.28, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 4, 354.12, 798.57, 2.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 5, 389.46, 800.64, 14.13, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 6, 406.17, 799.02, 14.91, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 7, 389.46, 800.64, 14.13, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 8, 354.12, 798.57, 2.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 9, 346.48, 799.92, -0.28, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13413, 10, 289.22, 799.62, -24.23, 0, 0, 0, 100, 0);

SET @GUID := 12869;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'18950 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12869, 1, 252.726, 915.427, -41.2835, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12869, 2, 252.709, 958.494, -62.6302, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12869, 3, 252.587, 968.839, -62.6023, 3000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12869, 4, 252.709, 958.494, -62.6302, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12869, 5, 252.726, 915.427, -41.2835, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12869, 6, 252.71, 888.408, -28.1103, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12869, 7, 252.661, 875.529, -27.0654, 3000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12869, 8, 252.71, 888.408, -28.1103, 0, 0, 0, 100, 0);

UPDATE `creature` SET `position_x`='712.9567', `position_y`='387.4395', `position_z`='117.7117', `orientation`='1.5677' WHERE `guid` = 12746;
UPDATE `creature` SET `position_x`='694.8687', `position_y`='387.4951', `position_z`='117.7328', `orientation`='1.5677' WHERE `guid` = 12747; 
UPDATE `creature` SET `position_x`='697.5386', `position_y`='383.8868', `position_z`='119.9242', `orientation`='1.5677' WHERE `guid` = 12755; 
UPDATE `creature` SET `position_x`='710.2506', `position_y`='383.8477', `position_z`='119.9090', `orientation`='1.5677' WHERE `guid` = 12820;
UPDATE `creature` SET `position_x`='719.8175', `position_y`='385.3928', `position_z`='118.9384', `orientation`='1.5677' WHERE `guid` = 12833;
UPDATE `creature` SET `position_x`='687.7366', `position_y`='385.4914', `position_z`='118.9758', `orientation`='1.5677' WHERE `guid` = 12834;

SET @GUID := 12806;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12806, 1, 485.9926, 406.4437, 112.7849, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12806, 2, 488.9220, 406.4711, 112.7849, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12806, 3, 526.5108, 406.2319, 112.785, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12806, 4, 524.5601, 406.2302, 112.785, 0, 0, 0, 100, 0);


SET @GUID := 12805;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12805, 1, 526.6975, 395.3765, 112.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12805, 2, 524.4810, 395.3703, 112.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12805, 3, 485.7506, 395.6316, 112.7838, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12805, 4, 488.6212, 395.5325, 112.7838, 0, 0, 0, 100, 0);

-- those stairs drive me crazy
SET @GUID := 53800;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 575.3708, 110.8513, 139.4759,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 586.7089, 110.7460, 139.3130,5000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 575.3708, 110.8513, 139.4759,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 573.7471, 110.8180, 140.8192,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 541.8935, 110.9994, 165.9266,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 528.6511, 110.9819, 165.3688,5000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 542.1239, 111.1832, 165.9393,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 543.0819, 111.0051, 165.2134,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 573.7471, 110.8180, 140.8192,0,0,0,100,0);

SET @GUID := 53801;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 575.3708, 110.8513, 139.4759,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 580.7092, 110.8015, 139.3103,8000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 575.3708, 110.8513, 139.4759,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 573.7471, 110.8180, 140.8192,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 541.8935, 110.9994, 165.9266,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 535.1976, 110.8754, 165.7051,8000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 542.1239, 111.1832, 165.9393,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 543.0819, 111.0051, 165.2134,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 573.7471, 110.8180, 140.8192,0,0,0,100,0);

SET @GUID := 53798;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 494.1227, 170.0645, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 489.4893, 170.1348, 163.9814,0,0,0,100,0), 
(@GUID,@POINT := @POINT + 1, 437.9820, 176.2317, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 437.7856, 180.4702, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 436.4199, 209.9411, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 446.7656, 209.7393, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 494.2183, 209.3279, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 489.7312, 209.4832, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 436.4199, 209.9411, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 436.7008, 203.8786, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 437.9820, 176.2317, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 448.7488, 170.3644, 163.9814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 458.2099, 170.2440, 163.9810,0,0,0,100,0);

UPDATE `creature` SET `position_x`='817.6086', `position_y`='489.8837', `position_z`='183.3297', `orientation`='1.5514',`spawndist`='0',`movementtype`='0' WHERE `guid` = 53054;

UPDATE `creature` SET `orientation` = '0.3351' WHERE `guid` = 12810;

UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (12784,12787,12802,12808,12821,12824,12835,12840,12851,12852);

SET @GUID := 13412;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,''); -- 12873
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (13412, 1, 225.599, 787.167, -24.1854, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 2, 226.255, 784.008, -23.9493, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 3, 219.755, 774.258, -23.4493, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 4, 219.399, 766.433, -23.471, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 5, 225.785, 743.861, -23.8015, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 6, 225.859, 730.236, -15.9509, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 7, 226.609, 726.486, -13.9509, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 8, 236.528, 706.583, -4.81124, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 9, 265.267, 707.321, -4.30114, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 10, 272.355, 719.12, -10.1958, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 11, 275.13, 743.173, -24.0094, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 12, 279.329, 758.15, -23.9057, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 13, 281.99, 760.675, -23.696, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 14, 282.882, 767.979, -23.4587, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 15, 277.356, 793.042, -24.1517, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 16, 285.965, 799.731, -23.8582, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 17, 292.121, 799.703, -22.6732, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 18, 303.121, 795.203, -17.1732, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 19, 295.627, 798.385, -20.6824, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 20, 286.127, 799.635, -23.9324, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 21, 276.864, 782.945, -23.9255, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 22, 282.114, 770.695, -23.4255, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 23, 279.363, 758.279, -24.0036, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 24, 275.226, 743.77, -24.0494, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 25, 272.431, 719.382, -10.38, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 26, 266.067, 708.079, -4.45915, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 27, 258.067, 704.329, -4.95915, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 28, 236.291, 706.643, -3.6331, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 29, 226.627, 726.214, -13.6222, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 30, 225.89, 730.388, -15.9331, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 31, 226.062, 743.571, -23.9032, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 32, 220.638, 762.828, -23.166, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 33, 218.63, 769.206, -23.467, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (13412, 34, 226.297, 784.119, -24.1624, 0, 1, 0, 100, 0);

SET @GUID := 12826;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12826, 1, 608.289, 313.645, 112.705, 2000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12826, 2, 609.0838, 320.8728, 112.7056, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12826, 3, 616.423, 387.615, 112.713, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12826, 4, 645.102, 412.355, 112.713, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12826, 5, 695.16, 413.139, 112.735, 2000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12826, 6, 691.5309, 413.0821, 112.7346, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12826, 7, 645.102, 412.355, 112.713, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12826, 8, 616.423, 387.615, 112.713, 0, 0, 0, 100, 0);

SET @GUID := 12827;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12827, 1, 798.3474, 312.9170, 112.7486, 2000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12827, 2, 798.0026, 319.1691, 112.7481, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12827, 3, 796.152, 379.841, 112.747, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12827, 4, 765.0722, 410.3952, 112.7434, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12827, 5, 712.2567, 412.4319, 112.7470, 2000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12827, 6, 717.1557, 412.5141, 112.7488, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12827, 7, 765.0722, 410.3952, 112.7434, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12827, 8, 796.152, 379.841, 112.747, 0, 0, 0, 100, 0);

UPDATE `creature` SET `position_x`='558.3591', `position_y`='296.2860', `position_z`='271.6911', `orientation`='0.0527',`spawndist`='0',`movementtype`='0' WHERE `guid` = 52413;
UPDATE `creature` SET `orientation`='6.2181' WHERE `guid` = 16195;

-- ======================================================
-- Gameobjects
-- ======================================================

-- 185483


-- ======================================================
-- Miscellaneous
-- ======================================================

-- Creatures
DELETE FROM `creature_loot_template` WHERE `entry` = 22844;
INSERT INTO `creature_loot_template` VALUES (22844, 14099, 1.5, 0, -14099, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 21877, 37.85, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24012, 0.5, 1, -24012, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24015, 0.1, 1, -24015, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 32428, 13.88, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22844, 32897, 5.36, 0, 1, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` = 22845;
INSERT INTO `creature_loot_template` VALUES (22845, 14099, 1.5, 0, -14099, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 21877, 42.48, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 32428, 12.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22845, 32897, 12.41, 0, 1, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` = 22846;
INSERT INTO `creature_loot_template` VALUES (22846, 14099, 1.5, 0, -14099, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 21877, 40.1, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 32428, 6.28, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22846, 32897, 8.21, 0, 1, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` = 22847;
INSERT INTO `creature_loot_template` VALUES (22847, 14099, 1.5, 0, -14099, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 21877, 38.14, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 22153, 0.93, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 50028, 0.05, 1, -50028, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 32428, 11.63, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22847, 32897, 10.23, 0, 1, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` = 22962;
INSERT INTO `creature_loot_template` VALUES (22962, 14099, 1.5, 0, -14099, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22962, 21877, 36.02, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22962, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22962, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22962, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22962, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22962, 32428, 13.98, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22962, 32897, 5.91, 0, 1, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` = 23374;
INSERT INTO `creature_loot_template` VALUES (23374, 79, 0.01, 1, -10006, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 14099, 1.5, 0, -14099, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 21877, 41.05, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 32428, 10.92, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 32897, 10.48, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23374, 50028, 0.05, 1, -50028, 1, 0, 0, 0);

-- missing something
DELETE FROM `creature_loot_template` WHERE `entry` = 22874 AND `item` = 32897;
INSERT INTO `creature_loot_template` VALUES (22874, 32897, 8.21, 0, 1, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` = 23049 AND `item` = 50028;
INSERT INTO `creature_loot_template` VALUES (23049, 50028, 0.05, 1, -50028, 1, 0, 0, 0);

DELETE FROM `creature_loot_template` WHERE `entry` IN (23196,23147,23047,23018,22965,22963,22959,22957,22964,22956,22883,22879,23339,23330,23239,23237,23236,23235,23232,22946,23049,23222,23223) AND `item` = 14099;
INSERT INTO `creature_loot_template` VALUES
(23196, 14099, 1.5, 0, -14099, 1, 0, 0, 0),  
(23047, 14099, 1.5, 0, -14099, 1, 0, 0, 0),  
(23018, 14099, 1.5, 0, -14099, 1, 0, 0, 0),  
(22965, 14099, 1.5, 0, -14099, 1, 0, 0, 0),  
(22959, 14099, 1.5, 0, -14099, 1, 0, 0, 0),   
(22957, 14099, 1.5, 0, -14099, 1, 0, 0, 0),  
(22964, 14099, 1.5, 0, -14099, 1, 0, 0, 0), 
(22956, 14099, 1.5, 0, -14099, 1, 0, 0, 0), 
(22879, 14099, 1.5, 0, -14099, 1, 0, 0, 0),
(23339, 14099, 1.5, 0, -14099, 1, 0, 0, 0),
(23330, 14099, 1.5, 0, -14099, 1, 0, 0, 0),  
(23239, 14099, 1.5, 0, -14099, 1, 0, 0, 0), 
(23237, 14099, 1.5, 0, -14099, 1, 0, 0, 0),
(23236, 14099, 1.5, 0, -14099, 1, 0, 0, 0), 
(23235, 14099, 1.5, 0, -14099, 1, 0, 0, 0), 
(23232, 14099, 1.5, 0, -14099, 1, 0, 0, 0),
(22946, 14099, 1.5, 0, -14099, 1, 0, 0, 0),
(23049, 14099, 1.5, 0, -14099, 1, 0, 0, 0),
(23222, 14099, 1.5, 0, -14099, 1, 0, 0, 0),
(23223, 14099, 1.5, 0, -14099, 1, 0, 0, 0);


-- Boss Loot Changes

-- Mother Shahraz Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 22947 AND `item` = 34076;

-- Council
DELETE FROM `creature_loot_template` WHERE `entry` IN (22949,22950,22952);
INSERT INTO `creature_loot_template` VALUES (22949, 31098, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22949, 31099, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22949, 31100, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22950, 29434, 100, 0, 2, 2, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (22950, 31098, 0, 2, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (22950, 31099, 0, 2, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (22950, 31100, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22950, 32331, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22950, 32373, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22950, 32376, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22950, 32505, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22950, 32518, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22950, 32519, 0, 1, 1, 1, 0, 0, 0);
-- 22951 Epic GEM
-- INSERT INTO `creature_loot_template` VALUES (22952, 31098, 0, 1, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (22952, 31099, 0, 1, 1, 1, 0, 0, 0);
-- INSERT INTO `creature_loot_template` VALUES (22952, 31100, 0, 1, 1, 1, 0, 0, 0);

-- Illidan Stormrage <The Betrayer> Token
DELETE FROM `creature_loot_template` WHERE `entry` = 22917 AND `item` IN (90077,90078);
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 22917 AND `item` = 34077;

-- Badge of Justice for Hyjal and BT
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` IN (22887,22898,22841,22871,22948,22856,22947,23426,22917,23420,22950,17767,17808,17842,17888,17968) AND `item` = 29434;

-- ===========
-- Overall Loot Issues
-- ===========

-- epics which should not be listed directly in creature_loot_template
-- includes random epics and patterns and epic gems
DELETE FROM `creature_loot_template` WHERE `item` IN (32526,32527,32528,32589,32590,32591,32592,32593,32606,32608,32609,32943,32945,32946,34009,34010,34011,34012,32736,32737,32738,32739,32744,32745,32746,32747,32748,32749,32750,32751,32752,32753,32754,32755);

DELETE FROM `reference_loot_template` WHERE `entry` = 14099 AND `item` = 32526;
INSERT INTO `reference_loot_template` VALUES
(14099, 32526, 0, 1, 1, 1, 0, 0, 0);

-- BT Random Epics Reference -14099 9 out of 18
-- Hyjal Random Epics Reference -39534 9 out of 18
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 2 WHERE `mincountOrRef` IN (-14099,-39534); -- 1.5 / 2

-- no need for patterns in the hyjal random epic items template
DELETE FROM `reference_loot_template` WHERE `entry` = 39534 AND `item` IN (32736,32739,32745,32746,32748,32751,32752,32755);

-- Pattern Drop Reference Loot Template some drop only Hyjal(3&4) some drop only BT(1&2)
-- Some have Profession Loot Restrictions with higher % (creature_loot)(Groupid 1&3) some have no Restrictions but lower % (Groupid 2&4)
DELETE FROM `reference_loot_template` WHERE `entry` = 34069;
INSERT INTO `reference_loot_template` VALUES (34069, 32736, 0, 3, 1, 1, 7, 164, 1); -- Hyjal only
INSERT INTO `reference_loot_template` VALUES (34069, 32739, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34069, 32745, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34069, 32746, 0, 3, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34069, 32748, 0, 3, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34069, 32751, 0, 4, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34069, 32752, 0, 3, 1, 1, 7, 197, 1);
INSERT INTO `reference_loot_template` VALUES (34069, 32755, 0, 4, 1, 1, 0, 0, 0);

INSERT INTO `reference_loot_template` VALUES (34069, 32737, 0, 2, 1, 1, 0, 0, 0); -- BT only
INSERT INTO `reference_loot_template` VALUES (34069, 32738, 0, 1, 1, 1, 7, 164, 1);
INSERT INTO `reference_loot_template` VALUES (34069, 32744, 0, 1, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34069, 32747, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34069, 32749, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34069, 32750, 0, 1, 1, 1, 7, 165, 1);
INSERT INTO `reference_loot_template` VALUES (34069, 32753, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (34069, 32754, 0, 1, 1, 1, 7, 197, 1);

-- Patterns
DELETE FROM `creature_loot_template` WHERE `mincountOrRef` =  -34069;
INSERT INTO `creature_loot_template` VALUES

-- Hyjal 3&4
(17895, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17895, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17897, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17897, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17898, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17898, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17899, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17899, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17905, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17905, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17906, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17906, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17907, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17907, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17908, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17908, 90069, 1, 4, -34069, 1, 0, 0, 0),

(17916, 34069, 2, 3, -34069, 1, 0, 0, 0),
(17916, 90069, 1, 4, -34069, 1, 0, 0, 0),

-- BT 1&2
(22844, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22844, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22845, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22845, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22846, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22846, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22847, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22847, 90069, 1, 2, -34069, 1, 0, 0, 0), 

(22853, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22853, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22855, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22855, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22869, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22869, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22879, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22879, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22880, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22880, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22882, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22882, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22939, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22939, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22945, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22945, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22946, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22946, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22953, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22953, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22954, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22954, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22955, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22955, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22956, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22956, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22957, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22957, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22959, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22959, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22962, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22962, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22964, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22964, 90069, 1, 2, -34069, 1, 0, 0, 0),

(22965, 34069, 2, 1, -34069, 1, 0, 0, 0),
(22965, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23018, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23018, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23047, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23047, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23049, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23049, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23172, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23172, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23196, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23196, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23222, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23222, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23223, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23223, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23232, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23232, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23235, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23235, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23236, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23236, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23237, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23237, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23239, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23239, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23330, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23330, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23337, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23337, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23339, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23339, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23374, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23374, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23394, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23394, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23397, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23397, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23400, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23400, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23402, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23402, 90069, 1, 2, -34069, 1, 0, 0, 0),

(23403, 34069, 2, 1, -34069, 1, 0, 0, 0),
(23403, 90069, 1, 2, -34069, 1, 0, 0, 0);

-- Heart of Darkness 32428 seems ok
-- Mark of the Illidari 32897 seems ok

-- Epic GEMs
DELETE FROM `creature_loot_template` WHERE `item` IN (32227,32228,32229,32230,32231,32249);

DELETE FROM `creature_loot_template` WHERE `mincountOrRef` = -34093;
INSERT INTO `creature_loot_template` VALUES
(22844, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22845, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22846, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22847, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22853, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22855, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22869, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22873, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22874, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22875, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22876, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22877, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22878, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22879, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22880, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22881, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22882, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22884, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22885, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22939, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22945, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22946, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22951, 34093, 100, 1, -34093, 1, 0, 0, 0),
(22953, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22954, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22955, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22956, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22957, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22959, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22964, 34093, 6, 1, -34093, 1, 0, 0, 0),
(22965, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23018, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23047, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23049, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23172, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23196, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23222, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23223, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23232, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23235, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23236, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23237, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23239, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23330, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23337, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23339, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23394, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23397, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23400, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23402, 34093, 6, 1, -34093, 1, 0, 0, 0),
(23403, 34093, 6, 1, -34093, 1, 0, 0, 0),
(25593, 34093, 6, 1, -34093, 1, 0, 0, 0),
(25595, 34093, 6, 1, -34093, 1, 0, 0, 0);

-- https://github.com/Looking4Group/L4G_Core/issues/641
-- http://hellfire-tbc.com/hellfire2/forums/showthread.php?tid=2477
-- =============================
-- Caverns of Time: Hyjal Summit
-- =============================

-- ======================================================
-- Texts & Scripts
-- ======================================================

UPDATE `creature_ai_texts` SET `content_loc3` = 'Lasst diese Monster kalten Stahl schmecken!' WHERE `entry` = -985;

-- -XXX- -XXX
-- DELETE FROM `creature_ai_texts` WHERE `entry` IN ('XXX');
-- INSERT INTO `creature_ai_texts` VALUES
-- (-XXX,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'HyjalPlatzhalter'),
-- (-XXX,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'HyjalPlatzhalter'),

-- Shadowy Necromancer says: A pleasure... to serve the master.
-- Shadowy Necromancer says: My life... to the master.
-- Shadowy Necromancer says: Rise, my soldiers, and march for me!
-- Shadowy Necromancer says: You will... ultimately fail.

-- Lady Jaina Proudmoore yells: Hold them back as long as possible!
-- Lady Jaina Proudmoore yells: We have won valuable time. Now we must pull back.
-- Lady Jaina Proudmoore yells: We must hold strong!

-- Thrall yells: Bring the fight to me and pay with your lives!
-- Thrall yells: I will lay down for no one!
-- Thrall yells: It is over! Withdraw! We have failed....

-- Banshee says: I am... released?
-- Banshee says: Is it really... over?
-- Banshee says: Let this torment end!!

-- ======================================================
-- Spawns
-- ======================================================

DELETE FROM `creature` WHERE `guid` IN (27135,48568,49995,256773,51861,52942,52943,48425);
INSERT INTO `creature` VALUES (27135, 4646, 1, 1, 9420, 0, -2239.72, 2411.1, 54.4443, 2.60245, 300, 5, 0, 1163, 0, 0, 1);
INSERT INTO `creature` VALUES (48568, 17919, 534, 1, 0, 0, 5017.48, -1737.11, 1324.66, 2.52227, 120, 0, 0, 20700, 0, 0, 0);
INSERT INTO `creature` VALUES (49995, 17921, 534, 1, 0, 0, 5026.87, -1841.01, 1322.42, 5.12241, 120, 0, 0, 16200, 0, 0, 0);
INSERT INTO `creature` VALUES (51861, 23437, 534, 1, 0, 0, 4206.96, -4174.64, 870.099, 1.40248, 120, 0, 0, 9800, 0, 0, 0);
INSERT INTO `creature` VALUES (52942, 17852, 534, 1, 0, 1048, 5449.97, -2723.77, 1485.67, 5.8858, 300, 0, 0, 455250, 50805, 0, 0);
INSERT INTO `creature` VALUES (52943, 17936, 534, 1, 0, 0, 5454.07, -2713.43, 1485.8, 5.6903, 120, 0, 0, 20700, 22716, 0, 0);
INSERT INTO `creature` VALUES (48425, 17922, 534, 1, 0, 0, 5078.84, -1795.86, 1320.79, 3.16519, 120, 0, 0, 18000, 32382, 0, 0);

-- extra population
SET @GUID:= 190000;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+10; --

-- Soldiers 
INSERT INTO `creature` VALUES (@GUID := @GUID + 0, 17919, 534, 1, 0, 0, 4989.3134, -1751.1210, 1331.4525, 1.7154, 120, 0, 0, 41916, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17919, 534, 1, 0, 0, 4976.4956, -1752.9862, 1330.7408, 1.7154, 120, 0, 0, 41916, 0, 0, 0);

INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17898, 534, 1, 0, 0, 4952.2651, -1494.8516, 1330.1817, 5.2065, 7200, 0, 0, 179525, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17898, 534, 1, 0, 0, 4958.9140, -1511.6903, 1328.3854, 2.0570, 7200, 0, 0, 179525, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17898, 534, 1, 0, 0, 4992.3203, -1499.5684, 1328.3745, 1.8764, 7200, 0, 0, 179525, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17898, 534, 1, 0, 0, 4983.8198, -1480.2349, 1334.1741, 5.1790, 7200, 0, 0, 179525, 0, 0, 0);

INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17895, 534, 1, 0, 0, 5038.4184, -1407.9271, 1339.4877, 1.7318, 120, 5, 0, 139720, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17895, 534, 1, 0, 0, 5043.3632, -1400.0614, 1341.4854, 1.7318, 120, 5, 0, 139720, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 17895, 534, 1, 0, 0, 5024.8886, -1411.1236, 1339.9748, 1.9478, 120, 5, 0, 139720, 0, 0, 1);

-- ======================================================
-- NPC Research
-- Trash /1.25
-- ======================================================

-- Druid of the Talon 3794
-- wooden staff
UPDATE `creature_template` SET `AIName`='EventAI',`flags_extra`='0' WHERE `entry` = '3794';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '3794';
INSERT INTO `creature_ai_scripts` VALUES
('379401','3794','9','0','100','0','8','40','2400','4800','11','31784','1','0','0','0','0','0','0','0','0','0','Druid of the Talon - Cast Wrath'),
('379402','3794','9','0','100','3','0','30','30000','33000','11','25602','4','32','0','0','0','0','0','0','0','0','Druid of the Talon - Cast Faerie Fire');

-- Druid of the Claw 3795
UPDATE `creature_template` SET `AIName`='EventAI',`flags_extra`='0' WHERE `entry` = '3795';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '3795';
INSERT INTO `creature_ai_scripts` VALUES
('379501','3795','4','0','100','2','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Druid of the Claw - Set Phase 1 on Aggro'),
('379502','3795','14','5','100','3','5000','40','4000','8000','11','31782','6','0','0','0','0','0','0','0','0','0','Druid of the Claw - Cast Rejuvenation on Friendlies (Phase 1)'),
('379503','3795','2','5','100','3','95','0','12000','15000','11','31782','0','0','0','0','0','0','0','0','0','0','Druid of the Claw - Cast Rejuvenation on Self (Phase 1)'),
('379504','3795','2','0','100','2','50','0','0','0','11','31792','0','1','22','2','0','0','0','0','0','0','Druid of the Claw - Cast Bear Form and Set Phase 2 on 50% Health'),
('379505','3795','3','0','100','2','5','0','0','0','11','31792','0','1','22','2','0','0','0','0','0','0','Druid of the Claw - Cast Bear Form and Set Phase 2 on 5% Mana'),
('379506','3795','7','0','100','2','0','0','0','0','28','0','31792','0','0','0','0','0','0','0','0','0','Druid of the Claw - Remove Bear Form on Evade');

-- Tyrande Whisperwind 7999
-- not hyjal darnassus version
UPDATE `creature_template` SET `AIName`='EventAI',`flags_extra`='0' WHERE `entry` = '7999'; -- 3
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '7999';
INSERT INTO `creature_ai_scripts` VALUES
('799901','7999','9','0','100','3','0','15','6000','8000','11','20691','1','0','0','0','0','0','0','0','0','0','Tyrande Whisperwind - Cast Cleave'),
('799902','7999','9','0','100','3','0','30','16000','21000','11','20687','4','1','0','0','0','0','0','0','0','0','Tyrande Whisperwind - Cast Starfall'),
('799903','7999','0','0','100','3','9000','12000','17000','22000','11','20690','5','0','0','0','0','0','0','0','0','0','Tyrande Whisperwind - Cast Moonfire'),
('799904','7999','0','0','100','3','11000','14000','9000','12000','11','20688','2','1','0','0','0','0','0','0','0','0','Tyrande Whisperwind - Cast Searing Arrow');

-- Echo of Archimonde 13083
-- UPDATE `creature_template` SET  WHERE `entry` = '';

-- Lady Jaina Proudmoore 17772- npc_jaina_proudmoore
UPDATE `creature_template` SET `armor`='6350' WHERE `entry` = 17772;

-- Thrall 17852- npc_thrall

-- Dire Wolf 17854
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 17854;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17854;
INSERT INTO `creature_ai_scripts` VALUES
('1785401','17854','9','0','100','3','0','5','9000','14000','11','31334','1','0','0','0','0','0','0','0','0','0','Dire Wolf - Cast Growl');

-- Ghoul 17895- mob_ghoul
-- http://wowwiki.wikia.com/wiki/Ghoul_(Hyjal)
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='2700',`maxdmg`='2940',`mechanic_immune_mask`='8388625',`flags_extra`='1073741824' WHERE `entry` = 17895; -- 1.2 2200 2500 -- 3375 - 3675
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='3' WHERE `creature_id` = 17895; -- 12 in 2.4

-- Crypt Fiend 17897- mob_crypt_fiend
-- http://wowwiki.wikia.com/wiki/Crypt_Fiend_(Hyjal)
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='3791',`maxdmg`='3958',`mechanic_immune_mask`='8388625',`flags_extra`='1073741824' WHERE `entry` = 17897; -- 1.2 3750 4000 -- 5687 - 5937 /1.5

-- Abomination 17898- mob_abomination
-- http://wowwiki.wikia.com/wiki/Abomination_(Hyjal)
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='6300',`maxdmg`='6540',`mechanic_immune_mask`='8388625',`flags_extra`='1073741824' WHERE `entry` = 17898; -- 1.2 5200 5500 1400 -- 7875 - 8175

-- Shadowy Necromancer 17899- mob_necromancer
-- http://wowwiki.wikia.com/wiki/Shadowy_Necromancer_(Hyjal)
UPDATE `creature_template` SET `armor`='5450',`speed`='1.20',`mindmg`='2995',`maxdmg`='3795' WHERE `entry` = 17899; -- 0 1.2 3230 4230 -- 3744 - 4744

-- Skeleton Invader 17902
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='1201',`maxdmg`='1457',`mechanic_immune_mask`='8388625' WHERE `entry` = 17902; -- 1.2 408 921 -- 2,401 - 2,914 /2
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 3 WHERE `creature_id` = 17902;

-- Skeleton Mage 17903
UPDATE `creature_template` SET `armor`='5450',`speed`='1.20',`mindmg`='941',`maxdmg`='1158',`AIName`='EventAI',`mechanic_immune_mask`='8388625' WHERE `entry` = 17903; -- 0 1.2 308 742 -- 1,881 - 2,315 /2
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 3 WHERE `creature_id` = 17903;
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` = 17903;
INSERT INTO `creature_ai_scripts` (`id`,`entryOrGUID`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
('1790301','17903','0','0','100','2','0','0','0','0','30','1','2','3','0','0','0','0','0','0','0','0','Skeleton Mage - Select Random Phase on Aggro'),
('1790302','17903','9','6','100','3','0','40','3400','4800','11','31622','1','0','0','0','0','0','0','0','0','0','Skeleton Mage - Cast Frostbolt (Phase 1)'),
('1790303','17903','9','5','100','3','0','40','3400','4800','11','31620','1','0','0','0','0','0','0','0','0','0','Skeleton Mage - Cast Fireball (Phase 2)'),
('1790304','17903','9','3','100','3','0','40','3400','4800','11','31618','1','0','0','0','0','0','0','0','0','0','Skeleton Mage - Cast Shadowbolt (Phase 3)');

-- Banshee 17905- mob_banshee
-- http://wowwiki.wikia.com/wiki/Banshee_(Hyjal)
UPDATE `creature_template` SET `speed`='1.2',`mindmg`='1531',`maxdmg`='1817',`mechanic_immune_mask`='8388625' WHERE `entry` = 17905; -- 1.2 826 1685 -- 4,592 - 5,451 /3

-- Gargoyle 17906- mob_gargoyle
-- http://wowwiki.wikia.com/wiki/Gargoyle_(Hyjal)
UPDATE `creature_template` SET `speed`='1.2',`mindmg`='2474',`maxdmg`='2938',`mechanic_immune_mask`='8388625' WHERE `entry` = 17906; -- 1.2 1334 2726 -- 7,422 - 8,814 /3 

-- Frost Wyrm 17907- mob_frost_wyrm
-- http://wowwiki.wikia.com/wiki/Frost_Wyrm_(Hyjal)
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='9222',`maxdmg`='10953',`mechanic_immune_mask`='652967935',`flags_extra`='1078001664' WHERE `entry` = 17907; -- 1.2 2071 4234 -- 11528 - 13691

-- Giant Infernal 17908- mob_giant_infernal
-- http://wowwiki.wikia.com/wiki/Giant_Infernal_(Hyjal)
UPDATE `creature_template` SET `speed`='1.2',`mindmg`='1400',`maxdmg`='1600',`dmgschool`='2',`mechanic_immune_mask`='14341' WHERE `entry` = 17908; -- 1.2 678 1386 -- 3,774 - 4,482

-- Fel Stalker 17916- mob_fel_stalker
-- http://wowwiki.wikia.com/wiki/Fel_Stalker_(Hyjal)
UPDATE `creature_template` SET `speed`='1.2',`mindmg`='1392',`maxdmg`='1653' WHERE `entry` = 17916; -- 1.2 1000 2045 -- 5,567 - 6,612 /4

-- Alliance Footman 17919
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17919;
UPDATE `creature_template` SET `armor` = 6800 WHERE `entry` = 17919; -- 0
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17919;
INSERT INTO `creature_ai_scripts` VALUES
(1791901, 17919, 0, 0, 100, 3, 4000, 8000, 16000, 25000, 11, 31731, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Footman - Cast Shield Wall'),
(1791902, 17919, 4, 0, 25, 2, 0, 0, 0, 0, 1, -985, -986, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Footman - Say on Aggro'),
(1791903, 17919, 6, 0, 25, 2, 0, 0, 0, 0, 1, -987, -988, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Footman - Say on Death'),
(1791904, 17919, 12, 0, 25, 2, 2, 0, 0, 0, 1, -989, -990, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Footman - Say on Kill');

-- Alliance Knight 17920
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17920;
UPDATE `creature_template` SET `armor` = 6200, `speed` = '1.20' WHERE `entry` = 17920; -- 0 2
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17920;
INSERT INTO `creature_ai_scripts` VALUES
(1792001, 17920, 0, 0, 100, 3, 1000, 3000, 21000, 35000, 11, 31732, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Knight - Cast Rallying Cry'),
(1792002, 17920, 4, 0, 25, 2, 0, 0, 0, 0, 1, -977, -978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Knight - Say on Aggro'),
(1792003, 17920, 6, 0, 25, 2, 0, 0, 0, 0, 1, -979, -980, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Knight - Say on Death'),
(1792004, 17920, 12, 0, 25, 2, 2, 0, 0, 0, 1, -981, -982, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Knight - Say on Kill');

-- Alliance Rifleman 17921- alliance_rifleman
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17921;

-- Alliance Sorceress 17922
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17922;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17922;
INSERT INTO `creature_ai_scripts` VALUES
('1792201','17922','4','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Alliance Sorceress - Set Phase 1 on Aggro'),
('1792202','17922','9','5','100','3','8','30','3400','4800','11','31743','1','0','0','0','0','0','0','0','0','0','Alliance Sorceress - Cast Arcane Missile (Phase 1)'),
('1792203','17922','3','5','100','2','7','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Alliance Sorceress - Set Phase 2 when Mana is at 7% (Phase 1)'),
('1792204','17922','3','3','100','3','100','15','1000','1000','22','1','0','0','0','0','0','0','0','0','0','0','Alliance Sorceress - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1792205','17922','0','0','100','3','10000','14000','13000','18000','11','31741','4','32','0','0','0','0','0','0','0','0','Alliance Sorceress - Cast Slow'),
('1792206','17922','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Alliance Sorceress - Set Phase to 0 on Evade'),
(1792207, 17922, 6, 0, 25, 0, 0, 0, 0, 0, 1, -991, -992, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Sorceress - Say on Death');

-- Alliance Priest 17928
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17928;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17928;
INSERT INTO `creature_ai_scripts` VALUES
('1792801','17928','4','0','100','2','0','0','0','0','22','1','0','0','21','0','0','0','0','0','0','0','Alliance Priest - Set Phase 1 and Stop Movement on Aggro'),
('1792802','17928','9','5','100','3','8','40','3400','4800','11','31740','1','0','0','0','0','0','0','0','0','0','Alliance Priest - Cast Holy Smite (Phase 1)'),
('1792803','17928','3','5','100','2','7','0','0','0','21','1','0','0','22','2','0','0','0','0','0','0','Alliance Priest - Enable Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('1792804','17928','3','3','100','3','100','15','1000','1000','22','1','0','0','21','0','0','0','0','0','0','0','Alliance Priest - Set Phase 1 and Disable Movement when Mana is above 15% (Phase 2)'),
('1792805','17928','14','0','100','3','15000','40','15000','21000','11','31739','6','1','0','0','0','0','0','0','0','0','Alliance Priest - Cast Heal on Friendlies'),
('1792806','17928','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Alliance Priest - Set Phase to 0 on Evade'),
(1792807, 17928, 6, 0, 15, 0, 0, 0, 0, 0, 1, -983, -984, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Alliance Priest - Say on Death');

-- Alliance Peasant 17931
-- http://www.wowhead.com/npc=17931/alliance-peasant#english-comments
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17931;
DELETE FROM `creature_template_addon` WHERE `entry` = 17931;
INSERT INTO `creature_template_addon` VALUES
(17931,0,0,0,0,4097,173,0,'');

-- Horde Grunt 17932
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17932;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17932;
INSERT INTO `creature_ai_scripts` VALUES 
(1793201, 17932, 9, 0, 100, 3, 0, 5, 10000, 15000, 11, 31754, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Grunt - Cast Strike'),
(1793202, 17932, 4, 0, 25, 0, 0, 0, 0, 0, 1, -800, -801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Grunt - Text on Aggro'),
(1793203, 17932, 6, 0, 25, 0, 0, 0, 0, 0, 1, -802, -803, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Grunt - Text on Death'),
(1793204, 17932, 12, 0, 25, 0, 2, 0, 500, 1000, 1, -804, -805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Grunt - Text on Kill');

-- Tauren Warrior 17933
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17933;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17933;
INSERT INTO `creature_ai_scripts` VALUES
('1793301','17933','9','0','100','3','0','15','7000','11000','11','31755','0','0','0','0','0','0','0','0','0','0','Tauren Warrior - Cast War Stomp'),
(1793302, 17933, 4, 0, 25, 0, 0, 0, 0, 0, 1, -971, -972, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Warrior - Say on Aggro'),
(1793303, 17933, 6, 0, 25, 0, 0, 0, 0, 0, 1, -973, -974, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Warrior - Say on Death'),
(1793304, 17933, 12, 0, 25, 0, 2, 0, 500, 1000, 1, -975, -976, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tauren Warrior - Say on Kill');

-- Horde Headhunter 17934
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17934;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17934;
INSERT INTO `creature_ai_scripts` VALUES
('1793401','17934','0','0','100','3','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Horde Headhunter - Start Movement and Set Melee Weapon Model'),
('1793402','17934','9','0','100','3','8','40','3000','4500','11','31758','4','0','40','2','0','0','21','0','0','0','Horde Headhunter - Cast Spear Throw and Set Ranged Weapon Model and Stop Movement'),
('1793403','17934','9','0','100','3','0','8','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Horde Headhunter - Start Movement and Set Melee Weapon Model Below 8 Yards'),
('1793404','17934','7','0','100','0','0','0','0','0','21','1','0','0','40','1','0','0','21','1','0','0','Horde Headhunter - Start Movement and Set Melee Weapon Model on Evade'),
('1793405','17934','9','0','100','3','8','40','0','0','21','0','0','0','40','2','0','0','0','0','0','0','Horde Headhunter - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 8 Yards'),
(1793406, 17934, 4, 0, 25, 0, 0, 0, 0, 0, 1, -965, -966, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Headhunter - Say on Aggro'),
(1793407, 17934, 6, 0, 25, 0, 0, 0, 0, 0, 1, -967, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Headhunter - Say on Death'),
(1793408, 17934, 12, 0, 25, 0, 2, 0, 500, 1000, 1, -968, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Headhunter - Say on Kill');

-- Horde Witch Doctor 17935
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17935;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17935;
INSERT INTO `creature_ai_scripts` VALUES
('1793501','17935','4','0','100','2','0','0','0','0','11','31760','0','0','0','0','0','0','0','0','0','0','Horde Witch Doctor - Cast Healing Ward on Aggro'),
('1793502','17935','9','0','100','3','8','40','3400','4800','11','31759','1','0','0','0','0','0','0','0','0','0','Horde Witch Doctor - Cast Holy Bolt'),
('1793503','17935','0','0','100','3','11000','16000','30000','36000','11','31760','0','33','0','0','0','0','0','0','0','0','Horde Witch Doctor - Cast Healing Ward'),
(1793504, 17935, 6, 0, 25, 0, 0, 0, 0, 0, 1, -970, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Witch Doctor - Say on Death');

-- Horde Shaman 17936
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17936;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17936;
INSERT INTO `creature_ai_scripts` VALUES
('1793601','17936','1','0','100','3','1000','1000','600000','600000','11','31765','0','1','0','0','0','0','0','0','0','0','Horde Shaman - Cast Lightning Shield OOC'),
('1793602','17936','9','0','100','3','8','40','3400','4800','11','31764','1','0','0','0','0','0','0','0','0','0','Horde Shaman - Cast Lightning Bolt'),
('1793603','17936','0','0','100','3','14000','26000','40000','55000','11','6742','0','1','0','0','0','0','0','0','0','0','Horde Shaman - Cast Bloodlust'),
('1793604','17936','16','0','100','3','31765','1','15000','30000','11','31765','0','33','0','0','0','0','0','0','0','0','Horde Shaman - Cast Lightning Shield on Missing Buff'),
(1793605, 17936, 6, 0, 25, 0, 0, 0, 0, 0, 1, -969, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Horde Shaman - Say on Death');

-- Horde Peon 17937
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 17937;
DELETE FROM `creature_template_addon` WHERE `entry` = 17937;
INSERT INTO `creature_template_addon` VALUES
(17937,0,0,0,0,4097,173,0,'');

-- Night Elf Archer 17943
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 17943;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17943;
INSERT INTO `creature_ai_scripts` VALUES
('1794301','17943','0','0','100','3','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Night Elf Archer - Start Movement and Set Melee Weapon Model'),
('1794302','17943','9','0','100','3','8','40','3000','4500','11','32103','4','0','40','2','0','0','21','0','0','0','Night Elf Archer - Cast Shoot and Set Ranged Weapon Model and Stop Movement'),
('1794303','17943','9','0','100','3','0','8','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Night Elf Archer - Start Movement and Set Melee Weapon Model Below 8 Yards'),
('1794304','17943','7','0','100','0','0','0','0','0','21','1','0','0','40','1','0','0','21','1','0','0','Night Elf Archer - Start Movement and Set Melee Weapon Model on Evade'),
('1794305','17943','9','0','100','3','8','40','0','0','21','0','0','0','40','2','0','0','0','0','0','0','Night Elf Archer - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 8 Yards');

-- Dryad 17944

-- Night Elf Huntress 17945
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 17945;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17945;
INSERT INTO `creature_ai_scripts` VALUES
('1794501','17945','9','0','100','3','0','5','6000','10000','11','31779','1','0','0','0','0','0','0','0','0','0','Night Elf Huntress - Cast Cleave');

-- Ancient Wisp 17946- mob_ancient_wisp

-- Tyrande Whisperwind 17948- npc_tyrande_whisperwind

-- Guardian Water Elemental 18001

-- Horde Healing Ward 18036- POSSIBLE HEALING SPELL CASTS?

-- Night Elf Ancient of War 18485

-- Night Elf Ancient of Lore 18486

-- Night Elf Ancient Protector 18487
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 18487;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18487;
INSERT INTO `creature_ai_scripts` VALUES
('1848701','18487','9','0','100','3','0','30','9000','14000','11','11922','4','32','0','0','0','0','0','0','0','0','Night Elf Ancient Protector - Cast Entangling Roots'),
('1848702','18487','9','0','100','3','0','5','8000','12000','11','45','0','1','0','0','0','0','0','0','0','0','Night Elf Ancient Protector - Cast War Stomp');

-- Night Elf Wisp 18502
UPDATE `creature_template` SET `Inhabittype`='7' WHERE `entry` = 18502;

-- Tydormu 23381

-- Indormi 23437
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (51861);

-- ==============
-- Bosses
-- /2.5
-- ==============

-- Rage Winterchill 17767- boss_rage_winterchill
-- http://wow.gamepedia.com/index.php?title=Rage_Winterchill_(tactics)&direction=next&oldid=725383
-- https://web.archive.org/web/20100907205436/http://www.hordeguides.de/Schlachtzug/TBC/Boss/17767/Furor-Winterfrost/index.htm
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='9796',`maxdmg`='11608',`mechanic_immune_mask`='650854231' WHERE `entry` = 17767; -- 4398 8969 -- ~5626 6563! -- 24,449 - 29,020 /2.5

-- Anetheron 17808- boss_anetheron
-- https://web.archive.org/web/20100907205442/http://www.hordeguides.de/Schlachtzug/TBC/Boss/17808/Anetheron/index.htm
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='10867',`maxdmg`='12898',`mechanic_immune_mask`='650854263' WHERE `entry` = 17808; -- 4888 9966 -- ~6082 12163! -- 27,167 - 32,245

-- Towering Infernal 17818- mob_towering_infernal
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4616',`maxdmg`='5482',`flags_extra`=`flags_extra`|1073741824 WHERE `entry` = 17818; -- 2073 4238 -- 11,539 - 13,704

-- Kaz'rogal 17888- boss_kazrogal
-- https://web.archive.org/web/20100907205452/http://www.hordeguides.de/Schlachtzug/TBC/Boss/17888/Kazrogal/index.htm
-- Warstomp cant be fixed as spell range is calculated from bounding radius.
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6792',`maxdmg`='8061',`mechanic_immune_mask`='650854387' WHERE `entry` = 17888; -- 4888 9966 -- 8717 10744 -- 10867 12898 -- 27,167 - 32,245 /4
UPDATE `creature_model_info` SET `bounding_radius` = 13, `combat_reach` = 13 WHERE `modelid` = 17886; -- 0

-- Azgalor 17842- boss_azgalor
-- https://web.archive.org/web/20100907205446/http://www.hordeguides.de/Schlachtzug/TBC/Boss/17842/Azgalor/index.htm
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='16957',`maxdmg`='19292',`equipment_id`='1566',`mechanic_immune_mask`='650854259' WHERE `entry` = 17842; -- 13000 20000 -- 50,876 - 57,876 /3

-- Lesser Doomguard 17864- mob_lesser_doomguard
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='2675',`maxdmg`='3176',`mechanic_immune_mask`='1056914431',`flags_extra`='1078001664' WHERE `entry` = 17864; -- 1443 2945 -- 8025 - 9527

-- Archimonde 17968- boss_archimonde
-- https://web.archive.org/web/20100907205458/http://www.hordeguides.de/Schlachtzug/TBC/Boss/17968/Archimonde/index.htm
UPDATE `creature_template` SET `speed`='2.4',`mindmg`='18182',`maxdmg`='21242',`mechanic_immune_mask`='650854399' WHERE `entry` = 17968; -- 2 17786 21242 -- 15204 20271 -- 54,547 - 58,003

-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================

DELETE FROM `creature_addon` WHERE `guid` IN (49163,49164,49988,49995);
INSERT INTO `creature_addon` VALUES 
(49163,0,0,512,0,4097,333,0,''),
(49164,0,0,512,0,4097,333,0,''),
(49988,0,0,512,0,4097,214,0,''),
(49995,0,0,512,0,4097,214,0,'');

UPDATE `creature` SET `position_x`='5183.02', `position_y`='-3382.98', `position_z`='1638.14', `orientation`='6.03443',`spawndist`='0',`movementtype`='0' WHERE `guid` = 52080;

-- Delete wrong movement
DELETE FROM `creature_addon` WHERE `guid` = 51475;

SET @GUID := 48408;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5542.7763, -2623.4787, 1480.8839,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5544.7011, -2616.4560, 1480.6052,25000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5542.7763, -2623.4787, 1480.8839,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5524.6240, -2658.0793, 1479.7385,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5524.1284, -2672.3625, 1478.6580,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5535.5302, -2710.9177, 1480.4343,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5525.7451, -2731.6071, 1483.6087,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5511.0634, -2746.2360, 1486.3032,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5455.3535, -2776.0166, 1494.2977,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5429.9252, -2797.3664, 1499.1535,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5412.1474, -2830.4309, 1507.4825,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5413.0126, -2852.3854, 1512.1518,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5409.5488, -2853.1596, 1512.4718,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5363.7841, -2861.5798, 1512.8094,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5366.8540, -2860.8496, 1512.8094,25000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5413.0126, -2852.3854, 1512.1518,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5413.2294, -2846.2573, 1510.8695,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5412.1474, -2830.4309, 1507.4825,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5429.9252, -2797.3664, 1499.1535,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5455.3535, -2776.0166, 1494.2977,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5511.0634, -2746.2360, 1486.3032,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5525.7451, -2731.6071, 1483.6087,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5535.5302, -2710.9177, 1480.4343,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5524.1284, -2672.3625, 1478.6580,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5524.6240, -2658.0793, 1479.7385,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5542.7763, -2623.4787, 1480.8839,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5544.7011, -2616.4560, 1480.6052,0,0,0,100,0);

UPDATE `creature` SET `position_x`='5380.7304', `position_y`='-2784.2524', `position_z`='1500.9121', `orientation`='4.4290' WHERE `guid` = 52949;
UPDATE `creature` SET `position_x`='5593.1992', `position_y`='-2715.9479', `position_z`='1495.6308', `orientation`='0.6714' WHERE `guid` = 53013;

SET @GUID := 51901;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5004.2299, -1892.4552, 1325.9412,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4977.6147, -1885.4683, 1321.7950,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4976.6030, -1883.3793, 1321.6474,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4973.8300, -1871.4394, 1321.1518,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4974.6821, -1869.4301, 1321.1088,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4994.4121, -1846.3155, 1321.6802,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5014.2958, -1827.2132, 1321.6782,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5016.2309, -1821.8514, 1321.8298,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5030.5507, -1778.0809, 1321.8430,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5023.7495, -1767.4716, 1322.2296,10000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5030.4970, -1782.4370, 1321.7009,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5023.1923, -1812.6506, 1321.7681,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5016.2309, -1821.8514, 1321.8298,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4994.4121, -1846.3155, 1321.6802,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4974.6821, -1869.4301, 1321.1088,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4973.8300, -1871.4394, 1321.1518,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4976.6030, -1883.3793, 1321.6474,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 4982.3364, -1886.0722, 1322.4235,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5004.2299, -1892.4552, 1325.9412,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5049.2622, -1886.9235, 1331.6601,30000,0,0,100,0);

SET @GUID := 52946;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5436.8325, -2652.5925, 1485.2058,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5448.3828, -2664.9121, 1485.2918,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5461.2944, -2707.1530, 1485.5791,15000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5448.3828, -2664.9121, 1485.2918,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5436.8325, -2652.5925, 1485.2058,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5397.3999, -2634.8000, 1486.3599,15000,0,0,100,0);

-- 52528 movement 

-- 52532 movement

-- 52626 movement

-- 52679 / 52695 movement

SET @GUID := 52953;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5468.3818, -2949.1467, 1537.6992,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5457.8393, -2932.4338, 1534.6328,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5416.5107, -2896.8491, 1522.7535,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5416.9399, -2892.7543, 1521.9375,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5419.4677, -2873.1367, 1517.0444,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5415.6152, -2856.8845, 1513.1450,15000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5419.4677, -2873.1367, 1517.0444,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5416.5107, -2896.8491, 1522.7535,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5420.8706, -2900.8623, 1523.6153,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5457.8393, -2932.4338, 1534.6328,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5479.4702, -2960.3500, 1538.4300,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5501.1220, -2971.8000, 1537.5042,15000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 5479.4702, -2960.3500, 1538.4300,0,0,0,100,0);

-- 53024 movement

-- 53025 movement

-- ======================================================
-- Linking
-- ======================================================

DELETE FROM `creature_formations` WHERE `leaderguid` IN (52953,52946,51901,51877,51860,48408,48411,48415,48412,48413,48414,48425);
DELETE FROM `creature_formations` WHERE `memberguid` IN (48408,48411,48415,48412,48413,48414,48425);
INSERT INTO `creature_formations` VALUES

(52953, 52953, 100, 360, 2),
(52953, 52981, 3, 0.78, 2),
(52953, 52982, 3, 5.50, 2),

(52946, 52946, 100, 360, 2),
(52946, 52947, 3, 0.78, 2),
(52946, 52948, 3, 5.50, 2),

-- 52695,52679

-- 52626,52628

-- 52532,52533

(51901,51901,100,360,2),
(51901,51860,4,0,2),
(51901,51877,8,0,2),

(48408,48408,100,360,2),
(48408,48411,2,5.5,2),
(48408,48415,2,0.7,2),
(48408,48412,4,5.9,2),
(48408,48413,4,0,2),
(48408,48414,4,0.4,2);

-- ======================================================
-- Respawn
-- ======================================================

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (48425);

-- ======================================================
-- Gameobjects
-- ======================================================


-- ======================================================
-- Miscellaneous
-- ======================================================

-- 39534 random epic reference loot template hyjal 9 of 18
-- SELECT * FROM `creature_loot_template` WHERE `mincountOrRef` = -39534;
-- see http://www.wowhead.com/item=32589/hellfire-encased-pendant
-- 17908 missing
DELETE FROM `creature_loot_template` WHERE `mincountOrRef` = -39534 AND `entry` = 17908;
INSERT INTO `creature_loot_template` VALUES
(17908, 39534, 1, 1, -39534, 1, 0, 0, 0);

-- Epic GEM Patterns
-- 8 Trash
-- 9 Boss 17767,17808,17888,17842,17968 see wowhead
DELETE FROM `reference_loot_template` WHERE `entry` = 34999;
INSERT INTO `reference_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES 
(34999, 32274, 0, 8, 1, 1, 7, 755, 1),
(34999, 32277, 0, 8, 1, 1, 7, 755, 1),
(34999, 32281, 0, 8, 1, 1, 7, 755, 1),
(34999, 32282, 0, 8, 1, 1, 7, 755, 1),
(34999, 32283, 0, 8, 1, 1, 7, 755, 1),
(34999, 32284, 0, 8, 1, 1, 7, 755, 1),
(34999, 32285, 0, 9, 1, 1, 7, 755, 1), -- Flashing Crimson Spinel
(34999, 32286, 0, 8, 1, 1, 7, 755, 1),
(34999, 32287, 0, 8, 1, 1, 7, 755, 1),
(34999, 32288, 0, 8, 1, 1, 7, 755, 1),
(34999, 32289, 0, 9, 1, 1, 7, 755, 1), -- Stormy Empyrean Sapphire
(34999, 32290, 0, 8, 1, 1, 7, 755, 1),
(34999, 32291, 0, 8, 1, 1, 7, 755, 1),
(34999, 32292, 0, 8, 1, 1, 7, 755, 1),
(34999, 32293, 0, 8, 1, 1, 7, 755, 1),
(34999, 32294, 0, 8, 1, 1, 7, 755, 1),
(34999, 32295, 0, 9, 1, 1, 7, 755, 1), -- Mystic Lionseye
(34999, 32296, 0, 9, 1, 1, 7, 755, 1), -- Great Lionseye
(34999, 32297, 0, 9, 1, 1, 7, 755, 1), -- Sovereign Shadowsong Amethyst
(34999, 32298, 0, 9, 1, 1, 7, 755, 1), -- Shifting Shadowsong Amethyst
(34999, 32299, 0, 8, 1, 1, 7, 755, 1),
(34999, 32300, 0, 8, 1, 1, 7, 755, 1),
(34999, 32301, 0, 8, 1, 1, 7, 755, 1),
(34999, 32302, 0, 8, 1, 1, 7, 755, 1),
(34999, 32303, 0, 9, 1, 1, 7, 755, 1), -- Inscribed Pyrestone
(34999, 32304, 0, 8, 1, 1, 7, 755, 1),
(34999, 32305, 0, 8, 1, 1, 7, 755, 1),
(34999, 32306, 0, 8, 1, 1, 7, 755, 1),
(34999, 32307, 0, 9, 1, 1, 7, 755, 1), -- Veiled Pyrestone
(34999, 32308, 0, 8, 1, 1, 7, 755, 1),
(34999, 32309, 0, 8, 1, 1, 7, 755, 1),
(34999, 32310, 0, 8, 1, 1, 7, 755, 1),
(34999, 32311, 0, 8, 1, 1, 7, 755, 1),
(34999, 32312, 0, 8, 1, 1, 7, 755, 1),
(34999, 35762, 0, 8, 1, 1, 7, 755, 1), -- 35767
(34999, 35763, 0, 8, 1, 1, 7, 755, 1), -- 35768
(34999, 35764, 0, 8, 1, 1, 7, 755, 1), -- 35766
(34999, 35765, 0, 8, 1, 1, 7, 755, 1); -- 35769

SET @CHANCE := 0.5;
DELETE FROM `creature_loot_template` WHERE `item` IN (32274,32277,32281,32282,32283,32284,32285,32286,32287,32288,32289,32290,32291,32292,32293,32294,32295,32296,32297,32298,32299,32300,32301,32302,32303,32304,32305,32306,32307,32308,32309,32310,32311,32312,35762,35763,35764,35765,35766,35767,35768,35769);
DELETE FROM `creature_loot_template` WHERE `mincountOrRef` = -34999;
INSERT INTO `creature_loot_template` VALUES
-- Trash 8
(17895, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17897, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17898, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17899, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17905, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17906, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17907, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17908, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
(17916, 34999, @CHANCE, 8, -34999, 1, 0, 0, 0),
-- Boss 9
(17767, 34999, 8, 9, -34999, 1, 0, 0, 0),
(17808, 34999, 8, 9, -34999, 1, 0, 0, 0),
(17888, 34999, 10, 9, -34999, 1, 0, 0, 0),
(17842, 34999, 10, 9, -34999, 1, 0, 0, 0),
(17968, 34999, 15, 9, -34999, 1, 0, 0, 0);

-- Azgalor 1 Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 17842 AND `item` = 34067;

-- Archimonde 1 Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 17968 AND `item` = 34068;


-- Blood Knight Dawnstar 17832
UPDATE `creature` SET `modelid` = 0 WHERE `guid` = 39681;


-- Xi'ri
UPDATE `creature` SET `spawnMask` = 1 WHERE `id` = 18528;

SET @GUID := 79402;
UPDATE `creature` SET `position_x`='135.8590',`position_y`='-0.0621',`position_z`='-10.1021',`movementtype`='2',`spawndist`='0' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,169.1991, 0.0123, -10.1011,15000,1,0,100,0),
(@GUID,2,105.4535, 0.0491, -10.1740,15000,1,0,100,0);


-- cleanup general startup ai errors
UPDATE `creature_template` SET `AIName` = 'NULL' WHERE `entry` IN (22309,25824,25799,25798,25599,25597,25595,25593,25592,25509,25508,24994,22451,21233,18970,18945,17855,17853,16409,14777,14776,14773,14772,14765,14764,14763,14762);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (22309,26253,25824,25799,25798,25599,25597,25595,25593,25592,25509,25508,24994,22451,21233,21229,18970,18945,17959,17893,17855,17853,17805,16826,16491,16409,14777,14776,14773,14772,14765,14764,14763,14762,15371);
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 18695;
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 18092;


UPDATE `creature_ai_scripts` SET `event_flags` = 0 WHERE `id` IN (2306704,2306703,1840103,2170701,2170601,2165101,2164406,2164401,2142801,2117105,2170701,2117104,2116806,2116805,2116405,2116404,2032912,2006101,1998911,1998808,1942407,1942406,1942404,1942402,1891201,1869553,1848301,1842301,1840202,1820201,1820200,1692505,1692504,1692502,1692501,1659904,1659901);
UPDATE `creature_ai_scripts` SET `event_flags` = 2 WHERE `id` IN (2404303,2130102,2123202,2089801,2088601,2086804,1963307,1772202,444251,398353,1650701,1645910);
UPDATE `creature_ai_scripts` SET `event_flags` = 4 WHERE `id` IN (2089802,2088602,2086805,1963308,1772204,1740001,1650702);
UPDATE `creature_ai_scripts` SET `event_flags` = 6 WHERE `id` IN (2535402,2134604,2112704,2112703,2090115,2088510,2088208,2086905,2085903,1984304,1951104,1884805,1884801,1883001,1870201,1870102,1863606,1863410,1863409,1863408,1863407,1863406,1863405,1863404,1863403,1863307,1863301,1863205,1863201,1863104,1849702,1849503,1849301,1833103,1833102,1832801,1832701,1832601,1832302,1832208,1831802,1831801,1831707,1831507,1831506,1831405,1831404,1831201,1831105,1830904,1810503,1796115,1796012,1793805,1786007,1786005,1786001,1782613,1782612,1782602,1781907,1780201,1772803,1772403,1772213,1772206,1769506,1769301,1762401,1749106,1747815,1742004,1741406,1739805,1739804,1739705,1728103,1728101,1726404,1726402,1670005,1670004,1652305);

DELETE FROM `creature_ai_scripts` WHERE `id` IN (2358005,2358006);
INSERT INTO `creature_ai_scripts` VALUES
(2358005,23580,7,0,100,2,0,0,0,0,43,22467,0,0,0,0,0,0,0,0,0,0,'Amani\'shi Warbringer - Mount on Evade'),
(2358006,23580,21,0,100,2,0,0,0,0,43,22467,0,0,0,0,0,0,0,0,0,0,'Amani\'shi Warbringer - Mount on Reaching Spawnpoint');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23355';
INSERT INTO `creature_ai_scripts` VALUES
(2335501,23355,4,0,100,0,0,0,0,0,11,29651,0,7,1,-9901,0,0,0,0,0,0,'Zarcsin  - Cast Dual Wield on Aggro'),
(2335502,23355,2,0,100,0,50,0,0,0,11,41447,0,7,1,-106,0,0,0,0,0,0,'Zarcsin - Casts Enrage at 50% HP'),
(2335503,23355,0,0,100,1,5000,6000,12000,13000,11,41444,0,0,0,0,0,0,0,0,0,0,'Zarcsin - Casts Fel Flames');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23068';
INSERT INTO `creature_ai_scripts` VALUES
('2306800','23068','4','0','100','0','0','0','0','0','28','0','37411','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cancel Skettis Corrupted Ghosts on Aggro'),
('2306801','23068','9','0','100','1','0','30','7000','9000','11','32863','4','32','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Seed of Corruption'),
('2306802','23068','9','0','100','1','0','5','8000','12000','11','15652','1','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Head Smash'),
('2306803','23068','9','0','100','1','0','20','4000','6000','11','17173','1','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Drain Life'),
('2306804','23068','4','0','25','0','0','0','0','0','1','-1241','0','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Say on Aggro'),
('2306805','23068','6','0','25','0','0','0','0','0','1','-1242','0','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Say on Death'),
('2306806','23068','7','0','100','0','0','0','0','0','11','37411','0','7','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Skettis Corrupted Ghosts on Evade');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23068';
INSERT INTO `creature_ai_scripts` VALUES
('2306800','23068','4','0','100','0','0','0','0','0','28','0','37411','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cancel Skettis Corrupted Ghosts on Aggro'),
('2306801','23068','9','0','100','1','0','30','7000','9000','11','32863','4','32','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Seed of Corruption'),
('2306802','23068','9','0','100','1','0','5','8000','12000','11','15652','1','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Head Smash'),
('2306803','23068','9','0','100','1','0','20','4000','6000','11','17173','1','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Drain Life'),
('2306804','23068','4','0','25','0','0','0','0','0','1','-1241','0','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Say on Aggro'),
('2306805','23068','6','0','25','0','0','0','0','0','1','-1242','0','0','0','0','0','0','0','0','0','0','Talonpriest Zellek - Say on Death'),
('2306806','23068','7','0','100','0','0','0','0','0','11','37411','0','7','0','0','0','0','0','0','0','0','Talonpriest Zellek - Cast Skettis Corrupted Ghosts on Evade');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23066';
INSERT INTO `creature_ai_scripts` VALUES
('2306600','23066','4','0','100','0','0','0','0','0','28','0','37411','0','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Cancel Skettis Corrupted Ghosts on Aggro'),
('2306601','23066','2','0','100','1','75','0','8000','12000','11','17843','0','0','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Cast Flash Heal'),
('2306602','23066','9','0','100','1','0','5','8000','12000','11','11918','1','32','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Cast Poison'),
('2306603','23066','2','0','100','1','90','0','6000','9000','11','12160','0','32','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Cast Rejuvenation'),
('2306604','23066','9','0','100','1','0','30','6000','9000','11','15654','4','32','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Cast Shadow Word Pain'),
('2306605','23066','4','0','25','0','0','0','0','0','1','-1241','0','0','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Say on Aggro'),
('2306606','23066','6','0','25','0','0','0','0','0','1','-1242','0','0','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Say on Death'),
('2306607','23066','7','0','100','0','0','0','0','0','11','37411','0','7','0','0','0','0','0','0','0','0','Talonpriest Ishaal - Cast Skettis Corrupted Ghosts on Evade');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22441;
INSERT INTO `creature_ai_scripts` VALUES 
(2244101,22441,7,0,100,0,0,0,0,0,41,0,0,0,18,33554432,0,0,0,0,0,0,'Teribus the Cursed - Despawn on Evade'),
(2244102,22441,1,0,100,0,30000,30000,0,0,41,0,0,0,0,0,0,0,0,0,0,0,'Teribus the Cursed - Despawn after 10sec OOC'),
('2244103','22441','6','0','100','0','0','0','0','0','33','22441','6','0','0','0','0','0','0','0','0','0','Teribus the Cursed - Quest Credit on Kill (Quest: 10923)');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22398;
INSERT INTO `creature_ai_scripts` VALUES
('2239801','22398','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Random Say OOC'),
('2239802','22398','9','0','100','7','0','5','5000','10000','11','9080','4','1','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Cast Hamstring'),
('2239803','22398','0','0','100','7','4000','9000','8000','11000','11','15496','1','1','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Cast Cleave'),
('2239804','22398','0','0','100','7','6200','9700','9000','13000','11','14895','1','1','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Cast Overpower'),
('2239805','22398','2','0','100','6','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Durnholde Reinforcement - Flee at 15% HP'),
('2239806','22398','6','0','10','6','0','0','0','0','1','-1279','-1280','-1281','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Random Say on Death'),
('2239807','22398','4','0','10','6','0','0','0','0','1','-1278','0','0','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Random Say on Aggro'),
('2239808','22398','7','0','10','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Despawn on Evade');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22355;
INSERT INTO `creature_ai_scripts` VALUES
('2235501','22355','4','0','100','0','0','0','0','0','31','1','6','0','0','0','0','0','0','0','0','0','Netherweb Victim - Choose Random Phase on Aggro'),
('2235502','22355','6','1','10','0','0','0','0','0','12','21242','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Auchenai Death-Speaker on Death'),
('2235503','22355','6','2','10','0','0','0','0','0','12','18470','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Bonelasher on Death'),
('2235504','22355','6','4','10','0','0','0','0','0','12','21661','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Cabal Skirmisher on Death'),
('2235505','22355','6','8','10','0','0','0','0','0','12','16805','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Broken Skeleton on Death'),
('2235506','22355','6','16','10','0','0','0','0','0','12','18452','0','30000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Skithian Dreadhawk on Death'),
('2235507','22355','6','32','50','0','0','0','0','0','12','22459','0','60000','0','0','0','0','0','0','0','0','Netherweb Victim - Summon Freed Sha\'tar Warrior on Death');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22128;
INSERT INTO `creature_ai_scripts` VALUES
('2212801','22128','0','0','100','7','4000','4000','4000','4000','21','1','0','0','22','1','0','0','40','2','0','0','Durnholde Lookout - Start Combat Movement and Start Melee'),
('2212802','22128','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Lookout - Random Say OOC'),
('2212803','22128','4','0','100','6','0','0','0','0','1','-1275','-1276','-1277','12','22398','1','300','12','22398','1','300','Durnholde Lookout - Random Say and Summon 2 Durnholde Reinforcement on Aggro'),
('2212804','22128','9','1','100','3','5','30','1500','1500','11','16100','1','0','40','2','0','0','21','0','0','0','Durnholde Lookout (Normal) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('2212805','22128','9','1','100','5','5','30','1500','1500','11','22907','1','0','40','2','0','0','21','0','0','0','Durnholde Lookout (Heroic) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('2212806','22128','0','1','100','3','9000','15000','9000','15000','11','31942','4','1','40','2','0','0','21','0','0','0','Durnholde Lookout (Normal) - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
('2212807','22128','0','1','100','5','9000','15000','9000','15000','11','38383','4','1','40','2','0','0','21','0','0','0','Durnholde Lookout (Heroic) - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
('2212808','22128','0','0','100','7','10900','26500','22900','36200','11','23601','4','1','40','2','0','0','0','0','0','0','Durnholde Lookout - Cast Scatter Shot and Set Ranged Weapon Model'),
('2212809','22128','2','0','100','6','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Durnholde Lookout - Set Phase 2 at 15% HP'),
('2212810','22128','2','0','100','6','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Durnholde Lookout - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('2212811','22128','9','1','100','6','0','5','0','0','21','1','0','0','40','1','0','0','20','1','0','0','Durnholde Lookout - Start Combat Movement and Set Melee Weapon Model and Start Melee Below 5 Yards (Phase 1)'),
('2212812','22128','7','0','100','6','0','0','0','0','22','0','0','0','40','1','0','0','21','1','0','0','Durnholde Lookout - Set Phase 0 and Set Melee Weapon Model and Start Movement on Evade'),
('2212813','22128','6','0','10','6','0','0','0','0','1','-1279','-1280','-1281','1','-1280','-1281','-1282','1','-1279','-1280','-1282','Durnholde Lookout - Random Say on Death');
-- Cast Hulk on Aggro Hulk -> Großer Grüner
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16880');
INSERT INTO `creature_ai_scripts` VALUES
('1688001','16880','2','0','100','0','66','0','0','0','11','33909','0','7','0','0','0','0','0','0','0','0','Hulking Helboar - Cast Hulk at 66% HP'),
('1688002','16880','2','0','100','0','50','0','0','0','11','33909','0','7','0','0','0','0','0','0','0','0','Hulking Helboar - Cast Hulk at 50% HP'),
('1688003','16880','2','0','100','0','33','0','0','0','11','33909','0','7','0','0','0','0','0','0','0','0','Hulking Helboar - Cast Hulk at 33% HP'),
('1688004','16880','2','0','100','0','66','0','0','0','1','-9949','0','0','0','0','0','0','0','0','0','0','Hulking Helboar - Play Emote once at 66% HP'),
('1688005','16880','8','0','100','0','34665','-1','0','0','16','16880','34665','6','3','16992','19249','0','0','0','0','0','Hulking Helboar - Quest Credit and Change Model on Administer Antidote Spellhit (Quest: 10255)');

UPDATE `creature_ai_scripts` SET `action3_param1` = 100 WHERE `id` = 2316503;
UPDATE `creature_ai_scripts` SET `action2_param1` = 100 WHERE `id` = 2316304;

-- 2.1 changes
UPDATE `creature` SET `position_x`='361.872009', `position_y`='-724.400024', `position_z`='-14.0032', `orientation`='3.2655',`spawndist`='0',`movementtype`='0' WHERE `guid` = 82974; -- `position_x`='354.7654', `position_y`='-723.9628', `position_z`='-13.8946' Post 2.1 `position_x`='361.872009', `position_y`='-724.400024', `position_z`='-14.0032'

-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8358',`maxdmg`='9926',`baseattacktime`='1400',`resistance3`= -1,`mechanic_immune_mask`='1073561599' WHERE `entry` = 21863;

-- Coilfang Priestess 21220
UPDATE `creature_template` SET `armor`='5950',`speed`='1.71',`mindmg`='5607',`maxdmg`='6657',`baseattacktime`='1400',`mechanic_immune_mask`='0',`flags_extra`='0' WHERE `entry` = 21220;

-- 2.1 (Re)Activate Mark of the Illidari
UPDATE `creature_loot_template` SET `mincountOrRef`=1, `maxcount`=1 WHERE `item` =32897; -- 1 1

-- 2.1 (Re)Activate Trash Patterns
-- <~1% fist entry 0,984
-- UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`*9 WHERE `item` IN (30321,30322,30323,30324,30280,30281,30282,30283,30301,30302,30303,30304,30305,30306,30307,30308);
-- UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`*30 WHERE `item` = 30323;
UPDATE `creature_loot_template` SET `mincountOrRef`=1,`maxcount`=1 WHERE `item` IN (30321,30322,30323,30324,30280,30281,30282,30283,30301,30302,30303,30304,30305,30306,30307,30308); -- 1 1

-- 2.1 (Re)Activate Boss Pattern
UPDATE `reference_loot_template` SET `mincountOrRef`=1, `maxcount`=1 WHERE `entry` = 34052; -- 1 1

-- 2.1 (Re)Activate 32902,32905 Bottled Nethergon Energy / Bottled Nethergon Vapor
UPDATE `creature_loot_template` SET `mincountOrRef` = 1, `maxcount` = 3 WHERE `item` IN (32902,32905); -- 1 3

-- 2.1 (Re)Activate Coilfang Armaments
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

-- Netherwing
DELETE FROM `creature_questrelation` WHERE `id` = 22112;
INSERT INTO `creature_questrelation` VALUES (22112, 10870);

-- ======================================================
-- https://github.com/Looking4Group/L4G_Core/issues/258
-- T4 Content + 20% -- Original 2.4.3 Prenerf Value -- Hellfire Tuned Value -> T6 10% ZA  5% SWP 0%
-- T5 Content + 30% -- Original 2.4.3 Prenerf Value -- Hellfire Tuned Value -> T6 20% ZA 10% SWP 0%
-- Zul'Aman   + 20% -- Original 2.4.3 Prenerf Value -- Hellfire Tuned Value -> SWP 10%
-- T6 Content + 20% -- Original 2.4.3 Prenerf Value -- Hellfire Tuned Value -> SWP 10%
-- SWP        + 10% -- Original 2.4.3 Prenerf Value -- Hellfire Tuned Value
--
-- ======================================================
-- Karazhan
-- https://github.com/Looking4Group/L4G_Core/issues/637
-- ======================================================

-- Attumen the Huntsman 15550
UPDATE `creature_template` SET `minhealth`='417340',`maxhealth`='417340' WHERE `entry` = 15550; -- 379400 -- 455280 417340

-- Midnight 16151
UPDATE `creature_template` SET `minhealth`='417340',`maxhealth`='417340' WHERE `entry` = 16151; -- 379400

-- Moroes 15687
UPDATE `creature_template` SET `minhealth`='425687',`maxhealth`='425687' WHERE `entry` = 15687; -- 386988 -- 464386 425687

-- Maiden of Virtue 16457
UPDATE `creature_template` SET `minhealth`='467390',`maxhealth`='467390' WHERE `entry` = 16457; -- 424900 -- 509880 467390

-- Dorothee 17535
UPDATE `creature_template` SET `minhealth`='166925',`maxhealth`='166925' WHERE `entry` = 17535; -- 151750 -- 182100 166925

-- Roar 17546
UPDATE `creature_template` SET `minhealth`='121770',`maxhealth`='121770' WHERE `entry` = 17546; -- 110700 -- 132840 121770

-- Strawman 17543
UPDATE `creature_template` SET `minhealth`='121770',`maxhealth`='121770' WHERE `entry` = 17543; -- 110700

-- Tinhead 17547
UPDATE `creature_template` SET `minhealth`='121770',`maxhealth`='121770' WHERE `entry` = 17547; -- 110700

-- The Crone 18168
UPDATE `creature_template` SET `minhealth`='166925',`maxhealth`='166925' WHERE `entry` = 18168; -- 151750

-- Tito 17548
UPDATE `creature_template` SET `minhealth`='38423',`maxhealth`='38423' WHERE `entry` = 17548; -- 34930 -- 41916 38423

-- Julianne 17534
UPDATE `creature_template` SET `minhealth`='166925',`maxhealth`='166925' WHERE `entry` = 17534; -- 151750

-- Romulo 17533
UPDATE `creature_template` SET `minhealth`='208670',`maxhealth`='208670' WHERE `entry` = 17533; -- 189700 -- 227640 208670

-- The Big Bad Wolf 17521
UPDATE `creature_template` SET `minhealth`='417340',`maxhealth`='417340' WHERE `entry` = 17521; -- 379400 --

-- The Curator 15691
UPDATE `creature_template` SET `minhealth`='1264230',`maxhealth`='1264230' WHERE `entry` = 15691; -- 1149300 -- 1379160 1264230

-- Terestian Illhoof 15688
UPDATE `creature_template` SET `minhealth`='768460',`maxhealth`='768460' WHERE `entry` = 15688; -- 698600 -- 838320 768460

-- Kil'rek 17229
UPDATE `creature_template` SET `minhealth`='64548',`maxhealth`='64548' WHERE `entry` = 17229; -- 58680 -- 70416 64548

-- Shade of Aran 16524
UPDATE `creature_template` SET `minhealth`='943736',`maxhealth`='943736' WHERE `entry` = 16524; -- 849760 -- 1019712 943736

-- Prince Malchezaar 15690
UPDATE `creature_template` SET `minhealth`='1365840',`maxhealth`='1365840' WHERE `entry` = 15690; -- 1138200 -- 1365840

-- Netherspite 15689
UPDATE `creature_template` SET `minhealth`='1250920',`maxhealth`='1250920' WHERE `entry` = 15689; -- 1117800 -- 1364640 1250920

-- Nightbane 17225
UPDATE `creature_template` SET `minhealth`='1460690',`maxhealth`='1460690' WHERE `entry` = 17225; -- 1327900 -- 1593480 1460690

-- ======================================================
-- Gruul's Lair
-- https://github.com/Looking4Group/L4G_Core/issues/1650
-- ======================================================

-- High King Maulgar – Hochkönig Maulgar 18831
UPDATE `creature_template` SET `minhealth`='834680',`maxhealth`='834680' WHERE `entry` = 18831; -- 758800 -- 910560 834680

-- Krosh Firehand – Krosh Feuerhand 18832
UPDATE `creature_template` SET `minhealth`='333850',`maxhealth`='333850' WHERE `entry` = 18832; -- 303500 -- 364200 333850

-- Olm the Summoner – Olm der Beschwörer 18834
UPDATE `creature_template` SET `minhealth`='333850',`maxhealth`='333850' WHERE `entry` = 18834; -- 303500

-- Kiggler the Crazed – Gicherer der Wahnsinnige 18835
UPDATE `creature_template` SET `minhealth`='333850',`maxhealth`='333850' WHERE `entry` = 18835; -- 303500

-- Blindeye the Seer – Blindauge der Seher 18836
UPDATE `creature_template` SET `minhealth`='333850',`maxhealth`='333850' WHERE `entry` = 18836; -- 303500

-- Gruul the Dragonkiller - Gruul der Drachenschlächter 19044
UPDATE `creature_template` SET `minhealth`='4950000',`maxhealth`='4950000' WHERE `entry` = 19044; -- 3415000->4500000? -- 5400000 49500000

-- ======================================================
-- Magtheridon's Lair
-- https://github.com/Looking4Group/L4G_Core/issues/1648
-- ======================================================

-- Hellfire Channeler – Kanalisierer des Höllenfeuers 17256
UPDATE `creature_template` SET `minhealth`='267080',`maxhealth`='291360' WHERE `entry` = 17256; -- 242800 -- 291360 267080

-- Magtheridon 17257
UPDATE `creature_template` SET `minhealth`='5300218',`maxhealth`='5300218' WHERE `entry` = 17257; -- 4818380 -- 5782056 5300218

-- =======================================================

-- Doomwalker 17711
UPDATE `creature_template` SET `minhealth`='2504040',`maxhealth`='2504040' WHERE `entry` = 17711; -- 2276400 -- 2731680 2504040

-- Doomlord Kazzak 18728
UPDATE `creature_template` SET `minhealth`='1430000',`maxhealth`='1430000' WHERE `entry` = 18728; -- 1300000 -- 1560000 1430000

-- =======================================================
-- SSC
-- https://github.com/Looking4Group/L4G_Core/issues/2326
-- ======================================================

-- Hydross the Unstable <Duke of Currents> 21216
UPDATE `creature_template` SET `minhealth`='4468171',`maxhealth`='4468171' WHERE `entry` = 21216; -- 3723476 --  4840519 4468171

-- Tainted Spawn of Hydross 22036
UPDATE `creature_template` SET `minhealth`='75500',`maxhealth`='75500' WHERE `entry` = 22036; -- 62917(51k) -- 81792 75500

-- Pure Spawn of Hydross 22035
UPDATE `creature_template` SET `minhealth`='67100',`maxhealth`='67100' WHERE `entry` = 22035; -- 55917(49k) -- 72692 67100

-- ===============

-- The Lurker Below 21217
UPDATE `creature_template` SET `minhealth`='6373920',`maxhealth`='6373920' WHERE `entry` = 21217; -- 5311600 -- 6905080 6373920

-- Coilfang Ambusher 21865
UPDATE `creature_template` SET `minhealth`='34800',`maxhealth`='34800' WHERE `entry` = 21865; -- 29000 -- 37700 34800

-- Coilfang Guardian 21873
UPDATE `creature_template` SET `minhealth`='83832',`maxhealth`='83832' WHERE `entry` = 21873; -- 69860 -- 90818 83832

-- ===============

-- Leotheras the Blind 21215
UPDATE `creature_template` SET `minhealth`='5392800',`maxhealth`='5392800' WHERE `entry` = 21215; -- 4494000 -- 5842200 5392800

-- Shadow of Leotheras 21875
UPDATE `creature_template` SET `minhealth`='5392800',`maxhealth`='5392800' WHERE `entry` = 21875; -- 4494000

-- Leotheras (Phase 3) 21845
UPDATE `creature_template` SET `minhealth`='5392800',`maxhealth`='5392800' WHERE `entry` = 21845; -- 4494000

-- Greyheart Spellbinder 21806
UPDATE `creature_template` SET `minhealth`='202800',`maxhealth`='202800' WHERE `entry` = 21806; -- 169000 -- 355000 202800

-- ===============

-- Fathom-Lord Karathress 21214
UPDATE `creature_template` SET `minhealth`='2185200',`maxhealth`='2185200' WHERE `entry` = 21214; -- 1821000 -- 2367300 2185200

-- Fathom-Guard Caribdis 21964
UPDATE `creature_template` SET `minhealth`='1033920',`maxhealth`='1033920' WHERE `entry` = 21964; -- 861600 -- 1154400 1033920

-- Fathom-Guard Tidalvess 21965
UPDATE `creature_template` SET `minhealth`='1033920',`maxhealth`='1033920' WHERE `entry` = 21965; -- 861600

-- Fathom-Guard Sharkkis 21966
UPDATE `creature_template` SET `minhealth`='1033920',`maxhealth`='1033920' WHERE `entry` = 21966; -- 861600

-- Fathom Lurker 22119
UPDATE `creature_template` SET `minhealth`='215430',`maxhealth`='215430' WHERE `entry` = 22119; -- 179525 -- 233383 215430

-- Fathom Sporebat 22120
UPDATE `creature_template` SET `minhealth`='215430',`maxhealth`='215430' WHERE `entry` = 22120; -- 179525 -- 233383

-- Spitfire Totem 22091
UPDATE `creature_template` SET `minhealth`='30000',`maxhealth`='30000' WHERE `entry` = 22091; -- 25000 -- 32500 30000

-- Greater Earthbind Totem 22486
UPDATE `creature_template` SET `minhealth`='25200',`maxhealth`='25200' WHERE `entry` = 22486; -- 21000 -- 27300 25200

-- Greater Poison Cleansing Totem 22487
UPDATE `creature_template` SET `minhealth`='5160',`maxhealth`='5160' WHERE `entry` = 22487; -- 4300 -- 5590 5160

-- ===============

-- Morogrim Tidewalker 21213
UPDATE `creature_template` SET `minhealth`='6829200',`maxhealth`='6829200' WHERE `entry` = 21213; -- 5691000 -- 7398300 6829200

-- Tidewalker Lurker 21920
UPDATE `creature_template` SET `minhealth`='21542',`maxhealth`='21542' WHERE `entry` = 21920; -- 17952 -- 23338 21542

-- ===============

-- Lady Vashj <Coilfang Matron> 21212
UPDATE `creature_template` SET `minhealth`='6427200',`maxhealth`='6427200' WHERE `entry` = 21212; -- 5356000 -- 6962800 6427200

-- Tainted Elemental 22009
UPDATE `creature_template` SET `minhealth`='11100',`maxhealth`='11100' WHERE `entry` = 22009; -- 9250 -- 12025 11100

-- Enchanted Elemental 21958
UPDATE `creature_template` SET `minhealth`='9240',`maxhealth`='9240' WHERE `entry` = 21958; -- 7700 -- 10010 9240

-- Coilfang Elite 22055
UPDATE `creature_template` SET `minhealth`='192500',`maxhealth`='192500' WHERE `entry` = 22055; -- 175000 -- 210000 192500

-- Toxic Spore Bat 22140
UPDATE `creature_template` SET `minhealth`='8910',`maxhealth`='8910' WHERE `entry` = 22140; -- 8100 -- 10530 8910

-- ======================================================
-- TK
-- https://github.com/Looking4Group/L4G_Core/issues/2327
-- ======================================================

-- Al'ar <Phoenix God> 19514
UPDATE `creature_template` SET `minhealth`='3960000',`maxhealth`='3960000' WHERE `entry` = 19514; -- 3300000 -- 4290000 3960000

-- ===============

-- Void Reaver 19516
UPDATE `creature_template` SET `minhealth`='5400000',`maxhealth`='5400000' WHERE `entry` = 19516; -- 4500000 -- 5850000 5400000

-- ===============

-- High Astromancer Solarian 18805
UPDATE `creature_template` SET `minhealth`='4006200',`maxhealth`='4006200' WHERE `entry` = 18805; -- 3338500 -- 4340050 4006200

-- ===============

-- Kael'thas Sunstrider <Lord of the Blood Elves> 19622

-- Thaladred the Darkener <Advisor to Kael'thas> 20064
UPDATE `creature_template` SET `minhealth`='378000',`maxhealth`='378000' WHERE `entry` = 20064; -- 378000(756000) -- 434700(869400)

-- Lord Sanguinar <The Blood Hammer> 20060
UPDATE `creature_template` SET `minhealth`='376000',`maxhealth`='376000' WHERE `entry` = 20060; -- 376000(752000)-- 432400(864800)

-- Grand Astromancer Capernian <Advisor to Kael'thas> 20062
UPDATE `creature_template` SET `minhealth`='281000',`maxhealth`='281000' WHERE `entry` = 20062; -- 281000(562000) -- 323150(646300)

-- Master Engineer Telonicus <Advisor to Kael'thas> 20063
UPDATE `creature_template` SET `minhealth`='377000',`maxhealth`='377000' WHERE `entry` = 20063; -- 377000(754000) -- 433550(867100)

-- Netherstrand Longbow 21268
UPDATE `creature_template` SET `minhealth`='210000',`maxhealth`='210000' WHERE `entry` = 21268; -- 210000 -- 231000

-- Devastation 21269
UPDATE `creature_template` SET `minhealth`='230000',`maxhealth`='230000' WHERE `entry` = 21269; -- 230000 -- 253000

-- Cosmic Infuser 21270
UPDATE `creature_template` SET `minhealth`='280000',`maxhealth`='280000' WHERE `entry` = 21270; -- 280000 -- 308000

-- Infinity Blades 21271
UPDATE `creature_template` SET `minhealth`='210000',`maxhealth`='210000' WHERE `entry` = 21271; -- 210000 -- 231000

-- Warp Slicer 21272
UPDATE `creature_template` SET `minhealth`='290000',`maxhealth`='290000' WHERE `entry` = 21272; -- 290000 -- 319000

-- Phaseshift Bulwark 21273
UPDATE `creature_template` SET `minhealth`='290000',`maxhealth`='290000' WHERE `entry` = 21273; -- 290000 -- 319000

-- Staff of Disintegration 21274
UPDATE `creature_template` SET `minhealth`='170000',`maxhealth`='170000' WHERE `entry` = 21274; -- 170000 -- 187000

-- Phoenix Egg 21364
UPDATE `creature_template` SET `minhealth`='70000',`maxhealth`='70000' WHERE `entry` = 21274; -- 70000 -- 77000

-- Phoenix 21362
UPDATE `creature_template` SET `minhealth`='174650',`maxhealth`='174650' WHERE `entry` = 21362; -- 174650 -- 195204

-- ======================================================
-- Hyjal
-- https://github.com/Looking4Group/L4G_Core/issues/641
-- ======================================================

-- Rage Winterchill 17767
UPDATE `creature_template` SET `minhealth`='5098800',`maxhealth`='5098800' WHERE `entry` = '17767'; -- 4249000 -- 5098800

-- ===============

-- Anetheron 17808
UPDATE `creature_template` SET `minhealth`='5098800',`maxhealth`='5098800' WHERE `entry` = '17808'; -- 4249000 -- 5098800

-- Towering Infernal 17818
UPDATE `creature_template` SET `minhealth`='265680',`maxhealth`='265680' WHERE `entry` = '17818'; -- 221400 -- 265680

-- ===============

-- Kaz'rogal 17888- boss_kazrogal
UPDATE `creature_template` SET `minhealth`='5098800',`maxhealth`='5098800' WHERE `entry` = '17888'; -- 4249000 -- 5098800

-- ===============

-- Azgalor 17842
UPDATE `creature_template` SET `minhealth`='5098800',`maxhealth`='5098800' WHERE `entry` = '17842'; -- 4249000 -- 5098800

-- Lesser Doomguard 17864- mob_lesser_doomguard
UPDATE `creature_template` SET `minhealth`='174000',`maxhealth`='174000' WHERE `entry` = '17864'; -- 145000 -- 174000

-- ===============

-- Archimonde 17968- boss_archimonde
UPDATE `creature_template` SET `minhealth`='5463000',`maxhealth`='5463000' WHERE `entry` = '17968'; -- 4552500 -- 5463000

-- ======================================================
-- Black Temple
-- https://github.com/Looking4Group/L4G_Core/issues/634
-- ======================================================

-- High Warlord Naj'entus 22887 - boss_najentus
UPDATE `creature_template` SET `minhealth`='4552800',`maxhealth`='4552800' WHERE `entry` = '22887'; -- 3794000 -- 4552800

-- ===============

-- Supremus 22898- boss_supremus

-- ===============

-- Shade of Akama 22841- boss_shade_of_akama
UPDATE `creature_template` SET `minhealth`='1152848',`maxhealth`='1327118' WHERE `entry` = '22841'; -- 960707-1105932 -- 1152848-13271184

-- Ashtongue Channeler 23421- mob_ashtongue_channeler
UPDATE `creature_template` SET `minhealth`='150810',`maxhealth`='150810' WHERE `entry` = 23421; -- 125675 -- 150810

-- Ashtongue Sorcerer 23215- mob_ashtongue_sorcerer
UPDATE `creature_template` SET `minhealth`='105600',`maxhealth`='120938' WHERE `entry` = 23215; -- 88000-100782 -- 105600-120938

-- Ashtongue Defender 23216- mob_ashtongue_defender
UPDATE `creature_template` SET `minhealth`='94800',`maxhealth`='110135' WHERE `entry` = 23216; -- 79000-91779 -- 94800-110135

-- Ashtongue Elementalist 23523- mob_ashtongue_elementalist
UPDATE `creature_template` SET `minhealth`='25349',`maxhealth`='28643' WHERE `entry` = 23523; -- 21124-23869 -- 25349-28643

-- Ashtongue Spiritbinder 23524- mob_ashtongue_spiritbinder
UPDATE `creature_template` SET `minhealth`='27485',`maxhealth`='29048' WHERE `entry` = 23524; -- 22904-24207 -- 27485-29048

-- Ashtongue Rogue 23318- mob_ashtongue_rogue
UPDATE `creature_template` SET `minhealth`='34289',`maxhealth`='36248' WHERE `entry` = 23318; -- 28574-30207 -- 34289-36248

-- ===============

-- Teron Gorefiend 22871- boss_teron_gorefiend
UPDATE `creature_template` SET `minhealth`='6009300',`maxhealth`='6009300' WHERE `entry` = 22871; -- 5007750 -- 6009300

-- ===============

-- Gurtogg Bloodboil 22948- boss_gurtogg_bloodboil
UPDATE `creature_template` SET `minhealth`='6829200',`maxhealth`='6829200' WHERE `entry` = 22948; -- 5691000 -- 6829200

-- ===============

-- Essence of Suffering 23418- boss_essence_of_suffering
UPDATE `creature_template` SET `minhealth`='2691960',`maxhealth`='2764800' WHERE `entry` = 23418; -- 2243300-2304000 -- 2691960-2764800

-- Essence of Desire 23419- boss_essence_of_desire
UPDATE `creature_template` SET `minhealth`='3600000',`maxhealth`='3600000' WHERE `entry` = 23419; -- 3000000 -- 3600000

-- Essence of Anger 23420- boss_essence_of_anger
UPDATE `creature_template` SET `minhealth`='3600000',`maxhealth`='3600000' WHERE `entry` = 23420; -- 3000000 -- 3600000

-- ===============

-- Mother Shahraz 22947- boss_mother_shahraz
UPDATE `creature_template` SET `minhealth`='5463000',`maxhealth`='5463000' WHERE `entry` = 22947; -- 4552500 -- 5463000

-- ===============

-- Gathios the Shatterer 22949- boss_gathios_the_shatterer
-- UPDATE `creature_template` SET `minhealth`='1785000',`maxhealth`='1785000' WHERE `entry` = 22949; -- 1785000 -- 2142000
-- High Nethermancer Zerevor 22950- boss_high_nethermancer_zerevor
-- Lady Malande 22951- boss_lady_malande
-- Veras Darkshadow 22952- boss_veras_darkshadow

-- ===============

-- Illidan Stormrage 22917- boss_illidan_stormrage
UPDATE `creature_template` SET `minhealth`='7284480',`maxhealth`='7284480' WHERE `entry` = 22917; -- 6070400 -- 2142000

-- Flame of Azzinoth 22997- boss_illidan_flameofazzinoth
UPDATE `creature_template` SET `minhealth`='1365840',`maxhealth`='1365840' WHERE `entry` = 22917; -- 1138200 -- 1365840

-- ======================================================
-- Zul'aman
-- https://github.com/Looking4Group/L4G_Core/issues/633
-- ======================================================


-- ======================================================
-- Sunwell
-- https://github.com/Looking4Group/L4G_Core/issues/511
-- ======================================================


-- =============
-- Magtheridon & SSC Trash HP Reset
-- =============

-- Hellfire Warder – Höllenfeuerwärter 18829
UPDATE `creature_template` SET `minhealth`='188896',`maxhealth`='188896' WHERE `entry` = 18829; -- 188896 -- 245565 207786

-- Vashj'ir Honor Guard 21218
UPDATE `creature_template` SET `maxhealth`='260000',`maxhealth`='260000' WHERE `entry` = 21218; -- 260000 -- 338000

-- Underbog Colossus 21251
UPDATE `creature_template` SET `minhealth`='620000',`maxhealth`='620000' WHERE `entry` = 21251; -- 620000 -- 806000

-- Coilfang Priestess 21220
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21220; -- 143600-153600 -- 195000

-- Tidewalker Depth-Seer 21224
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21224; -- 143600-153600 -- 186680-195000

-- Coilfang Serpentguard 21298
UPDATE `creature_template` SET `minhealth`='179525',`maxhealth`='179525' WHERE `entry` = 21298; -- 179525 -- 233383

-- Coilfang Shatterer 21301
UPDATE `creature_template` SET `minhealth`='200000',`maxhealth`='200000' WHERE `entry` = 21301; -- 200000 -- 260000

-- Colossus Lurker 22347
UPDATE `creature_template` SET `minhealth`='160000',`maxhealth`='160000' WHERE `entry` = 22347; -- 160000 -- 208000

-- Greyheart Nether-Mage 21230
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21230; -- 143600-153600 -- 186680

-- Colossus Rager 22352
UPDATE `creature_template` SET `minhealth`='46944',`maxhealth`='46944' WHERE `entry` = 22352; -- 46944(27944) -- 61027

-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `minhealth`='120000',`maxhealth`='120000' WHERE `entry` = 21863; -- 120000 -- 156000

-- Greyheart Shield-Bearer 21231
UPDATE `creature_template` SET `minhealth`='200000',`maxhealth`='200000' WHERE `entry` = 21231; -- 200000 -- 260000

-- Greyheart Technician 21263
UPDATE `creature_template` SET `minhealth`='24000',`maxhealth`='24000' WHERE `entry` = 21263; -- 24000 -- 31200

-- Tidewalker Warrior 21225
UPDATE `creature_template` SET `minhealth`='210000',`maxhealth`='210000' WHERE `entry` = 21225; -- 210000 -- 273000

-- Tidewalker Shaman 21226
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21226; -- 143600-153600 -- 186680-195000

-- Tidewalker Harpooner 21227 http://wowwiki.wikia.com/wiki/Tidewalker...id=1234855
UPDATE `creature_template` SET `minhealth`='179525',`maxhealth`='190000' WHERE `entry` = 21227; -- 179525-190000 -- 233383-247000

-- Tidewalker Hydromancer 21228 http://wowwiki.wikia.com/wiki/Tidewalker_Hydromancer
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21228; -- 143600-153600 -- 186680-195000

-- Coilfang Beast-Tamer 21221
UPDATE `creature_template` SET `minhealth`='250000',`maxhealth`='250000' WHERE `entry` = 21221; -- 250000 -- 400000

-- Coilfang Fathom-Witch 21299
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21299; -- 143600-153600 -- 186680

-- Coilfang Hate-Screamer 21339
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21339; -- 143600-153600 -- 186680

-- Greyheart Skulker 21232
UPDATE `creature_template` SET `minhealth`='179525',`maxhealth`='179525' WHERE `entry` = 21232; -- 179525 -- 233383

-- Greyheart Tidecaller 21229
UPDATE `creature_template` SET `minhealth`='143600',`maxhealth`='153600' WHERE `entry` = 21229; -- 143600-153600 -- 186680

-- Water Elemental Totem 22236
UPDATE `creature_template` SET `minhealth`='4300',`maxhealth`='4300' WHERE `entry` = 22236; -- 4300 -- 5590

-- Serpentshrine Tidecaller 22238
UPDATE `creature_template` SET `minhealth`='86160',`maxhealth`='86160' WHERE `entry` = 22238; -- 86160 -- 86160

-- Serpentshrine Sporebat 21246
UPDATE `creature_template` SET `minhealth`='214300',`maxhealth`='214300' WHERE `entry` = 21246; -- 214300 -- 214300

-- Tainted Water Elemental 21253
UPDATE `creature_template` SET `minhealth`='10772',`maxhealth`='11000' WHERE `entry` = 21253; -- 10772-11000-- 14004-14300

-- Purified Water Elemental 21260
UPDATE `creature_template` SET `minhealth`='10772',`maxhealth`='12000' WHERE `entry` = 21260; -- 11772-12000-- 15304-15600

-- =====================
-- TK Trash HP Reset
-- ======================

-- Bloodwarder Legionnaire 20031
UPDATE `creature_template` SET `minhealth`='180000',`maxhealth`='180000' WHERE `entry` = 20031; -- 180000 -- 234000

-- Bloodwarder Vindicator 20032
UPDATE `creature_template` SET `minhealth`='229760',`maxhealth`='229760' WHERE `entry` = 20032; -- 229760 -- 289697

-- Astromancer 20033
UPDATE `creature_template` SET `minhealth`='150000',`maxhealth`='150000' WHERE `entry` = 20033; -- 150000 -- 195000

-- Star Scryer 20034
UPDATE `creature_template` SET `minhealth`='160000',`maxhealth`='160000' WHERE `entry` = 20034; -- 160000 -- 208000

-- Bloodwarder Marshal 20035
UPDATE `creature_template` SET `minhealth`='295200',`maxhealth`='295200' WHERE `entry` = 20035; -- 295200 -- 383760

-- Bloodwarder Squire 20036
UPDATE `creature_template` SET `minhealth`='150000',`maxhealth`='150000' WHERE `entry` = 20036; -- 150000 -- 195000

-- Tempest Falconer 20037
UPDATE `creature_template` SET `minhealth`='150000',`maxhealth`='150000' WHERE `entry` = 20037; -- 150000 -- 195000

-- Phoenix-Hawk Hatchling 20038
UPDATE `creature_template` SET `minhealth`='72000',`maxhealth`='72000' WHERE `entry` = 20038; -- ~72000 -- 91000

-- Phoenix-Hawk 20039 x1.6
UPDATE `creature_template` SET `minhealth`='550000',`maxhealth`='550000' WHERE `entry` = 20039; -- 550000 -- 880000

-- Crystalcore Devastator 20040 x1.7
UPDATE `creature_template` SET `minhealth`='553500',`maxhealth`='553500' WHERE `entry` = 20040; -- 553500 -- 940950

-- Crystalcore Sentinel 20041 x1.7
UPDATE `creature_template` SET `minhealth`='295200',`maxhealth`='295200' WHERE `entry` = 20041; -- 295200 -- 501840

-- Tempest-Smith 20042
UPDATE `creature_template` SET `minhealth`='190000',`maxhealth`='190000' WHERE `entry` = 20042; -- 190000 -- 234000
 
-- Apprentice Star Scryer 20043
UPDATE `creature_template` SET `minhealth`='25000',`maxhealth`='25000' WHERE `entry` = 20043; -- 25000 -- 32500

-- Novice Astromancer 20044
UPDATE `creature_template` SET `minhealth`='26000',`maxhealth`='26000' WHERE `entry` = 20044; -- 26000 -- 33800

-- Nether Scryer 20045
UPDATE `creature_template` SET `minhealth`='190000',`maxhealth`='190000' WHERE `entry` = 20045; -- 190000 -- 234000

-- Astromancer Lord 20046
UPDATE `creature_template` SET `minhealth`='236120',`maxhealth`='236120' WHERE `entry` = 20046; -- 236120 -- 312000

-- Crimson Hand Battle Mage 20047
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000' WHERE `entry` = 20047; -- 140000 -- 182000

-- Crimson Hand Centurion 20048
UPDATE `creature_template` SET `minhealth`='180000',`maxhealth`='180000' WHERE `entry` = 20048; -- 180000 -- 234000

-- Crimson Hand Blood Knight 20049
UPDATE `creature_template` SET `minhealth`='230000',`maxhealth`='230000' WHERE `entry` = 20049; -- 230000 -- 299000

-- Crimson Hand Inquisitor 20050
UPDATE `creature_template` SET `minhealth`='230000',`maxhealth`='230000' WHERE `entry` = 20050; -- 230000 -- 299000

-- Crystalcore Mechanic 20052
UPDATE `creature_template` SET `minhealth`='180000',`maxhealth`='180000' WHERE `entry` = 20052; -- 180000 -- 234000


-- ================
-- 2.1 Units
-- ================

-- ========
-- Phase IN
-- ========

UPDATE `creature` SET `spawnmask`=1 WHERE `id` IN (18528,22861,22862,22863,22864);
UPDATE `creature` SET `spawnmask`=1 WHERE `guid` IN (84715);
UPDATE `creature` SET `id` = '23029' WHERE `id` = 21844; -- 23029

-- ========
-- Phase OUT
-- ========

UPDATE `creature` SET `spawnmask`=0 WHERE `id` IN (22201,22221,22217,22218,22287,22289,22451,22174,22283,22385);


-- S3 Vendor
DELETE FROM `npc_vendor` WHERE `entry` = 77777;
-- Shield
INSERT INTO `npc_vendor` VALUES (77777, 33661, 0, 0, 2364);
INSERT INTO `npc_vendor` VALUES (77777, 33735, 0, 0, 2364);
INSERT INTO `npc_vendor` VALUES (77777, 33755, 0, 0, 2364);
-- Offhand
INSERT INTO `npc_vendor` VALUES (77777, 33662, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33689, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33705, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33734, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33756, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33801, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 34015, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 34016, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33681, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33736, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 34033, 0, 0, 2363);
-- Shoulder
INSERT INTO `npc_vendor` VALUES (77777, 33668, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33674, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33679, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33682, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33693, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33699, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33703, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33710, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33715, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33720, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33726, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33732, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33742, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33747, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33753, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33757, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33770, 0, 0, 2359);
-- Melee MH
INSERT INTO `npc_vendor` VALUES (77777, 33669, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33733, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33737, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33754, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33762, 0, 0, 2362);
-- Caster MH
INSERT INTO `npc_vendor` VALUES (77777, 33687, 0, 0, 2361); 
INSERT INTO `npc_vendor` VALUES (77777, 33743, 0, 0, 2361);
INSERT INTO `npc_vendor` VALUES (77777, 33763, 0, 0, 2361);
-- Wands etc
INSERT INTO `npc_vendor` VALUES (77777, 33764, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33765, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33841, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33842, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33843, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33938, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33941, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33944, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33947, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33950, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33953, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 34014, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 34059, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 34066, 0, 0, 2339);
-- 2H Weapon & Ranged
INSERT INTO `npc_vendor` VALUES (77777, 33006, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33663, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33670, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33688, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33716, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33727, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33766, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 34529, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 34530, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 34540, 0, 0, 2360);
-- Chest
INSERT INTO `npc_vendor` VALUES (77777, 33664, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33675, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33680, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33685, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33694, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33695, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33704, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33706, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33711, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33721, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33722, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33728, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33738, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33748, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33749, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33760, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33771, 0, 0, 2337);
-- Head
INSERT INTO `npc_vendor` VALUES (77777, 33666, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33672, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33677, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33683, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33691, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33697, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33701, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33708, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33713, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33718, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33724, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33730, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33740, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33745, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33751, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33758, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33768, 0, 0, 2365);
-- Legs
INSERT INTO `npc_vendor` VALUES (77777, 33667, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33673, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33678, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33686, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33692, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33698, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33702, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33709, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33714, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33719, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33725, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33731, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33741, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33746, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33752, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33761, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33769, 0, 0, 2366);
-- Gloves
INSERT INTO `npc_vendor` VALUES (77777, 33665, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33671, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33676, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33684, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33690, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33696, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33700, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33707, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33712, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33717, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33723, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33729, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33739, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33744, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33750, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33759, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33767, 0, 0, 2286);

-- Bloodmaul Taskmaster 
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 22160;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22160;
INSERT INTO `creature_ai_scripts` VALUES
(2216001,22160,0,0,100,1,6000,6000,14000,15000,11,37592,1,0,0,0,0,0,0,0,0,0,'Bloodmaul Taskmaster - Casts Knockdown'),
(2216002,22160,0,0,100,1,8000,8000,18000,18000,11,34932,0,1,0,0,0,0,0,0,0,0,'Bloodmaul Taskmaster - Casts Bloodmaul Buzz'),
(2216003,22160,8,2,100,1,38173,-1,8000,8000,22,1,0,0,0,0,0,0,0,0,0,0,'Bloodmaul Taskmaster - q10714'),
(2216004,22160,10,1,100,1,0,50,8000,8000,33,22383,6,0,23,-1,0,0,41,0,0,0,'Bloodmaul Taskmaster - q10714');

-- Shadowsworn Drakonid
-- skinningloot
UPDATE `creature_template` SET `AIName`='EventAI',`mindmg`='500',`maxdmg`='1000' WHERE `entry` = 22072; -- 334 682
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22072;
INSERT INTO `creature_ai_scripts` VALUES
('2207201','22072','0','0','100','1','3500','4000','8000','12000','11','15496','1','0','0','0','0','0','0','0','0','0','Shadowsworn Drakonid  - Cleave'),
('2207202','22072','9','0','100','1','0','5','5000','10000','11','17547','1','0','0','0','0','0','0','0','0','0','Shadowsworn Drakonid  - Mortal Strike'),
('2207203','22072','9','0','100','1','0','5','4000','5000','11','16145','1','0','0','0','0','0','0','0','0','0','Shadowsworn Drakonid - Cast Sunder Armor');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21863;
INSERT INTO `creature_ai_scripts` VALUES
('2186301','21863','4','0','100','2','0','0','0','0','23','1','0','0','11','38655','1','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 and Cast Poison Bolt Volley on Aggro'),
('2186302','21863','9','5','100','3','3000','6000','4000','8000','11','38655','1','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Poison Bolt Volley (Phase 1)'),
-- ('2186303','21863','24','5','100','3','38655','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 2 on Target Max Poison Bolt Volley Aura Stack (Phase 1)'),
-- ('2186304','21863','28','3','100','3','38655','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 on Target Missing Poison Bolt Volley Aura Stack (Phase 2)'),
-- ('2186305','21863','9','0','100','3','0','5','18900','18900','11','38650','0','1','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'),
('2186306','21863','9','0','100','3','0','5','5000','10000','12','17990','1','20000','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Spawn Underbog Mushroom'),
('2186307','21863','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21694;
INSERT INTO `creature_ai_scripts` VALUES
('2169401','21694','11','0','100','2','0','0','0','0','11','37266','0','1','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Cast Disease Cloud on Spawn'),
('2169402','21694','11','0','100','4','0','0','0','0','11','37863','0','1','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Cast Disease Cloud on Spawn'),
('2169403','21694','4','0','100','6','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Bog Overlord - Set Phase 1 on Aggro'),
('2169404','21694','9','5','100','3','0','5','4000','6000','11','37272','1','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Cast Poison Bolt (Phase 1)'),
('2169405','21694','9','5','100','5','0','5','4000','6000','11','37862','1','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Cast Poison Bolt (Phase 1)'),
-- ('2169406','21694','24','5','100','3','37272','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Set Phase 2 on Target Max Poison Bolt Aura Stack (Phase 1)'),
-- ('2169407','21694','24','5','100','5','37862','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Set Phase 2 on Target Max Poison Bolt Aura Stack (Phase 1)'),
-- ('2169408','21694','28','3','100','3','37272','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Set Phase 1 on Target Missing Poison Bolt Aura Stack (Phase 2)'),
-- ('2169409','21694','28','3','100','5','37862','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Set Phase 1 on Target Missing Poison Bolt Aura Stack (Phase 2)'),
('2169410','21694','0','0','100','7','2000','5000','12000','19000','11','32065','4','33','0','0','0','0','0','0','0','0','Bog Overlord - Cast Fungal Decay'),
('2169411','21694','0','0','100','3','7000','9500','12000','15000','11','40340','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Cast Trample'), -- eig nur 40340
('2169412','21694','0','0','100','5','7000','9500','12000','15000','11','40492','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Cast Trample'), -- eig nur 40340
('2169413','21694','2','0','100','6','20','0','0','0','11','8599','0','0','1','-46','0','0','0','0','0','0','Bog Overlord - Cast Enrage at 20% HP'),
('2169414','21694','7','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Bog Overlord - Set Phase to 0 on Evade');

-- Shadow Council Warlock 21302
 UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 21302;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21302;
INSERT INTO `creature_ai_scripts` VALUES
('2130201','21302','11','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Set Phase 1 on Spawn'),
('2130202','21302','9','13','100','1','0','40','3000','3800','11','9613','1','0','0','0','0','0','0','0','0','0','Shadow Council Warlock -  Cast Shadow Bolt (Phase 1)'),
('2130203','21302','9','13','100','1','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Start Combat Movement Below 5 Yards'),
('2130204','21302','9','13','100','1','5','35','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Prevent Combat Movement between 5 and 35 Yards (Phase 1)'),
('2130205','21302','9','13','100','1','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Start Combat Movement at 35 Yards (Phase 1)'),
('2130206','21302','3','13','100','0','15','0','0','0','21','1','0','0','22','2','0','0','0','0','0','0','Shadow Council Warlock - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('2130207','21302','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Set Phase 1 when Mana is above 30% (Phase 2)'),
('2130208','21302','2','0','100','0','30','0','0','0','21','1','0','0','22','3','0','0','0','0','0','0','Shadow Council Warlock - Start Combat Movement and Set Phase 3 when HP are below 30%'),
('2130209','21302','9','7','100','0','0','15','0','0','11','37992','1','1','21','1','0','0','0','0','0','0','Shadow Council Warlock - Prevent Combat Movement and Cast Drain Life when in 15 yard range (Phase 3)'),
('2130210','21302','9','7','100','1','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Start Combat Movement Below 5 Yards'),
('2130211','21302','9','7','100','1','15','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Start Combat Movement at 15 Yards (Phase 3)'),
('2130212','21302','2','7','100','0','100','45','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Set Phase 1 when Life is above 45% (Phase 3)'),
('2130213','21302','7','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Shadow Council Warlock - Set Phase 1 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21296;
INSERT INTO `creature_ai_scripts` VALUES
('2129601','21296','11','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Bladespire Champion - Set Phase 1 on Spawned'),
('2129602','21296','4','0','100','0','0','0','0','0','11','37777','1','0','0','0','0','0','0','0','0','0','Bladespire Champion - Cast Mighty Charge on Aggro'),
-- ('2129603','21296','30','4','100','1','5','21241','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Bladespire Champion (Phase 1) - Set Phase 2 on Received AI Event'),
-- ('2129604','21296','1','2','100','0','25000','25000','0','0','24','0','0','0','0','0','0','0','0','0','0','0','Bladespire Champion (Phase 2) - Evade on OOC Timer'),
('2129605','21296','0','0','100','1','5000','8000','12000','18000','11','8078','0','0','0','0','0','0','0','0','0','0','Bladespire Champion - Cast Thunderclap'),
('2129606','21296','7','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Bladespire Champion - Set Phase 1 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21230;
INSERT INTO `creature_ai_scripts` VALUES
('2123001','21230','11','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Spawn'),
('2123002','21230','4','125','100','2','0','0','0','0','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt on Aggro (Phase 1)'),
('2123003','21230','9','125','100','3','0','40','1200','4800','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt (Phase 1)'),
('2123004','21230','9','125','100','3','0','5','8000','12000','11','38644','0','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Cone of Cold (Phase 1)'),
('2123005','21230','0','125','100','3','6000','12000','8400','12000','11','38646','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blizzard (Phase 1)'),
('2123006','21230','1','125','100','3','1000','1000','1800000','1800000','11','38649','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction OOC (Phase 1)'),
('2123007','21230','16','125','100','3','38649','1','5000','5000','11','38649','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction on Missing Buff (Phase 1)'),
('2123008','21230','1','119','100','3','1000','1000','1800000','1800000','11','38648','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction OOC (Phase 3)'),
('2123009','21230','4','119','100','2','0','0','0','0','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball on Aggro (Phase 3)'),
('2123010','21230','9','119','100','3','0','40','1200','4800','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball (Phase 3)'),
('2123011','21230','0','119','100','3','6000','12000','8400','12000','11','38635','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Rain of Fire (Phase 3)'),
('2123012','21230','9','119','100','2','0','30','9000','12000','11','38636','1','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Scorch (Phase 3)'),
('2123013','21230','16','119','100','3','38648','1','5000','5000','11','38648','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction on Missing Buff (Phase 3)'),
('2123014','21230','1','95','100','3','1000','1000','1800000','1800000','11','38647','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction OOC (Phase 2)'),
('2123015','21230','4','95','100','2','0','0','0','0','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley on Aggro (Phase 5)'),
('2123016','21230','9','95','100','3','0','40','4800','9600','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley (Phase 5)'),
('2123017','21230','0','95','100','3','2000','6000','9600','12600','11','38634','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Lightning (Phase 5)'),
('2123018','21230','16','95','100','3','38647','1','5000','5000','11','38647','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction on Missing Buff (Phase 5)'),
('2123019','21230','0','0','75','3','6000','18000','17000','24000','11','38642','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blink'),
('2123020','21230','7','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21226;
INSERT INTO `creature_ai_scripts` VALUES
('2122602','21226','1','0','100','3','1000','1000','600000','600000','11','39067','0','1','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Lightning Shield OOC'),
('2122604','21226','9','0','100','3','0','40','5000','8000','11','39065','1','0','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Lightning Bolt'),
('2122610','21226','16','0','100','3','39067','1','10000','20000','11','39067','0','32','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Lightning Shield on Missing Buff'),
('2122611','21226','9','0','100','2','0','30','12000','18000','11','39066','4','0','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Chain Lightning');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20898;
INSERT INTO `creature_ai_scripts` VALUES
('2089801','20898','4','0','100','2','0','0','0','0','11','38855','0','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Normal) - Cast Fire Shield on Aggro'),
('2089802','20898','4','0','100','4','0','0','0','0','11','38901','0','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Heroic) - Cast Fire Shield on Aggro'),
('2089803','20898','0','0','100','3','6000','13000','18000','24000','11','36837','4','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Normal) - Cast Meteor'),
('2089804','20898','0','0','100','5','6000','10000','16000','20000','11','38903','4','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Heroic) - Cast Meteor'),
('2089805','20898','16','0','100','3','38855','1','15000','30000','11','38855','0','33','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Normal) - Cast Fire Shield on Missing Buff'),
('2089806','20898','16','0','100','5','38901','1','15000','30000','11','38901','0','33','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Heroic) - Cast Fire Shield on Missing Buff');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20723;
INSERT INTO `creature_ai_scripts` VALUES
('2072301','20723','11','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Korgaah - Set Phase 1 on Spawned'),
-- ('2072302','20723','30','4','100','1','5','21241','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Korgaah (Phase 1) - Set Phase 2 on Received AI Event'),
-- ('2072303','20723','1','2','100','0','25000','25000','0','0','24','0','0','0','0','0','0','0','0','0','0','0','Korgaah (Phase 2) - Evade on OOC Timer'),
('2072304','20723','0','0','100','1','5000','8000','7000','13000','11','34802','1','0','0','0','0','0','0','0','0','0','Korgaah - Cast Kick'),
('2072305','20723','0','0','100','1','6000','12000','15000','25000','11','23600','0','0','0','0','0','0','0','0','0','0','Korgaah - Cast Piercing Howl'),
('2072306','20723','2','0','100','0','20','0','0','0','11','8599','0','0','0','0','0','0','0','0','0','0','Korgaah - Cast Enrage at 20% HP'),
('2072307','20723','7','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Korgaah - Set Phase 1 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20334;
INSERT INTO `creature_ai_scripts` VALUES
('2033401','20334','11','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Bladespire Cook - Set Phase 1 on Spawned'),
-- ('2033402','20334','30','4','100','1','5','21241','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Bladespire Cook (Phase 1) - Set Phase 2 on Received AI Event'),
-- ('2033403','20334','1','2','100','0','25000','25000','0','0','24','0','0','0','0','0','0','0','0','0','0','0','Bladespire Cook (Phase 2) - Evade on OOC Timer'),
('2033404','20334','0','0','100','1','5000','8000','7000','13000','11','37597','1','0','0','0','0','0','0','0','0','0','Bladespire Cook - Cast Meat Slap'),
('2033405','20334','0','0','100','1','1000','3000','10000','20000','11','37596','1','0','0','0','0','0','0','0','0','0','Bladespire Cook - Cast Tenderize'),
('2033406','20334','7','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Bladespire Cook - Set Phase 1 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20046;
INSERT INTO `creature_ai_scripts` VALUES
('2004601','20046','1','0','100','3','1000','1000','600000','600000','11','38732','0','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Shield OOC'),
('2004602','20046','9','0','100','3','0','40','3400','4800','11','37109','4','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fireball Volley'),
('2004603','20046','9','0','100','3','0','20','12000','16000','11','37110','4','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Blast'),
('2004604','20046','9','0','100','3','0','5','15000','20000','11','37289','1','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Dragon\'s Breath'),
('2004605','20046','16','0','100','3','38732','1','3000','6000','11','38732','0','32','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Shield on Missing Buff'),
('2004606','20046','0','0','100','3','8000','12000','10000','20000','11','37122','5','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Domination'),
('2004607','20046','0','0','100','3','8000','16000','16000','32000','11','36278','0','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Blast Wave');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20043;
INSERT INTO `creature_ai_scripts` VALUES
('2004301','20043','4','0','100','2','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Set Phase 1 on Aggro'),
('2004302','20043','9','0','100','3','0','50','3400','4800','11','37129','4','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Volley'),
('2004303','20043','9','13','100','3','0','20','8000','12000','11','37133','1','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Buffet (Phase 1)'),
-- ('2004304','20043','24','13','100','3','37133','10','5000','5000','22','2','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Set Phase 2 on Target Max Arcane Buffet Aura Stack (Phase 1)'),
-- ('2004305','20043','28','11','100','3','37133','1','5000','5000','22','1','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Set Phase 1 on Target Missing Arcane Buffet Aura Stack (Phase 2)'),
('2004306','20043','9','0','100','3','0','8','12000','16000','11','38725','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Explosion'),
('2004307','20043','0','0','100','3','15000','18000','14000','17000','11','37132','1','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Shock');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20033;
INSERT INTO `creature_ai_scripts` VALUES
('2003301','20033','1','0','100','3','1000','1000','600000','600000','11','35915','0','1','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor OOC'),
('2003302','20033','4','0','100','2','0','0','0','0','11','35915','0','32','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor on Aggro'),
('2003303','20033','9','0','100','3','0','40','5000','7000','11','37109','4','0','0','0','0','0','0','0','0','0','Astromancer - Cast Fireball Volley'),
('2003304','20033','9','0','100','3','0','20','6000','18000','11','37110','1','0','0','0','0','0','0','0','0','0','Astromancer - Cast Fire Blast'),
('2003305','20033','16','0','100','3','35915','1','8000','24000','11','33482','0','32','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor on Missing Buff'),
('2003306','20033','0','0','100','3','8000','16000','8000','12000','11','36278','0','1','0','0','0','0','0','0','0','0','Astromancer - Cast Blast Wave');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19985;
INSERT INTO `creature_ai_scripts` VALUES
(1998501,19985,1,0,100,1,1000,1000,150000,150000,11,12550,0,1,0,0,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Cast Lightning Shield'),
(1998502,19985,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Start Movement on Aggro'),
(1998503,19985,4,0,100,0,0,0,0,0,11,9532,1,0,22,1,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Cast Lighting Bolt and Set Phase 1 on Aggro'),
(1998504,19985,0,13,100,1,3000,4000,3000,4000,0,0,0,0,11,9532,1,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Cast Lighting Bolt (Phase 1)'),
(1998505,19985,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Start Movement and Set Phase 2 when Mana is at 15%'),
(1998506,19985,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Start Movement Beyond 25 Yards'),
(1998507,19985,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Set Phase 1 when Mana is above 30% (Phase 2)'),
(1998508,19985,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - Set Phase 3 at 15% HP'),
(1998509,19985,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Ruuan\'ok Cloudgazer - Start Movement and Flee at 15% HP (Phase 3)'),
(1998510,19985,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Ruuan\'ok Cloudgazer - On Evade set Phase to 0'),
('1998511','19985','16','0','100','1','12544','1','15000','30000','11','12544','0','1','0','0','0','0','0','0','0','0','Ruuan\'ok Cloudgazer - Cast Lightning Shield on Missing Buff');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19947;
INSERT INTO `creature_ai_scripts` VALUES
('1994701','19947','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Prevent Combat Movement on Spawn'),
('1994702','19947','1','0','100','1','1000','1000','1800000','1800000','11','12544','0','1','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Frost Armor on Spawn'),
('1994703','19947','4','0','100','0','0','0','0','0','11','13901','1','0','23','1','0','0','0','0','0','0','Darkcrest Sorceress - Cast Arcane Bolt and Set Phase 1 on Aggro'),
('1994704','19947','9','13','100','1','0','40','2500','3000','11','13901','1','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Arcane Bolt (Phase 1)'),
('1994705','19947','3','13','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Darkcrest Sorceress - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1994706','19947','9','13','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Start Combat Movement at 35 Yards (Phase 1)'),
('1994707','19947','9','13','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1994708','19947','9','13','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Start Combat Movement Below 5 Yards'),
('1994709','19947','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Set Phase 1 when Mana is above 30% (Phase 2)'),
-- ('1994710','19947','0','0','100','1','10000','15000','20000','25000','11','34787','1','1','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Freezing Circle'),
('1994711','19947','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Set Phase 3 at 15% HP'),
('1994712','19947','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Darkcrest Sorceress - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1994713','19947','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Set Phase to 0 on Evade'),
('1994714','19947','0','0','100','7','10000','10000','10000','10000','11','12544','0','33','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Ice Barrier on Missing Ice Barrier Aura');

DELETE FROM `creature_ai_scripts` WHERE `id` IN (1941115,1941116);
INSERT INTO `creature_ai_scripts` VALUES
('1941115','19411','0','0','100','1','5000','10000','15000','30000','11','13787','0','32','0','0','0','0','0','0','0','0','Shattered Hand Warlock - Cast Demon Armor on Missing Buff'),
('1941116','19411','6','0','100','0','0','0','0','0','33','22334','6','0','0','0','0','0','0','0','0','0','Shattered Hand Warlock - Quest Kill Credit');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18640;
INSERT INTO `creature_ai_scripts` VALUES
('1864001','18640','11','0','100','6','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Cabal Warlock - Start Combat Movement on Spawn'),
('1864002','18640','1','0','100','7','1000','1000','1800000','1800000','11','13787','0','1','0','0','0','0','0','0','0','0','Cabal Warlock - Cast Demon Armor OCC'),
('1864003','18640','4','0','10','38','0','0','0','0','1','-9986','-9985','-9984','0','0','0','0','0','0','0','0','Cabal Warlock - Random Say on Aggro'),
('1864004','18640','4','0','100','2','0','0','0','0','11','12471','1','0','23','1','0','0','0','0','0','0','Cabal Warlock (Normal) - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('1864005','18640','9','5','100','3','0','40','3000','4500','11','12471','1','0','0','0','0','0','0','0','0','0','Cabal Warlock (Normal) - Cast Shadow Bolt (Phase 1)'),
('1864006','18640','4','0','100','4','0','0','0','0','11','15232','1','0','23','1','0','0','0','0','0','0','Cabal Warlock (Heroic) - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('1864007','18640','9','5','100','5','0','40','3000','4500','11','15232','1','0','0','0','0','0','0','0','0','0','Cabal Warlock (Heroic) - Cast Shadow Bolt (Phase 1)'),
('1864008','18640','3','5','100','6','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Cabal Warlock - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1864009','18640','9','5','100','6','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Cabal Warlock - Start Combat Movement at 35 Yards (Phase 1)'),
('1864010','18640','9','5','100','6','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Cabal Warlock - Start Combat Movement at 15 Yards (Phase 1)'),
('1864011','18640','9','5','100','6','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Cabal Warlock - Start Combat Movement Below 5 Yards'),
('1864012','18640','3','3','100','7','100','30','100','100','23','-1','0','0','0','0','0','0','0','0','0','0','Cabal Warlock - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1864013','18640','0','0','100','3','6000','6600','6000','9000','11','32863','4','32','0','0','0','0','0','0','0','0','Cabal Warlock (Normal) - Cast Seed of Corruption'),
('1864014','18640','0','0','100','5','6000','6600','6000','9000','11','38252','4','32','0','0','0','0','0','0','0','0','Cabal Warlock (Heroic) - Cast Seed of Corruption'),
('1864015','18640','16','0','100','7','13787','1','15000','30000','11','13787','0','1','0','0','0','0','0','0','0','0','Cabal Warlock - Cast Demon Armor on Missing Buff'),
('1864016','18640','7','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Cabal Warlock - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18633;
INSERT INTO `creature_ai_scripts` VALUES
('1863301','18633','4','0','10','6','0','0','0','0','1','-9988','-9987','-9984','0','0','0','0','0','0','0','0','Cabal Acolyte - Random Say on Aggro'),
('1863302','18633','1','0','100','7','1000','1000','3600000','3600000','11','33482','0','1','0','0','0','0','0','0','0','0','Cabal Acolyte - Cast Shadow Defense OCC'),
('1863303','18633','14','0','100','3','6500','20','5000','9000','11','12039','6','0','0','0','0','0','0','0','0','0','Cabal Acolyte (Normal) - Cast Heal on Friendlies'),
('1863304','18633','14','0','100','5','10000','20','5000','9000','11','38209','6','0','0','0','0','0','0','0','0','0','Cabal Acolyte (Heroic) - Cast Heal on Friendlies'),
('1863305','18633','14','0','100','3','4000','20','12000','15000','11','25058','6','0','0','0','0','0','0','0','0','0','Cabal Acolyte (Normal) - Cast Renew on Friendlies'),
('1863306','18633','14','0','100','5','7000','20','12000','15000','11','38210','6','0','0','0','0','0','0','0','0','0','Cabal Acolyte (Heroic) - Cast Renew on Friendlies'),
('1863307','18633','2','0','100','6','15','0','0','0','25','0','0','0','0','0','0','0','0','0','0','0','Cabal Acolyte - Fleeing on 15% HP'),
('1863308','18633','16','0','100','7','33482','1','15000','30000','11','33482','0','1','0','0','0','0','0','0','0','0','Cabal Warlock - Cast Shadow Defense on Missing Buff');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18326;
INSERT INTO `creature_ai_scripts` VALUES
('1832601','18326','4','0','15','6','0','0','0','0','1','-1240','-1242','-1243','0','0','0','0','0','0','0','0','Sethekk Shaman - Random Say on Aggro'),
('1832602','18326','4','0','100','6','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Sethekk Shaman - Set Phase 1 on Aggro'),
('1832603','18326','0','5','100','7','1000','5000','30000','30000','11','32663','1','1','39','10','0','0','0','0','0','0','Sethekk Shaman - Summon Dark Vortex (Phase 1)'),
-- ('1832604','18326','17','5','100','7','18701','5000','5000','0','23','1','0','0','0','0','0','0','0','0','0','0','Sethekk Shaman - Set Phase 2 on Dark Vortex Spawn (Phase 1)'),
-- ('1832605','18326','25','3','100','7','18701','5000','5000','0','23','-1','0','0','0','0','0','0','0','0','0','0','Sethekk Shaman - Set Phase 1 on Dark Vortex Death (Phase 2)'),
('1832606','18326','13','0','100','3','4300','9100','0','0','11','15501','6','1','0','0','0','0','0','0','0','0','Sethekk Shaman (Normal) - Cast Earth Shock'),
('1832607','18326','13','0','100','5','4300','9100','0','0','11','22885','6','1','0','0','0','0','0','0','0','0','Sethekk Shaman (Heroic) - Cast Earth Shock'),
('1832608','18326','6','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Sethekk Shaman - Set Phase 0 on Death');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18320;
INSERT INTO `creature_ai_scripts` VALUES
('1832001','18320','4','0','100','6','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage - Set Phase 1 on Aggro'),
('1832002','18320','0','5','100','3','4000','7000','10000','20000','11','32682','1','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Normal) - Cast Curse of the Dark Talon (Phase 1)'),
('1832003','18320','0','5','100','5','4000','7000','10000','20000','11','38149','1','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Heroic) - Cast Curse of the Dark Talon (Phase 1)'),
-- ('1832004','18320','24','5','100','3','32682','5','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Normal) - Set Phase 2 on Target Max Curse of the Dark Talon Aura Stack (Phase 1)'),
-- ('1832005','18320','24','5','100','5','38149','5','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Heroic) - Set Phase 2 on Target Max Curse of the Dark Talon Aura Stack (Phase 1)'),
-- ('1832006','18320','28','3','100','3','32682','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Normal) - Set Phase 1 on Target Missing Curse of the Dark Talon Aura Stack (Phase 2)'),
-- ('1832007','18320','28','3','100','5','38149','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Heroic) - Set Phase 1 on Target Missing Curse of the Dark Talon Aura Stack (Phase 2)'),
('1832008','18320','9','0','100','7','0','20','9300','21800','11','32677','1','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Normal) - Cast Shadow Missiles'),
('1832009','18320','9','0','100','7','0','20','9300','21800','11','38147','1','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage (Normal) - Cast Shadow Missiles'),
('1832010','18320','7','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Time-Lost Shadowmage - Set Phase to 0 on Evade'),
('1832011','18320','1','0','100','7','1000','1000','900000','900000','11','32689','0','1','0','0','0','0','0','0','0','0','Time-Lost Shadowmage - Cast Arcane Destruction OCC'),
('1832012','18320','16','0','100','7','32689','1','5000','5000','11','32689','0','1','0','0','0','0','0','0','0','0','Time-Lost Shadowmage - Cast Arcane Destruction on Missing Arcane Destruction Aura');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18318;
INSERT INTO `creature_ai_scripts` VALUES
('1831801','18318','4','0','15','6','0','0','0','0','1','-1240','-1241','-1243','0','0','0','0','0','0','0','0','Sethekk Initiate - Random Say on Aggro'),
('1831802','18318','4','0','100','6','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Sethekk Initiate - Set Phase 1 on Aggro'),
('1831803','18318','9','5','100','7','0','5','5000','5000','11','16145','1','0','0','0','0','0','0','0','0','0','Sethekk Initiate - Cast Sunder Armor (Phase 1)'),
-- ('1831804','18318','24','5','100','7','16145','5','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Sethekk Initiate - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
-- ('1831805','18318','28','3','100','7','16145','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Sethekk Initiate - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('1831806','18318','0','0','100','7','5000','7000','12000','15000','11','33961','0','1','0','0','0','0','0','0','0','0','Sethekk Initiate - Cast Spell Reflection'),
('1831807','18318','7','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Sethekk Initiate - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18114;
INSERT INTO `creature_ai_scripts` VALUES
('1811401','18114','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Prevent Combat Movement on Spawn'),
('1811402','18114','1','0','100','1','1000','1000','600000','600000','11','12550','0','1','0','0','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Shield on Spawn'),
('1811403','18114','4','0','100','0','0','0','0','0','11','9532','1','0','23','1','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Bolt and Set Phase 1 on Aggro'),
('1811404','18114','9','13','100','1','0','40','3000','3800','11','9532','1','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Bolt (Phase 1)'),
('1811405','18114','3','13','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Feralfen Mystic - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1811406','18114','9','13','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Start Combat Movement at 35 Yards (Phase 1)'),
('1811407','18114','9','13','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1811408','18114','9','13','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Start Combat Movement Below 5 Yards'),
('1811409','18114','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1811410','18114','16','0','100','1','12550','1','15000','30000','11','12550','0','1','0','0','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Shield on Missing Buff'),
('1811411','18114','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Set Phase 3 at 15% HP'),
('1811412','18114','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Feralfen Mystic - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1811413','18114','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17957;
INSERT INTO `creature_ai_scripts` VALUES
('1795701','17957','4','0','100','6','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Coilfang Champion - Set Phase 1 on Aggro'),
('1795702','17957','9','5','100','7','0','5','5400','9600','11','16145','1','0','0','0','0','0','0','0','0','0','Coilfang Champion - Cast Sunder Armor (Phase 1)'),
-- ('1795703','17957','24','5','100','7','16145','5','5000','5000','22','2','0','0','0','0','0','0','0','0','0','0','Coilfang Champion - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
-- ('1795704','17957','28','3','100','7','16145','1','5000','5000','22','1','0','0','0','0','0','0','0','0','0','0','Coilfang Champion - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('1795705','17957','0','0','100','7','14200','24100','29000','29000','11','19134','4','0','0','0','0','0','0','0','0','0','Coilfang Champion - Cast Frightening Shout'),
('1795706','17957','0','0','100','7','4700','17900','10100','16200','11','15284','1','1','0','0','0','0','0','0','0','0','Coilfang Champion - Cast Cleave'),
('1795707','17957','7','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Coilfang Champion - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17465;
INSERT INTO `creature_ai_scripts` VALUES
('1746501','17465','4','0','100','6','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion - Set Phase 1 on Aggro'),
('1746502','17465','9','5','100','3','0','5','4000','5000','11','15572','1','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion (Normal) - Cast Sunder Armor (Phase 1)'),
('1746503','17465','9','5','100','5','0','5','4000','5000','11','16145','1','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion (Heroic) - Cast Sunder Armor (Phase 1)'),
-- ('1746504','17465','24','5','100','3','15572','5','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion (Normal) - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
-- ('1746505','17465','24','5','100','5','16145','5','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion (Heroic) - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
-- ('1746506','17465','28','3','100','3','15572','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion (Normal) - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
-- ('1746507','17465','28','3','100','5','16145','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion (Heroic) - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('1746508','17465','0','0','100','3','50','50','17000','21000','11','30931','0','1','0','0','0','0','0','0','0','0','Shattered Hand Centurion - Cast Battle Shout'),
('1746509','17465','7','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Shattered Hand Centurion - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16481;
INSERT INTO `creature_ai_scripts` VALUES
('1648101','16481','4','0','100','2','0','0','0','0','23','1','0','0','1','-9804','-9803','0','0','0','0','0','Ghastly Haunt - Set Phase 1 and Say on Aggro'),
('1648102','16481','9','5','100','3','0','5','9000','15000','11','29716','1','0','0','0','0','0','0','0','0','0','Ghastly Haunt - Cast Ethereal Curse (Phase 1)'),
-- ('1648103','16481','24','5','100','3','29716','5','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Ghastly Haunt - Set Phase 2 on Target Max Ethereal Curse Aura Stack (Phase 1)'),
-- ('1648104','16481','28','3','100','3','29716','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Ghastly Haunt - Set Phase 1 on Target Missing Ethereal Curse Aura Stack (Phase 2)'),
('1648105','16481','9','0','100','3','0','20','9000','14000','11','29712','4','0','0','0','0','0','0','0','0','0','Ghastly Haunt - Cast Shadow Shock'),
('1648106','16481','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Ghastly Haunt - Set Phase to 0 on Evade'),
('1648107','16481','6','0','100','2','0','0','0','0','1','-65','-66','0','0','0','0','0','0','0','0','0','Ghastly Haunt - Random Say on Death');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16179;
INSERT INTO `creature_ai_scripts` VALUES
('1617901','16179','1','0','100','0','0','0','0','0','11','22766','0','33','1','-9979','0','0','0','0','0','0','Hyakiss the Lurker - Cast Stealth and Emote on Spawn'),
('1617902','16179','4','0','100','0','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Set Phase 1 on Aggro'),
('1617903','16179','9','5','100','1','0','5','5000','10000','11','29901','1','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Cast Acidic Fang (Phase 1)'),
-- ('1617904','16179','24','5','100','1','29901','7','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Set Phase 2 on Target Max Acidic Fang Aura Stack (Phase 1)'),
-- ('1617905','16179','28','3','100','1','29901','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Set Phase 1 on Target Missing Acidic Fang Aura Stack (Phase 2)'),
('1617906','16179','9','0','100','1','0','40','6000','12000','11','29896','4','1','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Cast Hyakiss\' Web'),
('1617907','16179','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Hyakiss the Lurker - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16171;
INSERT INTO `creature_ai_scripts` VALUES
('1617101','16171','4','0','100','2','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Coldmist Widow - Set Phase 1 on Aggro'),
('1617102','16171','9','5','100','3','0','30','5000','9000','11','29293','1','0','0','0','0','0','0','0','0','0','Coldmist Widow - Cast Poison Volley (Phase 1)'),
-- ('1617103','16171','24','5','100','3','29293','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Coldmist Widow - Set Phase 2 on Target Max Poison Volley Aura Stack (Phase 1)'),
-- ('1617104','16171','28','3','100','3','29293','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Coldmist Widow - Set Phase 1 on Target Missing Poison Volley Aura Stack (Phase 2)'),
('1617105','16171','9','0','100','3','0','8','14000','20000','11','29292','0','1','0','0','0','0','0','0','0','0','Coldmist Widow - Cast Frost Mist'),
('1617106','16171','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Coldmist Widow - Set Phase to 0 on Evade');

-- King Gordok 11501
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 11501;
INSERT INTO `creature_ai_scripts` VALUES
('1150101','11501','4','0','100','2','0','0','0','0','1','-29','0','0','22','1','0','0','0','0','0','0','King Gordok - Say and Set Phase 1 on Aggro'),
('1150102','11501','9','5','100','3','0','5','7100','8500','11','15572','1','0','0','0','0','0','0','0','0','0','King Gordok - Cast Sunder Armor (Phase 1)'),
-- ('1150103','11501','24','5','100','3','15572','5','5000','5000','22','2','0','0','0','0','0','0','0','0','0','0','King Gordok - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
-- ('1150104','11501','28','3','100','3','15572','1','5000','5000','22','1','0','0','0','0','0','0','0','0','0','0','King Gordok - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('1150105','11501','0','0','100','2','7200','7200','18200','22800','11','22886','4','1','0','0','0','0','0','0','0','0','King Gordok - Cast Berserker Charge'),
('1150106','11501','0','0','100','3','5000','7000','9000','14000','11','15708','1','0','0','0','0','0','0','0','0','0','King Gordok - Cast Mortal Strike'),
('1150107','11501','0','0','100','3','12000','15000','17000','24000','11','16727','0','0','0','0','0','0','0','0','0','0','King Gordok - Cast War Stomp'),
('1150108','11501','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','King Gordok - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 10826;
INSERT INTO `creature_ai_scripts` VALUES
('1082601','10826','4','0','100','0','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Lord Darkscythe - Set Phase 1 on Aggro'),
('1082602','10826','9','5','100','1','0','5','5000','9000','11','11971','1','0','0','0','0','0','0','0','0','0','Lord Darkscythe - Cast Sunder Armor (Phase 1)'),
-- ('1082603','10826','24','5','100','1','11971','5','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Lord Darkscythe - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
-- ('1082604','10826','28','3','100','1','11971','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Lord Darkscythe - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('1082605','10826','0','0','100','1','3000','5000','6000','8000','11','15284','1','0','0','0','0','0','0','0','0','0','Lord Darkscythe - Cast Cleave'),
('1082606','10826','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Lord Darkscythe - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6224;
INSERT INTO `creature_ai_scripts` VALUES
('622401','6224','1','0','100','3','10000','45000','30000','70000','11','10348','0','1','0','0','0','0','0','0','0','0','Leprous Machinesmith - Cast Tune Up OOC'),
('622402','6224','1','0','100','2','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Leprous Machinesmith - Set Phase 1 on Spawn'),
('622404','6224','4','0','100','2','0','0','0','0','39','10','0','0','0','0','0','0','0','0','0','0','Leprous Machinesmith - Call for Help on Aggro'),
('622405','6224','9','5','100','3','8','30','1200','2500','11','13398','1','0','40','2','0','0','0','0','0','0','Leprous Machinesmith - Cast Throw Wrench and Set Ranged Weapon Model (Phase 1)'),
-- ('622406','6224','9','5','100','3','9','80','1000','1000','49','1','0','0','0','0','0','0','0','0','0','0','Leprous Machinesmith - Enable Dynamic Movement at 9-80 Yards (Phase 1)'),
-- ('622407','6224','9','0','100','3','0','8','1000','1000','49','0','0','0','20','1','0','0','40','1','0','0','Leprous Machinesmith - Disable Dynamic Movement and Enable Melee and Set Melee Weapon Model at 0-8 Yards'),
('622408','6224','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Leprous Machinesmith - Emote on Radiation Spellhit'),
('622409','6224','14','0','100','3','2000','15','28900','28900','11','10732','6','1','0','0','0','0','0','0','0','0','Leprous Machinesmith - Cast Supercharge on Mechanical Friendlies'),
('622410','6224','7','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Leprous Machinesmith - Set Phase 1 and Set Melee Weapon Model on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6222;
INSERT INTO `creature_ai_scripts` VALUES
('622201','6222','1','0','100','3','10000','45000','30000','70000','11','10348','0','1','0','0','0','0','0','0','0','0','Leprous Technician - Cast Tune Up OOC'),
('622202','6222','1','0','100','2','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Leprous Technician - Prevent Melee and Set Phase 1 on Spawn'),
('622204','6222','4','0','100','2','0','0','0','0','39','10','0','0','0','0','0','0','0','0','0','0','Leprous Technician - Call For Help on Aggro'),
('622205','6222','9','5','100','3','8','30','1200','2500','11','13398','1','0','40','2','0','0','0','0','0','0','Leprous Technician - Cast Throw Wrench and Set Ranged Weapon Model (Phase 1)'),
-- ('622206','6222','9','5','100','3','9','80','1000','1000','49','1','0','0','0','0','0','0','0','0','0','0','Leprous Technician - Enable Dynamic Movement at 9-80 Yards (Phase 1)'),
-- ('622207','6222','9','0','100','3','0','8','1000','1000','49','0','0','0','20','1','0','0','40','1','0','0','Leprous Technician - Disable Dynamic Movement and Enable Melee and Set Melee Weapon Model at 0-8 Yards'),
('622208','6222','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Leprous Technician - Emote on Radiation Spellhit'),
('622209','6222','14','0','100','3','2000','15','28900','28900','11','10732','6','1','0','0','0','0','0','0','0','0','Leprous Technician - Cast Supercharge on Mechanical Friendlies'),
('622210','6222','7','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Leprous Technician - Set Phase 1 and Set Melee Weapon Model on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6228;
INSERT INTO `creature_ai_scripts` VALUES
('622801','6228','1','0','100','3','1000','1000','1800000','1800000','11','12544','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Cast Frost Armor on Spawn'),
('622802','6228','9','5','100','3','0','40','2400','3800','11','9053','1','0','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Cast Fireball (Phase 1)'),
('622803','6228','0','0','100','3','6000','11000','60000','65000','11','184','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambasadror - Cast Fire Shield II'),
('622804','6228','0','0','100','2','2000','2000','0','0','11','10870','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Summon Burning Servant'),
('622805','6228','0','0','100','2','3000','3000','0','0','11','10870','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Summon Burning Servant'),
('622806','6228','16','0','100','3','12544','1','15000','30000','11','12544','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Cast Frost Armor on Missing Buff'),
('622807','6228','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Emote on Radiation Spellhit');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6206;
INSERT INTO `creature_ai_scripts` VALUES
('620601','6206','4','0','100','2','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase 1 on Aggro'),
('620602','6206','0','0','100','3','1100','4800','182900','184500','11','7164','0','1','0','0','0','0','0','0','0','0','Caverndeep Burrower - Cast Defensive Stance'),
('620603','6206','9','5','100','3','0','5','6100','9700','11','7405','1','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Cast Sunder Armor (Phase 1)'),
-- ('620604','6206','24','5','100','3','7405','5','5000','5000','22','2','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
-- ('620605','6206','28','3','100','3','7405','1','5000','5000','22','1','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('620606','6206','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Emote on Radiation Spellhit'),
('620607','6206','2','0','100','2','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Caverndeep Burrower - Flee at 15% HP'),
('620608','6206','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6138;
INSERT INTO `creature_ai_scripts` VALUES
('613801','6138','1','0','100','1','1000','1000','600000','600000','11','12550','0','0','0','0','0','0','0','0','0','0','Arkkoran Oracle - Cast Lightning Shield OCC'),
('613802','6138','9','0','100','1','0','20','6000','9000','11','11824','1','0','0','0','0','0','0','0','0','0','Arkkoran Oracle - Cast Shock'),
('613803','6138','16','0','100','1','12550','1','15000','30000','11','12550','0','33','0','0','0','0','0','0','0','0','Arkkoran Oracle - Cast Lightning Shield on Missing Buff'),
('613804','6138','14','0','100','1','1500','40','16000','21000','11','11986','6','1','0','0','0','0','0','0','0','0','Arkkoran Oracle - Cast Healing Wave on Friendlies'),
('613805','6138','2','0','100','0','75','0','0','0','11','11986','0','1','0','0','0','0','0','0','0','0','Arkkoran Oracle - Cast Healing Wave on Self on 75% HP'),
('613806','6138','2','0','100','0','25','0','0','0','11','11986','0','1','0','0','0','0','0','0','0','0','Arkkoran Oracle - Cast Healing Wave on Self on 75% HP');

-- Defias Pillager
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 589;
INSERT INTO `creature_ai_scripts` VALUES
('58901','589','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Defias Pillager - Prevent Combat Movement on Spawn'),
('58902','589','1','0','100','1','1000','1000','1800000','1800000','11','12544','0','32','0','0','0','0','0','0','0','0','Defias Pillager - Cast Frost Armor on Spawn'),
('58903','589','4','0','15','0','0','0','0','0','1','-2','-2','-4','0','0','0','0','0','0','0','0','Defias Pillager - Random Aggro Say'),
('58904','589','4','0','100','0','0','0','0','0','11','20793','1','0','23','1','0','0','0','0','0','0','Defias Pillager - Cast Fireball and Set Phase 1 on Aggro'),
('58905','589','9','13','100','1','0','40','3000','5000','11','20793','1','0','0','0','0','0','0','0','0','0','Defias Pillager - Cast Fireball (Phase 1)'),
('58906','589','3','13','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Defias Pillager - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('58907','589','9','13','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Defias Pillager - Start Combat Movement at 35 Yards (Phase 1)'),
('58908','589','9','13','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Defias Pillager - Prevent Combat Movement at 15 Yards (Phase 1)'),
('58909','589','9','13','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Defias Pillager - Start Combat Movement Below 5 Yards'),
('58910','589','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Defias Pillager - Set Phase 1 when Mana is above 30% (Phase 2)'),
('58911','589','16','0','100','1','12544','1','15000','30000','11','12544','0','1','0','0','0','0','0','0','0','0','Defias Pillager - Cast Frost Armor on Missing Buff'),
('58912','589','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Defias Pillager - Set Phase 3 at 15% HP'),
('58913','589','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Defias Pillager - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('58914','589','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Defias Pillager - Set Phase to 0 on Evade');

DELETE FROM `npc_vendor` WHERE `entry` = 1000010;
DELETE FROM `npc_vendor` WHERE `entry` = 1200051 AND `item` = 29895;
DELETE FROM `creature_template` WHERE `entry` = 0;

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (23578,89322);
INSERT INTO `creature_formations` VALUES
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

DELETE FROM `npc_vendor` WHERE `entry` IN (12781,12793) AND `item` IN (32227,32228,32229,32230,32231,32249);

-- Lhara <Darkmoon Faire Exotic Goods>
UPDATE `creature_template` SET `npcflag`='129' WHERE `entry` = 14846; -- 129

-- Professor Thaddeus Paleo <Darkmoon Faire Cards & Exotic Goods>
UPDATE `creature_template` SET `npcflag`='131' WHERE `entry` = 14847; -- 131


DELETE FROM `creature_formations` WHERE `leaderguid` IN (30816,68001,113952,114153,320869,16779010);
DELETE FROM `creature_formations` WHERE `memberguid` IN (32794,59476,52355,52356,178782);

DELETE FROM `creature` WHERE `guid` = 134711;
INSERT INTO `creature` VALUES (134711, 17670, 540, 3, 0, 0, 518.815, 171.06, 1.94158, 3.09919, 7200, 0, 0, 20259, 0, 0, 0);


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


DELETE FROM `creature_questrelation` WHERE `id` = 12042 AND `quest` = 10955;
INSERT INTO `creature_questrelation` VALUES (12042, 10955);


-- http://www.wowhead.com/quest=10704/how-to-break-into-the-arcatraz
UPDATE `quest_template` SET `MinLevel` = 67 WHERE `entry` = 10704;

UPDATE `creature_ai_scripts` SET `action1_param2` = -9910 WHERE `id` = 1999304;

UPDATE `gameobject` SET `spawntimesecs`= 900,`animprogress`= 100 WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881,185915,185600) AND `map`= 530; -- 2700

UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';

DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9699 AND -9600;
INSERT INTO `creature_ai_texts` VALUES
(-9600,'Destroy them! Destroy them all!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, '11980'),
(-9601,'Indeed, the time has come to end this charade.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, '11980'),
(-9602,'Foolish mortals. Did you think that I would not strike you down for your transgressions?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, 0, '11980'),
(-9603,'Come, mortals, face the lord of fire!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'-174 21181'),
(-9604,'You will suffer eternally!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'-175 21181'),
(-9605,'Little creature made of flesh, your wish is granted! Death comes for you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'-176 21181');
-- (-9606,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21181;
INSERT INTO `creature_ai_scripts` VALUES
('2118101','21181','1','0','100','0','0','0','0','0','11','36329','0','0','1','-9603','-9604','0','0','0','0','0','Cyrukh the Firelord - Cast Cyrukh Fire Kit and Text on Spawn'),
('2118102','21181','4','0','100','0','0','0','0','0','1','-9605','0','0','0','0','0','0','0','0','0','0','Cyrukh the Firelord - Yell on Aggro'),
('2118103','21181','9','0','100','1','0','30','12000','19000','11','39429','4','0','0','0','0','0','0','0','0','0','Cyrukh the Firelord - Cast Fel Flamestrike'),
('2118104','21181','9','0','100','1','0','5','6000','12000','11','18945','1','0','0','0','0','0','0','0','0','0','Cyrukh the Firelord - Cast Knock Away'),
('2118105','21181','0','0','100','1','8000','13000','8000','13000','11','39425','0','0','0','0','0','0','0','0','0','0','Cyrukh the Firelord - Cast Trample'),
('2118106','21181','6','0','100','0','0','0','0','0','11','37235','0','2','0','0','0','0','0','0','0','0','Cyrukh the Firelord - Cast Cyrukh Defeated on Death'),
('2118107','21181','1','0','100','1','15000','15000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Cyrukh the Firelord - Forced Despawn OOC');

UPDATE `creature_ai_scripts` SET `action1_type` = 103 WHERE `id` = 2086915;
UPDATE `creature_ai_scripts` SET `event_param1` = 70, `event_param2` = 0 WHERE `id` IN (2021112,2016111);
UPDATE `creature_ai_scripts` SET `event_param3` = 120000, `event_param4` = 150000 WHERE `id` = 2016112;
DELETE FROM `creature_ai_texts` WHERE `entry` = -9711;
INSERT INTO `creature_ai_texts` VALUES (-9711,'\'s hand begins to glow with Arcane energy.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'20041 on Overcharged Arcane Explosion Spellcast');
UPDATE `creature_ai_scripts` SET `event_param3` = 3000, `event_param4` = 15000 WHERE `id` = 1869351;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18693;
INSERT INTO `creature_ai_scripts` VALUES
(1869301, 18693, 1, 0, 100, 1, 1000, 5000, 300000, 600000, 1, -18000, -18001, -18002, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Text OOC'),
(1869302, 18693, 4, 0, 100, 0, 0, 0, 0, 0, 1, -18003, -18004, -18005, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Text on Aggro'),
(1869303, 18693, 4, 0, 100, 0, 0, 0, 0, 0, 11, 15497, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Cast Frostbolt on Aggro'),
(1869304, 18693, 8, 0, 100, 1, 0, 4, 3000, 15000, 11, 37844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Cast Fire Ward on Fire Spellhit'),
(1869305, 18693, 0, 0, 100, 1, 4000, 6000, 2000, 3000, 11, 15241, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Cast Scorch'),
(1869306, 18693, 0, 0, 100, 1, 8000, 10000, 5500, 11000, 11, 12466, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Speaker Mar\'grom - Cast Fireball');

UPDATE `creature_ai_scripts` SET `event_param1` = 50, `event_param2` = 0 WHERE `id` IN (1811810);
UPDATE `creature_ai_scripts` SET `event_param1` = 30, `event_param2` = 0 WHERE `id` IN (1811811);
UPDATE `creature_ai_scripts` SET `event_param1` = 15, `event_param2` = 0 WHERE `id` IN (1652303,1652304);
UPDATE `creature_ai_scripts` SET `event_param3` = 8000 WHERE `id` = 1645907;
UPDATE `creature_ai_scripts` SET `action2_param2` = 0 WHERE `id` = 1688005;
UPDATE `creature_ai_scripts` SET `action1_param1` = 0 WHERE `id` IN (72636, 72637);
UPDATE `creature_ai_texts` SET `emote` = 0 WHERE `entry` IN (-32,-33);
UPDATE `creature_ai_texts` SET `sound` = 0 WHERE `entry` IN (-628,-629,-630,-631,-632,-633);

-- Lady Vashj 21212
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 21212 AND `item` = 50031; -- 3
-- Leotheras the Blind 21215
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 21215 AND `item` = 34059; -- 3
-- Fathom-Lord Karathress 21214
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 21214 AND `item` = 34060; -- 3
-- Void Reaver 19516
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 19516 AND `item` = 34054; -- 3
-- Kael'thas Sunstrider 19622
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 19622 AND `item` = 50032; -- 3
-- High King Maulgar 18831
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 18831 AND `item` = 34050; -- 3
-- Gruul the Dragonkiller 19044
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 19044 AND `item` = 190039; -- 3
-- Magtheridon 17257
UPDATE `creature_loot_template` SET `maxcount` = 2 WHERE `entry` = 17257 AND `item` = 34039; -- 3

