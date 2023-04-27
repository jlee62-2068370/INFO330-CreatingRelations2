-- Table drops to keep data clean.
DROP TABLE IF EXISTS ability_mapping;
DROP TABLE IF EXISTS abilities;
DROP TABLE IF EXISTS pokemon_3NF;
DROP TABLE IF EXISTS against_types;

-- Creates table to house all transitive relationships regarding types
-- Uses a composite primary key of type1 and type2 to determine the effectiveness of a
-- pokemon against a certain type.
CREATE TABLE against_types (
	type1 varchar(50) NOT NULL REFERENCES types,
	type2 varchar(50) REFERENCES types,
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
	PRIMARY KEY (type1, type2)
);

-- Table in 3NF with transtive relations removed from the table. This table keeps
-- the intial stats of a pokemon since they correlate with the pokemon itself
CREATE TABLE pokemon_3NF (
	pokedex_number INT PRIMARY KEY,
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
	is_legendary INT,
	FOREIGN KEY (type1, type2) REFERENCES against_types (type1, type2)
);

-- Following the rules of 2NF, Abilities table houses unique pokemon ability values.
-- This is to remove any duplicates in the table
CREATE TABLE abilities (
 ability varchar(50) NOT NULL PRIMARY KEY
);

-- Following the rules of 2NF, Ability mapping serves as the linking table between
-- pokemon_2NF and abilities. It is essential to have this table as it removes the
-- many-to-many connections that may occur between these tables.
CREATE TABLE ability_mapping (
 pokedex_number INT NOT NULL,
 ability varchar(50) NOT NULL,
 FOREIGN KEY (pokedex_number) REFERENCES pokemon_3NF (pokedex_number),
 FOREIGN KEY (ability)  REFERENCES abilities (ability)
);

-- Inserts non-duplicate ability values into the abilities table
INSERT INTO abilities (ability)
SELECT DISTINCT n1.ability
FROM pokemon_1NF n1;

-- Inserts all information regarding effectiveness on other types. This is sorted
-- and grouped by type1 and type2 combined. This follows the arguments required
-- for the composite key.
INSERT INTO against_types
SELECT type1, type2,
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
	against_water
FROM pokemon_2NF
GROUP BY type1, type2;

-- Inserts values that are non-transitive into pokemon_3NF
INSERT INTO pokemon_3NF
SELECT pokedex_number,
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
FROM pokemon_2NF;

-- Inserts atomic abilitity values into the mapping, alonside the pokedex_num
-- of the pokemon that uses the ability
INSERT INTO ability_mapping (pokedex_number, ability)
SELECT n1.pokedex_number, n1.ability
FROM pokemon_1NF n1;