DELETE FROM `npc_vendor` WHERE `item` = 33783;
INSERT INTO `npc_vendor` VALUES (18821, 33783, 0, 0, 2236);
INSERT INTO `npc_vendor` VALUES (18822, 33783, 0, 0, 2236);

DELETE FROM `creature` WHERE `guid` IN (54687,54688,1189204);
DELETE FROM `creature` WHERE `guid` BETWEEN 359460 AND 359464;
INSERT INTO `creature` VALUES (359460, 15077, 0, 1, 0, 487, -14438, 474.425, 16.005, 3.71755, 300, 0, 0, 3700, 0, 0, 0);
INSERT INTO `creature` VALUES (359462, 15078, 0, 1, 0, 0, -14436.3, 472.755, 15.4216, 3.29867, 300, 0, 0, 3200, 0, 0, 0);
INSERT INTO `creature` VALUES (359464, 15079, 0, 1, 0, 0, -14438.7, 476.311, 15.3591, 4.04916, 300, 0, 0, 2600, 0, 0, 0);

DELETE FROM `game_event_creature` WHERE `guid` IN (54687,54688,1189204);
DELETE FROM `game_event_creature` WHERE `guid` BETWEEN 359460 AND 359464;
INSERT INTO `game_event_creature` VALUES (359460, 15);
INSERT INTO `game_event_creature` VALUES (359462, 15);
INSERT INTO `game_event_creature` VALUES (359464, 15);

UPDATE `creature_loot_template` SET `ChanceOrQuestChance` = 25, `groupid` = 9 WHERE `entry` = 9736 AND `item` = 12835;

UPDATE `creature` SET `spawnmask` = 0 WHERE `guid` IN (140773, 140774);

