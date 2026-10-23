# Business Data Glossary - Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50
- **Component**: Target Database Schema (Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_target)
- **Tier Specification**: Tier 2: 60 Source Tables, 50 Target Tables
- **Total Target Tables**: 50
- **Theme Focus**: Healthcare Hospital, EMR Clinical, Pharma R&D & Wearable Health IoT
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `fhir_account_billing`
**Description**: Domain table for `fhir_account_billing` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `billing_account_key` | **Billing Account Key** | `BIGINT` | `PRIMARY KEY` | Billing account surrogate key |
| `source_billing_id` | **Source Billing Id** | `INT` | `NOT NULL` | Source natural billing ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `total_gross_charge_usd` | **Total Gross Charge Usd** | `NUMERIC(10,2)` | `NOT NULL` | Gross medical charge USD |
| `amount_paid_usd` | **Amount Paid Usd** | `NUMERIC(10,2)` | `NOT NULL` | Settled amount USD |
| `balance_usd` | **Balance Usd** | `NUMERIC(10,2)` | `NOT NULL` | Balance due USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Account status |

---

---

### Table: `fhir_appointment`
**Description**: Domain table for `fhir_appointment` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `appointment_key` | **Appointment Key** | `BIGINT` | `PRIMARY KEY` | Appointment surrogate key |
| `source_appointment_id` | **Source Appointment Id** | `INT` | `NOT NULL` | Source natural appointment ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `start_timestamp` | **Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Scheduled start timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Appointment status |

---

---

### Table: `fhir_audit_event`
**Description**: Domain table for `fhir_audit_event` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `audit_event_key` | **Audit Event Key** | `BIGINT` | `PRIMARY KEY` | Audit event surrogate key |
| `source_log_id` | **Source Log Id** | `INT` | `NOT NULL` | Source natural log ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Clinician user ID |
| `action_code` | **Action Code** | `VARCHAR(30)` | `NOT NULL` | Action performed |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `event_timestamp` | **Event Timestamp** | `TIMESTAMP` | `NOT NULL` | Event ISO timestamp |

---

---

### Table: `fhir_claim`
**Description**: Domain table for `fhir_claim` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_key` | **Claim Key** | `BIGINT` | `PRIMARY KEY` | Claim surrogate key |
| `source_claim_id` | **Source Claim Id** | `INT` | `NOT NULL` | Source natural claim ID |
| `billing_account_key` | **Billing Account Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_account_billing |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `payer_name` | **Payer Name** | `VARCHAR(80)` | `NOT NULL` | Health insurance payer |
| `total_claimed_usd` | **Total Claimed Usd** | `NUMERIC(10,2)` | `NOT NULL` | Claimed total USD |
| `total_covered_usd` | **Total Covered Usd** | `NUMERIC(10,2)` | `NOT NULL` | Approved covered USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Claim status |

---

---

### Table: `fhir_condition_diagnosis`
**Description**: Domain table for `fhir_condition_diagnosis` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `condition_key` | **Condition Key** | `BIGINT` | `PRIMARY KEY` | Condition surrogate key |
| `source_diagnosis_id` | **Source Diagnosis Id** | `INT` | `NOT NULL` | Source natural diagnosis ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `icd10_code` | **Icd10 Code** | `VARCHAR(20)` | `NOT NULL` | ICD-10 clinical code |
| `condition_display` | **Condition Display** | `VARCHAR(100)` | `NOT NULL` | Condition display title |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Condition onset date |

---

---

### Table: `fhir_encounter`
**Description**: Domain table for `fhir_encounter` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `encounter_key` | **Encounter Key** | `BIGINT` | `PRIMARY KEY` | Encounter surrogate key |
| `source_encounter_id` | **Source Encounter Id** | `INT` | `NOT NULL` | Source natural encounter ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `encounter_class` | **Encounter Class** | `VARCHAR(20)` | `NOT NULL` | Encounter classification |
| `period_start` | **Period Start** | `TIMESTAMP` | `NOT NULL` | Encounter period start |
| `period_end` | **Period End** | `TIMESTAMP` | `NULL` | Encounter period end |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | FHIR status code |

---

---

### Table: `fhir_family_member_history`
**Description**: Domain table for `fhir_family_member_history` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fam_hist_key` | **Fam Hist Key** | `BIGINT` | `PRIMARY KEY` | Family history surrogate key |
| `source_history_id` | **Source History Id** | `INT` | `NOT NULL` | Source natural history ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `condition_display` | **Condition Display** | `VARCHAR(100)` | `NOT NULL` | Condition display name |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Onset date |

