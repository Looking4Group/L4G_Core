-- Blade's Edge Arena Start Orientation
UPDATE `battleground_template` SET `AllianceStartO` = 4.0551, `HordeStartO` = 0.8703 WHERE `id` = 5;

-- Arcane Anomaly 16488
-- some sources say immune to all magic
UPDATE `creature` SET `spawntimesecs` = 3600;
UPDATE `creature_template` SET `mindmg`='3396',`maxdmg`='4342',`resistance1` = '0', `resistance2` = '0', `resistance3` = '0', `resistance4` = '0', `resistance5` = '0', `resistance6` = '70' WHERE `entry` = 16488; -- 1308 2660 -- 7,258 - 8,610
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16488;
INSERT INTO `creature_ai_scripts` VALUES
('1648801','16488','11','0','100','2','0','0','0','0','42','1','1','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Set Invincible at 1% HP on Spawn'),
('1648802','16488','2','0','100','2','1','0','0','0','11','29880','0','1','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Mana Shield at 1% HP'),
('1648803','16488','9','0','100','3','0','40','6000','10000','11','29885','4','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Arcane Volley'),
('1648804','16488','0','0','100','3','18000','30000','30000','45000','11','29883','0','1','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Blink'), -- 4
('1648805','16488','3','0','100','2','1','0','0','0','42','0','1','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Remove Invincible at 1% Mana'),
('1648806','16488','6','0','100','2','0','0','0','0','11','29882','0','7','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Loose Mana on Death');

-- Syphoner 16492
UPDATE `creature_template` SET `mindmg`='1450',`maxdmg`='1856' WHERE `entry` = 16492; -- 558 1138 -- 3,102 - 3,682
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16492;
INSERT INTO `creature_ai_scripts` VALUES
('1649201','16492','9','0','100','3','0','15','9000','13000','11','29881','4','0','0','0','0','0','0','0','0','0','Syphoner - Cast Drain Mana');

-- Shattered Rumbler mob_shattered_rumbler
UPDATE `creature_template` SET `ScriptName` = NULL, `AIName` = 'EventAI', `resistance3` = -1 WHERE `entry` = 17157;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17157;
INSERT INTO `creature_ai_scripts` VALUES
('1715701','17157','0','0','100','1','7000','14000','14000','21000','11','33840','0','0','0','0','0','0','0','0','0','0','Shattered Rumbler - Cast Earth Rumble'),
('1715702','17157','8','0','100','0','32001','-1','0','0','12','18181','1','300','12','18181','1','300','12','18181','1','300','Shattered Rumbler - Summon 3 Minion of Gurok on Spellhit: Throw Gordawg''s Boulder'),
('1715703','17157','8','0','100','0','32001','-1','0','0','37','0','0','0','0','0','0','0','0','0','0','0','Shattered Rumbler - Die on Spellhit: Throw Gordawg''s Boulder');

SET @GUID := 140137;
SET @POINT := 0;
UPDATE `creature` SET `position_x`='-161.630005', `position_y`='964.481018', `position_z`='54.2989', `MovementType`='2' WHERE `guid` = @GUID;   
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -177.693893, 1011.964844, 54.2894,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -187.083023, 1020.650879, 54.2643,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -220.110153, 1032.145386, 54.3258,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -236.153015, 1074.382080, 54.3067,0,1,1375,100,0),
(@GUID,@POINT := @POINT + 1, -234.447998, 1097.599976, 41.7915,600000,0,2285701,100,0);

SET @GUID := 140125;
SET @POINT := 0;
UPDATE `creature` SET `position_x`='-337.196014', `position_y`='961.669006', `position_z`='54.2979', `MovementType`='2' WHERE `guid` = @GUID;    
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,66048,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -321.404114, 1009.786682, 54.2896,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -312.622986, 1018.638977, 54.2642,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -279.923157, 1031.153564, 54.3265,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -264.772156, 1073.969727, 54.3070,0,1,1333,100,0),
(@GUID,@POINT := @POINT + 1, -266.312012, 1099.079956, 41.7915,600000,0,2285701,100,0);

DELETE FROM `waypoint_scripts` WHERE `id` IN (1333, 1375);
INSERT INTO `waypoint_scripts` VALUES
(1333, 0, 2, 169, 333, 0, 0, 0, 0, 0, 1333, 'STATE_READY1H'),
(1375, 0, 2, 169, 375, 0, 0, 0, 0, 0, 1375, 'STATE_READY2H');

DELETE FROM `creature_addon` WHERE `guid` IN (140119, 140126);
INSERT INTO `creature_addon` VALUES
(140126, 0, 0, 66048, 0, 4097, 0, 0, NULL),
(140119, 0, 0, 16843008, 0, 4097, 0, 0, NULL);
