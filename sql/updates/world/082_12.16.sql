-- Steam Surger
UPDATE `creature` SET `MovementType` = 0 WHERE `id` = 21696;

SET @GUID := 12604;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12604, 1, -9583.38, 56.4448, 61.5721, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12604, 2, -9562.35, 72.3336, 59.0201, 5000, 0, 0, 0, 0);

SET @GUID := 12679;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12679, 1, 22.672, -223.202, -22.536, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12679, 2, 39.0578, -210.222, -22.6133, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12679, 3, 22.1297, -224.366, -22.5328, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12679, 4, 8.45932, -247.386, -23.3366, 0, 0, 0, 0, 0);

SET @GUID := 12695;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12695, 1, 27.0136, -145.039, -22.3968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 2, 18.9726, -161.946, -22.438, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12695, 3, 26.7279, -177.709, -22.3997, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 4, 18.9726, -161.946, -22.438, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12695, 5, 30.8925, -138.629, -22.5491, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 6, 57.7822, -114.87, -22.6239, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12695, 7, 38.5541, -130.114, -22.6439, 0, 0, 0, 0, 0);

SET @GUID := 12700;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12700, 1, 13.0123, -180.845, -22.3747, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 2, 17.6451, -189.086, -22.4312, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 3, 29.465, -208.979, -22.5932, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 4, 17.0985, -188.306, -22.4238, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 5, 9.53988, -180.075, -22.4403, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 6, -7.20501, -173.28, -23.2732, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (12700, 7, 2.36385, -176.577, -22.3011, 0, 0, 0, 0, 0);

SET @GUID := 99970;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (99970, 1, -1046.56, 7486.97, 229.16, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99970, 2, -1069.78, 7421.03, 228.622, 3000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99970, 3, -1119.78, 7498.12, 218.884, 3000, 0, 0, 0, 0);

