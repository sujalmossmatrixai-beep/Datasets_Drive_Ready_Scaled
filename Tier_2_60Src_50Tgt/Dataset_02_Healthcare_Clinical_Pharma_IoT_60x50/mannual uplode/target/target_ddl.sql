-- ========================================================
-- Master DDL Schema Script for Dataset_02_Healthcare_Clinical_Pharma_IoT_60x50_target
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 50
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_14_Fitness_Wearable_IoT_Dataset, Dataset_18_Hospital_EMR_Clinical_Patient_Dataset, Dataset_22_Pharmaceutical_Clinical_RND_Dataset
-- ========================================================

CREATE TABLE fhir_account_billing (
    billing_account_key            BIGINT          PRIMARY KEY                                                , -- Billing account surrogate key
    source_billing_id              INT             NOT NULL                                                   , -- Source natural billing ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    total_gross_charge_usd         NUMERIC(10,2)   NOT NULL                                                   , -- Gross medical charge USD
    amount_paid_usd                NUMERIC(10,2)   NOT NULL                                                   , -- Settled amount USD
    balance_usd                    NUMERIC(10,2)   NOT NULL                                                   , -- Balance due USD
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Account status
);

CREATE TABLE fhir_appointment (
    appointment_key                BIGINT          PRIMARY KEY                                                , -- Appointment surrogate key
    source_appointment_id          INT             NOT NULL                                                   , -- Source natural appointment ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    practitioner_key               BIGINT          NOT NULL REFERENCES fhir_practitioner(practitioner_key)    , -- FK to fhir_practitioner
    dept_key                       BIGINT          NOT NULL REFERENCES fhir_organization_dept(dept_key)       , -- FK to fhir_organization_dept
    start_timestamp                TIMESTAMP       NOT NULL                                                   , -- Scheduled start timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Appointment status
);

CREATE TABLE fhir_audit_event (
    audit_event_key                BIGINT          PRIMARY KEY                                                , -- Audit event surrogate key
    source_log_id                  INT             NOT NULL                                                   , -- Source natural log ID
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Clinician user ID
    action_code                    VARCHAR(30)     NOT NULL                                                   , -- Action performed
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    event_timestamp                TIMESTAMP       NOT NULL                                                     -- Event ISO timestamp
);

CREATE TABLE fhir_claim (
    claim_key                      BIGINT          PRIMARY KEY                                                , -- Claim surrogate key
    source_claim_id                INT             NOT NULL                                                   , -- Source natural claim ID
    billing_account_key            BIGINT          NOT NULL REFERENCES fhir_account_billing(billing_account_key) , -- FK to fhir_account_billing
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    payer_name                     VARCHAR(80)     NOT NULL                                                   , -- Health insurance payer
    total_claimed_usd              NUMERIC(10,2)   NOT NULL                                                   , -- Claimed total USD
    total_covered_usd              NUMERIC(10,2)   NOT NULL                                                   , -- Approved covered USD
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Claim status
);

CREATE TABLE fhir_condition_diagnosis (
    condition_key                  BIGINT          PRIMARY KEY                                                , -- Condition surrogate key
    source_diagnosis_id            INT             NOT NULL                                                   , -- Source natural diagnosis ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    icd10_code                     VARCHAR(20)     NOT NULL                                                   , -- ICD-10 clinical code
    condition_display              VARCHAR(100)    NOT NULL                                                   , -- Condition display title
    onset_date                     DATE            NOT NULL                                                     -- Condition onset date
);

CREATE TABLE fhir_encounter (
    encounter_key                  BIGINT          PRIMARY KEY                                                , -- Encounter surrogate key
    source_encounter_id            INT             NOT NULL                                                   , -- Source natural encounter ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    practitioner_key               BIGINT          NOT NULL REFERENCES fhir_practitioner(practitioner_key)    , -- FK to fhir_practitioner
    dept_key                       BIGINT          NOT NULL REFERENCES fhir_organization_dept(dept_key)       , -- FK to fhir_organization_dept
    encounter_class                VARCHAR(20)     NOT NULL                                                   , -- Encounter classification
    period_start                   TIMESTAMP       NOT NULL                                                   , -- Encounter period start
    period_end                     TIMESTAMP       NULL                                                       , -- Encounter period end
    status_code                    VARCHAR(15)     NOT NULL                                                     -- FHIR status code
);

