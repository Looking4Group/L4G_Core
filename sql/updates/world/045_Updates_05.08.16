-- Gruul
UPDATE `access_requirement` SET `level_min`= '70' WHERE `id` = '48';
-- Auchenai Crypts
UPDATE `access_requirement` SET `level_min`= '61' WHERE `id` = '45';
-- Mana-Tombs
UPDATE `access_requirement` SET `level_min`= '61' WHERE `id` = '44';
-- Sethekk Halls
UPDATE `access_requirement` SET `level_min`= '61' WHERE `id` = '43';
-- The Slave Pens
UPDATE `access_requirement` SET `level_min`= '61' WHERE `id` = '36';
-- The Underbog
UPDATE `access_requirement` SET `level_min`= '61' WHERE `id` = '35';
-- The Steamvault
UPDATE `access_requirement` SET `level_min`= '65' WHERE `id` = '34';
-- Magtheridon's Lair
UPDATE `access_requirement` SET `level_min`= '70' WHERE `id` = '33';
-- The Shattered Halls
UPDATE `access_requirement` SET `level_min`= '65' WHERE `id` = '30';
-- Karazhan
UPDATE `access_requirement` SET `level_min`= '70' WHERE `id` = '27';

-- High Astromancer Solarian 18805
-- www.wowhead.com/npc=18925/high-astromancer-solarian#comments http://wowwiki.wikia.com/wiki/High_Astromancer_Solarian?oldid=829691
-- As a DPS warrior, she can crush me for 8k, and one of our rogues reported 10k. (Arcane Dmg?)
UPDATE `creature_template` SET `speed`='2',`scale`='0.7',`mindmg`='5434',`maxdmg`='6449',`baseattacktime`='1400',`mechanic_immune_mask`='650854399' WHERE `entry` = '18805';

-- Grand Warlock Chamber Door
UPDATE `gameobject` SET `animprogress` = 100 WHERE `guid` = 9042537; -- 0
UPDATE `gameobject_template` SET `flags` = 34 WHERE `entry` = 182539; -- 4

-- Serpentshrine Lurker 21863
UPDATE `creature_template` SET `minhealth`=120000,`maxhealth`=120000,`speed`=1.48,`mindmg`=8358,`maxdmg`=9926,`baseattacktime`=1400,`mechanic_immune_mask`=1073561599 WHERE `entry` =21863; -- 104790 3003 6139 2000 1 -- 16,716 - 19,852
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('21863');
INSERT INTO `creature_ai_scripts` VALUES
('2186301','21863','4','0','100','2','0','0','0','0','23','1','0','0','11','38655','1','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 and Cast Poison Bolt Volley on Aggro'),
('2186302','21863','9','5','100','3','3000','6000','4000','8000','11','38655','1','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Poison Bolt Volley (Phase 1)'),
('2186303','21863','24','5','100','3','38655','3','5000','5000','23','1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 2 on Target Max Poison Bolt Volley Aura Stack (Phase 1)'),
('2186304','21863','28','3','100','3','38655','1','5000','5000','23','-1','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase 1 on Target Missing Poison Bolt Volley Aura Stack (Phase 2)'),
('2186305','21863','9','0','100','3','0','5','18900','18900','11','38650','0','1','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'), --
('2186306','21863','9','0','100','3','0','5','18900','18900','12','17990','1','22000','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Cast Rancid Mushroom Primer'), --
('2186307','21863','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Serpentshrine Lurker - Set Phase to 0 on Evade');
--
-- Rancid Mushroom 22250
UPDATE `creature_template` SET `modelid_A`='11686',`modelid_H`='11686',`faction_A`='14',`faction_H`='14',`armor`='6800',`flags_extra`='0',`unit_flags`=`unit_flags`|'4'|'131072'|'262144'|'33554432',`speed`='0.0001',`mindmg`='0',`maxdmg`='0',`attackpower`='0' WHERE `entry` IN ('22250'); -- 7999 7999 35 35 0 128 4
DELETE FROM `creature_template_addon` WHERE `entry` IN ('22250'); 
INSERT INTO `creature_template_addon` VALUES
(22250,0,0,0,0,0,0,0,'38652 0');
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('22250');
INSERT INTO `creature_ai_scripts` VALUES
('2225001','22250','0','0','100','2','18000','18000','0','0','11','38652','0','7','37','0','0','0','0','0','0','0','Rancid Mushroom - Cast Spore Cloud and die after 18s'); -- so broken xD
-- ('2225002','22250','6','0','100','2','0','0','0','0','11','38652','0','7','0','0','0','0','0','0','0','0','Rancid Mushroom - Cast Spore Cloud on Death'); -- so broken xD
--
-- Trigger NPC for 17990
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|'4'|'131072'|'262144' WHERE `entry` IN ('17990','20189'); -- 0
DELETE FROM `creature_template_addon` WHERE `entry` IN ('17990','20189'); 
INSERT INTO `creature_template_addon` VALUES
(17990,0,0,0,0,0,0,0,'31689 0'),
(20189,0,0,0,0,0,0,0,'31689 0');

