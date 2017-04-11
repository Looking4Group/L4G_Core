-- Death's Door Fel Cannon Target Bunny
UPDATE `creature` SET `position_x` = 2195.8024, `position_y` = 5475.7568, `position_z` = 163.7464, `orientation` = 0.2682,`spawndist`='0',`movementtype`='0',`spawntimesecs`='1' WHERE `guid` = 78947;
-- UPDATE `creature_template` SET `flags_extra` = 130, `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 22495; -- 35 130

-- Blade's Edge - Legion - Invis Bunny
UPDATE `creature_template` SET `AIName` = 'EventAI', `InhabitType` = 5, `flags_extra`=130 WHERE `entry` = 20736;

-- Death's Door North Warp-Gate
UPDATE `creature` SET `position_x` = '2196.6601', `position_y` = '5474.8798', `position_z` = '153.5782', `spawntimesecs` = 60 WHERE `guid` = 78881;
UPDATE `creature_template` SET `mindmg` = 1, `maxdmg` = 1, `AIName` = 'EventAI', `flags_extra`= 2 WHERE `entry` = 22471; -- 202 350

-- Death's Door South Warp-Gate
UPDATE `creature` SET `position_x` = '1968.8369', `position_y` = '5316.9965', `position_z` = '154.0295', `spawntimesecs` = 60 WHERE `guid` = 78882;
UPDATE `creature_template` SET `mindmg` = 1, `maxdmg` = 1, `AIName` = 'EventAI', `flags_extra`= 2 WHERE `entry` = 22472; -- 202 350

-- Void Hound
UPDATE `creature_template` SET `modelid_A` = 17188, `modelid_H` = 17188 WHERE `entry` = 22500;

-- Canons
UPDATE `creature` SET `orientation` = '5.8660', `spawntimesecs` = 60 WHERE `guid` = 78794;
UPDATE `creature` SET `orientation` = '3.3174', `spawntimesecs` = 60 WHERE `guid` = 78793;

-- AIs
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (20736,22471,22472);
INSERT INTO `creature_ai_scripts` VALUES (2073601, 20736, 4, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Blade\'s Edge - Legion - Invis Bunny - Disable Melee on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2247101, 22471, 4, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Door North Warp-Gate - Invis Bunny - Disable Melee on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (2247201, 22472, 4, 0, 100, 0, 0, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Death\'s Door South Warp-Gate - Invis Bunny - Disable Melee on Aggro');

-- Godan 3345
UPDATE `creature_template` SET `equipment_id` = 0 WHERE `entry` = 3345; -- 488 Fishing Pole now not used in any template

UPDATE `creature` SET `position_x` = '-185.0473', `position_y` = '206.4911', `position_z` = '78.8817' WHERE `guid` = 15507;
UPDATE `creature` SET `position_x` = '-181.6646', `position_y` = '68.2096', `position_z` = '67.8410' WHERE `guid` = 16655;

-- 3239,3240,3685 Benedict's Chest, Taillasher Eggs, Silithid Mound Lootable
UPDATE `gameobject_template` SET `faction` = 0 WHERE `entry` IN (3239,3240,3685);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16473;
INSERT INTO `creature_ai_scripts` VALUES
('1647301','16473','0','0','70','3','5000','10000','11000','15000','11','29680','0','0','0','0','0','0','0','0','0','0','Spectral Performer - Cast Curtain Call'),
('1647302','16473','0','0','100','3','11000','17000','15000','21000','11','29679','1','32','0','0','0','0','0','0','0','0','Spectral Performer - Cast Bad Poetry'),
('1647303','16473','2','0','100','3','50','0','25000','35000','11','29683','0','1','0','0','0','0','0','0','0','0','Spectral Performer - Cast Spotlight at 50% HP'),
('1647304','16473','6','0','20','2','0','0','0','0','1','-138','0','0','0','0','0','0','0','0','0','0','Spectral Performer - Say on Death');

UPDATE `creature_template` SET `mechanic_immune_mask`='1039089663' WHERE `entry` = 16473;

DELETE FROM `gameobject` WHERE `guid` IN (13691202,13674995);
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16231.7783', `position_y` = '16282.6748', `position_z` = '20.8547', `orientation` = '5.3060', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13675185;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16229.9443', `position_y` = '16254.8974', `position_z` = '13.4824', `orientation` = '2.3175', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 14107551;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16231.1718', `position_y` = '16263.1748', `position_z` = '13.4947', `orientation` = '3.2640', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13675189;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16219.2783', `position_y` = '16260.9707', `position_z` = '13.3842', `orientation` = '0.1538', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13675190;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16230.2246', `position_y` = '16267.2109', `position_z` = '13.2607', `orientation` = '3.5270', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 13676379;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16219.8271', `position_y` = '16265.9970', `position_z` = '13.2733', `orientation` = '5.6005', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 14072713;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16221.7968', `position_y` = '16257.0742', `position_z` = '13.1844', `orientation` = '1.1354', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 12929294;
UPDATE `gameobject` SET `id` = 185444, `position_x` = '16231.6474', `position_y` = '16258.8544', `position_z` = '13.7686', `orientation` = '3.2364', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 12917797;
UPDATE `gameobject` SET `id` = 187345, `position_x` = '16224.1142', `position_y` = '16262.0175', `position_z` = '13.2639', `orientation` = '4.8466', `rotation0` = 0, `rotation1` = 0, `rotation2` = 0, `rotation3` = 0 WHERE `guid` = 14023982;

DELETE FROM `creature_ai_scripts` WHERE `id` = 1832501;
INSERT INTO `creature_ai_scripts` VALUES ('1832501','18325','0','0','100','7','8700','12700','10000','15000','11','27641','4','0','0','0','0','0','0','0','0','0','Sethekk Prophet - Cast Fear');

-- Tazan's Satchel
UPDATE `item_template` SET `flags` = 0 WHERE `entry` = 7209; -- 4

UPDATE `creature` SET `spawnmask` = 3, `spawntimesecs` = 86400 WHERE `id` = 17695 AND `spawntimesecs` = 7200;
DELETE FROM `pool_template` WHERE `entry` = 30028;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30028','5','Shattared Halls - Shattered Hand Assassin - Pool'); 
DELETE FROM `pool_creature` WHERE `pool_entry` = 30028;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99941,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99949,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99942,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99943,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99944,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99946,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99948,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99940,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99939,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99947,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99945,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (99954,'30028','0','Shattared Halls - Shattered Hand Assassin - Pool');

DELETE FROM `creature` WHERE `guid` IN (15373,15484,15487,15466,15480,15482);
INSERT INTO `creature` VALUES (15373, 2375, 0, 1, 3617, 0, -1108.67, -39.2486, -2.84983, 0.361285, 300, 10, 0, 950, 0, 0, 1);
INSERT INTO `creature` VALUES (15466, 2349, 0, 1, 6808, 0, -285.62, -1156.22, 53.6537, 6.20492, 300, 10, 0, 664, 0, 0, 1);
INSERT INTO `creature` VALUES (15484, 2348, 0, 1, 8014, 0, -781.564, -891.376, 27.1351, 4.64985, 300, 5, 0, 788, 0, 0, 1);
INSERT INTO `creature` VALUES (15487, 2349, 0, 1, 6808, 0, -554.877, -972.102, 43.8503, 0.59589, 300, 10, 0, 664, 0, 0, 1);
INSERT INTO `creature` VALUES (15480, 2350, 0, 1, 1989, 0, -705.869, 388.254, 70.2089, 2.22054, 300, 10, 0, 494, 0, 0, 1);
INSERT INTO `creature` VALUES (15482, 2356, 0, 1, 3201, 0, -583.157, -950.196, 40.9115, 2.38018, 300, 10, 0, 944, 0, 0, 1);

-- Illidari Highlord 19797
UPDATE `creature_template` SET `speed`='1.20',`mechanic_immune_mask`='75569267',`flags_extra`='1073741824'  WHERE `entry` = 19797; -- 67110917

-- Illidari Mind Breaker 22074
UPDATE `creature_template` SET `speed`='1.20' WHERE `entry` = 22074;

-- Illidari Soldier 22075
UPDATE `creature_template` SET `speed`='1.20' WHERE `entry` = 22075;

-- Torloth the Magnificent 22076
UPDATE `creature_template` SET `speed`='1.48',`flags_extra`='1073741826' WHERE `entry` = 22076;

UPDATE `creature_template` SET `maxhealth`='22958',`speed`='0.6',`mindmg`='557',`maxdmg`='662',`mechanic_immune_mask`='650853375',`flags_extra`='1086390272' WHERE `entry` = 23375; -- 20958 0.5 100 205 -- 557 - 662

-- Aran Elemental Outsource

DELETE FROM `creature` WHERE `guid` IN (135128,135129,135130,135131,135132,135133,135138,135154);
DELETE FROM `creature_formations` WHERE `leaderguid` IN (57440,49978,50716,49805,50521,135172);
DELETE FROM `creature_formations` WHERE `memberguid` IN (57440,49978,50716,49805,50521,135172);
INSERT INTO `creature_formations` VALUES
(135172, 135172, 100, 360, 2),
(135172, 57440, 100, 360, 2),
(135172, 49978, 100, 360, 2),
(135172, 50716, 100, 360, 2),
(135172, 49805, 100, 360, 2),
(135172, 50521, 100, 360, 2);

DELETE FROM `creature_linked_respawn` WHERE `guid` = 45682;
INSERT INTO `creature_linked_respawn` VALUES (45682, 57440);

-- Shade of Aran Teleport Center 17176- Used for Elemental Check
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `AIName` = '' WHERE `entry` = 17176; -- `unit_flags` = 33554432 35 128
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17176;

UPDATE `creature` SET `spawntimesecs` = 780 WHERE `id` IN (17171,17168,17170,17169,17161,17176);
UPDATE `creature_template` SET `minlevel` = 70, `maxlevel` = 70, `minmana` = 0, `maxmana` = 0, `faction_A` = 16, `faction_H` = 16, `AIName` = 'EventAI' WHERE `entry` IN (17171,17168,17170,17169);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (17171,17168,17170,17169,17176);
INSERT INTO `creature_ai_scripts` VALUES 
(1716801, 17168, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport N - Stop Movement and Stop Melee on Aggro'),
(1716802, 17168, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 29962, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport N - Cast Summon Water Elemental on 40% Shade of Aran HP'), -- 40% HP 
(1716803, 17168, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport N - Call for Help and Despawn'),

(1716901, 17169, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport S - Stop Movement and Stop Melee on Aggro'),
(1716902, 17169, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 37053, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport S - Cast Summon Water Elemental on 40% Shade of Aran HP'),
(1716903, 17169, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport S - Call for Help and Despawn'),

(1717001, 17170, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport E - Stop Movement and Stop Melee on Aggro'),
(1717002, 17170, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 37051, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport E - Cast Summon Water Elemental on 40% Shade of Aran HP'),
(1717003, 17170, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport E - Call for Help and Despawn'),

(1717101, 17171, 4, 0, 100, 2, 0, 0, 0, 0, 21, 0, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport W - Stop Movement and Stop Melee on Aggro'),
(1717102, 17171, 14, 0, 100, 2, 601630, 80, 0, 0, 11, 37052, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport W - Cast Summon Water Elemental on 40% Shade of Aran HP'),
(1717103, 17171, 14, 0, 100, 2, 606630, 80, 0, 0, 39, 5, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0,'Shade of Aran Teleport W - Call for Help and Despawn');

-- Conjured Elemental 17167- mob_aran_elemental
UPDATE `creature_template` SET `faction_A` = 16, `faction_H` = 16, `mindmg` = 300, `maxdmg` = 600, `AIName` = 'EventAI', `ScriptName` = '' WHERE `entry` = 17167;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17167;
INSERT INTO `creature_ai_scripts` VALUES ('1716701','17167','9','0','100','3','0','40','1500','4000','11','31012','1','0','0','0','0','0','0','0','0','0','Conjured Elemental - Cast Water Bolt');
INSERT INTO `creature_ai_scripts` VALUES ('1716702','17167','1','0','100','3','1000','1000','3000','3000','38','0','0','0','0','0','0','0','0','0','0','0','Conjured Elemental - DoZoneInCombat OOC');
INSERT INTO `creature_ai_scripts` VALUES ('1716703','17167','1','0','100','2','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Conjured Elemental - Despawn OOC');

-- Shade of Aran 16524
UPDATE `creature_template` SET `mindmg`='2295',`maxdmg`='2760',`baseattacktime`='2000',`speed`='2.40',`flags_extra` = `flags_extra`|2|1048576 WHERE `entry` = 16524; -- 3060 3679 -- 4,590 - 5,519

-- Blizzard (Shade of Aran) 17161
UPDATE `creature_template` SET `speed` = 1.20, `unit_flags`='33554432',`flags_extra`='130' WHERE `entry` = 17161; -- 1,125 33554432 128

-- https://github.com/Looking4Group/L4G_Core/pull/3385
UPDATE creature_template SET ScriptName = 'npc_bloodmaul_dire_wolf' WHERE entry = 20058;
UPDATE `quest_template` SET `ReqCreatureOrGOId1`=21176, `ReqSpellCast1`=0 WHERE entry=10506;

-- Droggam should only drop one of the quest items, not both.
-- https://github.com/Looking4Group/L4G_Core/issues/3374
DELETE FROM `creature_loot_template` WHERE  `entry`=20731 AND `item`=30415;

DELETE FROM `looking4group_string` WHERE `entry`=2026;
INSERT INTO `looking4group_string` (`entry`, `content_default`) VALUES 
('2026', '|cff00ff00Character|r %s |cff00ff00was reported for spam. Ticket entry:|r|cffff00ff %d.|r');

UPDATE `creature_template` SET `mechanic_immune_mask`='787431407' WHERE `entry` = 17546;

UPDATE `creature_template` SET `mindmg`='3956',`maxdmg`='4698' WHERE `entry` = 16181;

-- Recipe: Transmute Primal Might Restocktime
UPDATE `npc_vendor` SET `maxcount` = 1, `incrtime` = 9000 WHERE `item` = 23574; -- 43200

UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` IN (16595, 16596);

DELETE FROM `gameobject` WHERE `guid` IN (82599,82598,82597);

