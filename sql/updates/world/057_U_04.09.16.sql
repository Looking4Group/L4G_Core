UPDATE `creature` SET `position_x`='348.194763', `position_y`='-721.6417', `position_z`='-13.6739', `orientation`='3.2655',`spawndist`='0',`movementtype`='0' WHERE `guid` = '82974'; -- 355,821	-721,004	-13,8746	6,09301

SET @GUID := '1748'; -- Ironforge Guard
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4958.850', `position_y`='-997.5289', `position_z`='501.5721', `orientation`='0.9778681', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, (@POINT := @POINT + '1'), '-4942.368', '-973.0673', '501.5523', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4922.720', '-954.7523', '501.5698', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4896.282', '-936.7808', '501.4918', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4872.001', '-926.0280', '501.5149', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4872.001', '-926.0280', '501.5149', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4872.3994', '-926.1273', '501.4919', '45000', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4905.076', '-941.8298', '501.5605', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4929.299', '-961.5024', '501.5698', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4958.948', '-997.8889', '501.4812', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4958.948', '-997.8889', '501.4812', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4958.7397', '-997.3656', '501.4906', '45000', '0', '0', '100', '0');

-- Respawn with correct GUID
-- Adjust Hitbox
UPDATE `creature_model_info` SET `bounding_radius`='17',`combat_reach`='17' WHERE `modelid` = 20216; -- 13  20
DELETE FROM `creature` WHERE `guid` IN (93838,16777006);
INSERT INTO `creature` VALUES (93838, 21217, 548, 1, 0, 0, 39.2422, -416.1356, -21.5911, 3.03312, 3600000, 0, 0, 6905080, 0, 0, 0);
DELETE FROM `creature_linked_respawn` WHERE `guid` = 93838;
INSERT INTO `creature_linked_respawn` VALUES 
(93838,93838);

-- HG / 2
UPDATE `creature_template` SET `mindmg`='226',`maxdmg`='294',`mechanic_immune_mask`='1' WHERE `entry` = 17429; -- 140 276 -- 452 - 588

--
UPDATE `creature` SET `spawnmask`='1',`id`='1000033',`position_x`='16251.6015', `position_y`='16295.9707', `position_z`='13.1745', `orientation`='1.4473',`spawndist`='0',`movementtype`='0' WHERE `guid` = '16800595'; -- > Move to Dev Land

-- Outland Herb Spawn Pools
--
-- MASTER Herbs Hellfire Peninsula zone 3483
UPDATE `pool_template` SET `max_limit`='30' WHERE `entry` IN ('972'); -- 60
-- MASTER Herbs Zangarmarsh zone 3521
UPDATE `pool_template` SET `max_limit`='55' WHERE `entry` IN ('975'); -- 95
-- MASTER Herbs Terokkar Forest zone 3519
UPDATE `pool_template` SET `max_limit`='35' WHERE `entry` IN ('977'); -- 65 
-- MASTER Herbs Nagrand zone 3518
UPDATE `pool_template` SET `max_limit`='30' WHERE `entry` IN ('973'); -- 40 
-- MASTER Herbs Blade's Edge Mountains zone 3522
UPDATE `pool_template` SET `max_limit`='25' WHERE `entry` IN ('978'); -- 35
-- MASTER Herbs Netherstorm zone 3523
UPDATE `pool_template` SET `max_limit`='15' WHERE `entry` IN ('974'); -- 40
-- MASTER Herbs Shadowmoon Valley zone 3520
UPDATE `pool_template` SET `max_limit`='25' WHERE `entry` IN ('976'); -- 45
--
--
-- new world krautz
-- Ragveil 183043 181275
-- Felweed 183044 181270
-- Dreaming Glory 183045 181271 181272
-- Blindweed (142143 old world only) 183046(tbc)
-- Flame Cap 181276
-- Terocone 181277
-- Ancient Lichen 181278 (only dungeons)
-- Netherbloom 181279(netherstorm)181282(dungeons)
-- Nightmare Vine 181280 181285
-- Mana Thistle 181281 181284(flightmount)
-- Nethercite Deposit 185877
-- Netherdust Bush 185881
-- Netherwing Egg 185915 + Netherwing Egg Trap 185600
-- SELECT * FROM `gameobject` WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881,185915,185600) AND `map`=530;
--
UPDATE `gameobject` SET `spawntimesecs`=300,`animprogress`=100 WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881,185915,185600) AND `map`=530; -- 2700

-- Missing Loottables thx@Satuin
DELETE FROM `creature_loot_template` WHERE `entry` IN (19973,20557,22174,22175,22180,22181,22182,22195,22196,22204,22217,22221,22241,22242,22243,22244,22254,22255,22275,22281,22287,22289,22291,22298,23061,23261,23281,23282,23333,23353,23354,23355,23386);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19230, 0.0116, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19231, 0.0116, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19259, 0.0058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19260, 0.0058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19261, 0.0058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19269, 0.0116, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19270, 0.0058, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 19279, 0.0231, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 21877, 33.4238, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 22925, 2.13, 0, 1, 1, 7, 171, 1);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24012, 0.5, 1, -24012, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 27854, 3.7773, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 27860, 1.906, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 29550, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 31952, 0.0116, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (19973, 32569, 73, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 23427, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 23883, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 23884, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 25418, 80.362, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 25421, 18.7473, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 31952, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (20557, 32569, 8.3465, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22174, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22174, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22174, 25455, 26.9231, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22174, 25457, 73.0769, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 22532, 0.01, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24093, 0.5, 1, -24093, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24519, 79.9075, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 24521, 18.5318, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 25455, 0.1405, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 25457, 0.4142, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 27854, 4.1198, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 27860, 2.1598, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22175, 32569, 33.1139, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 22786, 0.0075, 0, 2, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 25441, 79.898, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 25443, 18.7819, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 31952, 0.0225, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22180, 32569, 45, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 22576, 30.5996, 0, 1, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 22793, 0.0214, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 23154, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 23804, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24093, 0.5, 1, -24093, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24508, 72.5696, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 24511, 17.7944, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 25426, 6.531, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 25428, 1.3062, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 31952, 0.0642, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 32567, 100, 0, 1, 1, 9, 10980, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22181, 32569, 31.0921, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 24093, 0.5, 1, -24093, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 25435, 80.757, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 25437, 18.7518, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 31952, 0.0289, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22182, 32569, 22.768, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 19230, 0.0104, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 19260, 0.0209, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 19269, 0.0209, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 19270, 0.0104, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 19271, 0.0313, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 19278, 0.0104, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 21877, 38.1886, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 22793, 0.0209, 0, 2, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 23810, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 23883, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24012, 0.5, 1, -24012, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 24093, 0.5, 1, -24093, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 27854, 4.2362, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 27860, 2.4729, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 29550, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 29740, 0.7, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 30809, 10, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 31952, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22195, 32569, 46, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22196, 21877, 55.5556, 0, 4, 6, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22196, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22196, 27854, 5.5556, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 19232, 0.0591, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 21877, 35.9929, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 22153, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 22793, 0.04, 0, 2, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 23436, 0.0591, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 23884, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 27854, 3.6643, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 27860, 2.1277, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 29740, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 30809, 13, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 31501, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22204, 32569, 45, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 21877, 37.8436, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 27854, 5.4968, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22217, 27860, 2.1142, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22221, 21877, 35.8744, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22221, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22221, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22221, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22221, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22221, 27857, 5.8296, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22221, 27860, 2.2422, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 162, 0.01, 1, -10006, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 19232, 0.0109, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 19259, 0.0109, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 19261, 0.0109, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 21877, 34.9913, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 24093, 0.5, 1, -24093, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 27857, 4.3835, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 27860, 2.0114, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 29460, 3, 0, 1, 1, 8, 10970, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 31952, 0.0109, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 32569, 47, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22241, 34248, -22, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 136, 0.01, 1, -10006, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 19260, 0.0094, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 19270, 0.0094, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 21877, 35.5213, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 22555, 1, 0, 1, 1, 7, 333, 1);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 27857, 4.4295, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 27860, 2.4462, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 29460, 3, 0, 1, 1, 8, 10970, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 31952, 0.0567, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 32569, 45, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22242, 34248, -22, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 19231, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 19259, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 19260, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 19270, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 21877, 35.0039, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 27857, 4.1989, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 27860, 2.0205, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 29460, 3, 0, 1, 1, 8, 10970, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 31952, 0.0079, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 32569, 48, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22243, 34248, -22, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 77, 0.01, 1, -10006, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 22576, 33.179, 0, 1, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 22793, 0.04, 0, 1, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 23884, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24012, 0.5, 1, -24012, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24015, 0.1, 1, -24015, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24508, 80.5987, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 24511, 18.5991, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 29460, 3, 0, 1, 1, 8, 10970, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 31952, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 32569, 34, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22244, 34248, -22, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 21877, 34.2627, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 27857, 4.6649, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 27860, 2.1984, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 29550, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 29740, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 30809, 13, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 31952, 0.0536, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22254, 32569, 45, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22255, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22255, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22255, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22255, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22255, 27934, 78.157, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22255, 27935, 20.1365, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 4552, 48.5095, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 4554, 13.5501, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32670, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32672, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32673, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32674, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32675, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32676, 1.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32677, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22275, 32697, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 21877, 26.506, 0, 4, 5, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 24001, 5, 1, -24001, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 27854, 3.6145, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 27860, 9.6386, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32670, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32673, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32674, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32675, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32676, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32677, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32678, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22281, 32733, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22287, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22287, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22287, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22287, 24013, 1, 1, -24013, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22287, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22287, 25413, 77.5792, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22287, 25415, 21.2407, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22289, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22289, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22289, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22289, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22289, 24013, 1, 1, -24013, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 21877, 36.4341, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 22903, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 24009, 1, 1, -24009, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 27854, 3.6176, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 27860, 2.584, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 29550, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 29740, 0.9, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 30809, 14, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 31952, 0.04, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22291, 32569, 47, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 7078, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 22574, 35, 0, 1, 2, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24009, 1, 1, -24009, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24012, 0.5, 1, -24012, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24508, 80.3911, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 24511, 19.1158, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 31952, 0.0048, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (22298, 32569, 33, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 24002, 5, 1, -24002, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 29549, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 29563, 25.1, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 29564, 5.7, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 31837, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32569, 92, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32670, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32672, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32674, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32675, 1.2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32676, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32677, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32678, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32679, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32681, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23061, 32732, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 22153, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 29549, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 29563, 27.2, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 29564, 5.1, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32569, 92, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32670, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32671, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32673, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32674, 0.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32675, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32676, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32677, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32678, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32679, 4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32683, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23261, 32732, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 24013, 1, 1, -24013, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 29563, 23.6, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 29564, 7, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32569, 93, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32670, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32672, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32673, 1.1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32674, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32675, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32676, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32677, 1.1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32678, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32679, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32684, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23281, 32732, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 24002, 5, 1, -24002, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 29563, 23.6, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 29564, 5, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32569, 93, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32670, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32673, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32674, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32675, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32676, 1.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32677, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32679, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32682, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23282, 32732, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23333, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 24002, 5, 1, -24002, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 25418, 33.9, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 25421, 8, 0, 2, 4, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32670, 6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32672, 0.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32674, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32676, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32677, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32678, 0.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23353, 32733, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 21877, 21.1, 0, 4, 6, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 24001, 5, 1, -24001, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 27854, 1.7, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 27860, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32670, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32672, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32673, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32674, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32675, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32676, 1.4, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32677, 1.8, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23354, 32733, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 21877, 16.9, 0, 4, 6, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 22903, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 24002, 5, 1, -24002, 1, 0, 0, 0); 
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 24092, 0.5, 1, -24092, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 27854, 2.6, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 27860, 0.5, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32670, 1.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32674, 1.6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32675, 1.3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32676, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32677, 1.9, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32679, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23355, 32733, -100, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 22532, 0.01, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 22548, 0.03, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 23427, 0.08, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24001, 5, 1, -24001, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24009, 1, 1, -24009, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24011, 1, 1, -24011, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24012, 0.5, 1, -24012, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24014, 0.5, 1, -24014, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24015, 0.1, 1, -24015, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 24093, 0.5, 1, -24093, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 29550, 0.08, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 29740, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 30809, 14, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 31952, 0.1, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 32569, 50, 0, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (23386, 34114, 1.43, 0, 1, 1, 7, 202, 1);

-- move
UPDATE `creature` SET `position_x`='16181.4453', `position_y`='16187.4121', `position_z`='72.3692', `orientation`='4.7237',`spawndist`='0',`movementtype`='0',`curhealth`='10000',`map`='451' WHERE `guid` = '16800595';

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '20555';
INSERT INTO `creature_ai_scripts` VALUES
(2055501,20555,9,0,100,1,0,40,8000,16000,11,38783,1,0,0,0,0,0,0,0,0,0,'Goc - Casts Boulder Volley on Aggro'),
(2055502,20555,0,0,100,1,6000,6000,14000,15000,11,38784,0,7,11,38785,0,7,0,0,0,0,'Goc - Casts Ground Smash'),
(2055503,20555,1,0,100,1,30000,30000,1000,1000,41,0,0,0,0,0,0,0,0,0,0,0,'Goc  - Despawn OOC');

-- Lurker Trash
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (93838,183607,82966,93837,93840,93841,82861,172713,173195,93789,183141,93829,82965,93834,93830,93787,175587,175857,93831,182677,93820,93815,93824,93825,82036,176722,176935,82032,181841,93823,93821,93822,93819,82002,177699,81997,82003,180803,93816,82964,93827,93818,81917,81916,80273,81944,179801,93842,82955,93844,93826,81029,80445,80274,80473);
INSERT INTO `creature_linked_respawn` VALUES 
(93838,93838),(183607,93838),
(82966,93838),(93837,93838),
(93840,93838),(93841,93838),
(82861,93838),(172713,93838),
(173195,93838),(93789,93838),
(183141,93838),(93829,93838),
(82965,93838),(93834,93838),
(93830,93838),(93787,93838),
(175587,93838),(175857,93838),
(93831,93838),(182677,93838),
(93820,93838),(93815,93838),
(93824,93838),(93825,93838),
(82036,93838),(176722,93838),
(176935,93838),(82032,93838),
(181841,93838),(93823,93838),
(93821,93838),(93822,93838),
(93819,93838),(82002,93838),
(177699,93838),(81997,93838),
(82003,93838),(180803,93838),
(93816,93838),(82964,93838),
(93827,93838),(93818,93838),
(81917,93838),(81916,93838),
(80273,93838),(81944,93838),
(179801,93838),(93842,93838),
(82955,93838),(93844,93838),
(93826,93838),(81029,93838),
(80445,93838),(80274,93838),
(80473,93838);

-- Skull Pile 185913 & Ancient Skull Pile 185928
UPDATE `gameobject` SET `spawntimesecs`='900' WHERE `id` = 185928; -- 180
UPDATE `gameobject` SET `spawntimesecs`='300' WHERE `id` = 185913; -- 180

-- Ogrila & Skettis

UPDATE `creature` SET `spawnmask`=0 WHERE `id` IN (22221,22217,22218,22287,22289,22451,22174,22283,22385);
UPDATE `creature` SET `id` = 23029 WHERE `id` = 21844; -- 23029

-- 100 % flee
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('22134');
UPDATE `creature_template_addon` SET `auras`='18950 0 18950 1' WHERE `entry` IN ('22134');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22134');
INSERT INTO `creature_ai_scripts` VALUES
('2213401','22134','4','0','100','7','0','0','0','0','25','0','0','0','1','-48','0','0','0','0','0','0','Shadowmoon Eye of Kilrogg - Flee and Emote on Aggro');

-- Movement for Main
UPDATE `creature` SET `spawndist`='10',`MovementType`='1' WHERE `id` IN (19973,20557);

UPDATE `creature` SET `position_x`='2914.7097', `position_y`='6825.4423', `position_z`='364.5552', `orientation`='1.3445',`spawndist`='30',`movementtype`='1' WHERE `guid` = '78317';
UPDATE `creature` SET `position_x`='3061.0886', `position_y`='6877.4321', `position_z`='364.2837', `orientation`='1.4123',`spawndist`='30',`movementtype`='1' WHERE `guid` = '78318';
UPDATE `creature` SET `position_x`='3035.4667', `position_y`='6964.9379', `position_z`='363.9218', `orientation`='3.5176',`spawndist`='30',`movementtype`='1' WHERE `guid` = '78319';
UPDATE `creature` SET `position_x`='2849.3425', `position_y`='6940.5717', `position_z`='365.2920', `orientation`='0.6827',`spawndist`='30',`movementtype`='1' WHERE `guid` = '78320';
UPDATE `creature` SET `position_x`='2877.4897', `position_y`='7084.7822', `position_z`='364.9580', `orientation`='2.2578',`spawndist`='30',`movementtype`='1' WHERE `guid` = '78321';
UPDATE `creature` SET `position_x`='2976.6188', `position_y`='7086.7958', `position_z`='364.1542', `orientation`='5.2758',`spawndist`='30',`movementtype`='1' WHERE `guid` = '78322';
UPDATE `creature` SET `position_x`='2984.4492', `position_y`='6815.9365', `position_z`='369.9805', `orientation`='4.9337',`spawndist`='30',`movementtype`='1' WHERE `guid` = '78323';

-- Witness of Doom
UPDATE `creature_template` SET `speed`='1.71',`AIName`='EventAI' WHERE `entry` = 22282;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '22282';
INSERT INTO `creature_ai_scripts` VALUES
('2228201','22282','4','0','100','0','0','0','0','0','25','0','0','0','1','-48','0','0','0','0','0','0','Witness of Doom - Flee and Emote on Aggro'),
('2228202','22282','0','0','100','1','10000','10000','1000','1000','41','0','0','0','0','0','0','0','0','0','0','0','Witness of Doom - Despawn IC'),
(2228203,22282,6,0,100,0,0,0,0,0,11,40828,0,3,0,0,0,0,0,0,0,0,'Banished - Cast Credit on Master on Death');

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (37951,37987,37991,37989,80273,93854,93883);
INSERT INTO `creature_linked_respawn` VALUES
(93883,82974),
--
(93854,93773),
--
(37951,93814),
(37987,93814),
(37991,93814),
(37989,93814);

DELETE FROM `creature_loot_template` WHERE `entry` IN (23333,23390,23391);
-- The Grand Collector 23333
INSERT INTO `creature_loot_template` VALUES (23333, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 21877, 33, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32670, 6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32671, 3, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32672, 6, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32673, 0.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32674, 1.7, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32675, 0.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32676, 5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32677, 0.5, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23333, 32679, 0.7, 3, 1, 1, 0, 0, 0);
--
-- Bash'ir 23391
INSERT INTO `creature_loot_template` VALUES (23391, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32773, 5, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 21877, 33, 0, 2, 3, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32670, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32671, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32672, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32673, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32674, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32675, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32676, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32677, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32678, 2, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23391, 32679, 2, 3, 1, 1, 0, 0, 0);
--
-- Bash'ir's Harbinger 23390
INSERT INTO `creature_loot_template` VALUES (23390, 21877, 27.3, 0, 4, 5, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 24002, 5, 1, -24002, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 24013, 1, 1, -24013, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 24035, 2, 1, -24035, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32773, 5, 1, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32572, 0, 2, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32670, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32671, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32672, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32673, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32674, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32675, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32676, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32677, 1, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32678, 11, 3, 1, 1, 0, 0, 0);
INSERT INTO `creature_loot_template` VALUES (23390, 32679, 0.3, 3, 1, 1, 0, 0, 0);

-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/760/weapons-on-guards
--
--
-- korkron-defender
-- By Skullhawk13 (33,001 – 9·28·288) on 2015/05/28 (Patch 6.1.2)       
-- They will use a sword and shield, or a two-handed mace...Apparently These orcs are too good for axes.
UPDATE `creature_template` SET `equipment_id`='8021' WHERE `entry` IN ('19362');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8021');
INSERT INTO `creature_equip_template` VALUES
(8021,36079,0,0,285345026 ,0,0,1,0,0);
-- some npcs only
UPDATE `creature` SET `equipment_id`='8022' WHERE `guid` IN ('69079','69090','69078','78928','69075','69083');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8022');
INSERT INTO `creature_equip_template` VALUES
(8022,31997,31746,0,218171138,234948100,0,3,1038,0);

-- Targrom & Friends
UPDATE `creature` SET `position_x`='-2939.3872', `position_y`='2675.1628', `position_z`='93.6803', `orientation`='4.4358',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('68964');
-- Kor'kron Defender
UPDATE `creature` SET `movementtype`='0' WHERE `guid` IN (69092);
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN (69091);
UPDATE `creature` SET `position_x`='-3087.8986', `position_y`='2449.5834', `position_z`='63.9052', `orientation`='3.0394',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('69075');
UPDATE `creature` SET `position_x`='-2925.4338', `position_y`='2645.5607', `position_z`='93.6541', `orientation`='3.8796',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69077');
UPDATE `creature` SET `position_x`='-3124.9436', `position_y`='2569.8483', `position_z`='61.6758', `orientation`='3.5315',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69085');
UPDATE `creature` SET `position_x`='-2933.5161', `position_y`='2643.6137', `position_z`='93.6493', `orientation`='3.8992',`spawndist`='0',`movementtype`='2' WHERE `guid` IN ('69078');
-- Trop Rendlimb
UPDATE `creature` SET `position_x`='-2903', `position_y`='2615', `position_z`='93.6802', `orientation`='2.8521',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('68959');
-- Kalara
UPDATE `creature` SET `position_x`='-2906.5869', `position_y`='2603.2880', `position_z`='93.6802', `orientation`='2.4398',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('68961');
-- Gedrah
UPDATE `creature` SET `position_x`='-3023', `position_y`='2618', `position_z`='76.7027', `orientation`='3.8246',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('74708');
-- Detrafila
UPDATE `creature` SET `position_x`='-3023.0000', `position_y`='2616.0000', `position_z`='76.7956', `orientation`='3.000',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('74713');
DELETE FROM `creature_addon` WHERE `guid` IN ('74713');
INSERT INTO `creature_addon` VALUES
(74713,0,0,0,3,0,0,0,'');
-- Kor'kron Rider
UPDATE `creature` SET `position_x`='-3062.0314', `position_y`='2493.9934', `position_z`='64.7782', `orientation`='4.5601',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69097');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19364');
INSERT INTO `creature_template_addon` VALUES 
(19364,0,17408,16777472,0,4097,0,0,'');
--
UPDATE `creature` SET `movementtype`='0',`spawndist`='0' WHERE `id` IN ('19355');
UPDATE `creature` SET `position_x`='-3127.2180', `position_y`='2493.1831', `position_z`='61.8622', `orientation`='0.4197',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69055');
UPDATE `creature` SET `position_x`='-2965', `position_y`='2664', `position_z`='98.6647', `orientation`='00000',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69056');
UPDATE `creature` SET `position_x`='-2959', `position_y`='2578', `position_z`='76.6325', `orientation`='3.3455',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69058');
UPDATE `creature` SET `position_x`='-3037', `position_y`='2523', `position_z`='62.7889', `orientation`='6.0200',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69062');
UPDATE `creature` SET `position_x`='-3035.8466', `position_y`='2527.9194', `position_z`='63.2220', `orientation`='4.9057',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69063');
UPDATE `creature` SET `position_x`='-3139.5117', `position_y`='2453.2272', `position_z`='63.8940', `orientation`='4.2945',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69067');
UPDATE `creature` SET `position_x`='-3107.6000', `position_y`='2458.1030', `position_z`='62.8081', `orientation`='4.9489',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69068');
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
DELETE FROM `creature_formations` WHERE `leaderGUID`=69091;
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

-- Phoenix 21362
-- http://www.wowhead.com/npc=21362/phoenix#abilities 
-- ~ 177458 + 10% 195204 -> 253765
-- added stun immunity
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='2278',`maxdmg`='3309',`resistance2`='0',`mechanic_immune_mask`='1073561599',`flags_extra`='4194304' WHERE `entry` IN ('21362'); -- 1001 2046 -- 5,572 - 6,617

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21220;
INSERT INTO `creature_ai_scripts` VALUES
('2122001','21220','1','0','100','2','0','0','0','0','21','1','0','0','22','0','0','0','19','6','0','0','Coilfang Priestess - Start Movement and Set Phase to 0 OOC'),
('2122002','21220','4','0','100','2','0','0','0','0','22','1','0','0','42','1','0','0','39','50','0','0','Coilfang Priestess - Set Phase 1 and Set Minhealth to 1 and Call for Help on Aggro'),
('2122003','21220','9','6 ','100','3','0','50','5000','7000','11','38582','1','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Smite (Phase 1)'),
('2122004','21220','9','6 ','100','3','0','8','5000','10000','11','38589','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Nova (Phase 1)'),
('2122005','21220','3','6 ','100','2','7','0','0','0','21','1','0','0','22','2','0','0','0','0','0','0','Coilfang Priestess - Start Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2122006','21220','9','6 ','100','2','45','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Start Movement at 45 Yards (Phase 1)'),
('2122007','21220','9','6 ','100','2','5','40','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Prevent Movement at 30 Yards (Phase 1)'),
('2122008','21220','9','6 ','100','2','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Start Movement Below 5 Yards (Phase 1)'),
('2122009','21220','3','5','100','3','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2122010','21220','9','4','100','3','0','45','10400','14200','11','38585','4','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Fire'),
('2122011','21220','14','4','100','3','40000','40','5000','10000','11','38580','6','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal on Friendlies'),
('2122012','21220','2','4','100','2','80','0','15000','20000','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 80% HP'),
('2122013','21220','2','4','100','2','50','0','0','0','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 50% HP'),
('2122014','21220','2','4','100','2','20','0','0','0','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 20% HP'),
('2122015','21220','9','4','100','3','0','30','5400','7200','11','37275','4','32','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Shadow Word: Pain'),
('2122016','21220','2','0','100','2','1','0','0','0','11','38589','0','7','3','0','16031','0','22','3','0','0','Coilfang Priestess - Cast Holy Nova and Morph and Set Phase 3 at 1% HP'),
('2122017','21220','2','0','100','2','1','0','0','0','21','0','0','0','20','0','0','0','18','6','0','0','Coilfang Priestess - Stop Movement and Stop Melee and Set Unattackable at 1% HP'),
('2122018','21220','14','3','100','3','1000','40','2000','2000','11','38580','6','1','21','0','0','0','20','0','0','0','Coilfang Priestess - Cast Greater Heal and Stop Movement and Stop Melee on Friendlies (Phase 3)'),
('2122019','21220','7','0','100','2','0','0','0','0','22','0','0','0','3','0','0','0','19','6','0','0','Coilfang Priestess - Set Phase 0 and Demorph and Set Attackable on Evade'),
('2122020','21220','7','0','100','2','0','0','0','0','21','1','0','0','20','1','0','0','0','0','0','0','Coilfang Priestess - Start Movement and Melee on Evade'),
('2122021','21220','0','3','100','2','14750','14750','0','0','34','24','1','0','3','0','0','0','0','0','0','0','Coilfang Priestess - Set Instance Data 1 and Demorph to 0 (Phase 3)'),
('2122022','21220','0','3','100','2','15000','15000','0','0','42','0','0','0','37','0','0','0','0','0','0','0','Coilfang Priestess - Set Minhealth to 0 and Die after 15sec (Phase 3)');

-- Captain Alina 17290
UPDATE `creature_template` SET `faction_A`='1737',`faction_H`='1737' WHERE `entry` = 17290; -- 1666

