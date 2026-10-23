# Business Data Glossary - Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30
- **Component**: Target Database Schema (Dataset_04_Telecom_5G_IoT_SmartEnergy_20x30_target)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Target Tables**: 30
- **Theme Focus**: 5G Telecommunications, Cellular Infrastructure, Smart Grid & Energy IoT
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `dim_cell_tower`
**Description**: Domain table for `dim_cell_tower` in `Telecom_Cellular_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tower_key` | **Tower Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_tower_id` | **Source Tower Id** | `INT` | `NOT NULL` | Natural ID |
| `tower_code` | **Tower Code** | `VARCHAR(20)` | `NOT NULL` | Station code |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |

---

---

### Table: `dim_plan`
**Description**: Domain table for `dim_plan` in `Telecom_Cellular_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `plan_key` | **Plan Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_plan_id` | **Source Plan Id** | `INT` | `NOT NULL` | Natural ID |
| `plan_name` | **Plan Name** | `VARCHAR(50)` | `NOT NULL` | Plan name |
| `monthly_fee_usd` | **Monthly Fee Usd** | `NUMERIC(8,2)` | `NOT NULL` | Fee USD |

---

---

### Table: `dim_subscriber`
**Description**: Domain table for `dim_subscriber` in `Telecom_Cellular_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `subscriber_key` | **Subscriber Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_subscriber_id` | **Source Subscriber Id** | `INT` | `NOT NULL` | Natural ID |
| `plan_key` | **Plan Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_plan |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Phone number |

---

---

### Table: `fact_call_detail`
**Description**: Domain table for `fact_call_detail` in `Telecom_Cellular_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `cdr_key` | **Cdr Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `subscriber_key` | **Subscriber Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_subscriber |
| `tower_key` | **Tower Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_cell_tower |
| `duration_seconds` | **Duration Seconds** | `INT` | `NOT NULL` | Call duration |

---

---

### Table: `fact_data_usage`
**Description**: Domain table for `fact_data_usage` in `Telecom_Cellular_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `usage_key` | **Usage Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `subscriber_key` | **Subscriber Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_subscriber |
| `tower_key` | **Tower Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_cell_tower |
| `mb_downloaded` | **Mb Downloaded** | `NUMERIC(10,2)` | `NOT NULL` | Download MB |

---

---

### Table: `fact_subscriber_billing`
**Description**: Domain table for `fact_subscriber_billing` in `Telecom_Cellular_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `bill_key` | **Bill Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `subscriber_key` | **Subscriber Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_subscriber |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Billed amount USD |

---

---

