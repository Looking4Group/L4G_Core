-- Movement speed, damage, immune mask.
UPDATE `creature_template` SET `speed`='1.71',`mindmg`='12225',`maxdmg`='14510',`mechanic_immune_mask`='650854231' WHERE `entry` = '17767';

-- Texts and sounds
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1999980 AND -1999973;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES 
(-1999980, 'The Legion''s final conquest has begun! Once again the subjugation of this world is within our grasp. Let none survive!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11022, 14, 0, 0, 'YELL_ONAGGRO'),
(-1999979, 'All life must perish!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11025, 14, 0, 0, 'YELL_ONSLAY1'),
(-1999978, 'Victory to the Legion!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11057, 14, 0, 0, 'YELL_ONSLAY2'),
(-1999977, 'Crumble and rot!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11023, 14, 0, 0, 'YELL_DECAY1'),
(-1999976, 'Ashes to ashes, dust to dust.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11055, 14, 0, 0, 'YELL_DECAY2'),
(-1999975, 'Succumb to the icy chill... of death!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11024, 14, 0, 0, 'YELL_NOVA1'),
(-1999974, 'It will be much colder in your grave', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11058, 14, 0, 0, 'YELL_NOVA2'),
(-1999973, 'You have won this battle, but not... the... war.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11026, 14, 0, 0, 'YELL_ONDEATH');
