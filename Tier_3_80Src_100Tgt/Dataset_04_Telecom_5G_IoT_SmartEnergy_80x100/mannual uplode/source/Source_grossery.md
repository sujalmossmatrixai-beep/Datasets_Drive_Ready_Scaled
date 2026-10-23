# Business Data Glossary - Dataset_04_Telecom_5G_IoT_SmartEnergy_80x100_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_04_Telecom_5G_IoT_SmartEnergy_80x100_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_04_Telecom_5G_IoT_SmartEnergy_80x100
- **Component**: Source Database Schema (Dataset_04_Telecom_5G_IoT_SmartEnergy_80x100_source)
- **Tier Specification**: Tier 3: 80 Source Tables, 100 Target Tables
- **Total Source Tables**: 80
- **Theme Focus**: 5G Telecommunications, Cellular Infrastructure, Smart Grid & Energy IoT
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `tbl_call_detail_records`
**Description**: Domain table for `tbl_call_detail_records` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cdr_id` | **Cdr Id** | `INT` | `PRIMARY KEY` | CDR primary key ID |
| `subscriber_id` | **Subscriber Id** | `INT` | `FOREIGN KEY` | FK to tbl_subscribers |
| `tower_id` | **Tower Id** | `INT` | `FOREIGN KEY` | FK to tbl_cell_towers |
| `call_type` | **Call Type** | `VARCHAR(10)` | `NOT NULL` | VOICE/SMS |
| `duration_seconds` | **Duration Seconds** | `INT` | `NOT NULL` | Call duration |
| `call_timestamp` | **Call Timestamp** | `TIMESTAMP` | `NOT NULL` | Call timestamp |

---

---

### Table: `tbl_cell_towers`
**Description**: Domain table for `tbl_cell_towers` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tower_id` | **Tower Id** | `INT` | `PRIMARY KEY` | Tower primary key ID |
| `tower_code` | **Tower Code** | `VARCHAR(20)` | `NOT NULL` | Tower station code |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City location |
| `coverage_radius_km` | **Coverage Radius Km** | `DECIMAL(4,1)` | `NOT NULL` | Coverage range km |

---

---

### Table: `tbl_data_usage_logs`
**Description**: Domain table for `tbl_data_usage_logs` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `usage_id` | **Usage Id** | `INT` | `PRIMARY KEY` | Usage primary key ID |
| `subscriber_id` | **Subscriber Id** | `INT` | `FOREIGN KEY` | FK to tbl_subscribers |
| `tower_id` | **Tower Id** | `INT` | `FOREIGN KEY` | FK to tbl_cell_towers |
| `mb_downloaded` | **Mb Downloaded** | `DECIMAL(10,2)` | `NOT NULL` | Download MB |
| `mb_uploaded` | **Mb Uploaded** | `DECIMAL(10,2)` | `NOT NULL` | Upload MB |
| `session_start` | **Session Start** | `TIMESTAMP` | `NOT NULL` | Session start timestamp |

---

---

### Table: `tbl_network_outages`
**Description**: Domain table for `tbl_network_outages` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `outage_id` | **Outage Id** | `INT` | `PRIMARY KEY` | Outage primary key ID |
| `tower_id` | **Tower Id** | `INT` | `FOREIGN KEY` | FK to tbl_cell_towers |
| `outage_start` | **Outage Start** | `TIMESTAMP` | `NOT NULL` | Start time |
| `outage_end` | **Outage End** | `TIMESTAMP` | `NULL` | Resolution time |

---

---

### Table: `tbl_plans`
**Description**: Domain table for `tbl_plans` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `plan_id` | **Plan Id** | `INT` | `PRIMARY KEY` | Plan primary key ID |
| `plan_name` | **Plan Name** | `VARCHAR(50)` | `NOT NULL` | Plan tier name |
| `monthly_fee` | **Monthly Fee** | `DECIMAL(8,2)` | `NOT NULL` | Monthly price |
| `data_limit_gb` | **Data Limit Gb** | `INT` | `NOT NULL` | Data allowance GB |

