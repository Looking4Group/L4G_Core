-- -----------------------------------
-- Saltgurka Update 14
-- -----------------------------------
 
-- Manna biscuits can now be eaten by hunter pets
UPDATE `item_template` SET `foodtype`=4 WHERE `entry`=34062;
 
-- Hemorrhage no longer procs on non-physical spells.
DELETE FROM `spell_proc_event` WHERE `entry` IN (16511,17347,17348,26864);
INSERT INTO `spell_proc_event` (`entry`,`SpellFamilyName`,`procFlags`) VALUES
(16511,8,0x000222A8),
(17347,8,0x000222A8),
(17348,8,0x000222A8),
(26864,8,0x000222A8);
 
 
-- Rampage. First proc is on melee crit only, all following procs are on both melee normal and melee crit hits.
UPDATE `spell_proc_event` SET `procEx`=3 WHERE `entry` IN (29801,30030,30033);
-- Fix exploit that allowed you to cancel the stacking aura, but that didn't remove the invisible aura, which mean you would start stacking again without having to pay 20 Rage to activate it.
-- This exploit allowed the buff to last double as long if you did it at the right moment.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`='-30032';
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES ('-30032', '-30033', 'Remove Warrior Rampage trigger if player cancels the Stacking Aura.');

-- Tyrantus 20931
SET @GUID := 86748;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (86748, 20931, 530, 1, 0, 0, 5050.57, 2896.73, 83.7779, 0.130239, 160, 0, 0, 9335, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (86748, 1, 5116.44, 2905.53, 77.0648, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 2, 5133.4, 2909.44, 72.4063, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 3, 5183.69, 2891.85, 54.6853, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 4, 5192.38, 2910.73, 58.1054, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 5, 5180.38, 2916.19, 64.381, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 6, 5146.01, 2941.57, 74.6116, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 7, 5139.39, 2946.47, 71.6427, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 8, 5121.76, 2930.02, 78.2033, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 9, 5090.15, 2937.53, 83.9492, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 10, 5049.37, 2951.28, 87.6848, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 11, 5044.55, 2913.1, 88.6466, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 12, 5050.4, 2896.25, 83.7468, 0, 0, 0, 0, 0);
