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

SET @GUID := 77873;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77873, 22206, 530, 1, 0, 0, 3116.45, 6232.58, 131.618, 0.955641, 300, 0, 0, 16767, 3155, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,131584,33554432,4097,0,0,'30831');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77873, 1, 3116.45, 6232.58, 131.618, 25000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 2, 3144.88, 6258.86, 130.191, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 3, 3158.19, 6271.1, 126.974, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 4, 3172.03, 6273.93, 125.813, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 5, 3184.73, 6273.2, 124.863, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 6, 3187.99, 6271.61, 124.215, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 7, 3185.76, 6266.8, 124.273, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 8, 3180.05, 6264.92, 125.399, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 9, 3176.91, 6263.85, 124.739, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 10, 3164.73, 6258.24, 124.872, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 11, 3146.2, 6244.44, 124.107, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 12, 3133.05, 6228.81, 125.57, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 13, 3126.09, 6209.23, 128.857, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 14, 3124.91, 6191.65, 133.929, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 15, 3122.31, 6180.62, 137.146, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 16, 3116.36, 6174.45, 137.649, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 17, 3111.84, 6176.62, 137.941, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 18, 3107.19, 6202.1, 135.244, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77873, 19, 3111.43, 6216.25, 133.779, 0, 0, 0, 100, 0);

-- Fel Iron Deposit 181555
DELETE FROM `gameobject_loot_template` WHERE `entry` = 18359;
INSERT INTO `gameobject_loot_template` VALUES (18359, 0, 4, 2, -12004, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18359, 12004, 1, 1, -12004, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18359, 22573, 10, 0, 1, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18359, 22574, 10, 0, 1, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18359, 23424, 100, 0, 1, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18359, 23427, 2, 0, 1, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18359, 35229, -25, 0, 1, 1, 0, 0, 0);

