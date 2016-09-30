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

-- Scryer Hawkstrider 22969
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`minhealth`='4192',`maxhealth`='4192',`armor`='6792',`faction_A`='1838',`faction_H`='1838',`mindmg`='60',`maxdmg`='123',`unit_flags`='32768',`AIName`='EventAI'  WHERE `entry` = '22969';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22969');
INSERT INTO `creature_ai_scripts` VALUES
('2296901','22969','1','0','100','0','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Scryer Hawkstrider - Despawn OOC');

UPDATE `creature` SET `position_x`='-1230.2587',`position_y`='5751.5078',`position_z`='41.0792' WHERE `guid` = 64845;
UPDATE `creature` SET `position_x`='68.3115',`position_y`='8190.1899',`position_z`='21.2747',`orientation`='4.0090' WHERE `guid` = 64658;

DELETE FROM `creature_formations` WHERE `leaderguid` = 112008;
INSERT INTO `creature_formations` VALUES 
(112008,112008,100,360,1),
(112008,111481,100,360,1),
(112008,110619,100,360,1);

UPDATE `creature` SET `position_x`='361.8721', `position_y`='-724.3999', `position_z`='-14.0032' WHERE `guid` = 82974;

-- Warchief Kargath Bladefist 16808,20597
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry` = 20597 AND `item` = 35003; -- 1
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 40 WHERE `entry` = 20597 AND `Item` = 50021; -- 66

-- Warp Splinter
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry` = 21582 AND `item` = 35006; -- 1
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 40 WHERE `entry` = 21582 AND `Item` = 50013; -- 66

-- Pathaleon the Calculator 19220,21537
UPDATE `creature_loot_template` SET `maxcount`=2 WHERE `entry` = 21537 AND `item` = 35005; -- 1
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 40 WHERE `entry` = 21537 AND `Item` = 50018; -- 66

-- Harbinger Skyriss 20912,21599
DELETE FROM `creature_loot_template` WHERE `item` = 50028 AND `entry` IN (21599);
INSERT INTO `creature_loot_template` VALUES 
(21599,50028,40,0,-50028,1,0,0,0);

DELETE FROM `reference_loot_template` WHERE `entry` = 50028;
INSERT INTO `reference_loot_template` VALUES (50028, 30581, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 30575, 0, 1, 1, 1, 0, 0, 0);
INSERT INTO `reference_loot_template` VALUES (50028, 30582, 0, 1, 1, 1, 0, 0, 0);

UPDATE `creature` SET `spawntimesecs` = '300' WHERE `id` = 20159;
UPDATE `creature_template` SET `speed`='1.20',`AIName`='EventAI' WHERE `entry` = 20159;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20159;
INSERT INTO `creature_ai_scripts` VALUES 
(2015901,20159,9,0,100,1,0,10,12000,15000,11,11831,0,1,0,0,0,0,0,0,0,0,'Magister Aledis - Casts Frost Nova'),
(2015902,20159,0,0,100,1,3500,5500,10000,10000,11,33975,1,0,0,0,0,0,0,0,0,0,'Magister Aledis - Casts Pyroblast'),
(2015903,20159,4,0,100,0,0,0,0,0,11,20823,1,0,22,1,0,0,0,0,0,0,'Magister Aledis - Cast Fireball and Set Phase 1 on Aggro'),
(2015904,20159,0,13,100,1,3000,3500,3000,3500,0,0,0,0,11,20823,1,0,0,0,0,0,'Magister Aledis - Cast Fireball (Phase 1)'),
(2015905,20159,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Magister Aledis - Start Movement and Set Phase 2 when Mana is at 15%'),
(2015906,20159,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Magister Aledis - Start Movement Beyond 25 Yards'),
(2015907,20159,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Magister Aledis - Set Phase 1 when Mana is above 30% (Phase 2)'),
(2015908,20159,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Magister Aledis - Set Phase 3 at 15% HP'),
(2015909,20159,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Magister Aledis - Start Movement and Flee at 15% HP (Phase 3)'),
(2015910,20159,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Magister Aledis - On Evade set Phase to 0');
