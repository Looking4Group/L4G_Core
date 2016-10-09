-- Saltgurka
 
-- ----------------------------------------------------------
-- Stuff that's not from the bugtracker
-- ----------------------------------------------------------
 
-- Stop random movement from leokk and move his spawnpint slightly upwards, to prevent him from glitching out of his cage.
UPDATE `creature` SET `MovementType` = 0, `position_x` = 3675.989990, `position_y` = 5279.689941, `position_z` = 20.849602 WHERE guid = 78289;

-- Stop sitting ogres from moving randomly.
-- MovementType = 0 = Spawndist = 0;
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE  `guid`=71411;
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE  `guid`=71428;
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE  `guid`=71426;
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE  `guid`=71461;

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/1087
-- Translate NPC names to English in Hall of Legends and Champion's Hall
-- ----------------------------------------------------------
UPDATE `creature_template` SET `name`='Lady Palanseer', `subname`='Armor Quartermaster' WHERE entry = 1200054;
UPDATE `creature_template` SET `name`='Sergeant Thunderhorn', `subname`='Weapons Quartermaster' WHERE  `entry`=1200055;
UPDATE `creature_template` SET `name`='Vixton Pinchwhistle' WHERE  `entry`=1200050;
UPDATE `creature_template` SET `name`='Captain O\'Neal', `subname`='Weapons Quartermaster' WHERE  `entry`=1200053;
UPDATE `creature_template` SET `name`='Captain Dirgehammer', `subname`='Armor Quartermaster' WHERE  `entry`=1200052;

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/1745
-- Thrallmar Wolf Rider spells, waypoints and formations
-- ----------------------------------------------------------
-- Increase speed for Thrallmar Wolf Riders. They're supposed to be very fast (https://www.youtube.com/watch?v=F1Pd-UVF20I)
-- Add missing spells. I made the casts pretty random since you will always fight 4 mobs at a time. Scaling seems about right, they are a challenge for lvl 60s.
UPDATE `creature_template` SET `speed`=2, `AIName`='EventAI' WHERE  `entry`=16599;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '16599';
INSERT INTO `creature_ai_scripts` VALUES
('1659901','16599','4','0','100','1','0','0','0','0','11','18396','1','0','17','154','0','0','19','134217728','0','0','Thrallmar Wolf Rider - Cast Dismounting Blast and Dismount on Aggro'),
('1659902','16599','0','0','100','1','8500','8500','15000','15000','11','19643','1','0','0','0','0','0','0','0','0','0','Thrallmar Wolf Rider - Cast Mortal Strike'),
('1659903','16599','0','0','100','1','3500','5500','10000','12000','11','15618','1','0','0','0','0','0','0','0','0','0','Thrallmar Wolf Rider - Cast Snap Kick'), -- see problem with more melee abilies on range lair brutes, only use with different range values, i suggest having a look at acid scripts eventhough they start to differ alot from our stats now with the dynamic movement, which even robinsch thinks its not so good thing.
('1659904','16599','7','0','100','1','0','0','0','0','43','17408','0','0','0','0','0','0','0','0','0','0','Thrallmar Wolf Rider - Mount on Evade');

-- Change spawnpoint to be the same spot as first waypoint
UPDATE `creature` SET `position_x` = 196.28, `position_y` = 2781.241, `position_z` = 115.9637, `spawndist`=0 WHERE `guid` BETWEEN 57594 AND 57597; -- Change spawnpoint to be the same spot as first waypoint

SET @GUID := 57594; -- y not use it? :P and be cautious with SET XYZ because if you mess this part up you can wreck the db

-- MovementType = 0 = Spawndist = 0;
UPDATE `creature` SET `MovementType` = 0, `spawndist` = 0 WHERE `guid` BETWEEN 57595 AND 57597; -- MovementType 0, since they will follow their formation leader
DELETE FROM `creature_addon` WHERE `guid` BETWEEN 57595 AND 57597; -- Remove formation members from creature_addon, kind of false logic they just have all a seperate movement script, no group behavior

-- Create formations
DELETE FROM `creature_formations` WHERE `leaderguid` = @GUID;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(57594, 57594, 0, 0, 1),
(57594, 57595, 4, 0, 2),
(57594, 57596, 8, 0, 2),
(57594, 57597, 12, 0, 2);
 
-- Waypoints for Thrallmar Wolf Rider Entry: 16599
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=196.28,`position_y`=2781.241,`position_z`=115.9637 WHERE `guid`= @GUID;
DELETE FROM `creature_addon` WHERE `guid`= @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,14334,0,1,0,''); -- bytes values are still kinda mistery to me.
DELETE FROM `waypoint_data` WHERE `id`= @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,196.28,2781.241,115.9637,0,1,0,100,0),
(@GUID,2,173.7009,2773.865,111.0617,0,1,0,100,0),
(@GUID,3,144.2007,2764.989,105.126,0,1,0,100,0),
(@GUID,4,113.7401,2748.569,96.21298,0,1,0,100,0),
(@GUID,5,94.41273,2728.12,89.81252,0,1,0,100,0),
(@GUID,6,65.77112,2693.39,82.38187,0,1,0,100,0),
(@GUID,7,36.76459,2661.932,76.78915,0,1,0,100,0),
(@GUID,8,17.91903,2638.404,72.61198,0,1,0,100,0),
(@GUID,9,5.355525,2605.847,68.47747,0,1,0,100,0),
(@GUID,10,8.97837,2575.031,65.2146,0,1,0,100,0),
(@GUID,11,18.05011,2542.307,61.65181,0,1,0,100,0),
(@GUID,12,20.63871,2501.002,57.12801,0,1,0,100,0),
(@GUID,13,14.14331,2460.918,53.1017,0,1,0,100,0),
(@GUID,14,7.45386,2419.164,52.73537,0,1,0,100,0),
(@GUID,15,-14.25867,2395.82,52.69493,0,1,0,100,0),
(@GUID,16,-31.19849,2384.302,53.77038,0,1,0,100,0),
(@GUID,17,0.05626106,2409.986,52.19868,0,1,0,100,0),
(@GUID,18,13.30882,2456.084,52.34318,0,1,0,100,0),
(@GUID,19,20.00414,2492.995,56.18382,0,1,0,100,0),
(@GUID,20,19.18841,2536.792,60.81985,0,1,0,100,0),
(@GUID,21,11.05238,2567.616,64.15677,0,1,0,100,0),
(@GUID,22,4.750309,2601.44,67.78731,0,1,0,100,0),
(@GUID,23,13.32799,2630.8,71.16357,0,1,0,100,0),
(@GUID,24,32.40791,2656.75,75.65665,0,1,0,100,0),
(@GUID,25,62.52131,2689.98,81.53972,0,1,0,100,0),
(@GUID,26,92.98247,2726.685,89.31989,0,1,0,100,0),
(@GUID,27,109.4178,2744.999,94.76643,0,1,0,100,0),
(@GUID,28,142.0419,2764.24,104.1994,0,1,0,100,0),
(@GUID,29,171.1686,2772.708,110.2985,0,1,0,100,0);

-- http://www.wowhead.com/npc=16599/thrallmar-wolf-rider

-- Set correct HP for Thrallmar Grunts (source: http://web.archive.org/web/20101121125136/http://www.wowhead.com/npc=16580)
UPDATE `creature_template` SET `minhealth`=9156, `maxhealth`=9156 WHERE  `entry`=16580; 

-- Change Dismounting Blast to be cast on Aggro. Anon, you wrote that you didn't do it on aggro on purpose, because the spell doesn't 100% dismount. Well in fact the spell works 0% of the time, so IMO it makes more sense to have them use it on aggro, since more casts will not change anything.
-- If you disagree, you can leave this out. not the spell dismounts that is right but the player has a chance to getting dazed which dismounts him but yea should be on aggro only when it works
UPDATE `creature_ai_scripts` SET `event_type`=4, `event_flags` = 0, `event_param2`=0, `event_param3`=0, `event_param4`=0, `comment`='Thrallmar Grunt - Cast Dismounting Blast on Aggro' WHERE  `id` IN (1658001,2048701);
UPDATE `creature_ai_scripts` SET `event_type`=4, `event_flags` = 0, `event_param2`=0, `event_param3`=0, `event_param4`=0, `comment`='Honor Hold Defender - Cast Dismounting Blast on Aggro' WHERE  `id` IN (1684201,2051301);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20237;

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/775
-- Thrallmar Grunts waypoints and formations
-- ---------------------------------------------------------- 
 
-- Pathing and formation for Thrallmar Grunt Entry: 16580  GUIDs: 57528, 57527
DELETE FROM `creature_formations` WHERE `leaderGUID`=57528;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(57528, 57528, 0, 0, 2),
(57528, 57527, 3, 90, 2);
 
SET @NPC := 57528;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=132.3433,`position_y`=2762.987,`position_z`=102.3826 WHERE `guid`=@NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=132.3433,`position_y`=2762.987,`position_z`=102.3826 WHERE `guid`='57527';
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@NPC,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@NPC;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC,1,132.3433, 2762.987, 102.3826,0,0,0,100,0),
(@NPC,2,121.0521,2749.356,98.25848,0,0,0,100,0),
(@NPC,3,109.0274,2741.556,94.49025,0,0,0,100,0),
(@NPC,4,95.7988,2726.423,89.95798,0,0,0,100,0),
(@NPC,5,83.33932,2712.466,86.36182,0,0,0,100,0),
(@NPC,6,75.62203,2702.179,84.19798,0,0,0,100,0),
(@NPC,7,68.19456,2688.539,81.85039,0,0,0,100,0),
(@NPC,8,63.5472, 2683.4970, 80.4783,0,0,0,100,0),
(@NPC,9,82.17162,2678.548,81.62874,0,0,0,100,0),
(@NPC,10,96.37463,2678.292,82.75209,0,0,0,100,0),
(@NPC,11,112.1558,2676.275,83.38298,0,0,0,100,0),
(@NPC,12,119.6769,2675.056,83.7209,0,0,0,100,0),
(@NPC,13,111.278,2648.706,80.93124,0,0,0,100,0),
(@NPC,14,109.0044,2646.347,80.20769,0,0,0,100,0),
(@NPC,15,116.2792,2653.762,81.89182,0,0,0,100,0),
(@NPC,16,122.4159,2660.933,84.18261,0,0,0,100,0),
(@NPC,17,123.3134,2662.276,84.17096,0,0,0,100,0),
(@NPC,18,103.6847,2670.964,83.00417,0,0,0,100,0),
(@NPC,19,80.54628,2673.75,81.59075,0,0,0,100,0),
(@NPC,20,73.74189, 2676.277, 80.69298,0,0,0,100,0),
(@NPC,21,63.5472, 2683.4970, 80.4783,0,0,0,100,0),
(@NPC,22,69.13676, 2697.863, 83.02922,0,0,0,100,0),
(@NPC,23,75.02055,2712.901,85.39117,0,0,0,100,0),
(@NPC,24,87.82365,2724.378,88.41669,0,0,0,100,0),
(@NPC,25,104.5768,2742.848,93.40324,0,0,0,100,0),
(@NPC,26,117.3608,2752.192,97.77188,0,0,0,100,0),
(@NPC,27,129.486,2763.919,102.3025,0,0,0,100,0); 
 
