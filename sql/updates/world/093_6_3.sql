-- Incandescent Fel Spark 22323
UPDATE `creature_template` SET `resistance2` = '-1', `flags_extra` = `flags_extra`|262144 WHERE `entry` = 22323;
DELETE FROM `creature_ai_scripts` WHERE `entryOrGUID` = 22323;
INSERT INTO `creature_ai_scripts` VALUES
('2232301','22323','0','0','100','1','0','1000','10000','11000','11','36247','1','0','0','0','0','0','0','0','0','0','Incandescent Fel Spark - Cast Fel Fireball'),
('2232302','22323','6','0','100','0','0','0','0','0','11','44877','0','3','0','0','0','0','0','0','0','0','Incandescent Fel Spark - Cast Living Flare Master on Death');

-- Elemental Melee Attacks can not be blocked
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|262144 WHERE `dmgschool` != 0 AND `flags_extra` != `flags_extra`|262144;