---

---

### Table: `tbl_sim_cards`
**Description**: Domain table for `tbl_sim_cards` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sim_id` | **Sim Id** | `INT` | `PRIMARY KEY` | SIM primary key ID |
| `subscriber_id` | **Subscriber Id** | `INT` | `FOREIGN KEY` | FK to tbl_subscribers |
| `iccid` | **Iccid** | `VARCHAR(22)` | `NOT NULL` | SIM card serial number |
| `imsi` | **Imsi** | `VARCHAR(15)` | `NOT NULL` | Subscriber network ID |

---

---

### Table: `tbl_subscriber_bills`
**Description**: Domain table for `tbl_subscriber_bills` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `bill_id` | **Bill Id** | `INT` | `PRIMARY KEY` | Bill primary key ID |
| `subscriber_id` | **Subscriber Id** | `INT` | `FOREIGN KEY` | FK to tbl_subscribers |
| `billing_cycle_date` | **Billing Cycle Date** | `DATE` | `NOT NULL` | Billing date |
| `total_amount_due` | **Total Amount Due** | `DECIMAL(10,2)` | `NOT NULL` | Total bill amount |

---

---

### Table: `tbl_subscribers`
**Description**: Domain table for `tbl_subscribers` in `Telecom_Cellular_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `subscriber_id` | **Subscriber Id** | `INT` | `PRIMARY KEY` | Subscriber primary key ID |
| `plan_id` | **Plan Id** | `INT` | `FOREIGN KEY` | FK to tbl_plans |
| `account_number` | **Account Number** | `VARCHAR(30)` | `NOT NULL` | Subscriber account number |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Customer full name |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Assigned phone number |

---

---

### Table: `tbl_5g_cell_towers`
**Description**: Domain table for `tbl_5g_cell_towers` in `Telecommunications_5G_Network_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tower_id` | **Tower Id** | `INT` | `PRIMARY KEY` | 5G cell tower primary key ID |
| `tower_code` | **Tower Code** | `VARCHAR(20)` | `NOT NULL` | Tower unique site identifier |
| `tower_name` | **Tower Name** | `VARCHAR(80)` | `NOT NULL` | Site geographical name |
| `latitude` | **Latitude** | `DECIMAL(8,4)` | `NOT NULL` | Tower GPS latitude coordinate |
| `longitude` | **Longitude** | `DECIMAL(8,4)` | `NOT NULL` | Tower GPS longitude coordinate |
| `altitude_meters` | **Altitude Meters** | `INT` | `NOT NULL` | Tower height elevation in meters |
| `region_code` | **Region Code** | `VARCHAR(15)` | `NOT NULL` | Network operating region code |
| `frequency_band_ghz` | **Frequency Band Ghz** | `DECIMAL(4,2)` | `NOT NULL` | Operating spectrum band GHz (mmWave/Sub-6) |
| `max_bandwidth_gbps` | **Max Bandwidth Gbps** | `DECIMAL(6,2)` | `NOT NULL` | Maximum site throughput Gbps |
| `antenna_count` | **Antenna Count** | `INT` | `NOT NULL` | Massive MIMO antenna array count |
| `coverage_radius_km` | **Coverage Radius Km** | `DECIMAL(4,2)` | `NOT NULL` | Cellular coverage radius km |
| `power_consumption_kw` | **Power Consumption Kw** | `DECIMAL(6,2)` | `NOT NULL` | Power usage kilowatts |
| `vendor_name` | **Vendor Name** | `VARCHAR(50)` | `NOT NULL` | Telecom equipment manufacturer |
| `installation_date` | **Installation Date** | `DATE` | `NOT NULL` | Commissioning date |
| `last_maintenance_date` | **Last Maintenance Date** | `DATE` | `NOT NULL` | Last service maintenance date |
| `operational_status` | **Operational Status** | `VARCHAR(25)` | `NOT NULL` | ONLINE, MAINTENANCE, DEGRADED, OFFLINE |
| `backhaul_type` | **Backhaul Type** | `VARCHAR(30)` | `NOT NULL` | FIBER_OPTIC, MICROWAVE, SATELLITE |
| `ip_address` | **Ip Address** | `VARCHAR(45)` | `NOT NULL` | Management IP address |
| `firmware_version` | **Firmware Version** | `VARCHAR(20)` | `NOT NULL` | Baseband firmware software version |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Site maintenance notes |

