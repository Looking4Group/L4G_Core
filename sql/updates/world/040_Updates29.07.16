-- Syth Fire Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance2`='-1' WHERE `entry` IN ('19203');
UPDATE `creature_template` SET `resistance2`='-1' WHERE `entry` IN ('20703');
--
-- Syth Frost Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance4`='-1' WHERE `entry` IN ('19204');
UPDATE `creature_template` SET `resistance4`='-1' WHERE `entry` IN ('20704');
--
-- Syth Arcane Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance6`='-1' WHERE `entry` IN ('19205');
UPDATE `creature_template` SET `minhealth`='5903',`maxhealth`='5903',`resistance6`='-1' WHERE `entry` IN ('20702');
--
-- Syth Shadow Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance5`='-1' WHERE `entry` IN ('19206');
UPDATE `creature_template` SET `resistance5`='-1' WHERE `entry` IN ('20705');
--
DELETE FROM `creature_template_addon` WHERE `entry` IN (19203,19204,19205,19206); 

-- Warchief Kargath Bladefist 16808,20597
-- 2 guids 3666851 5274944 npc flag 2 ? y
UPDATE  `creature` SET `spawnmask`='3',`spawntimesecs`='43200' WHERE `guid` IN ('5274944');
UPDATE `creature_template` SET `mindmg`='1807',`maxdmg`='2382' WHERE `entry` IN ('16808'); -- 550 1125
UPDATE `creature_template` SET `mindmg`='6121',`maxdmg`='6446',`pickpocketloot`='16808' WHERE `entry` IN (20597); -- 7141 7521 -- 10,711 - 11,281

-- Eye of Honor Hold
UPDATE `creature_template` SET `InhabitType`='5',`unit_flags`='768' WHERE `entry` = '16887';

-- Murmur Loottable 2 Items in Heroic
UPDATE `creature_loot_template` SET `groupid`='1',`ChanceOrQuestChance`='30' WHERE `entry` IN ('20657') AND `item` IN ('50006'); -- 0 66 
UPDATE `creature_loot_template` SET `mincountOrRef`='2' WHERE `entry` IN ('20657') AND `item` IN ('28558'); -- 1
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='5' WHERE `entry` IN ('20657') AND `item` IN ('24309'); -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='1' WHERE `entry` IN ('20657') AND `item` IN ('31882','31892','31901','31910'); -- 0
UPDATE `reference_loot_template` SET `groupid`='2' WHERE `entry` = '50006';
UPDATE `creature_loot_template` SET `groupid`='1' WHERE `entry` = '20657' AND `item` = '35002';
UPDATE `creature_loot_template` SET `groupid`='2' WHERE `entry` = '20657' AND `item` = '50006';

-- not be killed by rogues
-- Captain Boneshatter
UPDATE `creature_template` SET `faction_A`='1729',`faction_H`='1729' WHERE `entry` ='17296'; -- 1668

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16905');
INSERT INTO `creature_ai_scripts` VALUES
('1690501','16905','1','0','100','0','0','0','0','0','21','1','0','0','22','1','0','0','0','0','0','0','Unyielding Sorcerer - Prevent Combat Movement and Set Phase 1 on OOC'),
('1690502','16905','4','0','100','0','0','0','0','0','11','9053','1','0','22','1','0','0','0','0','0','0','Unyielding Sorcerer - Cast Fireball and Set Phase 1 on Aggro'),
('1690503','16905','9','13','100','1','0','40','3000','3800','11','9053','1','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Cast Fireball (Phase 1)'),
('1690504','16905','3','13','100','0','15','0','0','0','21','1','0','0','22','2','0','0','0','0','0','0','Unyielding Sorcerer - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1690505','16905','9','13','100','1','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Start Combat Movement at 35 Yards (Phase 1)'),
('1690506','16905','9','13','100','1','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1690507','16905','9','13','100','1','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Start Combat Movement Below 5 Yards'),
('1690508','16905','0','13','100','1','5000','9000','12000','15000','11','11829','1','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Cast Flamestrike (Phase 1)'),
('1690509','16905','9','0','100','0','0','5','0','0','29','10','150','0','11','11831','0','1','0','0','0','0','Unyielding Sorcerer - Ranged Movement at 5 Yards to Avoid Melee Combat'),
('1690510','16905','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1690511','16905','2','0','100','0','15','0','0','0','11','11831','0','1','22','3','0','0','0','0','0','0','Unyielding Sorcerer - Cast Frost Nova and Set Phase 3 at 15% HP'),
('1690512','16905','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Unyielding Sorcerer - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1690513','16905','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Set Phase to 0 on Evade');

-- eyes of Eye of Grillok movement
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

