DROP TABLE IF EXISTS pokemon_1NF;

CREATE TABLE temp_split AS
SELECT trim(value) AS ability, pokedex_number
FROM imported_pokemon_data,
	json_each('["' || replace(abilities, ',', '","') || '"]')
WHERE ability <> '';

UPDATE temp_split
SET ability = REPLACE(REPLACE(REPLACE(ability, '[', ''), ']', ''),'''', '');

CREATE TABLE temp1 AS
SELECT *
FROM imported_pokemon_data;

ALTER TABLE temp1
DROP COLUMN abilities;

CREATE TABLE pokemon_1NF AS
SELECT *
FROM temp_split ts
JOIN temp1 t1 ON ts.pokedex_number = t1.pokedex_number;

ALTER TABLE pokemon_1NF
DROP 'pokedex_number:1';

DROP TABLE temp1;
DROP TABLE temp_split;