-- ========================================================
-- Master DDL Schema Script for Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_08_Banking_Fraud_Risk_Compliance_Dataset, Dataset_09_Cryptocurrency_Exchange_Dataset, Dataset_17_Global_Logistics_Shipping_Dataset, Dataset_27_Supply_Chain_Logistics_Dataset
-- ========================================================

CREATE TABLE tbl_cargo_containers (
    container_id                   INT             PRIMARY KEY                                              , -- Container primary key ID
    container_number               VARCHAR(20)     NOT NULL                                                 , -- ISO container serial number
    container_type                 VARCHAR(30)     NOT NULL                                                 , -- DRY_40FT, REEFER_40FT, OPEN_TOP, TANK
    length_feet                    INT             NOT NULL                                                 , -- Container length 20ft or 40ft
    max_payload_kg                 DECIMAL(10,2)   NOT NULL                                                 , -- Maximum payload capacity kg
    tare_weight_kg                 DECIMAL(8,2)    NOT NULL                                                 , -- Empty container weight kg
    manufacture_year               INT             NOT NULL                                                 , -- Year of container build
    last_inspection_date           DATE            NOT NULL                                                 , -- Safety inspection date
    current_location_port          VARCHAR(10)     NOT NULL                                                 , -- Current port location
    is_refrigerated                BOOLEAN         NOT NULL                                                 , -- Reefer container flag
    seal_number                    VARCHAR(20)     NOT NULL                                                 , -- Security seal lock ID
    owner_shipping_line            VARCHAR(50)     NOT NULL                                                 , -- Container owner shipping line
    lease_status                   VARCHAR(20)     NOT NULL                                                 , -- OWNED, LEASED_LONG, LEASED_SHORT
    maintenance_status             VARCHAR(20)     NOT NULL                                                 , -- SERVICEABLE, REPAIR_NEEDED, SCRAPPED
    gps_tracker_id                 VARCHAR(25)     NOT NULL                                                 , -- IoT GPS tracker device ID
    door_type                      VARCHAR(30)     NOT NULL                                                 , -- STANDARD_DOUBLE, ROLL_UP, SIDE_DOOR
    inspection_passed_flag         BOOLEAN         NOT NULL                                                 , -- Passed safety inspection
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    notes                          VARCHAR(150)    NOT NULL                                                   -- Container maintenance comments
);

CREATE TABLE tbl_carrier_vessels (
    vessel_id                      INT             PRIMARY KEY                                              , -- Vessel primary key ID
    imo_number                     VARCHAR(15)     NOT NULL                                                 , -- IMO ship identification number
    vessel_name                    VARCHAR(60)     NOT NULL                                                 , -- Ship official name
    flag_state                     VARCHAR(3)      NOT NULL                                                 , -- Flag country state registration
    vessel_type                    VARCHAR(30)     NOT NULL                                                 , -- CONTAINER, BULK, TANKER, RO-RO
    build_year                     INT             NOT NULL                                                 , -- Year ship was launched
    deadweight_tonnage             INT             NOT NULL                                                 , -- DWT cargo capacity metric tons
    teu_capacity                   INT             NOT NULL                                                 , -- Twenty-foot equivalent unit limit
    engine_power_kw                INT             NOT NULL                                                 , -- Main engine power kilowatts
    max_speed_knots                DECIMAL(4,1)    NOT NULL                                                 , -- Maximum nautical speed knots
    owner_company                  VARCHAR(80)     NOT NULL                                                 , -- Vessel owner shipping corporation
    operator_company               VARCHAR(80)     NOT NULL                                                 , -- Vessel operating charter company
    call_sign                      VARCHAR(10)     NOT NULL                                                 , -- Radio station call sign
    mmsi_number                    VARCHAR(15)     NOT NULL                                                 , -- Maritime Mobile Service Identity
    last_drydock_date              DATE            NOT NULL                                                 , -- Last drydock maintenance date
    safety_certificate_expiry      DATE            NOT NULL                                                 , -- SOLAS safety certificate expiry
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status                         VARCHAR(20)     NOT NULL                                                 , -- IN_SERVICE, DRYDOCK, CHARTERED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Vessel operational inspection notes
);

