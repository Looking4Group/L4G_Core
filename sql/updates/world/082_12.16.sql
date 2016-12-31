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

-- Instanced Gameobjects
UPDATE `gameobject` SET `spawnmask` = 3 WHERE `guid` IN (25832,32632,25830,25831,32635,32710,3486608,3496965,3496966,3496967,3496968,3496969,3496970,3497062,3497061,3489287,3497059,3497060,3497063,3497065,3497064,3489213,3486610,3497128,3497127,3496020,3496019,3497217,3497218,3497219,3493144,3497215,3497214,3497213,3497212,3497211,3497210,3497209,3497208,3497216,3497207,3497206,3494261,3486611,3489285,3493145,3497242,3497243,3497330,3497333,3497334,3497332,3497331,3497966);

DELETE FROM `creature` WHERE `guid` IN (48597,48562,45599,43099,43098,42978,42967,42893,42739,42727,42551,42535,42509,52659,85640,85644,85645,85651,15900796);
INSERT INTO `creature` VALUES (48597, 1834, 0, 1, 10325, 0, 2860.65, -1415.43, 146.333, 3.75648, 315, 5, 0, 2614, 2117, 0, 1);
INSERT INTO `creature` VALUES (48562, 2011, 1, 1, 3024, 0, 9265.23, 941.436, 1312, 6.05629, 300, 0, 0, 148, 165, 0, 0);
INSERT INTO `creature` VALUES (45599, 11738, 1, 1, 8014, 0, -6599.05, 561.707, 0.111476, 0.581763, 300, 25, 0, 3529, 0, 0, 1);
INSERT INTO `creature` VALUES (43099, 15222, 1, 1, 13069, 0, -8021.58, 1099.49, 4.82093, 2.77507, 300, 0, 0, 64, 0, 0, 0);
INSERT INTO `creature` VALUES (43098, 15221, 1, 1, 13069, 0, -8029.8, 1122.73, 3.31102, 1.43117, 300, 0, 0, 64, 0, 0, 0);
INSERT INTO `creature` VALUES (42978, 11880, 1, 1, 11812, 0, -6810.46, 1652.77, 6.36939, 2.67436, 300, 0, 0, 3876, 0, 0, 0);
INSERT INTO `creature` VALUES (42967, 11880, 1, 1, 11813, 0, -8019.18, 1853.87, 4.97852, 4.97957, 300, 25, 0, 3876, 0, 0, 1);
INSERT INTO `creature` VALUES (42893, 7410, 0, 1, 0, 0, -8387.889648, 287.373993, 120.886002, 3.821710, 300, 0, 0, 7600, 0, 0, 0); 
INSERT INTO `creature` VALUES (42739, 15617, 1, 1, 15579, 0, -7551.56, 744.482, -17.8704, 3.66519, 600, 0, 0, 24000, 0, 0, 0);
INSERT INTO `creature` VALUES (42727, 22902, 1, 1, 19034, 0, 7536.1, -3048.86, 463.34, 0.210379, 10, 5, 0, 4100, 0, 0, 1);
INSERT INTO `creature` VALUES (42551, 883, 1, 1, 347, 0, 7643.33, -2319.48, 458.534, 3.65773, 300, 5, 0, 64, 0, 0, 1);
INSERT INTO `creature` VALUES (42535, 883, 1, 1, 347, 0, 7871.1, -2173.72, 478.932, 0.860792, 300, 5, 0, 64, 0, 0, 1);
INSERT INTO `creature` VALUES (42509, 883, 1, 1, 347, 0, 8075.92, -2237.89, 515.601, 4.17448, 300, 5, 0, 64, 0, 0, 1);
INSERT INTO `creature` VALUES (52659, 1783, 0, 1, 0, 0, 1732.31, -1115.52, 62.718, 0, 315, 10, 0, 2880, 0, 0, 1);
INSERT INTO `creature` VALUES (85640, 21736, 530, 1, 0, 0, -3882.44, 1951.4, 98.6319, 4.47484, 300, 1, 0, 8700, 0, 0, 1);
INSERT INTO `creature` VALUES (85644, 21736, 530, 1, 0, 0, -3922.99, 1949.45, 93.1716, 0.0019, 300, 1, 0, 8700, 0, 0, 1);
INSERT INTO `creature` VALUES (85645, 21736, 530, 1, 0, 0, -3919.64, 1943.73, 93.0026, 0.885561, 300, 1, 0, 8700, 0, 0, 1);
INSERT INTO `creature` VALUES (85651, 21736, 530, 1, 0, 0, -3917.5, 1910.61, 91.6558, 1.36073, 300, 1, 0, 8700, 0, 0, 1);