### Table: `dim_cell_tower_telecommunications_telecommunications`
**Description**: Domain table for `dim_cell_tower_telecommunications` in `Telecommunications_5G_Network_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `tower_key` | **Tower Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for tower dimension |
| `source_tower_id` | **Source Tower Id** | `INT` | `NOT NULL` | Natural tower ID from source |
| `tower_code` | **Tower Code** | `VARCHAR(20)` | `NOT NULL` | Tower site code |
| `site_name` | **Site Name** | `VARCHAR(80)` | `NOT NULL` | Tower geographical site name |
| `region_code` | **Region Code** | `VARCHAR(15)` | `NOT NULL` | Network region code |
| `vendor_name` | **Vendor Name** | `VARCHAR(50)` | `NOT NULL` | Equipment vendor name |
| `latitude` | **Latitude** | `NUMERIC(8,4)` | `NOT NULL` | Latitude |
| `longitude` | **Longitude** | `NUMERIC(8,4)` | `NOT NULL` | Longitude |
| `altitude_meters` | **Altitude Meters** | `INT` | `NOT NULL` | Altitude meters |
| `frequency_band_ghz` | **Frequency Band Ghz** | `NUMERIC(4,2)` | `NOT NULL` | Frequency GHz |
| `max_bandwidth_gbps` | **Max Bandwidth Gbps** | `NUMERIC(6,2)` | `NOT NULL` | Max bandwidth Gbps |
| `antenna_array_count` | **Antenna Array Count** | `INT` | `NOT NULL` | MIMO antennas count |
| `coverage_radius_km` | **Coverage Radius Km** | `NUMERIC(4,2)` | `NOT NULL` | Coverage radius km |
| `power_usage_kw` | **Power Usage Kw** | `NUMERIC(6,2)` | `NOT NULL` | Power usage kW |
| `operational_status` | **Operational Status** | `VARCHAR(25)` | `NOT NULL` | Operational status |
| `backhaul_type` | **Backhaul Type** | `VARCHAR(30)` | `NOT NULL` | Backhaul connection type |
| `firmware_build` | **Firmware Build** | `VARCHAR(20)` | `NOT NULL` | Firmware version |
| `commissioned_date` | **Commissioned Date** | `DATE` | `NOT NULL` | Commissioning date |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_subscriber_device`
**Description**: Domain table for `dim_subscriber_device` in `Telecommunications_5G_Network_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `device_key` | **Device Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for device dimension |
| `source_device_id` | **Source Device Id** | `INT` | `NOT NULL` | Natural device ID from source |
| `imei_number` | **Imei Number** | `VARCHAR(20)` | `NOT NULL` | IMEI number |
| `device_brand` | **Device Brand** | `VARCHAR(40)` | `NOT NULL` | Handset brand |
| `device_model` | **Device Model** | `VARCHAR(50)` | `NOT NULL` | Model name |
| `operating_system` | **Operating System** | `VARCHAR(20)` | `NOT NULL` | Operating system |
| `os_version` | **Os Version** | `VARCHAR(20)` | `NOT NULL` | OS version |
| `is_5g_capable` | **Is 5g Capable** | `BOOLEAN` | `NOT NULL` | 5G capable flag |
| `volte_supported` | **Volte Supported** | `BOOLEAN` | `NOT NULL` | VoLTE supported flag |
| `storage_capacity_gb` | **Storage Capacity Gb** | `INT` | `NOT NULL` | Storage GB |
| `ram_memory_gb` | **Ram Memory Gb** | `INT` | `NOT NULL` | RAM GB |
| `battery_health_pct` | **Battery Health Pct** | `INT` | `NOT NULL` | Battery health % |
| `activation_date` | **Activation Date** | `DATE` | `NOT NULL` | Activation date |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Status code |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current_record` | **Is Current Record** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_call_detail_5g`
**Description**: Domain table for `fact_call_detail_5g` in `Telecommunications_5G_Network_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `call_fact_key` | **Call Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for call fact |
| `tower_key` | **Tower Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_cell_tower |
| `device_key` | **Device Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_subscriber_device |
| `caller_msisdn` | **Caller Msisdn** | `VARCHAR(20)` | `NOT NULL` | Caller number |
| `callee_msisdn` | **Callee Msisdn** | `VARCHAR(20)` | `NOT NULL` | Callee number |
| `call_start_timestamp` | **Call Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Call start timestamp |
| `duration_seconds` | **Duration Seconds** | `INT` | `NOT NULL` | Call duration in seconds |
| `call_type` | **Call Type** | `VARCHAR(30)` | `NOT NULL` | VoNR or VoLTE call type |
| `termination_reason` | **Termination Reason** | `VARCHAR(30)` | `NOT NULL` | Call clearing reason |
| `audio_codec` | **Audio Codec** | `VARCHAR(25)` | `NOT NULL` | Audio codec code |
| `signal_strength_dbm` | **Signal Strength Dbm** | `INT` | `NOT NULL` | RSRP signal strength dBm |
| `latency_ms` | **Latency Ms** | `NUMERIC(5,2)` | `NOT NULL` | Latency ms |
| `packet_loss_pct` | **Packet Loss Pct** | `NUMERIC(4,2)` | `NOT NULL` | Packet loss % |
| `billing_charge_usd` | **Billing Charge Usd** | `NUMERIC(6,2)` | `NOT NULL` | Charge amount USD |
| `qos_flow_id` | **Qos Flow Id** | `INT` | `NOT NULL` | QoS Flow ID QFI |
| `is_roaming_flag` | **Is Roaming Flag** | `BOOLEAN` | `NOT NULL` | Roaming flag |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Billing status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_data_usage_sessions`
**Description**: Domain table for `fact_data_usage_sessions` in `Telecommunications_5G_Network_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `session_fact_key` | **Session Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for session fact |
| `tower_key` | **Tower Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_cell_tower |
| `device_key` | **Device Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_subscriber_device |
| `session_start_time` | **Session Start Time** | `TIMESTAMP` | `NOT NULL` | Session connect time |
| `session_end_time` | **Session End Time** | `TIMESTAMP` | `NOT NULL` | Session disconnect time |
| `download_mb` | **Download Mb** | `NUMERIC(10,2)` | `NOT NULL` | Download MB |
| `upload_mb` | **Upload Mb** | `NUMERIC(10,2)` | `NOT NULL` | Upload MB |
| `total_data_mb` | **Total Data Mb** | `NUMERIC(10,2)` | `NOT NULL` | Total payload MB |
| `peak_speed_mbps` | **Peak Speed Mbps** | `NUMERIC(8,2)` | `NOT NULL` | Peak speed Mbps |
| `avg_latency_ms` | **Avg Latency Ms** | `NUMERIC(5,2)` | `NOT NULL` | Latency ms |
| `protocol_type` | **Protocol Type** | `VARCHAR(20)` | `NOT NULL` | Network protocol |
| `apn_name` | **Apn Name** | `VARCHAR(40)` | `NOT NULL` | APN string |
| `slice_id_5g` | **Slice Id 5g** | `VARCHAR(20)` | `NOT NULL` | 5G slice ID |
| `billing_charge_usd` | **Billing Charge Usd** | `NUMERIC(8,2)` | `NOT NULL` | Data charge USD |
| `network_mode` | **Network Mode** | `VARCHAR(20)` | `NOT NULL` | Network mode |
| `disconnection_reason` | **Disconnection Reason** | `VARCHAR(30)` | `NOT NULL` | Disconnect reason |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_network_outages`
**Description**: Domain table for `fact_network_outages` in `Telecommunications_5G_Network_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `outage_fact_key` | **Outage Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for outage fact |
| `tower_key` | **Tower Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_cell_tower |
| `outage_code` | **Outage Code** | `VARCHAR(20)` | `NOT NULL` | Outage ticket code |
| `start_time` | **Start Time** | `TIMESTAMP` | `NOT NULL` | Outage start time |
| `end_time` | **End Time** | `TIMESTAMP` | `NOT NULL` | Outage end time |
| `duration_minutes` | **Duration Minutes** | `INT` | `NOT NULL` | Duration in minutes |
| `root_cause` | **Root Cause** | `VARCHAR(50)` | `NOT NULL` | Root cause description |
| `severity_level` | **Severity Level** | `VARCHAR(15)` | `NOT NULL` | Severity level code |
| `affected_users_count` | **Affected Users Count** | `INT` | `NOT NULL` | Impacted user count |
| `penalty_cost_usd` | **Penalty Cost Usd** | `NUMERIC(10,2)` | `NOT NULL` | Penalty cost USD |
| `backup_power_flag` | **Backup Power Flag** | `BOOLEAN` | `NOT NULL` | Backup power flag |
| `sla_breached_flag` | **Sla Breached Flag** | `BOOLEAN` | `NOT NULL` | SLA breached flag |
| `region_code` | **Region Code** | `VARCHAR(15)` | `NOT NULL` | Region code |
| `weather_condition` | **Weather Condition** | `VARCHAR(30)` | `NOT NULL` | Weather text |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_smart_meter`
**Description**: Domain table for `dim_smart_meter` in `Energy_Smart_Grid_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `meter_key` | **Meter Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_meter_id` | **Source Meter Id** | `INT` | `NOT NULL` | Natural ID |
| `substation_key` | **Substation Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_substation |

---

---

### Table: `dim_substation`
**Description**: Domain table for `dim_substation` in `Energy_Smart_Grid_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `substation_key` | **Substation Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_substation_id` | **Source Substation Id** | `INT` | `NOT NULL` | Natural ID |
| `grid_code` | **Grid Code** | `VARCHAR(20)` | `NOT NULL` | Grid code |

---

---

### Table: `fact_grid_consumption`
**Description**: Domain table for `fact_grid_consumption` in `Energy_Smart_Grid_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `consumption_key` | **Consumption Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `meter_key` | **Meter Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_smart_meter |
| `kwh_consumption` | **Kwh Consumption** | `NUMERIC(10,3)` | `NOT NULL` | kWh |