-- Bleeding Hollow Tormentor 19424
UPDATE `creature_addon` SET `mount`='9562' WHERE `guid` IN ('69478');
UPDATE `creature_template_addon` SET `mount`='9562' WHERE `entry` IN ('19424');
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('19424');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19424');
INSERT INTO `creature_ai_scripts` VALUES
(1942401,19424,0,0,100,1,4000,8000,12000,18000,11,12542,1,33,0,0,0,0,0,0,0,0,'Bleeding Hollow Tormentor - Cast Fear'), -- 33924
(1942402,19424,4,0,100,1,0,0,0,0,11,34368,0,0,17,154,0,0,19,134217728,0,0,'Bleeding Hollow Tormentor - Summon Bleeding Hollow Riding Worg and Dismount on Aggro'),
(1942403,19424,0,0,100,1,100,100,0,0,39,10,0,0,0,0,0,0,0,0,0,0,'Bleeding Hollow Tormentor - Call for Help'),
(1942404,19424,2,0,100,1,15,0,0,0,11,31553,1,0,1,-47,0,0,25,0,0,0,'Bleeding Hollow Tormentor - Casts Hamstring and Flee at 15% HP'),
(1942406,19424,7,0,100,1,0,0,0,0,43,9562,0,0,0,0,0,0,0,0,0,0,'Bleeding Hollow Tormentor - Mount on Evade'),
(1942407,19424,12,0,100,1,99,0,0,0,11,34368,0,0,0,0,0,0,0,0,0,0,'Bleeding Hollow Tormentor - Summon Bleeding Hollow Riding Worg on Target HP');

-- Razorsaw
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('20798');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20798');
INSERT INTO `creature_ai_scripts` VALUES
(2079801,20798,4,0,100,0,0,0,0,0,11,32735,1,0,0,0,0,0,0,0,0,0,'Razorsaw - Casts Saw Blade'),
(2079802,20798,0,0,100,1,8000,8000,15000,15000,11,36486,0,0,0,0,0,0,0,0,0,0,'Razorsaw  - Casts Slime Spray');
SET @GUID := 73465;
SET @PATH := @GUID * 10;  
SET @POINT := '0';
UPDATE `creature` SET `position_x`='415.9948', `position_y`='2215.928', `position_z`='116.7331', `orientation`='2.310609', `MovementType`='2' WHERE `id`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@PATH,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH, @POINT := @POINT + '1', '402.9154', '2230.259', '117.4614', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '380.9025', '2232.046', '120.3028', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '373.8445', '2224.211', '119.6789', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '363.3306', '2208.840', '118.7775', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '377.8707', '2195.009', '118.3487', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '390.5488', '2186.308', '118.5270', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '389.7958', '2173.775', '118.2608', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '374.9228', '2168.000', '119.9206', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '362.8960', '2160.521', '119.6764', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '364.5011', '2147.048', '119.6321', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '371.8427', '2134.787', '119.0569', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '383.2012', '2131.624', '118.7750', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '400.1353', '2126.392', '116.0313', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '416.6149', '2139.431', '116.4313', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '444.4109', '2150.578', '116.9998', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '454.7191', '2161.122', '118.8741', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '439.4698', '2203.118', '116.4050', '0', '0', '0', '100', '0'),
(@PATH, @POINT := @POINT + '1', '420.8893', '2226.885', '116.4050', '0', '0', '0', '100', '0');

