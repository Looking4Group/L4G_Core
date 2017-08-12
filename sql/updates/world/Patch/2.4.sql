-- ================
-- 2.4
-- http://wowwiki.wikia.com/wiki/Patch_2.4.0
-- ================

-- ========
-- Temp Out
-- ========

-- ========
-- Creatures
-- ========



-- ========
-- Creature Phase OUT
-- ========



-- ========
-- Creature Phase IN
-- ========

UPDATE `creature` SET `spawnmask` = 1 WHERE `id` IN (18594,24917,18594,19202,19216,19475,24932,24937,24938,25134,25135,25136,25137,25138,25140,25141,25142,25143,25153,25155,25167,25885,27667,27666,27711,24918,24933,24918,24933,24919);
UPDATE `creature` SET `spawnmask` = 1 WHERE `guid` IN (34137,34138,34139,44253,40444);

UPDATE `gameobject` SET `spawnmask` = 1 WHERE `guid` IN (47204);

-- ========
-- Creature Change
-- ========



-- ========
-- Quests & Access
-- ========

-- SWP, MGT
UPDATE `access_requirement` SET `level_min` = 70 WHERE `id` IN (50, 51);

-- ========
-- Loot
-- ========

-- Schematic: Rocket Boots Xtreme Lite
DELETE FROM `reference_loot_template` WHERE `item` = 35582 AND `entry` = 50019;
INSERT INTO `reference_loot_template` VALUES (50019, 35582, 10, 0, 1, 1, 0, 0, 0);

-- 2.4 Magtheridons Black Sack of Gems and Pit Lord's Satchel
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 17257 AND `item` IN (34846,34845);

-- ========
-- Items
-- ========

-- HC Keys at revered 
UPDATE `item_template` SET `RequiredReputationRank` = 5 WHERE `entry` IN (30634, 30623, 30622, 30637, 30635, 30633); -- 6

-- ========
-- Gameobjects
-- ========



-- ========
-- Trainer & Vendor
-- ========

-- G'eras
DELETE FROM `npc_vendor` WHERE `entry` = 18525;
-- 2.0
INSERT INTO `npc_vendor` VALUES (18525, 29266, 0, 0, 1037);
INSERT INTO `npc_vendor` VALUES (18525, 29267, 0, 0, 1037);
INSERT INTO `npc_vendor` VALUES (18525, 29268, 0, 0, 1037);
INSERT INTO `npc_vendor` VALUES (18525, 29269, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29270, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29271, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29272, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29273, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29274, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29275, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 29367, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29368, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29369, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29370, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29373, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29374, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29375, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29376, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29379, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29381, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29382, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29383, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29384, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29385, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29386, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 29387, 0, 0, 1027);
INSERT INTO `npc_vendor` VALUES (18525, 29388, 0, 0, 1642);
INSERT INTO `npc_vendor` VALUES (18525, 29389, 0, 0, 1642);
INSERT INTO `npc_vendor` VALUES (18525, 29390, 0, 0, 1642);
INSERT INTO `npc_vendor` VALUES (18525, 30761, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30762, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30763, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30764, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30766, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30767, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30768, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30769, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30770, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30772, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30773, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30774, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30776, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30778, 0, 0, 1454);
INSERT INTO `npc_vendor` VALUES (18525, 30779, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 30780, 0, 0, 1452);
-- 2.1
INSERT INTO `npc_vendor` VALUES (18525, 23572, 0, 0, 1909);
INSERT INTO `npc_vendor` VALUES (18525, 32083, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32084, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32085, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32086, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32087, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32088, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32089, 0, 0, 1040);
INSERT INTO `npc_vendor` VALUES (18525, 32090, 0, 0, 1040);
-- 2.3
INSERT INTO `npc_vendor` VALUES (18525, 33192, 0, 0, 1015);
INSERT INTO `npc_vendor` VALUES (18525, 33207, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33222, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33279, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33280, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33287, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33291, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33296, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33304, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33324, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33325, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33331, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33333, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33334, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33386, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33484, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33501, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33502, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33503, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33504, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33505, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33506, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33507, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33508, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33509, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33510, 0, 0, 1452);
INSERT INTO `npc_vendor` VALUES (18525, 33512, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33513, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33514, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33515, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33516, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33517, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33518, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33519, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33520, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33522, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33523, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33524, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33527, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33528, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33529, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33530, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33531, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33532, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33534, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33535, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33536, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33537, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33538, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33539, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33540, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33552, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33557, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33559, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33566, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33577, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33578, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33579, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33580, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33582, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33583, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33584, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33585, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33586, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33587, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33588, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33589, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33593, 0, 0, 2060);
INSERT INTO `npc_vendor` VALUES (18525, 33810, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33965, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33970, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33972, 0, 0, 2049);
INSERT INTO `npc_vendor` VALUES (18525, 33973, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 33974, 0, 0, 2059);
-- Battlemaster Trinkets Season 3
-- INSERT INTO `npc_vendor` VALUES (18525, 33832, 0, 0, 2049);
-- INSERT INTO `npc_vendor` VALUES (18525, 34049, 0, 0, 2049);
-- INSERT INTO `npc_vendor` VALUES (18525, 34050, 0, 0, 2049);
-- INSERT INTO `npc_vendor` VALUES (18525, 34162, 0, 0, 2049);
-- INSERT INTO `npc_vendor` VALUES (18525, 34163, 0, 0, 2049);
-- 2.4
INSERT INTO `npc_vendor` VALUES (18525, 30183, 0, 0, 1642);
INSERT INTO `npc_vendor` VALUES (18525, 35321, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 35324, 0, 0, 2059);
INSERT INTO `npc_vendor` VALUES (18525, 35326, 0, 0, 2049);

