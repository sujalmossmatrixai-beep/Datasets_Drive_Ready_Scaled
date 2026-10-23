-- ========================================================
-- Master DDL Schema Script for Dataset_04_Telecom_5G_IoT_SmartEnergy_60x50_source
-- Tier: Tier 2: 60 Source Tables, 50 Target Tables
-- Total Tables: 60
-- Domains Included: Dataset_01_Ecommerce_Dataset, Dataset_02_Healthcare_Hospital_Dataset, Dataset_12_Energy_Smart_Grid_Dataset, Dataset_14_Fitness_Wearable_IoT_Dataset, Dataset_28_Telecom_Cellular_Dataset, Dataset_29_Telecommunications_5G_Network_Dataset
-- ========================================================

CREATE TABLE tbl_call_detail_records (
    cdr_id                         INT             PRIMARY KEY                                                , -- CDR primary key ID
    subscriber_id                  INT             NOT NULL REFERENCES tbl_subscribers(subscriber_id)         , -- FK to tbl_subscribers
    tower_id                       INT             NOT NULL REFERENCES tbl_cell_towers(tower_id)              , -- FK to tbl_cell_towers
    call_type                      VARCHAR(10)     NOT NULL                                                   , -- VOICE/SMS
    duration_seconds               INT             NOT NULL                                                   , -- Call duration
    call_timestamp                 TIMESTAMP       NOT NULL                                                     -- Call timestamp
);

CREATE TABLE tbl_cell_towers (
    tower_id                       INT             PRIMARY KEY                                                , -- Tower primary key ID
    tower_code                     VARCHAR(20)     NOT NULL                                                   , -- Tower station code
    city                           VARCHAR(50)     NOT NULL                                                   , -- City location
    coverage_radius_km             DECIMAL(4,1)    NOT NULL                                                     -- Coverage range km
);

CREATE TABLE tbl_data_usage_logs (
    usage_id                       INT             PRIMARY KEY                                                , -- Usage primary key ID
    subscriber_id                  INT             NOT NULL REFERENCES tbl_subscribers(subscriber_id)         , -- FK to tbl_subscribers
    tower_id                       INT             NOT NULL REFERENCES tbl_cell_towers(tower_id)              , -- FK to tbl_cell_towers
    mb_downloaded                  DECIMAL(10,2)   NOT NULL                                                   , -- Download MB
    mb_uploaded                    DECIMAL(10,2)   NOT NULL                                                   , -- Upload MB
    session_start                  TIMESTAMP       NOT NULL                                                     -- Session start timestamp
);

CREATE TABLE tbl_network_outages (
    outage_id                      INT             PRIMARY KEY                                                , -- Outage primary key ID
    tower_id                       INT             NOT NULL REFERENCES tbl_cell_towers(tower_id)              , -- FK to tbl_cell_towers
    outage_start                   TIMESTAMP       NOT NULL                                                   , -- Start time
    outage_end                     TIMESTAMP       NULL                                                         -- Resolution time
);

CREATE TABLE tbl_plans (
    plan_id                        INT             PRIMARY KEY                                                , -- Plan primary key ID
    plan_name                      VARCHAR(50)     NOT NULL                                                   , -- Plan tier name
    monthly_fee                    DECIMAL(8,2)    NOT NULL                                                   , -- Monthly price
    data_limit_gb                  INT             NOT NULL                                                     -- Data allowance GB
);

CREATE TABLE tbl_sim_cards (
    sim_id                         INT             PRIMARY KEY                                                , -- SIM primary key ID
    subscriber_id                  INT             NOT NULL REFERENCES tbl_subscribers(subscriber_id)         , -- FK to tbl_subscribers
    iccid                          VARCHAR(22)     NOT NULL                                                   , -- SIM card serial number
    imsi                           VARCHAR(15)     NOT NULL                                                     -- Subscriber network ID
);

CREATE TABLE tbl_subscriber_bills (
    bill_id                        INT             PRIMARY KEY                                                , -- Bill primary key ID
    subscriber_id                  INT             NOT NULL REFERENCES tbl_subscribers(subscriber_id)         , -- FK to tbl_subscribers
    billing_cycle_date             DATE            NOT NULL                                                   , -- Billing date
    total_amount_due               DECIMAL(10,2)   NOT NULL                                                     -- Total bill amount
);