CREATE TABLE fhir_family_member_history (
    fam_hist_key                   BIGINT          PRIMARY KEY                                                , -- Family history surrogate key
    source_history_id              INT             NOT NULL                                                   , -- Source natural history ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    condition_display              VARCHAR(100)    NOT NULL                                                   , -- Condition display name
    onset_date                     DATE            NOT NULL                                                     -- Onset date
);

CREATE TABLE fhir_immunization (
    immunization_key               BIGINT          PRIMARY KEY                                                , -- Immunization surrogate key
    source_immunization_id         INT             NOT NULL                                                   , -- Source natural immunization ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    vaccine_code                   VARCHAR(20)     NOT NULL                                                   , -- CVX vaccine code
    vaccine_display                VARCHAR(100)    NOT NULL                                                   , -- Vaccine display title
    occurrence_date                DATE            NOT NULL                                                     -- Administered date
);

CREATE TABLE fhir_location_bed (
    location_key                   BIGINT          PRIMARY KEY                                                , -- Location surrogate key
    source_allocation_id           INT             NOT NULL                                                   , -- Source natural allocation ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    room_name                      VARCHAR(20)     NOT NULL                                                   , -- Room designation
    bed_name                       VARCHAR(10)     NOT NULL                                                   , -- Bed designation
    start_timestamp                TIMESTAMP       NOT NULL                                                     -- Assignment start timestamp
);

CREATE TABLE fhir_medication_inventory (
    med_inv_key                    BIGINT          PRIMARY KEY                                                , -- Medication inventory surrogate key
    source_inventory_id            INT             NOT NULL                                                   , -- Source natural inventory ID
    ndc_code                       VARCHAR(20)     NOT NULL                                                   , -- NDC code
    medication_display             VARCHAR(100)    NOT NULL                                                   , -- Medication trade name
    stock_quantity                 INT             NOT NULL                                                   , -- Stock count
    reorder_threshold              INT             NOT NULL                                                     -- Reorder threshold
);

CREATE TABLE fhir_medication_request (
    med_req_key                    BIGINT          PRIMARY KEY                                                , -- Medication request surrogate key
    source_prescription_id         INT             NOT NULL                                                   , -- Source natural prescription ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    practitioner_key               BIGINT          NOT NULL REFERENCES fhir_practitioner(practitioner_key)    , -- FK to fhir_practitioner
    rxnorm_code                    VARCHAR(20)     NOT NULL                                                   , -- RxNorm medication code
    medication_display             VARCHAR(100)    NOT NULL                                                   , -- Medication display name
    dosage_instruction             VARCHAR(100)    NOT NULL                                                   , -- Dosage instruction text
    authored_on                    DATE            NOT NULL                                                     -- Prescription order date
);

CREATE TABLE fhir_observation_lab (
    obs_lab_key                    BIGINT          PRIMARY KEY                                                , -- Lab observation surrogate key
    source_lab_result_id           INT             NOT NULL                                                   , -- Source natural lab result ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    loinc_code                     VARCHAR(20)     NOT NULL                                                   , -- LOINC lab code
    observation_display            VARCHAR(100)    NOT NULL                                                   , -- Lab test display name
    value_quantity                 NUMERIC(10,2)   NOT NULL                                                   , -- Lab reading value
    unit_code                      VARCHAR(20)     NOT NULL                                                   , -- Unit of measure
    issued_timestamp               TIMESTAMP       NOT NULL                                                     -- Issue timestamp
);

