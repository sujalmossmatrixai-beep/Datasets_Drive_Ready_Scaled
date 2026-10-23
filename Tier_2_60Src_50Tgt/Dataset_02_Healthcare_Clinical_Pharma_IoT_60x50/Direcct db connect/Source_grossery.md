# Business Data Glossary - Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50
- **Component**: Source Database Schema (Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_source)
- **Tier Specification**: Tier 2: 60 Source Tables, 50 Target Tables
- **Total Source Tables**: 60
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

---

### Table: `tbl_lab_test_orders`
**Description**: Domain table for `tbl_lab_test_orders` in `Hospital_EMR_Clinical_Patient_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lab_order_id` | **Lab Order Id** | `INT` | `PRIMARY KEY` | Lab order primary key ID |
| `admission_id` | **Admission Id** | `INT` | `FOREIGN KEY` | FK to tbl_patient_admissions |
| `patient_id` | **Patient Id** | `INT` | `NOT NULL` | Patient ID |
| `ordering_doctor_id` | **Ordering Doctor Id** | `INT` | `NOT NULL` | Physician orderer ID |
| `test_code` | **Test Code** | `VARCHAR(20)` | `NOT NULL` | LOINC diagnostic lab test code |
| `test_name` | **Test Name** | `VARCHAR(80)` | `NOT NULL` | Diagnostic test panel name |
| `lab_specimen_type` | **Lab Specimen Type** | `VARCHAR(30)` | `NOT NULL` | BLOOD, URINE, CSF, SPUTUM, TISSUE |
| `order_timestamp` | **Order Timestamp** | `TIMESTAMP` | `NOT NULL` | Doctor lab order placement time |
| `collection_timestamp` | **Collection Timestamp** | `TIMESTAMP` | `NOT NULL` | Specimen phlebotomy draw time |
| `result_timestamp` | **Result Timestamp** | `TIMESTAMP` | `NOT NULL` | Lab report validation time |
| `test_result_value` | **Test Result Value** | `DECIMAL(10,2)` | `NOT NULL` | Lab quantitative result value |
| `result_unit` | **Result Unit** | `VARCHAR(20)` | `NOT NULL` | Measurement unit (g/dL, mg/dL) |
| `reference_range_normal` | **Reference Range Normal** | `VARCHAR(30)` | `NOT NULL` | Clinical reference standard range |
| `is_abnormal_flag` | **Is Abnormal Flag** | `BOOLEAN` | `NOT NULL` | High/Low flag alert |
| `test_cost_usd` | **Test Cost Usd** | `DECIMAL(8,2)` | `NOT NULL` | Diagnostic test fee USD |
| `lab_technician_id` | **Lab Technician Id** | `INT` | `NOT NULL` | Performing technologist ID |
| `performing_lab_code` | **Performing Lab Code** | `VARCHAR(20)` | `NOT NULL` | Lab facility code |
| `lab_status` | **Lab Status** | `VARCHAR(20)` | `NOT NULL` | COMPLETED, IN_PROGRESS, CANCELLED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | FINAL, PRELIMINARY, AMENDED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Pathologist result comments |

---

---