---

---

### Table: `tbl_call_detail_records_5g`
**Description**: Domain table for `tbl_call_detail_records_5g` in `Telecommunications_5G_Network_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cdr_id` | **Cdr Id** | `INT` | `PRIMARY KEY` | 5G CDR primary key ID |
| `caller_msisdn` | **Caller Msisdn** | `VARCHAR(20)` | `NOT NULL` | Originating mobile phone number |
| `callee_msisdn` | **Callee Msisdn** | `VARCHAR(20)` | `NOT NULL` | Terminating mobile phone number |
| `tower_id` | **Tower Id** | `INT` | `FOREIGN KEY` | FK to tbl_5g_cell_towers |
| `call_start_timestamp` | **Call Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Voice/video session start time |
| `call_end_timestamp` | **Call End Timestamp** | `TIMESTAMP` | `NOT NULL` | Voice/video session end time |
| `duration_seconds` | **Duration Seconds** | `INT` | `NOT NULL` | Call duration in seconds |
| `call_type` | **Call Type** | `VARCHAR(30)` | `NOT NULL` | VONR_5G, VOLTE_4G, VIDEO_CALL, EMERGENCY |
| `termination_reason` | **Termination Reason** | `VARCHAR(30)` | `NOT NULL` | NORMAL_CLEAR, HANDOVER_FAIL, DROPPED |
| `audio_codec` | **Audio Codec** | `VARCHAR(25)` | `NOT NULL` | Voice audio compression codec |
| `signal_strength_dbm` | **Signal Strength Dbm** | `INT` | `NOT NULL` | RSRP signal strength dBm |
| `latency_ms` | **Latency Ms** | `DECIMAL(5,2)` | `NOT NULL` | Packet latency milliseconds |
| `packet_loss_pct` | **Packet Loss Pct** | `DECIMAL(4,2)` | `NOT NULL` | Packet loss percentage |
| `is_roaming` | **Is Roaming** | `BOOLEAN` | `NOT NULL` | Roaming connection flag |
| `carrier_code` | **Carrier Code** | `VARCHAR(15)` | `NOT NULL` | Home network carrier code |
| `billing_charge_usd` | **Billing Charge Usd** | `DECIMAL(6,2)` | `NOT NULL` | Assessed call charge USD |
| `qos_index` | **Qos Index** | `INT` | `NOT NULL` | Quality of Service Flow ID (QFI) |
| `cell_sector_id` | **Cell Sector Id** | `VARCHAR(15)` | `NOT NULL` | Tower antenna sector code |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | BILLED, UNBILLED, DISPUTED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Session network diagnostic notes |

---

---

