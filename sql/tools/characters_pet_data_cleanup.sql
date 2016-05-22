DELETE FROM pet_aura           WHERE NOT EXISTS (SELECT id FROM character_pet WHERE id = pet_aura.guid);
DELETE FROM pet_spell          WHERE NOT EXISTS (SELECT id FROM character_pet WHERE id = pet_spell.guid);
DELETE FROM pet_spell_cooldown WHERE NOT EXISTS (SELECT id FROM character_pet WHERE id = pet_spell_cooldown.guid);