### Table: `tbl_medication_prescriptions`
**Description**: Domain table for `tbl_medication_prescriptions` in `Hospital_EMR_Clinical_Patient_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `prescription_id` | **Prescription Id** | `INT` | `PRIMARY KEY` | Rx primary key ID |
| `admission_id` | **Admission Id** | `INT` | `FOREIGN KEY` | FK to tbl_patient_admissions |
| `patient_id` | **Patient Id** | `INT` | `NOT NULL` | Patient ID |
| `prescribing_doctor_id` | **Prescribing Doctor Id** | `INT` | `NOT NULL` | Prescribing doctor ID |
| `drug_code_ndc` | **Drug Code Ndc** | `VARCHAR(20)` | `NOT NULL` | National Drug Code NDC |
| `medication_name` | **Medication Name** | `VARCHAR(80)` | `NOT NULL` | Pharmaceutical brand/generic name |
| `dosage_mg` | **Dosage Mg** | `DECIMAL(8,2)` | `NOT NULL` | Single administration dose mg |
| `administration_route` | **Administration Route** | `VARCHAR(30)` | `NOT NULL` | ORAL, IV_PUSH, SUBQ, INHALATION |
| `frequency_schedule` | **Frequency Schedule** | `VARCHAR(30)` | `NOT NULL` | ONCE_DAILY, BID_TWICE, TID_THREE |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Medication start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Medication course end date |
| `dispensed_quantity` | **Dispensed Quantity** | `INT` | `NOT NULL` | Total pill/unit count dispensed |
| `refills_allowed` | **Refills Allowed** | `INT` | `NOT NULL` | Authorized prescription refills |
| `pharmacist_id` | **Pharmacist Id** | `INT` | `NOT NULL` | Dispensing pharmacist ID |
| `pharmacy_cost_usd` | **Pharmacy Cost Usd** | `DECIMAL(8,2)` | `NOT NULL` | Medication billing cost USD |
| `is_controlled_substance` | **Is Controlled Substance** | `BOOLEAN` | `NOT NULL` | DEA Schedule controlled drug flag |
| `allergy_checked_flag` | **Allergy Checked Flag** | `BOOLEAN` | `NOT NULL` | Allergy interaction checked flag |
| `prescription_status` | **Prescription Status** | `VARCHAR(25)` | `NOT NULL` | ACTIVE, DISCONTINUED, EXPIRED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | FILLED, PENDING, CANCELLED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Pharmacy dispensing comments |

---

---

### Table: `tbl_patient_admissions`
**Description**: Domain table for `tbl_patient_admissions` in `Hospital_EMR_Clinical_Patient_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `admission_id` | **Admission Id** | `INT` | `PRIMARY KEY` | Admission primary key ID |
| `patient_id` | **Patient Id** | `INT` | `NOT NULL` | Patient master record ID |
| `admission_timestamp` | **Admission Timestamp** | `TIMESTAMP` | `NOT NULL` | Hospital admission time |
| `discharge_timestamp` | **Discharge Timestamp** | `TIMESTAMP` | `NOT NULL` | Hospital discharge time |
| `admission_type` | **Admission Type** | `VARCHAR(30)` | `NOT NULL` | EMERGENCY, ELECTIVE, URGENT, NEWBORN |
| `admission_source` | **Admission Source** | `VARCHAR(40)` | `NOT NULL` | EMERGENCY_ROOM, PHYSICIAN_REFERRAL, TRANSFER |
| `attending_physician_id` | **Attending Physician Id** | `INT` | `NOT NULL` | Lead physician doctor ID |
| `referring_physician_id` | **Referring Physician Id** | `INT` | `NOT NULL` | Referring doctor ID |
| `primary_diagnosis_code` | **Primary Diagnosis Code** | `VARCHAR(15)` | `NOT NULL` | ICD-10 primary diagnosis code |
| `secondary_diagnosis_code` | **Secondary Diagnosis Code** | `VARCHAR(15)` | `NOT NULL` | ICD-10 secondary diagnosis code |
| `department_id` | **Department Id** | `INT` | `NOT NULL` | Medical ward department ID |
| `room_number` | **Room Number** | `VARCHAR(10)` | `NOT NULL` | Inpatient room number |
| `bed_number` | **Bed Number** | `VARCHAR(5)` | `NOT NULL` | Bed location code A/B |
| `discharge_disposition` | **Discharge Disposition** | `VARCHAR(40)` | `NOT NULL` | HOME, REHAB, TRANSFERRED, EXPIRED |
| `total_billed_usd` | **Total Billed Usd** | `DECIMAL(12,2)` | `NOT NULL` | Total hospital billing amount USD |
| `insurance_covered_usd` | **Insurance Covered Usd** | `DECIMAL(12,2)` | `NOT NULL` | Insurance payout amount USD |
| `patient_copay_usd` | **Patient Copay Usd** | `DECIMAL(10,2)` | `NOT NULL` | Patient out-of-pocket copay USD |
| `readmission_30day_flag` | **Readmission 30day Flag** | `BOOLEAN` | `NOT NULL` | 30-day hospital readmission flag |
| `length_of_stay_days` | **Length Of Stay Days** | `INT` | `NOT NULL` | Inpatient duration in days |
| `emergency_flag` | **Emergency Flag** | `BOOLEAN` | `NOT NULL` | Emergency status flag |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | DISCHARGED, ADMITTED, TRANSFERRED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Clinical admission summary notes |

---

---