---

---

### Table: `fhir_immunization`
**Description**: Domain table for `fhir_immunization` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `immunization_key` | **Immunization Key** | `BIGINT` | `PRIMARY KEY` | Immunization surrogate key |
| `source_immunization_id` | **Source Immunization Id** | `INT` | `NOT NULL` | Source natural immunization ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `vaccine_code` | **Vaccine Code** | `VARCHAR(20)` | `NOT NULL` | CVX vaccine code |
| `vaccine_display` | **Vaccine Display** | `VARCHAR(100)` | `NOT NULL` | Vaccine display title |
| `occurrence_date` | **Occurrence Date** | `DATE` | `NOT NULL` | Administered date |

---

---

### Table: `fhir_location_bed`
**Description**: Domain table for `fhir_location_bed` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `location_key` | **Location Key** | `BIGINT` | `PRIMARY KEY` | Location surrogate key |
| `source_allocation_id` | **Source Allocation Id** | `INT` | `NOT NULL` | Source natural allocation ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `room_name` | **Room Name** | `VARCHAR(20)` | `NOT NULL` | Room designation |
| `bed_name` | **Bed Name** | `VARCHAR(10)` | `NOT NULL` | Bed designation |
| `start_timestamp` | **Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Assignment start timestamp |

---

---

### Table: `fhir_medication_inventory`
**Description**: Domain table for `fhir_medication_inventory` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `med_inv_key` | **Med Inv Key** | `BIGINT` | `PRIMARY KEY` | Medication inventory surrogate key |
| `source_inventory_id` | **Source Inventory Id** | `INT` | `NOT NULL` | Source natural inventory ID |
| `ndc_code` | **Ndc Code** | `VARCHAR(20)` | `NOT NULL` | NDC code |
| `medication_display` | **Medication Display** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `stock_quantity` | **Stock Quantity** | `INT` | `NOT NULL` | Stock count |
| `reorder_threshold` | **Reorder Threshold** | `INT` | `NOT NULL` | Reorder threshold |

---

---

### Table: `fhir_medication_request`
**Description**: Domain table for `fhir_medication_request` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `med_req_key` | **Med Req Key** | `BIGINT` | `PRIMARY KEY` | Medication request surrogate key |
| `source_prescription_id` | **Source Prescription Id** | `INT` | `NOT NULL` | Source natural prescription ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `rxnorm_code` | **Rxnorm Code** | `VARCHAR(20)` | `NOT NULL` | RxNorm medication code |
| `medication_display` | **Medication Display** | `VARCHAR(100)` | `NOT NULL` | Medication display name |
| `dosage_instruction` | **Dosage Instruction** | `VARCHAR(100)` | `NOT NULL` | Dosage instruction text |
| `authored_on` | **Authored On** | `DATE` | `NOT NULL` | Prescription order date |

---

---

### Table: `fhir_observation_lab`
**Description**: Domain table for `fhir_observation_lab` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `obs_lab_key` | **Obs Lab Key** | `BIGINT` | `PRIMARY KEY` | Lab observation surrogate key |
| `source_lab_result_id` | **Source Lab Result Id** | `INT` | `NOT NULL` | Source natural lab result ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC lab code |
| `observation_display` | **Observation Display** | `VARCHAR(100)` | `NOT NULL` | Lab test display name |
| `value_quantity` | **Value Quantity** | `NUMERIC(10,2)` | `NOT NULL` | Lab reading value |
| `unit_code` | **Unit Code** | `VARCHAR(20)` | `NOT NULL` | Unit of measure |
| `issued_timestamp` | **Issued Timestamp** | `TIMESTAMP` | `NOT NULL` | Issue timestamp |