-- Adamantite Deposit 181556 & Rich Adamantite Deposit 181569 & 181570
DELETE FROM `gameobject_loot_template` WHERE `entry` = 18361;
INSERT INTO `gameobject_loot_template` VALUES (18361, 0, 4, 2, -12004, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18361, 12004, 1, 1, -12004, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18361, 22573, 19.9, 0, 2, 4, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18361, 23425, 100, 0, 1, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18361, 23427, 9.9, 0, 1, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18361, 24243, 1, 0, 1, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (18361, 35229, -25, 0, 1, 1, 0, 0, 0);

-- Nethercite Deposit 185877
DELETE FROM `gameobject_loot_template` WHERE `entry` = 22070;
INSERT INTO `gameobject_loot_template` VALUES (22070, 0, 4, 2, -12004, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (22070, 22573, 10, 0, 1, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (22070, 22574, 9.8, 0, 1, 2, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (22070, 23427, 2, 0, 1, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (22070, 32464, 100, 0, 1, 1, 0, 0, 0);
INSERT INTO `gameobject_loot_template` VALUES (22070, 32506, 1, 0, 1, 1, 0, 0, 0);

-- Mature Cavern Crawler 22132
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 22132;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22132;
INSERT INTO `creature_ai_scripts` VALUES
('2213201','22132','9','0','100','1','0','30','4500','6000','11','7951','1','0','0','0','0','0','0','0','0','0','Mature Cavern Crawler - Cast Toxic Spit');

-- Cavern Crawler 22044
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 22044;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22044;
INSERT INTO `creature_ai_scripts` VALUES
('2204401','22044','0','0','100','3','4000','7000','8000','12000','11','744','4','32','0','0','0','0','0','0','0','0','Cavern Crawler - Cast Poison');

SET @GUID := 77719;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77719, 22132, 530, 1, 0, 0, 1236.68, 6974.83, 86.5215, 2.96731, 300, 0, 0, 5914, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77719, 1, 1236.68, 6974.83, 86.5215, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 2, 1213.58, 6994.5, 96.4589, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 3, 1191.59, 7009.76, 104.124, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 4, 1179.4, 7021.07, 106.665, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 5, 1191.59, 7009.76, 104.124, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 6, 1213.58, 6994.5, 96.4589, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 7, 1236.55, 6974.85, 86.5549, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 8, 1259.07, 6971.35, 87.2095, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 9, 1302.53, 6966.91, 92.3804, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 10, 1315.86, 6961.6, 92.8317, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 11, 1328.68, 6944.25, 93.1772, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 12, 1334.16, 6919.82, 94.023, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 13, 1341.48, 6899.75, 94.7778, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 14, 1355.23, 6884.75, 95.2125, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 15, 1373.99, 6866.59, 97.523, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 16, 1390.79, 6861.88, 102.258, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 17, 1407.61, 6858.91, 108.029, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 18, 1390.79, 6861.88, 102.258, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 19, 1373.99, 6866.59, 97.523, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 20, 1355.23, 6884.75, 95.2125, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 21, 1341.48, 6899.75, 94.7778, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 22, 1334.16, 6919.82, 94.023, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 23, 1328.68, 6944.25, 93.1772, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 24, 1315.86, 6961.6, 92.8317, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 25, 1302.53, 6966.91, 92.3804, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77719, 26, 1259.07, 6971.35, 87.2095, 0, 0, 0, 100, 0);

SET @GUID := 77196;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77196, 22040, 530, 1, 0, 0, 1308.01, 6958.69, 103.712, 5.70704, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77196, 1, 1308.01, 6958.69, 103.712, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77196, 2, 1255.09, 6959.11, 109.222, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77196, 3, 1304.9, 6960.3, 103.961, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77196, 4, 1329.99, 6926.44, 102.942, 0, 1, 0, 100, 0);

SET @GUID := 77195;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77195, 22040, 530, 1, 0, 0, 1331.97, 6921.99, 103.445, 3.00483, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77195, 1, 1331.97, 6921.99, 103.445, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77195, 2, 1342.37, 6884.35, 110.745, 0, 1, 0, 100, 0);

SET @GUID := 77194;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77194, 22040, 530, 1, 0, 0, 1213.56, 6978.56, 119.448, 3.14271, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77194, 1, 1213.56, 6978.56, 119.448, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77194, 2, 1252.22, 6959.56, 109.65, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77194, 3, 1305.89, 6960.33, 103.858, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77194, 4, 1254.09, 6959.15, 109.324, 0, 1, 0, 100, 0);

SET @GUID := 77193;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77193, 22040, 530, 1, 0, 0, 1182.27, 7005.14, 122.562, 0.014402, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77193, 1, 1182.27, 7005.14, 122.562, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77193, 2, 1252.27, 6959.66, 109.582, 0, 1, 0, 100, 0);

SET @GUID := 77192;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77192, 22040, 530, 1, 0, 0, 1308.53, 6957.84, 103.731, 5.64476, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77192, 1, 1308.53, 6957.84, 103.731, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77192, 2, 1329.49, 6927.31, 102.957, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77192, 3, 1342.31, 6884.34, 110.781, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77192, 4, 1331.96, 6921.99, 103.448, 0, 1, 0, 100, 0);

SET @GUID := 77191;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (77191, 22040, 530, 1, 0, 0, 1252.22, 6959.56, 109.648, 4.79157, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77191, 1, 1252.22, 6959.56, 109.648, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 2, 1305.89, 6960.33, 103.858, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 3, 1330.6, 6925.65, 102.916, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 4, 1342.88, 6882.45, 111.117, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 5, 1330.6, 6925.65, 102.916, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 6, 1305.89, 6960.33, 103.858, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 7, 1254.09, 6959.13, 109.325, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 8, 1213.56, 6978.56, 119.448, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 9, 1182.2, 7005.04, 122.638, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77191, 10, 1213.56, 6978.56, 119.448, 0, 1, 0, 100, 0);
