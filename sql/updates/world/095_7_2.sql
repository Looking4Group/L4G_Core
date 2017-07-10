DELETE FROM creature_formations WHERE leaderguid IN (12880,12881,12872,12873);
DELETE FROM creature_formations WHERE memberguid IN (12880,12881,12872,12873);
INSERT INTO creature_formations VALUES
(12880,12880,100,360,2),
(12880,12881,100,360,2),
(12880,12872,100,360,2),
(12880,12873,100,360,2);

UPDATE `creature_template` SET `InhabitType` = 5 WHERE `entry` = 17260;

