# Business Data Glossary - Dataset_01_Fintech_Banking_Wealth_Risk_60x50_target

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_01_Fintech_Banking_Wealth_Risk_60x50_target** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_01_Fintech_Banking_Wealth_Risk_60x50
- **Component**: Target Database Schema (Dataset_01_Fintech_Banking_Wealth_Risk_60x50_target)
- **Tier Specification**: Tier 2: 60 Source Tables, 50 Target Tables
- **Total Target Tables**: 50
- **Theme Focus**: Fintech, Corporate Banking, Wealth & Risk Management
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

### Table: `dim_accounts`
**Description**: Domain table for `dim_accounts` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `account_key` | **Account Key** | `BIGINT` | `PRIMARY KEY` | Account surrogate key |
| `source_account_id` | **Source Account Id** | `INT` | `NOT NULL` | Source natural account ID |
| `account_number` | **Account Number** | `VARCHAR(20)` | `NOT NULL` | Standardized account number |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `account_type_name` | **Account Type Name** | `VARCHAR(30)` | `NOT NULL` | Account category name |
| `currency_code` | **Currency Code** | `VARCHAR(3)` | `NOT NULL` | ISO currency code |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Account active flag |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | DW record creation timestamp |

---

---

### Table: `dim_branches`
**Description**: Domain table for `dim_branches` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `branch_key` | **Branch Key** | `BIGINT` | `PRIMARY KEY` | Branch surrogate key |
| `branch_code` | **Branch Code** | `VARCHAR(10)` | `NOT NULL` | Natural branch code |
| `branch_name` | **Branch Name** | `VARCHAR(60)` | `NOT NULL` | Branch designation name |
| `full_address` | **Full Address** | `VARCHAR(150)` | `NOT NULL` | Full street address |
| `city_name` | **City Name** | `VARCHAR(50)` | `NOT NULL` | City name |
| `state_province` | **State Province** | `VARCHAR(50)` | `NOT NULL` | State/province code |
| `postal_code` | **Postal Code** | `VARCHAR(10)` | `NOT NULL` | ZIP/Postal code |
| `manager_full_name` | **Manager Full Name** | `VARCHAR(60)` | `NOT NULL` | Branch manager full name |
| `is_operational` | **Is Operational** | `BOOLEAN` | `NOT NULL` | Operational boolean flag |

---

---

### Table: `dim_credit_cards`
**Description**: Domain table for `dim_credit_cards` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `card_key` | **Card Key** | `BIGINT` | `PRIMARY KEY` | Credit card surrogate key |
| `account_key` | **Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_accounts |
| `masked_card_number` | **Masked Card Number** | `VARCHAR(19)` | `NOT NULL` | Masked card number |
| `card_brand` | **Card Brand** | `VARCHAR(20)` | `NOT NULL` | Card brand network |
| `credit_limit_usd` | **Credit Limit Usd** | `NUMERIC(10,2)` | `NOT NULL` | Credit limit USD |
| `current_balance_usd` | **Current Balance Usd** | `NUMERIC(10,2)` | `NOT NULL` | Current balance USD |
| `expiry_date` | **Expiry Date** | `VARCHAR(7)` | `NOT NULL` | Card expiry MM/YYYY |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active status indicator |

---

---

### Table: `dim_customers`
**Description**: Domain table for `dim_customers` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `customer_key` | **Customer Key** | `BIGINT` | `PRIMARY KEY` | Customer surrogate key |
| `source_customer_id` | **Source Customer Id** | `INT` | `NOT NULL` | Source natural customer ID |
| `ssn_tax_id` | **Ssn Tax Id** | `VARCHAR(11)` | `NOT NULL` | Masked tax identifier |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full customer name |
| `primary_email` | **Primary Email** | `VARCHAR(100)` | `NOT NULL` | Standardized email address |
| `phone_number` | **Phone Number** | `VARCHAR(20)` | `NOT NULL` | Formatted contact phone |
| `kyc_status_name` | **Kyc Status Name** | `VARCHAR(20)` | `NOT NULL` | KYC compliance status |
| `risk_rating_code` | **Risk Rating Code** | `VARCHAR(10)` | `NOT NULL` | Risk tier classification |
| `is_current` | **Is Current** | `BOOLEAN` | `NOT NULL` | SCD Type 2 current record indicator |

---

---