### Table: `tbl_data_session_logs`
**Description**: Domain table for `tbl_data_session_logs` in `Telecommunications_5G_Network_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `session_id` | **Session Id** | `INT` | `PRIMARY KEY` | Data session primary key ID |
| `subscriber_id` | **Subscriber Id** | `INT` | `NOT NULL` | Subscriber customer ID |
| `device_id` | **Device Id** | `INT` | `FOREIGN KEY` | FK to tbl_subscriber_devices |
| `tower_id` | **Tower Id** | `INT` | `FOREIGN KEY` | FK to tbl_5g_cell_towers |
| `session_start_time` | **Session Start Time** | `TIMESTAMP` | `NOT NULL` | Data session connect time |
| `session_end_time` | **Session End Time** | `TIMESTAMP` | `NOT NULL` | Data session disconnect time |
| `download_mb` | **Download Mb** | `DECIMAL(10,2)` | `NOT NULL` | Downloaded data volume MB |
| `upload_mb` | **Upload Mb** | `DECIMAL(10,2)` | `NOT NULL` | Uploaded data volume MB |
| `total_data_mb` | **Total Data Mb** | `DECIMAL(10,2)` | `NOT NULL` | Total session data payload MB |
| `peak_speed_mbps` | **Peak Speed Mbps** | `DECIMAL(8,2)` | `NOT NULL` | Peak throughput megabits/sec |
| `avg_latency_ms` | **Avg Latency Ms** | `DECIMAL(5,2)` | `NOT NULL` | Average ping latency ms |
| `protocol_type` | **Protocol Type** | `VARCHAR(20)` | `NOT NULL` | HTTPS, QUIC, UDP, TCP, WEBSOCKET |
| `apn_name` | **Apn Name** | `VARCHAR(40)` | `NOT NULL` | Access Point Name configuration |
| `ip_assigned` | **Ip Assigned** | `VARCHAR(45)` | `NOT NULL` | Assigned IPv6 / IPv4 address |
| `slice_id_5g` | **Slice Id 5g** | `VARCHAR(20)` | `NOT NULL` | 5G Network Slice Identifier (NSSI) |
| `billing_charge_usd` | **Billing Charge Usd** | `DECIMAL(8,2)` | `NOT NULL` | Usage data charge USD |
| `disconnection_reason` | **Disconnection Reason** | `VARCHAR(30)` | `NOT NULL` | USER_DETACH, INACTIVITY, TOWER_HANDOVER |
| `network_mode` | **Network Mode** | `VARCHAR(20)` | `NOT NULL` | 5G_STANDALONE, 5G_NON_STANDALONE |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | CLOSED, ACTIVE, ERROR |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Session diagnostic comments |

---

---

### Table: `tbl_network_outage_events`
**Description**: Domain table for `tbl_network_outage_events` in `Telecommunications_5G_Network_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_id` | **Event Id** | `INT` | `PRIMARY KEY` | Outage event primary key ID |
| `tower_id` | **Tower Id** | `INT` | `FOREIGN KEY` | FK to tbl_5g_cell_towers |
| `outage_code` | **Outage Code** | `VARCHAR(20)` | `NOT NULL` | Network fault event ticket ID |
| `start_time` | **Start Time** | `TIMESTAMP` | `NOT NULL` | Outage start timestamp |
| `end_time` | **End Time** | `TIMESTAMP` | `NOT NULL` | Outage resolution timestamp |
| `duration_minutes` | **Duration Minutes** | `INT` | `NOT NULL` | Total downtime duration minutes |
| `root_cause` | **Root Cause** | `VARCHAR(50)` | `NOT NULL` | FIBER_CUT, POWER_FAILURE, HARDWARE_FAULT |
| `severity_level` | **Severity Level** | `VARCHAR(15)` | `NOT NULL` | CRITICAL, MAJOR, MINOR, WARNING |
| `affected_subscribers_count` | **Affected Subscribers Count** | `INT` | `NOT NULL` | Impacted active users count |
| `technician_id` | **Technician Id** | `INT` | `NOT NULL` | Assigned field engineer ID |
| `resolution_description` | **Resolution Description** | `VARCHAR(200)` | `NOT NULL` | Action taken to restore site |
| `backup_power_used_flag` | **Backup Power Used Flag** | `BOOLEAN` | `NOT NULL` | Battery/generator power flag |
| `sla_breached_flag` | **Sla Breached Flag** | `BOOLEAN` | `NOT NULL` | SLA downtime violation flag |
| `penalty_cost_usd` | **Penalty Cost Usd** | `DECIMAL(10,2)` | `NOT NULL` | Contract penalty cost USD |
| `region_code` | **Region Code** | `VARCHAR(15)` | `NOT NULL` | Operating region code |
| `weather_conditions` | **Weather Conditions** | `VARCHAR(30)` | `NOT NULL` | CLEAR, HEAVY_RAIN, BLIZZARD, THUNDERSTORM |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | RESOLVED, INVESTIGATING, CLOSED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Outage post-mortem summary |

---

---

### Table: `tbl_subscriber_devices`
**Description**: Domain table for `tbl_subscriber_devices` in `Telecommunications_5G_Network_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `device_id` | **Device Id** | `INT` | `PRIMARY KEY` | Subscriber device primary key ID |
| `imei_number` | **Imei Number** | `VARCHAR(20)` | `NOT NULL` | International Mobile Equipment Identity |
| `subscriber_id` | **Subscriber Id** | `INT` | `NOT NULL` | Subscriber customer ID |
| `device_brand` | **Device Brand** | `VARCHAR(40)` | `NOT NULL` | Handset brand manufacturer |
| `device_model` | **Device Model** | `VARCHAR(50)` | `NOT NULL` | Smartphone model name |
| `operating_system` | **Operating System** | `VARCHAR(20)` | `NOT NULL` | iOS or Android |
| `os_version` | **Os Version** | `VARCHAR(20)` | `NOT NULL` | OS software build version |
| `is_5g_capable` | **Is 5g Capable** | `BOOLEAN` | `NOT NULL` | 5G network capability flag |
| `volte_supported_flag` | **Volte Supported Flag** | `BOOLEAN` | `NOT NULL` | VoLTE voice over LTE flag |
| `sim_card_id` | **Sim Card Id** | `VARCHAR(25)` | `NOT NULL` | ICCID SIM card identification number |
| `first_activation_date` | **First Activation Date** | `DATE` | `NOT NULL` | First network registration date |
| `last_seen_timestamp` | **Last Seen Timestamp** | `TIMESTAMP` | `NOT NULL` | Last network heartbeat timestamp |
| `battery_health_pct` | **Battery Health Pct** | `INT` | `NOT NULL` | Device battery capacity health % |
| `storage_gb` | **Storage Gb** | `INT` | `NOT NULL` | Internal storage gigabytes |
| `ram_gb` | **Ram Gb** | `INT` | `NOT NULL` | System RAM memory gigabytes |
| `mac_address` | **Mac Address** | `VARCHAR(20)` | `NOT NULL` | Wi-Fi / Bluetooth MAC address |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | ACTIVE, SUSPENDED, LOST, RETIRED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Device provision comments |

