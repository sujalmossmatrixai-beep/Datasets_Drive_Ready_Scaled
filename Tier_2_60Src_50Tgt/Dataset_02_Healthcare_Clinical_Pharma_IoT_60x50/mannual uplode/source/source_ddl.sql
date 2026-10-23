-- ========================================================
-- Master DDL Schema Script for Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_source
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 60
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_03_Finance_Banking_Dataset, Dataset_14_Fitness_Wearable_IoT_Dataset, Dataset_18_Hospital_EMR_Clinical_Patient_Dataset, Dataset_22_Pharmaceutical_Clinical_RND_Dataset
-- ========================================================

CREATE TABLE src_doctor_physicians (
    physician_id                   INT             PRIMARY KEY                                                , -- Physician primary key ID
    npi_number                     VARCHAR(10)     NOT NULL                                                   , -- National Provider Identifier NPI
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Physician first name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Physician last name
    specialty                      VARCHAR(60)     NOT NULL                                                   , -- Medical specialty field
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    phone_contact                  VARCHAR(20)     NOT NULL                                                     -- Direct telephone contact
);

CREATE TABLE src_ehr_audit_logs (
    log_id                         INT             PRIMARY KEY                                                , -- Audit log primary key ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Clinician user ID
    action_type                    VARCHAR(30)     NOT NULL                                                   , -- READ/WRITE/DELETE
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    ip_address                     VARCHAR(45)     NOT NULL                                                   , -- Workstation IP
    log_timestamp                  TIMESTAMP       NOT NULL                                                     -- Audit timestamp
);

CREATE TABLE src_emergency_contacts (
    contact_id                     INT             PRIMARY KEY                                                , -- Emergency contact primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    contact_name                   VARCHAR(60)     NOT NULL                                                   , -- Contact person full name
    relationship                   VARCHAR(30)     NOT NULL                                                   , -- SPOUSE/PARENT/SIBLING
    phone_number                   VARCHAR(20)     NOT NULL                                                     -- Emergency phone number
);

CREATE TABLE src_hospital_departments (
    department_id                  INT             PRIMARY KEY                                                , -- Department primary key ID
    dept_name                      VARCHAR(60)     NOT NULL                                                   , -- Clinical department designation
    facility_name                  VARCHAR(80)     NOT NULL                                                   , -- Hospital facility complex
    building_location              VARCHAR(40)     NOT NULL                                                   , -- Building or floor wing
    phone_extension                VARCHAR(10)     NOT NULL                                                     -- Internal phone extension
);

CREATE TABLE src_hospital_encounters (
    encounter_id                   INT             PRIMARY KEY                                                , -- Encounter primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    attending_physician_id         INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    encounter_class                VARCHAR(20)     NOT NULL                                                   , -- INPATIENT/OUTPATIENT/EMERGENCY
    admission_date                 TIMESTAMP       NOT NULL                                                   , -- Admission timestamp
    discharge_date                 TIMESTAMP       NULL                                                       , -- Discharge timestamp
    encounter_status               VARCHAR(15)     NOT NULL                                                     -- ACTIVE/FINISHED/CANCELLED
);

CREATE TABLE src_hospital_staff_roster (
    staff_id                       INT             PRIMARY KEY                                                , -- Staff primary key ID
    employee_number                VARCHAR(20)     NOT NULL                                                   , -- Staff badge ID
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Staff full name
    role_title                     VARCHAR(50)     NOT NULL                                                   , -- NURSE/TECHNICIAN/ADMIN
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    phone_extension                VARCHAR(10)     NOT NULL                                                     -- Internal phone extension
);

CREATE TABLE src_insurance_claims (
    claim_id                       INT             PRIMARY KEY                                                , -- Insurance claim primary key ID
    billing_id                     INT             NOT NULL REFERENCES src_patient_billing(billing_id)        , -- FK to src_patient_billing
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    payer_name                     VARCHAR(80)     NOT NULL                                                   , -- Health insurance provider
    claim_amount                   DECIMAL(10,2)   NOT NULL                                                   , -- Claimed reimbursement amount
    covered_amount                 DECIMAL(10,2)   NOT NULL                                                   , -- Approved covered amount
    claim_status                   VARCHAR(15)     NOT NULL                                                   , -- SUBMITTED/PAID/DENIED
    submission_date                DATE            NOT NULL                                                     -- Payer filing date
);

CREATE TABLE src_lab_results (
    lab_result_id                  INT             PRIMARY KEY                                                , -- Lab result primary key ID
    lab_order_id                   INT             NOT NULL REFERENCES src_lab_test_orders(lab_order_id)      , -- FK to src_lab_test_orders
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    result_value                   DECIMAL(10,2)   NOT NULL                                                   , -- Quantitative lab measurement
    unit_of_measure                VARCHAR(20)     NOT NULL                                                   , -- Measurement unit (mg/dL)
    reference_range                VARCHAR(30)     NOT NULL                                                   , -- Normal reference range
    result_status                  VARCHAR(15)     NOT NULL                                                   , -- FINAL/PRELIMINARY
    result_date                    TIMESTAMP       NOT NULL                                                     -- Result timestamp
);

