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
INSERT INTO `creature_ai_scripts` VALUES (1739510, 17395, 9, 5, 100, 6, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Shadowmoon Summoner - Start Combat Movement at 15 Yards (Phase 1)');
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

UPDATE `gameobject` SET `animprogress` = 100 WHERE `guid` IN (28507,2156689,313331);

UPDATE `creature_template` SET `flags_extra` = 536870912 WHERE `entry` = 21854;

-- https://github.com/Looking4Group/L4G_Core/issues/3132
DELETE FROM creature_loot_template WHERE item = 12236;

-- https://github.com/Looking4Group/L4G_Core/issues/2359
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry`=12579 AND `item`=16190; -- Old: -65

-- Webbed Creature
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id`=17680;
UPDATE `creature_template` SET `flags_extra`=66, `unit_flags`=393220 WHERE `entry`=17680; -- Old: 2, 0

-- Disable rotate for Netherweb Victim
UPDATE `creature_template` SET `unit_flags`=393220 WHERE `entry`=22355; -- Old: 131076

-- Delete more random totem spawns on Bloodmyst Isle
DELETE FROM `creature` WHERE `id`=18795;

-- Despawn adds after 20 sec to prevent insane amounts of adds to be spawned on aggro each time
UPDATE `creature_ai_scripts` SET `event_param1`='0', `event_param2`='0' WHERE  `id`=684602; -- event_type is 4, so there should be no event_params
DELETE FROM `creature_ai_scripts` WHERE  `id`=686604;
INSERT INTO `creature_ai_scripts` (`id`, `entryOrGUID`, `event_type`, `event_param1`, `event_param2`, `action1_type`, `comment`) VALUES 
('686604', '6866', '1', '20000', '20000', '41', 'Defias Bodyguard - Despawn after 20 sec OOC');

-- Group completion for Evil Draws Near
UPDATE `creature_ai_scripts` SET `action1_type`='26',`action1_param1`='10923' WHERE  `id`=2244103;

-- Blood Elf Flight Masters
-- Source: https://github.com/cmangos/tbc-db/blob/18dd605950d0ace090ac7215c276d5ca7226d35f/Updates/442_Fix_Blood_Elf_Flight_Masters.sql
DELETE FROM `creature_template` WHERE `entry`=27946;
INSERT INTO `creature_template` (`entry`, `heroic_entry`, `modelid_A`, `modelid_A2`, `modelid_H`, `modelid_H2`, `name`, `minlevel`, `maxlevel`, `minhealth`, `maxhealth`, `minmana`, `maxmana`, `armor`, `faction_A`, `faction_H`, `npcflag`, `speed`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `baseattacktime`, `rangeattacktime`, `unit_flags`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `class`, `race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `PetSpellDataId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `RacialLeader`, `RegenHealth`, `equipment_id`, `mechanic_immune_mask`, `flags_extra`) VALUES 
('27946', '0', '17547', '0', '17547', '0', 'Silvermoon Dragonhawk', '65', '65', '17742', '17742', '0', '0', '5291', '1603', '1603', '0', '1.48', '1', '1', '601', '843', '0', '278', '2000', '2000', '0', '0', '30', '0', '0', '0', '0', '497', '738', '35', '1', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '12993', '0', '0', 'EventAI', '0', '3', '0', '1', '0', '0', '0');

UPDATE creature_template SET SubName='Dragonhawk Master' WHERE entry IN (16192,16189,26560);

-- Skymaster Sunwing Silvermoon Dragonhawks and Aggro Linking (81728)
DELETE FROM `creature` WHERE `guid` IN (140807,140808);
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('140807','27946','530','1','0','0','7592.39','-6776.33','86.834','4.83017','300','0','0','17742','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('140808','27946','530','1','0','0','7599.98','-6778.44','86.4116','4.19394','300','0','0','17742','0','0','0');

DELETE FROM `creature_formations` WHERE `leaderGUID`=81728;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES 
(81728, 81728, 0, 0, 2),
(81728, 140807, 0, 0, 2),
(81728, 140808, 0, 0, 2);

-- Skymistress Gloaming Silvermoon Dragonhawks and Aggro Linking (56866)
DELETE FROM `creature` WHERE `guid` IN (140809,140810);
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('140809','27946','530','1','0','0','9378.85','-7162.24','8.88681','3.16111','300','0','0','17742','0','0','0');
insert into `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) values('140810','27946','530','1','0','0','9379.6','-7169.83','9.07374','3.03163','300','0','0','17742','0','0','0');

DELETE FROM `creature_formations` WHERE `leaderGUID`=56866;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES 
(56866, 56866, 0, 0, 2),
(56866, 140809, 0, 0, 2),
(56866, 140810, 0, 0, 2);


-- ------------
-- Stop using the ugly core script for quest completion. It made it impossible to script the creature's normal spells
-- ------------

-- Arcane Wraith
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=15273;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 15273;
INSERT INTO `creature_ai_scripts` VALUES
('1527301','15273','8','0','100','0','28734','-1','0','0','16','15468','28734','6','0','0','0','0','0','0','0','0','Arcane Wraith - Quest Credit on Mana Tap Spellhit (Quest: 8346)'),
('1527302','15273','0','0','100','1','10100','16500','12700','24800','11','37361','1','0','0','0','0','0','0','0','0','0','Arcane Wraith - Cast Arcane Bolt');

-- Mana Wyrm
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=15274;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 15274;
INSERT INTO `creature_ai_scripts` VALUES
('1527401','15274','8','0','100','0','28734','-1','0','0','16','15468','28734','6','0','0','0','0','0','0','0','0','Mana Wyrm - Quest Credit on Mana Tap Spellhit (Quest: 8346)'),
('1527402','15274','0','0','75','1','12000','14000','56000','64000','11','25602','1','0','0','0','0','0','0','0','0','0','Mana Wyrm - Cast Faerie Fire');

-- Feral Tender
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=15294;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 15294;
INSERT INTO `creature_ai_scripts` VALUES
('1529401','15294','8','0','100','0','28734','-1','0','0','16','15468','28734','6','0','0','0','0','0','0','0','0','Feral Tender - Quest Credit on Mana Tap Spellhit (Quest: 8346)'),
('1529402','15294','2','0','100','1','50','0','15300','22900','11','31325','0','0','0','0','0','0','0','0','0','0','Feral Tender - Cast Renew at 50% HP');

-- Tainted Arcane Wraith
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=15298;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 15298;
INSERT INTO `creature_ai_scripts` VALUES
('1529801','15298','8','0','100','0','28734','-1','0','0','16','15468','28734','6','0','0','0','0','0','0','0','0','Tainted Arcane Wraith - Quest Credit on Mana Tap Spellhit (Quest: 8346)'),
('1529802','15298','0','0','100','1','9000','18800','21100','32200','11','25603','1','0','0','0','0','0','0','0','0','0','Tainted Arcane Wraith - Cast Slow');

-- Felendren the Banished (3.0.3 Official Data)
DELETE FROM `creature_ai_texts` WHERE `entry`=-110;
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-110','Take heart! Your friends will not long mourn your passing!','8506','0','0','15638','0');

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=15367;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 15367;
INSERT INTO `creature_ai_scripts` VALUES
('1536701','15367','4','0','100','0','0','0','0','0','1','-110','0','0','0','0','0','0','0','0','0','0','Felendren the Banished - Say on Aggro'),
('1536702','15367','0','0','100','1','9100','10600','20500','28600','11','16568','1','0','0','0','0','0','0','0','0','0','Felendren the Banished - Cast Mind Flay');

-- Nova
DELETE FROM `creature_ai_texts` WHERE `entry` IN(-948,-949,-950,-1166,-1167,-1168,-1169);
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-948','holds a sea shell up to her ear.','0','2','0','20244','0'),
('-949','shakes the dirt loose from the shell.','0','2','0','20244','0'),
('-950','picks up a sea shell.','0','2','0','20244','0'),
('-1166','Jane will love this one!','0','0','10','20244','0'),
('-1167','Oooh, a shiny one!','0','0','10','20244','0'),
('-1168','I think I can see the Sunwell from here!','0','0','10','20244','0'),
('-1169','Can you really hear the ocean from one of these shells?','0','0','10','20244','0');

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=20244;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 20244;
INSERT INTO `creature_ai_scripts` VALUES
('2024401','20244','1','0','100','1','10000','10000','110000','110000','1','-948','-949','-950','1','-1166','-1167','-1168','0','0','0','0','Nova - Random say on OOC'),
('2024402','20244','1','0','100','1','60000','60000','160000','160000','1','-949','-950','-948','1','-1166','-1169','-1167','0','0','0','0','Nova - Random say on OOC');

-- Silvermoon Dragonhawk
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=27946;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 27946;
INSERT INTO `creature_ai_scripts` VALUES
('2794601','27946','0','0','100','1','4000','7000','6000','9000','11','37985','0','0','0','0','0','0','0','0','0','0','Silvermoon Dragonhawk - Cast Fire Breath');

-- ---------------------------
-- Bloodmyst isle rework.
-- Big thanks to tbc-db
-- ---------------------------

-- ---------------------------
-- Bristlelimb Shaman
-- ---------------------------
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(62094,62098,62102,62105);

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17320;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17320;
INSERT INTO `creature_ai_scripts` VALUES
('1732001','17320','9','0','100','1','0','20','18000','22000','11','32967','4','0','0','0','0','0','0','0','0','0','Bristlelimb Shaman - Cast Flame Shock'),
('1732002','17320','0','0','100','1','9000','15000','45000','50000','11','32968','0','1','0','0','0','0','0','0','0','0','Bristlelimb Shaman - Cast Scorching Totem'),
('1732003','17320','6','0','8','0','0','0','0','0','32','17702','0','27','0','0','0','0','0','0','0','0','Bristlelimb Shaman - chance to summon High Chief Bristlelimb on Death');

DELETE FROM `creature_ai_summons` WHERE `id`=27;
INSERT INTO `creature_ai_summons` (`id`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`comment` ) VALUES
('27','-2426.937','-12166.98','32.70101','3.68','180000','17702');

-- Lesser Scorching Totem spell
UPDATE `creature_template` SET `spell1`='32969' WHERE  `entry`=18795;
-- ---------------------------
-- Bristlelimb Warrior
-- ---------------------------
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(62112,62117,62118,62124);

-- Missing spawn
DELETE FROM `creature` WHERE `guid`=62120;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES 
(62120, 17321, 530, 1, 0, 0, -2426.64, -12194.9, 33.1445, 2.40855, 300, 0, 0, 198, 0, 0, 0);

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17321;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17321;
INSERT INTO `creature_ai_scripts` VALUES
('1732101','17321','9','0','100','1','0','5','6000','11000','11','11976','1','0','0','0','0','0','0','0','0','0','Bristlelimb Warrior - Cast Strike'),
('1732102','17321','6','0','8','0','0','0','0','0','32','17702','0','27','0','0','0','0','0','0','0','0','Bristlelimb Warrior - chance to summon High Chief Bristlelimb on Death');

-- ---------------------------
-- High Chief Bristlelimb
-- ---------------------------
-- Delete static spawn (He spawns randomly when killing other furbolgs
DELETE FROM `creature` WHERE id = 17702;

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17702;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17702;
INSERT INTO `creature_ai_scripts` VALUES
('1770201','17702','11','0','100','0','0','0','0','0','1','-1406','0','0','0','0','0','0','0','0','0','0','High Chief Bristlelimb - Yell at Spawn'),
('1770202','17702','0','0','100','1','3000','5000','11000','15000','11','20753','0','1','0','0','0','0','0','0','0','0','High Chief Bristlelimb - Cast Demoralizing Roar'),
('1770203','17702','9','0','100','1','0','5','5000','8000','11','15793','1','0','0','0','0','0','0','0','0','0','High Chief Bristlelimb - Cast Maul');

DELETE FROM `creature_ai_texts` WHERE `entry`=-1406;
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1406','Face the wrath of Bristlelimb!','0','1','0','17702','0');

-- ---------------------------
-- Infected Wildkin
-- ---------------------------
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(62126,62129,62136,62137,62142);
UPDATE `creature` SET `spawndist`=10, `MovementType`=1 WHERE `guid` IN(62130,62132,62140);

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17322;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17322;
INSERT INTO `creature_ai_scripts` VALUES
('1732201','17322','9','0','100','1','0','5','9000','15000','11','31282','4','32','0','0','0','0','0','0','0','0','Infected Wildkin - Cast Infected Wound');

-- Contaminated Wildkin
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(62146,62148,62150,62153);
UPDATE `creature` SET `spawndist`=10, `MovementType`=1 WHERE `guid` IN(62143,62144,62147,62151,62152,62154);

-- Irradiated Wildkin
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(62155,62156,62159,62162,62163,62165,62166,62169,62170,62172);
UPDATE `creature` SET `spawndist`=10, `MovementType`=1 WHERE `guid` IN(62157,62158,62161,62164,62167,62168,62171);

-- ---------------------------
-- Blacksilt Forager
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17325;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17325;
INSERT INTO `creature_ai_scripts` VALUES
('1732501','17325','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Blacksilt Forager - Flee at 15% HP');

-- ---------------------------
-- Blacksilt Scout
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17326;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17326;
INSERT INTO `creature_ai_scripts` VALUES
('1732601','17326','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Blacksilt Scout - Flee at 15% HP'),
('1732602','17326','8','0','100','1','30877','-1','0','0','41','2000','0','0','0','0','0','0','0','0','0','0','Blacksilt Scout - despawn on SpellHIT');

-- ---------------------------
-- Blacksilt Tidecaller
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17327;

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17327;
INSERT INTO `creature_ai_scripts` VALUES
('1732701','17327','1','0','100','1','1000','1000','600000','600000','11','12550','0','1','0','0','0','0','0','0','0','0','Blacksilt Tidecaller - Cast Lightning Shield on Spawn'),
('1732702','17327','27','0','100','1','12550','1','15000','30000','11','12550','0','1','0','0','0','0','0','0','0','0','Blacksilt Tidecaller - Cast Lightning Shield on Missing Buff'), -- test
('1732703','17327','14','0','100','1','100','40','16000','21000','11','12160','6','1','0','0','0','0','0','0','0','0','Blacksilt Tidecaller - Cast Rejuvenation on Friendlies'),
('1732704','17327','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Blacksilt Tidecaller - Flee at 15% HP');

-- ---------------------------
-- Blacksilt Shorestriker
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17328;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17328;
INSERT INTO `creature_ai_scripts` VALUES
('1732801','17328','9','0','100','1','0','20','9000','13000','11','31290','1','0','0','0','0','0','0','0','0','0','Blacksilt Shorestriker - Cast Net'),
('1732802','17328','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Blacksilt Shorestriker - Flee at 15% HP');

-- ---------------------------
-- Blacksilt Warrior
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17329;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17329;
INSERT INTO `creature_ai_scripts` VALUES
('1732901','17329','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Blacksilt Warrior - Flee at 15% HP');

-- ---------------------------
-- Blacksilt Seer
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='', `minmana`=790, `maxmana`=938 WHERE `entry`=17330; -- Old mana: 0, 0
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17330;
INSERT INTO `creature_ai_scripts` VALUES
('1733001','17330','0','0','100','1','8000','12000','9000','15000','11','9739','4','0','0','0','0','0','0','0','0','0','Blacksilt Seer - Cast Wrath'), -- test
('1733002','17330','14','0','100','1','100','40','16000','21000','11','12160','6','1','0','0','0','0','0','0','0','0','Blacksilt Seer - Cast Rejuvenation on Friendlies'),
('1733003','17330','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Blacksilt Seer - Flee at 15% HP');

-- ---------------------------
-- Wrathscale Shorestalker
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17331; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17331;
INSERT INTO `creature_ai_scripts` VALUES
('1733101','17331','9','0','100','1','0','5','6000','11000','11','11976','1','0','0','0','0','0','0','0','0','0','Wrathscale Shorestalker - Cast Strike');

-- ---------------------------
-- Wrathscale Screamer
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`=''WHERE `entry`=17333;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17333;
INSERT INTO `creature_ai_scripts` VALUES
('1733301','17333','0','0','100','1','5000','8000','12000','16000','11','31295','1','0','0','0','0','0','0','0','0','0','Wrathscale Screamer - Cast Scream');

-- ---------------------------
-- Wrathscale Marauder
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17334; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17334;
INSERT INTO `creature_ai_scripts` VALUES
('1733401','17334','9','0','100','1','0','5','9000','15000','11','12555','1','0','0','0','0','0','0','0','0','0','Wrathscale Marauder - Cast Pummel');

-- ---------------------------
-- Wrathscale Sorceress
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17336; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17336;
INSERT INTO `creature_ai_scripts` VALUES
(1733601, 17336, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Wrathscale Sorceress - Start Combat Movement and Set Phase to 0 on Spawn'),
(1733602, 17336, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9672, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Wrathscale Sorceress - Cast Frostbolt and Set Phase 1 on Aggro'),
('1733603','17336','9','13','100','1','0','40','3000','4800','11','9672','1','0','0','0','0','0','0','0','0','0','Wrathscale Sorceress - Cast Frostbolt (Phase 1)'),
(1733604, 17336, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Wrathscale Sorceress - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1733605, 17336, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathscale Sorceress - Start Combat Movement at 35 Yards (Phase 1)'),
(1733606, 17336, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathscale Sorceress - Start Combat Movement at 15 Yards (Phase 1)'),
(1733607, 17336, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathscale Sorceress - Start Combat Movement Below 5 Yards (Phase 1)'),
(1733608, 17336, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Wrathscale Sorceress - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1733609','17336','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Wrathscale Sorceress - Set Phase to 0 on Evade');

-- ---------------------------
-- Nazzivus Felsworn
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17339; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17339;
INSERT INTO `creature_ai_scripts` VALUES
(1733901, 17339, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Nazzivus Felsworn - Start Combat Movement and Set Phase to 0 on Spawn'),
(1733902, 17339, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9613, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Nazzivus Felsworn - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('1733903','17339','9','13','100','1','0','40','3000','4800','11','9613','1','0','0','0','0','0','0','0','0','0','Nazzivus Felsworn - Cast Shadow Bolt (Phase 1)'),
(1733904, 17339, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Nazzivus Felsworn - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1733905, 17339, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nazzivus Felsworn - Start Combat Movement at 35 Yards (Phase 1)'),
(1733906, 17339, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nazzivus Felsworn - Start Combat Movement at 15 Yards (Phase 1)'),
(1733907, 17339, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nazzivus Felsworn - Start Combat Movement Below 5 Yards (Phase 1)'),
(1733908, 17339, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Nazzivus Felsworn - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1733909','17339','2','0','100','1','30','0','24000','28000','11','11962','1','1','0','0','0','0','0','0','0','0','Nazzivus Felsworn - Cast Immolate at 30% HP'),
('1733910','17339','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Nazzivus Felsworn - Set Phase to 0 on Evade');

-- ---------------------------
-- Axxarien Shadowstalker
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17340; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17340;
INSERT INTO `creature_ai_scripts` VALUES
('1734001','17340','9','0','100','1','0','30','30000','35000','11','21068','1','0','0','0','0','0','0','0','0','0','Axxarien Shadowstalker - Cast Corruption');

-- ---------------------------
-- Axxarien Trickster
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17341; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17341;
INSERT INTO `creature_ai_scripts` VALUES
('1734101','17341','0','0','100','1','9000','15000','18000','23000','11','15691','1','0','0','0','0','0','0','0','0','0','Axxarien Trickster - Cast Eviscerate');

-- ---------------------------
-- Axxarien Hellcaller
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17342; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17342;
INSERT INTO `creature_ai_scripts` VALUES
('1734201','17342','0','0','100','1','8000','13000','18000','22000','11','11990','4','0','0','0','0','0','0','0','0','0','Axxarien Hellcaller - Cast Rain of Fire');

-- ---------------------------
-- Thistle Lasher
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17343; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17343;
INSERT INTO `creature_ai_scripts` VALUES
('1734301','17343','9','0','100','1','0','5','9000','13000','11','31286','1','0','0','0','0','0','0','0','0','0','Thistle Lasher - Cast Lash');

-- ---------------------------
-- Mutated Tangler
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17346; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17346;
INSERT INTO `creature_ai_scripts` VALUES
('1734601','17346','9','0','100','1','0','30','8000','12000','11','31287','1','0','0','0','0','0','0','0','0','0','Mutated Tangler - Cast Entangling Roots');

-- ---------------------------
-- Grizzled Brown Bear
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17347; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17347;
INSERT INTO `creature_ai_scripts` VALUES
('1734701','17347','9','0','100','1','0','5','9000','13000','11','31279','1','0','0','0','0','0','0','0','0','0','Grizzled Brown Bear - Cast Swipe');

-- ---------------------------
-- Elder Brown Bear
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17348; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17348;
INSERT INTO `creature_ai_scripts` VALUES
('1734801','17348','9','0','100','1','0','5','8000','11000','11','31279','4','0','0','0','0','0','0','0','0','0','Elder Brown Bear - Cast Swipe');

-- ---------------------------
-- Blue Flutterer
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17349; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17349;
INSERT INTO `creature_ai_scripts` VALUES
('1734901','17349','0','0','100','1','7000','10000','15000','19000','11','36332','1','0','0','0','0','0','0','0','0','0','Blue Flutterer - Cast Rake');

-- ---------------------------
-- Royal Blue Flutterer
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17350; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17350;
INSERT INTO `creature_ai_scripts` VALUES
('1735001','17350','0','0','100','1','7000','10000','15000','19000','11','36332','1','0','0','0','0','0','0','0','0','0','Royal Blue Flutterer - Cast Rake');

-- ---------------------------
-- Corrupted Stomper
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17353; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17353;
INSERT INTO `creature_ai_scripts` VALUES
('1735301','17353','9','0','100','1','0','8','9000','14000','11','31277','1','0','0','0','0','0','0','0','0','0','Corrupted Stomper - Cast Stomp');

-- ---------------------------
-- Fouled Water Spirit
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17358; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17358;
INSERT INTO `creature_ai_scripts` VALUES
(1735801, 17358, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - Start Combat Movement and Set Phase to 0 on Spawn'),
(1735802, 17358, 4, 0, 100, 0, 0, 0, 0, 0, 11, 31281, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - Cast Bloodbolt and Set Phase 1 on Aggro'),
('1735803','17358','9','5','100','1','0','40','3200','4800','11','31281','1','0','0','0','0','0','0','0','0','0','Fouled Water Spirit - Cast Bloodbolt (Phase 1)'),
(1735804, 17358, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1735805, 17358, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - Start Combat Movement at 35 Yards (Phase 1)'),
(1735806, 17358, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - Start Combat Movement at 15 Yards (Phase 1)'),
(1735807, 17358, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - Start Combat Movement Below 5 Yards (Phase 1)'),
(1735808, 17358, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Fouled Water Spirit - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1735809','17358','9','0','100','1','0','5','9000','18000','11','31280','4','33','0','0','0','0','0','0','0','0','Fouled Water Spirit - Cast Bloodmyst Chill'),
('1735810','17358','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Fouled Water Spirit - Set Phase to 0 on Evade');

-- ---------------------------
-- Tel'athion the Impure
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17359; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17359;
INSERT INTO `creature_ai_scripts` VALUES
(1735901, 17359, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Start Combat Movement and Set Phase to 0 on Spawn'),
(1735902, 17359, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9672, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Cast Frostbolt and Set Phase 1 on Aggro'),
('1735903','17359','9','5','100','1','0','40','3000','4800','11','9672','1','0','0','0','0','0','0','0','0','0','Tel\'athion the Impure - Cast Frostbolt (Phase 1)'),
('1735904','17359','0','5','100','1','11000','15000','13000','16000','11','15736','4','1','0','0','0','0','0','0','0','0','Tel\'athion the Impure - Cast Arcane Missiles (Phase 1)'),
(1735905, 17359, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1735906, 17359, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Start Combat Movement at 35 Yards (Phase 1)'),
(1735907, 17359, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Start Combat Movement at 15 Yards (Phase 1)'),
(1735908, 17359, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Start Combat Movement Below 5 Yards (Phase 1)'),
(1735909, 17359, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Tel\'athion the Impure - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1735910','17359','9','0','100','1','0','8','13000','17000','11','11831','0','1','0','0','0','0','0','0','0','0','Tel\'athion the Impure - Cast Frost Nova'),
('1735911','17359','0','0','100','1','9000','18000','15000','19000','11','13339','4','1','0','0','0','0','0','0','0','0','Tel\'athion the Impure - Cast Fire Blast'),
('1735912','17359','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Tel\'athion the Impure - Set Phase to 0 on Evade');

-- ---------------------------
-- Zevrax
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17494; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17494;
INSERT INTO `creature_ai_scripts` VALUES
(1749401, 17494, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - Start Combat Movement and Set Phase to 0 on Spawn'),
(1749402, 17494, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20791, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Zevrax - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('1749403','17494','9','5','100','1','0','40','3000','4800','11','20791','1','0','0','0','0','0','0','0','0','0','Zevrax - Cast Shadow Bolt (Phase 1)'),
(1749404, 17494, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Zevrax - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1749405, 17494, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - Start Combat Movement at 35 Yards (Phase 1)'),
(1749406, 17494, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - Start Combat Movement at 15 Yards (Phase 1)'),
(1749407, 17494, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - Start Combat Movement Below 5 Yards (Phase 1)'),
(1749408, 17494, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Zevrax - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1749409','17494','0','0','100','1','9000','14000','17000','21000','11','17227','4','33','0','0','0','0','0','0','0','0','Zevrax - Cast Curse of Weakness'),
('1749410','17494','0','0','100','1','15000','18000','30000','35000','11','21068','4','1','0','0','0','0','0','0','0','0','Zevrax - Cast Corruption'),
('1749411','17494','9','0','100','1','0','30','21000','25000','11','11962','5','1','0','0','0','0','0','0','0','0','Zevrax - Cast Corruption at 30% HP'),
('1749412','17494','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Zevrax - Set Phase to 0 on Evade');

-- ---------------------------
-- Cruelfin
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17496; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17496;
INSERT INTO `creature_ai_scripts` VALUES
('1749601','17496','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Cruelfin - Flee at 15% HP');

-- https://github.com/cmangos/tbc-db/blob/cff248f0b40e2d22100d18062a74eb91ff829e6c/Updates/SpinOnTop/168_udb_backports_commits.sql#L198
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid = 63004;
UPDATE `creature_template_addon` SET `path_id`=63004 WHERE `entry`=17496;
DELETE FROM waypoint_data WHERE id = 63004;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z) VALUES
(63004,1,-2814.57,-11604.2,1.48152),
(63004,2,-2813.34,-11569.2,1.84373),
(63004,3,-2809.57,-11538.9,2.85442),
(63004,4,-2809.68,-11507.7,3.70625),
(63004,5,-2815.36,-11462.8,3.47233),
(63004,6,-2824.25,-11435.3,4.53325),
(63004,7,-2828.94,-11413.9,3.7831),
(63004,8,-2830.4,-11381,2.4203),
(63004,9,-2832.08,-11343.7,2.53179),
(63004,10,-2824.77,-11286.7,2.63238),
(63004,11,-2831.14,-11322.5,2.82903),
(63004,12,-2831.72,-11350.5,2.4931),
(63004,13,-2830.79,-11389,2.72528),
(63004,14,-2828.68,-11420.4,3.83855),
(63004,15,-2823.76,-11439.8,4.3306),
(63004,16,-2814.89,-11466.9,3.40746),
(63004,17,-2808.68,-11508.2,3.71919),
(63004,18,-2809.46,-11540.9,2.74078),
(63004,19,-2812.99,-11577.2,1.52412),
(63004,20,-2812.85,-11610.6,1.64333),
(63004,21,-2809.82,-11634.9,1.90057),
(63004,22,-2803.9,-11665.7,1.61544),
(63004,23,-2810.12,-11632.1,1.95185);

-- ---------------------------
-- Myst Spinner
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17522; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17522;
INSERT INTO `creature_ai_scripts` VALUES
('1752201','17522','9','0','100','1','0','30','12000','15000','11','745','1','0','0','0','0','0','0','0','0','0','Myst Spinner - Cast Web');

-- ---------------------------
-- Myst Leecher
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17523; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17523;
INSERT INTO `creature_ai_scripts` VALUES
('1752301','17523','9','0','100','1','0','5','12000','16000','11','31288','4','32','0','0','0','0','0','0','0','0','Myst Leecher - Cast Leech Poison');

-- ---------------------------
-- Enraged Ravager
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17527; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17527;
INSERT INTO `creature_ai_scripts` VALUES
('1752701','17527','9','0','100','1','0','5','5000','8000','11','3242','1','0','0','0','0','0','0','0','0','0','Enraged Ravager - Cast Ravage'),
('1752702','17527','2','0','100','0','30','0','0','0','11','15716','0','1','1','-106','0','0','0','0','0','0','Enraged Ravager - Cast Enrage at 30% HP');

-- ---------------------------
-- Veridian Broodling
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17589; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17589;
INSERT INTO `creature_ai_scripts` VALUES
(1758901, 17589, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement and Set Phase to 0 on Spawn'),
(1758902, 17589, 4, 0, 100, 0, 0, 0, 0, 0, 11, 21067, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Cast Poison Bolt and Set Phase 1 on Aggro'),
('1758903','17589','9','5','100','1','0','30','2500','4000','11','21067','1','0','0','0','0','0','0','0','0','0','Veridian Broodling - Cast Poison Bolt (Phase 1)'),
(1758904, 17589, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1758905, 17589, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement at 35 Yards (Phase 1)'),
(1758906, 17589, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement at 15 Yards (Phase 1)'),
(1758907, 17589, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement Below 5 Yards (Phase 1)'),
(1758908, 17589, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1758909','17589','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Veridian Broodling - Set Phase to 0 on Evade');

-- ---------------------------
-- Razormaw
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17592; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17592;
INSERT INTO `creature_ai_scripts` VALUES
('1759201','17592','0','0','100','1','5000','8000','7000','10000','11','8873','1','0','0','0','0','0','0','0','0','0','Razormaw - Cast Flame Breath'),
('1759202','17592','9','0','100','1','0','5','5000','7000','11','31279','1','0','0','0','0','0','0','0','0','0','Razormaw - Cast Swipe'),
('1759203','17592','0','0','100','1','15000','18000','17000','21000','11','14100','0','1','0','0','0','0','0','0','0','0','Razormaw - Cast Terrifying Roar');

-- ---------------------------
-- Sunhawk Spy
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17604; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17604;
INSERT INTO `creature_ai_scripts` VALUES
('1760401','17604','0','0','100','1','1000','3000','12000','16000','11','13730','0','0','0','0','0','0','0','0','0','0','Sunhawk Spy - Cast Demoralizing Shout'),
('1760402','17604','9','0','100','1','0','5','6000','9000','11','31827','1','0','0','0','0','0','0','0','0','0','Sunhawk Spy - Cast Heroic Strike'),
('1760403','17604','0','0','100','1','4000','6000','9000','14000','11','31734','1','33','0','0','0','0','0','0','0','0','Sunhawk Spy - Cast Mark of the Sunhawk'),
('1760404','17604','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Sunhawk Spy - Flee at 15% HP');

-- ---------------------------
-- Sunhawk Reclaimer
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17606; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17606;
INSERT INTO `creature_ai_scripts` VALUES
('1760601','17606','1','0','100','1','1000','1000','1800000','1800000','11','12544','0','1','0','0','0','0','0','0','0','0','Sunhawk Reclaimer - Cast Frost Armor on Spawn'),
(1760602, 17606, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Reclaimer - Start Combat Movement and Set Phase to 0 on Spawn'),
(1760603, 17606, 4, 0, 100, 0, 0, 0, 0, 0, 11, 19816, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Sunhawk Reclaimer - Cast Fireball and Set Phase 1 on Aggro'),
('1760604','17606','9','13','100','1','0','40','3000','4500','11','19816','1','0','0','0','0','0','0','0','0','0','Sunhawk Reclaimer - Cast Fireball (Phase 1)'),
(1760605, 17606, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Sunhawk Reclaimer - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1760606, 17606, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Reclaimer - Start Combat Movement at 35 Yards (Phase 1)'),
(1760607, 17606, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Reclaimer - Start Combat Movement at 15 Yards (Phase 1)'),
(1760608, 17606, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Reclaimer - Start Combat Movement Below 5 Yards (Phase 1)'),
(1760609, 17606, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Reclaimer - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1760610','17606','9','0','100','1','0','5','7000','10000','11','6595','1','1','0','0','0','0','0','0','0','0','Sunhawk Reclaimer - Cast Exploit Weakness'),
('1760611','17606','0','0','100','1','8000','11000','9000','14000','11','31734','1','33','0','0','0','0','0','0','0','0','Sunhawk Reclaimer - Cast Mark of the Sunhawk'),
('1760612','17606','27','0','100','1','12544','1','15000','30000','11','12544','0','1','0','0','0','0','0','0','0','0','Sunhawk Reclaimer - Cast Frost Armor on Missing Buff'),
('1760613','17606','2','0','100','0','15','0','0','0','49','0','0','0','22','3','0','0','0','0','0','0','Sunhawk Reclaimer - Disable Dynamic Movement and Set Phase 3 at 15% HP'),
('1760614','17606','2','7','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Sunhawk Reclaimer - Flee at 15% HP (Phase 3)'),
('1760615','17606','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Sunhawk Reclaimer - Set Phase to 0 on Evade');

-- ---------------------------
-- Sunhawk Defender
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17607; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17607;
INSERT INTO `creature_ai_scripts` VALUES
('1760701','17607','0','0','100','1','6000','9000','7000','11000','11','31737','0','0','0','0','0','0','0','0','0','0','Sunhawk Defender - Cast Whirlwind'),
('1760702','17607','9','0','100','1','0','5','9000','12000','11','15284','1','1','0','0','0','0','0','0','0','0','Sunhawk Defender - Cast Cleave'),
('1760703','17607','0','0','100','1','4000','6000','9000','14000','11','31734','1','33','0','0','0','0','0','0','0','0','Sunhawk Defender - Cast Mark of the Sunhawk'),
('1760704','17607','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Sunhawk Defender - Flee at 15% HP');

-- ---------------------------
-- Sunhawk Pyromancer
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17608; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17608;
INSERT INTO `creature_ai_scripts` VALUES
(1760801, 17608, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - Start Combat Movement and Set Phase to 0 on Spawn'),
(1760802, 17608, 4, 0, 100, 0, 0, 0, 0, 0, 11, 9053, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - Cast Fireball and Set Phase 1 on Aggro'),
('1760803','17608','9','13','100','1','0','40','3000','4800','11','9053','1','0','0','0','0','0','0','0','0','0','Sunhawk Pyromancer - Cast Fireball (Phase 1)'),
(1760804, 17608, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1760805, 17608, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - Start Combat Movement at 35 Yards (Phase 1)'),
(1760806, 17608, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - Start Combat Movement at 15 Yards (Phase 1)'),
(1760807, 17608, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - Start Combat Movement Below 5 Yards (Phase 1)'),
(1760808, 17608, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Pyromancer - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1760809','17608','0','0','100','1','12000','15000','19000','23000','11','11962','4','33','0','0','0','0','0','0','0','0','Sunhawk Pyromancer - Cast Immolate'),
('1760810','17608','0','0','100','1','8000','11000','9000','14000','11','31734','1','33','0','0','0','0','0','0','0','0','Sunhawk Pyromancer - Cast Mark of the Sunhawk'),
('1760811','17608','2','0','100','0','15','0','0','0','49','0','0','0','22','3','0','0','0','0','0','0','Sunhawk Pyromancer - Disable Dynamic Movement and Set Phase 3 at 15% HP'),
('1760812','17608','2','7','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Sunhawk Pyromancer - Flee at 15% HP (Phase 3)'),
('1760813','17608','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Sunhawk Pyromancer - Set Phase to 0 on Evade');

-- ---------------------------
-- Sunhawk Saboteur
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17609; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17609;
INSERT INTO `creature_ai_scripts` VALUES
(1760901, 17609, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Start Combat Movement and Prevent Melee on Spawn'),
(1760902, 17609, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Set Phase 1 on Aggro'),
('1760903','17609','9','5','100','1','5','30','2300','3900','11','6660','1','0','40','2','0','0','0','0','0','0','Sunhawk Saboteur - Cast Shoot and Set Ranged Weapon Model (Phase 1)'),
('1760904','17609','9','5','100','1','5','30','8000','11000','11','14443','4','1','40','2','0','0','0','0','0','0','Sunhawk Saboteur - Cast Multi-Shot and Set Ranged Weapon Model (Phase 1)'),
(1760905, 17609, 9, 5, 100, 1, 25, 80, 0, 0, 21, 1, 1, 0, 20, 1, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Start Combat Movement and Start Melee at 25 Yards (Phase 1)'),
(1760906, 17609, 9, 5, 100, 1, 0, 5, 0, 0, 21, 1, 0, 0, 40, 1, 0, 0, 20, 1, 0, 0, 'Sunhawk Saboteur - Start Combat Movement and Set Melee Weapon Model and Start Melee Below 5 Yards (Phase 1)'),
(1760907, 17609, 9, 5, 100, 1, 5, 15, 0, 0, 21, 1, 1, 0, 20, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Start Combat Movement and Prevent Melee at 15 Yards (Phase 1)'),
('1760908','17609','0','0','100','1','8000','11000','9000','14000','11','31734','1','33','0','0','0','0','0','0','0','0','Sunhawk Saboteur - Cast Mark of the Sunhawk'),
(1760909, 17609, 2, 0, 100, 0, 15, 0, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Set Phase 2 at 15% HP'),
(1760910, 17609, 2, 3, 100, 0, 15, 0, 0, 0, 21, 1, 0, 0, 25, 0, 0, 0, 1, -47, 0, 0, 'Sunhawk Saboteur - Start Combat Movement and Flee at 15% HP (Phase 2)'),
(1760911, 17609, 7, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 'Sunhawk Saboteur - Set Phase to 0 and Set Melee Weapon Model on Evade');

-- ---------------------------
-- Sunhawk Agent
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17610; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17610;
INSERT INTO `creature_ai_scripts` VALUES
('1761001','17610','0','0','100','1','6000','9000','7000','11000','11','7159','1','0','0','0','0','0','0','0','0','0','Sunhawk Agent - Cast Backstab'),
('1761002','17610','9','0','100','1','0','5','6000','9000','11','14873','1','1','0','0','0','0','0','0','0','0','Sunhawk Agent - Cast Sinister Strike'),
('1761003','17610','12','0','100','1','20','0','9000','13000','11','15691','1','1','0','0','0','0','0','0','0','0','Sunhawk Agent - Cast Eviscerate when Target is 20% HP'),
('1761004','17610','0','0','100','1','4000','6000','9000','14000','11','31734','1','33','0','0','0','0','0','0','0','0','Sunhawk Agent - Cast Mark of the Sunhawk'),
('1761005','17610','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Sunhawk Agent - Flee at 15% HP');

-- ---------------------------
-- Blade of Argus
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17659; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17659;
INSERT INTO `creature_ai_scripts` VALUES
('1765901','17659','9','0','100','1','0','5','6000','9000','11','8242','1','0','0','0','0','0','0','0','0','0','Blade of Argus - Cast Shield Slam');

-- https://github.com/cmangos/tbc-db/blob/18dd605950d0ace090ac7215c276d5ca7226d35f/Updates/453_UDB-416_waypoints.sql#L3
UPDATE creature SET orientation = 3.28, spawndist = 0, MovementType = 0 WHERE guid = 63380;
UPDATE creature SET position_x = -2470.925537, position_y = -12051.625000, position_z = 30.560596, orientation = 3.28, spawndist = 0, MovementType = 2 WHERE guid = 63381;
DELETE FROM `creature_addon` WHERE `guid`=63381;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (63381,63381,0,0,4097,0, '');
DELETE FROM waypoint_data WHERE id = 63381;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z, delay) VALUES
(63381,1,-2497.83,-12057.9,31.9053, 0),
(63381,2,-2523.79,-12075.3,32.3103, 0),
(63381,3,-2552.72,-12093.5,31.2433, 0),
(63381,4,-2566.69,-12108.9,29.5732, 0),
(63381,5,-2599.75,-12132,24.5561, 0),
(63381,6,-2620.57,-12144.9,21.4677, 0),
(63381,7,-2649.56,-12164.5,16.6404, 0),
(63381,8,-2677.64,-12180.3,12.8956, 0),
(63381,9,-2700.18,-12196.7,10.2884, 0),
(63381,10,-2712.49,-12202,9.55231, 0),
(63381,11,-2727.41,-12204.9,8.91536, 0),
(63381,12,-2752.72,-12206,8.53212, 4000),
(63381,13,-2748.58,-12210.2,8.47895, 0),
(63381,14,-2723.54,-12209.9,9.0245, 0),
(63381,15,-2708.51,-12206.7,9.70713, 0),
(63381,16,-2698.11,-12201.9,10.1994, 0),
(63381,17,-2677.07,-12185,12.7801, 0),
(63381,18,-2651.5,-12170.9,15.996, 0),
(63381,19,-2627.7,-12154.6,19.9544, 0),
(63381,20,-2606.67,-12142.1,23.209, 0),
(63381,21,-2582.39,-12128.2,26.6206, 0),
(63381,22,-2566.59,-12116.6,28.9216, 0),
(63381,23,-2549.63,-12098.6,31.4306, 0),
(63381,24,-2524.6,-12082.1,32.0987, 0),
(63381,25,-2503.23,-12066,32.3717, 0),
(63381,26,-2477.66,-12056.6,30.9584, 0),
(63381,27,-2455.42,-12046.9,30.1203, 0),
(63381,28,-2435.2,-12034.7,28.843, 0),
(63381,29,-2419.58,-12025.7,27.8794, 0),
(63381,30,-2399.2,-12016.5,26.9301, 0),
(63381,31,-2376.94,-12002,26.5955, 4000),
(63381,32,-2383.82,-12002.7,26.5736, 0),
(63381,33,-2406.64,-12014.6,27.1378, 0),
(63381,34,-2428.21,-12026.2,28.1998, 0),
(63381,35,-2447.22,-12038.5,29.5086, 0),
(63381,36,-2471.15,-12050.1,30.556, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID`= 63381;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(63381,63381,0,0,2),
(63381,63380,3,4.71,2);

-- ---------------------------
-- Deathclaw
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17661; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17661;
INSERT INTO `creature_ai_scripts` VALUES
('1766101','17661','9','0','100','1','0','5','5000','8000','11','31279','1','0','0','0','0','0','0','0','0','0','Deathclaw - Cast Swipe');

-- ---------------------------
-- Sironas
-- ---------------------------
DELETE FROM `creature_ai_texts` WHERE `entry` =-1432;
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1432','Petulant children, pray to your gods for you are about to meet them!','0','1','0','17678','0');

UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `id`=17678;
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17678; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17678;
INSERT INTO `creature_ai_scripts` VALUES
('1767801','17678','1','0','100','0','2000','2000','0','0','0','0','0','0','11','31612','0','0','0','0','0','0','Sironas - Cast Sironas Channeling after Spawn'),
('1767802','17678','4','0','100','0','0','0','0','0','1','-1432','0','0','0','0','0','0','0','0','0','0','Sironas - Yell on Aggro'),
('1767803','17678','0','0','100','1','8000','10000','15000','19000','11','13338','4','1','0','0','0','0','0','0','0','0','Sironas - Cast Curse of Tongues'),
('1767804','17678','0','0','100','1','4000','7000','16000','21000','11','8282','1','33','0','0','0','0','0','0','0','0','Sironas - Cast Curse of Blood'),
('1767805','17678','9','0','100','1','0','5','11000','15000','11','10966','1','1','0','0','0','0','0','0','0','0','Sironas - Cast Uppercut'),
('1767806','17678','9','0','100','1','0','30','9000','14000','11','12742','4','32','0','0','0','0','0','0','0','0','Sironas - Cast Immolate'),
('1767807','17678','21','0','100','0','0','0','0','0','0','0','0','0','11','31612','0','0','18','768','0','0','Sironas - Reset unit flags and cast Sironas Channeling on Reached Home');

-- ---------------------------
-- Expedition Researcher
-- ---------------------------
DELETE FROM `creature_ai_texts` WHERE `entry` IN(-1372,-1373,-1374);
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1372','Woot! Thanks!','0','0','0','17681','0'),
('-1373','I knew Cornelius wouldn\'t leave us behind!','0','0','0','17681','0'),
('-1374','By the forehead signet of Velen, I am saved!','0','0','0','17681','0');

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17681; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17681;
INSERT INTO `creature_ai_scripts` VALUES
('1768101','17681','11','0','25','0','0','0','0','0','1','-1372','-1373','-1374','0','0','0','0','0','0','0','0','Expedition Researcher - Say at Spawn');

-- ---------------------------
-- Zarakh 
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17683; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17683;
INSERT INTO `creature_ai_scripts` VALUES
('1768301','17683','11','0','100','0','0','0','0','0','11','3616','0','1','0','0','0','0','0','0','0','0','Zarakh - Cast Poison Proc on Spawn'),
('1768302','17683','9','0','100','1','0','30','8000','11000','11','745','1','0','0','0','0','0','0','0','0','0','Zarakh - Cast Web');

-- ---------------------------
-- Hand of Argus Swordsman
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17704; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17704;
INSERT INTO `creature_ai_scripts` VALUES
('1770401','17704','0','0','100','1','3000','5000','11000','15000','11','9128','0','1','0','0','0','0','0','0','0','0','Hand of Argus Swordsman - Cast Battle Shout'),
('1770402','17704','9','0','100','1','0','5','5000','7000','11','11976','1','0','0','0','0','0','0','0','0','0','Hand of Argus Swordsman - Cast Strike');

-- https://github.com/cmangos/tbc-db/blob/e3fa30f1dbd1f8c27eab65d75c75f662f0cfdfbf/Updates/760_UDB-427_waypoints.sql#L1
UPDATE creature SET position_x = -1900.667969, position_y = -11882.219727, position_z = 39.233170, orientation = 3.068463, spawndist = 0, MovementType = 0 WHERE guid = 63454;
UPDATE creature SET position_x = -1900.364258, position_y = -11880.276367, position_z = 38.941658, orientation = 3.064536, spawndist = 0, MovementType = 0 WHERE guid = 63453;
UPDATE creature SET position_x = -1900.088501, position_y = -11879.190430, position_z = 38.751530, orientation = 3.064536, spawndist = 0, MovementType = 0 WHERE guid = 63452;
UPDATE creature SET position_x = -1901.335938, position_y = -11881.068359, position_z = 39.285175, orientation = 2.963341, spawndist = 0, MovementType = 2 WHERE guid = 63451;

UPDATE `creature_addon` SET `path_id`=63451 WHERE `guid`=63451;
DELETE FROM waypoint_data WHERE id = 63451;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z, delay) VALUES
(63451,1,-1919.71,-11878.5,43.9417, 2000),
(63451,2,-1932.5,-11871.9,48.3816, 0),
(63451,3,-1943.91,-11863.3,50.3332, 0),
(63451,4,-1957.58,-11854.4,50.4065, 0),
(63451,5,-1965.31,-11852.6,49.8413, 0),
(63451,6,-1980.63,-11856,48.0117, 0),
(63451,7,-1997.15,-11857.4,47.2336, 0),
(63451,8,-2019.49,-11853.8,46.9228, 0),
(63451,9,-2034.37,-11851.7,47.2372, 0),
(63451,10,-2044.4,-11846.3,47.7605, 0),
(63451,11,-2050.89,-11829.3,47.7391, 0),
(63451,12,-2056.33,-11809.5,46.1639, 0),
(63451,13,-2059.23,-11783.7,45.9743, 0),
(63451,14,-2056.36,-11770.6,46.2552, 0),
(63451,15,-2043.51,-11763.3,51.9919, 0),
(63451,16,-2030.85,-11756.1,51.6225, 0),
(63451,17,-2025.79,-11739.8,49.4705, 0),
(63451,18,-2018.75,-11731.5,47.7727, 0),
(63451,19,-2011.27,-11726.2,45.5089, 0),
(63451,20,-1996.45,-11721.2,46.9958, 0),
(63451,21,-1966.27,-11695.8,40.323, 0),
(63451,22,-1968.31,-11664.4,40.3921, 0),
(63451,23,-1967.33,-11639.4,43.4553, 0),
(63451,24,-1965.45,-11625.4,49.0818, 0),
(63451,25,-1961.99,-11585.6,46.1863, 0),
(63451,26,-1960.29,-11556.9,54.8725, 0),
(63451,27,-1948.57,-11522.8,54.7186, 0),
(63451,28,-1915.01,-11500.5,51.5661, 0),
(63451,29,-1887.56,-11492.9,49.9166, 0),
(63451,30,-1855.26,-11476.2,46.8787, 0),
(63451,31,-1831.17,-11463,46.1476, 0),
(63451,32,-1815.46,-11455.4,46.5529, 0),
(63451,33,-1803.95,-11465.8,45.0146, 0),
(63451,34,-1801.89,-11482.8,39.0529, 0),
(63451,35,-1809.38,-11515.8,35.5228, 0),
(63451,36,-1805.72,-11526.2,36.5808, 0),
(63451,37,-1789.44,-11548.4,35.0002, 0),
(63451,38,-1777.65,-11563.1,35.2212, 0),
(63451,39,-1771.04,-11572.8,36.1952, 0),
(63451,40,-1771.71,-11584.3,36.0952, 0),
(63451,41,-1785.03,-11607.7,35.6682, 0),
(63451,42,-1798.6,-11621.4,34.424, 0),
(63451,43,-1825.18,-11630.9,35.6892, 0),
(63451,44,-1837.24,-11645.1,36.076, 0),
(63451,45,-1835.07,-11663.1,35.1535, 0),
(63451,46,-1822.54,-11671.7,34.7502, 0),
(63451,47,-1790,-11671.4,34.9058, 0),
(63451,48,-1782.02,-11675.5,34.8924, 0),
(63451,49,-1773.67,-11676.2,34.9571, 0),
(63451,50,-1756.83,-11669.9,33.831, 0),
(63451,51,-1739.46,-11667.1,35.6339, 0),
(63451,52,-1719.49,-11658.3,36.1233, 0),
(63451,53,-1704.09,-11648.9,35.0948, 0),
(63451,54,-1694.88,-11648.5,35.5366, 0),
(63451,55,-1681.53,-11661.8,38.7423, 0),
(63451,56,-1676.28,-11680,41.0487, 0),
(63451,57,-1676.31,-11701.4,38.9257, 0),
(63451,58,-1683.13,-11714.1,36.278, 0),
(63451,59,-1691.73,-11739.6,31.2819, 0),
(63451,60,-1703.01,-11757.7,28.8242, 0),
(63451,61,-1714.62,-11767.8,27.8882, 0),
(63451,62,-1733.62,-11774.8,27.5277, 0),
(63451,63,-1758.87,-11783.1,27.0512, 0),
(63451,64,-1771.36,-11790.2,27.3073, 0),
(63451,65,-1790.91,-11811.1,27.176, 0),
(63451,66,-1805.93,-11826.5,26.9529, 0),
(63451,67,-1823.29,-11842.4,27.4183, 0),
(63451,68,-1836.52,-11855.8,28.1996, 0),
(63451,69,-1849.44,-11869.2,29.6033, 0),
(63451,70,-1862.36,-11876.8,31.401, 0),
(63451,71,-1878.68,-11880.4,34.0545, 2000),
(63451,72,-1899.24,-11880.4,38.6422, 0);

DELETE FROM `creature_formations` WHERE `leaderGUID`= 63451;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(63451,63451,0,0,2),
(63451,63454,2,5.50,2),
(63451,63453,2,0.78,2),
(63451,63452,4,0.78,2);

-- ---------------------------
-- Bloodcursed Naga
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17713; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17713;
INSERT INTO `creature_ai_scripts` VALUES
('1771301','17713','1','0','100','1','1000','1000','1800000','1800000','11','12544','0','1','0','0','0','0','0','0','0','0','Bloodcursed Naga - Cast Frost Armor on Spawn'),
(1771302, 17713, 1, 0, 100, 0, 0, 0, 0, 0, 21, 1, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement and Set Phase to 0 on Spawn'),
(1771303, 17713, 4, 0, 100, 0, 0, 0, 0, 0, 11, 20792, 1, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Cast Frostbolt and Set Phase 1 on Aggro'),
('1771304','17713','9','5','100','1','0','40','3000','4800','11','20792','1','0','0','0','0','0','0','0','0','0','Bloodcursed Naga - Cast Frostbolt (Phase 1)'),
(1771305, 17713, 3, 5, 100, 0, 7, 0, 0, 0, 21, 1, 0, 0, 23, 1, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
(1771306, 17713, 9, 5, 100, 0, 35, 80, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement at 35 Yards (Phase 1)'),
(1771307, 17713, 9, 5, 100, 0, 5, 15, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement at 15 Yards (Phase 1)'),
(1771308, 17713, 9, 5, 100, 0, 0, 5, 0, 0, 21, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Start Combat Movement Below 5 Yards (Phase 1)'),
(1771309, 17713, 3, 3, 100, 1, 100, 15, 100, 100, 23, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Veridian Broodling - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1771310','17713','27','0','100','1','12544','1','15000','30000','11','12544','0','1','0','0','0','0','0','0','0','0','Bloodcursed Naga - Cast Frost Armor on Missing Buff'),
('1771311','17713','7','0','100','0','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Bloodcursed Naga - Set Phase to 0 on Evade');

-- ---------------------------
-- Bloodcursed Voyager
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17714; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17714;
INSERT INTO `creature_ai_scripts` VALUES
('1771401','17714','4','0','100','0','0','0','0','0','39','15','0','0','0','0','0','0','0','0','0','0','Bloodcursed Voyager - Call for Help on Aggro');

-- ---------------------------
-- Atoph the Bloodcursed
-- ---------------------------
DELETE FROM `creature_ai_texts` WHERE `entry` =-1413;
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1413','Who dares defile the statue of our beloved?','0','1','0','17715','0');

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17715; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17715;
INSERT INTO `creature_ai_scripts` VALUES
('1771501','17715','0','0','100','0','0','0','0','0','1','-1413','0','0','0','0','0','0','0','0','0','0','Atoph the Bloodcursed - Yell on Aggro'),
('1771502','17715','9','0','100','1','0','5','5000','8000','11','11976','1','0','0','0','0','0','0','0','0','0','Atoph the Bloodcursed - Cast Strike'),
('1771503','17715','9','0','100','1','0','5','21000','25000','11','11977','1','1','0','0','0','0','0','0','0','0','Atoph the Bloodcursed - Cast Rend');

-- ---------------------------
-- Hunter of the Hand
-- ---------------------------
-- UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17875;
-- DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17875;
-- INSERT INTO `creature_ai_scripts` VALUES
-- ('1787501','17875','11','0','100','32','0','0','0','0','3','0','17280','0','3','0','17281','0','3','0','17282','0','Hunter of the Hand - randomized model on spawn');

-- ---------------------------
-- Fenissa the Assassin
-- ---------------------------
UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=22060; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22060;
INSERT INTO `creature_ai_scripts` VALUES
('2206001','22060','9','0','100','1','0','5','5000','8000','11','14873','1','0','0','0','0','0','0','0','0','0','Fenissa the Assassin - Cast Sinister Strike'),
('2206002','22060','0','0','100','1','7000','10000','12000','15000','11','38863','1','1','0','0','0','0','0','0','0','0','Fenissa the Assassin - Cast Gouge'),
('2206003','22060','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Fenissa the Assassin - Flee at 15% HP');

-- https://github.com/cmangos/tbc-db/blob/cff248f0b40e2d22100d18062a74eb91ff829e6c/Updates/SpinOnTop/076_UDB-474_creature.sql#L1
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid = 77280;
UPDATE `creature_template_addon` SET `path_id`=77280 WHERE `entry`=22060;
DELETE FROM waypoint_data WHERE id = 77280;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z, delay) VALUES
(77280,1,-2018.4,-10779.8,83.9194,0),
(77280,2,-2009.19,-10774.9,86.3301,0),
(77280,3,-1997.48,-10777.2,88.1848,0),
(77280,4,-1966.53,-10790.7,88.7789,0),
(77280,5,-1954.79,-10796.6,87.7502,0),
(77280,6,-1943.7,-10807.8,84.992,0),
(77280,7,-1937.79,-10817.6,81.4528,0),
(77280,8,-1934.43,-10832.9,76.0153,0),
(77280,9,-1939.2,-10845.5,71.8459,0),
(77280,10,-1938.4,-10858.5,68.2741,0),
(77280,11,-1925.66,-10871.1,65.9228,0),
(77280,12,-1913.74,-10872.4,63.2952,0),
(77280,13,-1896.27,-10866.3,66.1058,0),
(77280,14,-1912.27,-10872.1,63.2463,0),
(77280,15,-1924.78,-10871.5,65.862,0),
(77280,16,-1935.38,-10864.3,67.0354,0),
(77280,17,-1940.43,-10853.4,69.2778,0),
(77280,18,-1937.82,-10844.6,72.1658,0),
(77280,19,-1933.96,-10833.9,75.6676,0),
(77280,20,-1936.99,-10818.1,81.2,0),
(77280,21,-1943.35,-10808.3,84.7891,0),
(77280,22,-1953.57,-10797.3,87.5858,0),
(77280,23,-1966.19,-10790.7,88.7802,0),
(77280,24,-1997.18,-10777.2,88.2231,0),
(77280,25,-2007.82,-10770.7,86.6695,0),
(77280,26,-2016.88,-10770.5,85.2932,0),
(77280,27,-2024.94,-10775.8,83.353,0),
(77280,28,-2033.24,-10787.8,80.3216,0),
(77280,29,-2041.92,-10799.6,76.6983,0),
(77280,30,-2056.36,-10813.9,70.8753,0),
(77280,31,-2068.36,-10822.2,67.4542,0),
(77280,32,-2078.3,-10822.7,66.9212,0),
(77280,33,-2085.57,-10818.7,67.1834,0),
(77280,34,-2093.56,-10803.4,66.9846,0),
(77280,35,-2085.88,-10817.9,67.1677,0),
(77280,36,-2075.81,-10822.9,66.981,0),
(77280,37,-2063.41,-10819.9,68.265,0),
(77280,38,-2055,-10812.8,71.3805,0),
(77280,39,-2042.03,-10799.7,76.6537,0),
(77280,40,-2024.38,-10786.2,81.8813,0);

DELETE FROM `creature` WHERE `guid` IN (1688799,1717948,1717953,1717977);

DELETE FROM `spell_script_target` WHERE `entry` = 39211;
INSERT INTO `spell_script_target` VALUES (39211,1,22001);

DELETE FROM creature_addon WHERE guid NOT IN (SELECT guid FROM creature);

UPDATE `creature` SET `modelid` = 0 WHERE `id` = 24222;

-- Magus Filinthus
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 16821;
INSERT INTO `creature_ai_scripts` VALUES
('1682101','16821','1','0','100','1','60000','60000','120000','120000','1','-11000','-11001','-11002','5','5','0','0','0','0','0','0','Magus Filinthus - Random say1 while OOC'),
('1682102','16821','1','0','100','1','120000','120000','120000','120000','1','-11003','-11004','-11005','0','0','0','0','0','0','0','0','Magus Filinthus - Random say2 while OOC'),
('1682603','16821','8','0','100','1','7791','-1','0','0','0','0','0','0','23','1','0','0','0','0','0','0','Magus Filinthus - Set phase 2 after teleport spell'),
('1682604','16821','1','1','100','1','1000','1000','1000','1000','100','0','0','0','0','0','0','0','0','0','0','0','Magus Filinthus - Despawn after 1 sec and set phase 1'),
('1682605','16821','1','1','100','1','1500','1500','1500','1500','12','1000015','0','1000','23','1','0','0','0','0','0','0','Magus Filinthus - Summon killer after 1 sec and set phase 1');

UPDATE `creature_template` SET `lootid` = 21127 WHERE `entry` = 21843;

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 12999;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 12999;

UPDATE `creature_template` SET `lootid` = 0 WHERE `entry` = 4535;

DELETE FROM `creature_ai_scripts` WHERE `id` IN (2497910,2497911,2497912,2497913,1689601,1689602,1689603,1689604,1814701,1814702,1814703,1814704,2493801,65696,65697,65699,65700);
INSERT INTO `creature_ai_scripts` VALUES (1689601,	16896, 10, 0, 75, 1, 1, 20, 8000, 16000, 11, 29120, 0, 7, 24, 0, 0, 0, 0, 0, 0, 0, 'Honor Hold Archer - Cast Shoot on Dummy & Reset OOC');
INSERT INTO `creature_ai_scripts` VALUES (1814701,	18147, 10, 0, 75, 1, 1, 20, 8000, 16000, 11, 29120, 0, 7, 24, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon Ranger - Cast Shoot on Dummy & Reset OOC');
INSERT INTO `creature_ai_scripts` VALUES (2493801,	24938, 10, 0, 75, 1, 1, 40, 8000, 16000, 11, 45233, 0, 7, 24, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Cast Shoot on Dummy & Reset OOC');
INSERT INTO `creature_ai_scripts` VALUES (2497913,	24979, 1, 0, 75, 1, 5000, 10000, 8000, 16000, 11, 29120, 0, 7, 24, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - Cast Shoot on Dummy & Reset OOC');

DELETE FROM `spell_script_target` WHERE `entry` = 45233;
INSERT INTO `spell_script_target` VALUES (45233, 1, 25192);

UPDATE `creature_template` SET `npcflag` = 3 WHERE `entry` = 14338; -- 83

DELETE FROM `spell_script_target` WHERE `entry` = 29866;
INSERT INTO `spell_script_target` VALUES (29866, 0, 181616);

UPDATE `creature_template` SET `npcflag` = 65539 WHERE `entry` = 21088; -- 66179

UPDATE `creature_template` SET `lootid`='18501' WHERE `entry` = 20323;

UPDATE `creature_ai_scripts` SET `action1_type`='41', `action2_type` = 0 WHERE `id` = 1849915;

DELETE FROM `gameobject_template` WHERE `entry` = 184839;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `castBarCaption`, `faction`, `flags`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `ScriptName`) VALUES (184839, 6, 477, 'Wyrmcult Egg Spawner', '', 1827, 0, 1, 0, 0, 5, 36903, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `spell_script_target` WHERE `entry` = 17618;
INSERT INTO `spell_script_target` VALUES (17618, 1, 11582);

DELETE FROM `spell_script_target` WHERE `entry` = 37285;
INSERT INTO `spell_script_target` VALUES (37285, 1, 21211);

DELETE FROM `spell_script_target` WHERE `entry` = 40902;
INSERT INTO `spell_script_target` VALUES (40902, 2, 22841);

DELETE FROM `gameobject_template` WHERE `entry` = 183929;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `castBarCaption`, `faction`, `flags`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `ScriptName`) VALUES (183929, 6, 0, '', '', 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `spell_script_target` WHERE `entry` = 36652;
INSERT INTO `spell_script_target` VALUES (36652, 1, 21195);

UPDATE `creature_template` SET `mindmg`='2136',`maxdmg`='2816' WHERE `entry` = 21694;
UPDATE `creature_template` SET `mindmg`='5519',`maxdmg`='6036' WHERE `entry` = 21914;

UPDATE `creature_ai_scripts` SET `action2_type` = 0, `action2_param1` = 0, `action2_param2` = 0, `action2_param3` = 0, `action3_type` = 0, `action3_param1` = 0, `action3_param2` = 0, `action3_param3` = 0, `comment` = 'Defias Dockmaster - Summon Defias Bodyguard on Aggro' WHERE `id` = 684602;
DELETE FROM `creature_ai_scripts` WHERE `id`  = 686604;
INSERT INTO `creature_ai_scripts` VALUES ('686604','6866','1','0','100','0','10000','10000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Defias Bodyguard - Despawn OOC');

UPDATE `creature_template` SET `mindmg`='5473',`maxdmg`='5970' WHERE `entry` = 20652;

UPDATE `creature_template` SET `mindmg`='300',`maxdmg`='600' WHERE `entry` = 17306;
UPDATE `creature_template` SET `mindmg`='2897',`maxdmg`='3418' WHERE `entry` = 18436;

UPDATE `creature_template` SET `minhealth` = 82642, `maxhealth` = 82642 WHERE `entry` = 18433;

UPDATE `creature_template` SET `mindmg`='4326',`maxdmg`='5138' WHERE `entry` = 20268;

UPDATE `gameobject` SET `spawnMask`=0 WHERE `id`=181598; -- Despawn abusable silithyst geysers

UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(63622,57448);

-- Update autobroadcast from L4G Info -> Hellfire Info
UPDATE `looking4group_string` SET `content_default`='|cffffff00[|c00077766Hellfire Info|cffffff00]: |cff00ccff%s|r', `content_loc3`='|cffffff00[|c00077766Hellfire Info|cffffff00]: |cff00ccff%s|r' WHERE `entry`=786;

-- ---------------------------
-- Hauteur
-- ---------------------------
DELETE FROM `creature_ai_texts` WHERE `entry` =-1395;
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1395','You dare summon me?!','0','0','0','17206','0');
 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17206;
INSERT INTO `creature_ai_scripts` VALUES
('1720603','17206','11','0','100','0','0','0','0','0','1','-1395','0','0','0','0','0','0','0','0','0','0','Hauteur - say on Spawn');

-- ---------------------------
-- Stillpine Hold
-- https://github.com/cmangos/tbc-db/blob/e3fa30f1dbd1f8c27eab65d75c75f662f0cfdfbf/Updates/705_UDB-359_Zone.sql#L20
-- ---------------------------
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid` IN(63001,62916,62917,62918);
 
-- Duplicates
DELETE FROM creature WHERE guid IN (86515,86535,86537,86534,86536,86533,86516,86532,86517,86518,86519,86531,86521,86520,86530,86529,86522,86523,86528,86526,86524,86527,86525,60792,60777,60780,62886,62890,62889,60814,60786,60778,60810);
DELETE FROM creature_addon WHERE guid IN (86515,86535,86537,86534,86536,86533,86516,86532,86517,86518,86519,86531,86521,86520,86530,86529,86522,86523,86528,86526,86524,86527,86525,60792,60777,60780,62886,62890,62889,60814,60786,60778,60810);
DELETE FROM creature_formations WHERE memberGUID IN (86515,86535,86537,86534,86536,86533,86516,86532,86517,86518,86519,86531,86521,86520,86530,86529,86522,86523,86528,86526,86524,86527,86525,60792,60777,60780,62886,62890,62889,60814,60786,60778,60810) 
OR leaderGUID IN (86515,86535,86537,86534,86536,86533,86516,86532,86517,86518,86519,86531,86521,86520,86530,86529,86522,86523,86528,86526,86524,86527,86525,60792,60777,60780,62886,62890,62889,60814,60786,60778,60810);

-- Stillpine Hunter
UPDATE creature SET modelid = 11363, spawndist = 0, MovementType = 0 WHERE guid = 62911;
UPDATE creature SET modelid = 11363, spawndist = 0, MovementType = 0 WHERE guid = 62912;
UPDATE creature SET modelid = 11363, spawndist = 0, MovementType = 0 WHERE guid = 62913;
UPDATE creature SET modelid = 11363, spawndist = 0, MovementType = 0 WHERE guid = 62914;

-- Stillpine Defender
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62894;
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62893;
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62895;
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62878;
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62877;
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62875;
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62874;
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 0 WHERE guid = 62885;
UPDATE creature SET modelid = 16861, position_x = -3379.922852, position_y = -12412.213867, position_z = 19.404476, orientation = 1.851495, spawndist = 0, MovementType = 0 WHERE guid = 62884;
UPDATE creature SET modelid = 16861, position_x = -3358.631592, position_y = -12295.454102, position_z = 21.910225, orientation = 3.551091, spawndist = 0, MovementType = 0 WHERE guid = 62883;
UPDATE creature SET modelid = 16861, position_x = -3363.484375, position_y = -12349.057617, position_z = 24.220934, orientation = 5.859406, spawndist = 1, MovementType = 1 WHERE guid = 62876;
UPDATE creature SET modelid = 16861, position_x = -3360.555664, position_y = -12345.720703, position_z = 24.202297, orientation = 5.879040, spawndist = 1, MovementType = 1 WHERE guid = 62881;
UPDATE creature SET modelid = 16861, position_x = -3361.940918, position_y = -12340.829102, position_z = 24.344650, orientation = 5.875113, spawndist = 1, MovementType = 1 WHERE guid = 62887;
UPDATE creature SET modelid = 16861, position_x = -3351.189941, position_y = -12348.177734, position_z = 23.703859, orientation = 4.900434, spawndist = 1, MovementType = 1 WHERE guid = 62888;
UPDATE creature SET modelid = 16861, position_x = -3354.359619, position_y = -12351.738281, position_z = 24.811050, orientation = 6.004703, spawndist = 1, MovementType = 1 WHERE guid = 62882;
UPDATE creature SET modelid = 16861, position_x = -3353.270996, position_y = -12357.412109, position_z = 24.356152, orientation = 0.177048, spawndist = 1, MovementType = 1 WHERE guid = 62879;

-- waypoints
UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 2 WHERE guid = 62892;
UPDATE creature SET modelid = 16861, position_x = -3437.737061, position_y = -12371.333984, position_z = 13.773876, orientation = 5.797322, spawndist = 0, MovementType = 0 WHERE guid = 62891;

UPDATE creature SET modelid = 16861, spawndist = 0, MovementType = 2 WHERE guid = 62892;
UPDATE creature SET modelid = 16861, position_x = -3437.737061, position_y = -12371.333984, position_z = 13.773876, orientation = 5.797322, spawndist = 0, MovementType = 0 WHERE guid = 62891;
DELETE FROM `creature_addon` WHERE `guid`=62892;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (62892,62892,0,0,4097,0, '');
DELETE FROM waypoint_data WHERE id = 62892;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z, delay) VALUES
(62892,1,-3410.58,-12386.8,17.176, 0),
(62892,2,-3402.21,-12401.9,18.6329, 0),
(62892,3,-3385.85,-12398.6,19.5929, 3000),
(62892,4,-3391.08,-12395,19.0975, 0),
(62892,5,-3402.08,-12388.1,17.9221, 0),
(62892,6,-3409.48,-12380.3,16.8769, 0),
(62892,7,-3410.42,-12372.3,16.9648, 0),
(62892,8,-3402.65,-12364.3,17.9025, 0),
(62892,9,-3391.62,-12357.3,19.7161, 3000),
(62892,10,-3396.46,-12355.8,18.8209, 0),
(62892,11,-3411.28,-12359.9,16.4387, 0),
(62892,12,-3425.52,-12357.6,14.2552, 0),
(62892,13,-3433.61,-12349.3,13.8262, 0),
(62892,14,-3429.93,-12338.7,13.4157, 0),
(62892,15,-3415.68,-12325.5,14.5452, 0),
(62892,16,-3405.05,-12318.4,16.0476, 0),
(62892,17,-3378.59,-12302.2,20.8771, 5000),
(62892,18,-3386.46,-12301.6,19.9336, 0),
(62892,19,-3408.18,-12311.4,16.7621, 0),
(62892,20,-3424.07,-12321.9,14.4198, 0),
(62892,21,-3436.24,-12334,13.3297, 0),
(62892,22,-3445.65,-12350.2,12.9553, 0),
(62892,23,-3453.29,-12362.3,11.7418, 0),
(62892,24,-3447.02,-12373,12.8004, 0),
(62892,25,-3439.76,-12375.6,13.8129, 0);
-- link with second Stillpine Defender
DELETE FROM `creature_formations` WHERE `leaderGUID`= 62892;
INSERT INTO `creature_formations` (`leaderGUID`,`memberGUID`,`dist`,`angle`,`groupAI`)VALUES
(62892,62892,0,0,2),
(62892,62891,3,4.71,2);


-- Crazed Wildkin
UPDATE creature SET position_x = -3208.423584, position_y = -12500.442383, position_z = 15.360935, orientation = 1.877415, spawndist = 2, MovementType = 1 WHERE guid = 60806;
UPDATE creature SET position_x = -3131.476074, position_y = -12432.246094, position_z = 9.829928, orientation = 4.107938, spawndist = 2, MovementType = 1 WHERE guid = 60796;
UPDATE creature SET spawndist = 2, MovementType = 1 WHERE guid IN (60801,60788,60771,60791,60770,60813,60812,60809,60795,60804,60797,60798,60784,60783);
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid IN (60803,60785);

DELETE FROM `creature_addon` WHERE `guid`=60803;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (60803,60803,0,0,4097,0, '');
DELETE FROM waypoint_data WHERE id = 60803;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z) VALUES
(60803,1,-3227.88,-12395.1,9.25217),
(60803,2,-3221.57,-12399.7,8.9608),
(60803,3,-3209.56,-12405,6.37311),
(60803,4,-3203.37,-12408.5,3.64216),
(60803,5,-3201.35,-12414,2.63199),
(60803,6,-3200.4,-12427,2.08767),
(60803,7,-3192.66,-12442.1,0.411249),
(60803,8,-3185.36,-12450.1,-0.34798),
(60803,9,-3173.91,-12458,-1.27741),
(60803,10,-3163.31,-12469.1,-3.21722),
(60803,11,-3156.84,-12480.1,-1.94875),
(60803,12,-3149.8,-12503.6,-0.252113),
(60803,13,-3140.87,-12540.1,-3.17973),
(60803,14,-3143.94,-12525.7,-1.68655),
(60803,15,-3151.77,-12496.1,-0.814089),
(60803,16,-3158.29,-12476.2,-2.47093),
(60803,17,-3165.48,-12465.5,-3.00421),
(60803,18,-3174.22,-12457.5,-1.2019),
(60803,19,-3185.46,-12449.9,-0.346048),
(60803,20,-3193.2,-12441.5,0.484302),
(60803,21,-3200.32,-12426.7,2.11017),
(60803,22,-3201.48,-12411.2,2.92101),
(60803,23,-3205.78,-12405.2,5.00591),
(60803,24,-3221.46,-12399.8,8.94135),
(60803,25,-3227.63,-12395.2,9.21495),
(60803,26,-3241.69,-12377.4,10.0602);

DELETE FROM `creature_addon` WHERE `guid`=60785;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (60785,60785,0,0,4097,0, '');
DELETE FROM waypoint_data WHERE id = 60785;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z) VALUES
(60785,1,-3239.61,-12398.6,11.4139),
(60785,2,-3245.01,-12384.5,10.4674),
(60785,3,-3257.62,-12360.6,13.0589),
(60785,4,-3251.43,-12371.6,10.7729),
(60785,5,-3241.92,-12390.3,10.4988),
(60785,6,-3238.55,-12403,12.0011),
(60785,7,-3237.21,-12420.1,14.9591),
(60785,8,-3234.49,-12427.7,16.4744),
(60785,9,-3225.82,-12434.6,19.132),
(60785,10,-3217.54,-12443.7,18.3465),
(60785,11,-3210.44,-12454.6,16.2576),
(60785,12,-3206.75,-12464.6,14.8739),
(60785,13,-3210.1,-12473.9,14.5388),
(60785,14,-3219.07,-12476.8,15.385),
(60785,15,-3234,-12471.2,19.7447),
(60785,16,-3245.07,-12465.4,23.306),
(60785,17,-3248.79,-12458.7,24.463),
(60785,18,-3247.4,-12453.9,24.7964),
(60785,19,-3237.75,-12449.8,25.1367),
(60785,20,-3247.15,-12453.7,24.8269),
(60785,21,-3248.58,-12459.2,24.4606),
(60785,22,-3245.6,-12465.7,23.2696),
(60785,23,-3233.87,-12471.6,19.6405),
(60785,24,-3211.9,-12478.7,14.6015),
(60785,25,-3201.67,-12472.1,14.1454),
(60785,26,-3189.02,-12461.5,13.032),
(60785,27,-3180.77,-12455.7,12.8117),
(60785,28,-3176.45,-12451.3,12.9772),
(60785,29,-3173,-12443,12.1127),
(60785,30,-3164.14,-12408.9,12.065),
(60785,31,-3167.59,-12428.3,12.9697),
(60785,32,-3173.36,-12444.3,12.175),
(60785,33,-3176.34,-12451,12.9539),
(60785,34,-3180.71,-12455.9,12.8124),
(60785,35,-3189.12,-12461.4,13.0461),
(60785,36,-3211.52,-12478.3,14.5861),
(60785,37,-3225.19,-12477.2,16.6483),
(60785,38,-3240.7,-12469.1,21.8553),
(60785,39,-3246.51,-12463.6,23.7375),
(60785,40,-3248.1,-12456.6,24.6363),
(60785,41,-3245.81,-12451.7,25.0139),
(60785,42,-3237.28,-12449.3,25.1458),
(60785,43,-3247.57,-12453.6,24.7845),
(60785,44,-3248.27,-12460,24.3338),
(60785,45,-3245.48,-12465.3,23.3843),
(60785,46,-3230.87,-12473.1,18.4899),
(60785,47,-3216.59,-12472.3,15.3717),
(60785,48,-3208.49,-12464.5,15.0321),
(60785,49,-3210.63,-12452.7,16.393),
(60785,50,-3217.14,-12444.3,18.215),
(60785,51,-3225.46,-12434.7,19.1355),
(60785,52,-3234.13,-12428.2,16.6575),
(60785,53,-3237.22,-12419.6,14.8355);

-- ---------------------------
-- Draenei Youngling
-- ---------------------------
DELETE FROM `creature_ai_texts` WHERE `entry` IN(-1399,-1400,-1401,-1402,-1403,-1404,-1405);
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1399','Hrm, azure snapdragons? Where do they come up with these names? Daedal has gone mad!','0','0','0','17587','0'),
('-1400','Where in the Nether are these damnable lashers?','0','0','0','17587','0'),
('-1401','These stags are nothing like talbuks.','0','0','0','17587','0'),
('-1402','I wonder what that little purple creature at the village is...It\'s certainly beautiful.','0','0','0','17587','0'),
('-1403','I\'m supposed to be hunting infected nightstalkers...this should be easy.','0','0','0','17587','0'),
('-1404','Time to meet your maker!','0','0','0','17587','0'),
('-1405','Thanks for the heal, $N!','0','0','0','17587','0');

UPDATE `creature_template` SET `AIName`='EventAI', `ScriptName`='' WHERE `entry`=17587; 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 17587;
INSERT INTO `creature_ai_scripts` VALUES
('1758701','17587','1','0','75','33','10000','60000','120000','360000','1','-1399','-1400','-1401','0','0','0','0','0','0','0','0','Draenei Youngling - Randomized Say OOC 1'),
('1758702','17587','1','0','75','33','120000','120000','120000','360000','0','0','0','0','1','-1402','-1403','0','0','0','0','0','Draenei Youngling - Randomized Say OOC 2'),
('1758703','17587','4','0','50','0','0','0','0','0','1','-1404','0','0','0','0','0','0','0','0','0','0','Draenei Youngling - Say on Aggro'),
('1758704','17587','8','0','100','1','28880','-1','0','0','1','-1405','0','0','0','0','0','0','0','0','0','0','Draenei Youngling - Say on Gift of the Naaru Spellhit');


-- https://github.com/cmangos/tbc-db/blob/e3fa30f1dbd1f8c27eab65d75c75f662f0cfdfbf/Updates/735_UDB-398_Azuremyst_Isle_Pt-4.sql
-- More Duplicates
DELETE FROM creature WHERE guid IN (61301,61226,61307,61312,61310,61309,61236,61275,61228,61233,61235,61234,61271,61276,61247,61273,61240,61245,61242,61308,61251,61304,61239,61302,61237,61265,62030,
62038,62034,61692,61267,61262,61284,61263,61266,61253,61268,61280,61252,61270,61259,61254,61258,61298,61261,61300,61296,61257,61295,60861,60903,60907,60875,
60821,60876,60838,60869,60867,60878,60840,60911,60825,60904,86511);
DELETE FROM creature_addon WHERE guid IN (61301,61226,61307,61312,61310,61309,61236,61275,61228,61233,61235,61234,61271,61276,61247,61273,61240,61245,61242,61308,61251,61304,61239,61302,61237,61265,62030,
62038,62034,61692,61267,61262,61284,61263,61266,61253,61268,61280,61252,61270,61259,61254,61258,61298,61261,61300,61296,61257,61295,60861,60903,60907,60875,
60821,60876,60838,60869,60867,60878,60840,60911,60825,60904,86511);
DELETE FROM creature_formations WHERE memberGUID IN (61301,61226,61307,61312,61310,61309,61236,61275,61228,61233,61235,61234,61271,61276,61247,61273,61240,61245,61242,61308,61251,61304,61239,61302,61237,61265,62030,
62038,62034,61692,61267,61262,61284,61263,61266,61253,61268,61280,61252,61270,61259,61254,61258,61298,61261,61300,61296,61257,61295,60861,60903,60907,60875,
60821,60876,60838,60869,60867,60878,60840,60911,60825,60904,86511)
OR leaderGUID IN (61301,61226,61307,61312,61310,61309,61236,61275,61228,61233,61235,61234,61271,61276,61247,61273,61240,61245,61242,61308,61251,61304,61239,61302,61237,61265,62030,
62038,62034,61692,61267,61262,61284,61263,61266,61253,61268,61280,61252,61270,61259,61254,61258,61298,61261,61300,61296,61257,61295,60861,60903,
60907,60875,60821,60876,60838,60869,60867,60878,60840,60911,60825,60904,86511);

UPDATE `creature` SET `spawndist`=2 WHERE `guid`=60817;

-- Temper
-- position corrected
UPDATE creature SET position_x = -3281.537598, position_y = -12928.379883, position_z = 9.883272, orientation = 1.213798 WHERE guid = 61720;

-- Siltfin Murlocks
UPDATE creature SET position_x = -3111.356445, position_y = -11948.715820, position_z = 1.786047 WHERE guid = 60815;
UPDATE creature SET position_x = -3191.357910, position_y = -11908.882813, position_z = 2.184604 WHERE guid = 60817;
UPDATE creature SET position_x = -3206.681885, position_y = -11889.676758, position_z = 1.547595 WHERE guid = 60860;
UPDATE creature SET position_x = -3309.920410, position_y = -11880.355469, position_z = 1.236242 WHERE guid = 60833;
UPDATE creature SET position_x = -3435.718750, position_y = -11912.351563, position_z = 1.454054 WHERE guid = 60836;


-- Murgurgula
UPDATE creature SET Spawndist = 0, MovementType = 2 WHERE guid = 62989;
DELETE FROM `creature_addon` WHERE `guid`=62989;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (62989,62989,0,0,4097,0, '');
DELETE FROM waypoint_data WHERE id = 62989;
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z) VALUES
(62989,1,-3378.02,-11918.5,3.35502),
(62989,2,-3364.13,-11897,1.79093),
(62989,3,-3352.22,-11887.8,0.884004),
(62989,4,-3338.67,-11882.7,1.38813),
(62989,5,-3305.63,-11883.2,1.41506),
(62989,6,-3263.73,-11885.8,1.17472),
(62989,7,-3217.82,-11888.1,1.40486),
(62989,8,-3189.26,-11896.8,1.29253),
(62989,9,-3155.32,-11909.5,1.94541),
(62989,10,-3136.6,-11918.9,1.80227),
(62989,11,-3116.09,-11939.1,1.79153),
(62989,12,-3135.78,-11919.7,1.86409),
(62989,13,-3175.88,-11900.5,1.37822),
(62989,14,-3219.13,-11889,1.46368),
(62989,15,-3247.34,-11886.3,0.87759),
(62989,16,-3284.99,-11884.3,1.18204),
(62989,17,-3323.19,-11881.6,1.0721),
(62989,18,-3341.64,-11884.6,1.31528),
(62989,19,-3362.57,-11895.2,1.58993),
(62989,20,-3371.74,-11907,2.66572),
(62989,21,-3378.06,-11917.9,3.24772),
(62989,22,-3385.01,-11923,3.56976),
(62989,23,-3401.84,-11925.1,3.55565),
(62989,24,-3435.23,-11911.2,1.31628),
(62989,25,-3467.63,-11891,0.611871),
(62989,26,-3487.55,-11884.3,0.907164),
(62989,27,-3512.39,-11875.5,1.29932),
(62989,28,-3524.65,-11862.9,1.37204),
(62989,29,-3529.55,-11851,0.80154),
(62989,30,-3527.16,-11837.8,0.298753),
(62989,31,-3529.07,-11853.1,1.00535),
(62989,32,-3521.42,-11868.3,1.61523),
(62989,33,-3507.08,-11879.1,1.48146),
(62989,34,-3477.28,-11887.3,0.681661),
(62989,35,-3460.58,-11895.2,0.81699),
(62989,36,-3435.67,-11910.5,1.26091),
(62989,37,-3392.72,-11924.6,3.91311);

-- https://github.com/cmangos/tbc-db/blob/9634fb4e1d770934297e532be6ca082f402eeed3/Updates/640_UDB-310_Azuremyst_Isle_Pt.1.sql
-- Duplicates
DELETE FROM creature WHERE guid IN (57365,57401,57367,57392);
DELETE FROM creature_addon WHERE guid IN (57365,57401,57367,57392);

-- Vale Moth
UPDATE creature SET position_x = -4056.166748, position_y = -13679.827148, position_z = 70.195099, orientation = 2.894147 WHERE guid = 57400;
UPDATE creature SET position_x = -4009.254883, position_y = -13751.575195, position_z = 69.994392, orientation = 1.271510 WHERE guid = 57362;
UPDATE creature SET position_x = -4002.972168, position_y = -13721.668945, position_z = 66.997993, orientation = 5.467894 WHERE guid = 57364;

-- Mutated Root Lasher
DELETE FROM creature_addon WHERE guid IN (SELECT guid FROM creature WHERE id = 16517);
UPDATE creature SET position_x = -4072.798828, position_y = -13457.387695, position_z = 53.739014, orientation = 0.767300 WHERE guid = 57304;

-- Blood Elf Scout
DELETE FROM creature WHERE guid = 87660;
INSERT INTO creature (guid, id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(87660,16521,530,1,0,0,-4577.68,-13315.6,87.9318,5.06332,300,0,0,83,104,0,0); -- missing added 
UPDATE creature SET spawndist = 0, MovementType = 0 WHERE guid IN (57429,57418,57435,57419,57417,57425,57431);
UPDATE creature SET position_x = -4494.916016, position_y = -13426.375977, position_z = 50.020802, orientation = 0.199758 WHERE guid = 57424;
UPDATE creature SET position_x = -4493.666016, position_y = -13412.100586, position_z = 49.711666, orientation = 5.910391 WHERE guid = 57426;
UPDATE creature SET position_x = -4489.001953, position_y = -13347.736328, position_z = 55.123600, spawndist = 5 WHERE guid = 57433;
UPDATE creature SET position_x = -4558.07, position_y = -13383, position_z = 84.0283, orientation = 0.980421, spawndist = 0, MovementType = 0 WHERE guid = 57415;
UPDATE creature SET position_x = -4561.61, position_y = -13332, position_z = 78.297, orientation = 4.36313, spawndist = 0, MovementType = 0 WHERE guid = 57438;
UPDATE creature SET position_x = -4495.072754, position_y = -13341.267578, position_z = 54.948174, orientation = 0.872046, spawndist = 0, MovementType = 2 WHERE guid = 57432;
UPDATE creature SET spawndist = 0, MovementType = 2 WHERE guid IN (57436,57420); -- pats, but set to 0 for now

DELETE FROM `creature_addon` WHERE `guid`=57432;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (57432,57432,0,0,4097,0, '');
DELETE FROM `creature_addon` WHERE `guid`=57436;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (57436,57436,0,0,4097,0, '');
DELETE FROM `creature_addon` WHERE `guid`=57420;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (57420,57420,0,0,4097,0, '');
DELETE FROM waypoint_data WHERE id IN (57432,57436,57420);
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z,delay,action) VALUES
-- #57432
(57432, 1,-4503.06,-13357.7,54.1247, 0, 0),
(57432, 2,-4506.78,-13373.2,53.7056, 0, 0),
(57432, 3,-4507.36,-13387,53.8641, 0, 0),
(57432, 4,-4506.39,-13372.9,53.7694, 0, 0),
(57432, 5,-4502.84,-13357.5,54.1533, 0, 0),
(57432, 6,-4495.22,-13341.5,54.8385, 0, 0),
-- #57436
(57436, 1,-4537.6,-13317.9,77.7301, 0, 0),
(57436, 2,-4531.29,-13317.2,77.917, 15000, 0),
(57436, 3,-4538.35,-13312.8,77.9808, 15000, 0),
(57436, 4,-4538.11,-13320.2,77.6869, 0, 0),
(57436, 5,-4536.77,-13324.9,77.5682, 15000, 0),
(57436, 6,-4537,-13320.7,77.6223, 0, 0),
(57436, 7,-4533.12,-13307.4,77.7173, 0, 0),
(57436, 8,-4525.5,-13301.3,77.8192, 0, 0),
(57436, 9,-4516,-13301.1,76.9484, 0, 0),
(57436, 10,-4508.35,-13305,74.2754, 0, 0),
(57436, 11,-4503.76,-13309.2,70.6749, 0, 0),
(57436, 12,-4502.26,-13315,68.1374, 0, 0),
(57436, 13,-4500.93,-13322.2,64.4202, 0, 0),
(57436, 14,-4502.32,-13314.8,68.1939, 0, 0),
(57436, 15,-4505.17,-13307.9,71.7238, 0, 0),
(57436, 16,-4511.36,-13302.8,75.8496, 0, 0),
(57436, 17,-4521.51,-13300.4,77.5693, 0, 0),
(57436, 18,-4529.88,-13303.2,77.7191, 0, 0),
(57436, 19,-4536.49,-13312.7,77.9282, 0, 0),
(57436, 20,-4542.37,-13324.8,77.5282, 0, 0),
(57436, 21,-4550.38,-13333.2,77.7908, 0, 0),
(57436, 22,-4550.78,-13344.5,78.0558, 0, 0),
(57436, 23,-4548.2,-13347.2,77.6171, 0, 0),
(57436, 24,-4544.49,-13348.3,76.6312, 15000, 0),
(57436, 25,-4550.57,-13355.2,78.4657, 0, 0),
(57436, 26,-4541.91,-13366.4,75.7633, 0, 0),
(57436, 27,-4537.09,-13379.5,72.2425, 0, 0),
(57436, 28,-4526.18,-13391.8,63.0653, 0, 0),
(57436, 29,-4535.68,-13382.6,70.6931, 0, 0),
(57436, 30,-4540.1,-13371.5,74.4121, 0, 0),
(57436, 31,-4543.29,-13364.2,76.4836, 0, 0),
(57436, 32,-4549.18,-13357.4,78.4678, 0, 0),
(57436, 33,-4553.56,-13358.2,78.9982, 0, 0),
(57436, 34,-4556.42,-13365.6,82.0062, 0, 0),
(57436, 35,-4557.25,-13379.6,84.2324, 15000, 0),
(57436, 36,-4556.48,-13368.8,83.0642, 0, 0),
(57436, 37,-4554.17,-13357.4,78.9413, 0, 0),
(57436, 38,-4550.83,-13348.5,78.0941, 0, 0),
(57436, 39,-4551.95,-13326,78.1122, 15000, 0),
(57436, 40,-4552.54,-13331.4,77.8854, 0, 0),
(57436, 41,-4555.86,-13336.1,77.8128, 0, 0),
(57436, 42,-4560.8,-13337.2,77.8925, 0, 0),
(57436, 43,-4561.78,-13335,78.0228, 15000, 0),
(57436, 44,-4560.34,-13337.7,77.8832, 0, 0),
(57436, 45,-4551.95,-13333.7,77.7376, 0, 0),
(57436, 46,-4543.65,-13322.2,77.7184, 0, 0),
-- #57420
(57420, 1,-4570.33,-13342,79.7079, 0, 0),
(57420, 2,-4572.42,-13338.7,81.9836, 0, 0),
(57420, 3,-4573.8,-13332.1,85.5403, 0, 0),
(57420, 4,-4573.62,-13325.4,88.0573, 0, 0),
(57420, 5,-4571.77,-13319.3,88.317, 0, 0),
(57420, 6,-4558.65,-13302.6,85.9795, 0, 0),
(57420, 7,-4550.41,-13299,82.8511, 0, 0),
(57420, 8,-4542.54,-13296.4,79.706, 30000, 0),
(57420, 9,-4551.81,-13299.4,83.4887, 0, 0),
(57420, 10,-4558,-13302.1,85.7307, 0, 0),
(57420, 11,-4569.98,-13314.4,87.7967, 0, 0),
(57420, 12,-4574.35,-13325.8,87.9575, 0, 0),
(57420, 13,-4574.1,-13333.5,84.9354, 0, 0),
(57420, 14,-4572.79,-13338.5,82.1879, 0, 0),
(57420, 15,-4570.21,-13342.1,79.6678, 0, 0),
(57420, 16,-4565.7,-13343.3,78.4452, 30000, 0);



-- Mutated Owlkin
UPDATE creature SET spawndist = 0, MovementType = 0 WHERE guid IN (61974,57473,57466,57319,57321,57468,57467,57320,57470,57472,57474,57471,57316,57457,57458,57450,57462,57318,57463,57465,57464,57461);
UPDATE creature SET position_x = -4471.007813, position_y = -14096.670898, position_z = 109.848373, orientation = 2.725909 WHERE guid = 57464;
UPDATE creature SET position_x = -4643.638672, position_y = -13940.991211, position_z = 85.342995, orientation = 5.246780 WHERE guid = 57474;

DELETE FROM creature WHERE guid IN (101199,101198,101197,87653,87654,87660,87656,87657,87658,87659);
INSERT INTO creature (guid, id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(101199,16537,530,1,0,0,-4434.66,-13759.4,56.6934,6.16494,300,0,0,71,0,0,2),
(101198,16537,530,1,0,0,-4447.7,-13871.1,100.039,0.550673,300,0,0,71,0,0,2),
(87653,16537,530,1,0,0,-4589.24,-13965.9,82.7032,3.97444,300,0,0,71,0,0,2),
(87659,16537,530,1,0,0,-4594.7,-14003.5,86.0174,1.36692,300,0,0,71,0,0,2),
(87654,16537,530,1,0,0,-4654.6,-13981.2,85.2454,0.550101,300,5,0,71,0,0,1),
 -- Nestlewwod Owlkin
(101197,16518,530,1,0,0,-4523.47,-14045.3,108.254,1.15354,300,0,0,86,0,0,2),
(87660,16518,530,1,0,0,-4622.08,-13980.5,83.0399,5.28298,300,0,0,86,0,0,0),
(87656,16518,530,1,0,0,-4637.72,-13935.3,86.0136,5.21538,300,0,0,71,0,0,0),
(87657,16518,530,1,0,0,-4667.34,-13966,87.076,5.68662,300,0,0,86,0,0,0),
(87658,16518,530,1,0,0,-4646.43,-14010,88.6244,2.11305,300,0,0,71,0,0,0);


DELETE FROM `creature_addon` WHERE `guid`=101199;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (101199,101199,0,0,4097,0, '');
DELETE FROM `creature_addon` WHERE `guid`=101198;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (101198,101198,0,0,4097,0, '');
DELETE FROM `creature_addon` WHERE `guid`=101197;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (101197,101197,0,0,4097,0, '');
DELETE FROM `creature_addon` WHERE `guid`=87653;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (87653,87653,0,0,4097,0, '');
DELETE FROM `creature_addon` WHERE `guid`=87659;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (87659,87659,0,0,4097,0, '');
DELETE FROM waypoint_data WHERE id IN (101199,101198,101197,87653,87659);
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z) VALUES
-- #101199
(101199, 1,-4397.45,-13759,52.5403),
(101199, 2,-4387.6,-13750.7,51.187),
(101199, 3,-4384.44,-13738.6,50.5713),
(101199, 4,-4385.32,-13731.1,50.4359),
(101199, 5,-4391.07,-13724.8,50.5065),
(101199, 6,-4426.98,-13722.3,51.7162),
(101199, 7,-4437.56,-13719.7,51.5869),
(101199, 8,-4446.66,-13713.5,49.9453),
(101199, 9,-4450.02,-13707.3,48.3929),
(101199, 10,-4448.54,-13698.3,47.5457),
(101199, 11,-4440.44,-13690.5,45.7925),
(101199, 12,-4434.76,-13689.6,45.5794),
(101199, 13,-4430.11,-13694,46.9106),
(101199, 14,-4423.66,-13715.8,51.0542),
(101199, 15,-4418.28,-13721.3,51.1114),
(101199, 16,-4391.7,-13722.8,50.4426),
(101199, 17,-4381.61,-13727.8,50.2699),
(101199, 18,-4380.06,-13739.4,50.4521),
(101199, 19,-4383.25,-13752.4,50.4515),
(101199, 20,-4392.68,-13769.2,52.2511),
(101199, 21,-4390.35,-13775.7,52.1454),
(101199, 22,-4370.44,-13787.6,52.2808),
(101199, 23,-4368.16,-13791.2,52.3032),
(101199, 24,-4369.71,-13795.9,52.4165),
(101199, 25,-4379.54,-13798.8,52.1976),
(101199, 26,-4391,-13795.6,53.3708),
(101199, 27,-4392.48,-13786.4,52.7211),
(101199, 28,-4409.88,-13759.7,53.5569),
(101199, 29,-4434.79,-13759.4,56.6967),
-- #101198
(101198, 1,-4438.31,-13862.6,91.776),
(101198, 2,-4431.32,-13855.8,84.8948),
(101198, 3,-4426.89,-13851,80.9621),
(101198, 4,-4425.11,-13841,79.7135),
(101198, 5,-4425.27,-13831.5,80.3198),
(101198, 6,-4428.9,-13821.8,80.8588),
(101198, 7,-4431.14,-13808.6,82.159),
(101198, 8,-4428.98,-13822,80.8303),
(101198, 9,-4425.5,-13831.3,80.3171),
(101198, 10,-4425.99,-13848.9,80.3403),
(101198, 11,-4422.94,-13853.1,79.9921),
(101198, 12,-4405.51,-13848.8,71.1473),
(101198, 13,-4394.64,-13843.8,69.9378),
(101198, 14,-4373.31,-13829.4,69.2241),
(101198, 15,-4367.44,-13827.8,69.2241),
(101198, 16,-4374.24,-13829.8,69.2241),
(101198, 17,-4395.14,-13844.2,69.9654),
(101198, 18,-4401.71,-13847.1,70.3372),
(101198, 19,-4408.22,-13846.1,70.6981),
(101198, 20,-4410.12,-13840.5,68.5303),
(101198, 21,-4407.06,-13825,62.3528),
(101198, 22,-4406.01,-13816.6,60.4572),
(101198, 23,-4401.2,-13811.8,58.4539),
(101198, 24,-4395.99,-13804.2,55.897),
(101198, 25,-4401.33,-13812.3,58.5553),
(101198, 26,-4405.57,-13815.9,60.3377),
(101198, 27,-4407.42,-13829.5,63.9209),
(101198, 28,-4409.96,-13840.7,68.609),
(101198, 29,-4407.79,-13845.8,70.5699),
(101198, 30,-4401.1,-13847.4,70.3476),
(101198, 31,-4393.45,-13843.7,69.9347),
(101198, 32,-4373.67,-13829.4,69.2235),
(101198, 33,-4366.85,-13827.6,69.2235),
(101198, 34,-4374.52,-13829.8,69.228),
(101198, 35,-4397.51,-13845.3,70.0348),
(101198, 36,-4405.96,-13849.2,71.4118),
(101198, 37,-4420.98,-13853.4,79.1551),
(101198, 38,-4425.01,-13851.3,80.4895),
(101198, 39,-4426.2,-13842.6,79.8567),
(101198, 40,-4425.92,-13830.4,80.3672),
(101198, 41,-4429.15,-13820.9,80.9154),
(101198, 42,-4431.09,-13808.4,82.1788),
(101198, 43,-4429.49,-13822.1,80.7973),
(101198, 44,-4425.68,-13831.3,80.2927),
(101198, 45,-4425.49,-13843.3,79.8208),
(101198, 46,-4426.59,-13851.3,80.9487),
(101198, 47,-4431.98,-13856.3,85.4742),
(101198, 48,-4438.4,-13862.8,91.9377),
(101198, 49,-4446.83,-13869.7,99.5607),
(101198, 50,-4450.92,-13879.3,102.427),
(101198, 51,-4447.55,-13889,107.062),
(101198, 52,-4439.39,-13901.1,116.042),
(101198, 53,-4435.46,-13912.5,124.001),
(101198, 54,-4434.29,-13919.4,128.474),
(101198, 55,-4429.09,-13933.4,138.171),
(101198, 56,-4429.81,-13941.6,143.975),
(101198, 57,-4426.58,-13948.8,149.331),
(101198, 58,-4424.46,-13957.5,154.731),
(101198, 59,-4424.99,-13971.4,161.606),
(101198, 60,-4425,-13966.8,160.317),
(101198, 61,-4424.71,-13954.9,153.1),
(101198, 62,-4426.49,-13948.2,149.01),
(101198, 63,-4429.64,-13942,144.229),
(101198, 64,-4429.46,-13931.9,137.163),
(101198, 65,-4433.91,-13920.2,129.02),
(101198, 66,-4436.84,-13906.8,119.518),
(101198, 67,-4439.42,-13900.3,115.63),
(101198, 68,-4445.36,-13893.5,110.394),
(101198, 69,-4449.88,-13882.6,103.797),
(101198, 70,-4450.84,-13875.1,101.276),
(101198, 71,-4448.44,-13870.8,100.18),
-- #101197
(101197, 1,-4517.82,-14036.6,109.638),
(101197, 2,-4512.34,-14031.9,111.705),
(101197, 3,-4504.76,-14032,115.22),
(101197, 4,-4495.7,-14035,120.769),
(101197, 5,-4485.96,-14035.7,125.867),
(101197, 6,-4477.07,-14034.1,130.216),
(101197, 7,-4468.08,-14026.7,135.697),
(101197, 8,-4463.56,-14019.2,139.389),
(101197, 9,-4462.25,-14008.6,144.543),
(101197, 10,-4462.15,-13995.7,151.398),
(101197, 11,-4459.33,-13989.3,155.012),
(101197, 12,-4453.88,-13984,158.884),
(101197, 13,-4442.96,-13977.9,162.913),
(101197, 14,-4437.08,-13973.9,163.54),
(101197, 15,-4442.83,-13978.1,162.882),
(101197, 16,-4447.89,-13981.6,160.698),
(101197, 17,-4454.41,-13984.3,158.621),
(101197, 18,-4459.15,-13988.9,155.249),
(101197, 19,-4462.06,-13995.7,151.433),
(101197, 20,-4463.62,-14005.8,145.88),
(101197, 21,-4464.5,-14015.9,140.278),
(101197, 22,-4465.92,-14022.3,137.806),
(101197, 23,-4473.41,-14032,132.139),
(101197, 24,-4480.65,-14035.1,128.564),
(101197, 25,-4489.53,-14035.6,123.745),
(101197, 26,-4499.66,-14033.4,118.385),
(101197, 27,-4509.38,-14031.3,113.055),
(101197, 28,-4516.56,-14033.5,110.339),
(101197, 29,-4522.55,-14042.1,108.413),
(101197, 30,-4522.58,-14049.5,108.513),
(101197, 31,-4511.73,-14069.1,108.323),
(101197, 32,-4494.98,-14092.5,108.716),
(101197, 33,-4480.21,-14106.9,109.008),
(101197, 34,-4476.78,-14106.6,109.331),
(101197, 35,-4480.54,-14107,109.074),
(101197, 36,-4501.89,-14085,108.471),
(101197, 37,-4513.44,-14066.2,108.282),
(101197, 38,-4523.29,-14045.9,108.31),
(101197, 39,-4531.47,-14045.2,107.159),
(101197, 40,-4540.48,-14042.7,104.373),
(101197, 41,-4545.76,-14038.1,101.742),
(101197, 42,-4549.34,-14028.7,97.4769),
(101197, 43,-4550.8,-14014.1,91.238),
(101197, 44,-4549.57,-14028.6,97.381),
(101197, 45,-4545.99,-14038.1,101.736),
(101197, 46,-4540.46,-14042.4,104.306),
(101197, 47,-4531.34,-14045,107.178),
(101197, 48,-4522.13,-14050.4,108.592),
(101197, 49,-4503.35,-14075.6,108.32),
(101197, 50,-4475.96,-14095.1,109.774),
(101197, 51,-4473.36,-14101.2,109.944),
(101197, 52,-4474.57,-14105.7,109.152),
(101197, 53,-4480.68,-14108,109.006),
(101197, 54,-4502.26,-14085.2,108.472),
(101197, 55,-4522.41,-14050.8,108.626),
(101197, 56,-4522.98,-14042.5,108.354),
-- #87653
(87653, 1,-4592.27,-13969.7,82.8063),
(87653, 2,-4598.27,-13970.8,82.8528),
(87653, 3,-4602.71,-13969,82.9031),
(87653, 4,-4605.37,-13963.2,82.86),
(87653, 5,-4604.43,-13957.7,82.9402),
(87653, 6,-4599.52,-13953.3,83.2446),
(87653, 7,-4593.36,-13953.8,83.11),
(87653, 8,-4588.46,-13958.5,82.7968),
(87653, 9,-4588.68,-13965.4,82.7122),
-- #87659
(87659, 1,-4592.98,-13982.5,84.4159),
(87659, 2,-4586.16,-13971.4,82.9927),
(87659, 3,-4580.24,-13956.1,83.3117),
(87659, 4,-4572.24,-13945.5,83.977),
(87659, 5,-4553.06,-13927.5,84.9424),
(87659, 6,-4540.27,-13916,87.0233),
(87659, 7,-4533.76,-13907.4,89.6782),
(87659, 8,-4526.08,-13901.9,91.075),
(87659, 9,-4511.39,-13896.2,93.3214),
(87659, 10,-4501.98,-13896,95.7497),
(87659, 11,-4513.02,-13896.4,92.8177),
(87659, 12,-4524.08,-13900.5,91.1834),
(87659, 13,-4533.81,-13907.2,89.7356),
(87659, 14,-4537.63,-13911.7,87.7131),
(87659, 15,-4543.6,-13919.2,87.4545),
(87659, 16,-4552.8,-13927.3,84.9588),
(87659, 17,-4576.24,-13949,83.6602),
(87659, 18,-4589.23,-13952,83.2427),
(87659, 19,-4604.19,-13952,83.5327),
(87659, 20,-4616.22,-13947.2,83.8974),
(87659, 21,-4627.14,-13943.9,84.4674),
(87659, 22,-4637.3,-13944.4,85.009),
(87659, 23,-4649.9,-13949.8,85.5586),
(87659, 24,-4657.77,-13959.4,86.2783),
(87659, 25,-4664.29,-13969.3,86.5976),
(87659, 26,-4662.94,-13981.2,86.5135),
(87659, 27,-4659.69,-13991.1,87.4205),
(87659, 28,-4659.05,-14002.6,88.7217),
(87659, 29,-4658.11,-13991.3,87.3414),
(87659, 30,-4652.72,-13982.8,85.1681),
(87659, 31,-4644.96,-13980.1,83.6062),
(87659, 32,-4629.25,-13979.6,82.8775),
(87659, 33,-4612.33,-13973.1,83.1243),
(87659, 34,-4597.79,-13975.3,83.3084),
(87659, 35,-4592.27,-13985.8,84.9837),
(87659, 36,-4594.39,-14003.7,86.0171);


-- https://github.com/cmangos/tbc-db/blob/9634fb4e1d770934297e532be6ca082f402eeed3/Updates/649_UDB-319_Azuremyst_Isle_Pt.2.sql
-- Azuremyst Isle Pt.2

-- Duplicates
DELETE FROM creature WHERE guid IN (63772,63769,63770);
DELETE FROM creature_addon WHERE guid IN (63772,63769,63770);
DELETE FROM npc_gossip WHERE npc_guid IN (63770,63772,63769);


-- Ammen Vale Guardian - missing added
DELETE FROM creature WHERE guid IN (170000,170001,170002,170003,170004,170005,170006);
INSERT INTO creature (guid, id, map, spawnMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType) VALUES 
(170000,16921,530,1,0,0,-4247.23,-13229.8,62.089,5.67232,300,0,0,11828,0,0,0),
(170001,16921,530,1,0,0,-4251.78,-13213.4,64.4749,1.553343,300,0,0,11828,0,0,0),
(170002,16921,530,1,0,0,-4266.62,-13213.4,66.5232,1.48353,300,0,0,11828,0,0,0),
(170003,16921,530,1,0,0,-4246.85,-13189.1,68.4469,3.193953,300,0,0,11828,0,0,0),
(170004,16921,530,1,0,0,-4265.27,-13183.5,59.3392,1.815142,300,0,0,11828,0,0,0),
-- Draenei Artificer
(170005,17228,530,1,0,0,-4214.15,-12468.7,45.3208,1.77108,120,0,0,114,131,0,0),
(170006,17228,530,1,0,0,-4149.24,-12465,45.3466,5.67608,120,0,0,98,115,0,0);

-- Gossip
DELETE FROM `npc_gossip` WHERE `npc_guid` IN(170005,170006);
INSERT INTO `npc_gossip` (npc_guid,textid) VALUES
(170005,8838),
(170006,8838);

-- Valaar's Berth
DELETE FROM gameobject WHERE guid = 22304;

-- Azuremyst Peacekeeper
UPDATE creature SET position_x = -4191.937988, position_y = -12478.247070, position_z = 45.769424, orientation = 3.565038, MovementType = 2, spawndist = 0 WHERE guid = 63771;
UPDATE creature SET position_x = -4121.803223, position_y = -12498.709961, position_z = 43.091747, orientation = 0.392636, MovementType = 2, spawndist = 0 WHERE guid = 63774;
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid IN (63773,63775);
DELETE FROM `creature_addon` WHERE `guid`=63774;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`auras`) VALUES (63774,63774,0,16777472,0,4097,0, '');
UPDATE `creature_addon` SET `path_id`=63771 WHERE `guid`=63771;
UPDATE `creature_addon` SET `path_id`=63773 WHERE `guid`=63773;
UPDATE `creature_addon` SET `path_id`=63775 WHERE `guid`=63775;
DELETE FROM waypoint_data WHERE id IN (63771,63773,63774,63775);
INSERT INTO waypoint_data (id, point, position_x, position_y, position_z, delay, action) VALUES
-- #63771
(63771,1,-4205.66,-12485.6,44.6914, 0, 0),
(63771,2,-4208.53,-12498.6,44.4324, 0, 0),
(63771,3,-4204.51,-12510.6,44.8193, 0, 0),
(63771,4,-4193.44,-12522.6,44.6915, 0, 0),
(63771,5,-4176.15,-12527.4,44.6961, 0, 0),
(63771,6,-4163.38,-12521.9,44.6597, 0, 0),
(63771,7,-4155.31,-12511.3,44.8935, 0, 0),
(63771,8,-4153.65,-12498,44.3924, 0, 0),
(63771,9,-4156.06,-12489.1,44.4723, 0, 0),
(63771,10,-4169.8,-12465.3,44.482, 0, 0),
(63771,11,-4172.35,-12441.4,43.6913, 0, 0),
(63771,12,-4183.24,-12464.9,44.8085, 0, 0),
(63771,13,-4193.13,-12477.9,45.7905, 0, 0),
-- #63773
(63773,1,-4233.12,-12487.6,41.7459, 1000, 0),
(63773,2,-4253.76,-12480.8,34.8627, 0, 0),
(63773,3,-4268.75,-12476.1,29.0027, 0, 0),
(63773,4,-4288.66,-12471.6,24.2334, 0, 0),
(63773,5,-4309.47,-12477.6,20.8072, 0, 0),
(63773,6,-4320.71,-12477.5,18.5734, 0, 0),
(63773,7,-4337.38,-12470.9,14.84, 0, 0),
(63773,8,-4368.72,-12468.9,9.63387, 0, 0),
(63773,9,-4396.24,-12458.8,5.97987, 0, 0),
(63773,10,-4413.7,-12450.7,3.52516, 0, 0),
(63773,11,-4441.16,-12442.9,2.06393, 0, 0),
(63773,12,-4463.41,-12432.1,2.65485, 0, 0),
(63773,13,-4488,-12421.2,3.67053, 0, 0),
(63773,14,-4502.04,-12413.8,4.58676, 0, 0),
(63773,15,-4528.75,-12416.2,6.93748, 0, 0),
(63773,16,-4545,-12415.7,8.3341, 0, 0),
(63773,17,-4567.34,-12417.9,9.11502, 0, 0),
(63773,18,-4545.31,-12416.2,8.32012, 0, 0),
(63773,19,-4524.5,-12416.2,6.32431, 0, 0),
(63773,20,-4506.8,-12413.8,4.77744, 0, 0),
(63773,21,-4488.36,-12419.3,3.81805, 0, 0),
(63773,22,-4462.29,-12432.7,2.63905, 0, 0),
(63773,23,-4444.97,-12442.7,1.96238, 0, 0),
(63773,24,-4412.28,-12451.8,3.74838, 0, 0),
(63773,25,-4389.28,-12461.4,6.76621, 0, 0),
(63773,26,-4373.72,-12469.6,9.03604, 0, 0),
(63773,27,-4363.62,-12473.2,10.645, 0, 0),
(63773,28,-4337.64,-12470.9,14.7957, 0, 0),
(63773,29,-4320.31,-12477.7,18.6569, 0, 0),
(63773,30,-4309.21,-12477.5,20.8536, 0, 0),
(63773,31,-4288.19,-12471.8,24.3448, 0, 0),
(63773,32,-4267.45,-12476.5,29.4462, 0, 0),
(63773,33,-4254.15,-12480.6,34.7295, 0, 0),
(63773,34,-4233.21,-12487.7,41.7129, 0, 0),
(63773,35,-4208.26,-12501.5,44.7111, 0, 0),
(63773,36,-4187.88,-12513.6,44.3435, 0, 0),
(63773,37,-4172.63,-12514.9,44.3647, 0, 0),
(63773,38,-4156.03,-12509,44.4737, 0, 0),
(63773,39,-4133.4,-12503.9,43.4838, 1000, 0),
(63773,40,-4162.65,-12511.3,44.391, 0, 0),
(63773,41,-4177.89,-12515.7,44.3673, 0, 0),
(63773,42,-4189.41,-12512.8,44.3664, 0, 0),
(63773,43,-4219.91,-12494.9,44.1521, 0, 0),
-- #63774
(63774,1,-4106.05,-12492.3,41.6468, 1000, 0),
(63774,2,-4088.56,-12487.2,38.7601, 0, 0),
(63774,3,-4074.76,-12477,36.6925, 0, 0),
(63774,4,-4056.05,-12470.8,33.9505, 0, 0),
(63774,5,-4034.42,-12460.5,30.9639, 0, 0),
(63774,6,-4018.51,-12459.1,28.2487, 0, 0),
(63774,7,-3982.07,-12444.5,21.3301, 0, 0),
(63774,8,-3962.04,-12437.8,17.0843, 0, 0),
(63774,9,-3942.13,-12427.6,12.5359, 0, 0),
(63774,10,-3921.28,-12428.5,8.93809, 0, 0),
(63774,11,-3890.14,-12421.4,2.94878, 0, 0),
(63774,12,-3855.8,-12404.4,-0.599702, 0, 0),
(63774,13,-3835.38,-12399.9,-0.790897, 0, 0),
(63774,14,-3796.89,-12397.1,-1.57472, 0, 0),
(63774,15,-3782.26,-12398.9,-1.78966, 0, 0),
(63774,16,-3763.04,-12388.9,-1.70261, 0, 0),
(63774,17,-3722.08,-12384.9,-3.18091, 0, 0),
(63774,18,-3684.53,-12370.5,-3.32684, 0, 0),
(63774,19,-3643.22,-12356.1,-2.45317, 0, 0),
(63774,20,-3627.6,-12355.1,-1.34103, 0, 0),
(63774,21,-3604.32,-12361.9,0.61728, 0, 0),
(63774,22,-3565.76,-12359.3,3.63315, 0, 0),
(63774,23,-3604.17,-12361.8,0.635082, 0, 0),
(63774,24,-3627.97,-12355,-1.34952, 0, 0),
(63774,25,-3642.15,-12355.8,-2.40368, 0, 0),
(63774,26,-3662.5,-12360,-2.69549, 0, 0),
(63774,27,-3700.76,-12378.8,-3.49316, 0, 0),
(63774,28,-3728.97,-12385.9,-3.05378, 0, 0),
(63774,29,-3749.81,-12385,-1.97987, 0, 0),
(63774,30,-3764.88,-12387.6,-1.69781, 0, 0),
(63774,31,-3783.67,-12397.7,-1.81325, 0, 0),
(63774,32,-3809.32,-12396.3,-1.48745, 0, 0),
(63774,33,-3846.04,-12400.8,-0.593908, 0, 0),
(63774,34,-3874.13,-12412.1,0.695393, 0, 0),
(63774,35,-3892.58,-12422.1,3.30651, 0, 0),
(63774,36,-3908.92,-12423.9,6.47097, 0, 0),
(63774,37,-3924.91,-12429,9.35508, 0, 0),
(63774,38,-3948.46,-12428.2,13.8682, 0, 0),
(63774,39,-3976.52,-12445.1,20.2205, 0, 0),
(63774,40,-3993.88,-12447,23.7009, 0, 0),
(63774,41,-4019.37,-12458.6,28.3566, 0, 0),
(63774,42,-4036.01,-12459.6,31.0169, 0, 0),
(63774,43,-4061.94,-12473.4,34.7949, 0, 0),
(63774,44,-4078.57,-12478.3,37.0618, 0, 0),
(63774,45,-4090.85,-12487.5,39.2156, 0, 0),
(63774,46,-4115.91,-12495.1,42.6562, 0, 0),
(63774,47,-4135.13,-12503,43.4695, 0, 0),
(63774,48,-4155.84,-12502.8,44.2209, 0, 0),
(63774,49,-4172.29,-12490.5,44.0644, 0, 0),
(63774,50,-4183.76,-12489.3,44.3628, 0, 0),
(63774,51,-4202.05,-12497.1,44.3641, 0, 0),
(63774,52,-4216.59,-12495.1,44.3567, 0, 0),
(63774,53,-4232.25,-12489.8,42.0015, 1000, 0),
(63774,54,-4207.35,-12497.7,44.4138, 0, 0),
(63774,55,-4192.17,-12498.4,44.3717, 0, 0),
(63774,56,-4183.4,-12489.6,44.3618, 0, 0),
(63774,57,-4172.96,-12490.9,44.1005, 0, 0),
(63774,58,-4160.64,-12501.8,44.3744, 0, 0),
(63774,59,-4135.05,-12503.6,43.5005, 0, 0),
-- #63775
(63775,1,-4252.89,-12393.9,14.5194, 0, 0),
(63775,2,-4236.92,-12362,8.88869, 0, 0),
(63775,3,-4221.71,-12334.4,3.76085, 0, 0),
(63775,4,-4207.3,-12310.4,1.43233, 0, 0),
(63775,5,-4193.96,-12289,0.234154, 0, 0),
(63775,6,-4177.63,-12268.3,-0.362697, 0, 0),
(63775,7,-4160.39,-12248.7,-0.90721, 0, 0),
(63775,8,-4153.88,-12237.2,-0.976952, 0, 0),
(63775,9,-4140.68,-12203.6,-1.06667, 0, 0),
(63775,10,-4127.23,-12173.1,-1.24787, 0, 0),
(63775,11,-4115.24,-12148,-1.53803, 0, 0),
(63775,12,-4105.68,-12132.6,-0.95673, 0, 0),
(63775,13,-4094.46,-12115.3,-1.12745, 0, 0),
(63775,14,-4082.87,-12103.9,-0.749816, 0, 0),
(63775,15,-4078.97,-12096.5,-0.560868, 0, 0),
(63775,16,-4075.17,-12077.3,-0.529888, 0, 0),
(63775,17,-4069.51,-12055,-1.09205, 0, 0),
(63775,18,-4073.41,-12026.3,-1.53289, 0, 0),
(63775,19,-4073.54,-12016.2,-1.32729, 0, 0),
(63775,20,-4070.18,-12003,-1.09959, 0, 0),
(63775,21,-4073.9,-12022.1,-1.5401, 0, 0),
(63775,22,-4069.62,-12052.3,-1.14399, 0, 0),
(63775,23,-4071.28,-12066.1,-0.960025, 0, 0),
(63775,24,-4078.13,-12086.2,-0.369815, 0, 0),
(63775,25,-4080.28,-12101.7,-0.643288, 0, 0),
(63775,26,-4084.06,-12106.7,-0.643821, 0, 0),
(63775,27,-4094.83,-12115.7,-1.1648, 0, 0),
(63775,28,-4105.67,-12132.2,-0.74096, 0, 0),
(63775,29,-4118.7,-12153.8,-1.5499, 0, 0),
(63775,30,-4130.34,-12179.3,-1.19709, 0, 0),
(63775,31,-4141.06,-12205.1,-1.01354, 0, 0),
(63775,32,-4151.27,-12231.1,-0.87849, 0, 0),
(63775,33,-4157.82,-12245.5,-0.7944, 0, 0),
(63775,34,-4166.52,-12257.3,-0.743649, 0, 0),
(63775,35,-4186.14,-12278,-0.193023, 0, 0),
(63775,36,-4199.8,-12296.4,0.450192, 0, 0),
(63775,37,-4212.18,-12317.5,1.91781, 0, 0),
(63775,38,-4227.93,-12344.8,5.56905, 0, 0),
(63775,39,-4239.32,-12366.5,9.91899, 0, 0),
(63775,40,-4246.31,-12383.7,12.9142, 0, 0),
(63775,41,-4258.05,-12400.7,15.6502, 0, 0),
(63775,42,-4271.89,-12426.1,18.9704, 0, 0),
(63775,43,-4283.4,-12441.8,21.1821, 0, 0),
(63775,44,-4288.12,-12454.5,22.8085, 0, 0),
(63775,45,-4287.93,-12469.4,24.3007, 0, 0),
(63775,46,-4279.27,-12473.6,26.3407, 0, 0),
(63775,47,-4260.21,-12479.1,32.2185, 0, 0),
(63775,48,-4231.34,-12490,42.2273, 0, 0),
(63775,49,-4248.46,-12482.2,36.9041, 0, 0),
(63775,50,-4269.78,-12476.8,28.7176, 0, 0),
(63775,51,-4283.67,-12472.2,25.4016, 0, 0),
(63775,52,-4288.29,-12466.3,24.1346, 0, 0),
(63775,53,-4286.72,-12449.5,22.2292, 0, 0),
(63775,54,-4281.04,-12437.8,20.8325, 0, 0),
(63775,55,-4269.86,-12424.9,18.708, 0, 0),
(63775,56,-4265.07,-12413.7,17.6402, 0, 0);


-- Issue: https://github.com/Looking4Group/L4G_Core/issues/3237
UPDATE `gameobject` SET `spawnmask`=0 WHERE `id`=186334; -- Despawn traps. It should not trigger on player vicinity, but don't know of a way to fix it
UPDATE `gameobject_template` SET `data10`=42421 WHERE `entry`=186332; -- Make the goober cast the spell instead

SET @GUID := 99246;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (99246, 1, 232.76, 3937.89, 73.8229, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 2, 127.357, 3989.36, 74.0902, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 3, 39.2732, 4035.53, 77.5754, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 4, -42.367, 4069.61, 87.9787, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 5, -48.6811, 4090.38, 82.7085, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 6, -58.4717, 4129.36, 82.3826, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 7, -117.141, 4202.16, 84.877, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 8, -153.732, 4213.5, 91.0064, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 9, -186.341, 4214.25, 94.9364, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 10, -193.176, 4218.66, 92.6077, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 11, -250.742, 4254.14, 95.3126, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 12, -401.634, 4299.24, 68.1546, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 13, -467.774, 4332.19, 46.2049, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 14, -483.463, 4336.8, 36.7254, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 15, -502.722, 4329.19, 43.0874, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 16, -639.201, 4305, 50.7146, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 17, -653.528, 4292.33, 44.3617, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 18, -681.279, 4297.77, 47.6205, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 19, -718.811, 4304.84, 49.6691, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 20, -779.043, 4318.45, 51.2479, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 21, -718.811, 4304.84, 49.6691, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 22, -681.279, 4297.77, 47.6205, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 23, -653.528, 4292.33, 44.3617, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 24, -639.201, 4305, 50.7146, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 25, -502.722, 4329.19, 43.0874, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 26, -483.463, 4336.8, 36.7254, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 27, -467.774, 4332.19, 46.2049, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 28, -401.634, 4299.24, 68.1546, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 29, -250.742, 4254.14, 95.3126, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 30, -193.176, 4218.66, 92.6077, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 31, -186.341, 4214.25, 94.9364, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 32, -153.732, 4213.5, 91.0064, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 33, -117.141, 4202.16, 84.877, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 34, -58.4717, 4129.36, 82.3826, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 35, -48.6811, 4090.38, 82.7085, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 36, -42.367, 4069.61, 87.9787, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 37, 39.2732, 4035.53, 77.5754, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99246, 38, 127.357, 3989.36, 74.0902, 0, 0, 0, 0, 0);

SET @GUID := 99247;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (99247, 1, -219.062, 3218.44, -74.5798, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 2, -237.769, 3297.4, -61.0024, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 3, -273.476, 3335.09, -56.5745, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 4, -290.626, 3412.91, -33.1171, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 5, -304.657, 3525.99, -4.98451, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 6, -342.322, 3649.84, 29.3, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 7, -357.017, 3664.84, 29.4163, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 8, -368.37, 3682.54, 29.1019, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 9, -409.321, 3708.29, 31.5923, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 10, -468.548, 3726.96, 29.0099, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 11, -585.002, 3759.98, 29.1668, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 12, -624.797, 3781.56, 28.9993, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 13, -639.006, 3879.74, 28.9962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 14, -670.006, 3914.67, 28.9962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 15, -718.356, 3926.31, 29.1268, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 16, -747.768, 3976.12, 30.3253, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 17, -740.836, 4026.18, 30.8922, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 18, -875.24, 4088.89, 32.9705, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 19, -942.019, 4158.65, 32.8769, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 20, -875.24, 4088.89, 32.9705, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 21, -740.836, 4026.18, 30.8922, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 22, -747.768, 3976.12, 30.3253, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 23, -718.356, 3926.31, 29.1268, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 24, -670.006, 3914.67, 28.9962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 25, -639.006, 3879.74, 28.9962, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 26, -624.797, 3781.56, 28.9993, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 27, -585.002, 3759.98, 29.1668, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 28, -468.548, 3726.96, 29.0099, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 29, -409.321, 3708.29, 31.5923, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 30, -368.37, 3682.54, 29.1019, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 31, -357.017, 3664.84, 29.4163, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 32, -342.322, 3649.84, 29.3, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 33, -304.657, 3525.99, -4.98451, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 34, -290.626, 3412.91, -33.1171, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 35, -273.476, 3335.09, -56.5745, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99247, 36, -237.769, 3297.4, -61.0024, 0, 0, 0, 0, 0);

SET @GUID := 99248;
DELETE FROM `creature_addon` WHERE `guid` = @GUID;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@GUID,@GUID,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` = @GUID;
INSERT INTO `waypoint_data` VALUES (99248, 1, -974.648, 2456.8, 5.998, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 2, -957.331, 2491, 5.38956, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 3, -981.882, 2553.38, 3.31046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 4, -993.082, 2623.02, 6.20042, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 5, -1003.46, 2705.02, 7.75319, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 6, -1013.06, 2772.37, -3.07673, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 7, -995.455, 2837.84, -4.80545, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 8, -1035.22, 2866.6, -4.05703, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 9, -1060.35, 2935.15, 1.27594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 10, -1058.14, 3000.11, 9.1404, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 11, -1015.99, 3031.96, 14.474, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 12, -959.32, 3036.92, 15.3494, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 13, -899.073, 3097.61, 14.797, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 14, -936.309, 3193.87, 32.329, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 15, -1007.81, 3265.01, 57.342, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 16, -1058.07, 3286.94, 71.5405, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 17, -1069.15, 3312.48, 78.9817, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 18, -1036.7, 3336.42, 86.2801, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 19, -988.644, 3396.75, 91.5886, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 20, -882.297, 3445.9, 93.4638, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 21, -800.89, 3414.12, 76.5468, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 22, -750.104, 3469.66, 90.8278, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 23, -800.89, 3414.12, 76.5468, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 24, -882.297, 3445.9, 93.4638, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 25, -988.644, 3396.75, 91.5886, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 26, -1036.7, 3336.42, 86.2801, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 27, -1069.15, 3312.48, 78.9817, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 28, -1058.07, 3286.94, 71.5405, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 29, -1007.81, 3265.01, 57.342, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 30, -936.309, 3193.87, 32.329, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 31, -899.073, 3097.61, 14.797, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 32, -959.32, 3036.92, 15.3494, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 33, -1015.99, 3031.96, 14.474, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 34, -1058.14, 3000.11, 9.1404, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 35, -1060.35, 2935.15, 1.27594, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 36, -1035.22, 2866.6, -4.05703, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 37, -995.455, 2837.84, -4.80545, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 38, -1013.06, 2772.37, -3.07673, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 39, -1003.46, 2705.02, 7.75319, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 40, -993.082, 2623.02, 6.20042, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 41, -981.882, 2553.38, 3.31046, 0, 0, 0, 0, 0);
INSERT INTO `waypoint_data` VALUES (99248, 42, -957.331, 2491, 5.38956, 0, 0, 0, 0, 0);

DELETE FROM `gameobject_template` WHERE `entry` = 3239;
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `castBarCaption`, `faction`, `flags`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `ScriptName`) VALUES (3239, 3, 41, 'Benedict\'s Chest', '', 0, 0, 1, 68, 2483, 0, 0, 0, 0, 498, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '');

DELETE FROM `gameobject_loot_template` WHERE `entry` = 2483;
INSERT INTO `gameobject_loot_template` (`entry`, `item`, `ChanceOrQuestChance`, `groupid`, `mincountOrRef`, `maxcount`, `lootcondition`, `condition_value1`, `condition_value2`) VALUES (2483, 4881, 100, 0, 1, 1, 0, 0, 0);

UPDATE `gameobject_template` SET `faction` = 0 WHERE `entry` IN (3240,3685);
DELETE FROM `gameobject_loot_template` WHERE `entry` = 2620 AND `item` IN (15277,15290,18793,18794,18795);
UPDATE `gameobject_loot_template` SET `maxcount` = 3 WHERE `entry` = 2620;

UPDATE `creature_template` SET `ScriptName`='npc_kerlonian' WHERE `entry`=11218;

DELETE FROM `script_texts` WHERE `entry`=-1000434;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000434, 'Liladris has been waiting for me at Maestra\'s Post, so we should make haste, $N.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_START');
DELETE FROM `script_texts` WHERE `entry`=-1000435;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000435, 'looks very sleepy...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, 'kerlonian EMOTE_KER_SLEEP_1');
DELETE FROM `script_texts` WHERE `entry`=-1000436;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000436, 'suddenly falls asleep', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, 'kerlonian EMOTE_KER_SLEEP_2');
DELETE FROM `script_texts` WHERE `entry`=-1000437;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000437, 'begins to drift off...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 2, 0, 0, 'kerlonian EMOTE_KER_SLEEP_3');
DELETE FROM `script_texts` WHERE `entry`=-1000438;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000438, 'This looks like the perfect place for a nap...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_SLEEP_1');
DELETE FROM `script_texts` WHERE `entry`=-1000439;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000439, 'Yaaaaawwwwwnnnn...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_SLEEP_2');
DELETE FROM `script_texts` WHERE `entry`=-1000440;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000440, 'Oh, I am so tired...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_SLEEP_3');
DELETE FROM `script_texts` WHERE `entry`=-1000441;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000441, 'You don\'t mind if I stop here for a moment, do you?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_SLEEP_4');
DELETE FROM `script_texts` WHERE `entry`=-1000442;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000442, 'Be on the alert! The Blackwood furbolgs are numerous in the area...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_ALERT_1');
DELETE FROM `script_texts` WHERE `entry`=-1000443;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000443, 'It\'s quiet... Too quiet...', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_ALERT_2');
DELETE FROM `script_texts` WHERE `entry`=-1000444;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES (-1000444, 'Oh, I can see Liladris from here... Tell her I\'m here, won\'t you?', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 'kerlonian SAY_KER_END');

UPDATE `creature_template` SET `mindmg`='486',`maxdmg`='733' WHERE `entry` = 22398;
UPDATE `creature_template` SET `mindmg`='2140',`maxdmg`='2689' WHERE `entry` = 22399;

UPDATE `creature_template` SET `mindmg`='377',`maxdmg`='646' WHERE `entry` = 17817;
UPDATE `creature_template` SET `mindmg`='4235',`maxdmg`='5029' WHERE `entry` = 19892;

UPDATE `creature_template` SET `mindmg`='5886',`maxdmg`='6987' WHERE `entry` = 18829;
UPDATE `creature_template` SET `mindmg`='5434',`maxdmg`='6449' WHERE `entry` = 17256;
UPDATE `creature_template` SET `mindmg`='505',`maxdmg`='714' WHERE `entry` = 17454;
UPDATE `creature_template` SET `mindmg`='13261',`maxdmg`='15748' WHERE `entry` = 17257;

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 5336;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 5336;
INSERT INTO `creature_ai_scripts` VALUES
(533601,5336,0,0,100,0,0,0,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Hatecrest Sorceress- Start Movement on Aggro'),
(533602,5336,4,0,100,0,0,0,0,0,11,20822,1,0,22,1,0,0,0,0,0,0,'Hatecrest Sorceress- Cast Frostbolt and Set Phase 1 on Aggro'),
(533603,5336,9,13,100,1,0,40,3000,4000,11,20822,1,0,0,0,0,0,0,0,0,0,'Hatecrest Sorceress - Cast Frostbolt (Phase 1)'),
(533604,5336,3,13,100,0,15,0,0,0,21,1,0,0,22,2,0,0,0,0,0,0,'Hatecrest Sorceress - Start Movement and Set Phase 2 when Mana is at 15%'),
(533605,5336,9,13,100,1,25,80,0,0,21,1,0,0,0,0,0,0,0,0,0,0,'Hatecrest Sorceress - Start Movement Beyond 25 Yards'),
(533606,5336,3,11,100,1,100,30,100,100,22,1,0,0,0,0,0,0,0,0,0,0,'Hatecrest Sorceress - Set Phase 1 when Mana is above 30% (Phase 2)'),
(533607,5336,2,0,100,0,15,0,0,0,22,3,0,0,0,0,0,0,0,0,0,0,'Hatecrest Sorceress - Set Phase 3 at 15% HP'),
(533608,5336,2,7,100,0,15,0,0,0,21,1,0,0,25,0,0,0,1,-47,0,0,'Hatecrest Sorceress- Start Movement and Flee at 15% HP (Phase 3)'),
(533609,5336,7,0,100,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,'Hatecrest Sorceress - On Evade set Phase to 0');

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 5333;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 5333;
INSERT INTO `creature_ai_scripts` VALUES
(533301,5333,9,0,100,1,0,25,10000,13000,11,8058,4,32,0,0,0,0,0,0,0,0,'Hatecrest Serpent Guard - Cast Frost Shock'),
(533302,5333,2,0,100,0,15,0,0,0,25,0,0,0,1,-47,0,0,0,0,0,0,'Hatecrest Serpent Guard - Flee at 15% HP');

UPDATE `creature_template` SET `AIName` = 'EventAI' WHERE `entry` = 8136;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 8136;
INSERT INTO `creature_ai_scripts` VALUES
(813601,8136,9,0,100,1,0,25,16000,21000,11,8058,4,0,0,0,0,0,0,0,0,0,'Lord Shalzaru - Cast Frost Shock');

UPDATE `creature_template` SET `mindmg`='3347',`maxdmg`='3549' WHERE `entry` = 18615;
UPDATE `creature_template` SET `mindmg`='377',`maxdmg`='546' WHERE `entry` = 17816;
UPDATE `creature_template` SET `mindmg`='738',`maxdmg`='1007' WHERE `entry` = 16699;
UPDATE `creature_template` SET `mindmg`='3550',`maxdmg`='3825' WHERE `entry` = 20621;
UPDATE `creature_template` SET `mindmg`='3738',`maxdmg`='3932' WHERE `entry` = 20626;
UPDATE `creature_template` SET `mindmg`='5015',`maxdmg`='5956' WHERE `entry` = 21591;
UPDATE `creature_template` SET `mindmg`='5015',`maxdmg`='5956' WHERE `entry` = 21593;
UPDATE `creature_template` SET `mindmg`='6521',`maxdmg`='7778' WHERE `entry` = 21614;
UPDATE `creature_template` SET `mindmg`='7755',`maxdmg`='9207' WHERE `entry` = 21594;
UPDATE `creature_template` SET `mindmg`='6721',`maxdmg`='7978' WHERE `entry` = 21595;
UPDATE `creature_template` SET `mindmg`='4215',`maxdmg`='5156' WHERE `entry` = 21610;
UPDATE `creature_template` SET `mindmg`='4215',`maxdmg`='5156' WHERE `entry` = 21611;

DELETE FROM `creature_ai_scripts` WHERE `id` IN (535902,536002);
INSERT INTO `creature_ai_scripts` VALUES
(535902,5359,9,0,100,1,0,5,11000,15000,11,10987,0,1,0,0,0,0,0,0,0,0,'Shore Strider - Cast Geyser'),
(536002,5360,9,0,100,1,0,5,11000,15000,11,10987,0,1,0,0,0,0,0,0,0,0,'Deep Strider - Cast Geyser');

-- https://github.com/cmangos/tbc-db/blob/2a0a0af0cbd277651603011e062bb5b72e7cfcbe/Updates/800_UDB-455_quest_4743.sql#L1
-- q.4743 'Seal of Ascension'
-- correct spell target
DELETE FROM spell_script_target WHERE entry IN (16053,16054);
INSERT INTO spell_script_target (entry,type,targetEntry) VALUES
(16053,1,10321),
(16054,0,175321);

DELETE FROM `creature_ai_texts` WHERE `entry` IN(-1460,-1497,-1481,-1028,-1029,-1030,-1031,-1032,-1033,-1034,-1459);
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1460','Who dares to interrupt my operations?','0','1','0','Nexus-Prince Razaan spawn','0'),
('-1497','\'s will falters.','0','2','0','10321','0'),
('-1481','\'s physical form is weakened. You notice the Stone of Binding near the creature is glowing! Strike now!','0','2','0','2681','0'),
('-1028','The Scarlet Crusade shall smite the wicked and drive evil from these lands!','0','0','7','Common Scarlet Text','0'),
('-1029','You carry the taint of the scourge.  Prepare to enter the twisting nether.','0','0','7','Common Scarlet Text','0'),
('-1030','The Scarlet Crusade shall not fail in it\'s mission!','0','0','7','1667','0'),
('-1031','These undead atrocities will be destroyed!','0','0','0','1667','0'),
('-1032','These lands shall be cleansed!','0','0','0','1667','0'),
('-1033','Here to visit the family? Die, fool!','0','0','0','1657','0'),
('-1034','The Agamand Mills is held by the Scourge, $c. Join us!','0','0','0','1657','0'),
('-1459','begins intensely dodging incoming attacks.','0','2','0','Demon Hunter Supplicant','0');

UPDATE `creature` SET `spawndist`=1 WHERE `guid`=29883;

UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN(10756,10757,8280,8278,21057,10321,18046,1553,1554,1555,1654,1657,1660,1662,1664,1665,1667,1674,1675,
1688,1545,1540,1543,1523,1525,1526,1527,1528,1529,1530,1531,1532,1533,1534,1535,1536,1537,1538,1508,1509,1502,1504,1505,1506,1753,1765,1918,1934,1935,1936,1941,10359,11022,13158,15195,347,2804,
5655,5656,5657,5658,5659,5660,5677,5735,20386,21179,22025);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN(10756,10757,8280,8278,21057,10321,18046,1553,1554,1555,1654,1657,1660,1662,1664,1665,1667,1674,1675,
1688,1545,1540,1543,1523,1525,1526,1527,1528,1529,1530,1531,1532,1533,1534,1535,1536,1537,1538,1508,1509,1502,1504,1505,1506,1753,1765,1918,1934,1935,1936,1941,10359,11022,13158,15195,347,2804,
5655,5656,5657,5658,5659,5660,5677,5735,20386,21179,22025);
INSERT INTO `creature_ai_scripts` (`id`,`entryOrGUID`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
-- Scalding Elemental
('1075601','10756','9','0','100','1','0','20','15000','18000','11','17276','4','1','0','0','0','0','0','0','0','0','Scalding Elemental - Cast Scald'),
-- Boiling Elemental
('1075701','10757','9','0','100','1','0','5','12000','15000','11','11983','0','1','0','0','0','0','0','0','0','0','Boiling Elemental - Cast Steam Jet'),
-- Shleipnarr
('828001','8280','9','0','100','1','0','30','9000','15000','11','13321','4','0','0','0','0','0','0','0','0','0','Shleipnarr - Cast Mana Burn'),
('828002','8280','0','0','100','1','5000','8000','9000','13000','11','7399','4','0','0','0','0','0','0','0','0','0','Shleipnarr - Cast Terrify'),
-- Smoldar      
('827801','8278','9','0','100','1','0','5','17000','21000','11','5213','1','0','0','0','0','0','0','0','0','0','Smoldar - Cast Molten Metal'),
-- Nexus-Prince Razaan
('2105701','21057','11','0','100','0','0','0','0','0','1','-1460','0','0','0','0','0','0','0','0','0','0','Nexus-Prince Razaan yell on spawn'),
('2105702','21057','0','0','100','1','8000','12000','17000','21000','11','35924','0','0','0','0','0','0','0','0','0','0','Nexus-Prince Razaan - Cast Energy Flux'),
-- Emberstrife      
('1032101','10321','9','0','100','1','0','5','8000','11000','11','40504','1','0','0','0','0','0','0','0','0','0','Emberstrife - Cast Cleave'),
('1032102','10321','0','0','100','1','7000','9000','10000','12000','11','9573','1','0','0','0','0','0','0','0','0','0','Emberstrife - Cast Flame Breath'),
('1032103','10321','2','0','100','1','30','0','120000','120000','11','8269','0','1','1','-106','0','0','0','0','0','0','Emberstrife - Cast Frenzy at 30% HP'),
('1032104','10321','2','0','100','0','10','0','0','0','1','-1497','0','0','0','0','0','0','0','0','0','0','Emberstrife - Textemote at 10% HP'),
-- Rajah Haghazed
('1804601',' 18046',' 0',' 0',' 100',' 1',' 0',' 1000',' 9000',' 11000',' 11',' 35472',' 4',' 1',' 0',' 0',' 0',' 0',' 0',' 0',' 0',' 0','Rajah Haghazed - Cast Shield Charge'),
('1804602',' 18046',' 0',' 0',' 100',' 1',' 2000',' 3000',' 5000',' 6000',' 11',' 16856',' 1',' 0',' 0',' 0',' 0',' 0',' 0',' 0',' 0',' 0','Rajah Haghazed - Cast Mortal Strike'),
('1804603',' 18046',' 0',' 0',' 100',' 1',' 5000',' 6000',' 16000',' 19000',' 11',' 35473',' 1',' 0',' 0',' 0',' 0',' 0',' 0',' 0',' 0',' 0','Rajah Haghazed - Cast Forceful Cleave'),
('1804604',' 18046',' 2',' 0',' 100',' 0',' 25',' 0',' 0',' 0',' 11',' 15062',' 0',' 1',' 0',' 0',' 0',' 0',' 0',' 0',' 0',' 0','Rajah Haghazed - Cast Shield Wall at 25% HP'),
-- Greater Duskbat
('155301','1553','9','0','100','1','0','5','7000','12000','11','3242','1','0','0','0','0','0','0','0','0','0','Greater Duskbat - Cast Ravage'),
-- Vampiric Duskbat
('155401','1554','9','0','100','1','0','5','7000','12000','11','3242','1','0','0','0','0','0','0','0','0','0','Vampiric Duskbat - Cast Ravage'),
-- Vicious Night Web Spider
('155501','1555','11','0','100','0','0','0','0','0','11','3616','0','1','0','0','0','0','0','0','0','0','Vicious Night Web Spider - Cast Poison Proc on Spawn'),
-- Gregor Agamand 
('165401','1654','1','0','100','0','0','0','0','0','11','26047','0','0','0','0','0','0','0','0','0','0','Gregor Agamand - Cast Birth on Spawn'),
-- Devilin Agamand
('165701','1657','4','0','60','0','0','0','0','0','1','-1033','-1034','0','0','0','0','0','0','0','0','0','Devlin Agamand - Random Say on Aggro'),
('165702','1657','9','0','100','1','0','5','16000','30000','11','3148','1','0','0','0','0','0','0','0','0','0','Devilin Agamand  - Cast Head Crack'),
-- Scarlet Bodyguard
('166001','1660','4','0','35','0','0','0','0','0','1','-897','-1028','-896','0','0','0','0','0','0','0','0','Scarlet Bodyguard - Random Say on Aggro'),
('166002','1660','0','0','100','1','1000','7000','5000','28000','11','12169','0','0','0','0','0','0','0','0','0','0','Scarlet Bodyguard - Cast Shield Block'),
('166003','1660','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Scarlet Bodyguard - Flee at 15% HP'),
-- Captian Perrine
('166201','1662','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Captian Perrine - Flee at 15% HP'),
-- Captain Vachon
('166401','1664','0','0','100','1','1000','3000','182000','186000','11','7164','0','1','0','0','0','0','0','0','0','0','Captain Vachon - Cast Defensive Stance'),
('166402','1664','0','0','100','1','8000','14000','18000','30000','11','3248','0','0','0','0','0','0','0','0','0','0','Captain Vachon - Cast Improved Blocking'),
('166403','1664','9','0','100','1','0','5','16000','24000','11','72','1','2','0','0','0','0','0','0','0','0','Captain Vachon - Cast Shield Bash'),
('166404','1664','13','0','100','1','0','20000','0','0','11','72','1','1','0','0','0','0','0','0','0','0','Captain Vachon - Cast Shield Bash when Player Casts a Spell'),
('166405','1664','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Captain Vachon - Flee at 15% HP'),
-- Captain Melrache
('166501','1665','0','0','100','1','1000','3000','240000','300000','11','8258','0','1','0','0','0','0','0','0','0','0','Captain Melrache - Cast Devotion Aura'),
('166502','1665','9','0','100','1','0','5','7000','11000','11','11976','1','0','0','0','0','0','0','0','0','0','Captain Melrache - Cast Strike'),
('166503','1665','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Captain Melrache - Flee at 15% HP'),
-- Meven Korgal
('166701','1667','4','0','100','0','0','0','0','0','1','-1030','-1031','-1032','0','0','0','0','0','0','0','0','Meven Korgal - Random Say on Aggro'),
-- Rot Hide Gnoll
('167401','1674','4','0','15','0','0','0','0','0','1','-5','-6','0','0','0','0','0','0','0','0','0','Rot Hide Gnoll - Random Say on Aggro'),
('167402','1674','0','0','100','1','7000','21000','30000','45000','11','3237','1','33','0','0','0','0','0','0','0','0','Rot Hide Gnoll - Cast Curse of Thule'),
('167403','1674','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Rot Hide Gnoll - Flee at 15% HP'),
-- Rot Hide Mongrel
('167501','1675','4','0','15','0','0','0','0','0','1','-5','-6','0','0','0','0','0','0','0','0','0','Rot Hide Mongrel - Random Say on Aggro'),
('167502','1675','0','0','100','0','7000','14000','30000','45000','11','3237','1','33','0','0','0','0','0','0','0','0','Rot Hide Mongrel - Cast Curse of Thule'),
-- Night Web Matriarch
('168801','1688','11','0','100','0','0','0','0','0','11','11959','0','1','0','0','0','0','0','0','0','0','Night Web Matriarch - Cast Poison Proc on Spawn'),
-- Vile Fin Muckdweller
('154501','1545','0','0','100','1','3000','7000','7000','12000','11','7159','1','0','0','0','0','0','0','0','0','0','Vile Fin Muckdweller - Cast Backstab'),
('154502','1545','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Vile Fin Muckdweller - Flee at 15% HP'),
-- Scarlet Vanguard
('154001','1540','4','0','15','0','0','0','0','0','1','-897','-1029','-1030','0','0','0','0','0','0','0','0','Scarlet Vanguard - Random Say on Aggro'),
('154002','1540','0','0','100','1','1000','3000','180000','183000','11','7164','0','1','0','0','0','0','0','0','0','0','Scarlet Vanguard - Cast Defensive Stance'),
('154003','1540','9','0','100','1','0','5','9000','16000','11','11972','1','0','0','0','0','0','0','0','0','0','Scarlet Vanguard - Cast Shield Bash'),
('154004','1540','13','0','100','1','0','20000','0','0','11','72','1','1','0','0','0','0','0','0','0','0','Scarlet Vanguard - Cast Shield Bash when Player Casts a Spell'),
('154005','1540','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Scarlet Vanguard - Flee at 15% HP'),
-- Vile Fin Puddlejumper
('154301','1543','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Vile Fin Puddlejumper - Flee at 15% HP'),
-- Cracked Skull Soldier
('152301','1523','0','0','100','1','4000','9000','21000','25000','11','589','4','0','0','0','0','0','0','0','0','0','Cracked Skull Soldier -  Cast Shadow Word: Pain'),
-- Rotting Dead
('152501','1525','9','0','100','1','0','5','9000','15000','11','3234','1','0','0','0','0','0','0','0','0','0','Rotting Dead - Cast Disease Touch'),
-- Ravaged Corpse
('152601','1526','9','0','100','1','0','5','9000','15000','11','3234','1','0','0','0','0','0','0','0','0','0','Ravaged Corpse - Cast Disease Touch'),
-- Hungering Dead
('152701','1527','9','0','100','1','0','5','9000','15000','11','3234','1','0','0','0','0','0','0','0','0','0','Hungering Dead - Cast Disease Touch'),
-- Shambling Horror
('152801','1528','9','0','100','1','0','5','9000','15000','11','3234','1','0','0','0','0','0','0','0','0','0','Shambling Horror - Cast Disease Touch'),
-- Bleeding Horror
('152901','1529','8','0','35','1','0','-1','0','0','11','3322','6','0','0','0','0','0','0','0','0','0','Bleeding Horror - Cast Rancid Blood on Spellhit'),
-- Rotting Ancestor
('153001','1530','8','0','35','1','0','-1','0','0','11','3322','6','0','0','0','0','0','0','0','0','0','Rotting Ancestor - Cast Rancid Blood on Spellhit'),
-- Lost Soil
('153101','1531','9','0','100','1','0','8','12000','21000','11','7713','0','0','0','0','0','0','0','0','0','0','Lost Soil - Cast Wailing Dead'),
-- Wandering Spirit
('153201','1532','9','0','100','1','0','8','12000','21000','11','7713','0','0','0','0','0','0','0','0','0','0','Wandering Spirit - Cast Wailing Dead'),
-- Tormented Spirit
('153301','1533','9','0','100','1','0','8','12000','21000','11','7713','0','0','0','0','0','0','0','0','0','0','Tormented Spirit - Cast Wailing Dead'),
-- Wailing Ancestor
('153401','1534','9','0','100','1','0','8','12000','21000','11','7713','0','0','0','0','0','0','0','0','0','0','Wailing Ancestor - Cast Wailing Dead'),
-- Scarlet Warrior
('153501','1535','4','0','15','0','0','0','0','0','1','-895','-896','-897','0','0','0','0','0','0','0','0','Scarlet Warrior - Random Say on Aggro'),
('153502','1535','0','0','100','1','3000','5000','45000','50000','11','3238','0','0','0','0','0','0','0','0','0','0','Scarlet Warrior - Cast Nimble Reflexes'),
('153503','1535','2','0','100','0','15','0','0','0','25','0','0','0','0','0','0','0','0','0','0','0','Scarlet Warrior - Flee at 15% HP'),
-- Scarlet Missionary
('153601','1536','4','0','15','0','0','0','0','0','1','-1028','-896','-895','0','0','0','0','0','0','0','0','Scarlet Missionary - Random Say on Aggro'),
('153602','1536','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Scarlet Missionary - Flee at 15% HP'),
-- Scarlet Zealot
('153701','1537','4','0','15','0','0','0','0','0','1','-897','-1028','-1029','0','0','0','0','0','0','0','0','Scarlet Zealot - Random Say on Aggro'),
('153702','1537','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Scarlet Zealot - Flee at 15% HP'),
-- Scarlet Friar
('153801','1538','1','0','100','1','1000','1000','3000000','3000000','11','1243','0','1','0','0','0','0','0','0','0','0','Scarlet Friar - Cast Power Word: Fortitude'),
('153802','1538','4','0','15','0','0','0','0','0','1','-897','-1028','-896','0','0','0','0','0','0','0','0','Scarlet Friar - Random Say on Aggro'),
('153803','1538','14','0','90','1','55','40','18000','29000','11','2052','6','1','0','0','0','0','0','0','0','0','Scarlet Friar - Cast Lesser Heal on Friendlies'),
('153804','1538','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Scarlet Friar - Flee at 15% HP'),
-- Young Scavenger
('150801','1508','1','0','10','0','30000','600000','120000','600000','4','1018','0','0','5','393','0','0','0','0','0','0','Young Scavenger - Howl and Emote OOC'),
-- Ragged Scavenger
('150901','1509','1','0','10','0','30000','600000','120000','600000','4','1018','0','0','5','393','0','0','0','0','0','0','Ragged Scavenger - Howl and Emote OOC'),
-- Wretched Ghoul
('150201','1502','1','0','100','0','0','0','0','0','11','26047','0','0','0','0','0','0','0','0','0','0','Wretched Ghoul - Cast Birth on Spawn'),
-- Young Night Web Spider
('150401','1504','11','0','100','0','0','0','0','0','11','6752','0','1','0','0','0','0','0','0','0','0','Young Night Web Spider - Cast Weak Poison Proc on Spawn'),
-- Night Web Spider
('150501','1505','11','0','100','0','0','0','0','0','11','6752','0','1','0','0','0','0','0','0','0','0','Night Web Spider - Cast Weak Poison Proc on Spawn'),
-- Scarlet Convert
('150601','1506','4','0','15','0','0','0','0','0','1','-897','-895','-1030','0','0','0','0','0','0','0','0','Scarlet Convert - Random Say on Aggro'),
-- Maggot Eye
('175302','1753','0','0','100','1','4000','9000','30000','45000','11','3237','1','33','0','0','0','0','0','0','0','0','Maggot Eye - Cast Curse of Thule'),
('175301','1753','2','0','100','1','75','0','7000','14000','11','3243','1','1','0','0','0','0','0','0','0','0','Maggot Eye - Cast Life Harvest at 75% HP'),
-- Karrel Grayves 
('191801','1918','1','0','100','0','0','0','0','0','11','26047','0','0','0','0','0','0','0','0','0','0','Karrel Grayves - Cast Birth on Spawn'),
-- Tirisfal Farmer
('193401','1934','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Tirisfal Farmer - Flee at 15% HP'),
-- Tirisfal Farmhand
('193501','1935','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Tirisfal Farmhand - Flee at 15% HP'),
-- Farmer Sollidan
('193601','1936','9','0','100','1','0','5','7000','10000','11','11976','1','0','0','0','0','0','0','0','0','0','Farmer Sollidan - Cast Strike'),
('193602','1936','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Farmer Sollidan - Flee at 15% HP'),
-- Rot Hide Graverobber
('194101','1941','4','0','15','0','0','0','0','0','1','-5','-6','0','0','0','0','0','0','0','0','0','Rot Hide Graverobber - Random Say on Aggro'),
('194102','1941','0','0','100','1','2000','18000','120000','161000','11','3237','1','1','0','0','0','0','0','0','0','0','Rot Hide Graverobber - Cast Curse of Thule'),
-- Sri'skulk
('1035901','10359','11','0','100','0','0','0','0','0','11','10022','0','0','0','0','0','0','0','0','0','0','Sri\'skulk - Cast Deadly Poison on Spawn'),
-- Alexi Barov
('1102201','11022','9','0','100','1','0','5','13000','18000','11','15583','1','1','0','0','0','0','0','0','0','0','Alexi Barov - Cast Rupture'),
('1102202','11022','0','0','100','1','5000','9000','9000','13000','11','14873','4','0','0','0','0','0','0','0','0','0','Alexi Barov - Cast Sinister Strike'),
('1102203','11022','0','0','100','1','7000','12000','14000','21000','11','7159','1','0','0','0','0','0','0','0','0','0','Alexi Barov - Cast Backstab'),
('1102204','11022','13','0','100','1','6000','10000','0','0','11','15614','1','1','0','0','0','0','0','0','0','0','Alexi Barov - Cast Kick on Target Spell Casting'),
-- Lieutenant Sanders
('1315801','13158','2','0','100','0','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Lieutenant Sanders - Flee at 15% HP'),
-- Wickerman Guardian
('1519501','15195','11','0','100','0','0','0','0','0','11','12187','0','0','0','0','0','0','0','0','0','0','Wickerman Guardian - Cast Disease Cloud on Spawn'),
('1519502','15195','9','0','100','1','0','5','8000','12000','11','18368','1','0','0','0','0','0','0','0','0','0','Wickerman Guardian - Cast Strike'),
('1519503','15195','0','0','100','1','8000','14000','9000','15000','11','19128','4','1','0','0','0','0','0','0','0','0','Wickerman Guardian - Cast Knockdown'),
('1519504','15195','6','0','100','0','0','0','0','0','11','25007','0','7','0','0','0','0','0','0','0','0','Wickerman Guardian - Cast Wickerman Guardian Ember on Death'),
-- Grizzle Halfmane
('34701','347','9','0','100','1','0','5','8000','11000','11','15284','1','0','0','0','0','0','0','0','0','0','Grizzle Halfmane - Cast Cleave'),
('34702','347','0','0','100','1','7000','11000','9000','12000','11','16856','4','1','0','0','0','0','0','0','0','0','Grizzle Halfmane - Cast Mortal Strike'),
('34703','347','0','0','100','1','10000','14000','7000','14000','11','13736','0','0','0','0','0','0','0','0','0','0','Grizzle Halfmane - Cast Whirlwind'),
('34704','347','0','0','100','1','15000','18000','18000','21000','11','19134','4','1','0','0','0','0','0','0','0','0','Grizzle Halfmane - Cast Frightening Shout'),
-- Kurden Bloodclaw
('280401','2804','9','0','100','1','0','5','8000','11000','11','15284','1','0','0','0','0','0','0','0','0','0','Kurden Bloodclaw - Cast Cleave'),
('280402','2804','0','0','100','1','7000','11000','9000','12000','11','16856','4','1','0','0','0','0','0','0','0','0','Kurden Bloodclaw - Cast Mortal Strike'),
('280403','2804','0','0','100','1','10000','14000','7000','14000','11','13736','0','0','0','0','0','0','0','0','0','0','Kurden Bloodclaw - Cast Whirlwind'),
('280404','2804','0','0','100','1','15000','18000','18000','21000','11','19134','4','1','0','0','0','0','0','0','0','0','Kurden Bloodclaw - Cast Frightening Shout'),
-- Robert Gossom      
('565501','5655','1','0','100','1','1000','2000','2000','4000','10','4','21','22','0','0','0','0','0','0','0','0','Robert Gossom - OOC Random Emote'),
-- Richard Van Brunt      
('565601','5656','1','0','100','1','1000','2000','2000','4000','10','4','21','22','0','0','0','0','0','0','0','0','Richard Van Brunt - OOC Random Emote'),
-- Marla Fowler      
('565701','5657','1','0','100','1','1000','2000','2000','4000','10','4','21','22','0','0','0','0','0','0','0','0','Marla Fowler - OOC Random Emote'),
-- Chloe Curthas      
('565801','5658','1','0','100','1','1000','2000','2000','4000','10','4','21','22','0','0','0','0','0','0','0','0','Chloe Curthas - OOC Random Emote'),
-- Andrew Hartwell      
('565901','5659','1','0','100','1','1000','2000','2000','4000','10','4','21','22','0','0','0','0','0','0','0','0','Andrew Hartwell - OOC Random Emote'),
-- Riley Walker      
('566001','5660','1','0','100','1','1000','2000','2000','4000','10','4','21','22','0','0','0','0','0','0','0','0','Riley Walker - OOC Random Emote'),
-- Summoned Succubus
('567701','5677','0','0','100','1','5000','11000','9000','15000','11','16583','1','0','0','0','0','0','0','0','0','0','Summoned Succubus - Cast Shadow Shock'),
-- Caged Human Female - (COMMENTS HAVE EMOTES FOR Apothecary Keever)
('573501','5735','1','0','100','1','3000','8000','5000','10000','10','18','20','0','0','0','0','0','0','0','0','0','Caged Human Female - Random Emotes'),
-- Lyrlia Blackshield
('2038601','20386','9','0','100','1','0','5','8000','11000','11','15284','1','0','0','0','0','0','0','0','0','0','Lyrlia Blackshield - Cast Cleave'),
('2038602','20386','0','0','100','1','7000','11000','9000','12000','11','16856','4','1','0','0','0','0','0','0','0','0','Lyrlia Blackshield - Cast Mortal Strike'),
('2038603','20386','0','0','100','1','10000','14000','7000','14000','11','13736','0','0','0','0','0','0','0','0','0','0','Lyrlia Blackshield - Cast Whirlwind'),
('2038604','20386','0','0','100','1','15000','18000','18000','21000','11','19134','4','1','0','0','0','0','0','0','0','0','Lyrlia Blackshield - Cast Frightening Shout'),
-- Demon Hunter Supplicant
('2117901','21179','2','0','100','0','40','0','0','0','1','-1459','0','0','11','37683','0','0','0','0','0','0','Demon Hunter Supplicant - Cast Evasion at 40% HP'),
('2117902','21179','2','0','100','0','25','0','0','0','11','32720','0','0','0','0','0','0','0','0','0','0','Demon Hunter Supplicant - Cast Sprint at 25% HP'),
-- Asghar
('2202501','22025','0','0','100','1','1000','2000','5000','5000','11','15496','0','0','0','0','0','0','0','0','0','0','Asghar - Cast Cleave'),
('2202502','22025','2','0','100','1','50','0','6000','7000','11','16588','0','0','0','0','0','0','0','0','0','0','Asghar - Cast Dark Mending at 50% HP');

-- https://github.com/Looking4Group/L4G_Core/blob/461cee68a9562532d30581a50c73b429f94940f6/sql/updates/world/080_Instant_70_Event.sql#L5
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (22395, 4, 9, -1, 'Totem of Rage', 34957, 3, 0, 1, 64867, 12973, 28, 32767, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27859, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (23198, 4, 8, -1, 'Idol of Brutality', 34955, 3, 0, 1, 78749, 15749, 28, 32767, -1, 65, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28855, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (23203, 4, 7, -1, 'Libram of Fervor', 34961, 3, 0, 1, 80217, 16043, 28, 32767, -1, 65, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28852, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (24390, 4, 0, -1, 'Auslese\'s Light Channeler', 38837, 3, 524288, 1, 82948, 20737, 12, -1, -1, 88, 61, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18038, 1, 0, 0, -1, 0, -1, 31794, 0, 0, 0, 180000, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 50, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (25689, 4, 2, -1, 'Heavy Clefthoof Vest', 37633, 3, 0, 1, 225054, 45010, 5, -1, -1, 114, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 45, 12, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 574, 100, 0, 0, 0, 0, 4, 0, 4, 0, 8, 0, 2871, 0, 275, 210, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (25690, 4, 2, -1, 'Heavy Clefthoof Leggings', 37631, 3, 0, 1, 224040, 44808, 7, -1, -1, 113, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 33, 12, 29, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 503, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 574, 75, 0, 0, 0, 0, 8, 0, 4, 0, 8, 0, 2871, 0, 275, 252, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (25691, 4, 2, -1, 'Heavy Clefthoof Boots', 37634, 3, 0, 1, 168631, 33726, 8, -1, -1, 113, 69, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 30, 12, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 574, 50, 0, 0, 0, 0, 4, 0, 8, 0, 0, 0, 2876, 0, 275, 196, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (25962, 4, 0, -1, 'Longstrider\'s Loop', 33534, 3, 0, 1, 335188, 83797, 11, -1, -1, 97, 64, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 16, 7, 15, 31, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15807, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 50, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27436, 4, 0, -1, 'Iron Band of the Unbreakable', 28830, 3, 0, 1, 17235, 4308, 11, -1, -1, 103, 66, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 27, 12, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 170, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 900000, 0, 30000, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27458, 4, 3, -1, 'Oceansong Kilt', 42927, 3, 0, 1, 273245, 54649, 7, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 36, 5, 34, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 570, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17320, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27459, 4, 4, -1, 'Vambraces of Daring', 42832, 3, 0, 1, 160876, 32175, 9, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 18, 7, 26, 12, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 509, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22852, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27461, 4, 2, -1, 'Chestguard of the Prowler', 43015, 3, 0, 1, 230123, 46024, 5, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 31, 7, 26, 14, 16, 31, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 292, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15820, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27465, 4, 1, -1, 'Mana-Etched Gloves', 43073, 3, 0, 1, 84536, 16907, 10, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 25, 5, 17, 21, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 97, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14799, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 658, 30, 0, 0, 0, 0, 2, 0, 4, 0, 0, 0, 2859, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27475, 4, 4, -1, 'Gauntlets of the Bold', 40830, 3, 0, 1, 158569, 31713, 10, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 17, 3, 16, 7, 31, 12, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 653, 45, 0, 0, 0, 0, 2, 0, 4, 0, 0, 0, 2870, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27491, 4, 0, -1, 'Signet of Repose', 39128, 3, 524288, 1, 123465, 30866, 11, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 17, 5, 18, 6, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9315, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27497, 4, 4, -1, 'Doomplate Gauntlets', 43035, 3, 0, 1, 159684, 31936, 10, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 31, 7, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 661, 45, 0, 0, 0, 0, 4, 0, 4, 0, 8, 0, 2860, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27509, 4, 2, -1, 'Handgrips of Assassination', 42410, 3, 0, 1, 110168, 22033, 10, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 25, 7, 24, 31, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14056, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 620, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27510, 4, 3, -1, 'Tidefury Gauntlets', 42568, 3, 0, 1, 132690, 26538, 10, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 22, 5, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13881, 1, 0, 0, -1, 0, -1, 21364, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 630, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27518, 4, 8, -1, 'Ivory Idol of the Moongoddess', 39645, 3, 0, 1, 123850, 24770, 28, 32767, -1, 112, 68, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34292, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27525, 4, 1, -1, 'Jeweled Boots of Sanctification', 43087, 3, 0, 1, 127161, 25432, 8, 32767, -1, 112, 68, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 22, 5, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18036, 1, 0, 0, -1, 0, -1, 21627, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27527, 4, 4, -1, 'Greaves of the Shatterer', 42831, 3, 0, 1, 306192, 61238, 7, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 25, 7, 37, 12, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1019, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 2, 0, 4, 0, 8, 0, 2888, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27528, 4, 3, -1, 'Gauntlets of Desolation', 43052, 3, 0, 1, 131700, 26340, 10, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 25, 5, 16, 32, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15807, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 660, 40, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2859, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27529, 4, 0, -1, 'Figurine of the Colossus', 40039, 3, 524352, 1, 265161, 66290, 12, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 15, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33089, 0, 0, 0, 120000, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27535, 4, 4, -1, 'Gauntlets of the Righteous', 42355, 3, 0, 1, 147111, 29422, 10, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 22, 5, 20, 12, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14248, 1, 0, 0, -1, 0, -1, 21628, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 623, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27544, 4, 9, -1, 'Totem of Spontaneous Regrowth', 39639, 3, 0, 1, 129747, 25949, 28, 32767, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34294, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27548, 4, 4, -1, 'Girdle of Many Blessings', 42862, 3, 0, 1, 154512, 30902, 6, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 24, 5, 22, 21, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18033, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27549, 4, 3, -1, 'Wavefury Boots', 42931, 3, 0, 1, 204413, 40882, 8, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 19, 5, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 448, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18036, 1, 0, 0, -1, 0, -1, 18378, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27551, 4, 0, -1, 'Skeletal Necklace of Battlerage', 40036, 3, 0, 1, 41135, 10283, 2, 32767, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 26, 7, 21, 31, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27672, 4, 4, -1, 'Girdle of the Immovable', 42833, 3, 0, 1, 149372, 29874, 6, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 17, 7, 33, 12, 18, 15, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 655, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 2, 0, 4, 0, 0, 0, 2876, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27712, 4, 2, -1, 'Shackles of Quagmirran', 31620, 3, 0, 1, 108969, 21793, 9, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 20, 7, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14049, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27713, 4, 3, -1, 'Pauldrons of Desolation', 43044, 3, 0, 1, 197752, 39550, 3, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 23, 7, 16, 5, 19, 31, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 660, 70, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2860, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27714, 4, 0, -1, 'Swamplight Lantern', 43091, 3, 0, 1, 137801, 34450, 23, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18031, 1, 0, 0, -1, 0, -1, 18379, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27739, 4, 4, -1, 'Spaulders of the Righteous', 42351, 3, 0, 1, 234300, 46860, 3, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 22, 5, 22, 12, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9344, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 623, 80, 0, 0, 0, 0, 2, 0, 8, 0, 0, 0, 2861, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27741, 2, 4, -1, 'Bleeding Hollow Warhammer', 41771, 3, 0, 1, 450393, 90078, 21, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 12, 5, 17, 21, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47.28, 151.28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2400, 0, 0, 33250, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, -30.3, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27742, 4, 1, -1, 'Mage-Fury Girdle', 43026, 3, 0, 1, 83920, 16784, 6, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 22, 5, 23, 21, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14127, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27757, 2, 10, -1, 'Greatstaff of the Leviathan', 40358, 3, 0, 1, 554799, 110959, 17, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 39, 7, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 106.28, 196.28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 360, 0, 0, 0, 0, 0, 0, 2400, 0, 0, 44908, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, -30.3, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27759, 4, 3, -1, 'Headdress of the Tides', 44410, 3, 0, 1, 206438, 41287, 1, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 30, 5, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 530, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18044, 1, 0, 0, -1, 0, -1, 21365, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27771, 4, 4, -1, 'Doomplate Shoulderguards', 43034, 3, 0, 1, 227477, 45495, 3, 32767, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 19, 7, 22, 32, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 661, 80, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 2870, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27775, 4, 1, -1, 'Hallowed Pauldrons', 42577, 3, 0, 1, 135672, 27134, 3, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 10, 5, 17, 6, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18032, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 662, 50, 0, 0, 0, 0, 2, 0, 8, 0, 0, 0, 2863, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27776, 4, 2, -1, 'Shoulderpads of Assassination', 42414, 3, 0, 1, 170184, 34036, 3, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 25, 7, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 219, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15809, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 620, 60, 0, 0, 0, 0, 4, 0, 4, 0, 0, 0, 2895, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27779, 4, 0, -1, 'Bone Chain Necklace', 32087, 3, 0, 1, 201151, 50287, 2, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 19, 7, 18, 31, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14089, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27780, 4, 0, -1, 'Ring of Fabled Hope', 24646, 3, 524288, 1, 335188, 83797, 11, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 12, 6, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18038, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27783, 4, 2, -1, 'Moonrage Girdle', 42967, 3, 0, 1, 102789, 20557, 6, -1, -1, 112, 68, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 22, 6, 21, 21, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15715, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27784, 4, 0, -1, 'Scintillating Coral Band', 39121, 3, 524288, 1, 167612, 41903, 11, -1, -1, 112, 68, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 14, 5, 15, 21, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14248, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27790, 4, 4, -1, 'Mask of Penance', 42860, 3, 0, 1, 227193, 45438, 1, -1, -1, 112, 68, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 27, 5, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 922, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18041, 1, 0, 0, -1, 0, -1, 21633, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27792, 4, 0, -1, 'Steam-Hinge Chain of Valor', 40040, 3, 0, 1, 35155, 8788, 2, -1, -1, 112, 68, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 26, 15, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33274, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27796, 4, 1, -1, 'Mana-Etched Spaulders', 42443, 3, 0, 1, 136134, 27226, 3, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 25, 5, 17, 21, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14799, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 658, 50, 0, 0, 0, 0, 4, 0, 2, 0, 0, 0, 2859, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27797, 4, 2, -1, 'Wastewalker Shoulderpads', 43066, 3, 0, 1, 170778, 34155, 3, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 25, 7, 13, 31, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 219, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15806, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 659, 60, 0, 0, 0, 0, 2, 0, 8, 0, 0, 0, 2887, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27799, 4, 1, -1, 'Vermillion Robes of the Dominant', 42898, 3, 0, 1, 183447, 36689, 20, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 37, 5, 33, 18, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 156, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18058, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27802, 4, 3, -1, 'Tidefury Shoulderguards', 42573, 3, 0, 1, 189580, 37916, 3, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 18, 5, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 489, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14254, 1, 0, 0, -1, 0, -1, 18379, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 630, 70, 0, 0, 0, 0, 2, 0, 8, 0, 0, 0, 2900, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27803, 4, 4, -1, 'Shoulderguards of the Bold', 42360, 3, 0, 1, 220632, 44126, 3, 32767, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 25, 7, 25, 12, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 873, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 653, 80, 0, 0, 0, 0, 4, 0, 8, 0, 0, 0, 2876, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27804, 4, 1, -1, 'Devilshark Cape', 43094, 3, 0, 1, 126804, 25360, 16, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 7, 22, 13, 18, 12, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33274, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27822, 4, 0, -1, 'Crystal Band of Valor', 40044, 3, 524288, 1, 220141, 55035, 11, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 27, 12, 22, 31, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);
REPLACE INTO `item_template` (`entry`, `class`, `subclass`, `unk0`, `name`, `displayid`, `Quality`, `Flags`, `BuyCount`, `BuyPrice`, `SellPrice`, `InventoryType`, `AllowableClass`, `AllowableRace`, `ItemLevel`, `RequiredLevel`, `RequiredSkill`, `RequiredSkillRank`, `requiredspell`, `requiredhonorrank`, `RequiredCityRank`, `RequiredReputationFaction`, `RequiredReputationRank`, `maxcount`, `stackable`, `ContainerSlots`, `stat_type1`, `stat_value1`, `stat_type2`, `stat_value2`, `stat_type3`, `stat_value3`, `stat_type4`, `stat_value4`, `stat_type5`, `stat_value5`, `stat_type6`, `stat_value6`, `stat_type7`, `stat_value7`, `stat_type8`, `stat_value8`, `stat_type9`, `stat_value9`, `stat_type10`, `stat_value10`, `dmg_min1`, `dmg_max1`, `dmg_type1`, `dmg_min2`, `dmg_max2`, `dmg_type2`, `dmg_min3`, `dmg_max3`, `dmg_type3`, `dmg_min4`, `dmg_max4`, `dmg_type4`, `dmg_min5`, `dmg_max5`, `dmg_type5`, `armor`, `holy_res`, `fire_res`, `nature_res`, `frost_res`, `shadow_res`, `arcane_res`, `delay`, `ammo_type`, `RangedModRange`, `spellid_1`, `spelltrigger_1`, `spellcharges_1`, `spellppmRate_1`, `spellcooldown_1`, `spellcategory_1`, `spellcategorycooldown_1`, `spellid_2`, `spelltrigger_2`, `spellcharges_2`, `spellppmRate_2`, `spellcooldown_2`, `spellcategory_2`, `spellcategorycooldown_2`, `spellid_3`, `spelltrigger_3`, `spellcharges_3`, `spellppmRate_3`, `spellcooldown_3`, `spellcategory_3`, `spellcategorycooldown_3`, `spellid_4`, `spelltrigger_4`, `spellcharges_4`, `spellppmRate_4`, `spellcooldown_4`, `spellcategory_4`, `spellcategorycooldown_4`, `spellid_5`, `spelltrigger_5`, `spellcharges_5`, `spellppmRate_5`, `spellcooldown_5`, `spellcategory_5`, `spellcategorycooldown_5`, `bonding`, `description`, `PageText`, `LanguageID`, `PageMaterial`, `startquest`, `lockid`, `Material`, `sheath`, `RandomProperty`, `RandomSuffix`, `block`, `itemset`, `MaxDurability`, `area`, `Map`, `BagFamily`, `TotemCategory`, `socketColor_1`, `socketContent_1`, `socketColor_2`, `socketContent_2`, `socketColor_3`, `socketContent_3`, `socketBonus`, `GemProperties`, `RequiredDisenchantSkill`, `ArmorDamageModifier`, `ScriptName`, `DisenchantID`, `FoodType`, `minMoneyLoot`, `maxMoneyLoot`, `Duration`) VALUES (27835, 4, 3, -1, 'Stillwater Girdle', 42936, 3, 0, 1, 135619, 27123, 6, -1, -1, 115, 70, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 7, 18, 5, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 367, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18378, 1, 0, 0, -1, 0, -1, 15696, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 52, 0, 0, 0, 0);

-- https://bitbucket.org/looking4group_b2tbc/looking4group_ptr/commits/6fd90944e143b0dd10d0ced652864c2df027773f
REPLACE INTO `item_template` VALUES (7734, 4, 0, -1, 'Six Demon Bag', 3410, 3, 524288, 1, 61980, 15495, 12, -1, -1, 51, 46, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14537, 0, 0, 0, 180000, 1141, 10000, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 175, 0, '', 47, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (11669, 4, 0, -1, 'Naglering', 9837, 3, 524288, 1, 68630, 17157, 11, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15438, 1, 0, 0, 0, 0, 0, 13383, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 50, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (11810, 4, 0, -1, 'Force of Will', 19767, 3, 524288, 1, 40000, 10000, 12, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15594, 1, 0, 0, -1, 0, -1, 13385, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12547, 4, 2, -1, 'Mar Alom\'s Grip', 28797, 3, 0, 1, 52597, 10519, 10, -1, -1, 56, 51, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 8, 5, 10, 7, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9408, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12554, 4, 1, -1, 'Hands of the Exalted Herald', 28771, 3, 0, 1, 47373, 9474, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 13, 6, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9318, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12556, 4, 1, -1, 'High Priestess Boots', 22779, 3, 0, 1, 71585, 14317, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 20, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9408, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12583, 2, 6, -1, 'Blackhand Doomsaw', 22792, 3, 0, 1, 334578, 66915, 17, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 151, 227, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3500, 0, 0, 16549, 2, 0, 1.5, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12602, 4, 6, -1, 'Draconian Deflector', 23419, 3, 0, 1, 158467, 31693, 14, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2153, 0, 10, 0, 0, 0, 0, 0, 0, 0, 13390, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 4, 0, 0, 40, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12620, 4, 4, -1, 'Enchanted Thorium Helm', 22886, 3, 0, 1, 140423, 28084, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 25, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 526, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13388, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12633, 4, 4, -1, 'Whitesoul Helm', 22901, 3, 0, 1, 129776, 25955, 1, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 15, 5, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 629, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 18029, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 120, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12930, 4, 0, -1, 'Briarwood Reed', 8232, 3, 524288, 1, 40000, 10000, 12, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13881, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (12968, 4, 1, -1, 'Frostweaver Cape', 23554, 3, 0, 1, 76271, 15254, 16, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 12, 6, 12, 18, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13091, 4, 0, -1, 'Medallion of Grand Marshal Morris', 23717, 3, 0, 1, 42549, 10637, 2, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13390, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13098, 4, 0, -1, 'Painweaver Band', 23608, 3, 524288, 1, 61130, 15282, 11, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7597, 1, 0, 0, 0, 0, 0, 9329, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13102, 4, 1, -1, 'Cassandra\'s Grace', 28974, 3, 0, 1, 34399, 6879, 1, -1, -1, 47, 42, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 9, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17371, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 150, 0, '', 46, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13177, 4, 0, -1, 'Talisman of Evasion', 6494, 3, 0, 1, 65585, 16396, 2, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13669, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13178, 4, 0, -1, 'Rosewine Circle', 23728, 3, 524288, 1, 55130, 13782, 11, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21363, 1, 0, 0, 0, 0, 0, 9316, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13208, 4, 2, -1, 'Bleak Howler Armguards', 23760, 3, 0, 1, 60455, 12091, 9, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 14, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7681, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13345, 4, 0, -1, 'Seal of Rivendare', 24022, 3, 0, 1, 61830, 15457, 11, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 17, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13346, 4, 1, -1, 'Robes of the Exalted', 24025, 3, 0, 1, 104038, 20807, 20, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 11, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18042, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13368, 2, 15, -1, 'Bonescraper', 25614, 3, 0, 1, 258448, 51689, 13, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 40, 74, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1400, 0, 0, 9336, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13372, 2, 10, -1, 'Slavedriver\'s Cane', 24063, 3, 0, 1, 318846, 63769, 17, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 29, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 160, 241, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3900, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13397, 4, 1, -1, 'Stoneskin Gargoyle Cape', 24108, 3, 0, 1, 73401, 14680, 16, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 8, 4, 7, 7, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'It\'s white and looks longer than your average cloak or cape.', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13515, 4, 0, -1, 'Ramstein\'s Lightning Bolts', 1236, 3, 524288, 1, 38400, 9600, 12, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17668, 0, 0, 0, 300000, 1141, 10000, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13938, 2, 19, -1, 'Bonecreeper Stylus', 24743, 3, 0, 1, 183232, 36646, 26, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 83, 155, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1900, 0, 100, 9416, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (13969, 4, 3, -1, 'Loomguard Armbraces', 24793, 3, 0, 1, 77350, 15470, 9, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 7, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 157, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9318, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14487, 2, 4, -1, 'Bonechill Hammer', 25096, 3, 0, 1, 248119, 49623, 13, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 68, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2400, 0, 0, 18276, 2, 0, 1, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 3, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14522, 4, 3, -1, 'Maelstrom Leggings', 25111, 3, 0, 1, 146003, 29200, 7, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 10, 7, 20, 5, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7680, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14525, 4, 4, -1, 'Boneclenched Gauntlets', 25116, 3, 0, 1, 86654, 17330, 10, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 14, 4, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 404, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13385, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14539, 4, 2, -1, 'Bone Ring Helm', 25166, 3, 0, 1, 99784, 19956, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 6, 7, 30, 6, 6, 5, 6, 3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 141, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14548, 4, 3, -1, 'Royal Cap Spaulders', 28817, 3, 0, 1, 115582, 23116, 3, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 13, 5, 9, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 274, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9315, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14620, 4, 4, -1, 'Deathbone Girdle', 25225, 3, 0, 1, 86132, 17226, 6, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 358, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18369, 1, 0, 0, -1, 0, -1, 21362, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 124, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14621, 4, 4, -1, 'Deathbone Sabatons', 25227, 3, 0, 1, 128709, 25741, 8, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 438, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21626, 1, 0, 0, -1, 0, -1, 13390, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 124, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (14623, 4, 4, -1, 'Deathbone Legguards', 25226, 3, 0, 1, 173246, 34649, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 557, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21363, 1, 0, 0, -1, 0, -1, 14249, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 124, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (15047, 4, 3, -1, 'Red Dragonscale Breastplate', 25675, 3, 0, 1, 144063, 28812, 5, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 360, 0, 12, 0, 0, 0, 0, 0, 0, 0, 18041, 1, 0, 0, 3600000, 0, 600000, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (15056, 4, 2, -1, 'Stormshroud Armor', 8682, 3, 0, 1, 104834, 20966, 5, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7598, 1, 0, 0, 3600000, 0, 600000, 13669, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 142, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (15057, 4, 2, -1, 'Stormshroud Pants', 25686, 3, 0, 1, 93643, 18728, 7, -1, -1, 55, 50, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 138, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7598, 1, 0, 0, -1, 0, -1, 13669, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 142, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 175, 0, '', 47, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (15058, 4, 2, -1, 'Stormshroud Shoulders', 25687, 3, 0, 1, 88158, 17631, 3, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 126, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7597, 1, 0, 0, -1, 0, -1, 13669, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 142, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (15061, 4, 2, -1, 'Living Shoulders', 25695, 3, 0, 1, 69017, 13803, 3, -1, -1, 54, 49, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 13, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 117, 0, 0, 3, 0, 0, 0, 0, 0, 0, 9317, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 175, 0, '', 47, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (15413, 4, 4, -1, 'Ornate Adamantium Breastplate', 26373, 3, 0, 1, 177351, 35470, 5, -1, -1, 63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13390, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 135, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 150, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16058, 4, 0, -1, 'Fordring\'s Seal', 26001, 3, 0, 1, 40625, 10156, 11, -1, -1, 63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 5, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18030, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16666, 4, 3, -1, 'Vest of Elements', 31416, 3, 0, 1, 161841, 32368, 5, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 20, 6, 20, 7, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16667, 4, 3, -1, 'Coif of Elements', 45174, 3, 0, 1, 120178, 24035, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 23, 7, 13, 6, 12, 4, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 297, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16668, 4, 3, -1, 'Kilt of Elements', 31415, 3, 0, 1, 147468, 29493, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 20, 5, 15, 4, 12, 7, 7, 3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 315, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16669, 4, 3, -1, 'Pauldrons of Elements', 30925, 3, 0, 1, 109977, 21995, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 15, 7, 14, 6, 6, 4, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 266, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16670, 4, 3, -1, 'Boots of Elements', 31412, 3, 0, 1, 105136, 21027, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 17, 3, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16671, 4, 3, -1, 'Bindings of Elements', 31411, 3, 0, 1, 62932, 12586, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 10, 6, 10, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16672, 4, 3, -1, 'Gauntlets of Elements', 31414, 3, 0, 1, 70299, 14059, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 16, 5, 10, 4, 9, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 218, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16673, 4, 3, -1, 'Cord of Elements', 31413, 3, 0, 1, 67202, 13440, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 17, 4, 9, 6, 7, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 187, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16674, 4, 3, -1, 'Beaststalker\'s Tunic', 31402, 3, 0, 1, 154969, 30993, 5, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 14, 7, 16, 5, 13, 6, 6, 4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 370, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9335, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16675, 4, 3, -1, 'Beaststalker\'s Boots', 31408, 3, 0, 1, 107106, 21421, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 14, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9335, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16676, 4, 3, -1, 'Beaststalker\'s Gloves', 31406, 3, 0, 1, 71344, 14268, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 10, 6, 10, 7, 9, 5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 218, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9330, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16677, 4, 3, -1, 'Beaststalker\'s Cap', 31410, 3, 0, 1, 115933, 23186, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 14, 7, 20, 5, 10, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 297, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9334, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16678, 4, 3, -1, 'Beaststalker\'s Pants', 31403, 3, 0, 1, 153036, 30607, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 18, 6, 12, 7, 6, 4, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 315, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15806, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16679, 4, 3, -1, 'Beaststalker\'s Mantle', 31409, 3, 0, 1, 114114, 22822, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 17, 3, 8, 5, 7, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 266, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9142, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16680, 4, 3, -1, 'Beaststalker\'s Belt', 31404, 3, 0, 1, 68941, 13788, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 11, 3, 7, 5, 9, 4, 9, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 193, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9141, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16681, 4, 3, -1, 'Beaststalker\'s Bindings', 31405, 3, 0, 1, 65275, 13055, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 10, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9331, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 186, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16682, 4, 1, -1, 'Magister\'s Boots', 29594, 3, 0, 1, 72914, 14582, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 14, 5, 14, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16683, 4, 1, -1, 'Magister\'s Bindings', 29597, 3, 0, 1, 43827, 8765, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 15, 6, 5, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16684, 4, 1, -1, 'Magister\'s Gloves', 29593, 3, 0, 1, 45468, 9093, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 14, 5, 14, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16685, 4, 1, -1, 'Magister\'s Belt', 29596, 3, 0, 1, 43470, 8694, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 21, 6, 6, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16686, 4, 1, -1, 'Magister\'s Crown', 31087, 3, 0, 1, 74182, 14836, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 30, 6, 5, 7, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16687, 4, 1, -1, 'Magister\'s Leggings', 29273, 3, 0, 1, 97928, 19585, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 21, 5, 20, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16688, 4, 1, -1, 'Magister\'s Robes', 29591, 3, 0, 1, 101011, 20202, 20, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 31, 6, 8, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16689, 4, 1, -1, 'Magister\'s Mantle', 30211, 3, 0, 1, 72986, 14597, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 22, 6, 6, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 181, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16690, 4, 1, -1, 'Devout Robe', 30422, 3, 0, 1, 101778, 20355, 20, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 24, 6, 15, 7, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16691, 4, 1, -1, 'Devout Sandals', 30430, 3, 0, 1, 70029, 14005, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 17, 5, 10, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16692, 4, 1, -1, 'Devout Gloves', 30427, 3, 0, 1, 46861, 9372, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 17, 5, 10, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16693, 4, 1, -1, 'Devout Crown', 31104, 3, 0, 1, 76153, 15230, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 24, 6, 15, 7, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16694, 4, 1, -1, 'Devout Skirt', 30424, 3, 0, 1, 100531, 20106, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 23, 5, 15, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16695, 4, 1, -1, 'Devout Mantle', 31103, 3, 0, 1, 74627, 14925, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 21, 6, 9, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16696, 4, 1, -1, 'Devout Belt', 30425, 3, 0, 1, 45293, 9058, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 20, 6, 9, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16697, 4, 1, -1, 'Devout Bracers', 30426, 3, 0, 1, 42887, 8577, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 10, 6, 10, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 182, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16698, 4, 1, -1, 'Dreadmist Mask', 31263, 3, 0, 1, 77557, 15511, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 23, 7, 15, 6, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16699, 4, 1, -1, 'Dreadmist Leggings', 29797, 3, 0, 1, 102377, 20475, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 21, 7, 15, 5, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16700, 4, 1, -1, 'Dreadmist Robe', 29792, 3, 0, 1, 108329, 21665, 20, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 21, 7, 20, 6, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 89, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16701, 4, 1, -1, 'Dreadmist Mantle', 29798, 3, 0, 1, 78254, 15650, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 15, 7, 14, 6, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16702, 4, 1, -1, 'Dreadmist Belt', 29793, 3, 0, 1, 42965, 8593, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 17, 7, 10, 6, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16703, 4, 1, -1, 'Dreadmist Bracers', 29795, 3, 0, 1, 40690, 8138, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 10, 7, 10, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16704, 4, 1, -1, 'Dreadmist Sandals', 29799, 3, 0, 1, 68196, 13639, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 17, 6, 10, 5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 58, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16705, 4, 1, -1, 'Dreadmist Wraps', 29800, 3, 0, 1, 45639, 9127, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 14, 5, 9, 7, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 183, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16706, 4, 2, -1, 'Wildheart Vest', 29974, 3, 0, 1, 125293, 25058, 5, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 20, 6, 20, 7, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16707, 4, 2, -1, 'Shadowcraft Cap', 28180, 3, 0, 1, 93064, 18612, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 20, 7, 18, 4, 13, 6, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 141, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16708, 4, 2, -1, 'Shadowcraft Spaulders', 28179, 3, 0, 1, 90878, 18175, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 22, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16709, 4, 2, -1, 'Shadowcraft Pants', 28161, 3, 0, 1, 123331, 24666, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 25, 7, 12, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16710, 4, 2, -1, 'Shadowcraft Bracers', 24190, 3, 0, 1, 52230, 10446, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 15, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16711, 4, 2, -1, 'Shadowcraft Boots', 28162, 3, 0, 1, 87528, 17505, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 21, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16712, 4, 2, -1, 'Shadowcraft Gloves', 28166, 3, 0, 1, 58571, 11714, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 14, 6, 10, 7, 9, 4, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16713, 4, 2, -1, 'Shadowcraft Belt', 28177, 3, 0, 1, 55985, 11197, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 14, 7, 10, 6, 9, 4, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16714, 4, 2, -1, 'Wildheart Bracers', 29977, 3, 0, 1, 53013, 10602, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 15, 4, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16715, 4, 2, -1, 'Wildheart Boots', 29981, 3, 0, 1, 88833, 17766, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 17, 7, 10, 5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16716, 4, 2, -1, 'Wildheart Belt', 29976, 3, 0, 1, 58105, 11621, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 17, 6, 10, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16717, 4, 2, -1, 'Wildheart Gloves', 29979, 3, 0, 1, 61224, 12244, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 21, 5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16718, 4, 2, -1, 'Wildheart Spaulders', 30412, 3, 0, 1, 96773, 19354, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 18, 7, 9, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16719, 4, 2, -1, 'Wildheart Kilt', 29975, 3, 0, 1, 131300, 26260, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 14, 6, 14, 7, 14, 4, 13, 3, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16720, 4, 2, -1, 'Wildheart Cowl', 31228, 3, 0, 1, 100187, 20037, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 20, 6, 20, 7, 10, 4, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 141, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 185, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16721, 4, 2, -1, 'Shadowcraft Tunic', 28160, 3, 0, 1, 135865, 27173, 5, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 26, 7, 13, 6, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 184, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16722, 4, 4, -1, 'Lightforge Bracers', 29968, 3, 0, 1, 71331, 14266, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 10, 6, 8, 4, 7, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 261, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16723, 4, 4, -1, 'Lightforge Belt', 29966, 3, 0, 1, 75904, 15180, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 15, 6, 6, 7, 9, 4, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 341, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16724, 4, 4, -1, 'Lightforge Gauntlets', 29970, 3, 0, 1, 80008, 16001, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 6, 14, 4, 14, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 386, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16725, 4, 4, -1, 'Lightforge Boots', 29967, 3, 0, 1, 119550, 23910, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 18, 6, 9, 4, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16726, 4, 4, -1, 'Lightforge Breastplate', 29969, 3, 0, 1, 175392, 35078, 5, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 21, 5, 16, 4, 13, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 657, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 135, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16727, 4, 4, -1, 'Lightforge Helm', 31207, 3, 0, 1, 130028, 26005, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 20, 4, 13, 5, 14, 6, 10, 3, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 526, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16728, 4, 4, -1, 'Lightforge Legplates', 29972, 3, 0, 1, 171993, 34398, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 20, 7, 14, 5, 12, 6, 9, 3, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 557, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16729, 4, 4, -1, 'Lightforge Spaulders', 29971, 3, 0, 1, 127443, 25488, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 15, 5, 11, 4, 9, 6, 5, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 470, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 188, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16730, 4, 4, -1, 'Breastplate of Valor', 29958, 3, 0, 1, 178058, 35611, 5, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 24, 4, 15, 3, 10, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 657, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 135, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16731, 4, 4, -1, 'Helm of Valor', 42241, 3, 0, 1, 131997, 26399, 1, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 23, 4, 15, 3, 9, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 526, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16732, 4, 4, -1, 'Legplates of Valor', 29963, 3, 0, 1, 179248, 35849, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 23, 7, 15, 3, 11, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 557, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16733, 4, 4, -1, 'Spaulders of Valor', 29964, 3, 0, 1, 132813, 26562, 3, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 17, 4, 11, 3, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 470, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16734, 4, 4, -1, 'Boots of Valor', 29960, 3, 0, 1, 126948, 25389, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 20, 4, 8, 3, 4, 6, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 424, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16735, 4, 4, -1, 'Bracers of Valor', 29961, 3, 0, 1, 76897, 15379, 9, -1, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 14, 4, 7, 3, 3, 6, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 261, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16736, 4, 4, -1, 'Belt of Valor', 29959, 3, 0, 1, 81796, 16359, 6, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 14, 7, 8, 3, 7, 6, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 341, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (16737, 4, 4, -1, 'Gauntlets of Valor', 29962, 3, 0, 1, 86195, 17239, 10, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 17, 7, 10, 6, 8, 3, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 386, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 189, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (17740, 4, 2, -1, 'Soothsayer\'s Headdress', 29941, 3, 0, 1, 57006, 11401, 1, -1, -1, 52, 46, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18036, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 175, 0, '', 47, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18318, 4, 3, -1, 'Merciful Greaves', 30679, 3, 0, 1, 110286, 22057, 8, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 14, 7, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9407, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18327, 4, 1, -1, 'Whipvine Cord', 30688, 3, 0, 1, 46880, 9376, 6, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21626, 1, 0, 0, -1, 0, -1, 9317, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18377, 4, 2, -1, 'Quickdraw Gloves', 30729, 3, 0, 1, 60879, 12175, 10, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 8, 4, 7, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 109, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13669, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18384, 4, 4, -1, 'Bile-etched Spaulders', 30743, 3, 0, 1, 131046, 26209, 3, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 17, 7, 6, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 485, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13385, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18386, 4, 1, -1, 'Padre\'s Trousers', 21964, 3, 0, 1, 99411, 19882, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21626, 1, 0, 0, -1, 0, -1, 18032, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18389, 4, 1, -1, 'Cloak of the Cosmos', 15247, 3, 0, 1, 78462, 15692, 16, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 11, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9315, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18391, 4, 2, -1, 'Eyestalk Cord', 30749, 3, 0, 1, 65858, 13171, 6, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 15, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18029, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18395, 4, 0, -1, 'Emerald Flame Ring', 9842, 3, 0, 1, 146580, 36645, 11, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 12, 6, 8, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7681, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18396, 2, 7, -1, 'Mind Carver', 30754, 3, 0, 1, 268138, 53627, 21, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 106, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2000, 0, 0, 9417, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 3, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18469, 4, 0, -1, 'Royal Seal of Eldre\'Thalas', 29712, 3, 0, 1, 0, 0, 12, 16, -1, 62, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 9318, 1, 0, 0, -1, 0, -1, 21618, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Blessed by the Shen\'dralar Ancients.', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18470, 4, 0, -1, 'Royal Seal of Eldre\'Thalas', 29712, 3, 0, 1, 0, 0, 12, 1024, -1, 62, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 17371, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Blessed by the Shen\'dralar Ancients.', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18471, 4, 0, -1, 'Royal Seal of Eldre\'Thalas', 29712, 3, 0, 1, 0, 0, 12, 64, -1, 62, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 14047, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Blessed by the Shen\'dralar Ancients.', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18472, 4, 0, -1, 'Royal Seal of Eldre\'Thalas', 29712, 3, 0, 1, 0, 0, 12, 2, -1, 62, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 15693, 1, 0, 0, 0, 0, 0, 9408, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Blessed by the Shen\'dralar Ancients.', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18497, 4, 1, -1, 'Sublime Wristguards', 30833, 3, 0, 1, 48657, 9731, 9, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 10, 6, 6, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9417, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18503, 4, 4, -1, 'Kromcrush\'s Chestplate', 30837, 3, 0, 1, 183741, 36748, 5, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 16, 7, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 777, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13390, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 135, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 130, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18523, 4, 0, -1, 'Brightly Glowing Stone', 30855, 3, 0, 1, 13924, 3481, 23, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18030, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18527, 4, 3, -1, 'Harmonious Gauntlets', 30862, 3, 0, 1, 8095, 1619, 10, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 5, 6, 5, 7, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18035, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18680, 2, 2, -1, 'Ancient Bone Bow', 30926, 3, 0, 1, 182973, 36594, 15, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 145, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2800, 2, 100, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18682, 4, 2, -1, 'Ghoul Skin Leggings', 10006, 3, 0, 1, 122915, 24583, 7, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 20, 5, 8, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17371, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18700, 4, 2, -1, 'Malefic Bracers', 27048, 3, 0, 1, 54552, 10910, 9, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 16, 3, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18701, 4, 0, -1, 'Innervating Band', 28733, 3, 524288, 1, 145640, 36410, 11, -1, -1, 59, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 15, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18702, 4, 4, -1, 'Belt of the Ordained', 31143, 3, 0, 1, 85322, 17064, 6, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 8, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 353, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18032, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18721, 4, 3, -1, 'Barrage Girdle', 31171, 3, 0, 1, 73446, 14689, 6, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 6, 6, 6, 7, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14047, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18723, 4, 0, -1, 'Animated Chain Necklace', 6539, 3, 0, 1, 167814, 41953, 2, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9318, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (18807, 4, 3, -1, 'Helm of Latent Power', 37667, 3, 0, 1, 128980, 25796, 1, -1, -1, 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 14, 6, 12, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 297, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18384, 1, 0, 0, -1, 0, -1, 9343, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (19052, 4, 2, -1, 'Dawn Treaders', 34504, 3, 0, 1, 88105, 17621, 8, -1, -1, 58, 53, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13669, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (19888, 4, 1, -1, 'Overlord\'s Embrace', 32339, 3, 0, 1, 84878, 16975, 16, -1, -1, 71, 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 140, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13385, 1, 0, 0, -1, 0, -1, 13674, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 90, '', 50, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (19912, 4, 0, -1, 'Overlord\'s Onyx Band', 32323, 3, 524288, 1, 174192, 43548, 11, -1, -1, 68, 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13675, 1, 0, 0, -1, 0, -1, 13669, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 464, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 49, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (19968, 2, 7, -1, 'Fiery Retributer', 32443, 3, 0, 1, 279834, 55966, 13, -1, -1, 68, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 4, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 1800, 0, 0, 13383, 1, 0, 0, -1, 0, -1, 7711, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 49, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (19993, 2, 2, -1, 'Hoodoo Hunting Bow', 32571, 3, 0, 1, 213650, 42730, 15, -1, -1, 68, 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 10, 7, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 86, 160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2800, 2, 100, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 49, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (20261, 4, 2, -1, 'Shadow Panther Hide Belt', 30749, 3, 0, 1, 64107, 12821, 6, -1, -1, 65, 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 16, 4, 8, 7, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13669, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 35, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (20266, 4, 4, -1, 'Peacekeeper Leggings', 32756, 3, 0, 1, 190096, 38019, 7, -1, -1, 68, 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 18, 7, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 618, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18030, 1, 0, 0, -1, 0, -1, 21364, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 49, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (20556, 2, 10, -1, 'Wildstaff', 24014, 3, 0, 1, 203339, 40667, 17, -1, -1, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 10, 5, 9, 7, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 135, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2500, 0, 0, 15464, 1, 0, 0, -1, 0, -1, 7597, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 175, 0, '', 47, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (20710, 4, 4, -1, 'Crystal Encrusted Greaves', 33152, 3, 0, 1, 129365, 25873, 8, -1, -1, 63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7518, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 60, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (20711, 4, 4, -1, 'Crystal Lined Greaves', 33152, 3, 0, 1, 129867, 25973, 8, -1, -1, 63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 12, 4, 12, 5, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 452, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7681, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (21503, 4, 4, -1, 'Belt of the Sand Reaver', 33905, 3, 0, 1, 96964, 19392, 6, 32767, -1, 71, 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 18, 4, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 494, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7518, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 80, '', 50, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (21567, 4, 0, -1, 'Rune of Duty', 7248, 3, 32768, 1, 0, 0, 12, 260623, -1, 45, 40, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21599, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (21784, 4, 0, -1, 'Figurine - Black Diamond Crab', 39916, 3, 64, 1, 60000, 15000, 12, -1, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13384, 1, 0, 0, 0, 0, 0, 26609, 0, 0, 0, 300000, 28, 60000, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (21792, 4, 0, -1, 'Necklace of the Diamond Tower', 39214, 3, 0, 1, 100872, 25218, 2, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3, 0, 0, 0, 21407, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (21801, 2, 19, -1, 'Antenna of Invigoration', 35017, 3, 0, 1, 198386, 39677, 26, 32767, -1, 68, 60, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80, 149, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1600, 0, 100, 21361, 1, 0, 0, -1, 0, -1, 7680, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 2, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 49, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (21996, 4, 4, -1, 'Bracers of Heroism', 34612, 3, 0, 1, 92717, 18543, 9, -1, -1, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 14, 4, 9, 3, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7515, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 511, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22000, 4, 4, -1, 'Legplates of Heroism', 34615, 3, 0, 1, 189563, 37912, 7, -1, -1, 66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 25, 7, 16, 3, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 601, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13383, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 511, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 49, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22001, 4, 4, -1, 'Spaulders of Heroism', 34616, 3, 0, 1, 140588, 28117, 3, -1, -1, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 18, 4, 12, 3, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 507, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 511, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22272, 4, 2, -1, 'Forest\'s Embrace', 34714, 3, 0, 1, 75761, 15152, 5, -1, -1, 52, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 8, 6, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 151, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18036, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 175, 0, '', 47, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22275, 4, 2, -1, 'Firemoss Boots', 6762, 3, 0, 1, 76917, 15383, 8, 32767, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 18, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 112, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9407, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22321, 4, 0, -1, 'Heart of Wyrmthalak', 6006, 3, 524352, 1, 42158, 10539, 12, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27656, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22334, 4, 0, -1, 'Band of Mending', 9837, 3, 524288, 1, 55130, 13782, 11, -1, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 5, 7, 6, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9317, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22335, 2, 10, -1, 'Lord Valthalak\'s Staff of Command', 34891, 3, 0, 1, 320650, 64130, 17, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 11, 5, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 90, 136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2100, 0, 0, 14798, 1, 0, 0, -1, 0, -1, 23727, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22336, 4, 6, -1, 'Draconian Aegis of the Legion', 18790, 3, 0, 1, 164786, 32957, 14, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2153, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14799, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 4, 0, 0, 40, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22340, 4, 0, -1, 'Pendant of Celerity', 9852, 3, 0, 1, 421315, 65328, 2, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15464, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22380, 2, 4, -1, 'Simone\'s Cultivating Hammer', 34860, 3, 0, 1, 275269, 55053, 21, 32767, -1, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50.66, 97.66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1800, 0, 0, 18030, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, -1.3, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22395, 4, 9, -1, 'Totem of Rage', 34957, 3, 0, 1, 64867, 12973, 28, 32767, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27859, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22397, 4, 8, -1, 'Idol of Ferocity', 34955, 3, 0, 1, 65339, 13067, 28, 32767, -1, 57, 52, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27851, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22398, 4, 8, -1, 'Idol of Rejuvenation', 34954, 3, 0, 1, 78777, 15755, 28, 32767, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27853, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22401, 4, 7, -1, 'Libram of Hope', 34960, 3, 0, 1, 79620, 15924, 28, 32767, -1, 62, 57, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 27848, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22403, 4, 0, -1, 'Diana\'s Pearl Necklace', 9858, 3, 0, 1, 167814, 41953, 2, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 8, 5, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23727, 1, 0, 0, -1, 0, -1, 9415, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22404, 2, 13, -1, 'Willey\'s Back Scratcher', 34896, 3, 0, 1, 264568, 52913, 21, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 136, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2600, 0, 0, 9140, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22405, 4, 1, -1, 'Mantle of the Scarlet Crusade', 34897, 3, 0, 1, 72077, 14415, 3, -1, -1, 61, 56, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 11, 5, 11, 6, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9407, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22433, 4, 0, -1, 'Don Mauricio\'s Band of Domination', 24022, 3, 524288, 1, 61130, 15282, 11, -1, -1, 63, 58, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9416, 1, 0, 0, 0, 0, 0, 18384, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (22680, 4, 0, -1, 'Band of Resolution', 3666, 3, 0, 1, 42837, 10709, 11, -1, -1, 66, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 7, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13383, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 49, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (23198, 4, 8, -1, 'Idol of Brutality', 34955, 3, 0, 1, 78749, 15749, 28, 32767, -1, 65, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28855, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (23200, 4, 9, -1, 'Totem of Sustaining', 34956, 3, 0, 1, 79339, 15867, 28, 32767, -1, 65, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28856, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (23201, 4, 7, -1, 'Libram of Divinity', 34960, 3, 0, 1, 79627, 15925, 28, 32767, -1, 65, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28853, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (23274, 4, 4, -1, 'Knight-Lieutenant\'s Lamellar Gauntlets', 30321, 3, 32768, 1, 0, 0, 10, 2, -1, 66, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 7, 13, 4, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 429, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23300, 1, 0, 0, -1, 0, -1, 7597, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 544, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (23276, 4, 4, -1, 'Lieutenant Commander\'s Lamellar Headguard', 30316, 3, 32768, 1, 0, 0, 1, 2, -1, 71, 60, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 7, 19, 4, 18, 5, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 598, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18049, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 544, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, '', 0, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (25780, 4, 1, -1, 'Warmaul Defender\'s Cloak', 39685, 2, 0, 1, 101037, 20207, 16, -1, -1, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 14, 7, 21, 32, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (25784, 4, 0, -1, 'Imbued Chain', 15420, 2, 0, 1, 114184, 28546, 2, -1, -1, 87, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 16, 4, 12, 3, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 13, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (25926, 4, 0, -1, 'Nexus-Stalker\'s Band', 9834, 2, 0, 1, 128092, 32023, 11, -1, -1, 99, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 14, 3, 13, 7, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'Worn by affiliates of the Consortium.', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 225, 0, '', 13, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (28972, 2, 16, -1, 'Flightblade Throwing Axe', 23723, 3, 4194304, 1, 9400, 2350, 25, 32767, -1, 60, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 6, 7, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2200, 0, 100, 9141, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 200, 0, '', 48, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (29776, 4, 0, -1, 'Core of Ar\'kelos', 33520, 2, 0, 1, 138516, 34629, 12, -1, -1, 108, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35733, 0, 0, 0, 120000, 1141, 20000, 15812, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (29786, 4, 4, -1, 'Kirin\'Var Defender\'s Greaves', 26874, 2, 0, 1, 189209, 37841, 8, -1, -1, 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 16, 7, 18, 4, 21, 31, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 703, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (29789, 4, 4, -1, 'Andrethan\'s Masterwork', 26332, 2, 0, 1, 255494, 51098, 5, -1, -1, 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 32, 19, 7, 27, 4, 34, 31, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1023, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (29807, 4, 4, -1, 'Engraved Cattleman\'s Buckle', 24514, 2, 0, 1, 127539, 25507, 6, -1, -1, 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 21, 7, 30, 31, 10, 32, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 575, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (29812, 4, 4, -1, 'Blued Steel Gauntlets', 26872, 2, 0, 1, 129839, 25967, 10, -1, -1, 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 28, 4, 16, 31, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 639, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (29969, 4, 4, -1, 'Sparky\'s Discarded Helmet', 42995, 2, 0, 1, 177809, 35561, 1, -1, -1, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 29, 32, 28, 7, 25, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 810, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (29980, 4, 4, -1, 'Midrealm Leggings', 26814, 2, 0, 1, 266483, 53296, 7, -1, -1, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 39, 32, 21, 7, 16, 31, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 918, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (30005, 4, 4, -1, 'Overmaster\'s Shoulders', 18497, 2, 0, 1, 183874, 36774, 3, -1, -1, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 32, 16, 31, 8, 7, 12, 4, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 787, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (30227, 2, 16, -1, 'Mark V\'s Throwing Star', 39999, 2, 4194304, 1, 138516, 34629, 25, -1, -1, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 7, 7, 10, 31, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61, 115, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1700, 0, 100, 9142, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 33, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (30339, 4, 0, -1, 'Protectorate Assassin\'s Ring', 2854, 2, 0, 1, 145472, 36368, 11, -1, -1, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 13, 4, 16, 3, 15, 31, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (30394, 2, 8, -1, 'Sunfury Blade', 20167, 2, 0, 1, 433813, 86762, 17, -1, -1, 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 4, 39, 32, 21, 37, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 337, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3500, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 33, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (30402, 4, 4, -1, 'Field Agent\'s Bracers', 24511, 2, 0, 1, 119907, 23981, 9, -1, -1, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 7, 16, 3, 8, 4, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 436, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, 'The inner surface is inscribed with the name of B.O.O.M.', 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);
REPLACE INTO `item_template` VALUES (31617, 4, 0, -1, 'Ancient Draenei War Talisman', 30696, 2, 524288, 1, 32891, 8222, 12, -1, -1, 102, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 32, 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33667, 0, 0, 0, 90000, 1141, 15000, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 0, 0, 0, 0, -1, 0, -1, 1, '', 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275, 0, '', 14, 0, 0, 0, 0);

UPDATE `command` SET `permission_mask`=1 WHERE `name` IN('account gann','charactivatelevel','charstoplevel','commands','debug threatlist','distance','guild ann','guild info','password','quest showlowlevel',
'server info','start','help');
UPDATE `command` SET `permission_mask`=256 WHERE `name` IN('account','bank','bindfollow','bindsight','demorph','dismount','event','event activelist','gm','gm announce','gm chat','gm fly','gm nameannounce',
'gm notify','go creature','go graveyard','go grid','go object','go ticket','go trigger','go xy','go xyz','go zonexy','gobject grid','gobject near','gobject target','goname','gps','guid',
'hover','instance listbinds','instance selfunbind','instance stats','list auras','list creature','lookup area','lookup creature','lookup event','lookup faction','lookup item','lookup itemset',
'lookup object','lookup quest','lookup skill','lookup spell','lookup tele','modify morph','modify mount','modify scale','neargrave','npc info','save','tele','ticket assign','ticket close',
'ticket closedlist','ticket comment','ticket list','ticket onlinelist','ticket response','ticket unassign','ticket viewid','ticket viewname','unbindfollow','unbindsight','unpossess','whispers');
UPDATE `command` SET `permission_mask`=2048 WHERE `name` IN('ban account','ban character','ban email','ban ip','baninfo account','baninfo character','baninfo email','baninfo ip','banlist account',
'banlist character','banlist email','banlist ip','channel kick','channel list','channel pass','combatstop','gm list','gm visible','gobject reset','groupgo','kick','listfreeze','lookup player account',
'lookup player email','lookup player ip','lookup player listip','modify aspeed','modify bwalk','modify drunk','modify fly','modify speed','modify swim','mute','muteinfo','namego','pinfo','quest',
'quest add','quest complete','quest remove','recall','rename','respawn','revive','revivegroup','send mail','send message','tele add','tele group','tele name','unban account','unban character',
'unban email','unban ip','unfreeze','unmute','waterwalk','weather','freeze');
UPDATE `command` SET `permission_mask`=4096 WHERE `name` IN('additem','additemset','announce','aura','cast','cast back','cast dist','cast null','cast self','cast target','cd','channel masskick',
'cometome','cooldown','damage','die','gobject activate','gobject addtemp','guild create','guild disable announce','guild enable announce','guild invite','guild rank','guild uninvite',
'honor','honor add','honor addkill','honor update','instance unbind','learn','levelup','lockaccount','maxskill','modify arena','modify energy','modify gender','modify honor','modify hp',
'modify mana','modify rage','modify rep','modify titles','modify tp','notify','npc addtemp','npc enterevademode','npc follow','npc playemote','npc resetai','npc say','npc textemote','npc unfollow',
'npc whisper','npc yell','pet','pet create','pet learn','pet tp','pet unlearn','playall','possess','repairitems','reset talents','send items','setskill','settitle','showarea','taxicheat','tele del',
'unaura','unlearn','nameannounce');
UPDATE `command` SET `permission_mask`=8192 WHERE `name` IN('account create','account delete','account delmultiacc','account log','account set','account set addon','account set multiacc',
'account set password','account set permissions','account whisp','changeacc','chardelete','debug','debug anim','debug arena','debug getinstdata','debug bg','debug getitemstate','debug getvalue',
'debug lootrecipient','debug Mod32Value','debug play cinematic','debug play sound','debug poolstats','debug send buyerror','debug send channelnotify','debug send chatmessage','debug send equiperror',
'debug send opcode','debug send qinvalidmsg','debug send qpartymsg','debug send sellerror','debug send spellfail','debug setinstdata','debug setinstdata64','debug setitemflag','debug setvalue',
'debug showcombatstats','debug update','debug uws','event start','event stop','explorecheat','flusharenapoints','gobject add','gobject delete','gobject move','gobject turn','guild delete',
'guild info','guild setlevel','hidearea','instance savedata','itemmove','learn all','learn all_crafts','learn all_default','learn all_gm','learn all_lang','learn all_myclass','learn all_myspells',
'learn all_mytalents','learn all_recipes','linkgrave','list object','loadscripts','mmap','modify bit','modify faction','modify Mod32Value','modify money','modify spell','modify standstate',
'movegens','npc add','npc addformation','npc additem','npc addmove','npc changeentry','npc changelevel','npc delete','npc deleteformation','npc delitem','npc doaction','npc factionid',
'npc fieldflags','npc flag','npc move','npc name','npc setlink','npc setmodel','npc setmovetype','npc spawndist','npc spawntime','npc subname','path','path add','path event','path load',
'path modify','path reloadpath','path show','path tofile','path unload','plimit','reload','reload access_requirement','reload all','reload all_area','reload all_item','reload all_locales',
'reload all_loot','reload all_npc','reload all_quest','reload all_scripts','reload all_spell','reload areatrigger_involvedrelation','reload areatrigger_tavern','reload areatrigger_teleport',
'reload auctions','reload autobroadcast','reload command','reload config','reload creature_ai_scripts','reload creature_involvedrelation','reload creature_linked_respawn','reload creature_loot_template',
'reload creature_questrelation','reload disenchant_loot_template','reload eventai','reload event_scripts','reload fishing_loot_template','reload gameobject_involvedrelation','reload gameobject_loot_template',
'reload gameobject_questrelation','reload gameobject_scripts','reload game_graveyard_zone','reload game_tele','reload gm_tickets','reload item_enchantment_template','reload item_loot_template',
'reload locales_creature','reload locales_gameobject','reload locales_item','reload locales_npc_text','reload locales_page_text','reload locales_quest','reload npc_gossip','reload npc_option',
'reload npc_trainer','reload npc_vendor','reload page_text','reload pickpocketing_loot_template','reload prospecting_loot_template','reload quest_end_scripts','reload quest_mail_loot_template',
'reload quest_start_scripts','reload quest_template','reload reference_loot_template','reload reputation_reward_rate','reload reputation_spillover_template','reload reserved_name','reload skill_discovery_template',
'reload skill_extra_item_template','reload skill_fishing_base_level','reload skinning_loot_template','reload spell_affect','reload spell_disabled','reload spell_elixir','reload spell_enchant_proc_data',
'reload spell_pet_auras','reload spell_proc_event','reload spell_required','reload spell_scripts','reload spell_script_target','reload spell_target_position','reload spell_threats',
'reload trinity_string','reload unqueue_account','reload waypoint_scripts','reset all','reset honor','reset level','reset spells','reset stats','send money','server corpses','server exit',
'server idlerestart','server idlerestart cancel','server idleshutdown','server idleshutdown cancel','server motd','server restart','server restart cancel','server rollshutdown','server set difftime',
'server set loglevel','server set motd','server shutdown','server shutdown cancel','showhonor','ticket delete','vipadd','vipdel','wchange','wp','wp add','wp event','wp load','wp modify','wp reloadpath',
'wp show','wp tofile','wp unload','guild givexp');
UPDATE `command` SET `permission_mask`=16384 WHERE `name` IN('account change','account onlinelist','allowmove','crash','crash map','crash server','list item');

DELETE FROM `command` WHERE `name` IN('mentoring','mentorlist','changeaccount');
INSERT INTO `command` (`name`, `permission_mask`) VALUES 
('mentoring', '256'),
('mentorlist', '256'),
('changeaccount', '8192');

-- Delete useless path for Inspector Tarem. He was just spamming the kneel emote for no reason
DELETE FROM `waypoint_data` WHERE `id`=372;
UPDATE `creature_addon` SET `path_id`=0 WHERE guid=18594;