CREATE TABLE tbl_customs_declarations (
    declaration_id                 INT             PRIMARY KEY                                              , -- Customs declaration primary key ID
    shipment_id                    INT             NOT NULL REFERENCES tbl_freight_shipments(shipment_id), -- FK to tbl_freight_shipments
    declaration_number             VARCHAR(25)     NOT NULL                                                 , -- Customs entry declaration number
    customs_office_code            VARCHAR(10)     NOT NULL                                                 , -- Customs office port code
    entry_date                     DATE            NOT NULL                                                 , -- Customs declaration entry date
    importer_record_id             INT             NOT NULL                                                 , -- Importer tax ID record
    exporter_record_id             INT             NOT NULL                                                 , -- Exporter tax ID record
    hs_tariff_code                 VARCHAR(12)     NOT NULL                                                 , -- Harmonized System tariff code
    duty_amount_usd                DECIMAL(10,2)   NOT NULL                                                 , -- Assessed customs duty USD
    tax_amount_usd                 DECIMAL(10,2)   NOT NULL                                                 , -- Assessed import VAT/tax USD
    inspection_status              VARCHAR(30)     NOT NULL                                                 , -- PASSED, PHYSICAL_EXAM, DOCUMENT_CHECK
    clearance_date                 DATE            NOT NULL                                                 , -- Customs release clearance date
    country_of_origin              VARCHAR(3)      NOT NULL                                                 , -- ISO-3 country of origin code
    country_of_destination         VARCHAR(3)      NOT NULL                                                 , -- ISO-3 destination country code
    exemption_code                 VARCHAR(15)     NOT NULL                                                 , -- Duty exemption code or NONE
    customs_broker_id              INT             NOT NULL                                                 , -- Broker license ID
    risk_score                     INT             NOT NULL                                                 , -- Customs automated risk score 1-100
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                   -- RELEASED, HELD, REJECTED
);

CREATE TABLE tbl_freight_shipments (
    shipment_id                    INT             PRIMARY KEY                                              , -- Freight shipment primary key ID
    tracking_number                VARCHAR(25)     NOT NULL                                                 , -- Global tracking waybill number
    shipper_id                     INT             NOT NULL                                                 , -- Shipper company record ID
    consignee_id                   INT             NOT NULL                                                 , -- Consignee recipient ID
    origin_port_code               VARCHAR(10)     NOT NULL                                                 , -- Origin port UN/LOCODE
    destination_port_code          VARCHAR(10)     NOT NULL                                                 , -- Destination port UN/LOCODE
    carrier_id                     INT             NOT NULL                                                  , -- FK to tbl_carrier_vessels
    vessel_name                    VARCHAR(60)     NOT NULL                                                 , -- Container ship vessel name
    voyage_number                  VARCHAR(15)     NOT NULL                                                 , -- Voyage manifest code
    container_number               VARCHAR(20)     NOT NULL                                                 , -- Standard 40ft container code
    declared_value_usd             DECIMAL(12,2)   NOT NULL                                                 , -- Declared customs cargo value
    freight_cost_usd               DECIMAL(10,2)   NOT NULL                                                 , -- Freight shipping charge USD
    gross_weight_kg                DECIMAL(10,2)   NOT NULL                                                 , -- Gross shipment weight kg
    net_weight_kg                  DECIMAL(10,2)   NOT NULL                                                 , -- Net cargo weight kg
    volume_cubic_meters            DECIMAL(8,2)    NOT NULL                                                 , -- Cargo volume CBM
    shipment_status                VARCHAR(30)     NOT NULL                                                 , -- BOOKED, IN_TRANSIT, CUSTOMS, DELIVERED
    departure_date                 DATE            NOT NULL                                                 , -- Port departure date
    estimated_arrival_date         DATE            NOT NULL                                                 , -- Estimated arrival date
    actual_arrival_date            DATE            NOT NULL                                                 , -- Actual arrival date
    customs_clearance_flag         BOOLEAN         NOT NULL                                                 , -- Customs cleared indicator
    hazardous_material_flag        BOOLEAN         NOT NULL                                                 , -- Hazmat cargo classification flag
    temperature_control_c          DECIMAL(4,1)    NOT NULL                                                 , -- Reefer temperature setting C
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                   -- Record update timestamp
);

