-- Stonegazer
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 18648; -- 2500

UPDATE `creature_ai_scripts` SET `action1_param1`= 1 WHERE `id` IN (70101, 70106);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1062;
INSERT INTO `creature_ai_scripts` VALUES 
(106201, 1062, 9, 0, 100, 1, 0, 30, 5000, 10000, 11, 421, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nezzliok the Dire - Cast Chain Lightning'),
(106201, 1062, 9, 0, 100, 1, 0, 20, 8000, 16000, 11, 2610, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nezzliok the Dire - Cast Shock');

UPDATE `creature_ai_scripts` SET `action1_param1` = 1 WHERE `action1_type` = 21 AND `action1_param1` = 0 AND `action2_type` = 0 AND `action3_type` = 0 AND `event_type` IN (1, 4, 9);

DELETE FROM `creature` WHERE `guid` = 203341;