CREATE TABLE src_lab_test_orders (
    lab_order_id                   INT             PRIMARY KEY                                                , -- Lab order primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    ordering_physician_id          INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    loinc_code                     VARCHAR(20)     NOT NULL                                                   , -- LOINC lab test concept code
    test_name                      VARCHAR(100)    NOT NULL                                                   , -- Lab panel test title
    order_date                     TIMESTAMP       NOT NULL                                                   , -- Order timestamp
    order_status                   VARCHAR(15)     NOT NULL                                                     -- ORDERED/COMPLETED/CANCELLED
);

CREATE TABLE src_medical_diagnoses (
    diagnosis_id                   INT             PRIMARY KEY                                                , -- Diagnosis primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    icd10_code                     VARCHAR(20)     NOT NULL                                                   , -- ICD-10 clinical diagnosis code
    diagnosis_name                 VARCHAR(100)    NOT NULL                                                   , -- Diagnosis description
    diagnosis_date                 DATE            NOT NULL                                                     -- Onset or diagnosis date
);

CREATE TABLE src_medical_history (
    history_id                     INT             PRIMARY KEY                                                , -- Medical history primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    condition_name                 VARCHAR(100)    NOT NULL                                                   , -- Pre-existing medical condition
    onset_date                     DATE            NOT NULL                                                   , -- Condition onset date
    condition_status               VARCHAR(15)     NOT NULL                                                     -- ACTIVE/RESOLVED
);

CREATE TABLE src_medical_prescriptions (
    prescription_id                INT             PRIMARY KEY                                                , -- Prescription primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    prescribing_physician_id       INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    rxnorm_code                    VARCHAR(20)     NOT NULL                                                   , -- RxNorm medication code
    medication_name                VARCHAR(100)    NOT NULL                                                   , -- Medication trade name
    dosage_instructions            VARCHAR(100)    NOT NULL                                                   , -- Dosage and frequency
    prescribed_date                DATE            NOT NULL                                                     -- Prescription order date
);

CREATE TABLE src_patient_appointments (
    appointment_id                 INT             PRIMARY KEY                                                , -- Appointment primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    physician_id                   INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    department_id                  INT             NOT NULL REFERENCES src_hospital_departments(department_id) , -- FK to src_hospital_departments
    appointment_time               TIMESTAMP       NOT NULL                                                   , -- Scheduled appointment timestamp
    appointment_status             VARCHAR(15)     NOT NULL                                                     -- SCHEDULED/COMPLETED/NO_SHOW
);

CREATE TABLE src_patient_billing (
    billing_id                     INT             PRIMARY KEY                                                , -- Patient billing primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    total_charge_amount            DECIMAL(10,2)   NOT NULL                                                   , -- Gross medical charge
    paid_amount                    DECIMAL(10,2)   NOT NULL                                                   , -- Settled payment amount
    balance_due                    DECIMAL(10,2)   NOT NULL                                                   , -- Outstanding invoice balance
    billing_date                   DATE            NOT NULL                                                   , -- Statement generation date
    billing_status                 VARCHAR(15)     NOT NULL                                                     -- BILLED/PAID/OVERDUE
);

CREATE TABLE src_patient_immunizations (
    immunization_id                INT             PRIMARY KEY                                                , -- Immunization primary key ID
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    vaccine_code                   VARCHAR(20)     NOT NULL                                                   , -- CVX vaccine code
    vaccine_name                   VARCHAR(100)    NOT NULL                                                   , -- Vaccine trade name
    administered_date              DATE            NOT NULL                                                   , -- Vaccination date
    dose_number                    INT             NOT NULL                                                     -- Dose sequence number
);

CREATE TABLE src_patient_master (
    patient_id                     INT             PRIMARY KEY                                                , -- Patient primary key ID
    mrn_number                     VARCHAR(30)     NOT NULL                                                   , -- Medical Record Number MRN
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Patient given first name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Patient family last name
    gender_code                    VARCHAR(1)      NOT NULL                                                   , -- Administrative gender (M/F/U)
    date_of_birth                  DATE            NOT NULL                                                   , -- Patient birth date
    phone_contact                  VARCHAR(20)     NOT NULL                                                   , -- Primary telephone contact
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State/Province code
    created_at                     TIMESTAMP       NOT NULL                                                     -- EHR entry timestamp
);

CREATE TABLE src_patient_vitals_signs (
    vital_id                       INT             PRIMARY KEY                                                , -- Vital sign primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    vital_type                     VARCHAR(30)     NOT NULL                                                   , -- HEART_RATE/BP_SYSTOLIC/TEMP
    numeric_value                  DECIMAL(8,2)    NOT NULL                                                   , -- Measurement reading
    unit_of_measure                VARCHAR(20)     NOT NULL                                                   , -- Measurement unit
    recorded_time                  TIMESTAMP       NOT NULL                                                     -- Observation timestamp
);

CREATE TABLE src_pharmacy_inventory (
    inventory_id                   INT             PRIMARY KEY                                                , -- Pharmacy stock primary key ID
    ndc_code                       VARCHAR(20)     NOT NULL                                                   , -- National Drug Code NDC
    medication_name                VARCHAR(100)    NOT NULL                                                   , -- Medication trade name
    quantity_in_stock              INT             NOT NULL                                                   , -- Physical stock on hand
    reorder_level                  INT             NOT NULL                                                     -- Reorder threshold count
);

