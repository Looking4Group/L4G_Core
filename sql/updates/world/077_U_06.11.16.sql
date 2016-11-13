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

DELETE FROM creature_loot_template WHERE Entry in (10925,10684,10698,17887,2462,10928,10388,10389);
UPDATE `creature_template` SET `mingold` = 0, `maxgold` = 0, `lootid` = 0 WHERE Entry in (10925,10684,10698,17887,2462,10928,10388,10389);

-- ----------------------------------------------------------
-- Saltgurka Update 13
-- ----------------------------------------------------------

-- Fel Reaver GUID 67185. Fix glitch at first/last waypoint
UPDATE `creature` SET `position_x`=491.940887,`position_y`=3041.700439,`position_z`=17.974068 WHERE `guid`=67185;
UPDATE `waypoint_data` SET `position_x`=501.118622,`position_y`=3036.401611,`position_z`=18.346073 WHERE `id`=67185 AND `point`=224;

-- ----------------------------------------------------------
-- Stonegazer
-- ----------------------------------------------------------
-- Pathing for  Entry: 18648 'TDB FORMAT' 
SET @GUID := 86357;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2069.873,`position_y`=3279.854,`position_z`=-53.93298 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2069.873,3279.854,-53.93298,0,0,0,100,0), -- 01:35:30
(@GUID,@POINT := @POINT + '1',-2079.191895,3290.044189,-51.785545,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2084.110840,3295.639648,-55.650745,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2090.854,3300.624,-49.96491,0,0,0,100,0), -- 01:35:41
(@GUID,@POINT := @POINT + '1',-2104.93,3315.133,-47.24506,0,0,0,100,0), -- 01:35:54
(@GUID,@POINT := @POINT + '1',-2127.758,3353.661,-46.73643,0,0,0,100,0), -- 01:36:05
(@GUID,@POINT := @POINT + '1',-2126.352295,3371.798828,-56.279808,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2126.850830,3382.518799,-50.864273,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2127.699,3391.13,-46.16661,0,0,0,100,0), -- 01:36:18
(@GUID,@POINT := @POINT + '1',-2116.345,3408.114,-47.12852,0,0,0,100,0), -- 01:36:36
(@GUID,@POINT := @POINT + '1',-2109.141,3436.284,-58.83674,0,0,0,100,0), -- 01:36:46
(@GUID,@POINT := @POINT + '1',-2106.72,3472.133,-65.41318,0,0,0,100,0), -- 01:36:58
(@GUID,@POINT := @POINT + '1',-2098.279,3510.867,-57.27117,0,0,0,100,0), -- 01:37:13
(@GUID,@POINT := @POINT + '1',-2093.169189,3545.266846,-60.775902,0,0,0,100,0), -- M
(@GUID,@POINT := @POINT + '1',-2098.639648,3553.168945,-69.527473,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-2096.787842,3559.678223,-63.142979,0,0,0,100,0), -- M
(@GUID,@POINT := @POINT + '1',-2078.596,3601.208,-61.60058,0,0,0,100,0), -- 01:38:01
(@GUID,@POINT := @POINT + '1',-2069.227,3620.525,-63.85473,0,0,0,100,0), -- 01:38:12
(@GUID,@POINT := @POINT + '1',-2059.475,3639.335,-64.33026,0,0,0,100,0), -- 01:38:20
(@GUID,@POINT := @POINT + '1',-2041.745,3656.187,-67.35803,0,0,0,100,0), -- 01:38:32
(@GUID,@POINT := @POINT + '1',-2032.396,3660.364,-68.41994,0,0,0,100,0), -- 01:38:40
(@GUID,@POINT := @POINT + '1',-2018.860474,3672.631836,-70.354584,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2005.629,3679.599,-63.06415,0,0,0,100,0), -- 01:38:45
(@GUID,@POINT := @POINT + '1',-1994.584,3703.789,-46.7004,0,0,0,100,0), -- 01:38:57
(@GUID,@POINT := @POINT + '1',-1981.856,3727.542,-31.08355,0,0,0,100,0), -- 01:39:11
(@GUID,@POINT := @POINT + '1',-1955.825,3745.198,-13.03543,0,0,0,100,0), -- 01:39:23
(@GUID,@POINT := @POINT + '1',-1922.638,3759.67,-7.223214,20000,0,0,100,0), -- 01:39:39
(@GUID,@POINT := @POINT + '1',-1902.283,3773.418,0.7086811,0,0,0,100,0), -- 01:40:03
(@GUID,@POINT := @POINT + '1',-1886.899,3784.381,7.361509,0,0,0,100,0), -- 01:40:03
(@GUID,@POINT := @POINT + '1',-1860.92,3793.652,9.11064,0,0,0,100,0), -- 01:40:14
(@GUID,@POINT := @POINT + '1',-1832.157,3801.548,18.17687,20000,0,0,100,0), -- 01:40:22
(@GUID,@POINT := @POINT + '1',-1855.311,3795.068,10.872,0,0,0,100,0), -- 01:40:36
(@GUID,@POINT := @POINT + '1',-1871.965,3791.469,6.906743,0,0,0,100,0), -- 01:40:48
(@GUID,@POINT := @POINT + '1',-1900.469,3774.797,2.331289,0,0,0,100,0), -- 01:40:55
(@GUID,@POINT := @POINT + '1',-1915.89,3763.656,-5.425821,0,0,0,100,0), -- 01:41:07
(@GUID,@POINT := @POINT + '1',-1951.463,3747.947,-11.19495,0,0,0,100,0), -- 01:41:16
(@GUID,@POINT := @POINT + '1',-1980.19,3729.019,-30.1324,0,0,0,100,0), -- 01:41:38
(@GUID,@POINT := @POINT + '1',-1993.188,3706.402,-44.85973,0,0,0,100,0), -- 01:41:47
(@GUID,@POINT := @POINT + '1',-2003.645,3682.012,-60.9176,0,0,0,100,0), -- 01:42:00
(@GUID,@POINT := @POINT + '1',-2017.007202,3675.731201,-69.071999,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2022.713,3664.636,-68.72914,0,0,0,100,0), -- 01:42:11
(@GUID,@POINT := @POINT + '1',-2029.238,3661.682,-68.21417,0,0,0,100,0), -- 01:42:23
(@GUID,@POINT := @POINT + '1',-2051.059,3650.764,-65.41318,0,0,0,100,0), -- 01:42:31
(@GUID,@POINT := @POINT + '1',-2067.809,3623.25,-65.20171,0,0,0,100,0), -- 01:42:38
(@GUID,@POINT := @POINT + '1',-2075.301,3608.421,-61.94993,0,0,0,100,0), -- 01:42:54
(@GUID,@POINT := @POINT + '1',-2088.608154,3563.041504,-64.395264,0,0,0,100,0), -- M
(@GUID,@POINT := @POINT + '1',-2092.310303,3551.349121,-71.436234,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2093.432,3545.782,-60.6242,0,0,0,100,0), -- 01:43:10
(@GUID,@POINT := @POINT + '1',-2095.836,3527.139,-56.22093,0,0,0,100,0), -- 01:43:34
(@GUID,@POINT := @POINT + '1',-2105.932,3477.156,-64.52386,0,0,0,100,0), -- 01:43:48
(@GUID,@POINT := @POINT + '1',-2108.521,3439.301,-60.6965,0,0,0,100,0), -- 01:44:03
(@GUID,@POINT := @POINT + '1',-2112.503,3413.643,-47.70906,0,0,0,100,0), -- 01:44:11
(@GUID,@POINT := @POINT + '1',-2124.775879,3387.528320,-47.553360,0,0,0,100,0), -- M
(@GUID,@POINT := @POINT + '1',-2128.065186,3375.886230,-56.247795,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2127.688721,3361.588379,-52.347160,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2127.839,3356.377,-46.30887,0,0,0,100,0), -- 01:44:31
(@GUID,@POINT := @POINT + '1',-2120.441,3338.171,-47.29559,0,0,0,100,0), -- 01:44:50
(@GUID,@POINT := @POINT + '1',-2089.120361,3300.458984,-51.937576,0,0,0,100,0), -- M
(@GUID,@POINT := @POINT + '1',-2083.832520,3293.304932,-55.831375,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2079.254150,3288.217773,-51.482536,0,0,0,100,0), -- M
(@GUID,@POINT := @POINT + '1',-2052.282959,3260.209961,-60.194260,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2049.582031,3255.669189,-64.417122,0,0,0,100,0), -- M
(@GUID,@POINT := @POINT + '1',-2045.900146,3245.193359,-73.206505,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2037.369,3238.545,-68.77824,0,0,0,100,0), -- 01:45:39
(@GUID,@POINT := @POINT + '1',-2044.561890,3245.060791,-73.118362,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-2049.628906,3250.762207,-68.862167,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2055.411,3258.592,-58.74536,0,0,0,100,0), -- 01:45:57
(@GUID,@POINT := @POINT + '1',-2069.996,3279.67,-53.85863,0,0,0,100,0); -- 01:46:11
-- 0x202FD4424012360000006900001D1B37 .go -2069.873 3279.854 -53.93298

-- ----------------------------------------------------------
-- Bach'lor
-- https://github.com/Looking4Group/L4G_Core/issues/549
-- ----------------------------------------------------------

-- 1 Bach'lor, 6 Stags, 3 Thorngrazer
DELETE FROM `creature_formations` WHERE `leaderGUID`=65528;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(65528,65528,0,0,0), -- Bach'lor
(65528,59730,10,0.5,0), -- Stag 
(65528,59973,7,1.4,0), -- Thorngrazer 
(65528,68110,9,2.7,0), -- Stag  
(65528,59974,6,3.2,0), -- Thorngrazer 
(65528,59727,8,4.8,0), -- Stag
(65528,59729,10,3.8,0), -- Stag
(65528,59972,9,5.1,0), -- Thorngrazer
(65528,68109,7,5.7,0), -- Stag 
(65528,59728,6,0,0); -- Stag 

UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid` IN (59730,59728,68109,68110,59727,59729,59972,59974,59973);
UPDATE `creature_template` SET `speed`=1.125 WHERE `entry`=18258;

-- Pathing for  Entry: 18258 'TDB FORMAT' 
SET @GUID := 65528;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-1763.743408,`position_y`=8824.981445,`position_z`=28.770004 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-1722.28,8819.484,33.3289,0,0,0,100,0), -- 13:08:48
(@GUID,@POINT := @POINT + '1',-1702.276,8815.271,33.32148,0,0,0,100,0), -- 13:09:08
(@GUID,@POINT := @POINT + '1',-1679.725,8809.788,37.99786,0,0,0,100,0), -- 13:09:14
(@GUID,@POINT := @POINT + '1',-1665.328,8807.191,38.86504,0,0,0,100,0), -- 13:09:25
(@GUID,@POINT := @POINT + '1',-1627.726,8792.098,36.82252,0,0,0,100,0), -- 13:09:33
(@GUID,@POINT := @POINT + '1',-1544.211,8763.725,33.05894,0,0,0,100,0), -- 13:10:33
(@GUID,@POINT := @POINT + '1',-1517.92,8760.383,28.72654,0,0,0,100,0), -- 13:10:41
(@GUID,@POINT := @POINT + '1',-1470.43,8750.481,28.02884,0,0,0,100,0), -- 13:10:53
(@GUID,@POINT := @POINT + '1',-1425.195,8726.87,21.71577,0,0,0,100,0), -- 13:11:46
(@GUID,@POINT := @POINT + '1',-1395.229,8717.943,23.6657,0,0,0,100,0), -- 13:12:19
(@GUID,@POINT := @POINT + '1',-1365.803,8700.389,28.48817,0,0,0,100,0), -- 13:12:28
(@GUID,@POINT := @POINT + '1',-1347.923,8663.277,24.94011,0,0,0,100,0), -- 13:12:37
(@GUID,@POINT := @POINT + '1',-1352.986,8628.97,25.12338,0,0,0,100,0), -- 13:12:43
(@GUID,@POINT := @POINT + '1',-1345.75,8602.563,22.75222,0,0,0,100,0), -- 13:12:46
(@GUID,@POINT := @POINT + '1',-1332.214,8589.995,19.76134,0,0,0,100,0), -- 13:12:53
(@GUID,@POINT := @POINT + '1',-1288.517,8597.396,22.40537,0,0,0,100,0), -- 13:12:53
(@GUID,@POINT := @POINT + '1',-1247.689,8631.377,32.35799,0,0,0,100,0), -- 13:12:57
(@GUID,@POINT := @POINT + '1',-1221.921,8669.443,38.759,0,0,0,100,0), -- 13:13:42
(@GUID,@POINT := @POINT + '1',-1230.986,8689.392,37.48727,0,0,0,100,0), -- 13:14:04
(@GUID,@POINT := @POINT + '1',-1246.518,8711.414,34.55711,0,0,0,100,0), -- 13:14:13
(@GUID,@POINT := @POINT + '1',-1264.723,8731.359,32.45301,0,0,0,100,0), -- 13:14:23
(@GUID,@POINT := @POINT + '1',-1283.211,8742.08,35.1921,0,0,0,100,0), -- 13:14:34
(@GUID,@POINT := @POINT + '1',-1302.945,8740.64,34.15536,0,0,0,100,0), -- 13:14:42
(@GUID,@POINT := @POINT + '1',-1328.931,8730.213,29.98804,0,0,0,100,0), -- 13:14:52
(@GUID,@POINT := @POINT + '1',-1359.769,8736.244,28.62923,0,0,0,100,0), -- 13:15:02
(@GUID,@POINT := @POINT + '1',-1374.585,8757.733,31.23441,0,0,0,100,0), -- 13:15:15
(@GUID,@POINT := @POINT + '1',-1378.192017,8802.869141,34.409225,0,0,0,100,0), -- 13:16:06
(@GUID,@POINT := @POINT + '1',-1396.674,8830.664,29.17865,0,0,0,100,0), -- 13:16:11
(@GUID,@POINT := @POINT + '1',-1415.894,8849.027,32.91793,0,0,0,100,0), -- 13:16:42
(@GUID,@POINT := @POINT + '1',-1439.048,8862.957,37.71593,0,0,0,100,0), -- 13:16:51
(@GUID,@POINT := @POINT + '1',-1457.388,8872.232,37.3876,0,0,0,100,0), -- 13:17:01
(@GUID,@POINT := @POINT + '1',-1481.634,8894.106,41.19839,0,0,0,100,0), -- 13:02:37
(@GUID,@POINT := @POINT + '1',-1491.279,8909.655,43.60288,0,0,0,100,0), -- 13:02:49
(@GUID,@POINT := @POINT + '1',-1505.115,8929.373,42.08359,0,0,0,100,0), -- 13:02:59
(@GUID,@POINT := @POINT + '1',-1519.289,8943.564,38.27998,0,0,0,100,0), -- 13:03:14
(@GUID,@POINT := @POINT + '1',-1581.565,8968.285,39.17889,0,0,0,100,0), -- 13:03:25
(@GUID,@POINT := @POINT + '1',-1619.783,8971.953,41.27372,0,0,0,100,0), -- 13:03:30
(@GUID,@POINT := @POINT + '1',-1655.179,8964.685,43.4279,0,0,0,100,0), -- 13:03:33
(@GUID,@POINT := @POINT + '1',-1678.577,8957.195,39.42907,0,0,0,100,0), -- 13:03:43
(@GUID,@POINT := @POINT + '1',-1721.105,8963.633,48.24629,0,0,0,100,0), -- 13:03:43
(@GUID,@POINT := @POINT + '1',-1759.582,8971.582,58.49213,0,0,0,100,0), -- 13:03:47
(@GUID,@POINT := @POINT + '1',-1763.973,8972.37,58.62778,0,0,0,100,0), -- 13:03:59
(@GUID,@POINT := @POINT + '1',-1759.463,8944.176,58.30365,10000,0,0,100,0), -- 13:03:59
(@GUID,@POINT := @POINT + '1',-1782.382,8980.544,54.58898,0,0,0,100,0), -- 13:04:16
(@GUID,@POINT := @POINT + '1',-1794.694092,8981.319336,50.397305,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1809.132,8982.399,46.16508,0,0,0,100,0), -- 13:04:44
(@GUID,@POINT := @POINT + '1',-1815.578735,8976.117188,41.797672,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1830.365,8948.427,39.76588,0,0,0,100,0), -- 13:04:51
(@GUID,@POINT := @POINT + '1',-1849.443,8918.301,37.4994,0,0,0,100,0), -- 13:05:04
(@GUID,@POINT := @POINT + '1',-1853.802,8911.711,37.22044,0,0,0,100,0), -- 13:05:19
(@GUID,@POINT := @POINT + '1',-1900.892,8888.019,37.02385,0,0,0,100,0), -- 13:05:30
(@GUID,@POINT := @POINT + '1',-1904.156,8887.938,37.14519,0,0,0,100,0), -- 13:05:41
(@GUID,@POINT := @POINT + '1',-1947.176,8879.732,36.11081,0,0,0,100,0), -- 13:06:04
(@GUID,@POINT := @POINT + '1',-1875.973,8847.949,30.94032,0,0,0,100,0), -- 13:07:02
(@GUID,@POINT := @POINT + '1',-1853.324,8843.785,30.09974,0,0,0,100,0), -- 13:07:17
(@GUID,@POINT := @POINT + '1',-1807.557,8834.994,29.25954,0,0,0,100,0), -- 13:07:30
(@GUID,@POINT := @POINT + '1',-1778.889,8832.211,28.83184,0,0,0,100,0); -- 13:07:58

-- ----------------------------------------------------------
-- Mountain Gronn's
-- ----------------------------------------------------------
UPDATE `creature` SET `spawndist`=40,`MovementType`=1 WHERE `guid`=68734;

SET @GUID := 68733;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-967.971008,8735.259766,145.375198,60000,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-978.207275,8739.339844,136.553177,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-991.007202,8742.399414,128.609924,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1016.179016,8762.903320,119.399399,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1025.071655,8786.770508,116.338470,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1038.896118,8807.762695,111.582047,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1050.839355,8825.990234,105.875496,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1042.220947,8851.875000,119.197044,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1013.263611,8864.773438,133.216599,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-987.994629,8875.675781,142.408096,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-960.660400,8891.832031,147.622253,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-926.747864,8911.389648,151.088943,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-886.730896,8933.423828,155.152786,10000,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-923.709595,8914.567383,151.549591,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-968.073486,8887.724609,146.594772,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1002.600403,8871.376953,137.645859,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1033.747803,8855.992188,124.245102,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1034.324097,8830.502930,114.207443,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1035.634277,8802.632813,112.631409,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1025.797729,8779.989258,115.139107,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1010.115723,8749.827148,121.177612,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-992.439819,8741.413086,127.880783,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-975.800537,8737.937500,138.538086,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-961.674988,8734.902344,150.876282,0,0,0,100,0);

-- Pathing for  Entry: 19201 'TDB FORMAT' 
SET @GUID := 68735;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-1800.628,8785.258,31.36622,0,0,0,100,0), -- 17:17:19
(@GUID,@POINT := @POINT + '1',-1821.058,8778.673,30.80778,0,0,0,100,0), -- 17:17:24
(@GUID,@POINT := @POINT + '1',-1848.456,8762.41,28.90891,0,0,0,100,0), -- 17:17:37
(@GUID,@POINT := @POINT + '1',-1869.854,8754.341,26.27174,0,0,0,100,0), -- 17:17:46
(@GUID,@POINT := @POINT + '1',-1904.505,8759.32,26.06429,0,0,0,100,0), -- 17:17:54
(@GUID,@POINT := @POINT + '1',-1918.91,8769.67,26.86385,10000,0,0,100,0), -- 17:18:12
(@GUID,@POINT := @POINT + '1',-1946.543091,8816.708984,28.342142,0,0,0,100,0), -- 17:20:29
(@GUID,@POINT := @POINT + '1',-1981.723999,8863.507813,25.978216,0,0,0,100,0), -- 17:20:33
(@GUID,@POINT := @POINT + '1',-2015.871,8875.336,30.86393,0,0,0,100,0), -- 17:20:36
(@GUID,@POINT := @POINT + '1',-1997.016,8879.214,31.98178,0,0,0,100,0), -- 17:21:39
(@GUID,@POINT := @POINT + '1',-1966.578,8847.789,26.00286,0,0,0,100,0), -- 17:21:52
(@GUID,@POINT := @POINT + '1',-1946.478,8824.432,29.30156,0,0,0,100,0), -- 17:22:08
(@GUID,@POINT := @POINT + '1',-1944.506,8822.006,29.37523,0,0,0,100,0), -- 17:22:22
(@GUID,@POINT := @POINT + '1',-1925.181,8787.125,27.40347,0,0,0,100,0), -- 17:22:30
(@GUID,@POINT := @POINT + '1',-1916.387,8762.832,26.09533,0,0,0,100,0), -- 17:22:42
(@GUID,@POINT := @POINT + '1',-1874.201,8754.344,26.05693,0,0,0,100,0), -- 17:22:51
(@GUID,@POINT := @POINT + '1',-1854.197,8759.664,28.04397,0,0,0,100,0), -- 17:23:09
(@GUID,@POINT := @POINT + '1',-1840.163,8769.178,30.26139,0,0,0,100,0), -- 17:23:18
(@GUID,@POINT := @POINT + '1',-1815.867,8780.174,31.31474,0,0,0,100,0), -- 17:23:26
(@GUID,@POINT := @POINT + '1',-1791.843,8788.039,30.60195,0,0,0,100,0), -- 17:23:39
(@GUID,@POINT := @POINT + '1',-1778.97,8792.19,28.33318,0,0,0,100,0), -- 17:23:44
(@GUID,@POINT := @POINT + '1',-1785.26,8790.171,29.29748,0,0,0,100,0); -- 17:23:52
-- 0x203AF4424012C04000004E0000273198 .go -1800.628 8785.258 31.36622

-- Pathing for  Entry: 19201 'TDB FORMAT' 
SET @GUID := 68736;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-1882.313,8993.66,38.3989,0,0,0,100,0), -- 17:35:09
(@GUID,@POINT := @POINT + '1',-1871.939,8953.98,41.94349,0,0,0,100,0), -- 17:35:23
(@GUID,@POINT := @POINT + '1',-1836.418,8920.867,36.96106,0,0,0,100,0), -- 17:35:36
(@GUID,@POINT := @POINT + '1',-1832.932,8918.501,36.04041,0,0,0,100,0), -- 17:35:54
(@GUID,@POINT := @POINT + '1',-1782.748,8893.457,34.7769,0,0,0,100,0), -- 17:36:08
(@GUID,@POINT := @POINT + '1',-1749.646,8880.189,32.58824,30000,0,0,100,0), -- 17:36:18
(@GUID,@POINT := @POINT + '1',-1749.675,8880.189,32.43178,0,0,0,100,0), -- 17:39:58
(@GUID,@POINT := @POINT + '1',-1716.815,8865.834,35.36955,0,0,0,100,0), -- 17:40:13
(@GUID,@POINT := @POINT + '1',-1701.336,8863.66,33.39202,0,0,0,100,0), -- 17:40:26
(@GUID,@POINT := @POINT + '1',-1663.693,8847.714,34.84836,0,0,0,100,0), -- 17:40:42
(@GUID,@POINT := @POINT + '1',-1666.743,8834.359,36.58212,0,0,0,100,0), -- 17:40:52
(@GUID,@POINT := @POINT + '1',-1692.787,8829.908,35.22899,0,0,0,100,0), -- 17:40:58
(@GUID,@POINT := @POINT + '1',-1728.21,8834.949,35.92305,0,0,0,100,0), -- 17:41:09
(@GUID,@POINT := @POINT + '1',-1763.568,8846.715,28.71403,0,0,0,100,0), -- 17:41:28
(@GUID,@POINT := @POINT + '1',-1786.974,8851.196,30.74931,0,0,0,100,0), -- 17:41:39
(@GUID,@POINT := @POINT + '1',-1804.311,8857.869,29.32577,0,0,0,100,0), -- 17:41:51
(@GUID,@POINT := @POINT + '1',-1836.927,8878.327,34.59752,0,0,0,100,0), -- 17:42:01
(@GUID,@POINT := @POINT + '1',-1857.11,8892.201,36.93163,0,0,0,100,0), -- 17:42:12
(@GUID,@POINT := @POINT + '1',-1886.158,8898.459,37.84557,0,0,0,100,0), -- 17:42:24
(@GUID,@POINT := @POINT + '1',-1902.083,8901.02,38.78384,0,0,0,100,0), -- 17:42:37
(@GUID,@POINT := @POINT + '1',-1966.359,8933.63,38.7355,0,0,0,100,0), -- 17:42:54
(@GUID,@POINT := @POINT + '1',-1976.945,8945.818,37.83896,0,0,0,100,0), -- 17:43:13
(@GUID,@POINT := @POINT + '1',-1972.83,9000.511,41.57624,0,0,0,100,0), -- 17:43:20
(@GUID,@POINT := @POINT + '1',-1955.283,9009.258,41.16612,0,0,0,100,0), -- 17:43:39
(@GUID,@POINT := @POINT + '1',-1924.979,9016.831,40.69277,0,0,0,100,0), -- 17:43:48
(@GUID,@POINT := @POINT + '1',-1917.55,9015.53,40.05937,0,0,0,100,0), -- 17:44:00
(@GUID,@POINT := @POINT + '1',-1885.793,9012.721,41.2858,0,0,0,100,0); -- 17:44:11
-- 0x203AF4424012C04000004E0000274379 .go -1882.313 8993.66 38.3989

-- ----------------------------------------------------------
-- Living Cyclone's
-- ----------------------------------------------------------

-- Missing spawns (from Corona DB)
DELETE FROM `creature` WHERE `guid` IN (60656,60657);
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `curhealth`, `curmana`, `MovementType`) VALUES 
('60656', '17160', '530', '-1681.28', '8826.55', '36.8134', '5.55995', '300', '4892', '2846', '1'),
('60657', '17160', '530', '-1694.04', '8954.35', '40.0056', '1.06649', '300', '4892', '2846', '1');


-- Pathing for  Entry: 17160 'TDB FORMAT' 
SET @GUID := 60646;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2218.909,8532.035,-14.55127,0,0,0,100,0), -- 18:55:58
(@GUID,2,-2213.463,8493.347,-15.9245,0,0,0,100,0), -- 18:56:11
(@GUID,3,-2235.288,8487.771,-20.22474,0,0,0,100,0), -- 18:56:27
(@GUID,4,-2271.988,8484.273,-25.57598,0,0,0,100,0), -- 18:56:37
(@GUID,5,-2300.219,8478.117,-27.93031,0,0,0,100,0), -- 18:56:53
(@GUID,6,-2343.819,8477.945,-30.46092,0,0,0,100,0), -- 18:57:06
(@GUID,7,-2345.436,8478.367,-30.71931,0,0,0,100,0), -- 18:57:20
(@GUID,8,-2366.974,8534.188,-28.57604,0,0,0,100,0), -- 18:57:31
(@GUID,9,-2364.656,8538.896,-27.93513,0,0,0,100,0), -- 18:57:46
(@GUID,10,-2337.154,8588.368,-22.77536,0,0,0,100,0), -- 18:57:57
(@GUID,11,-2333.299,8614.905,-19.03483,0,0,0,100,0), -- 18:58:13
(@GUID,12,-2323.921,8652.335,-14.08994,0,0,0,100,0), -- 18:58:29
(@GUID,13,-2287.332,8677.703,-10.03967,0,0,0,100,0), -- 18:58:38
(@GUID,14,-2259.379,8681.381,-6.591813,0,0,0,100,0), -- 18:58:58
(@GUID,15,-2221.033,8678.025,-4.474685,0,0,0,100,0), -- 18:59:11
(@GUID,16,-2190.501,8652.262,-2.895641,0,0,0,100,0), -- 18:59:24
(@GUID,17,-2203.092,8626.182,-3.644493,0,0,0,100,0), -- 18:59:41
(@GUID,18,-2230.453,8595.404,-9.703726,0,0,0,100,0), -- 18:59:55
(@GUID,19,-2238.125,8550.227,-13.32629,0,0,0,100,0); -- 19:00:11
-- 0x203AF4424010C20000004E0000273692 .go -2218.909 8532.035 -14.55127

-- Pathing for  Entry: 17160 'TDB FORMAT' 
SET @GUID := 60647;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2851.062,`position_y`=8604.486,`position_z`=-26.98985 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2851.062,8604.486,-26.98985,0,0,0,100,0), -- 19:18:28
(@GUID,2,-2853.612,8565.762,-28.95748,0,0,0,100,0), -- 19:18:39
(@GUID,3,-2856.305,8518.212,-28.2282,0,0,0,100,0), -- 19:18:49
(@GUID,4,-2857.343,8508.396,-26.69543,0,0,0,100,0), -- 19:19:06
(@GUID,5,-2856.817,8454.49,-30.37154,0,0,0,100,0), -- 19:19:14
(@GUID,6,-2858.391,8433.736,-28.13358,0,0,0,100,0), -- 19:19:33
(@GUID,7,-2856.243,8408.164,-29.54103,0,0,0,100,0), -- 19:19:42
(@GUID,8,-2870.582,8358.115,-30.76497,0,0,0,100,0), -- 19:19:59
(@GUID,9,-2877.267,8347.434,-30.35114,0,0,0,100,0), -- 19:20:18
(@GUID,10,-2912.502,8287.769,-34.04604,0,0,0,100,0), -- 19:20:31
(@GUID,11,-2943.914,8246.276,-33.56764,0,0,0,100,0), -- 19:20:48
(@GUID,12,-2947.085,8216.837,-32.07269,0,0,0,100,0), -- 19:21:08
(@GUID,13,-2946.495,8202.583,-31.15883,0,0,0,100,0), -- 19:21:21
(@GUID,14,-2944.915,8155.916,-28.40335,0,0,0,100,0), -- 19:21:33
(@GUID,15,-2940.201,8106.595,-25.62872,0,0,0,100,0), -- 19:21:49
(@GUID,16,-2924.944,8081.14,-25.20331,0,0,0,100,0), -- 19:22:05
(@GUID,17,-2909.327,8058.345,-26.6944,0,0,0,100,0), -- 19:22:18
(@GUID,18,-2891.889,8032.808,-23.66979,0,0,0,100,0), -- 19:22:30
(@GUID,19,-2902.842,8048.745,-26.66047,0,0,0,100,0), -- 19:22:42
(@GUID,20,-2914.708,8066.444,-25.521,0,0,0,100,0), -- 19:22:51
(@GUID,21,-2938.842,8100.649,-25.0303,0,0,0,100,0), -- 19:23:03
(@GUID,22,-2943.514,8131.927,-28.15734,0,0,0,100,0), -- 19:23:16
(@GUID,23,-2944.651,8176.857,-31.43738,0,0,0,100,0), -- 19:23:32
(@GUID,24,-2944.602,8181.904,-31.56922,0,0,0,100,0), -- 19:23:48
(@GUID,25,-2946.227,8238.67,-33.21095,0,0,0,100,0), -- 19:24:00
(@GUID,26,-2919.207,8278.54,-34.03411,0,0,0,100,0), -- 19:24:14
(@GUID,27,-2895.867,8311.143,-31.49473,0,0,0,100,0), -- 19:24:32
(@GUID,28,-2884.13,8333.227,-30.39072,0,0,0,100,0), -- 19:24:50
(@GUID,29,-2864.657,8367.927,-29.98916,0,0,0,100,0), -- 19:25:03
(@GUID,30,-2858.147,8424.769,-28.00387,0,0,0,100,0), -- 19:25:22
(@GUID,31,-2857.332,8445.621,-30.27377,0,0,0,100,0), -- 19:25:39
(@GUID,32,-2857.913,8492.428,-27.05224,0,0,0,100,0), -- 19:25:48
(@GUID,33,-2856.889,8513.242,-27.54257,0,0,0,100,0), -- 19:26:05
(@GUID,34,-2854.012,8549.157,-29.94097,0,0,0,100,0), -- 19:26:15
(@GUID,35,-2855.15,8581.633,-27.27661,0,0,0,100,0), -- 19:26:32
(@GUID,36,-2849.891,8610.896,-26.69648,0,0,0,100,0), -- 19:26:42
(@GUID,37,-2825.622,8633.816,-26.75046,0,0,0,100,0), -- 19:26:54
(@GUID,38,-2848.538,8613.273,-26.45103,0,0,0,100,0); -- 19:27:12
-- 0x203AF4424010C20000004E0000271DE1 .go -2851.062 8604.486 -26.98985


-- Pathing for  Entry: 17160 'TDB FORMAT' 
SET @GUID := 60650;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-1180.527,`position_y`=8259.756,`position_z`=11.79787 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1180.527,8259.756,11.79787,0,0,0,100,0), -- 22:15:33
(@GUID,2,-1208.19,8283.085,9.375608,0,0,0,100,0), -- 22:15:46
(@GUID,3,-1243.406,8284.08,4.280885,0,0,0,100,0), -- 22:15:57
(@GUID,4,-1279.378,8252.215,-0.9195747,0,0,0,100,0), -- 22:16:11
(@GUID,5,-1281.549,8282.41,2.547065,0,0,0,100,0), -- 22:16:34
(@GUID,6,-1262.651,8289.77,5.181315,0,0,0,100,0), -- 22:16:45
(@GUID,7,-1219.715,8320.075,10.71095,0,0,0,100,0), -- 22:17:01
(@GUID,8,-1202.644,8340.688,19.24014,0,0,0,100,0), -- 22:17:17
(@GUID,9,-1179.973,8345.475,22.11248,0,0,0,100,0), -- 22:17:29
(@GUID,10,-1174.452,8345.74,21.92912,0,0,0,100,0), -- 22:17:39
(@GUID,11,-1141.888,8333.143,21.9819,0,0,0,100,0), -- 22:17:55
(@GUID,12,-1114.821,8318.269,21.72685,0,0,0,100,0), -- 22:18:08
(@GUID,13,-1051.624,8321.764,21.82816,0,0,0,100,0), -- 22:18:18
(@GUID,14,-1013.136,8301.93,15.25349,0,0,0,100,0), -- 22:18:34
(@GUID,15,-1041.813,8321.18,21.19265,0,0,0,100,0), -- 22:18:56
(@GUID,16,-1078.513,8321.752,21.43271,0,0,0,100,0), -- 22:19:05
(@GUID,17,-1087.745,8321.825,21.25556,0,0,0,100,0), -- 22:19:25
(@GUID,18,-1146.156,8335.557,21.69788,0,0,0,100,0), -- 22:19:34
(@GUID,19,-1148.237,8336.811,21.63617,0,0,0,100,0), -- 22:19:50
(@GUID,20,-1196.33,8344.121,20.71226,0,0,0,100,0), -- 22:20:00
(@GUID,21,-1216.812,8323.146,11.78852,0,0,0,100,0), -- 22:20:11
(@GUID,22,-1240.605,8299.116,6.195087,0,0,0,100,0), -- 22:20:29
(@GUID,23,-1278.502,8285.098,3.645116,0,0,0,100,0), -- 22:20:37
(@GUID,24,-1281.754,8266.367,-1.034753,0,0,0,100,0), -- 22:20:53
(@GUID,25,-1249.098,8281.325,3.381279,0,0,0,100,0), -- 22:21:08
(@GUID,26,-1213.483,8285.096,8.44901,0,0,0,100,0), -- 22:21:27
(@GUID,27,-1196.676,8272.297,11.64876,0,0,0,100,0), -- 22:21:42
(@GUID,28,-1161.769,8247.777,10.07712,0,0,0,100,0), -- 22:21:53
(@GUID,29,-1160.778,8211.513,5.701956,0,0,0,100,0), -- 22:22:07
(@GUID,30,-1168.08,8187.924,1.462332,0,0,0,100,0), -- 22:22:23
(@GUID,31,-1174.12,8155.979,1.800441,0,0,0,100,0), -- 22:22:35
(@GUID,32,-1172.058,8176.729,1.013165,0,0,0,100,0), -- 22:22:47
(@GUID,33,-1161.829,8204.387,4.388052,0,0,0,100,0), -- 22:22:55
(@GUID,34,-1161.278,8241.381,9.467208,0,0,0,100,0); -- 22:23:08
-- 0x203AF4424010C20000004E0000275972 .go -1180.527 8259.756 11.79787

-- Pathing for  Entry: 17160 'TDB FORMAT' 
SET @GUID := 60652;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-847.6241,8506.102,46.51483,0,0,0,100,0), -- 22:44:48
(@GUID,@POINT := @POINT + '1',-885.6124,8492.075,47.08598,0,0,0,100,0), -- 22:45:09
(@GUID,@POINT := @POINT + '1',-910.4478,8501.637,45.99551,0,0,0,100,0), -- 22:45:20
(@GUID,@POINT := @POINT + '1',-949.2445,8515.805,46.90946,0,0,0,100,0), -- 22:45:33
(@GUID,@POINT := @POINT + '1',-976.4283,8513.402,45.46638,0,0,0,100,0), -- 22:45:49
(@GUID,@POINT := @POINT + '1',-995.79,8488.892,41.1385,0,0,0,100,0), -- 22:46:03
(@GUID,@POINT := @POINT + '1',-1001.121,8471.082,38.10412,0,0,0,100,0), -- 22:46:12
(@GUID,@POINT := @POINT + '1',-995.4634,8451.914,40.31676,0,0,0,100,0), -- 22:46:27
(@GUID,@POINT := @POINT + '1',-975.4257,8423.902,34.86913,0,0,0,100,0), -- 22:46:34
(@GUID,@POINT := @POINT + '1',-957.0313,8412.603,36.46369,0,0,0,100,0), -- 22:46:45
(@GUID,@POINT := @POINT + '1',-916.869,8402.206,29.6397,0,0,0,100,0), -- 22:47:03
(@GUID,@POINT := @POINT + '1',-889.0398,8409.73,33.77266,0,0,0,100,0), -- 22:47:10
(@GUID,@POINT := @POINT + '1',-884.9122,8411.354,34.38969,0,0,0,100,0), -- 22:47:23
(@GUID,@POINT := @POINT + '1',-851.2719,8457.979,34.22821,0,0,0,100,0), -- 22:47:38
(@GUID,@POINT := @POINT + '1',-818.7665,8468.701,35.97379,0,0,0,100,0), -- 22:48:03
(@GUID,@POINT := @POINT + '1',-788.2867,8481.544,39.92352,0,0,0,100,0), -- 22:48:05
(@GUID,@POINT := @POINT + '1',-772.3636,8499.309,41.57874,0,0,0,100,0), -- 22:48:19
(@GUID,@POINT := @POINT + '1',-760.1832,8535.275,46.50875,0,0,0,100,0), -- 22:48:31
(@GUID,@POINT := @POINT + '1',-749.8218,8557.404,47.89983,0,0,0,100,0), -- 22:48:46
(@GUID,@POINT := @POINT + '1',-727.6384,8550.875,49.25499,0,0,0,100,0), -- 22:48:53
(@GUID,@POINT := @POINT + '1',-716.4973,8546.428,49.82978,0,0,0,100,0), -- 22:49:08
(@GUID,@POINT := @POINT + '1',-702.9384,8521.404,47.29637,0,0,0,100,0), -- 22:49:10
(@GUID,@POINT := @POINT + '1',-695.9539,8501.604,44.29335,0,0,0,100,0), -- 22:49:24
(@GUID,@POINT := @POINT + '1',-714.644,8474.453,37.31478,0,0,0,100,0), -- 22:49:34
(@GUID,@POINT := @POINT + '1',-746.7903,8474.797,40.27406,0,0,0,100,0), -- 22:49:56
(@GUID,@POINT := @POINT + '1',-759.4641,8483.564,41.5388,0,0,0,100,0), -- 22:50:04
(@GUID,@POINT := @POINT + '1',-808.5963,8521.328,46.28402,0,0,0,100,0); -- 22:50:20
-- 0x203AF4424010C20000004E00002786A9 .go -749.7501 8557.416 47.83742

-- Pathing for  Entry: 17160 'TDB FORMAT' 
SET @GUID := 60654;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-1329.849,8729.318,29.77645,0,0,0,100,0), -- 23:03:46
(@GUID,@POINT := @POINT + '1',-1345.848,8732.217,28.78369,0,0,0,100,0), -- 23:03:58
(@GUID,@POINT := @POINT + '1',-1371.013,8747.047,29.38465,0,0,0,100,0), -- 23:04:08
(@GUID,@POINT := @POINT + '1',-1387.687,8770.004,31.64497,0,0,0,100,0), -- 23:04:20
(@GUID,@POINT := @POINT + '1',-1416.33,8781.183,29.89367,0,0,0,100,0), -- 23:04:28
(@GUID,@POINT := @POINT + '1',-1417.822,8780.176,29.44069,0,0,0,100,0), -- 23:04:40
(@GUID,@POINT := @POINT + '1',-1450.178,8799.719,28.27308,0,0,0,100,0), -- 23:04:50
(@GUID,@POINT := @POINT + '1',-1474.821,8821.99,33.64485,0,0,0,100,0), -- 23:05:01
(@GUID,@POINT := @POINT + '1',-1481.276,8841.878,37.36152,0,0,0,100,0), -- 23:05:11
(@GUID,@POINT := @POINT + '1',-1485.313,8880.046,37.81051,0,0,0,100,0), -- 23:05:23
(@GUID,@POINT := @POINT + '1',-1486.957,8908.776,43.98286,0,0,0,100,0), -- 23:05:35
(@GUID,@POINT := @POINT + '1',-1485.844,8884.578,38.73222,0,0,0,100,0), -- 23:05:48
(@GUID,@POINT := @POINT + '1',-1484.083,8857.072,37.6493,0,0,0,100,0), -- 23:05:58
(@GUID,@POINT := @POINT + '1',-1477.65,8826.271,34.6497,0,0,0,100,0), -- 23:06:12
(@GUID,@POINT := @POINT + '1',-1460.998,8811.525,29.23185,0,0,0,100,0), -- 23:06:23
(@GUID,@POINT := @POINT + '1',-1444.991,8793.285,28.77672,0,0,0,100,0), -- 23:06:32
(@GUID,@POINT := @POINT + '1',-1440.622,8787.981,28.97463,0,0,0,100,0), -- 23:06:43
(@GUID,@POINT := @POINT + '1',-1395.341,8775.701,31.54462,0,0,0,100,0), -- 23:06:53
(@GUID,@POINT := @POINT + '1',-1381.846,8759.529,30.3087,0,0,0,100,0), -- 23:07:05
(@GUID,@POINT := @POINT + '1',-1364.425,8740.752,28.97256,0,0,0,100,0), -- 23:07:14
(@GUID,@POINT := @POINT + '1',-1348.235,8732.832,28.96984,0,0,0,100,0), -- 23:07:26
(@GUID,@POINT := @POINT + '1',-1307.293,8728.733,30.60105,0,0,0,100,0), -- 23:07:37
(@GUID,@POINT := @POINT + '1',-1282.64,8738.605,34.46647,0,0,0,100,0), -- 23:07:49
(@GUID,@POINT := @POINT + '1',-1267.958,8745.07,35.43052,0,0,0,100,0), -- 23:08:00
(@GUID,@POINT := @POINT + '1',-1222.84,8736.021,37.51833,0,0,0,100,0), -- 23:08:11
(@GUID,@POINT := @POINT + '1',-1206.838,8726.57,39.76221,0,0,0,100,0), -- 23:08:24
(@GUID,@POINT := @POINT + '1',-1193.413,8717.713,40.97464,0,0,0,100,0), -- 23:08:32
(@GUID,@POINT := @POINT + '1',-1153.848,8719.697,43.48478,0,0,0,100,0), -- 23:08:47
(@GUID,@POINT := @POINT + '1',-1169.735,8707.974,41.73248,0,0,0,100,0), -- 23:09:00
(@GUID,@POINT := @POINT + '1',-1197.885,8720.727,40.34807,0,0,0,100,0), -- 23:02:46
(@GUID,@POINT := @POINT + '1',-1218.948,8733.604,37.98303,0,0,0,100,0), -- 23:03:02
(@GUID,@POINT := @POINT + '1',-1240.587,8745.244,35.22275,0,0,0,100,0), -- 23:03:09
(@GUID,@POINT := @POINT + '1',-1252.183,8750.959,35.51665,0,0,0,100,0), -- 23:03:23
(@GUID,@POINT := @POINT + '1',-1298.374,8730.303,31.508,0,0,0,100,0); -- 23:03:34
-- 0x203AF4424010C20000004E0000278EE4 .go -1197.885 8720.727 40.34807

-- Pathing for  Entry: 17160 'TDB FORMAT' 
SET @GUID := 60655;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-1324.84,8611.415,24.3239,0,0,0,100,0), -- 23:19:08
(@GUID,@POINT := @POINT + '1',-1329.201,8646.008,24.05163,0,0,0,100,0), -- 23:19:29
(@GUID,@POINT := @POINT + '1',-1327.408,8682.793,29.86036,0,0,0,100,0), -- 23:19:42
(@GUID,@POINT := @POINT + '1',-1320.487,8705.758,28.43415,0,0,0,100,0), -- 23:20:11
(@GUID,@POINT := @POINT + '1',-1310.705,8751.045,35.48253,0,0,0,100,0), -- 23:20:11
-- (@GUID,@POINT := @POINT + '1',-1307.489,8791.121,33.87317,0,0,0,100,0), -- 23:20:26
-- (@GUID,@POINT := @POINT + '1',-1307.615,8789.503,33.34456,0,0,0,100,0), -- 23:20:40
-- (@GUID,@POINT := @POINT + '1',-1310.659,8750.904,35.48589,0,0,0,100,0), -- 23:13:01
(@GUID,@POINT := @POINT + '1',-1307.466,8791.086,33.90017,0,0,0,100,0), -- 23:13:13
-- (@GUID,@POINT := @POINT + '1',-1307.57,8790.064,33.39592,0,0,0,100,0), -- 23:13:32
(@GUID,@POINT := @POINT + '1',-1304.622,8821.599,45.152412,0,0,0,100,0), -- 23:13:54
(@GUID,@POINT := @POINT + '1',-1307.374,8792.206,33.71959,0,0,0,100,0), -- 23:14:19
(@GUID,@POINT := @POINT + '1',-1309.528,8763.512,35.85816,0,0,0,100,0), -- 23:14:22
(@GUID,@POINT := @POINT + '1',-1313.73,8721.64,29.05592,0,0,0,100,0), -- 23:14:42
(@GUID,@POINT := @POINT + '1',-1326.086,8692.776,30.10572,0,0,0,100,0), -- 23:14:48
(@GUID,@POINT := @POINT + '1',-1329.644,8654.186,23.90092,0,0,0,100,0), -- 23:15:01
(@GUID,@POINT := @POINT + '1',-1326.048,8614.336,24.7538,0,0,0,100,0), -- 23:15:17
(@GUID,@POINT := @POINT + '1',-1307.329,8592.754,20.00387,0,0,0,100,0), -- 23:15:35
(@GUID,@POINT := @POINT + '1',-1260.748,8563.608,23.83166,0,0,0,100,0), -- 23:15:57
(@GUID,@POINT := @POINT + '1',-1237.174,8556.889,30.38428,0,0,0,100,0), -- 23:16:09
(@GUID,@POINT := @POINT + '1',-1187.048,8526.018,30.46066,0,0,0,100,0), -- 23:16:24
(@GUID,@POINT := @POINT + '1',-1175.692,8520.717,31.32639,0,0,0,100,0), -- 23:16:42
(@GUID,@POINT := @POINT + '1',-1118.066,8509.112,32.60777,0,0,0,100,0), -- 23:17:01
(@GUID,@POINT := @POINT + '1',-1075.616,8490.703,37.06806,0,0,0,100,0), -- 23:17:15
(@GUID,@POINT := @POINT + '1',-1112.405,8507.679,33.73273,0,0,0,100,0), -- 23:17:36
(@GUID,@POINT := @POINT + '1',-1130.282,8509.166,31.58519,0,0,0,100,0), -- 23:17:48
(@GUID,@POINT := @POINT + '1',-1144.1,8509.896,30.99378,0,0,0,100,0), -- 23:18:03
(@GUID,@POINT := @POINT + '1',-1220.687,8551.584,29.93642,0,0,0,100,0), -- 23:18:19
(@GUID,@POINT := @POINT + '1',-1258.476,8562.503,24.51159,0,0,0,100,0), -- 23:18:37
(@GUID,@POINT := @POINT + '1',-1294.4,8579.377,20.14703,0,0,0,100,0); -- 23:18:57
-- 0x203AF4424010C20000004E000027852A .go -1310.659 8750.904 35.48589

-- Pathing for  Entry: 17160 'TDB FORMAT' 
SET @GUID := 60656;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1751.981,8803.936,33.19414,0,0,0,100,0), -- 23:46:33
(@GUID,2,-1767.672,8809.592,28.82925,0,0,0,100,0), -- 23:46:49
(@GUID,3,-1813.099,8810.471,30.90652,0,0,0,100,0), -- 23:47:00
(@GUID,4,-1830.744,8819.027,27.90022,0,0,0,100,0), -- 23:47:15
(@GUID,5,-1876.968,8840.01,29.69574,0,0,0,100,0), -- 23:47:30
(@GUID,6,-1895.012,8833.254,29.23977,0,0,0,100,0), -- 23:47:45
(@GUID,7,-1935.814,8823.287,29.24092,0,0,0,100,0), -- 23:47:57
(@GUID,8,-1961.692,8834.017,26.24941,0,0,0,100,0), -- 23:48:12
(@GUID,9,-1973.036,8845.234,23.9778,0,0,0,100,0), -- 23:48:21
(@GUID,10,-1977.742,8882.643,32.54356,0,0,0,100,0), -- 23:48:30
(@GUID,11,-1972.041,8907.73,39.49168,0,0,0,100,0), -- 23:48:43
(@GUID,12,-1965.393,8911.664,40.52651,0,0,0,100,0), -- 23:48:56
(@GUID,13,-1924.88,8917.485,37.42287,0,0,0,100,0), -- 23:49:02
(@GUID,14,-1900.034,8930.83,36.97285,0,0,0,100,0), -- 23:49:15
(@GUID,15,-1868.678,8943.331,41.89066,0,0,0,100,0), -- 23:49:27
(@GUID,16,-1841.491,8948.025,41.04195,0,0,0,100,0), -- 23:49:42
(@GUID,17,-1828.61,8939.722,39.24327,0,0,0,100,0), -- 23:49:50
(@GUID,18,-1819.398,8933.352,39.06162,0,0,0,100,0), -- 23:50:01
(@GUID,19,-1786.593,8900.07,35.72157,0,0,0,100,0), -- 23:50:10
(@GUID,20,-1765.321,8885.568,30.71168,0,0,0,100,0), -- 23:50:21
(@GUID,21,-1742.2,8862.65,34.80313,0,0,0,100,0), -- 23:50:36
(@GUID,22,-1720.517,8848.105,34.74336,0,0,0,100,0), -- 23:50:46
(@GUID,23,-1692.387,8835.063,34.99734,0,0,0,100,0), -- 23:50:56
(@GUID,24,-1668.529,8815.561,38.73476,0,0,0,100,0), -- 23:51:09
(@GUID,25,-1695.455,8800.848,33.58766,0,0,0,100,0), -- 23:51:23
(@GUID,26,-1712.963,8792.557,29.20308,0,0,0,100,0); -- 23:51:36
-- 0x203AF4424010C20000004E00002785E0 .go -1751.981 8803.936 33.19414

-- ----------------------------------------------------------
-- Clefthoof packs in Nagrand
-- ----------------------------------------------------------

-- Add missing Clefthoof spawns
DELETE FROM `creature` WHERE `guid` IN (181446,181447,181448);
INSERT INTO `creature` (`guid`, `id`, `map`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `curhealth`) VALUES 
('181446', '18205', '530', '-2694.656', '7679.033', '-18.07502', '5.18131', '300', '0', '5715'),
('181447', '18205', '530', '-2212.798', '7642.844', '-18.07502', '-18.30746', '300', '0', '5715'),
('181448', '18205', '530', '-2212.798', '7642.844', '-18.07502', '-18.30746', '300', '0', '5715');
-- Not sure why this one had 25s respawn, all others have 300
UPDATE `creature` SET `spawntimesecs`=300 WHERE `guid`=181445;

-- 1 Bull, 4 Clefthoof, 2 Calf
DELETE FROM `creature_formations` WHERE `leaderGUID`=59983;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(59983,59983,0,0,0), -- Bull
(59983,65052,10,0.7,0), -- Clefthoof
(59983,65051,10,1.5,0), -- Clefthoof
(59983,65053,10,4.7,0), -- Clefthoof 
(59983,65054,10,5.5,0), -- Clefthoof
(59983,68630,10,2.3,0), -- Calf
(59983,68629,10,3.9,0); -- Calf

UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-2582.664,`position_y`=7885.661,`position_z`=-54.54472 WHERE `guid` IN (65052,65051,65053,65054,68630,68629);

-- Pathing for  Entry: 17132 'TDB FORMAT' 
SET @GUID := 59983;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2582.664,`position_y`=7885.661,`position_z`=-54.54472 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2582.664,7885.661,-54.54472,0,0,0,100,0), -- 01:26:30
(@GUID,@POINT := @POINT + '1',-2567.906,7885.974,-54.03246,0,0,0,100,0), -- 01:26:41
(@GUID,@POINT := @POINT + '1',-2523.622,7879.178,-51.87878,0,0,0,100,0), -- 01:26:52
(@GUID,@POINT := @POINT + '1',-2513.863,7839.92,-48.37919,0,0,0,100,0), -- 01:27:06
(@GUID,@POINT := @POINT + '1',-2525.054,7828.949,-45.29484,0,0,0,100,0), -- 01:27:23
(@GUID,@POINT := @POINT + '1',-2543.11,7815.13,-44.15993,0,0,0,100,0), -- 01:27:33
(@GUID,@POINT := @POINT + '1',-2558.591,7794.416,-41.86953,0,0,0,100,0), -- 01:27:40
(@GUID,@POINT := @POINT + '1',-2569.043,7777,-39.92451,0,0,0,100,0), -- 01:27:50
(@GUID,@POINT := @POINT + '1',-2578.232,7763.182,-37.44819,0,0,0,100,0), -- 01:27:57
(@GUID,@POINT := @POINT + '1',-2585.56,7746.999,-33.98311,0,0,0,100,0), -- 01:28:05
(@GUID,@POINT := @POINT + '1',-2590.046,7732.152,-30.76868,0,0,0,100,0), -- 01:28:12
(@GUID,@POINT := @POINT + '1',-2597.008,7717.748,-28.50545,0,0,0,100,0), -- 01:28:18
(@GUID,@POINT := @POINT + '1',-2610.855,7704.224,-25.33329,0,0,0,100,0), -- 01:28:25
(@GUID,@POINT := @POINT + '1',-2656.998535,7709.767090,-28.212711,0,0,0,100,0), -- 01:28:33 
(@GUID,@POINT := @POINT + '1',-2682.146729,7703.314453,-25.047697,0,0,0,100,0), -- 01:28:50 
(@GUID,@POINT := @POINT + '1',-2710.835,7676.221,-14.20121,0,0,0,100,0), -- 01:29:07
(@GUID,@POINT := @POINT + '1',-2733.511,7672.114,-12.80436,0,0,0,100,0), -- 01:29:15
(@GUID,@POINT := @POINT + '1',-2744.733,7669.799,-12.1274,0,0,0,100,0), -- 01:29:25
(@GUID,@POINT := @POINT + '1',-2760.551,7666.779,-12.13447,0,0,0,100,0), -- 01:29:35
(@GUID,@POINT := @POINT + '1',-2776.92,7683.984,-10.61778,0,0,0,100,0), -- 01:29:41
(@GUID,@POINT := @POINT + '1',-2779.63,7703.997,-12.72672,0,0,0,100,0), -- 01:29:47
(@GUID,@POINT := @POINT + '1',-2767.821777,7715.978027,-16.010204,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2765.256,7734.458,-20.69319,0,0,0,100,0), -- 01:29:56
(@GUID,@POINT := @POINT + '1',-2755.092,7744.958,-22.13419,0,0,0,100,0), -- 01:30:10
(@GUID,@POINT := @POINT + '1',-2738.323730,7756.058594,-26.921783,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-2723.601,7766.869,-30.32949,0,0,0,100,0), -- 01:30:16
(@GUID,@POINT := @POINT + '1',-2695.65,7783.267,-33.61748,0,0,0,100,0), -- 01:30:30
(@GUID,@POINT := @POINT + '1',-2679.206,7796.113,-39.4891,0,0,0,100,0), -- 01:30:44
(@GUID,@POINT := @POINT + '1',-2649.058,7819.751,-42.16552,0,0,0,100,0), -- 01:30:52
(@GUID,@POINT := @POINT + '1',-2625.69,7845.158,-45.1545,0,0,0,100,0), -- 01:31:12
(@GUID,@POINT := @POINT + '1',-2604.82,7867.244,-50.159,0,0,0,100,0); -- 01:31:22
-- 0x203AF4424010BB0000004E000023BC76 .go -2582.664 7885.661 -54.54472

-- 1 Bull, 3 Clefthoof, 1 Calf

DELETE FROM `creature_formations` WHERE `leaderGUID`=59986;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(59986,59986,0,0,0), -- Bull
(59986,65056,10,0.7,0), -- Clefthoof
(59986,65057,10,3.9,0), -- Clefthoof
(59986,65055,10,2.3,0), -- Clefthoof
(59986,68631,10,5.5,0); -- Calf

UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-2749.328,`position_y`=7855.484,`position_z`=-34.06189 WHERE `guid` IN (65056,65057,65055,68631);

-- Pathing for  Entry: 17132 'TDB FORMAT' 
SET @GUID := 59986;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2749.328,`position_y`=7855.484,`position_z`=-34.06189 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2749.328,7855.484,-34.06189,0,0,0,100,0), -- 14:09:35
(@GUID,2,-2728.664,7860.593,-39.103,0,0,0,100,0), -- 14:09:50
(@GUID,3,-2711.897,7862.271,-42.26756,0,0,0,100,0), -- 14:09:58
(@GUID,4,-2695.868,7863.63,-43.16758,0,0,0,100,0), -- 14:10:06
(@GUID,5,-2673.683,7868.456,-45.53575,0,0,0,100,0), -- 14:10:14
(@GUID,6,-2650.029,7872.975,-48.53274,0,0,0,100,0), -- 14:10:21
(@GUID,7,-2625.483,7876.098,-49.58039,0,0,0,100,0), -- 14:10:33
(@GUID,8,-2602.635,7879.193,-52.35776,0,0,0,100,0), -- 14:10:42
(@GUID,9,-2596.499,7880.02,-53.19814,0,0,0,100,0), -- 14:10:52
(@GUID,10,-2577.097,7879.104,-53.44668,0,0,0,100,0), -- 14:10:59
(@GUID,11,-2523.105,7878.628,-51.8253,0,0,0,100,0), -- 14:11:12
(@GUID,12,-2503.91,7877.2,-51.24072,0,0,0,100,0), -- 14:11:22
(@GUID,13,-2475.22,7874.914,-49.30717,0,0,0,100,0), -- 14:11:31
(@GUID,14,-2466.848389,7848.893066,-46.633808,0,0,0,100,0), -- 14:11:40 --C
(@GUID,15,-2464.659912,7831.702637,-44.124992,0,0,0,100,0), -- 14:11:56 --C
(@GUID,16,-2462.256,7814.089,-40.9869,0,0,0,100,0), -- 14:12:02
(@GUID,17,-2487.967,7801.904,-40.27177,0,0,0,100,0), -- 14:12:12
(@GUID,18,-2532.932,7801.175,-41.0661,0,0,0,100,0), -- 14:12:23
(@GUID,19,-2546.34,7801.104,-42.39443,0,0,0,100,0), -- 14:12:41
(@GUID,20,-2568.648,7801.215,-42.28034,0,0,0,100,0), -- 14:12:53
(@GUID,21,-2629.898,7795.53,-39.8434,0,0,0,100,0), -- 14:13:09
(@GUID,22,-2658.01,7793.965,-40.11377,0,0,0,100,0), -- 14:13:22
(@GUID,23,-2681.57,7788.672,-37.4698,0,0,0,100,0), -- 14:13:32
(@GUID,24,-2706.089,7778.329,-31.97561,0,0,0,100,0), -- 14:13:41
(@GUID,25,-2735.795,7773.435,-29.87989,0,0,0,100,0), -- 14:13:53
(@GUID,26,-2756.661,7773.131,-25.51587,0,0,0,100,0), -- 14:14:04
(@GUID,27,-2773.296,7777.635,-24.23773,0,0,0,100,0), -- 14:14:12
(@GUID,28,-2788.555,7791.825,-19.11279,0,0,0,100,0), -- 14:14:18
(@GUID,29,-2793.622,7804.069,-20.21746,0,0,0,100,0), -- 14:14:28
(@GUID,30,-2782.241,7841.168,-28.69229,0,0,0,100,0); -- 14:14:34
-- 0x203AF4424010BB0000004E0000A3A9E3 .go -2749.328 7855.484 -34.06189

-- 1 Bull, 4 Clefthoof, 2 Calf
DELETE FROM `creature_formations` WHERE `leaderGUID`=59987;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(59987,59987,0,0,0), -- Bull
(59987,65048,10,0.7,0), -- Clefthoof
(59987,65050,10,1.5,0), -- Clefthoof
(59987,65049,10,4.7,0), -- Clefthoof 
(59987,181446,10,5.5,0), -- Clefthoof
(59987,68628,10,2.3,0), -- Calf
(59987,68632,10,3.9,0); -- Calf

UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-2694.656,`position_y`=7679.033,`position_z`=-18.07502 WHERE `guid` IN (65048,65050,65049,68628,68632,181446);

-- Pathing for  Entry: 17132 'TDB FORMAT' 
SET @GUID := 59987;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2694.656,`position_y`=7679.033,`position_z`=-18.07502 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2694.656,7679.033,-18.07502,0,0,0,100,0), -- 14:42:07
(@GUID,2,-2656.974,7670.048,-15.47376,0,0,0,100,0), -- 14:42:17
(@GUID,3,-2652.402,7668.645,-15.52887,0,0,0,100,0), -- 14:42:29
(@GUID,4,-2610.103,7654.216,-14.01661,0,0,0,100,0), -- 14:42:36
(@GUID,5,-2591.153,7645.637,-12.02162,0,0,0,100,0), -- 14:42:48
(@GUID,6,-2561.323,7643.456,-12.74269,0,0,0,100,0), -- 14:42:57
(@GUID,7,-2539.129,7661.876,-17.8188,0,0,0,100,0), -- 14:43:08
(@GUID,8,-2532.55,7689.64,-21.56883,0,0,0,100,0), -- 14:43:25
(@GUID,9,-2552.986,7730.301,-31.19198,0,0,0,100,0), -- 14:43:34
(@GUID,10,-2575.109,7746.987,-34.45193,0,0,0,100,0), -- 14:43:51
(@GUID,11,-2582.805176,7793.902344,-41.807865,0,0,0,100,0), -- 14:44:07 --C
(@GUID,12,-2623.025146,7798.501953,-41.530445,0,0,0,100,0), -- 14:44:16 --C
(@GUID,13,-2655.625,7767.865,-36.75452,0,0,0,100,0), -- 14:44:28
(@GUID,14,-2674.65,7765.183,-34.21177,0,0,0,100,0), -- 14:44:37
(@GUID,15,-2701.452,7765.449,-30.58504,0,0,0,100,0), -- 14:44:46
(@GUID,16,-2717.85,7769.892,-31.09562,0,0,0,100,0), -- 14:44:56
(@GUID,17,-2756.941,7778.824,-26.23858,0,0,0,100,0), -- 14:45:07
(@GUID,18,-2780.976318,7774.655762,-21.934942,0,0,0,100,0), -- 14:45:27 --C
(@GUID,19,-2797.683105,7770.476563,-15.790320,0,0,0,100,0), -- 14:45:19 --C
(@GUID,20,-2799.009,7751.888,-14.10312,0,0,0,100,0), -- 14:45:35
(@GUID,21,-2799.733,7749.706,-14.27131,0,0,0,100,0), -- 14:45:43
(@GUID,22,-2780.255,7692.592,-10.98975,0,0,0,100,0), -- 14:45:55
(@GUID,23,-2764.832,7687.478,-12.73743,0,0,0,100,0), -- 14:46:07
(@GUID,24,-2738.414,7683.993,-15.75019,0,0,0,100,0), -- 14:46:16
(@GUID,25,-2708.645,7682.698,-16.07082,0,0,0,100,0); -- 14:46:31
-- 0x203AF4424010BB0000004E000722A885 .go -2694.656 7679.033 -18.07502


-- 1 Bull, 5 Clefthoof, 0 Calf
DELETE FROM `creature_formations` WHERE `leaderGUID`=59989;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(59989,59989,0,0,0), -- Bull
(59989,65060,10,0.7,0), -- Clefthoof
(59989,65058,15,0,0), -- Clefthoof 
(59989,181445,10,5.5,0), -- Clefthoof
(59989,181447,10,2.3,0), -- Clefthoof
(59989,181448,10,3.9,0); -- Clefthoof

UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-2212.798,`position_y`=7642.844,`position_z`=-18.30746 WHERE `guid` IN (65060,65058,181445,181447,181448);
-- Pathing for  Entry: 17132 'TDB FORMAT' 
SET @GUID := 59989;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2212.798,`position_y`=7642.844,`position_z`=-18.30746 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2212.798,7642.844,-18.30746,0,0,0,100,0), -- 15:16:14
(@GUID,@POINT := @POINT + '1',-2227.222,7624.214,-15.17053,0,0,0,100,0), -- 15:16:28
(@GUID,@POINT := @POINT + '1',-2280.136,7612.526,-9.260273,0,0,0,100,0), -- 15:16:39
(@GUID,@POINT := @POINT + '1',-2304.362,7615.188,-4.701969,0,0,0,100,0), -- 15:16:59
(@GUID,@POINT := @POINT + '1',-2344.053,7630.318,-4.197508,0,0,0,100,0), -- 15:17:16
(@GUID,@POINT := @POINT + '1',-2372.733,7664.014,-6.959114,0,0,0,100,0), -- 15:17:27
(@GUID,@POINT := @POINT + '1',-2394.948,7683.438,-11.36308,0,0,0,100,0), -- 15:17:44
(@GUID,@POINT := @POINT + '1',-2419.933,7707.627,-15.30166,0,0,0,100,0), -- 15:17:57
(@GUID,@POINT := @POINT + '1',-2444.152100,7718.977051,-18.350840,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2447.639,7730.747,-20.63128,0,0,0,100,0), -- 15:18:11
(@GUID,@POINT := @POINT + '1',-2467.071045,7730.314453,-23.655447,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2489.186,7730.752,-27.74808,0,0,0,100,0), -- 15:18:24
(@GUID,@POINT := @POINT + '1',-2521.405,7717.604,-25.86868,0,0,0,100,0), -- 15:18:44
(@GUID,@POINT := @POINT + '1',-2544.926,7722.098,-28.68562,0,0,0,100,0), -- 15:18:57
(@GUID,@POINT := @POINT + '1',-2566.218,7725.047,-30.99588,0,0,0,100,0), -- 15:19:07
(@GUID,@POINT := @POINT + '1',-2604.167,7725.69,-28.86899,0,0,0,100,0), -- 15:19:19
(@GUID,@POINT := @POINT + '1',-2631.105,7723.376,-30.03154,0,0,0,100,0), -- 15:19:32
(@GUID,@POINT := @POINT + '1',-2670.957,7717.24,-27.27287,0,0,0,100,0), -- 15:19:44
(@GUID,@POINT := @POINT + '1',-2702.072,7721.095,-25.46005,0,0,0,100,0), -- 15:19:59
(@GUID,@POINT := @POINT + '1',-2726.141,7728.657,-23.23393,0,0,0,100,0), -- 15:20:11
(@GUID,@POINT := @POINT + '1',-2739.961,7733.432,-22.1667,0,0,0,100,0), -- 15:20:23
(@GUID,@POINT := @POINT + '1',-2782.29,7739.2,-17.89948,0,0,0,100,0), -- 15:20:35
(@GUID,@POINT := @POINT + '1',-2794.905,7723.167,-13.05616,0,0,0,100,0), -- 15:20:44
(@GUID,@POINT := @POINT + '1',-2796.92,7698.82,-10.37669,0,0,0,100,0), -- 15:20:54
(@GUID,@POINT := @POINT + '1',-2731.029,7695.752,-16.89625,0,0,0,100,0), -- 15:21:02
(@GUID,@POINT := @POINT + '1',-2710.537,7694.048,-18.32459,0,0,0,100,0), -- 15:21:30
(@GUID,@POINT := @POINT + '1',-2683.458,7693.71,-22.34031,0,0,0,100,0), -- 15:21:38
(@GUID,@POINT := @POINT + '1',-2680.466,7693.592,-22.78121,0,0,0,100,0), -- 15:21:49
(@GUID,@POINT := @POINT + '1',-2675.359619,7684.728516,-19.905119,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2667.972168,7676.687012,-17.497200,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2637.307,7663.331,-14.99821,0,0,0,100,0), -- 15:21:57
(@GUID,@POINT := @POINT + '1',-2627.46,7652.215,-12.57934,0,0,0,100,0), -- 15:22:14
(@GUID,@POINT := @POINT + '1',-2609.165,7637.314,-10.93683,0,0,0,100,0), -- 15:22:20
(@GUID,@POINT := @POINT + '1',-2595.587,7628.897,-9.749682,0,0,0,100,0), -- 15:22:30
(@GUID,@POINT := @POINT + '1',-2563.491943,7627.551270,-10.763746,0,0,0,100,0), -- 15:22:38
(@GUID,@POINT := @POINT + '1',-2543.443848,7609.125488,-7.012755,0,0,0,100,0), -- 15:22:47 --C
(@GUID,@POINT := @POINT + '1',-2531.74,7601.503,-3.30106,0,0,0,100,0), -- 15:22:55
(@GUID,@POINT := @POINT + '1',-2512.573,7605.456,-4.437243,0,0,0,100,0), -- 15:23:06
(@GUID,@POINT := @POINT + '1',-2488.788,7616.915,-3.758238,0,0,0,100,0), -- 15:23:17
(@GUID,@POINT := @POINT + '1',-2467.339,7638.91,-4.340944,0,0,0,100,0), -- 15:23:25
(@GUID,@POINT := @POINT + '1',-2453.296,7659.895,-6.978621,0,0,0,100,0), -- 15:23:37
(@GUID,@POINT := @POINT + '1',-2418.779,7678.434,-9.857171,0,0,0,100,0), -- 15:23:46
(@GUID,@POINT := @POINT + '1',-2397.988,7688.753,-12.80805,0,0,0,100,0), -- 15:24:02
(@GUID,@POINT := @POINT + '1',-2373.26,7707.588,-18.84068,0,0,0,100,0), -- 15:24:11
(@GUID,@POINT := @POINT + '1',-2358.61,7708.731,-20.29558,0,0,0,100,0), -- 15:24:23
(@GUID,@POINT := @POINT + '1',-2338.563,7708.34,-19.30795,0,0,0,100,0), -- 15:24:31
(@GUID,@POINT := @POINT + '1',-2327.801,7707.166,-18.06245,0,0,0,100,0), -- 15:24:38
(@GUID,@POINT := @POINT + '1',-2298.427,7708.467,-19.59582,0,0,0,100,0), -- 15:24:48
(@GUID,@POINT := @POINT + '1',-2283.09,7716.009,-21.19913,0,0,0,100,0), -- 15:24:55
(@GUID,@POINT := @POINT + '1',-2249.317,7722.6,-19.36967,0,0,0,100,0), -- 15:25:05
(@GUID,@POINT := @POINT + '1',-2238.224,7718.114,-16.09093,0,0,0,100,0), -- 15:25:16
(@GUID,@POINT := @POINT + '1',-2222.575,7695.965,-13.21361,0,0,0,100,0), -- 15:25:22
(@GUID,@POINT := @POINT + '1',-2247.484131,7674.131348,-10.926633,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2242.163330,7648.675781,-13.820538,0,0,0,100,0); -- 15:25:32
-- 0x203AF4424010BB0000004E0000247BAB .go -2212.798 7642.844 -18.30746

-- ----------------------------------------------------------
-- Elekks
-- ----------------------------------------------------------

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65650;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2700.05,`position_y`=7707.09,`position_z`=-22.9957 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2674.269,7691.681,-22.02553,0,0,0,100,0), -- 14:42:09
(@GUID,2,-2647.13,7687.174,-21.63469,0,0,0,100,0), -- 14:42:20
(@GUID,3,-2634.092,7690.889,-24.89965,0,0,0,100,0), -- 14:42:31
(@GUID,4,-2595.526,7696.667,-25.62142,0,0,0,100,0), -- 14:42:42
(@GUID,5,-2550.476,7674.772,-21.62527,0,0,0,100,0), -- 14:42:57
(@GUID,6,-2544.033,7645.498,-16.04786,0,0,0,100,0), -- 14:43:12
(@GUID,7,-2548.478,7669.872,-20.55757,0,0,0,100,0), -- 14:43:28
(@GUID,8,-2578.528,7694.802,-25.57306,0,0,0,100,0), -- 14:43:40
(@GUID,9,-2603.167,7696.505,-24.80726,0,0,0,100,0), -- 14:43:56
(@GUID,10,-2643.71,7687.625,-22.29348,0,0,0,100,0), -- 14:44:11
(@GUID,11,-2659.478,7688.336,-20.91553,0,0,0,100,0), -- 14:44:23
(@GUID,12,-2685.064,7699.987,-23.74258,0,0,0,100,0), -- 14:44:34
(@GUID,13,-2714.749,7709.776,-21.0963,0,0,0,100,0), -- 14:44:45
(@GUID,14,-2737.495,7703.183,-17.15627,0,0,0,100,0), -- 14:44:56
(@GUID,15,-2753.035,7689.911,-15.15311,0,0,0,100,0), -- 14:45:05
(@GUID,16,-2742.514,7700.255,-16.58095,0,0,0,100,0), -- 14:45:15
(@GUID,17,-2721.877,7709.784,-19.91874,0,0,0,100,0), -- 14:45:22
(@GUID,18,-2692.772,7705.893,-23.72323,0,0,0,100,0), -- 14:45:32
(@GUID,19,-2674.066,7691.752,-21.89675,0,0,0,100,0), -- 14:45:43
(@GUID,20,-2647.014,7687.249,-21.64456,0,0,0,100,0), -- 14:45:54
(@GUID,21,-2634.09,7690.91,-24.85542,0,0,0,100,0), -- 14:46:04
(@GUID,22,-2595.506,7696.591,-25.62829,0,0,0,100,0), -- 14:46:15
(@GUID,23,-2550.469,7674.769,-21.62007,0,0,0,100,0), -- 14:46:29
(@GUID,24,-2576.608,7690.399,-24.80136,0,0,0,100,0), -- 14:46:34
(@GUID,25,-2575.799,7692.778,-25.154,0,0,0,100,0); -- 14:46:34
-- 0x203AF4424011E78000004E0002A2A883 .go -2674.269 7691.681 -22.02553

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65651;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2749.34,`position_y`=7810.44,`position_z`=-32.9055 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2734.878,7787.57,-31.95395,0,0,0,100,0), -- 17:48:13
(@GUID,2,-2751.098,7813.736,-31.82531,0,0,0,100,0), -- 17:48:32
(@GUID,3,-2766.9,7831.707,-28.99045,0,0,0,100,0), -- 17:48:48
(@GUID,4,-2776.292,7868.074,-32.95581,0,0,0,100,0), -- 17:48:59
(@GUID,5,-2777.775,7900.986,-36.16138,0,0,0,100,0), -- 17:49:14
(@GUID,6,-2788.39,7918.089,-33.02819,0,0,0,100,0), -- 17:49:26
(@GUID,7,-2807.047,7930.485,-28.70544,0,0,0,100,0), -- 17:49:34
(@GUID,8,-2820.076,7942.464,-24.23338,0,0,0,100,0), -- 17:49:44
(@GUID,9,-2811.142,7933.16,-27.23658,0,0,0,100,0), -- 17:49:51
(@GUID,10,-2792.437,7922.438,-32.35848,0,0,0,100,0), -- 17:49:56
(@GUID,11,-2779.116,7904.042,-35.84225,0,0,0,100,0), -- 17:50:06
(@GUID,12,-2777.534,7878.43,-33.79493,0,0,0,100,0), -- 17:50:15
(@GUID,13,-2772.507,7842.947,-29.39881,0,0,0,100,0), -- 17:50:27
(@GUID,14,-2753.878,7817.817,-31.29185,0,0,0,100,0); -- 17:50:41
-- 0x203AF4424011E78000004E000422A884 .go -2734.878 7787.57 -31.95395

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65658;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2194.39,`position_y`=7531.68,`position_z`=-28.4981 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2174.563,7474.802,-33.41673,0,0,0,100,0), -- 23:41:01
(@GUID,2,-2173.903,7465.789,-34.45302,0,0,0,100,0), -- 23:41:13
(@GUID,3,-2168.34,7421.876,-33.72536,0,0,0,100,0), -- 23:41:22
(@GUID,4,-2170.287,7433.129,-35.00093,0,0,0,100,0), -- 23:41:36
(@GUID,5,-2174.035,7469.135,-34.35434,0,0,0,100,0), -- 23:41:49
(@GUID,6,-2177.058,7497.729,-31.92061,0,0,0,100,0), -- 23:41:57
(@GUID,7,-2186.501,7522.515,-30.27327,0,0,0,100,0), -- 23:42:09
(@GUID,8,-2197.183,7534.59,-27.64496,0,0,0,100,0), -- 23:42:19
(@GUID,9,-2210.867,7551.57,-24.63984,0,0,0,100,0), -- 23:42:26
(@GUID,10,-2220.933,7561.727,-22.92727,0,0,0,100,0), -- 23:42:35
(@GUID,11,-2241.067,7570.204,-20.10358,0,0,0,100,0), -- 23:42:42
(@GUID,12,-2260.738,7566.847,-16.69444,0,0,0,100,0), -- 23:42:49
(@GUID,13,-2274.992,7559.235,-14.27239,0,0,0,100,0), -- 23:42:58
(@GUID,14,-2291.522,7561.524,-11.96934,0,0,0,100,0), -- 23:43:05
(@GUID,15,-2308.261,7577.214,-8.312639,0,0,0,100,0), -- 23:43:12
(@GUID,16,-2320.567,7584.441,-7.4962,0,0,0,100,0), -- 23:43:21
(@GUID,17,-2336.248,7588.756,-6.660901,0,0,0,100,0), -- 23:43:27
(@GUID,18,-2326.12,7586.88,-7.028824,0,0,0,100,0), -- 23:43:35
(@GUID,19,-2318.203,7583.188,-7.76639,0,0,0,100,0), -- 23:43:40
(@GUID,20,-2298.529,7566.686,-10.36064,0,0,0,100,0), -- 23:43:46
(@GUID,21,-2281.937,7557.433,-13.36305,0,0,0,100,0), -- 23:43:55
(@GUID,22,-2264.897,7564.749,-15.72989,0,0,0,100,0), -- 23:44:02
(@GUID,23,-2243.441,7570.386,-19.43285,0,0,0,100,0), -- 23:44:10
(@GUID,24,-2226.243,7565.745,-22.0393,0,0,0,100,0), -- 23:44:18
(@GUID,25,-2216.101,7557.269,-23.55024,0,0,0,100,0), -- 23:44:25
(@GUID,26,-2201.051,7538.647,-26.74527,0,0,0,100,0), -- 23:44:33
(@GUID,27,-2191.496,7529.282,-28.76989,0,0,0,100,0), -- 23:44:41
(@GUID,28,-2183.993,7516.437,-31.02223,0,0,0,100,0), -- 23:44:47
(@GUID,29,-2174.547,7474.765,-33.41794,0,0,0,100,0), -- 23:44:58
(@GUID,30,-2173.897,7465.742,-34.46141,0,0,0,100,0), -- 23:45:10
(@GUID,31,-2168.338,7421.841,-33.72625,0,0,0,100,0), -- 23:45:19
(@GUID,32,-2170.287,7433.129,-35.00093,0,0,0,100,0); -- 23:45:33
-- 0x203AF4424011E78000004E000024F34E .go -2174.563 7474.802 -33.41673

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65664;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-1520.43,`position_y`=6779.92,`position_z`=15.7022 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1478.384,6821.081,12.3371,0,0,0,100,0), -- 00:16:41
(@GUID,2,-1461.294,6839.07,13.80124,0,0,0,100,0), -- 00:16:54
(@GUID,3,-1422.633,6884.449,17.41131,0,0,0,100,0), -- 00:17:05
(@GUID,4,-1404.191,6929.119,16.5009,0,0,0,100,0), -- 00:17:24
(@GUID,5,-1399.407,6958.563,13.41168,0,0,0,100,0), -- 00:17:42
(@GUID,6,-1403.5,6931.095,16.08972,0,0,0,100,0), -- 00:17:57
(@GUID,7,-1417.5,6895.715,17.50602,0,0,0,100,0), -- 00:18:09
(@GUID,8,-1447.766,6854.247,14.47745,0,0,0,100,0), -- 00:18:28
(@GUID,9,-1466.076,6833.959,13.08254,0,0,0,100,0), -- 00:18:48
(@GUID,10,-1490.93,6808.366,14.66289,0,0,0,100,0), -- 00:18:58
(@GUID,11,-1499.758,6799.843,16.24991,0,0,0,100,0), -- 00:19:11
(@GUID,12,-1540.873,6755.851,15.91483,0,0,0,100,0), -- 00:19:27
(@GUID,13,-1522.77,6777.234,16.15338,0,0,0,100,0), -- 00:19:43
(@GUID,14,-1493.864,6805.536,15.32713,0,0,0,100,0); -- 00:19:57
-- 0x203AF4424011E78000004E000024FED8 .go -1478.384 6821.081 12.3371



-- Check




-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65657;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1966.289,7782.999,-50.16899,0,0,0,100,0), -- 18:08:38
(@GUID,2,-1968.533,7796.549,-47.72079,0,0,0,100,0), -- 18:08:47
(@GUID,3,-1969.226,7822.298,-41.31853,0,0,0,100,0), -- 18:08:53
(@GUID,4,-1968.798,7843.106,-36.28822,0,0,0,100,0), -- 18:09:03
(@GUID,5,-1968.708,7867.842,-32.81573,0,0,0,100,0), -- 18:09:12
(@GUID,6,-1972.283,7876.478,-30.59978,0,0,0,100,0), -- 18:09:21
(@GUID,7,-1987.089,7896.491,-31.31792,0,0,0,100,0), -- 18:09:29
(@GUID,8,-2011.68,7902.815,-30.0549,0,0,0,100,0), -- 18:09:40
(@GUID,9,-2021.044,7900.263,-29.21589,0,0,0,100,0), -- 18:09:48
(@GUID,10,-2035.616,7890.054,-28.23161,0,0,0,100,0), -- 18:09:53
(@GUID,11,-2060.752,7865.037,-26.96479,0,0,0,100,0), -- 18:09:59
(@GUID,12,-2076.108,7844.815,-22.70536,0,0,0,100,0), -- 18:10:12
(@GUID,13,-2089.256,7827.075,-21.07095,0,0,0,100,0), -- 18:10:23
(@GUID,14,-2105.831,7791.486,-24.94334,0,0,0,100,0), -- 18:10:33
(@GUID,15,-2126.039,7750.967,-27.52921,0,0,0,100,0), -- 18:10:50
(@GUID,16,-2109.755,7782.88,-25.82896,0,0,0,100,0), -- 18:11:08
(@GUID,17,-2096.188,7813.935,-22.10828,0,0,0,100,0), -- 18:11:23
(@GUID,18,-2079.774,7840.229,-21.69007,0,0,0,100,0), -- 18:11:40
(@GUID,19,-2065.585,7858.899,-26.14882,0,0,0,100,0), -- 18:11:49
(@GUID,20,-2052.721,7873.183,-27.95574,0,0,0,100,0), -- 18:12:00
(@GUID,21,-2031.826,7893.363,-28.59493,0,0,0,100,0), -- 18:12:13
(@GUID,22,-2020.586,7900.396,-29.42924,0,0,0,100,0), -- 18:12:20
(@GUID,23,-1998.706,7903.119,-30.6776,0,0,0,100,0), -- 18:12:25
(@GUID,24,-1982.296,7891.21,-30.84521,0,0,0,100,0), -- 18:12:33
(@GUID,25,-1969.664,7871.461,-31.65129,0,0,0,100,0), -- 18:12:44
(@GUID,26,-1968.788,7856.637,-35.1958,0,0,0,100,0), -- 18:12:50
(@GUID,27,-1969.054,7826.09,-40.23038,0,0,0,100,0), -- 18:13:01
(@GUID,28,-1969.389,7801.586,-46.17776,0,0,0,100,0), -- 18:13:10
(@GUID,29,-1966.288,7782.938,-50.05931,0,0,0,100,0), -- 18:13:19
(@GUID,30,-1968.533,7796.549,-47.72079,0,0,0,100,0), -- 18:13:28
(@GUID,31,-1969.296,7822.302,-41.32153,0,0,0,100,0), -- 18:13:34
(@GUID,32,-1968.799,7843.09,-36.13723,0,0,0,100,0), -- 18:13:45
(@GUID,33,-1968.688,7867.88,-32.93111,0,0,0,100,0), -- 18:13:53
(@GUID,34,-1972.282,7876.555,-30.68247,0,0,0,100,0), -- 18:14:03
(@GUID,35,-1987.122,7896.296,-31.28928,0,0,0,100,0); -- 18:14:11
-- 0x203AF4424011E78000004E000025E6CC .go -1966.289 7782.999 -50.16899

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65662;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1577.223,7116.43,9.134361,0,0,0,100,0), -- 21:23:06
(@GUID,2,-1569.741,7127.651,11.35795,0,0,0,100,0), -- 21:23:16
(@GUID,3,-1567.184,7131.216,11.57992,0,0,0,100,0), -- 21:23:23
(@GUID,4,-1566.232,7164.062,9.502401,0,0,0,100,0), -- 21:23:30
(@GUID,5,-1579.337,7179.873,7.692366,0,0,0,100,0), -- 21:23:36
(@GUID,6,-1590.527,7192.306,6.606363,0,0,0,100,0), -- 21:23:46
(@GUID,7,-1616.887,7222.026,6.090874,0,0,0,100,0), -- 21:23:57
(@GUID,8,-1632.668,7235.391,4.303286,0,0,0,100,0), -- 21:24:08
(@GUID,9,-1649.182,7249.502,2.978147,0,0,0,100,0), -- 21:24:16
(@GUID,10,-1663.21,7262.692,1.710088,0,0,0,100,0), -- 21:24:24
(@GUID,11,-1672.39,7280.579,-0.9890751,0,0,0,100,0), -- 21:24:32
(@GUID,12,-1671.511,7291.896,-2.59061,0,0,0,100,0), -- 21:24:40
(@GUID,13,-1672.266,7285.227,-1.696026,0,0,0,100,0), -- 21:24:48
(@GUID,14,-1666.033,7266.865,1.135019,0,0,0,100,0), -- 21:24:54
(@GUID,15,-1653.479,7253.245,2.542091,0,0,0,100,0), -- 21:25:01
(@GUID,16,-1639.864,7241.508,3.429439,0,0,0,100,0), -- 21:25:10
(@GUID,17,-1619.332,7223.901,5.694285,0,0,0,100,0), -- 21:25:18
(@GUID,18,-1612.078,7216.344,6.479156,0,0,0,100,0), -- 21:25:27
(@GUID,19,-1600.532,7203.195,6.74604,0,0,0,100,0), -- 21:25:38
(@GUID,20,-1568.358,7166.74,9.019341,0,0,0,100,0), -- 21:25:49
(@GUID,21,-1561.81,7148.381,10.85218,0,0,0,100,0), -- 21:25:59
(@GUID,22,-1564.552,7139.45,11.80651,0,0,0,100,0); -- 21:26:06
-- 0x203AF4424011E78000004E0000262247 .go -1577.223 7116.43 9.134361

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65647;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1834.752,6454.875,26.86079,0,0,0,100,0), -- 23:32:59
(@GUID,2,-1800.979,6461.191,35.33779,0,0,0,100,0), -- 23:33:08
(@GUID,3,-1793.701,6460.261,40.42421,0,0,0,100,0), -- 23:33:21
(@GUID,4,-1783.613,6462.039,41.75187,0,0,0,100,0), -- 23:33:27
(@GUID,5,-1776.539,6477.089,46.6764,0,0,0,100,0), -- 23:33:33
(@GUID,6,-1776.082,6469.592,43.53386,0,0,0,100,0), -- 23:33:40
(@GUID,7,-1783.878,6461.541,41.92315,0,0,0,100,0), -- 23:33:44
(@GUID,8,-1798.169,6461.243,37.27209,0,0,0,100,0), -- 23:33:49
(@GUID,9,-1828.329,6454.762,27.57287,0,0,0,100,0), -- 23:33:55
(@GUID,10,-1847.793,6456.353,26.41575,0,0,0,100,0), -- 23:34:08
(@GUID,11,-1880.324,6458.532,28.61514,0,0,0,100,0), -- 23:34:17
(@GUID,12,-1888.081,6457.873,29.59407,0,0,0,100,0), -- 23:34:29
(@GUID,13,-1919.655,6459.986,28.07707,0,0,0,100,0), -- 23:34:36
(@GUID,14,-1945.343,6469.1,22.66152,0,0,0,100,0), -- 23:34:45
(@GUID,15,-1952.141,6471.51,22.01204,0,0,0,100,0), -- 23:34:58
(@GUID,16,-1968.71,6476.275,22.24739,0,0,0,100,0), -- 23:35:06
(@GUID,17,-2003.271,6473.622,21.54292,0,0,0,100,0), -- 23:35:14
(@GUID,18,-2010.868,6471.325,21.2761,0,0,0,100,0), -- 23:35:23
(@GUID,19,-2046.419,6450.189,23.66801,0,0,0,100,0), -- 23:35:31
(@GUID,20,-2061.182,6432.168,28.19959,0,0,0,100,0), -- 23:35:41
(@GUID,21,-2067.351,6422.73,29.15,0,0,0,100,0), -- 23:35:51
(@GUID,22,-2065.856,6425.313,28.68368,0,0,0,100,0), -- 23:35:59
(@GUID,23,-2050.113,6447.179,24.38938,0,0,0,100,0), -- 23:36:05
(@GUID,24,-2034.957,6458.48,21.88783,0,0,0,100,0), -- 23:36:14
(@GUID,25,-2030.312,6461.822,21.11793,0,0,0,100,0), -- 23:36:23
(@GUID,26,-2001.154,6474.045,21.7739,0,0,0,100,0), -- 23:36:32
(@GUID,27,-1989.639,6476.935,22.19421,0,0,0,100,0), -- 23:36:40
(@GUID,28,-1968.369,6476.048,22.20636,0,0,0,100,0), -- 23:36:49
(@GUID,29,-1923.969,6461.55,27.18353,0,0,0,100,0), -- 23:36:56
(@GUID,30,-1908.116,6458.206,29.54674,0,0,0,100,0), -- 23:37:10
(@GUID,31,-1886.354,6458.063,29.17184,0,0,0,100,0), -- 23:37:18
(@GUID,32,-1862.282,6457.62,26.82578,0,0,0,100,0); -- 23:37:25
-- 0x203AF4424011E78000004E00002633F0 .go -1834.752 6454.875 26.86079

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65648;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2126.693,6239.017,72.7256,0,0,0,100,0), -- 23:46:47
(@GUID,2,-2119.314,6213.649,81.36611,0,0,0,100,0), -- 23:46:59
(@GUID,3,-2107.719,6178.692,88.54082,0,0,0,100,0), -- 23:47:10
(@GUID,4,-2118.661,6212.45,81.80202,0,0,0,100,0), -- 23:47:26
(@GUID,5,-2125.859,6235.744,74.0819,0,0,0,100,0), -- 23:47:40
(@GUID,6,-2127.663,6264.234,65.04448,0,0,0,100,0), -- 23:47:51
(@GUID,7,-2152.114,6290.877,55.80878,0,0,0,100,0), -- 23:48:04
(@GUID,8,-2176.058,6308.648,49.91105,0,0,0,100,0), -- 23:48:19
(@GUID,9,-2202.254,6318.988,43.55692,0,0,0,100,0), -- 23:48:31
(@GUID,10,-2222.569,6328.265,38.86273,0,0,0,100,0), -- 23:48:42
(@GUID,11,-2252.233,6335.9,43.29943,0,0,0,100,0), -- 23:48:55
(@GUID,12,-2283.341,6341.71,39.21158,0,0,0,100,0), -- 23:49:07
(@GUID,13,-2311.41,6334.139,33.03185,0,0,0,100,0), -- 23:49:16
(@GUID,14,-2329.011,6325.256,29.58763,0,0,0,100,0), -- 23:49:29
(@GUID,15,-2316.089,6331.952,32.04526,0,0,0,100,0), -- 23:49:38
(@GUID,16,-2285.619,6341.726,38.52241,0,0,0,100,0), -- 23:49:44
(@GUID,17,-2266.126,6338.675,43.154,0,0,0,100,0), -- 23:49:57
(@GUID,18,-2234.443,6332.935,39.24818,0,0,0,100,0), -- 23:50:07
(@GUID,19,-2205.476,6320.33,42.37166,0,0,0,100,0), -- 23:50:18
(@GUID,20,-2184.05,6312.602,48.70446,0,0,0,100,0), -- 23:50:31
(@GUID,21,-2156.169,6294.522,54.56664,0,0,0,100,0), -- 23:50:42
(@GUID,22,-2128.61,6266.641,64.29518,0,0,0,100,0); -- 23:50:55
-- 0x203AF4424011E78000004E0000262662 .go -2126.693 6239.017 72.7256

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65649;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2585.925,6393.098,29.64841,0,0,0,100,0), -- 23:55:15
(@GUID,2,-2591.24,6407.891,27.55262,0,0,0,100,0), -- 23:55:26
(@GUID,3,-2599.723,6435.602,27.35635,0,0,0,100,0), -- 23:55:34
(@GUID,4,-2603.277,6466.338,22.72696,0,0,0,100,0), -- 23:55:45
(@GUID,5,-2604.06,6484.821,20.41327,0,0,0,100,0), -- 23:55:59
(@GUID,6,-2599.066,6516.159,17.68868,0,0,0,100,0), -- 23:56:08
(@GUID,7,-2589.615,6542.362,13.32788,0,0,0,100,0), -- 23:56:18
(@GUID,8,-2577.838,6559.287,11.21143,0,0,0,100,0), -- 23:56:29
(@GUID,9,-2558.885,6579.771,7.326009,0,0,0,100,0), -- 23:56:38
(@GUID,10,-2545.771,6602.757,2.534073,0,0,0,100,0), -- 23:56:50
(@GUID,11,-2539.133,6616.802,0.4829364,0,0,0,100,0), -- 23:56:59
(@GUID,12,-2536.86,6625.967,0.8791575,0,0,0,100,0), -- 23:57:05
(@GUID,13,-2515.356,6659.719,2.398494,0,0,0,100,0), -- 23:57:18
(@GUID,14,-2495.58,6667.909,4.119918,0,0,0,100,0), -- 23:57:27
(@GUID,15,-2486.859,6671.273,3.723157,0,0,0,100,0), -- 23:57:38
(@GUID,16,-2487.116,6671.07,3.631673,0,0,0,100,0), -- 23:57:52
(@GUID,17,-2501.805,6665.751,3.328776,0,0,0,100,0), -- 23:58:03
(@GUID,18,-2524.225,6652.958,1.235423,0,0,0,100,0), -- 23:58:14
(@GUID,19,-2538.057,6619.963,0.3882366,0,0,0,100,0), -- 23:58:24
(@GUID,20,-2543.838,6606.063,1.966996,0,0,0,100,0), -- 23:58:35
(@GUID,21,-2556.168,6583.419,6.166683,0,0,0,100,0), -- 23:58:42
(@GUID,22,-2574.833,6562.892,9.942083,0,0,0,100,0), -- 23:58:53
(@GUID,23,-2582.796,6551.989,12.25274,0,0,0,100,0), -- 23:59:03
(@GUID,24,-2596.887,6521.549,16.85234,0,0,0,100,0), -- 23:59:12
(@GUID,25,-2603.945,6496.051,19.94339,0,0,0,100,0), -- 23:59:23
(@GUID,26,-2603.87,6471.16,21.98938,0,0,0,100,0), -- 23:59:33
(@GUID,27,-2600.861,6440.42,26.66329,0,0,0,100,0), -- 23:59:42
(@GUID,28,-2594.183,6416.707,27.87725,0,0,0,100,0); -- 23:59:56
-- 0x203AF4424011E78000004E0000263789 .go -2585.925 6393.098 29.64841

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65652;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2138.354,8152.989,-17.22172,0,0,0,100,0), -- 00:10:50
(@GUID,2,-2139.332,8151.859,-17.38486,0,0,0,100,0), -- 00:10:59
(@GUID,3,-2144.721,8109.328,-14.87674,0,0,0,100,0), -- 00:11:08
(@GUID,4,-2149.386,8096.513,-13.81364,0,0,0,100,0), -- 00:11:18
(@GUID,5,-2169.473,8077.414,-16.66967,0,0,0,100,0), -- 00:11:25
(@GUID,6,-2179.198,8060.242,-18.91715,0,0,0,100,0), -- 00:11:35
(@GUID,7,-2180.498,8038.136,-17.21233,0,0,0,100,0), -- 00:11:44
(@GUID,8,-2177.994,8019.822,-14.56186,0,0,0,100,0), -- 00:11:53
(@GUID,9,-2181.188,8009.348,-15.42714,0,0,0,100,0), -- 00:12:00
(@GUID,10,-2178.981,8014.441,-14.62748,0,0,0,100,0), -- 00:12:08
(@GUID,11,-2179.929,8031.977,-16.31877,0,0,0,100,0), -- 00:12:12
(@GUID,12,-2181.96,8054.216,-18.99487,0,0,0,100,0), -- 00:12:18
(@GUID,13,-2171.656,8075.128,-17.34079,0,0,0,100,0), -- 00:12:28
(@GUID,14,-2155.154,8087.903,-13.98548,0,0,0,100,0), -- 00:12:37
(@GUID,15,-2145.264,8108.008,-14.65509,0,0,0,100,0), -- 00:12:46
(@GUID,16,-2142.832,8124.181,-16.47704,0,0,0,100,0), -- 00:12:55
(@GUID,17,-2141.562,8131.214,-17.44239,0,0,0,100,0), -- 00:13:03
(@GUID,18,-2125.837,8168.122,-15.21656,0,0,0,100,0); -- 00:13:12
-- 0x203AF4424011E78000004E0000263FB8 .go -2138.354 8152.989 -17.22172

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65653;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2898.377,8307.381,-31.67321,0,0,0,100,0), -- 00:19:12
(@GUID,2,-2901.179,8298.313,-32.7457,0,0,0,100,0), -- 00:19:20
(@GUID,3,-2901.053,8299.016,-32.60822,0,0,0,100,0), -- 00:19:30
(@GUID,4,-2894.577,8317.129,-30.78543,0,0,0,100,0), -- 00:19:37
(@GUID,5,-2890.901,8325.871,-30.59866,0,0,0,100,0), -- 00:19:46
(@GUID,6,-2866.041,8345.82,-30.81076,0,0,0,100,0), -- 00:19:53
(@GUID,7,-2849.758,8361.666,-30.32227,0,0,0,100,0), -- 00:20:03
(@GUID,8,-2842.846,8374.494,-30.5211,0,0,0,100,0), -- 00:20:15
(@GUID,9,-2840.746,8432.953,-30.15903,0,0,0,100,0), -- 00:20:26
(@GUID,10,-2835.173,8446.146,-31.95422,0,0,0,100,0), -- 00:20:38
(@GUID,11,-2827.901,8457.858,-32.86356,0,0,0,100,0), -- 00:20:46
(@GUID,12,-2814.782,8480.281,-31.76475,0,0,0,100,0), -- 00:20:53
(@GUID,13,-2809.755,8494.485,-30.93392,0,0,0,100,0), -- 00:21:00
(@GUID,14,-2811.876,8487.129,-31.36007,0,0,0,100,0), -- 00:21:08
(@GUID,15,-2819.095,8470.451,-32.65718,0,0,0,100,0), -- 00:21:12
(@GUID,16,-2832.487,8451.91,-32.30348,0,0,0,100,0), -- 00:21:20
(@GUID,17,-2839.542,8435.974,-30.47555,0,0,0,100,0), -- 00:21:28
(@GUID,18,-2841.62,8424.307,-30.78892,0,0,0,100,0), -- 00:21:35
(@GUID,19,-2842.871,8401.959,-30.77183,0,0,0,100,0), -- 00:21:48
(@GUID,20,-2854.29,8353.625,-30.90292,0,0,0,100,0), -- 00:21:59
(@GUID,21,-2873.958,8342.044,-30.46323,0,0,0,100,0), -- 00:22:09
(@GUID,22,-2879.57,8339.491,-30.33056,0,0,0,100,0); -- 00:22:20
-- 0x203AF4424011E78000004E000025E6F5 .go -2898.377 8307.381 -31.67321

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65655;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2278.507,8658.529,-9.223353,0,0,0,100,0), -- 00:26:54
(@GUID,2,-2307.501,8652.371,-13.51316,0,0,0,100,0), -- 00:27:05
(@GUID,3,-2325.801,8642.944,-16.03048,0,0,0,100,0), -- 00:27:17
(@GUID,4,-2333.431,8628.619,-18.58308,0,0,0,100,0), -- 00:27:25
(@GUID,5,-2338.136,8604.41,-20.94481,0,0,0,100,0), -- 00:27:32
(@GUID,6,-2343.163,8571.582,-26.8824,0,0,0,100,0), -- 00:27:42
(@GUID,7,-2339.06,8599.572,-22.13805,0,0,0,100,0), -- 00:27:56
(@GUID,8,-2334.667,8625.227,-18.91174,0,0,0,100,0), -- 00:28:08
(@GUID,9,-2327.625,8641.408,-16.31199,0,0,0,100,0), -- 00:28:18
(@GUID,10,-2316.982,8648.273,-14.85222,0,0,0,100,0), -- 00:28:25
(@GUID,11,-2285.132,8657.02,-10.23796,0,0,0,100,0), -- 00:28:32
(@GUID,12,-2258.549,8661.555,-7.56432,0,0,0,100,0), -- 00:28:45
(@GUID,13,-2255.743,8662.08,-7.521385,0,0,0,100,0), -- 00:28:55
(@GUID,14,-2227.405,8674.256,-6.104901,0,0,0,100,0), -- 00:29:03
(@GUID,15,-2215.896,8682.293,-3.399796,0,0,0,100,0), -- 00:29:09
(@GUID,16,-2221.09,8678.688,-4.301564,0,0,0,100,0), -- 00:29:16
(@GUID,17,-2235.881,8668.545,-7.750009,0,0,0,100,0), -- 00:29:22
(@GUID,18,-2238.266,8666.847,-7.867585,0,0,0,100,0); -- 00:29:28
-- 0x203AF4424011E78000004E000025E43C .go -2278.507 8658.529 -9.223353

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65656;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1956.735,8074.969,-15.64434,0,0,0,100,0), -- 00:33:55
(@GUID,2,-1955.278,8079.891,-14.87942,0,0,0,100,0), -- 00:34:01
(@GUID,3,-1944.631,8092.254,-14.65845,0,0,0,100,0), -- 00:34:08
(@GUID,4,-1944.923,8092.063,-14.84067,0,0,0,100,0), -- 00:34:14
(@GUID,5,-1944.926,8092.121,-14.69281,0,0,0,100,0), -- 00:34:17
(@GUID,6,-1957.625,8070.56,-15.94069,0,0,0,100,0), -- 00:34:23
(@GUID,7,-1963.358,8051.472,-17.6675,0,0,0,100,0), -- 00:34:29
(@GUID,8,-1975.043,8038.899,-17.10886,0,0,0,100,0), -- 00:34:37
(@GUID,9,-1994.447,8031.636,-14.62317,0,0,0,100,0), -- 00:34:44
(@GUID,10,-2021.598,8032.464,-13.52624,0,0,0,100,0), -- 00:34:53
(@GUID,11,-2000.459,8031.319,-14.53973,0,0,0,100,0), -- 00:35:04
(@GUID,12,-1981.429,8035.199,-15.77899,0,0,0,100,0), -- 00:35:13
(@GUID,13,-1967.366,8045.611,-18.14491,0,0,0,100,0), -- 00:35:21
(@GUID,14,-1959.855,8063.115,-16.9567,0,0,0,100,0); -- 00:35:28
-- 0x203AF4424011E78000004E0000262580 .go -1956.735 8074.969 -15.64434

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65659;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2070.067,7102.888,-2.052302,0,0,0,100,0), -- 00:41:16
(@GUID,2,-2087.792,7091.019,-2.84837,0,0,0,100,0), -- 00:41:28
(@GUID,3,-2094.955,7083.156,-7.530978,0,0,0,100,0), -- 00:41:33
(@GUID,4,-2119.192,7073.39,-5.840673,0,0,0,100,0), -- 00:41:39
(@GUID,5,-2144.562,7071.356,-10.23449,0,0,0,100,0), -- 00:41:50
(@GUID,6,-2166.686,7075.237,-10.12987,0,0,0,100,0), -- 00:42:03
(@GUID,7,-2212.567,7082.845,-12.61264,0,0,0,100,0), -- 00:42:14
(@GUID,8,-2244.822,7077.09,-16.42495,0,0,0,100,0), -- 00:42:28
(@GUID,9,-2255.132,7071.432,-18.17007,0,0,0,100,0), -- 00:42:41
(@GUID,10,-2300.193,7055.505,-14.9094,0,0,0,100,0), -- 00:42:53
(@GUID,11,-2283.766,7058.581,-18.95871,0,0,0,100,0), -- 00:43:07
(@GUID,12,-2251.402,7073.429,-17.71605,0,0,0,100,0), -- 00:43:19
(@GUID,13,-2218.918,7081.915,-12.42291,0,0,0,100,0), -- 00:43:31
(@GUID,14,-2200.548,7081.673,-10.34254,0,0,0,100,0), -- 00:43:44
(@GUID,15,-2180.577,7079.616,-10.4028,0,0,0,100,0), -- 00:43:57
(@GUID,16,-2126.396,7072.2,-6.481983,0,0,0,100,0), -- 00:44:08
(@GUID,17,-2100.881,7079.062,-7.246603,0,0,0,100,0), -- 00:44:22
(@GUID,18,-2089.061,7089.905,-3.560722,0,0,0,100,0), -- 00:44:33
(@GUID,19,-2086.757,7091.884,-2.422595,0,0,0,100,0), -- 00:44:39
(@GUID,20,-2055.03,7111.666,-1.71111,0,0,0,100,0), -- 00:44:44
(@GUID,21,-2037.368,7115.566,2.335891,0,0,0,100,0), -- 00:44:56
(@GUID,22,-2051.541,7113.85,-0.620634,0,0,0,100,0); -- 00:45:04
-- 0x203AF4424011E78000004E000026020F .go -2070.067 7102.888 -2.052302

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65660;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1942.642,6849.093,-72.92125,0,0,0,100,0), -- 00:49:28
(@GUID,2,-1933.504,6826.45,-75.26394,0,0,0,100,0), -- 00:49:36
(@GUID,3,-1931.819,6822.075,-75.37437,0,0,0,100,0), -- 00:49:46
(@GUID,4,-1922.75,6785.666,-72.95307,0,0,0,100,0), -- 00:49:53
(@GUID,5,-1907.188,6766.765,-69.14503,0,0,0,100,0), -- 00:50:03
(@GUID,6,-1890.347,6751.697,-66.49285,0,0,0,100,0), -- 00:50:13
(@GUID,7,-1871.31,6729.206,-64.48141,0,0,0,100,0), -- 00:50:22
(@GUID,8,-1858.029,6707.824,-59.51189,0,0,0,100,0), -- 00:50:32
(@GUID,9,-1844.132,6694.053,-50.41512,0,0,0,100,0), -- 00:50:43
(@GUID,10,-1825.864,6681.325,-39.15125,0,0,0,100,0), -- 00:50:52
(@GUID,11,-1802.378,6664.6,-27.10991,0,0,0,100,0), -- 00:51:02
(@GUID,12,-1823.088,6679.301,-37.80519,0,0,0,100,0), -- 00:51:16
(@GUID,13,-1842.906,6693.241,-49.26271,0,0,0,100,0), -- 00:51:27
(@GUID,14,-1854.614,6704.058,-57.28621,0,0,0,100,0), -- 00:51:38
(@GUID,15,-1869.586,6726.67,-63.91664,0,0,0,100,0), -- 00:51:46
(@GUID,16,-1887.332,6748.798,-66.11209,0,0,0,100,0), -- 00:51:57
(@GUID,17,-1901.292,6760.844,-67.79343,0,0,0,100,0), -- 00:52:07
(@GUID,18,-1919.02,6779.318,-71.78227,0,0,0,100,0), -- 00:52:15
(@GUID,19,-1928.488,6799.359,-74.2896,0,0,0,100,0), -- 00:52:25
(@GUID,20,-1930.746,6810.968,-75.21525,0,0,0,100,0), -- 00:52:35
(@GUID,21,-1938.882,6844.152,-72.96707,0,0,0,100,0), -- 00:52:43
(@GUID,22,-1953.403,6859.177,-76.03436,0,0,0,100,0), -- 00:52:53
(@GUID,23,-1967.78,6869.684,-82.02167,0,0,0,100,0), -- 00:53:02
(@GUID,24,-1975.93,6889.724,-84.45914,0,0,0,100,0), -- 00:53:09
(@GUID,25,-1978.575,6914.104,-85.60001,0,0,0,100,0), -- 00:53:20
(@GUID,26,-1977.248,6935.521,-86.65601,0,0,0,100,0), -- 00:53:30
(@GUID,27,-1970.151,6971.417,-88.13138,0,0,0,100,0), -- 00:53:43
(@GUID,28,-1959.888,7003.455,-87.7128,0,0,0,100,0), -- 00:53:56
(@GUID,29,-1955.091,7021.313,-89.54883,0,0,0,100,0), -- 00:54:06
(@GUID,30,-1940.513,7054.224,-91.4761,0,0,0,100,0), -- 00:54:17
(@GUID,31,-1946.831,7043.527,-90.23984,0,0,0,100,0), -- 00:54:28
(@GUID,32,-1956.34,7016.11,-88.76565,0,0,0,100,0), -- 00:54:36
(@GUID,33,-1957.891,7009.697,-88.14755,0,0,0,100,0), -- 00:54:46
(@GUID,34,-1973.311,6960.887,-87.6763,0,0,0,100,0), -- 00:54:57
(@GUID,35,-1978.631,6921.268,-85.86533,0,0,0,100,0), -- 00:55:10
(@GUID,36,-1978.749,6910.597,-85.46688,0,0,0,100,0), -- 00:55:24
(@GUID,37,-1970.894,6874.887,-83.08214,0,0,0,100,0), -- 00:55:32
(@GUID,38,-1955.024,6860.422,-76.7248,0,0,0,100,0); -- 00:55:43
-- 0x203AF4424011E78000004E0000262DC6 .go -1942.642 6849.093 -72.92125

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65661;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1404.178,6581.783,36.97878,0,0,0,100,0), -- 01:01:21
(@GUID,2,-1415.946,6566.268,35.83021,0,0,0,100,0), -- 01:01:31
(@GUID,3,-1423.194,6556.933,35.62516,0,0,0,100,0), -- 01:01:43
(@GUID,4,-1423.181,6556.937,35.4207,0,0,0,100,0), -- 01:01:59
(@GUID,5,-1410.495,6573.779,36.27173,0,0,0,100,0), -- 01:02:13
(@GUID,6,-1392.716,6597.332,39.51819,0,0,0,100,0), -- 01:02:25
(@GUID,7,-1382.821,6615.047,42.09058,0,0,0,100,0), -- 01:02:35
(@GUID,8,-1371.363,6644.054,41.38248,0,0,0,100,0), -- 01:02:48
(@GUID,9,-1364.489,6663.1,40.78107,0,0,0,100,0), -- 01:02:57
(@GUID,10,-1339.37,6703.84,37.98162,0,0,0,100,0), -- 01:03:10
(@GUID,11,-1331.182,6715.096,35.57928,0,0,0,100,0), -- 01:03:22
(@GUID,12,-1306.141,6756.783,37.17308,0,0,0,100,0), -- 01:03:34
(@GUID,13,-1295.701,6784.692,36.64917,0,0,0,100,0), -- 01:03:51
(@GUID,14,-1286.531,6811.418,33.71194,0,0,0,100,0), -- 01:04:01
(@GUID,15,-1273.094,6848.473,34.57795,0,0,0,100,0), -- 01:04:13
(@GUID,16,-1271.917,6851.317,35.00767,0,0,0,100,0), -- 01:04:27
(@GUID,17,-1249.046,6889.787,32.25288,0,0,0,100,0), -- 01:04:40
(@GUID,18,-1257.136,6881.966,34.24331,0,0,0,100,0), -- 01:04:49
(@GUID,19,-1267.958,6860.314,35.18145,0,0,0,100,0), -- 01:04:55
(@GUID,20,-1278.259,6833.243,34.0903,0,0,0,100,0), -- 01:05:07
(@GUID,21,-1293.722,6791.219,36.07722,0,0,0,100,0), -- 01:05:21
(@GUID,22,-1300.381,6767.007,37.85215,0,0,0,100,0), -- 01:05:34
(@GUID,23,-1320.033,6731.62,35.67615,0,0,0,100,0), -- 01:05:43
(@GUID,24,-1336.799,6706.999,36.94962,0,0,0,100,0), -- 01:05:59
(@GUID,25,-1349.703,6691.412,41.4528,0,0,0,100,0), -- 01:06:11
(@GUID,26,-1358.422,6679.415,41.01048,0,0,0,100,0), -- 01:06:23
(@GUID,27,-1372.139,6640.42,41.84719,0,0,0,100,0), -- 01:06:37
(@GUID,28,-1389.265,6602.389,40.14487,0,0,0,100,0); -- 01:06:47
-- 0x203AF4424011E78000004E0000264865 .go -1404.178 6581.783 36.97878

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65663;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1485.416,7013.551,4.497173,0,0,0,100,0), -- 01:14:49
(@GUID,2,-1547.538,6991.499,3.110646,0,0,0,100,0), -- 01:15:06
(@GUID,3,-1573.989,6989.81,-1.990254,0,0,0,100,0), -- 01:15:17
(@GUID,4,-1604.381,6998.437,-0.6853603,0,0,0,100,0), -- 01:15:29
(@GUID,5,-1621.859,7011.414,1.00204,0,0,0,100,0), -- 01:15:43
(@GUID,6,-1647.53,7051.292,2.072027,0,0,0,100,0), -- 01:15:56
(@GUID,7,-1658.393,7069.521,5.831712,0,0,0,100,0), -- 01:16:09
(@GUID,8,-1676.531,7092.237,2.141031,0,0,0,100,0), -- 01:16:20
(@GUID,9,-1696.452,7110.438,3.136701,0,0,0,100,0), -- 01:16:33
(@GUID,10,-1700.553,7113.766,3.052119,0,0,0,100,0), -- 01:16:41
(@GUID,11,-1700.468,7113.456,2.990931,0,0,0,100,0), -- 01:16:48
(@GUID,12,-1689.626,7104.907,2.57127,0,0,0,100,0), -- 01:16:52
(@GUID,13,-1665.031,7079.08,5.263766,0,0,0,100,0), -- 01:17:01
(@GUID,14,-1650.376,7056.501,3.40823,0,0,0,100,0), -- 01:17:14
(@GUID,15,-1636.578,7026.346,1.583237,0,0,0,100,0), -- 01:17:24
(@GUID,16,-1614.363,7004.372,0.3699367,0,0,0,100,0), -- 01:17:38
(@GUID,17,-1581.035,6989.616,-2.253792,0,0,0,100,0), -- 01:17:52
(@GUID,18,-1551.522,6990.933,2.083474,0,0,0,100,0), -- 01:18:04
(@GUID,19,-1530.861,6995.087,4.737087,0,0,0,100,0), -- 01:18:17
(@GUID,20,-1504.083,7005.023,4.345994,0,0,0,100,0), -- 01:18:28
(@GUID,21,-1469.36,7031.599,8.589698,0,0,0,100,0), -- 01:18:44
(@GUID,22,-1459.101,7052.883,10.67044,0,0,0,100,0), -- 01:18:55
(@GUID,23,-1467.617,7033.951,9.086441,0,0,0,100,0), -- 01:19:06
(@GUID,24,-1481.243,7018.265,5.024168,0,0,0,100,0); -- 01:19:16
-- 0x203AF4424011E78000004E0000263785 .go -1485.416 7013.551 4.497173

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65665;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-726.1278,8258.896,46.79619,0,0,0,100,0), -- 01:24:39
(@GUID,2,-715.5438,8258.383,50.6083,0,0,0,100,0), -- 01:24:44
(@GUID,3,-695.5436,8269.021,50.67116,0,0,0,100,0), -- 01:24:50
(@GUID,4,-677.5765,8283.788,51.27704,0,0,0,100,0), -- 01:25:00
(@GUID,5,-684.4351,8277.872,50.36641,0,0,0,100,0), -- 01:25:09
(@GUID,6,-700.7598,8265.637,51.45205,0,0,0,100,0), -- 01:25:15
(@GUID,7,-722.9138,8258.746,47.99392,0,0,0,100,0), -- 01:25:26
(@GUID,8,-735.8064,8260.676,43.94917,0,0,0,100,0), -- 01:25:31
(@GUID,9,-745.5906,8261.691,42.20914,0,0,0,100,0), -- 01:25:37
(@GUID,10,-777.6868,8258.197,39.82001,0,0,0,100,0), -- 01:25:44
(@GUID,11,-794.8225,8248.406,37.03281,0,0,0,100,0), -- 01:25:53
(@GUID,12,-805.4694,8241.086,36.02858,0,0,0,100,0), -- 01:26:03
(@GUID,13,-827.6669,8229.941,33.95469,0,0,0,100,0), -- 01:26:11
(@GUID,14,-839.8032,8213.736,32.44018,0,0,0,100,0), -- 01:26:17
(@GUID,15,-853.3129,8196.732,30.00434,0,0,0,100,0), -- 01:26:25
(@GUID,16,-857.1725,8186.443,29.1683,0,0,0,100,0), -- 01:26:36
(@GUID,17,-861.9432,8163.325,27.36681,0,0,0,100,0), -- 01:26:39
(@GUID,18,-858.407,8125.881,30.55249,0,0,0,100,0), -- 01:26:49
(@GUID,19,-860.8428,8149.51,27.18979,0,0,0,100,0), -- 01:27:05
(@GUID,20,-860.2225,8172.098,28.26516,0,0,0,100,0), -- 01:27:19
(@GUID,21,-856.0573,8192.379,29.52557,0,0,0,100,0), -- 01:27:28
(@GUID,22,-842.6394,8210.267,31.7333,0,0,0,100,0), -- 01:27:33
(@GUID,23,-835.7462,8219.619,33.2645,0,0,0,100,0), -- 01:27:42
(@GUID,24,-816.0286,8234.012,35.40913,0,0,0,100,0), -- 01:27:51
(@GUID,25,-801.8287,8243.748,36.18961,0,0,0,100,0), -- 01:27:57
(@GUID,26,-781.1525,8256.221,38.92212,0,0,0,100,0), -- 01:28:04
(@GUID,27,-761.9681,8261.029,41.3192,0,0,0,100,0), -- 01:28:14
(@GUID,28,-740.3534,8261.42,42.87246,0,0,0,100,0), -- 01:28:24
(@GUID,29,-726.1328,8258.857,46.62317,0,0,0,100,0); -- 01:28:31
-- 0x203AF4424011E78000004E00002643B8 .go -726.1278 8258.896 46.79619

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65666;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-944.314,7694.686,38.25343,0,0,0,100,0), -- 01:32:10
(@GUID,2,-960.3644,7712.979,30.39906,0,0,0,100,0), -- 01:32:23
(@GUID,3,-959.1507,7729.939,31.55951,0,0,0,100,0), -- 01:32:34
(@GUID,4,-949.505,7746.969,31.55574,0,0,0,100,0), -- 01:32:43
(@GUID,5,-935.2028,7765.514,35.1063,0,0,0,100,0), -- 01:32:51
(@GUID,6,-933.859,7785.102,37.44837,0,0,0,100,0), -- 01:33:00
(@GUID,7,-935.9513,7800,37.23156,0,0,0,100,0), -- 01:33:10
(@GUID,8,-929.7489,7828.585,38.2348,0,0,0,100,0), -- 01:33:16
(@GUID,9,-927.9563,7837.804,39.16978,0,0,0,100,0), -- 01:33:27
(@GUID,10,-934.1493,7865.022,38.13041,0,0,0,100,0), -- 01:33:35
(@GUID,11,-963.676,7890.41,38.05733,0,0,0,100,0), -- 01:33:42
(@GUID,12,-972.8056,7901.368,33.94324,0,0,0,100,0), -- 01:33:56
(@GUID,13,-973.3759,7908.995,30.522,0,0,0,100,0), -- 01:34:02
(@GUID,14,-967.3795,7932.751,29.69618,0,0,0,100,0), -- 01:34:09
(@GUID,15,-971.6959,7922.502,30.16867,0,0,0,100,0), -- 01:34:16
(@GUID,16,-973.6913,7905.07,32.06013,0,0,0,100,0), -- 01:34:20
(@GUID,17,-964.774,7891.498,37.93332,0,0,0,100,0), -- 01:34:27
(@GUID,18,-960.0255,7887.42,37.6365,0,0,0,100,0), -- 01:34:35
(@GUID,19,-929.3149,7856.846,39.10969,0,0,0,100,0), -- 01:34:48
(@GUID,20,-928.082,7854.673,39.14806,0,0,0,100,0), -- 01:34:55
(@GUID,21,-932.9129,7820.926,37.70737,0,0,0,100,0), -- 01:35:04
(@GUID,22,-935.6017,7798.7,37.56623,0,0,0,100,0), -- 01:35:15
(@GUID,23,-933.3494,7773.51,36.45978,0,0,0,100,0), -- 01:35:21
(@GUID,24,-942.5555,7755.716,32.19045,0,0,0,100,0), -- 01:35:31
(@GUID,25,-944.2391,7753.512,31.65475,0,0,0,100,0), -- 01:35:39
(@GUID,26,-959.8394,7723.305,30.76319,0,0,0,100,0); -- 01:35:48
-- 0x203AF4424011E78000004E0000260FB8 .go -944.314 7694.686 38.25343

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65667;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1128.908,8477.045,30.33621,0,0,0,100,0), -- 01:41:12
(@GUID,2,-1119.157,8462.143,29.5297,0,0,0,100,0), -- 01:41:22
(@GUID,3,-1101.587,8460.635,27.21489,0,0,0,100,0), -- 01:41:29
(@GUID,4,-1075.335,8463.006,30.54274,0,0,0,100,0), -- 01:41:40
(@GUID,5,-1053.572,8463.48,34.12425,0,0,0,100,0), -- 01:41:48
(@GUID,6,-1047.813,8463.867,34.53427,0,0,0,100,0), -- 01:41:58
(@GUID,7,-1033.322,8465.708,34.65159,0,0,0,100,0), -- 01:42:04
(@GUID,8,-1005.902,8453.615,38.15792,0,0,0,100,0), -- 01:42:09
(@GUID,9,-995.0693,8446.64,40.08287,0,0,0,100,0), -- 01:42:17
(@GUID,10,-966.594,8437.863,35.65092,0,0,0,100,0), -- 01:42:25
(@GUID,11,-943.9083,8431.957,37.16125,0,0,0,100,0), -- 01:42:35
(@GUID,12,-926.6941,8432.678,35.41687,0,0,0,100,0), -- 01:42:44
(@GUID,13,-914.7294,8432.65,33.39082,0,0,0,100,0), -- 01:42:51
(@GUID,14,-923.3787,8432.742,34.722,0,0,0,100,0), -- 01:43:01
(@GUID,15,-936.4376,8431.959,37.06477,0,0,0,100,0), -- 01:43:08
(@GUID,16,-961.6565,8436.555,35.80644,0,0,0,100,0), -- 01:43:16
(@GUID,17,-986.3014,8441.924,39.47265,0,0,0,100,0), -- 01:43:24
(@GUID,18,-1002.232,8450.996,38.95334,0,0,0,100,0), -- 01:43:35
(@GUID,19,-1015.515,8460.523,35.36264,0,0,0,100,0), -- 01:43:42
(@GUID,20,-1030.17,8465.472,34.67385,0,0,0,100,0), -- 01:43:51
(@GUID,21,-1033.581,8465.709,34.56473,0,0,0,100,0), -- 01:43:56
(@GUID,22,-1071.846,8463.623,31.43729,0,0,0,100,0), -- 01:44:02
(@GUID,23,-1088.21,8460.65,28.10583,0,0,0,100,0), -- 01:44:11
(@GUID,24,-1111.78,8460.889,28.34188,0,0,0,100,0); -- 01:44:19
-- 0x203AF4424011E78000004E00002623F6 .go -1128.908 8477.045 30.33621

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65668;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1298.94,8737.665,33.7051,0,0,0,100,0), -- 01:48:20
(@GUID,2,-1324.44,8732.457,30.85565,0,0,0,100,0), -- 01:48:30
(@GUID,3,-1340.438,8734.076,29.74687,0,0,0,100,0), -- 01:48:40
(@GUID,4,-1364.445,8730.121,26.79006,0,0,0,100,0), -- 01:48:49
(@GUID,5,-1380.466,8724.014,24.07105,0,0,0,100,0), -- 01:48:56
(@GUID,6,-1412.805,8720.652,21.99923,0,0,0,100,0), -- 01:49:07
(@GUID,7,-1402.107,8720.162,22.95799,0,0,0,100,0), -- 01:49:18
(@GUID,8,-1370.667,8727.73,25.72835,0,0,0,100,0), -- 01:49:25
(@GUID,9,-1354.004,8734.844,28.96291,0,0,0,100,0), -- 01:49:36
(@GUID,10,-1341.958,8734.481,30.00632,0,0,0,100,0), -- 01:49:44
(@GUID,11,-1303.214,8735.422,32.89497,0,0,0,100,0), -- 01:49:52
(@GUID,12,-1285.108,8749.334,37.11982,0,0,0,100,0), -- 01:50:03
(@GUID,13,-1264.996,8765.237,38.6629,0,0,0,100,0), -- 01:50:13
(@GUID,14,-1250.768,8774.912,37.94144,0,0,0,100,0), -- 01:50:24
(@GUID,15,-1232.983,8794.147,38.70338,0,0,0,100,0), -- 01:50:33
(@GUID,16,-1225.867,8833.785,46.07362,0,0,0,100,0), -- 01:50:42
(@GUID,17,-1229.429,8801.566,39.74549,0,0,0,100,0), -- 01:50:58
(@GUID,18,-1242.266,8781.217,37.74895,0,0,0,100,0), -- 01:51:12
(@GUID,19,-1262.608,8767,38.69908,0,0,0,100,0), -- 01:51:21
(@GUID,20,-1279.417,8753.924,37.96495,0,0,0,100,0); -- 01:51:30
-- 0x203AF4424011E78000004E000025EAB4 .go -1298.94 8737.665 33.7051

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65669;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1905.752,8849.963,31.1883,0,0,0,100,0), -- 01:56:12
(@GUID,2,-1935.98,8876.736,35.7215,0,0,0,100,0), -- 01:56:20
(@GUID,3,-1946.287,8883.662,36.65396,0,0,0,100,0), -- 01:56:34
(@GUID,4,-1970.356,8900.385,38.18405,0,0,0,100,0), -- 01:56:42
(@GUID,5,-1981.821,8911.693,39.54768,0,0,0,100,0), -- 01:56:52
(@GUID,6,-1979.206,8908.531,38.84719,0,0,0,100,0), -- 01:57:00
(@GUID,7,-1962.636,8894.715,37.43145,0,0,0,100,0), -- 01:57:05
(@GUID,8,-1941.701,8881.033,36.4118,0,0,0,100,0), -- 01:57:15
(@GUID,9,-1918.998,8860.391,31.82777,0,0,0,100,0), -- 01:57:23
(@GUID,10,-1896.513,8843.802,30.8529,0,0,0,100,0), -- 01:57:37
(@GUID,11,-1871.678,8838.736,29.45558,0,0,0,100,0), -- 01:57:47
(@GUID,12,-1870.336,8838.371,29.11763,0,0,0,100,0), -- 01:57:56
(@GUID,13,-1834.845,8838.773,28.20097,0,0,0,100,0), -- 01:58:05
(@GUID,14,-1828.867,8836.951,27.58482,0,0,0,100,0), -- 01:58:13
(@GUID,15,-1829.162,8836.926,27.28334,0,0,0,100,0), -- 01:58:19
(@GUID,16,-1843.316,8840.856,28.78101,0,0,0,100,0), -- 01:58:23
(@GUID,17,-1847.484,8841.689,29.32478,0,0,0,100,0), -- 01:58:30
(@GUID,18,-1894.005,8842.438,30.46817,0,0,0,100,0); -- 01:58:40
-- 0x203AF4424011E78000004E0000263D08 .go -1905.752 8849.963 31.1883

-- Pathing for  Entry: 18334 'TDB FORMAT' 
SET @GUID := 65646;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1612.406,6570.503,6.982493,0,0,0,100,0), -- 02:08:05
(@GUID,2,-1614.595,6565.356,7.208048,0,0,0,100,0), -- 02:08:13
(@GUID,3,-1638.007,6571.519,6.701593,0,0,0,100,0), -- 02:08:20
(@GUID,4,-1654.055,6609.707,0.1810076,0,0,0,100,0), -- 02:08:30
(@GUID,5,-1649.122,6637.95,-8.652092,0,0,0,100,0), -- 02:08:43
(@GUID,6,-1649.657,6652.884,-9.074863,0,0,0,100,0), -- 02:08:55
(@GUID,7,-1666.357,6710.94,-2.727369,0,0,0,100,0), -- 02:09:07
(@GUID,8,-1676.008,6737.302,-5.586429,0,0,0,100,0), -- 02:09:26
(@GUID,9,-1681.334,6756.157,-9.995689,0,0,0,100,0), -- 02:09:36
(@GUID,10,-1669.921,6808.041,-11.01227,0,0,0,100,0), -- 02:09:50
(@GUID,11,-1649.946,6842.342,-11.98508,0,0,0,100,0), -- 02:10:08
(@GUID,12,-1645.45,6849.631,-12.52353,0,0,0,100,0), -- 02:10:26
(@GUID,13,-1631.198,6865.211,-11.80149,0,0,0,100,0), -- 02:10:40
(@GUID,14,-1662.066,6822.472,-12.15099,0,0,0,100,0), -- 02:10:52
(@GUID,15,-1682.708,6775.835,-9.737608,0,0,0,100,0), -- 02:11:10
(@GUID,16,-1676.805,6739.438,-6.040812,0,0,0,100,0), -- 02:11:27
(@GUID,17,-1670.686,6721.969,-3.275235,0,0,0,100,0), -- 02:11:42
(@GUID,18,-1653.276,6676.503,-8.282584,0,0,0,100,0), -- 02:11:52
(@GUID,19,-1649.429,6649.203,-9.570678,0,0,0,100,0), -- 02:12:11
(@GUID,20,-1653.794,6611.523,-0.473855,0,0,0,100,0), -- 02:12:23
(@GUID,21,-1652.239,6581.729,6.184913,0,0,0,100,0), -- 02:12:35
(@GUID,22,-1636.589,6570.722,7.107543,0,0,0,100,0), -- 02:12:48
(@GUID,23,-1632.383,6568.686,7.45083,0,0,0,100,0), -- 02:12:57
(@GUID,24,-1607.946,6582.783,7.268674,0,0,0,100,0), -- 02:13:04
(@GUID,25,-1611.074,6612.02,19.03936,0,0,0,100,0), -- 02:13:13
(@GUID,26,-1607.55,6586.147,8.281254,0,0,0,100,0); -- 02:13:27
-- 0x203AF4424011E78000004E0000264702 .go -1612.406 6570.503 6.982493

-- ----------------------------------------------------------
-- Storm Ragers
-- ----------------------------------------------------------

UPDATE `creature` SET `spawndist`=10,`MovementType`=1,`position_x`=-1558.220337,`position_y`=7661.585938,`position_z`=-9.573906 WHERE `guid`=60633;
UPDATE `creature` SET `spawndist`=10,`MovementType`=1 WHERE `guid`=60640;
-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60626;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2284.43,`position_y`=7761.18,`position_z`=-25.4335 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2280.718,7763.378,-25.66972,0,0,0,100,0), -- 18:09:47
(@GUID,@POINT := @POINT + '1',-2294.724,7756.154,-24.49666,0,0,0,100,0), -- 18:10:07
(@GUID,@POINT := @POINT + '1',-2332.205,7745.393,-24.86271,0,0,0,100,0), -- 18:10:19
(@GUID,@POINT := @POINT + '1',-2379.229,7740.997,-25.19179,0,0,0,100,0), -- 18:10:28
(@GUID,@POINT := @POINT + '1',-2406.142,7728.465,-20.35161,0,0,0,100,0), -- 18:10:47
(@GUID,@POINT := @POINT + '1',-2441.561,7728.537,-20.26049,0,0,0,100,0), -- 18:10:58
(@GUID,@POINT := @POINT + '1',-2484.312,7739.452,-28.86633,0,0,0,100,0), -- 18:11:15
(@GUID,@POINT := @POINT + '1',-2524.406,7733.471,-28.92428,0,0,0,100,0), -- 18:11:31
(@GUID,@POINT := @POINT + '1',-2546.264,7725.069,-29.32391,0,0,0,100,0), -- 18:11:48
(@GUID,@POINT := @POINT + '1',-2602.393,7710.53,-26.82005,0,0,0,100,0), -- 18:12:08
(@GUID,@POINT := @POINT + '1',-2638.841,7713.832,-29.14826,0,0,0,100,0), -- 18:12:23
(@GUID,@POINT := @POINT + '1',-2677.241,7732.904,-28.20031,0,0,0,100,0), -- 18:12:39
(@GUID,@POINT := @POINT + '1',-2679.577,7734.628,-28.26339,0,0,0,100,0), -- 18:12:53
(@GUID,@POINT := @POINT + '1',-2735.678,7768.694,-28.92821,0,0,0,100,0), -- 18:13:05
(@GUID,@POINT := @POINT + '1',-2772.903,7788.438,-24.88911,0,0,0,100,0), -- 18:13:22
(@GUID,@POINT := @POINT + '1',-2806.41,7824.431,-21.44869,0,0,0,100,0), -- 18:13:36
(@GUID,@POINT := @POINT + '1',-2774.595,7789.528,-24.36315,0,0,0,100,0), -- 18:13:58
(@GUID,@POINT := @POINT + '1',-2745.761,7774.81,-27.84523,0,0,0,100,0), -- 18:03:52
(@GUID,@POINT := @POINT + '1',-2708.076,7749.796,-28.58076,0,0,0,100,0), -- 18:04:08
(@GUID,@POINT := @POINT + '1',-2693.038,7741.721,-27.83322,0,0,0,100,0), -- 18:04:25
(@GUID,@POINT := @POINT + '1',-2662.971,7723.492,-28.93122,0,0,0,100,0), -- 18:04:37
(@GUID,@POINT := @POINT + '1',-2614.3,7709.555,-26.32296,0,0,0,100,0), -- 18:04:49
(@GUID,@POINT := @POINT + '1',-2585.726,7712.583,-28.59635,0,0,0,100,0), -- 18:05:06
(@GUID,@POINT := @POINT + '1',-2544.18,7725.927,-29.33258,0,0,0,100,0), -- 18:05:22
(@GUID,@POINT := @POINT + '1',-2487.354,7739.927,-29.48177,0,0,0,100,0), -- 18:05:41
(@GUID,@POINT := @POINT + '1',-2452.095,7729.264,-20.80545,0,0,0,100,0), -- 18:05:58
(@GUID,@POINT := @POINT + '1',-2411.31,7727.674,-20.19808,0,0,0,100,0), -- 18:06:14
(@GUID,@POINT := @POINT + '1',-2386.72,7738.647,-24.88115,0,0,0,100,0), -- 18:06:31
(@GUID,@POINT := @POINT + '1',-2373.201,7741.64,-24.543,0,0,0,100,0), -- 18:06:42
(@GUID,@POINT := @POINT + '1',-2328.39,7745.795,-24.88101,0,0,0,100,0), -- 18:07:01
(@GUID,@POINT := @POINT + '1',-2313.255,7747.291,-24.6969,0,0,0,100,0), -- 18:07:10
(@GUID,@POINT := @POINT + '1',-2253.858,7779.068,-25.17061,0,0,0,100,0), -- 18:07:22
(@GUID,@POINT := @POINT + '1',-2241.003,7803.941,-24.35389,0,0,0,100,0), -- 18:07:42
(@GUID,@POINT := @POINT + '1',-2239.196,7855.418,-22.99221,0,0,0,100,0), -- 18:08:00
(@GUID,@POINT := @POINT + '1',-2218.54,7885.224,-21.95422,0,0,0,100,0), -- 18:08:14
(@GUID,@POINT := @POINT + '1',-2200.597,7920.25,-15.3881,0,0,0,100,0), -- 18:08:27
(@GUID,@POINT := @POINT + '1',-2215.623,7889.388,-21.10126,0,0,0,100,0), -- 18:08:46
(@GUID,@POINT := @POINT + '1',-2228.359,7876.08,-22.34141,0,0,0,100,0), -- 18:09:03
(@GUID,@POINT := @POINT + '1',-2237.683,7837.097,-24.47541,0,0,0,100,0), -- 18:09:15
(@GUID,@POINT := @POINT + '1',-2241.276,7800.156,-24.74651,0,0,0,100,0); -- 18:09:30
-- 0x203AF4424010C1C000004E000023CF52 .go -2745.761 7774.81 -27.84523

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60625;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2784.52,`position_y`=7907.15,`position_z`=-34.792 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2787.35,7916.05,-33.41465,0,0,0,100,0), -- 18:26:35
(@GUID,@POINT := @POINT + '1',-2780.458,7894.974,-34.42623,0,0,0,100,0), -- 18:15:20
(@GUID,@POINT := @POINT + '1',-2748.483,7851.858,-34.20364,0,0,0,100,0), -- 18:15:34
(@GUID,@POINT := @POINT + '1',-2720.694,7820.764,-36.89186,0,0,0,100,0), -- 18:15:51
(@GUID,@POINT := @POINT + '1',-2690.303,7811.287,-38.55512,0,0,0,100,0), -- 18:16:08
(@GUID,@POINT := @POINT + '1',-2649.125,7807.872,-40.85405,0,0,0,100,0), -- 18:16:20
(@GUID,@POINT := @POINT + '1',-2623.065,7793.934,-40.33918,0,0,0,100,0), -- 18:16:40
(@GUID,@POINT := @POINT + '1',-2591.73,7809.872,-42.47198,0,0,0,100,0), -- 18:16:56
(@GUID,@POINT := @POINT + '1',-2566.32,7816.186,-44.34589,0,0,0,100,0), -- 18:17:10
(@GUID,@POINT := @POINT + '1',-2528.698,7814.801,-42.88158,0,0,0,100,0), -- 18:17:27
(@GUID,@POINT := @POINT + '1',-2487.967,7822.7,-42.99165,0,0,0,100,0), -- 18:17:37
(@GUID,@POINT := @POINT + '1',-2462.101,7847.087,-45.96609,0,0,0,100,0), -- 18:17:54
(@GUID,@POINT := @POINT + '1',-2449.392,7878.37,-48.32826,0,0,0,100,0), -- 18:18:06
(@GUID,@POINT := @POINT + '1',-2448.966,7879.2,-48.8006,0,0,0,100,0), -- 18:18:21
(@GUID,@POINT := @POINT + '1',-2431.337891,7891.773438,-43.449921,0,0,0,100,0), -- 18:18:44
(@GUID,@POINT := @POINT + '1',-2375.980469,7913.506348,-43.685230,0,0,0,100,0), -- 18:19:10
-- (@GUID,@POINT := @POINT + '1',-2354.732,7889.538,-40.72826,0,0,0,0,100,0), -- 18:19:35
(@GUID,@POINT := @POINT + '1',-2310.785,7887.123,-36.84087,0,0,0,100,0), -- 18:20:01
(@GUID,@POINT := @POINT + '1',-2283.047,7915.84,-29.75405,0,0,0,100,0), -- 18:20:02
(@GUID,@POINT := @POINT + '1',-2251.813,7938.25,-24.90488,0,0,0,100,0), -- 18:20:19
(@GUID,@POINT := @POINT + '1',-2222.403,7949.989,-19.76187,0,0,0,100,0), -- 18:20:36
(@GUID,@POINT := @POINT + '1',-2192.206,7979.006,-16.99471,0,0,0,100,0), -- 18:20:49
(@GUID,@POINT := @POINT + '1',-2211.387,7955.148,-19.15054,0,0,0,100,0), -- 18:21:05
(@GUID,@POINT := @POINT + '1',-2242.142,7944.202,-23.67212,0,0,0,100,0), -- 18:21:19
(@GUID,@POINT := @POINT + '1',-2277.086,7921.057,-28.86916,0,0,0,100,0), -- 18:21:31
(@GUID,@POINT := @POINT + '1',-2309.442,7888.423,-36.40188,0,0,0,100,0), -- 18:21:50
(@GUID,@POINT := @POINT + '1',-2309.576,7888.328,-36.62676,0,0,0,100,0), -- 18:22:08
(@GUID,@POINT := @POINT + '1',-2357.119629,7912.037598,-43.776260,0,0,0,100,0), -- 18:22:31
(@GUID,@POINT := @POINT + '1',-2429.624268,7905.913574,-46.044796,0,0,0,100,0), -- 18:22:57
-- (@GUID,@POINT := @POINT + '1',-2419.845,7885.883,-47.74906,0,0,0,0,100,0), -- 18:23:22
(@GUID,@POINT := @POINT + '1',-2447.688,7882.326,-49.331753,0,0,0,100,0), -- 18:23:48
(@GUID,@POINT := @POINT + '1',-2460.387,7849.981,-46.28027,0,0,0,100,0), -- 18:23:49
(@GUID,@POINT := @POINT + '1',-2480.561,7826.219,-42.97644,0,0,0,100,0), -- 18:24:03
(@GUID,@POINT := @POINT + '1',-2516.247,7814.837,-43.0522,0,0,0,100,0), -- 18:24:15
(@GUID,@POINT := @POINT + '1',-2543.083,7816.943,-44.33011,0,0,0,100,0), -- 18:24:31
(@GUID,@POINT := @POINT + '1',-2575.068,7815.85,-43.54463,0,0,0,100,0), -- 18:24:42
(@GUID,@POINT := @POINT + '1',-2609.462,7785.996,-40.75513,0,0,0,100,0), -- 18:24:59
(@GUID,@POINT := @POINT + '1',-2610.373,7785.427,-40.44117,0,0,0,100,0), -- 18:25:14
(@GUID,@POINT := @POINT + '1',-2686.484,7810.387,-39.64625,0,0,0,100,0), -- 18:25:30
(@GUID,@POINT := @POINT + '1',-2702.6,7814.202,-37.33952,0,0,0,100,0), -- 18:25:49
(@GUID,@POINT := @POINT + '1',-2744.664,7847.78,-34.84281,0,0,0,100,0), -- 18:26:01
(@GUID,@POINT := @POINT + '1',-2765.453,7870.131,-34.58795,0,0,0,100,0); -- 18:26:18
-- 0x203AF4424010C1C000004E000023C057 .go -2394.61 7884.241 -43.88793

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60624;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2818.25,`position_y`=7048.97,`position_z`=-11.0032 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-2849.774,7110.413,-6.046308,0,0,0,100,0), -- 20:04:28
(@GUID,2,-2853.396,7115.6,-4.74917,0,0,0,100,0), -- 20:04:45
(@GUID,3,-2867.926,7070.511,-16.48763,0,0,0,100,0), -- 20:04:48
(@GUID,4,-2868.111,7070.283,-16.5513,0,0,0,100,0), -- 20:08:07
(@GUID,5,-2869.967,7067.74,-17.7383,0,0,0,100,0); -- 20:08:14

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60623;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2697.92,`position_y`=7040.53,`position_z`=-6.81427 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2699.193,7046.151,-6.722614,0,0,0,100,0), -- 20:10:13
(@GUID,@POINT := @POINT + '1',-2652.557,7054.379,-4.143121,0,0,0,100,0), -- 20:10:25
(@GUID,@POINT := @POINT + '1',-2640.919,7051.006,-3.168398,0,0,0,100,0), -- 20:10:41
(@GUID,@POINT := @POINT + '1',-2597.716,7038.055,-3.39875,0,0,0,100,0), -- 20:10:52
(@GUID,@POINT := @POINT + '1',-2560.625,7034.698,-6.083586,0,0,0,100,0), -- 20:11:06
(@GUID,@POINT := @POINT + '1',-2582.919,7035.597,-4.166915,0,0,0,100,0), -- 20:11:24
(@GUID,@POINT := @POINT + '1',-2600.248,7038.574,-3.296067,0,0,0,100,0), -- 20:11:38
(@GUID,@POINT := @POINT + '1',-2644.608,7052.838,-3.563079,0,0,0,100,0), -- 20:11:54
(@GUID,@POINT := @POINT + '1',-2670.993,7052.688,-6.616284,0,0,0,100,0), -- 20:12:05
(@GUID,@POINT := @POINT + '1',-2686.378,7051.268,-7.214131,0,0,0,100,0), -- 20:12:20
(@GUID,@POINT := @POINT + '1',-2714.871,7039.572,-7.28418,0,0,0,100,0), -- 20:12:33
(@GUID,@POINT := @POINT + '1',-2774.948,7019.605,-9.209288,0,0,0,100,0), -- 20:12:47
(@GUID,@POINT := @POINT + '1',-2817.173,7048.181,-10.38402,0,0,0,100,0), -- 20:13:05
(@GUID,@POINT := @POINT + '1',-2841.282,7070.998,-11.82775,0,0,0,100,0), -- 20:13:21
(@GUID,@POINT := @POINT + '1',-2856.209,7106.354,-8.310734,0,0,0,100,0), -- 20:13:37
(@GUID,@POINT := @POINT + '1',-2856.883,7107.498,-8.307525,0,0,0,100,0), -- 20:13:50
(@GUID,@POINT := @POINT + '1',-2913.605,7150.265,-2.639728,0,0,0,100,0), -- 20:04:23
(@GUID,@POINT := @POINT + '1',-2912.953,7162.026,-2.035193,0,0,0,100,0), -- 20:04:41
(@GUID,@POINT := @POINT + '1',-2918.514,7209.465,0.6713169,0,0,0,100,0), -- 20:04:52
(@GUID,@POINT := @POINT + '1',-2939.673,7247,-0.2752615,0,0,0,100,0), -- 20:05:10
(@GUID,@POINT := @POINT + '1',-2918.253,7280.755,1.047163,0,0,0,100,0), -- 20:05:24
(@GUID,@POINT := @POINT + '1',-2923.069,7316.552,6.040999,0,0,0,100,0), -- 20:05:41
(@GUID,@POINT := @POINT + '1',-2928.339,7351.842,9.683969,0,0,0,100,0), -- 20:05:55
(@GUID,@POINT := @POINT + '1',-2940.79,7370.774,11.76672,0,0,0,100,0), -- 20:06:10
(@GUID,@POINT := @POINT + '1',-2969.653,7368.656,12.19211,0,0,0,100,0), -- 20:06:20
(@GUID,@POINT := @POINT + '1',-2958.457,7369.961,11.56003,0,0,0,100,0), -- 20:06:35
(@GUID,@POINT := @POINT + '1',-2929.731,7354.361,10.32422,0,0,0,100,0), -- 20:06:48
(@GUID,@POINT := @POINT + '1',-2926.876,7340.729,7.133774,0,0,0,100,0), -- 20:06:57
(@GUID,@POINT := @POINT + '1',-2916.912,7290.315,1.317884,0,0,0,100,0), -- 20:07:11
(@GUID,@POINT := @POINT + '1',-2940.726,7251.239,-0.2171192,0,0,0,100,0), -- 20:07:25
(@GUID,@POINT := @POINT + '1',-2924.564,7226.65,-0.3030074,0,0,0,100,0), -- 20:07:42
(@GUID,@POINT := @POINT + '1',-2913.515,7187.506,-1.554206,0,0,0,100,0), -- 20:07:56
(@GUID,@POINT := @POINT + '1',-2913.744,7153.698,-2.410354,0,0,0,100,0), -- 20:08:14
(@GUID,@POINT := @POINT + '1',-2887.063,7125.858,-7.045651,0,0,0,100,0), -- 20:08:25
(@GUID,@POINT := @POINT + '1',-2874.972,7117.333,-8.106588,0,0,0,100,0), -- 20:08:43
(@GUID,@POINT := @POINT + '1',-2847.941,7079.747,-11.89652,0,0,0,100,0), -- 20:08:54
(@GUID,@POINT := @POINT + '1',-2820.662,7051.48,-11.4577,0,0,0,100,0), -- 20:09:07
(@GUID,@POINT := @POINT + '1',-2794.932,7026.308,-9.488497,0,0,0,100,0), -- 20:09:23
(@GUID,@POINT := @POINT + '1',-2748.775,7016.777,-7.175637,0,0,0,100,0), -- 20:09:40
(@GUID,@POINT := @POINT + '1',-2745.176,7016.581,-6.9723,0,0,0,100,0); -- 20:09:57

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60629;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2180.41,`position_y`=7449.87,`position_z`=-34.7481 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2186.902,7459.907,-34.14049,0,0,0,100,0), -- 23:36:12
(@GUID,@POINT := @POINT + '1',-2192.761,7485.829,-30.82996,0,0,0,100,0), -- 23:36:28
(@GUID,@POINT := @POINT + '1',-2206.288,7509.409,-27.32218,0,0,0,100,0), -- 23:36:42
(@GUID,@POINT := @POINT + '1',-2214.38,7538.713,-23.72157,0,0,0,100,0), -- 23:36:55
(@GUID,@POINT := @POINT + '1',-2238.795,7576.903,-20.17494,0,0,0,100,0), -- 23:29:19
(@GUID,@POINT := @POINT + '1',-2220.221,7608.72,-17.5443,0,0,0,100,0), -- 23:29:36
(@GUID,@POINT := @POINT + '1',-2195.222,7631.705,-23.92457,0,0,0,100,0), -- 23:29:53
(@GUID,@POINT := @POINT + '1',-2160.094,7675.206,-29.28339,0,0,0,100,0), -- 23:30:09
(@GUID,@POINT := @POINT + '1',-2153.48,7697.494,-28.78719,0,0,0,100,0), -- 23:30:27
(@GUID,@POINT := @POINT + '1',-2128.125,7753.728,-26.48363,0,0,0,100,0), -- 23:30:44
(@GUID,@POINT := @POINT + '1',-2104.155,7774.553,-30.0355,0,0,0,100,0), -- 23:31:02
(@GUID,@POINT := @POINT + '1',-2091.938,7807.079,-25.00104,0,0,0,100,0), -- 23:31:14
(@GUID,@POINT := @POINT + '1',-2069.595,7844.852,-26.97473,0,0,0,100,0), -- 23:31:29
(@GUID,@POINT := @POINT + '1',-2045.771,7861.251,-33.67918,0,0,0,100,0), -- 23:31:46
(@GUID,@POINT := @POINT + '1',-2020.792,7880.968,-34.28879,0,0,0,100,0), -- 23:31:58
(@GUID,@POINT := @POINT + '1',-1980.796,7886.231,-30.36411,0,0,0,100,0), -- 23:32:13
(@GUID,@POINT := @POINT + '1',-2008.429,7884.817,-33.97379,0,0,0,100,0), -- 23:32:34
(@GUID,@POINT := @POINT + '1',-2039.762,7865.805,-33.84718,0,0,0,100,0), -- 23:32:52
(@GUID,@POINT := @POINT + '1',-2068.066,7846.31,-27.04763,0,0,0,100,0), -- 23:33:06
(@GUID,@POINT := @POINT + '1',-2075.205,7835.296,-24.54612,0,0,0,100,0), -- 23:33:18
(@GUID,@POINT := @POINT + '1',-2100.688,7780.701,-29.6921,0,0,0,100,0), -- 23:33:35
(@GUID,@POINT := @POINT + '1',-2121.731,7760.096,-26.24451,0,0,0,100,0), -- 23:33:50
(@GUID,@POINT := @POINT + '1',-2142.565,7726.572,-29.00374,0,0,0,100,0), -- 23:34:03
(@GUID,@POINT := @POINT + '1',-2155.626,7689.222,-29.43825,0,0,0,100,0), -- 23:34:21
(@GUID,@POINT := @POINT + '1',-2182.448,7644.232,-23.26413,0,0,0,100,0), -- 23:34:37
(@GUID,@POINT := @POINT + '1',-2213.639,7616.933,-18.4043,0,0,0,100,0), -- 23:34:55
(@GUID,@POINT := @POINT + '1',-2232.493,7591.379,-19.69997,0,0,0,100,0), -- 23:35:11
(@GUID,@POINT := @POINT + '1',-2220.854,7552.617,-22.8694,0,0,0,100,0), -- 23:35:30
(@GUID,@POINT := @POINT + '1',-2209.284,7516.458,-26.52888,0,0,0,100,0), -- 23:35:45
(@GUID,@POINT := @POINT + '1',-2194.163,7488.476,-30.08399,0,0,0,100,0); -- 23:36:00
-- 0x203AF4424010C1C000004E000024F46B .go -2238.795 7576.903 -20.17494

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60631;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-1590.26,`position_y`=7181.33,`position_z`=6.30724 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1577.794,7221.407,10.18464,0,0,0,100,0), -- 23:51:04
(@GUID,2,-1572.499,7211.928,11.50952,0,0,0,100,0), -- 23:51:16
(@GUID,3,-1561.525,7158.377,9.989041,0,0,0,100,0), -- 23:51:28
(@GUID,4,-1558.444,7119.097,10.59508,0,0,0,100,0), -- 23:51:43
(@GUID,5,-1541.908,7085.047,7.428963,0,0,0,100,0), -- 23:51:57
(@GUID,6,-1517.056,7067.572,9.120987,0,0,0,100,0), -- 23:52:14
(@GUID,7,-1509.929,7059.699,10.27606,0,0,0,100,0), -- 23:52:25
(@GUID,8,-1522.75,7020.788,8.506086,0,0,0,100,0), -- 23:52:36
(@GUID,9,-1544.635,6987.345,2.576344,0,0,0,100,0), -- 23:52:50
(@GUID,10,-1578.695,6978.203,-3.74432,0,0,0,100,0), -- 23:53:07
(@GUID,11,-1612.536,6984.831,0.6673695,0,0,0,100,0), -- 23:53:21
(@GUID,12,-1620.05,6987.154,1.161987,0,0,0,100,0), -- 23:53:37
(@GUID,13,-1650.734,7031.964,0.4385625,0,0,0,100,0), -- 23:53:50
(@GUID,14,-1670.47,7067.199,5.307508,0,0,0,100,0), -- 23:54:04
(@GUID,15,-1656.324,7109.069,3.373481,0,0,0,100,0), -- 23:54:18
(@GUID,16,-1639.419,7138.071,4.098329,0,0,0,100,0), -- 23:54:35
(@GUID,17,-1621.776,7173.719,3.085117,0,0,0,100,0), -- 23:54:50
(@GUID,18,-1639.039,7213.127,2.922881,0,0,0,100,0), -- 23:55:04
(@GUID,19,-1647.369,7220.92,2.543242,0,0,0,100,0), -- 23:55:23
(@GUID,20,-1698.519,7260.933,3.903978,0,0,0,100,0), -- 23:55:40
(@GUID,21,-1704.041,7286.869,2.561028,0,0,0,100,0), -- 23:55:54
(@GUID,22,-1688.93,7311.872,-0.723447,0,0,0,100,0), -- 23:56:05
(@GUID,23,-1657.768,7295.309,-1.352589,0,0,0,100,0), -- 23:56:17
(@GUID,24,-1628.133,7273.818,0.4630274,0,0,0,100,0), -- 23:56:34
(@GUID,25,-1612.2,7251.295,1.917702,0,0,0,100,0), -- 23:56:46
(@GUID,26,-1592.452,7242.728,5.403481,0,0,0,100,0); -- 23:56:57
-- 0x203AF4424010C1C000004E000024F18F .go -1577.794 7221.407 10.18464

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60628;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2014.98,`position_y`=7375.31,`position_z`=-33.0574 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2004.871,7373.875,-34.11275,0,0,0,100,0), -- 17:56:54 
(@GUID,@POINT := @POINT + '1',-1950.513,7356.812,-29.61288,0,0,0,100,0), -- 17:57:09
(@GUID,@POINT := @POINT + '1',-1915.491,7356.869,-20.41547,0,0,0,100,0), -- 17:52:47
(@GUID,@POINT := @POINT + '1',-1905.864,7366.096,-17.99051,0,0,0,100,0), -- 17:53:00
(@GUID,@POINT := @POINT + '1',-1888.388,7406.708,-16.59583,0,0,0,100,0), -- 17:53:13
(@GUID,@POINT := @POINT + '1',-1875.848,7451.949,-11.54931,0,0,0,100,0), -- 17:53:31
(@GUID,@POINT := @POINT + '1',-1881.042,7481.282,-7.584961,0,0,0,100,0), -- 17:53:44
(@GUID,@POINT := @POINT + '1',-1881.16,7502.434,-5.842937,0,0,0,100,0), -- 17:53:58
(@GUID,@POINT := @POINT + '1',-1877.221,7539.669,-6.546558,0,0,0,100,0), -- 17:54:13
(@GUID,@POINT := @POINT + '1',-1875.305,7547.384,-6.693436,0,0,0,100,0), -- 17:54:22
(@GUID,@POINT := @POINT + '1',-1849.418,7550.838,-6.900715,0,0,0,100,0), -- 17:54:33
(@GUID,@POINT := @POINT + '1',-1863.478,7549.181,-6.103773,0,0,0,100,0), -- 17:54:36
(@GUID,@POINT := @POINT + '1',-1878.414,7533.926,-5.997984,0,0,0,100,0), -- 17:54:47
(@GUID,@POINT := @POINT + '1',-1881.629,7490.453,-6.484003,0,0,0,100,0), -- 17:54:57
(@GUID,@POINT := @POINT + '1',-1875.701,7453.972,-10.98962,0,0,0,100,0), -- 17:55:13
(@GUID,@POINT := @POINT + '1',-1881.78,7432.241,-15.98159,0,0,0,100,0), -- 17:55:26
(@GUID,@POINT := @POINT + '1',-1890.584,7396.346,-17.31263,0,0,0,100,0), -- 17:55:40
(@GUID,@POINT := @POINT + '1',-1912.452,7359.35,-19.56378,0,0,0,100,0), -- 17:55:58
(@GUID,@POINT := @POINT + '1',-1946.599,7355.847,-28.73429,0,0,0,100,0), -- 17:56:09
(@GUID,@POINT := @POINT + '1',-1969.85,7365.979,-33.96259,0,0,0,100,0), -- 17:56:23
(@GUID,@POINT := @POINT + '1',-2015.568,7375.497,-32.86669,0,0,0,100,0); -- 17:56:37
-- 0x203AF4424010C1C000004E000025E6BA .go -1915.491 7356.869 -20.41547

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60634;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-1302.205,7624.803,7.276413,0,0,0,100,0), -- 19:34:09
(@GUID,2,-1312.922,7646.278,2.754141,0,0,0,100,0), -- 19:34:20
(@GUID,3,-1351.89,7654.133,-1.505748,0,0,0,100,0), -- 19:34:33
(@GUID,4,-1384.569,7674.83,-3.9754,0,0,0,100,0), -- 19:34:53
(@GUID,5,-1412.666,7664.152,-5.481736,0,0,0,100,0), -- 19:35:08
(@GUID,6,-1448.351,7637.426,-8.554265,0,0,0,100,0), -- 19:35:24
(@GUID,7,-1465.681,7622.823,-4.682709,0,0,0,100,0), -- 19:35:40
(@GUID,8,-1497.248,7608.438,-5.353672,0,0,0,100,0), -- 19:35:57
(@GUID,9,-1527.661,7610.789,-6.175372,0,0,0,100,0), -- 19:36:10
(@GUID,10,-1553.621,7629.847,-7.146496,0,0,0,100,0), -- 19:36:21
(@GUID,11,-1548.901,7621.209,-6.405141,0,0,0,100,0), -- 19:36:34
(@GUID,12,-1523.317,7610.345,-5.953789,0,0,0,100,0), -- 19:36:46
(@GUID,13,-1496.56,7608.358,-5.173573,0,0,0,100,0), -- 19:36:55
(@GUID,14,-1455.15,7631.623,-8.053031,0,0,0,100,0), -- 19:37:09
(@GUID,15,-1438.385,7645.881,-6.150327,0,0,0,100,0), -- 19:37:26
(@GUID,16,-1388.237,7674.978,-4.912149,0,0,0,100,0), -- 19:37:43
(@GUID,17,-1360.621,7660.412,-2.251181,0,0,0,100,0), -- 19:37:57
(@GUID,18,-1315.393,7647.698,2.016763,0,0,0,100,0), -- 19:38:13
(@GUID,19,-1294.131,7627.167,7.624875,0,0,0,100,0), -- 19:38:33
(@GUID,20,-1318.049,7622.467,6.7452,0,0,0,100,0), -- 19:38:45
(@GUID,21,-1354.272,7606.448,6.544794,0,0,0,100,0), -- 19:38:56
(@GUID,22,-1355.293,7591.742,4.810247,0,0,0,100,0), -- 19:39:11
(@GUID,23,-1366.007,7550.521,7.946598,0,0,0,100,0), -- 19:39:19
(@GUID,24,-1371.217,7524.027,8.545133,0,0,0,100,0), -- 19:39:35
(@GUID,25,-1387.266,7497.755,6.306058,0,0,0,100,0), -- 19:39:47
(@GUID,26,-1416.09,7461.804,7.157196,0,0,0,100,0), -- 19:40:03
(@GUID,27,-1427.398,7451.228,5.889177,0,0,0,100,0), -- 19:40:16
(@GUID,28,-1448.477,7443.717,4.474332,0,0,0,100,0), -- 19:40:28
(@GUID,29,-1481.763,7480.544,0.1523862,0,0,0,100,0), -- 19:40:41
(@GUID,30,-1484.656,7506.044,0.8060154,0,0,0,100,0), -- 19:40:56
(@GUID,31,-1490.569,7537.37,-0.5237842,0,0,0,100,0), -- 19:41:09
(@GUID,32,-1500.598,7549.915,-2.289253,0,0,0,100,0), -- 19:41:23
(@GUID,33,-1494.558,7550.219,-1.370428,0,0,0,100,0), -- 19:41:38
(@GUID,34,-1488.232,7526.051,0.7160435,0,0,0,100,0), -- 19:41:49
(@GUID,35,-1483.127,7485.396,-0.7941005,0,0,0,100,0), -- 19:42:04
(@GUID,36,-1473.74,7452.768,4.078592,0,0,0,100,0), -- 19:42:17
(@GUID,37,-1440.161,7441.417,5.666845,0,0,0,100,0), -- 19:42:31
(@GUID,38,-1419.769,7458.304,6.488023,0,0,0,100,0), -- 19:42:45
(@GUID,39,-1399.421,7481.996,6.463001,0,0,0,100,0), -- 19:42:57
(@GUID,40,-1374.365,7515.159,7.70086,0,0,0,100,0), -- 19:43:11
(@GUID,41,-1371.034,7524.604,8.455896,0,0,0,100,0), -- 19:43:27
(@GUID,42,-1358.869,7574.053,4.025465,0,0,0,100,0), -- 19:43:39
(@GUID,43,-1355.657,7600.686,5.715598,0,0,0,100,0), -- 19:43:55
(@GUID,44,-1350.826,7607.966,7.040402,0,0,0,100,0); -- 19:44:02
-- 0x203AF4424010C1C000004E00002605E7 .go -1302.205 7624.803 7.276413

-- Pathing for  Entry: 17159 'TDB FORMAT' 
SET @GUID := 60641;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-796.4657,7319.421,41.3488,0,0,0,100,0), -- 20:36:24
(@GUID,@POINT := @POINT + '1',-782.9763,7280.29,41.96567,0,0,0,100,0), -- 20:36:44
(@GUID,@POINT := @POINT + '1',-785.2264,7252.184,37.70712,0,0,0,100,0), -- 20:37:00
(@GUID,@POINT := @POINT + '1',-785.8892,7246.396,37.37162,0,0,0,100,0), -- 20:37:12
(@GUID,@POINT := @POINT + '1',-773.5501,7182.709,39.06979,0,0,0,100,0), -- 20:37:21
(@GUID,@POINT := @POINT + '1',-760.2941,7165.347,43.37309,0,0,0,100,0), -- 20:37:39
(@GUID,@POINT := @POINT + '1',-771.6362,7179.201,39.82962,0,0,0,100,0), -- 20:37:52
(@GUID,@POINT := @POINT + '1',-776.9364,7200.371,36.93715,0,0,0,100,0), -- 20:38:03
(@GUID,@POINT := @POINT + '1',-783.9009,7233.563,37.55064,0,0,0,100,0), -- 20:38:20
(@GUID,@POINT := @POINT + '1',-782.23,7276.148,41.57604,0,0,0,100,0), -- 20:38:30
(@GUID,@POINT := @POINT + '1',-790.4199,7309.822,41.53657,0,0,0,100,0), -- 20:38:42
(@GUID,@POINT := @POINT + '1',-822.085,7345.247,43.0487,0,0,0,100,0), -- 20:38:58
(@GUID,@POINT := @POINT + '1',-829.4587,7375.8,38.87577,0,0,0,100,0), -- 20:39:17
(@GUID,@POINT := @POINT + '1',-825.9688,7416.76,44.29037,0,0,0,100,0), -- 20:39:30
(@GUID,@POINT := @POINT + '1',-817.2632,7446.914,47.11782,0,0,0,100,0), -- 20:39:48
(@GUID,@POINT := @POINT + '1',-783.2119,7481.059,54.19846,0,0,0,100,0), -- 20:39:58
(@GUID,@POINT := @POINT + '1',-823.2734,7493.722,53.85662,0,0,0,100,0), -- 20:40:18
(@GUID,@POINT := @POINT + '1',-849.2864,7491.099,49.74932,0,0,0,100,0), -- 20:40:36
(@GUID,@POINT := @POINT + '1',-895.9341,7489.496,42.3,0,0,0,100,0), -- 20:40:47
(@GUID,@POINT := @POINT + '1',-913.5043,7494.478,40.30548,0,0,0,100,0), -- 20:41:04
(@GUID,@POINT := @POINT + '1',-958.1111,7485.92,37.58797,0,0,0,100,0), -- 20:41:14
(@GUID,@POINT := @POINT + '1',-988.47,7483.397,35.71804,0,0,0,100,0), -- 20:41:33
(@GUID,@POINT := @POINT + '1',-1003.6,7481.156,33.59723,0,0,0,100,0), -- 20:41:43
(@GUID,@POINT := @POINT + '1',-1030.027,7474.588,34.15218,0,0,0,100,0), -- 20:41:58
(@GUID,@POINT := @POINT + '1',-1072.279,7432.266,34.09426,0,0,0,100,0), -- 20:42:11
(@GUID,@POINT := @POINT + '1',-1096.249,7389.751,33.77329,0,0,0,100,0), -- 20:42:27
(@GUID,@POINT := @POINT + '1',-1083.527,7413.597,34.39515,0,0,0,100,0), -- 20:42:46
(@GUID,@POINT := @POINT + '1',-1055.533,7455.415,33.83797,0,0,0,100,0), -- 20:43:02
(@GUID,@POINT := @POINT + '1',-1055.555,7455.415,33.83643,0,0,0,100,0), -- 20:33:14
(@GUID,@POINT := @POINT + '1',-1029.483,7475.046,34.03548,0,0,0,100,0), -- 20:33:31
(@GUID,@POINT := @POINT + '1',-993.3051,7482.854,34.84463,0,0,0,100,0), -- 20:33:44
(@GUID,@POINT := @POINT + '1',-977.8425,7483.703,37.24035,0,0,0,100,0), -- 20:33:57
(@GUID,@POINT := @POINT + '1',-920.2915,7495.626,39.39814,0,0,0,100,0), -- 20:34:08
(@GUID,@POINT := @POINT + '1',-901.5239,7491.1,41.62576,0,0,0,100,0), -- 20:34:26
(@GUID,@POINT := @POINT + '1',-854.5839,7490.362,48.70249,0,0,0,100,0), -- 20:34:36
(@GUID,@POINT := @POINT + '1',-830.4695,7494.348,52.83247,0,0,0,100,0), -- 20:34:54
(@GUID,@POINT := @POINT + '1',-799.7736,7487.462,54.22504,0,0,0,100,0), -- 20:35:04
(@GUID,@POINT := @POINT + '1',-815.9313,7450.179,47.92859,0,0,0,100,0), -- 20:35:24
(@GUID,@POINT := @POINT + '1',-821.7086,7433.381,45.09736,0,0,0,100,0), -- 20:35:43
(@GUID,@POINT := @POINT + '1',-829.3733,7387.784,39.05788,0,0,0,100,0), -- 20:35:54
(@GUID,@POINT := @POINT + '1',-825.9973,7351.636,42.39259,0,0,0,100,0); -- 20:36:11
-- 0x203AF4424010C1C000004E00002614A3 .go -1055.555 7455.415 33.83643

-- ----------------------------------------------------------
-- Talbuk packs
-- ----------------------------------------------------------

-- 1 Patriarch, 4 Stags, 1 Thorngrazer
DELETE FROM `creature_formations` WHERE `leaderGUID`=65498;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(65498,65498,0,0,0), -- Patriarch
(65498,59702,6,0.7,0), -- Stag
(65498,68108,6,3.9,0), -- Stag 
(65498,59700,6,5.5,0), -- Stag
(65498,59701,6,2.3,0), -- Stag
(65498,59788,8,0,0); -- Thorngrazer

UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid` IN (59788,59702,68108,59700,59701);

