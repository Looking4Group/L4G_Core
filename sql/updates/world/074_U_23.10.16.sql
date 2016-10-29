-- Same Quepop for WSG Arathi and EOTS
UPDATE `battleground_template` SET `MinPlayersPerTeam` = 6 WHERE `id` IN (2,3,7);

-- shoulder pads 2.00k r 1500p -> 1435
-- the 2.05k to 2.2k grind is worth 2 weeks of points minimum
-- DELETE FROM `npc_vendor` WHERE `entry` = 1200061 AND `item` IN (30490,31964,31971,31976,31979,31990,31996,32001,32008,32013,32018,32024,32033,32037,32043,32047,32059);
-- INSERT INTO `npc_vendor` VALUES
-- (1200061,30490,0,0,1435), --  2359
-- (1200061,31964,0,0,1435),(1200061,31971,0,0,1435),(1200061,31976,0,0,1435),(1200061,31979,0,0,1435),(1200061,31990,0,0,1435),(1200061,31996,0,0,1435),(1200061,32001,0,0,1435),(1200061,32008,0,0,1435),
-- (1200061,32013,0,0,1435),(1200061,32018,0,0,1435),(1200061,32024,0,0,1435),(1200061,32033,0,0,1435),(1200061,32037,0,0,1435),(1200061,32043,0,0,1435),(1200061,32047,0,0,1435),(1200061,32059,0,0,1435);

DELETE FROM `creature` WHERE `guid` IN (16800046,16800048,16800056,16800106,16800123,16800126,16800127,16800135,16800136,16800923,16800924,16800716,16800707,16800705,16800706);
DELETE FROM `creature` WHERE `guid` IN (26973,44253,40444,73662,86179,88482,93958,93959,93960,132569,245629);

INSERT INTO `creature` VALUES (26973, 5643, 1, 1, 3790, 0, -419.61, 1850.15, 128.492, 1.20428, 300, 0, 0, 1208, 1097, 0, 0);

INSERT INTO `creature` VALUES (44253, 27666, 530, 1, 0, 1293, -1829.72, 5500.5, -12.4278, 3.8107, 25, 0, 0, 6600, 0, 0, 0);

INSERT INTO `creature` VALUES (40444, 27667, 530, 1, 0, 429, -1848.02, 5506.64, -12.4278, 4.97954, 300, 0, 0, 4500, 0, 0, 0);

INSERT INTO `creature` VALUES (73662, 20921, 530, 1, 0, 0, 3373.58, 2892.23, 144.049, 4.32842, 300, 0, 0, 5000, 3080, 0, 0);

INSERT INTO `creature` VALUES (86179, 26124, 0, 1, 0, 0, 1806.27, 220.163, 60.3925, 1.43117, 300, 0, 0, 1, 0, 0, 0);

INSERT INTO `creature` VALUES (88482, 15930, 533, 1, 0, 0, 3508.85, -2994.08, 312.18, 2.33, 6380, 0, 0, 499650, 0, 0, 0);
DELETE FROM `creature_linked_respawn` WHERE `guid` = 88482;
INSERT INTO `creature_linked_respawn` VALUES
(88482,88480);

INSERT INTO `creature` VALUES (93958, 26092, 530, 0, 0, 0, 12687, -6942.73, 36.2523, 4.49695, 600, 0, 0, 2500, 7196, 0, 0);
INSERT INTO `creature` VALUES (93959, 26091, 530, 0, 0, 0, 12678.7, -6972.44, 36.2525, 1.9392, 600, 0, 0, 8400, 7196, 0, 0);
INSERT INTO `creature` VALUES (93960, 26089, 530, 0, 0, 0, 12686.7, -6972.61, 36.2519, 1.84288, 600, 0, 0, 6000, 0, 0, 0);

INSERT INTO `creature` VALUES (132569, 18956, 556, 1, 0, 0, -157.6380, 158.8178, 0.010763, 1.0821, 180, 0, 0, 8700, 0, 0, 0);

INSERT INTO `creature` VALUES (245629, 26178, 1, 1, 0, 0, -413.607, 2425.78, 65.7533, 4.50994, 600, 0, 0, 1700, 0, 0, 0);

