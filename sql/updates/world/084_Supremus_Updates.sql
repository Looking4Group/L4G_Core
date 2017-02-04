-- Supremus movement speed, bonding box, combat reach
UPDATE `creature_template` SET `speed` = 1.7 WHERE `entry` = 22898;
UPDATE `creature_model_info` SET `bounding_radius` = 20,`combat_reach` = 20 WHERE `modelid` = 21145;

-- Supremus Punch Invis Stalker. Script no longer needed, it's all controlled from Supremus script.
UPDATE `creature_template` SET `ScriptName` = '' WHERE `entry` = 23095;

-- Supremus Volcanos
UPDATE `creature_template` SET `unit_flags` = 33817094, `AIName` = 'EventAI', `ScriptName` = '' WHERE `entry` = 23085; -- UNIT_FLAG_NON_ATTACKABLE, UNIT_FLAG_DISABLE_MOVE, UNIT_FLAG_PASSIVE, UNIT_FLAG_DISABLE_ROTATE, UNIT_FLAG_NOT_SELECTABLE
DELETE FROM creature_ai_scripts WHERE entryOrGuid=23085;
INSERT INTO creature_ai_scripts VALUES 
('2308501','23085','1','0','100','0','1000','1000','1000','1000','11','40117','0','20','0','0','0','0','0','0','0','0','(BT) Supremus Volcanic Geyser - Cast Volcanic Eruption on Self');
