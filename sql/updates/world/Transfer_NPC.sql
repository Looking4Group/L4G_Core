DELETE FROM creature_template WHERE entry = 1000004;
INSERT INTO creature_template VALUES
(1000004, 0, NULL, 21209, 0, 21209, 0, 'Level 70', 'Transfer NPC', '', 70, 70, 100000, 100000, 0, 0, 0, 1, 35, 35, 1, 1, 3, 0, 0, 0, 0, 0, 2000, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, 0, 0, '', 0, 3, 0, 1, 0, 0, 0, 'custom_transfer');
 
DELETE FROM creature WHERE guid = 16800923;
INSERT INTO creature VALUES
(16800923, 1000004, 29, 1, 0, 0, 2.6691, -0.6198, -144.7090, 1.5204, 25, 0, 0, 100000, 0, 0, 0);