SET @GUID := 12794;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (12794, 11, 675.512, 270.854, 125.131, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 12, 655.124, 294.591, 125.117, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 13, 655.017, 300.198, 125.126, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 14, 658.337, 327.576, 125.159, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 15, 665.057, 333.561, 125.156, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 16, 688.727, 360.796, 125.139, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 17, 692.899, 360.548, 125.139, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 1, 704.168, 360.445, 125.14, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 2, 723.814, 359.922, 125.143, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 3, 725.9, 356.229, 125.149, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 4, 753.716, 322.517, 125.174, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 5, 753.62, 319.39, 125.172, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 6, 750.64, 287.66, 125.142, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 7, 748.388, 284.961, 125.142, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 8, 723.082, 263.289, 125.158, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 9, 719.945, 263.568, 125.177, 700, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (12794, 10, 681.224, 266.071, 125.149, 0, 0, 0, 100, 0);

-- Reinforced Fel Iron Chest 185168,185169
UPDATE `gameobject_template` SET `size` = 1.5 WHERE `entry` IN (185168,185169);

-- Hellfire Ramparts Epic Gems
DELETE FROM `reference_loot_template` WHERE `entry` = 50002 AND `item` = 30592;
INSERT INTO `reference_loot_template` VALUES (50002, 30592, 0, 1, 1, 1, 0, 0, 0);

UPDATE `gameobject_loot_template` SET `ChanceOrQuestChance` = 100 WHERE `entry` = 21764 AND `item` = 12020;
DELETE FROM `gameobject_loot_template` WHERE `entry` = 21764 AND `item` = 50002;
INSERT INTO `gameobject_loot_template` VALUES (21764, 50002, 40, 1, -50002, 1, 0, 0, 0);

DELETE FROM `script_texts` WHERE `entry` = 0;

-- Zelemar the Wrathful 17830
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 17830;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17830;
INSERT INTO `creature_ai_scripts` VALUES
('1783001','17830','4','0','100','2','0','0','0','0','1','-17','0','0','0','0','0','0','0','0','0','0','Zelemar the Wrathful - Yell on Aggro');

-- Overlord Ramtusk 4420
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 4420;
INSERT INTO `creature_ai_scripts` VALUES
('442001','4420','11','0','100','2','0','0','0','0','11','7165','0','1','0','0','0','0','0','0','0','0','Overlord Ramtusk - Cast Battle Stance on Spawn'),
('442002','4420','4','0','100','2','0','0','0','0','1','-18','0','0','39','15','0','0','0','0','0','0','Overlord Ramtusk - Yell and Call For Help on Aggro'),
('442003','4420','0','0','100','3','1000','3000','30000','45000','11','9128','0','0','0','0','0','0','0','0','0','0','Overlord Ramtusk - Cast Battle Shout'),
('442004','4420','9','0','100','3','0','10','8000','14000','11','15548','0','0','0','0','0','0','0','0','0','0','Overlord Ramtusk - Cast Thunderclap');

-- King Gordok 11501
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 11501;
INSERT INTO `creature_ai_scripts` VALUES
('1150101','11501','4','0','100','2','0','0','0','0','1','-29','0','0','22','1','0','0','0','0','0','0','King Gordok - Say and Set Phase 1 on Aggro'),
('1150102','11501','9','5','100','3','0','5','7100','8500','11','15572','1','0','0','0','0','0','0','0','0','0','King Gordok - Cast Sunder Armor (Phase 1)'),
('1150103','11501','24','5','100','3','15572','5','5000','5000','22','2','0','0','0','0','0','0','0','0','0','0','King Gordok - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
('1150104','11501','28','3','100','3','15572','1','5000','5000','22','1','0','0','0','0','0','0','0','0','0','0','King Gordok - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('1150105','11501','0','0','100','2','7200','7200','18200','22800','11','22886','4','1','0','0','0','0','0','0','0','0','King Gordok - Cast Berserker Charge'),
('1150106','11501','0','0','100','3','5000','7000','9000','14000','11','15708','1','0','0','0','0','0','0','0','0','0','King Gordok - Cast Mortal Strike'),
('1150107','11501','0','0','100','3','12000','15000','17000','24000','11','16727','0','0','0','0','0','0','0','0','0','0','King Gordok - Cast War Stomp'),
('1150108','11501','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','King Gordok - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -33 AND -30;
DELETE FROM `creature_ai_texts` WHERE `entry` = -4420;
INSERT INTO `creature_ai_texts` (`entry`, `content_default`, `sound`, `type`, `language`, `emote`, `comment`) VALUES
('-30','%s blood sprays into the air!','0','2','0','Common Gnomeregan Emote','0'),
('-31','%s is splashed by the blood and becomes irradiated!','0','2','0','Common Gnomeregan Emote','0'),
('-32','Electric justice!','5811','1','0','6235','0'),
('-33','Warning! Warning! Intruder alert! Intruder alert!','0','1','0','7849','0');

-- Irradiated Invader 6213
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6213;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6213;
INSERT INTO `creature_ai_scripts` VALUES
('621301','6213','11','0','100','2','0','0','0','0','11','21862','0','1','0','0','0','0','0','0','0','0','Irradiated Invader - Cast Radiation Visual on Spawn'),
('621302','6213','9','0','100','3','0','25','3600','7200','11','9771','1','0','0','0','0','0','0','0','0','0','Irradiated Invader - Cast Radiation Bolt'),
('621303','6213','0','0','100','3','0','0','2400','3900','11','9770','0','0','0','0','0','0','0','0','0','0','Irradiated Invader - Cast Radiation'),
('621304','6213','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Irradiated Invader - Flee at 15% HP (Out of Instance Only)'),
('621305','6213','6','0','100','2','0','0','0','0','1','-30','0','0','11','9798','0','7','0','0','0','0','Irradiated Invader - Emote and Cast Radiation on Death');

-- Irradiated Pillager 6329
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6329;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6329;
INSERT INTO `creature_ai_scripts` VALUES
('632901','6329','11','0','100','2','0','0','0','0','11','21862','0','1','0','0','0','0','0','0','0','0','Irradiated Pillager - Cast Radiation Visual on Spawn'),
('632902','6329','9','0','100','3','0','25','3600','7200','11','9771','1','0','0','0','0','0','0','0','0','0','Irradiated Pillager - Cast Radiation Bolt'),
('632903','6329','0','0','100','3','0','0','2400','3900','11','9770','0','0','0','0','0','0','0','0','0','0','Irradiated Pillager - Cast Radiation'),
('632904','6329','6','0','100','2','0','0','0','0','1','-30','0','0','11','9798','0','7','0','0','0','0','Irradiated Pillager - Emote and Cast Radiation on Death'),
('632905','6329','2','0','100','2','50','0','0','0','11','8269','0','1','1','-106','0','0','0','0','0','0','Irradiated Pillager - Cast Frenzy at 50% HP');

-- Caverndeep Burrower 
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6206;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6206;
INSERT INTO `creature_ai_scripts` VALUES
('620601','6206','4','0','100','2','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase 1 on Aggro'),
('620602','6206','0','0','100','3','1100','4800','182900','184500','11','7164','0','1','0','0','0','0','0','0','0','0','Caverndeep Burrower - Cast Defensive Stance'),
('620603','6206','9','5','100','3','0','5','6100','9700','11','7405','1','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Cast Sunder Armor (Phase 1)'),
('620604','6206','24','5','100','3','7405','5','5000','5000','22','2','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase 2 on Target Max Sunder Armor Aura Stack (Phase 1)'),
('620605','6206','28','3','100','3','7405','1','5000','5000','22','1','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase 1 on Target Missing Sunder Armor Aura Stack (Phase 2)'),
('620606','6206','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Emote on Radiation Spellhit'),
('620607','6206','2','0','100','2','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Caverndeep Burrower - Flee at 15% HP'),
('620608','6206','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Caverndeep Burrower - Set Phase to 0 on Evade');

-- Caverndeep Ambusher 6207
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6207;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6207;
INSERT INTO `creature_ai_scripts` VALUES
('620701','6207','9','0','100','2','0','5','0','0','11','2590','1','0','0','0','0','0','0','0','0','0','Caverndeep Ambusher - Cast Backstab'),
('620702','6207','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Caverndeep Ambusher - Emote on Radiation Spellhit'),
('620703','6207','2','0','100','2','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Caverndeep Ambusher - Flee at 15% HP');

-- Caverndeep Invader 6208
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6208;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6208;
INSERT INTO `creature_ai_scripts` VALUES
('620801','6208','8','0','100','0','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Caverndeep Invader - Emote on Radiation Spellhit'),
('620802','6208','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Caverndeep Invader - Flee at 15% HP');

-- Caverndeep Looter 6209
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6209;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6209;
INSERT INTO `creature_ai_scripts` VALUES
('620901','6209','0','0','100','1','4000','9000','21000','26000','11','10851','1','0','0','0','0','0','0','0','0','0','Caverndeep Looter - Cast Grab Weapon'),
('620902','6209','8','0','100','0','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Caverndeep Looter - Emote on Radiation Spellhit');

-- Caverndeep Pillager  6210
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6210;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6210;
INSERT INTO `creature_ai_scripts` VALUES
('621001','6210','11','0','100','0','0','0','0','0','11','8876','0','1','0','0','0','0','0','0','0','0','Caverndeep Pillager - Cast Thrash on Spawn'),
('621002','6210','9','0','100','1','0','5','24500','24500','11','1777','1','0','0','0','0','0','0','0','0','0','Caverndeep Pillager - Cast Gouge'),
('621003','6210','8','0','100','0','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Caverndeep Pillager - Emote on Radiation Spellhit'),
('621004','6210','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Caverndeep Pillager - Flee at 15% HP');

-- Caverndeep Reaver 6211
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6211;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6211;
INSERT INTO `creature_ai_scripts` VALUES
('621101','6211','0','0','100','3','1000','3600','240300','241100','11','7366','0','1','0','0','0','0','0','0','0','0','Caverndeep Reaver - Cast Berserker Stance'),
('621102','6211','9','0','100','3','0','5','1900','12100','11','8374','1','0','0','0','0','0','0','0','0','0','Caverndeep Reaver - Cast Arcing Smash'),
('621103','6211','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Caverndeep Reaver - Emote on Radiation Spellhit'),
('621104','6211','2','0','100','2','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Caverndeep Reaver - Flee at 15% HP');

-- Dark Iron Agent 6212
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6212;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6212;
INSERT INTO `creature_ai_scripts` VALUES
('621201','6212','0','0','100','3','15700','24400','21300','34900','11','11802','1','0','0','0','0','0','0','0','0','0','Dark Iron Agent - Cast Dark Iron Land Mine'),
('621202','6212','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Dark Iron Agent - Emote on Radiation Spellhit');

-- Leprous Technician 6222
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6222;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6222;
INSERT INTO `creature_ai_scripts` VALUES
('622201','6222','1','0','100','3','10000','45000','30000','70000','11','10348','0','1','0','0','0','0','0','0','0','0','Leprous Technician - Cast Tune Up OOC'),
('622202','6222','1','0','100','2','0','0','0','0','20','0','0','0','22','1','0','0','0','0','0','0','Leprous Technician - Prevent Melee and Set Phase 1 on Spawn'),
('622204','6222','4','0','100','2','0','0','0','0','39','10','0','0','0','0','0','0','0','0','0','0','Leprous Technician - Call For Help on Aggro'),
('622205','6222','9','5','100','3','8','30','1200','2500','11','13398','1','0','40','2','0','0','0','0','0','0','Leprous Technician - Cast Throw Wrench and Set Ranged Weapon Model (Phase 1)'),
('622206','6222','9','5','100','3','9','80','1000','1000','49','1','0','0','0','0','0','0','0','0','0','0','Leprous Technician - Enable Dynamic Movement at 9-80 Yards (Phase 1)'),
('622207','6222','9','0','100','3','0','8','1000','1000','49','0','0','0','20','1','0','0','40','1','0','0','Leprous Technician - Disable Dynamic Movement and Enable Melee and Set Melee Weapon Model at 0-8 Yards'),
('622208','6222','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Leprous Technician - Emote on Radiation Spellhit'),
('622209','6222','14','0','100','3','2000','15','28900','28900','11','10732','6','1','0','0','0','0','0','0','0','0','Leprous Technician - Cast Supercharge on Mechanical Friendlies'),
('622210','6222','7','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Leprous Technician - Set Phase 1 and Set Melee Weapon Model on Evade');

-- Leprous Defender 6223
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6223;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6223;
INSERT INTO `creature_ai_scripts` VALUES
('622301','6223','9','0','100','3','5','30','2000','2700','11','6660','1','0','40','2','0','0','0','0','0','0','Leprous Defender - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('622302','6223','9','0','100','3','5','30','30000','45000','11','14443','4','0','40','2','0','0','0','0','0','0','Leprous Defender - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
('622303','6223','9','0','100','3','0','5','0','0','40','1','0','0','20','1','0','0','0','0','0','0','Leprous Defender - Set Melee Weapon Model and Start Melee Below 5 Yards (Phase 1)'),
('622304','6223','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Leprous Defender - Emote on Radiation Spellhit'),
('622305','6223','7','0','100','2','0','0','0','0','22','0','0','0','40','1','0','0','0','0','0','0','Leprous Defender - Set Phase 0 and Set Melee Weapon Model on Evade');

-- Leprous Machinesmith 6224
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6224;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6224;
INSERT INTO `creature_ai_scripts` VALUES
('622401','6224','1','0','100','3','10000','45000','30000','70000','11','10348','0','1','0','0','0','0','0','0','0','0','Leprous Machinesmith - Cast Tune Up OOC'),
('622402','6224','1','0','100','2','0','0','0','0','20','0','0','0','22','1','0','0','0','0','0','0','Leprous Machinesmith - Prevent Melee and Set Phase 1 on Spawn'),
('622404','6224','4','0','100','2','0','0','0','0','39','10','0','0','0','0','0','0','0','0','0','0','Leprous Machinesmith - Call for Help on Aggro'),
('622405','6224','9','5','100','3','8','30','1200','2500','11','13398','1','0','40','2','0','0','0','0','0','0','Leprous Machinesmith - Cast Throw Wrench and Set Ranged Weapon Model (Phase 1)'),
('622406','6224','9','5','100','3','9','80','1000','1000','49','1','0','0','0','0','0','0','0','0','0','0','Leprous Machinesmith - Enable Dynamic Movement at 9-80 Yards (Phase 1)'),
('622407','6224','9','0','100','3','0','8','1000','1000','49','0','0','0','20','1','0','0','40','1','0','0','Leprous Machinesmith - Disable Dynamic Movement and Enable Melee and Set Melee Weapon Model at 0-8 Yards'),
('622408','6224','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Leprous Machinesmith - Emote on Radiation Spellhit'),
('622409','6224','14','0','100','3','2000','15','28900','28900','11','10732','6','1','0','0','0','0','0','0','0','0','Leprous Machinesmith - Cast Supercharge on Mechanical Friendlies'),
('622410','6224','7','0','100','2','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Leprous Machinesmith - Set Phase 1 and Set Melee Weapon Model on Evade');

-- Dark Iron Ambassador 6228
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6228;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6228;
INSERT INTO `creature_ai_scripts` VALUES
('622801','6228','1','0','100','3','1000','1000','1800000','1800000','11','12544','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Cast Frost Armor on Spawn'),
('622802','6228','4','0','100','2','0','0','0','0','49','1','0','0','22','1','0','0','0','0','0','0','Dark Iron Ambassador - Enable Dynamic Movement and Set Phase 1 on Aggro'),
('622803','6228','9','5','100','3','0','40','2400','3800','11','9053','1','0','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Cast Fireball (Phase 1)'),
('622804','6228','9','5','100','3','9','80','1000','1000','49','1','0','0','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Enable Dynamic Movement at 9-80 Yards (Phase 1)'),
('622805','6228','9','0','100','3','0','8','1000','1000','49','0','0','0','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Disable Dynamic Movement at 0-8 Yards'),
('622806','6228','3','5','100','2','7','0','0','0','49','0','0','0','22','2','0','0','0','0','0','0','Dark Iron Ambassador - Disable Dynamic Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('622807','6228','3','3','100','3','100','15','1000','1000','22','1','0','0','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Set Phase 1 when Mana is above 15% (Phase 2)'),
('622808','6228','0','0','100','3','6000','11000','60000','65000','11','184','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambasadror - Cast Fire Shield II'),
('622809','6228','0','0','100','2','2000','2000','0','0','11','10870','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Summon Burning Servant'),
('622810','6228','0','0','100','2','3000','3000','0','0','11','10870','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Summon Burning Servant'),
('622811','6228','27','0','100','3','12544','1','15000','30000','11','12544','0','1','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Cast Frost Armor on Missing Buff'),
('622812','6228','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Dark Iron Ambassador - Emote on Radiation Spellhit');

-- Holdout Warrior
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6391;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6391;
INSERT INTO `creature_ai_scripts` VALUES
('639101','6391','9','0','100','3','0','5','7000','10000','11','11976','1','0','0','0','0','0','0','0','0','0','Holdout Warrior - Cast Strike'),
('639102','6391','13','0','100','3','11000','15000','0','0','11','12555','1','1','0','0','0','0','0','0','0','0','Holdout Warrior - Cast Pummel on Target Spell Casting'),
('639103','6391','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Holdout Warrior - Emote on Radiation Spellhit'),
('639104','6391','2','0','100','2','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Holdout Warrior - Flee at 15% HP');

-- Leprous Assistant 
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 7603;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 7603;
INSERT INTO `creature_ai_scripts` VALUES
('760301','7603','4','0','100','2','0','0','0','0','39','10','0','0','0','0','0','0','0','0','0','0','Leprous Assistant - Call for Help on Aggro'),
('760303','7603','8','0','100','2','9798','-1','0','0','1','-31','0','0','0','0','0','0','0','0','0','0','Leprous Assistant - Emote on Radiation Spellhit');

-- Electrocutioner 6000 6235
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 6235;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 6235;
INSERT INTO `creature_ai_scripts` VALUES
('623501','6235','4','0','100','2','0','0','0','0','1','-32','0','0','0','0','0','0','0','0','0','0','Electrocutioner 6000 - Yell on Aggro'),
('623502','6235','9','0','100','3','0','30','14500','27400','11','11082','1','0','0','0','0','0','0','0','0','0','Electrocutioner 6000 - Cast Megavolt'),
('623503','6235','0','0','100','3','15700','26500','8000','10900','11','15605','4','0','0','0','0','0','0','0','0','0','Electrocutioner 6000 - Cast Shock'),
('623504','6235','0','0','100','3','17200','33700','11000','17800','11','11085','4','0','0','0','0','0','0','0','0','0','Electrocutioner 6000 - Cast Chain Bolt');

-- Mobile Alert System 
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 7849;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 7849;
INSERT INTO `creature_ai_scripts` VALUES
('784901','7849','11','0','100','2','0','0','0','0','20','0','0','0','0','0','0','0','0','0','0','0','Mobile Alert System - Prevent Melee on Spawn'),
('784902','7849','0','0','100','2','0','0','0','0','1','-33','0','0','4','5805','0','0','0','0','0','0','Mobile Alert System - Yell Alert and Sound'),
('784903','7849','0','0','100','2','2400','2400','0','0','1','-33','0','0','0','0','0','0','0','0','0','0','Mobile Alert System - Yell Alert'),
('784904','7849','0','0','100','2','4800','4800','0','0','1','-33','0','0','11','1543','0','1','0','0','0','0','Mobile Alert System - Yell Alert and Cast Flare'),
('784905','7849','0','0','100','2','6800','6800','0','0','4','5806','0','0','12','6233','1','600000','12','6233','1','600000','Mobile Alert System - Sound and Summon 2 Mechanized Sentry'),
('784906','7849','0','0','100','2','7000','7000','0','0','20','1','0','0','21','1','0','0','25','0','0','0','Mobile Alert System - Enable Melee and Combat Movement and Flee');
