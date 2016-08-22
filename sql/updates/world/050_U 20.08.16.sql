UPDATE `creature` SET `position_x`='-784.758301', `position_y`='5396.248047', `position_z`='23.044712', `orientation`='2.9116' WHERE `guid` ='63945';
UPDATE `creature` SET `position_x`='-719.549194', `position_y`='5382.931152', `position_z`='22.456079', `orientation`='4.5999' WHERE `guid` ='63944';

-- 19421 
UPDATE `creature_template` SET `inhabittype`='7' WHERE `entry` IN ('19421');

UPDATE `creature` SET `spawnmask`=1 WHERE `guid`=39681;

DELETE FROM `creature` WHERE `guid` = 99257;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (99257, 18683, 530, 1, 0, 0, -2797.86, 8371.15, -39.4439, 0.959005, 43200, 0, 0, 10466, 11964, 0, 2);
SET @GUID := 99257;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2797.86,8371.15,-39.4439,0,0,0,100,0),
(@GUID,2,-2769.38,8427.4,-41.0358,0,0,0,100,0),
(@GUID,3,-2745.51,8451.7,-40.1339,0,0,0,100,0),
(@GUID,4,-2719.87,8475.16,-42.5082,0,0,0,100,0),
(@GUID,5,-2646.94,8516.83,-39.1658,0,0,0,100,0),
(@GUID,6,-2569.01,8520.52,-37.3603,0,0,0,100,0),
(@GUID,7,-2537.85,8512.96,-36.0247,0,0,0,100,0),
(@GUID,8,-2521.09,8506.78,-37.2972,0,0,0,100,0),
(@GUID,9,-2433.52,8462.14,-37.8204,0,0,0,100,0),
(@GUID,10,-2395.54,8415.53,-39.621,0,0,0,100,0),
(@GUID,11,-2370.48,8347.7,-40.1679,0,0,0,100,0),
(@GUID,12,-2365.48,8273.46,-40.3955,0,0,0,100,0),
(@GUID,13,-2385.62,8211.39,-41.404,0,0,0,100,0),
(@GUID,14,-2418.92,8163,-42.0625,0,0,0,100,0),
(@GUID,15,-2427.3,8154,-40.4315,0,0,0,100,0),
(@GUID,16,-2436.93,8143.79,-42.2831,0,0,0,100,0),
(@GUID,17,-2533.66,8092.81,-46.0847,0,0,0,100,0),
(@GUID,18,-2620.56,8092.64,-48.379,0,0,0,100,0),
(@GUID,19,-2635.2,8097.11,-45.711,0,0,0,100,0),
(@GUID,20,-2652.55,8102.41,-47.9662,0,0,0,100,0),
(@GUID,21,-2730.78,8141.86,-48.1224,0,0,0,100,0),
(@GUID,22,-2782.87,8205.79,-47.5376,0,0,0,100,0),
(@GUID,23,-2791.14,8241.92,-45.1802,0,0,0,100,0),
(@GUID,24,-2794.04,8254.55,-46.6515,0,0,0,100,0),
(@GUID,25,-2804.39,8345.89,-40.7947,0,0,0,100,0),
(@GUID,26,-2798.9,8367.5,-39.5606,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` = 71626;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (71626, 20125, 530, 1, 0, 0, -1839.5, 5223.18, -37.9621, 3.42085, 300, 0, 0, 7000, 0, 0, 0);
DELETE FROM `creature_addon` WHERE `guid` = 71626;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES (71626, 0, 0, 0, 0, 4097, 233, 0, '');
DELETE FROM `creature` WHERE `guid` = 33821;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (33821, 4960, 0, 1, 0, 0, -8507, 328.347, 120.885, 2.468, 310, 0, 0, 3200, 0, 0, 0);
DELETE FROM `creature` WHERE `guid` = 75999;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (75999, 21746, 530, 1, 0, 0, -2983.52, 863.391, -7.48924, 3.08923, 300, 0, 0, 6600, 2790, 0, 0);

UPDATE `creature_template` SET `lootid`=0 WHERE `entry` = 7395;

DELETE FROM `game_event_creature` WHERE `guid` IN (16800782,16800783,16800784,16800785,16800789,16800790,16800791,16800792,16800797,16800798);
INSERT INTO `game_event_creature` VALUES
--
-- Call to Arms: Alterac Valley! 18
--
(16800784,18),
(16800785,18),
(16800791,18),
(16800792,18),
(16800797,18),
(16800798,18),
-- Call to Arms: Warsong Gulch! 19
--
(16800782,19),
(16800783,19),
(16800789,19),
(16800790,19);
-- Call to Arms: Arathi Basin! 20
--
-- Call to Arms: Eye of the Storm! 21
--

-- loottable summoned voidwalkers no loot no gold nothing just pain
UPDATE `creature_template` SET `lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('8996','12922'); -- 8996
-- spell spawned npc 8996,12922
DELETE FROM `creature` WHERE `id` IN (8996,12922);

-- Terrordar the Tormentor 22385
UPDATE `creature_template` SET `maxhealth`='25356',`mindmg`='1549',`maxdmg`='1840',`AIName`='EventAI',`mechanic_immune_mask`='618889051' WHERE `entry` IN ('22385'); -- 22356 278 569
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22385');
INSERT INTO `creature_ai_scripts` VALUES
('2238501','22385','0','0','100','9','0','20','6000','12000','11','44519','1','0','0','0','0','0','0','0','0','0','Terrordar the Tormentor - Cast Incinerate'),
('2238502','22385','0','0','100','0','4000','8000','15000','18000','11','41281','1','0','0','0','0','0','0','0','0','0','Terrordar the Tormentor - Cast Criple');
SET @GUID := 78694;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + 1,'1501.4047','7177.1020','364.8366',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1542.2263','7187.4453','363.7533',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1558.0931','7236.4135','363.9824',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1559.1157','7305.6469','364.4091',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1529.4974','7334.1015','364.1177',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1467.1242','7332.9423','363.9970',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1402.5922','7310.8276','364.0789',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1369.8989','7261.9033','364.3698',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1405.0351','7189.0825','364.0041',0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,'1456.0393','7176.1972','365.1547',0,0,0,100,0);

-- Felstorm Corruptor 22217
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='71',`AIName`='EventAI' WHERE `entry` IN ('22217'); -- 66 67
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22217');
INSERT INTO `creature_ai_scripts` VALUES
('2221701','22217','0','0','100','9','0','30','7000','9000','11','18376','4','32','0','0','0','0','0','0','0','0','Felstorm Corruptor - Cast Corruption'),
('2221702','22217','0','0','100','9','0','40','4000','5000','11','15232','1','0','0','0','0','0','0','0','0','0','Felstorm Corruptor - Cast Shadow Bolt');

-- Trigul 22174
UPDATE `creature_template` SET `baseattacktime`='2000',`AIName`='EventAI' WHERE `entry` = '22174';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '22174';
INSERT INTO `creature_ai_scripts` VALUES
('2217401','22174','0','0','100','4','0','0','0','0','11','3391','0','7','0','0','0','0','0','0','0','0','Trigul - Cast Thrash on Aggro'),
('2217402','22174','9','0','100','0','0','5','8000','12000','11','33628','1','0','0','0','0','0','0','0','0','0','Trigul - Cast Lightning Tether');

UPDATE `creature` SET `position_x`='3868.8671', `position_y`='5777.7602', `position_z`='267.0777', `orientation`='0.7928',`spawndist`='5',`movementtype`='1' WHERE `guid` = '77881';
UPDATE `creature` SET `position_x`='3866.2773', `position_y`='5775.1318', `position_z`='267.1492', `orientation`='0.7928',`spawndist`='5',`movementtype`='1' WHERE `guid` = '77910';
UPDATE `creature` SET `position_x`='3943.0634', `position_y`='5727.0981', `position_z`='268.1709', `orientation`='4.6550',`spawndist`='5',`movementtype`='1' WHERE `guid` = '78317';
UPDATE `creature` SET `position_x`='3868.9838', `position_y`='5736.1850', `position_z`='266.6504', `orientation`='1.5531',`spawndist`='5',`movementtype`='1' WHERE `guid` = '78343';
UPDATE `creature` SET `position_x`='3888.9775', `position_y`='5770.6542', `position_z`='267.5713', `orientation`='1.9144',`spawndist`='0',`movementtype`='0' WHERE `guid` = '78804';
UPDATE `creature` SET `position_z`='266.1194' WHERE `guid` = '78806';
UPDATE `creature` SET `position_x`='3992.0195', `position_y`='5706.6997', `position_z`='272.0166', `orientation`='5.8257',`spawndist`='0',`movementtype`='0' WHERE `guid` = '78805';
UPDATE `creature` SET `position_z`='266.7215' WHERE `guid` = '78808';

UPDATE `creature` SET `position_x`='2978.3776', `position_y`='5486.0156', `position_z`='143.4522', `orientation`='5.8492' WHERE `guid` = '77717';

