# Business Data Glossary - Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30
- **Component**: Target Database Schema (Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30_target)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Target Tables**: 30
- **Theme Focus**: Cross-Border Trade, Crypto Finance, AML Compliance & Global Logistics
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `dim_port`
**Description**: Domain table for `dim_port` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `port_key` | **Port Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for port dimension |
| `source_port_id` | **Source Port Id** | `INT` | `NOT NULL` | Natural port ID from source |
| `port_code` | **Port Code** | `VARCHAR(10)` | `NOT NULL` | UN/LOCODE port code |
| `port_name` | **Port Name** | `VARCHAR(80)` | `NOT NULL` | Port terminal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country code ISO-3 |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `terminal_operator` | **Terminal Operator** | `VARCHAR(80)` | `NOT NULL` | Operator name |
| `latitude` | **Latitude** | `NUMERIC(8,4)` | `NOT NULL` | Latitude |
| `longitude` | **Longitude** | `NUMERIC(8,4)` | `NOT NULL` | Longitude |
| `berth_capacity` | **Berth Capacity** | `INT` | `NOT NULL` | Berth count |
| `annual_teu_capacity` | **Annual Teu Capacity** | `INT` | `NOT NULL` | TEU capacity |
| `water_depth_meters` | **Water Depth Meters** | `NUMERIC(4,1)` | `NOT NULL` | Depth meters |
| `is_deepwater_flag` | **Is Deepwater Flag** | `BOOLEAN` | `NOT NULL` | Deepwater flag |
| `customs_office_flag` | **Customs Office Flag** | `BOOLEAN` | `NOT NULL` | Customs office flag |
| `operating_hours` | **Operating Hours** | `VARCHAR(30)` | `NOT NULL` | Operating schedule |
| `security_level` | **Security Level** | `VARCHAR(15)` | `NOT NULL` | Security level code |
| `contact_phone` | **Contact Phone** | `VARCHAR(20)` | `NOT NULL` | Contact phone |
| `contact_email` | **Contact Email** | `VARCHAR(100)` | `NOT NULL` | Contact email |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_shipment`
**Description**: Domain table for `dim_shipment` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_key` | **Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for shipment dimension |
| `source_shipment_id` | **Source Shipment Id** | `INT` | `NOT NULL` | Natural shipment ID from source |
| `tracking_number` | **Tracking Number** | `VARCHAR(25)` | `NOT NULL` | Tracking waybill number |
| `shipper_id` | **Shipper Id** | `INT` | `NOT NULL` | Shipper ID |
| `consignee_id` | **Consignee Id** | `INT` | `NOT NULL` | Consignee ID |
| `origin_port_code` | **Origin Port Code** | `VARCHAR(10)` | `NOT NULL` | Origin port code |
| `destination_port_code` | **Destination Port Code** | `VARCHAR(10)` | `NOT NULL` | Destination port code |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Vessel name |
| `container_number` | **Container Number** | `VARCHAR(20)` | `NOT NULL` | Container number |
| `shipment_status` | **Shipment Status** | `VARCHAR(30)` | `NOT NULL` | Shipment status text |
| `declared_value_usd` | **Declared Value Usd** | `NUMERIC(12,2)` | `NOT NULL` | Declared value USD |
| `freight_cost_usd` | **Freight Cost Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |
| `gross_weight_kg` | **Gross Weight Kg** | `NUMERIC(10,2)` | `NOT NULL` | Gross weight kg |
| `volume_cbm` | **Volume Cbm** | `NUMERIC(8,2)` | `NOT NULL` | Volume CBM |
| `customs_cleared_flag` | **Customs Cleared Flag** | `BOOLEAN` | `NOT NULL` | Customs cleared flag |
| `hazardous_flag` | **Hazardous Flag** | `BOOLEAN` | `NOT NULL` | Hazmat flag |
| `reefer_temp_c` | **Reefer Temp C** | `NUMERIC(4,1)` | `NOT NULL` | Reefer temp C |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Departure date |
| `estimated_arrival_date` | **Estimated Arrival Date** | `DATE` | `NOT NULL` | ETA date |
| `actual_arrival_date` | **Actual Arrival Date** | `DATE` | `NOT NULL` | ATA date |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current_record` | **Is Current Record** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_vessel`
**Description**: Domain table for `dim_vessel` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vessel_key` | **Vessel Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for vessel dimension |
| `source_vessel_id` | **Source Vessel Id** | `INT` | `NOT NULL` | Natural vessel ID from source |
| `imo_number` | **Imo Number** | `VARCHAR(15)` | `NOT NULL` | IMO ship number |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Vessel name |
| `flag_state` | **Flag State** | `VARCHAR(3)` | `NOT NULL` | Flag state ISO-3 |
| `vessel_type` | **Vessel Type** | `VARCHAR(30)` | `NOT NULL` | Vessel category |
| `build_year` | **Build Year** | `INT` | `NOT NULL` | Build year |
| `dwt_tonnage` | **Dwt Tonnage** | `INT` | `NOT NULL` | DWT tonnage |
| `teu_capacity` | **Teu Capacity** | `INT` | `NOT NULL` | TEU capacity |
| `engine_power_kw` | **Engine Power Kw** | `INT` | `NOT NULL` | Engine power kW |
| `max_speed_knots` | **Max Speed Knots** | `NUMERIC(4,1)` | `NOT NULL` | Max speed knots |
| `owner_company` | **Owner Company** | `VARCHAR(80)` | `NOT NULL` | Owner company |
| `operator_company` | **Operator Company** | `VARCHAR(80)` | `NOT NULL` | Operator company |
| `call_sign` | **Call Sign** | `VARCHAR(10)` | `NOT NULL` | Call sign |
| `mmsi_number` | **Mmsi Number** | `VARCHAR(15)` | `NOT NULL` | MMSI number |
| `safety_cert_expiry` | **Safety Cert Expiry** | `DATE` | `NOT NULL` | Cert expiry date |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Operational status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_customs_duties`
**Description**: Domain table for `fact_customs_duties` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_key` | **Customs Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for customs fact |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_shipment |
| `port_key` | **Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `entry_date` | **Entry Date** | `DATE` | `NOT NULL` | Customs entry date |
| `clearance_date` | **Clearance Date** | `DATE` | `NOT NULL` | Customs clearance date |
| `declared_cargo_value_usd` | **Declared Cargo Value Usd** | `NUMERIC(12,2)` | `NOT NULL` | Declared value USD |
| `assessed_duty_usd` | **Assessed Duty Usd** | `NUMERIC(10,2)` | `NOT NULL` | Customs duty USD |
| `import_vat_usd` | **Import Vat Usd** | `NUMERIC(10,2)` | `NOT NULL` | Import VAT USD |
| `excise_tax_usd` | **Excise Tax Usd** | `NUMERIC(8,2)` | `NOT NULL` | Excise tax USD |
| `total_duties_taxes_usd` | **Total Duties Taxes Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total tax & duties USD |
| `customs_risk_score` | **Customs Risk Score** | `INT` | `NOT NULL` | Automated risk score 1-100 |
| `inspection_required_flag` | **Inspection Required Flag** | `BOOLEAN` | `NOT NULL` | Physical inspection flag |
| `inspection_status` | **Inspection Status** | `VARCHAR(30)` | `NOT NULL` | Inspection status text |
| `exemption_claimed_flag` | **Exemption Claimed Flag** | `BOOLEAN` | `NOT NULL` | Duty exemption flag |
| `customs_status_code` | **Customs Status Code** | `VARCHAR(20)` | `NOT NULL` | Customs status |
| `clearance_days` | **Clearance Days** | `INT` | `NOT NULL` | Days to clear customs |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Customs processing comments |

---

---

### Table: `fact_freight_movements`
**Description**: Domain table for `fact_freight_movements` in `Global_Logistics_Shipping_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `movement_key` | **Movement Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for movement fact |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_shipment |
| `origin_port_key` | **Origin Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `dest_port_key` | **Dest Port Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_port |
| `vessel_key` | **Vessel Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_vessel |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Departure date key |
| `arrival_date` | **Arrival Date** | `DATE` | `NOT NULL` | Arrival date key |
| `transit_days` | **Transit Days** | `INT` | `NOT NULL` | Total transit duration days |
| `freight_cost_usd` | **Freight Cost Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |
| `insurance_cost_usd` | **Insurance Cost Usd** | `NUMERIC(8,2)` | `NOT NULL` | Cargo insurance cost USD |
| `bunker_surcharge_usd` | **Bunker Surcharge Usd** | `NUMERIC(8,2)` | `NOT NULL` | Fuel surcharge USD |
| `port_handling_fee_usd` | **Port Handling Fee Usd** | `NUMERIC(8,2)` | `NOT NULL` | Terminal handling charge USD |
| `total_transport_usd` | **Total Transport Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total transportation cost USD |
| `gross_weight_kg` | **Gross Weight Kg** | `NUMERIC(10,2)` | `NOT NULL` | Weight kg |
| `volume_cbm` | **Volume Cbm** | `NUMERIC(8,2)` | `NOT NULL` | Volume CBM |
| `on_time_delivery_flag` | **On Time Delivery Flag** | `BOOLEAN` | `NOT NULL` | On-time delivery performance flag |
| `delay_reason_code` | **Delay Reason Code** | `VARCHAR(30)` | `NOT NULL` | Delay reason code or NONE |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_asset`
**Description**: Domain table for `dim_asset` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `asset_key` | **Asset Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_asset_id` | **Source Asset Id** | `INT` | `NOT NULL` | Natural ID |
| `ticker_symbol` | **Ticker Symbol** | `VARCHAR(10)` | `NOT NULL` | Ticker |