DELETE FROM `game_event_creature` WHERE `guid` IN (44253,40444,86179,93958,93959,93960);
INSERT INTO `game_event_creature` VALUES
(86179, 1),

(44253, 46),
(40444, 46),

(93959,49),

(93958,53),
(93960,53);

-- Stairs of Destiny NPCs should not be attackable
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|2 WHERE `entry` IN (20487, 20513);

-- Searing Elemental (Fire Elemental)
UPDATE `creature_template` SET `resistance2` = -1 WHERE `entry` = 20514;

-- Greyheart Nether-Mage 21230
-- only Sheepable immune to cast speed reduce ( all casters )
-- Decides whether Fire 38635 38636 38641 Frost 38644 38645 38646 Arcane 38633 38634, additional Blink 38642 38643 and Buff 38647 38648 38649 depending on specc chosen maybe 38632 for visual something
-- http://www.wowhead.com/npc=21230/greyheart-nether-mage#comments , http://wowwiki.wikia.com/wiki/Greyheart_Nether-Mage?direction=prev&oldid=993664 , http://wowwiki.wikia.com/wiki/Greyheart_Nether-Mage?direction=next&oldid=1185956
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='4206',`maxdmg`='4993',`baseattacktime`='1400',`mechanic_immune_mask`='1073627115' WHERE `entry` = 21230; -- 1513 3087 2000 -- 8,411 - 9,985
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21230;
INSERT INTO `creature_ai_scripts` VALUES
('2123001','21230','11','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Spawn'),
('2123002','21230','4','125','100','2','0','0','0','0','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt on Aggro (Phase 1)'),
('2123003','21230','9','125','100','3','0','40','1200','4800','11','38645','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frostbolt (Phase 1)'),
('2123004','21230','9','125','100','3','0','5','8000','12000','11','38644','0','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Cone of Cold (Phase 1)'),
('2123005','21230','0','125','100','3','6000','12000','8400','12000','11','38646','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blizzard (Phase 1)'),
('2123006','21230','1','125','100','3','1000','1000','1800000','1800000','11','38649','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction OOC (Phase 1)'),
('2123007','21230','27','125','100','3','38649','1','5000','5000','11','38649','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Frost Destruction on Missing Buff (Phase 1)'),
('2123008','21230','1','119','100','3','1000','1000','1800000','1800000','11','38648','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction OOC (Phase 3)'),
('2123009','21230','4','119','100','2','0','0','0','0','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball on Aggro (Phase 3)'),
('2123010','21230','9','119','100','3','0','40','1200','4800','11','38641','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fireball (Phase 3)'),
('2123011','21230','0','119','100','3','6000','12000','8400','12000','11','38635','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Rain of Fire (Phase 3)'),
('2123012','21230','9','119','100','2','0','30','9000','12000','11','38636','1','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Scorch (Phase 3)'),
('2123013','21230','27','119','100','3','38648','1','5000','5000','11','38648','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Fire Destruction on Missing Buff (Phase 3)'),
('2123014','21230','1','95','100','3','1000','1000','1800000','1800000','11','38647','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction OOC (Phase 2)'),
('2123015','21230','4','95','100','2','0','0','0','0','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley on Aggro (Phase 5)'),
('2123016','21230','9','95','100','3','0','40','4800','9600','11','38633','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Volley (Phase 5)'),
('2123017','21230','0','95','100','3','2000','6000','9600','12600','11','38634','4','0','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Lightning (Phase 5)'),
('2123018','21230','27','95','100','3','38647','1','5000','5000','11','38647','0','32','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Arcane Destruction on Missing Buff (Phase 5)'),
('2123019','21230','0','0','75','3','6000','18000','17000','24000','11','38642','0','1','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Cast Blink'),
('2123020','21230','7','0','100','2','0','0','0','0','30','1','3','5','0','0','0','0','0','0','0','0','Greyheart Nether-Mage - Random Phase Select on Evade');

-- League of Arathor Emissary
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|4 WHERE `entry` = 14991;
