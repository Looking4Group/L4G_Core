-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/717
-- No birds are spawning from Kaliri nests, missing nest spawns, static bird spawns that shouldn't be there.
-- ----------------------------------------------------------
 
-- The spell "Break Kaliri Egg" (http://db.looking4group.eu/?spell=29395) doesn't work, so I'm going to do this with an invisible trigger instead.
 
DELETE FROM `creature_template` WHERE `entry` IN ('1000012');
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(1000012, 0, 17519, 11686, 17519, 11686, 'Invisible Kaliri Spawner', 61, 61, 112, 112, 0, 0, 20, 114, 114, 0, 0.91, 1, 0, 0, 0, 0, 0, 2000, 0, 33587968, 0, 0, 0, 0, 0, 0, 1.76, 2.42, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 0, 1, 0, 0, 128, '');
 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (1000012);
INSERT INTO `creature_ai_scripts` VALUES
(100001201, 1000012, 11, 0, 20, 0, 0, 0, 0, 0, 12, 17034, 1, 100000, 41, 0, 0, 0, 0, 0, 0, 0, 'Invisible Kaliri Spawner - Summon Female Kaliri, then despawn self'), -- 1/5 chance of getting a female
(100001202, 1000012, 1, 0, 100, 0, 0, 100, 0, 0, 12, 17039, 1, 100000, 41, 0, 0, 0, 0, 0, 0, 0, 'Invisible Kaliri Spawner - Summon Male Kaliri, then despawn self'); -- If no female, spawn a male instead
 
UPDATE `gameobject_template` SET `type`=3, `data0`=43, `data3`=0, `data10`=0, `data14`=0 WHERE  `entry`=181582;
 
-- Add missing nest spawns
DELETE FROM `gameobject` WHERE `guid` BETWEEN 21923 AND 21925;
INSERT INTO `gameobject` VALUES
(21923,181582,530,1,-1138.567871,4243.345215,14.137020,0,0,0,0,0,181,100,1),
(21924,181582,530,1,-1152.503906,4263.899414,13.958394,0,0,0,0,0,181,100,1),
(21925,181582,530,1,-1141.335938,4213.396484,51.825722,0,0,0,0,0,181,100,1);
 
-- Make the trigger spawn from any of the nests
DELETE FROM `gameobject_scripts` WHERE id BETWEEN 21923 AND 21925;
DELETE FROM `gameobject_scripts` WHERE id BETWEEN 21931 AND 21940;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21923, 0, 10, 1000012, 180000, -1138.56, 4243.34, 14.137);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21924, 0, 10, 1000012, 180000, -1152.50, 4263.89, 13.958);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21925, 0, 10, 1000012, 180000, -1141.33, 4213.39, 51.82);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21931, 0, 10, 1000012, 180000, -1332.26, 4061.72, 116.778);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21932, 0, 10, 1000012, 180000, -1324.8, 4040.57, 116.778);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21933, 0, 10, 1000012, 180000, -1167.66, 4214.58, 49.9546);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21934, 0, 10, 1000012, 180000, -1200.16, 4116.68, 61.3052);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21935, 0, 10, 1000012, 180000, -1108.96, 4175.83, 40.9417);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21936, 0, 10, 1000012, 180000, -1114.93, 4184.79, 17.7944);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21937, 0, 10, 1000012, 180000, -1102.93, 4210.66, 55.6402);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21938, 0, 10, 1000012, 180000, -1099.27, 4252.83, 16.6227);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21939, 0, 10, 1000012, 180000, -1076.14, 4176.77, 38.1325);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21940, 0, 10, 1000012, 180000, -982.999, 4230.92, 42.0996);
 
-- Remove static spawns of Kaliri birds. They should not exist.
DELETE FROM `creature` WHERE `id` IN (17039,17034);