-- Pathing and formations for Thrallmar Grunt Entry: 16580 GUIDs: 57506, 57507 
DELETE FROM `creature_formations` WHERE `leaderGUID`=57506;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(57506, 57506, 0, 0, 2),
(57506, 57507, 3, 90, 2);
 
SET @NPC := 57506;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=160.0679,`position_y`=2783.137,`position_z`=111.3373 WHERE `guid`=@NPC;
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=160.0679,`position_y`=2783.137,`position_z`=111.3373 WHERE `guid`='57507';
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@NPC,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@NPC;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC,1,160.0679,2783.137,111.3373,0,0,0,100,0),
(@NPC,2,162.4358,2778.617,110.5461,0,0,0,100,0),
(@NPC,3,172.7094,2774.508,110.6423,0,0,0,100,0),
(@NPC,4,186.6513,2777.03,113.5835,0,0,0,100,0),
(@NPC,5,200.0523,2782.693,116.7996,0,0,0,100,0),
(@NPC,6,209.4241,2784.837,118.5891,0,0,0,100,0),
(@NPC,7,222.8512,2785.429,121.0061,0,0,0,100,0),
(@NPC,8,233.1155,2787.613,123.6816,0,0,0,100,0),
(@NPC,9,237.861,2791.877,125.6136,0,0,0,100,0),
(@NPC,10,239.1323,2799.748,127.3235,0,0,0,100,0),
(@NPC,11,239.1207,2795.199,126.621,0,0,0,100,0),
(@NPC,12,235.6156,2789.706,124.6459,0,0,0,100,0),
(@NPC,13,227.0757,2786.192,122.1876,0,0,0,100,0),
(@NPC,14,212.622,2785.389,119.2345,0,0,0,100,0),
(@NPC,15,205.132,2784.269,117.806,0,0,0,100,0),
(@NPC,16,188.0606,2777.626,114.1675,0,0,0,100,0),
(@NPC,17,175.7908,2774.627,111.4541,0,0,0,100,0),
(@NPC,18,168.39,2775.401,110.4383,0,0,0,100,0),
(@NPC,19,160.1083,2782.976,111.366,0,0,0,100,0); 
 
-- Path for Thrallmar Grunt GUID: 57505 
SET @NPC := 57505;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=218.0770,`position_y`=2694.1625,`position_z`=91.1763 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@NPC,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@NPC;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC,1,218.0770,2694.1625,91.1763,0,0,0,100,0),
(@NPC,2,224.9998,2680.4279,90.6995,0,0,0,100,0),
(@NPC,3,244.4257,2681.7155,90.7033,0,0,0,100,0),
(@NPC,4,254.9327,2692.3100,90.7033,0,0,0,100,0),
(@NPC,5,252.2106,2706.0104,90.7035,0,0,0,100,0),
(@NPC,6,241.8701,2712.4443,90.7035,0,0,0,100,0),
(@NPC,7,223.4116,2710.1625,90.6950,0,0,0,100,0),
(@NPC,8,217.7516,2697.1372,90.6998,0,0,0,100,0),
(@NPC,9,189.2095,2690.3569,88.6209,0,0,0,100,0),
(@NPC,10,170.9556,2675.8039,86.3324,0,0,0,100,0),
(@NPC,11,176.1528,2631.4272,86.8991,0,0,0,100,0),
(@NPC,12,185.4241,2617.4987,87.2838,0,0,0,100,0),
(@NPC,13,182.6744,2606.1511,87.2838,0,0,0,100,0),
(@NPC,14,186.8166,2599.0705,87.2838,0,0,0,100,0),
(@NPC,15,193.7652,2597.8908,87.2838,0,0,0,100,0),
(@NPC,16,202.7697,2607.0363,87.2838,0,0,0,100,0),
(@NPC,17,198.6081,2616.2170,87.2838,0,0,0,100,0),
(@NPC,18,183.5041,2620.6555,87.4222,0,0,0,100,0),
(@NPC,19,158.6466,2653.3059,86.2131,0,0,0,100,0),
(@NPC,20,168.5774,2683.7739,85.5311,0,0,0,100,0),
(@NPC,21,195.5000,2691.1550,90.7037,0,0,0,100,0);

-- Set correct HP for Thrallmar Peon. (Source: http://wayback.archive.org/web/20101122161424/http://www.wowhead.com/npc=16591/thrallmar-peon)
-- Add missing spells to Thrallmar Peon (http://www.wowhead.com/npc=16591/thrallmar-peon#abilities)
UPDATE `creature_template` SET `minhealth`=2215, `maxhealth`=2292, `AIName`='EventAI' WHERE  `entry`=16591;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '16591';
INSERT INTO `creature_ai_scripts` VALUES
('1659101','16591','0','0','100','1','8500','8500','15000','15000','11','19643','1','0','0','0','0','0','0','0','0','0','Thrallmar Peon - Cast Mortal Strike'),
('1659102','16591','0','0','100','1','3500','5500','10000','12000','11','15618','1','0','0','0','0','0','0','0','0','0','Thrallmar Peon - Cast Snap Kick');
  
-- Pathing for Thrallmar Peon Entry: 16591 GUID: 57575
SET @NPC := 57575;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=55.27306,`position_y`=2654.043,`position_z`=78.42071 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@NPC,0,0,1,69, '');
DELETE FROM `waypoint_data` WHERE `id`=@NPC;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@NPC,1,55.27306,2654.043,78.42071,0,0,1000,100,0),
(@NPC,2,60.95808,2657.462,79.7836,0,0,0,100,0),
(@NPC,3,64.60378,2660.895,80.497,0,0,0,100,0),
(@NPC,4,66.75615,2663.12,80.74207,0,0,0,100,0),
(@NPC,5,65.12799,2682.579,80.74263,0,0,0,100,0),
(@NPC,6,65.82681,2693.285,82.36795,0,0,0,100,0),
(@NPC,7,75.21483,2707.858,84.6664,0,0,0,100,0),
(@NPC,8,84.96182,2718.535,87.05235,0,0,0,100,0),
(@NPC,9,95.03929,2728.742,90.13913,0,0,0,100,0),
(@NPC,10,106.4619,2744.316,94.00992,0,0,0,100,0),
(@NPC,11,123.8118,2755.292,99.37874,0,0,0,100,0),
(@NPC,12,135.8948,2760.833,102.7533,0,0,0,100,0),
(@NPC,13,155.0525,2769.579,107.7352,0,0,0,100,0),
(@NPC,14,158.3794,2773.243,108.8904,0,0,0,100,0),
(@NPC,15,159.9402,2783.268,111.4848,0,0,0,100,0),
(@NPC,16,161.3573,2786.643,112.5604,0,0,0,100,0),
(@NPC,17,165.1619, 2790.098, 113.5347,120000,0,1069,100,0),
(@NPC,18,161.6743, 2781.431, 111.1523,0,0,1000,100,0),
(@NPC,19,165.2408, 2775.052, 109.6661,0,0,0,100,0),
(@NPC,20,161.0955,2772.586,109.2963,0,0,0,100,0),
(@NPC,21,143.7382,2764.468,104.6033,0,0,0,100,0),
(@NPC,22,122.8,2754.483,99.03847,0,0,0,100,0),
(@NPC,23,109.0177,2745.05,94.75985,0,0,0,100,0),
(@NPC,24,96.74924,2729.785,90.4996,0,0,0,100,0),
(@NPC,25,83.87657,2715.537,86.72665,0,0,0,100,0),
(@NPC,26,75.78943,2705.43,84.61099,0,0,0,100,0),
(@NPC,27,64.73528,2690.525,81.81812,0,0,0,100,0),
(@NPC,28,62.68444,2679.1,80.26672,0,0,0,100,0),
(@NPC,29,62.20171,2674.227,80.11406,0,0,0,100,0),
(@NPC,30,62.53893,2659.067,79.85791,0,0,0,100,0),
(@NPC,31,53.87121,2650.147,77.64667,0,0,0,100,0),
(@NPC,32,52.78874,2648.066,76.98107,120000,0,1069,100,0);

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/775
-- Overseer Nuaar, waypoints already existed, only needed to change MovementType, spawndist and spawnpoint. I assune this was mistakenly changed at some point?
-- ----------------------------------------------------------
UPDATE `creature` SET `MovementType`=2,`spawndist`=0,`position_x`=3448.69, `position_y`=5434.72, `position_z`=142.871 WHERE `guid`=76771;

-- Abaddon

UPDATE `game_event` SET `length` = 23040 WHERE `entry` = 26; -- old: 20160 changed from 14days to 16days

UPDATE `game_event` SET `start_time`='2016-10-05 18:00:00', `occurence`='360', `length`='5' WHERE `entry` = 34;  -- every 6h vl70ETC playing 5mins infront of shat

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (37951,37989,37987,37991);
INSERT INTO `creature_linked_respawn` VALUES
(37951,93846),
(37989,93846),
(37987,93846),
(37991,93846);

-- Gekirin

-- increase tidewalker damage by 15 %
update creature_template set mindmg = 16173, maxdmg = 19207 where entry = 21213;

-- Anonx

UPDATE `gameobject` SET `spawntimesecs` = 600 WHERE `id` = 185877; -- 2100
UPDATE `pool_template` SET `max_limit` = 10, `description` = 'Master Mineral Pool - Shadowmoon Valley (Nethercite Deposit Spawns)' WHERE `entry` = 2069; -- 25
DELETE FROM `pool_gameobject` WHERE `pool_entry` = 2069;
INSERT INTO `pool_gameobject` VALUES
(3481871,2069,0,'Nethercite Deposit'),
(3484816,2069,0,'Nethercite Deposit'),
(3484853,2069,0,'Nethercite Deposit'),
(3484984,2069,0,'Nethercite Deposit'),
(3485057,2069,0,'Nethercite Deposit'),
(3485206,2069,0,'Nethercite Deposit'),
(3485484,2069,0,'Nethercite Deposit'),
(3494224,2069,0,'Nethercite Deposit'),
(3494277,2069,0,'Nethercite Deposit'),
(3494304,2069,0,'Nethercite Deposit'),
(3494412,2069,0,'Nethercite Deposit'),
(3494453,2069,0,'Nethercite Deposit'),
(3494456,2069,0,'Nethercite Deposit'),
(3494559,2069,0,'Nethercite Deposit'),
(3494698,2069,0,'Nethercite Deposit'),
(3495652,2069,0,'Nethercite Deposit'),
(3495653,2069,0,'Nethercite Deposit'),
(3495654,2069,0,'Nethercite Deposit'),
(3495655,2069,0,'Nethercite Deposit'),
(3495656,2069,0,'Nethercite Deposit'),
(3495657,2069,0,'Nethercite Deposit'),
(3495658,2069,0,'Nethercite Deposit'),
(3495659,2069,0,'Nethercite Deposit'),
(3495660,2069,0,'Nethercite Deposit');

UPDATE `gameobject` SET `spawntimesecs` = 600 WHERE `id` = 185881; -- 2100
DELETE FROM `pool_template` WHERE `entry` = 2070;
INSERT INTO `pool_template` VALUES
(2070,10,'Master Mineral Pool - Shadowmoon Valley (Netherdust Bush Spawns)');
UPDATE `pool_gameobject` SET `pool_entry` = 2070 WHERE `pool_entry` = 50000;
DELETE FROM `pool_template` WHERE `entry` = 50000;