---

---

### Table: `dim_wallet`
**Description**: Domain table for `dim_wallet` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `wallet_key` | **Wallet Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_wallet_id` | **Source Wallet Id** | `INT` | `NOT NULL` | Natural ID |
| `asset_key` | **Asset Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_asset |

---

---

### Table: `fact_deposits`
**Description**: Domain table for `fact_deposits` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `deposit_key` | **Deposit Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `wallet_key` | **Wallet Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_wallet |
| `amount` | **Amount** | `NUMERIC(18,8)` | `NOT NULL` | Amount |

---

---

### Table: `fact_executed_trades`
**Description**: Domain table for `fact_executed_trades` in `Cryptocurrency_Exchange_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trade_key` | **Trade Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `asset_key` | **Asset Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_asset |
| `trade_volume` | **Trade Volume** | `NUMERIC(18,8)` | `NOT NULL` | Volume |

---

---

### Table: `dim_account_compliance`
**Description**: Domain table for `dim_account_compliance` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `account_key` | **Account Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for account dimension |
| `source_account_id` | **Source Account Id** | `INT` | `NOT NULL` | Natural account ID from source |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `account_number` | **Account Number** | `VARCHAR(20)` | `NOT NULL` | Account number string |
| `account_type` | **Account Type** | `VARCHAR(30)` | `NOT NULL` | CHECKING, SAVINGS, CORPORATE, INVESTMENT |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | Currency ISO-3 |
| `opening_date` | **Opening Date** | `DATE` | `NOT NULL` | Account opening date |
| `current_balance_usd` | **Current Balance Usd** | `NUMERIC(14,2)` | `NOT NULL` | Balance USD |
| `overdraft_limit_usd` | **Overdraft Limit Usd** | `NUMERIC(10,2)` | `NOT NULL` | Overdraft limit USD |
| `account_status` | **Account Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE, FROZEN, DORMANT, CLOSED |
| `branch_code` | **Branch Code** | `VARCHAR(15)` | `NOT NULL` | Bank branch code |
| `is_high_risk_flag` | **Is High Risk Flag** | `BOOLEAN` | `NOT NULL` | High risk account flag |
| `aml_monitoring_status` | **Aml Monitoring Status** | `VARCHAR(20)` | `NOT NULL` | ACTIVE, ENHANCED, EXEMPT |
| `last_transaction_date` | **Last Transaction Date** | `DATE` | `NOT NULL` | Last active transaction date |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | Current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_customer_risk`
**Description**: Domain table for `dim_customer_risk` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_key` | **Customer Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for customer risk dimension |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Natural customer ID from source |
| `customer_number` | **Customer Number** | `VARCHAR(20)` | `NOT NULL` | Customer number |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full legal name |
| `date_of_birth` | **Date Of Birth** | `DATE` | `NOT NULL` | Birth date |
| `is_pep_flag` | **Is Pep Flag** | `BOOLEAN` | `NOT NULL` | PEP flag |
| `sanctions_status` | **Sanctions Status** | `VARCHAR(25)` | `NOT NULL` | Sanctions status text |
| `kyc_status` | **Kyc Status** | `VARCHAR(25)` | `NOT NULL` | KYC status text |
| `kyc_updated_date` | **Kyc Updated Date** | `DATE` | `NOT NULL` | KYC date |
| `risk_rating` | **Risk Rating** | `VARCHAR(15)` | `NOT NULL` | Risk category rating |
| `credit_score` | **Credit Score** | `INT` | `NOT NULL` | Credit score |
| `annual_income_usd` | **Annual Income Usd** | `NUMERIC(12,2)` | `NOT NULL` | Annual income USD |
| `employment_status` | **Employment Status** | `VARCHAR(30)` | `NOT NULL` | Employment status |
| `residence_country` | **Residence Country** | `VARCHAR(3)` | `NOT NULL` | Country ISO-3 |
| `tax_residence_country` | **Tax Residence Country** | `VARCHAR(3)` | `NOT NULL` | FATCA country |
| `active_account_count` | **Active Account Count** | `INT` | `NOT NULL` | Account count |
| `total_balance_usd` | **Total Balance Usd** | `NUMERIC(14,2)` | `NOT NULL` | Total balance USD |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | Customer status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `updated_timestamp` | **Updated Timestamp** | `TIMESTAMP` | `NOT NULL` | Update timestamp |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record flag |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_aml_reports`
**Description**: Domain table for `fact_aml_reports` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sar_fact_key` | **Sar Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for SAR fact |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `filing_date` | **Filing Date** | `DATE` | `NOT NULL` | Filing date key |
| `fincen_control_number` | **Fincen Control Number** | `VARCHAR(25)` | `NOT NULL` | Control number |
| `suspicious_activity_code` | **Suspicious Activity Code** | `VARCHAR(25)` | `NOT NULL` | Activity code |
| `suspicious_amount_usd` | **Suspicious Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Suspicious amount USD |
| `investigation_days` | **Investigation Days** | `INT` | `NOT NULL` | Days under investigation |
| `law_enforcement_flag` | **Law Enforcement Flag** | `BOOLEAN` | `NOT NULL` | Law enforcement notified flag |
| `account_frozen_flag` | **Account Frozen Flag** | `BOOLEAN` | `NOT NULL` | Account frozen flag |
| `regulatory_body_code` | **Regulatory Body Code** | `VARCHAR(15)` | `NOT NULL` | Regulatory body code |
| `jurisdiction_code` | **Jurisdiction Code** | `VARCHAR(10)` | `NOT NULL` | Jurisdiction code |
| `approval_status` | **Approval Status** | `VARCHAR(20)` | `NOT NULL` | Approval status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_financial_transactions`
**Description**: Domain table for `fact_financial_transactions` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_key` | **Transaction Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for transaction fact |
| `sender_customer_key` | **Sender Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `receiver_customer_key` | **Receiver Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `sender_account_key` | **Sender Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_account_compliance |
| `transaction_reference` | **Transaction Reference** | `VARCHAR(30)` | `NOT NULL` | Transaction reference code |
| `transaction_timestamp` | **Transaction Timestamp** | `TIMESTAMP` | `NOT NULL` | Timestamp key |
| `transaction_type` | **Transaction Type** | `VARCHAR(30)` | `NOT NULL` | Type text |
| `channel_type` | **Channel Type** | `VARCHAR(20)` | `NOT NULL` | Channel text |
| `principal_amount_usd` | **Principal Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Amount USD |
| `fee_amount_usd` | **Fee Amount Usd** | `NUMERIC(8,2)` | `NOT NULL` | Fee USD |
| `total_debit_usd` | **Total Debit Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total debited USD |
| `risk_score_numeric` | **Risk Score Numeric** | `INT` | `NOT NULL` | Risk score 1-100 |
| `fraud_flag` | **Fraud Flag** | `BOOLEAN` | `NOT NULL` | Confirmed fraud flag |
| `cross_border_flag` | **Cross Border Flag** | `BOOLEAN` | `NOT NULL` | Cross border flag |
| `location_country` | **Location Country** | `VARCHAR(3)` | `NOT NULL` | Country ISO-3 |
| `aml_status` | **Aml Status** | `VARCHAR(25)` | `NOT NULL` | AML status |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `fact_fraud_alerts`
**Description**: Domain table for `fact_fraud_alerts` in `Banking_Fraud_Risk_Compliance_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `alert_key` | **Alert Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key for alert fact |
| `transaction_key` | **Transaction Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_financial_transactions |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customer_risk |
| `alert_timestamp` | **Alert Timestamp** | `TIMESTAMP` | `NOT NULL` | Alert timestamp |
| `rule_code` | **Rule Code** | `VARCHAR(20)` | `NOT NULL` | Rule triggered code |
| `rule_name` | **Rule Name** | `VARCHAR(80)` | `NOT NULL` | Rule name text |
| `severity_level` | **Severity Level** | `VARCHAR(15)` | `NOT NULL` | Severity level |
| `anomaly_score` | **Anomaly Score** | `INT` | `NOT NULL` | Anomaly score 1-100 |
| `investigation_status` | **Investigation Status** | `VARCHAR(25)` | `NOT NULL` | Status text |
| `resolution_outcome` | **Resolution Outcome** | `VARCHAR(40)` | `NOT NULL` | Resolution text |
| `is_false_positive_flag` | **Is False Positive Flag** | `BOOLEAN` | `NOT NULL` | False positive flag |
| `sar_filed_flag` | **Sar Filed Flag** | `BOOLEAN` | `NOT NULL` | SAR filed flag |
| `confirmed_loss_usd` | **Confirmed Loss Usd** | `NUMERIC(10,2)` | `NOT NULL` | Loss USD |
| `recovered_funds_usd` | **Recovered Funds Usd** | `NUMERIC(10,2)` | `NOT NULL` | Recovered USD |
| `investigation_hours` | **Investigation Hours** | `NUMERIC(5,1)` | `NOT NULL` | Hours to resolve |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation timestamp |
| `etl_batch_id` | **Etl Batch Id** | `INT` | `NOT NULL` | ETL batch processing ID |

