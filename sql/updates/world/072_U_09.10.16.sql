-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/717
-- No birds are spawning from Kaliri nests, missing nest spawns, static bird spawns that shouldn't be there.
-- ----------------------------------------------------------
 
-- The spell "Break Kaliri Egg" (http://db.looking4group.eu/?spell=29395) doesn't work, so I'm going to do this with an invisible trigger instead.
 
DELETE FROM `creature_template` WHERE `entry` IN ('1000012');
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES
(1000012, 0, 17519, 11686, 17519, 11686, 'Invisible Kaliri Spawner', 61, 61, 112, 112, 0, 0, 20, 114, 114, 0, 0.91, 1, 0, 0, 0, 0, 0, 2000, 0, 33587968, 0, 0, 0, 0, 0, 0, 1.76, 2.42, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 0, 1, 0, 0, 128, '');
 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (1000012);
INSERT INTO `creature_ai_scripts` VALUES
(100001201, 1000012, 11, 0, 20, 0, 0, 0, 0, 0, 12, 17034, 1, 100000, 41, 0, 0, 0, 0, 0, 0, 0, 'Invisible Kaliri Spawner - Summon Female Kaliri, then despawn self'), -- 1/5 chance of getting a female
(100001202, 1000012, 1, 0, 100, 0, 0, 100, 0, 0, 12, 17039, 1, 100000, 41, 0, 0, 0, 0, 0, 0, 0, 'Invisible Kaliri Spawner - Summon Male Kaliri, then despawn self'); -- If no female, spawn a male instead
 
UPDATE `gameobject_template` SET `type`=3, `data0`=43, `data3`=0, `data10`=0, `data14`=0 WHERE  `entry`=181582;
 
-- Add missing nest spawns
DELETE FROM `gameobject` WHERE `guid` BETWEEN 21923 AND 21925;
INSERT INTO `gameobject` VALUES
(21923,181582,530,1,-1138.567871,4243.345215,14.137020,0,0,0,0,0,181,100,1),
(21924,181582,530,1,-1152.503906,4263.899414,13.958394,0,0,0,0,0,181,100,1),
(21925,181582,530,1,-1141.335938,4213.396484,51.825722,0,0,0,0,0,181,100,1);
 
-- Make the trigger spawn from any of the nests
DELETE FROM `gameobject_scripts` WHERE id BETWEEN 21923 AND 21925;
DELETE FROM `gameobject_scripts` WHERE id BETWEEN 21931 AND 21940;
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21923, 0, 10, 1000012, 180000, -1138.56, 4243.34, 14.137);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21924, 0, 10, 1000012, 180000, -1152.50, 4263.89, 13.958);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21925, 0, 10, 1000012, 180000, -1141.33, 4213.39, 51.82);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21931, 0, 10, 1000012, 180000, -1332.26, 4061.72, 116.778);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21932, 0, 10, 1000012, 180000, -1324.8, 4040.57, 116.778);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21933, 0, 10, 1000012, 180000, -1167.66, 4214.58, 49.9546);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21934, 0, 10, 1000012, 180000, -1200.16, 4116.68, 61.3052);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21935, 0, 10, 1000012, 180000, -1108.96, 4175.83, 40.9417);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21936, 0, 10, 1000012, 180000, -1114.93, 4184.79, 17.7944);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21937, 0, 10, 1000012, 180000, -1102.93, 4210.66, 55.6402);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21938, 0, 10, 1000012, 180000, -1099.27, 4252.83, 16.6227);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21939, 0, 10, 1000012, 180000, -1076.14, 4176.77, 38.1325);
INSERT INTO `gameobject_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`) VALUES (21940, 0, 10, 1000012, 180000, -982.999, 4230.92, 42.0996);
 
-- Remove static spawns of Kaliri birds. They should not exist.
DELETE FROM `creature` WHERE `id` IN (17039,17034);

-- Update Natural Shapeshifter talents (rank 1-3) to include Tree of Life
UPDATE `spell_affect` SET `SpellFamilyMask`=527769339428864 WHERE `entry` IN (16833,16834,16835);

-- Lesser Spell Blasting (32106) (Spellstrike Set Effect) will now have a chance to trigger from channeled spells and DoT application
DELETE FROM `spell_proc_event` WHERE `entry` = 32106;
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`SpellFamilyMask`,`procFlags`,`procEx`,`ppmRate`,`CustomChance`,`Cooldown`) VALUES
(32106, 0, 0, 0, 0, 67108864, 0, 0, 0);

-- Feralfen Mystic
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18114;
INSERT INTO `creature_ai_scripts` VALUES
('1811401','18114','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Prevent Combat Movement on Spawn'),
('1811402','18114','1','0','100','1','1000','1000','600000','600000','11','12550','0','1','0','0','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Shield on Spawn'),
('1811403','18114','4','0','100','0','0','0','0','0','11','9532','1','0','23','1','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Bolt and Set Phase 1 on Aggro'),
('1811404','18114','9','13','100','1','0','40','3000','3800','11','9532','1','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Bolt (Phase 1)'),
('1811405','18114','3','13','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Feralfen Mystic - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1811406','18114','9','13','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Start Combat Movement at 35 Yards (Phase 1)'),
('1811407','18114','9','13','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1811408','18114','9','13','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Start Combat Movement Below 5 Yards'),
('1811409','18114','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1811410','18114','27','0','100','1','12550','1','15000','30000','11','12550','0','1','0','0','0','0','0','0','0','0','Feralfen Mystic - Cast Lightning Shield on Missing Buff'),
('1811411','18114','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Set Phase 3 at 15% HP'),
('1811412','18114','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Feralfen Mystic - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1811413','18114','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Feralfen Mystic - Set Phase to 0 on Evade');

-- Ango'rosh Shaman 18118
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18118;
INSERT INTO `creature_ai_scripts` VALUES
('1811801','18118','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Prevent Combat Movement on Spawn'),
('1811802','18118','4','0','100','0','0','0','0','0','11','9532','1','0','23','1','0','0','0','0','0','0','Ango\'rosh Shaman - Cast Lightning Bolt and Set Phase 1 on Aggro'),
('1811803','18118','9','5','100','1','0','40','3000','3800','11','9532','1','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Cast Lightning Bolt (Phase 1)'),
('1811804','18118','3','5','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Ango\'rosh Shaman - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1811805','18118','9','5','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Start Combat Movement at 35 Yards (Phase 1)'),
('1811806','18118','9','5','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1811807','18118','9','5','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Start Combat Movement Below 5 Yards'),
('1811808','18118','3','3','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1811809','18118','9','0','50','1','0','5','18000','25000','11','32062','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Summon Fire Nova Totem'),
('1811810','18118','2','0','100','1','0','50','10000','15000','11','23381','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Cast Healing Touch at 50% HP'),
('1811811','18118','2','0','100','1','0','30','30000','60000','11','6742','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Cast Bloodlust at 30% HP'),
('1811812','18118','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Ango\'rosh Shaman - Set Phase to 0 on Evade');

-- Daggerfen Muckdweller 18115
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18115;
INSERT INTO `creature_ai_scripts` VALUES
('1811501','18115','9','0','100','1','0','5','10000','10000','11','35201','1','32','0','0','0','0','0','0','0','0','Daggerfen Muckdweller - Cast Paralytic Poison');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = -35201;
INSERT INTO `spell_linked_spell` VALUES
('-35201','35202','0','Paralytic Poison - Paralysis');

-- Ancestral Spirit Wolf 17077
UPDATE creature_template SET unit_flags=unit_flags|2 WHERE entry = 17077;

DELETE FROM `creature` WHERE `guid` IN (52278,76114);
INSERT INTO `creature` VALUES (52278, 16873, 530, 1, 0, 0, -1121.16, 2127.72, 66.9479, 2.39271, 300, 0, 0, 3984, 2434, 0, 2);
INSERT INTO `creature` VALUES (76114, 21801, 530, 1, 0, 0, -5140.63, 537.607, 225.587, 3.9687, 300, 0, 0, 104790, 0, 0, 2);

UPDATE `creature_ai_texts` SET `content_default` = 'has spotted you!', `content_loc3` = 'hat euch gesichtet!' WHERE `entry` = '-48';

UPDATE `creature_template` SET `minhealth`='305',`maxhealth`='305',`MovementType`='0' WHERE `entry` = 19440;
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1944001','1944003');
INSERT INTO `creature_ai_scripts` VALUES
(1944001,19440,0,0,100,1,6000,6000,0,0,41,0,0,0,39,30,0,0,0,0,0,0,'Eye of Grillok - Despawn after 6 seconds and pull Mobs in 30yards Range'),
(1944003,19440,9,0,100,1,0,5,0,0,39,30,0,0,0,0,0,0,0,0,0,0,'Eye of Grillok - Add Mobs in 30yards Range when in Melee Range');

UPDATE `creature` SET `MovementType`='2',`curhealth`='305' WHERE `guid` IN (69630,69631,69632,69633);
UPDATE `creature` SET `position_x`='-1163.9326',`position_y`='1989.3409',`position_z`='73.4113',`orientation`='1' WHERE `guid` = 69630;
UPDATE `creature` SET `position_x`='-1129.3885',`position_y`='2111.0297',`position_z`='67.3838',`orientation`='2' WHERE `guid` = 69631;
UPDATE `creature` SET `position_x`='-1015.0742',`position_y`='2071.7985',`position_z`='68.1599',`orientation`='3' WHERE `guid` = 69632; 
UPDATE `creature` SET `position_x`='-948.0367',`position_y`='1959.3719',`position_z`='66.9395',`orientation`='4' WHERE `guid` = 69633;

SET @GUID := 69633;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,01,-928.3358,1986.7524,66.7063,0,1,0,0,0),
(@GUID,02,-914.0970,1975.1490,66.9381,0,1,0,0,0),
(@GUID,03,-942.1527,2017.2342,66.4272,0,1,0,0,0), 
(@GUID,04,-910.6004,2030.3096,54.9803,0,1,0,0,0),
(@GUID,05,-881.2473,2062.9765,32.9544,0,1,0,0,0),
(@GUID,06,-910.6004,2030.3096,54.9803,0,1,0,0,0),
(@GUID,07,-942.1527,2017.2342,66.4272,0,1,0,0,0),
(@GUID,08,-965.8059,2015.7540,66.9382,0,1,0,0,0),
(@GUID,09,-967.2543,2043.5303,66.9383,0,1,0,0,0),
(@GUID,10,-965.8059,2015.7540,66.9382,0,1,0,0,0),
(@GUID,11,-994.0278,2018.3187,66.9398,0,1,0,0,0),
(@GUID,12,-1008.3182,1998.1336,66.9398,0,1,0,0,0),
(@GUID,13,-961.6397,1928.9605,69.7001,0,1,0,0,0);

SET @GUID := 69632;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,01,-995.2246,2050.7878,67.0786,0,1,0,0,0),
(@GUID,02,-965.1807,2015.1136,66.9396,0,1,0,0,0),
(@GUID,03,-1019.5062,2019.8485,68.5836,0,1,0,0,0),
(@GUID,04,-1049.9830,1978.5461,69.7531,0,1,0,0,0),
(@GUID,05,-1083.0324,1999.5413,67.5355,0,1,0,0,0),
(@GUID,06,-1051.1049,2035.9420,67.8373,0,1,0,0,0),
(@GUID,07,-1015.0700,2071.8000,68.1598,0,1,0,0,0);

SET @GUID := 69631;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,01,-1080.3474,2078.0305,65.0987,0,1,0,0,0), 
(@GUID,02,-1058.6500,2095.5725,60.5359,0,1,0,0,0), 
(@GUID,03,-1057.7172,2135.4677,45.9153,0,1,0,0,0),
(@GUID,04,-1051.2012,2158.9655,32.0612,0,1,0,0,0),
(@GUID,05,-1057.7172,2135.4677,45.9153,0,1,0,0,0),
(@GUID,06,-1058.6500,2095.5725,60.5359,0,1,0,0,0),
(@GUID,07,-1080.3474,2078.0305,65.0987,0,1,0,0,0),
(@GUID,08,-1119.9788,2001.8972,68.2734,0,1,0,0,0),
(@GUID,09,-1176.4782,2077.5385,70.3548,0,1,0,0,0),
(@GUID,10,-1169.5651,2108.4208,69.0777,0,1,0,0,0),
(@GUID,11,-1134.4404,2108.9665,67.2592,0,1,0,0,0);

SET @GUID := 69630;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,01,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@GUID,02,-1113.0444,2012.2253,67.1017,0,1,0,0,0),
(@GUID,03,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@GUID,04,-1145.7219,1953.0606,81.1721,0,1,0,0,0),
(@GUID,05,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@GUID,06,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@GUID,07,-1114.2845,1946.6412,74.0025,0,1,0,0,0),
(@GUID,08,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@GUID,09,-1113.0444,2012.2253,67.1017,0,1,0,0,0),
(@GUID,10,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@GUID,11,-1145.7219,1953.0606,81.1721,0,1,0,0,0),
(@GUID,12,-1135.7148,1970.8599,73.5443,0,1,0,0,0),
(@GUID,13,-1128.5218,1986.3791,71.8458,0,1,0,0,0),
(@GUID,14,-1179.1141,1990.8114,74.5931,0,1,0,0,0);



DELETE FROM `creature` WHERE `guid` IN (52275,52276,69470,69471,69472,69473,69474,69475,69476,69477,69478,69479,69480,69481);
INSERT INTO `creature` VALUES (52275, 19424, 530, 1, 0, 0, -973.445, 2189.36, 14.3768, 2.63555, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 52275;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52275, 1, -1013.41, 2217.75, 12.9209, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 2, -1040.43, 2236.6, 18.5546, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 3, -1060.23, 2247.38, 23.7136, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 4, -1035.09, 2227.63, 16.6393, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 5, -1005.26, 2211.83, 12.2921, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 6, -975.232, 2194.48, 12.6268, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 7, -945.358, 2173.37, 13.7803, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 8, -916.314, 2146.21, 14.8403, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 9, -915.11, 2129.17, 18.5694, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 10, -907.158, 2112.14, 20.9662, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 11, -889.008, 2091.63, 24.9967, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 12, -858.048, 2079.4, 25.4812, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 13, -837.462, 2068.34, 26.6337, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 14, -830.567, 2056.49, 33.0622, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 15, -832.802, 2048.74, 36.335, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 16, -838.373, 2041.57, 39.1844, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 17, -832.796, 2050.07, 35.9626, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 18, -830.296, 2066.4, 28.0419, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 19, -850.962, 2078.84, 24.7177, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 20, -880.735, 2091.12, 24.5305, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 21, -907.615, 2112.54, 20.887, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 22, -915.517, 2134.03, 17.5009, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 23, -927.071, 2153.99, 14.2757, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52275, 24, -973.109, 2187.75, 14.7322, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (52276, 19424, 530, 1, 0, 0, -814.005, 2049.01, 39.4324, 5.49986, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 52276;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52276, 1, -803.659, 2038.57, 40.127, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 2, -800.316, 2021.94, 38.6401, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 3, -805.395, 2011.6, 38.7898, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 4, -821.872, 2000.35, 38.8469, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 5, -805.742, 2014.11, 38.8205, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 6, -801.654, 2026.38, 38.6509, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 7, -803.84, 2037.24, 39.8107, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 8, -810.391, 2044.47, 39.9908, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 9, -825.949, 2053.93, 34.7244, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 10, -830.524, 2063.44, 29.459, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 11, -834.389, 2094.6, 20.0797, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 12, -853.699, 2124.69, 16.8178, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 13, -853.695, 2139.64, 15.0528, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 14, -855.824, 2146.77, 14.1908, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 15, -859.695, 2159.09, 12.4201, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 16, -879.949, 2163.04, 11.4725, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 17, -902.055, 2165.72, 12.0532, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 18, -863.174, 2164.13, 11.679, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 19, -855.069, 2157.64, 12.7463, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 20, -853.283, 2150.45, 13.7853, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 21, -854.602, 2137.94, 15.2158, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 22, -845.739, 2101.05, 19.5115, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 23, -835.625, 2074.89, 24.6744, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 24, -830.97, 2061, 30.6882, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 25, -825.224, 2052.07, 35.4368, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52276, 26, -813.257, 2046.64, 39.4646, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (69470, 19424, 530, 1, 0, 0, -1183.66, 1999.52, 74.1797, 0.851996, 300, 5, 0, 4126, 2434, 0, 1);
INSERT INTO `creature` VALUES (69471, 19424, 530, 1, 0, 0, -1138.52, 1901.65, 81.3538, 1.28713, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69471;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69471, 1, -1136.55, 1911.1, 81.3933, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 2, -1138.6, 1919.57, 81.3483, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 3, -1142.19, 1929.69, 81.4068, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 4, -1146.76, 1936.75, 81.4037, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 5, -1152.56, 1940.86, 81.4037, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 6, -1159.56, 1944.3, 81.4038, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 7, -1152.95, 1941.38, 81.4038, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 8, -1145.44, 1936, 81.4038, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 9, -1140.77, 1926.64, 81.394, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 10, -1136.01, 1914.57, 81.3919, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 11, -1136.21, 1907.56, 81.3927, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 12, -1139.47, 1900.2, 81.3547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 13, -1145.08, 1892.43, 81.3547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69471, 14, -1138.81, 1901.58, 81.3545, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (69472, 19424, 530, 1, 0, 0, -1085.62, 1986.82, 68.8359, 1.36594, 300, 5, 0, 4126, 2434, 0, 1);
INSERT INTO `creature` VALUES (69473, 19424, 530, 1, 0, 0, -1099, 1953.35, 76.1699, 3.60316, 300, 5, 0, 4126, 2434, 0, 1);
INSERT INTO `creature` VALUES (69474, 19424, 530, 1, 0, 0, -1141.45, 2039.27, 67.0646, 3.25189, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69474;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69474, 1, -1147.61, 2031.19, 67.0769, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 2, -1120.61, 2037.99, 67.2565, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 3, -1090.18, 2035.56, 66.9398, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 4, -1052.27, 2024.45, 67.4647, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 5, -1020.43, 2009.68, 68.1736, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 6, -992.912, 1992.14, 67.2648, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 7, -981.575, 1969.58, 69.2717, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 8, -977.501, 1944.57, 70.0693, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 9, -967.47, 1920.13, 73.4568, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 10, -954.652, 1905.34, 74.3197, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 11, -928.707, 1898.19, 73.6704, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 12, -906.439, 1891.94, 72.9486, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 13, -930.511, 1893.97, 76.0185, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 14, -958.805, 1909.76, 73.8872, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 15, -971.234, 1930.2, 71.7382, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 16, -977.706, 1959.37, 69.2708, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 17, -984.426, 1976.97, 68.9392, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 18, -994.644, 1993.02, 67.1263, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 19, -1012.83, 2005.94, 67.551, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 20, -1036.17, 2017.68, 67.785, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 21, -1061.34, 2027.19, 67.3781, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 22, -1088.52, 2037.82, 66.995, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 23, -1109.66, 2038.27, 67.0858, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69474, 24, -1138.71, 2032.47, 66.9532, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (69475, 19424, 530, 1, 0, 0, -1194.21, 2068.98, 78.3852, 6.17069, 300, 5, 0, 4126, 2434, 0, 1);
INSERT INTO `creature` VALUES (69476, 19424, 530, 1, 0, 0, -1058.4500, 2121.2255, 52.3891, 4.51174, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69476;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69476, 1, -1058.48, 2110.31, 56.2759, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 2, -1081.06, 2076.1, 65.4043, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 3, -1101.37, 2046.57, 67.0615, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 4, -1143.82, 2032.49, 66.9939, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 5, -1093.84, 2049.28, 66.9407, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 6, -1063.5, 2094.12, 61.0532, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 7, -1058.12, 2110.9, 56.0566, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 8, -1058.31, 2138.64, 44.4715, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 9, -1051.71, 2161.29, 31.1843, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 10, -1048.01, 2191.85, 20.0944, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 11, -1059.13, 2233.37, 21.4197, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 12, -1069.6, 2246.99, 24.8229, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 13, -1078.69, 2293.49, 23.9027, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 14, -1078.31, 2307.39, 20.2485, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 15, -1066.72, 2352.72, 17.5898, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 16, -1065.18, 2424, 20.9677, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 17, -1060.46, 2434.23, 17.2582, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 18, -1041.13, 2473.6, 14.5424, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 19, -1040.73, 2485.63, 14.3359, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 20, -1042.73, 2496.65, 14.3896, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 21, -1054.55, 2499.75, 15.7857, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 22, -1100.89, 2458.92, 26.1907, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 23, -1110.51, 2454.88, 32.0613, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 24, -1140.43, 2443.59, 34.6146, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 25, -1147.62, 2449.07, 36.4209, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 26, -1154, 2450.9, 37.5179, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 27, -1163.46, 2447.87, 38.2704, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 28, -1172.66, 2424.06, 36.7747, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 29, -1163.81, 2373.84, 34.8389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 30, -1152.62, 2323.53, 34.0788, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 31, -1163.02, 2286.8, 38.2756, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 32, -1172.98, 2258.85, 42.2957, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 33, -1165.16, 2252.31, 40.7515, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 34, -1127.53, 2233.24, 33.9389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 35, -1089.72, 2209.04, 27.9299, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 36, -1064.83, 2188.07, 24.8297, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 37, -1056.31, 2171.22, 28.5906, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 38, -1056.49, 2152.67, 36.8095, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 39, -1059.82, 2128.16, 49.9128, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 40, -1057.95, 2114.07, 54.9561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 41, -1038.6, 2098.86, 61.7002, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 42, -1021.65, 2077.17, 67.6632, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 43, -1005.56, 2059, 67.6238, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 44, -993.818, 2049.77, 67.0679, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 45, -977.046, 2053.23, 67.1282, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 46, -990.863, 2051.38, 66.9627, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 47, -1001.22, 2054.03, 67.3418, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 48, -1027.76, 2084.81, 66.5972, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 49, -1048.65, 2100.71, 59.4541, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 50, -1058.03, 2118.41, 53.3923, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 51, -1057.63, 2134.94, 46.1521, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 52, -1052.23, 2157.42, 33.0717, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 53, -1058.29, 2187.54, 23.2086, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 54, -1089.96, 2215.21, 27.4763, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 55, -1131.33, 2239.02, 34.1127, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 56, -1167.89, 2255.42, 41.2232, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 57, -1170.77, 2261.93, 41.5853, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 58, -1159.76, 2298.09, 37.0421, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 59, -1152.92, 2322.89, 34.1771, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 60, -1160.12, 2362.33, 34.6708, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 61, -1169.18, 2403.97, 34.8349, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 62, -1172.06, 2421.57, 36.4417, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 63, -1164.66, 2445.32, 38.0613, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 64, -1156.84, 2450.75, 37.8551, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 65, -1148.68, 2449.54, 36.6316, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 66, -1109.32, 2453.86, 31.5157, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 67, -1100.81, 2458.22, 26.1981, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 68, -1065.01, 2480.49, 17.3976, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 69, -1060.02, 2495.68, 16.5451, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 70, -1055.15, 2500.55, 15.8407, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 71, -1043.53, 2500.47, 14.382, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 72, -1036.97, 2489.74, 13.8377, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 73, -1044.34, 2467.02, 15.0249, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 74, -1069.49, 2424.92, 21.7427, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 75, -1077.86, 2391.89, 20.1119, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 76, -1088.58, 2355.92, 20.9075, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 77, -1082.22, 2304.55, 21.3683, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 78, -1073.81, 2255.95, 24.9067, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 79, -1058.61, 2241.98, 22.6206, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 80, -1047.78, 2218.08, 18.7745, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 81, -1047.1, 2193.01, 19.7522, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69476, 82, -1054.41, 2155.18, 34.7918, 0, 0, 0, 0, 0);
INSERT INTO `creature` VALUES (69477, 19424, 530, 1, 0, 0, -885.924, 2057.69, 35.7585, 4.6984, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69477;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69477, 1, -904.345, 2037.7, 50.0011, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 2, -921.762, 2023.69, 60.6625, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 3, -942.932, 2017.42, 66.4969, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 4, -992.397, 2016.43, 66.9397, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 5, -1014.87, 2009.07, 68.0249, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 6, -1043.66, 2015.96, 66.9404, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 7, -1061.38, 2022.08, 67.5387, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 8, -1073.01, 2013.13, 67.7404, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 9, -1079.18, 1996.46, 67.6509, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 10, -1073.52, 1990.7, 68.1946, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 11, -1077.55, 1998.84, 67.4702, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 12, -1065.62, 2020.73, 67.8377, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 13, -1022.29, 2009, 68.0734, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 14, -990.646, 2016.07, 66.9397, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 15, -961.459, 2015.48, 66.9403, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 16, -937.869, 2018.02, 65.6837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 17, -919.763, 2025.5, 59.6063, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 18, -897.143, 2044.97, 44.4054, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 19, -891.366, 2083.89, 27.5076, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 20, -909.706, 2117.24, 19.9877, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 21, -918.437, 2153.87, 13.9904, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 22, -944.434, 2188.61, 11.5538, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 23, -964.757, 2221.72, 8.78206, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 24, -972.937, 2257.99, 7.31084, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 25, -984.266, 2278.31, 6.90569, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 26, -1008.07, 2299.09, 8.01525, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 27, -1039.37, 2313.25, 12.5841, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 28, -1059.26, 2313.98, 16.0154, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 29, -1082.56, 2305.67, 21.2855, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 30, -1084.34, 2288.42, 24.452, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 31, -1072.93, 2254.04, 24.9175, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 32, -1060.32, 2226.27, 21.0269, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 33, -1047.18, 2193.45, 19.6968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 34, -1047.11, 2171.28, 25.9937, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 35, -1050.91, 2152.06, 35.1947, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 36, -1057.24, 2126.9, 49.8555, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 37, -1057.66, 2102.66, 58.5786, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 38, -1048.12, 2084.57, 63.4963, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 39, -1031.33, 2063.44, 66.9858, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 40, -1031.04, 2054.96, 67.1859, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 41, -1041.2, 2037.5, 67.4372, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 42, -1060.5, 2025.25, 67.5755, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 43, -1069.05, 2018.63, 67.9542, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 44, -1078.18, 2003.77, 67.4211, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 45, -1077.92, 1995.62, 67.6535, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 46, -1073.19, 1988.72, 68.6417, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 47, -1078.79, 2000.4, 67.4528, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 48, -1073.83, 2013.67, 67.7826, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 49, -1061.15, 2026.68, 67.391, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 50, -1034.21, 2048.76, 67.6882, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 51, -1029.94, 2058.48, 67.0839, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 52, -1039.38, 2074.17, 65.8501, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 53, -1056.85, 2100.05, 59.322, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 54, -1058.19, 2123.58, 51.411, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 55, -1057.17, 2137.24, 44.8638, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 56, -1049.46, 2165.44, 28.7961, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 57, -1048, 2191.89, 20.0854, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 58, -1061.09, 2227.67, 21.2033, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 59, -1074.12, 2254.48, 24.9517, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 60, -1081.23, 2293.88, 23.7313, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 61, -1075.47, 2305.82, 19.9612, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 62, -1055.17, 2314.3, 15.2611, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 63, -1036.08, 2311.77, 11.9965, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 64, -996.499, 2288.92, 7.30002, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 65, -980.992, 2274.71, 6.87161, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 66, -972.792, 2243.95, 7.75112, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 67, -965.806, 2216.41, 9.4594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 68, -942.965, 2183.29, 12.315, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 69, -921.471, 2147.82, 14.78, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 70, -915.585, 2129.17, 18.6193, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 71, -900.483, 2108.07, 21.7013, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 72, -887.399, 2085.98, 26.5456, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69477, 73, -885.721, 2058.69, 35.3881, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (69478, 19424, 530, 1, 0, 0, -868.391, 2063.93, 30.6293, 4.37173, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69478;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69478, 1, -891.3, 2047, 41.318, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 2, -915.06, 2021.05, 59.5722, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 3, -923.794, 2000.87, 65.5555, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 4, -953.165, 1964.59, 67.1231, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 5, -968.617, 1944.97, 68.6796, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 6, -972.183, 1917.94, 75.8879, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 7, -973.519, 1898.6, 86.3297, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 8, -974.751, 1887.8, 93.5686, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 9, -976.054, 1881.63, 94.7104, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 10, -973.89, 1887.12, 93.7215, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 11, -970.094, 1911.99, 77.6017, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 12, -966.989, 1930.91, 70.592, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 13, -958.151, 1954.61, 67.7862, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 14, -930.347, 1988.29, 66.662, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 15, -918.003, 2019.06, 60.9238, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 16, -905.889, 2036.41, 51.0628, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 17, -887.846, 2067.11, 32.9724, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 18, -873.888, 2089, 24.5729, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 19, -865.937, 2112.85, 18.4893, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 20, -858.244, 2123.8, 17.0288, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 21, -851.814, 2127.91, 16.407, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 22, -824.98, 2121.34, 16.3133, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 23, -803.833, 2112.59, 18.1399, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 24, -786.096, 2076.21, 24.7511, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 25, -774.526, 2044.08, 30.6097, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 26, -784.345, 2023.14, 35.6131, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 27, -804.479, 1990.08, 39.1371, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 28, -816.851, 1953.7, 46.3828, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 29, -826.892, 1924.05, 53.5988, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 30, -855.075, 1897.47, 63.8065, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 31, -885.907, 1889.72, 70.8439, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 32, -910.181, 1889.45, 74.7864, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 33, -938.718, 1887.96, 80.4209, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 34, -958.809, 1884.41, 87.9354, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 35, -965.227, 1878.34, 93.8642, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 36, -970.386, 1875.87, 94.7288, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 37, -975.504, 1877.55, 94.7959, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 38, -967.402, 1876.07, 94.577, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 39, -949.63, 1882.82, 85.3628, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 40, -923.467, 1882.9, 80.7002, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 41, -895.809, 1883.22, 74.8814, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 42, -866.646, 1892.18, 67.099, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 43, -843.826, 1904.53, 60.2443, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 44, -827.11, 1926.55, 53.079, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 45, -817.485, 1952.7, 46.7373, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 46, -810.256, 1980.17, 39.7263, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 47, -790.293, 2008.97, 37.8926, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 48, -776.461, 2027.08, 33.7303, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 49, -771.934, 2044.34, 30.536, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 50, -774.704, 2062.9, 27.399, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 51, -787.148, 2079.02, 24.268, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 52, -808.947, 2106.31, 18.5389, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 53, -829.713, 2121.04, 16.2941, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 54, -846.323, 2127.13, 16.3565, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 55, -858.307, 2124.52, 16.9656, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 56, -866.565, 2111.99, 18.6373, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 57, -871.745, 2091.87, 23.6123, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69478, 58, -876.654, 2067.97, 30.6379, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (69479, 19424, 530, 1, 0, 0, -929.326, 2171.63, 12.6575, 5.50607, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69479;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69479, 1, -904.801, 2140.01, 15.8217, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 2, -929.749, 2171.64, 12.4077, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 3, -961.989, 2199.57, 11.032, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 4, -1005.12, 2215.76, 11.9567, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 5, -1042.34, 2231.55, 18.359, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 6, -1065.28, 2248.22, 24.4744, 2000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 7, -1027.78, 2232.73, 15.3397, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 8, -987.288, 2216.83, 10.2402, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 9, -961.169, 2204.21, 10.4281, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 10, -939.016, 2189.58, 11.0464, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69479, 11, -929.09, 2172.02, 12.3689, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (69480, 19424, 530, 1, 0, 0, -959.787, 2209.46, 9.9771, 5.75947, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69480;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69480, 1, -921.141, 2193.05, 10.9223, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 2, -888.225, 2173.71, 10.581, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 3, -854.812, 2157.65, 12.7529, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 4, -844.064, 2150.66, 13.6534, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 5, -838.367, 2142.14, 14.6384, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 6, -840.753, 2133.03, 15.6541, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 7, -853.728, 2114.88, 17.7807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 8, -872.8, 2099.86, 21.5829, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 9, -893.45, 2099.2, 23.4114, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 10, -909.542, 2111.94, 21.12, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 11, -915.429, 2126.3, 19.1125, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 12, -919.827, 2156.63, 13.7418, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 13, -927.429, 2188.79, 11.0204, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 14, -937.975, 2218.42, 8.56733, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 15, -944.478, 2227.11, 7.82746, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 16, -952.326, 2227.37, 8.01609, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 17, -959.75, 2221.96, 8.69023, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69480, 18, -959.719, 2209.89, 9.94857, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (69481, 19424, 530, 1, 0, 0, -1067.51, 2249.84, 24.9013, 2.53951, 300, 0, 0, 4126, 2434, 0, 2);
SET @GUID := 69481;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,9562,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69481, 1, -1085.73, 2268.46, 24.8463, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 2, -1118.02, 2267.34, 28.6684, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 3, -1165.47, 2260.73, 40.3271, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 4, -1174.3, 2250.32, 43.0665, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 5, -1181.83, 2211.35, 49.9694, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 6, -1174.31, 2158.3, 62.5115, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 7, -1177.18, 2220.93, 47.0419, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 8, -1169.44, 2257.33, 41.4966, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 9, -1127.52, 2271.72, 30.7831, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 10, -1091.15, 2274.09, 24.8648, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 11, -1081.08, 2266.18, 24.85, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 12, -1072.32, 2252.04, 24.892, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69481, 13, -1057.03, 2245.8, 23.0258, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (52279,52281,52282,52283,52284,52285,52286,52287,52288,52289,52291,52292,52293,52294,52295,52296,52297,52298,52299,52301,52302,52303,52304,52305,52306,52307,52308,52309,52310,52311,52313,52314,52315,52316,52317,52318,52319,52320,52321,52322,52325,52327,52328,52329,52330,52331,52332,52333,52334,52335,52336,52337,52338,52339,52340,52341,52342,52343,52344,52345,52346,52347);

INSERT INTO `creature` VALUES (52279, 18065, 530, 1, 0, 0, -384.99, 8786.67, 212.753, 2.12956, 300, 0, 0, 6116, 0, 0, 2);
SET @GUID := 52279;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52279, 1, -398.269, 8804.46, 217.325, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 2, -412.053, 8812.45, 220.161, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 3, -430.507, 8819.81, 221.395, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 4, -441.296, 8830.23, 221.626, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 5, -445.609, 8850.52, 223.452, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 6, -445.632, 8867.33, 224.72, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 7, -453.055, 8881.74, 224.406, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 8, -470.271, 8889.71, 225.414, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 9, -515.143, 8892.06, 228.826, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 10, -534.872, 8886.37, 230.565, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 11, -546.735, 8870.39, 229.176, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 12, -540.254, 8856.33, 229.642, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 13, -529.629, 8849.6, 232.416, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 14, -506.749, 8845.22, 236.625, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 15, -485.893, 8848.37, 239.283, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 16, -508.798, 8844.63, 236.39, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 17, -529.363, 8848.72, 232.67, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 18, -540.861, 8857.2, 229.432, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 19, -547.196, 8871.09, 229.261, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 20, -542.196, 8882.48, 230.796, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 21, -530.482, 8889.93, 230.493, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 22, -511.938, 8894.58, 228.543, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 23, -470.208, 8890.2, 225.434, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 24, -451.641, 8880.46, 224.297, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 25, -445.421, 8866.58, 224.696, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 26, -445.974, 8843.71, 222.71, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 27, -440.18, 8829.58, 221.609, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 28, -431.559, 8820.13, 221.376, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 29, -406.215, 8810.67, 219.203, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 30, -390.925, 8796.25, 214.569, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 31, -377.17, 8778.05, 211.155, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 32, -373.347, 8757.8, 208.023, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 33, -382.987, 8744.06, 202.201, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 34, -405.184, 8718.64, 193.11, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 35, -419.225, 8713.4, 189.002, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 36, -441.585, 8714.71, 184.544, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 37, -451.864, 8719.73, 183.338, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 38, -455.238, 8731.33, 182.193, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 39, -452.53, 8740.64, 182.894, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 40, -449.194, 8754.34, 183.497, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 41, -450.988, 8793.51, 196.171, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 42, -449.783, 8773.5, 189.535, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 43, -447.893, 8752.71, 183.107, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 44, -455.492, 8736.31, 182.568, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 45, -450.041, 8721.45, 183.049, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 46, -438.284, 8714.93, 184.711, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 47, -412.573, 8715.54, 190.76, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 48, -373.826, 8754.15, 207.196, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 49, -374.3, 8774.6, 210.924, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52279, 50, -388.62, 8792.9, 213.872, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52281, 21059, 530, 1, 0, 0, -3022.99, 1608.08, 58.58, 3.22, 300, 0, 0, 5756, 2991, 0, 2);
SET @GUID := 52281;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52281, 1, -3041.08, 1601.79, 58.3442, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52281, 2, -3027.22, 1607.53, 58.47, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52281, 3, -3016.77, 1607.05, 58.5488, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52281, 4, -3012.05, 1599.96, 58.5315, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52281, 5, -3010.04, 1589.44, 58.5068, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52281, 6, -3014.07, 1606.39, 58.5483, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52281, 7, -3022.23, 1607.59, 58.5819, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52282, 20872, 530, 1, 0, 0, -3646.64, 2071.34, 9.78811, 0.684723, 300, 0, 0, 4710, 2991, 0, 2);
SET @GUID := 52282;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52282, 1, -3641.72, 2075.41, 10.4084, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52282, 2, -3635.02, 2076.15, 11.3416, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52282, 3, -3641.66, 2074.37, 10.2916, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52282, 4, -3657.89, 2061.97, 10.1908, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52282, 5, -3669.64, 2056.74, 10.5026, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52282, 6, -3646.59, 2070.74, 9.78782, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52283, 20887, 530, 1, 0, 0, -3648.69, 2071.51, 9.85834, 0.437324, 120, 5, 0, 1518, 2933, 0, 1);
INSERT INTO `creature` VALUES (52284, 19362, 530, 1, 0, 0, -2683.86, 2696.61, 100.084, 0.619396, 300, 0, 0, 14000, 0, 0, 2);
SET @GUID := 52284;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52284, 1, -2680.01, 2701.34, 102.078, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 2, -2680.11, 2707.2, 103.366, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 3, -2682.18, 2711.39, 104.304, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 4, -2711.63, 2727.95, 116.601, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 5, -2702.82, 2722.75, 112.557, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 6, -2683.84, 2714.1, 104.962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 7, -2679.14, 2708.38, 103.578, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 8, -2679.53, 2702.55, 102.36, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 9, -2681.98, 2698.7, 101.198, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 10, -2688.5, 2694.53, 97.4611, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52284, 11, -2686.11, 2696.18, 99.1396, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52285, 21310, 530, 1, 0, 0, -3788.56, 2597.47, 92.709, 3.87463, 300, 0, 0, 9250, 0, 0, 2);
SET @GUID := 52285;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52285, 1, -3788.56, 2597.47, 92.709, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52285, 2, -3788.56, 2597.47, 92.709, 300000, 0, 0, 0, 0); -- 2131001

INSERT INTO `creature` VALUES (52286, 21310, 530, 1, 0, 0, -3802.71, 2594.56, 92.709, 0.191986, 300, 0, 0, 9250, 0, 0, 2);
SET @GUID := 52286;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52286, 1, -3802.71, 2594.56, 92.709, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52286, 2, -3802.71, 2594.56, 92.709, 300000, 0, 0, 0, 0); -- 2131001

INSERT INTO `creature` VALUES (52287, 22253, 530, 1, 0, 0, -5017.33, 268.827, 88.0933, 3.79018, 25, 0, 0, 110700, 0, 0, 2);
SET @GUID := 52287;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52287, 1, -5035.62, 238.973, 100.022, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 2, -5056.45, 189.602, 119.037, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 3, -5069.33, 170.666, 128.5, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 4, -5090.68, 155.49, 129.719, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 5, -5100.71, 153.752, 129.76, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 6, -5105.75, 163.456, 129.76, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 7, -5104.55, 176.361, 130.19, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 8, -5107.65, 199.59, 136.026, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 9, -5100.54, 235.21, 145.359, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 10, -5095.83, 275.448, 155.658, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 11, -5093.69, 305.897, 163.504, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 12, -5088.88, 311.633, 165.474, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 13, -5083.66, 307.726, 165.131, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 14, -5092.82, 275.552, 156.112, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 15, -5103.53, 236.391, 145.245, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 16, -5108.45, 187.182, 132.882, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 17, -5097.7, 171.263, 129.81, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 18, -5084.6, 164.902, 129.265, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 19, -5066.66, 171.763, 127.822, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 20, -5056.02, 185.991, 119.918, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 21, -5042.77, 221.464, 106.548, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 22, -5022.04, 264.2, 90.1586, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 23, -5013.07, 279.828, 84.1723, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 24, -4985.21, 301.837, 81.3615, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 25, -4965.48, 363.072, 83.4894, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 26, -4934.09, 384.81, 83.2715, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 27, -4918.1, 389.84, 69.7027, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 28, -4909.63, 394.312, 68.1948, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 29, -4893.19, 406.209, 64.1292, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 30, -4886.88, 414.297, 66.1913, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 31, -4868.07, 437.713, 63.6985, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 32, -4866.39, 442.678, 60.6982, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 33, -4864.23, 451.362, 63.333, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 34, -4868.04, 484.173, 64.9821, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 35, -4890.5, 513.275, 62.9483, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 36, -4907.87, 520.664, 62.3634, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 37, -4915.03, 526.036, 55.9176, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 38, -4922.98, 532.515, 58.7792, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 39, -4931.07, 533.199, 62.7698, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 40, -4946.57, 534.135, 66.2364, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 41, -4954.49, 537.257, 68.1512, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 42, -4963.46, 540.731, 68.0801, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 43, -4972.6, 537.99, 71.1986, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 44, -4988.84, 531.568, 79.9752, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 45, -5004.82, 522.7, 86.7006, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 46, -5016.98, 501.582, 87.5746, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 47, -5017.08, 486.986, 86.7599, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 48, -5015.12, 470.392, 87.7964, 7000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 49, -4987.51, 441.991, 87.3768, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 50, -4966.16, 399.949, 85.7143, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 51, -4967.79, 373.053, 84.0841, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 52, -4976.34, 326.112, 83.2585, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 53, -4985.73, 297.476, 81.2298, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52287, 54, -5008.94, 280.523, 83.8395, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52288, 21310, 530, 1, 0, 0, -3794.09, 2588.92, 92.709, 5.16617, 300, 0, 0, 9250, 0, 0, 2);
SET @GUID := 52288;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52288, 1, -3794.09, 2588.92, 92.709, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52288, 2, -3794.09, 2588.92, 92.709, 300000, 0, 0, 0, 0); -- 2131001

