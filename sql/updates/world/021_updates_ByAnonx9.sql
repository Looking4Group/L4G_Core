-- The Big Bad Wolf - Der große böse Wolf
UPDATE `creature_template` SET `mindmg`='7312',`maxdmg`='8685',`baseattacktime`='1500',`speed`='1.20',`flags_extra`='65537' WHERE `entry` IN ('17521'); -- ba 1449 
-- missing banker and smith and commercial blizzard npcs
DELETE FROM `creature` WHERE `guid` IN ('75955','75960','75962','75973');
INSERT INTO `creature` VALUES
(75955,28343,530,1,0,0,2959.0070,3679.3813,144.1191,1.4519,25,0,0,0,0,0,0),
(75960,28344,530,1,0,0,3063.1926,3677.0954,142.6685,4.0290,25,0,0,0,0,0,0),
(75962,29093,0,1,0,0,-8807.0009,638.9830,94.2290,3.7030,25,0,0,0,0,0,0),
(75973,29095,0,1,0,0,1584.4161,201.3631,-43.1023,1.9019,25,0,0,0,0,0,0);
--
-- Ian Drake 29093
UPDATE `creature_template` SET `minlevel`='35',`maxlevel`='35',`minhealth`='1337',`maxhealth`='1337',`faction_A`='12',`faction_H`='12',`flags_extra`='2',`npcflag`='3' WHERE `entry` IN ('29093');
-- Edward Cairn 29095
UPDATE `creature_template` SET `minlevel`='35',`maxlevel`='35',`minhealth`='1337',`maxhealth`='1337',`faction_A`='68',`faction_H`='68',`flags_extra`='2',`npcflag`='3' WHERE `entry` IN ('29095');
-- Blazzle 28344
UPDATE `creature_template` SET `minlevel`='65',`maxlevel`='67',`minhealth`='4747',`maxhealth`='4747',`faction_A`='35',`faction_H`='35',`flags_extra`='2',`npcflag`='4225',`equipment_id`='8027' WHERE `entry` IN ('28344');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8027');
INSERT INTO `creature_equip_template` VALUES
(8027,8576,0,0,218235906,0,0,3,0,0);
INSERT IGNORE INTO `npc_vendor` VALUES
(28344,18567,0,0,0),
(28344,3857,0,0,0),
(28344,3466,0,0,0),
(28344,2880,0,0,0),
(28344,2901,0,0,0),
(28344,5956,0,0,0);
-- Meeda 28343
UPDATE `creature_template` SET `minlevel`='65',`maxlevel`='67',`minhealth`='3820',`maxhealth`='3820',`minmana`='2790',`maxmana`='2933',`faction_A`='35',`faction_H`='35',`flags_extra`='2',`npcflag`='131073' WHERE `entry` IN ('28343');
-- Harvest Golem 36
-- http://wow.gamepedia.com/index.php?title=Harvest_Golem&oldid=1481283
UPDATE `creature_template` SET `AIName`='EventAI',`mechanic_immune_mask`='8415256' WHERE `entry` IN (36);
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN (36);
INSERT INTO `creature_ai_scripts` VALUES
('3601','36','0','0','100','1','14100','36600','22200','34500','11','8014','1','32','0','0','0','0','0','0','0','0','Harvest Golem - Cast Tetanus');
--
-- Naga Distiller 17954,20631
UPDATE `creature_template` SET `armor`='6310',`mindmg`='0',`maxdmg`='0',`attackpower`='0',`baseattacktime`='0',`unit_flags`='33947654',`mechanic_immune_mask`='1073741823' WHERE `entry` IN ('17954');
UPDATE `creature_template` SET `armor`='6800',`unit_flags`='33947654',`mechanic_immune_mask`='1073741823',`flags_extra`='2' WHERE `entry` IN ('20631');
-- Fel Crystal 24722,25552
UPDATE `creature_template` SET `unit_flags`='33816576',`armor`='6310',`mechanic_immune_mask`='1073741823' WHERE `entry` IN ('24722');
UPDATE `creature_template` SET `unit_flags`='33816576',`armor`='6800',`mechanic_immune_mask`='1073741823' WHERE `entry` IN ('25552');
--
DELETE FROM `creature` WHERE `guid` BETWEEN '100000' AND '100006';
INSERT INTO `creature` VALUES
-- (GUID,ENTRY,1,1,0,0,XXX,YYY,ZZZ,OOO,300,0,0,0,0,0,0);
-- Brewfest
(100000,27818,1,1,0,0,1619.7659,-4442.7426,11.0100,2.0577,300,0,0,0,0,0,0),
(100001,27489,1,1,0,0,1616.6805,-4443.3652,10.2710,1.7474,300,0,0,0,0,0,0),
(100002,27817,0,1,0,0,-4845.8271,-862.0108,501.9142,4.8323,300,0,0,0,0,0,0),
(100003,27478,0,1,0,0,-4849.3466,-862.5279,501.9144,4.9109,300,0,0,0,0,0,0),
(100004,27215,0,1,0,0,-5197.2548,-549.1323,397.1746,0.8172,300,0,0,0,0,0,0),
-- Shattrath
(100005,27711,530,1,0,0,-1888.4288,5770.3222,129.5580,6.0776,300,0,0,0,0,0,0),
-- Theramore
(100006,27704,1,1,0,0,-3763.5007,-4432.4941,56.2551,2.209,300,0,0,0,0,0,0);
--
DELETE FROM `game_event_creature` WHERE `guid` IN ('16800562');
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN '100000' AND '100004';
INSERT INTO `game_event_creature` VALUES
-- 26 Brewfest
(16800562,26),
(100000,26),
(100001,26),
(100002,26),
(100003,26),
(100004,26);


