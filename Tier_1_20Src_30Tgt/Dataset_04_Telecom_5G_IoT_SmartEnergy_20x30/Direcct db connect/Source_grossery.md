# Business Data Glossary - Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30
- **Component**: Source Database Schema (Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
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