### Table: `tbl_patient_vital_signs`
**Description**: Domain table for `tbl_patient_vital_signs` in `Hospital_EMR_Clinical_Patient_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vital_sign_id` | **Vital Sign Id** | `INT` | `PRIMARY KEY` | Vitals primary key ID |
| `admission_id` | **Admission Id** | `INT` | `FOREIGN KEY` | FK to tbl_patient_admissions |
| `patient_id` | **Patient Id** | `INT` | `NOT NULL` | Patient ID |
| `recorded_timestamp` | **Recorded Timestamp** | `TIMESTAMP` | `NOT NULL` | Vitals measurement timestamp |
| `recorded_by_nurse_id` | **Recorded By Nurse Id** | `INT` | `NOT NULL` | Nurse clinician ID |
| `systolic_bp_mmhg` | **Systolic Bp Mmhg** | `INT` | `NOT NULL` | Systolic blood pressure mmHg |
| `diastolic_bp_mmhg` | **Diastolic Bp Mmhg** | `INT` | `NOT NULL` | Diastolic blood pressure mmHg |
| `heart_rate_bpm` | **Heart Rate Bpm** | `INT` | `NOT NULL` | Heart pulse rate BPM |
| `respiratory_rate_bpm` | **Respiratory Rate Bpm** | `INT` | `NOT NULL` | Breaths per minute |
| `body_temp_celsius` | **Body Temp Celsius** | `DECIMAL(4,1)` | `NOT NULL` | Body temperature C |
| `oxygen_sat_pct` | **Oxygen Sat Pct** | `DECIMAL(4,1)` | `NOT NULL` | SpO2 oxygen saturation % |
| `body_weight_kg` | **Body Weight Kg** | `DECIMAL(6,2)` | `NOT NULL` | Patient weight kg |
| `height_cm` | **Height Cm** | `DECIMAL(5,1)` | `NOT NULL` | Patient height cm |
| `bmi_value` | **Bmi Value** | `DECIMAL(4,1)` | `NOT NULL` | Body Mass Index BMI |
| `pain_score_scale` | **Pain Score Scale** | `INT` | `NOT NULL` | Pain scale score 0-10 |
| `blood_glucose_mgdl` | **Blood Glucose Mgdl** | `INT` | `NOT NULL` | Blood sugar glucose mg/dL |
| `consciousness_level` | **Consciousness Level** | `VARCHAR(25)` | `NOT NULL` | ALERT, DROWSY, STUPOROUS, COMATOSE |
| `is_abnormal_flag` | **Is Abnormal Flag** | `BOOLEAN` | `NOT NULL` | Abnormal vitals alert flag |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | VERIFIED, DRAFT, CORRECTED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Clinical vital sign observation |

---

---

