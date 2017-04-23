CREATE TABLE IF NOT EXISTS `character_reports` (
	`player_guid` INT UNSIGNED NOT NULL COMMENT 'The reported player\'s GUID',
	`report_type` TINYINT UNSIGNED NOT NULL COMMENT 'The type of report (mail=0, chat=1)',
	`report_count` INT UNSIGNED NOT NULL COMMENT 'The number of reports of the specific type for the player'
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