-- Brilliant Glass
DELETE FROM `npc_trainer` WHERE `spell` = 47280;
INSERT INTO `npc_trainer` VALUES (19539, 47280, 27000, 755, 350, 0);
INSERT INTO `npc_trainer` VALUES (19063, 47280, 27000, 755, 350, 0);
INSERT INTO `npc_trainer` VALUES (18774, 47280, 27000, 755, 350, 0);
INSERT INTO `npc_trainer` VALUES (18751, 47280, 27000, 755, 350, 0);

-- Shattrath Flask of Pure Death
-- Shattrath Flask of Blinding Light
DELETE FROM `npc_vendor` WHERE `item` IN (35716,35717);
INSERT INTO `npc_vendor` VALUES (23483, 35716, 0, 0, 1959);
INSERT INTO `npc_vendor` VALUES (23483, 35717, 0, 0, 1959);
INSERT INTO `npc_vendor` VALUES (23484, 35716, 0, 0, 1959);
INSERT INTO `npc_vendor` VALUES (23484, 35717, 0, 0, 1959); 

-- Charred Bear Kabobs
-- Juicy Bear Burger
DELETE FROM `npc_vendor` WHERE `item` IN (35564,35566);
INSERT INTO `npc_vendor` VALUES (2803, 35564, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (2803, 35566, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (2806, 35564, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (2806, 35566, 0, 0, 0);

-- ========
-- Reputation
-- ========



-- ========
-- Riding
-- ========

-- Horde Mounts `RequiredSkill` = 762 AND `RequiredSkillRank` = 75
UPDATE `item_template` SET `RequiredLevel` = 30, `BuyPrice` = 100000 WHERE `entry` IN (1132,5665,5668,8588,8591,8592,13331,13332,13333,15277,15290,28927,29220,29221,29222,33224,33976,37012); -- 30 100000
UPDATE `npc_trainer` SET `spellcost` = 350000, `reqlevel` = 30 WHERE `entry` IN (3690,4752,4773,7953,16280,20500) AND `spell` = 33388; -- 350000 (900000 prenerf) 30

-- Alliance Mounts
UPDATE `item_template` SET `RequiredLevel` = 30, `BuyPrice` = 100000 WHERE `entry` IN (2411,2414,5655,5656,5864,5872,5873,8563,8595,8629,8631,8632,13321,13322,28481,29743,29744); -- 30 100000
UPDATE `npc_trainer` SET `spellcost` = 350000, `reqlevel` = 30 WHERE `entry` IN (4732,4753,4772,7954,20914,20511) AND `spell` = 33388; -- 350000 900000 prenerf 30

-- Set Paladin and Warlock First Mount to 40
UPDATE `npc_trainer` SET `reqlevel` = 30 WHERE `spell` IN (5784,13819,34769);

-- Horde Warlock and Paladin First Mount at Horde Incentive Discount
UPDATE `npc_trainer` SET `spellcost` = 10000 WHERE `spell` IN (5784,13819,34769) AND `entry` IN (988,2127,3172,3324,3325,3326,4563,4564,4565,16266,16275,16646,16647,16648,16679,16680,16681,17844,20406,23128,23534); -- 10000

-- Alliance Warlock and Paladin First Mount at Alliance Incentive Discount
UPDATE `npc_trainer` SET `spellcost` = 10000 WHERE `spell` IN (5784,13819,34769) AND `entry` IN (5495,5496,906,459,461,5171,5173,5172,460,5612,5491,5492,925,927,928,5147,5148,5149,926,1232,8140,17483,17509,16501,16761,17121); -- 10000

-- ===========================================================================================

UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';
