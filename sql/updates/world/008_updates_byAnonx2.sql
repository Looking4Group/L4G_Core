-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/420/elementarplateu-rework
--
--
--
-- spawns
--
-- 16800000 - 16800009
UPDATE `creature` SET `spawndist`='5',`movementtype`='1' WHERE `id` IN ('22310');
DELETE FROM `creature` WHERE `guid` IN ('16800000','16800001');
INSERT INTO `creature` VALUES
(16800000,22310,530,1,0,0,-840.0236,6542.0161,171.1328,5.9890,300,5,0,0,0,0,1),
(16800001,22311,530,1,0,0,-786.2155,6540.7275,173.1196,2.0817,300,5,0,0,0,0,1);
--
-- 12x Storming Wind-Ripper 22310
UPDATE `creature_template` SET `armor`='6100',`speed`='1.20',`resistance3`='0'  WHERE `entry` IN ('22310'); -- 20
UPDATE `creature_template_addon` SET `auras`='34304 0 34308 0' WHERE `entry` IN ('22310');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22310');
INSERT INTO `creature_ai_scripts` VALUES
(2231001,22310,0,0,100,1,10000,10000,10000,10000,11,12550,0,33,0,0,0,0,0,0,0,0,'Storming Wind-Ripper - Cast Lightning Shield IC'),
(2231002,22310,1,0,100,1,1000,1000,60000,60000,11,12550,0,1,0,0,0,0,0,0,0,0,'Storming Wind-Ripper - Cast Lightning Shield OOC'),
(2231003,22310,9,0,100,1,0,40,3000,6000,0,0,0,0,11,20295,1,0,0,0,0,0,'Storming Wind-Ripper - Cast Lighting Bolt');
--
-- 12x Raging Fire-Soul 22311
UPDATE `creature_template` SET `scriptname`='',`flags_extra`=`flags_extra`|'536870912' WHERE `entry` IN ('22311'); -- npc_erzuernte_FeuerseeleAI und mmap disable for reset issues
UPDATE `creature_template_addon` SET `auras`='34305 0 34308 0' WHERE `entry` IN ('22311'); -- 29948 0 needs core spellwork to function as proper aura
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22311');
--
-- 10x Rumbling Earth-Heart 22313
-- movement 4 two or so
UPDATE `creature_template` SET `speed`='1.20',`AIName`='EventAI' WHERE `entry` IN ('22313');
UPDATE `creature_template_addon` SET `auras`='34308 0' WHERE `entry` IN ('22313');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22313');
INSERT INTO `creature_ai_scripts` VALUES
(2231301,22313,9,0,100,1,0,5,14000,16000,11,33840,0,0,0,0,0,0,0,0,0,0,'Rumbling Earth-Heart  - Cast Earth Rumble'),
(2231302,22313,2,0,100,0,30,0,0,0,11,8599,0,0,1,-106,0,0,0,0,0,0,'Rumbling Earth-Heart - Casts Enrage at 30% HP');
--
-- 14x Crashing Wave-Spirit 22309 npc_Wasserelementar
UPDATE `creature_template` SET `speed`='1.20',`resistance4`='0' WHERE `entry` IN ('22309');
UPDATE `creature_template_addon` SET `auras`='34306 0' WHERE `entry` IN ('22309');
--
--
--  repos
--
UPDATE `creature` SET `movementtype`='1',`spawndist`='5' WHERE `id` IN ('22311');
UPDATE `creature` SET `position_x`='-825.3634', `position_y`='6618.4624', `position_z`='175.4391' WHERE `guid` IN ('78466');
UPDATE `creature` SET `position_x`='-794.4229', `position_y`='6581.7529', `position_z`='171.3957' WHERE `guid` IN ('78474');
UPDATE `creature` SET `position_x`='-679.4104', `position_y`='6566.6533', `position_z`='170.9530' WHERE `guid` IN ('78473');
UPDATE `creature` SET `position_x`='-750.3014', `position_y`='6551.8862', `position_z`='170.9357' WHERE `guid` IN ('78471');
--
-- Target Dummys
--
-- target dummy enhancements
UPDATE `creature_template` SET `scale`='2',`minhealth`='99999999',`maxhealth`='99999999',`subname`='6200 Armor',`rank`='3',`mechanic_immune_mask`='787431423',`flags_extra`='65536' WHERE `entry` IN ('1200062','1200063');
UPDATE `creature_template` SET `scale`='2',`minhealth`='99999999',`maxhealth`='99999999',`subname`='7700 Armor',`rank`='3',`mechanic_immune_mask`='787431423',`flags_extra`='65536' WHERE `entry` IN ('1200064','1200065');
UPDATE `creature_template` SET `name`='Player Combat Dummy',`maxlevel`='70',`scale`='1',`minhealth`='99999999',`maxhealth`='99999999',`subname`='0 Armor',`armor`='0',`type`='7',`dynamicflags`='8',`flags_extra`='65536' WHERE `entry` IN ('1200058');
DELETE FROM `creature_template` WHERE `entry` IN ('1200066');
INSERT INTO `creature_template` VALUES
(1200066,0,NULL,3019,NULL,3019,NULL,'Player Combat Dummy','0 Armor',NULL,70,70,99999999,99999999,0,0,0,1,31,31,0,0.001,1,0,0,0,0,0,2000,0,0,8,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,NULL,0,0,'',0,3,0,NULL,NULL,NULL,65536,'npc_theramore_combat_dummy');


DELETE FROM `creature` WHERE `guid` IN ('29337','29312','29437','133929','29461','124496','16800641','16800640','271838','328022','16800649','16800655','16800661','16800667','16800673','16800679','16800697','16800698','16800642','16800650','16800656','16800662','16800668','16800674','16800680','16800686','16800692','16800643','16800651','16800657','16800663','16800670','16800675','16800681','16800687','16800693','16800644','16800653','16800658','16800664','16800669','16800676','16800682','16800688','16800694','16800645','16800652','16800660','16800665','16800671','16800677','16800683','16800689','16800695','16800646','16800654','16800659','16800666','16800672','16800678','16800684','16800690','16800696');
DELETE FROM `creature` WHERE `guid` IN (16800036,16800037,16800038,16800039,16800041,16800049,16800050,16800051,16800052,16800053,16800054,16800055,16800057,16800058,16800059,16800060,16800061,16800062,16800063,16800064,16800065,16800066,16800067,16800068,16800069,16800070,16800071,16800072,16800073,16800074,16800075,16800076,16800077,16800078,16800080,16800088,16800089,16800090,16800091,16800092,16800093,16800094,16800095,16800096,16800097,16800098,16800099,16800100,16800101,16800102,16800103,16800104,16800105,16800107,16800109,16800110,16800111,16800112,16800113,16800114);


UPDATE `creature_template` SET `lootid`='0' WHERE `entry` IN ('7286');

-- 16800036,16800037,16800038,16800039,16800041,16800049 shattrath
-- 16800050,16800051,16800052,16800053,16800054,16800055 if
-- 16800057,16800058,16800059,16800060,16800061,16800062 sw
-- 16800063,16800064,16800065,16800066,16800067,16800068 dr
-- 16800069,16800070,16800071,16800072,16800073,16800074 ex
-- 16800075,16800076,16800077,16800078,16800080,16800088 og
-- 16800089,16800090,16800091,16800092,16800093,16800094 tb
-- 16800095,16800096,16800097,16800098,16800099,16800100 uc
-- 16800101,16800102,16800103,16800104,16800105,16800107 sm
-- 16800109,16800110,16800111,16800112,16800113,16800114 gm

INSERT INTO `creature` VALUES
-- (GUID,IIDD,1,1,0,0,XXX,YYY,ZZZ,OOO,SSS,0,0,HHPP,0,0,0),
(16800109,1200062,1,1,0,0,16260.9003,16247.0332,24.6619,1.9079,30,0,0,99999999,0,0,0),
(16800110,1200063,1,1,0,0,16268.8212,16249.8105,23.6558,1.9079,30,0,0,99999999,0,0,0),
(16800111,1200064,1,1,0,0,16279.8662,16253.6826,23.8619,1.9079,30,0,0,99999999,0,0,0),
(16800112,1200065,1,1,0,0,16289.2402,16256.9687,23.3671,1.9079,30,0,0,99999999,0,0,0),
(16800113,1200058,1,1,0,0,16287.4248,16266.9404,19.9136,3.3216,30,0,0,99999999,0,0,0),
(16800114,1200066,1,1,0,0,16285.3164,16278.5185,17.1308,3.3216,30,0,0,99999999,0,0,0);

