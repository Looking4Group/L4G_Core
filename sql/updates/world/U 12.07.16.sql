-- NPC RECHECK missing
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (16594);
INSERT INTO `creature_ai_scripts` VALUES
('1659401','16594','1','0','100','6','0','0','0','0','21','1','0','0','22','0','0','0','0','0','0','0','Shadowmoon Acolyte - Prevent Combat Movement and Set Phase to 0 on Spawn'),
('1659402','16594','1','0','100','7','1000','1000','3600000','3600000','11','30479','0','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte - Cast Resist Shadow on Spawn'),
('1659403','16594','4','0','100','2','0','0','0','0','11','31516','1','0','23','1','0','0','0','0','0','0','Shadowmoon Acolyte (Normal) - Cast Mind Blast and Set Phase 1 on Aggro'),
('1659404','16594','9','13','100','3','0','30','3400','4800','11','31516','1','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte (Normal) - Cast Mind Blast (Phase 1)'),
('1659405','16594','4','0','100','4','0','0','0','0','11','15587','1','0','23','1','0','0','0','0','0','0','Shadowmoon Acolyte (Heroic) - Cast Mind Blast and Set Phase 1 on Aggro'),
('1659406','16594','9','13','100','5','0','30','3400','4800','11','15587','1','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte (Heroic) - Cast Mind Blast (Phase 1)'),
('1659407','16594','3','13','100','6','7','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Shadowmoon Acolyte - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('1659408','16594','9','13','100','6','25','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte - Start Combat Movement at 25 Yards (Phase 1)'),
('1659409','16594','9','13','100','6','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1659410','16594','9','13','100','6','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte - Start Combat Movement Below 5 Yards'),
('1659411','16594','3','11','100','7','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1659412','16594','14','0','100','3','5000','40','20000','25000','11','35944','6','3','0','0','0','0','0','0','0','0','Shadowmoon Acolyte (Normal) - Cast Power Word: Shield'),
('1659413','16594','14','0','100','5','5000','40','20000','25000','11','36052','6','3','0','0','0','0','0','0','0','0','Shadowmoon Acolyte (Heroic) - Cast Power Word: Shield'),
('1659414','16594','14','0','100','3','8000','30','7000','7000','11','15585','0','1','0','0','0','0','0','0','0','0','Shadowmoon Acolyte (Normal) - Cast Prayer of Healing'),
('1659415','16594','14','0','100','5','8000','30','7000','7000','11','35943','0','1','0','0','0','0','0','0','0','0','Shadowmoon Acolyte (Heroic) - Cast Prayer of Healing'),
('1659416','16594','2','0','100','6','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte - Set Phase 3 at 15% HP'),
('1659417','16594','2','7','100','6','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Shadowmoon Acolyte - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1659418','16594','7','0','100','6','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Shadowmoon Acolyte - Set Phase to 0 on Evade');
--
--

UPDATE `creature` SET `id`='17694' WHERE `guid` IN ('57581');
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('1769401','1769408');
UPDATE `creature_ai_scripts` SET `action1_param2`='4',`action1_param3`='33' WHERE `id` IN ('1769413');
--
-- Shattered Hand Houndmaster 17670,20588
UPDATE `creature_template` SET `mechanic_immune_mask`='379665875' WHERE `entry` IN ('20588');
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('1767001');
UPDATE `creature_ai_scripts` SET `event_param2`='15',`action3_type`='29',`action3_param1`='15',`action3_param2`='360',`comment`='Shattered Hand Houndmaster - Prevent Combat Movement and Prevent Melee at 15 Yards (Phase 1)' WHERE `id` IN ('1767008');
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1767014');
INSERT INTO `creature_ai_scripts` VALUES
('1767014','17670','15','0','100','7','0','30','0','0','11','23859','6','3','1','-768','0','0','0','0','0','0','Shattered Hand Sharpshooter - Cast Despell on CCed Friendlys and Shout');
--
-- Bosses
--
-- Shattered Hand Blood Guard / Blood Guard Porung 17461,20992 
UPDATE `creature_template` SET `mindmg`='1671',`maxdmg`='2202',`equipment_id`='5607' WHERE `entry` IN ('17461'); -- 509 1040
UPDATE `creature_template` SET `ScriptName`='boss_blood_guard_porung',`mechanic_immune_mask`='1073725439',`mindmg`='6311',`maxdmg`='6577',`equipment_id`='5607' WHERE `entry` IN (20992); -- nicht exakt aber passend rotes 2h schwert
DELETE FROM `creature_equip_template` WHERE `entry` IN ('5607');
INSERT INTO `creature_equip_template` VALUES
(5607,20195,0,0,218171394,0,0,1,0,0);
--
-- Grand Warlock Nethekurse 16807,20568
-- Sollte ein anderes kleineres Schwert tragen
UPDATE `creature` SET `position_x`='178.8155', `position_y`='287.1836', `position_z`='-8.1846', `orientation`='4.6464',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('13681415');
UPDATE `creature_template` SET `equipment_id`='1187',`mindmg`='1830 ',`maxdmg`='2410 ' WHERE `entry` IN (16807); -- 558 1138 rotes 2h schwert
UPDATE `creature_template` SET `equipment_id`='1187',`mindmg`='5489',`maxdmg`='6029',`pickpocketloot`='16807',`baseattacktime`='0' WHERE `entry` IN (20568); 
--
-- Fel Orc Convert 17083,20567
UPDATE `creature_template` SET `minlevel`='68',`maxlevel`='69',`minhealth`='9803',`maxhealth`='10000',`mindmg`='566',`maxdmg`='745',`baseattacktime`='1400',`mechanic_immune_mask`='1' WHERE `entry` IN ('17083'); -- 173 352 -- 566 - 745
UPDATE `creature_template` SET `minhealth`='13972',`maxhealth`='14000',`mindmg`='1485',`maxdmg`='1765',`baseattacktime`='0',`lootid`='17083',`pickpocketloot`='17083',`mechanic_immune_mask`='1' WHERE `entry` IN ('20567'); -- 400 819 -- 2,228 - 2,647
--
-- Warbringer O'mrogg 16809,20596
UPDATE `creature_template` SET `mindmg`='2096',`maxdmg`='2763' WHERE `entry` IN ('16809'); -- 638 1305 s1 2h hammer
UPDATE `creature_template` SET `mindmg`='6561',`maxdmg`='6925',`pickpocketloot`='16809' WHERE `entry` IN (20596); -- 2255 2802
-- 
-- Warchief Kargath Bladefist 16808,20597
-- 2 guids 3666851 5274944 npc flag 2 ? y
UPDATE  `creature` SET `spawnmask`='3',`spawntimesecs`='43200' WHERE `guid` IN ('5274944');
UPDATE `creature_template` SET `mindmg`='1807',`maxdmg`='2382' WHERE `entry` IN ('16808'); -- 550 1125
UPDATE `creature_template` SET `mindmg`='7141',`maxdmg`='7521',`pickpocketloot`='16808' WHERE `entry` IN (20597); --
DELETE FROM `creature_template_addon` WHERE `entry` IN ('16808','20597');
INSERT INTO `creature_template_addon` VALUES
(16808,0,0,512,0,4097,0,0,'18950 0 18950 1'),
(20597,0,0,512,0,4097,0,0,'18950 0 18950 1');
--
-- Heathen Guard 17621,20569
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='708',`maxdmg`='932',`equipment_id`='1290',`AIName`='EventAI' WHERE `entry` IN ('17621'); -- 216 440
UPDATE `creature_template` SET `mindmg`='1500',`maxdmg`='1763',`armor`='6800',`equipment_id`='1290' WHERE `entry` IN ('20569'); -- 557 1077
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17621','20569');
INSERT INTO `creature_template_addon` VALUES
(17621,0,0,512,0,4097,0,0,''),
(20569,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17621');
INSERT INTO `creature_ai_scripts` VALUES
('1762101','17621','9','0','100','7','0','5','10000','12000','11','30474','1','0','0','0','0','0','0','0','0','0','Heathen Guard - Cast Bloodthirst'),
('1762102','17621','2','0','100','7','30','0','120000','120000','11','30485','0','1','1','-106','0','0','0','0','0','0','Heathen Guard - Cast Enrage at 30% HP');
--
-- Sharpshooter Guard 17622,20578
-- equipslot 3 31747 polish 17622 ai
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='708',`maxdmg`='932',`minrangedmg`='500',`maxrangedmg`='1000' WHERE `entry` IN ('17622'); -- 216 440
UPDATE `creature_template` SET `mindmg`='1500',`maxdmg`='1763',`armor`='6800',`minrangedmg`='1000',`maxrangedmg`='2000' WHERE `entry` IN ('20578'); -- 863 1642
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17622','20578');
INSERT INTO `creature_template_addon` VALUES
(17622,0,0,512,0,4098,0,0,''),
(20578,0,0,512,0,4098,0,0,'');
--
-- Reaver Guard 17623,20575
UPDATE `creature_template` SET `speed`='1.20',`equipment_id`='1429',`mindmg`='1008',`maxdmg`='1232',`baseattacktime`='2000' WHERE `entry` IN ('17623'); -- 216 440
UPDATE `creature_template` SET `armor`='6800',`mindmg`='2095',`maxdmg`='2495',`equipment_id`='1429' WHERE `entry` IN ('20575'); -- 748 1547
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17623','20575');
INSERT INTO `creature_template_addon` VALUES
(17623,0,0,512,0,4097,0,0,''),
(20575,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17623');
INSERT INTO `creature_ai_scripts` VALUES
('1762301','17623','9','0','100','7','0','7','6000','9000','11','15496','1','0','0','0','0','0','0','0','0','0','Shattered Hand Reaver - Cast Cleave'),
('1762302','17623','0','0','100','7','8000','12000','5000','10000','11','30471','1','0','13','-99','1','0','0','0','0','0','Shattered Hand Reaver - Cast Uppercut'),
('1762303','17623','2','0','100','7','30','0','120000','120000','11','30485','0','1','1','-106','0','0','0','0','0','0','Shattered Hand Reaver - Cast Enrage at 30% HP');
-- add rep
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='0',`RewOnKillRepValue2`='0' WHERE `creature_id` IN ('17621','17622','17623'); -- 2
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='0',`RewOnKillRepValue2`='0' WHERE `creature_id` IN ('20578'); -- 3 20569 nonexistent good
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='0',`RewOnKillRepValue2`='0' WHERE `creature_id` IN ('20575'); -- 4
--
-- Shattered Hand Executioner 17301,20585
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`equipment_id`='1429',`armor`='6800',`mindmg`='1476',`maxdmg`='2013',`baseattacktime`='2000',`mechanic_immune_mask`='1073692671',`speed`='1.48',`flags_extra`='65536' WHERE `entry` IN (16699); -- rote wirbelaxt 448 912 1420
UPDATE `creature_template` SET `equipment_id`='1429',`armor`='6800',`mindmg`='6405',`maxdmg`='6786',`faction_A`='1662',`faction_H`='1662',`speed`='1.48',`unit_flags`='1',`baseattacktime`='0',`mechanic_immune_mask`='1073692671',`flags_extra`='65536'  WHERE `entry` IN (20590); -- rote wirbelaxt 2188 2759
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17301','20585');
INSERT INTO `creature_template_addon` VALUES
(17301,0,0,512,0,4097,0,0,'18950 0 18950 1'),
(20585,0,0,512,0,4097,0,0,'18950 0 18950 1');
INSERT IGNORE INTO `creature_onkill_reputation` VALUES (20585,946,947,7,0,15,7,0,15,1);
INSERT IGNORE INTO `creature_loot_template` VALUES
(17301,22829,80,1,2,8,0,0,0),
(17301,22832,80,2,2,8,0,0,0),
(17301,33457,0,3,1,1,0,0,0),
(17301,33458,0,3,1,1,0,0,0),
(17301,33459,0,3,1,1,0,0,0),
(17301,33460,0,3,1,1,0,0,0),
(17301,33461,0,3,1,1,0,0,0),
(17301,33462,0,3,1,1,0,0,0),
--
(20585,22829,80,1,2,8,0,0,0),
(20585,22832,80,2,2,8,0,0,0),
(20585,33457,0,3,1,1,0,0,0),
(20585,33458,0,3,1,1,0,0,0),
(20585,33459,0,3,1,1,0,0,0),
(20585,33460,0,3,1,1,0,0,0),
(20585,33461,0,3,1,1,0,0,0),
(20585,33462,0,3,1,1,0,0,0);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17301');
INSERT INTO `creature_ai_scripts` VALUES
('1730101','17301','9','0','100','7','0','5','5000','7000','11','15284','1','0','0','0','0','0','0','0','0','0','Shattered Hand Executioner - Cast Cleave'),
('1730102','17301','0','0','100','7','4000','8000','8000','12000','11','11876','0','1','0','0','0','0','0','0','0','0','Shattered Hand Executioner - Cast War Stomp');
--
--
--
--
--
--
-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================
-- 
--
DELETE FROM `creature` WHERE `guid` IN (13403387);
UPDATE `creature` SET `spawnMask`='3',`curhealth`='149420',`curmana`='60581' WHERE `guid` IN (13681415);
--
-- special npcs + npcs with false values
DELETE FROM `creature_addon` WHERE `guid` IN (18485,18838,18601,18788,18536,57700,57690,13540,11262,15610,57698,57694,15331,57688,57222,57223,57220,57221,163832,163872,163892,163676,163620,34034,34199,99998,20420,30418,31564,13540,32301,13590,24089,62926,62927,62932,99979,99965,99964,99963,99962,99961,99960,99959,85748,85749,85752,85753,11033,11074,113165,113221);

INSERT INTO `creature_addon` VALUES
(34034,0,0,0,3,0,12,0,''),
(34199,0,0,0,3,0,12,0,''),
(99998,0,0,0,3,0,12,0,''),
(18485,0,0,512,0,4098,376,0,''),
(18838,0,0,0,0,4097,375,0,''),
(18601,0,0,512,0,4098,376,0,''),
(18788,0,0,0,0,4097,375,0,''),
(18536,0,0,512,0,4098,376,0,''),
(57700,0,0,512,0,4098,376,0,''),
(57690,0,0,0,0,4097,375,0,''),
(13540,0,0,0,0,4097,0,0,''), -- caster no battle stance
(11262,0,0,512,0,4098,376,0,''),
(15610,0,0,0,0,4097,333,0,''),
(57698,0,0,512,0,4098,376,0,''),
(57694,0,0,0,0,4097,333,0,''),
(15331,0,0,0,0,4097,333,0,''),
(57688,0,0,0,0,4097,375,0,''),
(57222,0,0,0,0,4097,333,0,''),
(57223,0,0,0,0,4097,333,0,''),
(57220,0,0,0,0,4097,333,0,''),
(57221,0,0,0,0,4097,333,0,''),
(163832,0,0,0,0,4097,333,0,''),
(163872,0,0,0,0,4097,333,0,''),
(163892,0,0,0,0,4097,333,0,''),
(163676,0,0,0,0,4097,333,0,''),
(163620,0,0,0,0,4097,333,0,''),
(62926,0,0,0,0,4097,333,0,''),
(62927,0,0,0,0,4097,333,0,''),
(62932,0,0,0,0,4097,333,0,''),
(99979,0,0,0,0,4097,333,0,''),
(99965,0,0,0,0,4097,333,0,''),
(99964,0,0,0,0,4097,333,0,''),
(99963,0,0,0,0,4097,333,0,''),
(99962,0,0,0,0,4097,333,0,''),
(99961,0,0,0,0,4097,333,0,''),
(99960,0,0,0,0,4097,333,0,''),
(99959,0,0,0,0,4097,333,0,''),
(85748,0,0,0,0,4097,333,0,''),
(85749,0,0,0,0,4097,333,0,''),
(85752,0,0,0,0,4097,333,0,''),
(85753,0,0,0,0,4097,333,0,''),
(11033,0,0,0,0,4097,333,0,''),
(11074,0,0,0,0,4097,333,0,''),
(113165,0,0,0,0,4097,333,0,''),
(113221,0,0,0,0,4097,333,0,'');
--
UPDATE `creature_addon` SET `auras`='30472 0 30472 1 30472 2' WHERE `guid` IN (187294);
--
UPDATE `creature` SET `spawndist`='10',`MovementType`='1' WHERE `guid` IN (57855);
--
-- slight movement for rogues
UPDATE `creature` SET `MovementType` = '1',`spawndist`='5' WHERE `guid` IN ('112008','111481','110619','13590','13414','13244','15373','15466','86466');
-- adds bei 1 Boss
UPDATE `creature` SET `spawndist`='0',`MovementType`='0',`position_x`='175.5123',`position_y`='274.6477',`position_z`='-13.1881',`orientation`='1.3332' WHERE `guid`='59478';
UPDATE `creature` SET `spawndist`='0',`MovementType`='0',`position_x`='169.7071',`position_y`='275.8798',`position_z`='-13.1888',`orientation`='1.0819' WHERE `guid`='59479';
UPDATE `creature` SET `spawndist`='0',`MovementType`='0',`position_x`='181.3458',`position_y`='274.9934',`position_z`='-13.1926',`orientation`='1.7261' WHERE `guid`='59480';
UPDATE `creature` SET `spawndist`='0',`MovementType`='0',`position_x`='187.4927',`position_y`='275.7191',`position_z`='-13.1879',`orientation`='1.9733' WHERE `guid`='59481';
DELETE FROM `creature_addon` WHERE `guid` IN ('59478','59479','59480','59481');
INSERT INTO `creature_addon` VALUES 
(59478,0,0,0,8,4097,0,0,''),
(59479,0,0,0,8,4097,0,0,''),
(59480,0,0,0,8,4097,0,0,''),
(59481,0,0,0,8,4097,0,0,'');
--
-- Movement
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=11612;
SET @NPC := 11612;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,'30472 0 30472 1 30472 2'); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,513.0515,153.8430,1.9244,0,0,0,100,0),
(@PATH,2,524.3060,152.4040,1.9236,0,0,0,100,0); 
--
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=57693;
SET @NPC := 57693;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,'30472 0 30472 1 30472 2'); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,35.9639,1.4408,-13.2116,0,0,0,100,0),
(@PATH,2,60.2413,5.1070,-13.2089,0,0,0,100,0),
(@PATH,3,69.8133,19.0945,-13.2075,0,0,0,100,0),
(@PATH,4,70.0109,32.3430,-13.2046,0,0,0,100,0),
(@PATH,5,69.8133,19.0945,-13.2075,0,0,0,100,0),
(@PATH,6,60.2413,5.1070,-13.2089,0,0,0,100,0),
(@PATH,7,35.9639,1.4408,-13.2116,0,0,0,100,0),
(@PATH,8,24.0561,1.8183,-13.1981,0,0,0,100,0);
--
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=19314;
SET @NPC := 19314;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,'30472 0 30472 1 30472 2'); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,76.5898,203.8892,-13.1954,0,0,0,100,0),
(@PATH,2,62.5537,203.8860,-13.1971,0,0,0,100,0);
--
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=57695;
SET @NPC := 57695;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,'30472 0 30472 1 30472 2'); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,69.6280,158.9295,-13.2195,0,0,0,100,0),
(@PATH,2,69.7576,174.6510,-13.2070,0,0,0,100,0);
--
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=57696;
SET @NPC := 57696;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,391,0,'30472 0 30472 1 30472 2'); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,65.2870,268.8684,-13.2005,0,0,0,100,0), 
(@PATH,2,71.7101,263.7010,-13.2009,0,0,0,100,0), 
(@PATH,3,73.2797,265.7437,-13.2013,2700,0,0,100,0),
(@PATH,4,71.7101,263.7010,-13.2009,0,0,0,100,0),
(@PATH,5,78.9588,257.5530,-13.2005,0,0,0,100,0),
(@PATH,6,71.7101,263.7010,-13.2009,0,0,0,100,0),
(@PATH,7,73.2797,265.7437,-13.2013,2700,0,0,100,0),
(@PATH,8,71.7101,263.7010,-13.2009,0,0,0,100,0), 
(@PATH,9,65.2870,268.8684,-13.2005,0,0,0,100,0);
--
-- grp nach gauntlet boss
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=123402;
SET @NPC := 123402; 
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,'30472 0 30472 1 30472 2'); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,521.2297,217.6290,1.9231,0,0,0,100,0), 
(@PATH,2,529.8040,226.0390,1.9306,0,0,0,100,0);
--
-- 1st Hundemeisterpat
UPDATE `creature` SET `MovementType`='0' WHERE `guid` IN (134711);
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=136542;
SET @NPC := 136542;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,0,0,0,''); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,'1','519.9730','195.1775','1.9408','0','0','0','100','0'),
(@PATH,'2','518.6427','215.8883','1.9158','0','0','0','100','0'),
(@PATH,'3','519.9730','195.1775','1.9408','0','0','0','100','0'),
(@PATH,'4','518.8150','171.0599','1.9415','0','0','0','100','0'),
(@PATH,'5','503.0823','150.0780','1.9316','0','0','0','100','0'),   
(@PATH,'6','511.2404','137.6811','1.9329','0','0','0','100','0'),  
(@PATH,'7','526.5178','137.5205','1.9338','0','0','0','100','0'),    
(@PATH,'8','533.7495','154.7415','1.9302','0','0','0','100','0'),  
(@PATH,'9','518.8150','171.0599','1.9415','0','0','0','100','0');
--
-- 2nd Hundemeisterpat
UPDATE `creature` SET `MovementType`='0' WHERE `guid` IN (19742);
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=19868;
SET @NPC := 19868;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,''); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,'1','518.9190','68.9030','1.9103','0','0','0','100','0'),    
(@PATH,'2','505.4788','58.5282','1.9274','0','0','0','100','0'),
(@PATH,'3','473.6363','57.6172','1.9303','0','0','0','100','0'),
(@PATH,'4','429.1069','57.5724','2.0470','0','0','0','100','0'), 
(@PATH,'5','473.6363','57.6172','1.9303','0','0','0','100','0'), 
(@PATH,'6','505.4788','58.5282','1.9274','0','0','0','100','0'),   
(@PATH,'7','518.9190','68.9030','1.9103','0','0','0','100','0'),     
(@PATH,'8','518.2490','109.2559','1.9397','0','0','0','100','0');
--
-- 3rd Hundemeisterpat
UPDATE `creature` SET `MovementType`='0' WHERE `guid` IN (106659);
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=107109;
SET @NPC := 107109;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,''); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,'1','319.6603','-84.3010','1.9296','0','0','0','100','0'),
(@PATH,'2','364.5243','-84.1685','1.9203','0','0','0','100','0'),    
(@PATH,'3','374.8218','-69.1961','1.9160','0','0','0','100','0'),      
(@PATH,'4','374.4144','-15.9977','1.9386','0','0','0','100','0'),    
(@PATH,'5','374.8218','-69.1961','1.9160','0','0','0','100','0'),     
(@PATH,'6','364.5243','-84.1685','1.9203','0','0','0','100','0'),
(@PATH,'7','319.6603','-84.3010','1.9296','0','0','0','100','0'),
(@PATH,'8','284.3859','-84.4404','2.0522','0','0','0','100','0');
--
-- SpÃ¤her
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=107964;
SET @NPC := 107964;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1'); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,'1','363.6064','316.2029','1.9181','0','1','0','100','0'),
(@PATH,'2','403.6547','315.8898','1.9170','0','1','0','100','0'),
(@PATH,'3','450.6195','315.6488','1.9353','0','1','0','100','0'),
(@PATH,'4','403.6547','315.8898','1.9170','0','1','0','100','0'),
(@PATH,'5','363.6064','316.2029','1.9181','0','1','0','100','0');
--
-- Add Aura of Discipline to Shattered Hand Legionnaire, Glads fighting but no hp loss
DELETE FROM `creature_template_addon` WHERE `entry` IN (16700,20589,17464,20586);
INSERT INTO `creature_template_addon` VALUES
(16700,0,0,0,0,4097,0,0,'30472 0 30472 1 30472 2'),
(20589,0,0,0,0,4097,0,0,'30472 0 30472 1 30472 2'),
(17464,0,0,0,0,4097,389,0,''),
(20586,0,0,0,0,4097,389,0,'');
--
-- Stealth Sight for Warhounds
DELETE FROM `creature_addon` WHERE `guid` IN (19868,19889,107109,107255,136542,136592,63390,63391);
INSERT INTO `creature_addon` VALUES 
(19868,198680,0,16908544,0,4097,0,0,'18950 0 18950 1'),
(19889,0,0,16908544,0,4097,0,0,'18950 0 18950 1'),
(107109,1071090,0,16908544,0,4097,0,0,'18950 0 18950 1'),
(107255,0,0,16908544,0,4097,0,0,'18950 0 18950 1'),
(136542,1365420,0,0,0,0,0,0,'18950 0 18950 1'),
(136592,0,0,0,0,0,0,0,'18950 0 18950 1'),
(63390,0,0,16908544,0,4097,0,0,'18950 0 18950 1'),
(63391,0,0,16908544,0,4097,0,0,'18950 0 18950 1');
--
UPDATE `creature` SET `orientation`='0.0037' WHERE `guid` IN (62935);
UPDATE `creature` SET `orientation`='0.1170' WHERE `guid` IN (62948,62949);
UPDATE `creature` SET `orientation`='6.2713' WHERE `guid` IN (62938,62941);
--
-- ======================================================
-- Linking
-- ======================================================
--
-- Groups
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (30418,13681415,59478,59479,59480,59481,136542,3666851,113165,11033,85752,15484,85749,62946,62942,8439,62934,62938,121466,15480,16777014,117515,15373,63392,30418,18601,11262,106659,107255,19314,107109,19742,19868,11612,57695,57694,57220,20420,24360,136542,163620,57222);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (57696,32163,32301,31564,62872,62871,123402,122190,122141,121724,121269,136592,134711,13681415,59478,59479,59480,59481,136542,3666851,113165,11033,85752,15484,85749,62946,62942,8439,62934,62938,121466,15480,16777014,117515,15373,63392,30418,18601,11262,106659,107255,19314,107109,19742,19868,11612,57695,57694,57220,20420,24360,136542,163620,57222);
--
--
--
--
INSERT INTO `creature_formations` VALUES 
(13681415,13681415,60,360,2),
(13681415,59481,60,360,2),
(13681415,59480,60,360,2),
(13681415,59479,60,360,2),
(13681415,59478,60,360,2);
-- INSERT INTO `creature_formations` VALUES
-- (5274944,5274944,1000,360,1),
-- (5274944,99954,1000,360,1),
-- (5274944,99953,1000,360,1);
INSERT INTO `creature_formations` VALUES 
(113165,113165,60,360,2),
(113165,113221,60,360,2);
INSERT INTO `creature_formations` VALUES 
(11033,11033,60,360,2),
(11033,11074,60,360,2);
INSERT INTO `creature_formations` VALUES 
(85752,85752,60,360,2),
(85752,85753,60,360,2);
INSERT INTO `creature_formations` VALUES 
(15484,15484,60,360,2),
(15484,15487,60,360,2);
INSERT INTO `creature_formations` VALUES 
(85749,85749,60,360,2),
(85749,85748,60,360,2);
INSERT INTO `creature_formations` VALUES 
(62946,62946,60,360,2),
(62946,62947,60,360,2),
(62946,62948,60,360,2),
(62946,62949,60,360,2),
(62946,62955,60,360,2);
INSERT INTO `creature_formations` VALUES 
(136542,136542,60,360,2),
(136542,134711,3,1,2),
(136542,136592,3,3,2);
INSERT INTO `creature_formations` VALUES 
(19868,19868,60,360,2),
(19868,19742,3,1,2),
(19868,19889,3,3,2);
INSERT INTO `creature_formations` VALUES 
(107109,107109,60,360,2),
(107109,107255,3,1,2),
(107109,106659,3,3,2);
INSERT INTO `creature_formations` VALUES 
(62942,62942,60,360,2),
(62942,62943,60,360,2),
(62942,62944,60,360,2),
(62942,62945,60,360,2),
(62942,62954,60,360,2);
INSERT INTO `creature_formations` VALUES 
(8439,8439,60,360,2),
(8439,8966,60,360,2),
(8439,7746,60,360,2),
(8439,138404,60,360,2),
(8439,138169,60,360,2),
(8439,11612,60,360,2);
INSERT INTO `creature_formations` VALUES 
(62934,62934,60,360,2),
(62934,62935,60,360,2),
(62934,62936,60,360,2),
(62934,62937,60,360,2),
(62934,62952,60,360,2);
INSERT INTO `creature_formations` VALUES 
(62938,62938,60,360,2),
(62938,62939,60,360,2),
(62938,62940,60,360,2),
(62938,62941,60,360,2),
(62938,62953,60,360,2);
INSERT INTO `creature_formations` VALUES 
(121466,121466,60,360,2),
(121466,121269,60,360,2),
(121466,121724,60,360,2),
(121466,122141,60,360,2),
(121466,122190,60,360,2),
(121466,123402,60,360,2);
INSERT INTO `creature_formations` VALUES 
(15480,15480,60,360,2),
(15480,15482,60,360,2);
INSERT INTO `creature_formations` VALUES 
(16777014,16777014,150,360,2),
(16777014,62871,150,360,2),
(16777014,62872,150,360,2);
INSERT INTO `creature_formations` VALUES 
(117515,117515,60,360,2), -- Leader hinten
(117515,107964,60,360,2), -- Scout
(117515,62927,60,360,2),
(117515,62932,60,360,2),
(117515,62926,60,360,2),
(117515,117489,60,360,2),
(117515,117436,60,360,2),
(117515,117466,60,360,2);
INSERT INTO `creature_formations` VALUES 
(15373,15373,60,360,2),
(15373,15466,60,360,2);
INSERT INTO `creature_formations` VALUES 
(63392,63392,60,360,2),
(63392,63390,60,360,2),
(63392,63391,60,360,2);
INSERT INTO `creature_formations` VALUES 
(30418,30418,60,360,2),
(30418,31564,60,360,2),
(30418,32301,60,360,2),
(30418,99996,60,360,2),
(30418,32163,60,360,2),
(30418,99997,60,360,2),
(30418,57696,60,360,2);
INSERT INTO `creature_formations` VALUES 
(18601,18601,60,360,2),
(18601,18536,60,360,2),
(18601,18788,60,360,2),
(18601,19314,60,360,2),
(18601,18485,60,360,2),
(18601,18838,60,360,2),
(18601,99955,60,360,2);
INSERT INTO `creature_formations` VALUES 
(11262,11262,60,360,2),
(11262,57695,60,360,2),
(11262,13540,60,360,2),
(11262,57690,60,360,2),
(11262,57700,60,360,2),
(11262,99956,60,360,2);
INSERT INTO `creature_formations` VALUES 
(57694,57694,60,360,2),
(57694,57688,60,360,2),
(57694,15331,60,360,2),
(57694,57698,60,360,2),
(57694,15610,60,360,2),
(57694,99957,60,360,2);
INSERT INTO `creature_formations` VALUES 
(57222,57222,60,360,2),
(57222,57223,60,360,2),
(57222,99958,60,360,2);
-- links
INSERT INTO `creature_formations` VALUES 
(20420,20420,60,360,2),
(20420,20624,60,360,2),
(20420,21428,60,360,2),
(20420,57584,60,360,2);
-- rechts
INSERT INTO `creature_formations` VALUES 
(24360,24360,60,360,2),
(24360,24089,60,360,2),
(24360,22961,60,360,2),
(24360,57581,60,360,2);
INSERT INTO `creature_formations` VALUES 
(57220,57220,60,360,2),
(57220,57221,60,360,2);
INSERT INTO `creature_formations` VALUES 
(163620,163620,60,360,2),
(163620,163676,60,360,2),
(163620,163892,60,360,2),
(163620,163872,60,360,2),
(163620,163832,60,360,2);
--
-- ======================================================
-- Respawn
-- ======================================================
--
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (15118,15120,15112,15110,99949,99948,15094,15092,117515,117489,117436,117466,107964,62926,62927,62932,99979,99965,99964,99963,99962,99961,99960,99959,99958,99957,99956,99955,99996,99997,99998,99954,99953,99951,99950,99949,99948,99947,99946,99945,99944,99943,99942,99941,99940,99939);
INSERT INTO `creature_linked_respawn` VALUES
(99996,13681415),
(99997,13681415),
(99998,13681415),
(99979,62871),
(99965,62871),
(99964,62871),
(99963,62871),
(99962,62871),
(99961,62871),
(99960,62871),
(99959,62871),
(99958,13681415),
(99957,13681415),
(99956,13681415),
(99955,13681415),
(99954,5274944),
(99953,5274944),
(99951,5274944),
(99950,5274944),
--
(15118,5274944),
(15120,5274944),
(15112,5274944),
(15110,5274944),
(99949,5274944),
(99948,5274944),
(15094,5274944),
(15092,5274944),
(99947,5274944),
(99946,5274944),
(99945,5274944),
(99944,5274944),
(99943,5274944),
(99942,5274944),
(99941,5274944),
(99940,5274944),
(99939,5274944),
--
(62926,62871),
(62927,62871),
(62932,62871),
--
(117489,62871),
(117436,62872),
(117466,62872),
(117515,62871),
(107964,62871);
--
-- respawn gauntlet
UPDATE `creature` SET `spawntimesecs`='0' WHERE `guid` IN (117515,117489,117436,117466);
UPDATE `creature` SET `spawntimesecs`='90' WHERE `guid` IN (62926,62927,62932,107964);
UPDATE `creature` SET `spawntimesecs`='43200' WHERE `guid` IN (16777014);
--
-- ======================================================
-- Gameobjects
-- ======================================================
--
--
-- ======================================================
-- Miscellaneous
-- ======================================================
--
--
--
--
--
--
-- sleeping orcs, abandoned maybe another time
-- DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('34034','34199','99998');
--
-- UPDATE `creature_ai_scripts` SET `event_flags`='7',`action1_param3`='1' WHERE `id` IN ('1233905','945009');
-- aggro reduce fix for BK & SP
-- UPDATE `creature_ai_scripts` SET `action2_param1`='-25' WHERE `id` IN (1740004,1889401); 
-- UPDATE `creature_ai_scripts` SET `action1_param1`='-99' WHERE `id` IN (1794203);
--
DELETE FROM `creature` WHERE `guid` IN ('97065');
UPDATE `creature` SET `position_x`='798.7082', `position_y`='1885.4190', `position_z`='151.9342', `orientation`='4.5223',`spawndist`='XXX',`movementtype`='XXX' WHERE `guid` IN ('13913368');
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (69268, 19400, 530, 1, 0, 0, 630.359985, 1815.050049, 114.672997, 0.678789, 25, 0, 0, 855600, 0, 0, 2);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (69269, 19400, 530, 1, 0, 0, 750.862976, 1715.030029, 98.503601, 1.435140, 25, 0, 0, 855600, 0, 0, 2);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (69270, 19400, 530, 1, 0, 0, 1151.025269, 1800.391602, 116.70629, 2.556693, 25, 0, 0, 855600, 0, 0, 2); 
-- Fel Cannon 19 Updates
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69247';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69248';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `orientation`='3.882448', `MovementType`='0' WHERE `guid`='69249';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `orientation`='4.904270', `MovementType`='0' WHERE `guid`='69266';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `orientation`='3.971199', `MovementType`='0' WHERE `guid`='69254';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69251';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69250';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69255';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69257';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `position_x`='931.603027', `position_y`='1724.815308', `position_z`='102.419891', `orientation`='4.597957', `MovementType`='0' WHERE `guid`='69260';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `position_x`='970.444275', `position_y`='1703.526978', `position_z`='90.229973', `orientation`='4.643500', `MovementType`='0' WHERE `guid`='69263';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `position_x`='1022.650024', `position_y`='1727.25000', `position_z`='96.733101', `orientation`='5.517640', `MovementType`='0' WHERE `guid`='69265';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `position_x`='835.013977', `position_y`='1722.472534', `position_z`='108.600487', `orientation`='5.563979', `MovementType`='0' WHERE `guid`='69256';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `position_x`='716.960022', `position_y`='1710.010132', `position_z`='94.432152', `orientation`='1.856893', `MovementType`='0' WHERE `guid`='69252';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69262';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69261';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69264';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69267';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='35', `MovementType`='0' WHERE `guid`='69259';
-- Fel Reaver Sentry
SET @GUID := 69269;
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '757.662720', '1722.598267', '103.873299', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '775.191589', '1740.147339', '112.743805', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '795.147156', '1758.360840', '121.187309', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '808.609253', '1776.325684', '124.804062', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '825.541016', '1791.279907', '124.981033', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '841.744812', '1805.189087', '129.613510', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '869.104553', '1828.674194', '133.310684', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '881.653992', '1839.811157', '135.252396', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '900.871277', '1841.842651', '134.966305', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '916.194824', '1843.0322227', '134.548218', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '942.318787', '1811.949219', '126.208206', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '951.464783', '1791.828735', '115.666603', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '955.488831', '1780.793213', '115.329666', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '963.569214', '1758.424072', '112.959862', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '962.135315', '1719.690918', '97.324966', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '944.108582', '1705.799683', '90.298103', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '925.78326', '1700.064575', '90.404167', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '945.602844', '1704.890381', '89.473137', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '959.091370', '1719.135254', '96.515182', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '960.089966', '1739.036499', '107.794884', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '959.281250', '1754.856567', '112.255028', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '950.330444', '1788.645874', '115.171867', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '952.075989', '1790.119507', '114.744400', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '947.140808', '1803.702881', '122.737167', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '934.264771', '1834.602539', '132.163010', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '881.897888', '1840.255249', '135.362503', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '867.977844', '1826.710205', '132.960022', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '829.760925', '1799.989136', '129.153336', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '812.348816', '1784.740723', '124.837967', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '790.507446', '1768.578735', '123.978386', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '763.693970', '1749.249634', '113.950386', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '751.601929', '1741.746094', '105.711403', '0', '0', '0', '100', '0');
-- Fel Reaver Sentry
SET @GUID := 69270;
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '1145.702881', '1803.733032', '117.791985', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1120.499268', '1832.604736', '123.454361', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1091.770386', '1848.980225', '125.403374', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1076.228882', '1857.034424', '129.261063', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1064.190063', '1862.632568', '133.714249', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1039.966675', '1874.485474', '142.144058', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1019.229431', '1875.402588', '143.493057', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '992.795618', '1877.319824', '141.012253', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '968.763245', '1877.694336', '139.833328', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '942.893677', '1878.266724', '142.947556', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '915.639526', '1871.748413', '145.219116', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '875.708801', '1858.322876', '140.830948', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '819.535645', '1859.040894', '140.643250', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '761.232666', '1842.436279', '140.276825', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '732.978760', '1831.868896', '137.837646', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '697.521179', '1814.865234', '129.287994', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '671.809631', '1806.069702', '117.762360', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '653.643982', '1800.517700', '118.289612', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '620.651550', '1771.003296', '104.749763', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '662.092285', '1747.162964', '101.084175', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '694.076782', '1735.206299', '100.473900', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '707.451538', '1727.123901', '88.349060', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '734.177551', '1717.693604', '92.609810', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '755.644104', '1721.549805', '102.010178', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '776.175415', '1727.272095', '109.535957', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '810.452515', '1732.047607', '114.056900', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '884.990601', '1731.283813', '105.879982', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '917.606262', '1734.587769', '106.908936', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '944.834229', '1734.260742', '104.177071', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '969.668091', '1734.251831', '104.998024', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1002.246399', '1734.395752', '102.394302', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1051.151611', '1727.858521', '94.974808', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1105.755249', '1732.716919', '93.367188', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1111.143311', '1737.525879', '95.663216', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1121.927612', '1754.985107', '104.525742', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1135.613159', '1776.548340', '112.902122', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1145.485840', '1802.716919', '117.567581', '0', '0', '0', '100', '0');
-- Fel Reaver Sentry
SET @GUID := 69268;
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '647.900269', '1828.093262', '120.541428', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '667.015015', '1840.195190', '128.352783', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '686.978333', '1851.952393', '137.748627', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '712.705200', '1861.521729', '148.219223', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '753.326172', '1856.148071', '141.480927', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '779.294128', '1853.769287', '141.786407', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '818.853516', '1850.919556', '137.699265', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '848.239685', '1849.602051', '137.707932', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '881.760498', '1847.416138', '137.290558', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '919.420715', '1848.886963', '136.317886', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '952.750366', '1850.595825', '131.049545', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '978.987793', '1849.600830', '132.103638', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1018.252808', '1847.190186', '131.437805', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1045.254639', '1835.540894', '126.332581', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1081.931641', '1816.728027', '122.940598', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1088.452026', '1792.304321', '117.180351', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1084.086792', '1787.716309', '114.4414444', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1084.834839', '1779.535034', '114.682495', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1085.244629', '1768.692749', '112.545105', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1071.045166', '1743.363647', '100.353432', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1054.592529', '1737.411865', '98.674515', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1043.961914', '1734.259888', '93.452995', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1036.338013', '1731.906616', '94.722618', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1022.137817', '1726.929199', '96.643211', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1011.367920', '1725.447876', '96.741776', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '991.840149', '1723.012695', '98.115845', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '982.496460', '1723.154419', '96.524223', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '974.121582', '1723.705200', '98.024025', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '966.435364', '1724.148682', '101.109291', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '956.400574', '1724.361328', '100.490715', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '947.076111', '1724.637329', '101.260941', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '932.028625', '1724.635132', '102.396049', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '923.442627', '1722.719360', '97.980736', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '915.719971', '1718.415283', '99.828918', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '903.734863', '1712.649170', '99.595543', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '887.303345', '1704.823242', '95.883301', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '867.968506', '1698.336548', '89.143974', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '863.160095', '1696.229126', '87.194206', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '856.307556', '1693.808960', '90.567261', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '845.139526', '1693.266235', '92.528954', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '836.510498', '1692.757812', '89.442146', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '830.593201', '1692.137085', '93.226868', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '817.737671', '1690.588989', '96.953346', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '807.009705', '1691.053223', '99.517204', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '795.649475', '1693.833618', '100.417458', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '780.786987', '1698.653198', '98.762886', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '767.747681', '1704.060181', '98.658112', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '752.050476', '1709.360840', '100.240944', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '739.894165', '1713.071289', '97.388710', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '732.856689', '1716.927124', '91.983818', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '712.907166', '1722.084595', '92.568832', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '712.165955', '1724.894897', '89.837097', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '702.835876', '1726.334961', '86.802910', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '699.194275', '1727.445679', '92.128044', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '699.917236', '1728.142578', '95.256165', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '679.687988', '1739.991943', '100.487900', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '667.037170', '1748.756836', '102.196548', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '654.350403', '1757.883667', '104.235893', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '644.662354', '1765.574219', '105.247681', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '637.549622', '1771.796021', '102.370758', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '633.939392', '1774.929932', '105.762772', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '628.021973', '1781.500366', '110.030739', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '621.920898', '1792.221924', '111.745468', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '625.369873', '1805.567017', '116.092949', '0', '0', '0', '100', '0');
--
-- Mo'arg Overseer
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='30', `position_x`='700.574402', `position_y`='1863.209961', `position_z`='146.867691', `orientation`='4.6', `MovementType`='2' WHERE `guid`='69146';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='30', `position_x`='912.013062', `position_y`='1684.601562', `position_z`='86.6479449', `orientation`='1.8', `MovementType`='2' WHERE `guid`='69147';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='30', `position_x`='647.887329', `position_y`='1755.359619', `position_z`='102.724243', `orientation`='1.8', `MovementType`='2' WHERE `guid`='69148';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='30', `position_x`='775.672791', `position_y`='1680.854004', `position_z`='96.071106', `orientation`='1.3', `MovementType`='2' WHERE `guid`='69149';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='30', `position_x`='775.672791', `position_y`='1680.854004', `position_z`='96.071106', `orientation`='1.3', `MovementType`='2' WHERE `guid`='69149';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='30', `position_x`='847.257013', `position_y`='1858.979980', `position_z`='141.001999', `orientation`='4.7', `MovementType`='2' WHERE `guid`='69150';
UPDATE `creature` SET  `spawndist`='0', `spawntimesecs`='30', `position_x`='1119.588745', `position_y`='1716.730225', `position_z`='84.372009', `orientation`='2.7', `MovementType`='2' WHERE `guid`='69151';
UPDATE `creature` SET `spawndist`='0', `spawntimesecs`='30', `position_x`='985.438416', `position_y`='1847.512573', `position_z`='131.616867', `orientation`='4.6', `MovementType`='2' WHERE `guid`='69152';
-- Mo'arg Overseer
SET @GUID := 69146;
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '699.447693', '1851.012207', '139.298737', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '699.596069', '1834.927368', '132.742493', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '700.293579', '1827.491089', '128.716919', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '701.856445', '1820.550171', '130.101944', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '711.500488', '1805.117554', '128.486481', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '720.121399', '1791.661255', '124.981514', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '713.357971', '1782.760010', '120.797997', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '703.561890', '1762.689453', '111.730690', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '706.341858', '1753.165283', '108.395851', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '714.729126', '1749.719116', '102.424103', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '718.569580', '1746.259888', '103.555771', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '720.745728', '1743.383179', '105.289757', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '716.636047', '1734.510010', '101.078445', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '709.200623', '1728.714233', '89.643059', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '711.632690', '1721.802368', '91.388512', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '713.617004', '1717.716553', '94.599648', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '718.523376', '1705.399536', '92.815170', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '713.617004', '1717.716553', '94.599648', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '711.632690', '1721.802368', '91.388512', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '709.200623', '1728.714233', '89.643059', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '716.636047', '1734.510010', '101.078445', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '720.745728', '1743.383179', '105.289757', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '718.569580', '1746.259888', '103.555771', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '714.729126', '1749.719116', '102.424103', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '706.341858', '1753.165283', '108.395851', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '703.561890', '1762.689453', '111.730690', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '713.357971', '1782.760010', '120.797997', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '720.121399', '1791.661255', '124.981514', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '711.500488', '1805.117554', '128.486481', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '701.856445', '1820.550171', '130.101944', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '700.293579', '1827.491089', '128.716919', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '699.596069', '1834.927368', '132.742493', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '699.447693', '1851.012207', '139.298737', '0', '0', '0', '100', '0');
-- Mo'arg Overseer
SET @GUID := 69147;
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '906.696899', '1701.634644', '94.417450', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '914.734009', '1723.858643', '103.68199', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '923.744263', '1740.360352', '105.987480', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '919.721252', '1756.784302', '113.964417', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '912.116150', '1787.142578', '122.332787', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '916.540039', '1809.919067', '124.778526', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '917.115845', '1826.173462', '130.779053', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '922.766113', '1850.249512', '136.603439', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '915.619141', '1857.460938', '140.105988', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '922.766113', '1850.249512', '136.603439', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '917.115845', '1826.173462', '130.779053', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '916.540039', '1809.919067', '124.778526', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '912.116150', '1787.142578', '122.332787', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '919.721252', '1756.784302', '113.964417', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '923.744263', '1740.360352', '105.987480', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '914.734009', '1723.858643', '103.68199', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '906.696899', '1701.634644', '94.417450', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '847.257013', '1858.979980', '141.001999', '0', '0', '0', '100', '0');
-- Mo'arg Overseer
SET @GUID := '69148';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '663.626404', '1767.271484', '108.425529', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '688.952271', '1749.683350', '105.147018', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '708.846130', '1755.718140', '109.675903', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '717.952637', '1755.217163', '105.999550', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '733.536926', '1752.255493', '110.545158', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '745.250366', '1751.058838', '110.216652', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '754.388062', '1752.052246', '109.739639', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '761.496155', '1753.9000024', '115.295876', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '785.477661', '1763.860596', '121.862541', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '816.670959', '1737.048340', '114.875328', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '832.429321', '1747.258667', '113.252502', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '845.364502', '1755.844482', '118.307350', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '866.321533', '1757.407837', '117.633759', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '914.577271', '1755.919189', '113.774620', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '959.877808', '1736.482056', '106.987320', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '974.641541', '1754.916870', '111.713875', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '986.710083', '1755.266724', '106.319138', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '992.729614', '1753.885376', '108.663559', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1010.583435', '1751.816650', '104.732956', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1040.523804', '1748.426514', '97.014572', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1052.749878', '1748.949097', '99.107422', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1072.766602', '1744.159912', '100.537209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1105.838013', '1741.597656', '98.447639', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1122.749512', '1748.162476', '101.595871', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1138.507690', '1751.462769', '95.233978', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1122.749512', '1748.162476', '101.595871', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1105.838013', '1741.597656', '98.447639', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1072.766602', '1744.159912', '100.537209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1052.749878', '1748.949097', '99.107422', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1040.523804', '1748.426514', '97.014572', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1040.523804', '1748.426514', '97.014572', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '992.729614', '1753.885376', '108.663559', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '986.710083', '1755.266724', '106.319138', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '974.641541', '1754.916870', '111.713875', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '959.877808', '1736.482056', '106.987320', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '914.577271', '1755.919189', '113.774620', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '866.321533', '1757.407837', '117.633759', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '845.364502', '1755.844482', '118.307350', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '832.429321', '1747.258667', '113.252502', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '816.670959', '1737.048340', '114.875328', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '785.477661', '1763.860596', '121.862541', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '761.496155', '1753.9000024', '115.295876', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '754.388062', '1752.052246', '109.739639', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '745.250366', '1751.058838', '110.216652', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '733.536926', '1752.255493', '110.545158', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '717.952637', '1755.217163', '105.999550', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '708.846130', '1755.718140', '109.675903', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '688.952271', '1749.683350', '105.147018', '0', '0', '0', '100', '0');
-- Mo'arg Overseer
SET @GUID := '69149';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '783.789062', '1692.381714', '99.448456', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '784.510010', '1703.207275', '102.671310', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '783.977722', '1719.925171', '108.779831', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '766.377869', '1742.267212', '111.976273', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '776.407715', '1759.183105', '119.131607', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '793.434387', '1785.451538', '128.699585', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '786.241211', '1801.446289', '132.674088', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '794.754456', '1841.365845', '138.421371', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '794.754456', '1841.365845', '138.421371', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '786.241211', '1801.446289', '132.674088', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '793.434387', '1785.451538', '128.699585', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '776.407715', '1759.183105', '119.131607', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '766.377869', '1742.267212', '111.976273', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '783.977722', '1719.925171', '108.779831', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '784.510010', '1703.207275', '102.671310', '0', '0', '0', '100', '0');
-- Mo'arg Overseer
SET @GUID := '69150';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '850.932983', '1815.473267', '131.183044', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '858.758179', '1780.179321', '124.588852', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '849.030212', '1744.467041', '114.647156', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '845.963623', '1732.986572', '106.524895', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '850.220581', '1717.297363', '101.295227', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '852.464966', '1705.421509', '94.012650', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '852.184326', '1689.628784', '90.334763', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '848.187012', '1677.214600', '86.458450', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '845.254272', '1671.283081', '77.311638', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '840.754728', '1662.330200', '71.406410', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '845.254272', '1671.283081', '77.311638', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '848.187012', '1677.214600', '86.458450', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '852.184326', '1689.628784', '90.334763', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '852.464966', '1705.421509', '94.012650', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '850.220581', '1717.297363', '101.295227', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '845.963623', '1732.986572', '106.524895', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '849.030212', '1744.467041', '114.647156', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '858.758179', '1780.179321', '124.588852', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '851.109314', '1852.231567', '138.572388', '0', '0', '0', '100', '0');
-- Mo'arg Overseer
SET @GUID := '69151';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '1093.386108', '1724.781372', '90.728683', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1048.029663', '1725.610352', '93.876816', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1035.148193', '1724.635620', '91.812302', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '999.015442', '1713.564087', '91.345856', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '985.505371', '1709.543701', '82.027374', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '969.185974', '1709.052979', '90.147209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '953.161621', '1719.715820', '97.129723', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '931.432007', '1729.417480', '101.466690', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '900.818298', '1722.679932', '103.876762', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '867.406128', '1714.553467', '101.787544', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '853.799622', '1709.166748', '94.48749', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '823.053467', '1699.805542', '98.259392', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '802.691956', '1689.481079', '100.677605', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '791.075134', '1687.779297', '97.579872', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '752.406738', '1716.276978', '98.543800', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '752.406738', '1716.276978', '98.543800', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '791.075134', '1687.779297', '97.579872', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '802.691956', '1689.481079', '100.677605', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '823.053467', '1699.805542', '98.259392', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '853.799622', '1709.166748', '94.48749', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '867.406128', '1714.553467', '101.787544', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '900.818298', '1722.679932', '103.876762', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '931.432007', '1729.417480', '101.466690', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '953.161621', '1719.715820', '97.129723', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '969.185974', '1709.052979', '90.147209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '985.505371', '1709.543701', '82.027374', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '999.015442', '1713.564087', '91.345856', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1035.148193', '1724.635620', '91.812302', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1048.029663', '1725.610352', '93.876816', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1093.386108', '1724.781372', '90.728683', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '1119.588745', '1716.730225', '84.372009', '0', '0', '0', '100', '0');
-- Mo'arg Overseer
SET @GUID := '69152';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '980.268799', '1848.870117', '131.911499', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '988.033997', '1785.729980', '118.09996', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '984.196899', '1771.750732', '113.933479', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '978.986877', '1762.243896', '112.581924', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '967.583191', '1737.078979', '106.542763', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '975.760986', '1734.712158', '101.783585', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '986.535706', '1731.655151', '102.132362', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '981.712769', '1714.359985', '88.433220', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '977.118408', '1700.509033', '85.810806', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '971.770752', '1688.218506', '84.186691', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '977.118408', '1700.509033', '85.810806', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '981.712769', '1714.359985', '88.433220', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '986.535706', '1731.655151', '102.132362', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '975.760986', '1734.712158', '101.783585', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '967.583191', '1737.078979', '106.542763', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '978.986877', '1762.243896', '112.581924', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '984.196899', '1771.750732', '113.933479', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '988.033997', '1785.729980', '118.09996', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '980.268799', '1848.870117', '131.911499', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '985.438416', '1847.512573', '131.616867', '0', '0', '0', '100', '0');
--
SET @GUIDSTART := '101254'; -- 221 creatures
SET @GUID := @GUIDSTART;

