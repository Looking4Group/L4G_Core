-- Hellfire Channeler – Dont Set ID
UPDATE `creature_template` SET `flags_extra`='2' WHERE `entry` IN ('17256'); -- befor extra 1

DELETE FROM `creature_onkill_reputation` WHERE `creature_id` IN ('21609');
INSERT INTO `creature_onkill_reputation` VALUES
(21609,935,0,7,0,30,0,0,0,0);

-- Unbound Devastator 20881 21619
UPDATE `creature_template` SET `mindmg`='2466',`maxdmg`='3250' WHERE `entry` IN ('20881'); -- 751 1535
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='8023',`maxdmg`='9529',`unit_flags`='64',`pickpocketloot`='20881' WHERE `entry` IN ('21619'); -- 1802 3684 6686 7941 -- 10,029 - 11,911

-- Spiteful Temptress 20883 21615  
-- taunt immune
UPDATE `creature_template` SET `mindmg`='1628',`maxdmg`='2712',`baseattacktime`='1400',`flags_extra` = flags_extra|'65536' WHERE `entry` IN ('20883'); -- 326 1410
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6521',`maxdmg`='7778',`baseattacktime`='0',`unit_flags`='32832',`pickpocketloot`='20883',`flags_extra` = flags_extra|'65536' WHERE `entry` IN ('21615'); -- 2317 4832 3800 4800 -- 6521 7778 -- 13041 - 15556

-- Skulking Witch 20882 21613
-- repos one stealthy one
UPDATE `creature` SET `position_x`='190.3266', `position_y`='146.8560', `position_z`='22.4398', `orientation`='0.0157',`spawndist`='15',`movementtype`='1' WHERE `guid` IN ('79549');
--
UPDATE `creature_template` SET `AIName`='EventAI',`mindmg`='2466',`maxdmg`='3250',`baseattacktime`='1400' WHERE `entry` = '20882';  -- 751 1535
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6521',`maxdmg`='7778',`baseattacktime`='0',`pickpocketloot`='20882' WHERE `entry` IN ('21613'); -- 2317 4832 4600 5800 -- 6521 7778 -- 13041 - 15556