---

---

### Table: `fhir_observation_vitals`
**Description**: Domain table for `fhir_observation_vitals` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `obs_vital_key` | **Obs Vital Key** | `BIGINT` | `PRIMARY KEY` | Vital sign surrogate key |
| `source_vital_id` | **Source Vital Id** | `INT` | `NOT NULL` | Source natural vital ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `vital_display` | **Vital Display** | `VARCHAR(30)` | `NOT NULL` | Vital display category |
| `value_quantity` | **Value Quantity** | `NUMERIC(8,2)` | `NOT NULL` | Measurement reading |
| `unit_code` | **Unit Code** | `VARCHAR(20)` | `NOT NULL` | Unit code |
| `effective_timestamp` | **Effective Timestamp** | `TIMESTAMP` | `NOT NULL` | Observation timestamp |

---

---

### Table: `fhir_organization_dept`
**Description**: Domain table for `fhir_organization_dept` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dept_key` | **Dept Key** | `BIGINT` | `PRIMARY KEY` | Organization surrogate key |
| `source_department_id` | **Source Department Id** | `INT` | `NOT NULL` | Source natural department ID |
| `dept_name` | **Dept Name** | `VARCHAR(60)` | `NOT NULL` | Department designation |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Hospital facility complex |

---

---

### Table: `fhir_patient`
**Description**: Domain table for `fhir_patient` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fhir_patient_key` | **Fhir Patient Key** | `BIGINT` | `PRIMARY KEY` | FHIR patient surrogate key |
| `source_patient_id` | **Source Patient Id** | `INT` | `NOT NULL` | Source natural patient ID |
| `mrn_identifier` | **Mrn Identifier** | `VARCHAR(30)` | `NOT NULL` | Medical Record Number MRN |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full patient name |
| `gender_code` | **Gender Code** | `VARCHAR(1)` | `NOT NULL` | Administrative gender (M/F/U) |
| `birth_date` | **Birth Date** | `DATE` | `NOT NULL` | Patient date of birth |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/province code |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | FHIR active record flag |

---

---

### Table: `fhir_patient_contact`
**Description**: Domain table for `fhir_patient_contact` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `contact_key` | **Contact Key** | `BIGINT` | `PRIMARY KEY` | Patient contact surrogate key |
| `source_contact_id` | **Source Contact Id** | `INT` | `NOT NULL` | Source natural contact ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Contact full name |
| `relationship_code` | **Relationship Code** | `VARCHAR(30)` | `NOT NULL` | Relationship type |
| `telecom_phone` | **Telecom Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |

---

---

### Table: `fhir_practitioner`
**Description**: Domain table for `fhir_practitioner` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `PRIMARY KEY` | Practitioner surrogate key |
| `source_physician_id` | **Source Physician Id** | `INT` | `NOT NULL` | Source natural physician ID |
| `npi_number` | **Npi Number** | `VARCHAR(10)` | `NOT NULL` | National Provider Identifier NPI |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Practitioner full name |
| `specialty_name` | **Specialty Name** | `VARCHAR(60)` | `NOT NULL` | Medical specialty |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |

---

---

### Table: `fhir_practitioner_role`
**Description**: Domain table for `fhir_practitioner_role` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `role_key` | **Role Key** | `BIGINT` | `PRIMARY KEY` | Practitioner role surrogate key |
| `source_staff_id` | **Source Staff Id** | `INT` | `NOT NULL` | Source natural staff ID |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `role_code` | **Role Code** | `VARCHAR(50)` | `NOT NULL` | Staff role designation |

---

---

### Table: `fhir_procedure`
**Description**: Domain table for `fhir_procedure` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `procedure_key` | **Procedure Key** | `BIGINT` | `PRIMARY KEY` | Procedure surrogate key |
| `source_procedure_id` | **Source Procedure Id** | `INT` | `NOT NULL` | Source natural procedure ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `cpt_code` | **Cpt Code** | `VARCHAR(20)` | `NOT NULL` | CPT procedure code |
| `procedure_display` | **Procedure Display** | `VARCHAR(100)` | `NOT NULL` | Procedure display title |
| `performed_date` | **Performed Date** | `DATE` | `NOT NULL` | Performed date |

