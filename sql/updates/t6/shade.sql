-- Set Akama to Untargettable
UPDATE `creature_template` SET `unit_flags`=0 WHERE `entry`='22841';


-- Spiritbinder
UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`='23524';


-- Elementalist
UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`='23523';


-- Rogue
UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`='23318';


-- Sorcerer
UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`='23215';


-- Defender
UPDATE `creature_template` SET `ScriptName`='', `AIName`='EventAI' WHERE `entry`='23216';


DELETE FROM `creature_ai_scripts` WHERE entryOrGuid IN(23523,23524,23216,23318);


INSERT INTO `creature_ai_scripts` VALUES 
-- Ashtongue Elementalist
('2352301','23523','4','0','100','2','0','0','0','0','49','1','0','0','22','1','0','0','0','0','0','0','Ashtongue Elementalist - Enable Dynamic Movement and Set Phase 1 on Aggro'),
('2352302','23523','9','5','100','3','8','50','3400','4800','11','42024','1','0','0','0','0','0','0','0','0','0','Ashtongue Elementalist - Cast Lightning Bolt (Phase 1)'),
('2352303','23523','9','5','100','3','9','80','1000','1000','49','1','0','0','0','0','0','0','0','0','0','0','Ashtongue Elementalist - Enable Dynamic Movement at 9-80 Yards (Phase 1)'),
('2352304','23523','9','0','100','3','0','8','1000','1000','49','0','0','0','0','0','0','0','0','0','0','0','Ashtongue Elementalist - Disable Dynamic Movement at 0-8 Yards'),
('2352305','23523','3','5','100','2','7','0','0','0','49','0','0','0','22','2','0','0','0','0','0','0','Ashtongue Elementalist - Disable Dynamic Movement and Set Phase 2 when Mana is at 7% (Phase 1)'),
('2352306','23523','3','3','100','3','100','15','1000','1000','22','1','0','0','0','0','0','0','0','0','0','0','Ashtongue Elementalist - Set Phase 1 when Mana is above 15% (Phase 2)'),
('2352307','23523','0','0','100','3','12000','18000','16000','21000','11','42023','4','0','0','0','0','0','0','0','0','0','Ashtongue Elementalist - Cast Rain of Fire'),
('2352308','23523','7','0','100','2','0','0','0','0','22','0','0','0','0','0','0','0','0','0','0','0','Ashtongue Elementalist - Set Phase to 0 on Evade'),

-- Ashtongue Spiritbinder
('2352401','23524','14','0','100','3','10000','40','12000','16000','11','42025','6','0','0','0','0','0','0','0','0','0','Ashtongue Spiritbinder - Cast Spirit Mend on Friendlies'),
('2352402','23524','14','0','100','3','15000','40','18000','24000','11','42027','6','1','0','0','0','0','0','0','0','0','Ashtongue Spiritbinder - Cast Chain Heal on Friendlies'),
('2352403','23524','14','0','100','3','18000','100','21000','30000','11','42318','6','1','0','0','0','0','0','0','0','0','Ashtongue Spiritbinder - Cast Spirit Heal on Friendlies'),

-- Ashtongue Defender
('2321601','23216','9','0','100','3','0','5','6000','11000','11','41178','1','0','0','0','0','0','0','0','0','0','Ashtongue Defender - Cast Debilitating Strike'),
('2321602','23216','0','0','100','3','11000','16000','13000','17000','11','41975','5','0','0','0','0','0','0','0','0','0','Ashtongue Defender - Cast Heroic Strike'),
('2321603','23216','0','0','100','3','8000','15000','16000','21000','11','41180','1','0','0','0','0','0','0','0','0','0','Ashtongue Defender - Cast Shield Bash'),
('2321604','23216','13','0','100','3','5000','10000','0','0','11','41180','1','1','0','0','0','0','0','0','0','0','Ashtongue Defender - Cast Shield Bash on Target Casting'),

-- Ashtongue Rogue
('2331801','23318','11','0','100','2','0','0','0','0','11','42459','0','1','0','0','0','0','0','0','0','0','Ashtongue Rogue - Cast Dual Wield on Spawn'),
('2331802','23318','9','0','100','3','0','5','11000','14000','11','41978','1','0','0','0','0','0','0','0','0','0','Ashtongue Rogue - Cast Debilitating Poison'),
('2331803','23318','12','0','100','3','15','0','11000','15000','11','41177','1','0','0','0','0','0','0','0','0','0','Ashtongue Rogue - Cast Eviscerate at 15% Target HP');






















