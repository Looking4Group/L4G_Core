DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '19947';
INSERT INTO `creature_ai_scripts` VALUES
('1994701','19947','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Prevent Combat Movement on Spawn'),
('1994702','19947','1','0','100','1','1000','1000','1800000','1800000','11','12544','0','1','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Frost Armor on Spawn'),
('1994703','19947','4','0','100','0','0','0','0','0','11','13901','1','0','23','1','0','0','0','0','0','0','Darkcrest Sorceress - Cast Arcane Bolt and Set Phase 1 on Aggro'),
('1994704','19947','9','13','100','1','0','40','2500','3000','11','13901','1','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Arcane Bolt (Phase 1)'),
('1994705','19947','3','13','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Darkcrest Sorceress - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1994706','19947','9','13','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Start Combat Movement at 35 Yards (Phase 1)'),
('1994707','19947','9','13','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1994708','19947','9','13','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Start Combat Movement Below 5 Yards'),
('1994709','19947','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Set Phase 1 when Mana is above 30% (Phase 2)'),
-- ('1994710','19947','0','0','100','1','10000','15000','20000','25000','11','34787','1','1','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Freezing Circle'),
('1994711','19947','27','0','100','1','12544','1','15000','30000','11','12544','0','1','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Frost Armor on Missing Buff'),
('1994712','19947','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Set Phase 3 at 15% HP'),
('1994713','19947','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Darkcrest Sorceress - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1994714','19947','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Set Phase to 0 on Evade'),
('1994715','19947','0','0','100','7','10000','10000','10000','10000','11','12544','0','33','0','0','0','0','0','0','0','0','Darkcrest Sorceress - Cast Ice Barrier on Missing Ice Barrier Aura');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = '18044';
INSERT INTO `creature_ai_scripts` VALUES
('1804401','18044','1','0','100','0','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Prevent Combat Movement on Spawn'),
('1804402','18044','4','0','100','0','0','0','0','0','11','15043','1','0','23','1','0','0','0','0','0','0','Rajis Fyashe - Cast Frostbolt and Set Phase 1 on Aggro'),
('1804403','18044','9','13','100','1','0','40','3000','3800','11','15043','1','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Cast Frostbolt (Phase 1)'),
('1804404','18044','3','13','100','0','15','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Rajis Fyashe - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)'),
('1804405','18044','9','13','100','0','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Start Combat Movement at 35 Yards (Phase 1)'),
('1804406','18044','9','13','100','0','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1804407','18044','9','13','100','0','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Start Combat Movement Below 5 Yards'),
('1804408','18044','3','11','100','1','100','30','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Set Phase 1 when Mana is above 30% (Phase 2)'),
('1804409','18044','0','0','100','0','6000','9000','0','0','11','35594','0','1','0','0','0','0','0','0','0','0','Rajis Fyashe - Cast Mass Elementals'),
('1804410','18044','0','0','100','1','8000','9000','8000','12000','11','35499','1','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Cast Water Spout'),
-- ('1804411','18044','0','0','100','1','18000','24000','18000','24000','11','34787','1','1','0','0','0','0','0','0','0','0','Rajis Fyashe - Cast Freezing Circle'),
('1804412','18044','2','0','100','0','15','0','0','0','22','3','0','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Set Phase 3 at 15% HP'),
('1804413','18044','2','7','100','0','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Rajis Fyashe - Start Combat Movement and Flee at 15% HP (Phase 3)'),
('1804414','18044','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Rajis Fyashe - Set Phase to 0 on Evade');

-- Toshley Flying Machine 22089
UPDATE `creature_template` SET `InhabitType`='7' WHERE `entry` = '22089';

-- Shattered Hand Champion 17671 20584
UPDATE `creature_template` SET `equipment_id`='8019',`mechanic_immune_mask`='346100947',`mindmg`='1337',`maxdmg`='1762' WHERE `entry` IN (17671); -- Schwert und Schild orange 509 1040 -- 1,671 - 2,202
UPDATE `creature_template` SET `equipment_id`='8019',`mechanic_immune_mask`='346100947',`mindmg`='4673',`maxdmg`='4973' WHERE `entry` IN (20584); -- Schwert und Schild orange 2112 2712 -- 4673 4973 -- 9,346 - 9,946

-- Warchief Kargath Bladefist 16808,20597
-- 2 guids 3666851 5274944 npc flag 2 ? y
UPDATE  `creature` SET `spawnmask`='3',`spawntimesecs`='43200' WHERE `guid` IN ('5274944');
UPDATE `creature_template` SET `mindmg`='1446',`maxdmg`='1906',`baseattacktime`='1000' WHERE `entry` IN ('16808'); -- 550 1125 1464 -- 1,807 - 2,382
UPDATE `creature_template` SET `mindmg`='3060',`maxdmg`='3223',`pickpocketloot`='16808',`baseattacktime`='0' WHERE `entry` IN (20597); -- 7141 7521 -- 6121 6446 -- 10,711 - 11,281