-- Netherwing Egg Trap (Gas)
UPDATE `gameobject_template` SET `data2`= 2,`data4` = 1 WHERE `entry` = 185600; -- 0 0

-- Overmine Flayer 23264
UPDATE `creature_template` SET `faction_A`='1824',`faction_H`='1824',`AIName`='EventAI' WHERE `entry` = 23264; -- 14
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23264;
INSERT INTO `creature_ai_scripts` VALUES
(2326401,23264,9,0,100,1,0,5,10000,12000,11,13443,1,0,0,0,0,0,0,0,0,0,'Overmine Flayer - Cast Rend'),
(2326402,23264,0,0,100,1,5000,10000,15000,16000,11,33810,0,1,0,0,0,0,0,0,0,0,'Overmine Flayer - Cast Rock Shell'); -- trigger 33811

-- pool
-- 1800	40	Nethermine Cargo (185939)
DELETE FROM `gameobject` WHERE `id` = 185939;
INSERT INTO `gameobject` VALUES (50388, 185939, 530, 1, -5205.37, 203.066, -13.3182, 5.21189, 0, 0, 0.510396, -0.85994, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50389, 185939, 530, 1, -5189.81, 627.107, 43.5186, 3.07167, 0, 0, 0.999389, 0.0349535, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50390, 185939, 530, 1, -5178.61, 362.202, -20.2691, 0.299837, 0, 0, 0.149358, 0.988783, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50391, 185939, 530, 1, -5176.67, 160.591, -11.8483, 5.69884, 0, 0, 0.288036, -0.95762, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50392, 185939, 530, 1, -5155.35, 726.69, 45.245, 1.91321, 0, 0, 0.81724, 0.576298, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50393, 185939, 530, 1, -5154.33, 225.287, -20.1081, 0.742976, 0, 0, 0.363002, 0.931788, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50394, 185939, 530, 1, -5146.78, 659.46, 39.2763, 4.15159, 0, 0, 0.875174, -0.483808, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50395, 185939, 530, 1, -5138.9, 690.166, 42.1073, 5.2818, 0, 0, 0.480034, -0.87725, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50396, 185939, 530, 1, -5122.69, 412, -11.7448, 4.39961, 0, 0, 0.80861, -0.588345, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50397, 185939, 530, 1, -5112.25, 160.935, -9.40376, 0.63302, 0, 0, 0.311252, 0.950328, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50398, 185939, 530, 1, -5105.03, 460.255, -9.67519, 1.11665, 0, 0, 0.529766, 0.848144, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50399, 185939, 530, 1, -5103.78, 662.771, 33.5271, 5.89441, 0, 0, 0.193167, -0.981166, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50400, 185939, 530, 1, -5098.94, 371.462, 0.885829, 1.45769, 0, 0, 0.666008, 0.745945, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50401, 185939, 530, 1, -5094.73, 444.284, -5.70656, 1.28097, 0, 0, 0.597585, 0.801806, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50402, 185939, 530, 1, -5080.83, 335.975, 4.94704, 2.44729, 0, 0, 0.940345, 0.340221, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50403, 185939, 530, 1, -5078.21, 277.921, -9.74248, 3.76677, 0, 0, 0.951541, -0.307521, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50404, 185939, 530, 1, -5062.76, 402.884, 0.763877, 0.106798, 0, 0, 0.0533735, 0.998575, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50405, 185939, 530, 1, -5060.08, 182.564, -10.4589, 0.464771, 0, 0, 0.230299, 0.97312, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50406, 185939, 530, 1, -5042.78, 323.487, -3.05248, 1.02571, 0, 0, 0.490667, 0.871347, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50407, 185939, 530, 1, -5037.07, 302.368, 5.13704, 2.42373, 0, 0, 0.936272, 0.351275, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50408, 185939, 530, 1, -5037.07, 452.604, -10.9334, 5.3297, 0, 0, 0.458886, -0.888495, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50409, 185939, 530, 1, -5028.88, 599.486, 19.7124, 5.1365, 0, 0, 0.542443, -0.840093, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50410, 185939, 530, 1, -5024.72, 504.442, 11.34, 4.53174, 0, 0, 0.768005, -0.640444, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50411, 185939, 530, 1, -5024.53, 372.361, 1.72313, 4.61028, 0, 0, 0.742269, -0.670102, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50412, 185939, 530, 1, -5011.71, 237.713, -6.58554, 0.978595, 0, 0, 0.470006, 0.882663, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50413, 185939, 530, 1, -5007.28, 470.563, 18.8001, 1.46555, 0, 0, 0.668934, 0.743322, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50414, 185939, 530, 1, -5005.62, 549.462, 20.7371, 5.01161, 0, 0, 0.59381, -0.804605, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50415, 185939, 530, 1, -4955.91, 409.701, 1.61203, 4.72888, 0, 0, 0.701254, -0.712912, 120, 100, 1);
INSERT INTO `gameobject` VALUES (50416, 185939, 530, 1, -4931.72, 529.889, 6.94222, 2.21167, 0, 0, 0.893839, 0.448387, 120, 100, 1);

DELETE FROM `pool_gameobject` WHERE `pool_entry` = 1800;
SET @GUID := 50388;
INSERT INTO `pool_gameobject` VALUES
(@GUID := @GUID + '0', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)');

INSERT INTO `gameobject` VALUES (56203, 185939, 530, 1, -4969.38, 523.027, -5.36902, 2.70526, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56204, 185939, 530, 1, -5002.83, 448.958, -7.03501, 2.09439, 0, 0, 0, 1, 300, 255, 1);

SET @GUID := 56203;
INSERT INTO `pool_gameobject` VALUES
(@GUID := @GUID + '0', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)');

INSERT INTO `gameobject` VALUES (56207, 185939, 530, 1, -5096.04, 353.769, 3.34744, -1.15192, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56208, 185939, 530, 1, -5033.93, 388.446, -13.2778, -0.226892, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56209, 185939, 530, 1, -5045.86, 420.975, -10.681, -2.56563, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56210, 185939, 530, 1, -4929.31, 297.951, -12.1268, -1.58825, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56211, 185939, 530, 1, -5066.43, 394.802, -12.9495, 0.767944, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56212, 185939, 530, 1, -5026.17, 587.553, 21.0214, -0.017452, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56213, 185939, 530, 1, -5024.83, 207.571, -11.9162, 1.0821, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56214, 185939, 530, 1, -4987.25, 520.171, -5.70161, 0.017452, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56215, 185939, 530, 1, -5026.1, 493.594, 10.4515, 1.44862, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56216, 185939, 530, 1, -5228.15, 136.479, -13.7112, 0.890117, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56217, 185939, 530, 1, -5103.53, 123.015, -13.9215, 1.15192, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56218, 185939, 530, 1, -5140.1, 150.798, -11.5229, -1.95477, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56219, 185939, 530, 1, -5135.53, 483.049, -14.8337, 2.46091, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56220, 185939, 530, 1, -4883.53, 475.869, -2.67198, -3.03684, 0, 0, 0, 1, 180, 33, 1);
INSERT INTO `gameobject` VALUES (56221, 185939, 530, 1, -5036.11, 361.019, 2.36178, -2.33874, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56222, 185939, 530, 1, -5111.9, 665.725, 35.3144, 2.79252, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56223, 185939, 530, 1, -4971.06, 225.004, -11.3607, 2.70526, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56224, 185939, 530, 1, -5038.92, 575.498, 19.7935, 1.65806, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56225, 185939, 530, 1, -5217.55, 337.072, -22.0709, 1.22173, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56226, 185939, 530, 1, -5027.67, 545.317, 18.4923, 1.81514, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56227, 185939, 530, 1, -5180.56, 383.743, -18.8471, 1.41372, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56228, 185939, 530, 1, -4891.32, 531.999, 1.39411, 2.70526, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56229, 185939, 530, 1, -5037.43, 424.579, 4.64012, 1.81514, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56230, 185939, 530, 1, -5051.67, 632.156, 23.9043, -0.645772, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56231, 185939, 530, 1, -5018.34, 150.108, -14.1947, -0.453785, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56232, 185939, 530, 1, -5108.4, 405.713, -12.3955, -2.3911, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56233, 185939, 530, 1, -4987.44, 668.217, 23.5955, 3.00195, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56234, 185939, 530, 1, -4943.11, 423.362, 1.99854, -2.426, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56235, 185939, 530, 1, -4943.78, 536.902, 7.24843, -2.82743, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56236, 185939, 530, 1, -5033.96, 512.002, -5.49904, -1.71042, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56237, 185939, 530, 1, -5092.58, 450.738, -6.41982, 1.0472, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56238, 185939, 530, 1, -4900.04, 458.943, 0.135431, 1.11701, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56239, 185939, 530, 1, -5101.45, 473.739, -8.98286, -3.01941, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56240, 185939, 530, 1, -5135.19, 451.007, -11.4897, 1.02974, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56241, 185939, 530, 1, -4976.8, 451.216, 3.51752, -2.35619, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56242, 185939, 530, 1, -4932.08, 453.45, 1.32601, -1.74533, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56243, 185939, 530, 1, -4985.45, 531.645, -6.27893, -1.46608, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56244, 185939, 530, 1, -5063, 323.446, 6.62532, 2.51327, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56245, 185939, 530, 1, -5051.17, 624.346, 23.028, 2.68781, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56246, 185939, 530, 1, -4959.3, 362.391, -1.9749, 0.872664, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56247, 185939, 530, 1, -5012.34, 426.711, 13.5566, -1.41372, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56248, 185939, 530, 1, -4959.33, 576.761, 11.9238, -2.28638, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56249, 185939, 530, 1, -5104.44, 165.22, -8.67575, 0.314158, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56250, 185939, 530, 1, -4953.66, 468.525, 0.739507, -2.26892, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56251, 185939, 530, 1, -5048.38, 403.73, 1.97754, 1.27409, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56252, 185939, 530, 1, -4908.91, 429.57, -3.17093, 0.279252, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56253, 185939, 530, 1, -5222.39, 196.002, -12.931, -1.79769, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56254, 185939, 530, 1, -5003.44, 525.828, 19.1116, 1.48353, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56255, 185939, 530, 1, -5170.85, 254.96, -31.7537, -0.349065, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56256, 185939, 530, 1, -4917.46, 309.583, -13.1415, 1.83259, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56257, 185939, 530, 1, -5170.76, 167.798, -11.7985, 0.541051, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56258, 185939, 530, 1, -4972.69, 334.418, -1.68185, -1.88495, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56259, 185939, 530, 1, -5067.6, 624.055, 28.1315, 1.90241, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56260, 185939, 530, 1, -4910.93, 592.504, 5.28092, 1.51844, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56261, 185939, 530, 1, -5162.89, 310.071, -25.0638, 1.48353, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56262, 185939, 530, 1, -5081.24, 190.113, -8.61309, 1.91986, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56263, 185939, 530, 1, -5033.31, 470.331, -9.32264, -0.122173, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56264, 185939, 530, 1, -5027.37, 482.105, -8.57508, -2.07694, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56265, 185939, 530, 1, -5037.1, 596.536, 18.5783, 1.78023, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56266, 185939, 530, 1, -4916.29, 545.349, 6.52156, 2.61799, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56267, 185939, 530, 1, -5069.65, 662.32, 33.0581, 2.80997, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56268, 185939, 530, 1, -5175.63, 231.512, -33.8192, 0.977383, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56269, 185939, 530, 1, -5018.86, 299.244, 4.61528, 1.23918, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56270, 185939, 530, 1, -4910.72, 480.099, 0.642428, -2.65289, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56271, 185939, 530, 1, -5130.02, 347.811, -17.7808, -2.68781, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56272, 185939, 530, 1, -5056.37, 137.68, -14.3643, -1.309, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56273, 185939, 530, 1, -5116.07, 441.232, -10.9529, -1.41372, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56274, 185939, 530, 1, -5155.65, 431.065, -10.451, -1.18682, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56275, 185939, 530, 1, -5087.48, 429.858, -12.093, 1.51844, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56276, 185939, 530, 1, -4962.56, 366.978, -1.46309, 0.296705, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56277, 185939, 530, 1, -4939.6, 523.843, 7.77777, -2.58308, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56278, 185939, 530, 1, -5107.48, 645.042, 33.7795, -0.157079, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56279, 185939, 530, 1, -5032.08, 432.775, -9.90734, -1.71042, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56280, 185939, 530, 1, -4988.81, 280.268, -4.79425, -0.715585, 0, 0, 0, 1, 300, 255, 1);

