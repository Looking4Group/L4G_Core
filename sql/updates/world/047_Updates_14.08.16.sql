UPDATE `creature` SET `position_x`='-172.933716', `position_y`='1244.347534', `position_z`='36.505833', `orientation`='3.839731' WHERE `guid` IN ('68189');

-- T5 Loottable
--
-- Lady Vashj
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21212 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21212 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21212 AND `item` = 190052; -- 2
-- Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 21212 AND `item` = 50031; -- 3
--
-- The Lurker Below
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21217 AND `item` = 29434; -- 100
--
-- Hydross the Unstable
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21216 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21216 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21216 AND `item` = 90052; -- 10
--
-- Leotheras the Blind
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21215 AND `item` = 29434; -- 100
-- Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 21215 AND `item` = 34059; -- 2
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21215 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21215 AND `item` = 190052; -- 2
--
-- Fathom-Lord Karathress
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21214 AND `item` = 29434; -- 100
-- Token
DELETE FROM `creature_loot_template` WHERE `entry` = 21214 AND `item` = 34060;
INSERT INTO `creature_loot_template` VALUES
(21214,34060,100,1,-34060,1,0,0,0);
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21214 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21214 AND `item` = 90052; -- 10
--
-- Morogrim Tidewalker 
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21213 AND `item` = 29434; -- 100
-- Item
DELETE FROM `creature_loot_template` WHERE `entry` = 21213 AND `item` = 34061;
INSERT INTO `creature_loot_template` VALUES
(21213,34061,100,1,-34061,2,0,0,0);
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21213 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 21213 AND `item` = 90052; -- 10

--
--
-- Alar Loot
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 19514 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19514 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19514 AND `item` = 190052; -- 2
--
-- Void Reaver
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 19516 AND `item` = 29434; -- 100
-- Token
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 19516 AND `item` = 34054; -- 2
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19516 AND `item` = 34052; -- 10
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19516 AND `item` = 90052; -- 2
--
-- Solarian
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 18805 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 18805 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 18805 AND `item` = 90052; -- 10
--
-- Kael'thas Sunstrider
-- BoJ
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 19622 AND `item` = 29434; -- 100
-- Pattern
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19622 AND `item` = 34052; -- 2
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 1 WHERE `entry` = 19622 AND `item` = 90052; -- 10
-- Items
DELETE FROM `creature_loot_template` WHERE `entry` = 19622 AND `item` = 90056; -- not needed
UPDATE `creature_loot_template` SET `groupid`= 0, `maxcount` = 2 WHERE `entry` = 19622 AND `item` = 34056; -- make 90056 not needed anymore
-- Tokens
UPDATE `creature_loot_template` SET `maxcount` = 1 WHERE `entry` = 19622 AND `item` = 50032; -- 3

-- Trash
--
-- <~1% fist entry 0,984
-- Patterns & Mark of Illidari
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`/3,`mincountOrRef`=0,`maxcount`=0 WHERE `item` IN (30321,30322,30323,30324,30280,30281,30282,30283,30301,30302,30303,30304,30305,30306,30307,30308);
-- >~1% first entry 1,0475
-- Nether Vortex
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`/3 WHERE `item` = 30183;
-- Random Epics <~1% first entry 0,3
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=`ChanceOrQuestChance`/3,`mincountOrRef`=0,`maxcount`=0 WHERE `item` IN (30020,30021,30022,30023,30024,30025,30026,30027,30028,30029,30030,30620);
--
-- Kael
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` IN (32405,34056,50032) AND `entry` = 19622;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 29905 AND `entry` = 21212;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 2 WHERE `item` = 32458 AND `entry` = 19622;
-- Vashj
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `item` IN (50031,90062) AND `entry` = 21212;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = -100 WHERE `item` = 29906 AND `entry` = 21212;
-- Boss Pattern
UPDATE `reference_loot_template` SET `mincountOrRef`=0, `maxcount`=0 WHERE `entry` IN (34052); -- 1 1

-- Setting Kael and Vashj Vortex back
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 25,`mincountOrRef`=2,`maxcount`=2 WHERE `entry` = 19622 AND `item` = 30183;
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 25,`mincountOrRef`=2,`maxcount`=2 WHERE `entry` = 21212 AND `item` = 30183;
-- 
-- 32902,32905
UPDATE `creature_loot_template` SET `mincountOrRef` = 0, `maxcount` = 0 WHERE `item` IN (32902,32905); -- 1 3
-- Coilfang Armaments
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21863 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21339 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21301 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21299 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21298 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21263 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21251 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21232 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21231 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21230 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21229 AND `item` = 24368; -- 16
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21228 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21227 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21226 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21225 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21224 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21221 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21220 AND `item` = 24368; -- 12
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 21218 AND `item` = 24368; -- 12

-- Mortog Steamhead 2.1 back
UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` = 84715; -- 1