CREATE TABLE fhir_observation_vitals (
    obs_vital_key                  BIGINT          PRIMARY KEY                                                , -- Vital sign surrogate key
    source_vital_id                INT             NOT NULL                                                   , -- Source natural vital ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    vital_display                  VARCHAR(30)     NOT NULL                                                   , -- Vital display category
    value_quantity                 NUMERIC(8,2)    NOT NULL                                                   , -- Measurement reading
    unit_code                      VARCHAR(20)     NOT NULL                                                   , -- Unit code
    effective_timestamp            TIMESTAMP       NOT NULL                                                     -- Observation timestamp
);

CREATE TABLE fhir_organization_dept (
    dept_key                       BIGINT          PRIMARY KEY                                                , -- Organization surrogate key
    source_department_id           INT             NOT NULL                                                   , -- Source natural department ID
    dept_name                      VARCHAR(60)     NOT NULL                                                   , -- Department designation
    facility_name                  VARCHAR(80)     NOT NULL                                                     -- Hospital facility complex
);

CREATE TABLE fhir_patient (
    fhir_patient_key               BIGINT          PRIMARY KEY                                                , -- FHIR patient surrogate key
    source_patient_id              INT             NOT NULL                                                   , -- Source natural patient ID
    mrn_identifier                 VARCHAR(30)     NOT NULL                                                   , -- Medical Record Number MRN
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full patient name
    gender_code                    VARCHAR(1)      NOT NULL                                                   , -- Administrative gender (M/F/U)
    birth_date                     DATE            NOT NULL                                                   , -- Patient date of birth
    city_name                      VARCHAR(50)     NOT NULL                                                   , -- City location
    state_code                     VARCHAR(5)      NOT NULL                                                   , -- State/province code
    is_active                      BOOLEAN         NOT NULL                                                     -- FHIR active record flag
);

CREATE TABLE fhir_patient_contact (
    contact_key                    BIGINT          PRIMARY KEY                                                , -- Patient contact surrogate key
    source_contact_id              INT             NOT NULL                                                   , -- Source natural contact ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    contact_name                   VARCHAR(60)     NOT NULL                                                   , -- Contact full name
    relationship_code              VARCHAR(30)     NOT NULL                                                   , -- Relationship type
    telecom_phone                  VARCHAR(20)     NOT NULL                                                     -- Contact phone
);

CREATE TABLE fhir_practitioner (
    practitioner_key               BIGINT          PRIMARY KEY                                                , -- Practitioner surrogate key
    source_physician_id            INT             NOT NULL                                                   , -- Source natural physician ID
    npi_number                     VARCHAR(10)     NOT NULL                                                   , -- National Provider Identifier NPI
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Practitioner full name
    specialty_name                 VARCHAR(60)     NOT NULL                                                   , -- Medical specialty
    dept_key                       BIGINT          NOT NULL REFERENCES fhir_organization_dept(dept_key)         -- FK to fhir_organization_dept
);

CREATE TABLE fhir_practitioner_role (
    role_key                       BIGINT          PRIMARY KEY                                                , -- Practitioner role surrogate key
    source_staff_id                INT             NOT NULL                                                   , -- Source natural staff ID
    practitioner_key               BIGINT          NULL REFERENCES fhir_practitioner(practitioner_key)        , -- FK to fhir_practitioner
    dept_key                       BIGINT          NOT NULL REFERENCES fhir_organization_dept(dept_key)       , -- FK to fhir_organization_dept
    role_code                      VARCHAR(50)     NOT NULL                                                     -- Staff role designation
);

CREATE TABLE fhir_procedure (
    procedure_key                  BIGINT          PRIMARY KEY                                                , -- Procedure surrogate key
    source_procedure_id            INT             NOT NULL                                                   , -- Source natural procedure ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    practitioner_key               BIGINT          NOT NULL REFERENCES fhir_practitioner(practitioner_key)    , -- FK to fhir_practitioner
    cpt_code                       VARCHAR(20)     NOT NULL                                                   , -- CPT procedure code
    procedure_display              VARCHAR(100)    NOT NULL                                                   , -- Procedure display title
    performed_date                 DATE            NOT NULL                                                     -- Performed date
);

