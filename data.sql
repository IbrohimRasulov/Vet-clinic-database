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