INSERT INTO `creature` VALUES (52289, 19800, 530, 1, 0, 0, -3828.58, 2559.87, 90.364, 1.50323, 300, 0, 0, 3925, 2991, 0, 2);
SET @GUID := 52289;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52289, 1, -3810.13, 2576.41, 91.2506, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52289, 2, -3802.88, 2578.49, 90.7495, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52289, 3, -3798.8, 2588.27, 90.1271, 15000, 0, 0, 0, 0); -- 1980001
INSERT INTO `waypoint_data` VALUES (52289, 4, -3803.84, 2578.34, 90.8452, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52289, 5, -3820.61, 2568.89, 90.6726, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52289, 6, -3829.79, 2560.67, 90.525, 10000, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52291, 19802, 530, 1, 0, 0, -3747.1, 2418.19, 79.5939, 0.544394, 300, 0, 0, 6542, 0, 0, 2);
SET @GUID := 52291;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52291, 1, -3710.13, 2441.1, 81.524, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 2, -3668.97, 2475.07, 77.5203, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 3, -3652.46, 2500.25, 77.3533, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 4, -3632.99, 2541.96, 76.9411, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 5, -3617.63, 2601.42, 75.6323, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 6, -3629.49, 2533.09, 76.2526, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 7, -3651.82, 2485.32, 78.2723, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 8, -3695.3, 2444.93, 81.6251, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52291, 9, -3742.78, 2415.87, 79.4894, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52292, 19799, 530, 1, 0, 0, -3784.54, 2460.28, 79.1358, 5.18144, 300, 0, 0, 5409, 3080, 0, 2);
SET @GUID := 52292;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52292, 1, -3742, 2392.87, 78.1075, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 2, -3782.91, 2456.82, 79.1186, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 3, -3787.92, 2479.88, 79.2852, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 4, -3791.45, 2533.11, 82.1782, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 5, -3792.61, 2557.61, 91.5, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 6, -3794.16, 2581.74, 90.2241, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 7, -3791.91, 2557.71, 91.5027, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 8, -3791.4, 2532.96, 82.1728, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52292, 9, -3784.44, 2460.35, 79.1422, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52293, 19800, 530, 1, 0, 0, -3786.45, 2465.6, 79.1452, 5.09189, 300, 5, 0, 3925, 2991, 0, 1);
INSERT INTO `creature` VALUES (52294, 21949, 530, 1, 0, 0, -2759.59, 2031.66, 116.029, 0.733, 25, 0, 0, 69860, 0, 0, 2);
SET @GUID := 52294;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52294, 1, -2759.59, 2031.66, 116.029, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52294, 2, -2759.59, 2031.66, 116.029, 200000, 0, 0, 0, 0); -- 2194901

INSERT INTO `creature` VALUES (52295, 21949, 530, 1, 0, 0, -2752.25, 2024.44, 116.194, 0.82, 25, 0, 0, 69860, 0, 0, 2);
SET @GUID := 52295;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52295, 1, -2752.25, 2024.44, 116.194, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52295, 2, -2752.25, 2024.44, 116.194, 200000, 0, 0, 0, 0); -- 2194901

INSERT INTO `creature` VALUES (52296, 21949, 530, 1, 0, 0, -2728.15, 2020.02, 116.196, 1.79769, 25, 0, 0, 69860, 0, 0, 2);
SET @GUID := 52296;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52296, 1, -2728.15, 2020.02, 116.196, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52296, 2, -2728.15, 2020.02, 116.196, 200000, 0, 0, 0, 0); -- 2194901

INSERT INTO `creature` VALUES (52297, 21949, 530, 1, 0, 0, -2654.26, 2667.9, 74.9156, 4.71239, 25, 0, 0, 69860, 0, 0, 2);
SET @GUID := 52297;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52297, 1, -2654.26, 2667.9, 74.9156, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52297, 2, -2654.26, 2667.9, 74.9156, 200000, 0, 0, 0, 0); -- 2194901

INSERT INTO `creature` VALUES (52298, 21949, 530, 1, 0, 0, -2644.06, 2666.83, 75.0076, 4.66003, 25, 0, 0, 69860, 0, 0, 2);
SET @GUID := 52298;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52298, 1, -2644.06, 2666.83, 75.0076, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52298, 2, -2644.06, 2666.83, 75.0076, 200000, 0, 0, 0, 0); -- 2194901

INSERT INTO `creature` VALUES (52299, 21949, 530, 1, 0, 0, -2634.42, 2668.06, 74.9564, 4.62512, 25, 0, 0, 69860, 0, 0, 2);
SET @GUID := 52299;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52299, 1, -2634.42, 2668.06, 74.9564, 1000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52299, 2, -2634.42, 2668.06, 74.9564, 200000, 0, 0, 0, 0); -- 2194901

