UPDATE `creature_loot_template` SET `mincountOrRef`=1,`maxcount`=1 WHERE `item` IN (30020,30021,30022,30023,30024,30025,30026,30027,30028,30029,30030,30620);


SET @GUID := 57800;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57800, 1, 74.0635, 4333.11, 101.473, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 2, 59.6808, 4332.9, 96.1607, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 3, 73.1186, 4333.16, 101.055, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 4, 90.3435, 4333.23, 101.483, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 5, 122.918, 4333.39, 104.867, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 6, 154.94, 4333.25, 107.505, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 7, 122.918, 4333.39, 104.867, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 8, 90.3435, 4333.23, 101.483, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 9, 74.0635, 4333.11, 101.473, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 10, 59.6808, 4332.9, 96.1607, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 11, 73.1186, 4333.16, 101.055, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 12, 90.3435, 4333.23, 101.483, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 13, 122.918, 4333.39, 104.867, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 14, 154.94, 4333.25, 107.505, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 15, 192.09, 4333.34, 116.444, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 16, 154.94, 4333.25, 107.505, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 17, 122.918, 4333.39, 104.867, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 18, 90.3435, 4333.23, 101.483, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 19, 74.0635, 4333.11, 101.473, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 20, 154.94, 4333.25, 107.505, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 21, 192.09, 4333.34, 116.444, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 22, 122.918, 4333.39, 104.867, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 23, 90.3435, 4333.23, 101.483, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 24, 74.0635, 4333.11, 101.473, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 25, 59.6808, 4332.9, 96.1607, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 26, 73.1186, 4333.16, 101.055, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 27, 90.3435, 4333.23, 101.483, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 28, 122.918, 4333.39, 104.867, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 29, 154.94, 4333.25, 107.505, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 30, 192.09, 4333.34, 116.444, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (57800, 31, 90.3435, 4333.23, 101.483, 0, 0, 0, 100, 0);

UPDATE `creature` SET `position_x`='103.4094', `position_y`='4341.2641', `position_z`='101.4677', `orientation`='4.2540',`spawndist`='0',`movementtype`='0' WHERE `guid` = '67032';

-- Deathfrost ~10%
-- http://www.wowhead.com/spell=46578/deathfrost#comments:id=311615
-- http://www.wowhead.com/item=35498/formula-enchant-weapon-deathfrost#comments:id=309736:reply=339434
-- http://www.wowhead.com/item=35498/formula-enchant-weapon-deathfrost#comments:id=310017
DELETE FROM `spell_enchant_proc_data` WHERE `entry` = 3273;
INSERT INTO `spell_enchant_proc_data` VALUES (3273, 0, 3, 0, 3);