### Table: `dim_portfolios`
**Description**: Domain table for `dim_portfolios` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `portfolio_key` | **Portfolio Key** | `BIGINT` | `PRIMARY KEY` | Portfolio surrogate key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `portfolio_name` | **Portfolio Name** | `VARCHAR(60)` | `NOT NULL` | Portfolio title name |
| `investment_strategy` | **Investment Strategy** | `VARCHAR(30)` | `NOT NULL` | Investment strategy category |
| `total_portfolio_val_usd` | **Total Portfolio Val Usd** | `NUMERIC(12,2)` | `NOT NULL` | Total portfolio value USD |
| `risk_profile` | **Risk Profile** | `VARCHAR(15)` | `NOT NULL` | Risk profile classification |
| `created_timestamp` | **Created Timestamp** | `TIMESTAMP` | `NOT NULL` | Creation ISO timestamp |
| `is_active` | **Is Active** | `BOOLEAN` | `NOT NULL` | Active boolean flag |

---

---

### Table: `fact_audit_events`
**Description**: Domain table for `fact_audit_events` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `event_key` | **Event Key** | `BIGINT` | `PRIMARY KEY` | Audit event surrogate key |
| `user_id` | **User Id** | `VARCHAR(40)` | `NOT NULL` | Operator user string |
| `action_category` | **Action Category** | `VARCHAR(30)` | `NOT NULL` | Action category name |
| `target_entity` | **Target Entity** | `VARCHAR(40)` | `NOT NULL` | Target domain entity |
| `entity_id` | **Entity Id** | `INT` | `NOT NULL` | Natural entity ID |
| `user_ip_address` | **User Ip Address** | `VARCHAR(45)` | `NOT NULL` | User IP address |
| `event_timestamp` | **Event Timestamp** | `TIMESTAMP` | `NOT NULL` | Event ISO timestamp |
| `event_result` | **Event Result** | `VARCHAR(15)` | `NOT NULL` | Event outcome result |

---

---

### Table: `fact_loan_payments`
**Description**: Domain table for `fact_loan_payments` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payment_key` | **Payment Key** | `BIGINT` | `PRIMARY KEY` | Loan payment surrogate key |
| `loan_key` | **Loan Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_loans |
| `payment_timestamp` | **Payment Timestamp** | `TIMESTAMP` | `NOT NULL` | Payment execution timestamp |
| `principal_amount_paid` | **Principal Amount Paid** | `NUMERIC(10,2)` | `NOT NULL` | Principal portion paid USD |
| `interest_amount_paid` | **Interest Amount Paid** | `NUMERIC(10,2)` | `NOT NULL` | Interest portion paid USD |
| `total_amount_paid` | **Total Amount Paid** | `NUMERIC(10,2)` | `NOT NULL` | Total amount paid USD |
| `payment_channel` | **Payment Channel** | `VARCHAR(20)` | `NOT NULL` | Payment method channel |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Payment status |

---

---

### Table: `fact_loans`
**Description**: Domain table for `fact_loans` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `loan_key` | **Loan Key** | `BIGINT` | `PRIMARY KEY` | Loan surrogate key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `loan_type_code` | **Loan Type Code** | `VARCHAR(20)` | `NOT NULL` | Loan category code |
| `principal_amount_usd` | **Principal Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Disbursed principal amount USD |
| `annual_interest_rate` | **Annual Interest Rate** | `NUMERIC(5,2)` | `NOT NULL` | Interest percentage rate |
| `term_months` | **Term Months** | `INT` | `NOT NULL` | Loan term duration in months |
| `start_date` | **Start Date** | `DATE` | `NOT NULL` | Loan start date |
| `remaining_balance_usd` | **Remaining Balance Usd** | `NUMERIC(12,2)` | `NOT NULL` | Current balance in USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Status code |

---

---

### Table: `fact_transactions`
**Description**: Domain table for `fact_transactions` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_key` | **Transaction Key** | `BIGINT` | `PRIMARY KEY` | Transaction surrogate key |
| `account_key` | **Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_accounts |
| `transaction_ref` | **Transaction Ref** | `VARCHAR(36)` | `NOT NULL` | Enterprise reference code |
| `txn_type` | **Txn Type** | `VARCHAR(20)` | `NOT NULL` | Transaction classification |
| `transaction_amount_usd` | **Transaction Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Transaction amount in USD |
| `transaction_timestamp` | **Transaction Timestamp** | `TIMESTAMP` | `NOT NULL` | Transaction ISO timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Standardized status code |
| `dim_date_key` | **Dim Date Key** | `INT` | `NOT NULL` | Date key YYYYMMDD |