-- Eclipsion Soldier [108]
SET @ENTRY := '22016';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '0', @ENTRY, '530', '1', '0', '0', '-4123.924', '1401.821', '86.12651', '0.66322510', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4091.161', '1401.570', '86.44725', '2.18166200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4094.887', '1399.191', '85.73920', '2.12930200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4123.232', '1398.521', '84.94530', '0.69813170', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4100.065', '1377.723', '80.58579', '2.11895700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4125.009', '1385.029', '82.06972', '0.68067840', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4121.998', '1381.514', '81.27090', '0.71558500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4100.049', '1373.944', '79.29758', '2.07694200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4176.760', '1317.902', '56.14388', '4.66002900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4206.372', '1313.213', '56.97198', '4.67748200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4286.958', '1399.464', '141.7273', '0.14922700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4173.190', '1316.726', '57.28808', '4.62512300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4285.288', '1403.703', '142.7468', '0.15707960', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4225.355', '1382.274', '131.8036', '0.59341190', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4203.806', '1313.086', '56.38221', '4.72984200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4282.858', '1372.467', '142.9853', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4229.290', '1314.141', '56.20462', '4.83456200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4228.463', '1386.521', '131.6950', '0.99483760', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4286.955', '1372.653', '144.4907', '1.36135700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4225.272', '1314.485', '56.76705', '4.64257600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4246.702', '1319.209', '55.12754', '4.72984200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4250.584', '1318.969', '54.35254', '4.69493600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4296.026', '1328.683', '65.42085', '4.90437500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4299.640', '1328.812', '66.22527', '4.74729500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4303.616', '1368.628', '142.4450', '1.58825000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4313.260', '1332.713', '75.18435', '4.86946900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4314.923', '1392.792', '145.1806', '4.72984200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4309.135', '1368.470', '143.1826', '1.51843600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4318.995', '1393.429', '144.8428', '4.57276200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4316.293', '1330.928', '75.44308', '4.79965500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4333.595', '1331.259', '81.49699', '4.74729500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4337.558', '1331.472', '82.28129', '4.74729500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4259.223', '1297.016', '53.49150', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4366.688', '1403.155', '143.6546', '4.88692200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4254.897', '1297.109', '54.15660', '1.62315600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4237.948', '1296.560', '56.77861', '1.51843600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4352.139', '1360.497', '149.0262', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4356.693', '1360.722', '147.4154', '1.64061000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4394.715', '1395.115', '141.7673', '5.04400200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4438.936', '1341.436', '133.1845', '1.58825000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4398.186', '1394.587', '141.2314', '4.66002900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4444.756', '1402.805', '153.3001', '4.67748200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4417.643', '1349.761', '137.6745', '1.85004900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4435.272', '1342.658', '134.1407', '1.74532900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4421.238', '1348.147', '137.2926', '1.90240900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4402.107', '1356.144', '139.4134', '1.69296900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4371.126', '1402.858', '143.6186', '4.76474900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4418.939', '1398.979', '144.4967', '4.64257600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4405.679', '1354.707', '138.5374', '2.23402100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4425.032', '1399.435', '144.9056', '4.72984200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4368.874', '1329.790', '87.01675', '4.76474900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4394.570', '1325.529', '90.04512', '4.67748200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4457.658', '1336.211', '128.4674', '2.09439500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4363.924', '1329.675', '86.33422', '4.79965500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4459.715', '1324.069', '117.5098', '4.83456200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4461.854', '1335.399', '127.5277', '2.16420800', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4374.500', '1298.990', '86.34121', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4472.857', '1384.759', '142.8940', '5.53269400', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4370.159', '1299.016', '87.18961', '1.55334300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4435.651', '1324.362', '108.6567', '4.76474900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4478.784', '1380.629', '140.9524', '5.58505300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4439.019', '1324.268', '110.3090', '4.81710900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4450.358', '1401.978', '152.9127', '4.72984200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4390.215', '1325.901', '87.89794', '4.72984200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4321.846', '1306.318', '77.87005', '1.43117000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4325.973', '1306.922', '79.31133', '1.55334300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4392.289', '1294.808', '85.76007', '1.91986200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4428.073', '1294.681', '79.88619', '5.60250700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4341.430', '1307.242', '81.52878', '1.60570300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4395.842', '1292.162', '85.00720', '2.23402100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4431.681', '1291.176', '78.45481', '5.51524000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4444.622', '1301.590', '112.1513', '1.53589000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4409.826', '1279.684', '78.84362', '2.23402100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4448.522', '1301.487', '114.2430', '1.62315600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4463.649', '1323.491', '118.1441', '4.90437500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4345.604', '1307.461', '81.77303', '1.46607700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4450.571', '1275.527', '70.22888', '5.61996000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4453.189', '1272.508', '68.93385', '5.55014700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4412.818', '1277.005', '79.30817', '2.33874100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4493.479', '1361.584', '132.8436', '5.21853400', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4472.635', '1297.545', '122.2836', '1.53589000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4498.341', '1358.715', '132.1810', '2.80998000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4477.008', '1297.547', '122.7371', '1.65806300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4475.839', '1249.627', '55.78446', '5.58505300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4478.314', '1246.605', '54.47562', '5.77704000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4434.315', '1251.847', '70.62190', '2.53072700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4432.405', '1255.069', '71.96661', '2.42600800', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4452.750', '1228.520', '57.82890', '2.37364800', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4455.954', '1224.727', '54.16023', '2.65290000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4212.834', '1296.573', '57.13382', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4216.644', '1297.057', '56.21738', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4234.124', '1296.488', '57.28716', '1.62315600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4194.589', '1296.483', '57.24684', '1.55334300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4177.251', '1289.748', '58.83070', '1.46607700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4191.070', '1296.055', '57.67142', '1.60570300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4173.101', '1288.451', '57.66615', '1.50098300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4149.733', '1310.271', '56.68331', '4.72984200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4127.499', '1315.508', '57.72110', '5.70722700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4100.112', '1350.390', '72.31179', '3.05432600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4108.455', '1288.618', '54.21447', '1.94269600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4124.980', '1317.968', '59.00411', '5.51524000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4111.450', '1286.984', '54.52287', '2.26892800', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4096.357', '1322.749', '65.64674', '2.93215300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4127.137', '1286.000', '55.26802', '1.81514200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4096.191', '1317.842', '63.59529', '3.05432600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4131.382', '1285.947', '55.53052', '1.97222200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4153.588', '1311.411', '56.24898', '4.62512300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4099.992', '1353.743', '73.81431', '3.22885900', '300', '0', '0', '0', '0', '0', '0');

