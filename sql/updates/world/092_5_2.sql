-- Pattern: Spellstrike Pants
UPDATE `creature_loot_template` SET `groupid` = 3 WHERE `entry` IN (18708,20657) AND `item` = 24309;

-- Aqueous Lord 22878
UPDATE `creature_template` SET `mindmg`='6938',`maxdmg`='7257' WHERE `entry` = 22878;

