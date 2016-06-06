-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2232/coilfang-serpentshrine-cavern
--
--
-- Texts & Scripts
--
UPDATE `creature_template` SET `mindmg`='8000',`maxdmg`='10000' WHERE `entry` IN ('15550'); -- 
--
-- Spawns
--
--
-- NPC Research
--
-- Coilfang Frenzy 21508
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='500',`maxdmg`='800',`baseattacktime`='1000',`mechanic_immune_mask`='1073741823',`flags_extra`='65536' WHERE `entry` IN ('21508'); -- 1 392 696 2000 0 0
--
-- Coilfang Frenzy Corpse 21689
-- UPDATE `creature_template` SET  WHERE `entry` IN ('21689');
--
-- Visuals & Repos
--
UPDATE `creature` SET `position_x`='29.6855', `position_y`='-923.2489', `position_z`='42.9018', `orientation`='1.5949',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('93814');
--
-- Movement
--
--
-- Linking
--
--
-- Respawn
--
--
-- ssc hydross & lurker trash 45min respawn timer
-- The creatures that lead up to Hydross the Unstable and creatures at the six pumping stations are now on a 2 hour respawn instead of 45 minutes. 
--
UPDATE `creature` SET `spawntimesecs`='2700' WHERE `guid` IN (93853,93828,93851,82953,82961,82917,93848,93850,93852,82956,93832,93849,93847,82958,82957,93845);