-- Simon Say Ogrila big thx to Robin
DELETE FROM `gameobject` WHERE `guid` BETWEEN 100001 AND 100088;
DELETE FROM `gameobject` WHERE `guid` IN (28038,28036,28039,28035,28030,28034,28037,28031,28032,28033);
INSERT INTO `gameobject` VALUES (100088, 185805, 530, 1, 3888.66, 5119.85, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100087, 185806, 530, 1, 3891.52, 5116.98, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100086, 185731, 530, 1, 3888.72, 5117.06, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100085, 185730, 530, 1, 3888.72, 5117.07, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100084, 185804, 530, 1, 3885.8,  5117.02, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100083, 185728, 530, 1, 3888.72, 5117.05, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100082, 185729, 530, 1, 3888.73, 5117.06, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100081, 185807, 530, 1, 3888.71, 5114.23, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100080, 185890, 530, 1, 3888.72, 5117.07, 272.293, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100079, 185894, 530, 1, 3888.7,  5117.03, 270.255,  0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100078, 185794, 530, 1, 3895.19, 5102.03, 270.093, 3.14159, 0, 0, 1, 0, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100077, 185811, 530, 1, 3891.35, 5085.79, 270.093, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100076, 185808, 530, 1, 3888.48, 5083.15, 270.093, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100075, 185809, 530, 1, 3885.68, 5086.06, 270.093, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100074, 185732, 530, 1, 3888.6,  5085.98, 270.148, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100073, 185733, 530, 1, 3888.61, 5085.97, 270.148, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100072, 185734, 530, 1, 3888.61, 5085.97, 270.148, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100071, 185810, 530, 1, 3888.66, 5088.69, 270.093, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100070, 185735, 530, 1, 3888.61, 5085.97, 270.148, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100069, 185890, 530, 1, 3888.63, 5085.98, 272.139, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100068, 185894, 530, 1, 3888.66, 5085.99, 270.247, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100067, 185795, 530, 1, 3905.94, 5091.22, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100066, 185792, 530, 1, 3916.73, 5102.01, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100065, 185797, 530, 1, 3919.67, 5086.12, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100064, 185799, 530, 1, 3922.57, 5086.15, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100063, 185800, 530, 1, 3922.57, 5086.16, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100062, 185803, 530, 1, 3925.41, 5086.07, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100061, 185727, 530, 1, 3922.49, 5116.90, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100060, 185791, 530, 1, 3922.47, 5114.02, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100059, 185725, 530, 1, 3922.5,  5116.89, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100058, 185726, 530, 1, 3922.49, 5116.90, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100057, 185724, 530, 1, 3922.5,  5116.89, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100056, 185802, 530, 1, 3922.57, 5086.16, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100055, 185798, 530, 1, 3922.55, 5088.85, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100054, 185796, 530, 1, 3922.56, 5083.36, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100053, 185801, 530, 1, 3922.57, 5086.15, 270.148, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100052, 185788, 530, 1, 3919.61, 5116.84, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100051, 185793, 530, 1, 3905.97, 5112.77, 270.093, 3.12414, 0, 0, 0.999962, 0.008727, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100050, 185789, 530, 1, 3922.44, 5119.64, 270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100049, 185790, 530, 1, 3925.29, 5116.8,  270.093, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100048, 185890, 530, 1, 3922.6,  5086.17, 272.588, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100047, 185894, 530, 1, 3922.53, 5086.17, 270.25, 0, 0, 0, 0, 1, 180, 100, 1); 
INSERT INTO `gameobject` VALUES (100046, 185890, 530, 1, 3922.49, 5116.93, 272.559, 0, 0, 0, 0, 1, 180, 100, 1); 
INSERT INTO `gameobject` VALUES (100045, 185894, 530, 1, 3922.51, 5116.9,  270.238, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100044, 185805, 530, 1, 2708.96, 7301.26, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100043, 185806, 530, 1, 2711.82, 7298.39, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100042, 185731, 530, 1, 2709.02, 7298.47, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100041, 185730, 530, 1, 2709.02, 7298.48, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100040, 185804, 530, 1, 2706.1,  7298.43, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100039, 185728, 530, 1, 2709.02, 7298.46, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100038, 185729, 530, 1, 2709.03, 7298.47, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100037, 185807, 530, 1, 2709.01, 7295.64, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100036, 185890, 530, 1, 2709.02, 7298.48, 370.728, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100035, 185894, 530, 1, 2709.00, 7298.44, 368.69, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100034, 185794, 530, 1, 2715.49, 7283.44, 368.528, 3.14159, 0, 0, 1, 0, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100033, 185811, 530, 1, 2711.65, 7267.2,  368.528, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100032, 185808, 530, 1, 2708.78, 7264.56, 368.528, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100031, 185809, 530, 1, 2705.98, 7267.47, 368.528, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100030, 185732, 530, 1, 2708.9,  7267.39, 368.583, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100029, 185733, 530, 1, 2708.91, 7267.38, 368.583, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100028, 185734, 530, 1, 2708.91, 7267.38, 368.583, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100027, 185810, 530, 1, 2708.96, 7270.1,  368.528, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100026, 185735, 530, 1, 2708.91, 7267.38, 368.583, 3.11541, 0, 0, 0.999914, 0.01309, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100025, 185890, 530, 1, 2708.93, 7267.39, 370.574, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100024, 185894, 530, 1, 2708.96, 7267.4,  368.682, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100023, 185795, 530, 1, 2726.24, 7272.67, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100022, 185792, 530, 1, 2737.03, 7283.42, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100021, 185797, 530, 1, 2739.97, 7267.53, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100020, 185799, 530, 1, 2742.87, 7267.56, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100019, 185800, 530, 1, 2742.87, 7267.57, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100018, 185803, 530, 1, 2745.71, 7267.48, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100017, 185727, 530, 1, 2742.79, 7298.31, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100016, 185791, 530, 1, 2742.77, 7295.43, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100015, 185725, 530, 1, 2742.8,  7298.3,  368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100014, 185726, 530, 1, 2742.79, 7298.31, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100013, 185724, 530, 1, 2742.8,  7298.3,  368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100012, 185802, 530, 1, 2742.87, 7267.57, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100011, 185798, 530, 1, 2742.85, 7270.26, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100010, 185796, 530, 1, 2742.86, 7264.77, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100009, 185801, 530, 1, 2742.87, 7267.56, 368.583, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100008, 185788, 530, 1, 2739.91, 7298.25, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100007, 185793, 530, 1, 2726.27, 7294.18, 368.528, 3.12414, 0, 0, 0.999962, 0.008727, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100006, 185789, 530, 1, 2742.74, 7301.05, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100005, 185790, 530, 1, 2745.59, 7298.21, 368.528, -3.13287, 0, 0, 0.99999, -0.004363, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100004, 185890, 530, 1, 2742.9,  7267.58, 371.023, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100003, 185894, 530, 1, 2742.83, 7267.58, 368.685, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100002, 185890, 530, 1, 2742.79, 7298.34, 370.994, 0, 0, 0, 0, 1, 180, 100, 1);
INSERT INTO `gameobject` VALUES (100001, 185894, 530, 1, 2742.81, 7298.31, 368.673, 0, 0, 0, 0, 1, 180, 100, 1);

-- Thorium Lockbox
UPDATE `item_template` SET `lockid`=62 WHERE `entry` = 5759; -- 
DELETE FROM `item_loot_template` WHERE `entry` = 5759;
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 1973, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 4500, 5.9, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 7527, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 7909, 2.7, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 7910, 2.4, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 8316, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 10198, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 10204, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 12682, 0.5, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 12694, 0.3, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 12697, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 12702, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 12704, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 12713, 0.4, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13044, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13053, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13056, 0.4, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13096, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13101, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13118, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13130, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13487, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13490, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 13492, 0.4, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14466, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14474, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14489, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14492, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14494, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14496, 0.4, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14504, 0.3, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 14508, 0.4, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15245, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15731, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15743, 0.7, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15745, 0.7, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15746, 0.3, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15754, 0.1, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15755, 0.3, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15757, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15765, 0.4, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 15936, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 16245, 0.2, 0, 1, 1);
INSERT INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 16251, 0.4, 0, 1, 1);
INSERT IGNORE INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 24016, 30, 1, -24016, 1);
INSERT IGNORE INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 24031, 30, 1, -24031, 1);
INSERT IGNORE INTO `item_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`) VALUES (5759, 24033, 30, 1, -24033, 1);

-- Netherstorm Trigger
UPDATE `creature_template` SET `Inhabittype`='7' WHERE `entry` IN ('19656');

-- Razorsaw
UPDATE `creature` SET `spawntimesecs`=180 WHERE `guid` = 73465;

DELETE FROM `pool_template` WHERE `entry` BETWEEN 2019 AND 2069;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2019, 9, 'Master Mineral Pool - Redridge Mountians (Main Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2020, 4, 'Master Mineral Pool - Redridge Mountians (Rethban Caverns)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2021, 7, 'Master Mineral Pool - Searing Gorge (West Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2022, 5, 'Master Mineral Pool - Searing Gorge (East Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2023, 7, 'Master Mineral Pool - Silverpine Forest');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2024, 11, 'Master Mineral Pool - Stranglethorn Vale');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2025, 9, 'Master Mineral Pool - Swamp of Sorrows');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2026, 7, 'Master Mineral Pool - The Hinterlands');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2027, 7, 'Master Mineral Pool - Tirisfal Glades');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2028, 5, 'Master Mineral Pool - Western Plaguelands (South-West Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2029, 4, 'Master Mineral Pool - Western Plaguelands (East and North Sections)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2030, 8, 'Master Mineral Pool - Westfall');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2031, 7, 'Master Mineral Pool - Wetlands (Main Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2032, 4, 'Master Mineral Pool - Wetlands (Thelgen Rock)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2033, 8, 'Master Mineral Pool - Ashenvale (West Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2034, 8, 'Master Mineral Pool - Ashenvale (East Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2035, 11, 'Master Mineral Pool - Azshara');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2036, 11, 'Master Mineral Pool - Azuremyst Isle');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2037, 3, 'Master Mineral Pool - Bloodmyst Isle (Lower Level Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2038, 9, 'Master Mineral Pool - Bloodmyst Isle (Main Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2039, 12, 'Master Mineral Pool - Darkshore');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2040, 9, 'Master Mineral Pool - Desolace');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2041, 13, 'Master Mineral Pool - Durotar');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2042, 9, 'Master Mineral Pool - Dustwallow Marsh');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2043, 9, 'Master Mineral Pool - Felwood');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2045, 7, 'Master Mineral Pool - Feralas');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2046, 4, 'Master Mineral Pool - Feralas (Ooze Covered Mineral GOs)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2047, 11, 'Master Mineral Pool - Mulgore');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2048, 7, 'Master Mineral Pool - Silithus');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2049, 8, 'Master Mineral Pool - Silithus (Ooze Covered Mineral GOs)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2050, 7, 'Master Mineral Pool - Stonetalon Mountians');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2051, 9, 'Master Mineral Pool - Tanaris');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2052, 13, 'Master Mineral Pool - The Barrens (Main Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2053, 3, 'Master Mineral Pool - The Barrens (Bael Modan)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2055, 13, 'Master Mineral Pool - Thousand Needles');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2056, 3, 'Master Mineral Pool - Thousand Needles (Ooze Covered Mineral GOs)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2057, 1, 'Master Mineral Pool - Thunder Bluff');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2058, 11, 'Master Mineral Pool - Un\'Goro Crater');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2059, 5, 'Master Mineral Pool - Un\'Goro Crater (Ooze Covered Mineral GOs)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2060, 7, 'Master Mineral Pool - Winterspring (Main Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2061, 5, 'Master Mineral Pool - Winterspring (West Section)');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2062, 25, 'Master Mineral Pool - Hellfire Peninsula');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2063, 25, 'Master Mineral Pool - Zangarmarsh');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2064, 25, 'Master Mineral Pool - Nagrand');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2065, 25, 'Master Mineral Pool - Terokkar Forest');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2066, 25, 'Master Mineral Pool - Netherstorm');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2067, 25, 'Master Mineral Pool - Blades Edge Mountains');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2068, 25, 'Master Mineral Pool - Shadowmoon Valley');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES (2069, 25, 'Master Mineral Pool - Shadowmoon Valley (Nethercite Spawns)');

