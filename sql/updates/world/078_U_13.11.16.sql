-- Blade's Edge Arena Start Orientation
UPDATE `battleground_template` SET `AllianceStartO` = 4.0551, `HordeStartO` = 0.8703 WHERE `id` = 5;

-- Arcane Anomaly 16488
-- some sources say immune to all magic
UPDATE `creature` SET `spawntimesecs` = 3600 WHERE `id` = 16488;
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

-- Shattered Rumbler mob_shattered_rumbler
UPDATE `creature_template` SET `ScriptName` = NULL, `AIName` = 'EventAI', `resistance3` = -1 WHERE `entry` = 17157;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17157;
INSERT INTO `creature_ai_scripts` VALUES
('1715701','17157','0','0','100','1','7000','14000','14000','21000','11','33840','0','0','0','0','0','0','0','0','0','0','Shattered Rumbler - Cast Earth Rumble'),
('1715702','17157','8','0','100','0','32001','-1','0','0','12','18181','1','300','12','18181','1','300','12','18181','1','300','Shattered Rumbler - Summon 3 Minion of Gurok on Spellhit: Throw Gordawg''s Boulder'),
('1715703','17157','8','0','100','0','32001','-1','0','0','37','0','0','0','0','0','0','0','0','0','0','0','Shattered Rumbler - Die on Spellhit: Throw Gordawg''s Boulder');

SET @GUID := 140137;
SET @POINT := 0;
UPDATE `creature` SET `position_x`='-161.630005', `position_y`='964.481018', `position_z`='54.2989', `MovementType`='2' WHERE `guid` = @GUID;   
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -177.693893, 1011.964844, 54.2894,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -187.083023, 1020.650879, 54.2643,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -220.110153, 1032.145386, 54.3258,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -236.153015, 1074.382080, 54.3067,0,1,1375,100,0),
(@GUID,@POINT := @POINT + 1, -234.447998, 1097.599976, 41.7915,600000,0,2285701,100,0);

SET @GUID := 140125;
SET @POINT := 0;
UPDATE `creature` SET `position_x`='-337.196014', `position_y`='961.669006', `position_z`='54.2979', `MovementType`='2' WHERE `guid` = @GUID;    
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,66048,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, -321.404114, 1009.786682, 54.2896,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -312.622986, 1018.638977, 54.2642,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -279.923157, 1031.153564, 54.3265,0,1,0,100,0),
(@GUID,@POINT := @POINT + 1, -264.772156, 1073.969727, 54.3070,0,1,1333,100,0),
(@GUID,@POINT := @POINT + 1, -266.312012, 1099.079956, 41.7915,600000,0,2285701,100,0);

DELETE FROM `waypoint_scripts` WHERE `id` IN (1333, 1375);
INSERT INTO `waypoint_scripts` VALUES
(1333, 0, 2, 169, 333, 0, 0, 0, 0, 0, 1333, 'STATE_READY1H'),
(1375, 0, 2, 169, 375, 0, 0, 0, 0, 0, 1375, 'STATE_READY2H');

DELETE FROM `creature_addon` WHERE `guid` IN (140119, 140126);
INSERT INTO `creature_addon` VALUES
(140126, 0, 0, 66048, 0, 4097, 0, 0, NULL),
(140119, 0, 0, 16843008, 0, 4097, 0, 0, NULL);

-- Event Permanant Stuff, S1 Vendor Keys Rep etc.
DELETE FROM `creature` WHERE `guid` BETWEEN 9999956 AND 10000000;
SET @GUID := 9999956;
DELETE FROM `creature` WHERE `guid` BETWEEN @GUID AND @GUID+100;

