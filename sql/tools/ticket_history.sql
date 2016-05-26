// -- FOR CHARACTERS DB !

CREATE TABLE IF NOT `ticket_history` (
  `guid` int(10) NOT NULL AUTO_INCREMENT,
  `playerGuid` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `createtime` int(10) NOT NULL,
  `timestamp` int(10) NOT NULL DEFAULT '0',
  `closed` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TRIGGER IF EXISTS ticket_insert_check;
delimiter |
CREATE TRIGGER ticket_insert_check BEFORE INSERT ON gm_tickets
  FOR EACH ROW BEGIN
    INSERT INTO ticket_history VALUES ('XXX', NEW.playerGuid, NEW.name, NEW.message, NEW.createtime, NEW.timestamp, NEW.closed, NEW.comment);
  END;
|
delimiter ;

DROP TRIGGER IF EXISTS ticket_upd_check;
delimiter |
CREATE TRIGGER ticket_upd_check BEFORE UPDATE ON gm_tickets
  FOR EACH ROW BEGIN
    UPDATE ticket_history
    SET message = NEW.message, name = NEW.name, timestamp = NEW.timestamp, closed = NEW.closed, comment = NEW.comment
    WHERE playerGuid = NEW.playerGuid AND createtime = NEW.createtime;
  END;
|
delimiter ;
