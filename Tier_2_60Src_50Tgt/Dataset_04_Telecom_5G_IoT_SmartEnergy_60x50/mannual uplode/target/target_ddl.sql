-- ========================================================
-- Master DDL Schema Script for Dataset_04_Telecom_5G_IoT_SmartEnergy_60x50_target
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 50
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_12_Energy_Smart_Grid_Dataset, Dataset_14_Fitness_Wearable_IoT_Dataset, Dataset_28_Telecom_Cellular_Dataset, Dataset_29_Telecommunications_5G_Network_Dataset
-- ========================================================

CREATE TABLE dim_cell_tower (
    tower_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_tower_id                INT             NOT NULL                                                   , -- Natural ID
    tower_code                     VARCHAR(20)     NOT NULL                                                   , -- Station code
    city_name                      VARCHAR(50)     NOT NULL                                                     -- City name
);

CREATE TABLE dim_plan (
    plan_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_plan_id                 INT             NOT NULL                                                   , -- Natural ID
    plan_name                      VARCHAR(50)     NOT NULL                                                   , -- Plan name
    monthly_fee_usd                NUMERIC(8,2)    NOT NULL                                                     -- Fee USD
);

CREATE TABLE dim_subscriber (
    subscriber_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_subscriber_id           INT             NOT NULL                                                   , -- Natural ID
    plan_key                       BIGINT          NOT NULL REFERENCES dim_plan(plan_key)                     , -- FK to dim_plan
    phone_number                   VARCHAR(20)     NOT NULL                                                     -- Phone number
);

CREATE TABLE fact_call_detail (
    cdr_key                        BIGINT          PRIMARY KEY                                                , -- Surrogate key
    subscriber_key                 BIGINT          NOT NULL REFERENCES dim_subscriber(subscriber_key)         , -- FK to dim_subscriber
    tower_key                      BIGINT          NOT NULL REFERENCES dim_cell_tower(tower_key)              , -- FK to dim_cell_tower
    duration_seconds               INT             NOT NULL                                                     -- Call duration
);

CREATE TABLE fact_data_usage (
    usage_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    subscriber_key                 BIGINT          NOT NULL REFERENCES dim_subscriber(subscriber_key)         , -- FK to dim_subscriber
    tower_key                      BIGINT          NOT NULL REFERENCES dim_cell_tower(tower_key)              , -- FK to dim_cell_tower
    mb_downloaded                  NUMERIC(10,2)   NOT NULL                                                     -- Download MB
);

CREATE TABLE fact_subscriber_billing (
    bill_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    subscriber_key                 BIGINT          NOT NULL REFERENCES dim_subscriber(subscriber_key)         , -- FK to dim_subscriber
    total_amount_usd               NUMERIC(10,2)   NOT NULL                                                     -- Billed amount USD
);

