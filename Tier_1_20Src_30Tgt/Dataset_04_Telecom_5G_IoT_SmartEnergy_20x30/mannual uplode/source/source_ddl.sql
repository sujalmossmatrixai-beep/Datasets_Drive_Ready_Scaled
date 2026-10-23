-- ========================================================
-- Master DDL Schema Script for Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30_source
-- Tier: Tier 1: 20 Source Tables, 30 Target Tables
-- Total Tables: 20
-- Domains Included: Dataset_12_Energy_Smart_Grid_Dataset, Dataset_14_Fitness_Wearable_IoT_Dataset, Dataset_28_Telecom_Cellular_Dataset, Dataset_29_Telecommunications_5G_Network_Dataset
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