CREATE TABLE tbl_subscribers (
    subscriber_id                  INT             PRIMARY KEY                                                , -- Subscriber primary key ID
    plan_id                        INT             NOT NULL REFERENCES tbl_plans(plan_id)                     , -- FK to tbl_plans
    account_number                 VARCHAR(30)     NOT NULL                                                   , -- Subscriber account number
    full_name                      VARCHAR(100)    NOT NULL                                                   , -- Customer full name
    phone_number                   VARCHAR(20)     NOT NULL                                                     -- Assigned phone number
);

CREATE TABLE tbl_5g_cell_towers (
    tower_id                       INT             PRIMARY KEY                                              , -- 5G cell tower primary key ID
    tower_code                     VARCHAR(20)     NOT NULL                                                 , -- Tower unique site identifier
    tower_name                     VARCHAR(80)     NOT NULL                                                 , -- Site geographical name
    latitude                       DECIMAL(8,4)    NOT NULL                                                 , -- Tower GPS latitude coordinate
    longitude                      DECIMAL(8,4)    NOT NULL                                                 , -- Tower GPS longitude coordinate
    altitude_meters                INT             NOT NULL                                                 , -- Tower height elevation in meters
    region_code                    VARCHAR(15)     NOT NULL                                                 , -- Network operating region code
    frequency_band_ghz             DECIMAL(4,2)    NOT NULL                                                 , -- Operating spectrum band GHz (mmWave/Sub-6)
    max_bandwidth_gbps             DECIMAL(6,2)    NOT NULL                                                 , -- Maximum site throughput Gbps
    antenna_count                  INT             NOT NULL                                                 , -- Massive MIMO antenna array count
    coverage_radius_km             DECIMAL(4,2)    NOT NULL                                                 , -- Cellular coverage radius km
    power_consumption_kw           DECIMAL(6,2)    NOT NULL                                                 , -- Power usage kilowatts
    vendor_name                    VARCHAR(50)     NOT NULL                                                 , -- Telecom equipment manufacturer
    installation_date              DATE            NOT NULL                                                 , -- Commissioning date
    last_maintenance_date          DATE            NOT NULL                                                 , -- Last service maintenance date
    operational_status             VARCHAR(25)     NOT NULL                                                 , -- ONLINE, MAINTENANCE, DEGRADED, OFFLINE
    backhaul_type                  VARCHAR(30)     NOT NULL                                                 , -- FIBER_OPTIC, MICROWAVE, SATELLITE
    ip_address                     VARCHAR(45)     NOT NULL                                                 , -- Management IP address
    firmware_version               VARCHAR(20)     NOT NULL                                                 , -- Baseband firmware software version
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    notes                          VARCHAR(150)    NOT NULL                                                   -- Site maintenance notes
);

CREATE TABLE tbl_call_detail_records_5g (
    cdr_id                         INT             PRIMARY KEY                                              , -- 5G CDR primary key ID
    caller_msisdn                  VARCHAR(20)     NOT NULL                                                 , -- Originating mobile phone number
    callee_msisdn                  VARCHAR(20)     NOT NULL                                                 , -- Terminating mobile phone number
    tower_id                       INT             NOT NULL REFERENCES tbl_5g_cell_towers(tower_id)     , -- FK to tbl_5g_cell_towers
    call_start_timestamp           TIMESTAMP       NOT NULL                                                 , -- Voice/video session start time
    call_end_timestamp             TIMESTAMP       NOT NULL                                                 , -- Voice/video session end time
    duration_seconds               INT             NOT NULL                                                 , -- Call duration in seconds
    call_type                      VARCHAR(30)     NOT NULL                                                 , -- VONR_5G, VOLTE_4G, VIDEO_CALL, EMERGENCY
    termination_reason             VARCHAR(30)     NOT NULL                                                 , -- NORMAL_CLEAR, HANDOVER_FAIL, DROPPED
    audio_codec                    VARCHAR(25)     NOT NULL                                                 , -- Voice audio compression codec
    signal_strength_dbm            INT             NOT NULL                                                 , -- RSRP signal strength dBm
    latency_ms                     DECIMAL(5,2)    NOT NULL                                                 , -- Packet latency milliseconds
    packet_loss_pct                DECIMAL(4,2)    NOT NULL                                                 , -- Packet loss percentage
    is_roaming                     BOOLEAN         NOT NULL                                                 , -- Roaming connection flag
    carrier_code                   VARCHAR(15)     NOT NULL                                                 , -- Home network carrier code
    billing_charge_usd             DECIMAL(6,2)    NOT NULL                                                 , -- Assessed call charge USD
    qos_index                      INT             NOT NULL                                                 , -- Quality of Service Flow ID (QFI)
    cell_sector_id                 VARCHAR(15)     NOT NULL                                                 , -- Tower antenna sector code
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- BILLED, UNBILLED, DISPUTED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Session network diagnostic notes
);

