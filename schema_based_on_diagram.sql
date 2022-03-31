CREATE TABLE patients(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(100),
  date_of_birth DATE,
  PRIMARY KEY(id)
);

CREATE TABLE invoices(
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
  generated_at DATE,
  payed_at DATE,
  medical_history_id INT,
  PRIMARY KEY(id)
);

CREATE TABLE medical_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at DATE,
  patient_id INT,
  status VARCHAR(100),
  PRIMARY KEY(id)
);

CREATE TABLE invoice_items(
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoices_id INT,
  treatment_id INT,
  PRIMARY KEY(id)
);

CREATE TABLE treatments(
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(100),
  name VARCHAR(100),
  PRIMARY KEY(id)
);

ALTER TABLE invoices
ADD CONSTRAINT fk_medical_history KEY (medical_history_id) REFERENCES medical_histories(id);

ALTER TABLE invoice_items
ADD CONSTRAINT fk_invoice_id FOREIGN KEY (invoices_id) REFERENCES invoices(id);

ALTER TABLE invoice_items
ADD CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES treatments(id);

ALTER TABLE medical_histories
ADD CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES patients(id);

CREATE TABLE treatmets_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  treatment_id INT,
  medical_history_id INT,
  CONSTRAINT fk_treatment_id
    FOREIGN KEY (treatment_id)
      REFERENCES treatments(id),
  CONSTRAINT fk_medical_history_id
    FOREIGN KEY (medical_history_id)
      REFERENCES medical_histories(id),
  PRIMARY KEY(id, treatment_id, medical_history_id)
);

CREATE INDEX patient_id_asc ON medical_histories(patient_id ASC);
CREATE INDEX invoices_id_asc ON invoice_items(invoices_id ASC);
CREATE INDEX treatment_id_asc ON invoice_items(treatment_id ASC);
CREATE INDEX medical_history_id_asc ON invoices(medical_history_id ASC);