SET @GUID := 56207;
INSERT INTO `pool_gameobject` VALUES
(@GUID := @GUID + '0', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),

(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),

(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),

(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),

(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),

(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),

(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),

(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)');

INSERT INTO `gameobject` VALUES (56596, 185939, 530, 1, -4997.54, 158.95, -14.7979, 0.104719, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56597, 185939, 530, 1, -5033.11, 427.561, -9.99404, -1.91986, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56598, 185939, 530, 1, -5071.87, 398.519, -0.286157, 1.69297, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56599, 185939, 530, 1, -4962.51, 405.349, 1.43439, 0.087266, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56600, 185939, 530, 1, -5013.62, 404.31, -12.2255, 2.70526, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56601, 185939, 530, 1, -5017.2, 365.171, 0.648494, 2.21656, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56602, 185939, 530, 1, -4957.36, 334.104, -3.08167, 0.610864, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56603, 185939, 530, 1, -4948.42, 283.201, -7.74535, 1.25664, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56604, 185939, 530, 1, -5018.78, 271.518, -0.210369, 2.68781, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56605, 185939, 530, 1, -4968.73, 624.278, 16.0225, -2.30383, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56606, 185939, 530, 1, -4996.43, 264.861, -4.54931, -0.104719, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56607, 185939, 530, 1, -4962.21, 298.344, -4.64944, -0.418879, 0, 0, 0, 1, 300, 255, 1);
INSERT INTO `gameobject` VALUES (56608, 185939, 530, 1, -5057.35, 120.543, -17.2921, -0.418879, 0, 0, 0, 1, 300, 255, 1);

SET @GUID := 56596;
INSERT INTO `pool_gameobject` VALUES
(@GUID := @GUID + '0', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)'),
(@GUID := @GUID + '1', 1800, 0,'Nethermine Cargo (185939)');

-- Saltgurka Update 3
 
-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/708
-- Bonechewer Marauder/ Bonechewe Messenger not patrolling and not triggering their event
-- ----------------------------------------------------------
 
-- This is an emergency creature that will only spawn if the orcs somehow get past the demon event. It kills them and then despawns self.
DELETE FROM `creature_template` WHERE `entry` = 1000011;
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(1000011, 0, 17519, 11686, 17519, 11686, 'Bonechewer Event Killer', 10, 10, 112, 112, 0, 0, 20, 114, 114, 0, 0.91, 1, 0, 0, 0, 0, 0, 2000, 0, 33587968, 0, 0, 0, 0, 0, 0, 1.76, 2.42, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 0, 1, 0, 0, 128, '');
 
-- Source for numbers: Corona DB

-- Bonechewer Messenger 21244
UPDATE `creature_template` SET `AIName`='EventAI',`mindmg` = '238',`maxdmg`='304',`baseattacktime`='2000',`unit_flags`='32768',`flags_extra`='536870912',`armor`='6192',`speed`='1.20' WHERE `entry` = 21244;
-- Bonechewer Marauder 21245
UPDATE `creature_template` SET `AIName`='EventAI',`mindmg` = '188',`maxdmg`='240',`baseattacktime`='1500',`unit_flags`='32768',`flags_extra`='536870912',`armor`='6492',`speed`='1.20' WHERE `entry` = 21245;
-- Wrathstalker 21249
UPDATE `creature_template` SET `AIName`='EventAI',`mindmg` = '792',`maxdmg`='1047',`baseattacktime`='2000',`unit_flags`='64',`flags_extra`='0',`armor`='6370',`speed`='1.20',`mechanic_immune_mask`='1' WHERE `entry` = 21249; -- Wrathstalker
DELETE FROM `creature_loot_template` WHERE `entry` = 21249 AND `item` = 29740; -- 21249	29740	33	0	1	1	0	0	0
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (21244,21245,21249,1000011);
INSERT INTO `creature_ai_scripts` VALUES
-- Bonechewer Messenger
('2124401','21244','4','0','100','0','0','0','0','0','17','154','0','0','19','134217728','0','0','0','0','0','0','Bonechewer Messenger - Dismount on Aggro'),
('2124402','21244','9','0','100','0','8','25','0','0','11','35570','1','0','0','0','0','0','0','0','0','0','Bonechewer Messenger - Cast Charge'),
('2124403','21244','7','0','100','0','0','0','0','0','43','17408','0','0','0','0','0','0','0','0','0','0','Bonechewer Messenger - Mount on Evade'),
-- Bonechewer Marauder
('2124501','21245','9','0','100','1','0','5','10000','15000','11','8646','1','32','0','0','0','0','0','0','0','0','Bonechewer Marauder - Cast Snap Kick'),
('2124502','21245','4','0','100','0','0','0','0','0','17','154','0','0','19','134217728','0','0','0','0','0','0','Bonechewer Marauder - Dismount on Aggro'),
('2124503','21245','7','0','100','0','0','0','0','0','43','17408','0','0','0','0','0','0','0','0','0','0','Bonechewer Marauder - Mount on Evade'),
-- Wrathstalker
('2124901','21249','11','0','100','0','0','0','0','0','11','7791','0','1','0','0','0','0','0','0','0','0','Wrathstalker - Cast Teleport on Spawn'),
('2124902','21249','9','0','100','1','0','5','8200','12100','11','15496','4','0','0','0','0','0','0','0','0','0','Wrathstalker - Cast Cleave'),
('2124903','21249','2','0','100','0','30','0','0','0','11','8599','0','0','0','0','0','0','0','0','0','0','Wrathstalker - Cast Enrage at 30% HP'),
('2124905','21249','21','0','100','0','0','0','0','0','100','0','0','0','41','0','0','0','0','0','0','0','Wrathstalker - Despawn on Return to Home after Evade'),
-- Bonechewer Event Killer
('100001101','1000011','11','0','100','0','0','0','0','0','44','5','74476','0','44','5','74477','0','44','5','74478','0','Bonechewer Event Killer - Cast Death Touch on Bonechewer NPCs'),
('100001102','1000011','11','0','100','0','0','0','0','0','44','5','74479','0','44','5','74480','0','41','0','0','0','Bonechewer Event Killer - Cast Death Touch on Bonechewer NPCs, then despawn self');
 
-- Set spawnsettings
UPDATE `creature` SET `position_x`='-2970.7753', `position_y`='3473.5097', `position_z`='-0.1832',`movementtype`='2',`spawntimesecs`='600',`spawndist`='0' WHERE `guid` = 74476;
UPDATE `creature` SET `position_x`='-2962.9152', `position_y`='3473.9216', `position_z`='-0.3620',`movementtype`='0',`spawntimesecs`='600',`spawndist`='0' WHERE `guid` = 74477;
UPDATE `creature` SET `position_x`='-2969.1257', `position_y`='3482.2575', `position_z`='-1.2946',`movementtype`='0',`spawntimesecs`='600',`spawndist`='0' WHERE `guid` = 74478;
UPDATE `creature` SET `position_x`='-2978.6911', `position_y`='3475.1311', `position_z`='0.0306',`movementtype`='0',`spawntimesecs`='600',`spawndist`='0' WHERE `guid` = 74479;
UPDATE `creature` SET `position_x`='-2971.6948', `position_y`='3465.3898', `position_z`='0.2104',`movementtype`='0',`spawntimesecs`='600',`spawndist`='0' WHERE `guid` = 74480;

DELETE FROM `creature_formations` WHERE `leaderguid` = 74476;
INSERT INTO `creature_formations` VALUES
(74476,74476,100,360,2),
(74476,74477,3,0.7,2),
(74476,74478,3,2.3,2),
(74476,74479,3,3.9,2),
(74476,74480,3,5.5,2);
 
-- Movement. Messenger is formation leader
SET @GUID := 74476;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,17408,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,'-2975.3991','3482.2319','-0.8728',0,0,0,100,0),
(@GUID,2,'-2977.6318','3490.6518','-1.7099',0,0,0,100,0),
(@GUID,3,'-2982.1223','3519.9533','-4.5545',0,0,0,100,0),
(@GUID,4,'-2968.1250','3540.5681','-7.9367',0,0,0,100,0),
(@GUID,5,'-2959.8293','3544.7788','-9.6096',0,0,0,100,0),
(@GUID,6,'-2935.3659','3533.3242','-16.4632',0,0,0,100,0),
(@GUID,7,'-2894.6325','3501.2863','-28.5189',0,0,0,100,0),
(@GUID,8,'-2828.9492','3492.9062','-36.3563',0,0,0,100,0),
(@GUID,9,'-2817.3093','3460.1953','-40.8173',0,1,0,100,0),
(@GUID,10,'-2806.1398','3391.6066','-32.0091',0,1,0,100,0),
(@GUID,11,'-2785.5380','3342.2800','-13.7473',0,1,0,100,0),
(@GUID,12,'-2750.3918','3313.3601','0.4519',0,1,0,100,0),
(@GUID,13,'-2761.7126','3290.6828','1.3977',0,1,0,100,0),
(@GUID,14,'-2799.2678','3251.6989','5.2506',0,1,0,100,0),
(@GUID,15,'-2820.2299','3227.4272','10.9445',0,1,0,100,0),
(@GUID,16,'-2841.0607','3203.4450','5.4102',0,1,0,100,0),
(@GUID,17,'-2870.5827','3172.2014','13.0033',0,1,0,100,0),
(@GUID,18,'-2892.5683','3135.9277','23.4260',0,1,0,100,0),
(@GUID,19,'-2914.6350','3114.1408','30.7731',0,1,0,100,0),
(@GUID,20,'-2918.0200','3080.2678','39.7595',0,1,0,100,0),
(@GUID,21,'-2908.4555','3048.2336','46.8876',0,1,0,100,0),
(@GUID,22,'-2916.8417','3027.5156','52.1469',0,1,0,100,0),
(@GUID,23,'-2948.5908','3005.5483','63.3806',0,1,0,100,0),
(@GUID,24,'-2992.3544','2977.6123','78.5383',0,1,0,100,0),
(@GUID,25,'-3017.9770','2955.5036','85.2966',0,1,0,100,0),
(@GUID,26,'-3034.6232','2937.4646','86.4232',0,1,7447601,100,0), -- 74476 Spawn 4 Wrathstalkers. The orcs should never be able to get past these.
(@GUID,27,'-3046.9462','2921.9240','86.1639',0,1,0,100,0),
(@GUID,28,'-3076.9624','2876.5402','81.9593',0,1,0,100,0),
(@GUID,29,'-3107.3051','2830.9824','78.3916',0,1,7447602,100,0); -- If the mobs by some miracle make it past the demons, an invisible mob will spawn and kill them at this waypoint. Optimally I would have liked to just despawn them, but this seems hard to do.
 
