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
(-633,'GOOO!',NULL,NULL,'LOOOS!',NULL,NULL,NULL,NULL,NULL,13460,1,0,0,'26798'),
(-634,'Life energy to... consume.',NULL,NULL,'Lebensenergie... verzehren.',NULL,NULL,NULL,NULL,NULL,11250,1,0,0,'20870'),
(-635,'The shadow... will engulf you.',NULL,NULL,'Die Schatten... werden Euch umschlingen.',NULL,NULL,NULL,NULL,NULL,11253,1,0,0,'20870'),
(-636,'Darkness...consumes...all.',NULL,NULL,'Dunkelheit... verzehrt... alles.',NULL,NULL,NULL,NULL,NULL,11254,1,0,0,'20870'),
(-637,'This vessel... is empty.',NULL,NULL,'Dieses Gefäß... ist leer.',NULL,NULL,NULL,NULL,NULL,11251,1,0,0,'20870'),
(-638,'No...more...life.',NULL,NULL,'Kein... Leben... mehr.',NULL,NULL,NULL,NULL,NULL,11252,1,0,0,'20870'),
(-639,'The void...beckons.',NULL,NULL,'Die Leere... ruft.',NULL,NULL,NULL,NULL,NULL,11255,1,0,0,'20870'),
(-640,'It is not smart to make me angry!',NULL,NULL,'Es ist nicht klug, mich wütend zu machen.',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-641,'Ahh..., much better.',NULL,NULL,'Ahh..., viel besser.',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-642,'Ahh... exactly what I needed.',NULL,NULL,'Ahh... genau, was ich brauchte.',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-643,'Completely inefficient. Like someone I know.',NULL,NULL,'Völlig ineffizient. Genau wie jemand anders den ich kenne.',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-644,'You have chosen the wrong opponent.',NULL,NULL,'Ihr habt den falschen Gegner gewählt.',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-645,'I will cut you to pieces!',NULL,NULL,'Ich werde Euch in Stücke schneiden!',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-646,'Reap the Storm!',NULL,NULL,'Erntet den Sturm!',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-647,'Now I am really angry.',NULL,NULL,'Nun bin ich wirklich wütend.',NULL,NULL,NULL,NULL,NULL,0,1,0,0,'???'),
(-648,'lets out a deep roar, alerting nearby allies and becoming enraged!',NULL,NULL,'gibt ein tiefes Grollen von sich und warnt alle in der Nähe befindlichen Verbündeten und wird wütend!',NULL,NULL,NULL,NULL,NULL,0,2,0,0,'Dire Maul Guards'),
(-649,'goes into a drunken rage!',NULL,NULL,'verfällt in eine betrunke Raserei!',NULL,NULL,NULL,NULL,NULL,0,2,0,0,'14322'),
(-650,'I am Scarlet Onslaught. We don\'t rat out our leaders!',NULL,NULL,'Ich bin der Scharlachrote Ansturm. Wir verraten unsere Anführer nicht!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29490'),
(-651,'I don\'t know where the grand admiral is. Go to hell!',NULL,NULL,'Ich weiß nicht wo sich der Großadmiral befindet. Fahr zur Hölle!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29490'),
(-652,'Guards help!',NULL,NULL,'Wachen, Hilfe!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29489'),
(-653,'Archbishop Landrgren must know! Aaaaaaaagggghhh.....!',NULL,NULL,'Erzbischof Landrgren muss es erfahren! Aaaaaaarrrghhhh.....!',NULL,NULL,NULL,NULL,NULL,0,0,0,0,'29489'),
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
UPDATE `creature_template` SET `armor`='5500',`speed`='1.20',`mindmg`='200',`maxdmg`='400' WHERE `entry` IN ('21395'); -- 184 330 570 716
UPDATE `creature_template` SET `armor`='6100',`mindmg`='300',`maxdmg`='600' WHERE `entry` IN ('21609'); -- 284 430 764 861
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
UPDATE `creature_template` SET `equipment_id`='4001',`speed`='1.71',`mindmg`='8961',`maxdmg`='10637',`baseattacktime`='0',`pickpocketloot`='20879' WHERE `entry` IN ('21595'); -- 4200-5800 5974-7091 8961-10637
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
UPDATE `creature_template` SET `equipment_id`='1476',`armor`='6800',`speed`='1.71',`mindmg`='10340',`maxdmg`='12275',`baseattacktime`='0' WHERE `entry` IN ('21594'); -- 2789-5692 5800-7000 6893-8183 -- 10340-12275 15,510 - 18,413
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
('2086902','20869','1','0','100','2','1000','1000','0','0','11','36716','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge on Spawn'),
('2086903','20869','1','0','100','4','1000','1000','0','0','11','38828','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge on Spawn'),
('2086904','20869','1','0','100','6','2000','2000','0','0','11','31261','0','0','22','0','0','0','0','0','0','0','Arcatraz Sentinel - Cast Permanent Feign Death (Root) on Spawn'),
('2086905','20869','4','0','100','7','0','0','0','0','28','0','31261','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Remove Permanent Feign Death (Root) on Aggro'),
('2086906','20869','0','0','100','2','1000','2000','0','0','28','0','36716','0','22','1','0','0','0','0','0','0','Arcatraz Sentinel (Normal) - Remove Energy Discharge and Set Phase 1'),
('2086907','20869','0','0','100','4','1000','2000','0','0','28','0','38828','0','22','1','0','0','0','0','0','0','Arcatraz Sentinel (Heroic) - Remove Energy Discharge and Set Phase 1'),
('2086908','20869','9','13','100','3','0','15','1000','3000','11','36717','4','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge (Phase 1)'),
('2086909','20869','9','13','100','5','0','15','1000','3000','11','38829','4','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge (Phase 1)'),
-- the hp values where he transforms seems to produce the nonkillable bug so increasing the value to 15% in both mods ( befor 16/10)
('2086910','20869','2','13','100','2','20','0','0','0','11','36716','0','7','36','21761','0','0','22','2','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge and Transform into Destroyed Sentinel and Set Phase 2 at 15% HP (Phase 1)'),
('2086911','20869','2','13','100','4','20','0','0','0','11','38828','0','7','36','21761','0','0','22','2','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge and Transform into Destroyed Sentinel and Set Phase 2 at 15% HP (Phase 1)'),
('2086912','20869','0','11','100','7','500','500','500','500','21','0','0','0','103','20','0','0','22','3','0','0','Arcatraz Sentinel - Prevent Combat Movement and Attack Random and Set Phase 3 (Phase 2)'),
('2086913','20869','0','7','100','2','10','10','1000','1000','11','36719','0','6','11','36716','0','39','20','0','0','0','Arcatraz Sentinel (Normal) - Remove Energy Discharge and Cast Explode and Prevent Melee (Phase 3)'), -- 28 0 36717
('2086914','20869','0','7','100','4','10','10','1000','1000','11','38830','0','6','11','38828','0','39','20','0','0','0','Arcatraz Sentinel (Heroic) - Remove Energy Discharge and Cast Explode and Prevent Melee (Phase 3)'), -- 28 0 38828
('2086915','20869','0','7','100','7','10','10','10','10','11','20','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Aggro Pulse Out of Combat (Phase 3)'),
('2086916','20869','21','0','100','2','0','0','0','0','11','36716','0','7','0','0','0','0','22','0','0','0','Arcatraz Sentinel (Normal) - Cast Energy Discharge on Return Home'),
('2086917','20869','21','0','100','4','0','0','0','0','11','38828','0','7','0','0','0','0','22','0','0','0','Arcatraz Sentinel (Heroic) - Cast Energy Discharge on Return Home'),
('2086918','20869','0','0','100','7','5000','10000','8000','12000','14','-99','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Random Aggro Wipe'),
('2086919','20869','7','0','100','2','0','0','0','0','36','20869','0','0','22','0','0','0','0','0','0','0','Arcatraz Sentinel (Normal) - Transform into Arcatraz Sentinel and Set Phase 0 on Evade'),
('2086920','20869','7','0','100','4','0','0','0','0','36','21586','0','0','22','0','0','0','0','0','0','0','Arcatraz Sentinel (Heroic) - Transform into Arcatraz Sentinel and Set Phase 0 on Evade'),
('2086921','20869','7','0','100','6','0','0','0','0','21','1','0','0','22','1','0','0','28','0','46416','0','Arcatraz Sentinel - Start Movement and Start Melee and Remove Stun on Evade'),
('2086922','20869','0','7','100','6','8000','8000','0','0','33','20869','6','0','11','46416','0','7','0','0','0','0','Arcatraz Sentinel - Give Quest Kill Credit and Selfstun (Phase 3)'),
('2086923','20869','0','7','100','6','20000','30000','0','0','37','0','0','0','0','0','0','0','0','0','0','0','Arcatraz Sentinel - Kill Self after Explode(Phase 3)');
--
-- Destroyed Sentinel 21761
UPDATE `creature_template` SET `minhealth`='18500',`maxhealth`='18500',`modelid_A`='19971',`modelid_H`='19971',`dynamicflags`='8',`armor`='0',`faction_A`='14',`faction_H`='14',`unit_flags`='262148',`flags_extra`='0',`mindmg`='2137',`maxdmg`='2817',`lootid`='20869',`flags_extra`=`flags_extra`|'65536'|'33554432' WHERE `entry` IN ('21761'); -- 9250 19971 `unit_flags`|'256'|'512'|'33554432'|'4'|'262144' -> 33555200
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
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6521',`maxdmg`='7778',`baseattacktime`='0',`pickpocketloot`='20882' WHERE `entry` IN ('21613'); -- 2317 4832 4600 5800 -- 13041 - 15556
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
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6521',`maxdmg`='7778',`baseattacktime`='0',`unit_flags`='32832',`pickpocketloot`='20883',`flags_extra` = flags_extra|'65536' WHERE `entry` IN ('21615'); -- 2317 4832 3800 4800 -- 13041 - 15556
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
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='8023',`maxdmg`='9529',`unit_flags`='64',`pickpocketloot`='20881' WHERE `entry` IN ('21619'); -- 1802 3684 6686 7941 -- 10,029 - 11,911
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
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='8023',`maxdmg`='9529',`baseattacktime`='0',`mechanic_immune_mask`='787431423',`unit_flags`='64' WHERE `entry` IN ('21598'); -- 1802 3684 6686 7941 -- 10,029 - 11,911
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
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='5666',`maxdmg`='6730',`baseattacktime`='0',`mechanic_immune_mask`='787431423',`unit_flags`='64',`pickpocketloot`='20900' WHERE `entry` IN ('21621'); -- 1018 2082 -- 5,666 - 6,730
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
-- Bosses
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
-- still no heal cuz of delay
UPDATE `creature_ai_scripts` SET `event_param1`='14750',`event_param2`='14750' WHERE `id` IN ('2088505'); -- 15000
--
-- Wrath-Scryer Soccothrates 20886,21624
UPDATE `creature` SET `position_x`='121.9831', `position_y`='191.2938', `position_z`='22.4411', `orientation`='5.2464',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('79398');
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`mindmg`='2722',`maxdmg`='3588' WHERE `entry` IN ('20886'); 
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6742',`maxdmg`='8301',`unit_flags`='64',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21624'); -- 5619 6917 -- 8,428 - 10,376
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
('2090514','20905','1','0','100','7','0','0','0','0','103','40','0','0','0','0','0','0','0','0','0','0','Blazing Trickster - Attack OOC');
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
('2090606','20906','1','0','100','7','0','0','0','0','103','40','0','0','0','0','0','0','0','0','0','0','Phase-Hunter - Attack OOC');
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
('2090909','20909','1','0','100','7','0','0','0','0','103','40','0','0','0','0','0','0','0','0','0','0','Sulfuron Magma-Thrower - Attack OOC');
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
('2090810','20908','1','0','100','7','0','0','0','0','103','40','0','0','0','0','0','0','0','0','0','0','Akkiris Lightning-Waker - Attack OOC');
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
('2091107','20911','1','0','100','7','0','0','0','0','103','40','0','0','0','0','0','0','0','0','0','0','Blackwing Drakonaar - Attack OOC');
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
('2091013','20910','1','0','100','7','0','0','0','0','103','40','0','0','0','0','0','0','0','0','0','0','Twilight Drakonaar - Attack on OOC'),
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
