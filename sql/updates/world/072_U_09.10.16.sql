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
SET @GUID := 52311;
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
