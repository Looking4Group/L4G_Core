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
