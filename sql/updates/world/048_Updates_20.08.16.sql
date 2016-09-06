-- Storming Wind-Ripper 22310
UPDATE `creature_template` SET `resistance3`='-1' WHERE `entry` ='22310';

-- 1 archer missing
DELETE FROM `creature_linked_respawn` WHERE `guid` = 57698;
INSERT INTO `creature_linked_respawn` VALUES
(57698,13681415);

-- Umbrafen Witchdoctor 20115
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` ='20115';
INSERT INTO `creature_ai_scripts` VALUES
('2011501','20115','0','0','100','1','2000','6000','8000','12000','11','7289','4','32','0','0','0','0','0','0','0','0','Umbrafen Witchdoctor - Cast Shrink'),
('2011502','20115','0','0','100','1','1000','1000','8000','12000','11','34871','0','32','0','0','0','0','0','0','0','0','Umbrafen Witchdoctor- Cast Umbrafen Buff'),
('2011503','20115','2','0','100','1','50','0','20000','20000','11','35197','0','0','0','0','0','0','0','0','0','0','Umbrafen Witchdoctor- Cast Terror Totem at 50% HP'),
('2011504','20115','2','0','100','1','49','0','20000','20000','39','5','0','0','0','0','0','0','0','0','0','0','Umbrafen Witchdoctor- Call for Help at 49% HP'),
('2011505','20115','1','0','100','1','10000','10000','120000','150000','11','34871','0','0','0','0','0','0','0','0','0','0','Umbrafen Witchdoctor- Cast Umbrafen Buff OOC');
-- Terror Totem 20455
UPDATE `creature_template` SET `speed`=0.0001,`unit_flags`=262148, `dynamicflags`=8 WHERE `entry` ='20455'; -- 0 0
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` ='20455';
INSERT INTO `creature_ai_scripts` VALUES
('2045501','20455','1','0','100','1','3000','3000','0','0','11','35198','0','39','21','0','0','0','20','0','0','0','Terror Totem - Cast Fear'),
('2045502','20455','4','0','100','0','0','0','0','0','103','5','0','0','20','0','0','0','21','0','0','0','Terror Totem - Stop Attack and Stop Melee and Stop Movement on Aggro'),
('2045503','20455','1','0','100','1','15000','15000','1000','1000','41','0','0','0','0','0','0','0','0','0','0','0','Terror Totem - Despawn on OOC Timer');


UPDATE `creature` SET `orientation`='3.4761' WHERE `guid` = 67880;


DELETE FROM `creature_formations` WHERE `leaderguid` IN (101459,101460,101461,101462,101463);
DELETE FROM `creature_formations` WHERE `memberguid` IN (101459,101460,101461,101462,101463);
INSERT INTO `creature_formations` VALUES
(101459,101459,100,360,2),
(101459,101460,5,5,2),
(101459,101461,5,1,2),
(101459,101462,5,2,2),
(101459,101463,5,4,2);

-- Netherspite - Nethergroll 15689
UPDATE `creature_template` SET `minhealth`='1117800',`maxhealth`='1117800',`mindmg`='6146',`maxdmg`='6415',`baseattacktime`='2000',`speed`='3.00',`faction_A`='14',`faction_H`='14' WHERE `entry` = '15689'; -- 1194 neutral -- 10000 11000 -- 12293 12830 -- 15,366 - 16,037hg

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (22961,57698,62871,62872,16777014,15118,15120,15112,15110,99949,99948,15094,15092,117515,117489,117436,117466,107964,62926,62927,62932,99979,99965,99964,99963,99962,99961,99960,99959,99958,99957,99956,99955,99996,99997,99998,99954,99953,99951,99950,99949,99948,99947,99946,99945,99944,99943,99942,99941,99940,99939);
INSERT INTO `creature_linked_respawn` VALUES
--
--
(22961,13681415),
(57698,13681415),
--
(16777014,16777014),
(62871,16777014),
(62872,16777014),
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

