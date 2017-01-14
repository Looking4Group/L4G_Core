-- -----------------------------------
-- Saltgurka Update 14
-- -----------------------------------
 
-- Manna biscuits can now be eaten by hunter pets
UPDATE `item_template` SET `foodtype`=4 WHERE `entry`=34062;
 
-- Hemorrhage no longer procs on non-physical spells.
DELETE FROM `spell_proc_event` WHERE `entry` IN (16511,17347,17348,26864);
INSERT INTO `spell_proc_event` (`entry`,`SpellFamilyName`,`procFlags`) VALUES
(16511,8,0x000222A8),
(17347,8,0x000222A8),
(17348,8,0x000222A8),
(26864,8,0x000222A8);
 
 
-- Rampage. First proc is on melee crit only, all following procs are on both melee normal and melee crit hits.
UPDATE `spell_proc_event` SET `procEx`=3 WHERE `entry` IN (29801,30030,30033);
-- Fix exploit that allowed you to cancel the stacking aura, but that didn't remove the invisible aura, which mean you would start stacking again without having to pay 20 Rage to activate it.
-- This exploit allowed the buff to last double as long if you did it at the right moment.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`='-30032';
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES ('-30032', '-30033', 'Remove Warrior Rampage trigger if player cancels the Stacking Aura.');

-- Tyrantus 20931
SET @GUID := 86748;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (86748, 20931, 530, 1, 0, 0, 5050.57, 2896.73, 83.7779, 0.130239, 160, 0, 0, 9335, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (86748, 1, 5116.44, 2905.53, 77.0648, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 2, 5133.4, 2909.44, 72.4063, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 3, 5183.69, 2891.85, 54.6853, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 4, 5192.38, 2910.73, 58.1054, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 5, 5180.38, 2916.19, 64.381, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 6, 5146.01, 2941.57, 74.6116, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 7, 5139.39, 2946.47, 71.6427, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 8, 5121.76, 2930.02, 78.2033, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 9, 5090.15, 2937.53, 83.9492, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 10, 5049.37, 2951.28, 87.6848, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 11, 5044.55, 2913.1, 88.6466, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (86748, 12, 5050.4, 2896.25, 83.7468, 0, 0, 0, 0, 0);

-- Magistrix Seyla
UPDATE `creature` SET `spawnmask` = 0 WHERE `id` = 24937;

-- Trigger NPC
UPDATE `creature_template` SET `InhabitType` = 7 WHERE `entry` = 24921;

SET @GUID := 64246;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (64246, 18121, 530, 1, 0, 0, 1487.56, 8615.63, -25.3721, 0.142035, 300, 0, 0, 4422, 2620, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64246, 1, 1502.9443, 8616.0058, -26.6611, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 2, 1526.74, 8614.7, -31.361, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 3, 1543.33, 8612.67, -32.8239, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 4, 1550.0433, 8611.8701, -33.8301, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 5, 1562.4114, 8612.3642, -35.7223, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 6, 1610.06, 8604.58, -28.9488, 5000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 7, 1562.4114, 8612.3642, -35.7223, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 8, 1550.0433, 8611.8701, -33.8301, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 9, 1543.33, 8612.67, -32.8239, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 10, 1526.74, 8614.7, -31.361, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 11, 1502.9443, 8616.0058, -26.6611, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64246, 12, 1481, 8617.21, -22.3273, 5000, 0, 0, 0, 0);

-- Ango'rosh Souleater - Movement
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN (1812101,1812107);

-- Quest Convenience
UPDATE item_template SET stackable = 1 WHERE entry = 31346; -- 1

-- Poor Weapons (Gold Inflation) 24001
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 3 WHERE `mincountOrRef` = -24001; -- 5
-- Poor Armor (Gold Inflation) 24002
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 3 WHERE `mincountOrRef` = -24002; -- 5

SET @GUID := 64223;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (64223, 18120, 530, 1, 0, 0, 1394.52, 8623.38, 9.4831, 3.23446, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64223, 1, 1394.52, 8623.38, 9.4831, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 2, 1367.01, 8620, 14.6973, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 3, 1348.54, 8608.5, 18.9828, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 4, 1330.3, 8594.46, 20.7081, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 5, 1312.62, 8590.25, 19.8928, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 6, 1271.03, 8590.59, 19.0253, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 7, 1312.62, 8590.25, 19.8928, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 8, 1330.3, 8594.46, 20.7081, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 9, 1348.51, 8608.5, 18.9951, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 10, 1367.01, 8620, 14.6973, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 11, 1394.52, 8623.38, 9.4831, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 12, 1409.57, 8618.85, 5.86771, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 13, 1424.44, 8607.31, 3.25742, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 14, 1441.44, 8607.56, -2.58179, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 15, 1461.23, 8614.6, -12.2068, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 16, 1484.59, 8616.81, -23.6464, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 17, 1461.68, 8614.68, -12.7068, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 18, 1441.52, 8607.56, -2.71729, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 19, 1424.44, 8607.31, 3.25742, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64223, 20, 1409.57, 8618.85, 5.86771, 0, 0, 0, 100, 0);

SET @GUID := 64228;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (64228, 18120, 530, 1, 0, 0, 1764.78, 8621.49, 3.29565, 3.50196, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64228, 1, 1764.78, 8621.49, 3.29565, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 2, 1755.78, 8625.82, 4.38501, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 3, 1744.3, 8627.53, 6.18872, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 4, 1729.12, 8630.34, 6.31183, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 5, 1717.92, 8632.59, 8.06501, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 6, 1699.81, 8628.59, 12.0102, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 7, 1689.12, 8621.33, 12.5069, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 8, 1681.7, 8611.76, 12.6384, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 9, 1675, 8605.29, 12.3617, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 10, 1664.97, 8601.52, 10.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 11, 1655.83, 8594.22, 8.95046, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 12, 1649.31, 8586.1, 8.34609, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 13, 1655.83, 8594.22, 8.95046, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 14, 1664.97, 8601.52, 10.784, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 15, 1675, 8605.29, 12.3617, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 16, 1681.7, 8611.76, 12.6384, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 17, 1689.12, 8621.33, 12.5069, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 18, 1699.81, 8628.59, 12.0102, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 19, 1717.92, 8632.59, 8.06501, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 20, 1729.12, 8630.34, 6.31183, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 21, 1744.3, 8627.53, 6.18872, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 22, 1755.78, 8625.82, 4.38501, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 23, 1764.72, 8621.62, 3.3584, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 24, 1770.79, 8609.97, 0.86006, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 25, 1778.08, 8581.91, -7.02197, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 26, 1781.57, 8556.62, -9.00761, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 27, 1791.78, 8532.47, -16.7822, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 28, 1806.07, 8517.05, -16.5287, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 29, 1812.22, 8498.1, -19.5813, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 30, 1805.24, 8477.74, -19.6905, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 31, 1809.99, 8468.15, -16.3652, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 32, 1822.48, 8447.89, -16.8868, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 33, 1809.99, 8468.15, -16.3652, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 34, 1805.24, 8477.74, -19.6905, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 35, 1812.22, 8498.1, -19.5813, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 36, 1806.07, 8517.05, -16.5287, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 37, 1791.8, 8532.45, -16.8339, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 38, 1781.57, 8556.62, -9.00761, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 39, 1778.08, 8581.91, -7.02197, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64228, 40, 1770.79, 8609.97, 0.86006, 0, 0, 0, 100, 0);

SET @GUID := 64232;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (64232, 18120, 530, 1, 0, 0, 1608.69, 8551.91, -15.6161, 2.68401, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64232, 1, 1608.69, 8551.91, -15.6161, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 2, 1606.19, 8568.75, -21.7997, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 3, 1608.48, 8584.46, -29.3473, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 4, 1606.19, 8568.75, -21.7997, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 5, 1608.68, 8551.94, -15.4296, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 6, 1611.31, 8535.48, -8.69375, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 7, 1615.58, 8524.72, -6.33484, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 8, 1622.58, 8518.37, -5.84937, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 9, 1631.16, 8510.86, -6.80164, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 10, 1644.64, 8504.22, -7.0206, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 11, 1654.69, 8501.37, -6.63352, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 12, 1665.91, 8502.83, -6.9249, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 13, 1672.21, 8501.25, -7.81, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 14, 1677.83, 8494.04, -8.56403, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 15, 1689.13, 8484.7, -7.43525, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 16, 1700.16, 8477, -6.36907, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 17, 1689.13, 8484.7, -7.43525, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 18, 1677.83, 8494.04, -8.56403, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 19, 1672.21, 8501.25, -7.81, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 20, 1665.91, 8502.83, -6.9249, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 21, 1654.69, 8501.37, -6.63352, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 22, 1644.64, 8504.22, -7.0206, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 23, 1631.16, 8510.86, -6.80164, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 24, 1622.58, 8518.37, -5.84937, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 25, 1615.58, 8524.72, -6.33484, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64232, 26, 1611.31, 8535.48, -8.69375, 0, 0, 0, 100, 0);

SET @GUID := 64239;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (64239, 18120, 530, 1, 0, 0, 1643.83, 8612.98, -31.1259, 5.05577, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64239, 1, 1643.83, 8612.98, -31.1259, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 2, 1636.37, 8611.65, -28.4568, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 3, 1631.08, 8610.18, -27.16, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 4, 1624.01, 8607.95, -25.6686, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 5, 1630.67, 8610.06, -27.0775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 6, 1636.37, 8611.65, -28.4568, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 7, 1643.82, 8612.98, -31.1251, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 8, 1653.17, 8612.42, -33.3041, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 9, 1659.04, 8606.21, -35.0201, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 10, 1663.34, 8595.79, -39.4456, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 11, 1668.67, 8580.87, -43.5667, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 12, 1672.77, 8571.9, -45.457, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 13, 1683.16, 8565.99, -47.1843, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 14, 1706.9, 8560.65, -45.6206, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 15, 1683.16, 8565.99, -47.1843, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 16, 1672.77, 8571.9, -45.457, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 17, 1668.67, 8580.87, -43.5667, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 18, 1663.34, 8595.79, -39.4456, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 19, 1659.04, 8606.21, -35.0201, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64239, 20, 1653.17, 8612.42, -33.3041, 0, 0, 0, 100, 0);

SET @GUID := 64241;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (64241, 18120, 530, 1, 0, 0, 1654.65, 8521.53, -53.5835, 3.14159, 300, 0, 0, 5527, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64241, 1, 1654.65, 8521.53, -53.5835, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 2, 1649.62, 8510.09, -54.2113, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 3, 1648.94, 8498.17, -53.8317, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 4, 1656.67, 8485.06, -55.7098, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 5, 1668.38, 8473.03, -58.7728, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 6, 1682.67, 8469.87, -61.031, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 7, 1693.72, 8469.74, -60.3237, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 8, 1702.25, 8470.65, -59.5008, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 9, 1715.03, 8473.5, -57.4673, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 10, 1702.25, 8470.65, -59.5008, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 11, 1693.75, 8469.74, -60.2351, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 12, 1682.67, 8469.87, -61.031, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 13, 1668.38, 8473.03, -58.7728, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 14, 1656.67, 8485.06, -55.7098, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 15, 1648.94, 8498.17, -53.8317, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 16, 1649.62, 8510.09, -54.2113, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 17, 1654.65, 8521.53, -53.5835, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 18, 1664.27, 8535.21, -51.2856, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 19, 1673.35, 8538.97, -49.8396, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 20, 1687.69, 8539.3, -49.183, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 21, 1698.44, 8539.61, -48.2535, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 22, 1687.69, 8539.3, -49.183, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 23, 1673.36, 8538.98, -49.8888, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (64241, 24, 1664.27, 8535.21, -51.2856, 0, 0, 0, 100, 0);

SET @GUID := 64259;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (64259, 18121, 530, 1, 0, 0, 1701.71, 8476.47, -6.14528, 2.68781, 300, 0, 0, 4422, 2620, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64259, 1, 1681.44, 8486.82, -8.04557, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 2, 1670.9, 8499.21, -7.93905, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 3, 1656.29, 8499.72, -6.64107, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 4, 1636.63, 8506.09, -7.37743, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 5, 1619.45, 8519.54, -5.86774, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 6, 1612.97, 8530.24, -7.36203, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 7, 1611.98, 8538.14, -9.667, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 8, 1608.91, 8559.17, -18.6553, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 9, 1606.81, 8566.77, -20.9001, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 10, 1607.43, 8574.21, -24.1375, 10000, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 11, 1605.88, 8566.47, -20.8363, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 12, 1609.4, 8557.97, -18.1479, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 13, 1610.9, 8540.09, -10.5095, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 14, 1612.82, 8526.25, -6.42162, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 15, 1624.66, 8514.33, -6.42656, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 16, 1643.3, 8503.39, -7.19652, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 17, 1659.96, 8500.68, -6.61295, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 18, 1672.67, 8498.77, -8.13133, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64259, 19, 1702.05, 8479.28, -6.15383, 10000, 0, 0, 0, 0);

-- Zalazane 3205
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('3205');
INSERT INTO `creature_ai_scripts` VALUES
('320501','3205','9','0','100','1','0','25','6000','10500','11','7289','4','32','0','0','0','0','0','0','0','0','Zalazane - Cast Shrink'),
('320502','3205','2','0','100','1','50','0','10000','15000','11','332','0','1','0','0','0','0','0','0','0','0','Zalazane - Cast Healing Wave at 50% HP'),
('320503','3205','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Zalazane - Flee at 15% HP');
--
SET @GUID := '13001';
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(13001,1,-1284.75,-5534.64,15.194,0,0,0,0,0),
(13001,2,-1279.21,-5533.94,14.9978,0,0,0,0,0),
(13001,3,-1263.56,-5534.82,6.68782,0,0,0,0,0),
(13001,4,-1259.35,-5526.31,5.56873,0,0,0,0,0),
(13001,5,-1259.52,-5511.77,5.56369,0,0,0,0,0),
(13001,6,-1254.09,-5513.06,5.76845,0,0,0,0,0),
(13001,7,-1248.72,-5520.58,5.98018,0,0,0,0,0),
(13001,8,-1244.54,-5527.47,5.6585,0,0,0,0,0),
(13001,9,-1233.42,-5536.23,5.03145,0,0,0,0,0),
(13001,10,-1228.55,-5544.99,4.42019,0,0,0,0,0),
(13001,11,-1235.32,-5543.22,4.20322,0,0,0,0,0),
(13001,12,-1247.51,-5526.22,5.80676,0,0,0,0,0),
(13001,13,-1259,-5523.91,5.60917,0,0,0,0,0),
(13001,14,-1265.91,-5533.76,7.3323,0,0,0,0,0),
(13001,15,-1278.21,-5533.66,14.5769,0,0,0,0,0);

SET @GUID := 46817;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (46817, 23399, 564, 1, 0, 0, 609.316, 98.4336, 112.342, 5.4793, 30, 0, 0, 49560, 66180, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (46817, 1, 609.316, 98.4336, 112.342, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (46817, 2, 580.646, 90.1881, 111.161, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (46817, 3, 609.316, 98.4336, 112.342, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (46817, 4, 629.514, 77.4753, 112.792, 0, 0, 0, 100, 0);

SET @GUID := 45208;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (45208, 19792, 530, 1, 0, 0, -4300.74, 1528.3, 145.323, 6.02139, 300, 0, 0, 1, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (45208, 1, -4300.74, 1528.3, 145.323, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45208, 2, -4267.3, 1506.35, 137.316, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45208, 3, -4234.44, 1486.09, 127.767, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45208, 4, -4266.8, 1506.02, 137.566, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45208, 5, -4300.74, 1528.3, 145.323, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45208, 6, -4333.72, 1549.17, 154.284, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45208, 7, -4365.85, 1562.44, 160.944, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45208, 8, -4333.71, 1549.16, 154.197, 0, 0, 0, 100, 0);

DELETE FROM `creature` WHERE `id` = 15214; -- 12402,12925,45075,45099,45136,45208
SET @GUID := 45136;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (45136, 16906, 530, 1, 0, 0, -1245.85, 2530.15, 39.8954, 0.325707, 120, 0, 0, 1, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (45136, 1, -1245.85, 2530.15, 39.8954, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 2, -1215, 2524.66, 46.1355, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 3, -1199.7, 2529.83, 46.0862, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 4, -1174.8, 2530.01, 49.2358, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 5, -1148.8, 2544.55, 46.8673, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 6, -1124.96, 2558.43, 43.6249, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 7, -1109.3, 2576.64, 38.4571, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 8, -1096.7, 2593.5, 33.9679, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 9, -1087.89, 2610.02, 27.8341, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 10, -1076.24, 2628.69, 21.1295, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 11, -1087.89, 2610.02, 27.8795, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 12, -1096.7, 2593.5, 33.9679, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 13, -1109.3, 2576.64, 38.4571, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 14, -1124.96, 2558.43, 43.6249, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 15, -1148.8, 2544.55, 46.8673, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 16, -1174.8, 2530.01, 49.2358, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 17, -1199.7, 2529.83, 46.0862, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45136, 18, -1215, 2524.66, 46.1355, 0, 0, 0, 100, 0);

SET @GUID := 45099;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (45099, 18134, 530, 1, 0, 0, -245.411, 7483.66, 17.3958, 6.02139, 300, 0, 0, 1, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (45099, 1, -245.411, 7483.66, 17.3958, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 2, -247.296, 7450.51, 17.5493, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 3, -254.912, 7428.49, 17.7533, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 4, -285.53, 7422.53, 17.6539, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 5, -305.531, 7416.8, 17.6698, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 6, -285.53, 7422.53, 17.6539, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 7, -254.912, 7428.49, 17.7533, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 8, -247.296, 7450.51, 17.5493, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 9, -245.411, 7483.66, 17.3958, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 10, -247.987, 7522.86, 17.7038, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 11, -247.197, 7559.84, 17.5741, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 12, -247.443, 7578.94, 17.3795, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 13, -236.784, 7612.13, 17.5056, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 14, -216.761, 7626.37, 17.4885, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 15, -236.784, 7612.13, 17.5056, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 16, -247.443, 7578.94, 17.3795, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 17, -247.197, 7559.84, 17.5741, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (45099, 18, -247.987, 7522.86, 17.7038, 0, 0, 0, 100, 0);

SET @GUID := 43598;
DELETE FROM `creature` WHERE `guid` IN (@GUID,99971);
DELETE FROM `pool_creature` WHERE `guid` IN (@GUID,99971);
INSERT INTO `pool_creature` VALUES (43598, 30043, 0, 'Windy Cloud - Nagrand');
INSERT INTO `creature` VALUES (43598, 24222, 530, 1, 0, 0, -965.405, 7976.56, 32.7939, 1.14893, 600, 0, 0, 4979, 0, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (43598, 1, -965.388, 7968.49, 35.9964, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (43598, 2, -1014.64, 8027.04, 26.0385, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (43598, 3, -878.702, 8082.89, 32.1764, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (43598, 4, -869.792, 8008.34, 41.453, 0, 0, 0, 100, 0);

SET @GUID := 42920;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (42920, 23399, 564, 1, 16255, 0, 629.089, 47.3309, 112.777, 2.51799, 30, 0, 0, 49560, 66180, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (42920, 1, 629.089, 47.3309, 112.777, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (42920, 2, 601.507, 37.5607, 112.735, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (42920, 3, 575.11, 56.3028, 111.031, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (42920, 4, 601.277, 37.4792, 112.741, 0, 0, 0, 100, 0);

SET @GUID := 41792;
DELETE FROM `creature` WHERE `guid` = @GUID;
INSERT INTO `creature` VALUES (41792, 15937, 530, 1, 0, 0, 8869.87, -5775.96, 0.405, 1.25926, 300, 0, 1, 183, 178, 0, 2);
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (41792, 1, 8880.69, -5754.61, 0.25531, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 2, 8873.34, -5735.01, 0.43308, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 3, 8862.79, -5722.62, 0.42263, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 4, 8846.43, -5720.66, 0.49396, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 5, 8836.92, -5726.74, 0.83736, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 6, 8828.79, -5743.62, 0.8259, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 7, 8818.04, -5755.89, 0.64673, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 8, 8804.55, -5762.79, 0.51199, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 9, 8791.79, -5762.27, 0.45083, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 10, 8777.22, -5753.97, 0.55571, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 11, 8776.86, -5738.23, 0.61609, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 12, 8785.23, -5722.79, 0.75764, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 13, 8786.4, -5701.79, 0.67103, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 14, 8771.28, -5696.08, 0.67596, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 15, 8758.6, -5694.22, 0.55669, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 16, 8746.01, -5704.51, 0.50786, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 17, 8735.82, -5722.94, 0.94607, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 18, 8720.27, -5730.86, 0.89406, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 19, 8706.96, -5730.08, 0.77437, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 20, 8693.58, -5720.97, 0.86999, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 21, 8679.18, -5710.54, 1.10842, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 22, 8656.02, -5704.34, 1.80973, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 23, 8640.98, -5691.51, 0.4769, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 24, 8635.42, -5689.71, 0.53144, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 25, 8620.44, -5687.68, 0.86486, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 26, 8601.69, -5688.44, 0.49338, 36000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 27, 8619.99, -5679.97, 0.75128, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 28, 8635.67, -5671.58, 0.53144, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 29, 8648.3, -5670.15, 0.49488, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 30, 8664.99, -5679.42, 0.55752, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 31, 8679.18, -5710.54, 1.10842, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 32, 8693.58, -5720.97, 0.86999, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 33, 8706.96, -5730.08, 0.77437, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 34, 8721.72, -5745.01, 0.62278, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 35, 8735.53, -5753.92, 1.24721, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 36, 8767.19, -5758.18, 0.50536, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 37, 8791.79, -5762.27, 0.45083, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 38, 8804.55, -5762.79, 0.51199, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 39, 8818.04, -5755.89, 0.64673, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 40, 8828.79, -5743.62, 0.8259, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 41, 8836.92, -5726.74, 0.83736, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 42, 8846.43, -5720.66, 0.49396, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 43, 8873.34, -5735.01, 0.43308, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (41792, 44, 8880.69, -5754.61, 0.25531, 60000, 0, 0, 100, 0);

SET @GUID := 40526;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (40526, 1, 492.685, 78.6267, 111.24, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40526, 2, 483.629, 51.8116, 112.367, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40526, 3, 497.625, 29.7903, 113.637, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40526, 4, 521.332, 51.4145, 113.37, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40526, 5, 490.61, 79.4847, 111.358, 0, 0, 0, 100, 0);

SET @GUID := 40446;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (40446, 1, 562.457, 106.666, 113.235, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40446, 2, 564.992, 66.6809, 111.341, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40446, 3, 586.732, 43.2198, 112.591, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40446, 4, 602.589, 101.523, 112.376, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (40446, 5, 560.133, 104.79, 113.416, 0, 0, 0, 100, 0);

SET @GUID := 62850; 
DELETE FROM `creature` WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid`= @GUID;
DELETE FROM `waypoint_data` WHERE `id`= @GUID;