---

---

### Table: `dim_device`
**Description**: Domain table for `dim_device` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `device_key` | **Device Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_device_id` | **Source Device Id** | `INT` | `NOT NULL` | Natural ID |
| `model_name` | **Model Name** | `VARCHAR(50)` | `NOT NULL` | Model name |

---

---

### Table: `dim_user`
**Description**: Domain table for `dim_user` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `user_key` | **User Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_user_id` | **Source User Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_telemetry_reads`
**Description**: Domain table for `fact_telemetry_reads` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `telemetry_key` | **Telemetry Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `device_key` | **Device Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_device |
| `bpm_value` | **Bpm Value** | `INT` | `NOT NULL` | BPM |

---

---

### Table: `fact_workout_summary`
**Description**: Domain table for `fact_workout_summary` in `Fitness_Wearable_IoT_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `workout_key` | **Workout Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `user_key` | **User Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_user |
| `calories_burned` | **Calories Burned** | `INT` | `NOT NULL` | Calories burned |

---

---

### Table: `dim_categories`
**Description**: Domain table for `dim_categories` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_cat_key` | **Dim Cat Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_category_id` | **Source Category Id** | `INT` | `NOT NULL` | Natural source ID |
| `category_name` | **Category Name** | `VARCHAR(50)` | `NOT NULL` | Category name |
| `parent_category_name` | **Parent Category Name** | `VARCHAR(50)` | `NULL` | Parent category name |

---

---

