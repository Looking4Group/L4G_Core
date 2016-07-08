DELETE FROM `spell_proc_event` WHERE `entry` IN (11213,12574,12575,12576,12577,12536,12043,29976);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
--
-- Mage
--
(11213,84,3,0,69632,3,0,2,1), -- Arcane Concentration (Rank 1) -- 0x00051000 mit aoes
(12574,84,3,0,69632,3,0,4,1), -- Arcane Concentration (Rank 2)
(12575,84,3,0,69632,3,0,6,1), -- Arcane Concentration (Rank 3)
(12576,84,3,0,69632,3,0,8,1), -- Arcane Concentration (Rank 4)
(12577,84,3,0,69632,3,0,10,1); -- Arcane Concentration (Rank 5)