-- link to vashj
-- 37951,37987,37991,37989

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (37951,37987,37991,37989);
INSERT INTO `creature_linked_respawn` VALUES
(37951,93814),
(37987,93814),
(37991,93814),
(37989,93814);
--
--
-- Sonstiges
--
--
-- Scarlet Conjuror 4297
UPDATE `creature` SET `id`='4297',`modelid`='0',`curhealth`='2706',`curmana`='5360' WHERE `guid` IN (40141,40135);
UPDATE `creature_addon` SET `bytes0`='2048' WHERE `guid` IN (40141,40135);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('4297');
INSERT INTO `creature_ai_scripts` VALUES
('429701','4297','1','0','100','2','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Prevent Combat Movement on Spawn'),
('429702','4297','1','0','100','2','1000','1000','0','0','11','8985','0','1','0','0','0','0','0','0','0','0','Scarlet Conjuror - Summon Fire Elemental on Spawn'),
('429703','4297','4','0','100','2','0','0','0','0','11','9053','1','0','23','1','0','0','0','0','0','0','Scarlet Conjuror - Cast Fireball and Set Phase 1 on Aggro'),
('429704','4297','9','13','100','3','0','40','3000','4800','11','9053','1','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Cast Fireball (Phase 1)'),
('429705','4297','3','13','100','2','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Scarlet Conjuror - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('429706','4297','9','13','100','2','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Start Combat Movement at 35 Yards (Phase 1)'),
('429707','4297','9','13','100','2','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Prevent Combat Movement at 15 Yards (Phase 1)'),
('429708','4297','9','13','100','2','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Start Combat Movement Below 5 Yards'),
('429709','4297','3','11','100','3','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Set Phase 1 when Mana is above 30% (Phase 2)'),
('429710','4297','2','0','100','2','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Set Phase 3 at 15% HP'),
('429711','4297','2','7','100','2','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Scarlet Conjuror - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('429712','4297','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Scarlet Conjuror - Set Phase to 0 on Evade');
--
-- Fire Elemental 575
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('575');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('575');
INSERT INTO `creature_ai_scripts` VALUES
('57501','575','11','0','100','2','0','0','0','0','11','25035','0','0','0','0','0','0','0','0','0','0','Fire Elemental - Cast Elemental Spawn-in on Spawn');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2243/alterac-valley
--
--

--
-- Horde Side
--
-- Rezz Horde
--
-- 13117
--
-- 10981
--
-- 12053
--
-- 13798
--
-- 12051
--
-- 14282
--
-- 13179
--
-- 14772
--
-- 14773
--
-- 14776
--
-- 14777
--
-- Frostwolf Bowman 13359
UPDATE `creature_template` SET `modelid_A`='13398',`modelid_A2`='13400',`modelid_H`='13398',`modelid_H2`='13400',`minhealth`='10000',`maxhealth`='10142',`rank`='0',`mindmg`='500',`maxdmg`='1000',`attackpower`='0',`baseattacktime`='1400',`minrangedmg`='1000',`maxrangedmg`='2000',`unit_flags`=`unit_flags`|'1 '|'8 '|'64 '|'512 '|'4096'|'32768' WHERE `entry` IN ('13359'); -- 66 137 2000 200 600 uf 4608
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='7' WHERE `creature_id` IN ('13359'); -- 6
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('13359');
INSERT INTO `creature_ai_scripts` VALUES
('1335901','13359','1','0','100','2','0','0','0','0','21','0','0','0','20','0','0','0','23','1','0','0','Frostwolf Bowman - Prevent Combat Movement and Prevent Melee and Set Phase 1 OOC'),
('1335902','13359','9','1','100','3','0','80','2300','3900','11','22121','1','0','40','2','0','0','0','0','0','0','Frostwolf Bowman - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('1335903','13359','7','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Frostwolf Bowman - Set Phase 1 and Set Melee Weapon Model on Evade');
--
-- Neutral Mine
--
-- 10982
--
-- 11603
--
-- 11604
--
-- 11605
--
-- 11677
--
-- Miniboss Horde
--
-- 11947
--
-- Alliance Side
--
-- Trash
--
-- 10990
--
-- 11675
--
-- 11678
--
-- 10986
--
-- Miniboss Alliance
--
-- 11949
--
-- Rezz Alliance
--
-- 13116
--
-- Flag Alliance
--
-- 12050
--
-- Patrol 
--
-- 12127
--
-- 14283
--
-- Tower 
--
-- Stormpike Bowman 13358
UPDATE `creature_template` SET `modelid_A`='13390',`modelid_A2`='13392',`modelid_H`='13390',`modelid_H2`='13392',`mingold`='262',`maxgold`='347',`minhealth`='10000',`maxhealth`='10142',`rank`='0',`mindmg`='500',`maxdmg`='1000',`attackpower`='0',`baseattacktime`='1400',`minrangedmg`='1000',`maxrangedmg`='2000',`unit_flags`=`unit_flags`|'1 '|'8 '|'64 '|'512 '|'4096'|'32768' WHERE `entry` IN ('13358'); -- 65 135 2000 200 600 uf 4608  4500
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='7' WHERE `creature_id` IN ('13358'); -- 6
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('13358');
INSERT INTO `creature_ai_scripts` VALUES
('1335801','13358','1','0','100','2','0','0','0','0','21','0','0','0','20','0','0','0','23','1','0','0','Stormpike Bowman - Prevent Combat Movement and Prevent Melee and Set Phase 1 on Spawn'),
('1335802','13358','9','1','100','3','0','80','2300','3900','11','22121','1','0','40','2','0','0','0','0','0','0','Stormpike Bowman - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('1335803','13358','7','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Stormpike Bowman - Set Phase 1 and Set Melee Weapon Model on Evade');
--
-- Neutral Mine
--
-- 10987
--
-- 11600
--
-- 11602
--
-- 11657
--
-- 12922
--
-- Dun Baldar
--
-- 13797
--
-- 13447
--
-- 14762
--
-- 14763
--
-- 14764
--
-- 14765
--
-- 13816
--
-- Horde Warbringer
UPDATE `creature_template` SET `dynamicflags`='0' WHERE `entry` IN ('15350');
-- Alliance Brigadier General
-- UPDATE `creature_template` SET  WHERE `entry` IN ('15351');
--
UPDATE `creature` SET `position_x`=-4974.69, `position_y`=-885.103, `position_z`=501.627, `orientation`=2.248,`MovementType`=2 WHERE `guid`=134;
--
-- Ortor of Murkblood & Friends
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18204');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18204');
INSERT INTO `creature_ai_scripts` VALUES
(1820403,18204,0,0,100,1,3500,4000,5000,10000,11,32132,4,0,0,0,0,0,0,0,0,0,'Ortor of Murkblood - Cast Tainted Chain Lightning'),
(1820404,18204,9,0,100,1,0,5,16000,19000,11,31981,0,33,29,10,3,0,0,0,0,0,'Ortor of Murkblood - Cast Tainted Earthgrab Totem and Start Ranged Combat Movement');
DELETE FROM `creature` WHERE `guid` IN ('64996','84479');
DELETE FROM `creature_formations` WHERE `leaderguid` IN (84445,64996,84479);
DELETE FROM `creature_formations` WHERE `memberguid` IN (84445,64996,84479);
-- Sunwindpost Corpses
UPDATE `creature` SET `curhealth`='0',`curmana`='0',`DeathState`='1' WHERE `id` IN ('18240');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18240');
INSERT INTO `creature_template_addon` VALUES
(18240,0,0,512,7,4097,65,0,'');
-- trigger npc
UPDATE `creature_template` SET `flags_extra`='130' WHERE `entry` IN ('18840');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/635/nagrand
--
-- ======================================================
-- Texts & Scripts
-- ======================================================
--
-- -9400 - -9499
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9400','-9401','-9402','-9403','-9404','-9405','-9406','-9407','-9408','-9409','-9410','-9411','-9412','-9413','-9414','-9415','-9416','-9417','-9418','-9419');
INSERT INTO `creature_ai_texts` VALUES
(-9400,'Where do you think you\'re going? Kill them all!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'18202 on Aggro'),
(-9401,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9402,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9403,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9404,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9405,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9406,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9407,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9408,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9409,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9410,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9411,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9412,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9413,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9414,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9415,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9416,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9417,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9418,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9419,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter');
--
DELETE FROM `spell_script_target` WHERE `entry` IN ('32087');
INSERT INTO `spell_script_target` VALUES
(32087,1,18215);
--
UPDATE `creature_ai_texts` SET `content_loc3`='In der Leere kann Euch niemand Schreien hören!' WHERE `entry` ='-18684';
--
--
--
--
--
--
-- ======================================================
-- Spawns
-- ======================================================
--
DELETE FROM creature WHERE guid IN (130154,130155,130156,130158,130159,130160,130161,130162,65453);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(130158, 18202, 530, 1, 0, 0, -1681.0676, 8554.2734, -20.7633, 3.3994, 300, 0, 0, 4731, 2790, 0, 0),
(130159, 18202, 530, 1, 0, 0, -1592.6337, 8396.7431, -21.8216, 4.3167, 300, 0, 0, 4731, 2790, 0, 0),
(130160, 18202, 530, 1, 0, 0, -1692.6000, 8515.8115, -22.4287, 3.3876, 300, 0, 0, 4731, 2790, 0, 0),
(130161, 18202, 530, 1, 0, 0, -1681.6245, 8465.6611, -22.3940, 3.0695, 300, 0, 0, 4731, 2790, 0, 0),
(130162, 18202, 530, 1, 0, 0, -1586.4890, 8393.2763, -22.3020, 4.0772, 300, 0, 0, 4731, 2790, 0, 0),
--
(65453, 18215, 530, 1, 0, 0, -1723.6906, 8409.2724, -23.0456, 0.5366, 300, 0, 0, 1, 0, 0, 0),
(130156, 18215, 530, 1, 0, 0,-1634.831543 , 8386.664062 , -23.045870 , 1.1084, 300, 0, 0, 1, 0, 0, 0),
(130155, 18215, 530, 1, 0, 0,-1702.0804 , 8591.1914 , -23.0433, 5.9975, 300, 0, 0, 1, 0, 0, 0),
(130154, 18215, 530, 1, 0, 0,-1605.1492 , 8369.8632 , -23.0337, 1.289, 300, 0, 0, 1, 0, 0, 0);
--
DELETE FROM creature WHERE guid IN (130153,130152,130151,130150,130149,130148,130147,130146,130145,130144,130143,130142,130141,130140,130139,130138,130137,130136,130135,130134,130133);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(130153, 18207, 530, 1, 0, 0, -1627.78, 8518.52, -13.3941, 5.26975, 300, 0, 0, 1000, 6299, 0, 0),
(130152, 18207, 530, 1, 0, 0, -1623.96, 8521.62, -13.3941, 4.72783, 300, 0, 0, 1000, 6299, 0, 0),
(130151, 18207, 530, 1, 0, 0, -1634.98, 8513.87, -13.3941, 0.0167007, 300, 0, 0, 1000, 6299, 0, 0),
-- (130150, 18207, 530, 1, 0, 0, -1438.26, 8532.47, 13.7976, 3.71471, 300, 0, 0, 1000, 6299, 0, 0),
(130149, 18207, 530, 1, 0, 0, -1628.85, 8505.92, -13.3941, 1.10055, 300, 0, 0, 1000, 6299, 0, 0),
-- (130148, 18207, 530, 1, 0, 0, -1619.79, 8511.52, -13.3111, 2.52415, 300, 0, 0, 1000, 6299, 0, 0),
-- (130147, 18207, 530, 1, 0, 0, -1617.17, 8517.14, -13.3111, 3.18328, 300, 0, 0, 1000, 6299, 0, 0),
(130146, 18207, 530, 1, 0, 0, -1588.43, 8465.31, -10.5951, 5.62052, 300, 0, 0, 1000, 6299, 0, 0),
(130145, 18207, 530, 1, 0, 0, -1589.34, 8463.08, -10.3989, 6.15851, 300, 0, 0, 1000, 6299, 0, 0),
(130144, 18207, 530, 1, 0, 0, -1590, 8459.27, -10.1017, 0.0441875, 300, 0, 0, 1000, 6299, 0, 0),
(130143, 18207, 530, 1, 0, 0, -1470.51, 8410.75, 0.17227, 1.64227, 300, 0, 0, 1000, 6299, 0, 0),
(130142, 18207, 530, 1, 0, 0, -1553.08, 8579.5, 7.25886, 3.79446, 300, 0, 0, 1000, 6299, 0, 0),
(130141, 18207, 530, 1, 0, 0, -1550.63, 8577.96, 7.25886, 4.30497, 300, 0, 0, 1000, 6299, 0, 0),
(130140, 18207, 530, 1, 0, 0, -1549.31, 8575.98, 7.25886, 3.28789, 300, 0, 0, 1000, 6299, 0, 0),
(130139, 18207, 530, 1, 0, 0, -1533.62, 8481.93, -4.10242, 5.71476, 300, 0, 0, 1000, 6299, 0, 0),
(130138, 18207, 530, 1, 0, 0, -1530.73, 8484.16, -4.10242, 5.20819, 300, 0, 0, 1000, 6299, 0, 0),
(130137, 18207, 530, 1, 0, 0, -1496.64, 8565.37, 7.26011, 5.34956, 300, 0, 0, 1000, 6299, 0, 0),
(130136, 18207, 530, 1, 0, 0, -1489.77, 8566.64, 7.26014, 6.26062, 300, 0, 0, 1000, 6299, 0, 0),
(130135, 18207, 530, 1, 0, 0, -1492.31, 8573, 7.2602, 5.35349, 300, 0, 0, 1000, 6299, 0, 0),
(130134, 18207, 530, 1, 0, 0, -1463.05, 8405.77, -0.0208871, 2.07424, 300, 0, 0, 1000, 6299, 0, 0),
(130133, 18207, 530, 1, 0, 0, -1476.8, 8417.78, 0.972544, 3.73824, 300, 0, 0, 1000, 6299, 0, 0);
--
-- Sunspring Post (poorly spawned)
DELETE FROM creature WHERE guid IN (130132,130131,130130,130129,130128,130127,130126,130125,130124,130123);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(130132, 18203, 530, 1, 0, 0, -1481.64, 8607.28, 7.26011, 0.248205, 300, 0, 0, 5504, 0, 0, 0),
(130131, 18203, 530, 1, 0, 0, -1515.94, 8590.04, 7.26011, 4.48542, 300, 0, 0, 5504, 0, 0, 0),
(130130, 18203, 530, 1, 0, 0, -1522.72, 8592.33, 7.26011, 4.58359, 300, 0, 0, 5504, 0, 0, 0),
(130129, 18203, 530, 1, 0, 0, -1514.32, 8555.2, 7.26013, 4.56789, 300, 0, 0, 5504, 0, 0, 0),
(130128, 18203, 530, 1, 0, 0, -1530.12, 8555.45, 7.26013, 4.77209, 300, 0, 0, 5504, 0, 0, 0),
(130127, 18203, 530, 1, 0, 0, -1519.91, 8462.62, -4.10237, 2.60731, 300, 0, 0, 5504, 0, 0, 0),
(130126, 18203, 530, 1, 0, 0, -1516.01, 8465.96, -4.10237, 2.60731, 300, 0, 0, 5504, 0, 0, 0),
(130125, 18203, 530, 1, 0, 0, -1532.52, 8459.64, -4.10237, 3.44104, 300, 0, 0, 5504, 0, 0, 0),
(130124, 18203, 530, 1, 0, 0, -1550.52, 8614.9, 7.26015, 2.92659, 300, 0, 0, 5504, 0, 0, 0),
(130123, 18203, 530, 1, 0, 0, -1547.23, 8621.04, 7.26015, 2.25114, 300, 0, 0, 5504, 0, 0, 0);
-- ======================================================
-- NPC Research
-- ======================================================
--
-- Murkblood Putrifier 18202
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18202');
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='5' WHERE `creature_id` IN ('18202'); -- 7
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18202');
INSERT INTO `creature_ai_scripts` VALUES
(1820200,18202,4,0,20,1,0,0,0,0,1,-9400,0,0,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Say on Aggro'),
(1820201,18202,4,0,100,1,0,0,0,0,11,32132,1,1,28,0,32087,0,0,0,0,0,'Murkblood Putrifier - Cast Tainted Chain Lightning Stop Channeling on Aggro'),
(1820202,18202,0,0,100,1,6000,6000,10000,15000,11,32132,1,0,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Tainted Chain Lightning'),
(1820203,18202,0,0,100,1,3000,3000,8000,12000,11,32133,1,33,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Corrupted Earth'),
(1820204,18202,0,0,100,1,8000,8000,16000,18000,11,32134,1,32,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Putrid Cloud IC'),
(1820205,18202,1,0,100,1,10000,30000,300000,360000,11,32087,0,0,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Putrid Cloud OOC');
--
-- Murkblood Target Dummy 18215
UPDATE `creature_template` SET `inhabittype`='7' WHERE `entry` IN ('18215');
--
-- Murkblood Scavenger 18207
UPDATE `creature_template` SET `modelid_A`='17589',`modelid_A2`='17591',`modelid_H`='17589',`modelid_H2`='17591' WHERE `entry` IN ('18207');
--
-- Murkblood Raider 18203
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18203');
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='5' WHERE `creature_id` IN ('18203'); -- 7
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18203');
INSERT INTO `creature_ai_scripts` VALUES
(1820301,18203,0,0,100,1,3500,4000,10000,11000,11,15496,1,0,0,0,0,0,0,0,0,0,'Murkblood Raider - Cast Cleave'),
(1820302,18203,9,0,100,1,0,5,10000,12000,11,11971,1,0,0,0,0,0,0,0,0,0,'Murkblood Raider - Cast Sunder Armor');
--
-- Lebendiger Zyklon 17160
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('17160');
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry` IN (17160);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17160');
INSERT INTO `creature_ai_scripts` VALUES
(1716001,17160,1,0,100,1,1000,1000,300000,300000,11,12550,0,1,0,0,0,0,0,0,0,0,'Living Cyclone - Cast Lightning Shield');
-- (1716002,17160,9,0,100,0,30,40,0,0,11,31705,1,1,0,0,0,0,0,0,0,0,'Living Cyclone - Casts Magnetic Pull on Aggro'); needs reduce EffectMiscValue[0] to 100
--
-- Mo'arg Engineer
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('16945');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16945');
INSERT INTO `creature_ai_scripts` VALUES 
(1694501,16945,9,0,100,0,30,40,0,0,11,31705,1,1,0,0,0,0,0,0,0,0,'Mo\'arg Engineer - Casts Magnetic Pull on Aggro'),
(1694502,16945,0,0,100,1,3000,3000,11000,14000,11,15976,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Engineer - Cast Puncture'),
(1694503,16945,0,0,100,1,6000,6000,14000,16000,11,32005,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Engineer - Cast Thorium Drill');
--
-- Mo'arg Master Planner
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18567');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18567');
INSERT INTO `creature_ai_scripts` VALUES 
(1856701,18567,9,0,100,0,30,40,0,0,11,31705,1,1,0,0,0,0,0,0,0,0,'Mo\'arg Master Planner - Casts Magnetic Pull on Aggro'),
(1856702,18567,0,0,100,1,3000,3000,6000,12000,11,15976,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Master Planner - Cast Puncture'),
(1856703,18567,0,0,100,1,6000,6000,7000,14000,11,32005,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Master Planner - Cast Thorium Drill');
--
-- Gan'arg Tinkerer
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('17151');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17151');
INSERT INTO `creature_ai_scripts` VALUES 
(1715101,17151,0,0,100,1,7500,7500,14000,16000,11,32003,1,0,0,0,0,0,0,0,0,0,'Gan\'arg Tinkerer - Cast Power Burn');
--
-- Xirkos, Overseer of Fear
UPDATE `creature_template` SET `mechanic_immune_mask`='616578131',`speed`='1.20' WHERE `entry` IN ('17151');
--
-- Felguard Legionnaire
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('17152');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17152');
INSERT INTO `creature_ai_scripts` VALUES 
(1715201,17152,0,0,100,1,3000,3000,10000,12000,11,15496,1,0,0,0,0,0,0,0,0,0,'Felguard Legionnaire - Cast Cleave'),
(1715202,17152,0,0,100,1,6000,6000,14000,16000,11,32015,1,0,0,0,0,0,0,0,0,0,'Felguard Legionnaire - Cast Cutdown');
--
-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================
-- 
DELETE FROM creature_addon WHERE guid BETWEEN 130143 AND 130146; -- 4 working emotes
INSERT INTO creature_addon (guid, mount, bytes1, bytes2, emote, moveflags, auras) VALUES 
(130146, 0, 8, 4097, 0, 0, ''),
(130145, 0, 8, 4097, 0, 0, ''),
(130144, 0, 8, 4097, 0, 0, ''),
(130143, 0, 8, 4097, 0, 0, '');
--
-- Murkblood Target Dummy
UPDATE `creature` SET `position_x`='-1679.4619', `position_y`='8368.0117', `position_z`='-23.0451', `orientation`='1.1005',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('65457'); 
-- Murkblood Putrifier
UPDATE `creature` SET `position_x`='-1683.0513', `position_y`='8541.1425', `position_z`='-20.1492', `orientation`='2.7947',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('64994');
UPDATE `creature` SET `position_x`='-1675.9553', `position_y`='8582.8593', `position_z`='-21.6737', `orientation`='2.7577',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('64995');
--
-- movement
SET @NPC := 58969;
SET @PATH := @NPC * 10;  
UPDATE `creature` SET `MovementType`='2' WHERE `guid` IN (58969);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-1802.7333','9222.6181','70.2459',0,0,0,0,0),
(@PATH,2,'-1790.9542','9245.0273','70.9925',0,0,0,0,0),
(@PATH,3,'-1814.1148','9271.6816','72.4065',0,0,0,0,0),
(@PATH,4,'-1847.2919','9250.9648','70.5196',0,0,0,0,0),
(@PATH,5,'-1873.9462','9183.8496','70.2807',0,0,0,0,0),
(@PATH,6,'-1840.0675','9168.8242','71.3096',0,0,0,0,0),
(@PATH,7,'-1805.6177','9189.2480','70.8272',0,0,0,0,0);
-- ======================================================
-- Linking
-- ======================================================
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (58969,60330,60331,60332);
DELETE FROM `creature_formations` WHERE `memberguid` IN (58969,60330,60331,60332);
INSERT INTO `creature_formations` VALUES
(58969,58969,60,360,2),
(58969,60331,3,0,2),
(58969,60332,3,2,2),
(58969,60330,3,4,2);
--
-- ======================================================
-- Respawn
-- ======================================================
--
--
-- ======================================================
-- Gameobjects
-- ======================================================
--
--
-- ======================================================
-- Miscellaneous
-- ======================================================
--
--
--
--
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17942');
INSERT INTO `creature_ai_scripts` VALUES 
('1794201','17942','0','0','100','7','8000','15000','8000','13000','11','40504','1','0','0','0','0','0','0','0','0','0','Quagmirran - Cast Cleave'),
('1794202','17942','9','0','100','7','0','5','8000','15000','11','32055','4','0','0','0','0','0','0','0','0','0','Quagmirran - Cast Uppercut'),
('1794203','17942','0','0','100','3','14800','14800','20000','20000','13','-99','1','0','13','100','4','0','20','0','0','0','Quagmirran  - Reset Threat and Set High Threat Random Target and Stop Melee'),
('1794204','17942','0','0','100','7','15000','15000','20000','20000','11','38153','1','1','20','1','0','0','0','0','0','0','Quagmirran - Cast Acid Spray and Start Melee'),
('1794205','17942','0','0','100','3','6000','12000','12000','15000','11','34780','0','0','0','0','0','0','0','0','0','0','Quagmirran (Normal) - Cast Poison Volley'),
('1794206','17942','0','0','100','5','6000','12000','12000','15000','11','39340','0','0','0','0','0','0','0','0','0','0','Quagmirran (Heroic) - Cast Poison Volley');
--
-- Mutate Fleshlasher spawned by Bloodelves
UPDATE `creature_template` SET `heroic_entry`='21561',`maxhealth`='5300',`armor`='5800',`faction_A`='14',`faction_H`='14',`speed`='1.20',`mindmg`='766',`maxdmg`='1010',`AIName`='EventAI',`mechanic_immune_mask`='283313875' WHERE `entry` IN ('25354');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('25354');
INSERT INTO `creature_ai_scripts` VALUES
('2535401','25354','0','0','100','7','7800','12100','6200','12100','11','34351','1','0','0','0','0','0','0','0','0','0','Mutate Fleshlasher - Cast Vicious Bite'),
('2535402','25354','7','0','100','7','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Mutate Fleshlasher - Despawn on Evade');
--
UPDATE creature SET MovementType = 0, spawndist = 0 WHERE guid = 71424;
-- loch modan
UPDATE creature SET position_x = -5850.31, position_y = -463.224, position_z = 411.103, orientation = 6.11854 WHERE guid = 232;
UPDATE creature SET position_x = -5928.77, position_y = -478.387, position_z = 412.97, orientation = 2.3879 WHERE guid = 3625;
UPDATE creature SET position_x = -5944.88, position_y = -115.987, position_z = 394.331, orientation = 4.00974 WHERE guid = 1575;
-- silverpine forrest
UPDATE creature SET position_x = 1691.98, position_y = 510.147, position_z = 37.6366, orientation = 0.497324 WHERE guid = 45217;
-- azuremist island
UPDATE creature SET position_x = -3314.89, position_y = -12038.7, position_z = 18.6874, orientation = 4.77913 WHERE guid = 62810;
--
DELETE FROM creature WHERE id IN (21446);
--
-- Apex Crumbler should be summoned while fighting with Apex http://www.wowhead.com/?npc=21328#comments, script will follow
DELETE FROM creature WHERE id = 21328;
--
-- Update InhabitType Normal
UPDATE creature_template SET InhabitType = 1 WHERE entry IN (18323, 18318, 19429, 18327, 18328, 18322, 21891, 18319, 19428, 18325, 18321, 21904, 18320, 18326, 18472, 18473, 23035);
-- Update InhabitType Heroic
UPDATE creature_template SET InhabitType = 1 WHERE entry IN (20692, 20693, 20686, 20686, 20694, 20696, 21989, 20697, 20688, 20695, 20701, 21990, 20698, 20699, 20690, 20706);
-- Sethekk Prophet immune MC
UPDATE creature_template SET mechanic_immune_mask = 1 WHERE entry = 20695;
-- Sethekk Talon Lord immune MC
UPDATE creature_template SET mechanic_immune_mask = 1 WHERE entry = 20701;
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/607/schergrat
--
-- ======================================================
-- Texts & Scripts
-- ======================================================
--
-- -9400 - -9499
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9400','-9401','-9402','-9403','-9404','-9405','-9406','-9407','-9408','-9409','-9410','-9411','-9412','-9413','-9414','-9415','-9416','-9417','-9418','-9419');
INSERT INTO `creature_ai_texts` VALUES
(-9400,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9401,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9402,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9403,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9404,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9405,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9406,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9407,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9408,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9409,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9410,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9411,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9412,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9413,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9414,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9415,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9416,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9417,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9418,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter'),
(-9419,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchergartPlatzhalter');
--
--
--
--
--
--
--
-- ======================================================
-- Spawns
-- ======================================================
--
-- Quest Spawned
DELETE FROM creature WHERE id IN (21446);
--
--
--
-- ======================================================
-- NPC Research
-- ======================================================
--
--
-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================
-- 
-- ======================================================
-- Linking
-- ======================================================
--
--
-- ======================================================
-- Respawn
-- ======================================================
--
--
-- ======================================================
-- Gameobjects
-- ======================================================
--
--
-- ======================================================
-- Miscellaneous
-- ======================================================
--
--
--
--
--
-- texts 
-- 
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9910','-9909','-9908','-9907','-9906','-9905','-9904','-9903','-9902','-9901','-9900');
INSERT INTO `creature_ai_texts` VALUES
('-9910','I\'ll crush you!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','Schergrat Ogres on Aggro'),
('-9909','Me smash! You die!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','Schergrat Ogres on Aggro'),
('-9908','Now, proceed to the translocator. Forge Camp Wrath awaits your arrival!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','19747 OCC Summon Event'),
('-9907','You will suffer slowly until the end of time for this affront!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 on Aggro'),
('-9906','Prepare yourself for eternal torture, mortal!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 on Aggro'),
('-9905','I shall enjoy the smell of the grease from your marrow crackling over the fire!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 on Aggro'),
('-9904','Release the hounds!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','1','0','0','19747 IC Summon Event'),
('-9903','Your name is as insignificant to me as the names of the thousands who have died under the might of Goc. I will crush you and $N!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','20555 on Aggro'),
('-9902',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','SCHERGRATCOMMENT'),
('-9901','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','SCHERGRATCOMMENT'),
('-9900',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'0','0','0','0','SCHERGRATCOMMENT');
--
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('21004','20751','20714','21032','22123','21423','20600','20768','20609','20614','20668','21124','21123','16952','19961','19960','21519','19980','21837','21516','20998');
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` IN ('21004','20751','20714','21032','22123','21423','20600','20768','20609','20614','20668','21124','21123','16952','19961','19960','21519','19980','21837','21516','20998');
INSERT INTO `creature_ai_scripts` VALUES
--
-- Lesser Nether Drake
(2100401,21004,0,0,100,1,6000,6000,12000,16000,11,36513,0,1,0,0,0,0,0,0,0,0,'Lesser Nether Drake - Casts Intangible Presence'),
--
-- Daggermaw Lashtail
(2075101,20751,4,0,100,0,0,0,0,0,11,35570,1,0,0,0,0,0,0,0,0,0,'Daggermaw Lashtail - Casts Mighty Charge on Aggro'),
(2075102,20751,0,0,100,1,3500,4000,10000,11000,11,7367,1,0,0,0,0,0,0,0,0,0,'Daggermaw Lashtail - Casts Infected Bite'),
--
-- Ridgespine Stalker
(2071401,20714,0,0,100,1,3500,4000,10000,11000,11,744,1,0,0,0,0,0,0,0,0,0,'Ridgespine Stalker - Casts Poison'),
(2071402,20714,1,0,100,0,1000,1000,0,0,11,22766,0,7,0,0,0,0,0,0,0,0,'Ridgespine Stalker - Cast Stealth'),
(2071403,20714,4,0,100,0,0,0,0,0,28,0,22766,0,0,0,0,0,0,0,0,0,'Ridgespine Stalker - Remove Stealth on Aggro'),
--
-- Ridgespine Horror
(2099801,20998,0,0,100,1,3500,4000,10000,11000,11,7951,1,0,0,0,0,0,0,0,0,0,'Ridgespine Horror - Casts Toxic Spit'),
(2099802,20998,0,0,100,1,6000,6000,12000,16000,11,745,1,0,0,0,0,0,0,0,0,0,'Ridgespine Horror - Casts Threatening Web'),
(2099803,20998,1,0,100,0,1000,1000,0,0,11,22766,0,7,0,0,0,0,0,0,0,0,'Ridgespine Horror - Cast Stealth'),
(2099804,20998,4,0,100,0,0,0,0,0,28,0,22766,0,0,0,0,0,0,0,0,0,'Ridgespine Horror - Remove Stealth on Aggro'),
--
(2103201,21032,0,0,100,1,6000,6000,14000,14000,11,36631,0,0,0,0,0,0,0,0,0,0,'Dreadwing - Casts Netherbreath'),
(2212301,22123,0,0,100,1,3500,4000,10000,11000,11,3242,1,0,0,0,0,0,0,0,0,0,'Rip-Blade Ravager - Casts Ravage'),
(2142301,21423,0,0,100,1,3000,3000,14000,15000,11,13443,1,0,0,0,0,0,0,0,0,0,'Gore-Scythe Ravager - Casts Rend'),
--
-- Maggoc <Son of Gruul>
(2060001,20600,2,0,100,0,30,0,0,0,11,40743,0,1,1,-106,0,0,0,0,0,0,'Maggoc - Casts Frenzy at 30% HP'),
(2060002,20600,6,0,100,0,0,0,0,0,11,39891,0,7,0,0,0,0,0,0,0,0,'Maggoc - Summon Maggoc Treasure Chest on Death'),
(2060003,20600,9,0,100,1,5,30,5000,5000,11,42139,4,1,0,0,0,0,0,0,0,0,'Maggoc  - Casts Boulder on Aggro'),
(2060004,20600,9,0,100,1,0,5,5000,10000,11,38770,1,1,0,0,0,0,0,0,0,0,'Maggoc - Casts Mortal Wound'),
(2060005,20600,0,0,100,1,5000,5000,10000,15000,11,38777,4,1,0,0,0,0,0,0,0,0,'Maggoc - Rock Rumble'),
--

(2076801,20768,0,0,100,1,6000,6000,12000,16000,11,37597,1,0,0,0,0,0,0,0,0,0,'Gnosh Brognat - Casts Meat Slap'),
(2076802,20768,0,0,100,1,2500,5500,10000,11000,11,37596,1,0,0,0,0,0,0,0,0,0,'Gnosh Brognat - Casts Tenderize'),
(2060901,20609,0,0,100,1,6000,6000,12000,16000,11,36513,0,1,0,0,0,0,0,0,0,0,'Razaani Nexus Stalker - Casts Intangible Presence'),
(2060902,20609,0,0,100,1,6000,6000,12000,16000,11,11975,0,0,0,0,0,0,0,0,0,0,'Razaani Nexus Stalker - Casts Arcane Explosion'),
(2061401,20614,0,0,100,1,2500,5500,10000,11000,11,36508,1,1,0,0,0,0,0,0,0,0,'Razaani Spell-Thief - Casts Energy Surge'),
(2066801,20668,11,0,100,0,0,0,0,0,11,37816,0,0,0,0,0,0,0,0,0,0,'Fiendling Flesh Beast - Shadowform'),
(2112401,21124,4,0,100,0,0,0,0,0,11,35570,1,0,0,0,0,0,0,0,0,0,'Felsworn Daggermaw - Casts Chaos Charge on Aggro'),
(2112402,21124,0,0,100,1,2500,5500,10000,11000,11,7367,1,0,0,0,0,0,0,0,0,0,'Felsworn Daggermaw - Casts Infected Bite'),
(2112301,21123,0,0,100,1,3000,3000,14000,15000,11,32093,1,0,0,0,0,0,0,0,0,0,'Felsworn Scalewing - Casts Poison Spit'),
(1695201,16952,4,0,100,0,0,0,0,0,11,22911,1,0,0,0,0,0,0,0,0,0,'Anger Guard - Casts Charge'),
(1695202,16952,0,0,100,1,3500,5500,10000,11000,11,15496,1,0,0,0,0,0,0,0,0,0,'Anger Guard - Casts Cleave'),
(1996101,19961,0,0,100,1,8000,9000,16000,16000,11,36846,0,0,0,0,0,0,0,0,0,0,'Deathforge Over-Smith - Casts Mana Bomb'),
(1996102,19961,0,0,100,1,6000,6000,10000,15000,11,36208,1,1,0,0,0,0,0,0,0,0,'Deathforge Technician - Steal Weapon'),
(1996001,19960,0,0,100,1,8000,9000,16000,16000,11,36253,0,0,0,0,0,0,0,0,0,0,'Doomforge Engineer - Casts Chemical Flames'),
(1996002,19960,0,0,100,1,6000,6000,10000,15000,11,36251,0,0,0,0,0,0,0,0,0,0,'Doomforge Engineer - Hammer Slam'),
(2151901,21519,0,0,100,1,3500,4000,10000,11000,11,15496,1,0,0,0,0,0,0,0,0,0,'Deaths Might - Casts Cleave'),
(2151902,21519,0,0,100,1,6000,6000,14000,15000,11,32736,1,0,0,0,0,0,0,0,0,0,'Deaths Might - Casts Mortal Strike'),
(1998001,19980,0,0,100,1,5500,5500,14000,15000,11,36406,0,0,0,0,0,0,0,0,0,0,'Void Terror - Casts Double Breath'),
(1998002,19980,0,0,100,1,3500,4000,10000,11000,11,36405,0,0,0,0,0,0,0,0,0,0,'Void Terror - Casts Stomp'),
(2183701,21837,4,0,100,0,0,0,0,0,11,22911,1,0,0,0,0,0,0,0,0,0,'Summoned Wrath Hound - Cast Threshalisk Charge on Aggro'),
(2183702,21837,0,0,100,1,6000,8000,14000,16000,11,36406,0,0,0,0,0,0,0,0,0,0,'Summoned Wrath Hound - Casts Double Breath'),
(2151601,21516,0,0,100,1,3500,4000,10000,11000,11,37621,1,1,0,0,0,0,0,0,0,0,'Death Watch - Casts Mind Flay'),
(2151602,21516,0,0,100,1,6000,6000,14000,15000,11,36398,1,0,0,0,0,0,0,0,0,0,'Death Watch - Casts Tongue Lash');
--
-- Sons of Gruul Immunities
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423' WHERE `entry` IN ('20555','21514','20600','22199','22910','18411');
UPDATE `creature_template` SET `mechanic_immune_mask`='787430911' WHERE `entry` IN ('20216'); -- grulloc sleep for quest
--
-- visual fledermaus
UPDATE `creature_template` SET `inhabittype`='5' WHERE `entry` IN ('22040');

--
-- movement
-- movement 73833
SET @NPC := 73833;
SET @PATH := @NPC * 10;  
UPDATE `creature` SET `MovementType`='2' WHERE `guid` IN (73833);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'1560.0057','6814.2592','125.9330',0,0,0,100,0),
(@PATH,2,'1543.2507','6807.8037','122.9554',10000,0,0,100,0),
(@PATH,3,'1560.0057','6814.2592','125.9330',0,0,0,100,0),
(@PATH,4,'1583.1910','6824.8935','128.4384',0,0,0,100,0),
(@PATH,5,'1615.6489','6820.9194','130.5220',0,0,0,100,0),
(@PATH,6,'1643.9464','6811.3750','132.1697',0,0,0,100,0),
(@PATH,7,'1669.6838','6812.7114','134.3553',0,0,0,100,0),
(@PATH,8,'1705.7690','6828.5761','136.0150',0,0,0,100,0),
(@PATH,9,'1770.1423','6807.6308','137.2133',0,0,0,100,0),
(@PATH,10,'1796.1015','6806.2011','137.3799',0,0,0,100,0),
(@PATH,11,'1866.7496','6828.6577','143.4973',0,0,0,100,0),
(@PATH,12,'1921.3824','6837.2202','149.3398',0,0,0,100,0),
(@PATH,13,'1918.1480','6836.7924','148.6411',10000,0,0,100,0),
(@PATH,14,'1866.7496','6828.6577','143.4973',0,0,0,100,0),
(@PATH,15,'1796.1015','6806.2011','137.3799',0,0,0,100,0),
(@PATH,16,'1770.1423','6807.6308','137.2133',0,0,0,100,0),
(@PATH,17,'1705.7690','6828.5761','136.0150',0,0,0,100,0),
(@PATH,18,'1669.6838','6812.7114','134.3553',0,0,0,100,0),
(@PATH,19,'1643.9464','6811.3750','132.1697',0,0,0,100,0),
(@PATH,20,'1615.6489','6820.9194','130.5220',0,0,0,100,0),
(@PATH,21,'1583.1910','6824.8935','128.4384',0,0,0,0,0);
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,0,0),
--

-- blade\'s edge
UPDATE creature SET MovementType = 0, spawndist = 0 WHERE guid = 71424;
UPDATE creature SET position_x = 3732.81, position_y = 4810.64, position_z = 250.242, orientation = 3.94357 WHERE guid = 72651;
UPDATE creature SET position_x = 1567.21, position_y = 6300.45, position_z = 3.92716, orientation = 1.57909 WHERE guid = 71174;
UPDATE creature SET position_x = 3482.38, position_y = 5011.42, position_z = 265.417, orientation = 4.52083 WHERE guid = 73675;
UPDATE creature SET position_x = 5006.45, position_y = 5006.45, position_z = 265.857, orientation = 4.21061 WHERE guid = 73673;
-- UPDATE creature SET orientation = 0.955641 WHERE guid = 77873;
UPDATE creature SET position_x = 3828.99, position_y = 6659.73, position_z = 169.658, orientation = 5.54995, MovementType = 0 WHERE guid = 71356;
-- UPDATE creature SET position_x = 3778.11, position_y = 6706.03, position_z = 138.19, orientation = 2.89689 WHERE guid = 71355;
UPDATE creature SET position_x = 3775.24, position_y = 6719.76, position_z = 137.539, orientation = 3.8433 WHERE guid = 71332;
UPDATE creature SET position_x = 3789.1, position_y = 6649.72, position_z = 159.939, orientation = 3.73333 WHERE guid = 71354;
--
DELETE FROM `creature` WHERE `guid` IN (49590,49591);
INSERT INTO creature (guid, id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
('49590','17103','0','1','16854','0','-8442.97','325.454','122.246','1.93731','180','0','0','1','0','0','0'),
('49591','24729','0','1','344','0','-8408.96','490.48','124.058','1.84221','180','5','0','1','0','0','1');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/635/nagrand
--
-- ======================================================
-- Texts & Scripts
-- ======================================================
--
-- -9300 - -9399
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9300','-9301','-9302','-9303','-9304','-9305','-9306','-9307','-9308','-9309','-9310','-9311','-9312','-9313','-9314','-9315','-9316','-9317','-9318','-9319');
INSERT INTO `creature_ai_texts` VALUES
(-9300,'Where do you think you\'re going? Kill them all!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'18202 on Aggro'),
(-9301,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9302,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9303,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9304,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9305,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9306,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9307,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9308,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9309,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9310,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9311,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9312,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9313,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9314,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9315,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9316,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9317,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9318,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter'),
(-9319,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'NagrandPlatzhalter');
--
DELETE FROM `spell_script_target` WHERE `entry` IN ('32087');
INSERT INTO `spell_script_target` VALUES
(32087,1,18215);
--
UPDATE `creature_ai_texts` SET `content_loc3`='In der Leere kann Euch niemand Schreien hören!' WHERE `entry` ='-18684';
--
--
--
--
--
--
-- ======================================================
-- Spawns
-- ======================================================
--
DELETE FROM creature WHERE guid IN (130154,130155,130156,130158,130159,130160,130161,130162,65453);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(130158, 18202, 530, 1, 0, 0, -1681.0676, 8554.2734, -20.7633, 3.3994, 300, 0, 0, 4731, 2790, 0, 0),
(130159, 18202, 530, 1, 0, 0, -1592.6337, 8396.7431, -21.8216, 4.3167, 300, 0, 0, 4731, 2790, 0, 0),
(130160, 18202, 530, 1, 0, 0, -1692.6000, 8515.8115, -22.4287, 3.3876, 300, 0, 0, 4731, 2790, 0, 0),
(130161, 18202, 530, 1, 0, 0, -1681.6245, 8465.6611, -22.3940, 3.0695, 300, 0, 0, 4731, 2790, 0, 0),
(130162, 18202, 530, 1, 0, 0, -1586.4890, 8393.2763, -22.3020, 4.0772, 300, 0, 0, 4731, 2790, 0, 0),
--
(65453, 18215, 530, 1, 0, 0, -1723.6906, 8409.2724, -23.0456, 0.5366, 300, 0, 0, 1, 0, 0, 0),
(130156, 18215, 530, 1, 0, 0,-1634.831543 , 8386.664062 , -23.045870 , 1.1084, 300, 0, 0, 1, 0, 0, 0),
(130155, 18215, 530, 1, 0, 0,-1702.0804 , 8591.1914 , -23.0433, 5.9975, 300, 0, 0, 1, 0, 0, 0),
(130154, 18215, 530, 1, 0, 0,-1605.1492 , 8369.8632 , -23.0337, 1.289, 300, 0, 0, 1, 0, 0, 0);
--
DELETE FROM creature WHERE guid IN (130153,130152,130151,130150,130149,130148,130147,130146,130145,130144,130143,130142,130141,130140,130139,130138,130137,130136,130135,130134,130133);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(130153, 18207, 530, 1, 0, 0, -1627.78, 8518.52, -13.3941, 5.26975, 300, 0, 0, 1000, 6299, 0, 0),
(130152, 18207, 530, 1, 0, 0, -1623.96, 8521.62, -13.3941, 4.72783, 300, 0, 0, 1000, 6299, 0, 0),
(130151, 18207, 530, 1, 0, 0, -1634.98, 8513.87, -13.3941, 0.0167007, 300, 0, 0, 1000, 6299, 0, 0),
-- (130150, 18207, 530, 1, 0, 0, -1438.26, 8532.47, 13.7976, 3.71471, 300, 0, 0, 1000, 6299, 0, 0),
(130149, 18207, 530, 1, 0, 0, -1628.85, 8505.92, -13.3941, 1.10055, 300, 0, 0, 1000, 6299, 0, 0),
-- (130148, 18207, 530, 1, 0, 0, -1619.79, 8511.52, -13.3111, 2.52415, 300, 0, 0, 1000, 6299, 0, 0),
-- (130147, 18207, 530, 1, 0, 0, -1617.17, 8517.14, -13.3111, 3.18328, 300, 0, 0, 1000, 6299, 0, 0),
(130146, 18207, 530, 1, 0, 0, -1588.43, 8465.31, -10.5951, 5.62052, 300, 0, 0, 1000, 6299, 0, 0),
(130145, 18207, 530, 1, 0, 0, -1589.34, 8463.08, -10.3989, 6.15851, 300, 0, 0, 1000, 6299, 0, 0),
(130144, 18207, 530, 1, 0, 0, -1590, 8459.27, -10.1017, 0.0441875, 300, 0, 0, 1000, 6299, 0, 0),
(130143, 18207, 530, 1, 0, 0, -1470.51, 8410.75, 0.17227, 1.64227, 300, 0, 0, 1000, 6299, 0, 0),
(130142, 18207, 530, 1, 0, 0, -1553.08, 8579.5, 7.25886, 3.79446, 300, 0, 0, 1000, 6299, 0, 0),
(130141, 18207, 530, 1, 0, 0, -1550.63, 8577.96, 7.25886, 4.30497, 300, 0, 0, 1000, 6299, 0, 0),
(130140, 18207, 530, 1, 0, 0, -1549.31, 8575.98, 7.25886, 3.28789, 300, 0, 0, 1000, 6299, 0, 0),
(130139, 18207, 530, 1, 0, 0, -1533.62, 8481.93, -4.10242, 5.71476, 300, 0, 0, 1000, 6299, 0, 0),
(130138, 18207, 530, 1, 0, 0, -1530.73, 8484.16, -4.10242, 5.20819, 300, 0, 0, 1000, 6299, 0, 0),
(130137, 18207, 530, 1, 0, 0, -1496.64, 8565.37, 7.26011, 5.34956, 300, 0, 0, 1000, 6299, 0, 0),
(130136, 18207, 530, 1, 0, 0, -1489.77, 8566.64, 7.26014, 6.26062, 300, 0, 0, 1000, 6299, 0, 0),
(130135, 18207, 530, 1, 0, 0, -1492.31, 8573, 7.2602, 5.35349, 300, 0, 0, 1000, 6299, 0, 0),
(130134, 18207, 530, 1, 0, 0, -1463.05, 8405.77, -0.0208871, 2.07424, 300, 0, 0, 1000, 6299, 0, 0),
(130133, 18207, 530, 1, 0, 0, -1476.8, 8417.78, 0.972544, 3.73824, 300, 0, 0, 1000, 6299, 0, 0);
--
-- Sunspring Post (poorly spawned)
DELETE FROM creature WHERE guid IN (130132,130131,130130,130129,130128,130127,130126,130125,130124,130123);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(130132, 18203, 530, 1, 0, 0, -1481.64, 8607.28, 7.26011, 0.248205, 300, 0, 0, 5504, 0, 0, 0),
(130131, 18203, 530, 1, 0, 0, -1515.94, 8590.04, 7.26011, 4.48542, 300, 0, 0, 5504, 0, 0, 0),
(130130, 18203, 530, 1, 0, 0, -1522.72, 8592.33, 7.26011, 4.58359, 300, 0, 0, 5504, 0, 0, 0),
(130129, 18203, 530, 1, 0, 0, -1514.32, 8555.2, 7.26013, 4.56789, 300, 0, 0, 5504, 0, 0, 0),
(130128, 18203, 530, 1, 0, 0, -1530.12, 8555.45, 7.26013, 4.77209, 300, 0, 0, 5504, 0, 0, 0),
(130127, 18203, 530, 1, 0, 0, -1519.91, 8462.62, -4.10237, 2.60731, 300, 0, 0, 5504, 0, 0, 0),
(130126, 18203, 530, 1, 0, 0, -1516.01, 8465.96, -4.10237, 2.60731, 300, 0, 0, 5504, 0, 0, 0),
(130125, 18203, 530, 1, 0, 0, -1532.52, 8459.64, -4.10237, 3.44104, 300, 0, 0, 5504, 0, 0, 0),
(130124, 18203, 530, 1, 0, 0, -1550.52, 8614.9, 7.26015, 2.92659, 300, 0, 0, 5504, 0, 0, 0),
(130123, 18203, 530, 1, 0, 0, -1547.23, 8621.04, 7.26015, 2.25114, 300, 0, 0, 5504, 0, 0, 0);
--
-- ceremonial circle should be 4 kneeling hexers with aura, needed to be added 
DELETE FROM creature WHERE guid IN (60211,130122,130121,130120,130119);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(60211, 17147, 530, 1, 0, 0, -2852.6, 6441.05, 82.7555, 4.71239, 300, 0, 0, 4731, 2790, 0, 0),
(130122, 17147, 530, 1, 0, 0, -2892.94, 6395.3, 81.9097, 2.35308, 300, 0, 0, 4731, 2790, 0, 0),
(130121, 17147, 530, 1, 0, 0, -2892.44, 6405.05, 81.9117, 3.88674, 300, 0, 0, 4731, 2790, 0, 0),
(130120, 17147, 530, 1, 0, 0, -2902.1, 6405.04, 81.9079, 5.46145, 300, 0, 0, 4731, 2790, 0, 0),
(130119, 17147, 530, 1, 0, 0, -2902.6, 6395.39, 81.9079, 0.705869, 300, 0, 0, 4731, 2790, 0, 0);
DELETE FROM creature_addon WHERE guid BETWEEN 130119 AND 130122;
INSERT INTO creature_addon (guid, mount, bytes1, bytes2, emote, moveflags, auras) VALUES 
(130122, 0, 8, 4097, 0, 0, '16592 0'),
(130121, 0, 8, 4097, 0, 0, '16592 0'),
(130120, 0, 8, 4097, 0, 0, '16592 0'),
(130119, 0, 8, 4097, 0, 0, '16592 0');
--
--
--
-- kil\'sorge, some guards missing at the entrances
DELETE FROM creature WHERE guid IN (130118,130117,130116,130115,130114,130113,130112,130111,130110,130109,130108,60243,60245);
INSERT INTO creature (guid,id,map,spawnMask,modelid,equipment_id,position_x,position_y,position_z,orientation,spawntimesecs,spawndist,currentwaypoint,curhealth,curmana,DeathState,MovementType) VALUES
(130118, 17148, 530, 1, 0, 0, -2897.67, 6438.67, 82.4528, 4.5993, 300, 0, 0, 5914, 0, 0, 0),
-- (130117, 17148, 530, 1, 0, 0, -2865.39, 6399.41, 80.6548, 0.117942, 300, 0, 0, 5914, 0, 0, 0),
-- (130116, 17148, 530, 1, 0, 0, -2773.41, 6425.3, 59.0218, 5.8324, 300, 0, 0, 5914, 0, 0, 0),
-- (130115, 17148, 530, 1, 0, 0, -2771.53, 6434.06, 58.5206, 6.13477, 300, 0, 0, 5914, 0, 0, 0),
(60243, 17148, 530, 1, 0, 0, -2879.42, 6297.64, 83.0126, 1.01229, 300, 0, 0, 5914, 0, 0, 0),
(60245, 17148, 530, 1, 0, 0, -3006.67, 6359.98, 96.4121, 0.296706, 300, 0, 0, 5914, 0, 0, 0),
(130114, 17148, 530, 1, 0, 0, -2892.3842, 6480.7119, 101.5106, 4.6447, 300, 0, 0, 5914, 0, 0, 0),
(130113, 17148, 530, 1, 0, 0, -2910.22, 6473.03, 82.4898, 2.49669, 300, 0, 0, 5914, 0, 0, 0),
-- (130112, 17148, 530, 1, 0, 0, -2910.22, 6473.03, 82.4898, 2.49669, 300, 0, 0, 5914, 0, 0, 0),
(130111, 17148, 530, 1, 0, 0, -2874.23, 6467.19, 82.6466, 0.305419, 300, 0, 0, 5914, 0, 0, 0),
(130110, 17148, 530, 1, 0, 0, -2811.58, 6452.9, 63.4576, 2.79895, 300, 0, 0, 5914, 0, 0, 0),
(130109, 17148, 530, 1, 0, 0, -2848.85, 6509.37, 60.8635, 2.4573, 300, 0, 0, 5914, 0, 0, 0),
(130108, 17148, 530, 1, 0, 0, -2797.13, 6442.84, 63.4026, 5.72848, 300, 0, 0, 5914, 0, 0, 0);
--
--
--
-- ======================================================
-- NPC Research
-- ======================================================
--
-- Murkblood Putrifier 18202
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18202');
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='5' WHERE `creature_id` IN ('18202'); -- 7
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18202');
INSERT INTO `creature_ai_scripts` VALUES
(1820200,18202,4,0,20,1,0,0,0,0,1,-9300,0,0,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Say on Aggro'),
(1820201,18202,4,0,100,1,0,0,0,0,11,32132,1,1,28,0,32087,0,0,0,0,0,'Murkblood Putrifier - Cast Tainted Chain Lightning Stop Channeling on Aggro'),
(1820202,18202,0,0,100,1,6000,6000,10000,15000,11,32132,1,0,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Tainted Chain Lightning'),
(1820203,18202,0,0,100,1,3000,3000,8000,12000,11,32133,1,33,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Corrupted Earth'),
(1820204,18202,0,0,100,1,8000,8000,16000,18000,11,32134,1,32,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Putrid Cloud IC'),
(1820205,18202,1,0,100,1,10000,30000,300000,360000,11,32087,0,0,0,0,0,0,0,0,0,0,'Murkblood Putrifier - Cast Putrid Cloud OOC');
--
-- Murkblood Target Dummy 18215
UPDATE `creature_template` SET `inhabittype`='7' WHERE `entry` IN ('18215');
--
-- Murkblood Scavenger 18207
UPDATE `creature_template` SET `modelid_A`='17589',`modelid_A2`='17591',`modelid_H`='17589',`modelid_H2`='17591' WHERE `entry` IN ('18207');
--
-- Murkblood Raider 18203
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18203');
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='5' WHERE `creature_id` IN ('18203'); -- 7
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18203');
INSERT INTO `creature_ai_scripts` VALUES
(1820301,18203,0,0,100,1,3500,4000,10000,11000,11,15496,1,0,0,0,0,0,0,0,0,0,'Murkblood Raider - Cast Cleave'),
(1820302,18203,9,0,100,1,0,5,10000,12000,11,11971,1,0,0,0,0,0,0,0,0,0,'Murkblood Raider - Cast Sunder Armor');
--
-- Lebendiger Zyklon 17160
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('17160');
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry` IN (17160);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17160');
INSERT INTO `creature_ai_scripts` VALUES
(1716001,17160,1,0,100,1,1000,1000,300000,300000,11,12550,0,1,0,0,0,0,0,0,0,0,'Living Cyclone - Cast Lightning Shield');
-- (1716002,17160,9,0,100,0,30,40,0,0,11,31705,1,1,0,0,0,0,0,0,0,0,'Living Cyclone - Casts Magnetic Pull on Aggro'); needs reduce EffectMiscValue[0] to 100
--
-- Mo'arg Engineer
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('16945');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16945');
INSERT INTO `creature_ai_scripts` VALUES 
(1694501,16945,9,0,100,0,30,40,0,0,11,31705,1,1,0,0,0,0,0,0,0,0,'Mo\'arg Engineer - Casts Magnetic Pull on Aggro'),
(1694502,16945,0,0,100,1,3000,3000,11000,14000,11,15976,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Engineer - Cast Puncture'),
(1694503,16945,0,0,100,1,6000,6000,14000,16000,11,32005,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Engineer - Cast Thorium Drill');
--
-- Mo'arg Master Planner
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18567');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18567');
INSERT INTO `creature_ai_scripts` VALUES 
(1856701,18567,9,0,100,0,30,40,0,0,11,31705,1,1,0,0,0,0,0,0,0,0,'Mo\'arg Master Planner - Casts Magnetic Pull on Aggro'),
(1856702,18567,0,0,100,1,3000,3000,6000,12000,11,15976,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Master Planner - Cast Puncture'),
(1856703,18567,0,0,100,1,6000,6000,7000,14000,11,32005,1,0,0,0,0,0,0,0,0,0,'Mo\'arg Master Planner - Cast Thorium Drill');
--
-- Gan'arg Tinkerer
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('17151');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17151');
INSERT INTO `creature_ai_scripts` VALUES 
(1715101,17151,0,0,100,1,7500,7500,14000,16000,11,32003,1,0,0,0,0,0,0,0,0,0,'Gan\'arg Tinkerer - Cast Power Burn');
--
-- Xirkos, Overseer of Fear
UPDATE `creature_template` SET `mechanic_immune_mask`='616578131',`speed`='1.20' WHERE `entry` IN ('17151');
--
-- Felguard Legionnaire
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('17152');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17152');
INSERT INTO `creature_ai_scripts` VALUES 
(1715201,17152,0,0,100,1,3000,3000,10000,12000,11,15496,1,0,0,0,0,0,0,0,0,0,'Felguard Legionnaire - Cast Cleave'),
(1715202,17152,0,0,100,1,6000,6000,14000,16000,11,32015,1,0,0,0,0,0,0,0,0,0,'Felguard Legionnaire - Cast Cutdown');
--
-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================
-- 
-- nagrand
UPDATE creature SET position_x = 87.5382, position_y = 1755.13, position_z = 45.5574, orientation = 5.07582 WHERE guid = 59080;
UPDATE creature SET position_x = -1640.27, position_y = 8327.07, position_z = -40.0108, orientation = 3.7281 WHERE guid = 60411;
--
DELETE FROM creature_addon WHERE guid BETWEEN 130143 AND 130146; -- 4 working emotes
INSERT INTO creature_addon (guid, mount, bytes1, bytes2, emote, moveflags, auras) VALUES 
(130146, 0, 8, 4097, 0, 0, ''),
(130145, 0, 8, 4097, 0, 0, ''),
(130144, 0, 8, 4097, 0, 0, ''),
(130143, 0, 8, 4097, 0, 0, '');
--
-- Murkblood Target Dummy
UPDATE `creature` SET `position_x`='-1679.4619', `position_y`='8368.0117', `position_z`='-23.0451', `orientation`='1.1005',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('65457'); 
-- Murkblood Putrifier
UPDATE `creature` SET `position_x`='-1683.0513', `position_y`='8541.1425', `position_z`='-20.1492', `orientation`='2.7947',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('64994');
UPDATE `creature` SET `position_x`='-1675.9553', `position_y`='8582.8593', `position_z`='-21.6737', `orientation`='2.7577',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('64995');
--
-- movement
SET @NPC := 58969;
SET @PATH := @NPC * 10;  
UPDATE `creature` SET `MovementType`='2' WHERE `guid` IN (58969);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-1802.7333','9222.6181','70.2459',0,0,0,0,0),
(@PATH,2,'-1790.9542','9245.0273','70.9925',0,0,0,0,0),
(@PATH,3,'-1814.1148','9271.6816','72.4065',0,0,0,0,0),
(@PATH,4,'-1847.2919','9250.9648','70.5196',0,0,0,0,0),
(@PATH,5,'-1873.9462','9183.8496','70.2807',0,0,0,0,0),
(@PATH,6,'-1840.0675','9168.8242','71.3096',0,0,0,0,0),
(@PATH,7,'-1805.6177','9189.2480','70.8272',0,0,0,0,0);
-- ======================================================
-- Linking
-- ======================================================
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (58969,60330,60331,60332);
DELETE FROM `creature_formations` WHERE `memberguid` IN (58969,60330,60331,60332);
INSERT INTO `creature_formations` VALUES
(58969,58969,60,360,2),
(58969,60331,3,0,2),
(58969,60332,3,2,2),
(58969,60330,3,4,2);
--
-- ======================================================
-- Respawn
-- ======================================================
--
--
-- ======================================================
-- Gameobjects
-- ======================================================
--
--
-- ======================================================
-- Miscellaneous
-- ======================================================
--
--
--
--
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (90991,90992,90993,91247,91248,91249,90978,90987,90986,90985);
DELETE FROM `creature_formations` WHERE `memberguid` IN (90991,90992,90993,91247,91248,91249,90978,90987,90986,90985);
INSERT INTO `creature_formations` VALUES
--
--
(90991,90991,1000,360,1),
(90991,90992,3,1.2,1),
(90991,90993,3,5.2,1);
--
-- (90978,90978,1000,360,2),
--
-- (90978,91249,1000,360,1),
-- (90978,91248,1000,360,1),
-- (90978,91247,1000,360,1),
--
-- (90978,90987,1000,360,1),
-- (90978,90986,1000,360,1),
-- (90978,90985,1000,360,1);
-- Doomwalker 17711
-- 11-15K on tank during enrage without armor debuff
UPDATE `creature_template` SET `flags_extra`='4194305',`mindmg`='12500',`maxdmg`='17144' WHERE `entry` IN ('17711'); -- 5527 11298
--
-- spell summoned npc Tamed Ravager
DELETE FROM `creature` WHERE `guid` IN (69711,69712,69713,69714,69715,69716,69717,69718,69719,69720,69721,69722,69723,69724);
INSERT INTO `creature` VALUES
(69711,21846,530,1,0,0,-3715.1254,5081.5590,-19.9572,2,300,0,0,9250,0,0,0),
(69712,21846,530,1,0,0,-3669.1437,5123.7553,-22.6606,0,300,0,0,9250,0,0,0),
(69713,21846,530,1,0,0,-3614.7067,5203.8383,-20.6503,0,300,0,0,9250,0,0,0),
(69714,21846,530,1,0,0,-3721.4592,5188.3745,-20.9041,3,300,0,0,9250,0,0,0),
(69715,21846,530,1,0,0,-3711.6428,5043.4833,-19.5145,1,300,0,0,9250,0,0,0),
(69716,21846,530,1,0,0,-3745.3771,5102.3100,-19.9544,6,300,0,0,9250,0,0,0),
(69717,21846,530,1,0,0,-3693.2556,5151.8583,-14.3050,4,300,0,0,9250,0,0,0),
(69718,21846,530,1,0,0,-3650.2294,5142.5126,-22.7626,4,300,0,0,9250,0,0,0),
--
(69719,21859,530,1,0,0,-3708.9221,5111.0068,-22.1079,0,300,0,0,9250,0,0,0),
(69720,21859,530,1,0,0,-3650.4421,5176.5385,-20.8863,0,300,0,0,9250,0,0,0),
(69721,21859,530,1,0,0,-3706.8068,5139.3295,-19.6968,5,300,0,0,9250,0,0,0),
(69722,21859,530,1,0,0,-3756.5253,5032.0200,-18.5965,3,300,0,0,9250,0,0,0),
(69723,21859,530,1,0,0,-3696.9355,5159.2192,-15.2199,0,300,0,0,9250,0,0,0),
(69724,21859,530,1,0,0,-3646.3493,5161.0429,-17.5482,5,300,0,0,9250,0,0,0);
--
-- Shattered Hand Heathen
UPDATE `creature_template` SET `equipment_id`='1290',`mindmg`='1320',`maxdmg`='1737' WHERE `entry` IN (17420); -- 2 rote 1h schwerter 403 820
UPDATE `creature_template` SET `equipment_id`='1290',`armor`='6800',`mindmg`='3262',`maxdmg`='3393',`baseattacktime`='0' WHERE `entry` IN (20587); -- 2 rote 1h schwerter 1915 2244 4077 4242 dualwield 2.5
--
-- Shattered Hand Sentry 16507 20593
UPDATE `creature_template` SET `equipment_id`='58',`mindmg`='1467',`maxdmg`='1931' WHERE `entry` IN (16507); -- nicht ganz 448 912
UPDATE `creature_template` SET `equipment_id`='58',`armor`='6800',`mindmg`='4310',`maxdmg`='4586' WHERE `entry` IN (20593); -- nicht ganz 1948 2500
--
-- Shattered Hand Savage 16523 20591
UPDATE `creature_template` SET `equipment_id`='926',`mindmg`='1467',`maxdmg`='1931' WHERE `entry` IN (16523); -- 2 äxte 448 912  - 
UPDATE `creature_template` SET `equipment_id`='926',`armor`='6800',`mindmg`='3298',`maxdmg`='3513' WHERE `entry` IN (20591); -- 2 äxte 1860 2397 4123 4392 dualwield 2.5