-- Primal Nether / Nether Vortex
UPDATE `item_template` SET `flags`= 1 WHERE `entry` IN (30183,23572);

-- Design: Veiled Nightseye
INSERT IGNORE INTO `creature_loot_template` VALUES
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

-- Landmark under A'dal
UPDATE `gameobject` SET `spawnmask`=0 WHERE `guid` = 47204; -- 1

-- Reduce Damage due to Core Timer Changes
--
-- High King Maulgar – Hochkönig Maulgar 18831
UPDATE `creature_template` SET `mindmg`='10783',`maxdmg`='12805',`baseattacktime`='1500',`speed`='3.00' WHERE `entry` = 18831; -- 10783 12805 1449 -- 20487 24330 -- 21565 25610 

-- Magtheridon 17257
UPDATE `creature_template` SET `mindmg`='16000',`maxdmg`='20000',`baseattacktime`='2000',`speed`='3.00' WHERE `entry` = 17257; -- 16000 20000 -- 23207 27559 -- 25785 30621

-- SP Event Boss Gameobject
UPDATE `gameobject` SET `spawnmask`=3 WHERE `guid` = 3461739; -- 1
DELETE FROM `game_event_gameobject` WHERE `guid` = 3461739; -- nicht vorhanden
INSERT INTO `game_event_gameobject` VALUES
(3461739,1);

-- U 15.08.08
SET @GUID := 59464;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@GUID,@POINT := @POINT + '1','-455.0282','4862.6879','30.2490',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-489.4607','4881.5634','31.7768',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-519.2503','4890.5107','35.2500',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-540.9163','4880.7221','36.8381',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-552.9354','4857.9985','37.5230',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-523.6680','4806.4946','33.0417',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-487.4189','4805.9248','30.0893',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-477.1825','4859.6909','30.5836',0,0,0,100,0),
(@GUID,@POINT := @POINT + '1','-439.1553','4854.8764','28.7576',0,0,0,100,0);
-- (@PATH,@POINT := @POINT + '1','XXX','YYY','ZZZ',0,0,0,100,0),

DELETE FROM `creature_formations` WHERE `leaderguid` IN (59464,58904,58905,59461,58903,58902,68832,58165,58164);
DELETE FROM `creature_formations` WHERE `memberguid` IN (59464,58904,58905,59461,58903,58902,68832,58165,58164);
INSERT INTO `creature_formations` VALUES
--
(59464,59464,100,360,2),
(59464,58904,2,1,2),
(59464,58905,2,4,2),
--
(59461,59461,100,360,2),
(59461,58903,2,1,2),
(59461,58902,2,4,2),
--
(68832,68832,100,360,2),
(68832,58164,2,1,2),
(68832,58165,2,4,2);

DELETE FROM `creature_addon` WHERE `guid` = 6589096;
INSERT INTO `creature_addon` VALUES
(6589096,0,0,16777472,0,4097,0,0,'30205');

-- Manticron Cube 181713
UPDATE `gameobject_template` SET `data10` = 30410 WHERE `entry` = 181713; -- 30420 which is nonexistant

-- Honor Hold Defender1
UPDATE `creature_template` SET `modelid_A`='16387',`modelid_H`='16387',`modelid_A2`='16388',`modelid_H2`='16388',`faction_A`='1666',`faction_H`='1666',`armor`='5200',`speed`='1.20',`AIName`='EventAI',`minlevel`='68',`maxlevel`='68',`minhealth`='7716',`maxhealth`='7716',`mindmg`='214',`maxdmg`='267',`unit_flags`='0',`type_flags`='4096' WHERE `entry` = 16842;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16842');
INSERT INTO `creature_ai_scripts` VALUES
('1684201','16842','9','0','100','1','0','30','4000','8000','11','18396','1','7','0','0','0','0','0','0','0','0','Honor Hold Defender - Cast Dismounting Blast'),
(1684202,16842,0,0,100,1,3500,5500,10000,12000,11,15618,1,0,0,0,0,0,0,0,0,0,'Honor Hold Defender - Cast Snap Kick'),
(1684203,16842,0,0,100,1,8500,8500,15000,15000,11,19643,1,0,0,0,0,0,0,0,0,0,'Honor Hold Defender - Cast Mortal Strike');
--
-- Honor Hold Defender2
UPDATE `creature_template` SET `modelid_A`='16389',`modelid_H`='16389',`modelid_A2`='16390',`modelid_H2`='16390',`armor`='2800',`speed`='1.20',`AIName`='EventAI',`minhealth`='5874',`maxhealth`='5874',`mindmg`='107',`maxdmg`='160',`unit_flags`='0' WHERE `entry` = 20513;
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('20513');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20513');
INSERT INTO `creature_ai_scripts` VALUES
('2051301','20513','9','0','100','1','0','30','4000','8000','11','18396','1','7','0','0','0','0','0','0','0','0','Honor Hold Defender - Cast Dismounting Blast'),
(2051302,20513,0,0,100,1,3500,5500,10000,12000,11,15618,1,0,0,0,0,0,0,0,0,0,'Honor Hold Defender - Cast Snap Kick'),
(2051303,20513,0,0,100,1,8500,8500,15000,15000,11,19643,1,0,0,0,0,0,0,0,0,0,'Honor Hold Defender - Cast Mortal Strike');

