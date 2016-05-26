CREATE USER 'hgcore'@'localhost' IDENTIFIED BY 'hgcore';
CREATE DATABASE `world` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE `characters` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE `realm` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON `world` . * TO 'hgcore'@'localhost';
GRANT ALL PRIVILEGES ON `characters` . * TO 'hgcore'@'localhost';
GRANT ALL PRIVILEGES ON `realmd` . * TO 'hgcore'@'localhost';
