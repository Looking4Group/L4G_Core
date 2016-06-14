-- fixing Shadowpine Hexxer (16346), Shadowpine Catlord (16345), Sentinel Infiltrator(16333) respawn to 5 mins
UPDATE creature SET spawntimesecs = 300 WHERE id IN (16346, 16345, 16333);
-- complete from trinity update 322.6 
UPDATE `creature_equip_template` SET `equipmodel2`='43792',`equipinfo2`='234948100 ',`equipslot2`='1038' WHERE `entry` IN ('1654');
-- Shadowmoon Darkweaver 22081
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('22081');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22081');
INSERT INTO `creature_ai_scripts` VALUES
(2208101,22081,1,0,100,1,1000,1000,1800000,1800000,11,38446,0,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Casts Dark Summoning on Spawn'),
(2208102,22081,0,0,100,1,8000,10000,8000,10000,11,11962,1,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Immolate'),
(2208103,22081,9,0,100,1,0,5,10000,15000,11,35373,0,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Shadowfury'),
(2208104,22081,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Start Movement on Aggro'),
(2208105,22081,4,0,100,0,0,0,0,0,11,11962,1,0,22,1,0,0,0,0,0,0,'Shadowmoon Darkweaver - Cast Immolate and Set Phase 1 on Aggro'),
(2208106,22081,0,13,100,1,2000,3000,3000,4000,0,0,0,0,11,9613,1,0,0,0,0,0,'Shadowmoon Darkweaver - Cast Shadow Bolt (Phase 1)'),
(2208107,22081,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Shadowmoon Darkweaver - Start Movement and Set Phase 2 when Mana is at 15%'),
(2208108,22081,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Start Movement Beyond 25 Yards'),
(2208109,22081,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Set Phase 1 when Mana is above 30% (Phase 2)'),
(2208110,22081,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - Set Phase 3 at 15% HP'),
(2208111,22081,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Shadowmoon Darkweaver - Start Movement and Flee at 15% HP (Phase 3)'),
(2208112,22081,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Shadowmoon Darkweaver - On Evade set Phase to 0');
-- Scarshield Acolyte 9045
UPDATE `creature_template` SET `modelid_A2`='9853',`modelid_H2`='9853' WHERE `entry` IN ('9045');
-- Flesh Eating Worm
UPDATE `creature_template` SET `lootid`='0' WHERE `entry` IN ('2462');
--
-- no exp
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|'64' WHERE `entry` IN (2462,22355,18909,18922,68,1642,4262,5595,16222,19500,3571,10037,15852,1756,15088);
--
-- deathguard olivers waypoint path
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=28706 AND `id`=1737;
DELETE FROM `creature_addon` WHERE `guid`=28706;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (28706,287060,0,0,4097,0,0,'18950 0');
DELETE FROM `waypoint_data` WHERE `id`=287060;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES 
(287060,1,1827.97,1608.97,95.8095,0,0,0,100,0),
(287060,2,1825.75,1645.94,95.6226,30000,0,0,100,0),-- stands at fence for 30 secs
(287060,3,1825.78,1591.98,94.7738,0,0,0,100,0),
(287060,4,1814.01,1589.88,97.1136,0,0,0,100,0),
(287060,5,1799.11,1597.59,101.781,0,0,0,100,0),
(287060,6,1802.2,1601.52,102.911,0,0,0,100,0),
(287060,7,1808.4,1607.82,102.645,15000,0,0,100,0),-- stands here for 15 secs
(287060,8,1800.17,1600.14,102.897,0,0,0,100,0),
(287060,9,1798.63,1595.36,101.307,0,0,0,100,0),
(287060,10,1823.07,1588.53,95.2936,0,0,0,100,0);
--
-- 1512 duskbat movement increased
UPDATE `creature` SET `spawndist`=10,`MovementType`=1 WHERE `id`=1512;
-- 1509 ragged scavengers on bigger random
UPDATE `creature` SET `spawndist`=10,`MovementType`=1 WHERE `id`=1509;
-- 1513 mangy duskbats on bigger random
UPDATE `creature` SET `spawndist`=10,`MovementType`=1 WHERE `id`=1513;

-- set up wretched zombie on wp path and to charge to the guards
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=44808;
UPDATE `creature_addon` SET `path_id`=448080 WHERE `guid`=44808;
DELETE FROM `waypoint_data` WHERE `id`=448080;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES 
(448080,1,1922.09,1548.48,87.1417,0,0,0,100,0),
(448080,2,1916.51,1563.13,86.3795,0,0,0,100,0),
(448080,3,1931.5,1559.04,87.006,0,0,0,100,0),
(448080,4,1936.0,1557.74,87.6393,0,0,0,100,0),
(448080,5,1930.04,1552.25,87.8579,0,0,0,100,0),
(448080,6,1925.3,1551.31,87.1472,0,0,0,100,0),
(448080,7,1917.13,1548.74,86.9007,0,0,0,100,0),
(448080,8,1920.98,1561.15,86.1384,0,0,0,100,0),
(448080,9,1932.77,1566.77,84.1405,0,0,0,100,0),
(448080,10,1949.08,1574.19,81.2356,0,0,0,100,0),
(448080,11,1956.98,1585.29,81.2102,0,0,0,100,0),
(448080,12,1951.91,1593.34,82.0238,0,0,0,100,0),
(448080,13,1947.45,1583.45,80.9648,0,0,0,100,0),
(448080,14,1936.29,1574.2,82.7512,0,0,0,100,0),
(448080,15,1925.86,1573.74,84.1143,0,0,0,100,0),
(448080,16,1926.94,1580.69,83.099,0,0,0,100,0),
(448080,17,1919.99,1585.89,83.861,1000,0,0,100,0),
(448080,18,1898.07,1586.52,87.3678,3000,0,0,100,0),
(448080,19,1886.25,1588.39,89.2619,0,1,0,100,0),-- run to guards
(448080,20,1930.4,1580.68,82.7223,0,0,0,100,0);

-- wp path for misc zombie (he is just blizzards eycandy)
UPDATE `creature` SET `spawndist`=0,`MovementType`=2 WHERE `guid`=44818;
UPDATE `creature_addon` SET `path_id`=448180 WHERE `guid`=44818;
DELETE FROM `waypoint_data` WHERE `id`=448180;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES 
(448180,1,1917.28,1532.13,86.9054,0,0,0,100,0),
(448180,2,1920.1,1557.7,86.4135,0,0,0,100,0),
(448180,3,1926.93,1573.8,83.991,0,0,0,100,0),
(448180,4,1929.87,1573.85,83.6135,0,0,0,100,0),
(448180,5,1924.92,1579.0,83.4188,0,0,0,100,0),
(448180,6,1931.67,1595.07,83.6037,0,0,0,100,0),
(448180,7,1932.63,1607.29,82.7558,0,0,0,100,0),
(448180,8,1930.97,1591.35,83.3431,0,0,0,100,0),
(448180,9,1922.52,1586.04,83.5847,0,0,0,100,0),
(448180,10,1931.54,1581.75,82.5486,0,0,0,100,0),
(448180,11,1922.33,1559.69,86.201,0,1,0,100,0); -- runs back to pt 1
-- there are NO prtals that should move
UPDATE `creature` SET `MovementType`=0, `spawndist`=0 WHERE `id` IN (SELECT `entry` FROM `creature_template` WHERE `name` LIKE '%portal%');
-- Combustion 11129 -- 28682 -- 29977
-- Rev 6799 Combustion
UPDATE `spell_proc_event` SET `SchoolMask`=4 WHERE `entry`=11129; -- `spellFamilyMask0`=146800663,`spellFamilyMask1`=200776
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16175');
INSERT INTO `creature_ai_scripts` VALUES
('1617501','16175','1','0','100','3','1000','1000','180000','180000','11','32429','0','39','0','0','0','0','0','0','0','0','Vampiric Shadowbat - Cast Draining Touch Aura OCC');
--
-- missing equipment template from tc 322.7 update
UPDATE `creature_template` SET `equipment_id`=8024 WHERE `entry`=25035; -- 2080
UPDATE `creature_template` SET `equipment_id`=8025 WHERE `entry`=25069; -- 2083
UPDATE `creature_template` SET `equipment_id`=8026 WHERE `entry`=25037; -- 2081
-- missing equipment template from tc 322.7 update
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8024','8025','8026');
INSERT INTO `creature_equip_template` VALUES
(8024,38724,0,0,218173186,0,0,3,0,0),
(8025,33255,0,0,218169346,0,0,3,0,0),
(8026,33304,0,39431,218171138,0,50266626,3,0,15);
DELETE FROM `creature_template_addon` WHERE `entry` IN ('25037');
INSERT INTO `creature_template_addon` VALUES
(25037,0,0,0,0,4098,0,0,NULL);
--
UPDATE `creature_ai_scripts` SET `action2_type`='40',`action2_param1`='2',`comment`='Dawnblade Hawkrider - Cast Dawnblade Attack and Set Ranged Weapon Model' WHERE `id` IN ('2506301');
UPDATE `creature_template` SET `mindmg`='4000',`maxdmg`='6000',`unit_flags`='37632',`flags_extra`='66' WHERE `entry` IN ('26253'); -- 16250,21250,37632,9175040
--
-- Remove auras which are already in ACID 3.0.2 and dont need to be moved to EAI
UPDATE `creature_template_addon` SET `auras`=null WHERE `entry` IN (881,1260,1729,1732,2018,4299,4303,4805,6221,7843,8567,12902,16175,16844,16857,16873,17143,17147,18077,18121,18450,18453,18464,18465,18637,18640,19411,19415,19457,19732,19952,20115,20886,21242,21380);
-- Remove auras where creatures have player pet auras
UPDATE `creature_template_addon` SET `auras`=null WHERE `entry` IN (454,728,3862,5427,7456,8960,10200);
--
-- Vampiric Mistbat 16354
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16354');
INSERT INTO `creature_ai_scripts` VALUES
('1635401','16354','1','0','100','2','1000','1000','12000','18000','11','29363','0','32','0','0','0','0','0','0','0','0','Vampiric Mistbat - Cast Draining Touch Aura');
-- mines should not move & give no exp
UPDATE `creature_template` SET `unit_flags`='4',`flags_extra`='64' WHERE `entry` IN (7527,8035,15368,22315);
--
-- Immune to CC 
UPDATE `creature_template` SET `armor`='5200',`mechanic_immune_mask`='13111315' WHERE `entry` IN ('18327'); -- kleiner gebogener Holzstock wie die Furbolgs
UPDATE `creature_template` SET `armor`='5950',`minmana`='35980',`maxmana`='35980',`speed`='1.48',`lootid`='18327',`mindmg`='1181',`maxdmg`='1421',`mechanic_immune_mask`='13111315' WHERE `entry` IN ('20691'); -- 411 890
--
-- Change movetype to stay (by kiper) Naxxx
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 where `id`=16236;
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'4' WHERE `entry` IN ('16236');
-- working state for last constuction worker
UPDATE `creature_addon` SET `emote`='69' WHERE `guid` IN ('84719');
UPDATE `creature` SET `orientation`='0.7152' WHERE `guid` IN ('85178');
UPDATE `waypoint_data` SET `delay`='0',`action`='0' WHERE `id` IN ('1756') AND `point` IN ('6');
INSERT INTO `waypoint_data` VALUES
(1756,7,-8650.9511,933.1313,85.8581,30000,0,220,100,0);
-- Doom Lord Kazzak
UPDATE `creature_template` SET `speed`='3',`mindmg`='16000',`maxdmg`='25143',`mechanic_immune_mask`='1073692671',`flags_extra`='4259841' WHERE `entry` IN ('18728'); -- 1 6250 16250
--
-- Tremor Totem
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('5913');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('5913');
INSERT INTO `creature_ai_scripts` VALUES
('591301','5913','1','0','100','0','0','0','0','0','11','8146','0','0','0','0','0','0','0','0','0','0','Tremor Totem - Cast Tremor Totem Effect on Spawn');
-- Grounding Totem
-- UPDATE `creature_template` SET `AIName`='' WHERE `entry` IN ('5925');
-- DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('5925');
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('592501','5925','1','0','100','0','0','0','0','0','11','8178','0','0','0','0','0','0','0','0','0','0','Grounding Totem - Cast Grounding Totem Effect on Spawn');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('5925');
INSERT INTO `creature_template_addon` VALUES
(5925,0,0,0,0,0,0,0,'8178 0'); -- 8179 0