CREATE TABLE tbl_port_terminals (
    port_id                        INT             PRIMARY KEY                                              , -- Port primary key ID
    port_code                      VARCHAR(10)     NOT NULL                                                 , -- UN/LOCODE port identifier
    port_name                      VARCHAR(80)     NOT NULL                                                 , -- Official sea port terminal name
    country_code                   VARCHAR(3)      NOT NULL                                                 , -- Country code ISO-3
    city_name                      VARCHAR(50)     NOT NULL                                                 , -- Port city location
    latitude                       DECIMAL(8,4)    NOT NULL                                                 , -- Port GPS latitude coordinate
    longitude                      DECIMAL(8,4)    NOT NULL                                                 , -- Port GPS longitude coordinate
    berth_capacity                 INT             NOT NULL                                                 , -- Total vessel berth capacity
    annual_teu_capacity            INT             NOT NULL                                                 , -- Annual TEU handling capacity
    terminal_operator              VARCHAR(80)     NOT NULL                                                 , -- Terminal operating company
    depth_meters                   DECIMAL(4,1)    NOT NULL                                                 , -- Water depth draft in meters
    is_deepwater_port              BOOLEAN         NOT NULL                                                 , -- Deepwater port flag
    customs_office_present         BOOLEAN         NOT NULL                                                 , -- On-site customs office flag
    contact_phone                  VARCHAR(20)     NOT NULL                                                 , -- Port authority telephone
    contact_email                  VARCHAR(100)    NOT NULL                                                 , -- Port operations email
    operating_hours                VARCHAR(30)     NOT NULL                                                 , -- 24/7 or scheduled hours
    security_level_code            VARCHAR(15)     NOT NULL                                                 , -- ISPS Code Security Level
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    active_flag                    BOOLEAN         NOT NULL                                                   -- Active operational status
);

CREATE TABLE tbl_blockchain_deposits (
    deposit_id                     INT             PRIMARY KEY                                                , -- Deposit primary key ID
    wallet_id                      INT             NOT NULL REFERENCES tbl_user_wallets(wallet_id)            , -- FK to tbl_user_wallets
    tx_hash                        VARCHAR(66)     NOT NULL                                                   , -- Tx hash
    amount                         DECIMAL(18,8)   NOT NULL                                                     -- Deposited amount
);

CREATE TABLE tbl_completed_trades (
    trade_id                       INT             PRIMARY KEY                                                , -- Trade primary key ID
    order_id                       INT             NOT NULL REFERENCES tbl_limit_orders(order_id)             , -- FK to tbl_limit_orders
    trade_price_usd                DECIMAL(12,2)   NOT NULL                                                   , -- Executed trade price
    trade_volume                   DECIMAL(18,8)   NOT NULL                                                   , -- Volume
    trade_time                     TIMESTAMP       NOT NULL                                                     -- Timestamp
);

CREATE TABLE tbl_crypto_assets (
    asset_id                       INT             PRIMARY KEY                                                , -- Asset primary key ID
    ticker_symbol                  VARCHAR(10)     NOT NULL                                                   , -- BTC/ETH/SOL
    asset_name                     VARCHAR(50)     NOT NULL                                                     -- Full token name
);

CREATE TABLE tbl_limit_orders (
    order_id                       INT             PRIMARY KEY                                                , -- Order primary key ID
    asset_id                       INT             NOT NULL REFERENCES tbl_crypto_assets(asset_id)            , -- FK to tbl_crypto_assets
    side                           VARCHAR(4)      NOT NULL                                                   , -- BUY/SELL
    limit_price_usd                DECIMAL(12,2)   NOT NULL                                                   , -- Limit price
    order_quantity                 DECIMAL(18,8)   NOT NULL                                                     -- Quantity
);

CREATE TABLE tbl_user_wallets (
    wallet_id                      INT             PRIMARY KEY                                                , -- Wallet primary key ID
    asset_id                       INT             NOT NULL REFERENCES tbl_crypto_assets(asset_id)            , -- FK to tbl_crypto_assets
    wallet_address                 VARCHAR(64)     NOT NULL                                                   , -- On-chain address string
    available_balance              DECIMAL(18,8)   NOT NULL                                                     -- Token balance
);

