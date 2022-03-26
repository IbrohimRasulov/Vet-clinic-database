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

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deletion;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* How many animals are there? */
SELECT COUNT(*) FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered, SUM(escape_attempts) FROM animals
GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg) FROM animals
GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;
