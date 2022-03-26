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

SELECT full_name as owner_name, name as animal_name
FROM OWNERS O
JOIN ANIMALS A ON O.id = A.owner_id
WHERE O.full_name = 'Melody Pond';

SELECT A.name, S.name as type
FROM species S
JOIN ANIMALS A ON S.id = A.species_id
WHERE S.name = 'Pokemon';

SELECT full_name as owner_name, name as animal_name
FROM OWNERS O
LEFT JOIN ANIMALS A ON O.id = A.owner_id;

SELECT S.name as type, COUNT(A.id)
FROM SPECIES S
JOIN ANIMALS A ON S.id = A.species_id
GROUP BY S.name;

SELECT O.full_name as owner_name, A.name as animal_name
FROM OWNERS O
JOIN ANIMALS A ON O.id = A.owner_id
JOIN SPECIES S ON S.id = A.species_id
WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';

SELECT O.full_name as owner_name, name as animal_name
FROM OWNERS O
JOIN ANIMALS A ON O.id = A.owner_id
WHERE A.escape_attempts = 0 AND O.full_name = 'Dean Winchester';

SELECT filtered.owner_name
FROM (
  SELECT O.full_name as owner_name, COUNT(A.id) as animal_owned
  FROM OWNERS O
  JOIN ANIMALS A ON O.id = A.owner_id
  GROUP BY O.full_name
) as filtered
WHERE filtered.animal_owned = (
  SELECT MAX (filtered.animal_owned)
  FROM (
    SELECT O.full_name as owner_name, COUNT(A.id) as animal_owned
    FROM OWNERS O
    JOIN ANIMALS A ON O.id = A.owner_id
    GROUP BY O.full_name
  ) as filtered
);
