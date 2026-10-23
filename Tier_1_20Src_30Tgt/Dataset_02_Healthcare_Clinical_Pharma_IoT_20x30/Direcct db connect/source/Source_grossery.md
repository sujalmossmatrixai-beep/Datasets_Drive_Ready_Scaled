# Business Data Glossary - Dataset_02_Healthcare_Clinical_Pharma_IoT_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_02_Healthcare_Clinical_Pharma_IoT_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_02_Healthcare_Clinical_Pharma_IoT_20x30
- **Component**: Source Database Schema (Dataset_02_Healthcare_Clinical_Pharma_IoT_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Healthcare Hospital, EMR Clinical, Pharma R&D & Wearable Health IoT
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `src_doctor_physicians`
**Description**: Domain table for `src_doctor_physicians` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `physician_id` | **Physician Id** | `INT` | `PRIMARY KEY` | Physician primary key ID |
| `npi_number` | **Npi Number** | `VARCHAR(10)` | `NOT NULL` | National Provider Identifier NPI |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Physician first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Physician last name |
| `specialty` | **Specialty** | `VARCHAR(60)` | `NOT NULL` | Medical specialty field |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Direct telephone contact |

---

---

### Table: `src_ehr_audit_logs`
**Description**: Domain table for `src_ehr_audit_logs` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Clinician user ID |
| `action_type` | **Action Type** | `VARCHAR(30)` | `NOT NULL` | READ/WRITE/DELETE |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `ip_address` | **Ip Address** | `VARCHAR(45)` | `NOT NULL` | Workstation IP |
| `log_timestamp` | **Log Timestamp** | `TIMESTAMP` | `NOT NULL` | Audit timestamp |

---

---

### Table: `src_emergency_contacts`
**Description**: Domain table for `src_emergency_contacts` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `contact_id` | **Contact Id** | `INT` | `PRIMARY KEY` | Emergency contact primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Contact person full name |
| `relationship` | **Relationship** | `VARCHAR(30)` | `NOT NULL` | SPOUSE/PARENT/SIBLING |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Emergency phone number |

---

---

### Table: `src_hospital_departments`
**Description**: Domain table for `src_hospital_departments` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `department_id` | **Department Id** | `INT` | `PRIMARY KEY` | Department primary key ID |
| `dept_name` | **Dept Name** | `VARCHAR(60)` | `NOT NULL` | Clinical department designation |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Hospital facility complex |
| `building_location` | **Building Location** | `VARCHAR(40)` | `NOT NULL` | Building or floor wing |
| `phone_extension` | **Phone Extension** | `VARCHAR(10)` | `NOT NULL` | Internal phone extension |

---

---

### Table: `src_hospital_encounters`
**Description**: Domain table for `src_hospital_encounters` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `encounter_id` | **Encounter Id** | `INT` | `PRIMARY KEY` | Encounter primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `attending_physician_id` | **Attending Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `encounter_class` | **Encounter Class** | `VARCHAR(20)` | `NOT NULL` | INPATIENT/OUTPATIENT/EMERGENCY |
| `admission_date` | **Admission Date** | `TIMESTAMP` | `NOT NULL` | Admission timestamp |
| `discharge_date` | **Discharge Date** | `TIMESTAMP` | `NULL` | Discharge timestamp |
| `encounter_status` | **Encounter Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/FINISHED/CANCELLED |

---

---

### Table: `src_hospital_staff_roster`
**Description**: Domain table for `src_hospital_staff_roster` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `staff_id` | **Staff Id** | `INT` | `PRIMARY KEY` | Staff primary key ID |
| `employee_number` | **Employee Number** | `VARCHAR(20)` | `NOT NULL` | Staff badge ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Staff full name |
| `role_title` | **Role Title** | `VARCHAR(50)` | `NOT NULL` | NURSE/TECHNICIAN/ADMIN |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `phone_extension` | **Phone Extension** | `VARCHAR(10)` | `NOT NULL` | Internal phone extension |

---

---

### Table: `src_insurance_claims`
**Description**: Domain table for `src_insurance_claims` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_id` | **Claim Id** | `INT` | `PRIMARY KEY` | Insurance claim primary key ID |
| `billing_id` | **Billing Id** | `INT` | `FOREIGN KEY` | FK to src_patient_billing |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `payer_name` | **Payer Name** | `VARCHAR(80)` | `NOT NULL` | Health insurance provider |
| `claim_amount` | **Claim Amount** | `DECIMAL(10,2)` | `NOT NULL` | Claimed reimbursement amount |
| `covered_amount` | **Covered Amount** | `DECIMAL(10,2)` | `NOT NULL` | Approved covered amount |
| `claim_status` | **Claim Status** | `VARCHAR(15)` | `NOT NULL` | SUBMITTED/PAID/DENIED |
| `submission_date` | **Submission Date** | `DATE` | `NOT NULL` | Payer filing date |

---

---

### Table: `src_lab_results`
**Description**: Domain table for `src_lab_results` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_result_id` | **Lab Result Id** | `INT` | `PRIMARY KEY` | Lab result primary key ID |
| `lab_order_id` | **Lab Order Id** | `INT` | `FOREIGN KEY` | FK to src_lab_test_orders |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `result_value` | **Result Value** | `DECIMAL(10,2)` | `NOT NULL` | Quantitative lab measurement |
| `unit_of_measure` | **Unit Of Measure** | `VARCHAR(20)` | `NOT NULL` | Measurement unit (mg/dL) |
| `reference_range` | **Reference Range** | `VARCHAR(30)` | `NOT NULL` | Normal reference range |
| `result_status` | **Result Status** | `VARCHAR(15)` | `NOT NULL` | FINAL/PRELIMINARY |
| `result_date` | **Result Date** | `TIMESTAMP` | `NOT NULL` | Result timestamp |

---

---

### Table: `src_lab_test_orders`
**Description**: Domain table for `src_lab_test_orders` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_order_id` | **Lab Order Id** | `INT` | `PRIMARY KEY` | Lab order primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `ordering_physician_id` | **Ordering Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `loinc_code` | **Loinc Code** | `VARCHAR(20)` | `NOT NULL` | LOINC lab test concept code |
| `test_name` | **Test Name** | `VARCHAR(100)` | `NOT NULL` | Lab panel test title |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order timestamp |
| `order_status` | **Order Status** | `VARCHAR(15)` | `NOT NULL` | ORDERED/COMPLETED/CANCELLED |

---

---

### Table: `src_medical_diagnoses`
**Description**: Domain table for `src_medical_diagnoses` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `diagnosis_id` | **Diagnosis Id** | `INT` | `PRIMARY KEY` | Diagnosis primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `icd10_code` | **Icd10 Code** | `VARCHAR(20)` | `NOT NULL` | ICD-10 clinical diagnosis code |
| `diagnosis_name` | **Diagnosis Name** | `VARCHAR(100)` | `NOT NULL` | Diagnosis description |
| `diagnosis_date` | **Diagnosis Date** | `DATE` | `NOT NULL` | Onset or diagnosis date |

---

---

### Table: `src_medical_history`
**Description**: Domain table for `src_medical_history` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `history_id` | **History Id** | `INT` | `PRIMARY KEY` | Medical history primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `condition_name` | **Condition Name** | `VARCHAR(100)` | `NOT NULL` | Pre-existing medical condition |
| `onset_date` | **Onset Date** | `DATE` | `NOT NULL` | Condition onset date |
| `condition_status` | **Condition Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/RESOLVED |

---

---

### Table: `src_medical_prescriptions`
**Description**: Domain table for `src_medical_prescriptions` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `prescription_id` | **Prescription Id** | `INT` | `PRIMARY KEY` | Prescription primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `prescribing_physician_id` | **Prescribing Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `rxnorm_code` | **Rxnorm Code** | `VARCHAR(20)` | `NOT NULL` | RxNorm medication code |
| `medication_name` | **Medication Name** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `dosage_instructions` | **Dosage Instructions** | `VARCHAR(100)` | `NOT NULL` | Dosage and frequency |
| `prescribed_date` | **Prescribed Date** | `DATE` | `NOT NULL` | Prescription order date |

---

---

### Table: `src_patient_appointments`
**Description**: Domain table for `src_patient_appointments` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `appointment_id` | **Appointment Id** | `INT` | `PRIMARY KEY` | Appointment primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `physician_id` | **Physician Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_departments |
| `appointment_time` | **Appointment Time** | `TIMESTAMP` | `NOT NULL` | Scheduled appointment timestamp |
| `appointment_status` | **Appointment Status** | `VARCHAR(15)` | `NOT NULL` | SCHEDULED/COMPLETED/NO_SHOW |

---

---

### Table: `src_patient_billing`
**Description**: Domain table for `src_patient_billing` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `billing_id` | **Billing Id** | `INT` | `PRIMARY KEY` | Patient billing primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `total_charge_amount` | **Total Charge Amount** | `DECIMAL(10,2)` | `NOT NULL` | Gross medical charge |
| `paid_amount` | **Paid Amount** | `DECIMAL(10,2)` | `NOT NULL` | Settled payment amount |
| `balance_due` | **Balance Due** | `DECIMAL(10,2)` | `NOT NULL` | Outstanding invoice balance |
| `billing_date` | **Billing Date** | `DATE` | `NOT NULL` | Statement generation date |
| `billing_status` | **Billing Status** | `VARCHAR(15)` | `NOT NULL` | BILLED/PAID/OVERDUE |

---

---

### Table: `src_patient_immunizations`
**Description**: Domain table for `src_patient_immunizations` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `immunization_id` | **Immunization Id** | `INT` | `PRIMARY KEY` | Immunization primary key ID |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `vaccine_code` | **Vaccine Code** | `VARCHAR(20)` | `NOT NULL` | CVX vaccine code |
| `vaccine_name` | **Vaccine Name** | `VARCHAR(100)` | `NOT NULL` | Vaccine trade name |
| `administered_date` | **Administered Date** | `DATE` | `NOT NULL` | Vaccination date |
| `dose_number` | **Dose Number** | `INT` | `NOT NULL` | Dose sequence number |

---

---

### Table: `src_patient_master`
**Description**: Domain table for `src_patient_master` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `patient_id` | **Patient Id** | `INT` | `PRIMARY KEY` | Patient primary key ID |
| `mrn_number` | **Mrn Number** | `VARCHAR(30)` | `NOT NULL` | Medical Record Number MRN |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Patient given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Patient family last name |
| `gender_code` | **Gender Code** | `VARCHAR(1)` | `NOT NULL` | Administrative gender (M/F/U) |
| `date_of_birth` | **Date Of Birth** | `DATE` | `NOT NULL` | Patient birth date |
| `phone_contact` | **Phone Contact** | `VARCHAR(20)` | `NOT NULL` | Primary telephone contact |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/Province code |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | EHR entry timestamp |

---

---

### Table: `src_patient_vitals_signs`
**Description**: Domain table for `src_patient_vitals_signs` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vital_id` | **Vital Id** | `INT` | `PRIMARY KEY` | Vital sign primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `vital_type` | **Vital Type** | `VARCHAR(30)` | `NOT NULL` | HEART_RATE/BP_SYSTOLIC/TEMP |
| `numeric_value` | **Numeric Value** | `DECIMAL(8,2)` | `NOT NULL` | Measurement reading |
| `unit_of_measure` | **Unit Of Measure** | `VARCHAR(20)` | `NOT NULL` | Measurement unit |
| `recorded_time` | **Recorded Time** | `TIMESTAMP` | `NOT NULL` | Observation timestamp |

---

---

### Table: `src_pharmacy_inventory`
**Description**: Domain table for `src_pharmacy_inventory` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_id` | **Inventory Id** | `INT` | `PRIMARY KEY` | Pharmacy stock primary key ID |
| `ndc_code` | **Ndc Code** | `VARCHAR(20)` | `NOT NULL` | National Drug Code NDC |
| `medication_name` | **Medication Name** | `VARCHAR(100)` | `NOT NULL` | Medication trade name |
| `quantity_in_stock` | **Quantity In Stock** | `INT` | `NOT NULL` | Physical stock on hand |
| `reorder_level` | **Reorder Level** | `INT` | `NOT NULL` | Reorder threshold count |

---

---

### Table: `src_room_bed_allocations`
**Description**: Domain table for `src_room_bed_allocations` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `allocation_id` | **Allocation Id** | `INT` | `PRIMARY KEY` | Bed allocation primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `room_number` | **Room Number** | `VARCHAR(20)` | `NOT NULL` | Hospital room number |
| `bed_number` | **Bed Number** | `VARCHAR(10)` | `NOT NULL` | Bed location designation |
| `start_time` | **Start Time** | `TIMESTAMP` | `NOT NULL` | Bed assignment start |
| `end_time` | **End Time** | `TIMESTAMP` | `NULL` | Bed discharge time |

---

---

### Table: `src_surgical_procedures`
**Description**: Domain table for `src_surgical_procedures` in `Healthcare_Hospital_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `procedure_id` | **Procedure Id** | `INT` | `PRIMARY KEY` | Procedure primary key ID |
| `encounter_id` | **Encounter Id** | `INT` | `FOREIGN KEY` | FK to src_hospital_encounters |
| `patient_id` | **Patient Id** | `INT` | `FOREIGN KEY` | FK to src_patient_master |
| `surgeon_id` | **Surgeon Id** | `INT` | `FOREIGN KEY` | FK to src_doctor_physicians |
| `cpt_code` | **Cpt Code** | `VARCHAR(20)` | `NOT NULL` | CPT procedure medical code |
| `procedure_name` | **Procedure Name** | `VARCHAR(100)` | `NOT NULL` | Surgical procedure title |
| `procedure_date` | **Procedure Date** | `DATE` | `NOT NULL` | Surgery execution date |

---