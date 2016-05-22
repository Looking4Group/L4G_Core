// -- FOR CHARACTERS DB ! ("realm" in trigger is name of realm DB)

DROP TABLE IF EXISTS accchange_log;
CREATE TABLE accchange_log
(
    id INT NOT NULL AUTO_INCREMENT,
    old_acc int NOT NULL,
    new_acc int NOT NULL,
    date CHAR(25) NOT NULL,
    char int default 0,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS accchange_upd_check;
delimiter |
CREATE TRIGGER accchange_upd_check BEFORE UPDATE ON characters
  FOR EACH ROW BEGIN
	IF NEW.account != OLD.account THEN
		INSERT INTO realm.accchange_log VALUES ('XXX', OLD.account, NEW.account, NOW(), NEW.guid);
	END IF;
  END;
|
delimiter ;
