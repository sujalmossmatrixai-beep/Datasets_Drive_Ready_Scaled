-- ========================================================
-- Master DDL Schema Script for Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_60x50_source
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 60
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_08_Banking_Fraud_Risk_Compliance_Dataset, Dataset_09_Cryptocurrency_Exchange_Dataset, Dataset_17_Global_Logistics_Shipping_Dataset, Dataset_27_Supply_Chain_Logistics_Dataset
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

CREATE TABLE tbl_purchase_orders (
    po_id                          INT             PRIMARY KEY                                                , -- PO primary key ID
    po_number                      VARCHAR(30)     NOT NULL                                                   , -- Unique PO document number
    supplier_id                    INT             NOT NULL REFERENCES tbl_suppliers(supplier_id)             , -- FK to tbl_suppliers
    warehouse_id                   INT             NOT NULL REFERENCES tbl_warehouses(warehouse_id)           , -- FK to tbl_warehouses
    po_date                        DATE            NOT NULL                                                   , -- Order placement date
    total_cost                     DECIMAL(12,2)   NOT NULL                                                     -- Gross PO total amount
);

CREATE TABLE tbl_shipment_manifests (
    shipment_id                    INT             PRIMARY KEY                                                , -- Shipment primary key ID
    po_id                          INT             NOT NULL REFERENCES tbl_purchase_orders(po_id)             , -- FK to tbl_purchase_orders
    carrier_id                     INT             NOT NULL REFERENCES tbl_carrier_fleet(carrier_id)          , -- FK to tbl_carrier_fleet
    tracking_number                VARCHAR(40)     NOT NULL                                                   , -- Tracking reference
    dispatch_date                  TIMESTAMP       NOT NULL                                                   , -- Dispatch timestamp
    expected_delivery              DATE            NOT NULL                                                     -- Estimated arrival date
);

CREATE TABLE tbl_suppliers (
    supplier_id                    INT             PRIMARY KEY                                                , -- Supplier primary key ID
    supplier_name                  VARCHAR(100)    NOT NULL                                                   , -- Vendor legal name
    country_code                   VARCHAR(3)      NOT NULL                                                   , -- Country ISO code
    rating_score                   DECIMAL(3,2)    NOT NULL                                                     -- Vendor rating 1.0-5.0
);

CREATE TABLE tbl_warehouse_racks (
    rack_id                        INT             PRIMARY KEY                                                , -- Rack primary key ID
    warehouse_id                   INT             NOT NULL REFERENCES tbl_warehouses(warehouse_id)           , -- FK to tbl_warehouses
    aisle_code                     VARCHAR(10)     NOT NULL                                                   , -- Aisle designation
    shelf_level                    INT             NOT NULL                                                     -- Shelf vertical level
);

CREATE TABLE tbl_warehouses (
    warehouse_id                   INT             PRIMARY KEY                                                , -- Warehouse primary key ID
    facility_name                  VARCHAR(80)     NOT NULL                                                   , -- Facility designation
    city                           VARCHAR(50)     NOT NULL                                                   , -- Location city
    capacity_sqft                  INT             NOT NULL                                                     -- Storage square footage
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

CREATE TABLE tbl_suppliers_ecommerce (
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

CREATE TABLE tbl_warehouses_ecommerce (
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