### Table: `dim_customer_addresses`
**Description**: Domain table for `dim_customer_addresses` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_addr_key` | **Dim Addr Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `address_type` | **Address Type** | `VARCHAR(20)` | `NOT NULL` | Address classification |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `state_province` | **State Province** | `VARCHAR(50)` | `NOT NULL` | State/Province |
| `country_code_iso2` | **Country Code Iso2** | `VARCHAR(2)` | `NOT NULL` | Country code |

---

---

### Table: `dim_customers`
**Description**: Domain table for `dim_customers` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_cust_key` | **Dim Cust Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Natural source ID |
| `customer_code` | **Customer Code** | `VARCHAR(36)` | `NOT NULL` | Tracking code |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full customer name |
| `email_address` | **Email Address** | `VARCHAR(100)` | `NOT NULL` | Email contact |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NULL` | Phone number |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | Status code |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active indicator |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | DW record timestamp |

---

---

### Table: `dim_product_attributes`
**Description**: Domain table for `dim_product_attributes` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_attr_key` | **Dim Attr Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `attribute_name` | **Attribute Name** | `VARCHAR(50)` | `NOT NULL` | Attribute name |
| `attribute_value` | **Attribute Value** | `VARCHAR(50)` | `NOT NULL` | Attribute value |

---

---

### Table: `dim_products`
**Description**: Domain table for `dim_products` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_prod_key` | **Dim Prod Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_product_id` | **Source Product Id** | `INT` | `NOT NULL` | Natural source ID |
| `sku` | **Sku** | `VARCHAR(30)` | `NOT NULL` | Product SKU |
| `product_name` | **Product Name** | `VARCHAR(100)` | `NOT NULL` | Product title |
| `category_key` | **Category Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_categories |
| `supplier_key` | **Supplier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_suppliers |
| `unit_price_usd` | **Unit Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Standard unit price |

---

---

### Table: `dim_promotions`
**Description**: Domain table for `dim_promotions` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_promo_key` | **Dim Promo Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_promo_id` | **Source Promo Id** | `INT` | `NOT NULL` | Natural source ID |
| `promo_code` | **Promo Code** | `VARCHAR(20)` | `NOT NULL` | Promo code |
| `discount_percent` | **Discount Percent** | `NUMERIC(5,2)` | `NOT NULL` | Discount rate |

---

---

### Table: `dim_suppliers`
**Description**: Domain table for `dim_suppliers` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_supp_key` | **Dim Supp Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_supplier_id` | **Source Supplier Id** | `INT` | `NOT NULL` | Natural source ID |
| `company_name` | **Company Name** | `VARCHAR(100)` | `NOT NULL` | Supplier company name |
| `country_code_iso2` | **Country Code Iso2** | `VARCHAR(2)` | `NOT NULL` | ISO country code |

---

---

### Table: `dim_warehouses`
**Description**: Domain table for `dim_warehouses` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `dim_wh_key` | **Dim Wh Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_warehouse_id` | **Source Warehouse Id** | `INT` | `NOT NULL` | Natural source ID |
| `warehouse_code` | **Warehouse Code** | `VARCHAR(20)` | `NOT NULL` | Warehouse code |
| `warehouse_name` | **Warehouse Name** | `VARCHAR(80)` | `NOT NULL` | Warehouse name |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Facility city |

---

---

### Table: `fact_audit_events`
**Description**: Domain table for `fact_audit_events` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_audit_key` | **Fact Audit Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | User string |
| `action_name` | **Action Name** | `VARCHAR(50)` | `NOT NULL` | Action performed |
| `target_entity` | **Target Entity** | `VARCHAR(50)` | `NOT NULL` | Target entity |

---

---

### Table: `fact_inventory_snapshot`
**Description**: Domain table for `fact_inventory_snapshot` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_inv_key` | **Fact Inv Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouses |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Physical stock count |
| `reserved_quantity` | **Reserved Quantity** | `INT` | `NOT NULL` | Reserved stock count |

---

---

### Table: `fact_invoices`
**Description**: Domain table for `fact_invoices` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_invoice_key` | **Fact Invoice Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `invoice_number` | **Invoice Number** | `VARCHAR(30)` | `NOT NULL` | Invoice document number |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Billed total USD |

---

---

### Table: `fact_order_line_items`
**Description**: Domain table for `fact_order_line_items` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_item_key` | **Fact Item Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `unit_price_usd` | **Unit Price Usd** | `NUMERIC(10,2)` | `NOT NULL` | Sold price USD |
| `quantity` | **Quantity** | `INT` | `NOT NULL` | Unit count |
| `subtotal_usd` | **Subtotal Usd** | `NUMERIC(12,2)` | `NOT NULL` | Subtotal USD |

---