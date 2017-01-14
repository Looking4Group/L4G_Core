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