---

---

### Table: `fhir_service_request`
**Description**: Domain table for `fhir_service_request` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `service_req_key` | **Service Req Key** | `BIGINT` | `PRIMARY KEY` | Service request surrogate key |
| `source_lab_order_id` | **Source Lab Order Id** | `INT` | `NOT NULL` | Source natural lab order ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC concept code |
| `service_display` | **Service Display** | `VARCHAR(100)` | `NOT NULL` | Service display title |
| `authored_on` | **Authored On** | `TIMESTAMP` | `NOT NULL` | Order timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Status code |

---

---

### Table: `dim_patient_demographics`
**Description**: Domain table for `dim_patient_demographics` in `Hospital_EMR_Clinical_Patient_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `patient_key` | **Patient Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for patient dimension |
| `source_patient_id` | **Source Patient Id** | `INT` | `NOT NULL` | Natural patient ID from source |
| `mrn_number` | **Mrn Number** | `VARCHAR(20)` | `NOT NULL` | Medical Record Number |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Patient full name |
| `date_of_birth` | **Date Of Birth** | `DATE` | `NOT NULL` | Date of birth |
| `gender` | **Gender** | `VARCHAR(15)` | `NOT NULL` | MALE, FEMALE, OTHER |
| `blood_type` | **Blood Type** | `VARCHAR(5)` | `NOT NULL` | ABO Rh blood group |
| `primary_phone` | **Primary Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Email contact |
| `address_street` | **Address Street** | `VARCHAR(100)` | `NOT NULL` | Street address |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City name |
| `state_code` | **State Code** | `VARCHAR(2)` | `NOT NULL` | State postal code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP code |
| `insurance_provider_name` | **Insurance Provider Name** | `VARCHAR(80)` | `NOT NULL` | Health insurance carrier |
| `insurance_policy_number` | **Insurance Policy Number** | `VARCHAR(30)` | `NOT NULL` | Insurance policy ID |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current_record` | **Is Current Record** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Patient chart notes |

---

---