### Table: `tbl_surgical_procedures`
**Description**: Domain table for `tbl_surgical_procedures` in `Hospital_EMR_Clinical_Patient_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `procedure_id` | **Procedure Id** | `INT` | `PRIMARY KEY` | Surgery primary key ID |
| `admission_id` | **Admission Id** | `INT` | `FOREIGN KEY` | FK to tbl_patient_admissions |
| `patient_id` | **Patient Id** | `INT` | `NOT NULL` | Patient ID |
| `lead_surgeon_id` | **Lead Surgeon Id** | `INT` | `NOT NULL` | Surgeon primary MD ID |
| `anesthesiologist_id` | **Anesthesiologist Id** | `INT` | `NOT NULL` | Anesthesiologist MD ID |
| `cpt_procedure_code` | **Cpt Procedure Code** | `VARCHAR(15)` | `NOT NULL` | CPT surgical procedure code |
| `procedure_name` | **Procedure Name** | `VARCHAR(100)` | `NOT NULL` | Surgical operation description |
| `operating_room_number` | **Operating Room Number** | `VARCHAR(10)` | `NOT NULL` | OR suite room code |
| `surgery_start_time` | **Surgery Start Time** | `TIMESTAMP` | `NOT NULL` | Incision start timestamp |
| `surgery_end_time` | **Surgery End Time** | `TIMESTAMP` | `NOT NULL` | Suture closure end timestamp |
| `anesthesia_type` | **Anesthesia Type** | `VARCHAR(30)` | `NOT NULL` | GENERAL, SPINAL, LOCAL, SEDATION |
| `has_complication_flag` | **Has Complication Flag** | `BOOLEAN` | `NOT NULL` | Intraoperative complication flag |
| `blood_loss_ml` | **Blood Loss Ml** | `INT` | `NOT NULL` | Estimated blood loss EBL mL |
| `implant_used_flag` | **Implant Used Flag** | `BOOLEAN` | `NOT NULL` | Medical implant/prosthetic flag |
| `procedure_cost_usd` | **Procedure Cost Usd** | `DECIMAL(12,2)` | `NOT NULL` | Surgical procedure fee USD |
| `recovery_time_minutes` | **Recovery Time Minutes** | `INT` | `NOT NULL` | PACU recovery duration minutes |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | COMPLETED, SCHEDULED, CANCELLED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Surgeon post-op operative report notes |

---

---

### Table: `tbl_adverse_event_reports`
**Description**: Domain table for `tbl_adverse_event_reports` in `Pharmaceutical_Clinical_RND_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_id` | **Event Id** | `INT` | `PRIMARY KEY` | Event primary key ID |
| `subject_id` | **Subject Id** | `INT` | `FOREIGN KEY` | FK to tbl_trial_subjects |
| `adverse_event_term` | **Adverse Event Term** | `VARCHAR(100)` | `NOT NULL` | MedDRA adverse event term |
| `severity` | **Severity** | `VARCHAR(15)` | `NOT NULL` | MILD/MODERATE/SEVERE |

---

---

### Table: `tbl_clinical_trials`
**Description**: Domain table for `tbl_clinical_trials` in `Pharmaceutical_Clinical_RND_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trial_id` | **Trial Id** | `INT` | `PRIMARY KEY` | Trial primary key ID |
| `compound_id` | **Compound Id** | `INT` | `FOREIGN KEY` | FK to tbl_drug_compounds |
| `nct_number` | **Nct Number** | `VARCHAR(15)` | `NOT NULL` | ClinicalTrials.gov NCT ID |
| `trial_phase` | **Trial Phase** | `VARCHAR(10)` | `NOT NULL` | PHASE_1/PHASE_2/PHASE_3 |

---

---

### Table: `tbl_drug_compounds`
**Description**: Domain table for `tbl_drug_compounds` in `Pharmaceutical_Clinical_RND_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `compound_id` | **Compound Id** | `INT` | `PRIMARY KEY` | Compound primary key ID |
| `molecule_code` | **Molecule Code** | `VARCHAR(30)` | `NOT NULL` | Internal R&D chemical code |
| `therapeutic_area` | **Therapeutic Area** | `VARCHAR(50)` | `NOT NULL` | ONCOLOGY/CARDIOLOGY/NEUROLOGY |

---

---

### Table: `tbl_trial_subjects`
**Description**: Domain table for `tbl_trial_subjects` in `Pharmaceutical_Clinical_RND_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `subject_id` | **Subject Id** | `INT` | `PRIMARY KEY` | Subject primary key ID |
| `trial_id` | **Trial Id** | `INT` | `FOREIGN KEY` | FK to tbl_clinical_trials |
| `subject_code` | **Subject Code** | `VARCHAR(20)` | `NOT NULL` | Anonymized subject code |
| `age_years` | **Age Years** | `INT` | `NOT NULL` | Age in years |

---

---

### Table: `tbl_devices`
**Description**: Domain table for `tbl_devices` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `device_id` | **Device Id** | `INT` | `PRIMARY KEY` | Device primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `device_mac` | **Device Mac** | `VARCHAR(17)` | `NOT NULL` | MAC address |
| `model_name` | **Model Name** | `VARCHAR(50)` | `NOT NULL` | Smartwatch model |

---

---

### Table: `tbl_heartrate_telemetry`
**Description**: Domain table for `tbl_heartrate_telemetry` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `telemetry_id` | **Telemetry Id** | `INT` | `PRIMARY KEY` | Telemetry primary key ID |
| `device_id` | **Device Id** | `INT` | `FOREIGN KEY` | FK to tbl_devices |
| `bpm_value` | **Bpm Value** | `INT` | `NOT NULL` | Beats per minute reading |
| `recorded_at` | **Recorded At** | `TIMESTAMP` | `NOT NULL` | Sensor timestamp |

---

---

### Table: `tbl_sleep_sessions`
**Description**: Domain table for `tbl_sleep_sessions` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sleep_id` | **Sleep Id** | `INT` | `PRIMARY KEY` | Sleep primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `deep_sleep_minutes` | **Deep Sleep Minutes** | `INT` | `NOT NULL` | Deep sleep stage minutes |
| `rem_sleep_minutes` | **Rem Sleep Minutes** | `INT` | `NOT NULL` | REM stage minutes |