-- Eclipsion Spellbinder [64]
SET @ENTRY := '22017';
DELETE FROM `creature` WHERE `id`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22017');
INSERT INTO `creature_ai_scripts` VALUES
('2201700','22017','0','0','100','7','1000','1000','2000','2000','21','1','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Start Combat Movement'),
('2201701','22017','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Prevent Combat Movement on Spawn'),
('2201702','22017','4','0','100','0','0','0','0','0','11','34447','1','0','23','1','0','0','21','0','0','0','Eclipsion Spellbinder - Cast Arcane Missiles and Set Phase 1 and Stop Movement on Aggro'),
('2201703','22017','9','13','100','1','0','30','2000','2500','11','34447','1','0','21','0','0','0','0','0','0','0','Eclipsion Spellbinder - Cast Arcane Missiles and Stop Movement (Phase 1)'),
('2201704','22017','3','13','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Eclipsion Spellbinder - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('2201705','22017','9','13','100','0','25','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Start Combat Movement at 25 Yards (Phase 1)'),
('2201706','22017','9','13','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Prevent Combat Movement at 15 Yards (Phase 1)'),
('2201707','22017','9','13','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Start Combat Movement Below 5 Yards'),
('2201708','22017','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Set Phase 1 when Mana is above 30% (Phase 2)'),
('2201709','22017','9','0','100','0','0','30','12000','18000','11','18972','4','32','21','0','0','0','0','0','0','0','Eclipsion Spellbinder - Cast Slow and Stop Movement'),
('2201710','22017','2','0','100','0','40','0','0','0','11','38171','0','1','21','0','0','0','0','0','0','0','Eclipsion Spellbinder - Summon Arcane Bursts and Stop Movement at 40% HP'),
('2201711','22017','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Set Phase 3 at 15% HP'),
('2201712','22017','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Eclipsion Spellbinder - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('2201713','22017','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Set Phase to 0 on Evade'),
('2201714','22017','9','0','100','7','5','8','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Eclipsion Spellbinder - Stop Combat Movement Above 5 Yards');

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4244.603', '1375.733', '140.6022', '2.84488700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4175.071', '1317.023', '56.29230', '4.57276200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4204.949', '1314.804', '57.78447', '4.67748200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4286.808', '1401.710', '142.5168', '0.00000000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4255.302', '1377.411', '142.1805', '0.03490658', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4227.069', '1384.309', '131.8253', '0.66322510', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4284.596', '1372.362', '143.8031', '1.85004900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4297.718', '1328.606', '65.66891', '4.69493600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4278.104', '1312.277', '56.58344', '2.74016700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4316.877', '1394.038', '145.6370', '4.64257600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4306.205', '1368.637', '142.5210', '1.44862300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4287.814', '1313.235', '62.81659', '6.21337200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4236.117', '1296.549', '57.04790', '1.65806300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4354.213', '1360.633', '147.6353', '1.65806300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4396.593', '1394.883', '141.4977', '5.14872100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4436.858', '1341.966', '133.7134', '2.18166200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4385.414', '1361.219', '141.6366', '0.19198620', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4369.081', '1402.925', '143.5219', '4.67748200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4419.232', '1348.801', '137.5110', '2.25147500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4378.136', '1362.198', '142.5400', '3.35103200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4447.987', '1404.780', '155.0365', '4.69493600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4422.063', '1399.372', '144.5840', '4.67748200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4392.064', '1326.513', '89.33613', '4.95673500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4424.601', '1307.101', '101.6579', '0.36651920', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4372.298', '1299.017', '86.82649', '1.71042300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4366.271', '1329.881', '86.92708', '4.69493600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4415.506', '1310.735', '97.27908', '3.35103200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4437.295', '1324.284', '109.6401', '4.76474900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4343.598', '1307.349', '81.73926', '1.48353000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4430.338', '1293.527', '79.38573', '5.51524000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4495.860', '1360.218', '132.9001', '5.72468000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4474.752', '1297.632', '122.5307', '1.85004900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4433.133', '1253.580', '71.40871', '2.67035400', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4214.664', '1297.190', '57.29764', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4175.284', '1288.930', '58.04388', '1.57079600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4100.066', '1351.959', '72.96577', '2.91470000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4110.106', '1287.867', '54.45539', '2.39110100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4157.983', '1285.352', '57.46820', '0.00000000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4151.662', '1310.755', '56.45577', '4.90437500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4126.124', '1316.797', '58.35994', '5.74213300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4146.760', '1283.892', '59.42959', '2.63544700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4093.147', '1400.594', '86.09357', '2.33874100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4100.009', '1375.739', '79.86129', '2.37284500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4459.636', '1335.907', '128.0879', '1.83259600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4476.515', '1383.730', '142.9695', '5.55014700', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4447.055', '1301.427', '113.4150', '1.51843600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4477.426', '1248.335', '55.17253', '5.68977300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4335.564', '1331.208', '81.76533', '4.53785600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4257.244', '1296.912', '53.74193', '1.72787600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4248.659', '1319.342', '54.67619', '4.39823000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4192.901', '1296.210', '57.52086', '1.99867900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4461.736', '1324.455', '117.9274', '4.57276200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4403.888', '1355.367', '138.6868', '1.91986200', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4315.114', '1332.354', '75.88205', '4.90437500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4323.755', '1306.162', '78.73392', '1.60570300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4451.962', '1274.145', '69.79694', '5.61996000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4411.285', '1278.528', '79.11395', '2.49582100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4096.000', '1320.296', '64.87482', '2.98451300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4123.972', '1400.038', '85.69238', '0.69813170', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4123.581', '1382.959', '81.56386', '0.66322510', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4227.290', '1313.989', '56.11438', '4.66002900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4393.921', '1293.493', '85.24201', '2.39110100', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4129.427', '1285.630', '55.43221', '1.88495600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4454.148', '1225.992', '55.58987', '2.26892800', '300', '0', '0', '0', '0', '0', '0');

-- Eclipsion Cavalier [21]
SET @ENTRY := '22018';
DELETE FROM `creature` WHERE `id`=@ENTRY;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22018');
INSERT INTO `creature_ai_scripts` VALUES
('2201801','22018','0','0','100','1','1000','1000','120000','240000','11','30931','0','1','0','0','0','0','0','0','0','0','Eclipsion Cavalier - Cast Battle Shout'),
('2201802','22018','9','0','100','1','0','5','10500','12500','11','35871','1','0','0','0','0','0','0','0','0','0','Eclipsion Cavalier - Cast Spellbreaker'),
('2201803','22018','6','0','100','0','0','0','0','0','11','38311','1','3','0','0','0','0','0','0','0','0','Eclipsion Cavalier - Summon Eclipsion Hawkstrider on Death');
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('21627');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21627');
INSERT INTO `creature_ai_scripts` VALUES
('2162701','21627','1','0','100','0','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Eclipsion Hawkstrider - Despawn OOC');

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4166.534', '1310.932', '56.39446', '4.67321700', '300', '0', '0', '0', '0', '0', '2'), -- x + 172
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4225.071', '1389.411', '130.7682', '3.24139300', '300', '0', '0', '0', '0', '0', '2'), -- x + 173
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4519.708', '1359.151', '132.7614', '6.07178400', '300', '0', '0', '0', '0', '0', '2'), -- x + 174
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4528.846', '1339.219', '130.8591', '6.09119900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4582.990', '1309.632', '135.4770', '0.08726646', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4560.177', '1343.253', '135.4770', '5.79449300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4531.120', '1294.859', '130.9649', '0.12217300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4534.008', '1297.440', '131.1336', '6.23082500', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4476.917', '1245.477', '54.33916', '0.78548460', '300', '0', '0', '0', '0', '0', '2'), -- x + 180
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4337.833', '1403.836', '143.9981', '4.45059000', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4463.945', '1321.892', '117.7956', '6.26658200', '300', '0', '0', '0', '0', '0', '2'), -- x + 182
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4325.512', '1308.526', '79.02608', '3.07928000', '300', '0', '0', '0', '0', '0', '2'), -- x + 183
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4287.435', '1325.978', '61.82189', '6.22064500', '300', '0', '0', '0', '0', '0', '2'), -- x + 184
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4376.835', '1397.602', '142.4064', '0.19662930', '300', '0', '0', '0', '0', '0', '2'), -- x + 185
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4349.438', '1405.274', '144.0969', '4.76474900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4353.043', '1364.852', '147.6270', '3.26977800', '300', '0', '0', '0', '0', '0', '2'), -- x + 187
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4581.021', '1306.492', '135.4587', '0.13962630', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4525.637', '1342.223', '130.2755', '6.05629300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4555.485', '1344.411', '135.4771', '5.74213300', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4174.210', '1290.529', '57.97489', '2.70229900', '300', '0', '0', '0', '0', '0', '2'), -- x + 191
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4102.147', '1399.901', '84.77899', '4.65579300', '300', '0', '0', '0', '0', '0', '2'); -- x + 192

-- Son of Corok [10]
SET @ENTRY := '19824';
DELETE FROM `creature` WHERE `id`=@ENTRY;
UPDATE `creature_template` SET `mindmg`='860',`maxdmg`='1044',`AIName`='EventAI',`mechanic_immune_mask`='1' WHERE `entry` IN ('19824'); -- 292 660 -- 1,720 - 2,088
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19824');
INSERT INTO `creature_ai_scripts` VALUES
(1982401,19824,9,0,100,1,0,5,9500,18000,11,12612,0,0,0,0,0,0,0,0,0,0,'Son of Corok  - Stomp');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4243.271', '1408.345', '131.8937', '2.2514750', '300', '0', '0', '0', '0', '0', '2'), -- x + 193
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4250.472', '1381.948', '139.1874', '4.7298420', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4468.681', '1357.605', '129.9002', '0.3595284', '300', '0', '0', '0', '0', '0', '2'), -- x + 195
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4419.471', '1314.182', '99.80012', '4.9043750', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4464.041', '1243.445', '57.19920', '0.7378397', '300', '0', '0', '0', '0', '0', '2'), -- x + 197
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4382.188', '1366.950', '141.6207', '4.7647490', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4389.062', '1315.935', '86.02590', '0.1814530', '300', '0', '0', '0', '0', '0', '2'), -- x + 199
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4153.195', '1279.679', '57.75654', '1.2740900', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4115.589', '1312.478', '55.37975', '3.7322260', '300', '0', '0', '0', '0', '0', '2'), -- x + 201
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4281.281', '1317.739', '58.53769', '4.4854960', '300', '0', '0', '0', '0', '0', '0');

-- Chancellor Bloodleaf [1]
SET @ENTRY := '22012';
DELETE FROM `creature` WHERE `id`=@ENTRY;
UPDATE `creature_template` SET `AIName`='EventAI',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('22012');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22012');
INSERT INTO `creature_ai_scripts` VALUES
('2201200','22012','0','0','100','7','1000','1000','2000','2000','21','1','0','0','0','0','0','0','0','0','0','0','Chancellor Bloodleaf - Start Combat Movement'),
(2201201,22012,9,0,100,1,0,30,2000,2000,11,15791,1,0,21,0,0,0,0,0,0,0,'Chancellor Bloodleaf - Cast Arcane Missiles'),
(2201202,22012,9,0,100,1,0,5,5000,10000,11,34517,0,0,0,0,0,0,0,0,0,0,'Chancellor Bloodleaf - Cast Arcane Explosion'),
('2201203','22012','9','0','100','7','5','8','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Chancellor Bloodleaf - Stop Combat Movement Above 5 Yards (Phase 0)');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4496.981', '1307.314', '124.5788', '2.286381', '300', '0', '0', '0', '0', '0', '0');

-- Corok the Mighty [1]
SET @ENTRY := '22011';
DELETE FROM `creature` WHERE `id`=@ENTRY;
UPDATE `creature_template` SET `mindmg`='919',`maxdmg`='1092',`AIName`='EventAI',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('22011'); -- 330 675 -- 1,838 - 2,183
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22011');
INSERT INTO `creature_ai_scripts` VALUES
(2201101,22011,0,0,100,1,4000,8000,10000,12000,11,12612,0,0,0,0,0,0,0,0,0,0,'Corok the Mighty - Cast Stomp'),
(2201102,22011,9,0,100,1,0,5,8000,15000,11,15550,0,0,0,0,0,0,0,0,0,0,'Corok the Mighty - Cast Trample');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4501.332', '1312.931', '124.7291', '5.253441', '300', '0', '0', '0', '0', '0', '0');

-- Val'zareq the Conqueror [1]
SET @ENTRY := '21979';
DELETE FROM `creature` WHERE `id`=@ENTRY;
UPDATE `creature_template` SET `AIName`='EventAI',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('21979');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21979');
INSERT INTO `creature_ai_scripts` VALUES
('2197901','21979','0','0','100','7','1000','1000','2000','2000','21','1','0','0','0','0','0','0','0','0','0','0','Val\'zareq the Conqueror - Start Combat Movement and Set Ranged Weapon Model'),
(2197902,21979,4,0,100,0,0,0,0,0,21,0,0,0,40,2,0,0,0,0,0,0,'Val\'zareq the Conqueror - Stop Combat Movement and Set Ranged Weapon Model on Aggro'),
(2197903,21979,4,0,100,0,0,0,0,0,11,38094,1,0,22,1,0,0,21,0,0,0,'Val\'zareq the Conqueror - Cast Shoot and Set Phase 1 and Set Ranged Weapon Model on Aggro'),
(2197904,21979,0,13,100,1,2200,4700,2200,4700,11,38094,1,0,21,0,0,0,40,2,0,0,'Val\'zareq the Conqueror - Cast Shoot and Stop Combat Movement and Set Ranged Weapon Model (Phase 1)'),
(2197905,21979,9,13,100,1,20,100,0,0,21,0,0,0,0,0,0,0,0,0,0,0,'Val\'zareq the Conqueror - Start Movement at 20 Yards (Phase 1)'),
(2197906,21979,9,13,100,1,6,10,0,0,21,0,0,0,0,0,0,0,0,0,0,0,'Val\'zareq the Conqueror - Stop Movement at 10 Yards (Phase 1)'),
(2197907,21979,9,13,100,1,0,5,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Val\'zareq the Conqueror - Start Movement and Set Phase 2 at 5 Yards (Phase 1)'),
(2197908,21979,2,0,100,0,15,0,0,0,22,2,0,0,0,0,0,0,0,0,0,0,'Val\'zareq the Conqueror - Set Phase 3 at 15% HP'),
(2197909,21979,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Val\'zareq the Conqueror - Start Movement and Flee at 15% HP (Phase 3)'),
(2197910,21979,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Val\'zareq the Conqueror - On Evade set Phase to 0'),
('2197911','21979','9','0','100','7','5','8','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Val\'zareq the Conqueror - Stop Combat Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4278.670', '1393.161', '139.5192', '3.3691690', '300', '0', '0', '0', '0', '0', '2');  -- x + 205

-- Eclipsion Blood Knight [4]
SET @ENTRY := '19795';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4270.522', '1390.441', '138.6508', '4.4331360', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4274.397', '1403.015', '138.9335', '2.2514750', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4285.713', '1397.473', '141.1266', '2.1642080', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4287.410', '1389.150', '141.5160', '0.0000000', '300', '0', '0', '0', '0', '0', '0');

DELETE FROM `creature_formations` WHERE `leaderguid` IN (101459,101460,101461,101462,101463);
DELETE FROM `creature_formations` WHERE `memberguid` IN (101459,101460,101461,101462,101463);
INSERT INTO `creature_formations` VALUES
(101459,101460,5,5,2),
(101459,101461,5,1,2),
(101459,101462,5,2,2),
(101459,101463,5,4,2);