### Table: `dim_physician_provider`
**Description**: Domain table for `dim_physician_provider` in `Hospital_EMR_Clinical_Patient_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `physician_key` | **Physician Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for physician dimension |
| `source_physician_id` | **Source Physician Id** | `INT` | `NOT NULL` | Natural physician ID from source |
| `npi_number` | **Npi Number** | `VARCHAR(15)` | `NOT NULL` | National Provider Identifier NPI |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Physician full name |
| `medical_specialty` | **Medical Specialty** | `VARCHAR(50)` | `NOT NULL` | CARDIOLOGY, SURGERY, INTERNAL_MED |
| `department_name` | **Department Name** | `VARCHAR(50)` | `NOT NULL` | Hospital department ward |
| `medical_license_number` | **Medical License Number** | `VARCHAR(20)` | `NOT NULL` | State medical license ID |
| `years_of_practice` | **Years Of Practice** | `INT` | `NOT NULL` | Years practicing medicine |
| `office_phone` | **Office Phone** | `VARCHAR(20)` | `NOT NULL` | Clinic office telephone |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Professional medical email |
| `hospital_privilege_status` | **Hospital Privilege Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE, CONSULTING, ACTIVE |
| `medical_school_graduated` | **Medical School Graduated** | `VARCHAR(80)` | `NOT NULL` | Medical university school |
| `is_board_certified` | **Is Board Certified** | `BOOLEAN` | `NOT NULL` | Board certified specialist flag |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | Current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Physician credentialing comments |

---

---

### Table: `fact_hospital_admissions`
**Description**: Domain table for `fact_hospital_admissions` in `Hospital_EMR_Clinical_Patient_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `admission_fact_key` | **Admission Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for admission fact |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_patient_demographics |
| `attending_physician_key` | **Attending Physician Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_physician_provider |
| `admission_timestamp` | **Admission Timestamp** | `TIMESTAMP` | `NOT NULL` | Admission timestamp key |
| `discharge_timestamp` | **Discharge Timestamp** | `TIMESTAMP` | `NOT NULL` | Discharge timestamp key |
| `length_of_stay_days` | **Length Of Stay Days** | `INT` | `NOT NULL` | Inpatient stay days |
| `admission_type` | **Admission Type** | `VARCHAR(30)` | `NOT NULL` | Admission classification |
| `primary_diagnosis_code` | **Primary Diagnosis Code** | `VARCHAR(15)` | `NOT NULL` | ICD-10 primary code |
| `discharge_disposition` | **Discharge Disposition** | `VARCHAR(40)` | `NOT NULL` | Discharge disposition text |
| `total_billed_usd` | **Total Billed Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total billed USD |
| `insurance_covered_usd` | **Insurance Covered Usd** | `NUMERIC(12,2)` | `NOT NULL` | Insurance covered USD |
| `patient_copay_usd` | **Patient Copay Usd** | `NUMERIC(10,2)` | `NOT NULL` | Patient copay USD |
| `readmission_30day_flag` | **Readmission 30day Flag** | `BOOLEAN` | `NOT NULL` | 30-day readmit flag |
| `emergency_flag` | **Emergency Flag** | `BOOLEAN` | `NOT NULL` | Emergency flag |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Admission status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_lab_test_results`
**Description**: Domain table for `fact_lab_test_results` in `Hospital_EMR_Clinical_Patient_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_fact_key` | **Lab Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for lab fact |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_patient_demographics |
| `ordering_physician_key` | **Ordering Physician Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_physician_provider |
| `order_timestamp` | **Order Timestamp** | `TIMESTAMP` | `NOT NULL` | Order timestamp |
| `result_timestamp` | **Result Timestamp** | `TIMESTAMP` | `NOT NULL` | Result timestamp |
| `test_code` | **Test Code** | `VARCHAR(20)` | `NOT NULL` | LOINC code |
| `test_name` | **Test Name** | `VARCHAR(80)` | `NOT NULL` | Test name |
| `test_result_value` | **Test Result Value** | `NUMERIC(10,2)` | `NOT NULL` | Result value numeric |
| `result_unit` | **Result Unit** | `VARCHAR(20)` | `NOT NULL` | Unit string |
| `is_abnormal_flag` | **Is Abnormal Flag** | `BOOLEAN` | `NOT NULL` | Abnormal result flag |
| `test_cost_usd` | **Test Cost Usd** | `NUMERIC(8,2)` | `NOT NULL` | Test cost USD |
| `turnaround_minutes` | **Turnaround Minutes** | `INT` | `NOT NULL` | Lab turnaround time in minutes |
| `lab_status` | **Lab Status** | `VARCHAR(20)` | `NOT NULL` | Lab status text |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_medication_administrations`
**Description**: Domain table for `fact_medication_administrations` in `Hospital_EMR_Clinical_Patient_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rx_fact_key` | **Rx Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for medication fact |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_patient_demographics |
| `prescribing_physician_key` | **Prescribing Physician Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_physician_provider |
| `drug_code_ndc` | **Drug Code Ndc** | `VARCHAR(20)` | `NOT NULL` | NDC code |
| `medication_name` | **Medication Name** | `VARCHAR(80)` | `NOT NULL` | Medication name |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Rx start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Rx end date |
| `duration_days` | **Duration Days** | `INT` | `NOT NULL` | Duration in days |
| `dosage_mg` | **Dosage Mg** | `NUMERIC(8,2)` | `NOT NULL` | Dose mg |
| `dispensed_quantity` | **Dispensed Quantity** | `INT` | `NOT NULL` | Dispensed unit count |
| `pharmacy_cost_usd` | **Pharmacy Cost Usd** | `NUMERIC(8,2)` | `NOT NULL` | Cost USD |
| `is_controlled_flag` | **Is Controlled Flag** | `BOOLEAN` | `NOT NULL` | Controlled substance flag |
| `prescription_status` | **Prescription Status** | `VARCHAR(25)` | `NOT NULL` | Rx status text |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_clinical_trial`
**Description**: Domain table for `dim_clinical_trial` in `Pharmaceutical_Clinical_RND_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trial_key` | **Trial Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_trial_id` | **Source Trial Id** | `INT` | `NOT NULL` | Natural ID |
| `compound_key` | **Compound Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_compound |
| `nct_number` | **Nct Number** | `VARCHAR(15)` | `NOT NULL` | NCT ID |

