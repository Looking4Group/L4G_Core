-- Quest available for all alliance players was reqrace 1001 before
UPDATE `quest_template` SET `RequiredRaces`='1101' WHERE `entry` IN ('10805','10806');


-- correct values for disenc skill for our insta70 items form quelthalas
UPDATE `item_template` SET `RequiredDisenchantSkill`='225' WHERE `entry` IN ('25784','25926');
UPDATE `item_template` SET `RequiredDisenchantSkill`='275' WHERE `entry` IN ('31617','25780','29776','29969','30402','29786','29789','29807','29812','29980','30005','30339','30394');
