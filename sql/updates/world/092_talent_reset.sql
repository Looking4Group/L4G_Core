-- change talent reset token to 20day duration
UPDATE `item_template` SET `Duration` = '-1728000', `description` = 'Use to reset talents', `name`= 'Hellfire Talent Reset Token', `class` = '15', `maxcount` = '1', `stackable` = '1', `BuyPrice` = '2000000' WHERE `entry` = 1000022;