-- set to 40% for all heroic endbosses
UPDATE `creature_loot_template` SET `groupid`='1',`ChanceOrQuestChance`='40' WHERE `entry` IN ('20657') AND `item` IN ('50006'); -- 0 66 

-- Keli'dan the Breaker
DELETE FROM `creature_loot_template` WHERE `entry` = 18607 AND `item` IN (18607,27494,27495,27497,27505,27506,27507,27512,27514,27522,27788,28121,28264);
INSERT INTO `creature_loot_template` VALUES (18607,18607,100,1,-18607,2,0,0,0);
DELETE FROM `reference_loot_template` WHERE `entry` = 18607;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`groupid`,`mincountOrRef`,`maxcount`,`lootcondition`,`condition_value1`,`condition_value2`) VALUES
-- nonset
(18607,27494,0,1,1,1,0,0,0),
(18607,27495,0,1,1,1,0,0,0),
(18607,27505,0,1,1,1,0,0,0),
(18607,27506,0,1,1,1,0,0,0),
(18607,27507,0,1,1,1,0,0,0),
(18607,27512,0,1,1,1,0,0,0),
(18607,27514,0,1,1,1,0,0,0),
(18607,27522,0,1,1,1,0,0,0),
(18607,27788,0,1,1,1,0,0,0),
(18607,28121,0,1,1,1,0,0,0),
-- set
(18607,27497,0,1,1,1,0,0,0),
(18607,28264,0,1,1,1,0,0,0);

-- set to 40% for all heroic endbosses
UPDATE `creature_loot_template` SET `groupid`='1',`ChanceOrQuestChance`='40' WHERE `entry` = 19894 AND `item` = 50024; -- 0 66 
-- Quagmirran 17942,19894
DELETE FROM `creature_loot_template` WHERE `entry` = 19894 AND `item` IN (19894,27672,27673,27683,27712,27713,27714,27740,27741,27742,27796,27800,28337);
INSERT INTO `creature_loot_template` VALUES (19894,19894,100,2,-19894,2,0,0,0);
DELETE FROM `reference_loot_template` WHERE `entry` = 19894;
INSERT INTO `reference_loot_template` (`entry`,`item`,`ChanceOrQuestChance`,`groupid`,`mincountOrRef`,`maxcount`,`lootcondition`,`condition_value1`,`condition_value2`) VALUES
-- nonset
(19894,27672,0,2,1,1,0,0,0),
(19894,27673,0,2,1,1,0,0,0),
(19894,27683,0,2,1,1,0,0,0),
(19894,27712,0,2,1,1,0,0,0),
(19894,27713,0,2,1,1,0,0,0),
(19894,27714,0,2,1,1,0,0,0),
(19894,27740,0,2,1,1,0,0,0),
(19894,27741,0,2,1,1,0,0,0),
(19894,27742,0,2,1,1,0,0,0),
(19894,27796,0,2,1,1,0,0,0),
(19894,27800,0,2,1,1,0,0,0),
(19894,28337,0,2,1,1,0,0,0);

