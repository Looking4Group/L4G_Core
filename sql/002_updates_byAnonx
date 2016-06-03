-- Quest 10935
UPDATE `creature_template` SET `npcflag`='3',`ScriptName`='npc_anchorite_barada' WHERE `entry` IN ('22431');
--
-- Boulderfist Invader 18260 Unkor the Ruthless 18262
UPDATE `creature` SET `spawntimesecs`='120' WHERE `id` IN ('18260'); -- 300
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='0',`RewOnKillRepValue2`='0' WHERE `creature_id` IN ('18260'); -- 10 10
UPDATE `creature` SET `spawntimesecs`='150' WHERE `id` IN ('18262'); -- 300
UPDATE `creature_template` SET `minlevel`='68',`maxlevel`='68',`armor`='6200',`minhealth`='10000',`maxhealth`='10000' WHERE `entry` IN ('18262'); -- 65 20 9300

DELETE FROM `creature_addon` WHERE `guid` IN ('65533','65535','65547');
INSERT INTO `creature_addon` VALUES
(65533,0,0,16777472,0,4097,10,0,''),
(65535,0,0,16777472,0,4097,10,0,''),
(65547,0,0,16777472,1,4097,0,0,'');
--
-- Prince Malchezaar's Axes
--
-- Core needs #define AXE_EQUIP_INFO           33448898 changed to 218169346 then they are always visible i think. its wrong number thats y the axes vanish all the time
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`AIName`='EventAI',`attackpower`='100000',`speed`='1.48',`unit_flags`='258' WHERE `entry` IN ('17650'); -- 35 9 1 2
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17650');
INSERT INTO `creature_ai_scripts` VALUES
('1765001','17650','0','0','100','3','7500','25000','7500','25000','14','-99','0','0','13','100','4','0','0','0','0','0','Prince Malchezaar\'s Axes - Reset Threat and Attack New Target and Increase Dmg'),
('1765002','17650','0','0','100','3','9000','9000','9000','9000','11','32851','0','7','0','0','0','0','0','0','0','0','Prince Malchezaar\'s Axes - Increase Dmg');
--
DELETE FROM `creature` WHERE `creature`.`guid` = 85055;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(85055, 15551, 532, 1, 16399, 523, -11143.2, -1935.59, 49.8911, 0.625177, 1800, 0, 0, 33534, 31550, 0, 0);
--
-- Netherspite - Nethergroll 15689
UPDATE `creature_template` SET `mindmg`='12293',`maxdmg`='12830',`baseattacktime`='2000',`speed`='3.00',`faction_A`='14',`faction_H`='14' WHERE `entry` IN ('15689'); -- 1194 neutral 
-- aura fix
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry` IN ('15689'); -- 30522 0 
-- movement
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN  ('16800040');
SET @NPC := 16800040;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-11135.6240','-1581.1112','278.7943',0,0,0,100,0),
(@PATH,2,'-11141.0673','-1603.4708','278.7943',0,0,0,100,0),
(@PATH,3,'-11133.3720','-1623.3416','278.7943',0,0,0,100,0),
(@PATH,4,'-11108.1552','-1637.3908','278.7943',0,0,0,100,0),
(@PATH,5,'-11076.3671','-1611.6318','279.3620',0,0,0,100,0),
(@PATH,6,'-11108.1552','-1637.3908','278.7943',0,0,0,100,0),
(@PATH,7,'-11133.3720','-1623.3416','278.7943',0,0,0,100,0),
(@PATH,8,'-11141.0673','-1603.4708','278.7943',0,0,0,100,0),
(@PATH,9,'-11135.6240','-1581.1112','278.7943',0,0,0,100,0);
-- (@PATH,6,'-11088.6484','-1587.2272','279.9496',0,0,0,100,0),
-- (@PATH,7,'-11114.5283','-1575.2803','279.3625',0,0,0,100,0);
--
UPDATE `creature` SET `id`='16596' WHERE `guid` IN ('85355','85354','85353','85359');
--
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('19982');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19982');
INSERT INTO `creature_ai_scripts` VALUES
(1998201,19982,0,0,100,1,5500,5500,14000,15000,11,38541,0,1,0,0,0,0,0,0,0,0,'Vekh\'nir Keeneye - Casts Evasion'),
(1998202,19982,0,0,100,1,3500,4000,10000,11000,11,35321,1,32,0,0,0,0,0,0,0,0,'Vekh\'nir Keeneye - Casts Gushing Wound');
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20747');
INSERT INTO `creature_ai_scripts` VALUES
-- emote
('2074701','20747','2','0','50','1','20','0','1000','2000','11','36948','0','1','37','0','0','0','0','0','0','0','Silkwing Larva - Cast Silkwing and Kill Self');
-- Silkwing
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`AIName`='EventAI' WHERE `entry` IN ('21373');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21373');
INSERT INTO `creature_ai_scripts` VALUES
(2137301,21373,0,0,100,1,3500,4000,10000,14000,11,32914,0,0,0,0,0,0,0,0,0,0,'Silkwing - Casts Wing Buffet'),
(2137302,21373,11,0,100,1,0,0,0,0,103,10,0,0,0,0,0,0,0,0,0,0,'Silkwing - Attack near Target on Spawn'),
(2137303,21373,1,0,100,1,10000,10000,0,0,41,0,0,0,0,0,0,0,0,0,0,0,'Silkwing - Despawn OOC Timer');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/1908/quest-gauging-the-resonant-frequency
--
--
-- Oscillating Frequency Scanner Master Bunny 21760 
-- model wird nicht angezeigt 13069
-- fehlt da n script?
UPDATE `creature_template` SET `AIName`='EventAI',`unit_flags`='33554432' WHERE `entry` IN ('21796');
-- 37503 summon wyrm spell zum item hinzufügen
-- Oscillating Frequency Scanners Item
UPDATE `item_template` SET `spellid_2`='37503',`spellcooldown_2`='10000',`spellcategorycooldown_2`='10000' WHERE `entry` IN (''); -- 0 -1 -1
-- 20476 alternatives model da model 11686 wird nicht angezeigt
-- Wyrm from Beyond should only spawn with quest
DELETE FROM `creature` WHERE `id` IN ('21796');
UPDATE `creature_template` SET `AIName`='EventAI',`unit_flags`='0',`modelid_A`='20476',`modelid_H`='20476' WHERE `entry` IN ('21796');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21796');
INSERT INTO `creature_ai_scripts` VALUES
(2179602,21796,0,0,100,1,2500,7500,14000,18000,11,13321,1,0,0,0,0,0,0,0,0,0,'Wyrm from Beyond - Casts Mana Burn'),
(2179603,21796,0,0,100,1,5000,6000,12000,13000,11,36574,0,1,0,0,0,0,0,0,0,0,'Wyrm from Beyond - Casts Phase Slip');
-- Prince Malchezaar
UPDATE `creature_template` SET `mindmg`='5310',`maxdmg`='7509',`baseattacktime`='2000',`mechanic_immune_mask`='650854239' WHERE `entry` IN ('15690'); 
-- repos
UPDATE `creature` SET `position_x`='-2771.1962', `position_y`='6434.4370', `position_z`='58.4952', `orientation`='6.0133',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('60237');
UPDATE `creature` SET `position_x`='-2772.8327', `position_y`='6425.0712', `position_z`='58.8107', `orientation`='0.0914',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('60236');
UPDATE `creature` SET `position_x`='-2897.5488', `position_y`='6391.3652', `position_z`='81.9105', `orientation`='1.591',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('60202');
UPDATE `creature` SET `position_x`='-2867.9140', `position_y`='6397.0200', `position_z`='80.9934', `orientation`='0.0835',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('60229');
UPDATE `creature` SET `position_x`='-2867.4921', `position_y`='6412.1059', `position_z`='80.8310', `orientation`='5.6205',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('60226');
UPDATE `creature` SET `position_x`='-2851.9106', `position_y`='6442.4023', `position_z`='82.6757', `orientation`='3.3104',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('60211');
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/760/weapons-on-guards
--
--
-- korkron-defender
-- By Skullhawk13 (33,001 – 9·28·288) on 2015/05/28 (Patch 6.1.2)		
-- They will use a sword and shield, or a two-handed mace...Apparently These orcs are too good for axes.
UPDATE `creature_template` SET `equipment_id`='8021' WHERE `entry` IN ('19362');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8021');
INSERT INTO `creature_equip_template` VALUES
(8021,36079,0,0,285345026 ,0,0,1,0,0);
-- some npcs only
UPDATE `creature` SET `equipment_id`='8022' WHERE `guid` IN ('69079','69090','69078','78928','69075','69083');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8022');
INSERT INTO `creature_equip_template` VALUES
(8022,31997,31746,0,218171138,234948100,0,3,1038,0);
--
-- general exp exploit fix
UPDATE `creature_template` SET `flags_extra`='64' WHERE `minhealth`<'1000' AND `minlevel`>='58' AND `flags_extra`='0';
-- visual fledermaus
UPDATE `creature_template` SET `inhabittype`='5' WHERE `entry` IN ('22040');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/420/elementarplateu-rework
--
--
--
-- spawns
--
-- 16800000 - 16800009
UPDATE `creature` SET `spawndist`='5',`movementtype`='1' WHERE `id` IN ('22310');
DELETE FROM `creature` WHERE `guid` IN ('16800000','16800001');
INSERT INTO `creature` VALUES
(16800000,22310,530,1,0,0,-840.0236,6542.0161,171.1328,5.9890,300,0,0,0,0,5,1),
(16800001,22311,530,1,0,0,-786.2155,6540.7275,173.1196,2.0817,300,0,0,0,0,5,1);
--
-- 12x Storming Wind-Ripper 22310
UPDATE `creature_template` SET `armor`='6100',`speed`='1.20',`resistance3`='0'  WHERE `entry` IN ('22310'); -- 20
UPDATE `creature_template_addon` SET `auras`='34304 0 34308 0' WHERE `entry` IN ('22310');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22310');
INSERT INTO `creature_ai_scripts` VALUES
(2231001,22310,0,0,100,1,10000,10000,10000,10000,11,12550,0,33,0,0,0,0,0,0,0,0,'Storming Wind-Ripper - Cast Lightning Shield IC'),
(2231002,22310,1,0,100,1,1000,1000,60000,60000,11,12550,0,1,0,0,0,0,0,0,0,0,'Storming Wind-Ripper - Cast Lightning Shield OOC'),
(2231003,22310,9,0,100,1,0,40,3000,6000,0,0,0,0,11,20295,1,0,0,0,0,0,'Storming Wind-Ripper - Cast Lighting Bolt');
--
-- 12x Raging Fire-Soul 22311
UPDATE `creature_template` SET `scriptname`='',`flags_extra`=`flags_extra`|'536870912' WHERE `entry` IN ('22311'); -- npc_erzuernte_FeuerseeleAI und mmap disable for reset issues
UPDATE `creature_template_addon` SET `auras`='34305 0 34308 0' WHERE `entry` IN ('22311'); -- 29948 0 needs core spellwork to function as proper aura
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22311');
--
-- 10x Rumbling Earth-Heart 22313
-- movement 4 two or so
UPDATE `creature_template` SET `speed`='1.20',`AIName`='EventAI' WHERE `entry` IN ('22313');
UPDATE `creature_template_addon` SET `auras`='34308 0' WHERE `entry` IN ('22313');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22313');
INSERT INTO `creature_ai_scripts` VALUES
(2231301,22313,9,0,100,1,0,5,14000,16000,11,33840,0,0,0,0,0,0,0,0,0,0,'Rumbling Earth-Heart  - Cast Earth Rumble'),
(2231302,22313,2,0,100,0,30,0,0,0,11,8599,0,0,1,-106,0,0,0,0,0,0,'Rumbling Earth-Heart - Casts Enrage at 30% HP');
--
-- 14x Crashing Wave-Spirit 22309 npc_Wasserelementar
UPDATE `creature_template` SET `speed`='1.20',`resistance4`='0' WHERE `entry` IN ('22309');
UPDATE `creature_template_addon` SET `auras`='34306 0' WHERE `entry` IN ('22309');
--
--
--  repos
--
UPDATE `creature` SET `movementtype`='1',`spawndist`='5' WHERE `id` IN ('22311');
UPDATE `creature` SET `position_x`='-825.3634', `position_y`='6618.4624', `position_z`='175.4391' WHERE `guid` IN ('78466');
UPDATE `creature` SET `position_x`='-794.4229', `position_y`='6581.7529', `position_z`='171.3957' WHERE `guid` IN ('78474');
UPDATE `creature` SET `position_x`='-679.4104', `position_y`='6566.6533', `position_z`='170.9530' WHERE `guid` IN ('78473');
UPDATE `creature` SET `position_x`='-750.3014', `position_y`='6551.8862', `position_z`='170.9357' WHERE `guid` IN ('78471');
--
UPDATE `creature_template` SET `mindmg`='1894',`maxdmg`='2495',`mechanic_immune_mask`='787431423',`baseattacktime`='1400' WHERE `entry` IN ('20870');  --
UPDATE `creature_template` SET `speed`='1.71',`armor`='7400',`mindmg`='4279',`maxdmg`='5081',`unit_flags`='64',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21626'); -- 6419 - 7621
--
UPDATE `creature_template` SET `armor`='6800',`maxhealth`='23278',`mindmg`='1054',`maxdmg`='1801',`mechanic_immune_mask`='720327677',`dmgschool`='6' WHERE `entry` IN ('18405'); -- 206 206 0
UPDATE `creature_template` SET `armor`='7700',`maxhealth`='71836',`mindmg`='4857',`maxdmg`='5069',`speed`='1.48',`mechanic_immune_mask`='720327677',`dmgschool`='6' WHERE `entry` IN ('21578'); -- 2270 2693
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20886');
INSERT INTO `creature_ai_scripts` VALUES
('2088601','20886','4','0','100','3','0','0','0','0','11','36051','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Normal) - Fel Immolation on Aggro'),
('2088602','20886','4','0','100','5','0','0','0','0','11','39007','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Heroic) - Immolation on Aggro'),
('2088603','20886','0','0','100','3','10000','10000','20000','30000','11','35759','1','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Normal) - Cast Felfire Shock'),
('2088604','20886','0','0','100','5','10000','10000','20000','30000','11','39006','1','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Heroic) - Cast Felfire Shock'),
('2088605','20886','0','0','100','7','21000','21000','30000','30000','11','36512','0','7','21','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Cast Knock Away and Stop Movement'),
('2088606','20886','0','0','100','7','22000','22000','30000','30000','12','20978','0','20000','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Summon Felfire Line'),
('2088607','20886','0','0','100','7','23000','23000','30000','30000','11','20508','4','7','1','-23','-24','0','0','0','0','0','Wrath-Scryer Soccothrates - Cast Charge and Random Say/Sound'),
('2088608','20886','0','0','100','7','22500','22500','30000','30000','21','1',' 0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Start move'),
('2088609','20886','6','0','100','6','0','0','0','0','1','-25','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - On Creature Death Say/Sound'),
('2088610','20886','5','0','100','7','0','0','0','0','1','-26','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - On Player Death Say/Sound'),
('2088611','20886','4','0','100','6','0','0','0','0','1','-27','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Aggro Say/Sound'),
('2088612','20886','1','0','100','6','0','0','31000','31000','1','-28','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Not in Combat Sound/Yell'),
('2088613','20886','1','0','40','6','0','0','5000','5000','4','11236','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Not in Combat Sound'),
('2088614','20886','4','0','100','6','0','0','0','0','34','3','1','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Set Instance Data on Aggro'),
('2088615','20886','6','0','100','6','0','0','0','0','34','3','3','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Set Instance Data on Death'),
('2088616','20886','7','0','100','6','0','0','0','0','34','3','2','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Set Instance Data on Evade');

DELETE FROM `creature_ai_scripts` WHERE `id` IN ('2088510','2088511','2088512','2088513');
INSERT INTO `creature_ai_scripts` VALUES
(2088510,20885,4,0,100,7,0,0,0,0,11,29651,0,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer - Cast Dual Wield on Aggro'),
(2088511,20885,9,0,100,5,7,40,10000,15000,11,39016,4,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer (Heroic) - Cast Shadow Wave'),
(2088512,20885,0,0,100,5,21100,21100,30000,30000,11,39013,0,0,1,-77,-78,0,9,11091,11092,-1,'Dalliah the Doomsayer (Heroic) - Cast Heal'),
(2088513,20885,9,0,100,5,0,10,8500,10000,11,39009,1,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer (Heroic) - Cast Gift of the Doomsayer');
-- no heal cuz of server lag
UPDATE `creature_ai_scripts` SET `event_param1`='21100',`event_param2`='21100' WHERE `id` IN ('2088506');
--
-- target dummy enhancements
UPDATE `creature_template` SET `scale`='2',`minhealth`='1000000000',`maxhealth`='1000000000',`subname`='6200 Armor' WHERE `entry` IN ('1200062','1200063');
UPDATE `creature_template` SET `scale`='2',`minhealth`='1000000000',`maxhealth`='1000000000',`subname`='7700 Armor' WHERE `entry` IN ('1200064','1200065');
