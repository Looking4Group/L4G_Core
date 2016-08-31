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