DELETE FROM `creature_ai_scripts` WHERE `id` IN ('2088510','2088511','2088512','2088513');
INSERT INTO `creature_ai_scripts` VALUES
(2088510,20885,4,0,100,7,0,0,0,0,11,29651,0,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer - Cast Dual Wield on Aggro'),
(2088511,20885,9,0,100,5,7,40,10000,15000,11,39016,4,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer (Heroic) - Cast Shadow Wave'),
(2088512,20885,0,0,100,5,21100,21100,30000,30000,11,39013,0,1,1,-77,-78,0,9,11091,11092,-1,'Dalliah the Doomsayer (Heroic) - Cast Heal'),
(2088513,20885,9,0,100,5,0,10,8500,10000,11,39009,1,0,0,0,0,0,0,0,0,0,'Dalliah the Doomsayer (Heroic) - Cast Gift of the Doomsayer');

UPDATE `creature_ai_scripts` SET `event_param1`='21100',`event_param2`='21100',`action1_param3`='1' WHERE `id` IN ('2088506'); -- the 1 ;)
UPDATE `creature_ai_scripts` SET `event_param1`='15000',`event_param2`='15000' WHERE `id` IN ('2088505'); -- 15000

-- Wrath-Scryer Soccothrates 20886,21624
UPDATE `creature` SET `position_x`='121.9831', `position_y`='191.2938', `position_z`='22.4411', `orientation`='5.2464',`spawndist`='5',`movementtype`='1' WHERE `guid` IN ('79398');
UPDATE `creature_template` SET `mechanic_immune_mask`='787431423',`mindmg`='2722',`maxdmg`='3588' WHERE `entry` IN ('20886'); 
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='8428',`maxdmg`='10376',`unit_flags`='64',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('21624'); -- 5619 6917 -- 6742 8301 -- 8,428 - 10,376

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20900');
INSERT INTO `creature_ai_scripts` VALUES
('2090001','20900','4','0','100','6','0','0','0','0','11','36833','1','1','0','0','0','0','0','0','0','0','Unchained Doombringer - Cast Berserker Charge on Aggro'),
('2090002','20900','9','0','100','7','5','40','15000','18000','11','36833','4','1','0','0','0','0','0','0','0','0','Unchained Doombringer - Cast Berserker Charge'),
('2090003','20900','9','0','100','7','0','5','7000','12000','11','36836','1','1','0','0','0','0','0','0','0','0','Unchained Doombringer - Cast Agonizing Armor'),
('2090004','20900','0','0','100','3','7000','8000','18000','18000','11','36835','0','7','0','0','0','0','0','0','0','0','Unchained Doombringer (Normal) - Cast War Stomp'),
('2090005','20900','0','0','100','5','7000','8000','18000','18000','11','38911','0','7','0','0','0','0','0','0','0','0','Unchained Doombringer (Heroic) - Cast War Stomp');

-- Serpentshrine Sporebat 21246
-- By 1313moridin (1,661 – 13·34) on 2007/04/30 (Patch 2.0.12) they only have alittle over 200k hp
-- Spore Burst Charge 10-15 secs melee for 3000 on cloth. 
-- http://wowwiki.wikia.com/wiki/Serpentshrine_Sporebat?direction=next&oldid=768437 , http://www.wowhead.com/npc=21246/serpentshrine-sporebat#comments
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='3000',`maxdmg`='5000',`baseattacktime`='1000',`mechanic_immune_mask`='75579255' WHERE `entry` IN ('21246'); -- 1874 3809 2000 -- 2500 3500 7,649 - 9,084

-- Underbog Colossus 21251
-- 620000 2-3k on a tank http://wowwiki.wikia.com/wiki/Underbog_Colossus?direction=next&oldid=768654
-- different ai sets he is core scripted atm but poorly
-- set1 39031/enrage 39015/atrophic-blow
-- set2 38971/acid-geyser 39044/serpentshrine-parasite
-- spawns parasites that do lots of damage, but one hit kills them. 4 at a time 
-- Parasite - Does a ?2k dot to target, after dot a small 1hp 'parasite' will leave the infected person and go to a new target. Also spawns parasites if a parasite kills someone. 
-- set3 38976/spore-quake 39032/initial-infection
UPDATE `creature_template` SET `minhealth`='806000',`maxhealth`='806000',`speed`='1.48',`mindmg`='13856',`maxdmg`='16445',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304' WHERE `entry` IN ('21251'); -- 4571 6857 -- 620000 3109 6357 -- 17,308 - 20,556 mob_underbog_colossus

-- Spitfire Totem 22091
UPDATE `creature_template` SET `armor`='6500',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` IN ('22091');
-- Greater Earthbind Totem 22486
UPDATE `creature_template` SET `armor`='6500',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` IN ('22486');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22486');
INSERT INTO `creature_ai_scripts` VALUES
('2248601','22486','0','0','100','3','1000','1000','5000','5000','11','3600','0','0','0','0','0','0','0','0','0','0','Greater Earthbind Totem - Cast Earthbind');
-- Greater Poison Cleansing Totem 22487
UPDATE `creature_template` SET `armor`='6500',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`='393216',`dynamicflags`='8',`mechanic_immune_mask`='1073741823',`flags_extra`='65600' WHERE `entry` IN ('22487');

-- Phoenix-Hawk 20039
-- http://www.wowhead.com/npc=20039 , http://wowwiki.wikia.com/wiki/Phoenix-Hawk?direction=next&oldid=706656
-- mob_phoenix_hawk
UPDATE `creature_template` SET `speed`='1.48',`mindmg`='9753',`maxdmg`='11581',`mechanic_immune_mask`='1073692671',`flags_extra`='4194304'  WHERE `entry` IN ('20039'); -- 1402 2865 -- 7,802 - 9,265 -- 9753 11581

-- repos one stealthy one
UPDATE `creature` SET `position_x`='201.8695', `position_y`='146.8431', `position_z`='22.4157', `orientation`='6.2713',`spawndist`='10',`movementtype`='1' WHERE `guid` IN ('79549');

UPDATE `creature_template` SET `minlevel`='140000',`maxlevel`='140000',`speed`='1.48',`mindmg`='3147',`maxdmg`='3219',`baseattacktime`='1400',`resistance2`='-1',`mechanic_immune_mask`='75644246',`flags_extra`='4194304' WHERE `entry` IN ('19551'); -- 140000 1520 1664 2000 -- 6,294 - 6,438

-- Reverting my Totem Part to see what broke them, Trench or my Update, but from when this first appeared id say its not the sql i did.
UPDATE `creature_template` SET `AIName`='' WHERE `entry` IN ('5913');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('5913');
DELETE FROM `creature_template_addon` WHERE `entry` IN ('5925');

-- Coilfang Ambusher 21865
-- They have nasty burst damage and can Multishot for about 2.5k on leather. mob_coilfang_ambusher
UPDATE `creature_template` SET `minhealth`='37700',`maxhealth`='37700',`mindmg`='3000',`maxdmg`='4000',`baseattacktime`='1400',`minrangedmg`='1000',`maxrangedmg`='2000',`speed`='1.48',`mechanic_immune_mask`='1' WHERE `entry` IN ('21865'); -- 29000 930 1898 2000 0 0 -- 2585 3069

-- Sulfuron Magma-Thrower
UPDATE `creature_template` SET `resistance2`='-1',`mechanic_immune_mask`='753876991',`mindmg`='2209',`maxdmg`='2910' WHERE `entry` IN ('20909'); -- 673 1374
UPDATE `creature_template` SET `maxhealth`='94448',`minmana`='26472 ',`maxmana`='26472 ',`speed`='1.71',`mindmg`='5387',`maxdmg`='5808',`baseattacktime`='0',`resistance2`='-1',`mechanic_immune_mask`='753876991' WHERE `entry` IN ('21616'); -- 1783 2415

-- Blackwing Drakonaar 20911 21588
-- Pathetic, inferior mortals!
-- The dragonflight will... devour you.
UPDATE `creature_template` SET `mindmg`='2722',`maxdmg`='3588',`resistance2`='-1',`mechanic_immune_mask`='787431423' WHERE `entry` IN ('20911'); -- 829 1695     - 3,58
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='6686',`maxdmg`='7941',`baseattacktime`='0',`unit_flags`='64',`resistance2`='-1',`mechanic_immune_mask`='787431423',`lootid`='20911' WHERE `entry` IN ('21588'); -- 1802 3684   

-- Akkiris Lightning-Waker 20908 21617
UPDATE `creature_template` SET `speed`='1.71',`resistance3`='-1',`mechanic_immune_mask`='753876991',`mindmg`='2051',`maxdmg`='2702' WHERE `entry` IN ('20908'); -- 625 1276
UPDATE `creature_template` SET `maxhealth`='94448',`speed`='1.71',`mindmg`='5387',`maxdmg`='5808',`baseattacktime`='0',`resistance3`='-1',`mechanic_immune_mask`='753876991',`unit_flags`='64' WHERE `entry` IN ('21617'); -- 1783 2415

-- Tainted Elemental 22009   
UPDATE `creature_template` SET `minhealth`='12025',`maxhealth`='12025',`armor`='6800',`speed`='1.48',`mindmg`='169',`maxdmg`='299',`mechanic_immune_mask`='109264767' WHERE `entry` IN ('22009'); -- 9250 20 1 1 131
--
-- Enchanted Elemental 21958
-- mob_enchanted_elemental
UPDATE `creature_template` SET `minhealth`='10010',`maxhealth`='10010',`speed`='1.48',`mechanic_immune_mask`='109264767' WHERE `entry` IN ('21958'); -- 6986/7700

-- Coilfang Elite 22055
-- 170000
-- http://www.wowhead.com/npc=22055/coilfang-elite#comments , http://wowwiki.wikia.com/wiki/Coilfang_Elite?direction=next&oldid=784963
UPDATE `creature_template` SET `minhealth`='221000',`maxhealth`='221000',`speed`='1.20',`mindmg`='6400',`maxdmg`='13867',`mechanic_immune_mask`='1073420283' WHERE `entry` IN ('22055'); -- 3129 6395 550183931 -- 8000 9400 8707 10340 -- 17,413 - 20,679 -- 
--
-- Coilfang Strider 22056
-- 170000
--
-- 4500 - 8000 on tanks, one-shots anything else Tauntable 
UPDATE `creature_template` SET `minhealth`='344650',`maxhealth`='344650',`speed`='1.20',`mindmg`='12000',`maxdmg`='14000',`mechanic_immune_mask`='1073427391',`flags_extra`='0' WHERE `entry` IN ('22056'); -- 1 6007 12278 550183931 65536 -- 16717 19853 33,434 - 39,705
-- UPDATE `creature_template` SET `mindmg`='12000',`maxdmg`='15000',`minhealth`='448045',`maxhealth`='448045' WHERE `entry`='22056'; -- 

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21221');
INSERT INTO `creature_ai_scripts` VALUES
('2122101','21221','9','0','100','3','5','35','2000','3000','11','38904','4','0','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Throw'),
('2122102','21221','9','0','100','3','0','5','4900','10900','11','38474','1','0','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Cleave'),
('2122103','21221','0','0','100','3','2000','9000','19300','23400','11','38484','0','1','0','0','0','0','0','0','0','0','Coilfang Beast-Tamer - Cast Bestial Wrath');

-- Fathom-Lord Karathress 21214
-- =================================
--
UPDATE `creature_template` SET `minhealth`='2367300',`maxhealth`='2367300',`speed`='1.71',`mindmg`='11177',`maxdmg`='13266',`mechanic_immune_mask`='1073430527',`flags_extra`=`flags_extra`|'4194304' WHERE `entry` IN ('21214'); -- 1821000 4519 8175 -- 6840 7630 -- 19,560 - 23,216
-- UPDATE `creature_template` SET `mindmg`='6840',`maxdmg`='7630',`minhealth`='2367300',`maxhealth`='2367300' WHERE `entry`='21214';
