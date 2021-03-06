/*Queries that provide answers to the questions from all projects.*/

/* - Find all animals whose name ends in "mon". */
SELECT * FROM animals WHERE name LIKE '%mon';
/* - List the name of all animals born between 2016 and 2019.*/
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
/* - List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
/* - List date of birth of all animals named either "Agumon" or "Pikachu". */
SELECT date_of_birth FROM animals WHERE name = 'Pikachu' OR name = 'Agumon';
/* - List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
/*  - Find all animals that are neutered. */
SELECT name FROM animals WHERE neutered = true;
/*  - Find all animals not named Gabumon. */
SELECT * FROM animals WHERE name != 'Gabumon';
/*  - Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
/*   - How many animals are there? */
SELECT COUNT(*) FROM animals;
/*   - How many animals have never tried to escape? */
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
/*   - What is the average weight of animals? */
SELECT AVG(weight_kg) FROM animals;
/*   - Who escapes the most, neutered or not neutered animals? */
SELECT SUM(escape_attempts) FROM animals GROUP BY neutered;
SELECT AVG(escape_attempts) FROM animals GROUP BY neutered;
/*   - What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
/*   - What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth <= '2000-12-31' GROUP BY species;

/* TRANSACTIONS */
/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction. */
BEGIN;
	UPDATE animals SET species = 'unspecified';
ROLLBACK;

/* Inside a transaction: */
BEGIN;
/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. */
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
/* Update the animals table by setting the species column to pokemon for all animals that don't have species already set. */
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
/* Commit the transaction. */
COMMIT;
/* Verify that change was made and persists after commit. */
SELECT species from animals;

/* Inside a transaction delete all records in the animals table, then roll back the transaction. */
BEGIN;
  DELETE FROM animals;
ROLLBACK;
/* After the roll back verify if all records in the animals table still exist */
SELECT * FROM animals;


/* Inside a transaction: */
BEGIN;
/* Delete all animals born after Jan 1st, 2022. */
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
/* Create a savepoint for the transaction. */
SAVEPOINT SP1;
/* Update all animals' weight to be their weight multiplied by -1. */
UPDATE animals SET weight_kg = weight_kg * -1;
/* Rollback to the savepoint */
ROLLBACK TO SP1;
/* Update all animals' weights that are negative to be their weight multiplied by -1. */
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
/* Commit transaction */
COMMIT;

/* Write queries (using JOIN) to answer the following questions: */
/* What animals belong to Melody Pond? */
SELECT owners.full_name, animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond'

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name, species.name FROM animals JOIN species on animals.species_id = species.id WHERE species.name = 'Pokemon' 

/* List all owners and their animals, remember to include those that don't own any animal. */
SELECT animals.name, owners.full_name FROM animals FULL OUTER JOIN owners ON animals.owner_id = owners.id

/* How many animals are there per species? */
SELECT species.name, COUNT(animals.species_id) FROM species JOIN animals ON animals.species_id = species.id GROUP BY species.name;

/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND animals.species_id = (SELECT id FROM species WHERE name = 'Digimon')

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(animals.owner_id) FROM owners JOIN animals ON animals.owner_id = owners.id GROUP BY owners.full_name ORDER BY COUNT(animals.owner_id) DESC