---

---

### Table: `fact_wire_transfers`
**Description**: Domain table for `fact_wire_transfers` in `Finance_Banking_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transfer_key` | **Transfer Key** | `BIGINT` | `PRIMARY KEY` | Transfer surrogate key |
| `source_account_key` | **Source Account Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_accounts |
| `dest_account_number` | **Dest Account Number** | `VARCHAR(34)` | `NOT NULL` | Destination account IBAN |
| `swift_bic_code` | **Swift Bic Code** | `VARCHAR(11)` | `NOT NULL` | Destination SWIFT code |
| `transfer_amount_usd` | **Transfer Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Transfer amount USD |
| `transfer_fee_usd` | **Transfer Fee Usd** | `NUMERIC(8,2)` | `NOT NULL` | Transfer fee USD |
| `transfer_timestamp` | **Transfer Timestamp** | `TIMESTAMP` | `NOT NULL` | Transfer execution timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Status code |

---

---

### Table: `dim_client`
**Description**: Domain table for `dim_client` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `client_key` | **Client Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_client_id` | **Source Client Id** | `INT` | `NOT NULL` | Natural ID |
| `client_name` | **Client Name** | `VARCHAR(100)` | `NOT NULL` | Client name |

---

---

### Table: `dim_security`
**Description**: Domain table for `dim_security` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `security_key` | **Security Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_security_id` | **Source Security Id** | `INT` | `NOT NULL` | Natural ID |
| `ticker_symbol` | **Ticker Symbol** | `VARCHAR(10)` | `NOT NULL` | Ticker |

---

---

### Table: `fact_asset_transactions`
**Description**: Domain table for `fact_asset_transactions` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_key` | **Transaction Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `client_key` | **Client Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_client |
| `security_key` | **Security Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_security |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Amount USD |

---

---

### Table: `fact_portfolio_holdings`
**Description**: Domain table for `fact_portfolio_holdings` in `Asset_Management_Wealth_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `holding_key` | **Holding Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `client_key` | **Client Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_client |
| `security_key` | **Security Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_security |
| `shares_count` | **Shares Count** | `NUMERIC(12,4)` | `NOT NULL` | Shares count |

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

### Table: `dim_adjuster`
**Description**: Domain table for `dim_adjuster` in `Insurance_Claims_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `adjuster_key` | **Adjuster Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_adjuster_id` | **Source Adjuster Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `dim_policy`
**Description**: Domain table for `dim_policy` in `Insurance_Claims_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `policy_key` | **Policy Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_policy_id` | **Source Policy Id** | `INT` | `NOT NULL` | Natural ID |
| `policyholder_key` | **Policyholder Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_policyholder |
| `policy_type` | **Policy Type** | `VARCHAR(20)` | `NOT NULL` | Policy type |

---

---

### Table: `dim_policyholder`
**Description**: Domain table for `dim_policyholder` in `Insurance_Claims_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `policyholder_key` | **Policyholder Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `source_policyholder_id` | **Source Policyholder Id** | `INT` | `NOT NULL` | Natural ID |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `fact_claim_payouts`
**Description**: Domain table for `fact_claim_payouts` in `Insurance_Claims_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payout_key` | **Payout Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `claim_key` | **Claim Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_claim_submissions |
| `payout_amount_usd` | **Payout Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Payout amount USD |

---

---

### Table: `fact_claim_submissions`
**Description**: Domain table for `fact_claim_submissions` in `Insurance_Claims_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_key` | **Claim Key** | `BIGINT` | `PRIMARY KEY` | Surrogate key |
| `policy_key` | **Policy Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_policy |
| `adjuster_key` | **Adjuster Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_adjuster |
| `claimed_amount_usd` | **Claimed Amount Usd** | `NUMERIC(10,2)` | `NOT NULL` | Claimed amount USD |

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

### Table: `dim_customers_ecommerce_ecommerce`
**Description**: Domain table for `dim_customers_ecommerce` in `Ecommerce_Dataset` (target).

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

### Table: `fact_audit_events_ecommerce_ecommerce`
**Description**: Domain table for `fact_audit_events_ecommerce` in `Ecommerce_Dataset` (target).

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

---

### Table: `fact_orders`
**Description**: Domain table for `fact_orders` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `source_order_id` | **Source Order Id** | `INT` | `NOT NULL` | Natural source ID |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `order_number` | **Order Number** | `VARCHAR(36)` | `NOT NULL` | Order number |
| `order_date` | **Order Date** | `TIMESTAMP` | `NOT NULL` | Order date |
| `order_status` | **Order Status** | `VARCHAR(20)` | `NOT NULL` | Order status |
| `total_amount_usd` | **Total Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Gross order total USD |

---

---

### Table: `fact_payments`
**Description**: Domain table for `fact_payments` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_payment_key` | **Fact Payment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `payment_method` | **Payment Method** | `VARCHAR(20)` | `NOT NULL` | Method name |
| `amount_usd` | **Amount Usd** | `NUMERIC(12,2)` | `NOT NULL` | Payment amount USD |