CREATE TABLE src_room_bed_allocations (
    allocation_id                  INT             PRIMARY KEY                                                , -- Bed allocation primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    room_number                    VARCHAR(20)     NOT NULL                                                   , -- Hospital room number
    bed_number                     VARCHAR(10)     NOT NULL                                                   , -- Bed location designation
    start_time                     TIMESTAMP       NOT NULL                                                   , -- Bed assignment start
    end_time                       TIMESTAMP       NULL                                                         -- Bed discharge time
);

CREATE TABLE src_surgical_procedures (
    procedure_id                   INT             PRIMARY KEY                                                , -- Procedure primary key ID
    encounter_id                   INT             NOT NULL REFERENCES src_hospital_encounters(encounter_id)  , -- FK to src_hospital_encounters
    patient_id                     INT             NOT NULL REFERENCES src_patient_master(patient_id)         , -- FK to src_patient_master
    surgeon_id                     INT             NOT NULL REFERENCES src_doctor_physicians(physician_id)    , -- FK to src_doctor_physicians
    cpt_code                       VARCHAR(20)     NOT NULL                                                   , -- CPT procedure medical code
    procedure_name                 VARCHAR(100)    NOT NULL                                                   , -- Surgical procedure title
    procedure_date                 DATE            NOT NULL                                                     -- Surgery execution date
);

CREATE TABLE tbl_lab_test_orders (
    lab_order_id                   INT             PRIMARY KEY                                              , -- Lab order primary key ID
    admission_id                   INT             NOT NULL                                                  , -- FK to tbl_patient_admissions
    patient_id                     INT             NOT NULL                                                 , -- Patient ID
    ordering_doctor_id             INT             NOT NULL                                                 , -- Physician orderer ID
    test_code                      VARCHAR(20)     NOT NULL                                                 , -- LOINC diagnostic lab test code
    test_name                      VARCHAR(80)     NOT NULL                                                 , -- Diagnostic test panel name
    lab_specimen_type              VARCHAR(30)     NOT NULL                                                 , -- BLOOD, URINE, CSF, SPUTUM, TISSUE
    order_timestamp                TIMESTAMP       NOT NULL                                                 , -- Doctor lab order placement time
    collection_timestamp           TIMESTAMP       NOT NULL                                                 , -- Specimen phlebotomy draw time
    result_timestamp               TIMESTAMP       NOT NULL                                                 , -- Lab report validation time
    test_result_value              DECIMAL(10,2)   NOT NULL                                                 , -- Lab quantitative result value
    result_unit                    VARCHAR(20)     NOT NULL                                                 , -- Measurement unit (g/dL, mg/dL)
    reference_range_normal         VARCHAR(30)     NOT NULL                                                 , -- Clinical reference standard range
    is_abnormal_flag               BOOLEAN         NOT NULL                                                 , -- High/Low flag alert
    test_cost_usd                  DECIMAL(8,2)    NOT NULL                                                 , -- Diagnostic test fee USD
    lab_technician_id              INT             NOT NULL                                                 , -- Performing technologist ID
    performing_lab_code            VARCHAR(20)     NOT NULL                                                 , -- Lab facility code
    lab_status                     VARCHAR(20)     NOT NULL                                                 , -- COMPLETED, IN_PROGRESS, CANCELLED
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- FINAL, PRELIMINARY, AMENDED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Pathologist result comments
);

CREATE TABLE tbl_medication_prescriptions (
    prescription_id                INT             PRIMARY KEY                                              , -- Rx primary key ID
    admission_id                   INT             NOT NULL                                                  , -- FK to tbl_patient_admissions
    patient_id                     INT             NOT NULL                                                 , -- Patient ID
    prescribing_doctor_id          INT             NOT NULL                                                 , -- Prescribing doctor ID
    drug_code_ndc                  VARCHAR(20)     NOT NULL                                                 , -- National Drug Code NDC
    medication_name                VARCHAR(80)     NOT NULL                                                 , -- Pharmaceutical brand/generic name
    dosage_mg                      DECIMAL(8,2)    NOT NULL                                                 , -- Single administration dose mg
    administration_route           VARCHAR(30)     NOT NULL                                                 , -- ORAL, IV_PUSH, SUBQ, INHALATION
    frequency_schedule             VARCHAR(30)     NOT NULL                                                 , -- ONCE_DAILY, BID_TWICE, TID_THREE
    start_date                     DATE            NOT NULL                                                 , -- Medication start date
    end_date                       DATE            NOT NULL                                                 , -- Medication course end date
    dispensed_quantity             INT             NOT NULL                                                 , -- Total pill/unit count dispensed
    refills_allowed                INT             NOT NULL                                                 , -- Authorized prescription refills
    pharmacist_id                  INT             NOT NULL                                                 , -- Dispensing pharmacist ID
    pharmacy_cost_usd              DECIMAL(8,2)    NOT NULL                                                 , -- Medication billing cost USD
    is_controlled_substance        BOOLEAN         NOT NULL                                                 , -- DEA Schedule controlled drug flag
    allergy_checked_flag           BOOLEAN         NOT NULL                                                 , -- Allergy interaction checked flag
    prescription_status            VARCHAR(25)     NOT NULL                                                 , -- ACTIVE, DISCONTINUED, EXPIRED
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- FILLED, PENDING, CANCELLED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Pharmacy dispensing comments
);

