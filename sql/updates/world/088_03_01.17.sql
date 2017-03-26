-- Database March 01

-- =================
-- Real Vendor Spawns
-- ================= ATTENTION 20278 costum atm
SET @GUID := 9999956;
DELETE FROM `creature` WHERE `guid` BETWEEN 9999956 AND 9999980;
DELETE FROM `creature` WHERE `guid` IN (16800709,16800710,16800713,16800714);
-- S1 1200057 1200050- reduced
-- S2 1200061 77778- reduced
-- S3 77777 77773- reduced 
-- S4 26352
INSERT INTO `creature` VALUES (@GUID := @GUID + 0, 77778, 1, 1, 0, 0, -7120.38, -3774.1, 8.92485, 0.64873, 300, 0, 0, 6300, 0, 0, 0); -- 77778
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77777, 1, 1, 0, 0, -7118.7109, -3776.7121, 8.7466, 0.3197, 300, 0, 0, 6300, 0, 0, 0); -- 77777
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77778, 530, 1, 0, 0, 3067.31, 3635.82, 143.781, 0.872758, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77777, 530, 1, 0, 0, 3070.1987, 3632.4182, 143.7810, 1.2072, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77778, 450, 1, 0, 0, 261.833, 81.6485, 25.7204, 3.0366, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77777, 450, 1, 0, 0, 262.3464, 86.1316, 25.7198, 3.2060, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 450, 1, 0, 0, 261.6542, 90.4808, 25.7210, 3.6099, 300, 0, 0, 6300, 0, 0, 0); -- honor vendor
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77778, 449, 1, 0, 0, 4.14647, 18.6761, 1.05706, 1.59124, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77777, 449, 1, 0, 0, 8.3817, 21.1129, 1.0558, 3.1393, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 449, 1, 0, 0, 8.4142, 26.6698, 1.0558, 3.1393, 300, 0, 0, 6300, 0, 0, 0); -- honor vendor
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77778, 530, 1, 0, 0, -1966.84, 5168.63, -38.2516, 0.434276, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77777, 530, 1, 0, 0, -1968.5123, 5171.7255, -38.3079, 0.4689, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 20278, 530, 1, 0, 0, -1970.0279, 5174.9272, -38.4901, 0.4689, 300, 0, 0, 6300, 0, 0, 0); -- honor vendor
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77778, 530, 1, 0, 0, 2885.7, 5983.29, 3.156, 1.2639, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77777, 530, 1, 0, 0, 2890.4035, 5981.6450, 2.8027, 0.9166, 300, 0, 0, 6300, 0, 0, 0); 
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77778, 530, 1, 0, 0, -2161.66, 6658.46, -0.175319, 5.96662, 300, 0, 0, 6300, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 77777, 530, 1, 0, 0, -2163.7885, 6653.3735, -0.2625, 5.96662, 300, 0, 0, 6300, 0, 0, 0);
-- Offparts Vendors
-- S2 1200059 & 1200060
-- S3 77710 & 77779 
-- S4 24520 & 23446
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,77710,450,1,0,0,250.256,101.317,25.7211,4.3434,300,0,0,32400,0,0,0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,77779,449,1,0,0,-7.23101,35.5028,1.05583,4.72225,300,0,0,7048,0,0,0);
-- AV Mark Trader
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200007,450,1,0,0,235.7808,101.0694,25.7211,5.1641,300,0,0,32400,0,0,0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200007,449,1,0,0,-0.6561,36.4941,1.05583,4.6986,300,0,0,11000,0,0,0);
-- other changeable vendors pre s1 honor
-- INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200054, 450, 1, 0, 0, 255.136, 99.0989, 25.7213, 4.08738, 300, 0, 0, 11828, 0, 0, 0);
-- INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200055, 450, 1, 0, 0, 244.667, 103.94, 25.7206, 4.54998, 300, 0, 0, 11828, 0, 0, 0);
-- INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200053, 449, 1, 0, 0, 7.0471, 18.6628, 1.05583, 1.57548, 300, 0, 0, 11828, 0, 0, 0); -- should become s1 honor vendor
-- INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200052, 449, 1, 0, 0, -6.73524, -7.10416, 5.48803, 1.55003, 300, 0, 0, 11828, 0, 0, 0);

UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';

-- epic gems equivalent BuyPrice
-- UPDATE `item_template` SET `BuyPrice` = 200000 WHERE `entry` IN (32227,32228,32229,32230,32231,32249); -- 0

-- Scotty 1200007
UPDATE `creature_template` SET `modelid_A`=21290, `modelid_H`=21290, `subname`='Alterac Valley Mark Trader', `armor`=6800, `unit_flags`=512, `rank`=1 WHERE `entry` = 1200007;
UPDATE `creature_model_info` SET `modelid_other_gender`=0 WHERE `modelid`=21290; -- 21289
UPDATE `quest_template` SET `Name`='Small Mark Trade', `Details`='Deal or no Deal?', `Objectives`='1 of each Honor Mark for 2 Alterac Valley Honor Marks', `OfferRewardText`='You are welcome!', `RequestItemsText`='You need 1 of each Marks to trade.', `ReqItemId2`=20559, `ReqItemId3`=29024, `ReqItemCount1`=1 , `ReqItemCount2`=1, `ReqItemCount3`=1, `RewChoiceItemId2`=0, `RewChoiceItemId3`=0, `RewChoiceItemCount1`=2, `RewChoiceItemCount2`=0, `RewChoiceItemCount3`=0 WHERE `entry` = 100017;
UPDATE `quest_template` SET `Name`='Medium Mark Trade', `Details`='Deal or no Deal?', `Objectives`='5 of each Honor Mark for 10 Alterac Valley Honor Marks', `OfferRewardText`='You are welcome!', `RequestItemsText`='You need 5 of each Marks to trade.', `ReqItemId2`=20559, `ReqItemId3`=29024, `ReqItemCount1`=5, `ReqItemCount2`=5, `ReqItemCount3`=5, `RewChoiceItemId2`=0, `RewChoiceItemId3`=0, `RewChoiceItemCount1`=10, `RewChoiceItemCount2`=0, `RewChoiceItemCount3`=0 WHERE `entry` = 100018;
UPDATE `quest_template` SET `Name`='Big Mark Trade', `Details`='Deal or no Deal?', `Objectives`='10 of each Honor Mark for 20 Alterac Valley Honor Marks', `OfferRewardText`='You are welcome!', `RequestItemsText`='You need 10 of each Marks to trade.', `ReqItemId2`=20559, `ReqItemId3`=29024, `ReqItemCount1`=10, `ReqItemCount2`=10, `ReqItemCount3`=10, `RewChoiceItemId2`=0, `RewChoiceItemId3`=0, `RewChoiceItemCount1`=20, `RewChoiceItemCount2`=0, `RewChoiceItemCount3`=0 WHERE `entry` = 100019;

