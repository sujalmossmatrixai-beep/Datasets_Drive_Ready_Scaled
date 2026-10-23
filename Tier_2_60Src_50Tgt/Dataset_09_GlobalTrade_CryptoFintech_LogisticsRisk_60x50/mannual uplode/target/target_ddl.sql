-- ========================================================
-- Master DDL Schema Script for Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_60x50_target
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 50
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_08_Banking_Fraud_Risk_Compliance_Dataset, Dataset_09_Cryptocurrency_Exchange_Dataset, Dataset_17_Global_Logistics_Shipping_Dataset, Dataset_27_Supply_Chain_Logistics_Dataset
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
