/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Agumon', '2020-02-3', 0, true, 10.23)
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Gabumon', '2018-11-15', 2, true, 8)
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Pikachu', '2021-01-07', 1, false, 15.04)
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES('Devimon', '2012-05-12', 5, true, 11)

/* INSERT NEW DATA */

INSERT INTO animals (name, date_of_birth,  weight_kg, neutered, escape_attempts) 
  VALUES
    ('Charmander', '2020-02-08', 11, false, 0),
    ('Plantmon', '2021-11-15', 5.7, true, 2),
    ('Squirtle', '1993-04-02', 12.13, false, 3),
    ('Angemon', '2005-06-12', 45, true, 1),
    ('Boarmon', '2005-06-07', 20.4, true, 7),
    ('Blossom', '1998-10-13', 17, true, 3),
    ('Ditto', '2022-05-14', 22, true, 4);

/* Insert data into the owners table: */
INSERT INTO owners(full_name, age) VALUES
  ('Sam Smith', 34), 
  ('Jennifer Orwell', 19), 
  ('Bob', 45), 
  ('Melody Pond', 77), 
  ('Dean Winchester', 14), 
  ('Jodie Whittaker', 38);

/* Insert data into the species table: */
INSERT INTO species(name) VALUES
  ('Pokemon'), ('Digimon');

/* Modify your inserted animals so it includes the species_id value:
If the name ends in "mon" it will be Digimon
All other animals are Pokemon */
UPDATE animals
  SET species_id = CASE 
                        WHEN name LIKE '%mon' THEN 2
                        ELSE 1
                    END

/* Modify your inserted animals to include owner information (owner_id) */
UPDATE animals
  SET owner_id = CASE
                      WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith' )
                      WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' )
                      WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob' )
                      WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond' )
                      WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester' )
                    END;