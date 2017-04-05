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