-- Illidari Watcher [4]
SET @ENTRY := '22093';
DELETE FROM `creature` WHERE `id`=@ENTRY;
UPDATE `creature_template` SET `AIName`='EventAI',`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('22093');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22093');
INSERT INTO `creature_ai_scripts` VALUES
(2209301,22093,9,0,100,1,0,5,5000,10000,11,32736,1,0,0,0,0,0,0,0,0,0,'Illidari Watcher - Casts Mortal Strike');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4588.834', '1337.239', '139.5454', '5.881760', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4576.276', '1356.441', '139.5454', '5.567600', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4585.051', '1341.516', '139.5454', '5.689773', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4598.597', '1323.696', '140.0525', '5.689773', '300', '0', '0', '0', '0', '0', '0');

-- Marcus Auralion [1]
SET @ENTRY := '22073';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4616.837', '1399.111', '144.4221', '4.45059', '300', '0', '0', '0', '0', '0', '0');

UPDATE `creature_template` SET `InhabitType`='4' WHERE `Entry`=@ENTRY;

-- Lord Illidan Stormrage [1]
SET @ENTRY := '22083';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4634.525', '1384.88', '143.7461', '5.759586', '300', '0', '0', '0', '0', '0', '0');

UPDATE `creature_template` SET `modelid_A`='19595',`modelid_H`='19595',`InhabitType`='4' WHERE `Entry`=@ENTRY; -- 21135

-- Eclipse Point - Bloodcrystal Spell Orgin [5]
SET @ENTRY := '20431';
DELETE FROM `creature` WHERE `guid` IN ('72390', '72391', '72392');
DELETE FROM `creature` WHERE `id` = @ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4151.469', '1285.948', '66.78405', '5.8992130', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4250.005', '1376.736', '149.7797', '5.9864790', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4280.861', '1311.672', '66.64850', '0.7330383', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4419.022', '1307.198', '108.1425', '1.6057030', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4381.685', '1361.485', '154.8493', '4.8171090', '300', '0', '0', '0', '0', '0', '0');

UPDATE `creature_template` SET `InhabitType`='4' WHERE `Entry`=@ENTRY;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '172';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4166.621', '1308.714', '56.10738', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4153.512', '1308.444', '55.89290', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4133.438', '1307.470', '55.02596', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4123.819', '1314.369', '56.64791', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4118.538', '1324.823', '61.44796', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4117.508', '1335.222', '65.65890', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4115.328', '1366.132', '76.17562', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4115.887', '1378.652', '79.68504', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4121.052', '1384.647', '81.33787', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4119.559', '1399.574', '84.55857', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4121.053', '1384.647', '81.43357', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4115.887', '1378.652', '79.68504', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4115.301', '1366.664', '76.17562', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4117.508', '1335.222', '65.65890', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4118.538', '1324.823', '61.44796', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4123.819', '1314.369', '56.64791', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4133.438', '1307.470', '55.02596', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4153.512', '1308.444', '55.89290', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4166.621', '1308.714', '56.10738', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4177.803', '1314.777', '56.14388', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '173';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4225.071', '1389.411', '130.7682', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4251.912', '1386.722', '136.7030', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4268.757', '1380.578', '143.2194', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4281.188', '1379.160', '141.7555', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4285.916', '1375.490', '144.1345', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4312.600', '1371.350', '144.5065', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4326.698', '1358.886', '149.4401', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4312.632', '1371.358', '144.6315', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4285.947', '1375.497', '144.1305', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4281.188', '1379.160', '141.7555', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4268.757', '1380.578', '143.2194', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4251.988', '1386.726', '136.9262', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4225.071', '1389.411', '130.7682', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4223.016', '1384.319', '131.5443', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '174';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4499.893', '1354.892', '130.4003', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4488.530', '1359.317', '130.4103', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4473.752', '1380.696', '139.9162', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4446.962', '1399.871', '150.8158', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4433.307', '1396.373', '144.5733', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4407.404', '1393.152', '139.8293', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4433.307', '1396.373', '144.5733', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4446.962', '1399.871', '150.8158', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4473.658', '1380.822', '140.0102', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4488.530', '1359.317', '130.4103', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4499.893', '1354.892', '130.4003', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4519.933', '1359.258', '132.8754', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '180';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4450.646', '1271.779', '68.11189', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4426.590', '1292.116', '77.73438', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4416.120', '1294.945', '80.64515', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4402.337', '1303.954', '85.68913', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4401.889', '1311.866', '89.64017', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4420.955', '1319.465', '99.99149', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4447.500', '1304.226', '114.4334', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4472.884', '1300.319', '121.5928', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4447.500', '1304.226', '114.4334', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4420.955', '1319.465', '99.99149', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4401.889', '1311.866', '89.64017', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4402.337', '1303.954', '85.68913', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4416.120', '1294.945', '80.64515', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4426.590', '1292.116', '77.73438', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4450.646', '1271.779', '68.11189', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4476.528', '1245.443', '54.42379', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '182';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4436.052', '1321.420', '107.2834', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4400.123', '1323.846', '91.48551', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4390.480', '1322.298', '86.71658', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4369.580', '1326.864', '86.12380', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4353.177', '1325.928', '83.30986', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4333.882', '1328.150', '79.53789', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4314.765', '1328.733', '73.46253', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4333.882', '1328.150', '79.53789', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4353.177', '1325.928', '83.30986', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4369.580', '1326.864', '86.12380', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4390.480', '1322.298', '86.71658', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4400.058', '1323.856', '91.35770', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4435.986', '1321.430', '107.1602', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4466.537', '1320.917', '118.4459', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '183';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4344.219', '1309.704', '81.71318', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4360.592', '1306.487', '87.38994', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4374.955', '1301.693', '85.99343', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4393.687', '1296.770', '85.93530', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4412.083', '1281.501', '80.14576', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4430.380', '1263.335', '72.94647', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4435.706', '1254.161', '69.75253', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4456.874', '1228.037', '55.36204', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4435.706', '1254.161', '69.75253', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4430.380', '1263.335', '72.94647', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4412.083', '1281.501', '80.14576', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4393.687', '1296.770', '85.93530', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4374.955', '1301.693', '85.99343', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4360.717', '1306.439', '87.15068', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4344.219', '1309.704', '81.71318', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4324.618', '1308.668', '78.72352', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '184';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4273.771', '1325.130', '57.02357', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4258.498', '1315.868', '52.57105', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4229.137', '1311.222', '55.94048', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4199.834', '1310.231', '56.14388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4190.341', '1314.549', '56.17244', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4199.834', '1310.231', '56.14388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4229.137', '1311.222', '55.94048', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4258.498', '1315.868', '52.57105', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4273.771', '1325.130', '57.02357', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4297.618', '1326.378', '64.41212', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '185';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4367.584', '1399.437', '142.0146', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4333.475', '1398.600', '144.3466', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4328.418', '1392.464', '144.0339', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4317.647', '1390.783', '144.2131', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4299.912', '1391.672', '144.0488', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4285.613', '1394.999', '140.9279', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4283.558', '1399.976', '140.8688', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4285.613', '1394.999', '140.9279', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4299.912', '1391.672', '144.0488', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4317.647', '1390.783', '144.2131', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4328.418', '1392.464', '144.0339', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4333.475', '1398.600', '144.3466', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4367.584', '1399.437', '142.0146', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4399.890', '1392.012', '139.8434', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '187';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4369.308', '1362.754', '143.8343', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4382.920', '1372.947', '140.3996', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4405.990', '1358.069', '138.8837', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4421.194', '1351.280', '136.7834', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4436.415', '1345.249', '133.8961', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4461.845', '1338.370', '128.0844', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4436.415', '1345.249', '133.8961', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4421.194', '1351.280', '136.7834', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4405.990', '1358.069', '138.8837', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4382.976', '1373.005', '140.3784', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4369.363', '1362.812', '143.7835', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4353.258', '1364.555', '147.6109', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '191';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4194.194', '1299.909', '56.35340', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4215.779', '1299.875', '56.38190', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4237.326', '1299.232', '56.34880', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4258.104', '1299.365', '53.06182', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4279.213', '1299.724', '48.06502', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4258.104', '1299.365', '53.06182', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4237.326', '1299.232', '56.34880', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4215.779', '1299.875', '56.38190', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4194.194', '1299.909', '56.35340', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4174.914', '1291.567', '58.18434', '0', '0', '0', '100', '0');

-- Eclipsion Cavalier
SET @GUID := @GUIDSTART + '192';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4103.468', '1376.825', '79.53953', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4102.838', '1353.306', '72.31637', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4099.004', '1320.331', '62.24683', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4109.967', '1292.495', '52.58207', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4118.303', '1295.372', '53.02384', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4130.411', '1288.522', '55.04911', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4118.303', '1295.372', '53.02384', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4109.967', '1292.495', '52.58207', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4099.004', '1320.331', '62.24683', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4102.838', '1353.306', '72.31637', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4103.468', '1376.825', '79.53953', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4097.666', '1401.537', '85.57001', '0', '0', '0', '100', '0');

-- Son of Corok
SET @GUID := @GUIDSTART + '193';
SET @POINT := '0'; 
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4257.452', '1400.368', '135.1779', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4281.203', '1392.313', '139.9943', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4303.821', '1385.086', '143.7775', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4329.110', '1386.571', '143.7565', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4303.821', '1385.086', '143.7775', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4281.203', '1392.313', '139.9943', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4257.452', '1400.368', '135.1779', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4241.350', '1408.419', '131.0781', '0', '0', '0', '100', '0');

-- Son of Corok
SET @GUID := @GUIDSTART + '195';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4423.920', '1374.436', '132.7069', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4406.461', '1375.059', '136.9795', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4380.588', '1383.079', '140.5566', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4354.617', '1389.822', '141.8532', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4380.588', '1383.079', '140.5566', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4406.461', '1375.059', '136.9795', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4423.920', '1374.436', '132.7069', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4462.013', '1364.896', '131.4610', '0', '0', '0', '100', '0');

-- Son of Corok
SET @GUID := @GUIDSTART + '197';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4443.392', '1262.241', '66.49532', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4433.011', '1273.885', '71.53358', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4420.625', '1286.901', '77.03065', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4400.590', '1298.177', '84.52772', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4420.625', '1286.901', '77.03065', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4433.011', '1273.885', '71.53358', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4443.392', '1262.241', '66.49532', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4461.213', '1245.472', '58.49483', '0', '0', '0', '100', '0');

-- Son of Corok
SET @GUID := @GUIDSTART + '199';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4368.556', '1319.710', '84.21169', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4351.290', '1322.436', '82.09050', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4329.943', '1321.933', '77.08961', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4293.944', '1321.216', '63.21620', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4329.943', '1321.919', '77.08363', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4351.290', '1322.436', '82.09050', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4368.556', '1319.710', '84.21169', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4391.421', '1317.775', '86.86306', '0', '0', '0', '100', '0');

-- Son of Corok
SET @GUID := @GUIDSTART + '201';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4128.466', '1303.851', '53.66854', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4154.984', '1302.706', '55.81710', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4185.151', '1308.381', '56.14388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4210.623', '1308.702', '56.31548', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4231.903', '1307.641', '55.94048', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4258.673', '1308.574', '51.75086', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4279.650', '1299.844', '48.04818', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4258.673', '1308.574', '51.75086', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4231.903', '1307.641', '55.94048', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4210.623', '1308.702', '56.31548', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4185.151', '1308.381', '56.14388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4154.984', '1302.706', '55.81710', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4128.466', '1303.851', '53.66854', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4115.384', '1315.770', '56.70418', '0', '0', '0', '100', '0');

-- Val'zareq the Conqueror
SET @GUID := @GUIDSTART + '205';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20675,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-4317.562', '1384.141', '144.1774', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4334.214', '1387.854', '143.8441', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4371.864', '1385.479', '140.7746', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4416.488', '1367.854', '135.3174', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4458.061', '1350.716', '129.8858', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4478.686', '1338.435', '125.5021', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4481.392', '1326.418', '123.1486', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4468.062', '1311.398', '118.3858', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4449.954', '1316.015', '112.7066', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4421.273', '1316.703', '100.2643', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4399.550', '1319.384', '90.06692', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4372.965', '1318.115', '83.86184', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4344.135', '1321.457', '79.15068', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4322.803', '1323.905', '75.10511', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4300.467', '1323.293', '65.18958', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4277.512', '1321.676', '57.38050', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4260.594', '1309.564', '51.63904', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4241.421', '1307.120', '55.10474', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4227.530', '1308.487', '55.99370', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4216.284', '1304.308', '56.31548', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4187.634', '1310.781', '56.14388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4164.851', '1303.150', '56.06710', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4129.132', '1300.769', '54.07210', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4111.819', '1322.403', '59.94039', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4107.568', '1351.998', '71.05941', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4106.442', '1377.136', '79.44651', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4110.178', '1406.908', '85.32136', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4103.373', '1425.765', '87.61823', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4090.517', '1438.420', '87.28346', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4117.618', '1459.786', '100.5760', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4139.917', '1449.612', '108.3969', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4156.692', '1427.866', '112.7589', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4166.061', '1401.347', '114.8959', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4186.184', '1395.035', '120.8572', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4206.013', '1397.541', '123.8834', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4233.267', '1405.135', '129.0163', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4256.471', '1404.797', '134.8813', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4275.196', '1396.933', '138.8024', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4237.463', '1403.418', '131.2128', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4215.023', '1404.576', '127.0802', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4195.912', '1395.902', '122.8439', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4177.771', '1400.133', '117.4371', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4157.768', '1427.665', '112.6542', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4140.117', '1447.850', '109.1949', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4120.885', '1462.571', '101.3683', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4096.275', '1449.111', '87.64430', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4101.462', '1414.243', '85.50947', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4110.905', '1387.407', '81.91111', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4111.033', '1354.406', '71.92562', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4108.924', '1325.664', '61.69466', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4120.061', '1308.658', '54.31758', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4137.358', '1300.391', '54.69210', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4169.725', '1304.378', '56.14388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4191.462', '1307.997', '56.14388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4215.704', '1306.050', '56.31548', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4239.134', '1307.289', '55.31678', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4270.404', '1319.183', '54.88087', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4292.506', '1325.606', '63.38050', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4329.667', '1322.331', '77.07093', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4372.843', '1319.686', '84.28896', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4414.306', '1320.866', '96.63981', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4434.752', '1317.145', '105.4435', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4457.026', '1315.548', '115.1268', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4469.077', '1324.385', '120.6070', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4474.989', '1344.733', '127.3629', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4455.466', '1361.991', '130.2322', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4434.304', '1370.552', '132.3079', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4402.581', '1378.450', '137.6983', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4378.606', '1383.377', '140.4674', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4354.602', '1386.969', '141.7633', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4333.253', '1384.720', '143.9345', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4305.889', '1383.544', '143.9006', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4279.963', '1391.963', '139.6964', '0', '0', '0', '100', '0');

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM `creature_addon` WHERE `guid` IN (@GUIDSTART + '108', @GUIDSTART + '112', @GUIDSTART + '116', @GUIDSTART + '119', @GUIDSTART + '124', @GUIDSTART + '127', @GUIDSTART + '131', @GUIDSTART + '134', @GUIDSTART + '145', @GUIDSTART + '148');

INSERT INTO `creature_addon` (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES
(@GUIDSTART + '108', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '112', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '116', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '119', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '124', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '127', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '131', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '134', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '145', '0', '0', '1', '16', '0', '0', '35190'),
(@GUIDSTART + '148', '0', '0', '1', '16', '0', '0', '35190');

DELETE FROM `spell_script_target` WHERE `entry`='35190' and `type`='1' and `targetEntry`='22017';

UPDATE creature, creature_template SET creature.curhealth = creature_template.MinHealth, creature.curmana = creature_template.MinMana WHERE creature.id = creature_template.entry AND creature_template.RegenHealth & '1';

DELETE FROM `creature_addon` WHERE `guid` IN ('77144', '77145', '77150', '77151', '77152', '77153');
--
-- Felspine the Greater 21897
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('21897');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21897'); 
INSERT INTO `creature_template_addon` VALUES
(21897,0,0,0,0,4097,0,0,'36006 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21897');
INSERT INTO `creature_ai_scripts` VALUES
(2189701,21897,0,0,100,1,5500,5500,15000,15000,11,37941,0,1,0,0,0,0,0,0,0,0,'Felspine the Greater  - Cast Flaming Wound'),
(2189702,21897,0,0,100,1,8000,8000,10000,18000,11,38356,0,0,0,0,0,0,0,0,0,0,'Felspine the Greater  - Cast Fel Flames');
--
-- Void Conduit 20899
UPDATE `creature_template` SET `inhabittype`='7' WHERE `entry` IN ('20899');
--
-- unused trigger [-5|+0]
DELETE FROM `creature` WHERE `id` IN ('21071','21092','21094','21095','21096');
--
-- http://looking4group.de/quelthalas/database/?quest=9378
UPDATE `access_requirement` SET `quest_done`='9378' WHERE `id` IN ('28');
-- http://looking4group.de/quelthalas/database/?spell=28147
DELETE FROM `spell_target_position` WHERE `id`='28147';
INSERT INTO `spell_target_position` (`id`, `target_map`, `target_position_x`, `target_position_y`, `target_position_z`, `target_orientation`) VALUES
('28147', '0', '-11123.3', '-2014.44', '47.09271', '0.675977');
-- http://looking4group.de/quelthalas/database/?object=181146
UPDATE `gameobject_template` SET `faction`='0', `flags`='0' WHERE `entry`='181146';
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2477/shadowmoon-valley-the-fel-pits
--
-- bereich um 74k wird gelÃ¶scht
SET @GUIDSTART := '101691';  -- 110 creatures added / ~66 creatures removed
SET @GUID := @GUIDSTART;

-- unused trigger [-5|+0]
DELETE FROM `creature` WHERE `id` IN ('21071','21092','21094','21095','21096');

-- Enraged Fire Soul [-1|+0]
SET @ENTRY := '21097';
DELETE FROM `creature` WHERE `id`=@ENTRY;

-- Corrupted Fire Elemental [-2|+0]
SET @ENTRY := '21706';
DELETE FROM `creature` WHERE `id`=@ENTRY;

-- Enraged Fire Spirit [-26|+46]
SET @ENTRY := '21061';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '0', @ENTRY, '530', '1', '0', '0', '-3968.536', '1361.080', '41.27816', '0.70625500', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3963.216', '1303.419', '39.72447', '1.64708400', '300', '0', '0', '0', '0', '0', '2'), -- x + 1
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3884.351', '1303.794', '39.86781', '3.39144300', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3950.135', '1455.504', '39.72449', '0.34084400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3834.725', '1337.655', '40.10129', '0.57602490', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3883.372', '1264.323', '39.59035', '1.22603800', '300', '0', '0', '0', '0', '0', '2'), -- x + 5
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3866.720', '1401.258', '39.69121', '4.85331100', '300', '0', '0', '0', '0', '0', '2'), -- x + 6
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3819.414', '1477.472', '43.62658', '2.45591700', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3854.826', '1443.303', '40.57096', '1.32574600', '300', '0', '0', '0', '0', '0', '2'), -- x + 8
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3873.481', '1528.284', '40.61100', '3.78045200', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3806.792', '1549.519', '37.98209', '0.42071370', '300', '0', '0', '0', '0', '0', '2'), -- x + 10
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3946.140', '1516.706', '40.21125', '0.98613250', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3752.961', '1479.470', '46.97700', '1.71976500', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3778.269', '1549.228', '45.32440', '5.32436800', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3710.817', '1516.760', '48.40620', '1.64676900', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3718.244', '1584.411', '43.83197', '2.12660400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3733.802', '1617.507', '40.69199', '3.29347700', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3634.643', '1514.704', '85.56610', '6.18828900', '300', '0', '0', '0', '0', '0', '2'), -- x + 17
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3655.402', '1558.273', '49.42381', '3.34238400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3692.613', '1653.045', '39.56059', '5.04861900', '300', '0', '0', '0', '0', '0', '2'), -- x + 19
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3763.165', '1651.651', '39.75420', '5.16300400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3753.688', '1685.946', '40.80269', '6.00020000', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3677.914', '1739.522', '39.71070', '0.77572140', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3567.777', '1687.128', '39.19603', '0.58025940', '300', '0', '0', '0', '0', '0', '2'), -- x + 23
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3607.611', '1725.361', '39.64762', '1.57953800', '300', '0', '0', '0', '0', '0', '2'), -- x + 24
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3584.378', '1581.990', '47.31120', '1.26930000', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3548.881', '1617.359', '45.93129', '2.45798000', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3514.874', '1579.913', '46.95868', '2.13559500', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3512.374', '1657.086', '46.50841', '0.81237940', '300', '0', '0', '0', '0', '0', '2'), -- x + 28
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3422.720', '1584.403', '47.00019', '3.21533300', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3448.423', '1550.403', '46.91026', '2.47952500', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3386.554', '1724.774', '100.8920', '0.98422700', '300', '0', '0', '0', '0', '0', '2'), -- x + 31
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3361.977', '1668.255', '94.57737', '2.76240000', '300', '0', '0', '0', '0', '0', '2'), -- x + 32
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3425.414', '1771.370', '100.9127', '3.38890700', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3408.992', '1804.676', '97.31487', '4.39471400', '300', '0', '0', '0', '0', '0', '2'), -- x + 34
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3362.607', '1591.451', '47.85078', '1.63152900', '300', '0', '0', '0', '0', '0', '2'), -- x + 35
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3399.757', '1549.373', '48.05845', '0.02931504', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3381.920', '1514.206', '52.11436', '5.40148400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3346.893', '1547.978', '52.42512', '0.51249250', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3244.677', '1583.898', '49.64318', '3.05806700', '300', '0', '0', '0', '0', '0', '2'), -- x + 39
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3266.770', '1516.685', '50.80831', '4.70469900', '300', '0', '0', '0', '0', '0', '2'), -- x + 40
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3261.721', '1358.507', '50.14167', '1.72787600', '300', '0', '0', '0', '0', '0', '2'), -- x + 41
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3291.019', '1545.251', '51.10376', '2.58186800', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3282.524', '1451.430', '50.74366', '2.22636100', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3191.679', '1355.129', '5.919065', '6.24723900', '300', '0', '0', '0', '0', '0', '2'), -- x + 44
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3016.804', '1379.479', '11.47956', '3.46587800', '300', '0', '0', '0', '0', '0', '2'); -- x + 45

-- Spawn of Uvuros [-1|+3]
SET @ENTRY := '21108';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3268.571', '1355.402', '49.62804', '1.117570', '300', '0', '0', '0', '0', '0', '2'), -- x + 46
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3412.071', '1773.265', '102.8363', '5.732968', '300', '0', '0', '0', '0', '0', '2'), -- x + 47
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3876.617', '1232.423', '44.13676', '1.803640', '300', '0', '0', '0', '0', '0', '2'); -- x + 48

-- Enraged Earthen Soul [-2|+0]
SET @ENTRY := '21073';
DELETE FROM `creature` WHERE `id`=@ENTRY;

-- Enraged Earth Shard [-2|+0]
SET @ENTRY := '22115';
DELETE FROM `creature` WHERE `id`=@ENTRY;

-- Enraged Earth Spirit [-26|+52]
SET @ENTRY := '21050';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3866.737', '1336.028', '42.74855', '2.14247500', '300', '0', '0', '0', '0', '0', '2'), -- x + 49
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3908.297', '1395.076', '43.21666', '0.11453480', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3842.790', '1281.757', '51.66577', '4.92514000', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3960.711', '1276.084', '56.77777', '0.52832060', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3933.352', '1261.858', '54.75646', '4.07941600', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3814.530', '1248.937', '78.71390', '6.01852500', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3878.596', '1180.443', '72.48586', '2.53072700', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3741.470', '1281.555', '113.8274', '3.28419700', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3996.543', '1337.669', '81.56582', '3.72117100', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-4005.849', '1462.696', '92.27657', '6.18035600', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3902.121', '1516.603', '43.03911', '3.53872900', '300', '0', '0', '0', '0', '0', '2'), -- x + 59
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3968.619', '1563.531', '66.14909', '0.20553990', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3961.449', '1641.886', '90.49254', '1.10937400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3883.597', '1587.640', '81.93299', '4.34950700', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3879.770', '1645.156', '84.84524', '5.43915200', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3819.025', '1653.583', '74.85554', '4.49788900', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3814.047', '1717.877', '93.48297', '2.57838800', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3867.834', '1732.107', '101.7153', '4.01071900', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3749.210', '1753.942', '83.42970', '5.96162800', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3750.264', '1813.892', '89.68528', '2.48003300', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3686.873', '1699.504', '40.89808', '2.73184800', '300', '0', '0', '0', '0', '0', '2'), -- x + 69
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3714.731', '1818.344', '76.98749', '4.29815900', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3659.335', '1756.456', '40.78264', '4.51790400', '300', '0', '0', '0', '0', '0', '2'), -- x + 71
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3710.710', '1879.895', '91.27804', '4.32893600', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3747.350', '1896.423', '104.9478', '0.70170860', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3658.188', '1846.846', '61.83801', '0.71981790', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3526.231', '1923.227', '76.36613', '2.50152300', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3513.701', '1870.485', '86.74851', '3.29156400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3505.914', '1821.854', '92.69957', '2.87824100', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3466.111', '1809.786', '103.9440', '6.22427100', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3348.607', '1750.611', '101.4064', '0.83170590', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3418.536', '1716.530', '106.6131', '2.20875100', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3328.624', '1641.063', '89.89996', '2.59388900', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3286.542', '1686.468', '75.64011', '0.36694600', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3417.779', '1652.075', '111.6684', '3.50989100', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3217.031', '1614.583', '70.61845', '2.13346100', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3181.773', '1512.901', '61.22135', '2.29262400', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3234.644', '1496.701', '53.61910', '2.07510800', '300', '0', '0', '0', '0', '0', '2'), -- x + 86
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3079.578', '1456.178', '14.04403', '6.10865200', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3186.007', '1480.489', '55.14701', '4.98156500', '300', '0', '0', '0', '0', '0', '2'), -- x + 88
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3084.113', '1384.975', '9.918798', '0.10219530', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3149.645', '1385.471', '12.66104', '5.95624200', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3182.702', '1314.611', '23.52866', '0.46801560', '300', '0', '0', '0', '0', '0', '2'), -- x + 91
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3254.076', '1315.386', '66.96973', '4.71238900', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3333.872', '1488.855', '60.61049', '1.52830300', '300', '0', '0', '0', '0', '0', '2'), -- x + 93
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3473.865', '1639.244', '53.92172', '1.46985300', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3593.993', '1643.338', '42.15769', '1.66699000', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3523.989', '1697.715', '57.57351', '1.24426000', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3585.892', '1736.058', '40.88088', '4.44222700', '300', '0', '0', '0', '0', '0', '2'), -- x + 97
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3685.642', '1614.460', '42.17778', '0.56657210', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3768.278', '1611.409', '42.06032', '1.76326700', '300', '5', '0', '0', '0', '0', '1'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3833.012', '1561.892', '42.23775', '5.18968500', '300', '0', '0', '0', '0', '0', '2'); -- x + 100

-- Uylaru [-1|+1]
SET @ENTRY := '21710';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3398.692', '1569.113', '48.56428', '4.8520150', '300', '0', '0', '0', '0', '0', '0');

-- Corrupt Fire Totem [-0|+3]
SET @ENTRY := '21703';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3404.077', '1566.567', '47.88474', '4.7822020', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3397.854', '1576.284', '47.14587', '5.5326940', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3392.402', '1566.671', '47.97179', '0.2094395', '300', '0', '0', '0', '0', '0', '0');

-- Eykenen [-1|+1]
SET @ENTRY := '21709';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3884.683', '1410.314', '43.97570', '2.9670600', '300', '0', '0', '0', '0', '0', '0');

-- Corrupt Earth Totem [-3|+3]
SET @ENTRY := '21704';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3883.987', '1404.300', '43.63169', '2.0594890', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3879.858', '1416.280', '45.31780', '0.6108652', '300', '0', '0', '0', '0', '0', '0'),
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3893.048', '1411.493', '44.15714', '3.7175510', '300', '0', '0', '0', '0', '0', '0');

-- Uvuros [-1|+1]
SET @ENTRY := '21102';
DELETE FROM `creature` WHERE `id`=@ENTRY;

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUID := @GUID + '1', @ENTRY, '530', '1', '0', '0', '-3744.360', '1194.464', '82.55341', '5.3581610', '300', '0', '0', '0', '0', '0', '0');

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '1';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3966.661', '1348.314', '39.68160', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3982.043', '1362.629', '39.71037', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3993.894', '1368.137', '39.70597', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4024.098', '1350.256', '37.81841', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4047.619', '1336.134', '39.98072', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4068.789', '1317.866', '41.59033', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4047.619', '1336.134', '39.98072', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-4024.098', '1350.256', '37.81841', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3993.894', '1368.137', '39.70597', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3982.214', '1362.787', '39.71037', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3966.661', '1348.314', '39.68160', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3963.918', '1305.338', '39.68935', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '5';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3877.228', '1281.433', '39.52972', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3864.557', '1301.940', '39.75750', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3851.966', '1308.705', '39.75750', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3844.692', '1333.741', '39.85207', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3848.119', '1362.103', '40.78005', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3841.732', '1375.505', '40.30152', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3843.752', '1397.419', '39.35426', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3843.176', '1421.318', '39.29580', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3843.778', '1397.466', '39.18543', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3841.732', '1375.505', '40.30152', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3848.119', '1362.103', '40.78005', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3844.692', '1333.741', '39.85207', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3851.966', '1308.705', '39.75750', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3864.557', '1301.940', '39.75750', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3877.228', '1281.433', '39.52972', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3884.200', '1265.161', '39.60587', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '6';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3862.637', '1372.648', '41.00941', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3851.491', '1361.881', '40.48562', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3844.906', '1341.203', '39.97707', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3849.517', '1313.437', '39.70293', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3862.557', '1305.086', '39.75750', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3849.517', '1313.437', '39.70293', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3844.906', '1341.203', '39.97707', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3851.491', '1361.881', '40.48562', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3862.637', '1372.648', '41.00941', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3865.949', '1398.294', '40.02015', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '8';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3851.612', '1456.155', '39.94035', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3846.642', '1464.607', '38.85209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3850.096', '1476.015', '39.08060', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3859.760', '1492.439', '40.22611', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3871.936', '1501.833', '40.14218', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3885.933', '1498.914', '40.64204', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3895.244', '1496.856', '39.95760', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3885.933', '1498.914', '40.64204', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3871.936', '1501.833', '40.14218', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3859.760', '1492.439', '40.22611', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3850.096', '1476.015', '39.08060', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3846.642', '1464.607', '38.85209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3851.612', '1456.155', '39.94035', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3856.105', '1444.823', '40.58195', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '10';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3798.786', '1553.103', '36.26998', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3792.497', '1560.754', '34.90401', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3791.767', '1579.444', '37.74704', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3802.113', '1584.761', '38.04142', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3820.368', '1576.584', '39.42118', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3848.582', '1577.911', '39.91356', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3855.335', '1561.266', '40.34032', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3863.603', '1549.112', '39.87230', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3869.726', '1525.698', '40.40732', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3878.041', '1514.083', '39.96201', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3869.726', '1525.698', '40.40732', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3863.603', '1549.112', '39.87230', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3855.335', '1561.266', '40.34032', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3848.582', '1577.911', '39.91356', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3820.368', '1576.584', '39.42118', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3802.113', '1584.761', '38.04142', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3791.767', '1579.444', '37.74704', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3792.497', '1560.754', '34.90401', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3798.786', '1553.103', '36.26998', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3809.915', '1546.029', '38.62252', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '17';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3613.111', '1512.661', '84.76304', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3636.142', '1513.880', '85.33750', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '19';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3685.122', '1631.567', '41.32896', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3674.267', '1609.299', '42.86021', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3655.034', '1594.121', '44.64022', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3674.267', '1609.299', '42.86021', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3685.122', '1631.567', '41.32896', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3690.860', '1660.168', '39.37911', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '23';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3556.126', '1694.759', '40.17222', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3562.115', '1708.797', '39.73536', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3562.772', '1727.675', '39.86036', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3562.615', '1747.675', '38.67850', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3569.429', '1761.298', '39.56737', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3579.794', '1773.608', '39.10586', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3582.570', '1780.497', '39.32803', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3577.259', '1787.475', '39.98086', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3564.290', '1794.507', '39.65005', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3577.259', '1787.475', '39.98086', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3582.570', '1780.497', '39.32803', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3579.794', '1773.608', '39.10586', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3569.429', '1761.298', '39.56737', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3562.604', '1747.943', '38.51286', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3562.772', '1727.675', '39.86036', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3562.115', '1708.797', '39.73536', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3556.126', '1694.759', '40.17222', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3565.220', '1683.332', '39.21604', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '24';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3607.786', '1745.441', '39.73397', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3610.059', '1758.763', '39.10897', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3606.948', '1779.317', '39.82947', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3603.752', '1794.376', '39.74744', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3616.517', '1802.796', '39.86226', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3629.782', '1803.063', '39.58028', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3644.492', '1797.165', '39.72593', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3657.183', '1788.322', '39.72593', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3663.814', '1778.259', '39.72593', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3657.183', '1788.322', '39.72593', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3644.492', '1797.165', '39.72593', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3629.782', '1803.063', '39.58028', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3616.517', '1802.796', '39.86226', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3603.752', '1794.376', '39.74744', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3606.948', '1779.317', '39.82947', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3610.059', '1758.763', '39.10897', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3607.786', '1745.441', '39.73397', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3608.346', '1725.416', '39.56675', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '28';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3495.523', '1674.854', '54.05362', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3490.152', '1696.188', '64.45596', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3475.687', '1716.370', '72.83356', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3459.085', '1730.499', '83.66209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3435.279', '1746.453', '98.65145', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3459.085', '1730.499', '83.66209', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3475.687', '1716.370', '72.83356', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3490.157', '1696.191', '64.40372', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3495.523', '1674.854', '54.05362', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3509.487', '1658.060', '46.64849', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '31';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3377.245', '1738.781', '100.8844', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3379.829', '1753.055', '100.9325', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3387.415', '1755.659', '101.1016', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3379.829', '1753.055', '100.9325', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3377.245', '1738.781', '100.8844', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3390.743', '1719.957', '100.9751', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '32';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3376.523', '1674.045', '98.72786', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3394.130', '1688.848', '99.74837', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3392.110', '1711.657', '101.1825', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3394.130', '1688.848', '99.74837', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3376.523', '1674.045', '98.72786', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3361.519', '1669.541', '94.49751', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '34';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3413.367', '1791.373', '99.69798', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3431.269', '1793.322', '100.5617', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3438.707', '1784.378', '100.8168', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3440.137', '1772.868', '100.8836', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3430.415', '1756.091', '100.8905', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3440.137', '1772.868', '100.8836', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3438.707', '1784.378', '100.8168', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3431.269', '1793.322', '100.5617', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3413.411', '1791.203', '99.76389', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3409.603', '1803.208', '97.50513', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '35';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3364.697', '1625.718', '67.45491', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3358.170', '1645.251', '78.26536', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3355.514', '1662.498', '90.43528', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3358.170', '1645.251', '78.26536', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3364.697', '1625.718', '67.45491', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3363.971', '1594.718', '47.73098', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3364.697', '1625.718', '67.14265', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3358.170', '1645.251', '78.26536', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3355.514', '1662.498', '90.43528', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3358.170', '1645.251', '78.26536', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3364.697', '1625.718', '67.45491', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3363.971', '1594.718', '47.73098', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '39';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3270.670', '1586.074', '50.19849', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3292.600', '1586.784', '50.24732', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3317.282', '1592.559', '49.21576', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3318.112', '1582.750', '49.43244', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3301.980', '1578.054', '49.78742', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3301.512', '1564.927', '50.64901', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3316.518', '1554.231', '50.29134', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3304.758', '1542.962', '49.04280', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3272.580', '1544.624', '50.71184', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3276.326', '1555.708', '51.05583', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3267.039', '1567.807', '51.15406', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3250.104', '1571.737', '51.06451', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3242.369', '1579.531', '50.58331', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3251.172', '1585.850', '49.27813', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '40';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3266.944', '1495.482', '50.70709', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3260.746', '1475.659', '51.25534', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3242.165', '1471.615', '49.59628', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3218.661', '1475.549', '47.78694', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3213.801', '1500.323', '48.97348', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3224.212', '1521.493', '49.84909', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3213.801', '1500.323', '48.97348', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3218.661', '1475.549', '47.78694', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3242.165', '1471.615', '49.59628', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3260.746', '1475.659', '51.25534', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3266.944', '1495.482', '50.70709', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3265.549', '1516.259', '50.79179', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '41';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3270.971', '1376.588', '50.29376', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3280.325', '1397.854', '51.23919', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3289.615', '1434.420', '50.68203', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3280.579', '1453.911', '50.48915', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3265.446', '1437.963', '50.94470', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3258.100', '1414.249', '49.12197', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3264.547', '1392.286', '51.29313', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3252.828', '1368.444', '49.72086', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3250.914', '1354.164', '51.24254', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3258.653', '1355.439', '50.72826', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '44';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3182.042', '1354.782', '5.891076', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3174.273', '1361.083', '6.436242', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3164.761', '1357.554', '7.730681', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3157.927', '1345.460', '9.404876', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3144.306', '1336.979', '7.899871', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3129.863', '1332.921', '12.63351', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3119.914', '1331.117', '13.21066', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3105.562', '1328.574', '5.339685', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3090.967', '1322.019', '3.507803', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3078.913', '1318.775', '2.916128', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3090.967', '1322.019', '3.507803', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3105.562', '1328.574', '5.339685', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3119.914', '1331.117', '13.21066', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3129.732', '1332.891', '12.60800', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3144.306', '1336.979', '7.899871', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3157.927', '1345.460', '9.404876', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3164.761', '1357.554', '7.730681', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3174.273', '1361.083', '6.436242', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3182.042', '1354.782', '5.891076', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3192.773', '1354.919', '5.891076', '0', '0', '0', '100', '0');

-- Enraged Fire Spirit
SET @GUID := @GUIDSTART + '45';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3029.917', '1375.073', '8.104202', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3038.843', '1369.191', '6.326932', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3050.946', '1376.182', '6.012967', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3055.799', '1393.589', '5.339383', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3049.967', '1404.723', '5.382828', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3044.835', '1416.556', '6.239396', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3039.312', '1433.172', '5.309830', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3036.245', '1451.358', '6.765009', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3028.730', '1468.617', '7.079117', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3036.245', '1451.358', '6.765009', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3039.312', '1433.172', '5.309830', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3044.835', '1416.556', '6.239396', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3049.967', '1404.723', '5.382828', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3055.799', '1393.589', '5.339383', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3050.946', '1376.182', '6.012967', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3038.843', '1369.191', '6.326932', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3029.917', '1375.073', '8.104202', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3013.523', '1380.948', '11.48164', '0', '0', '0', '100', '0');

-- Spawn of Uvuros
SET @GUID := @GUIDSTART + '46'; 
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3261.052', '1370.817', '50.43204', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3259.591', '1396.251', '51.30545', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3260.267', '1417.615', '49.94558', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3268.925', '1438.428', '50.73915', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3277.157', '1454.070', '50.79006', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3273.442', '1469.771', '50.80280', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3268.631', '1489.467', '50.80280', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3265.457', '1513.454', '50.52824', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3268.582', '1547.500', '50.79436', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3292.102', '1569.630', '51.72522', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3312.658', '1583.314', '48.13527', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3331.849', '1587.753', '52.29828', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3351.814', '1591.260', '51.01516', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3376.521', '1590.513', '48.12061', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3401.154', '1591.178', '46.47407', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3418.478', '1593.764', '46.80402', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3438.720', '1598.961', '46.00710', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3459.175', '1607.099', '44.76759', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3477.656', '1618.874', '43.46716', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3493.255', '1634.055', '43.22388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3506.059', '1646.729', '45.10381', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3520.908', '1661.742', '45.64239', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3540.830', '1677.818', '41.02866', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3554.971', '1691.269', '40.24473', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3562.589', '1703.800', '39.84192', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3566.669', '1722.530', '39.90781', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3567.719', '1741.610', '39.81187', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3574.672', '1753.050', '39.81737', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3583.069', '1759.762', '39.94237', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3595.444', '1760.937', '40.31737', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3615.263', '1759.552', '39.35897', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3637.424', '1757.551', '40.38606', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3662.133', '1747.172', '40.81453', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3679.094', '1731.953', '39.74870', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3700.690', '1712.346', '40.11227', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3720.564', '1700.168', '39.88595', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3741.941', '1695.867', '40.08457', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3761.721', '1690.102', '39.73850', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3776.717', '1684.102', '42.48848', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3782.882', '1667.605', '44.21590', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3777.177', '1651.166', '40.49483', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3763.309', '1632.191', '40.09911', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3735.632', '1624.778', '39.02733', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3708.306', '1623.589', '40.79650', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3682.398', '1614.112', '42.12840', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3642.329', '1607.818', '43.93411', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3622.813', '1613.005', '44.44532', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3597.527', '1619.549', '44.18061', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3581.189', '1613.882', '45.11066', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3555.823', '1619.289', '44.40530', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3534.210', '1619.247', '45.11855', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3514.888', '1596.725', '45.30498', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3490.427', '1582.333', '46.29775', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3468.826', '1584.601', '47.17080', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3444.473', '1562.420', '46.86129', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3425.052', '1548.150', '47.58210', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3406.093', '1541.807', '48.58210', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3383.017', '1535.272', '49.26402', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3348.572', '1526.081', '52.90599', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3330.415', '1513.742', '53.77206', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3316.707', '1496.823', '50.89009', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3302.981', '1475.289', '49.69674', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3295.732', '1450.932', '49.38251', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3292.761', '1433.665', '50.58071', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3287.547', '1413.096', '49.76452', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3283.492', '1396.401', '51.95086', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3283.792', '1368.525', '49.50677', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3270.693', '1350.602', '50.33706', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3260.033', '1350.003', '49.33507', '0', '0', '0', '100', '0');

-- Spawn of Uvuros
SET @GUID := @GUIDSTART + '47';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3396.531', '1763.735', '103.6715', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3379.886', '1753.972', '100.9325', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3351.075', '1731.366', '101.1027', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3335.615', '1706.502', '92.09635', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3313.236', '1680.902', '82.59068', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3280.050', '1659.776', '76.94063', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3256.454', '1644.560', '75.24611', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3228.498', '1617.366', '73.30030', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3203.841', '1603.456', '65.55091', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3201.420', '1584.667', '64.65486', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3210.530', '1554.086', '69.44525', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3203.931', '1537.755', '63.10846', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3191.709', '1521.932', '58.59893', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3196.587', '1492.656', '56.64238', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3225.277', '1459.418', '52.93445', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3238.553', '1442.582', '54.95837', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3247.033', '1425.069', '54.55080', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3257.249', '1405.119', '49.37111', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3257.781', '1372.573', '50.29313', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3258.098', '1356.509', '50.86205', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3276.818', '1362.266', '51.14101', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3293.685', '1386.509', '54.60675', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3300.835', '1403.705', '48.41467', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3296.142', '1444.353', '49.72927', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3299.179', '1481.897', '49.46906', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3306.986', '1513.383', '49.63754', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3313.588', '1545.196', '49.11946', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3318.321', '1574.779', '52.82721', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3333.300', '1582.579', '52.62922', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3360.646', '1591.053', '48.30080', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3364.933', '1616.938', '57.70552', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3364.986', '1625.938', '67.14265', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3360.393', '1641.267', '76.21262', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3355.990', '1654.556', '85.33762', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3359.185', '1667.092', '93.14179', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3366.348', '1672.388', '96.57612', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3382.228', '1678.242', '99.06844', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3392.588', '1689.778', '100.1087', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3392.004', '1707.503', '101.3446', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3389.512', '1722.959', '100.9325', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3395.845', '1737.874', '100.9760', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3422.167', '1761.102', '100.8965', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3426.048', '1779.245', '101.0012', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3411.591', '1779.760', '102.7506', '0', '0', '0', '100', '0');

-- Spawn of Uvuros
SET @GUID := @GUIDSTART + '48';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3883.975', '1263.450', '39.57877', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3877.299', '1295.013', '41.17059', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3861.565', '1336.159', '42.57558', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3856.842', '1374.854', '40.72926', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3853.621', '1415.182', '41.28652', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3850.096', '1449.127', '40.63004', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3837.649', '1471.836', '42.25663', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3812.637', '1487.339', '43.66748', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3778.138', '1477.471', '45.69685', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3761.435', '1481.047', '46.64577', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3752.615', '1506.764', '46.73626', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3760.840', '1521.903', '46.17974', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3740.406', '1548.016', '45.69281', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3701.556', '1555.235', '46.53735', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3666.428', '1555.937', '48.74696', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3641.703', '1560.784', '48.89943', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3621.069', '1564.322', '49.37859', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3586.438', '1575.808', '48.08504', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3565.169', '1579.912', '47.44227', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3544.782', '1581.799', '47.61414', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3527.046', '1582.921', '46.90386', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3504.064', '1581.823', '46.44817', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3478.576', '1585.087', '46.27065', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3460.618', '1590.825', '46.06741', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3440.108', '1591.190', '46.27847', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3426.212', '1578.240', '46.94013', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3411.032', '1558.515', '47.33210', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3404.604', '1542.934', '48.61762', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3389.848', '1526.002', '51.15543', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3368.523', '1513.192', '52.20939', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3351.651', '1503.182', '54.91648', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3351.657', '1527.715', '52.74461', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3364.133', '1546.499', '48.51556', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3392.952', '1570.519', '47.51637', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3417.222', '1593.474', '46.98994', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3445.851', '1601.562', '45.30702', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3491.342', '1617.464', '44.01123', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3519.079', '1613.837', '44.54689', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3547.801', '1609.742', '46.08816', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3567.615', '1603.953', '46.46394', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3599.266', '1603.943', '46.56330', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3629.512', '1602.128', '44.90650', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3663.672', '1596.284', '44.14022', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3684.847', '1597.485', '44.30370', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3706.536', '1597.117', '43.56276', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3740.229', '1592.695', '42.73486', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3765.860', '1589.795', '42.14697', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3776.209', '1586.297', '43.06784', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3801.413', '1582.604', '38.66776', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3818.088', '1579.023', '39.01566', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3833.926', '1572.863', '40.53856', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3853.145', '1562.179', '40.32445', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3864.950', '1546.461', '39.87780', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3877.748', '1532.587', '40.83701', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3887.162', '1514.339', '40.20065', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3897.826', '1498.679', '39.94930', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3911.663', '1481.578', '40.96449', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3923.059', '1472.531', '39.72596', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3942.438', '1456.924', '39.64678', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3951.686', '1438.097', '39.99761', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3957.481', '1416.761', '41.08671', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3962.978', '1389.702', '40.50446', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3962.620', '1365.318', '39.93514', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3958.417', '1341.775', '40.65548', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3949.188', '1329.422', '39.64235', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3930.227', '1332.664', '39.72723', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3912.603', '1323.637', '39.72723', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3905.935', '1306.785', '40.00555', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3897.439', '1291.250', '39.77972', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3895.385', '1274.919', '39.77972', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3897.776', '1262.570', '40.61844', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3894.454', '1248.885', '40.76053', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3889.979', '1241.081', '41.68936', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3874.964', '1239.425', '43.99124', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '49'; 
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3885.240', '1364.806', '47.32335', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3893.468', '1378.957', '44.22478', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3890.696', '1403.879', '42.45049', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3878.542', '1416.131', '45.03984', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3868.016', '1422.589', '43.28850', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3866.986', '1431.180', '44.35478', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3872.096', '1444.150', '44.33565', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3887.687', '1451.941', '43.10823', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3904.409', '1442.322', '43.87148', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3915.545', '1437.817', '42.73317', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3935.223', '1430.502', '42.05680', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3948.244', '1414.806', '42.20597', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3949.208', '1394.731', '42.42316', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3942.230', '1380.242', '48.84430', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3926.847', '1369.215', '56.77013', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3914.108', '1356.588', '48.61945', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3901.195', '1340.179', '44.42853', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3884.467', '1330.002', '42.31290', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3867.133', '1337.162', '42.78844', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '59';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3914.196', '1511.538', '41.50407', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3921.157', '1501.577', '41.83073', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3943.445', '1494.013', '42.36216', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3921.454', '1495.902', '42.89320', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3910.507', '1493.047', '42.32911', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3905.857', '1475.243', '42.60096', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3909.167', '1494.119', '42.26332', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3907.289', '1501.576', '41.53849', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3901.062', '1508.516', '41.95768', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3900.365', '1514.210', '42.87772', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3903.610', '1517.513', '43.24992', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '69';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3709.945', '1709.525', '41.01095', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3720.238', '1723.055', '43.88595', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3738.680', '1715.650', '43.50869', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3736.526', '1705.155', '41.14419', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3727.699', '1692.519', '41.20983', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3723.818', '1683.273', '41.00549', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3717.185', '1677.910', '40.70983', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3711.126', '1677.806', '41.08483', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3703.645', '1693.281', '40.71606', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3691.058', '1695.034', '40.92959', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3691.011', '1699.614', '40.92959', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '71';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3665.200', '1726.542', '41.00065', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3685.951', '1704.760', '40.74003', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3708.052', '1711.204', '40.72897', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3711.397', '1734.295', '49.12101', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3690.316', '1757.645', '53.07401', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3683.085', '1771.540', '52.25634', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3667.904', '1764.635', '41.10392', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3661.037', '1753.775', '40.54902', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '86';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3238.603', '1503.875', '53.12578', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3242.168', '1516.518', '52.48369', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3248.125', '1528.953', '52.95305', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3248.861', '1516.293', '52.52824', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3247.510', '1508.754', '53.04033', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3252.998', '1499.196', '53.13034', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3244.429', '1497.290', '52.85495', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3236.769', '1495.461', '53.52316', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '88';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3181.236', '1463.110', '48.81565', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3168.532', '1444.734', '37.02708', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3166.327', '1435.308', '33.06020', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3188.029', '1418.776', '26.58076', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3188.216', '1403.985', '17.01582', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3161.896', '1384.002', '12.73356', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3137.334', '1364.318', '15.08554', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3111.115', '1363.514', '11.71142', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3095.935', '1342.166', '11.30849', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3083.227', '1340.211', '11.49074', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3068.760', '1350.527', '12.61390', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3071.868', '1369.817', '10.94514', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3073.509', '1402.595', '11.95168', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3080.528', '1424.535', '12.57888', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3068.792', '1440.774', '11.69368', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3053.285', '1455.278', '15.71386', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3049.059', '1481.634', '19.06850', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3040.421', '1505.779', '21.51766', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3060.786', '1516.275', '27.21846', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3082.017', '1521.448', '31.14843', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3115.762', '1517.771', '36.77888', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3148.282', '1512.845', '52.54025', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3179.017', '1499.947', '57.56462', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3188.386', '1488.957', '56.37053', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3188.365', '1476.448', '54.75310', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '91';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3169.582', '1321.246', '20.41059', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3151.086', '1321.264', '18.86339', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3129.894', '1308.252', '15.26388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3116.495', '1296.661', '10.75269', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3103.535', '1292.129', '8.244267', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3087.993', '1285.691', '7.557983', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3103.535', '1292.129', '8.244267', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3116.495', '1296.661', '10.75269', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3129.894', '1308.252', '15.26388', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3151.086', '1321.264', '18.86339', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3169.582', '1321.246', '20.41059', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3182.668', '1317.121', '23.24592', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '93';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3333.127', '1505.996', '56.88705', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3333.297', '1531.010', '53.27084', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3336.890', '1549.107', '53.41644', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3359.720', '1559.841', '48.68084', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3386.077', '1564.115', '47.83860', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3399.071', '1572.567', '48.68861', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3403.656', '1588.113', '47.37836', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3410.922', '1597.664', '48.89814', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3435.559', '1600.706', '46.05702', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3455.617', '1598.535', '45.76723', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3474.853', '1601.084', '47.08947', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3487.188', '1609.624', '44.91955', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3498.708', '1610.491', '45.33032', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3507.274', '1622.938', '44.48219', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3525.378', '1631.045', '44.88404', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3540.047', '1633.398', '44.68267', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3551.048', '1629.547', '45.11062', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3570.073', '1627.939', '46.33479', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3551.048', '1629.547', '45.11062', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3540.047', '1633.398', '44.68267', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3525.378', '1631.045', '44.88404', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3507.274', '1622.938', '44.48219', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3498.708', '1610.491', '45.33032', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3487.263', '1609.681', '44.97107', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3474.853', '1601.084', '47.08947', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3455.617', '1598.535', '45.76723', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3435.559', '1600.706', '46.05702', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3411.025', '1597.808', '49.02583', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3403.656', '1588.113', '47.37836', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3399.125', '1572.770', '48.79957', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3386.077', '1564.115', '47.83860', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3359.720', '1559.841', '48.68084', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3336.890', '1549.107', '53.41644', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3333.297', '1531.010', '53.27084', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3333.127', '1505.996', '56.88705', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3331.013', '1486.700', '61.64925', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '97';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3589.718', '1722.242', '41.14121', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3597.313', '1712.778', '41.14121', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3618.428', '1713.334', '41.31626', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3625.589', '1736.798', '40.76400', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3635.015', '1739.896', '41.21443', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3625.589', '1736.798', '40.76400', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3618.428', '1713.334', '41.31626', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3597.313', '1712.778', '41.14121', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3589.718', '1722.242', '41.14121', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3585.924', '1736.551', '40.81908', '0', '0', '0', '100', '0');

-- Enraged Earth Spirit
SET @GUID := @GUIDSTART + '100';
SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16908544,0,4097,0,0,'36006 0');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, @POINT := @POINT + '1', '-3825.014', '1546.434', '42.23067', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3817.830', '1531.363', '43.49965', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3804.013', '1529.107', '44.79787', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3794.242', '1527.443', '45.19921', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3793.912', '1511.280', '45.78661', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3802.640', '1500.825', '44.64186', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3815.027', '1494.317', '43.41748', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3843.093', '1496.748', '42.07108', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3853.235', '1507.411', '42.07387', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3846.999', '1533.572', '42.09203', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3830.346', '1546.582', '41.71285', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3828.609', '1551.348', '41.51583', '0', '0', '0', '100', '0'),
(@GUID, @POINT := @POINT + '1', '-3833.577', '1561.334', '42.24730', '0', '0', '0', '100', '0');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2479/molten-core-patrols
--
-- Lava Surger 12101 [-12|+12]
DELETE FROM `creature` WHERE `id`='12101';
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('56656', '12101', '409', '1', '0', '0', '1039.557', '-666.4965', '-175.5690', '5.393786', '1680', '0', '0', '0', '0', '0', '2'),
('56657', '12101', '409', '1', '0', '0', '1013.988', '-807.3286', '-148.2019', '5.479007', '1680', '0', '0', '0', '0', '0', '2'),
('56658', '12101', '409', '1', '0', '0', '1056.576', '-861.7056', '-159.4021', '2.829309', '1680', '0', '0', '0', '0', '0', '2'),
('56659', '12101', '409', '1', '0', '0', '956.5746', '-882.7143', '-173.4351', '5.244633', '1680', '0', '0', '0', '0', '0', '2'),
('56660', '12101', '409', '1', '0', '0', '1009.204', '-863.9430', '-164.4548', '4.396853', '1680', '0', '0', '0', '0', '0', '2'),
('56661', '12101', '409', '1', '0', '0', '989.7455', '-625.5197', '-200.8345', '1.059593', '1680', '0', '0', '0', '0', '0', '2'),
('56662', '12101', '409', '1', '0', '0', '805.4228', '-659.1059', '-206.9372', '4.054467', '1680', '0', '0', '0', '0', '0', '2'),
('56664', '12101', '409', '1', '0', '0', '766.6229', '-685.1467', '-212.6748', '4.289903', '1680', '0', '0', '0', '0', '0', '2'),
('56665', '12101', '409', '1', '0', '0', '889.0994', '-822.9662', '-227.2441', '1.828480', '1680', '0', '0', '0', '0', '0', '2'),
('56666', '12101', '409', '1', '0', '0', '691.6334', '-662.5723', '-209.6153', '5.214818', '1680', '0', '0', '0', '0', '0', '2'),
('56740', '12101', '409', '1', '0', '0', '608.5266', '-1192.999', '-195.7372', '0.417171', '1680', '0', '0', '0', '0', '0', '2'),
('56741', '12101', '409', '1', '0', '0', '758.0289', '-1227.535', '-119.5741', '2.510490', '1680', '0', '0', '0', '0', '0', '2');
-- Ancient Core Hound 11673 [-14|+15]
DELETE FROM `creature` WHERE `id`='11673';
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
('56667', '11673', '409', '1', '0', '0', '1142.959', '-645.0295', '-131.8003', '1.6231560', '1080', '0', '0', '0', '0', '0', '2'),
('56668', '11673', '409', '1', '0', '0', '711.9438', '-591.7904', '-210.7750', '1.4198990', '1080', '0', '0', '0', '0', '0', '2'),
('56669', '11673', '409', '1', '0', '0', '1039.007', '-817.4524', '-152.2047', '0.9648618', '1080', '0', '0', '0', '0', '0', '2'),
('56670', '11673', '409', '1', '0', '0', '813.1617', '-646.3583', '-204.5891', '0.7919637', '1080', '0', '0', '0', '0', '0', '2'),
('56671', '11673', '409', '1', '0', '0', '669.2405', '-532.0613', '-210.2233', '0.2158491', '1080', '0', '0', '0', '0', '0', '2'),
('56672', '11673', '409', '1', '0', '0', '708.1201', '-604.0325', '-209.6696', '4.3744790', '1080', '0', '0', '0', '0', '0', '2'),
('56673', '11673', '409', '1', '0', '0', '729.6019', '-485.4805', '-212.5103', '4.5383950', '1080', '0', '0', '0', '0', '0', '2'),
('56674', '11673', '409', '1', '0', '0', '709.8370', '-932.3306', '-191.2970', '1.9807470', '1080', '0', '0', '0', '0', '0', '2'),
('56675', '11673', '409', '1', '0', '0', '705.4085', '-1197.964', '-119.9327', '2.5816860', '1080', '0', '0', '0', '0', '0', '2'),
('56676', '11673', '409', '1', '0', '0', '576.6952', '-777.4089', '-207.3211', '4.4228480', '1080', '0', '0', '0', '0', '0', '2'),
('56742', '11673', '409', '1', '0', '0', '814.4380', '-973.4529', '-208.8811', '5.0248670', '1080', '0', '0', '0', '0', '0', '2'),
('56743', '11673', '409', '1', '0', '0', '607.6859', '-1160.476', '-198.0445', '1.1930560', '1080', '0', '0', '0', '0', '0', '2'),
('56744', '11673', '409', '1', '0', '0', '659.5686', '-1071.075', '-190.9022', '6.1722460', '1080', '0', '0', '0', '0', '0', '2'),
('56745', '11673', '409', '1', '0', '0', '746.8201', '-997.8535', '-177.5622', '4.2786960', '1080', '0', '0', '0', '0', '0', '2'),
('56746', '11673', '409', '1', '0', '0', '796.0061', '-639.6680', '-204.3206', '0.3408172', '1080', '0', '0', '0', '0', '0', '2');

-- -------------------------------------------------------------------------------------------------------------------------------
SET @GUID := '56656';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56656', '01', '1046.413', '-674.9515', '-169.5157', '0', '0', '0', '100', '0'),
('56656', '02', '1068.962', '-696.5590', '-157.7810', '0', '0', '0', '100', '0'),
('56656', '03', '1053.966', '-737.0459', '-151.7794', '0', '0', '0', '100', '0'),
('56656', '04', '1059.624', '-760.5685', '-151.5860', '0', '0', '0', '100', '0'),
('56656', '05', '1084.683', '-739.8831', '-150.7728', '0', '0', '0', '100', '0'),
('56656', '06', '1099.292', '-778.5201', '-151.1692', '0', '0', '0', '100', '0'),
('56656', '07', '1125.305', '-739.6833', '-142.7612', '0', '0', '0', '100', '0'),
('56656', '08', '1159.508', '-719.2535', '-133.2384', '0', '0', '0', '100', '0'),
('56656', '09', '1192.168', '-686.1762', '-128.7967', '0', '0', '0', '100', '0'),
('56656', '10', '1211.332', '-653.7628', '-127.9139', '0', '0', '0', '100', '0'),
('56656', '11', '1187.516', '-611.0389', '-121.1588', '0', '0', '0', '100', '0'),
('56656', '12', '1148.847', '-599.9906', '-114.8980', '0', '0', '0', '100', '0'),
('56656', '13', '1187.516', '-611.0389', '-121.1588', '0', '0', '0', '100', '0'),
('56656', '14', '1211.332', '-653.7628', '-127.9139', '0', '0', '0', '100', '0'),
('56656', '15', '1192.168', '-686.1762', '-128.7967', '0', '0', '0', '100', '0'),
('56656', '16', '1159.508', '-719.2535', '-133.2384', '0', '0', '0', '100', '0'),
('56656', '17', '1125.392', '-739.6312', '-142.7302', '0', '0', '0', '100', '0'),
('56656', '18', '1099.292', '-778.5201', '-151.1692', '0', '0', '0', '100', '0'),
('56656', '19', '1084.683', '-739.8831', '-150.7728', '0', '0', '0', '100', '0'),
('56656', '20', '1059.654', '-760.5442', '-151.5920', '0', '0', '0', '100', '0'),
('56656', '21', '1053.966', '-737.0459', '-151.7794', '0', '0', '0', '100', '0'),
('56656', '22', '1068.962', '-696.5590', '-157.7810', '0', '0', '0', '100', '0'),
('56656', '23', '1046.413', '-674.9515', '-169.5157', '0', '0', '0', '100', '0'),
('56656', '24', '1023.840', '-646.4510', '-189.8513', '0', '0', '0', '100', '0');

SET @GUID := '56657';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56657', '01', '1032.143', '-826.1788', '-154.2626', '0', '0', '0', '100', '0'),
('56657', '02', '1055.823', '-833.2653', '-154.4680', '0', '0', '0', '100', '0'),
('56657', '03', '1032.143', '-826.1788', '-154.2626', '0', '0', '0', '100', '0'),
('56657', '04', '1015.666', '-808.7546', '-148.7213', '0', '0', '0', '100', '0');

SET @GUID := '56658';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56658', '01', '1035.173', '-854.7958', '-158.8589', '0', '0', '0', '100', '0'),
('56658', '02', '995.0676', '-853.4235', '-165.4317', '0', '0', '0', '100', '0'),
('56658', '03', '1035.173', '-854.7958', '-158.8589', '0', '0', '0', '100', '0'),
('56658', '04', '1057.385', '-862.5274', '-159.6177', '0', '0', '0', '100', '0');

SET @GUID := '56659';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56659', '01', '966.7530', '-899.8453', '-175.7252', '0', '0', '0', '100', '0'),
('56659', '02', '980.3823', '-904.3610', '-171.1376', '0', '0', '0', '100', '0'),
('56659', '03', '1008.565', '-890.0919', '-165.3463', '0', '0', '0', '100', '0'),
('56659', '04', '1028.491', '-908.0417', '-161.3687', '0', '0', '0', '100', '0'),
('56659', '05', '1041.238', '-888.9818', '-158.3343', '0', '0', '0', '100', '0'),
('56659', '06', '1061.057', '-900.0848', '-159.2599', '0', '0', '0', '100', '0'),
('56659', '07', '1071.243', '-893.1624', '-156.4947', '0', '0', '0', '100', '0'),
('56659', '08', '1061.057', '-900.0848', '-159.2599', '0', '0', '0', '100', '0'),
('56659', '09', '1041.238', '-888.9818', '-158.3343', '0', '0', '0', '100', '0'),
('56659', '10', '1028.491', '-908.0417', '-161.3687', '0', '0', '0', '100', '0'),
('56659', '11', '1008.565', '-890.0919', '-165.3463', '0', '0', '0', '100', '0'),
('56659', '12', '980.3823', '-904.3610', '-171.1376', '0', '0', '0', '100', '0'),
('56659', '13', '966.7530', '-899.8453', '-175.7252', '0', '0', '0', '100', '0'),
('56659', '14', '957.4196', '-885.5380', '-173.7588', '0', '0', '0', '100', '0');

SET @GUID := '56660';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56660', '01', '1001.684', '-886.9771', '-167.0547', '0', '0', '0', '100', '0'),
('56660', '02', '987.0620', '-893.2951', '-169.7379', '0', '0', '0', '100', '0'),
('56660', '03', '962.8450', '-884.6795', '-173.6825', '0', '0', '0', '100', '0'),
('56660', '04', '996.8139', '-897.9012', '-168.1947', '0', '0', '0', '100', '0'),
('56660', '05', '1031.916', '-889.5740', '-160.0134', '0', '0', '0', '100', '0'),
('56660', '06', '1069.734', '-893.8550', '-156.7931', '0', '0', '0', '100', '0'),
('56660', '07', '1031.916', '-889.5740', '-160.0134', '0', '0', '0', '100', '0'),
('56660', '08', '996.8139', '-897.9012', '-168.1947', '0', '0', '0', '100', '0'),
('56660', '09', '962.8450', '-884.6795', '-173.6825', '0', '0', '0', '100', '0'),
('56660', '10', '987.0620', '-893.2951', '-169.7379', '0', '0', '0', '100', '0'),
('56660', '11', '1001.684', '-886.9771', '-167.0547', '0', '0', '0', '100', '0'),
('56660', '12', '1008.282', '-863.9785', '-164.7876', '0', '0', '0', '100', '0');

SET @GUID := '56661';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56661', '01', '998.6928', '-609.5692', '-202.0619', '0', '0', '0', '100', '0'),
('56661', '02', '989.8893', '-595.9269', '-203.2261', '0', '0', '0', '100', '0'),
('56661', '03', '975.5094', '-589.3787', '-203.7810', '0', '0', '0', '100', '0'),
('56661', '04', '958.4057', '-595.7327', '-203.9931', '0', '0', '0', '100', '0'),
('56661', '05', '950.7159', '-608.6719', '-202.8820', '0', '0', '0', '100', '0'),
('56661', '06', '957.0149', '-625.9316', '-203.2590', '0', '0', '0', '100', '0'),
('56661', '07', '980.0177', '-632.2986', '-203.5142', '0', '0', '0', '100', '0'),
('56661', '08', '990.2437', '-625.7770', '-200.7675', '0', '0', '0', '100', '0');

SET @GUID := '56662';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56662', '01', '800.4368', '-665.5578', '-208.9407', '0', '0', '0', '100', '0'),
('56662', '02', '779.0322', '-680.1849', '-213.9095', '0', '0', '0', '100', '0'),
('56662', '03', '759.9225', '-689.7131', '-212.5623', '0', '0', '0', '100', '0'),
('56662', '04', '753.9745', '-704.1632', '-211.7530', '0', '0', '0', '100', '0'),
('56662', '05', '758.8966', '-684.4725', '-212.3810', '0', '0', '0', '100', '0'),
('56662', '06', '780.8896', '-669.5650', '-211.4591', '0', '0', '0', '100', '0'),
('56662', '07', '791.4582', '-652.9810', '-207.6324', '0', '0', '0', '100', '0'),
('56662', '08', '780.8896', '-669.5650', '-211.4591', '0', '0', '0', '100', '0'),
('56662', '09', '758.8966', '-684.4725', '-212.3810', '0', '0', '0', '100', '0'),
('56662', '10', '753.9745', '-704.1632', '-211.7530', '0', '0', '0', '100', '0'),
('56662', '11', '759.9225', '-689.7131', '-212.5623', '0', '0', '0', '100', '0'),
('56662', '12', '779.0322', '-680.1849', '-213.9095', '0', '0', '0', '100', '0'),
('56662', '13', '800.4368', '-665.5578', '-208.9407', '0', '0', '0', '100', '0'),
('56662', '14', '807.4164', '-656.2690', '-206.1155', '0', '0', '0', '100', '0');

SET @GUID := '56664';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56664', '01', '748.5151', '-725.4263', '-211.9395', '0', '0', '0', '100', '0'),
('56664', '02', '739.7422', '-763.3509', '-218.9724', '0', '0', '0', '100', '0'),
('56664', '03', '737.3899', '-809.9995', '-225.6305', '0', '0', '0', '100', '0'),
('56664', '04', '745.2436', '-850.8501', '-223.6281', '0', '0', '0', '100', '0'),
('56664', '05', '737.3899', '-809.9995', '-225.6305', '0', '0', '0', '100', '0'),
('56664', '06', '739.7422', '-763.3509', '-218.9724', '0', '0', '0', '100', '0'),
('56664', '07', '748.5151', '-725.4263', '-211.9395', '0', '0', '0', '100', '0'),
('56664', '08', '764.8676', '-686.4996', '-212.5972', '0', '0', '0', '100', '0');

SET @GUID := '56665';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56665', '01', '884.0205', '-803.6951', '-226.6926', '0', '0', '0', '100', '0'),
('56665', '02', '865.6118', '-779.7151', '-225.9819', '0', '0', '0', '100', '0'),
('56665', '03', '865.0396', '-765.1099', '-224.7500', '0', '0', '0', '100', '0'),
('56665', '04', '879.3519', '-761.3517', '-224.0491', '0', '0', '0', '100', '0'),
('56665', '05', '895.7159', '-764.4568', '-224.3548', '0', '0', '0', '100', '0'),
('56665', '06', '909.2687', '-788.9470', '-226.9377', '0', '0', '0', '100', '0'),
('56665', '07', '912.3800', '-812.9961', '-227.3731', '0', '0', '0', '100', '0'),
('56665', '08', '917.8469', '-848.5494', '-219.4701', '0', '0', '0', '100', '0'),
('56665', '09', '913.7874', '-875.5369', '-214.2200', '0', '0', '0', '100', '0'),
('56665', '10', '890.5936', '-905.0054', '-222.0683', '0', '0', '0', '100', '0'),
('56665', '11', '860.6026', '-921.1229', '-225.7609', '0', '0', '0', '100', '0'),
('56665', '12', '816.9810', '-920.8954', '-225.8454', '0', '0', '0', '100', '0'),
('56665', '13', '782.6620', '-911.1868', '-222.6471', '0', '0', '0', '100', '0'),
('56665', '14', '816.9766', '-920.8942', '-225.8542', '0', '0', '0', '100', '0'),
('56665', '15', '860.6026', '-921.1229', '-225.7609', '0', '0', '0', '100', '0'),
('56665', '16', '890.5936', '-905.0054', '-222.0683', '0', '0', '0', '100', '0'),
('56665', '17', '913.7874', '-875.5369', '-214.2200', '0', '0', '0', '100', '0'),
('56665', '18', '917.8469', '-848.5494', '-219.4701', '0', '0', '0', '100', '0'),
('56665', '19', '912.3800', '-812.9961', '-227.3731', '0', '0', '0', '100', '0'),
('56665', '20', '909.2687', '-788.9470', '-226.9377', '0', '0', '0', '100', '0'),
('56665', '21', '895.7159', '-764.4568', '-224.3548', '0', '0', '0', '100', '0'),
('56665', '22', '879.3519', '-761.3517', '-224.0491', '0', '0', '0', '100', '0'),
('56665', '23', '865.0396', '-765.1099', '-224.7500', '0', '0', '0', '100', '0'),
('56665', '24', '865.6118', '-779.7151', '-225.9819', '0', '0', '0', '100', '0'),
('56665', '25', '884.0205', '-803.6951', '-226.6926', '0', '0', '0', '100', '0'),
('56665', '26', '889.6862', '-825.1835', '-227.3351', '0', '0', '0', '100', '0');

SET @GUID := '56666';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56666', '01', '708.2625', '-692.8368', '-209.5175', '0', '0', '0', '100', '0'),
('56666', '02', '707.9111', '-711.0708', '-209.5187', '0', '0', '0', '100', '0'),
('56666', '03', '686.1985', '-738.5436', '-209.2948', '0', '0', '0', '100', '0'),
('56666', '04', '681.6021', '-776.7833', '-209.1657', '0', '0', '0', '100', '0'),
('56666', '05', '665.0020', '-813.2372', '-208.7740', '0', '0', '0', '100', '0'),
('56666', '06', '676.7046', '-829.8509', '-208.8353', '0', '0', '0', '100', '0'),
('56666', '07', '679.1953', '-847.3836', '-208.2482', '0', '0', '0', '100', '0'),
('56666', '08', '696.5482', '-855.4606', '-206.0954', '0', '0', '0', '100', '0'),
('56666', '09', '697.0541', '-866.1818', '-204.0854', '0', '0', '0', '100', '0'),
('56666', '10', '710.7119', '-882.6242', '-198.9530', '0', '0', '0', '100', '0'),
('56666', '11', '714.8118', '-907.6405', '-193.7685', '0', '0', '0', '100', '0'),
('56666', '12', '735.3042', '-937.3447', '-188.4066', '0', '0', '0', '100', '0'),
('56666', '13', '714.8118', '-907.6405', '-193.7685', '0', '0', '0', '100', '0'),
('56666', '14', '710.7119', '-882.6242', '-198.9530', '0', '0', '0', '100', '0'),
('56666', '15', '697.0541', '-866.1818', '-204.0854', '0', '0', '0', '100', '0'),
('56666', '16', '679.1953', '-847.3836', '-208.2482', '0', '0', '0', '100', '0'),
('56666', '17', '676.7046', '-829.8509', '-208.8353', '0', '0', '0', '100', '0'),
('56666', '18', '665.0020', '-813.2372', '-208.7740', '0', '0', '0', '100', '0'),
('56666', '19', '681.6021', '-776.7833', '-209.1657', '0', '0', '0', '100', '0'),
('56666', '20', '686.1985', '-738.5436', '-209.2948', '0', '0', '0', '100', '0'),
('56666', '21', '707.9111', '-711.0708', '-209.5187', '0', '0', '0', '100', '0'),
('56666', '22', '708.2624', '-692.8405', '-209.5718', '0', '0', '0', '100', '0'),
('56666', '23', '690.2739', '-662.6287', '-209.6574', '0', '0', '0', '100', '0');

SET @GUID := '56740';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56740', '01', '623.8442', '-1186.210', '-195.8348', '0', '0', '0', '100', '0'),
('56740', '02', '628.4896', '-1171.869', '-194.5435', '0', '0', '0', '100', '0'),
('56740', '03', '628.3709', '-1151.011', '-197.0152', '0', '0', '0', '100', '0'),
('56740', '04', '626.8060', '-1131.724', '-200.8709', '0', '0', '0', '100', '0'),
('56740', '05', '645.6395', '-1106.676', '-196.4797', '0', '0', '0', '100', '0'),
('56740', '06', '667.9337', '-1066.047', '-188.3889', '0', '0', '0', '100', '0'),
('56740', '07', '619.8726', '-1066.640', '-199.7958', '0', '0', '0', '100', '0'),
('56740', '08', '613.3337', '-1099.887', '-198.7582', '0', '0', '0', '100', '0'),
('56740', '09', '591.3667', '-1135.207', '-200.2088', '0', '0', '0', '100', '0'),
('56740', '10', '578.8029', '-1173.733', '-194.7558', '0', '0', '0', '100', '0'),
('56740', '11', '591.5503', '-1192.438', '-195.7943', '0', '0', '0', '100', '0'),
('56740', '12', '608.1950', '-1194.054', '-195.7651', '0', '0', '0', '100', '0');

SET @GUID := '56741';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56741', '01', '736.2715', '-1211.634', '-118.8998', '0', '0', '0', '100', '0'),
('56741', '02', '717.1637', '-1193.438', '-118.9491', '0', '0', '0', '100', '0'),
('56741', '03', '693.4008', '-1186.742', '-120.9137', '0', '0', '0', '100', '0'),
('56741', '04', '666.1591', '-1162.693', '-126.0165', '0', '0', '0', '100', '0'),
('56741', '05', '701.5763', '-1137.426', '-135.6903', '0', '0', '0', '100', '0'),
('56741', '06', '723.3930', '-1106.211', '-143.0938', '0', '0', '0', '100', '0'),
('56741', '07', '757.2313', '-1129.672', '-145.1273', '0', '0', '0', '100', '0'),
('56741', '08', '787.2233', '-1123.192', '-150.5524', '0', '0', '0', '100', '0'),
('56741', '09', '791.8120', '-1152.450', '-150.4214', '0', '0', '0', '100', '0'),
('56741', '10', '809.3260', '-1150.683', '-152.5631', '0', '0', '0', '100', '0'),
('56741', '11', '819.8719', '-1143.500', '-153.6145', '0', '0', '0', '100', '0'),
('56741', '12', '839.0113', '-1128.492', '-156.5452', '0', '0', '0', '100', '0'),
('56741', '13', '855.7172', '-1121.873', '-161.9807', '0', '0', '0', '100', '0'),
('56741', '14', '870.0406', '-1110.407', '-169.6678', '0', '0', '0', '100', '0'),
('56741', '15', '883.1496', '-1090.733', '-176.0342', '0', '0', '0', '100', '0'),
('56741', '16', '891.1622', '-1067.062', '-182.6621', '0', '0', '0', '100', '0'),
('56741', '17', '891.3988', '-1050.081', '-187.1399', '0', '0', '0', '100', '0'),
('56741', '18', '875.8871', '-1014.841', '-194.9043', '0', '0', '0', '100', '0'),
('56741', '19', '864.6398', '-983.1211', '-199.6699', '0', '0', '0', '100', '0'),
('56741', '20', '875.8871', '-1014.841', '-194.9043', '0', '0', '0', '100', '0'),
('56741', '21', '891.3988', '-1050.081', '-187.1399', '0', '0', '0', '100', '0'),
('56741', '22', '891.1622', '-1067.062', '-182.6621', '0', '0', '0', '100', '0'),
('56741', '23', '883.1496', '-1090.733', '-176.0342', '0', '0', '0', '100', '0'),
('56741', '24', '870.0406', '-1110.407', '-169.6678', '0', '0', '0', '100', '0'),
('56741', '25', '855.7172', '-1121.873', '-161.9807', '0', '0', '0', '100', '0'),
('56741', '26', '839.0113', '-1128.492', '-156.5452', '0', '0', '0', '100', '0'),
('56741', '27', '819.8719', '-1143.500', '-153.6145', '0', '0', '0', '100', '0'),
('56741', '28', '809.3260', '-1150.683', '-152.5631', '0', '0', '0', '100', '0'),
('56741', '29', '791.8120', '-1152.450', '-150.4214', '0', '0', '0', '100', '0'),
('56741', '30', '787.2233', '-1123.192', '-150.5524', '0', '0', '0', '100', '0'),
('56741', '31', '757.2313', '-1129.672', '-145.1273', '0', '0', '0', '100', '0'),
('56741', '32', '723.3930', '-1106.211', '-143.0938', '0', '0', '0', '100', '0'),
('56741', '33', '701.5763', '-1137.426', '-135.6903', '0', '0', '0', '100', '0'),
('56741', '34', '666.1591', '-1162.693', '-126.0165', '0', '0', '0', '100', '0'),
('56741', '35', '693.4008', '-1186.742', '-120.9137', '0', '0', '0', '100', '0'),
('56741', '36', '717.1637', '-1193.438', '-118.9491', '0', '0', '0', '100', '0'),
('56741', '37', '736.2715', '-1211.634', '-118.8998', '0', '0', '0', '100', '0'),
('56741', '38', '759.3818', '-1228.879', '-119.2757', '0', '0', '0', '100', '0');

SET @GUID := '56667';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56667', '01', '1142.684', '-647.4110', '-131.9233', '0', '0', '0', '100', '0'),
('56667', '02', '1142.684', '-647.4110', '-131.9233', '150000', '0', '0', '100', '0'),
('56667', '03', '1144.050', '-662.6844', '-131.4626', '0', '0', '0', '100', '0'),
('56667', '04', '1160.286', '-696.8795', '-132.4863', '0', '0', '0', '100', '0'),
('56667', '05', '1129.031', '-721.0490', '-139.5804', '0', '0', '0', '100', '0'),
('56667', '06', '1118.512', '-712.1383', '-144.2585', '0', '0', '0', '100', '0'),
('56667', '07', '1104.687', '-722.1303', '-146.9832', '0', '0', '0', '100', '0'),
('56667', '08', '1090.824', '-731.3634', '-149.9868', '0', '0', '0', '100', '0'),
('56667', '09', '1070.791', '-717.5623', '-153.4831', '0', '0', '0', '100', '0'),
('56667', '10', '1080.754', '-681.5721', '-159.8726', '150000', '0', '0', '100', '0'),
('56667', '11', '1080.101', '-708.4520', '-154.2289', '0', '0', '0', '100', '0'),
('56667', '12', '1084.528', '-731.8951', '-151.0118', '0', '0', '0', '100', '0'),
('56667', '13', '1093.696', '-748.0836', '-149.2619', '0', '0', '0', '100', '0'),
('56667', '14', '1110.641', '-738.1426', '-146.5005', '0', '0', '0', '100', '0'),
('56667', '15', '1115.694', '-716.5850', '-144.6347', '0', '0', '0', '100', '0'),
('56667', '16', '1148.220', '-713.5815', '-132.9880', '0', '0', '0', '100', '0'),
('56667', '17', '1161.699', '-694.4932', '-132.2003', '0', '0', '0', '100', '0'),
('56667', '18', '1149.113', '-669.7729', '-130.3396', '0', '0', '0', '100', '0');

SET @GUID := '56668';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56668', '01', '716.2954', '-563.1713', '-215.2122', '0', '0', '0', '100', '0'),
('56668', '02', '730.7200', '-541.2038', '-216.5207', '0', '0', '0', '100', '0'),
('56668', '03', '751.7352', '-537.1676', '-215.0087', '0', '0', '0', '100', '0'),
('56668', '04', '782.8221', '-568.6121', '-213.2396', '0', '0', '0', '100', '0'),
('56668', '05', '826.4692', '-557.4173', '-206.1204', '0', '0', '0', '100', '0'),
('56668', '06', '862.7628', '-559.3347', '-203.8248', '0', '0', '0', '100', '0'),
('56668', '07', '897.3094', '-575.2031', '-203.7624', '0', '0', '0', '100', '0'),
('56668', '08', '928.2740', '-599.9254', '-203.4944', '0', '0', '0', '100', '0'),
('56668', '09', '976.9997', '-588.0521', '-203.5660', '0', '0', '0', '100', '0'),
('56668', '10', '1013.348', '-611.7108', '-198.8222', '0', '0', '0', '100', '0'),
('56668', '11', '1031.784', '-628.6943', '-189.8679', '0', '0', '0', '100', '0'),
('56668', '12', '1054.582', '-638.4258', '-174.0191', '0', '0', '0', '100', '0'),
('56668', '13', '1082.930', '-658.8265', '-159.5947', '0', '0', '0', '100', '0'),
('56668', '14', '1102.016', '-688.0265', '-153.0321', '0', '0', '0', '100', '0'),
('56668', '15', '1095.611', '-709.9710', '-151.2729', '0', '0', '0', '100', '0'),
('56668', '16', '1102.016', '-688.0265', '-153.0321', '0', '0', '0', '100', '0'),
('56668', '17', '1082.930', '-658.8265', '-159.5947', '0', '0', '0', '100', '0'),
('56668', '18', '1054.582', '-638.4258', '-174.0191', '0', '0', '0', '100', '0'),
('56668', '19', '1031.784', '-628.6943', '-189.8679', '0', '0', '0', '100', '0'),
('56668', '20', '1013.348', '-611.7108', '-198.8222', '0', '0', '0', '100', '0'),
('56668', '21', '976.9997', '-588.0521', '-203.5660', '0', '0', '0', '100', '0'),
('56668', '22', '928.2740', '-599.9254', '-203.4944', '0', '0', '0', '100', '0'),
('56668', '23', '897.3094', '-575.2031', '-203.7624', '0', '0', '0', '100', '0'),
('56668', '24', '862.7628', '-559.3347', '-203.8248', '0', '0', '0', '100', '0'),
('56668', '25', '826.4692', '-557.4173', '-206.1204', '0', '0', '0', '100', '0'),
('56668', '26', '782.8221', '-568.6121', '-213.2396', '0', '0', '0', '100', '0'),
('56668', '27', '751.7352', '-537.1676', '-215.0087', '0', '0', '0', '100', '0'),
('56668', '28', '730.7200', '-541.2038', '-216.5207', '0', '0', '0', '100', '0'),
('56668', '29', '716.2954', '-563.1713', '-215.2122', '0', '0', '0', '100', '0'),
('56668', '30', '710.9113', '-588.9549', '-211.3497', '0', '0', '0', '100', '0');

SET @GUID := '56669';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56669', '01', '1051.314', '-799.6896', '-151.9713', '0', '0', '0', '100', '0'),
('56669', '02', '1039.667', '-791.0968', '-151.0096', '0', '0', '0', '100', '0'),
('56669', '03', '1026.315', '-767.8003', '-156.6493', '0', '0', '0', '100', '0'),
('56669', '04', '1038.774', '-761.6977', '-152.6580', '0', '0', '0', '100', '0'),
('56669', '05', '1064.627', '-748.9409', '-151.7516', '0', '0', '0', '100', '0'),
('56669', '06', '1038.774', '-761.6977', '-152.6580', '0', '0', '0', '100', '0'),
('56669', '07', '1026.315', '-767.8003', '-156.6493', '0', '0', '0', '100', '0'),
('56669', '08', '1039.641', '-791.0518', '-150.9892', '0', '0', '0', '100', '0'),
('56669', '09', '1026.315', '-767.8003', '-156.6493', '0', '0', '0', '100', '0'),
('56669', '10', '1039.641', '-791.0518', '-150.9892', '0', '0', '0', '100', '0'),
('56669', '11', '1051.314', '-799.6896', '-151.9713', '0', '0', '0', '100', '0'),
('56669', '12', '1040.764', '-815.1115', '-152.1656', '0', '0', '0', '100', '0');

SET @GUID := '56670';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56670', '01', '831.3860', '-627.8932', '-203.1487', '0', '0', '0', '100', '0'),
('56670', '02', '856.4564', '-617.9056', '-202.1571', '0', '0', '0', '100', '0'),
('56670', '03', '899.6118', '-613.5433', '-202.2377', '0', '0', '0', '100', '0'),
('56670', '04', '936.2535', '-612.5002', '-203.6217', '0', '0', '0', '100', '0'),
('56670', '05', '975.1815', '-641.0467', '-201.5775', '0', '0', '0', '100', '0'),
('56670', '06', '1002.311', '-661.9902', '-194.1922', '0', '0', '0', '100', '0'),
('56670', '07', '1024.067', '-684.3118', '-173.4296', '0', '0', '0', '100', '0'),
('56670', '08', '1042.016', '-695.8206', '-163.7581', '0', '0', '0', '100', '0'),
('56670', '09', '1058.163', '-706.0782', '-156.6107', '0', '0', '0', '100', '0'),
('56670', '10', '1068.566', '-742.8318', '-151.7328', '0', '0', '0', '100', '0'),
('56670', '11', '1117.097', '-744.4790', '-145.6289', '0', '0', '0', '100', '0'),
('56670', '12', '1149.458', '-726.4506', '-133.8044', '0', '0', '0', '100', '0'),
('56670', '13', '1175.513', '-702.1757', '-130.9873', '0', '0', '0', '100', '0'),
('56670', '14', '1200.504', '-670.9343', '-128.5453', '0', '0', '0', '100', '0'),
('56670', '15', '1202.953', '-639.3985', '-126.1688', '0', '0', '0', '100', '0'),
('56670', '16', '1188.303', '-614.0296', '-121.8816', '0', '0', '0', '100', '0'),
('56670', '17', '1164.196', '-595.4036', '-115.7764', '0', '0', '0', '100', '0'),
('56670', '18', '1155.213', '-574.8707', '-113.3766', '0', '0', '0', '100', '0'),
('56670', '19', '1164.196', '-595.4036', '-115.7764', '0', '0', '0', '100', '0'),
('56670', '20', '1188.303', '-614.0296', '-121.8816', '0', '0', '0', '100', '0'),
('56670', '21', '1202.953', '-639.3985', '-126.1688', '0', '0', '0', '100', '0'),
('56670', '22', '1200.504', '-670.9343', '-128.5453', '0', '0', '0', '100', '0'),
('56670', '23', '1175.589', '-702.0806', '-130.9749', '0', '0', '0', '100', '0'),
('56670', '24', '1149.458', '-726.4506', '-133.8044', '0', '0', '0', '100', '0'),
('56670', '25', '1117.097', '-744.4790', '-145.6289', '0', '0', '0', '100', '0'),
('56670', '26', '1068.566', '-742.8318', '-151.7328', '0', '0', '0', '100', '0'),
('56670', '27', '1058.163', '-706.0782', '-156.6107', '0', '0', '0', '100', '0'),
('56670', '28', '1042.016', '-695.8206', '-163.7581', '0', '0', '0', '100', '0'),
('56670', '29', '1024.226', '-684.4753', '-173.2943', '0', '0', '0', '100', '0'),
('56670', '30', '1002.311', '-661.9902', '-194.1922', '0', '0', '0', '100', '0'),
('56670', '31', '975.1815', '-641.0467', '-201.5775', '0', '0', '0', '100', '0'),
('56670', '32', '936.2535', '-612.5002', '-203.6217', '0', '0', '0', '100', '0'),
('56670', '33', '899.6118', '-613.5433', '-202.2377', '0', '0', '0', '100', '0'),
('56670', '34', '856.4564', '-617.9056', '-202.1571', '0', '0', '0', '100', '0'),
('56670', '35', '831.3860', '-627.8932', '-203.1487', '0', '0', '0', '100', '0'),
('56670', '36', '816.5816', '-641.0675', '-203.8891', '0', '0', '0', '100', '0');

SET @GUID := '56671';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56671', '01', '695.7981', '-526.2382', '-214.3069', '0', '0', '0', '100', '0'),
('56671', '02', '706.8069', '-515.2225', '-215.4603', '0', '0', '0', '100', '0'),
('56671', '03', '708.7521', '-494.4869', '-213.9441', '0', '0', '0', '100', '0'),
('56671', '04', '706.4074', '-474.3789', '-211.1673', '0', '0', '0', '100', '0'),
('56671', '05', '708.7521', '-494.4869', '-213.9441', '0', '0', '0', '100', '0'),
('56671', '06', '706.8069', '-515.2225', '-215.4603', '0', '0', '0', '100', '0'),
('56671', '07', '695.7981', '-526.2382', '-214.3069', '0', '0', '0', '100', '0'),
('56671', '08', '671.7322', '-532.8630', '-210.5322', '0', '0', '0', '100', '0');

SET @GUID := '56672';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56672', '01', '694.3823', '-643.1285', '-209.7859', '0', '0', '0', '100', '0'),
('56672', '02', '691.9941', '-667.7454', '-209.6549', '0', '0', '0', '100', '0'),
('56672', '03', '712.6238', '-699.4688', '-209.7263', '0', '0', '0', '100', '0'),
('56672', '04', '696.8894', '-727.3798', '-209.4279', '0', '0', '0', '100', '0'),
('56672', '05', '672.7046', '-770.8894', '-209.0702', '0', '0', '0', '100', '0'),
('56672', '06', '696.8894', '-727.3798', '-209.4279', '0', '0', '0', '100', '0'),
('56672', '07', '712.6238', '-699.4688', '-209.7263', '0', '0', '0', '100', '0'),
('56672', '08', '691.9941', '-667.7454', '-209.6549', '0', '0', '0', '100', '0'),
('56672', '09', '694.3823', '-643.1285', '-209.7859', '0', '0', '0', '100', '0'),
('56672', '10', '694.3823', '-643.1285', '-209.7859', '0', '0', '0', '100', '0'),
('56672', '11', '706.5988', '-608.7560', '-209.7862', '0', '0', '0', '100', '0');

SET @GUID := '56673';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56673', '01', '723.8314', '-518.3099', '-217.6104', '0', '0', '0', '100', '0'),
('56673', '02', '706.7125', '-535.8472', '-216.7189', '0', '0', '0', '100', '0'),
('56673', '03', '685.7861', '-543.6451', '-211.2004', '0', '0', '0', '100', '0'),
('56673', '04', '667.6307', '-538.1242', '-209.9916', '0', '0', '0', '100', '0'),
('56673', '05', '685.7861', '-543.6451', '-211.2004', '0', '0', '0', '100', '0'),
('56673', '06', '706.7125', '-535.8472', '-216.7189', '0', '0', '0', '100', '0'),
('56673', '07', '723.8314', '-518.3099', '-217.6104', '0', '0', '0', '100', '0'),
('56673', '08', '728.2719', '-487.4919', '-212.9500', '0', '0', '0', '100', '0');

SET @GUID := '56674';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56674', '01', '693.7902', '-895.4052', '-199.3317', '0', '0', '0', '100', '0'),
('56674', '02', '676.3041', '-859.0721', '-207.3966', '0', '0', '0', '100', '0'),
('56674', '03', '660.5331', '-846.3304', '-208.5820', '0', '0', '0', '100', '0'),
('56674', '04', '676.3041', '-859.0721', '-207.3966', '0', '0', '0', '100', '0'),
('56674', '05', '693.7902', '-895.4052', '-199.3317', '0', '0', '0', '100', '0'),
('56674', '06', '709.7253', '-933.0809', '-191.2163', '0', '0', '0', '100', '0');

SET @GUID := '56675';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56675', '01', '687.7936', '-1186.922', '-122.3323', '0', '0', '0', '100', '0'),
('56675', '02', '678.9120', '-1171.258', '-124.9925', '0', '0', '0', '100', '0'),
('56675', '03', '681.3560', '-1157.213', '-129.4221', '0', '0', '0', '100', '0'),
('56675', '04', '688.8096', '-1145.377', '-132.6487', '0', '0', '0', '100', '0'),
('56675', '05', '705.0751', '-1129.982', '-137.4043', '0', '0', '0', '100', '0'),
('56675', '06', '726.2703', '-1123.733', '-140.4308', '0', '0', '0', '100', '0'),
('56675', '07', '751.8342', '-1124.252', '-144.3583', '0', '0', '0', '100', '0'),
('56675', '08', '786.1231', '-1142.027', '-149.5751', '0', '0', '0', '100', '0'),
('56675', '09', '797.6674', '-1151.590', '-151.2095', '0', '0', '0', '100', '0'),
('56675', '10', '809.0994', '-1147.870', '-152.4792', '0', '0', '0', '100', '0'),
('56675', '11', '839.5970', '-1126.927', '-156.8890', '0', '0', '0', '100', '0'),
('56675', '12', '852.0717', '-1110.005', '-164.8026', '0', '0', '0', '100', '0'),
('56675', '13', '866.1934', '-1092.763', '-172.8487', '0', '0', '0', '100', '0'),
('56675', '14', '872.7313', '-1072.910', '-180.5435', '0', '0', '0', '100', '0'),
('56675', '15', '867.8922', '-1050.318', '-187.0417', '0', '0', '0', '100', '0'),
('56675', '16', '862.4832', '-1025.388', '-193.7729', '0', '0', '0', '100', '0'),
('56675', '17', '837.9779', '-1005.705', '-203.4326', '0', '0', '0', '100', '0'),
('56675', '18', '811.0497', '-995.4718', '-207.7699', '0', '0', '0', '100', '0'),
('56675', '19', '837.9779', '-1005.705', '-203.4326', '0', '0', '0', '100', '0'),
('56675', '20', '862.4832', '-1025.388', '-193.7729', '0', '0', '0', '100', '0'),
('56675', '21', '867.8922', '-1050.318', '-187.0417', '0', '0', '0', '100', '0'),
('56675', '22', '872.7313', '-1072.910', '-180.5435', '0', '0', '0', '100', '0'),
('56675', '23', '866.1934', '-1092.763', '-172.8487', '0', '0', '0', '100', '0'),
('56675', '24', '852.0717', '-1110.005', '-164.8026', '0', '0', '0', '100', '0'),
('56675', '25', '839.5970', '-1126.927', '-156.8890', '0', '0', '0', '100', '0'),
('56675', '26', '809.0994', '-1147.870', '-152.4792', '0', '0', '0', '100', '0'),
('56675', '27', '797.6674', '-1151.590', '-151.2095', '0', '0', '0', '100', '0'),
('56675', '28', '786.1231', '-1142.027', '-149.5751', '0', '0', '0', '100', '0'),
('56675', '29', '751.8342', '-1124.252', '-144.3583', '0', '0', '0', '100', '0'),
('56675', '30', '726.2703', '-1123.733', '-140.4308', '0', '0', '0', '100', '0'),
('56675', '31', '705.0751', '-1129.982', '-137.4043', '0', '0', '0', '100', '0'),
('56675', '32', '688.8096', '-1145.377', '-132.6487', '0', '0', '0', '100', '0'),
('56675', '33', '681.3560', '-1157.213', '-129.4221', '0', '0', '0', '100', '0'),
('56675', '34', '678.9120', '-1171.258', '-124.9925', '0', '0', '0', '100', '0'),
('56675', '35', '687.7820', '-1186.916', '-122.3317', '0', '0', '0', '100', '0'),
('56675', '36', '702.4774', '-1195.069', '-120.2255', '0', '0', '0', '100', '0');

SET @GUID := '56676';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56676', '01', '568.2750', '-805.6725', '-206.7511', '0', '0', '0', '100', '0'),
('56676', '02', '571.1739', '-823.5732', '-206.9356', '0', '0', '0', '100', '0'),
('56676', '03', '580.7532', '-839.1719', '-206.0227', '0', '0', '0', '100', '0'),
('56676', '04', '606.3914', '-839.9142', '-207.4040', '0', '0', '0', '100', '0'),
('56676', '05', '640.3456', '-838.7157', '-208.4006', '0', '0', '0', '100', '0'),
('56676', '06', '606.3914', '-839.9142', '-207.4040', '0', '0', '0', '100', '0'),
('56676', '07', '580.7532', '-839.1719', '-206.0227', '0', '0', '0', '100', '0'),
('56676', '08', '571.1739', '-823.5732', '-206.9356', '0', '0', '0', '100', '0'),
('56676', '09', '568.2750', '-805.6725', '-206.7511', '0', '0', '0', '100', '0'),
('56676', '10', '574.7719', '-784.4373', '-207.1243', '0', '0', '0', '100', '0');

SET @GUID := '56742';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56742', '01', '820.1378', '-991.0960', '-207.3450', '0', '0', '0', '100', '0'),
('56742', '02', '837.5117', '-1001.866', '-203.9284', '0', '0', '0', '100', '0'),
('56742', '03', '875.2714', '-1009.170', '-195.7951', '0', '0', '0', '100', '0'),
('56742', '04', '884.1406', '-1024.130', '-192.9333', '0', '0', '0', '100', '0'),
('56742', '05', '875.2714', '-1009.170', '-195.7951', '0', '0', '0', '100', '0'),
('56742', '06', '837.5117', '-1001.866', '-203.9284', '0', '0', '0', '100', '0'),
('56742', '07', '820.1378', '-991.0960', '-207.1345', '0', '0', '0', '100', '0'),
('56742', '08', '815.0589', '-979.8468', '-208.6176', '0', '0', '0', '100', '0');

SET @GUID := '56743';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56743', '01', '619.3152', '-1131.169', '-201.6246', '0', '0', '0', '100', '0'),
('56743', '02', '635.5156', '-1094.704', '-196.7484', '0', '0', '0', '100', '0'),
('56743', '03', '637.1269', '-1060.913', '-199.2417', '0', '0', '0', '100', '0'),
('56743', '04', '635.5156', '-1094.704', '-196.7484', '0', '0', '0', '100', '0'),
('56743', '05', '619.3152', '-1131.169', '-201.6246', '0', '0', '0', '100', '0'),
('56743', '06', '610.0372', '-1155.730', '-198.8285', '0', '0', '0', '100', '0');

SET @GUID := '56744';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56744', '01', '713.1385', '-1077.042', '-178.4627', '0', '0', '0', '100', '0'),
('56744', '02', '756.4903', '-1086.385', '-165.0273', '0', '0', '0', '100', '0'),
('56744', '03', '791.6740', '-1098.377', '-157.4893', '0', '0', '0', '100', '0'),
('56744', '04', '811.4623', '-1112.419', '-155.1721', '0', '0', '0', '100', '0'),
('56744', '05', '820.8864', '-1133.536', '-153.9561', '0', '0', '0', '100', '0'),
('56744', '06', '807.4134', '-1143.589', '-152.2109', '0', '0', '0', '100', '0'),
('56744', '07', '788.3813', '-1136.843', '-150.0572', '0', '0', '0', '100', '0'),
('56744', '08', '774.8284', '-1122.117', '-148.7992', '0', '0', '0', '100', '0'),
('56744', '09', '753.0598', '-1112.579', '-145.9724', '0', '0', '0', '100', '0'),
('56744', '10', '723.3937', '-1111.516', '-142.1575', '0', '0', '0', '100', '0'),
('56744', '11', '692.8207', '-1125.591', '-137.0500', '0', '0', '0', '100', '0'),
('56744', '12', '670.8020', '-1153.978', '-128.2815', '0', '0', '0', '100', '0'),
('56744', '13', '669.0090', '-1180.974', '-123.0805', '0', '0', '0', '100', '0'),
('56744', '14', '670.8020', '-1153.978', '-128.2815', '0', '0', '0', '100', '0'),
('56744', '15', '692.8207', '-1125.591', '-137.0500', '0', '0', '0', '100', '0'),
('56744', '16', '723.3937', '-1111.516', '-142.1575', '0', '0', '0', '100', '0'),
('56744', '17', '753.0598', '-1112.579', '-145.9724', '0', '0', '0', '100', '0'),
('56744', '18', '774.8284', '-1122.117', '-148.7992', '0', '0', '0', '100', '0'),
('56744', '19', '788.3813', '-1136.843', '-150.0572', '0', '0', '0', '100', '0'),
('56744', '20', '807.4134', '-1143.589', '-152.2109', '0', '0', '0', '100', '0'),
('56744', '21', '820.8864', '-1133.536', '-153.9561', '0', '0', '0', '100', '0'),
('56744', '22', '811.4623', '-1112.419', '-155.1721', '0', '0', '0', '100', '0'),
('56744', '23', '791.6740', '-1098.377', '-157.4893', '0', '0', '0', '100', '0'),
('56744', '24', '756.4903', '-1086.385', '-165.0273', '0', '0', '0', '100', '0'),
('56744', '25', '713.1385', '-1077.042', '-178.4627', '0', '0', '0', '100', '0'),
('56744', '26', '666.2255', '-1071.984', '-188.5744', '0', '0', '0', '100', '0');

SET @GUID := '56745';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56745', '01', '733.2838', '-1027.083', '-177.5541', '0', '0', '0', '100', '0'),
('56745', '02', '695.6022', '-1035.410', '-182.9091', '0', '0', '0', '100', '0'),
('56745', '03', '652.9347', '-1047.064', '-195.1933', '0', '0', '0', '100', '0'),
('56745', '04', '695.6022', '-1035.410', '-182.9091', '0', '0', '0', '100', '0'),
('56745', '05', '733.2838', '-1027.083', '-177.5541', '0', '0', '0', '100', '0'),
('56745', '06', '746.1315', '-1006.086', '-177.4375', '0', '0', '0', '100', '0');

SET @GUID := '56746';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
('56746', '01', '819.1058', '-631.4754', '-202.4386', '0', '0', '0', '100', '0'),
('56746', '02', '842.2988', '-620.2899', '-203.6502', '0', '0', '0', '100', '0'),
('56746', '03', '863.2007', '-606.6663', '-201.9657', '0', '0', '0', '100', '0'),
('56746', '04', '880.7169', '-589.9871', '-203.5187', '0', '0', '0', '100', '0'),
('56746', '05', '891.5865', '-563.1656', '-204.1768', '0', '0', '0', '100', '0'),
('56746', '06', '880.7169', '-589.9871', '-203.5187', '0', '0', '0', '100', '0'),
('56746', '07', '863.2007', '-606.6663', '-201.9657', '0', '0', '0', '100', '0'),
('56746', '08', '842.2988', '-620.2899', '-203.6502', '0', '0', '0', '100', '0'),
('56746', '09', '819.1058', '-631.4754', '-202.4386', '0', '0', '0', '100', '0'),
('56746', '10', '801.1528', '-637.2293', '-203.2919', '0', '0', '0', '100', '0');

-- -----------------------------------------------------------------------------------------------------------------------------

-- Lava Annihilator do not patrol through the Molten Core, only Lava Surgers do
UPDATE `creature` SET `MovementType`='1' WHERE `guid`='56789';
DELETE FROM `waypoint_data` WHERE `id`='56789';

-- the following creatures in Molten Core do fire damage with their melee attacks, not physical
-- (Ancient Core Hounds, Firelords, Lava Spawns, Firewalkers, Flameguards, Sons of Flame and Baron Geddon)
UPDATE `creature_template` SET `DmgSchool`='2' WHERE `Entry` IN ('11673', '11666', '11667', '11668', '12056', '12143', '12265');

-- the following creatures in Molten Core do not drop any loot, nor money when killed. You cannot skin them either.
-- (Flame Imp, Core Hound, Lava Spawn, Firesworn, Core Rager, Son of Flame)
UPDATE `creature_template` SET `lootId`='0', `skinloot`='0', `mingold`='0', `maxgold`='0' WHERE `entry` IN ('11669', '11671', '12265', '12099', '11672', '12143');
DELETE FROM `creature_loot_template` WHERE `entry` IN ('11669', '11671', '12265', '12099', '11672', '12143');

-- a go was missing as a template and object
DELETE FROM `gameobject_template` WHERE `entry`='178188';
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `castBarCaption`, `faction`, `flags`, `size`, `data0`, `data1`, `data2`, `data3`, `data4`, `data5`, `data6`, `data7`, `data8`, `data9`, `data10`, `data11`, `data12`, `data13`, `data14`, `data15`, `data16`, `data17`, `data18`, `data19`, `data20`, `data21`, `data22`, `data23`, `ScriptName`) VALUES
('178188', '6', '410', 'Molten Core Circle BARON', '', '114', '0', '1', '0', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '');

DELETE FROM `gameobject` WHERE `guid`='113269';
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`) VALUES
('113269', '178188', '409', '1', '748.839', '-985.16', '-178.283', '3.14159', '0', '0', '-1', '0', '604800', '255', '1');