-- Rechecking
DELETE FROM `creature_template` WHERE `entry` IN (18898,19857,20278,23396,24392,24394,24395,24451,24452,25176,25177,25178,25179,26352,26378,26383,26384,27668,27721,27722,28225,77771,77772,77773,77774,77775,77776,77777,77778,1200050,1200057,1200061);
INSERT INTO `creature_template` VALUES (18898, 0, NULL, 18293, 0, 18293, 0, 'Explodyne Fizzlespurt', 'Arena Vendor', NULL, 70, 70, 7900, 7900, 0, 0, 6800, 1, 35, 35, 129, 1.125, 1, 0, 60, 101, 0, 1695, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (19857, 0, NULL, 19225, 0, 19225, 0, 'Meminnie', 'Arena Vendor', NULL, 70, 70, 7800, 7800, 0, 0, 6800, 1, 35, 35, 129, 1.125, 1, 0, 202, 350, 0, 5796, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 1, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (20278, 0, NULL, 18290, 0, 18290, 0, 'Vixton Pinchwhistle', 'Arena Vendor', NULL, 70, 70, 6300, 6300, 0, 0, 6800, 1, 35, 35, 129, 1.125, 0.85, 0, 202, 350, 0, 5796, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 1, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (23396, 0, NULL, 21462, 0, 21462, 0, 'Krixel Pinchwhistle', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 129, 1.1, 1, 0, 300, 350, 0, 0, 2000, 0, 514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (24392, 0, NULL, 22393, 0, 22393, 0, 'Leeni "Smiley" Smalls', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (24394, 0, NULL, 22398, 0, 22398, 0, 'Dellix Pinchwhistle', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (24395, 0, NULL, 22399, 0, 22399, 0, 'Zindik Pinchwhistle', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (24451, 0, NULL, 22438, 0, 22438, 0, 'Elli Blastnozzle', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (24452, 0, NULL, 22439, 0, 22439, 0, 'Paree Blastnozzle', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (25176, 0, NULL, 22398, 0, 22398, 0, 'Grikkin Copperspring', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 129, 1.1, 1, 0, 220, 450, 0, 7500, 2000, 0, 514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (25177, 0, NULL, 22438, 0, 22438, 0, 'Evee Copperspring', 'Arena Vendor', NULL, 70, 70, 4100, 4100, 0, 0, 6800, 1, 35, 35, 129, 1.1, 1, 0, 0, 0, 0, 0, 2000, 0, 514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (25178, 0, NULL, 22399, 0, 22399, 0, 'Ecton Brasstumbler', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.05, 1, 0, 220, 350, 0, 11400, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (25179, 0, NULL, 22439, 0, 22439, 0, 'Frixee Brasstumbler', 'Arena Vendor', NULL, 70, 70, 8400, 8400, 0, 0, 6800, 1, 35, 35, 129, 1.1, 1, 0, 220, 450, 0, 7500, 2000, 0, 514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (26352, 0, NULL, 23768, 0, 23768, 0, 'Big Zokk Torquewrench', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 129, 1.5, 1, 0, 320, 410, 0, 7500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (26378, 0, NULL, 22438, 0, 22438, 0, 'Evee Copperspring', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.05, 1, 0, 0, 0, 0, 0, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (26383, 0, NULL, 22398, 0, 22398, 0, 'Grikkin Copperspring', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (26384, 0, NULL, 22439, 0, 22439, 0, 'Frixee Brasstumbler', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (27668, 0, NULL, 24735, 0, 24735, 0, 'Ontok Shatterhorn', 'Arena Vendor', '', 70, 70, 12000, 12000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 8044, 0, 2, '');
INSERT INTO `creature_template` VALUES (27721, 0, NULL, 24764, 0, 24764, 0, 'Drelik Blastpipe', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 129, 1.2, 1, 0, 120, 350, 0, 7500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (27722, 0, NULL, 24764, 0, 24764, 0, 'Drolig Blastpipe', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 129, 1.2, 1, 0, 120, 350, 0, 7500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (28225, 0, NULL, 25219, 0, 25219, 0, 'Griz Gutshank', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1, 1, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77771, 0, NULL, 22393, 0, 22393, 0, 'Leeni "Kicher" Erbse', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77772, 0, NULL, 21462, 0, 21462, 0, 'Krixel Quetschpfeiffe', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77773, 0, NULL, 18293, 0, 18293, 0, 'Explodyne Fizzlespurt', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77774, 0, NULL, 22398, 0, 22398, 0, 'Grikkin Kupferspule', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77775, 0, NULL, 19225, 0, 19225, 0, 'Meminnie', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77776, 0, NULL, 22439, 0, 22439, 0, 'Frixi Messingkipper', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77777, 0, NULL, 22399, 0, 22399, 0, 'Ecton Messingkipper', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (77778, 0, NULL, 22438, 0, 22438, 0, 'Ivi Kupferspule', 'Arena Vendor', '', 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 128, 1.5, 1, 0, 220, 350, 0, 10500, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (1200050, 0, NULL, 18290, 0, 18290, 0, 'Vixton Quetschpfeife', 'Arena Vendor', '', 70, 70, 6300, 6300, 0, 0, 6800, 1, 35, 35, 129, 1.125, 0.8, 0, 202, 350, 0, 0, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 1, 3, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (1200057, 0, NULL, 22438, 0, 22438, 0, 'Ivi Kupferspule', 'Arena Vendor', '', 70, 70, 6986, 6986, 0, 0, 0, 1, 35, 35, 128, 1.05, 1, 0, 0, 0, 0, 0, 2000, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 1, 0, 1, 0, 0, 2, '');
INSERT INTO `creature_template` VALUES (1200061, 0, NULL, 21462, 0, 21462, 0, 'Krixel Pinchwhistle', 'Arena Vendor', NULL, 70, 70, 11000, 11000, 0, 0, 6800, 1, 35, 35, 129, 1.1, 1, 0, 300, 350, 0, 0, 2000, 0, 514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 2, '');

-- Honorvendor +++
UPDATE `creature_template` SET `faction_A`=35, `faction_H`= 35, `npcflag`=`npcflag`|128, `unit_flags`=`unit_flags`|2 WHERE `entry` IN (12777,12785,12792,12795,23446,23447,24520,24668,24670,24672,26393,26395,26397,26398,77710,77779,1200051,1200052,1200053,1200054,1200055,1200056,1200059,1200060);

-- S2 Glaive for Shoulder NPC
DELETE FROM `creature_equip_template` WHERE `entry` = 8044;
INSERT INTO `creature_equip_template` VALUES
(8044,41562,0,0,33490434,0,0,529,0,0);

-- Change Season 1 Settings in Live NPC to Less Arena Points without Rating except for Shoulders
UPDATE `npc_vendor` SET `ExtendedCost`='2388' WHERE `ExtendedCost`='1758' AND `entry` = 1200050; -- 1000       -> 800
UPDATE `npc_vendor` SET `ExtendedCost`='22' WHERE `ExtendedCost`='2337' AND `entry` = 1200050;  -- 1875(1600R) -> 1630
UPDATE `npc_vendor` SET `ExtendedCost`='2373' WHERE `ExtendedCost`='2359' AND `entry` = 1200050; -- 1500(2200R) -> 1304(1950R) -- 24 1304
UPDATE `npc_vendor` SET `ExtendedCost`='26' WHERE `ExtendedCost`='2360' AND `entry` = 1200050;   -- 3750(2050R) -> 3261
UPDATE `npc_vendor` SET `ExtendedCost`='148' WHERE `ExtendedCost`='2361' AND `entry` = 1200050; -- 3150(2050R) -> 2739
UPDATE `npc_vendor` SET `ExtendedCost`='133' WHERE `ExtendedCost`='2362' AND `entry` = 1200050; -- 2625(2050R) -> 2283
UPDATE `npc_vendor` SET `ExtendedCost`='21' WHERE `ExtendedCost`='2363' AND `entry` = 1200050; -- 1125(2050R) -> 978
UPDATE `npc_vendor` SET `ExtendedCost`='21' WHERE `ExtendedCost`='2283' AND `entry` = 1200050 AND `item` IN (28346,32452);   -- 1125       -> 978
UPDATE `npc_vendor` SET `ExtendedCost`='22' WHERE `ExtendedCost`='2364' AND `entry` = 1200050; -- 1875(2050R) -> 1630
UPDATE `npc_vendor` SET `ExtendedCost`='22' WHERE `ExtendedCost`='2365' AND `entry` = 1200050; -- 1875(1700R) -> 1630
UPDATE `npc_vendor` SET `ExtendedCost`='22' WHERE `ExtendedCost`='2366' AND `entry` = 1200050; -- 1875(1550R) -> 1630

-- S2 Vendor Adjustments
UPDATE `npc_vendor` SET `ExtendedCost`='2363' WHERE `Item` IN (31978,32961) AND `entry` = 1200061; -- 1125(0R)(2342) -- 2363
UPDATE `npc_vendor` SET `ExtendedCost`='2363' WHERE `Item` IN (31958,31985,32003,32027,32046) AND `entry` = 1200061; -- 1125(2050R) -- 2362
-- UPDATE `npc_vendor` SET `ExtendedCost`='1758' WHERE `ExtendedCost`='2339' AND `entry` = 1200050; -- 1000(1750R) -> 1000

-- shoulder pads 2.00k r 1500p -> 1435
DELETE FROM `npc_vendor` WHERE `entry` = 1200061 AND `item` IN (30490,31964,31971,31976,31979,31990,31996,32001,32008,32013,32018,32024,32033,32037,32043,32047,32059);
INSERT INTO `npc_vendor` VALUES
(1200061,30490,0,0,1435), --  2359
(1200061,31964,0,0,1435),(1200061,31971,0,0,1435),(1200061,31976,0,0,1435),(1200061,31979,0,0,1435),(1200061,31990,0,0,1435),(1200061,31996,0,0,1435),(1200061,32001,0,0,1435),(1200061,32008,0,0,1435),(1200061,32013,0,0,1435),(1200061,32018,0,0,1435),(1200061,32024,0,0,1435),(1200061,32033,0,0,1435),(1200061,32037,0,0,1435),(1200061,32043,0,0,1435),(1200061,32047,0,0,1435),(1200061,32059,0,0,1435);

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
INSERT INTO `npc_vendor` VALUES (20278, 24550, 0, 0, 2238); -- 2285 -- 2237(2238 for no av marks)
INSERT INTO `npc_vendor` VALUES (20278, 24557, 0, 0, 2238);
INSERT INTO `npc_vendor` VALUES (20278, 28294, 0, 0, 2238);
INSERT INTO `npc_vendor` VALUES (20278, 28298, 0, 0, 2238);
INSERT INTO `npc_vendor` VALUES (20278, 28299, 0, 0, 2238);
INSERT INTO `npc_vendor` VALUES (20278, 28300, 0, 0, 2238);
INSERT INTO `npc_vendor` VALUES (20278, 28476, 0, 0, 2238);
-- 1H Caster
INSERT INTO `npc_vendor` VALUES (20278, 28297, 0, 0, 2238); -- 2283 -- 2238
INSERT INTO `npc_vendor` VALUES (20278, 32450, 0, 0, 2238);
INSERT INTO `npc_vendor` VALUES (20278, 32451, 0, 0, 2238);
-- 1H Melee
INSERT INTO `npc_vendor` VALUES (20278, 28295, 0, 0, 2239); -- 2283 -- 2239
INSERT INTO `npc_vendor` VALUES (20278, 28305, 0, 0, 2239);
INSERT INTO `npc_vendor` VALUES (20278, 28308, 0, 0, 2239);
INSERT INTO `npc_vendor` VALUES (20278, 28312, 0, 0, 2239);
INSERT INTO `npc_vendor` VALUES (20278, 28313, 0, 0, 2239);
-- Offhand
INSERT INTO `npc_vendor` VALUES (20278, 28302, 0, 0, 2240); -- 2343 -- 2240
INSERT INTO `npc_vendor` VALUES (20278, 28307, 0, 0, 2240);
INSERT INTO `npc_vendor` VALUES (20278, 28309, 0, 0, 2240);
INSERT INTO `npc_vendor` VALUES (20278, 28310, 0, 0, 2240);
INSERT INTO `npc_vendor` VALUES (20278, 28314, 0, 0, 2240);
INSERT INTO `npc_vendor` VALUES (20278, 28346, 0, 0, 2240);
INSERT INTO `npc_vendor` VALUES (20278, 32452, 0, 0, 2240);
-- Thrown/Wand/Idol/Libram/Totem
INSERT INTO `npc_vendor` VALUES (20278, 28319, 0, 0, 2241); -- 2374 -- 2241
INSERT INTO `npc_vendor` VALUES (20278, 28320, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 28355, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 28356, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 28357, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 33936, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 33939, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 33942, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 33945, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 33948, 0, 0, 2241);
INSERT INTO `npc_vendor` VALUES (20278, 33951, 0, 0, 2241);

-- Shield
INSERT INTO `npc_vendor` VALUES (20278, 28358, 0, 0, 2242); -- 2374 -- 2242
-- Gauntlets
INSERT INTO `npc_vendor` VALUES (20278, 24549, 0, 0, 2255); -- 2254 -- 2277(2255 for eots marks)
INSERT INTO `npc_vendor` VALUES (20278, 24556, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 25834, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 25857, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 26000, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 27470, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 27703, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 27707, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 27880, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 28126, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 28136, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 28335, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 30188, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 31375, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 31397, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 31409, 0, 0, 2255);
INSERT INTO `npc_vendor` VALUES (20278, 31614, 0, 0, 2255);
-- Shoulders
INSERT INTO `npc_vendor` VALUES (20278, 24546, 0, 0, 2278); -- 2373 -- 2278
INSERT INTO `npc_vendor` VALUES (20278, 24554, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 25832, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 25854, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 25999, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 27473, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 27706, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 27710, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 27883, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 28129, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 28139, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 28333, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 30186, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 31378, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 31407, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 31412, 0, 0, 2278);
INSERT INTO `npc_vendor` VALUES (20278, 31619, 0, 0, 2278);
-- Chest
INSERT INTO `npc_vendor` VALUES (20278, 24544, 0, 0, 2279); -- 2258 -- 2279
INSERT INTO `npc_vendor` VALUES (20278, 24552, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 25831, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 25856, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 25997, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 27469, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 27702, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 27711, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 27879, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 28130, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 28140, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 28334, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 30200, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 31379, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 31396, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 31413, 0, 0, 2279);
INSERT INTO `npc_vendor` VALUES (20278, 31613, 0, 0, 2279);
-- Helmet
INSERT INTO `npc_vendor` VALUES (20278, 24545, 0, 0, 2280); -- 2262-2280- 
INSERT INTO `npc_vendor` VALUES (20278, 24553, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 25830, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 25855, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 25998, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 27471, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 27704, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 27708, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 27881, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 28127, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 28137, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 28331, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 30187, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 31376, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 31400, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 31410, 0, 0, 2280);
INSERT INTO `npc_vendor` VALUES (20278, 31616, 0, 0, 2280);
-- Legs
INSERT INTO `npc_vendor` VALUES (20278, 24547, 0, 0, 2281); -- 2264-2281
INSERT INTO `npc_vendor` VALUES (20278, 24555, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 25833, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 25858, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 26001, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 27472, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 27705, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 27709, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 27882, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 28128, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 28138, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 28332, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 30201, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 31377, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 31406, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 31411, 0, 0, 2281);
INSERT INTO `npc_vendor` VALUES (20278, 31618, 0, 0, 2281);
--
-- nonblizzlike rar gems for honor+12g
-- INSERT INTO `npc_vendor` VALUES (20278, 23436, 0, 0, 2404);
-- INSERT INTO `npc_vendor` VALUES (20278, 23437, 0, 0, 2404);
-- INSERT INTO `npc_vendor` VALUES (20278, 23438, 0, 0, 2404);
-- INSERT INTO `npc_vendor` VALUES (20278, 23439, 0, 0, 2404);
-- INSERT INTO `npc_vendor` VALUES (20278, 23440, 0, 0, 2404);
-- INSERT INTO `npc_vendor` VALUES (20278, 23441, 0, 0, 2404);
-- nonblizzlike epic gems for honor
-- ('@ENTRY','32227','0','0','2404'),
-- ('@ENTRY','32229','0','0','2404'),
-- ('@ENTRY','32228','0','0','2404'),
-- ('@ENTRY','32230','0','0','2404'),
-- ('@ENTRY','32231','0','0','2404'),
-- ('@ENTRY','32249','0','0','2404');

-- S3 Vendor
DELETE FROM `npc_vendor` WHERE `entry` = 77777;
-- Shield
INSERT INTO `npc_vendor` VALUES (77777, 33661, 0, 0, 2364);
INSERT INTO `npc_vendor` VALUES (77777, 33735, 0, 0, 2364);
INSERT INTO `npc_vendor` VALUES (77777, 33755, 0, 0, 2364);
-- Offhand
INSERT INTO `npc_vendor` VALUES (77777, 33662, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33689, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33705, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33734, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33756, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33801, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 34015, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 34016, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33681, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 33736, 0, 0, 2363);
INSERT INTO `npc_vendor` VALUES (77777, 34033, 0, 0, 2363);
-- Shoulder
INSERT INTO `npc_vendor` VALUES (77777, 33668, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33674, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33679, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33682, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33693, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33699, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33703, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33710, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33715, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33720, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33726, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33732, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33742, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33747, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33753, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33757, 0, 0, 2359);
INSERT INTO `npc_vendor` VALUES (77777, 33770, 0, 0, 2359);
-- Melee MH
INSERT INTO `npc_vendor` VALUES (77777, 33669, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33733, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33737, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33754, 0, 0, 2362);
INSERT INTO `npc_vendor` VALUES (77777, 33762, 0, 0, 2362);
-- Caster MH
INSERT INTO `npc_vendor` VALUES (77777, 33687, 0, 0, 2361); 
INSERT INTO `npc_vendor` VALUES (77777, 33743, 0, 0, 2361);
INSERT INTO `npc_vendor` VALUES (77777, 33763, 0, 0, 2361);
-- Wands etc
INSERT INTO `npc_vendor` VALUES (77777, 33764, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33765, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33841, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33842, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33843, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33938, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33941, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33944, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33947, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33950, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 33953, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 34014, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 34059, 0, 0, 2339);
INSERT INTO `npc_vendor` VALUES (77777, 34066, 0, 0, 2339);
-- 2H Weapon & Ranged
INSERT INTO `npc_vendor` VALUES (77777, 33006, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33663, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33670, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33688, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33716, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33727, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 33766, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 34529, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 34530, 0, 0, 2360);
INSERT INTO `npc_vendor` VALUES (77777, 34540, 0, 0, 2360);
-- Chest
INSERT INTO `npc_vendor` VALUES (77777, 33664, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33675, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33680, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33685, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33694, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33695, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33704, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33706, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33711, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33721, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33722, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33728, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33738, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33748, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33749, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33760, 0, 0, 2337);
INSERT INTO `npc_vendor` VALUES (77777, 33771, 0, 0, 2337);
-- Head
INSERT INTO `npc_vendor` VALUES (77777, 33666, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33672, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33677, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33683, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33691, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33697, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33701, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33708, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33713, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33718, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33724, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33730, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33740, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33745, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33751, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33758, 0, 0, 2365);
INSERT INTO `npc_vendor` VALUES (77777, 33768, 0, 0, 2365);
-- Legs
INSERT INTO `npc_vendor` VALUES (77777, 33667, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33673, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33678, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33686, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33692, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33698, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33702, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33709, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33714, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33719, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33725, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33731, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33741, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33746, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33752, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33761, 0, 0, 2366);
INSERT INTO `npc_vendor` VALUES (77777, 33769, 0, 0, 2366);
-- Gloves
INSERT INTO `npc_vendor` VALUES (77777, 33665, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33671, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33676, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33684, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33690, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33696, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33700, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33707, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33712, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33717, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33723, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33729, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33739, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33744, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33750, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33759, 0, 0, 2286);
INSERT INTO `npc_vendor` VALUES (77777, 33767, 0, 0, 2286);


DELETE FROM `npc_vendor` WHERE `entry` IN (77779,77710) AND `item` IN (35326,35327,34049,34579,34163,34576,34162,34577,33832,34578,34050,34580);
-- 2.3 release
-- INSERT INTO `npc_vendor` VALUES (77710, 34576, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77710, 34577, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77710, 34578, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77710, 34579, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77710, 34580, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77779, 34576, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77779, 34577, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77779, 34578, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77779, 34579, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77779, 34580, 0, 0, 2289);
-- 2.4 other vendor with 2.4 -> S4 Honor Vendor
-- INSERT INTO `npc_vendor` VALUES (77710, 35327, 0, 0, 2289);
-- INSERT INTO `npc_vendor` VALUES (77779, 35327, 0, 0, 2289);

DELETE FROM `pool_template` WHERE `entry` IN (13029, 13100);
INSERT INTO `pool_template` VALUES (13029, 21, 'Master Herb Pool - Desolace');
INSERT INTO `pool_template` VALUES (13100, 9, 'Master Herb Pool - Maraudon');

DELETE FROM `pool_gameobject` WHERE `guid` IN (3480888,3490639,3490647,3490650,3494618,3494625,3494628,3494629,3494631,3494632,3494633,3494753,3497319,3497320,3497321,3497322,3497323,3497324,3497325);
INSERT INTO `pool_gameobject` VALUES 
(3490639, 13029, 0, 'Ghost Mushroom - Desolace'),
(3490647, 13029, 0, 'Ghost Mushroom - Desolace'),
(3490650, 13029, 0, 'Ghost Mushroom - Desolace'),
(3494618, 13029, 0, 'Ghost Mushroom - Desolace'),
(3497325, 13029, 0, 'Ghost Mushroom - Desolace'),

(3480888, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3494625, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3494628, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3494629, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3494631, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3494632, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3494633, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3494753, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3497319, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3497320, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3497321, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3497322, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3497323, 13100, 0, 'Ghost Mushroom - Maraudon'),
(3497324, 13100, 0, 'Ghost Mushroom - Maraudon');

UPDATE `gameobject` SET `spawntimesecs` = 60 WHERE `id` = 142144;

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 23254;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 23254;
INSERT INTO `creature_ai_scripts` VALUES (2325401, 23254, 4, 0, 100, 2, 0, 0, 0, 0, 11, 40593, 0, 7, 37, 0, 0, 0, 0, 0, 0, 0, 'Fel Geyser - Cast Fel Geyser and Die on Aggro');

UPDATE `creature_template` SET `speed` = '1.20' WHERE `entry` = 22948;

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` IN (15106,15103,15102,15105,14991,14990,22013,22015);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (15106,15103,15102,15105,14991,14990,22013,22015);

INSERT INTO `creature_ai_scripts` VALUES (1499001, 14990, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Defilers Emissary - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (1499002, 14990, 1, 0, 100, 1, 5000, 25000, 5000, 15000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Defilers Emissary - Talk Emote OOC');

INSERT INTO `creature_ai_scripts` VALUES (1499101, 14991, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'League of Arathor Emissary - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (1499102, 14991, 1, 0, 100, 1, 5000, 25000, 5000, 15000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'League of Arathor Emissary - Talk Emote OOC');

INSERT INTO `creature_ai_scripts` VALUES (1510201, 15102, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Silverwing Emissary - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (1510202, 15102, 1, 0, 100, 1, 5000, 25000, 5000, 15000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Silverwing Emissary - Talk Emote OOC');

INSERT INTO `creature_ai_scripts` VALUES (1510301, 15103, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormpike Emissary - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (1510302, 15103, 1, 0, 100, 1, 5000, 25000, 5000, 15000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Stormpike Emissary - Talk Emote OOC');

INSERT INTO `creature_ai_scripts` VALUES (1510501, 15105, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Emissary - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (1510502, 15105, 1, 0, 100, 1, 5000, 25000, 5000, 15000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Warsong Emissary - Talk Emote OOC');

INSERT INTO `creature_ai_scripts` VALUES (1510601, 15106, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwolf Emissary - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (1510602, 15106, 1, 0, 100, 1, 5000, 25000, 5000, 15000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Frostwolf Emissary - Talk Emote OOC');

INSERT INTO `creature_ai_scripts` VALUES (2201301, 22013, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of the Storm Emissary - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (2201302, 22013, 1, 0, 100, 1, 5000, 25000, 10000, 30000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of the Storm Emissary - Talk Emote OOC');

INSERT INTO `creature_ai_scripts` VALUES (2201501, 22015, 1, 0, 100, 1, 10000, 90000, 20000, 70000, 10, 11, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of the Storm Envoy - Random Laugh or Cry Emote');
INSERT INTO `creature_ai_scripts` VALUES (2201502, 22015, 1, 0, 100, 1, 5000, 25000, 5000, 15000, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Eye of the Storm Envoy - Talk Emote OOC');

-- 2.2 Eye Vendor
DELETE FROM `npc_vendor` WHERE `entry` = 18255 AND `item` IN (33124,33205,33209);
INSERT INTO `npc_vendor` VALUES (18255, 33124, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (18255, 33205, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (18255, 33209, 0, 0, 0);

-- 2.2 Jewelcrafter Gems
DELETE FROM `npc_vendor` WHERE `entry` IN (20242, 23007, 21643, 21655, 21432) AND `item` IN (33305,33156,33158,33157,33160,33159,33155);
INSERT INTO `npc_vendor` VALUES (20242, 33305, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (23007, 33305, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (20242, 33156, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (23007, 33156, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 33158, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21655, 33157, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21643, 33160, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 33159, 0, 0, 0);
INSERT INTO `npc_vendor` VALUES (21432, 33155, 0, 0, 0);

UPDATE `gameobject_template` SET `flags` = 36 WHERE `entry` IN (183295, 183296, 184275, 184276, 184277, 184278, 184281, 184279, 183932, 184632, 184322, 184449);

-- Midnight 16151
UPDATE `creature_template` SET `mindmg`='4688',`maxdmg`='5567' WHERE `entry` = 16151; -- 9,375 - 11,134

-- Attumen the Huntsman 15550 
UPDATE `creature_template` SET `mindmg`='5413',`maxdmg`='6840' WHERE `entry` = 15550; -- 10,826 - 13,619

-- Moroes 15687
-- UPDATE `creature_template` SET ` WHERE `entry` = 15687;
UPDATE `creature_template` SET `mindmg`='5275',`maxdmg`='6264',`baseattacktime`='2000',`speed`='2.00' WHERE `entry` = 15687; -- 8439 10022 -- 10,549 - 12,527

-- Maiden of Virtue - Tugendhafte Maid 
UPDATE `creature_template` SET `mindmg`='6792',`maxdmg`='8062',`baseattacktime`='2000',`speed`='2.00' WHERE `entry` = 16457; -- 9500 10500 -- 13,584 - 16,123

-- Roar Fear
UPDATE `creature_template` SET `mindmg`='2769',`maxdmg`='3289',`baseattacktime`='1200',`speed`='1.71',`mechanic_immune_mask`='779042799',`flags_extra`='4259841' WHERE `entry` = 17546;  -- 4430 5262 --  5,538 - 6,578

-- Strawman Slow und Blind
UPDATE `creature_template` SET `mindmg`='4616',`maxdmg`='5482',`baseattacktime`='2000',`speed`='1.71',`mechanic_immune_mask`='720321533',`flags_extra`='4259841' WHERE `entry` = 17543; -- 7385 8771 -- 9,231 - 10,964

-- Tinhead Slow
UPDATE `creature_template` SET `mindmg`='4616',`maxdmg`='5482',`baseattacktime`='2000',`speed`='1.71',`mechanic_immune_mask`='787430395',`flags_extra`='4259841' WHERE `entry` = 17547; -- 7385 8771 -- 9,231 - 10,964 

-- The Crone
UPDATE `creature_template` SET `mindmg`='5433',`maxdmg`='6449',`baseattacktime`='2000',`speed`='2.00',`mechanic_immune_mask`='787431423',`flags_extra`='4259841' WHERE `entry` = 18168; -- 8693 10318 -- 10,866 - 12,898

-- Tito
UPDATE `creature_template` SET `mindmg`='928',`maxdmg`='1102',`baseattacktime`='1500',`speed`='1.71',`mechanic_immune_mask`='787431423',`flags_extra`='4259841' WHERE `entry` = 17548; -- 1485 1763 -- 1,856 - 2,204

-- Julianne
UPDATE `creature_template` SET `mindmg`='3260',`maxdmg`='3870',`baseattacktime`='1400',`speed`='1.71',`flags_extra`='65537' WHERE `entry` = 17534; -- 4216 5191 -- 6,520 - 7,739

-- Romulo
UPDATE `creature_template` SET `mindmg`='4395',`maxdmg`='5220',`baseattacktime`='2000',`speed`='1.71',`flags_extra`='65537' WHERE `entry` = 17533; -- 7032 8351 -- 8,790 - 10,439

-- The Big Bad Wolf
UPDATE `creature_template` SET `mindmg`='4571',`maxdmg`='5428',`baseattacktime`='1449',`speed`='1.30',`flags_extra`='65537' WHERE `entry` = 17521; -- 7312 8685 -- 9,141 - 10,856

-- The Curator - Der Kurator
UPDATE `creature_template` SET `mindmg`='6031',`maxdmg`='7159',`baseattacktime`='2000',`speed`='1.48' WHERE `entry` = 15691; -- 9000 10000 -- 12,062 - 14,317

-- Terestian Illhoof 15688
UPDATE `creature_template` SET `mindmg`='5573',`maxdmg`='6618',`baseattacktime`='2000',`speed`='2.00' WHERE `entry` = 15688; -- 7900 8400 -- 11,145 - 13,235

-- Shade of Aran
UPDATE `creature_template` SET `mindmg`='2295',`maxdmg`='2760',`baseattacktime`='2000',`speed`='2.00' WHERE `entry` = 16524; -- 3060 3679 -- 4,590 - 5,519

-- Prince Malchezaar 15690
UPDATE `creature_template` SET `mindmg`='5310',`maxdmg`='7509',`baseattacktime`='2400',`mechanic_immune_mask`='650854239' WHERE `entry` = 15690; -- 6000 - 7500 -- 6,638 - 9,386

-- Netherspite 15689
UPDATE `creature_template` SET `mindmg`='5122',`maxdmg`='5346',`baseattacktime`='2000',`speed`='2.00',`faction_A`='14',`faction_H`='14' WHERE `entry` = '15689'; -- 6146 6415 -- 15,366 - 16,037

-- Nightbane 17225
UPDATE `creature_template` SET `mindmg`='9960',`maxdmg`='11824',`baseattacktime`='2000',`speed`='2.00',`mechanic_immune_mask`='1072644095' WHERE `entry` = 17225; -- 15936 18918 -- 19,920 - 23,648

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
UPDATE `creature` SET `spawntimesecs` = 3600 WHERE `id` = 16492;
UPDATE `creature_template` SET `mindmg`='1450',`maxdmg`='1856' WHERE `entry` = 16492; -- 558 1138 -- 3,102 - 3,682
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16492;
INSERT INTO `creature_ai_scripts` VALUES 
('1649201','16492','9','0','100','3','0','15','9000','13000','11','29881','4','0','0','0','0','0','0','0','0','0','Syphoner - Cast Drain Mana');

-- Illidan Stormrage 22917- boss_illidan_stormrage
UPDATE `creature_template` SET `minhealth`='7284480',`maxhealth`='7284480' WHERE `entry` = 22917; -- 6070400 -- 7284480

-- Flame of Azzinoth 22997- boss_illidan_flameofazzinoth
UPDATE `creature_template` SET `minhealth`='1365840',`maxhealth`='1365840' WHERE `entry` = 22997; -- 1138200 -- 1365840

-- Magtheridon 17257
UPDATE `creature_template` SET `speed`='3.00',`mindmg`='15471',`maxdmg`='18373',`baseattacktime`='2000' WHERE `entry` = 17257; -- 1 16000 20000 1500 33554752 -- 16000 20000 -- 23207 27559

-- Lair Brute 19389
UPDATE `creature_template` SET `minhealth`='298298',`maxhealth`='298298',`armor`='7400',`speed`='1.48',`mindmg`='9193',`maxdmg`='9643',`baseattacktime`='1400',`mechanic_immune_mask`=617299827 WHERE `entry` = 19389; -- 298298 ba 1400 -- 4259 5159 -- 11000 12850 -- 18,386 - 19,286

-- Gronn-Priest 21350
UPDATE `creature_template` SET `minhealth`='250000',`maxhealth`='260000',`speed`='1.48',`mindmg`='6955',`maxdmg`='8256',`flags_extra`='4194304',`baseattacktime`='1400',mechanic_immune_mask=617299827 WHERE `entry` = 21350; -- 236120 1,15 2501 5104 ba 1400 -- 9273 11008 -- 13,909 - 16,512

-- Krosh Firehand 18832
UPDATE `creature_template` SET `mindmg`='6032',`maxdmg`='7159',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` = 18832; -- 7238 8591 -- 9,048 - 10,739

-- Olm the Summoner 18834
UPDATE `creature_template` SET `mindmg`='6032',`maxdmg`='7159',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` = 18834; -- 7238 8591 -- 9,048 - 10,739

-- Kiggler the Crazed 18835
UPDATE `creature_template` SET `mindmg`='10051',`maxdmg`='11931',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` = 18835; -- 12061 14317 -- 15,077 - 17,896

-- Blindeye the Seer 18836
UPDATE `creature_template` SET `mindmg`='6032',`maxdmg`='7159',`baseattacktime`='1449',`speed`='1.71' WHERE `entry` = 18836; -- 7238 8591 -- 2,449 - 2,908

-- Wild Fel Stalker 18847
UPDATE `creature_template` SET `mindmg`='2169',`maxdmg`='2575',`baseattacktime`='1400',`speed`='1.71',`spell1`='33091' WHERE `entry` = 18847; -- 2602 3090 -- 3,253 - 3,863

-- Gruul the Dragonkiller 19044
UPDATE `creature_template` SET `mindmg`='7369',`maxdmg`='8797',`baseattacktime`='1449',`speed`='3.00',`mechanic_immune_mask`='787431423',`flags_extra`='4259841' WHERE `entry` = 19044; -- T6+ 7369 8797 -- T4+5 9825 11729 -- 14,737 - 17,594

-- https://github.com/Looking4Group/L4G_Core/issues/639
-- =========
-- Old Hillsbrad Foothills
-- =========

-- ======================================================
-- Texts & Scripts
-- ======================================================

-- Scripts & Texts

DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-1272','-1273','-1274','-1275','-1276','-1277','-1278','-1279','-1280','-1281','-1282','-1283','-1284','-1285','-1286','-1287','-1288','-1289','-1290','-1291');
DELETE FROM `creature_ai_texts` WHERE `entry` BETWEEN -9859 AND -9857;
INSERT INTO `creature_ai_texts` VALUES
(-1272,'I\'m thinking of a vacation. I hear Hearthglen is nice.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1273,'Quitting time can\'t come too soon.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1274,'I hear that Blackmoore has been acting strange.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1275,'This area is restricted!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1276,'Halt!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1277,'Surrender immediately!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1278,'Stop them!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills 17820'),
(-1279,'Why...?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1280,'Blackmoore will have... your head!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1281,'I was just... following orders.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1282,'Cursed scum!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1283,'He\'s here, stop him!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1284,'Give up or die!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1285,'You won\'t get far....',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1286,'You think you\'ve won?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1287,'I\'ll...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1288,'You don\'t stand a chance!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1289,'We have all the time in the world....',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1290,'All that you know... will be undone.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),
(-1291,'You cannot escape us!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'Old Hillsbrad Foothills'),

(-9859,'Die like a dog!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'Don Carlos on PK'),
(-9858,'HAH! How do you like THAT?!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'Don Carlos on PK'),
(-9857,'Im... possible...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'Don Carlos on Death');
-- (-9856,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'HDZ1COMMENT'),

-- ======================================================
-- Spawns & Pooling
-- ======================================================

-- freie guids ab 83900 :  84007 - 84010 84012 84095 - 84100 weiter  84101
-- freie guids ab 83455: 83497 - 83501 83506 - 83510 83520 - 83525 83877 bis 83900

DELETE FROM `creature` WHERE `guid` IN (83939,83989,48021,84001);
INSERT INTO `creature` VALUES 
(83939,17819,560,3,0,0,2089.9956,44.8650,52.4412,4.4137,7200,0,0,17926,0,0,0),
(83989,17819,560,3,0,0,2055.1633,83.7097,52.4906,3.5859,7200,0,0,17926,0,0,0),
(48021, 17814, 560, 3, 17959, 0, 2013.41, 302.687, 66.0954, 1.14394, 6600, 0, 0, 0, 0, 0, 0);
-- (84001,17814,560,3,17959,0,2014.4409,302.3657,66.0960,1,7200,0,0,0,0,0,0);

-- ==========
-- ReGUID
-- ==========



-- ======================================================
-- NPC Research
-- ======================================================

-- Durnholde Rifleman / Durnholde Lookout 1h axe and rifle
UPDATE `creature_template` SET `equipment_id`='8008' WHERE `entry` IN ('17820','20526','22128','22129');
DELETE FROM `creature_equip_template` WHERE `entry` = 8008;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8008,22105,0,6606,218169346,0,50266626,3,0,26);

-- Durnholde Rifleman Axt und Gewehr 17820,20526
UPDATE `creature` SET `id`='17820' WHERE `guid` = 83972;
UPDATE `creature_template` SET `armor`='4900',`modelid_A2`='17982',`modelid_H2`='17982' WHERE `entry` = 17820;
UPDATE `creature_template` SET `speed`='1.48',`lootid`='17820',`pickpocketloot`='17820',`rangeattacktime`='0',`modelid_A2`='17982',`modelid_H2`='17982' WHERE `entry` = 20526;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17820');
INSERT INTO `creature_ai_scripts` VALUES
('1782001','17820','0','0','100','7','4000','4000','4000','4000','21','1','0','0','22','0','0','0','40','2','0','0','Durnholde Rifleman - Start Combat Movement and Start Melee'),
('1782002','17820','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Rifleman - Random Say OOC'),
('1782003','17820','4','0','10','38','0','0','0','0','1','-1275','-1276','-1277','22','1','0','0','21','0','0','0','Durnholde Rifleman - Random Say and Set Phase 1 on Aggro'),
('1782004','17820','9','1','100','3','5','30','1500','1500','11','16100','1','0','40','2','0','0','21','0','0','0','Durnholde Rifleman (Normal) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('1782005','17820','9','1','100','5','5','30','1500','1500','11','22907','1','0','40','2','0','0','21','0','0','0','Durnholde Rifleman (Heroic) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('1782006','17820','0','1','100','3','9000','15000','9000','15000','11','31942','4','1','40','2','0','0','21','0','0','0','Durnholde Rifleman (Normal) - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
('1782007','17820','0','1','100','5','9000','15000','9000','15000','11','38383','4','1','40','2','0','0','21','0','0','0','Durnholde Rifleman (Heroic) - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
('1782008','17820','0','0','100','7','10900','26500','22900','36200','11','23601','4','1','40','2','0','0','0','0','0','0','Durnholde Rifleman - Cast Scatter Shot and Set Ranged Weapon Model'),
('1782009','17820','2','0','100','6','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Durnholde Rifleman - Set Phase 2 at 15% HP'),
('1782010','17820','2','0','100','6','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Durnholde Rifleman - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('1782011','17820','9','1','100','6','0','5','0','0','21','1','0','0','40','1','0','0','20','1','0','0','Durnholde Rifleman - Start Combat Movement and Set Melee Weapon Model and Start Melee Below 5 Yards (Phase 1)'),
('1782012','17820','7','0','100','6','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Durnholde Rifleman - Set Phase 1 and Set Melee Weapon Model on Evade'),
('1782013','17820','6','0','10','38','0','0','0','0','1','-1279','-1280','-1281','1','-1280','-1281','-1282','1','-1279','-1280','-1282','Durnholde Rifleman - Random Say on Death');

-- Durnholde Lookout 22128,22129
UPDATE `creature` SET `id`='22128' WHERE `guid` IN (83910,83907,83930,83932,83940,83950,83962);
UPDATE `creature_template` SET `minlevel`='66',`maxlevel`='67',`armor`='4900',`faction_A`='1748',`faction_H`='1748',`modelid_A2`='17982',`modelid_H2`='17982',`unit_flags`='0',`baseattacktime`='1400',`speed`='1.48',`lootid`='17820',`pickpocketloot`='17820',`mechanic_immune_mask`='0',`AIName`='EventAI' WHERE `entry` = 22128;
UPDATE `creature_template` SET `armor`='7400',`faction_A`='1748',`faction_H`='1748',`modelid_A2`='17982',`modelid_H2`='17982',`speed`='1.48',`lootid`='17820',`pickpocketloot`='22128',`mechanic_immune_mask`='787431423' WHERE `entry` = 22129;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22128;
INSERT INTO `creature_ai_scripts` VALUES
('2212801','22128','0','0','100','7','4000','4000','4000','4000','21','1','0','0','22','1','0','0','40','2','0','0','Durnholde Lookout - Start Combat Movement and Start Melee'),
('2212802','22128','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Lookout - Random Say OOC'),
('2212803','22128','4','0','100','6','0','0','0','0','1','-1275','-1276','-1277','12','22398','1','300','12','22398','1','300','Durnholde Lookout - Random Say and Summon 2 Durnholde Reinforcement on Aggro'),
('2212804','22128','9','1','100','3','5','30','1500','1500','11','16100','1','0','40','2','0','0','21','0','0','0','Durnholde Lookout (Normal) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('2212805','22128','9','1','100','5','5','30','1500','1500','11','22907','1','0','40','2','0','0','21','0','0','0','Durnholde Lookout (Heroic) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('2212806','22128','0','1','100','3','9000','15000','9000','15000','11','31942','4','1','40','2','0','0','21','0','0','0','Durnholde Lookout (Normal) - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
('2212807','22128','0','1','100','5','9000','15000','9000','15000','11','38383','4','1','40','2','0','0','21','0','0','0','Durnholde Lookout (Heroic) - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
('2212808','22128','0','0','100','7','10900','26500','22900','36200','11','23601','4','1','40','2','0','0','0','0','0','0','Durnholde Lookout - Cast Scatter Shot and Set Ranged Weapon Model'),
('2212809','22128','2','0','100','6','15','0','0','0','22','2','0','0','0','0','0','0','0','0','0','0','Durnholde Lookout - Set Phase 2 at 15% HP'),
('2212810','22128','2','0','100','6','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Durnholde Lookout - Start Combat Movement and Flee at 15% HP (Phase 2)'),
('2212811','22128','9','1','100','6','0','5','0','0','21','1','0','0','40','1','0','0','20','1','0','0','Durnholde Lookout - Start Combat Movement and Set Melee Weapon Model and Start Melee Below 5 Yards (Phase 1)'),
('2212812','22128','7','0','100','6','0','0','0','0','22','0','0','0','40','1','0','0','21','1','0','0','Durnholde Lookout - Set Phase 0 and Set Melee Weapon Model and Start Movement on Evade'),
('2212813','22128','6','0','10','6','0','0','0','0','1','-1279','-1280','-1281','1','-1280','-1281','-1282','1','-1279','-1280','-1282','Durnholde Lookout - Random Say on Death');

-- Durnholde Sentry / Durnholde Reinforcement eigentlich 56902
UPDATE `creature_template` SET `equipment_id`='8006' WHERE `entry` IN ('17819','20527','22398','22399');
DELETE FROM `creature_equip_template` WHERE `entry` = 8006;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8006,20084,0,0,218171394,0,0,256,0,0);

-- Durnholde Sentry 2H Sword 17819,20527
UPDATE `creature` SET `id`='17819' WHERE `guid` IN (83912,83971,83966);
UPDATE `creature_template` SET `maxlevel`='67',`armor`='4900',`modelid_A2`='18001',`modelid_H2`='18001',`mindmg`='750',`maxdmg`='1250',`baseattacktime`='1800' WHERE `entry` = 17819;
UPDATE `creature_template` SET `armor`='7100',`modelid_A2`='18001',`modelid_H2`='18001',`speed`='1.48',`mindmg`='2555',`maxdmg`='3239',`lootid`='17819',`pickpocketloot`='17819' WHERE `entry` = 20527; -- 5,109 - 6,478 2000 4000
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17819');
INSERT INTO `creature_ai_scripts` VALUES
('1781901','17819','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Sentry - Random Say OOC'),
('1781902','17819','9','0','100','7','0','5','10100','15000','11','9080','1','1','0','0','0','0','0','0','0','0','Durnholde Sentry - Cast Hamstring'),
('1781903','17819','0','0','100','7','4000','9000','8000','11000','11','15496','1','1','0','0','0','0','0','0','0','0','Durnholde Sentry - Cast Cleave'),
('1781904','17819','0','0','100','7','6200','9700','9000','13000','11','14895','1','1','0','0','0','0','0','0','0','0','Durnholde Sentry - Cast Overpower'),
('1781905','17819','2','0','100','6','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Durnholde Sentry - Flee at 15% HP'),
('1781906','17819','6','0','10','38','0','0','0','0','1','-1279','-1280','-1281','0','0','0','0','0','0','0','0','Durnholde Sentry - Random Say on Death'),
('1781907','17819','4','0','10','6','0','0','0','0','1','-1278','0','0','0','0','0','0','0','0','0','0','Durnholde Sentry - Random Say on Aggro');

-- Durnholde Reinforcement 22398,22399
UPDATE `creature_template` SET `minlevel`='68',`maxlevel`='68',`armor`='5200',`minhealth`='24926',`maxhealth`='25338',`modelid_A2`='18001',`modelid_H2`='18001',`speed`='1.48',`unit_flags`='0',`lootid`='17819',`pickpocketloot`='17819',`mindmg`='1000',`maxdmg`='1500',`baseattacktime`='1800',`mechanic_immune_mask`='0',`AIName`='EventAI' WHERE `entry` = 22398;
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`armor`='7400',`minhealth`='49852',`maxhealth`='55676',`modelid_A2`='18001',`modelid_H2`='18001',`speed`='1.48',`mindmg`='3140',`maxdmg`='3689',`lootid`='17819',`pickpocketloot`='17819',`mechanic_immune_mask`='787421183' WHERE `entry` = 22399; -- 4,279 - 5,377 2500  4500
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 22399;
INSERT INTO `creature_onkill_reputation` VALUES
(22399,989,0,7,0,15,0,0,0,0);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22398;
INSERT INTO `creature_ai_scripts` VALUES
('2239801','22398','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Random Say OOC'),
('2239802','22398','9','0','100','7','0','5','5000','10000','11','9080','4','1','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Cast Hamstring'),
('2239803','22398','0','0','100','7','4000','9000','8000','11000','11','15496','1','1','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Cast Cleave'),
('2239804','22398','0','0','100','7','6200','9700','9000','13000','11','14895','1','1','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Cast Overpower'),
('2239805','22398','2','0','100','6','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Durnholde Reinforcement - Flee at 15% HP'),
('2239806','22398','6','0','10','6','0','0','0','0','1','-1279','-1280','-1281','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Random Say on Death'),
('2239807','22398','4','0','10','6','0','0','0','0','1','-1278','0','0','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Random Say on Aggro'),
('2239808','22398','7','0','10','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Durnholde Reinforcement - Despawn on Evade');

-- Durnholde Tracking Hound 17840,20528
UPDATE `creature_template` SET `maxlevel`='66',`minhealth`='10000',`maxhealth`='10645',`armor`='4600',`mindmg`='800',`maxdmg`='1200',`baseattacktime`='1000',`speed`='1.71' WHERE `entry` = 17840;
UPDATE `creature_template` SET `armor`='6500',`speed`='1.71',`mindmg`='1500',`maxdmg`='2000',`lootid`='17840',`skinloot`='70065' WHERE `entry` = 20528;
DELETE FROM `creature_template_addon` WHERE `entry` IN (17840,20528);
INSERT INTO `creature_template_addon` VALUES
(17840,0,0,0,0,0,0,0,'18950 0 18950 1'),
(20528,0,0,0,0,0,0,0,'18950 0 18950 1');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17840;
INSERT INTO `creature_ai_scripts` VALUES
('1784001','17840','2','0','100','6','50','0','0','0','11','8269','0','0','1','-106','0','0','0','0','0','0','Durnholde Tracking Hound - Cast Frenzy at 50% HP');
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='6' WHERE `creature_id` = 17840;

-- Durnholde Warden 17833,20530
-- Slabby ZH Zul Aman AI DESPELL vlt sogar anderen spell 23859 benutzen statt 17201
UPDATE `creature` SET `spawntimesecs`='7200' WHERE `id` = 17833;
UPDATE `creature` SET `id`='17833' WHERE `guid` = 83968;
UPDATE `creature_template` SET `equipment_id`='8009' WHERE `entry` IN (17833,20530);
DELETE FROM `creature_equip_template` WHERE `entry` = 8009;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8009,18368,0,0,50268674,0,0,529,0,0);
UPDATE `creature_template` SET `maxlevel`='68',`armor`='3950',`mindmg`='800',`maxdmg`='1200' WHERE `entry` = 17833;
UPDATE `creature_template` SET `minlevel`='70',`armor`='5700',`speed`='1.48',`mindmg`='1500',`maxdmg`='2000',`lootid`='17833',`pickpocketloot`='17833' WHERE `entry` = 20530;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17833');
INSERT INTO `creature_ai_scripts` VALUES
('1783301','17833','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Warden - Random Say OOC'),
('1783302','17833','4','0','10','38','0','0','0','0','1','-1276','-1277','-1278','0','0','0','0','0','0','0','0','Durnholde Warden - Random Say on Aggro'),
('1783303','17833','9','0','100','3','0','30','10000','15000','11','15654','4','32','0','0','0','0','0','0','0','0','Durnholde Warden (Normal) - Cast Shadow Word: Pain'),
('1783304','17833','9','0','100','5','0','30','8000','12000','11','34941','4','32','0','0','0','0','0','0','0','0','Durnholde Warden (Heroic) - Cast Shadow Word: Pain'),
('1783305','17833','0','0','100','7','16000','24000','20000','35000','11','22884','0','1','0','0','0','0','0','0','0','0','Durnholde Warden - Cast Psychic Scream'),
('1783306','17833','0','0','100','7','7000','12000','10000','16000','11','17201','0','1','0','0','0','0','0','0','0','0','Durnholde Warden - Cast Dispel Magic'),
('1783307','17833','14','0','100','3','7500','15','10000','15000','11','15586','6','0','0','0','0','0','0','0','0','0','Durnholde Warden (Normal) - Cast Heal on Friendlies'),
('1783308','17833','14','0','100','5','11200','15','8000','12000','11','22883','6','0','0','0','0','0','0','0','0','0','Durnholde Warden (Heroic) - Cast Heal on Friendlies'),
('1783309','17833','2','0','100','6','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Durnholde Warden - Flee at 15% HP'),
('1783310','17833','6','0','10','38','0','0','0','0','1','-1280','-1281','-1282','0','0','0','0','0','0','0','0','Durnholde Warden - Random Say on Death'),
('1783311','17833','15','0','100','7','0','30','10000','15000','11','17201','7','7','0','0','0','0','0','0','0','0','Durnholde Warden - Cast Dispel Magic on Friendlies'),
('1783313','17833','2','0','100','3','75','0','15000','20000','11','15586','0','1','0','0','0','0','0','0','0','0','Durnholde Warden (Heroic) - Cast Heal at 75%'),
('1783314','17833','2','0','100','5','75','0','15000','20000','11','22883','0','1','0','0','0','0','0','0','0','0','Durnholde Warden (Heroic) - Cast Heal at 75%');

-- Durnholde Veteran 17860,20529
UPDATE `creature` SET `id`='17860' WHERE `guid` IN (83975,83967);
UPDATE `creature_template` SET `equipment_id`='8010' WHERE `entry` IN (17860,20529);
DELETE FROM `creature_equip_template` WHERE `entry` = 8010;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8010,22078,6434,0,218171138,218173186,0,3,3,0); 
UPDATE `creature_template` SET `modelid_A2`='18006',`modelid_H2`='18006',`maxlevel`='68',`minhealth`='18345',`maxhealth`='18508',`armor`='5200',`mindmg`='400',`maxdmg`='600' WHERE `entry` = 17860;
UPDATE `creature_template` SET `modelid_A2`='18006',`modelid_H2`='18006',`minhealth`='28114',`armor`='7100',`speed`='1.48',`mindmg`='1200',`maxdmg`='1500',`lootid`='17860',`pickpocketloot`='17860',`mechanic_immune_mask`='787431423' WHERE `entry` = 20529;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17860;
INSERT INTO `creature_ai_scripts` VALUES
('1786001','17860','4','0','10','6','0','0','0','0','1','-1275','-1278','-1277','0','0','0','0','0','0','0','0','Durnholde Veteran - Random Say on Aggro'),
('1786002','17860','0','0','100','7','4000','7000','3600','10000','11','15581','1','0','0','0','0','0','0','0','0','0','Durnholde Veteran - Cast Sinister Strike'),
('1786003','17860','9','0','100','7','0','5','5000','7000','11','15582','1','0','0','0','0','0','0','0','0','0','Durnholde Veteran - Cast Backstab'),
('1786004','17860','2','0','100','6','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Durnholde Veteran - Flee at 15% HP'),
('1786005','17860','6','0','10','6','0','0','0','0','1','-1282','-1280','-1281','0','0','0','0','0','0','0','0','Durnholde Veteran - Random Say on Death'),
('1786006','17860','0','0','100','7','4000','8000','10000','12000','11','41389','1','1','0','0','0','0','0','0','0','0','Durnholde Veteran - Cast Kidney Shot'),
('1786007','17860','4','0','100','6','0','0','0','0','11','29651','0','0','0','0','0','0','0','0','0','0','Durnholde Veteran - Casts Dual Wield on Aggro');

-- Lordaeron Sentry 17815,20537
UPDATE `creature_template` SET `maxlevel`='66',`minhealth`='17151',`maxhealth`='17469',`minmana`='0',`maxmana`='0',`armor`='5600',`equipment_id`='1802',`lootid`='17820',`pickpocketloot`='17820' WHERE `entry` = 17815; -- 575 803
UPDATE `creature_template` SET `speed`='1.48',`lootid`='17820',`pickpocketloot`='17820',`equipment_id`='1802',`mindmg`='1844',`maxdmg`='2083',`spell1`='0' WHERE `entry` = 20537; -- 784 1652 s1 16100
DELETE FROM `creature_template_addon` WHERE `entry` IN (17815,20537);
INSERT INTO `creature_template_addon` VALUES
(17815,0,0,512,0,4097,0,0,''),
(20537,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17815;
INSERT INTO `creature_ai_scripts` VALUES
('1781501','17815','0','0','100','7','1000','1000','4000','4000','21','1','0','0','40','2','0','0','0','0','0','0','Lordaeron Sentry - Start Combat Movement and Set Melee Weapon Model'),
('1781502','17815','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Lordaeron Sentry - Random Say OOC'),
('1781503','17815','4','0','10','38','0','0','0','0','1','-1275','-1276','-1277','22','1','0','0','21','0','0','0','Lordaeron Sentry - Random Say and Set Phase 1 and Stop Movement on Aggro'),
('1781504','17815','9','1','100','3','5','30','2000','2000','11','16100','1','0','40','2','0','0','21','0','0','0','Lordaeron Sentry (Normal) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('1781505','17815','9','1','100','5','5','30','2000','2000','11','22907','1','0','40','2','0','0','21','0','0','0','Lordaeron Sentry (Heroic) - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('1781506','17815','2','0','100','6','15','0','0','0','21','1','0','0','25','0','0','0','1','-47','0','0','Lordaeron Sentry - Start Movement and Flee at 15% HP'),
('1781507','17815','9','1','100','6','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Lordaeron Sentry - Start Movement and Set Melee Weapon Model and Set Phase 0 (Phase 1)'),
('1781508','17815','7','0','100','6','0','0','0','0','22','1','0','0','40','1','0','0','21','1','0','0','Lordaeron Sentry - Set Phase 1 and Set Melee Weapon Model on Evade'),
('1781509','17815','6','0','10','38','0','0','0','0','1','-1279','-1280','-1281','1','-1280','-1281','-1282','1','-1279','-1280','-1282','Lordaeron Sentry - Random Say on Death'),
('1781510','17815','9','0','100','7','5','15','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Lordaeron Sentry - Stop Combat Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

-- update 1801 equipinfo!
-- Lordaeron Watchman 17814,20538
UPDATE `creature` SET `spawntimesecs`='7200' WHERE `id` IN (17814,17815);
UPDATE `creature_template` SET `maxlevel`='66',`minhealth`='17151',`maxhealth`='17469',`minmana`='0',`maxmana`='0',`armor`='5600',`equipment_id`='1801',`lootid`='17819',`pickpocketloot`='17819' WHERE `entry` = 17814; -- 575 803
UPDATE `creature_template` SET `speed`='1.48',`lootid`='17819',`pickpocketloot`='17819',`equipment_id`='1801',`mindmg`='2219',`maxdmg`='2652',`spell1`='0',`spell2`='0' WHERE `entry` = 20538; -- 784 1652 s1 12169 s2 11976
DELETE FROM `creature_template_addon` WHERE `entry` IN (17814,20538);
INSERT INTO `creature_template_addon` VALUES
(17814,0,0,512,0,4097,0,0,''),
(20538,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17814;
INSERT INTO `creature_ai_scripts` VALUES
('1781401','17814','9','0','100','7','0','5','6200','14100','11','11976','1','0','0','0','0','0','0','0','0','0','Lordaeron Watchman - Cast Strike'),
('1781402','17814','0','0','100','7','7000','11000','11000','18000','11','12169','0','1','0','0','0','0','0','0','0','0','Lordaeron Watchman - Cast Shield Block'),
('1781403','17814','2','0','100','6','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Lordaeron Watchman - Flee at 15% HP'),
('1781404','17814','6','0','10','6','0','0','0','0','1','-1285','-1287','0','0','0','0','0','0','0','0','0','Lordaeron Watchman - Random Say on Death');

-- epoch_hunter Transformation NPCs should not have `equipment_id` !
-- Tarren Mill Guardsman 18092,20545
UPDATE `creature_template` SET `modelid_A2`=18249,`modelid_H2`=18249,`minhealth`='18345',`armor`='6200',`lootid`='17819',`pickpocketloot`='17819',`mindmg`='575',`maxdmg`='803',`equipment_id`='0',`AIName` = 'EventAI' WHERE `entry` = 18092; -- 196 201
UPDATE `creature_template` SET `modelid_A2`=18249,`modelid_H2`=18249,`speed` = '1.48',`lootid`='17819',`pickpocketloot`='17819',`mindmg`='2389',`maxdmg`='3005',`equipment_id`='0' WHERE `entry` = 20545; -- 733 1964 s1 16856 s2 15749 s3 33133
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18092;
INSERT INTO `creature_ai_scripts` VALUES
('1809201','18092','4','0','10','6','0','0','0','0','1','-1283','-1284','0','0','0','0','0','0','0','0','0','Tarren Mill Guardsman - Random Say on Aggro'),
('1809202','18092','9','0','100','6','8','25','10000','15000','11','15749','1','0','0','0','0','0','0','0','0','0','Tarren Mill Guardsman - Cast Shield Charge'),
('1809203','18092','9','0','100','7','0','5','9000','13000','11','16856','1','0','0','0','0','0','0','0','0','0','Tarren Mill Guardsman - Cast Mortal Strike'),
('1809204','18092','6','0','10','6','0','0','0','0','1','-1285','-1286','-1287','0','0','0','0','0','0','0','0','Tarren Mill Guardsman - Random Say on Death');

-- Tarren Mill Protector 18093,20547
-- equipment 8020?
UPDATE `creature_template` SET `modelid_A`=18265,`modelid_H`=18265,`modelid_A2`=18267,`modelid_H2`=18267,`equipment_id`=0,`minhealth`='15176',`armor`='6200',`lootid`='17833',`pickpocketloot`='17833' WHERE `entry` = 18093; -- 196 201
UPDATE `creature_template` SET `modelid_A`=18265,`modelid_H`=18265,`modelid_A2`=18267,`modelid_H2`=18267,`baseattacktime`=1400,`equipment_id`=0,`minlevel`='71',`armor`='7100',`speed`='1.48',`lootid`='17833',`pickpocketloot`='17833',`spell1`='0',`spell2`='0',`spell3`='0',`spell4`='0' WHERE `entry` = 20547; -- 1172 1911 s1 29380 s2 15496 s3 32588 s4 17843
DELETE FROM `creature_template_addon` WHERE `entry` IN (18093,20547);
INSERT INTO `creature_template_addon` VALUES
(18093,0,0,512,0,4097,0,0,''),
(20547,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 18093;
INSERT INTO `creature_ai_scripts` VALUES
('1809301','18093','0','0','100','7','3200','9100','12100','18100','11','32588','1','32','0','0','0','0','0','0','0','0','Tarren Mill Protector - Cast Concussion Blow'),
('1809302','18093','14','0','100','7','5600','40','9600','12700','11','17843','6','1','0','0','0','0','0','0','0','0','Tarren Mill Protector (Normal) - Cast Flash Heal on Friendlies'),
('1809303','18093','14','0','100','7','7600','40','7600','9600','11','17138','6','1','0','0','0','0','0','0','0','0','Tarren Mill Protector (Heroic) - Cast Flash Heal on Friendlies'),
('1809304','18093','0','0','100','7','5000','7000','9000','13000','11','15496','1','0','0','0','0','0','0','0','0','0','Tarren Mill Protector - Cast Cleave'),
('1809305','18093','0','0','100','7','11000','20000','17000','22000','11','17234','1','0','0','0','0','0','0','0','0','0','Tarren Mill Protector - Cast Shadow Shock'),
('1809306','18093','0','0','100','7','3000','9000','15000','20000','11','29380','0','1','0','0','0','0','0','0','0','0','Tarren Mill Protector - Cast Cleanse'),
('1809307','18093','2','0','100','7','50','0','15000','20000','11','31976','0','33','0','0','0','0','0','0','0','0','Tarren Mill Protector - Cast Shadow Shield at 50% HP'),
('1809308','18093','14','0','100','7','3000','30','10000','15000','11','29380','6','1','0','0','0','0','0','0','0','0','Tarren Mill Protector - Cast Cleanse on Friendlies');

-- Tarren Mill Lookout 18094,20546
UPDATE `creature_template` SET `modelid_A`=18252,`modelid_H`=18252,`modelid_A2`=18263,`modelid_H2`=18263,`armor`=4800,`equipment_id`=0 WHERE `entry` = 18094;
UPDATE `creature_template` SET `modelid_A`=18252,`modelid_H`=18252,`modelid_A2`=18263,`modelid_H2`=18263,`minlevel`=71,`speed` = '1.48',`baseattacktime`=1400,`lootid`=18094,`pickpocketloot`=18094,`equipment_id` = '0',`equipment_id`=0 WHERE `entry` = 20546;

-- Tarren Mill Guardsman 23175,23181
UPDATE `creature_template` SET `heroic_entry` = 23181,`modelid_A2`=18249,`modelid_H2`=18249,`armor`=6200,`speed` = '1.48',`equipment_id` = '1801' WHERE `entry` = 23175;
UPDATE `creature_template` SET `modelid_H`=18247,`modelid_A2`=18249,`modelid_H2`=18249,`minlevel`='71',`maxlevel`='72',`minmana`='0',`maxmana`='0',`minhealth`='28712',`maxhealth`='28893',`armor`='7068',`mindmg`='2389',`maxdmg`='3005',`baseattacktime` = '1400', `faction_A`='1748',`faction_H`='1748',`speed` = '1.48',`unit_flags`='1',`equipment_id` = '1801' WHERE `entry` = 23181;

-- Tarren Mill Guardsman 23176,23182
UPDATE `creature_template` SET `heroic_entry` = 23182,`modelid_A2`=18249,`modelid_H2`=18249,`armor`=6200,`speed` = '1.48',`equipment_id` = '1801' WHERE `entry` = 23176;
UPDATE `creature_template` SET `modelid_H`=18247,`modelid_A2`=18249,`modelid_H2`=18249,`minlevel`='71',`maxlevel`='72',`minmana`='0',`maxmana`='0',`minhealth`='28712',`maxhealth`='28893',`armor`='7068',`mindmg`='2389',`maxdmg`='3005',`baseattacktime` = '1400', `faction_A`='1748',`faction_H`='1748',`speed` = '1.48',`unit_flags`='1',`equipment_id` = '1801' WHERE `entry` = 23182;

-- Tarren Mill Lookout 23177,23183
UPDATE `creature_template` SET `modelid_A`=18252,`modelid_H`=18252,`modelid_A2`=18263,`modelid_H2`=18263,`heroic_entry` = 23183,`minmana`='3309',`maxmana`='3309',`armor`=4800,`speed` = '1.48',`equipment_id` = '8008' WHERE `entry` = 23177;
UPDATE `creature_template` SET `modelid_A`=18252,`modelid_H`=18252,`modelid_A2`=18263,`modelid_H2`=18263,`minlevel`='71',`maxlevel`='72',`minmana`='3309',`maxmana`='3309',`minhealth`='22892',`maxhealth`='23110',`armor`='5289',`mindmg`='1038',`maxdmg`='2129',`baseattacktime` = '1400', `faction_A`='1748',`faction_H`='1748',`speed` = '1.48',`unit_flags`='1',`equipment_id` = '8008' WHERE `entry` = 23183;

-- Tarren Mill Lookout 23178,23184
UPDATE `creature_template` SET `modelid_A`=18252,`modelid_H`=18252,`modelid_A2`=18263,`modelid_H2`=18263,`heroic_entry` = 23184,`minmana`='3309',`maxmana`='3309',`armor`=4800,`speed` = '1.48',`equipment_id` = '8008' WHERE `entry` = 23178;
UPDATE `creature_template` SET `modelid_A`=18252,`modelid_H`=18252,`modelid_A2`=18263,`modelid_H2`=18263,`minlevel`='71',`maxlevel`='72',`minmana`='3309',`maxmana`='3309',`minhealth`='22892',`maxhealth`='23110',`armor`='5289',`mindmg`='1038',`maxdmg`='2129',`baseattacktime` = '1400', `faction_A`='1748',`faction_H`='1748',`speed` = '1.48',`unit_flags`='1',`equipment_id` = '8008' WHERE `entry` = 23184;

-- Tarren Mill Protector 23179,23185
UPDATE `creature_template` SET `modelid_A`=18265,`modelid_H`=18265,`modelid_A2`=18267,`modelid_H2`=18267,`heroic_entry` = 23185,`armor`=6200,`speed` = '1.48',`baseattacktime`=2000,`equipment_id`=8020 WHERE `entry` = 23179;
UPDATE `creature_template` SET `modelid_A`=18265,`modelid_H`=18265,`modelid_A2`=18267,`modelid_H2`=18267,`minlevel`='71',`maxlevel`='72',`minmana`='15399',`maxmana`='16545',`minhealth`='23110',`maxhealth`='23456',`armor`='7100',`mindmg`='1172',`maxdmg`='1911',`baseattacktime` = '2000', `faction_A`='1748',`faction_H`='1748',`speed` = '1.48',`unit_flags`='1',`equipment_id` = '8020' WHERE `entry` = 23185;

-- Tarren Mill Protector 23180,23186
UPDATE `creature_template` SET `modelid_A`=18265,`modelid_H`=18265,`modelid_A2`=18267,`modelid_H2`=18267,`heroic_entry` = 23186,`armor`=6200,`speed` = '1.48',`baseattacktime`=2000 WHERE `entry` = 23180;
UPDATE `creature_template` SET `modelid_A`=18265,`modelid_H`=18265,`modelid_A2`=18267,`modelid_H2`=18267,`minlevel`='71',`maxlevel`='72',`minmana`='15399',`maxmana`='16545',`minhealth`='23110',`maxhealth`='23456',`armor`='7100',`mindmg`='1172',`maxdmg`='1911',`baseattacktime` = '2000', `faction_A`='1748',`faction_H`='1748',`speed` = '1.48', `unit_flags`='1',`equipment_id` = '8020' WHERE `entry` = 23186;

-- 18170

-- 18171

-- 18172

-- ====================
-- Bosses
-- ====================

-- Lieutenant Drake 17848,20535
UPDATE `creature_template` SET `armor`='6200',`mindmg`='1200',`maxdmg`='1500',`mechanic_immune_mask`='787431423' WHERE `entry` = 17848;
UPDATE `creature_template` SET `armor`='7400',`speed`='1.48',`mindmg`='4319',`maxdmg`='4991',`pickpocketloot`='17848',`mechanic_immune_mask`='787431423',`rank`='1' WHERE `entry` = 20535; -- 6500 8500
UPDATE `creature_template` SET `equipment_id`='8007' WHERE `entry` IN (17848,20535);
DELETE FROM `creature_equip_template` WHERE `entry` = 8007;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8007,20195,0,0,218171394,0,0,256,0,0);

-- Captain Skarloc 17862,20521
UPDATE `creature_template` SET `armor`='6200',`mindmg`='900',`maxdmg`='1200',`equipment_id`='1450' WHERE `entry` = 17862;
UPDATE `creature_template` SET `armor`='7400',`speed`='1.48',`mindmg`='5412 ',`maxdmg`='5849',`pickpocketloot`='17862',`mechanic_immune_mask`='787431423',`equipment_id`='1450',`rank`='1' WHERE `entry` = 20521;

-- Epoch Hunter 18096,20531
UPDATE `creature_template` SET `mindmg`='1600',`maxdmg`='1900' WHERE `entry` = 18096;
UPDATE `creature_template` SET `armor`='7400',`speed`='1.48',`mindmg`='5585',`maxdmg`='6317',`rank`='1' WHERE `entry` = 20531;

-- Erozion & Brazen

--  Don Carlos 28126,28132,91598 hier liegt glaub ich ein fehler vor.
DELETE FROM `creature` WHERE `guid` = 16800080;
UPDATE `creature` SET `spawnmask`='3',`curhealth`='0' WHERE `guid` = 16800079;
UPDATE `creature_template` SET `armor`='6200',`mindmg`='915',`maxdmg`='2286',`baseattacktime`='1200',`mechanic_immune_mask`='787169275',`unit_flags`='134252608' WHERE `entry` = 91598;
UPDATE `creature_template` SET `armor`='7400',`mindmg`='2286',`maxdmg`='6858',`baseattacktime`='0',`mechanic_immune_mask`='787169275',`unit_flags`='134252608' WHERE `entry` = 28132;
UPDATE `creature_addon` SET `mount`='2402' WHERE `guid` = 16800079;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 91598;
INSERT INTO `creature_ai_scripts` VALUES
('9159800','91598','0','0','100','7','4000','4000','4000','4000','21','1','0','0','0','0','0','0','0','0','0','0','Don Carlos - Start Combat Movement and Start Melee'),
('9159801','91598','4','0','100','6','0','0','0','0','22','1','0','0','17','154','0','0','19','134217728','0','0','Don Carlos - Set Phase 1 and Dismount on Aggro'),
('9159802','91598','4','0','100','6','0','0','0','0','12','28163','1','300','39','10','0','0','0','0','0','0','Don Carlos - Summon Guerrero on Aggro'),
('9159803','91598','9','1','100','3','5','30','1500','1500','11','16100','1','7','40','2','0','0','21','0','0','0','Don Carlos (Normal) - Cast Shoot and Stop Movement and Set Ranged Weapon Model (Phase 1)'),
('9159804','91598','9','1','100','5','5','30','1500','1500','11','16496','1','7','40','2','0','0','21','0','0','0','Don Carlos (Heroic) - Cast Shoot and Stop Movement and Set Ranged Weapon Model (Phase 1)'),
('9159805','91598','9','1','100','7','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Don Carlos - Start Combat Movement and Set Melee Weapon Model and Start Melee and Set Phase 0 Below 5 Yards (Phase 1)'),
('9159806','91598','0','0','100','3','9000','14000','10000','15000','11','12024','4','1','0','0','0','0','0','0','0','0','Don Carlos (Normal) - Cast Net'),
('9159807','91598','0','0','100','5','9000','14000','10000','15000','11','50762','4','1','0','0','0','0','0','0','0','0','Don Carlos (Heroic) - Cast Net'),
('9159808','91598','7','0','100','6','0','0','0','0','21','1','0','0','43','2402','0','0','0','0','0','0','Don Carlos - Start Movement and Mount on Evade'),
('9159809','91598','5','0','100','7','0','0','0','0','1','-9859','-9858','0','0','0','0','0','0','0','0','0','Don Carlos - Yell on Kill'),
('9159810','91598','6','0','100','6','0','0','0','0','1','-9857','0','0','0','0','0','0','0','0','0','0','Don Carlos - Yell on Death');

-- Guerrero needs heroic template 
DELETE FROM `creature_ai_scripts` WHERE `id` = 2816303;
INSERT INTO `creature_ai_scripts` VALUES
('2816303','28163','7','0','100','6','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Guerrero - Despawn on Evade');

-- ======================================================
-- Visuals & Positioning & Movement
-- ======================================================

UPDATE `creature` SET `spawntimesecs` = 7200 WHERE `id` IN (17840,22128); -- 1500 patrols nerfed spawntime

UPDATE `creature` SET `position_x`='2230.2180', `position_y`='95.7559', `position_z`='91.7011', `orientation`='1.0774',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83457;
UPDATE `creature` SET `position_x`='2222.5979', `position_y`='88.7325', `position_z`='91.5879', `orientation`='2.6207',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83977;

-- fucking animals
UPDATE `creature` SET `position_x`='2263.5405', `position_y`='681.1868', `position_z`='52.5143' WHERE `guid` = 83850;
UPDATE `creature` SET `position_x`='2295.9206', `position_y`='649.4188', `position_z`='58.5106' WHERE `guid` = 83849;
UPDATE `creature` SET `position_x`='2313.4550', `position_y`='584.9873', `position_z`='51.4871' WHERE `guid` = 83848;
UPDATE `creature` SET `position_x`='2278.7788', `position_y`='493.2092', `position_z`='40.2923' WHERE `guid` = 83847;

-- Behind Houses, need last house+housed pats
UPDATE `creature` SET `position_x`='2064.3532', `position_y`='138.0448', `position_z`='53.3321', `orientation`='2.6708',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83924;
UPDATE `creature` SET `position_x`='2066.3603', `position_y`='143.7087', `position_z`='53.4870', `orientation`='2.6708',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83958;

UPDATE `creature` SET `position_x`='2166.2172', `position_y`='265.5596', `position_z`='52.9383', `orientation`='2.2585',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83934;
UPDATE `creature` SET `position_x`='2170.6582', `position_y`='269.2080', `position_z`='53.0677', `orientation`='2.2585',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83959;

-- under bridge
UPDATE `creature` SET `position_x`='2131.8378', `position_y`='179.7291', `position_z`='54.0583', `orientation`='2.4902',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83944;
UPDATE `creature` SET `position_x`='2129.9321', `position_y`='177.2296', `position_z`='54.2305', `orientation`='2.4902',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83945;
UPDATE `creature` SET `orientation`='5.6357' WHERE `guid` = 83943;

-- peon
UPDATE `creature` SET `position_x`='2062.6606', `position_y`='112.4434', `position_z`='55.4020',`orientation`='2.0400' WHERE `guid` = 83919;
UPDATE `creature` SET `position_x`='2058.4582', `position_y`='117.3054', `position_z`='55.4039',`orientation`='5.6096' WHERE `guid` = 83920;
DELETE FROM `creature_addon` WHERE `guid` IN (11420,11417,11404,11390,11501,11502,11499,11488,11424,11416,11415,11414,83457,83977,83914,83915,83456,83919,83920,83970);
INSERT INTO `creature_addon` VALUES
-- sleep
(83457,0,0,0,3,4097,0,0,NULL),
(83977,0,0,0,3,4097,0,0,NULL),
(83919,0,0,0,3,4097,0,0,NULL),
(83920,0,0,0,3,4097,0,0,NULL),
-- chop
(83970,0,0,0,0,4097,69,0,NULL),
-- work
(11416,0,0,0,0,4097,234,0,NULL),
(11415,0,0,0,0,4097,234,0,NULL),
(11414,0,0,0,0,4097,234,0,NULL),
(11424,0,0,0,0,4097,234,0,NULL),

(11488,0,0,0,0,4097,234,0,NULL),
(11499,0,0,0,0,4097,234,0,NULL),
(11501,0,0,0,0,4097,234,0,NULL),
(11502,0,0,0,0,4097,234,0,NULL),
(11390,0,0,0,0,4097,234,0,NULL),
(11404,0,0,0,0,4097,234,0,NULL), 
(11417,0,0,0,0,4097,234,0,NULL),
(11420,0,0,0,0,4097,234,0,NULL),

-- sit
(83914,0,0,0,1,4097,0,0,NULL),
(83915,0,0,0,1,4097,0,0,NULL),
(83456,0,0,0,1,4097,0,0,NULL);

-- 31931

-- 38497

-- 38051

SET @GUID := 40161;
SET @POINT := 0;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@GUID,@POINT := @POINT + 1, XXX, YYY, ZZZ,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2023.5502, 1040.2321, 26.2825,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2041.4444, 1033.0207, 28.0258,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2060.5043, 1024.9743, 31.0522,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2082.5676, 1025.4198, 32.6669,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2115.0964, 1037.1940, 35.3105,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2147.2958, 1040.2392, 40.2173,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2231.1408, 1014.8381, 53.5992,15000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2147.2958, 1040.2392, 40.2173,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2115.0964, 1037.1940, 35.3105,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2082.5676, 1025.4198, 32.6669,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2060.5043, 1024.9743, 31.0522,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2041.4444, 1033.0207, 28.0258,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 2023.5502, 1040.2321, 26.2825,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1999.4035, 1039.0671, 25.2571,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1980.4165, 1030.7443, 25.0123,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1962.0742, 1034.9116, 23.3120,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1939.3199, 1052.0250, 20.2088,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1916.9570, 1053.2131, 18.9520,15000,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1939.3199, 1052.0250, 20.2088,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1962.0742, 1034.9116, 23.3120,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1980.4165, 1030.7443, 25.0123,0,0,0,100,0),
(@GUID,@POINT := @POINT + 1, 1999.4035, 1039.0671, 25.2571,0,0,0,100,0);

UPDATE `creature` SET `movementtype`='2' WHERE `guid` = 31799;
SET @NPC := 31799;
SET @PATH := @NPC;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'1989.1328','269.9029','67.0582',0,0,0,100,0),
(@PATH,2,'1950.7413','220.4822','68.1479',0,0,0,100,0),
(@PATH,3,'1926.4708','187.9020','67.7167',0,0,0,100,0),
(@PATH,4,'1950.7413','220.4822','68.1479',0,0,0,100,0),
(@PATH,5,'1989.1328','269.9029','67.0582',0,0,0,100,0),
(@PATH,6,'2002.2683','283.5443','66.1293',0,0,0,100,0);

UPDATE `creature` SET `movementtype`='0',`spawndist` = 0 WHERE `guid` = 83930;
UPDATE `creature` SET `movementtype`='2',`spawndist` = 0 WHERE `guid` = 83931;
SET @NPC := 83931;
SET @PATH := @NPC;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'2098.4592','75.6454','53.1011',0,0,0,100,0),
(@PATH,2,'2084.6132','97.3700','53.0240',0,0,0,100,0),
(@PATH,3,'2091.3298','112.6363','52.4410',0,0,0,100,0),
(@PATH,4,'2104.4335','115.7826','53.3999',0,0,0,100,0),
(@PATH,5,'2113.2922','98.6639','52.5478',0,0,0,100,0),
(@PATH,6,'2110.5908','82.4466','53.3391',0,0,0,100,0),
(@PATH,7,'2106.3842','72.6309','52.7401',0,0,0,100,0);

UPDATE `creature` SET `movementtype`='0',`spawndist` = 0 WHERE `guid` = 83932;
UPDATE `creature` SET `movementtype`='2',`spawndist` = 0 WHERE `guid` = 83933;
SET @NPC := 83933;
SET @PATH := @NPC;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'2142.1411','42.8234','52.6519',0,0,0,100,0),
(@PATH,2,'2161.2336','33.6550','52.4506',10000,0,0,100,0),
(@PATH,3,'2142.1411','42.8234','52.6519',0,0,0,100,0),
(@PATH,4,'2122.4543','61.7468','52.5050',0,0,0,100,0),
(@PATH,5,'2114.0104','113.1287','52.4415',0,0,0,100,0),
(@PATH,6,'2108.9946','153.7105','52.4411',0,0,0,100,0),
(@PATH,7,'2121.8815','167.0272','52.6761',0,0,0,100,0),
(@PATH,8,'2123.3269','174.1710','52.8848',10000,0,0,100,0),
(@PATH,9,'2121.8815','167.0272','52.6761',0,0,0,100,0),
(@PATH,10,'2108.9946','153.7105','52.4411',0,0,0,100,0),
(@PATH,11,'2114.0104','113.1287','52.4415',0,0,0,100,0),
(@PATH,12,'2122.4543','61.7468','52.5050',0,0,0,100,0);

UPDATE `creature` SET `movementtype`='0',`spawndist` = 0 WHERE `guid` = 83950;
UPDATE `creature` SET `movementtype`='2',`spawndist` = 0 WHERE `guid` = 83951; 
SET @NPC := 83951;
SET @PATH := @NPC;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'2185.2966','219.3567','52.4614',0,0,0,100,0),
(@PATH,2,'2206.0375','223.4078','52.4410',0,0,0,100,0),
(@PATH,3,'2212.5874','238.4148','52.6749',0,0,0,100,0),
(@PATH,4,'2186.2216','251.7567','52.6279',0,0,0,100,0),
(@PATH,5,'2169.1970','237.9315','52.4469',0,0,0,100,0),
(@PATH,6,'2157.1564','213.0630','52.8079',0,0,0,100,0),
(@PATH,7,'2138.6787','196.7278','52.4413',0,0,0,100,0),
(@PATH,8,'2130.2419','185.6176','52.8783',10000,0,0,100,0),
(@PATH,9,'2138.6787','196.7278','52.4413',0,0,0,100,0),
(@PATH,10,'2157.1564','213.0630','52.8079',0,0,0,100,0);

UPDATE `creature` SET `position_x`='2218.7082', `position_y`='45.4916', `position_z`='65.0238', `orientation`='2.6865',`spawndist`='0',`movementtype`='2' WHERE `guid` = 83963;
UPDATE `creature` SET `position_x`='2216.1157', `position_y`='43.5302', `position_z`='64.9912', `orientation`='2.6865',`spawndist`='0',`movementtype`='0' WHERE `guid` = 83962;
SET @NPC := 83963;
SET @PATH := @NPC;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'2195.5468','53.1180','65.0885',0,0,0,100,0),
(@PATH,2,'2172.4086','64.4389','65.2330',0,0,0,100,0),
(@PATH,3,'2163.8271','77.3777','65.7777',0,0,0,100,0),
(@PATH,4,'2151.3286','90.8969','70.0680',0,0,0,100,0),
(@PATH,5,'2146.9484','118.3120','76.0335',15000,0,0,100,0),
(@PATH,6,'2151.3286','90.8969','70.0680',0,0,0,100,0),
(@PATH,7,'2163.8271','77.3777','65.7777',0,0,0,100,0),
(@PATH,8,'2172.4086','64.4389','65.2330',0,0,0,100,0),
(@PATH,9,'2195.5468','53.1180','65.0885',0,0,0,100,0), 
(@PATH,10,'2220.7866','46.8486','65.0684',0,0,0,100,0),
(@PATH,11,'2217.0515','46.3174','65.0676',15000,0,0,100,0);

UPDATE `creature` SET `movementtype`='0',`spawndist` = 0 WHERE `guid` = 83940;
UPDATE `creature` SET `movementtype`='2',`spawndist` = 0 WHERE `guid` = 83941;
SET @NPC := 83941;
SET @PATH := @NPC;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'2205.8188','105.1063','89.4554',0,0,0,100,0),
(@PATH,2,'2199.7976','108.4979','89.4554',0,0,0,100,0),
(@PATH,3,'2201.2526','115.7598','89.4554',0,0,0,100,0),
(@PATH,4,'2208.6616','128.9851','87.9560',0,0,0,100,0),
(@PATH,5,'2179.3981','145.3745','88.2165',10000,0,0,100,0),
(@PATH,6,'2208.6616','128.9851','87.9560',0,0,0,100,0),
(@PATH,7,'2217.8764','145.6893','89.4548',0,0,0,100,0),
(@PATH,8,'2221.4472','147.8570','89.4548',0,0,0,100,0),
(@PATH,9,'2227.6362','144.4029','89.4548',0,0,0,100,0),
(@PATH,10,'2228.0495','138.8155','89.4548',0,0,0,100,0),
(@PATH,11,'2220.1213','124.4039','89.4549',0,0,0,100,0),
(@PATH,12,'2209.5603','105.8696','89.4548',0,0,0,100,0);

UPDATE `creature` SET `movementtype`='0',`spawndist` = 0 WHERE `guid` = 83910;
UPDATE `creature` SET `movementtype`='2',`spawndist` = 0 WHERE `guid` = 83911;
SET @NPC := 83911;
SET @PATH := @NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'2109.0908','220.3088','65.3646',0,0,0,100,0), 
(@PATH,2,'2108.8244','218.3886','65.2718',0,0,0,100,0),
(@PATH,3,'2073.0605','176.8052','65.4811',0,0,0,100,0),
(@PATH,4, 2075.4682, 170.9876, 65.2548,10000,0,0,100,0),
(@PATH,5,'2073.0605','176.8052','65.4811',0,0,0,100,0),
(@PATH,6,'2108.8244','218.3886','65.2718',0,0,0,100,0),
(@PATH,7,'2109.0908','220.3088','65.3646',0,0,0,100,0),
(@PATH,8, 2116.3686, 222.6754, 64.9093,10000,0,0,100,0);

UPDATE `creature` SET `movementtype`='0',`spawndist` = 0 WHERE `guid` = 83907;
UPDATE `creature` SET `movementtype`='2',`spawndist` = 0 WHERE `guid` = 83906;
SET @NPC := 83906;
SET @PATH := @NPC;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'2132.9138','176.3118','68.7873',0,0,0,100,0),
(@PATH,2,'2145.1372','167.1323','64.8979',0,0,0,100,0),
(@PATH,3,'2139.4523','155.3669','67.0943',0,0,0,100,0),
(@PATH,4,'2139.2253','134.9036','73.2475',0,0,0,100,0),
(@PATH,5,'2144.3818','123.6578','76.0074',0,0,0,100,0),
(@PATH,6,'2159.6130','132.5165','82.3744',0,0,0,100,0),
(@PATH,7,'2173.2021','148.8258','87.9175',0,0,0,100,0),
(@PATH,8,'2184.4614','167.5238','88.3149',0,0,0,100,0),
(@PATH,9,'2201.1945','175.1245','90.3368',0,0,0,100,0), 
(@PATH,10,'2218.7570','179.4011','96.8204',10000,0,0,100,0),
(@PATH,11,'2201.1945','175.1245','90.3368',0,0,0,100,0), 
(@PATH,12,'2184.4614','167.5238','88.3149',0,0,0,100,0),
(@PATH,13,'2173.2021','148.8258','87.9175',0,0,0,100,0),
(@PATH,14,'2159.6130','132.5165','82.3744',0,0,0,100,0),
(@PATH,15,'2144.3818','123.6578','76.0074',0,0,0,100,0),
(@PATH,16,'2139.2253','134.9036','73.2475',0,0,0,100,0),
(@PATH,17,'2139.4523','155.3669','67.0943',0,0,0,100,0),
(@PATH,18,'2145.1372','167.1323','64.8979',0,0,0,100,0),
(@PATH,19,'2132.9138','176.3118','68.7873',0,0,0,100,0),
(@PATH,20,'2118.0200','187.5052','68.8050',10000,0,0,100,0);

-- ======================================================
-- Group Linking
-- ======================================================

DELETE FROM `creature_formations` WHERE `leaderguid` IN (48021,84001,48022,31799,83934,83959,83924,83958,31931,47895,47896,38497,48008,48009,38051,48007,48006,44653,44656,40161,48010,48011,83987,83989,83939,83986,83966,83967,83968,83969,83962,83963,83955,83956,83950,83951,83948,83949,83942,83943,83944,83945,83932,83933,83930,83931,83929,83928,83926,83927,83923,83922,83912,83913,83901,83902,83905,83908,83903,83904,83973,83974,83975,83976,83971,83972,83997,83996,83940,83941,83935,83936,83937,83938,83907,83906,83910,83911);
DELETE FROM `creature_formations` WHERE `memberguid` IN (48021,84001,48022,31799,83934,83959,83924,83958,31931,47895,47896,38497,48008,48009,38051,48007,48006,44653,44656,40161,48010,48011,83987,83989,83939,83986,83966,83967,83968,83969,83962,83963,83955,83956,83950,83951,83948,83949,83942,83943,83944,83945,83932,83933,83930,83931,83929,83928,83926,83927,83923,83922,83912,83913,83901,83902,83905,83908,83903,83904,83973,83974,83975,83976,83971,83972,83997,83996,83940,83941,83935,83936,83937,83938,83907,83906,83910,83911);
INSERT INTO `creature_formations` VALUES

(31799,31799,100,360,2),
(31799,48021,2,1,2),
(31799,48022,2,5,2),

(83934,83934,100,360,2),
(83934,83959,100,360,2),

(83924,83924,100,360,2),
(83924,83958,100,360,2),

(31931,31931,100,360,2),
(31931,47895,2,1,2),
(31931,47896,2,5,2),

(38497,38497,100,360,2),
(38497,48008,2,1,2),
(38497,48009,2,5,2),

(38051,38051,100,360,2),
(38051,48007,2,1,2),
(38051,48006,2,5,2),

(44653,44653,100,360,2),
(44653,44656,100,360,2),

(40161,40161,100,360,2),
(40161,48010,2,0.78,2),
(40161,48011,2,5.50,2),

(83987,83987,100,360,2),
(83987,83989,100,360,2),

(83939,83939,100,360,2),
(83939,83986,100,360,2),

(83966,83966,100,360,2),
(83966,83967,100,360,2),
(83966,83968,100,360,2),
(83966,83969,100,360,2), 

(83963,83963,100,360,2),
(83963,83962,2,1.57,2),

(83955,83955,100,360,2),
(83955,83956,100,360,2),

(83951,83951,100,360,2),
(83951,83950,2,1.57,2),

(83948,83948,100,360,2),
(83948,83949,100,360,2),

(83942,83942,100,360,2),
(83942,83943,100,360,2),
(83942,83944,100,360,2),
(83942,83945,100,360,2), 

(83933,83933,100,360,2),
(83933,83932,2,1.57,2),

(83931,83931,100,360,2),
(83931,83930,2,1.57,2),

(83928,83928,100,360,2),
(83928,83929,100,360,2),

(83926,83926,100,360,2),
(83926,83927,100,360,2),

(83922,83922,100,360,2),
(83922,83923,100,360,2),

(83912,83912,100,360,2),
(83912,83913,100,360,2),

(83901,83901,100,360,2),
(83901,83902,100,360,2),

(83905,83905,100,360,2),
(83905,83908,100,360,2),

(83903,83903,100,360,2),
(83903,83904,100,360,2),

(83973,83973,100,360,2),
(83973,83974,100,360,2),
(83973,83975,100,360,2),
(83973,83976,100,360,2), 

(83971,83971,100,360,2),
(83971,83972,100,360,2),
(83971,83997,100,360,2),
(83971,83996,100,360,2), 

(83941,83941,100,360,2),
(83941,83940,2,1.57,2),

(83935,83935,100,360,2),
(83935,83936,100,360,2),
(83935,83937,100,360,2),
(83935,83938,100,360,2), 

(83906,83906,100,360,2),
(83906,83907,2,1.57,2),

(83911,83911,100,360,2),
(83911,83910,2,1.57,2);

-- ======================================================
-- Respawn Linking
-- ======================================================

DELETE FROM `creature_linked_respawn` WHERE `guid` IN (83996,83910,83911,83950,83951,83930,83931,83962,83963,83906,83907,83940,83941,83932,83933);
INSERT INTO `creature_linked_respawn` VALUES

(83910,83950),
(83911,83950),

(83950,83950),
(83951,83950),

(83930,83950),
(83931,83950),

(83962,83950),
(83963,83950),

(83906,83950),
(83907,83950),

(83940,83950),
(83941,83950),

(83932,83950),
(83933,83950);

-- =====================
-- Gameobjects
-- =====================

-- Barrels
UPDATE `gameobject` SET `spawntimesecs`='7200' WHERE `id` = 182589;
UPDATE `gameobject_template` SET `data5`='1',`data6`='7200' WHERE `entry` = 182589;

-- =====================
-- Miscellaneous
-- =====================

-- für iwas verwenden
DELETE FROM `creature_equip_template` WHERE `entry` = 8021;
INSERT INTO `creature_equip_template` VALUES
(8021,36960,2161,0,218171138,234948100,0,3,1038,0);

-- Broggok 17380,18601
UPDATE `creature_template` SET `speed`='1.48',`unit_flags`='64',`mechanic_immune_mask`='787431423',`armor`='7400',`mindmg`='3977',`maxdmg`='4238' WHERE `entry` = 18601; -- 7,953 - 8,476

-- Shade of Aran 16524
UPDATE `creature_template` SET `mindmg`='2295',`maxdmg`='2760',`baseattacktime`='2000',`speed`='2.00',`flags_extra` = `flags_extra`|2 WHERE `entry` = 16524; -- 3060 3679 -- 4,590 - 5,519
UPDATE `creature_model_info` SET `bounding_radius` = 0, `combat_reach` = 0 WHERE `modelid` = 16621; -- 0,5508 2,7
UPDATE `spell_target_position` SET `target_position_x` = -11164.900391, `target_position_y` = -1912.199951, `target_position_z` = 232.009003, `target_orientation` = 2.222600 WHERE `id`  = 39567; -- 39567	532	-11164,5	-1909,56	232,009	2,23979

-- Position Aran in the middle of the room because he doesnt port self at the moment to the middle where the trigger is positioned. Should be moving while OOC and IC.
UPDATE `creature` SET `position_x`='-11164.9257',`position_y`='-1912.1971',`position_z`='232.0090',`orientation`='2.2226' WHERE `guid` = 57440;

-- if teleport is fixed implement this from sniff data:
SET @GUID := 57440;
UPDATE `creature` SET `MovementType`='2' WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (57440, 1, -11172.5, -1900.33, 232.009, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57440, 2, -11180.2, -1905.71, 232.009, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57440, 3, -11178.1, -1920.48, 232.009, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57440, 4, -11162.5, -1925.34, 232.009, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57440, 5, -11148.3, -1910.55, 232.009, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (57440, 6, -11168.7, -1896.08, 232.009, 0, 0, 0, 0, 0);

-- Blizzard (Shade of Aran) 17161
UPDATE `creature_template` SET `speed` = 1, `unit_flags`='33554432',`flags_extra`='130' WHERE `entry` = 17161; -- 1,125 33554432 128

DELETE FROM `creature_addon` WHERE `guid` = 49805;

-- Arena Organizer in Shattrath
UPDATE `creature_template` SET `npcflag` = 262145, `subname` = 'Arena Organizer' WHERE `entry` = 25991; -- 1048577 Arena Battlemaster

-- All Pooled GOs
UPDATE `gameobject` SET `spawntimesecs` = 60 WHERE `guid` IN (3491328,
3491329,3491330,3491331,3491332,3491829,3491830,3491831,3491832,3493184,3493185,3493186,3493187,3493418,3493421,3495496,3495497,
3495498,3495499,3495500,3495501,3495502,3495503,3495563,3495564,3495565,3495566,3495567,3495568,3495569,3495570,3495571,3495572,
3495573,3495574,3495575,3495576,3495577,3495578,3497590,3497609,3497618,3497621,3497624,3497625,3497626,3497627,3497628,3497629,
3497632,3497633,3497634,3497677,3497678,3497679,3497680,3497681,3498285,3498286,3498287,3498288,3498289,3498295,3504426,3504437,
3504438,3504763,3504764,3504956,3504958,3505111);

-- Watchkeeper Gargolmar 17306,18436
-- heroic - hits tank for 2K.
UPDATE `creature_template` SET `mindmg`='750',`maxdmg`='1000' WHERE `entry` = 17306;
UPDATE `creature_template` SET `armor`='7400',`mindmg`='3622',`maxdmg`='4272',`pickpocketloot`='17306' WHERE `entry` = 18436; -- 4000 5145 -- 7,243 - 8,544

-- Hellfire Watcher <Watchkeeper's Subordinate> 17309,18058
UPDATE `creature_template` SET `mindmg`='370',`maxdmg`='486' WHERE `entry` = 17309; --  113 229 -- 370 - 486
UPDATE `creature_template` SET `equipment_id` ='1024',`mindmg`='932',`maxdmg`='1145', `baseattacktime` = 0, `pickpocketloot` = 17309 WHERE `entry` = 18058; -- 306 732 2000 -- 1,863 - 2,289
UPDATE `creature_ai_scripts` SET `event_param3`='12000',`event_param4`='15000' WHERE `id` = 1730904;
UPDATE `creature_ai_scripts` SET `event_param4`='15000' WHERE `id` IN (1730902,1730903);
DELETE FROM `creature_ai_scripts` WHERE `id` = 1730905;
INSERT INTO `creature_ai_scripts` VALUES
('1730905','17309','14','0','100','7','1000','40','12000','15000','11','8362','6','0','0','0','0','0','0','0','0','0','Hellfire Watcher - Casts Renew on Friendlies');

-- Omor the Unscarred 17308,18433
UPDATE `creature` SET `position_x` = -1122.34, `position_y` = 1718.41, `position_z` = 89.4315, `orientation` = 3.75246 WHERE `guid` = 62087;
UPDATE `creature_template` SET `mindmg`='1250',`maxdmg`='1500',`baseattacktime`='1400', `unit_flags` = 68 WHERE `entry` = 17308;
UPDATE `creature_template` SET `minhealth` = 132642, `maxhealth` = 132642, `armor`='5954',`resistance5`='200',`mindmg`='4572',`maxdmg`='5715', `unit_flags` = 68 WHERE `entry` = 18433; -- 82642 2852 3387

-- Fiendish Hound 17540,18056
UPDATE `creature_template` SET `minlevel`='62',`maxlevel`='62',`armor`='3450',`speed`='1.20',`mindmg`='710',`maxdmg`='1060',`baseattacktime`='1289',`AIName` = 'EventAI' WHERE `entry` = 17540;
UPDATE `creature_template` SET `armor`='5474',`mindmg`='2293',`maxdmg`='2973',`baseattacktime`='0' WHERE `entry` = 18056; -- 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17540;
INSERT INTO `creature_ai_scripts` VALUES
('1754001','17540','9','0','100','5','0','30','6000','12000','11','15785','4','0','0','0','0','0','0','0','0','0','Fiendish Hound (Heroic) - Cast Mana Burn'),
('1754002','17540','2','0','100','3','75','0','7000','10000','11','35748','4','0','0','0','0','0','0','0','0','0','Fiendish Hound - Cast Drain Life at 75% HP'), -- 30%
('1754003','17540','7','0','100','5','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Fiendish Hound - Die on Evade');

-- Most Texts are readable for players
UPDATE `creature_ai_texts` SET `language` = 0 WHERE `entry` IN (-101,-102,-105,-181,-672,-925,-926,-1110); -- 1
UPDATE `creature_ai_texts` SET `language` = 0 WHERE `entry` IN (-104,-329,-330,-331,-332); -- 6
UPDATE `creature_ai_texts` SET `language` = 0 WHERE `entry` = -1349; -- 12
UPDATE `creature_ai_texts` SET `language` = 0 WHERE `entry` IN (-549,-924,-1109); -- 7
UPDATE `creature_ai_texts` SET `language` = 0 WHERE `entry` IN (-113,-114,-947); -- 10
UPDATE `creature_ai_texts` SET `language` = 0 WHERE `entry` = -927; -- 33
UPDATE `creature_ai_texts` SET `language` = 0 WHERE `entry` IN (-817,-818); -- 14

DELETE FROM `creature` WHERE `guid` IN (16202, 12850);

-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='8358',`maxdmg`='9926',`baseattacktime`='1400',`resistance3`= 0,`mechanic_immune_mask`='1073692671' WHERE `entry` = 21863; -- 3003 6139 2000 1 -- 16,716 - 19,852
-- pre 2.1 1073692671 post patch 2.1 `mechanic_immune_mask`='1073561599'
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 21863;
INSERT INTO `creature_ai_scripts` VALUES
('2186301','21863','9','0','100','3','0','100','4000','8000','11','38655','1','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Poison Bolt Volley'),
-- ('2186302','21863','9','0','100','3','0','5','18900','18900','11','38650','0','1','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'),
('2186303','21863','9','0','100','3','0','5','5000','10000','12','22250','1','20000','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Spawn Rancid Mushroom'); -- 17990

-- Rancid Mushroom 22250
UPDATE `creature_template` SET `modelid_A`='11686',`modelid_H`='11686',`faction_A`='14',`faction_H`='14',`armor`='6800',`flags_extra`='0',`unit_flags`= 393220,`speed`='0.0001',`mindmg`='0',`maxdmg`='0',`attackpower`='0',`resistance3`= 0 WHERE `entry` = 22250; -- 7999 7999 35 35 0 128 4
DELETE FROM `creature_template_addon` WHERE `entry` = 22250; 
INSERT INTO `creature_template_addon` VALUES (22250,0,0,0,0,0,0,0,'38652 0 38652 1 31690 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22250;
INSERT INTO `creature_ai_scripts` VALUES
('2225001','22250','0','0','100','3','1000','1000','3000','3000','11','31698','0','7','0','0','0','0','0','0','0','0','Rancid Mushroom - Cast Grow'),
('2225002','22250','6','0','100','2','0','0','0','0','11','38652','0','7','0','0','0','0','0','0','0','0','Rancid Mushroom - Cast Spore Cloud on Death'),
('2225003','22250','0','0','100','2','20000','20000','0','0','11','38652','0','7','37','0','0','0','0','0','0','0','Rancid Mushroom - Cast Spore Cloud and Die');

-- Underbog Mushroom 17990,20189
UPDATE `creature_template` SET `unit_flags`= 393220,`resistance3`= 0 WHERE `entry` IN (17990,20189); -- 0
DELETE FROM `creature_template_addon` WHERE `entry` IN (17990,20189); 
INSERT INTO `creature_template_addon` VALUES
(17990,0,0,0,0,0,0,0,'34168 0 34168 1'),
(20189,0,0,0,0,0,0,0,'34168 0 34168 1');

-- Magtheridons Head 2.1 cond 6, value 67 / 469
DELETE FROM `creature_loot_template` WHERE `item` IN (32385,32386);
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (17257, 32386, 100, 0, 1, 1, 6, 67, 0); -- 100
INSERT INTO `creature_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (17257, 32385, 100, 0, 1, 1, 6, 469, 0);

-- Magtheridons Black Sack of Gems and Pit Lord's Satchel 2.4
UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 0 WHERE `entry` = 17257 AND `item` IN (34846,34845);

-- Captain Fairmount
UPDATE `creature` SET `modelid` = 1855 WHERE `id` = 3393;

DELETE FROM `creature` WHERE `guid` = 6584423;
DELETE FROM `creature` WHERE `guid` BETWEEN 16777256 AND 16777268;

UPDATE `creature` SET `spawndist` = 0, `MovementType` = 0 WHERE `guid` IN (58272);
-- 300secs way to go
UPDATE `creature` SET `spawntimesecs` = 300 WHERE `id` IN (18260,18262,20798,22144,22143,22148,20561,19764,16964);

SET @GUID := 80849;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,NULL);
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
REPLACE INTO `waypoint_data` VALUES (80849, 1, -9785.24, -880.61, 39.6131, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 2, -9792.77, -872.876, 39.5751, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 3, -9793.2, -867.623, 39.4678, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 4, -9774.36, -847.313, 39.7919, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 5, -9767.83, -847.814, 39.6107, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 6, -9752.2, -863.369, 39.4772, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 7, -9753.51, -871.917, 39.5511, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 8, -9769.58, -886.229, 39.4867, 0, 0, 0, 0, 0);
REPLACE INTO `waypoint_data` VALUES (80849, 9, -9776.63, -887.336, 39.5384, 0, 0, 0, 0, 0);

DELETE FROM `creature_formations` WHERE `leaderguid` = 80849;
INSERT INTO `creature_formations` VALUES
(80849, 80849, 100, 360, 2),
(80849, 80848, 2, 0.78, 2),
(80849, 80850, 2, 5.50, 2);

-- Underbog Lurker 20188
UPDATE `creature_template` SET `mindmg`='4012',`maxdmg`='4764' WHERE `entry` = 20188;
-- Bog Giant 20164
UPDATE `creature_template` SET `mindmg`='6686',`maxdmg`='7941' WHERE `entry` = 20164;
-- Swamplord Musel'ek 20183
UPDATE `creature_template` SET `mindmg`='4171',`maxdmg`='4950' WHERE `entry` = 20183;
-- Auchenai Monk 20299
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` = 20299;

-- --------------------
-- Vanilla quests
-- ---------------------

-- [QUEST] A Dip in the Moonwell (9433)
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`=30009 AND `spell_effect`=29989 AND `type`=0;
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES 
(30009, 29989, 0, 'Control Robotron 3000');

-- [QUEST] Proving Allegiance (409)
DELETE FROM `quest_end_scripts` WHERE `id`=410;
INSERT INTO `quest_end_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES 
('410', '10', '1946', '180000', '2483.71', '22.11', '26.98', '3.151972');

UPDATE `gameobject` SET `spawntimesecs` = 7200, `spawnmask` = 0 WHERE `id` IN (153451,153453);

SET @NPC := 56752;
SET @PATH := 56752; -- 1359
UPDATE `creature_addon` SET `path_id`= 56752 WHERE `guid` = 56752;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-11137.99,`position_y`=-1945.277,`position_z`=49.89039 WHERE `guid`=@NPC;
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-11137.99, -1945.277, 49.89039,0,0,0,100,0),
(@PATH,2,-11129.64, -1948.63, 50.14034,0,0,0,100,0), 
(@PATH,3,-11125.21, -1949.558, 50.13778,0,0,0,100,0), 
(@PATH,4,-11110.95, -1946.991, 50.13663,0,0,0,100,0),
(@PATH,5,-11102.87, -1942.1, 50.13157,0,0,0,100,0), 
(@PATH,6,-11099.54, -1937.292, 50.13352,0,0,0,100,0), 
(@PATH,7,-11097.69, -1933.512, 50.13876,0,0,0,100,0), 
(@PATH,8,-11097.51, -1933.438, 50.13683,0,0,0,100,0),
(@PATH,9,-11099.44, -1937.166, 50.13335,0,0,0,100,0), 
(@PATH,10,-11102.06, -1941.6, 50.13267,0,0,0,100,0), 
(@PATH,11,-11110.1, -1946.833, 50.13472,0,0,0,100,0), 
(@PATH,12,-11124.7, -1949.601, 50.13889,0,0,0,100,0),
(@PATH,13,-11135.64, -1946.267, 50.13834,0,0,0,100,0);

UPDATE `creature_formations` SET `groupAI` = 2 WHERE `leaderguid` = 85083;

UPDATE `creature_template` SET `mindmg`='6550',`maxdmg`='7820',`speed`='2.40' WHERE `entry` = 19044; -- 7369 8797 -- 14,737 - 17,594
UPDATE `creature_model_info` SET `bounding_radius` = 7, `combat_reach` = 7 WHERE `modelid` = 18698; -- 4 10 growth
UPDATE `script_texts` SET `type` = 2, `content_loc3` = 'brüllt!' WHERE `entry` = -1565020;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17395;
INSERT INTO `creature_ai_scripts` VALUES (1739501, 17395, 0, 0, 100, 7, 5000, 5000, 1000, 1000, 39, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Constant Call for Help');
INSERT INTO `creature_ai_scripts` VALUES (1739502, 17395, 0, 0, 100, 7, 3000, 6000, 15000, 20000, 11, 30853, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Summon Seductress');
INSERT INTO `creature_ai_scripts` VALUES (1739503, 17395, 0, 0, 100, 7, 6000, 9000, 15000, 20000, 11, 30851, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Summon Felhound Manastalker');
INSERT INTO `creature_ai_scripts` VALUES (1739504, 17395, 4, 0, 100, 2, 0, 0, 0, 0, 11, 15242, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner (Normal) - Cast Fireball and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (1739505, 17395, 9, 5, 80, 3, 0, 40, 3000, 3800, 11, 15242, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner (Normal) - Cast Fireball (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1739506, 17395, 4, 0, 100, 4, 0, 0, 0, 0, 11, 17290, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner (Heroic) - Cast Fireball and Set Phase 1 on Aggro');
INSERT INTO `creature_ai_scripts` VALUES (1739507, 17395, 9, 5, 80, 5, 0, 40, 3000, 3800, 11, 17290, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner (Heroic) - Cast Fireball (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1739508, 17395, 3, 5, 100, 6, 15, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Start Combat Movement and Set Phase 2 when Mana is at 15% (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1739509, 17395, 9, 5, 100, 6, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Start Combat Movement at 35 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1739510, 17395, 9, 5, 100, 6, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Prevent Combat Movement at 15 Yards (Phase 1)');
INSERT INTO `creature_ai_scripts` VALUES (1739511, 17395, 9, 5, 100, 6, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Start Combat Movement Below 5 Yards');
INSERT INTO `creature_ai_scripts` VALUES (1739512, 17395, 3, 3, 100, 7, 100, 30, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Set Phase 1 when Mana is above 30% (Phase 2)');
INSERT INTO `creature_ai_scripts` VALUES (1739513, 17395, 0, 0, 100, 3, 12000, 14000, 6000, 9000, 11, 18399, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner (Normal) - Cast Flamestrike');
INSERT INTO `creature_ai_scripts` VALUES (1739514, 17395, 0, 0, 100, 5, 12000, 14000, 6000, 9000, 11, 16102, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner (Heroic) - Cast Flamestrike');
INSERT INTO `creature_ai_scripts` VALUES (1739515, 17395, 7, 0, 100, 6, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Set Phase to 0 on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17399;
INSERT INTO `creature_ai_scripts` VALUES (1739901, 17399, 0, 0, 100, 7, 1000, 3000, 12800, 12800, 11, 32202, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Seductress - Cast Lash of Pain');
INSERT INTO `creature_ai_scripts` VALUES (1739902, 17399, 0, 0, 100, 7, 3200, 5700, 13700, 13700, 11, 31865, 5, 32, 0, 0, 0, 0, 0, 0, 0, 0, 'Seductress - Cast Seduction');
INSERT INTO `creature_ai_scripts` VALUES (1739903, 17399, 7, 0, 100, 6, 0, 0, 0, 0, 41, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 0, 'Seductress - Despawn on Evade');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17401;
INSERT INTO `creature_ai_scripts` VALUES (1740101, 17401, 0, 0, 100, 7, 1000, 2500, 11100, 11300, 11, 13321, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Felhound Manastalker - Cast Mana Burn');
INSERT INTO `creature_ai_scripts` VALUES (1740102, 17401, 0, 0, 100, 7, 3300, 8700, 12900, 12900, 11, 30849, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Felhound Manastalker - Cast Spell Lock');
INSERT INTO `creature_ai_scripts` VALUES (1740103, 17401, 7, 0, 100, 6, 0, 0, 0, 0, 41, 0, 0, 0, 18, 33554432, 0, 0, 0, 0, 0, 0, 'Felhound Manastalker - Despawn on Evade');

SET @GUID := 62013;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,16777472,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id` IN (1411,@GUID);
INSERT INTO `waypoint_data` VALUES (62013, 1, -1294.61, 1671.99, 67.6775, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 2, -1306.92, 1669.19, 65.5432, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 3, -1316.17, 1666.43, 66.9309, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 4, -1325.66, 1663.59, 68.6933, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 5, -1333.06, 1660.84, 68.7694, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 6, -1341.02, 1656.47, 68.7922, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 7, -1333.15, 1660.58, 68.7765, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 8, -1322.8172, 1665.2110, 68.28718, 0, 0, 0, 100, 0);  -- -1321.47, 1664.95, 68.1255
INSERT INTO `waypoint_data` VALUES (62013, 9, -1309.64, 1668.51, 65.7793, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 10, -1299.97, 1671.23, 66.5435, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62013, 11, -1287.35, 1673.12, 68.7382, 0, 0, 0, 100, 0);

SET @GUID := 62012;
UPDATE `creature` SET `MovementType`= 2, `spawndist` = 0 WHERE `guid` = @GUID;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'18950 0 18950 1');
DELETE FROM `waypoint_data` WHERE `id` IN (1410,@GUID);
INSERT INTO `waypoint_data` VALUES (62012, 1, -1257.71, 1651, 67.9137, 5000, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62012, 2, -1277.2553, 1670.4768, 68.7051, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62012, 3, -1257.71, 1651, 67.9137, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62012, 4, -1249, 1629.44, 68.5386, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62012, 5, -1248.3504, 1603.1793, 68.5528, 0, 0, 0, 100, 0);
INSERT INTO `waypoint_data` VALUES (62012, 6, -1249, 1629.44, 68.5386, 0, 0, 0, 100, 0);

UPDATE `creature_addon` SET `auras` = '18950 0 18950 1' WHERE `guid` IN (200931,200932,200949,200952);

UPDATE `creature` SET `id` = 17269, `equipment_id` = 0 WHERE `guid` = 200911;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17281;
INSERT INTO `creature_ai_scripts` VALUES 
(1728101, 17281, 2, 0, 100, 6, 30, 0, 0, 0, 11, 18501, 0, 0, 1, -46, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - Casts Enrage at 30% HP'),
(1728102, 17281, 4, 0, 100, 6, 0, 0, 0, 0, 11, 29651, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - Casts Dual Wield on Aggro'),
(1728103, 17281, 1, 0, 100, 7, 2000, 2000, 15000, 15000, 17, 159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - Set Stand State OOC'),
(1728104, 17281, 1, 0, 100, 7, 4000, 4000, 15000, 15000, 17, 169, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - Emote Cheer OOC'),
(1728105, 17281, 1, 0, 100, 7, 5700, 5700, 15000, 15000, 17, 159, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - Set Kneel State OOC'),
(1728106, 17281, 0, 0, 100, 7, 10000, 10000, 10000, 10000, 11, 30659, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 'Bonechewer Ripper - Workaround slowly enrage, should be casted by 17478 when they die');

UPDATE `creature_template` SET `mindmg`='3343',`maxdmg`='3971' WHERE `entry` = 18052;
UPDATE `creature_template` SET `mindmg`='300',`maxdmg`='900' WHERE `entry` = 17540;
UPDATE `creature_template` SET `mindmg`='1720',`maxdmg`='2230' WHERE `entry` = 18056;
UPDATE `creature_template` SET `mindmg`='800',`maxdmg`='1600' WHERE `entry` = 17308;
UPDATE `creature_template` SET `mindmg`='2853',`maxdmg`='3387' WHERE `entry` = 18433;

DELETE FROM `creature_loot_template` WHERE `item` = 31878;
DELETE FROM `creature_loot_template` WHERE `entry` IN (16409,16468,17148,17833,17895,18323,18493,18497,18875,20035,20259,20299,20301,20530,20692,21337,21543,21695,21911,21917,22877,23018,23397,24683,24685) AND `mincountOrRef` = -24092;
INSERT INTO `creature_loot_template` VALUES
(16409, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(16468, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(17148, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(17833, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(17895, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(18323, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(18493, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(18497, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(18875, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(20035, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(20259, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(20299, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(20301, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(20530, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(20692, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(21337, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(21543, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(21695, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(21911, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(21917, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(22877, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(23018, 24092, 0.5, 1, -24092, 1, 0, 0, 0), 
(23397, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(24683, 24092, 0.5, 1, -24092, 1, 0, 0, 0),
(24685, 24092, 0.5, 1, -24092, 1, 0, 0, 0);

-- Respawn with correct GUID
DELETE FROM `creature` WHERE `guid` = 93838;
INSERT INTO `creature` VALUES (93838, 21217, 548, 1, 0, 0, 36.956867, -415.168793, -22.3911, 3.03312, 604800, 0, 0, 6905080, 0, 0, 0);-- -21.5911

DELETE FROM `creature_ai_scripts` WHERE `id` = 1653405;
INSERT INTO `creature_ai_scripts` VALUES (1653405, 16534, 1, 0, 100, 0, 10000, 10000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Inoculated Nestlewood Owlkin - Despawn OOC');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16488;
INSERT INTO `creature_ai_scripts` VALUES
('1648801','16488','11','0','100','2','0','0','0','0','42','1','1','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Set Invincible at 1% HP on Spawn'),
('1648802','16488','2','0','100','2','1','0','0','0','11','29880','0','1','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Mana Shield at 1% HP'),
('1648803','16488','9','0','100','3','0','40','6000','10000','11','29885','4','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Arcane Volley'),
('1648804','16488','0','0','100','3','18000','30000','30000','45000','11','29883','4','1','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Blink'), -- 4
('1648805','16488','3','0','100','2','5','0','0','0','42','0','1','0','0','0','0','0','0','0','0','0','Arcane Anomaly - Remove Invincible at 5% Mana'),
('1648806','16488','6','0','100','2','0','0','0','0','11','29882','0','7','0','0','0','0','0','0','0','0','Arcane Anomaly - Cast Loose Mana on Death');

UPDATE creature_template set spell1 = 33561 where entry = 19222;
UPDATE creature_template set spell1 = 33571 where entry = 19225;

UPDATE `item_template` SET `flags`=`flags`|2048 WHERE `entry` = 24099;

-- [Quest] The Blackwood Corrupted (4763)
DELETE FROM `event_scripts` WHERE `id`=3938;
INSERT INTO `event_scripts` (`id`, `command`, `datalong`, `datalong2`, `x`, `y`, `z`, `o`) VALUES 
('3938', '10', '10373', '3000000', '6881.64', '-506.63', '40.14', '2.02');

-- Since the chest for some reason seem to inherit the summoner's faction the player is unable to loot it. 
-- Let the item drop from Xabraxxis for now
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`='-100' WHERE  `entry`=10373 AND `item`=12355;


-- NPC lying down or kneeling, should not move randomly
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(63308,63303,63288,63301);

-- Delete random Strength of Earth Totems on Bloodmyst Isle. How did these get here? :O
DELETE FROM `creature` WHERE `id`=5874;

-- Matis the Cruel
-- His old script broke the already existing core script which also handles quest completion and despawning. Delete old scripts and only do mount and aggro text in DB
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID`=17664;
INSERT INTO `creature_ai_scripts` (`id`, `entryOrGUID`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES 
(1766401, 17664, 4, 0, 100, 0, 0, 0, 0, 0, 1, -17664, 0, 0, 17, 154, 0, 0, 19, 134217728, 0, 0, 'Matis The Cruel - Say and Dismount on Aggro'),
(1766402, 17664, 7, 0, 100, 0, 0, 0, 0, 0, 43, 17408, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Matis The Cruel - Mount on Evade');

-- Movement data from cmangos: https://github.com/cmangos/tbc-db/blob/2a0a0af0cbd277651603011e062bb5b72e7cfcbe/Updates/803_UDB-459_Zone.sql#L63
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid = 63387;
UPDATE `creature_template_addon` SET `path_id`=63387 WHERE `entry`=17664;
DELETE FROM waypoint_data WHERE id = 63387;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z, delay) VALUES
(63387,1,-1917.35,-10929.6,61.541, 0),
(63387,2,-1929.25,-10907.2,62.6743, 0),
(63387,3,-1935.67,-10877.1,64.8566, 0),
(63387,4,-1940.59,-10853.8,69.1685, 0),
(63387,5,-1939.15,-10845.1,71.933, 0),
(63387,6,-1934.67,-10837.7,74.4851, 0),
(63387,7,-1935.73,-10823.3,79.3717, 0),
(63387,8,-1940.26,-10802.2,86.4451, 10000),
(63387,9,-1933.92,-10828.4,77.5937, 0),
(63387,10,-1933.61,-10836.2,74.9683, 0),
(63387,11,-1939.6,-10845.9,71.7024, 0),
(63387,12,-1939.63,-10858.2,68.3036, 0),
(63387,13,-1934.66,-10885.1,64.065, 0),
(63387,14,-1912.98,-10885.2,62.5901, 0),
(63387,15,-1901.3,-10885.7,65.7651, 0),
(63387,16,-1885.29,-10885.9,66.7829, 10000),
(63387,17,-1898.06,-10906.9,64.1897, 0),
(63387,18,-1912.31,-10925.5,61.4623, 0),
(63387,19,-1908.58,-10941.8,61.4612, 0),
(63387,20,-1893.36,-10962.5,61.2537, 0),
(63387,21,-1884.23,-10980.4,60.8326, 0),
(63387,22,-1881.02,-10998,60.5245, 0),
(63387,23,-1883.8,-11019.1,60.0129, 0),
(63387,24,-1886.71,-11046.6,59.313, 0),
(63387,25,-1884.24,-11058.2,59.516, 0),
(63387,26,-1862.52,-11079.7,61.1166, 0),
(63387,27,-1834.24,-11091.9,63.3128, 0),
(63387,28,-1816.24,-11111.9,64.3889, 0),
(63387,29,-1805.47,-11133.9,64.3039, 5000),
(63387,30,-1790.49,-11162.9,64.2675, 0),
(63387,31,-1777.86,-11180.9,64.3316, 0),
(63387,32,-1775.9,-11199.7,63.6491, 0),
(63387,33,-1778.98,-11226.4,61.9235, 0),
(63387,34,-1784.71,-11254.4,59.7856, 0),
(63387,35,-1783.82,-11277.3,58.3305, 0),
(63387,36,-1775.11,-11301.9,57.2286, 0),
(63387,37,-1761.89,-11330.5,56.1889, 0),
(63387,38,-1752.58,-11347.4,55.3093, 0),
(63387,39,-1741.77,-11372,53.8783, 0),
(63387,40,-1734.44,-11407.4,48.6277, 10000),
(63387,41,-1738.91,-11382.6,52.1298, 0),
(63387,42,-1744.32,-11366.7,54.3216, 0),
(63387,43,-1757.38,-11338,55.8696, 0),
(63387,44,-1769.41,-11312.8,56.8602, 0),
(63387,45,-1779.43,-11292.9,57.6417, 0),
(63387,46,-1784.36,-11268.4,58.8302, 0),
(63387,47,-1783.6,-11246.4,60.2839, 0),
(63387,48,-1777,-11213.4,62.9699, 0),
(63387,49,-1775.89,-11192.7,63.7768, 0),
(63387,50,-1783.15,-11174.8,64.1119, 0),
(63387,51,-1797.14,-11150.5,64.4089, 0),
(63387,52,-1810.11,-11123.5,64.1998, 0),
(63387,53,-1820.63,-11106.1,64.2334, 0),
(63387,54,-1836.08,-11091.7,63.1688, 0),
(63387,55,-1863.87,-11078.6,60.9968, 0),
(63387,56,-1884.23,-11058,59.517, 5000),
(63387,57,-1886.05,-11036,59.4273, 0),
(63387,58,-1882.62,-11011.1,60.1273, 0),
(63387,59,-1882.03,-10987.1,60.7278, 0),
(63387,60,-1887.39,-10973.1,60.9613, 0),
(63387,61,-1898.37,-10955.3,61.3482, 0);

UPDATE `gameobject` SET `animprogress` = 100 WHERE `guid` = 313331;

UPDATE `creature_template` SET `flags_extra` = 536870912 WHERE `entry` = 21854;