-- Toxic Spore Bat 22140
-- mob_toxic_sporebat
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`minhealth`=10400,`maxhealth`=10530,`speed`=1.20 WHERE `entry` = 22140; -- 70 73 6986 6986 1 -- 8000 8200

-- Invisible Stalker (Floating) 23033
UPDATE `creature_template` SET `inhabittype`=7 WHERE `entry` = 23033; -- 3

DELETE FROM `item_template` WHERE `entry` = 40000;
INSERT INTO `item_template` VALUES (40000, 15, 0, -1, 'Welcome to L4G', 7629, 0, 0, 1, 1, 0, 0, -1, -1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, '', 4000, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);

-- 1 page
DELETE FROM `page_text` WHERE `entry` = 4000;
INSERT INTO `page_text` VALUES (4000, 'Welcome to Hellfire TBC!

Thank you for choosing our realm. We hope you will enjoy your stay here. Before you begin your journey, here are a few things to help you on your way:

1. The Murloc in front of you will take you through the process of obtaining level 60, choosing your gear-setup and teleport you to your class trainer where you can learn your skills.

2. Your Hearthstone is your one way ticket to Blasted Lands where you can reach the Outlands through the Dark Portal. ( Dont forget to set hearthstone to the next Inn )

3. You may notice you are unable to chat in global chat. It\'s set in place to neutralize illegal gold selling spam. Rest assured - you can still use /Say, /Whisper, /Yell and /Guild.

If you have any further questions, feel free to visit the Q & A Section of our forum board: http://looking4group.eu/hellfire/

Good luck and have fun in your adventures! Your L4G - Team.', 0);

#Set sell price to 1c for alliance start bags
update item_template set SellPrice = 1 where entry = 10050; -- 2500

DELETE FROM `playercreateinfo_item` WHERE `itemid` = 40000;
INSERT INTO `playercreateinfo_item` VALUES
-- (1791,1503,40000,1), 255 255 40000 1
(11,2,40000,1),
(1,2,40000,1),
(2,4,40000,1),
(3,4,40000,1),
(2,1,40000,1),
(1,1,40000,1),
(10,5,40000,1),
(4,4,40000,1),
(3,1,40000,1),
(4,1,40000,1),
(7,1,40000,1),
(8,1,40000,1),
(10,2,40000,1),
(5,1,40000,1),
(3,2,40000,1),
(10,4,40000,1),
(11,1,40000,1),
(6,1,40000,1),
(5,4,40000,1),
(7,4,40000,1),
(11,8,40000,1),
(1,9,40000,1),
(2,9,40000,1),
(5,9,40000,1),
(7,9,40000,1),
(10,9,40000,1),
(4,11,40000,1),
(6,11,40000,1),
(2,7,40000,1),
(6,7,40000,1),
(8,7,40000,1),
(10,8,40000,1),
(8,8,40000,1),
(8,4,40000,1),
(1,4,40000,1),
(3,5,40000,1),
(4,5,40000,1),
(5,5,40000,1),
(8,5,40000,1),
(1,5,40000,1),
(11,5,40000,1),
(1,8,40000,1),
(5,8,40000,1),
(7,8,40000,1),
(11,7,40000,1),
(3,3,40000,1),
(4,3,40000,1),
(11,3,40000,1),
(2,3,40000,1),
(6,3,40000,1),
(8,3,40000,1),
(0,3,40000,1),
(10,3,40000,1);
