-- Wild Fel Stalker - Wilder Teufelspirscher
UPDATE `creature_template` SET `mindmg`='2602',`maxdmg`='3090',`baseattacktime`='1000',`speed`='1.71',`spell1`='33091' WHERE `entry` IN ('18847'); -- ba 1400 
-- activate Ancient Lichen in heroic
UPDATE `gameobject` SET `spawnmask`='2' WHERE `id` IN ('181278');

-- updates by robin regarding https://bitbucket.org/looking4group_b2tbc/looking4group/issues/1576/some-blacksmithing-crafts-cant-be
UPDATE `item_template` SET `RequiredDisenchantSkill`='25' WHERE `entry` IN ('2850','7956');
UPDATE `item_template` SET `RequiredDisenchantSkill`='1' WHERE `entry` IN ('2857');
UPDATE `item_template` SET `RequiredDisenchantSkill`='200' WHERE `entry` IN ('12554','12556','11669','22395');

-- adding http://de.wowhead.com/spell=23489/extrem-sicherer-transporter-gadgetzan#english-comments to npc trainer
INSERT INTO `npc_trainer` VALUES ('14743','23489','1050','202','260','0');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/608/schattenmondtal
--
-- ======================================================
-- Texts & Scripts
-- ======================================================
--
-- -9600 - -9699
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9600','-9601','-9602','-9603','-9604','-9605','-9606','-9607','-9608','-9609','-9610','-9611','-9612','-9613','-9614','-9615','-9616','-9617','-9618','-9619');
INSERT INTO `creature_ai_texts` VALUES
(-9600,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9601,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9602,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9603,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9604,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9605,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9606,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9607,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9608,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9609,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9610,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9611,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9612,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9613,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9614,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9615,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9616,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9617,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9618,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter'),
(-9619,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'SchattenmondtalPlatzhalter');
--
--
--
--
--
--
--
-- ======================================================
-- Spawns
-- ======================================================
--
--
--
--
-- ======================================================
-- NPC Research
-- ======================================================
--
-- Doomwalker 17711
-- 11-15K on tank during enrage without armor debuff
UPDATE `creature_template` SET `flags_extra`='4194305',`mindmg`='12500',`maxdmg`='17144' WHERE `entry` IN ('17711'); -- 5527 11298
--
-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================
-- 
-- ======================================================
-- Linking
-- ======================================================
--
--
-- ======================================================
-- Respawn
-- ======================================================
--
--
-- ======================================================
-- Gameobjects
-- ======================================================
--
--
-- ======================================================
-- Miscellaneous
-- ======================================================
--
--
--
--
--
--
-- Freie GUIDS SMV 84490 84609 84610 84611 84629 84630
--
--
--
--
--
--
--
UPDATE `creature` SET `spawntimesecs`='86400' WHERE `guid` IN ('1007','78222');
UPDATE `creature_template` SET `mechanic_immune_mask`='753866751' WHERE `entry` IN ('18696','18694'); -- rare elite immunities
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1869401','1869402','1869403');
INSERT INTO `creature_ai_scripts` VALUES
(1869401,18694,0,0,100,1,8500,8500,15000,15000,11,38932,0,2,0,0,0,0,0,0,0,0,'Collidus the Warp-Watcher - Cast Blink'),
(1869402,18694,0,0,100,1,3500,5500,10000,11000,11,36414,1,3,0,0,0,0,0,0,0,0,'Collidus the Warp-Watcher - Cast Focused Bursts'),
(1869403,18694,9,0,100,1,0,8,15000,16000,11,34322,0,3,0,0,0,0,0,0,0,0,'Collidus the Warp-Watcher - Cast Psychic Scream');
-- immolation aura, spell that works
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18696');
INSERT INTO `creature_template_addon` VALUES
(18696,0,0,0,0,4097,0,0,'39007 0 39007 1');
--
-- Summoned Infernal 22203 by Kraator
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('22203');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22203');
INSERT INTO `creature_ai_scripts` VALUES
(2220301,22203,1,0,100,6,5000,5000,0,0,41,0,0,0,0,0,0,0,0,0,0,0,'Infernal - Despawn after 5sec OOC');
--
-- Ghostrider of Karabor
UPDATE `creature_template`  SET `type_flags`='0',`unit_flags`='512' WHERE `entry` IN ('21784'); -- 2 0
--
-- Cleric of Karabor
UPDATE `creature_template`  SET `faction_A`='1822',`faction_H`='1822' WHERE `entry` IN ('21815');
--
UPDATE `creature_template_addon` SET `bytes0`='0',`auras`='37509 0 37497 0' WHERE `entry` IN ('21815'); -- 16843008 = 16777216 + 65536 + 256
-- 65536 macht unsichtbar? oder aktiviert deaktiviert auras? 2 mal zu addieren hebt wieder auf ka
DELETE FROM `creature_addon` WHERE `guid` IN (76348,76349,76351,76353,76355,76356,76358,76359,76360,76362,76363,76364,76365,76366,76368,76369,76371,76372,76373,76374,76376);
-- ab 76200 freie guid 76278 76290 weiter bei 76400
--
--
-- Leiche von Ar'tor, Son of Oronok sollte so in der luft schweben mit magical effect unso
UPDATE `creature` SET `curhealth`='0',`curmana`='0',`DeathState`='0',`position_x`='-3795.6413',`position_y`='2595.9692',`position_z`='90.1193',`orientation`='4.9644' WHERE `guid` IN ('84607');
DELETE FROM `creature_addon` WHERE `guid` IN ('84607');
INSERT INTO `creature_addon` VALUES
(84607,0,0,67584,7,4097,65,0,'');
--
-- Shadowmoon Zealot & Shadowmoon Harbinger Ghostrider of Karabor Vhel'kur MELEE ATTACKABLE
UPDATE `creature_template` SET `type_flags`='0' WHERE `entry` IN ('21788','21795','21784','21801');
--
-- Vhel'kur
UPDATE `creature` SET `position_x`='-5044.3710', `position_y`='360.8592', `position_z`='209.7891', `orientation`='3.9687' WHERE `id` IN ('21801');
UPDATE `creature_template` SET `Inhabittype`='5' WHERE `entry` IN ('21801');
--
UPDATE `creature_template_addon` SET `bytes0`='0',`auras`='37509 0 37497 0' WHERE `entry` IN ('21815','21784'); -- 16843008 = 16777216 + 65536 + 256
-- 65536 macht unsichtbar? oder aktiviert deaktiviert auras? 2 mal zu addieren hebt wieder auf ka
DELETE FROM `creature_addon` WHERE `guid` IN (76348,76349,76351,76353,76355,76356,76358,76359,76360,76362,76363,76364,76365,76366,76368,76369,76370,76371,76372,76373,76374,76376);
-- ab 76200 freie guid 76278 76290 weiter bei 76400
--
-- flying dummy
UPDATE `creature_template` SET `inhabittype`='5' WHERE `entry` IN ('22317');
-- fire dmg for Enraged Fire Spirit
UPDATE `creature_template` SET `dmgschool`='2' WHERE `entry` IN ('21061');

DELETE FROM `creature_formations` WHERE `memberguid` IN (76085,76084,76083,76082);
DELETE FROM `creature_formations` WHERE `leaderguid` IN (76085,76084,76083,76082);
INSERT INTO `creature_formations` VALUES
(76082,76082,60,360,2),
(76082,76083,5,0,2),
--
(76084,76084,60,360,2),
(76084,76085,5,0,2);
--
-- movement 76082 erweitern
SET @NPC := 76082;
SET @PATH := @NPC * 10;  
UPDATE `creature` SET `MovementType`='2' WHERE `guid` IN (76082);
UPDATE `creature` SET `MovementType`='0' WHERE `guid` IN (76083);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16777472,16777216,4097,0,0,'37509 0 37497 0');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-3125.6755','797.6018','-22.4501',0,1,0,0,0),
(@PATH,2,'-3147.0263','783.6260','-22.0322',0,1,0,0,0),
(@PATH,3,'-3206.2492','779.5981','-20.1981',0,1,0,0,0),
(@PATH,4,'-3258.0471','782.0344','-19.1112',0,1,0,0,0),
(@PATH,5,'-3299.8872','764.3292','-21.7981',0,1,0,0,0);