CREATE TABLE tbl_patient_admissions (
    admission_id                   INT             PRIMARY KEY                                              , -- Admission primary key ID
    patient_id                     INT             NOT NULL                                                 , -- Patient master record ID
    admission_timestamp            TIMESTAMP       NOT NULL                                                 , -- Hospital admission time
    discharge_timestamp            TIMESTAMP       NOT NULL                                                 , -- Hospital discharge time
    admission_type                 VARCHAR(30)     NOT NULL                                                 , -- EMERGENCY, ELECTIVE, URGENT, NEWBORN
    admission_source               VARCHAR(40)     NOT NULL                                                 , -- EMERGENCY_ROOM, PHYSICIAN_REFERRAL, TRANSFER
    attending_physician_id         INT             NOT NULL                                                 , -- Lead physician doctor ID
    referring_physician_id         INT             NOT NULL                                                 , -- Referring doctor ID
    primary_diagnosis_code         VARCHAR(15)     NOT NULL                                                 , -- ICD-10 primary diagnosis code
    secondary_diagnosis_code       VARCHAR(15)     NOT NULL                                                 , -- ICD-10 secondary diagnosis code
    department_id                  INT             NOT NULL                                                 , -- Medical ward department ID
    room_number                    VARCHAR(10)     NOT NULL                                                 , -- Inpatient room number
    bed_number                     VARCHAR(5)      NOT NULL                                                 , -- Bed location code A/B
    discharge_disposition          VARCHAR(40)     NOT NULL                                                 , -- HOME, REHAB, TRANSFERRED, EXPIRED
    total_billed_usd               DECIMAL(12,2)   NOT NULL                                                 , -- Total hospital billing amount USD
    insurance_covered_usd          DECIMAL(12,2)   NOT NULL                                                 , -- Insurance payout amount USD
    patient_copay_usd              DECIMAL(10,2)   NOT NULL                                                 , -- Patient out-of-pocket copay USD
    readmission_30day_flag         BOOLEAN         NOT NULL                                                 , -- 30-day hospital readmission flag
    length_of_stay_days            INT             NOT NULL                                                 , -- Inpatient duration in days
    emergency_flag                 BOOLEAN         NOT NULL                                                 , -- Emergency status flag
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- DISCHARGED, ADMITTED, TRANSFERRED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Clinical admission summary notes
);

CREATE TABLE tbl_patient_vital_signs (
    vital_sign_id                  INT             PRIMARY KEY                                              , -- Vitals primary key ID
    admission_id                   INT             NOT NULL                                                  , -- FK to tbl_patient_admissions
    patient_id                     INT             NOT NULL                                                 , -- Patient ID
    recorded_timestamp             TIMESTAMP       NOT NULL                                                 , -- Vitals measurement timestamp
    recorded_by_nurse_id           INT             NOT NULL                                                 , -- Nurse clinician ID
    systolic_bp_mmhg               INT             NOT NULL                                                 , -- Systolic blood pressure mmHg
    diastolic_bp_mmhg              INT             NOT NULL                                                 , -- Diastolic blood pressure mmHg
    heart_rate_bpm                 INT             NOT NULL                                                 , -- Heart pulse rate BPM
    respiratory_rate_bpm           INT             NOT NULL                                                 , -- Breaths per minute
    body_temp_celsius              DECIMAL(4,1)    NOT NULL                                                 , -- Body temperature C
    oxygen_sat_pct                 DECIMAL(4,1)    NOT NULL                                                 , -- SpO2 oxygen saturation %
    body_weight_kg                 DECIMAL(6,2)    NOT NULL                                                 , -- Patient weight kg
    height_cm                      DECIMAL(5,1)    NOT NULL                                                 , -- Patient height cm
    bmi_value                      DECIMAL(4,1)    NOT NULL                                                 , -- Body Mass Index BMI
    pain_score_scale               INT             NOT NULL                                                 , -- Pain scale score 0-10
    blood_glucose_mgdl             INT             NOT NULL                                                 , -- Blood sugar glucose mg/dL
    consciousness_level            VARCHAR(25)     NOT NULL                                                 , -- ALERT, DROWSY, STUPOROUS, COMATOSE
    is_abnormal_flag               BOOLEAN         NOT NULL                                                 , -- Abnormal vitals alert flag
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- VERIFIED, DRAFT, CORRECTED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Clinical vital sign observation
);

