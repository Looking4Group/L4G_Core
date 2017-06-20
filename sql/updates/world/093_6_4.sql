-- Crashing Wave-Spirit 22309
UPDATE `creature_template` SET `resistance4` = -1 WHERE `entry` = 22309;
UPDATE `creature_template_addon` SET `auras` = NULL WHERE `entry` = 22309;

-- Midsummer Sausage 5er Stack
UPDATE `item_template` SET `BuyCount` = 5 WHERE `entry` = 23326;

