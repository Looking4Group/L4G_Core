-- 5x Serpentshrine Console
UPDATE `gameobject_template`
SET `type`=1, `flags`=34, `data1`=86, `ScriptName`='GOUse_go_vashj_console_access_panel'
WHERE `entry` IN(185114, 185115, 185116, 185117, 185118);
-- Lady Vashj Bridge Console
UPDATE `gameobject_template`
SET `type`=0, `flags`=34, `data1`=86, `ScriptName`='GOUse_go_vashj_console_access_panel'
WHERE `entry` = 184568;
-- Lady Vashj Bridge
UPDATE `gameobject`
SET `animprogress`=100
WHERE `guid` IN(80001,80002,80003,80004);