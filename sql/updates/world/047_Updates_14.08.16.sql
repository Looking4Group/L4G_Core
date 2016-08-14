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
-- Setting Kael and Vashj Vortex back
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 25,`mincountOrRef`=2,`maxcount`=2 WHERE `entry` IN (19622,21212) AND `item` = 30183; 
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
UPDATE `creature_template` SET `mindmg`='10783',`maxdmg`='12805',`baseattacktime`='1500',`speed`='3.00' WHERE `entry` IN ('18831'); -- 10783 12805 1449 -- 20487 24330 -- 21565 25610 

-- Magtheridon 17257
UPDATE `creature_template` SET `mindmg`='16000',`maxdmg`='20000',`baseattacktime`='2000',`speed`='3.00' WHERE `entry` IN ('17257'); -- 16000 20000 -- 23207 27559 -- 25785 30621

UPDATE `gameobject` SET `spawnmask`=3 WHERE `guid` = 3461739; -- 1
DELETE FROM `game_event_gameobject` WHERE `guid` = 3461739; -- nicht vorhanden
INSERT INTO `game_event_gameobject` VALUES
(3461739,1);