-- BT Pre
DELETE FROM `creature_questrelation` WHERE `quest` IN (10568,10683);
INSERT INTO `creature_questrelation` VALUES (21402, 10568);
INSERT INTO `creature_questrelation` VALUES (21955, 10683);

SET @GUID := 75801;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75801, 21720, 530, 1, 0, 0, -4263.52, 408.381, 79.6707, 1.07947, 300, 0, 0, 5409, 3080, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75801, 1, -4263.52, 408.381, 79.6707, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 2, -4275.6, 391.144, 81.4561, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 3, -4276.92, 384.266, 79.9921, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 4, -4272.85, 367.338, 83.4083, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 5, -4299.14, 333.17, 109.859, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 6, -4291.64, 298.577, 121.624, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 7, -4284.62, 294.588, 122.376, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 8, -4265.87, 286.049, 122.693, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 9, -4231.65, 272.029, 122.616, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 10, -4221.66, 271.404, 122.595, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 11, -4221.83, 271.217, 122.331, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 12, -4241.43, 272.784, 122.93, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 13, -4243.72, 273.089, 123.174, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 14, -4287.71, 296.086, 122.087, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 15, -4299.36, 330.603, 110.983, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 16, -4274.68, 364.696, 85.3268, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 17, -4269.53, 373.963, 80.2689, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75801, 18, -4276.89, 385.2, 79.9844, 0, 0, 0, 100, 0);

SET @GUID := 75798;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75798, 21720, 530, 1, 0, 0, -4244.08, 315.988, 134.664, 3.54201, 300, 0, 0, 5409, 3080, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75798, 1, -4244.08, 315.988, 134.664, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 2, -4235.73, 319.797, 134.671, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 3, -4229.5, 315.743, 134.689, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 4, -4194.72, 303.959, 136.771, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 5, -4190.97, 294.081, 135.759, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 6, -4183.76, 287.077, 135.655, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 7, -4191.17, 297.893, 136.033, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 8, -4220.7, 310.053, 134.98, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 9, -4229.36, 315.7, 134.696, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 10, -4230.43, 317.367, 134.676, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 11, -4235.94, 319.629, 134.67, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 12, -4255.56, 318.702, 134.611, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 13, -4249.84, 317.125, 134.681, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 14, -4243.67, 313.41, 134.663, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 15, -4235.89, 308.923, 134.668, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 16, -4230.52, 310.42, 134.687, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 17, -4194.89, 303.799, 136.77, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 18, -4188.84, 309.639, 135.933, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 19, -4175.21, 316.237, 135.709, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 20, -4161.51, 360.043, 141.908, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 21, -4171.74, 320.056, 135.907, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 22, -4185.64, 313.67, 135.349, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 23, -4191.21, 305.068, 136.402, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 24, -4220.62, 309.99, 134.808, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 25, -4229.75, 310.823, 134.69, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 26, -4235.21, 308.577, 134.681, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 27, -4243.49, 313.385, 134.667, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 28, -4255.52, 318.563, 134.61, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75798, 29, -4249.62, 317.301, 134.652, 0, 0, 0, 100, 0);

UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN (2171801,2171806);

SET @GUID := 75780;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75780, 21718, 530, 1, 0, 0, -4192.55, 463.315, 30.7665, 3.9185, 300, 0, 0, 5409, 3080, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75780, 1, -4192.55, 463.315, 30.7665, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75780, 2, -4188.43, 467.363, 30.5879, 0, 0, 0, 100, 0);

