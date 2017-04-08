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