CREATE TABLE tbl_surgical_procedures (
    procedure_id                   INT             PRIMARY KEY                                              , -- Surgery primary key ID
    admission_id                   INT             NOT NULL                                                  , -- FK to tbl_patient_admissions
    patient_id                     INT             NOT NULL                                                 , -- Patient ID
    lead_surgeon_id                INT             NOT NULL                                                 , -- Surgeon primary MD ID
    anesthesiologist_id            INT             NOT NULL                                                 , -- Anesthesiologist MD ID
    cpt_procedure_code             VARCHAR(15)     NOT NULL                                                 , -- CPT surgical procedure code
    procedure_name                 VARCHAR(100)    NOT NULL                                                 , -- Surgical operation description
    operating_room_number          VARCHAR(10)     NOT NULL                                                 , -- OR suite room code
    surgery_start_time             TIMESTAMP       NOT NULL                                                 , -- Incision start timestamp
    surgery_end_time               TIMESTAMP       NOT NULL                                                 , -- Suture closure end timestamp
    anesthesia_type                VARCHAR(30)     NOT NULL                                                 , -- GENERAL, SPINAL, LOCAL, SEDATION
    has_complication_flag          BOOLEAN         NOT NULL                                                 , -- Intraoperative complication flag
    blood_loss_ml                  INT             NOT NULL                                                 , -- Estimated blood loss EBL mL
    implant_used_flag              BOOLEAN         NOT NULL                                                 , -- Medical implant/prosthetic flag
    procedure_cost_usd             DECIMAL(12,2)   NOT NULL                                                 , -- Surgical procedure fee USD
    recovery_time_minutes          INT             NOT NULL                                                 , -- PACU recovery duration minutes
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- COMPLETED, SCHEDULED, CANCELLED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Surgeon post-op operative report notes
);

CREATE TABLE tbl_adverse_event_reports (
    event_id                       INT             PRIMARY KEY                                                , -- Event primary key ID
    subject_id                     INT             NOT NULL REFERENCES tbl_trial_subjects(subject_id)         , -- FK to tbl_trial_subjects
    adverse_event_term             VARCHAR(100)    NOT NULL                                                   , -- MedDRA adverse event term
    severity                       VARCHAR(15)     NOT NULL                                                     -- MILD/MODERATE/SEVERE
);

CREATE TABLE tbl_clinical_trials (
    trial_id                       INT             PRIMARY KEY                                                , -- Trial primary key ID
    compound_id                    INT             NOT NULL REFERENCES tbl_drug_compounds(compound_id)        , -- FK to tbl_drug_compounds
    nct_number                     VARCHAR(15)     NOT NULL                                                   , -- ClinicalTrials.gov NCT ID
    trial_phase                    VARCHAR(10)     NOT NULL                                                     -- PHASE_1/PHASE_2/PHASE_3
);

CREATE TABLE tbl_drug_compounds (
    compound_id                    INT             PRIMARY KEY                                                , -- Compound primary key ID
    molecule_code                  VARCHAR(30)     NOT NULL                                                   , -- Internal R&D chemical code
    therapeutic_area               VARCHAR(50)     NOT NULL                                                     -- ONCOLOGY/CARDIOLOGY/NEUROLOGY
);

CREATE TABLE tbl_trial_subjects (
    subject_id                     INT             PRIMARY KEY                                                , -- Subject primary key ID
    trial_id                       INT             NOT NULL REFERENCES tbl_clinical_trials(trial_id)          , -- FK to tbl_clinical_trials
    subject_code                   VARCHAR(20)     NOT NULL                                                   , -- Anonymized subject code
    age_years                      INT             NOT NULL                                                     -- Age in years
);

CREATE TABLE tbl_devices (
    device_id                      INT             PRIMARY KEY                                                , -- Device primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    device_mac                     VARCHAR(17)     NOT NULL                                                   , -- MAC address
    model_name                     VARCHAR(50)     NOT NULL                                                     -- Smartwatch model
);

CREATE TABLE tbl_heartrate_telemetry (
    telemetry_id                   INT             PRIMARY KEY                                                , -- Telemetry primary key ID
    device_id                      INT             NOT NULL REFERENCES tbl_devices(device_id)                 , -- FK to tbl_devices
    bpm_value                      INT             NOT NULL                                                   , -- Beats per minute reading
    recorded_at                    TIMESTAMP       NOT NULL                                                     -- Sensor timestamp
);

CREATE TABLE tbl_sleep_sessions (
    sleep_id                       INT             PRIMARY KEY                                                , -- Sleep primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    deep_sleep_minutes             INT             NOT NULL                                                   , -- Deep sleep stage minutes
    rem_sleep_minutes              INT             NOT NULL                                                     -- REM stage minutes
);

CREATE TABLE tbl_users (
    user_id                        INT             PRIMARY KEY                                                , -- User primary key ID
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- User full name
    weight_kg                      DECIMAL(5,2)    NOT NULL                                                     -- Body weight kg
);

CREATE TABLE tbl_workouts (
    workout_id                     INT             PRIMARY KEY                                                , -- Workout primary key ID
    user_id                        INT             NOT NULL REFERENCES tbl_users(user_id)                     , -- FK to tbl_users
    workout_type                   VARCHAR(30)     NOT NULL                                                   , -- RUNNING/CYCLING/SWIMMING
    duration_minutes               INT             NOT NULL                                                   , -- Active duration
    calories_burned                INT             NOT NULL                                                     -- Burned kilocalories
);

CREATE TABLE tbl_cart_items (
    cart_item_id                   INT             PRIMARY KEY                                                , -- Cart item primary key ID
    cart_id                        INT             NOT NULL REFERENCES tbl_shopping_carts(cart_id)            , -- FK to tbl_shopping_carts
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    quantity                       INT             NOT NULL                                                     -- Cart item count quantity
);

