-- Scryer Cavalier 22967
UPDATE `creature_template` SET `minlevel`='69',`maxlevel`='69',`armor`='6492',`mindmg`='96',`maxdmg`='195',`faction_A`='1838',`faction_H`='1838',`unit_flags`='32768',`AIName`='EventAI',`mechanic_immune_mask`='65536',`equipment_id`='1660' WHERE `entry` = 22967;
DELETE FROM `creature_template_addon` WHERE `entry` = 22967;
INSERT INTO `creature_template_addon` VALUES
(22967,0,19483,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22967;
INSERT INTO `creature_ai_scripts` VALUES
('2296701','22967','0','0','100','1','1000','3000','120000','240000','11','30931','0','0','0','0','0','0','0','0','0','0','Scryer Cavalier - Cast Battle Shout'),
('2296702','22967','0','0','100','1','10000','14000','17000','21000','11','35871','1','0','0','0','0','0','0','0','0','0','Scryer Cavalier - Cast Spellbreaker'),
('2296703','22967','6','0','100','0','0','0','0','0','11','39783','1','7','0','0','0','0','0','0','0','0','Scryer Cavalier - Summon Eclipsion Hawkstrider on Death');

DELETE FROM `creature` WHERE `guid` BETWEEN 132960 AND 132964;
INSERT INTO `creature` VALUES (132960, 22967, 530, 1, 0, 0, -3609.14, 739.651, -9.26425, 0.196605, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (132961, 22967, 530, 1, 0, 0, -3605.89, 738.174, -9.79895, 0.130639, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (132962, 22967, 530, 1, 0, 0, -3608.7, 730.693, -9.24896, 0.130639, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (132963, 22967, 530, 1, 0, 0, -3602.65, 735.693, -10.0605, 0.130639, 180, 0, 0, 6761, 0, 0, 2);
INSERT INTO `creature` VALUES (132964, 22967, 530, 1, 0, 0, -3605.52, 733.791, -9.77686, 0.130639, 180, 0, 0, 6761, 0, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderguid` = 132963;
INSERT INTO `creature_formations` VALUES
(132963,132963,100,360,2),
(132963,132960,6,5.5,2),
(132963,132961,3,5.5,2),
(132963,132962,6,0.7,2),
(132963,132964,3,0.7,2);

SET @GUID := 132963;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,19483,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX,YYY,ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3577.7795,735.9827,-11.9157,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3560.6403,735.0994,-13.8505,30000,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3577.7795,735.9827,-11.9157,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3605.6833,736.4700,-9.8442,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3634.7702,726.7840,-5.2179,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3664.9912,734.4345,-2.0007,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3732.5473,751.4430,7.0705,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3781.6013,747.2598,9.5973,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3826.3664,750.4028,11.0102,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3858.5913,751.9708,10.3980,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3880.9121,775.3513,9.5625,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3883.0070,818.8770,11.9000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3888.3037,859.6588,16.2894,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3880.1987,892.9423,18.8295,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3884.8740,942.7310,21.5951,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3880.6784,1005.2694,23.5252,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3925.6542,1045.3082,25.5732,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3962.4689,1077.9169,29.2199,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4007.7727,1091.1273,30.4545,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4069.7634,1070.9010,30.5566,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4080.9343,1091.3734,36.3465,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4076.1057,1082.8961,33.7892,30000,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4069.7634,1070.9010,30.5566,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-4007.7727,1091.1273,30.4545,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3962.4689,1077.9169,29.2199,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3925.6542,1045.3082,25.5732,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3880.6784,1005.2694,23.5252,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3884.8740,942.7310,21.5951,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3880.1987,892.9423,18.8295,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3888.3037,859.6588,16.2894,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3883.0070,818.8770,11.9000,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3880.9121,775.3513,9.5625,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3858.5913,751.9708,10.3980,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3826.3664,750.4028,11.0102,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3781.6013,747.2598,9.5973,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3732.5473,751.4430,7.0705,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3664.9912,734.4345,-2.0007,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3634.7702,726.7840,-5.2179,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1,-3605.6833,736.4700,-9.8442,0,0,0,100,0);

-- Eclipsion Bloodwarder 19806
UPDATE `creature_template` SET `mechanic_immune_mask`='65536' WHERE `entry` = 19806;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19806;
INSERT INTO `creature_ai_scripts` VALUES
('1980601','19806','2','0','100','0','35','0','0','0','11','37838','4','0','0','0','0','0','0','0','0','0','Eclipsion Bloodwarder - Cast Blood Leech at 35% HP'),
('1980602','19806','6','0','100','0','0','0','0','0','11','38311','1','7','0','0','0','0','0','0','0','0','Eclipsion Bloodwarder - Summon Eclipsion Hawkstrider on Death'),
('1980603','19806','13','0','100','1','8000','12000','0','0','11','38313','1','1','0','0','0','0','0','0','0','0','Eclipsion Bloodwarder - Cast Pummel on Player Spellcasting');

-- Eclipsion Cavalier 22018
UPDATE `creature_template` SET `mechanic_immune_mask`='65536' WHERE `entry` = 22018;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` =22018;
INSERT INTO `creature_ai_scripts` VALUES
('2201801','22018','0','0','100','1','1000','3000','120000','240000','11','30931','0','0','0','0','0','0','0','0','0','0','Eclipsion Cavalier - Cast Battle Shout'),
('2201802','22018','0','0','100','1','10000','14000','17000','21000','11','35871','1','0','0','0','0','0','0','0','0','0','Eclipsion Cavalier - Cast Spellbreaker'),
('2201803','22018','6','0','100','0','0','0','0','0','11','38311','1','7','0','0','0','0','0','0','0','0','Eclipsion Cavalier - Summon Eclipsion Hawkstrider on Death');

UPDATE `creature` SET `position_x`='-1230.2587',`position_y`='5751.5078',`position_z`='41.0792' WHERE `guid` = 64845;
UPDATE `creature` SET `position_x`='68.3115',`position_y`='8190.1899',`position_z`='21.2747',`orientation`='4.0090' WHERE `guid` = 64658;
