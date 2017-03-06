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

-- Illidan Stormrage 22917- boss_illidan_stormrage
UPDATE `creature_template` SET `minhealth`='7284480',`maxhealth`='7284480' WHERE `entry` = 22917; -- 6070400 -- 7284480

-- Flame of Azzinoth 22997- boss_illidan_flameofazzinoth
UPDATE `creature_template` SET `minhealth`='1365840',`maxhealth`='1365840' WHERE `entry` = 22997; -- 1138200 -- 1365840