-- Not sure how we handle id's in waypoint_scripts? I used the id from waypoint_data + 01,02,03 etc.
DELETE FROM `waypoint_scripts` WHERE `id` IN (7447601,7447602);
INSERT INTO `waypoint_scripts` VALUES
(7447601,0,10,21249,120000,0,-3040.230713,2923.361572,86.667702,0.959264,7447601,'Spawn Wrathstalker 1'), 
(7447601,0,10,21249,120000,0,-3049.942139,2944.359863,91.529282,6.221430,7447602,'Spawn Wrathstalker 2'), 
(7447601,0,10,21249,120000,0,-3027.402344,2920.409668,89.594650,2.527246,7447603,'Spawn Wrathstalker 3'), 
(7447601,0,10,21249,120000,0,-3047.662842,2927.633301,86.636345,0.723925,7447604,'Spawn Wrathstalker 4'), 
(7447602,0,10,1000011,120000,0,-3107.3051,2830.9824,78.3916,0.723925,7447605,'Spawn Bonechewer Event Killer');

SET @GUID := 1000;
DELETE FROM `waypoint_scripts` WHERE `id` BETWEEN 1000 AND 1476;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`, `comment`) VALUES
(1000,0,2,169,0,0,0,0,0,0,@GUID := @GUID + '0','ONESHOT_NONE'),
(1001,0,2,169,1,0,0,0,0,0,@GUID := @GUID + '1','ONESHOT_TALK'),
(1002,0,2,169,2,0,0,0,0,0,@GUID := @GUID + '1','ONESHOT_BOW'),
(1003,0,2,169,3,0,0,0,0,0,@GUID := @GUID + '1','ONESHOT_WAVE'),
(1004,0,2,169,4,0,0,0,0,0,@GUID := @GUID + '1','ONESHOT_CHEER'),
(1005,0,2,169,5,0,0,0,0,0,@GUID := @GUID + '1','ONESHOT_EXCLAMATION'),
(1006,0,2,169,6,0,0,0,0,0,@GUID := @GUID + '1','ONESHOT_QUESTION'),
(1007,0,2,169,7,0,0,0,0,0,@GUID := @GUID + '1','ONESHOT_EAT'),
(1010,0,2,169,10,0,0,0,0,0,1010,'STATE_DANCE'),
(1011,0,2,169,11,0,0,0,0,0,1011,'ONESHOT_LAUGH'),
(1012,0,2,169,12,0,0,0,0,0,1012,'STATE_SLEEP'),
(1013,0,2,169,13,0,0,0,0,0,1013,'STATE_SIT'),
(1014,0,2,169,14,0,0,0,0,0,1014,'ONESHOT_RUDE'),
(1015,0,2,169,15,0,0,0,0,0,1015,'ONESHOT_ROAR'),
(1016,0,2,169,16,0,0,0,0,0,1016,'ONESHOT_KNEEL'),
(1017,0,2,169,17,0,0,0,0,0,1017,'ONESHOT_KISS'),
(1018,0,2,169,18,0,0,0,0,0,1018,'ONESHOT_CRY'),
(1019,0,2,169,19,0,0,0,0,0,1019,'ONESHOT_CHICKEN'),
(1020,0,2,169,20,0,0,0,0,0,1020,'ONESHOT_BEG'),
(1021,0,2,169,21,0,0,0,0,0,1021,'ONESHOT_APPLAUD'),
(1022,0,2,169,22,0,0,0,0,0,1022,'ONESHOT_SHOUT'),
(1023,0,2,169,23,0,0,0,0,0,1023,'ONESHOT_FLEX'),
(1024,0,2,169,24,0,0,0,0,0,1024,'ONESHOT_SHY'),
(1025,0,2,169,25,0,0,0,0,0,1025,'ONESHOT_POINT'),
(1026,0,2,169,26,0,0,0,0,0,1026,'STATE_STAND'),
(1027,0,2,169,27,0,0,0,0,0,1027,'STATE_READYUNARMED'),
(1028,0,2,169,28,0,0,0,0,0,1028,'STATE_WORK_SHEATHED'),
(1029,0,2,169,29,0,0,0,0,0,1029,'STATE_POINT'),
(1030,0,2,169,30,0,0,0,0,0,1030,'STATE_NONE'),
(1033,0,2,169,33,0,0,0,0,0,1033,'ONESHOT_WOUND'),
(1034,0,2,169,34,0,0,0,0,0,1034,'ONESHOT_WOUNDCRITICAL'),
(1035,0,2,169,35,0,0,0,0,0,1035,'ONESHOT_ATTACKUNARMED'),
(1036,0,2,169,36,0,0,0,0,0,1036,'ONESHOT_ATTACK1H'),
(1037,0,2,169,37,0,0,0,0,0,1037,'ONESHOT_ATTACK2HTIGHT'),
(1038,0,2,169,38,0,0,0,0,0,1038,'ONESHOT_ATTACK2HLOOSE'),
(1039,0,2,169,39,0,0,0,0,0,1039,'ONESHOT_PARRYUNARMED'),
(1043,0,2,169,43,0,0,0,0,0,1043,'ONESHOT_PARRYSHIELD'),
(1044,0,2,169,44,0,0,0,0,0,1044,'ONESHOT_READYUNARMED'),
(1045,0,2,169,45,0,0,0,0,0,1045,'ONESHOT_READY1H'),
(1048,0,2,169,48,0,0,0,0,0,1048,'ONESHOT_READYBOW'),
(1050,0,2,169,50,0,0,0,0,0,1050,'ONESHOT_SPELLPRECAST'),
(1051,0,2,169,51,0,0,0,0,0,1051,'ONESHOT_SPELLCAST'),
(1053,0,2,169,53,0,0,0,0,0,1053,'ONESHOT_BATTLEROAR'),
(1054,0,2,169,54,0,0,0,0,0,1054,'ONESHOT_SPECIALATTACK1H'),
(1060,0,2,169,60,0,0,0,0,0,1060,'ONESHOT_KICK'),
(1061,0,2,169,61,0,0,0,0,0,1061,'ONESHOT_ATTACKTHROWN'),
(1064,0,2,169,64,0,0,0,0,0,1064,'STATE_STUN'),
(1065,0,2,169,65,0,0,0,0,0,1065,'STATE_DEAD'),
(1066,0,2,169,66,0,0,0,0,0,1066,'ONESHOT_SALUTE'),
(1068,0,2,169,68,0,0,0,0,0,1068,'STATE_KNEEL'),
(1069,0,2,169,69,0,0,0,0,0,1069,'STATE_USESTANDING'),
(1070,0,2,169,70,0,0,0,0,0,1070,'ONESHOT_WAVE_NOSHEATHE'),
(1071,0,2,169,71,0,0,0,0,0,1071,'ONESHOT_CHEER_NOSHEATHE'),
(1092,0,2,169,92,0,0,0,0,0,1092,'ONESHOT_EAT_NOSHEATHE'),
(1093,0,2,169,93,0,0,0,0,0,1093,'STATE_STUN_NOSHEATHE'),
(1094,0,2,169,94,0,0,0,0,0,1094,'ONESHOT_DANCE'),                
--
(1476,0,2,169,476,0,0,0,0,0,1476,'ONESHOT_CRY (JAINA PROUDMOORE ONLY)');

DELETE FROM `game_event_creature` WHERE `guid` BETWEEN 138384 AND 138394;
SET @GUID := 138384;
INSERT INTO `game_event_creature` VALUES
(@GUID := @GUID + '0',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1),
(@GUID := @GUID + '1',1);

-- mob_ember_of_alar
UPDATE `creature_template` SET `speed`=4 WHERE `entry` = 19551;

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/1301
-- Swamprat Guards not patrolling.
-- ----------------------------------------------------------

 -- Source for numbers: Corona DB
UPDATE `creature_template` SET `mindmg`=430, `maxdmg`=522, `AIName` = 'EventAI' WHERE  `entry` = 18910;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18910;
INSERT INTO `creature_ai_scripts` VALUES
('1891001','18910','0','0','100','1','5000','7000','7000','10000','11','12169','0','0','0','0','0','0','0','0','0','0','Swamprat Guard - Cast Shield Block'); 
-- Source for waypoints: https://searchcode.com/file/115778080/sql/old/4.3.4/TDB6_to_TDB7_updates/world/012_2014_07_30_07_world_waypoints.sql#
-- Pathing for Swamprat Guard Entry: 18910
SET @GUID := 67907;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=75.29373,`position_y`=5261.419,`position_z`=23.08392 WHERE `guid`=@GUID;
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=75.29373,`position_y`=5261.419,`position_z`=23.08392 WHERE `guid`=67906;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@GUID,@GUID,257,0, '5301');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,75.29373,5261.419,23.08392,0,0,0,100,0),
(@GUID,2,75.29796,5274.807,23.04233,0,0,0,100,0),
(@GUID,3,82.62872,5302.216,22.98195,0,0,0,100,0),
(@GUID,4,83.02105,5314.273,22.13724,0,0,0,100,0),
(@GUID,5,82.34508,5302.751,22.97913,0,0,0,100,0),
(@GUID,6,75.29796,5274.807,23.04233,0,0,0,100,0),
(@GUID,7,75.29373,5261.419,23.08392,0,0,0,100,0),
(@GUID,8,75.86388,5247.502,23.12924,0,0,0,100,0),
(@GUID,9,79.21181,5240.832,23.16174,0,0,0,100,0),
(@GUID,10,87.85194,5229.543,22.38807,0,0,0,100,0),
(@GUID,11,79.21181,5240.832,23.16174,0,0,0,100,0),
(@GUID,12,75.86388,5247.502,23.12924,0,0,0,100,0);
 
-- Add Swamprat Guard formation
DELETE FROM `creature_formations` WHERE `leaderGUID`=67907;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(67907,67907,0,0,2),(67907,67906,3,0,2);
 
-- Pathing for Swamprat Guard Entry: 18910
SET @GUID := 67910;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=104.3016,`position_y`=5221.673,`position_z`=22.33099 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`,`mount`,`auras`) VALUES (@GUID,@GUID,257,0, '5301');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,104.3016,5221.673,22.33099,0,0,0,100,0),
(@GUID,2,98.48994,5217.889,22.21583,0,0,0,100,0),
(@GUID,3,97.17163,5209.297,21.69117,0,0,0,100,0),
(@GUID,4,82.73155,5204.081,22.44019,0,0,0,100,0),
(@GUID,5,85.2154,5189.0009,21.4521,0,0,0,100,0),
(@GUID,6,90.1913,5186.492,21.33686,0,0,0,100,0),
(@GUID,7,92.36255,5170.327,22.81916,0,0,0,100,0),
(@GUID,8,104.2373,5163.936,22.91181,0,0,0,100,0),
(@GUID,9,108.7816,5178.44,22.09893,0,0,0,100,0),
(@GUID,10,121.7926,5183.15,24.04241,0,0,0,100,0),
(@GUID,11,117.1341,5191.477,23.33294,0,0,0,100,0),
(@GUID,12,118.593,5209.887,22.58294,0,0,0,100,0),
(@GUID,13,114.1548,5216.103,23.23504,0,0,0,100,0);

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/1749
-- Bat Rider Guards and Eye of Thrallmar not flying and not on a path.
-- ----------------------------------------------------------
 
 
-- Remove duplicate Bat Rider Guard spawns. There should be 4, we had 7.
DELETE FROM `creature` WHERE `guid` IN (54839,54844,54845);
DELETE FROM `creature_addon` WHERE `guid` IN (54839,54844,54845);
 