CREATE TABLE tbl_aml_suspicious_reports (
    sar_report_id                  INT             PRIMARY KEY                                              , -- SAR report primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customer_risk_profiles(customer_id), -- FK to tbl_customer_risk_profiles
    filing_date                    DATE            NOT NULL                                                 , -- Official regulatory filing date
    reporting_officer_id           INT             NOT NULL                                                 , -- AML compliance officer ID
    suspicious_activity_code       VARCHAR(25)     NOT NULL                                                 , -- FinCEN suspicious activity code
    total_suspicious_amount_usd    DECIMAL(12,2)   NOT NULL                                                 , -- Total aggregate suspicious USD
    fincen_control_number          VARCHAR(25)     NOT NULL                                                 , -- FinCEN regulatory tracking number
    narrative_summary              VARCHAR(250)    NOT NULL                                                 , -- Summary narrative of suspicious activity
    investigation_start_date       DATE            NOT NULL                                                 , -- Investigation start date
    investigation_end_date         DATE            NOT NULL                                                 , -- Investigation closure date
    law_enforcement_contacted_flag BOOLEAN         NOT NULL                                                 , -- FBI/Law enforcement notified flag
    account_frozen_flag            BOOLEAN         NOT NULL                                                 , -- Account restriction/freeze flag
    regulatory_body_code           VARCHAR(15)     NOT NULL                                                 , -- FINCEN, FCA, MAS, FINMA
    jurisdiction_code              VARCHAR(10)     NOT NULL                                                 , -- Jurisdiction legal code
    case_file_path                 VARCHAR(100)    NOT NULL                                                 , -- Encrypted evidence dossier file path
    approval_status                VARCHAR(20)     NOT NULL                                                 , -- APPROVED, PENDING_SIGNATURE, FILED
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- FILED, DRAFT, CLOSED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Compliance officer sign-off notes
);

CREATE TABLE tbl_customer_risk_profiles (
    customer_id                    INT             PRIMARY KEY                                              , -- Customer primary key ID
    customer_number                VARCHAR(20)     NOT NULL                                                 , -- Unique customer master ID
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Customer full legal name
    date_of_birth                  DATE            NOT NULL                                                 , -- Customer birth date
    national_id_ssn                VARCHAR(20)     NOT NULL                                                 , -- Encrypted SSN or national tax ID
    is_pep_flag                    BOOLEAN         NOT NULL                                                 , -- Politically Exposed Person flag
    sanctions_check_status         VARCHAR(25)     NOT NULL                                                 , -- CLEARED, MATCH_FOUND, PENDING
    kyc_verification_status        VARCHAR(25)     NOT NULL                                                 , -- VERIFIED, EXPIRED, INCOMPLETE
    kyc_last_updated_date          DATE            NOT NULL                                                 , -- Date of last KYC refresh
    risk_rating_category           VARCHAR(15)     NOT NULL                                                 , -- LOW, MEDIUM, HIGH, CRITICAL
    credit_score                   INT             NOT NULL                                                 , -- FICO credit score 300-850
    annual_income_usd              DECIMAL(12,2)   NOT NULL                                                 , -- Verified annual income USD
    employment_status              VARCHAR(30)     NOT NULL                                                 , -- EMPLOYED, SELF_EMPLOYED, RETIRED
    occupation_title               VARCHAR(50)     NOT NULL                                                 , -- Job title or business domain
    residence_country              VARCHAR(3)      NOT NULL                                                 , -- Country of residence ISO-3
    tax_residence_country          VARCHAR(3)      NOT NULL                                                 , -- FATCA tax jurisdiction code
    account_count                  INT             NOT NULL                                                 , -- Total active bank accounts owned
    total_balance_usd              DECIMAL(14,2)   NOT NULL                                                 , -- Aggregate balance across accounts
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, FROZEN, CLOSED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Compliance audit comments
);

