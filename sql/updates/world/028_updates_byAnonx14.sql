-- Design: Veiled Nightseye
INSERT IGNORE INTO `creature_loot_template` VALUES
-- 0.03
(21337,31878,0.03,0,1,1,0,0,0),
-- 0.02
(18320,31878,0.02,0,1,1,0,0,0),
-- 0.01
(16468,31878,0.01,0,1,1,0,0,0),
(18493,31878,0.01,0,1,1,0,0,0),
(20301,31878,0.01,0,1,1,0,0,0),
(18497,31878,0.01,0,1,1,0,0,0),
(20299,31878,0.01,0,1,1,0,0,0),
(23397,31878,0.01,0,1,1,0,0,0),
(23018,31878,0.01,0,1,1,0,0,0),
(16481,31878,0.01,0,1,1,0,0,0),
(16415,31878,0.01,0,1,1,0,0,0),
(24685,31878,0.01,0,1,1,0,0,0),
(24683,31878,0.01,0,1,1,0,0,0),
(20259,31878,0.01,0,1,1,0,0,0),
(17833,31878,0.01,0,1,1,0,0,0),
(20530,31878,0.01,0,1,1,0,0,0),
(21298,31878,0.01,0,1,1,0,0,0),
(18323,31878,0.01,0,1,1,0,0,0),
(20692,31878,0.01,0,1,1,0,0,0),
(20035,31878,0.01,0,1,1,0,0,0),
(20031,31878,0.01,0,1,1,0,0,0),
(19166,31878,0.01,0,1,1,0,0,0),
(21543,31878,0.01,0,1,1,0,0,0),
(21695,31878,0.01,0,1,1,0,0,0),
(21917,31878,0.01,0,1,1,0,0,0),
-- 0.005
(15547,31878,0.005,0,1,1,0,0,0),
(15548,31878,0.005,0,1,1,0,0,0),
(15551,31878,0.005,0,1,1,0,0,0),
(16406,31878,0.005,0,1,1,0,0,0),
(17148,31878,0.005,0,1,1,0,0,0),
(18875,31878,0.005,0,1,1,0,0,0),
(21911,31878,0.005,0,1,1,0,0,0),
(22877,31878,0.005,0,1,1,0,0,0),
(17895,31878,0.005,0,1,1,0,0,0),
(16539,31878,0.005,0,1,1,0,0,0),
(16409,31878,0.005,0,1,1,0,0,0);
-- deleting stuff
-- cooking quests
--
DELETE FROM `game_event_creature_quest` WHERE `quest` IN (11380,11377,11381,11379);
-- INSERT INTO `game_event_creature_quest` VALUES
-- (24393,11377,125),
-- (24393,11379,127),
-- (24393,11380,124),
-- (24393,11381,126);
--
-- Set trigger flag on Infernal Target triggers... (from forum)
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|128 WHERE `entry`=17644;
-- TEACHER
-- remove emtpy rows (thx Aokromes)
DELETE FROM `creature_addon` WHERE `path_id`=0 AND `mount`=0 AND `bytes1`=0 AND `bytes2`=0 AND `emote`=0 AND `auras` IS NULL;
DELETE FROM `creature_template_addon` WHERE `path_id`=0 AND `mount`=0 AND `bytes1`=0 AND `bytes2`=0 AND `emote`=0 AND `auras` IS NULL;
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (68924,68568,68567,69136,69137,69138,69139);
DELETE FROM `creature_formations` WHERE `memberguid` IN (68924,68568,68567,69136,69137,69138,69139);
INSERT IGNORE INTO `creature_formations` VALUES 
(68924,68924,60,360,2),
(68924,68493,2,0,2),
(68924,68925,4,0,2),
(68924,68494,6,0,2),
(68924,68923,8,0,2),
(68924,68492,10,0,2),
-- Flüchtlingsjungs
(68568,68568,60,360,2),
(68568,68567,3,0,2),
(69137,69137,100,360,3),
(69137,69136,4,1,3),
(69137,69138,4,5,3),
(69137,69139,6,0,3);
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('69137');
SET @NPC := 69137;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,19869,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-1797.21814','5629.5776','130.8128',0,0,0,100,0),
(@PATH,2,'-1795.8704','5633.7294','130.7822',0,0,0,100,0),
(@PATH,3,'-1786.7004','5661.3969','129.4054',0,0,0,100,0),
(@PATH,4,'-1776.8057','5690.7163','128.03428',0,0,0,100,0),
(@PATH,5,'-1777.8790','5687.5952','128.0998',0,0,0,100,0);
--
-- pvp kids
SET @NPC := 68568; 
UPDATE `creature` SET `MovementType` = 2 WHERE guid = @NPC;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` VALUES (@NPC,@PATH,0,16777472,0,4097,0,0,''); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1865.1380,5226.7050,-40.2091,0,1,0,100,0),
(@PATH,2,-1874.0732,5221.7236,-40.2091,0,1,0,100,0),
(@PATH,3,-1896.9624,5217.5102,-48.0995,0,1,0,100,0), 
(@PATH,4,-1936.0278,5217.9941,-47.2738,0,1,0,100,0),
(@PATH,5,-1957.4179,5253.1718,-42.4121,0,1,0,100,0),
(@PATH,6,-1959.2875,5257.5942,-38.8516,0,1,0,100,0),
(@PATH,7,-1962.2069,5268.2412,-38.8108,0,1,0,100,0),
(@PATH,8,-1972.4090,5266.1381,-38.8508,0,1,0,100,0),
(@PATH,9,-1975.5362,5261.1347,-41.9375,0,1,0,100,0),
(@PATH,10,-1973.3724,5214.8261,-47.7292,0,1,0,100,0),
(@PATH,11,-1968.0831,5190.0449,-40.2076,0,1,0,100,0),
(@PATH,12,-1945.9741,5171.5532,-40.2092,0,1,0,100,0),
(@PATH,13,-1905.5919,5176.2368,-40.2092,0,1,0,100,0),
(@PATH,14,-1868.4006,5174.7724,-50.0506,0,1,0,100,0),
(@PATH,15,-1825.6529,5168.1435,-48.9272,0,1,0,100,0),
(@PATH,16,-1798.4946,5181.3803,-41.8442,0,1,0,100,0),
(@PATH,17,-1777.8391,5215.7353,-49.1428,0,1,0,100,0),
(@PATH,18,-1759.4946,5243.5415,-40.8305,0,1,0,100,0),
(@PATH,19,-1750.2081,5258.2495,-40.2078,0,1,0,100,0),
(@PATH,20,-1772.9831,5264.2685,-38.8104,0,1,0,100,0), 
(@PATH,21,-1778.1439,5251.1411,-40.2091,0,1,0,100,0),
(@PATH,22,-1807.3149,5238.1420,-42.0734,0,1,0,100,0),
(@PATH,23,-1830.6756,5214.0410,-40.2093,0,1,0,100,0),
(@PATH,24,-1840.7662,5218.4252,-38.0447,0,1,0,100,0),
(@PATH,25,-1853.2336,5224.8989,-38.0447,0,1,0,100,0);
--
-- Bog Giant 17723 20164
UPDATE `creature_template` SET `mechanic_immune_mask`='652885759',`mindmg`='1132',`maxdmg`='1475',`baseattacktime`='2000' WHERE `entry` IN (17723); -- 525-1040 
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='652885759',`mindmg`='8023',`maxdmg`='9529',`baseattacktime`='0' WHERE `entry` IN (20164); -- 10,029 - 11,911
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17723');
INSERT INTO `creature_ai_scripts` VALUES
('1772301','17723','9','0','75','3','0','5','13650','16100','11','15550','0','0','0','0','0','0','0','0','0','0','Bog Giant (Normal) - Cast Trample'), -- 40340 eig nur 15550
('1772302','17723','9','0','75','5','0','5','13650','16100','11','40492','0','0','0','0','0','0','0','0','0','0','Bog Giant (Heroic) - Cast Trample'), -- 40340 eig nur 15550
('1772303','17723','9','0','100','7','0','15','9300','9300','11','32065','4','32','0','0','0','0','0','0','0','0','Bog Giant - Cast Fungal Decay'),
('1772304','17723','2','0','100','6','50','0','0','0','11','40318','0','1','0','0','0','0','0','0','0','0','Bog Giant - Cast Growth at 50% HP'),
('1772305','17723','2','0','100','6','30','0','120000','120000','11','8599','0','1','1','-46','0','0','0','0','0','0','Bog Giant - Cast Enrage at 30% HP');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/525/dampfkammer
--
-- Texts
--
-- trans
UPDATE `creature_ai_texts` SET `content_loc3`='Was ist das?! Haben Mami und Papi Dir nichts beigebracht?' WHERE (`entry`='-685'); 
UPDATE `creature_ai_texts` SET `content_loc3`='Geht zurück an die Arbeit!' WHERE (`entry`='-684'); 
UPDATE `creature_ai_texts` SET `content_loc3`='Schrecklich... meine Arme sind durch die ganzen Schläge schon ganz lahm geworden!' WHERE (`entry`='-683');
UPDATE `creature_ai_texts` SET `content_loc3`='Slackerband!' WHERE (`entry`='-681'); 
UPDATE `creature_ai_texts` SET `content_loc3`='Aufwachen! Zurück an die Arbeit!' WHERE (`entry`='-680'); 
UPDATE `creature_ai_texts` SET `content_loc3`='Beeilt Euch! Je länger Ihr braucht, desto mehr Schläge für Euch!' WHERE (`entry`='-679'); 
UPDATE `creature_ai_texts` SET `content_loc3`='Helft mir, Sklaven!' WHERE (`entry`='-678');
--
-- Research
--
-- All NPCs nonheroic speed
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` IN (20624,17802,20626,17801,20623,17722,20625,17721,20620,21694,21914,17803,20622,21696,21916,21695,21917,17800,20621,17799,20628,21338,21915,17797,20629,17796,20630,17798,20633);
--
-- Invisible Stalker Coilfang Doors
UPDATE `creature_template` SET `flags_extra` ='128' WHERE entry = '20926';
--
-- Coilfang Engineer 17721,20620
UPDATE `creature_template` SET `equipment_id` ='429' WHERE `entry` IN (17721);
UPDATE `creature_template` SET `equipment_id` ='429',`mindmg`='3792',`maxdmg`='3952' WHERE `entry` IN (20620); -- 1332 1572
--
-- Coilfang Warrior 17802,20626
UPDATE `creature_template` SET `maxlevel`='70',`equipment_id` ='940' WHERE `entry` IN (17802); 
UPDATE `creature_template` SET `maxlevel`='70',`equipment_id` ='940',`mindmg`='4984',`maxdmg`='5242' WHERE `entry` IN (20626); -- 1724 2111
UPDATE `creature_ai_scripts` SET `event_flags`='7',`action1_param3`='7' WHERE `id` IN (1780201);
--
-- Coilfang Siren 17801,20623
UPDATE `creature_template` SET `equipment_id` ='838' WHERE `entry` IN (17801); 
UPDATE `creature_template` SET `equipment_id` ='838' WHERE `entry` IN (20623);
UPDATE `creature_ai_scripts` SET `action1_param2`='4' WHERE `id` IN (1780113);
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN (1780101,1780108);
--
-- Coilfang Sorceress 17722,20625
UPDATE `creature_template` SET `equipment_id` ='1572' WHERE `entry` IN (17722); 
UPDATE `creature_template` SET `equipment_id` ='1572' WHERE `entry` IN (20625); 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (17722);
INSERT INTO `creature_ai_scripts` VALUES
('1772201','17722','1','0','100','7','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Sorceress - Combat Movement on Spawn'),
('1772202','17722','4','0','100','3','0','0','0','0','11','12675','1','0','23','1','0','0','0','0','0','0','Coilfang Sorceress (Normal) - Cast Frostbolt and Set Phase 1 on Aggro'),
('1772203','17722','9','5','100','3','0','40','2400','3800','11','12675','1','0','0','0','0','0','0','0','0','0','Coilfang Sorceress (Normal) - Cast Frostbolt (Phase 1)'),
('1772204','17722','4','0','100','5','0','0','0','0','11','37930','1','0','23','1','0','0','0','0','0','0','Coilfang Sorceress (Heroic) - Cast Frostbolt and Set Phase 1 on Aggro'),
('1772205','17722','9','5','100','5','0','40','2400','3800','11','37930','1','0','0','0','0','0','0','0','0','0','Coilfang Sorceress (Heroic) - Cast Frostbolt (Phase 1)'),
('1772206','17722','3','5','100','7','5','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Coilfang Sorceress - Start Combat Movement and Set Phase 2 when Mana is at 5% (Phase 1)'),
('1772207','17722','9','5','100','7','0','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Sorceress - Start Combat Movement at 35 Yards (Phase 1)'),
('1772208','17722','3','3','100','7','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Coilfang Sorceress - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1772209','17722','0','0','100','3','18000','20000','25000','27000','11','31581','1','0','0','0','0','0','0','0','0','0','Coilfang Sorceress (Normal) - Cast Blizzard'),
('1772210','17722','0','0','100','5','18000','20000','25000','27000','11','39416','1','0','0','0','0','0','0','0','0','0','Coilfang Sorceress (Heroic) - Cast Blizzard'),
('1772211','17722','9','0','100','3','0','6','13000','18000','11','15063','0','0','0','0','0','0','0','0','0','0','Coilfang Sorceress (Normal) - Cast Frost Nova'),
('1772212','17722','9','0','100','5','0','6','13000','18000','11','15531','0','0','0','0','0','0','0','0','0','0','Coilfang Sorceress (Heroic) - Cast Frost Nova'),
('1772213','17722','7','0','100','7','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Coilfang Sorceress - Set Phase to 0 on Evade');
--
-- Coilfang Oracle 17803,20622
UPDATE `creature_template` SET `equipment_id` ='619' WHERE `entry` IN (17803);
UPDATE `creature_template` SET `equipment_id` ='619' WHERE `entry` IN (20622); 
UPDATE `creature_ai_scripts` SET `event_param1`='6600' WHERE `id` IN ('1780303','1780304');
--
-- Coilfang Leper 21338,21915
UPDATE `creature_template` SET `equipment_id` ='1731' WHERE `entry` IN (21338);
UPDATE `creature_template` SET `equipment_id` ='1731' WHERE `entry` IN (21915);
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN (2133801,2133809,2133818);
--
-- Coilfang Slavemaster 17805,20624
UPDATE `creature_template` SET `equipment_id` ='1571' WHERE `entry` IN (17805);
UPDATE `creature_template` SET `equipment_id` ='1571' WHERE `entry` IN (20624);      
--
-- Coilfang Myrmidon 17800,20621
UPDATE `creature_template` SET `equipment_id` ='1020',`mindmg`='1532',`maxdmg`='2019' WHERE `entry` IN (17800); -- 467 954
UPDATE `creature_template` SET `equipment_id` ='1020',`mindmg`='4733',`maxdmg`='5100' WHERE `entry` IN (20621); -- 1568 2119
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (17800);
INSERT INTO `creature_ai_scripts` VALUES
('1780001','17800','9','0','100','7','0','5','6000','10000','11','15496','1','0','0','0','0','0','0','0','0','0','Coilfang Myrmidon - Cast Cleave'),
('1780002','17800','12','0','100','6','20','0','0','0','11','7160','1','1','0','0','0','0','0','0','0','0','Coilfang Myrmidon - Cast Execute at 20% Player HP');
--
-- Coilfang Water Elemental 17917,20627
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` IN ('17917');
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`speed`='1.48',`lootid`='17917' WHERE `entry` IN ('20627');
--
-- Bog Overlord 21694,21914
UPDATE `creature_template` SET `mindmg`='2272',`maxdmg`='3631',`baseattacktime`='2000',`mechanic_immune_mask`='1073723391' WHERE `entry` IN ('21694'); -- 1301 2660 -- 4272 - 5631 
UPDATE `creature_template` SET `mindmg`='6622',`maxdmg`='7243',`baseattacktime`='0',`skinloot`='80001',`mechanic_immune_mask`='1073723391' WHERE `entry` IN ('21914'); -- 5518 7000 -- 8,278 - 9,054
DELETE FROM `creature_template_addon` WHERE `entry` IN (21694,21914);
INSERT INTO `creature_template_addon` VALUES
(21694,0,0,0,0,0,0,0,'18950 0 18950 1'), -- b1 = 1
(21914,0,0,0,0,0,0,0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (21694);
INSERT INTO `creature_ai_scripts` VALUES
('2169401','21694','11','0','100','2','0','0','0','0','11','37266','0','1','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Cast Disease Cloud on Spawn'),
('2169402','21694','11','0','100','4','0','0','0','0','11','37863','0','1','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Cast Disease Cloud on Spawn'),
('2169403','21694','4','0','100','6','0','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Bog Overlord - Set Phase 1 on Aggro'),
('2169404','21694','9','5','100','3','0','5','4000','6000','11','37272','1','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Cast Poison Bolt (Phase 1)'),
('2169405','21694','9','5','100','5','0','5','4000','6000','11','37862','1','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Cast Poison Bolt (Phase 1)'),
('2169406','21694','24','5','100','3','37272','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Set Phase 2 on Target Max Poison Bolt Aura Stack (Phase 1)'),
('2169407','21694','24','5','100','5','37862','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Set Phase 2 on Target Max Poison Bolt Aura Stack (Phase 1)'),
('2169408','21694','28','3','100','3','37272','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Set Phase 1 on Target Missing Poison Bolt Aura Stack (Phase 2)'),
('2169409','21694','28','3','100','5','37862','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Set Phase 1 on Target Missing Poison Bolt Aura Stack (Phase 2)'),
('2169410','21694','0','0','100','7','2000','5000','12000','19000','11','32065','4','33','0','0','0','0','0','0','0','0','Bog Overlord - Cast Fungal Decay'),
('2169411','21694','0','0','100','3','7000','9500','12000','15000','11','40340','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Normal) - Cast Trample'), -- eig nur 40340
('2169412','21694','0','0','100','5','7000','9500','12000','15000','11','40492','0','0','0','0','0','0','0','0','0','0','Bog Overlord (Heroic) - Cast Trample'), -- eig nur 40340
('2169413','21694','2','0','100','6','20','0','0','0','11','8599','0','0','1','-46','0','0','0','0','0','0','Bog Overlord - Cast Enrage at 20% HP'),
('2169414','21694','7','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Bog Overlord - Set Phase to 0 on Evade');
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (21695);
INSERT INTO `creature_ai_scripts` VALUES
('2169501','21695','0','0','100','7','3000','7000','14000','18000','11','37250','4','0','0','0','0','0','0','0','0','0','Tidal Surger - Cast Water Spout'),
('2169502','21695','9','0','100','7','0','8','12000','17000','11','15531','0','1','0','0','0','0','0','0','0','0','Tidal Surger - Cast Frost Nova');
--
-- ??? 20628
UPDATE `creature_template` SET `armor`='7100' WHERE `entry` IN (20628);
--
-- Dreghood Slave 17799
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (17799);
INSERT INTO `creature_ai_scripts` VALUES
(1779901,17799,2,0,100,6,30,0,0,0,11,8269,0,0,1,-106,0,0,0,0,0,0,'Dreghood Slave - Casts Enrage at 30% HP');
--
-- Naga Distiller 17954,20631
UPDATE `creature_template` SET `armor`='6310',`mindmg`='0',`maxdmg`='0',`attackpower`='0',`baseattacktime`='0',`unit_flags`='33947654',`mechanic_immune_mask`='1073741823' WHERE `entry` IN ('17954');
UPDATE `creature_template` SET `armor`='6800',`unit_flags`='33947654',`mechanic_immune_mask`='1073741823',`flags_extra`='2' WHERE `entry` IN ('20631');
DELETE FROM `creature_template_addon` WHERE `entry` IN (17954,20631);
INSERT INTO `creature_template_addon` VALUES
(17954,0,0,16908544,0,4097,0,0,''),
(20631,0,0,16908544,0,4097,0,0,'');
--
-- Bosse
--
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423' WHERE `entry` IN (17797,20629,17796,20630,17798,20633);
--
-- Hydromancer Thespia 17797,20629
UPDATE `creature_template` SET `mindmg`='2051',`maxdmg`='2702' WHERE `entry` IN ('17797'); -- 625 1276
UPDATE `creature_template` SET `mindmg`='3060',`maxdmg`='3762',`pickpocketloot`='17797' WHERE `entry` IN ('20629');
--
-- Mekgineer Steamrigger 17796,20630
UPDATE `creature_template` SET `mindmg`='2722',`maxdmg`='3588',`baseattacktime`='1400' WHERE `entry` IN ('17796'); -- 829 1695
UPDATE `creature_template` SET `mindmg`='4179',`maxdmg`='4603',`baseattacktime`='0',`equipment_id`='0',`pickpocketloot`='17796' WHERE `entry` IN ('20630');
--
-- Warlord Kalithresh 17798,20633
UPDATE `creature_template` SET `mindmg`='2212',`maxdmg`='2916',`equipment_id` ='1752' WHERE `entry` IN ('17798'); -- 674 1378
UPDATE `creature_template` SET `mindmg`='5463',`maxdmg`='5683',`equipment_id` ='1752',`pickpocketloot`='17798' WHERE `entry` IN ('20633');
--
DELETE FROM `creature` WHERE `guid` IN (12624,306,307,308,299,394,42409,42440,42492);
INSERT INTO `creature` VALUES (306,17801,545,3,0,0,-11.9115,-111.5610,-22.0738,2.7426,7200,0,0,16208,15775,0,0);
INSERT INTO `creature` VALUES (12624,17722,545,3,0,0,0,0,0,0,7200,0,0,22357,15775,0,0);
INSERT INTO `creature` VALUES (307,17721,545,3,0,0,-27.3369,-186.1193,-20.7097,1.2739,7200,0,0,0,0,0,0);
INSERT INTO `creature` VALUES (308,17801,545,3,0,0,6.7600,-258.0846,-21.7040,1.7255,7200,0,0,0,0,0,0);
INSERT INTO `creature` VALUES (299,17802,545,3,0,0,13.5726,-261.4963,-21.7032,2.1731,7200,0,0,0,0,0,0);
INSERT INTO `creature` VALUES (394,17802,545,3,0,0,-82.4439,-255.9031,-11.9954,1.5600,7200,0,0,0,0,0,0);
INSERT INTO `creature` VALUES (42409,17803,545,3,0,0,13.2024,-207.3253,-22.4309,3.7751,7200,0,0,0,0,0,0);   
INSERT INTO `creature` VALUES (42440,17802,545,3,0,0,6.3134,-198.6056,-22.4149,5.9974,7200,0,0,0,0,0,0);
INSERT INTO `creature` VALUES (42492,17802,545,3,0,0,45.3809,-229.7579,-22.6132,3.4003,7200,0,0,0,0,0,0);  
--
-- linked respawn
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (12624,12625,12626,306,317,2093,2090,307,1550,502,452,308,1560,1557,299,394,1561,1723,42409,12678,12715,42440,42492,12691,12690,12676,118,120);
INSERT INTO `creature_linked_respawn` VALUES
(12624,12613),
(12625,12613),
(12626,12613),
(306,3453),
(317,3453),
(2093,3453),
(2090,3453),
(307,3453),
(1550,3453),
(502,3453),
(452,3453),
(308,3453),
(1560,3453),
(1557,3453),
(299,3453),
(394,12613),
(1561,12613),
(1723,12613),
(42409,3453),
(12678,3453),
(12715,3453),
(42440,3453),
(42492,3453),
(12691,3453),
(12690,3453),
(12676,3453),
(118,3453),
(120,3453);
-- (GUID,BOSSGUID), noch nicht alle nix gelinkt
--
--
--
UPDATE `creature` SET `position_x`='-82.3836',`position_y`='-371.1122',`position_z`='-7.7673',`orientation`='1.5882',`MovementType`='0',`id`='17722' WHERE `guid` IN ('12624');
UPDATE `creature` SET `position_x`='-91.6113',`position_y`='-372.0186',`position_z`='-7.7673',`orientation`='1.6235',`MovementType`='0',`id`='17800' WHERE `guid` IN ('12626');
UPDATE `creature` SET `position_x`='-100.3674',`position_y`='-372.1709',`position_z`='-7.7673',`orientation`='1.5882',`MovementType`='0' WHERE `guid` IN ('12625');
UPDATE `creature` SET `position_x`='-53.7041',`position_y`='-390.5220',`position_z`='-7.7683',`orientation`='3.6458',`MovementType`='0' WHERE `guid` IN ('12660');
UPDATE `creature` SET `position_x`='-12.3939',`position_y`='-378.7253',`position_z`='-7.7685',`orientation`='6.0099',`MovementType`='0' WHERE `guid` IN ('12662');
UPDATE `creature` SET `position_x`='-18.3115',`position_y`='-129.3071',`position_z`='-22.1619',`orientation`='4.4941',`MovementType`='0' WHERE `guid` IN ('12686');
UPDATE `creature` SET `position_x`='-3.6617',`position_y`='-132.7701',`position_z`='-21.1049',`orientation`='4.4548',`MovementType`='0' WHERE `guid` IN ('12687');
UPDATE `creature` SET `position_x`='58.5484',`position_y`='-127.0172',`position_z`='-22.7188',`orientation`='2.7068',`MovementType`='0' WHERE `guid` IN ('12710');
UPDATE `creature` SET `position_x`='60.2239',`position_y`='-121.2375',`position_z`='-22.6504',`orientation`='2.7068',`MovementType`='0' WHERE `guid` IN ('12711');
UPDATE `creature` SET `position_x`='-327.4291',`position_y`='-112,0949',`position_z`='-7,7555',`orientation`='3,2950',`MovementType`='0' WHERE `guid` IN ('12607');


UPDATE `creature` SET `id`='17802',`position_x`='-19.2700',`position_y`='-122.4256',`position_z`='-22.2596',`orientation`='6.1316',`MovementType`='2' WHERE `guid` IN ('12716');
UPDATE `creature` SET `spawndist`='5' WHERE `id` IN (21338);
UPDATE `creature` SET `MovementType`='2' WHERE `guid`  IN (1741,1550,299,1561,12587,12591,42440,42492);
UPDATE `creature` SET `MovementType`='0' WHERE `guid` IN (1723,118,120,394,12621,12641,12642,12616,12618,1554,1552,12622,12636,12646,12649,12661,12668); 
UPDATE `creature` SET `orientation`='2.5716',`MovementType`='0' WHERE `guid` IN (12628,12632,12631);

DELETE FROM `creature_addon` WHERE `guid` IN (307,12716,12686,12687,12715,12678,452,12709,12677,12676,12691,12660,12662);
INSERT INTO `creature_addon` VALUES 
(307,0,0,0,0,1,173,0,''),
(12716,0,0,0,0,1,173,0,''),
(12686,0,0,0,0,1,173,0,''),
(12687,0,0,0,0,1,173,0,''),
(12715,0,0,0,0,1,173,0,''),
(12678,0,0,0,0,1,173,0,''),
(452,0,0,0,0,1,173,0,''),
(12709,0,0,0,0,1,173,0,''),
(12677,0,0,0,0,1,173,0,''),
(12676,0,0,0,0,1,173,0,''),
(12691,0,0,0,0,1,173,0,''),
(12660,0,0,0,0,1,173,0,''),
(12662,0,0,0,0,1,173,0,'');


UPDATE `creature_addon` SET `bytes0`='0',`emote`='0' WHERE `guid` IN (394);

DELETE FROM `creature_addon` WHERE `guid` IN (12624,12625,12626);
DELETE FROM `creature_addon` WHERE `path_id` IN (1723,394,1561);
DELETE FROM `waypoint_data` WHERE `id` IN ('1723991','3940','15610');

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (2090,2093,3453,12667,12668,12669,12630, 12633, 12635, 12592, 12593, 12585, 12586, 12634, 12608,12609, 12610, 12612,12690,42409,12693,12629,12584,1561,308,299,12709,317,12686,1741,452,12646,12649,12641,12636,12587,12591,12616,12619,12627,1552,118,12663,12626,12624,12625,1723,1561,12679,12680,12681,12682,12683,12700,12684,12701,12702,12703,12695,12688,12696,12704,12694,12697,12698,12699);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (2090,2093,3453,12667,12668,12669,12630, 12633, 12635, 12592, 12593, 12585, 12586, 12634, 12608,12609, 12610, 12612,12690,42409,12693,12629,12584,1561,308,299,12709,317,12686,1741,452,12646,12649,12641,12636,12587,12591,12616,12619,12627,1552,118,12663,12626,12624,12625,1723,1561,12679,12680,12681,12682,12683,12700,12684,12701,12702,12703,12695,12688,12696,12704,12694,12697,12698,12699);
--
-- 12670,12579,12580,12581,12578,12577
-- 12605,12574,12575,12576,3641,12396,6439,116
--
INSERT INTO `creature_formations` VALUES 
(3453,3453,60,360,2),
(3453,2090,60,360,2),
(3453,2093,60,360,2);
--
INSERT INTO `creature_formations` VALUES 
(12697,12697,60,360,2),
(12697,12698,60,360,2),
(12697,12699,60,360,2);
--
INSERT INTO `creature_formations` VALUES 
(12667,12667,60,360,2),
(12667,12668,60,360,2),
(12667,12669,60,360,2);
INSERT INTO `creature_formations` VALUES 
(12690,12690,40,360,2),
(12690,42492,5,2,2),
(12690,12691,5,2,2),
(12690,12676,5,2,2);
INSERT INTO `creature_formations` VALUES 
(42409,42409,40,360,2),
(42409,12678,5,2,2),
(42409,12715,5,2,2),
(42409,42440,5,2,2);
INSERT INTO `creature_formations` VALUES 
(12693,12693,40,360,2),
(12693,12692,5,2,2),
(12693,12705,5,2,2),
(12693,12689,5,4,2);
INSERT INTO `creature_formations` VALUES 
(308,308,40,360,2),
(308,299,5,2,2),
(308,1560,5,2,2),
(308,1557,5,4,2);
INSERT INTO `creature_formations` VALUES 
(317,317,40,360,2),
(317,306,5,1,2);
INSERT INTO `creature_formations` VALUES 
(12709,12709,40,360,2),
(12709,12710,5,2,2),
(12709,12711,5,4,2);
INSERT INTO `creature_formations` VALUES 
(12686,12686,40,360,2),
(12686,12687,5,2,2),
(12686,12716,5,4,2);
INSERT INTO `creature_formations` VALUES 
(1741,1741,40,360,2),
(1741,1742,5,2,2),
(1741,2080,5,4,2);
 INSERT INTO `creature_formations` VALUES 
(452,452,40,360,2),
(452,502,5,2,2),
(452,307,5,2,2),
(452,1550,5,4,2);
INSERT INTO `creature_formations` VALUES 
(118,118,40,360,2),
(118,120,1,360,2);
INSERT INTO `creature_formations` VALUES 
(12624,12624,40,360,2),
(12624,12626,5,1,2),
(12624,12625,5,5,2);
INSERT INTO `creature_formations` VALUES 
(1561,1561,40,360,2),
(1561,394,5,1,2),
(1561,1723,5,5,2);
INSERT INTO `creature_formations` VALUES 
(1552,1552,40,360,2),
(1552,1554,5,1,2);
INSERT INTO `creature_formations` VALUES 
(12679,12679,40,360,2),
(12679,12680,5,1,2),
(12679,12681,5,2,2),
(12679,12682,5,4,2),
(12679,12683,5,5,2);
INSERT INTO `creature_formations` VALUES 
(12700,12700,40,360,2),
(12700,12684,5,1,2),
(12700,12701,5,2,2),
(12700,12702,5,4,2),
(12700,12703,5,5,2);
INSERT INTO `creature_formations` VALUES 
(12695,12695,40,360,2),
(12695,12688,5,1,2),
(12695,12696,5,2,2),
(12695,12704,5,4,2),
(12695,12694,5,5,2);
INSERT INTO `creature_formations` VALUES 
(12663,12663,40,360,2),
(12663,12661,40,360,2),
(12663,12662,40,360,2),
(12663,12660,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12627,12627,40,360,2),
(12627,12628,40,360,2),
(12627,12631,40,360,2),
(12627,12632,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12619,12619,40,360,2),
(12619,12620,40,360,2),
(12619,12621,40,360,2),
(12619,12622,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12616,12616,40,360,2),
(12616,12618,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12629,12629,40,360,2),
(12629,12591,40,360,2),
(12629,12630,40,360,2),
(12629,12633,40,360,2),
(12629,12635,40,360,2),
(12629,12592,40,360,2),
(12629,12593,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12584,12584,40,360,2),
(12584,12587,40,360,2),
(12584,12585,40,360,2),
(12584,12586,40,360,2),
(12584,12634,40,360,2),
(12584,12608,40,360,2),
(12584,12609,40,360,2),
(12584,12610,40,360,2),
(12584,12612,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12636,12636,40,360,2),
(12636,12637,40,360,2),
(12636,12638,40,360,2),
(12636,12615,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12641,12641,40,360,2),
(12641,12642,40,360,2),
(12641,12643,40,360,2),
(12641,12614,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12649,12649,40,360,2),
(12649,12650,40,360,2),
(12649,12651,40,360,2),
(12649,12652,40,360,2);
INSERT INTO `creature_formations` VALUES 
(12646,12646,40,360,2),
(12646,12647,40,360,2),
(12646,12648,40,360,2),
(12646,12653,40,360,2);

DELETE FROM `waypoint_data` WHERE `id` IN (126240,126250,126260);
UPDATE `creature` SET `MovementType`='2' WHERE `guid` IN ('12624');
SET @NPC := 12624;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-91.3785,-333.8914,-7.7673,0,0,0,0,0),
(@PATH,2,-89.9023,-288.1805,-7.7673,0,0,0,0,0),
(@PATH,3,-91.3785,-333.8914,-7.7673,0,0,0,0,0),
(@PATH,4,-92.2922,-377.9305,-7.7673,0,0,0,0,0); 

SET @NPC := 1741;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,35.5512,-299.6387,-10.2368,0,0,0,0,0),
(@PATH,2,30.4756,-287.1654,-16.2907,0,0,0,0,0),
(@PATH,3,28.2474,-270.8317,-22.7606,0,0,0,0,0),
(@PATH,4,30.4756,-287.1654,-16.2907,0,0,0,0,0),
(@PATH,5,35.5512,-299.6387,-10.2368,0,0,0,0,0),
(@PATH,6,50.7598,-307.0406,-8.2670,0,0,0,0,0);

SET @NPC := 12716;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-0.0599,-127.2395,-20.0795,0,0,0,0,0),
(@PATH,2,-19.7878,-121.7839,-22.2396,0,0,0,0,0);

SET @NPC := 1550;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-12.9851,-189.2772,-22.7799,0,0,0,0,0),
(@PATH,2,-7.0073,-181.1557,-23.4808,0,0,0,0,0),
(@PATH,3,-12.9851,-189.2772,-22.7799,0,0,0,0,0),
(@PATH,4,-30.1536,-190.2982,-20.3857,0,0,0,0,0);

SET @NPC := 42492;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,25.3680,-235.2199,-22.5675,0,0,0,0,0),
(@PATH,2,45.3809,-229.7579,-22.6131,0,0,0,0,0);


SET @NPC := 42440;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,18.5333,-204.9412,-22.3882,0,0,0,0,0),
(@PATH,2,20.1530,-212.7591,-22.5006,0,0,0,0,0), 
(@PATH,3,18.5333,-204.9412,-22.3882,0,0,0,0,0),
(@PATH,4,6.3134,-198.6056,-22.4149,0,0,0,0,0);

SET @NPC := 299;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,4.0809,-241.2227,-21.9188,0,0,0,0,0),
(@PATH,2,12.8337,-256.1345,-21.8768,0,0,0,0,0);

SET @NPC := 1561;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-78.2618,-233.3967,-19.0738,0,0,0,0,0),  
(@PATH,2,-62.7014,-220.6495,-18.5730,0,0,0,0,0),
(@PATH,3,-46.1952,-214.9539,-18.5513,5000,0,0,0,0),
(@PATH,4,-62.7014,-220.6495,-18.5730,0,0,0,0,0),
(@PATH,5,-78.2618,-233.3967,-19.0738,0,0,0,0,0),  
(@PATH,6,-90.4510,-257.7790,-11.7885,0,0,0,0,0),
(@PATH,7,-90.4720,-265.1724,-9.5625,0,0,0,0,0),
(@PATH,8,-91.9829,-255.4900,-12.5682,0,0,0,0,0); 

SET @NPC := 12587;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-234.9901,-204.9100,-8.0766,0,0,0,0,0), 
(@PATH,2,-235.0330,-198.5261,-8.0272,0,0,0,0,0),
(@PATH,3,-234.9901,-204.9100,-8.0766,0,0,0,0,0), 
(@PATH,4,-233.7279,-235.8910,-7.9739,0,0,0,0,0),
(@PATH,5,-229.2011,-248.5270,-7.8836,0,0,0,0,0),
(@PATH,6,-217.7293,-255.9783,-7.9923,0,0,0,0,0),
(@PATH,7,-207.1499,-258.4804,-8.0811,5000,0,0,0,0),
(@PATH,8,-217.7293,-255.9783,-7.9923,0,0,0,0,0),
(@PATH,9,-229.2011,-248.5270,-7.8836,0,0,0,0,0),
(@PATH,10,-233.7279,-235.8910,-7.9739,0,0,0,0,0);

SET @NPC := 12591;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-228.8183,-264.3383,-7.8840,5000,0,0,0,0),
(@PATH,2,-213.3816,-267.5317,-8.0438,5000,0,0,0,0);
--
--
-- Mekgineer Steamrigger Stealth Detection
-- (17796,0,0,0,0,0,0,0,'18950 0 18950 1'), 
-- (20630,0,0,0,0,0,0,0,'18950 0 18950 1'), 
-- Hydromancer Thespia
-- (17797,0,0,0,0,0,0,0,'18950 0 18950 1'),
-- (20629,0,0,0,0,0,0,0,'18950 0 18950 1'),
--

--
-- chest respawn in sv
UPDATE `gameobject` SET `spawntimesecs`='43200' WHERE `guid` IN ('32635','32636','32710');
--
-- 10928 faction fix and summoning fix 
UPDATE `creature_template` SET `faction_A`='1750',`faction_H`='1750',`lootid`='0' WHERE `entry` IN ('10928'); -- 119 oder 14 10928 
UPDATE `creature_ai_scripts` SET `event_param3`='1500',`event_param4`='3500' WHERE `id` IN ('1708802');
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1708801');
INSERT INTO `creature_ai_scripts` VALUES
('1708801','17088','1','0','100','0','1000','1000','1000','1000','11','8722','0','0','0','0','0','0','0','0','0','0','Shadowy Summoner - Summon Succubus OCC');
--
-- Frayer Protector 19953,21553
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='986',`maxdmg`='1300'  WHERE `entry` IN ('19953'); --  300 614
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='2649',`maxdmg`='3033',`baseattacktime`='0'  WHERE `entry` IN ('21553'); -- 778 1353 -- 3974 - 4549
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19953','21553'); 
INSERT INTO `creature_template_addon` VALUES
(19953,0,0,512,0,4097,0,0,''),
(21553,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19953');
INSERT INTO `creature_ai_scripts` VALUES
('1995301','19953','1','0','100','6','0','0','0','0','21','1','0','0','20','0','0','0','23','1','0','0','Frayer Protector - Prevent Combat Movement and Prevent Melee and Set Phase 1 on Spawn'),
('1995302','19953','9','5','100','7','5','30','2000','3000','11','34745','4','0','40','2','0','0','0','0','0','0','Frayer Protector - Cast Shoot Thorns and Set Ranged Weapon Model (Phase 1)'),
('1995303','19953','9','5','100','7','30','80','1000','1000','21','1','1','0','20','1','0','0','0','0','0','0','Frayer Protector - Start Combat Movement and Start Melee at 30 Yards (Phase 1)'),
('1995304','19953','9','5','100','7','0','5','1000','1000','21','1','0','0','40','1','0','0','20','1','0','0','Frayer Protector - Start Combat Movement and Set Melee Weapon Model and Start Melee at 5 Yards (Phase 1)'),
('1995305','19953','9','5','100','7','6','25','1000','1000','21','1','1','0','20','0','0','0','0','0','0','0','Frayer Protector - Prevent Combat Movement and Prevent Melee at 25 Yards (Phase 1)'),
('1995306','19953','7','0','100','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Frayer Protector - Despawn on Evade');
-- White Seedling 19958,21583
UPDATE `creature_template` SET `minhealth`='981',`armor`='5800',`speed`='1.20',`mindmg`='500',`maxdmg`='506' WHERE `entry` IN ('19958'); -- 198 204
UPDATE `creature_template` SET `armor`='5800',`mindmg`='1108',`maxdmg`='1393',`baseattacktime`='0' WHERE `entry` IN ('21583'); -- 255 683 -- 1,662 - 2,090
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19958','21583'); 
INSERT INTO `creature_template_addon` VALUES
(19958,0,0,512,0,4097,0,0,'7940 0'),
(21583,0,0,512,0,4097,0,0,'7940 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19958');
INSERT INTO `creature_ai_scripts` VALUES
('1995801','19958','9','0','100','7','0','5','500','500','11','34752','1','32','13','-50','1','0','0','0','0','0','White Seedling - Cast Freezing Touch'),
('1995802','19958','7','0','100','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','White Seedling - Despawn on Evade');
--
-- Red Seedling 19964 21566
UPDATE `creature_template` SET `minhealth`='1014',`maxhealth`='1415',`armor`='5800',`speed`='1.20',`mindmg`='500',`maxdmg`='506' WHERE `entry` IN ('19964'); -- 198 204
UPDATE `creature_template` SET `armor`='5800',`mindmg`='1108',`maxdmg`='1393',`baseattacktime`='0' WHERE `entry` IN ('21566'); -- 255 683
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19964','21566'); 
INSERT INTO `creature_template_addon` VALUES
(19964,0,0,512,0,4097,0,0,'7942 0'),
(21566,0,0,512,0,4097,0,0,'7942 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19964');
INSERT INTO `creature_ai_scripts` VALUES
('1996401','19964','9','0','100','7','0','20','2000','4000','11','36339','1','0','0','0','0','0','0','0','0','0','Red Seedling - Cast Fire Blast'),
('1996402','19964','7','0','100','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Red Seedling - Despawn on Evade');
--
-- Green Seedling 19969 21557
UPDATE `creature_template` SET `minhealth`='1014',`maxhealth`='1415',`armor`='5800',`speed`='1.20',`mindmg`='500',`maxdmg`='506' WHERE `entry` IN ('19969'); -- 198 204
UPDATE `creature_template` SET `armor`='5800',`mindmg`='1108',`maxdmg`='1393',`baseattacktime`='0' WHERE `entry` IN ('21557'); -- 255 683
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19969','21557'); 
INSERT INTO `creature_template_addon` VALUES
(19969,0,0,512,0,4097,0,0,'7941 0'),
(21557,0,0,512,0,4097,0,0,'7941 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19969');
INSERT INTO `creature_ai_scripts` VALUES
('1996901','19969','11','0','100','6','0','0','0','0','11','34757','0','7','0','0','0','0','0','0','0','0','Green Seedling - Cast Toxic Pollen on Spawn'),
('1996902','19969','7','0','100','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Green Seedling - Despawn on Evade');
--
-- Blue Seedling 19962,21550
UPDATE `creature_template` SET `minhealth`='981',`maxhealth`='1415',`armor`='5800',`speed`='1.20',`mindmg`='500',`maxdmg`='506' WHERE `entry` IN ('19962'); -- 198 204
UPDATE `creature_template` SET `armor`='5800',`mindmg`='1108',`maxdmg`='1393',`baseattacktime`='0' WHERE `entry` IN ('21550'); -- 255 683
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19962','21550'); 
INSERT INTO `creature_template_addon` VALUES
(19962,0,0,512,0,4097,0,0,'34184 0'),
(21550,0,0,512,0,4097,0,0,'34184 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19962');
INSERT INTO `creature_ai_scripts` VALUES
('1996201','19962','9','0','100','7','0','10','500','500','11','34782','1','0','13','-50','1','0','0','0','0','0','Blue Seedling - Cast Bind Feet'),
('1996202','19962','7','0','100','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Blue Seedling - Despawn on Evade');
-- Boulderfist Mystic 
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('17135');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17135');
INSERT INTO `creature_ai_scripts` VALUES
(1713501,17135,13,0,100,1,8000,12000,0,0,11,13281,1,0,0,0,0,0,0,0,0,0,'Boulderfist Mystic - Cast Earth Shock on Target Spellcasting'),
(1713502,17135,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Boulderfist Mystic - Start Combat Movement on Aggro'),
(1713503,17135,4,0,100,0,0,0,0,0,11,9532,1,0,22,1,0,0,0,0,0,0,'Boulderfist Mystic - Cast Lighting Bolt and Set Phase 1 on Aggro'),
(1713504,17135,0,13,100,1,3000,4000,3000,4000,0,0,0,0,11,9532,1,0,0,0,0,0,'Boulderfist Mystic - Cast Lighting Bolt (Phase 1)'),
(1713505,17135,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Boulderfist Mystic - Start Movement and Set Phase 2 when Mana is at 15%'),
(1713506,17135,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Boulderfist Mystic - Start Movement Beyond 25 Yards'),
(1713507,17135,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Boulderfist Mystic - Set Phase 1 when Mana is above 30% (Phase 2)'),
(1713508,17135,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Boulderfist Mystic - Set Phase 3 at 15% HP'),
(1713509,17135,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Boulderfist Mystic - Start Movement and Flee at 15% HP (Phase 3)'),
(1713510,17135,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Boulderfist Mystic - On Evade set Phase to 0'),
(1713511,17135,2,0,100,1,25,0,15300,22900,11,11431,0,1,0,0,0,0,0,0,0,0,'Boulderfist Mystic - Cast Healing Touch When Below 25% HP');
