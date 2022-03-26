/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals
WHERE name LIKE '%mon';

SELECT name from animals
WHERE date_of_birth BETWEEN '1-Jan-2016' AND '31-Dec-2019';

SELECT name from animals
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth from animals
WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts from animals
WHERE weight_kg > 10.5;

SELECT * from animals
WHERE neutered = true;

SELECT * from animals
WHERE name != 'Gabumon';

SELECT * from animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * from animals;