DELETE FROM `creature_formations` WHERE `memberguid` IN ('85702','85701','85697');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('85702', '85702', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('85702', '85701', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('85702', '85697', '60', '360', '2');

-- Tavarok 18343,20268
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='787447807' WHERE `entry` IN ('18343');
UPDATE `creature_template` SET `speed`='1.48',`unit_flags`='64',`mechanic_immune_mask`='787447807',`mindmg`='5800',`maxdmg`='6200',`dynamicflags`='8' WHERE `entry` IN ('20268'); -- 5768 6851

-- ZA Quest
DELETE FROM `creature_questrelation` WHERE `quest` IN ('11130','11164');
-- INSERT INTO `creature_questrelation` VALUES
-- (19227,11130),
-- (23761,11164);

-- Remove auras which are already in ACID 3.0.2 and dont need to be moved to EAI Dublicate auras 
DELETE FROM `creature_template_addon` WHERE `entry` IN (881,1260,1729,1732,2018,2588,2731,4299,4303,4805,6221,7843,8567,12902,16175,16844,16857,16873,17143,17147,18077,18121,18450,18453,18464,18465,18637,18640,19411,19415,19457,19732,19952,20115,20886,21242,21380,23285);
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (881, 0, 0, 67584, 0, 4097, 0, 0, '12544 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (1260, 0, 0, 512, 0, 4097, 0, 0, '465 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (1729, 0, 0, 2048, 0, 4097, 0, 0, '12544 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (1732, 0, 0, 2048, 0, 4097, 0, 0, '12544 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (2018, 0, 0, 67584, 0, 4097, 0, 0, '12544 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (4299, 0, 0, 66048, 0, 4097, 0, 0, '1006 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (4303, 0, 0, 512, 8, 4097, 0, 0, '1006 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (4805, 0, 0, 66048, 0, 4097, 0, 0, '12544 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (6221, 0, 0, 16777728, 1114112, 4097, 0, 0, '7165 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (7843, 0, 0, 16777728, 1114112, 4097, 0, 0, '7165 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (8567, 0, 0, 16908544, 0, 4097, 0, 0, '12627 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (12902, 0, 0, 512, 0, 4097, 0, 0, '12550 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (16175, 0, 0, 16908544, 0, 4097, 0, 0, '32429 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (16844, 0, 0, 0, 0, 0, 0, 0, '29147 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (16857, 0, 0, 0, 0, 0, 0, 0, '29147 0 37751 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (16873, 0, 0, 512, 0, 4097, 0, 0, '12550 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (17143, 0, 0, 512, 0, 4097, 0, 0, '12550 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (17147, 0, 0, 512, 0, 4097, 0, 0, '16592 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18077, 0, 0, 512, 0, 4097, 0, 0, '12550 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18121, 0, 0, 512, 0, 4097, 0, 0, '35194 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18450, 0, 0, 131584, 0, 4097, 0, 0, '32924 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18453, 0, 0, 131584, 0, 4097, 0, 0, '32924 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18464, 0, 0, 131584, 0, 4097, 0, 0, '32942 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18465, 0, 0, 16908544, 0, 4097, 0, 0, '32942 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18637, 0, 0, 512, 0, 4097, 0, 0, '16592 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (18640, 0, 0, 512, 0, 4097, 0, 0, '13787 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (19411, 0, 0, 512, 0, 4097, 0, 0, '13787 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (19415, 0, 0, 512, 0, 4097, 0, 0, '13864 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (19457, 0, 0, 512, 0, 4097, 0, 0, '12550 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (19732, 0, 0, 2048, 0, 4097, 0, 0, '13787 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (19952, 0, 0, 512, 0, 4097, 0, 0, '12544 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (20115, 0, 0, 512, 0, 4097, 0, 0, '34871 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (20886, 0, 0, 16777472, 0, 4097, 0, 0, '39007 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (21242, 0, 0, 512, 0, 4097, 0, 0, '13787 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (21380, 0, 0, 0, 0, 0, 0, 0, '29147 0');
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (23285, 0, 0, 0, 0, 0, 0, 0, '29147 0 37751 0');
UPDATE `creature_template_addon` SET `bytes1`='0',`auras`='29147 0 37751 0' WHERE `entry` = '21849'; -- 9

-- Crust Burster 16844
UPDATE `creature` SET `spawndist`='5',`movementtype`='1' WHERE `id` = '16844';

UPDATE `creature_template_addon` SET `bytes0`='0' WHERE `entry` = '16905'; -- 512
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16905');
INSERT INTO `creature_ai_scripts` VALUES
('1690501','16905','1','0','100','0','0','0','0','0','21','1','0','0','22','1','0','0','0','0','0','0','Unyielding Sorcerer - Prevent Combat Movement and Set Phase 1 on OOC'),
('1690502','16905','4','0','100','0','0','0','0','0','11','9053','1','0','22','1','0','0','0','0','0','0','Unyielding Sorcerer - Cast Fireball and Set Phase 1 on Aggro'),
('1690503','16905','9','13','100','1','0','40','3000','3800','11','9053','1','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Cast Fireball (Phase 1)'),
('1690504','16905','3','13','100','0','15','0','0','0','21','1','0','0','22','2','0','0','0','0','0','0','Unyielding Sorcerer - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1690505','16905','9','13','100','1','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Start Combat Movement at 35 Yards (Phase 1)'),
('1690506','16905','9','13','100','1','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1690507','16905','9','13','100','1','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Start Combat Movement Below 5 Yards'),
('1690508','16905','0','13','100','1','5000','9000','12000','15000','11','11829','1','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Cast Flamestrike (Phase 1)'),
('1690509','16905','9','0','100','0','0','5','0','0','29','10','150','0','11','11831','0','1','0','0','0','0','Unyielding Sorcerer - Ranged Movement at 5 Yards to Avoid Melee Combat'),
('1690510','16905','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1690511','16905','2','0','100','0','15','0','0','0','11','11831','0','1','22','3','0','0','0','0','0','0','Unyielding Sorcerer - Cast Frost Nova and Set Phase 3 at 15% HP'),
('1690512','16905','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Unyielding Sorcerer - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1690513','16905','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Unyielding Sorcerer - Set Phase to 0 on Evade');
