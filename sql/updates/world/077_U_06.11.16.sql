-- Summoner Kanthin 19657
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19657;
INSERT INTO `creature_ai_scripts` VALUES
('1965701','19657','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Summoner Kanthin - Set Phase 1 on Aggro'),
('1965702','19657','9','5','100','1','0','40','3400','4800','11','19816','1','0','0','0','0','0','0','0','0','0','Summoner Kanthin - Cast Fireball (Phase 1)'),
('1965703','19657','3','5','100','0','7','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Summoner Kanthin - Set Phase 2 when Mana is at 7% (Phase 1)'),
('1965704','19657','3','3','100','1','100','15','1000','1000','22','1','0','0','0','0','0','0','0','0','0','0','Summoner Kanthin - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1965705','19657','9','0','100','1','0','8','12000','16000','11','11831','0','0','0','0','0','0','0','0','0','0','Summoner Kanthin - Cast Frost Nova'),
('1965706','19657','0','0','100','1','10000','14000','18000','21000','11','17273','4','0','0','0','0','0','0','0','0','0','Summoner Kanthin - Cast Pyroblast'),
('1965707','19657','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Summoner Kanthin - Set Phase to 0 on Evade');

UPDATE `creature` SET `position_z`= 237.1 WHERE `guid` = 70138;
UPDATE `creature` SET `position_z`= 241.5 WHERE `guid` = 70139;
UPDATE `creature` SET `position_x`= 4912.5493, `position_y`= 3859.2773, `position_z`= 237 WHERE `guid` = 70136;
UPDATE `creature` SET `position_x`= 4924.5078, `position_y`= 3834.0354 WHERE `guid` = 70137;