-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,0,0),
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,0,0),
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,0,0),
-- -- movement 76084 erweitern
SET @NPC := 76084;
SET @PATH := @NPC * 10;  
UPDATE `creature` SET `MovementType`='2' WHERE `guid` IN (76084);
UPDATE `creature` SET `MovementType`='0' WHERE `guid` IN (76085);
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16777472,16777216,4097,0,0,'37509 0 37497 0');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-3100.8750','847.5437','-21.1103',0,1,0,0,0),
(@PATH,2,'-3090.7971','864.1595','-20.3988',0,1,0,0,0),
(@PATH,3,'-3091.7426','937.6027','-16.6609',0,1,0,0,0); 

-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,0,0),
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,0,0),
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,0,0),
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,0,0),

--
--
--
--
--
-- totem elementals despawn on evade Issue #351
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('2170603','2142803','2170703','2170802');
INSERT INTO `creature_ai_scripts` VALUES
(2170603,21706,7,0,100,6,0,0,0,0,41,0,0,0,18,33554432,0,0,0,0,0,0,'Corrupted Fire Elemental - Despawn on Evade'),
(2142803,21428,7,0,100,6,0,0,0,0,41,0,0,0,18,33554432,0,0,0,0,0,0,'Corrupted Water Elemental - Despawn on Evade'),
(2170703,21707,7,0,100,6,0,0,0,0,41,0,0,0,18,33554432,0,0,0,0,0,0,'Corrupted Air Elemental - Despawn on Evade'),
(2170802,21708,7,0,100,6,0,0,0,0,41,0,0,0,18,33554432,0,0,0,0,0,0,'Corrupted Earth Elemental - Despawn on Evade');
-- Zorus the Judicator Speed
UPDATE `creature_template` SET `speed`='1.20' WHERE `entry` IN ('21774');
-- set idle
UPDATE `creature` SET `movementtype`='0' WHERE `guid` IN ('76071');
-- Mine der Todesschmiede
UPDATE `creature_template` SET `unit_flags`='4',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0' WHERE `entry` IN ('22315');
--
--
-- vilewing_chimeras waypoints 
DELETE FROM `creature` WHERE `creature`.`guid` = 84490;
DELETE FROM `creature` WHERE `creature`.`guid` = 84611;
DELETE FROM `creature` WHERE `creature`.`guid` = 84609;
DELETE FROM `creature` WHERE `creature`.`guid` = 84610;
DELETE FROM `creature` WHERE `creature`.`guid` = 84629;
DELETE FROM `creature` WHERE `creature`.`guid` = 84630;