-- 
-- trigger steht falsch
UPDATE `creature` SET `position_x`='-1846.6214', `position_y`='6378.0756', `position_z`='48.8201', `orientation`='1.0103',`spawndist`='0',`movementtype`='0',`map`='530' WHERE `guid` IN ('16800087');
--
-- Omen
UPDATE `creature` SET `spawnmask`='1' WHERE `guid` IN ('2468');
UPDATE `creature_template` SET `minlevel`='73',`maxlevel`='73',`minhealth`='1000000',`maxhealth`='1000000',`armor`='7700',`speed`='2',`mindmg`='1000',`maxdmg`='2000',`baseattacktime`='1000',`dynamicflags`='0',`unit_flags`='0',`resistance1`='100',`resistance2`='100',`resistance3`='100',`resistance4`='100',`resistance5`='100',`resistance6`='100',`mechanic_immune_mask`='1073725439',`flags_extra`=`flags_extra`|'65536'|'33554432' WHERE `entry` IN ('15467');
--
-- Hydromancer Thespia 17797,20629
UPDATE `creature_template` SET `mindmg`='2051',`maxdmg`='2702' WHERE `entry` IN ('17797'); -- 625 1276
UPDATE `creature_template` SET `mindmg`='3060',`maxdmg`='3762',`pickpocketloot`='17797' WHERE `entry` IN ('20629');
--
-- Mekgineer Steamrigger 17796,20630
UPDATE `creature_template` SET `mindmg`='2722',`maxdmg`='3588',`baseattacktime`='1400' WHERE `entry` IN ('17796'); -- 829 1695
UPDATE `creature_template` SET `mindmg`='4179',`maxdmg`='4603',`baseattacktime`='0',`equipment_id`='0',`pickpocketloot`='17796' WHERE `entry` IN ('20630');
--
-- Warlord Kalithresh 17798,20633
UPDATE `creature_template` SET `mindmg`='2212',`maxdmg`='2916',`equipment_id` ='1752' WHERE `entry` IN ('17798'); -- 674 1378
UPDATE `creature_template` SET `mindmg`='5463',`maxdmg`='5683',`equipment_id` ='1752',`pickpocketloot`='17798' WHERE `entry` IN ('20633');
--
-- Pandemonius 18341,20267
-- Pandemonius' attacks are all purely shadow damage, including his melee attacks.
UPDATE `creature_template` SET `speed`='1.48',`dynamicflags`='0',`mechanic_immune_mask`='787431423',`flags_extra`='0' WHERE `entry` IN ('18341');
UPDATE `creature_template` SET `armor`='7400 ',`speed`='1.48',`unit_flags`='64',`mechanic_immune_mask`='787431423',`mindmg`='5000',`maxdmg`='5667',`dmgschool`='5' WHERE `entry` IN ('20267');
--
-- Tavarok 18343,20268
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='787447807' WHERE `entry` IN ('18343');
UPDATE `creature_template` SET `speed`='1.48',`unit_flags`='64',`mechanic_immune_mask`='787447807',`mindmg`='5768',`maxdmg`='6851',`dynamicflags`='8' WHERE `entry` IN ('20268'); 
--
-- Nexus-Prince Shaffar interruptable 18344,20266
UPDATE `creature_template` SET `speed`='1.48',`mechanic_immune_mask`='753876991',`baseattacktime`='1400' WHERE `entry` IN ('18344');
UPDATE `creature_template` SET `armor`='6450',`speed`='1.48',`unit_flags`='64',`equipment_id`='1835',`mechanic_immune_mask`='753876991',`mindmg`='4621',`maxdmg`='5274' WHERE `entry` IN ('20266');
--
-- Yor Void Hound of Shaffar
UPDATE `creature_template` SET `speed`='1.48',`baseattacktime`='1000',`mechanic_immune_mask`='787431423',`flags_extra`='1' WHERE `entry` IN ('22930');
--
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`mechanic_immune_mask`='617299835',`mindmg`='2698',`maxdmg`='3470' WHERE `entry` IN ('20692'); -- 770 2314 Waffe passt
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`minlevel`='70',`lootid`='19429',`mindmg`='1960',`maxdmg`='2374' WHERE `entry` IN ('20686'); -- 770 2314
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`lootid`='18318',`mindmg`='2404',`maxdmg`='2777' WHERE `entry` IN ('20693'); -- Roter gewellter Dolch wie im Tempel und Bronze Schild 922 1668
--
-- Charming Totem 20343,20687
UPDATE `creature_template` SET `minlevel`='67',`maxlevel`='67',`minhealth`='2000',`maxhealth`='2000',`faction_A`='16',`faction_H`='16',`armor`='0',`speed`='0',`mindmg`='0',`maxdmg`='0',`mechanic_immune_mask`='1073741823',`flags_extra`='196732' WHERE `entry` IN ('20343');
UPDATE `creature_template` SET `minlevel`='70',`maxlevel`='70',`minhealth`='5000',`maxhealth`='5000',`faction_A`='16',`faction_H`='16',`speed`='0',`mindmg`='0',`maxdmg`='0',`mechanic_immune_mask`='1073741823',`flags_extra`='196732' WHERE `entry` IN ('20687');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('20343','20687'); 
INSERT INTO `creature_template_addon` VALUES
(20343,0,0,0,0,0,0,0,'34309 0'),
(20687,0,0,0,0,0,0,0,'34309 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20343');
INSERT INTO `creature_ai_scripts` VALUES
('2034301','20343','4','0','100','7','0','0','0','0','11','35120','4','39','0','0','0','0','0','0','0','0','Charming Totem - Charm on Aggro'),
('2034302','20343','7','0','100','7','0','0','0','0','41','0','0','0','0','0','0','0','0','0','0','0','Charming Totem - Despawn on Evade');
UPDATE `creature_template` SET `armor`='6200',`faction_A`='16',`faction_H`='16',`speed`='1.48',`mindmg`='1376',`maxdmg`='1647' WHERE `entry` IN ('20694'); -- 485 1026
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`family`='22',`inhabittype`='3',`lootid`='19428',`skinloot`='70063',`mechanic_immune_mask`='753866495',`mindmg`='3732',`maxdmg`='3902' WHERE `entry` IN ('20688'); -- 1739 2078
UPDATE `creature_template` SET `minmana`='73320',`maxmana`='73320',`armor`='6200',`faction_A`='16',`faction_H`='16',`speed`='1.48',`mindmg`='1720',`maxdmg`='1894' WHERE `entry` IN ('20697'); -- 730 1078
UPDATE `creature_template` SET `armor`='5800',`faction_A`='16',`faction_H`='16',`lootid`='21891',`mindmg`='1351',`maxdmg`='1572' WHERE `entry` IN ('21989'); -- 510 951
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`minlevel`='71',`armor`='6450',`speed`='1.48',`spell1`='0',`mindmg`='1578',`maxdmg`='1808',`spell1`='0' WHERE `entry` IN ('20695'); -- 616 1077 s1 27641
UPDATE `creature_template` SET `faction_A`='16',`faction_H`='16',`speed`='1',`mechanic_immune_mask`='653230079',`unit_flags`='33554688',`flags_extra`='0',`mindmg`='2869',`maxdmg`='3569',`speed`='0.75' WHERE `entry` IN ('20700'); -- 2000 3000
UPDATE `creature_template` SET `armor`='7400',`faction_A`='16',`faction_H`='16',`speed`='1.48',`mechanic_immune_mask`='0',`mindmg`='2595',`maxdmg`='2873',`spell1`='0',`spell2`='0' WHERE `entry` IN ('20701'); -- gelbe eisen Lanze 1089 1645 s1 32674 s2 32654
UPDATE `creature_template` SET `armor`='6450',`speed`='1.48',`mindmg`='949',`maxdmg`='1141',`spell1`='0',`spell2`='0' WHERE `entry` IN ('20698'); -- 330 715 s1 32682 s2 38148
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`armor`='7400',`faction_A`='16',`faction_H`='16',`mindmg`='903',`maxdmg`='1136' WHERE `entry` IN ('20689'); -- 276 743 s1 12471
--
-- Darkweaver Syth 18472,20690
UPDATE `creature_template` SET `armor`='5700',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('18472'); -- 479 970
UPDATE `creature_template` SET `armor`='6450',`speed`='1.48',`mechanic_immune_mask`='787431423',`mindmg`='2535',`maxdmg`='2795',`dmgschool`='5' WHERE `entry` IN ('20690'); -- 804 1195
UPDATE `creature_template` SET `armor`='7100',`faction_H`='16',`faction_A`='16',`speed`='1.71',`spell1`='0',`spell2`='0',`spell3`='0',`mindmg`='1921',`maxdmg`='2232' WHERE `entry` IN ('21990'); -- 727 1349 s1 32901 s2 38059 s3 18144
UPDATE `creature_template` SET `modelid_A2`='18592',`modelid_H2`='18592',`minlevel`='70',`maxlevel`='71',`armor`='7100',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18635',`equipment_id`='1360',`mindmg`='3786',`maxdmg`='4105' WHERE `entry` IN ('20641');
UPDATE `creature_template` SET `modelid_A2`='18192',`modelid_H2`='18192',`minlevel`='70',`armor`='5700',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18794',`equipment_id`='1364',`mindmg`='2558',`maxdmg`='2761' WHERE `entry` IN ('20645');
-- Fel Overseer dmg too low 18796,20652
UPDATE `creature` SET `spawndist`='0' WHERE `id` IN ('18796');
UPDATE `creature_template` SET `mechanic_immune_mask`='4325377',`mindmg`='775',`maxdmg`='1059' WHERE `entry` IN ('18796'); -- 382 666
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18796',`equipment_id`='1075',`mechanic_immune_mask`='4325377',`mindmg`='4105',`maxdmg`='4478' WHERE `entry` IN ('20652'); -- 1773 2519
--
-- Ambassador Hellmaw 18731,20636
UPDATE `creature_template` SET `mindmg`='1975',`maxdmg`='2922' WHERE `entry` IN ('');  -- 906 1853
UPDATE `creature_template` SET `mindmg`='4233',`maxdmg`='4740',`speed`='1.48',`unit_flags`='2147483712',`pickpocketloot`='18731',`equipment_id`='1547',`rank`='1' WHERE `entry` IN ('20636'); --
-- Malicious Instructor 18848,20656
UPDATE `creature` SET `spawndist`='0' WHERE `id` IN ('18848');
UPDATE `creature_template` SET `maxlevel`='70',`mechanic_immune_mask`='4325377',`armor`='6800',`mindmg`='824',`maxdmg`='1113' WHERE `entry` IN ('18848'); -- 427 716
UPDATE `creature_template` SET `minlevel`='71',`armor`='7100',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18848',`equipment_id`='1676',`mechanic_immune_mask`='4325377',`mindmg`='2701',`maxdmg`='3206' WHERE `entry` IN ('20656'); -- 972 1982
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18631',`equipment_id`='361',`mechanic_immune_mask`='1',`mindmg`='2780',`maxdmg`='3011' WHERE `entry` IN ('20640');
UPDATE `creature_template` SET `armor`='7100',`speed`='1.48',`unit_flags`='32832',`lootid`='18636',`pickpocketloot`='18636',`equipment_id`='1288',`mechanic_immune_mask`='1',`mindmg`='3046',`maxdmg`='3469' WHERE `entry` IN ('20639');
--
-- Blackheart the Inciter 18667,20637
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`mindmg`='1411',`maxdmg`='2178' WHERE `entry` IN ('18667'); -- 734 1501 2411 3178
UPDATE `creature_template` SET `speed`='1.48',`rank`='1',`unit_flags`='64',`pickpocketloot`='18667',`equipment_id`='1369',`mechanic_immune_mask`='787431423',`mindmg`='3791',`maxdmg`='4366' WHERE `entry` IN ('20637'); -- 5791 6366
--
-- Cabal Executioner 18632,20642
UPDATE `creature_template` SET `modelid_A2`='18595',`modelid_H2`='18593' WHERE `entry` IN ('18632');
UPDATE `creature_template` SET `modelid_A2`='18595',`modelid_H2`='18595',`minlevel`='71',`maxlevel`='71',`armor`='7100',`speed`='1.48',`unit_flags`='32832',`pickpocketloot`='18632',`equipment_id`='1111',`mindmg`='3091',`maxdmg`='3444' WHERE `entry` IN ('20642'); -- 1280 1987 s1 30485 s2 15578 s3 33500 s4 38959
--
-- Murmur 18708,20657
UPDATE `creature_template` SET `armor`='7387',`minhealth`='411750',`maxhealth`='411750',`mindmg`='3000',`maxdmg`='3500',`baseattacktime`='2500' WHERE `entry` IN ('18708'); -- 1905 2305
UPDATE `creature_template` SET `unit_flags`='64',`speed`='1.48',`minhealth`='575445',`maxhealth`='575445',`mindmg`='5727',`maxdmg`='6138',`rank`='1' WHERE `entry` IN ('20657'); -- 4765 5725
--
-- Lieutenant Drake 17848,20535
UPDATE `creature_template` SET `armor`='6200',`mindmg`='1200',`maxdmg`='1500',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('17848');
UPDATE `creature_template` SET `armor`='7400',`speed`='1.48',`mindmg`='4319',`maxdmg`='4991',`pickpocketloot`='17848',`mechanic_immune_mask`='787431423',`rank`='1' WHERE `entry` IN ('20535'); -- 6500 8500
--
-- Captain Skarloc 17862,20521
UPDATE `creature_template` SET `armor`='6200',`mindmg`='900',`maxdmg`='1200',`equipment_id`='1450' WHERE `entry` IN ('17862');
UPDATE `creature_template` SET `armor`='7400',`speed`='1.48',`mindmg`='5412 ',`maxdmg`='5849',`pickpocketloot`='17862',`mechanic_immune_mask`='787431423',`equipment_id`='1450',`rank`='1' WHERE `entry` IN ('20521');
--
-- Epoch Hunter 18096,20531
UPDATE `creature_template` SET `mindmg`='1600',`maxdmg`='1900' WHERE `entry` IN ('18096');
UPDATE `creature_template` SET `armor`='7400',`speed`='1.48',`mindmg`='5585',`maxdmg`='6317',`rank`='1' WHERE `entry` IN ('20531');
--
-- Chrono Lord Deja 17879,20738
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`minlevel`='72',`maxlevel`='72',`mindmg`='1894',`maxdmg`='2495',`speed`='2',`armor`='5950',`rank`='1' WHERE `entry` IN ('17879'); -- 1263 1663
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`minlevel`='72',`maxlevel`='72',`mindmg`='5169',`maxdmg`='5405',`skinloot`='70066',`speed`='2',`armor`='5950',`rank`='1' WHERE `entry` IN ('20738'); --
-- Infinite Chrono-Lord 21697 when Wipe on Boss on Heroic
UPDATE `creature_template` SET `minlevel`='72',`maxlevel`='72',`faction_A`='14',`faction_H`='14',`armor`='5950',`speed`='2',`mindmg`='5169',`maxdmg`='5405',`baseattacktime`='1400',`unit_flags`='0',`skinloot`='70066',`mingold`='0',`maxgold`='0',`rank`='1' WHERE `entry` IN ('21697'); -- 1
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17879','20738','21697');
INSERT INTO `creature_template_addon` VALUES
(17879,0,0,16908544,0,4097,0,0,'18950 0 18950 1'),
(20738,0,0,16908544,0,4097,0,0,'18950 0 18950 1'),
(21697,0,0,16908544,0,4097,0,0,'18950 0 18950 1');
--
-- Temporus 17880,20745
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`minlevel`='72',`maxlevel`='72',`mindmg`='2381',`maxdmg`='3139',`rank`='1' WHERE `entry` IN ('17880'); -- 1587 2093
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`minlevel`='72',`maxlevel`='72',`mindmg`='5764',`maxdmg`='6216',`skinloot`='70066',`flags_extra`='65537',`rank`='1' WHERE `entry` IN ('20745'); --
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17880','20745');
INSERT INTO `creature_template_addon` VALUES
(17880,0,0,512,0,4097,0,0,'18950 0 18950 1'),
(20745,0,0,512,0,4097,0,0,'18950 0 18950 1');
--
-- Aeonus 17881,20737
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`minlevel`='72',`maxlevel`='72',`mindmg`='3063',`maxdmg`='4037',`rank`='1' WHERE `entry` IN ('17881'); -- 2042 2691
UPDATE `creature_template` SET `faction_A`='14',`faction_H`='14',`minlevel`='72',`maxlevel`='72',`speed`='2.00',`mindmg`='6617',`maxdmg`='7082',`skinloot`='70066',`rank`='1' WHERE `entry` IN ('20737'); --
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17881','20737');
INSERT INTO `creature_template_addon` VALUES
(17881,0,0,512,0,4097,0,0,'18950 0 18950 1'),
(20737,0,0,512,0,4097,0,0,'18950 0 18950 1');
-- https://bitbucket.org/looking4group_b2tbc/looking4group/issues/649/ironforge
--
--
--
-- Waypoints by Malcrom
-- Ironforge waypoints
-- movement for 51
-- movement for 1748