CREATE TABLE fhir_service_request (
    service_req_key                BIGINT          PRIMARY KEY                                                , -- Service request surrogate key
    source_lab_order_id            INT             NOT NULL                                                   , -- Source natural lab order ID
    patient_key                    BIGINT          NOT NULL REFERENCES fhir_patient(fhir_patient_key)         , -- FK to fhir_patient
    encounter_key                  BIGINT          NOT NULL REFERENCES fhir_encounter(encounter_key)          , -- FK to fhir_encounter
    practitioner_key               BIGINT          NOT NULL REFERENCES fhir_practitioner(practitioner_key)    , -- FK to fhir_practitioner
    loinc_code                     VARCHAR(20)     NOT NULL                                                   , -- LOINC concept code
    service_display                VARCHAR(100)    NOT NULL                                                   , -- Service display title
    authored_on                    TIMESTAMP       NOT NULL                                                   , -- Order timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Status code
);

CREATE TABLE dim_patient_demographics (
    patient_key                    BIGINT          PRIMARY KEY                                              , -- Surrogate key for patient dimension
    source_patient_id              INT             NOT NULL                                                 , -- Natural patient ID from source
    mrn_number                     VARCHAR(20)     NOT NULL                                                 , -- Medical Record Number
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Patient full name
    date_of_birth                  DATE            NOT NULL                                                 , -- Date of birth
    gender                         VARCHAR(15)     NOT NULL                                                 , -- MALE, FEMALE, OTHER
    blood_type                     VARCHAR(5)      NOT NULL                                                 , -- ABO Rh blood group
    primary_phone                  VARCHAR(20)     NOT NULL                                                 , -- Contact phone
    email_address                  VARCHAR(100)    NOT NULL                                                 , -- Email contact
    address_street                 VARCHAR(100)    NOT NULL                                                 , -- Street address
    city                           VARCHAR(50)     NOT NULL                                                 , -- City name
    state_code                     VARCHAR(2)      NOT NULL                                                 , -- State postal code
    postal_code                    VARCHAR(10)     NOT NULL                                                 , -- ZIP code
    insurance_provider_name        VARCHAR(80)     NOT NULL                                                 , -- Health insurance carrier
    insurance_policy_number        VARCHAR(30)     NOT NULL                                                 , -- Insurance policy ID
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current_record              BOOLEAN         NOT NULL                                                 , -- SCD Type 2 current record flag
    etl_batch_id                   INT             NOT NULL                                                 , -- ETL batch processing ID
    notes                          VARCHAR(150)    NOT NULL                                                   -- Patient chart notes
);

CREATE TABLE dim_physician_provider (
    physician_key                  BIGINT          PRIMARY KEY                                              , -- Surrogate key for physician dimension
    source_physician_id            INT             NOT NULL                                                 , -- Natural physician ID from source
    npi_number                     VARCHAR(15)     NOT NULL                                                 , -- National Provider Identifier NPI
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Physician full name
    medical_specialty              VARCHAR(50)     NOT NULL                                                 , -- CARDIOLOGY, SURGERY, INTERNAL_MED
    department_name                VARCHAR(50)     NOT NULL                                                 , -- Hospital department ward
    medical_license_number         VARCHAR(20)     NOT NULL                                                 , -- State medical license ID
    years_of_practice              INT             NOT NULL                                                 , -- Years practicing medicine
    office_phone                   VARCHAR(20)     NOT NULL                                                 , -- Clinic office telephone
    email_address                  VARCHAR(100)    NOT NULL                                                 , -- Professional medical email
    hospital_privilege_status      VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, CONSULTING, ACTIVE
    medical_school_graduated       VARCHAR(80)     NOT NULL                                                 , -- Medical university school
    is_board_certified             BOOLEAN         NOT NULL                                                 , -- Board certified specialist flag
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current                     BOOLEAN         NOT NULL                                                 , -- Current record flag
    etl_batch_id                   INT             NOT NULL                                                 , -- ETL batch processing ID
    notes                          VARCHAR(150)    NOT NULL                                                   -- Physician credentialing comments
);

