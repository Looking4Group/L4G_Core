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