-- Ray'ma <Brew of the Month Club> 27489
UPDATE `creature_template` SET `minhealth`='2070',`maxhealth`='2070',`minlevel`='50',`maxlevel`='50',`faction_A`='35',`faction_H`='16',`flags_extra`='2' WHERE `entry` IN ('27489');
--
-- Larkin Thunderbrew <Brew of the Month Club> 27478
UPDATE `creature_template` SET `minhealth`='2070',`maxhealth`='2070',`minlevel`='50',`maxlevel`='50',`faction_A`='16',`faction_H`='35',`flags_extra`='2' WHERE `entry` IN ('27478');
--
-- Brew Vendor <Brew of the Month Club> 27817
UPDATE `creature_template` SET `minhealth`='1000',`maxhealth`='1000',`minlevel`='50',`maxlevel`='50',`flags_extra`='2' WHERE `entry` IN ('27817');
--
-- Brew Vendor <Brew of the Month Club> 27818
UPDATE `creature_template` SET `minhealth`='1000',`maxhealth`='1000',`minlevel`='50',`maxlevel`='50',`flags_extra`='2' WHERE `entry` IN ('27818');
--
-- Boxey Boltspinner 27215
UPDATE `creature_template` SET `minhealth`='1000',`maxhealth`='1000' WHERE `entry` IN ('27215');
--
-- Technician Halmaha 27711
UPDATE `creature_template` SET `minhealth`='3516',`maxhealth`='3516',`flags_extra`='66' WHERE `entry` IN ('27711');
INSERT IGNORE INTO `npc_vendor` VALUES
(27711,10647,0,0,0),
(27711,4389,1,1800,0),
(27711,4382,1,1800,0),
(27711,3466,0,0,0),
(27711,4400,0,0,0),
(27711,4371,2,1800,0),
(27711,4404,3,1800,0),
(27711,4364,4,1800,0),
(27711,4361,2,1800,0),
(27711,4399,0,0,0),
(27711,2880,0,0,0),
(27711,4357,4,1800,0),
(27711,2901,0,0,0),
(27711,5956,0,0,0);
-- Horace Alder
UPDATE `creature_template` SET `minmana`='4393',`maxmana`='4393',`minhealth`='2070',`maxhealth`='2070',`npcflag`='49',`class`='8' WHERE `entry` IN ('27704');
INSERT IGNORE INTO `npc_trainer` VALUES
(27704,	10,	0,	0,	0,	20),
(27704,	66	,0,0,0,	68),
(27704,	116	,0,0,0,	4),
(27704,	118	,0,0,0,	8),
(27704,	120	,0,0,0,	26),
(27704,	122	,0,0,0,	10),
(27704,	130	,0,0,0,	12),
(27704,	143	,0,0,0,	6),
(27704,	145	,0,0,0,	12),
(27704,	205	,0,0,0,	8),
(27704,	475	,0,0,0,	18),
(27704,	543	,0,0,0,	20),
(27704,	587	,0,0,0,	6),
(27704,	597	,0,0,0,	12),
(27704,	604	,0,0,0,	12),
(27704,	759	,0,0,0,	28),
(27704,	837	,0,0,0,	14),
(27704,	865	,0,0,0,	26),
(27704,	990	,0,0,0,	22),
(27704,	1008,0,0,0,	18),
(27704,	1449,0,0,0,	14),
(27704,	1459,0,0,0,	1),
(27704,	1460,0,0,0,	14),
(27704,	1461,0,0,0,	28),
(27704,	1463,0,0,0,	20),
(27704,	1953,0,0,0,	20),
(27704,	2120,0,0,0,	16),
(27704,	2121,0,0,0,	24),
(27704,	2136,0,0,0,	6),
(27704,	2137,0,0,0,	14),
(27704,	2138,0,0,0,	22),
(27704,	2139,0,0,0,	24),
(27704,	2948,0,0,0,	22),
(27704,	3140,0,0,0,	18),
(27704,	3552,0,0,0,	38),
(27704,	3561,0,0,0,	20),
(27704,	3562,0,0,0,	20),
(27704,	3565,0,0,0,	30),
(27704,	5143,0,0,0,	8),
(27704,	5144,0,0,0,	16),
(27704,	5145,0,0,0,	24),
(27704,	5504,0,0,0,	4),
(27704,	5505,0,0,0,	10),
(27704,	5506,0,0,0,	20),
(27704,	6117,0,0,0,	34),
(27704,	6127,0,0,0,	30),
(27704,	6129,0,0,0,	32),
(27704,	6131,0,0,0,	40),
(27704,	6141,0,0,0,	28),
(27704,	6143,0,0,0,	22),
(27704,	7300,0,0,0,	10),
(27704,	7301,0,0,0,	20),
(27704,	7302,0,0,0,	30),
(27704,	7320,0,0,0,	40),
(27704,	7322,0,0,0,	20),
(27704,	8400,0,0,0,	24),
(27704,	8401,0,0,0,	30),
(27704,	8402,0,0,0,	36),
(27704,	8406,0,0,0,	26),
(27704,	8407,0,0,0,	32),
(27704,	8408,0,0,0,	38),
(27704,	8412,0,0,0,	30),
(27704,	8413,0,0,0,	38),
(27704,	8416,0,0,0,	32),
(27704,	8417,0,0,0,	40),
(27704,	8422,0,0,0,	32),
(27704,	8423,0,0,0,	40),
(27704,	8427,0,0,0,	36),
(27704,	8437,0,0,0,	22),
(27704,	8438,0,0,0,	30),
(27704,	8439,0,0,0,	38),
(27704,	8444,0,0,0,	28),
(27704,	8445,0,0,0,	34),
(27704,	8446,0,0,0,	40),
(27704,	8450,0,0,0,	24),
(27704,	8451,0,0,0,	36),
(27704,	8455,0,0,0,	30),
(27704,	8457,0,0,0,	30),
(27704,	8458,0,0,0,	40),
(27704,	8461,0,0,0,	32),
(27704,	8462,0,0,0,	42),
(27704,	8492,0,0,0,	34),
(27704,	8494,0,0,0,	28),
(27704,	8495,0,0,0,	36),
(27704,	10053,0,0,0,	48),
(27704,	10054,0,0,0,	58),
(27704,	10059,0,0,0,	40),
(27704,	10138,0,0,0,	40),
(27704,	10139,0,0,0,	50),
(27704,	10140,0,0,0,	60),
(27704,	10144,0,0,0,	42),
(27704,	10145,0,0,0,	52),
(27704,	10148,0,0,0,	42),
(27704,	10149,0,0,0,	48),
(27704,	10150,0,0,0,	54),
(27704,	10151,0,0,0,	60),
(27704,	10156,0,0,0,	42),
(27704,	10157,0,0,0,	56),
(27704,	10159,0,0,0,	42),
(27704,	10160,0,0,0,	50),
(27704,	10161,0,0,0,	58),
(27704,	10169,0,0,0,	42),
(27704,	10170,0,0,0,	54),
(27704,	10173,0,0,0,	48),
(27704,	10174,0,0,0,	60),
(27704,	10177,0,0,0,	52),
(27704,	10179,0,0,0,	44),
(27704,	10180	,0,0,0,	50),
(27704,	10181	,0,0,0,	56),
(27704,	10185	,0,0,0,	44),
(27704,	10186	,0,0,0,	52),
(27704,	10187	,0,0,0,	60),
(27704,	10191	,0,0,0,	44),
(27704,	10192	,0,0,0,	52),
(27704,	10193	,0,0,0,	60),
(27704,	10197	,0,0,0,	46),
(27704,	10199	,0,0,0,	54),
(27704,	10201	,0,0,0,	46),
(27704,	10202	,0,0,0,	54),
(27704,	10205	,0,0,0,	46),
(27704,	10206	,0,0,0,	52),
(27704,	10207	,0,0,0,	58),
(27704,	10211	,0,0,0,	48),
(27704,	10212	,0,0,0,	56),
(27704,	10215	,0,0,0,	48),
(27704,	10216	,0,0,0,	56),
(27704,	10219	,0,0,0,	50),
(27704,	10220	,0,0,0,	60),
(27704,	10223	,0,0,0,	50),
(27704,	10225	,0,0,0,	60),
(27704,	10230	,0,0,0,	54),
(27704,	11416	,0,0,0,	40),
(27704,	12051	,0,0,0,	20),
(27704,	12505	,0,0,0,	24),
(27704,	12522	,0,0,0,	30),
(27704,	12523	,0,0,0,	36),
(27704,	12524	,0,0,0,	42),
(27704,	12525	,0,0,0,	48),
(27704,	12526	,0,0,0,	54),
(27704,	12824	,0,0,0,	20),
(27704,	12825	,0,0,0,	40),
(27704,	12826	,0,0,0,	60),
(27704,	13018	,0,0,0,	36),
(27704,	13019	,0,0,0,	44),
(27704,	13020	,0,0,0,	52),
(27704,	13021	,0,0,0,	60),
(27704,	13031	,0,0,0,	46),
(27704,	13032	,0,0,0,	52),
(27704,	13033	,0,0,0,	58),
(27704,	18809	,0,0,0,	60),
(27704,	22782	,0,0,0,	46),
(27704,	22783	,0,0,0,	58),
(27704,	23028	,0,0,0,	56),
(27704,	25304	,0,0,0,	60),
(27704,	25306	,0,0,0,	62),
(27704,	25345	,0,0,0,	60),
(27704,	27070	,0,0,0,	66),
(27704,	27071	,0,0,0,	63),
(27704,	27072	,0,0,0,	69),
(27704,	27073	,0,0,0,	65),
(27704,	27074	,0,0,0,	70),
(27704,	27075	,0,0,0,	63),
(27704,	27078	,0,0,0,	61),
(27704,	27079	,0,0,0,	70),
(27704,	27080	,0,0,0,	62),
(27704,	27082	,0,0,0,	70),
(27704,	27085	,0,0,0,	68),
(27704,	27086	,0,0,0,	64),
(27704,	27087	,0,0,0,	65),
(27704,	27088	,0,0,0,	67),
(27704,	27101	,0,0,0,	68),
(27704,	27124	,0,0,0,	69),
(27704,	27125	,0,0,0,	69),
(27704,	27126	,0,0,0,	70),
(27704,	27128	,0,0,0,	69),
(27704,	27130	,0,0,0,	63),
(27704,	27131	,0,0,0,	68),
(27704,	27132	,0,0,0,	66),
(27704,	27133	,0,0,0,	65),
(27704,	27134	,0,0,0,	64),
(27704,	28609	,0,0,0,	60),
(27704,	28612	,0,0,0,	60),
(27704,	30449	,0,0,0,	70),
(27704,	30451	,0,0,0,	64),
(27704,	30455	,0,0,0,	66),
(27704,	30482	,0,0,0,	62),
(27704,	32796	,0,0,0,	70),
(27704,	33041	,0,0,0,	56),
(27704,	33042	,0,0,0,	64),
(27704,	33043	,0,0,0,	70),
(27704,	33405	,0,0,0,	70),
(27704,	33933	,0,0,0,	70),
(27704,	33938	,0,0,0,	70),
(27704,	33944	,0,0,0,	67),
(27704,	33946	,0,0,0,	69),
(27704,	37420	,0,0,0,	65),
(27704,	38699	,0,0,0,	69),
(27704,	43987	,0,0,0,	70),
(27704,	45438	,0,0,0,	30);
--
-- More S4 Arena Vendors 27722 27721 27668
-- maybe import item 43516
--
-- Ancient Lichen 181278
UPDATE `gameobject` SET `spawntimesecs`='86400',`spawnmask`='3' WHERE `id` IN ('181278');
-- loottable summoned voidwalkers no loot no gold nothing just pain
UPDATE `creature_template` SET `lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('8996'); -- 8996
--
DELETE FROM `spell_proc_event` WHERE `entry` IN (16166,16246);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
--
-- Shaman
--
(16166,0x00,11,0x00000000,0x00010000,0x0000000,0,0,0), -- Shaman Elemental Mastery
-- (16246,0x00,11,0x00000000,0x00010000,0x0000000,0,0,0); -- Shaman Clearcasting V1 
(16246, 0x00, 11, 0x90100003, 0x00, 0x0, 0, 0, 0); -- Shaman Clearcasting V2 PTBC SpellFamilyMask 0x90100003 -> spells that can procc it?
--
DELETE FROM `spell_proc_event` WHERE `entry` IN (11213,12574,12575,12576,12577,12536,12043,29976); 
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
--
-- Mage
--
(11213,0x00,3,0x00000000,0x00050000,0x0000000,0,0,0), -- Arcane Concentration (Rank 1) -- 0x00051000 mit aoes
(12574,0x00,3,0x00000000,0x00050000,0x0000000,0,0,0), -- Arcane Concentration (Rank 2)
(12575,0x00,3,0x00000000,0x00050000,0x0000000,0,0,0), -- Arcane Concentration (Rank 3)
(12576,0x00,3,0x00000000,0x00050000,0x0000000,0,0,0), -- Arcane Concentration (Rank 4)
(12577,0x00,3,0x00000000,0x00050000,0x0000000,0,0,0), -- Arcane Concentration (Rank 5)
-- (12536,0x00,3,0x00000000,0x00010000,0x0040000,0,0,0), -- Mage Clearcasting V1
(12536,0x00,3,549591799,0,0,0,0,0), -- Mage Clearcasting V2 PTBC
(12043,0x00,3,0x00000000,0x00010000,0x0040000,0,0,0), -- Presence of Mind
(29976,0x00,3,0x00000000,0x00010000,0x0040000,0,0,0); -- Presence of Mind Part2?
--
-- Ursula Direbrew <Dark Iron Brewmaiden> 26822
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`mindmg`='200',`maxdmg`='400',`baseattacktime`='1400',`minrangedmg`='200',`maxrangedmg`='400',`rangeattacktime`='1400',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304' WHERE `entry` IN ('26822'); -- 0 50 300 2000 50 300 2000 0 0
--
-- Ilsa Direbrew <Dark Iron Brewmaiden> 26764
UPDATE `creature_template` SET `armor`='6800',`speed`='1.48',`mindmg`='200',`maxdmg`='400',`baseattacktime`='1400',`minrangedmg`='200',`maxrangedmg`='400',`rangeattacktime`='1400',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304' WHERE `entry` IN ('26764'); -- 0 50 300 2000 50 300 2000 0 0
--
-- Direbrew Minion 26776
UPDATE `creature_template` SET `armor`='5800',`mindmg`='200',`maxdmg`='400',`baseattacktime`='1400',`equipment_id`='8027' WHERE `entry` IN ('26776');
DELETE FROM `creature_equip_template` WHERE `entry` IN ('8027');
INSERT INTO `creature_equip_template` VALUES
(8027,5009,0,0,218235906,0,0,3,0,0);
--
UPDATE `creature` SET `position_x`='9826.3457', `position_y`='-7395.9433', `position_z`='13.6080', `orientation`='3.6202',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('54713');
UPDATE `creature` SET `position_x`='9835.0341', `position_y`='-7405.4370', `position_z`='13.6192', `orientation`='1.1501',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('64951');

-- Silvermoon Ranger 18147
-- 16897,16898,16899
UPDATE `creature_template` SET `modelid_A`='17539',`modelid_A2`='17541',`modelid_H`='17539',`modelid_H2`='17541',`AIName`='EventAI' WHERE `entry` IN ('18147');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18147');
INSERT INTO `creature_ai_scripts` VALUES
('1814701','18147','1','0','100','1','1000','3000','7000','21000','11','29120','0','0','24','0','0','0','40','2','0','0','Silvermoon Ranger - Shoot on Dummy and Set Range Weapon Model and Reset OOC');
INSERT IGNORE INTO `spell_script_target` VALUES
(29120,1,16897),
(29120,1,16898),
(29120,1,16899);

-- Silvermoon Farstrider 18507
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` IN ('18507');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('18507');
INSERT INTO `creature_ai_scripts` VALUES
(1850701,18507,10,0,100,0,0,15,0,0,12,16222,1,600000,0,0,0,0,0,0,0,0,'Silvermoon Farstrider - Summon Silvermoon City Guardian on Hostile LOS'),
(1850702,18507,1,0,100,1,0,2000,2000,2000,10,36,36,54,0,0,0,0,0,0,0,0,"Silvermoon Farstrider - Out of Combat - Emote ONESHOT_ATTACK1H or ONESHOT_SPECIALATTACK1H");

