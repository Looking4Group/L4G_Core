-- ================
-- 2.3
-- http://wowwiki.wikia.com/wiki/Patch_2.3.0
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

UPDATE `creature` SET `spawnmask`= 1 WHERE `id` IN (24369,24370,24393,25580);

-- ========
-- Creature Change
-- ========



-- ========
-- Quests & Access
-- ========

-- ZA
UPDATE `access_requirement` SET `level_min` = 70 WHERE `id` = 49;

-- ZA Quests
DELETE FROM `creature_questrelation` WHERE `quest` IN (11130,11164);
INSERT INTO `creature_questrelation` VALUES
(19227,11130),
(23761,11164);

-- Plans: Heavy Copper Longsword
UPDATE `quest_template` SET `RewItemId1` = 33792 WHERE `entry` = 1578;

-- Daily fishing quests
UPDATE `creature` SET `spawnmask` = 1 WHERE `id` = 25580;
-- Daily dungeon quests
UPDATE `creature` SET `spawnmask` = 1 WHERE `id` IN (24369, 24370);
-- Daily cooking quests
UPDATE `creature` SET `spawnmask` = 1 WHERE `id` = 24393;
-- Daily pvp quests
UPDATE `creature` SET `spawnmask` = 1 WHERE `id` IN (15350, 15351);
UPDATE `quest_template` set `RewHonorableKills` = 20, `RewMoneyMaxLevel` = 75900 where `entry` between 11335 and 11342; -- nonblizzlike 24 155999 blizzlike 20 75900

-- PvP Turn in Quest
UPDATE `quest_template` SET `ReqItemId1` = 0, `RewHonorableKills` = 15 WHERE `entry` IN (8388,8385); -- nonblizzlike 0 20 blizzlike 20560 15

-- ========
-- Loot
-- ========

-- Plans: Adamantite Weapon Chain
DELETE FROM `creature_loot_template` WHERE `item` = 35296;
INSERT INTO `creature_loot_template` VALUES (24857, 35296, 0, 2, 1, 1, 0, 0, 0);

-- Schematic: Field Repair Bot 110G
DELETE FROM `creature_loot_template` WHERE `item` = 34114;
INSERT INTO `creature_loot_template` VALUES (23386, 34114, 1.43, 0, 1, 1, 7, 202, 1);

-- Design: Chaotic Skyfire Diamond 
DELETE FROM `creature_loot_template` WHERE `item` = 34689;
INSERT INTO `creature_loot_template` VALUES (19768, 34689, 2, 0, 1, 1, 7, 755, 1);

-- Pattern: Bag of Many Hides
DELETE FROM `creature_loot_template` WHERE `item` = 34491;
INSERT INTO `creature_loot_template` VALUES (22143, 34491, 1.15, 0, 1, 1, 7, 165, 1);
INSERT INTO `creature_loot_template` VALUES (22144, 34491, 1.15, 0, 1, 1, 7, 165, 1);
INSERT INTO `creature_loot_template` VALUES (22148, 34491, 1.15, 0, 1, 1, 7, 165, 1);
INSERT INTO `creature_loot_template` VALUES (23022, 34491, 1.34, 0, 1, 1, 7, 165, 1);

-- Weather-Beaten Journal
DELETE FROM `item_loot_template` WHERE `item` = 34109;
INSERT INTO `item_loot_template` VALUES (20708, 34109, 5, 0, 1, 1, 0, 0, 0);
INSERT INTO `item_loot_template` VALUES (21113, 34109, 5, 0, 1, 1, 0, 0, 0);
INSERT INTO `item_loot_template` VALUES (21150, 34109, 5, 0, 1, 1, 0, 0, 0);
INSERT INTO `item_loot_template` VALUES (21228, 34109, 5, 0, 1, 1, 0, 0, 0);
INSERT INTO `item_loot_template` VALUES (27481, 34109, 11, 0, 1, 1, 0, 0, 0);
INSERT INTO `item_loot_template` VALUES (27513, 34109, 43, 0, 1, 1, 0, 0, 0);

