-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/458/instance-gameobjects
--
--
-- -----------------------------------------------------------------
-- Spawn All Gameobjects in all TBC-Instances
-- -----------------------------------------------------------------
--
--
-- Master Pool Templates
--
DELETE FROM `pool_template` WHERE `entry` BETWEEN '2992' AND '2999';
INSERT INTO `pool_template` VALUES
--
(2992,6,'Master Herb Pool - The Botanica'), -- max 6 spawns per id
(2993,5,'Master Herb Pool - Shadow Labyrinth'), -- max 5 spawns per id
(2994,4,'Master Herb Pool - Auchenai Crypts'), -- max 4 spawns per id
(2995,6,'Master Herb Pool - The Underbog'), -- max 6 spawns per id
(2996,4,'Master Herb Pool - Sethekk Halls'), -- max 4 spawns per id
(2997,5,'Master Herb Pool - The Steamvault'), -- max 5 spawns per id
(2998,4,'Master Herb Pool - The Slave Pens'), -- max 4 spawns per id
(2999,4,'Master Herb Pool - Mana-Tombs'); -- max 4 spawns per id
--
--
-- ================================================
-- Spawns
-- ================================================
--
SET @GGUID := 9999000;
DELETE FROM gameobject WHERE guid BETWEEN @GGUID AND @GGUID+123;
--
-- ================================================
-- Mana-Tombs 557 
-- ================================================
--
-- ============================
-- Ancient Lichen 181278 22 Spawns
-- ============================
--
-- 3496018
INSERT INTO gameobject VALUES (@GGUID,181278,557,3,-96.5428,-121.9535,7.6393,0.6649,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+1,181278,557,3,-13.9267,-224.1375,1.6038,0.0759,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+2,181278,557,3,-106.9524,-199.7739,-1.7556,3.7398,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+3,181278,557,3,-105.0052,-248.4696,-0.6580,1.4896,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+4,181278,557,3,-232.8580,-219.3262,-1.7038,5.6640,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+5,181278,557,3,-250.6222,-173.6582,0.2163,5.7504,0,0,0,0,86400,100,1);
-- 3496016
INSERT INTO gameobject VALUES (@GGUID+6,181278,557,3,-305.0610,-169.8128,9.7360,4.5251,0,0,0,0,86400,100,1);
-- 3497922
-- 3496017
-- 3497920
INSERT INTO gameobject VALUES (@GGUID+7,181278,557,3,-350.4886,-179.6122,-0.9822,3.0407,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+8,181278,557,3,-396.3511,-171.6109,-0.9744,0.0994,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+9,181278,557,3,-362.4905,-142.9416,-0.4630,3.1389,0,0,0,0,86400,100,1);
-- 3497103
INSERT INTO gameobject VALUES (@GGUID+10,181278,557,3,-389.4281,-50.9376,-0.9781,5.7346,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+11,181278,557,3,-380.9594,-25.2826,-0.9600,5.4323,0,0,0,0,86400,100,1);
-- 3496015
INSERT INTO gameobject VALUES (@GGUID+12,181278,557,3,-247.5678,3.8457,16.9003,3.1036,0,0,0,0,86400,100,1);
-- 3497921
INSERT INTO gameobject VALUES (@GGUID+13,181278,557,3,-228.6693,26.4206,17.3579,3.1900,0,0,0,0,86400,100,1);
--
-- ============================
-- 181556 Adamantite Deposit 13 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181556) AND `map` IN (557);
--
-- ============================
-- 181569 Rich Adamantite Deposit 7 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181569) AND `map` IN (557);
--
-- ============================
-- 181557 Khorium Vein 2 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181557) AND `map` IN (557);
--
-- ================================================
-- Sethekk Halls 556 
-- ================================================
--
-- ============================
-- Ancient Lichen 181278 18 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+14,181278,556,3,87.7146,115.8216,0.3582,3.7939,0,0,0,0,86400,100,1);
-- 3497098
INSERT INTO gameobject VALUES (@GGUID+15,181278,556,3,-75.0443,76.0778,0.0054,0.7779,0,0,0,0,86400,100,1);
-- 3497100
INSERT INTO gameobject VALUES (@GGUID+16,181278,556,3,-69.4806,176.6845,0.0103,4.4889,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+17,181278,556,3,-241.1965,202.2738,-0.0137,5.3882,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+18,181278,556,3,-246.0114,147.8707,0.0632,1.1903,0,0,0,0,86400,100,1);
-- 3497096
INSERT INTO gameobject VALUES (@GGUID+19,181278,556,3,-236.7799,345.4994,27.0003,5.4275,0,0,0,0,86400,100,1);
-- 3497092
-- 3497099
INSERT INTO gameobject VALUES (@GGUID+20,181278,556,3,-192.2959,271.1188,26.9074,1.0450,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+21,181278,556,3,-117.2071,260.6297,26.8428,1.7911,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+22,181278,556,3,-99.1734,314.4681,26.5422,4.3908,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+23,181278,556,3,-90.9299,285.0844,26.4831,3.6250,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+24,181278,556,3,-78.8806,277.4134,25.9685,3.1302,0,0,0,0,86400,100,1);
-- 3497097
INSERT INTO gameobject VALUES (@GGUID+25,181278,556,3,-49.7114,275.5465,26.8807,1.6301,0,0,0,0,86400,100,1);
--
-- ============================
-- 181556 Adamantite Deposit 16 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181556) AND `map` IN (556);
--
-- ============================
-- 181569 Rich Adamantite Deposit 13 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181569) AND `map` IN (556);
--
-- ============================
-- 181557 Khorium Vein 3 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181557) AND `map` IN (556);
--
-- ================================================
-- The Underbog 546
-- ================================================
--
DELETE FROM `gameobject` WHERE `guid` IN (32630,44742);
--
-- ============================
-- Felweed 181270 8 Spawn Points
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+26,181270,546,3,210.5737,41.1370,27.5625,3.8471,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+27,181270,546,3,134.6080,-84.8074,26.6971,6.1444,0,0,0,0,86400,100,1);
-- 3496969
INSERT INTO gameobject VALUES (@GGUID+28,181270,546,3,281.4347,-117.0561,29.7730,4.1416,0,0,0,0,86400,100,1);
-- 3496967
INSERT INTO gameobject VALUES (@GGUID+29,181270,546,3,139.5271,50.1643,27.0406,4.9074,0,0,0,0,86400,100,1);
-- 3496970
INSERT INTO gameobject VALUES (@GGUID+30,181270,546,3,-141.7918,-339.7595,33.2642,5.2687,0,0,0,0,86400,100,1);
--
-- ============================
-- Flame Cap 181276 7 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+31,181276,546,3,139.5271,50.1643,27.0406,4.9074,0,0,0,0,86400,100,1); -- @GGUID+40
INSERT INTO gameobject VALUES (@GGUID+32,181276,546,3,56.7509,-31.7603,21.0322,0.9529,0,0,0,0,86400,100,1); -- @GGUID+41
INSERT INTO gameobject VALUES (@GGUID+33,181276,546,3,141.9367,-148.1493,30.0807,0.3324,0,0,0,0,86400,100,1); -- @GGUID+42
UPDATE `gameobject` SET `position_x`='278.915985', `position_y`='-236.037003', `position_z`='29.1704', `orientation`='2.705260' WHERE `guid` IN ('3497065'); -- 3497063
INSERT INTO gameobject VALUES (@GGUID+34,181276,546,3,308.0365,-297.2597,21.2990,4.5636,0,0,0,0,86400,100,1); -- @GGUID+37
INSERT INTO gameobject VALUES (@GGUID+35,181276,546,3,348.469391,-340.080902,29.879873,3.3266,0,0,0,0,86400,100,1); -- @GGUID+38
INSERT INTO gameobject VALUES (@GGUID+36,181276,546,3,376.428986,-453.140991,33.199501,-2.251470,0,0,0,0,86400,100,1); -- 3497060
--
-- ============================
-- Ragveil 181275 8 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+37,181275,546,3,308.0365,-297.2597,21.2990,4.5636,0,0,0,0,86400,100,1); -- 
INSERT INTO gameobject VALUES (@GGUID+38,181275,546,3,348.469391,-340.080902,29.879873,3.3266,0,0,0,0,86400,100,1); -- 
INSERT INTO gameobject VALUES (@GGUID+39,181275,546,3,98.150002,-217.300003,30.320000,3.000000,0,0,0,0,86400,100,1); -- 14113585
INSERT INTO gameobject VALUES (@GGUID+40,181275,546,3,139.5271,50.1643,27.0406,4.9074,0,0,0,0,86400,100,1); -- 
INSERT INTO gameobject VALUES (@GGUID+41,181275,546,3,56.7509,-31.7603,21.0322,0.9529,0,0,0,0,86400,100,1); -- 
INSERT INTO gameobject VALUES (@GGUID+42,181275,546,3,141.9367,-148.1493,30.0807,0.3324,0,0,0,0,86400,100,1); -- 
-- 3497060 -- @GGUID+36
-- 3497063 -- 3497065
--
-- ============================
-- Ancient Lichen 181278 16 Spawns
-- ============================
--
-- 3497101
INSERT INTO gameobject VALUES (@GGUID+43,181278,546,3,62.731445,-128.980804,-2.758906,2.955444,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+44,181278,546,3,-8.501747,-85.244743,-4.533485,4.706873,0,0,0,0,86400,100,1);
-- 3497113
INSERT INTO gameobject VALUES (@GGUID+45,181278,546,3,-44.983326,-208.804550,-4.536035,4.883576,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+46,181278,546,3,-133.631363,-204.648392,-3.451222,5.295897,0,0,0,0,86400,100,1);
-- 3497110
INSERT INTO gameobject VALUES (@GGUID+47,181278,546,3,-98.379997,-312.299988,-4.040000,2.000000,0,0,0,0,86400,100,1); -- 14113593
INSERT INTO gameobject VALUES (@GGUID+48,181278,546,3,10.911406,-400.743713,27.301226,2.307454,0,0,0,0,86400,100,1);
-- 3497104 
-- 3497111
INSERT INTO gameobject VALUES (@GGUID+49,181278,546,3,66.724800,-269.042511,32.272633,3.858610,0,0,0,0,86400,100,1);
-- 3497102
INSERT INTO gameobject VALUES (@GGUID+50,181278,546,3,352.754547,-447.540924,31.719244,5.731786,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+51,181278,546,3,325.518127,-403.049652,46.245808,0.281113,0,0,0,0,86400,100,1);
-- 3497112
--
-- ============================
-- 181556 Adamantite Deposit 13 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181556) AND `map` IN (546);
--
-- ============================
-- 181569 Rich Adamantite Deposit 3 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181569) AND `map` IN (546);
--
-- ============================
-- 181557 Khorium Vein 1 Spawn
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181557) AND `map` IN (546);
--
-- ================================================
--  Slave Pens 547
-- ================================================
--
-- ============================
-- Flame Cap 181276 8 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+52,181276,547,3,-4.9537,-7.236,-1.3325,4.2254,0,0,0,0,86400,100,1); -- + 78
INSERT INTO gameobject VALUES (@GGUID+53,181276,547,3,-55.941502,-29.017401,-1.694970,-1.326450,0,0,0,0,86400,100,1); -- 3497059
-- 3497064
INSERT INTO gameobject VALUES (@GGUID+54,181276,547,3,-54.1270,-147.0812,-1.4798,3.2240,0,0,0,0,86400,100,1); -- + 80
INSERT INTO gameobject VALUES (@GGUID+55,181276,547,3,-146.686996,-255.880005,-1.585130,-0.628317,0,0,0,0,86400,100,1); -- 3497062
INSERT INTO gameobject VALUES (@GGUID+56,181276,547,3,-70.9439,-485.8596,-1.5939,2.8824,0,0,0,0,86400,100,1); -- + 79
INSERT INTO gameobject VALUES (@GGUID+57,181276,547,3,-62.3669,-622.7919,-1.4774,1.4883,0,0,0,0,86400,100,1); -- + 80
INSERT INTO gameobject VALUES (@GGUID+58,181276,547,3,-170.839996,-779.573975,42.787102,-3.036840,0,0,0,0,86400,100,1); -- 3497061 
--
-- ============================
-- Felweed 181270 8 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+59,181270,547,3,-124.9409,-270.5637,-1.5922,0.4830,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+60,181270,547,3,-50.4967,-450.0803,-1.6262,4.5710,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+61,181270,547,3,-22.8062,-556.7200,-1.5924,3.0473,0,0,0,0,86400,100,1);
-- 3496968
INSERT INTO gameobject VALUES (@GGUID+62,181270,547,3,-100.3582,-708.7028,37.7168,1.2723,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+63,181270,547,3,-116.6233,-747.8840,36.4112,0.1060,0,0,0,0,86400,100,1);
-- 3496966
INSERT INTO gameobject VALUES (@GGUID+64,181270,547,3,-168.6782,-697.5800,37.8930,4.7320,0,0,0,0,86400,100,1);
--
-- ============================
-- Ancient Lichen 181278 16 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+65,181278,547,3,47.0660,-68.3126,-2.5934,6.1339,0,0,0,0,86400,100,1);
-- 3497109
-- 3497105
INSERT INTO gameobject VALUES (@GGUID+66,181278,547,3,-109.9700,-6.3713,-8.7302,5.5409,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+67,181278,547,3,-111.9343,-191.3912,-1.6001,0.0196,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+68,181278,547,3,-75.2523,-191.3103,-3.9491,2.7920,0,0,0,0,86400,100,1);
-- 3497107
INSERT INTO gameobject VALUES (@GGUID+69,181278,547,3,-27.1897,-257.8917,-1.2907,5.5998,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+70,181278,547,3,-86.3739,-287.2673,-1.4828,3.2751,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+71,181278,547,3,-115.4944,-316.0114,-1.5833,0.9817,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+72,181278,547,3,-68.8996,-312.7276,-1.4720,4.4649,0,0,0,0,86400,100,1);
-- 3497108
INSERT INTO gameobject VALUES (@GGUID+73,181278,547,3,-109.6604,-506.2465,-0.2922,1.2723,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+74,181278,547,3,-41.5624,-507.9121,-1.5941,4.3668,0,0,0,0,86400,100,1);
-- 3497106
INSERT INTO gameobject VALUES (@GGUID+75,181278,547,3,-118.4276,-587.4552,5.8534,5.8944,0,0,0,0,86400,100,1);
--
-- ============================
-- Ragveil 181275 8 Spawns 
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+76,181275,547,3,-4.9537,-7.236,-1.3325,4.2254,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+77,181275,547,3,-131.524994,-133.744003,-1.971610,1.884950,0,0,0,0,86400,100,1); -- 3497064 
INSERT INTO gameobject VALUES (@GGUID+78,181275,547,3,-54.1270,-147.0812,-1.4798,3.2240,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+79,181275,547,3,-70.9439,-485.8596,-1.5939,2.8824,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+80,181275,547,3,-62.3669,-622.7919,-1.4774,1.4883,0,0,0,0,86400,100,1);
-- 3497059
-- 3497061
-- 3497062
--
-- ============================
-- 181556 Adamantite Deposit 5 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181556) AND `map` IN (547);
--
-- ============================
-- 181569 Rich Adamantite Deposit 4 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181569) AND `map` IN (547);
--
-- ============================
-- 181557 Khorium Vein 2 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181557) AND `map` IN (547);
--
-- ================================================
-- The Steamvault 545
-- ================================================
--
-- ============================
-- Ragveil 2 Spawns 
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+81,181275,545,3,-312.1579,-195.9128,-7.7555,2.0106,0,0,0,0,86400,100,1); -- @GGUID+82  
-- 3489287 
--
-- ============================
--  2 Flamecap
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+82,181276,545,3,-312.1579,-195.9128,-7.7555,2.0106,0,0,0,0,86400,100,1); -- @GGUID+81
INSERT INTO gameobject VALUES (@GGUID+83,181276,545,3,58.566700,-204.123001,-22.613300,0.000000,0,0,0,0,86400,100,1); -- 3489287
--
-- ============================
-- Fellweed 2 Spawns
-- ============================
--
-- 3496965
-- 3486608
--
-- ============================
-- Ancient Lichen 9 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+84,181278,545,3,-239.5380,-182.3608,-5.6323,4.5277,0,0,0,0,86400,100,1);
UPDATE `gameobject` SET `position_x`='-349.6146', `position_y`='-136.0712', `position_z`='-7.7555', `orientation`='6.0004' WHERE `guid` IN ('3489268');
UPDATE `gameobject` SET `position_x`='-314.8144', `position_y`='-184.5514', `position_z`='-7.7555', `orientation`='2.0499' WHERE `guid` IN ('3497095');
-- 3486612
-- 3489227
-- 3489283
-- 3494259
-- 3497093
-- 3497094
--
-- ============================
-- Fel Iron Deposit 181555 6 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181555) AND `map` IN (545);
--
-- ============================
-- 181556 Adamantite Deposit 7 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181556) AND `map` IN (545);
--
-- ================================================
-- Auchenai Crypts 558
-- ================================================
--
-- ============================
-- 181278 Ancient Lichen 16 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+85,181278,558,3,74.5461,41.7255,4.2618,4.5051,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+86,181278,558,3,95.7300,-40.3090,4.2611,2.0468,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+87,181278,558,3,135.6600,40.8598,4.2609,4.0810,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+88,181278,558,3,141.5011,-21.5060,7.5809,3.7197,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+89,181278,558,3,223.5942,23.4183,4.0106,4.9724,0,0,0,0,86400,100,1);
-- 3497089
INSERT INTO gameobject VALUES (@GGUID+90,181278,558,3,240.1054,-163.5702,28.3727,5.4004,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+91,181278,558,3,-129.4146,-248.2453,26.3250,2.5887,0,0,0,0,86400,100,1);
-- 3497090
INSERT INTO gameobject VALUES (@GGUID+92,181278,558,3,-124.0806,-302.9804,26.8327,2.2588,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+93,181278,558,3,-59.2463,-356.2056,26.5865,4.5875,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+94,181278,558,3,-47.5485,-411.3084,26.5996,5.1334,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+95,181278,558,3,-18.6959,-365.1479,26.5834,3.2013,0,0,0,0,86400,100,1);
-- 3497091
INSERT INTO gameobject VALUES (@GGUID+96,181278,558,3,13.2697,-352.1596,30.7254,4.3244,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+97,181278,558,3,31.1778,-409.2182,26.5868,2.5102,0,0,0,0,86400,100,1);
--
-- ============================
-- 181556 Adamantite Deposit 16 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181556) AND `map` IN (558);
--
-- ============================
-- 181569 Rich Adamantite Deposit 6 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181569) AND `map` IN (558);
--
-- ============================
-- 181557 Khorium Vein 2 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181557) AND `map` IN (558);
--
-- ================================================
-- Shadow Labyrinth 555
-- ================================================
--
-- ============================
-- 181278 Ancient Lichen 22 Spawns
-- ============================
--
UPDATE `gameobject` SET `spawnmask`='3',`spawntimesecs`='86400' WHERE `id` IN (181278) AND `map` IN (555);
INSERT INTO gameobject VALUES (@GGUID+98,181278,555,3,-98.0383,5.9327,-1.1297,5.8573,0,0,0,0,86400,100,1);
-- 3492977
INSERT INTO gameobject VALUES (@GGUID+99,181278,555,3,-87.3983,-82.5818,-1.1310,0.1514,0,0,0,0,86400,100,1);
-- 3497117
INSERT INTO gameobject VALUES (@GGUID+100,181278,555,3,-143.1783,-72.7388,8.0642,3.5404,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+101,181278,555,3,-169.5667,-72.4537,8.0642,5.5667,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+102,181278,555,3,-152.3075,-63.5299,8.0730,4.4318,0,0,0,0,86400,100,1);
-- 3492978
INSERT INTO gameobject VALUES (@GGUID+103,181278,555,3,-290.4609,27.8269,8.0739,5.2525,0,0,0,0,86400,100,1);
-- 3497116
INSERT INTO gameobject VALUES (@GGUID+104,181278,555,3,-259.7827,-45.3562,8.0741,0.0571,0,0,0,0,86400,100,1);
-- 3492979
INSERT INTO gameobject VALUES (@GGUID+105,181278,555,3,-297.2861,-86.4956,8.0730,0.5519,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+106,181278,555,3,-447.9371,-121.5296,13.4209,1.0427,0,0,0,0,86400,100,1);
-- 3492980
-- 3497115
INSERT INTO gameobject VALUES (@GGUID+107,181278,555,3,-333.5915,-308.4202,25.3725,1.8870,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+108,181278,555,3,-293.7563,-308.8580,26.8150,1.5572,0,0,0,0,86400,100,1);
-- 3492981
INSERT INTO gameobject VALUES (@GGUID+109,181278,555,3,-169.2458,-355.3884,17.0828,1.0585,0,0,0,0,86400,100,1);
UPDATE `gameobject` SET `position_x`='-140.2255', `position_y`='-407.7074', `position_z`='17.0782', `orientation`='1.4538' WHERE `guid` IN ('3497114');
-- 3492982
--
-- ============================
-- 181556 Adamantite Deposit 10 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181556) AND `map` IN (555);
--
-- ============================
-- 181569 Rich Adamantite Deposit 7 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181569) AND `map` IN (555);
--
-- ============================
-- 181557 Khorium Vein 3 Spawns
-- ============================
--
-- SELECT * FROM `gameobject` WHERE `id` IN (181557) AND `map` IN (555);
--
-- ================================================
-- The Botanica 553
-- ================================================
--
-- ============================
-- Dreaming Glory 3 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+110,181271,553,3,-0.6961,165.1311,-3.9249,4.6556,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+111,181271,553,3,154.5396,407.5450,-3.3976,4.1294,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+112,181271,553,3,-22.2110,502.6916,-5.0288,0.2927,0,0,0,0,86400,100,1);
--
-- ============================
-- Felweed 7 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+113,181270,553,3,173.8415,389.0357,-3.9249,4.5535,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+114,181270,553,3,-155.1293,523.3920,-15.9849,5.9986,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+115,181270,553,3,15.1402,420.8761,-27.1588,1.3844,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+116,181270,553,3,30.0437,356.2431,-26.0345,2.2421,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+117,181270,553,3,35.2637,352.5915,-25.9644,4.4160,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+118,181270,553,3,70.1794,432.9414,-24.8402,0.3532,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+119,181270,553,3,103.0154,368.6782,-27.2969,5.3248,0,0,0,0,86400,100,1);
--
-- ============================
-- Netherbloom 3 Spawns
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+120,181279,553,3,-0.2972,256.9944,-4.0000,4.6556,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+121,181279,553,3,170.1984,503.4997,0.0152,4.2707,0,0,0,0,86400,100,1);
INSERT INTO gameobject VALUES (@GGUID+122,181279,553,3,115.7411,450.9008,-3.7880,0.6893,0,0,0,0,86400,100,1);
--
-- ============================
-- Terocone 1 Spawn
-- ============================
--
INSERT INTO gameobject VALUES (@GGUID+123,181277,553,3,-170.1716,496.8661,-15.0520,3.6738,0,0,0,0,86400,100,1);
--
-- ================================================
-- Gameobjects Pools
-- ================================================
--
SET @POOL := 20000;
DELETE FROM `pool_template` WHERE `entry` BETWEEN @POOL AND @POOL+18;
INSERT INTO `pool_template` VALUES
--
-- ============================
-- The Underbog
-- ============================
(@POOL+0,1,'The Underbog - Herb - Pool 1'),
(@POOL+1,1,'The Underbog - Herb - Pool 2'),
(@POOL+2,1,'The Underbog - Herb - Pool 3'),
(@POOL+3,1,'The Underbog - Herb - Pool 4'),
(@POOL+4,1,'The Underbog - Herb - Pool 5'),
(@POOL+5,1,'The Underbog - Herb - Pool 6'),
(@POOL+6,1,'The Underbog - Herb - Pool 7'),
(@POOL+7,1,'The Underbog - Herb - Pool 8'),
(@POOL+8,1,'The Underbog - Herb - Pool 9'),
--
-- ============================
-- The Slave Pens
-- ============================
(@POOL+9,1,'The Slave Pens - Herb - Pool 1'),
(@POOL+10,1,'The Slave Pens - Herb - Pool 2'),
(@POOL+11,1,'The Slave Pens - Herb - Pool 3'),
(@POOL+12,1,'The Slave Pens - Herb - Pool 4'),
(@POOL+13,1,'The Slave Pens - Herb - Pool 5'),
(@POOL+14,1,'The Slave Pens - Herb - Pool 6'),
(@POOL+15,1,'The Slave Pens - Herb - Pool 7'),
(@POOL+16,1,'The Slave Pens - Herb - Pool 8'),
--
-- ============================
-- The Steamvault
-- ============================
(@POOL+17,1,'The Steamvault - Herb - Pool 1'),
(@POOL+18,1,'The Steamvault - Herb - Pool 2');
--
-- ================================================
-- Master Spawn Pool Linking
-- ================================================
SET @POOL := 20000;
DELETE FROM pool_pool WHERE pool_id BETWEEN @POOL AND @POOL+18;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES
--
-- ============================
-- The Underbog
-- ============================
(@POOL+0,'2995','0','The Underbog - Herb - Pool 1'),
(@POOL+1,'2995','0','The Underbog - Herb - Pool 2'),
(@POOL+2,'2995','0','The Underbog - Herb - Pool 3'),
(@POOL+3,'2995','0','The Underbog - Herb - Pool 4'),
(@POOL+4,'2995','0','The Underbog - Herb - Pool 5'),
(@POOL+5,'2995','0','The Underbog - Herb - Pool 6'),
(@POOL+6,'2995','0','The Underbog - Herb - Pool 7'),
(@POOL+7,'2995','0','The Underbog - Herb - Pool 8'),
(@POOL+8,'2995','0','The Underbog - Herb - Pool 9'),
--
-- ============================
-- The Slave Pens
-- ============================
(@POOL+9,'2998','0','The Slave Pens - Herb - Pool 1'),
(@POOL+10,'2998','0','The Slave Pens - Herb - Pool 2'),
(@POOL+11,'2998','0','The Slave Pens - Herb - Pool 3'),
(@POOL+12,'2998','0','The Slave Pens - Herb - Pool 4'),
(@POOL+13,'2998','0','The Slave Pens - Herb - Pool 5'),
(@POOL+14,'2998','0','The Slave Pens - Herb - Pool 6'),
(@POOL+15,'2998','0','The Slave Pens - Herb - Pool 7'),
(@POOL+16,'2998','0','The Slave Pens - Herb - Pool 8'),
--
-- ============================
-- The Steamvault
-- ============================
(@POOL+17,'2997','0','The Steamvault - Herb - Pool 1'),
(@POOL+18,'2997','0','The Steamvault - Herb - Pool 2');
--
-- ================================================
-- Fill Individual Gameobjects Spawn Pools with GUIDs
-- ================================================
--
SET @POOL := 20000;
DELETE FROM pool_gameobject WHERE pool_entry BETWEEN @POOL AND @POOL+18;
--
-- ============================
-- The Underbog
-- ============================
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+31,@POOL,'0','The Underbog - Herb - Pool 1');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+40,@POOL,'0','The Underbog - Herb - Pool 1');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+32,@POOL+1,'0','The Underbog - Herb - Pool 2');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+41,@POOL+1,'0','The Underbog - Herb - Pool 2');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+33,@POOL+2,'0','The Underbog - Herb - Pool 3');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+42,@POOL+2,'0','The Underbog - Herb - Pool 3');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497065,@POOL+3,'0','The Underbog - Herb - Pool 4');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497063,@POOL+3,'0','The Underbog - Herb - Pool 4');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+34,@POOL+4,'0','The Underbog - Herb - Pool 5');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+37,@POOL+4,'0','The Underbog - Herb - Pool 5');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+35,@POOL+5,'0','The Underbog - Herb - Pool 6');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+38,@POOL+5,'0','The Underbog - Herb - Pool 6');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+36,@POOL+6,'0','The Underbog - Herb - Pool 7');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497060,@POOL+6,'0','The Underbog - Herb - Pool 7');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+39,@POOL+7,'0','The Underbog - Herb - Pool 8');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (14113585,@POOL+7,'0','The Underbog - Herb - Pool 8');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+47,@POOL+8,'0','The Underbog - Herb - Pool 9');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (14113593,@POOL+8,'0','The Underbog - Herb - Pool 9');
--
-- ============================
-- The Slave Pens
-- ============================
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+52,@POOL+9,'0','The Slave Pens - Herb - Pool 1');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+78,@POOL+9,'0','The Slave Pens - Herb - Pool 1');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+53,@POOL+10,'0','The Slave Pens - Herb - Pool 2');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497059,@POOL+10,'0','The Slave Pens - Herb - Pool 2');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+54,@POOL+11,'0','The Slave Pens - Herb - Pool 3');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+80,@POOL+11,'0','The Slave Pens - Herb - Pool 3');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+55,@POOL+12,'0','The Slave Pens - Herb - Pool 4');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497062,@POOL+12,'0','The Slave Pens - Herb - Pool 4');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+56,@POOL+13,'0','The Slave Pens - Herb - Pool 5');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+79,@POOL+13,'0','The Slave Pens - Herb - Pool 5');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+57,@POOL+14,'0','The Slave Pens - Herb - Pool 6');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+80,@POOL+14,'0','The Slave Pens - Herb - Pool 6');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+58,@POOL+15,'0','The Slave Pens - Herb - Pool 7');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497061,@POOL+15,'0','The Slave Pens - Herb - Pool 7');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+77,@POOL+16,'0','The Slave Pens - Herb - Pool 8');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497064,@POOL+16,'0','The Slave Pens - Herb - Pool 8');
--
-- ============================
-- The Steamvault
-- ============================
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+81,@POOL+17,'0','The Steamvault - Herb - Pool 1');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+82,@POOL+17,'0','The Steamvault - Herb - Pool 1');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+83,@POOL+18,'0','The Steamvault - Herb - Pool 2');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3489287,@POOL+18,'0','The Steamvault - Herb - Pool 2');
--
-- ================================================
-- Link single spawns directly to the motherpool
-- ================================================
--
-- ============================
-- Mana-Tombs
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2999');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+1,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+2,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+3,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+4,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+5,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+6,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+7,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+8,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+9,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+10,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+11,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+12,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+13,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496015,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496016,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496017,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496018,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497103,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497920,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497921,'2999','0','Master Herb Pool - Mana-Tombs');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497922,'2999','0','Master Herb Pool - Mana-Tombs');
--
-- ============================
-- The Slave Pens
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2998');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+59,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+60,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+61,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+62,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+63,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+64,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+65,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+66,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+67,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+68,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+69,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+70,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+71,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+72,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+73,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+74,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+75,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+76,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+78,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+79,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+80,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496968,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496966,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497109,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497105,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497107,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497108,'2998','0','Master Herb Pool - The Slave Pens');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497106,'2998','0','Master Herb Pool - The Slave Pens');
--
-- ============================
-- The Steamvault
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2997');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496965,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3486608,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+84,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3489268,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497095,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3486612,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3489227,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3489283,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3494259,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497093,'2997','0','Master Herb Pool - The Steamvault');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497094,'2997','0','Master Herb Pool - The Steamvault');
--
-- ============================
-- Sethekk Halls 18 Only Ancient Lichen
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2996');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+14,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+15,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+16,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+17,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+18,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+19,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+20,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+21,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+22,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+23,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+24,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+25,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497098,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497100,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497096,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497092,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497099,'2996','0','Master Herb Pool - Sethekk Halls');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497097,'2996','0','Master Herb Pool - Sethekk Halls');
--
-- ============================
-- The Underbog
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2995');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+26,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+27,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+28,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+29,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+30,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+43,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+44,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+45,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+46,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+48,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+49,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+50,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+51,'2995','0','Master Herb Pool - The Underbog'); 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496969,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496967,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3496970,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497101,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497113,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497110,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497104,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497111,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497102,'2995','0','Master Herb Pool - The Underbog');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497112,'2995','0','Master Herb Pool - The Underbog');
--
-- ============================
-- Auchenai Crypts 558 16 (6 First Floor)(10 Second Floor) Only Ancient Lichen
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2994');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497089,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497090,'2994','0','Master Herb Pool - Auchenai Crypts'); 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497091,'2994','0','Master Herb Pool - Auchenai Crypts'); 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+85,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+86,'2994','0','Master Herb Pool - Auchenai Crypts'); 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+87,'2994','0','Master Herb Pool - Auchenai Crypts'); 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+88,'2994','0','Master Herb Pool - Auchenai Crypts'); 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+89,'2994','0','Master Herb Pool - Auchenai Crypts'); 
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+90,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+91,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+92,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+93,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+94,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+95,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+96,'2994','0','Master Herb Pool - Auchenai Crypts');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+97,'2994','0','Master Herb Pool - Auchenai Crypts');
--
-- ============================
-- Shadow Labyrinth 555 22 Only Ancient Lichen
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2993');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+98,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+99,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+100,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+101,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+102,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+103,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+104,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+105,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+106,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+107,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+108,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+109,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3492977,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497117,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3492978,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497116,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3492979,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3492980,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497115,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3492981,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3497114,'2993','0','Master Herb Pool - Shadow Labyrinth');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (3492982,'2993','0','Master Herb Pool - Shadow Labyrinth');
--
--
-- ============================
-- The Botanica
-- ============================
--
DELETE FROM pool_gameobject WHERE pool_entry IN ('2992');
--
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+110,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+111,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+112,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+113,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+114,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+115,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+116,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+117,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+118,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+119,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+120,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+121,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+122,'2992','0','Master Herb Pool - The Botanica');
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@GGUID+123,'2992','0','Master Herb Pool - The Botanica');
