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