CREATE TABLE tbl_categories (
    category_id                    INT             PRIMARY KEY                                                , -- Category primary key ID
    category_name                  VARCHAR(50)     NOT NULL                                                   , -- Category display name
    category_slug                  VARCHAR(60)     NOT NULL                                                   , -- URL friendly slug
    parent_category_id             INT             NULL REFERENCES tbl_categories(category_id)                , -- Self-referencing parent category
    is_active                      VARCHAR(1)      NOT NULL                                                   , -- Active flag Y/N
    created_at                     TIMESTAMP       NOT NULL                                                     -- Record creation timestamp
);

CREATE TABLE tbl_customer_addresses (
    address_id                     INT             PRIMARY KEY                                                , -- Address primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    address_type                   VARCHAR(20)     NOT NULL                                                   , -- SHIPPING/BILLING
    street_address                 VARCHAR(100)    NOT NULL                                                   , -- Street address line
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State/province code
    postal_code                    VARCHAR(10)     NOT NULL                                                   , -- ZIP or Postal code
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO 3-letter country code
);

CREATE TABLE tbl_customer_support_tickets (
    ticket_id                      INT             PRIMARY KEY                                                , -- Ticket primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    order_id                       INT             NULL REFERENCES tbl_orders(order_id)                       , -- FK to tbl_orders
    ticket_subject                 VARCHAR(100)    NOT NULL                                                   , -- Issue subject title
    ticket_status                  VARCHAR(20)     NOT NULL                                                   , -- OPEN/RESOLVED/CLOSED
    created_at                     TIMESTAMP       NOT NULL                                                     -- Opened timestamp
);

CREATE TABLE tbl_customers (
    customer_id                    INT             PRIMARY KEY                                                , -- Customer primary key ID
    customer_code                  VARCHAR(36)     NOT NULL                                                   , -- Unique tracking code
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Given first name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Family last name
    email                          VARCHAR(100)    NOT NULL                                                   , -- Contact email address
    phone                          VARCHAR(20)     NULL                                                       , -- Telephone contact number
    account_status                 VARCHAR(20)     NOT NULL                                                   , -- ACTIVE/SUSPENDED/CLOSED
    customer_segment               VARCHAR(30)     NOT NULL                                                   , -- RETAIL/WHOLESALE/VIP
    total_spent                    DECIMAL(10,2)   NOT NULL                                                   , -- Lifetime spend amount
    loyalty_points                 INT             NOT NULL                                                   , -- Earned loyalty points
    is_active                      VARCHAR(1)      NOT NULL                                                   , -- Active flag Y/N
    created_at                     TIMESTAMP       NOT NULL                                                   , -- Account creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                     -- Account updated timestamp
);

CREATE TABLE tbl_discounts_promos (
    promo_id                       INT             PRIMARY KEY                                                , -- Promo primary key ID
    promo_code                     VARCHAR(20)     NOT NULL                                                   , -- Unique promo code
    discount_percent               DECIMAL(5,2)    NOT NULL                                                   , -- Discount percentage rate
    start_date                     DATE            NOT NULL                                                   , -- Campaign start date
    end_date                       DATE            NOT NULL                                                   , -- Campaign expiry date
    is_active                      VARCHAR(1)      NOT NULL                                                     -- Active flag Y/N
);

CREATE TABLE tbl_inventory (
    inventory_id                   INT             PRIMARY KEY                                                , -- Inventory record primary key ID
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    warehouse_id                   INT             NOT NULL REFERENCES tbl_warehouses(warehouse_id)           , -- FK to tbl_warehouses
    quantity_on_hand               INT             NOT NULL                                                   , -- Available physical stock
    reserved_quantity              INT             NOT NULL                                                   , -- Allocated pending order stock
    last_updated                   TIMESTAMP       NOT NULL                                                     -- Stock check timestamp
);

CREATE TABLE tbl_invoices (
    invoice_id                     INT             PRIMARY KEY                                                , -- Invoice primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    invoice_number                 VARCHAR(30)     NOT NULL                                                   , -- Tax invoice document number
    invoice_date                   DATE            NOT NULL                                                   , -- Billing issue date
    due_date                       DATE            NOT NULL                                                   , -- Payment due date
    total_amount                   DECIMAL(10,2)   NOT NULL                                                   , -- Total billed amount
    invoice_status                 VARCHAR(15)     NOT NULL                                                     -- PAID/UNPAID/OVERDUE
);

CREATE TABLE tbl_order_items (
    order_item_id                  INT             PRIMARY KEY                                                , -- Order line item primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    unit_price                     DECIMAL(10,2)   NOT NULL                                                   , -- Sold price per unit
    quantity                       INT             NOT NULL                                                   , -- Purchased item quantity
    subtotal                       DECIMAL(10,2)   NOT NULL                                                     -- Calculated line item subtotal
);

