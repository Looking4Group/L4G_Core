-- x2 25697 for nh and hc deleted one
DELETE FROM `creature` WHERE `guid` IN ('16800140');
UPDATE `creature` SET `spawnmask`='3' WHERE `guid` IN ('16777012');
UPDATE `creature` SET `position_x`='-89.2778',`position_y`='-114.0839',`position_z`='-2.2904',`orientation`='2.2800' WHERE `guid` IN ('16777012');
DELETE FROM `game_event_creature` WHERE `guid` IN ('16777012');
INSERT INTO `game_event_creature` VALUES
(16777012,2);
-- min / max level startup errors
update creature_template set minlevel=25, maxlevel=27 where entry = 10760;
update creature_template set minlevel=60, maxlevel=60 where entry = 14302;
update creature_template set minlevel=73, maxlevel=73 where entry = 15936;
update creature_template set minlevel=69, maxlevel=69 where entry = 19799;
update creature_template set minlevel=71, maxlevel=71 where entry = 19821;
update creature_template set minlevel=69, maxlevel=69 where entry = 21860;
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/621/tiefensumpf
--
-- Underbog Frenzy 20465,21943
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`minhealth`='33333',`maxhealth`='34822',`armor`='6800',`speed`='1.48',`mindmg`='1371',`maxdmg`='2333',`baseattacktime`='1000',`attackpower`='0',`MovementType`='1',`mechanic_immune_mask`='787431423',`unit_flags`='32832' WHERE `entry` IN ('21943');
UPDATE `creature_template` SET `MovementType`='1',`unit_flags`='32832' WHERE `entry` IN ('20465');
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('2046501');
INSERT INTO `creature_ai_scripts` VALUES
(2046501,20465,9,0,100,7,0,5,7500,10000,11,12097,1,0,13,-25,1,0,0,0,0,0,'Underbog Frenzy - Cast Pierce Armor');
--
-- Underbat 17724 20185
UPDATE `creature_template` SET `mechanic_immune_mask`='8520720' WHERE `entry` IN (17724);
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='8530960',`mindmg`='3440',`maxdmg`='4572' WHERE `entry` IN (20185); -- 1802 3684
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1772403');
INSERT INTO `creature_ai_scripts` VALUES
('1772403','17724','4','0','100','7','0','0','0','0','39','5','0','0','0','0','0','0','0','0','0','0','Underbat - Call For Help on Aggro');
--
-- Underbog Shambler 17871 20190
UPDATE `creature_template` SET `mechanic_immune_mask`='8389648' WHERE `entry` IN (17871);
UPDATE `creature_template` SET `speed`='1.48',`unit_flags`='1',`mechanic_immune_mask`='8399888',`mindmg`='3440',`maxdmg`='4572' WHERE `entry` IN (20190);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17871');
INSERT INTO `creature_ai_scripts` VALUES
('1787101','17871','9','0','100','3','0','15','10000','15000','11','32329','4','32','0','0','0','0','0','0','0','0','Underbog Shambler (Normal) - Cast Itchy Spores'),
('1787102','17871','9','0','100','5','0','15','8000','12500','11','37965','4','32','0','0','0','0','0','0','0','0','Underbog Shambler (Heroic) - Cast Itchy Spores'),
('1787103','17871','2','0','100','3','75','0','25000','30000','11','34163','0','0','0','0','0','0','0','0','0','0','Underbog Shambler (Normal) - Cast Fungal Regrowth at 75% HP'),
('1787104','17871','2','0','100','5','75','0','25000','30000','11','37967','0','0','0','0','0','0','0','0','0','0','Underbog Shambler (Heroic) - Cast Fungal Regrowth at 75% HP'),
('1787105','17871','14','0','100','3','4000','40','25000','30000','11','34163','6','0','0','0','0','0','0','0','0','0','Underbog Shambler (Normal) - Cast Fungal Regrowth on Friendlies'),
('1787106','17871','14','0','100','5','8000','40','25000','30000','11','37967','6','0','0','0','0','0','0','0','0','0','Underbog Shambler (Heroic) - Cast Fungal Regrowth on Friendlies'),
('1787107','17871','9','0','25','7','0','5','4000','8000','11','31427','5','0','0','0','0','0','0','0','0','0','Underbog Shambler - Cast Allergies');
--
-- Underbog Lurker 17725 20188
UPDATE `creature_template` SET `mechanic_immune_mask`='8389648' WHERE `entry` IN (17725);
UPDATE `creature_template` SET `maxhealth`='27350',`speed`='1.48',`unit_flags`='1',`mechanic_immune_mask`='8399888',`mindmg`='4572',`maxdmg`='6858' WHERE `entry` IN (20188);
UPDATE `creature_ai_texts` SET `content_loc3`='wächst, als er $N sieht!' WHERE `entry` IN (-152);
UPDATE `creature_ai_texts` SET `content_loc3`='\'s Kraft verschwindet!' WHERE `entry` IN (-153);
--
-- Bog Giant 17723 20164
UPDATE `creature_template` SET `mechanic_immune_mask`='652885759',`mindmg`='1132',`maxdmg`='1475',`baseattacktime`='2000' WHERE `entry` IN (17723); -- 525-1040 
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='652885759',`mindmg`='6686',`maxdmg`='7941',`baseattacktime`='0' WHERE `entry` IN (20164); --
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17723');
INSERT INTO `creature_ai_scripts` VALUES
('1772301','17723','9','0','75','7','0','5','13650','27100','11','15550','0','0','0','0','0','0','0','0','0','0','Bog Giant - Cast Trample'),
('1772302','17723','9','0','100','7','0','15','9300','9300','11','32065','4','32','0','0','0','0','0','0','0','0','Bog Giant - Cast Fungal Decay'),
('1772303','17723','2','0','100','6','50','0','0','0','11','40318','0','1','0','0','0','0','0','0','0','0','Bog Giant - Cast Growth at 50% HP'),
('1772304','17723','2','0','100','6','30','0','120000','120000','11','8599','0','1','1','-46','0','0','0','0','0','0','Bog Giant - Cast Enrage at 30% HP');
--
--
UPDATE `creature_ai_texts` SET `content_loc3`='Ich werde Eure Haut als Hausjacke tragen! Die Zigarren? Die müsst Ihr schon aus meinen kalten, toten... ääh... RAAAR!!!' WHERE `entry`='-177';
UPDATE `creature_ai_texts` SET `content_loc3`='Die Zigarren? Die müsst Ihr schon aus meinen kalten, toten... ääh... RAAAR!!!' WHERE `entry`='-178';
-- recheck
UPDATE `creature_ai_texts` SET `content_loc3`='wird wütend!' WHERE `entry`='-46';
UPDATE `creature_template` SET `mechanic_immune_mask`='67109571',`equipment_id`='832' WHERE `entry` IN (17726); 
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='67109571',`equipment_id`='832' WHERE `entry` IN (20191);
UPDATE `creature_template` SET `mechanic_immune_mask`='75578067',`equipment_id`='72' WHERE `entry` IN (17727); -- Holzschild + Langschwert  72 nice aqua look 1711 eisenschild 1766 holzschild  
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='75578067',`equipment_id`='72' WHERE `entry` IN (20192); -- Holzschild + Langschwert
DELETE FROM `creature_template_addon` WHERE `entry` IN (17727,20192,20465,21943);
INSERT INTO `creature_template_addon` VALUES 
(17727,0,0,0,0,4097,0,0,'18950 0 18950 1'),
(20192,0,0,0,0,4097,0,0,'18950 0 18950 1'),
(20465,0,0,0,0,0,0,2097152,'18950 0 18950 1'),
(21943,0,0,0,0,0,0,2097152,'18950 0 18950 1');
UPDATE `creature_ai_texts` SET `content_loc3`='Heil Illidan!',`type`='1' WHERE `entry` IN (-154);
UPDATE `creature_ai_scripts` SET `event_type`='9',`event_param1`='0',`event_param2`='5' WHERE `id` IN (1772702);
UPDATE `creature_template` SET `mechanic_immune_mask`='75507923',`equipment_id`='940' WHERE `entry` IN (17735); -- Holzschild + Säbel
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='75507923',`equipment_id`='940' WHERE `entry` IN (20193); -- Holzschild + Säbel
UPDATE `creature_ai_scripts` SET `event_type`='9',`event_param1`='0',`event_param2`='5' WHERE `id` IN (1773501);
UPDATE `creature_template` SET `equipment_id`='397' WHERE `entry` IN (17730); -- Dolch Einhändig
UPDATE `creature_template` SET `speed`='1.48',`equipment_id`='397' WHERE `entry` IN (20177); -- Dolch Einhändig
UPDATE `creature_ai_texts` SET `content_default`='begins a massive heal!',`content_loc3`='beginnt eine große Heilung!' WHERE `entry` IN (-686);
UPDATE `creature_template` SET `equipment_id`='1754'  WHERE `entry` IN (17729); -- Spear
UPDATE `creature_template` SET `speed`='1.48',`equipment_id`='1754' WHERE `entry` IN (20180); -- Spear
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('1772901','1772908');
UPDATE `creature_ai_scripts` SET `event_param2`='10',`action3_type`='29',`action3_param1`='10',`action3_param2`='360',`comment`='Murkblood Spearman - Prevent Combat Movement and Prevent Melee at 10 Yards (Phase 1)' WHERE `id` IN ('1772908');
UPDATE `creature_ai_scripts` SET `event_param4`='2200' WHERE `id` IN (1772903,1772905);
UPDATE `creature_ai_scripts` SET `action1_param3`='33' WHERE `id` IN (1772909,1772910);
--
-- Murkblood Tribesman
UPDATE `creature_template` SET `equipment_id`='437',`mindmg`='474',`maxdmg`='645'  WHERE `entry` IN (17728); -- Doppel Eisenhammer 277 619
UPDATE `creature_template` SET `speed`='1.48',`equipment_id`='437',`mindmg`='2266',`maxdmg`='2692' WHERE `entry` IN (20181); -- Doppel Eisenhammer 814 1665 5383
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17728');
INSERT INTO `creature_ai_scripts` VALUES
('1772801','17728','9','0','100','7','0','5','4400','8700','11','12057','1','0','0','0','0','0','0','0','0','0','Murkblood Tribesman - Cast Strike'),
('1772802','17728','2','0','100','6','30','0','0','0','11','8599','0','1','1','-106','0','0','0','0','0','0','Murkblood Tribesman - Cast Enrage at 30% HP'),
('1772803','17728','4','0','100','7','0','0','0','0','11','29651','0','1','0','0','0','0','0','0','0','0','Murkblood Tribesman - Casts Dual Wield on Aggro');
--
-- Murkblood Oracle 17771 20179
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='1033',`maxdmg`='1226' WHERE `entry` IN (20179); -- 372 758
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('1777101','1777110','1777121','1777132');
--
-- Fen Ray
UPDATE `creature_template` SET `mechanic_immune_mask`='1024' WHERE `entry` IN (17731);
UPDATE `creature_template` SET `mechanic_immune_mask`='75569011',`speed`='1.48',`unit_flags`='1',`mindmg`='3021',`maxdmg`='3588' WHERE `entry` IN (20173);
--
-- Lykul Stinger
UPDATE `creature_template` SET `mechanic_immune_mask`='1024' WHERE `entry` IN (19632);
UPDATE `creature_template` SET `mechanic_immune_mask`='75564915',`speed`='1.48',`mindmg`='2288',`maxdmg`='2722' WHERE `entry` IN (20174); -- 614 1265
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN (1773201,1773205);
UPDATE `creature_ai_scripts` SET `event_param3`='2500',`event_param4`='4000' WHERE `id` IN (1773203);
--
-- Bosses
--
-- Hungarfen 17770 20169
UPDATE `creature_template` SET `mindmg`='7683',`maxdmg`='9117' WHERE `entry` IN ('20169');
--
-- Underbog Mushroom
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423' WHERE `entry` IN ('17990');
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423' WHERE `entry` IN ('20189');
--
-- Ghaz'an 18105,20168
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`speed`='1.48' WHERE `entry` IN (18105);
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`armor`='7400',`speed`='1.48',`mindmg`='6153',`maxdmg`='7308',`skinloot`='70063' WHERE `entry` IN (20168);
DELETE FROM `creature_ai_scripts` WHERE `id` IN (1810503);
INSERT INTO `creature_ai_scripts` VALUES 
('1810503','18105','4','0','100','7','0','0','0','0','11','8876','0','0','0','0','0','0','0','0','0','0','Ghaz\'an - Cast Thrash on Aggro');
--
-- Overseer Tidewrath 18107
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`minhealth`='250000',`maxhealth`='250000',`armor`='7400',`speed`='3',`mindmg`='10000',`maxdmg`='15000',`baseattacktime`='2000',`attackpower`='0',`mingold`='8000',`maxgold`='12000',`AIName`='EventAI',`mechanic_immune_mask`='787431423',`flags_extra`='4259841',`equipment_id` ='1752',`faction_A`='14',`faction_H`='14' WHERE `entry` IN (18107); -- Dreizack wie DK Endboss
--
-- 89224 Swamplord Musel'ek 17826,20183
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`equipment_id`='1713',`baseattacktime`='2000' WHERE `entry` IN ('17826'); --
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`speed`='1.48',`equipment_id`='1713',`minhealth`='89652',`maxhealth`='89652',`mindmg`='6952',`maxdmg`='8251',`baseattacktime`='2000' WHERE `entry` IN ('20183'); --
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17826');
INSERT INTO `creature_ai_scripts` VALUES
('1782600','17826','0','0','100','7','4000','4000','4000','4000','21','1','0','0','40','1','0','0','20','1','0','0','Swamplord Musel\'ek - Start Combat Movement and Start Melee'),
('1782601','17826','1','0','100','7','0','0','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Swamplord Musel\'ek - Prevent Combat Movement on Spawn'),
('1782602','17826','4','0','100','7','0','0','0','0','1','-463','-464','0','22','1','0','0','0','0','0','0','Swamplord Musel\'ek - Yell and Set Phase 1 on Aggro'),
('1782603','17826','9','1','100','3','6','30','2000','2000','11','16100','1','0','40','2','0','0','21','0','0','0','Swamplord Musel\'ek (Normal) - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('1782604','17826','9','1','100','5','6','30','2000','2000','11','38940','1','0','40','2','0','0','21','0','0','0','Swamplord Musel\'ek (Heroic) - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('1782605','17826','9','0','100','6','0','5','1000','1000','21','1','0','0','40','1','0','0','22','0','0','0','Swamplord Musel\'ek - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 5 Yards'),
('1782606','17826','9','0','100','7','0','5','2000','4000','11','31566','1','0','40','1','0','0','0','0','0','0','Swamplord Musel\'ek - Cast Raptor Strike and Set Melee Weapon Model Below 5 Yards'),
('1782607','17826','0','1','100','7','8000','12000','10000','15000','11','34974','1','0','40','2','0','0','21','0','0','0','Swamplord Musel\'ek - Cast Multi-Shot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('1782608','17826','0','0','100','7','6000','6000','31000','31000','11','31946','4','0','21','0','0','0','0','0','0','0','Swamplord Musel\'ek - Throw Freezing Trap and Stop Movement'),
('1782609','17826','0','0','100','7','5000','5000','30000','30000','11','18813','1','1','21','0','0','0','22','1','0','0','Swamplord Musel\'ek - Cast Knock Away and Stop Movement and Set Phase 1'),
('1782610','17826','0','0','100','7','5000','5000','30000','30000','1','-465','0','0','0','0','0','0','0','0','0','0','Swamplord Musel\'ek - Pet Enrage Yell During Combat'),
('1782611','17826','5','0','100','7','0','0','0','0','1','-467','-468','0','0','0','0','0','0','0','0','0','Swamplord Musel\'ek - Yell on Player Kill'),
('1782612','17826','7','0','100','7','0','0','0','0','40','1','0','0','22','0','0','0','0','0','0','0','Swamplord Musel\'ek - Set Melee Weapon Model and Set Phase 0 on Evade'),
('1782613','17826','6','0','100','7','0','0','0','0','1','-466','0','0','0','0','0','0','0','0','0','0','Swamplord Musel\'ek - Yell on Death'),
('1782614','17826','2','0','100','7','30','0','12000','18000','11','31567','0','1','0','0','0','0','0','0','0','0','Swamplord Musel\'ek - Cast Deterrence at 30% HP'),
('1782615','17826','9','0','100','7','5','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Swamplord Musel\'ek - Stop Combat Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');
--
-- infight text
UPDATE creature_ai_texts SET content_loc3='Kurz und schmerzvoll....' WHERE entry='-463';
UPDATE creature_ai_texts SET content_loc3='Wir kämpfen bis zum Tod!' WHERE entry='-464';
UPDATE creature_ai_texts SET content_loc3='Bestie! Gehorche deinem Meister! Töte sie!' WHERE entry='-465';
UPDATE creature_ai_texts SET content_loc3='Krypta!' WHERE entry='-467';
UPDATE creature_ai_texts SET content_loc3='Es ist vollbracht.' WHERE entry='-468';
UPDATE creature_ai_texts SET content_loc3='Gut...gemacht...' WHERE entry='-466';
--
-- 88626  Claw 17827,20165
UPDATE `creature` SET `spawntimesecs`='60' WHERE `guid` IN ('56862');
UPDATE `creature_template` SET `baseattacktime`='1800',`mechanic_immune_mask`='787430911' WHERE `entry` IN ('17827');
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`speed`='1.48',`minhealth`='89667',`maxhealth`='89667',`mindmg`='1752',`maxdmg`='2327',`baseattacktime`='0' WHERE `entry` IN ('20165');
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17827');
INSERT INTO `creature_ai_scripts` VALUES
('1782701','17827','0','0','100','3','7400','7400','15000','20000','11','39435','4','0','14','-10','0','0','0','0','0','0','Claw (Normal) - Cast Feral Charge and Modify Threat'),
('1782702','17827','0','0','100','5','7400','7400','10000','12000','11','39435','4','0','14','-10','0','0','0','0','0','0','Claw (Heroic) - Cast  Feral Charge and Modify Threat'),
('1782703','17827','9','0','100','7','0','5','15000','30000','11','31429','0','0','0','0','0','0','0','0','0','0','Claw - Cast  Echoing Roar'),
('1782704','17827','0','0','100','7','5000','5000','30000','30000','11','34971','0','1','13','-25','1','0','0','0','0','0','Claw - Cast Frenzy'),
('1782705','17827','0','0','100','9','0','5','11100','21500','11','34298','1','1','0','0','0','0','0','0','0','0','Claw - Cast Maul'),
('1782706','17827','2','0','100','6','19','0','0','0','24','0','0','0','36','17894','0','0','5','13','0','0','Claw - Transform to Windcaller Claw at 19% HP');
UPDATE `creature_template` SET `armor`='0',`minhealth`='6000',`maxhealth`='6000' WHERE `entry` IN ('17894');
UPDATE `creature` SET `spawndist`='5',`MovementType`='1' WHERE `guid` IN ('54300','56168','56145','54301','98233','98232','98231','98230','98229','98228');
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423' WHERE `entry` IN ('17882');
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20184');
--
 -- 127505 The Black Stalker 17882,20184 
