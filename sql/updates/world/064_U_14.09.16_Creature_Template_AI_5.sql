-- HG / 2
UPDATE `creature_template` SET `mindmg`='226',`maxdmg`='294',`mechanic_immune_mask`='1' WHERE `entry` = 17429; -- 140 276 -- 452 - 588

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '20555';
INSERT INTO `creature_ai_scripts` VALUES
(2055501,20555,9,0,100,1,0,40,8000,16000,11,38783,1,0,0,0,0,0,0,0,0,0,'Goc - Casts Boulder Volley on Aggro'),
(2055502,20555,0,0,100,1,6000,6000,14000,15000,11,38784,0,7,11,38785,0,7,0,0,0,0,'Goc - Casts Ground Smash'),
(2055503,20555,1,0,100,1,30000,30000,1000,1000,41,0,0,0,0,0,0,0,0,0,0,0,'Goc  - Despawn OOC');

-- 100 % flee
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('22134');
UPDATE `creature_template_addon` SET `auras`='18950 0 18950 1' WHERE `entry` IN ('22134');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22134');
INSERT INTO `creature_ai_scripts` VALUES
('2213401','22134','4','0','100','7','0','0','0','0','25','0','0','0','1','-48','0','0','0','0','0','0','Shadowmoon Eye of Kilrogg - Flee and Emote on Aggro');

-- Witness of Doom
UPDATE `creature_template` SET `speed`='1.71',`AIName`='EventAI' WHERE `entry` = 22282;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '22282';
INSERT INTO `creature_ai_scripts` VALUES
('2228201','22282','4','0','100','0','0','0','0','0','25','0','0','0','1','-48','0','0','0','0','0','0','Witness of Doom - Flee and Emote on Aggro'),
('2228202','22282','0','0','100','1','10000','10000','1000','1000','41','0','0','0','0','0','0','0','0','0','0','0','Witness of Doom - Despawn IC'),
(2228203,22282,6,0,100,0,0,0,0,0,11,40828,0,3,0,0,0,0,0,0,0,0,'Banished - Cast Credit on Master on Death');

-- Captain Alina 17290
UPDATE `creature_template` SET `faction_A`='1737',`faction_H`='1737' WHERE `entry` = 17290; -- 1666

