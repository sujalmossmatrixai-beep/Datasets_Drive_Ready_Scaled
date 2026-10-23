# Business Data Glossary - Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30
- **Component**: Source Database Schema (Dataset_09_GlobalTrade_CryptoFintech_LogisticsRisk_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Cross-Border Trade, Crypto Finance, AML Compliance & Global Logistics
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `tbl_cargo_containers`
**Description**: Domain table for `tbl_cargo_containers` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `container_id` | **Container Id** | `INT` | `PRIMARY KEY` | Container primary key ID |
| `container_number` | **Container Number** | `VARCHAR(20)` | `NOT NULL` | ISO container serial number |
| `container_type` | **Container Type** | `VARCHAR(30)` | `NOT NULL` | DRY_40FT, REEFER_40FT, OPEN_TOP, TANK |
| `length_feet` | **Length Feet** | `INT` | `NOT NULL` | Container length 20ft or 40ft |
| `max_payload_kg` | **Max Payload Kg** | `DECIMAL(10,2)` | `NOT NULL` | Maximum payload capacity kg |
| `tare_weight_kg` | **Tare Weight Kg** | `DECIMAL(8,2)` | `NOT NULL` | Empty container weight kg |
| `manufacture_year` | **Manufacture Year** | `INT` | `NOT NULL` | Year of container build |
| `last_inspection_date` | **Last Inspection Date** | `DATE` | `NOT NULL` | Safety inspection date |
| `current_location_port` | **Current Location Port** | `VARCHAR(10)` | `NOT NULL` | Current port location |
| `is_refrigerated` | **Is Refrigerated** | `BOOLEAN` | `NOT NULL` | Reefer container flag |
| `seal_number` | **Seal Number** | `VARCHAR(20)` | `NOT NULL` | Security seal lock ID |
| `owner_shipping_line` | **Owner Shipping Line** | `VARCHAR(50)` | `NOT NULL` | Container owner shipping line |
| `lease_status` | **Lease Status** | `VARCHAR(20)` | `NOT NULL` | OWNED, LEASED_LONG, LEASED_SHORT |
| `maintenance_status` | **Maintenance Status** | `VARCHAR(20)` | `NOT NULL` | SERVICEABLE, REPAIR_NEEDED, SCRAPPED |
| `gps_tracker_id` | **Gps Tracker Id** | `VARCHAR(25)` | `NOT NULL` | IoT GPS tracker device ID |
| `door_type` | **Door Type** | `VARCHAR(30)` | `NOT NULL` | STANDARD_DOUBLE, ROLL_UP, SIDE_DOOR |
| `inspection_passed_flag` | **Inspection Passed Flag** | `BOOLEAN` | `NOT NULL` | Passed safety inspection |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Container maintenance comments |

---

---

### Table: `tbl_carrier_vessels`
**Description**: Domain table for `tbl_carrier_vessels` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `vessel_id` | **Vessel Id** | `INT` | `PRIMARY KEY` | Vessel primary key ID |
| `imo_number` | **Imo Number** | `VARCHAR(15)` | `NOT NULL` | IMO ship identification number |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Ship official name |
| `flag_state` | **Flag State** | `VARCHAR(3)` | `NOT NULL` | Flag country state registration |
| `vessel_type` | **Vessel Type** | `VARCHAR(30)` | `NOT NULL` | CONTAINER, BULK, TANKER, RO-RO |
| `build_year` | **Build Year** | `INT` | `NOT NULL` | Year ship was launched |
| `deadweight_tonnage` | **Deadweight Tonnage** | `INT` | `NOT NULL` | DWT cargo capacity metric tons |
| `teu_capacity` | **Teu Capacity** | `INT` | `NOT NULL` | Twenty-foot equivalent unit limit |
| `engine_power_kw` | **Engine Power Kw** | `INT` | `NOT NULL` | Main engine power kilowatts |
| `max_speed_knots` | **Max Speed Knots** | `DECIMAL(4,1)` | `NOT NULL` | Maximum nautical speed knots |
| `owner_company` | **Owner Company** | `VARCHAR(80)` | `NOT NULL` | Vessel owner shipping corporation |
| `operator_company` | **Operator Company** | `VARCHAR(80)` | `NOT NULL` | Vessel operating charter company |
| `call_sign` | **Call Sign** | `VARCHAR(10)` | `NOT NULL` | Radio station call sign |
| `mmsi_number` | **Mmsi Number** | `VARCHAR(15)` | `NOT NULL` | Maritime Mobile Service Identity |
| `last_drydock_date` | **Last Drydock Date** | `DATE` | `NOT NULL` | Last drydock maintenance date |
| `safety_certificate_expiry` | **Safety Certificate Expiry** | `DATE` | `NOT NULL` | SOLAS safety certificate expiry |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status` | **Status** | `VARCHAR(20)` | `NOT NULL` | IN_SERVICE, DRYDOCK, CHARTERED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Vessel operational inspection notes |

---

---

### Table: `tbl_customs_declarations`
**Description**: Domain table for `tbl_customs_declarations` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `declaration_id` | **Declaration Id** | `INT` | `PRIMARY KEY` | Customs declaration primary key ID |
| `shipment_id` | **Shipment Id** | `INT` | `FOREIGN KEY` | FK to tbl_freight_shipments |
| `declaration_number` | **Declaration Number** | `VARCHAR(25)` | `NOT NULL` | Customs entry declaration number |
| `customs_office_code` | **Customs Office Code** | `VARCHAR(10)` | `NOT NULL` | Customs office port code |
| `entry_date` | **Entry Date** | `DATE` | `NOT NULL` | Customs declaration entry date |
| `importer_record_id` | **Importer Record Id** | `INT` | `NOT NULL` | Importer tax ID record |
| `exporter_record_id` | **Exporter Record Id** | `INT` | `NOT NULL` | Exporter tax ID record |
| `hs_tariff_code` | **Hs Tariff Code** | `VARCHAR(12)` | `NOT NULL` | Harmonized System tariff code |
| `duty_amount_usd` | **Duty Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Assessed customs duty USD |
| `tax_amount_usd` | **Tax Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Assessed import VAT/tax USD |
| `inspection_status` | **Inspection Status** | `VARCHAR(30)` | `NOT NULL` | PASSED, PHYSICAL_EXAM, DOCUMENT_CHECK |
| `clearance_date` | **Clearance Date** | `DATE` | `NOT NULL` | Customs release clearance date |
| `country_of_origin` | **Country Of Origin** | `VARCHAR(3)` | `NOT NULL` | ISO-3 country of origin code |
| `country_of_destination` | **Country Of Destination** | `VARCHAR(3)` | `NOT NULL` | ISO-3 destination country code |
| `exemption_code` | **Exemption Code** | `VARCHAR(15)` | `NOT NULL` | Duty exemption code or NONE |
| `customs_broker_id` | **Customs Broker Id** | `INT` | `NOT NULL` | Broker license ID |
| `risk_score` | **Risk Score** | `INT` | `NOT NULL` | Customs automated risk score 1-100 |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | RELEASED, HELD, REJECTED |

---

---

### Table: `tbl_freight_shipments`
**Description**: Domain table for `tbl_freight_shipments` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `shipment_id` | **Shipment Id** | `INT` | `PRIMARY KEY` | Freight shipment primary key ID |
| `tracking_number` | **Tracking Number** | `VARCHAR(25)` | `NOT NULL` | Global tracking waybill number |
| `shipper_id` | **Shipper Id** | `INT` | `NOT NULL` | Shipper company record ID |
| `consignee_id` | **Consignee Id** | `INT` | `NOT NULL` | Consignee recipient ID |
| `origin_port_code` | **Origin Port Code** | `VARCHAR(10)` | `NOT NULL` | Origin port UN/LOCODE |
| `destination_port_code` | **Destination Port Code** | `VARCHAR(10)` | `NOT NULL` | Destination port UN/LOCODE |
| `carrier_id` | **Carrier Id** | `INT` | `FOREIGN KEY` | FK to tbl_carrier_vessels |
| `vessel_name` | **Vessel Name** | `VARCHAR(60)` | `NOT NULL` | Container ship vessel name |
| `voyage_number` | **Voyage Number** | `VARCHAR(15)` | `NOT NULL` | Voyage manifest code |
| `container_number` | **Container Number** | `VARCHAR(20)` | `NOT NULL` | Standard 40ft container code |
| `declared_value_usd` | **Declared Value Usd** | `DECIMAL(12,2)` | `NOT NULL` | Declared customs cargo value |
| `freight_cost_usd` | **Freight Cost Usd** | `DECIMAL(10,2)` | `NOT NULL` | Freight shipping charge USD |
| `gross_weight_kg` | **Gross Weight Kg** | `DECIMAL(10,2)` | `NOT NULL` | Gross shipment weight kg |
| `net_weight_kg` | **Net Weight Kg** | `DECIMAL(10,2)` | `NOT NULL` | Net cargo weight kg |
| `volume_cubic_meters` | **Volume Cubic Meters** | `DECIMAL(8,2)` | `NOT NULL` | Cargo volume CBM |
| `shipment_status` | **Shipment Status** | `VARCHAR(30)` | `NOT NULL` | BOOKED, IN_TRANSIT, CUSTOMS, DELIVERED |
| `departure_date` | **Departure Date** | `DATE` | `NOT NULL` | Port departure date |
| `estimated_arrival_date` | **Estimated Arrival Date** | `DATE` | `NOT NULL` | Estimated arrival date |
| `actual_arrival_date` | **Actual Arrival Date** | `DATE` | `NOT NULL` | Actual arrival date |
| `customs_clearance_flag` | **Customs Clearance Flag** | `BOOLEAN` | `NOT NULL` | Customs cleared indicator |
| `hazardous_material_flag` | **Hazardous Material Flag** | `BOOLEAN` | `NOT NULL` | Hazmat cargo classification flag |
| `temperature_control_c` | **Temperature Control C** | `DECIMAL(4,1)` | `NOT NULL` | Reefer temperature setting C |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |

---

---

### Table: `tbl_port_terminals`
**Description**: Domain table for `tbl_port_terminals` in `Global_Logistics_Shipping_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `port_id` | **Port Id** | `INT` | `PRIMARY KEY` | Port primary key ID |
| `port_code` | **Port Code** | `VARCHAR(10)` | `NOT NULL` | UN/LOCODE port identifier |
| `port_name` | **Port Name** | `VARCHAR(80)` | `NOT NULL` | Official sea port terminal name |
| `country_code` | **Country Code** | `VARCHAR(3)` | `NOT NULL` | Country code ISO-3 |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | Port city location |
| `latitude` | **Latitude** | `DECIMAL(8,4)` | `NOT NULL` | Port GPS latitude coordinate |
| `longitude` | **Longitude** | `DECIMAL(8,4)` | `NOT NULL` | Port GPS longitude coordinate |
| `berth_capacity` | **Berth Capacity** | `INT` | `NOT NULL` | Total vessel berth capacity |
| `annual_teu_capacity` | **Annual Teu Capacity** | `INT` | `NOT NULL` | Annual TEU handling capacity |
| `terminal_operator` | **Terminal Operator** | `VARCHAR(80)` | `NOT NULL` | Terminal operating company |
| `depth_meters` | **Depth Meters** | `DECIMAL(4,1)` | `NOT NULL` | Water depth draft in meters |
| `is_deepwater_port` | **Is Deepwater Port** | `BOOLEAN` | `NOT NULL` | Deepwater port flag |
| `customs_office_present` | **Customs Office Present** | `BOOLEAN` | `NOT NULL` | On-site customs office flag |
| `contact_phone` | **Contact Phone** | `VARCHAR(20)` | `NOT NULL` | Port authority telephone |
| `contact_email` | **Contact Email** | `VARCHAR(100)` | `NOT NULL` | Port operations email |
| `operating_hours` | **Operating Hours** | `VARCHAR(30)` | `NOT NULL` | 24/7 or scheduled hours |
| `security_level_code` | **Security Level Code** | `VARCHAR(15)` | `NOT NULL` | ISPS Code Security Level |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `active_flag` | **Active Flag** | `BOOLEAN` | `NOT NULL` | Active operational status |

---

---

### Table: `tbl_blockchain_deposits`
**Description**: Domain table for `tbl_blockchain_deposits` in `Cryptocurrency_Exchange_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `deposit_id` | **Deposit Id** | `INT` | `PRIMARY KEY` | Deposit primary key ID |
| `wallet_id` | **Wallet Id** | `INT` | `FOREIGN KEY` | FK to tbl_user_wallets |
| `tx_hash` | **Tx Hash** | `VARCHAR(66)` | `NOT NULL` | Tx hash |
| `amount` | **Amount** | `DECIMAL(18,8)` | `NOT NULL` | Deposited amount |

---

---

### Table: `tbl_completed_trades`
**Description**: Domain table for `tbl_completed_trades` in `Cryptocurrency_Exchange_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `trade_id` | **Trade Id** | `INT` | `PRIMARY KEY` | Trade primary key ID |
| `order_id` | **Order Id** | `INT` | `FOREIGN KEY` | FK to tbl_limit_orders |
| `trade_price_usd` | **Trade Price Usd** | `DECIMAL(12,2)` | `NOT NULL` | Executed trade price |
| `trade_volume` | **Trade Volume** | `DECIMAL(18,8)` | `NOT NULL` | Volume |
| `trade_time` | **Trade Time** | `TIMESTAMP` | `NOT NULL` | Timestamp |

---

---

### Table: `tbl_crypto_assets`
**Description**: Domain table for `tbl_crypto_assets` in `Cryptocurrency_Exchange_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `asset_id` | **Asset Id** | `INT` | `PRIMARY KEY` | Asset primary key ID |
| `ticker_symbol` | **Ticker Symbol** | `VARCHAR(10)` | `NOT NULL` | BTC/ETH/SOL |
| `asset_name` | **Asset Name** | `VARCHAR(50)` | `NOT NULL` | Full token name |

---

---

### Table: `tbl_limit_orders`
**Description**: Domain table for `tbl_limit_orders` in `Cryptocurrency_Exchange_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `order_id` | **Order Id** | `INT` | `PRIMARY KEY` | Order primary key ID |
| `asset_id` | **Asset Id** | `INT` | `FOREIGN KEY` | FK to tbl_crypto_assets |
| `side` | **Side** | `VARCHAR(4)` | `NOT NULL` | BUY/SELL |
| `limit_price_usd` | **Limit Price Usd** | `DECIMAL(12,2)` | `NOT NULL` | Limit price |
| `order_quantity` | **Order Quantity** | `DECIMAL(18,8)` | `NOT NULL` | Quantity |

---

---

### Table: `tbl_user_wallets`
**Description**: Domain table for `tbl_user_wallets` in `Cryptocurrency_Exchange_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `wallet_id` | **Wallet Id** | `INT` | `PRIMARY KEY` | Wallet primary key ID |
| `asset_id` | **Asset Id** | `INT` | `FOREIGN KEY` | FK to tbl_crypto_assets |
| `wallet_address` | **Wallet Address** | `VARCHAR(64)` | `NOT NULL` | On-chain address string |
| `available_balance` | **Available Balance** | `DECIMAL(18,8)` | `NOT NULL` | Token balance |

---

---

### Table: `tbl_aml_suspicious_reports`
**Description**: Domain table for `tbl_aml_suspicious_reports` in `Banking_Fraud_Risk_Compliance_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `sar_report_id` | **Sar Report Id** | `INT` | `PRIMARY KEY` | SAR report primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customer_risk_profiles |
| `filing_date` | **Filing Date** | `DATE` | `NOT NULL` | Official regulatory filing date |
| `reporting_officer_id` | **Reporting Officer Id** | `INT` | `NOT NULL` | AML compliance officer ID |
| `suspicious_activity_code` | **Suspicious Activity Code** | `VARCHAR(25)` | `NOT NULL` | FinCEN suspicious activity code |
| `total_suspicious_amount_usd` | **Total Suspicious Amount Usd** | `DECIMAL(12,2)` | `NOT NULL` | Total aggregate suspicious USD |
| `fincen_control_number` | **Fincen Control Number** | `VARCHAR(25)` | `NOT NULL` | FinCEN regulatory tracking number |
| `narrative_summary` | **Narrative Summary** | `VARCHAR(250)` | `NOT NULL` | Summary narrative of suspicious activity |
| `investigation_start_date` | **Investigation Start Date** | `DATE` | `NOT NULL` | Investigation start date |
| `investigation_end_date` | **Investigation End Date** | `DATE` | `NOT NULL` | Investigation closure date |
| `law_enforcement_contacted_flag` | **Law Enforcement Contacted Flag** | `BOOLEAN` | `NOT NULL` | FBI/Law enforcement notified flag |
| `account_frozen_flag` | **Account Frozen Flag** | `BOOLEAN` | `NOT NULL` | Account restriction/freeze flag |
| `regulatory_body_code` | **Regulatory Body Code** | `VARCHAR(15)` | `NOT NULL` | FINCEN, FCA, MAS, FINMA |
| `jurisdiction_code` | **Jurisdiction Code** | `VARCHAR(10)` | `NOT NULL` | Jurisdiction legal code |
| `case_file_path` | **Case File Path** | `VARCHAR(100)` | `NOT NULL` | Encrypted evidence dossier file path |
| `approval_status` | **Approval Status** | `VARCHAR(20)` | `NOT NULL` | APPROVED, PENDING_SIGNATURE, FILED |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | FILED, DRAFT, CLOSED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Compliance officer sign-off notes |

---

---

### Table: `tbl_customer_risk_profiles`
**Description**: Domain table for `tbl_customer_risk_profiles` in `Banking_Fraud_Risk_Compliance_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_id` | **Customer Id** | `INT` | `PRIMARY KEY` | Customer primary key ID |
| `customer_number` | **Customer Number** | `VARCHAR(20)` | `NOT NULL` | Unique customer master ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Customer full legal name |
| `date_of_birth` | **Date Of Birth** | `DATE` | `NOT NULL` | Customer birth date |
| `national_id_ssn` | **National Id Ssn** | `VARCHAR(20)` | `NOT NULL` | Encrypted SSN or national tax ID |
| `is_pep_flag` | **Is Pep Flag** | `BOOLEAN` | `NOT NULL` | Politically Exposed Person flag |
| `sanctions_check_status` | **Sanctions Check Status** | `VARCHAR(25)` | `NOT NULL` | CLEARED, MATCH_FOUND, PENDING |
| `kyc_verification_status` | **Kyc Verification Status** | `VARCHAR(25)` | `NOT NULL` | VERIFIED, EXPIRED, INCOMPLETE |
| `kyc_last_updated_date` | **Kyc Last Updated Date** | `DATE` | `NOT NULL` | Date of last KYC refresh |
| `risk_rating_category` | **Risk Rating Category** | `VARCHAR(15)` | `NOT NULL` | LOW, MEDIUM, HIGH, CRITICAL |
| `credit_score` | **Credit Score** | `INT` | `NOT NULL` | FICO credit score 300-850 |
| `annual_income_usd` | **Annual Income Usd** | `DECIMAL(12,2)` | `NOT NULL` | Verified annual income USD |
| `employment_status` | **Employment Status** | `VARCHAR(30)` | `NOT NULL` | EMPLOYED, SELF_EMPLOYED, RETIRED |
| `occupation_title` | **Occupation Title** | `VARCHAR(50)` | `NOT NULL` | Job title or business domain |
| `residence_country` | **Residence Country** | `VARCHAR(3)` | `NOT NULL` | Country of residence ISO-3 |
| `tax_residence_country` | **Tax Residence Country** | `VARCHAR(3)` | `NOT NULL` | FATCA tax jurisdiction code |
| `account_count` | **Account Count** | `INT` | `NOT NULL` | Total active bank accounts owned |
| `total_balance_usd` | **Total Balance Usd** | `DECIMAL(14,2)` | `NOT NULL` | Aggregate balance across accounts |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | ACTIVE, FROZEN, CLOSED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Compliance audit comments |

---

---

### Table: `tbl_financial_transactions`
**Description**: Domain table for `tbl_financial_transactions` in `Banking_Fraud_Risk_Compliance_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_id` | **Transaction Id** | `INT` | `PRIMARY KEY` | Transaction primary key ID |
| `transaction_reference` | **Transaction Reference** | `VARCHAR(30)` | `NOT NULL` | SWIFT/ISO20022 transaction reference |
| `sender_account_id` | **Sender Account Id** | `INT` | `NOT NULL` | Sender account ID |
| `receiver_account_id` | **Receiver Account Id** | `INT` | `NOT NULL` | Receiver account ID |
| `transaction_amount_usd` | **Transaction Amount Usd** | `DECIMAL(12,2)` | `NOT NULL` | Transaction principal amount USD |
| `transaction_timestamp` | **Transaction Timestamp** | `TIMESTAMP` | `NOT NULL` | Transaction execution time |
| `transaction_type` | **Transaction Type** | `VARCHAR(30)` | `NOT NULL` | WIRE_TRANSFER, ACH, CARD_PAYMENT, ATM |
| `channel_type` | **Channel Type** | `VARCHAR(20)` | `NOT NULL` | ONLINE_BANKING, MOBILE_APP, BRANCH, POS |
| `merchant_category_code` | **Merchant Category Code** | `VARCHAR(10)` | `NOT NULL` | MCC code identifier |
| `location_city` | **Location City** | `VARCHAR(50)` | `NOT NULL` | Transaction city location |
| `location_country` | **Location Country** | `VARCHAR(3)` | `NOT NULL` | ISO-3 country code |
| `ip_address` | **Ip Address** | `VARCHAR(45)` | `NOT NULL` | Client IP address |
| `device_fingerprint` | **Device Fingerprint** | `VARCHAR(40)` | `NOT NULL` | Browser / device unique hash |
| `is_cross_border` | **Is Cross Border** | `BOOLEAN` | `NOT NULL` | International transfer flag |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | Transaction ISO currency code |
| `exchange_rate` | **Exchange Rate** | `DECIMAL(8,4)` | `NOT NULL` | Applied currency exchange rate |
| `fee_amount_usd` | **Fee Amount Usd** | `DECIMAL(8,2)` | `NOT NULL` | Transaction service fee USD |
| `risk_score_numeric` | **Risk Score Numeric** | `INT` | `NOT NULL` | Real-time AI fraud risk score 1-100 |
| `fraud_flag` | **Fraud Flag** | `BOOLEAN` | `NOT NULL` | Confirmed fraud indicator flag |
| `aml_flagged_status` | **Aml Flagged Status** | `VARCHAR(25)` | `NOT NULL` | PASSED, SUSPICIOUS, BLOCKED |
| `authorization_code` | **Authorization Code** | `VARCHAR(15)` | `NOT NULL` | Payment gateway authorization ID |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Risk engine processing notes |

---

---

### Table: `tbl_fraud_detection_alerts`
**Description**: Domain table for `tbl_fraud_detection_alerts` in `Banking_Fraud_Risk_Compliance_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `alert_id` | **Alert Id** | `INT` | `PRIMARY KEY` | Alert primary key ID |
| `transaction_id` | **Transaction Id** | `INT` | `FOREIGN KEY` | FK to tbl_financial_transactions |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customer_risk_profiles |
| `alert_timestamp` | **Alert Timestamp** | `TIMESTAMP` | `NOT NULL` | Fraud rule trigger timestamp |
| `rule_triggered_id` | **Rule Triggered Id** | `VARCHAR(20)` | `NOT NULL` | Rule catalog code |
| `rule_name` | **Rule Name** | `VARCHAR(80)` | `NOT NULL` | Rule description title |
| `severity_level` | **Severity Level** | `VARCHAR(15)` | `NOT NULL` | CRITICAL, HIGH, MEDIUM, LOW |
| `alert_score` | **Alert Score** | `INT` | `NOT NULL` | Anomaly risk score 1-100 |
| `investigator_user_id` | **Investigator User Id** | `INT` | `NOT NULL` | Assigned AML investigator ID |
| `investigation_status` | **Investigation Status** | `VARCHAR(25)` | `NOT NULL` | OPEN, UNDER_REVIEW, CLOSED, ESCALATED |
| `resolution_outcome` | **Resolution Outcome** | `VARCHAR(40)` | `NOT NULL` | FALSE_POSITIVE, CONFIRMED_FRAUD, SAR_FILED |
| `resolution_timestamp` | **Resolution Timestamp** | `TIMESTAMP` | `NOT NULL` | Alert resolution timestamp |
| `is_false_positive` | **Is False Positive** | `BOOLEAN` | `NOT NULL` | False positive determination flag |
| `reported_to_authorities_flag` | **Reported To Authorities Flag** | `BOOLEAN` | `NOT NULL` | FinCEN / FIU report flag |
| `loss_amount_usd` | **Loss Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Confirmed financial loss USD |
| `recovered_amount_usd` | **Recovered Amount Usd** | `DECIMAL(10,2)` | `NOT NULL` | Recovered funds USD |
| `comments` | **Comments** | `VARCHAR(200)` | `NOT NULL` | Investigator notes and rationale |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | NEW, ASSIGNED, COMPLETED |

---

---

### Table: `tbl_sanction_watchlist_matches`
**Description**: Domain table for `tbl_sanction_watchlist_matches` in `Banking_Fraud_Risk_Compliance_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `match_id` | **Match Id** | `INT` | `PRIMARY KEY` | Match record primary key ID |
| `customer_id` | **Customer Id** | `INT` | `FOREIGN KEY` | FK to tbl_customer_risk_profiles |
| `watchlist_name` | **Watchlist Name** | `VARCHAR(50)` | `NOT NULL` | OFAC, UN, EU, INTERPOL, PEP |
| `matched_name` | **Matched Name** | `VARCHAR(100)` | `NOT NULL` | Name on government sanction list |
| `match_score_pct` | **Match Score Pct** | `DECIMAL(5,2)` | `NOT NULL` | Fuzzy logic match confidence % |
| `sanction_entity_id` | **Sanction Entity Id** | `VARCHAR(20)` | `NOT NULL` | Global sanction entity code |
| `sanction_authority` | **Sanction Authority** | `VARCHAR(30)` | `NOT NULL` | US_TREASURY, UN, EU_COMMISSION |
| `match_timestamp` | **Match Timestamp** | `TIMESTAMP` | `NOT NULL` | Automated screening match time |
| `analyst_review_status` | **Analyst Review Status** | `VARCHAR(25)` | `NOT NULL` | UNDER_REVIEW, CLEARED, CONFIRMED |
| `review_decision` | **Review Decision** | `VARCHAR(30)` | `NOT NULL` | FALSE_POSITIVE, BLOCK_TRANSACTION |
| `analyst_id` | **Analyst Id** | `INT` | `NOT NULL` | Assigned sanction analyst ID |
| `clearance_reason` | **Clearance Reason** | `VARCHAR(150)` | `NOT NULL` | Reason for clearing or blocking match |
| `entity_type` | **Entity Type** | `VARCHAR(20)` | `NOT NULL` | INDIVIDUAL, VESSEL, CORPORATION |
| `country_listed` | **Country Listed** | `VARCHAR(3)` | `NOT NULL` | Listed entity country ISO-3 |
| `passport_match_flag` | **Passport Match Flag** | `BOOLEAN` | `NOT NULL` | Passport number exact match flag |
| `dob_match_flag` | **Dob Match Flag** | `BOOLEAN` | `NOT NULL` | Date of birth match flag |
| `created_at` | **Created At** | `TIMESTAMP` | `NOT NULL` | Record creation timestamp |
| `updated_at` | **Updated At** | `TIMESTAMP` | `NOT NULL` | Record update timestamp |
| `status_code` | **Status Code** | `VARCHAR(20)` | `NOT NULL` | RESOLVED, PENDING, BLOCKED |
| `notes` | **Notes** | `VARCHAR(150)` | `NOT NULL` | Screening system audit trail |

---

---

### Table: `tbl_carrier_fleet`
**Description**: Domain table for `tbl_carrier_fleet` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `carrier_id` | **Carrier Id** | `INT` | `PRIMARY KEY` | Carrier primary key ID |
| `carrier_name` | **Carrier Name** | `VARCHAR(80)` | `NOT NULL` | Logistics provider name |
| `transport_mode` | **Transport Mode** | `VARCHAR(20)` | `NOT NULL` | TRUCK/RAIL/OCEAN/AIR |
| `fleet_size` | **Fleet Size** | `INT` | `NOT NULL` | Active vehicle count |

---

---

### Table: `tbl_customs_clearance`
**Description**: Domain table for `tbl_customs_clearance` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customs_id` | **Customs Id** | `INT` | `PRIMARY KEY` | Customs primary key ID |
| `shipment_id` | **Shipment Id** | `INT` | `FOREIGN KEY` | FK to tbl_shipment_manifests |
| `declaration_number` | **Declaration Number** | `VARCHAR(40)` | `NOT NULL` | Customs declaration ref |
| `duty_amount` | **Duty Amount** | `DECIMAL(10,2)` | `NOT NULL` | Import duty paid |
| `clearance_status` | **Clearance Status** | `VARCHAR(20)` | `NOT NULL` | CLEARED/HELD/INSPECTED |

---

---

### Table: `tbl_freight_bills`
**Description**: Domain table for `tbl_freight_bills` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `bill_id` | **Bill Id** | `INT` | `PRIMARY KEY` | Bill primary key ID |
| `shipment_id` | **Shipment Id** | `INT` | `FOREIGN KEY` | FK to tbl_shipment_manifests |
| `freight_charge` | **Freight Charge** | `DECIMAL(10,2)` | `NOT NULL` | Freight charge |
| `fuel_surcharge` | **Fuel Surcharge** | `DECIMAL(10,2)` | `NOT NULL` | Fuel surcharge |
| `payment_status` | **Payment Status** | `VARCHAR(15)` | `NOT NULL` | UNPAID/PAID/OVERDUE |

---

---

### Table: `tbl_inventory_lots`
**Description**: Domain table for `tbl_inventory_lots` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `lot_id` | **Lot Id** | `INT` | `PRIMARY KEY` | Lot primary key ID |
| `warehouse_id` | **Warehouse Id** | `INT` | `FOREIGN KEY` | FK to tbl_warehouses |
| `sku_code` | **Sku Code** | `VARCHAR(30)` | `NOT NULL` | Material SKU |
| `quantity_on_hand` | **Quantity On Hand** | `INT` | `NOT NULL` | Stock count |
| `expiry_date` | **Expiry Date** | `DATE` | `NULL` | Expiration date if applicable |

---

---

### Table: `tbl_po_items`
**Description**: Domain table for `tbl_po_items` in `Supply_Chain_Logistics_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `po_item_id` | **Po Item Id** | `INT` | `PRIMARY KEY` | PO line item primary key ID |
| `po_id` | **Po Id** | `INT` | `FOREIGN KEY` | FK to tbl_purchase_orders |
| `sku_code` | **Sku Code** | `VARCHAR(30)` | `NOT NULL` | Material SKU code |
| `ordered_qty` | **Ordered Qty** | `INT` | `NOT NULL` | Ordered quantity |
| `unit_price` | **Unit Price** | `DECIMAL(10,2)` | `NOT NULL` | Unit price |

---