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

SELECT VE.name, A.name, VI.date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
WHERE VE.name = 'William Tatcher'
ORDER BY VI.date_of_visit DESC
LIMIT 1;

CREATE VIEW stephanie_visits as
  SELECT A.name, COUNT(A.name)
  FROM ANIMALS A
  JOIN VISITS VI ON VI.animal_id = A.id
  JOIN VETS VE ON VI.vets_id = VE.id
  WHERE VE.name = 'Stephanie Mendez'
  GROUP BY A.name;

SELECT COUNT(name) FROM stephanie_visits;

SELECT VE.name as VET, S.name as Speciality
FROM VETS VE
LEFT JOIN SPECIALIZATION ON VE.id = SPECIALIZATION.vets_id
LEFT JOIN SPECIES S ON S.id = SPECIALIZATION.species_id;

SELECT A.NAME as animal, VI.date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
WHERE VE.name = 'Stephanie Mendez' AND VI.date_of_visit BETWEEN '1-4-2020' AND '30-8-2020';

SELECT A.name, COUNT(A.name) as number_of_visits
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
GROUP BY A.name
ORDER BY number_of_visits DESC
LIMIT 1;

SELECT A.name as animal, VI. date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
WHERE VE.name = 'Maisy Smith'
ORDER BY VI.date_of_visit
LIMIT 1;

SELECT A.name AS animal, S.name as type, A.date_of_birth as birth_date,
A.escape_attempts, A.weight_kg, A.neutered, O.full_name as owner,
VE.name as vet, VE.age as vet_age, VE.date_of_graduation, VI.date_of_visit
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
JOIN SPECIES S ON A.species_id = S.id
JOIN OWNERS O ON A.owner_id = O.id
ORDER BY VI.date_of_visit DESC
LIMIT 1;

CREATE VIEW Speciality as
  SELECT innerVe.name as VET
  FROM VETS innerVe
  LEFT JOIN SPECIALIZATION ON innerVe.id = SPECIALIZATION.vets_id
  LEFT JOIN SPECIES innerS ON innerS.id = SPECIALIZATION.species_id;

SELECT COUNT(VI.date_of_visit)
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VE.id = VI.vets_id
LEFT JOIN SPECIALIZATION SPE ON VE.id = SPE.vets_id
WHERE (A.species_id != SPE.species_id OR SPE.species_id IS NULL) AND 2 != (
  SELECT COUNT(Speciality.vet)
  FROM Speciality
  WHERE Speciality.vet = VE.name
);

SELECT S.name, COUNT(S.name) as VISITS
FROM ANIMALS A
JOIN VISITS VI ON VI.animal_id = A.id
JOIN VETS VE ON VI.vets_id = VE.id
JOIN SPECIES S ON S.id = A.species_id
WHERE VE.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY VISITS DESC
LIMIT 1;

--! Milestone 5

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
-- Execution Time: 1237.492 ms

EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
-- Execution Time: 1163.343 ms

EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
-- Execution Time: 1045.216 ms