-- =================
-- Real Vendor Spawns
-- ================= ATTENTION 20278 costum atm
INSERT INTO `creature` VALUES (@GUID := @GUID + 0, 20278, 1, 1, 0, 0, -7120.38, -3774.1, 8.92485, 0.64873, 300, 0, 0, 6300, 0, 0, 0); -- 20278
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200061, 1, 1, 0, 0, -7118.7109, -3776.7121, 8.7466, 0.3197, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 530, 1, 0, 0, 3067.31, 3635.82, 143.781, 0.872758, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200061, 530, 1, 0, 0, 3070.1987, 3632.4182, 143.7810, 1.2072, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 450, 1, 0, 0, 261.833, 81.6485, 25.7204, 3.0366, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200061, 450, 1, 0, 0, 262.3464, 86.1316, 25.7198, 3.2060, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 449, 1, 0, 0, 4.14647, 18.6761, 1.05706, 1.59124, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200061, 449, 1, 0, 0, 8.3817, 21.1129, 1.0558, 3.1393, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 530, 1, 0, 0, -1966.84, 5168.63, -38.2516, 0.434276, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200061, 530, 1, 0, 0, -1968.5640, 5172.0336, -38.2717, 0.4689, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 530, 1, 0, 0, 2885.7, 5983.29, 3.156, 1.2639, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200061, 530, 1, 0, 0, 2890.4035, 5981.6450, 2.8027, 0.9166, 300, 0, 0, 6300, 0, 0, 0); 
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 530, 1, 0, 0, -2161.66, 6658.46, -0.175319, 5.96662, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200061, 530, 1, 0, 0, -2163.7885, 6653.3735, -0.2625, 5.96662, 300, 0, 0, 6300, 0, 0, 0);
-- Offparts Vendors
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200059,450,1,0,0,250.256,101.317,25.7211,4.3434,300,0,0,32400,0,0,0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200060,449,1,0,0,-7.23101,35.5028,1.05583,4.72225,300,0,0,7048,0,0,0);
-- AV Mark Trader
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200007,450,1,0,0,235.7808,101.0694,25.7211,5.1641,300,0,0,32400,0,0,0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200007,449,1,0,0,-0.6561,36.4941,1.05583,4.6986,300,0,0,11000,0,0,0);

-- The changed S1 Vendor will be released until Season 3 hits, to keep arena and overall pvp an competetive and open experience for all/new joining pvp players.

-- S1 Vendor
-- Arena Points without Rating (Value)
-- 600(2374)
-- 650(2357)
-- 675(2343)
-- 800(2388)
-- 900(2387)
-- 1000(1758)
-- 1125(2283)
-- 1500(2288)
-- 1630(22)
-- 1875(2285)

