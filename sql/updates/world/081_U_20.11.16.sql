-- -----------------------------------
-- Saltgurka Update 14
-- -----------------------------------
 
-- Manna biscuits can now be eaten by hunter pets
UPDATE `item_template` SET `foodtype`=4 WHERE `entry`=34062;
 
-- Hemorrhage no longer procs on non-physical spells.
DELETE FROM `spell_proc_event` WHERE `entry` IN (16511,17347,17348,26864);
INSERT INTO `spell_proc_event` (`entry`,`SpellFamilyName`,`procFlags`) VALUES
(16511,8,0x000222A8),
(17347,8,0x000222A8),
(17348,8,0x000222A8),
(26864,8,0x000222A8);
 
 
-- Rampage. First proc is on melee crit only, all following procs are on both melee normal and melee crit hits.
UPDATE `spell_proc_event` SET `procEx`=3 WHERE `entry` IN (29801,30030,30033);
-- Fix exploit that allowed you to cancel the stacking aura, but that didn't remove the invisible aura, which mean you would start stacking again without having to pay 20 Rage to activate it.
-- This exploit allowed the buff to last double as long if you did it at the right moment.
DELETE FROM `spell_linked_spell` WHERE `spell_trigger`='-30032';
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `comment`) VALUES ('-30032', '-30033', 'Remove Warrior Rampage trigger if player cancels the Stacking Aura.');
