-- Stonegazer
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 18648; -- 2500

UPDATE `creature_ai_scripts` SET `action1_param1`= 1 WHERE `id` IN (70101, 70106);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1062;
INSERT INTO `creature_ai_scripts` VALUES 
(106201, 1062, 9, 0, 100, 1, 0, 30, 5000, 10000, 11, 421, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nezzliok the Dire - Cast Chain Lightning'),
(106201, 1062, 9, 0, 100, 1, 0, 20, 8000, 16000, 11, 2610, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nezzliok the Dire - Cast Shock');

UPDATE `creature_ai_scripts` SET `action1_param1` = 1 WHERE `action1_type` = 21 AND `action1_param1` = 0 AND `action2_type` = 0 AND `action3_type` = 0 AND `event_type` IN (1, 4, 9);

DELETE FROM `creature` WHERE `guid` = 203341;

DELETE FROM `creature_formations` WHERE `leaderguid` IN (12880,12881,12872,12873);
DELETE FROM `creature_formations` WHERE `memberguid` IN (12880,12881,12872,12873);
INSERT INTO `creature_formations` VALUES
(12880,12880,100,360,2),
(12880,12881,100,360,2),
(12880,12872,100,360,2),
(12880,12873,100,360,2);

UPDATE `creature_template` SET `resistance3`='0',`resistance6` = '-1'  WHERE `entry` = 22310;
UPDATE `creature_template` SET `resistance2` = '-1' WHERE `entry` = 22311;

-- Death's Door North Warp-Gate, Death's Door South Warp-Gate 22471,22472
UPDATE `creature_template` SET `dynamicflags` = 8 WHERE `entry` IN (22471,22472);

DELETE FROM `areatrigger_tavern` WHERE `id` = 4265;
INSERT INTO `areatrigger_tavern` VALUES (4265, 'Fairbreeze Village Inn');

DELETE FROM `creature_ai_scripts` WHERE `id` = 1198012;
INSERT INTO `creature_ai_scripts` VALUES ('1198012','11980','1','0','100','0','60000','60000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Zuluhed the Whacked - Despawn OOC');

UPDATE `gameobject` SET `spawntimesecs`= 450,`animprogress`= 255 WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181279,181280,181281,181284,181285,185877,185881) AND `map`= 530; -- 2700

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181555;
UPDATE `gameobject` SET `spawntimesecs` = 450 WHERE `id` = 181555 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181569;
UPDATE `gameobject` SET `spawntimesecs` = 450 WHERE `id` = 181569 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181570;
UPDATE `gameobject` SET `spawntimesecs` = 450 WHERE `id` = 181570 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181556;
UPDATE `gameobject` SET `spawntimesecs` = 450 WHERE `id` = 181556 AND `map` IN (0, 1, 530);

UPDATE `gameobject` SET `animprogress` = 255 WHERE `id` = 181557;
UPDATE `gameobject` SET `spawntimesecs` = 450 WHERE `id` = 181557 AND `map` IN (0, 1, 530);

-- Outland Pools /2
-- MASTER Herbs Hellfire Peninsula zone 3483
UPDATE `pool_template` SET `max_limit`='120' WHERE `entry` = 972; -- 60 -- 140
-- MASTER Herbs Nagrand zone 3518
UPDATE `pool_template` SET `max_limit`='62' WHERE `entry` = 973; -- 40 -- 72
-- MASTER Herbs Netherstorm zone 3523
UPDATE `pool_template` SET `max_limit`='70' WHERE `entry` = 974; -- 40 -- 80
-- MASTER Herbs Zangarmarsh zone 3521
UPDATE `pool_template` SET `max_limit`='188' WHERE `entry` = 975; -- 95 -- 188
-- MASTER Herbs Shadowmoon Valley zone 3520
UPDATE `pool_template` SET `max_limit`='56' WHERE `entry` = 976; -- 45 -- 66
-- MASTER Herbs Terokkar Forest zone 3519
UPDATE `pool_template` SET `max_limit`='115' WHERE `entry` = 977; -- 65 -- 135
-- MASTER Herbs Blade's Edge Mountains zone 3522
UPDATE `pool_template` SET `max_limit`='58' WHERE `entry` = 978; -- 35 -- 68
-- MASTER Herbs Isle of Quel\'Danas
UPDATE `pool_template` SET `max_limit`='3' WHERE `entry` = 979; -- 2 -- 3

-- Mineral Pool - Hellfire Peninsula
UPDATE `pool_template` SET `max_limit`='84' WHERE `entry` = 2062; -- 25 -- 104
-- Mineral Pool - Zangarmarsh
UPDATE `pool_template` SET `max_limit`='44' WHERE `entry` = 2063; -- 25 -- 54
-- Mineral Pool - Nagrand
UPDATE `pool_template` SET `max_limit`='82' WHERE `entry` = 2064; -- 25 -- 102
-- Mineral Pool - Terokkar Forest
UPDATE `pool_template` SET `max_limit`='61' WHERE `entry` = 2065; -- 25 -- 71
-- Mineral Pool - Netherstorm
UPDATE `pool_template` SET `max_limit`='29' WHERE `entry` = 2066; -- 25 -- 39
-- Mineral Pool - Blades Edge Mountains
UPDATE `pool_template` SET `max_limit`='43' WHERE `entry` = 2067; -- 25 -- 53
-- Mineral Pool - Shadowmoon Valley
UPDATE `pool_template` SET `max_limit`='54' WHERE `entry` = 2068; -- 25 -- 64
-- Master Mineral Pool - Isle of Quel'Danas 
UPDATE `pool_template` SET `max_limit`='3' WHERE `entry` = 2017; -- 2 -- 3