---

---

### Table: `dim_compound`
**Description**: Domain table for `dim_compound` in `Pharmaceutical_Clinical_RND_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `compound_key` | **Compound Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_compound_id` | **Source Compound Id** | `INT` | `NOT NULL` | Natural ID |
| `molecule_code` | **Molecule Code** | `VARCHAR(30)` | `NOT NULL` | Code |

---

---

### Table: `fact_adverse_events`
**Description**: Domain table for `fact_adverse_events` in `Pharmaceutical_Clinical_RND_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_key` | **Event Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `trial_key` | **Trial Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_clinical_trial |
| `severity` | **Severity** | `VARCHAR(15)` | `NOT NULL` | Severity |

---

---

### Table: `dim_device`
**Description**: Domain table for `dim_device` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `device_key` | **Device Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_device_id` | **Source Device Id** | `INT` | `NOT NULL` | Natural ID |
| `model_name` | **Model Name** | `VARCHAR(50)` | `NOT NULL` | Model name |

---

---

### Table: `dim_user`
**Description**: Domain table for `dim_user` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_key` | **User Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_user_id` | **Source User Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_telemetry_reads`
**Description**: Domain table for `fact_telemetry_reads` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `telemetry_key` | **Telemetry Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `device_key` | **Device Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_device |
| `bpm_value` | **Bpm Value** | `INT` | `NOT NULL` | BPM |

---

---

### Table: `fact_workout_summary`
**Description**: Domain table for `fact_workout_summary` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `workout_key` | **Workout Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `user_key` | **User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_user |
| `calories_burned` | **Calories Burned** | `INT` | `NOT NULL` | Calories burned |

---

---

### Table: `dim_categories`
**Description**: Domain table for `dim_categories` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_cat_key` | **Dim Cat Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_category_id` | **Source Category Id** | `INT` | `NOT NULL` | Natural source ID |
| `category_name` | **Category Name** | `VARCHAR(50)` | `NOT NULL` | Category name |
| `parent_category_name` | **Parent Category Name** | `VARCHAR(50)` | `NULL` | Parent category name |

---

---

### Table: `dim_customer_addresses`
**Description**: Domain table for `dim_customer_addresses` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_addr_key` | **Dim Addr Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `address_type` | **Address Type** | `VARCHAR(20)` | `NOT NULL` | Address classification |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `state_province` | **State Province** | `VARCHAR(50)` | `NOT NULL` | State/Province |
| `country_code_iso2` | **Country Code Iso2** | `VARCHAR(2)` | `NOT NULL` | Country code |

---

---

### Table: `dim_customers`
**Description**: Domain table for `dim_customers` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_cust_key` | **Dim Cust Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Natural source ID |
| `customer_code` | **Customer Code** | `VARCHAR(36)` | `NOT NULL` | Tracking code |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full customer name |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Email contact |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NULL` | Phone number |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | Status code |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active indicator |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | DW record timestamp |

---

---

### Table: `dim_product_attributes`
**Description**: Domain table for `dim_product_attributes` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_attr_key` | **Dim Attr Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `attribute_name` | **Attribute Name** | `VARCHAR(50)` | `NOT NULL` | Attribute name |
| `attribute_value` | **Attribute Value** | `VARCHAR(50)` | `NOT NULL` | Attribute value |

---

---

### Table: `dim_products`
**Description**: Domain table for `dim_products` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_prod_key` | **Dim Prod Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_product_id` | **Source Product Id** | `INT` | `NOT NULL` | Natural source ID |
| `sku` | **Sku** | `VARCHAR(30)` | `NOT NULL` | Product SKU |
| `product_name` | **Product Name** | `VARCHAR(100)` | `NOT NULL` | Product title |
| `category_key` | **Category Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_categories |
| `supplier_key` | **Supplier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_suppliers |
| `unit_price_usd` | **Unit Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Standard unit price |

---

---

