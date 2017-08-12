-- ================
-- Arena Season 1
-- ================

SET @GUID := 199900;

DELETE FROM `creature` WHERE `id` IN (18898,19857,20278,23396,24392,24394,24395,24451,24452,25176,25177,25178,25179,26352,26378,26383,26384,27668,27721,27722,28225,77771,77772,77773,77774,77775,77776,77777,77778,1200050,1200057,1200061,12777,12792,23446,23447,24520,24668,24670,24672,26393,26395,26397,26398,77710,77779,1200051,1200052,1200053,1200054,1200055,1200056,1200059,1200060,26304,26305);

INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200057, 1, 1, 0, 0, -7118.7109, -3776.7121, 8.7466, 0.3197, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200057, 530, 1, 0, 0, 3070.1987, 3632.4182, 143.7810, 1.2072, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200057, 450, 1, 0, 0, 262.3464, 86.1316, 25.7198, 3.2060, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200054, 450, 1, 0, 0, 261.6542, 90.4808, 25.7210, 3.6099, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200055, 450, 1, 0, 0, 244.667, 103.94, 25.7206, 4.54998, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200056, 450, 1, 0, 0, 250.256, 101.317, 25.7211, 4.3434, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200057, 449, 1, 0, 0, 8.3817, 21.1129, 1.0558, 3.1393, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200052, 449, 1, 0, 0, 8.4142, 26.6698, 1.0558, 3.1393, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200053, 449, 1, 0, 0, 7.0471, 18.6628, 1.05583, 1.57548, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200051, 449, 1, 0, 0, -7.23101, 35.5028, 1.05583, 4.72225, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200057, 530, 1, 0, 0, -1968.5123, 5171.7255, -38.3079, 0.4689, 300, 0, 0, 1, 0, 0, 0);
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200057, 530, 1, 0, 0, 2890.4035, 5981.6450, 2.8027, 0.9166, 300, 0, 0, 1, 0, 0, 0); 
INSERT INTO `creature` VALUES (@GUID := @GUID + 1, 1200057, 530, 1, 0, 0, -2163.7885, 6653.3735, -0.2625, 5.96662, 300, 0, 0, 1, 0, 0, 0);

-- ================
-- Optional
-- ================

-- AV Mark Trader
-- INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200007,450,1,0,0,235.7808,101.0694,25.7211,5.1641,300,0,0,11000,0,0,0);
-- INSERT INTO `creature` VALUES (@GUID := @GUID + 1,1200007,449,1,0,0,-0.6561,36.4941,1.05583,4.6986,300,0,0,11000,0,0,0);

UPDATE `creature`, `creature_template` SET `creature`.`curhealth` = `creature_template`.`MinHealth`, `creature`.`curmana` = `creature_template`.`MinMana` WHERE `creature`.`id` = `creature_template`.`entry` AND `creature_template`.`RegenHealth` & '1';