-- Fix Bat Rider Guard InhabitType and damage. Speed for flying mobs is currently bugged. Adjusting speed in creature_template has no effect.
UPDATE `creature_template` SET `InhabitType`=4,`speed`=2.8,`mindmg`=558,`maxdmg`=674,`AIName`='EventAI' WHERE `entry`=15242;
 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 15242;
INSERT INTO `creature_ai_scripts` VALUES
-- Bat Rider Guard
('1524201','15242','4','0','100','0','0','0','0','0','11','38066','1','2','0','0','0','0','0','0','0','0','Bat Rider Guard - Cast Unstable Concoction on Aggro');
 
-- Bat Rider Guard pathing
SET @GUID := 54840;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=156.9029,`position_y`=2554.784,`position_z`=170.8949 WHERE `guid`=@GUID;
UPDATE `creature_addon` SET `path_id`=@GUID WHERE `guid`=@GUID;
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,156.9029,2554.784,170.8949,0,0,0,100,0),
(@GUID,2,52.51677,2602.816,139.7838,0,0,0,100,0),
(@GUID,3,42.10146,2627.056,139.7838,0,0,0,100,0),
(@GUID,4,37.17329,2663.729,139.7838,0,0,0,100,0),
(@GUID,5,62.91933,2687.96,139.7838,0,0,0,100,0),
(@GUID,6,96.1871,2688.141,148.4226,0,0,0,100,0),
(@GUID,7,129.818,2690.786,151.256,0,0,0,100,0),
(@GUID,8,165.6888,2715.398,170.8949,0,0,0,100,0),
(@GUID,9,199.7751,2744.93,170.8949,0,0,0,100,0),
(@GUID,10,246.0857,2761.154,170.8949,0,0,0,100,0),
(@GUID,11,295.0904,2757.991,170.8949,0,0,0,100,0),
(@GUID,12,309.3468,2726.089,170.8949,0,0,0,100,0),
(@GUID,13,303.8448,2682.588,170.8949,0,0,0,100,0),
(@GUID,14,289.3104,2650.866,170.8949,0,0,0,100,0),
(@GUID,15,261.2743,2618.831,170.8949,0,0,0,100,0),
(@GUID,16,233.6436,2578.997,170.8949,0,0,0,100,0),
(@GUID,17,199.3375,2546.226,170.8949,0,0,0,100,0);
 
-- Bat Rider Guard pathing
SET @GUID := 54841;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=65.97776,`position_y`=2661.205,`position_z`=163.6752 WHERE `guid`=@GUID;
UPDATE `creature_addon` SET `path_id`=@GUID WHERE `guid`=@GUID;
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,65.97776,2661.205,163.6752,0,0,0,100,0),
(@GUID,2,85.52612,2668.312,163.6752,0,0,0,100,0),
(@GUID,3,119.9537,2689.26,163.6752,0,0,0,100,0),
(@GUID,4,121.8238,2721.88,163.6752,0,0,0,100,0),
(@GUID,5,142.6907,2750.891,163.6752,0,0,0,100,0),
(@GUID,6,149.9812,2788.504,163.6752,0,0,0,100,0),
(@GUID,7,142.9353,2830.464,163.6752,0,0,0,100,0),
(@GUID,8,115.1711,2822.444,163.6752,0,0,0,100,0),
(@GUID,9,57.16672,2791.644,163.6752,0,0,0,100,0),
(@GUID,10,38.80463,2758.823,163.6752,0,0,0,100,0),
(@GUID,11,19.69282,2714.784,163.6752,0,0,0,100,0),
(@GUID,12,23.22027,2677.714,163.6752,0,0,0,100,0);
 
-- Bat Rider Guard pathing
SET @GUID := 54842;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=263.5968,`position_y`=2694.818,`position_z`=169.7312 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@GUID,@GUID,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,263.5968,2694.818,169.7312,0,0,0,100,0),
(@GUID,2,184.0861,2784.899,154.4534,0,0,0,100,0),
(@GUID,3,154.2815,2754.787,154.3701,0,0,0,100,0),
(@GUID,4,127.0308,2740.488,154.3701,0,0,0,100,0),
(@GUID,5,118.0444,2706.509,154.3701,0,0,0,100,0),
(@GUID,6,115.7577,2669.386,158.6756,0,0,0,100,0),
(@GUID,7,131.4314,2622.531,162.1478,0,0,0,100,0),
(@GUID,8,154.8241,2607.207,164.4812,0,0,0,100,0),
(@GUID,9,176.3283,2571.343,168.5645,0,0,0,100,0),
(@GUID,10,221.6267,2559.683,172.1201,0,0,0,100,0),
(@GUID,11,245.392,2593.423,169.8978,0,0,0,100,0),
(@GUID,12,251.0069,2617.749,169.7312,0,0,0,100,0),
(@GUID,13,263.0581,2644.614,169.7312,0,0,0,100,0);
 
-- Bat Rider Guard pathing
SET @GUID := 54843;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=62.42025,`position_y`=2785.719,`position_z`=192.1124 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@GUID,@GUID,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,62.42025,2785.719,192.1124,0,0,0,100,0),
(@GUID,2,159.9371,2842.977,208.279,0,0,0,100,0),
(@GUID,3,183.0578,2845.035,208.279,0,0,0,100,0),
(@GUID,4,211.2432,2864.757,214.2235,0,0,0,100,0),
(@GUID,5,238.1182,2871.979,220.9457,0,0,0,100,0),
(@GUID,6,252.9173,2853.913,220.9457,0,0,0,100,0),
(@GUID,7,255.0203,2812.634,220.9457,0,0,0,100,0),
(@GUID,8,240.4993,2780.929,220.9457,0,0,0,100,0),
(@GUID,9,195.4901,2773.965,209.3901,0,0,0,100,0),
(@GUID,10,162.1341,2742.294,212.9179,0,0,0,100,0),
(@GUID,11,125.4935,2720.611,197.9457,0,0,0,100,0),
(@GUID,12,93.49241,2699.757,192.1124,0,0,0,100,0),
(@GUID,13,58.35324,2681.49,192.1124,0,0,0,100,0),
(@GUID,14,22.8833,2715.123,192.1124,0,0,0,100,0),
(@GUID,15,30.10514,2764.5,192.1124,0,0,0,100,0);
 
-- Fix Eye of Thrallmar InhabitType. Speed for flying mobs is currently bugged. Adjusting speed in creature_template has no effect.
UPDATE `creature_template` SET `InhabitType`=4,`speed`=2 WHERE `entry`=16598;
 
-- Add missing Eye of Thrallmar spawn. We had 4, there should be 5.
DELETE FROM `creature` WHERE `guid` = 57585;
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `curhealth`, `curmana`, `MovementType`) VALUES
(57585, 16598, 530, 242.116, 2814.94, 162.248, 6.14692, 300, 0, 4080, 2175, 2);
 
-- Eye of Thrallmar
SET @GUID := 57585;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=219.834778,`position_y`=2803.304688,`position_z`=214.173996 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@GUID,@GUID,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,219.834778,2803.304688,214.173996,0,0,0,100,0),
(@GUID,2,233.776016,2804.136230,217.897995,0,0,0,100,0),
(@GUID,3,253.133835,2818.521484,217.897995,0,0,0,100,0),
(@GUID,4,254.082962,2844.027588,216.091873,0,0,0,100,0),
(@GUID,5,227.018814,2857.876465,213.320297,0,0,0,100,0),
(@GUID,6,212.906586,2848.217285,206.803482,0,0,0,100,0),
(@GUID,7,205.680878,2819.583984,198.880692,0,0,0,100,0),
(@GUID,8,225.256668,2807.054199,198.880692,0,0,0,100,0),
(@GUID,9,245.431046,2817.839600,199.180984,0,0,0,100,0),
(@GUID,10,246.018906,2853.813721,200.253677,0,0,0,100,0),
(@GUID,11,213.296463,2851.532227,200.629395,0,0,0,100,0),
(@GUID,12,209.837982,2828.311523,201.177902,0,0,0,100,0);
 
-- Eye of Thrallmar
SET @GUID := 57586;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=242.115891,`position_y`=2814.944824,`position_z`=162.247818 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@GUID,@GUID,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,242.115891,2814.944824,162.247818,0,0,0,100,0),
(@GUID,2,255.798676,2828.883545,170.696396,0,0,0,100,0),
(@GUID,3,240.192581,2867.977295,158.058456,0,0,0,100,0),
(@GUID,4,217.483932,2858.706543,163.708649,0,0,0,100,0),
(@GUID,5,205.317566,2838.108887,156.497604,0,0,0,100,0),
(@GUID,6,219.706543,2808.419922,167.707886,0,0,0,100,0);
 
-- Eye of Thrallmar
SET @GUID := 57587;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=228.410950,`position_y`=2821.334473,`position_z`=171.923889 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@GUID,@GUID,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,228.410950,2821.334473,171.923889,0,0,0,100,0),
(@GUID,2,241.658859,2825.995850,170.897873,0,0,0,100,0),
(@GUID,3,247.296982,2830.600098,177.734558,0,0,0,100,0),
(@GUID,4,251.712997,2845.102783,178.658875,0,0,0,100,0),
(@GUID,5,239.692719,2853.370605,169.603516,0,0,0,100,0),
(@GUID,6,213.356064,2852.545410,177.772354,0,0,0,100,0),
(@GUID,7,214.914795,2828.211182,169.192627,0,0,0,100,0);
 
-- Eye of Thrallmar
SET @GUID := 57588;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=225.064789,`position_y`=2821.549805,`position_z`=194.492599 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@GUID,@GUID,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,225.064789,2821.549805,194.492599,0,0,0,100,0),
(@GUID,2,240.854492,2824.726318,195.257202,0,0,0,100,0),
(@GUID,3,245.693283,2834.881348,195.644119,0,0,0,100,0),
(@GUID,4,252.054642,2845.350342,192.884186,0,0,0,100,0),
(@GUID,5,239.172882,2856.322998,201.815521,0,0,0,100,0),
(@GUID,6,220.145828,2855.896484,198.060486,0,0,0,100,0),
(@GUID,7,206.920425,2843.603760,194.365051,0,0,0,100,0); 
 