---

---

### Table: `dim_carrier`
**Description**: Domain table for `dim_carrier` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `carrier_key` | **Carrier Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_carrier_id` | **Source Carrier Id** | `INT` | `NOT NULL` | Source natural ID |
| `carrier_name` | **Carrier Name** | `VARCHAR(80)` | `NOT NULL` | Provider name |
| `transport_mode` | **Transport Mode** | `VARCHAR(20)` | `NOT NULL` | Transport mode |

---

---

### Table: `dim_supplier`
**Description**: Domain table for `dim_supplier` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `supplier_key` | **Supplier Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_supplier_id` | **Source Supplier Id** | `INT` | `NOT NULL` | Source natural ID |
| `supplier_name` | **Supplier Name** | `VARCHAR(100)` | `NOT NULL` | Vendor legal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | ISO country |

---

---

### Table: `dim_warehouse`
**Description**: Domain table for `dim_warehouse` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_warehouse_id` | **Source Warehouse Id** | `INT` | `NOT NULL` | Source natural ID |
| `facility_name` | **Facility Name** | `VARCHAR(80)` | `NOT NULL` | Facility name |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Location city |

---

---

### Table: `fact_customs_events`
**Description**: Domain table for `fact_customs_events` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_key` | **Customs Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_shipment |
| `duty_amount_usd` | **Duty Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Import duty USD |