-- Ember of Al'ar 19551
-- http://www.wowhead.com/npc=19551/ember-of-alar#abilities http://wowwiki.wikia.com/wiki/Ember_of_Al'ar
-- Hit for ~1500 damage.  mob_ember_of_alar
UPDATE `creature_template` SET `minlevel`=70,`maxlevel`=70,`minhealth`=140000,`maxhealth`=140000,`speed`=1.48,`mindmg`=3147,`maxdmg`=3219,`baseattacktime`=1400,`resistance2`=-1,`mechanic_immune_mask`=75644246,`flags_extra`=4194304 WHERE `entry` = 19551; -- 140000 1520 1664 2000 -- 6,294 - 6,438

-- Spectral Charger Hits for around 1200 to 1500 on 23k AC
UPDATE `creature_template` SET `speed`='1.38',`mechanic_immune_mask`='8389137',`mindmg`='2750',`maxdmg`='4400' WHERE `entry` IN ('15547'); -- 8500 - 10095 1527 3122

-- Spectral Stallion
UPDATE `creature_template` SET `armor`='7100',`speed`='1.38',`mechanic_immune_mask`='8389137',`mindmg`='3000',`maxdmg`='5000' WHERE `entry` IN ('15548'); -- 20 1.71 2,700 - 3,300 450 1050

-- Spectral Apprentice 16389 
UPDATE `creature_template` SET `mindmg`='2508',`maxdmg`='2978' WHERE `entry` IN ('16389 '); -- 5,015 - 5,956 901 1842

-- Spectral Stable Hand
UPDATE `creature_template` SET `modelid_A2`='16398',`modelid_H2`='16398',`speed`='1.38',`mechanic_immune_mask`='8389137',`mindmg`='2009',`maxdmg`='2385' WHERE `entry` IN ('15551'); -- 723 1474 -- 4,018 - 4,769 

--
-- ohf patrols respawn increased
UPDATE `creature` SET `id`='22128',`spawntimesecs`='1800' WHERE `guid` IN ('83910','83907','83930','83932','83940','83950','83962','83940'); -- 900

-- improve respawn behavior for ohf patrols
DELETE FROM `creature_linked_respawn` WHERE `guid` IN (83996,83910,83911,83950,83951,83930,83931,83962,83963,83906,83907,83940,83941,83932,83933);
INSERT INTO `creature_linked_respawn` VALUES
--
--
--
--
--
(83910,83950),
(83911,83950),
--
(83950,83950),
(83951,83950),
--
(83930,83950),
(83931,83950),
--
(83962,83950),
(83963,83950),
--
(83906,83950),
(83907,83950),
--
(83940,83950),
(83941,83950),
--
(83932,83950),
(83933,83950);

DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` IN ('17942');
INSERT INTO `creature_ai_scripts` VALUES 
('1794201','17942','0','0','100','7','8000','15000','8000','13000','11','40504','1','0','0','0','0','0','0','0','0','0','Quagmirran - Cast Cleave'),
('1794202','17942','9','0','100','7','0','5','8000','15000','11','32055','1','0','0','0','0','0','0','0','0','0','Quagmirran - Cast Uppercut'),
('1794205','17942','0','0','100','7','15000','15000','24000','24000','11','38153','4','1','0','0','0','0','0','0','0','0','Quagmirran - Cast Acid Spray'),
('1794206','17942','0','0','100','3','6000','12000','12000','20000','11','34780','0','0','0','0','0','0','0','0','0','0','Quagmirran (Normal) - Cast Poison Volley'),
('1794207','17942','0','0','100','5','6000','12000','12000','20000','11','39340','0','0','0','0','0','0','0','0','0','0','Quagmirran (Heroic) - Cast Poison Volley');

-- leotheras texts
UPDATE `script_texts` SET `content_default`='Be gone, trifling elf. I am in control now!' WHERE `entry` = -1548010;
UPDATE `script_texts` SET `content_default`='Finally, my banishment ends!' WHERE `entry` = -1548009;
