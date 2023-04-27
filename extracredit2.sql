DROP TABLE IF EXISTS favorite_pokemon_type;
DROP TABLE IF EXISTS teaming_up;
DROP TABLE IF EXISTS trainer;

CREATE TABLE trainer (
  trainer_id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name VARCHAR(80) NOT NULL,
  last_name VARCHAR(80) NOT NULL
);

CREATE TABLE favorite_pokemon_type (
  trainer_id INT NOT NULL REFERENCES trainer(trainer_id),
  type VARCHAR(20) NOT NULL
);

CREATE TABLE teaming_up (
  trainer_id INT NOT NULL REFERENCES trainer (trainer_id),
  pokemon_id INT NOT NULL REFERENCES pokemon_2NF (pokedex_number)
);

INSERT INTO trainer (first_name, last_name)
VALUES ('Jordan', 'Lee'),
  ('Tyler', 'Todd'),
  ('Ash', 'Ketchum'),
  ('Lebron', 'James');

INSERT INTO favorite_pokemon_type (trainer_id, type)
VALUES (1, 'Fire'),
  (2, 'Water'),
  (3, 'Electric'),
  (4, 'Rock');

INSERT INTO teaming_up (trainer_id, pokemon_id)
VALUES (1, 6),
  (1, 2),
  (2, 9),
  (2, 8),
  (2, 7),
  (3, 25),
  (3, 24),
  (4, 10),
  (4, 10);
