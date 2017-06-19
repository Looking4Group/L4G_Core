ALTER TABLE `characters`
	ADD COLUMN `grantableLevels` tinyint(3) UNSIGNED NOT NULL default '0' AFTER `title`;