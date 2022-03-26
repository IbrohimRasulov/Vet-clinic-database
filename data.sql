/* Populate database WITH sample data. */

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  (1, 'Agumon', '3-FEB-2020', 0, true, 10.23),
  (2, 'Gabumon', '15-NOV-2018', 2, true, 8),
  (3, 'Pikachu', '7-JAN-2021', 1, false, 15.04),
  (4, 'Devimon', '12-MAY-2017', 5, true, 11),
  (5, 'Charmander', '8-FEB-2020', 0, false, -11),
  (6, 'Plantmon', '15-NOV-2021', 2, true, -5.7),
  (7, 'Squirtle', '2-APR-1993', 3, false, -12.13),
  (8, 'Angemon', '12-JUN-2005', 1, true, -45),
  (9, 'Boarmon', '7-JUN-2005', 7, true, 20.4),
  (10, 'Blossom', '13-OCT-1998', 3, true, 17),
  (11, 'Ditto', '14-MAY-2022', 4, true, 22);

INSERT INTO owners(full_name, age)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES
  ('Pokemon'),
  ('Digimon');

UPDATE ANIMALS
SET species_id = 1;
UPDATE ANIMALS
SET species_id = 2
WHERE name LIKE '%mon%';


UPDATE ANIMALS
SET owner_id = 1
WHERE name = 'Agumon';
SAVEPOINT OWNER_1;
UPDATE ANIMALS
SET owner_id = 2
WHERE name IN ('Gabumon', 'Pikachu');
SAVEPOINT OWNER_2;
UPDATE ANIMALS
SET owner_id = 3
WHERE name IN ('Devimon', 'Plantmon');
SAVEPOINT OWNER_3;
UPDATE ANIMALS
SET owner_id = 4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
SAVEPOINT OWNER_4;
UPDATE ANIMALS
SET owner_id = 5
WHERE name IN ('Angemon', 'Boarmon');
SAVEPOINT OWNER_5;
