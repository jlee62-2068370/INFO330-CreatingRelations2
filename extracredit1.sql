-- SQL script to insert "Huskichu", "Mascot"-type Pokemon into the database.
INSERT INTO imported_pokemon_data
VALUES (
  "['Super Bark', 'HuskyPower!']", -- abilities
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -- against_*
  09, -- attack
  5120, -- base_egg_steps
  100, -- base_happiness
  800, -- base_total
  100, -- capture_rate
  'Huskichu One of a Kind Pokemon', -- classification
  200, -- defense
  1250000, -- experience_growth
  0.4, -- height_m
  250, -- hp
  'Huskichu', -- name
  100, -- percentage_male
  09, -- pokedex_number (assumed it's not already taken)
  250, -- sp_attack
  250, -- sp_defense
  300, -- speed
  'Mascot', -- type1
  '', -- type2
  10, -- weight_kg
  7, -- generation
  1 -- is_legendary
);

----------------------------------------------------------------------
-- Write another SQL script that adds "Cougarite", another "Mascot"-type Pokemon.
INSERT INTO imported_pokemon_data
VALUES (
  "['Slow Attack']", -- abilities
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -- against_*
  1, -- attack
  10000, -- base_egg_steps
  50, -- base_happiness
  50, -- base_total
  110, -- capture_rate
  'Weak and lazy pokemon', -- classification
  5, -- defense
  5, -- experience_growth
  0.2, -- height_m
  1, -- hp
  'Cougarite', -- name
  0, -- percentage_male
  251, -- pokedex_number (assumed it's not already taken)
  0, -- sp_attack
  0, -- sp_defense
  10, -- speed
  'Mascot', -- type1
  '', -- type2
  1000, -- weight_kg
  7, -- generation
  0 -- is_legendary
);