---

---

### Table: `tbl_users`
**Description**: Domain table for `tbl_users` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_id` | **User Id** | `INT` | `PRIMARY KEY` | User primary key ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | User full name |
| `weight_kg` | **Weight Kg** | `DECIMAL(5,2)` | `NOT NULL` | Body weight kg |

---

---

### Table: `tbl_workouts`
**Description**: Domain table for `tbl_workouts` in `Fitness_Wearable_IoT_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `workout_id` | **Workout Id** | `INT` | `PRIMARY KEY` | Workout primary key ID |
| `user_id` | **User Id** | `INT` | `FOREIGN KEY` | FK to tbl_users |
| `workout_type` | **Workout Type** | `VARCHAR(30)` | `NOT NULL` | RUNNING/CYCLING/SWIMMING |
| `duration_minutes` | **Duration Minutes** | `INT` | `NOT NULL` | Active duration |
| `calories_burned` | **Calories Burned** | `INT` | `NOT NULL` | Burned kilocalories |

---

---

### Table: `tbl_cart_items`
**Description**: Domain table for `tbl_cart_items` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cart_item_id` | **Cart Item Id** | `INT` | `PRIMARY KEY` | Cart item primary key ID |
| `cart_id` | **Cart Id** | `INT` | `FOREIGN KEY` | FK to tbl_shopping_carts |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Cart item count quantity |

---

---

### Table: `tbl_categories`
**Description**: Domain table for `tbl_categories` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `category_id` | **Category Id** | `INT` | `PRIMARY KEY` | Category primary key ID |
| `category_name` | **Category Name** | `VARCHAR(50)` | `NOT NULL` | Category display name |
| `category_slug` | **Category Slug** | `VARCHAR(60)` | `NOT NULL` | URL friendly slug |
| `parent_category_id` | **Parent Category Id** | `INT` | `FOREIGN KEY` | Self-referencing parent category |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |

---

---

### Table: `tbl_customer_addresses`
**Description**: Domain table for `tbl_customer_addresses` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `address_id` | **Address Id** | `INT` | `PRIMARY KEY` | Address primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `address_type` | **Address Type** | `VARCHAR(20)` | `NOT NULL` | SHIPPING/BILLING |
| `street_address` | **Street Address** | `VARCHAR(100)` | `NOT NULL` | Street address line |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/province code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP or Postal code |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_customer_support_tickets`
**Description**: Domain table for `tbl_customer_support_tickets` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `ticket_id` | **Ticket Id** | `INT` | `PRIMARY KEY` | Ticket primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `ticket_subject` | **Ticket Subject** | `VARCHAR(100)` | `NOT NULL` | Issue subject title |
| `ticket_status` | **Ticket Status** | `VARCHAR(20)` | `NOT NULL` | OPEN/RESOLVED/CLOSED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Opened timestamp |

---

---

### Table: `tbl_customers`
**Description**: Domain table for `tbl_customers` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `customer_code` | **Customer Code** | `VARCHAR(36)` | `NOT NULL` | Unique tracking code |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Family last name |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Contact email address |
| `phone` | **Phone** | `VARCHAR(20)` | `NULL` | Telephone contact number |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/SUSPENDED/CLOSED |
| `customer_segment` | **Customer Segment** | `VARCHAR(30)` | `NOT NULL` | RETAIL/WHOLESALE/VIP |
| `total_spent` | **Total Spent** | `DECIMAL(10,2)` | `NOT NULL` | Lifetime spend amount |
| `loyalty_points` | **Loyalty Points** | `INT` | `NOT NULL` | Earned loyalty points |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Account creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Account updated timestamp |

---

---

### Table: `tbl_discounts_promos`
**Description**: Domain table for `tbl_discounts_promos` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `promo_id` | **Promo Id** | `INT` | `PRIMARY KEY` | Promo primary key ID |
| `promo_code` | **Promo Code** | `VARCHAR(20)` | `NOT NULL` | Unique promo code |
| `discount_percent` | **Discount Percent** | `DECIMAL(5,2)` | `NOT NULL` | Discount percentage rate |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Campaign start date |
| `end_date` | **End Date** | `DATE` | `NOT NULL` | Campaign expiry date |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |

---

---

### Table: `tbl_inventory`
**Description**: Domain table for `tbl_inventory` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_id` | **Inventory Id** | `INT` | `PRIMARY KEY` | Inventory record primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `warehouse_id` | **Warehouse Id** | `INT` | `FOREIGN KEY` | FK to tbl_warehouses |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Available physical stock |
| `reserved_quantity` | **Reserved Quantity** | `INT` | `NOT NULL` | Allocated pending order stock |
| `last_updated` | **Last Updated** | `TIMESTAMP` | `NOT NULL` | Stock check timestamp |

---

---

### Table: `tbl_invoices`
**Description**: Domain table for `tbl_invoices` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `invoice_id` | **Invoice Id** | `INT` | `PRIMARY KEY` | Invoice primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `invoice_number` | **Invoice Number** | `VARCHAR(30)` | `NOT NULL` | Tax invoice document number |
| `invoice_date` | **Invoice Date** | `DATE` | `NOT NULL` | Billing issue date |
| `due_date` | **Due Date** | `DATE` | `NOT NULL` | Payment due date |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Total billed amount |
| `invoice_status` | **Invoice Status** | `VARCHAR(15)` | `NOT NULL` | PAID/UNPAID/OVERDUE |

---

---

### Table: `tbl_order_items`
**Description**: Domain table for `tbl_order_items` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_item_id` | **Order Item Id** | `INT` | `PRIMARY KEY` | Order line item primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Sold price per unit |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Purchased item quantity |
| `subtotal` | **Subtotal** | `DECIMAL(10,2)` | `NOT NULL` | Calculated line item subtotal |

---

---

### Table: `tbl_orders`
**Description**: Domain table for `tbl_orders` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | **Order Id** | `INT` | `PRIMARY KEY` | Order primary key ID |
| `order_number` | **Order Number** | `VARCHAR(36)` | `NOT NULL` | Unique transaction order number |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order placement timestamp |
| `order_status` | **Order Status** | `VARCHAR(20)` | `NOT NULL` | PENDING/PROCESSING/SHIPPED/DELIVERED/CANCELLED |
| `total_amount` | **Total Amount** | `DECIMAL(10,2)` | `NOT NULL` | Gross order total |
| `tax_amount` | **Tax Amount** | `DECIMAL(10,2)` | `NOT NULL` | Applied tax amount |
| `shipping_fee` | **Shipping Fee** | `DECIMAL(10,2)` | `NOT NULL` | Shipping charge fee |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |

---

---

### Table: `tbl_payments`
**Description**: Domain table for `tbl_payments` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_id` | **Payment Id** | `INT` | `PRIMARY KEY` | Payment primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | CREDIT_CARD/PAYPAL/WIRE |
| `payment_status` | **Payment Status** | `VARCHAR(15)` | `NOT NULL` | COMPLETED/PENDING/FAILED |
| `amount` | **Amount** | `DECIMAL(10,2)` | `NOT NULL` | Processed payment amount |
| `transaction_ref` | **Transaction Ref** | `VARCHAR(36)` | `NOT NULL` | Gateway transaction reference |
| `payment_date` | **Payment Date** | `TIMESTAMP` | `NOT NULL` | Execution timestamp |

---

---

### Table: `tbl_product_attributes`
**Description**: Domain table for `tbl_product_attributes` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attribute_id` | **Attribute Id** | `INT` | `PRIMARY KEY` | Attribute primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `attribute_name` | **Attribute Name** | `VARCHAR(50)` | `NOT NULL` | Color/Size/Weight |
| `attribute_value` | **Attribute Value** | `VARCHAR(50)` | `NOT NULL` | Attribute value string |

---

---

### Table: `tbl_product_reviews`
**Description**: Domain table for `tbl_product_reviews` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `review_id` | **Review Id** | `INT` | `PRIMARY KEY` | Review primary key ID |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `rating_score` | **Rating Score** | `INT` | `NOT NULL` | Rating 1-5 stars |
| `review_text` | **Review Text** | `TEXT` | `NULL` | Customer feedback review |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Review submission timestamp |