---

---

### Table: `tbl_meter_telemetry_reads`
**Description**: Domain table for `tbl_meter_telemetry_reads` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `read_id` | **Read Id** | `INT` | `PRIMARY KEY` | Read primary key ID |
| `meter_id` | **Meter Id** | `INT` | `FOREIGN KEY` | FK to tbl_smart_meters |
| `kwh_consumption` | **Kwh Consumption** | `DECIMAL(10,3)` | `NOT NULL` | Power consumption kWh |
| `voltage_reading` | **Voltage Reading** | `DECIMAL(6,2)` | `NOT NULL` | Voltage reading |
| `read_timestamp` | **Read Timestamp** | `TIMESTAMP` | `NOT NULL` | Meter read timestamp |

---

---

### Table: `tbl_power_outage_events`
**Description**: Domain table for `tbl_power_outage_events` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `outage_id` | **Outage Id** | `INT` | `PRIMARY KEY` | Outage primary key ID |
| `substation_id` | **Substation Id** | `INT` | `FOREIGN KEY` | FK to tbl_substations |
| `affected_customers` | **Affected Customers** | `INT` | `NOT NULL` | Impacted customer count |
| `outage_start` | **Outage Start** | `TIMESTAMP` | `NOT NULL` | Outage start |

---

---

### Table: `tbl_smart_meters`
**Description**: Domain table for `tbl_smart_meters` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `meter_id` | **Meter Id** | `INT` | `PRIMARY KEY` | Meter primary key ID |
| `substation_id` | **Substation Id** | `INT` | `FOREIGN KEY` | FK to tbl_substations |
| `meter_serial_number` | **Meter Serial Number** | `VARCHAR(30)` | `NOT NULL` | Hardware serial number |