UPDATE `gameobject_template` SET `flags`='16', `size`='1.03788' WHERE `entry`='176951'; -- 0 1
UPDATE `gameobject_template` SET `flags`='16', `size`='1.03788' WHERE `entry`='176952';
UPDATE `gameobject_template` SET `flags`='16', `size`='1.03788' WHERE `entry`='176953';
UPDATE `gameobject_template` SET `flags`='16', `size`='1.03788' WHERE `entry`='176954';
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2480/sand-sharks-patrols
--

SET @GUIDSTART := '101621';

-- -------------------------------------

SET @ENTRY := '5435'; -- Sand Shark
-- Sand Shark 5435 [-0|+12]
UPDATE `creature_template` SET `minhealth`='800',`maxhealth`='820',`armor`='218' WHERE `entry` IN ('5435');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('5435');
INSERT INTO `creature_ai_scripts` VALUES
('543501','5435','1','0','100','0','0','0','0','0','11','12787','0','32','0','0','0','0','0','0','0','0','Sand Shark - Cast Thrash OOC');
DELETE FROM `creature` WHERE `id`=@ENTRY;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES
(@GUIDSTART + '0',  @ENTRY, '0', '1', '0', '0', '3221.8960', '1710.4690', '-49.23661', '0.715585', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '1',  @ENTRY, '0', '1', '0', '0', '3234.7780', '1040.1620', '-49.03365', '2.083385', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '2',  @ENTRY, '0', '1', '0', '0', '3221.2930', '530.99500', '-49.03215', '6.165682', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '3',  @ENTRY, '1', '1', '0', '0', '1550.5950', '-5378.973', '-32.53504', '3.280727', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '4',  @ENTRY, '1', '1', '0', '0', '1283.9980', '-5408.571', '-50.30394', '3.492435', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '5',  @ENTRY, '1', '1', '0', '0', '912.37060', '-5415.917', '-55.11948', '0.000000', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '6',  @ENTRY, '1', '1', '0', '0', '493.32640', '-5371.269', '-49.88814', '0.000000', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '7',  @ENTRY, '1', '1', '0', '0', '-326.5838', '-5558.277', '-32.57368', '3.883571', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '8',  @ENTRY, '1', '1', '0', '0', '-576.1233', '-5817.376', '-32.54733', '3.157282', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '9',  @ENTRY, '1', '1', '0', '0', '-1385.017', '-5779.737', '-18.00786', '3.348139', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '10', @ENTRY, '1', '1', '0', '0', '-1753.698', '-5591.549', '-33.64932', '3.028575', '300', '0', '0', '0', '0', '0', '2'),
(@GUIDSTART + '11', @ENTRY, '1', '1', '0', '0', '-1115.526', '-4306.334', '-7.687678', '3.674317', '300', '0', '0', '0', '0', '0', '2');