UPDATE `creature` SET `position_x`='294.0052', `position_y`='-84.4953', `position_z`='1.9203', `orientation`='3.1313',`spawndist`='5',`movementtype`='1',`spawntimesecs`='60' WHERE `guid` = '112008';
UPDATE `creature` SET `position_x`='319.6404', `position_y`='-84.4010', `position_z`='1.9295', `orientation`='3.1195',`spawndist`='5',`movementtype`='1',`spawntimesecs`='150' WHERE `guid` = '111481';

-- respawn sewerage
UPDATE `creature` SET `spawntimesecs`='90' WHERE `guid` IN (90805,91716,91731,91744,90996);

-- respawn gauntlet
UPDATE `creature` SET `spawntimesecs`='180' WHERE `guid` IN (117515,117489,117436,117466);
UPDATE `creature` SET `spawntimesecs`='180' WHERE `guid` IN (62926,62927,62932,107964);

DELETE FROM `creature` WHERE `guid` IN (3666851,99996,99997,99998,99979,99965,99964,99963,99962,99961,99960,99959,99958,99957,99956,99955,99954,99953,99951,99950,99949,99948,99947,99946,99945,99944,99943,99942,99941,99940,99939);
INSERT INTO `creature` (`guid`,`id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(99996,17462,540,3,77.3463,264.6607,-13.2028,4.0404,7200,0,0),
(99997,17462,540,3,68.6459,271.7706,-13.2043,4.0404,7200,0,0),
(99998,17420,540,3,43.2567,254.2895,-10.9824,1.6006,7200,0,0),
(99979,17462,540,3,379.6138,310.3692,1.9438,3.1254,180,0,0),
(99965,17462,540,3,379.8101,322.5056,1.9440,3.1254,180,0,0),
(99964,17462,540,3,401.9723,323.2708,1.9082,3.1254,180,0,0),
(99963,17462,540,3,402.7467,310.5365,1.9020,3.1254,180,0,0),
(99962,17462,540,3,427.0512,308.9408,1.9322,3.1254,180,0,0),
(99961,17462,540,3,427.2383,320.5103,1.9322,3.1254,180,0,0),
(99960,17462,540,3,458.3092,322.9482,1.9467,3.1254,180,0,0),
(99959,17462,540,3,458.0854,309.1110,1.9467,3.1254,180,0,0),
(99958,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99957,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99956,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99955,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99954,17695,540,3,315.9148,58.2639,1.0244,6.2479,7200,5,1),
(99953,17695,540,3,138.6280,-84.2911,1.9078,6.2700,7200,5,1),
-- 99952 maggi
(99951,17695,540,3,522.0420,103.0975,1.9230,6.2700,7200,5,1),
(99950,17695,540,3,513.5316,101.9586,1.9230,6.2700,7200,5,1),
(99949,17695,540,3,274.4971,317.3325,-0.3597,6.2700,7200,5,1),
(99948,17695,540,3,535.7389,294.3880,1.9401,6.2700,7200,5,1),
(99947,17695,540,3,467.4152,57.9210,1.9360,0.0064,7200,5,1),
(99946,17695,540,3,531.5406,333.6080,2.1095,3.9334,7200,5,1),
(99945,17695,540,3,427.2488,57.6792,2.0958,0.0103,7200,5,1),
(99944,17695,540,3,330.8828,296.9179,1.9263,1.4672,7200,5,1),
(99943,17695,540,3,320.0052,328.7619,1.9297,4.4950,7200,5,1),
(99942,17695,540,3,297.2097,316.2634,1.9170,3.1127,7200,5,1),
(99941,17695,540,3,257.4549,307.2904,-5.4710,4.4046,7200,5,1),
(99940,17695,540,3,517.8952,202.3979,1.9305,1.5851,7200,5,1),
(99939,17695,540,3,518.4773,173.6161,1.9417,1.6165,7200,5,1);

UPDATE `creature` SET `spawndist`='0',`movementtype`='0' WHERE `guid` = '73897';

-- new world krautz
-- Ragveil 183043 181275
-- Felweed 183044 181270
-- Dreaming Glory 183045 181271 181272
-- Blindweed (142143 old world only) 183046(tbc)
-- Flame Cap 181276
-- Terocone 181277
-- Ancient Lichen 181278 (only dungeons)
-- Netherbloom 181279(netherstorm)181282(dungeons)
-- Nightmare Vine 181280 181285
-- Mana Thistle 181281 181284(flightmount)
-- Nethercite Deposit 185877
-- Netherdust Bush 185881
-- Netherwing Egg 185915 + Netherwing Egg Trap 185600
-- SELECT * FROM `gameobject` WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881,185915,185600) AND `map`=530;
UPDATE `gameobject` SET `spawntimesecs`=1800,`animprogress`=100 WHERE `id` IN (183043,183044,183045,183046,181270,181271,181272,181275,181276,181277,181278,181279,181280,181281,181282,181284,181285,185877,185881,185915,185600) AND `map`=530; -- 2700
