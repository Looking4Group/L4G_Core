#first part (up to Rival title (2147483648))
UPDATE `characters`
SET `data`= CONCAT(CAST(SUBSTRING_INDEX(`data`, ' ', 924) AS CHAR), ' ',
    (CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`data`, ' ', 925), ' ', -1) AS UNSIGNED) &~ 1245003644928), ' ',
    CAST(SUBSTRING_INDEX(`data`, ' ', -668) AS CHAR));

#second part (from Chellenger (4294967296 -> 1))
UPDATE `characters`
SET `data` = CONCAT(CAST(SUBSTRING_INDEX(`data`, ' ', 925) AS CHAR), ' ',
    (CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`data`, ' ', 926), ' ', -1) AS UNSIGNED) &~ 289), ' ',
    CAST(SUBSTRING_INDEX(`data`, ' ', -667) AS CHAR));
