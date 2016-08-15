-- respawntimer up to 5min for gauntlet to have more time to clear it

-- ======================================================
-- Spawns
-- ======================================================
--
-- added npcs
DELETE FROM `creature` WHERE `guid` IN (3666851,99996,99997,99998,99979,99965,99964,99963,99962,99961,99960,99959,99958,99957,99956,99955,99954,99953,99951,99950,99949,99948,99947,99946,99945,99944,99943,99942,99941,99940,99939);
DELETE FROM `creature` WHERE `guid` IN (99945,99947,99948,99949);
INSERT INTO `creature` (`guid`,`id`, `map`, `spawnMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `MovementType`) VALUES
(99996,17462,540,3,77.3463,264.6607,-13.2028,4.0404,7200,0,0),
(99997,17462,540,3,68.6459,271.7706,-13.2043,4.0404,7200,0,0),
(99998,17420,540,3,43.2567,254.2895,-10.9824,1.6006,7200,0,0),
(99979,17462,540,3,379.6138,310.3692,1.9438,3.1254,300,0,0),
(99965,17462,540,3,379.8101,322.5056,1.9440,3.1254,300,0,0),
(99964,17462,540,3,401.9723,323.2708,1.9082,3.1254,300,0,0),
(99963,17462,540,3,402.7467,310.5365,1.9020,3.1254,300,0,0),
(99962,17462,540,3,427.0512,308.9408,1.9322,3.1254,300,0,0),
(99961,17462,540,3,427.2383,320.5103,1.9322,3.1254,300,0,0),
(99960,17462,540,3,458.3092,322.9482,1.9467,3.1254,300,0,0),
(99959,17462,540,3,458.0854,309.1110,1.9467,3.1254,300,0,0),
(99958,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99957,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99956,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99955,17462,540,3,93.1910,246.8917,-13.2047,2.9958,7200,0,0),
(99954,17695,540,3,315.9148,58.2639,1.0244,6.2479,7200,5,1),
(99953,17695,540,3,138.6280,-84.2911,1.9078,6.2700,7200,5,1),
-- 99952 maggi
(99951,17695,540,3,522.0420,103.0975,1.9230,6.2700,7200,5,1),
(99950,17695,540,3,513.5316,101.9586,1.9230,6.2700,7200,5,1),
(99949,17695,540,3,274.4971,317.3325,-0.3597,6.2700,7200,5,1),
(99948,17695,540,3,535.7389,294.3880,1.9401,6.2700,7200,5,1),
(99947,17695,540,3,467.4152,57.9210,1.9360,0.0064,7200,5,1),
(99946,17695,540,3,531.5406,333.6080,2.1095,3.9334,7200,5,1),
(99945,17695,540,3,427.2488,57.6792,2.0958,0.0103,7200,5,1),
(99944,17695,540,3,330.8828,296.9179,1.9263,1.4672,7200,5,1),
(99943,17695,540,3,320.0052,328.7619,1.9297,4.4950,7200,5,1),
(99942,17695,540,3,297.2097,316.2634,1.9170,3.1127,7200,5,1),
(99941,17695,540,3,257.4549,307.2904,-5.4710,4.4046,7200,5,1),
(99940,17695,540,3,517.8952,202.3979,1.9305,1.5851,7200,5,1),
(99939,17695,540,3,518.4773,173.6161,1.9417,1.6165,7200,5,1);

-- dmg nerf nonheroic

-- Shattered Hand Champion 17671 20584
UPDATE `creature_template` SET `equipment_id`=8019,`mechanic_immune_mask`=346100947,`mindmg`=1337,`maxdmg`=1762 WHERE `entry` = 17671; -- Schwert und Schild orange 509 1040 -- 1,671 - 2,202
UPDATE `creature_template` SET `equipment_id`=8019,`mechanic_immune_mask`=346100947,`mindmg`=3738,`maxdmg`=3978 WHERE `entry` = 20584; -- Schwert und Schild orange 2112 2712 -- 4673 4973 -- 9,346 - 9,946

-- Shattered Hand Sharpshooter 16704 20594
UPDATE `creature_template` SET `equipment_id`=5603,`armor`=6800,`mindmg`=1181,`maxdmg`=1610 WHERE `entry` = 16704; -- Tryout Hordegewehr + ? 429 966 -- 1,476 - 2,013

-- Shattered Hand Houndmaster 17670 20588 
-- equipmodel 3 39059
UPDATE `creature_template` SET `equipment_id`=5605,`mindmg`=1226,`maxdmg`=1615 WHERE `entry` = 17670; -- Tryout Rote Armbrust + großer Säbel 1800 -- 467 954 -- 1,532 - 2,019
UPDATE `creature_template` SET `equipment_id`=5605,`mindmg`=3230,`maxdmg`=3383 WHERE `entry` = 20588; -- Tryout Rote Armbrust + großer Säbel 1800 -- 1875 2259 -- 8,074 - 8,458

-- Shattered Hand Archer 17427 20579
-- equipslot 3 20650
UPDATE `creature_template` SET `mindmg`=1007,`maxdmg`=1326,`equipment_id`=5609,`mechanic_immune_mask`=614535379 WHERE `entry` = 17427; -- Schwarzer Bogen + großer Säbel 384 782 -- 1,259 - 1,657
UPDATE `creature_template` SET `armor`=6800,`mindmg`=2324,`maxdmg`=2510,`equipment_id`=5609,`mechanic_immune_mask`=614535379,`minrangedmg`=1500,`maxrangedmg`=2500 WHERE `entry` = 20579; -- Schwarzer Bogen + großer Säbel 1279 1743 -- 1257 1809 -- 5,810 - 6,274

-- Shattered Hand Assassin 17695 20580
UPDATE `creature_template` SET `equipment_id`=518,`armor`=7100,`mindmg`=1054,`maxdmg`=1408 WHERE `entry` = 17695; -- 2 geschwungene dolche 395 837 -- 1,318 - 1,760
UPDATE `creature_template` SET `equipment_id`=518,`armor`=7100,`mindmg`=2897,`maxdmg`=3153,`lootid`=17695 WHERE `entry` = 20580; -- 2 geschwungene dolche 1571 2210 -- 7,243 - 7,882

-- Shattered Hand Centurion 17465 20583
UPDATE `creature_template` SET `equipment_id`=1481,`mechanic_immune_mask`=614546655,`mindmg`=1337,`maxdmg`=1762,`baseattacktime`=1800 WHERE `entry` = 17465; -- totenschädelaxt 509 1040 -- 1,671 - 2,202
UPDATE `creature_template` SET `equipment_id`=1481,`mechanic_immune_mask`=614546655,`mindmg`=3454,`maxdmg`=3734,`baseattacktime`=0 WHERE `entry` = 20583; -- totenschädelaxt 1897 2597 -- 8,636 - 9,336

-- Shattered Hand Gladiator 17464 20586
UPDATE `creature_template` SET `equipment_id`=1375,`mechanic_immune_mask`=0,`mindmg`=1226,`maxdmg`=1615 WHERE `entry` = 17464; -- hordeaxt 467 954 -- 1,532 - 2,019
UPDATE `creature_template` SET `equipment_id`=1375,`mechanic_immune_mask`=0,`mindmg`=3484,`maxdmg`=3705 WHERE `entry` = 20586; -- hordeaxt 1970 2523 -- 8,709 - 9,262

-- Shattered Hand Reaver 16699,20590
UPDATE `creature_template` SET `equipment_id`=1429,`armor`=6800,`mindmg`=1181,`maxdmg`=1610,`baseattacktime`=1600,`mechanic_immune_mask`=1 WHERE `entry` = 16699; -- rote wirbelaxt 429 966 1420 -- 1,476 - 2,013
UPDATE `creature_template` SET `equipment_id`=1429,`armor`=6800,`mindmg`=3470,`maxdmg`=3728 WHERE `entry` = 20590; -- rote wirbelaxt 1927 2573 -- 8,675 - 9,321

-- Shattered Hand Heathen 17420,20587
-- dualwield 3.0
UPDATE `creature_template` SET `equipment_id`=1290,`mindmg`=1056,`maxdmg`=1390 WHERE `entry` = 17420; -- 2 rote 1h schwerter 403 820 -- 1,320 - 1,737
UPDATE `creature_template` SET `equipment_id`=1290,`armor`=6800,`mindmg`=2718,`maxdmg`=2828,`baseattacktime`=0 WHERE `entry` = 20587; -- 2 rote 1h schwerter 1915 2244 4077 4242 -- 8,154 - 8,483

-- Shattered Hand Sentry 16507 20593
UPDATE `creature_template` SET `equipment_id`=5601,`mindmg`=1174,`maxdmg`=1545 WHERE `entry` = 16507; -- nicht ganz 448 912 -- 1,467 - 1,931
UPDATE `creature_template` SET `equipment_id`=5601,`armor`=6800,`mindmg`=3448,`maxdmg`=3669 WHERE `entry` = 20593; -- nicht ganz 1948 2500 -- 8,620 - 9,172

-- Shattered Hand Savage 16523 20591
-- dualwield 3.0
UPDATE `creature_template` SET `equipment_id`=926,`mindmg`=1174,`maxdmg`=1545 WHERE `entry` = 16523; -- 2 äxte 448 912  -- 1,467 - 1,931
UPDATE `creature_template` SET `equipment_id`=926,`armor`=6800,`mindmg`=2749,`maxdmg`=2928 WHERE `entry` = 20591; -- 2 äxte 1860 2397 4123 4392 -- 8,246 - 8,783

-- Shattered Hand Legionnaire 16700 20589
UPDATE `creature_template` SET `equipment_id`=52,`mindmg`=1314,`maxdmg`=1733,`mechanic_immune_mask`=614544851 WHERE `entry` = 16700; -- Fakel 500 1023 -- 1,643 - 2,166
UPDATE `creature_template` SET `equipment_id`=52,`mindmg`=3951,`maxdmg`=4185,`mechanic_immune_mask`=614544851 WHERE `entry` = 20589; -- Fakel 2250 2835 -- 9,877 - 10,462

-- Shattered Hand Blood Guard / Blood Guard Porung 17461,20992 
UPDATE `creature_template` SET `mindmg`=1337,`maxdmg`=1762,`equipment_id`=5607 WHERE `entry` = 17461; -- 509 1040 -- 1,671 - 2,202
UPDATE `creature_template` SET `ScriptName`='boss_blood_guard_porung',`mechanic_immune_mask`=1073725439,`mindmg`=4734,`maxdmg`=4933,`equipment_id`=5607 WHERE `entry` = 20992; -- nicht exakt aber passend rotes 2h schwert -- 6311 6577 -- 9,467 - 9,865

-- Grand Warlock Nethekurse 16807,20568
-- Sollte ein anderes kleineres Schwert tragen
UPDATE `creature` SET `position_x`=178.8155, `position_y`=287.1836, `position_z`=-8.1846, `orientation`=4.6464,`spawndist`=0,`movementtype`=0 WHERE `guid` = 13681415;
UPDATE `creature_template` SET `equipment_id`=1187,`mindmg`=1464,`maxdmg`=1928 WHERE `entry` = 16807; -- 558 1138 rotes 2h schwert -- 1,830 - 2,410
UPDATE `creature_template` SET `equipment_id`=1187,`mindmg`=4117,`maxdmg`=4522,`pickpocketloot`=16807,`baseattacktime`=0 WHERE `entry` = 20568; -- 8,233 - 9,043

-- Fel Orc Convert 17083,20567
UPDATE `creature_template` SET `minlevel`=68,`maxlevel`=69,`minhealth`=9803,`maxhealth`=10000,`mindmg`=566,`maxdmg`=745,`baseattacktime`=1400,`mechanic_immune_mask`=1 WHERE `entry` = 17083; -- 173 352 -- 566 - 745
UPDATE `creature_template` SET `minhealth`=13972,`maxhealth`=14000,`mindmg`=1114,`maxdmg`=1324,`baseattacktime`=0,`lootid`=17083,`pickpocketloot`=17083,`mechanic_immune_mask`=1 WHERE `entry` = 20567; -- 400 819 -- 2,228 - 2,647

-- Warbringer Omrogg 16809,20596
UPDATE `creature_template` SET `mindmg`=1677,`maxdmg`=2210 WHERE `entry` = 16809; -- 638 1305 s1 2h hammer -- 638 1305 -- 2,096 - 2,763
UPDATE `creature_template` SET `mindmg`=5623,`maxdmg`=5936,`pickpocketloot`=16809 WHERE `entry` = 20596; -- 2255 2802 -- 9,841 - 10,388

-- Warchief Kargath Bladefist 16808,20597
-- 2 guids 3666851 5274944 npc flag 2 ? y
UPDATE  `creature` SET `spawnmask`=3,`spawntimesecs`=43200 WHERE `guid` = 5274944;
UPDATE `creature_template` SET `mindmg`=1446,`maxdmg`=1906 WHERE `entry` = 16808; -- 550 1125 -- 1,807 - 2,382
UPDATE `creature_template` SET `mindmg`=5356,`maxdmg`=5641,`pickpocketloot`=16808 WHERE `entry` = 20597; -- 7141 7521 -- 6121 6446 -- 10,711 - 11,281

-- Heathen Guard 17621,20569
UPDATE `creature_template` SET `speed`=1.20,`mindmg`=566,`maxdmg`=746,`equipment_id`=1290,`AIName`='EventAI' WHERE `entry` = 17621; -- 216 440 --  708 - 932
UPDATE `creature_template` SET `mindmg`=1000,`maxdmg`=1763,`armor`=6800,`equipment_id`=1290 WHERE `entry` = 20569; -- 557 1077 -- 3,006 - 3,526

-- Sharpshooter Guard 17622,20578
-- equipslot 3 31747 polish 17622 ai
UPDATE `creature_template` SET `speed`=1.20,`mindmg`=566,`maxdmg`=746,`minrangedmg`=500,`maxrangedmg`=1000 WHERE `entry` = 17622; -- 216 440 -- 708 - 932
UPDATE `creature_template` SET `mindmg`=1000,`maxdmg`=1763,`armor`=6800,`minrangedmg`=1000,`maxrangedmg`=2000 WHERE `entry` = 20578; -- 863 1642 -- 4,620 - 5,399

-- Reaver Guard 17623,20575
UPDATE `creature_template` SET `speed`=1.20,`equipment_id`=1429,`mindmg`=708,`maxdmg`=932,`baseattacktime`=2000 WHERE `entry` = 17623; -- 216 440 --  708 - 932
UPDATE `creature_template` SET `armor`=6800,`mindmg`=2095,`maxdmg`=2495,`equipment_id`=1429 WHERE `entry` = 20575; -- 748 1547 -- 4,190 - 4,989

-- Shattered Hand Executioner 17301,20585
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`equipment_id`=1429,`armor`=6800,`mindmg`=1476,`maxdmg`=2013,`baseattacktime`=2000,`mechanic_immune_mask`=1073692671,`speed`=1.48,`flags_extra`=65536 WHERE `entry` = 16699; -- rote wirbelaxt 448 912 1420
UPDATE `creature_template` SET `equipment_id`=1429,`armor`=6800,`mindmg`=4338,`maxdmg`=4661,`faction_A`=1662,`faction_H`=1662,`speed`=1.48,`unit_flags`=1,`baseattacktime`=0,`mechanic_immune_mask`=1073692671,`flags_extra`=65536  WHERE `entry` = 20590; -- rote wirbelaxt 2188 2759 -- 8,675 - 9,321

-- Arca

-- Sentinel Movementspeed + Damage

-- Arcatraz Sentinel 20869,21586
UPDATE `creature_template` SET `minhealth`=46108,`maxhealth`=46108,`dynamicflags`=0,`unit_flags`=536870976,`RegenHealth`=0,`speed`=1.20,`ScriptName`='',`mindmg`=1425,`maxdmg`=1878,`flags_extra`=`flags_extra`=65536,`mechanic_immune_mask`=8388631 WHERE `entry` IN (20869); -- arcatraz_sentinel 651 1331 -- 2,137 - 2,817 -- 46108 (115269)
UPDATE `creature_template` SET `minhealth`=64908,`maxhealth`=64908,`dynamicflags`=0,`unit_flags`=536870976,`RegenHealth`=0,`speed`=1.20,`ScriptName`='',`mindmg`=4012,`maxdmg`=4764,`lootid`=20869,`flags_extra`=65536,`mechanic_immune_mask`=8388631 WHERE `entry` IN (21586); -- arcatraz_sentinel 1802 3684 -- 6686 7941 -- 10,029 - 11,911 -- 64908 (162269)

-- Protean Horror 20865 21607
UPDATE `creature_template` SET `armor`=5500,`speed`=1.48,`mindmg`=500,`maxdmg`=1000,`baseattacktime`=1400 WHERE `entry` = 20865; -- 342 929   718 885
UPDATE `creature_template` SET `armor`=5800,`speed`=1.48,`mindmg`=800,`maxdmg`=1200,`baseattacktime`=0,`unit_flags`=524352 WHERE `entry` = 21607; -- 701 1956 

-- Eredar Soul-Eater 20879 21595
UPDATE `creature_template` SET `equipment_id`=4001,`mindmg`=2287,`maxdmg`=3013,`baseattacktime`=1800 WHERE `entry` = 20879; -- 697 1423
UPDATE `creature_template` SET `equipment_id`=4001,`speed`=1.71,`mindmg`=7681,`maxdmg`=9118,`baseattacktime`=0,`pickpocketloot`=20879 WHERE `entry` = 21595; -- 4200-5800 5974-7091 8961-10637 -- 13,441 - 15,956

-- Eredar Deathbringer 20880 21594
UPDATE `creature_template` SET `equipment_id`=1476,`armor`=6800,`mindmg`=3431,`maxdmg`=4520,`baseattacktime`=2000 WHERE `entry` = 20880; -- 1046 2135
UPDATE `creature_template` SET `equipment_id`=1476,`armor`=6800,`speed`=1.71,`mindmg`=8863,`maxdmg`=10522,`baseattacktime`=0 WHERE `entry` = 21594; -- 2789-5692 5800-7000 6893-8183 -- 10340-12275 15,510 - 18,413

-- Trash Nerf
-- Greater Fleshbeast - mindmg=8861  maxdmg=10000
UPDATE `creature_template` SET `mindmg`=6900,`maxdmg`=8300 WHERE `entry`=16596;
 
-- Phantom Valet - mindmg=8000  maxdmg=9412
UPDATE `creature_template` SET `mindmg`=6400,`maxdmg`=7800 WHERE `entry`=16408;
 
-- Skeletal Usher - mindmg=9415 maxdmg=11178
UPDATE `creature_template` SET `mindmg`=7500,`maxdmg`=8500 WHERE `entry`=16471;
 
-- Ghastly Haunt - mindmg=9231 maxdmg=10963
UPDATE `creature_template` SET `mindmg`=7400,`maxdmg`=8600 WHERE `entry`=16481;
 
-- Trapped Soul - mindmg=8667  maxdmg=10000
UPDATE `creature_template` SET `mindmg`=6700,`maxdmg`=8200 WHERE `entry`=16482;
 
-- Arcane Watchman - mindmg=8461  maxdmg=10049
UPDATE `creature_template` SET `mindmg`=7900,`maxdmg`=8300 WHERE `entry`=16485;
 
-- Arcane Protector - mindmg=8654  maxdmg=10278
UPDATE `creature_template` SET `mindmg`=7800,`maxdmg`=8200 WHERE `entry`=16504;
 
-- Ethereal Thief - mindmg=9231  maxdmg=10963
UPDATE `creature_template` SET `mindmg`=8000,`maxdmg`=9000 WHERE `entry`=16544;
 
-- Ethereal Spellfilcher - mindmg=8561  maxdmg=10162
UPDATE `creature_template` SET `mindmg`=7500,`maxdmg`=8100 WHERE `entry`=16545;

-- Grishna Arakkoa has no EventAI
UPDATE `creature_template` SET `AIName`= 'NULL' WHERE `entry` = 22232; -- EventAI
