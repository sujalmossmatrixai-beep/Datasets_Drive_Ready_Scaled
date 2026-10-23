-- ========================================================
-- Master DDL Schema Script for Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_80x100_target
-- Tier: Tier 3: 80 Source Tables, 100 Target Tables
-- Total Tables: 100
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_03_Finance_Banking_Dataset, Dataset_04_HR_Payroll_Dataset, Dataset_05_Airline_Reservation_Dataset, Dataset_06_Asset_Management_Wealth_Dataset, Dataset_07_Automotive_Dealership_Dataset, Dataset_08_Banking_Fraud_Risk_Compliance_Dataset, Dataset_09_Cryptocurrency_Exchange_Dataset, Dataset_10_Digital_Streaming_Media_Dataset, Dataset_17_Global_Logistics_Shipping_Dataset, Dataset_27_Supply_Chain_Logistics_Dataset
-- ========================================================

CREATE TABLE dim_port (
    port_key                       BIGINT          PRIMARY KEY                                              , -- Surrogate key for port dimension
    source_port_id                 INT             NOT NULL                                                 , -- Natural port ID from source
    port_code                      VARCHAR(10)     NOT NULL                                                 , -- UN/LOCODE port code
    port_name                      VARCHAR(80)     NOT NULL                                                 , -- Port terminal name
    country_code                   VARCHAR(3)      NOT NULL                                                 , -- Country code ISO-3
    city_name                      VARCHAR(50)     NOT NULL                                                 , -- City name
    terminal_operator              VARCHAR(80)     NOT NULL                                                 , -- Operator name
    latitude                       NUMERIC(8,4)    NOT NULL                                                 , -- Latitude
    longitude                      NUMERIC(8,4)    NOT NULL                                                 , -- Longitude
    berth_capacity                 INT             NOT NULL                                                 , -- Berth count
    annual_teu_capacity            INT             NOT NULL                                                 , -- TEU capacity
    water_depth_meters             NUMERIC(4,1)    NOT NULL                                                 , -- Depth meters
    is_deepwater_flag              BOOLEAN         NOT NULL                                                 , -- Deepwater flag
    customs_office_flag            BOOLEAN         NOT NULL                                                 , -- Customs office flag
    operating_hours                VARCHAR(30)     NOT NULL                                                 , -- Operating schedule
    security_level                 VARCHAR(15)     NOT NULL                                                 , -- Security level code
    contact_phone                  VARCHAR(20)     NOT NULL                                                 , -- Contact phone
    contact_email                  VARCHAR(100)    NOT NULL                                                 , -- Contact email
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_shipment (
    shipment_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for shipment dimension
    source_shipment_id             INT             NOT NULL                                                 , -- Natural shipment ID from source
    tracking_number                VARCHAR(25)     NOT NULL                                                 , -- Tracking waybill number
    shipper_id                     INT             NOT NULL                                                 , -- Shipper ID
    consignee_id                   INT             NOT NULL                                                 , -- Consignee ID
    origin_port_code               VARCHAR(10)     NOT NULL                                                 , -- Origin port code
    destination_port_code          VARCHAR(10)     NOT NULL                                                 , -- Destination port code
    vessel_name                    VARCHAR(60)     NOT NULL                                                 , -- Vessel name
    container_number               VARCHAR(20)     NOT NULL                                                 , -- Container number
    shipment_status                VARCHAR(30)     NOT NULL                                                 , -- Shipment status text
    declared_value_usd             NUMERIC(12,2)   NOT NULL                                                 , -- Declared value USD
    freight_cost_usd               NUMERIC(10,2)   NOT NULL                                                 , -- Freight cost USD
    gross_weight_kg                NUMERIC(10,2)   NOT NULL                                                 , -- Gross weight kg
    volume_cbm                     NUMERIC(8,2)    NOT NULL                                                 , -- Volume CBM
    customs_cleared_flag           BOOLEAN         NOT NULL                                                 , -- Customs cleared flag
    hazardous_flag                 BOOLEAN         NOT NULL                                                 , -- Hazmat flag
    reefer_temp_c                  NUMERIC(4,1)    NOT NULL                                                 , -- Reefer temp C
    departure_date                 DATE            NOT NULL                                                 , -- Departure date
    estimated_arrival_date         DATE            NOT NULL                                                 , -- ETA date
    actual_arrival_date            DATE            NOT NULL                                                 , -- ATA date
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current_record              BOOLEAN         NOT NULL                                                 , -- SCD Type 2 current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_vessel (
    vessel_key                     BIGINT          PRIMARY KEY                                              , -- Surrogate key for vessel dimension
    source_vessel_id               INT             NOT NULL                                                 , -- Natural vessel ID from source
    imo_number                     VARCHAR(15)     NOT NULL                                                 , -- IMO ship number
    vessel_name                    VARCHAR(60)     NOT NULL                                                 , -- Vessel name
    flag_state                     VARCHAR(3)      NOT NULL                                                 , -- Flag state ISO-3
    vessel_type                    VARCHAR(30)     NOT NULL                                                 , -- Vessel category
    build_year                     INT             NOT NULL                                                 , -- Build year
    dwt_tonnage                    INT             NOT NULL                                                 , -- DWT tonnage
    teu_capacity                   INT             NOT NULL                                                 , -- TEU capacity
    engine_power_kw                INT             NOT NULL                                                 , -- Engine power kW
    max_speed_knots                NUMERIC(4,1)    NOT NULL                                                 , -- Max speed knots
    owner_company                  VARCHAR(80)     NOT NULL                                                 , -- Owner company
    operator_company               VARCHAR(80)     NOT NULL                                                 , -- Operator company
    call_sign                      VARCHAR(10)     NOT NULL                                                 , -- Call sign
    mmsi_number                    VARCHAR(15)     NOT NULL                                                 , -- MMSI number
    safety_cert_expiry             DATE            NOT NULL                                                 , -- Cert expiry date
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- Operational status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_customs_duties (
    customs_key                    BIGINT          PRIMARY KEY                                              , -- Surrogate key for customs fact
    shipment_key                   BIGINT          NOT NULL REFERENCES dim_shipment(shipment_key)       , -- FK to dim_shipment
    port_key                       BIGINT          NOT NULL REFERENCES dim_port(port_key)               , -- FK to dim_port
    entry_date                     DATE            NOT NULL                                                 , -- Customs entry date
    clearance_date                 DATE            NOT NULL                                                 , -- Customs clearance date
    declared_cargo_value_usd       NUMERIC(12,2)   NOT NULL                                                 , -- Declared value USD
    assessed_duty_usd              NUMERIC(10,2)   NOT NULL                                                 , -- Customs duty USD
    import_vat_usd                 NUMERIC(10,2)   NOT NULL                                                 , -- Import VAT USD
    excise_tax_usd                 NUMERIC(8,2)    NOT NULL                                                 , -- Excise tax USD
    total_duties_taxes_usd         NUMERIC(12,2)   NOT NULL                                                 , -- Total tax & duties USD
    customs_risk_score             INT             NOT NULL                                                 , -- Automated risk score 1-100
    inspection_required_flag       BOOLEAN         NOT NULL                                                 , -- Physical inspection flag
    inspection_status              VARCHAR(30)     NOT NULL                                                 , -- Inspection status text
    exemption_claimed_flag         BOOLEAN         NOT NULL                                                 , -- Duty exemption flag
    customs_status_code            VARCHAR(20)     NOT NULL                                                 , -- Customs status
    clearance_days                 INT             NOT NULL                                                 , -- Days to clear customs
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    etl_batch_id                   INT             NOT NULL                                                 , -- ETL batch processing ID
    notes                          VARCHAR(150)    NOT NULL                                                   -- Customs processing comments
);

CREATE TABLE fact_freight_movements (
    movement_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for movement fact
    shipment_key                   BIGINT          NOT NULL REFERENCES dim_shipment(shipment_key)       , -- FK to dim_shipment
    origin_port_key                BIGINT          NOT NULL REFERENCES dim_port(port_key)               , -- FK to dim_port
    dest_port_key                  BIGINT          NOT NULL REFERENCES dim_port(port_key)               , -- FK to dim_port
    vessel_key                     BIGINT          NOT NULL REFERENCES dim_vessel(vessel_key)           , -- FK to dim_vessel
    departure_date                 DATE            NOT NULL                                                 , -- Departure date key
    arrival_date                   DATE            NOT NULL                                                 , -- Arrival date key
    transit_days                   INT             NOT NULL                                                 , -- Total transit duration days
    freight_cost_usd               NUMERIC(10,2)   NOT NULL                                                 , -- Freight cost USD
    insurance_cost_usd             NUMERIC(8,2)    NOT NULL                                                 , -- Cargo insurance cost USD
    bunker_surcharge_usd           NUMERIC(8,2)    NOT NULL                                                 , -- Fuel surcharge USD
    port_handling_fee_usd          NUMERIC(8,2)    NOT NULL                                                 , -- Terminal handling charge USD
    total_transport_usd            NUMERIC(12,2)   NOT NULL                                                 , -- Total transportation cost USD
    gross_weight_kg                NUMERIC(10,2)   NOT NULL                                                 , -- Weight kg
    volume_cbm                     NUMERIC(8,2)    NOT NULL                                                 , -- Volume CBM
    on_time_delivery_flag          BOOLEAN         NOT NULL                                                 , -- On-time delivery performance flag
    delay_reason_code              VARCHAR(30)     NOT NULL                                                 , -- Delay reason code or NONE
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_asset (
    asset_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_asset_id                INT             NOT NULL                                                   , -- Natural ID
    ticker_symbol                  VARCHAR(10)     NOT NULL                                                     -- Ticker
);

CREATE TABLE dim_wallet (
    wallet_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_wallet_id               INT             NOT NULL                                                   , -- Natural ID
    asset_key                      BIGINT          NOT NULL REFERENCES dim_asset(asset_key)                     -- FK to dim_asset
);

CREATE TABLE fact_deposits (
    deposit_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    wallet_key                     BIGINT          NOT NULL REFERENCES dim_wallet(wallet_key)                 , -- FK to dim_wallet
    amount                         NUMERIC(18,8)   NOT NULL                                                     -- Amount
);

CREATE TABLE fact_executed_trades (
    trade_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    asset_key                      BIGINT          NOT NULL REFERENCES dim_asset(asset_key)                   , -- FK to dim_asset
    trade_volume                   NUMERIC(18,8)   NOT NULL                                                     -- Volume
);

CREATE TABLE dim_account_compliance (
    account_key                    BIGINT          PRIMARY KEY                                              , -- Surrogate key for account dimension
    source_account_id              INT             NOT NULL                                                 , -- Natural account ID from source
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    account_number                 VARCHAR(20)     NOT NULL                                                 , -- Account number string
    account_type                   VARCHAR(30)     NOT NULL                                                 , -- CHECKING, SAVINGS, CORPORATE, INVESTMENT
    currency_code                  VARCHAR(3)      NOT NULL                                                 , -- Currency ISO-3
    opening_date                   DATE            NOT NULL                                                 , -- Account opening date
    current_balance_usd            NUMERIC(14,2)   NOT NULL                                                 , -- Balance USD
    overdraft_limit_usd            NUMERIC(10,2)   NOT NULL                                                 , -- Overdraft limit USD
    account_status                 VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, FROZEN, DORMANT, CLOSED
    branch_code                    VARCHAR(15)     NOT NULL                                                 , -- Bank branch code
    is_high_risk_flag              BOOLEAN         NOT NULL                                                 , -- High risk account flag
    aml_monitoring_status          VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, ENHANCED, EXEMPT
    last_transaction_date          DATE            NOT NULL                                                 , -- Last active transaction date
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current                     BOOLEAN         NOT NULL                                                 , -- Current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_customer_risk (
    customer_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for customer risk dimension
    source_customer_id             INT             NOT NULL                                                 , -- Natural customer ID from source
    customer_number                VARCHAR(20)     NOT NULL                                                 , -- Customer number
    full_name                      VARCHAR(100)    NOT NULL                                                 , -- Full legal name
    date_of_birth                  DATE            NOT NULL                                                 , -- Birth date
    is_pep_flag                    BOOLEAN         NOT NULL                                                 , -- PEP flag
    sanctions_status               VARCHAR(25)     NOT NULL                                                 , -- Sanctions status text
    kyc_status                     VARCHAR(25)     NOT NULL                                                 , -- KYC status text
    kyc_updated_date               DATE            NOT NULL                                                 , -- KYC date
    risk_rating                    VARCHAR(15)     NOT NULL                                                 , -- Risk category rating
    credit_score                   INT             NOT NULL                                                 , -- Credit score
    annual_income_usd              NUMERIC(12,2)   NOT NULL                                                 , -- Annual income USD
    employment_status              VARCHAR(30)     NOT NULL                                                 , -- Employment status
    residence_country              VARCHAR(3)      NOT NULL                                                 , -- Country ISO-3
    tax_residence_country          VARCHAR(3)      NOT NULL                                                 , -- FATCA country
    active_account_count           INT             NOT NULL                                                 , -- Account count
    total_balance_usd              NUMERIC(14,2)   NOT NULL                                                 , -- Total balance USD
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- Customer status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    updated_timestamp              TIMESTAMP       NOT NULL                                                 , -- Update timestamp
    is_current                     BOOLEAN         NOT NULL                                                 , -- SCD Type 2 current record flag
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_aml_reports (
    sar_fact_key                   BIGINT          PRIMARY KEY                                              , -- Surrogate key for SAR fact
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    filing_date                    DATE            NOT NULL                                                 , -- Filing date key
    fincen_control_number          VARCHAR(25)     NOT NULL                                                 , -- Control number
    suspicious_activity_code       VARCHAR(25)     NOT NULL                                                 , -- Activity code
    suspicious_amount_usd          NUMERIC(12,2)   NOT NULL                                                 , -- Suspicious amount USD
    investigation_days             INT             NOT NULL                                                 , -- Days under investigation
    law_enforcement_flag           BOOLEAN         NOT NULL                                                 , -- Law enforcement notified flag
    account_frozen_flag            BOOLEAN         NOT NULL                                                 , -- Account frozen flag
    regulatory_body_code           VARCHAR(15)     NOT NULL                                                 , -- Regulatory body code
    jurisdiction_code              VARCHAR(10)     NOT NULL                                                 , -- Jurisdiction code
    approval_status                VARCHAR(20)     NOT NULL                                                 , -- Approval status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_financial_transactions (
    transaction_key                BIGINT          PRIMARY KEY                                              , -- Surrogate key for transaction fact
    sender_customer_key            BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    receiver_customer_key          BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    sender_account_key             BIGINT          NOT NULL REFERENCES dim_account_compliance(account_key), -- FK to dim_account_compliance
    transaction_reference          VARCHAR(30)     NOT NULL                                                 , -- Transaction reference code
    transaction_timestamp          TIMESTAMP       NOT NULL                                                 , -- Timestamp key
    transaction_type               VARCHAR(30)     NOT NULL                                                 , -- Type text
    channel_type                   VARCHAR(20)     NOT NULL                                                 , -- Channel text
    principal_amount_usd           NUMERIC(12,2)   NOT NULL                                                 , -- Amount USD
    fee_amount_usd                 NUMERIC(8,2)    NOT NULL                                                 , -- Fee USD
    total_debit_usd                NUMERIC(12,2)   NOT NULL                                                 , -- Total debited USD
    risk_score_numeric             INT             NOT NULL                                                 , -- Risk score 1-100
    fraud_flag                     BOOLEAN         NOT NULL                                                 , -- Confirmed fraud flag
    cross_border_flag              BOOLEAN         NOT NULL                                                 , -- Cross border flag
    location_country               VARCHAR(3)      NOT NULL                                                 , -- Country ISO-3
    aml_status                     VARCHAR(25)     NOT NULL                                                 , -- AML status
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE fact_fraud_alerts (
    alert_key                      BIGINT          PRIMARY KEY                                              , -- Surrogate key for alert fact
    transaction_key                BIGINT          NOT NULL REFERENCES fact_financial_transactions(transaction_key), -- FK to fact_financial_transactions
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customer_risk(customer_key)  , -- FK to dim_customer_risk
    alert_timestamp                TIMESTAMP       NOT NULL                                                 , -- Alert timestamp
    rule_code                      VARCHAR(20)     NOT NULL                                                 , -- Rule triggered code
    rule_name                      VARCHAR(80)     NOT NULL                                                 , -- Rule name text
    severity_level                 VARCHAR(15)     NOT NULL                                                 , -- Severity level
    anomaly_score                  INT             NOT NULL                                                 , -- Anomaly score 1-100
    investigation_status           VARCHAR(25)     NOT NULL                                                 , -- Status text
    resolution_outcome             VARCHAR(40)     NOT NULL                                                 , -- Resolution text
    is_false_positive_flag         BOOLEAN         NOT NULL                                                 , -- False positive flag
    sar_filed_flag                 BOOLEAN         NOT NULL                                                 , -- SAR filed flag
    confirmed_loss_usd             NUMERIC(10,2)   NOT NULL                                                 , -- Loss USD
    recovered_funds_usd            NUMERIC(10,2)   NOT NULL                                                 , -- Recovered USD
    investigation_hours            NUMERIC(5,1)    NOT NULL                                                 , -- Hours to resolve
    created_timestamp              TIMESTAMP       NOT NULL                                                 , -- Creation timestamp
    etl_batch_id                   INT             NOT NULL                                                   -- ETL batch processing ID
);

CREATE TABLE dim_carrier (
    carrier_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_carrier_id              INT             NOT NULL                                                   , -- Source natural ID
    carrier_name                   VARCHAR(80)     NOT NULL                                                   , -- Provider name
    transport_mode                 VARCHAR(20)     NOT NULL                                                     -- Transport mode
);

CREATE TABLE dim_supplier (
    supplier_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_supplier_id             INT             NOT NULL                                                   , -- Source natural ID
    supplier_name                  VARCHAR(100)    NOT NULL                                                   , -- Vendor legal name
    country_code                   VARCHAR(3)      NOT NULL                                                     -- ISO country
);

CREATE TABLE dim_warehouse (
    warehouse_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_warehouse_id            INT             NOT NULL                                                   , -- Source natural ID
    facility_name                  VARCHAR(80)     NOT NULL                                                   , -- Facility name
    city_name                      VARCHAR(50)     NOT NULL                                                     -- Location city
);

CREATE TABLE fact_customs_events (
    customs_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    shipment_key                   BIGINT          NOT NULL REFERENCES fact_shipment(shipment_key)            , -- FK to fact_shipment
    duty_amount_usd                NUMERIC(10,2)   NOT NULL                                                     -- Import duty USD
);

CREATE TABLE fact_freight_billing (
    freight_bill_key               BIGINT          PRIMARY KEY                                                , -- Surrogate key
    shipment_key                   BIGINT          NOT NULL REFERENCES fact_shipment(shipment_key)            , -- FK to fact_shipment
    freight_charge_usd             NUMERIC(10,2)   NOT NULL                                                     -- Freight cost USD
);

CREATE TABLE fact_inventory_snapshot (
    inventory_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    warehouse_key                  BIGINT          NOT NULL REFERENCES dim_warehouse(warehouse_key)           , -- FK to dim_warehouse
    sku_code                       VARCHAR(30)     NOT NULL                                                   , -- Material SKU
    quantity_on_hand               INT             NOT NULL                                                     -- Stock count
);

CREATE TABLE fact_purchase_order (
    po_fact_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    supplier_key                   BIGINT          NOT NULL REFERENCES dim_supplier(supplier_key)             , -- FK to dim_supplier
    warehouse_key                  BIGINT          NOT NULL REFERENCES dim_warehouse(warehouse_key)           , -- FK to dim_warehouse
    po_number                      VARCHAR(30)     NOT NULL                                                   , -- Document number
    total_cost_usd                 NUMERIC(12,2)   NOT NULL                                                     -- Total PO cost USD
);

CREATE TABLE fact_shipment (
    shipment_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    po_fact_key                    BIGINT          NOT NULL REFERENCES fact_purchase_order(po_fact_key)       , -- FK to fact_purchase_order
    carrier_key                    BIGINT          NOT NULL REFERENCES dim_carrier(carrier_key)               , -- FK to dim_carrier
    tracking_number                VARCHAR(40)     NOT NULL                                                     -- Tracking ref
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

CREATE TABLE fact_inventory_snapshot_ecommerce (
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

CREATE TABLE dim_accounts (
    account_key                    BIGINT          PRIMARY KEY                                                , -- Account surrogate key
    source_account_id              INT             NOT NULL                                                   , -- Source natural account ID
    account_number                 VARCHAR(20)     NOT NULL                                                   , -- Standardized account number
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(customer_key)            , -- FK to dim_customers
    account_type_name              VARCHAR(30)     NOT NULL                                                   , -- Account category name
    currency_code                  VARCHAR(3)      NOT NULL                                                   , -- ISO currency code
    is_active                      BOOLEAN         NOT NULL                                                   , -- Account active flag
    created_timestamp              TIMESTAMP       NOT NULL                                                     -- DW record creation timestamp
);

CREATE TABLE dim_branches (
    branch_key                     BIGINT          PRIMARY KEY                                                , -- Branch surrogate key
    branch_code                    VARCHAR(10)     NOT NULL                                                   , -- Natural branch code
    branch_name                    VARCHAR(60)     NOT NULL                                                   , -- Branch designation name
    full_address                   VARCHAR(150)    NOT NULL                                                   , -- Full street address
    city_name                      VARCHAR(50)     NOT NULL                                                   , -- City name
    state_province                 VARCHAR(50)     NOT NULL                                                   , -- State/province code
    postal_code                    VARCHAR(10)     NOT NULL                                                   , -- ZIP/Postal code
    manager_full_name              VARCHAR(60)     NOT NULL                                                   , -- Branch manager full name
    is_operational                 BOOLEAN         NOT NULL                                                     -- Operational boolean flag
);

CREATE TABLE dim_credit_cards (
    card_key                       BIGINT          PRIMARY KEY                                                , -- Credit card surrogate key
    account_key                    BIGINT          NOT NULL REFERENCES dim_accounts(account_key)              , -- FK to dim_accounts
    masked_card_number             VARCHAR(19)     NOT NULL                                                   , -- Masked card number
    card_brand                     VARCHAR(20)     NOT NULL                                                   , -- Card brand network
    credit_limit_usd               NUMERIC(10,2)   NOT NULL                                                   , -- Credit limit USD
    current_balance_usd            NUMERIC(10,2)   NOT NULL                                                   , -- Current balance USD
    expiry_date                    VARCHAR(7)      NOT NULL                                                   , -- Card expiry MM/YYYY
    is_active                      BOOLEAN         NOT NULL                                                     -- Active status indicator
);

CREATE TABLE dim_customers_finance (
    customer_key                   BIGINT          PRIMARY KEY                                                , -- Customer surrogate key
    source_customer_id             INT             NOT NULL                                                   , -- Source natural customer ID
    ssn_tax_id                     VARCHAR(11)     NOT NULL                                                   , -- Masked tax identifier
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full customer name
    primary_email                  VARCHAR(100)    NOT NULL                                                   , -- Standardized email address
    phone_number                   VARCHAR(20)     NOT NULL                                                   , -- Formatted contact phone
    kyc_status_name                VARCHAR(20)     NOT NULL                                                   , -- KYC compliance status
    risk_rating_code               VARCHAR(10)     NOT NULL                                                   , -- Risk tier classification
    is_current                     BOOLEAN         NOT NULL                                                     -- SCD Type 2 current record indicator
);

CREATE TABLE dim_portfolios (
    portfolio_key                  BIGINT          PRIMARY KEY                                                , -- Portfolio surrogate key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(customer_key)            , -- FK to dim_customers
    portfolio_name                 VARCHAR(60)     NOT NULL                                                   , -- Portfolio title name
    investment_strategy            VARCHAR(30)     NOT NULL                                                   , -- Investment strategy category
    total_portfolio_val_usd        NUMERIC(12,2)   NOT NULL                                                   , -- Total portfolio value USD
    risk_profile                   VARCHAR(15)     NOT NULL                                                   , -- Risk profile classification
    created_timestamp              TIMESTAMP       NOT NULL                                                   , -- Creation ISO timestamp
    is_active                      BOOLEAN         NOT NULL                                                     -- Active boolean flag
);

CREATE TABLE fact_audit_events_finance (
    event_key                      BIGINT          PRIMARY KEY                                                , -- Audit event surrogate key
    user_id                        VARCHAR(40)     NOT NULL                                                   , -- Operator user string
    action_category                VARCHAR(30)     NOT NULL                                                   , -- Action category name
    target_entity                  VARCHAR(40)     NOT NULL                                                   , -- Target domain entity
    entity_id                      INT             NOT NULL                                                   , -- Natural entity ID
    user_ip_address                VARCHAR(45)     NOT NULL                                                   , -- User IP address
    event_timestamp                TIMESTAMP       NOT NULL                                                   , -- Event ISO timestamp
    event_result                   VARCHAR(15)     NOT NULL                                                     -- Event outcome result
);

CREATE TABLE fact_loan_payments (
    payment_key                    BIGINT          PRIMARY KEY                                                , -- Loan payment surrogate key
    loan_key                       BIGINT          NOT NULL REFERENCES fact_loans(loan_key)                   , -- FK to fact_loans
    payment_timestamp              TIMESTAMP       NOT NULL                                                   , -- Payment execution timestamp
    principal_amount_paid          NUMERIC(10,2)   NOT NULL                                                   , -- Principal portion paid USD
    interest_amount_paid           NUMERIC(10,2)   NOT NULL                                                   , -- Interest portion paid USD
    total_amount_paid              NUMERIC(10,2)   NOT NULL                                                   , -- Total amount paid USD
    payment_channel                VARCHAR(20)     NOT NULL                                                   , -- Payment method channel
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Payment status
);

CREATE TABLE fact_loans (
    loan_key                       BIGINT          PRIMARY KEY                                                , -- Loan surrogate key
    customer_key                   BIGINT          NOT NULL REFERENCES dim_customers(customer_key)            , -- FK to dim_customers
    loan_type_code                 VARCHAR(20)     NOT NULL                                                   , -- Loan category code
    principal_amount_usd           NUMERIC(12,2)   NOT NULL                                                   , -- Disbursed principal amount USD
    annual_interest_rate           NUMERIC(5,2)    NOT NULL                                                   , -- Interest percentage rate
    term_months                    INT             NOT NULL                                                   , -- Loan term duration in months
    start_date                     DATE            NOT NULL                                                   , -- Loan start date
    remaining_balance_usd          NUMERIC(12,2)   NOT NULL                                                   , -- Current balance in USD
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Status code
);

CREATE TABLE fact_transactions (
    transaction_key                BIGINT          PRIMARY KEY                                                , -- Transaction surrogate key
    account_key                    BIGINT          NOT NULL REFERENCES dim_accounts(account_key)              , -- FK to dim_accounts
    transaction_ref                VARCHAR(36)     NOT NULL                                                   , -- Enterprise reference code
    txn_type                       VARCHAR(20)     NOT NULL                                                   , -- Transaction classification
    transaction_amount_usd         NUMERIC(12,2)   NOT NULL                                                   , -- Transaction amount in USD
    transaction_timestamp          TIMESTAMP       NOT NULL                                                   , -- Transaction ISO timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                   , -- Standardized status code
    dim_date_key                   INT             NOT NULL                                                     -- Date key YYYYMMDD
);

CREATE TABLE fact_wire_transfers (
    transfer_key                   BIGINT          PRIMARY KEY                                                , -- Transfer surrogate key
    source_account_key             BIGINT          NOT NULL REFERENCES dim_accounts(account_key)              , -- FK to dim_accounts
    dest_account_number            VARCHAR(34)     NOT NULL                                                   , -- Destination account IBAN
    swift_bic_code                 VARCHAR(11)     NOT NULL                                                   , -- Destination SWIFT code
    transfer_amount_usd            NUMERIC(12,2)   NOT NULL                                                   , -- Transfer amount USD
    transfer_fee_usd               NUMERIC(8,2)    NOT NULL                                                   , -- Transfer fee USD
    transfer_timestamp             TIMESTAMP       NOT NULL                                                   , -- Transfer execution timestamp
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Status code
);

CREATE TABLE dim_department (
    department_key                 BIGINT          PRIMARY KEY                                                , -- Department surrogate key
    source_dept_id                 INT             NOT NULL                                                   , -- Source department natural ID
    department_code                VARCHAR(10)     NOT NULL                                                   , -- Natural department code
    department_name                VARCHAR(50)     NOT NULL                                                   , -- Department name
    manager_employee_key           BIGINT          NOT NULL                                                   , -- Managing employee key
    location_key                   BIGINT          NOT NULL                                                   , -- Office location key
    annual_budget_usd              NUMERIC(12,2)   NOT NULL                                                   , -- Annual budget USD
    is_active                      BOOLEAN         NOT NULL                                                     -- Active boolean indicator
);

CREATE TABLE dim_employee (
    employee_key                   BIGINT          PRIMARY KEY                                                , -- Employee surrogate key
    source_employee_id             INT             NOT NULL                                                   , -- Source natural employee ID
    national_id                    VARCHAR(11)     NOT NULL                                                   , -- Masked national identity SSN
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Full employee name
    work_email                     VARCHAR(100)    NOT NULL                                                   , -- Corporate email address
    hire_date                      DATE            NOT NULL                                                   , -- Employment start date
    job_title                      VARCHAR(50)     NOT NULL                                                   , -- Standardized job title
    department_key                 BIGINT          NOT NULL REFERENCES dim_department(department_key)         , -- FK to dim_department
    employment_status_code         VARCHAR(15)     NOT NULL                                                     -- Employment status code
);

CREATE TABLE dim_job_positions (
    position_key                   BIGINT          PRIMARY KEY                                                , -- Position surrogate key
    position_code                  VARCHAR(10)     NOT NULL                                                   , -- Natural position code
    position_title                 VARCHAR(50)     NOT NULL                                                   , -- Position title name
    salary_grade_min               NUMERIC(10,2)   NOT NULL                                                   , -- Minimum salary USD
    salary_grade_max               NUMERIC(10,2)   NOT NULL                                                   , -- Maximum salary USD
    department_key                 BIGINT          NOT NULL                                                   , -- FK to dim_department
    position_status                VARCHAR(10)     NOT NULL                                                     -- Position status
);

CREATE TABLE fact_daily_attendance (
    attendance_key                 BIGINT          PRIMARY KEY                                                , -- Attendance surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    shift_date                     DATE            NOT NULL                                                   , -- Work shift date
    clock_in_timestamp             TIMESTAMP       NOT NULL                                                   , -- Clock in ISO timestamp
    clock_out_timestamp            TIMESTAMP       NOT NULL                                                   , -- Clock out ISO timestamp
    total_worked_hours             NUMERIC(4,2)    NOT NULL                                                   , -- Total regular worked hours
    total_overtime_hours           NUMERIC(4,2)    NOT NULL                                                   , -- Total overtime worked hours
    attendance_status              VARCHAR(15)     NOT NULL                                                     -- Attendance status code
);

CREATE TABLE fact_employee_benefits (
    benefit_key                    BIGINT          PRIMARY KEY                                                , -- Benefit surrogate key
    employee_key                   BIGINT          NOT NULL REFERENCES dim_employee(employee_key)             , -- FK to dim_employee
    benefit_plan_name              VARCHAR(50)     NOT NULL                                                   , -- Benefit plan title
    benefit_category               VARCHAR(25)     NOT NULL                                                   , -- Benefit category code
    employer_contribution_usd      NUMERIC(8,2)    NOT NULL                                                   , -- Monthly employer cost USD
    employee_contribution_usd      NUMERIC(8,2)    NOT NULL                                                   , -- Monthly employee cost USD
    enrollment_date                DATE            NOT NULL                                                   , -- Plan enrollment date
    coverage_status                VARCHAR(15)     NOT NULL                                                     -- Coverage status
);

CREATE TABLE fact_payroll_disbursements (
    payroll_key                    BIGINT          PRIMARY KEY                                                , -- Payroll surrogate key
    employee_key                   BIGINT          NOT NULL REFERENCES dim_employee(employee_key)             , -- FK to dim_employee
    pay_period_start_date          DATE            NOT NULL                                                   , -- Pay period start date
    pay_period_end_date            DATE            NOT NULL                                                   , -- Pay period end date
    gross_pay_usd                  NUMERIC(10,2)   NOT NULL                                                   , -- Gross compensation pay USD
    net_pay_usd                    NUMERIC(10,2)   NOT NULL                                                   , -- Net take-home pay USD
    total_tax_deduction_usd        NUMERIC(10,2)   NOT NULL                                                   , -- Total tax withholdings USD
    disbursement_date              DATE            NOT NULL                                                   , -- Disbursement execution date
    payment_status                 VARCHAR(15)     NOT NULL                                                     -- Payment status code
);

CREATE TABLE fact_performance_appraisals (
    review_key                     BIGINT          PRIMARY KEY                                                , -- Performance review surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    reviewer_employee_key          BIGINT          NOT NULL                                                   , -- Reviewer employee key
    appraisal_cycle                VARCHAR(10)     NOT NULL                                                   , -- Appraisal cycle period
    rating_score                   NUMERIC(3,2)    NOT NULL                                                   , -- Score decimal 1.00 - 5.00
    appraisal_date                 DATE            NOT NULL                                                   , -- Review date
    evaluation_notes               TEXT            NULL                                                       , -- Appraisal summary comments
    status_code                    VARCHAR(15)     NOT NULL                                                     -- Review status
);

CREATE TABLE fact_salary_history (
    salary_key                     BIGINT          PRIMARY KEY                                                , -- Salary surrogate key
    employee_key                   BIGINT          NOT NULL REFERENCES dim_employee(employee_key)             , -- FK to dim_employee
    base_salary_usd                NUMERIC(10,2)   NOT NULL                                                   , -- Annual base salary USD
    currency_code                  VARCHAR(3)      NOT NULL                                                   , -- ISO currency code
    effective_date                 DATE            NOT NULL                                                   , -- Start effective date
    end_date                       DATE            NULL                                                       , -- End effective date
    pay_frequency_code             VARCHAR(15)     NOT NULL                                                   , -- Pay frequency code
    is_active_record               BOOLEAN         NOT NULL                                                     -- Current active salary record flag
);

CREATE TABLE fact_timeoff (
    timeoff_key                    BIGINT          PRIMARY KEY                                                , -- Timeoff surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    leave_category                 VARCHAR(20)     NOT NULL                                                   , -- Leave category code
    start_date                     DATE            NOT NULL                                                   , -- Leave start date
    end_date                       DATE            NOT NULL                                                   , -- Leave end date
    duration_days                  NUMERIC(4,1)    NOT NULL                                                   , -- Duration in work days
    approval_status_code           VARCHAR(15)     NOT NULL                                                   , -- Approval status code
    request_timestamp              TIMESTAMP       NOT NULL                                                     -- Request timestamp ISO
);

CREATE TABLE fact_training_completions (
    training_key                   BIGINT          PRIMARY KEY                                                , -- Training completion surrogate key
    employee_key                   BIGINT          NOT NULL                                                   , -- FK to dim_employee
    course_title                   VARCHAR(80)     NOT NULL                                                   , -- Course title name
    training_provider              VARCHAR(50)     NOT NULL                                                   , -- Provider name
    completion_date                DATE            NOT NULL                                                   , -- Completion date
    final_score_pct                INT             NOT NULL                                                   , -- Score percentage
    certification_flag             BOOLEAN         NOT NULL                                                     -- Certification earned boolean flag
);

CREATE TABLE dim_aircraft (
    aircraft_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_aircraft_id             INT             NOT NULL                                                   , -- Natural ID
    model_name                     VARCHAR(40)     NOT NULL                                                     -- Model name
);

CREATE TABLE dim_airport (
    airport_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_airport_id              INT             NOT NULL                                                   , -- Natural ID
    iata_code                      VARCHAR(3)      NOT NULL                                                     -- IATA code
);

CREATE TABLE dim_passenger (
    passenger_key                  BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_passenger_id            INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE fact_flight_bookings (
    booking_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    passenger_key                  BIGINT          NOT NULL REFERENCES dim_passenger(passenger_key)           , -- FK to dim_passenger
    ticket_price_usd               NUMERIC(8,2)    NOT NULL                                                     -- Price USD
);

CREATE TABLE dim_client (
    client_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_client_id               INT             NOT NULL                                                   , -- Natural ID
    client_name                    VARCHAR(100)    NOT NULL                                                     -- Client name
);

CREATE TABLE dim_security (
    security_key                   BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_security_id             INT             NOT NULL                                                   , -- Natural ID
    ticker_symbol                  VARCHAR(10)     NOT NULL                                                     -- Ticker
);

CREATE TABLE fact_asset_transactions (
    transaction_key                BIGINT          PRIMARY KEY                                                , -- Surrogate key
    client_key                     BIGINT          NOT NULL REFERENCES dim_client(client_key)                 , -- FK to dim_client
    security_key                   BIGINT          NOT NULL REFERENCES dim_security(security_key)             , -- FK to dim_security
    total_amount_usd               NUMERIC(12,2)   NOT NULL                                                     -- Amount USD
);

CREATE TABLE fact_portfolio_holdings (
    holding_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    client_key                     BIGINT          NOT NULL REFERENCES dim_client(client_key)                 , -- FK to dim_client
    security_key                   BIGINT          NOT NULL REFERENCES dim_security(security_key)             , -- FK to dim_security
    shares_count                   NUMERIC(12,4)   NOT NULL                                                     -- Shares count
);

CREATE TABLE dim_buyer (
    buyer_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_buyer_id                INT             NOT NULL                                                   , -- Natural ID
    full_name                      VARCHAR(100)    NOT NULL                                                     -- Full name
);

CREATE TABLE dim_dealer (
    dealer_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_dealer_id               INT             NOT NULL                                                   , -- Natural ID
    dealer_name                    VARCHAR(80)     NOT NULL                                                     -- Dealer name
);

CREATE TABLE dim_vehicle (
    vehicle_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_vehicle_id              INT             NOT NULL                                                   , -- Natural ID
    vin                            VARCHAR(17)     NOT NULL                                                   , -- VIN
    make                           VARCHAR(30)     NOT NULL                                                   , -- Make
    model                          VARCHAR(40)     NOT NULL                                                     -- Model
);

CREATE TABLE fact_car_sales (
    sale_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    vehicle_key                    BIGINT          NOT NULL REFERENCES dim_vehicle(vehicle_key)               , -- FK to dim_vehicle
    buyer_key                      BIGINT          NOT NULL REFERENCES dim_buyer(buyer_key)                   , -- FK to dim_buyer
    dealer_key                     BIGINT          NOT NULL REFERENCES dim_dealer(dealer_key)                 , -- FK to dim_dealer
    sale_price_usd                 NUMERIC(10,2)   NOT NULL                                                     -- Sale price USD
);

CREATE TABLE fact_service_revenue (
    service_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    vehicle_key                    BIGINT          NOT NULL REFERENCES dim_vehicle(vehicle_key)               , -- FK to dim_vehicle
    service_cost_usd               NUMERIC(8,2)    NOT NULL                                                     -- Service cost USD
);

CREATE TABLE dim_creator (
    creator_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_creator_id              INT             NOT NULL                                                   , -- Natural ID
    creator_name                   VARCHAR(100)    NOT NULL                                                     -- Creator name
);

CREATE TABLE dim_media (
    media_key                      BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_media_id                INT             NOT NULL                                                   , -- Natural ID
    creator_key                    BIGINT          NOT NULL REFERENCES dim_creator(creator_key)               , -- FK to dim_creator
    title                          VARCHAR(120)    NOT NULL                                                   , -- Media title
    media_type                     VARCHAR(20)     NOT NULL                                                     -- Media type
);

CREATE TABLE dim_subscriber (
    user_key                       BIGINT          PRIMARY KEY                                                , -- Surrogate key
    source_user_id                 INT             NOT NULL                                                   , -- Natural ID
    username                       VARCHAR(50)     NOT NULL                                                     -- Username
);

CREATE TABLE fact_stream_events (
    stream_key                     BIGINT          PRIMARY KEY                                                , -- Surrogate key
    user_key                       BIGINT          NOT NULL REFERENCES dim_subscriber(user_key)               , -- FK to dim_subscriber
    media_key                      BIGINT          NOT NULL REFERENCES dim_media(media_key)                   , -- FK to dim_media
    streamed_seconds               INT             NOT NULL                                                     -- Streamed seconds
);

CREATE TABLE fact_subscription_revenue (
    revenue_key                    BIGINT          PRIMARY KEY                                                , -- Surrogate key
    user_key                       BIGINT          NOT NULL REFERENCES dim_subscriber(user_key)               , -- FK to dim_subscriber
    amount_usd                     NUMERIC(8,2)    NOT NULL                                                     -- Monthly amount USD
);
