# Business Data Glossary - Dataset_01_Fintech_Banking_Wealth_Risk_80x100_source

This glossary documents the business term definitions, column data dictionary, and attribute constraints for the **Dataset_01_Fintech_Banking_Wealth_Risk_80x100_source** schema.

## Summary Overview

- **Dataset Identifier**: Dataset_01_Fintech_Banking_Wealth_Risk_80x100
- **Component**: Source Database Schema (Dataset_01_Fintech_Banking_Wealth_Risk_80x100_source)
- **Tier Specification**: Tier 3: 80 Source Tables, 100 Target Tables
- **Total Source Tables**: 80
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

### Table: `tbl_adjusters`
**Description**: Domain table for `tbl_adjusters` in `Insurance_Claims_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `adjuster_id` | **Adjuster Id** | `INT` | `PRIMARY KEY` | Adjuster primary key ID |
| `license_code` | **License Code** | `VARCHAR(20)` | `NOT NULL` | Claims adjuster license |
| `full_name` | **Full Name** | `VARCHAR(100)` | `NOT NULL` | Full name |

---

---

### Table: `tbl_claim_evidence`
**Description**: Domain table for `tbl_claim_evidence` in `Insurance_Claims_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `evidence_id` | **Evidence Id** | `INT` | `PRIMARY KEY` | Evidence primary key ID |
| `claim_id` | **Claim Id** | `INT` | `FOREIGN KEY` | FK to tbl_claims |
| `file_type` | **File Type** | `VARCHAR(20)` | `NOT NULL` | PHOTO/POLICE_REPORT/ESTIMATE |
| `file_url` | **File Url** | `VARCHAR(255)` | `NOT NULL` | Cloud document link |

---

---

### Table: `tbl_claim_payouts`
**Description**: Domain table for `tbl_claim_payouts` in `Insurance_Claims_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `payout_id` | **Payout Id** | `INT` | `PRIMARY KEY` | Payout primary key ID |
| `claim_id` | **Claim Id** | `INT` | `FOREIGN KEY` | FK to tbl_claims |
| `payout_amount` | **Payout Amount** | `DECIMAL(10,2)` | `NOT NULL` | Settled payout amount |
| `payout_date` | **Payout Date** | `DATE` | `NOT NULL` | Disbursement date |

---

---

### Table: `tbl_claims`
**Description**: Domain table for `tbl_claims` in `Insurance_Claims_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `claim_id` | **Claim Id** | `INT` | `PRIMARY KEY` | Claim primary key ID |
| `policy_id` | **Policy Id** | `INT` | `FOREIGN KEY` | FK to tbl_insurance_policies |
| `adjuster_id` | **Adjuster Id** | `INT` | `FOREIGN KEY` | FK to tbl_adjusters |
| `claim_number` | **Claim Number** | `VARCHAR(30)` | `NOT NULL` | Unique claim identifier |
| `incident_date` | **Incident Date** | `DATE` | `NOT NULL` | Date of loss |
| `claimed_amount` | **Claimed Amount** | `DECIMAL(10,2)` | `NOT NULL` | Claimed dollar amount |
| `claim_status` | **Claim Status** | `VARCHAR(20)` | `NOT NULL` | SUBMITTED/UNDER_REVIEW/APPROVED/DENIED |

---

---

### Table: `tbl_insurance_policies`
**Description**: Domain table for `tbl_insurance_policies` in `Insurance_Claims_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `policy_id` | **Policy Id** | `INT` | `PRIMARY KEY` | Policy primary key ID |
| `policyholder_id` | **Policyholder Id** | `INT` | `FOREIGN KEY` | FK to tbl_policyholders |
| `policy_number` | **Policy Number** | `VARCHAR(30)` | `NOT NULL` | Policy document number |
| `policy_type` | **Policy Type** | `VARCHAR(20)` | `NOT NULL` | AUTO/HOME/HEALTH/LIFE |
| `coverage_limit` | **Coverage Limit** | `DECIMAL(12,2)` | `NOT NULL` | Maximum policy coverage |
| `deductible` | **Deductible** | `DECIMAL(10,2)` | `NOT NULL` | Policy deductible amount |

---

---

### Table: `tbl_policyholders`
**Description**: Domain table for `tbl_policyholders` in `Insurance_Claims_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `policyholder_id` | **Policyholder Id** | `INT` | `PRIMARY KEY` | Policyholder primary key ID |
| `ssn_tax_id` | **Ssn Tax Id** | `VARCHAR(11)` | `NOT NULL` | Social security or tax ID |
| `first_name` | **First Name** | `VARCHAR(50)` | `NOT NULL` | First name |
| `last_name` | **Last Name** | `VARCHAR(50)` | `NOT NULL` | Last name |
| `city` | **City** | `VARCHAR(50)` | `NOT NULL` | City |

---

---

### Table: `tbl_underwriting_rules`
**Description**: Domain table for `tbl_underwriting_rules` in `Insurance_Claims_Dataset` (source).

| Column Name | Business Term | Data Type | Constraint | Business Definition / Description |
| :--- | :--- | :--- | :--- | :--- |
| `rule_id` | **Rule Id** | `INT` | `PRIMARY KEY` | Rule primary key ID |
| `rule_code` | **Rule Code** | `VARCHAR(20)` | `NOT NULL` | Rule code |
| `risk_tier` | **Risk Tier** | `VARCHAR(15)` | `NOT NULL` | LOW/MODERATE/HIGH |

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

### Table: `tbl_customers_ecommerce_ecommerce`
**Description**: Domain table for `tbl_customers_ecommerce` in `Ecommerce_Dataset` (source).

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