CREATE TABLE tbl_orders (
    order_id                       INT             PRIMARY KEY                                                , -- Order primary key ID
    order_number                   VARCHAR(36)     NOT NULL                                                   , -- Unique transaction order number
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    order_date                     TIMESTAMP       NOT NULL                                                   , -- Order placement timestamp
    order_status                   VARCHAR(20)     NOT NULL                                                   , -- PENDING/PROCESSING/SHIPPED/DELIVERED/CANCELLED
    total_amount                   DECIMAL(10,2)   NOT NULL                                                   , -- Gross order total
    tax_amount                     DECIMAL(10,2)   NOT NULL                                                   , -- Applied tax amount
    shipping_fee                   DECIMAL(10,2)   NOT NULL                                                   , -- Shipping charge fee
    created_at                     TIMESTAMP       NOT NULL                                                     -- Record creation timestamp
);

CREATE TABLE tbl_payments (
    payment_id                     INT             PRIMARY KEY                                                , -- Payment primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    payment_method                 VARCHAR(20)     NOT NULL                                                   , -- CREDIT_CARD/PAYPAL/WIRE
    payment_status                 VARCHAR(15)     NOT NULL                                                   , -- COMPLETED/PENDING/FAILED
    amount                         DECIMAL(10,2)   NOT NULL                                                   , -- Processed payment amount
    transaction_ref                VARCHAR(36)     NOT NULL                                                   , -- Gateway transaction reference
    payment_date                   TIMESTAMP       NOT NULL                                                     -- Execution timestamp
);

CREATE TABLE tbl_product_attributes (
    attribute_id                   INT             PRIMARY KEY                                                , -- Attribute primary key ID
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    attribute_name                 VARCHAR(50)     NOT NULL                                                   , -- Color/Size/Weight
    attribute_value                VARCHAR(50)     NOT NULL                                                     -- Attribute value string
);

CREATE TABLE tbl_product_reviews (
    review_id                      INT             PRIMARY KEY                                                , -- Review primary key ID
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    rating_score                   INT             NOT NULL                                                   , -- Rating 1-5 stars
    review_text                    TEXT            NULL                                                       , -- Customer feedback review
    created_at                     TIMESTAMP       NOT NULL                                                     -- Review submission timestamp
);

CREATE TABLE tbl_products (
    product_id                     INT             PRIMARY KEY                                                , -- Product primary key ID
    sku                            VARCHAR(30)     NOT NULL                                                   , -- Stock Keeping Unit SKU
    product_name                   VARCHAR(100)    NOT NULL                                                   , -- Product catalog title
    category_id                    INT             NOT NULL REFERENCES tbl_categories(category_id)            , -- FK to tbl_categories
    supplier_id                    INT             NOT NULL REFERENCES tbl_suppliers(supplier_id)             , -- FK to tbl_suppliers
    unit_price                     DECIMAL(10,2)   NOT NULL                                                   , -- Standard retail price
    cost_price                     DECIMAL(10,2)   NOT NULL                                                   , -- Wholesale cost price
    product_status                 VARCHAR(20)     NOT NULL                                                   , -- ACTIVE/DISCONTINUED/OUT_OF_STOCK
    created_at                     TIMESTAMP       NOT NULL                                                     -- Catalog entry timestamp
);

CREATE TABLE tbl_return_requests (
    return_id                      INT             PRIMARY KEY                                                , -- Return request primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    return_reason                  VARCHAR(100)    NOT NULL                                                   , -- Reason for return
    return_status                  VARCHAR(20)     NOT NULL                                                   , -- REQUESTED/APPROVED/REJECTED
    created_at                     TIMESTAMP       NOT NULL                                                     -- Request timestamp
);

CREATE TABLE tbl_shipments (
    shipment_id                    INT             PRIMARY KEY                                                , -- Shipment primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_orders(order_id)                   , -- FK to tbl_orders
    tracking_number                VARCHAR(40)     NOT NULL                                                   , -- Carrier tracking code
    carrier_name                   VARCHAR(30)     NOT NULL                                                   , -- UPS/FEDEX/DHL
    shipped_date                   TIMESTAMP       NULL                                                       , -- Dispatch timestamp
    delivery_date                  TIMESTAMP       NULL                                                       , -- Delivery timestamp
    shipment_status                VARCHAR(20)     NOT NULL                                                     -- IN_TRANSIT/DELIVERED/RETURNED
);

CREATE TABLE tbl_shopping_carts (
    cart_id                        INT             PRIMARY KEY                                                , -- Cart primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    created_at                     TIMESTAMP       NOT NULL                                                   , -- Cart creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                     -- Cart modified timestamp
);

CREATE TABLE tbl_suppliers (
    supplier_id                    INT             PRIMARY KEY                                                , -- Supplier primary key ID
    company_name                   VARCHAR(100)    NOT NULL                                                   , -- Supplier corporate name
    contact_name                   VARCHAR(60)     NOT NULL                                                   , -- Primary account manager
    email                          VARCHAR(100)    NOT NULL                                                   , -- Corporate email address
    phone                          VARCHAR(20)     NOT NULL                                                   , -- Corporate contact phone
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO 3-letter country code
);

CREATE TABLE tbl_system_audit_logs (
    log_id                         INT             PRIMARY KEY                                                , -- Audit log primary key ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Operator user string ID
    action_name                    VARCHAR(50)     NOT NULL                                                   , -- Action performed
    target_entity                  VARCHAR(50)     NOT NULL                                                   , -- Target table name
    created_at                     TIMESTAMP       NOT NULL                                                     -- Audit timestamp
);

