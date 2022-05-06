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


/* Create a table named vets */
CREATE TABLE vets( id SERIAL PRIMARY KEY, name TEXT, age INT, date_of_graduation DATE)

/* There is a many-to-many relationship between the tables species and vets: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called specializations to handle this relationship. */
CREATE TABLE specializations( vet_id INT, species_id INT, CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id), CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id))

/* There is a many-to-many relationship between the tables animals and vets: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit. */
CREATE TABLE visits( vet_id INT, animal_id INT, visit_date DATE, CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id), CONSTRAINT fk_animal FOREIGN KEY (animal_id) REFERENCES animals(id))