---

---

### Table: `tbl_substations`
**Description**: Domain table for `tbl_substations` in `Energy_Smart_Grid_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `substation_id` | **Substation Id** | `INT` | `PRIMARY KEY` | Substation primary key ID |
| `grid_code` | **Grid Code** | `VARCHAR(20)` | `NOT NULL` | Grid station code |
| `region_name` | **Region Name** | `VARCHAR(50)` | `NOT NULL` | Service region |

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

---

### Table: `tbl_investment_portfolios`
**Description**: Domain table for `tbl_investment_portfolios` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `portfolio_id` | **Portfolio Id** | `INT` | `PRIMARY KEY` | Portfolio primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | Investor customer ID |
| `portfolio_name` | **Portfolio Name** | `VARCHAR(60)` | `NOT NULL` | Portfolio title |
| `portfolio_type` | **Portfolio Type** | `VARCHAR(25)` | `NOT NULL` | GROWTH/BALANCED/CONSERVATIVE |
| `total_value` | **Total Value** | `DECIMAL(12,2)` | `NOT NULL` | Total asset market value |
| `risk_level` | **Risk Level** | `VARCHAR(15)` | `NOT NULL` | MODERATE/AGGRESSIVE/LOW |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Portfolio creation date |
| `status_code` | **Status Code** | `VARCHAR(10)` | `NOT NULL` | ACTIVE/LIQUIDATED |

---

---

### Table: `tbl_loan_payments`
**Description**: Domain table for `tbl_loan_payments` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_id` | **Payment Id** | `INT` | `PRIMARY KEY` | Loan payment primary key ID |
| `loan_id` | **Loan Id** | `INT` | `FOREIGN KEY` | Associated loan ID |
| `payment_date` | **Payment Date** | `DATE` | `NOT NULL` | Payment execution date |
| `principal_paid` | **Principal Paid** | `DECIMAL(10,2)` | `NOT NULL` | Principal portion paid |
| `interest_paid` | **Interest Paid** | `DECIMAL(10,2)` | `NOT NULL` | Interest portion paid |
| `total_paid` | **Total Paid** | `DECIMAL(10,2)` | `NOT NULL` | Total amount paid |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | AUTOPAY/WIRE/CHECK |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | POSTED/PENDING/REVERSED |

---

---

### Table: `tbl_loans`
**Description**: Domain table for `tbl_loans` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `loan_id` | **Loan Id** | `INT` | `PRIMARY KEY` | Loan primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | Borrower customer ID |
| `loan_type` | **Loan Type** | `VARCHAR(20)` | `NOT NULL` | MORTGAGE/AUTO/PERSONAL/BUSINESS |
| `principal_amount` | **Principal Amount** | `DECIMAL(12,2)` | `NOT NULL` | Original loan principal |
| `interest_rate` | **Interest Rate** | `DECIMAL(5,2)` | `NOT NULL` | Annual percentage interest rate |
| `term_months` | **Term Months** | `INT` | `NOT NULL` | Loan duration in months |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Loan disbursement date |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/PAID_OFF/DEFAULTED |
| `remaining_balance` | **Remaining Balance** | `DECIMAL(12,2)` | `NOT NULL` | Outstanding principal balance |

---

---