UPDATE `creature` SET `position_x` = '-3642.4', `position_y` = '2282.84', `position_z` = '101.388', `MovementType` = '2' WHERE `creature`.`guid` = 84488; 
UPDATE `creature` SET `position_x` = '-3306.02', `position_y` = '2329.37', `position_z` = '83.5418', `MovementType` = '2' WHERE `creature`.`guid` = 84594; 
UPDATE `creature` SET `position_x` = '-3679.03', `position_y` = '1980.17', `position_z` = '95.4007', `MovementType` = '2' WHERE `creature`.`guid` = 84597; 
UPDATE `creature` SET `position_x` = '-3495.38', `position_y` = '2654.51', `position_z` = '85.1497', `MovementType` = '2' WHERE `creature`.`guid` = 84613; 
UPDATE `creature` SET `position_x` = '-3051.69', `position_y` = '1036.49', `position_z` = '18.4269', `MovementType` = '2' WHERE `creature`.`guid` = 84632; 

DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 84488;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 84594;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 84597;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 84613;
DELETE FROM `creature_addon` WHERE `creature_addon`.`guid` = 84632;

INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes0`, `bytes1`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES 
('84488', '844880', '0', '0', '0', '1', '0', '0', NULL), 
('84594', '845940', '0', '0', '0', '1', '0', '0', NULL), 
('84597', '845970', '0', '0', '0', '1', '0', '0', NULL), 
('84613', '846130', '0', '0', '0', '1', '0', '0', NULL), 
('84632', '846320', '0', '0', '0', '1', '0', '0', NULL); 

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 844880;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(844880, 1, -3669.03, 2270.02, 101.638, 0, 0, 0, 100, 0),
(844880, 2, -3678.18, 2255.65, 102.61, 0, 0, 0, 100, 0),
(844880, 3, -3670.33, 2221.35, 101.971, 0, 0, 0, 100, 0),
(844880, 4, -3643.31, 2194.72, 101.749, 0, 0, 0, 100, 0),
(844880, 5, -3616.06, 2171.17, 100.721, 0, 0, 0, 100, 0),
(844880, 6, -3592.53, 2149.25, 97.388, 0, 0, 0, 100, 0),
(844880, 7, -3565.21, 2111.29, 91.7213, 0, 0, 0, 100, 0),
(844880, 8, -3539.71, 2073.03, 90.7214, 0, 0, 0, 100, 0),
(844880, 9, -3525.45, 2044.54, 86.1101, 0, 0, 0, 100, 0),
(844880, 10, -3525.76, 2011.65, 86.4714, 0, 0, 0, 100, 0),
(844880, 11, -3542.68, 1995.36, 88.4713, 0, 0, 0, 100, 0),
(844880, 12, -3561.44, 2002.94, 85.0268, 0, 0, 0, 100, 0),
(844880, 13, -3575.93, 2019.75, 82.8878, 0, 0, 0, 100, 0),
(844880, 14, -3575.17, 2047.14, 81.3602, 0, 0, 0, 100, 0),
(844880, 15, -3573.45, 2072.32, 84.9157, 0, 0, 0, 100, 0),
(844880, 16, -3564.49, 2102.47, 90.3324, 0, 0, 0, 100, 0),
(844880, 17, -3536.42, 2134.58, 97.9435, 0, 0, 0, 100, 0),
(844880, 18, -3500.94, 2154.61, 104.332, 0, 0, 0, 100, 0),
(844880, 19, -3468.63, 2165.14, 101.999, 0, 0, 0, 100, 0),
(844880, 20, -3451.68, 2176.57, 102.971, 0, 0, 0, 100, 0),
(844880, 21, -3440.87, 2214.56, 102.499, 0, 0, 0, 100, 0),
(844880, 22, -3464.08, 2240.17, 96.1936, 0, 0, 0, 100, 0),
(844880, 23, -3503.83, 2238.95, 96.8879, 0, 0, 0, 100, 0),
(844880, 24, -3532.54, 2227.36, 98.5269, 0, 0, 0, 100, 0),
(844880, 25, -3557.9, 2223.09, 99.7491, 0, 0, 0, 100, 0),
(844880, 26, -3585.39, 2233.09, 100.499, 0, 0, 0, 100, 0),
(844880, 27, -3605.96, 2248.53, 99.888, 0, 0, 0, 100, 0),
(844880, 28, -3615.81, 2270.33, 99.7213, 0, 0, 0, 100, 0),
(844880, 29, -3642.4, 2282.84, 101.388, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 845940;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(845940, 1, -3306.58, 2358.01, 83.9584, 0, 0, 0, 100, 0),
(845940, 2, -3312.28, 2366.84, 84.1251, 0, 0, 0, 100, 0),
(845940, 3, -3339.58, 2384.22, 85.0139, 0, 0, 0, 100, 0),
(845940, 4, -3375.19, 2400.31, 84.7918, 0, 0, 0, 100, 0),
(845940, 5, -3413.53, 2413.8, 83.4028, 0, 0, 0, 100, 0),
(845940, 6, -3449.75, 2447.95, 84.5973, 0, 0, 0, 100, 0),
(845940, 7, -3484.88, 2475.86, 87.4863, 0, 0, 0, 100, 0),
(845940, 8, -3516.8, 2470.34, 88.6529, 0, 0, 0, 100, 0),
(845940, 9, -3551.3, 2449.09, 88.6529, 0, 0, 0, 100, 0),
(845940, 10, -3577.61, 2417.92, 88.6529, 0, 0, 0, 100, 0),
(845940, 11, -3587.22, 2394.96, 88.6529, 0, 0, 0, 100, 0),
(845940, 12, -3578.09, 2358.18, 91.0141, 0, 0, 0, 100, 0),
(845940, 13, -3542.67, 2341.77, 90.7363, 0, 0, 0, 100, 0),
(845940, 14, -3508.3, 2338.78, 88.6529, 0, 0, 0, 100, 0),
(845940, 15, -3480.53, 2321.33, 85.2084, 0, 0, 0, 100, 0),
(845940, 16, -3438.7, 2328.43, 84.014, 0, 0, 0, 100, 0),
(845940, 17, -3402.31, 2319.82, 84.0696, 0, 0, 0, 100, 0),
(845940, 18, -3367.93, 2320.2, 83.4028, 0, 0, 0, 100, 0),
(845940, 19, -3336.19, 2315.69, 83.7084, 0, 0, 0, 100, 0),
(845940, 20, -3306.02, 2329.37, 83.5418, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 845970;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(845970, 1, -3694.72, 1971.45, 97.0395, 0, 0, 0, 100, 0),
(845970, 2, -3698.6, 1961.44, 97.5118, 0, 0, 0, 100, 0),
(845970, 3, -3703.09, 1932.74, 93.0952, 0, 0, 0, 100, 0),
(845970, 4, -3710.8, 1898.88, 95.0673, 0, 0, 0, 100, 0),
(845970, 5, -3706.17, 1855.21, 94.6507, 0, 0, 0, 100, 0),
(845970, 6, -3730.44, 1822.59, 97.1506, 0, 0, 0, 100, 0),
(845970, 7, -3764.35, 1786.2, 103.54, 0, 0, 0, 100, 0),
(845970, 8, -3806.22, 1765.62, 104.623, 0, 0, 0, 100, 0),
(845970, 9, -3831.6, 1734.27, 106.484, 0, 0, 0, 100, 0),
(845970, 10, -3845.84, 1700.6, 104.79, 0, 0, 0, 100, 0),
(845970, 11, -3860.27, 1667.3, 102.984, 0, 0, 0, 100, 0),
(845970, 12, -3878.3, 1634.77, 97.234, 0, 0, 0, 100, 0),
(845970, 13, -3905.48, 1624.4, 96.4007, 0, 0, 0, 100, 0),
(845970, 14, -3934.36, 1629.9, 95.7895, 0, 0, 0, 100, 0),
(845970, 15, -3941.39, 1653.26, 102.401, 0, 0, 0, 100, 0),
(845970, 16, -3933.62, 1681.02, 107.54, 0, 0, 0, 100, 0),
(845970, 17, -3911.21, 1703.6, 110.734, 0, 0, 0, 100, 0),
(845970, 18, -3870.42, 1717.62, 111.429, 0, 0, 0, 100, 0),
(845970, 19, -3851.41, 1733.49, 109.762, 0, 0, 0, 100, 0),
(845970, 20, -3832.47, 1767.41, 108.484, 0, 0, 0, 100, 0),
(845970, 21, -3821.69, 1801.01, 106.762, 0, 0, 0, 100, 0),
(845970, 22, -3804.74, 1833.07, 104.317, 0, 0, 0, 100, 0),
(845970, 23, -3771.97, 1852.2, 103.067, 0, 0, 0, 100, 0),
(845970, 24, -3733.2, 1857.56, 99.8175, 0, 0, 0, 100, 0),
(845970, 25, -3700.39, 1874.68, 91.9285, 0, 0, 0, 100, 0),
(845970, 26, -3669.67, 1899.9, 86.984, 0, 0, 0, 100, 0),
(845970, 27, -3657.47, 1933.84, 83.7894, 0, 0, 0, 100, 0),
(845970, 28, -3665.44, 1967.77, 90.2617, 0, 0, 0, 100, 0),
(845970, 29, -3679.03, 1980.17, 95.4007, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 846130;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(846130, 1, -3513.77, 2667.21, 85.8719, 0, 0, 0, 100, 0),
(846130, 2, -3527.99, 2668.34, 87.3996, 0, 0, 0, 100, 0),
(846130, 3, -3568.94, 2660.98, 87.3718, 0, 0, 0, 100, 0),
(846130, 4, -3605.73, 2631.42, 89.0941, 0, 0, 0, 100, 0),
(846130, 5, -3606.99, 2590.2, 89.0108, 0, 0, 0, 100, 0),
(846130, 6, -3624.85, 2552.97, 89.8441, 0, 0, 0, 100, 0),
(846130, 7, -3632.88, 2523.19, 90.7886, 0, 0, 0, 100, 0),
(846130, 8, -3623.27, 2498.77, 93.4275, 0, 0, 0, 100, 0),
(846130, 9, -3594.59, 2497.11, 91.8164, 0, 0, 0, 100, 0),
(846130, 10, -3571.22, 2522.08, 89.7608, 0, 0, 0, 100, 0),
(846130, 11, -3555.3, 2550.05, 88.2052, 0, 0, 0, 100, 0),
(846130, 12, -3546.01, 2576.07, 86.6774, 0, 0, 0, 100, 0),
(846130, 13, -3533.12, 2604.75, 86.5941, 0, 0, 0, 100, 0),
(846130, 14, -3505.66, 2622.68, 86.0384, 0, 0, 0, 100, 0),
(846130, 15, -3495.38, 2654.51, 85.1497, 0, 0, 0, 100, 0);

DELETE FROM `waypoint_data` WHERE `waypoint_data`.`id` = 846320;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(846320, 1, -3078.82, 1034.04, 19.2881, 0, 0, 0, 100, 0),
(846320, 2, -3088.5, 1066.14, 25.0936, 0, 0, 0, 100, 0),
(846320, 3, -3087.41, 1099.35, 30.8436, 0, 0, 0, 100, 0),
(846320, 4, -3067.32, 1113.82, 27.6213, 0, 0, 0, 100, 0),
(846320, 5, -3035.01, 1131.8, 22.4825, 0, 0, 0, 100, 0),
(846320, 6, -3022.37, 1165.86, 21.288, 0, 0, 0, 100, 0),
(846320, 7, -3028.65, 1200.96, 24.2047, 0, 0, 0, 100, 0),
(846320, 8, -3053.87, 1219.14, 31.1214, 0, 0, 0, 100, 0),
(846320, 9, -3098.91, 1230.56, 38.8714, 0, 0, 0, 100, 0),
(846320, 10, -3120.39, 1233.38, 42.4825, 0, 0, 0, 100, 0),
(846320, 11, -3155.85, 1240.66, 47.0381, 0, 0, 0, 100, 0),
(846320, 12, -3184.49, 1256.95, 49.177, 0, 0, 0, 100, 0),
(846320, 13, -3200.05, 1273.89, 49.177, 0, 0, 0, 100, 0),
(846320, 14, -3198.47, 1300.31, 47.5659, 0, 0, 0, 100, 0),
(846320, 15, -3180.19, 1312.81, 46.5103, 0, 0, 0, 100, 0),
(846320, 16, -3166.77, 1318.92, 44.5658, 0, 0, 0, 100, 0),
(846320, 17, -3133.76, 1306.83, 33.8992, 0, 0, 0, 100, 0),
(846320, 18, -3107.96, 1267.03, 29.7603, 0, 0, 0, 100, 0),
(846320, 19, -3102.76, 1234.92, 31.5659, 0, 0, 0, 100, 0),
(846320, 20, -3081.74, 1200.23, 34.7603, 0, 0, 0, 100, 0),
(846320, 21, -3064.9, 1171.27, 31.5936, 0, 0, 0, 100, 0),
(846320, 22, -3032.82, 1161.91, 24.9269, 0, 0, 0, 100, 0),
(846320, 23, -2998.29, 1162.48, 17.288, 0, 0, 0, 100, 0),
(846320, 24, -2989.17, 1125.52, 23.2603, 0, 0, 0, 100, 0),
(846320, 25, -3019.7, 1108.53, 28.3714, 0, 0, 0, 100, 0),
(846320, 26, -3030.19, 1069.28, 24.0659, 0, 0, 0, 100, 0),
(846320, 27, -3051.69, 1036.49, 18.4269, 0, 0, 0, 100, 0);

SET @NPC := 84604;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,1,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'-3599.6838','2076.1064','92.5506',0,0,0,100,0),
(@PATH,2,'-3669.1286','2090.3444','102.6834',0,0,0,100,0),
(@PATH,3,'-3730.5886','2072.4396','103.1668',0,0,0,100,0),
(@PATH,4,'-3738.8093','2000.7200','107.0229',0,0,0,100,0),
(@PATH,5,'-3825.2058','1880.9262','119.2841',0,0,0,100,0),
(@PATH,6,'-3767.8276','1824.7760','106.1014',0,0,0,100,0),
(@PATH,7,'-3706.9865','1851.2696','96.2108',0,0,0,100,0),
(@PATH,8,'-3663.1618','1934.2031','87.0559',0,0,0,100,0),
(@PATH,9,'-3599.0512','1955.2877','80.2601',0,0,0,100,0),
(@PATH,10,'-3574.9699','2053.8500','81.8910',0,0,0,100,0);
--
-- Prince Malchezaar
UPDATE `creature_template` SET `mindmg`='5310',`maxdmg`='7509',`baseattacktime`='2000',`mechanic_immune_mask`='650854239' WHERE `entry` IN ('15690'); -- 6638 - 9386
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16545');
INSERT INTO `creature_ai_scripts` VALUES
('1654501','16545','11','0','100','2','0','0','0','0','11','30007','0','1','0','0','0','0','0','0','0','0','Ethereal Spellfilcher - Cast Spatial Distortion on Spawn'),
('1654502','16545','9','0','100','3','0','30','7000','9000','11','37161','0','0','0','0','0','0','0','0','0','0','Ethereal Spellfilcher - Cast Arcane Volley'),
('1654503','16545','0','0','100','3','4000','8000','10000','18000','11','30039','1','33','0','0','0','0','0','0','0','0','Ethereal Spellfilcher - Cast Transference'),
('1654504','16545','0','0','100','3','7000','9000','8000','15000','11','30036','4','1','0','0','0','0','0','0','0','0','Ethereal Spellfilcher - Cast Steal Magic');