---

---

### Table: `tbl_products`
**Description**: Domain table for `tbl_products` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `product_id` | **Product Id** | `INT` | `PRIMARY KEY` | Product primary key ID |
| `sku` | **Sku** | `VARCHAR(30)` | `NOT NULL` | Stock Keeping Unit SKU |
| `product_name` | **Product Name** | `VARCHAR(100)` | `NOT NULL` | Product catalog title |
| `category_id` | **Category Id** | `INT` | `FOREIGN KEY` | FK to tbl_categories |
| `supplier_id` | **Supplier Id** | `INT` | `FOREIGN KEY` | FK to tbl_suppliers |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Standard retail price |
| `cost_price` | **Cost Price** | `DECIMAL(10,2)` | `NOT NULL` | Wholesale cost price |
| `product_status` | **Product Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE/DISCONTINUED/OUT_OF_STOCK |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Catalog entry timestamp |

---

---

### Table: `tbl_return_requests`
**Description**: Domain table for `tbl_return_requests` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `return_id` | **Return Id** | `INT` | `PRIMARY KEY` | Return request primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `return_reason` | **Return Reason** | `VARCHAR(100)` | `NOT NULL` | Reason for return |
| `return_status` | **Return Status** | `VARCHAR(20)` | `NOT NULL` | REQUESTED/APPROVED/REJECTED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Request timestamp |

---

---

### Table: `tbl_shipments`
**Description**: Domain table for `tbl_shipments` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_id` | **Shipment Id** | `INT` | `PRIMARY KEY` | Shipment primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_orders |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Carrier tracking code |
| `carrier_name` | **Carrier Name** | `VARCHAR(30)` | `NOT NULL` | UPS/FEDEX/DHL |
| `shipped_date` | **Shipped Date** | `TIMESTAMP` | `NULL` | Dispatch timestamp |
| `delivery_date` | **Delivery Date** | `TIMESTAMP` | `NULL` | Delivery timestamp |
| `shipment_status` | **Shipment Status** | `VARCHAR(20)` | `NOT NULL` | IN_TRANSIT/DELIVERED/RETURNED |

---

---

### Table: `tbl_shopping_carts`
**Description**: Domain table for `tbl_shopping_carts` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cart_id` | **Cart Id** | `INT` | `PRIMARY KEY` | Cart primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Cart creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Cart modified timestamp |

---

---

### Table: `tbl_suppliers`
**Description**: Domain table for `tbl_suppliers` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `supplier_id` | **Supplier Id** | `INT` | `PRIMARY KEY` | Supplier primary key ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | Supplier corporate name |
| `contact_name` | **Contact Name** | `VARCHAR(60)` | `NOT NULL` | Primary account manager |
| `email` | **Email** | `VARCHAR(100)` | `NOT NULL` | Corporate email address |
| `phone` | **Phone** | `VARCHAR(20)` | `NOT NULL` | Corporate contact phone |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_system_audit_logs`
**Description**: Domain table for `tbl_system_audit_logs` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Operator user string ID |
| `action_name` | **Action Name** | `VARCHAR(50)` | `NOT NULL` | Action performed |
| `target_entity` | **Target Entity** | `VARCHAR(50)` | `NOT NULL` | Target table name |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Audit timestamp |

---

---

### Table: `tbl_warehouses`
**Description**: Domain table for `tbl_warehouses` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `warehouse_id` | **Warehouse Id** | `INT` | `PRIMARY KEY` | Warehouse primary key ID |
| `warehouse_code` | **Warehouse Code** | `VARCHAR(20)` | `NOT NULL` | Unique warehouse location code |
| `warehouse_name` | **Warehouse Name** | `VARCHAR(80)` | `NOT NULL` | Facility designation name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | Facility location city |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State/Province code |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO 3-letter country code |

---

---

### Table: `tbl_wishlists`
**Description**: Domain table for `tbl_wishlists` in `Ecommerce_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `wishlist_id` | **Wishlist Id** | `INT` | `PRIMARY KEY` | Wishlist primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customers |
| `product_id` | **Product Id** | `INT` | `FOREIGN KEY` | FK to tbl_products |
| `added_at` | **Added At** | `TIMESTAMP` | `NOT NULL` | Addition timestamp |

---

---