-- Eye of Thrallmar
SET @GUID := 57589;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=214.620773,`position_y`=2817.682861,`position_z`=188.117706 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes2`) VALUES (@GUID,@GUID,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,214.620773,2817.682861,188.117706,0,0,0,100,0),
(@GUID,2,237.724762,2815.922363,200.630554,0,0,0,100,0),
(@GUID,3,257.967712,2838.514160,203.734146,0,0,0,100,0),
(@GUID,4,239.734726,2855.139404,209.278366,0,0,0,100,0),
(@GUID,5,222.779602,2856.832275,208.555817,0,0,0,100,0),
(@GUID,6,207.967361,2841.418945,192.224503,0,0,0,100,0);

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/683
-- (Spells -> Core) and movement for Mature Netherwing Drakes entry: 21648
-- ----------------------------------------------------------
 
-- Add missing spawns
DELETE FROM `creature` WHERE `guid` IN (75551,86103);
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `curhealth`, `MovementType`) VALUES
(75551, 21648, 530, -4099.644, 950.2539, 69.2939, 4.17771, 300, 0, 27044, 2);
 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (21648);
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('2164801','21648','9','0','100','1','0','30','20000','24000','11','36513','0','0','0','0','0','0','0','0','0','0','Nether Dragon - Cast Intangible Presence'),
-- ('2164802','21648','9','0','100','1','0','5','9000','13000','11','36631','0','0','0','0','0','0','0','0','0','0','Nether Dragon - Cast Netherbreath');
 
-- Source: https://searchcode.com/file/62345644/sql/old/3.3.5a/2011_03_02_02_world_waypoint_data.sql#l-7
-- Mature Netherwing Drake Pathing From sniff 1 added.
SET @GUID := 75541;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4134.369,`position_y`=850.2852,`position_z`=61.26378 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4120.351,883.5854,61.26378,0,0,0,100,0),
(@GUID,2,-4085.13,900.4695,61.26378,0,0,0,100,0),
(@GUID,3,-4048.586,884.7811,61.26378,0,0,0,100,0),
(@GUID,4,-4033.683,852.1551,61.26378,0,0,0,100,0),
(@GUID,5,-4050.652,818.6749,61.26378,0,0,0,100,0),
(@GUID,6,-4085.118,799.5022,61.26378,0,0,0,100,0),
(@GUID,7,-4117.451,815.256,61.26378,0,0,0,100,0),
(@GUID,8,-4134.369,850.2852,61.26378,0,0,0,100,0);
 
SET @GUID := 75542;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4066.473,`position_y`=752.3994,`position_z`=43.04424 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4083.436,721.6484,43.04424,0,0,0,100,0),
(@GUID,2,-4109.103,700.2794,43.04424,0,0,0,100,0),
(@GUID,3,-4114.49,699.9313,43.04424,0,0,0,100,0),
(@GUID,4,-4149.18,716.9812,43.04424,0,0,0,100,0),
(@GUID,5,-4164.394,749.7984,44.87757,0,0,0,100,0),
(@GUID,6,-4147.782,783.0017,46.62758,0,0,0,100,0),
(@GUID,7,-4117.128,799.6888,51.93314,0,0,0,100,0),
(@GUID,8,-4082.698,785.6704,50.3498,0,0,0,100,0),
(@GUID,9,-4066.473,752.3994,43.04424,0,0,0,100,0);
 
SET @GUID := 75543;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4148.391,`position_y`=766.8653,`position_z`=66.01289 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4183.416,753.0403,72.09624,0,0,0,100,0),
(@GUID,2,-4199.977,716.2882,82.67956,0,0,0,100,0),
(@GUID,3,-4183.724,684.1388,70.56844,0,0,0,100,0),
(@GUID,4,-4148.917,666.9986,63.51288,0,0,0,100,0),
(@GUID,5,-4116.004,684.5375,61.51288,0,0,0,100,0),
(@GUID,6,-4099.94,716.4078,62.09623,0,0,0,100,0),
(@GUID,7,-4116.647,749.6686,61.59621,0,0,0,100,0),
(@GUID,8,-4148.391,766.8653,66.01289,0,0,0,100,0);
 
SET @GUID := 75544;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4084.089,`position_y`=683.0483,`position_z`=59.55887 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4067.996,652.302,59.55887,0,0,0,100,0),
(@GUID,2,-4084.038,618.9259,59.55887,0,0,0,100,0),
(@GUID,3,-4117.386,599.9404,59.55887,0,0,0,100,0),
(@GUID,4,-4149.88,616.7292,59.55887,0,0,0,100,0),
(@GUID,5,-4165.804,652.2473,59.55887,0,0,0,100,0),
(@GUID,6,-4150.054,685.6966,59.55887,0,0,0,100,0),
(@GUID,7,-4118.107,699.7501,59.55887,0,0,0,100,0),
(@GUID,8,-4084.089,683.0483,59.55887,0,0,0,100,0);
 
SET @GUID := 75545;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4083.681,`position_y`=848.0616,`position_z`=58.43416 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4117.843,866.6574,58.43417,0,0,0,100,0),
(@GUID,2,-4149.746,851.1995,68.6286,0,0,0,100,0),
(@GUID,3,-4167.114,815.8797,74.48971,0,0,0,100,0),
(@GUID,4,-4150.918,786.3128,65.07306,0,0,0,100,0),
(@GUID,5,-4116.956,766.7995,70.51749,0,0,0,100,0),
(@GUID,6,-4085.521,784.5572,76.90639,0,0,0,100,0),
(@GUID,7,-4067.243,818.4576,64.35083,0,0,0,100,0),
(@GUID,8,-4083.681,848.0616,58.43416,0,0,0,100,0);
 
SET @GUID := 75546;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4133.319,`position_y`=918.6325,`position_z`=70.3725 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4117.341,884.8878,62.09472,0,0,0,100,0),
(@GUID,2,-4084.125,867.1631,52.70584,0,0,0,100,0),
(@GUID,3,-4050.462,883.2648,46.84472,0,0,0,100,0),
(@GUID,4,-4033.427,917.2786,54.8725,0,0,0,100,0),
(@GUID,5,-4049.515,951.7986,62.20583,0,0,0,100,0),
(@GUID,6,-4082.625,966.6864,69.48361,0,0,0,100,0),
(@GUID,7,-4116.243,949.7843,72.2614,0,0,0,100,0),
(@GUID,8,-4133.319,918.6325,70.3725,0,0,0,100,0);
 
SET @GUID := 75547;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4000.944,`position_y`=650.089,`position_z`=84.74791 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4015.128,680.8443,72.16458,0,0,0,100,0),
(@GUID,2,-4047.654,700.2465,60.27572,0,0,0,100,0),
(@GUID,3,-4082.378,686.9391,58.8868,0,0,0,100,0),
(@GUID,4,-4099.23,649.127,67.30346,0,0,0,100,0),
(@GUID,5,-4083.47,615.1847,74.74792,0,0,0,100,0),
(@GUID,6,-4047.911,600.5391,92.52572,0,0,0,100,0),
(@GUID,7,-4016.922,616.1044,98.47014,0,0,0,100,0),
(@GUID,8,-4000.944,650.089,84.74791,0,0,0,100,0);
 
SET @GUID := 75548;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4052.34,`position_y`=716.3079,`position_z`=48.66938 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4019.384,700.1765,47.08604,0,0,0,100,0),
(@GUID,2,-3983.657,716.8768,52.75271,0,0,0,100,0),
(@GUID,3,-3967.16,750.4713,65.47495,0,0,0,100,0),
(@GUID,4,-3982.856,783.4985,67.83604,0,0,0,100,0),
(@GUID,5,-4017.322,800.1605,65.75271,0,0,0,100,0),
(@GUID,6,-4048.333,784.6697,60.58604,0,0,0,100,0),
(@GUID,7,-4067.148,750.3481,53.25271,0,0,0,100,0),
(@GUID,8,-4052.34,716.3079,48.66938,0,0,0,100,0);
 
SET @GUID := 75549;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3949.365,`position_y`=819.178,`position_z`=51.50261 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-3933.805,784.3923,51.50261,0,0,0,100,0),
(@GUID,2,-3951.698,751.0433,51.50261,0,0,0,100,0),
(@GUID,3,-3980.543,733.1439,58.86372,0,0,0,100,0),
(@GUID,4,-4016.032,747.1483,64.55817,0,0,0,100,0),
(@GUID,5,-4032.366,782.211,60.08595,0,0,0,100,0),
(@GUID,6,-4017.203,816.9814,53.30817,0,0,0,100,0),
(@GUID,7,-3985.723,832.2205,51.50261,0,0,0,100,0),
(@GUID,8,-3949.365,819.178,51.50261,0,0,0,100,0);
 
SET @GUID := 75550;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3916.397,`position_y`=883.2978,`position_z`=81.9971 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-3948.779,899.8286,68.13598,0,0,0,100,0),
(@GUID,2,-3982.235,885.5906,61.1082,0,0,0,100,0),
(@GUID,3,-3999.414,851.4448,62.69153,0,0,0,100,0),
(@GUID,4,-3983.74,817.0834,58.96931,0,0,0,100,0),
(@GUID,5,-3950.159,800.5572,63.10819,0,0,0,100,0),
(@GUID,6,-3918.94,815.5467,72.46931,0,0,0,100,0),
(@GUID,7,-3900.264,851.1897,81.30264,0,0,0,100,0),
(@GUID,8,-3916.397,883.2978,81.9971,0,0,0,100,0);
 
SET @GUID := 75551;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4084.883,`position_y`=914.0491,`position_z`=72.2939 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4099.644,950.2539,69.2939,0,0,0,100,0),
(@GUID,2,-4086.421,983.3143,71.12724,0,0,0,100,0),
(@GUID,3,-4050.086,1000.082,74.32168,0,0,0,100,0),
(@GUID,4,-4018.68,983.5675,74.32168,0,0,0,100,0),
(@GUID,5,-4001.11,950.1692,74.32168,0,0,0,100,0),
(@GUID,6,-4016.584,917.4998,74.32168,0,0,0,100,0),
(@GUID,7,-4048.498,899.8286,74.32168,0,0,0,100,0),
(@GUID,8,-4084.883,914.0491,72.2939,0,0,0,100,0);
-- .go -4084.883 914.0491 72.2939
 
 
SET @GUID := 75552;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3915.657,`position_y`=833.4163,`position_z`=47.38418 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-3948.898,849.9359,47.38418,0,0,0,100,0),
(@GUID,2,-3964.938,879.6131,47.38418,0,0,0,100,0),
(@GUID,3,-3948.945,916.1858,47.38418,0,0,0,100,0),
(@GUID,4,-3916.809,932.6107,48.16196,0,0,0,100,0),
(@GUID,5,-3886.793,916.5725,53.96752,0,0,0,100,0),
(@GUID,6,-3866.807,883.3404,60.02308,0,0,0,100,0),
(@GUID,7,-3884.739,849.9593,54.30085,0,0,0,100,0),
(@GUID,8,-3915.657,833.4163,47.38418,0,0,0,100,0);
 
SET @GUID := 75553;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4047.742,`position_y`=1066.566,`position_z`=106.1299 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4082.141,1050.517,104.5466,0,0,0,100,0),
(@GUID,2,-4099.718,1017.106,98.4355,0,0,0,100,0),
(@GUID,3,-4082.201,985.4608,87.46328,0,0,0,100,0),
(@GUID,4,-4048.188,966.8837,78.15773,0,0,0,100,0),
(@GUID,5,-4017.819,980.5856,72.37994,0,0,0,100,0),
(@GUID,6,-4000.326,1016.784,86.21326,0,0,0,100,0),
(@GUID,7,-4014.791,1050.645,97.40771,0,0,0,100,0),
(@GUID,8,-4047.742,1066.566,106.1299,0,0,0,100,0);
 
SET @GUID := 75554;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3900.323,`position_y`=984.7424,`position_z`=60.60864 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-3918.999,953.8466,58.96975,0,0,0,100,0),
(@GUID,2,-3950.793,934.2088,58.96975,0,0,0,100,0),
(@GUID,3,-3982.866,950.2649,58.96975,0,0,0,100,0),
(@GUID,4,-4000.046,985.8019,61.02531,0,0,0,100,0),
(@GUID,5,-3981.982,1017.846,58.96975,0,0,0,100,0),
(@GUID,6,-3949.962,1033.053,56.85864,0,0,0,100,0),
(@GUID,7,-3918.825,1014.746,58.33086,0,0,0,100,0),
(@GUID,8,-3900.323,984.7424,60.60864,0,0,0,100,0);
 
SET @GUID := 75555;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3950.083,`position_y`=985.4277,`position_z`=83.53654 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-3965.832,952.775,76.7032,0,0,0,100,0),
(@GUID,2,-3951.587,918.8143,71.53653,0,0,0,100,0),
(@GUID,3,-3916.848,899.7321,72.39764,0,0,0,100,0),
(@GUID,4,-3885.93,916.5598,83.34209,0,0,0,100,0),
(@GUID,5,-3867.241,951.6891,90.39765,0,0,0,100,0),
(@GUID,6,-3882.38,983.3097,81.48098,0,0,0,100,0),
(@GUID,7,-3915.022,1000.09,72.17542,0,0,0,100,0),
(@GUID,8,-3950.083,985.4277,83.53654,0,0,0,100,0);
 
SET @GUID := 75556;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3966.719,`position_y`=1048.378,`position_z`=69.52766 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-3983.504,1016.722,67.94434,0,0,0,100,0),
(@GUID,2,-4015.046,1002.573,69.52766,0,0,0,100,0),
(@GUID,3,-4049.708,1017.723,72.13878,0,0,0,100,0),
(@GUID,4,-4066.48,1048.968,72.66656,0,0,0,100,0),
(@GUID,5,-4048.204,1083.848,71.19434,0,0,0,100,0),
(@GUID,6,-4016.47,1100.259,72.47211,0,0,0,100,0),
(@GUID,7,-3985.822,1082.684,70.97211,0,0,0,100,0),
(@GUID,8,-3966.719,1048.378,69.52766,0,0,0,100,0);
 
SET @GUID := 75557;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3950.767,`position_y`=1000.512,`position_z`=87.49402 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-3918.137,1015.368,90.16069,0,0,0,100,0),
(@GUID,2,-3900.402,1050.901,91.7718,0,0,0,100,0),
(@GUID,3,-3917.262,1083.885,99.32737,0,0,0,100,0),
(@GUID,4,-3949.68,1100.575,106.7718,0,0,0,100,0),
(@GUID,5,-3981.045,1082.341,107.8829,0,0,0,100,0),
(@GUID,6,-3999.798,1048.804,99.57736,0,0,0,100,0),
(@GUID,7,-3985.399,1018.346,91.7718,0,0,0,100,0),
(@GUID,8,-3950.767,1000.512,87.49402,0,0,0,100,0);
 
SET @GUID := 75558;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3981.939,`position_y`=1200.395,`position_z`=108.2629 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`,`bytes2`) VALUES (@GUID,@GUID,16908544,4097);
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4015.405,1186.572,107.8463,0,0,0,100,0),
(@GUID,2,-4032.093,1150.835,100.8185,0,0,0,100,0),
(@GUID,3,-4016.442,1117.503,95.84628,0,0,0,100,0),
(@GUID,4,-3982.193,1100.35,95.62405,0,0,0,100,0),
(@GUID,5,-3950.59,1116.853,99.12405,0,0,0,100,0),
(@GUID,6,-3933.569,1150.704,103.263,0,0,0,100,0),
(@GUID,7,-3949.776,1184.953,106.8185,0,0,0,100,0),
(@GUID,8,-3981.939,1200.395,108.2629,0,0,0,100,0);
-- .go -3981.939 1200.395 108.2629

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 30834;
INSERT INTO `spell_linked_spell` VALUES
(30834,30836,1,'Prince Infernal Spawning');