CREATE TABLE tbl_financial_transactions (
    transaction_id                 INT             PRIMARY KEY                                              , -- Transaction primary key ID
    transaction_reference          VARCHAR(30)     NOT NULL                                                 , -- SWIFT/ISO20022 transaction reference
    sender_account_id              INT             NOT NULL                                                 , -- Sender account ID
    receiver_account_id            INT             NOT NULL                                                 , -- Receiver account ID
    transaction_amount_usd         DECIMAL(12,2)   NOT NULL                                                 , -- Transaction principal amount USD
    transaction_timestamp          TIMESTAMP       NOT NULL                                                 , -- Transaction execution time
    transaction_type               VARCHAR(30)     NOT NULL                                                 , -- WIRE_TRANSFER, ACH, CARD_PAYMENT, ATM
    channel_type                   VARCHAR(20)     NOT NULL                                                 , -- ONLINE_BANKING, MOBILE_APP, BRANCH, POS
    merchant_category_code         VARCHAR(10)     NOT NULL                                                 , -- MCC code identifier
    location_city                  VARCHAR(50)     NOT NULL                                                 , -- Transaction city location
    location_country               VARCHAR(3)      NOT NULL                                                 , -- ISO-3 country code
    ip_address                     VARCHAR(45)     NOT NULL                                                 , -- Client IP address
    device_fingerprint             VARCHAR(40)     NOT NULL                                                 , -- Browser / device unique hash
    is_cross_border                BOOLEAN         NOT NULL                                                 , -- International transfer flag
    currency_code                  VARCHAR(3)      NOT NULL                                                 , -- Transaction ISO currency code
    exchange_rate                  DECIMAL(8,4)    NOT NULL                                                 , -- Applied currency exchange rate
    fee_amount_usd                 DECIMAL(8,2)    NOT NULL                                                 , -- Transaction service fee USD
    risk_score_numeric             INT             NOT NULL                                                 , -- Real-time AI fraud risk score 1-100
    fraud_flag                     BOOLEAN         NOT NULL                                                 , -- Confirmed fraud indicator flag
    aml_flagged_status             VARCHAR(25)     NOT NULL                                                 , -- PASSED, SUSPICIOUS, BLOCKED
    authorization_code             VARCHAR(15)     NOT NULL                                                 , -- Payment gateway authorization ID
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    notes                          VARCHAR(150)    NOT NULL                                                   -- Risk engine processing notes
);

CREATE TABLE tbl_fraud_detection_alerts (
    alert_id                       INT             PRIMARY KEY                                              , -- Alert primary key ID
    transaction_id                 INT             NOT NULL REFERENCES tbl_financial_transactions(transaction_id), -- FK to tbl_financial_transactions
    customer_id                    INT             NOT NULL REFERENCES tbl_customer_risk_profiles(customer_id), -- FK to tbl_customer_risk_profiles
    alert_timestamp                TIMESTAMP       NOT NULL                                                 , -- Fraud rule trigger timestamp
    rule_triggered_id              VARCHAR(20)     NOT NULL                                                 , -- Rule catalog code
    rule_name                      VARCHAR(80)     NOT NULL                                                 , -- Rule description title
    severity_level                 VARCHAR(15)     NOT NULL                                                 , -- CRITICAL, HIGH, MEDIUM, LOW
    alert_score                    INT             NOT NULL                                                 , -- Anomaly risk score 1-100
    investigator_user_id           INT             NOT NULL                                                 , -- Assigned AML investigator ID
    investigation_status           VARCHAR(25)     NOT NULL                                                 , -- OPEN, UNDER_REVIEW, CLOSED, ESCALATED
    resolution_outcome             VARCHAR(40)     NOT NULL                                                 , -- FALSE_POSITIVE, CONFIRMED_FRAUD, SAR_FILED
    resolution_timestamp           TIMESTAMP       NOT NULL                                                 , -- Alert resolution timestamp
    is_false_positive              BOOLEAN         NOT NULL                                                 , -- False positive determination flag
    reported_to_authorities_flag   BOOLEAN         NOT NULL                                                 , -- FinCEN / FIU report flag
    loss_amount_usd                DECIMAL(10,2)   NOT NULL                                                 , -- Confirmed financial loss USD
    recovered_amount_usd           DECIMAL(10,2)   NOT NULL                                                 , -- Recovered funds USD
    comments                       VARCHAR(200)    NOT NULL                                                 , -- Investigator notes and rationale
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                   -- NEW, ASSIGNED, COMPLETED
);