DELETE FROM `creature` WHERE `guid` IN ('105');
INSERT INTO `creature` VALUES
(105,5595,0,1,0,0,-4973.11,-995.715,501.658,1,300,0,0,6300,0,0,0);
--
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=57;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=105;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=1759;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=1760;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=1768;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=1816;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=1889;
UPDATE `creature` SET `MovementType`=2 WHERE `guid`=1894;
UPDATE `creature` SET `position_x`=-4948.85, `position_y`=-1191.17, `position_z`=501.66, `orientation`=3.8315, `MovementType`=2 WHERE `guid`=97;
UPDATE `creature` SET `position_x`=-4979.68, `position_y`=-889.409, `position_z`=501.626, `orientation`=2.248, `MovementType`=2 WHERE `guid`=121;
-- UPDATE `creature` SET `position_x`=-4974.69, `position_y`=-885.103, `position_z`=501.627, `orientation`=2.248,`MovementType`=2 WHERE `guid`=134;
UPDATE `creature` SET `position_x`=-4875.47, `position_y`=-1109.89, `position_z`=502.212, `orientation`=4.45, `MovementType`=2 WHERE `guid`=1895;
UPDATE `creature` SET `position_x`='-4946.4912', `position_y`='-1013.5420', `position_z`='501.4402', `orientation`='1.1881',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('1748');