DELETE FROM `pool_gameobject` WHERE `pool_entry` BETWEEN 2019 AND 2069; 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78551, 2027, 0, 'Mineral Spawn Point 1 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78552, 2027, 0, 'Mineral Spawn Point 2 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78553, 2027, 0, 'Mineral Spawn Point 3 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78554, 2027, 0, 'Mineral Spawn Point 4 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78555, 2027, 0, 'Mineral Spawn Point 5 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78556, 2027, 0, 'Mineral Spawn Point 6 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78557, 2027, 0, 'Mineral Spawn Point 7 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78558, 2027, 0, 'Mineral Spawn Point 8 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78559, 2027, 0, 'Mineral Spawn Point 9 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78560, 2027, 0, 'Mineral Spawn Point 10 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78561, 2027, 0, 'Mineral Spawn Point 11 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78562, 2027, 0, 'Mineral Spawn Point 12 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78563, 2027, 0, 'Mineral Spawn Point 13 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78564, 2027, 0, 'Mineral Spawn Point 14 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78565, 2027, 0, 'Mineral Spawn Point 15 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78566, 2027, 0, 'Mineral Spawn Point 16 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78567, 2027, 0, 'Mineral Spawn Point 17 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78568, 2027, 0, 'Mineral Spawn Point 18 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78569, 2027, 0, 'Mineral Spawn Point 19 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78570, 2027, 0, 'Mineral Spawn Point 20 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78571, 2027, 0, 'Mineral Spawn Point 21 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78572, 2027, 0, 'Mineral Spawn Point 22 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78573, 2027, 0, 'Mineral Spawn Point 23 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78574, 2027, 0, 'Mineral Spawn Point 24 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78575, 2027, 0, 'Mineral Spawn Point 25 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78576, 2027, 0, 'Mineral Spawn Point 26 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78577, 2027, 0, 'Mineral Spawn Point 27 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78578, 2027, 0, 'Mineral Spawn Point 28 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78579, 2027, 0, 'Mineral Spawn Point 29 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78580, 2027, 0, 'Mineral Spawn Point 30 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78581, 2027, 0, 'Mineral Spawn Point 31 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78582, 2027, 0, 'Mineral Spawn Point 32 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78583, 2027, 0, 'Mineral Spawn Point 33 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78584, 2027, 0, 'Mineral Spawn Point 34 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78585, 2027, 0, 'Mineral Spawn Point 35 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78586, 2027, 0, 'Mineral Spawn Point 36 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78587, 2027, 0, 'Mineral Spawn Point 37 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78588, 2027, 0, 'Mineral Spawn Point 38 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78589, 2027, 0, 'Mineral Spawn Point 39 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78590, 2027, 0, 'Mineral Spawn Point 40 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78591, 2027, 0, 'Mineral Spawn Point 41 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78592, 2027, 0, 'Mineral Spawn Point 42 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78593, 2027, 0, 'Mineral Spawn Point 43 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78594, 2027, 0, 'Mineral Spawn Point 44 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78595, 2027, 0, 'Mineral Spawn Point 45 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78596, 2027, 0, 'Mineral Spawn Point 46 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78597, 2027, 0, 'Mineral Spawn Point 47 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78598, 2027, 0, 'Mineral Spawn Point 48 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78599, 2027, 0, 'Mineral Spawn Point 49 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78600, 2027, 0, 'Mineral Spawn Point 50 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78601, 2027, 0, 'Mineral Spawn Point 51 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78602, 2027, 0, 'Mineral Spawn Point 52 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (78603, 2027, 0, 'Mineral Spawn Point 53 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105151, 2027, 0, 'Mineral Spawn Point 54 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105152, 2027, 0, 'Mineral Spawn Point 55 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105153, 2027, 0, 'Mineral Spawn Point 56 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105154, 2027, 0, 'Mineral Spawn Point 57 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105155, 2027, 0, 'Mineral Spawn Point 58 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105156, 2027, 0, 'Mineral Spawn Point 59 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105157, 2027, 0, 'Mineral Spawn Point 60 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105158, 2027, 0, 'Mineral Spawn Point 61 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105159, 2027, 0, 'Mineral Spawn Point 62 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (105308, 2027, 0, 'Mineral Spawn Point 63 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101242, 2036, 0, 'Mineral Spawn Point 1 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101243, 2036, 0, 'Mineral Spawn Point 2 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101244, 2036, 0, 'Mineral Spawn Point 3 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101245, 2036, 0, 'Mineral Spawn Point 4 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101246, 2036, 0, 'Mineral Spawn Point 5 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101247, 2036, 0, 'Mineral Spawn Point 6 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101248, 2036, 0, 'Mineral Spawn Point 7 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101249, 2036, 0, 'Mineral Spawn Point 8 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101250, 2036, 0, 'Mineral Spawn Point 9 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101251, 2036, 0, 'Mineral Spawn Point 10 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101252, 2036, 0, 'Mineral Spawn Point 11 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101253, 2036, 0, 'Mineral Spawn Point 12 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101254, 2036, 0, 'Mineral Spawn Point 13 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101255, 2036, 0, 'Mineral Spawn Point 14 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101256, 2036, 0, 'Mineral Spawn Point 15 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101257, 2036, 0, 'Mineral Spawn Point 16 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101258, 2036, 0, 'Mineral Spawn Point 17 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101259, 2036, 0, 'Mineral Spawn Point 18 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101260, 2036, 0, 'Mineral Spawn Point 19 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101261, 2036, 0, 'Mineral Spawn Point 20 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101262, 2036, 0, 'Mineral Spawn Point 21 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101263, 2036, 0, 'Mineral Spawn Point 22 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101264, 2036, 0, 'Mineral Spawn Point 23 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101265, 2036, 0, 'Mineral Spawn Point 24 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101266, 2036, 0, 'Mineral Spawn Point 25 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101267, 2036, 0, 'Mineral Spawn Point 26 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101268, 2036, 0, 'Mineral Spawn Point 27 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101269, 2036, 0, 'Mineral Spawn Point 28 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101270, 2036, 0, 'Mineral Spawn Point 29 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101271, 2036, 0, 'Mineral Spawn Point 30 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101272, 2036, 0, 'Mineral Spawn Point 31 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101273, 2036, 0, 'Mineral Spawn Point 32 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101274, 2036, 0, 'Mineral Spawn Point 33 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101275, 2036, 0, 'Mineral Spawn Point 34 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101276, 2036, 0, 'Mineral Spawn Point 35 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101277, 2036, 0, 'Mineral Spawn Point 36 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101278, 2036, 0, 'Mineral Spawn Point 37 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101279, 2036, 0, 'Mineral Spawn Point 38 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101280, 2036, 0, 'Mineral Spawn Point 39 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101281, 2036, 0, 'Mineral Spawn Point 40 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101282, 2036, 0, 'Mineral Spawn Point 41 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101283, 2036, 0, 'Mineral Spawn Point 42 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101284, 2036, 0, 'Mineral Spawn Point 43 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101285, 2036, 0, 'Mineral Spawn Point 44 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101286, 2036, 0, 'Mineral Spawn Point 45 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101287, 2036, 0, 'Mineral Spawn Point 46 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101288, 2036, 0, 'Mineral Spawn Point 47 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101289, 2036, 0, 'Mineral Spawn Point 48 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101290, 2036, 0, 'Mineral Spawn Point 49 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101291, 2036, 0, 'Mineral Spawn Point 50 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101292, 2036, 0, 'Mineral Spawn Point 51 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101293, 2036, 0, 'Mineral Spawn Point 52 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101294, 2036, 0, 'Mineral Spawn Point 53 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101295, 2036, 0, 'Mineral Spawn Point 54 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101296, 2036, 0, 'Mineral Spawn Point 55 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (111262, 2036, 0, 'Mineral Spawn Point 56 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (111263, 2036, 0, 'Mineral Spawn Point 57 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (111264, 2036, 0, 'Mineral Spawn Point 58 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (111265, 2036, 0, 'Mineral Spawn Point 59 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101297, 2037, 0, 'Mineral Spawn Point 1 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101298, 2037, 0, 'Mineral Spawn Point 2 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101299, 2037, 0, 'Mineral Spawn Point 3 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101300, 2037, 0, 'Mineral Spawn Point 4 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101301, 2037, 0, 'Mineral Spawn Point 5 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101302, 2037, 0, 'Mineral Spawn Point 6 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101303, 2037, 0, 'Mineral Spawn Point 7 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101304, 2037, 0, 'Mineral Spawn Point 8 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101305, 2037, 0, 'Mineral Spawn Point 9 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (101306, 2037, 0, 'Mineral Spawn Point 10 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103101, 2041, 0, 'Mineral Spawn Point 1 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103102, 2041, 0, 'Mineral Spawn Point 2 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103103, 2041, 0, 'Mineral Spawn Point 3 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103104, 2041, 0, 'Mineral Spawn Point 4 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103105, 2041, 0, 'Mineral Spawn Point 5 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103106, 2041, 0, 'Mineral Spawn Point 6 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103107, 2041, 0, 'Mineral Spawn Point 7 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103108, 2041, 0, 'Mineral Spawn Point 8 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103109, 2041, 0, 'Mineral Spawn Point 9 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103110, 2041, 0, 'Mineral Spawn Point 10 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103111, 2041, 0, 'Mineral Spawn Point 11 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103112, 2041, 0, 'Mineral Spawn Point 12 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103113, 2041, 0, 'Mineral Spawn Point 13 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103114, 2041, 0, 'Mineral Spawn Point 14 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103115, 2041, 0, 'Mineral Spawn Point 15 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103116, 2041, 0, 'Mineral Spawn Point 16 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103117, 2041, 0, 'Mineral Spawn Point 17 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103118, 2041, 0, 'Mineral Spawn Point 18 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103119, 2041, 0, 'Mineral Spawn Point 19 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103120, 2041, 0, 'Mineral Spawn Point 20 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103121, 2041, 0, 'Mineral Spawn Point 21 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103122, 2041, 0, 'Mineral Spawn Point 22 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103123, 2041, 0, 'Mineral Spawn Point 23 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103124, 2041, 0, 'Mineral Spawn Point 24 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103125, 2041, 0, 'Mineral Spawn Point 25 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103126, 2041, 0, 'Mineral Spawn Point 26 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103127, 2041, 0, 'Mineral Spawn Point 27 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103128, 2041, 0, 'Mineral Spawn Point 28 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103129, 2041, 0, 'Mineral Spawn Point 29 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103130, 2041, 0, 'Mineral Spawn Point 30 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103131, 2041, 0, 'Mineral Spawn Point 31 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103132, 2041, 0, 'Mineral Spawn Point 32 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103133, 2041, 0, 'Mineral Spawn Point 33 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103134, 2041, 0, 'Mineral Spawn Point 34 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103135, 2041, 0, 'Mineral Spawn Point 35 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103136, 2041, 0, 'Mineral Spawn Point 36 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103137, 2041, 0, 'Mineral Spawn Point 37 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103138, 2041, 0, 'Mineral Spawn Point 38 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103139, 2041, 0, 'Mineral Spawn Point 39 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103140, 2041, 0, 'Mineral Spawn Point 40 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103141, 2041, 0, 'Mineral Spawn Point 41 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103142, 2041, 0, 'Mineral Spawn Point 42 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103143, 2041, 0, 'Mineral Spawn Point 43 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103144, 2041, 0, 'Mineral Spawn Point 44 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103145, 2041, 0, 'Mineral Spawn Point 45 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103146, 2041, 0, 'Mineral Spawn Point 46 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103147, 2041, 0, 'Mineral Spawn Point 47 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103148, 2041, 0, 'Mineral Spawn Point 48 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103149, 2041, 0, 'Mineral Spawn Point 49 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103150, 2041, 0, 'Mineral Spawn Point 50 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103151, 2041, 0, 'Mineral Spawn Point 51 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103152, 2041, 0, 'Mineral Spawn Point 52 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103153, 2041, 0, 'Mineral Spawn Point 53 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103154, 2041, 0, 'Mineral Spawn Point 54 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103155, 2041, 0, 'Mineral Spawn Point 55 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103156, 2041, 0, 'Mineral Spawn Point 56 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103157, 2041, 0, 'Mineral Spawn Point 57 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103158, 2041, 0, 'Mineral Spawn Point 58 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103159, 2041, 0, 'Mineral Spawn Point 59 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103160, 2041, 0, 'Mineral Spawn Point 60 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103161, 2041, 0, 'Mineral Spawn Point 61 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103162, 2041, 0, 'Mineral Spawn Point 62 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103163, 2041, 0, 'Mineral Spawn Point 63 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103164, 2041, 0, 'Mineral Spawn Point 64 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103165, 2041, 0, 'Mineral Spawn Point 65 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103166, 2041, 0, 'Mineral Spawn Point 66 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103167, 2041, 0, 'Mineral Spawn Point 67 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103168, 2041, 0, 'Mineral Spawn Point 68 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103169, 2041, 0, 'Mineral Spawn Point 69 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103170, 2041, 0, 'Mineral Spawn Point 70 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103171, 2041, 0, 'Mineral Spawn Point 71 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103172, 2041, 0, 'Mineral Spawn Point 72 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103173, 2041, 0, 'Mineral Spawn Point 73 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103174, 2041, 0, 'Mineral Spawn Point 74 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103175, 2041, 0, 'Mineral Spawn Point 75 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103176, 2041, 0, 'Mineral Spawn Point 76 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103177, 2041, 0, 'Mineral Spawn Point 77 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103178, 2041, 0, 'Mineral Spawn Point 78 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103179, 2041, 0, 'Mineral Spawn Point 79 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103180, 2041, 0, 'Mineral Spawn Point 80 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103181, 2041, 0, 'Mineral Spawn Point 81 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103182, 2041, 0, 'Mineral Spawn Point 82 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103183, 2041, 0, 'Mineral Spawn Point 83 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103184, 2041, 0, 'Mineral Spawn Point 84 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103185, 2041, 0, 'Mineral Spawn Point 85 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103186, 2041, 0, 'Mineral Spawn Point 86 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103187, 2041, 0, 'Mineral Spawn Point 87 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103188, 2041, 0, 'Mineral Spawn Point 88 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103189, 2041, 0, 'Mineral Spawn Point 89 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103190, 2041, 0, 'Mineral Spawn Point 90 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103191, 2041, 0, 'Mineral Spawn Point 91 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103192, 2041, 0, 'Mineral Spawn Point 92 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103193, 2041, 0, 'Mineral Spawn Point 93 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103194, 2041, 0, 'Mineral Spawn Point 94 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103195, 2041, 0, 'Mineral Spawn Point 95 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103196, 2041, 0, 'Mineral Spawn Point 96 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103197, 2041, 0, 'Mineral Spawn Point 97 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103198, 2041, 0, 'Mineral Spawn Point 98 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103199, 2041, 0, 'Mineral Spawn Point 99 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103200, 2041, 0, 'Mineral Spawn Point 100 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103201, 2041, 0, 'Mineral Spawn Point 101 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103202, 2041, 0, 'Mineral Spawn Point 102 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103203, 2041, 0, 'Mineral Spawn Point 103 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103204, 2041, 0, 'Mineral Spawn Point 104 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103205, 2041, 0, 'Mineral Spawn Point 105 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103206, 2041, 0, 'Mineral Spawn Point 106 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103207, 2041, 0, 'Mineral Spawn Point 107 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103208, 2041, 0, 'Mineral Spawn Point 108 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103209, 2041, 0, 'Mineral Spawn Point 109 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103210, 2041, 0, 'Mineral Spawn Point 110 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103211, 2041, 0, 'Mineral Spawn Point 111 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103212, 2041, 0, 'Mineral Spawn Point 112 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103213, 2041, 0, 'Mineral Spawn Point 113 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103214, 2041, 0, 'Mineral Spawn Point 114 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103215, 2041, 0, 'Mineral Spawn Point 115 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103216, 2041, 0, 'Mineral Spawn Point 116 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103217, 2041, 0, 'Mineral Spawn Point 117 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103218, 2041, 0, 'Mineral Spawn Point 118 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103219, 2041, 0, 'Mineral Spawn Point 119 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103220, 2041, 0, 'Mineral Spawn Point 120 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103221, 2041, 0, 'Mineral Spawn Point 121 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103222, 2041, 0, 'Mineral Spawn Point 122 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103223, 2041, 0, 'Mineral Spawn Point 123 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103224, 2041, 0, 'Mineral Spawn Point 124 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103225, 2041, 0, 'Mineral Spawn Point 125 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103226, 2041, 0, 'Mineral Spawn Point 126 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103227, 2041, 0, 'Mineral Spawn Point 127 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103228, 2041, 0, 'Mineral Spawn Point 128 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103229, 2041, 0, 'Mineral Spawn Point 129 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103230, 2041, 0, 'Mineral Spawn Point 130 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103231, 2041, 0, 'Mineral Spawn Point 131 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103232, 2041, 0, 'Mineral Spawn Point 132 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103233, 2041, 0, 'Mineral Spawn Point 133 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103234, 2041, 0, 'Mineral Spawn Point 134 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103235, 2041, 0, 'Mineral Spawn Point 135 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103236, 2041, 0, 'Mineral Spawn Point 136 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103237, 2041, 0, 'Mineral Spawn Point 137 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103238, 2041, 0, 'Mineral Spawn Point 138 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103883, 2041, 0, 'Mineral Spawn Point 139 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103884, 2041, 0, 'Mineral Spawn Point 140 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103885, 2041, 0, 'Mineral Spawn Point 141 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103886, 2041, 0, 'Mineral Spawn Point 142 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103887, 2041, 0, 'Mineral Spawn Point 143 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103888, 2041, 0, 'Mineral Spawn Point 144 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103889, 2041, 0, 'Mineral Spawn Point 145 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103890, 2041, 0, 'Mineral Spawn Point 146 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103891, 2041, 0, 'Mineral Spawn Point 147 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103892, 2041, 0, 'Mineral Spawn Point 148 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103893, 2041, 0, 'Mineral Spawn Point 149 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103894, 2041, 0, 'Mineral Spawn Point 150 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103895, 2041, 0, 'Mineral Spawn Point 151 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103896, 2041, 0, 'Mineral Spawn Point 152 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103897, 2041, 0, 'Mineral Spawn Point 153 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103898, 2041, 0, 'Mineral Spawn Point 154 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103899, 2041, 0, 'Mineral Spawn Point 155 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103900, 2041, 0, 'Mineral Spawn Point 156 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103901, 2041, 0, 'Mineral Spawn Point 157 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103902, 2041, 0, 'Mineral Spawn Point 158 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103903, 2041, 0, 'Mineral Spawn Point 159 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103904, 2041, 0, 'Mineral Spawn Point 160 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103905, 2041, 0, 'Mineral Spawn Point 161 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103906, 2041, 0, 'Mineral Spawn Point 162 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103907, 2041, 0, 'Mineral Spawn Point 163 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103908, 2041, 0, 'Mineral Spawn Point 164 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103909, 2041, 0, 'Mineral Spawn Point 165 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103910, 2041, 0, 'Mineral Spawn Point 166 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103911, 2041, 0, 'Mineral Spawn Point 167 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103912, 2041, 0, 'Mineral Spawn Point 168 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103913, 2041, 0, 'Mineral Spawn Point 169 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103914, 2041, 0, 'Mineral Spawn Point 170 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103915, 2041, 0, 'Mineral Spawn Point 171 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103916, 2041, 0, 'Mineral Spawn Point 172 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103917, 2041, 0, 'Mineral Spawn Point 173 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (103918, 2041, 0, 'Mineral Spawn Point 174 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104521, 2047, 0, 'Mineral Spawn Point 1 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104522, 2047, 0, 'Mineral Spawn Point 2 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104523, 2047, 0, 'Mineral Spawn Point 3 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104524, 2047, 0, 'Mineral Spawn Point 4 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104525, 2047, 0, 'Mineral Spawn Point 5 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104526, 2047, 0, 'Mineral Spawn Point 6 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104527, 2047, 0, 'Mineral Spawn Point 7 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104528, 2047, 0, 'Mineral Spawn Point 8 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104529, 2047, 0, 'Mineral Spawn Point 9 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104530, 2047, 0, 'Mineral Spawn Point 10 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104531, 2047, 0, 'Mineral Spawn Point 11 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104532, 2047, 0, 'Mineral Spawn Point 12 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104533, 2047, 0, 'Mineral Spawn Point 13 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104534, 2047, 0, 'Mineral Spawn Point 14 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104535, 2047, 0, 'Mineral Spawn Point 15 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104536, 2047, 0, 'Mineral Spawn Point 16 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104537, 2047, 0, 'Mineral Spawn Point 17 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104538, 2047, 0, 'Mineral Spawn Point 18 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104539, 2047, 0, 'Mineral Spawn Point 19 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104540, 2047, 0, 'Mineral Spawn Point 20 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104541, 2047, 0, 'Mineral Spawn Point 21 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104542, 2047, 0, 'Mineral Spawn Point 22 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104543, 2047, 0, 'Mineral Spawn Point 23 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104544, 2047, 0, 'Mineral Spawn Point 24 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104545, 2047, 0, 'Mineral Spawn Point 25 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104546, 2047, 0, 'Mineral Spawn Point 26 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104547, 2047, 0, 'Mineral Spawn Point 27 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104548, 2047, 0, 'Mineral Spawn Point 28 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104549, 2047, 0, 'Mineral Spawn Point 29 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104550, 2047, 0, 'Mineral Spawn Point 30 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104551, 2047, 0, 'Mineral Spawn Point 31 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104552, 2047, 0, 'Mineral Spawn Point 32 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104553, 2047, 0, 'Mineral Spawn Point 33 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104554, 2047, 0, 'Mineral Spawn Point 34 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104555, 2047, 0, 'Mineral Spawn Point 35 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104556, 2047, 0, 'Mineral Spawn Point 36 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104557, 2047, 0, 'Mineral Spawn Point 37 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104558, 2047, 0, 'Mineral Spawn Point 38 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104559, 2047, 0, 'Mineral Spawn Point 39 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104560, 2047, 0, 'Mineral Spawn Point 40 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104561, 2047, 0, 'Mineral Spawn Point 41 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104562, 2047, 0, 'Mineral Spawn Point 42 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104563, 2047, 0, 'Mineral Spawn Point 43 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104564, 2047, 0, 'Mineral Spawn Point 44 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104565, 2047, 0, 'Mineral Spawn Point 45 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104566, 2047, 0, 'Mineral Spawn Point 46 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104567, 2047, 0, 'Mineral Spawn Point 47 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104568, 2047, 0, 'Mineral Spawn Point 48 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104569, 2047, 0, 'Mineral Spawn Point 49 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104570, 2047, 0, 'Mineral Spawn Point 50 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104571, 2047, 0, 'Mineral Spawn Point 51 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104572, 2047, 0, 'Mineral Spawn Point 52 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104573, 2047, 0, 'Mineral Spawn Point 53 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104574, 2047, 0, 'Mineral Spawn Point 54 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104575, 2047, 0, 'Mineral Spawn Point 55 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104576, 2047, 0, 'Mineral Spawn Point 56 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104577, 2047, 0, 'Mineral Spawn Point 57 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104578, 2047, 0, 'Mineral Spawn Point 58 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104579, 2047, 0, 'Mineral Spawn Point 59 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104580, 2047, 0, 'Mineral Spawn Point 60 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104581, 2047, 0, 'Mineral Spawn Point 61 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104582, 2047, 0, 'Mineral Spawn Point 62 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (104583, 2047, 0, 'Mineral Spawn Point 63 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (108722, 2047, 0, 'Mineral Spawn Point 64 - Copper');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (110221, 2057, 100, 'Mineral Spawn Point 1 - Copper');

DELETE FROM `gameobject` WHERE `guid` BETWEEN 78551 AND 78603;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 101242 AND 101306; 
DELETE FROM `gameobject` WHERE `guid` BETWEEN 103101 AND 103238;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 103883 AND 103918;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 104521 AND 104583;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 105151 AND 105159;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 111262 AND 111265;
DELETE FROM `gameobject` WHERE `guid` IN (105308,108722,110221,61958,61959);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78551, 1731, 0, 1, 2956.82, 412.312, 39.4448, -2.82743, 0, 0, 0.987688, -0.156434, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78552, 1731, 0, 1, 2245.63, 1519.28, 53.4071, -2.58309, 0, 0, 0.961262, -0.275637, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78553, 1731, 0, 1, 2557.3, 1691.01, 8.38937, -2.54818, 0, 0, 0.956305, -0.292372, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78554, 1731, 0, 1, 2551.51, -120.405, 25.5001, 2.67035, 0, 0, 0.97237, 0.233445, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78555, 1731, 0, 1, 1732.7, 897.179, 60.023, 1.98968, 0, 0, 0.838671, 0.544639, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78556, 1731, 0, 1, 2018.84, -628.099, 66.4502, 0.453786, 0, 0, 0.224951, 0.97437, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78557, 1731, 0, 1, 2709.98, 1336.98, 42.0939, 1.22173, 0, 0, 0.573576, 0.819152, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78558, 1731, 0, 1, 2736.66, 1411.2, 2.68338, -0.750491, 0, 0, 0.366501, -0.930418, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78559, 1731, 0, 1, 2453.47, 835.25, 85.8056, -2.58309, 0, 0, 0.961262, -0.275637, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78560, 1731, 0, 1, 2283.34, -1086.17, 83.1417, -2.09439, 0, 0, 0.866025, -0.5, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78561, 1731, 0, 1, 2850.04, -461.927, 82.1176, -1.8326, 0, 0, 0.793353, -0.608761, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78562, 1731, 0, 1, 2968.22, -349.844, 27.8641, 0.715585, 0, 0, 0.350207, 0.936672, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78563, 1731, 0, 1, 3040.21, 619.111, 98.6797, -1.50098, 0, 0, 0.681998, -0.731354, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78564, 1731, 0, 1, 3023.28, 790.686, 87.5232, 0.436332, 0, 0, 0.21644, 0.976296, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78565, 1731, 0, 1, 2927.08, 447.921, 37.3951, -2.60054, 0, 0, 0.96363, -0.267238, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78566, 1731, 0, 1, 2617.09, 564.733, 22.2648, 0.331613, 0, 0, 0.165048, 0.986286, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78567, 1731, 0, 1, 2575.05, 641.717, 31.4842, 0.977384, 0, 0, 0.469472, 0.882948, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78568, 1731, 0, 1, 3019.68, 162.956, -7.08108, -1.85005, 0, 0, 0.798635, -0.601815, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78569, 1731, 0, 1, 1702.92, 768.162, 69.0627, 2.3911, 0, 0, 0.930418, 0.366501, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78570, 1731, 0, 1, 1619.52, -560.97, 55.0243, 0.453786, 0, 0, 0.224951, 0.97437, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78571, 1731, 0, 1, 2373.29, 804.254, 47.0329, -1.72788, 0, 0, 0.760406, -0.649448, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78572, 1731, 0, 1, 2985.67, -721.287, 161.564, 1.98968, 0, 0, 0.838671, 0.544639, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78573, 1731, 0, 1, 2252.92, -636.266, 81.7184, 0.959931, 0, 0, 0.461749, 0.887011, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78574, 1731, 0, 1, 2721.52, -931.349, 81.0418, -1.06465, 0, 0, 0.507538, -0.861629, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78575, 1731, 0, 1, 2700.2, -846.233, 84.8905, 0.279253, 0, 0, 0.139173, 0.990268, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78576, 1731, 0, 1, 2745.86, -385.011, 85.5166, 0.261799, 0, 0, 0.130526, 0.991445, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78577, 1731, 0, 1, 2861.2, -498.192, 102.199, 0.890118, 0, 0, 0.430511, 0.902585, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78578, 1731, 0, 1, 2114.57, 1213.39, 48.3358, 2.84489, 0, 0, 0.989016, 0.147809, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78579, 1731, 0, 1, 2716.62, -540, 106.939, 0.14, 0, 0, 0.069756, 0.997564, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78580, 1731, 0, 1, 2659.03, 802.917, 114.841, 0.314, 0, 0, 0.156434, 0.987688, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78581, 1731, 0, 1, 2208.11, 553.019, 34.0019, 0.523598, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78582, 1731, 0, 1, 2805.09, 741.591, 138.367, -1, 0, 0, -0.300706, 0.953717, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78583, 1731, 0, 1, 2245.48, 1332.42, 38.1899, -2.93214, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78584, 1731, 0, 1, 2225.5, -332.543, 73.1434, -0.034906, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78585, 1731, 0, 1, 2133.66, -315.844, 57.8635, 2.21656, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78586, 1731, 0, 1, 2478.94, 56.65, 12.432, 1.292, 0, 0, 0.601815, 0.798635, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78587, 1731, 0, 1, 2782.9, -830, 155.883, 2.234, 0, 0, 0.898794, 0.438371, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78588, 1731, 0, 1, 2219.76, 607.936, 29.159, -2, 0, 0, -0.766044, 0.642788, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78589, 1731, 0, 1, 1730.85, 994.12, 56.659, 1.466, 0, 0, 0.669131, 0.743145, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78590, 1731, 0, 1, 3100.4, -592, 126.385, 2.496, 0, 0, 0.948324, 0.317305, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78591, 1731, 0, 1, 2613.72, -503.312, 91.9222, 3.05433, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78592, 1731, 0, 1, 2718.82, 1259.24, 46.958, 2.21657, 0, 0, 0.894934, 0.446198, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78593, 1731, 0, 1, 1572.09, -687.518, 57.2998, 1.37881, 0, 0, 0.636078, 0.771625, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78594, 1731, 0, 1, 2134.76, -457.173, 76.0097, -0.645772, 0, 0, 0.317305, -0.948324, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78595, 1731, 0, 1, 2524.39, -584.124, 83.0835, -0.890118, 0, 0, 0.430511, -0.902585, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78596, 1731, 0, 1, 1841.24, 1133.81, 33.6349, -3.12414, 0, 0, 0.999962, -0.008727, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78597, 1731, 0, 1, 2228.82, 1288.9, 49.7022, 1.02974, 0, 0, 0.492424, 0.870356, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78598, 1731, 0, 1, 2686.04, -717.874, 129.438, 1.64061, 0, 0, 0.731354, 0.681998, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78599, 1731, 0, 1, 2589.23, -673.345, 78.9289, 2.42601, 0, 0, 0.936672, 0.350207, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78600, 1731, 0, 1, 2115.94, -662.906, 79.4342, 0.890118, 0, 0, 0.430511, 0.902585, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78601, 1731, 0, 1, 2656.42, 1194.57, 74.715, -2, 0, 0, -0.793353, 0.608761, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78602, 1731, 0, 1, 2485.92, 581.391, 34.6939, -2.07694, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (78603, 1731, 0, 1, 2400.78, 569.456, 42.212, 2.74, 0, 0, 0.979925, 0.199368, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101242, 1731, 530, 1, -4217.77, -11982.2, -6.78159, 0.506145, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101243, 1731, 530, 1, -4739.83, -11558.4, -8.61849, 1.95477, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101244, 1731, 530, 1, -4771.43, -12306.4, 6.75373, -0.226892, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101245, 1731, 530, 1, -4559.39, -11676.8, 22.0364, -2.11185, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101246, 1731, 530, 1, -4859.67, -12139.1, 14.5417, 1.0821, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101247, 1731, 530, 1, -4547.69, -12142.5, 34.0249, -0.698132, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101248, 1731, 530, 1, -3823.74, -12579.4, 2.17238, 0, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101249, 1731, 530, 1, -3703.19, -11466.1, 303.665, 2.53072, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101250, 1731, 530, 1, -3496.12, -11577, 14.9949, 0, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101251, 1731, 530, 1, -3149.38, -12393.9, 12.1434, 3.00197, 0, 0, 0.997564, 0.069757, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101252, 1731, 530, 1, -4666.33, -11535.9, 22.4012, -2.11185, 0, 0, 0.870356, -0.492423, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101253, 1731, 530, 1, -4408.13, -11518.2, 14.1106, 1.46608, 0, 0, 0.669131, 0.743145, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101254, 1731, 530, 1, -4752.11, -11584.9, -27.4095, 0.366518, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101255, 1731, 530, 1, -4851.3, -11549.3, 29.8844, -0.820303, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101256, 1731, 530, 1, -4721.82, -11381.1, 1.53777, -1.15192, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101257, 1731, 530, 1, -3847.4, -12503.3, 4.08391, -0.226892, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101258, 1731, 530, 1, -3917.63, -12360.3, 7.19842, -2.07694, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101259, 1731, 530, 1, -3767.92, -11826.2, 21.986, -0.523598, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101260, 1731, 530, 1, -4113.75, -12349.5, -14.5151, -2.84488, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101261, 1731, 530, 1, -4779.29, -12180.7, 29.5111, 0.488691, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101262, 1731, 530, 1, -5240.38, -11234.1, 11.1148, -0.698132, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101263, 1731, 530, 1, -5156.21, -11105.9, 29.7827, 2.86233, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101264, 1731, 530, 1, -4774.76, -11635.7, -36.7166, -1.23918, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101265, 1731, 530, 1, -4780.46, -11527.6, -16.3041, 1.01229, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101266, 1731, 530, 1, -4831.48, -11442.9, -34.6254, -2.21656, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101267, 1731, 530, 1, -4996.57, -11193.1, 20.9336, -1.91986, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101268, 1731, 530, 1, -3887.91, -12696.9, 94.0337, -2.70526, 0, 0, 0.976296, -0.21644, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101269, 1731, 530, 1, -4809.11, -11667.8, -40.5956, -1.43117, 0, 0, 0.656059, -0.75471, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101270, 1731, 530, 1, -5085.58, -11970, -2.40896, 1.8326, 0, 0, 0.793353, 0.608761, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101271, 1731, 530, 1, -4773.14, -11467.5, 24.643, -1.91986, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101272, 1731, 530, 1, -4702.54, -11540.2, -24.777, -0.733038, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101273, 1731, 530, 1, -4774.76, -11635.7, -36.7166, -1.23918, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101274, 1731, 530, 1, -4778.81, -11573.7, -2.75845, -0.820305, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101275, 1731, 530, 1, -4302, -12927.6, 9.3698, -2.14675, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101276, 1731, 530, 1, -4295.92, -12735.8, 21.8414, -1.0472, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101277, 1731, 530, 1, -3961.57, -12711.4, 82.02, 1.02974, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101278, 1731, 530, 1, -3875.6, -12775, 25.1323, 2.77507, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101279, 1731, 530, 1, -3356.8, -12177.6, 41.1204, -1.32645, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101280, 1731, 530, 1, -3127.35, -12482.8, 2.25965, -1.15192, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101281, 1731, 530, 1, -3205.95, -12416.9, 3.10401, 0.959931, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101282, 1731, 530, 1, -5045.83, -11072.7, 29.4929, 1.8675, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101283, 1731, 530, 1, -5167.42, -11033.6, 24.5044, 1.6057, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101284, 1731, 530, 1, -5118.29, -10943.1, 16.0907, 0.174533, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101285, 1731, 530, 1, -4565.29, -12030.2, 42.5364, 0.331613, 0, 0, 0.165048, 0.986286, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101286, 1731, 530, 1, -4066.04, -12693.8, 14.8971, -0.872665, 0, 0, 0.422618, -0.906308, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101287, 1731, 530, 1, -4178.29, -12910.6, 6.36836, -1.01229, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101288, 1731, 530, 1, -4323.69, -12851.5, 11.673, -1.15192, 0, 0, 1, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101289, 1731, 530, 1, -4890.44, -12042.3, 22.4669, 0.733038, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101290, 1731, 530, 1, -4961.75, -11727.3, 12.8604, 0.541052, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101291, 1731, 530, 1, -5083.06, -11658.3, -12.9082, 2.82743, 0, 0, 1, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101292, 1731, 530, 1, -4816.09, -11605.3, -42.3396, -1.0821, 0, 0, 1, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101293, 1731, 530, 1, -4977.74, -11441.8, -36.9993, 2.75762, 0, 0, 1, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101294, 1731, 530, 1, -4890.08, -11146.4, 7.22636, 1.0472, 0, 0, 1, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101295, 1731, 530, 1, -4874.49, -11278.6, 2.6214, -0.488692, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101296, 1731, 530, 1, -3198.77, -12358.7, 18.8168, -0.663225, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101297, 1731, 530, 1, -2173.48, -12289.1, 54.1866, -1.01229, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101298, 1731, 530, 1, -2542.84, -11916.8, 22.3775, -2.79252, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101299, 1731, 530, 1, -2614.69, -12192.1, 28.0703, -0.610864, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101300, 1731, 530, 1, -2289.45, -12050.3, 27.3578, 0.350288, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101301, 1731, 530, 1, -2645.99, -11874.3, 4.17322, 4.11706, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101302, 1731, 530, 1, -2470.84, -12315.9, 17.1588, 5.84886, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101303, 1731, 530, 1, -2421.05, -12157.7, 33.0353, 1.56295, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101304, 1731, 530, 1, -2302.43, -12314.9, 35.2952, 5.16321, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101305, 1731, 530, 1, -2211.55, -12359.4, 50.3877, 4.78072, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (101306, 1731, 530, 1, -2149.17, -12373.4, 25.2237, 0.421762, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103101, 1731, 1, 1, -552, -4832, 36.636, 4.135, 0, 0, 0.879262, -0.476338, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103102, 1731, 1, 1, 1430.12, -4664.15, 46.1002, -0.418879, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103103, 1731, 1, 1, 5.7781, -4578.69, 53.9976, 0.314158, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103104, 1731, 1, 1, 835.805, -4055, -9, 3.073, 0, 0, 0.999408, 0.034417, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103105, 1731, 1, 1, 719.195, -4127, 1.455, 2.869, 0, 0, 0.990746, 0.135728, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103106, 1731, 1, 1, -300, -4851, 37.896, 3.004, 0, 0, 0.997643, 0.068625, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103107, 1731, 1, 1, -642, -5100, 21.157, 0.379, 0, 0, 0.18853, 0.982067, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103108, 1731, 1, 1, 517.774, -4761, 30.16, 0.785, 0, 0, 0.382683, 0.92388, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103109, 1731, 1, 1, 987.733, -4279.1, 20.6213, -2.02458, 0, 0, 0.848048, -0.529919, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103110, 1731, 1, 1, -666.219, -4858.36, 39.6105, 0.890118, 0, 0, 0.430511, 0.902585, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103111, 1731, 1, 1, -369.761, -5142.03, 25.3783, -0.174533, 0, 0, 0.087156, -0.996195, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103112, 1731, 1, 1, 733.337, -4104.11, -9.99905, 1.27409, 0, 0, 0.594823, 0.803857, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103113, 1731, 1, 1, 833.363, -4095.24, -12.8436, -1.09956, 0, 0, 0.522499, -0.85264, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103114, 1731, 1, 1, -145.402, -4681.56, 32.4146, 1.3439, 0, 0, 0.622515, 0.782608, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103115, 1731, 1, 1, 612.375, -4124.88, 25.6376, -1.18682, 0, 0, 0.559193, -0.829037, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103116, 1731, 1, 1, 972.06, -4718.87, 29.4653, 0, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103117, 1731, 1, 1, 590.341, -4278, 15.473, 1.777, 0, 0, 0.776019, 0.63071, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103118, 1731, 1, 1, 1067.8, -4590.99, 27.041, -2.74016, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103119, 1731, 1, 1, -817, -4629, 44.872, 3.991, 0, 0, 0.911245, -0.411865, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103120, 1731, 1, 1, 958.429, -4298, -6, 4.213, 0, 0, 0.859792, -0.510644, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103121, 1731, 1, 1, 1133.49, -4584.18, 28.9594, 2.79252, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103122, 1731, 1, 1, 801.919, -4835, 38.039, -3, 0, 0, -0.984808, 0.173648, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103123, 1731, 1, 1, 544.077, -4581.3, 49.0066, -2.18166, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103124, 1731, 1, 1, 418.688, -4938, 37.499, -1, 0, 0, -0.430511, 0.902585, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103125, 1731, 1, 1, 251.159, -3871.59, 39.2736, 0.331611, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103126, 1731, 1, 1, 951.524, -4226, -6, 2.417, 0, 0, 0.935001, 0.354646, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103127, 1731, 1, 1, 82.093, -4522, 70.473, 2.467, 0, 0, 0.943659, 0.330919, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103128, 1731, 1, 1, -708, -4690, 35.181, 6.181, 0, 0, 0.051245, -0.998686, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103129, 1731, 1, 1, 833.341, -4095, 25.37, -1, 0, 0, -0.522499, 0.85264, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103130, 1731, 1, 1, 1316.97, -4828.23, 24.0255, -0.575957, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103131, 1731, 1, 1, 71.799, -5185, -6, 1.129, 0, 0, 0.534839, 0.844954, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103132, 1731, 1, 1, 1509.55, -4858.73, 9.38298, 1.85, 0, 0, 0.798635, 0.601815, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103133, 1731, 1, 1, 1176.75, -4150.77, 21.4219, 2.96706, 0, 0, 0.996195, 0.087156, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103134, 1731, 1, 1, -940.237, -4518.29, 36.6469, -0.349066, 0, 0, 0.173648, -0.984808, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103135, 1731, 1, 1, 359.069, -5093.58, 12.6732, -0.506145, 0, 0, 0.25038, -0.968148, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103136, 1731, 1, 1, 701.043, -4386.61, 27.4552, 2.53073, 0, 0, 0.953717, 0.300706, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103137, 1731, 1, 1, 1181.44, -5106.4, 8.4284, -2.96706, 0, 0, 0.996195, -0.087156, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103138, 1731, 1, 1, 121.802, -4321.91, 60.3641, 1.44862, 0, 0, 0.66262, 0.748956, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103139, 1731, 1, 1, 31.9014, -4346.94, 76.9537, -1.32645, 0, 0, 0.615661, -0.788011, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103140, 1731, 1, 1, 932.9, -4749.66, 21.0103, -1.62316, 0, 0, 0.725374, -0.688354, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103141, 1731, 1, 1, 790.85, -3870.64, 21.5309, -2.33874, 0, 0, 0.920505, -0.390731, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103142, 1731, 1, 1, 1513.36, -4712.86, 12.2831, -0.418879, 0, 0, 0.207912, -0.978148, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103143, 1731, 1, 1, 620.868, -3887.83, 29.8135, 1.23918, 0, 0, 0.580703, 0.814116, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103144, 1731, 1, 1, 1316.97, -4828.23, 24.0255, -0.575959, 0, 0, 0.284015, -0.95882, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103145, 1731, 1, 1, -281.428, -4741.94, 39.3108, -2.70526, 0, 0, 0.976296, -0.21644, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103146, 1731, 1, 1, -111.012, -4599, 54.0679, -0.680679, 0, 0, 0.333807, -0.942641, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103147, 1731, 1, 1, -10.5625, -3934.51, 56.4291, -1.85005, 0, 0, 0.798635, -0.601815, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103148, 1731, 1, 1, 503.216, -3923.43, 23.0152, -2.80998, 0, 0, 0.986286, -0.165048, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103149, 1731, 1, 1, 58.4049, -4381.18, 74.8717, 0.383972, 0, 0, 0.190809, 0.981627, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103150, 1731, 1, 1, -111.785, -4017.52, 67.2261, -1.41372, 0, 0, 0.649448, -0.760406, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103151, 1731, 1, 1, -416.801, -4633.31, 50.701, -1.20428, 0, 0, 0.566406, -0.824126, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103152, 1731, 1, 1, -945.979, -4608.4, 25.5947, 0.296706, 0, 0, 0.147809, 0.989016, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103153, 1731, 1, 1, 1178.94, -4858.16, 24.753, 0.645772, 0, 0, 0.317305, 0.948324, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103154, 1731, 1, 1, 829.248, -4702.52, 12.2974, -2.21657, 0, 0, 0.894934, -0.446198, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103155, 1731, 1, 1, 877.604, -4602.6, 14.8535, -1.78024, 0, 0, 0.777146, -0.62932, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103156, 1731, 1, 1, 980.647, -4085.28, -5.86554, 0.383972, 0, 0, 0.190809, 0.981627, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103157, 1731, 1, 1, 1057.03, -4889.49, 25.6804, 1.46608, 0, 0, 0.669131, 0.743145, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103158, 1731, 1, 1, 1166.65, -4762.67, 22.9298, -0.2618, 0, 0, 0.130526, -0.991445, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103159, 1731, 1, 1, 1067.8, -4590.99, 27.041, -2.74017, 0, 0, 0.979925, -0.199368, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103160, 1731, 1, 1, -651.845, -5585.51, 12.682, 0.942478, 0, 0, 0.45399, 0.891007, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103161, 1731, 1, 1, 518.501, -4760.18, 29.9781, 0.785398, 0, 0, 0.382683, 0.92388, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103162, 1731, 1, 1, 1417.42, -4711.25, -0.304713, 0.541052, 0, 0, 0.267238, 0.96363, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103163, 1731, 1, 1, 1299.94, -4054.1, 39.2247, -0.20944, 0, 0, 0.104528, -0.994522, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103164, 1731, 1, 1, 793.832, -4771.2, 38.5628, -2.33874, 0, 0, 0.920505, -0.390731, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103165, 1731, 1, 1, 1465.41, -4865.19, 13.0559, 1.76278, 0, 0, 0.771625, 0.636078, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103166, 1731, 1, 1, 557.418, -3846.62, 30.4998, 2.35619, 0, 0, 0.92388, 0.382683, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103167, 1731, 1, 1, -303, -4871, 36.637, 0.932, 0, 0, 0.449502, 0.893279, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103168, 1731, 1, 1, 922.413, -4280, -5, 3.482, 0, 0, 0.985543, -0.169428, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103169, 1731, 1, 1, 1119.91, -4494, 20.438, 1.565, 0, 0, 0.704938, 0.709268, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103170, 1731, 1, 1, -993, -4497, 29.336, 2.604, 0, 0, 0.964043, 0.265746, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103171, 1731, 1, 1, -370, -5143, 25.101, 0, 0, 0, -0.087156, 0.996195, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103172, 1731, 1, 1, 871.858, -4230, -11, 3.379, 0, 0, 0.992971, -0.118355, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103173, 1731, 1, 1, 713.16, -4010.18, 9.61455, -0.698132, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103174, 1731, 1, 1, 1458.08, -4808, 11.859, -2, 0, 0, -0.85264, 0.522499, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103175, 1731, 1, 1, 765.985, -3999, 24.124, -3, 0, 0, 0.981627, -0.190809, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103176, 1731, 1, 1, -784, -5564, 16.693, 0.681, 0, 0, 0.333807, 0.942641, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103177, 1731, 1, 1, 919.19, -4031, -13, 4.714, 0, 0, 0.706456, -0.707757, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103178, 1731, 1, 1, 207.442, -3865, 45.509, 4.674, 0, 0, 0.720517, -0.693438, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103179, 1731, 1, 1, 1141.85, -4684, 17.7031, 5.94, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103180, 1731, 1, 1, -420, -4898, 59.501, 4.375, 0, 0, 0.81589, -0.578208, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103181, 1731, 1, 1, 24.325, -3989, 49.571, 3.016, 0, 0, 0.998045, 0.062506, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103182, 1731, 1, 1, 1117.3, -4850, 18.723, 2.619, 0, 0, 0.966114, 0.258117, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103183, 1731, 1, 1, 1417.42, -4711.25, -0.304713, 0.541051, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103184, 1731, 1, 1, 646.033, -4629, 11.574, 4.39, 0, 0, 0.811522, -0.584322, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103185, 1731, 1, 1, -877, -4736, 29.884, 1.937, 0, 0, 0.824126, 0.566406, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103186, 1731, 1, 1, 497.183, -4427, 47.452, 1.484, 0, 0, 0.67559, 0.737277, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103187, 1731, 1, 1, 647.757, -4755.22, 22.2529, -1.69297, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103188, 1731, 1, 1, 463.742, -4203, 26.989, 5.652, 0, 0, 0.31042, -0.9506, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103189, 1731, 1, 1, 193.139, -4449, 32.768, 1.497, 0, 0, 0.680605, 0.73265, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103190, 1731, 1, 1, 110.429, -4593.55, 69.8251, 2.75761, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103191, 1731, 1, 1, 1127.29, -4691.03, 19.824, -2.28638, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103192, 1731, 1, 1, 1178.94, -4858.16, 24.753, 0.645772, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103193, 1731, 1, 1, -507, -5222, 13.401, 5.888, 0, 0, 0.196252, -0.980553, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103194, 1731, 1, 1, 1466.95, -4775, 8.583, 0.244, 0, 0, 0.121869, 0.992546, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103195, 1731, 1, 1, 1199.76, -4642, 19.916, 3.019, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103196, 1731, 1, 1, -9, -4221, 94.547, 2.251, 0, 0, 0.902585, 0.430511, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103197, 1731, 1, 1, 37.761, -4547, 83.901, 2.107, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103198, 1731, 1, 1, 389.877, -4049, 38.833, 0, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103199, 1731, 1, 1, -297, -4870, 35.73, 1.833, 0, 0, 0.793363, 0.608748, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103200, 1731, 1, 1, -879, -4727, 29.001, 6.179, 0, 0, 0.051822, -0.998656, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103201, 1731, 1, 1, 751.688, -4683.93, 30.1805, 1.72787, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103202, 1731, 1, 1, 879.885, -3867.51, 34.1144, 2.82743, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103203, 1731, 1, 1, 1056.59, -4808.49, 21.7389, -2.04204, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103204, 1731, 1, 1, 900.322, -4608, 18.3222, 2.264, 0, 0, 0.905198, 0.424991, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103205, 1731, 1, 1, 945.301, -4123, -12, 3.856, 0, 0, 0.936927, -0.349526, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103206, 1731, 1, 1, -947, -4608, 25.595, 0.297, 0, 0, 0.147809, 0.989016, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103207, 1731, 1, 1, 791.334, -4036, -6, 3.273, 0, 0, 0.997842, -0.065666, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103208, 1731, 1, 1, 833.743, -4211, -1, 5.17, 0, 0, 0.528468, -0.848953, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103209, 1731, 1, 1, -317.643, -4847.5, 40.5401, -0.453785, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103210, 1731, 1, 1, 1177.25, -4769, 18.966, 0, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103211, 1731, 1, 1, -550, -4910, 45.558, 0, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103212, 1731, 1, 1, 546.318, -4874.02, 37.2483, -1.69297, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103213, 1731, 1, 1, 923.991, -3979, 27.253, -2, 0, 0, -0.913545, 0.406737, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103214, 1731, 1, 1, 712.542, -4512.38, 19.8831, -1.71042, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103215, 1731, 1, 1, 845.625, -4164.17, -8.82255, -0.994837, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103216, 1731, 1, 1, 358.909, -4596, 60.359, 4.485, 0, 0, 0.782814, -0.622256, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103217, 1731, 1, 1, 193.885, -4771, 14.324, 0.164, 0, 0, 0.081855, 0.996644, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103218, 1731, 1, 1, 188.034, -4793, 14.51, 3.147, 0, 0, 0.999997, -0.002613, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103219, 1731, 1, 1, -309, -5194, 22.23, 0, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103220, 1731, 1, 1, -710.721, -4951.73, 29.1461, 0.349065, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103221, 1731, 1, 1, -149.711, -5155.12, 22.047, 0.279, 0, 0, 0.139173, 0.990268, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103222, 1731, 1, 1, -999, -4500, 28.246, 0.698, 0, 0, 0.34202, 0.939693, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103223, 1731, 1, 1, 413.661, -4258.74, 32.9778, -1.39626, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103224, 1731, 1, 1, 356.217, -4973, 27.051, 6.106, 0, 0, 0.088544, -0.996072, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103225, 1731, 1, 1, 66.278, -4533, 66.611, 2.471, 0, 0, 0.94432, 0.329028, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103226, 1731, 1, 1, -325, -4856, 40.775, 1.292, 0, 0, 0.6018, 0.798647, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103227, 1731, 1, 1, 1241.87, -4940, 14.829, -3, 0, 0, -0.97237, 0.233445, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103228, 1731, 1, 1, -943, -5110, -9, 4.681, 0, 0, 0.71815, -0.695888, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103229, 1731, 1, 1, -605, -4948, 48.027, 4.451, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103230, 1731, 1, 1, 503.216, -3923.43, 23.0152, -2.80997, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103231, 1731, 1, 1, 1000.78, -4682, 33.097, 0.107, 0, 0, 0.053395, 0.998573, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103232, 1731, 1, 1, -1042, -4566, 45.508, 1.606, 0, 0, 0.71934, 0.694658, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103233, 1731, 1, 1, 418.566, -4941, 36.963, 1.789, 0, 0, 0.780015, 0.625761, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103234, 1731, 1, 1, -704, -4570, 41.348, 0.718, 0, 0, 0.351164, 0.936314, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103235, 1731, 1, 1, -618, -4501, 52.452, 3.17, 0, 0, 0.9999, -0.014173, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103236, 1731, 1, 1, -668, -4569, 65.216, 5.03, 0, 0, 0.586432, -0.809999, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103237, 1731, 1, 1, 837.491, -4754, 11.956, 5.68, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103238, 1731, 1, 1, 834.88, -4737, 11.114, 3.302, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103883, 1731, 1, 1, -807, -4645, 57.513, 4.33, 0, 0, 0.828612, -0.559824, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103884, 1731, 1, 1, 1041.65, -4731.42, 17.7684, -1.01229, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103885, 1731, 1, 1, 850.867, -4766.13, 38.2993, -1.0472, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103886, 1731, 1, 1, 931.159, -4703.13, 23.2867, 0.733038, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103887, 1731, 1, 1, -150.154, -5160.85, 25.5989, 0.279252, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103888, 1731, 1, 1, 11.737, -4641.79, 49.2284, 3.05433, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103889, 1731, 1, 1, -5.93815, -4229.33, 97.8519, 2.25147, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103890, 1731, 1, 1, 842.223, -4749.95, 12.749, -1.91986, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103891, 1731, 1, 1, 72.8817, -4528.48, 61.0341, -3.00195, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103892, 1731, 1, 1, 535.034, -4936.4, 37.0527, -0.820303, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103893, 1731, 1, 1, 847.784, -4206.12, -10.5332, 0.95993, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103894, 1731, 1, 1, 149.417, -5075.54, 16.1375, 0.034906, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103895, 1731, 1, 1, 598.039, -4543.84, 17.8262, 0.733038, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103896, 1731, 1, 1, 35.3273, -4101.95, 63.2919, -2.26892, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103897, 1731, 1, 1, -717.853, -4696.23, 37.8685, 2.42601, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103898, 1731, 1, 1, -982.906, -4436.19, 34.2814, 0.418879, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103899, 1731, 1, 1, 832.711, -4756.26, 38.3843, 2.42601, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103900, 1731, 1, 1, 873.399, -4743.74, 30.9023, 0.942477, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103901, 1731, 1, 1, 908.307, -4224.11, 26.1928, -3.03684, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103902, 1731, 1, 1, 73.9236, -4487.36, 50.8945, 0.802851, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103903, 1731, 1, 1, 1114.85, -4224.99, 28.0452, 0.541051, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103904, 1731, 1, 1, 894.402, -4080.42, 26.5511, 0.366518, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103905, 1731, 1, 1, 901.996, -4036.53, -11.3043, 0.645772, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103906, 1731, 1, 1, 947.336, -4220.51, -6.28864, -1.71042, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103907, 1731, 1, 1, 798.026, -4046.3, -1.21654, 3.03684, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103908, 1731, 1, 1, 1071.53, -3948.96, 24.9357, -2.75761, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103909, 1731, 1, 1, 1213.05, -4591.97, 23.571, 2.05949, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103910, 1731, 1, 1, 1200.46, -4646.21, 23.5411, 3.01941, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103911, 1731, 1, 1, 966.096, -4906.56, 28.7647, -2.00713, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103912, 1731, 1, 1, 955.784, -4045.23, -11.4768, -2.35619, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103913, 1731, 1, 1, 1242.78, -4948.08, 16.0424, -2.67035, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103914, 1731, 1, 1, 1459.55, -4745.43, -0.996877, -2.00713, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103915, 1731, 1, 1, 1562.55, -4769.49, 15.478, -0.279252, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103916, 1731, 1, 1, 1464.22, -4891.54, 14.0545, 0.296705, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103917, 1731, 1, 1, 1488.58, -4816.56, 9.27292, 1.0821, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (103918, 1731, 1, 1, 1517.21, -4965.98, 11.4182, -0.837757, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104521, 1731, 1, 1, -686.463, -243.221, -4.68434, -1.72787, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104522, 1731, 1, 1, -441.273, -634.283, 68.3678, 1.55334, 0, 0, 0.700909, 0.71325, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104523, 1731, 1, 1, -2160.77, 246.023, 85.1964, 2.02458, 0, 0, 0.848048, 0.529919, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104524, 1731, 1, 1, -1554.69, -1083.31, 105.707, -1.64061, 0, 0, 0.731354, -0.681998, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104525, 1731, 1, 1, -1598.59, -1179.21, 143.803, 1.48353, 0, 0, 0.67559, 0.737277, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104526, 1731, 1, 1, -1716.2, -1252.96, 114.492, -2.54818, 0, 0, 0.956305, -0.292372, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104527, 1731, 1, 1, -2378.36, 391.934, 66.0987, 2.74017, 0, 0, 0.979925, 0.199368, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104528, 1731, 1, 1, -2126.26, 342.359, 137.839, 0.20944, 0, 0, 0.104528, 0.994522, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104529, 1731, 1, 1, -2395.6, 455.132, 74.6857, 2.02458, 0, 0, 0.848048, 0.529919, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104530, 1731, 1, 1, -2834.42, -829.513, 28.5204, 0.977384, 0, 0, 0.469472, 0.882948, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104531, 1731, 1, 1, -500.561, -67.4469, 72.3764, -2.40855, 0, 0, 0.93358, -0.358368, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104532, 1731, 1, 1, -2658.35, -1470.27, 80.4637, -2.53073, 0, 0, 0.953717, -0.300706, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104533, 1731, 1, 1, -2658.6, 257.63, 96.5652, 2.26893, 0, 0, 0.906308, 0.422618, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104534, 1731, 1, 1, -3006.23, 277.98, 111.43, -2.28638, 0, 0, 0.909961, -0.414693, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104535, 1731, 1, 1, -503.832, -529.76, 72.2556, 0.575959, 0, 0, 0.284015, 0.95882, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104536, 1731, 1, 1, -2412.37, 503.889, 64.3131, 4.71239, 0, 0, 0.707107, -0.707107, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104537, 1731, 1, 1, -2299.02, 385.609, 58.3093, 2.67035, 0, 0, 0.97237, 0.233445, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104538, 1731, 1, 1, -1731.5, 446.03, 104.992, 1.50098, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104539, 1731, 1, 1, -2745.81, -1099.56, 34.6196, -2.68781, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104540, 1731, 1, 1, -759.502, -750.369, 19.4819, 2.51327, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104541, 1731, 1, 1, -1084.01, -1189.03, 74.0368, -2.02458, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104542, 1731, 1, 1, -2316.38, 421.633, 49.3617, -3.12412, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104543, 1731, 1, 1, -2266.06, 324.555, 114.628, 2.44346, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104544, 1731, 1, 1, -1348.19, -948.489, 25.8795, -2.61799, 0, 0, 0.965926, -0.258819, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104545, 1731, 1, 1, -1810.58, -1214.9, 108.548, -0.488692, 0, 0, 0.241922, -0.970296, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104546, 1731, 1, 1, -1648.13, -1087.61, 127.155, 2.46091, 0, 0, 0.942641, 0.333807, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104547, 1731, 1, 1, -1271.72, -1073.83, 57.5627, 0, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104548, 1731, 1, 1, -1301.52, -1039.44, 61.9713, -2.84489, 0, 0, 0.989016, -0.147809, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104549, 1731, 1, 1, -1745.35, -912.952, 88.8484, -0.575959, 0, 0, 0.284015, -0.95882, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104550, 1731, 1, 1, -2415.56, 352.934, 65.7179, -2.77507, 0, 0, 0.983255, -0.182235, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104551, 1731, 1, 1, -2881.33, 355.126, 127.839, 0.10472, 0, 0, 0.052336, 0.99863, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104552, 1731, 1, 1, -1486.76, -1196.38, 129.623, -1.46608, 0, 0, 0.669131, -0.743145, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104553, 1731, 1, 1, -1382.94, -1171.94, 163.176, -0.942478, 0, 0, 0.453991, -0.891006, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104554, 1731, 1, 1, -2290.48, 262.298, 84.6144, -0.872665, 0, 0, 0.422618, -0.906308, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104555, 1731, 1, 1, -2820.62, -438.43, 24.2419, -0.977384, 0, 0, 0.469472, -0.882948, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104556, 1731, 1, 1, -2089, -1113, 38.546, 5.599, 0, 0, 0.33526, -0.942126, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104557, 1731, 1, 1, -516, 78.965, 61.133, 1.449, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104558, 1731, 1, 1, -2037, 299.28, 127.223, 0.336, 0, 0, 0.16728, 0.985909, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104559, 1731, 1, 1, -1118, -485, -40, 0, 0, 0, -0.207912, 0.978148, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104560, 1731, 1, 1, -961, -183, 22.172, 0.454, 0, 0, 0.224951, 0.97437, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104561, 1731, 1, 1, -2508.05, -1484.73, 67.8085, -1.76278, 0, 0, 0.771625, -0.636078, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104562, 1731, 1, 1, -758.024, 151.076, 19.3412, -1.72788, 0, 0, 0.760406, -0.649448, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104563, 1731, 1, 1, -840.207, 175.43, -2.1451, -0.820303, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104564, 1731, 1, 1, -2716.08, -1351.25, 54.7605, 0.10472, 0, 0, 0.052336, 0.99863, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104565, 1731, 1, 1, -2169.64, -1179.78, 39.1276, -2.77507, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104566, 1731, 1, 1, -3003, 269.918, 104.591, 2.859, 0, 0, 0.990066, 0.140601, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104567, 1731, 1, 1, -2437, -1487, 38.715, 0.698, 0, 0, 0.34202, 0.939693, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104568, 1731, 1, 1, -2587, -1468, 107.091, 1.564, 0, 0, 0.70483, 0.709376, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104569, 1731, 1, 1, -615.527, -775.294, 56.9064, 1.41372, 0, 0, 0.649448, 0.760406, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104570, 1731, 1, 1, -1385.24, -1081.32, 142.678, 2.67035, 0, 0, 0.97237, 0.233445, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104571, 1731, 1, 1, -1541.22, -991.637, 154.309, -1.8675, 0, 0, 0.803857, -0.594823, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104572, 1731, 1, 1, -1413.5, -1023.59, 142.286, 0.715585, 0, 0, 0.350207, 0.936672, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104573, 1731, 1, 1, -1583, 276.251, 22.789, -2, 0, 0, -0.902585, 0.430511, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104574, 1731, 1, 1, -1594, -874, 37.908, 2.723, 0, 0, 0.978148, 0.207912, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104575, 1731, 1, 1, -2673, 343.263, 137.52, -1, 0, 0, -0.446198, 0.894934, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104576, 1731, 1, 1, -2808, -792, 18.084, 1.917, 0, 0, 0.818442, 0.574589, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104577, 1731, 1, 1, -1844.6, -1004.5, 84.088, 2.74017, 0, 0, 0.979925, 0.199368, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104578, 1731, 1, 1, -713, -763, 44.168, -2, 0, 0, -0.681998, 0.731354, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104579, 1731, 1, 1, -2762, -634, 19.881, 0.541, 0, 0, 0.267238, 0.96363, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104580, 1731, 1, 1, -2806, -144, 22.177, 4.521, 0, 0, 0.771557, -0.636161, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104581, 1731, 1, 1, -815.609, -868.47, 26.8822, -2.84489, 0, 0, 0.989016, -0.147809, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104582, 1731, 1, 1, -2766.59, -204.171, 22.2618, 1.41372, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (104583, 1731, 1, 1, -2000.81, -1117.73, 83.8292, -0.453786, 0, 0, 0.224951, -0.97437, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105151, 1731, 0, 1, 2196.57, -500.417, 86.2787, -0.488691, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105152, 1731, 0, 1, 2673.29, -772.678, 85.4531, -0.418879, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105153, 1731, 0, 1, 2202.98, -65.3898, 30.8705, -2.75761, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105154, 1731, 0, 1, 2646.08, 1350.02, 9.43725, -1.67551, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105155, 1731, 0, 1, 1727.84, 808.579, 68.0469, -1.55334, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105156, 1731, 0, 1, 2371.46, -634.19, 68.5649, -0.628317, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105157, 1731, 0, 1, 1633.95, -687.568, 47.3942, -3.01941, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105158, 1731, 0, 1, 1781.53, -748.291, 63.1568, 2.00713, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105159, 1731, 0, 1, 1814.78, -141.659, 49.7266, 3.05433, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (105308, 1731, 0, 1, 1790.83, 884.56, 33.848, 2.304, 0, 0, 0, 0, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (108722, 1731, 1, 1, -1558.8, -1308.79, 135.994, -0.20944, 0, 0, 0.104528, -0.994522, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (110221, 1731, 1, 1, -959.687, -189.309, 25.0983, 0.453785, 0, 0, 0, 1, 7200, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (111262, 1731, 530, 1, -3584.34, -11828.8, 11.2678, 2.30383, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (111263, 1731, 530, 1, -2997.91, -12274.1, 17.2133, 0.191985, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (111264, 1731, 530, 1, -3208.36, -12254.1, 57.0038, -0.680679, 0, 0, 0, 1, 60, 255, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (111265, 1731, 530, 1, -4095.92, -11588.5, 19.9823, -1.78023, 0, 0, 0, 1, 60, 255, 1);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (61958, 181557, 556, 3, 24.3, 114.706, 0.058363, -1.58825, 0, 0, 0, 1, 86400, 100, 1);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES (61959, 181557, 546, 3, -25.0788, -95.4667, -4.53427, -0.855211, 0, 0, -0.414693, 0.909961, 86400, 100, 1);

DELETE FROM `gameobject_loot_template` WHERE `entry` = 18363 AND `item` = 12363;
-- INSERT INTO `gameobject_loot_template` VALUES
-- (18363,12363,2,0,1,1,0,0,0);

-- Port Stones Maxlevel to 70
UPDATE `gameobject_template` SET `data1`='70' WHERE `type` = 23;

DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-1240','-1241','-1242','-1243','-1244');
INSERT INTO `creature_ai_texts` VALUES
(-1240,'Arak-ha!',NULL,NULL,'Arak-ha!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Sethekk Halls'),
(-1241,'Protect the Veil!',NULL,NULL,'Beschützt das Versteck!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Sethekk Halls'),
(-1242,'Darkfire -- avenge us!',NULL,NULL,'Klauenkönig Ikiss wird uns rächen!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Sethekk Halls'),
(-1243,'Ssssekk-sara Rith-nealaak!',NULL,NULL,'Ssssekk-sara Rith-nealaak!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Sethekk Halls'),
(-1244,'In Terokk\'s name!',NULL,NULL,'Im Namen von Terokk!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Sethekk Halls');

-- -9200 - -9299
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9200','-9201','-9202','-9203','-9204','-9205','-9206','-9207','-9208','-9209','-9210','-9211','-9212','-9213','-9214','-9215','-9216','-9217','-9218','-9219');
INSERT INTO `creature_ai_texts` VALUES
(-9200,'Death to our enemies!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21644 on Aggro'),
(-9201,'You\'ll go nowhere, Skyguard scum!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21644 on Aggro'),
(-9202,'Skettis prevails!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9203,'No one escapes Skettis!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21644 on Aggro'),
(-9204,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9205,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9206,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9207,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9208,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9209,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9210,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9211,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9212,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9213,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9214,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9215,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9216,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9217,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9218,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder'),
(-9219,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TerokkarPlaceholder');

-- pvp daily quests
update `quest_template` set `RewHonorableKills` = 24, `RewMoneyMaxLevel` = 155999 where `entry` between 11335 and 11342;