-- Plans: Hammer of Righteous Might
DELETE FROM `reference_loot_template` WHERE `entry` = 10006 AND `item` = 33954;
INSERT INTO `reference_loot_template` VALUES (10006, 33954, 0, 1, 1, 1, 0, 0, 0);

-- ========
-- Items
-- ========



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

-- Mad Alchemist's Potion
DELETE FROM `npc_trainer` WHERE `spell` = 45061;
INSERT INTO `npc_trainer` VALUES (18802, 45061, 30000, 171, 325, 0);
INSERT INTO `npc_trainer` VALUES (16588, 45061, 30000, 171, 325, 0);
INSERT INTO `npc_trainer` VALUES (19052, 45061, 30000, 171, 325, 0);

-- Pattern: Green Winter Clothes
DELETE FROM `npc_vendor` WHERE `item` = 34261;
INSERT INTO `npc_vendor` VALUES (13420, 34261, 0, 0, 0);

-- Pattern: Winter Boots
DELETE FROM `npc_vendor` WHERE `item` = 34262;
INSERT INTO `npc_vendor` VALUES (13420, 34262, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (13433, 34262, 0, 0, 0);

-- Pattern: Red Winter Clothes
DELETE FROM `npc_vendor` WHERE `item` = 34319;
INSERT INTO `npc_vendor` VALUES (13433, 34319, 0, 0, 0);

-- Leatherworker's Satchel
DELETE FROM `npc_trainer` WHERE `spell` = 45100;
INSERT INTO `npc_trainer` VALUES (18754, 45100, 15000, 165, 300, 0);
INSERT INTO `npc_trainer` VALUES (18771, 45100, 15000, 165, 300, 0);
INSERT INTO `npc_trainer` VALUES (19187, 45100, 15000, 165, 300, 0);
INSERT INTO `npc_trainer` VALUES (21087, 45100, 15000, 165, 300, 0);

-- Glove Reinforcements
DELETE FROM `npc_trainer` WHERE `spell` = 44770;
INSERT INTO `npc_trainer` VALUES (18754, 44770, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (18771, 44770, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (19187, 44770, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (21087, 44770, 50000, 165, 350, 0);

-- Knothide Ammo Pouch
DELETE FROM `npc_trainer` WHERE `spell` = 44343;
INSERT INTO `npc_trainer` VALUES (18754, 44343, 18000, 165, 315, 0);
INSERT INTO `npc_trainer` VALUES (18771, 44343, 18000, 165, 315, 0);
INSERT INTO `npc_trainer` VALUES (19187, 44343, 18000, 165, 315, 0);
INSERT INTO `npc_trainer` VALUES (21087, 44343, 18000, 165, 315, 0);

-- Knothide Quiver
DELETE FROM `npc_trainer` WHERE `spell` = 44344;
INSERT INTO `npc_trainer` VALUES (18754, 44344, 18000, 165, 315, 0);
INSERT INTO `npc_trainer` VALUES (18771, 44344, 18000, 165, 315, 0);
INSERT INTO `npc_trainer` VALUES (19187, 44344, 18000, 165, 315, 0);
INSERT INTO `npc_trainer` VALUES (21087, 44344, 18000, 165, 315, 0);

-- Heavy Knothide Armor Kit
DELETE FROM `npc_trainer` WHERE `spell` = 44970;
INSERT INTO `npc_trainer` VALUES (18754, 44970, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (18771, 44970, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (21087, 44970, 50000, 165, 350, 0);
INSERT INTO `npc_trainer` VALUES (19187, 44970, 50000, 165, 350, 0);

-- Netherscale Ammo Pouch, Quiver of a Thousand Feathers
DELETE FROM `npc_vendor` WHERE `item` IN (34200,34201,34218);
INSERT INTO `npc_vendor` VALUES (17585, 34201, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 34218, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 34200, 0, 0, 0);

-- Flying Machine 
DELETE FROM `npc_trainer` WHERE `spell` = 44155;
INSERT INTO `npc_trainer` VALUES (24868, 44155, 120000, 202, 350, 70);
INSERT INTO `npc_trainer` VALUES (25099, 44155, 120000, 202, 350, 70);

-- Turbo-Charged Flying Machine
DELETE FROM `npc_trainer` WHERE `spell` = 44157;
INSERT INTO `npc_trainer` VALUES (24868, 44157, 200000, 202, 375, 70);
INSERT INTO `npc_trainer` VALUES (25099, 44157, 200000, 202, 375, 70);

-- 2.3 Rep PvP Gear
DELETE FROM `npc_vendor` where entry = 17585 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 17657 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 21655 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 17904 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 21432 AND item > 35000;
DELETE FROM `npc_vendor` where entry = 21643 AND item > 35000;

DELETE FROM `npc_vendor` WHERE `entry`  IN (17585,17657,21655,17904,21432,21643);
INSERT INTO `npc_vendor` VALUES (17585, 24000, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 24001, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 24002, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 24003, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 24004, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 24006, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 24009, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 25738, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 25739, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 25740, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 25823, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 25824, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29152, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29155, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29165, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29167, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29168, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29190, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29197, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 29232, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 30637, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 31358, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 31359, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 31361, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 31362, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 32882, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 33151, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 34201, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35332, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35337, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35339, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35343, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35360, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35364, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35366, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35371, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35377, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35383, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35386, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35392, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35406, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35409, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17585, 35413, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 22531, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 22547, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 22905, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 23142, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 23619, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 23999, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 24007, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 24008, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 24180, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 25825, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 25826, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 25870, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29151, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29153, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29156, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29166, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29169, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29189, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29196, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29213, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29214, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29215, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29719, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 29722, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 30622, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 32883, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 33150, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 34218, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35464, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35465, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35466, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35467, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35468, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35469, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35470, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35471, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35472, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35473, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35474, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35475, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35476, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35477, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17657, 35478, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 22918, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 22922, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 23618, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 23814, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 24183, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 24417, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 24429, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25526, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25735, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25736, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25737, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25835, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25836, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25838, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 25869, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 28271, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 28632, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29170, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29171, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29172, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29173, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29174, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29192, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29194, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29720, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 29721, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 30623, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 31356, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 31390, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 31391, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 31392, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 31402, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 31804, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 31949, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 32070, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 33149, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 33999, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35329, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35336, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35342, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35347, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35358, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35365, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35367, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35374, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35379, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35385, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35387, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35394, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35403, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35408, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (17904, 35415, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 13517, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 22537, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 22915, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 24182, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 25904, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 28273, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 28281, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29175, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29176, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29177, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29179, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29180, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29191, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29195, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 29717, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 30634, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 30826, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 31354, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 31781, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 33153, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 33155, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 33159, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35330, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35333, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35341, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35345, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35359, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35362, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35368, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35375, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35380, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35381, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35388, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35395, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35404, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35407, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 35416, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 22536, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 24174, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 24181, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 25910, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 28272, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29181, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29182, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29183, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29184, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29185, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29186, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29198, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 29713, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 30635, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 31355, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 31777, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 31951, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 33152, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 33158, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 33160, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35328, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35334, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35338, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35346, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35356, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35363, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35369, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35372, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35376, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35384, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35390, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35393, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35402, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35410, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 35414, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 22538, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 22910, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 23138, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 24175, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 24179, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 29199, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30633, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30830, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30832, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30833, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30834, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30835, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30836, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30841, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 30846, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 31357, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 31778, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 33148, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 33157, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 34200, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35331, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35335, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35340, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35344, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35357, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35361, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35370, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35373, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35378, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35382, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35389, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35391, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35405, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35411, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 35412, 0, 0, 0);

-- Cenarion War Hippogryph
DELETE FROM `npc_vendor` WHERE `item` = 33999;
INSERT INTO `npc_vendor` VALUES (17904, 33999, 0, 0, 0);

-- ========
-- Reputation
-- ========



-- =============================================================================================
-- Patch 2.4.0
-- Shattered Sun Offensive - We dont delte gameevents
-- SELECT * FROM `game_event` WHERE `entry` BETWEEN 35 AND 53;
-- =============================================================================================

-- SWP, MGT
-- UPDATE `access_requirement` SET `level_min` = 70 WHERE `id` IN (50, 51);

-- HC Keys at revered 
-- UPDATE `item_template` SET `RequiredReputationRank` = 5 WHERE `entry` IN (30634, 30623, 30622, 30637, 30635, 30633); -- 6

-- Brilliant Glass
DELETE FROM `npc_trainer` WHERE `spell` = 47280;
-- INSERT INTO `npc_trainer` VALUES (19539, 47280, 27000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (19063, 47280, 27000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (18774, 47280, 27000, 755, 350, 0);
-- INSERT INTO `npc_trainer` VALUES (18751, 47280, 27000, 755, 350, 0);

-- Schematic: Rocket Boots Xtreme Lite
DELETE FROM `reference_loot_template` WHERE `item` = 35582 AND `entry` = 50019;
-- INSERT INTO `reference_loot_template` VALUES (50019, 35582, 10, 0, 1, 1, 0, 0, 0);

-- Shattrath Flask of Pure Death
-- Shattrath Flask of Blinding Light
DELETE FROM `npc_vendor` WHERE `item` IN (35716,35717);
-- INSERT INTO `npc_vendor` VALUES (23483, 35716, 0, 0, 1959);
-- INSERT INTO `npc_vendor` VALUES (23483, 35717, 0, 0, 1959);
-- INSERT INTO `npc_vendor` VALUES (23484, 35716, 0, 0, 1959);
-- INSERT INTO `npc_vendor` VALUES (23484, 35717, 0, 0, 1959); 

-- Charred Bear Kabobs
-- Juicy Bear Burger
DELETE FROM `npc_vendor` WHERE `item` IN (35564,35566);
-- INSERT INTO `npc_vendor` VALUES (2803, 35564, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (2803, 35566, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (2806, 35564, 0, 0, 0);
-- INSERT INTO `npc_vendor` VALUES (2806, 35566, 0, 0, 0);

-- 2.4 Magtheridons Black Sack of Gems and Pit Lord's Satchel
-- UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 17257 AND `item` IN (34846,34845);

-- Riding

-- Horde Mounts `RequiredSkill` = 762 AND `RequiredSkillRank` = 75
-- UPDATE `item_template` SET `RequiredLevel` = 40, `BuyPrice` = 1 WHERE `entry` IN (1132,5665,5668,8588,8591,8592,13331,13332,13333,15277,15290,28927,29220,29221,29222,33224,33976,37012); -- 30 100000
-- UPDATE `npc_trainer` SET `spellcost` = 1, `reqlevel` = 40 WHERE `entry` IN (3690,4752,4773,7953,16280,20500) AND `spell` = 33388; -- 350000 900000 prenerf 30

-- Alliance Mounts
-- UPDATE `item_template` SET `RequiredLevel` = 40, `BuyPrice` = 100000 WHERE `entry` IN (2411,2414,5655,5656,5864,5872,5873,8563,8595,8629,8631,8632,13321,13322,28481,29743,29744); -- 30 100000
-- UPDATE `npc_trainer` SET `spellcost` = 500000, `reqlevel` = 40 WHERE `entry` IN (4732,4753,4772,7954,20914,20511) AND `spell` = 33388; -- 350000 900000 prenerf 30

-- Set Paladin and Warlock First Mount to 40
-- UPDATE `npc_trainer` SET `reqlevel` = 40 WHERE `spell` IN (5784,13819,34769); -- 30

-- Horde Warlock and Paladin First Mount at Horde Incentive Discount
-- UPDATE `npc_trainer` SET `spellcost` = 0 WHERE `spell` IN (5784,13819,34769) AND `entry` IN (988,2127,3172,3324,3325,3326,4563,4564,4565,16266,16275,16646,16647,16648,16679,16680,16681,17844,20406,23128,23534); -- 10000

-- Alliance Warlock and Paladin First Mount at Alliance Incentive Discount
-- UPDATE `npc_trainer` SET `spellcost` = 3333 WHERE `spell` IN (5784,13819,34769) AND `entry` IN (5495,5496,906,459,461,5171,5173,5172,460,5612,5491,5492,925,927,928,5147,5148,5149,926,1232,8140,17483,17509,16501,16761,17121); -- 10000

-- ===========================================================================================

UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';