---

---

### Table: `fact_freight_billing`
**Description**: Domain table for `fact_freight_billing` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `freight_bill_key` | **Freight Bill Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `shipment_key` | **Shipment Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_shipment |
| `freight_charge_usd` | **Freight Charge Usd** | `NUMERIC(10,2)` | `NOT NULL` | Freight cost USD |

---

---

### Table: `fact_inventory_snapshot`
**Description**: Domain table for `fact_inventory_snapshot` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `inventory_key` | **Inventory Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouse |
| `sku_code` | **Sku Code** | `VARCHAR(30)` | `NOT NULL` | Material SKU |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Stock count |

---

---

### Table: `fact_purchase_order`
**Description**: Domain table for `fact_purchase_order` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `po_fact_key` | **Po Fact Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `supplier_key` | **Supplier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_supplier |
| `warehouse_key` | **Warehouse Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_warehouse |
| `po_number` | **Po Number** | `VARCHAR(30)` | `NOT NULL` | Document number |
| `total_cost_usd` | **Total Cost Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total PO cost USD |

---

---

### Table: `fact_shipment`
**Description**: Domain table for `fact_shipment` in `Supply_Chain_Logistics_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_key` | **Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `po_fact_key` | **Po Fact Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_purchase_order |
| `carrier_key` | **Carrier Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_carrier |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Tracking ref |

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