CREATE TABLE tbl_data_session_logs (
    session_id                     INT             PRIMARY KEY                                              , -- Data session primary key ID
    subscriber_id                  INT             NOT NULL                                                 , -- Subscriber customer ID
    device_id                      INT             NOT NULL REFERENCES tbl_subscriber_devices(device_id), -- FK to tbl_subscriber_devices
    tower_id                       INT             NOT NULL REFERENCES tbl_5g_cell_towers(tower_id)     , -- FK to tbl_5g_cell_towers
    session_start_time             TIMESTAMP       NOT NULL                                                 , -- Data session connect time
    session_end_time               TIMESTAMP       NOT NULL                                                 , -- Data session disconnect time
    download_mb                    DECIMAL(10,2)   NOT NULL                                                 , -- Downloaded data volume MB
    upload_mb                      DECIMAL(10,2)   NOT NULL                                                 , -- Uploaded data volume MB
    total_data_mb                  DECIMAL(10,2)   NOT NULL                                                 , -- Total session data payload MB
    peak_speed_mbps                DECIMAL(8,2)    NOT NULL                                                 , -- Peak throughput megabits/sec
    avg_latency_ms                 DECIMAL(5,2)    NOT NULL                                                 , -- Average ping latency ms
    protocol_type                  VARCHAR(20)     NOT NULL                                                 , -- HTTPS, QUIC, UDP, TCP, WEBSOCKET
    apn_name                       VARCHAR(40)     NOT NULL                                                 , -- Access Point Name configuration
    ip_assigned                    VARCHAR(45)     NOT NULL                                                 , -- Assigned IPv6 / IPv4 address
    slice_id_5g                    VARCHAR(20)     NOT NULL                                                 , -- 5G Network Slice Identifier (NSSI)
    billing_charge_usd             DECIMAL(8,2)    NOT NULL                                                 , -- Usage data charge USD
    disconnection_reason           VARCHAR(30)     NOT NULL                                                 , -- USER_DETACH, INACTIVITY, TOWER_HANDOVER
    network_mode                   VARCHAR(20)     NOT NULL                                                 , -- 5G_STANDALONE, 5G_NON_STANDALONE
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- CLOSED, ACTIVE, ERROR
    notes                          VARCHAR(150)    NOT NULL                                                   -- Session diagnostic comments
);

CREATE TABLE tbl_network_outage_events (
    event_id                       INT             PRIMARY KEY                                              , -- Outage event primary key ID
    tower_id                       INT             NOT NULL REFERENCES tbl_5g_cell_towers(tower_id)     , -- FK to tbl_5g_cell_towers
    outage_code                    VARCHAR(20)     NOT NULL                                                 , -- Network fault event ticket ID
    start_time                     TIMESTAMP       NOT NULL                                                 , -- Outage start timestamp
    end_time                       TIMESTAMP       NOT NULL                                                 , -- Outage resolution timestamp
    duration_minutes               INT             NOT NULL                                                 , -- Total downtime duration minutes
    root_cause                     VARCHAR(50)     NOT NULL                                                 , -- FIBER_CUT, POWER_FAILURE, HARDWARE_FAULT
    severity_level                 VARCHAR(15)     NOT NULL                                                 , -- CRITICAL, MAJOR, MINOR, WARNING
    affected_subscribers_count     INT             NOT NULL                                                 , -- Impacted active users count
    technician_id                  INT             NOT NULL                                                 , -- Assigned field engineer ID
    resolution_description         VARCHAR(200)    NOT NULL                                                 , -- Action taken to restore site
    backup_power_used_flag         BOOLEAN         NOT NULL                                                 , -- Battery/generator power flag
    sla_breached_flag              BOOLEAN         NOT NULL                                                 , -- SLA downtime violation flag
    penalty_cost_usd               DECIMAL(10,2)   NOT NULL                                                 , -- Contract penalty cost USD
    region_code                    VARCHAR(15)     NOT NULL                                                 , -- Operating region code
    weather_conditions             VARCHAR(30)     NOT NULL                                                 , -- CLEAR, HEAVY_RAIN, BLIZZARD, THUNDERSTORM
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- RESOLVED, INVESTIGATING, CLOSED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Outage post-mortem summary
);

