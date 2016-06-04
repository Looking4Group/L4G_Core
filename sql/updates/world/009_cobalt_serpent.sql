-- fix a crash family was 22 which did not exists - so hunters which did try to tame them run into a crash
UPDATE `creature_template` SET `family`='27' WHERE `entry` IN (19428, 20688); 