-- ==============
-- NON TEMPORARY
-- ==============

DELETE FROM `npc_text` WHERE `ID` = 30024;
INSERT INTO `npc_text` (`ID`, `text0_0`) VALUES ('30024', 'Sorry, but you have already used this feature. This 36 hour feature is only usable once per account/IP.');

UPDATE `npc_text` SET `text0_0`='You will receive full starter equipment set for your specified role and then will be teleported to your class trainer! \nPlease select your role: \n(NOTE: THE GEAR YOU HAVE EQUIPPED WILL BE DESTROYED)' WHERE `ID`='30012';

UPDATE `npc_text` SET `text0_0`='Note : You should not close this window during the level up process, if you do you will need to delete and recreate your character.\n\nWelcome to the Hellfire Progressive Burning Crusade Realm!' WHERE `ID`='30000';

CREATE TABLE `progress_realm`.`account_70_promo` (
  `accountID` INT(10) NOT NULL,
  `already_used` VARCHAR(10) NOT NULL DEFAULT 'no',
  PRIMARY KEY (`accountID`));


ALTER TABLE `progress_realm`.`account_70_promo` 
ADD COLUMN `registration_ip` VARCHAR(16) NOT NULL DEFAULT '0.0.0.0' AFTER `accountID`;


ALTER TABLE `progress_realm`.`account_70_promo` 
CHANGE COLUMN `accountID` `account_id` INT(10) NOT NULL ;

-- Instant 70 NPC Template
UPDATE creature_template SET scale = 1 WHERE entry = 1000001; 
DELETE FROM creature_template WHERE entry = 1000003; 
INSERT INTO creature_template VALUES 
(1000003, 0, NULL, 21209, 0, 21209, 0, 'Level 70', 'Instant Event NPC', '', 70, 70, 100000, 100000, 0, 0, 0, 1, 35, 35, 1, 1, 3, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 0, 'custom_instant_70_uncommon');


-- ==============
-- TEMPORARY
-- ==============

-- Instant 70 NPC Spawns
SET @GUID := 1688640; 
DELETE FROM creature WHERE guid BETWEEN @GUID AND @GUID + 8;
INSERT INTO creature VALUES 
(@GUID := @GUID + 0, 1000003, 1, 1, 0, 0, -2915.95, -256.444, 52.9413, 4.63156, 25, 0, 0, 100000, 0, 0, 0),
(@GUID := @GUID + 1, 1000003, 530, 1, 0, 0, 10352.5, -6360.56, 33.5492, 2.91885, 25, 0, 0, 100000, 0, 0, 0),
(@GUID := @GUID + 1, 1000003, 0, 1, 0, 0, -6236.31, 333.716, 382.826, 2.97499, 25, 0, 0, 100000, 0, 0, 0),
(@GUID := @GUID + 1, 1000003, 530, 1, 0, 0, -3958.58, -13935.1, 100.944, 2.59143, 25, 0, 0, 100000, 0, 0, 0),
(@GUID := @GUID + 1, 1000003, 1, 1, 0, 0, -612.258, -4254.75, 38.9562, 3.14205, 25, 0, 0, 100000, 0, 0, 0),
(@GUID := @GUID + 1, 1000003, 0, 1, 0, 0, 1676.2670, 1677.8623, 121.6705, 1.5689, 25, 0, 0, 100000, 0, 0, 0),
(@GUID := @GUID + 1, 1000003, 1, 1, 0, 0, 10315.3, 835.416, 1326.38, 3.22292, 25, 0, 0, 100000, 0, 0, 0),
(@GUID := @GUID + 1, 1000003, 0, 1, 0, 0, -8946.46, -135.317, 83.6775, 3.19178, 25, 0, 0, 100000, 0, 0, 0);

-- revert with backup file
-- better solution
UPDATE `npc_trainer` SET `spellcost` = 0 WHERE `entry` IN (3353,3354,3408,5479,5480,914,23128,928,5492,5491,3401,3328,3327,13283,6018,6014,5994,11397,5484,5885,5883,5882,7311,5958,20791,5497,331,5498,2485,3324,3326,3325,5496,461,5495,3034,3033,3036,5504,5505,5506,5515,5516,2879,5517,3406,3407,3352,10088,3403,13417,3344,20407);
