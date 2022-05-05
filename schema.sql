/* Database schema to keep the structure of entire database. */

CREATE TABLE animals( id INT, name TEXT, date_of_birth DATE, escape_attempts INT, neutered BOOL, weight_kg FLOAT)

/*  ADD COLUMN */
ALTER TABLE animals ADD species varchar(50);

/* Create a table named owners */
CREATE TABLE owners( id SERIAL PRIMARY KEY, full_name TEXT, age INT );

/* Create a table named species */
CREATE TABLE species( id SERIAL PRIMARY KEY, name TEXT);

/* Modify animals table:
Make sure that id is set as autoincremented PRIMARY KEY */
ALTER TABLE animals 
  DROP COLUMN id,
  ADD COLUMN id SERIAL PRIMARY KEY;

/* Remove column species */
ALTER TABLE animals 
  DROP COLUMN species;

/* Add column species_id which is a foreign key referencing species table */
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);

/* Add column owner_id which is a foreign key referencing the owners table */
ALTER TABLE animals 
  ADD COLUMN owner_id INT,
  ADD FOREIGN KEY (owner_id) REFERENCES owners(id);