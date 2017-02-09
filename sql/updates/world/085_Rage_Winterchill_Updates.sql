-- Texts and sounds
DELETE FROM `script_texts` WHERE `entry` BETWEEN -1999980 AND -1999973;
INSERT INTO `script_texts` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`, `sound`, `type`, `language`, `emote`, `comment`) VALUES 
(-1999980, 'The Legion''s final conquest has begun! Once again the subjugation of this world is within our grasp. Let none survive!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11022, 6, 0, 0, 'YELL_ONAGGRO'),
(-1999979, 'All life must perish!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11025, 6, 0, 0, 'YELL_ONSLAY1'),
(-1999978, 'Victory to the Legion!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11057, 6, 0, 0, 'YELL_ONSLAY2'),
(-1999977, 'Crumble and rot!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11023, 6, 0, 0, 'YELL_DECAY1'),
(-1999976, 'Ashes to ashes, dust to dust.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11055, 6, 0, 0, 'YELL_DECAY2'),
(-1999975, 'Succumb to the icy chill... of death!', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11024, 6, 0, 0, 'YELL_NOVA1'),
(-1999974, 'It will be much colder in your grave', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11058, 6, 0, 0, 'YELL_NOVA2'),
(-1999973, 'You have won this battle, but not... the... war.', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 11026, 6, 0, 0, 'YELL_ONDEATH');
