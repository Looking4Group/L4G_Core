-- Evidence Marker
UPDATE `creature_template` SET `modelid_A`='1126',`modelid_H`='1126',`unit_flags`='0',`type_flags`='1024',`AIName`='EventAI',`flags_extra`='128' WHERE `entry` = '23583'; -- 17188 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23583';
INSERT INTO `creature_ai_scripts` VALUES
(2358301,23583,1,0,100,1,0,0,0,0,11,42171,0,39,0,0,0,0,0,0,0,0,'Evidence Marker - Mark on Spawn');
UPDATE `creature_template_addon` SET `auras` = '' WHERE `entry` = 23583; -- 42175 0

-- Skeletal Gryphon
UPDATE `creature_template` SET `InhabitType` = '4', `unit_flags` = '33554432' WHERE `entry` = 17660;
DELETE FROM `creature_template_addon` WHERE `entry` = 17660;
INSERT INTO `creature_template_addon` VALUES (17660,0,0,16908544,0,4097,0,0,NULL);

UPDATE `creature` SET `position_x`='-4155.7739', `position_y`='385.0739', `position_z`='141.5365', `orientation`='1.3100',`spawndist`='0',`movementtype`='0' WHERE `guid` = 75786;

-- Tortured Drake 13976
UPDATE `creature` SET `DeathState` = 1 WHERE `id` = 13976;
UPDATE `creature_template` SET `unit_flags` = 33554432 WHERE `entry` = 13976;

-- World Invisible Trigger 12999
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 12999;

-- Blackwing Spell Marker 16604
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 16604;

DELETE FROM `creature` WHERE `guid` IN (85805,85802,85799,85797,85788,85793,84528,84526,84531,84627,84598,84521,84519,84524,84525,85775,85773,85772,84628,84634,84635,84602,84603,84623,84619,84618,84617,84616,84692,84691,85616,85613,85612,85611,85609,85601,85620,85621,85776,85777,85757,85760,85764,84520,84527,84529,84522,84523,84530,84532,85798,84547,84549,84549,84550,84551,84552,84554,84555,84556,84567,84566,84565,84563,84562,84562,84571,85808,85808,84592,84557,84590,84589,84387,84639,84650,84648,85768,85767,85766,85758,85778,85622,85623,85625,85581,84624,84615,84614,84606,84605,84601,84599,84654,84655,84688,84689,84762,84761,84760,84759,84652,84533,84534,84535,84536,84537,84538,84539,84540,84541,84542,84543,84544,84545,84546,84547,84548,84549,84553,84559,84564,84568,84569,84570,84572,84573);

-- MH Pre
DELETE FROM `creature_questrelation` WHERE `quest` = 10445;
INSERT INTO `creature_questrelation` VALUES (19935, 10445);

-- Infernal Target 17644
UPDATE `creature_template` SET `unit_flags`=33554434 WHERE `entry` = 17644;

-- Infernal Relay 17645
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 17645;

UPDATE `creature` SET `movementtype`= 0 WHERE `guid` IN (57098,57130);

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (85345,103661);
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES (85345, 135476);
INSERT INTO `creature_linked_respawn` (`guid`, `linkedGuid`) VALUES (103661, 135476);

-- Lightsworn Elekk Rider 22966
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`minhealth`='4299',`maxhealth`='4299',`armor`='6492',`mindmg`='96',`maxdmg`='195',`unit_flags`='32768',`AIName`='EventAI',`mechanic_immune_mask`='65536' WHERE `entry` = 22966;
DELETE FROM `creature_template_addon` WHERE `entry` = 22966;
 INSERT INTO `creature_template_addon` VALUES
(22966,0,19872,16777472,0,4097,0,0,'');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22966;
INSERT INTO `creature_ai_scripts` VALUES
('2296602','22966','6','0','100','0','0','0','0','0','11','39782','1','7','0','0','0','0','0','0','0','0','Lightsworn Elekk Rider - Summon Lightsworn Elekk on Death');

-- Light-Armored Elekk 22968
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`minhealth`='4192',`maxhealth`='4192',`armor`='6792',`faction_A`='1854',`faction_H`='1854',`mindmg`='60',`maxdmg`='123',`unit_flags`='32768',`AIName`='EventAI'  WHERE `entry` = '22968';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22968;
INSERT INTO `creature_ai_scripts` VALUES
('2296801','22968','1','0','100','0','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Light-Armored Elekk - Despawn OOC');

DELETE FROM `creature_formations` WHERE `leaderguid` = 132967;
INSERT INTO `creature_formations` VALUES
(132967,132967,100,360,2),
(132967,132969,8,5.5,2),
(132967,132965,4,5.5,2),
(132967,132966,8,0.7,2),
(132967,132968,4,0.7,2);

SET @GUID := 74235;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (74235, 1, -3925.4458, 441.3823, 104.0319, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (74235, 2, -3923.83, 441.34, 104.029, 10000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (74235, 3, -3871.6499, 436.5169, 104.0801, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (74235, 4, -3797.6325, 436.2568, 104.0972, 5000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (74235, 5, -3871.6499, 436.5169, 104.0801, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (74235, 6, -3890.6047, 474.3337, 104.0476, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (74235, 7, -3920.0148, 473.8088, 104.2548, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (74235, 8, -3919.0456, 442.1552, 104.4862, 0, 0, 0, 100, 0);

-- Boss Portal: Purple (3.00) 24925
UPDATE `creature_template` SET `modelid_A`='22742',`modelid_H`='22742',`modelid_A2`='0',`modelid_H2`='0' WHERE `entry` = 24925;

UPDATE `creature` SET `position_x`='-3271.0639', `position_y`='338.5537', `position_z`='119.7490' WHERE `guid` = 77484;

-- Netherwing Drake Escape Point 23225
UPDATE `creature_template` SET `InhabitType` = 7, `flags_extra` = 130 WHERE `entry` = 23225; -- 3 2

-- Monster Generator (Blackwing) 12434
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 12434;

-- Skyguard Prisoner 23383
UPDATE `creature_template` SET `unit_flags` = 33089 WHERE `entry` = 23383;

UPDATE `creature` SET `MovementType`='2' WHERE `guid` = 75654;