SET @ID := 1965600;
UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 19656;
DELETE FROM `creature_ai_scripts` WHERE `id` BETWEEN 1965601 AND 1965699;
INSERT INTO `creature_ai_scripts` VALUES
(@ID := @ID + 1,'-70092','1','0','100','0','0','0','0','0','44','33346','70093','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70094','1','0','100','0','0','0','0','0','44','33346','70093','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70096','1','0','100','0','0','0','0','0','44','33346','70097','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70097','1','0','100','0','0','0','0','0','44','33346','70098','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70098','1','0','100','0','0','0','0','0','44','33346','70099','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70099','1','0','100','0','0','0','0','0','44','33346','70096','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70100','1','0','100','0','0','0','0','0','44','33346','70102','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70101','1','0','100','0','0','0','0','0','44','33346','70102','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70104','1','0','100','0','0','0','0','0','44','33346','70102','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70103','1','0','100','0','0','0','0','0','44','33346','70102','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70102','1','0','100','0','0','0','0','0','44','33346','70102','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70112','1','0','100','0','0','0','0','0','44','33346','78368','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70113','1','0','100','0','0','0','0','0','44','33346','78368','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70115','1','0','100','0','0','0','0','0','44','33346','70116','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70117','1','0','100','0','0','0','0','0','44','33346','70118','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70118','1','0','100','0','0','0','0','0','44','33346','70116','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70119','1','0','100','0','0','0','0','0','44','33346','70120','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70121','1','0','100','0','0','0','0','0','44','33346','70120','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70122','1','0','100','0','0','0','0','0','44','33346','70120','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70128','1','0','100','0','0','0','0','0','44','33346','70120','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70122','1','0','100','0','0','0','0','0','44','33346','70123','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70124','1','0','100','0','0','0','0','0','44','33346','70123','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70125','1','0','100','0','0','0','0','0','44','33346','70124','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70126','1','0','100','0','0','0','0','0','44','33346','70123','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70127','1','0','100','0','0','0','0','0','44','33346','70121','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70129','1','0','100','0','0','0','0','0','44','33346','78370','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70130','1','0','100','0','0','0','0','0','44','33346','78370','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70131','1','0','100','0','0','0','0','0','44','33346','78370','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),

(@ID := @ID + 1,'-70134','1','0','100','0','0','0','0','0','44','33346','70136','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70135','1','0','100','0','0','0','0','0','44','33346','70138','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70136','1','0','100','0','0','0','0','0','44','33346','70137','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70138','1','0','100','0','0','0','0','0','44','33346','70137','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC'),
(@ID := @ID + 1,'-70139','1','0','100','0','0','0','0','0','44','33346','70137','7','0','0','0','0','0','0','0','0','Netherstorm Trigger - Cast Green Beam OOC');

-- Fel Cannon MKI 22461
UPDATE `creature_template` SET `AIName` = 'EventAI',`ScriptName` = NULL WHERE `entry` = 22461; -- npc_fel_cannon_master
DELETE FROM `creature_ai_scripts` WHERE `id` BETWEEN 2246101 AND 2246199;
INSERT INTO `creature_ai_scripts` VALUES
('2246101','22461','1','0','100','1','1000','1000','1000','1000','21','0','0','0','0','0','0','0','0','0','0','0','Fel Cannon MKI - OOC - Prevent Combat Movement'),
('2246102','22461','0','0','100','1','0','1000','2000','2500','11','36238','1','0','0','0','0','0','0','0','0','0','Fel Cannon MKI - Combat - Cast Fel Cannon Blast'),
('2246103','-78826','1','0','100','1','3000','9000','9000','90000','44','39211','70095','0','0','0','0','0','0','0','0','0','Fel Cannon MKI - Cast Fel Cannon Blast OOC'), -- visual non functional
('2246104','-78827','1','0','100','1','3000','9000','9000','90000','44','39211','70095','0','0','0','0','0','0','0','0','0','Fel Cannon MKI - Cast Fel Cannon Blast OOC'),
('2246105','-78831','1','0','100','1','3000','9000','9000','90000','44','39211','70106','0','0','0','0','0','0','0','0','0','Fel Cannon MKI - Cast Fel Cannon Blast OOC'),
('2246106','-78832','1','0','100','1','3000','9000','9000','90000','44','39211','70105','0','0','0','0','0','0','0','0','0','Fel Cannon MKI - Cast Fel Cannon Blast OOC');

-- Skyguard Prisoner 23383
UPDATE `creature_template` SET `unit_flags` = 32833 WHERE `entry` = 23383;
-- correct respawntime of sniffed npcs 21911
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` = 21911;
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` = 138363; -- cant be used currently

DELETE FROM `creature` WHERE `guid` BETWEEN 98755 AND 98758;
INSERT INTO `creature` VALUES (98755, 22062, 530, 1, 0, 0, 6300.91, -6252.88, 77.8134, 4.92138, 5400, 0, 0, 626, 0, 0, 0);
INSERT INTO `creature` VALUES (98756, 22062, 530, 1, 0, 0, 6305.22, -6475.4, 83.0121, 0.443913, 6300, 0, 0, 626, 0, 0, 0);
INSERT INTO `creature` VALUES (98757, 22062, 530, 1, 0, 0, 7160.29, -6620.61, 60.6592, 5.59064, 7200, 0, 0, 626, 0, 0, 0);
INSERT INTO `creature` VALUES (98758, 22062, 530, 1, 0, 0, 7227.19, -6406.61, 56.1656, 2.77106, 9000, 0, 0, 626, 0, 0, 0);
DELETE FROM `pool_creature` WHERE `pool_entry` = 1077;
INSERT INTO `pool_creature` VALUES
(98755,1077,0,'Dr. Whitherlimb (22062)'),
(98756,1077,0,'Dr. Whitherlimb (22062)'),
(98757,1077,0,'Dr. Whitherlimb (22062)'),
(98758,1077,0,'Dr. Whitherlimb (22062)');

SET @GUID := 83087;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (83087, 1, -56.6067, 566.384, -17.7584, 255, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (83087, 2, -81.0371, 554.711, -17.7842, 255, 0, 0, 100, 0);

SET @GUID := 78723;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (78723, 22393, 530, 1, 0, 0, -1453.54, 9636.82, 201.688, 1.66862, 300, 0, 0, 33534, 9465, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78723, 1, -1453.54, 9636.82, 201.688, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 2, -1432.65, 9646.11, 201.194, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 3, -1405.08, 9634.17, 200.442, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 4, -1376.06, 9616.1, 201.409, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 5, -1359.88, 9605.58, 202.905, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 6, -1340.02, 9602.57, 203.255, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 7, -1324.82, 9604.7, 203.328, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 8, -1307.9, 9605.09, 203.847, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 9, -1324.82, 9604.7, 203.328, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 10, -1340.02, 9602.57, 203.255, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 11, -1359.88, 9605.58, 202.905, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 12, -1376.06, 9616.1, 201.409, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 13, -1405.08, 9634.17, 200.442, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (78723, 14, -1432.65, 9646.11, 201.194, 0, 0, 0, 100, 0);
