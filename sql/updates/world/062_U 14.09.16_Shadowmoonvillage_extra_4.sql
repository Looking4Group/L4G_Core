-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/760/weapons-on-guards
--
--
-- korkron-defender
-- By Skullhawk13 (33,001 – 9·28·288) on 2015/05/28 (Patch 6.1.2)       
-- They will use a sword and shield, or a two-handed mace...Apparently These orcs are too good for axes.
UPDATE `creature_template` SET `equipment_id`='8021' WHERE `entry` = 19362;
DELETE FROM `creature_equip_template` WHERE `entry` = 8021;
INSERT INTO `creature_equip_template` VALUES
(8021,36079,0,0,285345026 ,0,0,1,0,0);
-- some npcs only
UPDATE `creature` SET `equipment_id`='8022' WHERE `guid` IN (69079,69090,69078,78928,69075,69083);
DELETE FROM `creature_equip_template` WHERE `entry` = 8022;
INSERT INTO `creature_equip_template` VALUES
(8022,31997,31746,0,218171138,234948100,0,3,1038,0);

-- Targrom & Friends
UPDATE `creature` SET `position_x`='-2939.3872', `position_y`='2675.1628', `position_z`='93.6803', `orientation`='4.4358',`spawndist`='0',`movementtype`='0' WHERE `guid` = 68964;
-- Kor'kron Defender
UPDATE `creature` SET `movementtype`='0' WHERE `guid` = 69092;
UPDATE `creature` SET `movementtype`='2' WHERE `guid` = 69091;
UPDATE `creature` SET `position_x`='-3087.8986', `position_y`='2449.5834', `position_z`='63.9052', `orientation`='3.0394',`spawndist`='5',`movementtype`='1' WHERE `guid` = 69075;
UPDATE `creature` SET `position_x`='-2925.4338', `position_y`='2645.5607', `position_z`='93.6541', `orientation`='3.8796',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69077;
UPDATE `creature` SET `position_x`='-3124.9436', `position_y`='2569.8483', `position_z`='61.6758', `orientation`='3.5315',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69085;
UPDATE `creature` SET `position_x`='-2933.5161', `position_y`='2643.6137', `position_z`='93.6493', `orientation`='3.8992',`spawndist`='0',`movementtype`='2' WHERE `guid` = 69078;
-- Trop Rendlimb
UPDATE `creature` SET `position_x`='-2903', `position_y`='2615', `position_z`='93.6802', `orientation`='2.8521',`spawndist`='0',`movementtype`='0' WHERE `guid` = 68959;
-- Kalara
UPDATE `creature` SET `position_x`='-2906.5869', `position_y`='2603.2880', `position_z`='93.6802', `orientation`='2.4398',`spawndist`='0',`movementtype`='0' WHERE `guid` = 68961;
-- Gedrah
UPDATE `creature` SET `position_x`='-3023', `position_y`='2618', `position_z`='76.7027', `orientation`='3.8246',`spawndist`='0',`movementtype`='0' WHERE `guid` = 74708;
-- Detrafila
UPDATE `creature` SET `position_x`='-3023.0000', `position_y`='2616.0000', `position_z`='76.7956', `orientation`='3.000',`spawndist`='0',`movementtype`='0' WHERE `guid` = 74713;
DELETE FROM `creature_addon` WHERE `guid` = 74713;
INSERT INTO `creature_addon` VALUES
(74713,0,0,0,3,0,0,0,'');
-- Kor'kron Rider
UPDATE `creature` SET `position_x`='-3062.0314', `position_y`='2493.9934', `position_z`='64.7782', `orientation`='4.5601',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69097;
DELETE FROM `creature_template_addon` WHERE `entry` = 19364;
INSERT INTO `creature_template_addon` VALUES 
(19364,0,17408,16777472,0,4097,0,0,'');
--
UPDATE `creature` SET `movementtype`='0',`spawndist`='0' WHERE `id` = 19355;
UPDATE `creature` SET `position_x`='-3127.2180', `position_y`='2493.1831', `position_z`='61.8622', `orientation`='0.4197',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69055;
UPDATE `creature` SET `position_x`='-2965', `position_y`='2664', `position_z`='98.6647', `orientation`='00000',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69056;
UPDATE `creature` SET `position_x`='-2959', `position_y`='2578', `position_z`='76.6325', `orientation`='3.3455',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69058;
UPDATE `creature` SET `position_x`='-3037', `position_y`='2523', `position_z`='62.7889', `orientation`='6.0200',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69062;
UPDATE `creature` SET `position_x`='-3035.8466', `position_y`='2527.9194', `position_z`='63.2220', `orientation`='4.9057',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69063;
UPDATE `creature` SET `position_x`='-3139.5117', `position_y`='2453.2272', `position_z`='63.8940', `orientation`='4.2945',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69067;
UPDATE `creature` SET `position_x`='-3107.6000', `position_y`='2458.1030', `position_z`='62.8081', `orientation`='4.9489',`spawndist`='0',`movementtype`='0' WHERE `guid` = 69068;
--
SET @NPC := 69078;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-2943.1425','2633.8398','92.6612',0,0,0,100,0),
(@PATH,2,'-2981.6433','2599.5947','78.5899',5000,0,0,100,0),
(@PATH,3,'-2943.1425','2633.8398','92.6612',0,0,0,100,0),
(@PATH,4,'-2933.5161','2643.6137','93.6493',5000,0,0,100,0);
--
DELETE FROM `creature_formations` WHERE `leaderGUID` = 69091;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(69091, 69091, 0, 0, 2),
(69091, 69092, 3, 270, 2);

