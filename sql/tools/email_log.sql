// -- FOR REALM DB !

DROP TABLE IF EXISTS email_log;
CREATE TABLE email_log
(
    id INT NOT NULL AUTO_INCREMENT,
    old_email CHAR(50) NOT NULL,
    new_email CHAR(50) NOT NULL,
    date CHAR(25) NOT NULL,
    acc int default 0,
    PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS email_upd_check;
delimiter |
CREATE TRIGGER email_upd_check BEFORE UPDATE ON account
  FOR EACH ROW BEGIN
	IF NEW.email != OLD.email THEN
		INSERT INTO email_log VALUES ('XXX', OLD.email, NEW.email, NOW(), NEW.id);
	END IF;
  END;
|
delimiter ;
