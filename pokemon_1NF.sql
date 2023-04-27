-- Table drops to keep data clean.
DROP TABLE IF EXISTS pokemon_1NF;
DROP TABLE IF EXISTS temp_split;
DROP TABLE IF EXISTS temp1;

-- This is a temporary table that houses the split values of abilities from the
-- original imported database. The table allows for abilities to be atomic and
-- follow the rules of 1NF
CREATE TABLE temp_split AS
SELECT trim(value) AS ability, pokedex_number
FROM imported_pokemon_data,
 json_each('["' || replace(abilities, ',', '","') || '"]')
WHERE ability <> '';

-- After spliting, [] and single quotes are left behind, this updates the values
-- and trims off the unwanted characters..
UPDATE temp_split
SET ability = REPLACE(REPLACE(REPLACE(ability, '[', ''), ']', ''),'''', '');

-- Creates a temporary copy of the imported database. This way we can manipulate
-- values without modifying the original copy. Additionally, the temporary table
-- makes combining tables easier in later steps.
CREATE TABLE temp1 AS
SELECT *
FROM imported_pokemon_data;

-- Joins temp_split and temp1 on pokedex_number, this removes the original
-- 'abilities' column while keeping all subsequent data the same. By doing this,
-- all values in pokemon_1NF are atomic.
CREATE TABLE pokemon_1NF AS
SELECT ts.ability,
 t1.against_bug,
 t1.against_dark,
 t1.against_dragon,
 t1.against_electric,
 t1.against_fairy,
 t1.against_fight,
 t1.against_fire,
 t1.against_flying,
 t1.against_ghost,
 t1.against_grass,
 t1.against_ground,
 t1.against_ice,
 t1.against_normal,
 t1.against_poison,
 t1.against_psychic,
 t1.against_rock,
 t1.against_steel,
 t1.against_water,
 t1.attack,
 t1.base_egg_steps,
 t1.base_happiness,
 t1.base_total,capture_rate,
 t1.classfication,
 t1.defense,
 t1.experience_growth,
 t1.height_m,
 t1.hp,
 t1.name,
 t1.percentage_male,
 t1.pokedex_number,
 t1.sp_attack,
 t1.sp_defense,
 t1.speed,
 t1.type1,
 t1.type2,
 t1.weight_kg,
 t1.generation,
 t1.is_legendary
FROM temp_split ts
JOIN temp1 t1 ON ts.pokedex_number = t1.pokedex_number;

-- Drops the temporary tables, as there is no need for them anymore. Also practices
-- clean and clear data modeling. 
DROP TABLE temp1;
DROP TABLE temp_split;