CREATE TABLE dim_cell_tower_telecommunications (
    tower_key                      BIGINT          PRIMARY KEY                                              , -- Surrogate key for tower dimension
    source_tower_id                INT             NOT NULL                                                 , -- Natural tower ID from source
    tower_code                     VARCHAR(20)     NOT NULL                                                 , -- Tower site code
    site_name                      VARCHAR(80)     NOT NULL                                                 , -- Tower geographical site name
    region_code                    VARCHAR(15)     NOT NULL                                                 , -- Network region code
    vendor_name                    VARCHAR(50)     NOT NULL                                                 , -- Equipment vendor name
    latitude                       NUMERIC(8,4)    NOT NULL                                                 , -- Latitude
    longitude                      NUMERIC(8,4)    NOT NULL                                                 , -- Longitude
    altitude_meters                INT             NOT NULL                                                 , -- Altitude meters
    frequency_band_ghz             NUMERIC(4,2)    NOT NULL                                                 , -- Frequency GHz
    max_bandwidth_gbps             NUMERIC(6,2)    NOT NULL                                                 , -- Max bandwidth Gbps
    antenna_array_count            INT             NOT NULL                                                 , -- MIMO antennas count
    coverage_radius_km             NUMERIC(4,2)    NOT NULL                                                 , -- Coverage radius km
    power_usage_kw                 NUMERIC(6,2)    NOT NULL                                                 , -- Power usage kW
    operational_status             VARCHAR(25)     NOT NULL                                                 , -- Operational status
    backhaul_type                  VARCHAR(30)     NOT NULL                                                 , -- Backhaul connection type
    firmware_build                 VARCHAR(20)     NOT NULL                                                 , -- Firmware version
    commissioned_date              DATE            NOT NULL                                                 , -- Commissioning date
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_subscriber_device (
    device_key                     BIGINT          PRIMARY KEY                                              , -- Surrogate key for device dimension
    source_device_id               INT             NOT NULL                                                 , -- Natural device ID from source
    imei_number                    VARCHAR(20)     NOT NULL                                                 , -- IMEI number
    device_brand                   VARCHAR(40)     NOT NULL                                                 , -- Handset brand
    device_model                   VARCHAR(50)     NOT NULL                                                 , -- Model name
    operating_system               VARCHAR(20)     NOT NULL                                                 , -- Operating system
    os_version                     VARCHAR(20)     NOT NULL                                                 , -- OS version
    is_5g_capable                  BOOLEAN         NOT NULL                                                 , -- 5G capable flag
    volte_supported                BOOLEAN         NOT NULL                                                 , -- VoLTE supported flag
    storage_capacity_gb            INT             NOT NULL                                                 , -- Storage GB
    ram_memory_gb                  INT             NOT NULL                                                 , -- RAM GB
    battery_health_pct             INT             NOT NULL                                                 , -- Battery health %
    activation_date                DATE            NOT NULL                                                 , -- Activation date
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- Status code
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current_record              BOOLEAN         NOT NULL                                                 , -- SCD Type 2 current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_call_detail_5g (
    call_fact_key                  BIGINT          PRIMARY KEY                                              , -- Surrogate key for call fact
    tower_key                      BIGINT          NOT NULL REFERENCES dim_cell_tower(tower_key)        , -- FK to dim_cell_tower
    device_key                     BIGINT          NOT NULL REFERENCES dim_subscriber_device(device_key), -- FK to dim_subscriber_device
    caller_msisdn                  VARCHAR(20)     NOT NULL                                                 , -- Caller number
    callee_msisdn                  VARCHAR(20)     NOT NULL                                                 , -- Callee number
    call_start_timestamp           TIMESTAMP       NOT NULL                                                 , -- Call start timestamp
    duration_seconds               INT             NOT NULL                                                 , -- Call duration in seconds
    call_type                      VARCHAR(30)     NOT NULL                                                 , -- VoNR or VoLTE call type
    termination_reason             VARCHAR(30)     NOT NULL                                                 , -- Call clearing reason
    audio_codec                    VARCHAR(25)     NOT NULL                                                 , -- Audio codec code
    signal_strength_dbm            INT             NOT NULL                                                 , -- RSRP signal strength dBm
    latency_ms                     NUMERIC(5,2)    NOT NULL                                                 , -- Latency ms
    packet_loss_pct                NUMERIC(4,2)    NOT NULL                                                 , -- Packet loss %
    billing_charge_usd             NUMERIC(6,2)    NOT NULL                                                 , -- Charge amount USD
    qos_flow_id                    INT             NOT NULL                                                 , -- QoS Flow ID QFI
    is_roaming_flag                BOOLEAN         NOT NULL                                                 , -- Roaming flag
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- Billing status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_data_usage_sessions (
    session_fact_key               BIGINT          PRIMARY KEY                                              , -- Surrogate key for session fact
    tower_key                      BIGINT          NOT NULL REFERENCES dim_cell_tower(tower_key)        , -- FK to dim_cell_tower
    device_key                     BIGINT          NOT NULL REFERENCES dim_subscriber_device(device_key), -- FK to dim_subscriber_device
    session_start_time             TIMESTAMP       NOT NULL                                                 , -- Session connect time
    session_end_time               TIMESTAMP       NOT NULL                                                 , -- Session disconnect time
    download_mb                    NUMERIC(10,2)   NOT NULL                                                 , -- Download MB
    upload_mb                      NUMERIC(10,2)   NOT NULL                                                 , -- Upload MB
    total_data_mb                  NUMERIC(10,2)   NOT NULL                                                 , -- Total payload MB
    peak_speed_mbps                NUMERIC(8,2)    NOT NULL                                                 , -- Peak speed Mbps
    avg_latency_ms                 NUMERIC(5,2)    NOT NULL                                                 , -- Latency ms
    protocol_type                  VARCHAR(20)     NOT NULL                                                 , -- Network protocol
    apn_name                       VARCHAR(40)     NOT NULL                                                 , -- APN string
    slice_id_5g                    VARCHAR(20)     NOT NULL                                                 , -- 5G slice ID
    billing_charge_usd             NUMERIC(8,2)    NOT NULL                                                 , -- Data charge USD
    network_mode                   VARCHAR(20)     NOT NULL                                                 , -- Network mode
    disconnection_reason           VARCHAR(30)     NOT NULL                                                 , -- Disconnect reason
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_network_outages (
    outage_fact_key                BIGINT          PRIMARY KEY                                              , -- Surrogate key for outage fact
    tower_key                      BIGINT          NOT NULL REFERENCES dim_cell_tower(tower_key)        , -- FK to dim_cell_tower
    outage_code                    VARCHAR(20)     NOT NULL                                                 , -- Outage ticket code
    start_time                     TIMESTAMP       NOT NULL                                                 , -- Outage start time
    end_time                       TIMESTAMP       NOT NULL                                                 , -- Outage end time
    duration_minutes               INT             NOT NULL                                                 , -- Duration in minutes
    root_cause                     VARCHAR(50)     NOT NULL                                                 , -- Root cause description
    severity_level                 VARCHAR(15)     NOT NULL                                                 , -- Severity level code
    affected_users_count           INT             NOT NULL                                                 , -- Impacted user count
    penalty_cost_usd               NUMERIC(10,2)   NOT NULL                                                 , -- Penalty cost USD
    backup_power_flag              BOOLEAN         NOT NULL                                                 , -- Backup power flag
    sla_breached_flag              BOOLEAN         NOT NULL                                                 , -- SLA breached flag
    region_code                    VARCHAR(15)     NOT NULL                                                 , -- Region code
    weather_condition              VARCHAR(30)     NOT NULL                                                 , -- Weather text
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_smart_meter (
    meter_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_meter_id                INT             NOT NULL                                                   , -- Natural ID
    substation_key                 BIGINT          NOT NULL REFERENCES dim_substation(substation_key)           -- FK to dim_substation
);

CREATE TABLE dim_substation (
    substation_key                 BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_substation_id           INT             NOT NULL                                                   , -- Natural ID
    grid_code                      VARCHAR(20)     NOT NULL                                                     -- Grid code
);

CREATE TABLE fact_grid_consumption (
    consumption_key                BIGINT          PRIMARY KEY                                                , -- Surrogate key
    meter_key                      BIGINT          NOT NULL REFERENCES dim_smart_meter(meter_key)             , -- FK to dim_smart_meter
    kwh_consumption                NUMERIC(10,3)   NOT NULL                                                     -- kWh
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

CREATE TABLE fact_support_tickets (
    fact_ticket_key                BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    fact_order_key                 BIGINT          NULL REFERENCES fact_orders(fact_order_key)                , -- FK to fact_orders
    ticket_status                  VARCHAR(20)     NOT NULL                                                     -- Ticket status
);

CREATE TABLE fact_wishlists (
    fact_wishlist_key              BIGINT          PRIMARY KEY                                                , -- Surrogate primary key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(dim_cust_key)            , -- FK to dim_customers
    product_key                    BIGINT          NOT NULL REFERENCES dim_products(dim_prod_key)               -- FK to dim_products
);

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
