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
('-9907','You will suffer slowly until the end of time for this affront!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 on Aggro'),
('-9906','Prepare yourself for eternal torture, mortal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 on Aggro'),
('-9905','I shall enjoy the smell of the grease from your marrow crackling over the fire!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 on Aggro'),
('-9904','Release the hounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 IC Summon Event'),
('-9903','Your name is as insignificant to me as the names of the thousands who have died under the might of Goc. I will crush you and $N!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','20555 on Aggro'),
('-9902','Me mad. You get smash in face!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','19948 on Aggro'),
('-9901','','As I shall consume your flesh, so too shall the Burning Legion consume your people!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','23355 on Aggro'),
('-9900',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','SCHERGRATCOMMENT');

UPDATE `creature` SET `position_x`='2548.5935', `position_y`='7331.4287', `position_z`='373.4237', `orientation`='4.2454',`spawndist`='0',`movementtype`='0' WHERE `guid` = '44255';
DELETE FROM `creature_addon` WHERE `guid` = 44255;
INSERT INTO `creature_addon` VALUES (44255,0,21152,0,0,4097,0,0,'');

DELETE FROM `creature_loot_template` WHERE `entry` IN (22281,23353,23354,23355);
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
