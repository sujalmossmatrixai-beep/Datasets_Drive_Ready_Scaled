# Business Data Glossary - Dataset_01_Fintech_Banking_Wealth_Risk_20x30_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_01_Fintech_Banking_Wealth_Risk_20x30_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_01_Fintech_Banking_Wealth_Risk_20x30
- **Component**: Source Database Schema (Dataset_01_Fintech_Banking_Wealth_Risk_20x30_source)
- **Tier Specification**: Tier 1: 20 Source Tables, 30 Target Tables
- **Total Source Tables**: 20
- **Theme Focus**: Fintech, Corporate Banking, Wealth & Risk Management
- **Target Engine**: ANSI SQL / PostgreSQL / MySQL / SQLite / Snowflake
- **Sample Rows per Table**: 25-200 sample rows per table CSV

---

## Detailed Table & Column Dictionary

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

### Table: `tbl_customers`
**Description**: Domain table for `tbl_customers` in `Finance_Banking_Dataset` (source).

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

### Table: `tbl_asset_transactions`
**Description**: Domain table for `tbl_asset_transactions` in `Asset_Management_Wealth_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `transaction_id` | **Transaction Id** | `INT` | `PRIMARY KEY` | Transaction primary key ID |
| `account_id` | **Account Id** | `INT` | `FOREIGN KEY` | FK to tbl_investment_accounts |
| `security_id` | **Security Id** | `INT` | `FOREIGN KEY` | FK to tbl_security_assets |
| `txn_type` | **Txn Type** | `VARCHAR(10)` | `NOT NULL` | BUY/SELL/DIVIDEND |
| `total_amount` | **Total Amount** | `DECIMAL(12,2)` | `NOT NULL` | Total dollar amount |

---

---

### Table: `tbl_clients`
**Description**: Domain table for `tbl_clients` in `Asset_Management_Wealth_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `client_id` | **Client Id** | `INT` | `PRIMARY KEY` | Client primary key ID |
| `tax_identifier` | **Tax Identifier** | `VARCHAR(11)` | `NOT NULL` | SSN or Tax ID |
| `client_name` | **Client Name** | `VARCHAR(100)` | `NOT NULL` | Wealth client name |

---

---

### Table: `tbl_investment_accounts`
**Description**: Domain table for `tbl_investment_accounts` in `Asset_Management_Wealth_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `account_id` | **Account Id** | `INT` | `PRIMARY KEY` | Account primary key ID |
| `client_id` | **Client Id** | `INT` | `FOREIGN KEY` | FK to tbl_clients |
| `account_type` | **Account Type** | `VARCHAR(30)` | `NOT NULL` | INDIVIDUAL_BROKERAGE/IRA/TRUST |

---

---

### Table: `tbl_portfolio_holdings`
**Description**: Domain table for `tbl_portfolio_holdings` in `Asset_Management_Wealth_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `holding_id` | **Holding Id** | `INT` | `PRIMARY KEY` | Holding primary key ID |
| `account_id` | **Account Id** | `INT` | `FOREIGN KEY` | FK to tbl_investment_accounts |
| `security_id` | **Security Id** | `INT` | `FOREIGN KEY` | FK to tbl_security_assets |
| `shares_count` | **Shares Count** | `DECIMAL(12,4)` | `NOT NULL` | Quantity of shares |

---

---

### Table: `tbl_security_assets`
**Description**: Domain table for `tbl_security_assets` in `Asset_Management_Wealth_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `security_id` | **Security Id** | `INT` | `PRIMARY KEY` | Security primary key ID |
| `ticker_symbol` | **Ticker Symbol** | `VARCHAR(10)` | `NOT NULL` | AAPL/MSFT/GOOGL |
| `security_name` | **Security Name** | `VARCHAR(100)` | `NOT NULL` | Asset name |

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