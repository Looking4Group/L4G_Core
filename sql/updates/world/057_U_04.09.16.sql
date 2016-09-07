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