-- Lair Brute - Schläger des Unterschlupfs
UPDATE `creature_template` SET `minhealth`='298298',`maxhealth`='298298',`armor`='7400',`speed`='1.48',`mindmg`='11000',`maxdmg`='12850',`baseattacktime`='1400',`mechanic_immune_mask`=617299827 WHERE `entry` = 19389; -- 298298 ba 1400 -- 4259 5159 -- 12257 12857 -- 14709 15429 -- 18,386 - 19,286
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` = 19389;
INSERT INTO `creature_ai_scripts` VALUES
('1938901','19389','4','0','100','2','0','0','0','0','30','1','2','3','0','0','0','0','0','0','0','0','Lair Brute - Random Phase on Aggro'),
('1938902','19389','9','13','100','3','0','5','8000','12000','11','39171','1','1','30','1','2','3','0','0','0','0','Lair Brute - Cast Mortal Strike and Select Random Phase (Phase 1)'),
('1938903','19389','9','11','100','3','0','5','6000','8000','11','39174','1','1','30','1','2','3','0','0','0','0','Lair Brute - Cast Cleave and Select Random Phase (Phase 2)'),
('1938904','19389','9','7','100','3','8','25','11000','18000','11','24193','5','1','30','1','2','3','14','-99','0','0','Lair Brute - Cast Charge and Select Random Phase (Phase 3)'),
('1938905','19389','2','0','100','2','15','0','0','0','39','90','0','0','1','-551','0','0','0','0','0','0','Lair Brute - Call for Help and and Text Emote at 15% HP');

-- Enchanted Elemental 21958
-- mob_enchanted_elemental 7700
UPDATE `creature_template` SET `speed`='1.20',`mechanic_immune_mask`='109264767' WHERE `entry` IN ('21958'); --
UPDATE `creature_model_info` SET `bounding_radius`='2' WHERE `modelid` = 20076; -- 0.61112

-- Spectral Retainer -- one hand sword
-- http://www.wowhead.com/npc=16410/spectral-retainer#screenshots:id=47157
UPDATE `creature_template` SET `modelid_A2`='16511',`modelid_H2`='16511',`armor`='7400',`speed`='1.38',`mechanic_immune_mask`='8917521',`flags_extra`='65536',`equipment_id`='1' WHERE `entry` = 16410;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16410;
INSERT INTO `creature_ai_scripts` VALUES
('1641001','16410','9','0','100','3','0','5','6000','12000','11','29578','4','32','0','0','0','0','0','0','0','0','Spectral Retainer - Cast Rend'),
('1641002','16410','0','0','100','3','9000','13000','18000','22000','11','29546','5','1','0','0','0','0','0','0','0','0','Spectral Retainer - Cast Oath of Fealty'),
('1641003','16410','4','0','50','2','0','0','0','0','1','-9968','-9967','0','0','0','0','0','0','0','0','0','Spectral Retainer - Random Say on Aggro'),
('1641004','16410','6','0','20','2','0','0','0','0','1','-9969','0','0','0','0','0','0','0','0','0','0','Spectral Retainer - Say on Death'),
('1641005','16410','0','0','100','3','13000','15000','22000','22000','11','32375','4','1','0','0','0','0','0','0','0','0','Spectral Retainer - Cast Massdespell');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16411;
INSERT INTO `creature_ai_scripts` VALUES
('1641101','16411','0','0','100','3','4000','8000','5000','10000','11','29665','1','0','0','0','0','0','0','0','0','0','Spectral Chef - Cast Cleave'),
('1641102','16411','9','0','100','3','0','5','8000','12000','11','29667','1','1','0','0','0','0','0','0','0','0','Spectral Chef - Cast Hamstring'),
('1641103','16411','4','0','50','2','0','0','0','0','1','-9829','-9828','-9827','0','0','0','0','0','0','0','0','Spectral Chef - Random Say on Aggro'),
('1641104','16411','6','0','20','2','0','0','0','0','1','-9962','-9961','-9960','0','0','0','0','0','0','0','0','Spectral Chef - Say on Death');

-- Fel Overseer 18796,20652
UPDATE `creature` SET `spawndist`='0' WHERE `id` = 18796;
UPDATE `creature_template` SET `mechanic_immune_mask`='4325377',`mindmg`='969',`maxdmg`='1324' WHERE `entry` = 18796; -- 382 666 -- 775 - 1,059
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18796',`equipment_id`='1075',`mechanic_immune_mask`='4325377',`mindmg`='6567',`maxdmg`='7164' WHERE `entry` = 20652; -- 1773 2519 -- 4105 4478 -- 8,209 - 8,955
DELETE FROM `creature_template_addon` WHERE `entry` IN (18796,20652);
INSERT INTO `creature_template_addon` VALUES
(18796,0,0,16908544,0,4097,0,0,''),
(20652,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18796;
INSERT INTO `creature_ai_scripts` VALUES
('1879601','18796','4','0','5','6','0','0','0','0','1','-9983','-9982','-9959','0','0','0','0','1','0','0','0','Fel Overseer - Random Say on Aggro'),
('1879602','18796','9','0','100','7','0','25','15000','15000','11','27577','4','0','0','0','0','0','0','0','0','0','Fel Overseer - Cast Intercept on Aggro Range 25'),
('1879603','18796','0','0','100','7','9000','12000','9000','15000','11','30471','1','0','0','0','0','0','0','0','0','0','Fel Overseer - Cast Uppercut'),
('1879604','18796','9','0','100','5','0','5','8000','12000','11','16856','1','0','0','0','0','0','0','0','0','0','Fel Overseer (Heroic) - Cast Mortal Strike'),
('1879605','18796','0','0','100','7','30000','30000','30000','30000','11','19134','1','1','0','0','0','0','0','0','0','0','Fel Overseer (Heroic) - Cast Frightening Shout every 30 Secs'),
('1879606','18796','6','0','20','6','0','0','0','0','1','-9958','-9957','-9981','0','0','0','0','0','0','0','0','Fel Overseer - Say on Death');

-- Malicious Instructor 18848,20656
UPDATE `creature` SET `spawndist`='0' WHERE `id` IN ('18848');
UPDATE `creature_template` SET `maxlevel`='70',`mechanic_immune_mask`='4325377',`armor`='6800',`mindmg`='824',`maxdmg`='1113' WHERE `entry` IN ('18848'); -- 427 716
UPDATE `creature_template` SET `minlevel`='71',`armor`='7100',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18848',`equipment_id`='1676',`mechanic_immune_mask`='4325377',`mindmg`='3601',`maxdmg`='4274' WHERE `entry` IN ('20656'); -- 972 1982 -- 2701 3206 -- 5,401 - 6,411
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18848','20656');
INSERT INTO `creature_template_addon` VALUES
(18848,0,0,66048,0,4097,0,0,''),
(20656,0,0,66048,0,4097,0,0,'');   
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18848');
INSERT INTO `creature_ai_scripts` VALUES
(1884801,18848,4,0,10,7,0,0,0,0,1,-9999,-9980,-9958,0,0,0,0,0,0,0,0,'Malicious Instructor - Say on Aggro'),
(1884802,18848,0,0,100,7,5400,5400,12000,12000,11,33493,1,32,20,1,0,0,0,0,0,0,'Malicious Instructor - Cast Mark of Malice & Start Autoattack again'),
(1884803,18848,0,0,100,7,7000,7000,12000,12000,11,33501,0,0,0,0,0,0,0,0,0,0,'Malicious Instructor - Cast Shadow Nova'),
(1884804,18848,0,0,100,9,0,5,10000,20000,11,6713,1,0,0,0,0,0,0,0,0,0,'Malicious Instructor - Cast Disarm HC Only'),
(1884805,18848,4,0,100,7,0,0,0,0,11,29651,0,0,0,0,0,0,0,0,0,0,'Malicious Instructor - Cast Dual Wield on Aggro'),
(1884806,18848,6,0,20,6,0,0,0,0,1,-9959,-9958,-9981,0,0,0,0,0,0,0,0,'Malicious Instructor - Say on Death');

-- 24959
UPDATE `creature` SET `spawndist`='0',`movementtype`='0' WHERE `guid` = '97064';

-- Sethekk Spirit 18703,20700
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`speed`='1',`mechanic_immune_mask`='653230079',`unit_flags`='33554688',`flags_extra`='1048576',`speed`='1' WHERE `entry` = 18703;
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`speed`='1',`mechanic_immune_mask`='653230079',`unit_flags`='33554688',`flags_extra`='1048576',`mindmg`='3825',`maxdmg`='4758',`speed`='1' WHERE `entry` = 20700; -- 2000 3000 -- 5,737 - 7,137
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18703;
INSERT INTO `creature_ai_scripts` VALUES
('1870301','18703','11','0','100','6','0','0','0','0','11','24051','0','7','0','0','0','0','0','0','0','0','Sethekk Spirit - Cast Spirit Burst on Spawn');

-- Time-Lost Controller 18327,20691
-- Immune to CC 
UPDATE `creature_template` SET `armor`='5200',`mechanic_immune_mask`='13111315' WHERE `entry` = 18327; -- kleiner gebogener Holzstock wie die Furbolgs
UPDATE `creature_template` SET `armor`='5950',`minmana`='35980',`maxmana`='35980',`speed`='1.48',`lootid`='18327',`mindmg`='1181',`maxdmg`='1421',`mechanic_immune_mask`='13111315' WHERE `entry` = 20691; -- 411 890
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18327;
INSERT INTO `creature_ai_scripts` VALUES
('1832701','18327','4','0','15','7','0','0','0','0','1','-1240','-1241','-1244','0','0','0','0','0','0','0','0','Time-Lost Controller - Random Say on Aggro'),
('1832702','18327','9','0','100','7','0','5','17800','28300','12','20343','0','30000','0','0','0','0','0','0','0','0','Time-Lost Controller - Summon Charming Totem'), -- spell 32764 bugged
('1832703','18327','9','0','100','7','0','15','10000','15000','11','35013','4','32','0','0','0','0','0','0','0','0','Time-Lost Controller - Cast Shrink'),
('1832705','18327','1','0','100','7','1000','1000','900000','900000','11','32689','0','1','0','0','0','0','0','0','0','0','Time-Lost Controller - Cast Arcane Destruction OCC'),
('1832706','18327','0','0','100','7','10000','10000','5000','5000','11','32689','0','32','0','0','0','0','0','0','0','0','Time-Lost Scryer - Cast Arcane Destruction on Missing Arcane Destruction Aura');

-- Charming Totem 20343,20687
UPDATE `creature_template` SET `minlevel`='67',`maxlevel`='67',`minhealth`='2000',`maxhealth`='2000',`faction_A`='16',`faction_H`='16',`armor`='0',`speed`='0',`mindmg`='0',`maxdmg`='0',`unit_flags`='131072',`resistance5`='-1',`mechanic_immune_mask`='1073741823',`flags_extra`='196732' WHERE `entry` = 20343;
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`minhealth`='5000',`maxhealth`='5000',`faction_A`='16',`faction_H`='16',`speed`='0',`mindmg`='0',`maxdmg`='0',`unit_flags`='131072',`resistance5`='-1',`mechanic_immune_mask`='1073741823',`flags_extra`='196732' WHERE `entry` = 20687;
DELETE FROM `creature_template_addon` WHERE `entry` IN (20343,20687); 
INSERT INTO `creature_template_addon` VALUES
(20343,0,0,0,0,0,0,0,''),
(20687,0,0,0,0,0,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20343;
INSERT INTO `creature_ai_scripts` VALUES
('2034301','20343','0','0','100','7','2500','4500','15000','15000','11','37122','4','7','20','0','0','0','21','0','0','0','Charming Totem - Cast Charm and Stop Melee and Stop Movement on Aggro'), -- 
('2034302','20343','1','0','100','7','15000','15000','1000','1000','41','0','0','0','0','0','0','0','0','0','0','0','Charming Totem - Despawn OOC');

-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2232/coilfang-serpentshrine-cavern
-- 
--
-- ======================================================
-- Texts & Scripts
-- ======================================================
--
-- -9700 - -9710
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-9700,-9701,-9702,-9703,-9704,-9705,-9706,-9707);
INSERT INTO `creature_ai_texts` VALUES
(-9700,'Be wary of intruders.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21299 OOC'),
(-9701,'Stay alert!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21299 OOC'),
(-9702,'Understood.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21298 answer to 21299'),
(-9703,'Enough! I have had enough of you filthy warm bloods!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'21218 on 50% Enrage'),
(-9704,'Don\'t let the levels get too low.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21218 OOC'),
(-9705,'FASTER!!!!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21218 OOC'),
(-9706,'Keep regulating the main valve to ensure steady flow.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21218 OOC'),
(-9707,'We appear to be on target.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'21218 on Aggro?');
--
UPDATE `script_texts` SET `content_default`='Be gone, trifling elf. I am in control now!' WHERE `entry` = -1548010;
UPDATE `script_texts` SET `content_default`='Finally, my banishment ends!' WHERE `entry` = -1548009;
--
-- ======================================================
-- NPC Research
-- ======================================================
--
-- Coilfang Frenzy 21508
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='500',`maxdmg`='800',`baseattacktime`='1000',`mechanic_immune_mask`='1073741823',`flags_extra`='536936448',`InhabitType`='2' WHERE `entry` = 21508; -- 1 392 696 2000 0 0
DELETE FROM `creature_template_addon` WHERE `entry` = 21508;
INSERT INTO `creature_template_addon` VALUES (21508,0,0,0,0,0,0,33554432,NULL);
--
-- Coilfang Frenzy Corpse 21689
-- Morogrim?
UPDATE `creature_template` SET `dynamicflags`='36' WHERE `entry` = 21689;
--
-- Colossus Rager 22352
-- http://www.wowhead.com/npc=22352/colossus-rager#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='1671',`maxdmg`='1985',`baseattacktime`='1400' WHERE `entry` = 22352; -- 300 614 2000
--
-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8358',`maxdmg`='9926',`baseattacktime`='1400',`resistance3`= -1,`mechanic_immune_mask`='1073692671' WHERE `entry` = 21863; -- 3003 6139 2000 1 -- 16,716 - 19,852
-- `mechanic_immune_mask`='1073561599' after patch 2.1
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21863;
INSERT INTO `creature_ai_scripts` VALUES
('2186301','21863','4','0','100','2','0','0','0','0','23','1','0','0','11','38655','1','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 and Cast Poison Bolt Volley on Aggro'),
('2186302','21863','9','5','100','3','3000','6000','4000','8000','11','38655','1','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Poison Bolt Volley (Phase 1)'),
('2186303','21863','24','5','100','3','38655','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 2 on Target Max Poison Bolt Volley Aura Stack (Phase 1)'),
('2186304','21863','28','3','100','3','38655','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 on Target Missing Poison Bolt Volley Aura Stack (Phase 2)'),
-- ('2186305','21863','9','0','100','3','0','5','18900','18900','11','38650','0','1','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'),
('2186306','21863','9','0','100','3','0','5','5000','10000','12','17990','1','20000','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Spawn Underbog Mushroom'),
('2186307','21863','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase to 0 on Evade');
--
-- Rancid Mushroom 22250
UPDATE `creature_template` SET `modelid_A`='11686',`modelid_H`='11686',`faction_A`='35',`faction_H`='35',`armor`='6800',`flags_extra`='0',`unit_flags`=`unit_flags`|'4'|'131072'|'262144'|'33554432',`speed`='0.0001',`mindmg`='0',`maxdmg`='0',`attackpower`='0' WHERE `entry` = 22250; -- 7999 7999 35 35 0 128 4
DELETE FROM `creature_template_addon` WHERE `entry` = 22250; 
INSERT INTO `creature_template_addon` VALUES
(22250,0,0,0,0,0,0,0,'38652 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22250;
INSERT INTO `creature_ai_scripts` VALUES
('2225001','22250','0','0','100','2','15000','15000','0','0','11','38652','0','7','0','0','0','0','0','0','0','0','Rancid Mushroom - Cast Spore Cloud befor Death'),
('2225002','22250','0','0','100','2','18000','18000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Rancid Mushroom - Despawn on Timer');
--
-- Trigger NPC for 17990
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'4'|'131072'|'262144' WHERE `entry` IN (17990,20189); -- 0
DELETE FROM `creature_template_addon` WHERE `entry` IN (17990,20189); 
INSERT INTO `creature_template_addon` VALUES
(17990,0,0,0,0,0,0,0,'31689 0'),
(20189,0,0,0,0,0,0,0,'31689 0');
--
-- Coilfang Beast-Tamer 21221
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='10577',`maxdmg`='12562',`mechanic_immune_mask`='1073692671'  WHERE `entry` = 21221; -- 3705 7576 -- 7933 9422 -- 15,865 - 18,843
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21221;
INSERT INTO `creature_ai_scripts` VALUES
('2122101','21221','9','0','100','3','5','35','2000','3000','11','38904','4','0','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Throw'),
('2122102','21221','9','0','100','3','0','5','4900','10900','11','38474','1','0','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Cleave'),
('2122103','21221','0','0','100','3','2000','9000','19300','23400','11','38484','0','1','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Bestial Wrath');
--
-- Coilfang Fathom-Witch 21299- http://wowwiki.wikia.com/wiki/Coilfang_Fathom-Witch?direction=next&oldid=784889
UPDATE `creature_template` SET `armor`='5700',`speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`mechanic_immune_mask`='1073692671'  WHERE `entry` = 21299; -- 5414 1513 3087 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21299;
INSERT INTO `creature_ai_scripts` VALUES
('2129901','21299','1','0','100','2','0','0','0','0','21','1','0','0','22','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Combat Movement and Set Phase to 0 on Spawn'),
('2129902','21299','4','0','100','2','0','0','0','0','11','38628','1','0','23','1','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('2129903','21299','9','5','100','3','0','45','5200','9200','11','38628','1','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Bolt (Phase 1)'),
('2129904','21299','3','5','100','2','7','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2129905','21299','9','5','100','2','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement at 35 Yards (Phase 1)'),
('2129906','21299','9','5','100','2','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Prevent Combat Movement at 15 Yards (Phase 1)'),
('2129907','21299','9','5','100','2','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement Below 5 Yards (Phase 1)'),
('2129908','21299','3','3','100','3','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2129909','21299','0','0','100','3','8200','12200','36300','49300','11','38627','0','1','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Nova'),
('2129910','21299','9','0','100','3','0','10','11900','16100','11','38626','5','1','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Domination on TARGET_T_HOSTILE_WPET_RANDOM_NOT_TOP'),
('2129911','21299','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Set Phase to 0 on Evade');
--
-- Coilfang Hate-Screamer 21339- http://wowwiki.wikia.com/wiki/Coilfang_Hate-Screamer
-- Silence: PBAoE silence for 4 seconds, 30 yard range. Nerfed 20yards atm
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5607',`maxdmg`='6657',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304' WHERE `entry` = 21339; -- 1913 4087 1 0 -- 4206 4993 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21339;
INSERT INTO `creature_ai_scripts` VALUES
('2133901','21339','0','0','100','3','5000','9000','10500','19600','11','38491','0','7','0','0','0','0','0','0','0','0','Coilfang Hate-Screamer - Cast PBAoE Silence'),
('2133902','21339','0','0','100','3','6100','11200','4800','12000','11','38496','4','0','0','0','0','0','0','0','0','0','Coilfang Hate-Screamer - Cast Sonic Scream');
--
-- Coilfang Priestess 21220
UPDATE `creature_template` SET `armor`='5950',`speed`='1.71',`mindmg`='5607',`maxdmg`='6657',`baseattacktime`='1400',`mechanic_immune_mask`='69649',`flags_extra`='0' WHERE `entry` = 21220; -- 1513 3087 -- 8,411 - 9,985
-- `mechanic_immune_mask`='0' after patch 2.1
-- Smite Holy Nova Shadow Word: Pain and Sprit of Redemption 15 seconds after death. 
-- http://wowwiki.wikia.com/wiki/Coilfang_Priestess?oldid=770831 , http://de.wowhead.com/npc=21220/priesterin-des-echsenkessels#english-comments
-- Prenerf Spirit of Redemption on Death, unkillable and 15sec kill self -> morph to 12904
-- Holy Nova on Death
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21220;
INSERT INTO `creature_ai_scripts` VALUES
('2122001','21220','1','0','100','2','0','0','0','0','21','1','0','0','22','0','0','0','19','6','0','0','Coilfang Priestess - Start Movement and Set Phase to 0 OOC'),
('2122002','21220','4','0','100','2','0','0','0','0','22','1','0','0','42','1','0','0','39','50','0','0','Coilfang Priestess - Set Phase 1 and Set Minhealth to 1 and Call for Help on Aggro'),
('2122003','21220','9','6 ','100','3','0','50','5000','7000','11','38582','1','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Smite (Phase 1)'),
('2122004','21220','9','6 ','100','3','0','8','5000','10000','11','38589','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Nova (Phase 1)'),
('2122005','21220','3','6 ','100','2','7','0','0','0','21','1','0','0','22','2','0','0','0','0','0','0','Coilfang Priestess - Start Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2122006','21220','9','6 ','100','2','45','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Start Movement at 45 Yards (Phase 1)'),
('2122007','21220','9','6 ','100','2','5','40','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Prevent Movement at 30 Yards (Phase 1)'),
('2122008','21220','9','6 ','100','2','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Start Movement Below 5 Yards (Phase 1)'),
('2122009','21220','3','5','100','3','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2122010','21220','9','4','100','3','0','45','10400','14200','11','38585','4','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Fire'),
('2122011','21220','14','4','100','3','40000','40','5000','10000','11','38580','6','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal on Friendlies'),
('2122012','21220','2','4','100','2','80','0','15000','20000','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 80% HP'),
('2122013','21220','2','4','100','2','50','0','0','0','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 50% HP'),
('2122014','21220','2','4','100','2','20','0','0','0','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 20% HP'),
('2122015','21220','9','4','100','3','0','30','5400','7200','11','37275','4','32','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Shadow Word: Pain'),
('2122016','21220','2','0','100','2','1','0','0','0','11','38589','0','7','3','0','16031','0','22','3','0','0','Coilfang Priestess - Cast Holy Nova and Morph and Set Phase 3 at 1% HP'),
('2122017','21220','2','0','100','2','1','0','0','0','21','0','0','0','20','0','0','0','18','6','0','0','Coilfang Priestess - Stop Movement and Stop Melee and Set Unattackable at 1% HP'),
('2122018','21220','14','3','100','3','1000','40','2000','2000','11','38580','6','1','21','0','0','0','20','0','0','0','Coilfang Priestess - Cast Greater Heal and Stop Movement and Stop Melee on Friendlies (Phase 3)'),
('2122019','21220','7','0','100','2','0','0','0','0','22','0','0','0','3','0','0','0','19','6','0','0','Coilfang Priestess - Set Phase 0 and Demorph and Set Attackable on Evade'),
('2122020','21220','7','0','100','2','0','0','0','0','21','1','0','0','20','1','0','0','0','0','0','0','Coilfang Priestess - Start Movement and Melee on Evade'),
('2122021','21220','0','3','100','2','14750','14750','0','0','34','24','1','0','3','0','0','0','0','0','0','0','Coilfang Priestess - Set Instance Data 1 and Demorph to 0 (Phase 3)'),
('2122022','21220','0','3','100','2','15000','15000','0','0','42','0','0','0','37','0','0','0','0','0','0','0','Coilfang Priestess - Set Minhealth to 0 and Die after 15sec (Phase 3)');
--
-- Coilfang Serpentguard 21298
-- Cleave  Corrupt Devotion Aura 38603 Spell Reflection 38599 No CC
-- http://wowwiki.wikia.com/wiki/Coilfang_Serpentguard?direction=next&oldid=777756 , http://www.wowhead.com/npc=21298/coilfang-serpentguard#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='7366',`maxdmg`='8749',`baseattacktime`='1400',`mechanic_immune_mask`='1073692667'  WHERE `entry` = 21298; -- 2646 5411 2000 -- 14,732 - 17,497
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21298;
INSERT INTO `creature_ai_scripts` VALUES
('2129801','21298','4','0','100','2','0','0','0','0','11','38603','0','7','0','0','0','0','0','0','0','0','Coilfang Serpentguard - Cast Corrupt Devotion Aura on Aggro'),
('2129802','21298','0','0','75','3','4900','7700','9900','13900','11','38599','0','0','0','0','0','0','0','0','0','0','Coilfang Serpentguard - Cast Spell Reflection'),
('2129803','21298','9','0','50','3','0','5','15900','18900','11','31779','0','0','0','0','0','0','0','0','0','0','Coilfang Serpentguard - Cast Cleave');
--
-- Coilfang Shatterer 21301
-- 3000 - 4500 damage to tanks Shatter Armor No CC
-- http://www.wowhead.com/npc=21301/coilfang-shatterer#comments , http://wowwiki.wikia.com/wiki/Coilfang_Shatterer?direction=next&oldid=1145233
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8000',`maxdmg`='12000',`baseattacktime`='1400',`mechanic_immune_mask`='1073692667' WHERE `entry` = 21301; -- 2646 5411 2000 -- -- 14,732 - 17,497
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21301;
INSERT INTO `creature_ai_scripts` VALUES
('2130101','21301','9','0','100','3','0','5','9200','11500','11','38591','1','32','0','0','0','0','0','0','0','0','Coilfang Shatterer - Cast Shatter Armor'),
('2130102','21301','6','0','100','3','0','0','0','0','34','24','1','0','0','0','0','0','0','0','0','0','Coilfang Shatterer - Set Instance Data 1'),
-- ('2130102','21301','29','0','100','2','1000','1000','0','0','35','1','0','0','0','0','0','0','0','0','0','0','Coilfang Shatterer - Set Instance Data64 (SD2) on Timer'),
('2130103','21301','4','0','100','2','0','0','0','0','11','29651','0','0','0','0','0','0','0','0','0','0','Coilfang Shatterer - Cast Dual Wield on Aggro');
--
-- Colossus Lurker 22347
-- http://wowwiki.wikia.com/wiki/Colossus_Lurker?direction=next&oldid=785020 , http://www.wowhead.com/npc=22347/colossus-lurker#comments
UPDATE `creature_template` SET `armor`='7100',`speed`='1.71',`mindmg`='9443',`maxdmg`='11216',`baseattacktime`='1400',`mechanic_immune_mask`='1073741823' WHERE `entry` = 22347; -- 2544 5203 -- -- 14,165 - 16,824
--
-- Greyheart Nether-Mage 21230
-- only Sheepable immune to cast speed reduce ( all casters )
-- Decides whether Fire 38635 38636 38641 Frost 38644 38645 38646 Arcane 38633 38634, additional Blink 38642 38643 and Buff 38647 38648 38649 depending on specc chosen maybe 38632 for visual something
-- http://www.wowhead.com/npc=21230/greyheart-nether-mage#comments , http://wowwiki.wikia.com/wiki/Greyheart_Nether-Mage?direction=prev&oldid=993664 , http://wowwiki.wikia.com/wiki/Greyheart_Nether-Mage?direction=next&oldid=1185956
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`baseattacktime`='1400',`mechanic_immune_mask`='1073627115' WHERE `entry` = 21230; -- 1513 3087 2000 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21230');
INSERT INTO `creature_ai_scripts` VALUES
('2123001','21230','11','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Spawn'),
('2123002','21230','4','125','100','2','0','0','0','0','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt on Aggro (Phase 1)'),
('2123003','21230','9','125','100','3','0','40','1200','4800','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt (Phase 1)'),
('2123004','21230','9','125','100','3','0','5','8000','12000','11','38644','0','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Cone of Cold (Phase 1)'),
('2123005','21230','0','125','100','3','6000','12000','10400','16000','11','38646','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blizzard (Phase 1)'),
('2123006','21230','1','125','100','3','1000','1000','1800000','1800000','11','38649','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction OOC (Phase 1)'),
('2123007','21230','27','125','100','3','38649','1','5000','5000','11','38649','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction on Missing Buff (Phase 1)'),
('2123008','21230','1','119','100','3','1000','1000','1800000','1800000','11','38648','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction OOC (Phase 3)'),
('2123009','21230','4','119','100','2','0','0','0','0','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball on Aggro (Phase 3)'),
('2123010','21230','9','119','100','3','0','40','1200','4800','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball (Phase 3)'),
('2123011','21230','0','119','100','3','6000','12000','10400','16000','11','38635','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Rain of Fire (Phase 3)'),
('2123012','21230','9','119','100','2','0','30','9000','12000','11','38636','1','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Scorch (Phase 3)'),
('2123013','21230','27','119','100','3','38648','1','5000','5000','11','38648','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction on Missing Buff (Phase 3)'),
('2123014','21230','1','95','100','3','1000','1000','1800000','1800000','11','38647','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction OOC (Phase 2)'),
('2123015','21230','4','95','100','2','0','0','0','0','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley on Aggro (Phase 5)'),
('2123016','21230','9','95','100','3','0','40','1200','4800','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley (Phase 5)'),
('2123017','21230','0','95','100','3','2000','6000','9600','12600','11','38634','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Lightning (Phase 5)'),
('2123018','21230','27','95','100','3','38647','1','5000','5000','11','38647','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction on Missing Buff (Phase 5)'),
('2123019','21230','0','0','75','3','6000','18000','17000','24000','11','38642','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blink'),
('2123020','21230','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - On Evade set Phase to 0');

-- Backup
-- 2123001  21230   11  0   100 2   0   0   0   0   30  1   2   3   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Sets Random Phase on Spawn
-- 2123002  21230   0   13  100 3   0   0   1200    6400    11  38645   4   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Frostbolt (Phase 1)
-- 2123003  21230   0   13  100 3   0   0   8000    8000    11  38644   0   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Cone of Cold (Phase 1)
-- 2123004  21230   0   13  100 2   0   0   8100    8100    11  38649   0   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Frost Destruction (Phase 1)
-- 2123005  21230   0   11  100 3   2100    2100    12600   15600   11  38634   1   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Arcane Lightning (Phase 2)
-- 2123006  21230   0   11  100 2   0   0   2700    2700    11  38647   0   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Arcane Destruction (Phase 2)
-- 2123007  21230   0   0   50  3   500 500 20000   20000   11  38642   0   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Blink
-- 2123008  21230   0   11  100 3   8800    8800    9600    9600    11  38633   4   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Arcane Volley (Phase 2)
-- 2123009  21230   0   7   100 3   4700    4700    116600  116600  11  38641   1   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Fireball (Phase 3)
-- 2123010  21230   0   7   100 3   8400    8400    104400  104400  11  38635   4   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Rain of Fire (Phase 3)
-- 2123011  21230   0   7   100 2   0   0   1000    1000    11  38648   0   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Fire Destruction (Phase 3)
-- 2123012  21230   0   7   100 3   700 700 10100   10100   11  38636   1   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Scorch (Phase 3)
-- 2123013  21230   0   13  100 3   4000    8000    10000   20000   11  38646   4   0   0   0   0   0   0   0   0   0   Greyheart Nether-Mage - Cast Blizzard (Phase 1)
--
-- Greyheart Shield-Bearer 21231
-- CC able ( Poly Sap Fear ) Charge 38630 ( should have meleedmg + X ) and Avenger's shield 38631
-- Being a holy priest he can usually one shot me on a charge.
-- http://www.wowhead.com/npc=21231/greyheart-shield-bearer#comments http://wowwiki.wikia.com/wiki/Greyheart_Shield-Bearer
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='7083',`maxdmg`='8412',`baseattacktime`='1400',`mechanic_immune_mask`='461246433' WHERE `entry` = 21231; -- 2544 5203 2000 -- 14,165 - 16,824
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21231;
INSERT INTO `creature_ai_scripts` VALUES
('2123101','21231','9','0','100','3','8','25','10800','12800','11','38630','5','1','0','0','0','0','0','0','0','0','Greyheart Shield-Bearer - Cast Shield Charge'),
('2123102','21231','9','0','100','3','0','30','7600','12600','11','38631','4','1','0','0','0','0','0','0','0','0','Greyheart Shield-Bearer - Cast Avenger\'s Shield');
--
-- Greyheart Skulker 21232- http://wowwiki.wikia.com/wiki/Greyheart_Skulker?direction=next&oldid=1265744
-- 216000 HP Sheep / Disarm Fear Wyvern Sting  but immune to trap stuns
-- Random Kick in Melee Range
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`mindmg`='7932',`maxdmg`='9421',`baseattacktime`='1400',`mechanic_immune_mask`='6145' WHERE `entry` = 21232; -- 3562 7284 2000 -- 19,831 - 23,553
DELETE FROM `creature_template_addon` WHERE `entry` = 21232;
INSERT INTO `creature_template_addon` VALUES
(21232,0,0,512,0,4097,173,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21232;
INSERT INTO `creature_ai_scripts` VALUES
('2123201','21232','9','0','100','3','0','5','4800','7900','11','38625','4','0','0','0','0','0','0','0','0','0','Greyheart Skulker - Cast Kick'),
('2123202','21232','4','0','100','3','0','0','0','0','11','29651','0','7','0','0','0','0','0','0','0','0','Geyheart Skulker - Cast Dual Wield on Aggro');
-- ('2123203','21232','1','0','100','3','0','0','1000','1000','5','173','0','0','0','0','0','0','0','0','0','0','Geyheart Skulker - Emote work');
--
-- Greyheart Technician 21263
-- 24000 HP CC able
-- Harmstring http://www.wowhead.com/npc=21263/greyheart-technician#abilities , http://wowwiki.wikia.com/wiki/Greyheart_Technician
-- These mobs are NOT tied to the others on the platform, its possibly to aggro them without attracting the attention of the Naga. -> Recheck linking
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='1133',`maxdmg`='1346',`baseattacktime`='1400' WHERE `entry` = 21263; -- 407 832 2000 -- 2,266 - 2,691
DELETE FROM `creature_template_addon` WHERE `entry` = 21263;
INSERT INTO `creature_template_addon` VALUES
(21263,0,0,512,0,4097,173,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21263;
INSERT INTO `creature_ai_scripts` VALUES
('2126301','21263','9','0','100','3','0','5','5300','9300','11','38995','4','32','0','0','0','0','0','0','0','0','Greyheart Technician - Cast Hamstring');
-- ('2126302','21263','29','0','100','2','1000','1000','0','0','35','1','0','0','0','0','0','0','0','0','0','0','Greyheart Technician - Set Instace Data64 (SD2) on Timer');
-- ('2126302','21263','1','0','100','3','0','0','1000','1000','5','173','0','0','0','0','0','0','0','0','0','0','Geyheart Technician - Emote work');
--
-- Greyheart Tidecaller 21229
-- 168000 HP fearable sheepable snare and rootable, but immune to trap  
-- Totem -> Elemantal , Poison Shield, Chain lightning with silence component http://looking4group.de/quelthalas/database/?spell=38624
-- http://wowwiki.wikia.com/wiki/Greyheart_Tidecaller?direction=next&oldid=1234828 , http://www.wowhead.com/npc=21229/greyheart-tidecaller#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5256',`maxdmg`='6240',`mechanic_immune_mask`='6145',`flags_extra`='4194304' WHERE `entry` = 21229; -- 1890 3858 -- 10,512 - 12,480 Core: mob_greyheart_tidecaller
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21229;
INSERT INTO `creature_ai_scripts` VALUES
('2122901','21229','0','0','100','3','1000','10000','9500','13500','11','39027','0','0','0','0','0','0','0','0','0','0','Greyheart Tidecaller - Cast Poison Shield'),
('2122902','21229','0','0','100','3','2300','3200','15700','23700','11','38624','0','0','0','0','0','0','0','0','0','0','Greyheart Tidecaller - Cast Water Elemental Totem'),
('2122903','21229','9','0','100','3','0','30','5000','7000','11','38146','5','0','0','0','0','0','0','0','0','0','Greyheart Tidecaller - Cast Arcane Lightning');
--
-- Water Elemental Totem 22236 spell=38624
-- UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'4'|'262144'  WHERE `entry` = 22236; -- TotemAI
--
-- Serpentshrine Tidecaller 22238 (Elemental)
-- http://looking4group.de/quelthalas/database/?spell=38624
-- 72000
-- Water Bolt Volley 38623 , Frost Nova 39035
-- http://www.wowhead.com/npc=22238/serpentshrine-tidecaller , http://wowwiki.wikia.com/wiki/Serpentshrine_Tidecaller?direction=next&oldid=1476724
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`mindmg`='4731',`maxdmg`='5616',`baseattacktime`='1400',`mechanic_immune_mask`='993859567'  WHERE `entry` = 22238; -- 1701 3472 2000 -- 9,461 - 11,232
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22238;
INSERT INTO `creature_ai_scripts` VALUES
('2223801','22238','0','0','100','3','1000','2400','11000','16000','11','38623','4','0','0','0','0','0','0','0','0','0','Serpentshrine Tidecaller - Cast Water Bolt Volley'),
('2223802','22238','9','0','100','3','0','8','16000','21000','11','39035','0','1','0','0','0','0','0','0','0','0','Serpentshrine Tidecaller - Cast Frost Nova');
--
-- Serpentshrine Sporebat 21246
-- 107 150, 214 300 Leben haben
-- By 1313moridin (1,661 – 13·34) on 2007/04/30 (Patch 2.0.12) they only have alittle over 200k hp
-- Spore Burst Charge 10-15 secs melee for 3000 on cloth. 
-- http://wowwiki.wikia.com/wiki/Serpentshrine_Sporebat?direction=next&oldid=768437 , http://www.wowhead.com/npc=21246/serpentshrine-sporebat#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3000',`maxdmg`='5000',`baseattacktime`='1000',`mechanic_immune_mask`='75579255' WHERE `entry` = 21246; -- 1874 3809 2000 -- 2500 3500 7,649 - 9,084
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21246;
INSERT INTO `creature_ai_scripts` VALUES
('2124601','21246','9','0','100','3','6','30','10000','15000','11','38461','5','1','0','0','0','0','0','0','0','0','Serpentshrine Sporebat - Cast Charge'), -- 22120
('2124602','21246','9','0','100','3','0','5','15800','24000','11','38924','0','1','0','0','0','0','0','0','0','0','Serpentshrine Sporebat - Cast Spore Burst');
--
-- Tainted Water Elemental 21253
-- 13200 http://wowwiki.wikia.com/wiki/Tainted_Water_Elemental?direction=next&oldid=783566
-- These mobs move around Hydross the Unstable's platform Tainted Water Elemental's come from the right and stop in front of Hydross the Unstable and become Purified Water Elemental then continue along the platform
-- Elemental Spawn-in minievent relativ short respawn timer.
UPDATE `creature` SET `spawntimesecs`='300' WHERE `id` = 21253;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='850',`maxdmg`='1009',`baseattacktime`='1400',`dmgschool`='3' WHERE `entry` = 21253; -- 305 624 2000 -- 1,699 - 2,018
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21253;
INSERT INTO `creature_ai_scripts` VALUES
('2125301','21253','11','0','100','2','0','0','0','0','11','25035','0','0','0','0','0','0','0','0','0','0','Tainted Water Elemental - Cast Elemental Spawn-in on Spawn');
--
-- Purified Water Elemental 21260
-- 14400 http://wowwiki.wikia.com/wiki/Purified_Water_Elemental?direction=prev&oldid=795366
-- Elemental Spawn-in minievent relativ short respawn timer.
UPDATE `creature` SET `spawntimesecs`='300' WHERE `id` IN ('21260');
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='850',`maxdmg`='1009',`baseattacktime`='1400',`dmgschool`='4' WHERE `entry` = 21260; -- 305 624 2000 -- 1,699 - 2,018
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21260;
INSERT INTO `creature_ai_scripts` VALUES
('2126001','21260','11','0','100','2','0','0','0','0','11','25035','0','0','0','0','0','0','0','0','0','0','Purified Water Elemental - Cast Elemental Spawn-in on Spawn');
--
-- Tidewalker Depth-Seer 21224
-- ~150000 -> 180000 plate for ~1500-2k 
-- 38657 38658 and uninterruptible tranquility 38659
-- Confirmed immune to all types of crowd control. but can be interrupted no silence abilitys
-- http://wowwiki.wikia.com/wiki/Tidewalker_Depth-Seer , http://www.wowhead.com/npc=21224/tidewalker-depth-seer#abilities
UPDATE `creature_template` SET `mindmg`='3784',`maxdmg`='4493',`baseattacktime`='1400',`mechanic_immune_mask`='1040138235',`flags_extra`='4194304'  WHERE `entry` = 21224; -- 1701 3472 2000 -- 9,461 - 11,232
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21224;
INSERT INTO `creature_ai_scripts` VALUES
('2122401','21224','2','0','100','3','75','0','25000','27000','11','38657','0','0','0','0','0','0','0','0','0','0','Tidewalker Depth-Seer - Cast Rejuvenation on Self'),
('2122402','21224','2','0','100','3','50','0','22000','31000','11','38658','0','0','0','0','0','0','0','0','0','0','Tidewalker Depth-Seer - Cast Healing Touch on Self'),
('2122403','21224','14','0','100','3','10000','40','13300','14500','11','38657','6','0','0','0','0','0','0','0','0','0','Tidewalker Depth-Seer - Cast Rejuvenation on Friendlies'),
('2122404','21224','14','0','100','3','25000','40','12000','21000','11','38658','6','0','0','0','0','0','0','0','0','0','Tidewalker Depth-Seer - Cast Healing Touch on Friendlies'),
('2122405','21224','2','0','100','3','20','0','12000','15000','11','38659','0','7','0','0','0','0','0','0','0','0','Tidewalker Depth-Seer - Cast Tranquility at 20% HP');
--
-- Tidewalker Harpooner 21227
-- 228000 They are immune to all forms of Crowd Control and Snares. 
-- These will net the tank they're on (immobilize) and drop aggro (permanent aggro drop, tanks need to taunt it back). They're not CC'able.
-- http://wowwiki.wikia.com/wiki/Tidewalker_Harpooner?oldid=1234855 , http://www.wowhead.com/npc=21227/tidewalker-harpooner#abilities
UPDATE `creature_template` SET `mindmg`='5100',`maxdmg`='6057',`mechanic_immune_mask`='1073692667' WHERE `entry` = 21227; -- 1832 3746 -- 10,199 - 12,113
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21227');
INSERT INTO `creature_ai_scripts` VALUES
('2122700','21227','0','0','100','3','1000','1000','2000','2000','21','1','0','0','0','0','0','0','0','0','0','0','Tidewalker Harpooner - Start Combat Movement'),
('2122701','21227','4','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Tidewalker Harpooner - Set Phase 1 and Set Melee Weapon Model and Start Movement OOC'),
('2122702','21227','9','1','100','3','5','35','3000','4000','11','39060','1','0','40','2','0','0','21','0','0','0','Tidewalker Harpooner - Cast Throw and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2122703','21227','9','1','100','3','5','30','7000','11000','11','39061','4','32','40','2','0','0','21','0','0','0','Tidewalker Harpooner - Cast Impale and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2122704','21227','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Tidewalker Harpooner - Start Combat Movement and Set Melee Weapon Model and Set Phase 0 at 5 Yards (Phase 1)'),
('2122705','21227','9','0','100','3','0','5','16800','25300','11','38661','1','1','13','-99','1','0','0','0','0','0','Tidewalker Harpooner - Cast Net and Reduces Threat'),
('2122706','21227','9','0','100','3','5','8','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Tidewalker Harpooner - Stop Combat Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)'),
('2122707','21227','7','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Tidewalker Harpooner - Set Phase 1 and Set Melee Weapon Model on Evade');
--
-- Tidewalker Hydromancer 21228
-- 150000 -> 180000
-- 39063/frost-nova 39062/frost-shock 39064/frostbolt rare
-- Vulnerable to Stuns.These mobs can be both silenced and interrupted.These mobs are vulnerable to Curse of Tongues. 
-- http://www.wowhead.com/npc=21228/tidewalker-hydromancer#abilities http://wowwiki.wikia.com/wiki/Tidewalker_Hydromancer
UPDATE `creature_template` SET `mindmg`='3364',`maxdmg`='3994',`baseattacktime`='1400' WHERE `entry` = 21228; -- 1513 3087 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21228;
INSERT INTO `creature_ai_scripts` VALUES
('2122801','21228','9','0','100','3','0','40','7000','12000','11','39064','4','0','0','0','0','0','0','0','0','0','Tidewalker Hydromancer - Cast Frostbolt'),
('2122802','21228','9','0','100','3','0','20','12000','16000','11','39062','1','0','0','0','0','0','0','0','0','0','Tidewalker Hydromancer - Cast Frost Shock'),
('2122803','21228','9','0','100','3','0','8','12000','18000','11','39063','0','0','0','0','0','0','0','0','0','0','Tidewalker Hydromancer - Cast Frost Nova');
--
-- Tidewalker Shaman 21226
-- 180000 39066/chain-lightning 39065/lightning-bolt 39067/lightning-shield
-- They are immune to all forms of Crowd Control.Their spells can be interrupted, but they are immune to silence.They are immune to Curse of Tongues and snares. Can be stunned
-- http://www.wowhead.com/npc=21226/tidewalker-shaman#abilities , http://wowwiki.wikia.com/wiki/Tidewalker_Shaman
UPDATE `creature_template` SET `mindmg`='3364',`maxdmg`='3994',`baseattacktime`='1400',`mechanic_immune_mask`='1040136187' WHERE `entry` = 21226; -- 1513 3087 2000 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21226;
INSERT INTO `creature_ai_scripts` VALUES
('2122602','21226','1','0','100','3','1000','1000','600000','600000','11','39067','0','1','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Lightning Shield OOC'),
('2122604','21226','9','0','100','3','0','40','5000','8000','11','39065','1','0','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Lightning Bolt'),
('2122610','21226','27','0','100','3','39067','1','10000','20000','11','39067','0','32','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Lightning Shield on Missing Buff'),
('2122611','21226','9','0','100','2','0','30','12000','18000','11','39066','4','0','0','0','0','0','0','0','0','0','Tidewalker Shaman - Cast Chain Lightning');
--
-- Tidewalker Warrior 21225
-- Cleave 39070/bloodthirst 39069/uppercut 38664/enrage gain frenzy every 20-25 -> uppercuts are blizzards aggro reset spells.
-- Repeat Drop Aggro, Frenzy can't be stunned, These mobs are vulnerable to Fear, Polymorph, tranq shot and Snares. They are vulnerable to Disarm 
-- http://www.wowhead.com/npc=21225/tidewalker-warrior#abilities , http://wowwiki.wikia.com/wiki/Tidewalker_Warrior
UPDATE `creature_template` SET `mindmg`='4532',`maxdmg`='5383',`baseattacktime`='1400' WHERE `entry` = 21225; -- 2035 4162  2000 -- 11,331 - 13,458
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21225;
INSERT INTO `creature_ai_scripts` VALUES
('2122501','21225','9','0','100','3','0','5','12000','15000','11','39070','1','1','0','0','0','0','0','0','0','0','Tidewalker Warrior - Cast Bloodthirst'),
('2122502','21225','0','0','100','3','12400','16100','15000','19000','11','39069','1','0','13','-99','1','0','0','0','0','0','Tidewalker Warrior - Cast Uppercut'),
('2122503','21225','0','0','100','3','7700','9300','20000','24600','11','38664','0','0','0','0','0','0','0','0','0','0','Tidewalker Warrior - Cast Frenzy'),
('2122504','21225','4','0','100','2','0','0','0','0','11','29651','0','0','0','0','0','0','0','0','0','0','Tidewalker Warrior - Cast Dual Wield on Aggro');
--
-- Vashj'ir Honor Guard 21218
-- Quotes missing cuz scripted
-- 260000 immune to all http://www.wowhead.com/npc=21218/vashjir-honor-guard#abilities http://wowwiki.wikia.com/wiki/Vashj%27ir_Honor_Guard?oldid=770642
-- 38959/execute 38947/frenzy on 50% + yell 38576/knockback 38572/mortal-cleave intimidating shout
-- yell on 50% hp + enrage: Enough! I have had enough of you filthy warm bloods!
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='11554',`maxdmg`='13332' WHERE `entry` = 21218; -- 2778 5000 -- 9629 11110 -- 14,443 - 16,665 mob_vashjir_honor_guard
--
-- Underbog Colossus 21251
-- 620000 2-3k on a tank http://wowwiki.wikia.com/wiki/Underbog_Colossus?direction=next&oldid=768654
-- different ai sets he is core scripted atm but poorly
-- set1 39031/enrage 39015/atrophic-blow
-- set2 38971/acid-geyser 39044/serpentshrine-parasite
-- spawns parasites that do lots of damage, but one hit kills them. 4 at a time 
-- Parasite - Does a ?2k dot to target, after dot a small 1hp 'parasite' will leave the infected person and go to a new target. Also spawns parasites if a parasite kills someone. 
-- set3 38976/spore-quake 39032/initial-infection
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='13856',`maxdmg`='16445',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304' WHERE `entry` = 21251; -- 4571 6857 -- 620000 3109 6357 -- 17,308 - 20,556 mob_underbog_colossus
--
-- has random aura which increases the dmg it takes from a spellschool
--
-- random effects on death 38718/toxic-pool
-- Nothing.
-- Two big adds spawn. These need to be tanked.
-- 10-15 or so little adds spawn. AOE these down.
-- Blue mushrooms spawn. These put a heal/mana regain over time on you when you get close to them (if you run in and out of range you can stack the buff several times).
--
-- http://wowwiki.wikia.com/wiki/Underbog_Colossus?direction=next&oldid=768654 , http://www.wowhead.com/npc=21251/underbog-colossus#comments
--
-- Serpentshrine Parasite 22379
-- http://www.wowhead.com/npc=22379/serpentshrine-parasite#abilities http://wowwiki.wikia.com/wiki/Serpentshrine_Parasite
UPDATE `creature_template` SET `speed`='3',`mindmg`='10000',`maxdmg`='10000',`baseattacktime`='1000'  WHERE `entry` = 22379; -- 1 1 0 2222 2000
--
-- =================================
-- Bosses
-- =================================
--
-- =================================
-- Hydross the Unstable <Duke of Currents> 21216
-- =================================
--
UPDATE `creature_template` SET `speed`='2.00',`mindmg`='6500',`maxdmg`='8500',`mechanic_immune_mask`='1072644095',`flags_extra`='4522017' WHERE `entry` = 21216; -- 6500 7500
--
-- Pure Spawn of Hydross 22035
-- Pure Spawns of Hydross has around 55,000 HP
UPDATE `creature_template` SET `mindmg`='4000',`maxdmg`='5000',`baseattacktime`='2000',`speed`='1.48',`resistance4`='-1',`AIName`='EventAI' WHERE `entry` = 22035; -- 55917 3500 4500 2000 -- 
DELETE FROM `creature_template_addon` WHERE `entry` = 22035; 
INSERT INTO `creature_template_addon` VALUES
(22035,0,0,512,0,4097,0,0,''); 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22035;
INSERT INTO `creature_ai_scripts` VALUES
('2203501','22035','11','0','100','2','0','0','0','0','11','25035','0','0','0','0','0','0','0','0','0','0','Pure Spawn of Hydross - Cast Elemental Spawn-in on Spawn');
--
-- Tainted Spawn of Hydross 22036
-- Tainted Spawn of Hydross has around 62,500 HP
UPDATE `creature_template` SET `mindmg`='4000',`maxdmg`='5000',`baseattacktime`='2000',`speed`='1.48',`resistance3`='-1',`AIName`='EventAI' WHERE `entry` = 22036; -- 62917 3500 4500 2000 --
DELETE FROM `creature_template_addon` WHERE `entry` = 22036; 
INSERT INTO `creature_template_addon` VALUES
(22036,0,0,512,0,4097,0,0,''); 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22036;
INSERT INTO `creature_ai_scripts` VALUES
('2203601','22036','11','0','100','2','0','0','0','0','11','25035','0','0','0','0','0','0','0','0','0','0','Tainted Spawn of Hydross - Cast Elemental Spawn-in on Spawn');
--
-- 21934 hydross trigger
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` = 21934;
--
-- =================================
-- The Lurker Below 21217
-- =================================
--
-- Hits tanks for 5000-9000 in melee http://wowwiki.wikia.com/wiki/The_Lurker_Below?direction=next&oldid=560965
UPDATE `creature_template` SET `speed`='3',`mindmg`='10900',`maxdmg`='18600',`baseattacktime`='2000',`mechanic_immune_mask`='1073692671' WHERE `entry` = 21217; -- 5311600 4738 9684 2000 -- 13000 24000 13186 15658 -- 26,371 - 31,317
-- UPDATE `creature_template` SET `mindmg`='6200',`maxdmg`='15700' WHERE `entry` = 21217; -- 5311600
--
-- Adjust Hitbox
UPDATE `creature_model_info` SET `bounding_radius`='17',`combat_reach`='17' WHERE `modelid` = 20216; -- 13  20
--
-- Coilfang Ambusher 21865
-- They have nasty burst damage and can Multishot for about 2.5k on leather. mob_coilfang_ambusher
UPDATE `creature_template` SET `mindmg`='3000',`maxdmg`='4000',`baseattacktime`='1400',`minrangedmg`='1000',`maxrangedmg`='2000',`speed`='1.48',`mechanic_immune_mask`='1' WHERE `entry` = 21865; -- 930 1898 2000 0 0 -- 2585 3069
--
-- Coilfang Guardian 21873
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8500',`maxdmg`='13000' WHERE `entry` = 21873; -- 3003 6139 -- 12800 16533 -- 16,716 - 19,852
--
-- =================================
-- Leotheras the Blind 21215
-- =================================
--
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3200',`maxdmg`='11000',`baseattacktime`='2000',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('21215'); -- 4494000(4.5 M HP) 1 2843 5810 2000 -- 3200 11000(12160) -- 9600 12800(dualwield doesnt need low value) -- 15,822 - 18,789
-- Shadow of Leotheras 21875
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='3200',`maxdmg`='6160',`baseattacktime`='1400',`mechanic_immune_mask`='1073692671',`flags_extra`='4194305' WHERE `entry` IN ('21875'); -- 1.20 2843 5810 2000
-- UPDATE `creature_template` SET `mindmg`='6200',`maxdmg`='15700' WHERE `entry`='21215';
-- Leotheras Phase 3
UPDATE `creature_template` SET `mindmg`='3200',`maxdmg`='11000' WHERE `entry`='21845'; -- nonexistant
--
-- Greyheart Spellbinder 21806 mob_greyheart_spellbinder
-- Should cast Mindblast more frequent , kickable ( Core, also Core Spawned ) 
-- http://www.wowhead.com/npc=21806/greyheart-spellbinder#comments http://wowwiki.wikia.com/wiki/Greyheart_Spellbinder?direction=next&oldid=785172
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5700',`maxdmg`='7400',`mechanic_immune_mask`='1040138239',`flags_extra`='4194304'  WHERE `entry` IN ('21806'); -- 2268 4630 -- 6308 7489 -- 12,615 - 14,977
--
-- Inner Demon 21857 mob_inner_demon
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='954',`maxdmg`='1259',`baseattacktime`='1400' WHERE `entry` IN ('21857'); -- 1 -- 718 1259 -- 1154 1370 -- 2,884 - 3,425
--
-- =================================
-- Fathom-Lord Karathress 21214
-- =================================
--
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='11177',`maxdmg`='13266',`mechanic_immune_mask`='1073430527',`flags_extra`=`flags_extra`|'4194304' WHERE `entry` IN ('21214'); -- 4519 8175 -- 6840 7630 -- 19,560 - 23,216
-- UPDATE `creature_template` SET `mindmg`='6840',`maxdmg`='7630' WHERE `entry`='21214';
--
-- Fathom-Guard Caribdis 21964
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4200',`maxdmg`='7100',`mechanic_immune_mask`='1039876095' WHERE `entry` IN ('21964'); -- 1 2363 4823
-- UPDATE `creature_template` SET `mindmg`='4200',`maxdmg`='7100' WHERE `entry`='21964';
--
-- Fathom-Guard Tidalvess 21965
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='10800',`maxdmg`='15200',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('21965'); -- 1 3969 8102 -- 22,076 - 26,209
-- UPDATE `creature_template` SET `mindmg`='8000',`maxdmg`='15200' WHERE `entry`='21965';
--
-- Fathom-Guard Sharkkis 21966
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='7300',`maxdmg`='14000',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('21966'); -- 1 2363 4823
-- UPDATE `creature_equip_template` SET `equipmodel3`='22031',`equipinfo3`='33492994',`equipslot3`='25' WHERE `entry` = 1041; -- 0 0 0
--
-- Fathom Lurker 22119
-- 204000 69 Elite no CC ( could be banished till 2.3 )
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4900',`maxdmg`='6200',`baseattacktime`='1400',`mechanic_immune_mask`='1073561599' WHERE `entry` IN ('22119'); -- 2687 5495 -- 14,958 - 17,766
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22119');
INSERT INTO `creature_ai_scripts` VALUES
('2211901','22119','9','0','100','3','0','8','14000','21000','11','25778','1','0','13','-10','1','0','0','0','0','0','Fathom Lurker - Cast Knock Away');
--
-- Fathom Sporebat 22120
-- 69 Elite no CC http://www.wowhead.com/npc=22120/fathom-sporebat#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4900',`maxdmg`='6200',`baseattacktime`='1400',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('22120'); -- 2687 5495 -- 14,958 - 17,766
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22120');
INSERT INTO `creature_ai_scripts` VALUES
('2212001','22120','9','0','100','3','0','8','14000','21000','11','25778','1','0','13','-10','1','0','0','0','0','0','Fathom Sporebat - Cast Knock Away');
--
-- Spitfire Totem 22091
UPDATE `creature_template` SET `armor`='6500',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` IN ('22091');
--
-- Greater Earthbind Totem 22486
UPDATE `creature_template` SET `armor`='6500',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` IN ('22486');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22486');
INSERT INTO `creature_ai_scripts` VALUES
('2248601','22486','0','0','100','3','1000','1000','5000','5000','11','3600','0','0','0','0','0','0','0','0','0','0','Greater Earthbind Totem - Cast Earthbind');
--
-- Greater Poison Cleansing Totem 22487
UPDATE `creature_template` SET `armor`='6500',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` IN ('22487');
--
-- Cyclone (Karathress)
UPDATE `creature_template` SET `minlevel` = 73, `maxlevel` = 73, `armor` = 20, `faction_A` = 14, `faction_H` = 14, `speed` = 1.125, `unit_flags` = 33554432, `type_flags` = 4, `MovementType` = 1, `flags_extra` = 0, `modelid_A` = 11686, `modelid_H` = 11686 WHERE `entry` = 22104;
--
-- =================================
-- Morogrim Tidewalker 21213
-- =================================
--
UPDATE `creature_template` SET `speed`='2',`mindmg`='14064',`maxdmg`='16702',`mechanic_immune_mask`='1073430527' WHERE `entry` IN ('21213'); -- 5054 10330 -- 9500 16702 -- 28,128 - 33,404
--
-- Tidewalker Lurker 21920
UPDATE `creature_template` SET `mindmg`='1200',`maxdmg`='2220',`baseattacktime`='1400' WHERE `entry` IN ('21920'); -- 611 1249 2000
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21920');
INSERT INTO `creature_ai_scripts` VALUES
('2192001','21920','9','0','100','3','0','5','5900','7100','11','41932','1','0','0','0','0','0','0','0','0','0','Tidewalker Lurker - Cast Carnivorous Bite'),
('2192002','21920','4','0','100','2','0','0','0','0','39','15','0','0','0','0','0','0','0','0','0','0','Tidewalker Lurker - Call for Help on Aggro');
--
-- Water Globule 21913
-- http://www.wowhead.com/npc=21913/water-globule
--
-- =================================
-- Lady Vashj <Coilfang Matron> 21212
-- =================================
--
-- http://wowwiki.wikia.com/wiki/Lady_Vashj_(tactics)?direction=next&oldid=882757
UPDATE `creature_template` SET `speed`='3',`mindmg`='8000',`maxdmg`='16000',`baseattacktime`='1800',`minrangedmg`='1000',`maxrangedmg`='2000',`mechanic_immune_mask`='1073430527' WHERE `entry` IN ('21212'); -- 1 4398 8969 2000 0 0 -- 7200 157333
--
-- Tainted Elemental 22009   
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`mindmg`='169',`maxdmg`='299',`mechanic_immune_mask`='109264767' WHERE `entry` IN ('22009'); -- 9250 20 1 1 131
UPDATE `creature_model_info` SET `bounding_radius`='2' WHERE `modelid` = 11172; -- 0.61112
--
-- Enchanted Elemental 21958
-- mob_enchanted_elemental 7700
UPDATE `creature_template` SET `speed`='1.20',`mechanic_immune_mask`='109264767' WHERE `entry` IN ('21958');
UPDATE `creature_model_info` SET `bounding_radius`='2' WHERE `modelid` = 20076; -- 0.61112
--
-- Coilfang Elite 22055
-- 170000 (Pre Patch 2.1 about 340 000 HP)
-- http://www.wowhead.com/npc=22055/coilfang-elite#comments , http://wowwiki.wikia.com/wiki/Coilfang_Elite?direction=next&oldid=784963
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='6400',`maxdmg`='13867',`mechanic_immune_mask`='1073420283' WHERE `entry` IN ('22055'); -- 3129 6395 550183931 -- 8000 9400 8707 10340 -- 17,413 - 20,679 -- 
--
-- Coilfang Strider 22056
-- 170000 (Pre Patch 2.1 about 340 000 HP)
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='12000',`maxdmg`='15000',`mechanic_immune_mask`='1073427391',`flags_extra`='0' WHERE `entry` IN ('22056'); -- 1 6007 12278 550183931 65536 -- 16717 19853 33,434 - 39,705
--
-- Toxic Spore Bat 22140
-- mob_toxic_sporebat
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`speed`=1.20 WHERE `entry` = 22140; -- 70 73 6986 6986 1 -- 8000 8200
--
-- ======================================================
-- Spawns & Pooling
-- ======================================================
--
DELETE FROM `creature` WHERE `guid` IN ('80273','178782');
INSERT INTO `creature` VALUES
(80273,21263,548,1,0,0,39.2109,-523.3978,0.7427,1.6433,2700,0,0,14362,0,0,0);
--
-- Mortog Steamhead 2.1 back
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` = 84715; -- 1
--
-- Respawn with correct GUID
DELETE FROM `creature` WHERE `guid` IN (93838,16777006);
INSERT INTO `creature` VALUES (93838, 21217, 548, 1, 0, 0, 39.2422, -416.1356, -21.5911, 3.03312, 3600000, 0, 0, 6905080, 0, 0, 0);
--
--
-- ======================================================
-- Linking
-- ======================================================
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (93766,82975,82976,93765);
DELETE FROM `creature_formations` WHERE `memberguid` IN (93766,82975,82976,93765);
INSERT INTO `creature_formations` VALUES
-- XXX,XXX,100,360,2),
--
--
--
(93766,93766,100,360,2),
(93766,82975,100,360,2),
(93766,82976,100,360,2),
(93766,93765,100,360,2);
--
-- 183607,82966,93837,93840,93841,
-- 82861,93789,172713,173195
UPDATE `creature_formations` SET `groupAI`='0' WHERE `leaderguid` IN ('183607') AND `memberguid` IN ('82861','93789','172713','173195');
--
-- 
--
--
-- ======================================================
-- Respawn
-- ======================================================
--
-- Lurker Trash
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (93838,183607,82966,93837,93840,93841,82861,172713,173195,93789,183141,93829,82965,93834,93830,93787,175587,175857,93831,182677,93820,93815,93824,93825,82036,176722,176935,82032,181841,93823,93821,93822,93819,82002,177699,81997,82003,180803,93816,82964,93827,93818,81917,81916,80273,81944,179801,93842,82955,93844,93826,81029,80445,80274,80473);
INSERT INTO `creature_linked_respawn` VALUES 
(93838,93838),(183607,93838),
(82966,93838),(93837,93838),
(93840,93838),(93841,93838),
(82861,93838),(172713,93838),
(173195,93838),(93789,93838),
(183141,93838),(93829,93838),
(82965,93838),(93834,93838),
(93830,93838),(93787,93838),
(175587,93838),(175857,93838),
(93831,93838),(182677,93838),
(93820,93838),(93815,93838),
(93824,93838),(93825,93838),
(82036,93838),(176722,93838),
(176935,93838),(82032,93838),
(181841,93838),(93823,93838),
(93821,93838),(93822,93838),
(93819,93838),(82002,93838),
(177699,93838),(81997,93838),
(82003,93838),(180803,93838),
(93816,93838),(82964,93838),
(93827,93838),(93818,93838),
(81917,93838),(81916,93838),
(80273,93838),(81944,93838),
(179801,93838),(93842,93838),
(82955,93838),(93844,93838),
(93826,93838),(81029,93838),
(80445,93838),(80274,93838),
(80473,93838);
--
--
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (37951,37987,37991,37989,80273,93854,93883);
INSERT INTO `creature_linked_respawn` VALUES
(93883,82974),
--
(93854,93773),
--
(37951,93814),
(37987,93814),
(37991,93814),
(37989,93814);
--
-- ssc hydross & lurker trash 45min respawn timer
-- The creatures that lead up to Hydross the Unstable and creatures at the six pumping stations are now on a 2 hour respawn instead of 45 minutes. 
-- always 5min in despawn so -5min always
UPDATE `creature` SET `spawntimesecs`='7200' WHERE `guid` IN (80272,93853,93828,93851,82953,82961,82917,93848,93850,93852,82956,93832,93849,93847,82958,82957,93845);
--
-- Lurker Trash
UPDATE `creature` SET `spawntimesecs`='7200' WHERE `guid` IN (183607,82966,93837,93840,93841,82861,172713,173195,93789,183141,93829,82965,93834,93830,93787,175587,175857,93831,182677,93820,93815,93824,93825,82036,176722,176935,82032,181841,93823,93821,93822,93819,82002,177699,81997,82003,180803,93816,82964,93827,93818,81917,81916,80273,81944,179801,93842,82955,93844,93826,81029,80445,80274,80473);
--
--
--
-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================
--
UPDATE `creature` SET `position_x`='29.6855', `position_y`='-923.2489', `position_z`='42.9018', `orientation`='1.5949',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('93814');
--
SET @GUID := '37951';
SET @POINT := '0';
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1','19.6190','-56.7943','-72.0772',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','29.2468','-52.0036','-72.4646',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','19.6190','-56.7943','-72.0772',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-11.0251','-66.2496','-71.2579',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-37.1720','-64.7938','-69.9687',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-11.0251','-66.2496','-71.2579',0,0,0,100,0);
--
UPDATE `creature` SET `position_x`='348.194763', `position_y`='-721.6417', `position_z`='-13.6739', `orientation`='3.2655',`spawndist`='0',`movementtype`='0' WHERE `guid` = '82974'; -- 355,821    -721,004    -13,8746    6,09301
--
--
-- ======================================================
-- Gameobjects
-- ======================================================
--
-- 184203 184204 184205 etc brückenteile
--
--
--
-- ======================================================
-- Miscellaneous
-- ======================================================
--
-- Lady Vashj
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21212 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21212 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21212 AND `item` = 190052; -- 2
-- Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 21212 AND `item` = 50031; -- 3
--
-- The Lurker Below
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21217 AND `item` = 29434; -- 100
--
-- Hydross the Unstable
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21216 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21216 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21216 AND `item` = 90052; -- 10
--
-- Leotheras the Blind
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21215 AND `item` = 29434; -- 100
-- Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 21215 AND `item` = 34059; -- 2
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21215 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21215 AND `item` = 190052; -- 2
--
-- Fathom-Lord Karathress
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21214 AND `item` = 29434; -- 100
-- Token
DELETE FROM `creature_loot_template` WHERE `entry` = 21214 AND `item` = 34060;
INSERT INTO `creature_loot_template` VALUES
(21214,34060,100,1,-34060,1,0,0,0);
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21214 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21214 AND `item` = 90052; -- 10
--
-- Morogrim Tidewalker 
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21213 AND `item` = 29434; -- 100
-- Item
DELETE FROM `creature_loot_template` WHERE `entry` = 21213 AND `item` = 34061;
INSERT INTO `creature_loot_template` VALUES
(21213,34061,100,1,-34061,2,0,0,0);
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21213 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21213 AND `item` = 90052; -- 10
--
-- Trash only one time apply to reduce %
--
-- SELECT * FROM `creature_loot_template` WHERE `item` IN (30321,30322,30323,30324,30280,30281,30282,30283,30301,30302,30303,30304,30305,30306,30307,30308);
-- SELECT * FROM `creature_loot_template` WHERE `item` = 30183;
-- SELECT * FROM `creature_loot_template` WHERE `item` IN (30020,30021,30022,30023,30024,30025,30026,30027,30028,30029,30030,30620);

-- Mark of the Illidari
UPDATE `creature_loot_template` SET `mincountOrRef`=0, `maxcount`=0 WHERE `item` =32897; -- 1 1
-- <~1% fist entry 0,984
-- Patterns & Mark of Illidari
-- UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`*3,`mincountOrRef`=0,`maxcount`=0 WHERE `item` IN (30321,30322,30323,30324,30280,30281,30282,30283,30301,30302,30303,30304,30305,30306,30307,30308);
--
-- >~1% first entry 1,0475
-- Nether Vortex
-- UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`*3 WHERE `item` = 30183;
-- Random Epics <~1% first entry 0,3
-- UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`*3,`mincountOrRef`=0,`maxcount`=0 WHERE `item` IN (30020,30021,30022,30023,30024,30025,30026,30027,30028,30029,30030,30620);
--
-- Kael
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` IN (32405,34056,50032) AND `entry` = 19622;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 29905 AND `entry` = 19622;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 2 WHERE `item` = 32458 AND `entry` = 19622;
-- Vashj
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` IN (50031,90062) AND `entry` = 21212;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 29906 AND `entry` = 21212;
-- Boss Pattern
UPDATE `reference_loot_template` SET `mincountOrRef`=0, `maxcount`=0 WHERE `entry` IN (34052); -- 1 1

-- Setting Kael and Vashj Vortex back
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 25,`mincountOrRef`=2,`maxcount`=2 WHERE `entry` = 19622 AND `item` = 30183;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 25,`mincountOrRef`=2,`maxcount`=2 WHERE `entry` = 21212 AND `item` = 30183;
-- 
-- 32902,32905
UPDATE `creature_loot_template` SET `mincountOrRef` = 0, `maxcount` = 0 WHERE `item` IN (32902,32905); -- 1 3
-- Coilfang Armaments
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21863 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21339 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21301 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21299 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21298 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21263 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21251 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21232 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21231 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21230 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21229 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21228 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21227 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21226 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21225 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21224 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21221 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21220 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21218 AND `item` = 24368; -- 12
--

-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2233/tempest-keep-the-eye
--
-- ======================================================
-- Texts & Scripts
-- ======================================================
--
-- -9711 - -9720
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-9708,-9709,-9710,-9711,-9712,-9713,-9714,-9715,-9716,-9717,-9718,-9719,-9720,-9721,-9722,-9723,-9724,-9725);
INSERT INTO `creature_ai_texts` VALUES
(-9708,'This unit is ready to serve.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20040 OOC'),
(-9709,'After this mobility test, we\'ll only have the final weapons check to complete.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20042 OOC'),
(-9710,'Golem. Command. Operational status report.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20042 OOC'),
(-9711,'\'s hand begins to glow with Arcane energy.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'20041 on Overcharged Arcane Explosion Spellcast'),
(-9712,'All clear!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9713,'First squad is ready for battle!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9714,'Our blades and spells are at the ready!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9715,'Our defenses stand ready!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9716,'Second squad is ready to fight!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9717,'The enemy will not get past us!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9718,'Third squad reporting in!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9719,'We stand ready to defend the Eye!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9720,'We will show our enemies no quarter!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20031 on Event'),
(-9721,'As you were!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'20035 OOC'),
(-9722,'Excellent work.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'20035 OOC'),
(-9723,'Stand vigilant.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'20035 OOC'),
(-9724,'Very well.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'20035 OOC'),
(-9725,'Your conduct makes me proud.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'20035 OOC');
--
-- Script for Patrol
--
-- ======================================================
-- NPC Research
-- ======================================================
--
-- Bloodwarder Legionnaire 20031
-- 180000 Vulnerable to Crowd Control.Vulnerable to snares. 
-- 33500/whirlwind 15284/cleave 35949/bloodthirst
-- http://wowwiki.wikia.com/wiki/Bloodwarder_Legionnaire , http://www.wowhead.com/npc=20031/bloodwarder-legionnaire#abilities
UPDATE `creature` SET `modelid`='0',`equipment_id`='0' WHERE `id` IN ('20031');
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='6346',`maxdmg`='7537' WHERE `entry` = 20031; -- 2279 4662 -- 12,691 - 15,074
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20031;
INSERT INTO `creature_ai_scripts` VALUES
('2003101','20031','4','0','100','2','0','0','0','0','11','42459','0','1','0','0','0','0','0','0','0','0','Bloodwarder Legionnaire - Cast Dual Wield on Aggro'),
('2003102','20031','9','0','100','3','0','5','8000','11000','11','15284','1','0','0','0','0','0','0','0','0','0','Bloodwarder Legionnaire - Cast Cleave'),
('2003103','20031','0','0','100','3','8000','15000','12000','15000','11','33500','0','0','0','0','0','0','0','0','0','0','Bloodwarder Legionnaire - Cast Whirlwind'),
('2003104','20031','0','0','100','3','5000','10000','12000','18000','11','35949','1','0','0','0','0','0','0','0','0','0','Bloodwarder Legionnaire - Cast Bloodthirst');
--
-- Bloodwarder Vindicator 20032 mob_Bloodwarder_Vindicator
-- http://www.wowhead.com/npc=20032/bloodwarder-vindicator#comments http://wowwiki.wikia.com/wiki/Bloodwarder_Vindicator?direction=next&oldid=796374 
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`mindmg`='8410',`maxdmg`='9985',`mechanic_immune_mask`='1073691647',`flags_extra`='4194304'  WHERE `entry` = 20032; -- 3024 6173 2000 -- 16,820 - 19,969
UPDATE `creature_equip_template` SET `equipmodel2`='41645',`equipinfo2`='33490436',`equipslot2`='1038' WHERE `entry` = 2192;
--
-- Astromancer 20033
-- 37109/fireball-volley 35916/molten-armor
-- Vulnerable to all Crowd Control.Vulnerable to snares.Immune to all Stun effects.Immune to Curse of Tongues.Immune to Mind Control 
-- http://wowwiki.wikia.com/wiki/Astromancer?direction=next&oldid=1476928 , http://www.wowhead.com/npc=20033/astromancer
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4906',`maxdmg`='5825',`baseattacktime`='2000',`mechanic_immune_mask`='10241',`flags_extra`='4194304'  WHERE `entry` = 20033; -- 1323 2701 1500 -- 7,359 - 8,737
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20033;
INSERT INTO `creature_ai_scripts` VALUES
('2003301','20033','1','0','100','3','1000','1000','600000','600000','11','35915','0','1','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor OOC'),
('2003302','20033','4','0','100','2','0','0','0','0','11','35915','0','32','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor on Aggro'),
('2003303','20033','9','0','100','3','0','40','5000','7000','11','37109','4','0','0','0','0','0','0','0','0','0','Astromancer - Cast Fireball Volley'),
('2003304','20033','9','0','100','3','0','20','6000','18000','11','37110','1','0','0','0','0','0','0','0','0','0','Astromancer - Cast Fire Blast'),
('2003305','20033','27','0','100','3','35915','1','8000','24000','11','33482','0','32','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor on Missing Buff'),
('2003306','20033','0','0','100','3','8000','16000','8000','12000','11','36278','0','1','0','0','0','0','0','0','0','0','Astromancer - Cast Blast Wave');
--
-- Star Scryer 20034
-- 160,000 ~ 37126/arcane-blast 37122/domination Starfire
-- Vulnerable to sheep and trap and sap,Vulnerable to snares,Immune to all Stun effects,Immune to Curse of Tongues,Immune to Mind Control
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5607',`maxdmg`='6657',`mechanic_immune_mask`='10241',`flags_extra`='4194304' WHERE `entry` = 20034; -- 1513 3087 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20034;
INSERT INTO `creature_ai_scripts` VALUES
('2003401','20034','9','0','100','3','0','5','10000','15000','11','37126','1','0','0','0','0','0','0','0','0','0','Star Scryer - Cast Arcane Blast'),
('2003402','20034','0','0','100','3','5000','10000','7000','15000','11','37124','4','32','0','0','0','0','0','0','0','0','Star Scryer - Cast Starfall'),
('2003403','20034','0','0','100','3','7000','15000','15000','20000','11','37122','5','1','0','0','0','0','0','0','0','0','Star Scryer - Cast Domination');
--
-- Bloodwarder Marshal 20035
-- http://www.wowhead.com/npc=20035/bloodwarder-marshal#comments http://wowwiki.wikia.com/wiki/Bloodwarder_Marshal?direction=next&oldid=796387
UPDATE `creature` SET `equipment_id`='0' WHERE `id` IN ('20035');
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='7385',`maxdmg`='8770',`baseattacktime`='1600',`mechanic_immune_mask`='1073691647' WHERE `entry` = 20035; -- 2653 5424 2000 -- 14,769 - 17,540
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20035;
INSERT INTO `creature_ai_scripts` VALUES
('2003501','20035','4','0','100','2','0','0','0','0','11','42459','0','1','0','0','0','0','0','0','0','0','Bloodwarder Marshal - Cast Dual Wield on Aggro'),
('2003502','20035','9','0','100','3','0','5','9000','12000','11','34996','1','0','13','-5','1','0','0','0','0','0','Bloodwarder Marshal - Cast Uppercut and Modify Threat'),
('2003503','20035','0','0','100','3','6000','12000','7000','14000','11','36132','0','0','0','0','0','0','0','0','0','0','Bloodwarder Marshal - Cast Whirlwind'),
('2003504','20035','0','0','100','3','3000','9000','10000','15000','11','35949','1','0','0','0','0','0','0','0','0','0','Bloodwarder Marshal - Cast Bloodthirst at 50% HP');
--
-- Bloodwarder Squire 20036 mob_Bloodwarder_Squire
-- 150000  http://www.wowhead.com/npc=20036/bloodwarder-squire#abilities http://wowwiki.wikia.com/wiki/Bloodwarder_Squire?direction=next&oldid=796394
UPDATE `creature` SET `modelid`='0',`equipment_id`='0' WHERE `id` = 20036;
UPDATE `creature_template` SET `modelid_A2`='21001',`modelid_H2`='21001',`armor`='7100',`speed`='1.48',`mindmg`='6308',`maxdmg`='7489',`mechanic_immune_mask`='1073692659',`flags_extra`='4194304' WHERE `entry` = 20036; -- 2268 4630 1600 -- 12,615 - 14,977
--
-- Tempest Falconer 20037 mob_tempest_falconer
-- http://www.wowhead.com/npc=20037/tempest-falconer#comments http://wowwiki.wikia.com/wiki/Tempest_Falconer?direction=next&oldid=796410 
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`mindmg`='5555',`maxdmg`='7777',`baseattacktime`='1400',`mechanic_immune_mask`='1073692671' WHERE `entry` = 20037; -- 556 2778 2000 -- 5,555 - 7,777
--
-- Phoenix-Hawk Hatchling 20038 mob_phoenixhawk_hatchling
-- 72k hp packs of 5-7 currently fix 6
-- http://wowwiki.wikia.com/wiki/Phoenix-Hawk_Hatchling?direction=next&oldid=796420 , http://www.wowhead.com/npc=20038/phoenix-hawk-hatchling 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3901',`maxdmg`='4633',`baseattacktime`='1400',`mechanic_immune_mask`='2053' WHERE `entry` = 20038; -- 1402 2865 2000 -- 7,802 - 9,265
--
-- Phoenix-Hawk 20039 mob_phoenix_hawk
-- http://www.wowhead.com/npc=20039 , http://wowwiki.wikia.com/wiki/Phoenix-Hawk?direction=next&oldid=706656
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='9753',`maxdmg`='11581',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304'  WHERE `entry` = 20039; -- 1402 2865 -- 7,802 - 9,265 -- 9753 11581
--
-- Crystalcore Devastator 20040 mob_crystalcore_devastator
-- http://wowwiki.wikia.com/wiki/Crystalcore_Devastator?direction=next&oldid=1343520 http://www.wowhead.com/npc=20040/crystalcore-devastator#comments
-- By huntergenwedar (2,153 – 4·15) on 2007/05/15 (Patch 2.0.12) These guys have about 1 million HP
-- These have around 450k-500k hp after 2.1
UPDATE `creature_template` SET `speed`='1',`mindmg`='7384',`maxdmg`='8770',`mechanic_immune_mask`='1073709055',`flags_extra`='4194304' WHERE `entry` = 20040; -- 0.6 3316 6781 -- 18,461 - 21,926
--
-- Crystalcore Sentinel 20041
-- http://www.wowhead.com/npc=20041/crystalcore-sentinel#comments http://wowwiki.wikia.com/wiki/Crystalcore_Sentinel
UPDATE `creature_template` SET `mindmg`='6462',`maxdmg`='7674',`dmgschool`='6',`mechanic_immune_mask`='1073709055',`flags_extra`='4194304' WHERE `entry` = 20041; -- 2902 5933 0 -- 16,154 - 19,185 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20041');
INSERT INTO `creature_ai_scripts` VALUES
('2004101','20041','0','0','100','3','9000','14000','25000','35000','11','37104','1','0','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Overcharge'), -- 4
('2004102','20041','0','0','100','3','21000','25000','25000','30000','11','37106','0','0','1','-9711','0','0','0','0','0','0','Crystalcore Sentinel - Cast Charged Arcane Explosion and Emote'),
('2004103','20041','2','0','100','2','15','0','0','0','11','34937','0','1','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Power Down at 15% HP'),
('2004104','20041','0','0','100','3','4000','8000','8000','16000','11','40492','0','0','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Trample');
--
-- Tempest-Smith 20042 mob_tempest_smith
-- http://www.wowhead.com/npc=20042/tempest-smith#comments http://wowwiki.wikia.com/wiki/Tempest-Smith?oldid=796371 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3631',`maxdmg`='4468',`baseattacktime`='1400',`mechanic_immune_mask`='1092',`flags_extra`='4194304' WHERE `entry` = 20042; -- 1188 2862 2000 -- 7,261 - 8,935
--
-- Apprentice Star Scryer 20043
-- http://www.wowhead.com/npc=20043/apprentice-star-scryer#abilities http://wowwiki.wikia.com/wiki/Apprentice_Star_Scryer?direction=next&oldid=803127
-- Melee for 3-4k  (on cloth i think)
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='2778',`maxdmg`='3889' WHERE `entry` = 20043; -- 1 556 2778 -- 5,555 - 7,777
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20043');
INSERT INTO `creature_ai_scripts` VALUES
('2004301','20043','4','0','100','2','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Set Phase 1 on Aggro'),
('2004302','20043','9','0','100','3','0','50','3400','4800','11','37129','4','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Volley'),
('2004303','20043','9','13','100','3','0','20','8000','12000','11','37133','1','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Buffet (Phase 1)'),
('2004304','20043','24','13','100','3','37133','10','5000','5000','22','2','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Set Phase 2 on Target Max Arcane Buffet Aura Stack (Phase 1)'),
('2004305','20043','28','11','100','3','37133','1','5000','5000','22','1','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Set Phase 1 on Target Missing Arcane Buffet Aura Stack (Phase 2)'),
('2004306','20043','9','0','100','3','0','8','12000','16000','11','38725','0','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Explosion'),
('2004307','20043','0','0','100','3','15000','18000','14000','17000','11','37132','1','0','0','0','0','0','0','0','0','0','Apprentice Star Scryer - Cast Arcane Shock');
--
-- Novice Astromancer 20044 mob_novice_astromancer
-- http://wowwiki.wikia.com/wiki/Novice_Astromancer?direction=next&oldid=1377868 http://www.wowhead.com/npc=20044/novice-astromancer#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='2778',`maxdmg`='3889',`mechanic_immune_mask`='612447863' WHERE `entry` = 20044; -- 556 2778 -- 5,555 - 7,777
-- ('2004401','20044','1','0','100','3','1000','1000','600000','600000','11','37282','0','1','0','0','0','0','0','0','0','0','Novice Astromancer - Cast Fire Shield on Spawn'),
-- ('2004403','20044','9','5','100','3','8','50','3400','4800','11','37111','1','0','0','0','0','0','0','0','0','0','Novice Astromancer - Cast Fireball (Phase 1)'),
-- ('2004408','20044','9','0','100','3','0','20','12000','16000','11','38728','0','1','0','0','0','0','0','0','0','0','Novice Astromancer - Cast Fire Nova'),
-- ('2004409','20044','0','0','100','3','15000','19000','18000','22000','11','37279','5','1','0','0','0','0','0','0','0','0','Novice Astromancer - Cast Rain of Fire'),
-- ('2004410','20044','27','0','100','3','37282','1','15000','30000','11','37282','0','1','0','0','0','0','0','0','0','0','Novice Astromancer - Cast Fire Shield on Missing Buff'),
--
-- Nether Scryer 20045
UPDATE `creature` SET `modelid`='0' WHERE `id` = 20045;
-- http://www.wowhead.com/npc=20045/nether-scryer#abilities http://wowwiki.wikia.com/wiki/Nether_Scryer 
-- ai maybe malfunction, was deleted in db atm
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5351',`maxdmg`='6352',`equipment_id`='8036',`mechanic_immune_mask`='1073430527',`flags_extra`='4194304' WHERE `entry` = 20045; -- 1925 3927 -- 10,701 - 12,703
DELETE FROM `creature_equip_template` WHERE `entry` = 8036;
INSERT INTO `creature_equip_template` VALUES
(8036,40359,0,0,285346306,0,0,2,0,0);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20045');
INSERT INTO `creature_ai_scripts` VALUES
('2004501','20045','9','0','100','3','0','5','12000','16000','11','37126','4','0','0','0','0','0','0','0','0','0','Nether Scryer - Cast Arcane Blast'),
('2004502','20045','2','0','100','2','99','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004503','20045','2','0','100','2','98','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004504','20045','2','0','100','2','97','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004505','20045','2','0','100','2','96','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004506','20045','2','0','100','2','95','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination');
--
-- Astromancer Lord 20046
-- Has a fire shield buff like the astromages in Mechanaar, however it is not stealable/dispelable.
-- da in dem pack kein mc mob ist ist davon auszugehen, dass der npc tatsächlich mc konnte prenerf.
-- http://www.wowhead.com/npc=20046/astromancer-lord#abilities http://wowwiki.wikia.com/wiki/Astromancer_Lord?direction=next&oldid=1518430
UPDATE `creature` SET `modelid`='0',`equipment_id`='0' WHERE `id` IN ('20046');
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5351',`maxdmg`='6352',`baseattacktime`='1400',`mechanic_immune_mask`='612450143',`flags_extra`='4194304' WHERE `entry` = 20046; -- 1925 3927 2000 -- 10,701 - 12,703
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20046;
INSERT INTO `creature_ai_scripts` VALUES
('2004601','20046','1','0','100','3','1000','1000','600000','600000','11','38732','0','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Shield OOC'),
('2004602','20046','9','0','100','3','0','40','3400','4800','11','37109','4','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fireball Volley'),
('2004603','20046','9','0','100','3','0','20','12000','16000','11','37110','4','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Blast'),
('2004604','20046','9','0','100','3','0','5','15000','20000','11','37289','1','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Dragon\'s Breath'),
('2004605','20046','27','0','100','3','38732','1','3000','6000','11','38732','0','32','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Shield on Missing Buff'),
('2004606','20046','0','0','100','3','8000','12000','10000','20000','11','37122','5','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Domination'),
('2004607','20046','0','0','100','3','8000','16000','16000','32000','11','36278','0','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Blast Wave');
--
-- Crimson Hand Battle Mage 20047
-- http://www.wowhead.com/npc=20047/crimson-hand-battle-mage#abilities http://wowwiki.wikia.com/wiki/Crimson_Hand_Battle_Mage
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`baseattacktime`='1400',`equipment_id`='8037',`mechanic_immune_mask`='502935279',`flags_extra`='4194304' WHERE `entry` = 20047; -- 1513 3087 2000 -- 8,411 - 9,985
DELETE FROM `creature_equip_template` WHERE `entry` = 8037;
INSERT INTO `creature_equip_template` VALUES
(8037,43036,0,0,218171138,0,0,3,0,0);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20047;
INSERT INTO `creature_ai_scripts` VALUES
('2004701','20047','9','0','100','3','0','40','4400','5800','11','37262','1','0','0','0','0','0','0','0','0','0','Crimson Hand Battle Mage - Cast Frostbolt Volley'), -- 0
('2004702','20047','9','0','100','3','0','8','15000','21000','11','37265','1','0','0','0','0','0','0','0','0','0','Crimson Hand Battle Mage - Cast Cone of Cold'), -- 0
('2004703','20047','0','0','100','3','12000','15000','18000','24000','11','37263','4','0','0','0','0','0','0','0','0','0','Crimson Hand Battle Mage - Cast Blizzard'),
('2004704','20047','9','0','100','3','0','5','5000','10000','11','39087','1','0','0','0','0','0','0','0','0','0','Crimson Hand Battle Mage - Cast Frost Attack');
--
-- Crimson Hand Centurion 20048
-- http://www.wowhead.com/npc=20048/crimson-hand-centurion#comments http://wowwiki.wikia.com/wiki/Crimson_Hand_Centurion?direction=next&oldid=1338002
UPDATE `creature` SET `modelid`='0',`equipment_id`='0' WHERE `id` = 20048;
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8411',`maxdmg`='9985',`mechanic_immune_mask`='33557825',`flags_extra`='4194304' WHERE `entry` = 20048; -- 1513 3087 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20048;
INSERT INTO `creature_ai_scripts` VALUES
('2004801','20048','0','0','100','3','5000','9000','15000','22000','11','37268','0','1','0','0','0','0','0','0','0','0','Crimson Hand Centurion - Cast Arcane Flurry');
--
-- Crimson Hand Blood Knight 20049 mob_crimson_hand_blood_knight
-- http://www.wowhead.com/npc=20049/crimson-hand-blood-knight#comments http://wowwiki.wikia.com/wiki/Crimson_Hand_Blood_Knight?direction=next&oldid=1252922
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`baseattacktime`='1400',`mechanic_immune_mask`='1073430515',`flags_extra`='4194304' WHERE `entry` = 20049; -- 1513 3087 2000 -- 8,411 - 9,985
UPDATE `creature_equip_template` SET `equipmodel2`='41645',`equipinfo2`='33490436',`equipslot2`='1038' WHERE `entry` = 2196;
--
-- Crimson Hand Inquisitor 20050
-- http://www.wowhead.com/npc=20050/crimson-hand-inquisitor#abilities http://wowwiki.wikia.com/wiki/Crimson_Hand_Inquisitor
UPDATE `creature` SET `modelid`='0',`equipment_id`='0' WHERE `id` IN ('20050');
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`mechanic_immune_mask`='536489955',`flags_extra`='4194304' WHERE `entry` = 20050; -- 1513 3087 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20050;
INSERT INTO `creature_ai_scripts` VALUES
('2005001','20050','4','0','100','2','0','0','0','0','11','37274','0','0','0','0','0','0','0','0','0','0','Crimson Hand Inquisitor - Cast Power Infusion on Aggro'),
('2005002','20050','0','0','100','3','10000','20000','10000','20000','11','37274','0','32','0','0','0','0','0','0','0','0','Crimson Hand Inquisitor - Cast Power Infusion'),
('2005003','20050','9','0','100','3','0','20','3000','9000','11','37276','1','0','0','0','0','0','0','0','0','0','Crimson Hand Inquisitor - Cast Mind Flay'),
('2005004','20050','9','0','100','3','0','30','8000','13000','11','37275','4','32','0','0','0','0','0','0','0','0','Crimson Hand Inquisitor - Cast Shadow Word: Pain');
--
-- Crystalcore Mechanic 20052 mob_crystalcore_mechanic
-- http://www.wowhead.com/npc=20052/crystalcore-mechanic#comments http://wowwiki.wikia.com/wiki/Crystalcore_Mechanic
-- They are confirmed to do about 2500-2900 physical damage. 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5714',`maxdmg`='6629',`baseattacktime`='1400',`mechanic_immune_mask`='1073561599',`flags_extra`='4194304' WHERE `entry` = 20052; -- 2035 4162 2000 -- 11,331 - 13,458
--
-- ===================
-- Bosses
-- ===================
--
-- Al'ar <Phoenix God> 19514
UPDATE `creature_template` SET `mindmg`='10222',`maxdmg`='12000',`resistance2`='-1',`inhabittype`='7',`mechanic_immune_mask`='1073430527',`flags_extra`='4194305' WHERE `entry` = 19514; -- 3778 7333 -- 20,444 - 23,999
--
-- Ember of Al'ar 19551
-- http://www.wowhead.com/npc=19551/ember-of-alar#abilities http://wowwiki.wikia.com/wiki/Ember_of_Al'ar
-- Hit for ~1500 damage.  mob_ember_of_alar
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`speed`=2,`mindmg`=4196,`maxdmg`=4292, `dmgschool` = 2, `baseattacktime`=1400,`resistance2`=-1,`mechanic_immune_mask`=75644246,`flags_extra`=4194304 WHERE `entry` = 19551; -- 1520 1664 0 2000 -- 6,294 - 6,438
--
-- Void Reaver 19516
-- http://wowwiki.wikia.com/wiki/Void_Reaver?direction=next&oldid=565999
UPDATE `creature_template` SET `speed`='2',`scale`='1',`mindmg`='9780',`maxdmg`='11608',`mechanic_immune_mask`='1073709055' WHERE `entry` = 19516; -- 1.2 0.8 3519 7175 -- 19,560 - 23,216 
--
-- High Astromancer Solarian 18805
-- www.wowhead.com/npc=18925/high-astromancer-solarian#comments http://wowwiki.wikia.com/wiki/High_Astromancer_Solarian?oldid=829691 http://wowwiki.wikia.com/wiki/High_Astromancer_Solarian?direction=next&oldid=697382
-- As a DPS warrior, she can crush me for 8k, and one of our rogues reported 10k. (Arcane Dmg?)
UPDATE `creature_template` SET `minmana`='420970',`maxmana`='420970',`speed`='2',`scale`='0.7',`mindmg`='5434',`maxdmg`='6449',`dmgschool`='0',`baseattacktime`='1400',`mechanic_immune_mask`='650854399' WHERE `entry` = 18805; -- 1.2 0.7 2444 4983 2000 -- 6792 8062 --13,584 - 16,123
--
-- Solarium Agent 18925
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='1500',`maxdmg`='2000',`baseattacktime`='1400',`equipment_id`='8002' WHERE `entry` = 18925; -- 1 845 1267 2000 -- 2,111 - 2,333
--
-- Solarium Priest 18806
-- http://wowwiki.wikia.com/wiki/High_Astromancer_Solarian?direction=next&oldid=829694 mob_solarium_priest
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='200',`maxdmg`='400',`baseattacktime`='1400',`flags_extra`='4194304'  WHERE `entry` = 18806; -- 66 155 2000
--
-- Kael'thas Sunstrider <Lord of the Blood Elves> 19622
-- http://wowwiki.wikia.com/wiki/Kael%27thas_Sunstrider_(tactics)?direction=prev&oldid=1187868
-- ~ 1,700,000? atm 4188300 -> 3624683 * 1.15549415
-- http://wowwiki.wikia.com/wiki/Kael%27thas_Sunstrider_(tactics)?oldid=958878
UPDATE `creature_template` SET `speed`='2',`mindmg`='9781',`maxdmg`='11608',`baseattacktime`='1400',`mechanic_immune_mask`='617299967' WHERE `entry` = 19622; -- 1.2 4399 8969 2000 -- 24,451 - 29,021
--
-- Thaladred the Darkener <Advisor to Kael'thas> 20064
-- http://wowwiki.wikia.com/wiki/Thaladred_the_Darkener 378000 -> 491400
UPDATE `creature_template` SET `rank`= 3, `speed`='0.9',`mindmg`='10548',`maxdmg`='12527',`mechanic_immune_mask`='653213695' WHERE `entry` = 20064; -- 1 XXX 3790 7747 -- 21,096 - 25,053
--
-- Lord Sanguinar <The Blood Hammer> 20060
-- http://wowwiki.wikia.com/wiki/Lord_Sanguinar 376000 -> 488800
UPDATE `creature_template` SET `rank`='3',`speed`='1.48',`mindmg`='7501',`maxdmg`='8908',`mechanic_immune_mask`='653213695' WHERE `entry` = 20060; -- 1 3369 6886 -- 18,752 - 22,269
--
-- Grand Astromancer Capernian <Advisor to Kael'thas> 20062
-- http://wowwiki.wikia.com/wiki/Grand_Astromancer_Capernian 281000 -> 365300
UPDATE `creature_template` SET `rank`='3',`armor`='6700',`speed`='1.48',`mindmg`='2754',`maxdmg`='3312',`baseattacktime`='2000' WHERE `entry` = 20062; -- 1 959 2074 -- 5,508 - 6,623
--
-- Master Engineer Telonicus <Advisor to Kael'thas> 20063
-- http://wowwiki.wikia.com/wiki/Master_Engineer_Telonicus 377000 -> 490100
UPDATE `creature_template` SET `rank`='3',`speed`='1.48',`mindmg`='6692',`maxdmg`='7192' WHERE `entry` = 20063; -- 1 2754 3312 -- 13,383 - 14,383
--
-- http://wowwiki.wikia.com/wiki/Kael%27thas_Sunstrider_(tactics)?oldid=738387
-- All of the weapons have approximately 300k HP, besides the staff which has about 100k less and the shield which has about 100k more.
-- First with actual weapon hp data http://wowwiki.wikia.com/wiki/Kael%27thas_Sunstrider_(tactics)?direction=next&oldid=1176105
--
-- weapon wowhead nerf * 1.57533987 +10% (documented nerf) +((30% buff (talents / knowledge)) 
-- Netherstrand Longbow 21268
-- ~210,000 HP (208000) + 10% nerf for advisor+weapon 231000 -> 300300 weapon_advisor 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4179',`maxdmg`='4963',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` = 21268; -- 1502 3070 -- 8,358 - 9,926
--
-- Devastation 21269
-- http://wowwiki.wikia.com/wiki/Kael%27thas_Sunstrider_(tactics)?oldid=1139113 ~230,000 HP + 10% 253000 -> 328900
-- Also has much higher HP than the other weapons. 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8358',`maxdmg`='9926',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` = 21269; -- 220059 3003 6139 --  16,716 - 19,852
--
-- Cosmic Infuser 21270
-- ~280,000 HP  + 10% nerf for advisor+weapon 308000 -> 400400 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4179',`maxdmg`='4963',`baseattacktime`='1400',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` = 21270; -- 251496 1502 3070 2000 -- 8,358 - 9,926
--
-- Infinity Blades 21271
-- ~210,000 HP + 10% 231000 -> 300300
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='5000',`maxdmg`='6111',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` = 21271; -- 1667 3889 -- 9,999 - 12,221
--
-- Warp Slicer 21272
-- ~290,000 HP + 10% 319000 -> 414700
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='6686',`maxdmg`='7941',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` = 21272; -- 1502 3070 -- 8,358 - 9,926
--
-- Phaseshift Bulwark 21273
-- ~290,000 HP + 10% 319000 -> 414700
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3999',`maxdmg`='4444',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` = 21273; -- 1666 2555 -- 7,998 - 8,887
--
-- Staff of Disintegration 21274
-- ~170,000 HP + 10% 187000 -> 243100
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4179',`maxdmg`='4963',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` = 21274; -- 1502 3070 -- 8,358 - 9,926
--
-- Phoenix Egg 21364 mob_phoenix_egg_tk
--  70k HP + 10% 77000 -> 100100
UPDATE `creature_template` SET `armor`='5800',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`=`unit_flags`|'262144',`dynamicflags`='8',`flags_extra`='4194304' WHERE `entry` = 21364;
--
-- Phoenix 21362 mob_phoenix_tk
-- http://www.wowhead.com/npc=21362/phoenix#abilities ~ 177458 + 10% 195204 -> 253765
-- added stun immunity
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='2278',`maxdmg`='3309',`resistance2`='0',`mechanic_immune_mask`='1073561599',`flags_extra`='4194304' WHERE `entry` = 21362; -- 1001 2046 -- 5,572 - 6,617 
--
-- ======================================================
-- Spawns & Pooling
-- ======================================================
--
DELETE FROM `creature` WHERE `guid` IN (12459,12460,12545,12546,12547,12548);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES 
(12459, 20031, 550, 1, 0, 0, 497.37, 101.67, 20.2899, 3.81968, 7200, 0, 0, 125668, 0, 0, 0),
(12460, 20031, 550, 1, 0, 0, 488.734, 107.574, 20.2899, 4.13952, 7200, 0, 0, 125668, 0, 0, 0),
(12545, 20033, 550, 1, 0, 0, 485.237, 107.537, 20.2899, 4.0116, 7200, 0, 0, 100520, 32310, 0, 0),
(12546, 20033, 550, 1, 0, 0, 482.367, 105.012, 20.2899, 4.0155, 7200, 0, 0, 100520, 32310, 0, 0),
(12547, 20032, 550, 1, 0, 0, 497.415, 97.8661, 20.2899, 3.7131, 7200, 0, 0, 160832, 48465, 0, 0),
(12548, 20034, 550, 1, 0, 0, 494.6575, 94.2722, 20.2898, 3.8506, 7200, 0, 0, 100520, 32310, 0, 0);
--
DELETE FROM `creature` WHERE `guid` IN (200032,200033,200034);
INSERT INTO `creature` VALUES
(200032, 20050, 550, 1, 0, 0, 742.0285, -0.7949, 46.7796, 3.1573, 7200, 0, 0, 230000, 49635, 0, 2),
(200033, 20048, 550, 1, 0, 0, 741.9401, 4.8253, 46.7796, 3.1573, 7200, 0, 0, 180000, 0, 0, 0),
(200034, 20048, 550, 1, 0, 0, 742.1139, -6.2403, 46.7788, 3.1573, 7200, 0, 0, 180000, 0, 0, 0);
--
-- ======================================================
-- Linking
-- ======================================================
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (12545,12546,12547,12548,12459,12460,200032,200033,200034);
DELETE FROM `creature_formations` WHERE `memberguid` IN (12545,12546,12547,12548,12459,12460,200032,200033,200034);
INSERT INTO `creature_formations` VALUES
--
(200032,200032,100,360,2),
(200032,200033,3,1.1,2),
(200032,200034,3,5.1,2),
--
(12545,12545,100,360,2),
(12545,12546,100,360,2),
(12545,12547,100,360,2),
(12545,12548,100,360,2),
(12545,12459,100,360,2),
(12545,12460,100,360,2);
--
-- ======================================================
-- Respawn
-- ======================================================
--
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (12545,12546,12547,12548,12459,12460,200032,200033,200034);
INSERT INTO `creature_linked_respawn` VALUES
--
(200032,82162),
(200033,82162),
(200034,82162),
--
(12545,12478),
(12546,12478),
(12547,12478),
(12548,12478),
(12459,12478),
(12460,12478);
--
-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================
--
SET @GUID := 200032;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX,YYY,ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,740.5244,-0.7594,46.7795,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,707.7401,-0.7159,46.7795,10000,0,0,100,0),
(@GUID,@POINT := @POINT + 1,709.5639,-0.6971,46.7795,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,742.0285,-0.7949,46.7796,10000,0,0,100,0);
--
-- ======================================================
-- Gameobjects
-- ======================================================
--
--
--
-- ======================================================
-- Miscellaneous
-- ======================================================
--
-- Other T5 Loot in SSC 2.1 Changes
--
-- Alar Loot
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 19514 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19514 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19514 AND `item` = 190052; -- 2
--
-- Void Reaver
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 19516 AND `item` = 29434; -- 100
-- Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 19516 AND `item` = 34054; -- 2
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19516 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19516 AND `item` = 90052; -- 2
--
-- Solarian
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 18805 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 18805 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 18805 AND `item` = 90052; -- 10
--
-- Kael'thas Sunstrider
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 19622 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19622 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19622 AND `item` = 90052; -- 10
-- Items
DELETE FROM `creature_loot_template` WHERE `entry` = 19622 AND `item` = 90056; -- not needed
UPDATE `creature_loot_template` SET `groupid`= 0, `maxcount` = 2 WHERE `entry` = 19622 AND `item` = 34056; -- make 90056 not needed anymore
-- Tokens
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 19622 AND `item` = 50032; -- 3
--

UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`*81 WHERE `item` = 30183;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100,`mincountOrRef`=2,`maxcount`=2 WHERE `entry` = 19622 AND `item` = 30183;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 55,`mincountOrRef`=2,`maxcount`=2 WHERE `entry` = 21212 AND `item` = 30183;

-- Astromancer Solarian Spotlight 18928
UPDATE `creature` SET `position_x`='432.5939', `position_y`='-373.6006', `position_z`='17.9604', `orientation`='1.0367' WHERE `guid` = 12457; 
UPDATE `creature_template` SET `flags_extra`='128' WHERE `entry` = 18928;

DELETE FROM `game_event_gameobject` WHERE `guid` IN (15773,210003,210004,210005,210006);
INSERT INTO `game_event_gameobject` VALUES
(15773,1),
(210003,1),
(210004,1),
(210005,1),
(210006,1);

UPDATE `gameobject` SET `spawnmask`=0 WHERE `id` = 183435;

UPDATE `quest_template` SET `RewRepValue1`='0' WHERE `entry` = 16;

-- Bleeding Hollow Archer
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17270;
INSERT INTO `creature_ai_scripts` VALUES
('1727001','17270','4','0','10','6','0','0','0','0','1','-158','-160','-157','0','0','0','0','0','0','0','0','Bleeding Hollow Archer - Random Say on Aggro'), -- -156','-181','-672'=160
('1727002','17270','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Bleeding Hollow Archer - Start Movement and Set Melee Weapon Model'),
('1727003','17270','9','0','100','7','5','30','2300','4000','11','18651','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer - Cast Multi Shot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727004','17270','9','0','100','3','5','30','2300','5000','11','18651','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Normal) - Cast Multi Shot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727005','17270','9','0','100','5','5','30','2300','5000','11','31942','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Heroic) - Cast Multi Shot and Set Ranged Weapon Model and Stop Movement'),
('1727006','17270','0','0','100','7','12100','15300','13300','18200','11','30614','4','1','40','2','0','0','21','0','0','0','Bleeding Hollow Archer - Cast Aimed Shot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727007','17270','9','0','50','3','5','30','2000','5000','11','15620','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Normal) - Cast Shoot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727008','17270','9','0','50','5','5','30','2000','5000','11','22907','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Heroic) - Cast Shoot and Set Ranged Weapon Model and Stop Movement'),
('1727009','17270','9','0','100','6','0','5','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Bleeding Hollow Archer - Start Movement and Set Melee Weapon Model Below 6 Yards'),
('1727010','17270','9','0','100','6','6','15','0','0','21','0','0','0','40','2','0','0','0','0','0','0','Bleeding Hollow Archer - Stop Movement and Set Ranged Weapon Model Above 5 Yards');

-- Start Pool Spawning for Arcane Vortex/Felmist/Swamp Gas/Windy Cloud
UPDATE `pool_template` SET `max_limit`='10' WHERE `entry` IN (30043,30044,30045,30046);

UPDATE `creature` SET `spawntimesecs`='900' WHERE `id` = 17407; -- 3600 
DELETE FROM `pool_creature` WHERE `pool_entry` = 30046;
INSERT INTO `pool_creature` VALUES 
(26582,30046,0,'Felmist - Shadowmoonvalley'),
(29060,30046,0,'Felmist - Shadowmoonvalley'),
(29061,30046,0,'Felmist - Shadowmoonvalley'),
(29099,30046,0,'Felmist - Shadowmoonvalley'),
(29395,30046,0,'Felmist - Shadowmoonvalley'),
(31825,30046,0,'Felmist - Shadowmoonvalley'),
(32374,30046,0,'Felmist - Shadowmoonvalley'),
(32375,30046,0,'Felmist - Shadowmoonvalley'),
(32376,30046,0,'Felmist - Shadowmoonvalley'),
(32377,30046,0,'Felmist - Shadowmoonvalley'),
(32583,30046,0,'Felmist - Shadowmoonvalley'),
(32584,30046,0,'Felmist - Shadowmoonvalley'),
(32585,30046,0,'Felmist - Shadowmoonvalley'),
(32594,30046,0,'Felmist - Shadowmoonvalley'),
(35870,30046,0,'Felmist - Shadowmoonvalley'),
(35871,30046,0,'Felmist - Shadowmoonvalley'),
(40531,30046,0,'Felmist - Shadowmoonvalley'),
(40532,30046,0,'Felmist - Shadowmoonvalley'),
(40552,30046,0,'Felmist - Shadowmoonvalley'),
(40558,30046,0,'Felmist - Shadowmoonvalley'),
(41637,30046,0,'Felmist - Shadowmoonvalley'),
(42968,30046,0,'Felmist - Shadowmoonvalley'),
(47088,30046,0,'Felmist - Shadowmoonvalley'),
(86826,30046,0,'Felmist - Shadowmoonvalley'),
(86827,30046,0,'Felmist - Shadowmoonvalley'),
(86828,30046,0,'Felmist - Shadowmoonvalley'),
(86829,30046,0,'Felmist - Shadowmoonvalley'),
(86830,30046,0,'Felmist - Shadowmoonvalley'),
(86833,30046,0,'Felmist - Shadowmoonvalley'),
(140647,30046,0,'Felmist - Shadowmoonvalley'),
(140648,30046,0,'Felmist - Shadowmoonvalley'),
(140649,30046,0,'Felmist - Shadowmoonvalley'),
(140650,30046,0,'Felmist - Shadowmoonvalley'),
(140651,30046,0,'Felmist - Shadowmoonvalley'),
(140768,30046,0,'Felmist - Shadowmoonvalley'),
(140772,30046,0,'Felmist - Shadowmoonvalley'),
(140794,30046,0,'Felmist - Shadowmoonvalley'),
(140795,30046,0,'Felmist - Shadowmoonvalley'),
(140796,30046,0,'Felmist - Shadowmoonvalley'),
(140797,30046,0,'Felmist - Shadowmoonvalley'),
(140800,30046,0,'Felmist - Shadowmoonvalley'),
(140801,30046,0,'Felmist - Shadowmoonvalley'),
(140802,30046,0,'Felmist - Shadowmoonvalley'),
(140803,30046,0,'Felmist - Shadowmoonvalley'),
(140804,30046,0,'Felmist - Shadowmoonvalley'),
(140805,30046,0,'Felmist - Shadowmoonvalley');

-- Shadowmoon Valley Tuber Node
UPDATE `creature` SET `MovementType`='0',`spawndist`='0' WHERE `id` = 21347;
-- UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'' WHERE `entry` = 21347;

-- Anveena
UPDATE `creature_template` SET `MovementType`='5' WHERE `entry` = 26046;
DELETE FROM `creature_template_addon` WHERE `entry` = 26046;
INSERT INTO `creature_template_addon` VALUES
(26046,0,0,0,0,0,0,33554432,'');

-- Skettis - Invis Raven Stone 22986
UPDATE `creature_template` SET `unit_flags`='33554432',`flags_extra`='130' WHERE `entry` = 22986; -- 0 2

-- Illidari Slayer 21639
UPDATE `creature` SET `spawndist`='0',`MovementType`='0' WHERE `guid` IN (75468,75469);

-- Infernal Attacker 21419
UPDATE `creature` SET `spawnmask`='1',`spawndist`='5',`MovementType`='1',`spawntimesecs`='30' WHERE `guid` IN (75029,75030,75031,75032,75033,75034,75035,75036,75037,75038,75039,75040,75041,75042,75043,75044,75045,75046,75047,75048,75049,75050,75051,75052,75053,75054,75055,75056,75057,75058,75059,75060,75061,75062,75064,75065,75066,75067,75068,75069,75070,75071,75072,75073,75074,75075,75076,75077,75078,75079,75081,75082,75083,75084,75085,75086,75087,75088,75089,75090,75091,75092,75093,75094,75095,75096,75097,75098,75099,75100,75101,75102,75103);
UPDATE `creature` SET `position_x`='-3854.5815', `position_y`='1991.5308', `position_z`='95.3527' WHERE `guid` = '75064';
UPDATE `creature` SET `position_x`='-3878.1271', `position_y`='2043.6038', `position_z`='94.6129' WHERE `guid` = '75065';
UPDATE `creature` SET `position_x`='-3702.0156', `position_y`='2097.8491', `position_z`='77.7276' WHERE `guid` = '75067';
UPDATE `creature` SET `position_x`='-3772.4577', `position_y`='1933.2860', `position_z`='97.2586' WHERE `guid` = '75068';

-- Invis Infernal Caster 21417
UPDATE `creature` SET `position_x`='-4000.7719', `position_y`='1970.2165', `position_z`='110.0740' WHERE `guid` = '74987';
UPDATE `creature_template` SET `InhabitType`='7',`AIName`='EventAI' WHERE `entry` = '21417';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21417';
INSERT INTO `creature_ai_scripts` VALUES
('2141701','21417','10','0','100','1','1','50','48000','48000','11','5739','6','39','0','0','0','0','0','0','0','0','Invis Infernal Caster - Cast Meteor Strike Infernal OOC LOS');

-- Black Blood of Draenor 23286
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`AIName`='EventAI' WHERE `entry` = '23286';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23286';
INSERT INTO `creature_ai_scripts` VALUES
('2328601','23286','0','0','100','1','6000','12000','15000','20000','11','40818','0','0','0','0','0','0','0','0','0','0','Black Blood of Draenor - Cast Toxic Slime'),
('2328602','23286','2','0','100','0','40','0','0','0','11','7279','1','1','25','0','0','0','0','0','0','0','Black Blood of Draenor - Cast Black Sludge and Flee at 40% HP');

-- Earthmender Wilda Trigger 21041
UPDATE `creature_template` SET `flags_extra`='130' WHERE `entry` = 21041;

-- Enraged Fire Spirit 21061
UPDATE `creature_template` SET `dmgschool`='2',`inhabittype`='3',`resistance2`='-1' WHERE `entry` = 21061;

-- Enraged Earth Spirit 21050
UPDATE `creature_template` SET `resistance3`='-1' WHERE `entry` = 21050;

-- Lady Sinestra 23283
UPDATE `creature_template` SET `flags_extra`='130' WHERE `entry` = 23283; -- 2

-- Gan'arg Technician
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`AIName`='EventAI' WHERE `entry` = '21960';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21960';
INSERT INTO `creature_ai_scripts` VALUES
('2196001','21960','1','0','40','1','2000','20000','35000','60000','11','38053','0','0','0','0','0','0','0','0','0','0','Gan\'arg Technician - Cast Tune Deathforge Infernal OOC');

-- Cataclysm Overseer 21961
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16' WHERE `entry` = '21961';

-- Captured Water Spirit 21029
UPDATE `creature_template` SET `InhabitType`='7' WHERE `entry` = 21029;

-- Orb Target
UPDATE `creature_template` SET `modelid_H`='11686' WHERE `entry` = 25640; -- 1126

-- Hellfire Warder – Höllenfeuerwärter 18829
UPDATE `creature_template` SET `modelid_A2`='11438',`modelid_H2`='11440',`minlevel`='73',`maxlevel`='73',`rank`='3',`mindmg`='7847',`maxdmg`='9315',`baseattacktime`='2000',`speed`='1.48',`mechanic_immune_mask`='646004723' WHERE `entry` = 18829; -- 9417 11178 -- 11,771 - 13,973
--
-- Hellfire Channeler – Kanalisierer des Höllenfeuers 17256
UPDATE `creature_template` SET `modelid_A`='9609',`modelid_H`='9609',`modelid_A2`='9865',`modelid_H2`='9865',`mindmg`='7245',`maxdmg`='8599',`baseattacktime`='2000',`speed`='1.48',`mechanic_immune_mask`='619396859',`flags_extra`='2' WHERE `entry` = 17256; -- 8694 10318 -- 10,867 - 12,898
--
-- Burning Abyssal - Brennender Abyss 17454
UPDATE `creature_template` SET `mindmg`='673',`maxdmg`='952',`baseattacktime`='2000',`speed`='1.20' WHERE `entry` = 17454; -- 807 1142 -- 1,009 - 1,428

UPDATE `creature` SET `position_x`='-3821.3032', `position_y`='1618.7412', `position_z`='76.9796', `orientation`='6.2741' WHERE `guid` = '101755';

DELETE FROM `creature` WHERE `guid` BETWEEN 86800 AND 86833;
INSERT INTO `creature` VALUES (86800, 21029, 530, 1, 0, 0, -2729.85, 1215.23, 48.2141, 1.5708, 1407, 0, 0, 3700, 2434, 0, 0);
INSERT INTO `creature` VALUES (86801, 21029, 530, 1, 0, 0, -2713.19, 1221.69, 38.1432, 2.09439, 1407, 0, 0, 3700, 2434, 0, 0);
INSERT INTO `creature` VALUES (86802, 21061, 530, 1, 0, 0, -3619.8503, 1599.2523, 45.0802, 6.10141, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86803, 21061, 530, 1, 0, 0, -3473.6682, 1589.5378, 45.8765, 5.02542, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86804, 21061, 530, 1, 0, 0, -3514.8774, 1625.6716, 45.6920, 5.64597, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86805, 21061, 530, 1, 0, 0, -3366.8505, 1574.8800, 46.9739, 5.752, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86806, 21029, 530, 1, 0, 0, -2711.53, 1230.92, 37.3221, 2.54818, 1407, 0, 0, 3700, 2434, 0, 0);
INSERT INTO `creature` VALUES (86807, 21029, 530, 1, 0, 0, -2721.25, 1216.49, 41.7782, 1.79769, 1407, 0, 0, 3700, 2434, 0, 0);
INSERT INTO `creature` VALUES (86808, 21029, 530, 1, 0, 0, -2708.88, 1239.1, 38.1921, 3.08923, 1407, 0, 0, 3700, 2434, 0, 0);
INSERT INTO `creature` VALUES (86809, 21061, 530, 1, 0, 0, -3342.5866, 1488.6488, 59.3346, 5.42213, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86810, 21061, 530, 1, 0, 0, -3311.4440, 1507.7302, 50.1914, 0.258133, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86811, 21061, 530, 1, 0, 0, -3250.7165, 1558.5388, 53.1279, 3.91809, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86812, 21061, 530, 1, 0, 0, -3273.1884, 1412.9414, 53.3567, 5.02078, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86813, 21061, 530, 1, 0, 0, -3189.0644, 1480.2093, 55.6898, 1.02703, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86814, 21050, 530, 1, 0, 0, -3758.6130, 1861.0747, 91.4309, 1.51687, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86815, 21050, 530, 1, 0, 0, -3667.8227, 1935.2979, 73.7587, 1.37943, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86816, 21050, 530, 1, 0, 0, -3808.1694, 1809.0141, 93.8167, 3.69243, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86817, 21050, 530, 1, 0, 0, -3762.9, 1782.16, 90.7682, 3.74034, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86818, 21050, 530, 1, 0, 0, -3847.5053, 1680.4007, 81.5765, 2.75701, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86819, 21050, 530, 1, 0, 0, -3898.3459, 1687.4758, 93.6202, 2.23865, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86820, 21050, 530, 1, 0, 0, -3832.96, 1652.14, 83.163, 4.31603, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86821, 21050, 530, 1, 0, 0, -3923.8789, 1633.2105, 85.6468, 3.86442, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86822, 21050, 530, 1, 0, 0, -3923.4995, 1571.6365, 80.7014, 4.40799, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86823, 21050, 530, 1, 0, 0, -4002.2148, 1614.7431, 95.9401, 1.41336, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86824, 21050, 530, 1, 0, 0, -3123.9555, 1319.5333, 20.4525, 2.85675, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86825, 21050, 530, 1, 0, 0, -3119.5791, 1349.0131, 25.6996, 2.5431, 300, 5, 0, 6761, 0, 0, 1);
INSERT INTO `creature` VALUES (86826, 17407, 530, 1, 0, 0, -3258.6887, 2679.0483, 59.3172, 3.06697, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (86827, 17407, 530, 1, 0, 0, -3345.0781, 2235.3308, 67.3600, 3.00256, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (86828, 17407, 530, 1, 0, 0, -3450.8549, 2336.6281, 66.4496, 5.95644, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (86829, 17407, 530, 1, 0, 0, -3613.4646, 2313.7209, 74.5317, 4.04243, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (86830, 17407, 530, 1, 0, 0, -3743.1557, 2268.3186, 76.7126, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (86831, 21960, 530, 1, 0, 0, -2681.83, 2044.9, 117.226, 2.76783, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (86832,	21027, 530,	1, 0,	0, -2705.66, 1301.04, 32.5693, 5.83769, 1560,	0, 0, 7800, 6310, 0, 0);
INSERT INTO `creature` VALUES (86833, 17407, 530, 1, 0, 0, -2940.6833, 2104.9963, 169.7164, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (52280,84007,84008,84009,84012,84629,85483,86066,86067,86068,86069,86070,86071,86072,86083,86084,86086,86087,86088,86097,86872,90871,100042,100043,100044,100045,100046,100062,100073,16800865,16800864);
INSERT INTO `creature` VALUES (52280, 19789, 530, 1, 0, 0, -3048.96, 1598, 59.1358, 2.63839, 300, 0, 0, 5409, 3080, 0, 2);
SET @GUID := 52280;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52280, 1, -3057.21, 1600.07, 57.6605, 0,0,0,100,0);
--
INSERT INTO `waypoint_data` VALUES (52280, 2, -3064.61, 1595.91, 56.8124, 2000,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 3, -3057.61, 1599.7, 57.5376, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 4, -3050.85, 1599.52, 59.1422, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 5, -3023.77, 1598.26, 59.081, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 6, -3015.37, 1597.73, 58.7386, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 7, -3005.35, 1588.81, 58.8596, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 8, -3006.79, 1581.08, 59.5207, 0,0,0,100,0);
--
INSERT INTO `waypoint_data` VALUES (52280, 9, -3011.55, 1576.15, 60.745, 2000,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 10, -3003.55, 1584.7, 59.4872, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 11, -3005.9, 1593.1, 58.9026, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 12, -3021.37, 1598.45, 59.0623, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 13, -3040.07, 1595.73, 58.8217, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (52280, 14, -3050.3, 1597.91, 59.2016, 0,0,0,100,0);
--
INSERT INTO `creature` VALUES (84007, 19762, 530, 1, 0, 0, -3147.14, 1601.01, 53.64, 3.85, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (84008, 19762, 530, 1, 0, 0, -3158.17, 1617.75, 55.43, 4.01, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (84009, 19762, 530, 1, 0, 0, -3027.45, 1579.61, 64.27, 1.65, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (84012, 19762, 530, 1, 0, 0, -2928.87, 1576.1, 36.1739, 0.488692, 300, 0, 0, 6542, 0, 0, 0);
--
INSERT INTO `creature` VALUES (84629, 19784, 530, 1, 0, 0, -2738.83, 1137.51, 3.69936, 2.48028, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (85483, 19784, 530, 1, 0, 0, -3079.14, 1609.92, 55.97, 4.15, 300, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (86066, 19784, 530, 1, 0, 0, -2636.83, 1260.95, 22.3503, 4.99127, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (86067, 19784, 530, 1, 0, 0, -2715.36, 1312.55, 34.2753, 5.14495, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (86068, 19784, 530, 1, 0, 0, -2705.87, 1316.38, 32.5245, 4.79938, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (86069, 19784, 530, 1, 0, 0, -2583.66, 1386.4, 43.4713, 0.381754, 300, 0, 0, 6542, 0, 0, 0);
-- 86070,86071,86072

INSERT INTO `creature` VALUES (86083, 21960, 530, 1, 0, 0, -2770.42, 2462.32, 93.2809, 5.29993, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (86084, 21960, 530, 1, 0, 0, -2762.35, 2467.72, 93.2809, 6.25419, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (86086, 19784, 530, 1, 0, 0, -2586.7, 1393.04, 43.1409, 0.341699, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (86087, 19784, 530, 1, 0, 0, -2697.99, 1227.02, 32.9681, 3.32304, 300, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (86088, 19784, 530, 1, 0, 0, -2700.81, 1218.34, 32.8339, 2.52035, 300, 0, 0, 6542, 0, 0, 0);
--
INSERT INTO `creature` VALUES (86097, 21061, 530, 1, 0, 0, -3747.2487, 1557.3321, 44.9063, 2.32265, 180, 5, 0, 6761, 0, 0, 1);
--
INSERT INTO `creature` VALUES (86872, 20795, 530, 1, 0, 0, -2593.76, 1384.13, 44.286, 0.561506, 300, 0, 0, 6803, 2991, 0, 0);
--
INSERT INTO `creature` VALUES (90871, 21462, 530, 1, 0, 0, -2927.65, 1531.05, 10.2394, 2.93664, 180, 5, 0, 6542, 0, 0, 1);
--
INSERT INTO `creature` VALUES (100042, 19762, 530, 1, 0, 0, -2885.72, 1589.38, 19.9814, 5.58505, 300, 0, 0, 6542, 0, 0, 0); -- 84622
INSERT INTO `creature` VALUES (100043, 19762, 530, 1, 0, 0, -2964.3093, 1629.5489, 56.2737, 5.2283, 300, 0, 0, 6542, 0, 0, 0); -- 84622
INSERT INTO `creature` VALUES (100044, 19784, 530, 1, 0, 0, -2841.49, 1248.57, 6.80746, 2.67519, 300, 5, 0, 6542, 0, 0, 1); -- 84613
INSERT INTO `creature` VALUES (100045, 19784, 530, 1, 0, 0, -2736.01, 1146.11, 3.11515, 3.07334, 300, 0, 0, 6542, 0, 0, 0); -- 84632
INSERT INTO `creature` VALUES (100046, 19784, 530, 1, 0, 0, -3083.91, 1598.23, 55.68, 2.86, 300, 5, 0, 6542, 0, 0, 1); -- 85612
--
INSERT INTO `creature` VALUES (100062, 6491, 1, 1, 0, 0, 7763.65, -4102.77, 697.988, 0.266153, 60, 0, 0, 4120, 0, 0, 0); -- maybe wotlk but np
--
INSERT INTO `creature` VALUES (100073, 6491, 1, 1, 0, 0, 6617.82, -3544.02, 682.132, 0.89447, 60, 0, 0, 4120, 0, 0, 0); -- maybe wotlk but np


DELETE FROM `creature` WHERE `guid` BETWEEN 140000 AND 140806; 
--
-- 140000 AND 150000;
INSERT INTO `creature` VALUES (140000, 21347, 530, 1, 0, 0, -2483.1689, 1216.3806, 42.5085, 3.4536, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140001, 21347, 530, 1, 0, 0, -2518.09, 1180.25, 65.1497, 3.39077, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140002, 21347, 530, 1, 0, 0, -2500.14, 1165.85, 53.6676, 4.87127, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140003, 21347, 530, 1, 0, 0, -2566.39, 1200.25, 77.7982, 6.12882, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140004, 21347, 530, 1, 0, 0, -2566.65, 1165.72, 76.1817, 4.56588, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140005, 21347, 530, 1, 0, 0, -2550.49, 1149.13, 77.7456, 5.42208, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140006, 21347, 530, 1, 0, 0, -2484.61, 1315.87, 58.3943, 0.049953, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140007, 21347, 530, 1, 0, 0, -2466.51, 1332.21, 49.4113, 2.21373, 25, 0, 0, 9250, 0, 0, 0);
INSERT INTO `creature` VALUES (140008, 21347, 530, 1, 0, 0, -2466.7021, 1298.6217, 44.6195, 3.3878, 25, 0, 0, 9250, 0, 0, 0);
-- 140009-140019 free
INSERT INTO `creature` VALUES (140020, 25640, 580, 1, 0, 0, 1704.32, 582.722, 28.2507, 5.0091, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (140021, 25640, 580, 1, 0, 0, 1746.55, 621.946, 28.1335, 2.09439, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (140022, 25640, 580, 1, 0, 0, 1696.01, 675.393, 28.1335, 0.610865, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (140023, 25640, 580, 1, 0, 0, 1652.03, 635.354, 28.2087, 3.75246, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (140024, 26046, 580, 1, 0, 0, 1698.09, 627.29, 58.1771, 1.69297, 604800, 0, 0, 1000, 10000, 0, 0);
-- 140025-140165 free
INSERT INTO `creature` VALUES (140166, 15344, 509, 1, 0, 0, -8991.15, 1554, 21.6539, 2.77507, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140167, 15344, 509, 1, 0, 0, -9003.75, 1536.16, 21.4697, 2.63545, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140168, 15344, 509, 1, 0, 0, -9012.13, 1608.77, 24.8693, 3.14159, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140169, 15344, 509, 1, 0, 0, -9014.36, 1597.68, 21.4697, 3.03687, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140170, 15344, 509, 1, 0, 0, -9020.15, 1586.73, 21.4697, 2.94961, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140171, 15344, 509, 1, 0, 0, -9022.04, 1612.05, 22.8073, 3.15905, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140172, 15344, 509, 1, 0, 0, -9022.71, 1505.88, 21.5596, 2.40855, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140173, 15344, 509, 1, 0, 0, -9029.94, 1498.08, 22.1401, 2.33874, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140174, 15344, 509, 1, 0, 0, -9031.99, 1592.26, 21.4697, 2.98451, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140175, 15344, 509, 1, 0, 0, -9038.44, 1491.04, 23.2296, 2.26893, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140176, 15344, 509, 1, 0, 0, -9070.71, 1634.37, 21.4812, 3.49066, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140177, 15344, 509, 1, 0, 0, -9071.04, 1622.14, 21.4697, 3.33358, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140178, 15344, 509, 1, 0, 0, -9071.76, 1611.28, 21.4721, 3.1765, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140179, 15344, 509, 1, 0, 0, -9076.42, 1530.23, 21.4697, 2.23402, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140180, 15344, 509, 1, 0, 0, -9078.8, 1622.8, 21.4697, 3.36849, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140181, 15344, 509, 1, 0, 0, -9083.14, 1524.76, 21.4697, 2.14675, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140182, 15344, 509, 1, 0, 0, -9091.76, 1519.37, 21.4697, 2.05949, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140183, 15344, 509, 1, 0, 0, -9092.34, 1586.27, 21.4696, 2.68781, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140184, 15344, 509, 1, 0, 0, -9097.29, 1578.36, 21.4696, 2.51327, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140185, 15344, 509, 1, 0, 0, -9102.55, 1569.42, 21.4757, 2.32129, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140186, 15344, 509, 1, 0, 0, -9113.94, 1546.06, 21.4696, 1.95477, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140187, 15344, 509, 1, 0, 0, -9132.83, 1539.1, 21.4696, 1.65806, 604800, 0, 0, 12576, 0, 0, 0);
INSERT INTO `creature` VALUES (140188, 15341, 509, 1, 0, 0, -9129.73, 1602.5, 26.5441, 5.53269, 604800, 0, 0, 416375, 0, 0, 0);
INSERT INTO `creature` VALUES (140189, 15385, 509, 1, 0, 0, -9108.29, 1584.17, 21.471, 5.75959, 604800, 0, 0, 56627, 0, 0, 0);
INSERT INTO `creature` VALUES (140190, 15386, 509, 1, 0, 0, -9085.03, 1622.4, 21.4697, 3.36849, 604800, 0, 0, 56627, 0, 0, 0);
INSERT INTO `creature` VALUES (140191, 15387, 509, 1, 0, 0, -8994.83, 1542.27, 21.6486, 2.70526, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140192, 15387, 509, 1, 0, 0, -8998.05, 1560.15, 22.1308, 2.80998, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140193, 15387, 509, 1, 0, 0, -9001.26, 1549.05, 22.0209, 2.72271, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140194, 15387, 509, 1, 0, 0, -9010.7, 1542.47, 21.4697, 2.6529, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140195, 15387, 509, 1, 0, 0, -9023.85, 1601.58, 21.4697, 3.07178, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140196, 15387, 509, 1, 0, 0, -9030.08, 1512.31, 21.4706, 2.40855, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140197, 15387, 509, 1, 0, 0, -9038.83, 1505.32, 21.5906, 2.33874, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140198, 15387, 509, 1, 0, 0, -9046.5, 1498.26, 22.0108, 2.26893, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140199, 15387, 509, 1, 0, 0, -9066.89, 1521.48, 21.4697, 2.25147, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140200, 15387, 509, 1, 0, 0, -9074, 1515.24, 21.4697, 2.16421, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140201, 15387, 509, 1, 0, 0, -9078.07, 1635.03, 21.4697, 3.54302, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140202, 15387, 509, 1, 0, 0, -9080.05, 1612.09, 21.4697, 3.19395, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140203, 15387, 509, 1, 0, 0, -9082.67, 1510.19, 21.5131, 2.07694, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140204, 15387, 509, 1, 0, 0, -9098.18, 1589.88, 21.47, 2.70526, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140205, 15387, 509, 1, 0, 0, -9102.67, 1581.56, 21.471, 2.49582, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140206, 15387, 509, 1, 0, 0, -9107.89, 1574.31, 21.4863, 2.30383, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140207, 15387, 509, 1, 0, 0, -9117.37, 1553.28, 21.4696, 1.93732, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140208, 15387, 509, 1, 0, 0, -9123.58, 1541.55, 21.4696, 1.79769, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140209, 15387, 509, 1, 0, 0, -9125.76, 1549.29, 21.4696, 1.78024, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140210, 15387, 509, 1, 0, 0, -9134.14, 1546.72, 21.4696, 1.64061, 604800, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140211, 15388, 509, 1, 0, 0, -9127.98, 1558.54, 21.6879, 1.79769, 604800, 0, 0, 56627, 0, 0, 0);
INSERT INTO `creature` VALUES (140212, 15389, 509, 1, 0, 0, -9033.17, 1604.66, 21.4697, 3.08923, 604800, 0, 0, 56627, 0, 0, 0);
INSERT INTO `creature` VALUES (140213, 15390, 509, 1, 0, 0, -9087.01, 1530.26, 21.4697, 2.14675, 604800, 0, 0, 56627, 0, 0, 0);
INSERT INTO `creature` VALUES (140214, 15391, 509, 1, 0, 0, -9007.4, 1556.87, 21.6039, 5.51524, 604800, 0, 0, 56627, 0, 0, 0);
INSERT INTO `creature` VALUES (140215, 15392, 509, 1, 0, 0, -9041.36, 1512.58, 21.4748, 2.33874, 604800, 0, 0, 56627, 0, 0, 0);
INSERT INTO `creature` VALUES (140216, 15426, 509, 1, 0, 0, -8680.66, 1585.61, 33.1911, 2.54818, 120, 0, 0, 5000, 0, 0, 0);
INSERT INTO `creature` VALUES (140217, 15168, 509, 1, 0, 0, -8532.81, 1467.03, 31.9923, 6.23083, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140218, 15168, 509, 1, 0, 0, -8566.46, 1399.42, 31.9903, 3.21141, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140219, 15168, 509, 1, 0, 0, -8600.14, 1466.59, 31.9903, 2.18166, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140220, 15168, 509, 1, 0, 0, -8600.33, 1600.62, 31.9904, 2.02458, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140221, 15168, 509, 1, 0, 0, -8665.98, 1566.63, 31.9904, 2.3911, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140222, 15168, 509, 1, 0, 0, -8666.03, 1432.59, 32.6509, 2.00713, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140223, 15168, 509, 1, 0, 0, -8666.48, 1667.62, 21.5036, 6.23083, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140224, 15168, 509, 1, 0, 0, -8666.83, 1499.21, 32.7247, 5.25344, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140225, 15168, 509, 1, 0, 0, -8733.77, 1600.12, 21.4697, 3.24631, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140226, 15168, 509, 1, 0, 0, -8848.91, 1845.96, 21.4697, 2.05949, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140227, 15168, 509, 1, 0, 0, -8917.9, 1547.61, 21.4697, 0.994838, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140228, 15168, 509, 1, 0, 0, -9000.71, 1700.1, 21.5722, 4.43314, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140229, 15168, 509, 1, 0, 0, -9066.02, 1733.49, 21.5309, 3.24631, 687, 0, 0, 5228, 0, 0, 0);
INSERT INTO `creature` VALUES (140230, 15320, 509, 1, 0, 0, -9193.53, 1459.78, 21.5113, 4.20948, 3520, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140231, 15320, 509, 1, 0, 0, -9224.24, 1384.02, 21.4697, 3.19395, 3520, 0, 0, 31440, 0, 0, 0);
INSERT INTO `creature` VALUES (140232, 15323, 509, 1, 0, 0, -9187.02, 1463.77, 21.4697, 1.18682, 3520, 0, 0, 15720, 0, 0, 0);
INSERT INTO `creature` VALUES (140233, 15323, 509, 1, 0, 0, -9189.15, 1452.48, 21.5292, 2.05949, 3520, 0, 0, 15720, 0, 0, 0);
INSERT INTO `creature` VALUES (140234, 15323, 509, 1, 0, 0, -9227.63, 1391.41, 21.4067, 4.16572, 3520, 0, 0, 15720, 0, 0, 0);
INSERT INTO `creature` VALUES (140235, 15324, 509, 1, 0, 0, -8517.44, 1505.66, 33.3647, 0.837758, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140236, 15324, 509, 1, 0, 0, -8531.85, 1515.69, 33.2644, 0.767945, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140237, 15324, 509, 1, 0, 0, -8693.79, 1565.82, 31.9903, 5.35816, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140238, 15324, 509, 1, 0, 0, -8706.15, 1552.28, 31.9903, 5.41052, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140239, 15324, 509, 1, 0, 0, -9053.82, 1664.36, 22.9385, 3.9968, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140240, 15324, 509, 1, 0, 0, -9067.32, 1673.46, 23.0715, 4.31096, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140241, 15324, 509, 1, 0, 0, -9148.94, 1510.32, 21.9923, 0.942478, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140242, 15324, 509, 1, 0, 0, -9162.49, 1518.8, 22.7809, 0.226893, 450, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140243, 15325, 509, 1, 0, 0, -8542.54, 1478.01, 31.9904, 4.06662, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140244, 15325, 509, 1, 0, 0, -8545.16, 1437.03, 31.9903, 4.4855, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140245, 15325, 509, 1, 0, 0, -8547.5, 1476.41, 31.9904, 1.76278, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140246, 15325, 509, 1, 0, 0, -8551.96, 1439.4, 31.9903, 0.436332, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140247, 15325, 509, 1, 0, 0, -8582.97, 1599.11, 32.032, 4.68351, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140248, 15325, 509, 1, 0, 0, -8592.64, 1388.11, 32.4094, 1.52794, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140249, 15325, 509, 1, 0, 0, -8592.86, 1599.39, 32.032, 4.68349, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140250, 15325, 509, 1, 0, 0, -8602.44, 1388.5, 32.032, 1.54599, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140251, 15325, 509, 1, 0, 0, -8616.94, 1514.72, 32.1834, 0.506145, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140252, 15325, 509, 1, 0, 0, -8619.92, 1517.5, 32.1943, 4.27606, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140253, 15325, 509, 1, 0, 0, -8652.17, 1472.9, 32.0061, 0.706683, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140254, 15325, 509, 1, 0, 0, -8665.91, 1446.74, 32.0319, 0.97636, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140255, 15325, 509, 1, 0, 0, -8686.13, 1631.23, 21.4589, 0.773305, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140256, 15325, 509, 1, 0, 0, -8718.21, 1592.04, 21.5113, 1.21382, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140257, 15325, 509, 1, 0, 0, -8746.42, 1583.25, 21.5113, 1.26603, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140258, 15325, 509, 1, 0, 0, -8764.29, 1584.63, 21.9326, 5.24075, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140259, 15325, 509, 1, 0, 0, -8767.65, 1610.11, 21.6572, 1.4321, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140260, 15325, 509, 1, 0, 0, -8773.97, 1616.39, 21.4558, 1.98608, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140261, 15325, 509, 1, 0, 0, -8803.79, 1659.91, 21.4307, 5.53989, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140262, 15325, 509, 1, 0, 0, -8809.88, 1652.23, 20.8364, 5.54377, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140263, 15327, 509, 1, 0, 0, -8544.8, 1474.66, 31.9903, 1.51844, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140264, 15327, 509, 1, 0, 0, -8549.29, 1437.01, 31.9903, 3.33358, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140265, 15327, 509, 1, 0, 0, -8587.77, 1604.2, 31.9538, 1.54177, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140266, 15327, 509, 1, 0, 0, -8597.94, 1369.12, 32.032, 0.56862, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140267, 15327, 509, 1, 0, 0, -8619.19, 1514.31, 32.138, 1.71042, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140268, 15327, 509, 1, 0, 0, -8667.24, 1453.61, 32.0313, 0.976377, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140269, 15327, 509, 1, 0, 0, -8704.98, 1614.31, 21.5215, 0.449098, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140270, 15327, 509, 1, 0, 0, -8767.04, 1578.57, 24.7869, 5.62536, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140271, 15327, 509, 1, 0, 0, -8789.38, 1598.04, 21.4998, 0.0595344, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140272, 15327, 509, 1, 0, 0, -8790.47, 1615.46, 21.4558, 4.86202, 3520, 0, 0, 50304, 0, 0, 0);
INSERT INTO `creature` VALUES (140273, 15338, 509, 1, 0, 0, -8790.35, 1982.15, 21.5098, 1.51484, 4224, 0, 0, 50300, 12430, 0, 0);
INSERT INTO `creature` VALUES (140274, 15338, 509, 1, 0, 0, -8857.88, 1833.75, 21.5113, 0.935567, 4224, 0, 0, 50300, 12430, 0, 0);
INSERT INTO `creature` VALUES (140275, 15338, 509, 1, 0, 0, -8861.8, 2021.68, 21.7937, 3.10614, 4224, 0, 0, 50300, 12430, 0, 0);
INSERT INTO `creature` VALUES (140276, 15338, 509, 1, 0, 0, -8920.27, 1911.37, 21.7709, 2.56745, 4224, 0, 0, 50300, 12430, 0, 0);
INSERT INTO `creature` VALUES (140277, 15338, 509, 1, 0, 0, -9003.38, 1700.75, 21.734, 5.49558, 4224, 0, 0, 50300, 12430, 0, 0);
INSERT INTO `creature` VALUES (140278, 15338, 509, 1, 0, 0, -9040.84, 1707.05, 21.5026, 5.58163, 4224, 0, 0, 50300, 12430, 0, 0);
INSERT INTO `creature` VALUES (140279, 15338, 509, 1, 0, 0, -9044.09, 1839.8, 21.5113, 4.0525, 4224, 0, 0, 50300, 12430, 0, 0);
INSERT INTO `creature` VALUES (140280, 15343, 509, 1, 0, 0, -8600.62, 1483.55, 32.8614, 3.00197, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140281, 15343, 509, 1, 0, 0, -8612.69, 1446.04, 31.9903, 3.01942, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140282, 15343, 509, 1, 0, 0, -8620.62, 1484.9, 31.9009, 6.05629, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140283, 15343, 509, 1, 0, 0, -8622.46, 1385.47, 32.032, 5.9549, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140284, 15343, 509, 1, 0, 0, -8622.62, 1437.46, 33.157, 0.0412672, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140285, 15343, 509, 1, 0, 0, -8652.9, 1459.57, 32.0319, 5.51512, 3520, 0, 0, 25152, 0, 0, 0);
INSERT INTO `creature` VALUES (140286, 21960, 530, 1, 0, 0, -2787.73, 2357.25, 93.28, 0.47021, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140287, 21960, 530, 1, 0, 0, -2789.01, 2351.89, 93.2023, 5.78814, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140288, 21960, 530, 1, 0, 0, -2748.12, 2338.67, 92.4345, 2.10462, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140289, 21960, 530, 1, 0, 0, -2758.44, 2295.85, 93.2808, 5.62791, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140290, 21960, 530, 1, 0, 0, -2772.49, 2283.24, 93.2811, 5.20679, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140291, 21960, 530, 1, 0, 0, -2762.13, 2320.37, 93.2807, 3.69882, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140292, 21960, 530, 1, 0, 0, -2797.64, 2257.09, 93.2808, 3.29334, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140293, 21960, 530, 1, 0, 0, -2780.73, 2233.34, 92.3539, 5.76361, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140294, 21960, 530, 1, 0, 0, -2798.54, 2212.54, 93.2808, 3.96898, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140295, 21960, 530, 1, 0, 0, -2758.31, 2220.11, 93.2212, 6.20736, 120, 10, 0, 6326, 0, 0, 1);
-- Abweichung da vorhanden
-- INSERT INTO `creature` VALUES (140296, 19633, 553, 3, 0, 0, 6.15941, 166.406, -5.54122, 1.51584, 7200, 3, 0, 14199, 21093, 0, 1);
-- INSERT INTO `creature` VALUES (140297, 18404, 553, 3, 0, 0, 149.565, 281.787, -4.65385, 1.01615, 7200, 0, 0, 20958, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140298, 17993, 553, 3, 0, 0, 151.661, 281.789, -4.33474, 1.61228, 7200, 0, 0, 16208, 3080, 0, 0);
-- INSERT INTO `creature` VALUES (140299, 17993, 553, 3, 0, 0, 153.757, 281.744, -4.00861, 2.17694, 7200, 0, 0, 16208, 3080, 0, 0);
-- INSERT INTO `creature` VALUES (140300, 17993, 553, 3, 0, 0, 165.165, 295.535, -4.37166, 3.11024, 7200, 0, 0, 16208, 3080, 0, 0);
-- INSERT INTO `creature` VALUES (140301, 18404, 553, 3, 0, 0, 165.194, 298.208, -4.77445, 3.85272, 7200, 0, 0, 20958, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140302, 17993, 553, 3, 0, 0, 164.969, 292.953, -4.00805, 2.37327, 7200, 0, 0, 16208, 3080, 0, 0);
-- INSERT INTO `creature` VALUES (140303, 17993, 553, 3, 0, 0, 161.403, 285.599, -3.09818, 1.74291, 7200, 0, 0, 16208, 3080, 0, 0);
-- INSERT INTO `creature` VALUES (140304, 18404, 553, 3, 0, 0, 159.136, 283.813, -3.27211, 1.29749, 7200, 0, 0, 20958, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140305, 17993, 553, 3, 0, 0, 163.108, 287.899, -3.3132, 2.55293, 7200, 0, 0, 16208, 3080, 0, 0);
-- INSERT INTO `creature` VALUES (140306, 18421, 553, 3, 17843, 0, 175.843, 387.166, -5.30306, 2.23402, 7200, 0, 0, 16208, 9465, 0, 0);
-- INSERT INTO `creature` VALUES (140307, 19508, 553, 3, 21338, 0, -16.2609, 482.706, -5.38576, 3.94444, 7200, 0, 0, 20259, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140308, 19508, 553, 3, 21339, 0, -17.3213, 485.099, -5.36875, 2.96706, 7200, 0, 0, 20259, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140309, 19509, 553, 3, 21333, 0, -15.0387, 479.981, -5.40512, 1.39626, 7200, 0, 0, 16208, 3155, 0, 0);
-- INSERT INTO `creature` VALUES (140310, 19555, 553, 3, 11686, 0, -18.0924, 509.914, 1.61268, 3.52556, 7200, 0, 0, 6986, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140311, 19555, 553, 3, 11686, 0, -1.83877, 510.545, 0.624383, 2.58309, 7200, 0, 0, 6986, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140312, 19512, 553, 3, 0, 0, -18.8205, 518.483, -6.07107, 6.05097, 7200, 0, 0, 20958, 0, 0, 2);
-- INSERT INTO `creature` VALUES (140313, 19511, 553, 3, 0, 0, -19.6808, 514.978, -5.89398, 5.61429, 7200, 0, 0, 20958, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140314, 19555, 553, 3, 11686, 0, -9.87732, 599.763, -8.5421, 6.03884, 7200, 0, 0, 6986, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140315, 19555, 553, 3, 11686, 0, 20.0907, 599.71, -8.29904, 3.14159, 7200, 0, 0, 6986, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140316, 19507, 553, 3, 21337, 0, -157.634, 411.701, -17.6124, 1.27409, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140317, 19507, 553, 3, 21335, 0, -177.217, 408.964, -17.6069, 2.07694, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140318, 19507, 553, 3, 21336, 0, -150.54, 400.302, -17.7579, 2.75762, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140319, 19507, 553, 3, 21335, 0, -172.605, 403.925, -17.6111, 4.74729, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140320, 19507, 553, 3, 21335, 0, -173.274, 390.129, -17.6073, 3.50811, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140321, 19507, 553, 3, 21336, 0, -177.095, 378.248, -17.6081, 5.18363, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140322, 19507, 553, 3, 21336, 0, -172.32, 380.316, -17.6107, 0.890118, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140323, 19507, 553, 3, 21337, 0, -166.857, 398.471, -17.6142, 4.2237, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140324, 19507, 553, 3, 21337, 0, -154.356, 386.376, -17.7216, 4.43314, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140325, 19507, 553, 3, 21337, 0, -179.922, 401.107, -17.6042, 0.488692, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140326, 19507, 553, 3, 21336, 0, -164.275, 375.683, -17.6168, 2.75762, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140327, 19507, 553, 3, 21336, 0, -152.4, 372.664, -17.6055, 0.331613, 7200, 0, 0, 14181, 7196, 1, 0);
-- INSERT INTO `creature` VALUES (140328, 17993, 553, 3, 0, 0, -155.507, 389.66, -17.7781, 2.1041, 7200, 0, 0, 16208, 3080, 0, 2);
-- INSERT INTO `creature` VALUES (140329, 17993, 553, 3, 0, 0, -160.717, 374.429, -17.6977, 2.19363, 7200, 0, 0, 16208, 3155, 0, 2);
-- INSERT INTO `creature` VALUES (140330, 21304, 552, 3, 0, 0, 257.344, 155.568, 22.3321, 4.71239, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140331, 21303, 552, 3, 0, 0, 257.344, 155.568, 22.3321, 4.71239, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140332, 21304, 552, 3, 0, 0, 392.004, 18.3857, 48.296, 1.48353, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140333, 21303, 552, 3, 0, 0, 392.004, 18.3857, 48.296, 1.48353, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140334, 21304, 552, 3, 0, 0, 397.07, 25.3331, 48.296, 0.523599, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140335, 21303, 552, 3, 0, 0, 397.07, 25.3331, 48.296, 0.523599, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140336, 21304, 552, 3, 0, 0, 291.632, 70.5809, 22.5269, 2.00713, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140337, 21303, 552, 3, 0, 0, 291.632, 70.5809, 22.5269, 2.00713, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140338, 21304, 552, 3, 0, 0, 293.885, 70.9368, 22.5262, 1.55334, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140339, 21303, 552, 3, 0, 0, 293.885, 70.9368, 22.5262, 1.55334, 7200, 0, 0, 20283, 0, 0, 0);
-- INSERT INTO `creature` VALUES (140340, 21304, 552, 3, 0, 0, 311.119, -5.50369, 22.5245, 1.5708, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140341, 21303, 552, 3, 0, 0, 311.119, -5.50369, 22.5245, 1.5708, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140342, 21304, 552, 3, 0, 0, 312.929, -7.19062, 22.5245, 4.03171, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140343, 21303, 552, 3, 0, 0, 312.929, -7.19062, 22.5245, 4.03171, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140344, 21304, 552, 3, 0, 0, 262.56, -65.5981, 22.4534, 1.50098, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140345, 21303, 552, 3, 0, 0, 262.56, -65.5981, 22.4534, 1.50098, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140346, 21304, 552, 3, 0, 0, 232.754, -198.125, -10.023, 5.61996, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140347, 21303, 552, 3, 0, 0, 232.754, -198.125, -10.023, 5.61996, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140348, 21304, 552, 3, 0, 0, 272.501, -40.1927, 22.509, 2.9147, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140349, 21303, 552, 3, 0, 0, 272.501, -40.1927, 22.509, 2.9147, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140350, 21304, 552, 3, 0, 0, 306.976, 141.112, 22.2286, 3.0285, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140351, 21303, 552, 3, 0, 0, 306.976, 141.112, 22.2286, 3.0285, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140352, 21304, 552, 3, 0, 0, 298.848, 151.748, 22.3105, 5.70723, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140353, 21303, 552, 3, 0, 0, 298.848, 151.748, 22.3105, 5.70723, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140354, 21304, 552, 3, 0, 0, 253.951, 155.001, 22.3806, 4.93928, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140355, 21303, 552, 3, 0, 0, 253.951, 155.001, 22.3806, 4.93928, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140356, 21304, 552, 3, 0, 0, 253.689, 139.868, 22.4121, 2.30383, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140357, 21303, 552, 3, 0, 0, 253.689, 139.868, 22.4121, 2.30383, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140358, 21304, 552, 3, 0, 0, 285.416, 127.127, 22.2951, 4.69494, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140359, 21303, 552, 3, 0, 0, 285.416, 127.127, 22.2951, 4.69494, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140360, 21304, 552, 3, 0, 0, 245.982, -194.617, -10.0217, 0.872665, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140361, 21303, 552, 3, 0, 0, 245.982, -194.617, -10.0217, 0.872665, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140362, 21304, 552, 3, 0, 0, 226.184, -162.096, -10.0352, 0.349066, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140363, 21303, 552, 3, 0, 0, 226.184, -162.096, -10.0352, 0.349066, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140364, 21304, 552, 3, 0, 0, 270.819, -45.4794, 22.4534, 4.46804, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140365, 21303, 552, 3, 0, 0, 270.819, -45.4794, 22.4534, 4.46804, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140366, 21304, 552, 3, 0, 0, 273.438, -64.07, 22.4534, 22.4534, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140367, 21303, 552, 3, 0, 0, 273.438, -64.07, 22.4534, 22.4534, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140368, 21304, 552, 3, 0, 0, 213.626, -161.424, -10.0346, 2.74017, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140369, 21303, 552, 3, 0, 0, 213.626, -161.424, -10.0346, 2.74017, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140370, 21304, 552, 3, 0, 0, 206.342, -98.2784, -10.0262, 2.6529, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140371, 21303, 552, 3, 0, 0, 206.342, -98.2784, -10.0262, 2.6529, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140372, 21304, 552, 3, 0, 0, 197.795, -86.5381, -10.1018, 5.90384, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140373, 21303, 552, 3, 0, 0, 197.795, -86.5381, -10.1018, 5.90384, 7200, 0, 0, 20283, 0, 0, 0);
#INSERT INTO `creature` VALUES (140374, 20864, 552, 3, 0, 0, 208.859, 6.44106, -7.46839, 4.26597, 25, 0, 0, 47138, 0, 0, 2);
#INSERT INTO `creature` VALUES (140375, 20865, 552, 3, 0, 0, 212.562, 6.48385, -7.46839, 3.46093, 25, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140376, 20865, 552, 3, 0, 0, 209.099, 10.6454, -7.4684, 4.9173, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140377, 20865, 552, 3, 0, 0, 208.434, -21.0154, -10.0878, 0.166969, 7200, 0, 0, 7868, 0, 0, 2);
#INSERT INTO `creature` VALUES (140378, 20865, 552, 3, 0, 0, 206.383, -20.1627, -10.0984, 0.611504, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140379, 20865, 552, 3, 0, 0, 207.515, -23.0306, -10.0875, 0.361747, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140380, 20865, 552, 3, 0, 0, 205.901, -21.77, -10.0973, 0.187389, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140381, 20865, 552, 3, 0, 0, 204.041, -20.9714, -10.1009, 0.0931411, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140382, 20865, 552, 3, 0, 0, 205.502, -23.8515, -10.0948, 1.00813, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140383, 20864, 552, 3, 0, 0, 202.329, -40.5555, -10.0961, 4.59888, 7200, 0, 0, 47138, 0, 0, 2);
#INSERT INTO `creature` VALUES (140384, 20865, 552, 3, 0, 0, 201.214, -36.4609, -10.0973, 3.43722, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140385, 20865, 552, 3, 0, 0, 205.26, -45.3562, -10.1119, 3.64711, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140386, 20868, 552, 3, 0, 0, 254.91, -125.087, -10.1232, 2.89044, 7200, 10, 0, 39123, 0, 0, 1);
#INSERT INTO `creature` VALUES (140387, 20868, 552, 3, 0, 0, 266.335, -187.128, -10.1051, 4.02795, 7200, 10, 0, 45409, 0, 0, 1);
#INSERT INTO `creature` VALUES (140388, 20867, 552, 3, 0, 0, 266.335, -187.128, -10.1051, 4.02795, 7200, 10, 0, 45409, 0, 0, 1);
#INSERT INTO `creature` VALUES (140389, 20867, 552, 3, 0, 0, 215.332, -140.698, -10.1109, 5.29231, 7200, 10, 0, 45409, 0, 0, 1);
#INSERT INTO `creature` VALUES (140390, 20868, 552, 3, 0, 0, 244.258, -156.479, -10.104, 4.38315, 7200, 10, 0, 45409, 0, 0, 1);
#INSERT INTO `creature` VALUES (140391, 20867, 552, 3, 0, 0, 244.258, -156.479, -10.104, 4.38315, 7200, 10, 0, 45409, 0, 0, 1);
#INSERT INTO `creature` VALUES (140392, 20866, 552, 3, 0, 0, 220.769, -128.934, -10.1098, 0.0107276, 7200, 0, 0, 45409, 0, 0, 2);
#INSERT INTO `creature` VALUES (140393, 20866, 552, 3, 0, 0, 219.579, -152.526, -10.1123, 6.26082, 7200, 0, 0, 45409, 0, 0, 2);
#INSERT INTO `creature` VALUES (140394, 20865, 552, 3, 0, 0, 213.449, -120.089, -10.1083, 2.4144, 7200, 0, 0, 7868, 0, 0, 2);
#INSERT INTO `creature` VALUES (140395, 20865, 552, 3, 0, 0, 216.056, -119.667, -10.1204, 3.17144, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140396, 20865, 552, 3, 0, 0, 217.345, -121.596, -10.1199, 2.99551, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140397, 20865, 552, 3, 0, 0, 217.556, -118.237, -10.1212, 3.08662, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140398, 20865, 552, 3, 0, 0, 215.016, -121.252, -10.1204, 3.3945, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140399, 20865, 552, 3, 0, 0, 214.844, -118.252, -10.1188, 2.43393, 7200, 0, 0, 7868, 0, 0, 0);
#INSERT INTO `creature` VALUES (140400, 20869, 552, 1, 0, 0, 264.286, -61.3211, 22.4534, 5.28835, 7200, 0, 0, 46108, 0, 0, 0);
#INSERT INTO `creature` VALUES (140401, 20879, 552, 3, 0, 0, 285.519, 146.155, 22.3118, 5.79449, 7200, 0, 0, 39123, 12620, 0, 0);
#INSERT INTO `creature` VALUES (140402, 20869, 552, 1, 0, 0, 253.743, 131.448, 22.3164, 1.05009, 7200, 0, 0, 46108, 0, 0, 0);
#INSERT INTO `creature` VALUES (140403, 20869, 552, 1, 0, 0, 254.359, 160.747, 22.2955, 5.44126, 7200, 0, 0, 46108, 0, 0, 0);
#INSERT INTO `creature` VALUES (140404, 20879, 552, 3, 0, 0, 305.191, 148.248, 24.7556, 4.09202, 7200, 0, 0, 39123, 12620, 0, 0);
#INSERT INTO `creature` VALUES (140405, 20869, 552, 1, 0, 0, 336.514, 27.4267, 48.426, 3.83972, 7200, 0, 0, 46108, 0, 0, 0);
#INSERT INTO `creature` VALUES (140406, 20869, 552, 1, 0, 0, 395.413, 18.1948, 48.296, 2.49582, 7200, 0, 0, 46108, 0, 0, 0);
#INSERT INTO `creature` VALUES (140407, 20869, 552, 2, 0, 0, 203.401, 126.201, 22.5118, 1.52555, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140408, 20869, 552, 2, 0, 0, 195.709, 126.549, 22.4416, 1.52555, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140409, 20869, 552, 2, 0, 0, 202.84, 46.4277, 48.3155, 2.42562, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140410, 20869, 552, 2, 0, 0, 196.555, 47.0605, 48.3239, 1.20301, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140411, 20869, 552, 2, 0, 0, 264.286, -61.3211, 22.4534, 5.28835, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140412, 20869, 552, 2, 0, 0, 253.743, 131.448, 22.3164, 1.05009, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140413, 20869, 552, 2, 0, 0, 254.359, 160.747, 22.2955, 5.44126, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140414, 20869, 552, 2, 0, 0, 336.514, 27.4267, 48.426, 3.83972, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140415, 20869, 552, 2, 0, 0, 395.413, 18.1948, 48.296, 2.49582, 7200, 0, 0, 64907, 0, 0, 0);
#INSERT INTO `creature` VALUES (140416, 20883, 552, 3, 0, 0, 148.05, 146.994, 20.8982, 6.26573, 7200, 0, 0, 38553, 12620, 0, 0);
#INSERT INTO `creature` VALUES (140417, 20881, 552, 3, 0, 0, 148.05, 146.994, 20.8982, 6.26573, 7200, 0, 0, 48902, 0, 0, 0);
--
INSERT INTO `creature` VALUES (140418, 21736, 530, 1, 0, 0, -3783.53, 2082.99, 87.0361, 2.78886, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140419, 21736, 530, 1, 0, 0, -3787.41, 2080.85, 87.8479, 2.78886, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140420, 21736, 530, 1, 0, 0, -3782.78, 2052.59, 90.6403, 4.01681, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140421, 21736, 530, 1, 0, 0, -3784.83, 2049.61, 90.9455, 1.30875, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140422, 21736, 530, 1, 0, 0, -3782.35, 2048.84, 90.508, 2.22924, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140423, 21736, 530, 1, 0, 0, -3845.64, 2016.54, 95.109, 2.22924, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140424, 21736, 530, 1, 0, 0, -3844.12, 2020.87, 95.0602, 4.32853, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140425, 21736, 530, 1, 0, 0, -3880.85, 2007.17, 95.2154, 1.99197, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140426, 21736, 530, 1, 0, 0, -3887.31, 2009.2, 95.5845, 0.605745, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140427, 21736, 530, 1, 0, 0, -3785.08, 1915.11, 97.2271, 2.32499, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140428, 21736, 530, 1, 0, 0, -3782.4, 1916.44, 97.6024, 2.96274, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140429, 21736, 530, 1, 0, 0, -3785.57, 1919.08, 96.2228, 5.04798, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140430, 21736, 530, 1, 0, 0, -3716.56, 1983.13, 84.4894, 4.03324, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140431, 21736, 530, 1, 0, 0, -3718.37, 1979.32, 85.0302, 2.82923, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140432, 21736, 530, 1, 0, 0, -3715.64, 1986.16, 84.5007, 3.64211, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140433, 21736, 530, 1, 0, 0, -3684.72, 2080.2, 79.29, 3.09626, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140434, 21736, 530, 1, 0, 0, -3682.77, 2080.1, 79.3648, 3.09626, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140435, 21736, 530, 1, 0, 0, -3684.58, 2084.2, 79.0349, 3.09626, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140436, 21736, 530, 1, 0, 0, -3684.83, 2151.28, 77.4513, 5.38962, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140437, 21736, 530, 1, 0, 0, -3681.64, 2150.36, 77.0633, 3.38843, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140438, 21736, 530, 1, 0, 0, -3685.41, 2155.24, 77.3063, 3.56122, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140439, 21736, 530, 1, 0, 0, -3650.81, 2117.13, 73.8919, 3.56122, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140440, 21736, 530, 1, 0, 0, -3684.93, 2117.38, 77.2597, 4.22488, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140441, 21736, 530, 1, 0, 0, -3652.89, 2115.46, 73.7934, 5.57655, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140442, 21736, 530, 1, 0, 0, -3654.44, 2119.74, 74.3457, 5.57655, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140443, 21736, 530, 1, 0, 0, -3683.69, 2114.37, 76.9549, 1.99906, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140444, 21736, 530, 1, 0, 0, -3685.2, 2181.82, 76.4848, 1.99906, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140445, 21736, 530, 1, 0, 0, -3682.8, 2184.63, 76.1265, 3.87223, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140446, 21736, 530, 1, 0, 0, -3750.91, 1987.59, 87.9522, 4.08236, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140447, 21736, 530, 1, 0, 0, -3748.92, 1985.24, 88.1233, 3.98969, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140448, 21736, 530, 1, 0, 0, -3752.48, 1981.12, 89.2402, 1.37038, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140449, 21736, 530, 1, 0, 0, -3784.75, 1950.28, 92.4757, 4.68476, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140450, 21736, 530, 1, 0, 0, -3785.54, 1944.53, 93.8077, 1.26435, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140451, 21736, 530, 1, 0, 0, -3781.35, 1945.67, 94.3879, 2.65058, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140452, 21736, 530, 1, 0, 0, -3754.95, 1948.17, 95.5037, 4.29286, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140453, 21736, 530, 1, 0, 0, -3753.28, 1943.44, 96.6293, 2.54064, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140454, 21736, 530, 1, 0, 0, -3757.52, 1941.97, 96.4033, 1.11592, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140455, 21736, 530, 1, 0, 0, -3717.05, 2077.63, 80.1896, 0.610904, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140456, 21736, 530, 1, 0, 0, -3717.79, 2080.88, 79.7053, 6.01994, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140457, 21736, 530, 1, 0, 0, -3713.21, 2081.54, 79.7971, 3.69124, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (140458, 21417, 530, 1, 0, 0, -3783.13, 1918.5, 118.92, 2.33643, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140459, 21417, 530, 1, 0, 0, -3716.39, 1983.24, 103.94, 2.33643, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140460, 21417, 530, 1, 0, 0, -3683.92, 2083.78, 100.328, 2.33643, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140461, 21417, 530, 1, 0, 0, -3716.86, 2184.77, 100.334, 2.33643, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140462, 21417, 530, 1, 0, 0, -3683.69, 2149.84, 100.588, 2.33643, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140463, 21417, 530, 1, 0, 0, -3717.34, 2150.09, 102.483, 2.33643, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140464, 21417, 530, 1, 0, 0, -3684.21, 2116.27, 98.7243, 2.33643, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140465, 21417, 530, 1, 0, 0, -3650.55, 2117.25, 96.151, 5.35627, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140466, 21417, 530, 1, 0, 0, -3684.18, 2183.21, 98.8751, 5.35627, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140467, 21417, 530, 1, 0, 0, -3750.97, 1984.75, 106.213, 3.15322, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140468, 21417, 530, 1, 0, 0, -3783.72, 1943.93, 115.348, 1.56675, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140469, 21417, 530, 1, 0, 0, -3758.73, 1944.65, 115.495, 6.16526, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140470, 21417, 530, 1, 0, 0, -3716.97, 2117.05, 102.136, 2.5568, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140471, 21417, 530, 1, 0, 0, -3717.81, 2081.91, 104.409, 1.53891, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140472, 21417, 530, 1, 0, 0, -3782.23, 2284.06, 106.409, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140473, 21417, 530, 1, 0, 0, -3815.91, 2283.84, 114.505, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140474, 21417, 530, 1, 0, 0, -3784.33, 2250.31, 108.411, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140475, 21417, 530, 1, 0, 0, -3782.92, 2216.47, 106.744, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140476, 21417, 530, 1, 0, 0, -3816.28, 2217.19, 111.539, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140477, 21417, 530, 1, 0, 0, -3848.53, 2249.43, 117.77, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140478, 21417, 530, 1, 0, 0, -3848.73, 2218.54, 115.873, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140479, 21417, 530, 1, 0, 0, -3783.97, 2183.78, 100.273, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140480, 21417, 530, 1, 0, 0, -3816.52, 2183.86, 111.585, 1.76275, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140481, 21417, 530, 1, 0, 0, -3847.75, 2182.98, 118.241, 3.15684, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140482, 21417, 530, 1, 0, 0, -3782.36, 2150.69, 96.6612, 3.15684, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140483, 21417, 530, 1, 0, 0, -3782.97, 2082.78, 107.031, 1.53891, 300, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140484, 21417, 530, 1, 0, 0, -3782.79, 2048.17, 109.419, 1.53891, 300, 0, 0, 41, 60, 0, 0);
-- abweichung
#INSERT INTO `creature` VALUES (140485, 18970, 530, 1, 0, 0, -232.374, 1083.71, 48.3245, 1.55738, 10, 0, 0, 13084, 0, 0, 0);
#INSERT INTO `creature` VALUES (140486, 18948, 530, 1, 0, 0, -252.769, 1093.94, 41.668, 1.5708, 10, 0, 0, 13084, 0, 0, 0);
#INSERT INTO `creature` VALUES (140487, 18948, 530, 1, 0, 0, -272.204, 1097.1, 41.9803, 1.5708, 10, 0, 0, 12652, 0, 0, 0);
--
INSERT INTO `creature` VALUES (140488, 22986, 530, 1, 0, 0, -3709.53, 3744.06, 277.073, 1.62054, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140489, 22986, 530, 1, 0, 0, -3758.84, 3732.39, 276.846, 5.73288, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140490, 22986, 530, 1, 0, 0, -3687.76, 3677.07, 275.927, 5.73288, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140491, 22986, 530, 1, 0, 0, -3591.33, 3724.59, 285.996, 5.73288, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140492, 22986, 530, 1, 0, 0, -3615.09, 3667.87, 277.788, 1.00477, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140493, 22986, 530, 1, 0, 0, -3642.5, 3189.22, 314.596, 1.50114, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140494, 22986, 530, 1, 0, 0, -3967.37, 3323.17, 289.012, 1.50114, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140495, 22986, 530, 1, 0, 0, -3523.61, 3591.08, 279.754, 0.483256, 320, 0, 0, 41, 60, 0, 0);
INSERT INTO `creature` VALUES (140496, 21901, 530, 1, 0, 0, -4381.74, 353.922, 46.5179, 3.39443, 300, 10, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140497, 21901, 530, 1, 0, 0, -4335.86, 446.14, 115.147, 0.609704, 300, 5, 0, 5409, 1540, 0, 1);
INSERT INTO `creature` VALUES (140498, 21901, 530, 1, 0, 0, -4425.07, 458.863, 117.462, 2.46324, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140499, 21901, 530, 1, 0, 0, -4392.56, 285.814, 56.2566, 2.94234, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140500, 21901, 530, 1, 0, 0, -4449.86, 223.316, 92.4057, 2.44754, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140501, 21901, 530, 1, 0, 0, -4428.07, 367.712, 89.9368, 1.46972, 300, 5, 0, 5409, 1540, 0, 1);
INSERT INTO `creature` VALUES (140502, 21901, 530, 1, 0, 0, -4541.94, 533.606, 85.2636, 0.578294, 300, 5, 0, 5409, 1540, 0, 1);
INSERT INTO `creature` VALUES (140503, 21901, 530, 1, 0, 0, -4484.97, 578.795, 131.17, 5.97791, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140504, 21901, 530, 1, 0, 0, -4471.63, 669.445, 150.031, 2.05509, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140505, 21901, 530, 1, 0, 0, -4330.74, 690.942, 109.125, 5.00074, 300, 5, 0, 5409, 1540, 0, 1);
INSERT INTO `creature` VALUES (140506, 21901, 530, 1, 0, 0, -4349.36, 527.022, 114.887, 3.98364, 300, 5, 0, 5409, 1540, 0, 1);
INSERT INTO `creature` VALUES (140507, 21901, 530, 1, 0, 0, -4318, 198.217, 46.5048, 0.166587, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140508, 21901, 530, 1, 0, 0, -4313.67, 134.258, -0.560779, 5.3345, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140509, 21901, 530, 1, 0, 0, -4275.4, 82.4957, 6.44667, 0.0644793, 300, 5, 0, 5409, 1540, 0, 1);
INSERT INTO `creature` VALUES (140510, 21901, 530, 1, 0, 0, -4230.75, 154.809, 57.7332, 0.441463, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140511, 21901, 530, 1, 0, 0, -4376.36, 222.844, 22.2332, 5.18134, 300, 5, 0, 5589, 1578, 0, 1);
INSERT INTO `creature` VALUES (140512, 21901, 530, 1, 0, 0, -4544.11, 633.432, 56.2809, 0.0683952, 300, 5, 0, 5409, 1540, 0, 1);
INSERT INTO `creature` VALUES (140513, 23286, 530, 1, 0, 0, -5089.01, 344.069, 4.01021, 5.5254, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140514, 23286, 530, 1, 0, 0, -5028.71, 397.794, -12.9515, 5.43508, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140515, 23286, 530, 1, 0, 0, -5046.71, 400.054, -12.3586, 1.27325, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140516, 23286, 530, 1, 0, 0, -5049.42, 445.07, -12.0961, 3.54383, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140517, 23286, 530, 1, 0, 0, -5076.71, 424.111, -12.3675, 2.95635, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140518, 23286, 530, 1, 0, 0, -5022.75, 430.781, -10.0339, 0.303842, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140519, 23286, 530, 1, 0, 0, -5013.32, 459.255, -7.65362, 6.22966, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140520, 23286, 530, 1, 0, 0, -5000, 445.478, -6.96391, 2.93885, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140521, 23286, 530, 1, 0, 0, -5115.25, 384.494, -12.52, 1.63298, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140522, 23286, 530, 1, 0, 0, -5023.56, 465.013, -8.61042, 2.50162, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140523, 23286, 530, 1, 0, 0, -5079.76, 468.967, -8.46821, 1.56307, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140524, 23286, 530, 1, 0, 0, -5018.34, 488.495, -8.07559, 1.01721, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140525, 23286, 530, 1, 0, 0, -5129.29, 425.833, -11.3592, 3.62866, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140526, 23286, 530, 1, 0, 0, -5012.51, 543.045, -4.53214, 4.81461, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140527, 23286, 530, 1, 0, 0, -5094.57, 511.98, -11.678, 2.10106, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140528, 23286, 530, 1, 0, 0, -5113.43, 461.183, -10.5322, 0.00404715, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140529, 23286, 530, 1, 0, 0, -5095.13, 646.196, 32.9789, 1.9856, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140530, 23286, 530, 1, 0, 0, -5048.1, 633.528, 22.6769, 1.57798, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140531, 23286, 530, 1, 0, 0, -5107.42, 682.474, 34.8255, 1.57798, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140532, 23286, 530, 1, 0, 0, -5069.87, 675.499, 33.4247, 3.56974, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140533, 23286, 530, 1, 0, 0, -5146.54, 491.249, -13.8132, 5.48925, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140534, 23286, 530, 1, 0, 0, -5173.72, 421.3, -10.4883, 3.59644, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140535, 23286, 530, 1, 0, 0, -5182.14, 343.977, -21.4375, 1.99184, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140536, 23286, 530, 1, 0, 0, -5219.86, 338.501, -22.0416, 3.73542, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140537, 23285, 530, 1, 0, 0, -5010.47, 418.128, -10.2213, 1.12906, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140538, 23285, 530, 1, 0, 0, -5107.32, 419.949, -12.5462, 3.57167, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140539, 23285, 530, 1, 0, 0, -5099.04, 399.222, -12.601, 4.23532, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140540, 23286, 530, 1, 0, 0, -4995.15, 520.18, -5.37083, 1.45893, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140541, 23286, 530, 1, 0, 0, -5176.14, 374.761, -19.8123, 5.43698, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140542, 23286, 530, 1, 0, 0, -5146.27, 346.642, -18.8773, 0.358768, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140543, 23169, 530, 1, 0, 0, -4952.52, 483.403, 3.33166, 2.82631, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140544, 23169, 530, 1, 0, 0, -4974.97, 460.03, 3.05225, 3.22372, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140545, 23169, 530, 1, 0, 0, -4927.05, 454.454, 1.49615, 0.953924, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140546, 23169, 530, 1, 0, 0, -4953.06, 421.764, 2.87277, 4.2683, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140547, 23169, 530, 1, 0, 0, -4956.07, 357.641, -2.5232, 4.3547, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140548, 23169, 530, 1, 0, 0, -4970.04, 309.18, -2.96103, 4.33505, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140549, 23169, 530, 1, 0, 0, -4948.2, 293.112, -7.26181, 0.270241, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140550, 23169, 530, 1, 0, 0, -4922, 303.155, -13.3553, 0.757188, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140551, 23169, 530, 1, 0, 0, -4997.32, 290.245, -2.24522, 2.62251, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140552, 23169, 530, 1, 0, 0, -5006.9, 267.489, -1.89704, 3.2469, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140553, 23169, 530, 1, 0, 0, -4991.47, 250.541, -5.76584, 5.36748, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140554, 23169, 530, 1, 0, 0, -4973.54, 225.451, -10.9796, 4.72738, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140555, 23169, 530, 1, 0, 0, -4971.94, 268.502, -7.06792, 0.761132, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140556, 23169, 530, 1, 0, 0, -5004.51, 233.188, -8.51353, 3.90116, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140557, 23169, 530, 1, 0, 0, -5034.1, 205.98, -12.4777, 3.8344, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140558, 23169, 530, 1, 0, 0, -5043.84, 172.295, -13.7058, 5.47195, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140559, 23169, 530, 1, 0, 0, -5097.41, 178.122, -8.44018, 2.59974, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140560, 23169, 530, 1, 0, 0, -5164.15, 153.849, -12.7468, 2.80001, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140561, 23326, 530, 1, 0, 0, -4946.79, 403.189, -0.796316, 4.58246, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140562, 23326, 530, 1, 0, 0, -4966.87, 347.387, -1.60104, 4.25259, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140563, 23326, 530, 1, 0, 0, -5017.47, 281.068, 1.29391, 2.60929, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140564, 23326, 530, 1, 0, 0, -4981.12, 311.104, -1.9292, 1.09347, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140565, 23326, 530, 1, 0, 0, -5188.59, 151.283, -12.8542, 0.965763, 300, 0, 0, 5240, 0, 0, 0);
INSERT INTO `creature` VALUES (140566, 23326, 530, 1, 0, 0, -5186.65, 167.762, -11.8742, 1.89489, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140567, 23326, 530, 1, 0, 0, -5197.84, 186.612, -12.5282, 2.24439, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140568, 23326, 530, 1, 0, 0, -5010.14, 251.174, -3.03427, 4.40073, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140569, 23326, 530, 1, 0, 0, -5023.7, 210.638, -11.9473, 3.91378, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140570, 23326, 530, 1, 0, 0, -5034.53, 160.782, -14.3529, 5.56704, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140571, 23326, 530, 1, 0, 0, -5070.61, 163.745, -10.0831, 3.09304, 300, 5, 0, 5240, 0, 0, 1);
INSERT INTO `creature` VALUES (140572, 23324, 530, 1, 0, 0, -5219.73, 222.883, -11.3673, 1.97768, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140573, 23324, 530, 1, 0, 0, -5179.4, 174.429, -11.5549, 1.54151, 300, 5, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140574, 23324, 530, 1, 0, 0, -5198.31, 158.062, -13.4348, 1.54151, 300, 10, 0, 6986, 0, 0, 1);
INSERT INTO `creature` VALUES (140575, 23309, 530, 1, 0, 0, -4898.18, 411.931, -5.89363, 3.36848, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140576, 23309, 530, 1, 0, 0, -4860.77, 468.779, -5.82488, 4.24115, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140577, 23309, 530, 1, 0, 0, -4907.27, 314.558, -12.2545, 1.51844, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140578, 23309, 530, 1, 0, 0, -4961.05, 211.625, -11.0616, 4.03171, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140579, 23305, 530, 1, 0, 0, -5238.25, 234.065, -11.7546, 5.36175, 300, 10, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140580, 23305, 530, 1, 0, 0, -5229.3, 140.023, -13.5415, 0.382326, 300, 5, 0, 7181, 0, 0, 1);
INSERT INTO `creature` VALUES (140581, 23102, 530, 1, 0, 0, -2443.7, 4634.14, 158.221, 1.10586, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140582, 23102, 530, 1, 0, 0, -2482.24, 4661.68, 161.413, 3.51227, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140583, 23102, 530, 1, 0, 0, -2384.98, 4552.59, 165.69, 4.99611, 25, 0, 0, 4120, 0, 0, 0);
-- abweichung
-- INSERT INTO `creature` VALUES (140584, 23102, 530, 1, 0, 0, -2432.75, 4458.1, 166.076, 0.907029, 25, 0, 0, 4120, 0, 0, 0);
-- 140585 free
INSERT INTO `creature` VALUES (140586, 4075, 0, 1, 0, 0, 1412.15, 417.707, -84.9654, 3.36426, 180, 5, 0, 8, 0, 0, 1);
INSERT INTO `creature` VALUES (140587, 4075, 0, 1, 0, 0, 1428.02, 406.496, -85.2519, 3.37997, 180, 20, 0, 8, 0, 0, 1);
INSERT INTO `creature` VALUES (140588, 4075, 0, 1, 0, 0, 1452.04, 401.733, -84.9925, 0.222665, 180, 5, 0, 8, 0, 0, 1);
INSERT INTO `creature` VALUES (140589, 4075, 0, 1, 0, 0, 1407.63, 370.503, -84.953, 3.96901, 180, 5, 0, 8, 0, 0, 1);
INSERT INTO `creature` VALUES (140590, 1125, 0, 1, 0, 0, -6119.69, -200.734, 434.551, 0.361272, 180, 5, 0, 102, 0, 0, 1);
-- 140591-140622
INSERT INTO `creature` VALUES (140623, 19768, 530, 1, 0, 0, -2953.91, 1632.53, 55.186, 5.20641, 180, 0, 0, 5233, 2991, 0, 2);
SET @GUID := 140623;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140623, 1, -2948.85, 1620.52, 50.9339, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 2, -2948.62, 1606.71, 46.3706, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 3, -2946.83, 1597.38, 43.3655, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 4, -2941.05, 1589.2, 40.6134, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 5, -2930.78, 1584.22, 36.7235, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 6, -2915.55, 1581.13, 30.0541, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 7, -2902.26, 1580.24, 24.2089, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 8, -2872.79, 1580.65, 15.7052, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 9, -2892.4, 1580.48, 20.5454, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 10, -2910.51, 1580.57, 27.9381, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 11, -2923.92, 1583.02, 34.0035, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 12, -2936.33, 1587.42, 38.8889, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 13, -2945.42, 1595.14, 42.6182, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 14, -2947.7, 1601.71, 44.7921, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 15, -2948.34, 1612.44, 48.2517, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 16, -2947.95, 1624.06, 51.8413, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 17, -2955.93, 1638.98, 57.3739, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 18, -2957.91, 1642.16, 58.2903, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 19, -2962.38, 1650.06, 62.1748, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 20, -2963.01, 1652.75, 62.1967, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 21, -2968.32, 1662.33, 66.9122, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 22, -2983.44, 1679.15, 67.6165, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 23, -2968.48, 1662.08, 66.9107, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 24, -2963.18, 1652.73, 62.198, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 25, -2961.16, 1650.86, 62.1755, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 26, -2957.02, 1641.53, 57.7952, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140623, 27, -2954.48, 1632.21, 55.2364, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140624, 19788, 530, 1, 0, 0, -2703.59, 1159.87, 5.30619, 4.24358, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140624;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140624, 1, -2709.5, 1149.2, 3.76682, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 2, -2716.63, 1143.44, 1.55487, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 3, -2728.59, 1142.06, 1.56225, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 4, -2740.74, 1144.66, 2.58528, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 5, -2749.98, 1149.23, 4.84679, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 6, -2760.58, 1151.75, 6.37926, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 7, -2750.32, 1148.65, 5.02487, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 8, -2744.08, 1146.07, 3.08787, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 9, -2731.79, 1140.63, 2.27721, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 10, -2725.69, 1141.51, 1.0185, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 11, -2715.63, 1142.92, 1.56719, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 12, -2709.58, 1149.27, 3.79128, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140624, 13, -2704.87, 1160.91, 5.26353, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140625, 19788, 530, 1, 0, 0, -2670.19, 1189.04, 2.50672, 0.717135, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140625;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140625, 1, -2662.78, 1194.27, 4.89809, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140625, 2, -2652.94, 1202.78, 6.36992, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140625, 3, -2662.1, 1193.35, 4.7841, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140625, 4, -2669.66, 1188.71, 2.66698, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140625, 5, -2681.1, 1177.21, 5.30023, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140625, 6, -2693.57, 1169.01, 5.23136, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140625, 7, -2680.37, 1178.64, 5.0248, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140625, 8, -2669.93, 1189.34, 2.6242, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140626, 19788, 530, 1, 0, 0, -2663.22, 1283.27, 27.3812, 5.66254, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140626;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140626, 1, -2673.27, 1287.53, 30.0059, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140626, 2, -2686.45, 1288, 33.7323, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140626, 3, -2702.89, 1294.32, 33.346, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140626, 4, -2708.91, 1316.02, 33.1505, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140626, 5, -2703.39, 1296.33, 33.1224, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140626, 6, -2697.54, 1293.02, 33.7168, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140626, 7, -2685.62, 1288.57, 33.6562, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140626, 8, -2665.94, 1281.87, 27.3855, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140627, 19788, 530, 1, 0, 0, -2666.03, 1342.99, 34.4455, 3.37765, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140627;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140627, 1, -2697.32, 1335.65, 34.4455, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 2, -2714.16, 1325.63, 34.4318, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 3, -2731.4, 1319.42, 33.3495, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 4, -2744.27, 1313.27, 33.6604, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 5, -2761.38, 1299.57, 33.234, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 6, -2735.76, 1318.91, 33.372, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 7, -2714.38, 1324.81, 34.4313, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 8, -2696.22, 1335.15, 34.4441, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140627, 9, -2666.71, 1343.22, 34.4441, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140628, 19788, 530, 1, 0, 0, -2631.91, 1352.43, 36.4787, 0.130435, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140628;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140628, 1, -2602.22, 1356.34, 38.5434, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140628, 2, -2593.89, 1359.97, 39.9005, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140628, 3, -2580.5, 1369.67, 41.5277, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140628, 4, -2598.78, 1357.09, 38.9169, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140628, 5, -2630.38, 1351.95, 36.5911, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140629, 19788, 530, 1, 0, 0, -2638.05, 1371.17, 36.0565, 0.833366, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140629;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140629, 1, -2627.7, 1381.62, 37.312, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140629, 2, -2610.51, 1394.28, 41.4979, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140629, 3, -2601.86, 1401.56, 41.8298, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140629, 4, -2611.51, 1393.41, 41.3773, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140629, 5, -2629.13, 1381.32, 37.1627, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140629, 6, -2637.9, 1371.2, 36.0518, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140630, 19765, 530, 1, 0, 0, -2809.17, 1208.37, 6.36241, 1.99577, 300, 5, 0, 7000, 0, 0, 2);
SET @GUID := 140630;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140630, 1, -2813.66, 1219.47, 6.26582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140630, 2, -2823.04, 1231.43, 6.26582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140630, 3, -2812.49, 1218.18, 6.26582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140630, 4, -2810.22, 1210.22, 6.33902, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140630, 5, -2804.85, 1201.79, 6.35387, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140630, 6, -2809.33, 1208.98, 6.34654, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140631, 19765, 530, 1, 0, 0, -2625.6, 1230.3, 16.0772, 4.37159, 300, 0, 0, 6800, 0, 0, 2);
SET @GUID := 140631;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140631, 1, -2630.87, 1216.9, 13.2485, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140631, 2, -2633.34, 1209.6, 11.5034, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140631, 3, -2640.97, 1198.39, 7.09301, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140631, 4, -2633.61, 1208.49, 11.2079, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140631, 5, -2625.64, 1231.05, 16.2039, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140632, 19765, 530, 1, 0, 0, -2751.58, 1254.24, 33.2959, 5.17046, 300, 0, 0, 7000, 0, 0, 2);
SET @GUID := 140632;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140632, 1, -2749.4, 1244.21, 33.2671, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 2, -2743.86, 1237.89, 33.1367, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 3, -2734.48, 1234.54, 33.0974, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 4, -2727.84, 1234.95, 33.3884, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 5, -2719.89, 1239.82, 33.4734, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 6, -2732.9, 1236.39, 33.2376, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 7, -2743.78, 1243.76, 33.0691, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 8, -2752.27, 1253.43, 33.3292, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 9, -2756.76, 1261.23, 33.6086, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 10, -2755.41, 1267.02, 33.5622, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 11, -2751.57, 1271.24, 33.2816, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 12, -2755.03, 1267.12, 33.5387, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 13, -2755.32, 1260.73, 33.5241, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140632, 14, -2752.29, 1253.29, 33.3312, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140633, 19767, 530, 1, 0, 0, -2696.6, 1353.23, 33.0829, 4.37698, 300, 0, 0, 5409, 3080, 0, 2);
SET @GUID := 140633;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140633, 1, -2695.24, 1357.19, 33.7026, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 2, -2685.75, 1365.43, 36.35, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 3, -2674.19, 1374.13, 35.8703, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 4, -2674.55, 1377.93, 36.8811, 8000, 0, 0, 0, 0); -- 1976701
INSERT INTO `waypoint_data` VALUES (140633, 5, -2673.1, 1372.77, 35.2807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 6, -2673.87, 1369.61, 34.4183, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 7, -2675.56, 1369.15, 34.7282, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 8, -2680.29, 1370.4, 36.4156, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 9, -2691.28, 1367.88, 37.5129, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 10, -2695.36, 1365.82, 37.2766, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140633, 11, -2697.01, 1353.85, 33.2442, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140634, 19784, 530, 1, 0, 0, -2783.33, 1278.81, 34.3858, 3.82742, 300, 0, 0, 6542, 0, 0, 2);
SET @GUID := 140634;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140634, 1, -2800.36, 1264.38, 33.7794, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140634, 2, -2785.31, 1278.35, 34.5188, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140635, 19784, 530, 1, 0, 0, -2780.24, 1275.13, 34.1177, 3.80386, 300, 0, 0, 6542, 0, 0, 2);
SET @GUID := 140635;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140635, 1, -2798.04, 1259.64, 33.7046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140635, 2, -2779.5, 1275.52, 34.0586, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140636, 21041, 530, 1, 0, 0, -2614.51, 1381.27, 51.6831, 5.55015, 180, 0, 0, 8, 0, 0, 0);
INSERT INTO `creature` VALUES (140637, 21041, 530, 1, 0, 0, -2605.25, 1369.39, 47.99, 4.03171, 180, 0, 0, 8, 0, 0, 0);
INSERT INTO `creature` VALUES (140638, 21041, 530, 1, 0, 0, -2610.76, 1377.7, 41.0943, 3.50811, 180, 0, 0, 8, 0, 0, 0);
INSERT INTO `creature` VALUES (140639, 21041, 530, 1, 0, 0, -2605.53, 1374.24, 45.3846, 5.55015, 180, 0, 0, 8, 0, 0, 0);
INSERT INTO `creature` VALUES (140640, 21041, 530, 1, 0, 0, -2590.76, 1387.65, 54.3178, 4.10152, 180, 0, 0, 8, 0, 0, 0);
INSERT INTO `creature` VALUES (140641, 19355, 530, 1, 0, 0, -3114.63, 2574.29, 61.833, 4.23464, 180, 0, 0, 3052, 0, 0, 2);
SET @GUID := 140641;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140641, 1, -3119.21, 2568.56, 61.7314, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 2, -3130.42, 2567.74, 61.6389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 3, -3136.44, 2571.7, 61.7384, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 4, -3144.4, 2579.04, 62.0745, 60000, 0, 0, 0, 0); -- 1935502
INSERT INTO `waypoint_data` VALUES (140641, 5, -3134.28, 2550.84, 62.1044, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 6, -3133.02, 2552.09, 62.1456, 60000, 0, 0, 0, 0); -- 1935502
INSERT INTO `waypoint_data` VALUES (140641, 7, -3134.71, 2552.86, 62.148, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 8, -3134.6, 2557.56, 61.9761, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 9, -3127.74, 2563.25, 61.4409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 10, -3086.83, 2576.14, 61.8572, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 11, -3082.29, 2579.78, 62.3389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 12, -3083.66, 2582.2, 62.1725, 60000, 0, 0, 0, 0); -- 1935502
INSERT INTO `waypoint_data` VALUES (140641, 13, -3080.6, 2583.78, 62.5164, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 14, -3075.93, 2599.77, 61.7457, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 15, -3077.69, 2603.51, 61.7306, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 16, -3084.03, 2610.19, 61.7291, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 17, -3086.55, 2611.93, 61.7291, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 18, -3087.66, 2614.89, 61.7291, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 19, -3087.33, 2619.43, 61.7291, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 20, -3082.3, 2619.89, 61.7291, 60000, 0, 0, 0, 0); -- 1935502
INSERT INTO `waypoint_data` VALUES (140641, 21, -3102.85, 2609, 61.7642, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 22, -3111.04, 2600.86, 61.9742, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 23, -3113.23, 2590.05, 62.3248, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140641, 24, -3114.75, 2573.97, 61.828, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140642, 21050, 530, 1, 0, 0, -3401.94, 1594.09, 45.9019, 5.79304, 180, 0, 0, 6761, 0, 0, 2);
SET @GUID := 140642;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140642, 1, -3400.45, 1579.4, 46.8652, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 2, -3389.75, 1567.38, 48.1885, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 3, -3377.06, 1565.15, 49.7281, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 4, -3363.11, 1565.16, 49.1122, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 5, -3355.71, 1554.58, 49.7046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 6, -3352.07, 1521.5, 52.6119, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 7, -3347.26, 1512.19, 55.2219, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 8, -3339.7, 1500.99, 58.5891, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 9, -3340.73, 1493.55, 58.1675, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 10, -3345.8, 1494.06, 57.3365, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 11, -3349.73, 1501.85, 55.1933, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 12, -3339.48, 1525.89, 53.1462, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 13, -3340.31, 1542.84, 53.2299, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 14, -3356.87, 1559.89, 48.9579, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 15, -3362.24, 1564.57, 49.1256, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 16, -3376.4, 1566.63, 49.4909, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 17, -3382.72, 1567.24, 48.0252, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 18, -3392.77, 1569.33, 47.5556, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 19, -3400.77, 1579.15, 46.9104, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 20, -3399.51, 1592.05, 46.4213, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 21, -3423.97, 1598.17, 47.2602, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 22, -3454.44, 1599.59, 45.5399, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 23, -3477.29, 1600.43, 47.0628, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 24, -3466.51, 1599.7, 45.2818, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 25, -3430.14, 1598.29, 46.5037, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 26, -3411.66, 1592.33, 47.5634, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140642, 27, -3399.51, 1595.82, 46.2274, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140643, 21050, 530, 1, 0, 0, -3667.21, 1723.94, 41.043, 3.93526, 180, 0, 0, 6761, 0, 0, 2);
SET @GUID := 140643;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140643, 1, -3686.01, 1707.4, 40.5547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 2, -3696.97, 1704.18, 41.0685, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 3, -3707.51, 1708.84, 40.9849, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 4, -3715.55, 1717.43, 40.8865, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 5, -3712.55, 1729.17, 44.0952, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 6, -3706.95, 1739, 51.5767, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 7, -3693.86, 1753.82, 54.5777, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 8, -3682.5, 1763.09, 44.3714, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 9, -3675.4, 1766.51, 40.9381, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 10, -3665.3, 1762.31, 41.7159, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 11, -3660.01, 1756.15, 40.6729, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140643, 12, -3665.82, 1724.3, 41.0397, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140644, 21050, 530, 1, 0, 0, -3710.69, 1677.08, 41.0118, 2.99125, 180, 0, 0, 6542, 0, 0, 2);
SET @GUID := 140644;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140644, 1, -3705.27, 1692.13, 40.4454, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 2, -3707.92, 1703.73, 40.9052, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 3, -3716.4, 1713.82, 40.8496, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 4, -3725.67, 1715.98, 41.593, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 5, -3731.9, 1712.89, 41.0044, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 6, -3735.35, 1704.45, 40.8381, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 7, -3729.98, 1693.9, 41.3835, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 8, -3726.83, 1685.98, 41.2881, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (140644, 9, -3716.06, 1676.56, 40.7349, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (140645, 21108, 530, 1, 0, 0, -3300.09, 1463.34, 51.55, 5.08793, 300, 0, 0, 6761, 0, 0, 2);
SET @GUID := 140645;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140645, 1, -3287.86, 1412.26, 50.2313, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 2, -3281.42, 1393.18, 52.574, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 3, -3273.87, 1365.81, 50.913, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 4, -3260.18, 1347.87, 48.9119, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 5, -3248.73, 1353.49, 51.1305, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 6, -3250.08, 1364.19, 50.2145, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 7, -3260.62, 1384.49, 51.3391, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 8, -3264.61, 1423.85, 51.2409, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 9, -3274.98, 1456.48, 50.8531, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 10, -3265.7, 1515.82, 50.6368, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 11, -3267.05, 1549.42, 50.8879, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 12, -3288.94, 1567.97, 51.9825, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 13, -3328.93, 1590.19, 51.9497, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 14, -3349, 1596.11, 51.5565, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 15, -3367.35, 1594.09, 47.1684, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 16, -3383.31, 1594.08, 48.4979, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 17, -3400.97, 1593, 46.0947, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 18, -3408.8, 1593.05, 47.5293, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 19, -3453.03, 1607.03, 44.8104, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 20, -3475.6, 1618.33, 43.5552, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 21, -3494.26, 1636.7, 43.0869, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 22, -3515.2, 1664.12, 45.9852, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 23, -3529.14, 1675.73, 41.3297, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 24, -3551.77, 1687.56, 40.1676, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 25, -3569.08, 1727.82, 40.0509, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 26, -3566.71, 1755.33, 39.1077, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 27, -3609.59, 1756.4, 38.812, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 28, -3665.47, 1739.46, 40.0974, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 29, -3708.24, 1708.09, 41.0614, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 30, -3760.09, 1667.63, 39.6639, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 31, -3745.42, 1615.05, 41.8879, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 32, -3691.21, 1591.18, 44.3896, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 33, -3617.37, 1606.96, 44.548, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 34, -3561.79, 1622.34, 44.7117, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 35, -3515.49, 1600.1, 45.0796, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 36, -3482.66, 1590.89, 46.9434, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 37, -3464.06, 1588.62, 46.4173, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 38, -3440.06, 1584.29, 46.497, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 39, -3340.3, 1589.32, 52.7975, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 40, -3311.78, 1574.92, 51.9905, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 42, -3311.26, 1564.96, 51.481, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140645, 43, -3300.6, 1464.73, 51.5472, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140646, 21108, 530, 1, 0, 0, -3419.71, 1784.16, 101.805, 0.524738, 300, 0, 0, 6761, 0, 0, 2);
SET @GUID := 140646;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140646, 1, -3403.45, 1772.14, 101.297, 5000,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 2, -3398.81, 1762.23, 102.941, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 3, -3371, 1745.24, 100.975, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 4, -3366.3613, 1743.4969, 103.6118, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 5, -3361.81, 1741.45, 105.019, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 6, -3359.98, 1732.87, 105.472, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 7, -3323.59, 1694.08, 86.5096, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 8, -3295.64, 1672.87, 78.1218, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 9, -3267.15, 1645.62, 75.9675, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 10, -3225.05, 1616.91, 72.6087, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 11, -3210.92, 1600.48, 66.0893, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 12, -3206.74, 1579.32, 65.6319, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 13, -3210.36, 1553.1, 68.9449, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 14, -3206.14, 1540.35, 64.387, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 15, -3191.89, 1526.35, 58.7016, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 16, -3212.46, 1479.68, 50.2325, 5000,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 17, -3250.97, 1427.84, 53.3375, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 18, -3258.26, 1388.5, 52.0214, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 19, -3251.17, 1356.83, 51.1723, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 20, -3269.54, 1362.19, 50.4712, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 21, -3288.97, 1415.78, 50.2179, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 22, -3297.14, 1502.28, 51.99, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 23, -3320.51, 1569.32, 53.3711, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 24, -3336.13, 1588.33, 52.9492, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 25, -3361.59, 1607.53, 51.9881, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 26, -3364.99, 1629.22, 70.1786, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 27, -3357.41, 1644.46, 77.924, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 28, -3354.07, 1660.57, 88.9349, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 29, -3365.41, 1672.48, 96.1703, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 30, -3378.84, 1675.79, 98.7418, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 31, -3387.05, 1681.33, 99.7231, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 32, -3394.48, 1691.46, 100.191, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 33, -3391.42, 1719.77, 100.912, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 34, -3395.46, 1733.23, 100.907, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 35, -3421.93, 1763.18, 100.806, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140646, 36, -3419.22, 1784.51, 101.823, 0,0,0,100,0);
-- felmist
INSERT INTO `creature` VALUES (140647, 17407, 530, 1, 0, 0, -5234.1347, 216.5856, -12.8691, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0); -- unusual
INSERT INTO `creature` VALUES (140648, 17407, 530, 1, 0, 0, -5066.8476, 437.9804, -12.2789, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0); -- unusual
INSERT INTO `creature` VALUES (140649, 17407, 530, 1, 0, 0, -4672.9589, 1088.5375, 1.5159, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140650, 17407, 530, 1, 0, 0, -4431.3818, 982.1983, 39.2977, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140651, 17407, 530, 1, 0, 0, -3856.7827, 1392.4550, 40.5468, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
--
INSERT INTO `creature` VALUES (140652, 21419, 530, 1, 0, 0, -3784.81, 2286.66, 83.0783, 2.74718, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140653, 21419, 530, 1, 0, 0, -3816.42, 2285.9, 91.4079, 0.0375435, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140654, 21419, 530, 1, 0, 0, -3848.7199, 2300.2600, 112.4635, 4.24727, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140655, 21419, 530, 1, 0, 0, -3847.77, 2218.69, 93.8801, 4.7028, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140656, 21419, 530, 1, 0, 0, -3849.34, 2185.77, 95.7345, 1.94999, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140657, 21419, 530, 1, 0, 0, -3817.76, 2219.59, 91.8577, 5.30308, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140658, 21419, 530, 1, 0, 0, -3817.89, 2186.58, 90.4282, 4.72244, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140659, 21419, 530, 1, 0, 0, -3783.44, 2249.07, 86.5784, 4.04307, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140660, 21419, 530, 1, 0, 0, -3786.38, 2217.81, 86.5859, 2.04816, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140661, 21419, 530, 1, 0, 0, -3784.5, 2184.19, 81.3733, 4.78919, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140662, 21419, 530, 1, 0, 0, -3786.1, 2152.5, 81.8705, 2.4919, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140663, 21419, 530, 1, 0, 0, -3785.82, 2083.22, 87.6686, 4.80097, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140664, 21419, 530, 1, 0, 0, -3783.75, 2051.07, 90.8064, 1.65152, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140665, 21419, 530, 1, 0, 0, -3846.34, 2019.34, 95.0945, 4.72635, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140666, 21419, 530, 1, 0, 0, -3784.7, 1917.45, 96.7852, 1.54941, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140667, 21419, 530, 1, 0, 0, -3783.79, 1946.7, 93.7058, 1.51014, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140668, 21419, 530, 1, 0, 0, -3756.44, 1944.63, 95.9784, 3.68963, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140669, 21419, 530, 1, 0, 0, -3751.48, 1983.8, 88.7101, 2.73537, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140670, 21419, 530, 1, 0, 0, -3719.93, 1983.6, 84.9934, 2.87674, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140671, 21419, 530, 1, 0, 0, -3715.19, 2079.73, 79.8674, 4.93449, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140672, 21419, 530, 1, 0, 0, -3716.08, 2119.36, 79.1584, 1.53086, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140673, 21419, 530, 1, 0, 0, -3716.16, 2149.15, 78.6881, 1.59262, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140674, 21419, 530, 1, 0, 0, -3719.69, 2184.11, 77.1836, 1.86751, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140675, 21419, 530, 1, 0, 0, -3685.3, 2183.46, 76.2974, 0.0178981, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140676, 21419, 530, 1, 0, 0, -3683.27, 2153.68, 77.2081, 4.69102, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140677, 21419, 530, 1, 0, 0, -3685.26, 2114.55, 77.2785, 4.52609, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140678, 21419, 530, 1, 0, 0, -3683.11, 2082.65, 79.0549, 4.85596, 30, 5, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140679, 21419, 530, 1, 0, 0, -3652.89, 2118.24, 74.0999, 4.19622, 30, 5, 0, 6542, 0, 0, 1);
INSERT INTO `creature` VALUES (140680, 19744, 530, 1, 0, 0, -3665.54, 1108.07, 61.3669, 1.94317, 300, 0, 0, 5589, 3155, 0, 2);
SET @GUID := 140680;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140680, 1, -3678.61, 1133.88, 60.4435, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 2, -3690.92, 1139.26, 64.7604, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 3, -3702.91, 1139.36, 67.6693, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 4, -3716.57, 1134.06, 67.1855, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 5, -3703.88, 1143.3, 67.3359, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 6, -3692.36, 1146.59, 64.548, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 7, -3678.06, 1145.78, 60.2868, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 8, -3666.09, 1137.03, 57.0266, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 9, -3658.06, 1117.16, 58.0592, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 10, -3655.79, 1090.31, 64.8018, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 11, -3663.67, 1067.47, 67.2895, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 12, -3665.2, 1088.37, 66.8208, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140680, 13, -3667.99, 1107.8, 61.7709, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140681, 21520, 530, 1, 0, 0, -3672.81, 1138.07, 58.8466, 2.53618, 180, 5, 0, 5589, 3155, 0, 1);
INSERT INTO `creature` VALUES (140682, 19801, 530, 1, 0, 0, -3670.75, 1136.53, 58.2683, 1.37622, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140683, 19801, 530, 1, 0, 0, -3675.78, 1137.01, 59.6789, 1.41942, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140684, 21520, 530, 1, 0, 0, -3646.96, 1107.05, 58.4512, 3.02007, 180, 5, 0, 5589, 3155, 0, 1);
INSERT INTO `creature` VALUES (140685, 19801, 530, 1, 0, 0, -3645.02, 1109.62, 57.8429, 3.03971, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140686, 19801, 530, 1, 0, 0, -3643.98, 1105.48, 58.2824, 3.024, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140687, 21520, 530, 1, 0, 0, -3658.33, 1082.92, 66.3172, 2.80566, 180, 5, 0, 5589, 3155, 0, 1);
INSERT INTO `creature` VALUES (140688, 19801, 530, 1, 0, 0, -3654.8, 1084.15, 65.2433, 2.80959, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140689, 19801, 530, 1, 0, 0, -3658.35, 1078.32, 66.4645, 1.92209, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140690, 21520, 530, 1, 0, 0, -3686.07, 1014.24, 67.7476, 2.69595, 180, 5, 0, 5589, 3155, 0, 1);
INSERT INTO `creature` VALUES (140691, 19801, 530, 1, 0, 0, -3681.87, 1015.27, 67.3623, 2.43991, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140692, 19801, 530, 1, 0, 0, -3684.55, 1010.74, 67.389, 2.73837, 180, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (140693, 2556, 0, 1, 0, 0, -1234.76, -3536.47, 46.5823, 5.929, 120, 0, 0, 1342, 0, 0, 0);
INSERT INTO `creature` VALUES (140694, 2552, 0, 1, 0, 0, -1232.1, -3535.9, 46.4729, 5.6706, 120, 0, 0, 1107, 0, 0, 0);
INSERT INTO `creature` VALUES (140695, 2552, 0, 1, 0, 0, -1230.75, -3533.46, 46.0261, 5.83082, 120, 0, 0, 1107, 0, 0, 0);
INSERT INTO `creature` VALUES (140696, 2552, 0, 1, 0, 0, -1229.85, -3535.1, 46.3087, 5.918, 120, 0, 0, 1050, 0, 0, 0);
INSERT INTO `creature` VALUES (140697, 2553, 0, 1, 0, 0, -1233.3, -3533.72, 46.0859, 5.80098, 120, 0, 0, 847, 2253, 0, 2);
SET @GUID := 140697;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140697, 1, -1233.3, -3533.72, 46.0859, 100000, 0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140697, 2, -1233.3, -3533.72, 46.0859, 3000, 0,0,100,0); -- 255301
INSERT INTO `waypoint_data` VALUES (140697, 3, -1233.3, -3533.72, 46.0859, 1000, 0,0,100,0); -- 255302
INSERT INTO `waypoint_data` VALUES (140697, 4, -1162.87, -3563.07, 50.5074, 0, 0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140697, 5, -1032.97, -3550.54, 55.9796, 0, 0,0,100,0);
DELETE FROM `creature_formations` WHERE `leaderguid` IN (140693,140694,140695,140696,140697);
INSERT INTO `creature_formations` VALUES
(140697,140697,3,360,2),
(140697,140696,5,3,2),
(140697,140695,3,3.9,2),
(140697,140694,3,2.3,2),
(140697,140693,3,1.5,2);
INSERT INTO `creature` VALUES (140698, 22332, 530, 0, 17188, 0, -4086.1, 298.374, 141.729, 2.51223, 5, 0, 0, 27000, 0, 0, 2); -- movement on script
INSERT INTO `creature` VALUES (140699, 22332, 530, 0, 17188, 0, -4153.9, 228.013, 167.625, 2.51223, 5, 0, 0, 27000, 0, 0, 2); -- movement on script
INSERT INTO `creature` VALUES (140700, 22332, 530, 0, 17188, 0, -4338.94, 379.093, 134.61, 2.51223, 5, 0, 0, 27000, 0, 0, 2); -- movement on script
INSERT INTO `creature` VALUES (140701, 21720, 530, 1, 0, 0, -4292.98, 340.881, 107.096, 0.79021, 300, 0, 0, 5409, 3080, 0, 2);
SET @GUID := 140701;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140701, 1, -4289.59, 346.399, 104.111, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 2, -4281.13, 354.821, 95.4771, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 3, -4270.27, 369.509, 81.2705, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 4, -4270.36, 376.657, 79.602, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 5, -4257.27, 375.784, 78.5948, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 6, -4249.57, 383.635, 76.2674, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 7, -4257.64, 391.223, 78.149, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 8, -4264.45, 411.093, 79.3317, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 9, -4269.28, 402.955, 81.1993, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 10, -4275.18, 392.348, 81.3846, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 11, -4279.31, 384.501, 79.6322, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 12, -4270.36, 376.657, 79.602, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 13, -4281.79, 357.416, 94.0001, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 14, -4289.13, 346.915, 103.669, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 15, -4296.65, 334.31, 109.315, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 16, -4296.91, 310.901, 118.275, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 17, -4287.18, 296.827, 121.951, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 18, -4278.96, 293.098, 122.413, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 19, -4287.44, 297.287, 121.903, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 20, -4298.07, 315.398, 116.483, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140701, 21, -4298.33, 327.09, 111.821, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140702, 23286, 530, 1, 0, 0, -5037.76, 361.996, 2.47224, 4.83238, 300, 0, 0, 5240, 0, 0, 2);
SET @GUID := 140702;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140702, 1, -5028.69, 337.405, 1.28132, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 2, -5034.7, 326.371, -1.17461, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 3, -5043.8, 308.722, -6.34723, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 4, -5049.19, 298.824, -7.57796, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 5, -5072.68, 290.605, -8.30046, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 6, -5080.16, 287.886, -8.07662, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 7, -5078.26, 291.331, -7.91104, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 8, -5052.26, 300.331, -7.57235, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 9, -5046.45, 304.058, -7.0923, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 10, -5033.16, 348.629, 2.59315, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140702, 11, -5037.76, 361.996, 2.47224, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140703, 23286, 530, 1, 0, 0, -5037.75, 598.596, 18.3524, 3.43622, 300, 0, 0, 5240, 0, 0, 2);
SET @GUID := 140703;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140703, 1, -5026.54, 602.799, 19.1664, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140703, 2, -5048.57, 594.614, 18.9736, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140704, 23283, 530, 1, 0, 0, -5238.41, 776.695, 181.833, 5.21307, 600, 0, 0, 151760, 0, 0, 2);
SET @GUID := 140704;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140704, 1, -5238.41, 776.695, 181.833, 0,0,0,100,0); -- 2328301
INSERT INTO `waypoint_data` VALUES (140704, 2, -5238, 775.781, 181.833, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140704, 3, -5245.78, 722.915, 173.064, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140704, 4, -5220.59, 696.059, 139.87, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140704, 5, -5198.42, 674.919, 95.4254, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140704, 6, -5182.4, 660.596, 79.7865, 3000,0,0,100,0); -- 2328302
INSERT INTO `creature` VALUES (140705, 23287, 530, 1, 0, 0, -4904.54, 420.029, -5.17154, 2.44346, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140706, 23287, 530, 1, 0, 0, -4956.98, 356.441, -2.34743, 4.46804, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140707, 23287, 530, 1, 0, 0, -4941.54, 294.663, -8.89759, 3.26377, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140708, 23287, 530, 1, 0, 0, -4919.89, 307.317, -13.2153, 3.40339, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140709, 23287, 530, 1, 0, 0, -4969.65, 298.882, -3.58632, 3.42085, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140710, 23287, 530, 1, 0, 0, -4970.34, 322.204, -2.72005, 3.90954, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140711, 23287, 530, 1, 0, 0, -4977.84, 252.817, -8.28688, 2.40855, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140712, 23287, 530, 1, 0, 0, -4981, 267.045, -6.38198, 2.56563, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140713, 23287, 530, 1, 0, 0, -4994.48, 281.776, -3.57802, 2.68781, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140714, 23287, 530, 1, 0, 0, -4959.42, 393.706, -1.01247, 4.5204, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140715, 23287, 530, 1, 0, 0, -5009.96, 296.281, 1.98117, 2.79253, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140716, 23287, 530, 1, 0, 0, -5014.73, 262.624, -1.14193, 2.09439, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140717, 23287, 530, 1, 0, 0, -5011.1, 222.092, -10.5945, 1.81514, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140718, 23287, 530, 1, 0, 0, -5023.84, 241.114, -4.47528, 1.32645, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140719, 23287, 530, 1, 0, 0, -4981.04, 460.073, 4.12424, 0.174533, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140720, 23287, 530, 1, 0, 0, -4937.38, 438.723, 2.25706, 1.29154, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140721, 23287, 530, 1, 0, 0, -4950.46, 451.137, 0.642393, 0.942478, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140722, 23287, 530, 1, 0, 0, -5014.46, 279.322, -0.0181935, 2.35619, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140723, 23287, 530, 1, 0, 0, -5218.99, 222.209, -11.4247, 5.21853, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140724, 23287, 530, 1, 0, 0, -5241.21, 231.772, -12.0143, 5.51524, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140725, 23287, 530, 1, 0, 0, -5178.48, 174.83, -11.5723, 5.34071, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140726, 23287, 530, 1, 0, 0, -5198.48, 157.077, -13.4976, 0.471239, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140727, 23287, 530, 1, 0, 0, -5174.08, 155.275, -12.3164, 6.02139, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140728, 23287, 530, 1, 0, 0, -5229.69, 136.861, -13.717, 0.558505, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140729, 23287, 530, 1, 0, 0, -5189.78, 135.485, -12.1236, 0.680678, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140730, 23287, 530, 1, 0, 0, -5149.46, 152.029, -12.4745, 6.17846, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140731, 23287, 530, 1, 0, 0, -5107.63, 169.443, -8.46992, 0.349066, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140732, 23287, 530, 1, 0, 0, -4926.75, 455.508, 1.44473, 1.39626, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140733, 23287, 530, 1, 0, 0, -4941.03, 469.183, 0.119479, 1.06465, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140734, 23287, 530, 1, 0, 0, -4965.99, 483.219, 4.06074, 0.0349066, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140735, 23287, 530, 1, 0, 0, -4983.62, 632.319, 20.5006, 3.05433, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140736, 23287, 530, 1, 0, 0, -4907.83, 475.566, 0.806803, 2.04204, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140737, 23287, 530, 1, 0, 0, -4991.9, 300.797, -1.38809, 3.28122, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140738, 23287, 530, 1, 0, 0, -4966.65, 279.133, -5.95937, 2.84489, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140739, 23287, 530, 1, 0, 0, -4995.98, 254.496, -4.78231, 2.21657, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140740, 23287, 530, 1, 0, 0, -5220.69, 199.715, -12.8885, 5.95157, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140741, 23287, 530, 1, 0, 0, -5247.15, 212.461, -13.9035, 5.63741, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140742, 23287, 530, 1, 0, 0, -5198.59, 202.205, -13.7189, 5.11381, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140743, 23287, 530, 1, 0, 0, -5090.02, 180.66, -8.38217, 0.349066, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140744, 23287, 530, 1, 0, 0, -5069.87, 170.684, -9.48402, 0.820305, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140745, 23287, 530, 1, 0, 0, -5056.44, 120.819, -17.233, 2.05949, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140746, 23287, 530, 1, 0, 0, -5041.76, 179.201, -14.3201, 0.959931, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140747, 23287, 530, 1, 0, 0, -4944.88, 561.502, 7.55387, 2.09439, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140748, 23287, 530, 1, 0, 0, -4959.94, 591.927, 12.908, 1.98968, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140749, 23287, 530, 1, 0, 0, -4904.56, 530.207, 4.48007, 2.1293, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140750, 23287, 530, 1, 0, 0, -5067.46, 192.511, -8.97754, 0.645772, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140751, 23287, 530, 1, 0, 0, -5009.81, 160.832, -14.804, 2.75762, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140752, 23287, 530, 1, 0, 0, -5044.64, 201.475, -11.9468, 0.872665, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140753, 23287, 530, 1, 0, 0, -4942.41, 582.11, 9.83164, 2.1293, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140754, 23287, 530, 1, 0, 0, -4921.11, 528.473, 6.48531, 2.04204, 300, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (140755, 23289, 530, 1, 0, 0, -5134.8, 703.83, 41.8539, 1.83264, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140755;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140755, 1, -5137.85, 719.541, 44.1389, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 2, -5151.13, 736.399, 46.1113, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 3, -5155.08, 736.686, 46.0196, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 4, -5160.24, 734.224, 45.959, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 5, -5161.19, 731.089, 46.0857, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 6, -5157.77, 724.971, 45.4773, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 7, -5155.89, 719.194, 44.0871, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 8, -5154.6, 713.129, 43.2635, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 9, -5156.23, 698.103, 42.3923, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 10, -5153.76, 691.724, 42.091, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 11, -5154.31, 686.026, 41.3585, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 12, -5157.5, 678.576, 41.0877, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 13, -5132.74, 678.279, 40.2995, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 14, -5129.38, 681.363, 40.0231, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 15, -5123.65, 690.203, 39.0936, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 16, -5125.15, 692.283, 39.5493, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 17, -5129.57, 693.284, 40.5014, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140755, 18, -5134.71, 703.928, 41.8478, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140756, 23289, 530, 1, 0, 0, -5207.63, 621.234, 46.1889, 6.18352, 300, 0, 0, 6986, 0, 0, 2);
SET @GUID := 140756;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140756, 1, -5184.49, 619.616, 41.758, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 2, -5171.27, 617.964, 37.9829, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 3, -5160.24, 623.06, 36.628, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 4, -5149.16, 630.465, 36.1156, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 5, -5142.94, 638.438, 36.3234, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 6, -5140.06, 648.983, 36.8795, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 7, -5140.98, 661.596, 38.8392, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 8, -5152.96, 671.36, 41.2096, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 9, -5158.74, 669.576, 40.7404, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 10, -5158.69, 657.247, 38.5142, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 11, -5163.21, 649.39, 37.2432, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 12, -5170.05, 643.641, 38.1235, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 13, -5186.76, 636.857, 41.7227, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 14, -5199.22, 633.676, 44.6131, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 15, -5211.18, 634.503, 46.3591, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 16, -5221.19, 635.082, 48.383, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 17, -5227.45, 628.726, 48.5577, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 18, -5223, 625.187, 48.1883, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 19, -5216.42, 622.666, 47.4948, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140756, 20, -5206.99, 621.026, 46.1051, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140757, 23102, 530, 1, 0, 0, -2466.61, 4699.98, 155.643, 3.14159, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140758, 23102, 530, 1, 0, 0, -2414.98, 4458.58, 165.725, 4.31056, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140759, 23102, 530, 1, 0, 0, -2432.75, 4458.1, 166.076, 4.31056, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140760, 23102, 530, 1, 0, 0, -2418.7, 4446.77, 165.623, 4.31056, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140761, 23102, 530, 1, 0, 0, -2432.38, 4444.57, 170.177, 4.31056, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140762, 23102, 530, 1, 0, 0, -2423.71, 4453.52, 165.612, 5.42973, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140763, 23102, 530, 1, 0, 0, -2428.66, 4460.05, 166.238, 5.42973, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140764, 23102, 530, 1, 0, 0, -2432.45, 4434.58, 170.862, 5.42973, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140765, 23102, 530, 1, 0, 0, -2426.57, 4437.26, 167.977, 5.42973, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140766, 23102, 530, 1, 0, 0, -2414.89, 4436.77, 163.105, 5.42973, 25, 0, 0, 4120, 0, 0, 0);
INSERT INTO `creature` VALUES (140767, 23102, 530, 1, 0, 0, -2435.68, 4440.87, 171.618, 2.64157, 25, 0, 0, 4120, 0, 0, 0);
-- felmist
INSERT INTO `creature` VALUES (140768, 17407, 530, 1, 0, 0, -3761.0461, 858.0087, 70.5503, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
--
INSERT INTO `creature` VALUES (140769, 21723, 530, 1, 0, 0, -3522.41, 3254.19, 300.692, 0.0237059, 300, 0, 0, 9082, 0, 0, 2);
SET @GUID := 140769;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140769, 1, -3512.91, 3253.65, 298.684, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 2, -3509.42, 3247.42, 297.527, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 3, -3508.96, 3238.18, 291.435, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 4, -3509.74, 3247.4, 297.482, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 5, -3510.9, 3254.41, 298.329, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 6, -3520.29, 3251.55, 300.414, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 7, -3529.47, 3244.12, 301.703, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 8, -3544.26, 3234.75, 303.708, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 9, -3550.47, 3226.39, 307.004, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 10, -3543.36, 3236.64, 303.118, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140769, 11, -3523.98, 3253.32, 300.861, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140770, 21723, 530, 1, 0, 0, -3491.7, 3240.65, 299.471, 5.0402, 300, 0, 0, 9335, 0, 0, 2);
SET @GUID := 140770;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140770, 1, -3491.98, 3230.37, 298.39, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 2, -3499.64, 3217.43, 296.899, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 3, -3490.54, 3233.88, 298.693, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 4, -3497.68, 3253.86, 299.642, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 5, -3499.37, 3269.09, 301.012, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 6, -3501.71, 3273.94, 300.778, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 7, -3498.72, 3268.99, 301.056, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 8, -3498.38, 3254.15, 299.717, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140770, 9, -3491.69, 3241.45, 299.476, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140771, 23376, 530, 1, 0, 0, -5209.09, 621.369, 46.3592, 6.17571, 25, 0, 0, 6986, 0, 0, 0);
-- felmist
INSERT INTO `creature` VALUES (140772, 17407, 530, 1, 0, 0, -3613.8569, 1031.0131, 55.0270, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
--
INSERT INTO `creature` VALUES (140773, 23383, 530, 0, 0, 0, -3712.91, 3802.86, 302.928, 1.58023, 60, 0, 0, 9250, 0, 0, 0); -- needs gameobject 185952 and script extension set to 0 spawn atm
INSERT INTO `creature` VALUES (140774, 23383, 530, 0, 0, 0, -3655.85, 3380.96, 312.994, 0.146884, 60, 0, 0, 9250, 0, 0, 0); -- needs gameobject 185952 and script extension set to 0 spawn atm
--
INSERT INTO `creature` VALUES (140775, 8394, 1, 1, 0, 0, 1746.45, -5861.29, -91.4165, 3.20841, 300, 0, 0, 2762, 3575, 0, 0);
INSERT INTO `creature` VALUES (140776, 8388, 1, 1, 0, 0, 1747.62, -5862.27, -90.9249, 3.17332, 300, 0, 0, 2666, 0, 0, 0);
INSERT INTO `creature` VALUES (140777, 8387, 1, 1, 0, 0, 1747.24, -5859.6, -90.3817, 3.98543, 300, 0, 0, 2766, 0, 0, 0);
INSERT INTO `creature` VALUES (140778, 8389, 1, 1, 0, 0, 1748.87, -5863.46, -90.2665, 2.83088, 300, 0, 0, 2666, 0, 0, 0);
INSERT INTO `creature` VALUES (140779, 8478, 1, 1, 0, 0, 1916.44, -5733.37, 10.1936, 4.10397, 300, 0, 0, 2766, 0, 0, 0);
INSERT INTO `creature` VALUES (140780, 21960, 530, 1, 0, 0, -2751.21, 2229.99, 92.1626, 1.33868, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140781, 21960, 530, 1, 0, 0, -2765.55, 2088.55, 116.126, 3.70597, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140782, 21960, 530, 1, 0, 0, -2739.99, 2067.33, 117.225, 0.902101, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140783, 21960, 530, 1, 0, 0, -2705.6, 2078.71, 117.225, 0.874612, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140784, 21960, 530, 1, 0, 0, -2721.97, 2082.51, 117.225, 2.0814, 120, 10, 0, 6326, 0, 0, 1);
INSERT INTO `creature` VALUES (140785, 23168, 530, 1, 0, 0, -5338.61, -108.45, 72.423, 1.41698, 25, 0, 0, 110700, 0, 0, 2);
SET @GUID := 140785;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX,YYY,ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-5328.1162,-104.7812,75.1846,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-5320.0048,-92.8429,79.9479,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-5321.4868,-73.4671,86.7180,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-5352.0380,-55.1446,86.0051,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-5378.8842,-79.4089,80.1808,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-5369.2763,-120.0324,65.3489,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-5333.4365,-119.7504,68.0895,0,0,0,100,0);
INSERT INTO `creature` VALUES (140786, 21961, 530, 1, 0, 0, -2658.77, 2596.16, 74.9248, 1.60186, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140786;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140786, 1, -2659.69, 2651.55, 74.9249, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140786, 2, -2657.64, 2583.58, 74.9248, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140786, 3, -2656.44, 2522.42, 74.9247, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140786, 4, -2657.94, 2595.53, 74.9249, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140787, 21961, 530, 1, 0, 0, -2625.86, 2635.63, 74.9245, 4.6924, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140787;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140787, 1, -2625.38, 2579.04, 74.9253, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140787, 2, -2626.04, 2510.67, 74.3728, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140787, 3, -2625.81, 2583.72, 74.3143, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140787, 4, -2625.9, 2656.29, 74.1024, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140788, 21961, 530, 1, 0, 0, -2772.78, 2453.67, 93.2794, 4.68452, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140788;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140788, 1, -2773.82, 2358.29, 93.2806, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140788, 2, -2772.54, 2422.19, 93.1891, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140788, 3, -2772.76, 2475.49, 93.2811, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140789, 21961, 530, 1, 0, 0, -2760.04, 2350.47, 93.2792, 1.51701, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140789;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140789, 1, -2758.8, 2427.52, 93.2806, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140789, 2, -2758.14, 2481.77, 92.1622, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140789, 3, -2758.88, 2415.95, 93.2802, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140789, 4, -2760.52, 2350.33, 93.2807, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140790, 21961, 530, 1, 0, 0, -2773.28, 2300.33, 93.2811, 1.59004, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140790;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140790, 1, -2773.85, 2347.28, 93.2807, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140790, 2, -2773.64, 2275.4, 93.2808, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140790, 3, -2773.48, 2210.35, 93.2807, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140790, 4, -2773.34, 2297.05, 93.2818, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140791, 21961, 530, 1, 0, 0, -2759.17, 2207.39, 93.2797, 1.55469, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140791;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140791, 1, -2759.65, 2255.74, 93.2793, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140791, 2, -2760.07, 2296.39, 93.2799, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140791, 3, -2758.84, 2210.07, 93.2805, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140792, 21961, 530, 1, 0, 0, -2708.3, 2129.17, 117.225, 4.66172, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140792;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140792, 1, -2708.38, 2038.33, 117.217, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140792, 2, -2707.46, 2141.53, 117.225, 0,0,0,100,0);
INSERT INTO `creature` VALUES (140793, 21961, 530, 1, 0, 0, -2741.95, 2067.71, 117.225, 1.58216, 120, 0, 0, 69860, 0, 0, 2);
SET @GUID := 140793;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (140793, 1, -2741.15, 2136.83, 116.915, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140793, 2, -2743.13, 2030.68, 116.605, 0,0,0,100,0);
INSERT INTO `waypoint_data` VALUES (140793, 3, -2740.38, 2064.33, 117.225, 0,0,0,100,0);
-- felmist
INSERT INTO `creature` VALUES (140794, 17407, 530, 1, 0, 0, -3052.9536, 650.1656, -7.2665, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140795, 17407, 530, 1, 0, 0, -3269.8420, 652.1217, 8.1650, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140796, 17407, 530, 1, 0, 0, -3278.5371, 989.7410, 42.2720, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140797, 17407, 530, 1, 0, 0, -3280.5190, 1120.9276, 55.5956, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
--
UPDATE `creature` SET `position_x`='375.797', `position_y`='6230.68', `position_z`='22.7942', `orientation`='0.143877' WHERE `guid` = '16800864';
UPDATE `creature` SET `position_x`='283.941', `position_y`='7815.65', `position_z`='27.1572', `orientation`='0.559242' WHERE `guid` = '16800865';
INSERT INTO `creature` VALUES (140798, 18564, 530, 1, 0, 0, 283.941, 7815.65, 27.1572, 0.559242, 300, 0, 0, 5500, 0, 0, 0);
INSERT INTO `creature` VALUES (140799, 18581, 530, 1, 0, 0, 375.797, 6230.68, 22.7942, 0.143877, 300, 0, 0, 4900, 0, 0, 0);
-- felmist
INSERT INTO `creature` VALUES (140800, 17407, 530, 1, 0, 0, -2782.9619, 795.2183, 26.9291, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140801, 17407, 530, 1, 0, 0, -2707.5817, 1605.5360, 3.1457, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140802, 17407, 530, 1, 0, 0, -3393.9355, 1661.2109, 103.9613, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140803, 17407, 530, 1, 0, 0, -4227.9106, 1817.0648, 127.1126, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140804, 17407, 530, 1, 0, 0, -4135.3076, 1656.6524, 95.1784, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
INSERT INTO `creature` VALUES (140805, 17407, 530, 1, 0, 0, -3904.1083, 1651.3642, 88.7646, 1.93206, 3600, 0, 0, 6900, 9070, 0, 0);
--
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

-- Dreadwarden 19744
UPDATE `creature_template` SET `mindmg`='200',`maxdmg`='400',`baseattacktime`='1400',`armor`='4450',`AIName`='EventAI' WHERE `entry` = '19744'; -- 20 61 2000 20
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '19744';
INSERT INTO `creature_ai_scripts` VALUES
('1974401','19744','9','0','100','1','0','5','6000','12000','11','32736','1','0','0','0','0','0','0','0','0','0','Dreadwarden - Cast Mortal Strike'),
('1974402','19744','9','0','100','1','0','25','10000','12000','11','11443','4','32','0','0','0','0','0','0','0','0','Dreadwarden - Cast Cripple');

-- Illidari Jailor 21520
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '21520';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21520';
INSERT INTO `creature_ai_scripts` VALUES
('2152001','21520','9','0','100','1','0','20','14300','28200','11','38051','4','32','0','0','0','0','0','0','0','0','Illidari Jailor - Cast Fel Shackles');

-- Illidari Agonizer 19801
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '19801';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '19801';
INSERT INTO `creature_ai_scripts` VALUES
('1980101','19801','9','0','100','1','0','30','2400','4200','11','36227','1','0','0','0','0','0','0','0','0','0','Illidari Agonizer - Cast Firebolt');

-- Zandras 21827
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '21827';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21827';
INSERT INTO `creature_ai_scripts` VALUES
('2182701','21827','9','0','100','1','0','25','10000','20000','11','38051','4','32','0','0','0','0','0','0','0','0','Illidari Jailor - Cast Fel Shackles');

-- Felboar 21878
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21878';
INSERT INTO `creature_ai_scripts` VALUES
('2187801','21878','9','0','100','1','8','25','12000','18000','11','35570','1','0','0','0','0','0','0','0','0','0','Felboar - Cast Charge');

DELETE FROM `creature_formations` WHERE `leaderguid` IN (76415);
INSERT INTO `creature_formations` VALUES
(76415,76415,100,360,2),
(76415,70887,3,0.7,2),
(76415,70888,3,5.5,2);

SET @GUID := 76415;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2',`spawntimesecs`='180' WHERE `guid` = @GUID;
UPDATE `creature` SET `spawntimesecs`='180' WHERE `guid` IN (70887,70888);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX,YYY,ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3758.9118,1030.6923,91.1329,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3770.7741,1030.9337,93.7164,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3782.2312,1037.8085,93.8334,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3799.7597,1053.7956,93.4925,10000,0,0,100,0),
--
(@GUID,@POINT := @POINT + 1,-3782.2312,1037.8085,93.8334,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3770.7741,1030.9337,93.7164,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3758.9118,1030.6923,91.1329,0,0,0,100,0),
--
(@GUID,@POINT := @POINT + 1,-3745.7802,1035.9519,89.2109,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3738.2658,1041.3862,88.5053,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3732.8200,1052.4451,86.6530,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3733.6257,1070.4434,87.8530,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3733.3320,1087.5629,86.1342,10000,0,0,100,0),
--
(@GUID,@POINT := @POINT + 1,-3738.4565,1101.2872,86.0334,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3741.7067,1107.7178,84.3930,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3747.8779,1116.7993,79.4853,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3759.1835,1125.7387,78.6744,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3772.1791,1127.6865,81.4655,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3780.3295,1125.0867,83.7786,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3791.5642,1113.0164,84.9287,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3802.5644,1101.6862,84.2388,10000,0,0,100,0),
--
(@GUID,@POINT := @POINT + 1,-3791.5642,1113.0164,84.9287,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3780.3295,1125.0867,83.7786,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3772.1791,1127.6865,81.4655,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3759.1835,1125.7387,78.6744,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3747.8779,1116.7993,79.4853,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3741.7067,1107.7178,84.3930,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3738.4565,1101.2872,86.0334,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3733.3320,1087.5629,86.1342,10000,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3733.6257,1070.4434,87.8530,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3732.8200,1052.4451,86.6530,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3738.2658,1041.3862,88.5053,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3745.7802,1035.9519,89.2109,0,0,0,100,0);

UPDATE `creature_addon` SET `path_id`=551779 WHERE `guid` IN (17525, 84633);
SET @GUID := 17525; 
SET @POINT := 0;
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + 1, -3562.36, 277.757, 40.6969, 0, 0, 0, 100, 0),
(@GUID, @POINT := @POINT + 1, -3560.79, 321.866, 37.2202, 0, 0, 0, 100, 0),
(@GUID, @POINT := @POINT + 1, -3556.08, 358.736, 34.205, 0, 0, 0, 100, 0),
(@GUID, @POINT := @POINT + 1, -3557.99, 394.854, 30.6853, 0, 0, 0, 100, 0),
(@GUID,@POINT := @POINT + 1,-3570.0673,420.4542,28.6032,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3559.9160,471.6178,23.3096,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3558.9196,537.6043,16.5752,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3561.7250,609.2359,7.8407,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3561.0568,653.4253,0.7608,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3559.3081,718.3830,-11.9101,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3547.4375,737.0812,-17.4986,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3483.8259,744.0936,-34.5031,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3449.1201,746.9906,-30.9438,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3417.4462, 749.3307, -38.2708,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3380.3178, 752.3899, -32.3898,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3346.9758,758.8504,-27.1043,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3293.9145,766.8486,-21.0801,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3249.9245,784.7351,-18.9703,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3189.8916,779.1128,-20.8030,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3142.7944,814.4816,-18.9685,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3127.0551,868.0310,-19.2874,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3124.6279,891.1821,-13.9304,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3116.2561,978.8806,-8.9606,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3114.2028,1023.7120,1.5768,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3112.1440,1101.9074,21.4688,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3105.6069,1173.0317,25.5522,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3067.3430,1266.2763,8.8893,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3049.4846,1285.4127,14.0953,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3027.9238,1308.4312,8.5150,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2992.5114,1342.2867,9.1775,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2976.0070,1395.8554,13.3927,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2933.6108,1452.8242,13.9511,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2892.8828,1499.4138,15.3848,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2883.3757,1530.5625,21.9156,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2873.1652,1564.2423,15.5285,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2849.5915,1612.9476,14.5550,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2822.6640,1684.9062,22.7327,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2847.2124,1707.2447,31.9952,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2870.7426,1712.0786,37.1462,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2894.4875,1770.3480,50.4121,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2921.7282,1822.7777,70.0533,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2951.3566,1867.0697,91.2290,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-2976.2893,1901.6828,105.0166,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3043.4853,1929.3596,113.0658,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3082.4938,1957.4027,108.4686,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3124.8950,1981.9355,104.5664,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3170.4450,2027.6052,93.9200,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3190.4658,2066.1833,84.8002,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3201.8562,2105.2443,74.7895,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3215.5983,2158.0637,78.2631,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3198.8266,2211.9191,63.3501,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3215.9042,2238.6716,61.4640,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3181.4570,2289.1733,59.5427,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3129.6123,2318.4589,59.8122,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3100.8879,2372.4050,60.4608,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3070.9680,2428.1794,62.8292,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3066.1791,2464.0170,64.9997,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3059.4409,2511.1013,62.8746,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3078.2360,2538.1870,61.7762,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3115.4829,2565.4738,61.7291,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3188.4323,2566.9853,62.9672,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3252.8479,2584.3410,61.6680,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3307.4257,2603.4997,62.9666,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3380.1403,2607.1513,61.9024,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3446.9116,2604.0124,60.8417,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3489.0810,2582.9072,63.1081,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3546.8083,2537.0151,71.8188,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3586.6408,2490.5153,74.9549,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3615.9230,2456.8984,74.9497,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3661.4182,2404.5649,79.4238,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3706.3974,2337.8281,76.3186,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3744.3464,2266.6042,76.6807,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3745.9013,2188.5969,75.5167,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3768.4245,2123.2761,77.6719,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3795.9738,2116.6669,81.7972,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3839.0261,2075.7629,93.1717,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3861.3100,2063.7148,93.9563,0,0,0,100,0),
--
(@GUID,@POINT := @POINT + 1,-3891.9462,2062.0180,94.0931,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3932.9086,2106.9658,95.0181,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3971.1525,2170.3896,105.0582,0,0,0,100,0),
--
(@GUID,@POINT := @POINT + 1,-3932.9086,2106.9658,95.0181,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3891.9462,2062.0180,94.0931,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3861.3100,2063.7148,93.9563,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3800.8610,2025.2998,94.1887,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3789.6965,1988.8480,85.2974,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3810.2771,1968.7325,85.8039,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3841.9997,1902.1363,85.7401,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3852.9604,1818.3240,90.9806,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3868.7915,1785.6900,94.4845,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3906.8317,1754.7072,98.5138,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3966.6062,1720.7399,98.5202,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4044.7983,1645.9534,94.3174,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4055.9350,1600.1495,94.4940,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4055.9519,1568.0187,100.5482,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4056.3239,1529.7514,93.5602,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4054.0600,1463.8737,86.4579,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4053.1074,1369.8171,84.9461,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4046.0747,1336.5170,91.4814,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4038.8063,1302.8571,85.0719,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4036.5764,1257.4493,77.5612,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4054.0915,1200.5660,62.4978,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4049.3486,1178.0878,55.9543,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4033.5600,1160.8664,50.2092,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4004.6640,1145.7778,42.0257,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3965.0881,1091.9371,28.7885,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3930.1103,1038.0045,26.7869,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3908.2058,960.2801,24.4173,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3887.2155,869.9601,17.2988,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3863.9560,807.2733,12.9543,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3847.5961,762.0527,11.7622,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3766.2954,734.2719,11.5756,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3687.1184,705.8120,2.5453,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3602.9697,679.3745,-2.0988,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3561.0568,653.4253,0.7608,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3561.7250,609.2359,7.8407,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3558.9196,537.6043,16.5752,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3559.9160,471.6178,23.3096,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3570.0673,420.4542,28.6032,0,0,0,100,0),
(@GUID, @POINT := @POINT + 1, -3557.99, 394.854, 30.6853, 0, 0, 0, 100, 0),
(@GUID, @POINT := @POINT + 1, -3556.08, 358.736, 34.205, 0, 0, 0, 100, 0),
(@GUID, @POINT := @POINT + 1, -3560.79, 321.866, 37.2202, 0, 0, 0, 100, 0),
(@GUID, @POINT := @POINT + 1, -3562.36, 277.757, 40.6969, 0, 0, 0, 100, 0);