### Table: `tbl_transactions`
**Description**: Domain table for `tbl_transactions` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_id` | **Transaction Id** | `INT` | `PRIMARY KEY` | Transaction primary key ID |
| `account_id` | **Account Id** | `INT` | `FOREIGN KEY` | Associated account ID |
| `txn_reference` | **Txn Reference** | `VARCHAR(36)` | `NOT NULL` | Unique transaction reference code |
| `txn_type` | **Txn Type** | `VARCHAR(20)` | `NOT NULL` | DEPOSIT/WITHDRAWAL/TRANSFER/FEE |
| `amount` | **Amount** | `DECIMAL(10,2)` | `NOT NULL` | Transaction amount |
| `txn_date` | **Txn Date** | `TIMESTAMP` | `NOT NULL` | Transaction timestamp |
| `description` | **Description** | `VARCHAR(100)` | `NOT NULL` | Transaction narrative note |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | COMPLETED/PENDING/FAILED |

---

---

### Table: `tbl_wire_transfers`
**Description**: Domain table for `tbl_wire_transfers` in `Finance_Banking_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transfer_id` | **Transfer Id** | `INT` | `PRIMARY KEY` | Wire transfer primary key ID |
| `source_account_id` | **Source Account Id** | `INT` | `FOREIGN KEY` | Originating account ID |
| `dest_account_number` | **Dest Account Number** | `VARCHAR(34)` | `NOT NULL` | Destination IBAN or account |
| `swift_code` | **Swift Code** | `VARCHAR(11)` | `NOT NULL` | Destination SWIFT/BIC code |
| `amount` | **Amount** | `DECIMAL(12,2)` | `NOT NULL` | Transfer amount |
| `fee_amount` | **Fee Amount** | `DECIMAL(8,2)` | `NOT NULL` | Service fee charged |
| `transfer_date` | **Transfer Date** | `TIMESTAMP` | `NOT NULL` | Execution timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | SETTLED/PROCESSING/CANCELLED |

---

---

### Table: `tbl_attendances`
**Description**: Domain table for `tbl_attendances` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `attendance_id` | **Attendance Id** | `INT` | `PRIMARY KEY` | Attendance entry primary key ID |
| `employee_id` | **Employee Id** | `INT` | `NOT NULL` | Employee ID |
| `work_date` | **Work Date** | `DATE` | `NOT NULL` | Shift work date |
| `check_in_time` | **Check In Time** | `TIMESTAMP` | `NOT NULL` | Clock in timestamp |
| `check_out_time` | **Check Out Time** | `TIMESTAMP` | `NOT NULL` | Clock out timestamp |
| `hours_worked` | **Hours Worked** | `DECIMAL(4,2)` | `NOT NULL` | Total regular hours worked |
| `overtime_hours` | **Overtime Hours** | `DECIMAL(4,2)` | `NOT NULL` | Total overtime hours worked |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | PRESENT/LATE/ABSENT |

---

---

### Table: `tbl_benefits`
**Description**: Domain table for `tbl_benefits` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `benefit_id` | **Benefit Id** | `INT` | `PRIMARY KEY` | Benefit enrollment primary key ID |
| `employee_id` | **Employee Id** | `INT` | `FOREIGN KEY` | Enrolled employee ID |
| `plan_name` | **Plan Name** | `VARCHAR(50)` | `NOT NULL` | Benefit plan designation |
| `benefit_type` | **Benefit Type** | `VARCHAR(25)` | `NOT NULL` | HEALTH/DENTAL/VISION/401K |
| `employer_cost` | **Employer Cost** | `DECIMAL(8,2)` | `NOT NULL` | Employer monthly contribution |
| `employee_cost` | **Employee Cost** | `DECIMAL(8,2)` | `NOT NULL` | Employee monthly payroll deduction |
| `enrollment_date` | **Enrollment Date** | `DATE` | `NOT NULL` | Benefit plan enrollment date |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | ENROLLED/CANCELLED |

---

---

### Table: `tbl_departments`
**Description**: Domain table for `tbl_departments` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `department_id` | **Department Id** | `INT` | `PRIMARY KEY` | Department primary key ID |
| `dept_code` | **Dept Code** | `VARCHAR(10)` | `NOT NULL` | Unique department code |
| `dept_name` | **Dept Name** | `VARCHAR(50)` | `NOT NULL` | Department title name |
| `manager_id` | **Manager Id** | `INT` | `NOT NULL` | Managing employee ID |
| `location_id` | **Location Id** | `INT` | `NOT NULL` | Office location ID |
| `budget_amount` | **Budget Amount** | `DECIMAL(12,2)` | `NOT NULL` | Annual department budget |
| `is_active` | **Is Active** | `VARCHAR(1)` | `NOT NULL` | Active flag Y/N |

---

---

### Table: `tbl_employees`
**Description**: Domain table for `tbl_employees` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `employee_id` | **Employee Id** | `INT` | `PRIMARY KEY` | Employee primary key ID |
| `ssn_number` | **Ssn Number** | `VARCHAR(11)` | `NOT NULL` | Social Security Number |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | Employee given first name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Employee family last name |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Corporate email address |
| `hire_date` | **Hire Date** | `DATE` | `NOT NULL` | Employment start date |
| `job_title` | **Job Title** | `VARCHAR(50)` | `NOT NULL` | Assigned job title |
| `department_id` | **Department Id** | `INT` | `FOREIGN KEY` | Assigned department ID |
| `employment_status` | **Employment Status** | `VARCHAR(15)` | `NOT NULL` | ACTIVE/TERMINATED/LEAVE |

---

---

### Table: `tbl_job_positions`
**Description**: Domain table for `tbl_job_positions` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `position_id` | **Position Id** | `INT` | `PRIMARY KEY` | Job position primary key ID |
| `position_code` | **Position Code** | `VARCHAR(10)` | `NOT NULL` | Unique position code |
| `position_title` | **Position Title** | `VARCHAR(50)` | `NOT NULL` | Standardized job title |
| `min_salary` | **Min Salary** | `DECIMAL(10,2)` | `NOT NULL` | Minimum salary band |
| `max_salary` | **Max Salary** | `DECIMAL(10,2)` | `NOT NULL` | Maximum salary band |
| `department_id` | **Department Id** | `INT` | `NOT NULL` | Parent department ID |
| `status_code` | **Status Code** | `VARCHAR(10)` | `NOT NULL` | ACTIVE/OPEN/CLOSED |

---

---

### Table: `tbl_payrolls`
**Description**: Domain table for `tbl_payrolls` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payroll_id` | **Payroll Id** | `INT` | `PRIMARY KEY` | Payroll record primary key ID |
| `employee_id` | **Employee Id** | `INT` | `FOREIGN KEY` | Employee ID |
| `pay_period_start` | **Pay Period Start** | `DATE` | `NOT NULL` | Pay cycle start date |
| `pay_period_end` | **Pay Period End** | `DATE` | `NOT NULL` | Pay cycle end date |
| `gross_pay` | **Gross Pay** | `DECIMAL(10,2)` | `NOT NULL` | Gross compensation pay |
| `net_pay` | **Net Pay** | `DECIMAL(10,2)` | `NOT NULL` | Net take-home pay |
| `tax_deductions` | **Tax Deductions** | `DECIMAL(10,2)` | `NOT NULL` | Total tax withholdings |
| `payment_date` | **Payment Date** | `DATE` | `NOT NULL` | Disbursement date |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | PROCESSED/PENDING |

---

---

### Table: `tbl_performance_reviews`
**Description**: Domain table for `tbl_performance_reviews` in `HR_Payroll_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `review_id` | **Review Id** | `INT` | `PRIMARY KEY` | Performance review primary key ID |
| `employee_id` | **Employee Id** | `INT` | `NOT NULL` | Evaluated employee ID |
| `reviewer_id` | **Reviewer Id** | `INT` | `NOT NULL` | Reviewer manager employee ID |
| `review_period` | **Review Period** | `VARCHAR(10)` | `NOT NULL` | Review cycle e.g. 2024-Q4 |
| `performance_score` | **Performance Score** | `DECIMAL(3,2)` | `NOT NULL` | Rating score 1.00 - 5.00 |
| `review_date` | **Review Date** | `DATE` | `NOT NULL` | Appraisal review date |
| `feedback_notes` | **Feedback Notes** | `TEXT` | `NULL` | Manager evaluation comments |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | COMPLETED/DRAFT |

---