INSERT IGNORE INTO `game_event_creature` VALUES
(54712,19),
(54713,19);
--
UPDATE `creature` SET `position_x`='-734.3161', `position_y`='6414.8891', `position_z`='171.5525', `orientation`='2.4091' WHERE `guid` IN ('78459');
UPDATE `creature` SET `position_x`='-769.2809', `position_y`='6468.4375', `position_z`='184.9504', `orientation`='4.8125' WHERE `guid` IN ('78457');
--
-- Shattrath City Peacekeeper 19687
UPDATE `creature_template` SET `armor`='6800',`speed`='1.71',`mindmg`='1600',`maxdmg`='3200',`baseattacktime`='1400',`mechanic_immune_mask`='1072644095',`flags_extra`='64' WHERE `entry` IN ('19687');
--
UPDATE `item_template` SET `buyprice`='50000' WHERE `entry` IN ('30719'); -- 0
UPDATE `creature_template` SET `npcflag`=`npcflag`|'128' WHERE `entry` IN ('21774','21772');
INSERT IGNORE INTO `npc_vendor` VALUES
(21772,30719,0,0,0),
(21774,30719,0,0,0);
--
UPDATE `creature` SET `position_x`='147.3844', `position_y`='2362.6159', `position_z`='54.6601', `orientation`='2.1028',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('68413');
UPDATE `creature` SET `spawndist`='5',`movementtype`='1' WHERE `guid` IN ('68217','68218');
UPDATE `creature` SET `id`='19136',`position_x`='206.8875', `position_y`='2373.2124', `position_z`='53.1630', `orientation`='1',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('68212');

