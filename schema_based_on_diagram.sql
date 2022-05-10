CREATE TABLE patients(
  id SERIAL PRIMARY KEY,
  name TEXT,
  date_of_birth DATE
);

CREATE TABLE medical_histories(
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  status TEXT,
  patient_id INT,
  CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id)
);

CREATE TABLE invoices(
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  medical_history_id INT UNIQUE,
  CONSTRAINT fk_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

CREATE TABLE treatments(
  id SERIAL PRIMARY KEY,
  type TEXT,
  name TEXT
);

CREATE TABLE treatments_medical_histories_relations(
  treatment_id INT,
  medical_history_id INT,
  CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id),
  CONSTRAINT fk_medical_history FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);


CREATE TABLE invoice_items(
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES invoices(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);