CREATE TABLE tbl_sanction_watchlist_matches (
    match_id                       INT             PRIMARY KEY                                              , -- Match record primary key ID
    customer_id                    INT             NOT NULL REFERENCES tbl_customer_risk_profiles(customer_id), -- FK to tbl_customer_risk_profiles
    watchlist_name                 VARCHAR(50)     NOT NULL                                                 , -- OFAC, UN, EU, INTERPOL, PEP
    matched_name                   VARCHAR(100)    NOT NULL                                                 , -- Name on government sanction list
    match_score_pct                DECIMAL(5,2)    NOT NULL                                                 , -- Fuzzy logic match confidence %
    sanction_entity_id             VARCHAR(20)     NOT NULL                                                 , -- Global sanction entity code
    sanction_authority             VARCHAR(30)     NOT NULL                                                 , -- US_TREASURY, UN, EU_COMMISSION
    match_timestamp                TIMESTAMP       NOT NULL                                                 , -- Automated screening match time
    analyst_review_status          VARCHAR(25)     NOT NULL                                                 , -- UNDER_REVIEW, CLEARED, CONFIRMED
    review_decision                VARCHAR(30)     NOT NULL                                                 , -- FALSE_POSITIVE, BLOCK_TRANSACTION
    analyst_id                     INT             NOT NULL                                                 , -- Assigned sanction analyst ID
    clearance_reason               VARCHAR(150)    NOT NULL                                                 , -- Reason for clearing or blocking match
    entity_type                    VARCHAR(20)     NOT NULL                                                 , -- INDIVIDUAL, VESSEL, CORPORATION
    country_listed                 VARCHAR(3)      NOT NULL                                                 , -- Listed entity country ISO-3
    passport_match_flag            BOOLEAN         NOT NULL                                                 , -- Passport number exact match flag
    dob_match_flag                 BOOLEAN         NOT NULL                                                 , -- Date of birth match flag
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- RESOLVED, PENDING, BLOCKED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Screening system audit trail
);

CREATE TABLE tbl_carrier_fleet (
    carrier_id                     INT             PRIMARY KEY                                                , -- Carrier primary key ID
    carrier_name                   VARCHAR(80)     NOT NULL                                                   , -- Logistics provider name
    transport_mode                 VARCHAR(20)     NOT NULL                                                   , -- TRUCK/RAIL/OCEAN/AIR
    fleet_size                     INT             NOT NULL                                                     -- Active vehicle count
);

CREATE TABLE tbl_customs_clearance (
    customs_id                     INT             PRIMARY KEY                                                , -- Customs primary key ID
    shipment_id                    INT             NOT NULL REFERENCES tbl_shipment_manifests(shipment_id)    , -- FK to tbl_shipment_manifests
    declaration_number             VARCHAR(40)     NOT NULL                                                   , -- Customs declaration ref
    duty_amount                    DECIMAL(10,2)   NOT NULL                                                   , -- Import duty paid
    clearance_status               VARCHAR(20)     NOT NULL                                                     -- CLEARED/HELD/INSPECTED
);

CREATE TABLE tbl_freight_bills (
    bill_id                        INT             PRIMARY KEY                                                , -- Bill primary key ID
    shipment_id                    INT             NOT NULL REFERENCES tbl_shipment_manifests(shipment_id)    , -- FK to tbl_shipment_manifests
    freight_charge                 DECIMAL(10,2)   NOT NULL                                                   , -- Freight charge
    fuel_surcharge                 DECIMAL(10,2)   NOT NULL                                                   , -- Fuel surcharge
    payment_status                 VARCHAR(15)     NOT NULL                                                     -- UNPAID/PAID/OVERDUE
);

CREATE TABLE tbl_inventory_lots (
    lot_id                         INT             PRIMARY KEY                                                , -- Lot primary key ID
    warehouse_id                   INT             NOT NULL REFERENCES tbl_warehouses(warehouse_id)           , -- FK to tbl_warehouses
    sku_code                       VARCHAR(30)     NOT NULL                                                   , -- Material SKU
    quantity_on_hand               INT             NOT NULL                                                   , -- Stock count
    expiry_date                    DATE            NULL                                                         -- Expiration date if applicable
);

CREATE TABLE tbl_po_items (
    po_item_id                     INT             PRIMARY KEY                                                , -- PO line item primary key ID
    po_id                          INT             NOT NULL REFERENCES tbl_purchase_orders(po_id)             , -- FK to tbl_purchase_orders
    sku_code                       VARCHAR(30)     NOT NULL                                                   , -- Material SKU code
    ordered_qty                    INT             NOT NULL                                                   , -- Ordered quantity
    unit_price                     DECIMAL(10,2)   NOT NULL                                                     -- Unit price
);
