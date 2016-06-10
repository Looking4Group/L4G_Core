-- reactivate Ancient Lichen in both mods
UPDATE `gameobject` SET `spawnmask`='3' WHERE `id` IN ('181278');
--
UPDATE `creature_template` SET `maxlevel`='67',`armor`='4900',`modelid_A2`='18001',`modelid_H2`='18001',`mindmg`='750',`maxdmg`='1250',`baseattacktime`='1800' WHERE `entry` IN ('17819');
UPDATE `creature_template` SET `armor`='7100',`modelid_A2`='18001',`modelid_H2`='18001',`speed`='1.48',`mindmg`='2555',`maxdmg`='3239',`lootid`='17819',`pickpocketloot`='17819' WHERE `entry` IN ('20527');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17819');
INSERT INTO `creature_ai_scripts` VALUES
('1781901','17819','1','0','5','7','30000','180000','180000','360000','1','-1272','-1273','-1274','0','0','0','0','0','0','0','0','Durnholde Sentry - Random Say OOC'),
('1781902','17819','9','0','100','7','0','5','10100','15000','11','9080','1','1','0','0','0','0','0','0','0','0','Durnholde Sentry - Cast Hamstring'),
('1781903','17819','0','0','100','7','4000','9000','8000','11000','11','15496','1','1','0','0','0','0','0','0','0','0','Durnholde Sentry - Cast Cleave'),
('1781904','17819','0','0','100','7','6200','9700','9000','13000','11','14895','1','1','0','0','0','0','0','0','0','0','Durnholde Sentry - Cast Overpower'),
('1781905','17819','2','0','100','6','15','0','0','0','25','0','0','0','1','-47','0','0','0','0','0','0','Durnholde Sentry - Flee at 15% HP'),
('1781906','17819','6','0','10','38','0','0','0','0','1','-1279','-1280','-1281','0','0','0','0','0','0','0','0','Durnholde Sentry - Random Say on Death'),
('1781907','17819','4','0','10','7','0','0','0','0','1','-1278','0','0','0','0','0','0','0','0','0','0','Durnholde Sentry - Random Say on Aggro');
--
-- Durnholde Reinforcement 22398 22399
UPDATE `creature_template` SET `minlevel`='68',`maxlevel`='68',`armor`='5200',`minhealth`='24926',`maxhealth`='25338',`modelid_A2`='18001',`modelid_H2`='18001',`speed`='1.48',`unit_flags`='0',`lootid`='17819',`pickpocketloot`='17819',`mindmg`='1000',`maxdmg`='1500',`baseattacktime`='1800',`mechanic_immune_mask`='0',`AIName`='EventAI' WHERE `entry` IN ('22398');
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`armor`='7400',`minhealth`='49852',`maxhealth`='55676',`modelid_A2`='18001',`modelid_H2`='18001',`speed`='1.48',`mindmg`='3140',`maxdmg`='3689',`lootid`='17819',`pickpocketloot`='17819',`mechanic_immune_mask`='787421183' WHERE `entry` IN ('22399');
--
-- Sunwindpost Corpses
UPDATE `creature` SET `curhealth`='0',`curmana`='0',`DeathState`='0' WHERE `id` IN ('18240'); -- deathstate cant be 1 because of quest
--
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1831506','1831507');
INSERT INTO `creature_ai_scripts` VALUES
('1831506','18315','4','0','15','7','0','0','0','0','1','-1237','-1238','-1239','0','0','0','0','0','0','0','0','Ethereal Theurgist - Random Say on Aggro'),
('1831507','18315','4','0','100','7','0','0','0','0','11','29651','0','0','0','0','0','0','0','0','0','0','Ethereal Theurgist - Cast Dual Wield on Aggro');
--
DELETE FROM `creature` WHERE `guid` IN (59467);
INSERT INTO `creature` VALUES
(59467,17059,530,1,0,0,-246.8854,3090.5285,-65.6097,6.0039,300,0,0,2200,0,0,0);
--
-- The Big Bad Wolf - Der große böse Wolf decrease speed
UPDATE `creature_template` SET `mindmg`='7312',`maxdmg`='8685',`baseattacktime`='1500',`speed`='1.48',`flags_extra`='65537' WHERE `entry` IN ('17521'); -- ba 1449
-- Issue #2282
UPDATE `creature_template` SET `modelid_A2`='16398',`modelid_H2`='16398',`speed`='1.38',`mechanic_immune_mask`='8389137',`mindmg`='1000',`maxdmg`='1474' WHERE `entry` IN ('15551'); -- 4,018 - 4,769 723 
UPDATE `creature_template` SET `speed`='1.38',`mechanic_immune_mask`='8389137',`mindmg`='2750',`maxdmg`='3440' WHERE `entry` IN ('15547'); -- 8500 - 10095 1527 3122
UPDATE `creature_template` SET `armor`='7100',`speed`='1.38',`mechanic_immune_mask`='8389137',`mindmg`='1350',`maxdmg`='1650' WHERE `entry` IN ('15548'); -- 20 1.71 2,700 - 3,300 450 1050
UPDATE `creature_template` SET `mindmg`='1672',`maxdmg`='1985' WHERE `entry` IN ('16389 '); -- 5,015 - 5,956 901 1842
--
-- MASTER Herbs Hellfire Peninsula zone 3483
UPDATE `pool_template` SET `max_limit`='80' WHERE `entry` IN ('972'); -- 60
-- MASTER Herbs Zangarmarsh zone 3521
UPDATE `pool_template` SET `max_limit`='105' WHERE `entry` IN ('975'); -- 95
-- MASTER Herbs Terokkar Forest zone 3519
UPDATE `pool_template` SET `max_limit`='85' WHERE `entry` IN ('977'); -- 65 
-- MASTER Herbs Nagrand zone 3518
UPDATE `pool_template` SET `max_limit`='60' WHERE `entry` IN ('973'); -- 40 
-- MASTER Herbs Blade's Edge Mountains zone 3522
UPDATE `pool_template` SET `max_limit`='55' WHERE `entry` IN ('978'); -- 35
-- MASTER Herbs Netherstorm zone 3523
-- UPDATE `pool_template` SET `max_limit`='60' WHERE `entry` IN ('974'); -- 40
-- MASTER Herbs Shadowmoon Valley zone 3520
-- UPDATE `pool_template` SET `max_limit`='65' WHERE `entry` IN ('976'); -- 45
--
UPDATE `creature_template` SET `mindmg`='2400',`maxdmg`='2578' WHERE `entry` IN ('18603'); -- 1332 1779 5998 - 6445
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/1445/the-botanica
--
--
--
--
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-9849','-9848','-9847','-9846','-9845','-9844','-9843','-9842','-9841','-9840','-9839','-9838','-9837','-9836','-9835','-9834','-9833','-9832','-9831','-9830');
INSERT INTO `creature_ai_texts` VALUES
(-9849,'Protect the Botanica at all costs!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,1,0,0,'-144 17976'),
(-9848,'%s calls for reinforcements!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'-343 17976 Summon Adds'),
(-9847,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9846,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9845,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9844,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9843,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9842,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9841,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9840,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9839,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9838,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9837,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9836,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9835,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9834,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9833,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9832,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9831,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter'),
(-9830,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'BotanicaPlatzhalter');
--
--
--
--
--
--
DELETE FROM `creature_ai_texts` WHERE `entry` IN (-1292,-1293,-1294,-1295,-1296,-1297,-1298,-1299,-1300,-1301,-1302,-1303,-1304,-1305,-1306,-1307,-1308,-1309,-1310,-1311,-1312,-1313,-1314,-1315,-1316,-1317,-1318,-1319,-1320,-1321,-1322,-1323,-1324,-1325,-1326,-1327,-1328,-1329,-1330,-1331,-1332,-1333,-1334,-1335,-1336,-1337,-1338,-1339,-1340,-1341,-1342,-1343,-1344,-1345,-1346,-1347,-1348,-1349,-1350,-1351,-1352,-1353,-1354,-1355,-1356,-1357,-1358,-1359,-1360,-1361,-1362,-1363,-1364,-1365,-1366,-1367,-1368,-1369,-1370,-1371);
INSERT INTO `creature_ai_texts` (`entry`,`content_default`,`sound`,`type`,`language`,`comment`,`emote`) VALUES
('-1292','Hm, hungry.','0','0','0','18598','0'),
('-1293','So-ngh-thirsty.','0','0','0','18598','0'),
('-1294','Intruders have breached the hatchery! Sound the alarm! Protect the eggs at all costs!','8272','1','0','12557','0'),
('-1295','Foolish mortal, you serve me now!','8273','1','0','12557','0'),
('-1296','The power of the light is truly great and merciful.','0','0','0','14484, 14485','0'),
('-1297','We shall be reunited once more, my love...','0','0','0','14484, 14485','0'),
('-1298','At last, it ends...','0','0','0','14484, 14485','0'),
('-1299','Stranger, find the fallen Prince Menethil and end his reign of terror.','0','0','0','14484, 14485','0'),
('-1300','Should I live through this, I shall make it my life\'s sole ambition to destroy Arthas...','0','0','0','14484, 14485','0'),
('-1301','I won\'t make it... go... go on without me...','0','0','0','14484, 14485','0'),
('-1302','Death take me! I cannot go on! I have nothing left...','0','0','0','14484, 14485','0'),
('-1303',NULL,'0','0','0','LEER','0'),
('-1304','Kill $n!','0','1','0','17994 Call of the Falcon','5'),
-- Please re-use -1303 and -1304
('-1305','The light condemns all who harbor evil.  Now you will die!','0','0','0','Scarlet Monastery','0'),
('-1306','You carry the taint of the scourge.  Prepare to enter the twisting nether.','0','0','0','Scarlet Monastery','0'),
('-1307','There is no escape for you.  The Crusade shall destroy all who carry the scourge\'s taint.','0','0','0','Scarlet Monastery','0'),
('-1308','The Scarlet Crusade shall smite the wicked and drive evil from these lands!','0','0','0','Scarlet Monastery','0'),
('-1309','Do as I say, Fly!','0','0','0','17994','0'),
('-1310','Welcome to flavor country!','0','0','0','11058','0'),
('-1311','Kitten for sale, looking for a good home.','0','0','0','8666','0'),
('-1312','I can\'t believe dad won\'t let me keep your sister.','0','0','0','8666','0'),
('-1313','Can anyone give my adorable, extra little kitty a home?','0','0','0','8666','0'),
('-1314','What does allergic mean anyway? And what does it have to do with either of my kitties?','0','0','0','8666','0'),
('-1315','Will someone please give my little kitten a good home?','0','0','0','8666','0'),
('-1316','Don\'t worry, I\'ll find a good home for ya.','0','0','0','8666','0'),
('-1317','Silithid Creeper lays an egg!','0','2','0','3250','0'),
('-1318','Silithid Creeper Egg begins to crack and open...','0','2','0','5781','0'),
('-1319','Silithid Creeper Egg splits open!','0','2','0','5781','0'),
('-1320','Your pathetic attempt to escape will be short lived, Gorefiend. Let the boy go and submit! Even with your armour and weapons, you cannot defeat the ancients!','0','0','0','21877','0'),
('-1321','What ... have you done...','0','1','0','21877','0'),
('-1322','Pray that the chilling embrace of Teron Gorefiend does not reach out for you...','0','4','0','21788 21795','0'),
('-1323','It is you who have invaded our home. Gorefiend will avenge us!','0','4','0','21788 21795','0'),
('-1324','We will never dissipate, mortal... Our fate is tied to Gorefiend...','0','4','0','21788 21795','0'),
('-1325','We are bound here... eternally. It is the will of Gorefiend.','0','4','0','21788 21795','0'),
('-1326','Gorefiend will have your head, interloper!','0','4','0','21788 21795','0'),
('-1327','%s returns the rude gesture to $n','0','2','0','Jenn/Elly Langston rude','0'),
('-1328','Well hello, $n, what can I get you today?','0','0','0','Jenn/Elly Langston random text','0'),
('-1329','Been a tough day? A nice ale should loosen those worries right up.','0','0','0','Jenn/Elly Langston random text','0'),
('-1330','Do you think I need more pieces of flair?','0','0','0','Jenn Langston random text','0'),
('-1331','What do you fancy, $G sir:miss;?','0','0','0','Jenn Langston random text','0'),
('-1332','Hi, what would you like?','0','0','0','Jenn Langston random text','0'),
('-1333','Look what the cat dragged in. What can I get you, $n?','0','0','0','Jenn Langston random text','0'),
('-1334','Remain strong. Kael\'thas will - error - Lor\'themar will lead you to power and glory!','0','0','0','18103','0'),
('-1335','Maintain order within these walls.','0','0','0','18103','0'),
('-1336','Happiness is mandatory, citizen.','0','0','0','18103','0'),
('-1337','Do not be disheartened. Silvermoon will remain strong through this course of events.','0','0','0','18103','0'),
('-1338','The magister\'s going to kill me...','0','0','0','18230','0'),
('-1339','Argh. They told me those crystals would work properly!','0','0','0','18230','0'),
('-1340','When I catch you, I\'m going to disenchant your components, so help me...','0','0','0','18230','0'),
('-1341','You stay out of the regent lord\'s way! I mean it!','0','0','0','18230','0'),
('-1342','No, no, no! Come back here!','0','0','0','18230','0'),
('-1343',NULL,'0','0','0','LEER','0'),
('-1344',NULL,'0','0','0','LEER','0'),
('-1345',NULL,'0','0','0','LEER','0'),
('-1346',NULL,'0','0','0','LEER','0'),
('-1347',NULL,'0','0','0','LEER','0'),
('-1348',NULL,'0','0','0','LEER','0'),
('-1349','Burn Burn Burn','0','0','12','18109','0'),
('-1350','%s appears very grateful to be free of the koi-koi spirit\'s influence.','0','2','0','21326','34'),
('-1351','AYYAYAAYAA!','0','0','0','22483','0'),
('-1352','AWOOOOGAAAA!','0','0','0','22483','0'),
('-1353','AAAAEEEEEEIIIIIIII!!!!!','0','0','0','22483','0'),
('-1354',NULL,'0','0','0','LEER','0'),
('-1355',NULL,'0','0','0','LEER','0'),
('-1356',NULL,'0','0','0','LEER','0'),
('-1357',NULL,'0','0','0','LEER','0'),
('-1358',NULL,'0','0','0','LEER','0'),
('-1359',NULL,'0','0','0','LEER','0'),
('-1360',NULL,'0','0','0','LEER','0'),
('-1361',NULL,'0','0','0','LEER','0'),
('-1362',NULL,'0','0','0','LEER','0'),
('-1363',NULL,'0','0','0','LEER','0'),
('-1364',NULL,'0','0','0','LEER','0'),
('-1365','I\'ll crush you!','0','0','0','9196','0'),
('-1366','Me smash! You die!','0','0','0','9196','0'),
('-1367','Raaar!!! Me smash $R!','0','0','0','9196','1'),
('-1368','I cannot be destroyed! By the will of Ragnaros, I shall be reborn!','0','0','0','9017','0'),
('-1369','What are you doing? Intruders!!','0','1','0','9476','0'),
('-1370','Intruders in the Manufactory? My constructs will destroy you!','0','0','0','8983','0'),
('-1371','%s gets really dizzy!','0','2','0','9554','0');
--
UPDATE creature_ai_texts SET content_loc3='Tretet vor. Ich sorge dafür, dass Ihr ordendlich empfangen werdet!' WHERE entry=-34;
UPDATE creature_ai_texts SET content_loc3='Ich bin nicht nur ein einfacher Untergebener.' WHERE entry=-37;
UPDATE creature_ai_texts SET content_loc3='Band\'or shorel\'aran!' WHERE entry=-38;
UPDATE creature_ai_texts SET content_loc3='Wachen! Vernichtet diese Eindringlinge!' WHERE entry=-39;
UPDATE creature_ai_texts SET content_loc3='Ist dies das Ende?' WHERE entry=-40;
UPDATE creature_ai_texts SET content_loc3='Was wird werden...' WHERE entry=-41;
UPDATE creature_ai_texts SET content_loc3='Es wird Zeit, sich uns anzuschließen, $C.' WHERE entry=-42;
--
DELETE FROM db_script_string WHERE entry IN (2000005550,2000005551,2000005552,2000005553,2000005554,2000005555,2000005556,2000005557,2000005558,2000005559); -- 8298601 8303501 8304901 8304902 8298701 8298702 8298703 8298704
INSERT INTO `db_script_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES 
('2000005550','We must not fail our leader!  Kael\'thas will redeem us!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- yell
('2000005551','Hmm...Frost, Fire, and Arcane defenses respond faster than Batch 7, but Nature defenses remain passive.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- say
('2000005552','Hmm...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- say
('2000005553','Yes. That did the trick.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- say
('2000005554','...mumble...Petals of Fire...mumble...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- say
('2000005555','...mumble mumble...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- say
('2000005556','...with the right mixture, perhaps...',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- say
('2000005557','...thorny vines...mumble...ouch!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- say
('2000005558','Get out of here, there are too many of them! Escape while you can!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL), -- yell
('2000005559','Help! Someone help us!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL); -- yell
--
-- waypoint script
DELETE FROM `waypoint_scripts` WHERE `id` IN ('8315101','8299401','8298601','8303501','8303502','8303503','8303504','8303505','8304901','8304902','8304903','8305201','8298701','8298702','8298703','8298704','1069','1011','8307101','8307102','8307103','8307104','8307105','8307106','8307107','8307108','8307109','8307110','8305901','8305902','8305903','8305904');
INSERT INTO `waypoint_scripts` VALUES
(8315101,0,1,66,1,0,0,0,0,0,8315101),
--
(8299401,0,1,378,1,0,0,0,0,0,8299401),
--
(8298601,0,0,0,0,2000005550,0,0,0,0,8298601), -- yell geht nicht mal say machen
--
(8303501,0,0,0,0,2000005551,0,0,0,0,8303501), -- say
(8303502,0,15,34167,1,0,0,0,0,0,8303502), -- frost
(8303503,0,15,34169,1,0,0,0,0,0,8303503), -- fire
(8303504,0,15,34170,1,0,0,0,0,0,8303504), -- arcane
(8303505,0,15,37788,1,0,0,0,0,0,8303505), -- shadow need shadow dummy spell
--
(8304901,0,0,0,0,2000005552,0,0,0,0,8304901),
(8304902,0,0,0,0,2000005553,0,0,0,0,8304902),
(8304903,0,15,34254,2,19557,0,0,0,0,8304903),
--
(8305201,0,1,1,1,0,0,0,0,0,8305201),
--
(8298701,0,0,0,0,2000005554,0,0,0,0,8298701),
(8298702,0,0,0,0,2000005555,0,0,0,0,8298702),
(8298703,0,0,0,0,2000005556,0,0,0,0,8298703),
(8298704,0,0,0,0,2000005557,0,0,0,0,8298704),
--
(8305901,0,0,0,0,2000005558,0,0,0,0,8305901),
(8305902,0,0,0,0,2000005559,0,0,0,0,8305902),
(8305903,0,15,31261,1,0,0,0,0,0,8305903), -- Feign Death
(8305904,0,22,1,0,0,0,0,0,0,8305904), -- Despawn
--
(1069,0,1,69,1,0,0,0,0,0,1069),
(1011,0,1,11,1,0,0,0,0,0,1011),
--
-- channelers
(8307101,0,15,34221,2,19555,0,0,0,0,8307101), -- Sunseeker Channeler (Botanica) - Crystal Channel TK Atrium Channel Target');
(8307102,0,15,34200,2,19511,0,0,0,0,8307102), -- Sunseeker Channeler (Botanica) - Crystal Channel Nethervine Inciter');
(8307103,0,15,34187,2,19511,0,0,0,0,8307103), -- Sunseeker Channeler (Botanica) - Nethervine Inciter Casts Sunseeker Blessing'); 60sec
(8307104,0,15,34187,1,0,0,0,0,0,8307104), -- Sunseeker Channeler (Botanica) - NPC Casts Sunseeker Blessing on Self'); 60sec
(8307105,0,15,34173,2,19511,1,0,0,0,8307105), -- Sunseeker Channeler (Botanica) - Nethervine Inciter Casts Sunseeker Blessing'); 30sec
(8307106,0,15,34222,1,0,0,0,0,0,8307106), -- Sunseeker Channeler (Botanica) - Cast Sunseeker Blessing AOE');
(8307107,0,15,34200,2,19512,0,0,0,0,8307107); -- Sunseeker Channeler (Botanica) - Crystal Channel 19512');

-- (8307107,0,15,34173,0,0,0,0,0,0,8307107), -- 34156 brauchts vlt garnicht? 60 / 30sec
-- (8307108,0,15,34173,0,0,0,0,0,0,8307108), -- 34156 brauchts vlt garnicht? 60 / 30sec

-- TARGET SCRIPTS FOR CHANNEL SPELL
-- DELETE FROM dbscripts_on_creature_movement WHERE id IN (8307101,8307102);
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307101,0,15,34221,0,19555,15,1,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Crystal Channel TK Atrium Channel Target');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307102,0,15,34200,0,19511,83073,17,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Crystal Channel Nethervine Inciter');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307102,7,15,34187,0,19511,83073,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Inciter Casts Sunseeker Blessing');
-- SPELL SCRIPT TARGET ENTRIES
-- INSERT IGNORE INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34221','1','19505');
-- INSERT IGNORE INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34221','1','19555');
-- INSERT IGNORE INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34200','1','19511');
DELETE FROM `spell_script_target` WHERE targetentry IN (19505,19555,19511,19512);
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34221','1','19505');
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34221','1','19555');
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34156','1','19555');
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34200','1','19511');
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34200','1','19512');
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34222','1','19511');
INSERT INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values('34222','1','19512');



-- TARGET SCRIPTS FOR CHANNEL SPELL (RIGHT NPC)
-- DELETE FROM dbscripts_on_creature_movement WHERE id IN (8298801,8298802);
-- INSERT INTO dbscripts_on_creature_movement VALUES (8298801,0,15,34221,0,19555,15,1,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Crystal Channel TK Atrium Channel Target');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8298802,2,15,34222,0,0,0,0,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Cast Sunseeker Blessing AOE');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8298802,3,15,34173,0,19512,83085,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Reaper Casts Sunseeker Blessing');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8298802,3,15,34173,0,19512,83084,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Reaper Casts Sunseeker Blessing');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8298802,3,15,34173,0,19511,83082,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Inciter Casts Sunseeker Blessing');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8298802,3,15,34173,0,19511,83083,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Inciter Casts Sunseeker Blessing');

-- TARGET SCRIPTS FOR CHANNEL SPELL (LEFT NPC)
-- DELETE FROM dbscripts_on_creature_movement WHERE id IN (8307701,8307702);
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307701,0,15,34221,0,19555,15,1,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Crystal Channel TK Atrium Channel Target');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307702,2,15,34222,0,0,0,0,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Cast Sunseeker Blessing AOE');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307702,3,15,34173,0,19512,83081,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Reaper Casts Sunseeker Blessing');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307702,3,15,34173,0,19512,83079,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Reaper Casts Sunseeker Blessing');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307702,3,15,34173,0,19511,83078,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Inciter Casts Sunseeker Blessing');
-- INSERT INTO dbscripts_on_creature_movement VALUES (8307702,3,15,34173,0,19511,83080,23,0,0,0,0,0,0,0,0,'Sunseeker Channeler (Botanica) - Nethervine Inciter Casts Sunseeker Blessing');


--
--
--
-- entry 16346 ai anschauen
--
-- Spawns
--
-- freie guids ab 82900: 82902 82912 82929 82936 82951 82954 82959 82963 82968 82969 82970 82971 82972 82973 für SSC 
--
-- ------------------------------
-- Add Missing Bloodwarder Mender
-- ------------------------------
DELETE FROM creature WHERE guid IN (83137);
DELETE FROM creature_addon WHERE guid IN (83137);
INSERT INTO creature VALUES
(83137,19633,553,3,0,0,6.15941,166.406,-5.54122,1.51584,7200,3,0,14199,21093,0,1);
--
-- ----------------------------------
-- NPC In Front Of Commander Sarannis
-- ----------------------------------
-- Fix Spawns With Sniff Data (Current Ones Badly Placed Better To Fix All Of The With Sniff Data)
DELETE FROM creature WHERE guid IN (83011,83012,83013,83014,83015,83119,83120,83138,83139);
DELETE FROM creature_addon WHERE guid IN (83011,83012,83013,83014,83015,83119,83120,83138,83139);
INSERT INTO `creature` (`guid`, `id`, `modelid`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(83011, 18404, 0, 553, 3, 149.5653, 281.7874, -4.653852, 1.016146, 7200, 0, 0), -- 18404 (Area: 0) (possible waypoints or random movement)
(83012, 17993, 0, 553, 3, 151.6609, 281.7887, -4.334745, 1.612284, 7200, 0, 0), -- 17993 (Area: 0) (possible waypoints or random movement)
(83013, 17993, 0, 553, 3, 153.7568, 281.7442, -4.008605, 2.176939, 7200, 0, 0), -- 17993 (Area: 0) (possible waypoints or random movement)
(83014, 17993, 0, 553, 3, 165.1652, 295.5352, -4.371663, 3.110243, 7200, 0, 0), -- 17993 (Area: 0) (possible waypoints or random movement)
(83015, 18404, 0, 553, 3, 165.1942, 298.2077, -4.774447, 3.852716, 7200, 0, 0), -- 18404 (Area: 0) (possible waypoints or random movement)
(83119, 17993, 0, 553, 3, 164.9687, 292.9525, -4.00805, 2.373266, 7200, 0, 0), -- 17993 (Area: 0) (possible waypoints or random movement)
(83120, 17993, 0, 553, 3, 161.4033, 285.5994, -3.098177, 1.742907, 7200, 0, 0), -- 17993 (Area: 0) (possible waypoints or random movement)
(83138, 18404, 0, 553, 3, 159.1362, 283.813, -3.272108, 1.297487, 7200, 0, 0), -- 18404 (Area: 0) (possible waypoints or random movement)
(83139, 17993, 0, 553, 3, 163.1084, 287.8988, -3.313203, 2.552928, 7200, 0, 0); -- 17993 (Area: 0) (possible waypoints or random movement)
--
-- ----------------------------------------------------
-- Centre Group of Researchers After Commander Sarannis
-- ----------------------------------------------------
DELETE FROM creature WHERE guid IN (83140);
INSERT INTO `creature` (`guid`, `id`, `modelid`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(83140, 18421, 17843, 553, 3, 175.8427, 387.1663, -5.303061, 2.234021, 7200, 0, 0); -- 18421 (Area: 0) (possible waypoints or random movement)
-- 

--
-- ------------------------------------------
-- NPC At Entry to Thorngrin the Tenders Room
-- ------------------------------------------
DELETE FROM creature WHERE guid IN (83141,83142,83143,83144,83145);
INSERT INTO `creature` (`guid`, `id`, `modelid`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(83141, 19508, 21338, 553, 3, -16.26085, 482.7058, -5.385756, 3.944444, 7200, 0, 0), -- 19508 (Area: 0) (possible waypoints or random movement)
(83142, 19508, 21339, 553, 3, -17.32133, 485.0991, -5.368748, 2.96706, 7200, 0, 0), -- 19508 (Area: 0) (possible waypoints or random movement)
(83143, 19509, 21333, 553, 3, -15.03868, 479.9812, -5.405121, 1.396263, 7200, 0, 0), -- 19509 (Area: 0) (possible waypoints or random movement)
(83144, 19555, 11686, 553, 3, -18.09245, 509.9142, 1.612676, 3.525565, 7200, 0, 0), -- 19555 (Area: 0) -- TK Atrium Channel Target
(83145, 19555, 11686, 553, 3, -1.838774, 510.5453, 0.6243833, 2.583087, 7200, 0, 0); -- 19555 (Area: 0) -- TK Atrium Channel Target
--
--
-- TK Atrium Channel Target
DELETE FROM `creature` WHERE `guid` IN (83158,83159);
INSERT INTO `creature` VALUES
(83158,19555,553,3,11686,0,20.1475,600.4174,-8.5,0,7200,0,0,1,0,0,0),
(83159,19555,553,3,11686,0,-10.3903,600.2659,-8.5,0,7200,0,0,1,0,0,0);
--
DELETE FROM creature WHERE guid IN (83045,83047); -- Delete Too Many Frayers 83044 83037
-- 82999,83059,83060,83067 freie
DELETE FROM creature WHERE guid IN (83045,83047);
INSERT INTO creature VALUES (83045,19512,553,3,0,0,-18.8205,518.483,-6.07107,6.05097,7200,0,0,20958,0,0,0);
INSERT INTO creature VALUES (83047,19511,553,3,0,0,-19.6808,514.978,-5.89398,5.61429,7200,0,0,20958,0,0,0);
--
--
DELETE FROM creature WHERE guid=83089;
DELETE FROM creature_addon WHERE guid=83089;
DELETE FROM waypoint_data WHERE id=83089;
DELETE FROM creature WHERE guid IN (83059,83060,83067); -- Delete Too Many Frayers
--
-- -------------------------------------------------------------
-- Add Missing Gene-Splicer Spawns Laying on Floor in Laj's Room
-- -------------------------------------------------------------

DELETE FROM creature WHERE guid IN (98283,98284,98285,98286,98287,98288,98289,98290,98291,98292,98293,98294);
INSERT INTO `creature` (`guid`, `id`, `modelid`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `DeathState`, `MovementType`) VALUES
(98283, 19507, 21337, 553, 3, -157.6343, 411.7007, -17.61243, 1.27409, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98284, 19507, 21335, 553, 3, -177.2168, 408.9644, -17.60689, 2.076942, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98285, 19507, 21336, 553, 3, -150.5405, 400.3017, -17.75786, 2.75762, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98286, 19507, 21335, 553, 3, -172.6049, 403.9249, -17.61106, 4.747295, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98287, 19507, 21335, 553, 3, -173.2738, 390.1292, -17.60731, 3.508112, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98288, 19507, 21336, 553, 3, -177.0949, 378.2484, -17.60809, 5.183628, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98289, 19507, 21336, 553, 3, -172.3201, 380.3159, -17.61069, 0.8901179, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98290, 19507, 21337, 553, 3, -166.8567, 398.4712, -17.6142, 4.223697, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98291, 19507, 21337, 553, 3, -154.356, 386.3756, -17.72159, 4.433136, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98292, 19507, 21337, 553, 3, -179.9221, 401.1072, -17.60423, 0.4886922, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98293, 19507, 21336, 553, 3, -164.2751, 375.6826, -17.61685, 2.75762, 7200, 0, 1, 0), -- 19507 (Area: 0)
(98294, 19507, 21336, 553, 3, -152.4001, 372.6643, -17.60546, 0.3316126, 7200, 0, 1, 0); -- 19507 (Area: 0)
--
DELETE FROM creature_addon WHERE guid IN (98283,98284,98285,98286,98287,98288,98289,98290,98291,98292,98293,98294);
INSERT INTO creature_addon VALUES 
(98283,'0','0','7','1','0','0','0',NULL),
(98284,'0','0','7','1','0','0','0',NULL),
(98285,'0','0','7','1','0','0','0',NULL),
(98286,'0','0','7','1','0','0','0',NULL),
(98287,'0','0','7','1','0','0','0',NULL),
(98288,'0','0','7','1','0','0','0',NULL),
(98289,'0','0','7','1','0','0','0',NULL),
(98290,'0','0','7','1','0','0','0',NULL),
(98291,'0','0','7','1','0','0','0',NULL),
(98292,'0','0','7','1','0','0','0',NULL),
(98293,'0','0','7','1','0','0','0',NULL),
(98294,'0','0','7','1','0','0','0',NULL);
--
DELETE FROM creature WHERE guid IN (83059,83060); 
INSERT INTO creature VALUES (83059,17993,553,0,0,0,-155.507,389.66,-17.7781,2.1041,7200,0,0,16208,3080,0,0); -- not spawned atm event doesnt work
INSERT INTO creature VALUES (83060,17993,553,0,0,0,-160.717,374.429,-17.6977,2.19363,7200,0,0,16208,3155,0,0); -- not spawned atm event doesnt work
--
-- 82999,83067,83089 freie
--
-- Recheck
--
-- Bloodwarder Protector 17993 21548
UPDATE `creature_template` SET `modelid_A2`='17775',`modelid_H`='17774',`modelid_H2`='17776',`mindmg`='1369',`maxdmg`='1867',`equipment_id`='8002' WHERE `entry` IN ('17993'); -- 398 896
UPDATE `creature_template` SET `speed`='1.48',`armor`='6800',`mindmg`='4284',`maxdmg`='4336',`equipment_id`='8002' WHERE `entry` IN ('21548'); -- 2103 2207 :2
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17993','21548');
INSERT INTO `creature_template_addon` VALUES
(17993,0,0,512,0,4097,0,0,''),
(21548,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17993');
INSERT INTO `creature_ai_scripts` VALUES
('1799301','17993','14','0','100','7','1000','25','5000','10000','11','34784','6','39','0','0','0','0','0','0','0','0','Bloodwarder Protector - Cast Intervene on friendly missing Intervene Buff'),
('1799302','17993','0','0','100','7','6600','14100','6000','12000','11','29765','1','1','0','0','0','0','0','0','0','0','Bloodwarder Protector - Cast Crystal Strike'),
('1799303','17993','0','0','100','7','5000','12000','12000','15000','11','35399','0','1','0','0','0','0','0','0','0','0','Bloodwarder Protector - Cast Spell Reflection');
-- ('1799304','17993','2','0','100','6','10','0','0','0','11','7','0','0','0','0','0','0','0','0','0','0','Bloodwarder Protector - Cast Suicide at 10% HP'), Only for Event it seems
-- 
-- Tempest-Forge Peacekeeper 18405 21578
-- 5-6k on heroic elemental dmg prenerf
UPDATE `creature_template` SET `armor`='6800',`maxhealth`='23278',`mindmg`='1054',`maxdmg`='1801',`mechanic_immune_mask`='720327677',`dmgschool`='6' WHERE `entry` IN ('18405'); -- 206 206 0
UPDATE `creature_template` SET `armor`='7700',`maxhealth`='71836',`mindmg`='4857',`maxdmg`='5069',`speed`='1.48',`mechanic_immune_mask`='720327677',`dmgschool`='6' WHERE `entry` IN ('21578'); -- 2270 2693
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18405','21578');
INSERT INTO `creature_template_addon` VALUES
(18405,0,0,512,0,4097,0,0,''),
(21578,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18405');
INSERT INTO `creature_ai_scripts` VALUES
('1840501','18405','1','0','15','7','30000','120000','120000','240000','1','-9899','-9849','0','0','0','0','0','0','0','0','0','Tempest Forge Peacekeeper - Random Say OOC'),
('1840502','18405','0','0','100','7','4000','8000','12100','21200','11','34785','1','0','0','0','0','0','0','0','0','0','Tempest Forge Peacekeeper - Cast Arcane Volley'),
('1840503','18405','0','0','100','7','5000','7100','7200','14500','11','34791','0','0','0','0','0','0','0','0','0','0','Tempest Forge Peacekeeper - Cast Arcane Explosion'),
('1840504','18405','0','0','100','7','7600','16400','15700','25300','11','34793','1','0','0','0','0','0','0','0','0','0','Tempest Forge Peacekeeper - Cast Arcane Blast');
--
-- Bloodwarder Greenkeeper 18419 21546
UPDATE `creature_template` SET `maxhealth`='18000',`modelid_H`='17884',`modelid_A2`='0',`modelid_H2`='0',`speed`='1.48',`mindmg`='1369',`maxdmg`='1867' WHERE `entry` IN ('18419'); -- 398 896
UPDATE `creature_template` SET `modelid_A2`='0',`modelid_H2`='0',`speed`='1.48',`mindmg`='3733',`maxdmg`='4053' WHERE `entry` IN ('21546'); -- 1627 2266
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18419','21546');
INSERT INTO `creature_template_addon` VALUES
(18419,0,0,16908544,0,4097,0,0,''),
(21546,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18419');
INSERT INTO `creature_ai_scripts` VALUES
('1841901','18419','9','0','100','7','0','5','5000','10000','11','34800','4','0','0','0','0','0','0','0','0','0','Bloodwarder Greenkeeper - Cast Impending Coma'),
('1841902','18419','9','0','100','3','0','40','4000','8000','11','34798','1','0','0','0','0','0','0','0','0','0','Bloodwarder Greenkeeper (Normal) - Cast Greenkeeper\'s Fury'),
('1841903','18419','9','0','100','5','0','40','2000','5000','11','39121','1','0','0','0','0','0','0','0','0','0','Bloodwarder Greenkeeper (Heroic) - Cast Greenkeeper\'s Fury'),
('1841904','18419','0','0','100','3','4000','8000','7200','16000','11','34797','4','0','0','0','0','0','0','0','0','0','Bloodwarder Greenkeeper (Normal) - Cast Nature Shock'),
('1841905','18419','0','0','100','5','2000','5000','7200','10000','11','39120','4','0','0','0','0','0','0','0','0','0','Bloodwarder Greenkeeper (Heroic) - Cast Nature Shock');
--
-- Bloodwarder Mender 19633 21547
UPDATE `creature_template` SET `maxhealth`='16000',`modelid_A`='21331',`modelid_A2`='21332',`modelid_H`='21331',`modelid_H2`='21332',`armor`='5450',`speed`='1.48',`mindmg`='1149',`maxdmg`='1605' WHERE `entry` IN ('19633'); -- 323 779 model 19050 19051 zu groß ka was da abgeht
UPDATE `creature_template` SET `modelid_A`='21331',`modelid_A2`='21332',`modelid_H`='21331',`modelid_H2`='21332',`armor`='5450',`speed`='1.48',`mindmg`='3940',`maxdmg`='4063' WHERE `entry` IN ('21547'); -- 1877 2124
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19633','21547');
INSERT INTO `creature_template_addon` VALUES
(19633,0,0,16908544,0,4097,0,0,''),
(21547,0,0,16908544,0,4097,0,0,''); 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19633');
INSERT INTO `creature_ai_scripts` VALUES
('1963301','19633','1','0','100','7','1000','1000','1800000','1800000','11','34809','0','0','0','0','0','0','0','0','0','0','Bloodwarder Mender - Cast Holy Fury on Spawn'),
('1963302','19633','9','0','100','3','0','30','10000','14000','11','17194','1','0','0','0','0','0','0','0','0','0','Bloodwarder Mender (Normal) - Cast Mind Blast'),
('1963303','19633','9','0','100','5','0','30','10000','14000','11','17287','1','0','0','0','0','0','0','0','0','0','Bloodwarder Mender (Heroic) - Cast Mind Blast'),
('1963304','19633','14','0','100','3','3600','15','10000','15000','11','35096','6','0','0','0','0','0','0','0','0','0','Bloodwarder Mender (Normal) - Cast Greater Heal on Friendlies'),
('1963305','19633','14','0','100','5','5000','15','10000','15000','11','29564','6','0','0','0','0','0','0','0','0','0','Bloodwarder Mender (Heroic) - Cast Greater Heal on Friendlies'),
('1963306','19633','16','0','100','7','34809','15','7000','14000','11','34809','6','0','0','0','0','0','0','0','0','0','Bloodwarder Mender - Cast Holy Fury on Friendlies'),
('1963307','19633','2','0','100','3','50','0','0','0','11','35096','0','1','0','0','0','0','0','0','0','0','Bloodwarder Mender (Normal) - Cast Greater Heal at 50%'),
('1963308','19633','2','0','100','5','50','0','0','0','11','29564','0','1','0','0','0','0','0','0','0','0','Bloodwarder Mender (Heroic) - Cast Greater Heal at 50%');
--
-- Bloodwarder Falconer 17994 21545 
UPDATE `creature_template` SET `modelid_A`='17777',`modelid_A2`='17779',`modelid_H`='17777',`modelid_H2`='17779',`speed`='1.48',`mindmg`='1532',`maxdmg`='2019',`equipment_id`='8013' WHERE `entry` IN ('17994'); -- 467 954
UPDATE `creature_template` SET `modelid_A`='17777',`modelid_A2`='17779',`modelid_H`='17777',`modelid_H2`='17779',`armor`='7100',`speed`='1.48',`mindmg`='4056',`maxdmg`='4361',`equipment_id`='8013' WHERE `entry` IN ('21545'); -- 1799 2409
DELETE FROM `creature_equip_template` WHERE `creature_equip_template`.`entry` = 8013;
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8013,19134,0,0,218169346,0,0,3,0,0);
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17994','21545');
INSERT INTO `creature_template_addon` VALUES
(17994,0,0,512,0,4097,0,0,''),
(21545,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17994');
INSERT INTO `creature_ai_scripts` VALUES
('1799401','17994','4','0','100','6','0','0','0','0','1','-1309','0','0','0','0','0','0','0','0','0','0','Bloodwarder Falconer - Say on Aggro'),
('1799402','17994','0','0','100','7','700','6500','10050','11150','11','34852','8','1','1','-1304','0','0','0','0','0','0','Bloodwarder Falconer - Cast Call of the Falcon'),
('1799403','17994','9','0','100','7','0','5','5000','10000','11','32908','4','32','0','0','0','0','0','0','0','0','Bloodwarder Falconer - Cast Wing Clip'),
('1799404','17994','2','0','100','7','85','0','10000','15000','11','31567','0','1','0','0','0','0','0','0','0','0','Bloodwarder Falconer - Cast Deterrence at 75% HP');
--
-- Bloodfalcon 18155 21544
UPDATE `creature_template` SET `mindmg`='1070',`maxdmg`='1408',`equipment_id`='0' WHERE `entry` IN ('18155'); -- 327 665
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3294',`maxdmg`='3653',`equipment_id`='0' WHERE `entry` IN ('21544'); -- 1377 2096
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18155','21544');
INSERT INTO `creature_template_addon` VALUES
(18155,0,0,16908544,0,4097,0,0,''),
(21544,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18155');
INSERT INTO `creature_ai_scripts` VALUES
('1815501','18155','9','0','75','7','8','25','10000','15000','11','32323','1','0','0','0','0','0','0','0','0','0','Bloodfalcon - Cast Charge'),
('1815502','18155','0','0','100','7','6200','7900','10800','12500','11','34856','1','0','0','0','0','0','0','0','0','0','Bloodfalcon - Cast Bloodburn'),
('1815503','18155','0','0','100','7','12500','20100','20100','25300','11','18144','1','0','0','0','0','0','0','0','0','0','Bloodfalcon - Cast Swoop');
--
-- Bloodwarder Steward 18404 21549
UPDATE `creature_template` SET `modelid_A`='17813',`modelid_A2`='17816',`modelid_H`='17813',`modelid_H2`='17816',`equipment_id`='1550',`speed`='1.48',`mindmg`='1476',`maxdmg`='2013' WHERE `entry` IN ('18404'); -- 429 966
UPDATE `creature_template` SET `modelid_A`='17813',`modelid_A2`='17816',`modelid_H`='17813',`modelid_H2`='17816',`equipment_id`='1550',`speed`='1.48',`mindmg`='4105',`maxdmg`='4390' WHERE `entry` IN ('21549'); -- 1839 2408
UPDATE `creature_model_info` SET `bounding_radius`='2' WHERE `modelid` IN ('17815','17816','17817');
UPDATE `creature_model_info` SET `gender`='1' WHERE `modelid` IN ('17816');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18404','21549');
INSERT INTO `creature_template_addon` VALUES
(18404,0,0,512,0,4097,0,0,''),
(21549,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18404');
INSERT INTO `creature_ai_scripts` VALUES
('1840401','18404','0','0','100','7','7000','10000','12000','15000','11','34821','0','0','0','0','0','0','0','0','0','0','Bloodwarder Steward - Cast Arcane Flurry');
--
-- Sunseeker Botanist 18422 21570
--    Hmm...
-- The Sunseeker Botanist casts Rejuvenate Plant on her Greater Frayer.
--    Yes. That did the trick.
UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='17820',`modelid_H`='17819',`modelid_H2`='17820',`minlevel`='69',`speed`='1.48',`mindmg`='1421',`maxdmg`='1872' WHERE `entry` IN ('18422'); -- 433 884
UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='17820',`modelid_H`='17819',`modelid_H2`='17820',`minlevel`='70',`armor`='5700',`speed`='1.48',`pickpocketloot`='18422',`mindmg`='3487',`maxdmg`='3831' WHERE `entry` IN ('21570'); -- 1486 2174
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18422','21570');
INSERT INTO `creature_template_addon` VALUES
(18422,0,0,16908544,0,4097,0,0,''),
(21570,0,0,16908544,0,4097,0,0,''); 
UPDATE `creature_model_info` SET `bounding_radius`='2' WHERE `modelid` IN ('17820');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18422');
INSERT INTO `creature_ai_scripts` VALUES
('1842201','18422','16','0','100','7','34350','15','16900','27700','11','34350','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist - Cast Nature\'s Rage on Friendlies on Missing Buff'),
('1842202','18422','0','0','100','3','19300','19300','38600','38600','11','34254','1','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Normal) - Cast Rejuvenate Plant'),
('1842203','18422','0','0','100','5','19300','19300','38600','38600','11','39126','1','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Heroic) - Cast Rejuvenate Plant'),
('1842204','18422','14','0','100','3','4000','15','13300','21000','11','27637','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Normal) - Cast Regrowth on Friendlies'),
('1842205','18422','14','0','100','5','5600','15','13300','21000','11','39125','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Heroic) - Cast Regrowth on Friendlies'),
('1842206','18422','2','0','100','3','75','0','13300','21000','11','27637','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Normal) - Cast Regrowth at 75% HP'),
('1842207','18422','2','0','100','5','75','0','13300','21000','11','39125','6','0','0','0','0','0','0','0','0','0','Sunseeker Botanist (Heroic) - Cast Regrowth at 75% HP');
--
-- Greater Frayer 19557 21555
UPDATE `creature_template` SET `armor`='5500',`speed`='1.20',`mindmg`='597',`maxdmg`='786',`AIName`='EventAI' WHERE `entry` IN ('19557'); -- 182 371
UPDATE `creature_template` SET `armor`='6100',`speed`='1.20',`mindmg`='2521',`maxdmg`='2853' WHERE `entry` IN ('21555'); -- 1012 1676
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19557','21555');
INSERT INTO `creature_template_addon` VALUES
(19557,0,0,512,0,4097,0,0,''),
(21555,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19557');
INSERT INTO `creature_ai_scripts` VALUES
('1955701','19557','0','0','100','3','2300','8300','5100','12100','11','34644','1','0','0','0','0','0','0','0','0','0','Greater Frayer (Normal) - Cast Lash'),
('1955702','19557','0','0','100','5','2300','8300','5100','12100','11','39122','1','0','0','0','0','0','0','0','0','0','Greater Frayer (Heroic) - Cast Lash');
--
-- Sunseeker Researcher 18421 21577
UPDATE `creature_template` SET `modelid_A2`='17844',`modelid_H2`='17845',`speed`='1.48',`mindmg`='1421',`maxdmg`='1872' WHERE `entry` IN ('18421'); -- 433 884
UPDATE `creature_template` SET `modelid_H`='17842',`armor`='5700',`speed`='1.48',`mindmg`='4162',`maxdmg`='4397' WHERE `entry` IN ('21577'); -- 1905 2375
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18421','21577');
INSERT INTO `creature_template_addon` VALUES
(18421,0,0,16908544,0,4097,0,0,''),
(21577,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18421');
INSERT INTO `creature_ai_scripts` VALUES
('1842101','18421','0','0','100','7','2000','7200','7200','14000','11','34352','4','32','0','0','0','0','0','0','0','0','Sunseeker Researcher - Cast Mind Shock'),
('1842102','18421','0','0','100','7','5500','8000','12100','14000','11','34354','4','32','0','0','0','0','0','0','0','0','Sunseeker Researcher - Cast Flame Shock'),
('1842103','18421','0','0','100','7','5000','16900','12100','14000','11','34353','4','32','0','0','0','0','0','0','0','0','Sunseeker Researcher - Cast Frost Shock'),
('1842104','18421','0','0','100','7','3000','5000','2000','5000','11','34355','0','33','0','0','0','0','0','0','0','0','Sunseeker Researcher - Cast Poison Shield'),
('1842105','18421','16','0','100','7','34355','1','2000','5000','11','34355','0','1','0','0','0','0','0','0','0','0','Sunseeker Researcher - Cast Poison Shield on Missing Buff');
--
-- Sunseeker Chemist 19486 21572
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='1421',`maxdmg`='1872' WHERE `entry` IN ('19486'); -- 433 884
UPDATE `creature_template` SET `modelid_H`='18925',`speed`='1.48',`armor`='5700',`mindmg`='4047',`maxdmg`='4231' WHERE `entry` IN ('21572'); -- 1886 2253
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19486','21572');
INSERT INTO `creature_template_addon` VALUES
(19486,0,0,16908544,0,4097,0,0,''),
(21572,0,0,16908544,0,4097,0,0,''); 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19486');
INSERT INTO `creature_ai_scripts` VALUES
('1948601','19486','0','0','100','3','4300','10000','18100','25000','11','34358','4','0','0','0','0','0','0','0','0','0','Sunseeker Chemist (Normal) - Cast Vial of Poison'),
('1948602','19486','0','0','100','5','4300','10000','18100','25000','11','39127','4','0','0','0','0','0','0','0','0','0','Sunseeker Chemist (Heroic) - Cast Vial of Poison'),
('1948603','19486','0','0','100','3','5000','9600','10000','14500','11','34359','0','0','0','0','0','0','0','0','0','0','Sunseeker Chemist (Normal) - Cast Fire Breath Potion'),
('1948604','19486','0','0','100','5','5000','9600','10000','14500','11','39128','0','0','0','0','0','0','0','0','0','0','Sunseeker Chemist (Heroic) - Cast Fire Breath Potion');
--
-- Sunseeker Geomancer 18420 21574
UPDATE `creature_template` SET `modelid_A`='17916',`modelid_A2`='17918',`modelid_H`='17916',`modelid_H2`='17918',`speed`='1.48',`mindmg`='1446',`maxdmg`='1904',`equipment_id`='8016',`mechanic_immune_mask`='1039089407' WHERE `entry` IN ('18420'); -- 441 899  
UPDATE `creature_template` SET `modelid_A`='17916',`modelid_A2`='17918',`modelid_H`='17916',`modelid_H2`='17918',`speed`='1.48',`mindmg`='4051',`maxdmg`='4308',`equipment_id`='8016',`mechanic_immune_mask`='1039089407' WHERE `entry` IN ('21574'); -- 1833 2347
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8016');
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8016,40650,0,0,285346306,0,0,2,0,0);
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18420','21574');
INSERT INTO `creature_template_addon` VALUES
(18420,0,0,16908544,0,4097,0,0,''),
(21574,0,0,16908544,0,4097,0,0,''); 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18420');
INSERT INTO `creature_ai_scripts` VALUES
('1842001','18420','9','0','100','7','0','8','3600','8000','11','35124','0','0','0','0','0','0','0','0','0','0','Sunseeker Geomancer - Cast Arcane Explosion'),
('1842002','18420','1','0','100','7','1000','1000','12000','12000','11','35265','0','33','0','0','0','0','0','0','0','0','Sunseeker Geomancer - Cast Fire Shield on Missing Buff OOC'),
('1842003','18420','0','0','100','7','5000','10000','10000','20000','11','35265','0','33','0','0','0','0','0','0','0','0','Sunseeker Geomancer - Cast Fire Shield on Missing Buff IC');
--
-- Frayer 18587 21552
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='423',`maxdmg`='578',`AIName`='EventAI' WHERE `entry` IN ('18587'); -- 123 278
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='1231',`maxdmg`='1632' WHERE `entry` IN ('21552'); -- 315 1116
DELETE FROM `creature_template_addon` WHERE `entry` IN ('18587','21552');
INSERT INTO `creature_template_addon` VALUES
(18587,0,0,16908544,0,4097,0,0,'34201 0'),
(21552,0,0,16908544,0,4097,0,0,'34201 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18587');
INSERT INTO `creature_ai_scripts` VALUES
('1858701','18587','8','0','100','7','34167','-1','1000','1000','11','34202','0','33','0','0','0','0','0','0','0','0','Frayer - Cast Frost Form on Blizzard SpellHit'), -- -1 = 34167
('1858702','18587','8','0','100','7','34169','-1','1000','1000','11','34203','0','33','0','0','0','0','0','0','0','0','Frayer - Cast Fire Form on Rain of Fire SpellHit'), -- 34169
('1858703','18587','8','0','100','7','34170','-1','1000','1000','11','34204','0','33','0','0','0','0','0','0','0','0','Frayer - Cast Arcane Form on Arcane Explosion SpellHit'), -- 34170
('1858704','18587','8','0','100','7','0','32','1000','1000','11','34205','0','33','0','0','0','0','0','0','0','0','Frayer - Cast Shadow Form on Shadow SpellHit'),
--
('1858705','18587','8','0','100','7','0','16','1000','1000','11','34202','0','33','0','0','0','0','0','0','0','0','Frayer - Cast Frost Form on Frost SpellHit'),
('1858706','18587','8','0','100','7','0','4','1000','1000','11','34203','0','33','0','0','0','0','0','0','0','0','Frayer - Cast Fire Form on Fire SpellHit'),
('1858707','18587','8','0','100','7','0','64','1000','1000','11','34204','0','33','0','0','0','0','0','0','0','0','Frayer - Cast Arcane Form on Arcane SpellHit');
--
-- 2 	SPELL_SCHOOL_FIRE
-- 3 	SPELL_SCHOOL_NATURE
-- 4 	SPELL_SCHOOL_FROST
-- 5 	SPELL_SCHOOL_SHADOW
-- 6 	SPELL_SCHOOL_ARCANE 
--
-- shadow nova increase radius to hit all Frayers
UPDATE `dbc_spell` SET `EffectRadiusIndex[0]`='8' WHERE `entry` IN ('34256'); -- 8
--
-- Nethervine Inciter 19511 21563
UPDATE `creature_template` SET `mindmg`='1532',`maxdmg`='2019',`equipment_id`='8017',`mechanic_immune_mask`='0' WHERE `entry` IN ('19511'); -- 467 954
UPDATE `creature_template` SET `minlevel`='71',`armor`='7100',`speed`='1.71',`mindmg`='3000',`maxdmg`='4000',`equipment_id`='8017',`mechanic_immune_mask`='1' WHERE `entry` IN ('21563'); -- 1749 2499 4194305
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19511','21563');
INSERT INTO `creature_template_addon` VALUES
(19511,0,0,512,0,4097,0,0,''),
(21563,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8017');
INSERT INTO `creature_equip_template` VALUES
(8017,34111,34111,0,218173186,218173186,0,3,3,0);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19511');
INSERT INTO `creature_ai_scripts` VALUES
('1951101','19511','0','0','100','7','4300','5600','5000','10000','11','34615','5','7','0','0','0','0','0','0','0','0','Nethervine Inciter - Cast Mind Numbing Poison'),
('1951102','19511','0','0','100','7','3000','4300','10000','15000','11','34616','4','7','0','0','0','0','0','0','0','0','Nethervine Inciter - Cast Deadly Poison'),
('1951103','19511','9','0','100','7','0','5','20000','25000','11','30621','1','0','0','0','0','0','0','0','0','0','Nethervine Inciter - Cast Kidney Shot'),
('1951104','19511','4','0','100','7','0','0','0','0','11','29651','0','0','0','0','0','0','0','0','0','0','Nethervine Inciter - Casts Dual Wield on Aggro'),
('1951105','19511','8','0','100','7','34222','-1','1000','1000','11','34173','0','7','0','0','0','0','0','0','0','0','Nethervine Inciter - Cast Sunseeker Blessing on Sunseeker Blessing Spellhit');

-- Nethervine Reaper 19512 21564
UPDATE `creature_template` SET `mindmg`='2019',`maxdmg`='2532',`baseattacktime`='2000',`equipment_id`='1564' WHERE `entry` IN ('19512'); -- 467 954
UPDATE `creature_template` SET `minlevel`='71',`armor`='7100',`speed`='1.71',`mindmg`='4000',`maxdmg`='5000',`mechanic_immune_mask`='1',`equipment_id`='1564' WHERE `entry` IN ('21564'); -- 1896 2177
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19512','21564');
INSERT INTO `creature_template_addon` VALUES
(19512,0,0,512,0,4097,0,0,''),
(21564,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19512');
INSERT INTO `creature_ai_scripts` VALUES
('1951201','19512','0','0','100','7','4300','8100','4300','8100','11','15284','1','0','0','0','0','0','0','0','0','0','Nethervine Reaper - Cast Cleave'),
('1951202','19512','9','0','100','5','0','30','12000','16000','11','34626','4','32','0','0','0','0','0','0','0','0','Nethervine Reaper (Heroic) - Cast Pale Death'),
('1951203','19512','8','0','100','7','34222','-1','1000','1000','11','34173','0','7','0','0','0','0','0','0','0','0','Nethervine Reaper - Cast Sunseeker Blessing on Sunseeker Blessing Spellhit');
--
-- Nethervine Trickster 19843 21565
UPDATE `creature_template` SET `mindmg`='1532',`maxdmg`='2019',`equipment_id`='8018' WHERE `entry` IN ('19843'); -- 467 954
UPDATE `creature_template` SET `minlevel`='71',`armor`='7100',`speed`='1.71',`mindmg`='3000',`maxdmg`='4000',`equipment_id`='8018',`mechanic_immune_mask`='1' WHERE `entry` IN ('21565'); -- 1758 2210
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8018');
INSERT INTO `creature_equip_template` VALUES
(8018,20273,20273,0,218173186 ,218173186 ,0,3,3,0);
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19843','21565');
INSERT INTO `creature_template_addon` VALUES
(19843,0,0,512,0,4097,0,0,''),
(21565,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19843');
INSERT INTO `creature_ai_scripts` VALUES
('1984301','19843','1','0','100','7','1000','1000','0','0','11','30831','0','33','0','0','0','0','0','0','0','0','Nethervine Trickster - Cast Stealth OOC'),
('1984302','19843','9','0','100','7','0','5','4100','9700','11','34614','1','0','0','0','0','0','0','0','0','0','Nethervine Trickster - Cast Backstab'),
('1984303','19843','7','0','100','6','0','0','0','0','11','30831','0','1','0','0','0','0','0','0','0','0','Nethervine Trickster - Cast Stealth on Evade'),
('1984304','19843','4','0','100','7','0','0','0','0','11','29651','0','0','0','0','0','0','0','0','0','0','Nethervine Trickster - Casts Dual Wield on Aggro'),
('1984305','19843','8','0','100','7','34222','-1','1000','1000','11','34173','0','7','0','0','0','0','0','0','0','0','Nethervine Trickster - Cast Sunseeker Blessing on Sunseeker Blessing Spellhit');
--
-- Sunseeker Channeler 19505 21571
-- UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='21340',`modelid_H`='17819',`modelid_H2`='21340',`armor`='5450',`speed`='1.48',`mindmg`='1310',`maxdmg`='1724', WHERE `entry` IN ('19505'); -- 400 814
-- UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='21340',`modelid_H`='17819',`modelid_H2`='21340',`armor`='5700',`speed`='1.48',`mindmg`='3685',`maxdmg`='3889', WHERE `entry` IN ('21571'); -- 1690 2098
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19505','21571');
INSERT INTO `creature_template_addon` VALUES
(19505,0,0,16908544,0,4097,0,0,''),
(21571,0,0,16908544,0,4097,0,0,''); 
--
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19505');
INSERT INTO `creature_ai_scripts` VALUES
-- (Sunseeker Blessing is Triggered from Channeling OOC) - REVIEW SNIFF DATA
('1950501','19505','9','0','100','7','0','20','10000','15000','11','34637','4','1','0','0','0','0','0','0','0','0','Sunseeker Channeler - Cast Soul Channel'),
('1950502','19505','0','0','100','7','5000','10000','10000','15000','11','34634','0','39','0','0','0','0','0','0','0','0','Sunseeker Channeler - Cast Sunseeker Aura');
-- ('1950503','19505','1','0','100','7','5000','5000','16500','16500','11','34221','0','7','11','34156','0','7','0','0','0','0','Sunseeker Channeler - Cast Crystal Channel OOC'),
-- ('1950504','19505','1','0','100','7','15200','15200','16500','16500','11','34173','0','7','0','0','0','0','0','0','0','0','Sunseeker Channeler - Cast Sunseeker Blessing');
--
-- TK Atrium Channel Target
UPDATE `creature_template` SET `inhabittype`='5',`unit_flags`='33554688',`flags_extra`='130' WHERE `entry` IN ('19555');
--
-- Sunseeker Harvester 19509 21575
UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='21333',`modelid_H`='17819',`modelid_H2`='21333',`speed`='1.48',`mindmg`='1421',`maxdmg`='1872' WHERE `entry` IN ('19509'); -- 433 884
UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='21333',`modelid_H`='17819',`modelid_H2`='21333',`armor`='5700',`speed`='1.48',`mindmg`='3966',`maxdmg`='4208' WHERE `entry` IN ('21575'); -- 1801 2286
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19509','21575');
INSERT INTO `creature_template_addon` VALUES
(19509,0,0,16908544,0,4097,0,0,''),
(21575,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19509');
INSERT INTO `creature_ai_scripts` VALUES
('1950901','19509','0','0','100','7','3100','9700','5400','12700','11','34640','4','32','0','0','0','0','0','0','0','0','Sunseeker Harvester - Cast Wilting Touch'),
('1950902','19509','9','0','100','7','0','20','5000','8000','11','34639','5','32','0','0','0','0','0','0','0','0','Sunseeker Harvester - Cast Polymorph'),
('1950903','19509','9','0','100','7','0','30','8000','12000','11','37823','4','32','0','0','0','0','0','0','0','0','Sunseeker Harvester - Cast Entangling Roots'),
('1950904','19509','0','0','100','7','12100','19400','24800','27700','11','34247','1','1','11','35428','1','1','0','0','0','0','Sunseeker Gene-Splicer - Summon 2 Lasher Beast'); -- oder 50% hp 
-- ('1950904','19509','2','0','100','6','50','0','0','0','12','19598','1','300','12','19598','1','300','0','0','0','0','Sunseeker Harvester - Summon 2 Mutate Fleshlasher Adds on 50% HP');
--
-- Mutate Fleshlasher 19598 21561
UPDATE `creature_template` SET `maxhealth`='5300',`armor`='5800',`speed`='1.20',`mindmg`='766',`maxdmg`='1010',`AIName`='EventAI',`mechanic_immune_mask`='283313875' WHERE `entry` IN ('19598'); -- 467 954
UPDATE `creature_template` SET `minlevel`='71',`maxlevel`='71',`armor`='6100',`speed`='1.20',`mechanic_immune_mask`='283313875',`mindmg`='1532',`maxdmg`='2019' WHERE `entry` IN ('21561'); -- -66 421
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19598','21561');
INSERT INTO `creature_template_addon` VALUES
(19598,0,0,512,0,4097,0,0,'7743 0'),
(21561,0,0,512,0,4097,0,0,'7743 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19598');
INSERT INTO `creature_ai_scripts` VALUES
('1959801','19598','0','0','100','7','7800','12100','6200','12100','11','34351','1','0','0','0','0','0','0','0','0','0','Mutate Fleshlasher - Cast Vicious Bite');
--
-- Mutate Fleshlasher spawned by Bloodelves
UPDATE `creature_template` SET `heroic_entry`='21561',`maxhealth`='5300',`armor`='5800',`faction_A`='14',`faction_H`='14',`speed`='1.20',`mindmg`='766',`maxdmg`='1010',`AIName`='EventAI',`mechanic_immune_mask`='283313875' WHERE `entry` IN ('25354');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('25354');
INSERT INTO `creature_ai_scripts` VALUES
('2535401','25354','0','0','100','7','7800','12100','6200','12100','11','34351','1','0','0','0','0','0','0','0','0','0','Mutate Fleshlasher - Cast Vicious Bite'),
('2535402','25354','7','0','100','7','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Mutate Fleshlasher - Despawn on Evade');
--
-- Sunseeker Gene-Splicer 19507 21573
UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='21335',`modelid_H`='17819',`modelid_H2`='21335',`armor`='5450',`speed`='1.48',`mindmg`='1310',`maxdmg`='1724' WHERE `entry` IN ('19507'); -- model 21336 too 400 814
UPDATE `creature_template` SET `modelid_A`='17819',`modelid_A2`='21335',`modelid_H`='17819',`modelid_H2`='21335',`armor`='5700',`speed`='1.48',`mindmg`='4103',`maxdmg`='4323',`pickpocketloot`='19507',`mechanic_immune_mask`='1' WHERE `entry` IN ('21573'); -- 1887 2326
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19507','21573');
INSERT INTO `creature_template_addon` VALUES
(19507,0,0,16908544,0,4097,0,0,''),
(21573,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19507');
INSERT INTO `creature_ai_scripts` VALUES
('1950701','19507','9','0','100','3','0','20','15100','20300','11','34642','4','0','0','0','0','0','0','0','0','0','Sunseeker Gene-Splicer (Normal) - Cast Death and Decay'),
('1950702','19507','9','0','100','5','0','20','10100','20300','11','39347','4','0','0','0','0','0','0','0','0','0','Sunseeker Gene-Splicer (Heroic) - Cast Death and Decay'),
('1950703','19507','0','0','100','7','12100','19400','24800','27700','11','34247','1','1','11','35428','1','1','0','0','0','0','Sunseeker Gene-Splicer - Summon 2 Lasher Beast'); -- oder 50% hp 
--
-- Mutate Horror 19865 21562
UPDATE `creature_template` SET `minhealth`='19000',`maxhealth`='20000',`armor`='6800',`mindmg`='515',`maxdmg`='1005',`mechanic_immune_mask`='283313875' WHERE `entry` IN ('19865'); -- 206 206
UPDATE `creature_template` SET `minhealth`='28000',`maxhealth`='29000',`minlevel`='71',`armor`='7100',`speed`='1.71',`mindmg`='3777',`maxdmg`='4021' WHERE `entry` IN ('21562'); -- 1706 2194
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19865','21562');
INSERT INTO `creature_template_addon` VALUES
(19865,0,0,512,0,4097,0,0,'7743 0'),
(21562,0,0,512,0,4097,0,0,'7743 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19865');
INSERT INTO `creature_ai_scripts` VALUES
('1986501','19865','9','0','100','7','0','5','10000','15000','11','34643','1','0','0','0','0','0','0','0','0','0','Mutate Horror - Cast Corrode Armor');
--
-- Mutate Fear-Shrieker 19513 21560
UPDATE `creature_template` SET `minhealth`='19000',`maxhealth`='20000',`armor`='6800',`mindmg`='515',`maxdmg`='1005',`mechanic_immune_mask`='283313875' WHERE `entry` IN ('19513'); -- 206 206
UPDATE `creature_template` SET `minhealth`='28000',`maxhealth`='29000',`minlevel`='71',`armor`='7100',`speed`='1.71',`mindmg`='3332',`maxdmg`='3707' WHERE `entry` IN ('21560'); -- 1385 2134
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19513','21560');
INSERT INTO `creature_template_addon` VALUES
(19513,0,0,512,0,4097,0,0,'7743 0'),
(21560,0,0,512,0,4097,0,0,'7743 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19513');
INSERT INTO `creature_ai_scripts` VALUES
('1951301','19513','9','0','100','7','0','10','10000','15000','11','12542','5','33','0','0','0','0','0','0','0','0','Mutate Fear-Shrieker - Cast Fear'); -- should be a casted fear that is interruptable
--
-- Frayer Wildling 19608 21554
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='460',`maxdmg`='607',`AIName`='EventAI' WHERE `entry` IN ('19608'); -- 140 287
UPDATE `creature_template` SET `armor`='6792',`speed`='1.20',`mindmg`='1264',`maxdmg`='1503' WHERE `entry` IN ('21554'); -- 453 931
DELETE FROM `creature_template_addon` WHERE `entry` IN ('19608','21554');
INSERT INTO `creature_template_addon` VALUES
(19608,0,0,512,0,4097,0,0,''),
(21554,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('19608');
INSERT INTO `creature_ai_scripts` VALUES
('1960801','19608','9','0','100','3','0','5','4100','8300','11','34644','1','0','0','0','0','0','0','0','0','0','Frayer Wildling (Normal) - Cast Lash'),
('1960802','19608','9','0','100','5','0','5','4100','6100','11','39122','1','0','0','0','0','0','0','0','0','0','Frayer Wildling (Heroic) - Cast Lash');
--
--
-- Bosses
--
-- Commander Sarannis 17976,21551
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`mindmg`='1983',`maxdmg`='2614',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('17976');
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='5851',`maxdmg`='6354',`pickpocketloot`='17976',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21551');
UPDATE `creature_template` SET `equipment_id`='8005' WHERE `entry` IN ('17976','21551');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8005');
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8005,43978,0,0,33490690,0,0,781,0,0);
-- 0 verschwindet die waffe nach dem schlag
-- 1 links hauptangriff unarmed
-- 2 rechts hauptangriff unarmed
-- 3 unarmed
-- 4
-- 13 für sachen die kaputt gehen
-- 273 schlägt zu und dann erscheint die waffe auf dem rücken nach unten zeigend
-- 529 schlägt zu und dann erscheint die waffe auf dem rücken nach oben zeigend
-- 781 schlägt zu und dann erscheint die waffe auf an der hüfte
-- 1037 schlägt zu und dann erscheint die waffe auf dem rücken senkrecht nach oben
-- 1805 schlägt zu dann verschindet die waffe
-- 1814 schwere waffen
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17976');
INSERT INTO `creature_ai_scripts` VALUES
-- (Adds Summon Spell: 34803 / Casts - 34810 (NPC: 20083 5 Yards Behind) and 34817 / 34818 / 34819 (NPC: 20078 5 Yards Sides and Front)
('1797601','17976','4','0','100','6','0','0','0','0','1','-34','0','0','0','0','0','0','0','0','0','0','Commander Sarannis - Yell on Aggro'),
('1797602','17976','9','0','100','3','0','10','3800','15300','11','34794','1','0','1','-37','0','0','0','0','0','0','Commander Sarannis (Normal) - Cast Arcane Resonance and Yell'),
('1797603','17976','9','0','100','5','0','10','2800','10900','11','34794','1','0','1','-37','0','0','0','0','0','0','Commander Sarannis (Heroic) - Cast Arcane Resonance and Yell'),
('1797604','17976','0','0','100','7','15200','15200','11000','19200','11','34799','1','1','1','-38','0','0','0','0','0','0','Commander Sarannis - Cast Arcane Devastation on 3 Arcane Resonance Stack and Yell'),
('1797605','17976','2','0','100','2','55','0','0','0','1','-9848','0','0','12','20078','4','1800000','12','19633','4','1800000','Commander Sarannis (Normal) - Emote and Summon Bloodwarder Reservist and Bloodwarder Mender at 55% HP'),
('1797606','17976','2','0','100','2','55','0','0','0','12','20078','4','1800000','12','20078','4','1800000','1','-39','0','0','Commander Sarannis (Normal) - Summon 2 Bloodwarder Reservists and Yell at 55% HP'),
('1797607','17976','2','0','100','2','60','0','0','0','11','34803','0','0','0','0','0','0','0','0','0','0','Commander Sarannis (Normal) - Cast Dummy Spell on 60% HP'),
('1797608','17976','0','0','100','5','30000','30000','60000','60000','1','-9848','0','0','12','20078','4','1800000','12','19633','4','1800000','Commander Sarannis (Heroic) - Emote and Summon Bloodwarder Reservist and Bloodwarder Mender'),
('1797609','17976','0','0','100','5','30000','30000','60000','60000','12','20078','4','1800000','12','20078','4','1800000','1','-39','0','0','Commander Sarannis (Heroic) - Summon 2 Bloodwarder Reservists and Yell'),
('1797610','17976','0','0','100','5','28000','28000','60000','60000','11','34803','0','0','0','0','0','0','0','0','0','0','Commander Sarannis (Heroic) - Cast Dummy Spell befor Summon'),
('1797611','17976','5','0','100','7','0','0','0','0','1','-21','-35','0','0','0','0','0','0','0','0','0','Commander Sarannis - Yell on Player Kill'),
('1797612','17976','6','0','100','6','0','0','0','0','1','-36','0','0','0','0','0','0','0','0','0','0','Commander Sarannis - Yell on Death');
--
--
--
--
--
--
-- 20078 19633 spawned npcs
-- Summoned Bloodwarder Mender same as Bloodwarder Mender
-- Summoned Bloodwarder Reservist
UPDATE `creature_template` SET `equipment_id`='8014',`modelid_A`='17816',`modelid_A2`='17774',`modelid_H`='17816',`modelid_H2`='17774',`armor`='5500',`speed`='1.20',`mindmg`='507',`maxdmg`='761',`AIName`='EventAI' WHERE `entry` IN ('20078');
UPDATE `creature_template` SET `equipment_id`='8014',`modelid_A`='17816',`modelid_A2`='17774',`modelid_H`='17816',`modelid_H2`='17774',`armor`='5800',`speed`='1.20',`mindmg`='3294',`maxdmg`='3594' WHERE `entry` IN ('21569');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20078');
INSERT INTO `creature_ai_scripts` VALUES
('2007801','20078','0','0','100','7','12400','16400','8100','16200','11','34820','1','0','0','0','0','0','0','0','0','0','Summoned Bloodwarder Reservist - Cast Arcane Strike');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('20078');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8014');
INSERT INTO `creature_equip_template` (`entry`, `equipmodel1`, `equipmodel2`, `equipmodel3`, `equipinfo1`, `equipinfo2`, `equipinfo3`, `equipslot1`, `equipslot2`, `equipslot3`) VALUES
(8014,48061 ,0,0,33490690,0,0,781,0,0);
--
--
--
--
--
--
-- High Botanist Freywinn 17975,21558
UPDATE `creature_template` SET `mindmg`='1840',`maxdmg`='2424',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('17975');  --
UPDATE `creature_template` SET `maxlevel`='72',`speed`='1.71',`mindmg`='5474',`maxdmg`='5934',`pickpocketloot`='17975',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21558');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17975','21558');
INSERT INTO `creature_template_addon` VALUES
(17975,0,0,16908544,0,4097,0,0,''),
(21558,0,0,16908544,0,4097,0,0,''); 
--
-- Thorngrin the Tender 17978,21581
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`mindmg`='2604',`maxdmg`='3429',`mechanic_immune_mask`='787431423',`flags_extra`='536870912' WHERE `entry` IN ('17978');  -- 
UPDATE `creature_template` SET `maxlevel`='72',`armor`='7400',`speed`='1.71',`mindmg`='5562',`maxdmg`='5963',`pickpocketloot`='17978',`mechanic_immune_mask`='787431423',`flags_extra`='536870913' WHERE `entry` IN ('21581'); -- 
--
-- Laj 17980,21559
UPDATE `creature_template` SET `mindmg`='2552',`maxdmg`='3364',`mechanic_immune_mask`='787431423',`flags_extra`='536870912' WHERE `entry` IN ('17980');  --
UPDATE `creature_template` SET `maxlevel`='72',`speed`='1.71',`mindmg`='5758',`maxdmg`='6221',`mechanic_immune_mask`='787431423',`flags_extra`='536870913' WHERE `entry` IN ('21559');
--
-- Warp Splinter 17977,21582
UPDATE `creature_template` SET `armor`='7400',`mindmg`='1578',`maxdmg`='1945',`mechanic_immune_mask`='787431423',`flags_extra`='536870913' WHERE `entry` IN ('17977');  --
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`armor`='7400',`speed`='1.48',`mindmg`='6607',`maxdmg`='7199',`skinloot`='80002',`mechanic_immune_mask`='787431423',`flags_extra`='536870913' WHERE `entry` IN ('21582');
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='7' WHERE `creature_id` IN ('17977','21582');
--
-- Sapling 19949 21567
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`faction_A`='14',`faction_H`='14',`speed`='1.20'   WHERE `entry` IN ('19949');
UPDATE `creature_template` SET `armor`='6792' WHERE `entry` IN ('21567');
--
--
--
-- visuals / positioning
--
--
-- ------------------------
-- Fix Warp Splinter's Room
-- ------------------------
UPDATE creature SET Spawndist=3, MovementType=1 WHERE id IN (19608);
--
UPDATE `creature` SET `id`='19512' WHERE `guid` IN ('83082');
UPDATE `creature` SET `id`='19511' WHERE `guid` IN ('83085');
--
-- --------------------------
-- Fix Nethervine Trickster's
-- --------------------------
UPDATE creature SET Spawndist=5, MovementType=1 WHERE guid IN (83087,83088);
DELETE FROM waypoint_data WHERE id IN (83087);
UPDATE creature SET position_x = '-88.661102', position_y = '547.243958', position_z = '-17.805691', orientation = '0.557306' WHERE guid = '83088';
-- ---------------------
-- Fix Gene-Splicer Room
-- ---------------------
UPDATE creature SET Spawndist=3, MovementType=1 WHERE guid IN (83092,83090,83099,83098,83101,83100);
UPDATE creature SET position_x = '-150.864899', position_y = '525.923035', position_z = '-17.823814', orientation = '3.511526' WHERE guid = '83097';
UPDATE creature SET position_x = '-154.763702', position_y = '529.822021', position_z = '-17.823814', orientation = '4.188539' WHERE guid = '83095';
UPDATE creature SET position_x = '-163.409683', position_y = '504.117920', position_z = '-17.823814', orientation = '4.029104' WHERE guid = '83102';
UPDATE creature SET position_x = '-129.737488', position_y = '504.990234', position_z = '-17.823814', orientation = '3.721230' WHERE guid = '83091';
UPDATE creature SET position_x = '-157.169098', position_y = '471.524658', position_z = '-17.824739', orientation = '1.367393' WHERE guid = '83106';
UPDATE creature SET position_x = '-165.245972', position_y = '472.490967', position_z = '-17.824739', orientation = '1.426298' WHERE guid = '83105';

DELETE FROM creature_addon WHERE guid IN (83095,83097,83096,83091,83093,83094,83104,83103,83102);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83095','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83097','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83096','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83091','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83093','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83094','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83104','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83103','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83102','0','0','0','0','69','0',NULL);
--
-- Move NPC to Correct Locations
UPDATE creature SET position_x = '0.743981', position_y = '504.740265', position_z = '-5.319865', orientation = '2.016919' WHERE guid = '83070';
UPDATE creature SET position_x = '-17.591831', position_y = '505.420837', position_z = '-5.307605', orientation = '2.085249' WHERE guid = '83075';
UPDATE creature SET position_x = '1.367998', position_y = '493.800598', position_z = '-5.412396', orientation = '2.885726' WHERE guid = '83073';
--
-- -----------------------
-- Second Group of Frayers
-- -----------------------
UPDATE creature SET Spawndist=3, MovementType=1 WHERE guid IN (83065,83063,83064,83069,83062,82061,83058,83057,83068,83066);
UPDATE creature SET position_x = '106.104866', position_y = '497.827667', position_z = '-6.854609', orientation = '3.172230' WHERE guid = '83057';
-- --------------------------------------
-- NPC in Front of High Botanist Freywinn
-- --------------------------------------
DELETE FROM creature_addon WHERE guid IN (83052,83053,83055,83051,83049);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83052','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83053','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83055','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83051','0','0','1','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83049','0','0','1','0','0','0',NULL);
--
-- ----------------------
-- First Group of Frayers
-- ----------------------
UPDATE creature SET Spawndist=3, MovementType=1 WHERE guid IN (83043,83044,83046,83042,83040,83039,83041,83036,83037,83038);
UPDATE creature SET position_x = '162.939285', position_y = '433.364624', position_z = '-6.835905', orientation = '1.929722' WHERE guid = '83040';
--
-- --------------------------------------------------
-- Left Group of Researchers After Commander Sarannis
-- --------------------------------------------------
UPDATE creature SET position_x = '159.302002', position_y = '367.640228', position_z = '-5.411332', orientation = '3.524878' WHERE guid = '83018';
DELETE FROM creature_addon WHERE guid IN (83016,83017,83019);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83016','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83019','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83017','0','8','0','0','0','0',NULL);
-- ---------------------------------------------------
-- Right Group of Researchers After Commander Sarannis
-- ---------------------------------------------------
DELETE FROM creature_addon WHERE guid IN (83032,83033,83034,83030);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83032','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83033','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83034','0','0','1','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83030','0','8','0','0','0','0',NULL);
DELETE FROM creature_addon WHERE guid IN (83029,83020,83140);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83029','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83140','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83020','0','0','1','0','69','0',NULL);
-- ------------------------------------------------------
-- Far Left Group of Researchers After Commander Sarannis
-- ------------------------------------------------------
UPDATE creature SET position_x = '164.376556', position_y = '408.294800', position_z = '-5.386406', orientation = '2.155144' WHERE guid = '83025';
DELETE FROM creature_addon WHERE guid IN (83028,83048,83021,83024);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83028','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83048','0','0','0','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83021','0','0','1','0','69','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83024','0','8','0','0','0','0',NULL);
--
--
-- 1st boss trash
DELETE FROM `creature_addon` WHERE `guid` IN (83011,83012,83013,83014,83015,83119,83120,83138,83139);
INSERT INTO `creature_addon` VALUES
(83011,0,0,512,0,4097,26,0,''),
(83012,0,0,512,0,4097,26,0,''),
(83013,0,0,512,0,4097,26,0,''),
(83014,0,0,512,0,4097,26,0,''),
(83015,0,0,512,0,4097,26,0,''),
(83119,0,0,512,0,4097,26,0,''),
(83120,0,0,512,0,4097,26,0,''),
(83138,0,0,512,0,4097,26,0,''),
(83139,0,0,512,0,4097,26,0,'');
--
-- -------------------------------------
-- Bloodwarder Falconer and Bloodfalcons
-- -------------------------------------
-- Random Movement for Falconer and BloodFalcons
UPDATE creature SET Spawndist=10, MovementType=1 WHERE guid IN (83008,83009,83010);
UPDATE creature SET Spawndist=3, MovementType=1 WHERE guid IN (83007);
--
UPDATE `creature_model_info` SET `bounding_radius`='2' WHERE `modelid` IN ('17777','17778','17780');
UPDATE `creature_model_info` SET `gender`='0' WHERE `modelid` IN ('17780');
-- --------------------
-- Bloodwarder Falconer
-- --------------------
-- Random Movement for Remaining BloodFalcons
UPDATE creature SET Spawndist=10, MovementType=1 WHERE guid IN (82996,82997,82998);
-- ------------------------
-- 2 Bloodwarder Protectors
-- ------------------------
DELETE FROM creature_addon WHERE guid IN (83001,83002);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83001','0','0','4097','0','333','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83002','0','0','4097','0','333','0',NULL);
-- ------------------------
-- 2 Bloodwarder Protectors
-- ------------------------
DELETE FROM creature_addon WHERE guid IN (83004,83005);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83004','0','0','4097','0','333','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83005','0','0','4097','0','333','0',NULL);
--
UPDATE `creature` SET `position_x`='-0.7006', `position_y`='255.0998', `position_z`='-5.4898', `orientation`='1.5881',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('83000');
UPDATE `creature_model_info` SET `bounding_radius`='2' WHERE `modelid` IN ('21331','21332');
--
-- ----------------------------------------
-- 2 Green Keepers and One Mender in Middle
-- ----------------------------------------
-- Addon Data
DELETE FROM creature_addon WHERE guid IN (83000,82994,82993);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82994','0','0','0','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82993','0','0','0','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83000','0','8','0','0','0','0',NULL);
--
-- ------------------------
-- 2 Bloodwarder Protectors
-- ------------------------
UPDATE creature SET position_x = '-14.725861', position_y = '244.255112', position_z = '-5.214353', orientation = '6.011446' WHERE guid = '82985';
UPDATE creature SET position_x = '12.536785', position_y = '244.131027', position_z = '-5.276653', orientation = '3.282975' WHERE guid = '82991';
DELETE FROM creature_addon WHERE guid IN (82985,82991);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82985','0','0','1','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82991','0','0','1','0','0','0',NULL);
--
DELETE FROM creature_addon WHERE guid IN (82981,82982);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82981','0','0','0','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82982','0','8','0','0','0','0',NULL);
DELETE FROM creature_addon WHERE guid IN (82977,82978);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82977','0','0','0','0','0','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82978','0','8','0','0','0','0',NULL);
--
-- ---------------------------------
-- 4 Bloodwarder Protectors At Front
-- ---------------------------------
DELETE FROM creature_addon WHERE guid IN (83152,83151,83154,83155);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83151','0','0','1','0','333','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83152','0','0','1','0','333','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83154','0','0','1','0','333','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83155','0','0','1','0','333','0',NULL);

UPDATE creature SET position_x = '0.319128', position_y = '93.350929', position_z = '-5.652020', orientation = '4.749768' WHERE guid = '83151';
UPDATE creature SET position_x = '-2.910640', position_y = '93.303818', position_z = '-5.652020', orientation = '4.661018' WHERE guid = '83152';
-- ------------------------
-- 2 Bloodwarder Protectors
-- ------------------------
UPDATE creature SET position_x = '-10.472994', position_y = '160.509964', position_z = '-5.540343', orientation = '4.944090' WHERE guid = '83156';
UPDATE creature SET position_x = '9.051096', position_y = '160.359482', position_z = '-5.540343', orientation = '4.428083' WHERE guid = '82984';
DELETE FROM creature_addon WHERE guid IN (83156,82984);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83156','0','0','1','0','333','0',NULL);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('82984','0','0','1','0','333','0',NULL);
--
-- -----------------------
-- Bloodwarder Greenkeeper
-- -----------------------
DELETE FROM creature_addon WHERE guid IN (83150);
INSERT INTO creature_addon (`guid`, `mount`, `bytes1`, `bytes0`, `bytes2`, `emote`, `moveflags`, `auras`) VALUES ('83150','0','0','0','0','69','0',NULL);



--
--
--
--
--
--
--
--
--
--
--
-- movement
--
--
--
--
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83059);
SET @NPC := 83059;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-155.507','389.66','-17.7781','16000',0,0,100,0),
(@PATH,2,'-155.507','389.66','-17.7781',0,0,0,100,0),
(@PATH,3,'-161.64','398.266','-17.734',0,0,0,100,0),
(@PATH,4,'-157.994','405.455','-17.6956',0,0,8305902,100,0),
(@PATH,5,'-164.289','411.495','-17.7221',0,0,0,100,0),
(@PATH,6,'-169.0393','407.6524','-17.69853','60000',0,8305901,100,0),
(@PATH,7,'-169.0393','407.6524','-17.69853','1000',0,8305903,100,0),
(@PATH,8,'-169.0393','407.6524','-17.69853','1000',0,8305904,100,0);

UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83060);
SET @NPC := 83060;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-160.717','374.429','-17.6977','16000',0,0,100,0),
(@PATH,2,'-160.717','374.429','-17.6977',0,0,0,100,0),
(@PATH,3,'-167.591','389.41','-17.6984',0,0,0,100,0),
(@PATH,4,'-170.008','400.085','-17.696',0,0,0,100,0),
(@PATH,5,'-161.8523','407.7832','-17.69849',0,0,0,100,0),
(@PATH,6,'-163.7475','428.2452','-17.78011','60000',0,8305901,100,0),
(@PATH,7,'-163.7475','428.2452','-17.78011','1000',0,8305903,100,0),
(@PATH,8,'-163.7475','428.2452','-17.78011','1000',0,8305904,100,0);
--
-- -----------------------------------------------------
-- Sunseeker Channelers In Front of Thorngrin the Tender
-- -----------------------------------------------------
-- Right Sunseeker Channeler Pathing
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (82988);
SET @NPC := 82988;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'21.6491','588.464','-17.7652','21337',0,8307101,100,0), -- Channeling 
(@PATH,2,'21.6491','588.464','-17.7652','2000',0,8307104,100,0), -- Cast Sunseeker Blessing 
(@PATH,3,'19.3148','583.8','-17.8192',0,0,0,100,0),
(@PATH,4,'18.6946','574.077','-17.9568','2000',0,8307106,100,0), -- Cast In Middle of Group (2 Sec Delay)
(@PATH,5,'19.3882','583.435','-17.8253',0,0,0,100,0),
(@PATH,6,'21.6491','588.464','-17.7652','5000',0,0,100,0); -- Wait at Channeling Position

-- Left Sunseeker Channeler Pathing
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83077);
SET @NPC := 83077;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-11.5331','590.832','-17.7077','21337',0,8307101,100,0), -- Channeling
(@PATH,2,'-11.5331','590.832','-17.7077','2000',0,8307104,100,0), -- Cast Sunseeker Blessing
(@PATH,3,'-3.60459','580.712','-17.8252',0,0,0,100,0),
(@PATH,4,'-5.46937','575.998','-17.8898','2000',0,8307106,100,0), -- Cast In Middle of Group (2 Sec Delay)
(@PATH,5,'-3.59916','581.005','-17.8215',0,0,0,100,0),
(@PATH,6,'-11.5331','590.832','-17.7077','5000',0,0,100,0);  -- Wait at Channeling Position
--
-- -----------------------------------------------------------
-- Nethervine Inciter Pathing in Front of Thorngrin the Tender
-- -----------------------------------------------------------
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83086);
SET @NPC := 83086;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-23.5901','562.602','-18.0989',0,0,0,100,0),
(@PATH,2,'-30.229','570.418','-17.9359',0,0,0,100,0),
(@PATH,3,'-23.8211','563.044','-18.0996',0,0,0,100,0),
(@PATH,4,'-16.2925','559.634','-18.1095',0,0,0,100,0),
(@PATH,5,'31.0858','559.317','-18.1989',0,0,0,100,0),
(@PATH,6,'40.6974','562.026','-17.609',0,0,0,100,0),
(@PATH,7,'31.3911','559.043','-18.2044',0,0,0,100,0),
(@PATH,8,'-15.7247','559.729','-18.1073',0,0,0,100,0);

-- ----------------------------------------------------------------------------------
-- Nethervine Inciter and Nethervine Reaper Pathing Around Thorngrin the Tenders Room
-- ----------------------------------------------------------------------------------
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83045);
SET @NPC := 83045;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,'1','-11.1495','518.438','-5.74976',0,0,0,100,0),
(@PATH,'2','-4.07179','518.313','-5.74221',0,0,0,100,0),
(@PATH,'3','6.70262','522.214','-8.08245',0,0,0,100,0),
(@PATH,'4','17.3582','529.537','-12.428',0,0,0,100,0),
(@PATH,'5','20.4706','535.661','-15.3494',0,0,0,100,0),
(@PATH,'6','20.9221','543.053','-18.4064',0,0,0,100,0),
(@PATH,'7','16.8279','549.014','-18.3111',0,0,0,100,0),
(@PATH,'8','9.84162','550.811','-18.2149',0,0,0,100,0),
(@PATH,'9','-8.74968','551.02','-18.2178',0,0,0,100,0),
(@PATH,'10','-26.358','551.434','-18.2145',0,0,0,100,0),
(@PATH,'11','-36.5401','550.107','-18.263',0,0,0,100,0),
(@PATH,'12','-42.5133','546.936','-18.3103',0,0,0,100,0),
(@PATH,'13','-43.7557','542.668','-18.4038',0,0,0,100,0),
(@PATH,'14','-39.4576','531.936','-14.0649',0,0,0,100,0),
(@PATH,'15','-35.2496','526.307','-10.4672',0,0,0,100,0),
(@PATH,'16','-29.7596','522.783','-8.69191',0,0,0,100,0),
(@PATH,'17','-23.0708','519.459','-6.90383',0,0,0,100,0),
(@PATH,'18','-18.2628','518.513','-5.97764',0,0,0,100,0);
--
-- Sunseeker Channeler that buffs a PAT
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83071);
SET @NPC := 83071;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0), 8307101
(@PATH,1,'-7.07519','507.14','-5.29541','10000',0,8307101,100,0), -- Channeling
(@PATH,2,'-7.07519','507.14','-5.29541','2000',0,8307104,100,0), -- Stop Channel by selfcasting 34173
(@PATH,3,'-7.07519','507.14','-5.29541','10000',0,8307102,100,0), -- Channel Nethervine Inciter
(@PATH,4,'-7.07519','507.14','-5.29541','2000',0,8307106,100,0), -- Buff Nethervine Inciter
(@PATH,5,'-7.07519','507.14','-5.29541','9000',0,1011,100,0); -- Emote 11
--
-- Sunseeker Channeler
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83070);
SET @NPC := 83070;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'0.743981','504.74','-5.31987','20000',0,8307101,100,0), -- Channeling
(@PATH,2,'0.743981','504.74','-5.31987','25000',0,8307106,100,0); -- Stop Channel by selfcasting 34173
-- (@PATH,3,'0.743981','504.74','-5.31987','1000',0,1011,100,0); -- Emote 11

-- Sunseeker Channeler
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83075);
SET @NPC := 83075;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-17.5918','505.421','-5.3076','20000',0,8307101,100,0), -- Channeling
(@PATH,2,'-17.5918','505.421','-5.3076','25000',0,8307106,100,0); -- Stop Channel by selfcasting 34173
-- (@PATH,3,'-17.5918','505.421','-5.3076','1000',0,1011,100,0); -- Emote 11
-- Sunseeker Channeler
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83074);
SET @NPC := 83074;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-24.473','507.265','-5.30362','20000',0,8307101,100,0), -- Channeling
(@PATH,2,'-24.473','507.265','-5.30362','25000',0,8307106,100,0); -- Stop Channel by selfcasting 34173
-- (@PATH,3,'-24.473','507.265','-5.30362','1000',0,1011,100,0); -- Emote 11
--
-- Outside Pathing Nethervine Inciter
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83072);
SET @NPC := 83072;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-14.2594','491.108','-5.40935',0,0,0,100,0),
(@PATH,2,'-8.55427','483.309','-5.47117',0,0,0,100,0),
(@PATH,3,'2.78195','481.305','-5.58427',0,0,0,100,0),
(@PATH,4,'-8.53638','482.843','-5.4743',0,0,0,100,0),
(@PATH,5,'-15.5274','491.044','-5.41147',0,0,0,100,0),
(@PATH,6,'-17.9647','501.451','-5.33586',0,0,0,100,0);
--
-- Inside Pathing Nethervine Inciter
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83073);
SET @NPC := 83073;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-4.02644','494.172','-5.3942',0,0,0,100,0),
(@PATH,2,'-9.07605','497.28','-5.36563',0,0,0,100,0),
(@PATH,3,'-13.1972','502.904','-5.32566',0,0,0,100,0),
(@PATH,4,'-11.7771','511.38','-5.33284',12000,0,0,100,0),
(@PATH,5,'-12.8163','503.922','-5.31762',0,0,0,100,0), -- cast trigger spell 34200 
(@PATH,6,'-8.46771','497.311','-5.36527',0,0,0,100,0),
(@PATH,7,'-3.33881','493.658','-5.39807',0,0,0,100,0),
(@PATH,8,'6.10934','493.845','-5.4377',0,0,0,100,0),
(@PATH,9,'15.9986','496.659','-5.46175',0,0,0,100,0),
(@PATH,10,'6.36544','494.456','-5.43269',0,0,0,100,0);
--
-- Sunseeker Geomancer Pathing
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83056);
SET @NPC := 83056;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'88.4563','495.092','-5.38647','3000',0,0,100,0),
(@PATH,2,'97.2095','493.595','-6.78375',0,0,0,100,0),
(@PATH,3,'102.952','491.174','-6.76313','8000',0,8303502,100,0), -- Cast Frost 
(@PATH,4,'102.952','491.174','-6.76313','8000',0,8303503,100,0), -- Cast Fire
(@PATH,5,'102.952','491.174','-6.76313','2000',0,8303504,100,0), -- cast arcane
(@PATH,6,'102.952','491.174','-6.76313','2000',0,8303504,100,0), -- cast arcane
(@PATH,7,'102.952','491.174','-6.76313','4000',0,8303504,100,0), -- cast arcane
(@PATH,8,'102.952','491.174','-6.76313','6000',0,8303501,100,0), -- say
(@PATH,9,'102.952','491.174','-6.76313','2000',0,0,100,0), -- cast shadow 8303505  when shadow spell found
(@PATH,10,'97.2095','493.595','-6.78375',0,0,0,100,0),
(@PATH,11,'87.5729','495.1206','-5.3864','0',0,0,100,0);
--
-- ----------------------
-- High Botanist Freywinn
-- ----------------------
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (82987);
SET @NPC := 82987;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,69,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'116.584','455.602','-4.95288',0,0,0,100,0),
(@PATH,2,'115.153','455.568','-4.89346','10000',0,1069,100,0), -- 69
(@PATH,3,'115.153','455.568','-4.89346','1666',0,8298701,100,0),
(@PATH,4,'115.153','455.568','-4.89346','1667',0,8298702,100,0),
(@PATH,5,'115.153','455.568','-4.89346','1667',0,8298703,100,0),
(@PATH,6,'115.153','455.568','-4.89346','1667',0,8298704,100,0),
(@PATH,7,'115.153','455.568','-4.89346','1667',0,8298702,100,0),
(@PATH,8,'115.153','455.568','-4.89346','1666',0,1069,100,0),
(@PATH,9,'116.623','455.478','-4.94902',0,0,0,100,0),
(@PATH,10,'120.628','451.036','-4.92864',0,0,0,100,0),
(@PATH,11,'120.543','449.982','-4.88372','10000',0,1069,100,0),
(@PATH,12,'120.543','449.982','-4.88372','1666',0,8298701,100,0),
(@PATH,13,'120.543','449.982','-4.88372','1667',0,8298702,100,0),
(@PATH,14,'120.543','449.982','-4.88372','1667',0,8298703,100,0),
(@PATH,15,'120.543','449.982','-4.88372','1667',0,8298704,100,0),
(@PATH,16,'120.543','449.982','-4.88372','1667',0,8298702,100,0),
(@PATH,17,'120.543','449.982','-4.88372','1666',0,1069,100,0),
(@PATH,18,'120.796','450.93','-4.93171',0,0,0,100,0);
--
-- Right Sunseeker Botanist
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83049);
SET @NPC := 83049;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'174.814','495.449','-2.62112','4000',0,8304901,100,0),
(@PATH,2,'174.814','495.449','-2.62112','6000',0,8304903,100,0), -- cast 34254
(@PATH,3,'174.814','495.449','-2.62112','55000',0,8304902,100,0);
--
-- Left Sunseeker Botanist
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83055);
SET @NPC := 83055;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'159.537','508.659','-2.74336','25000',0,0,100,0), -- Spacer
(@PATH,2,'159.537','508.659','-2.74336','4000',0,8304901,100,0), -- Say 
(@PATH,3,'159.537','508.659','-2.74336','6000',0,8304903,100,0), -- Cast Spell
(@PATH,4,'159.537','508.659','-2.74336','55000',0,8304902,100,0); -- Say
--
-- Sunseeker Researcher Pathing
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83052);
SET @NPC := 83052;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'164.783','501.235','-2.07282','25000',0,0,100,0),
(@PATH,2,'158.254','492.187','-4.47891',0,0,0,100,0),
(@PATH,3,'136.829','470.648','-1.59932',0,0,0,100,0),
(@PATH,4,'121.211','455.423','-4.88299','5000',0,8305201,100,0), -- emote 1 
(@PATH,5,'121.211','455.423','-4.88299','10000',0,8305201,100,0), -- emote 1
(@PATH,6,'134.158','467.606','-1.69619',0,0,0,100,0),
(@PATH,7,'158.166','491.949','-4.52846',0,0,0,100,0);
--
-- Sunseeker Geomancer Pathing
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83035);
SET @NPC := 83035;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'162.3120','452.8745','-5.4149',3000,0,0,100,0),
(@PATH,2,'162.23','452.538','-5.41697',0,0,0,100,0),
(@PATH,3,'163.493','446.524','-6.9092',0,0,0,100,0),
(@PATH,4,'163.268','441.86','-6.86923',0,0,0,100,0),
(@PATH,5,'162.006','437.507','-6.83356',0,0,0,100,0),
(@PATH,6,'156.922','435.956','-6.77183','8000',0,8303502,100,0), -- Cast Frost 34167
(@PATH,7,'156.922','435.956','-6.77183','8000',0,8303503,100,0), -- Cast Fire 34169
(@PATH,8,'156.922','435.956','-6.77183','2000',0,8303504,100,0), -- Cast Arcane 34170
(@PATH,9,'156.922','435.956','-6.77183','2000',0,8303504,100,0),  -- Cast Arcane 34170
(@PATH,10,'156.922','435.956','-6.77183','4000',0,8303504,100,0), -- Cast Arcane 34170
(@PATH,11,'156.922','435.956','-6.77183','6000',0,8303501,100,0), -- say 8303501
(@PATH,12,'156.922','435.956','-6.77183','2000',0,0,100,0), -- Cast 8303505 Shadow 
(@PATH,13,'161.566','437.091','-6.82662',0,0,0,100,0),
(@PATH,14,'163.727','441.472','-6.87038',0,0,0,100,0),
(@PATH,15,'163.606','446.25','-6.90634',0,0,0,100,0),
(@PATH,16,'161.4920','454.2147','-5.4148','0',0,0,100,0);
--
-- ---------------------
-- Left Pathing Botanist
-- ---------------------
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (83022);
SET @NPC := 83022;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'153.194','402.43','-5.3864','21000',0,0,100,0),
(@PATH,2,'152.247','399.99','-5.3864',0,0,0,100,0),
(@PATH,3,'153.166','393.779','-5.3864',0,0,0,100,0),
(@PATH,4,'157.038','387.449','-5.3864',0,0,0,100,0),
(@PATH,5,'160.205','378.829','-5.3864',0,0,0,100,0),
(@PATH,6,'159.918','377.573','-5.3864','26000',0,0,100,0),
(@PATH,7,'162.102','381.613','-5.3864',0,0,0,100,0),
(@PATH,8,'161.551','390.539','-5.3864',0,0,0,100,0),
(@PATH,9,'155.869','395.531','-5.3864',0,0,0,100,0),
(@PATH,10,'151.97','399.905','-5.3864',0,0,0,100,0);

-- ----------------------
-- Right Pathing Botanist
-- ----------------------
UPDATE creature SET Spawndist=0, MovementType=2,orientation = '2.16378' WHERE guid IN (83027);
SET @NPC := 83027;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),

(@PATH,1,'159.904','402.942','-5.3864','26000',0,0,100,0),
(@PATH,2,'161.38','401.344','-5.3864',0,0,0,100,0),
(@PATH,3,'168.674','402.822','-5.3864',0,0,0,100,0),
(@PATH,4,'177.992','404.019','-5.3864',0,0,0,100,0),
(@PATH,5,'182.163','403.591','-5.3864',0,0,0,100,0),
(@PATH,6,'182.889','396.989','-5.3864',0,0,0,100,0),
(@PATH,7,'181.288','388.73','-5.3864',0,0,0,100,0),
(@PATH,8,'188.878','381.951','-5.43289',0,0,0,100,0),
(@PATH,9,'191.392','382.601','-5.44611',0,0,0,100,0),
(@PATH,10,'192.458','383.717','-5.44123','31000',0,0,100,0),
(@PATH,11,'189.689','381.902','-5.43911',0,0,0,100,0),
(@PATH,12,'182.847','387.644','-5.38726',0,0,0,100,0),
(@PATH,13,'182.062','400.955','-5.38726',0,0,0,100,0),
(@PATH,14,'178.353','404.378','-5.38726',0,0,0,100,0),
(@PATH,15,'166.276','401.489','-5.38726',0,0,0,100,0),
(@PATH,16,'161.438','401.543','-5.38726',0,0,0,100,0);
--
-- ------------------
-- Commander Sarannis
-- ------------------
UPDATE creature SET Spawndist=0, MovementType=2 WHERE guid IN (82986);
SET @NPC := 82986;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- -- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,2,'120.012','327.677','-4.99033',0,0,0,100,0), -- Back Of Bridge
(@PATH,3,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,4,'120.012','327.677','-4.99033',0,0,0,100,0), -- Back Of Bridge
(@PATH,5,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,6,'151.954','283.758','-4.67356','3000',0,8315101,100,0), -- Front of Left NPC and Salute
(@PATH,7,'151.954','283.758','-4.67356','6000',0,8299401,100,0),-- Front of Left NPC and Talk
(@PATH,8,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,9,'162.800','295.447','-4.80194','3000',0,8315101,100,0), -- Front of Right NPC and Salute
(@PATH,10,'162.800','295.447','-4.80194','6000',0,8299401,100,0), -- Front of Right NPC and Talk
(@PATH,11,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC (Facing To Back)
(@PATH,12,'120.012','327.677','-4.99033',0,0,0,100,0), -- Back Of Bridge
(@PATH,13,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,14,'120.012','327.677','-4.99033',0,0,0,100,0), -- Back Of Bridge
(@PATH,15,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,16,'159.540','287.615','-4.10529','3000',0,8315101,100,0), -- Front of Center NPC and Salute
(@PATH,17,'159.540','287.615','-4.10529','6000',0,8299401,100,0), -- Front of Center NPC and Talk
(@PATH,18,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,19,'151.954','283.758','-4.67356','3000',0,8315101,100,0), -- Front of Left NPC and Salute
(@PATH,20,'151.954','283.758','-4.67356','6000',0,8299401,100,0), -- Front of Left NPC and Talk
(@PATH,21,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC (Facing To Back)
(@PATH,22,'120.012','327.677','-4.99033',0,0,0,100,0), -- Back Of Bridge
(@PATH,23,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,24,'120.012','327.677','-4.99033',0,0,0,100,0), -- Back Of Bridge
(@PATH,25,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,26,'162.800','295.447','-4.80194','3000',0,8315101,100,0), -- Front of Right NPC and Salute
(@PATH,27,'162.800','295.447','-4.80194','6000',0,8299401,100,0), -- Front of Right NPC and Talk
(@PATH,28,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,29,'159.540','287.615','-4.10529','3000',0,8315101,100,0), -- Front of Center NPC and Salute
(@PATH,30,'159.540','287.615','-4.10529','6000',0,8299401,100,0), -- Front of Center NPC and Talk
(@PATH,31,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC (Facing To Back)
(@PATH,32,'120.012','327.677','-4.99033',0,0,0,100,0), -- Back Of Bridge
(@PATH,33,'152.491','294.444','-4.6658',0,0,0,100,0), -- Front of Bridge With NPC
(@PATH,34,'159.540','287.615','-4.10529','10000',0,8298601,100,0); -- Front of Center NPC and Yell and Cheer Emote 4
--
-- -----------------------------------
-- Bloodwarder Steward Pathing in Hall
-- -----------------------------------
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('83006');
SET @NPC := 83006;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'50.9215','293.818','-5.63032',0,0,0,100,0),
(@PATH,2,'50.4144','282.994','-5.64831',0,0,0,100,0);
--
-- Left Green Keeper
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('82994');
SET @NPC := 82994;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,69,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-3.0730','254.8057','-5.4790','22200',0,0,100,0),
(@PATH,2,'-1.3867','253.2512','-5.4943','7000',0,8299401,100,0),
(@PATH,3,'-3.0730','254.8057','-5.4790','30200',0,0,100,0),
(@PATH,4,'-1.3867','253.2512','-5.4943','7000',0,8299401,100,0),
(@PATH,5,'-3.0730','254.8057','-5.4790','16200',0,0,100,0),
(@PATH,6,'-1.3867','253.2512','-5.4943','7000',0,8299401,100,0);
--
-- Right Green Keeper
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('82993');
SET @NPC := 82993;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,69,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'3.9829','253.1120','-5.4724',21500,0,0,100,0), 
(@PATH,2,'3.4760','252.0930','-5.4791',0,0,0,100,0),
(@PATH,3,'0.4444','252.4552','-5.4943',7000,0,8299401,100,0),
(@PATH,4,'3.9829','253.1120','-5.4724',29500,0,0,100,0), 
(@PATH,5,'3.4760','252.0930','-5.4791',0,0,0,100,0),
(@PATH,6,'0.4444','252.4552','-5.4943',7000,0,8299401,100,0),
(@PATH,7,'3.9829','253.1120','-5.4724',15500,0,0,100,0), 
(@PATH,8,'3.4760','252.0930','-5.4791',0,0,0,100,0),
(@PATH,9,'0.4444','252.4552','-5.4943',7000,0,8299401,100,0),
(@PATH,10,'3.4760','252.0930','-5.4791',0,0,0,100,0);
--
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('82985');
SET @NPC := 82985;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,513,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-14.725861','244.255112','-5.214353','8000',0,0,100,0),
(@PATH,2,'-3.16054','243.291','-5.5165',0,0,0,100,0),
(@PATH,3,'-3.54976','215.113','-5.53931',0,0,0,100,0),
(@PATH,4,'-5.031358','214.277512','-5.540350','10000',0,8315101,100,0),
(@PATH,5,'-3.54976','215.113','-5.53931',0,0,0,100,0),
(@PATH,6,'-3.16054','243.291','-5.5165',0,0,0,100,0);
--
--
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('82991');
SET @NPC := 82991;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,513,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'12.536785','244.131027','-5.276653','8800',0,0,100,0),
(@PATH,2,'2.36405','242.874','-5.51154',0,0,0,100,0),
(@PATH,3,'2.44798','215.308','-5.54035',0,0,0,100,0),
(@PATH,4,'3.941355','214.042435','-5.540350','10000',0,8315101,100,0),
(@PATH,5,'2.44798','215.308','-5.54035',0,0,0,100,0),
(@PATH,6,'2.36405','242.874','-5.51154',0,0,0,100,0);

--
-- -----------------------------
-- Left Bloodwarder Greenkeepers
-- -----------------------------
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('82981');
SET @NPC := 82981;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,69,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-19.4848','197.125','-5.54034','29000',0,0,100,0),
(@PATH,2,'-18.3153','195.691','-5.54122',0,0,0,100,0),
(@PATH,3,'-14.4761','195.052','-5.54122',0,0,0,100,0),
(@PATH,4,'-9.28239','198.789','-5.54122',0,0,0,100,0),
(@PATH,5,'-7.14421','203.369','-5.54122',0,0,0,100,0),
(@PATH,6,'-8.27586','203.442','-5.54122','24000',0,0,100,0),
(@PATH,7,'-6.73612','202.567','-5.54122',0,0,0,100,0),
(@PATH,8,'-8.75032','199.727','-5.54122',0,0,0,100,0),
(@PATH,9,'-13.0694','195.498','-5.54122',0,0,0,100,0),
(@PATH,10,'-17.5981','194.664','-5.54122',0,0,0,100,0),
(@PATH,11,'-19.281','195.896','-5.54122',0,0,0,100,0);
--
-- ------------------------------
-- Right Bloodwarder Greenkeepers
-- ------------------------------
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('82977');
SET @NPC := 82977;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,69,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'13.8952','197.464','-5.54041','18000',0,0,100,0),
(@PATH,2,'15.0475','193.183','-5.54122',0,0,0,100,0),
(@PATH,3,'16.6998','192.651','-5.54122',0,0,0,100,0),
(@PATH,4,'17.8517','192.8757','-5.54122','20000',0,0,100,0),
(@PATH,5,'17.5705','192.439','-5.54122',0,0,0,100,0),
(@PATH,6,'14.347','193.671','-5.54122',0,0,0,100,0),
(@PATH,7,'13.4535','196.095','-5.54122',0,0,0,100,0);
--
-- -------------------------------
-- Third Tempest-Forge Peacekeeper
-- -------------------------------
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('82992');
SET @NPC := 82992;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'13.2272','178.591','-5.5404',0,0,0,100,0),
(@PATH,2,'13.7786','193.285','-5.5404',0,0,0,100,0),
(@PATH,3,'9.13868','197.798','-5.5404','5000',0,0,100,0),
(@PATH,4,'-0.635412','203.851','-5.5404',0,0,0,100,0),
(@PATH,5,'-0.660702','223.381','-5.5404',0,0,0,100,0),
(@PATH,6,'-0.571616','247.901','-5.51829',0,0,0,100,0),
(@PATH,7,'-0.697975','222.215','-5.54037','3000',0,0,100,0),
(@PATH,8,'-0.301946','204.186','-5.54037',0,0,0,100,0),
(@PATH,9,'8.68828','198.154','-5.54037',0,0,0,100,0),
(@PATH,10,'13.1168','194.426','-5.54037',0,0,0,100,0);
--
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('82983');
SET @NPC := 82983;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,69,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-0.268618','160.028','-5.5395',0,0,0,100,0),
(@PATH,2,'-4.24328','161.149','-5.5395',0,0,0,100,0),
(@PATH,3,'-6.01467','167.23','-5.5395','34000',0,0,100,0),
-- evtl nochn waypoint
(@PATH,4,'-3.54166','160.511','-5.5395',0,0,0,100,0),
(@PATH,5,'2.36906','161.495','-5.5395',0,0,0,100,0),
(@PATH,6,'2.31835','163.18','-5.54038','16000',0,0,100,0);
-- evtl nochn waypoint
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
--
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('83151');
SET @NPC := 83151;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,333,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'0.319128','93.350929','-5.652020',2200,0,8315101,100,0),
(@PATH,2,'0.304653','53.7379','-5.65205',0,0,0,100,0),
(@PATH,3,'0.246856','49.9056','-5.61616',0,0,0,100,0),
(@PATH,4,'1.77807','47.0135','-5.52788',0,0,0,100,0),
(@PATH,5,'2.35202','46.2708','-5.53589',60000,0,0,100,0); -- 8315102 waypoint_script
-- 
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('83152');
SET @NPC := 83152;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,333,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-2.910640','93.303818','-5.652020',2190,0,8315101,100,0),
(@PATH,2,'-3.09647','53.6826','-5.65205',0,0,0,100,0),
(@PATH,3,'-2.9898','50.0713','-5.62371',0,0,0,100,0),
(@PATH,4,'-3.98776','46.8545','-5.53157',0,0,0,100,0),
(@PATH,5,'-4.7336','45.9968','-5.55443',59990,0,0,100,0);  -- 8315102 waypoint_script
-- -------------------------------
-- First Tempest-Forge Peacekeeper
-- -------------------------------
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('83153');
SET @NPC := 83153;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1, -1.238058,53.229778,-5.650580,0,0,0,100,0),
(@PATH,2, -1.056883,93.744209,-5.651805,0,0,0,100,0),
(@PATH,3, -0.781224,113.317207,-5.583306,0,0,0,100,0),
(@PATH,4, -1.384052,95.681999,-5.650106,0,0,0,100,0),
(@PATH,5, -1.409816,55.045288,-5.651893,0,0,0,100,0),
(@PATH,6, -1.025726,43.837605,-5.606754,0,0,0,100,0);
--
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('82984');
SET @NPC := 82984;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,333,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'9.051096','160.359482','-5.540343','2200',0,8315101,100,0),
(@PATH,2,'7.00565','151.863','-5.54034',0,0,0,100,0),
(@PATH,3,'2.13972','149.017','-5.54034',0,0,0,100,0),
(@PATH,4,'2.85909','133.568','-5.54034',0,0,0,100,0),
(@PATH,5,'3.1027','130.1091','-5.5396','10000',0,0,100,0),
(@PATH,6,'2.85909','133.568','-5.54034',0,0,0,100,0),
(@PATH,7,'2.13972','149.017','-5.54034',0,0,0,100,0),
(@PATH,8,'7.00565','151.863','-5.54034',0,0,0,100,0);
--
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('83156');
SET @NPC := 83156;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,512,0,4097,333,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,'-10.472994','160.509964','-5.540343','2200',0,8315101,100,0),
(@PATH,2,'-9.05886','151.889','-5.54034',0,0,0,100,0),
(@PATH,3,'-3.30866','147.948','-5.54034',0,0,0,100,0),
(@PATH,4,'-3.96269','134.198','-5.54034',0,0,0,100,0),
(@PATH,5,'-5.29153','130.642','-5.53917','10000',0,0,100,0),
(@PATH,6,'-3.96269','134.198','-5.54034',0,0,0,100,0),
(@PATH,7,'-3.30866','147.948','-5.54034',0,0,0,100,0),
(@PATH,8,'-9.05886','151.889','-5.54034',0,0,0,100,0);





--
--
--
--
-- 
--
--
--
-- formations
DELETE FROM `creature_formations` WHERE `leaderguid` IN (82991,82985,83141,83142,83143,83049,83050,83051,83053,83054,83055,83021,83024,83025,83028,83048,83029,83020,83140,83030,83031,83032,83033,83034,83016,83017,83018,83019,83115,83116,83117,83118,83110,83111,83113,83114,83107,83108,83109,83112,83105,83106,83095,83096,83097,83098,83099,83090,83091,83092,83093,83094,83100,83101,83102,83103,83104,83045,83047,83074,83075,83070,83071,83057,83058,83061,83062,83063,83064,83065,83066,83068,83069,83056,83046,83044,83043,83042,83041,83040,83039,83038,83037,83036,83035,83155,83154,82984,83156,82980,82981,82982,82979,82978,82977,83000,82993,82994,82995,82996,82997,82998,83001,83002,83004,83005,83006,83007,83008,83009,83010,83026,83027,83023,83022,83119,83014,83015,83138,83139,83120,83011,83012,83013,83130,83131,83132,83133,83134,83135,83136,83146,83147,83148,83149,83119,83120,83121,83122,83123,83123,83124,83125,83126,83127,83128,83129,83137,83150,82983,82988,83082,83083,83084,83085,83077,83078,83079,83080,83081,82984,83152,83151);
DELETE FROM `creature_formations` WHERE `memberguid` IN (82991,82985,83141,83142,83143,83049,83050,83051,83053,83054,83055,83021,83024,83025,83028,83048,83029,83020,83140,83030,83031,83032,83033,83034,83016,83017,83018,83019,83115,83116,83117,83118,83110,83111,83113,83114,83107,83108,83109,83112,83105,83106,83095,83096,83097,83098,83099,83090,83091,83092,83093,83094,83100,83101,83102,83103,83104,83045,83047,83074,83075,83070,83071,83057,83058,83061,83062,83063,83064,83065,83066,83068,83069,83056,83046,83044,83043,83042,83041,83040,83039,83038,83037,83036,83035,83155,83154,82984,83156,82980,82981,82982,82979,82978,82977,83000,82993,82994,82995,82996,82997,82998,83001,83002,83004,83005,83006,83007,83008,83009,83010,83026,83027,83023,83022,83119,83014,83015,83138,83139,83120,83011,83012,83013,83130,83131,83132,83133,83134,83135,83136,83146,83147,83148,83149,83119,83120,83121,83122,83123,83123,83124,83125,83126,83127,83128,83129,83137,83150,82983,82988,83082,83083,83084,83085,83077,83078,83079,83080,83081,82984,83152,83151);
INSERT INTO `creature_formations` VALUES
--
--
--
(83141,83141,100,360,2),
(83141,83142,100,360,2),
(83141,83143,100,360,2),
--
(83049,83049,100,360,2),
(83049,83050,100,360,2),
(83049,83051,100,360,2),
--
(83053,83053,100,360,2),
(83053,83054,100,360,2),
(83053,83055,100,360,2),
--
(83021,83021,100,360,2),
(83021,83024,100,360,2),
(83021,83025,100,360,2),
(83021,83028,100,360,2),
(83021,83048,100,360,2),
--
(83029,83029,100,360,2),
(83029,83020,100,360,2),
(83029,83140,100,360,2),
--
(83030,83030,100,360,2),
(83030,83031,100,360,2),
(83030,83032,100,360,2),
(83030,83033,100,360,2),
(83030,83034,100,360,2),  
--
-- 83077 82988
--
(83016,83016,100,360,2),
(83016,83017,100,360,2),
(83016,83018,100,360,2),
(83016,83019,100,360,2),
--
(83115,83115,100,360,2),
(83115,83116,100,360,2),
(83115,83117,100,360,2),
(83115,83118,100,360,2),
--
(83110,83110,100,360,2),
(83110,83111,100,360,2),
(83110,83113,100,360,2),
(83110,83114,100,360,2),

--
(83107,83107,100,360,2),
(83107,83108,100,360,2),
(83107,83109,100,360,2),
(83107,83112,100,360,2),
--
(83105,83105,100,360,2),
(83105,83106,100,360,2),
--
(83095,83095,100,360,2),
(83095,83096,100,360,2),
(83095,83097,100,360,2),
(83095,83098,100,360,2),
(83095,83099,100,360,2),
--
(83090,83090,100,360,2),
(83090,83091,100,360,2),
(83090,83092,100,360,2),
(83090,83093,100,360,2),
(83090,83094,100,360,2),
--
(83100,83100,100,360,2),
(83100,83101,100,360,2),
(83100,83102,100,360,2),
(83100,83103,100,360,2),
(83100,83104,100,360,2),
--
--
--
--
(83045,83045,100,360,2),
(83045,83047,2,2.1,2),
-- 
(83075,83075,0,0,1),
(83075,83074,0,0,1),
--
(83070,83070,0,0,1),
(83070,83071,0,0,1),
--
(83057,83057,100,360,2),
(83057,83058,100,360,2),
(83057,83061,100,360,2),
(83057,83062,100,360,2),
(83057,83063,100,360,2),
(83057,83064,100,360,2),
(83057,83065,100,360,2),
(83057,83066,100,360,2),
(83057,83068,100,360,2),
(83057,83069,100,360,2),
(83057,83056,100,360,2),
--
(83046,83046,100,360,2),
(83046,83044,100,360,2),
(83046,83043,100,360,2),
(83046,83042,100,360,2),
(83046,83041,100,360,2),
(83046,83040,100,360,2),
(83046,83039,100,360,2),
(83046,83038,100,360,2),
(83046,83037,100,360,2),
(83046,83036,100,360,2),
(83046,83035,100,360,2),
--
(83154,83154,100,360,2),
(83154,83155,100,360,2),
--
(82980,82980,100,360,2),
(82980,82981,100,360,2),
(82980,82982,100,360,2),
--
(82979,82979,100,360,2),
(82979,82978,100,360,2),
(82979,82977,100,360,2),
--
(83000,83000,100,360,2),
(83000,82993,100,360,2),
(83000,82994,100,360,2),
-- 
(82995,82995,100,360,2),
(82995,82996,100,360,2),
(82995,82997,100,360,2),
(82995,82998,100,360,2),
--
(83001,83001,100,360,2),
(83001,83002,100,360,2),
--
(83004,83004,100,360,2),
(83004,83005,100,360,2),
(83004,83006,100,360,2),
--
(83007,83007,100,360,2),
(83007,83008,100,360,2),
(83007,83009,100,360,2),
(83007,83010,100,360,2),
--
(83027,83027,100,360,2),
(83027,83026,3,1,2),
--
(83022,83022,100,360,2),
(83022,83023,3,1,2),
--
(83119,83119,100,360,2),
(83119,83014,100,360,2),
(83119,83015,100,360,2),
--
--
(83138,83138,100,360,2),
(83138,83139,100,360,2),
(83138,83120,100,360,2),
--
--
(83011,83011,100,360,2),
(83011,83012,100,360,2),
(83011,83013,100,360,2),
--
(83131,83131,100,360,2),
(83131,83132,100,360,2),
(83131,83133,100,360,2),
(83131,83134,100,360,2),
(83131,83135,100,360,2),
(83131,83136,100,360,2),
(83131,83146,100,360,2),
(83131,83147,100,360,2),
(83131,83148,100,360,2),
(83131,83149,100,360,2),
--
(83121,83121,100,360,2),
(83121,83122,100,360,2),
(83121,83123,100,360,2),
(83121,83124,100,360,2),
(83121,83125,100,360,2),
(83121,83126,100,360,2),
(83121,83127,100,360,2),
(83121,83128,100,360,2),
(83121,83129,100,360,2),
(83121,83130,100,360,2),

--
(83137,83137,100,360,2),
(83137,83150,100,360,2),
(83137,82983,100,360,2),
--
(83082,83082,100,360,2),
(83082,83083,100,360,2),
(83082,83084,100,360,2),
(83082,83085,100,360,2),
--
(83078,83078,100,360,2),
(83078,83079,100,360,2),
(83078,83080,100,360,2),
(83078,83081,100,360,2),
--
(82991,82991,0,0,1),
(82991,82985,0,0,1),
--
(83156,83156,0,0,1),
(83156,82984,0,0,1),
--
(83152,83152,0,0,1),
(83152,83151,0,0,1);
--
--
--
--
--
-- sonstiges
-- Duyash the Cruel
UPDATE `creature_template` SET `unit_flags`='33090',`flags_extra`='2' WHERE `entry` IN ('20390');
--
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/1443/the-arcatraz
--
-- texts eig anderes issue
DELETE FROM `creature_ai_texts` WHERE `entry` IN ('-21','-20','-19','-18','-17','-628','-629','-630','-631','-632','-633','-634','-635','-636','-637','-638','-639','-640','-641','-642','-643','-644','-645','-646','-647','-648','-649','-650','-651','-652','-653');
INSERT INTO `creature_ai_texts` VALUES
(-628,'What? Where in a..? Don\'t just stand around lads KILL SOMEBODY!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,13193,1,0,0,'26796'),
(-629,'Now we\re getting someplace!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,13195,1,0,0,'26796'),
(-630,'Is that all you\'ve... got?',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,13194,1,0,0,'26796'),
(-631,'What is this? Mag thorin Kar! Kill them!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,13458,1,0,0,'26798'),
(-632,'Our task is not yet done!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,13459,1,0,0,'26798'),
(-633,'GOOO!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,13460,1,0,0,'26798'),
(-634,'Life energy to... consume.',NULL,NULL,'Lebensenergie... verzehren.',NULL,NULL,NULL,NULL,NULL,11250,1,0,0,'20870'),
(-635,'The shadow... will engulf you.',NULL,NULL,'Die Schatten... werden Euch umschlingen.',NULL,NULL,NULL,NULL,NULL,11253,1,0,0,'20870'),
(-636,'Darkness...consumes...all.',NULL,NULL,'Dunkelheit... verzehrt... alles.',NULL,NULL,NULL,NULL,NULL,11254,1,0,0,'20870'),
(-637,'This vessel... is empty.',NULL,NULL,'Dieses Gefäß... ist leer.',NULL,NULL,NULL,NULL,NULL,11251,1,0,0,'20870'),
(-638,'No...more...life.',NULL,NULL,'Kein... Leben... mehr.',NULL,NULL,NULL,NULL,NULL,11252,1,0,0,'20870'),
(-639,'The void...beckons.',NULL,NULL,'Die Leere... ruft.',NULL,NULL,NULL,NULL,NULL,11255,1,0,0,'20870'),
(-640,'It is not smart to make me angry!',NULL,NULL,'Es ist nicht klug, mich wütend zu machen.',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-641,'Ahh..., much better.',NULL,NULL,'Ahh..., viel besser.',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'???'),
(-642,NULL,NULL,NULL,'Ahh... genau, was ich brauchte.',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'???'),
(-643,NULL,NULL,NULL,'Völlig ineffizient. Genau wie jemand anders den ich kenne.',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'???'),
(-644,NULL,NULL,NULL,'Ihr habt den falschen Gegner gewählt.',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'???'),
(-645,NULL,NULL,NULL,'Ich werde Euch in Stücke schneiden!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'???'),
(-646,NULL,NULL,NULL,'Erntet den Sturm!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'???'),
(-647,NULL,NULL,NULL,'Nun bin ich wirklich wütend.',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'???'),
(-648,'%s lets out a deep roar, alerting nearby allies and becoming enraged!',NULL,NULL,'%s grollt tief und alle in der Nähe befindlichen Verbündeten werden wütend!',NULL,NULL,NULL,NULL,NULL,0,2,0,0,'Dire Maul Guards'),
(-649,'%s goes into a drunken rage!',NULL,NULL,'%s verfällt betrunken, in eine Raserei!',NULL,NULL,NULL,NULL,NULL,0,2,0,0,'14322'),
(-650,'I am Scarlet Onslaught. We don\'t rat out our leaders!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29490'),
(-651,'I don\'t know where the grand admiral is. Go to hell!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29490'),
(-652,'Guards help!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29489'),
(-653,'Archbishop Landrgren must know! Aaaaaaaagggghhh.....!',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29489'),
--
(-17,'Insolent fool! You thought to steal Zelemar\'s blood? You shall pay with your own!',NULL,NULL,'Unverschämter Narr! Ihr wolltet Zelemars blut stehlen? Dafür werdet Ihr mit Eurem eigenen bezahlen!',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'17830'),
(-18,'For Victory! For Agamaggan!',NULL,NULL,'Sieg! Für Agammagan!',NULL,NULL,NULL,NULL,NULL,5812,1,0,0,'4420'),
(-19,'I\'m gonna cook ya, and then i\'m going to eat ya!',NULL,NULL,'Ich werd\' Euch kochen, dann werd\' ich Euch verspeisen!',NULL,NULL,NULL,NULL,NULL,0,0,0,1,'20905'),
(-20,'I hope you die! Painfully!',NULL,NULL,'Ich hoffe, Ihr sterbt alle... schmerzvoll!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'20905'),
(-21,'Mission accomplished.',NULL,NULL,'Mission erfüllt!',NULL,NULL,NULL,NULL,NULL,11073,1,0,0,'17976');
--
UPDATE creature_ai_texts SET content_loc3='Schnuffel ist da! Schnuffel gehört jetzt die Eisbeißermine!' WHERE entry=-654;
UPDATE creature_ai_texts SET content_loc3='Sprecht! Wo versteckt sich Euer Anführer?' WHERE entry=-655;
--
--
--
--
--
--
UPDATE `creature` SET `position_x`='-112.5076', `position_y`='-258.5599', `position_z`='-57.9743', `orientation`='2.6004',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('86047');
UPDATE `creature` SET `position_x`='-105.1697', `position_y`='-264.0008', `position_z`='-56.9552', `orientation`='3.4137',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('86048');
UPDATE `creature` SET `position_x`='-5206.0000', `position_y`='-479.0000', `position_z`='389.1181', `orientation`='2.2140',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('86176');
-- unter boden 87125
--
--
-- freie guids ab 86000: 86101 86117 86148 86177 86179 86183 bis 86200
-- freie guids ab 79400: bis 79700 
-- frei neu  
-- freie guids ab 98200: bis  98282
-- ---------------------------------------------------------
-- Fix Entropic Eye / Death Watcher Spawns (First Boss Room)
-- ---------------------------------------------------------
DELETE FROM creature WHERE guid IN (86063,79486,79481,79462,79464,79536,79579,79658,79677);
INSERT INTO creature VALUES (79462,20868,552,3,0,0,254.9104,-125.0874,-10.12324,2.890443,7200,10,0,39123,0,0,1); -- Single Entropic Eye
INSERT INTO creature VALUES (79464,20868,552,3,0,0,266.335,-187.128,-10.1051,4.02795,7200,10,0,45409,0,0,1); -- Entropic Eye (Pool 1)
INSERT INTO creature VALUES (79536,20867,552,3,0,0,266.335,-187.128,-10.1051,4.02795,7200,10,0,45409,0,0,1); -- Death Watcher (Pool 1)
INSERT INTO creature VALUES (79579,20867,552,3,0,0,215.3317,-140.6983,-10.11088,5.292313,7200,10,0,45409,0,0,1); -- Single Death Watcher
INSERT INTO creature VALUES (79658,20868,552,3,0,0,245.8474,-159.4548,-10.1040,4.38315,7200,10,0,45409,0,0,1); -- Entropic Eye (Pool 2)
INSERT INTO creature VALUES (79677,20867,552,3,0,0,245.8474,-159.4548,-10.1040,4.38315,7200,10,0,45409,0,0,1); -- Death Watcher (Pool 2)
INSERT INTO creature VALUES (79486,20868,552,3,0,0,273.3929,-138.6973,-10.1199,3.1378,7200,10,0,45409,0,0,1); -- Entropic Eye (Pool 3)
INSERT INTO creature VALUES (79481,20867,552,3,0,0,273.3929,-138.6973,-10.1199,3.1378,7200,10,0,45409,0,0,1); -- Death Watcher (Pool 3)
--
-- -------------------------------------------------------------------------------------------------------
-- Add Missing Protean Nightmare and Protean Horror Spawns in First Room
-- -------------------------------------------------------------------------------------------------------
DELETE FROM creature WHERE guid IN (79454,79456,79457,79427,79458,79459);
INSERT INTO creature VALUES (79454,20864,552,3,0,0,208.859,6.44106,-7.46839,4.26597,7200,0,0,46676,0,0,2); -- Protean Nightmare
INSERT INTO creature VALUES (79456,20865,552,3,0,0,212.562,6.48385,-7.46839,3.46093,7200,0,0,8178,0,0,0); -- Protean Horror
INSERT INTO creature VALUES (79457,20865,552,3,0,0,209.099,10.6454,-7.4684,4.9173,7200,0,0,8178,0,0,0); -- Protean Horror

-- ========================================
-- CREATURE SPAWN / MOVEMENT / LINKING DATA
-- ========================================
-- -----------------------------------------------------------------
-- Spawn All Warder Corpse and Defender Corpse NPC's From Sniff Data
-- -----------------------------------------------------------------
SET @CGUID := 98239;
DELETE FROM creature WHERE guid IN (98237,98238,98239,98240,98241,98242,98243,98244,98245,98248,98249,98250,98251,98252,98253,98254,98255,98256,98257,98258,98259,98260,98261,98262,98263,98264,98265,98266,98267,98268,98269,98270,98271,98272,98273,98274,98275,98276,98277,98278,98279,98280,98281,98282);
-- Arcatraz Warder/Defender Corpse Pool 1
INSERT INTO creature VALUES (98237,21303,552,3,0,0,197.795,-86.5381,-10.1018,5.90384,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (98238,21304,552,3,0,0,197.795,-86.5381,-10.1018,5.90384,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 2
INSERT INTO creature VALUES (98239,21303,552,3,0,0,206.3423,-98.27836,-10.02623,2.6529,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (98240,21304,552,3,0,0,206.3423,-98.27836,-10.02623,2.6529,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 3
INSERT INTO creature VALUES (98241,21303,552,3,0,0,213.6261,-161.4238,-10.0346,2.740167,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (98242,21304,552,3,0,0,213.6261,-161.4238,-10.0346,2.740167,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 4
INSERT INTO creature VALUES (98243,21303,552,3,0,0,273.4377,-64.06999,22.45336,22.45336,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (98244,21304,552,3,0,0,273.4377,-64.06999,22.45336,22.45336,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 5
INSERT INTO creature VALUES (98245,21303,552,3,0,0,270.8191,-45.47938,22.4534,4.468043,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (98248,21304,552,3,0,0,270.8191,-45.47938,22.4534,4.468043,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 6
INSERT INTO creature VALUES (@CGUID+10,21303,552,3,0,0,226.1842,-162.0961,-10.03523,0.3490658,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (@CGUID+11,21304,552,3,0,0,226.1842,-162.0961,-10.03523,0.3490658,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 7
INSERT INTO creature VALUES (@CGUID+12,21303,552,3,0,0,245.9822,-194.6173,-10.02174,0.8726646,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (@CGUID+13,21304,552,3,0,0,245.9822,-194.6173,-10.02174,0.8726646,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 8
INSERT INTO creature VALUES (@CGUID+14,21303,552,3,0,0,285.4156,127.1274,22.29513,4.694936,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (@CGUID+15,21304,552,3,0,0,285.4156,127.1274,22.29513,4.694936,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 9
INSERT INTO creature VALUES (@CGUID+16,21303,552,3,0,0,253.6892,139.8683,22.41207,2.303835,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (@CGUID+17,21304,552,3,0,0,253.6892,139.8683,22.41207,2.303835,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 10
INSERT INTO creature VALUES (@CGUID+18,21303,552,3,0,0,253.9511,155.0008,22.38065,4.939282,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (@CGUID+19,21304,552,3,0,0,253.9511,155.0008,22.38065,4.939282,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 11
INSERT INTO creature VALUES (@CGUID+20,21303,552,3,0,0,298.8479,151.7484,22.31051,5.707227,7200,0,0,20283,0,0,0); 
INSERT INTO creature VALUES (@CGUID+21,21304,552,3,0,0,298.8479,151.7484,22.31051,5.707227,7200,0,0,20283,0,0,0); 
-- Arcatraz Warder/Defender Corpse Pool 12
INSERT INTO creature VALUES (@CGUID+22,21303,552,3,0,0,306.976,141.112,22.2286,3.0285,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+23,21304,552,3,0,0,306.976,141.112,22.2286,3.0285,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 13
INSERT INTO creature VALUES (@CGUID+24,21303,552,3,0,0,272.5006,-40.19271,22.50897,2.9147,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+25,21304,552,3,0,0,272.5006,-40.19271,22.50897,2.9147,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 14
INSERT INTO creature VALUES (@CGUID+26,21303,552,3,0,0,232.7542,-198.1254,-10.02295,5.61996,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+27,21304,552,3,0,0,232.7542,-198.1254,-10.02295,5.61996,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 15
INSERT INTO creature VALUES (@CGUID+28,21303,552,3,0,0,262.5602,-65.59807,22.45336,1.500983,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+29,21304,552,3,0,0,262.5602,-65.59807,22.45336,1.500983,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 16
INSERT INTO creature VALUES (@CGUID+30,21303,552,3,0,0,312.9286,-7.190621,22.5245,4.031711,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+31,21304,552,3,0,0,312.9286,-7.190621,22.5245,4.031711,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 17
INSERT INTO creature VALUES (@CGUID+32,21303,552,3,0,0,311.1194,-5.503693,22.5245,1.570796,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+33,21304,552,3,0,0,311.1194,-5.503693,22.5245,1.570796,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 18
INSERT INTO creature VALUES (@CGUID+34,21303,552,3,0,0,293.8853,70.93681,22.52617,1.553343,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+35,21304,552,3,0,0,293.8853,70.93681,22.52617,1.553343,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 19
INSERT INTO creature VALUES (@CGUID+36,21303,552,3,0,0,291.632,70.58091,22.52693,2.007129,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+37,21304,552,3,0,0,291.632,70.58091,22.52693,2.007129,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 20
INSERT INTO creature VALUES (@CGUID+38,21303,552,3,0,0,397.0705,25.33308,48.29603,0.5235988,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+39,21304,552,3,0,0,397.0705,25.33308,48.29603,0.5235988,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 21
INSERT INTO creature VALUES (@CGUID+40,21303,552,3,0,0,392.0042,18.38568,48.29601,1.48353,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+41,21304,552,3,0,0,392.0042,18.38568,48.29601,1.48353,7200,0,0,20283,0,0,0);
-- Arcatraz Warder/Defender Corpse Pool 22
INSERT INTO creature VALUES (@CGUID+42,21303,552,3,0,0,257.3438,155.5679,22.33209,4.712389,7200,0,0,20283,0,0,0);
INSERT INTO creature VALUES (@CGUID+43,21304,552,3,0,0,257.3438,155.5679,22.33209,4.712389,7200,0,0,20283,0,0,0);

-- Pool Templates
DELETE FROM pool_template WHERE entry BETWEEN 30000 AND 30022;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30000','18','Arcatraz - Warder/Defender Corpses - Master Pool'); -- UNKNOWN MAX LIMIT FOR TOTAL IN DUNGEON TO BE SPAWNED 16
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30001','1','Arcatraz - Warder/Defender Corpses - Pool 1');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30002','1','Arcatraz - Warder/Defender Corpses - Pool 2');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30003','1','Arcatraz - Warder/Defender Corpses - Pool 3');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30004','1','Arcatraz - Warder/Defender Corpses - Pool 4');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30005','1','Arcatraz - Warder/Defender Corpses - Pool 5');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30006','1','Arcatraz - Warder/Defender Corpses - Pool 6');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30007','1','Arcatraz - Warder/Defender Corpses - Pool 7');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30008','1','Arcatraz - Warder/Defender Corpses - Pool 8');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30009','1','Arcatraz - Warder/Defender Corpses - Pool 9');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30010','1','Arcatraz - Warder/Defender Corpses - Pool 10');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30011','1','Arcatraz - Warder/Defender Corpses - Pool 11');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30012','1','Arcatraz - Warder/Defender Corpses - Pool 12');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30013','1','Arcatraz - Warder/Defender Corpses - Pool 13');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30014','1','Arcatraz - Warder/Defender Corpses - Pool 14');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30015','1','Arcatraz - Warder/Defender Corpses - Pool 15');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30016','1','Arcatraz - Warder/Defender Corpses - Pool 16');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30017','1','Arcatraz - Warder/Defender Corpses - Pool 17');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30018','1','Arcatraz - Warder/Defender Corpses - Pool 18');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30019','1','Arcatraz - Warder/Defender Corpses - Pool 19');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30020','1','Arcatraz - Warder/Defender Corpses - Pool 20');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30021','1','Arcatraz - Warder/Defender Corpses - Pool 21');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30022','1','Arcatraz - Warder/Defender Corpses - Pool 22');

-- Individual Creature Spawn Pools
DELETE FROM pool_creature WHERE pool_entry BETWEEN 30001 AND 30022;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98237,'30001','0','Arcatraz - Defender Corpse - Pool 1');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98238,'30001','0','Arcatraz - Warder Corpse - Pool 1');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98239,'30002','0','Arcatraz - Defender Corpse - Pool 2');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98240,'30002','0','Arcatraz - Warder Corpse - Pool 2');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98241,'30003','0','Arcatraz - Defender Corpse - Pool 3');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98242,'30003','0','Arcatraz - Warder Corpse - Pool 3');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98243,'30004','0','Arcatraz - Defender Corpse - Pool 4');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98244,'30004','0','Arcatraz - Warder Corpse - Pool 4');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98245,'30005','0','Arcatraz - Defender Corpse - Pool 5');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (98248,'30005','0','Arcatraz - Warder Corpse - Pool 5');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+10,'30006','0','Arcatraz - Defender Corpse - Pool 6');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+11,'30006','0','Arcatraz - Warder Corpse - Pool 6');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+12,'30007','0','Arcatraz - Defender Corpse - Pool 7');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+13,'30007','0','Arcatraz - Warder Corpse - Pool 7');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+14,'30008','0','Arcatraz - Defender Corpse - Pool 8');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+15,'30008','0','Arcatraz - Warder Corpse - Pool 8');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+16,'30009','0','Arcatraz - Defender Corpse - Pool 9');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+17,'30009','0','Arcatraz - Warder Corpse - Pool 9');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+18,'30010','0','Arcatraz - Defender Corpse - Pool 10');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+19,'30010','0','Arcatraz - Warder Corpse - Pool 10');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+20,'30011','0','Arcatraz - Defender Corpse - Pool 11');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+21,'30011','0','Arcatraz - Warder Corpse - Pool 11');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+22,'30012','0','Arcatraz - Defender Corpse - Pool 12');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+23,'30012','0','Arcatraz - Warder Corpse - Pool 12');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+24,'30013','0','Arcatraz - Defender Corpse - Pool 13');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+25,'30013','0','Arcatraz - Warder Corpse - Pool 13');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+26,'30014','0','Arcatraz - Defender Corpse - Pool 14');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+27,'30014','0','Arcatraz - Warder Corpse - Pool 14');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+28,'30015','0','Arcatraz - Defender Corpse - Pool 15');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+29,'30015','0','Arcatraz - Warder Corpse - Pool 15');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+30,'30016','0','Arcatraz - Defender Corpse - Pool 16');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+31,'30016','0','Arcatraz - Warder Corpse - Pool 16');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+32,'30017','0','Arcatraz - Defender Corpse - Pool 17');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+33,'30017','0','Arcatraz - Warder Corpse - Pool 17');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+34,'30018','0','Arcatraz - Defender Corpse - Pool 18');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+35,'30018','0','Arcatraz - Warder Corpse - Pool 18');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+36,'30019','0','Arcatraz - Defender Corpse - Pool 19');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+37,'30019','0','Arcatraz - Warder Corpse - Pool 19');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+38,'30020','0','Arcatraz - Defender Corpse - Pool 20');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+39,'30020','0','Arcatraz - Warder Corpse - Pool 20');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+40,'30021','0','Arcatraz - Defender Corpse - Pool 21');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+41,'30021','0','Arcatraz - Warder Corpse - Pool 21');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+42,'30022','0','Arcatraz - Defender Corpse - Pool 22');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (@CGUID+43,'30022','0','Arcatraz - Warder Corpse - Pool 22');

-- Master Spawn Pool
DELETE FROM pool_pool WHERE pool_id BETWEEN 30001 AND 30022;
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30001','30000','0','Arcatraz - Warder/Defender Corpses - Pool 1');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30002','30000','0','Arcatraz - Warder/Defender Corpses - Pool 2');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30003','30000','0','Arcatraz - Warder/Defender Corpses - Pool 3');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30004','30000','0','Arcatraz - Warder/Defender Corpses - Pool 4');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30005','30000','0','Arcatraz - Warder/Defender Corpses - Pool 5');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30006','30000','0','Arcatraz - Warder/Defender Corpses - Pool 6');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30007','30000','0','Arcatraz - Warder/Defender Corpses - Pool 7');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30008','30000','0','Arcatraz - Warder/Defender Corpses - Pool 8');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30009','30000','0','Arcatraz - Warder/Defender Corpses - Pool 9');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30010','30000','0','Arcatraz - Warder/Defender Corpses - Pool 10');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30011','30000','0','Arcatraz - Warder/Defender Corpses - Pool 11');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30012','30000','0','Arcatraz - Warder/Defender Corpses - Pool 12');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30013','30000','0','Arcatraz - Warder/Defender Corpses - Pool 13');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30014','30000','0','Arcatraz - Warder/Defender Corpses - Pool 14');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30015','30000','0','Arcatraz - Warder/Defender Corpses - Pool 15');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30016','30000','0','Arcatraz - Warder/Defender Corpses - Pool 16');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30017','30000','0','Arcatraz - Warder/Defender Corpses - Pool 17');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30018','30000','0','Arcatraz - Warder/Defender Corpses - Pool 18');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30019','30000','0','Arcatraz - Warder/Defender Corpses - Pool 19');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30020','30000','0','Arcatraz - Warder/Defender Corpses - Pool 20');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30021','30000','0','Arcatraz - Warder/Defender Corpses - Pool 21');
INSERT INTO `pool_pool` (`pool_id`, `mother_pool`, `chance`, `description`) VALUES ('30022','30000','0','Arcatraz - Warder/Defender Corpses - Pool 22'); 
--
DELETE FROM pool_template WHERE entry IN (30023,30024,30025);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30023','1','Arcatraz - Entropic Eye/Death Watcher - Pool 1');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30024','1','Arcatraz - Entropic Eye/Death Watcher - Pool 2');
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30025','1','Arcatraz - Entropic Eye/Death Watcher - Pool 3');
--
DELETE FROM pool_creature WHERE pool_entry IN (30023,30024,30025);
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (79464,'30023','0','Arcatraz - Entropic Eye - Pool 1');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (79536,'30023','0','Arcatraz - Death Watcher - Pool 1');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (79658,'30024','0','Arcatraz - Entropic Eye - Pool 2');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (79677,'30024','0','Arcatraz - Death Watcher - Pool 2');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (79486,'30025','0','Arcatraz - Entropic Eye - Pool 3');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (79481,'30025','0','Arcatraz - Death Watcher - Pool 3');
--
-- ------------------------------------------------------------------------------------------------------------
-- GROUP OF 6 PROTEAN HORROR'S - MOVE EXISTING SPAWNS / ADD MISSING SPAWNS / LINK SPAWNS FOR MOVEMENT AND AGGRO
-- ------------------------------------------------------------------------------------------------------------
DELETE FROM creature WHERE guid IN (79427,79458,79459,79484,79688,79694,79797,79841);
INSERT INTO creature VALUES (79427,20865,552,3,0,0,208.434,-21.0154,-10.0878,0.166969,7200,0,0,8178,0,0,2);
INSERT INTO creature VALUES (79458,20865,552,3,0,0,206.383,-20.1627,-10.0984,0.611504,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (79459,20865,552,3,0,0,207.515,-23.0306,-10.0875,0.361747,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (79484,20865,552,3,0,0,205.901,-21.77,-10.0973,0.187389,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (79688,20865,552,3,0,0,204.041,-20.9714,-10.1009,0.0931411,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (79694,20865,552,3,0,0,205.502,-23.8515,-10.0948,1.00813,7200,0,0,8178,0,0,0);
--
-- -------------------------------------------------------------------------------------------------
-- Spawn Normal / Heroic Sentinels With Proper 40% Health
-- -------------------------------------------------------------------------------------------------
-- freie guids ab 86000: 86101 86117 86148 86177 86179 86183 bis 86200
DELETE FROM `creature` WHERE guid IN (86026,86027,86028,86029,86030,86031,86032,86033,86034,86035,86054,86055,86056,86057,86058,86059,86060,86061,86062,86063);
DELETE FROM `creature_addon` WHERE `guid` IN (86026,86027,86028,86029,86030,86031,86032,86033,86034,86035,86054,86055,86056,86057,86058,86059,86060,86061,86062,86063);
-- 86026 86063 -- not sure 86027 86028 86054 86055 nonheroic 
INSERT INTO creature VALUES (86027,'20869','552','1','0','0','205.7428','105.8393','22.3192','2.2316','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86028,'20869','552','1','0','0','193.9575','105.6515','22.3190','0.8886','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86029,'20869','552','1','0','0','202.84','46.4277','48.3155','2.42562','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86030,'20869','552','1','0','0','196.555','47.0605','48.3239','1.20301','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86031,'20869','552','1','0','0','264.286','-61.3211','22.4534','5.28835','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86032,'20869','552','1','0','0','253.743','131.448','22.3164','1.05009','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86033,'20869','552','1','0','0','254.359','160.747','22.2955','5.44126','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86034,'20869','552','1','0','0','336.514','27.4267','48.426','3.83972','7200','0','0','46108','0','0','0');
INSERT INTO creature VALUES (86035,'20869','552','1','0','0','395.413','18.1948','48.296','2.49582','7200','0','0','46108','0','0','0');
-- heroic
INSERT INTO creature VALUES (86054,'20869','552','2','0','0','205.7428','105.8393','22.3192','2.2316','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86055,'20869','552','2','0','0','193.9575','105.6515','22.3190','0.8886','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86056,'20869','552','2','0','0','202.84','46.4277','48.3155','2.42562','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86057,'20869','552','2','0','0','196.555','47.0605','48.3239','1.20301','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86058,'20869','552','2','0','0','264.286','-61.3211','22.4534','5.28835','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86059,'20869','552','2','0','0','253.743','131.448','22.3164','1.05009','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86060,'20869','552','2','0','0','254.359','160.747','22.2955','5.44126','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86061,'20869','552','2','0','0','336.514','27.4267','48.426','3.83972','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86062,'20869','552','2','0','0','395.413','18.1948','48.296','2.49582','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86063,'20869','552','2','0','0','460.7652','-22.3251','48.2147','3.1702','7200','0','0','64908','0','0','0');
INSERT INTO creature VALUES (86026,'20869','552','2','0','0','430.5813','-22.2480','48.2128','6.2725','7200','0','0','64908','0','0','0');
--
-- Pool Templates
DELETE FROM pool_template WHERE entry=30027;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30027','1','Arcatraz - Eredar Soul-Eater/Eredar Deathbringer - Pool'); 
-- Individual Creature Spawn Pools
DELETE FROM pool_creature WHERE pool_entry=30027;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (15535333,'30027','0','Arcatraz - Eredar Deathbringer - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (15535334,'30027','0','Arcatraz - Eredar Soul-Eater - Pool');
DELETE FROM `creature` WHERE `guid` IN ('15535333');
INSERT INTO `creature` VALUES
(15535333,20880,552,3,0,0,306.648,150.38,24.8584,3.8182,7200,0,0,0,0,0,0);
UPDATE `creature` SET `spawntimesecs`='7200' WHERE `guid` IN ('15535334');
--
-- -------------------------------------------------------------------
-- Unbound Devastator/Spiteful Temptress Pool In Center of 2-Boss Room
-- -------------------------------------------------------------------
DELETE FROM creature WHERE guid IN (79542,86036);
INSERT INTO creature VALUES  (79542,'20883','552','3','0','0','148.05','146.994','20.8982','6.26573','7200','0','0','38553','12620','0','0');
INSERT INTO creature VALUES  (86036,'20881','552','3','0','0','148.05','146.994','20.8982','6.26573','7200','0','0','48902','0','0','0');
-- Pool Templates
DELETE FROM pool_template WHERE entry=30026;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES ('30026','1','Arcatraz - Unbound Devastator/Spiteful Temptress - Pool'); 
-- Individual Creature Spawn Pools
DELETE FROM pool_creature WHERE pool_entry=30026;
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (79542,'30026','0','Arcatraz - Spiteful Temptress - Pool');
INSERT INTO `pool_creature` (`guid`, `pool_entry`, `chance`, `description`) VALUES (86036,'30026','0','Arcatraz - Unbound Devastator - Pool');
--
-- sw guard
DELETE FROM `creature` WHERE `guid` IN ('79841');
INSERT INTO `creature` VALUES
(79841,68,0,1,0,0,-8850.9550,717.0305,97.4220,2.0260,900,0,0,6400,0,0,0);
-- -----------------------------------------------------------------
-- Fix 6 Protean Horror Placement For Pathing Around First Boss Room
-- -----------------------------------------------------------------
DELETE FROM creature WHERE guid IN (79478,79479,79480,79941,79979,80004);
INSERT INTO creature VALUES (79478,20865,552,3,0,0,213.449,-120.089,-10.1083,2.4144,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (79479,20865,552,3,0,0,216.056,-119.667,-10.1204,3.17144,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (79480,20865,552,3,0,0,217.345,-121.596,-10.1199,2.99551,7200,0,0,8178,0,0,2);
INSERT INTO creature VALUES (79941,20865,552,3,0,0,217.556,-118.237,-10.1212,3.08662,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (79979,20865,552,3,0,0,215.016,-121.252,-10.1204,3.3945,7200,0,0,8178,0,0,0);
INSERT INTO creature VALUES (80004,20865,552,3,0,0,214.844,-118.252,-10.1188,2.43393,7200,0,0,8178,0,0,0);
--
--
--
--
--
--
--
-- general enslave immunity for demons on arcatraz
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|'1' WHERE `entry` IN (20866,21614,20867,21591,20870,21626,20873,21605,20875,21604,20879,21595,20880,21594,20881,21619,20882,21613,20883,21615,20885,21590,20898,21598,20900,21621,20901,21610,20902,21611);
--
-- Event Grp at Start
UPDATE `creature` SET `spawntimesecs`='120' WHERE `guid` IN (79402,79403,79401,79410,79413);
-- Arcatraz Defender
UPDATE `creature` SET `spawntimesecs`='1200' WHERE `id` IN ('20857');
UPDATE `creature_template` SET `speed`='1.48',`flags_extra`='0' WHERE `entry` IN ('20857'); -- 33554432
UPDATE `creature_template` SET `speed`='1.48',`pickpocketloot`='20857',`minlevel`='68',`maxlevel`='69',`mindmg`='3021',`maxdmg`='3589',`flags_extra`='0' WHERE `entry` IN ('21585'); -- 814 1665 33554432
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='15' WHERE `creature_id` IN ('21585');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21585');
INSERT INTO `creature_template_addon` VALUES
(21585  ,0  ,0  ,16777472   ,0  ,4097,  333,    0   ,'');
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('20857');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20857');
INSERT INTO `creature_ai_scripts` VALUES
('2085701','20857','11','0','100','6','0','0','0','0','11','38805','0','1','0','0','0','0','0','0','0','0','Arcatraz Defender  - Cast Immolate on Spawn'),
('2085702','20857','9','0','100','7','0','5','2000','4000','11','38804','1','0','0','0','0','0','0','0','0','0','Arcatraz Defender  - Cast Flaming Weapon');
-- ('2085703','20857','2','0','100','7','40','0','1000','1000','11','40449','1','1','0','0','0','0','0','0','0','0','Arcatraz Defender  - Cast Protean Subdual');
--
UPDATE `creature` SET `position_x`='81.8500', `position_y`='0.1146', `position_z`='-11.0280', `orientation`='0',`spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79399');
UPDATE `creature` SET `position_x`='81.9808', `position_y`='-3.8452', `position_z`='-11.0508', `orientation`='0',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('79395');
UPDATE `creature` SET `position_x`='81.7220', `position_y`='3.9905', `position_z`='-11.0475', `orientation`='0',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('79400');
--
-- Arcane Warder Target
-- Fix Arcane Warder Target To Allow Aggro and Stay Rooted (NPC Will target Them and Warders Will Target These For Visual AOE Attack)
UPDATE `creature_template` SET `faction_A`='1692',`faction_H`='1692',`dynamicflags`='0',`flags_extra`='128',`unit_flags`='0' WHERE `entry` IN ('21186'); -- 1692 0 130 33554688
UPDATE `creature` SET `position_x`='107.1377', `position_y`='0.0697', `position_z`='-10.1713', `orientation`='0',`spawndist`='5',`movementtype`='1',`spawntimesecs`='10' WHERE `guid` IN ('79407'); 
UPDATE `creature` SET `position_x`='107.1377', `position_y`='0.0697', `position_z`='-10.1713', `orientation`='0',`spawndist`='5',`movementtype`='1',`spawntimesecs`='10' WHERE `guid` IN ('79408');
UPDATE `creature` SET `position_x`='107.1377', `position_y`='0.0697', `position_z`='-10.1713', `orientation`='0',`spawndist`='5',`movementtype`='1',`spawntimesecs`='10' WHERE `guid` IN ('79409');
--
-- Arcatraz Warder 20859 21587
UPDATE `creature` SET `spawntimesecs`='1200' WHERE `id` IN ('20859');
UPDATE `creature_template` SET `AIName`='EventAI',`speed`='1.48' WHERE `entry` IN ('20859');
UPDATE `creature_template` SET `modelid_H`='19994',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='20859',`mindmg`='3021',`maxdmg`='3589' WHERE `entry` IN ('21587'); -- 814 1665
DELETE FROM `creature_addon` WHERE `guid` IN ('79393');
UPDATE `creature_template_addon` SET `bytes0`='512' WHERE `entry` IN ('20859'); -- 66048
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21587');
INSERT INTO `creature_template_addon` VALUES
(21587,0,0,66048,0,4098,376,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20859');
INSERT INTO `creature_ai_scripts` VALUES
('2085900','20859','0','0','100','7','4000','4000','4000','4000','21','1','0','0','40','1','0','0','20','1','0','0','Arcatraz Warder - Start Combat Movement and Start Melee'),
('2085901','20859','11','0','100','6','0','0','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Arcatraz Warder - Prevent Combat Movement on Spawn'), 
('2085902','20859','1','0','100','7','1000','3000','5000','10000','11','36327','0','0','40','2','0','0','0','0','0','0','Arcatraz Warder - Cast Shoot Arcane Explosion Arrow and Set Ranged Weapon Model OOC'), -- 36327 has to be set to target Arcane Warder Target.
('2085903','20859','4','0','100','7','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Arcatraz Warder - Set Phase 1 on Aggro'), 
('2085904','20859','9','1','100','3','5','30','2000','2000','11','22907','1','0','40','2','0','0','21','0','0','0','Arcatraz Warder (Normal) - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2085905','20859','9','1','100','5','5','30','2000','2000','11','38940','1','0','40','2','0','0','21','0','0','0','Arcatraz Warder (Heroic) - Cast Shoot and Set Ranged Weapon Model and Stop Movement(Phase 1)'),
('2085906','20859','9','0','100','6','0','5','1000','1000','21','1','0','0','22','0','0','0','40','1','0','0','Arcatraz Warder - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 5 Yards'),
('2085907','20859','21','0','100','6','0','0','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Arcatraz Warder - Prevent Combat Movement on Reaching Home after Evade'),
('2085908','20859','9','0','100','1','0','5','16000','21000','11','35963','1','1','0','0','0','0','0','0','0','0','Arcatraz Warder - Cast Improved Wing Clip'),
('2085909','20859','0','1','100','3','5000','5000','10000','10000','11','36608','1','0','40','2','0','0','21','0','0','0','Arcatraz Warder (Normal) - Cast Charged Arcane Shot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2085910','20859','0','1','100','5','5000','5000','10000','10000','11','38808','1','0','40','2','0','0','21','0','0','0','Arcatraz Warder (Heroic) - Cast Charged Arcane Shot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2085911','20859','9','0','100','7','5','15','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Arcatraz Warder - Stop Combat Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');
--
-- Arcane Warders Target Arcane Warder Target
INSERT IGNORE INTO `spell_script_target` (`entry`, `type`, `targetEntry`) values ('36327','1','21186');
--
--
-- Protean Nightmare 20864 21608
UPDATE `creature_template` SET `AIName`='EventAI',`armor`='7100',`speed`='1.71',`mindmg`='1295 ',`maxdmg`='1882',`baseattacktime`='1400' WHERE `entry` IN ('20864'); -- 237 404  718 885
UPDATE `creature_template` SET `armor`='7100',`speed`='1.71',`mindmg`='3124',`maxdmg`='3961',`baseattacktime`='0',`unit_flags`=`unit_flags`|'64'|'524288' WHERE `entry` IN ('21608'); -- 295 955 1447 1887
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21608');
INSERT INTO `creature_template_addon` VALUES
(21608, 0,  0,  16908544,   0,  4097,   0,  0   ,'');
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry` IN ('20864');
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20864'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21608'); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20864');
INSERT INTO `creature_ai_scripts` VALUES
('2086401','20864','9','0','100','7','0','10','10900','22900','11','36622','4','33','0','0','0','0','0','0','0','0','Protean Nightmare  - Cast Incubation'), -- 36612
('2086402','20864','9','0','100','3','0','5','12000','15000','11','36617','1','33','0','0','0','0','0','0','0','0','Protean Nightmare (Normal)  - Cast Gaping Maw'), 
('2086403','20864','9','0','100','5','0','5','12000','15000','11','38810','1','33','0','0','0','0','0','0','0','0','Protean Nightmare (Heroic)  - Cast Gaping Maw'),
('2086404','20864','0','0','100','3','5000','10000','8000','12000','11','36619','4','1','0','0','0','0','0','0','0','0','Protean Nightmare (Normal)  - Cast Infectious Poison'),
('2086405','20864','0','0','100','5','5000','10000','8000','12000','11','38811','4','1','0','0','0','0','0','0','0','0','Protean Nightmare (Heroic)  - Cast Infectious Poison');
-- 79402 79444 79452 creature_addon
--
--
-- Protean Spawn 21395 21609
UPDATE `creature_template` SET `armor`='5500',`speed`='1.20',`mindmg`='300',`maxdmg`='500' WHERE `entry` IN ('21395'); -- 184 330 570 716
UPDATE `creature_template` SET `armor`='6100',`mindmg`='500',`maxdmg`='700' WHERE `entry` IN ('21609'); -- 284 430 764 861
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='0' WHERE `creature_id` IN ('21395'); -- 24
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21609');
INSERT INTO `creature_onkill_reputation` VALUES
(21609,935,0,7,0,0,0,0,0,0); -- 30
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21608');
INSERT INTO `creature_template_addon` VALUES
(21608,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21395');
INSERT INTO `creature_ai_scripts` VALUES
('2139501','21395','9','0','100','7','0','5','8000','12000','11','36796','1','0','0','0','0','0','0','0','0','0','Protean Spawn - Cast Acidic Bite'),
('2139502','21395','11','0','100','7','0','0','0','0','103','24','0','0','0','0','0','0','0','0','0','0','Protean Spawn - Attack on Spawn');
--
--
-- Protean Horror 20865 21607
UPDATE `creature_template` SET `armor`='5500',`speed`='1.48',`mindmg`='500',`maxdmg`='1000',`baseattacktime`='1400' WHERE `entry` IN ('20865'); -- 342 929   718 885
UPDATE `creature_template` SET `armor`='5800',`speed`='1.48',`mindmg`='1000',`maxdmg`='1500',`baseattacktime`='0',`unit_flags`='524352' WHERE `entry` IN ('21607'); -- 701 1956 1447 1887
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21607');
INSERT INTO `creature_template_addon` VALUES
(21607,0,0,16908544,0,4097,0,0,'');
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='5' WHERE `creature_id` IN ('20865'); -- 12 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='10' WHERE `creature_id` IN ('21607'); -- 24 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20865');
INSERT INTO `creature_ai_scripts` VALUES
('2086501','20865','9','0','100','7','0','5','4000','8000','11','36612','1','1','0','0','0','0','0','0','0','0','Protean Horror  - Cast Toothy Bite');
--
--
-- Soul Devourer 20866 21614
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='2466',`maxdmg`='3250',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20866'); -- 751 1535
UPDATE `creature_template` SET `speed`='1.48',`unit_flags`='64',`mindmg`='8694',`maxdmg`='10371',`skinloot`='70162',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21614'); -- 2317 4832
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21614');
INSERT INTO `creature_template_addon` VALUES
(21614,0,0,16908544,0,4097,0,0,'');
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20866'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21614'); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20866');
INSERT INTO `creature_ai_scripts` VALUES
('2086601','20866','9','0','100','3','0','5','8000','12000','11','36654','0','0','0','0','0','0','0','0','0','0','Soul Devourer (Normal)  - Cast Fel Breath'),
('2086602','20866','9','0','100','5','0','5','5000','10000','11','38813','0','0','0','0','0','0','0','0','0','0','Soul Devourer (Heroic)  - Cast Fel Breath'),
('2086603','20866','0','0','100','6','5000','5000','10000','10000','11','36644','0','1','0','0','0','0','0','0','0','0','Soul Devourer  - Cast Sightless Eye'),
('2086604','20866','2','0','100','6','30','0','0','0','11','33958','0','1','0','0','0','0','0','0','0','0','Soul Devourer - Cast Enrage at 30% HP');
--
-- Sightless Eye 21346 21612
UPDATE `creature_template` SET `speed`='1.20' WHERE `entry` IN ('21346');
UPDATE `creature_template` SET `armor`='6792',`unit_flags`='524288' WHERE `entry` IN ('21612');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21612');
INSERT INTO `creature_template_addon` VALUES
(21612,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21346');
INSERT INTO `creature_ai_scripts` VALUES
('2134601','21346','9','0','100','3','0','5','2000','2000','11','36646','4','33','0','0','0','0','0','0','0','0','Sightless Eye (Normal) - Cast Sightless Touch'),
('2134602','21346','9','0','100','5','0','5','2000','2000','11','38815','4','33','0','0','0','0','0','0','0','0','Sightless Eye (Heroic) - Cast Sightless Touch'),
('2134603','21346','11','0','100','7','0','0','0','0','103','24','0','0','0','0','0','0','0','0','0','0','Sightless Eye - Attack on Spawn'),
('2134604','21346','7','0','100','7','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Sightless Eye - Despawn on Evade');
--
-- Death Watcher 20867 21591 
-- 79481 79486 86063
UPDATE `creature_template` SET `mindmg`='2466',`maxdmg`='3250' WHERE `entry` IN ('20867');  -- 751 1535
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6686',`maxdmg`='7941',`unit_flags`='64' WHERE `entry` IN ('21591'); -- 1802 3684
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21591');
INSERT INTO `creature_template_addon` VALUES
(21591,0,0,16777472,0,4097,0,0,'');
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20867'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21591'); -- 30
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` IN ('20867');
INSERT INTO `creature_ai_scripts` (`id`,`entryOrGUID`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
('2086701','20867','9','0','100','3','0','5','6000','8000','11','36664','4','0','0','0','0','0','0','0','0','0','Death Watcher (Normal) - Cast Tentacle Cleave'),
('2086702','20867','9','0','100','5','0','5','4000','7000','11','38816','4','0','0','0','0','0','0','0','0','0','Death Watcher (Heroic) - Cast Tentacle Cleave'),
('2086703','20867','2','0','100','3','70','0','15000','15000','11','36655','4','0','0','0','0','0','0','0','0','0','Death Watcher (Normal) - Cast Drain Life When Below 70% HP'),
('2086704','20867','2','0','100','5','70','0','12000','15000','11','38817','4','0','0','0','0','0','0','0','0','0','Death Watcher (Heroic) - Cast Drain Life When Below 70% HP'),
('2086705','20867','2','0','100','3','50','0','15500','15500','11','36657','0','1','11','36655','4','1','0','0','0','0','Death Watcher (Normal) - Cast Death Count and Drain Life When Health Below 50% HP'),
('2086706','20867','2','0','100','5','50','0','15500','15500','11','38818','0','1','11','38817','4','1','0','0','0','0','Death Watcher (Heroic) - Cast Death Count and Drain Life When Health Below 50% HP');
--
-- Entropic Eye 20868 21593
UPDATE `creature_template` SET `armor`='6800',`mindmg`='2466',`maxdmg`='3250' WHERE `entry` IN ('20868'); --  751 1535
UPDATE `creature_template` SET `minhealth`='56203',`maxhealth`='56203',`armor`='7792',`speed`='1.71',`mindmg`='6686',`maxdmg`='7941',`lootid`='21591',`minmana`='12620',`maxmana`='12620' WHERE `entry` IN ('21593'); -- 1802 3684
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20868','21593');
INSERT INTO `creature_template_addon` VALUES
(20868,0,0,16777472,0,4097,0,0,''),
(21593,0,0,16777472,0,4097,0,0,'');
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20868'); -- 24
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21593');
INSERT INTO `creature_onkill_reputation` VALUES
(21593,935,0,7,0,0,0,0,0,0); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20868');
INSERT INTO `creature_ai_scripts` VALUES
('2086801','20868','9','0','100','7','0','20','14000','17000','11','36677','4','1','0','0','0','0','0','0','0','0','Entropic Eye - Cast Chaos Breath'),
('2086802','20868','9','0','100','3','0','5','6000','8000','11','36664','4','0','0','0','0','0','0','0','0','0','Entropic Eye (Normal) - Cast Tentacle Cleave'),
('2086803','20868','9','0','100','5','0','5','4000','7000','11','38816','4','0','0','0','0','0','0','0','0','0','Entropic Eye (Heroic) - Cast Tentacle Cleave'),
('2086804','20868','6','0','100','3','0','0','0','0','11','36712','4','1','0','0','0','0','0','0','0','0','Entropic Eye (Heroic) - Cast Arcane Nova on Death'),
('2086805','20868','6','0','100','5','0','0','0','0','11','38823','4','1','0','0','0','0','0','0','0','0','Entropic Eye (Heroic) - Cast Arcane Nova on Death');
--
-- Defender Corpse 21303 21592
UPDATE `creature_template` SET `minhealth`='16200',`maxhealth`='16200',`AIName`='EventAI' WHERE `entry` IN ('21303');
UPDATE `creature_template` SET `minhealth`='22227',`maxhealth`='22227' WHERE `entry` IN ('21592');
UPDATE `creature_template_addon` SET `bytes1`='7',`auras`='' WHERE `entry` IN ('21303','21592');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21303');
INSERT INTO `creature_ai_scripts` VALUES      
('2130301','21303','10','0','100','6','0','8','0','0','11','36593','0','7','37','0','0','0','0','0','0','0','Defender Corpse - Cast Corpse Burst and Die on 8 Yards LOS'),
('2130302','21303','4','0','100','6','0','0','0','0','11','36593','0','7','37','0','0','0','0','0','0','0','Defender Corpse - Cast Corpse Burst and Die on Aggro');
--
-- Warder Corpse 21304 21623
UPDATE `creature_template` SET `ScriptName`='',`AIName`='EventAI',`flags_extra`='0' WHERE `entry` IN ('21304'); -- warder_corpse 2
UPDATE `creature_template` SET `dynamicflags`='' WHERE `entry` IN ('21623');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21304','21623');
INSERT INTO `creature_template_addon` VALUES
(21304,0,0,16777472,7,4097,0,0,''), -- 29266 0 29266 1
(21623,0,0,16777472,7,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21304');
INSERT INTO `creature_ai_scripts` VALUES
('2130401','21304','10','0','100','6','0','8','0','0','11','36593','0','7','37','0','0','0','0','0','0','0','Warder Corpse - Cast Corpse Burst and Die on 8 Yards LOS'),
('2130402','21304','4','0','100','6','0','0','0','0','11','36593','0','7','37','0','0','0','0','0','0','0','Defender Corpse - Cast Corpse Burst and Die on Aggro');
--
-- Eredar Soul-Eater 20879 21595
UPDATE `creature_template` SET `equipment_id`='4001',`mindmg`='2287',`maxdmg`='3013',`baseattacktime`='1800' WHERE `entry` IN ('20879'); -- 697 1423
UPDATE `creature_template` SET `equipment_id`='4001',`speed`='1.71',`mindmg`='5974',`maxdmg`='7091',`baseattacktime`='0',`pickpocketloot`='20879' WHERE `entry` IN ('21595'); -- 4200-5800 5974-7091 8961-10637
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20879'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21595'); -- 30
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20879','21595');
INSERT INTO `creature_template_addon` VALUES
(20879,0,0,512,0,4097,0,0,'36784 0 36784 1 36784 2 36784 3'),
(21595,0,0,512,0,4097,0,0,'36784 0 36784 1 36784 2 36784 3');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20879');
INSERT INTO `creature_ai_scripts` VALUES
('2087901','20879','1','0','100','7','1000','1000','12000','15000','11','36784','0','7','0','0','0','0','0','0','0','0','Eredar Soul-Eater - Cast Entropic Aura and Frost Armor on Spawn'),
('2087902','20879','9','0','100','7','0','5','10000','17000','11','36778','4','32','0','0','0','0','0','0','0','0','Eredar Soul-Eater - Cast Soul Steal'),
('2087903','20879','0','0','100','3','6000','15000','12000','18000','11','36786','0','0','0','0','0','0','0','0','0','0','Eredar Soul-Eater (Normal) - Cast Soul Chill'),
('2087904','20879','0','0','100','5','6000','10000','11000','16000','11','38843','0','0','0','0','0','0','0','0','0','0','Eredar Soul-Eater (Heroic) - Cast Soul Chill');
--
--
UPDATE `creature` SET `position_x`='285.5186', `position_y`='146.1547', `position_z`='22.31179', `orientation`='5.794493',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('86053');
UPDATE `creature` SET `orientation`='1.541828' WHERE `guid` IN ('15538078');
--
--
-- Eredar Deathbringer 20880 21594
UPDATE `creature_template` SET `equipment_id`='1476',`armor`='6800',`mindmg`='3431',`maxdmg`='4520',`baseattacktime`='2000' WHERE `entry` IN ('20880'); -- 1046 2135
UPDATE `creature_template` SET `equipment_id`='1476',`armor`='6800',`speed`='1.71',`mindmg`='6893',`maxdmg`='8183 ',`baseattacktime`='0' WHERE `entry` IN ('21594'); -- 2789-5692 5800-7000 6893-8183 10340-12275
UPDATE `creature_template_addon` SET `auras`='' WHERE `entry` IN ('20880','21594'); -- 27987 0 ; 38844 0
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20880');
INSERT INTO `creature_ai_scripts` VALUES
('2088001','20880','11','0','100','2','0','0','0','0','11','27987','0','1','0','0','0','0','0','0','0','0','Eredar Deathbringer (Normal) - Cast Unholy Aura on Spawn'),
('2088002','20880','11','0','100','4','0','0','0','0','11','38844','0','1','0','0','0','0','0','0','0','0','Eredar Deathbringer (Heroic) - Cast Unholy Aura on Spawn'),
('2088003','20880','9','0','100','3','0','5','10000','16000','11','36787','1','0','0','0','0','0','0','0','0','0','Eredar Deathbringer (Normal) - Cast Forceful Cleave'),
('2088004','20880','9','0','100','5','0','5','8000','14000','11','38846','1','0','0','0','0','0','0','0','0','0','Eredar Deathbringer (Heroic) - Cast Forceful Cleave'),
('2088005','20880','9','0','100','3','0','5','9000','11000','11','36789','1','0','0','0','0','0','0','0','0','0','Eredar Deathbringer (Normal) - Cast Diminish Soul'),
('2088006','20880','9','0','100','5','0','5','6000','9000','11','38848','1','0','0','0','0','0','0','0','0','0','Eredar Deathbringer (Heroic) - Cast Diminish Soul');
--
--
--
--
--
-- Fix Arcatraz Sentinel (Still Need To Make It Change Template Too)
-- recheck immunities ( fear etc )
-- Arcatraz Sentinel 20869 21586
UPDATE `creature` SET `curhealth`='64907' WHERE `id` IN ('20869');
UPDATE `creature_template` SET `dynamicflags`='0',`unit_flags`='536870976',`RegenHealth`='0',`speed`='1.48',`ScriptName`='',`mindmg`='2137',`maxdmg`='2817',`flags_extra`=`flags_extra`|'65536'|'33554432' WHERE `entry` IN ('20869'); -- arcatraz_sentinel 651 1331
UPDATE `creature_template` SET `dynamicflags`='0',`unit_flags`='536870976',`RegenHealth`='0',`speed`='1.48',`ScriptName`='',`mindmg`='5000',`maxdmg`='6000',`lootid`='20869',`flags_extra`=`flags_extra`|'65536'|'33554432' WHERE `entry` IN ('21586'); -- arcatraz_sentinel 1802 3684 6686 7941
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20869','21586');
INSERT INTO `creature_template_addon` VALUES
(20869,0,0,0,0,4097,0,0,''),
(21586,0,0,0,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20869');
INSERT INTO `creature_ai_scripts` VALUES
('2086901','20869','11','0','100','6','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Set Phase 0 on Spawn'),
('2086902','20869','1','0','100','2','1000','1000','0','0','11','36716','0','0','42','1','1','0','0','0','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge and Set Min Health At 1% on Spawn'),
('2086903','20869','1','0','100','4','1000','1000','0','0','11','38828','0','0','42','1','1','0','0','0','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge and Set Min Health At 1% on Spawn'),
('2086904','20869','1','0','100','6','2000','2000','0','0','11','31261','0','0','22','0','0','0','0','0','0','0','Arcatraz Sentinel - Cast Permanent Feign Death (Root) on Spawn'),
('2086905','20869','4','0','100','7','0','0','0','0','28','0','31261','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Remove Permanent Feign Death (Root) on Aggro'),
('2086906','20869','0','0','100','2','1000','2000','0','0','28','0','36716','0','22','1','0','0','0','0','0','0','Arcatraz Sentinel (Normal) - Remove Energy Discharge and Set Phase 1'),
('2086907','20869','0','0','100','4','1000','2000','0','0','28','0','38828','0','22','1','0','0','0','0','0','0','Arcatraz Sentinel (Heroic) - Remove Energy Discharge and Set Phase 1'),
('2086908','20869','9','13','100','3','0','15','1000','3000','11','36717','4','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge (Phase 1)'),
('2086909','20869','9','13','100','5','0','15','1000','3000','11','38829','4','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge (Phase 1)'),
-- the hp values where he transforms seems to produce the nonkillable bug so increasing the value to 15% in both mods ( befor 16/10)
('2086910','20869','2','13','100','2','15','0','0','0','11','36716','0','7','36','21761','0','0','22','2','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge and Transform into Destroyed Sentinel and Set Phase 2 at 15% HP (Phase 1)'),
('2086911','20869','2','13','100','4','15','0','0','0','11','38828','0','7','36','21761','0','0','22','2','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge and Transform into Destroyed Sentinel and Set Phase 2 at 15% HP (Phase 1)'),
('2086912','20869','0','11','100','7','500','500','500','500','21','0','0','0','103','20','0','0','22','3','0','0','Arcatraz Sentinel - Prevent Combat Movement and Attack Random and Set Phase 3 (Phase 2)'),
('2086913','20869','0','7','100','2','10','10','1000','1000','11','36719','0','6','11','36716','0','39','20','0','0','0','Arcatraz Sentinel (Normal) - Remove Energy Discharge and Cast Explode and Prevent Melee (Phase 3)'), -- 28 0 36717
('2086914','20869','0','7','100','4','10','10','1000','1000','11','38830','0','6','11','38828','0','39','20','0','0','0','Arcatraz Sentinel (Heroic) - Remove Energy Discharge and Cast Explode and Prevent Melee (Phase 3)'), -- 28 0 38828
('2086915','20869','0','7','100','7','10','10','10','10','11','20','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Aggro Pulse Out of Combat (Phase 3)'),
('2086916','20869','21','0','100','2','0','0','0','0','11','36716','0','7','42','1','1','0','22','0','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge and Set Min Health At 1% on Return Home'),
('2086917','20869','21','0','100','4','0','0','0','0','11','38828','0','7','42','1','1','0','22','0','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge and Set Min Health At 1% on Return Home'),
('2086918','20869','0','0','100','7','5000','10000','8000','12000','14','-99','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Random Aggro Wipe'),
('2086919','20869','7','0','100','2','0','0','0','0','36','20869','0','0','22','0','0','0','42','0','0','0','Arcatraz Sentinel (Normal) - Transform into Arcatraz Sentinel and Set Phase 0 and Disable INVINCIBILITY on Evade'),
('2086920','20869','7','0','100','4','0','0','0','0','36','21586','0','0','22','0','0','0','42','0','0','0','Arcatraz Sentinel (Heroic) - Transform into Arcatraz Sentinel and Set Phase 0 and Disable INVINCIBILITY on Evade'),
('2086921','20869','7','0','100','6','0','0','0','0','21','1','0','0','22','1','0','0','28','0','46416','0','Arcatraz Sentinel - Start Movement and Start Melee and Remove Stun on Evade'),
('2086922','20869','0','7','100','6','8000','8000','0','0','33','20869','6','0','11','46416','0','7','0','0','0','0','Arcatraz Sentinel - Give Quest Kill Credit and Selfstun (Phase 3)'),
('2086923','20869','0','7','100','6','20000','30000','0','0','37','0','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Kill Self after Explode(Phase 3)');
--
-- Destroyed Sentinel 21761
UPDATE `creature_template` SET `modelid_A`='19971',`modelid_H`='19971',`dynamicflags`='8',`armor`='0',`faction_A`='14',`faction_H`='14',`unit_flags`='262148',`flags_extra`='0',`mindmg`='2137',`maxdmg`='2817',`lootid`='20869',`flags_extra`=`flags_extra`|'65536'|'33554432' WHERE `entry` IN ('21761'); -- 19971 `unit_flags`|'256'|'512'|'33554432'|'4'|'262144' -> 33555200
--
-- UPDATE creature_template_addon SET auras='' WHERE entry IN (21761);
--
-- Negaton Screamer 20875 21604
UPDATE `creature` SET `spawndist`='5',`movementtype`='1' WHERE `id` IN ('20875');
UPDATE `creature_template` SET `mindmg`='2135',`maxdmg`='2812',`mechanic_immune_mask`='113906003',`faction_A`='1693',`faction_H`='1693' WHERE `entry` IN ('20875'); -- 651 1328
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='3686',`maxdmg`='4274',`unit_flags`='64',`mechanic_immune_mask`='113906003',`faction_A`='1693',`faction_H`='1693' WHERE `entry` IN ('21604'); -- 1052 1934
UPDATE `creature_ai_scripts` SET `event_param3`='4000',`event_param4`='4000' WHERE `id` IN (2087508,2087509,2087510,2087511,2087512,2087513,2087514,2087515,2087516,2087517,2087518,2087519,2087520,2087521,2087522,2087523,2087524,2087525);
--
-- Negaton Warp-Master 20873 21605
UPDATE `creature_template` SET `mindmg`='3164',`maxdmg`='4170',`unit_flags`='0',`AIName`='EventAI',`faction_A`='1693',`faction_H`='1693' WHERE `entry` IN ('20873');  -- 964 1970
UPDATE `creature_template` SET `speed`='1.71',`unit_flags`='0',`mindmg`='5019',`maxdmg`='5607',`spell1` = '36813',`faction_A`='1693',`faction_H`='1693' WHERE `entry` IN ('21605'); -- 1552 2434
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21605');
INSERT INTO `creature_template_addon` VALUES
(21605,0,0,16908544,0,4097,0,0,''); 
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20873'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21605'); -- 30
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` IN ('20873');
INSERT INTO `creature_ai_scripts` (`id`,`entryOrGUID`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES    
('2087301','20873','9','0','100','3','0','5','4000','8000','11','36813','0','3','0','0','0','0','0','0','0','0','Negaton Warp-Master - Summon Negaton Field'),
('2087302','20873','9','0','100','5','0','5','3000','6000','11','36813','0','3','0','0','0','0','0','0','0','0','Negaton Warp-Master - Summon Negaton Field');
--
-- Negaton Field 21414 21603
UPDATE `creature_template` SET `unit_flags`='33554688' WHERE `entry` IN ('21414'); -- 33554432
UPDATE `creature_template` SET `unit_flags`='33554688' WHERE `entry` IN ('21603');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21603');
INSERT INTO `creature_template_addon` VALUES
(21603,0,0,16908544,0,4097,0,0,'38833 0');
-- ('2141401','21414','11','0','100','3','0','0','0','0','11','36728','0','23','41','6000','0','0','0','0','0','0','Negaton Field (Normal) - Cast Negaton Field and Delayed Despawn on Spawn'),
-- ('2141402','21414','11','0','100','5','0','0','0','0','11','38833','0','23','41','6000','0','0','0','0','0','0','Negaton Field (Heroic) - Cast Negaton Field and Delayed Despawn on Spawn');
--
-- Skulking Witch 20882 21613
-- repos one stealthy one
UPDATE `creature` SET `position_x`='190.3266', `position_y`='146.8560', `position_z`='22.4398', `orientation`='0.0157',`spawndist`='15',`movementtype`='1' WHERE `guid` IN ('79549');
--
UPDATE `creature_template` SET `AIName`='EventAI',`mindmg`='2466',`maxdmg`='3250',`baseattacktime`='1400' WHERE `entry` = '20882';  -- 751 1535
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='4600',`maxdmg`='5800',`baseattacktime`='0',`pickpocketloot`='20882' WHERE `entry` IN ('21613'); -- 2317 4832 13041 - 15556
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20873'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21605'); -- 30
DELETE from `creature_ai_scripts` WHERE `entryOrGUID` ='20882';
INSERT INTO `creature_ai_scripts` (`id`,`entryOrGUID`,`event_type`,`event_inverse_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`action1_type`,`action1_param1`,`action1_param2`,`action1_param3`,`action2_type`,`action2_param1`,`action2_param2`,`action2_param3`,`action3_type`,`action3_param1`,`action3_param2`,`action3_param3`,`comment`) VALUES
('2088201','20882','11','0','100','7','0','0','0','0','11','16380','0','1','0','0','0','0','0','0','0','0','Skulking Witch - Cast Greater Invisibility on Spawn'),
('2088202','20882','9','0','100','7','0','10','0','0','28','0','16380','0','0','0','0','0','0','0','0','0','Skulking Witch - Remove Greater Invisibility on 10 Yards Range IC'),
('2088203','20882','0','0','100','7','6000','12000','8000','13000','11','36862','4','1','13','-50','4','0','0','0','0','0','Skulking Witch - Cast Gouge'),
('2088204','20882','9','0','50','3','0','5','14000','21000','11','36863','1','0','0','0','0','0','0','0','0','0','Skulking Witch (Normal) - Cast Chastise'),
('2088205','20882','9','0','50','5','0','5','14000','18000','11','38851','1','0','0','0','0','0','0','0','0','0','Skulking Witch (Heroic) - Cast Chastise'),
('2088206','20882','9','0','50','3','0','5','14000','21000','11','36864','4','0','0','0','0','0','0','0','0','0','Skulking Witch (Normal) - Cast Lash of Pain'),
('2088207','20882','9','0','50','5','0','5','14000','18000','11','38852','4','0','0','0','0','0','0','0','0','0','Skulking Witch (Heroic) - Cast Lash of Pain'),
('2088208','20882','7','0','100','7','0','0','0','0','11','16380','0','1','0','0','0','0','0','0','0','0','Skulking Witch - Cast Greater Invisibility on Evade');
--
-- Spiteful Temptress 20883 21615  
-- taunt immune
UPDATE `creature_template` SET `mindmg`='1628',`maxdmg`='2712',`baseattacktime`='1400',`flags_extra` = flags_extra|'65536' WHERE `entry` IN ('20883'); -- 326 1410
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='3800',`maxdmg`='4800',`baseattacktime`='0',`unit_flags`='32832',`pickpocketloot`='20883',`flags_extra` = flags_extra|'65536' WHERE `entry` IN ('21615'); -- 2317 4832 13041 - 15556
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21615');
INSERT INTO `creature_template_addon` VALUES
(21615,0,0,66048,0,4097,0,0,'');
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20883'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21615'); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20883');
INSERT INTO `creature_ai_scripts` VALUES
('2088301','20883','9','0','100','7','0','10','8000','12000','11','36886','4','1','0','0','0','0','0','0','0','0','Spiteful Temptress - Cast Spiteful Fury'),
('2088302','20883','9','0','100','7','0','5','10000','12000','11','36866','4','1','0','0','0','0','0','0','0','0','Spiteful Temptress - Cast Domination'),
('2088303','20883','9','0','100','3','0','40','7000','12000','11','36868','1','0','0','0','0','0','0','0','0','0','Spiteful Temptress (Normal) - Cast Shadow Bolt'),
('2088304','20883','9','0','100','5','0','40','7000','10000','11','38892','1','0','0','0','0','0','0','0','0','0','Spiteful Temptress (Heroic) - Cast Shadow Bolt');
--
-- Unbound Devastator 20881 21619
UPDATE `creature_template` SET `mindmg`='2466',`maxdmg`='3250' WHERE `entry` IN ('20881'); -- 751 1535
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6200',`maxdmg`='7400',`unit_flags`='64',`pickpocketloot`='20881' WHERE `entry` IN ('21619'); -- 1802 3684 6686 7941
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20881','21619');
INSERT INTO `creature_template_addon` VALUES
(20881,0,0,16908544,0,4097,0,0,''),
(21619,0,0,16908544,0,4097,0,0,'');
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='12' WHERE `creature_id` IN ('20881'); -- 24
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1`='24' WHERE `creature_id` IN ('21619'); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20881');
INSERT INTO `creature_ai_scripts` VALUES
('2088101','20881','9','0','100','3','0','8','14000','21000','11','36891','4','0','0','0','0','0','0','0','0','0','Unbound Devastator (Normal) - Cast Devastate'),
('2088102','20881','9','0','100','5','0','8','14000','18000','11','38849','4','0','0','0','0','0','0','0','0','0','Unbound Devastator (Heroic) - Cast Devastate'),
('2088103','20881','0','0','100','3','4000','7000','14000','19000','11','36887','0','0','0','0','0','0','0','0','0','0','Unbound Devastator (Normal) - Cast Deafening Roar'),
('2088104','20881','0','0','100','5','2000','4000','11000','15000','11','38850','0','0','0','0','0','0','0','0','0','0','Unbound Devastator (Heroic) - Cast Deafening Roar');
--
-- Ethereum Slayer 20896 21596
UPDATE `creature_template` SET `mindmg`='1759',`maxdmg`='2318',`baseattacktime`='1400',`mechanic_immune_mask`='1088' WHERE `entry` IN ('20896'); -- 536 1095
UPDATE `creature_template` SET `speed`='1.7',`mindmg`='4457',`maxdmg`='5196',`baseattacktime`='0',`unit_flags`='64',`pickpocketloot`='20896',`mechanic_immune_mask`='1089' WHERE `entry` IN ('21596'); -- 1201 2456
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21596');
INSERT INTO `creature_template_addon` VALUES
(21596,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20896');
INSERT INTO `creature_ai_scripts` VALUES
('2089601','20896','9','0','100','7','0','40','6000','10000','11','36839','4','33','0','0','0','0','0','0','0','0','Ethereum Slayer - Cast Impairing Poison'),
('2089602','20896','9','0','100','3','0','5','6000','12000','11','36838','1','0','0','0','0','0','0','0','0','0','Ethereum Slayer (Normal) - Cast Slaying Strike'),
('2089603','20896','9','0','100','5','0','5','6000','12000','11','38894','1','0','0','0','0','0','0','0','0','0','Ethereum Slayer (Heroic) - Cast Slaying Strike'),
('2089604','20896','0','0','100','7','1000','5000','17000','21000','11','15087','0','1','0','0','0','0','0','0','0','0','Ethereum Slayer - Cast Evasion');
--
-- Ethereum Life-Binder 21702 22346
UPDATE `creature_template` SET `mindmg`='1632',`maxdmg`='2149',`baseattacktime`='2000',`equipment_id`='1588',`mechanic_immune_mask`='1088' WHERE `entry` IN ('21702');  -- 498 1015
UPDATE `creature_template` SET `minhealth`='22356',`maxhealth`='22356',`speed`='1.71',`mindmg`='1845',`maxdmg`='2189',`baseattacktime`='0',`equipment_id`='1588',`unit_flags`='64',`pickpocketloot`='21702',`mechanic_immune_mask`='1089' WHERE `entry` IN ('22346'); -- 498 1015
DELETE FROM `creature_template_addon` WHERE `entry` IN ('22346');
INSERT INTO `creature_template_addon` VALUES
(22346,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21702');
INSERT INTO `creature_ai_scripts` VALUES
('2170201','21702','9','0','100','3','0','15','15000','15000','11','37480','4','0','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Normal) - Cast Bind'),
('2170202','21702','9','0','100','5','0','15','10000','10000','11','38900','4','0','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Heroic) - Cast Bind'),
('2170203','21702','0','0','100','3','0','30','8000','12000','11','15654','4','32','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Normal) - Cast Shadow Word: Pain'),
('2170204','21702','0','0','100','5','0','30','5000','10000','11','34941','4','32','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Heroic) - Cast Shadow Word: Pain'),
('2170205','21702','14','0','100','3','6000','40','15000','15000','11','37479','6','1','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Normal) - Cast Shadow Mend on Friendlies'),
('2170206','21702','14','0','100','5','7500','40','10000','10000','11','38899','6','1','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Heroic) - Cast Shadow Mend on Friendlies'),
('2170207','21702','2','0','100','3','75','0','20000','20000','11','37479','0','0','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Heroic) - Cast Shadow Mend on Self'),
('2170208','21702','2','0','100','5','75','0','15000','15000','11','38899','0','0','0','0','0','0','0','0','0','0','Ethereum Life-Binder (Heroic) - Cast Shadow Mend on Self');
--
-- Ethereum Wave-Caster 20897 21597
UPDATE `creature_template` SET `mindmg`='1632',`maxdmg`='2149',`baseattacktime`='2000',`mechanic_immune_mask`='1088' WHERE `entry` IN ('20897'); -- 498 1015
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='2067',`maxdmg`='2454',`baseattacktime`='0',`unit_flags`='64',`pickpocketloot`='20897',`mechanic_immune_mask`='1089' WHERE `entry` IN ('21597'); -- 557 1138
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21597');
INSERT INTO `creature_template_addon` VALUES
(21597,0,0,512,0,4097,0,0,'');  
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20897');
INSERT INTO `creature_ai_scripts` VALUES
('2089701','20897','0','0','100','7','1000','5000','30000','45000','11','32693','0','1','0','0','0','0','0','0','0','0','Ethereum Wave-Caster - Cast Arcane Haste'),
('2089702','20897','13','0','100','7','20000','25000','0','0','11','38897','1','1','0','0','0','0','0','0','0','0','Ethereum Wave-Caster - Cast Sonic Boom on Target Spell Casting'),
('2089703','20897','9','0','100','3','0','15','10000','15000','11','36840','5','32','0','0','0','0','0','0','0','0','Ethereum Wave-Caster (Normal) - Cast Polymorph'),
('2089704','20897','9','0','100','5','0','15','10000','12000','11','38896','5','32','0','0','0','0','0','0','0','0','Ethereum Wave-Caster (Heroic) - Cast Polymorph'),
('2089705','20897','9','0','100','7','0','5','10000','12000','11','38897','1','1','0','0','0','0','0','0','0','0','Ethereum Wave-Caster - Cast Sonic Boom IC');
--
-- Sargeron Hellcaller 20902 21611
UPDATE `creature_template` SET `mindmg`='2059',`maxdmg`='2712',`baseattacktime`='1400',`mechanic_immune_mask`='753876991'  WHERE `entry` IN ('20902'); -- 628 1281
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='5619',`maxdmg`='6874',`baseattacktime`='0',`unit_flags`='64',`pickpocketloot`='20902',`mechanic_immune_mask`='753876991' WHERE `entry` IN ('21611'); -- 1402 3284
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21611');
INSERT INTO `creature_template_addon` VALUES
(21611,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20902');
INSERT INTO `creature_ai_scripts` VALUES
('2090201','20902','0','0','100','7','3000','9000','10000','10000','11','36831','4','32','0','0','0','0','0','0','0','0','Sargeron Hellcaller - Cast Curse of the Elements'),
('2090202','20902','9','0','100','3','0','30','11000','17000','11','36832','4','0','0','0','0','0','0','0','0','0','Sargeron Hellcaller (Normal) - Cast Incinerate'),
('2090203','20902','9','0','100','5','0','30','9000','15000','11','38918','4','0','0','0','0','0','0','0','0','0','Sargeron Hellcaller (Heroic) - Cast Incinerate'),
('2090204','20902','9','0','100','3','0','40','13000','19000','11','36829','4','0','0','0','0','0','0','0','0','0','Sargeron Hellcaller (Normal) - Cast Hell Rain'),
('2090205','20902','9','0','100','5','0','40','11000','17000','11','38917','4','0','0','0','0','0','0','0','0','0','Sargeron Hellcaller (Heroic) - Cast Hell Rain');
--
-- Sargeron Archer 20901 21610
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='2059',`maxdmg`='2712',`baseattacktime`='1400',`mechanic_immune_mask`='753876991',`minrangedmg`='750',`maxrangedmg`='1000' WHERE `entry` IN ('20901'); -- 628 1281  - 
UPDATE `creature_template` SET `speed`='1.20',`mindmg`='5619',`maxdmg`='6874',`baseattacktime`='0',`baseattacktime`='64',`pickpocketloot`='20901',`mechanic_immune_mask`='753876991',`minrangedmg`='1000',`maxrangedmg`='1500' WHERE `entry` IN ('21610'); -- 1402 3284
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20901','21610');
INSERT INTO `creature_template_addon` VALUES
(20901,0,0,512,0,4098,0,0,''),
(21610,0,0,512,0,4098,0,0,'');
DELETE FROM creature_ai_scripts WHERE `entryOrGUID` IN ('20901');
INSERT INTO `creature_ai_scripts` VALUES
('2090100','20901','0','0','100','7','2000','2000','2000','2000','21','1','0','0','40','1','0','0','20','1','0','0','Sargeron Archer - Start Combat Movement and Start Melee'),
('2090101','20901','1','0','100','7','0','0','0','0','21','0','0','0','22','1','0','0','0','0','0','0','Sargeron Archer - Prevent Combat Movement and Set Phase 1 on Spawn'),
('2090102','20901','9','1','100','3','5','30','3000','3000','11','22907','1','0','40','2','0','0','21','0','0','0','Sargeron Archer (Normal) - Cast Shoot and Set Ranged Weapon Model and Stop Movement(Phase 1)'),
('2090103','20901','9','1','100','5','5','30','3000','3000','11','38940','1','0','40','2','0','0','21','0','0','0','Sargeron Archer (Heroic) - Cast Shoot and Set Ranged Weapon Model and Stop Movement(Phase 1)'),
('2090104','20901','9','0','100','3','0','15','15000','19000','11','36827','1','1','21','1','0','0','29','15','0','0','Sargeron Archer (Normal) - Cast Hooked Net and Start Movement and Start Ranged Combat Movement'),
('2090105','20901','9','0','100','5','0','15','15000','19000','11','38912','1','1','21','1','0','0','29','15','0','0','Sargeron Archer (Heroic) - Cast Hooked Net and Start Movement and Start Ranged Combat Movement'),
('2090106','20901','9','1','20','3','0','50','12000','12000','11','35964','4','3','40','2','0','0','21','0','0','0','Sargeron Archer (Normal) - Random Cast Frost Arrow and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2090107','20901','9','1','20','3','10','40','12000','12000','11','35932','4','3','40','2','0','0','21','0','0','0','Sargeron Archer (Normal) - Random Cast Immolation Arrow and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2090108','20901','9','1','20','3','0','40','12000','12000','11','36984','4','3','40','2','0','0','21','0','0','0','Sargeron Archer (Normal) - Random Cast Serpent Sting and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2090109','20901','9','1','20','5','0','50','12000','12000','11','38942','4','3','40','2','0','0','21','0','0','0','Sargeron Archer (Heroic) - Random Cast Frost Arrow and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2090110','20901','9','1','20','5','10','40','12000','12000','11','38943','4','3','40','2','0','0','21','0','0','0','Sargeron Archer (Heroic) - Random Cast Immolation Arrow and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2090111','20901','9','1','20','5','0','50','12000','12000','11','38914','4','3','40','2','0','0','21','0','0','0','Sargeron Archer (Heroic) - Random Cast Serpent Sting and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2090112','20901','9','1','100','1','0','15','8000','12000','11','23601','4','3','40','2','0','0','21','0','0','0','Sargeron Archer - Cast Scatter Shot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('2090113','20901','2','0','100','7','50','0','20000','30000','11','36828','0','1','0','0','0','0','0','0','0','0','Sargeron Archer - Cast Rapid Fire at 50% HP'),
('2090114','20901','9','1','100','7','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Sargeron Archer - Start Combat Movement and Set Melee Weapon Model and Set Phase 0 Below 5 Yards (Phase 1)'),
('2090115','20901','7','0','100','7','0','0','0','0','22','1','0','0','40','1','0','0','0','0','0','0','Sargeron Archer - Set Phase 1 and Set Melee Weapon Model on Evade'),
('2090116','20901','9','0','100','7','5','15','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Sargeron Archer - Stop Combat Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');
--
-- Gargantuan Abyssal 20898 21598
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`mindmg`='3675',`maxdmg`='4845',`baseattacktime`='2000',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20898'); -- 1119 2289
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6686',`maxdmg`='7941',`baseattacktime`='0',`mechanic_immune_mask`='787431423',`unit_flags`='64' WHERE `entry` IN ('21598'); -- 1802 3684
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21598');
INSERT INTO `creature_template_addon` VALUES
(21598,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20898');
INSERT INTO `creature_ai_scripts` VALUES
('2089801','20898','4','0','100','3','0','0','0','0','11','38855','0','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Normal) - Cast Fire Shield on Aggro'),
('2089802','20898','4','0','100','5','0','0','0','0','11','38901','0','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Heroic) - Cast Fire Shield on Aggro'),
('2089803','20898','0','0','100','3','6000','13000','18000','24000','11','36837','4','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Normal) - Cast Meteor'),
('2089804','20898','0','0','100','5','6000','10000','16000','20000','11','38903','4','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Heroic) - Cast Meteor'),
('2089805','20898','27','0','100','3','38855','1','15000','30000','11','38855','0','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Normal) - Cast Fire Shield on Missing Buff'),
('2089806','20898','27','0','100','5','38901','1','15000','30000','11','38901','0','1','0','0','0','0','0','0','0','0','Gargantuan Abyssal (Heroic) - Cast Fire Shield on Missing Buff');
--
-- Unchained Doombringer 20900 21621
UPDATE `creature_template` SET `mindmg`='3342',`maxdmg`='4406',`baseattacktime`='1400',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20900'); -- 1018 2082
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='3777',`maxdmg`='4487',`baseattacktime`='0',`mechanic_immune_mask`='787431423',`unit_flags`='64',`pickpocketloot`='20900' WHERE `entry` IN ('21621'); -- 1018 2082
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21621');
INSERT INTO `creature_template_addon` VALUES
(21621,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20900');
INSERT INTO `creature_ai_scripts` VALUES
('2090001','20900','4','0','100','6','0','0','0','0','11','36833','1','1','0','0','0','0','0','0','0','0','Unchained Doombringer - Cast Berserker Charge on Aggro'),
('2090002','20900','0','0','100','7','8050','9000','18000','18000','11','36833','4','1','0','0','0','0','0','0','0','0','Unchained Doombringer - Cast Berserker Charge'),
('2090003','20900','9','0','100','7','0','5','7000','12000','11','36836','1','1','0','0','0','0','0','0','0','0','Unchained Doombringer - Cast Agonizing Armor'),
('2090004','20900','0','0','100','3','7000','8000','18000','18000','11','36835','0','1','0','0','0','0','0','0','0','0','Unchained Doombringer (Normal) - Cast War Stomp'),
('2090005','20900','0','0','100','3','7000','8000','18000','18000','11','38911','0','1','0','0','0','0','0','0','0','0','Unchained Doombringer (Heroic) - Cast War Stomp');
--
--
--
--
-- Zereketh the Unbound 20870,21626
-- ~4k hits on heroic
UPDATE `creature_template` SET `mindmg`='1894',`maxdmg`='2495',`mechanic_immune_mask`='787431423',`baseattacktime`='1400' WHERE `entry` IN ('20870');  --
UPDATE `creature_template` SET `speed`='1.71',`armor`='7400',`mindmg`='4279',`maxdmg`='5081',`unit_flags`='64',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21626'); -- 6,419 - 7,621
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21626');
INSERT INTO `creature_template_addon` VALUES
(21626,0,0,131584,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20870');
INSERT INTO `creature_ai_scripts` VALUES
('2087001','20870','4','0','100','6','0','0','0','0','1','-634','0','0','0','0','0','0','0','0','0','0','Zereketh The Unbound - Yell on Aggro'),
('2087002','20870','5','0','100','7','0','0','0','0','1','-637','-638','0','0','0','0','0','0','0','0','0','Zereketh The Unbound - Yell on Player Kill'),
('2087003','20870','6','0','100','6','0','0','0','0','1','-639','0','0','0','0','0','0','0','0','0','0','Zereketh The Unbound - Yell on Death'),
('2087004','20870','0','0','100','7','5000','5000','20000','20000','11','36119','4','7','0','0','0','0','0','0','0','0','Zereketh The Unbound - Cast Void Zone'),
('2087005','20870','9','0','100','3','0','30','20000','30000','11','32863','5','32','0','0','0','0','0','0','0','0','Zereketh The Unbound (Normal) - Cast Seed of Corruption'), -- doesnt work right 14000 21000
('2087006','20870','9','0','100','5','0','30','20000','30000','11','36123','5','32','0','0','0','0','0','0','0','0','Zereketh The Unbound (Heroic) - Cast Seed of Corruption'), -- 12000 18000
('2087007','20870','0','0','100','3','12000','12000','30000','30000','11','36127','0','0','1','-635','-636','0','0','0','0','0','Zereketh The Unbound (Normal) - Cast Shadow Nova and Yell'),
('2087008','20870','0','0','100','5','12000','12000','20000','20000','11','39005','0','0','1','-635','-636','0','0','0','0','0','Zereketh The Unbound (Heroic) - Cast Shadow Nova and Yell'),
('2087009','20870','0','0','100','7','15000','15000','20000','20000','12','21101','4','0','0','0','0','0','0','0','0','0','Zereketh The Unbound - Summon additional Void Zone');
--
-- Unbound Void Zone 21101 21620
-- Recheck Infight Bug should have 2 extra flags maybe 512 unit flags etc
--
UPDATE `creature_template` SET `mindmg`='0',`maxdmg`='0',`dynamicflags`='8',`unit_flags`=`unit_flags`|'4'|'64'|'256'|'512'|'131072'|'262144'|'33554432',`AIName`='EventAI',`ScriptName`='',`flags_extra`='2' WHERE `entry` IN ('21101'); --
UPDATE `creature_template` SET `mindmg`='0',`maxdmg`='0',`dynamicflags`='8',`faction_A`='16',`faction_H`='16',`ScriptName`='',`unit_flags`=`unit_flags`|'4'|'64'|'256'|'512'|'131072'|'262144'|'33554432',`flags_extra`='2' WHERE `entry` IN ('21620');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21101');
INSERT INTO `creature_ai_scripts` VALUES
('2110101','21101','11','0','100','2','0','0','0','0','11','36120','0','0','0','0','0','0','0','0','0','0','Unbound Void Zone (Normal) - Cast Consumption on Spawn'),
('2110102','21101','11','0','100','4','0','0','0','0','11','39003','0','0','0','0','0','0','0','0','0','0','Unbound Void Zone (Heroic) - Cast Consumption on Spawn'),
('2110103','21101','0','0','100','7','25000','25000','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Unbound Void Zone - Despawn after 25secs IC');
--
-- Dalliah the Doomsayer 20885,21590
UPDATE `creature` SET `position_x`='122.4736', `position_y`='102.0117', `position_z`='22.4411', `orientation`='1.0485',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('79394');
UPDATE `creature_template` SET `mindmg`='2313',`maxdmg`='3050',`mechanic_immune_mask`='753876991' WHERE `entry` IN ('20885'); -- 
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='3922',`maxdmg`='4659',`unit_flags`='64',`pickpocketloot`='20885',`mechanic_immune_mask`='753876991' WHERE `entry` IN ('21590'); --
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21590');
INSERT INTO `creature_template_addon` VALUES
(21590,0,0,16843008,0,4097,0,0,'');
-- heal nh
UPDATE `creature_ai_scripts` SET `event_param1`='21050',`event_param2`='21050',`event_chance`='100',`event_flags`='3',`comment`='Dalliah the Doomsayer (Normal) - Cast Heal' WHERE `id` IN ('2088506');
-- Gift of the Doomsayer
UPDATE `creature_ai_scripts` SET `event_chance`='100',`event_flags`='3',`comment`='Dalliah the Doomsayer (Normal) - Cast Gift of the Doomsayer' WHERE `id` IN ('2088504');
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('2088510','2088511','2088512','2088513');
INSERT INTO `creature_ai_scripts` VALUES
(2088510,20885,4,0,100,7,0,0,0,0,11,29651,0,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer - Cast Dual Wield on Aggro'),
(2088511,20885,9,0,100,5,7,40,10000,15000,11,39016,4,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer (Heroic) - Cast Shadow Wave'),
(2088512,20885,0,0,100,5,21100,21100,30000,30000,11,39013,0,0,1,-77,-78,0,9,11091,11092,-1,'Dalliah the Doomsayer (Heroic) - Cast Heal'),
(2088513,20885,9,0,100,5,0,10,8500,10000,11,39009,1,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer (Heroic) - Cast Gift of the Doomsayer');
-- no heal cuz of server lag
UPDATE `creature_ai_scripts` SET `event_param1`='21100',`event_param2`='21100' WHERE `id` IN ('2088506');
--
-- Wrath-Scryer Soccothrates 20886,21624
UPDATE `creature` SET `position_x`='121.9831', `position_y`='191.2938', `position_z`='22.4411', `orientation`='5.2464',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('79398');
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`mindmg`='2722',`maxdmg`='3588' WHERE `entry` IN ('20886'); 
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='5619',`maxdmg`='6917',`unit_flags`='64',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21624');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21624');
INSERT INTO `creature_template_addon` VALUES
(21624,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20886');
INSERT INTO `creature_ai_scripts` VALUES
('2088601','20886','4','0','100','3','0','0','0','0','11','36051','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Normal) - Fel Immolation on Aggro'),
('2088602','20886','4','0','100','5','0','0','0','0','11','39007','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Heroic) - Immolation on Aggro'),
('2088603','20886','0','0','100','3','10000','10000','20000','30000','11','35759','1','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Normal) - Cast Felfire Shock'),
('2088604','20886','0','0','100','5','10000','10000','20000','30000','11','39006','1','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates (Heroic) - Cast Felfire Shock'),
('2088605','20886','0','0','100','7','21000','21000','30000','30000','11','36512','0','7','21','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Cast Knock Away and Stop Movement'),
('2088606','20886','0','0','100','7','22000','22000','30000','30000','12','20978','0','20000','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Summon Felfire Line'),
('2088607','20886','0','0','100','7','23000','23000','30000','30000','11','20508','4','7','1','-23','-24','0','0','0','0','0','Wrath-Scryer Soccothrates - Cast Charge and Random Say/Sound'),
('2088608','20886','0','0','100','7','22500','22500','30000','30000','21','1',' 0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Start move'),
('2088609','20886','6','0','100','6','0','0','0','0','1','-25','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - On Creature Death Say/Sound'),
('2088610','20886','5','0','100','7','0','0','0','0','1','-26','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - On Player Death Say/Sound'),
('2088611','20886','4','0','100','6','0','0','0','0','1','-27','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Aggro Say/Sound'),
('2088612','20886','1','0','100','6','0','0','31000','31000','1','-28','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Not in Combat Sound/Yell'),
('2088613','20886','1','0','40','6','0','0','5000','5000','4','11236','0','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Not in Combat Sound'),
('2088614','20886','4','0','100','6','0','0','0','0','34','3','1','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Set Instance Data on Aggro'),
('2088615','20886','6','0','100','6','0','0','0','0','34','3','3','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Set Instance Data on Death'),
('2088616','20886','7','0','100','6','0','0','0','0','34','3','2','0','0','0','0','0','0','0','0','0','Wrath-Scryer Soccothrates - Set Instance Data on Evade');
--
-- Wrath-Scryer's Felfire 20978 21625 npc_felfire_wave -> charges fiends atm not players.
UPDATE `creature_template` SET `speed`='1.71',`faction_A`='16',`faction_H`='16',`unit_flags`='33554688' WHERE `entry` IN ('20978'); -- 0,01 14 33554432  
UPDATE `creature_template` SET `speed`='1.71',`faction_A`='16',`faction_H`='16',`unit_flags`='33554688' WHERE `entry` IN ('21625'); -- 1,2 14 33554432
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21625');
INSERT INTO `creature_template_addon` VALUES
(21625,0,0,16908544,0,4097,0,0,'');
--
--
-- Harbinger Skyriss 20912,21599
UPDATE `creature_template` SET `mindmg`='1261',`maxdmg`='1662',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20912');  -- 
UPDATE `creature_template` SET `armor`='7400',`speed`='1.71',`mindmg`='3021',`maxdmg`='3587',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21599'); --
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20912','21599');
INSERT INTO `creature_template_addon` VALUES
(20912,0,0,512,0,4097,0,0,''),
(21599,0,0,512,0,4097,0,0,'');
--
-- Blazing Trickster 20905 21589
UPDATE `creature_template` SET `mindmg`='1830',`maxdmg`='2410',`baseattacktime`='1400',`mechanic_immune_mask`='753876991' WHERE `entry` IN ('20905'); -- 558 1138
UPDATE `creature_template` SET `minhealth`='89424 ',`maxhealth`='89424',`speed`='1.71',`mindmg`='2068',`maxdmg`='2455',`baseattacktime`='0',`mechanic_immune_mask`='753876991' WHERE `entry` IN ('21589'); -- 558 1138
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20905','21589');
INSERT INTO `creature_template_addon` VALUES
(20905,0,0,512,0,4097,0,0,''),
(21589,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21589');
INSERT INTO `creature_onkill_reputation` VALUES
(21589,935,0,7,0,30,0,0,0,0); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20905');
INSERT INTO `creature_ai_scripts` VALUES
('2090501','20905','1','0','100','6','0','0','0','0','21','1','0','0','22','0','0','0','1','-19','0','0','Blazing Trickster - Prevent Combat Movement and Set Phase to 0 and Say on Spawn'),
('2090502','20905','4','0','100','2','0','0','0','0','11','36906','1','0','22','1','0','0','34','5','1','0','Blazing Trickster (Normal) - Cast Fireball and Set Phase 1 and Set Instance Data on Aggro'),
('2090503','20905','9','5','100','3','0','40','2000','4000','11','36906','4','0','0','0','0','0','0','0','0','0','Blazing Trickster (Normal) - Cast Fireball (Phase 1)'),
('2090504','20905','4','0','100','4','0','0','0','0','11','39023','1','0','22','1','0','0','34','5','1','0','Blazing Trickster (Heroic) - Cast Fireball and Set Phase 1 and Set Instance Data on Aggro'),
('2090505','20905','9','5','100','5','0','40','2000','4000','11','39023','4','0','0','0','0','0','0','0','0','0','Blazing Trickster (Heroic) - Cast Fireball (Phase 1)'),
('2090506','20905','0','0','100','7','2000','5000','16000','21000','11','36907','0','33','0','0','0','0','0','0','0','0','Blazing Trickster - Cast Fire Shield'),
('2090507','20905','3','5','100','6','7','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Blazing Trickster - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2090508','20905','9','5','100','7','25','80','1000','1000','21','1','0','0','0','0','0','0','0','0','0','0','Blazing Trickster - Start Combat Movement at 35 Yards (Phase 1)'),
('2090509','20905','9','5','100','7','5','15','1000','1000','21','1','0','0','0','0','0','0','0','0','0','0','Blazing Trickster - Prevent Combat Movement at 15 Yards (Phase 1)'),
('2090510','20905','9','5','100','7','0','5','1000','1000','21','1','0','0','0','0','0','0','0','0','0','0','Blazing Trickster - Start Combat Movement Below 5 Yards'),
('2090511','20905','3','3','100','7','100','15','1000','1000','22','1','0','0','0','0','0','0','0','0','0','0','Blazing Trickster - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2090512','20905','7','0','100','6','0','0','0','0','22','0','0','0','34','4','2','0','41','0','0','0','Blazing Trickster - Set Phase to 0 and Set Instance Data and Despawn on Evade'),
('2090513','20905','6','0','100','6','0','0','0','0','1','-20','0','0','34','5','3','0','0','0','0','0','Blazing Trickster - Say and Set Instance Data on Death'),
('2090514','20905','1','0','100','7','0','0','0','0','103','30','0','0','0','0','0','0','0','0','0','0','Blazing Trickster - Attack on Spawn');
--
-- Phase-Hunter 20906 21606
UPDATE `creature_template` SET `minlevel`='71',`maxlevel`='71',`armor`='7100',`mindmg`='1000',`maxdmg`='2000',`baseattacktime`='2000',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20906'); -- 933 1907
UPDATE `creature_template` SET `maxhealth`='110700',`speed`='1.71',`mindmg`='3000',`maxdmg`='4000',`baseattacktime`='0',`mechanic_immune_mask`='787431423',`unit_flags`='64',`skinloot`='70162' WHERE `entry` IN ('21606'); -- 2614 5217
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21606');
INSERT INTO `creature_template_addon` VALUES
(21606,0,0,16908544,0,4097,0,0,'');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21606');
INSERT INTO `creature_onkill_reputation` VALUES
(21606,935,0,7,0,30,0,0,0,0); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20906');
INSERT INTO `creature_ai_scripts` VALUES
('2090601','20906','4','0','100','6','0','0','0','0','34','5','1','0','0','0','0','0','0','0','0','0','Phase-Hunter - Set Instance Data on Aggro'),
('2090602','20906','9','0','100','7','0','40','5000','6000','11','36908','4','0','11','36909','4','0','0','0','0','0','Phase-Hunter - Cast Warp and Back Attack'),
('2090603','20906','0','0','100','7','1000','3000','12000','18000','11','36910','0','0','0','0','0','0','0','0','0','0','Phase-Hunter - Cast Phase Burst'),
('2090604','20906','6','0','100','6','0','0','0','0','34','5','3','0','0','0','0','0','0','0','0','0','Phase-Hunter - Set Instance Data on Death'),
('2090605','20906','7','0','100','6','0','0','0','0','34','4','2','0','41','0','0','0','0','0','0','0','Phase-Hunter - Set Instance Data and Despawn on Evade'),
('2090606','20906','1','0','100','7','0','0','0','0','103','30','0','0','0','0','0','0','0','0','0','0','Phase-Hunter - Attack on Spawn');
--
-- Sulfuron Magma-Thrower
UPDATE `creature_template` SET `resistance2`='140',`mechanic_immune_mask`='753876991',`mindmg`='2209',`maxdmg`='2910' WHERE `entry` IN ('20909'); -- 673 1374
UPDATE `creature_template` SET `maxhealth`='94448',`minmana`='26472 ',`maxmana`='26472 ',`speed`='1.71',`mindmg`='5387',`maxdmg`='5808',`baseattacktime`='0',`mechanic_immune_mask`='753876991' WHERE `entry` IN ('21616'); -- 1783 2415
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20909','21616');
INSERT INTO `creature_template_addon` VALUES
(20909,0,0,512,0,4097,0,0,''),
(21616,0,0,512,0,4097,0,0,'');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21616');
INSERT INTO `creature_onkill_reputation` VALUES
(21616,935,0,7,0,30,0,0,0,0); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20909');
INSERT INTO `creature_ai_scripts` VALUES
('2090901','20909','4','0','100','6','0','0','0','0','34','7','1','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower - Set Instance Data on Aggro'),
('2090902','20909','0','0','100','7','3000','6000','12000','15000','11','36917','4','32','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower - Cast Magma-Thrower\'s Curse'),
('2090903','20909','0','0','100','3','7000','11000','15000','21000','11','19717','4','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower (Normal) - Cast Rain of Fire'),
('2090904','20909','0','0','100','5','7000','11000','15000','21000','11','39024','4','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower (Heroic) - Cast Rain of Fire'),
('2090905','20909','9','0','100','3','0','40','8000','12000','11','36986','1','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower (Normal) - Cast Shadow Bolt'),
('2090906','20909','9','0','100','5','0','40','5000','10000','11','39025','1','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower (Heroic) - Cast Shadow Bolt'),
('2090907','20909','6','0','100','6','0','0','0','0','34','7','3','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower - Set Instance Data on Death'),
('2090908','20909','7','0','100','6','0','0','0','0','34','4','2','0','41','0','0','0','0','0','0','0','Sulfuron Magma-Thrower - Set Instance Data and Despawn on Evade'),
('2090909','20909','1','0','100','7','0','0','0','0','103','30','0','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower - Attack on Spawn');
--
-- Akkiris Lightning-Waker 20908 21617
UPDATE `creature_template` SET `speed`='1.71',`mechanic_immune_mask`='753876991',`mindmg`='2051',`maxdmg`='2702' WHERE `entry` IN ('20908'); -- 625 1276
UPDATE `creature_template` SET `maxhealth`='94448',`speed`='1.71',`mindmg`='5387',`maxdmg`='5808',`baseattacktime`='0',`mechanic_immune_mask`='753876991',`unit_flags`='64' WHERE `entry` IN ('21617'); -- 1783 2415
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20908','21617');
INSERT INTO `creature_template_addon` VALUES
(20908,0,0,131584,0,4097,0,0,'34308 0'),
(21617,0,0,131584,0,4097,0,0,'34308 0');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21617');
INSERT INTO `creature_onkill_reputation` VALUES
(21617,935,0,7,0,30,0,0,0,0); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20908');
INSERT INTO `creature_ai_scripts` VALUES
('2090801','20908','4','0','100','6','0','0','0','0','34','7','1','0','11','38642','0','1','0','0','0','0','Akkiris Lightning-Waker - Set Instance Data and Cast Blink on Aggro'),
('2090802','20908','0','0','100','7','3000','8000','16000','21000','11','36912','0','0','13','-80','1','0','0','0','0','0','Akkiris Lightning-Waker - Cast Lightning Jump and Reduce Threat of Top Threat Target'),
('2090803','20908','0','0','100','3','5000','9000','6000','12000','11','36915','0','0','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker (Normal) - Cast Lightning Discharge'),
('2090804','20908','0','0','100','5','5000','9000','10000','15000','11','39028','0','0','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker (Heroic) - Cast Lightning Discharge'),
('2090805','20908','0','0','100','7','10000','15000','30000','30000','11','36914','4','32','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker - Cast Lightning-Waker\'s Curse'),
('2090806','20908','8','0','100','7','0','127','15000','30000','11','19714','0','33','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker - Cast Magic Grounding on Spell Hit'),
('2090807','20908','13','0','100','7','10000','10000','0','0','11','32691','1','1','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker - Cast Spell Shock on Target Casting'),
('2090808','20908','7','0','100','6','0','0','0','0','34','4','2','0','41','0','0','0','0','0','0','0','Akkiris Lightning-Waker - Set Instance Data and Despawn on Evade'),
('2090809','20908','6','0','100','6','0','0','0','0','34','7','3','0','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker - Set Instance Data on Death'),
('2090810','20908','1','0','100','7','0','0','0','0','103','30','0','0','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker - Attack on Spawn');
--
-- Blackwing Drakonaar 20911 21588
-- Pathetic, inferior mortals!
-- The dragonflight will... devour you.
UPDATE `creature_template` SET `mindmg`='2722',`maxdmg`='3588',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20911'); -- 829 1695     - 3,58
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6686',`maxdmg`='7941',`baseattacktime`='0',`unit_flags`='64',`mechanic_immune_mask`='787431423',`lootid`='20911' WHERE `entry` IN ('21588'); -- 1802 3684   
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20911','21588');
INSERT INTO `creature_template_addon` VALUES
(20911,0,0,16777472,0,4097,0,0,'34305 0'),
(21588,0,0,16777472,0,4097,0,0,'34305 0');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21588');
INSERT INTO `creature_onkill_reputation` VALUES
(21588,935,0,7,0,30,0,0,0,0); -- 30
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20911');
INSERT INTO `creature_ai_scripts` VALUES
('2091101','20911','4','0','100','6','0','0','0','0','34','8','1','0','0','0','0','0','0','0','0','0','Blackwing Drakonaar - Set Instance Data on Aggro'),
('2091102','20911','9','0','100','7','0','5','7000','11000','11','13737','1','0','0','0','0','0','0','0','0','0','Blackwing Drakonaar - Cast Mortal Strike'),
('2091103','20911','9','0','100','7','0','20','18000','22000','11','39038','0','1','0','0','0','0','0','0','0','0','Blackwing Drakonaar - Cast Blast Wave'),
('2091104','20911','0','0','100','7','5000','9000','14000','18000','11','39033','4','0','0','0','0','0','0','0','0','0','Blackwing Drakonaar - Cast Brood Power: Black'),
('2091105','20911','7','0','100','6','0','0','0','0','34','4','2','0','41','0','0','0','0','0','0','0','Blackwing Drakonaar - Set Instance Data and Despawn on Evade'),
('2091106','20911','6','0','100','6','0','0','0','0','34','8','3','0','0','0','0','0','0','0','0','0','Blackwing Drakonaar - Set Instance Data on Death'),
('2091107','20911','1','0','100','7','0','0','0','0','103','30','0','0','0','0','0','0','0','0','0','0','Blackwing Drakonaar - Attack on Spawn');
--
-- Twilight Drakonaar 20910
UPDATE `creature_template` SET `resistance1`='140',`mindmg`='2722',`maxdmg`='3588',`baseattacktime`='2000',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20910'); -- 829 1695
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6686',`maxdmg`='7941',`baseattacktime`='0',`mechanic_immune_mask`='787431423',`resistance1`='140',`resistance2`='140',`resistance3`='140',`resistance4`='140',`resistance5`='140',`resistance6`='140' WHERE `entry` IN ('21618'); -- 1802 3684
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20910','21618');
INSERT INTO `creature_template_addon` VALUES
(20910,0,0,16777472,0,4097,0,0,''),
(21618,0,0,16777472,0,4097,0,0,'');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21618');
INSERT INTO `creature_onkill_reputation` VALUES
(21618,935,0,7,0,30,0,0,0,0); -- 30
-- always use new phase after spell usage
UPDATE `creature_ai_scripts` SET `event_chance`='100',`action2_type`='31',`action2_param1`='1',`action2_param2`='5' WHERE `id` IN (2091004,2091005,2091006,2091007,2091008,2091009,2091010,2091011,2091012);
-- cone
UPDATE `creature_ai_scripts` SET `action1_param2`='1' WHERE `id` IN (2091004,2091005,2091010);
-- random
UPDATE `creature_ai_scripts` SET `action1_param2`='4' WHERE `id` IN (2091006,2091007,2091008,2091009,2091011,2091012);
UPDATE `creature_ai_scripts` SET `event_flags`='3',`comment`='Twilight Drakonaar (Normal) - Cast Brood Power: Green (Phase 4 - Green Dragon)' WHERE `id` IN ('2091010');
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('2091013','2091014');
INSERT INTO `creature_ai_scripts` VALUES
('2091013','20910','1','0','100','7','0','0','0','0','103','30','0','0','0','0','0','0','0','0','0','0','Twilight Drakonaar - Attack on Spawn'),
('2091014','20910','0','47','100','7','4000','4000','12000','14000','11','22289','1','0','31','1','5','0','0','0','0','0','Twilight Drakonaar (Heroic) - Cast Brood Power: Green (Phase 4 - Green Dragon)');
--
-- Warden Mellichar 20904 21622
-- npc_warden_mellichar attackable machen
-- -         me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
UPDATE `creature_template` SET `unit_flags`='0',`dynamicflags`='8',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20904'); -- 33344  = 64 + 
UPDATE `creature_template` SET `unit_flags`='0',`dynamicflags`='8',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21622');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('21622');
INSERT INTO `creature_template_addon` VALUES
(21622,0,0,16777472,0,4097,0,0,'36852 0');
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('20904');
--
-- Arca Prisons
UPDATE `creature_template` SET `inhabittype`='5' WHERE `entry` IN ('21436','21437','21438','21439','21440');
--
--
--
--
--
-- linking
--
DELETE FROM `creature_formations` WHERE `leaderguid` IN (79404,79451,79478,79479,79480,79941,79979,80004,79566,79567,79568,79569,86056,86057,86029,86030,86054,86055,86027,86028,86059,86060,86033,86032,86063,86026,79427,79458,79459,79484,79688,79694,79454,79456,79457,79577,79578,79575,79576,79562,79563,79564,79565,79396,79397,79393,79392,79399,79395,79400,79402,79403,79401,79410,79413);
DELETE FROM `creature_formations` WHERE `memberguid` IN (79404,79451,79478,79479,79480,79941,79979,80004,79566,79567,79568,79569,86056,86057,86029,86030,86054,86055,86027,86028,86059,86060,86033,86032,86063,86026,79427,79458,79459,79484,79688,79694,79454,79456,79457,79577,79578,79575,79576,79562,79563,79564,79565,79396,79397,79393,79392,79399,79395,79400,79402,79403,79401,79410,79413);
INSERT INTO `creature_formations` VALUES
--
--
--
--
--
(79451,79451,100,360,2),
(79451,79404,100,360,2),
--
(79480,79480,100,360,2),
(79480,79478,2,0,2),
(79480,79479,2,1,2),
(79480,79941,2,2,2),
(79480,79979,2,4,2),
(79480,80004,2,5,2),
--
(79566,79566,100,360,2),
(79566,79567,3,0,2),
(79566,79568,3,1,2),
(79566,79569,3,5,2),
--
(86056,86056,100,360,2),
(86056,86057,100,360,2),
--
(86029,86029,100,360,2),
(86029,86030,100,360,2),
--
(86054,86054,100,360,2),
(86054,86055,100,360,2),
--
(86027,86027,100,360,2),
(86027,86028,100,360,2),
--
(86063,86063,100,360,2),
(86063,86026,100,360,2),
--
(79427,79427,100,360,2),
(79427,79458,2,0,2),
(79427,79459,2,1,2),
(79427,79484,2,2,2),
(79427,79688,2,4,2),
(79427,79694,2,5,2),
-- 
-- 
(86059,86059,100,360,2),
(86059,86060,100,360,2),
--
(86033,86033,100,360,2),
(86033,86032,100,360,2),
--
(79454,79454,100,360,2),
(79454,79456,2,1,2),
(79454,79457,2,5,2),
--
(79577,79577,100,360,2),
(79577,79578,100,360,2),
--
(79575,79575,100,360,2),
(79575,79576,100,360,2),
--
(79562,79562,100,360,2),
(79562,79563,100,360,2),
(79562,79564,100,360,2),
(79562,79565,100,360,2),
--
(79396,79396,100,360,2),
(79396,79397,100,360,2),
-- 
(79393,79393,100,360,2),
(79393,79392,100,360,2),
--
(79399,79399,100,360,2),
(79399,79395,2,1,2),
(79399,79400,2,5,2),
--
-- start event group, should move if i remember right, after they killed the group
(79402,79402,100,360,2),
(79402,79403,2,1,2),
(79402,79401,2,2,2),
(79402,79410,2,4,2),
(79402,79413,2,5,2);
--
--
--
--
-- movement
--
--
--
--
--
-- Waypoint Movement for 6 Protean Horror's in First Boss Room
SET @NPC := 79480;
SET @PATH := @NPC * 10;   -- 79480
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,200.417557,-117.797157,-10.121884,0,0,0,100,0),
(@PATH,2,196.680008,-138.121567,-10.118616,0,0,0,100,0),
(@PATH,3,197.441513,-146.303894,-10.116393,0,0,0,100,0),
(@PATH,4,211.090561,-156.501984,-10.114545,0,0,0,100,0),
(@PATH,5,229.877884,-157.158936,-10.110607,0,0,0,100,0),
(@PATH,6,235.302383,-161.837494,-10.107670,0,0,0,100,0),
(@PATH,7,237.075363,-172.449677,-10.106312,0,0,0,100,0),
(@PATH,8,232.312439,-181.700851,-10.109240,0,0,0,100,0),
(@PATH,9,232.484512,-190.902832,-10.107521,0,0,0,100,0),
(@PATH,10,260.106995,-192.488022,-10.106289,0,0,0,100,0),
(@PATH,11,273.485718,-175.798553,-10.106289,0,0,0,100,0),
(@PATH,12,274.816711,-164.848145,-10.105530,0,0,0,100,0),
(@PATH,13,277.810608,-152.978165,-10.113414,0,0,0,100,0),
(@PATH,14,277.979736,-139.472931,-10.119408,0,0,0,100,0),
(@PATH,15,267.372345,-132.869247,-10.120901,0,0,0,100,0),
(@PATH,16,259.278687,-120.858826,-10.122385,0,0,0,100,0),
(@PATH,17,238.092804,-122.442680,-10.122385,0,0,0,100,0),
(@PATH,18,218.314133,-121.632462,-10.120625,0,0,0,100,0),
(@PATH,19,208.415344,-118.459152,-10.119198,0,0,0,100,0);
--
-- -----------------------------------------------
-- Random Movement for 2 NPC in Final Boss Chamber
-- -----------------------------------------------
UPDATE creature SET Spawndist=5, MovementType=1 WHERE guid in (79448,79404);
--
-- -----------------------------------------------
-- Abyssal Waypoint Movement in Final Boss Chamber
-- -----------------------------------------------
SET @NPC := 79405;
SET @PATH := @NPC * 10; -- 79405
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,445.795166,-60.789742,48.395481,0,0,0,100,0),
(@PATH,2,445.867126,-79.721024,48.347279,0,0,0,100,0),
(@PATH,3,443.590271,-111.476212,43.100109,0,0,0,100,0),
(@PATH,4,442.416565,-124.400269,43.100109,0,0,0,100,0),
(@PATH,5,436.618011,-138.834335,43.102058,0,0,0,100,0),
(@PATH,6,443.983246,-154.158844,43.076141,0,0,0,100,0),
(@PATH,7,445.068939,-160.755096,43.066151,0,0,0,100,0),
(@PATH,8,462.307648,-174.316940,43.107048,0,0,0,100,0),
(@PATH,9,444.267700,-153.474655,43.074203,0,0,0,100,0),
(@PATH,10,437.304504,-134.904251,43.101089,0,0,0,100,0),
(@PATH,11,444.126984,-120.394928,43.101089,0,0,0,100,0),
(@PATH,12,444.903351,-95.872215,43.101089,0,0,0,100,0),
(@PATH,13,445.893311,-77.828835,48.395470,0,0,0,100,0);
--
-- -----------------------------------------------
-- Ethereium Waypoint Movement in Containment Core
-- -----------------------------------------------
UPDATE creature SET position_x = '461.361481', position_y = '39.636238', position_z = '50.799458', orientation = '2.688958',`spawndist`='0',`movementtype`='0' WHERE guid = '79569';
UPDATE creature SET position_x = '460.075256', position_y = '36.932503', position_z = '50.846470', orientation = '2.891591',`spawndist`='0',`movementtype`='0' WHERE guid = '79568';
UPDATE `creature` SET `spawndist`='0',`movementtype`='0' WHERE `guid` IN ('79567');
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79566');
SET @NPC := 79566;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,454.720398,39.429810,50.846470,0,0,0,100,0),
(@PATH,2,445.098267,43.004402,50.307037,0,0,0,100,0),
(@PATH,3,436.149292,44.500755,49.445507,0,0,0,100,0),
(@PATH,4,429.377563,43.071075,48.646275,0,0,0,100,0),
(@PATH,5,425.879517,39.237438,48.198914,0,0,0,100,0),
(@PATH,6,427.006897,31.302124,48.237396,0,0,0,100,0),
(@PATH,7,437.728271,17.481710,48.213081,0,0,0,100,0),
(@PATH,8,440.470703,6.125143,48.211678,0,0,0,100,0),
(@PATH,9,440.767151,-16.458893,48.211678,0,0,0,100,0),
(@PATH,10,450.292023,-15.927221,48.226391,0,0,0,100,0),
(@PATH,11,451.300568,-6.256669,48.234272,0,0,0,100,0),
(@PATH,12,451.921631,0.912464,48.230587,0,0,0,100,0),
(@PATH,13,453.762817,2.724073,48.234756,0,0,0,100,0),
(@PATH,14,463.692871,4.924800,48.292850,0,0,0,100,0),
(@PATH,15,468.068268,10.702532,49.106396,0,0,0,100,0),
(@PATH,16,467.922394,18.886110,49.854065,0,0,0,100,0),
(@PATH,17,466.032013,23.588348,50.324493,0,0,0,100,0),
(@PATH,18,462.582062,28.266960,50.846508,0,0,0,100,0),
(@PATH,19,461.344940,34.926785,50.846508,0,0,0,100,0),
(@PATH,20,457.106720,38.776997,50.846508,0,0,0,100,0);
--
-- ----------------------------------------------------------
-- Protean Horror Pathing Along Long Walkway at Top of Stairs - Run Mode On
-- ----------------------------------------------------------
DELETE FROM `creature` WHERE `guid` IN ('79963');
INSERT INTO `creature` VALUES
(79963,20865,552,3,0,0,200.8430,23.5294,48.2138,0.7489,7200,0,0,0,0,0,2);
SET @NPC := 79963;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,100,0),
(@PATH,1,206.893188,22.994820,48.213863,0,1,0,100,0),
(@PATH,2,223.208313,22.342752,48.339237,0,1,0,100,0),
(@PATH,3,267.205200,21.640602,48.350433,0,1,0,100,0),
(@PATH,4,313.569244,22.101646,48.350433,0,1,0,100,0),
(@PATH,5,344.486847,22.378342,48.337875,0,1,0,100,0),
(@PATH,6,368.271088,21.997456,48.212669,0,1,0,100,0),
(@PATH,7,400.191498,22.012131,48.212669,0,1,0,100,0),
(@PATH,8,419.790466,22.210125,48.213303,0,1,0,100,0),
(@PATH,9,424.230743,14.892774,48.213303,0,1,0,100,0),
(@PATH,10,425.881134,3.239856,48.206142,0,1,0,100,0),
(@PATH,11,443.302032,-0.542986,48.211395,0,1,0,100,0),
(@PATH,12,457.661499,1.599466,48.230694,0,1,0,100,0),
(@PATH,13,464.794922,5.553366,48.404144,0,1,0,100,0),
(@PATH,14,468.034668,13.963913,49.422935,0,1,0,100,0),
(@PATH,15,467.408478,18.293869,49.793346,0,1,0,100,0),
(@PATH,16,463.347015,27.697102,50.751137,0,1,0,100,0),
(@PATH,17,459.654327,36.577274,50.846516,0,1,0,100,0),
(@PATH,18,455.159546,39.475204,50.846516,0,1,0,100,0),
(@PATH,19,445.222137,41.122322,50.347519,0,1,0,100,0),
(@PATH,20,437.780609,43.674835,49.549824,0,1,0,100,0),
(@PATH,21,432.251740,42.931530,48.982998,0,1,0,100,0),
(@PATH,22,427.619476,39.698357,48.312069,0,1,0,100,0),
(@PATH,23,423.373840,27.909573,48.230087,0,1,0,100,0),
(@PATH,24,410.734009,22.510492,48.216408,0,1,0,100,0),
(@PATH,25,401.738312,22.077915,48.213680,0,1,0,100,0),
(@PATH,26,368.434387,21.900286,48.213680,0,1,0,100,0),
(@PATH,27,346.604187,22.395164,48.333515,0,1,0,100,0),
(@PATH,28,304.417847,22.712563,48.350433,0,1,0,100,0),
(@PATH,29,264.006775,22.318815,48.350433,0,1,0,100,0),
(@PATH,30,229.906219,22.600843,48.314240,0,1,0,100,0);
--
-- ------------------------------------
-- Spiteful Temptress Waypoint Movement
-- ------------------------------------
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79534');
SET @NPC := 79534;
SET @PATH := @NPC * 10;  -- 79534
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,203.624054,156.420914,22.422407,5000,0,0,100,0),
(@PATH,2,201.115082,157.017273,22.430033,3000,0,0,100,0),
(@PATH,3,200.380508,154.526321,22.430033,4000,0,0,100,0),
(@PATH,4,198.234100,155.301224,22.436960,1000,0,0,100,0),
(@PATH,5,202.348206,156.520584,22.426357,2000,0,0,100,0),
(@PATH,6,199.168381,158.032578,22.437122,0,0,0,100,0),
(@PATH,7,188.511398,159.850830,22.439934,0,0,0,100,0),
(@PATH,8,176.867661,160.700134,22.439934,0,0,0,100,0),
(@PATH,9,176.784149,146.914825,22.439934,5000,0,0,100,0),
(@PATH,10,181.197891,147.084335,22.439934,1000,0,0,100,0),
(@PATH,11,178.418488,148.857788,22.439934,3000,0,0,100,0),
(@PATH,12,177.628510,145.204224,22.439934,2000,0,0,100,0),
(@PATH,13,176.239075,148.944489,22.439934,5000,0,0,100,0),
(@PATH,14,176.538452,161.781204,22.439934,0,0,0,100,0),
(@PATH,15,187.246719,159.954849,22.439934,0,0,0,100,0),
(@PATH,16,201.458374,159.143387,22.432077,0,0,0,100,0);
--
-- -------------------------------------------
-- Unbound Devastator in 2 Boss Room Waypoints
-- -------------------------------------------
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79532');
SET @NPC := 79532;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,201.657578,138.055450,22.479853,5000,0,0,100,0),
(@PATH,2,198.899292,135.182098,22.437172,2000,0,0,100,0),
(@PATH,3,199.475754,140.639740,22.499559,5000,0,0,100,0),
(@PATH,4,202.355179,134.738785,22.412693,3000,0,0,100,0),
(@PATH,5,197.448563,140.795837,22.422436,1000,0,0,100,0),
(@PATH,6,201.672913,135.623749,22.413099,0,0,0,100,0),
(@PATH,7,189.193069,134.967987,22.439667,0,0,0,100,0),
(@PATH,8,176.915665,133.268021,22.439667,0,0,0,100,0),
(@PATH,9,177.011566,143.452576,22.439667,4000,0,0,100,0),
(@PATH,10,177.485199,132.554306,22.439667,0,0,0,100,0),
(@PATH,11,186.466354,134.748276,22.439667,0,0,0,100,0),
(@PATH,12,200.482025,134.913269,22.416996,0,0,0,100,0);
--
-- -------------------------------------------------------------------
-- Waypoint Movement for Front Protean Horror in Negaton Screamer Room
-- -------------------------------------------------------------------
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79467');
SET @NPC := 79467;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,100,0),
(@PATH,1,276.188873,-4.195693,22.441347,0,1,0,100,0),
(@PATH,2,266.139313,7.796986,22.441347,0,1,0,100,0),
(@PATH,3,266.247437,-22.611425,22.447418,0,1,0,100,0),
(@PATH,4,281.419769,-21.592731,22.445967,0,1,0,100,0),
(@PATH,5,283.910217,-8.088942,22.441710,0,1,0,100,0),
(@PATH,6,276.132172,-11.520005,22.443382,0,1,0,100,0),
(@PATH,7,278.105957,-27.949659,22.444387,0,1,0,100,0),
(@PATH,8,279.399078,-11.178328,22.443960,0,1,0,100,0),
(@PATH,9,268.779388,-0.587566,22.441538,0,1,0,100,0),
(@PATH,10,279.826538,-10.056340,22.441916,0,1,0,100,0),
(@PATH,11,267.893188,-24.198978,22.447971,0,1,0,100,0),
(@PATH,12,266.199005,1.033335,22.442314,0,1,0,100,0),
(@PATH,13,278.066620,-8.708308,22.442314,0,1,0,100,0),
(@PATH,14,277.867279,-28.168938,22.444113,0,1,0,100,0),
(@PATH,15,279.702942,-17.528187,22.443876,0,1,0,100,0),
(@PATH,16,287.853210,-22.004072,22.443991,0,1,0,100,0),
(@PATH,17,279.812073,-8.400301,22.442545,0,1,0,100,0),
(@PATH,18,270.201996,0.472228,22.442545,0,1,0,100,0),
(@PATH,19,266.016205,9.325026,22.442545,0,1,0,100,0),
(@PATH,20,267.740295,0.898820,22.442545,0,1,0,100,0),
(@PATH,21,277.642578,-5.017527,22.442545,0,1,0,100,0),
(@PATH,22,280.211182,-20.043873,22.444384,0,1,0,100,0),
(@PATH,23,278.357483,-7.861632,22.442942,0,1,0,100,0),
(@PATH,24,281.523712,-20.043016,22.444191,0,1,0,100,0),
(@PATH,25,278.958374,-7.842030,22.442770,0,1,0,100,0),
(@PATH,26,263.748688,3.748354,22.441378,0,1,0,100,0),
(@PATH,27,267.410004,-22.776783,22.447727,0,1,0,100,0),
(@PATH,28,278.466949,-9.572640,22.443493,0,1,0,100,0),
(@PATH,29,278.334595,-27.713200,22.445286,0,1,0,100,0),
(@PATH,30,282.311005,-16.807537,22.445286,0,1,0,100,0);
--
-- --------------------------------------------------------------------------
-- Waypoint Movement for Protean Horror at Very Back of Negaton Screamer Room
-- --------------------------------------------------------------------------
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79520');
SET @NPC := 79520;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,100,0),
(@PATH,1,300.642761,132.433136,22.227863,0,1,0,100,0),
(@PATH,2,280.267914,145.768295,22.224611,0,1,0,100,0),
(@PATH,3,205.459442,147.222336,22.529886,0,1,0,100,0),
(@PATH,4,178.317276,161.465225,22.439648,0,1,0,100,0),
(@PATH,5,177.155533,132.549988,22.439648,0,1,0,100,0),
(@PATH,6,206.136734,146.360229,22.533291,0,1,0,100,0),
(@PATH,7,285.687653,145.897919,22.228125,0,1,0,100,0),
(@PATH,8,299.448425,130.976807,22.225727,0,1,0,100,0),
(@PATH,9,301.781494,110.523033,22.224663,0,1,0,100,0),
(@PATH,10,301.418518,72.443741,22.452053,0,1,0,100,0);
--
-- ------------------------------------------------------------------
-- Waypoint Movement for Rear Protean Horror in Negaton Screamer Room
-- ------------------------------------------------------------------
UPDATE `creature` SET `spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79466');
SET @NPC := 79466;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,1,0,100,0),
(@PATH,1,300.756775,40.685520,22.441168,0,1,0,100,0),
(@PATH,2,266.581726,45.614574,22.441168,0,1,0,100,0),
(@PATH,3,300.608124,40.575359,22.441168,0,1,0,100,0),
(@PATH,4,267.060394,41.358055,22.441168,0,1,0,100,0),
(@PATH,5,284.294586,41.908459,22.441168,0,1,0,100,0),
(@PATH,6,269.809875,34.175770,22.441168,0,1,0,100,0),
(@PATH,7,264.533600,44.058380,22.441168,0,1,0,100,0),
(@PATH,8,295.828278,42.082439,22.441168,0,1,0,100,0),
(@PATH,9,263.093414,44.391598,22.441168,0,1,0,100,0),
(@PATH,10,282.177612,42.438896,22.441168,0,1,0,100,0),
(@PATH,11,262.842407,42.357197,22.441168,0,1,0,100,0),
(@PATH,12,302.240265,41.506519,22.441168,0,1,0,100,0);
--
-- ------------------------------------------------------------------------
-- Waypoint Movement for Protean Horror Running Fast Around First Boss Room
-- ------------------------------------------------------------------------
UPDATE `creature` SET `position_x`='253.873', `position_y`='-148.56', `position_z`='-10.1103', `orientation`='2.60445',`spawndist`='0',`movementtype`='2' WHERE `guid` IN ('79485');
SET @NPC := 79485;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,219.423737,-159.582596,-10.109697,0,1,0,100,0),
(@PATH,2,238.576538,-156.828522,-10.106292,0,1,0,100,0),
(@PATH,3,238.719421,-188.230408,-10.107300,0,1,0,100,0),
(@PATH,4,260.300720,-187.154465,-10.105927,0,1,0,100,0),
(@PATH,5,273.417450,-155.947067,-10.110563,0,1,0,100,0),
(@PATH,6,219.423737,-159.582596,-10.109697,1000,1,0,100,0), -- RESET POINT AT BOTTOM OF STAIRS
(@PATH,7,221.418625,-170.111130,-6.530465,0,1,0,100,0),
(@PATH,8,224.955399,-180.223587,-2.252718,0,1,0,100,0),
(@PATH,9,231.421036,-186.304611,1.389626,0,1,0,100,0),
(@PATH,10,239.355362,-189.083817,5.071302,0,1,0,100,0),
(@PATH,11,246.303619,-189.989212,7.906513,0,1,0,100,0),
(@PATH,12,253.008530,-187.978180,10.734591,0,1,0,100,0), 
(@PATH,13,262.221161,-180.071991,15.643401,0,1,0,100,0),
(@PATH,14,266.803650,-170.353149,20.758307,0,1,0,100,0),
(@PATH,15,267.635040,-160.139359,22.709887,0,1,0,100,0),
(@PATH,16,267.698853,-98.665016,22.533136,0,1,0,100,0),
(@PATH,17,267.631500,-163.200089,22.721127,0,1,0,100,0),
(@PATH,18,264.618652,-176.454178,17.391729,0,1,0,100,0),
(@PATH,19,254.650314,-185.509323,11.554505,0,1,0,100,0),
(@PATH,20,249.936523,-187.553650,9.215827,0,1,0,100,0),
(@PATH,21,237.336990,-187.444992,3.769906,0,1,0,100,0),
(@PATH,22,232.253189,-185.096588,1.492478,0,1,0,100,0),
(@PATH,23,226.582001,-180.257507,-1.869559,0,1,0,100,0),
(@PATH,24,221.051743,-168.552002,-7.273007,0,1,0,100,0),
(@PATH,25,219.423737,-159.582596,-10.109697,1000,1,0,100,0),  -- RESET POINT AS BOTTOM OF STAIRS
(@PATH,26,203.100998,-150.079544,-10.114161,0,1,0,100,0),
(@PATH,27,198.943787,-122.771667,-10.120299,0,1,0,100,0),
(@PATH,28,258.830627,-121.746956,-10.123139,0,1,0,100,0),
(@PATH,29,258.964966,-155.836700,-10.109425,0,1,0,100,0),
(@PATH,30,219.423737,-159.582596,-10.109697,1000,1,0,100,0); -- RESET POINT AS BOTTOM OF STAIRS
--
SET @NPC := 79452;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,202.676270,-20.579115,-10.103319,25000,1,0,100,0),
(@PATH,2,202.722672,-41.737045,-10.101971,25000,1,0,100,0);
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
--
SET @NPC := 79427;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,216.848267,-18.881395,-10.098760,0,0,0,100,0),
(@PATH,2,224.404907,-10.905930,-9.184657,0,0,0,100,0),
(@PATH,3,224.718613,-4.696578,-8.655243,0,0,0,100,0),
(@PATH,4,219.629547,5.646447,-7.485297,0,0,0,100,0),
(@PATH,5,207.049744,16.887529,-7.468389,0,0,0,100,0),
(@PATH,6,198.094162,21.969025,-8.388568,0,0,0,100,0),
(@PATH,7,189.256256,21.147505,-9.359654,0,0,0,100,0),
(@PATH,8,184.528610,17.122450,-10.063705,0,0,0,100,0),
(@PATH,9,184.106415,-12.764568,-10.111907,0,0,0,100,0),
(@PATH,10,197.460083,-22.889290,-10.103550,0,0,0,100,0),
(@PATH,11,196.538254,-38.496593,-10.103550,0,0,0,100,0),
(@PATH,12,196.502731,-61.281567,-10.090692,0,0,0,100,0),
(@PATH,13,202.605331,-63.888237,-10.099648,0,0,0,100,0),
(@PATH,14,208.133896,-60.967098,-10.085385,0,0,0,100,0),
(@PATH,15,209.608978,-48.554283,-10.079647,0,0,0,100,0),
(@PATH,16,209.365677,-22.774431,-10.079889,0,0,0,100,0),
(@PATH,17,213.747040,-20.220253,-10.074949,0,0,0,100,0);
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
--
--
SET @NPC := 79454;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,218.647339,8.709291,-7.468386,0,1,0,100,0),
(@PATH,2,223.847092,-1.618047,-8.210444,0,1,0,100,0),
(@PATH,3,224.021225,-12.192992,-9.421474,0,1,0,100,0),
(@PATH,4,218.005096,-17.964638,-10.109095,0,1,0,100,0),
(@PATH,5,211.043930,-16.059084,-10.085238,0,1,0,100,0),
(@PATH,6,194.756409,-1.592626,-10.103669,0,1,0,100,0),
(@PATH,7,193.059967,5.981993,-10.103669,0,1,0,100,0), -- Stop Point On Floor in Front of Ledge (30 Seconds) doof
(@PATH,8,184.626175,9.869833,-10.078323,0,1,0,100,0),
(@PATH,9,183.574585,14.728133,-10.103496,0,1,0,100,0),
(@PATH,10,188.755112,21.108707,-9.446897,0,1,0,100,0),
(@PATH,11,196.325409,21.570499,-8.626263,0,1,0,100,0),
(@PATH,12,205.938950,18.123007,-7.582917,0,1,0,100,0),
(@PATH,13,211.359039,9.439790,-7.468381,0,1,0,100,0),
(@PATH,14,206.970108,5.479094,-7.468381,30000,0,1,100,0); -- On Top of Ledge Stop Point (30 Seconds)
--
UPDATE `creature` SET `position_x`='135.8590',`position_y`='-0.0621',`position_z`='-10.1021',`movementtype`='2',`spawndist`='0' WHERE `guid` IN ('79402');
SET @NPC := 79402;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16908544,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'169.1991','0.0123','-10.1011',0,1,0,100,0),
(@PATH,2,'115.6377','0.1641','-10.1371',0,1,0,100,0),
(@PATH,3,'60.9237','28.1395','-9.4256',0,1,0,100,0),
(@PATH,4,'43.1489','15.9863','-2.2695',0,1,0,100,0),
(@PATH,5,'37.8908','0.0118','-0.2792',0,1,0,100,0),
(@PATH,6,'13.9086','0.1512',' -0.2054',30000,1,0,100,0),
(@PATH,7,'37.8908','0.0118','-0.2792',0,1,0,100,0),
(@PATH,8,'43.1489','15.9863','-2.2695',0,1,0,100,0),
(@PATH,9,'60.9237','28.1395','-9.4256',0,1,0,100,0),
(@PATH,10,'115.6377','0.1641','-10.1371',0,1,0,100,0);
--
SET @NPC := 79399;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,16777472,0,4097,333,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,'82.8503','0.1346','-11.0281',25000,0,0,100,0),
(@PATH,2,'101.7103','0.0948','-10.1730',60000,1,0,100,0),
(@PATH,3,'79.8004','0.3042','-11.0267',0,0,0,100,0),
(@PATH,4,'82.8503','0.1346','-11.0281',25000,0,0,100,0);
--
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (79404,79405,86026,86056,86057,86054,86055,86059,15535334,79979,80004,79941,79464,79401,79403,79410,79413,79402,79579,86064,79462,79658,79536,79459,79484,79688,79694,79395,79399,79400,79392,79393,79396,79397,79395,79399,79400);
INSERT INTO `creature_linked_respawn` VALUES
--
--
--
-- 
--
(79404,79451), 
(79405,79451),
--
(86026,79451),
-- 
(86057,79451),
(86056,79451),
--
(86055,79451),
(86054,79451),
-- nh robos 
(86059,79398),
(15535334 ,79398),
-- 
(79979,79391),
(80004,79391),
(79941,79391),
--
(79464,79391),
(79579,79391),
(86064,79391),
(79462,79391),
(79658,79391),
(79536,79391),
--
(79459,79391),
(79484,79391),
(79688,79391),
(79694,79391),
--
-- entrance event 

(79395,79452),
(79399,79452),
(79400,79452),
(79392,79452),
(79393,79452),
(79396,79452),
(79397,79452),
--
--
(79401,79399),
(79403,79399),
(79410,79399),
(79413,79399),
(79402,79399);
--