-- Warbringer O'mrogg 16809,20596
UPDATE `creature_template` SET `mindmg`='1677',`maxdmg`='2210',`speed`='1.00' WHERE `entry` ='16809'; -- 638 1305 s1 2h hammer -- 638 1305 -- 2,096 - 2,763
UPDATE `creature_template` SET `mindmg`='5623',`maxdmg`='5936',`pickpocketloot`='16809',`speed`='1.00' WHERE `entry` =20596; -- 2255 2802 -- 9,841 - 10,388

-- Rabid Warhound 17669,20574
-- http://wow.gamepedia.com/Rabid_Warhound 
UPDATE `creature_template` SET `maxlevel`='68',`maxhealth`='9473',`mindmg`='388',`maxdmg`='509',`mechanic_immune_mask`='1' WHERE `entry` ='17669'; -- 119 240 -- 388 - 509
UPDATE `creature_template` SET `rank`='0',`mindmg`='3270',`maxdmg`='3474',`baseattacktime`='0',`mechanic_immune_mask`='1' WHERE `entry` ='20574'; -- 1482 1890 -- 6,540 - 6,948
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17669','20574');
INSERT INTO `creature_template_addon` VALUES
(17669,0,0,512,0,4097,0,0,'18950 0 18950 1'),
(20574,0,0,512,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` ='17669';
INSERT INTO `creature_ai_scripts` VALUES
('1766901','17669','9','0','100','7','0','5','4000','6000','11','30639','1','0','0','0','0','0','0','0','0','0','Rabid Warhound - Cast Carnivorous Bite'),
('1766902','17669','0','0','100','3','2000','6000','12000','16000','11','30636','0','1','0','0','0','0','0','0','0','0','Rabid Warhound (Normal) - Cast Furious Howl'),
('1766903','17669','0','0','100','5','2000','4000','10000','12000','11','35942','0','1','0','0','0','0','0','0','0','0','Rabid Warhound (Heroic) - Cast Furious Howl');

UPDATE `creature_template` SET `equipment_id`='1187',`mindmg`='1830',`maxdmg`='2410' WHERE `entry` =16807; -- 558 1138 rotes 2h schwert -- 1,830 - 2,410 --

-- Creeping Oozeling 17357,20566
UPDATE `creature_template` SET `minhealth`='3200',`speed`='1.48',`mindmg`='158',`maxdmg`='208',`AIName`='EventAI' WHERE `entry` ='17357'; -- 48 98 -- 158 - 208
UPDATE `creature_template` SET `minhealth`='4400',`speed`='1.48',`mindmg`='661',`maxdmg`='849',`baseattacktime`='0' WHERE `entry` ='20566'; -- 190 566 -- 1,322 - 1,698
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17357','20566');
INSERT INTO `creature_template_addon` VALUES
(17357,0,0,512,0,4097,0,0,''),
(20566,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` =17357;
INSERT INTO `creature_ai_scripts` VALUES
('1735701','17357','0','0','100','7','5000','10000','5000','10000','11','30494','0','0','0','0','0','0','0','0','0','0','Creeping Oozeling - Cast Sticky Ooze');

-- Creeping Ooze 17356,20565
UPDATE `creature_template` SET `mindmg`='1467',`maxdmg`='1931' WHERE `entry` ='17356'; -- 448 912 -- 1,467 - 1,931
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3037',`maxdmg`='3322',`baseattacktime`='0' WHERE `entry` ='20565'; -- 1304 1875 -- 6,073 - 6,644
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17356','20565');
INSERT INTO `creature_template_addon` VALUES
(17356,0,0,512,0,4097,0,0,''),
(20565,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` =17356;
INSERT INTO `creature_ai_scripts` VALUES
('1735601','17356','0','0','100','7','3000','6000','3800','6500','11','30494','0','0','0','0','0','0','0','0','0','0','Creeping Ooze - Cast Sticky Ooze');

-- Groups
DELETE FROM `creature_formations` WHERE `leaderGUID` IN (90805,91716,91731,91744,90996,13681415,59478,59479,59480,59481,136542,3666851,113165,11033,85752,15484,85749,62946,62942,8439,62934,62938,121466,15480,16777014,117515,15373,63392,30418,18601,11262,106659,107255,19314,107109,19742,19868,11612,57695,57694,57220,20420,24360,136542,163620,57222);
DELETE FROM `creature_formations` WHERE `memberGUID` IN (90805,91716,91731,91744,90996,13681415,59478,59479,59480,59481,136542,3666851,113165,11033,85752,15484,85749,62946,62942,8439,62934,62938,121466,15480,16777014,117515,15373,63392,30418,18601,11262,106659,107255,19314,107109,19742,19868,11612,57695,57694,57220,20420,24360,136542,163620,57222);
--
--
--
INSERT INTO `creature_formations` VALUES 
(90805,90805,2,100,2),
(90805,91716,2,4,2),
(90805,91731,2,5,2),
(90805,91744,2,1,2),
(90805,90996,2,2,2);
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

SET @GUID := 90805;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
UPDATE `creature` SET `spawntimesecs`='300' WHERE `guid` IN (90805,91716,91731,91744,90996);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1','122.7454','222.4703','-47.7508',0,1,0,100,0),
(@GUID,@POINT := @POINT + '1','123.3319','233.6680','-46.5076',0,1,0,100,0),
(@GUID,@POINT := @POINT + '1','125.0957','204.5529','-48.7063',0,1,0,100,0),
(@GUID,@POINT := @POINT + '1','135.2930','189.6980','-47.3058',0,1,0,100,0),
(@GUID,@POINT := @POINT + '1','161.6374','168.8098','-42.4846',0,1,0,100,0),
(@GUID,@POINT := @POINT + '1','135.2930','189.6980','-47.3058',0,1,0,100,0),
(@GUID,@POINT := @POINT + '1','125.0957','204.5529','-48.7063',0,1,0,100,0);

-- shattrath aldor 0 action
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` = 68464;

UPDATE `creature_template` SET `mechanic_immune_mask`='1073709054' WHERE `entry` IN (15430,15439); -- 1073709055 -- 1073709054
-- incombat no need for this
UPDATE `creature_template` SET `unit_flags`='0' WHERE `entry` = 15438; -- 524288

-- Design: Veiled Nightseye
DELETE FROM `creature_loot_template` WHERE `item` = 31878;
INSERT INTO `creature_loot_template` VALUES
-- 0.03
(21337,31878,0.75,0,1,1,0,0,0),
-- 0.02
(18320,31878,0.50,0,1,1,0,0,0),
-- 0.01
(16468,31878,0.25,0,1,1,0,0,0),
(18493,31878,0.25,0,1,1,0,0,0),
(20301,31878,0.25,0,1,1,0,0,0),
(18497,31878,0.25,0,1,1,0,0,0),
(20299,31878,0.25,0,1,1,0,0,0),
(23397,31878,0.25,0,1,1,0,0,0),
(23018,31878,0.25,0,1,1,0,0,0),
(16481,31878,0.25,0,1,1,0,0,0),
(16415,31878,0.25,0,1,1,0,0,0),
(24685,31878,0.25,0,1,1,0,0,0),
(24683,31878,0.25,0,1,1,0,0,0),
(20259,31878,0.25,0,1,1,0,0,0),
(17833,31878,0.25,0,1,1,0,0,0),
(20530,31878,0.25,0,1,1,0,0,0),
(21298,31878,0.25,0,1,1,0,0,0),
(18323,31878,0.25,0,1,1,0,0,0),
(20692,31878,0.25,0,1,1,0,0,0),
(20035,31878,0.25,0,1,1,0,0,0),
(20031,31878,0.25,0,1,1,0,0,0),
(19166,31878,0.25,0,1,1,0,0,0),
(21543,31878,0.25,0,1,1,0,0,0),
(21695,31878,0.25,0,1,1,0,0,0),
(21917,31878,0.25,0,1,1,0,0,0),
-- 0.005
(15547,31878,0.10,0,1,1,0,0,0),
(15548,31878,0.10,0,1,1,0,0,0),
(15551,31878,0.10,0,1,1,0,0,0),
(16406,31878,0.10,0,1,1,0,0,0),
(17148,31878,0.10,0,1,1,0,0,0),
(18875,31878,0.10,0,1,1,0,0,0),
(21911,31878,0.10,0,1,1,0,0,0),
(22877,31878,0.10,0,1,1,0,0,0),
(17895,31878,0.10,0,1,1,0,0,0),
(16539,31878,0.10,0,1,1,0,0,0),
(16409,31878,0.10,0,1,1,0,0,0);

-- old world krautz
UPDATE `gameobject` SET `spawntimesecs`='1800' WHERE `id` IN (1617,1618,3724,3725,181166,1619,3726,1620,3727,1621,3729,2045,1622,3730,1623,1628,1624,2041,2042,2046,2043,2044,2866,142140,180165,142141,176642,142142,180164,176636,142143,183046,142144,142145,176637,176583,180167,176638,176584,180168,176639,176586,180166,176640,176587,176641,176588); -- 2700

DELETE FROM creature_ai_scripts WHERE `entryOrGUID` = '19389';
INSERT INTO `creature_ai_scripts` VALUES
('1938901','19389','9','0','100','3','0','7','8300','11250','11','39171','1','1','0','0','0','0','0','0','0','0','Lair Brute - Cast Mortal Strike'), -- 22500
('1938902','19389','9','0','100','3','0','5','6100','8000','11','39174','1','0','0','0','0','0','0','0','0','0','Lair Brute - Cast Cleave'), -- 16000
('1938903','19389','0','0','100','3','17600','18100','27100','34200','11','24193','5','1','14','-99','0','0','0','0','0','0','Lair Brute - Cast Charge and Drop Aggro'), -- 9050 
('1938904','19389','2','0','100','3','15','0','0','0','39','90','0','0','1','-551','0','0','0','0','0','0','Lair Brute - Call For Help at 15% HP'),
('1938905','19389','9','0','100','2','8','25','0','0','11','24193','1','0','0','0','0','0','0','0','0','0','Lair Brute - Cast Charge in Range');

-- High King Maulgar – Hochkönig Maulgar 18831
UPDATE `creature_template` SET `mindmg`='10783',`maxdmg`='12805',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` ='18831'; -- 10783 12805 -- 20487 24330 -- 21565 25610 
UPDATE `creature` SET `curhealth`='0' WHERE `guid` ='7483';
-- Krosh Firehand – Krosh Feuerhand
UPDATE `creature_template` SET `mindmg`='7238',`maxdmg`='8591',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` ='18832'; -- 
-- Olm the Summoner – Olm der Beschwörer
UPDATE `creature_template` SET `mindmg`='7238',`maxdmg`='8591',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` ='18834'; --
-- Kiggler the Crazed – Gicherer der Wahnsinnige 
UPDATE `creature_template` SET `mindmg`='12061',`maxdmg`='14317',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` ='18835'; -- 
-- Blindeye the Seer – Blindauge der Seher
UPDATE `creature_template` SET `mindmg`='7238',`maxdmg`='8591',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` ='18836'; --
-- Wild Fel Stalker - Wilder Teufelspirscher
UPDATE `creature_template` SET `mindmg`='2602',`maxdmg`='3090',`baseattacktime`='1400',`speed`='1.71',`spell1`='33091' WHERE `entry` ='18847'; --

-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/564/nighbane-adds-durch-die-wand
UPDATE `creature` SET `spawnmask`='0',`MovementType`='0' WHERE `guid` IN (353909,353950);
UPDATE `creature` SET `spawnmask`='0',`position_x`='-11155.8916',`position_y`='-1926.7788',`position_z`='74.4197',`orientation`='4.5796' WHERE `guid` =352721;
UPDATE `creature` SET `spawnmask`='0',`position_x`='-11162.8251',`position_y`='-1925.7696',`position_z`='74.4123',`orientation`='4.5678' WHERE `guid` =352535;
UPDATE `creature` SET `spawnmask`='0',`position_x`='-11159.0224',`position_y`='-1924.8333',`position_z`='74.4180',`orientation`='4.6856',`MovementType`='2' WHERE `guid` =368541;

-- Mark of the Illidari
UPDATE `creature_loot_template` SET `mincountOrRef`=0, `maxcount`=0 WHERE `item` =32897; -- 1 1