SET @GUID := 65498;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-1837.906250,6619.136719,-3.733728,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-1802.079346,6606.436523,-0.655963,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-1738.460693,6596.722168,-1.993880,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-1672.930420,6586.293457,4.540730,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1562.034546,6577.295410,4.540730,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1577.716553,6633.332031,1.878555,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1608.531494,6683.961426,3.218146,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1652.300537,6750.782715,-2.865198,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1676.219482,6776.321289,-9.658365,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1696.447754,6796.989746,-14.859472,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1711.947754,6814.493164,-17.874805,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1738.995850,6840.265625,-26.943909,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1784.635620,6850.056152,-30.962765,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1816.014282,6829.871582,-36.111855,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1817.851563,6807.831543,-35.466274,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1800.495728,6780.291016,-34.442913,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1791.538818,6762.562988,-29.148809,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1781.946533,6739.011719,-24.909246,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1779.026733,6705.042969,-23.770084,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1789.680420,6667.916016,-26.126898,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1803.351563,6652.561523,-21.662828,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1822.649658,6644.360352,-17.682804,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-1830.886841,6628.926270,-9.987613,0,0,0,100,0);


-- 1 Patriarch, 5 Stags, 2 Thorngrazer
DELETE FROM `creature_formations` WHERE `leaderGUID`=65497;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(65497,65497,0,0,0), -- Patriarch
(65497,59632,6,0.7,0), -- Stag
(65497,59630,6,1.5,0), -- Stag
(65497,68106,6,4.7,0), -- Stag 
(65497,59631,6,5.5,0), -- Stag
(65497,68107,6,2.3,0), -- Stag
(65497,59732,6,3.9,0), -- Thorngrazer
(65497,59731,8,0,0); -- Thorngrazer

UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid` IN (59632,59630,68106,59631,68107,59732,59731);

SET @GUID := 65497;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-2342.259277,`position_y`=6367.351563,`position_z`=28.038223 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-2342.259277,6367.351563,28.038223,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2300.882324,6374.016602,26.307806,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2253.633057,6402.676270,25.942070,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2203.975098,6429.952637,18.435156,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2164.174561,6445.201660,15.666538,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2155.874023,6460.815918,13.076160,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2182.359619,6504.177246,15.257035,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2201.156494,6542.579590,9.026549,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2264.874756,6549.381348,6.869394,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2320.307373,6537.656250,9.687850,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2366.299072,6551.759766,7.117074,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2409.335938,6547.215820,5.953309,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2429.826660,6503.998047,11.501584,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2419.294922,6435.339844,13.244519,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-2355.093994,6378.126465,27.225328,0,0,0,100,0);

-- Make the Blizzard (Shade of Aran) trigger Civilian so it doesn't aggro to players and doesn't fill the whole room with Blizzard.
UPDATE `creature_template` SET `flags_extra`=130 WHERE `entry`=17161;

-- Avian Flye 21931,21988
UPDATE `creature` SET `map` = 556 WHERE `id` IN (21931);
UPDATE creature_template SET `modelid_A2` = 4566, `modelid_H2` = 4566, `scale` = 0.75, `InhabitType` = 4, `unit_flags` = `unit_flags`|33554432 WHERE entry IN (21931,21988);
DELETE FROM creature_ai_scripts WHERE entryOrGUID = 21931;
INSERT INTO creature_ai_scripts VALUES 
('2193101','21931','11','0','100','0','0','0','0','0','31','1','4','0','0','0','0','0','0','0','0','0','Avian Flye - Random Phase on Spawn'),
('2193102','21931','1','13','100','0','0','0','0','0','3','0','4566','0','0','0','0','0','0','0','0','0','Avian Flye - Random Model (Phase 1)'),
('2193103','21931','1','11','100','0','0','0','0','0','3','0','20588','0','0','0','0','0','0','0','0','0','Avian Flye - Random Model (Phase 2)'),
('2193104','21931','1','7','100','0','0','0','0','0','3','0','20730','0','0','0','0','0','0','0','0','0','Avian Flye - Random Model (Phase 3)');
UPDATE `creature_model_info` SET `modelid_other_gender` = 20588, `gender` = 1 WHERE `modelid` = 18933;
UPDATE `creature_model_info` SET `modelid_other_gender` = 20730, `gender` = 1 WHERE `modelid` = 4566;
UPDATE `creature_model_info` SET `bounding_radius` = 2 WHERE `modelid` = 20588;
DELETE FROM `creature` WHERE `guid` BETWEEN 84904 AND 84936;
SET @GUID := 84904;
INSERT INTO creature (guid, id, map, spawnMask, position_x, position_y, position_z, orientation, spawntimesecs, curhealth, curmana, spawndist, MovementType) VALUES
(@GUID := @GUID + 0, 21931, 556, 3, -69.078, 255.062, 27.6692, 2.23169, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, 84.91618,251.3969,37.0668, 3.204143, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, 82.7928, 251.0653, 37.0668, 3.192098, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -55.35431, 292.4135, 27.84376, 3.334406, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -56.81138, 293.4768, 27.82975, 1.066901, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -109.229, 288.209, 53.3584, 3.249347, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -77.7733, 299.15, 60.5558, 5.757163, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -52.39689, 293.2879, 27.82958, 1.420948, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -65.26201, 281.413, 47.28283, 0.8305511, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -59.42, 289.0999, 27.89292, 2.894336, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -102.279, 278.86, 56.0703, 5.414571, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -86.60637, 286.1224, 27.48317, 2.953945, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -68.3353, 281.741, 61.757, 3.844181, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -71.9701, 272.574, 59.1446, 6.184331, 7200, 6326, 0, 0, 2),
(@GUID := @GUID + 1, 21931, 556, 3, -84.35631, 263.7281, 27.80793, 4.523829, 7200, 6326, 0, 0, 2);

DELETE FROM `creature_addon` WHERE `guid` BETWEEN 84904 AND 84918;
INSERT INTO `creature_addon` VALUES
(84904,84904,0,0,0,4097,0,0,''),
(84905,84905,0,0,0,4097,0,0,''),
(84906,84906,0,0,0,4097,0,0,''),
(84907,84907,0,0,0,4097,0,0,''),
(84908,84908,0,0,0,4097,0,0,''),
(84909,84909,0,0,0,4097,0,0,''),
(84910,84910,0,0,0,4097,0,0,''),
(84911,84911,0,0,0,4097,0,0,''),
(84912,84912,0,0,0,4097,0,0,''),
(84913,84913,0,0,0,4097,0,0,''),
(84914,84914,0,0,0,4097,0,0,''),
(84915,84915,0,0,0,4097,0,0,''),
(84916,84916,0,0,0,4097,0,0,''),
(84917,84917,0,0,0,4097,0,0,''),
(84918,84918,0,0,0,4097,0,0,'');

DELETE FROM `waypoint_data` WHERE `id` BETWEEN 84904 AND 84918;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- #1
(84904,1,-69.078,255.062,27.6692,1000,1,0,0,0),
(84904,2,-69.078,255.062,27.6692,0,1,0,0,0),
(84904,3,-77.6467,256.825,27.8182,0,1,0,0,0),
(84904,4,-85.5541,263.248,37.4314,0,1,0,0,0),
(84904,5,-89.3701,273.449,46.1637,0,1,0,0,0),
(84904,6,-87.3918,283.626,55.5433,0,1,0,0,0),
(84904,7,-81.6323,288.392,67.374,0,1,0,0,0),
(84904,8,-83.6451,281.803,77.323,0,1,0,0,0),
(84904,9,-97.3242,280.983,74.488,0,1,0,0,0),
(84904,10,-95.2966,294.303,27.4832,0,1,0,0,0),
(84904,11,-91.9066,298.554,40.3148,0,1,0,0,0),
(84904,12,-84.9968,296.969,52.3776,0,1,0,0,0),
(84904,13,-81.5458,289.807,63.8514,0,1,0,0,0),
(84904,14,-91.5585,284.275,71.9894,0,1,0,0,0),
(84904,15,-95.834,292.943,27.4832,0,1,0,0,0),
(84904,16,-94.3393,295.352,41.1404,0,1,0,0,0),
(84904,17,-88.5665,292.19,53.5047,0,1,0,0,0),
(84904,18,-88.0789,284.173,65.0211,0,1,0,0,0),
(84904,19,-96.7033,282.247,75.63,0,1,0,0,0),
(84904,20,-92.1857,296.241,27.4832,0,1,0,0,0),
-- #2
(84905,1,-84.35631,263.7281,27.80793,1000,1,0,0,0),
(84905,2,-87.4666,261.464,58.4138,0,1,0,0,0),
(84905,3,-94.4575,270.352,66.6585,0,1,0,0,0),
(84905,4,-95.7386,284.443,27.4832,0,1,0,0,0),
(84905,5,-91.3219,290.488,39.2894,0,1,0,0,0),
(84905,6,-84.573,290.53,51.5467,0,1,0,0,0),
(84905,7,-83.1581,284.409,64.0506,0,1,0,0,0),
(84905,8,-92.9101,280.978,73.484,0,1,0,0,0),
(84905,9,-96.079,293.202,74.566,0,1,0,0,0),
(84905,10,-82.8515,297.569,74.9201,0,1,0,0,0),
(84905,11,-77.4638,284.989,27.4832,0,1,0,0,0),
(84905,12,-81.0183,279.803,39.9446,0,1,0,0,0),
(84905,13,-89.1536,280.506,51.3678,0,1,0,0,0),
(84905,14,-94.1382,293.611,27.4832,0,1,0,0,0),
(84905,15,-88.9669,297.982,39.6762,0,1,0,0,0),
(84905,16,-84.4414,293.357,52.098,0,1,0,0,0),
(84905,17,-86.5034,284.787,63.0289,0,1,0,0,0),
(84905,18,-97.8593,278.945,26.2094,0,1,0,0,0),
(84905,19,-83.9472,285.452,63.0513,0,1,0,0,0),
(84905,20,-93.4871,275.608,26.8408,0,1,0,0,0),
-- #3
(84906,1,84.91618,251.3969,37.0668,1000,1,0,0,0),
(84906,2,83.96513,251.0878,37.0668,0,1,0,0,0),
(84906,3,51.4796,252.1832,37.0668,0,1,0,0,0),
(84906,4,33.24739,282.4318,37.0668,0,1,0,0,0),
(84906,5,-4.585953,288.248,37.0668,0,1,0,0,0),
(84906,6,-33.12523,287.3879,33.65012,0,1,0,0,0),
(84906,7,-63.6614,287.1449,37.0668,0,1,0,0,0),
(84906,8,-86.58053,281.3122,37.0668,0,1,0,0,0),
(84906,9,-122.8668,287.5829,33.70568,0,1,0,0,0),
(84906,10,-166.1352,286.0018,37.0668,0,1,0,0,0),
(84906,11,-197.1293,319.5987,41.56683,0,1,0,0,0),
(84906,12,-226.7219,321.6883,41.53905,0,1,0,0,0),
(84906,13,-241.978,284.0257,37.0668,0,1,0,0,0),
(84906,14,-241.867,239.6969,34.78908,0,1,0,0,0),
(84906,15,-240.4087,205.2585,33.28898,0,1,0,0,0),
(84906,16,-247.9211,181.8263,37.0668,0,1,0,0,0),
(84906,17,-258.5413,176.8185,28.87236,0,1,0,0,0),
(84906,18,-254.5885,187.9291,17.59458,0,1,0,0,0),
(84906,19,-233.2822,183.525,9.455688,0,1,0,0,0),
(84906,20,-207.9685,174.1038,9.455688,0,1,0,0,0),
(84906,21,-174.2731,173.5923,7.177915,0,1,0,0,0),
(84906,22,-153.4284,164.0868,10.48346,0,1,0,0,0),
(84906,23,-141.7187,162.8539,10.98347,0,1,0,0,0),
(84906,24,-125.9314,171.5796,9.150148,0,1,0,0,0),
(84906,25,-97.73457,173.6499,7.150136,0,1,0,0,0),
(84906,26,-82.8989,173.9212,10.3168,0,1,0,0,0),
(84906,27,-73.91816,173.0771,10.3168,0,1,0,0,0),
(84906,28,-69.98465,163.4588,10.3168,0,1,0,0,0),
(84906,29,-70.28123,156.7726,9.34458,0,1,0,0,0),
(84906,30,-71.15484,128.5923,6.705695,0,1,0,0,0),
(84906,31,-80.03834,115.5755,7.511248,0,1,0,0,0),
(84906,32,-82.54434,99.08558,7.511248,0,1,0,0,0),
(84906,33,-74.70563,88.52892,7.511248,0,1,0,0,0),
(84906,34,-60.10373,87.1475,7.511248,0,1,0,0,0),
(84906,35,-43.85668,99.20913,7.039028,0,1,0,0,0),
(84906,36,-21.47738,99.80711,7.261249,0,1,0,0,0),
(84906,37,7.509675,100.2483,7.511248,0,1,0,0,0),
(84906,38,27.40248,97.8097,19.31681,0,1,0,0,0),
(84906,39,37.0373,95.82257,30.84459,3000,1,2193102,0,0),
-- #4
(84907,1,-119.16,291.958,26.7305,1000,1,0,0,0),
(84907,2,-119.16,291.958,26.7305,0,1,0,0,0),
(84907,3,-118.246,291.551,26.7198,0,1,0,0,0),
(84907,4,-116.125,290.169,41.5238,0,1,0,0,0),
(84907,5,-114.528,275.12,40.1532,0,1,0,0,0),
(84907,6,-90.689,265.24,41.0333,0,1,0,0,0),
(84907,7,-62.0894,286.098,48.6939,0,1,0,0,0),
(84907,8,-76.8407,304.686,51.9439,0,1,0,0,0),
(84907,9,-98.7576,303.572,46.4161,0,1,0,0,0),
-- #5
(84908,1,-56.81138,293.4768,27.82975,1000,1,0,0,0),
(84908,2,-58.7468,295.764,29.4033,0,1,0,0,0),
(84908,3,-80.8255,317.109,28.9557,0,1,0,0,0),
(84908,4,-84.6018,313.357,62.0829,0,1,0,0,0),
(84908,5,-100.485,310.06,60.6726,0,1,0,0,0),
(84908,6,-119.643,290.201,57.4676,0,1,0,0,0),
(84908,7,-119.602,271.028,61.3137,0,1,0,0,0),
(84908,8,-99.3827,260.039,59.8997,0,1,0,0,0),
(84908,9,-62.9444,265.206,63.3061,0,1,0,0,0),
(84908,10,-53.9817,286.896,63.0482,0,1,0,0,0),
(84908,11,-66.9341,300.934,58.5854,0,1,0,0,0),
(84908,12,-82.0958,309.241,61.3414,0,1,0,0,0),
(84908,13,-100.199,310.19,60.9001,0,1,0,0,0),
(84908,14,-109.249,296.2,58.5368,0,1,0,0,0),
(84908,15,-112.956,287.824,28.945,0,1,0,0,0),
(84908,16,-131.244,263.41,30.9794,0,1,0,0,0),
(84908,17,-124.562,262.687,57.9071,0,1,0,0,0),
(84908,18,-89.1208,261.935,60.3001,0,1,0,0,0),
(84908,19,-66.6449,264.328,64.3038,0,1,0,0,0),
(84908,20,-56.4546,270.201,65.3866,0,1,0,0,0),
(84908,21,-53.7442,287.453,64.0839,0,1,0,0,0),
(84908,22,-56.4072,293.549,29.5758,0,1,0,0,0),
-- #6
(84909,1,-59.42,289.0999,27.89292,1000,1,0,0,0),
(84909,2,-58.7468,295.764,29.4033,0,1,0,0,0),
(84909,3,-80.8255,317.109,28.9557,0,1,0,0,0),
(84909,4,-84.6018,313.357,62.0829,0,1,0,0,0),
(84909,5,-100.485,310.06,60.6726,0,1,0,0,0),
(84909,6,-119.643,290.201,57.4676,0,1,0,0,0),
(84909,7,-119.602,271.028,61.3137,0,1,0,0,0),
(84909,8,-99.3827,260.039,59.8997,0,1,0,0,0),
(84909,9,-62.9444,265.206,63.3061,0,1,0,0,0),
(84909,10,-53.9817,286.896,63.0482,0,1,0,0,0),
(84909,11,-66.9341,300.934,58.5854,0,1,0,0,0),
(84909,12,-82.0958,309.241,61.3414,0,1,0,0,0),
(84909,13,-100.199,310.19,60.9001,0,1,0,0,0),
(84909,14,-109.249,296.2,58.5368,0,1,0,0,0),
(84909,15,-112.956,287.824,28.945,0,1,0,0,0),
(84909,16,-131.244,263.41,30.9794,0,1,0,0,0),
(84909,17,-124.562,262.687,57.9071,0,1,0,0,0),
(84909,18,-89.1208,261.935,60.3001,0,1,0,0,0),
(84909,19,-66.6449,264.328,64.3038,0,1,0,0,0),
(84909,20,-56.4546,270.201,65.3866,0,1,0,0,0),
(84909,21,-53.7442,287.453,64.0839,0,1,0,0,0),
(84909,22,-56.4072,293.549,29.5758,0,1,0,0,0),
-- #7
(84910,1,-52.39689,293.2879,27.82958,1000,1,0,0,0),
(84910,2,-58.7468,295.764,29.4033,0,1,0,0,0),
(84910,3,-80.8255,317.109,28.9557,0,1,0,0,0),
(84910,4,-84.6018,313.357,62.0829,0,1,0,0,0),
(84910,5,-100.485,310.06,60.6726,0,1,0,0,0),
(84910,6,-119.643,290.201,57.4676,0,1,0,0,0),
(84910,7,-119.602,271.028,61.3137,0,1,0,0,0),
(84910,8,-99.3827,260.039,59.8997,0,1,0,0,0),
(84910,9,-62.9444,265.206,63.3061,0,1,0,0,0),
(84910,10,-53.9817,286.896,63.0482,0,1,0,0,0),
(84910,11,-66.9341,300.934,58.5854,0,1,0,0,0),
(84910,12,-82.0958,309.241,61.3414,0,1,0,0,0),
(84910,13,-100.199,310.19,60.9001,0,1,0,0,0),
(84910,14,-109.249,296.2,58.5368,0,1,0,0,0),
(84910,15,-112.956,287.824,28.945,0,1,0,0,0),
(84910,16,-131.244,263.41,30.9794,0,1,0,0,0),
(84910,17,-124.562,262.687,57.9071,0,1,0,0,0),
(84910,18,-89.1208,261.935,60.3001,0,1,0,0,0),
(84910,19,-66.6449,264.328,64.3038,0,1,0,0,0),
(84910,20,-56.4546,270.201,65.3866,0,1,0,0,0),
(84910,21,-53.7442,287.453,64.0839,0,1,0,0,0),
(84910,22,-56.4072,293.549,29.5758,0,1,0,0,0),
-- #8
(84911,1,-62.0894,286.098,48.6939,1000,1,0,0,0),
(84911,2,-76.8407,304.686,51.9439,0,1,0,0,0),
(84911,3,-98.7576,303.572,46.4161,0,1,0,0,0),
(84911,4,-119.16,291.958,26.7305,0,1,0,0,0),
(84911,5,-119.16,291.958,26.7305,0,1,0,0,0),
(84911,6,-118.246,291.551,26.7198,0,1,0,0,0),
(84911,7,-116.125,290.169,41.5238,0,1,0,0,0),
(84911,8,-114.528,275.12,40.1532,0,1,0,0,0),
(84911,9,-90.689,265.24,41.0333,0,1,0,0,0),
-- #9
(84912,1,-109.229,288.209,53.3584,1000,1,0,0,0),
(84912,2,-102.279,278.86,56.0703,0,1,0,0,0),
(84912,3,-88.1313,272.423,59.4688,0,1,0,0,0),
(84912,4,-71.9701,272.574,59.1446,0,1,0,0,0),
(84912,5,-68.3353,281.741,61.757,0,1,0,0,0),
(84912,6,-77.7733,299.15,60.5558,0,1,0,0,0),
(84912,7,-94.7425,300.49,56.1018,0,1,0,0,0),
-- #10
(84913,1,-71.9701,272.574,59.1446,1000,1,0,0,0),
(84913,2,-68.3353,281.741,61.757,0,1,0,0,0),
(84913,3,-77.7733,299.15,60.5558,0,1,0,0,0),
(84913,4,-94.7425,300.49,56.1018,0,1,0,0,0),
(84913,5,-109.229,288.209,53.3584,0,1,0,0,0),
(84913,6,-102.279,278.86,56.0703,0,1,0,0,0),
(84913,7,-88.1313,272.423,59.4688,0,1,0,0,0),
-- #11
(84914,1,-68.3353,281.741,61.757,1000,1,0,0,0),
(84914,2,-77.7733,299.15,60.5558,0,1,0,0,0),
(84914,3,-94.7425,300.49,56.1018,0,1,0,0,0),
(84914,4,-109.229,288.209,53.3584,0,1,0,0,0),
(84914,5,-102.279,278.86,56.0703,0,1,0,0,0),
(84914,6,-88.1313,272.423,59.4688,0,1,0,0,0),
(84914,7,-71.9701,272.574,59.1446,0,1,0,0,0),
-- #12
(84915,1,-102.279,278.86,56.0703,1000,1,0,0,0),
(84915,2,-88.1313,272.423,59.4688,0,1,0,0,0),
(84915,3,-71.9701,272.574,59.1446,0,1,0,0,0),
(84915,4,-68.3353,281.741,61.757,0,1,0,0,0),
(84915,5,-77.7733,299.15,60.5558,0,1,0,0,0),
(84915,6,-94.7425,300.49,56.1018,0,1,0,0,0),
(84915,7,-109.229,288.209,53.3584,0,1,0,0,0),
-- #13
(84916,1,-77.7733,299.15,60.5558,1000,1,0,0,0),
(84916,2,-94.7425,300.49,56.1018,0,1,0,0,0),
(84916,3,-109.229,288.209,53.3584,0,1,0,0,0), 
(84916,4,-102.279,278.86,56.0703,0,1,0,0,0),
(84916,5,-88.1313,272.423,59.4688,0,1,0,0,0),
(84916,6,-71.9701,272.574,59.1446,0,1,0,0,0),
(84916,7,-68.3353,281.741,61.757,0,1,0,0,0),
-- #14
(84917,1,-86.60637,286.1224,27.48317,1000,1,0,0,0),
(84917,2,-84.2669,286.076,57.4227,0,1,0,0,0),
(84917,3,-71.9701,272.574,59.1446,0,1,0,0,0),
(84917,4,-68.3353,281.741,61.757,0,1,0,0,0),
(84917,5,-77.7733,299.15,60.5558,0,1,0,0,0),
(84917,6,-94.7425,300.49,56.1018,0,1,0,0,0),
(84917,7,-109.229,288.209,53.3584,0,1,0,0,0),
(84917,8,-102.279,278.86,56.0703,0,1,0,0,0),
(84917,9,-88.1313,272.423,59.4688,0,1,0,0,0),
-- #15
(84918,1,84.91618,251.3969,37.0668,1000,1,0,0,0),
(84918,2,83.96513,251.0878,37.0668,0,1,0,0,0),
(84918,3,51.4796,252.1832,37.0668,0,1,0,0,0),
(84918,4,33.24739,282.4318,37.0668,0,1,0,0,0),
(84918,5,-4.585953,288.248,37.0668,0,1,0,0,0),
(84918,6,-33.12523,287.3879,33.65012,0,1,0,0,0),
(84918,7,-63.6614,287.1449,37.0668,0,1,0,0,0),
(84918,8,-77.5616,286.325,98.1903,3000,1,2193102,0,0);

-- 2193102 despawn + respawn