### Table: `tbl_accounts`
**Description**: Domain table for `tbl_accounts` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `account_id` | **Account Id** | `INT` | `PRIMARY KEY` | Account primary key ID |
| `account_number` | **Account Number** | `VARCHAR(20)` | `NOT NULL` | Unique bank account number |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | Parent customer ID |
| `account_type` | **Account Type** | `VARCHAR(20)` | `NOT NULL` | CHECKING/SAVINGS/MONEY_MARKET |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | ISO currency code USD/EUR |
| `current_balance` | **Current Balance** | `DECIMAL(12,2)` | `NOT NULL` | Current account balance |
| `available_balance` | **Available Balance** | `DECIMAL(12,2)` | `NOT NULL` | Available account balance |
| `status_code` | **Status Code** | `VARCHAR(10)` | `NOT NULL` | ACTIVE/CLOSED/FROZEN |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Account creation timestamp |

---

---

### Table: `tbl_audit_logs`
**Description**: Domain table for `tbl_audit_logs` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `log_id` | **Log Id** | `INT` | `PRIMARY KEY` | Audit log primary key ID |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Operator user or system ID |
| `action_type` | **Action Type** | `VARCHAR(30)` | `NOT NULL` | LOGIN/TRANSFER/UPDATE_LIMIT |
| `entity_name` | **Entity Name** | `VARCHAR(40)` | `NOT NULL` | Target entity table |
| `entity_id` | **Entity Id** | `INT` | `NOT NULL` | Target entity record ID |
| `ip_address` | **Ip Address** | `VARCHAR(45)` | `NOT NULL` | Client IP address |
| `log_timestamp` | **Log Timestamp** | `TIMESTAMP` | `NOT NULL` | Audit log timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | SUCCESS/DENIED |

---

---

### Table: `tbl_branches`
**Description**: Domain table for `tbl_branches` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `branch_id` | **Branch Id** | `INT` | `PRIMARY KEY` | Branch primary key ID |
| `branch_code` | **Branch Code** | `VARCHAR(10)` | `NOT NULL` | Unique branch location code |
| `branch_name` | **Branch Name** | `VARCHAR(60)` | `NOT NULL` | Branch designation name |
| `address_line` | **Address Line** | `VARCHAR(100)` | `NOT NULL` | Street address line |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `state_code` | **State Code** | `VARCHAR(5)` | `NOT NULL` | State postal code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP/Postal code |
| `manager_name` | **Manager Name** | `VARCHAR(60)` | `NOT NULL` | Branch manager name |
| `status_code` | **Status Code** | `VARCHAR(10)` | `NOT NULL` | OPEN/CLOSED/REMODEL |

---

---

### Table: `tbl_credit_cards`
**Description**: Domain table for `tbl_credit_cards` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `card_id` | **Card Id** | `INT` | `PRIMARY KEY` | Credit card primary key ID |
| `account_id` | **Account Id** | `INT` | `FOREIGN KEY` | Associated checking/card account ID |
| `card_number_masked` | **Card Number Masked** | `VARCHAR(19)` | `NOT NULL` | Masked credit card number |
| `card_type` | **Card Type** | `VARCHAR(20)` | `NOT NULL` | VISA/MASTERCARD/AMEX |
| `credit_limit` | **Credit Limit** | `DECIMAL(10,2)` | `NOT NULL` | Approved credit limit |
| `current_balance` | **Current Balance** | `DECIMAL(10,2)` | `NOT NULL` | Current statement balance |
| `expiry_date` | **Expiry Date** | `VARCHAR(7)` | `NOT NULL` | Expiration date MM/YYYY |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | ISSUED/BLOCKED/EXPIRED |

---

---

### Table: `tbl_customers_finance_finance`
**Description**: Domain table for `tbl_customers_finance` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `tax_identifier` | **Tax Identifier** | `VARCHAR(11)` | `NOT NULL` | SSN or Tax ID number |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Customer given name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Customer family name |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Primary email contact |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Primary phone contact |
| `kyc_status` | **Kyc Status** | `VARCHAR(15)` | `NOT NULL` | VERIFIED/PENDING/REJECTED |
| `risk_rating` | **Risk Rating** | `VARCHAR(10)` | `NOT NULL` | LOW/MEDIUM/HIGH |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Customer onboarding timestamp |

---