DELETE FROM `spell_script_target` WHERE `entry` = 29120;
INSERT INTO `spell_script_target` VALUES
(29120,1,16897),
(29120,1,16898),
(29120,1,16899),
(29120,1,19376),
(29120,1,5202);

-- Dawnblade Marksman 24979
UPDATE `creature_template` SET `speed`='1.20',`inhabittype`='3',`modelid_H`='22792',`modelid_H2`='22794' WHERE `entry` = 24979; 
UPDATE `creature` SET `spawntimesecs`='300' WHERE `id` = 24979;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 24979 OR `entryOrGUID` IN (-94249,-94250,-94251);
INSERT INTO `creature_ai_scripts` VALUES
('2497901','24979','0','0','100','1','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Dawnblade Marksman - Start Movement and Set Melee Weapon Model'),
('2497902','24979','4','0','100','0','0','0','0','0','21','1','0','0','22','1','0','0','0','0','0','0','Dawnblade Marksman - Start Combat Movement and Set Phase 1 on Aggro'),
('2497903','24979','9','5','100','1','5','30','2500','3000','11','6660','1','0','40','2','0','0','21','0','0','0','Dawnblade Marksman - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2497904','24979','9','5','100','1','10','40','13000','17000','11','37847','4','32','40','2','0','0','21','0','0','0','Dawnblade Marksman - Cast Immolation Arrow and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2497905','24979','2','0','100','0','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Dawnblade Marksman - Set Phase 2 at 15% HP'),
('2497906','24979','2','3','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Dawnblade Marksman - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('2497907','24979','7','0','100','0','0','0','0','0','22','1','0','0','40','2','0','0','0','0','0','0','Dawnblade Marksman - Set Phase 1 and Set Ranged Weapon Model on Evade'),
('2497908','24979','9','0','100','1','0','5','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Dawnblade Marksman - Start Movement and Set Melee Weapon Model Below 6 Yards'),
('2497909','24979','9','0','100','1','6','20','0','0','21','0','0','0','40','2','0','0','0','0','0','0','Dawnblade Marksman - Stop Movement and Set Ranged Weapon Model Above 5 Yards'),
-- ('2497910','-94249','1','0','75','1','5000','10000','5000','10000','11','29120','0','0','24','0','0','0','0','0','0','0','Dawnblade Marksman (94249) - Shoot OOC on Dummy & Reset'),
-- ('2497911','-94250','1','0','75','1','5000','10000','5000','10000','11','29120','0','0','24','0','0','0','0','0','0','0','Dawnblade Marksman (94250) - Shoot OOC on Dummy & Reset'),
-- ('2497912','-94251','1','0','75','1','5000','10000','5000','10000','11','29120','0','0','24','0','0','0','0','0','0','0','Dawnblade Marksman (94251) - Shoot OOC on Dummy & Reset');
('2497910','-94249','1','0','75','1','5000','10000','5000','15000','44','29120','94241','0','24','0','0','0','0','0','0','0','Dawnblade Marksman (94249) - Shoot OOC on Dummy & Reset'),
('2497911','-94250','1','0','75','1','5000','10000','5000','15000','44','29120','94242','0','24','0','0','0','0','0','0','0','Dawnblade Marksman (94250) - Shoot OOC on Dummy & Reset'),
('2497912','-94251','1','0','75','1','5000','10000','5000','15000','44','29120','94246','0','24','0','0','0','0','0','0','0','Dawnblade Marksman (94251) - Shoot OOC on Dummy & Reset');

UPDATE `creature` SET `position_x`='12706.8876', `position_y`='-6748.7294', `position_z`='4.1605', `orientation`='3.5732' WHERE `guid` = 94250;

-- Silvermoon Ranger 18147
-- 16897,16898,16899
UPDATE `creature_template` SET `modelid_A`='17539',`modelid_A2`='17541',`modelid_H`='17539',`modelid_H2`='17541',`AIName`='EventAI' WHERE `entry` IN ('18147');
DELETE FROM `creature_ai_scripts` WHERE `id` BETWEEN 1814701 AND 1814704;
INSERT INTO `creature_ai_scripts` VALUES
('1814701','-64950','1','0','75','1','5000','15000','5000','15000','44','29120','58464','0','24','0','0','0','0','0','0','0','Silvermoon Ranger (64950) - Shoot OOC on Dummy & Reset'),
('1814702','-64951','1','0','75','1','5000','15000','5000','15000','44','29120','58464','0','24','0','0','0','0','0','0','0','Silvermoon Ranger (64951) - Shoot OOC on Dummy & Reset'),
('1814703','-64952','1','0','75','1','5000','15000','5000','15000','44','29120','58456','0','24','0','0','0','0','0','0','0','Silvermoon Ranger (64952) - Shoot OOC on Dummy & Reset'),
('1814704','-64953','1','0','75','1','5000','15000','5000','15000','44','29120','58460','0','24','0','0','0','0','0','0','0','Silvermoon Ranger (64953) - Shoot OOC on Dummy & Reset');

-- Honor Hold Archer 16896
UPDATE `creature_template` SET `AIName`='EventAI',`unit_flags`='4096',`flags_extra`='2' WHERE `entry` = 16896; -- 0 0
UPDATE `creature_template_addon` SET `bytes0`='16777472',`bytes2`='4098' WHERE `entry` IN ('16896');
DELETE FROM `creature_ai_scripts` WHERE `id` BETWEEN 1689601 AND 1689604;
INSERT INTO `creature_ai_scripts` VALUES
('1689601','-58449','1','0','75','1','0','5000','5000','10000','44','29120','58457','0','24','0','0','0','0','0','0','0','Honor Hold Archer (58449) - Shoot OOC on Dummy & Reset'),
('1689602','-58451','1','0','75','1','0','5000','5000','10000','44','29120','58455','0','24','0','0','0','0','0','0','0','Honor Hold Archer (58451) - Shoot OOC on Dummy & Reset'),
('1689603','-58450','1','0','75','1','0','5000','5000','10000','44','29120','58461','0','24','0','0','0','0','0','0','0','Honor Hold Archer (58450) - Shoot OOC on Dummy & Reset'),
('1689604','-58454','1','0','75','1','0','5000','5000','10000','44','29120','69107','0','24','0','0','0','0','0','0','0','Honor Hold Archer (58454) - Shoot OOC on Dummy & Reset');

SET @GUID := 64059;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (64059, 1, 9850.77, -7451.69, 13.6249, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 2, 9850.73, -7421.69, 13.3197, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 3, 9805.08, -7419.36, 13.3061, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 4, 9850.1, -7420.27, 13.3164, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 5, 9850.76, -7452.14, 13.6299, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 6, 9850.92, -7421.78, 13.3187, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 7, 9879.56, -7418.61, 13.2654, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 8, 9885.8, -7412.97, 13.2654, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 9, 9888.1, -7388.53, 13.5648, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 10, 9890.7, -7369.25, 20.7165, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 11, 9892.62, -7350.45, 20.6464, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 12, 9893.37, -7338.24, 22.3974, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 13, 9888.71, -7326.05, 23.7671, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 14, 9872.74, -7319.35, 26.2829, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 15, 9854.49, -7320.4, 26.2821, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 16, 9840.42, -7284.02, 26.2259, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 17, 9842.54, -7274.31, 26.133, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 18, 9860.73, -7245.4, 26.7839, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 19, 9870.92, -7232.72, 28.0373, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 20, 9875.86, -7232.71, 28.0373, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 21, 9881.25, -7236.75, 31.0445, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 22, 9886.03, -7237.04, 31.0209, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 23, 9909.42, -7214.81, 30.8594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 24, 9927.99, -7207.16, 30.8627, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 25, 9965.58, -7196.18, 30.8758, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 26, 10000.7, -7184.92, 30.8758, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 27, 9965.65, -7196.19, 30.8758, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 28, 9928.25, -7207.11, 30.8656, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 29, 9910.4, -7214.29, 30.8547, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 30, 9886.04, -7238.09, 31.0198, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 31, 9881.2, -7237.23, 31.0481, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 32, 9875.44, -7232.2, 28.0375, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 33, 9871.49, -7231.91, 28.0375, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 34, 9858.03, -7249.06, 26.7771, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 35, 9842.69, -7274.95, 26.1301, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 36, 9840.72, -7285.18, 26.2211, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 37, 9854.58, -7320.47, 26.2816, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 38, 9877.46, -7320.4, 25.71, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 39, 9891.5, -7329.49, 22.8815, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 40, 9894.34, -7343.66, 22.3979, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 41, 9893.21, -7351.31, 20.6479, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 42, 9890.91, -7369.46, 20.7144, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 43, 9888.19, -7388.55, 13.5651, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 44, 9885.37, -7412.69, 13.2651, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 45, 9879.32, -7418.23, 13.2651, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (64059, 46, 9850.15, -7420.8, 13.3167, 0, 0, 0, 0, 0);
