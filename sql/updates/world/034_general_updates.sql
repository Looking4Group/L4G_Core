--
UPDATE `gameobject` SET `position_x`='-10920.6640', `position_y`='-2696.3110', `position_z`='13.3734', `orientation`='2.4430' WHERE `guid` IN ('3486810');

-- Searscale Drake 7046
UPDATE `creature_template` SET `Inhabittype`='3' WHERE `entry` IN ('7046'); -- 5
-- Scalding Drake 7045
UPDATE `creature_template` SET `Inhabittype`='3' WHERE `entry` IN ('7045'); -- 5

-- Thaurissan Agent 7038
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('7038');
INSERT INTO `creature_ai_scripts` VALUES
('703800','7038','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Thaurissan Agent - Start Movement and Set Melee Weapon Model'),
('703801','7038','4','0','100','0','0','0','0','0','22','1','0','0','0','','0','0','0','0','0','0','Thaurissan Agent - Set Phase 1 and Start Movement OOC'),
('703802','7038','9','1','100','1','5','30','2200','3000','11','6660','1','0','40','2','0','0','21','0','0','0','Thaurissan Agent - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('703803','7038','9','1','100','1','5','30','36300','50000','11','6685','1','0','40','2','0','0','21','0','0','0','Thaurissan Agent - Cast Piercing Shot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('703804','7038','9','0','100','1','0','5','13300','24100','11','12540','4','0','0','0','0','0','0','0','0','0','Thaurissan Agent - Cast Gouge'),
('703805','7038','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Thaurissan Agent - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('703806','7038','7','0','100','0','0','0','0','0','22','0','0','0','40','1','0','0','21','1','0','0','Thaurissan Agent - Set Phase 0 and Set Melee Weapon Model and Start Movement on Evade'),
('703807','7038','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Thaurissan Agent - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');
--
-- Dark Iron Lookout 8566
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('8566');
INSERT INTO `creature_ai_scripts` VALUES
('856600','8566','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Dark Iron Lookout - Start Movement and Set Melee Weapon Model'),
('856601','8566','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Dark Iron Lookout - Set Phase 1 on Aggro'),
('856602','8566','4','0','15','0','0','0','0','0','1','-5','-6','0','0','0','0','0','0','0','0','0','Dark Iron Lookout - Say on Aggro'),
('856603','8566','9','5','100','1','5','30','1200','2400','11','6660','1','0','40','2','0','0','21','0','0','0','Dark Iron Lookout - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('856604','8566','2','0','100','0','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Dark Iron Lookout - Set Phase 2 at 15% HP'),
('856605','8566','2','3','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Dark Iron Lookout - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('856606','8566','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Dark Iron Lookout - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('856607','8566','7','0','100','0','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Dark Iron Lookout - Set Phase 1 and Set Melee Weapon Model and Start Movement on Evade'),
('856608','8566','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Dark Iron Lookout - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('702801','702806');

-- Dustbelcher Wyrmhunter 2716
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('2716');
INSERT INTO `creature_ai_scripts` VALUES
('271600','2716','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Dustbelcher Wyrmhunter - Start Movement and Set Melee Weapon Model'),
('271601','2716','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Dustbelcher Wyrmhunter - Set Phase 1 on Aggro'),
('271602','2716','4','0','10','0','0','0','0','0','1','-359','-360','-361','0','0','0','0','0','0','0','0','Dustbelcher Wyrmhunter - Random Say on Aggro'),
('271603','2716','9','1','100','1','5','30','2300','5900','11','9483','1','0','21','0','0','0','0','0','0','0','Dustbelcher Wyrmhunter - Cast Boulder and Stop Movement (Phase 1)'),
('271604','2716','0','0','100','1','18600','24700','21100','30400','11','6533','1','1','21','0','0','0','0','0','0','0','Dustbelcher Wyrmhunter - Cast Net and Stop Movement'),
('271605','2716','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Dustbelcher Wyrmhunter - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('271606','2716','7','0','100','0','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Dustbelcher Wyrmhunter - Set Phase 1 and Set Melee Weapon Model and Start Movement on Evade'),
('271607','2716','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Dustbelcher Wyrmhunter - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('271801','271807');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('290701','290706');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('484401','484407');

-- Haren Swifthoof 2478 & Gradok 2477 & Thragomm 7170
UPDATE `creature_template` SET `speed`='1.49' WHERE `entry` IN ('2478');
UPDATE `creature_template` SET `speed`='1.49' WHERE `entry` IN ('2477');
UPDATE `creature_template` SET `speed`='1.49' WHERE `entry` IN ('7170');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('105401','105407');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('2103');
INSERT INTO `creature_ai_scripts` VALUES
('210300','2103','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Dragonmaw Scout - Start Movement and Set Melee Weapon Model'),
('210301','2103','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Dragonmaw Scout - Set Phase 1 on Aggro'),
('210302','2103','4','0','15','0','0','0','0','0','1','-101','-102','-105','0','0','0','0','0','0','0','0','Dragonmaw Scout - Random Say on Aggro'),
('210303','2103','9','5','100','1','5','30','2400','3600','11','6660','1','0','40','2','0','0','21','0','0','0','Dragonmaw Scout - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('210304','2103','2','0','100','0','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Dragonmaw Scout - Set Phase 2 at 15% HP'),
('210305','2103','2','3','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Dragonmaw Scout - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('210306','2103','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Dragonmaw Scout - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('210307','2103','7','0','100','0','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Dragonmaw Scout - Set Phase 1 and Set Melee Weapon Model and Start Movement on Evade'),
('210308','2103','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Dragonmaw Scout - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('257001','257008');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('257301','257308');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('257701','257707');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('2587');
INSERT INTO `creature_ai_scripts` VALUES
('258700','2587','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Syndicate Pathstalker - Start Movement and Set Melee Weapon Model'),
('258701','2587','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Syndicate Pathstalker - Set Phase 1 on Aggro'),
('258702','2587','4','0','15','0','0','0','0','0','1','-5','-6','0','0','0','0','0','0','0','0','0','Syndicate Pathstalker - Random Aggro Say'),
('258703','2587','9','5','100','1','5','30','2200','3800','11','6660','1','0','40','2','0','0','21','0','0','0','Syndicate Pathstalker - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('258704','2587','2','0','100','0','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Syndicate Pathstalker - Set Phase 2 at 15% HP'),
('258705','2587','2','3','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Syndicate Pathstalker - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('258706','2587','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Syndicate Pathstalker - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('258707','2587','7','0','100','0','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Syndicate Pathstalker - Set Phase 1 and Set Melee Weapon Model and Start Movement on Evade'),
('258708','2587','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Syndicate Pathstalker - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('2554');
INSERT INTO `creature_ai_scripts` VALUES
('255400','2554','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Witherbark Axe Thrower - Start Movement and Set Melee Weapon Model'),
('255401','2554','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Witherbark Axe Thrower - Set Phase 1 on Aggro'),
('255402','2554','9','5','100','1','5','30','2100','4800','11','10277','1','0','40','2','0','0','21','0','0','0','Witherbark Axe Thrower - Cast Throw and Set Ranged Weapon Model (Phase 1)'),
('255403','2554','0','0','100','1','10200','26000','2500','6700','11','4974','1','32','0','0','0','0','0','0','0','0','Witherbark Axe Thrower - Cast Wither Touch'),
('255404','2554','2','0','100','0','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Witherbark Axe Thrower - Set Phase 2 at 15% HP'),
('255405','2554','2','3','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Witherbark Axe Thrower - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('255406','2554','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Witherbark Axe Thrower - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('255407','2554','7','0','100','0','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Witherbark Axe Thrower - Set Phase 1 and Set Melee Weapon Model and Start Movement on Evade'),
('255408','2554','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Witherbark Axe Thrower - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('3377');
INSERT INTO `creature_ai_scripts` VALUES
('337700','3377','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Bael\'dun Rifleman - Start Movement and Set Melee Weapon Model'),
('337701','3377','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Bael\'dun Rifleman - Set Phase 1 on Aggro'),
('337702','3377','9','5','100','1','5','30','2300','3900','11','6660','1','0','40','2','0','0','21','0','0','0','Bael\'dun Rifleman - Cast Shoot and Set Ranged Weapon Model and Stop Movement(Phase 1)'),
('337703','3377','2','0','100','0','15','0','0','0','23','1','0','0','0','0','0','0','0','0','0','0','Bael\'dun Rifleman - Set Phase 2 at 15% HP'),
('337704','3377','2','3','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Bael\'dun Rifleman - Start Movement and Flee at 15% HP (Phase 2)'),
('337705','3377','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Bael\'dun Rifleman - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('337706','3377','7','0','100','0','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Bael\'dun Rifleman - Set Phase 1 and Set Melee Weapon Model and Start Movement on Evade'),
('337707','3377','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Bael\'dun Rifleman - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('259101','259108');

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('707501','707506');

UPDATE `item_template` SET `SellPrice`='86148' WHERE `entry` IN ('31701');

-- Fiendish Imp 17267
UPDATE `creature_template` SET `minhealth`='4760', `maxhealth`='4901' WHERE `entry`='17267'; -- 4260 4401

-- The Elements 6pcs The Furious Storm
UPDATE `spell_proc_event` SET `SpellFamilyName`='11' WHERE (`entry`='27774'); -- 0

UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('19257');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19257');
INSERT INTO `creature_ai_scripts` VALUES
(1925701,19257,0,0,100,1,8000,12000,11000,22000,11,22273,1,0,0,0,0,0,0,0,0,0,'Arcanist Torseldori - Cast Arcane Missiles'),
(1925702,19257,0,0,100,1,8000,9000,19000,24000,11,33634,1,0,0,0,0,0,0,0,0,0,'Arcanist Torseldori - Cast Blizzard'),
(1925703,19257,9,0,100,1,0,8,13600,14500,11,12674,0,0,0,0,0,0,0,0,0,0,'Arcanist Torseldori - Cast Frost Nova'),
(1925704,19257,9,0,100,1,0,40,3400,4700,11,15530,1,0,0,0,0,0,0,0,0,0,'Arcanist Torseldori - Cast Frostbolt');

UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('19258');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19258');
INSERT INTO `creature_ai_scripts` VALUES
(1925801,19258,0,0,100,1,8000,12000,11000,22000,11,22273,1,0,0,0,0,0,0,0,0,0,'Bloodmage - Cast Arcane Missiles'),
(1925802,19258,0,0,100,1,8000,9000,19000,24000,11,33634,1,0,0,0,0,0,0,0,0,0,'Bloodmage - Cast Blizzard'),
(1925803,19258,9,0,100,1,0,8,13600,14500,11,12674,0,0,0,0,0,0,0,0,0,0,'Bloodmage - Cast Frost Nova'),
(1925804,19258,9,0,100,1,0,40,3400,4700,11,15530,1,0,0,0,0,0,0,0,0,0,'Bloodmage - Cast Frostbolt');


UPDATE `creature` SET `movementtype`='0' WHERE `guid` IN ('90992','90993');
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (90991,90992,90993,91247,91248,91249,90988,90989,90990,90985,90986,90987); -- 90978
DELETE FROM `creature_formations` WHERE `memberguid` IN (90991,90992,90993,91247,91248,91249,90988,90989,90990,90985,90986,90987);
INSERT INTO `creature_formations` VALUES
--
--
(90991,90991,1000,360,1),
(90991,90992,3,1.2,1),
(90991,90993,3,5.2,1),
--
(91247,91247,1000,360,1),
(91247,91248,1000,360,1),
(91247,91249,1000,360,1),
--
(90988,90988,1000,360,1),
(90988,90989,1000,360,1),
(90988,90990,1000,360,1),
--
(90985,90985,1000,360,1),
(90985,90986,1000,360,1),
(90985,90987,1000,360,1);

DELETE FROM `creature` WHERE `guid` IN ('84633');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (84633, 17711, 530, 1, 0, 0, -3563.52, 239.978, 43.9253, 1.55885, 432000, 0, 0, 2276400, 0, 0, 2);
INSERT IGNORE INTO `creature_addon` VALUES (84633,551779,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT IGNORE INTO `pool_template` VALUES (30040,1,'Worldboss Spawn Doomwalker');
DELETE FROM `pool_creature` WHERE `pool_entry`='30040';
INSERT IGNORE INTO `pool_creature` VALUES
(17525,30040,50,'Worldboss Spawn Doomwalker'),
(84633,30040,0,'Worldboss Spawn Doomwalker');

DELETE FROM `creature` WHERE `guid` IN ('96999');
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (96999, 18728, 530, 1, 0, 1268, 943.49, 2269.77, 306.786, 3.28122, 345600, 0, 0, 1300000, 0, 0, 0);
INSERT IGNORE INTO `pool_template` VALUES (30039,1,'Worldboss Spawn Doom Lord Kazzak');
INSERT IGNORE INTO `pool_creature` VALUES
(96999,30039,0,'Worldboss Spawn Doom Lord Kazzak'),
(124776,30039,50,'Worldboss Spawn Doom Lord Kazzak');

-- schrank abuse
UPDATE `creature_model_info` SET `bounding_radius`='2',`combat_reach`='5' WHERE `modelid` = '19097'; -- 2 0
--
-- Windy Cloud
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'256'|'512'|'32768'|'33554432',`MovementType`='1' WHERE `entry` IN ('24222'); -- 32768
--
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES (14124, 3415, 1, 1, 1056, 0, -224.436, -2791.11, 93.3145, 2.8786, 275, 15, 0, 222, 0, 1);
DELETE FROM `creature` WHERE `guid` ='14241';
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14241, 24222, 530, 1, 0, 0, -1761.4620, 7408.4145, 213.8054, 0.5665, 14400, 100, 0, 1, 0, 0, 1); 
--
DELETE FROM `creature` WHERE `guid` IN (7202,13050,14324,14325,14328,14329,14330,14331,14332);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (7202, 24222, 530, 1, 0, 0, -972.757, 7128.15, 38.0172, 3.71719, 14400, 15, 0, 1, 0, 0, 1);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (13050, 24222, 530, 1, 0, 0, -1656.4874, 7832.0927, 165.8362, 5.40165, 14400, 15, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14324, 24222, 530, 1, 530, 0, -1154.5211, 9099.8828, 45.8203, 0.3151, 14400, 50, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14325, 24222, 530, 1, 530, 0, -938.6796, 8430.3417, 36.8891, 5.0903, 14400, 50, 0, 1, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14326, 24222, 530, 1, 530, 0, -2043.8065, 6653.2592, 13.0542, 0.4565, 14400, 50, 0, 1, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14327, 24222, 530, 1, 530, 0, -2395.3466, 7609.8627, -9.0757, 0.9042, 14400, 50, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14328, 24222, 530, 1, 530, 0, -791.5836, 7289.8925, 42.2148, 6, 14400, 50, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14329, 24222, 530, 1, 530, 0, -3320.9396, 6765.3774, 73.3736, 0.7260, 14400, 50, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14330, 24222, 530, 1, 530, 0, -1571.5057, 6438.2226, 30.9567, 5.3952, 14400, 50, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14331, 24222, 530, 1, 530, 0, -2229.7739, 7790.0063, 150.5184, 0.2626, 14400, 50, 0, 1, 0, 0, 1);
INSERT INTO `creature` VALUES (14332, 24222, 530, 1, 530, 0, -1770.4216, 8535.1357, 197.1517, 5.6897, 14400, 50, 0, 1, 0, 0, 1);
--
DELETE FROM `pool_template` WHERE `entry` ='30043';
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(30043,12,'Windy Cloud - Nagrand');
INSERT IGNORE INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES
(7202, 30043, 0, 'Windy Cloud - Nagrand'),
(13050, 30043, 0, 'Windy Cloud - Nagrand'),
(14241, 30043, 0, 'Windy Cloud - Nagrand'),
(14324, 30043, 0, 'Windy Cloud - Nagrand'),
(14325, 30043, 0, 'Windy Cloud - Nagrand'),
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
(99974, 30043, 0, 'Windy Cloud - Nagrand');

--
-- Saboteur's Axe
UPDATE `item_template` SET `SellPrice`='86148' WHERE `entry` IN ('31701');
--
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES (14340, 18688, 530, 1, 0, 0, -2530.94, 8629.31, -25.5884, 5.65003, 300, 50, 0, 6326, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14428, 14718, 1, 1, 11858, 0, 1029.65, -2105.91, 123.07, 2.58302, 275, 0, 0, 870, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14504, 2760, 0, 1, 2172, 0, -848.952, -1789.83, 40.3907, 5.84351, 400, 5, 0, 1604, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14513, 2559, 0, 1, 11316, 0, -1045.42, -3229.63, 42.0618, 4.92089, 400, 10, 0, 1050, 0, 0, 1);
DELETE FROM `creature` WHERE `guid`='183160';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14520, 12920, 0, 1, 12928, 193, -1018.77, -3509.47, 63.0335, 0.855211, 400, 0, 0, 1800, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14535, 2591, 0, 1, 4019, 0, -1645.85, -1919.64, 73.8104, 3.54302, 400, 0, 0, 1067, 2861, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14557, 2590, 0, 1, 4014, 0, -1713.94, -1780.49, 83.4918, 4.97419, 400, 0, 0, 992, 2680, 0, 0);

-- Sunfury Conjurer
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN ('2013901','2013906');
UPDATE `creature_ai_scripts` SET `action1_param3`='0' WHERE `id` IN ('2013909');
UPDATE `creature_ai_scripts` SET `event_param3`='20000',`action1_param3`='32' WHERE `id` IN ('2013910');
UPDATE `creature_ai_scripts` SET `event_param4`='4500' WHERE `id` IN ('2013903');

-- Quest NPCs not stealing Quest Credit 2097152 no good
-- the no quest credit steal flag makes them passiv
UPDATE `creature_template` SET `flags_extra`='0' WHERE `entry` IN ('22103','22473','22448');
UPDATE `creature_template` SET `flags_extra`='2' WHERE `entry` IN ('21984');

INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14623, 2583, 0, 1, 4140, 0, -1545.08, -1744.71, 68.3035, 5.65337, 400, 0, 0, 1600, 1142, 0, 0);
INSERT IGNORE INTO `creature` VALUES (14730, 24222, 530, 1, 530, 0, -2054.8435, 6462.3618, 19.6635, 5.0692, 14400, 50, 0, 1, 0, 0, 1);
INSERT IGNORE INTO `creature` VALUES (14731, 24222, 530, 1, 530, 0, -2224.4902, 6775.2880, -8.7093, 2.0965, 14400, 50, 0, 1, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14735, 2556, 0, 1, 3997, 0, -1852.68, -3024.19, 60.4887, 4.82933, 400, 3, 0, 1279, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14828, 6766, 0, 1, 6573, 0, 121.93, -1524.03, 168.466, 3.39281, 300, 5, 0, 2769, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (14876, 7071, 0, 1, 5816, 0, -1234.14, 512.85, 14.1555, 2.72271, 600, 0, 0, 7100, 4482, 0, 0);
DELETE FROM `creature` WHERE `guid`='113637';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15030, 5768, 1, 1, 4290, 0, -802.192, -2039.24, 96.6199, 1.79769, 275, 0, 0, 1200, 0, 0, 0);
DELETE FROM `creature` WHERE `guid`='158794';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15033, 10378, 1, 1, 9771, 0, -2384.08, -1880.94, 95.9336, 6.05629, 600, 0, 0, 2700, 7071, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15052, 3466, 1, 1, 6086, 0, -2681.04, -2101.74, 95.4878, 1.45928, 275, 20, 0, 494, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15152, 3238, 1, 1, 1539, 0, -3378.75, -1815.86, 91.9675, 4.76259, 275, 5, 0, 573, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15201, 3239, 1, 1, 1538, 0, -2719.43, -2221.44, 91.7917, 4.01877, 275, 20, 0, 494, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15209, 3239, 1, 1, 1538, 0, -2604.74, -2285.65, 92.1247, 2.92123, 275, 20, 0, 494, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES (15214, 3239, 1, 1, 1538, 0, -2702.98, -2055.48, 97.8233, 5.31991, 275, 3, 0, 494, 0, 1);
DELETE FROM `creature` WHERE `guid`='179271';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES (15292, 2393, 0, 1, 3672, 1, -6.24961, -926.643, 57.1723, 3.81366, 300, 0, 0, 1163, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES (15381, 2356, 0, 1, 3201, 0, -807.772, -36.9599, 28.1008, 0.910693, 300, 10, 0, 944, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES (15410, 2349, 0, 1, 6808, 0, -858.729, -88.7984, 24.4019, 1.082, 300, 10, 0, 664, 0, 1);
DELETE FROM `creature` WHERE `guid`='105055'; 
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15525, 2401, 0, 1, 3659, 0, -24.7877, -935.177, 55.3061, 1.67552, 300, 0, 0, 2000, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15631, 2356, 0, 1, 3201, 0, -365.631, -1719.53, 90.7495, 1.79349, 300, 3, 0, 944, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15633, 2442, 0, 1, 1060, 0, -568.322, -113.526, 47.6385, 0.71739, 300, 5, 0, 1500, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15635, 2442, 0, 1, 1060, 0, -338.753, 55.3219, 55.5409, 2.56105, 300, 5, 0, 1500, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15637, 2267, 0, 1, 11035, 0, -459.92, 97.9049, 56.9202, 1.98382, 300, 0, 0, 644, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15672, 2386, 0, 1, 3708, 0, -664.517, -443.824, 31.5638, 0.930741, 300, 5, 0, 3330, 0, 0, 2);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15714, 2368, 0, 1, 4763, 0, -1229.2, -902.415, 1.8385, 1.82206, 300, 10, 0, 896, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15764, 2350, 0, 1, 1989, 0, 172.187, -977.416, 74.1867, 4.95475, 300, 5, 0, 494, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (15859, 2349, 0, 1, 6808, 0, -904.085, -298.646, 51.1379, 0.883556, 300, 5, 0, 664, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`) VALUES (16030, 2244, 0, 1, 3622, 1, -469.19, -1358.91, 52.5659, 2.92968, 300, 5, 0, 441, 1272, 1);

-- no windy clouds yet
UPDATE `creature` SET `spawnmask`='0' WHERE `id` = '24222';

-- Shadow Council Warlock
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('2130214');
INSERT INTO `creature_ai_scripts` VALUES
('2130214','21302','10','0','100','1','1','20','5000','5000','11','38014','0','7','0','0','0','0','0','0','0','0','Shadow Council Warlock - Cast Shadow Council Channel OOC');

-- Legion Fel Cannon
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('21233');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21233');
INSERT INTO `creature_ai_scripts` VALUES
('2123301','21233','4','0','100','1','0','0','0','0','20','0','0','0','0','0','0','0','0','0','0','0','Legion Fel Cannon - OOC - Prevent Melee on Aggro'),
('2123302','21233','9','0','100','1','0','40','4500','5000','11','36242','1','0','0','0','0','0','0','0','0','0','Legion Fel Cannon - Combat - Cast Fel Cannon Blast');
-- trigger dummy 21348
DELETE FROM `spell_script_target` WHERE `entry` = '38014';
INSERT INTO `spell_script_target` VALUES (38014,1,21348);
UPDATE `creature` SET `position_z`='184.0000' WHERE `guid` IN ('74746','74747','74748');

UPDATE `creature` SET `position_x`='558.3591', `position_y`='296.2860', `position_z`='271.6911', `orientation`='0.0527',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('52413');
UPDATE `creature` SET `orientation`='6.2181' WHERE `guid` IN ('16195');


INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16112, 2350, 0, 1, 1989, 0, -551.657, -1186.71, 63.4604, 4.42638, 300, 5, 0, 494, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16183, 2345, 0, 1, 3762, 0, -1183.52, -1215.07, 43.5995, 6.09062, 300, 10, 0, 905, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16193, 23397, 564, 1, 21563, 0, 560.2943, 300.0126, 271.7589, 5.1304, 7200, 0, 0, 236120, 49635, 0, 0); 
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16196, 23397, 564, 1, 21562, 0, 528.667, 271.184, 271.472, 4.7822, 7200, 0, 0, 236120, 49635, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16199, 22885, 564, 1, 21457, 0, 302.268, 986.683, -62.3218, 2.32129, 7200, 0, 0, 104790, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16200, 548, 0, 1, 1079, 0, -9521.19, -2823.86, 79.7058, 2.87958, 300, 0, 0, 350, 390, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16201, 22885, 564, 1, 21457, 0, 301.18, 998.612, -62.4953, 4.15388, 7200, 0, 0, 104790, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16205, 23398, 564, 1, 11686, 0, 486.085, 77.5332, 111.771, 1.98669, 20, 5, 0, 5500, 3155, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16215, 23398, 564, 1, 11686, 0, 504.395, 34.7434, 113.516, 2.81584, 20, 5, 0, 5500, 3155, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16221, 23398, 564, 1, 11686, 0, 595.774, 81.6333, 111.05, 0.851941, 7200, 20, 0, 5500, 3155, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16247, 3863, 33, 1, 2446, 0, -111.421, 2166.52, 101.603, 0.244346, 7200, 3, 0, 1452, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16250, 3863, 33, 1, 2446, 0, -120.756, 2183.02, 113.215, 4.13643, 7200, 2, 0, 1452, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16309, 2384, 0, 1, 1059, 0, -161.23, -692.294, 68.4183, 2.1195, 300, 10, 0, 617, 0, 0, 1);
-- movement 16397 + 14772
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16397, 2714, 0, 1, 4041, 0, -293.374, -744.734, 56.0809, 0.305683, 300, 0, 0, 1342, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16398, 2721, 0, 1, 4038, 0, -295.919, -745.283, 55.9431, 0.268877, 300, 0, 0, 610, 0, 0, 0);
UPDATE `creature` SET `spawndist`='0',`movementtype`='0' WHERE `id` IN ('2721');
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16470, 437, 0, 1, 6037, 0, -8841.39, -2515.96, 133.203, 2.67035, 300, 0, 0, 484, 0, 0, 0);
DELETE FROM `creature` WHERE `guid`='7621544';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16472, 15350, 530, 1, 0, 1284, -1966.88, 5260.62, -38.8442, 4.10239, 120, 0, 0, 10214, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16483, 2266, 0, 1, 3612, 0, -448.324, -97.3454, 54.2978, 2.60165, 300, 5, 0, 620, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16595, 14284, 0, 1, 14326, 0, 25.8477, -285.859, 133.085, 3.97275, 600, 5, 0, 4100, 0, 0, 2);
SET @GUID := '16595';
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(16595,1,21.3069,-285.302,133.005,0,0,0,0,0),
(16595,2,15.2383,-291.875,132.917,0,0,0,0,0),
(16595,3,8.87892,-299.696,132.513,0,0,0,0,0),
(16595,4,2.46847,-307.579,132.73,0,0,0,0,0),
(16595,5,9.57736,-298.906,132.49,0,0,0,0,0),
(16595,6,18.7988,-287.621,133.04,0,0,0,0,0),
(16595,7,27.2774,-277.194,133.623,0,0,0,0,0),
(16595,8,33.2294,-269.059,132.565,0,0,0,0,0),
(16595,9,39.6067,-264.551,131.376,0,0,0,0,0),
(16595,10,32.1712,-269.526,132.752,0,0,0,0,0),
(16595,11,26.3354,-277.742,133.741,0,0,0,0,0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16596, 19907, 0, 1, 19244, 0, 100.831, -182.979, 127.537, 5.16617, 300, 0, 0, 7600, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16599, 19906, 0, 1, 19243, 0, 537.732, -1085.39, 106.422, 3.735, 300, 0, 0, 5900, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16624, 6033, 0, 1, 7449, 0, 715.172, 128.641, 25.5884, 5.61996, 300, 5, 0, 328, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16641, 2408, 0, 1, 1244, 0, 482.332, 487.398, 20.7727, 4.06282, 300, 10, 0, 1050, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16649, 2349, 0, 1, 6808, 0, -213.835, 268.442, 94.5927, 5.29065, 300, 5, 0, 664, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16651, 2408, 0, 1, 1244, 0, 997.782, -150.97, 31.0625, 5.66385, 300, 10, 0, 1050, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16697, 2408, 0, 1, 1244, 0, 419.324, -1464.54, 33.9715, 1.51451, 300, 10, 0, 1050, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16701, 2252, 0, 1, 11567, 0, 951.095, -481.804, 132.545, 1.92995, 300, 5, 0, 1163, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16723, 2408, 0, 1, 1244, 0, 404.519, -1464.41, 34.9943, 0.237156, 300, 10, 0, 1050, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16724, 2349, 0, 1, 6808, 0, -142.33, 107.265, 59.9299, 2.33962, 300, 5, 0, 664, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16725, 2349, 0, 1, 6808, 0, 14.2789, 85.7148, 52.4014, 0.892272, 300, 10, 0, 664, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16728, 2628, 0, 1, 3720, 0, 102.488, 433.153, 43.3068, 5.47747, 300, 5, 0, 1221, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16750, 2408, 0, 1, 1244, 0, 303.062, -1356.19, 35.3282, 0.273935, 300, 10, 0, 1050, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16800, 2252, 0, 1, 11567, 0, 756.075, -514.504, 144.632, 0.414765, 300, 3, 0, 1163, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16805, 2254, 0, 1, 655, 0, 708.648, -339.294, 141.324, 5.28921, 300, 5, 0, 1277, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16960, 2240, 0, 1, 3707, 0, 237.363, -832.673, 146.439, 4.82431, 300, 5, 0, 1163, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (16969, 2240, 0, 1, 3707, 0, 222.754, -859.775, 148.023, 3.25053, 300, 0, 0, 1163, 0, 0, 0);

-- Reupdate:
UPDATE `creature` SET `position_x`='798.7082', `position_y`='1885.4190', `position_z`='151.9342', `orientation`='4.5223' WHERE `guid` IN ('13913368');
--
-- New
-- ===========================
-- Respawn Linking
-- ===========================
--
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (98237,98238,98239,98240,98241,98242,98243,98244,98245,98248,98249,98250,98251,98252,98253,98254,98255,98256,98257,98258,98259,98260,98261,98262,98263,98264,98265,98266,98267,98268,98269,98270,98271,98272,98273,98274,98275,98276,98277,98278,98279,98280,98281,98282,79404,79405,86026,86056,86057,86054,86055,86059,15535334,79979,80004,79941,79464,79401,79403,79410,79413,79402,79579,86064,79462,79658,79536,79459,79484,79688,79694,79395,79399,79400,79392,79393,79396,79397,79395,79399,79400);
INSERT INTO `creature_linked_respawn` VALUES
--
-- corpses
(98282,98282),
(98281,98281),
(98280,98280),
(98279,98279),
(98278,98278),
(98277,98277),
(98276,98276),
(98275,98275),
(98274,98274),
(98273,98273),
(98272,98272),
(98271,98271),
(98270,98270),
(98269,98269),
(98268,98268),
(98267,98267), 
(98266,98266), 
(98265,98265),
(98264,98264), 
(98263,98263), 
(98262,98262),
(98261,98261), 
(98260,98260), 
(98259,98259),  
(98258,98258),
(98257,98257), 
(98256,98256), 
(98255,98255), 
(98254,98254),
(98253,98253), 
(98252,98252), 
(98251,98251), 
(98250,98250),
(98249,98249), 
(98248,98248), 
(98245,98245), 
(98244,98244),
(98243,98243), 
(98242,98242), 
(98241,98241), 
(98240,98240),
(98239,98239), 
(98238,98238), 
(98237,98237), 
--
(79404,79451), 
(79405,79451),
--
(86026,79451),
-- 
(86057,79451),
(86056,79451),
--
(86055,79451),
(86054,79451),
--
-- nh robos 
(86059,79398),
(15535334 ,79398),
-- 
(79979,79391),
(80004,79391),
(79941,79391),
--
(79464,79391),
(79579,79391),
(86064,79391),
(79462,79391),
(79658,79391),
(79536,79391),
--
(79459,79391),
(79484,79391),
(79688,79391),
(79694,79391),
--
-- entrance event 
--
(79395,79452),
(79399,79452),
(79400,79452),
(79392,79452),
(79393,79452),
(79396,79452),
(79397,79452),
--
(79401,79399),
(79403,79399),
(79410,79399),
(79413,79399),
(79402,79399);

INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17008, 2318, 0, 1, 3724, 0, 678.995, -903.938, 157.779, 4.31451, 300, 0, 0, 1010, 2680, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17173, 2614, 530, 1, 0, 0, -4056.28, 2186.21, 169.997, 6.13303, 300, 5, 0, 9250, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17189, 2614, 530, 1, 0, 0, 1049.34, 7365.76, 89.3591, 5.67232, 300, 5, 0, 9250, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17194, 2614, 530, 1, 0, 0, -2909.69, 3905.94, 53.9051, 3.01909, 300, 5, 0, 9250, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17284, 23969, 1, 1, 6377, 0, -2727.09, -4987.36, 129.289, 2.90988, 360, 0, 0, 1, 0, 0, 0);
-- needs movement
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17322, 615, 0, 1, 6040, 0, -8759.72, -2380.98, 156.724, 4.04466, 300, 5, 0, 617, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17326, 435, 0, 1, 6044, 0, -8685.82, -2345.84, 157.181, 2.6529, 300, 0, 0, 664, 0, 0, 0);
-- not spawned atm but maybe missing one
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17336, 22861, 530, 0, 0, 1671, -3533.82, 576.426, 14.8438, 4.64091, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17343, 2349, 0, 1, 6808, 0, -157.096, 341.104, 86.8935, 2.44922, 300, 10, 0, 664, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17361, 2253, 0, 1, 610, 0, 613.289, -657.157, 153.99, 3.86315, 300, 3, 0, 1220, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17373, 2250, 0, 1, 1050, 0, 144.732, -317.714, 150.336, 4.36285, 300, 5, 0, 1163, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17375, 2250, 0, 1, 1050, 0, 225.94, -318.775, 155.309, 4.10759, 300, 10, 0, 1163, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17382, 2241, 0, 1, 3709, 0, -28.5016, -561.634, 151.48, 0.994472, 300, 0, 0, 1200, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17390, 3240, 1, 1, 1537, 0, -2219.75, -2320.75, 92.9836, 1.70815, 275, 20, 0, 417, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17413, 3240, 1, 1, 1537, 0, -2274.03, -1657.43, 91.7112, 5.61586, 275, 20, 0, 417, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17444, 3241, 1, 1, 1977, 0, 546.505, -1877.84, 94.3537, 1.82879, 275, 5, 0, 328, 0, 0, 1);
-- not spawned atm but maybe missing one UPDATE `creature` SET `spawnmask`='1' WHERE `id` IN (22861);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17566, 22861, 530, 0, 0, 1671, -3533.84, 568.843, 14.8219, 4.68412, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17577, 22861, 530, 0, 0, 1671, -3524.23, 578.947, 13.7938, 4.67391, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17579, 22861, 530, 0, 0, 1671, -3551.43, 565.449, 13.6617, 4.83565, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17598, 2250, 0, 1, 1050, 0, 415.83, -81.7302, 156.182, 3.01942, 300, 0, 0, 1163, 0, 0, 0);
DELETE FROM `creature` WHERE `guid`='16800137';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17612, 1937, 0, 1, 1661, 0, 522.449, 1652.3, 125.843, 4.86947, 275, 0, 0, 250, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17651, 6033, 0, 1, 7449, 0, 871.062, 856.756, 13.3644, 0, 275, 0, 0, 328, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17663, 1895, 0, 1, 2535, 0, -324.3194, 1550.3234, 25.2766, 3.1000, 600, 0, 0, 276, 295, 0, 0);
-- Leeni "Smiley" Smalls <Arena Vendor> S3 Vendor Netherstorm
-- INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17676, 24392, 530, 1, 22393, 0, 3070.16, 3635.11, 143.864, 0.750492, 180, 0, 0, 11000, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17681, 1958, 0, 1, 2597, 0, 786.541, 162.371, 32.1485, 0.94883, 275, 10, 0, 350, 390, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17698, 1958, 0, 1, 2597, 0, 848.003, 153.166, 33.7583, 0.334196, 275, 5, 0, 350, 390, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17706, 1909, 0, 1, 757, 0, 1043.61, 486.685, 15.7066, 2.55993, 275, 10, 0, 377, 408, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17898, 1940, 0, 1, 10855, 0, 1018.46, 734.057, 59.4484, 1.20428, 275, 0, 0, 350, 390, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17926, 2053, 0, 1, 3553, 0, -730.886, 1514.58, 14.0312, 3.91594, 275, 10, 0, 410, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17928, 2053, 0, 1, 3553, 0, -742.248, 1533.36, 16.3341, 1.88496, 275, 0, 0, 410, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17930, 2054, 0, 1, 3554, 0, -740.117, 1503.3, 16.1532, 1.15192, 275, 0, 0, 420, 456, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (17932, 1768, 0, 1, 346, 0, 1207.46, 892.76, 32.9063, 0, 275, 0, 0, 253, 264, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18044, 22861, 530, 0, 0, 1671, -3543.01, 566.102, 14.5032, 4.75324, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18051, 22861, 530, 0, 0, 1671, -3552.09, 573.709, 12.6734, 4.68412, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18053, 22861, 530, 0, 0, 1671, -3543.1, 575.442, 13.9088, 4.78115, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18054, 22861, 530, 0, 0, 1671, -3524.77, 571.807, 14.5552, 4.7658, 25, 0, 0, 5673, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18098, 1766, 0, 1, 246, 0, 1413.51, 887.719, 48.642, 5.90226, 275, 10, 0, 222, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18121, 22862, 530, 0, 0, 1378, -3546.75, 586.648, 12.3347, 4.83565, 25, 0, 0, 28120, 3155, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18206, 2173, 0, 1, 245, 0, 744.277, 1911.04, -3.12703, 4.92491, 275, 5, 0, 300, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18212, 1767, 0, 1, 441, 0, 1178.17, 932.995, 33.3193, 2.96104, 275, 0, 0, 247, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18224, 1778, 0, 1, 1006, 0, 1179.34, 1376.32, 34.0849, 0.456231, 275, 10, 0, 266, 0, 0, 1);
DELETE FROM `creature` WHERE `guid`='485993';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18259, 6570, 0, 1, 10834, 0, 716.412, 948.538, 34.7558, 2.04436, 275, 0, 0, 360, 0, 0, 0);
-- not spawned atm but maybe missing one UPDATE `creature` SET `spawnmask`='1' WHERE `id` = (22864);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18278, 22864, 530, 0, 0, 1505, -3576.74, 586.046, 11.5141, 4.73198, 25, 0, 0, 6634, 2991, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18284, 1942, 0, 1, 858, 0, 971.399, 709.432, 85.0009, 1.36876, 275, 0, 0, 417, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18310, 1895, 0, 1, 2535, 0, -414.124, 1581.03, 19.7275, 6.10865, 600, 0, 0, 276, 295, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18321, 3242, 1, 1, 6087, 0, -147.402, -2181.25, 92.044, 2.3341, 275, 5, 0, 273, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18329, 1923, 0, 1, 741, 0, -498.437, 1422.29, 31.5416, 1.5708, 275, 5, 0, 356, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18346, 1797, 0, 1, 820, 0, 1236.9036, 1866.3914, 10.6983, 2.89664, 275, 5, 0, 296, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18368, 1889, 0, 1, 3585, 0, -406.383, 718.241, 103.684, 4.69481, 275, 5, 0, 379, 1118, 0, 1);

INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18411, 1894, 0, 1, 3551, 0, -391.615, 1601.72, 17.1706, 4.86947, 600, 0, 0, 300, 0, 0, 0);
-- not spawned atm but maybe missing one UPDATE `creature` SET `spawnmask`='1' WHERE `id` = (22863);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18490, 22863, 530, 0, 0, 1461, -3583.87, 568.276, 13.4243, 4.83456, 25, 0, 0, 4908, 7196, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18492, 22863, 530, 0, 0, 1461, -3593.88, 572.175, 14.0355, 4.83456, 25, 0, 0, 4908, 7196, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18510, 1914, 0, 1, 3559, 0, -196.633, 941.087, 65.79, 1.6668, 275, 0, 0, 285, 790, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18515, 1780, 0, 1, 827, 0, 1317.13, 1963.29, 15.2581, 4.12758, 275, 3, 0, 247, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18525, 3242, 1, 1, 6087, 0, -973.471, -2323.7, 91.7917, 3.40056, 275, 15, 0, 273, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18550, 3242, 1, 1, 6087, 0, 54.9121, -3645.48, 28.6942, 4.82585, 275, 5, 0, 273, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18581, 3242, 1, 1, 6087, 0, -846.127, -2686.71, 93.1633, 5.08854, 275, 5, 0, 273, 0, 0, 1);
DELETE FROM `creature` WHERE `guid`='13382078';
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18598, 23579, 1, 1, 21967, 0, -4622.45, -3172.48, 34.8962, 6.26573, 360, 0, 0, 1500, 0, 0, 0);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18651, 3242, 1, 1, 6087, 0, -887.157, -2585.03, 92.7916, 3.74725, 275, 5, 0, 273, 0, 0, 1);
INSERT IGNORE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (18666, 3242, 1, 1, 6087, 0, -948.884, -2651.79, 91.9469, 4.6831, 275, 5, 0, 273, 0, 0, 1);

SET @NPC := 82983;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,69,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-0.268618','160.028','-5.5395',0,0,1000,100,0),
(@PATH,2,'-4.24328','161.149','-5.5395',0,0,0,100,0),
(@PATH,3,'-6.01467','167.23','-5.5395','34000',0,1068,100,0),
-- evtl nochn waypoint
(@PATH,4,'-3.54166','160.511','-5.5395',0,0,1000,100,0),
(@PATH,5,'2.36906','161.495','-5.5395',0,0,0,100,0),
(@PATH,6,'2.31835','163.18','-5.54038','16000',0,1068,100,0);

-- formations
DELETE FROM `creature_formations` WHERE `leaderguid` IN (82991,82985,83141,83142,83143,83049,83050,83051,83053,83054,83055,83021,83024,83025,83028,83048,83029,83020,83140,83030,83031,83032,83033,83034,83016,83017,83018,83019,83115,83116,83117,83118,83110,83111,83113,83114,83107,83108,83109,83112,83105,83106,83095,83096,83097,83098,83099,83090,83091,83092,83093,83094,83100,83101,83102,83103,83104,83045,83047,83074,83075,83070,83071,83057,83058,83061,83062,83063,83064,83065,83066,83068,83069,83056,83046,83044,83043,83042,83041,83040,83039,83038,83037,83036,83035,83155,83154,82984,83156,82980,82981,82982,82979,82978,82977,83000,82993,82994,82995,82996,82997,82998,83001,83002,83004,83005,83006,83007,83008,83009,83010,83026,83027,83023,83022,83119,83014,83015,83138,83139,83120,83011,83012,83013,83130,83131,83132,83133,83134,83135,83136,83146,83147,83148,83149,83119,83120,83121,83122,83123,83123,83124,83125,83126,83127,83128,83129,83137,83150,82983,82988,83082,83083,83084,83085,83077,83078,83079,83080,83081,82984,83152,83151);
DELETE FROM `creature_formations` WHERE `memberguid` IN (82991,82985,83141,83142,83143,83049,83050,83051,83053,83054,83055,83021,83024,83025,83028,83048,83029,83020,83140,83030,83031,83032,83033,83034,83016,83017,83018,83019,83115,83116,83117,83118,83110,83111,83113,83114,83107,83108,83109,83112,83105,83106,83095,83096,83097,83098,83099,83090,83091,83092,83093,83094,83100,83101,83102,83103,83104,83045,83047,83074,83075,83070,83071,83057,83058,83061,83062,83063,83064,83065,83066,83068,83069,83056,83046,83044,83043,83042,83041,83040,83039,83038,83037,83036,83035,83155,83154,82984,83156,82980,82981,82982,82979,82978,82977,83000,82993,82994,82995,82996,82997,82998,83001,83002,83004,83005,83006,83007,83008,83009,83010,83026,83027,83023,83022,83119,83014,83015,83138,83139,83120,83011,83012,83013,83130,83131,83132,83133,83134,83135,83136,83146,83147,83148,83149,83119,83120,83121,83122,83123,83123,83124,83125,83126,83127,83128,83129,83137,83150,82983,82988,83082,83083,83084,83085,83077,83078,83079,83080,83081,82984,83152,83151);
INSERT INTO `creature_formations` VALUES
--
--
--
(83141,83141,100,360,2),
(83141,83142,100,360,2),
(83141,83143,100,360,2),
--
(83051,83051,100,360,2),
(83051,83050,100,360,2),
(83051,83049,100,360,2),
--
(83053,83053,100,360,2),
(83053,83054,100,360,2),
(83053,83055,100,360,2),
--
(83021,83021,100,360,2),
(83021,83024,100,360,2),
(83021,83025,100,360,2),
(83021,83028,100,360,2),
(83021,83048,100,360,2),
--
(83029,83029,100,360,2),
(83029,83020,100,360,2),
(83029,83140,100,360,2),
--
(83030,83030,100,360,2),
(83030,83031,100,360,2),
(83030,83032,100,360,2),
(83030,83033,100,360,2),
(83030,83034,100,360,2),  
--
-- 83077 82988
--
(83016,83016,100,360,2),
(83016,83017,100,360,2),
(83016,83018,100,360,2),
(83016,83019,100,360,2),
--
(83115,83115,100,360,2),
(83115,83116,100,360,2),
(83115,83117,100,360,2),
(83115,83118,100,360,2),
--
(83110,83110,100,360,2),
(83110,83111,100,360,2),
(83110,83113,100,360,2),
(83110,83114,100,360,2),

--
(83107,83107,100,360,2),
(83107,83108,100,360,2),
(83107,83109,100,360,2),
(83107,83112,100,360,2),
--
(83105,83105,100,360,2),
(83105,83106,100,360,2),
--
(83095,83095,100,360,2),
(83095,83096,100,360,2),
(83095,83097,100,360,2),
(83095,83098,100,360,2),
(83095,83099,100,360,2),
--
(83090,83090,100,360,2),
(83090,83091,100,360,2),
(83090,83092,100,360,2),
(83090,83093,100,360,2),
(83090,83094,100,360,2),
--
(83100,83100,100,360,2),
(83100,83101,100,360,2),
(83100,83102,100,360,2),
(83100,83103,100,360,2),
(83100,83104,100,360,2),
--
--
--
--
(83045,83045,100,360,2),
(83045,83047,2,2.1,2),
-- 
(83075,83075,0,0,1),
(83075,83074,0,0,1),
--
(83070,83070,0,0,1),
(83070,83071,0,0,1),
--
(83057,83057,100,360,2),
(83057,83058,100,360,2),
(83057,83061,100,360,2),
(83057,83062,100,360,2),
(83057,83063,100,360,2),
(83057,83064,100,360,2),
(83057,83065,100,360,2),
(83057,83066,100,360,2),
(83057,83068,100,360,2),
(83057,83069,100,360,2),
(83057,83056,100,360,2),
--
(83046,83046,100,360,2),
(83046,83044,100,360,2),
(83046,83043,100,360,2),
(83046,83042,100,360,2),
(83046,83041,100,360,2),
(83046,83040,100,360,2),
(83046,83039,100,360,2),
(83046,83038,100,360,2),
(83046,83037,100,360,2),
(83046,83036,100,360,2),
(83046,83035,100,360,2),
--
(83154,83154,100,360,2),
(83154,83155,100,360,2),
--
(82980,82980,100,360,2),
(82980,82981,100,360,2),
(82980,82982,100,360,2),
--
(82979,82979,100,360,2),
(82979,82978,100,360,2),
(82979,82977,100,360,2),
--
(83000,83000,100,360,2),
(83000,82993,100,360,2),
(83000,82994,100,360,2),
-- 
(82995,82995,100,360,2),
(82995,82996,100,360,2),
(82995,82997,100,360,2),
(82995,82998,100,360,2),
--
(83001,83001,100,360,2),
(83001,83002,100,360,2),
--
(83004,83004,100,360,2),
(83004,83005,100,360,2),
(83004,83006,100,360,2),
--
(83007,83007,100,360,2),
(83007,83008,100,360,2),
(83007,83009,100,360,2),
(83007,83010,100,360,2),
--
(83027,83027,100,360,2),
(83027,83026,3,1,2),
--
(83022,83022,100,360,2),
(83022,83023,3,1,2),
--
(83119,83119,100,360,2),
(83119,83014,100,360,2),
(83119,83015,100,360,2),
--
--
(83138,83138,100,360,2),
(83138,83139,100,360,2),
(83138,83120,100,360,2),
--
--
(83011,83011,100,360,2),
(83011,83012,100,360,2),
(83011,83013,100,360,2),
--
(83131,83131,100,360,2),
(83131,83132,100,360,2),
(83131,83133,100,360,2),
(83131,83134,100,360,2),
(83131,83135,100,360,2),
(83131,83136,100,360,2),
(83131,83146,100,360,2),
(83131,83147,100,360,2),
(83131,83148,100,360,2),
(83131,83149,100,360,2),
--
(83121,83121,100,360,2),
(83121,83122,100,360,2),
(83121,83123,100,360,2),
(83121,83124,100,360,2),
(83121,83125,100,360,2),
(83121,83126,100,360,2),
(83121,83127,100,360,2),
(83121,83128,100,360,2),
(83121,83129,100,360,2),
(83121,83130,100,360,2),

--
(83137,83137,100,360,2),
(83137,83150,100,360,2),
(83137,82983,100,360,2),
--
(83082,83082,100,360,2),
(83082,83083,100,360,2),
(83082,83084,100,360,2),
(83082,83085,100,360,2),
--
(83078,83078,100,360,2),
(83078,83079,100,360,2),
(83078,83080,100,360,2),
(83078,83081,100,360,2),
--
(82991,82991,0,0,1),
(82991,82985,0,0,1),
--
(83156,83156,0,0,1),
(83156,82984,0,0,1),
--
(83152,83152,0,0,1),
(83152,83151,0,0,1);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18422');
INSERT INTO `creature_ai_scripts` VALUES
('1842201','18422','16','0','100','7','34350','15','16900','27700','11','34350','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist - Cast Nature\'s Rage on Friendlies on Missing Buff'),
('1842202','18422','0','0','100','3','19300','19300','38600','38600','11','34254','0','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Normal) - Cast Rejuvenate Plant'),
('1842203','18422','0','0','100','5','19300','19300','38600','38600','11','39126','0','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Heroic) - Cast Rejuvenate Plant'),
('1842204','18422','14','0','100','3','4000','15','13300','21000','11','27637','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Normal) - Cast Regrowth on Friendlies'),
('1842205','18422','14','0','100','5','5600','15','13300','21000','11','39125','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Heroic) - Cast Regrowth on Friendlies'),
('1842206','18422','2','0','100','3','75','0','13300','21000','11','27637','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Normal) - Cast Regrowth at 75% HP'),
('1842207','18422','2','0','100','5','75','0','13300','21000','11','39125','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Heroic) - Cast Regrowth at 75% HP');
UPDATE `spell_script_target` SET `targetEntry`='19557' WHERE `entry` ='34254'; -- 19554

DELETE FROM creature_addon WHERE guid IN (83095,83097,83096,83091,83093,83094,83104,83103,83102,83141,83142);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83095','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83097','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83096','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83091','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83093','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83094','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83104','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83103','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83102','0','0','0','0','69','0',NULL);
INSERT INTO `creature_addon` VALUES
(83141,0,0,16908544,0,4097,69,0,''),
(83142,0,0,16908544,0,4097,69,0,'');

UPDATE `creature_loot_template` SET `maxcount`='2' WHERE `entry` IN ('19598','21561') AND `item` IN ('32902','32905');
--
--
SET @NPC := 68924; 
UPDATE `creature` SET `MovementType` = 2 WHERE guid = @NPC;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`bytes0`, `bytes2`,`mount`,`auras`) VALUES (@NPC,@PATH,0, 4097, 0, ''); 
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-1909.3576,5846.2006,129.8383,0,0,0,100,0),
(@PATH,2,-1829.4794,5753.8984,130.5373,0,0,0,100,0),
(@PATH,3,-1857.7979,5762.3403,129.5581,0,0,0,100,0),
(@PATH,4,-1883.7142,5802.0180,130.5973,0,0,0,100,0),
(@PATH,5,-1901.5517,5831.3994,128.3695,0,0,0,100,0),
(@PATH,6,-1911.5161,5850.2978,130.2447,0,0,0,100,0),
(@PATH,7,-1920.7230,5868.8081,133.6996,0,0,0,100,0),
(@PATH,8,-1940.8338,5909.9321,145.8621,0,0,0,100,0),
(@PATH,9,-1959.9373,5956.9394,159.5592,0,0,0,100,0),
(@PATH,10,-1967.5106,5973.1679,157.6849,0,0,0,100,0),
(@PATH,11,-1972.6784,5976.1484,157.3017,0,0,0,100,0),
(@PATH,12,-1989.1994,5966.6025,156.1271,0,0,0,100,0),
(@PATH,13,-2004.0787,5972.5307,151.1060,0,0,0,100,0),
(@PATH,14,-2023.9764,6065.4990,121.1087,0,0,0,100,0),
(@PATH,15,-2035.5645,6083.7011,115.9172,60000,0,0,100,0);

-- ======================================================
-- Non Blizzlike Stuff
-- ======================================================
--
-- Target Dummys 
--
-- target dummy enhancements
UPDATE `creature_template` SET `scale`='2',`minhealth`='99999999',`maxhealth`='99999999',`subname`='6200 Armor',`rank`='3',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`mechanic_immune_mask`='787431423',`flags_extra`='65536' WHERE `entry` IN ('1200062','1200063');
UPDATE `creature_template` SET `scale`='2',`minhealth`='99999999',`maxhealth`='99999999',`subname`='7700 Armor',`rank`='3',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`mechanic_immune_mask`='787431423',`flags_extra`='65536' WHERE `entry` IN ('1200064','1200065');
UPDATE `creature_template` SET `name`='Player Combat Dummy',`maxlevel`='70',`scale`='1',`minhealth`='99999999',`maxhealth`='99999999',`subname`='0 Armor',`armor`='0',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`type`='7',`unit_flags`='393216',`dynamicflags`='8',`flags_extra`='65536' WHERE `entry` IN ('1200058'); 
DELETE FROM `creature_template` WHERE `entry` IN ('1200066');
INSERT INTO `creature_template` VALUES
(1200066,0,NULL,3019,NULL,3019,NULL,'Player Combat Dummy','0 Armor',NULL,70,70,99999999,99999999,0,0,0,1,31,31,0,0.001,1,0,0,0,0,0,2000,0,393216,8,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,'',0,3,0,NULL,NULL,NULL,65536,'npc_theramore_combat_dummy');
--
DELETE FROM `creature` WHERE `guid` IN ('29337','29312','29437','133929','29461','124496','16800641','16800640','271838','328022','16800649','16800655','16800661','16800667','16800673','16800679','16800697','16800698','16800642','16800650','16800656','16800662','16800668','16800674','16800680','16800686','16800692','16800643','16800651','16800657','16800663','16800670','16800675','16800681','16800687','16800693','16800644','16800653','16800658','16800664','16800669','16800676','16800682','16800688','16800694','16800645','16800652','16800660','16800665','16800671','16800677','16800683','16800689','16800695','16800646','16800654','16800659','16800666','16800672','16800678','16800684','16800690','16800696');
DELETE FROM `creature` WHERE `guid` IN (16800036,16800037,16800038,16800039,16800041,16800049,16800050,16800051,16800052,16800053,16800054,16800055,16800057,16800058,16800059,16800060,16800061,16800062,16800063,16800064,16800065,16800066,16800067,16800068,16800069,16800070,16800071,16800072,16800073,16800074,16800075,16800076,16800077,16800078,16800080,16800088,16800089,16800090,16800091,16800092,16800093,16800094,16800095,16800096,16800097,16800098,16800099,16800100,16800101,16800102,16800103,16800104,16800105,16800107,16800109,16800110,16800111,16800112,16800113,16800114);

-- 16800036,16800037,16800038,16800039,16800041,16800049 shattrath
--
INSERT INTO `creature` VALUES
-- 16800050,16800051,16800052,16800053,16800054,16800055 if
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800050,1200062,0,1,0,0,-4927.2524,-1189.4945,501.6523,2.7803,30,0,0,99999999,0,0,0),
(16800051,1200063,0,1,0,0,-4946.9311,-1166.9400,501.7056,5.4820,30,0,0,99999999,0,0,0),
(16800052,1200064,0,1,0,0,-4913.4267,-1155.3994,501.5509,3.0276,30,0,0,99999999,0,0,0),
(16800053,1200065,0,1,0,0,-4912.8999,-1148.2254,501.4670,3.0669,30,0,0,99999999,0,0,0),
(16800054,1200058,0,1,0,0,-4935.5473,-1139.5278,501.4591,6.2203,30,0,0,99999999,0,0,0),
(16800055,1200066,0,1,0,0,-4935.9521,-1149.6748,501.4966,6.2203,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800057,16800058,16800059,16800060,16800061,16800062 sw
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800057,1200062,0,1,0,0,-8789.5615,365.5816,101.0188,5.4043,30,0,0,99999999,0,0,0),
(16800058,1200063,0,1,0,0,-8795.9375,360.2980,101.0188,5.4043,30,0,0,99999999,0,0,0),
(16800059,1200064,0,1,0,0,-8776.0322,353.8493,101.0188,2.2509,30,0,0,99999999,0,0,0),
(16800060,1200065,0,1,0,0,-8785.0000,346.5939,101.0188,2.2509,30,0,0,99999999,0,0,0),
(16800061,1200058,0,1,0,0,-8791.5927,340.0069,101.0188,1.2849,30,0,0,99999999,0,0,0),
(16800062,1200066,0,1,0,0,-8801.1650,353.9028,101.0201,6.1661,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800063,16800064,16800065,16800066,16800067,16800068 dr
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800063,1200062,1,1,0,0,9968.5791,2258.2651,1335.1026,4.4134,30,0,0,99999999,0,0,0),
(16800064,1200063,1,1,0,0,9979.4863,2259.7231,1333.7755,4.4134,30,0,0,99999999,0,0,0),
(16800065,1200064,1,1,0,0,9936.5595,2257.3386,1334.8795,4.9986,30,0,0,99999999,0,0,0),
(16800066,1200065,1,1,0,0,9924.8603,2258.4765,1333.0574,4.9986,30,0,0,99999999,0,0,0),
(16800067,1200058,1,1,0,0,9932.7460,2323.8261,1336.5521,0.0348,30,0,0,99999999,0,0,0),
(16800068,1200066,1,1,0,0,9968.9433,2324.7792,1336.5539,3.1686,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800069,16800070,16800071,16800072,16800073,16800074 ex
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800069,1200062,530,1,0,0,-3850.7719,-11311.0634,-126.6673,4.2455,30,0,0,99999999,0,0,0),
(16800070,1200063,530,1,0,0,-3843.6706,-11314.6455,-126.5968,4.2455,30,0,0,99999999,0,0,0),
(16800071,1200064,530,1,0,0,-3834.9255,-11319.0527,-126.5103,4.2455,30,0,0,99999999,0,0,0),
(16800072,1200065,530,1,0,0,-3828.1403,-11322.4726,-126.4442,4.2455,30,0,0,99999999,0,0,0),
(16800073,1200058,530,1,0,0,-3827.6018,-11308.7294,-126.3871,4.2455,30,0,0,99999999,0,0,0),
(16800074,1200066,530,1,0,0,-3836.4548,-11304.2656,-126.4736,4.2455,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800075,16800076,16800077,16800078,16800080,16800088 og
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800075,1200062,1,1,0,0,2160.0466,-4635.3535,52.3962,3.5421,30,0,0,99999999,0,0,0),
(16800076,1200063,1,1,0,0,2154.5937,-4624.3706,52.4726,3.8837,30,0,0,99999999,0,0,0),
(16800077,1200064,1,1,0,0,2113.2895,-4625.0375,58.6760,2.8902,30,0,0,99999999,0,0,0),
(16800078,1200065,1,1,0,0,2108.8928,-4610.0576,58.7025,4.1704,30,0,0,99999999,0,0,0),
(16800080,1200058,1,1,0,0,2084.9677,-4618.0561,58.6134,6.2517,30,0,0,99999999,0,0,0),
(16800088,1200066,1,1,0,0,2094.0319,-4607.1035,58.6739,4.8812,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800089,16800090,16800091,16800092,16800093,16800094 tb
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800089,1200062,1,1,0,0,-1408.6981,-83.2666,158.9349,0.9691,30,0,0,99999999,0,0,0),
(16800090,1200063,1,1,0,0,-1429.3658,-86.4949,161.1018,0.2268,30,0,0,99999999,0,0,0), 
(16800091,1200064,1,1,0,0,-1416.6850,-77.7832,158.7257,0.9730,30,0,0,99999999,0,0,0),
(16800092,1200065,1,1,0,0,-1423.6745,-73.2963,157.6207,0.9690,30,0,0,99999999,0,0,0),
(16800093,1200058,1,1,0,0,-1437.5043,-61.7228,156.9426,6.1683,30,0,0,99999999,0,0,0),
(16800094,1200066,1,1,0,0,-1431.5075,-68.8002,156.8751,0.8277,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800095,16800096,16800097,16800098,16800099,16800100 uc
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800095,1200062,0,1,0,0,1779.5187,334.6853,-62.2897,2.4343,30,0,0,99999999,0,0,0),
(16800096,1200063,0,1,0,0,1782.1770,343.3691,-62.3427,2.7916,30,0,0,99999999,0,0,0),
(16800097,1200064,0,1,0,0,1770.6206,350.8294,-62.2893,4.4134,30,0,0,99999999,0,0,0),
(16800098,1200065,0,1,0,0,1763.9212,353.2437,-62.2893,4.9867,30,0,0,99999999,0,0,0),
(16800099,1200058,0,1,0,0,1794.6473,367.0260,-60.1590,2.6384,30,0,0,99999999,0,0,0),
(16800100,1200066,0,1,0,0,1794.9749,375.2593,-60.1590,3.7380,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800101,16800102,16800103,16800104,16800105,16800107 sm
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800101,1200062,530,1,0,0,9854.5722,-7391.5908,13.6415,4.7551,30,0,0,99999999,0,0,0),
(16800102,1200063,530,1,0,0,9847.6679,-7392.1210,13.6419,4.7573,30,0,0,99999999,0,0,0),
(16800103,1200064,530,1,0,0,9836.1376,-7388.5585,13.6227,5.2813,30,0,0,99999999,0,0,0),
(16800104,1200065,530,1,0,0,9832.5966,-7394.7568,13.6091,6.0156,30,0,0,99999999,0,0,0),
(16800105,1200058,530,1,0,0,9870.8945,-7391.8666,13.6028,3.9640,30,0,0,99999999,0,0,0),
(16800107,1200066,530,1,0,0,9865.4628,-7389.6757,13.6180,4.7355,30,0,0,99999999,0,0,0);
--
INSERT INTO `creature` VALUES
-- 16800109,16800110,16800111,16800112,16800113,16800114 gm
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,30,0,0,99999999,0,0,0),
(16800109,1200062,1,1,0,0,16260.9003,16247.0332,24.6619,1.9079,30,0,0,99999999,0,0,0),
(16800110,1200063,1,1,0,0,16268.8212,16249.8105,23.6558,1.9079,30,0,0,99999999,0,0,0),
(16800111,1200064,1,1,0,0,16279.8662,16253.6826,23.8619,1.9079,30,0,0,99999999,0,0,0),
(16800112,1200065,1,1,0,0,16289.2402,16256.9687,23.3671,1.9079,30,0,0,99999999,0,0,0),
(16800113,1200058,1,1,0,0,16287.4248,16266.9404,19.9136,3.3216,30,0,0,99999999,0,0,0),
(16800114,1200066,1,1,0,0,16285.3164,16278.5185,17.1308,3.3216,30,0,0,99999999,0,0,0);
--
INSERT IGNORE INTO `creature_addon` VALUES
--
-- Horde Flag Visual Only for Alliance
(16800050,0,0,0,0,0,0,0,'32610 0'),
(16800051,0,0,0,0,0,0,0,'32610 0'),
(16800052,0,0,0,0,0,0,0,'32610 0'),
(16800053,0,0,0,0,0,0,0,'32610 0'),
(16800054,0,0,0,0,0,0,0,'32610 0'),
(16800055,0,0,0,0,0,0,0,'32610 0'),
(16800057,0,0,0,0,0,0,0,'32610 0'),
(16800058,0,0,0,0,0,0,0,'32610 0'),
(16800059,0,0,0,0,0,0,0,'32610 0'),
(16800060,0,0,0,0,0,0,0,'32610 0'),
(16800061,0,0,0,0,0,0,0,'32610 0'),
(16800062,0,0,0,0,0,0,0,'32610 0'),
(16800063,0,0,0,0,0,0,0,'32610 0'),
(16800064,0,0,0,0,0,0,0,'32610 0'),
(16800065,0,0,0,0,0,0,0,'32610 0'),
(16800066,0,0,0,0,0,0,0,'32610 0'),
(16800067,0,0,0,0,0,0,0,'32610 0'),
(16800068,0,0,0,0,0,0,0,'32610 0'),
(16800069,0,0,0,0,0,0,0,'32610 0'),
(16800070,0,0,0,0,0,0,0,'32610 0'),
(16800071,0,0,0,0,0,0,0,'32610 0'),
(16800072,0,0,0,0,0,0,0,'32610 0'),
(16800073,0,0,0,0,0,0,0,'32610 0'),
(16800074,0,0,0,0,0,0,0,'32610 0'),
--
-- Alliance Flag Visual Only for Horde
(16800075,0,0,0,0,0,0,0,'32609 0'),
(16800076,0,0,0,0,0,0,0,'32609 0'),
(16800077,0,0,0,0,0,0,0,'32609 0'),
(16800078,0,0,0,0,0,0,0,'32609 0'),
(16800080,0,0,0,0,0,0,0,'32609 0'),
(16800088,0,0,0,0,0,0,0,'32609 0'),
(16800089,0,0,0,0,0,0,0,'32609 0'),
(16800090,0,0,0,0,0,0,0,'32609 0'),
(16800091,0,0,0,0,0,0,0,'32609 0'),
(16800092,0,0,0,0,0,0,0,'32609 0'),
(16800093,0,0,0,0,0,0,0,'32609 0'),
(16800094,0,0,0,0,0,0,0,'32609 0'),
(16800095,0,0,0,0,0,0,0,'32609 0'),
(16800096,0,0,0,0,0,0,0,'32609 0'),
(16800097,0,0,0,0,0,0,0,'32609 0'),
(16800098,0,0,0,0,0,0,0,'32609 0'),
(16800099,0,0,0,0,0,0,0,'32609 0'),
(16800100,0,0,0,0,0,0,0,'32609 0'),
(16800101,0,0,0,0,0,0,0,'32609 0'),
(16800102,0,0,0,0,0,0,0,'32609 0'),
(16800103,0,0,0,0,0,0,0,'32609 0'),
(16800104,0,0,0,0,0,0,0,'32609 0'),
(16800105,0,0,0,0,0,0,0,'32609 0'),
(16800107,0,0,0,0,0,0,0,'32609 0');

UPDATE `creature` SET `spawndist`='5',`movementtype`='1' WHERE `guid` IN ('66268');

-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/2453/darkmoon-faire-merchants
--
-- Lhara <Darkmoon Faire Exotic Goods>
UPDATE `creature_template` SET `npcflag`='1' WHERE `entry` IN ('14846'); -- 129
-- Professor Thaddeus Paleo <Darkmoon Faire Cards & Exotic Goods>
UPDATE `creature_template` SET `npcflag`='3' WHERE `entry` IN ('14847'); -- 131