CREATE TABLE fact_hospital_admissions (
    admission_fact_key             BIGINT          PRIMARY KEY                                              , -- Surrogate key for admission fact
    patient_key                    BIGINT          NOT NULL REFERENCES dim_patient_demographics(patient_key), -- FK to dim_patient_demographics
    attending_physician_key        BIGINT          NOT NULL REFERENCES dim_physician_provider(physician_key), -- FK to dim_physician_provider
    admission_timestamp            TIMESTAMP       NOT NULL                                                 , -- Admission timestamp key
    discharge_timestamp            TIMESTAMP       NOT NULL                                                 , -- Discharge timestamp key
    length_of_stay_days            INT             NOT NULL                                                 , -- Inpatient stay days
    admission_type                 VARCHAR(30)     NOT NULL                                                 , -- Admission classification
    primary_diagnosis_code         VARCHAR(15)     NOT NULL                                                 , -- ICD-10 primary code
    discharge_disposition          VARCHAR(40)     NOT NULL                                                 , -- Discharge disposition text
    total_billed_usd               NUMERIC(12,2)   NOT NULL                                                 , -- Total billed USD
    insurance_covered_usd          NUMERIC(12,2)   NOT NULL                                                 , -- Insurance covered USD
    patient_copay_usd              NUMERIC(10,2)   NOT NULL                                                 , -- Patient copay USD
    readmission_30day_flag         BOOLEAN         NOT NULL                                                 , -- 30-day readmit flag
    emergency_flag                 BOOLEAN         NOT NULL                                                 , -- Emergency flag
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- Admission status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_lab_test_results (
    lab_fact_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for lab fact
    patient_key                    BIGINT          NOT NULL REFERENCES dim_patient_demographics(patient_key), -- FK to dim_patient_demographics
    ordering_physician_key         BIGINT          NOT NULL REFERENCES dim_physician_provider(physician_key), -- FK to dim_physician_provider
    order_timestamp                TIMESTAMP       NOT NULL                                                 , -- Order timestamp
    result_timestamp               TIMESTAMP       NOT NULL                                                 , -- Result timestamp
    test_code                      VARCHAR(20)     NOT NULL                                                 , -- LOINC code
    test_name                      VARCHAR(80)     NOT NULL                                                 , -- Test name
    test_result_value              NUMERIC(10,2)   NOT NULL                                                 , -- Result value numeric
    result_unit                    VARCHAR(20)     NOT NULL                                                 , -- Unit string
    is_abnormal_flag               BOOLEAN         NOT NULL                                                 , -- Abnormal result flag
    test_cost_usd                  NUMERIC(8,2)    NOT NULL                                                 , -- Test cost USD
    turnaround_minutes             INT             NOT NULL                                                 , -- Lab turnaround time in minutes
    lab_status                     VARCHAR(20)     NOT NULL                                                 , -- Lab status text
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_medication_administrations (
    rx_fact_key                    BIGINT          PRIMARY KEY                                              , -- Surrogate key for medication fact
    patient_key                    BIGINT          NOT NULL REFERENCES dim_patient_demographics(patient_key), -- FK to dim_patient_demographics
    prescribing_physician_key      BIGINT          NOT NULL REFERENCES dim_physician_provider(physician_key), -- FK to dim_physician_provider
    drug_code_ndc                  VARCHAR(20)     NOT NULL                                                 , -- NDC code
    medication_name                VARCHAR(80)     NOT NULL                                                 , -- Medication name
    start_date                     DATE            NOT NULL                                                 , -- Rx start date
    end_date                       DATE            NOT NULL                                                 , -- Rx end date
    duration_days                  INT             NOT NULL                                                 , -- Duration in days
    dosage_mg                      NUMERIC(8,2)    NOT NULL                                                 , -- Dose mg
    dispensed_quantity             INT             NOT NULL                                                 , -- Dispensed unit count
    pharmacy_cost_usd              NUMERIC(8,2)    NOT NULL                                                 , -- Cost USD
    is_controlled_flag             BOOLEAN         NOT NULL                                                 , -- Controlled substance flag
    prescription_status            VARCHAR(25)     NOT NULL                                                 , -- Rx status text
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_clinical_trial (
    trial_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_trial_id                INT             NOT NULL                                                   , -- Natural ID
    compound_key                   BIGINT          NOT NULL REFERENCES dim_compound(compound_key)             , -- FK to dim_compound
    nct_number                     VARCHAR(15)     NOT NULL                                                     -- NCT ID
);

CREATE TABLE dim_compound (
    compound_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_compound_id             INT             NOT NULL                                                   , -- Natural ID
    molecule_code                  VARCHAR(30)     NOT NULL                                                     -- Code
);

CREATE TABLE fact_adverse_events (
    event_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    trial_key                      BIGINT          NOT NULL REFERENCES dim_clinical_trial(trial_key)          , -- FK to dim_clinical_trial
    severity                       VARCHAR(15)     NOT NULL                                                     -- Severity
);

CREATE TABLE dim_device (
    device_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_device_id               INT             NOT NULL                                                   , -- Natural ID
    model_name                     VARCHAR(50)     NOT NULL                                                     -- Model name
);

CREATE TABLE dim_user (
    user_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_user_id                 INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE fact_telemetry_reads (
    telemetry_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    device_key                     BIGINT          NOT NULL REFERENCES dim_device(device_key)                 , -- FK to dim_device
    bpm_value                      INT             NOT NULL                                                     -- BPM
);

CREATE TABLE fact_workout_summary (
    workout_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    user_key                       BIGINT          NOT NULL REFERENCES dim_user(user_key)                     , -- FK to dim_user
    calories_burned                INT             NOT NULL                                                     -- Calories burned
);

CREATE TABLE dim_categories (
    dim_cat_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_category_id             INT             NOT NULL                                                   , -- Natural source ID
    category_name                  VARCHAR(50)     NOT NULL                                                   , -- Category name
    parent_category_name           VARCHAR(50)     NULL                                                         -- Parent category name
);

CREATE TABLE dim_customer_addresses (
    dim_addr_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    address_type                   VARCHAR(20)     NOT NULL                                                   , -- Address classification
    city_name                      VARCHAR(50)     NOT NULL                                                   , -- City name
    state_province                 VARCHAR(50)     NOT NULL                                                   , -- State/Province
    country_code_iso2              VARCHAR(2)      NOT NULL                                                     -- Country code
);

CREATE TABLE dim_customers (
    dim_cust_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_customer_id             INT             NOT NULL                                                   , -- Natural source ID
    customer_code                  VARCHAR(36)     NOT NULL                                                   , -- Tracking code
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full customer name
    email_address                  VARCHAR(100)    NOT NULL                                                   , -- Email contact
    phone_number                   VARCHAR(20)     NULL                                                       , -- Phone number
    account_status                 VARCHAR(20)     NOT NULL                                                   , -- Status code
    is_active                      BOOLEAN         NOT NULL                                                   , -- Active indicator
    created_timestamp              TIMESTAMP       NOT NULL                                                     -- DW record timestamp
);

CREATE TABLE dim_product_attributes (
    dim_attr_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    attribute_name                 VARCHAR(50)     NOT NULL                                                   , -- Attribute name
    attribute_value                VARCHAR(50)     NOT NULL                                                     -- Attribute value
);

CREATE TABLE dim_products (
    dim_prod_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_product_id              INT             NOT NULL                                                   , -- Natural source ID
    sku                            VARCHAR(30)     NOT NULL                                                   , -- Product SKU
    product_name                   VARCHAR(100)    NOT NULL                                                   , -- Product title
    category_key                   BIGINT          NOT NULL REFERENCES dim_categories(dim_cat_key)            , -- FK to dim_categories
    supplier_key                   BIGINT          NOT NULL REFERENCES dim_suppliers(dim_supp_key)            , -- FK to dim_suppliers
    unit_price_usd                 NUMERIC(10,2)   NOT NULL                                                     -- Standard unit price
);

CREATE TABLE dim_promotions (
    dim_promo_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_promo_id                INT             NOT NULL                                                   , -- Natural source ID
    promo_code                     VARCHAR(20)     NOT NULL                                                   , -- Promo code
    discount_percent               NUMERIC(5,2)    NOT NULL                                                     -- Discount rate
);

CREATE TABLE dim_suppliers (
    dim_supp_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_supplier_id             INT             NOT NULL                                                   , -- Natural source ID
    company_name                   VARCHAR(100)    NOT NULL                                                   , -- Supplier company name
    country_code_iso2              VARCHAR(2)      NOT NULL                                                     -- ISO country code
);

CREATE TABLE dim_warehouses (
    dim_wh_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_warehouse_id            INT             NOT NULL                                                   , -- Natural source ID
    warehouse_code                 VARCHAR(20)     NOT NULL                                                   , -- Warehouse code
    warehouse_name                 VARCHAR(80)     NOT NULL                                                   , -- Warehouse name
    city_name                      VARCHAR(50)     NOT NULL                                                     -- Facility city
);

CREATE TABLE fact_audit_events (
    fact_audit_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- User string
    action_name                    VARCHAR(50)     NOT NULL                                                   , -- Action performed
    target_entity                  VARCHAR(50)     NOT NULL                                                     -- Target entity
);

CREATE TABLE fact_inventory_snapshot (
    fact_inv_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    warehouse_key                  BIGINT          NOT NULL REFERENCES dim_warehouses(dim_wh_key)             , -- FK to dim_warehouses
    quantity_on_hand               INT             NOT NULL                                                   , -- Physical stock count
    reserved_quantity              INT             NOT NULL                                                     -- Reserved stock count
);

CREATE TABLE fact_invoices (
    fact_invoice_key               BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    invoice_number                 VARCHAR(30)     NOT NULL                                                   , -- Invoice document number
    total_amount_usd               NUMERIC(12,2)   NOT NULL                                                     -- Billed total USD
);

CREATE TABLE fact_order_line_items (
    fact_item_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    unit_price_usd                 NUMERIC(10,2)   NOT NULL                                                   , -- Sold price USD
    quantity                       INT             NOT NULL                                                   , -- Unit count
    subtotal_usd                   NUMERIC(12,2)   NOT NULL                                                     -- Subtotal USD
);

CREATE TABLE fact_orders (
    fact_order_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    source_order_id                INT             NOT NULL                                                   , -- Natural source ID
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    order_number                   VARCHAR(36)     NOT NULL                                                   , -- Order number
    order_date                     TIMESTAMP       NOT NULL                                                   , -- Order date
    order_status                   VARCHAR(20)     NOT NULL                                                   , -- Order status
    total_amount_usd               NUMERIC(12,2)   NOT NULL                                                     -- Gross order total USD
);

CREATE TABLE fact_payments (
    fact_payment_key               BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    payment_method                 VARCHAR(20)     NOT NULL                                                   , -- Method name
    amount_usd                     NUMERIC(12,2)   NOT NULL                                                     -- Payment amount USD
);

CREATE TABLE fact_product_reviews (
    fact_review_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    rating_score                   INT             NOT NULL                                                     -- Rating score 1-5
);

CREATE TABLE fact_return_requests (
    fact_return_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)             , -- FK to dim_products
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    return_status                  VARCHAR(20)     NOT NULL                                                     -- Return status
);

CREATE TABLE fact_shipments (
    fact_shipment_key              BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    fact_order_key                 BIGINT          NOT NULL REFERENCES fact_orders(fact_order_key)            , -- FK to fact_orders
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    carrier_name                   VARCHAR(30)     NOT NULL                                                   , -- Carrier name
    tracking_number                VARCHAR(40)     NOT NULL                                                   , -- Tracking code
    shipment_status                VARCHAR(20)     NOT NULL                                                     -- Shipment status
);

CREATE TABLE fact_shopping_carts (
    fact_cart_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)              -- FK to dim_customers
);