-- Pathing for Kor'kron Defender Entry: 19362 'ODB FORMAT' 
SET @NPC := 69091;
SET @PATH := @NPC * 10;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-3146.969,`position_y`=2563.808,`position_z`=61.37704 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@NPC,@PATH,0,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-3146.969,2563.808,61.37704,0,0,0,100,0), -- 13:54:58
(@PATH,2,-3120.494,2564.844,61.75181,0,0,0,100,0), -- 13:54:58
(@PATH,3,-3120.494,2564.844,61.75181,0,0,0,100,0), -- 13:54:58
(@PATH,4,-3120.175,2565.024,61.98759,0,0,0,100,0), -- 13:55:06
(@PATH,5,-3105.344,2573.74,61.804,0,0,0,100,0), -- 13:55:12
(@PATH,6,-3091.726,2572.44,62.09174,0,0,0,100,0), -- 13:55:18
(@PATH,7,-3088.27,2558.042,62.11543,0,0,0,100,0), -- 13:55:24
(@PATH,8,-3100.597,2545.807,62.11351,0,0,0,100,0), -- 13:55:32
(@PATH,9,-3094.525,2537.95,61.9211,0,0,0,100,0), -- 13:55:35
(@PATH,10,-3079.098,2537.322,62.08109,0,0,0,100,0), -- 13:55:43
(@PATH,11,-3062.423,2502.734,63.59535,0,0,0,100,0), -- 13:55:52
(@PATH,12,-3063.66,2507.985,63.10339,0,0,0,100,0), -- 13:56:00
(@PATH,13,-3065.486,2517.504,62.46205,0,0,0,100,0), -- 13:56:04
(@PATH,14,-3079.187,2537.478,62.18378,0,0,0,100,0), -- 13:56:14
(@PATH,15,-3094.9,2537.977,62.13345,0,0,0,100,0), -- 13:56:20
(@PATH,16,-3100.354,2544.985,61.87681,0,0,0,100,0), -- 13:56:30
(@PATH,17,-3100.963,2545.778,61.87681,0,0,0,100,0), -- 13:56:30
(@PATH,18,-3088.325,2558.04,61.854,0,0,0,100,0), -- 13:56:30
(@PATH,19,-3088.325,2558.04,61.854,0,0,0,100,0), -- 13:56:30
(@PATH,20,-3088.377,2558.176,62.10567,0,0,0,100,0), -- 13:56:32
(@PATH,21,-3091.65,2572.547,62.05435,0,0,0,100,0), -- 13:56:38
(@PATH,22,-3105.591,2573.866,62.01907,0,0,0,100,0), -- 13:56:43
(@PATH,23,-3120.379,2565.042,61.81473,0,0,0,100,0), -- 13:56:50
(@PATH,24,-3120.494,2564.844,61.75181,0,0,0,100,0); -- 13:57:02
-- 0x1C09FC424012E88000001A00039B696A .go -3146.969 2563.808 61.37704

-- Nether Vortex Groupid Dropchance Increase
UPDATE `creature_loot_template` SET `groupid`=9 WHERE `item` = 30183; -- 0
