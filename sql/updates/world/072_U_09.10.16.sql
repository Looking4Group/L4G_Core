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
