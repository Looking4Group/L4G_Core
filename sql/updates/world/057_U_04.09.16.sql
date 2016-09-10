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