---

---

### Table: `fact_product_reviews`
**Description**: Domain table for `fact_product_reviews` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_review_key` | **Fact Review Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `rating_score` | **Rating Score** | `INT` | `NOT NULL` | Rating score 1-5 |

---

---

### Table: `fact_return_requests`
**Description**: Domain table for `fact_return_requests` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_return_key` | **Fact Return Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `return_status` | **Return Status** | `VARCHAR(20)` | `NOT NULL` | Return status |

---

---

### Table: `fact_shipments`
**Description**: Domain table for `fact_shipments` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_shipment_key` | **Fact Shipment Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `carrier_name` | **Carrier Name** | `VARCHAR(30)` | `NOT NULL` | Carrier name |
| `tracking_number` | **Tracking Number** | `VARCHAR(40)` | `NOT NULL` | Tracking code |
| `shipment_status` | **Shipment Status** | `VARCHAR(20)` | `NOT NULL` | Shipment status |

---

---

### Table: `fact_shopping_carts`
**Description**: Domain table for `fact_shopping_carts` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_cart_key` | **Fact Cart Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |

---

---

### Table: `fact_support_tickets`
**Description**: Domain table for `fact_support_tickets` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_ticket_key` | **Fact Ticket Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `fact_order_key` | **Fact Order Key** | `BIGINT` | `FOREIGN KEY` | FK to fact_orders |
| `ticket_status` | **Ticket Status** | `VARCHAR(20)` | `NOT NULL` | Ticket status |

---

---

### Table: `fact_wishlists`
**Description**: Domain table for `fact_wishlists` in `Ecommerce_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `fact_wishlist_key` | **Fact Wishlist Key** | `BIGINT` | `PRIMARY KEY` | Surrogate primary key |
| `customer_key` | **Customer Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_customers |
| `product_key` | **Product Key** | `BIGINT` | `FOREIGN KEY` | FK to dim_products |

---

---

### Table: `fhir_account_billing`
**Description**: Domain table for `fhir_account_billing` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `billing_account_key` | **Billing Account Key** | `BIGINT` | `PRIMARY KEY` | Billing account surrogate key |
| `source_billing_id` | **Source Billing Id** | `INT` | `NOT NULL` | Source natural billing ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `encounter_key` | **Encounter Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_encounter |
| `total_gross_charge_usd` | **Total Gross Charge Usd** | `NUMERIC(10,2)` | `NOT NULL` | Gross medical charge USD |
| `amount_paid_usd` | **Amount Paid Usd** | `NUMERIC(10,2)` | `NOT NULL` | Settled amount USD |
| `balance_usd` | **Balance Usd** | `NUMERIC(10,2)` | `NOT NULL` | Balance due USD |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Account status |

---

---

### Table: `fhir_appointment`
**Description**: Domain table for `fhir_appointment` in `Healthcare_Hospital_Dataset` (target).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `appointment_key` | **Appointment Key** | `BIGINT` | `PRIMARY KEY` | Appointment surrogate key |
| `source_appointment_id` | **Source Appointment Id** | `INT` | `NOT NULL` | Source natural appointment ID |
| `patient_key` | **Patient Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_patient |
| `practitioner_key` | **Practitioner Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_practitioner |
| `dept_key` | **Dept Key** | `BIGINT` | `FOREIGN KEY` | FK to fhir_organization_dept |
| `start_timestamp` | **Start Timestamp** | `TIMESTAMP` | `NOT NULL` | Scheduled start timestamp |
| `status_code` | **Status Code** | `VARCHAR(15)` | `NOT NULL` | Appointment status |

---