CREATE TABLE tbl_warehouses (
    warehouse_id                   INT             PRIMARY KEY                                                , -- Warehouse primary key ID
    warehouse_code                 VARCHAR(20)     NOT NULL                                                   , -- Unique warehouse location code
    warehouse_name                 VARCHAR(80)     NOT NULL                                                   , -- Facility designation name
    city                           VARCHAR(50)     NOT NULL                                                   , -- Facility location city
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State/Province code
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO 3-letter country code
);

CREATE TABLE tbl_wishlists (
    wishlist_id                    INT             PRIMARY KEY                                                , -- Wishlist primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- FK to tbl_customers
    product_id                     INT             NOT NULL REFERENCES tbl_products(product_id)               , -- FK to tbl_products
    added_at                       TIMESTAMP       NOT NULL                                                     -- Addition timestamp
);

CREATE TABLE tbl_accounts (
    account_id                     INT             PRIMARY KEY                                                , -- Account primary key ID
    account_number                 VARCHAR(20)     NOT NULL                                                   , -- Unique bank account number
    customer_id                    INT             NOT NULL REFERENCES tbl_customers(customer_id)             , -- Parent customer ID
    account_type                   VARCHAR(20)     NOT NULL                                                   , -- CHECKING/SAVINGS/MONEY_MARKET
    currency_code                  VARCHAR(3)      NOT NULL                                                   , -- ISO currency code USD/EUR
    current_balance                DECIMAL(12,2)   NOT NULL                                                   , -- Current account balance
    available_balance              DECIMAL(12,2)   NOT NULL                                                   , -- Available account balance
    status_code                    VARCHAR(10)     NOT NULL                                                   , -- ACTIVE/CLOSED/FROZEN
    created_at                     TIMESTAMP       NOT NULL                                                     -- Account creation timestamp
);

CREATE TABLE tbl_audit_logs (
    log_id                         INT             PRIMARY KEY                                                , -- Audit log primary key ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Operator user or system ID
    action_type                    VARCHAR(30)     NOT NULL                                                   , -- LOGIN/TRANSFER/UPDATE_LIMIT
    entity_name                    VARCHAR(40)     NOT NULL                                                   , -- Target entity table
    entity_id                      INT             NOT NULL                                                   , -- Target entity record ID
    ip_address                     VARCHAR(45)     NOT NULL                                                   , -- Client IP address
    log_timestamp                  TIMESTAMP       NOT NULL                                                   , -- Audit log timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- SUCCESS/DENIED
);

CREATE TABLE tbl_branches (
    branch_id                      INT             PRIMARY KEY                                                , -- Branch primary key ID
    branch_code                    VARCHAR(10)     NOT NULL                                                   , -- Unique branch location code
    branch_name                    VARCHAR(60)     NOT NULL                                                   , -- Branch designation name
    address_line                   VARCHAR(100)    NOT NULL                                                   , -- Street address line
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State postal code
    postal_code                    VARCHAR(10)     NOT NULL                                                   , -- ZIP/Postal code
    manager_name                   VARCHAR(60)     NOT NULL                                                   , -- Branch manager name
    status_code                    VARCHAR(10)     NOT NULL                                                     -- OPEN/CLOSED/REMODEL
);

CREATE TABLE tbl_credit_cards (
    card_id                        INT             PRIMARY KEY                                                , -- Credit card primary key ID
    account_id                     INT             NOT NULL REFERENCES tbl_accounts(account_id)               , -- Associated checking/card account ID
    card_number_masked             VARCHAR(19)     NOT NULL                                                   , -- Masked credit card number
    card_type                      VARCHAR(20)     NOT NULL                                                   , -- VISA/MASTERCARD/AMEX
    credit_limit                   DECIMAL(10,2)   NOT NULL                                                   , -- Approved credit limit
    current_balance                DECIMAL(10,2)   NOT NULL                                                   , -- Current statement balance
    expiry_date                    VARCHAR(7)      NOT NULL                                                   , -- Expiration date MM/YYYY
    is_active                      VARCHAR(1)      NOT NULL                                                   , -- Active flag Y/N
    status_code                    VARCHAR(15)     NOT NULL                                                     -- ISSUED/BLOCKED/EXPIRED
);

CREATE TABLE tbl_customers_finance (
    customer_id                    INT             PRIMARY KEY                                                , -- Customer primary key ID
    tax_identifier                 VARCHAR(11)     NOT NULL                                                   , -- SSN or Tax ID number
    first_name                     VARCHAR(50)     NOT NULL                                                   , -- Customer given name
    last_name                      VARCHAR(50)     NOT NULL                                                   , -- Customer family name
    email_address                  VARCHAR(100)    NOT NULL                                                   , -- Primary email contact
    phone_number                   VARCHAR(20)     NOT NULL                                                   , -- Primary phone contact
    kyc_status                     VARCHAR(15)     NOT NULL                                                   , -- VERIFIED/PENDING/REJECTED
    risk_rating                    VARCHAR(10)     NOT NULL                                                   , -- LOW/MEDIUM/HIGH
    created_at                     TIMESTAMP       NOT NULL                                                     -- Customer onboarding timestamp
);