CREATE TABLE tbl_subscriber_devices (
    device_id                      INT             PRIMARY KEY                                              , -- Subscriber device primary key ID
    imei_number                    VARCHAR(20)     NOT NULL                                                 , -- International Mobile Equipment Identity
    subscriber_id                  INT             NOT NULL                                                 , -- Subscriber customer ID
    device_brand                   VARCHAR(40)     NOT NULL                                                 , -- Handset brand manufacturer
    device_model                   VARCHAR(50)     NOT NULL                                                 , -- Smartphone model name
    operating_system               VARCHAR(20)     NOT NULL                                                 , -- iOS or Android
    os_version                     VARCHAR(20)     NOT NULL                                                 , -- OS software build version
    is_5g_capable                  BOOLEAN         NOT NULL                                                 , -- 5G network capability flag
    volte_supported_flag           BOOLEAN         NOT NULL                                                 , -- VoLTE voice over LTE flag
    sim_card_id                    VARCHAR(25)     NOT NULL                                                 , -- ICCID SIM card identification number
    first_activation_date          DATE            NOT NULL                                                 , -- First network registration date
    last_seen_timestamp            TIMESTAMP       NOT NULL                                                 , -- Last network heartbeat timestamp
    battery_health_pct             INT             NOT NULL                                                 , -- Device battery capacity health %
    storage_gb                     INT             NOT NULL                                                 , -- Internal storage gigabytes
    ram_gb                         INT             NOT NULL                                                 , -- System RAM memory gigabytes
    mac_address                    VARCHAR(20)     NOT NULL                                                 , -- Wi-Fi / Bluetooth MAC address
    created_at                     TIMESTAMP       NOT NULL                                                 , -- Record creation timestamp
    updated_at                     TIMESTAMP       NOT NULL                                                 , -- Record update timestamp
    status_code                    VARCHAR(20)     NOT NULL                                                 , -- ACTIVE, SUSPENDED, LOST, RETIRED
    notes                          VARCHAR(150)    NOT NULL                                                   -- Device provision comments
);

CREATE TABLE tbl_meter_telemetry_reads (
    read_id                        INT             PRIMARY KEY                                                , -- Read primary key ID
    meter_id                       INT             NOT NULL REFERENCES tbl_smart_meters(meter_id)             , -- FK to tbl_smart_meters
    kwh_consumption                DECIMAL(10,3)   NOT NULL                                                   , -- Power consumption kWh
    voltage_reading                DECIMAL(6,2)    NOT NULL                                                   , -- Voltage reading
    read_timestamp                 TIMESTAMP       NOT NULL                                                     -- Meter read timestamp
);

CREATE TABLE tbl_power_outage_events (
    outage_id                      INT             PRIMARY KEY                                                , -- Outage primary key ID
    substation_id                  INT             NOT NULL REFERENCES tbl_substations(substation_id)         , -- FK to tbl_substations
    affected_customers             INT             NOT NULL                                                   , -- Impacted customer count
    outage_start                   TIMESTAMP       NOT NULL                                                     -- Outage start
);

CREATE TABLE tbl_smart_meters (
    meter_id                       INT             PRIMARY KEY                                                , -- Meter primary key ID
    substation_id                  INT             NOT NULL REFERENCES tbl_substations(substation_id)         , -- FK to tbl_substations
    meter_serial_number            VARCHAR(30)     NOT NULL                                                     -- Hardware serial number
);

CREATE TABLE tbl_substations (
    substation_id                  INT             PRIMARY KEY                                                , -- Substation primary key ID
    grid_code                      VARCHAR(20)     NOT NULL                                                   , -- Grid station code
    region_name                    VARCHAR(50)     NOT NULL                                                     -- Service region
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