DELETE FROM `npc_vendor` WHERE `entry` = 20278;
-- 2H Weapon
INSERT INTO `npc_vendor` VALUES (20278, 24550, 0, 0, 2285); -- 2285 -- 2237
INSERT INTO `npc_vendor` VALUES (20278, 24557, 0, 0, 2285);
INSERT INTO `npc_vendor` VALUES (20278, 28294, 0, 0, 2285);
INSERT INTO `npc_vendor` VALUES (20278, 28298, 0, 0, 2285);
INSERT INTO `npc_vendor` VALUES (20278, 28299, 0, 0, 2285);
INSERT INTO `npc_vendor` VALUES (20278, 28300, 0, 0, 2285);
INSERT INTO `npc_vendor` VALUES (20278, 28476, 0, 0, 2285);
-- 1H Caster
INSERT INTO `npc_vendor` VALUES (20278, 28297, 0, 0, 2283); -- 2283 -- 2238
INSERT INTO `npc_vendor` VALUES (20278, 32450, 0, 0, 2283);
INSERT INTO `npc_vendor` VALUES (20278, 32451, 0, 0, 2283);
-- 1H Melee
INSERT INTO `npc_vendor` VALUES (20278, 28295, 0, 0, 2283); -- 2283 -- 2239
INSERT INTO `npc_vendor` VALUES (20278, 28305, 0, 0, 2283);
INSERT INTO `npc_vendor` VALUES (20278, 28308, 0, 0, 2283);
INSERT INTO `npc_vendor` VALUES (20278, 28312, 0, 0, 2283);
INSERT INTO `npc_vendor` VALUES (20278, 28313, 0, 0, 2283);
-- Offhand
INSERT INTO `npc_vendor` VALUES (20278, 28302, 0, 0, 2343); -- 2343 -- 2240
INSERT INTO `npc_vendor` VALUES (20278, 28307, 0, 0, 2343);
INSERT INTO `npc_vendor` VALUES (20278, 28309, 0, 0, 2343);
INSERT INTO `npc_vendor` VALUES (20278, 28310, 0, 0, 2343);
INSERT INTO `npc_vendor` VALUES (20278, 28314, 0, 0, 2343);
INSERT INTO `npc_vendor` VALUES (20278, 28346, 0, 0, 2343);
INSERT INTO `npc_vendor` VALUES (20278, 32452, 0, 0, 2343);
-- Thrown/Wand/Idol/Libram/Totem
INSERT INTO `npc_vendor` VALUES (20278, 28319, 0, 0, 2374); -- 2374 -- 2241
INSERT INTO `npc_vendor` VALUES (20278, 28320, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 28355, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 28356, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 28357, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 33936, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 33939, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 33942, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 33945, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 33948, 0, 0, 2374);
INSERT INTO `npc_vendor` VALUES (20278, 33951, 0, 0, 2374);
--
-- Shield
INSERT INTO `npc_vendor` VALUES (20278, 28358, 0, 0, 2374); -- 2374 -- 2242
-- Gauntlets
INSERT INTO `npc_vendor` VALUES (20278, 24549, 0, 0, 2254); -- 2254 -- 2277(2255 eots marks)
INSERT INTO `npc_vendor` VALUES (20278, 24556, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 25834, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 25857, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 26000, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 27470, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 27703, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 27707, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 27880, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 28126, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 28136, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 28335, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 30188, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 31375, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 31397, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 31409, 0, 0, 2254);
INSERT INTO `npc_vendor` VALUES (20278, 31614, 0, 0, 2254);
-- Shoulders
INSERT INTO `npc_vendor` VALUES (20278, 24546, 0, 0, 2373); -- 2373 -- 2278
INSERT INTO `npc_vendor` VALUES (20278, 24554, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 25832, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 25854, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 25999, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 27473, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 27706, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 27710, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 27883, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 28129, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 28139, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 28333, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 30186, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 31378, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 31407, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 31412, 0, 0, 2373);
INSERT INTO `npc_vendor` VALUES (20278, 31619, 0, 0, 2373);
-- Chest
INSERT INTO `npc_vendor` VALUES (20278, 24544, 0, 0, 2258); -- 2258 -- 2279
INSERT INTO `npc_vendor` VALUES (20278, 24552, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 25831, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 25856, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 25997, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 27469, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 27702, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 27711, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 27879, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 28130, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 28140, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 28334, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 30200, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 31379, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 31396, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 31413, 0, 0, 2258);
INSERT INTO `npc_vendor` VALUES (20278, 31613, 0, 0, 2258);
-- Helmet
INSERT INTO `npc_vendor` VALUES (20278, 24545, 0, 0, 2262); -- 2262 -- 2280 
INSERT INTO `npc_vendor` VALUES (20278, 24553, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 25830, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 25855, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 25998, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 27471, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 27704, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 27708, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 27881, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 28127, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 28137, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 28331, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 30187, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 31376, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 31400, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 31410, 0, 0, 2262);
INSERT INTO `npc_vendor` VALUES (20278, 31616, 0, 0, 2262);
-- Legs
INSERT INTO `npc_vendor` VALUES (20278, 24547, 0, 0, 2264); -- 2264 -- 2281
INSERT INTO `npc_vendor` VALUES (20278, 24555, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 25833, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 25858, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 26001, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 27472, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 27705, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 27709, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 27882, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 28128, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 28138, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 28332, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 30201, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 31377, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 31406, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 31411, 0, 0, 2264);
INSERT INTO `npc_vendor` VALUES (20278, 31618, 0, 0, 2264);

-- HC Keys at honored 
UPDATE item_template SET RequiredReputationRank = 5 WHERE entry IN (30634, 30623, 30622, 30637, 30635, 30633);

-- Level 60 Instant Event NPC
UPDATE `creature_template` SET `name` = 'Level 60',`minlevel` = '60',`maxlevel` = '60' WHERE `entry` = 1000001;

-- Requested I 70 NPC
SET @GUID := 1688648; 
DELETE FROM creature WHERE guid = @GUID;
INSERT INTO creature VALUES (@GUID, 1000003, 29, 1, 0, 0, 16.3467, 7.4524, -144.7086, 3.1423, 25, 0, 0, 100000, 0, 0, 0);

-- OHF Patrols Nerfed Respawntime
UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` IN (17840,22128);

-- Eye of Veil Reskk & Eye of Veil Shienor
DELETE FROM `gameobject` WHERE `guid` IN ('27550','27551');
UPDATE `gameobject_template` SET `data3`='1' WHERE `entry` IN ('185200','185201');
UPDATE `gameobject` SET `animprogress`='100' WHERE `id` IN ('185200','185201');

-- Empoor's Bodyguard 18483
UPDATE `creature_template` SET `faction_H`='35',`faction_A`='35',`flags_extra`=`flags_extra`|2 WHERE `entry` IN ('18483'); -- 7

-- Urdak Movement
UPDATE `creature_ai_scripts` SET `action1_param1`='1' WHERE `id` IN (1854101,1854107);

-- Children Quest
UPDATE `creature` SET `spawntimesecs` = 180 WHERE `id` = 22314;