### Table: `dim_promotions`
**Description**: Domain table for `dim_promotions` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_promo_key` | **Dim Promo Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_promo_id` | **Source Promo Id** | `INT` | `NOT NULL` | Natural source ID |
| `promo_code` | **Promo Code** | `VARCHAR(20)` | `NOT NULL` | Promo code |
| `discount_percent` | **Discount Percent** | `NUMERIC(5,2)` | `NOT NULL` | Discount rate |

---

---

### Table: `dim_suppliers`
**Description**: Domain table for `dim_suppliers` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_supp_key` | **Dim Supp Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_supplier_id` | **Source Supplier Id** | `INT` | `NOT NULL` | Natural source ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | Supplier company name |
| `country_code_iso2` | **Country Code Iso2** | `VARCHAR(2)` | `NOT NULL` | ISO country code |

---

---

### Table: `dim_warehouses`
**Description**: Domain table for `dim_warehouses` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_wh_key` | **Dim Wh Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_warehouse_id` | **Source Warehouse Id** | `INT` | `NOT NULL` | Natural source ID |
| `warehouse_code` | **Warehouse Code** | `VARCHAR(20)` | `NOT NULL` | Warehouse code |
| `warehouse_name` | **Warehouse Name** | `VARCHAR(80)` | `NOT NULL` | Warehouse name |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Facility city |

---

---

### Table: `fact_audit_events`
**Description**: Domain table for `fact_audit_events` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_audit_key` | **Fact Audit Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | User string |
| `action_name` | **Action Name** | `VARCHAR(50)` | `NOT NULL` | Action performed |
| `target_entity` | **Target Entity** | `VARCHAR(50)` | `NOT NULL` | Target entity |

---

---

### Table: `fact_inventory_snapshot`
**Description**: Domain table for `fact_inventory_snapshot` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_inv_key` | **Fact Inv Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouses |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Physical stock count |
| `reserved_quantity` | **Reserved Quantity** | `INT` | `NOT NULL` | Reserved stock count |

---

---

### Table: `fact_invoices`
**Description**: Domain table for `fact_invoices` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_invoice_key` | **Fact Invoice Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `invoice_number` | **Invoice Number** | `VARCHAR(30)` | `NOT NULL` | Invoice document number |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Billed total USD |

---

---

### Table: `fact_order_line_items`
**Description**: Domain table for `fact_order_line_items` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_item_key` | **Fact Item Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `unit_price_usd` | **Unit Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Sold price USD |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Unit count |
| `subtotal_usd` | **Subtotal Usd** | `NUMERIC(12,2)` | `NOT NULL` | Subtotal USD |

---

---

### Table: `fact_orders`
**Description**: Domain table for `fact_orders` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_order_id` | **Source Order Id** | `INT` | `NOT NULL` | Natural source ID |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `order_number` | **Order Number** | `VARCHAR(36)` | `NOT NULL` | Order number |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order date |
| `order_status` | **Order Status** | `VARCHAR(20)` | `NOT NULL` | Order status |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Gross order total USD |

---

---

### Table: `fact_payments`
**Description**: Domain table for `fact_payments` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_payment_key` | **Fact Payment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | Method name |
| `amount_usd` | **Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Payment amount USD |

---

---

### Table: `fact_product_reviews`
**Description**: Domain table for `fact_product_reviews` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_review_key` | **Fact Review Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `rating_score` | **Rating Score** | `INT` | `NOT NULL` | Rating score 1-5 |

---

---

### Table: `fact_return_requests`
**Description**: Domain table for `fact_return_requests` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_return_key` | **Fact Return Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `return_status` | **Return Status** | `VARCHAR(20)` | `NOT NULL` | Return status |

---

---

### Table: `fact_shipments`
**Description**: Domain table for `fact_shipments` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_shipment_key` | **Fact Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `carrier_name` | **Carrier Name** | `VARCHAR(30)` | `NOT NULL` | Carrier name |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Tracking code |
| `shipment_status` | **Shipment Status** | `VARCHAR(20)` | `NOT NULL` | Shipment status |

---

---

### Table: `fact_shopping_carts`
**Description**: Domain table for `fact_shopping_carts` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_cart_key` | **Fact Cart Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |

---