DELETE FROM `spell_script_target` WHERE `entry` = 30834;

-- Infernal Target 17644 netherspite_infernal
UPDATE `creature_template` SET `modelid_A`= 13069, `modelid_H` = 13069, `unit_flags` = 0, `flags_extra`=130, `ScriptName` = NULL, `AIName` = NULL  WHERE `entry` = 17644; -- 7029 33554434 0

-- Netherspite Infernal 17646
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `speed` = 0.001, `unit_flags` = 33851973, `dynamicflags` = 8, `type_flags` = 1056, `ScriptName` = NULL, `AIName` = 'EventAI' WHERE `entry` = 17646; -- 35
DELETE FROM `creature_template_addon` WHERE `entry` IN (17646);
INSERT INTO `creature_template_addon` VALUES
(17646,0,0,16908544,0,4097,0,0,NULL);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (17646);
INSERT INTO `creature_ai_scripts` VALUES
('1764601','17646','1','0','100','1','4000','4000','100','100','11','30859','0','32','0','0','0','0','0','0','0','0','Netherspite Infernal - Cast Hellfire OOC');

UPDATE `creature` SET `position_x`='-10932.4775', `position_y`='-1980.9719', `position_z`='275.5039' WHERE `guid` = 135920;
UPDATE `creature` SET `position_x`='-10982.8105', `position_y`='-2013.3117', `position_z`='275.0239' WHERE `guid` = 135919;
UPDATE `creature` SET `position_x`='-11005.1621', `position_y`='-1981.5374', `position_z`='274.9985' WHERE `guid` = 135917;
UPDATE `creature` SET `position_x`='-10954.2138', `position_y`='-1979.7288', `position_z`='275.3330' WHERE `guid` = 135916;
UPDATE `creature` SET `position_x`='-10958.8154', `position_y`='-1999.3208', `position_z`='275.4359' WHERE `guid` = 135915;
UPDATE `creature` SET `position_x`='-10972.2529', `position_y`='-1963.7476', `position_z`='275.0897' WHERE `guid` = 135912;
UPDATE `creature` SET `position_x`='-10949.7656', `position_y`='-1959.3552', `position_z`='275.2453' WHERE `guid` = 135911;
UPDATE `creature` SET `position_x`='-10989.9980', `position_y`='-1994.8156', `position_z`='275.1358' WHERE `guid` = 135909;

UPDATE `creature` SET `position_x`='4007.0761', `position_y`='1517.1452', `position_z`='-115.8280', `orientation`='4.9955',`spawndist`='0',`movementtype`='0' WHERE `guid` = 71729;

-- Apexis Shard
DELETE FROM `creature_loot_template` WHERE `item` = 32569;
INSERT INTO `creature_loot_template` VALUES (18692, 32569, 100, 2, 2, 3, 0, 0, 0); -- 15
INSERT INTO `creature_loot_template` VALUES (19973, 32569, 73, 0, 1, 1, 0, 0, 0); -- 18.7
INSERT INTO `creature_loot_template` VALUES (20557, 32569, 8.3465, 0, 1, 1, 0, 0, 0); -- 8.3465
INSERT INTO `creature_loot_template` VALUES (22175, 32569, 33.1139, 0, 1, 1, 0, 0, 0); -- 
INSERT INTO `creature_loot_template` VALUES (22180, 32569, 25, 0, 1, 1, 0, 0, 0); -- 29.4929 -- 45
INSERT INTO `creature_loot_template` VALUES (22181, 32569, 31.0921, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22182, 32569, 22.768, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (22195, 32569, 26, 0, 1, 1, 0, 0, 0); -- 16.6 -- 46
INSERT INTO `creature_loot_template` VALUES (22204, 32569, 25, 0, 1, 1, 0, 0, 0); -- 25.2364 -- 45
INSERT INTO `creature_loot_template` VALUES (22241, 32569, 27, 0, 1, 1, 0, 0, 0); -- 21.9174 -- 47
INSERT INTO `creature_loot_template` VALUES (22242, 32569, 25, 0, 1, 1, 0, 0, 0); -- 21.9872 -- 45
INSERT INTO `creature_loot_template` VALUES (22243, 32569, 28, 0, 1, 1, 0, 0, 0); -- 24.0095 -- 48
INSERT INTO `creature_loot_template` VALUES (22244, 32569, 14, 0, 1, 1, 0, 0, 0); -- 15.2663 -- 34
INSERT INTO `creature_loot_template` VALUES (22254, 32569, 25, 0, 1, 1, 0, 0, 0); -- 26.756 -- 45  
INSERT INTO `creature_loot_template` VALUES (22291, 32569, 27, 0, 1, 1, 0, 0, 0); -- 15.2455 -- 47
INSERT INTO `creature_loot_template` VALUES (22298, 32569, 13, 0, 1, 1, 0, 0, 0); -- 7.2 -- 33
INSERT INTO `creature_loot_template` VALUES (22304, 32569, 98.2, 0, 2, 3, 0, 0, 0); -- 
INSERT INTO `creature_loot_template` VALUES (23061, 32569, 92, 0, 2, 3, 0, 0, 0); -- 24.9 --
INSERT INTO `creature_loot_template` VALUES (23153, 32569, 97.2, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23154, 32569, 97.2, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23174, 32569, 98.7, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23261, 32569, 92, 0, 2, 3, 0, 0, 0); -- 25 --
INSERT INTO `creature_loot_template` VALUES (23281, 32569, 93, 0, 2, 3, 0, 0, 0); -- 25.1 --
INSERT INTO `creature_loot_template` VALUES (23282, 32569, 93, 0, 2, 3, 0, 0, 0); -- 25 --
INSERT INTO `creature_loot_template` VALUES (23386, 32569, 30, 0, 1, 1, 0, 0, 0); -- 33.8 -- 50

DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9910','-9909','-9908','-9907','-9906','-9905','-9904','-9903','-9902','-9901','-9900');
INSERT INTO `creature_ai_texts` VALUES
('-9910','Me angered. Raaah!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','Schergrat Ogres on Aggro'),
('-9909','Me smash! You die!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','Schergrat Ogres on Aggro'),
('-9908','Now, proceed to the translocator. Forge Camp Wrath awaits your arrival!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','19747 OCC Summon Event'),
('-9907','You will suffer slowly until the end of time for this affront!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 Yell on Aggro'),
('-9906','Prepare yourself for eternal torture, mortal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 Yell on Aggro'),
('-9905','I shall enjoy the smell of the grease from your marrow crackling over the fire!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 Yell on Aggro'),
('-9904','Release the hounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 IC Summon Event'),
('-9903','Your name is as insignificant to me as the names of the thousands who have died under the might of Goc. I will crush you and $N!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','20555 on Aggro'),
('-9902','Me mad. You get smash in face!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','19948 on Aggro'),
('-9901','As I shall consume your flesh, so too shall the Burning Legion consume your people!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','23355 Yell on Aggro'),
('-9900',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','SCHERGRATCOMMENT');
