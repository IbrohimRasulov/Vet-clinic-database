/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

ALTER TABLE animals
ADD species VARCHAR(100);

ALERT TABLE ANIMALS
ADD owner_id INT;

ALERT TABLE ANIMALS
ADD CONSTRAINT species_key
FOREIGN KEY (species_id) REFERENCES species(id);

ALERT TABLE ANIMALS
ADD CONSTRAINT owner_key
FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE OWNERS (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE SPECIES (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE VETS (
    id INT GENERATED ALWAYS as IDENTITY NOT NULL,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

CREATE TABLE SPECIALIZATION (
    species_id INT,
    vets_id INT,
    CONSTRAINT species_key
        FOREIGN KEY (species_id)
            REFERENCES species(id),
    CONSTRAINT vets_key
        FOREIGN KEY (vets_id)
            REFERENCES vets(id)
                ON DELETE CASCADE
);

CREATE TABLE VISITS (
    animal_id INT,
    vets_id INT,
    date_of_visit DATE,
    CONSTRAINT animal_key
        FOREIGN KEY (animal_id)
            REFERENCES animals(id),
    CONSTRAINT vets_key
        FOREIGN KEY (vets_id)
            REFERENCES vets(id)
);

--! Milestone 5

ALTER TABLE owners
ADD COLUMN email VARCHAR(120);
