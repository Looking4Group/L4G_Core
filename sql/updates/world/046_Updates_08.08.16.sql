-- Crystalline Key 30442
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`=-100 WHERE `entry` = 21309 AND `item` = 30442; -- -87

-- Coilfang Fathom-Witch Mind Control
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21299');
INSERT INTO `creature_ai_scripts` VALUES
('2129901','21299','1','0','100','2','0','0','0','0','21','1','0','0','22','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Combat Movement and Set Phase to 0 on Spawn'),
('2129902','21299','4','0','100','2','0','0','0','0','11','38628','1','0','23','1','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Bolt and Set Phase 1 on Aggro'),
('2129903','21299','9','5','100','3','0','45','5200','9200','11','38628','1','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Bolt (Phase 1)'),
('2129904','21299','3','5','100','2','7','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2129905','21299','9','5','100','2','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement at 35 Yards (Phase 1)'),
('2129906','21299','9','5','100','2','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Prevent Combat Movement at 15 Yards (Phase 1)'),
('2129907','21299','9','5','100','2','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Start Combat Movement Below 5 Yards (Phase 1)'),
('2129908','21299','3','3','100','3','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2129909','21299','0','0','100','3','8200','12200','36300','49300','11','38627','0','1','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Shadow Nova'),
('2129910','21299','9','0','100','3','0','10','11900','16100','11','38626','5','1','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Cast Domination on TARGET_T_HOSTILE_WPET_RANDOM_NOT_TOP'),
('2129911','21299','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Coilfang Fathom-Witch - Set Phase to 0 on Evade');

-- increased speed
-- Ember of Al'ar 19551
-- http://www.wowhead.com/npc=19551/ember-of-alar#abilities http://wowwiki.wikia.com/wiki/Ember_of_Al'ar
-- Hit for ~1500 damage.  mob_ember_of_alar
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`minhealth`=140000,`maxhealth`=140000,`speed`=2,`mindmg`=4196,`maxdmg`=4292,`baseattacktime`=1400,`resistance2`=-1,`mechanic_immune_mask`=75644246,`flags_extra`=4194304 WHERE `entry` = 19551; -- 140000 1520 1664 2000 -- 6,294 - 6,438


-- Crystalcore Sentinel 20041 added Trample Spell (nonmeleedmgrelated spell)
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20041');
INSERT INTO `creature_ai_scripts` VALUES
('2004101','20041','0','0','100','3','9000','14000','25000','35000','11','37104','1','0','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Overcharge'), -- 4
('2004102','20041','0','0','100','3','21000','25000','25000','30000','11','37106','0','0','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Charged Arcane Explosion'),
('2004103','20041','2','0','100','2','15','0','0','0','11','34937','0','1','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Power Down at 15% HP'),
('2004104','20041','0','0','100','3','4000','8000','8000','16000','11','40492','0','0','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Trample');

-- Added Blast Wave 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20033');
INSERT INTO `creature_ai_scripts` VALUES
('2003301','20033','1','0','100','2','1000','1000','600000','600000','11','35915','0','1','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor OOC'),
('2003302','20033','4','0','100','2','0','0','0','0','11','35915','0','32','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor on Aggro'),
('2003303','20033','9','0','100','3','0','40','5000','7000','11','37109','4','0','0','0','0','0','0','0','0','0','Astromancer - Cast Fireball Volley'),
('2003304','20033','9','0','100','3','0','20','6000','18000','11','37110','1','0','0','0','0','0','0','0','0','0','Astromancer - Cast Fire Blast'),
('2003305','20033','27','0','100','3','35915','1','8000','24000','11','33482','0','32','0','0','0','0','0','0','0','0','Astromancer - Cast Molten Armor on Missing Buff'),
('2003306','20033','0','0','100','3','8000','16000','16000','32000','11','36278','0','1','0','0','0','0','0','0','0','0','Astromancer - Cast Blast Wave');

-- Added Blast Wave 
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20046');
INSERT INTO `creature_ai_scripts` VALUES
('2004601','20046','1','0','100','3','1000','1000','600000','600000','11','38732','0','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Shield on Spawn'),
('2004602','20046','9','0','100','3','0','40','3400','4800','11','37109','4','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fireball Volley'),
('2004603','20046','9','0','100','3','0','20','12000','16000','11','37110','4','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Blast'),
('2004604','20046','9','0','100','3','0','5','15000','20000','11','37289','0','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Dragon\'s Breath'),
('2004605','20046','27','0','100','3','38732','1','2000','4000','11','38732','0','32','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Fire Shield on Missing Buff'),
('2004606','20046','0','0','100','3','8000','12000','20000','30000','11','37122','5','0','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Domination'),
('2004607','20046','0','0','100','3','8000','16000','16000','32000','11','36278','0','1','0','0','0','0','0','0','0','0','Astromancer Lord - Cast Blast Wave');

-- Thaurissan Agent 7038
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('7038');
INSERT INTO `creature_ai_scripts` VALUES
('703800','7038','0','0','100','7','1000','1000','2000','2000','21','1','0','0','40','1','0','0','0','0','0','0','Thaurissan Agent - Start Movement and Set Melee Weapon Model'),
('703801','7038','4','0','100','0','0','0','0','0','22','1','0','0','0','0','0','0','0','0','0','0','Thaurissan Agent - Set Phase 1 and Start Movement OOC'),
('703802','7038','9','1','100','1','5','30','2200','3000','11','6660','1','0','40','2','0','0','21','0','0','0','Thaurissan Agent - Cast Shoot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('703803','7038','9','1','100','1','5','30','36300','50000','11','6685','1','0','40','2','0','0','21','0','0','0','Thaurissan Agent - Cast Piercing Shot and Set Ranged Weapon Model and Stop Movement (Phase 1)'),
('703804','7038','9','0','100','1','0','5','13300','24100','11','12540','4','0','0','0','0','0','0','0','0','0','Thaurissan Agent - Cast Gouge'),
('703805','7038','9','1','100','3','0','5','0','0','21','1','0','0','40','1','0','0','22','0','0','0','Thaurissan Agent - Start Movement and Set Melee Weapon Model and Set Phase 0 Below 6 Yards (Phase 1)'),
('703806','7038','7','0','100','0','0','0','0','0','22','0','0','0','40','1','0','0','21','1','0','0','Thaurissan Agent - Set Phase 0 and Set Melee Weapon Model and Start Movement on Evade'),
('703807','7038','9','0','100','7','6','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Thaurissan Agent - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20034');
INSERT INTO `creature_ai_scripts` VALUES
('2003401','20034','9','0','100','3','0','5','5000','15000','11','37126','1','0','0','0','0','0','0','0','0','0','Star Scryer - Cast Arcane Blast'),
('2003402','20034','0','0','100','3','4000','8000','7000','15000','11','37124','4','32','0','0','0','0','0','0','0','0','Star Scryer - Cast Starfall'),
('2003403','20034','0','0','100','3','7000','15000','17000','22000','11','37122','5','1','0','0','0','0','0','0','0','0','Star Scryer - Cast Domination');

-- 7899,7901,7902
UPDATE `creature_loot_template` SET `ChanceOrQuestChance`= -10 WHERE `item` = 9275; -- -100
UPDATE `creature_loot_template` SET `maxcount` = 4 WHERE `item` = 4306 AND `entry` IN (7899,7901,7902); -- 2

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20045');
INSERT INTO `creature_ai_scripts` VALUES
('2004501','20045','9','0','100','3','0','5','12000','16000','11','37126','4','0','0','0','0','0','0','0','0','0','Nether Scryer - Cast Arcane Blast'),
('2004502','20045','2','0','100','2','99','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004503','20045','2','0','100','2','98','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004504','20045','2','0','100','2','97','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004505','20045','2','0','100','2','96','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination'),
('2004506','20045','2','0','100','2','95','0','30000','30000','11','36797','5','39','0','0','0','0','0','0','0','0','Nether Scryer - Cast Domination');

-- Coilfang Priestess 21220
UPDATE `creature_template` SET `minhealth`='180000',`maxhealth`='180000',`armor`='5950',`speed`='1.71',`mindmg`='5607',`maxdmg`='6657',`baseattacktime`='1400',`mechanic_immune_mask`='69649',`flags_extra`='0' WHERE `entry` IN ('21220'); -- 1513 3087 -- 8,411 - 9,985
-- `mechanic_immune_mask`='0' after patch 2.1
-- 180000 hp 150000 * 1.2
-- Smite Holy Nova Shadow Word: Pain and Sprit of Redemption 15 seconds after death. 
-- http://wowwiki.wikia.com/wiki/Coilfang_Priestess?oldid=770831 , http://de.wowhead.com/npc=21220/priesterin-des-echsenkessels#english-comments
-- Prenerf Spirit of Redemption on Death, unkillable and 15sec kill self -> morph to 12904
-- Holy Nova on Death
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21220');
INSERT INTO `creature_ai_scripts` VALUES
('2122001','21220','1','0','100','2','0','0','0','0','21','1','0','0','22','0','0','0','19','6','0','0','Coilfang Priestess - Start Movement and Set Phase to 0 OOC'),
('2122002','21220','4','0','100','2','0','0','0','0','22','1','0','0','42','1','0','0','39','50','0','0','Coilfang Priestess - Set Phase 1 and Set Minhealth to 1 and Call for Help on Aggro'),
('2122003','21220','9','6 ','100','3','0','50','5000','7000','11','38582','1','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Smite (Phase 1)'),
('2122004','21220','9','6 ','100','3','0','8','5000','10000','11','38589','0','7','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Nova (Phase 1)'),
('2122005','21220','3','6 ','100','2','7','0','0','0','21','1','0','0','22','2','0','0','0','0','0','0','Coilfang Priestess - Start Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2122006','21220','9','6 ','100','2','45','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Start Movement at 45 Yards (Phase 1)'),
('2122007','21220','9','6 ','100','2','5','40','0','0','21','0','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Prevent Movement at 30 Yards (Phase 1)'),
('2122008','21220','9','6 ','100','2','0','5','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Start Movement Below 5 Yards (Phase 1)'),
('2122009','21220','3','5','100','3','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2122010','21220','9','4','100','3','0','45','10400','14200','11','38585','4','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Holy Fire'),
('2122011','21220','14','4','100','3','40000','40','5000','10000','11','38580','6','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal on Friendlies'),
('2122012','21220','2','4','100','2','80','0','15000','20000','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 80% HP'),
('2122013','21220','2','4','100','2','50','0','0','0','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 50% HP'),
('2122014','21220','2','4','100','2','20','0','0','0','11','38580','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal at 20% HP'),
('2122015','21220','9','4','100','3','0','30','5400','7200','11','37275','4','32','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Shadow Word: Pain'),
('2122016','21220','2','0','100','2','1','0','0','0','11','38589','0','7','3','0','16031','0','22','3','0','0','Coilfang Priestess - Cast Holy Nova and Morph and Set Phase 3 at 1% HP'),
('2122017','21220','2','0','100','2','1','0','0','0','21','0','0','0','20','0','0','0','18','6','0','0','Coilfang Priestess - Stop Movement and Stop Melee and Set Unattackable at 1% HP'),
('2122018','21220','14','3','100','3','1000','40','2000','2000','11','38580','6','1','0','0','0','0','0','0','0','0','Coilfang Priestess - Cast Greater Heal on Friendlies (Phase 3)'),
('2122019','21220','7','0','100','2','0','0','0','0','22','0','0','0','3','0','0','0','19','6','0','0','Coilfang Priestess - Set Phase 0 and Demorph and Set Attackable on Evade'),
('2122020','21220','7','0','100','2','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Coilfang Priestess - Start Movement on Evade'),
('2122021','21220','0','3','100','2','14750','14750','0','0','34','24','1','0','3','0','0','0','0','0','0','0','Coilfang Priestess - Set Instance Data 1 and Demorph to 0 (Phase 3)'),
('2122022','21220','0','3','100','2','15000','15000','0','0','42','0','0','0','37','0','0','0','0','0','0','0','Coilfang Priestess - Set Minhealth to 0 and Die after 15sec (Phase 3)');

-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `minhealth`='120000',`maxhealth`='120000',`speed`='1.48',`mindmg`='8358',`maxdmg`='9926',`baseattacktime`='1400',`resistance3`= -1,`mechanic_immune_mask`='1073692671' WHERE `entry` IN ('21863'); -- 104790 3003 6139 2000 1 -- 16,716 - 19,852

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21863');
INSERT INTO `creature_ai_scripts` VALUES
('2186301','21863','4','0','100','2','0','0','0','0','23','1','0','0','11','38655','1','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 and Cast Poison Bolt Volley on Aggro'),
('2186302','21863','9','5','100','3','3000','6000','4000','8000','11','38655','1','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Poison Bolt Volley (Phase 1)'),
('2186303','21863','24','5','100','3','38655','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 2 on Target Max Poison Bolt Volley Aura Stack (Phase 1)'),
('2186304','21863','28','3','100','3','38655','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 on Target Missing Poison Bolt Volley Aura Stack (Phase 2)'),
-- ('2186305','21863','9','0','100','3','0','5','18900','18900','11','38650','0','1','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'),
('2186306','21863','9','0','100','3','0','5','5000','10000','12','17990','1','20000','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Spawn Underbog Mushroom'),
('2186307','21863','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase to 0 on Evade');

DELETE FROM `creature_equip_template` WHERE `entry` IN ('5609');
INSERT INTO `creature_equip_template` VALUES
('5609', '22081', '0', '20650','33490690','0','50266626','781','0','15');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17427');
INSERT INTO `creature_ai_scripts` VALUES
('1742701','17427','0','0','100','7','1000','1000','3000','3000','21','1','0','0','40','1','0','0','0','0','0','0','Shattered Hand Archer - Start Movement and Set Melee Weapon Model'),
('1742702','17427','4','0','100','6','0','0','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Shattered Hand Archer - Start Movement on Aggro'),
('1742703','17427','9','0','100','3','5','30','2300','5000','11','16100','4','0','40','2','0','0','21','0','0','0','Shattered Hand Archer (Normal) - Cast Shoot and Set Ranged Weapon Model and Stop Movement'),
('1742704','17427','9','0','100','5','5','30','2300','5000','11','22907','4','0','40','2','0','0','21','0','0','0','Shattered Hand Archer (Heroic) - Cast Shoot and Set Ranged Weapon Model and Stop Movement'),
('1742705','17427','9','0','100','7','5','30','6000','9000','11','30990','4','0','40','2','0','0','21','0','0','0','Shattered Hand Archer - Cast Multi-Shot and Set Ranged Weapon Model and Stop Movement'),
('1742706','17427','9','0','100','3','0','4','0','0','21','1','0','0','40','1','0','0','0','0','0','0','Shattered Hand Archer - Start Movement and Set Melee Weapon Model Below 5 Yards'),
('1742707','17427','9','0','100','6','5','30','0','0','21','0','0','0','40','2','0','0','22','1','0','0','Shattered Hand Archer - Stop Movement and Set Ranged Weapon Model and Set Phase 1 Above 5 Yards (Phase 0)'),
('1742708','17427','7','0','100','6','0','0','0','0','40','1','0','0','21','1','0','0','0','0','0','0','Shattered Hand Archer - Set Melee Weapon Model and Start Movement on Evade');

-- Wanton Hostess
UPDATE `creature_template` SET `modelid_A`='16543',`modelid_A2`='16545',`modelid_H`='16543',`modelid_H2`='16545',`mindmg`='3400',`maxdmg`='4038',`baseattacktime`='1400' WHERE `entry` IN ('16459'); -- 1222 2498
UPDATE `creature_onkill_reputation` SET `MaxStanding1`='7',`RewOnKillRepValue1`='15' WHERE `creature_id` IN ('16459');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16459');
INSERT INTO `creature_ai_scripts` VALUES
('1645901','16459','4','0','100','2','0','0','0','0','11','29485','0','39','0','0','0','0','0','0','0','0','Wanton Hostess - Cast Alluring Aura on Aggro'),
('1645902','16459','1','0','5','1','90000','210000','240000','360000','1','-56','-57','-58','1','-60','0','0','0','0','0','0','Wanton Hostess - Random Say OOC'),
('1645903','16459','1','0','1','1','120000','180000','240000','360000','1','-60','0','0','0','0','0','0','0','0','0','0','Wanton Hostess - Random Say OOC'),
('1645904','16459','2','0','100','2','50','0','0','0','28','0','29485','0','11','29472','0','39','11','29486','0','39','Wanton Hostess - Remove Alluring Aura and Cast Wanton Hostess Transform and Cast Bewitching Aura at 50% HP'),
('1645905','16459','2','0','100','2','50','0','0','0','23','1','0','0','1','-9822','0','0','0','0','0','0','Wanton Hostess - Set Phase 1 and Say at 50% HP'),
('1645906','16459','0','1','100','3','5000','8000','7000','10000','11','29477','4','0','0','0','0','0','0','0','0','0','Wanton Hostess - Cast Banshee Wail (Phase 1)'),
('1645907','16459','9','1','100','3','0','5','80000','12000','11','29505','0','1','0','0','0','0','0','0','0','0','Wanton Hostess - Cast Banshee Shriek (Phase 1)'),
('1645908','16459','7','0','100','2','0','0','0','0','28','0','29472','0','28','0','29486','0','28','0','29485','0','Wanton Hostess - Remove Wanton Hostess Transform and Bewitching Aura and Alluring Aura on Evade'),
('1645909','16459','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Wanton Hostess - Set Phase 0 on Evade'),
('1645910','16459','6','0','50','1','0','0','0','0','1','-59','0','0','0','0','0','0','0','0','0','0','Wanton Hostess - Say on Death');
--
-- Concubine 16461
UPDATE `creature_template` SET `modelid_A`='16551',`modelid_A2`='16553',`modelid_H`='16551',`modelid_H2`='16553',`mindmg`='3400',`maxdmg`='4038',`baseattacktime`='1400' WHERE `entry` IN ('16461'); -- 1222 2498
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16461');
INSERT INTO `creature_ai_scripts` VALUES
('1646101','16461','1','0','5','1','90000','210000','240000','360000','1','-56','-57','-58','1','-60','0','0','0','0','0','0','Concubine - Random Say OOC'),
('1646102','16461','1','0','1','1','120000','180000','240000','360000','1','-60','0','0','0','0','0','0','0','0','0','0','Concubine - Random Say OOC'),
('1646103','16461','2','0','100','2','50','0','0','0','11','29489','0','39','11','29490','0','39','23','1','0','0','Concubine - Cast Concubine Transform and Cast Seduction and Set Phase 1 at 50% HP'),
('1646104','16461','9','1','100','3','0','5','6000','9000','11','15969','4','0','0','0','0','0','0','0','0','0','Concubine - Cast Tormenting Lash'),
('1646105','16461','6','0','20','2','0','0','0','0','1','-59','0','0','22','0','0','0','0','0','0','0','Concubine - Say and Set Phase 0 on Death'),
('1646106','16461','7','0','100','2','0','0','0','0','28','0','29489','0','28','0','29490','0','22','0','0','0','Concubine - Remove Concubine Transform and Seduction and Set Phase 0 on Evade');
--
-- Night Mistress 16460
UPDATE `creature_template` SET `modelid_A`='16547',`modelid_A2`='16549',`modelid_H`='16547',`modelid_H2`='16549',`mindmg`='3154',`maxdmg`='3744',`baseattacktime`='1400',`flags_extra`='4194304' WHERE `entry` IN ('16460'); -- 1135 2315
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('16460');
INSERT INTO `creature_ai_scripts` VALUES
('1646001','16460','1','0','5','1','90000','210000','240000','360000','1','-56','-57','-58','1','-60','0','0','0','0','0','0','Night Mistress - Random Say OOC'),
('1646002','16460','1','0','1','1','120000','180000','240000','360000','1','-60','0','0','0','0','0','0','0','0','0','0','Night Mistress - Random Say OOC'),
('1646003','16460','2','0','100','2','50','0','0','0','11','29488','0','39','11','29491','0','39','0','0','0','0','Night Mistress - Cast Night Mistress Transform and Cast Impending Betrayal and at 50% HP'),
('1646004','16460','2','0','100','2','50','0','0','0','21','1','0','0','23','1','0','0','1','-9818','0','0','Night Mistress - Prevent Combat Movement and Set Phase 1 and Say at 50% HP'),
('1646005','16460','9','5','100','3','0','40','3000','4000','11','29487','4','0','0','0','0','0','0','0','0','0','Night Mistress - Cast Shadow Bolt (Phase 1)'),
('1646006','16460','3','5','100','2','7','0','0','0','21','1','0','0','23','1','0','0','0','0','0','0','Night Mistress - Start Combat Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('1646007','16460','9','5','100','2','35','80','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Night Mistress - Start Combat Movement at 35 Yards (Phase 1)'),
('1646008','16460','9','5','100','2','5','15','0','0','21','1','0','0','0','0','0','0','0','0','0','0','Night Mistress - Prevent Combat Movement at 15 Yards (Phase 1)'),
('1646009','16460','0','5','100','3','20000','20000','20000','20000','11','29491','0','1','0','0','0','0','0','0','0','0','Night Mistress - Cast Impending Betrayal (Phase 1)'),
('1646010','16460','0','5','100','3','8000','10000','9000','12000','11','30358','5','0','0','0','0','0','0','0','0','0','Night Mistress - Cast Searing Pain'),
('1646011','16460','3','3','100','3','100','15','1000','1000','23','-1','0','0','0','0','0','0','0','0','0','0','Night Mistress - Set Phase 1 when Mana is above 15% (Phase 2)'),
('1646012','16460','7','0','100','2','0','0','0','0','28','0','29488','0','21','1','0','0','22','0','0','0','Night Mistress - Remove Night Mistress Transform and Set Phase 0 on Evade');

-- Shattered Hand Reaver 20590
UPDATE `creature_template` SET `mechanic_immune_mask`=1089 WHERE `entry` = 20590;
-- Shattered Hand Zealot 20595
UPDATE `creature_template` SET `equipment_id`=990,`mindmg`=1600,`maxdmg`=2400 WHERE `entry` = 20595;

-- Warbringer O'mrogg 16809,20596
UPDATE `creature_template` SET `mindmg`='1677',`maxdmg`='2210',`speed`='1.20' WHERE `entry` IN ('16809'); -- 638 1305 s1 2h hammer -- 638 1305 -- 2,096 - 2,763
UPDATE `creature_template` SET `mindmg`='5623',`maxdmg`='5936',`pickpocketloot`='16809',`speed`='1.20' WHERE `entry` IN (20596); -- 2255 2802 -- 9,841 - 10,388

-- Call for Help on Aggro Prenerf
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21920');
INSERT INTO `creature_ai_scripts` VALUES
('2192001','21920','9','0','100','3','0','5','5900','7100','11','41932','1','0','0','0','0','0','0','0','0','0','Tidewalker Lurker - Cast Carnivorous Bite'),
('2192002','21920','4','0','100','2','0','0','0','0','39','15','0','0','0','0','0','0','0','0','0','0','Tidewalker Lurker - Call for Help on Aggro');

-- 20041 Emote on 37106 Spellcast
-- -9711 - -9720
DELETE FROM `creature_ai_texts` WHERE `entry` IN(-9711,-9712,-9713,-9714,-9715,-9716,-9717,-9718,-9719,-9720);
INSERT INTO `creature_ai_texts` VALUES
(-9711,'\'s hand begins to glow with Arcane energy.',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,2,0,0,'20041 on Overcharged Arcane Explosion Spellcast'),
(-9712,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9713,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9714,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9715,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9716,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9717,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9718,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9719,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder'),
(-9720,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,0,'TKPlaceholder');

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('20041');
INSERT INTO `creature_ai_scripts` VALUES
('2004101','20041','0','0','100','3','9000','14000','25000','35000','11','37104','1','0','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Overcharge'), -- 4
('2004102','20041','0','0','100','3','21000','25000','25000','30000','11','37106','0','0','1','-9711','0','0','0','0','0','0','Crystalcore Sentinel - Cast Charged Arcane Explosion and Emote'),
('2004103','20041','2','0','100','2','15','0','0','0','11','34937','0','1','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Power Down at 15% HP'),
('2004104','20041','0','0','100','3','4000','8000','8000','16000','11','40492','0','0','0','0','0','0','0','0','0','0','Crystalcore Sentinel - Cast Trample');

-- Thaladred the Darkener <Advisor to Kael'thas> 20064
-- 378000 -> 491400
-- http://wowwiki.wikia.com/wiki/Thaladred_the_Darkener
UPDATE `creature_template` SET `minhealth`='756000',`maxhealth`='756000',`rank`= 3, `speed`='0.8',`mindmg`='10548',`maxdmg`='12527',`mechanic_immune_mask`='653213695' WHERE `entry` IN ('20064'); -- 756000 1 XXX 3790 7747 -- 21,096 - 25,053
--
-- Lord Sanguinar <The Blood Hammer> 20060
-- 376000 -> 488800
-- http://wowwiki.wikia.com/wiki/Lord_Sanguinar
UPDATE `creature_template` SET `minhealth`='752000',`maxhealth`='752000',`rank`='3',`speed`='1.48',`mindmg`='7501',`maxdmg`='8908',`mechanic_immune_mask`='653213695' WHERE `entry` IN ('20060'); -- 552000 1 3369 6886 -- 18,752 - 22,269
--
-- Grand Astromancer Capernian <Advisor to Kael'thas> 20062
-- 281000 -> 365300
-- http://wowwiki.wikia.com/wiki/Grand_Astromancer_Capernian
UPDATE `creature_template` SET `minhealth`='562000',`maxhealth`='562000',`rank`='3',`armor`='6700',`speed`='2',`mindmg`='2754',`maxdmg`='3312',`baseattacktime`='2000' WHERE `entry` IN ('20062'); -- 562000 1 959 2074 -- 5,508 - 6,623
--
-- Master Engineer Telonicus <Advisor to Kael'thas> 20063
-- 377000 -> 490100
-- http://wowwiki.wikia.com/wiki/Master_Engineer_Telonicus
UPDATE `creature_template` SET `minhealth`='754000',`maxhealth`='754000',`rank`='3',`mindmg`='6692',`maxdmg`='7192' WHERE `entry` IN ('20063'); -- 754000 1 2754 3312 -- 13,383 - 14,383

-- weapon wowhead nerf * 1.57533987 +10% (documented nerf) +30% buff (talents / knowledge)
-- Netherstrand Longbow 21268
-- weapon_advisor
-- ~210,000 HP (208000) + 10% nerf for advisor+weapon 231000 -> 300300
UPDATE `creature_template` SET `minhealth`='231000',`maxhealth`='231000',`speed`='1.48',`mindmg`='4179',`maxdmg`='4963',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` IN ('21268'); -- 216000 1502 3070 -- 8,358 - 9,926
--
-- Devastation 21269
-- ~230,000 HP + 10% 253000 -> 328900
-- http://wowwiki.wikia.com/wiki/Kael%27thas_Sunstrider_(tactics)?oldid=1139113
-- Also has much higher HP than the other weapons. 
UPDATE `creature_template` SET `minhealth`='253000',`maxhealth`='253000',`speed`='1.48',`mindmg`='8358',`maxdmg`='9926',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` IN ('21269'); -- 220059 3003 6139 --  16,716 - 19,852
--
-- Cosmic Infuser 21270
-- ~280,000 HP  + 10% nerf for advisor+weapon 308000 -> 400400 
UPDATE `creature_template` SET `minhealth`='308000',`maxhealth`='308000',`speed`='1.48',`mindmg`='4179',`maxdmg`='4963',`baseattacktime`='1400',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` IN ('21270'); -- 251496 1502 3070 2000 -- 8,358 - 9,926
--
-- Infinity Blades 21271
-- ~210,000 HP + 10% 231000 -> 300300
UPDATE `creature_template` SET `minhealth`='231000',`maxhealth`='231000',`speed`='1.48',`mindmg`='5000',`maxdmg`='6111',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` IN ('21271'); -- 210000 1667 3889 -- 9,999 - 12,221
--
-- Warp Slicer 21272
-- ~290,000 HP + 10% 319000 -> 414700
UPDATE `creature_template` SET `minhealth`='319000',`maxhealth`='319000',`speed`='1.48',`mindmg`='6686',`maxdmg`='7941',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` IN ('21272'); -- 251496 1502 3070 -- 8,358 - 9,926
--
-- Phaseshift Bulwark 21273
-- ~290,000 HP + 10% 319000 -> 414700
UPDATE `creature_template` SET `minhealth`='319000',`maxhealth`='319000',`speed`='1.48',`mindmg`='3999',`maxdmg`='4444',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` IN ('21273'); -- 340000 1666 2555 -- 7,998 - 8,887
--
-- Staff of Disintegration 21274
-- ~170,000 HP + 10% 187000 -> 243100
UPDATE `creature_template` SET `minhealth`='187000',`maxhealth`='187000',`speed`='1.48',`mindmg`='4179',`maxdmg`='4963',`mechanic_immune_mask`='1040135103',`flags_extra`='4194304'  WHERE `entry` IN ('21274'); -- 160496 1502 3070 -- 8,358 - 9,926

-- Phoenix Egg 21364
-- mob_phoenix_egg_tk
-- 70k HP + 10% 77 -> 100100
UPDATE `creature_template` SET `minhealth`='77000',`maxhealth`='77000',`armor`='5800',`mindmg`='0',`maxdmg`='0',`baseattacktime`='0',`unit_flags`=`unit_flags`|'262144',`dynamicflags`='8',`flags_extra`='4194304' WHERE `entry` IN ('21364'); -- 69000
--
-- Phoenix 21362
-- http://www.wowhead.com/npc=21362/phoenix#abilities 
-- ~ 177458 + 10% 195204 -> 253765
-- added stun immunity
UPDATE `creature_template` SET `minhealth`='195204',`maxhealth`='195204',`speed`='1.20',`mindmg`='2278',`maxdmg`='3309',`mechanic_immune_mask`='1073561599',`flags_extra`='4194304' WHERE `entry` IN ('21362'); -- 174650 1001 2046 -- 5,572 - 6,617 

UPDATE `autobroadcast` SET `text`='T5 PTR Testphase: SSC closed and TK closing on 21.08.16. T5 Release Trailer in development.' WHERE `id` = 5;

DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1831105','1831106');
INSERT INTO `creature_ai_scripts` VALUES 
('1831105','18311','4','0','15','7','0','0','0','0','1','-1237','-1238','-1239','0','0','0','0','0','0','0','0','Ethereal Crypt Raider - Random Say on Aggro'),
('1831106','18311','4','0','100','6','0','0','0','0','39','8','0','0','0','0','0','0','0','0','0','0','Ethereal Crypt Raider - Call for Help on Aggro');
DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1830904','1830905');
INSERT INTO `creature_ai_scripts` VALUES 
('1830904','18309','4','0','15','7','0','0','0','0','1','-1236','-1237','-1239','0','0','0','0','0','0','0','0','Ethereal Scavenger - Random Say on Aggro'),
('1830905','18309','4','0','100','6','0','0','0','0','39','8','0','0','0','0','0','0','0','0','0','0','Ethereal Scavenger - Call for Help on Aggro');

DELETE FROM `creature_ai_scripts` WHERE `id` IN ('1831405');
INSERT INTO `creature_ai_scripts` VALUES 
(1831405,18314,4,0,100,7,0,0,0,0,11,29651,0,7,0,0,0,0,0,0,0,0,'Nexus Stalker - Casts Dual Wield on Aggro');

-- Ember of Al'ar 19551
-- http://www.wowhead.com/npc=19551/ember-of-alar#abilities http://wowwiki.wikia.com/wiki/Ember_of_Al'ar
-- Hit for ~1500 damage.  mob_ember_of_alar
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`minhealth`=140000,`maxhealth`=140000,`speed`=2,`mindmg`=4196,`maxdmg`=4292, `dmgschool` = 2, `baseattacktime`=1400,`resistance2`=-1,`mechanic_immune_mask`=75644246,`flags_extra`=4194304 WHERE `entry` = 19551; -- 140000 1520 1664 0 2000 -- 6,294 - 6,438

UPDATE `creature` SET `position_x`='-28.4099', `position_y`='-86.7979', `position_z`='-0.1248', `orientation`='2.5604' WHERE `guid` IN ('83319');
UPDATE `creature` SET `position_x`='-99.9899', `position_y`='-102.1105', `position_z`='-0.8251', `orientation`='0.9817' WHERE `guid` IN ('83310');
UPDATE `creature` SET `position_x`='-106.1641', `position_y`='-96.3666', `position_z`='-0.6624', `orientation`='0.9267' WHERE `guid` IN ('83309');

INSERT INTO `creature` (`guid`, `id`, `map`, `spawnMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `DeathState`, `MovementType`) VALUES (88813, 15990, 533, 1, 0, 0, 3746.41, -5113.35, 142.031, 2.93162, 28800, 0, 0, 3198000, 1572000, 0, 0);
INSERT INTO `creature_linked_respawn` VALUES (88813,88813);