INSERT INTO `creature` VALUES (52301, 21753, 530, 1, 0, 0, -2653.58, 2628.3, 74.9245, 4.66558, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52301;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52301, 1, -2651.02, 2516.86, 74.1991, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52301, 2, -2653.28, 2581.35, 74.733, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52301, 3, -2653.46, 2652.62, 74.3431, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52301, 4, -2653.12, 2623.68, 74.9237, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52302, 21753, 530, 1, 0, 0, -2622.38, 2574.29, 74.9249, 4.5311, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52302;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52302, 1, -2622.1, 2535.72, 74.6252, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52302, 2, -2622.23, 2655.03, 74.0254, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52302, 3, -2622.19, 2583.25, 74.7539, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52303, 21753, 530, 1, 0, 0, -2671.05, 2573.58, 74.7151, 1.59999, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52303;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52303, 1, -2670.83, 2652.94, 74.925, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52303, 2, -2670.19, 2529.75, 74.7506, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52303, 3, -2671.19, 2573.88, 74.7908, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52304, 21753, 530, 1, 0, 0, -2685.14, 2617.14, 74.1978, 4.69049, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52304;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52304, 1, -2683.8, 2542.88, 74.2033, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52304, 2, -2685.35, 2653.04, 74.2959, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52304, 3, -2685.17, 2617.09, 74.1972, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52305, 21753, 530, 1, 0, 0, -2636.36, 2542.87, 74.9248, 1.51547, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52305;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52305, 1, -2638.51, 2655.78, 74.3219, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52305, 2, -2635.96, 2517.61, 74.201, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52305, 3, -2636.86, 2543.8, 74.9239, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52306, 21753, 530, 1, 0, 0, -2745.5, 2470.75, 93.2805, 4.7351, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52306;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52306, 1, -2746.99, 2389.29, 92.1738, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52306, 2, -2745.34, 2498.41, 93.2809, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52306, 3, -2745.54, 2471.59, 93.2809, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52307, 21753, 530, 1, 0, 0, -2729.28, 2451.77, 93.2581, 4.74444, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52307;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52307, 1, -2729.33, 2427.23, 92.5373, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52307, 2, -2729.49, 2504.86, 93.2809, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52307, 3, -2729.18, 2441.58, 93.281, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52308, 21753, 530, 1, 0, 0, -2712.91, 2483.43, 93.2807, 4.94471, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52308;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52308, 1, -2712.03, 2452.52, 92.162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52308, 2, -2712.29, 2505.01, 92.5061, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52308, 3, -2712.15, 2486.92, 93.2807, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52309, 21753, 530, 1, 0, 0, -2762.91, 2408.55, 93.2806, 4.6896, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52309;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52309, 1, -2763.38, 2390.26, 93.2584, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52309, 2, -2762.98, 2483.25, 92.3028, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52309, 3, -2763.05, 2404.51, 93.2797, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52310, 21753, 530, 1, 0, 0, -2776.52, 2440.02, 92.5761, 1.44983, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52310;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52310, 1, -2775.69, 2478.66, 93.2716, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52310, 2, -2776.97, 2388.78, 93.2807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52310, 3, -2776.36, 2437.48, 92.7827, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52311, 21753, 530, 1, 0, 0, -2747.02, 2381.96, 92.1682, 4.77595, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52311;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52311, 1, -2748.83, 2290.84, 92.1931, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52311, 2, -2747.56, 2369.47, 93.0474, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 52312;
INSERT INTO `creature` VALUES (52312, 21753, 530, 1, 0, 0, -2763.02, 2362.8, 93.2809, 4.70526, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52312;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52312, 1, -2763.58, 2291.65, 93.2812, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52312, 2, -2762.69, 2385.76, 93.1871, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52312, 3, -2763.68, 2362.69, 93.2792, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52313, 21753, 530, 1, 0, 0, -2776.97, 2312.04, 92.1625, 1.52833, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52313;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52313, 1, -2777.61, 2385.93, 93.281, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52313, 2, -2776.82, 2294.01, 92.5392, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52313, 3, -2777.02, 2305.7, 93.2799, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52314, 21753, 530, 1, 0, 0, -2762.71, 2251.76, 93.2483, 4.65813, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52314;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52314, 1, -2763.72, 2212.13, 93.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52314, 2, -2763.35, 2292.74, 93.2809, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52314, 3, -2763.17, 2251.33, 93.2512, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52315, 21753, 530, 1, 0, 0, -2779.5, 2214.22, 93.2806, 1.58331, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52315;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52315, 1, -2777.12, 2290.77, 92.588, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52315, 2, -2779.85, 2212, 93.2804, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52316, 21753, 530, 1, 0, 0, -2795.98, 2260.29, 93.2815, 1.25815, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52316;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52316, 1, -2795.8, 2274.24, 92.2739, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52316, 2, -2797.11, 2194.79, 93.0831, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52316, 3, -2796.12, 2260.39, 93.2818, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52317, 21753, 530, 1, 0, 0, -2763.18, 2106.96, 117.225, 4.63576, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52317;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52317, 1, -2763.74, 2080.09, 116.126, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52317, 2, -2763.57, 2140.02, 116.703, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52317, 3, -2762.99, 2107.03, 117.226, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52318, 21753, 530, 1, 0, 0, -2746.86, 2091.63, 117.225, 1.58056, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52318;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52318, 1, -2746.63, 2141.74, 116.327, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52318, 2, -2746.03, 2038.37, 116.396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52318, 3, -2747.06, 2089, 117.224, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52319, 21753, 530, 1, 0, 0, -2729.78, 2139.39, 117.233, 1.61198, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52319;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52319, 1, -2730.33, 2034.36, 117.225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52319, 2, -2730.17, 2142.78, 116.992, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52320, 21753, 530, 1, 0, 0, -2714.16, 2038.81, 117.179, 1.61041, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52320;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52320, 1, -2713.38, 2141.8, 117.186, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52320, 2, -2714.56, 2036.58, 116.812, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52321, 21753, 530, 1, 0, 0, -2696.44, 2059.87, 117.225, 1.57663, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52321;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52321, 1, -2697.13, 2133.55, 117.225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52321, 2, -2696.88, 2035.28, 117.23, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52321, 3, -2696.98, 2061.21, 117.226, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52322, 22253, 530, 1, 0, 0, -5186.33, -119.621, 67.9895, 5.42302, 300, 7, 0, 110700, 0, 0, 1);
INSERT INTO `creature` VALUES (52325, 22253, 530, 1, 0, 0, -5083.72, -127.43, 57.864, 0.838646, 25, 0, 0, 110700, 0, 0, 2);
INSERT INTO `creature` VALUES (52327, 21754, 530, 1, 0, 0, -2645, 2590.59, 74.9251, 1.45658, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52327;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52327, 1, -2646.47, 2654.04, 74.9245, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52327, 2, -2644.31, 2586.75, 74.9259, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52327, 3, -2643.92, 2515.22, 74.2148, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52327, 4, -2644.5, 2585.19, 74.9259, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52328, 21754, 530, 1, 0, 0, -2631.19, 2653.51, 74.1862, 1.48405, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52328;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52328, 1, -2629.38, 2583.55, 74.1984, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52328, 2, -2628.94, 2518.08, 74.2024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52328, 3, -2630.05, 2583.5, 74.1974, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52328, 4, -2631.49, 2651.51, 74.1913, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52329, 21754, 530, 1, 0, 0, -2736.29, 2488.78, 93.2806, 1.52038, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52329;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52329, 1, -2736.12, 2505.82, 93.461, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52329, 2, -2736.9, 2429.87, 92.2576, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52329, 3, -2736.44, 2490.43, 93.2808, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52330, 22253, 530, 1, 0, 0, -4932.89, 22.4, 62.16, 3.616, 300, 0, 0, 110700, 0, 0, 0);
INSERT INTO `creature` VALUES (52331, 22253, 530, 1, 0, 0, -4941.29, 35.202, 62.653, 3.27, 300, 0, 0, 110700, 0, 0, 0);
INSERT INTO `creature` VALUES (52332, 21754, 530, 1, 0, 0, -2720.64, 2449.53, 92.162, 1.56763, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52332;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52332, 1, -2719.49, 2505.61, 93.2809, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52332, 2, -2719.75, 2446.81, 92.1613, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52333, 21754, 530, 1, 0, 0, -2755.07, 2382.19, 92.4042, 1.51657, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52333;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52333, 1, -2753.12, 2480.81, 92.1622, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52333, 2, -2755.17, 2394.44, 93.2104, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52334, 21754, 530, 1, 0, 0, -2769.76, 2426.95, 92.4207, 4.73277, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52334;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52334, 1, -2770.38, 2388.06, 93.2809, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52334, 2, -2769.79, 2481.35, 93.2798, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52334, 3, -2770.1, 2422.93, 92.4085, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52335, 21754, 530, 1, 0, 0, -2756.64, 2339.46, 92.1703, 4.74453, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52335;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52335, 1, -2756.41, 2294.05, 92.5436, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52335, 2, -2755.02, 2380.41, 92.8542, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52335, 3, -2757.79, 2338.13, 92.1484, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52336, 21754, 530, 1, 0, 0, -2769.54, 2320.77, 93.2806, 4.64635, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52336;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52336, 1, -2770.31, 2300.14, 93.2807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52336, 2, -2770.26, 2384.55, 93.2797, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52336, 3, -2769.98, 2315.23, 93.2808, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52337, 21754, 530, 1, 0, 0, -2755.03, 2225.6, 92.1626, 1.52046, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52337;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52337, 1, -2757.57, 2295.15, 92.9952, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52337, 2, -2755.67, 2249.97, 93.2806, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52337, 3, -2755.51, 2213.36, 93.2806, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52337, 4, -2756.07, 2235.85, 93.2813, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52338, 21754, 530, 1, 0, 0, -2770.36, 2283.05, 93.2808, 4.72489, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52338;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52338, 1, -2770.28, 2215.41, 93.281, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52338, 2, -2770.34, 2295.68, 93.2807, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52339, 21754, 530, 1, 0, 0, -2785.46, 2226.31, 92.4747, 4.64085, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52339;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52339, 1, -2786.39, 2214.95, 93.2807, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52339, 2, -2785.45, 2295.57, 92.1451, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52339, 3, -2785.8, 2226.15, 92.3954, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52340, 22253, 530, 1, 0, 0, -5177.52, 317.832, 73.6533, 1.51095, 25, 0, 0, 110700, 0, 0, 2);
INSERT INTO `creature` VALUES (52341, 21754, 530, 1, 0, 0, -2753.17, 2129.18, 117.225, 4.68956, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52341;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52341, 1, -2753.48, 2084.39, 116.692, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52341, 2, -2753.23, 2039.01, 117.226, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52341, 3, -2753.54, 2076.2, 117.025, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52341, 4, -2753.5, 2140.28, 116.233, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52341, 5, -2753.59, 2128.95, 117.225, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52342, 22253, 530, 1, 0, 0, -5179.42, 410.113, 73.9961, 0.870851, 25, 0, 0, 110700, 0, 0, 2);
INSERT INTO `creature` VALUES (52343, 22253, 530, 1, 0, 0, -5190.18, 541.781, 74.918, 1.51252, 25, 0, 0, 110700, 0, 0, 2);
INSERT INTO `creature` VALUES (52344, 21754, 530, 1, 0, 0, -2736.79, 2038.79, 117.226, 1.54404, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52344;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52344, 1, -2736.81, 2083.45, 116.135, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52344, 2, -2736.48, 2138.88, 117.222, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52344, 3, -2737.2, 2084.14, 116.154, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52344, 4, -2737.27, 2038.64, 117.226, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52345, 22253, 530, 1, 0, 0, -5188.89, 683.875, 69.584, 3.44382, 25, 0, 0, 110700, 0, 0, 2);
INSERT INTO `creature` VALUES (52346, 21754, 530, 1, 0, 0, -2721.05, 2095, 117.225, 1.45294, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52346;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52346, 1, -2720.25, 2139.84, 117.168, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52346, 2, -2721.5, 2089.03, 117.225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52346, 3, -2721.34, 2039.54, 117.225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52346, 4, -2721.85, 2072.63, 117.225, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (52347, 21754, 530, 1, 0, 0, -2703.57, 2072.28, 117.225, 4.69074, 120, 0, 0, 6326, 0, 0, 2);
SET @GUID := 52347;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (52347, 1, -2703.58, 2038.86, 117.225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52347, 2, -2703.5, 2071.44, 117.225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52347, 3, -2703.39, 2131.25, 117.225, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (52347, 4, -2703.21, 2071.45, 117.226, 0, 0, 0, 0, 0);

SET @GUID := 58257;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58257, 1, -994.858, 2016.68, 66.9401, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 2, -987.058, 2016.84, 66.944, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 3, -969.963, 2015.55, 66.9407, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 4, -992.627, 2016.88, 66.9396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 5, -1008.49, 2035.8, 66.9396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 6, -1019.05, 2035.35, 67.2124, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 7, -1026.29, 2037.92, 66.9864, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 8, -1031.45, 2045, 67.2057, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 9, -1031.8, 2050.98, 67.373, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 10, -1029.18, 2060.44, 67.0733, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 11, -1035.14, 2070.83, 66.4578, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 12, -1046.05, 2082, 64.1436, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 13, -1057.36, 2102.01, 58.7574, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 14, -1058.04, 2129.59, 48.8137, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 15, -1057.72, 2110.08, 56.3034, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 16, -1052.97, 2091.25, 61.7214, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 17, -1038.32, 2072.46, 66.0964, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 18, -1027.76, 2059.28, 67.1104, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 19, -1031.24, 2051.67, 67.2734, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 20, -1030.17, 2044.37, 67.0587, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 21, -1024.43, 2037.2, 67.0174, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 22, -1009.71, 2037.91, 66.9423, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 23, -1001.4, 2026.91, 66.9409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 24, -997.203, 2019.57, 66.9409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 25, -998.892, 2012.33, 66.9409, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 26, -1009.97, 1993.77, 66.9437, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58257, 27, -1006.72, 1997.57, 66.9406, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 58632;
INSERT INTO `creature` VALUES (58632, 16907, 530, 1, 0, 0, -966.617, 2033.46, 67.047, 1.50105, 300, 0, 0, 4142, 0, 0, 2);
SET @GUID := 58632;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58632, 1, -967.837, 2049.47, 66.9396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 2, -961.27, 2056.9, 66.9396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 3, -959.369, 2062.51, 66.9396, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 4, -963.171, 2062.44, 66.9396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 5, -972.978, 2069.15, 67.2109, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 6, -980.363, 2071.69, 68.1111, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 7, -983.956, 2068.97, 67.4094, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 8, -985.507, 2063.74, 66.9396, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 9, -981.499, 2052.05, 67.3838, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 10, -969.215, 2033.99, 66.9399, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 11, -967.02, 2022.12, 66.9399, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 12, -967.238, 2012.22, 66.9399, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58632, 13, -966.301, 2034.51, 66.9405, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 58258;
INSERT INTO `creature` VALUES (58258, 16873, 530, 1, 0, 0, -927.408, 1981.61, 66.9599, 5.89678, 300, 0, 0, 3984, 2434, 0, 2);
SET @GUID := 58258;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58258, 1, -921.449, 1980.35, 66.8774, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 2, -913.765, 1975.24, 66.9386, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 3, -928.577, 1988.22, 66.6361, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 4, -938.015, 2005.06, 66.1177, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 5, -941.708, 2016.25, 66.3742, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 6, -957.925, 2015.49, 66.9383, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 7, -964.086, 2017.72, 66.9383, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 8, -966.338, 2023.66, 66.9383, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 9, -967.488, 2047.72, 66.9395, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 10, -967.084, 2025.86, 66.9395, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 11, -963.563, 2017.48, 66.9395, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 12, -959.347, 2015.48, 66.9395, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 13, -945.11, 2016.23, 66.637, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 14, -941.893, 2014.64, 66.3753, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 15, -938.416, 2004.23, 66.1797, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 16, -931.909, 1992.22, 66.4831, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 17, -927.701, 1986.47, 66.7103, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 18, -914.462, 1975.92, 66.9383, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 19, -922.634, 1982.74, 66.8262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 20, -929.579, 1983.86, 66.7997, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 21, -938.836, 1975.64, 66.9378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 22, -947.48, 1963.75, 66.9378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 23, -948.247, 1958.09, 66.9378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 24, -946.037, 1948.46, 66.9378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 25, -947.17, 1958.57, 66.9378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 26, -946.699, 1963.58, 66.9378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 27, -936.566, 1978.14, 66.9274, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58258, 28, -927.685, 1982.05, 66.8359, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 58635;
INSERT INTO `creature` VALUES (58635, 16907, 530, 1, 0, 0, -926.346, 1998.53, 65.9756, 2.47848, 300, 0, 0, 4142, 0, 0, 2);
SET @GUID := 58635;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58635, 1, -930.128, 2000.58, 65.8055, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58635, 2, -943.891, 2000.6, 66.8665, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58635, 3, -927.429, 1999.94, 65.7533, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58635, 4, -916.524, 1997.9, 66.3727, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58635, 5, -911.155, 1991.46, 67.3741, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58635, 6, -906.294, 1982.16, 67.5317, 45000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58635, 7, -912.459, 1992.95, 67.1693, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58635, 8, -925.844, 1998.59, 65.8413, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 69634;
INSERT INTO `creature` VALUES (69634, 19442, 530, 1, 0, 0, -1050.19, 2009.98, 67.0646, 1.04782, 300, 0, 0, 3734, 0, 0, 2);
SET @GUID := 69634;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (69634, 1, -1061.4, 1990.54, 67.7375, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (69634, 2, -1050.05, 2010.76, 66.9442, 5000, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 58256;
INSERT INTO `creature` VALUES (58256, 16873, 530, 1, 0, 0, -1124.38, 1995.03, 69.9037, 1.19283, 300, 0, 0, 3984, 2434, 0, 2);
SET @GUID := 58256;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58256, 1, -1114.14, 2011.38, 67.1604, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 2, -1101.41, 2028.73, 66.9398, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 3, -1093.52, 2047.06, 66.9398, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 4, -1085.04, 2065.81, 66.6262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 5, -1076.16, 2080.22, 64.4702, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 6, -1064.43, 2095.27, 60.8484, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 7, -1059.13, 2106.46, 57.5343, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 8, -1061.44, 2097.33, 60.173, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 9, -1072.13, 2086.71, 63.1124, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 10, -1082.49, 2083.97, 64.5262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 11, -1104.78, 2083.75, 66.9315, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 12, -1118.4, 2083.03, 67.1008, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 13, -1127.97, 2079.65, 66.9416, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 14, -1114.92, 2083.49, 67.1903, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 15, -1100.28, 2084.04, 66.6023, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 16, -1087.11, 2083.69, 65.1054, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 17, -1075.01, 2085.77, 63.4943, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 18, -1064.91, 2094.61, 61.0279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 19, -1059.4, 2103.59, 58.3917, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 20, -1067.46, 2090.52, 62.0639, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 21, -1084.7, 2067.09, 66.526, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 22, -1095.02, 2044.96, 66.9383, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 23, -1103.5, 2026.86, 66.9407, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 24, -1124.08, 1994.27, 69.8528, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 25, -1135.96, 1970.91, 73.5444, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 26, -1141.88, 1958.74, 79.1522, 4000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 27, -1135.3, 1970.01, 73.7214, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 28, -1131.22, 1981.87, 72.9887, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58256, 29, -1124.47, 1995.19, 69.7317, 0, 0, 0, 0, 0);

UPDATE `creature` SET `spawntimesecs` = 180 WHERE `guid` = 59190;

UPDATE `creature_template` SET `InhabitType` = 3 WHERE `entry` = 21315;
DELETE FROM `creature` WHERE `guid` = 74638;
INSERT INTO `creature` VALUES (74638, 21315, 530, 1, 0, 0, -3807.05, 1074.56, 125.246, 3.6, 120, 0, 0, 86172, 0, 0, 2);
SET @GUID := 74638;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20344,16777472,0,4097,0,34078720,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX,YYY,ZZZ,0,0,0,100,0),
(74638,1,-3806.5219, 1077.2375, 109.1055,10000,1,0,100,0),
(74638,2,-3871.77, 1061.12, 104.353,0, 1, 0, 100, 0),
(74638,3,-3946.31, 1007.96, 41.4916,0, 0, 0, 100, 0),
(74638,4,-3981.2, 987.16, 17.436,0, 0, 0, 0, 100),
(74638,5,-3993.67, 972.909, 13.7035,0, 0, 0, 100, 0), -- remove flying
(74638,6,-4005.54, 940.329, 13.9175,0, 0, 0, 100, 0),
(74638,7,-4020.11, 896.722, 7.69662,0, 0, 0, 100, 0),
(74638,8,-4028.87, 860.941, 4.21714,0, 0, 0, 100, 0),
(74638,9,-4037.39, 811.117, 2.06301,0, 0, 0, 100, 0),
(74638,10,-4052.31, 778.566, 2.59821,0, 0, 0, 100, 0),
(74638,11,-4062.38, 747.941, 0.669277,0, 0, 0, 100, 0),
(74638,12,-4088.7, 713.37, 2.51993,0, 0, 0, 100, 0),
(74638,13,-4112.87, 681.706, 2.70455,0, 0, 0, 100, 0),
(74638,14,-4129.74, 646.929, 4.20341,0, 0, 0, 100, 0),
(74638,15,-4142.77, 622.847, 3.48307,0, 0, 0, 100, 0),
(74638,16,-4150.78, 575.896, 9.39146,0, 0, 0, 100, 0),
(74638,17,-4161.78, 548.95, 13.7863,0, 0, 0, 100, 0),
(74638,18,-4175.77, 521.903, 23.8752,10000, 0, 0, 100, 0),
(74638,19,-4181.6440, 503.6903, 28.0125,1000, 0, 0, 100, 0), -- 1 despawn?
(74638,20,-4135.1464, 615.4747, 46.8997,0, 0, 1, 100, 0),
(74638,21,-4093.4133, 715.8195, 63.8540,0, 0, 1, 100, 0),
(74638,22,-4046.8959, 827.6535, 82.7495,0, 0, 1, 100, 0),
(74638,23,-4000.6271, 938.9025, 101.5461,0, 0, 1, 100, 0),
(74638,24,-3967.9599, 1017.4416, 109.1055,0, 0, 1, 100, 0),
(74638,25,-3875.5007, 1071.0936, 109.1055,0, 0, 1, 100, 0);

SET @GUID := 140785;
SET @POINT := 0;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1,XXX,YYY,ZZZ,0,0,0,100,0),
(140785,1,-5332.09,-85.8966,83.0617,0,0,0,100,0),
(140785,2,-5345.18,-60.7703,86.1259,0,0,0,100,0),
(140785,3,-5359.92,-47.2275,88.2481,0,0,0,100,0),
(140785,4,-5375.98,-54.8256,85.1149,0,0,0,100,0),
(140785,5,-5383.74,-67.6999,82.852,0,0,0,100,0),
(140785,6,-5382.25,-85.6452,77.1119,0,0,0,100,0),
(140785,7,-5369.33,-110.352,68.5213,0,0,0,100,0),
(140785,8,-5376.19,-131.543,60.2006,0,0,0,100,0),
(140785,9,-5365.88,-147.114,56.8587,0,0,0,100,0),
(140785,10,-5354.64,-146.72,57.3092,0,0,0,100,0),
(140785,11,-5347.56,-140.622,59.763,0,0,0,100,0),
(140785,12,-5337.81,-108.826,72.3716,0,0,0,100,0);

DELETE FROM `creature` WHERE `guid` IN (78291,78292,78293,78294,78295,78296,78297,78298,78299,78300);
INSERT INTO `creature` VALUES (78291, 22274, 530, 1, 0, 0, -4911.14, 388.978, 125.189, 3.49686, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78291;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78291, 1, -4881.3, 427.912, 128.262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 2, -4871.17, 466.401, 131.434, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 3, -4873.22, 548.351, 119.355, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 4, -4871.98, 596.992, 108.096, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 5, -4891.92, 622.833, 110.9, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 6, -4918.26, 642.178, 113.206, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 7, -4966.29, 659.392, 117.973, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 8, -5008.11, 653.667, 123.262, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 9, -5053.75, 635.555, 122.915, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 10, -5074.28, 608.823, 126.232, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 11, -5080.16, 581.402, 130.831, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 12, -5079.39, 564.034, 132.081, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 13, -5072.99, 533.087, 134.23, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 14, -5030.73, 474.796, 138.025, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 15, -4985.5, 438.713, 136.57, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 16, -4952.93, 411.544, 133.09, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78291, 17, -4928.21, 400.14, 131.012, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78292, 22274, 530, 1, 0, 0, -4902.26, 379.006, 152.696, 2.10116, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78292;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78292, 1, -4949.25, 409.334, 172.648, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 2, -4986.28, 430.9, 164.212, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 3, -5030.59, 451.136, 157.85, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 4, -5092.63, 466.253, 150.296, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 5, -5133.9, 465.085, 140.105, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 6, -5165.66, 429.091, 139.144, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 7, -5182.09, 387.046, 147.142, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 8, -5191.97, 332.265, 149.23, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 9, -5184.35, 296.293, 154.117, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 10, -5168.04, 259.87, 174.531, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 11, -5144.8, 225.734, 177.739, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 12, -5098.47, 187.537, 166.379, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 13, -5056.61, 165.009, 154.057, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 14, -5007.17, 150.469, 133.295, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 15, -4962.95, 150.816, 126.2, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 16, -4914.33, 175.569, 138.166, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 17, -4883.57, 253.392, 130.726, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 18, -4840.9, 301.478, 161.359, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 19, -4867.16, 343.913, 179.668, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78292, 20, -4903.82, 376.069, 182.823, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78293, 22274, 530, 1, 0, 0, -4999.29, 189.984, 80.4584, 2.57263, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78293;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78293, 1, -4997.6, 211.812, 133.552, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 2, -4934.04, 221.55, 128.328, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 3, -4879.49, 236.103, 122.107, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 4, -4828.16, 305.232, 119.328, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 5, -4828.82, 359.135, 124.352, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 6, -4849.83, 387.363, 122.887, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 7, -4884.64, 388.875, 126.775, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 8, -4913.1, 382.401, 128.892, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 9, -4937.48, 371.375, 130.364, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 10, -4959.68, 347.329, 130.097, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 11, -4978.18, 304.388, 114.958, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 12, -4932.93, 209.679, 111.892, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 13, -4926.15, 183.988, 115.455, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 14, -4930.97, 159.154, 120.218, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 15, -4946.76, 140.626, 122.312, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 16, -4965.19, 141.617, 119.384, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 17, -4984.45, 149.966, 118.799, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 18, -5002.91, 172.814, 117.016, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78293, 19, -4998.34, 201.085, 113.024, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78294, 22274, 530, 1, 0, 0, -4958.5, -85.27, 117.736, 2.41635, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78294;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78294, 1, -4941.07, -111.012, 114.028, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 2, -4921.42, -123.247, 111.998, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 3, -4884.24, -120.132, 112.711, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 4, -4868.08, -92.5276, 107.21, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 5, -4865.19, -54.2843, 104.094, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 6, -4879.19, -23.9512, 100.15, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 7, -4909.36, -13.2885, 106.699, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 8, -4941.26, -7.0724, 133.33, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 9, -5002.9, 5.94151, 132.549, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 10, -5074.55, 22.7466, 134.073, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 11, -5101.11, 26.0961, 133.55, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 12, -5127.23, 20.6693, 131.995, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 13, -5156.48, 0.475302, 144.378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 14, -5154.25, -29.3614, 139.554, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 15, -5132.14, -63.023, 145.24, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 16, -5097.03, -87.8888, 134.508, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 17, -5032.7, -78.9392, 127.697, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78294, 18, -4975.4, -69.1826, 134.579, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78295, 22274, 530, 1, 0, 0, -5157.74, -73.334, 158.606, 1.83224, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78295;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78295, 1, -5156.25, -94.823, 171.465, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 2, -5130.8, -92.8877, 169.278, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 3, -5097.89, -85.159, 167.084, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 4, -5079.62, -74.9995, 165.999, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 5, -5056.81, -48.5336, 164.502, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 6, -5030.81, 95.1094, 164.23, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 7, -5032.43, 121.94, 164.434, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 8, -5043.1, 153.612, 169.073, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 9, -5069.2, 159.741, 169.297, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 10, -5119.94, 159.723, 170.732, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 11, -5139.41, 122.925, 165.495, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 12, -5146.54, 82.7476, 163.162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78295, 13, -5151.17, -26.9422, 175.432, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78296, 22274, 530, 1, 0, 0, -5289.07, 145.261, 125.233, 2.07098, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78296;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78296, 1, -5302.94, 148.193, 127.077, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 2, -5290.26, 249.662, 119.674, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 3, -5267.99, 307.372, 119.553, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 4, -5242.13, 346.618, 121.471, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 5, -5224.22, 366.559, 129.072, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 6, -5200.15, 357.228, 128.85, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 7, -5194.47, 339.612, 126.384, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 8, -5194.41, 306.298, 116.659, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 9, -5209.57, 201.541, 109.824, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 10, -5207.61, 165.878, 112.162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78296, 11, -5212.25, 113.191, 134.219, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78297, 22274, 530, 1, 0, 0, -5225.27, 263.193, 131.392, 3.25408, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78297;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78297, 1, -5215.32, 277.894, 166.181, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 2, -5172.04, 404.969, 165.06, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 3, -5130.57, 454.686, 159.026, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 4, -5089.47, 502.399, 170.614, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 5, -5041.76, 475.945, 165.177, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 6, -5006.87, 447.279, 171.482, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 7, -4986.95, 415.732, 169.479, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 8, -4975.85, 380.042, 181.744, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 9, -4999.68, 166.051, 189.57, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 10, -5015.45, 110.992, 189.148, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 11, -5058.36, 88.613, 176.465, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 12, -5120.99, 79.2858, 160.208, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 13, -5157.9, 84.5635, 149.221, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 14, -5175.5, 115.78, 143.718, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 15, -5202.99, 172.801, 131.402, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78297, 16, -5229.64, 253.177, 150.283, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78298, 22274, 530, 1, 0, 0, -5107.23, 621.556, 149.469, 2.64865, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78298;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78298, 1, -5075.7, 588.805, 171.098, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 2, -5072.26, 564.667, 167.686, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 3, -5084.8, 530.119, 160.541, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 4, -5115.49, 507.568, 173.964, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 5, -5154.44, 518.915, 169.609, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 6, -5179.29, 544.52, 163.991, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 7, -5191.59, 586.714, 155.673, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 8, -5208.79, 630.415, 141.357, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 9, -5201.16, 687.436, 133.72, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 10, -5185.01, 716.463, 135.258, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 11, -5153.45, 744.444, 135.341, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 12, -5128.04, 743.877, 161.561, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 13, -5110.02, 716.147, 155.565, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78298, 14, -5094.49, 634.262, 158.678, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78299, 22274, 530, 1, 0, 0, -5076.33, 636.957, 147.466, 0.855016, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78299;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78299, 1, -5069.71, 577.64, 147.79, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 2, -5050.86, 550.855, 148.449, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 3, -5013.49, 533.048, 147.952, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 4, -4981, 545.555, 145.112, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 5, -4953.01, 572.649, 139.987, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 6, -4955.81, 608.175, 129.584, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 7, -4970, 644.18, 124.6, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 8, -5003.18, 662.806, 125.4, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 9, -5043.46, 659.586, 123.544, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78299, 10, -5075.57, 644.292, 130.902, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (78300, 22274, 530, 1, 0, 0, -5130.26, 729.272, 115.821, 1.73891, 300, 0, 0, 7248, 3155, 0, 2);
SET @GUID := 78300;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20684,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (78300, 1, -5108.2, 702.831, 122.868, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 2, -5045.79, 689.993, 136.98, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 3, -4957.58, 712.13, 126.374, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 4, -4915.51, 732.807, 123.744, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 5, -4936.79, 796.18, 127.606, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 6, -5018.26, 817.255, 117.714, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 7, -5081.91, 819.454, 141.825, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 8, -5111.82, 789.527, 146.217, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (78300, 9, -5118.12, 733.878, 142.053, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` = 63565;
INSERT INTO `creature` VALUES (63565, 17855, 530, 1, 0, 0, -202.651, 5515.28, 21.7477, 3.7547, 300, 0, 0, 5200, 3155, 0, 2);
SET @GUID := 63565;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (63565, 1, -156.735, 5529.23, 29.4078, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 2, -187.331, 5519.33, 29.4078, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 3, -195.079, 5516.92, 26.1063, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 4, -201.47, 5514.63, 22.0083, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 5, -208.031, 5511.41, 21.5288, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 6, -212.832, 5492.39, 21.6689, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 7, -224.826, 5479.09, 21.7913, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 8, -232.499, 5477.83, 22.2421, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 9, -242.15, 5485.49, 24.3591, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 10, -254.019, 5502.76, 29.0737, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 11, -250.092, 5496.16, 28.4978, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 12, -243.141, 5487.11, 25.3283, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 13, -240.121, 5482.4, 23.2805, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 14, -227.154, 5478.94, 21.8781, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 15, -214.306, 5488.03, 21.977, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 16, -209.588, 5509.94, 21.5479, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 17, -202.532, 5514.33, 21.6838, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 18, -195.18, 5516.57, 25.9736, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 19, -187.158, 5519.01, 29.408, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (63565, 20, -160.726, 5527.58, 29.408, 0, 0, 0, 0, 0);

-- Expedition Warden
UPDATE `creature_template` SET `minhealth`=14000, `maxhealth`=14000, `AIName` = 'EventAI' WHERE `entry` = 17855;
DELETE FROM `creature_ai_scripts` WHERE `entryORGuid` = 17855;
INSERT INTO `creature_ai_scripts` VALUES
('1785501','17855','9','0','100','1','0','15','16000','24000','11','12024','1','32','0','0','0','0','0','0','0','0','Expedition Warden - Cast Net');

-- Update position Ja'y Nosliw <Skybreaker General> 22433
DELETE FROM `creature` WHERE `guid` = 8581445;
UPDATE `creature` SET `position_x`=-5144.404, `position_y`=600.9089, `position_z`=82.75489, `orientation`=6.021386 WHERE  `guid`=78787;

-- Update position Taskmaster Varkule Dragonbreath 23140
UPDATE `creature` SET `position_x`=-5114.439, `position_y`=588.4843, `position_z`=85.87241, `orientation`=3.036873 WHERE  `guid`=51876;

-- Update fly speed of Dragonmaw Skybreakers
UPDATE `waypoint_data` SET `move_type`=1 WHERE  `id` IN (78294, 78297, 78291, 78292, 78293, 78294, 78295, 78296, 78297, 78298, 78299, 78300);

-- Pathing for Dragonmaw Transporter Entry: 23188 'TDB FORMAT' 
SET @GUID := 132814;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4584.821,`position_y`=56.05914,`position_z`=260.3116 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,16314,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4584.821,56.05914,260.3116,0,1,0,100,0), -- 07:28:22
(@GUID,2,-4554.921,74.39236,250.4782,0,1,0,100,0), -- 07:28:22
(@GUID,3,-4532.374,72.2015,243.3948,0,1,0,100,0), -- 07:28:22
(@GUID,4,-4508.559,67.28505,241.6727,0,1,0,100,0), -- 07:28:22
(@GUID,5,-4487.302,56.6492,242.2004,0,1,0,100,0), -- 07:28:22
(@GUID,6,-4470.297,28.84614,244.756,0,1,0,100,0), -- 07:28:22
(@GUID,7,-4461.818,-8.348633,247.9227,0,1,0,100,0), -- 07:28:22
(@GUID,8,-4477.97,-44.38118,242.3393,0,1,0,100,0), -- 07:28:22
(@GUID,9,-4516.678,-59.03483,240.2283,0,1,0,100,0), -- 07:28:22
(@GUID,10,-4543.176,-60.92849,240.2838,0,1,0,100,0), -- 07:28:22
(@GUID,11,-4566.225,-51.06413,247.3116,0,1,0,100,0), -- 07:28:22
(@GUID,12,-4581.653,-29.58301,254.2004,0,1,0,100,0), -- 07:28:22
(@GUID,13,-4591.782,0.532661,260.3116,0,1,0,100,0), -- 07:28:22
(@GUID,14,-4594.208,28.59668,260.3116,0,1,0,100,0); -- 07:28:22

-- Pathing for Dragonmaw Transporter Entry: 23188 'TDB FORMAT' 
SET @GUID := 132818;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4735.987,`position_y`=122.2487,`position_z`=106.433 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,16314,0,1,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-4735.987,122.2487,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,2,-4744.92,149.3799,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,3,-4751.057,182.3161,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,4,-4767.275,216.0688,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,5,-4776.866,248.6194,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,6,-4781.172,280.7835,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,7,-4783.174,319.2545,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,8,-4752.483,324.3357,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,9,-4729.643,316.453,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,10,-4715.97,309.7697,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,11,-4709.104,290.6015,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,12,-4710.651,264.7013,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,13,-4709.572,256.6543,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,14,-4706.147,218.4914,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,15,-4709.459,193.1469,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,16,-4704.721,157.6649,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,17,-4695.498,116.758,106.433,0,1,0,100,0), -- 07:15:27
(@GUID,18,-4713.938,87.04405,101.2085,0,1,0,100,0), -- 07:15:27
(@GUID,19,-4726.667,100.212,106.433,0,1,0,100,0); -- 07:15:27

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = 37906;
INSERT INTO `spell_linked_spell` VALUES
(37906,-37905,1,'Book of Fel Names - Remove Metamorphosis');

-- Book of Fel Names target Varedis only
DELETE FROM `spell_script_target` WHERE `entry` = 37906;
INSERT INTO `spell_script_target` VALUES
(37906,1,21178);

-- Spell Script
DELETE FROM `spell_scripts` WHERE `id` = 37906;
INSERT INTO `spell_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`) VALUES
(37906, 0, 14, 37905, 0, 0, 0, 0, 0, 0);

-- Varedis 21178
UPDATE `creature_template` SET `speed`='1.48', `AIName`='EventAI', `mechanic_immune_mask`='578895699', `flags_extra`='1078001664' WHERE `entry` = 21178; -- 578895699 1078001664
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21178;
INSERT INTO `creature_ai_scripts` VALUES
(2117801,21178,4,0,100,0,0,0,0,0,11,29651,0,0,0,0,0,0,0,0,0,0,'Varedis - Casts Dual Wield on Aggro'),
(2117802,21178,0,0,100,1,3500,5500,10000,11000,11,38010,4,32,0,0,0,0,0,0,0,0,'Varedis - Curse of Flames'),
(2117803,21178,0,0,100,1,4000,8000,12000,15000,11,37683,0,0,0,0,0,0,0,0,0,0,'Varedis - Evasion'),
(2117804,21178,0,0,100,1,5000,5000,9500,16000,11,39262,4,0,0,0,0,0,0,0,0,0,'Varedis - Mana Burn'),
(2117805,21178,9,0,100,1,0,15,15000,20000,11,33803,1,0,0,0,0,0,0,0,0,0,'Varedis - Cast Flame Wave'),
(2117806,21178,2,0,100,0,50,0,0,0,11,36298,0,7,0,0,0,0,0,0,0,0,'Varedis - Casts Metamorphosis at 50% HP'), -- 37905
(2117807,21178,8,0,100,1,37906,-1,0,0,28,0,37905,0,0,0,0,0,0,0,0,0,'Varedis - Remove Metamorphosis on Book of Fel Names Spellhit'),
(2117808,21178,7,0,100,0,0,0,0,0,28,0,36298,0,0,0,0,0,0,0,0,0,'Varedis - Remove Metamorphosis on Evade');

-- Flame Wave 19381
-- faulty model A or H
UPDATE `creature_template` SET `flags_extra`='130' WHERE `entry` = 19381;

-- Shadow Council Felsworn 21753
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16' WHERE `entry` = 21753;
-- Shadow Council Zealot 21754
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16' WHERE `entry` = 21754;

-- Losing Gracefully Quest Object
UPDATE `gameobject` SET `spawnmask`=1 WHERE `id` = 183435;

-- Totems - Invernal Behavior
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (17646);
INSERT INTO `creature_ai_scripts` VALUES
('1764601','17646','1','0','100','1','4000','4000','100','100','11','30859','0','32','0','0','0','0','0','0','0','0','Netherspite Infernal - Cast Hellfire OOC'),
('1764602','17646','0','0','100','1','4000','4000','100','100','11','30859','0','32','0','0','0','0','0','0','0','0','Netherspite Infernal - Cast Hellfire');

DELETE FROM `creature` WHERE `guid` IN (29882, 34053, 34054, 34058, 40592);
INSERT INTO `creature` VALUES (29882, 21839, 530, 1, 0, 0, 2154.45, 4902.69, 147.832, 3.58426, 180, 5, 0, 6505, 0, 0, 1);
INSERT INTO `creature` VALUES (34053, 21839, 530, 1, 0, 0, 2024.7, 4905.79, 140.883, 3.59604, 180, 5, 0, 6505, 0, 0, 1);
INSERT INTO `creature` VALUES (34054, 21839, 530, 1, 0, 0, 1970.95, 4916.71, 142.878, 5.79515, 180, 5, 0, 6505, 0, 0, 1);
INSERT INTO `creature` VALUES (34058, 21839, 530, 1, 0, 0, 1869.55, 4921.42, 147.661, 0.140283, 180, 5, 0, 6505, 0, 0, 1);
INSERT INTO `creature` VALUES (40592, 21839, 530, 1, 0, 0, 1785.86, 4767.26, 145.577, 4.16543, 180, 5, 0, 6505, 0, 0, 1);

-- Don Carlos Head 100% not 50%
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry` = 91598 AND `item` = 38329;

-- Dampscale Basilisk 18461
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 18461;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18461;
INSERT INTO `creature_ai_scripts` VALUES
('1846101','18461','0','0','100','1','3000','6000','45000','50000','11','32905','1','0','0','0','0','0','0','0','0','0','Dampscale Basilisk - Cast Glare');

-- Marshrock Threshalisk 19706
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 19706;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19706;
INSERT INTO `creature_ai_scripts` VALUES
('1970601','19706','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','0','0','0','0','Marshrock Threshalisk - Cast Threshalisk Charge');

-- Ironspine Threshalisk 19729
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 19729;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19729;
INSERT INTO `creature_ai_scripts` VALUES
('1972901','19729','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','0','0','0','0','Ironspine Threshalisk - Cast Threshalisk Charge');

-- Ironspine Gazer 19730
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 19730;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 19730;
INSERT INTO `creature_ai_scripts` VALUES
('1973001','19730','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','0','0','0','0','Ironspine Gazer - Cast Threshalisk Charge'),
('1973002','19730','0','0','100','1','5000','10000','12000','24000','11','35313','4','32','0','0','0','0','0','0','0','0','Ironspine Gazer - Cast Hypnotic Gaze');

-- Ragestone Threshalisk 20279 FD
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 20279;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20279;
INSERT INTO `creature_ai_scripts` VALUES
('2027901','20279','2','0','100','0','20','0','0','0','11','3019','0','0','1','-46','0','0','0','0','0','0','Ragestone Threshalisk - Cast Enrage at 20% HP');
-- ('2027902','20279','2','0','100','0','50','40','0','0','11','35571','0','7','11','29266','0','7','22','0','0','0','Ragestone Threshalisk - Casts Feign Death Test and Stop Movement and Stop Attack at 50% HP'), -- 5384 29266 
-- ('2027903','20279','2','0','100','1','40','30','0','0','28','0','35571','0','28','0','29266','0','22','1','0','0','Ragestone Threshalisk - Remove Feign Death Test at 40% HP'),
-- ('2027904','20279','2','0','100','1','99','51','0','0','28','0','35571','0','28','0','29266','0','22','1','0','0','Ragestone Threshalisk - Remove Feign Death Test at 70% HP');

-- Ragestone Trampler 20280
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 20280;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20280;
INSERT INTO `creature_ai_scripts` VALUES
('2028001','20280','0','0','100','1','4000','8000','7000','12000','11','5568','0','0','22','1','0','0','0','0','0','0','Ragestone Trampler - Cast Trample'),
('2028002','20280','2','0','100','0','30','0','0','0','11','3019','0','0','1','-46','0','0','0','0','0','0','Ragestone Trampler - Cast Enrage at 30% HP'),
('2028003','20280','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','22','1','0','0','Ragestone Trampler - Casts Threshalisk Charge and Set Phase 1'),
-- ('2028004','20280','2','2','100','0','50','40','0','0','11','5384','0','7','11','29266','0','7','22','0','0','0','Ragestone Trampler - Casts Feign Death and Stop Movement and Stop Attack between 80% and 55% HP'),
-- ('2028005','20280','2','2','100','0','40','30','0','0','28','0','5384','0','28','0','29266','0','22','1','0','0','Ragestone Trampler - Remove Feign Death between 55% to 30% HP'),
('2028006','20280','9','2','100','0','5','40','0','0','11','35385','1','0','1','-9100','0','0','0','0','0','0','Ragestone Trampler - Casts Threshalisk Charge and Emote'),
('2028007','20280','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Ragestone Trampler - Set Phase to 0 on Evade');

-- Marshrock Stomper 20283
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 20283;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20283;
INSERT INTO `creature_ai_scripts` VALUES
(2028301,20283,0,0,100,1,5000,5000,15000,15000,11,12612,0,0,0,0,0,0,0,0,0,0,'Marshrock Stomper - Casts Stomp'),
(2028302,20283,9,0,100,0,5,40,0,0,11,35385,1,7,11,35385,1,7,0,0,0,0,'Marshrock Stomper - Casts Threshalisk Charge');

-- Bladespine Basilisk 20607 FD
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 20607;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20607;
INSERT INTO `creature_ai_scripts` VALUES
('2060701','20607','9','0','100','0','5','40','0','0','11','35385','1','0','11','35385','1','0','0','0','0','0','Bladespine Basilisk - Cast Threshalisk Charge'),
('2060702','20607','0','0','100','1','4000','8000','45000','55000','11','35313','1','0','0','0','0','0','0','0','0','0','Bladespine Basilisk - Cast Hypnotic Gaze');

-- Grishnath Basilisk 20924 FD
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 20924;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20924;
INSERT INTO `creature_ai_scripts` VALUES
('2092401','20924','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','0','0','0','0','Grishnath Basilisk - Cast Threshalisk Charge'),
('2092402','20924','2','0','100','0','70','41','0','0','11','37590','0','0','0','0','0','0','0','0','0','0','Grishnath Basilisk - Cast Soften at 70% HP'),
('2092403','20924','2','0','100','0','40','11','0','0','11','37590','0','0','0','0','0','0','0','0','0','0','Grishnath Basilisk - Cast Soften at 40% HP'),
('2092404','20924','2','0','100','0','10','0','0','0','11','37590','0','0','0','0','0','0','0','0','0','0','Grishnath Basilisk - Cast Soften at 10% HP');

-- Scalded Basilisk 20925 FD
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 20925;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20925;
INSERT INTO `creature_ai_scripts` VALUES
('2092501','20925','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','0','0','0','0','Scalded Basilisk - Cast Threshalisk Charge'),
('2092502','20925','0','0','85','1','8000','13000','14000','19000','11','35236','0','0','0','0','0','0','0','0','0','0','Scalded Basilisk - Cast Heat Wave');

-- Ruuan Weald Basilisk 20987 FD
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 20987;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20987;
INSERT INTO `creature_ai_scripts` VALUES
('2098701','20987','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','0','0','0','0','Ruuan Weald Basilisk - Cast Threshalisk Charge');

-- Craghide Basilisk 22187
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 22187;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22187;
INSERT INTO `creature_ai_scripts` VALUES
('2218701','22187','9','0','100','0','5','40','0','0','11','35385','1','7','11','35385','1','7','0','0','0','0','Craghide Basilisk - Cast Threshalisk Charge'),
('2218702','22187','0','0','100','1','4000','8000','7000','14000','11','35236','0','0','0','0','0','0','0','0','0','0','Craghide Basilisk - Cast Heat Wave');

DELETE FROM `creature_ai_texts` WHERE `entry` = '-9100';
INSERT INTO `creature_ai_texts` VALUES
(-9100,'stops playing dead and charges forward!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'Basilisc Feign Death Charge');

DELETE FROM `npc_trainer` WHERE `spell` = 44970;
INSERT INTO `npc_trainer` VALUES (19187, 44970, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (21087, 44970, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (18771, 44970, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (18754, 44970, 50000, 165, 350, 0);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18796;
INSERT INTO `creature_ai_scripts` VALUES
('1879601','18796','4','0','5','6','0','0','0','0','1','-9983','-9982','-9959','0','0','0','0','1','0','0','0','Fel Overseer - Random Say on Aggro'),
('1879602','18796','9','0','100','7','0','25','15000','15000','11','27577','1','7','11','27577','1','7','0','0','0','0','Fel Overseer - Cast Intercept in Range'),
('1879603','18796','0','0','100','7','9000','12000','9000','15000','11','30471','1','0','0','0','0','0','0','0','0','0','Fel Overseer - Cast Uppercut'),
('1879604','18796','9','0','100','5','0','5','8000','12000','11','16856','1','0','0','0','0','0','0','0','0','0','Fel Overseer (Heroic) - Cast Mortal Strike'),
('1879605','18796','0','0','100','7','30000','30000','30000','30000','11','19134','1','1','0','0','0','0','0','0','0','0','Fel Overseer (Heroic) - Cast Frightening Shout every 30 Secs'),
('1879606','18796','6','0','20','6','0','0','0','0','1','-9958','-9957','-9981','0','0','0','0','0','0','0','0','Fel Overseer - Say on Death');

DELETE FROM creature_ai_scripts WHERE `entryOrGUID` = 19389;
INSERT INTO `creature_ai_scripts` VALUES
('1938901','19389','4','0','100','2','0','0','0','0','30','1','1','2','0','0','0','0','0','0','0','0','Lair Brute - Random Phase on Aggro'),
('1938902','19389','0','2','100','3','3000','6000','3000','9000','11','39171','1','0','30','1','2','0','0','0','0','0','Lair Brute - Cast Mortal Strike and Select Random Phase (Phase 1)'),
('1938903','19389','0','1','100','3','3000','6000','3000','9000','11','39174','1','0','30','1','2','0','0','0','0','0','Lair Brute - Cast Cleave and Select Random Phase (Phase 2)'),
('1938904','19389','9','0','100','3','8','25','11000','18000','11','24193','5','0','11','27577','5','0','14','-99','0','0','Lair Brute - Cast Random Charge and Reduce All Threat'),
('1938905','19389','9','0','50','2','8','25','0','0','11','24193','1','0','11','27577','1','0','0','0','0','0','Lair Brute - Cast Charge in Range'), -- 50
('1938906','19389','2','0','100','2','15','0','0','0','39','90','0','0','1','-551','0','0','0','0','0','0','Lair Brute - Call for Help and and Text Emote at 15% HP');

DELETE FROM `creature_formations` WHERE `leaderguid` IN (81645,69871,65618,81648);
INSERT INTO `creature_formations` VALUES
(81645,81645,100,360,2),
(81645,81646,100,360,2),
--
(69871,69871,100,360,2),
(69871,72432,100,360,2),
--
(65618,65618,100,360,2),
(65618,83206,100,360,2),
--
(81648,81648,100,360,2),
(81648,81649,100,360,2),
(81648,81650,100,360,2);

-- Mag'har Hunter 16912
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16912;
INSERT INTO `creature_ai_scripts` VALUES
('1691201','16912','0','0','100','1','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Mag\'har Hunter - Start Movement and Set Melee Weapon Model'),
('1691202','16912','4','0','100','0','0','0','0','0','11','32730','1','7','0','0','0','0','0','0','0','0','Mag\'har Hunter - Summon Tamed Ravager on Aggro'),
('1691203','16912','9','0','100','1','5','30','2300','3900','11','6660','1','0','40','2','0','0','0','0','0','0','Mag\'har Hunter - Cast Shoot and Set Ranged Weapon Model'),
('1691204','16912','0','0','100','1','4000','8000','14000','18000','11','12024','1','0','0','0','0','0','0','0','0','0','Mag\'har Hunter - Cast Net'),
('1691205','16912','2','0','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Mag\'har Hunter - Start Movement and Flee at 15% HP'),
('1691206','16912','21','0','100','0','0','0','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Mag\'har Hunter - Start Movement and Set Melee Weapon Model on Evade'),
('1691207','16912','9','0','100','1','0','5','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Mag\'har Hunter - Start Movement and Set Melee Weapon Model Below 6 Yards'),
('1691208','16912','9','0','100','1','6','20','0','0','21','0','0','0','40','2','0','0','0','0','0','0','Mag\'har Hunter - Stop Movement and Set Ranged Weapon Model Above 5 Yards');

SET @GUID := 58673;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,207,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (58673, 1, 296.593, 3812.2, 166.866, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 2, 278.562, 3799.43, 174.341, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 3, 254.613, 3795.56, 180.252, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 4, 244.686, 3788, 183.952, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 5, 243.414, 3773.33, 185.054, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 6, 250.251, 3760.86, 183.248, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 7, 254.6, 3754.41, 179.452, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 8, 296.357, 3704.58, 179.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 9, 333.027, 3689.41, 179.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 10, 358.843, 3689.22, 179.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 11, 405.334, 3713.95, 179.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 12, 428.31, 3738.71, 180.12, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 13, 434.829, 3740.89, 183.512, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 14, 471.896, 3737.58, 185.936, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 15, 524.585, 3732.89, 184.812, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 16, 532.705, 3739.35, 185.795, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 17, 537.17, 3748.46, 186.823, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 18, 523.617, 3730.31, 184.739, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 19, 435.559, 3741.62, 183.559, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 20, 427.597, 3737.42, 179.845, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 21, 391.187, 3704.16, 179.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 22, 344.63, 3684.85, 179.279, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 23, 300.681, 3702.1, 179.278, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 24, 254.7, 3752.27, 179.342, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 25, 254.312, 3762.82, 183.541, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 26, 249.374, 3780.52, 184.945, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 27, 250.775, 3792.2, 182.04, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (58673, 28, 266.842, 3799.05, 176.7, 0, 0, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (29053,29054,29055,29056,29057,29058,75031,75032,75036,75037,75039,75040,75041,75043,75046,75048,75049,75055,75056,75067);
INSERT INTO `creature` VALUES (29053, 22859, 530, 1, 0, 0, -3500.33, 404.143, 30.9582, 4.69701, 25, 0, 0, 5409, 3080, 0, 0);
INSERT INTO `creature` VALUES (29054, 22859, 530, 1, 0, 0, -3500.3, 386.974, 33.702, 1.55334, 25, 0, 0, 5409, 3080, 0, 0);
INSERT INTO `creature` VALUES (29055, 22859, 530, 1, 0, 0, -3549.88, 374.402, 33.2306, 3.1765, 25, 0, 0, 5409, 3080, 0, 0);
INSERT INTO `creature` VALUES (29056, 22859, 530, 1, 0, 0, -3570.4, 373.56, 32.8885, 6.21337, 25, 0, 0, 5409, 3080, 0, 0);
INSERT INTO `creature` VALUES (29057, 22859, 530, 1, 0, 0, -3617.36, 389.152, 34.4028, 1.58825, 25, 0, 0, 5409, 3080, 0, 0);
INSERT INTO `creature` VALUES (29058, 22859, 530, 1, 0, 0, -3618.23, 405.728, 32.0895, 4.7822, 25, 0, 0, 5409, 3080, 0, 0);

-- DELETE FROM `waypoint_scripts` WHERE `id` = 2285701;
-- INSERT INTO `waypoint_scripts` VALUES
-- (2285701,0,20,0,0,0,0,0,0,0,2285701,'Stop Waypoint Movement'); -- nonfunctional atm as 0 value returns current path.

INSERT INTO `creature` VALUES (75056, 22860, 530, 1, 0, 0, -3498.94, 395.572, 32.8215, 3.09606, 25, 0, 0, 4890, 7196, 0, 2);
SET @GUID := 75056;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75056, 1, -3498.94, 395.572, 32.8215, 15000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75056, 2, -3538.63, 406.667, 31.5276, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75056, 3, -3537.18, 426.734, 29.6203, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75067, 22860, 530, 1, 0, 0, -3563.97, 372.969, 32.7509, 1.64462, 25, 0, 0, 4890, 7196, 0, 2);
SET @GUID := 75067;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75067, 1, -3563.97, 372.969, 32.7509, 15000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75067, 2, -3566.63, 398.212, 30.3852, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75046, 22858, 530, 1, 0, 0, -3497.72, 392.406, 33.3901, 3.44716, 25, 0, 0, 6761, 0, 0, 2);
SET @GUID := 75046;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75046, 1, -3497.72, 392.406, 33.3901, 15000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75046, 2, -3539.13, 404.16, 31.7229, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75046, 3, -3539.93, 416.171, 30.6542, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75046, 4, -3534.23, 429.033, 29.5253, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75048, 22858, 530, 1, 0, 0, -3498.71, 399.058, 32.0341, 3.133, 25, 0, 0, 6761, 0, 0, 2);
SET @GUID := 75048;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75048, 1, -3498.71, 399.058, 32.0341, 15000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75048, 2, -3535.84, 404.825, 31.7943, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75048, 3, -3538.67, 413.919, 30.9066, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75048, 4, -3530.69, 431.653, 28.903, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75049, 22858, 530, 1, 0, 0, -3561.08, 372.938, 32.7815, 1.73494, 25, 0, 0, 6761, 0, 0, 2);
SET @GUID := 75049;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75049, 1, -3563.97, 372.969, 32.7509, 15000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75049, 2, -3562.53, 398.248, 30.3088, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75055, 22858, 530, 1, 0, 0, -3556.42, 373.266, 32.9199, 1.66033, 25, 0, 0, 6761, 0, 0, 2);
SET @GUID := 75055;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75055, 1, -3556.42, 373.266, 32.9199, 15000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75055, 2, -3557.41, 398.045, 30.4066, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75031, 22857, 530, 1, 0, 0, -3618.52, 400.563, 32.6102, 0.349821, 25, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75031;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75031, 1, -3603.1, 405.87, 32.1828, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75031, 2, -3587.57, 426.027, 29.9384, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75032, 22857, 530, 1, 0, 0, -3619.03, 394.032, 33.7729, 0.153472, 25, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75032;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75032, 1, -3598.19, 400.955, 32.5042, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75032, 2, -3579.64, 420.87, 29.8369, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75036, 22857, 530, 1, 0, 0, -3499.19, 398.61, 32.1255, 2.94776, 25, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75036;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75036, 1, -3521.43, 398.615, 31.5006, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75036, 2, -3521.43, 398.615, 31.5006, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75037, 22857, 530, 1, 0, 0, -3499.11, 392.555, 33.2845, 2.97917, 25, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75037;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75037, 1, -3528.04, 392.062, 33.1226, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75037, 2, -3528.04, 392.062, 33.1226, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75039, 22857, 530, 1, 0, 0, -3555.98, 372.556, 33.0066, 1.24308, 120, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75039;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75039, 1, -3539.06, 410.48, 31.1203, 20000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75039, 2, -3536.94, 436.584, 28.3962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75039, 3, -3557.26, 478.573, 23.0744, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75040, 22857, 530, 1, 0, 0, -3560.18, 375.579, 32.5697, 1.1449, 120, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75040;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75040, 1, -3544.42, 413.53, 30.1391, 20000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75040, 2, -3544.84, 437.631, 27.6364, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75040, 3, -3566.47, 478.431, 22.6319, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75041, 22857, 530, 1, 0, 0, -3566.28, 373.577, 32.7165, 1.91306, 120, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75041;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75041, 1, -3572.02, 409.806, 29.7299, 20000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75041, 2, -3571.21, 472.279, 23.5142, 1000, 0, 2285701, 100, 0);

INSERT INTO `creature` VALUES (75043, 22857, 530, 1, 0, 0, -3561.52, 373.531, 32.7196, 1.90313, 120, 0, 0, 20958, 0, 0, 2);
SET @GUID := 75043;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75043, 1, -3566.1, 409.175, 29.4568, 20000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (75043, 2, -3561.11, 470.597, 23.4149, 1000, 0, 2285701, 100, 0);

UPDATE `creature_template` SET `faction_A` = 1843, `faction_H` = 1843 WHERE `entry` IN (22858,22860);

DELETE FROM `creature` WHERE `guid` IN (100048,100049,109766,109767,109768,109769);
INSERT INTO `creature` VALUES (100048, 22842, 530, 1, 21119, 0, -231.478, 5442.25, 29.7544, 0.62634, 120, 0, 0, 50, 0, 0, 2);
SET @GUID := 100048;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (100048, 1, -231.478, 5442.25, 29.7544, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 2, -231.907, 5441.81, 29.406, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 3, -233.547, 5436.12, 30.5861, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 4, -235.965, 5433.31, 31.3361, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 5, -245.663, 5430.38, 32.447, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 6, -254.214, 5432.43, 32.5025, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 7, -257.63, 5440.65, 31.3655, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 8, -250.052, 5446.8, 30.1432, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 9, -244.96, 5449.01, 29.6711, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100048, 10, -237.615, 5448.88, 29.7544, 0, 1, 0, 100, 0);

INSERT INTO `creature` VALUES (100049, 22843, 530, 1, 21119, 0, -253.422, 5430.91, 28.9293, 2.59318, 120, 0, 0, 4059, 0, 0, 2);
SET @GUID := 100049;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (100049, 1, -253.422, 5430.91, 28.9293, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 2, -252.237, 5429.65, 28.7579, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 3, -246.087, 5428.44, 29.5424, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 4, -239.405, 5431.1, 29.5424, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 5, -235.548, 5436.21, 30.9035, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 6, -235.02, 5442.25, 30.8757, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 7, -238.777, 5445.63, 32.0702, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 8, -246.55, 5445.43, 30.8202, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 9, -254.38, 5440.28, 29.6793, 0, 1, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (100049, 10, -255.29, 5432.61, 28.9293, 0, 1, 0, 100, 0);

UPDATE `creature_template` SET `InhabitType` = 4 WHERE `entry` IN (22842,22843);

INSERT INTO `creature` VALUES (109766, 22838, 530, 1, 0, 0, -2075.76, 8559.34, 23.027, 4.85702, 120, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (109767, 22831, 530, 1, 0, 0, -3320.86, 4925.1, -101.1, 0, 120, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (109768, 22839, 530, 1, 0, 0, -781.294, 6943.52, 33.3344, 0, 120, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (109769, 22866, 530, 1, 0, 0, 9506.09, -7329.31, 14.3973, 0, 120, 0, 0, 1, 0, 0, 0);


DELETE FROM `creature` WHERE `guid` = 100174;
INSERT INTO `creature` VALUES (100174, 22017, 530, 1, 0, 0, -4120.25, 1335.39, 67.2617, 0, 180, 0, 0, 5233, 2991, 0, 0);
DELETE FROM `creature` WHERE `guid` = 101801;
INSERT INTO `creature` VALUES (101801, 21060, 530, 1, 14515, 0, -2759.31, 875.419, -0.952728, 5.2065, 180, 5, 0, 5589, 3155, 0, 1);

DELETE FROM `creature` WHERE `guid` BETWEEN 104000 AND 105000;
INSERT INTO `creature` VALUES (104829, 22016, 530, 1, 0, 0, -4120.37, 1333.76, 66.4649, 0.0174533, 180, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (104830, 22016, 530, 1, 0, 0, -4120.15, 1336.9, 68.0352, 0, 180, 0, 0, 5233, 2991, 0, 0);
INSERT INTO `creature` VALUES (104986, 19823, 530, 1, 0, 0, -4486.58, 1998.88, 112.765, 0.113942, 300, 20, 0, 54088, 0, 0, 1);
INSERT INTO `creature` VALUES (104987, 19823, 530, 1, 0, 0, -4527.13, 2106.33, 38.1019, 0.221064, 300, 20, 0, 54088, 0, 0, 1);
INSERT INTO `creature` VALUES (104988, 19823, 530, 1, 0, 0, -4561.13, 2024.76, 92.2968, 5.31829, 300, 20, 0, 54088, 0, 0, 1);
INSERT INTO `creature` VALUES (104989, 19823, 530, 1, 0, 0, -4399.99, 2334.17, 28.1067, 0.071826, 300, 20, 0, 54088, 0, 0, 1);

DELETE FROM `creature` WHERE `guid` IN (106139,106140,106141,106142,106168,106169,106170,106171,106172,106173,106174,106175,106176,106209,106275,106796);
INSERT INTO `creature` VALUES (106139, 21803, 530, 1, 0, 0, -3224.17, 954.594, 53.2922, 0.282183, 180, 0, 0, 4057, 0, 0, 0);
INSERT INTO `creature` VALUES (106140, 21453, 530, 1, 0, 2098, -3211.19, 1069.99, 65.4826, 2.9824, 180, 0, 0, 5409, 3080, 0, 0);
INSERT INTO `creature` VALUES (106141, 21453, 530, 1, 0, 2098, -3212.87, 935.073, 53.7186, 3.74718, 180, 0, 0, 5409, 3080, 0, 0);
INSERT INTO `creature` VALUES (106142, 21454, 530, 1, 0, 0, -3355.57, 836.093, -22.4942, 4.62512, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106168, 21454, 530, 1, 0, 0, -3330.01, 838.522, -19.4002, 4.67748, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106169, 21454, 530, 1, 0, 0, -3411.82, 1065.97, 43.5778, 3.00197, 0, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106170, 21454, 530, 1, 0, 0, -3412.32, 1085.12, 44.0007, 3.40339, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106171, 21454, 530, 1, 0, 0, -3274.38, 987.516, 43.8539, 4.36332, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106172, 21455, 530, 1, 0, 0, -3194.41, 889.876, 51.7198, 5.5676, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106173, 21455, 530, 1, 0, 0, -3202.95, 902.151, 49.9862, 0.837758, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106174, 21455, 530, 1, 0, 0, -3329.55, 1187.46, 65.5767, 2.16421, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106175, 21455, 530, 1, 0, 0, -3251.08, 976.31, 48.1459, 6.23082, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106176, 21455, 530, 1, 0, 0, -3231.52, 997.717, 59.2313, 1.45149, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106209, 21455, 530, 1, 0, 0, -3231.95, 1018.78, 62.6671, 5.88176, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106275, 21455, 530, 1, 0, 0, -3254.02, 992.717, 51.3794, 1.44353, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (106796, 21455, 530, 1, 0, 0, -3245.43, 1009.24, 59.9086, 0.663225, 180, 0, 0, 6761, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (107578,107579,107580,107582,107584,107588,107589,107605,107607,107620,107624,107629,107641,107704,107711,107712,107713,107714);
INSERT INTO `creature` VALUES (107578, 12758, 249, 1, 0, 0, -27.0481, -219.097, -89.2858, 4.76475, 180, 0, 0, 5000, 0, 0, 0);
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` = 12758; 
INSERT INTO `creature` VALUES (107579, 22515, 249, 1, 0, 0, -64.041, -188.512, -59.4399, 5.65487, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107580, 22515, 249, 1, 0, 0, 12.422, -242.438, -60.5616, 2.53073, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107582, 22515, 249, 1, 0, 0, 11.945, -180.162, -60.2732, 3.80482, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107584, 21455, 530, 1, 0, 0, -3240.76, 1027.02, 61.4212, 0.15708, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (107588, 21455, 530, 1, 0, 0, -3250.08, 1020.43, 58.8627, 0.418879, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (107589, 21455, 530, 1, 0, 0, -3394.58, 1127.67, 51.0358, 5.86431, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (107605, 22515, 249, 1, 0, 0, 25.1607, -216.082, -58.9221, 2.68781, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107607, 22515, 249, 1, 0, 0, -63.7864, -235.271, -60.1968, 0.575959, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107620, 21455, 530, 1, 0, 0, -3383.46, 1127.75, 52.9988, 3.87463, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (107624, 22515, 249, 1, 0, 0, -15.7137, -181.303, -62.0383, 4.24115, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107629, 22515, 249, 1, 0, 0, -14.9782, -245.483, -60.3758, 1.98968, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107641, 22515, 249, 1, 0, 0, -75.3875, -215.219, -58.023, 0.05236, 180, 0, 0, 881, 0, 0, 0);
INSERT INTO `creature` VALUES (107704, 22515, 249, 1, 0, 0, -134.407, -213.742, -70.198, 0.017453, 180, 0, 0, 881, 0, 0, 0);
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 22515;
INSERT INTO `creature` VALUES (107711, 21455, 530, 1, 0, 0, -3264.48, 1002.89, 56.8814, 3.97935, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (107712, 21455, 530, 1, 0, 0, -3380.83, 1113.42, 48.791, 2.54818, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (107713, 21455, 530, 1, 0, 0, -3394.78, 1111.06, 50.7728, 1.27409, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (107714, 21455, 530, 1, 0, 0, -3289.59, 1032.92, 51.8233, 2.96706, 180, 0, 0, 6761, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (108872,108874,108877,108878,108879,108880,108972,108973,108974,108975,108999);
INSERT INTO `creature` VALUES (108872, 21455, 530, 1, 0, 0, -3337.02, 1092.48, 52.5119, 0.191986, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108874, 21455, 530, 1, 0, 0, -3297.32, 1038.93, 53.6622, 5.28835, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108877, 21060, 530, 1, 14515, 0, -2701.16, 854.306, -18.3783, 4.85701, 180, 5, 0, 5589, 3155, 0, 1);
INSERT INTO `creature` VALUES (108878, 21455, 530, 1, 0, 0, -3295.74, 1026.52, 49.9782, 1.93731, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108879, 21455, 530, 1, 0, 0, -3303.5, 1031.59, 50.6656, 0.0174533, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108880, 21455, 530, 1, 0, 0, -3320.54, 1058.17, 51.5506, 1.91986, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108972, 21455, 530, 1, 0, 0, -3406.06, 1042.06, 43.6969, 3.80482, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108973, 21455, 530, 1, 0, 0, -3230.25, 969.699, 56.468, 1.94, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108974, 21455, 530, 1, 0, 0, -3202.2, 924.88, 54.5841, 5.24821, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108975, 21455, 530, 1, 0, 0, -3194.94, 912.901, 53.9515, 3.68136, 180, 0, 0, 6761, 0, 0, 0);
INSERT INTO `creature` VALUES (108999, 21455, 530, 1, 0, 0, -3422.27, 1122.06, 46.7247, 0.86922, 180, 0, 0, 6761, 0, 0, 0);

DELETE FROM `creature` WHERE `guid` IN (109000,109001,109019,109045,109145,109736,109765);
INSERT INTO `creature` VALUES (109000, 23148, 530, 1, 0, 0, -5137.82, 561.52, 84.36, 4.747, 180, 0, 0, 7181, 0, 0, 0);
INSERT INTO `creature` VALUES (109001, 23144, 530, 1, 0, 0, -5119.8, 624.766, 86.8275, 1.25664, 180, 0, 0, 6542, 0, 0, 0);
INSERT INTO `creature` VALUES (109019, 23345, 530, 1, 0, 0, -5066.31, 640.214, 86.4967, 1.55334, 180, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (109045, 23346, 530, 1, 0, 0, -5060.33, 640.436, 86.5787, 1.78265, 25, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (109145, 23348, 530, 1, 0, 0, -5074.88, 625.448, 85.8285, 2.03791, 25, 0, 0, 6986, 0, 0, 0);
INSERT INTO `creature` VALUES (109736, 22829, 530, 1, 0, 0, 214.737, 8506.04, 24.3274, 3.89208, 180, 0, 0, 6986, 0, 0, 0);
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry` IN (22829,22831,22833,22838,22839,22866);
INSERT INTO `creature` VALUES (109765, 22833, 530, 1, 0, 0, -248.77, 962.568, 84.4228, 1.58825, 180, 0, 0, 1073, 0, 0, 0);
DELETE FROM `game_event_creature` WHERE `guid` IN (109736,109765,109766,109767,109768,109769);
INSERT INTO `game_event_creature` VALUES
(109736,10),
(109765,10),
(109766,10),
(109767,10),
(109768,10),
(109769,10);

DELETE FROM `creature` WHERE `guid` IN (110323);
INSERT INTO `creature` VALUES (110323, 23143, 530, 1, 0, 0, -5142.57, 581.328, 84.1357, 0.506145, 25, 0, 0, 6542, 0, 0, 0);
-- Horus <Innkeeper>
UPDATE `creature_template` SET `npcflag`=`npcflag`|65536|128|1,`unit_flags`=33536,`ScriptName`='npc_innkeeper' WHERE `entry` = 23143;

UPDATE `pool_template` SET `max_limit` = 5, `description` = 'Netherwing eggs (185915) - Dragonmaw Fortrees' WHERE `entry` = 25427; -- 4
UPDATE `pool_template` SET `max_limit` = 10, `description` = 'Netherwing eggs (185915) - Netherwing Ledge' WHERE `entry` = 25428; -- 7
UPDATE `pool_template` SET `max_limit` = 5, `description` = 'Netherwing eggs (185915) - Netherwing Mine' WHERE `entry` = 25429; -- 5

UPDATE `gameobject` SET `spawntimesecs` = 3600 WHERE `id` IN (185915,185600);

SET @ENTRY := 2542700;
DELETE FROM `pool_template`  WHERE `entry` BETWEEN 2542700 AND 2542799;
INSERT INTO `pool_template` VALUES
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121847 50426
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121848 3370498
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121849 3371109
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121850 50427
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121851 2056080
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121852 50429
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121853 50430
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121854 50431
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121855 50432
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'), -- 121856 3371670
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Dragonmaw Fortrees'); -- 121857 3371716

SET @ENTRY := 2542700;
DELETE FROM `pool_pool` WHERE `mother_pool` = 25427;
INSERT INTO `pool_pool` VALUES
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 1 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 2 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 3 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 4 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 5 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 6 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 7 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 8 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 9 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 10 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(@ENTRY := @ENTRY + '1',25427,0,'Spawn Point 11 - Netherwing eggs (185915) - Dragonmaw Fortrees');

DELETE FROM `pool_gameobject` WHERE `guid` IN (121847, 50426, 121848, 3370498, 121849, 3371109, 121850, 50427, 121851, 2056080, 121852, 50429, 121853, 50430, 121854, 50431, 121855, 50432, 121856, 3371670, 121857, 3371716);
INSERT INTO `pool_gameobject` VALUES
(121847,2542701,0,'Spawn Point 1 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(50426,2542701,0,'Spawn Point 1 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121848,2542702,0,'Spawn Point 2 - Netherwing eggs (185915) - Dragonmaw Fortrees'),
(3370498,2542702,0,'Spawn Point 2 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121849,2542703,0,'Spawn Point 3 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(3371109,2542703,0,'Spawn Point 3 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121850,2542704,0,'Spawn Point 4 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(50427,2542704,0,'Spawn Point 4 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121851,2542705,0,'Spawn Point 5 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(2056080,2542705,0,'Spawn Point 5 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121852,2542706,0,'Spawn Point 6 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(50429,2542706,0,'Spawn Point 6 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121853,2542707,0,'Spawn Point 7 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(50430,2542707,0,'Spawn Point 7 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121854,2542708,0,'Spawn Point 8 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(50431,2542708,0,'Spawn Point 8 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121855,2542709,0,'Spawn Point 9 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(50432,2542709,0,'Spawn Point 9 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121856,2542710,0,'Spawn Point 10 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(3371670,2542710,0,'Spawn Point 10 - Netherwing eggs (185915) - Dragonmaw Fortrees'),

(121857,2542711,0,'Spawn Point 11 - Netherwing eggs (185915) - Dragonmaw Fortrees'),  
(3371716,2542711,0,'Spawn Point 11 - Netherwing eggs (185915) - Dragonmaw Fortrees');

SET @ENTRY := 2542800;
DELETE FROM `pool_template`  WHERE `entry` BETWEEN 2542800 AND 2542899;
INSERT INTO `pool_template` VALUES
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50417 2057493
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50418 2057612
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50419 50428
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50420 2056954
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50421 2058488
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50422 2056430
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50423 2056646
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50424 3030869
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 50425 2056079
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121858 50433
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121859 50434
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121860 2056081
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121861 2056082
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121862 2056083
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121863 2056084
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121864 2056085
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121865 2056086
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121866 2056087
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121867 2056088
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121868 2056089
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121869 2056090
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121870 2056091
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121871 2056092
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121872 2056093
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121873 2056094
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121874 2056095
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121875 2056096
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121876 2056097
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121877 2056098
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121878 2056099
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121879 2056100
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121880 2056101
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121881 2056102
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121882 2056103
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121883 2056104
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121884 2056105
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121885 2056106
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121886 2056107
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121887 2056108
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121888 2056109
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121889 2056110
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'), -- 121890 2056111
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Ledge'); -- 121891 2056112

SET @ENTRY := 2542800;
DELETE FROM `pool_pool` WHERE `mother_pool` = 25428;
INSERT INTO `pool_pool` VALUES
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 1 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 2 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 3 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 4 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 5 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 6 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 7 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 8 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 9 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 10 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 11 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 12 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 13 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 14 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 15 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 16 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 17 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 18 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 19 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 20 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 21 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 22 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 23 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 24 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 25 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 26 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 27 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 28 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 29 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 30 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 31 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 32 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 33 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 34 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 35 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 36 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 37 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 38 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 39 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 40 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 41 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 42 - Netherwing eggs (185915) - Netherwing Ledge'),
(@ENTRY := @ENTRY + '1',25428,0,'Spawn Point 43 - Netherwing eggs (185915) - Netherwing Ledge');

DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN 50417 AND 50425;
DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN 121858 AND 121891;
DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN 2056081 AND 2056112;
DELETE FROM `pool_gameobject` WHERE `guid` IN (2057493, 2057612, 50428, 2056954, 2058488, 2056430, 2056646, 3030869, 2056079, 50433, 50434);
INSERT INTO `pool_gameobject` VALUES
(50417,2542801,0,'Spawn Point 1 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2057493,2542801,0,'Spawn Point 1 - Netherwing eggs (185915) - Netherwing Ledge'),

(50418,2542802,0,'Spawn Point 2 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2057612,2542802,0,'Spawn Point 2 - Netherwing eggs (185915) - Netherwing Ledge'),

(50419,2542803,0,'Spawn Point 3 - Netherwing eggs (185915) - Netherwing Ledge'),  
(50428,2542803,0,'Spawn Point 3 - Netherwing eggs (185915) - Netherwing Ledge'),

(50420,2542804,0,'Spawn Point 4 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056954,2542804,0,'Spawn Point 4 - Netherwing eggs (185915) - Netherwing Ledge'),

(50421,2542805,0,'Spawn Point 5 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2058488,2542805,0,'Spawn Point 5 - Netherwing eggs (185915) - Netherwing Ledge'),

(50422,2542806,0,'Spawn Point 6 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056430,2542806,0,'Spawn Point 6 - Netherwing eggs (185915) - Netherwing Ledge'),

(50423,2542807,0,'Spawn Point 7 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056646,2542807,0,'Spawn Point 7 - Netherwing eggs (185915) - Netherwing Ledge'),

(50424,2542808,0,'Spawn Point 8 - Netherwing eggs (185915) - Netherwing Ledge'),  
(3030869,2542808,0,'Spawn Point 8 - Netherwing eggs (185915) - Netherwing Ledge'),

(50425,2542809,0,'Spawn Point 9 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056079,2542809,0,'Spawn Point 9 - Netherwing eggs (185915) - Netherwing Ledge'),

(121858,2542810,0,'Spawn Point 10 - Netherwing eggs (185915) - Netherwing Ledge'),  
(50433,2542810,0,'Spawn Point 10 - Netherwing eggs (185915) - Netherwing Ledge'),

(121859,2542811,0,'Spawn Point 11 - Netherwing eggs (185915) - Netherwing Ledge'),  
(50434,2542811,0,'Spawn Point 11 - Netherwing eggs (185915) - Netherwing Ledge'),

(121860,2542812,0,'Spawn Point 12 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056081,2542812,0,'Spawn Point 12 - Netherwing eggs (185915) - Netherwing Ledge'),

(121861,2542813,0,'Spawn Point 13 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056082,2542813,0,'Spawn Point 13 - Netherwing eggs (185915) - Netherwing Ledge'),

(121862,2542814,0,'Spawn Point 14 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056083,2542814,0,'Spawn Point 14 - Netherwing eggs (185915) - Netherwing Ledge'),

(121863,2542815,0,'Spawn Point 15 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056084,2542815,0,'Spawn Point 15 - Netherwing eggs (185915) - Netherwing Ledge'),
 
(121864,2542816,0,'Spawn Point 16 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056085,2542816,0,'Spawn Point 16 - Netherwing eggs (185915) - Netherwing Ledge'),

(121865,2542817,0,'Spawn Point 17 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056086,2542817,0,'Spawn Point 17 - Netherwing eggs (185915) - Netherwing Ledge'),

(121866,2542818,0,'Spawn Point 18 - Netherwing eggs (185915) - Netherwing Ledge'),  
(2056087,2542818,0,'Spawn Point 18 - Netherwing eggs (185915) - Netherwing Ledge'),

(121867,2542819,0,'Spawn Point 19 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056088,2542819,0,'Spawn Point 19 - Netherwing eggs (185915) - Netherwing Ledge'),

(121868,2542820,0,'Spawn Point 20 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056089,2542820,0,'Spawn Point 20 - Netherwing eggs (185915) - Netherwing Ledge'),

(121869,2542821,0,'Spawn Point 21 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056090,2542821,0,'Spawn Point 21 - Netherwing eggs (185915) - Netherwing Ledge'),

(121870,2542822,0,'Spawn Point 22 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056091,2542822,0,'Spawn Point 22 - Netherwing eggs (185915) - Netherwing Ledge'),

(121871,2542823,0,'Spawn Point 23 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056092,2542823,0,'Spawn Point 23 - Netherwing eggs (185915) - Netherwing Ledge'),

(121872,2542824,0,'Spawn Point 24 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056093,2542824,0,'Spawn Point 24 - Netherwing eggs (185915) - Netherwing Ledge'),

(121873,2542825,0,'Spawn Point 25 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056094,2542825,0,'Spawn Point 25 - Netherwing eggs (185915) - Netherwing Ledge'),

(121874,2542826,0,'Spawn Point 26 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056095,2542826,0,'Spawn Point 26 - Netherwing eggs (185915) - Netherwing Ledge'),

(121875,2542827,0,'Spawn Point 27 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056096,2542827,0,'Spawn Point 27 - Netherwing eggs (185915) - Netherwing Ledge'),

(121876,2542828,0,'Spawn Point 28 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056097,2542828,0,'Spawn Point 28 - Netherwing eggs (185915) - Netherwing Ledge'),

(121877,2542829,0,'Spawn Point 29 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056098,2542829,0,'Spawn Point 29 - Netherwing eggs (185915) - Netherwing Ledge'),

(121878,2542830,0,'Spawn Point 30 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056099,2542830,0,'Spawn Point 30 - Netherwing eggs (185915) - Netherwing Ledge'),

(121879,2542831,0,'Spawn Point 31 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056100,2542831,0,'Spawn Point 31 - Netherwing eggs (185915) - Netherwing Ledge'),

(121880,2542832,0,'Spawn Point 32 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056101,2542832,0,'Spawn Point 32 - Netherwing eggs (185915) - Netherwing Ledge'),

(121881,2542833,0,'Spawn Point 33 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056102,2542833,0,'Spawn Point 33 - Netherwing eggs (185915) - Netherwing Ledge'),

(121882,2542834,0,'Spawn Point 34 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056103,2542834,0,'Spawn Point 34 - Netherwing eggs (185915) - Netherwing Ledge'),

(121883,2542835,0,'Spawn Point 35 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056104,2542835,0,'Spawn Point 35 - Netherwing eggs (185915) - Netherwing Ledge'),

(121884,2542836,0,'Spawn Point 36 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056105,2542836,0,'Spawn Point 36 - Netherwing eggs (185915) - Netherwing Ledge'),

(121885,2542837,0,'Spawn Point 37 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056106,2542837,0,'Spawn Point 37 - Netherwing eggs (185915) - Netherwing Ledge'),

(121886,2542838,0,'Spawn Point 38 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056107,2542838,0,'Spawn Point 38 - Netherwing eggs (185915) - Netherwing Ledge'),

(121887,2542839,0,'Spawn Point 39 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056108,2542839,0,'Spawn Point 39 - Netherwing eggs (185915) - Netherwing Ledge'),

(121888,2542840,0,'Spawn Point 40 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056109,2542840,0,'Spawn Point 40 - Netherwing eggs (185915) - Netherwing Ledge'),

(121889,2542841,0,'Spawn Point 41 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056110,2542841,0,'Spawn Point 41 - Netherwing eggs (185915) - Netherwing Ledge'),

(121890,2542842,0,'Spawn Point 42 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056111,2542842,0,'Spawn Point 42 - Netherwing eggs (185915) - Netherwing Ledge'),

(121891,2542843,0,'Spawn Point 43 - Netherwing eggs (185915) - Netherwing Ledge'),
(2056112,2542843,0,'Spawn Point 43 - Netherwing eggs (185915) - Netherwing Ledge');

SET @ENTRY := 2542900;
DELETE FROM `pool_template`  WHERE `entry` BETWEEN 2542900 AND 2542999;
INSERT INTO `pool_template` VALUES
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121892 2056113
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121893 3372998
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121894 3373115
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121895 3372707
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121896 3372045
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121897 2056114
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121898 3372503
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121899 2056115
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121900 2056119  
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121901 2056116
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121902 2056117
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'), -- 121903 2056118
(@ENTRY := @ENTRY + '1', 2,'Netherwing eggs (185915) - Netherwing Mine'); -- 121904 3372273

SET @ENTRY := 2542900;
DELETE FROM `pool_pool` WHERE `mother_pool` = 25429;
INSERT INTO `pool_pool` VALUES
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 1 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 2 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 3 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 4 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 5 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 6 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 7 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 8 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 9 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 10 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 11 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 12 - Netherwing eggs (185915) - Netherwing Mine'),
(@ENTRY := @ENTRY + '1',25429,0,'Spawn Point 13 - Netherwing eggs (185915) - Netherwing Mine');

DELETE FROM `pool_gameobject` WHERE `guid` IN (2056113, 3372998, 3373115, 3372707, 3372045, 2056114, 3372503, 2056115, 2056119, 2056116, 2056117, 2056118, 3372273);
DELETE FROM `pool_gameobject` WHERE `guid` BETWEEN 121892 AND 121904;
INSERT INTO `pool_gameobject` VALUES
(121892,2542901,0,'Spawn Point 1 - Netherwing eggs (185915) - Netherwing Mine'),  
(2056113,2542901,0,'Spawn Point 1 - Netherwing eggs (185915) - Netherwing Mine'),

(121893,2542901,0,'Spawn Point 2 - Netherwing eggs (185915) - Netherwing Mine'),  
(3372998,2542901,0,'Spawn Point 2 - Netherwing eggs (185915) - Netherwing Mine'),

(121894,2542901,0,'Spawn Point 3 - Netherwing eggs (185915) - Netherwing Mine'),  
(3373115,2542901,0,'Spawn Point 3 - Netherwing eggs (185915) - Netherwing Mine'),

(121895,2542901,0,'Spawn Point 4 - Netherwing eggs (185915) - Netherwing Mine'),  
(3372707,2542901,0,'Spawn Point 4 - Netherwing eggs (185915) - Netherwing Mine'),

(121896,2542901,0,'Spawn Point 5 - Netherwing eggs (185915) - Netherwing Mine'),  
(3372045,2542901,0,'Spawn Point 5 - Netherwing eggs (185915) - Netherwing Mine'),

(121897,2542901,0,'Spawn Point 6 - Netherwing eggs (185915) - Netherwing Mine'),
(2056114,2542901,0,'Spawn Point 6 - Netherwing eggs (185915) - Netherwing Mine'),

(121898,2542901,0,'Spawn Point 7 - Netherwing eggs (185915) - Netherwing Mine'),  
(3372503,2542901,0,'Spawn Point 7 - Netherwing eggs (185915) - Netherwing Mine'),

(121899,2542901,0,'Spawn Point 8 - Netherwing eggs (185915) - Netherwing Mine'),  
(2056115,2542901,0,'Spawn Point 8 - Netherwing eggs (185915) - Netherwing Mine'),

(121900,2542901,0,'Spawn Point 9 - Netherwing eggs (185915) - Netherwing Mine'),  
(2056119,2542901,0,'Spawn Point 9 - Netherwing eggs (185915) - Netherwing Mine'),

(121901,2542901,0,'Spawn Point 10 - Netherwing eggs (185915) - Netherwing Mine'),  
(2056116,2542901,0,'Spawn Point 10 - Netherwing eggs (185915) - Netherwing Mine'),

(121902,2542901,0,'Spawn Point 11 - Netherwing eggs (185915) - Netherwing Mine'),  
(2056117,2542901,0,'Spawn Point 11 - Netherwing eggs (185915) - Netherwing Mine'),

(121903,2542901,0,'Spawn Point 12 - Netherwing eggs (185915) - Netherwing Mine'),  
(2056118,2542901,0,'Spawn Point 12 - Netherwing eggs (185915) - Netherwing Mine'),

(121904,2542901,0,'Spawn Point 13 - Netherwing eggs (185915) - Netherwing Mine'),  
(3372273,2542901,0,'Spawn Point 13 - Netherwing eggs (185915) - Netherwing Mine');

SET @GUID := 77645;
UPDATE `creature` SET `position_x`='-4099.6796', `position_y`='980.0801', `position_z`='25.4651', `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (77645, 1, -4100.05, 969.276, 24.9571, 12000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 2, -4104.06, 931.187, 18.8469, 1000, 0, 0, 100, 0); -- 2211301
INSERT INTO `waypoint_data` VALUES (77645, 3, -4105.65, 911.224, 16.1353, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 4, -4106.05, 889.833, 14.4649, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 5, -4118.47, 857.928, 8.29486, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 6, -4122.4, 839.518, 10.4151, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 7, -4143.45, 803.2, 9.22043, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 8, -4150.96, 769.769, 6.31908, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 9, -4153.1, 760.191, 3.47747, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 10, -4155.08, 747.368, 1.8985, 4000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 11, -4151.37, 769.929, 6.42453, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 12, -4132.84, 797.355, 8.16607, 1000, 0, 0, 100, 0); -- 2211301
INSERT INTO `waypoint_data` VALUES (77645, 13, -4137.32, 823.672, 9.68296, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 14, -4119.16, 842.164, 9.89524, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 15, -4115.26, 851.276, 7.68533, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 16, -4109.66, 883.088, 13.8876, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 17, -4110.74, 914.769, 17.723, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (77645, 18, -4106.89, 948.026, 23.0078, 0, 0, 0, 100, 0);

DELETE FROM `game_event_creature` WHERE `guid` IN (370547,353884,368102,367827,62847,400425,211996,87031,91284,91966,91904,187355,187577,189324,530787,209093,388031,388050,209319,356613,369855,369648,364100,364257,370616,1517096);
INSERT INTO `game_event_creature` VALUES
(91966,36),
(91904,36),
(87031,36),
(91284,36),

(400425,38),
(211996,38),
(209093,38),
(388031,38),
(388050,38),
(209319,38),
(356613,38),
(369855,38),
(369648,38),
(364100,38),
(364257,38),
(370616,38),

(530787,40),
(189324,40),
(187577,40),
(187355,40),
(1517096,40),

(353884,42),
(367827,42),
(368102,42),
(370547,42),
(62847,42);

UPDATE `creature` SET `position_x`='12066.5791', `position_y`='-7073.8828', `position_z`='34.1287' WHERE `guid` = 94354;
UPDATE `creature` SET `position_x`='12066.5791', `position_y`='-7073.8828', `position_z`='34.1287' WHERE `guid` = 94353; 
UPDATE `creature` SET `position_x`='11953.3154', `position_y`='-7070.2392', `position_z`='35.2994' WHERE `guid` = 94352; 
UPDATE `creature` SET `position_x`='11886.3730', `position_y`='-7071.4599', `position_z`='26.9276' WHERE `guid` = 94351; 
UPDATE `creature` SET `position_x`='11886.3730', `position_y`='-7071.4599', `position_z`='26.9276' WHERE `guid` = 94350; 
UPDATE `creature` SET `position_x`='11747.9433', `position_y`='-7066.7905', `position_z`='25.0627' WHERE `guid` = 94349;

UPDATE `creature` SET `position_x`='11738.5761', `position_y`='-7083.0727', `position_z`='82.7448' WHERE `guid` = 94206; 
UPDATE `creature` SET `position_x`='11739.6064', `position_y`='-7073.7177', `position_z`='82.0511' WHERE `guid` = 94207;
UPDATE `creature` SET `position_x`='11766.9101', `position_y`='-7107.2666', `position_z`='56.0602' WHERE `guid` = 94208; 
UPDATE `creature` SET `position_x`='11774.8212', `position_y`='-7034.1293', `position_z`='54.3281' WHERE `guid` = 94209; 
UPDATE `creature` SET `position_x`='11836.1855', `position_y`='-7017.4985', `position_z`='66.8179' WHERE `guid` = 94210; 
UPDATE `creature` SET `position_x`='12049.0712', `position_y`='-7043.2167', `position_z`='48.5350' WHERE `guid` = 94211; 
UPDATE `creature` SET `position_x`='12043.1503', `position_y`='-7042.4013', `position_z`='48.5350' WHERE `guid` = 94212; 
UPDATE `creature` SET `position_x`='11839.7294', `position_y`='-7066.2348', `position_z`='78.5018' WHERE `guid` = 94213; 
UPDATE `creature` SET `position_x`='11839.4902', `position_y`='-7121.5043', `position_z`='80.4658' WHERE `guid` = 94214;
UPDATE `creature` SET `position_x`='11838.8281', `position_y`='-7135.9887', `position_z`='80.4634' WHERE `guid` = 94215;

UPDATE `creature` SET `position_x`='11787.1162', `position_y`='-7127.5444', `position_z`='66.8178' WHERE `guid` = 94240;
UPDATE `creature` SET `position_x`='11792.9287', `position_y`='-7127.6166', `position_z`='66.8178' WHERE `guid` = 94239;
UPDATE `creature` SET `position_x`='11840.9873', `position_y`='-7027.8911', `position_z`='67.0977' WHERE `guid` = 94238;
UPDATE `creature` SET `position_x`='11777.3388', `position_y`='-7094.7705', `position_z`='55.3071' WHERE `guid` = 94237;
UPDATE `creature` SET `position_x`='11783.3886', `position_y`='-7029.5263', `position_z`='54.5822' WHERE `guid` = 94236;

DELETE FROM `creature` WHERE `guid` IN (85370,85372,85373,85374);
INSERT INTO `creature` VALUES (85370, 25144, 530, 1, 18017, 0, 12449.2, -7358.39, 44.3258, 3.08487, 25, 0, 0, 660, 2620, 0, 2);
SET @GUID := 85370;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,19259,0,0,4097,0,33555456,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85370, 1, 12449.2, -7358.39, 44.3258, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 2, 12370.9, -7351.95, 40.2274, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 3, 12181.9, -7332.79, 32.9732, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 4, 12079.5, -7333.08, 29.6892, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 5, 11945.6, -7333.31, 36.6114, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 6, 11821.6, -7329.77, 126.591, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 7, 11954, -7344.8, 46.8962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 8, 12159.1, -7319.16, 33.8095, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 9, 12335, -7348.21, 37.7652, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85370, 10, 12565.5, -7330.68, 32.9106, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (85372, 25144, 530, 1, 18016, 0, 12451.9, -7358.55, 45.8779, 3.08487, 25, 0, 0, 660, 2620, 0, 2);
SET @GUID := 85372;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,19259,0,0,4097,0,33555456,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85372, 1, 12451.9, -7358.55, 45.8779, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 2, 12379.7, -7352.8, 41.999, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 3, 12187.5, -7333.35, 33.5723, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 4, 12082.5, -7332.41, 30.0478, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 5, 11949.9, -7333.76, 37.1091, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 6, 11824.4, -7329.57, 126.651, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 7, 11950.4, -7345.15, 48.2738, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 8, 12155.2, -7319.07, 34.0378, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 9, 12330.7, -7348.44, 38.2629, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85372, 10, 12563.3, -7330.91, 33.1633, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (85373, 25144, 530, 1, 18016, 0, 12454.9, -7358.72, 45.6095, 3.08487, 25, 0, 0, 660, 2620, 0, 2);
SET @GUID := 85373;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,19259,0,0,4097,0,33555456,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85373, 1, 12454.9, -7358.72, 45.6095, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 2, 12383.6, -7353.18, 42.782, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 3, 12191.7, -7333.77, 34.0177, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 4, 12085.1, -7331.83, 30.3594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 5, 11954.3, -7334.23, 37.635, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 6, 11826.3, -7329.44, 126.694, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 7, 11948.1, -7345.37, 49.1335, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 8, 12152.9, -7319.02, 34.1693, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 9, 12328.1, -7348.58, 38.5673, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85373, 10, 12561.7, -7331.08, 33.3498, 0, 0, 0, 0, 0);

INSERT INTO `creature` VALUES (85374, 25144, 530, 1, 0, 0, 12457.3, -7358.86, 46.2379, 3.08487, 25, 0, 0, 660, 2620, 0, 2);
SET @GUID := 85374;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,19259,0,0,4097,0,33555456,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (85374, 1, 12457.3, -7358.86, 46.2379, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 2, 12387.6, -7353.56, 43.5774, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 3, 12194.8, -7334.08, 34.3445, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 4, 12089.6, -7330.84, 30.8936, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 5, 11957.3, -7334.55, 37.9837, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 6, 11828.5, -7329.29, 126.742, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 7, 11944.6, -7345.69, 50.4382, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 8, 12150.8, -7318.98, 34.2945, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 9, 12325.4, -7348.72, 38.8826, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (85374, 10, 12560, -7331.26, 33.549, 0, 0, 0, 0, 0);

DELETE FROM `gameobject_questrelation` WHERE `quest` = 10781;
INSERT INTO `gameobject_questrelation` VALUES (185126,10781);

-- ***----------------------------------------------------------***
--                     Honor Hold
--  https://github.com/Looking4Group/L4G_Core/issues/1669
-- ***----------------------------------------------------------***

-- ----------------------------------------------------------
-- Misc
-- ----------------------------------------------------------
-- Honor Hold Scout 20238
UPDATE `creature_template` SET `AIName`='EventAI',`flags_extra`='0',`type_flags`='4096' WHERE `entry` = 20238; -- 0 0
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20238;
INSERT INTO `creature_ai_scripts` VALUES
('2023801','20238','10','0','50','1','0','15','5000','10000','11','35063','0','0','24','0','0','0','0','0','0','0','Honor Hold Scout - Shoot OOC on Dummy & Reset'),
('2023802','20238','10','0','50','1','0','15','5000','10000','11','35097','0','0','24','0','0','0','0','0','0','0','Honor Hold Scout - Shoot OOC on Dummy & Reset');

-- Honor Hold Archer 16896
UPDATE `creature_template` SET `AIName`='EventAI',`unit_flags`='4096',`flags_extra`='2' WHERE `entry` = 16896; -- 0 0
UPDATE `creature_template_addon` SET `bytes0`='16777472',`bytes2`='4098' WHERE `entry` IN ('16896');
DELETE FROM `creature_ai_scripts` WHERE `id` BETWEEN 1689601 AND 1689604;
INSERT INTO `creature_ai_scripts` VALUES
('1689601','-58449','1','0','75','1','0','5000','5000','10000','11','29120','0','0','24','0','0','0','0','0','0','0','Honor Hold Archer - Shoot OOC on Dummy & Reset'),
('1689602','-58451','1','0','75','1','0','5000','5000','10000','11','29120','0','0','24','0','0','0','0','0','0','0','Honor Hold Archer - Shoot OOC on Dummy & Reset'),
('1689603','-58450','1','0','75','1','0','5000','5000','10000','11','29120','0','0','24','0','0','0','0','0','0','0','Honor Hold Archer - Shoot OOC on Dummy & Reset'),
('1689604','-58454','1','0','75','1','0','5000','5000','10000','11','29120','0','0','24','0','0','0','0','0','0','0','Honor Hold Archer - Shoot OOC on Dummy & Reset');

DELETE FROM `creature_addon` WHERE `guid` IN (58449,58450,58451,58454);
INSERT INTO `creature_addon` VALUES
(58449,0,0,16777472,0,4098,376,0,''),
(58450,0,0,16777472,0,4098,376,0,''),
(58451,0,0,16777472,0,4098,376,0,''),
(58454,0,0,16777472,0,4098,376,0,'');

DELETE FROM `spell_script_target` WHERE `entry` = 29120 AND `targetentry` = 19376;
INSERT INTO `spell_script_target` VALUES
(29120,1,19376);

UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid`=72637; -- Honor hold defender
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid`=57946; -- Honor hold defender
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid`=57947; -- Honor hold defender
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid`=57882; -- Master Sergeant Lorin Thalmerok
UPDATE `creature` SET `position_x`='-668.5441', `position_y`='2755.5187', `position_z`='93.8881', `spawndist`=2.5,`MovementType`=1 WHERE `guid`=58435; -- War horse

-- horses nonattackable
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|2 WHERE `entry` = 16884;

UPDATE `creature_addon` SET `bytes1`=1 WHERE `guid`=30752; -- Brumman - Sit


DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16825;
INSERT INTO `creature_ai_scripts` VALUES
('1682501','16825','1','0','100','1','3000','10000','3000','10000','5','92','0','0','0','0','0','0','0','0','0','0','Father Malgor Devidicus - Drink animation'); -- 46583
-- ----------------------------------------------------------
-- Honor Hold Defenders
-- ----------------------------------------------------------
-- Update weapons for all Honor Hold Defenders. Was hard to find 100% information on this. Old values: 1: 5163. 2: 18700
UPDATE `creature_equip_template` SET `equipmodel1`=5163, `equipmodel2`=18700, `equipinfo2`=33490436, `equipslot2`=1038 WHERE  `entry`=368;

-- Outhouse guard GUID: 57942
-- Had to create a new creature template, since this npc has a gossip menu, and that can only be enabled in a template.
DELETE FROM `creature_equip_template` WHERE `entry` = 23685;
INSERT INTO `creature_equip_template` (`entry`, `equipinfo1`, `equipinfo2`, `equipslot1`, `equipslot2`) VALUES (23685, 33490690, 33490690, 781, 781);
DELETE FROM `creature_template` WHERE `entry` = 77780;
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `subname`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(77780, 0, 16387, 16388, 16387, 16388, 'Honor Hold Defender', '', 68, 68, 7716, 7716, 0, 0, 5200, 1666, 1666, 1, 1.2, 1, 0, 214, 267, 0, 4689, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 277.043, 392.769, 100, 7, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 1, 3, 0, 1, 23685, 0, 0, '');

DELETE FROM `db_script_string` WHERE `entry` BETWEEN 2000000004 AND 2000000007;
INSERT INTO `db_script_string` (`entry`,`content_default`) VALUES 
(2000000004,'Do ya want me to call a medic? Maybe a priest? It''s been over an hour, mate!'),
(2000000005,'So help me, I''m gonna count to ten and if yer not outta there by the time I reach 10, I''m comin'' in!'),
(2000000006,'What''s goin'' on in there?? For the love of the LIGHT, hurry it up!'),
(2000000007,'OY! You in there, this is official Honor Hold business yer holdin'' up!');

DELETE FROM `waypoint_scripts` WHERE `id` BETWEEN 5794201 AND 5794205;
INSERT INTO `waypoint_scripts` (`id`,`delay`,`dataint`,`guid`,`comment`) VALUES
(5794201,0,2000000004,5794201,'Outhouse Honor Hold Guard Text1'),
(5794202,0,2000000005,5794202,'Outhouse Honor Hold Guard Text2'),
(5794203,0,2000000006,5794203,'Outhouse Honor Hold Guard Text3'),
(5794204,0,2000000007,5794204,'Outhouse Honor Hold Guard Text4');
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`guid`,`comment`) VALUES
(5794205,0,1,5,0,0,5794205,'Outhouse Honor Hold Guard - Exclamation emote');

DELETE FROM `npc_text` WHERE `id` = 4;
INSERT INTO `npc_text` (`id`,`text0_0`,`text0_1`,`em0_0`,`em0_1`) VALUES
(4,'OY! Wait in line, would ya? Outland food doesn''t agree with me at all.','OY! Wait in line, would ya? Outland food doesn''t agree with me at all.',5,5);

DELETE FROM `npc_gossip` WHERE `npc_guid` = 57942;
INSERT INTO `npc_gossip` VALUES
(57942,4);

-- Pathing for  Entry: 16821 'TDB FORMAT' 
SET @GUID := 57942;
SET @POINT := 0;
UPDATE `creature` SET `id`=77780,`spawndist`=0,`MovementType`=2,`position_x`=-724.872,`position_y`=2722.862,`position_z`=95.62754 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:00
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:02
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:04
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:05
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:07
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:09
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:10
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:11
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:13
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:14
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:16
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:18
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:19
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:21
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:22
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:22
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,0,0,5794201,100,0), -- Text
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,15000,0,5794205,100,0), -- Exclamation emote
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:51:44
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:51:45
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:51:46
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:51:48
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:51:50
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:51:51
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:51:53
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:51:54
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:54
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:56
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:51:58
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:51:59
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:01
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:03
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:04
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:06
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:08
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:09
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:11
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:12
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:14
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:15
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:17
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:19
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:20
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:22
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:24
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:25
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:25
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,0,0,5794202,100,0), -- Text
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,15000,0,5794205,100,0), -- Exclamation emote
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:52:47
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:52:48
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:52:50
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:52:51
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:52:53
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:52:54
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:52:56
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:52:58
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:52:58
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:52:59
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:01
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:03
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:04
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:06
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:07
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:09
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:11
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:13
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:14
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:16
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:17
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:19
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:21
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:22
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:24
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:26
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:27
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:53:29
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:53:29
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,0,0,5794203,100,0), -- Text
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,15000,0,5794205,100,0), -- Exclamation emote
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:53:51
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:53:52
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:53:53
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:53:55
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:53:57
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:53:58
(@GUID,@POINT := @POINT + '1',-724.8216,2722.722,95.61582,250,0,0,100,0), -- 14:54:00
(@GUID,@POINT := @POINT + '1',-724.1487,2726.587,95.32871,250,0,0,100,0), -- 14:54:01
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:01
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:03
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:05
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:06
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:08
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:09
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:11
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:13
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:14
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:16
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:18
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:19
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:21
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:22
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:24
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:26
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:27
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:29
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:31
(@GUID,@POINT := @POINT + '1',-724.872,2722.862,95.62754,250,0,0,100,0), -- 14:54:32
(@GUID,@POINT := @POINT + '1',-724.4536,2725.909,95.40195,250,0,0,100,0), -- 14:54:32
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,0,0,5794204,100,0), -- Text
(@GUID,@POINT := @POINT + '1',-725.5215,2724.479,95.6583,15000,0,5794205,100,0); -- Exclamation emote

DELETE FROM `creature` WHERE `guid` IN (57941,100049);
INSERT INTO `creature` VALUES (57941, 16842, 530, 1, 0, 0, -659.3486, 2767.7260, 88.4945, 2.9157, 300, 0, 0, 6600, 0, 0, 0);
INSERT INTO `creature` VALUES (100049, 16842, 530, 1, 0, 0, -750.228, 2716.35, 111.868, 5.25344, 300, 0, 0, 6600, 0, 0, 0);

SET @GUID := 57948; -- Need formation member
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-659.241577,`position_y`=2764.013184,`position_z`=89.648140 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-659.241577,2764.013184,89.648140,500,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-676.385315,2769.760254,93.590286,500,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-693.940857,2767.547607,95.120773,500,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-676.385315,2769.760254,93.590286,500,0,0,100,0); 

DELETE FROM `creature_formations` WHERE `leaderGUID`= 57948;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(57948,57948,0,0,2),
(57948,57941,3,0,2);

-- Pathing for  Entry: 16842 'TDB FORMAT' 
SET @GUID := 57943; -- member 57944
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-729.6794,`position_y`=2657.958,`position_z`=95.2814 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-729.6794,2657.958,95.2814,0,0,0,100,0), -- 23:40:32
(@GUID,2,-725.9243,2657.444,94.29301,0,0,0,100,0), -- 23:40:36
(@GUID,3,-712.4608,2637.426,91.97912,0,0,0,100,0), -- 23:40:40
(@GUID,4,-696.0266,2633.286,90.51183,0,0,0,100,0), -- 23:40:47
(@GUID,5,-681.8851,2640.387,89.54575,0,0,0,100,0), -- 23:40:54
(@GUID,6,-678.4524,2642.606,89.3196,0,0,0,100,0), -- 23:41:01
(@GUID,7,-676.4327,2655.729,89.65163,0,0,0,100,0), -- 23:41:06
(@GUID,8,-686.6949,2675.069,91.69751,0,0,0,100,0), -- 23:41:11
(@GUID,9,-695.3953,2678.214,93.53847,0,0,0,100,0), -- 23:41:16
(@GUID,10,-715.9707,2676.224,95.10616,0,0,0,100,0), -- 23:41:22
(@GUID,11,-720.6448,2670.696,94.86513,0,0,0,100,0), -- 23:41:29
(@GUID,12,-724.7706,2663.015,94.51012,0,0,0,100,0), -- 23:41:34
(@GUID,13,-732.2354,2660.108,95.79332,0,0,0,100,0), -- 23:41:37
(@GUID,14,-743.7416,2658.196,99.50706,0,0,0,100,0), -- 23:41:39
(@GUID,15,-753.4407,2652.986,104.7612,0,0,0,100,0), -- 23:41:45
(@GUID,16,-760.7173,2650.15,108.0609,0,0,0,100,0), -- 23:41:49
(@GUID,17,-763.5579,2646.074,108.1835,0,0,0,100,0), -- 23:41:54
(@GUID,18,-774.3285,2638.794,108.1835,0,0,0,100,0), -- 23:42:00
(@GUID,19,-751.5222,2652.918,104.1722,0,0,0,100,0), -- 23:42:06
(@GUID,20,-734.8468,2657.947,96.88486,0,0,0,100,0); -- 23:42:12
-- (@GUID,21,-729.4844,2657.844,95.13605,0,0,0,100,0), -- 23:42:20
-- (@GUID,22,-725.9483,2657.54,94.23397,0,0,0,100,0), -- 23:42:23
-- (@GUID,23,-712.3545,2637.408,91.95067,0,0,0,100,0); -- 23:42:28
-- 0x203CCC42401072800031F9000001410D .go -729.6794 2657.958 95.2814

DELETE FROM `creature_formations` WHERE `leaderGUID`=57943;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(57943,57943,0,0,2),
(57943,57944,3,0,2);
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-729.6794,`position_y`=2657.958,`position_z`=95.2814 WHERE `guid`=57944;
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` = 57944;

-- Pathing for  Entry: 16842 'TDB FORMAT' 
SET @GUID := 57923;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-867.476,`position_y`=2718.552,`position_z`=69.17674 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,1,-867.476,2718.552,69.17674,0,0,0,100,0), -- 00:54:49
(@GUID,2,-867.5676,2699.178,79.64346,0,0,0,100,0), -- 00:54:59
(@GUID,3,-858.116,2686.463,88.44569,0,0,0,100,0), -- 00:55:08
(@GUID,4,-842.5492,2678.867,95.29387,0,0,0,100,0), -- 00:55:15
(@GUID,5,-822.5157,2681.53,102.3271,0,0,0,100,0), -- 00:55:23
(@GUID,6,-817.6292,2683.223,103.6337,0,0,0,100,0), -- 00:55:32
(@GUID,7,-817.5452,2683.404,103.4257,0,0,0,100,0), -- 00:55:37
(@GUID,8,-838.7524,2678.115,96.79544,0,0,0,100,0), -- 00:55:39
(@GUID,9,-856.3284,2684.984,89.34355,0,0,0,100,0), -- 00:55:48
(@GUID,10,-867.1521,2697.494,80.28738,0,0,0,100,0), -- 00:55:56
(@GUID,11,-867.6529,2713.841,71.40306,0,0,0,100,0), -- 00:56:04
(@GUID,12,-865.4053,2736.819,58.58712,0,0,0,100,0), -- 00:56:12
(@GUID,13,-866.5761,2765.043,41.56224,0,0,0,100,0), -- 00:56:22
(@GUID,14,-872.1741,2769.334,37.38614,0,0,0,100,0), -- 00:56:35
(@GUID,15,-869.7395,2768.148,39.13062,0,0,0,100,0), -- 00:56:41
(@GUID,16,-865.277,2739.819,56.70834,0,0,0,100,0); -- 00:56:44
-- 0x203CCC42401072800031F9000101574B .go -867.476 2718.552 69.17674
DELETE FROM `creature_formations` WHERE `leaderGUID`=57923;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(57923,57923,0,0,2),
(57923,57937,3,4.7,2);
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-867.476,`position_y`=2718.552,`position_z`=69.17674 WHERE `guid`=57937;
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` = 57937;

-- Pathing for  Entry: 16842 'TDB FORMAT' 
SET @GUID := 57951;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-687.996,`position_y`=2675.259,`position_z`=92.00164 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-687.996,2675.259,92.00164,0,0,0,100,0), -- 00:56:54
(@GUID,@POINT := @POINT + '1',-694.5895,2679.407,93.47656,0,0,0,100,0), -- 00:57:00
(@GUID,@POINT := @POINT + '1',-699.2542,2681.575,94.0282,0,0,0,100,0), -- 00:57:04
(@GUID,@POINT := @POINT + '1',-709.6293,2702.073,94.66191,0,0,0,100,0), -- 00:57:07
(@GUID,@POINT := @POINT + '1',-709.9301,2704.808,94.83853,0,0,0,100,0), -- 00:57:13
-- (@GUID,@POINT := @POINT + '1',-705.7255,2710.611,95.50642,0,0,0,100,0), -- 00:57:17
(@GUID,@POINT := @POINT + '1',-709.663208,2714.1892,94.7226,0,0,0,100,0), -- 00:57:24 --C
(@GUID,@POINT := @POINT + '1',-700.4745,2712.623,94.98143,0,0,0,100,0), -- 00:57:35
(@GUID,@POINT := @POINT + '1',-703.2124,2713.111,94.98071,0,0,0,100,0), -- 00:57:36
(@GUID,@POINT := @POINT + '1',-710.6580,2712.3549,94.7205,0,0,0,100,0), -- 00:57:38 --C
(@GUID,@POINT := @POINT + '1',-710.7588,2702.815,94.6216,0,0,0,100,0), -- 00:57:39
(@GUID,@POINT := @POINT + '1',-707.4856,2689.286,94.33665,0,0,0,100,0), -- 00:57:44
(@GUID,@POINT := @POINT + '1',-706.4232,2686.263,94.17517,0,0,0,100,0), -- 00:57:50
(@GUID,@POINT := @POINT + '1',-694.9254,2679.296,93.42561,0,0,0,100,0), -- 00:57:52
(@GUID,@POINT := @POINT + '1',-679.5647,2669.552,90.44455,0,0,0,100,0), -- 00:57:57
(@GUID,@POINT := @POINT + '1',-678.5782,2668.9,89.83815,0,0,0,100,0), -- 00:58:03
(@GUID,@POINT := @POINT + '1',-662.3951,2684.631,88.87974,0,0,0,100,0), -- 00:58:08
(@GUID,@POINT := @POINT + '1',-650.7223,2700.149,87.90611,0,0,0,100,0), -- 00:58:16
(@GUID,@POINT := @POINT + '1',-642.0238,2715.182,86.90927,0,0,0,100,0), -- 00:58:24
(@GUID,@POINT := @POINT + '1',-640.7755,2717.258,86.57317,0,0,0,100,0), -- 00:58:29
(@GUID,@POINT := @POINT + '1',-634.3006,2732.866,85.51468,0,0,0,100,0), -- 00:58:31
(@GUID,@POINT := @POINT + '1',-616.3732,2751.199,83.35973,0,0,0,100,0), -- 00:58:40
(@GUID,@POINT := @POINT + '1',-605.2081,2765.297,78.54527,0,0,0,100,0), -- 00:58:47
(@GUID,@POINT := @POINT + '1',-596.5933,2784.522,72.0435,0,0,0,100,0), -- 00:58:54
(@GUID,@POINT := @POINT + '1',-591.5787,2803.707,66.74985,0,0,0,100,0), -- 00:59:03
(@GUID,@POINT := @POINT + '1',-590.4258,2822.456,61.94441,0,0,0,100,0), -- 00:59:11
(@GUID,@POINT := @POINT + '1',-592.53,2835.081,59.69307,0,0,0,100,0), -- 00:59:20
(@GUID,@POINT := @POINT + '1',-596.1635,2847.102,58.09987,0,0,0,100,0), -- 00:59:26
(@GUID,@POINT := @POINT + '1',-597.4973,2850.567,57.33707,0,0,0,100,0), -- 00:59:31
(@GUID,@POINT := @POINT + '1',-592.5145,2859.644,57.5414,0,0,0,100,0), -- 00:59:34
(@GUID,@POINT := @POINT + '1',-610.3804,2871.98,54.83242,0,0,0,100,0), -- 00:59:37
(@GUID,@POINT := @POINT + '1',-639.1476,2874.169,50.74456,0,0,0,100,0), -- 00:59:45
(@GUID,@POINT := @POINT + '1',-647.4047,2872.841,49.71684,0,0,0,100,0), -- 00:59:57
(@GUID,@POINT := @POINT + '1',-657.5587,2869.095,49.19283,0,0,0,100,0), -- 01:00:05
(@GUID,@POINT := @POINT + '1',-629.851,2864.712,51.55709,0,0,0,100,0), -- 01:00:06
(@GUID,@POINT := @POINT + '1',-611.9828,2858.52,55.30186,0,0,0,100,0), -- 01:00:18
(@GUID,@POINT := @POINT + '1',-601.4695,2847.149,57.85207,0,0,0,100,0), -- 01:00:25
(@GUID,@POINT := @POINT + '1',-594.7114,2832.047,60.31672,0,0,0,100,0), -- 01:00:31
(@GUID,@POINT := @POINT + '1',-592.8293,2814.866,64.0257,0,0,0,100,0), -- 01:00:38
(@GUID,@POINT := @POINT + '1',-597.939,2791.476,70.42447,0,0,0,100,0), -- 01:00:45
(@GUID,@POINT := @POINT + '1',-606.717,2767.088,77.95975,0,0,0,100,0), -- 01:00:55
(@GUID,@POINT := @POINT + '1',-614.9818,2755.868,82.00406,0,0,0,100,0), -- 01:01:05
(@GUID,@POINT := @POINT + '1',-623.3367,2746.366,84.40461,0,0,0,100,0), -- 01:01:12
(@GUID,@POINT := @POINT + '1',-635.1954,2732.008,85.72681,0,0,0,100,0), -- 01:01:19
(@GUID,@POINT := @POINT + '1',-642.4907,2714.986,86.78146,0,0,0,100,0), -- 01:01:26
(@GUID,@POINT := @POINT + '1',-649.691,2702.885,87.69963,0,0,0,100,0), -- 01:01:32
(@GUID,@POINT := @POINT + '1',-654.83,2695.69,88.33471,0,0,0,100,0), -- 01:01:38
(@GUID,@POINT := @POINT + '1',-666.5414,2681.097,89.36565,0,0,0,100,0), -- 01:01:43
(@GUID,@POINT := @POINT + '1',-677.8886,2669.907,90.08049,0,0,0,100,0); -- 01:01:49
-- (@GUID,@POINT := @POINT + '1',-687.9769,2675.258,91.98616,0,0,0,100,0), -- 01:01:55
-- (@GUID,@POINT := @POINT + '1',-694.5687,2679.423,93.65937,0,0,0,100,0), -- 01:02:01
-- (@GUID,@POINT := @POINT + '1',-699.1838,2681.686,94.00005,0,0,0,100,0), -- 01:02:05
-- (@GUID,@POINT := @POINT + '1',-709.6846,2702.062,94.65549,0,0,0,100,0), -- 01:02:09
-- (@GUID,@POINT := @POINT + '1',-708.156,2711.113,95.01352,0,0,0,100,0); -- 01:02:26
-- 0x203CCC42401072800031F900000160EE .go -687.996 2675.259 92.00164
DELETE FROM `creature_formations` WHERE `leaderGUID`=57951;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(57951,57951,0,0,2),
(57951,57952,3,0,2);
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-687.996,`position_y`=2675.259,`position_z`=92.00164 WHERE `guid`=57952;
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` = 57952;

-- ----------------------------------------------------------
-- Honor Hold Archers
-- ----------------------------------------------------------

DELETE FROM `creature` WHERE `guid` = 31939;
INSERT INTO `creature` VALUES (31939, 4026, 1, 1, 10282, 0, 898.094, 1564.78, -16.8351, 6.02495, 300, 15, 0, 582, 618, 0, 1);

SET @GUID := 58441;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-778.086792,`position_y`=2611.213379,`position_z`=133.253265 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-778.086792,2611.213379,133.253265,500,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-794.580505,2601.480469,133.253265,500,0,0,100,0); 

SET @GUID := 58440;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-816.596924,`position_y`=2638.899902,`position_z`=133.253357 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-816.596924,2638.899902,133.253357,500,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-802.575134,2647.312988,133.253357,500,0,0,100,0); 

SET @GUID := 58448;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-684.023132,`position_y`=2574.477539,`position_z`=100.586746 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-684.023132,2574.477539,100.586746,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-697.688110,2571.345703,100.598846,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-696.135071,2564.149170,100.609314,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-680.653442,2567.783447,100.623665,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-696.135071,2564.149170,100.609314,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-697.688110,2571.345703,100.598846,0,0,0,100,0);

SET @GUID := 58442;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-764.784241,`position_y`=2575.985352,`position_z`=104.092911 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-764.784241,2575.985352,104.092911,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-733.677124,2567.583740,104.187248,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-734.555359,2563.964844,104.136047,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-765.734924,2572.005371,104.136047,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-734.555359,2563.964844,104.136047,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-733.677124,2567.583740,104.187248,0,0,0,100,0);

SET @GUID := 58453;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-615.481384,`position_y`=2607.880127,`position_z`=99.092003 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-615.481384,2607.880127,99.092003,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-603.260986,2615.532715,99.038170,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-606.086731,2619.775635,99.001106,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-618.218689,2611.881104,99.001846,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-606.086731,2619.775635,99.001106,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-603.260986,2615.532715,99.038170,0,0,0,100,0);

SET @GUID := 58452;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-679.087219,`position_y`=2782.460693,`position_z`=110.077003 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-679.087219,2782.460693,110.077003,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-648.031433,2770.963623,104.529289,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-645.291565,2776.596680,104.270088,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-677.481628,2787.628906,110.064980,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-645.291565,2776.596680,104.270088,0,0,0,100,0), 
(@GUID,@POINT := @POINT + '1',-648.031433,2770.963623,104.529289,0,0,0,100,0);

-- ----------------------------------------------------------
-- Stormwind cavalrymen
-- ----------------------------------------------------------

DELETE FROM `creature_formations` WHERE `leaderGUID`=57965;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(57965,57965,0,0,2),
(57965,57966,3,0,2),
(57965,57967,6,0,2),
(57965,57968,9,0,2);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '16843';
INSERT INTO `creature_ai_scripts` VALUES
('1684301','16843','4','0','100','0','0','0','0','0','0','0','0','0','17','154','0','0','19','134217728','0','0','Stormwind Cavalryman - Dismount on Aggro'),
('1684302','16843','7','0','100','0','0','0','0','0','43','17408','0','0','0','0','0','0','0','0','0','0','Stormwind Cavalryman - Mount on Evade');

UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-606.2551,`position_y`=2519.0322,`position_z`=67.1583 WHERE `guid`=57966;
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-606.2551,`position_y`=2519.0322,`position_z`=67.1583 WHERE `guid`=57967;
UPDATE `creature` SET `spawndist`=0,`MovementType`=0,`position_x`=-606.2551,`position_y`=2519.0322,`position_z`=67.1583 WHERE `guid`=57968;
DELETE FROM `creature_addon` WHERE `guid` BETWEEN 57966 AND 57968;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES 
(57966,0,2410,16843008,0,4097,0, ''),
(57967,0,2410,16843008,0,4097,0, ''),
(57968,0,2410,16843008,0,4097,0, '');

-- Pathing for  Entry: 16843 'TDB FORMAT' 
SET @GUID := 57965;
SET @POINT := 0;
UPDATE `creature_template` SET `speed`=2 WHERE `entry` = 16843;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-606.2551,`position_y`=2519.0322,`position_z`=67.1583 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,2410,16843008,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-603.8413,2468.978,57.24754,0,1,0,100,0), -- 02:10:26
(@GUID,@POINT := @POINT + '1',-604.4803,2435.139,50.4033,0,1,0,100,0), -- 02:10:29
(@GUID,@POINT := @POINT + '1',-599.3711,2409.698,44.90717,0,1,0,100,0), -- 02:10:31
(@GUID,@POINT := @POINT + '1',-584.9319,2406.705,43.84761,0,1,0,100,0), -- 02:10:33
(@GUID,@POINT := @POINT + '1',-582.3895,2430.362,47.80949,0,1,0,100,0), -- 02:10:34
(@GUID,@POINT := @POINT + '1',-582.2234,2463.364,54.12881,0,1,0,100,0), -- 02:10:36
(@GUID,@POINT := @POINT + '1',-583.6277,2498.37,61.37954,0,1,0,100,0), -- 02:10:37
(@GUID,@POINT := @POINT + '1',-558.1464,2532.389,67.1059,0,1,0,100,0), -- 02:10:40
(@GUID,@POINT := @POINT + '1',-524.2815,2553.872,65.78352,0,1,0,100,0), -- 02:10:42
(@GUID,@POINT := @POINT + '1',-505.6973,2594.282,68.3791,0,1,0,100,0), -- 02:10:46
(@GUID,@POINT := @POINT + '1',-504.4495,2604.855,70.36739,0,1,0,100,0), -- 02:10:48
(@GUID,@POINT := @POINT + '1',-509.9106,2664.477,70.11888,0,1,0,100,0), -- 02:10:51
(@GUID,@POINT := @POINT + '1',-511.2125,2694.753,68.72308,0,1,0,100,0), -- 02:10:53
(@GUID,@POINT := @POINT + '1',-517.1431,2716.786,67.86261,0,1,0,100,0), -- 02:10:54
(@GUID,@POINT := @POINT + '1',-534.4116,2747.668,69.11035,0,1,0,100,0), -- 02:10:57
(@GUID,@POINT := @POINT + '1',-565.2167,2807.088,63.10085,0,1,0,100,0), -- 02:10:59
(@GUID,@POINT := @POINT + '1',-596.0338,2836.992,59.53964,0,1,0,100,0), -- 02:11:03
(@GUID,@POINT := @POINT + '1',-614.9552,2858.75073,54.6820,0,1,0,100,0), -- 02:11:03 -- Added
(@GUID,@POINT := @POINT + '1',-630.5186,2866.889,51.23105,0,1,0,100,0), -- 02:11:05
(@GUID,@POINT := @POINT + '1',-678.2933,2883.322,47.20448,0,1,0,100,0), -- 02:11:08
(@GUID,@POINT := @POINT + '1',-697.3795,2884.9079,41.7335,0,1,0,100,0), -- 02:11:11
(@GUID,@POINT := @POINT + '1',-723.3648,2887.826,33.06394,0,1,0,100,0), -- 02:11:11
(@GUID,@POINT := @POINT + '1',-746.0063,2887.6555,27.1176,0,1,0,100,0), -- 02:11:11
(@GUID,@POINT := @POINT + '1',-762.1984,2886.511,24.12672,0,1,0,100,0), -- 02:11:14
(@GUID,@POINT := @POINT + '1',-792.9378,2863.699,21.6566,0,1,0,100,0), -- 02:11:16
(@GUID,@POINT := @POINT + '1',-819.9457,2843.082,18.99449,0,1,0,100,0), -- 02:11:20
(@GUID,@POINT := @POINT + '1',-873.9966,2815.336,15.86702,0,1,0,100,0), -- 02:11:22
(@GUID,@POINT := @POINT + '1',-894.1238,2802.419,14.53608,0,1,0,100,0), -- 02:11:26
(@GUID,@POINT := @POINT + '1',-897.1019,2770.831,21.08281,0,1,0,100,0), -- 02:11:27
(@GUID,@POINT := @POINT + '1',-867.1028,2775.519,38.11693,0,1,0,100,0), -- 02:11:30
(@GUID,@POINT := @POINT + '1',-860.3279,2762.119,45.57374,0,1,0,100,0), -- 02:11:31
(@GUID,@POINT := @POINT + '1',-869.2184,2737.057,57.95547,0,1,0,100,0), -- 02:11:32
(@GUID,@POINT := @POINT + '1',-871.6135,2701.309,78.26624,0,1,0,100,0), -- 02:11:35
(@GUID,@POINT := @POINT + '1',-856.28,2675.755,92.30522,0,1,0,100,0), -- 02:11:37
(@GUID,@POINT := @POINT + '1',-833.6925,2676.522,98.57971,0,1,0,100,0), -- 02:11:39
(@GUID,@POINT := @POINT + '1',-808.1074,2687.286,104.2635,0,1,0,100,0), -- 02:11:41
(@GUID,@POINT := @POINT + '1',-790.7687,2689.69,104.2749,0,1,0,100,0), -- 02:11:43
(@GUID,@POINT := @POINT + '1',-725.1459,2676.275,96.73329,0,1,0,100,0), -- 02:11:45
(@GUID,@POINT := @POINT + '1',-693.6385,2675.371,93.11407,0,1,0,100,0), -- 02:11:48
(@GUID,@POINT := @POINT + '1',-678.6763,2653.897,90.2196,0,1,0,100,0), -- 02:11:50
(@GUID,@POINT := @POINT + '1',-670.2182,2623.38,87.0732,0,1,0,100,0), -- 02:11:51
(@GUID,@POINT := @POINT + '1',-647.7286,2588.648,83.14568,0,1,0,100,0), -- 02:11:54
(@GUID,@POINT := @POINT + '1',-620.5898,2546.875,73.73161,0,1,0,100,0), -- 02:11:56
(@GUID,@POINT := @POINT + '1',-604.7241,2503.232,64.53005,0,1,0,100,0); -- 02:12:00
-- 0x203CD042401072C00000490000797476 .go -894.1846 2802.289 14.45487

-- ----------------------------------------------------------
-- Nethergarde Infantry Inside Inn
-- ----------------------------------------------------------
DELETE FROM `creature_template` WHERE `entry` = 16913;
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) 
VALUES (16913, 0, 16376, 0, 16376, 0, 'Nethergarde Infantry', 58, 60, 2900, 3900, 0, 0, 20, 1667, 1667, 0, 1.05, 1, 0, 17, 64, 0, 855, 2000, 0, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 100, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 1, 3, 0, 1, 23686, 0, 0, '');
DELETE FROM `creature_equip_template` WHERE `entry` = 23686;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipinfo1`, `equipinfo2`, `equipslot1`, `equipslot2`) VALUES (23686, 24594, 24117, 33492482, 218235906, 13, 7);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16913;
INSERT INTO `creature_ai_scripts` VALUES
('1691301','16913','1','0','100','1','3000','10000','3000','10000','5','92','0','0','0','0','0','0','0','0','0','0','Nethergarde Infantry - Drink animation'); -- 46583

UPDATE `creature` SET `id`=16913 WHERE `guid` IN (57896,57897,57898,57899);

-- ----------------------------------------------------------
-- Nethergarde/Stormwind Infantry
-- ----------------------------------------------------------
-- The way these NPCs work is that they have a 50/50 chance of being Stormwind/Nethergarde. However I can't think of any good way to implement that, so I will have to make them static :(

-- DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16831;
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('1683101','16831','11','0','100','0','0','0','0','0','3','16864','0','0','0','0','0','0','0','0','0','0','Nethergarde Infantry - 50% chance if being Stormwind Infantry instead.');
-- UPDATE `creature_template` SET `AIname` = 'EventAI' WHERE `entry` = 16831;

DELETE FROM `waypoint_scripts` WHERE `id` IN (1095, 5790402);
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`guid`,`comment`) VALUES
-- (5790401,1000,32,16164,0,0,0,0,0,5790401,'Nethergarde Infantry - Equip bottle');
(5790402,0,1,66,1,0,0,0,0,5790402,'Nethergarde Infantry - Salute Emote');

-- Boxes near gate.
-- Pathing for  Entry: 16831 'TDB FORMAT' 
SET @GUID := 57904;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-675.5676,`position_y`=2609.854,`position_z`=86.83054 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-676.6392,2606.2456,86.3983,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-676.6392,2606.2456,86.3983,2000,0,5790402,100,0), -- 17:19:23 -- Salute
(@GUID,@POINT := @POINT + '1',-679.1447,2609.0058,86.71082,120000,0,1069,100,0), -- 17:19:23 -- Use emote by boxes for 2 mins (120000)
(@GUID,@POINT := @POINT + '1',-679.1447,2609.0058,86.71082,0,0,1000,100,0), -- 17:19:23 -- Turn off emote
(@GUID,@POINT := @POINT + '1',-676.3438,2608.4021,86.4456,0,0,0,100,0), -- 17:19:23
(@GUID,@POINT := @POINT + '1',-673.6891,2610.629,86.79488,0,0,0,100,0), -- 17:19:24
(@GUID,@POINT := @POINT + '1',-676.3786,2619.2211,87.1581,0,0,0,100,0), -- 17:19:24 -- Added
(@GUID,@POINT := @POINT + '1',-702.3351,2632.415,90.65683,0,0,0,100,0), -- 17:19:35
(@GUID,@POINT := @POINT + '1',-710.6298,2636.448,91.78142,0,0,0,100,0), -- 17:19:41
(@GUID,@POINT := @POINT + '1',-721.761,2645.975,93.45092,0,0,0,100,0), -- 17:19:46
(@GUID,@POINT := @POINT + '1',-723.8354,2648.165,93.72618,0,0,0,100,0), -- 17:19:51
(@GUID,@POINT := @POINT + '1',-736.1548,2658.172,96.76268,0,0,0,100,0), -- 17:19:54
(@GUID,@POINT := @POINT + '1',-745.5068,2656.399,100.4888,0,0,0,100,0), -- 17:19:59
(@GUID,@POINT := @POINT + '1',-753.444,2652.021,105.0069,0,0,0,100,0), -- 17:20:03
(@GUID,@POINT := @POINT + '1',-759.5253,2648.16,108.0777,0,0,0,100,0), -- 17:20:08
(@GUID,@POINT := @POINT + '1',-762.7746,2645.629,108.1487,0,0,0,100,0), -- 17:20:12
(@GUID,@POINT := @POINT + '1',-781.6511,2634.466,108.0655,0,0,0,100,0), -- 17:20:18
(@GUID,@POINT := @POINT + '1',-787.555,2630.417,107.7722,0,0,0,100,0), -- 17:20:22
(@GUID,@POINT := @POINT + '1',-786.5496,2618.983,109.4194,0,0,0,100,0), -- 17:20:26
(@GUID,@POINT := @POINT + '1',-782.7269,2612.487,109.4225,0,0,0,100,0), -- 17:20:31
(@GUID,@POINT := @POINT + '1',-781.1051,2609.958,109.422,0,0,0,100,0), -- 17:20:35
(@GUID,@POINT := @POINT + '1',-769.5511,2615.452,109.422,0,0,0,100,0), -- 17:20:36
(@GUID,@POINT := @POINT + '1',-769.2007,2622.1369,109.1723,15000,0,1068,100,0), -- 17:20:41 -- Kneel and put down satchels
(@GUID,@POINT := @POINT + '1',-769.2007,2622.1369,109.1723,0,0,1000,100,0), -- Turn off kneel emote
(@GUID,@POINT := @POINT + '1',-772.579,2614.799,109.422,0,0,0,100,0), -- 17:20:50
(@GUID,@POINT := @POINT + '1',-775.0747,2612.723,109.422,0,0,0,100,0), -- 17:20:53
(@GUID,@POINT := @POINT + '1',-775.0747,2612.7229,109.1721,0,0,0,100,0), -- Added
(@GUID,@POINT := @POINT + '1',-783.3768,2615.284,109.422,0,0,0,100,0), -- 17:20:55
(@GUID,@POINT := @POINT + '1',-788.9121,2624.131,108.1715,0,0,0,100,0), -- 17:20:59
(@GUID,@POINT := @POINT + '1',-789.2635,2626.8117,107.6731,0,0,0,100,0), -- Added
(@GUID,@POINT := @POINT + '1',-776.8205,2637.103,108.0527,0,0,0,100,0), -- 17:21:05
(@GUID,@POINT := @POINT + '1',-755.5786,2651.957,105.9618,0,0,0,100,0), -- 17:21:12
(@GUID,@POINT := @POINT + '1',-742.3715,2657.095,99.17558,0,0,0,100,0), -- 17:21:23
(@GUID,@POINT := @POINT + '1',-730.1269,2658.817,95.05613,0,0,0,100,0), -- 17:21:28
(@GUID,@POINT := @POINT + '1',-725.9871,2659.364,94.28555,0,0,0,100,0), -- 17:21:35
(@GUID,@POINT := @POINT + '1',-721.1169,2645.587,93.1051,0,0,0,100,0), -- 17:21:39
(@GUID,@POINT := @POINT + '1',-706.5137,2635.195,91.43243,0,0,0,100,0), -- 17:21:43
(@GUID,@POINT := @POINT + '1',-682.3307,2623.243,88.63831,0,0,0,100,0), -- 17:21:50
(@GUID,@POINT := @POINT + '1',-675.4275,2616.5568,86.8754,0,0,0,100,0), -- Added
(@GUID,@POINT := @POINT + '1',-675.5676,2609.854,86.83054,0,0,0,100,0); -- 17:24:30
-- 0x203CDC4240106FC0005D0100007D011C .go -675.5676 2609.854 86.83054


-- Boxes near keep
-- Pathing for  Entry: 16831 'TDB FORMAT' 
SET @GUID := 57889;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-801.4343,`position_y`=2643.785,`position_z`=109.4202 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-801.4343,2643.785,109.4202,0,0,0,100,0), -- 17:16:55
(@GUID,@POINT := @POINT + '1',-796.0193,2651.808,109.422,0,0,0,100,0), -- 17:17:01
(@GUID,@POINT := @POINT + '1',-785.8399,2655.8332,109.1721,20000,0,1069,100,0), -- 17:17:06 -- Use emote and drop satchels 1m20s (80000)
(@GUID,@POINT := @POINT + '1',-785.8399,2655.8332,109.1721,0,0,1000,100,0), -- Turn off use emote
(@GUID,@POINT := @POINT + '1',-796.5684,2651.333,109.422,0,0,0,100,0), -- 17:18:22
(@GUID,@POINT := @POINT + '1',-799.8857,2645.846,109.422,0,0,0,100,0), -- 17:18:27
(@GUID,@POINT := @POINT + '1',-794.1083,2633.137,108.1725,0,0,0,100,0), -- 17:18:31
(@GUID,@POINT := @POINT + '1',-787.5057,2632.853,107.9186,0,0,0,100,0), -- 17:18:37
(@GUID,@POINT := @POINT + '1',-777.4234,2638.755,108.0459,0,0,0,100,0), -- 17:18:40
(@GUID,@POINT := @POINT + '1',-754.8186,2655.99,104.2998,0,0,0,100,0), -- 17:18:49
(@GUID,@POINT := @POINT + '1',-750.262,2666.566,99.67981,0,0,0,100,0), -- 17:18:56
(@GUID,@POINT := @POINT + '1',-752.3864,2673.738,99.89954,0,0,0,100,0), -- 17:19:01
(@GUID,@POINT := @POINT + '1',-760.5037,2682.006,101.7457,0,0,0,100,0), -- 17:19:05
(@GUID,@POINT := @POINT + '1',-762.8121,2683.413,102.0922,0,0,0,100,0), -- 17:19:09
(@GUID,@POINT := @POINT + '1',-766.9202,2682.946,102.3289,0,0,0,100,0), -- 17:19:11
(@GUID,@POINT := @POINT + '1',-768.8111,2681.4240,102.1079,0,0,0,100,0), -- Added
(@GUID,@POINT := @POINT + '1',-767.8975,2680.983,102.1091,130000,0,1069,100,0), -- 17:19:14 -- Work and pick up satchels 2m10s (130000)
(@GUID,@POINT := @POINT + '1',-767.8975,2680.983,102.1091,0,0,1000,100,0), -- Turn off use emote
(@GUID,@POINT := @POINT + '1',-760.3657,2682.387,101.792,0,0,0,100,0), -- 17:21:23
(@GUID,@POINT := @POINT + '1',-750.4936,2674.702,99.7462,0,0,0,100,0), -- 17:21:26
(@GUID,@POINT := @POINT + '1',-746.1119,2660.125,99.62329,0,0,0,100,0), -- 17:21:32
(@GUID,@POINT := @POINT + '1',-749.8309,2654.803,103.0287,0,0,0,100,0), -- 17:21:38
(@GUID,@POINT := @POINT + '1',-757.9945,2648.734,107.6141,0,0,0,100,0), -- 17:21:40
(@GUID,@POINT := @POINT + '1',-776.5012,2637.151,108.0291,0,0,0,100,0), -- 17:21:45
(@GUID,@POINT := @POINT + '1',-787.7245,2630.948,107.7993,0,0,0,100,0), -- 17:21:54
(@GUID,@POINT := @POINT + '1',-791.5713,2630.794,107.9425,0,0,0,100,0); -- 17:21:58
-- 0x203CDC4240106FC0005D0100007CD71E .go -801.4343 2643.785 109.4202

-- Going from inn to gate boxes
-- Pathing for  Entry: 16831 'TDB FORMAT' 
SET @GUID := 58153;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-691.2068,`position_y`=2612.307,`position_z`=86.82053 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-691.2068,2612.307,86.82053,0,0,0,100,0), -- 14:19:27
(@GUID,@POINT := @POINT + '1',-692.7888,2615.884,89.03557,0,0,0,100,0), -- 14:19:29
(@GUID,@POINT := @POINT + '1',-694.6949,2622.964,90.10753,0,0,0,100,0), -- 14:19:32
(@GUID,@POINT := @POINT + '1',-694.8127,2623.512,90.26909,0,0,0,100,0), -- 14:19:34
(@GUID,@POINT := @POINT + '1',-681.0259,2642.447,89.63081,0,0,0,100,0), -- 14:19:39
(@GUID,@POINT := @POINT + '1',-679.9601,2643.327,89.52776,0,0,0,100,0), -- 14:19:45
(@GUID,@POINT := @POINT + '1',-676.0788,2652.33,89.45507,0,0,0,100,0), -- 14:19:49
(@GUID,@POINT := @POINT + '1',-683.2964,2672.437,91.13505,0,0,0,100,0), -- 14:19:54
(@GUID,@POINT := @POINT + '1',-691.312,2677.852,92.85458,0,0,0,100,0), -- 14:19:58
(@GUID,@POINT := @POINT + '1',-697.7299,2679.415,93.82138,0,0,0,100,0), -- 14:20:02
(@GUID,@POINT := @POINT + '1',-703.9164,2680.697,93.97695,0,0,0,100,0), -- 14:20:07
(@GUID,@POINT := @POINT + '1',-709.7415,2703.192,94.69138,0,0,0,100,0), -- 14:20:13
(@GUID,@POINT := @POINT + '1',-709.845,2710.919,94.83158,0,0,0,100,0), -- 14:20:17
(@GUID,@POINT := @POINT + '1',-709.8132,2713.014,94.97685,0,0,0,100,0), -- 14:20:20
(@GUID,@POINT := @POINT + '1',-703.2125,2713.8120,94.7370,0,0,0,100,0), -- 14:20:24 --C
(@GUID,@POINT := @POINT + '1',-702.9235,2721.491,94.4231,0,0,0,100,0), -- 14:20:26
(@GUID,@POINT := @POINT + '1',-703.556,2730.551,94.98415,0,0,0,100,0), -- 14:20:29
(@GUID,@POINT := @POINT + '1',-704.699,2735.226,94.90048,0,0,0,100,0), -- 14:20:32
(@GUID,@POINT := @POINT + '1',-705.576,2736.907,94.73344,5000,0,1001,100,0), -- 14:20:36 --O --ToDo: Add speech
(@GUID,@POINT := @POINT + '1',-705.576,2736.907,94.73344,0,0,1000,100,0), -- Turn off talk emote
(@GUID,@POINT := @POINT + '1',-704.5279,2742.1013,94.7331,0,0,0,100,0), -- 14:20:48 --C
(@GUID,@POINT := @POINT + '1',-711.543,2742.858,94.97518,0,0,0,100,0), -- 14:20:52
(@GUID,@POINT := @POINT + '1',-713.9904,2745.996,94.95235,0,0,0,100,0), -- 14:20:53
(@GUID,@POINT := @POINT + '1',-714.3401,2747.434,94.40321,0,0,0,100,0), -- 14:20:54
(@GUID,@POINT := @POINT + '1',-713.3446,2758.6386,87.9284,0,0,0,100,0), -- 14:20:57 --C
(@GUID,@POINT := @POINT + '1',-711.1699,2759.309,88.18364,0,0,0,100,0), -- 14:21:00
(@GUID,@POINT := @POINT + '1',-704.5567,2753.353,87.7123,8000,0,1068,100,0), -- 14:21:03 -- Kneel 
(@GUID,@POINT := @POINT + '1',-704.5567,2753.353,87.7123,0,0,1000,100,0), -- Turn off kneel emote
(@GUID,@POINT := @POINT + '1',-711.8190,2759.0969,87.9301,0,0,0,100,0), -- 14:21:13 --C
(@GUID,@POINT := @POINT + '1',-714.008,2757.465,88.25082,0,0,0,100,0), -- 14:21:16
(@GUID,@POINT := @POINT + '1',-714.4139,2746.473,94.80678,0,0,0,100,0), -- 14:21:20
(@GUID,@POINT := @POINT + '1',-704.5270,2743.0043,94.7323,0,0,0,100,0), -- 14:21:24 --C
(@GUID,@POINT := @POINT + '1',-704.3337,2731.918,94.98073,0,0,0,100,0), -- 14:21:27
(@GUID,@POINT := @POINT + '1',-703.8024,2728.728,94.42149,0,0,0,100,0), -- 14:21:32
(@GUID,@POINT := @POINT + '1',-703.2446,2714.0810,94.7372,0,0,0,100,0), -- 14:21:36 --C
(@GUID,@POINT := @POINT + '1',-709.2371,2711.9323,94.7216,0,0,0,100,0), -- 14:21:41 --C
(@GUID,@POINT := @POINT + '1',-709.0999,2700.167,94.53326,0,0,0,100,0), -- 14:21:43
(@GUID,@POINT := @POINT + '1',-709.7512,2696.803,94.39558,0,0,0,100,0), -- 14:21:49
(@GUID,@POINT := @POINT + '1',-694.2099,2679.308,93.23099,0,0,0,100,0), -- 14:21:56
(@GUID,@POINT := @POINT + '1',-682.8473,2672.114,91.00636,0,0,0,100,0), -- 14:22:01
(@GUID,@POINT := @POINT + '1',-679.4442,2666.898,90.3499,0,0,0,100,0), -- 14:22:06
(@GUID,@POINT := @POINT + '1',-677.2031,2648.906,89.43787,0,0,0,100,0), -- 14:22:10
(@GUID,@POINT := @POINT + '1',-683.6664,2640.914,89.94809,0,0,0,100,0), -- 14:22:16
(@GUID,@POINT := @POINT + '1',-689.635,2635.617,89.85884,0,0,0,100,0), -- 14:22:23
(@GUID,@POINT := @POINT + '1',-691.4574,2610.438,88.27208,0,0,0,100,0), -- 14:22:29
(@GUID,@POINT := @POINT + '1',-687.9446,2606.449,87.25223,0,0,0,100,0), -- 14:22:34
(@GUID,@POINT := @POINT + '1',-686.3853,2604.818,86.82053,180000,0,1069,100,0), -- 14:22:38 --O -- Use emote for 3m (180000)
(@GUID,@POINT := @POINT + '1',-686.3853,2604.818,86.82053,0,0,1000,100,0); -- Turn off use emote
-- 0x202FD44240106FC00028C9000000CB0A .go -691.2068 2612.307 86.82053



-- ----------------------------------------------------------
-- Stormwind Infantry
-- ----------------------------------------------------------

-- ----------------------------------------------------------
-- Eye of Honor Hold
-- ----------------------------------------------------------

-- Pathing for  Entry: 16887 'TDB FORMAT'
SET @GUID := 58438;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-756.1597,`position_y`=2752.3581,`position_z`=152.2836 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-756.1597,2752.3581,152.2836,0,0,0,100,0), -- 14:19:27
(@GUID,@POINT := @POINT + '1',-766.7427,2718.9423,176.0424,0,0,0,100,0), -- 14:19:29
(@GUID,@POINT := @POINT + '1',-787.4961,2726.0864,182.8486,0,0,0,100,0), -- 14:19:32
(@GUID,@POINT := @POINT + '1',-814.0700,2740.9248,183.3243,0,0,0,100,0), -- 14:19:34
(@GUID,@POINT := @POINT + '1',-817.7127,2759.0454,162.0388,0,0,0,100,0), -- 14:19:39
(@GUID,@POINT := @POINT + '1',-815.5086,2769.9328,161.1689,0,0,0,100,0), -- 14:19:45
(@GUID,@POINT := @POINT + '1',-792.8707,2799.0156,181.775,0,0,0,100,0), -- 14:19:49
(@GUID,@POINT := @POINT + '1',-755.4234,2782.1103,181.8813,0,0,0,100,0), -- 14:19:54
(@GUID,@POINT := @POINT + '1',-750.323425,2759.126221,158.256607,0,0,0,100,0), -- 14:19:58
(@GUID,@POINT := @POINT + '1',-778.1268,2722.9465,187.0669,0,0,0,100,0), -- 14:20:02
(@GUID,@POINT := @POINT + '1',-805.9296,2730.6369,171.9460,0,0,0,100,0), -- 14:20:07
(@GUID,@POINT := @POINT + '1',-817.8197,2762.2678,163.0459,0,0,0,100,0), -- 14:20:13
(@GUID,@POINT := @POINT + '1',-809.7094,2783.0400,160.3302,0,0,0,100,0), -- 14:20:17
(@GUID,@POINT := @POINT + '1',-786.7590,2796.8569,162.128,0,0,0,100,0), -- 14:20:20
(@GUID,@POINT := @POINT + '1',-762.4360,2786.7182,162.7843,0,0,0,100,0), -- 14:20:24 
(@GUID,@POINT := @POINT + '1',-747.3114,2757.143311,148.11193,0,0,0,100,0); -- 14:20:26

-- ----------------------------------------------------------
-- Magus Filinthus
-- ----------------------------------------------------------
DELETE FROM `creature_template` WHERE `entry` IN (1000014,1000015);
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`) VALUES 
(1000014, 0, 17519, 11686, 17519, 11686, 'Sid speech trigger', 60, 60, 112, 112, 0, 0, 20, 114, 114, 0, 0.91, 1, 0, 0, 0, 0, 0, 2000, 0, 33587968, 0, 0, 0, 0, 0, 0, 1.76, 2.42, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 0, 1, 0, 0, 128, ''),
(1000015, 0, 17519, 11686, 17519, 11686, 'Magus Filinthus Killer', 60, 60, 112, 112, 0, 0, 20, 114, 114, 0, 0.91, 1, 0, 0, 0, 0, 0, 2000, 0, 33587968, 0, 0, 0, 0, 0, 0, 1.76, 2.42, 100, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'EventAI', 0, 3, 0, 1, 0, 0, 128, '');

-- Move the barkeep slightly to prevent his emotes from going through the table.
UPDATE `creature` SET `spawndist`=0,`MovementType`=1,`position_x`=-708.8249,`position_y`=2740.1203,`position_z`=94.7337 WHERE `guid`=57884;

DELETE FROM `db_script_string` WHERE `entry` BETWEEN 2000000078 AND 2000000083;
INSERT INTO `db_script_string` (`entry`,`content_default`) VALUES 
(2000000078,'What now, Danath? Can you not see that I am imundated with work as is?'),
(2000000079,'I take my leave now, Commander. Good day!'),
(2000000080,'A mailbox? Well is that not the salt on the wounds! Twenty years cut-off from the world and now a mailbox! WONDERFUL!'),
(2000000081,'Sid! Ale, NOW!'),
(2000000082,'Comin'' right up, yer highness! Is there anythin'' else you''ll be needin''? Perhaps yer hat cleaned or yer nails trimmed?'),
(2000000083,'Don''t you start with me, Sid! Have it sent to my quarters in the tower instead! Your inn has become a zoo!');

DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -11006 AND -11000;
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`comment`) VALUES
(-11000,'Twenty years lost! Twenty! I won''t stand for this! No, no, no...','Magus Filinthus GUID: 16821'),
(-11001,'What manner of fools opens the very thing we were sent to close?','Magus Filinthus GUID: 16821'),
(-11002,'To trust an orc? Even if it is the progeny of Durotan himself! This is madness!','Magus Filinthus GUID: 16821'),
(-11003,'Never! I''ll never abide by their will! I''d sooner be dead.','Magus Filinthus GUID: 16821'),
(-11004,'I have a good mind to tear down that portal myself! This is outrageous!','Magus Filinthus GUID: 16821'),
(-11005,'And have you heard? Have you heard the preposterous claims? Alliance and Horde supporting peace? Why the very thought of such things makes my blood boil!','Magus Filinthus GUID: 16821'),
(-11006,'Comin'' right up, yer highness! Is there anythin'' else you''ll be needin''? Perhaps yer hat cleaned or yer nails trimmed?','Sid Limbardi GUID: 57884');

DELETE FROM `waypoint_scripts` WHERE `id` BETWEEN 5787900 AND 5787910;
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`guid`,`comment`) VALUES
(5787900,0,0,0,0,2000000078,5787901,'Magus Filinthus - What now, Danath? Can you not see that I am imundated with work as is?'),
(5787900,0,1,6,0,0,5787902,'Magus Filinthus - Question emote'),
(5787901,0,1,1,0,0,5787903,'Magus Filinthus - Talk emote'),
(5787902,0,0,0,0,2000000079,5787904,'Magus Filinthus - I take my leave now, Commander. Good day!'),
(5787902,0,1,1,0,0,5787905,'Magus Filinthus - Talk emote'),
(5787903,0,1,66,0,0,5787906,'Magus Filinthus - Salute emote'),
(5787904,0,0,0,0,2000000080,5787907,'Magus Filinthus - Mailbox speech'),
(5787904,0,1,5,0,0,5787908,'Magus Filinthus - Exclamation emote'),
(5787905,0,0,0,0,2000000081,5787909,'Magus Filinthus - Sid! Ale, NOW!'),
(5787905,0,1,22,0,0,5787910,'Magus Filinthus - Shout emote'),
(5787907,0,0,0,0,2000000083,5787912,'Magus Filinthus - Don''t you start with me, Sid! Have it sent to my quarters in the tower instead! Your inn has becoma a zoo!'),
(5787907,0,1,5,0,0,5787913,'Magus Filinthus - Exclamation emote'),
(5787908,0,1,14,0,0,5787914,'Magus Filinthus - Rude emote'),
(5787909,0,15,7791,1,0,5787915,'Magus Filinthus - Cast teleport on self');

INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`dataint`,`x`,`y`,`z`,`guid`,`comment`) VALUES
(5787906,0,10,1000014,120000,0,-708.8249,2740.1203,94.7337,5787911,'Magus Filinthus - Spawn invisible Sid speech trigger');
-- (5787910,0,6,530,1,0,-779.6566,2749.112,155.3301,5787916,'Magus Filinthus - Teleport to starting point'); -- Doesn't work

-- Magus Filinthus
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16821;
INSERT INTO `creature_ai_scripts` VALUES
('1682101','16821','1','0','100','1','60000','60000','120000','120000','1','-11000','-11001','-11002','5','5','0','0','0','0','0','0','Magus Filinthus - Random say1 while OOC'),
('1682102','16821','1','0','100','1','120000','120000','120000','120000','1','-11003','-11004','-11005','0','0','0','0','0','0','0','0','Magus Filinthus - Random say2 while OOC'),
('1682603','16821','8','0','100','1','7791','-1','0','0','0','0','0','0','23','1','0','0','0','0','0','0','Magus Filinthus - Set phase 2 after teleport spell'),
-- ('1682604','16821','1','1','100','1','1000','1000','1000','1000','41','0','0','0','43','0','0','0','23','-1','0','0','Magus Filinthus - Despawn after 1 sec and set phase 1'),
('1682604','16821','1','1','100','1','1000','1000','1000','1000','100','0','0','0','0','0','0','0','0','0','0','0','Magus Filinthus - Despawn after 1 sec and set phase 1'),
('1682605','16821','1','1','100','1','1500','1500','1500','1500','12','1000015','0','1000','23','-1','0','0','0','0','0','0','Magus Filinthus - Summon killer after 1 sec and set phase 1');
-- ('1682605','16821','11','0','100','0','0','0','0','0','24','0','0','0','99','5','0','0','0','0','0','0','Magus Filinthus - Evade and move to random point on respawn, to prevent him not moving to first waypoint on respawn.');
-- ('1682604','16821','1','1','100','1','1000','1000','1000','1000','11','5','0','0','43','0','0','0','23','-1','0','0','Magus Filinthus - Kill after 1 sec and set phase 1');

-- Magus Filinthus Killer
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1000015;
INSERT INTO `creature_ai_scripts` VALUES
('100001501','1000015','11','0','100','0','0','0','0','0','44','5','57879','0','41','0','0','0','0','0','0','0','Magus Filinthus Killer - Cast Death Touch on Magus Filinthus on spawn. (Have to kill him this way, othersise he bugs on respawn)');

-- Sid
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16826;
INSERT INTO `creature_ai_scripts` VALUES
('1682601','16826','8','0','100','1','33227','-1','0','0','1','-11006','0','0','5','22','0','0','23','1','0','0','Sid Limbardi - Say, Emote, set phase 2'),
('1682602','16826','1','1','100','1','6000','6000','6000','6000','0','0','0','0','5','14','0','0','23','-1','0','0','Sid Limbardi - Emote, set phase 1');
UPDATE `creature_template` SET `AIName`='' WHERE `entry` = 16826;

-- Sid invis speech trigger
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 1000014;
INSERT INTO `creature_ai_scripts` VALUES
('100001401','1000014','11','0','100','0','0','0','0','0','44','33227','57884','0','41','0','0','0','0','0','0','0','Sid speech trigger - Cast Gossip NPC Periodic Trigger - Talk');

-- Pathing for  Entry: 16821 'TDB FORMAT'
SET @GUID := 57879;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`spawntimesecs`=1,`position_x`=-779.6566,`position_y`=2749.112,`position_z`=155.3301 WHERE `guid`=@GUID;
UPDATE `creature_template` SET `flags_extra`='536870912' WHERE `entry` = 16821;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-779.6566,2749.112,155.3301,0,0,0,100,0), -- 01:49:23
(@GUID,@POINT := @POINT + '1',-772.6121,2754.952,155.5087,0,0,0,100,0), -- 01:49:28
(@GUID,@POINT := @POINT + '1',-771.3204,2764.6318,155.2341,0,0,0,100,0), -- 01:49:28 --Added
(@GUID,@POINT := @POINT + '1',-773.6816,2768.407,155.4837,0,0,0,100,0), -- 01:49:31
-- (@GUID,@POINT := @POINT + '1',-775.764,2769.377,155.2425,0,0,0,100,0), -- 01:49:36
(@GUID,@POINT := @POINT + '1',-777.0079,2765.431,154.8024,0,0,0,100,0), -- 01:49:37
(@GUID,@POINT := @POINT + '1',-778.0384,2762.6423,153.2189,0,0,0,100,0), -- 01:49:37
(@GUID,@POINT := @POINT + '1',-779.8215,2762.42,153.0081,0,0,0,100,0), -- 01:49:40
(@GUID,@POINT := @POINT + '1',-782.2388,2762.958,151.1028,0,0,0,100,0), -- 01:49:42
(@GUID,@POINT := @POINT + '1',-782.7231,2765.576,150.01,0,0,0,100,0), -- 01:49:43
(@GUID,@POINT := @POINT + '1',-781.5016,2767.298,148.831,0,0,0,100,0), -- 01:49:45
(@GUID,@POINT := @POINT + '1',-778.6078,2766.317,147.1977,0,0,0,100,0), -- 01:49:46
(@GUID,@POINT := @POINT + '1',-774.1761,2765.54,146.6277,0,0,0,100,0), -- 01:49:48
(@GUID,@POINT := @POINT + '1',-775.8586,2768.62,146.7117,0,0,0,100,0), -- 01:49:49
(@GUID,@POINT := @POINT + '1',-779.1277,2771.878,146.7474,0,0,0,100,0), -- 01:49:52
(@GUID,@POINT := @POINT + '1',-789.3788,2773.089,146.7321,0,0,0,100,0), -- 01:49:54
(@GUID,@POINT := @POINT + '1',-790.3833,2772.747,146.7375,0,0,0,100,0), -- 01:49:58
(@GUID,@POINT := @POINT + '1',-794.7836,2766.801,146.7466,0,0,0,100,0), -- 01:50:00
(@GUID,@POINT := @POINT + '1',-794.671,2761.858,145.4243,0,0,0,100,0), -- 01:50:03
(@GUID,@POINT := @POINT + '1',-790.5088,2758.7980,142.5738,0,0,0,100,0), -- 01:50:04 -- Added
-- (@GUID,@POINT := @POINT + '1',-791.5698,2759.788,143.4376,0,0,0,100,0), -- 01:50:04
(@GUID,@POINT := @POINT + '1',-786.6111,2759.94,141.743,0,0,0,100,0), -- 01:50:06
(@GUID,@POINT := @POINT + '1',-791.4205,2768.945,137.747,0,0,0,100,0), -- 01:50:08
(@GUID,@POINT := @POINT + '1',-793.6792,2769.299,137.5086,0,0,0,100,0), -- 01:50:14
(@GUID,@POINT := @POINT + '1',-797.2106,2760.471,134.9409,0,0,0,100,0), -- 01:50:15
(@GUID,@POINT := @POINT + '1',-794.3986,2755.097,134.4531,0,0,0,100,0), -- 01:50:19
(@GUID,@POINT := @POINT + '1',-793.0892,2753.0029,134.1123,0,0,0,100,0), -- 01:50:19
(@GUID,@POINT := @POINT + '1',-785.8677,2757.643,132.4443,0,0,0,100,0), -- 01:50:22
(@GUID,@POINT := @POINT + '1',-784.1951,2759.4938,131.4428,0,0,0,100,0), -- 01:50:27 --added
(@GUID,@POINT := @POINT + '1',-783.5496,2757.546,131.6365,0,0,0,100,0), -- 01:50:27
(@GUID,@POINT := @POINT + '1',-781.3209,2756.4289,131.2748,0,0,0,100,0), -- 01:50:27 --added
(@GUID,@POINT := @POINT + '1',-777.0540,2760.9504,128.6305,0,0,0,100,0), -- 01:50:27 --added
(@GUID,@POINT := @POINT + '1',-777.4893,2761.395,128.855,0,0,0,100,0), -- 01:50:30
(@GUID,@POINT := @POINT + '1',-777.1847,2764.6511,126.5837,0,0,0,100,0), -- 01:50:32
(@GUID,@POINT := @POINT + '1',-778.3436,2765.721,126.1166,0,0,0,100,0), -- 01:50:32
(@GUID,@POINT := @POINT + '1',-777.7507,2769.801,125.8422,0,0,0,100,0), -- 01:50:34
(@GUID,@POINT := @POINT + '1',-774.1144,2767.114,125.1236,0,0,0,100,0), -- 01:50:36
(@GUID,@POINT := @POINT + '1',-772.84,2760.124,122.5914,0,0,0,100,0), -- 01:50:38
(@GUID,@POINT := @POINT + '1',-773.5005,2757.315,121.4295,0,0,0,100,0), -- 01:50:42
(@GUID,@POINT := @POINT + '1',-777.4531,2752.7463,120.8468,0,0,0,100,0), -- 01:50:50 --added
(@GUID,@POINT := @POINT + '1',-776.1379,2749.887,120.9658,0,0,0,100,0), -- 01:50:44
(@GUID,@POINT := @POINT + '1',-774.0491,2746.545,121.0984,0,0,0,100,0), -- 01:50:47
(@GUID,@POINT := @POINT + '1',-765.1492,2734.124,120.8622,0,0,0,100,0), -- 01:50:50
(@GUID,@POINT := @POINT + '1',-758.4291,2725.751,116.7763,0,0,0,100,0), -- 01:50:56
(@GUID,@POINT := @POINT + '1',-750.1381,2711.114,110.9275,0,0,0,100,0), -- 01:51:00
(@GUID,@POINT := @POINT + '1',-739.2902,2697.994,105.4595,0,0,0,100,0), -- 01:51:06
(@GUID,@POINT := @POINT + '1',-729.8958,2685.469,100.1962,0,0,0,100,0), -- 01:51:13
(@GUID,@POINT := @POINT + '1',-719.428,2674.712,95.68393,0,0,0,100,0), -- 01:51:21
(@GUID,@POINT := @POINT + '1',-722.2224,2666.956,94.55554,0,0,0,100,0), -- 01:51:27
(@GUID,@POINT := @POINT + '1',-738.5777,2658.926,97.63875,0,0,0,100,0), -- 01:51:33
(@GUID,@POINT := @POINT + '1',-753.056,2652.202,104.9079,0,0,0,100,0), -- 01:51:39
(@GUID,@POINT := @POINT + '1',-759.6188,2648.154,108.1811,0,0,0,100,0), -- 01:51:46
(@GUID,@POINT := @POINT + '1',-781.7079,2634.436,108.0559,0,0,0,100,0), -- 01:51:51
(@GUID,@POINT := @POINT + '1',-787.824,2630.978,107.8018,0,0,0,100,0), -- 01:51:59
(@GUID,@POINT := @POINT + '1',-795.3052,2633.888,108.4713,0,0,0,100,0), -- 01:52:03
(@GUID,@POINT := @POINT + '1',-797.6466,2637.246,109.4505,0,0,0,100,0), -- 01:52:07
(@GUID,@POINT := @POINT + '1',-802.5181,2644.344,109.4217,0,0,0,100,0), -- 01:52:10
(@GUID,@POINT := @POINT + '1',-806.1069,2646.608,109.422,0,0,0,100,0), -- 01:52:13
(@GUID,@POINT := @POINT + '1',-811.4109,2638.948,109.422,0,0,0,100,0), -- 01:52:15
(@GUID,@POINT := @POINT + '1',-807.3386,2630.296,109.422,0,0,0,100,0), -- 01:52:18
(@GUID,@POINT := @POINT + '1',-804.3088,2620.307,109.422,0,0,0,100,0), -- 01:52:24
(@GUID,@POINT := @POINT + '1',-805.9506,2616.556,109.422,0,0,0,100,0), -- 01:52:26
(@GUID,@POINT := @POINT + '1',-812.9794,2612.111,109.422,0,0,0,100,0), -- 01:52:30
(@GUID,@POINT := @POINT + '1',-815.412,2612.896,109.6071,0,0,0,100,0), -- 01:52:31
(@GUID,@POINT := @POINT + '1',-818.4614,2617.128,113.1964,0,0,0,100,0), -- 01:52:35
(@GUID,@POINT := @POINT + '1',-818.1932,2619.4772,113.1008,0,0,0,100,0), -- 01:52:36
(@GUID,@POINT := @POINT + '1',-813.9753,2622.237,115.535,0,0,0,100,0), -- 01:52:36
(@GUID,@POINT := @POINT + '1',-807.1000,2626.0339,117.9942,0,0,0,100,0), -- 01:52:40
(@GUID,@POINT := @POINT + '1',-811.0223,2634.018,118.2438,0,0,0,100,0), -- 01:52:42
(@GUID,@POINT := @POINT + '1',-808.3665,2638.212,118.512,0,0,0,100,0), -- 01:52:46
(@GUID,@POINT := @POINT + '1',-797.8145,2645.19,123.2433,0,0,0,100,0), -- 01:52:49
(@GUID,@POINT := @POINT + '1',-794.114,2639.995,123.3454,0,0,0,100,0), -- 01:52:53
(@GUID,@POINT := @POINT + '1',-791.9308,2630.846,123.3454,0,0,0,100,0), -- 01:52:59
(@GUID,@POINT := @POINT + '1',-792.4211,2630.415,123.3454,0,0,0,100,0), -- 01:53:00
(@GUID,@POINT := @POINT + '1',-805.3203,2621.029,124.4923,0,0,0,100,0), -- 01:53:05 --
(@GUID,@POINT := @POINT + '1',-808.9996,2618.0412,124.3892,2000,0,5787900,100,0), -- 01:53:05 -- Greet commander
(@GUID,@POINT := @POINT + '1',-808.9996,2618.0412,124.3892,4000,0,5787901,100,0), -- 01:53:10 ---- Talk emote
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:53:24
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:53:26
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:53:29
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:53:32
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:53:35
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:53:38
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:53:41
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:53:44
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:53:47
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:53:50
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:53:53
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:53:56
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:53:59
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:03
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:05
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:09
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:12
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:15
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:18
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:22
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:25
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:28
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:31
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:34
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:37
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:40
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:43
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:46
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:49
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:53
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:54:56
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:54:59
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:02
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:05
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:08
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:11
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:14
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:17
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:19
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:23
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:26
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:29
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:32
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:35
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:38
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:41
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:44
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:47
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:50
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:55:53
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:55:56
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:00
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:02
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:06
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:09
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:12
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:15
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:19
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:22
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:25
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:27
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:30
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:34
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:36
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:39
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:42
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:45
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:48
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:51
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:56:55
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:56:58
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:01
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:04
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:07
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:10
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:13
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:16
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:19
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:22
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:25
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:29
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:32
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:35
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:38
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:42
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:45
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:48
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:51
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:57:54
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:57:57
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:58:01
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:58:03
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:58:06
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:58:09
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:58:12
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:58:16
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:58:19
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:58:22
(@GUID,@POINT := @POINT + '1',-811.1351,2621.082,124.3893,0,0,0,100,0), -- 01:58:25
(@GUID,@POINT := @POINT + '1',-807.5905,2614.945,124.3893,0,0,0,100,0), -- 01:58:25 -----
(@GUID,@POINT := @POINT + '1',-808.5327,2618.6135,124.3892,0,0,0,100,0), -- 01:58:25 -- Added
(@GUID,@POINT := @POINT + '1',-810.0437,2617.4189,124.3892,3000,0,5787902,100,0), -- 01:58:25 -- Added -- Leave commander speech
(@GUID,@POINT := @POINT + '1',-810.0437,2617.4189,124.3892,3000,0,5787903,100,0), -- Salute commander
(@GUID,@POINT := @POINT + '1',-793.5458,2626.9306,123.0957,0,0,0,100,0), -- 01:58:25
(@GUID,@POINT := @POINT + '1',-788.4716,2626.819,123.1638,0,0,0,100,0), -- 01:58:34
(@GUID,@POINT := @POINT + '1',-782.2244,2621.667,123.3454,0,0,0,100,0), -- 01:58:39
(@GUID,@POINT := @POINT + '1',-780.3174,2616.45,123.3454,0,0,0,100,0), -- 01:58:43
(@GUID,@POINT := @POINT + '1',-790.2454,2608.325,118.2946,0,0,0,100,0), -- 01:58:45
(@GUID,@POINT := @POINT + '1',-794.4955,2607.6281,117.9941,0,0,0,100,0), -- 01:59:01
(@GUID,@POINT := @POINT + '1',-798.1478,2612.605,118.2438,0,0,0,100,0), -- 01:58:51
(@GUID,@POINT := @POINT + '1',-807.2708,2626.073,118.2438,0,0,0,100,0), -- 01:58:56
(@GUID,@POINT := @POINT + '1',-819.8717,2618.3537,113.1008,0,0,0,100,0), -- 01:58:56
(@GUID,@POINT := @POINT + '1',-813.6469,2610.71,109.5707,0,0,0,100,0), -- 01:59:07
(@GUID,@POINT := @POINT + '1',-803.081,2616.339,109.3586,0,0,0,100,0), -- 01:59:12
(@GUID,@POINT := @POINT + '1',-797.3878,2613.336,109.422,0,0,0,100,0), -- 01:59:18
(@GUID,@POINT := @POINT + '1',-792.3141,2606.875,109.422,0,0,0,100,0), -- 01:59:20
(@GUID,@POINT := @POINT + '1',-785.1685,2607.075,109.422,0,0,0,100,0), -- 01:59:25
(@GUID,@POINT := @POINT + '1',-785.0612,2615.707,109.422,0,0,0,100,0), -- 01:59:29
(@GUID,@POINT := @POINT + '1',-788.5981,2624.276,108.1702,0,0,0,100,0), -- 01:59:33
(@GUID,@POINT := @POINT + '1',-788.9245,2628.7475,107.6733,0,0,0,100,0), -- 01:59:37
(@GUID,@POINT := @POINT + '1',-777.4222,2636.925,108.1835,0,0,0,100,0), -- 01:59:43
(@GUID,@POINT := @POINT + '1',-755.5909,2652.344,105.7743,0,0,0,100,0), -- 01:59:50
(@GUID,@POINT := @POINT + '1',-729.4761,2658.79,95.0219,0,0,0,100,0), -- 01:59:56
(@GUID,@POINT := @POINT + '1',-719.9623,2672.204,95.05917,0,0,0,100,0), -- 02:00:07
(@GUID,@POINT := @POINT + '1',-710.0211,2678.701,94.40421,0,0,0,100,0), -- 02:00:14
(@GUID,@POINT := @POINT + '1',-705.699,2697.925,94.76318,8000,0,5787904,100,0), -- 02:00:19 --Mailbox speech
(@GUID,@POINT := @POINT + '1',-709.0976,2699.6367,94.3927,0,0,0,100,0), -- 02:00:31
(@GUID,@POINT := @POINT + '1',-710.2797,2710.86,94.97627,0,0,0,100,0), -- 02:00:36
(@GUID,@POINT := @POINT + '1',-701.8185,2714.304,94.98135,0,0,0,100,0), -- 02:00:38
(@GUID,@POINT := @POINT + '1',-702.9014,2721.559,94.42241,0,0,0,100,0), -- 02:00:41
(@GUID,@POINT := @POINT + '1',-703.3703,2722.376,94.11028,2000,0,5787905,100,0), -- 02:00:45 -- 
(@GUID,@POINT := @POINT + '1',-703.3703,2722.376,94.11028,8000,0,5787906,100,0), -- 02:00:45 -----
(@GUID,@POINT := @POINT + '1',-703.3703,2722.376,94.11028,2000,0,5787907,100,0), -- 02:00:45 -----
(@GUID,@POINT := @POINT + '1',-703.3703,2722.376,94.11028,4000,0,5787908,100,0), -- 02:00:45 -- 
(@GUID,@POINT := @POINT + '1',-703.3703,2722.376,94.11028,1000,0,5787909,100,0),
(@GUID,@POINT := @POINT + '1',-703.3703,2722.376,94.11028,1000,0,5787910,100,0); 
-- 0x203CD04240106D40002FF700007AD777 .go -779.6566 2749.112 155.3301

-- ----------------------------------------------------------
-- Caretaker Dilandrus --To do. Fix waypoints and add speech
-- ----------------------------------------------------------

-- Pathing for  Entry: 16856 'TDB FORMAT' 
SET @GUID := 58021;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-784.4011,`position_y`=2704.242,`position_z`=107.1181 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-807.2846,2727.0644,112.3538,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-784.4011,2704.242,107.1181,0,0,0,100,0), -- 02:28:27
(@GUID,@POINT := @POINT + '1',-786.1865,2701.929,106.4698,0,0,0,100,0), -- 02:28:36
(@GUID,@POINT := @POINT + '1',-787.6518,2700.579,105.934,0,0,0,100,0), -- 02:28:39 --
(@GUID,@POINT := @POINT + '1',-787.8432,2700.6953,105.8141,0,0,0,100,0), -- A O
(@GUID,@POINT := @POINT + '1',-792.1684,2694.501,105.0721,0,0,0,100,0), -- 02:28:46
(@GUID,@POINT := @POINT + '1',-792.685,2693.922,104.7101,0,0,0,100,0), -- 02:28:49 --
(@GUID,@POINT := @POINT + '1',-795.5505,2696.909,105.3471,0,0,0,100,0), -- 02:28:53
(@GUID,@POINT := @POINT + '1',-797.916,2697.396,105.4841,0,0,0,100,0), -- 02:28:56 --
(@GUID,@POINT := @POINT + '1',-792.765,2704.767,106.8859,0,0,0,100,0), -- 02:29:01
(@GUID,@POINT := @POINT + '1',-792.2449,2707.191,107.5509,0,0,0,100,0), -- 02:29:04
(@GUID,@POINT := @POINT + '1',-794.0685,2709.671,108.3569,0,0,0,100,0), -- 02:29:05
(@GUID,@POINT := @POINT + '1',-797.7253,2709.18,108.0311,0,0,0,100,0), -- 02:29:07
(@GUID,@POINT := @POINT + '1',-800.4393,2705.978,107.5758,0,0,0,100,0), -- 02:29:09
(@GUID,@POINT := @POINT + '1',-803.6293,2699.97,106.5134,0,0,0,100,0), -- 02:29:11
(@GUID,@POINT := @POINT + '1',-807.278,2694.193,105.6765,0,0,0,100,0), -- 02:29:13
(@GUID,@POINT := @POINT + '1',-808.0405,2693.319,105.0343,0,0,0,100,0), -- 02:29:17 --
(@GUID,@POINT := @POINT + '1',-812.295,2692.416,104.9431,0,0,0,100,0), -- 02:29:24
(@GUID,@POINT := @POINT + '1',-814.4872,2694.548,105.5211,0,0,0,100,0), -- 02:29:26
(@GUID,@POINT := @POINT + '1',-812.0645,2698.351,106.6527,0,0,0,100,0), -- 02:29:27
(@GUID,@POINT := @POINT + '1',-810.0867,2701.277,107.2569,0,0,0,100,0), -- 02:29:29
(@GUID,@POINT := @POINT + '1',-809.0142,2703.514,107.4949,0,0,0,100,0), -- 02:29:33 --
(@GUID,@POINT := @POINT + '1',-798.5548,2716.915,111.062,0,0,0,100,0), -- 02:29:37
(@GUID,@POINT := @POINT + '1',-804.4795,2711.166,108.7988,0,0,0,100,0), -- 02:29:37
(@GUID,@POINT := @POINT + '1',-803.1904,2712.994,109.2391,0,0,0,100,0), -- 02:29:40
(@GUID,@POINT := @POINT + '1',-801.8869,2715.421,109.8517,0,0,0,100,0), -- 02:29:43 --
(@GUID,@POINT := @POINT + '1',-804.9284,2720.378,111.2985,0,0,0,100,0), -- 02:29:47
(@GUID,@POINT := @POINT + '1',-808.2941,2719.672,110.8294,0,0,0,100,0), -- 02:29:49
(@GUID,@POINT := @POINT + '1',-810.041,2718.517,110.6133,0,0,0,100,0), -- 02:29:53 --
(@GUID,@POINT := @POINT + '1',-812.5195,2714.51,109.9449,0,0,0,100,0), -- 02:29:58
(@GUID,@POINT := @POINT + '1',-814.9861,2710.911,109.4516,0,0,0,100,0), -- 02:30:01
(@GUID,@POINT := @POINT + '1',-818.0924,2705.116,108.5067,0,0,0,100,0), -- 02:30:02
(@GUID,@POINT := @POINT + '1',-820.6952,2701.716,107.7344,0,0,0,100,0), -- 02:30:07 --
(@GUID,@POINT := @POINT + '1',-822.9139,2704.841,108.5406,0,0,0,100,0), -- 02:30:12
(@GUID,@POINT := @POINT + '1',-824.9557,2707.254,109.1384,0,0,0,100,0), -- 02:30:13
(@GUID,@POINT := @POINT + '1',-822.1829,2711.187,109.6212,0,0,0,100,0), -- 02:30:15
(@GUID,@POINT := @POINT + '1',-820.9127,2714.733,110.107,0,0,0,100,0), -- 02:30:18 --
(@GUID,@POINT := @POINT + '1',-815.1783,2724.23,111.5192,0,0,0,100,0), -- 02:30:24
(@GUID,@POINT := @POINT + '1',-810.7725,2732.773,113.6527,0,0,0,100,0), -- 02:30:28
(@GUID,@POINT := @POINT + '1',-808.1324,2738.118,115.3095,0,0,0,100,0), -- 02:30:31
(@GUID,@POINT := @POINT + '1',-807.3273,2739.819,115.4474,0,0,0,100,0), -- 02:30:36 --
(@GUID,@POINT := @POINT + '1',-807.5845,2738.5500,115.1652,0,0,0,100,0); -- 15 min wait
-- 0x203CCC42401076000031F90000015772 .go -784.4011 2704.242 107.1181

-- ----------------------------------------------------------
-- https://github.com/Looking4Group/L4G_Core/issues/886
-- Event with Huffer/Grulloc doesn't start.
-- ----------------------------------------------------------
-- This is only a hackfix for now that will at least allow players to do the quest in a semi-intended way. The quest item and related spell will need to be fixed in the core at some point.

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (22114);
INSERT INTO `creature_ai_scripts` VALUES
('2211401','22114','11','0','100','0','0','0','0','0','102','0','0','0','44','37486','71899','0','0','0','0','0','Huffer - Cast Taunt on Grulloc and set Huffer to passive so he doesnt fight back'),
('2211402','22114','1','0','100','0','10000','11000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Huffer - Despawn self');

SET @ENTRY := 22114;
UPDATE `creature_template` SET `AIName`='EventAI',`MovementType`=2 WHERE `entry` = 22114;
DELETE FROM `creature_template_addon` WHERE `entry`= @ENTRY;
INSERT INTO `creature_template_addon` (`entry`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@ENTRY,@ENTRY,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`= @ENTRY;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@ENTRY,1,'2683.599609','5561.506836','-8.377452',0,1,0,100,0),
(@ENTRY,2,'2683.599609','5561.506836','-8.377452',6000,1,0,100,0),
(@ENTRY,3,'2696.265137','5606.458984','-11.300397',0,1,0,100,0),
(@ENTRY,4,'2696.407471','5635.058594','-12.258788',0,1,0,100,0),
(@ENTRY,5,'2671.907715','5689.815430','-15.508551',0,1,0,100,0);

UPDATE `creature` SET `position_x`='-170.9876', `position_y`='5530.2988', `position_z`='29.4076', `orientation`='3.4761' WHERE `guid` = 67880;

-- 110k-120k
DELETE FROM `creature` WHERE `guid` IN (117310,117311,117371,117372,117421,117422,117423,117614,117633,117634,117646,117648,117649);
UPDATE `creature_template` SET `faction_A` = 1865, `faction_H` = 1865 WHERE `entry` = 23142;
UPDATE `creature_template` SET `minlevel`='68',`maxlevel`='68',`minhealth`='5311',`maxhealth`='5311',`armor`='5954',`faction_A`='62',`faction_H`='62',`npcflag`=`npcflag`|128|4096  WHERE `entry` = 23144;
INSERT INTO `creature` VALUES (117310, 23142, 530, 1, 0, 0, -5116.79, 602.136, 85.0878, 4.86947, 180, 0, 0, 6326, 0, 0, 0);
INSERT INTO `creature` VALUES (117311, 21060, 530, 1, 14515, 0, -2725.46, 817.03, -4.67013, 3.47707, 180, 5, 0, 5409, 3080, 0, 1);
INSERT INTO `creature` VALUES (117371, 23142, 530, 1, 0, 0, -5113.69, 599.206, 85.202, 3.52556, 180, 0, 0, 6326, 0, 0, 0);
INSERT INTO `creature` VALUES (117372, 23142, 530, 1, 0, 0, -5120.31, 601.432, 84.8131, 5.48033, 180, 0, 0, 6326, 0, 0, 0);
INSERT INTO `creature` VALUES (117421, 23142, 530, 1, 0, 0, -5121.04, 598.197, 84.8804, 0.366519, 180, 0, 0, 6326, 0, 0, 0);
INSERT INTO `creature` VALUES (117422, 23146, 530, 1, 0, 0, -5166.38, 563.994, 80.506, 3.21141, 180, 0, 0, 143620, 0, 0, 0);
INSERT INTO `creature` VALUES (117423, 23146, 530, 1, 0, 0, -5143.49, 515.507, 84.5, 4.83456, 180, 0, 0, 143620, 0, 0, 0);
INSERT INTO `creature` VALUES (117614, 23146, 530, 1, 0, 0, -5162.25, 534.28, 82.7053, 5.18363, 180, 0, 0, 143620, 0, 0, 0);
INSERT INTO `creature` VALUES (117633, 22252, 530, 1, 0, 0, -5121.29, 524.294, 85.979, 5.02271, 180, 0, 0, 3271, 0, 0, 0);
INSERT INTO `creature` VALUES (117634, 22252, 530, 1, 0, 0, -5116, 526.488, 86.1381, 5.08868, 180, 0, 0, 3271, 0, 0, 0);
INSERT INTO `creature` VALUES (117646, 22252, 530, 1, 0, 0, -5119.86, 518.446, 85.544, 2.56205, 180, 0, 0, 3271, 0, 0, 0);
INSERT INTO `creature` VALUES (117648, 22252, 530, 1, 0, 0, -5124.66, 631.394, 86.794, 0.331613, 180, 0, 0, 3271, 0, 0, 0);
INSERT INTO `creature` VALUES (117649, 22252, 530, 1, 0, 0, -5121.2, 632.552, 86.8863, 3.29867, 180, 0, 0, 3271, 0, 0, 0);
-- 120k-130k
DELETE FROM `creature` WHERE `guid` IN (120880,120881,120882,120883,120884,120903,120904,120905,120907,122728,122732,122953,123103,123108,124444);
INSERT INTO `creature` VALUES (120880, 21060, 530, 1, 14515, 0, -2717.49, 774.845, -16.7461, 4.80831, 180, 5, 0, 5409, 3080, 0, 1);
INSERT INTO `creature` VALUES (120881, 21736, 530, 1, 0, 0, -3781.84, 2286.79, 82.529, 6.07208, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (120882, 21736, 530, 1, 0, 0, -3782.08, 2290.53, 83.5589, 5.4327, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (120883, 21736, 530, 1, 0, 0, -3783.26, 2281.75, 82.709, 5.4327, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (120884, 21736, 530, 1, 0, 0, -3816.22, 2288.03, 91.8103, 5.4327, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (120903, 21736, 530, 1, 0, 0, -3816.1, 2284.48, 91.1192, 5.4327, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (120904, 21736, 530, 1, 0, 0, -3785.57, 2248.95, 87.2404, 3.77159, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (120905, 21736, 530, 1, 0, 0, -3783.47, 2246.63, 86.9104, 3.77159, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (120907, 21736, 530, 1, 0, 0, -3785.35, 2220.39, 86.664, 3.34433, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (122728, 13321, 429, 1, 0, 0, -21.3831, -431.467, -58.527, 3.7001, 7200, 0, 0, 40, 0, 0, 0);
INSERT INTO `creature` VALUES (122732, 13321, 429, 1, 0, 0, 1.08285, -427.635, -58.2154, 0.942478, 7200, 0, 0, 40, 0, 0, 0);
INSERT INTO `creature` VALUES (122953, 13321, 429, 1, 0, 0, -21.032, -425.93, -58.1864, 1.81514, 7200, 0, 0, 40, 0, 0, 0);
INSERT INTO `creature` VALUES (123103, 21736, 530, 1, 0, 0, -3783.41, 2216.37, 86.0964, 3.34433, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (123108, 21736, 530, 1, 0, 0, -3787.32, 2215.57, 86.4413, 0.932562, 300, 1, 0, 9489, 0, 0, 1);
INSERT INTO `creature` VALUES (124444, 21736, 530, 1, 0, 0, -3846.24, 2250.47, 95.5393, 4.37575, 300, 1, 0, 9489, 0, 0, 1);

-- ----------------------------------------------------------
-- Caretaker Dilandrus
-- ----------------------------------------------------------
-- Negative spawntime means the item starts as despawned. When it's spawned by the script this is the number of seconds it takes to despawn again
UPDATE `gameobject` SET `spawntimesecs`=-301 WHERE `guid` IN (21211,21212,21213,21214,21215,21210);
 
DELETE FROM `waypoint_scripts` WHERE `id` BETWEEN 5802101 AND 5802109;
INSERT INTO `waypoint_scripts` (`id`,`delay`,`command`,`datalong`,`datalong2`,`guid`,`comment`) VALUES
(5802101,0,1,66,1,5802101,'Caretaker Dilandrus - Salute Emote'),
(5802102,0,1,16,1,5802102,'Caretaker Dilandrus - Kneel Emote'),
(5802103,0,9,21211,300,5802103,'Caretaker Dilandrus - Respawn grave flower 1'),
(5802104,0,1,18,1,5802104,'Caretaker Dilandrus - Cry Emote'),
(5802105,0,9,21212,300,5802105,'Caretaker Dilandrus - Respawn grave flower 2'),
(5802106,0,9,21213,300,5802106,'Caretaker Dilandrus - Respawn grave flower 3'),
(5802107,0,9,21214,300,5802107,'Caretaker Dilandrus - Respawn grave flower 4'),
(5802108,0,9,21215,300,5802108,'Caretaker Dilandrus - Respawn grave flower 5'),
(5802109,0,9,21210,300,5802109,'Caretaker Dilandrus - Respawn grave flower 6');
 
UPDATE `creature_template` SET `speed` = 1 WHERE `entry` = 16856;
 
-- Gossip
DELETE FROM `npc_text` WHERE `id` = 5;
INSERT INTO `npc_text` (`id`,`text0_0`,`text0_1`) VALUES
(5,'I was born here, $R. This is my world - all that I know... As a boy my mother and father would regale me with tales of your world and the splendor it held. How I longed to leave this place.$B$BAlas, fate is a cruel mistress. My mother and father have long since passed, buried in this very graveyard. I remain to uphold their honor and the honor of my family - the Sons of Lothar.','I was born here, $R. This is my world - all that I know... As a boy my mother and father would regale me with tales of your world and the splendor it held. How I longed to leave this place.$B$BAlas, fate is a cruel mistress. My mother and father have long since passed, buried in this very graveyard. I remain to uphold their honor and the honor of my family - the Sons of Lothar.');
DELETE FROM `npc_gossip` WHERE `npc_guid` = 58021;
INSERT INTO `npc_gossip` VALUES
(58021,5);
 
-- Pathing for  Entry: 16856 'TDB FORMAT'
SET @GUID := 58021;
SET @POINT := 0;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-784.4011,`position_y`=2704.242,`position_z`=107.1181 WHERE `guid`=@GUID;
DELETE FROM `creature_addon` WHERE `guid`=@GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (@GUID,@GUID,0,0,4097,0, '');
DELETE FROM `waypoint_data` WHERE `id`=@GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1',-807.2846,2727.0644,112.3538,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-784.4011,2704.242,107.1181,0,0,0,100,0), -- 02:28:27
(@GUID,@POINT := @POINT + '1',-786.1865,2701.929,106.4698,0,0,0,100,0), -- 02:28:36
(@GUID,@POINT := @POINT + '1',-787.6518,2700.579,105.934,0,0,0,100,0), -- 02:28:39 --
(@GUID,@POINT := @POINT + '1',-787.8432,2700.6953,105.8141,3000,0,5802101,100,0), -- Salute
(@GUID,@POINT := @POINT + '1',-787.8432,2700.6953,105.8141,0,0,5802103,100,0), -- Kneel
(@GUID,@POINT := @POINT + '1',-787.8432,2700.6953,105.8141,5000,0,5802102,100,0), -- Spawn flower
(@GUID,@POINT := @POINT + '1',-792.1684,2694.501,105.0721,0,0,0,100,0), -- 02:28:46
(@GUID,@POINT := @POINT + '1',-792.685,2693.922,104.7101,0,0,0,100,0), -- 02:28:49 --
(@GUID,@POINT := @POINT + '1',-793.0121,2694.0087,104.6103,6000,0,1069,100,0), -- Use emote
(@GUID,@POINT := @POINT + '1',-795.5505,2696.909,105.3471,0,0,1000,100,0), -- Turn off use emote
(@GUID,@POINT := @POINT + '1',-797.916,2697.396,105.4841,0,0,5802105,100,0), -- Kneel
(@GUID,@POINT := @POINT + '1',-797.916,2697.396,105.4841,5000,0,5802102,100,0), -- Spawn flower
(@GUID,@POINT := @POINT + '1',-792.765,2704.767,106.8859,0,0,0,100,0), --
(@GUID,@POINT := @POINT + '1',-792.2449,2707.191,107.5509,0,0,0,100,0), -- 02:29:04
(@GUID,@POINT := @POINT + '1',-794.0685,2709.671,108.3569,0,0,0,100,0), -- 02:29:05
(@GUID,@POINT := @POINT + '1',-797.7253,2709.18,108.0311,0,0,0,100,0), -- 02:29:07
(@GUID,@POINT := @POINT + '1',-800.4393,2705.978,107.5758,0,0,0,100,0), -- 02:29:09
(@GUID,@POINT := @POINT + '1',-803.6293,2699.97,106.5134,0,0,0,100,0), -- 02:29:11
(@GUID,@POINT := @POINT + '1',-807.278,2694.193,105.6765,0,0,0,100,0), -- 02:29:13
(@GUID,@POINT := @POINT + '1',-808.0405,2693.319,105.0343,0,0,0,100,0), -- 02:29:17 --
(@GUID,@POINT := @POINT + '1',-808.4829,2693.4536,104.9821,5000,0,5802104,100,0), -- Cry
(@GUID,@POINT := @POINT + '1',-808.4829,2693.4536,104.9821,2000,0,5802106,100,0), -- Spawn flower
(@GUID,@POINT := @POINT + '1',-812.295,2692.416,104.9431,0,0,0,100,0), -- 02:29:24
(@GUID,@POINT := @POINT + '1',-814.4872,2694.548,105.5211,0,0,0,100,0), -- 02:29:26
(@GUID,@POINT := @POINT + '1',-812.0645,2698.351,106.6527,0,0,0,100,0), -- 02:29:27
(@GUID,@POINT := @POINT + '1',-810.0867,2701.277,107.2569,0,0,0,100,0), -- 02:29:29
(@GUID,@POINT := @POINT + '1',-809.0142,2703.514,107.4949,0,0,0,100,0), -- 02:29:33 --
(@GUID,@POINT := @POINT + '1',-809.2995,2703.7104,107.4316,5000,0,1069,100,0), -- Use emote
(@GUID,@POINT := @POINT + '1',-804.4795,2711.166,108.7988,0,0,1000,100,0), -- Turn off use emote
(@GUID,@POINT := @POINT + '1',-803.1904,2712.994,109.2391,0,0,0,100,0), -- 02:29:40
(@GUID,@POINT := @POINT + '1',-801.8869,2715.421,109.8517,0,0,0,100,0), -- 02:29:43 --
(@GUID,@POINT := @POINT + '1',-802.0388,2715.5146,109.7917,0,0,5802107,100,0), -- Kneel
(@GUID,@POINT := @POINT + '1',-802.0388,2715.5146,109.7917,5000,0,5802102,100,0), -- Spawn flower
(@GUID,@POINT := @POINT + '1',-804.9284,2720.378,111.2985,0,0,0,100,0), -- 02:29:47
(@GUID,@POINT := @POINT + '1',-808.2941,2719.672,110.8294,0,0,0,100,0), -- 02:29:49
(@GUID,@POINT := @POINT + '1',-810.041,2718.517,110.6133,0,0,0,100,0), -- 02:29:53 --
(@GUID,@POINT := @POINT + '1',-810.3601,2718.6601,110.4938,5000,0,5802101,100,0), -- Salute
(@GUID,@POINT := @POINT + '1',-812.5195,2714.51,109.9449,0,0,0,100,0), -- 02:29:58
(@GUID,@POINT := @POINT + '1',-814.9861,2710.911,109.4516,0,0,0,100,0), -- 02:30:01
(@GUID,@POINT := @POINT + '1',-818.0924,2705.116,108.5067,0,0,0,100,0), -- 02:30:02
(@GUID,@POINT := @POINT + '1',-820.6952,2701.716,107.7344,0,0,0,100,0), -- 02:30:07 --
(@GUID,@POINT := @POINT + '1',-820.8601,2701.7744,107.6350,0,0,5802108,100,0), -- Kneel
(@GUID,@POINT := @POINT + '1',-820.8601,2701.7744,107.6350,5000,0,5802102,100,0), -- Spawn flower
(@GUID,@POINT := @POINT + '1',-822.9139,2704.841,108.5406,0,0,0,100,0),
(@GUID,@POINT := @POINT + '1',-824.9557,2707.254,109.1384,0,0,0,100,0), -- 02:30:13
(@GUID,@POINT := @POINT + '1',-822.1829,2711.187,109.6212,0,0,0,100,0), -- 02:30:15
(@GUID,@POINT := @POINT + '1',-820.9127,2714.733,110.107,0,0,0,100,0), -- 02:30:18 --
(@GUID,@POINT := @POINT + '1',-821.0661,2714.8603,110.0726,0,0,5802109,100,0), -- Kneel
(@GUID,@POINT := @POINT + '1',-821.0661,2714.8603,110.0726,5000,0,5802102,100,0), -- Spawn flower
(@GUID,@POINT := @POINT + '1',-815.1783,2724.23,111.5192,0,0,0,100,0), --
(@GUID,@POINT := @POINT + '1',-810.7725,2732.773,113.6527,0,0,0,100,0), -- 02:30:28
(@GUID,@POINT := @POINT + '1',-808.1324,2738.118,115.3095,0,0,0,100,0), -- 02:30:31
(@GUID,@POINT := @POINT + '1',-807.3273,2739.819,115.4474,0,0,0,100,0), -- 02:30:36 --
(@GUID,@POINT := @POINT + '1',-807.5845,2738.5500,115.1652,600000,0,0,100,0); -- 10 min wait
-- 0x203CCC42401076000031F90000015772 .go -784.4011 2704.242 107.1181
