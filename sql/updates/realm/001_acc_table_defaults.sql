ALTER TABLE `account`
MODIFY COLUMN `staff_id`  varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 0 AFTER `client_os_version_id`,
MODIFY COLUMN `activation`  varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' AFTER `isactive`;