-- Lair Brute - Schläger des Unterschlupfs
UPDATE `creature_template` SET `minhealth`='298298',`maxhealth`='298298',`armor`='7400',`speed`='1.48',`mindmg`='11000',`maxdmg`='12850',`baseattacktime`='1400',`mechanic_immune_mask`=617299827 WHERE `entry` = 19389; -- 298298 ba 1400 -- 4259 5159 -- 12257 12857 -- 14709 15429 -- 18,386 - 19,286
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` = 19389;
INSERT INTO `creature_ai_scripts` VALUES
('1938901','19389','4','0','100','2','0','0','0','0','30','1','2','3','0','0','0','0','0','0','0','0','Lair Brute - Random Phase on Aggro'),
('1938902','19389','9','13','100','3','0','5','8000','12000','11','39171','1','1','30','1','2','3','0','0','0','0','Lair Brute - Cast Mortal Strike and Select Random Phase (Phase 1)'),
('1938903','19389','9','11','100','3','0','5','6000','8000','11','39174','1','1','30','1','2','3','0','0','0','0','Lair Brute - Cast Cleave and Select Random Phase (Phase 2)'),
('1938904','19389','9','7','100','3','8','25','11000','18000','11','24193','5','1','30','1','2','3','14','-99','0','0','Lair Brute - Cast Charge and Select Random Phase (Phase 3)'),
('1938905','19389','2','0','100','2','15','0','0','0','39','90','0','0','1','-551','0','0','0','0','0','0','Lair Brute - Call for Help and and Text Emote at 15% HP');

-- Spectral Retainer -- one hand sword
-- http://www.wowhead.com/npc=16410/spectral-retainer#screenshots:id=47157
UPDATE `creature_template` SET `modelid_A2`='16511',`modelid_H2`='16511',`armor`='7400',`speed`='1.38',`mechanic_immune_mask`='8917521',`flags_extra`='65536',`equipment_id`='1' WHERE `entry` = 16410;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16410;
INSERT INTO `creature_ai_scripts` VALUES
('1641001','16410','9','0','100','3','0','5','6000','12000','11','29578','4','32','0','0','0','0','0','0','0','0','Spectral Retainer - Cast Rend'),
('1641002','16410','0','0','100','3','9000','13000','18000','22000','11','29546','5','1','0','0','0','0','0','0','0','0','Spectral Retainer - Cast Oath of Fealty'),
('1641003','16410','4','0','50','2','0','0','0','0','1','-9968','-9967','0','0','0','0','0','0','0','0','0','Spectral Retainer - Random Say on Aggro'),
('1641004','16410','6','0','20','2','0','0','0','0','1','-9969','0','0','0','0','0','0','0','0','0','0','Spectral Retainer - Say on Death'),
('1641005','16410','0','0','100','3','13000','15000','22000','22000','11','32375','4','1','0','0','0','0','0','0','0','0','Spectral Retainer - Cast Massdespell');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16411;
INSERT INTO `creature_ai_scripts` VALUES
('1641101','16411','0','0','100','3','4000','8000','5000','10000','11','29665','1','0','0','0','0','0','0','0','0','0','Spectral Chef - Cast Cleave'),
('1641102','16411','9','0','100','3','0','5','8000','12000','11','29667','1','1','0','0','0','0','0','0','0','0','Spectral Chef - Cast Hamstring'),
('1641103','16411','4','0','50','2','0','0','0','0','1','-9829','-9828','-9827','0','0','0','0','0','0','0','0','Spectral Chef - Random Say on Aggro'),
('1641104','16411','6','0','20','2','0','0','0','0','1','-9962','-9961','-9960','0','0','0','0','0','0','0','0','Spectral Chef - Say on Death');

-- Fel Overseer 18796,20652
UPDATE `creature` SET `spawndist`='0' WHERE `id` = 18796;
UPDATE `creature_template` SET `mechanic_immune_mask`='4325377',`mindmg`='969',`maxdmg`='1324' WHERE `entry` = 18796; -- 382 666 -- 775 - 1,059
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18796',`equipment_id`='1075',`mechanic_immune_mask`='4325377',`mindmg`='6567',`maxdmg`='7164' WHERE `entry` = 20652; -- 1773 2519 -- 4105 4478 -- 8,209 - 8,955
DELETE FROM `creature_template_addon` WHERE `entry` IN (18796,20652);
INSERT INTO `creature_template_addon` VALUES
(18796,0,0,16908544,0,4097,0,0,''),
(20652,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18796;
INSERT INTO `creature_ai_scripts` VALUES
('1879601','18796','4','0','5','6','0','0','0','0','1','-9983','-9982','-9959','0','0','0','0','1','0','0','0','Fel Overseer - Random Say on Aggro'),
('1879602','18796','9','0','100','7','0','25','15000','15000','11','27577','4','0','0','0','0','0','0','0','0','0','Fel Overseer - Cast Intercept on Aggro Range 25'),
('1879603','18796','0','0','100','7','9000','12000','9000','15000','11','30471','1','0','0','0','0','0','0','0','0','0','Fel Overseer - Cast Uppercut'),
('1879604','18796','9','0','100','5','0','5','8000','12000','11','16856','1','0','0','0','0','0','0','0','0','0','Fel Overseer (Heroic) - Cast Mortal Strike'),
('1879605','18796','0','0','100','7','30000','30000','30000','30000','11','19134','1','1','0','0','0','0','0','0','0','0','Fel Overseer (Heroic) - Cast Frightening Shout every 30 Secs'),
('1879606','18796','6','0','20','6','0','0','0','0','1','-9958','-9957','-9981','0','0','0','0','0','0','0','0','Fel Overseer - Say on Death');

-- Malicious Instructor 18848,20656
UPDATE `creature` SET `spawndist`='0' WHERE `id` IN ('18848');
UPDATE `creature_template` SET `maxlevel`='70',`mechanic_immune_mask`='4325377',`armor`='6800',`mindmg`='824',`maxdmg`='1113' WHERE `entry` IN ('18848'); -- 427 716
UPDATE `creature_template` SET `minlevel`='71',`armor`='7100',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18848',`equipment_id`='1676',`mechanic_immune_mask`='4325377',`mindmg`='3601',`maxdmg`='4274' WHERE `entry` IN ('20656'); -- 972 1982 -- 2701 3206 -- 5,401 - 6,411
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18848','20656');
INSERT INTO `creature_template_addon` VALUES
(18848,0,0,66048,0,4097,0,0,''),
(20656,0,0,66048,0,4097,0,0,'');   
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18848');
INSERT INTO `creature_ai_scripts` VALUES
(1884801,18848,4,0,10,7,0,0,0,0,1,-9999,-9980,-9958,0,0,0,0,0,0,0,0,'Malicious Instructor - Say on Aggro'),
(1884802,18848,0,0,100,7,5400,5400,12000,12000,11,33493,1,32,20,1,0,0,0,0,0,0,'Malicious Instructor - Cast Mark of Malice & Start Autoattack again'),
(1884803,18848,0,0,100,7,7000,7000,12000,12000,11,33501,0,0,0,0,0,0,0,0,0,0,'Malicious Instructor - Cast Shadow Nova'),
(1884804,18848,0,0,100,9,0,5,10000,20000,11,6713,1,0,0,0,0,0,0,0,0,0,'Malicious Instructor - Cast Disarm HC Only'),
(1884805,18848,4,0,100,7,0,0,0,0,11,29651,0,0,0,0,0,0,0,0,0,0,'Malicious Instructor - Cast Dual Wield on Aggro'),
(1884806,18848,6,0,20,6,0,0,0,0,1,-9959,-9958,-9981,0,0,0,0,0,0,0,0,'Malicious Instructor - Say on Death');

-- Sethekk Spirit 18703,20700
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`speed`='1',`mechanic_immune_mask`='653230079',`unit_flags`='33554688',`flags_extra`='1048576',`speed`='1' WHERE `entry` = 18703;
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`speed`='1',`mechanic_immune_mask`='653230079',`unit_flags`='33554688',`flags_extra`='1048576',`mindmg`='3825',`maxdmg`='4758',`speed`='1' WHERE `entry` = 20700; -- 2000 3000 -- 5,737 - 7,137
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18703;
INSERT INTO `creature_ai_scripts` VALUES
('1870301','18703','11','0','100','6','0','0','0','0','11','24051','0','7','0','0','0','0','0','0','0','0','Sethekk Spirit - Cast Spirit Burst on Spawn');

-- Time-Lost Controller 18327,20691
-- Immune to CC 
UPDATE `creature_template` SET `armor`='5200',`mechanic_immune_mask`='13111315' WHERE `entry` = 18327; -- kleiner gebogener Holzstock wie die Furbolgs
UPDATE `creature_template` SET `armor`='5950',`minmana`='35980',`maxmana`='35980',`speed`='1.48',`lootid`='18327',`mindmg`='1181',`maxdmg`='1421',`mechanic_immune_mask`='13111315' WHERE `entry` = 20691; -- 411 890
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18327;
INSERT INTO `creature_ai_scripts` VALUES
('1832701','18327','4','0','15','7','0','0','0','0','1','-1240','-1241','-1244','0','0','0','0','0','0','0','0','Time-Lost Controller - Random Say on Aggro'),
('1832702','18327','9','0','100','7','0','5','17800','28300','12','20343','0','30000','0','0','0','0','0','0','0','0','Time-Lost Controller - Summon Charming Totem'), -- spell 32764 bugged
('1832703','18327','9','0','100','7','0','15','10000','15000','11','35013','4','32','0','0','0','0','0','0','0','0','Time-Lost Controller - Cast Shrink'),
('1832705','18327','1','0','100','7','1000','1000','900000','900000','11','32689','0','1','0','0','0','0','0','0','0','0','Time-Lost Controller - Cast Arcane Destruction OCC'),
('1832706','18327','0','0','100','7','10000','10000','5000','5000','11','32689','0','32','0','0','0','0','0','0','0','0','Time-Lost Scryer - Cast Arcane Destruction on Missing Arcane Destruction Aura');

-- Charming Totem 20343,20687
UPDATE `creature_template` SET `minlevel`='67',`maxlevel`='67',`minhealth`='2000',`maxhealth`='2000',`faction_A`='16',`faction_H`='16',`armor`='0',`speed`='0',`mindmg`='0',`maxdmg`='0',`unit_flags`='131072',`resistance5`='-1',`mechanic_immune_mask`='1073741823',`flags_extra`='196732' WHERE `entry` = 20343;
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`minhealth`='5000',`maxhealth`='5000',`faction_A`='16',`faction_H`='16',`speed`='0',`mindmg`='0',`maxdmg`='0',`unit_flags`='131072',`resistance5`='-1',`mechanic_immune_mask`='1073741823',`flags_extra`='196732' WHERE `entry` = 20687;
DELETE FROM `creature_template_addon` WHERE `entry` IN (20343,20687); 
INSERT INTO `creature_template_addon` VALUES
(20343,0,0,0,0,0,0,0,''),
(20687,0,0,0,0,0,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20343;
INSERT INTO `creature_ai_scripts` VALUES
('2034301','20343','0','0','100','7','2500','4500','15000','15000','11','37122','4','7','20','0','0','0','21','0','0','0','Charming Totem - Cast Charm and Stop Melee and Stop Movement on Aggro'), -- 
('2034302','20343','1','0','100','7','15000','15000','1000','1000','41','0','0','0','0','0','0','0','0','0','0','0','Charming Totem - Despawn OOC');

UPDATE `quest_template` SET `RewRepValue1`='0' WHERE `entry` = 16;

-- Bleeding Hollow Archer
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17270;
INSERT INTO `creature_ai_scripts` VALUES
('1727001','17270','4','0','10','6','0','0','0','0','1','-158','-160','-157','0','0','0','0','0','0','0','0','Bleeding Hollow Archer - Random Say on Aggro'), -- -156','-181','-672'=160
('1727002','17270','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Bleeding Hollow Archer - Start Movement and Set Melee Weapon Model'),
('1727003','17270','9','0','100','7','5','30','2300','4000','11','18651','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer - Cast Multi Shot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727004','17270','9','0','100','3','5','30','2300','5000','11','18651','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Normal) - Cast Multi Shot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727005','17270','9','0','100','5','5','30','2300','5000','11','31942','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Heroic) - Cast Multi Shot and Set Ranged Weapon Model and Stop Movement'),
('1727006','17270','0','0','100','7','12100','15300','13300','18200','11','30614','4','1','40','2','0','0','21','0','0','0','Bleeding Hollow Archer - Cast Aimed Shot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727007','17270','9','0','50','3','5','30','2000','5000','11','15620','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Normal) - Cast Shoot and Set Ranged Weapon Model and Stop Movement'),
-- ('1727008','17270','9','0','50','5','5','30','2000','5000','11','22907','1','0','40','2','0','0','21','0','0','0','Bleeding Hollow Archer (Heroic) - Cast Shoot and Set Ranged Weapon Model and Stop Movement'),
('1727009','17270','9','0','100','6','0','5','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Bleeding Hollow Archer - Start Movement and Set Melee Weapon Model Below 6 Yards'),
('1727010','17270','9','0','100','6','6','15','0','0','21','0','0','0','40','2','0','0','0','0','0','0','Bleeding Hollow Archer - Stop Movement and Set Ranged Weapon Model Above 5 Yards');

-- Start Pool Spawning for Arcane Vortex/Felmist/Swamp Gas/Windy Cloud
UPDATE `pool_template` SET `max_limit`='10' WHERE `entry` IN (30043,30044,30045,30046);

-- Shadowmoon Valley Tuber Node
UPDATE `creature` SET `MovementType`='0',`spawndist`='0' WHERE `id` = 21347;
-- UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'' WHERE `entry` = 21347;

-- Anveena
UPDATE `creature_template` SET `InhabitType` = 5, `MovementType`='0' WHERE `entry` = 26046;
DELETE FROM `creature_template_addon` WHERE `entry` = 26046;
INSERT INTO `creature_template_addon` VALUES
(26046,0,0,0,0,0,0,33554432,'');

-- Skettis - Invis Raven Stone 22986
UPDATE `creature_template` SET `unit_flags`='33554432',`flags_extra`='130' WHERE `entry` = 22986; -- 0 2

-- Invis Infernal Caster 21417
UPDATE `creature` SET `position_x`='-4000.7719', `position_y`='1970.2165', `position_z`='110.0740' WHERE `guid` = '74987';
UPDATE `creature_template` SET `InhabitType`='7' WHERE `entry` = '21417'; -- ,`AIName`='EventAI'
-- DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21417';
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('2141701','21417','10','0','100','1','1','50','48000','48000','11','5739','6','39','0','0','0','0','0','0','0','0','Invis Infernal Caster - Cast Meteor Strike Infernal OOC LOS');

-- Black Blood of Draenor 23286
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`AIName`='EventAI' WHERE `entry` = '23286';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '23286';
INSERT INTO `creature_ai_scripts` VALUES
('2328601','23286','0','0','100','1','6000','12000','15000','20000','11','40818','0','0','0','0','0','0','0','0','0','0','Black Blood of Draenor - Cast Toxic Slime'),
('2328602','23286','2','0','100','0','40','0','0','0','11','7279','1','1','25','0','0','0','0','0','0','0','Black Blood of Draenor - Cast Black Sludge and Flee at 40% HP');

-- Earthmender Wilda Trigger 21041
UPDATE `creature_template` SET `flags_extra`='130' WHERE `entry` = 21041;

-- Enraged Fire Spirit 21061
UPDATE `creature_template` SET `dmgschool`='2',`inhabittype`='3',`resistance2`='-1' WHERE `entry` = 21061;

-- Enraged Earth Spirit 21050
UPDATE `creature_template` SET `resistance3`='-1' WHERE `entry` = 21050;

-- Lady Sinestra 23283
UPDATE `creature_template` SET `flags_extra`='130' WHERE `entry` = 23283; -- 2

-- Gan'arg Technician
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`AIName`='EventAI' WHERE `entry` = '21960';
-- DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21960';
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('2196001','21960','1','0','40','1','2000','20000','35000','60000','11','38053','0','0','0','0','0','0','0','0','0','0','Gan\'arg Technician - Cast Tune Deathforge Infernal OOC');

-- Cataclysm Overseer 21961
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16' WHERE `entry` = '21961';

-- Captured Water Spirit 21029
UPDATE `creature_template` SET `InhabitType`='7' WHERE `entry` = 21029;

-- Orb Target
UPDATE `creature_template` SET `modelid_H`='11686' WHERE `entry` = 25640; -- 1126

-- Hellfire Warder – Höllenfeuerwärter 18829
UPDATE `creature_template` SET `modelid_A2`='11438',`modelid_H2`='11440',`minlevel`='73',`maxlevel`='73',`rank`='3',`mindmg`='7847',`maxdmg`='9315',`baseattacktime`='2000',`speed`='1.48',`mechanic_immune_mask`='646004723' WHERE `entry` = 18829; -- 9417 11178 -- 11,771 - 13,973
--
-- Hellfire Channeler – Kanalisierer des Höllenfeuers 17256
UPDATE `creature_template` SET `modelid_A`='9609',`modelid_H`='9609',`modelid_A2`='9865',`modelid_H2`='9865',`mindmg`='7245',`maxdmg`='8599',`baseattacktime`='2000',`speed`='1.48',`mechanic_immune_mask`='619396859',`flags_extra`='2' WHERE `entry` = 17256; -- 8694 10318 -- 10,867 - 12,898
--
-- Burning Abyssal - Brennender Abyss 17454
UPDATE `creature_template` SET `mindmg`='673',`maxdmg`='952',`baseattacktime`='2000',`speed`='1.20' WHERE `entry` = 17454; -- 807 1142 -- 1,009 - 1,428

-- Dreadwarden 19744
UPDATE `creature_template` SET `mindmg`='200',`maxdmg`='400',`baseattacktime`='1400',`armor`='4450',`AIName`='EventAI' WHERE `entry` = '19744'; -- 20 61 2000 20
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '19744';
INSERT INTO `creature_ai_scripts` VALUES
('1974401','19744','9','0','100','1','0','5','6000','12000','11','32736','1','0','0','0','0','0','0','0','0','0','Dreadwarden - Cast Mortal Strike'),
('1974402','19744','9','0','100','1','0','25','10000','12000','11','11443','4','32','0','0','0','0','0','0','0','0','Dreadwarden - Cast Cripple');

-- Illidari Jailor 21520
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '21520';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21520';
INSERT INTO `creature_ai_scripts` VALUES
('2152001','21520','9','0','100','1','0','20','14300','28200','11','38051','4','32','0','0','0','0','0','0','0','0','Illidari Jailor - Cast Fel Shackles');

-- Illidari Agonizer 19801
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '19801';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '19801';
INSERT INTO `creature_ai_scripts` VALUES
('1980101','19801','9','0','100','1','0','30','2400','4200','11','36227','1','0','0','0','0','0','0','0','0','0','Illidari Agonizer - Cast Firebolt');

-- Zandras 21827
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '21827';
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21827';
INSERT INTO `creature_ai_scripts` VALUES
('2182701','21827','9','0','100','1','0','25','10000','20000','11','38051','4','32','0','0','0','0','0','0','0','0','Illidari Jailor - Cast Fel Shackles');

-- Felboar 21878
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '21878';
INSERT INTO `creature_ai_scripts` VALUES
('2187801','21878','9','0','100','1','8','25','12000','18000','11','35570','1','0','0','0','0','0','0','0','0','0','Felboar - Cast Charge');

UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('19765','19767','19784','19788','20795','19762','19768','19789');
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` IN ('19765','19767','19784','19788','20795','19762','19768','19789');
INSERT INTO `creature_ai_scripts` (`id`,`entryOrGUID`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
--
-- Myrmidone der Echsennarbe
--
(1976501,19765,0,0,100,1,3500,5500,11500,13000,11,38027,1,0,0,0,0,0,0,0,0,0,'Coilskar Myrmidon - Cast Boiling Blood'),
--
-- Zauberhexerin der Echsennarbe
--
(1976701,19767,0,0,100,1,3500,3500,12000,16000,11,38026,0,1,0,0,0,0,0,0,0,0,'Coilskar Sorceress - Cast Viscous Shield'),
(1976702,19767,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Sorceress - Stop Movement on Aggro'),
(1976703,19767,4,0,100,0,0,0,0,0,11,32011,1,0,22,1,0,0,0,0,0,0,'Coilskar Sorceress - Cast Water Bolt and Set Phase 1 on Aggro'),
(1976704,19767,0,13,100,1,2500,4700,2500,4700,0,0,0,0,11,32011,1,0,0,0,0,0,'Coilskar Sorceress - Cast Water Bolt (Phase 1)'),
(1976705,19767,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Coilskar Sorceress - Start Movement and Set Phase 2 when Mana is at 15%'),
(1976706,19767,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Sorceress - Start Movement Beyond 25 Yards'),
(1976707,19767,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Sorceress - Set Phase 1 when Mana is above 30% (Phase 2)'),
(1976708,19767,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Coilskar Sorceress - Set Phase 3 at 15% HP'),
(1976709,19767,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Coilskar Sorceress- Start Movement and Flee at 15% HP (Phase 3)'),
(1976710,19767,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Coilskar Sorceress - On Evade set Phase to 0'),
--
-- Kobra der Echsennarbe
--
(1978401,19784,0,0,100,1,3500,5500,10000,12000,11,38030,1,3,0,0,0,0,0,0,0,0,'Coilskar Cobra - Cast Poison Spit'),
--
-- Matschbehüter der Echsennarbe
--
(1978801,19788,4,0,100,0,0,0,0,0,11,38232,0,0,0,0,0,0,0,0,0,0,'Coilskar Muckwatcher - Cast Battle Shout on Aggro'),
(1978802,19788,0,0,100,1,5000,6000,8000,12000,11,38029,1,0,0,0,0,0,0,0,0,0,'Coilskar Muckwatcher - Cast Stab'),
--
-- Bewahrerin der Zisterne
--
(2079501,20795,9,0,100,1,0,8,16500,16500,11,11831,0,3,0,0,0,0,0,0,0,0,'Keeper of the Cistern - Casts Frost Nova'),
(2079502,20795,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Keeper of the Cistern - Stop Movement on Aggro'),
(2079503,20795,4,0,100,0,0,0,0,0,11,32011,1,0,22,1,0,0,0,0,0,0,'Keeper of the Cistern - Cast Water Bolt and Set Phase 1 on Aggro'),
(2079504,20795,0,13,100,1,2500,4700,2500,4700,0,0,0,0,11,32011,1,0,0,0,0,0,'Keeper of the Cistern - Cast Water Bolt (Phase 1)'),
(2079505,20795,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Keeper of the Cistern - Start Movement and Set Phase 2 when Mana is at 15%'),
(2079506,20795,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Keeper of the Cistern - Start Movement Beyond 25 Yards'),
(2079507,20795,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Keeper of the Cistern - Set Phase 1 when Mana is above 30% (Phase 2)'),
(2079508,20795,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Keeper of the Cistern - Set Phase 3 at 15% HP'),
(2079509,20795,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Keeper of the Cistern - Start Movement and Flee at 15% HP (Phase 3)'),
(2079510,20795,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Keeper of the Cistern - On Evade set Phase to 0'),
--
-- Verteidiger der Echsennarbe
--
(1976201,19762,0,0,100,1,3500,5500,10000,12000,11,38233,1,0,0,0,0,0,0,0,0,0,'Coilskar Defender - Cast Shield Bash'),
(1976202,19762,0,0,100,1,6000,6000,14000,16000,11,38031,0,1,0,0,0,0,0,0,0,0,'Coilskar Defender - Cast Shield Block'),
--
-- Sirene der Echsennarbe
--
(1976801,19768,0,0,100,1,3500,3500,12000,16000,11,38026,0,1,0,0,0,0,0,0,0,0,'Coilskar Siren - Cast Viscous Shield'),
(1976802,19768,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Siren - Stop Movement on Aggro'),
(1976803,19768,4,0,100,0,0,0,0,0,11,32011,1,0,22,1,0,0,0,0,0,0,'Coilskar Siren - Cast Water Bolt and Set Phase 1 on Aggro'),
(1976804,19768,0,13,100,1,2500,4700,2500,4700,0,0,0,0,11,32011,1,0,0,0,0,0,'Coilskar Siren - Cast Water Bolt (Phase 1)'),
(1976805,19768,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Coilskar Siren - Start Movement and Set Phase 2 when Mana is at 15%'),
(1976806,19768,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Siren - Start Movement Beyond 25 Yards'),
(1976807,19768,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Siren - Set Phase 1 when Mana is above 30% (Phase 2)'),
(1976808,19768,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Coilskar Siren - Set Phase 3 at 15% HP'),
(1976809,19768,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Coilskar Siren- Start Movement and Flee at 15% HP (Phase 3)'),
(1976810,19768,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Coilskar Siren - On Evade set Phase to 0'),
--
-- Wasserbewahrer der Echsennarbe
--
(1978901,19789,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Waterkeeper - Stop Movement on Aggro'),
(1978902,19789,4,0,100,0,0,0,0,0,11,9672,1,0,22,1,0,0,0,0,0,0,'Coilskar Waterkeeper - Cast Frostbolt and Set Phase 1 on Aggro'),
(1978903,19789,0,13,100,1,3000,4700,3000,4700,0,0,0,0,11,9672,1,0,0,0,0,0,'Coilskar Waterkeeper - Cast Frostbolt (Phase 1)'),
(1978904,19789,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Coilskar Waterkeeper - Start Movement and Set Phase 2 when Mana is at 15%'),
(1978905,19789,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Waterkeeper - Start Movement Beyond 25 Yards'),
(1978906,19789,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Coilskar Waterkeeper - Set Phase 1 when Mana is above 30% (Phase 2)'),
(1978907,19789,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Coilskar Waterkeeper - Set Phase 3 at 15% HP'),
(1978908,19789,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Coilskar Waterkeeper - Start Movement and Flee at 15% HP (Phase 3)'),
(1978909,19789,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Coilskar Waterkeeper - On Evade set Phase to 0'),
(1978910,19789,0,0,100,1,3500,3500,16500,16500,11,38033,0,3,0,0,0,0,0,0,0,0,'Coilskar Waterkeeper - Cast Frost Nova');

UPDATE `creature_template` SET `unit_flags` = '32768', `flags_extra` = '0' WHERE `entry` = '19762';

DELETE FROM `creature` WHERE `guid` IN (7202,13050,14324,14325,14326,14327,14328,14329,14330,14331,14332);
INSERT INTO `creature` VALUES (7202, 24222, 530, 1, 0, 0, -972.757, 7128.15, 38.0172, 3.71719, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (13050, 24222, 530, 1, 0, 0, -1656.4874, 7832.0927, 165.8362, 5.40165, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14324, 24222, 530, 1, 0, 0, -1154.5211, 9099.8828, 45.8203, 0.3151, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14325, 24222, 530, 1, 0, 0, -938.6796, 8430.3417, 36.8891, 5.0903, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14326, 24222, 530, 1, 0, 0, -2043.8065, 6653.2592, 13.0542, 0.4565, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14327, 24222, 530, 1, 0, 0, -2395.3466, 7609.8627, -9.0757, 0.9042, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14328, 24222, 530, 1, 0, 0, -791.5836, 7289.8925, 42.2148, 6, 14400, 2700, 40, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14329, 24222, 530, 1, 0, 0, -3320.9396, 6765.3774, 73.3736, 0.7260, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14330, 24222, 530, 1, 0, 0, -1571.5057, 6438.2226, 30.9567, 5.3952, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14331, 24222, 530, 1, 0, 0, -2229.7739, 7790.0063, 150.5184, 0.2626, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14332, 24222, 530, 1, 0, 0, -1770.4216, 8535.1357, 197.1517, 5.6897, 2700, 40, 0, 1, 0, 0, 1);

DELETE FROM `creature` WHERE `guid` BETWEEN 140601 AND 140622;
-- 32 Windy Cloud Spawns
SET @GUID := 140601;
INSERT INTO `creature` VALUES (@GUID := @GUID + 0, 24222, 530, 1, 0, 0, -1533.7329, 6369.8935, 77.6436, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1880.1965, 6415.6181, 51.1248, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1666.3409, 6767.5034, -7.6006, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1412.7789, 6872.9023, 22.0742, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -558.2117, 8848.8232, 307.7323, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1037.4024, 8959.2158, 98.4896, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1541.7697, 9476.0996, 477.0890, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1863.4951, 9053.9423, 72.3042, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -2755.5195, 8960.7558, 14.9967, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1274.0355, 9965.7451, 276.0653, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1909.5537, 7905.9433, 61.3013, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -2367.1943, 7202.4086, 43.9668, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1661.2734, 8545.5673, -14.7632, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -2070.9245, 6541.8271, 20.3846, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -2803.8540, 6583.5644, 35.5174, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -2522.1479, 6416.3344, 203.8655, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1931.3232, 8855.9765, 31.6673, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1928.3510, 9085.7080, 291.5415, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1000.0269, 8885.9755, 309.1237, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -1355.4300, 6243.0019, 264.3694, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -2821.8842, 8212.4746, 202.8714, 1.337, 2700, 40, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 24222, 530, 1, 0, 0, -2499.7490, 8631.8759, 193.3694, 1.337, 2700, 40, 0, 1, 0, 0, 1);

-- Windy Clouds Respawn Ticker
UPDATE `creature` SET `spawntimesecs`='900',`spawnmask`='1' WHERE `id` = 24222; -- 3600

DELETE FROM `pool_creature` WHERE `pool_entry` = 30043;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(7202, 30043, 0, 'Windy Cloud - Nagrand'),
(9740, 30043, 0, 'Windy Cloud - Nagrand'),
(9741, 30043, 0, 'Windy Cloud - Nagrand'),
(13050, 30043, 0, 'Windy Cloud - Nagrand'),
(14241, 30043, 0, 'Windy Cloud - Nagrand'),
(14324, 30043, 0, 'Windy Cloud - Nagrand'),
(14325, 30043, 0, 'Windy Cloud - Nagrand'),
(14326, 30043, 0, 'Windy Cloud - Nagrand'),
(14327, 30043, 0, 'Windy Cloud - Nagrand'),
(14328, 30043, 0, 'Windy Cloud - Nagrand'),
(14329, 30043, 0, 'Windy Cloud - Nagrand'),
(14330, 30043, 0, 'Windy Cloud - Nagrand'),
(14331, 30043, 0, 'Windy Cloud - Nagrand'),
(14332, 30043, 0, 'Windy Cloud - Nagrand'),
(14730, 30043, 0, 'Windy Cloud - Nagrand'),
(14731, 30043, 0, 'Windy Cloud - Nagrand'),
(52399, 30043, 0, 'Windy Cloud - Nagrand'),
(52400, 30043, 0, 'Windy Cloud - Nagrand'),
(52401, 30043, 0, 'Windy Cloud - Nagrand'),
(52402, 30043, 0, 'Windy Cloud - Nagrand'),
(52403, 30043, 0, 'Windy Cloud - Nagrand'),
(52404, 30043, 0, 'Windy Cloud - Nagrand'),
(99969, 30043, 0, 'Windy Cloud - Nagrand'),
(99970, 30043, 0, 'Windy Cloud - Nagrand'),
(99971, 30043, 0, 'Windy Cloud - Nagrand'),
(99972, 30043, 0, 'Windy Cloud - Nagrand'),
(99973, 30043, 0, 'Windy Cloud - Nagrand'),
(99974, 30043, 0, 'Windy Cloud - Nagrand'),
(140601, 30043, 0, 'Windy Cloud - Nagrand'),
(140602, 30043, 0, 'Windy Cloud - Nagrand'),
(140603, 30043, 0, 'Windy Cloud - Nagrand'),
(140604, 30043, 0, 'Windy Cloud - Nagrand'),
(140605, 30043, 0, 'Windy Cloud - Nagrand'),
(140606, 30043, 0, 'Windy Cloud - Nagrand'),
(140607, 30043, 0, 'Windy Cloud - Nagrand'),
(140608, 30043, 0, 'Windy Cloud - Nagrand'),
(140609, 30043, 0, 'Windy Cloud - Nagrand'),
(140610, 30043, 0, 'Windy Cloud - Nagrand'),
(140611, 30043, 0, 'Windy Cloud - Nagrand'),
(140612, 30043, 0, 'Windy Cloud - Nagrand'),
(140613, 30043, 0, 'Windy Cloud - Nagrand'),
(140614, 30043, 0, 'Windy Cloud - Nagrand'),
(140615, 30043, 0, 'Windy Cloud - Nagrand'),
(140616, 30043, 0, 'Windy Cloud - Nagrand'),
(140617, 30043, 0, 'Windy Cloud - Nagrand'),
(140618, 30043, 0, 'Windy Cloud - Nagrand'),
(140619, 30043, 0, 'Windy Cloud - Nagrand'),
(140620, 30043, 0, 'Windy Cloud - Nagrand'),
(140621, 30043, 0, 'Windy Cloud - Nagrand'),
(140622, 30043, 0, 'Windy Cloud - Nagrand');

-- joj immunity for bosses
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|1073741824 WHERE `rank`=3;

-- Outland Herb Spawn Pools
--
-- MASTER Herbs Hellfire Peninsula zone 3483
UPDATE `pool_template` SET `max_limit`='60' WHERE `entry` IN ('972'); -- 60
-- MASTER Herbs Zangarmarsh zone 3521
UPDATE `pool_template` SET `max_limit`='95' WHERE `entry` IN ('975'); -- 95
-- MASTER Herbs Terokkar Forest zone 3519
UPDATE `pool_template` SET `max_limit`='65' WHERE `entry` IN ('977'); -- 65 
-- MASTER Herbs Nagrand zone 3518
UPDATE `pool_template` SET `max_limit`='40' WHERE `entry` IN ('973'); -- 40 
-- MASTER Herbs Blade's Edge Mountains zone 3522
UPDATE `pool_template` SET `max_limit`='35' WHERE `entry` IN ('978'); -- 35
-- MASTER Herbs Netherstorm zone 3523
UPDATE `pool_template` SET `max_limit`='40' WHERE `entry` IN ('974'); -- 40
-- MASTER Herbs Shadowmoon Valley zone 3520
UPDATE `pool_template` SET `max_limit`='45' WHERE `entry` IN ('976'); -- 45
--
--
-- new world krautz
-- Ragveil 183043 181275
-- Felweed 183044 181270
-- Dreaming Glory 183045 181271 181272
-- Blindweed 183046(tbc)
-- Flame Cap 181276
-- Terocone 181277
-- Ancient Lichen 181278 (only dungeons)
-- Netherbloom 181279(netherstorm)181282(dungeons)
-- Nightmare Vine 181280 181285
-- Mana Thistle 181281 181284(flightmount)
-- Nethercite Deposit 185877
-- Netherdust Bush 185881
-- Netherwing Egg 185915 + Netherwing Egg Trap 185600
-- SELECT * FROM `gameobject` WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881,185915,185600) AND `map`=530;
--
UPDATE `gameobject` SET `spawntimesecs`=2100,`animprogress`=100 WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881,185915,185600) AND `map`=530; -- 2700

DELETE FROM `creature_addon` WHERE `guid` = 6589096;

UPDATE `item_template` SET `BuyPrice`=40000 WHERE `entry` IN (23095,28595,23113,23106,23097,23105,23114,23100,23108,23098,23104,23099,23121,23101,23103,23116,23109,23096,23110,28290,23118,23111,23119,23120,23094,23115);

-- Val'zareq the Conqueror [1]
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
(2197910,21979,7,0,100,0,0,0,0,0,22,0,0,0,21,1,0,0,0,0,0,0,'Val\'zareq the Conqueror - Start Movement and Set Phase 0 on Evade'),
('2197911','21979','9','0','100','7','5','8','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Val\'zareq the Conqueror - Stop Combat Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

-- Item Abuse Prevention
UPDATE `item_template` SET `area`=3522 WHERE `entry` = 32696; -- 0

-- Vlagga Freyfeather 18930
UPDATE `creature_template` SET `faction_A`='1668',`faction_H`='1668',`unit_flags`='37632' WHERE `entry` = 18930; -- 1760
-- Amish Wildhammer 18931
UPDATE `creature_template` SET `faction_A`='1666',`faction_H`='1666',`unit_flags`='37632' WHERE `entry` = 18931; -- 1756

-- Darna Honeybock & Slurpo Fizzykeg & Brewfest Spy (Brewfest Agent)
UPDATE `creature_template` SET `minhealth`='1',`maxhealth`='1' WHERE `entry` IN (27584, 28329, 26719);

UPDATE `access_requirement` SET `quest_done`='10901' WHERE `id` = 37;
UPDATE `access_requirement` SET `quest_done`='10888' WHERE `id` = 38;

UPDATE `creature` SET `position_x`='528.0247', `position_y`='159.3643', `position_z`='20.2494', `orientation`='2.8928' WHERE `guid` = '12544';
UPDATE `creature` SET `position_x`='522.1024', `position_y`='136.0457', `position_z`='20.2510', `orientation`='2.8928' WHERE `guid` = '12543';

DELETE FROM `creature_formations` WHERE `leaderguid` IN (93798,93799,93800,93801,93766,82975,82976,93765);
DELETE FROM `creature_formations` WHERE `memberguid` IN (93798,93799,93800,93801,93766,82975,82976,93765);
INSERT INTO `creature_formations` VALUES
--
(93798,93798,100,360,2),
(93798,93799,100,360,2),
(93798,93800,100,360,2),
(93798,93801,100,360,2),
--
(93766,93766,100,360,2),
(93766,82975,100,360,2),
(93766,82976,100,360,2),
(93766,93765,100,360,2);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21230');
INSERT INTO `creature_ai_scripts` VALUES
('2123001','21230','11','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Spawn'),
('2123002','21230','4','125','100','2','0','0','0','0','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt on Aggro (Phase 1)'),
('2123003','21230','9','125','100','3','0','40','1200','4800','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt (Phase 1)'),
('2123004','21230','9','125','100','3','0','5','8000','12000','11','38644','0','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Cone of Cold (Phase 1)'),
('2123005','21230','0','125','100','3','6000','12000','8400','12000','11','38646','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blizzard (Phase 1)'),
('2123006','21230','1','125','100','3','1000','1000','1800000','1800000','11','38649','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction OOC (Phase 1)'),
('2123007','21230','27','125','100','3','38649','1','5000','5000','11','38649','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction on Missing Buff (Phase 1)'),
('2123008','21230','1','119','100','3','1000','1000','1800000','1800000','11','38648','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction OOC (Phase 3)'),
('2123009','21230','4','119','100','2','0','0','0','0','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball on Aggro (Phase 3)'),
('2123010','21230','9','119','100','3','0','40','1200','4800','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball (Phase 3)'),
('2123011','21230','0','119','100','3','6000','12000','8400','12000','11','38635','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Rain of Fire (Phase 3)'),
('2123012','21230','9','119','100','2','0','30','9000','12000','11','38636','1','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Scorch (Phase 3)'),
('2123013','21230','27','119','100','3','38648','1','5000','5000','11','38648','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction on Missing Buff (Phase 3)'),
('2123014','21230','1','95','100','3','1000','1000','1800000','1800000','11','38647','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction OOC (Phase 2)'),
('2123015','21230','4','95','100','2','0','0','0','0','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley on Aggro (Phase 5)'),
('2123016','21230','9','95','100','3','0','40','4800','9600','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley (Phase 5)'),
('2123017','21230','0','95','100','3','2000','6000','9600','12600','11','38634','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Lightning (Phase 5)'),
('2123018','21230','27','95','100','3','38647','1','5000','5000','11','38647','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction on Missing Buff (Phase 5)'),
('2123019','21230','0','0','75','3','6000','18000','17000','24000','11','38642','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blink'),
('2123020','21230','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - On Evade set Phase to 0');

-- Spitfire Totem 22091
UPDATE `creature_template` SET `armor`='6500',`speed`='0.001',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` = 22091;
--
-- Greater Earthbind Totem 22486
UPDATE `creature_template` SET `armor`='6500',`speed`='0.001',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` = 22486;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22486');
INSERT INTO `creature_ai_scripts` VALUES
('2248601','22486','0','0','100','3','1000','1000','5000','5000','11','3600','0','0','0','0','0','0','0','0','0','0','Greater Earthbind Totem - Cast Earthbind');
--
-- Greater Poison Cleansing Totem 22487
UPDATE `creature_template` SET `armor`='6500',`speed`='0.001',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` = 22487;

-- NV
UPDATE `item_template` SET `bonding` = 1 WHERE `entry` = 30183;

-- Leo
UPDATE `creature_template` SET `mindmg`=5400 WHERE `entry` = 21215;
