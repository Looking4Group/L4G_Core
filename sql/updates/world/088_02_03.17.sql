DELETE FROM `pool_template` WHERE `entry` = 979;
INSERT INTO `pool_template` VALUES (979, 2, 'MASTER Herbs Isle of Quel\'Danas');

DELETE FROM `pool_gameobject` WHERE `guid` IN (14117,14126,14723,20950,20954,27560,27571,27574,28042,28107,28128,28269,28290,28293,28320,28333,28448,28476,30435,32110,32730,32736,32782,
32786,32797,32807,32814,99817,99818,3496292,3496293,3496294,3496295,3496296,3496297,3496301,3505780,14050507,14050508,14050509,14050510,14050516,14050532,14050533,
14050534,14050535,14050536,14050537,14050553,14050555,14050556,14050557,14050558,14050559,14050560,14050561);
INSERT INTO `pool_gameobject` VALUES
(14117, 977, 0, '181272'),
(14126, 977, 0, '181272'),
(14723, 977, 0, '181284'),
(20950, 977, 0, '181272'),
(20954, 977, 0, '181272'),
(27560, 977, 0, '181284'),
(27571, 978, 0, '181272'),
(27574, 978, 0, '181272'),
(28042, 978, 0, '181272'),
(28107, 978, 0, '181272'),
(28128, 978, 0, '181272'),
(28269, 974, 0, '181272'),
(28290, 978, 0, '181272'),
(28293, 978, 0, '181272'),
(28320, 977, 0, '181272'),
(28333, 977, 0, '181284'),
(28448, 976, 0, '181285'),
(28476, 976, 0, '181285'),
(30435, 976, 0, '181285'),
(32110, 972, 0, '181272'),
(32730, 975, 0, '181272'),
(32736, 977, 0, '181284'),
(32782, 974, 0, '181272'),
(32786, 978, 0, '181272'),
(32797, 977, 0, '181284'),
(32807, 974, 0, '181272'),
(32814, 974, 0, '181272'),
(99817, 972, 0, '181285'),
(99818, 972, 0, '181285'),
(3496292, 979, 0, '181281'),
(3496293, 979, 0, '181281'),
(3496294, 979, 0, '181281'),
(3496295, 979, 0, '181280'),
(3496296, 979, 0, '181281'),
(3496297, 979, 0, '181281'),
(3496301, 979, 0, '181281'),
(3505780, 975, 0, '183043'),
(14050507, 977, 0, '181281'),
(14050508, 977, 0, '181281'),
(14050509, 977, 0, '181281'),
(14050510, 977, 0, '181281'),
(14050516, 974, 0, '181279'),
(14050532, 974, 0, '181279'),
(14050533, 974, 0, '181279'),
(14050534, 974, 0, '181279'),
(14050535, 974, 0, '181279'),
(14050536, 974, 0, '181279'),
(14050537, 974, 0, '181279'),
(14050553, 974, 0, '181279'),
(14050555, 974, 0, '181279'),
(14050556, 974, 0, '181279'),
(14050557, 974, 0, '181279'),
(14050558, 974, 0, '181279'),
(14050559, 974, 0, '181279'),
(14050560, 974, 0, '181279'),
(14050561, 974, 0, '181279');

-- Outland Pools

-- MASTER Herbs Hellfire Peninsula zone 3483
UPDATE `pool_template` SET `max_limit`='140' WHERE `entry` = 972; -- 60

-- MASTER Herbs Nagrand zone 3518
UPDATE `pool_template` SET `max_limit`='72' WHERE `entry` = 973; -- 40

-- MASTER Herbs Netherstorm zone 3523
UPDATE `pool_template` SET `max_limit`='80' WHERE `entry` = 974; -- 40

-- MASTER Herbs Zangarmarsh zone 3521
UPDATE `pool_template` SET `max_limit`='188' WHERE `entry` = 975; -- 95

-- MASTER Herbs Shadowmoon Valley zone 3520
UPDATE `pool_template` SET `max_limit`='66' WHERE `entry` = 976; -- 45

-- MASTER Herbs Terokkar Forest zone 3519
UPDATE `pool_template` SET `max_limit`='135' WHERE `entry` = 977; -- 65 

-- MASTER Herbs Blade's Edge Mountains zone 3522
UPDATE `pool_template` SET `max_limit`='68' WHERE `entry` = 978; -- 35

-- MASTER Herbs Isle of Quel\'Danas
UPDATE `pool_template` SET `max_limit`='3' WHERE `entry` = 979; -- 2

-- Mineral Pool - Hellfire Peninsula
UPDATE `pool_template` SET `max_limit`='104' WHERE `entry` = 2062; -- 25

-- Mineral Pool - Zangarmarsh
UPDATE `pool_template` SET `max_limit`='54' WHERE `entry` = 2063; -- 25

-- Mineral Pool - Nagrand
UPDATE `pool_template` SET `max_limit`='102' WHERE `entry` = 2064; -- 25

-- Mineral Pool - Terokkar Forest
UPDATE `pool_template` SET `max_limit`='71' WHERE `entry` = 2065; -- 25

-- Mineral Pool - Netherstorm
UPDATE `pool_template` SET `max_limit`='39' WHERE `entry` = 2066; -- 25

-- Mineral Pool - Blades Edge Mountains
UPDATE `pool_template` SET `max_limit`='53' WHERE `entry` = 2067; -- 25

-- Mineral Pool - Shadowmoon Valley
UPDATE `pool_template` SET `max_limit`='64' WHERE `entry` = 2068; -- 25

-- Master Mineral Pool - Isle of Quel'Danas 
UPDATE `pool_template` SET `max_limit`='3' WHERE `entry` = 2017; -- 2

-- MASTER Cloud Pools
UPDATE `pool_template` SET `max_limit`='15' WHERE `entry` IN (30043,30044,30045,30046); -- 10
UPDATE `creature` SET `spawntimesecs` = 600 WHERE `id` IN (24222,17407); -- 17378,17408 not pooled yet

-- tbc
-- Ragveil 183043, 181275
-- Felweed 183044, 181270
-- Dreaming Glory 183045, 181271, 181272
-- Blindweed 183046 (tbc version)
-- Flame Cap 181276
-- Terocone 181277
-- Ancient Lichen 181278 (only dungeons)
-- Netherbloom 181279(netherstorm)181282(dungeons)
-- Nightmare Vine 181280, 181285
-- Mana Thistle 181281, 181284(flightmount)
-- Nethercite Deposit 185877
-- Netherdust Bush 185881
-- Netherwing Egg 185915 + Netherwing Egg Trap 185600
-- SELECT * FROM `gameobject` WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881) AND `map`=530;
UPDATE `gameobject` SET `spawntimesecs`= 60,`animprogress`= 255 WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181279,181280,181281,181284,181285,185877,185881) AND `map`= 530; -- 2700

UPDATE `creature` SET `position_x` = 2195.8024, `position_y` = 5475.7568, `position_z` = 163.7464, `orientation` = 0.2682,`spawndist`='0',`movementtype`='0' WHERE `guid` = 78947;

DELETE FROM `creature` WHERE `guid` IN (78793,78794,170436);
INSERT INTO `creature` VALUES (78793, 22443, 530, 1, 0, 0, 2227.46, 5484.32, 153.773, 1.15192, 300, 0, 0, 8170, 0, 0, 0);
INSERT INTO `creature` VALUES (78794, 22443, 530, 1, 0, 0, 1931.44, 5330.76, 154.176, 2.86234, 300, 0, 0, 8170, 0, 0, 0);

