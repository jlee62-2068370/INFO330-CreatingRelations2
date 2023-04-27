-- Table drops to keep data clean.
DROP TABLE IF EXISTS ability_mapping;
DROP TABLE IF EXISTS abilities;
DROP TABLE IF EXISTS pokemon_2NF;

-- Creating a new tablenamed pokemon_2NF with pokedex_number as the primary key
-- and drops the abilities column created in pokemon_1NF
CREATE TABLE pokemon_2NF (
 pokedex_number INT PRIMARY KEY,
 against_bug REAL,
 against_dark REAL,
 against_dragon REAL,
 against_electric REAL,
 against_fairy REAL,
 against_fight REAL,
 against_fire REAL,
 against_flying REAL,
 against_ghost REAL,
 against_grass REAL,
 against_ground REAL,
 against_ice REAL,
 against_normal REAL,
 against_poison REAL,
 against_psychic REAL,
 against_rock REAL,
 against_steel REAL,
 against_water REAL,
 attack INT,
 base_total INT,
 capture_rate INT,
 classfication varchar(50),
 defense INT,
 experience_growth INT,
 height_m REAL,
 hp INT,
 name varchar(50),
 percentage_male REAL,
 sp_attack INT,
 sp_defense INT,
 speed INT,
 type1 varchar(50),
 type2 varchar(50),
 weight_kg REAL,
 generation INT,
 is_legendary INT
);

-- Inserts information into the non-duplicate table from the imported .csv file
INSERT INTO pokemon_2NF
SELECT pokedex_number,
 against_bug,
 against_dark,
 against_dragon,
 against_electric,
 against_fairy,
 against_fight,
 against_fire,
 against_flying,
 against_ghost,
 against_grass,
 against_ground,
 against_ice,
 against_normal,
 against_poison,
 against_psychic,
 against_rock,
 against_steel,
 against_water,
 attack,
 base_total,
 capture_rate,
 classfication,
 defense,
 experience_growth,
 height_m,
 hp,
 name,
 percentage_male,
 sp_attack,
 sp_defense,
 speed,
 type1,
 type2,
 weight_kg,
 generation,
 is_legendary
FROM imported_pokemon_data;

-- Abilities table houses unique pokemon ability values
CREATE TABLE abilities (
 ability varchar(50) NOT NULL PRIMARY KEY
);

-- Ability mapping serves as the linking table between pokemon_2NF and abilities.
-- It is essential to have this table as it removes the many-to-many connection
-- that may occur between these tables.
CREATE TABLE ability_mapping (
 pokedex_number INT NOT NULL,
 ability varchar(50) NOT NULL,
 FOREIGN KEY (pokedex_number) REFERENCES pokemon_2NF (pokedex_number),
 FOREIGN KEY (ability)  REFERENCES abilities (ability)
);


-- Inserts non-duplicate ability values into the abilities table
INSERT INTO abilities (ability)
SELECT DISTINCT n1.ability
FROM pokemon_1NF n1;

-- Inserts atomic abilitity values into the mapping, alonside the pokedex_num
-- of the pokemon that uses the ability
INSERT INTO ability_mapping (pokedex_number, ability)
SELECT n1.pokedex_number, n1.ability
FROM pokemon_1NF n1;