DELETE FROM `waypoint_data` WHERE `id` IN (570,970,1050,1210,1340,17480,17590,17600,17680,18160,18890,18940);
DELETE FROM `creature_addon` WHERE `guid` IN (57,97,105,121,134,1748,1759,1760,1768,1816,1889,1894);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES 
(57,570,0,0,0,4097,0,0,''),
(97,970,0,0,0,4097,0,0,''),
(105,1050,0,0,0,4097,0,0,''),
(121,1210,0,0,0,4097,0,0,''),
(134,1340,0,0,0,4097,0,0,''),
(1759,17590,0,0,0,4097,0,0,''),
(1760,17600,0,0,0,4097,0,0,''),
(1816,18160,0,0,0,4097,0,0,''),
(1889,18890,0,0,0,4097,0,0,''),
(1894,18940,0,0,0,4097,0,0,'');
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
-- Ironforge Guard GUID 57
(570,1,-4964.79,-1189.22,501.658,0,0,0,100,0),
(570,2,-4988.99,-1159.67,501.658,0,0,0,100,0),
(570,3,-5006.64,-1171.15,501.658,0,0,0,100,0),
(570,4,-5008.46,-1185.28,501.659,0,0,0,100,0),
(570,5,-4984.97,-1224.3,501.675,0,0,0,100,0),
(570,6,-4941.48,-1251.71,501.661,0,0,0,100,0),
(570,7,-4927.58,-1242.83,501.66,0,0,0,100,0),
(570,8,-4928.37,-1229.87,501.651,0,0,0,100,0),
(570,9,-4951.48,-1196.01,501.659,0,0,0,100,0),
-- Ironforge Guard GUID 97
(970,1,-4948.85,-1191.17,501.66,25000,0,0,100,0),
(970,2,-4937.44,-1181.27,501.704,0,0,0,100,0),
(970,3,-4915.41,-1123.8,501.697,0,0,0,100,0),
(970,4,-4883.33,-1115.46,502.212,25000,0,0,100,0),
(970,5,-4915.41,-1123.8,501.697,0,0,0,100,0),
(970,6,-4937.44,-1181.27,501.704,0,0,0,100,0),
-- Ironforge Guard GUID 105
(1050,1,-4973.11,-995.715,501.658,0,0,0,100,0),
(1050,2,-4953.47,-965.801,501.625,0,0,0,100,0),
(1050,3,-4895.93,-918.649,501.633,0,0,0,100,0),
(1050,4,-4858.83,-906.477,501.658,0,0,0,100,0),
(1050,5,-4822.89,-903.525,501.658,0,0,0,100,0),
(1050,6,-4815.19,-904.177,497.97,0,0,0,100,0),
(1050,7,-4783.02,-905.921,497.974,0,0,0,100,0),
(1050,8,-4774.54,-906.29,501.669,0,0,0,100,0),
(1050,9,-4766.49,-905.681,501.636,0,0,0,100,0),
(1050,10,-4753.43,-909.956,501.659,0,0,0,100,0),
(1050,11,-4746.9,-904.996,501.659,0,0,0,100,0),
(1050,12,-4748.57,-895.19,501.659,0,0,0,100,0),
(1050,13,-4798.67,-880.113,501.668,0,0,0,100,0),
(1050,14,-4830.06,-880.588,501.66,0,0,0,100,0),
(1050,15,-4858.91,-883.92,501.66,0,0,0,100,0),
(1050,16,-4901.73,-898.261,501.66,0,0,0,100,0),
(1050,17,-4928.82,-913.658,501.66,0,0,0,100,0),
(1050,18,-4961.98,-941.914,501.66,0,0,0,100,0),
(1050,19,-4982.31,-967.177,501.66,0,0,0,100,0),
(1050,20,-5005.72,-1015.37,501.659,0,0,0,100,0),
(1050,21,-5016.64,-1067.12,501.746,0,0,0,100,0),
(1050,22,-5016.87,-1095.08,501.675,0,0,0,100,0),
(1050,23,-5012.16,-1110.89,501.666,0,0,0,100,0),
(1050,24,-5004.34,-1114.52,501.68,0,0,0,100,0),
(1050,25,-4997.16,-1111.3,501.667,0,0,0,100,0),
(1050,26,-4995.31,-1089.3,501.66,0,0,0,100,0),
(1050,27,-4994.4,-1081.66,497.974,0,0,0,100,0),
(1050,28,-4990.72,-1049.48,497.937,0,0,0,100,0),
(1050,29,-4988.63,-1041.07,501.658,0,0,0,100,0),
-- Ironforge Guard GUID 1210
(1210,1,-4979.68,-889.409,501.626,20000,0,0,100,0),
(1210,2,-4981.46,-897.580,501.598,0,0,0,100,0),
(1210,3,-5011.41,-922.533,501.658,0,0,0,100,0),
(1210,4,-5012.52,-937.796,501.658,0,0,0,100,0),
(1210,5,-4996.93,-956.743,501.659,0,0,0,100,0),
(1210,6,-4986.90,-963.289,501.659,20000,0,0,100,0),
(1210,7,-4996.93,-956.743,501.659,0,0,0,100,0),
(1210,8,-5012.52,-937.796,501.658,0,0,0,100,0),
(1210,9,-5011.41,-922.533,501.658,0,0,0,100,0),
(1210,10,-4981.46,-897.58,501.659,0,0,0,100,0),
(1210,11,-4978.24,-891.15,501.659,0,0,0,100,0),
-- Ironforge Guard GUID 1340
(1340,1,-4974.69,-885.103,501.659,20000,0,0,100,0),
(1340,2,-4966.72,-885.263,501.659,0,0,0,100,0),
(1340,3,-4936.26,-861.016,501.659,0,0,0,100,0),
(1340,4,-4921.77,-861.219,501.659,0,0,0,100,0),
(1340,5,-4905.56,-880.628,501.659,0,0,0,100,0),
(1340,6,-4901.62,-894.978,501.659,20000,0,0,100,0),
(1340,7,-4905.56,-880.628,501.659,0,0,0,100,0),
(1340,8,-4921.77,-861.219,501.659,0,0,0,100,0),
(1340,9,-4936.26,-861.016,501.659,0,0,0,100,0),
(1340,10,-4966.72,-885.263,501.659,0,0,0,100,0),
(1340,11,-4973.23,-886.811,501.617,0,0,0,100,0),
-- Ironforge Guard GUID 1759
(17590,1,-4686.29,-974.5479,501.654,25000,0,0,100,0),
(17590,2,-4700.97,-986.755,501.68,0,0,0,100,0),
(17590,3,-4742.96,-984.416,501.443,0,0,0,100,0),
(17590,4,-4759.35,-994.952,501.696,0,0,0,100,0),
(17590,5,-4771.53,-1020.58,502.18,25000,0,0,100,0),
(17590,6,-4759.35,-994.952,501.696,0,0,0,100,0),
(17590,7,-4742.96,-984.416,501.443,0,0,0,100,0),
(17590,8,-4700.97,-986.755,501.68,0,0,0,100,0),
-- Ironforge Guard GUID 1760
(17600,1,-4702.2,-913.444,501.66,0,0,0,100,0),
(17600,2,-4706.77,-931.115,501.669,0,0,0,100,0),
(17600,3,-4698.04,-942.922,501.671,0,0,0,100,0),
(17600,4,-4687.52,-966.569,501.659,0,0,0,100,0),
(17600,5,-4654.35,-995.542,501.644,0,0,0,100,0),
(17600,6,-4634.24,-996.939,501.658,0,0,0,100,0),
(17600,7,-4621.61,-978.647,501.658,0,0,0,100,0),
(17600,8,-4633.24,-956.669,501.658,0,0,0,100,0),
(17600,9,-4648.21,-936.882,501.658,0,0,0,100,0),
(17600,10,-4684.75,-906.271,501.663,0,0,0,100,0),
-- Bimble LongBerry GUID 1768
(17680,1,-4640.85,-1014.54,501.648,0,0,0,100,0),
(17680,2,-4681.18,-969.568,501.658,0,0,0,100,0),
(17680,3,-4689.31,-949.094,501.658,0,0,0,100,0),
(17680,4,-4711.22,-922.766,501.66,0,0,0,100,0),
(17680,5,-4709.47,-906.969,501.66,0,0,0,100,0),
(17680,6,-4668.06,-918.75,501.654,0,0,0,100,0),
(17680,7,-4625.97,-969.373,501.661,0,0,0,100,0),
(17680,8,-4617.51,-1000.31,501.66,0,0,0,100,0),
(17680,9,-4626.04,-1011.51,501.654,0,0,0,100,0),
-- Srazz GUID 18160
(18160,1,-4740.8,-1139.15,502.211,0,0,0,100,0),
(18160,2,-4773.54,-1165.29,502.198,0,0,0,100,0),
(18160,3,-4815,-1167.08,502.207,0,0,0,100,0),
(18160,4,-4854.2,-1142.88,502.198,0,0,0,100,0),
(18160,5,-4865.82,-1123.32,502.211,0,0,0,100,0),
(18160,6,-4873.33,-1091.37,502.212,0,0,0,100,0),
(18160,7,-4829.84,-1085.12,502.204,0,0,0,100,0),
(18160,8,-4812.65,-1065.7,502.198,0,0,0,100,0),
(18160,9,-4810.09,-1034.03,502.205,0,0,0,100,0),
(18160,10,-4798.15,-1025.7,502.205,0,0,0,100,0),
(18160,11,-4764.56,-1040.37,502.211,0,0,0,100,0),
(18160,12,-4737.27,-1073.11,502.181,0,0,0,100,0),
(18160,13,-4733.47,-1103.05,502.217,0,0,0,100,0),
-- Ironforge Guard GUID 1889
(18890,1,-4698.34,-1235.72,501.66,0,0,0,100,0),
(18890,2,-4684.51,-1223.77,501.66,0,0,0,100,0),
(18890,3,-4670.89,-1218.99,501.66,0,0,0,100,0),
(18890,4,-4656,-1205.27,501.66,0,0,0,100,0),
(18890,5,-4666.46,-1192.5,501.66,0,0,0,100,0),
(18890,6,-4708.63,-1204.13,501.66,0,0,0,100,0),
(18890,7,-4720.4,-1213.46,501.66,0,0,0,100,0),
(18890,8,-4738.66,-1248.02,501.658,0,0,0,100,0),
(18890,9,-4732.05,-1261.34,501.658,0,0,0,100,0),
(18890,10,-4721.72,-1265.11,501.658,0,0,0,100,0),
(18890,11,-4706.02,-1248.55,501.658,0,0,0,100,0),
-- Ironforge Guard GUID 1894
(18940,1,-4747.57,-1146.17,502.187,0,0,0,100,0),
(18940,2,-4761.59,-1144.39,502.212,0,0,0,100,0),
(18940,3,-4765.64,-1139.26,502.176,0,0,0,100,0),
(18940,4,-4772.97,-1131.33,498.817,0,0,0,100,0),
(18940,5,-4791.44,-1112.72,498.806,0,0,0,100,0),
(18940,6,-4792.1,-1105.74,498.806,0,0,0,100,0),
(18940,7,-4801.78,-1093.3,498.807,0,0,0,100,0),
(18940,8,-4810.22,-1083.11,502.213,0,0,0,100,0),
(18940,9,-4813.46,-1078.89,502.214,0,0,0,100,0),
(18940,10,-4808.55,-1034.37,502.206,0,0,0,100,0),
(18940,11,-4799.75,-1027.15,502.206,0,0,0,100,0),
(18940,12,-4764.62,-1038.91,502.211,0,0,0,100,0),
(18940,13,-4747.19,-1056.31,502.211,0,0,0,100,0),
(18940,14,-4735.21,-1078.32,502.211,0,0,0,100,0),
(18940,15,-4732.27,-1104.52,502.218,0,0,0,100,0);
--
--
--
-- Thief Catcher Farmountain
-- http://wowwiki.wikia.com/wiki/Thief_Catcher_Farmountain?oldid=2348906
UPDATE `creature_template` SET `speed`='1.48' WHERE `entry` IN ('14365');
-- Pathing for  Entry: 14365
SET @NPC := 91;
SET @PATH := 9100;
UPDATE `creature` SET `spawndist`=0,`MovementType`=2,`position_x`=-4947.035,`position_y`=-922.7908,`position_z`=504.3236 WHERE `guid`=@NPC;
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`, `moveflags`, `auras`) VALUES (@NPC,@PATH,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
(@PATH,1,-4946.134,-927.5173,502.4982,0,0,0,100,0),
(@PATH,2,-4972.212,-956.0469,502.0974,0,0,0,100,0), 
(@PATH,3,-4991.725,-979.0193,501.9094,0,0,0,100,0),
(@PATH,4,-4993.961,-991.7936,501.9101,0,0,0,100,0),
(@PATH,5,-5004.43,-1019.039,501.9083,0,0,0,100,0),
(@PATH,6,-5012.757,-1048.226,501.9562,0,0,0,100,0),
(@PATH,7,-5015.443,-1090.132,501.9537,0,0,0,100,0),
(@PATH,8,-5012.187,-1111.397,501.9231,0,0,0,100,0),
(@PATH,9,-5008.548,-1114.885,501.9287,0,0,0,100,0), 
(@PATH,10,-5003.436,-1138.518,501.9221,0,0,0,100,0), 
(@PATH,11,-4999.213,-1172.706,501.9114,0,0,0,100,0),
(@PATH,12,-4984.045,-1221.896,501.9141,0,0,0,100,0), 
(@PATH,13,-4944.952,-1255.237,501.9203,0,0,0,100,0),
(@PATH,14,-4941.766,-1255.001,501.9109,0,0,0,100,0), 
(@PATH,15,-4923.513,-1238.097,501.9083,0,0,0,100,0),
(@PATH,16,-4944.066,-1215.419,501.9085,0,0,0,100,0),
(@PATH,17,-4963.118,-1194.325,501.896,0,0,0,100,0),
(@PATH,18,-4986.466,-1158.898,501.9022,0,0,0,100,0), 
(@PATH,19,-4996.452,-1120.04,501.8776,0,0,0,100,0), 
(@PATH,20,-4995.342,-1096.088,501.887,0,0,0,100,0),
(@PATH,21,-4992.534,-1059.457,498.281,0,0,0,100,0),
(@PATH,22,-4989.592,-1042.671,501.8037,0,0,0,100,0),
(@PATH,23,-4985.588,-1026.322,501.9061,0,0,0,100,0),
(@PATH,'24','-4976.9531','-1001.5249','501.6541','0','0','0','100','0'),
(@PATH,'25','-4921.0556','-955.3184','501.5118','0','0','0','100','0'), -- bank mitte
(@PATH,'26','-4902.7158','-977.7073','501.4405','0','0','0','100','0'),
(@PATH,'27','-4900.1845','-980.8189','503.9409','0','0','0','100','0'),
(@PATH,'28','-4892.0288','-990.5587','503.9409','0','0','0','100','0'), -- bank innen mitte
(@PATH,'29','-4884.0664','-983.7366','503.9409','0','0','0','100','0'),
(@PATH,'30','-4901.4233','-997.7728','503.9409','0','0','0','100','0'),
(@PATH,'31','-4892.0288','-990.5587','503.9409','0','0','0','100','0'), -- bank innen mitte
(@PATH,'32','-4900.1845','-980.8189','503.9409','0','0','0','100','0'),
(@PATH,'33','-4902.7158','-977.7073','501.4405','0','0','0','100','0'),
(@PATH,'34','-4921.0556','-955.3184','501.5118','0','0','0','100','0'), -- bank mitte
(@PATH,'35','-4937.5566','-935.5794','503.1448','0','0','0','100','0'),
(@PATH,'36','-4944.0502','-927.5317','501.6601','0','0','0','100','0'), -- AH raus
(@PATH,'37','-4948.8857','-921.5205','504.2634','0','0','0','100','0'), 
(@PATH,'38','-4958.6230','-909.5149','503.8370','0','0','0','100','0'), -- AH Mitte
(@PATH,'39','-4951.3999','-903.7335','503.8375','0','0','0','100','0'), 
(@PATH,'40','-4964.6879','-915.1539','503.8360','0','0','0','100','0'), 
(@PATH,'41','-4958.6230','-909.5149','503.8370','0','0','0','100','0'), -- AH Mitte
(@PATH,'42','-4948.8857','-921.5205','504.2634','0','0','0','100','0'), 
(@PATH,'43','-4944.0502','-927.5317','501.6601','0','0','0','100','0'); -- AH raus neuer spawn
-- despawn Kokorek
UPDATE `creature` SET `spawnmask`='0' WHERE `guid` IN ('85527');

-- add missing npcs
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65530', '18260', '530', '1', '0', '0', '-3215.25', '5982.57', '0.56763', '4.44929', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65532', '18260', '530', '1', '0', '0', '-3243.22', '5950.62', '-0.044451', '6.25464', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65533', '18260', '530', '1', '0', '0', '-3263.04', '5993.29', '-2.88212', '2.63545', '120', '0', '0', '5715', '0', '0', '0');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65534', '18260', '530', '1', '0', '0', '-3251.22', '6040.85', '3.02951', '3.52651', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65535', '18260', '530', '1', '0', '0', '-3263.52', '6006.19', '-2.0689', '3.64774', '120', '0', '0', '5715', '0', '0', '0');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65536', '18260', '530', '1', '0', '0', '-3278.06', '6049.26', '1.82642', '1.1252', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65537', '18260', '530', '1', '0', '0', '-3344.32', '5990.1', '-2.95462', '3.06687', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65538', '18260', '530', '1', '0', '0', '-3318.78', '5949.15', '-5.76096', '2.63723', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65539', '18260', '530', '1', '0', '0', '-3317.26', '5964.73', '-3.01096', '5.2333', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65540', '18260', '530', '1', '0', '0', '-3348.39', '6014.39', '0.58407', '5.20101', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65541', '18260', '530', '1', '0', '0', '-3319.37', '6051.57', '0.0778', '1.76593', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65542', '18260', '530', '1', '0', '0', '-3317.22', '6080.94', '1.50055', '5.92966', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65543', '18260', '530', '1', '0', '0', '-3314.86', '6015.68', '0.01053', '5.88851', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65544', '18260', '530', '1', '0', '0', '-3380.4', '5985.86', '-7.73129', '4.7551', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65545', '18260', '530', '1', '0', '0', '-3380.74', '6014.02', '-5.80249', '5.45422', '120', '5', '0', '5715', '0', '0', '1');
REPLACE INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES ('65547', '18262', '530', '1', '0', '0', '-3276.79', '5999.96', '-2.55379', '6.26573', '150', '0', '0', '9300', '0', '0', '0');
--
UPDATE creature SET position_z='-70.9617' WHERE guid IN (87125);
--
UPDATE `creature_template` SET `minlevel`='68',`maxlevel`='68',`armor`='6200',`minhealth`='10000',`maxhealth`='10000',`ScriptName`='mob_unkor_the_ruthless',`npcflag`='3' WHERE `entry` IN ('18262'); -- 65 20 9300
UPDATE creature SET position_z='-79.2175' WHERE guid IN (52598);
UPDATE creature SET position_z='-55.4227' WHERE guid IN (86048);
-- Fix Some NPC Spawn Position and Z Value Issues In Blackfathom Deeps
UPDATE creature SET position_x='-303.8273', position_y='344.955', position_z='-53.5', orientation='3.472466', spawndist=0, movementtype=0 WHERE guid IN (26120);
-- Fix Some NPC Spawn Position and Z Value Issues In Blackfathom Deeps
UPDATE creature SET position_x='-303.8273', position_y='344.955', position_z='-53.5', orientation='3.472466', spawndist=0, movementtype=0 WHERE guid IN (26120);
-- Sen'jin Watcher
UPDATE creature SET MovementType = 2, spawndist = 0 WHERE guid = 6401;
SET @NPC := 6401;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
(@PATH,1,-827.616,-4936.48,20.8528,0,0,0,100,0),
(@PATH,2,-830.761,-4929.45,20.5111,0,0,0,100,0),
(@PATH,3,-839.201,-4923.22,20.6271,0,0,0,100,0),
(@PATH,4,-841.734,-4919.66,20.5596,0,0,0,100,0),
(@PATH,5,-841.262,-4914.79,20.2692,0,0,0,100,0),
(@PATH,6,-838.219,-4907.74,19.9134,0,0,0,100,0),
(@PATH,7,-830.196,-4901.08,19.8305,0,0,0,100,0),
(@PATH,8,-820.589,-4896.57,19.2993,0,0,0,100,0),
(@PATH,9,-813.357,-4898.34,19.1296,0,0,0,100,0),
(@PATH,10,-805.803,-4902.86,19.3516,0,0,0,100,0),
(@PATH,11,-799.058,-4902.18,19.4843,0,0,0,100,0),
(@PATH,12,-795.003,-4900.82,19.5072,0,0,0,100,0),
(@PATH,13,-791.825,-4901.95,19.5425,0,0,0,100,0),
(@PATH,14,-789.253,-4903.92,19.5929,0,0,0,100,0),
(@PATH,15,-789.067,-4907.64,19.6142,0,0,0,100,0),
(@PATH,16,-790.609,-4909.58,19.5996,0,0,0,100,0),
(@PATH,17,-794.697,-4910.41,19.548,0,0,0,100,0),
(@PATH,18,-802.157,-4910.6,19.3913,0,0,0,100,0),
(@PATH,19,-807.364,-4913.22,19.2282,0,0,0,100,0),
(@PATH,20,-817.404,-4923.08,19.4963,0,0,0,100,0),
(@PATH,21,-821.698,-4931.91,20.2532,0,0,0,100,0),
(@PATH,22,-819.679,-4936.64,20.7199,0,0,0,100,0),
(@PATH,23,-821.131,-4940.8,21.2849,0,0,0,100,0);
-- Ula'elek
DELETE FROM `creature_addon` WHERE `guid`=6490;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (6490,0,0,0,0,4097,173,0,'');
--
-- Menethil Harbour NPCs
-- Updates for NPCs with random movement
UPDATE `creature` SET `spawndist`=4, `MovementType`=1 WHERE `guid`=9453;
UPDATE `creature` SET `spawndist`=2, `MovementType`=1 WHERE `guid`=9464;
UPDATE `creature` SET `spawndist`=0, `MovementType`=0 WHERE `guid`=9504;
UPDATE `creature` SET `spawndist`=1, `MovementType`=1 WHERE `guid`=9527;
UPDATE `creature` SET `spawndist`=2, `MovementType`=1 WHERE `guid`=9528;
UPDATE `creature` SET `spawndist`=3, `MovementType`=1 WHERE `guid`=9554;
-- UPDATE `creature` SET `spawndist`=4, `MovementType`=1 WHERE `guid`=9555;


UPDATE `creature` SET `spawndist`=3, `MovementType`=1 WHERE `guid`=9561;
UPDATE `creature` SET `spawndist`=3, `MovementType`=1 WHERE `guid`=9562;
UPDATE `creature` SET `spawndist`=2, `MovementType`=1 WHERE `guid`=9697;
UPDATE `creature` SET `position_x`=-3667.17, `position_y`=-884.368, `position_z`=9.95435, `orientation`=0.6876, `spawndist`=4, `MovementType`=1 WHERE `guid`=9454;
UPDATE `creature` SET `position_x`=-3646.95, `position_y`=-835.279, `position_z`=9.65445, `orientation`=5.7590 WHERE `guid`=9456;

-- Updates for NPCs with Waypoints
UPDATE `creature` SET `position_x`=-3767.47, `position_y`=-778.853, `position_z`=8.91371, `orientation`=5.1637, `MovementType`=2 WHERE `guid`=9475;
UPDATE `creature` SET `position_x`=-3602.91, `position_y`=-711.051, `position_z`=6.48002, `orientation`=6.1372, `MovementType`=2 WHERE `guid`=9695;
UPDATE `creature` SET `position_x`=-3793.04, `position_y`=-862.698, `position_z`=11.5974, `orientation`=2.2355, `MovementType`=2 WHERE `guid`=9461;
UPDATE `creature` SET `position_x`=-3822.19, `position_y`=-767.092, `position_z`=10.0241, `orientation`=3.24575, `MovementType`=2 WHERE `guid`=9514;
UPDATE `creature` SET `position_x`=-3797.76, `position_y`=-866.926, `position_z`=11.5981, `orientation`=3.216594, `MovementType`=2 WHERE `guid`=9522;
UPDATE `creature` SET `position_x`=-3776.6, `position_y`=-797.833, `position_z`=8.69004, `orientation`=2.882, `MovementType`=2 WHERE `guid`=9525;
UPDATE `creature` SET `position_x`=-3730.16, `position_y`=-807.502, `position_z`=20.3016, `orientation`=4.23419, `MovementType`=2 WHERE `guid`=9557;
UPDATE `creature` SET `position_x`=-3758.33, `position_y`=-855.729, `position_z`=10.0241, `orientation`=4.46419, `MovementType`=2 WHERE `guid`=9563;
UPDATE `creature` SET `position_x`=-3743.22, `position_y`=-797.57, `position_z`=11.4796, `orientation`=2.64953, `MovementType`=2 WHERE `guid`=9570;
UPDATE `creature` SET `position_x`=-3713.02, `position_y`=-735.669, `position_z`=10.9144, `orientation`=2.64953, `MovementType`=2 WHERE `guid`=9696;

DELETE FROM `creature_addon` WHERE `guid` IN (9461,9514,9522,9525,9557,9563,9570,9696,9475,9695);
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES 
(9461,94610,0,0,0,4097,0,0,''),
(9514,95140,0,0,0,4097,0,0,''),
(9522,95220,0,0,0,4097,0,0,''),
(9525,95250,0,0,0,4097,0,0,''),
(9557,95570,0,0,0,4097,0,0,''),
(9563,95630,0,0,0,4097,0,0,''),
(9570,95700,0,0,0,4097,0,0,''),
(9696,96960,0,0,0,4097,0,0,''),
(9475,94750,0,0,0,4097,0,0,''),
(9695,96950,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id` IN(94610,95140,95220,95250,95570,95630,95700,96960,94750,96950);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
-- Brak Durnad GUID 9461
(94610,1,-3793.04,-862.698,11.5974,9000,0,0,100,0),
(94610,2,-3788.95,-868.414,11.5929,10000,0,0,100,0),
-- Menethil Sentry GUID 9514
(95140,1,-3822.19,-767.092,8.06787,0,0,0,100,0),
(95140,2,-3831.28,-776.409,8.05275,0,0,0,100,0),
(95140,3,-3833.04,-777.78,6.23465,0,0,0,100,0),
(95140,4,-3838.14,-778.421,4.5457,0,0,0,100,0),
(95140,5,-3833.87,-805.345,9.64904,0,0,0,100,0),
(95140,6,-3856.37,-822.15,8.59936,0,0,0,100,0),
(95140,7,-3856.07,-831.333,9.17249,1000,0,0,100,0),
(95140,8,-3856.37,-822.15,8.59936,0,0,0,100,0),
(95140,9,-3833.87,-805.345,9.64904,0,0,0,100,0),
(95140,10,-3838.14,-778.421,4.5457,0,0,0,100,0),
(95140,11,-3833.04,-777.78,6.23465,0,0,0,100,0),
(95140,12,-3831.28,-776.409,8.05275,0,0,0,100,0),
(95140,13,-3822.19,-767.092,8.06787,0,0,0,100,0),
(95140,14,-3806.91,-765.37,8.0228,1000,0,0,100,0),
-- Brahnmar GUID 9522
(95220,1,-3797.76,-866.926,11.5981,7000,0,0,100,0),
(95220,2,-3795.23,-863.794,11.598,10000,0,0,100,0),
-- Camerick Jougleur GUID 9525
(95250,1,-3776.6,-797.833,8.69004,29000,0,0,100,0),
(95250,2,-3778.79,-800.852,8.57007,0,0,0,100,0),
(95250,3,-3778.43,-807.106,8.86214,0,0,0,100,0),
(95250,4,-3775.92,-808.031,9.76186,0,0,0,100,0),
(95250,5,-3775.25,-806.261,9.89661,12000,0,0,100,0),
(95250,6,-3772.94,-807.634,10.4204,0,0,0,100,0),
(95250,7,-3770.64,-805.001,10.3747,0,0,0,100,0),
(95250,8,-3768.57,-799.271,9.746,0,0,0,100,0),
(95250,9,-3772.09,-796.733,9.22766,13000,0,1029,100,0), -- Script 466 emote point.
(95250,10,-3770.23,-794.62,9.36567,0,0,0,100,0),
(95250,11,-3772.34,-792.51,8.97663,0,0,0,100,0),
(95250,12,-3774.92,-791.916,8.61633,0,0,0,100,0),
(95250,13,-3776.59,-793.099,8.51261,0,0,0,100,0),
(95250,14,-3775.36,-798.295,8.85547,0,0,0,100,0),
-- Menethil Sentry GUID 9557
(95570,1,-3730.16,-807.502,20.3016,0,0,0,100,0),
(95570,2,-3723.6,-795.39,20.3016,0,0,0,100,0),
(95570,3,-3727.46,-792.542,20.1036,0,0,0,100,0),
(95570,4,-3733.06,-789.129,15.4086,0,0,0,100,0),
(95570,5,-3736.24,-787.182,15.4086,0,0,0,100,0),
(95570,6,-3738.61,-790.885,15.1369,0,0,0,100,0),
(95570,7,-3741.1,-794.995,11.4798,0,0,0,100,0),
(95570,8,-3743.26,-798.874,11.4798,0,0,0,100,0),
(95570,9,-3741.1,-794.995,11.4798,0,0,0,100,0),
(95570,10,-3738.61,-790.885,15.1369,0,0,0,100,0),
(95570,11,-3736.24,-787.182,15.4086,0,0,0,100,0),
(95570,12,-3733.06,-789.129,15.4086,0,0,0,100,0),
(95570,13,-3727.46,-792.542,20.1036,0,0,0,100,0),
(95570,14,-3723.6,-795.39,20.3016,0,0,0,100,0),
-- Naela Trance GUID 9563
(95630,1,-3758.33,-855.729,10.0241,8000,0,0,100,0),
(95630,2,-3757.78,-855.045,9.90017,1000,0,0,100,0),
(95630,3,-3755.05,-857.688,9.90017,0,0,0,100,0),
(95630,4,-3750.88,-854.487,10.3368,0,0,0,100,0),
(95630,5,-3751.38,-853.43,10.3055,9000,0,0,100,0),
(95630,6,-3754.08,-857.361,9.89969,0,0,0,100,0),
(95630,7,-3757.78,-855.045,9.90017,0,0,0,100,0),
-- Murphy West GUID 9570
(95700,1,-3743.22,-797.57,11.4796,45000,0,0,100,0),
(95700,2,-3743.28,-798.991,11.4801,0,0,0,100,0),
(95700,3,-3728.19,-806.318,11.4801,0,0,0,100,0),
(95700,4,-3723.09,-795.092,11.4801,0,0,0,100,0),
(95700,5,-3726.25,-793.331,11.4798,0,0,0,100,0),
(95700,6,-3737.96,-786.927,4.68735,0,0,0,100,0),
(95700,7,-3739.68,-792.001,4.32461,0,0,0,100,0),
(95700,8,-3738,-799.006,4.32461,60000,0,0,100,0), -- movement should switch to random for 60 sec spawndist 4
(95700,9,-3739.68,-792.001,4.32461,0,0,0,100,0),
(95700,10,-3737.96,-786.927,4.68735,0,0,0,100,0),
(95700,11,-3726.25,-793.331,11.4798,0,0,0,100,0),
(95700,12,-3723.09,-795.092,11.4801,0,0,0,100,0),
(95700,13,-3728.19,-806.318,11.4801,0,0,0,100,0),
-- Menethil Sentry GUID 9696
(96960,1,-3713.02,-735.669,10.9144,0,0,0,100,0),
(96960,2,-3719.48,-737.253,11.0237,0,0,0,100,0),
(96960,3,-3712.89,-721.908,9.86457,0,0,0,100,0),
(96960,4,-3710.79,-719.43,9.70997,0,0,0,100,0),
(96960,5,-3710.14,-714.073,10.0695,0,0,0,100,0),
(96960,6,-3708.34,-711.863,8.7437,0,0,0,100,0),
(96960,7,-3689.72,-695.789,5.30313,1000,0,0,100,0),
(96960,8,-3708.34,-711.863,8.7437,0,0,0,100,0),
(96960,9,-3710.14,-714.073,10.0695,0,0,0,100,0),
(96960,10,-3710.79,-719.43,9.70997,0,0,0,100,0),
(96960,11,-3712.89,-721.908,9.86457,0,0,0,100,0),
(96960,12,-3719.48,-737.253,11.0237,0,0,0,100,0),
-- Bart Tidewater GUID 9475
(94750,1,-3767.47,-778.853,8.91371,9000,0,0,100,0),
(94750,2,-3766.09,-775.896,8.82388,0,0,0,100,0),
(94750,3,-3767.08,-765.029,8.01714,0,0,0,100,0),
(94750,4,-3765.77,-753.063,7.872,0,0,0,100,0),
(94750,5,-3753.29,-746.688,7.9276,0,0,0,100,0),
(94750,6,-3743.20,-746.79,8.49915,38000,0,0,100,0), -- movement should switch to random for 60 sec spawndist 4
(94750,7,-3763.94,-751.883,7.873,0,0,0,100,0),
(94750,8,-3767.2,-749.197,7.99052,0,0,0,100,0),
(94750,9,-3769.32,-745.156,8.00674,0,0,0,100,0),
(94750,10,-3760.97,-735.759,8.03362,0,0,0,100,0),
(94750,11,-3739.74,-721.4,8.34226,0,0,0,100,0),
(94750,12,-3733.03,-717.09,8.31754,0,0,0,100,0),
(94750,13,-3736.66,-717.01,8.32097,30000,0,0,100,0), -- movement should switch to random for 60 sec spawndist 4
(94750,14,-3767.1,-737.135,8.04506,0,0,0,100,0),
(94750,15,-3782.87,-746.452,8.03465,0,0,0,100,0),
(94750,16,-3797.23,-755.576,8.03365,50000,0,0,100,0), -- movement should switch to random for 60 sec spawndist 4
(94750,17,-3783.72,-763.875,7.60233,0,0,0,100,0),
(94750,18,-3779.46,-761.803,7.65703,0,0,0,100,0),
(94750,19,-3771.77,-768.995,8.02206,0,0,0,100,0),
-- Menethil Sentry GUID 9695
(96950,1,-3602.91,-711.051,6.48002,0,0,0,100,0),
(96950,2,-3613.58,-706.494,8.29125,0,0,0,100,0),
(96950,3,-3620.7,-710.571,9.53107,0,0,0,100,0),
(96950,4,-3626.76,-710.311,9.59993,0,0,0,100,0),
(96950,5,-3627.08,-714.309,9.88046,0,0,0,100,0),
(96950,6,-3627.75,-723.77,10.5426,1000,0,0,100,0),
(96950,7,-3627.08,-714.309,9.88046,0,0,0,100,0),
(96950,8,-3626.76,-710.311,9.59993,0,0,0,100,0),
(96950,9,-3620.7,-710.571,9.53107,0,0,0,100,0),
(96950,10,-3613.58,-706.494,8.29125,0,0,0,100,0),
(96950,11,-3602.91,-711.051,6.48002,0,0,0,100,0),
(96950,12,-3622.45,-698.266,6.27468,0,0,0,100,0),
(96950,13,-3645.15,-694.848,5.30492,1000,0,0,100,0),
(96950,14,-3621.2,-699.579,6.92538,0,0,0,100,0);
--
-- Scripts
DELETE FROM `waypoint_scripts` WHERE `id`=1029;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES
(1029,0,1,29,1,0,0,0,0,0,1029);
-- fire dmg for Enraged Fire Spirit
UPDATE `creature_template` SET `dmgschool`='2' WHERE `entry` IN ('21061');
--
UPDATE `creature` SET `movementtype`='2' WHERE `guid` IN ('9468');
SET @NPC := 9468;
SET @PATH := @NPC * 10;  
DELETE FROM `creature_addon` WHERE `guid`=@NPC;
INSERT INTO `creature_addon` (`guid`,`path_id`,`mount`,`bytes0`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (@NPC,@PATH,0,0,0,4097,0,0,'');
DELETE FROM `waypoint_data` WHERE `id`=@PATH;
INSERT INTO `waypoint_data` (`id`,`point`,`position_x`,`position_y`,`position_z`,`delay`,`move_type`,`action`,`action_chance`,`wpguid`) VALUES
-- (@PATH,1,'XXX','YYY','ZZZ',0,0,0,100,0),
-- Horse and trainer
(@PATH,1,-3644.88,-754.938,9.86772,3000,0,0,100,0),
(@PATH,2,-3651.28,-755.471,9.88141,0,0,0,100,0),
(@PATH,3,-3654.63,-751.725,9.87952,0,0,0,100,0),
(@PATH,4,-3655.63,-745.931,9.85159,0,0,0,100,0),
(@PATH,5,-3651.79,-737.735,9.83451,0,0,0,100,0),
(@PATH,6,-3648.7,-734.25,9.98569,0,0,0,100,0),
(@PATH,7,-3638.53,-739.414,9.77649,0,0,0,100,0);

DELETE FROM `creature_formations` WHERE `leaderGUID`=9468;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(9468,9468,0,0,0),
(9468,9469,2,225,0);
--
-- Wrong random movement
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `id`=17279;
UPDATE `creature` SET `spawndist`=0,`MovementType`=0 WHERE `guid` IN (61974,61973,61972,61971,61970,61969,61968,61967);
--
-- sign posts y value
UPDATE `gameobject` SET `position_x`=-8825.4,`position_y`=957.33,`position_z`=98.247,`orientation`=-2.45218 WHERE `guid`=42866;
-- Wrong Arena promoter
DELETE FROM `creature` WHERE `guid`=86498;
-- SW Marine missing equipment
UPDATE `creature_template` SET `equipment_id`=10000 WHERE `entry`=20556;
DELETE FROM `creature_equip_template` WHERE `entry`=10000;
INSERT INTO `creature_equip_template` VALUES (10000,28544,2594,0,218171138,234948100,0,3,1038,0);
--  Megelon kneel emote
DELETE FROM `creature_template_addon` WHERE `entry`=16475;
INSERT INTO `creature_template_addon` (`entry`,`mount`,`bytes1`,`bytes2`,`emote`,`moveflags`,`auras`) VALUES (16475,0,8,4097,0,0,'');
-- SW Druid trainer missing class quest
UPDATE `creature_questrelation` SET `id`=5505 WHERE `quest`=5924;
-- Critters stats
UPDATE `creature_template` SET `minhealth`=100, `maxhealth`=100  WHERE `entry`=2442;
UPDATE `creature_template` SET `minhealth`=15, `maxhealth`=15  WHERE `entry`=4166;
UPDATE `creature_template` SET `minhealth`=14, `maxhealth`=14  WHERE `entry`=12296;
UPDATE `creature_template` SET `minhealth`=100, `maxhealth`=100  WHERE `entry`=20411;
UPDATE `creature_template` SET `minhealth`=9813, `maxhealth`=9813  WHERE `entry`=20415;
-- Ammen Vale Guardian health fix
UPDATE `creature_template` SET `minhealth`=11828,`maxhealth`=11828 WHERE `entry`=16921;
-- Ensure Spell 34665 will only work on creature 16880 "Hulking Helboar".
DELETE FROM `spell_script_target` WHERE `entry`=34665;
INSERT INTO `spell_script_target` (`entry`,`type`,`targetEntry`) VALUES (34665,1,16880);
-- Ensure Spell 33909 will only work on creature 16880 "Hulking Helboar".
DELETE FROM `spell_script_target` WHERE `entry`=33909;
INSERT INTO `spell_script_target` (`entry`,`type`,`targetEntry`) VALUES (33909,1,16880);

UPDATE `gameobject` SET `state` = 0 WHERE `id` IN (SELECT `entry` FROM `gameobject_template` WHERE `type` = 0 AND `data0` = 1);
UPDATE `creature_template` SET `unit_flags`=`unit_flags`&~2056 WHERE `unit_flags`&2048=2048 OR `unit_flags`&8=8;
UPDATE `creature`, `creature_template` SET `creature`.`curhealth`=`creature_template`.`minhealth`,`creature`.`curmana`=`creature_template`.`minmana` WHERE `creature`.`id`=`creature_template`.`entry` and `creature_template`.`RegenHealth` = '1';
UPDATE `creature_template` SET `dynamicflags` = `dynamicflags`&~4;
UPDATE `gameobject_template` SET `flags`=`flags`&~4 WHERE `type` IN (2,19,17);
UPDATE `creature` SET `MovementType` = 0 WHERE `spawndist` = 0 AND `MovementType`=1;
UPDATE `creature` SET `spawndist`=0 WHERE `MovementType`=0;
UPDATE `quest_template` SET `SpecialFlags`=`SpecialFlags`|1 WHERE `QuestFlags`=`QuestFlags`|4096;
DELETE FROM go,gt USING `gameobject` go LEFT JOIN `gameobject_template` gt ON go.`id`=gt.`entry` WHERE gt.`entry` IS NULL;
DELETE FROM gi,gt USING `gameobject_involvedrelation` gi LEFT JOIN `gameobject_template` gt ON gi.`id`=gt.`entry` WHERE gt.`entry` IS NULL;
DELETE FROM gqr,gt USING `gameobject_questrelation` gqr LEFT JOIN `gameobject_template` gt ON gqr.`id`=gt.`entry` WHERE gt.`entry` IS NULL;
DELETE FROM ge,go USING `game_event_gameobject` ge LEFT JOIN `gameobject` go ON ge.`guid`=go.`guid` WHERE go.`guid` IS NULL;
DELETE FROM `gameobject_scripts` WHERE `id` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `gameobject_scripts` WHERE `command` in (11, 12) and `datalong` NOT IN (SELECT `guid` FROM `gameobject`);
DELETE FROM `creature_addon` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `npc_gossip` WHERE `npc_guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `game_event_creature` WHERE `guid` NOT IN (SELECT `guid` FROM `creature`);
DELETE FROM `creature_questrelation` WHERE `id` NOT IN (SELECT `entry` FROM `creature_template`);
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` NOT IN (SELECT `entry` FROM `creature_template`);
UPDATE `creature_template` SET `npcflag`=`npcflag`|2 WHERE `entry` IN (SELECT `id` FROM `creature_questrelation` UNION SELECT `id` FROM `creature_involvedrelation`);
--
-- Syth Fire Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance2`='345' WHERE `entry` IN ('19203');
UPDATE `creature_template` SET `resistance2`='0' WHERE `entry` IN ('20703');
--
-- Syth Frost Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance4`='345' WHERE `entry` IN ('19204');
UPDATE `creature_template` SET `resistance4`='0' WHERE `entry` IN ('20704');
--
-- Syth Arcane Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance6`='345' WHERE `entry` IN ('19205');
UPDATE `creature_template` SET `minhealth`='5903',`maxhealth`='5903',`resistance6`='0' WHERE `entry` IN ('20702');
--
-- Syth Shadow Elemental
UPDATE `creature_template` SET `speed`='1.20',`resistance5`='345' WHERE `entry` IN ('19206');
UPDATE `creature_template` SET `resistance5`='0' WHERE `entry` IN ('20705');
--
DELETE FROM `creature_template_addon` WHERE `entry` IN (19203,19204,19205,19206); 
INSERT INTO `creature_template_addon` VALUES
(19203,0,0,0,0,4097,0,0,'7942 0'),
(19204,0,0,0,0,4097,0,0,'7940 0'),
(19205,0,0,0,0,4097,0,0,'34184 0'),
(19206,0,0,0,0,4097,0,0,'7743 0');
-- escort mob dies on spawn
UPDATE `creature_template` SET `flags_extra`='0',`unit_flags`='0' WHERE `entry` IN ('7780');
-- Containment Beam Trigger NPC
UPDATE `creature_template` SET `scale`='3' WHERE `entry` IN ('21159');
--
-- Symbol of Divinity
UPDATE `item_template` SET `SellPrice`='0' WHERE `entry` IN ('17033'); -- 500
-- Symbol of Kings
UPDATE `item_template` SET `SellPrice`='0' WHERE `entry` IN ('21177'); -- 37
