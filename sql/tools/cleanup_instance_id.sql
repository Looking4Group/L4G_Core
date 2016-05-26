CREATE TABLE `instance_helper` (`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,`oldid` INT(10) UNSIGNED NULL DEFAULT '0',PRIMARY KEY (`id`) ) COLLATE='utf8_general_ci' ENGINE=InnoDB SELECT `id` as `oldid` from `instance`;

UPDATE `character_instance` ci JOIN instance_helper ih ON ci.instance = ih.oldid SET ci.instance = ih.id;
UPDATE `group_instance` ci JOIN instance_helper ih ON ci.instance = ih.oldid SET ci.instance = ih.id;
UPDATE `instance` ci JOIN instance_helper ih ON ci.id = ih.oldid SET ci.id = ih.id;
UPDATE `creature_respawn` ci JOIN instance_helper ih ON ci.instance = ih.oldid SET ci.instance = ih.id;
UPDATE `gameobject_respawn` ci JOIN instance_helper ih ON ci.instance = ih.oldid SET ci.instance = ih.id;
DROP TABLE `instance_helper`;