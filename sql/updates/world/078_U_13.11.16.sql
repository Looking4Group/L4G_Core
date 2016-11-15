-- Blade's Edge Arena Start Orientation
UPDATE `battleground_template` SET `AllianceStartO` = 4.0551, `HordeStartO` = 0.8703 WHERE `id` = 5;

-- Arcane Anomaly 16488
-- some sources say immune to all magic
UPDATE `creature` SET `spawntimesecs` = 3600;
UPDATE `creature_template` SET `mindmg`='3396',`maxdmg`='4342',`resistance1` = '0', `resistance2` = '0', `resistance3` = '0', `resistance4` = '0', `resistance5` = '0', `resistance6` = '70' WHERE `entry` = 16488; -- 1308 2660 -- 7,258 - 8,610
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16488;
INSERT INTO `creature_ai_scripts` VALUES
('1648801','16488','11','0','100','2','0','0','0','0','42','1','1','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Set Invincible at 1% HP on Spawn'),
('1648802','16488','2','0','100','2','1','0','0','0','11','29880','0','1','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Mana Shield at 1% HP'),
('1648803','16488','9','0','100','3','0','40','6000','10000','11','29885','4','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Arcane Volley'),
('1648804','16488','0','0','100','3','18000','30000','30000','45000','11','29883','0','1','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Blink'), -- 4
('1648805','16488','3','0','100','2','1','0','0','0','42','0','1','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Remove Invincible at 1% Mana'),
('1648806','16488','6','0','100','2','0','0','0','0','11','29882','0','7','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Loose Mana on Death');

-- Syphoner 16492
UPDATE `creature_template` SET `mindmg`='1450',`maxdmg`='1856' WHERE `entry` = 16492; -- 558 1138 -- 3,102 - 3,682
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16492;
INSERT INTO `creature_ai_scripts` VALUES
('1649201','16492','9','0','100','3','0','15','9000','13000','11','29881','4','0','0','0','0','0','0','0','0','0','Syphoner - Cast Drain Mana');