SET @GUID := 75774;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (75774, 21718, 530, 1, 0, 0, -4102.02, 377.261, 30.8946, 4.76033, 300, 0, 0, 5409, 3080, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (75774, 1, -4102.02, 377.261, 30.8946, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 2, -4108.74, 382.336, 30.5896, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 3, -4115.18, 384.736, 30.834, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 4, -4115.94, 392.739, 30.798, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 5, -4111.74, 392.884, 30.534, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 6, -4106.75, 389.336, 30.5421, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 7, -4103.54, 395.704, 30.6771, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 8, -4103.44, 396.104, 30.6216, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 9, -4099.81, 402.001, 30.7906, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 10, -4099.44, 401.964, 30.8793, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 11, -4086.57, 405.262, 30.8269, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 12, -4089.5, 392.905, 30.7651, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 13, -4089.03, 381.237, 31.1647, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (75774, 14, -4091.61, 379.738, 30.9751, 0, 0, 0, 100, 0);

UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 21403;

SET @GUID := 72418;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (72418, 20443, 530, 1, 0, 0, 1050.08, 8471.22, 55.7985, 5.97714, 300, 0, 0, 5341, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (72418, 1, 1050.08, 8471.22, 55.7985, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 2, 1045.57, 8467.72, 53.3624, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 3, 1039.81, 8464.55, 50.4806, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 4, 1034.04, 8462.96, 47.468, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 5, 1023.59, 8466.26, 41.9371, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 6, 1015.49, 8469.26, 37.7553, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 7, 1010.96, 8473.25, 35.4999, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 8, 1018.68, 8483.05, 29.7402, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 9, 1027.36, 8493.99, 23.2531, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 10, 1018.68, 8483.05, 29.7402, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 11, 1010.96, 8473.25, 35.4999, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 12, 1015.49, 8469.26, 37.7553, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 13, 1023.4, 8466.33, 41.8435, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 14, 1034.04, 8462.96, 47.468, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 15, 1039.81, 8464.55, 50.4806, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 16, 1045.57, 8467.72, 53.3624, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 17, 1050.08, 8471.22, 55.7985, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 18, 1049.31, 8476.16, 57.0994, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 19, 1044.82, 8485.45, 58.183, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (72418, 20, 1049.31, 8476.16, 57.0994, 0, 0, 0, 100, 0);

SET @GUID := 71806;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (71806, 20202, 530, 1, 0, 0, 4672.65, 2833.64, 119.721, 2.08893, 300, 0, 0, 27044, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (71806, 1, 4691.32, 2831.76, 115.228, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 2, 4711.75, 2826.13, 110.992, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 3, 4722.81, 2820.74, 108.242, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 4, 4730.56, 2807.48, 104.117, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 5, 4735.9, 2790.55, 97.9759, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 6, 4735.55, 2772.66, 94.9759, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 7, 4746.17, 2759.38, 88.9043, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 8, 4758.18, 2753.98, 84.2793, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 9, 4775.82, 2729.57, 81.3475, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 10, 4797.15, 2714.69, 83.2225, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 11, 4816.37, 2706.6, 87.9414, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 12, 4797.17, 2714.67, 83.2225, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 13, 4775.84, 2729.55, 81.3475, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 14, 4758.18, 2753.98, 84.2793, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 15, 4746.27, 2759.26, 88.9043, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 16, 4735.64, 2772.54, 94.9759, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 17, 4735.9, 2790.55, 97.9759, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 18, 4730.56, 2807.48, 104.117, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 19, 4722.81, 2820.74, 108.242, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 20, 4712.02, 2825.99, 110.992, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 21, 4691.32, 2831.76, 115.228, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (71806, 22, 4672.65, 2833.64, 119.721, 1000, 0, 0, 100, 0);

SET @GUID := 70924;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (70924, 19806, 530, 1, 0, 0, -4360.78, 1629.07, 155.238, 2.2141, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70924, 1, -4360.78, 1629.07, 155.238, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 2, -4353.15, 1625.6, 154.083, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 3, -4340.48, 1615.39, 150.836, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 4, -4325.92, 1602.08, 146.811, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 5, -4320, 1595.51, 145.277, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 6, -4294.65, 1561.69, 139.012, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 7, -4284.04, 1547.91, 136.925, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 8, -4279.68, 1538.48, 135.895, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 9, -4270.08, 1526.79, 133.691, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 10, -4279.68, 1538.48, 135.895, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 11, -4284.04, 1547.91, 136.925, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 12, -4294.65, 1561.69, 139.012, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 13, -4320, 1595.51, 145.277, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 14, -4325.92, 1602.08, 146.811, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 15, -4340.48, 1615.39, 150.836, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70924, 16, -4353.15, 1625.6, 154.083, 0, 0, 0, 100, 0);

SET @GUID := 70923;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (70923, 19806, 530, 1, 0, 0, -4217.18, 1521.9, 121.213, 2.19925, 300, 0, 0, 6986, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,20937,16777472,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (70923, 1, -4217.18, 1521.9, 121.213, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 2, -4229.04, 1525.22, 124.084, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 3, -4240.37, 1525.12, 126.964, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 4, -4251.38, 1522.14, 129.302, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 5, -4259.18, 1521.7, 131.07, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 6, -4265.09, 1523.24, 132.447, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 7, -4259.29, 1521.73, 130.949, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 8, -4251.38, 1522.14, 129.302, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 9, -4240.37, 1525.12, 126.964, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 10, -4229.37, 1525.22, 124.15, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 11, -4217.18, 1521.9, 121.213, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 12, -4208.12, 1518.04, 119.038, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 13, -4186.46, 1515.45, 114.312, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 14, -4179.2, 1518.33, 112.695, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 15, -4173.1, 1522.57, 111.377, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 16, -4163.67, 1521.31, 109.029, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 17, -4145.62, 1515.82, 104.826, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 18, -4133.98, 1513.43, 101.786, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 19, -4121.42, 1515.42, 99.4495, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 20, -4113.42, 1518.04, 98.239, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 21, -4121.42, 1515.42, 99.4495, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 22, -4133.98, 1513.43, 101.786, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 23, -4145.62, 1515.82, 104.826, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 24, -4163.67, 1521.31, 109.029, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 25, -4173.1, 1522.57, 111.377, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 26, -4179.2, 1518.33, 112.695, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 27, -4186.46, 1515.45, 114.312, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (70923, 28, -4208.12, 1518.04, 119.038, 0, 0, 0, 100, 0);

UPDATE `creature_template` SET `faction_A` = 35, `faction_H` = 35 WHERE `entry` = 22860;

-- Remove waypoints spawned with the old system
DELETE FROM `creature` WHERE `id` = 1;

-- BT Pre Cont.
DELETE FROM `creature_questrelation` WHERE `quest` = 10944;
INSERT INTO `creature_questrelation` (`id`,`quest`) VALUES ('22820','10944');

-- Fixed return lines for GO 21004 (Monument to Grom Hellscream) in Ashenvale
-- Thanks @Phatcat for reporting
UPDATE `page_text` SET `text` = 'Here lies Grommash Hellscream, Chieftain of the Warsong Clan$B$BIn many ways, the curse of our people began and ended with Grom.$BHis name meant \'giants heart\' in our ancient tongue. He earned that \nname a hundred-fold as he stood alone before the demon Mannoroth$B- and won our freedom with his blood.$B$BLok\'Tar ogar, big brother. May the Warsong never fade.$B$B-Thrall, Warchief of the Horde' WHERE `entry` = 2211;

SET @CGUID := 150195;
DELETE FROM `creature` WHERE `guid` BETWEEN @CGUID AND @CGUID+3;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES 
(@CGUID+0, 17059, 530, 1, 0, 0, -1309.493, 2774.156, -26.95394, 4.363323, 300, 0, 0, 2200, 0, 0, 0), -- 17059 (Area: 3546)
(@CGUID+1, 17059, 530, 1, 0, 0, -1304.588, 2771.275, -27.02782, 3.996804, 300, 0, 0, 2200, 0, 0, 0), -- 17059 (Area: 3546)
(@CGUID+2, 17059, 530, 1, 0, 0, -1321.134, 2771.165, -26.57714, 5.654867, 300, 0, 0, 2200, 0, 0, 0), -- 17059 (Area: 3546)
(@CGUID+3, 17059, 530, 1, 0, 0, -1315.754, 2774.218, -26.85213, 5.009095, 300, 0, 0, 2200, 0, 0, 0); -- 17059 (Area: 3546)?

-- Makes small combat dummies not targetable.

UPDATE `creature_template` SET `unit_flags`=33554688 WHERE `entry` = 17060;

-- https://github.com/cmangos/tbc-db/issues/6
-- Add stealth detection to Phantom Valets (Karazhan)
DELETE FROM `creature_template_addon` WHERE `entry` = 16408;
INSERT INTO `creature_template_addon` VALUES (16408, 0, 0, 0, 0, 0, 0, 0, '18950 0 18950 1');

-- Stones of Binding: aligned spawntime with Servants and set default flags to 4 to make it usable by players
UPDATE gameobject SET spawntimesecs = 450 WHERE id IN (141812,141857,141858,141859);
UPDATE gameobject_template SET flags = 4 WHERE entry IN (141812,141857,141858,141859);
UPDATE `creature` SET `spawntimesecs` = 450 WHERE `id`  IN (7668,7669,7670,7671);

-- https://github.com/Looking4Group/L4G_Core/issues/2064
-- temporary remove pooling of heavily farmed npcs due to core issue
DELETE FROM `pool_creature` WHERE `pool_entry` = 30047;
UPDATE `creature` SET `spawntimesecs`= 3600 WHERE `id` = 23029;
-- https://github.com/Looking4Group/L4G_Core/issues/2717
-- should not even be ingame on current patch
DELETE FROM `pool_creature` WHERE `pool_entry` = 30041;
UPDATE `creature` SET `spawntimesecs`= 43200 WHERE `id` = 23008;

-- Remove Seasonal Winter Hats as they should have the gameevent as loot condition
DELETE FROM `creature_loot_template` WHERE `entry` IN (9019,9237,10997,17862,20521,19221,21536,17975,21558,1853,10899,11486,16807,20568,18732,20653,18373,20306) AND `item` IN (21524,21525);

-- Madrigosa script target fix
-- not implemented yet
DELETE FROM spell_script_target WHERE entry = 46609;
INSERT INTO spell_script_target (entry,type,targetEntry) VALUES
(46609,1,19871);

-- Void Sentinal Summoner 25782
UPDATE creature_template SET `MinLevel` = 70, `MaxLevel` = 70, `Faction_A`=114, `Faction_H` = 114, `MinHealth` = 6602, `MaxHealth` = 6602, `mindmg` = 252, `maxdmg` = 357, `minrangedmg` = 215, `maxrangedmg` = 320, `unit_flags` = `unit_flags`|33554688, `armor` = 6792, `attackpower` = 304, `rangedattackpower` = 44 WHERE `entry` = 25782;

-- ===============
-- Fix Portal Name
-- ===============
UPDATE areatrigger_teleport SET name='Blackrock Depths - Main Entrance' WHERE id=2890;

-- ===============================================================
-- Fix Creature_Template For Vendor Data (Missing From Innkeepers)
-- ===============================================================
UPDATE creature_template set NpcFlag=NpcFlag|640 WHERE entry IN (15433,21088);

DELETE FROM `npc_vendor` WHERE `entry` = 15433;
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 159, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 1179, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 1205, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 1645, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 1708, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 4540, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 4541, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 4542, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 4544, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 4601, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 8766, 0, 0, 0);
INSERT INTO `npc_vendor` (`entry`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES (15433, 8950, 0, 0, 0);

-- ===============================================
-- Add Several Spell Targets (Gnarlpine Vengeance)
-- ===============================================
DELETE FROM `spell_script_target` WHERE `entry` = 5628;
INSERT INTO spell_script_target VALUES 
(5628, 1, 2006),
(5628, 1, 2007),
(5628, 1, 2008),
(5628, 1, 2009),
(5628, 1, 2010),
(5628, 1, 2011),
(5628, 1, 2012),
(5628, 1, 2013),
(5628, 1, 2014);

-- Gnarlpine Augur
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 2011;
INSERT INTO `creature_ai_scripts` VALUES
('201101','2011','0','0','100','1','6000','11000','9000','16000','11','702','4','32','0','0','0','0','0','0','0','0','Gnarlpine Augur - Cast Curse of Weakness'),
('201102','2011','6','0','100','0','0','0','0','0','11','5628','0','7','0','0','0','0','0','0','0','0','Gnarlpine Augur - Cast Gnarlpine Vengeance on Death');

-- Razormane Hunter
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 3265;
INSERT INTO `creature_ai_scripts` VALUES
('326500','3265','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Razormane Hunter - Start Movement and Set Melee Weapon Model'),
('326501','3265','1','0','100','0','0','0','0','0','11','6479','0','7','0','0','0','0','0','0','0','0','Razormane Hunter - Spawn Razormane Wolf (Entry 3939) on Spawn'),
('326502','3265','9','0','100','1','5','25','2300','3900','40','2','0','0','11','6660','1','0','0','0','0','0','Razormane Hunter - Set Ranged Weapon Model and Cast Shoot'),
('326503','3265','9','0','100','1','25','80','0','0','21','1','1','0','20','1','0','0','0','0','0','0','Razormane Hunter - Start Combat Movement and Start Melee over 25th yard'),
('326504','3265','9','0','100','1','10','25','0','0','21','0','1','0','20','0','0','0','0','0','0','0','Razormane Hunter - Prevent Combat Movement and Prevent Melee between 10 and 25 yard '),
('326505','3265','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Razormane Hunter - Flee at 15% HP'),
('326506','3265','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Razormane Hunter - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('326507','3265','7','0','100','0','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Razormane Hunter - Set Phase 1 and Set Melee Weapon Model and Start Movement on Evade'),
('326508','3265','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Razormane Hunter - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -10020 AND -10001;

-- Son of Cenarius 4057
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = 4057;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 4057;
INSERT INTO `creature_ai_scripts` VALUES    
('405701','4057','11','0','100','0','0','0','0','0','11','7993','0','7','0','0','0','0','0','0','0','0','Son of Cenarius - Summon Treant Ally on Spawn');

-- =======================================================
-- Delete Extra Trent Ally Spawns (Summoned By Spell Only)
-- =======================================================
DELETE FROM creature WHERE id = 5806;
DELETE FROM creature_addon WHERE guid IN (29974,29975,29976,29977,29978,29979,29980);

DELETE FROM `creature_equip_template` WHERE `entry` = 4001;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(4001, 45947, 0, 0, 50268674, 0, 0, 529, 0, 0);

-- trigger
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 20736;

DELETE FROM `creature` WHERE `guid` = 56870;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (56870, 16221, 530, 1, 0, 0, 9310.94, -7261.34, 13.2628, 5.12366, 300, 0, 0, 267, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = 56870;
INSERT INTO `creature_addon` VALUES (56870, 56870, 0, 16777472, 0, 4097, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id` = 56870;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 1, 9313.76, -7233.52, 14.3607, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 2, 9321.56, -7210.41, 14.9568, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 3, 9324.87, -7190.41, 15.5912, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 4, 9322.9, -7169.13, 15.6939, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 5, 9315.66, -7141.71, 16.3783, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 6, 9308.27, -7128.08, 16.3927, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 7, 9288.27, -7098.95, 15.0777, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 8, 9282.51, -7083.99, 12.7755, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 9, 9283.83, -7072.6, 11.6658, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 10, 9279.03, -7084.2, 12.8351, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 11, 9285.3, -7100.68, 15.1796, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 12, 9305.98, -7130.13, 16.3521, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 13, 9313.23, -7142.95, 16.3343, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 14, 9320.03, -7170.39, 15.744, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 15, 9321.99, -7191.2, 15.5395, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 16, 9318.65, -7209.67, 15.0213, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 17, 9311.12, -7233.62, 14.4968, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES (56870, 18, 9310.98, -7261.15, 13.2516, 180000, 0, 0, 0, 0);
DELETE FROM `creature_formations` WHERE `leaderguid` = 56870;
INSERT INTO `creature_formations` VALUES
(56870,56870,100,360,2),
(56870,56871,2,4.71,2);

UPDATE `creature` SET `spawndist` = 5, `MovementType` = 1 WHERE `id` = 18467;
UPDATE `creature` SET `position_x`='-2794.2963', `position_y`='4552.5883', `position_z`='-5.3070' WHERE `guid` = 66272;
UPDATE `creature` SET `spawndist` = 5 WHERE `guid` = 86064;
UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` IN (13092,23709,43211,43212);

-- Cleanup
UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';
DELETE FROM `creature_addon` WHERE `path_id`=0 AND `mount`=0 AND `bytes1`=0 AND `bytes2`=0 AND `emote`=0 AND `auras` IS NULL;
DELETE FROM `creature_template_addon` WHERE `path_id`=0 AND `mount`=0 AND `bytes1`=0 AND `bytes2`=0 AND `emote`=0 AND `auras` IS NULL;
UPDATE `creature` SET `MovementType` = 0 WHERE `spawndist` = 0 AND `MovementType`=1;
UPDATE `creature` SET `spawndist`=0 WHERE `MovementType`=0;
UPDATE creature_addon SET moveflags=moveflags &~ 0x00000100; -- MONSTER_MOVE_TELEPORT
UPDATE creature_addon SET moveflags=moveflags &~ 0x00000800; -- MONSTER_MOVE_UNK1 (can crash client)
UPDATE creature_addon SET moveflags=moveflags &~ 0x00200000; -- MONSTER_MOVE_UNK4 (can crash client)
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x00000100;
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x00000800;
UPDATE creature_template_addon SET moveflags=moveflags &~ 0x00200000;