UPDATE `creature_template` SET `minhealth`='130000',`maxhealth`='130000',`mindmg`='4279',`maxdmg`='5080' WHERE `entry` IN ('20184');
--
-- Repos
--
UPDATE `creature` SET `position_x`='16.2012',`position_y`='-175.8611',`position_z`='-4.4923',`orientation`='4.1284' WHERE `guid` IN (98203);
UPDATE `creature` SET `position_x`='11.6524',`position_y`='-170.7431',`position_z`='-4.5332',`orientation`='3.2101' WHERE `guid` IN (54212);
UPDATE `creature` SET `position_x`='22.7546',`position_y`='-175.8437',`position_z`='-4.3584',`orientation`='5.7823',`id`='17871' WHERE `guid` IN (54215);
UPDATE `creature` SET `orientation`='1.7565',`spawndist`='3',`MovementType`='1' WHERE `guid` IN (54213,54214);
UPDATE `creature` SET `orientation`='1.1203' WHERE `guid` IN (54216,54217);
UPDATE `creature` SET `MovementType`='1',`spawndist`='5' WHERE `guid` IN (54210);
--
DELETE FROM `creature` WHERE `guid` IN (55000,54962,54940,54609,54610,54866,54962,54940,53011,54203,54289,54290,54291,54292,54293,54294,54295,54296,54297,54298,54299,54300,54301,54302,54303,54317,54405,54442,54487,54555,4920659,4920764);
-- hohe guides die gelöscht werden da fehlerhaft 4922530,4922558,4920659,4920764
-- hier haben wir faulen code rumliegen der dort immer wieder npcs einfügt wenn ihr ein update schaltet...
-- add npcs
INSERT INTO `creature` (`guid`,`id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
('55000','18107','546','2','330.3231','-543.7508','42.1390','1.3225','43200','0','0'),
('54962','17724','546','3','62.3316','-246.7358','-4.5090','2.5975','7200','0','0'),
('54940','17724','546','3','62.3317','-246.7359','-4.5091','2.5976','7200','0','0'),
('54609','17724','546','3','72.8584','-260.8788','-4.5240','2.4640','7200','3','1'),
('54610','17724','546','3','79.4202','-241.7153','-4.4715','2.7585','7200','3','1'),
('54866','17725','546','3','70.0774','-248.4127','-4.4962','2.6172','7200','0','0'),
('53011','17724','546','3','10.6741','-193.8280','-4.5321','2.1307','7200','0','0'),
('54203','17724','546','3','8.2230','-199.9580','-4.5321','2.1307','7200','0','0'), 
('54289','17724','546','3','18.8243','-192.7174','-4.3985','2.1307','7200','0','0'),
('54290','17871','546','3','-56.5549','-253.0245','-4.5365','6.1810','7200','0','0'),
('54291','17724','546','3','-9.3767','-232.0353','-4.5348','6.1810','7200','0','0'),
('54292','17724','546','3','-6.7228','-231.8936','-4.5348','6.1810','7200','0','0'), 
('54293','17724','546','3','10.6742','-193.8281','-4.5322','2.1308','7200','0','0'),
('54294','17724','546','3','-21.1292','-209.9807','-4.5350','6.1810','7200','0','0'), 
('54295','17724','546','3','-25.6935','-210.2410','-4.5350','6.1810','7200','0','0'),
('54296','17723','546','3','84.8842','-282.8594','32.1868','4.9909','7200','0','0'),
('54297','17726','546','3','185.5287','-398.0972','72.3938','4.2372','7200','0','0'), 
('54298','17726','546','3','189.0179','-400.3017','72.4666','4.2372','7200','0','0'),
('54299','17731','546','3','329.8336','-332.2165','22.0885','1.9840','7200','0','2'),
('54300','17731','546','3','276.7394','-183.3901','29.0624','4.3312','7200','0','2'),
('54301','17731','546','3','243.9074','-177.5774','26.8624','5.8923','7200','0','2'),
('54302','20465','546','3','6.9152','-274.8950','-20.8859','1.5021','7200','5','1'),
('54303','20465','546','3','-15.5462','-302.5088','-18.4072','2.1352','7200','5','1'),
('54317','20465','546','3','221.8629','-420.4852','37.8492','4.9076','7200','5','1'), 
('54405','20465','546','3','201.3661','-459.3652','36.8523','4.2283','7200','5','1'), 
('54442','20465','546','3','216.2375','-499.4735','39.2713','1.7975','7200','5','1'),
('54487','20465','546','3','261.9448','-437.2689','35.2546','4.0005','7200','5','1'),
('54555','20465','546','3','-49.4212','-333.6355','-21.5887','4.9076','7200','5','1');
--
UPDATE `creature` SET `position_z`='-15',`spawndist`='10',`MovementType`='1' WHERE `guid` IN (54250,54249,54555,54387,54303,54248,54385,54383,54337,54381,54337,54339);
--
DELETE FROM `waypoint_data` WHERE `id` IN ('1361') AND `point` IN ('0');
INSERT INTO `waypoint_data` VALUES
(1361,0,232.1944,-132.0565,25.7789,0,0,0,100,0);
--
-- fische kein linking
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (54962,54940,54609,54866,54610,53011,54203,54289,54290,98207,98206,54291,54292,98205,54293,54211,98208,54294,54295,98204,54296,54297,54298,54299,56112,56142,54300,56316,56168,54301,56164,56145);
INSERT INTO `creature_linked_respawn` VALUES
(54962,54392),
(54940,54392),
(54609,54392),
(54866,54392),
(54610,54392),
(53011,54392),
(54203,54392),
(54289,54392),
(54290,54392),
(98207,54392),
(98206,54392),
(54291,54392),
(54292,54392),
(98205,54392),
(54293,54392),
(54211,54392),
(98208,54392),
(54294,54392),
(54295,54392),
(98204,54392),
(54296,56111),
(54297,56111),
(54298,56111),
(54299,56551),
(56112,56551),
(56142,56551),
(54300,56551),
(56316,56551),
(56168,56551),
(54301,56551),
(56164,56551),
(56145,56551);
-- (GUID,BOSSGUID),

DELETE FROM `creature_formations` WHERE `leaderGUID` IN (98202,54213,5421456551,56862,54410,54407,54406,54615,54421,54420,54940,54337,98203,54247,54866,54211,54291,53011,4920764,98214,54424,54703,55102,98222,98224,56112,56316,56164,54317,54555,54249,54248,54383,54294,54297,57013);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (98202,54213,5421456551,56862,54410,54407,54406,54615,54421,54420,54940,54337,98203,54247,54866,54211,54291,53011,4920764,98214,54424,54703,55102,98222,98224,56112,56316,56164,54317,54555,54249,54248,54383,54294,54297,57013);
--
--
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98202', '98202', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98202', '54213', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98202', '54214', '60', '360', '2'); 
--
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54410', '54410', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54410', '54411', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54410', '54409', '60', '360', '2'); 
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54410', '54412', '60', '360', '2'); 

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54615', '54615', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54615', '54622', '60', '360', '2');

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54866', '54866', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54866', '54610', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54866', '54609', '60', '360', '2');  
-- 
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('53011', '53011', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('53011', '54203', '4', '4', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('53011', '54289', '4', '2', '2');
-- waypoints for 53011
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=53011;
SET @NPC := 53011;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-6.3262','-167.7156','-4.5332',0,1,0,100,0),
(@PATH,2,'-11.9886','-144.4640','-4.5332',0,1,0,100,0),
(@PATH,3,'-1.5781','-119.7016','-4.5332',0,1,0,100,0),
(@PATH,4,'23.5109','-105.8123','-4.5332',0,1,0,100,0),
(@PATH,5,'30.1299','-106.9713','-4.2840',0,1,0,100,0),
(@PATH,6,'23.5109','-105.8123','-4.5332',0,1,0,100,0),
(@PATH,7,'-1.5781','-119.7016','-4.5332',0,1,0,100,0),
(@PATH,8,'-11.9886','-144.4640','-4.5332',0,1,0,100,0),
(@PATH,9,'-6.3262','-167.7156','-4.5332',0,1,0,100,0),
(@PATH,10,'14.7810','-199.3200','-4.4825',0,1,0,100,0);
--
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98203', '98203', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98203', '54215', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98203', '54212', '60', '360', '2');
--
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54337', '54337', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54337', '54339', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54337', '54381', '60', '360', '2');

--
-- waypoints for 54389
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54389;
SET @NPC := 54389;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-54.1570','-230.6118','-4.5369',0,0,0,100,0), 
(@PATH,2,'-96.1847','-229.0249','-4.4022',0,0,0,100,0),
(@PATH,3,'-131.6086','-227.0444','-4.1064',0,0,0,100,0),
(@PATH,4,'-153.2215','-278.6024','-4.8326',0,0,0,100,0), 
(@PATH,5,'-145.5415','-307.3332','-4.7787',0,0,0,100,0), 
(@PATH,6,'-153.2215','-278.6024','-4.8326',0,0,0,100,0), 
(@PATH,7,'-131.6086','-227.0444','-4.1064',0,0,0,100,0),
(@PATH,8,'-96.1847','-229.0249','-4.4022',0,0,0,100,0);
--
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('57013', '57013', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('57013', '54247', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('57013', '54218', '60', '360', '2');
-- linking pat
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54940', '54940', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54940', '54962', '4', '0', '2');
--
-- waypoints for 54940
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54940;
SET @NPC := 54940;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'15.6159','-213.5929','-4.5332',0,1,0,100,0),
(@PATH,2,'69.4439','-256.2760','-4.5127',0,1,0,100,0);
--
-- Update Respawntimer 
UPDATE `creature` SET `spawntimesecs` = '7200' WHERE `guid` IN ('4922530 ','4920659 ','4920764 ','4922558');
UPDATE `creature` SET `id`='17725' WHERE `guid` IN (4922558);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54211','54211','60','360','2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54211','98208','4','0','2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54211','54293','8','0','2');
--

-- pat wasser 
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54291', '54291', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54291', '54292', '4', '0', '2');
-- waypoints for 54291
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54291;
SET @NPC := 54291;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-19.1250','-229.9605','-4.5345',0,1,0,100,0),
(@PATH,2,'-20.9508','-246.5982','-4.5345',0,1,0,100,0),
(@PATH,3,'-8.0874','-247.3370','-4.5345',0,1,0,100,0),
(@PATH,4,'-5.0299','-233.6673','-4.5345',0,1,0,100,0);
-- pat wand
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54294', '54294', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54294', '54295', '4', '0', '2');
-- waypoints for 54294
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54294;
SET @NPC := 54294;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-9.3977','-207.5093','-4.5348',0,1,0,100,0), 
(@PATH,2,'-10.3382','-192.7245','-4.5348',0,1,0,100,0), 
(@PATH,3,'-27.4060','-199.7562','-4.5348',0,1,0,100,0),
(@PATH,4,'-19.8416','-210.6138','-4.5348',0,1,0,100,0);
--
-- Linking Big Ones
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98214', '98214', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98214', '98215', '60', '360', '2');
-- 

UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54296;
SET @NPC := 54296;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'61.3535','-286.4179','32.5175',0,0,0,100,0),
(@PATH,2,'31.4342','-297.8602','32.4165',0,0,0,100,0), 
(@PATH,3,'-1.9689','-317.3247','30.8063',0,0,0,100,0),
(@PATH,4,'-31.9453','-337.1885','31.2870',0,0,0,100,0),
(@PATH,5,'-1.9689','-317.3247','30.8063',0,0,0,100,0),
(@PATH,6,'31.4342','-297.8602','32.4165',0,0,0,100,0),
(@PATH,7,'61.3535','-286.4179','32.5175',0,0,0,100,0),
(@PATH,8,'82.3772','-276.9742','32.2350',0,0,0,100,0);
SET @NPC := 54394;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-27.9396','-383.3765','32.1395',0,0,0,100,0), 
(@PATH,2,'-7.5633','-351.0335','28.7634',0,0,0,100,0),
(@PATH,3,'17.8824','-314.9304','31.8449',0,0,0,100,0),
(@PATH,4,'67.4062','-289.4926','32.3532',0,0,0,100,0),
(@PATH,5,'95.7083','-312.5867','32.6117',0,0,0,100,0),
(@PATH,6,'67.4062','-289.4926','32.3532',0,0,0,100,0),
(@PATH,7,'17.8824','-314.9304','31.8449',0,0,0,100,0),
(@PATH,8,'-7.5633','-351.0335','28.7634',0,0,0,100,0),
(@PATH,9,'-27.9396','-383.3765','32.1395',0,0,0,100,0), 
(@PATH,10,'-39.2647','-387.6842','31.0512',0,0,0,100,0);
--
UPDATE `creature` SET `MovementType`='1',`spawndist`='5' WHERE `guid` IN ('54408');
-- pat unten draußen
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54406', '54406', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54406', '54407', '4', '2', '2');
UPDATE `creature` SET `MovementType`='0' WHERE `guid`=54407;
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54406;
SET @NPC := 54406;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'99.6727','-396.6582','36.6336',0,0,0,100,0),
(@PATH,2,'135.8842','-413.7192','48.6510',0,0,0,100,0),
(@PATH,3,'167.9092','-428.4701','48.1789',0,0,0,100,0),
(@PATH,4,'151.8593','-421.9701','48.4968',0,0,0,100,0),
(@PATH,5,'135.8842','-413.7192','48.6510',0,0,0,100,0),
(@PATH,6,'99.6727','-396.6582','36.6336',0,0,0,100,0),
(@PATH,7,'90.0270','-391.8455','34.2241',0,0,0,100,0);
-- (@PATH,1,'XXXX','YYYY','ZZZZ',0,0,0,100,0),

-- pat unten
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54420', '54420', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54420', '54421', '4', '2', '2');
UPDATE `creature` SET `MovementType`='0' WHERE `guid`=54421;
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54420;
SET @NPC := 54420;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'178.4817','-399.9548','48.1129',0,0,0,100,0),
(@PATH,2,'209.5823','-372.0679','48.4515',0,0,0,100,0),
(@PATH,3,'242.2194','-363.8118','72.2513',0,0,0,100,0),
(@PATH,4,'209.5823','-372.0679','48.4515',0,0,0,100,0),
(@PATH,5,'178.4817','-399.9548','48.1129',0,0,0,100,0),
(@PATH,6,'166.1878','-421.2389','48.1341',0,0,0,100,0),
(@PATH,7,'163.7172','-434.8401','48.1644',0,0,0,100,0),
(@PATH,8,'166.1878','-421.2389','48.1341',0,0,0,100,0),
(@PATH,9,'173.3470','-409.8232','48.1284',0,0,0,100,0);
--
-- Linking Group
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54424', '54424', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54424', '54701', '2', '0', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54424', '54637', '2', '4', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54424', '54700', '4', '2', '2');
-- Leader is moving
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54424;
SET @NPC := 54424;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'203.8385','-381.5525','48.1362',2000,0,0,100,0),  
(@PATH,2,'233.2160','-375.2340','48.1963',2000,0,0,100,0);
--

-- Linking Pat
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54297', '54297', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54297', '54298', '4', '2', '2');
UPDATE `creature` SET `MovementType`='2' WHERE `guid`=54297;
SET @NPC := 54297;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'186.9925','-402.6037','72.4654',0,0,0,100,0),
(@PATH,2,'178.5218','-413.6560','72.4603',0,0,0,100,0),
(@PATH,3,'169.8880','-424.2919','72.4484',0,0,0,100,0),
(@PATH,4,'161.4302','-454.0822','72.4702',0,0,0,100,0), 
(@PATH,5,'169.8880','-424.2919','72.4484',0,0,0,100,0),
(@PATH,6,'178.5218','-413.6560','72.4603',0,0,0,100,0),
(@PATH,7,'186.9925','-402.6037','72.4654',0,0,0,100,0),
(@PATH,8,'213.9510','-385.2624','72.4896',0,0,0,100,0),
(@PATH,9,'251.4497','-372.9180','72.3382',0,0,0,100,0), 
(@PATH,10,'213.9510','-385.2624','72.4896',0,0,0,100,0);
-- (@PATH,2,'XXX','YYY','ZZZ',0,0,0,100,0),
--
-- pat
UPDATE `creature` SET `MovementType`='2' WHERE `guid` IN ('98209');
SET @NPC := 98209;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`) VALUES (@NPC,@PATH); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'27.2480','-194.4162','-4.2727',0,1,0,100,0),
(@PATH,2,'56.4067','-171.6072','-3.3128',0,1,0,100,0),
(@PATH,3,'11.1139','-207.1972','-4.5332',0,1,0,100,0),
(@PATH,4,'-3.5688','-205.4432','-4.5332',0,1,0,100,0),
(@PATH,5,'-9.2726','-220.6104','-4.5332',0,1,0,100,0),
(@PATH,6,'14.8130','-222.3226','-4.5332',0,1,0,100,0),
(@PATH,7,'11.1139','-207.1972','-4.5332',0,1,0,100,0);
--
-- Linking Group
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54703', '54703', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54703', '54799', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54703', '54427', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54703', '55068', '60', '360', '2');
--
-- Linking Group
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('55102', '55102', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('55102', '55106', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('55102', '55391', '60', '360', '2');
--
-- Linking Group
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98222', '98222', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98222', '55552', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98222', '55536', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98222', '55553', '60', '360', '2');
--
-- Linking Group
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98224', '98224', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98224', '98223', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98224', '56109', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('98224', '55903', '60', '360', '2');
--

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56112', '56112', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56112', '54299', '4', '2', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56112', '56142', '4', '4', '2');
--
-- Completing Group vor 3 Boss rechts + Linking

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56316','56316','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56316','56168','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56316', '54300', '60', '360', '2');
--
-- Completing Group vor 3 Boss links + Linking

INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56164','56164','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56164','56145','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('56164', '54301', '60', '360', '2');
UPDATE `creature` SET `position_x`='-8.1499',`position_y`='-292.6946',`position_z`='-18.5731' WHERE `guid` IN ('54248');
UPDATE `creature` SET `position_x`='-43.1317',`position_y`='-313.8300',`position_z`='-18.5057' WHERE `guid` IN ('54249');
UPDATE `creature` SET `position_x`='-63.5895',`position_y`='-310.5407',`position_z`='-18.8755' WHERE `guid` IN ('54250');
-- fish in se water are deadly
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54317','54317','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54317','54405','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54317', '54442', '60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54317', '54487', '60', '360', '2');
-- 
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54249','54249','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54249','54250','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54249','54555','60', '360', '2');
--
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54248','54248','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54248','54302','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54248','54303','60', '360', '2');
--
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54383','54383','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54383','54385','60', '360', '2');
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES ('54383','54387','60', '360', '2');
--
--
-- Gameobjects
DELETE FROM `gameobject` WHERE `guid` IN (32634);
INSERT INTO `gameobject` VALUES 
(32634,184941,546,2,74.7062,-252.385,-4.50239,2.04204,0,0,0.85264,0.522499,43200,100,1);
--
-- zusätzlich gespawnte npcs die eigentlich via ai gespawnt werden
DELETE FROM `creature` WHERE `guid` IN (91245,91246);
--
UPDATE `gameobject` SET `spawntimesecs`='1' WHERE `id` IN (182199); -- 43200
--
--
DELETE FROM `creature_loot_template` WHERE `entry` IN ('16485','16415','22853','17356') AND `item` IN ('22540');
INSERT INTO `creature_loot_template` VALUES
(16485,22540,0.10,0,1,1,0,0,0),
(16415,22540,0.05,0,1,1,0,0,0),
(22853,22540,0.05,0,1,1,0,0,0),
(17356,22540,0.05,0,1,1,0,0,0);
--
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-10' WHERE `entry` IN ('18860') AND `item` IN ('29797'); -- -6
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-20' WHERE `entry` IN ('20285') AND `item` IN ('29797'); -- -13
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-30' WHERE `entry` IN ('20326') AND `item` IN ('29797'); -- -24
--
-- Tainted Elemental 22009
-- 38253 false spell in script and despawns after 16 not 15 secs
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`mindmg`='169',`maxdmg`='299' WHERE `entry` IN ('22009'); -- 20 1 1 131
--
-- Coilfang Elite 22055
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8707',`maxdmg`='10340',`mechanic_immune_mask`='1073420283' WHERE `entry` IN ('22055'); -- 3129 6395 550183931 -- 8000 9400 17,413 - 20,679
--
-- Coilfang Strider 22056
-- 4500 - 8000 on tanks, one-shots anything else Tauntable 
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='16717',`maxdmg`='19853',`mechanic_immune_mask`='1073427391',`flags_extra`='0' WHERE `entry` IN ('22056'); -- 1 6007 12278 550183931 65536 -- 100000 18400 33,434 - 39,705
--
-- Colossus Rager 22352
-- 10-15 of these have a chance to spawn after killing a Underbog Colossus. Zur Zeit 8-10
-- http://www.wowhead.com/npc=22352/colossus-rager#comments
UPDATE `creature_template` SET `minhealth`='45944 ',`maxhealth`='46944',`speed`='1.48',`mindmg`='1671',`maxdmg`='1985',`baseattacktime`='1400' WHERE `entry` IN ('22352'); -- 27944 300 614 2000
--
-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `minhealth`='120000',`maxhealth`='120000',`speed`='1.48',`mindmg`='8358',`maxdmg`='9926',`baseattacktime`='1400',`mechanic_immune_mask`='1073561599' WHERE `entry` IN ('21863'); -- 104790 3003 6139 2000 1 -- 16,716 - 19,852
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21863');
INSERT INTO `creature_ai_scripts` VALUES
('2186301','21863','4','0','100','2','0','0','0','0','23','1','0','0','11','38655','1','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 and Cast Poison Bolt Volley on Aggro'),
('2186302','21863','9','5','100','3','3000','6000','4000','8000','11','38655','1','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Poison Bolt Volley (Phase 1)'),
('2186303','21863','24','5','100','3','38655','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 2 on Target Max Poison Bolt Volley Aura Stack (Phase 1)'),
('2186304','21863','28','3','100','3','38655','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 on Target Missing Poison Bolt Volley Aura Stack (Phase 2)'),
('2186305','21863','9','0','100','3','0','5','8800','11000','11','38650','0','1','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'),
-- ('2186306','21863','9','0','100','3','0','5','8800','11000','12','17990','1','22000','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'),
('2186307','21863','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase to 0 on Evade');
--
-- Coilfang Beast-Tamer 21221
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='7933',`maxdmg`='9422',`mechanic_immune_mask`='1073692671'  WHERE `entry` IN ('21221'); -- 1 3705 7576 1 -- 15,865 - 18,843
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21221');
INSERT INTO `creature_ai_scripts` VALUES
('2122100','21221','0','0','100','7','4000','4000','4000','4000','21','1','0','0','40','1','0','0','0','0','0','0','Coilfang Beast-Tamer - Start Combat Movement and Start Melee'),
('2122101','21221','4','0','100','2','0','0','0','0','21','0','0','0','22','1','0','0','40','2','0','0','Coilfang Beast-Tamer - Prevent Movement and Set Phase 1 and Set Ranged Weapon Model on Aggro'),
('2122102','21221','9','1','100','3','5','35','2000','3000','11','38904','4','0','40','2','0','0','21','1','0','0','Coilfang Beast-Tamer - Cast Throw and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2122103','21221','9','1','100','3','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Start Movement at 35 Yards (Phase 1)'),
('2122104','21221','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Coilfang Beast-Tamer - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('2122105','21221','9','0','100','3','0','5','4900','10900','11','38474','1','0','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Cleave'),
('2122106','21221','0','0','100','3','2000','9000','19300','23400','11','38484','0','1','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Bestial Wrath'),
('2122107','21221','7','0','100','2','0','0','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Coilfang Beast-Tamer - Start Movement and Set Melee Weapon Model and Set Phase 0 on Evade'),
('2122108','21221','9','0','100','7','6','35','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Coilfang Beast-Tamer - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');
--
-- Coilfang Fathom-Witch 21299
UPDATE `creature_template` SET `armor`='5700',`speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`mechanic_immune_mask`='1073692671'  WHERE `entry` IN ('21299'); -- 5414 1513 3087 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21299');
INSERT INTO `creature_ai_scripts` VALUES
('2129901','21299','1','0','100','2','0','0','0','0','21','1','0','0','22','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Combat Movement and Set Phase to 0 on Spawn'),
('2129902','21299','4','0','100','2','0','0','0','0','11','38628','1','0','23','1','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('2129903','21299','9','5','100','3','0','45','5200','9200','11','38628','1','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Bolt (Phase 1)'),
('2129904','21299','3','5','100','2','7','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2129905','21299','9','5','100','2','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement at 35 Yards (Phase 1)'),
('2129906','21299','9','5','100','2','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Prevent Combat Movement at 15 Yards (Phase 1)'),
('2129907','21299','9','5','100','2','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement Below 5 Yards (Phase 1)'),
('2129908','21299','3','3','100','3','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2129909','21299','0','0','100','3','8200','12200','36300','49300','11','38627','0','1','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Nova'),
('2129910','21299','9','0','100','3','0','10','11900','16100','11','38626','9','1','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Domination on TARGET_T_HOSTILE_RANDOM_NOT_TOP_PLAYER'),
('2129911','21299','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Set Phase to 0 on Evade');
--
-- Coilfang Hate-Screamer 21339
-- Silence: PBAoE silence for 4 seconds, 30 yard range. Nerfed 20yards atm
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304' WHERE `entry` IN ('21339'); -- 1913 4087 1 0 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21339');
INSERT INTO `creature_ai_scripts` VALUES
('2133901','21339','0','0','100','3','5000','9000','10500','19600','11','38491','0','7','0','0','0','0','0','0','0','0','Coilfang Hate-Screamer - Cast PBAoE Silence'),
('2133902','21339','0','0','100','3','6100','11200','4800','12000','11','38496','4','0','0','0','0','0','0','0','0','0','Coilfang Hate-Screamer - Cast Sonic Scream');
