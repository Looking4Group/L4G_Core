DELETE FROM `looking4group_string` WHERE `entry` IN (13001, 13002, 13003);
-- entry: 13001 // Server first (green)
INSERT INTO `looking4group_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (13001, '|cff00ff00[Server First]: %s|r', NULL, NULL, '|cff00ff00[Server First]: %s|r', NULL, NULL, NULL, NULL, NULL);

-- entry: 13002 // Alliance first (blue)
INSERT INTO `looking4group_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (13002, '|cff0070dd[Alliance First]: %s|r', NULL, NULL, '|cff0070dd[Alliance First]: %s|r', NULL, NULL, NULL, NULL, NULL);

-- entry: 13003 // Horde first (red)
INSERT INTO `looking4group_string` (`entry`, `content_default`, `content_loc1`, `content_loc2`, `content_loc3`, `content_loc4`, `content_loc5`, `content_loc6`, `content_loc7`, `content_loc8`) VALUES (13003, '|c0ab5f400[Horde First]: %s|r', NULL, NULL, '|c0ab5f400[Horde First]: %s|r', NULL, NULL, NULL, NULL, NULL);