-- --------------------------------------------------------------------------------------------------------------------------------------------------

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '0';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '0',@GUIDSTART + '0',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '0';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3195.662', '1723.264', '-48.04173', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3172.181', '1728.667', '-46.73510', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3159.840', '1742.105', '-47.11641', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3150.543', '1759.820', '-48.98943', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3145.209', '1779.996', '-48.55008', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3150.675', '1795.498', '-43.96499', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3159.018', '1808.918', '-46.86113', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3147.042', '1829.820', '-48.91264', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3124.375', '1836.323', '-49.30346', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3110.177', '1853.608', '-49.30346', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3098.962', '1879.044', '-49.19866', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3099.791', '1899.643', '-45.14495', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3093.299', '1918.567', '-48.78092', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3074.238', '1939.806', '-49.20982', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3047.839', '1955.769', '-49.31664', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3028.469', '1970.392', '-49.24512', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3019.160', '1982.827', '-48.99512', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2988.323', '1998.347', '-49.14025', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2980.851', '2004.864', '-48.03909', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2954.493', '2018.016', '-47.80416', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2925.328', '2045.097', '-49.28268', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2893.023', '2053.511', '-49.19867', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2865.849', '2054.294', '-48.97533', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2843.767', '2055.249', '-49.08995', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2822.482', '2054.119', '-48.85473', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2788.695', '2062.917', '-48.87340', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2765.504', '2066.172', '-48.06932', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2788.695', '2062.917', '-48.87340', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2822.482', '2054.119', '-48.85473', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2843.767', '2055.249', '-49.08995', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2865.849', '2054.294', '-48.97533', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2893.023', '2053.511', '-49.19867', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2925.328', '2045.097', '-49.28268', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2954.493', '2018.016', '-47.80416', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2980.851', '2004.864', '-48.03909', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '2988.323', '1998.347', '-49.14025', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3019.160', '1982.827', '-48.99512', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3028.469', '1970.392', '-49.24512', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3047.839', '1955.769', '-49.31664', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3074.238', '1939.806', '-49.20982', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3093.299', '1918.567', '-48.78092', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3099.791', '1899.643', '-45.14495', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3098.962', '1879.044', '-49.19866', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3110.177', '1853.608', '-49.30346', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3124.375', '1836.323', '-49.30346', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3147.042', '1829.820', '-48.91264', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3159.018', '1808.918', '-46.86113', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3150.675', '1795.498', '-43.96499', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3145.209', '1779.996', '-48.55008', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3150.505', '1759.881', '-48.99666', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3159.840', '1742.105', '-47.11641', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3172.181', '1728.667', '-46.73510', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3195.662', '1723.264', '-48.04173', '0', '0', '0', '100', '0'),
(@GUIDSTART + '0', (@POINT := @POINT + '1'), '3222.932', '1722.388', '-49.26390', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '1';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '1',@GUIDSTART + '1',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '1';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3219.865', '1066.655', '-48.89483', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3207.929', '1090.381', '-47.27658', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3194.551', '1111.675', '-46.84540', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3181.076', '1131.854', '-44.69330', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3178.316', '1156.420', '-45.47855', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3176.881', '1185.595', '-45.43680', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3180.236', '1206.306', '-43.94244', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3190.403', '1227.345', '-48.06219', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3193.387', '1253.546', '-49.51052', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3191.814', '1284.168', '-48.92054', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3213.592', '1302.704', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3226.420', '1327.890', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3227.663', '1352.519', '-49.28304', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3220.748', '1378.083', '-49.21460', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3223.328', '1416.279', '-49.18565', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3237.026', '1444.512', '-49.23547', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3225.315', '1473.262', '-49.20024', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3215.697', '1516.206', '-49.28796', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3199.542', '1542.934', '-49.26866', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3186.097', '1575.288', '-49.23889', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3189.738', '1608.755', '-49.30112', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3207.190', '1630.425', '-49.30617', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3223.051', '1654.719', '-49.30940', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3245.558', '1679.743', '-49.38989', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3242.984', '1723.863', '-49.34183', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3245.558', '1679.743', '-49.38989', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3223.051', '1654.719', '-49.30940', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3207.190', '1630.425', '-49.30617', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3189.738', '1608.755', '-49.30112', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3186.097', '1575.288', '-49.23889', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3199.542', '1542.934', '-49.26866', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3215.697', '1516.206', '-49.28796', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3225.315', '1473.262', '-49.20024', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3237.026', '1444.512', '-49.23547', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3223.328', '1416.279', '-49.18565', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3220.748', '1378.083', '-49.21460', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3227.663', '1352.519', '-49.28304', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3226.420', '1327.890', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3213.592', '1302.704', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3191.814', '1284.168', '-48.92054', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3193.387', '1253.546', '-49.51052', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3190.403', '1227.345', '-48.06219', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3180.236', '1206.306', '-43.94244', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3176.881', '1185.595', '-45.43680', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3178.316', '1156.420', '-45.47855', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3181.076', '1131.854', '-44.69330', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3194.551', '1111.675', '-46.84540', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3207.856', '1090.509', '-47.15768', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3219.865', '1066.655', '-48.89483', '0', '0', '0', '100', '0'),
(@GUIDSTART + '1', (@POINT := @POINT + '1'), '3229.621', '1042.286', '-48.93804', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '2';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '2',@GUIDSTART + '2',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '2';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3237.635', '529.06600', '-49.16099', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3245.977', '509.61450', '-49.20725', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3244.237', '480.18940', '-48.52467', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3236.807', '451.48190', '-47.32991', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3229.509', '421.77820', '-46.67115', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3232.343', '398.54900', '-48.87648', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3232.087', '378.38370', '-47.22718', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3236.055', '354.16190', '-47.16812', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3225.398', '330.03550', '-46.41989', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3209.576', '308.72660', '-45.18295', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3194.012', '282.98680', '-44.12692', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3184.899', '250.45230', '-42.89439', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3180.684', '215.66450', '-43.48129', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3190.049', '191.40670', '-47.26377', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3202.457', '172.92600', '-49.13857', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3198.712', '154.54250', '-47.61382', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3191.650', '129.38040', '-46.38750', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3199.235', '111.01500', '-47.97380', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3215.442', '80.826820', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3225.974', '70.905170', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3215.456', '39.465930', '-49.28304', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3218.057', '14.812720', '-47.47643', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3232.953', '2.2024740', '-47.67784', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3241.448', '-16.72179', '-48.20384', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3240.345', '-45.92708', '-45.04333', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3236.313', '-72.91493', '-46.02376', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3225.415', '-94.10894', '-46.09856', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3215.184', '-125.0271', '-47.42868', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3198.149', '-144.3789', '-48.90287', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3195.199', '-160.0213', '-48.66862', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3190.234', '-188.3837', '-46.62103', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3194.873', '-215.7166', '-49.69736', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3213.641', '-245.5773', '-49.15242', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3233.052', '-275.7148', '-49.20945', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3234.987', '-304.3427', '-49.21683', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3220.768', '-329.8578', '-49.39344', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3197.923', '-345.2815', '-48.11151', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3181.139', '-362.3763', '-44.06171', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3170.618', '-379.9243', '-32.26678', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3167.317', '-395.3262', '-21.20147', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3162.110', '-435.2891', '-17.72998', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3167.317', '-395.3262', '-21.20147', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3170.618', '-379.9243', '-32.26678', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3181.139', '-362.3763', '-44.06171', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3197.923', '-345.2815', '-48.11151', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3220.768', '-329.8578', '-49.39344', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3234.987', '-304.3427', '-49.21683', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3233.052', '-275.7148', '-49.20945', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3213.641', '-245.5773', '-49.15242', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3194.873', '-215.7166', '-49.69736', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3190.234', '-188.3837', '-46.62103', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3195.199', '-160.0213', '-48.66862', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3198.149', '-144.3789', '-48.90287', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3215.184', '-125.0271', '-47.42868', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3225.415', '-94.10894', '-46.09856', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3236.313', '-72.91493', '-46.02376', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3240.345', '-45.92708', '-45.04333', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3241.448', '-16.72179', '-48.20384', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3232.953', '2.2024740', '-47.67784', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3218.057', '14.812720', '-47.47643', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3215.456', '39.465930', '-49.28304', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3225.974', '70.905170', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3215.442', '80.826820', '-49.30187', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3199.235', '111.01500', '-47.97380', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3191.650', '129.38040', '-46.38750', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3198.712', '154.54250', '-47.61382', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3202.457', '172.92600', '-49.13857', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3190.049', '191.40670', '-47.26377', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3180.684', '215.66450', '-43.48129', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3184.899', '250.45230', '-42.89439', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3194.012', '282.98680', '-44.12692', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3209.576', '308.72660', '-45.18295', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3225.398', '330.03550', '-46.41989', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3236.055', '354.16190', '-47.16812', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3232.087', '378.38370', '-47.22718', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3232.343', '398.54900', '-48.87648', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3229.509', '421.77820', '-46.67115', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3236.807', '451.48190', '-47.32991', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3244.237', '480.18940', '-48.52467', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3245.977', '509.61450', '-49.20725', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3237.635', '529.06600', '-49.16099', '0', '0', '0', '100', '0'),
(@GUIDSTART + '2', (@POINT := @POINT + '1'), '3222.140', '543.13870', '-49.32173', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '3';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '3',@GUIDSTART + '3',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '3';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1516.821', '-5383.695', '-28.89055', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1474.842', '-5385.459', '-29.28639', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1447.965', '-5383.485', '-25.54378', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1412.757', '-5384.636', '-29.42945', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1382.154', '-5391.196', '-28.43884', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1354.784', '-5391.483', '-28.67631', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1334.220', '-5378.395', '-28.84184', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1335.495', '-5355.212', '-28.79936', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1344.525', '-5325.676', '-28.07126', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1328.266', '-5309.035', '-31.77486', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1304.008', '-5312.752', '-31.23555', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1284.624', '-5347.431', '-37.39617', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1286.436', '-5381.057', '-48.04226', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1284.715', '-5401.730', '-48.88867', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1287.051', '-5438.851', '-54.86390', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1305.017', '-5456.569', '-56.55155', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1317.339', '-5496.389', '-55.88370', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1305.017', '-5456.569', '-56.55155', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1287.051', '-5438.851', '-54.86390', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1284.738', '-5401.922', '-48.86840', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1286.436', '-5381.057', '-48.04226', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1284.624', '-5347.431', '-37.39617', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1304.008', '-5312.752', '-31.23555', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1328.266', '-5309.035', '-31.77486', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1344.525', '-5325.676', '-28.07126', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1335.495', '-5355.212', '-28.79936', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1334.220', '-5378.395', '-28.84184', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1354.784', '-5391.483', '-28.67631', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1382.154', '-5391.196', '-28.43884', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1412.757', '-5384.636', '-29.42945', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1447.965', '-5383.485', '-25.54378', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1474.842', '-5385.459', '-29.28639', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1516.821', '-5383.695', '-28.89055', '0', '0', '0', '100', '0'),
(@GUIDSTART + '3', (@POINT := @POINT + '1'), '1546.040', '-5379.322', '-32.59856', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '4';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '4',@GUIDSTART + '4',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '4';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1254.183', '-5419.487', '-52.47182', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1229.275', '-5435.859', '-56.99025', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1208.765', '-5447.439', '-59.66518', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1187.963', '-5453.081', '-61.99784', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1153.766', '-5448.208', '-64.51538', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1124.296', '-5439.626', '-63.20396', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1100.615', '-5425.709', '-61.84917', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1080.524', '-5423.092', '-60.78251', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1055.613', '-5418.479', '-58.51124', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1026.962', '-5411.602', '-55.96208', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1002.202', '-5421.312', '-52.50908', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '978.4183', '-5425.099', '-52.55588', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '959.8919', '-5425.464', '-49.94030', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '939.5423', '-5439.234', '-53.97221', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '924.9915', '-5446.012', '-55.85010', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '902.2852', '-5443.909', '-58.57483', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '880.6873', '-5439.053', '-59.71062', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '850.2018', '-5453.352', '-60.19572', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '880.6873', '-5439.053', '-59.71062', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '902.2852', '-5443.909', '-58.57483', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '924.9915', '-5446.012', '-55.85010', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '939.5423', '-5439.234', '-53.97221', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '959.8919', '-5425.464', '-49.94030', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '978.4183', '-5425.099', '-52.55588', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1002.202', '-5421.312', '-52.50908', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1026.962', '-5411.602', '-55.96208', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1055.613', '-5418.479', '-58.51124', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1080.524', '-5423.092', '-60.78251', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1100.615', '-5425.709', '-61.84917', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1124.296', '-5439.626', '-63.20396', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1153.766', '-5448.208', '-64.51538', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1187.963', '-5453.081', '-61.99784', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1208.765', '-5447.439', '-59.66518', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1229.275', '-5435.859', '-56.99025', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1254.183', '-5419.487', '-52.47182', '0', '0', '0', '100', '0'),
(@GUIDSTART + '4', (@POINT := @POINT + '1'), '1284.577', '-5416.164', '-50.28735', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '5';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '5',@GUIDSTART + '5',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '5';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '884.7640', '-5424.270', '-58.09518', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '860.0378', '-5429.363', '-58.32449', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '840.0536', '-5447.569', '-59.14537', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '808.6261', '-5450.202', '-55.68275', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '785.2258', '-5449.354', '-55.08957', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '752.3654', '-5448.882', '-57.33829', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '710.3349', '-5452.754', '-57.69526', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '683.3268', '-5449.814', '-59.34686', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '655.4700', '-5444.357', '-59.52345', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '651.5726', '-5424.516', '-58.07015', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '618.4048', '-5414.902', '-62.80570', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '588.8499', '-5403.264', '-64.40174', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '542.9274', '-5406.277', '-62.64283', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '511.8536', '-5405.745', '-58.56149', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '482.2355', '-5413.691', '-57.85778', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '445.7431', '-5419.081', '-58.46385', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '482.2355', '-5413.691', '-57.85778', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '511.8536', '-5405.745', '-58.56149', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '542.9274', '-5406.277', '-62.64283', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '588.8499', '-5403.264', '-64.40174', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '618.4048', '-5414.902', '-62.80570', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '651.5726', '-5424.516', '-58.07015', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '655.4700', '-5444.357', '-59.52345', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '683.3268', '-5449.814', '-59.34686', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '710.3349', '-5452.754', '-57.69526', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '752.3654', '-5448.882', '-57.33829', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '785.2258', '-5449.354', '-55.08957', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '808.6261', '-5450.202', '-55.68275', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '840.0536', '-5447.569', '-59.14537', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '860.0378', '-5429.363', '-58.32449', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '884.7640', '-5424.270', '-58.09518', '0', '0', '0', '100', '0'),
(@GUIDSTART + '5', (@POINT := @POINT + '1'), '910.8514', '-5418.024', '-54.31270', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '6';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '6',@GUIDSTART + '6',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '6';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '478.1627', '-5354.213', '-43.77430', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '449.2878', '-5339.316', '-39.46656', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '417.3964', '-5331.676', '-27.15956', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '401.8826', '-5346.240', '-24.60424', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '384.3302', '-5356.516', '-22.07583', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '365.9248', '-5363.742', '-21.16536', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '359.1452', '-5389.113', '-23.30958', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '351.7778', '-5414.204', '-22.67201', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '336.7711', '-5442.292', '-26.53557', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '336.7526', '-5463.582', '-28.15532', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '326.5220', '-5489.887', '-32.60765', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '297.9786', '-5504.623', '-32.26982', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '266.1298', '-5515.100', '-32.10590', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '239.6120', '-5514.212', '-31.99897', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '209.3774', '-5516.511', '-31.55025', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '181.9160', '-5520.001', '-31.04438', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '152.5164', '-5519.960', '-29.29182', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '112.3420', '-5522.801', '-32.62555', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '71.75141', '-5513.651', '-32.56606', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '42.74143', '-5516.012', '-32.60234', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '71.75141', '-5513.651', '-32.56606', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '112.3420', '-5522.801', '-32.62555', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '152.5164', '-5519.960', '-29.29182', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '181.9160', '-5520.001', '-31.04438', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '209.3774', '-5516.511', '-31.55025', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '239.6120', '-5514.212', '-31.99897', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '266.1298', '-5515.100', '-32.10590', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '297.9786', '-5504.623', '-32.26982', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '326.5220', '-5489.887', '-32.60765', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '336.7526', '-5463.582', '-28.15532', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '336.7711', '-5442.292', '-26.53557', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '351.7778', '-5414.204', '-22.67201', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '359.1452', '-5389.113', '-23.30958', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '365.9248', '-5363.742', '-21.16536', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '384.3302', '-5356.516', '-22.07583', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '401.8826', '-5346.240', '-24.60424', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '417.1816', '-5331.885', '-27.10952', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '449.2878', '-5339.316', '-39.46656', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '478.1627', '-5354.213', '-43.77430', '0', '0', '0', '100', '0'),
(@GUIDSTART + '6', (@POINT := @POINT + '1'), '483.2733', '-5373.548', '-49.24841', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '7';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '7',@GUIDSTART + '7',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '7';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-348.0666', '-5577.971', '-32.64998', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-357.5493', '-5604.614', '-32.54316', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-380.1994', '-5623.577', '-31.47375', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-412.2324', '-5631.504', '-31.97309', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-438.9145', '-5638.841', '-33.19761', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-459.0912', '-5648.773', '-34.10117', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-471.5914', '-5669.522', '-33.25838', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-490.0464', '-5686.989', '-32.26326', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-512.8648', '-5686.814', '-36.96063', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-530.8138', '-5673.190', '-35.95770', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-545.8073', '-5669.218', '-31.60473', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-554.3489', '-5676.345', '-26.09570', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-548.3919', '-5686.530', '-26.03271', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-545.6289', '-5697.585', '-25.74463', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-558.8811', '-5718.676', '-23.57467', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-555.4393', '-5742.337', '-26.51720', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-543.6359', '-5759.576', '-33.29772', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-545.6593', '-5779.448', '-32.52080', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-565.7188', '-5811.162', '-34.10390', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-584.5605', '-5824.542', '-32.46045', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-614.8983', '-5821.754', '-32.86377', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-584.5605', '-5824.542', '-32.46045', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-565.7188', '-5811.162', '-34.10390', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-545.6593', '-5779.448', '-32.52080', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-543.6359', '-5759.576', '-33.29772', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-555.4393', '-5742.337', '-26.51720', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-558.8811', '-5718.676', '-23.57467', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-545.6289', '-5697.585', '-25.74463', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-548.3919', '-5686.530', '-26.03271', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-554.3489', '-5676.345', '-26.09570', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-545.8073', '-5669.218', '-31.60473', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-530.8138', '-5673.190', '-35.95770', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-512.8648', '-5686.814', '-36.96063', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-490.0464', '-5686.989', '-32.26326', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-471.5914', '-5669.522', '-33.25838', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-459.0912', '-5648.773', '-34.10117', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-438.9145', '-5638.841', '-33.19761', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-412.4659', '-5631.576', '-32.09028', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-380.1994', '-5623.577', '-31.47375', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-357.5493', '-5604.614', '-32.54316', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-348.0666', '-5577.971', '-32.64998', '0', '0', '0', '100', '0'),
(@GUIDSTART + '7', (@POINT := @POINT + '1'), '-318.7133', '-5564.043', '-32.55148', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '8';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '8',@GUIDSTART + '8',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '8';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-608.1886', '-5817.862', '-33.70899', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-636.5050', '-5820.905', '-28.45358', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-659.1743', '-5823.260', '-19.37738', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-691.7118', '-5820.370', '-20.50407', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-713.3483', '-5823.955', '-20.36920', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-751.2515', '-5827.444', '-21.73389', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-783.6209', '-5825.679', '-22.79669', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-808.2864', '-5822.929', '-29.95310', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-845.2535', '-5820.434', '-16.36810', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-875.6730', '-5822.888', '-12.82245', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-909.9373', '-5825.713', '-12.14808', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-942.4223', '-5823.407', '-20.27853', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-980.9655', '-5821.277', '-22.57777', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1015.380', '-5815.631', '-30.79053', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1034.805', '-5795.985', '-28.10279', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1056.589', '-5790.917', '-26.02222', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1070.566', '-5793.046', '-25.00549', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1094.363', '-5787.655', '-27.30798', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1114.446', '-5780.142', '-27.81094', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1128.797', '-5771.169', '-18.63370', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1147.591', '-5766.960', '-13.69177', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1179.733', '-5766.318', '-14.88489', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1207.664', '-5765.576', '-13.84899', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1232.476', '-5768.130', '-17.94231', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1249.485', '-5772.077', '-21.22132', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1232.476', '-5768.130', '-17.94231', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1207.664', '-5765.576', '-13.84899', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1179.733', '-5766.318', '-14.88489', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1147.591', '-5766.960', '-13.69177', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1128.797', '-5771.169', '-18.63370', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1114.446', '-5780.142', '-27.81094', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1094.363', '-5787.655', '-27.30798', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1070.566', '-5793.046', '-25.00549', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1056.589', '-5790.917', '-26.02222', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1034.805', '-5795.985', '-28.10279', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-1015.380', '-5815.631', '-30.79053', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-980.9655', '-5821.277', '-22.57777', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-942.4223', '-5823.407', '-20.27853', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-909.9373', '-5825.713', '-12.14808', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-875.6730', '-5822.888', '-12.82245', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-845.2535', '-5820.434', '-16.36810', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-808.2864', '-5822.929', '-29.95310', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-783.6209', '-5825.679', '-22.79669', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-751.2515', '-5827.444', '-21.73389', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-713.3483', '-5823.955', '-20.36920', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-691.7118', '-5820.370', '-20.50407', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-659.1743', '-5823.260', '-19.37738', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-636.5050', '-5820.905', '-28.45358', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-608.1886', '-5817.862', '-33.70899', '0', '0', '0', '100', '0'),
(@GUIDSTART + '8', (@POINT := @POINT + '1'), '-581.4075', '-5813.840', '-31.54468', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '9';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '9',@GUIDSTART + '9',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '9';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1414.717', '-5785.945', '-18.28851', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1429.123', '-5803.252', '-21.42676', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1440.071', '-5818.405', '-23.65052', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1473.324', '-5817.655', '-28.52335', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1493.109', '-5817.798', '-30.55362', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1515.078', '-5820.915', '-30.82909', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1546.918', '-5824.502', '-30.41975', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1576.580', '-5830.682', '-26.95949', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1609.989', '-5827.751', '-22.25511', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1649.508', '-5819.800', '-18.23368', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1656.176', '-5794.950', '-11.23240', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1638.662', '-5767.847', '-23.09690', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1641.793', '-5751.137', '-26.11779', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1618.052', '-5731.528', '-29.60553', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1600.349', '-5710.068', '-28.90900', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1617.423', '-5693.512', '-23.34335', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1640.375', '-5682.300', '-22.65612', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1660.634', '-5671.528', '-26.17687', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1686.911', '-5662.636', '-27.36601', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1698.239', '-5629.519', '-27.07917', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1712.572', '-5613.549', '-27.77460', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1728.000', '-5592.728', '-26.94653', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1744.330', '-5587.043', '-30.40704', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1728.000', '-5592.728', '-26.94653', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1712.572', '-5613.549', '-27.77460', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1698.239', '-5629.519', '-27.07917', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1686.911', '-5662.636', '-27.36601', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1660.634', '-5671.528', '-26.17687', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1640.375', '-5682.300', '-22.65612', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1617.423', '-5693.512', '-23.34335', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1600.349', '-5710.068', '-28.90900', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1618.052', '-5731.528', '-29.60553', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1641.793', '-5751.137', '-26.11779', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1638.662', '-5767.847', '-23.09690', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1656.176', '-5794.950', '-11.23240', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1649.508', '-5819.800', '-18.23368', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1609.989', '-5827.751', '-22.25511', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1576.580', '-5830.682', '-26.95949', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1546.918', '-5824.502', '-30.41975', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1515.078', '-5820.915', '-30.82909', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1493.109', '-5817.798', '-30.55362', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1473.324', '-5817.655', '-28.52335', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1440.071', '-5818.405', '-23.65052', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1429.123', '-5803.252', '-21.42676', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1414.717', '-5785.945', '-18.28851', '0', '0', '0', '100', '0'),
(@GUIDSTART + '9', (@POINT := @POINT + '1'), '-1368.822', '-5777.984', '-19.77502', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '10';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '10',@GUIDSTART + '10',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '10';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1776.081', '-5589.009', '-34.18173', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1803.558', '-5594.414', '-34.12356', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1823.099', '-5600.482', '-33.48129', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1856.045', '-5605.799', '-33.92609', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1873.247', '-5594.561', '-36.22752', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1884.442', '-5579.096', '-39.40404', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1896.791', '-5559.878', '-39.60547', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1889.671', '-5539.566', '-37.13672', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1871.801', '-5526.505', '-38.08211', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1846.049', '-5521.628', '-40.42604', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1827.922', '-5477.870', '-35.56777', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1820.318', '-5455.870', '-30.86184', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1804.972', '-5430.848', '-35.17406', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1779.959', '-5415.255', '-34.33684', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1766.378', '-5396.977', '-33.19410', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1779.959', '-5415.255', '-34.33684', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1804.972', '-5430.848', '-35.17406', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1820.318', '-5455.870', '-30.86184', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1827.922', '-5477.870', '-35.56777', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1846.049', '-5521.628', '-40.42604', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1871.801', '-5526.505', '-38.08211', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1889.671', '-5539.566', '-37.13672', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1896.791', '-5559.878', '-39.60547', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1884.442', '-5579.096', '-39.40404', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1873.247', '-5594.561', '-36.22752', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1856.045', '-5605.799', '-33.92609', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1823.099', '-5600.482', '-33.48129', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1803.558', '-5594.414', '-34.12356', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1776.081', '-5589.009', '-34.18173', '0', '0', '0', '100', '0'),
(@GUIDSTART + '10', (@POINT := @POINT + '1'), '-1755.496', '-5592.202', '-32.99152', '0', '0', '0', '100', '0');

SET @POINT := '0';
DELETE FROM `creature_addon` WHERE `guid` = @GUIDSTART + '11';
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUIDSTART + '11',@GUIDSTART + '11',0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUIDSTART + '11';
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1142.711', '-4322.336', '-7.514394', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1145.222', '-4345.001', '-9.041511', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1160.349', '-4357.775', '-12.11841', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1176.233', '-4369.198', '-13.35694', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1169.887', '-4381.364', '-14.98853', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1166.834', '-4391.783', '-13.77357', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1184.732', '-4412.307', '-13.05519', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1183.193', '-4430.994', '-10.80470', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1202.447', '-4460.210', '-6.748327', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1215.991', '-4472.520', '-8.580442', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1208.834', '-4488.687', '-6.471312', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1188.059', '-4498.218', '-4.539361', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1169.258', '-4479.332', '-4.284722', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1162.066', '-4452.037', '-4.664849', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1155.305', '-4427.696', '-7.986797', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1165.516', '-4412.070', '-11.33738', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1159.323', '-4392.171', '-11.84208', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1144.141', '-4381.103', '-9.759070', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1133.105', '-4355.526', '-8.964375', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1120.305', '-4335.307', '-8.061429', '0', '0', '0', '100', '0'),
(@GUIDSTART + '11', (@POINT := @POINT + '1'), '-1119.314', '-4321.887', '-7.848064', '0', '0', '0', '100', '0');
--
DELETE FROM `creature_addon` WHERE `guid` IN (57,97,105,121,134,1748,1759,1760,1768,1816,1889,1894);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES 
(57,570,0,0,0,4097,0,0,''),
(97,970,0,0,0,4097,0,0,''),
(105,1050,0,0,0,4097,0,0,''),
(121,1210,0,0,0,4097,0,0,''),
(134,1340,0,0,0,4097,0,0,''),
(1759,17590,0,0,0,4097,0,0,''),
(1760,17600,0,0,0,4097,0,0,''),
(1768,17680,0,0,0,4097,0,0,''),
(1816,18160,0,0,0,4097,0,0,''),
(1889,18890,0,0,0,4097,0,0,''),
(1894,18940,0,0,0,4097,0,0,'');
--
SET @GUID := '1748'; -- Ironforge Guard
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4958.850', `position_y`='-997.5289', `position_z`='501.5721', `orientation`='0.9778681', `MovementType`='2' WHERE `guid`=@GUID;

DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID, (@POINT := @POINT + '1'), '-4942.368', '-973.0673', '501.5523', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4922.720', '-954.7523', '501.5698', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4896.282', '-936.7808', '501.4918', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4872.001', '-926.0280', '501.5149', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4872.001', '-926.0280', '501.5149', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4872.3994', '-926.1273', '501.4919', '45000', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4905.076', '-941.8298', '501.5605', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4929.299', '-961.5024', '501.5698', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4958.948', '-997.8889', '501.4812', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4958.948', '-997.8889', '501.4812', '0', '0', '0', '100', '0'),
(@GUID, (@POINT := @POINT + '1'), '-4958.7397', '-997.3656', '501.4906', '45000', '0', '0', '100', '0');

INSERT IGNORE INTO `creature` VALUES (1823,5109,0,1,0,0,-4925.116,-947.6945,501.6491,4.042188,300,0,0,0,0,0,2);
SET @MYRA := '1823';
SET @GUID := 1823;
SET @POINT := '0';



DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@MYRA, (@POINT := @POINT + '1'), '-4940.067', '-966.5563', '501.5916', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4956.591', '-978.8500', '501.6491', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4966.608', '-974.9324', '502.7796', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4977.690', '-967.0145', '501.6595', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4978.871', '-957.0950', '501.6595', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4966.549', '-946.7832', '501.6595', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4946.386', '-929.8782', '501.6594', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4924.840', '-913.5948', '501.6594', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4904.366', '-898.4344', '501.6594', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4898.426', '-902.3857', '501.6593', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4891.908', '-916.8919', '501.6311', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4902.026', '-933.6296', '501.5292', '0', '0', '0', '100', '0'),
(@MYRA, (@POINT := @POINT + '1'), '-4925.541', '-947.7893', '501.6206', '0', '0', '0', '100', '0');
UPDATE `creature` SET `currentwaypoint`='0' WHERE `guid` IN ('51'); -- 5124


SET @STONEHAMMER := '1888'; -- Roetten Stonehammer
SET @GUID := 1888;
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4681.394', `position_y`='-1266.606', `position_z`='503.4648', `orientation`='1.963985', `MovementType`='2' WHERE `guid`=@STONEHAMMER;

DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4686.149', '-1255.140', '501.9927', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4675.921', '-1244.380', '501.9927', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4667.503', '-1245.781', '501.9927', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4661.595', '-1250.517', '503.3816', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4661.595', '-1250.517', '503.3816', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4662.0625', '-1250.2288', '503.3815', '60000', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4670.109', '-1243.077', '501.9927', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4681.147', '-1244.796', '501.9927', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4686.531', '-1252.014', '501.9927', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4685.416', '-1262.677', '501.9927', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4681.394', '-1266.606', '503.3816', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4681.394', '-1266.606', '503.3816', '0', '0', '0', '100', '0'),
(@STONEHAMMER, (@POINT := @POINT + '1'), '-4681.6557', '-1265.9698', '503.3816', '60000', '0', '0', '100', '0');


SET @ROHAN := '1777'; -- High Priest Rohan

-- ----------------------------------------

SET @GUID := 1777;
SET @POINT := '0';

UPDATE `creature` SET `position_x`='-4612.268', `position_y`='-909.0977', `position_z`='501.1455', `orientation`='4.328416', `MovementType`='2' WHERE `guid`=1777;

DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@ROHAN, (@POINT := @POINT + '1'), '-4603.221', '-905.3360', '502.7668', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4602.796', '-903.2332', '502.7668', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4607.162', '-897.2797', '502.7668', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4607.162', '-897.2797', '502.7668', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4607.0961', '-897.6234', '502.7668', '90000', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4601.626', '-904.6155', '502.7668', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4602.049', '-906.3550', '502.7668', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4608.619', '-913.5076', '501.0607', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4610.180', '-921.8517', '501.0684', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4607.634', '-926.9007', '501.0711', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4607.634', '-926.9007', '501.0711', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4608.0336', '-926.6286', '501.0696', '180000', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4612.254', '-909.1521', '501.0622', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4612.254', '-909.1521', '501.0622', '0', '0', '0', '100', '0'),
(@ROHAN, (@POINT := @POINT + '1'), '-4612.3408', '-909.4912', '501.0620', '90000', '0', '0', '100', '0');