-- Flamewaker Imp Grps
DELETE FROM `creature_formations` WHERE `creature_formations`.`leaderGUID` = 68212;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(68212, 68212, 0, 0, 2),
(68212, 68213, 3, 360, 2),
(68212, 68214, 3, 360, 2);
DELETE FROM `creature_formations` WHERE `creature_formations`.`leaderGUID` = 68413;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(68413, 68413, 0, 0, 2),
(68413, 68217, 3, 360, 2),
(68413, 68218, 3, 360, 2);
DELETE FROM `creature_formations` WHERE `creature_formations`.`leaderGUID` = 68414;
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(68414, 68414, 0, 0, 2),
(68414, 68203, 3, 360, 2),
(68414, 68206, 3, 360, 2);
INSERT IGNORE INTO `creature` VALUES
(68414,19136,530,1,0,0,175.634323,2221.234619,47.981358,1.6354,300,5,0,0,0,0,1);
UPDATE `creature` SET `position_x`='-1930.9318', `position_y`='5234.0239', `position_z`='-41.8173', `orientation`='1.2333',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('68397');
-- Interrogator Khan Hollogram 19152
UPDATE `creature_template` SET `Inhabittype`='7' WHERE `entry` IN ('19152');
--
-- portal spawn
INSERT IGNORE INTO `creature` VALUES
(68394,26255,530,1,0,0,-337.1957,961.6685,54.2979,1.5884,30,0,0,0,0,0,0),
(68395,26251,530,1,0,0,-337.1957,961.6685,54.2979,1.5884,30,0,0,0,0,0,0),
(68398,26255,530,1,0,0,-161.6300,964.4809,54.2989,1.6004,30,0,0,0,0,0,0),
(68399,26251,530,1,0,0,-161.6300,964.4809,54.2989,1.6004,30,0,0,0,0,0,0);

-- Triggers and Portal
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'33554432' WHERE `entry` IN ('26251','26255');
UPDATE `creature_template` SET `flags_extra`=`flags_extra`|'128' WHERE `entry` IN ('26251','19871');

UPDATE `creature` SET `orientation`='0.8168',`spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69643');
UPDATE `creature` SET `spawndist`='0',`movementtype`='0' WHERE `guid` IN ('69505');
-- Dun Baldar North Marshal 14762
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14762');
--
-- Dun Baldar South Marshal 14763
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14763');
--
-- Icewing Marshal 14764
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14763');
--
-- Stonehearth Marshal 14765
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14763');
--
-- East Frostwolf Warmaster 14772
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14763');
--
-- Iceblood Warmaster 14773
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14763');
--
-- Tower Point Warmaster 14776
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14763');
--
-- West Frostwolf Warmaster 14777
UPDATE `creature_template` SET `minhealth`='140000',`maxhealth`='140000',`armor`='6800',`speed`='2',`mindmg`='3450',`maxdmg`='6900',`unit_flags`='36928',`lootid`='0',`mingold`='0',`maxgold`='0' WHERE `entry` IN ('14763');
